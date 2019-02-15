From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 15 Feb 2019 10:09:55 +0000
Subject: [LTP] [PATCH v3] memcg_stress_test.sh: ported to newlib
In-Reply-To: <5C6527B4.4060204@cn.fujitsu.com>
References: <20190104105407.48123-1-cristian.marussi@arm.com>
 <20190104105407.48123-2-cristian.marussi@arm.com>
 <20190128163207.GA26834@dell5510> <20190129175019.GA14252@dell5510>
 <VI1PR08MB31815A4CF9A142A5B8A5E69F9E970@VI1PR08MB3181.eurprd08.prod.outlook.com>
 <20190201134537.GA17626@x230> <c328de8d-418f-d81e-910a-890e6639af6c@arm.com>
 <20190204233435.GA14637@dell5510> <5C6527B4.4060204@cn.fujitsu.com>
Message-ID: <f88e3984-6f6b-52db-6774-5414db1e54c1@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao

On 14/02/2019 08:32, Xiao Yang wrote:
> On 2019/02/05 7:34, Petr Vorel wrote:
>> Hi Cristian,

> Hi Petr, Cristian
> 
> I also saw the same message occasionally when running memcg_stress_test, 
> as below:
> -----------------------------------------------------------------------
> ...
> /opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 11262 User defined 
> signal 1   memcg_process_stress $mem_size $interval
> /opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 11264 User defined 
> signal 1   memcg_process_stress $mem_size $interval
> /opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 11267 User defined 
> signal 1   memcg_process_stress $mem_size $interval
> ...
> -----------------------------------------------------------------------
> 
> It is possible for memcg_process_stress to be killed by SIGUSR1(default 
> action), because it may
> have received SIGUSR1 before completing the specified initialization of 
> SIGUSR1 signal action
> 
> Perpahs, we should sleep a few seconds to wait for the completion of 
> initializing SIGUSR1 signal action. :-)

Mmm...yes that's a possibility....but I was noticing that we spawn a lot of bg
processes in a loop before starting signaling all of them in the following loop
(i.e. after all the forks)...but I just realized than then we signal them
starting from the most recently spawned...not the oldest (in reverse
order)....so maybe it could be enough to start signalling from the oldest.

Signaling in the natural-born order...

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 5b19cc292..aa91f77b2 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -78,7 +78,7 @@ run_stress()
                mkdir /dev/memcg/$i 2> /dev/null
                memcg_process_stress $mem_size $interval &
                echo $! > /dev/memcg/$i/tasks
-               pids="$! $pids"
+               pids="$pids $!"
        done

        for pid in $pids; do


I understand that this approach is NO more deterministic than your sleeping
solution, anyway.
IMHO the only real deterministic solution would be to somehow explicitly "sync"
at the end of process-spawn loop, with the test script waiting for all the
spawned child to be ready....but it is maybe a bit overkill for the issue we face.
Maybe it is worth trying signaling in the correct order and then sleeping a bit
and see if it solves...I haven't seen this issue at all on my local setup on ARM.

Regards

Thanks

Cristian


> 
> Please see my patch for details:
> -----------------------------------------------------------------------
> diff --git 
> a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh 
> b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> index 5b19cc2..697a973 100755
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> @@ -81,6 +81,13 @@ run_stress()
>                  pids="$! $pids"
>          done
> 
> +       # If memcg_process_stress has received SIGUSR1 before completing the
> +       # specified initialization of SIGUSR1 signal action, 
> memcg_process_stress
> +       # will be killed by SIGUSR1(i.e. default action).  So we should 
> wait for
> +       # the completion of initializing SIGUSR1 signal action by 
> sleeping a few
> +       # seconds.
> +       sleep 2
> +
>          for pid in $pids; do
>                  kill -USR1 $pid 2> /dev/null
>          done
> -----------------------------------------------------------------------
> 
> Best Regards,
> Xiao Yang
> 
>> This pid is the only one killed by -USR1, but line 65 is not in fist kill loop.
>> Therefore it cannot be killed by -KILL (second kill loop).
>>
>> Kind regards,
>> Petr
>>
>>
> 
> 
> 

