From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 Feb 2019 16:32:52 +0800
Subject: [LTP] [PATCH v3] memcg_stress_test.sh: ported to newlib
In-Reply-To: <20190204233435.GA14637@dell5510>
References: <20190104105407.48123-1-cristian.marussi@arm.com>
 <20190104105407.48123-2-cristian.marussi@arm.com>
 <20190128163207.GA26834@dell5510> <20190129175019.GA14252@dell5510>
 <VI1PR08MB31815A4CF9A142A5B8A5E69F9E970@VI1PR08MB3181.eurprd08.prod.outlook.com>
 <20190201134537.GA17626@x230> <c328de8d-418f-d81e-910a-890e6639af6c@arm.com>
 <20190204233435.GA14637@dell5510>
Message-ID: <5C6527B4.4060204@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/02/05 7:34, Petr Vorel wrote:
> Hi Cristian,
>
>> Tested from you branch with ToT as:
>> 10df48aa7 (HEAD ->  pevik_ltp/christian/memcg_stress_test.sh.v3.fixes)
>> memcg_stress_test.sh: fix memory usage
>> ebd6efaa6 memcg_stress_test.sh: Further cleanup
>> 02c520928 memcg_stress_test.sh: ported to newlib
>> fc544f842 controllers/mem_process.c: Fix comparison warning
>> ...
>> on 4k/64k pages defocnfig....looks fine to me.
>> Thanks a lot for the cleanup.
> Thanks a lot for testing!
> Pushed (with your Tested-by on my commit).
>
> I did few cleanup changes in my commit (TINFO messages, fix missing local pid, redirect
> stderr for wait to make it quiet, move TPASS message into run_stress()).
>
> I wonder how to suppress kill message for the first cgroup pid:
> /opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 14750 User defined signal 1   memcg_process_stress $mem_size $interval

Hi Petr, Cristian

I also saw the same message occasionally when running memcg_stress_test, 
as below:
-----------------------------------------------------------------------
...
/opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 11262 User defined 
signal 1   memcg_process_stress $mem_size $interval
/opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 11264 User defined 
signal 1   memcg_process_stress $mem_size $interval
/opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 11267 User defined 
signal 1   memcg_process_stress $mem_size $interval
...
-----------------------------------------------------------------------

It is possible for memcg_process_stress to be killed by SIGUSR1(default 
action), because it may
have received SIGUSR1 before completing the specified initialization of 
SIGUSR1 signal action.

Perpahs, we should sleep a few seconds to wait for the completion of 
initializing SIGUSR1 signal action. :-)

Please see my patch for details:
-----------------------------------------------------------------------
diff --git 
a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh 
b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 5b19cc2..697a973 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -81,6 +81,13 @@ run_stress()
                 pids="$! $pids"
         done

+       # If memcg_process_stress has received SIGUSR1 before completing the
+       # specified initialization of SIGUSR1 signal action, 
memcg_process_stress
+       # will be killed by SIGUSR1(i.e. default action).  So we should 
wait for
+       # the completion of initializing SIGUSR1 signal action by 
sleeping a few
+       # seconds.
+       sleep 2
+
         for pid in $pids; do
                 kill -USR1 $pid 2> /dev/null
         done
-----------------------------------------------------------------------

Best Regards,
Xiao Yang

> This pid is the only one killed by -USR1, but line 65 is not in fist kill loop.
> Therefore it cannot be killed by -KILL (second kill loop).
>
> Kind regards,
> Petr
>
>



