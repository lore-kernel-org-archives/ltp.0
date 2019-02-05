From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue, 5 Feb 2019 17:46:25 +0000
Subject: [LTP] [PATCH v3] memcg_stress_test.sh: ported to newlib
In-Reply-To: <20190204233435.GA14637@dell5510>
References: <20190104105407.48123-1-cristian.marussi@arm.com>
 <20190104105407.48123-2-cristian.marussi@arm.com>
 <20190128163207.GA26834@dell5510> <20190129175019.GA14252@dell5510>
 <VI1PR08MB31815A4CF9A142A5B8A5E69F9E970@VI1PR08MB3181.eurprd08.prod.outlook.com>
 <20190201134537.GA17626@x230> <c328de8d-418f-d81e-910a-890e6639af6c@arm.com>
 <20190204233435.GA14637@dell5510>
Message-ID: <e8bd5a31-1cbb-47b3-63a3-56e7c9b402cb@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

On 04/02/2019 23:34, Petr Vorel wrote:
> Hi Cristian,
> 
>> Tested from you branch with ToT as:
> 
>> 10df48aa7 (HEAD -> pevik_ltp/christian/memcg_stress_test.sh.v3.fixes)
>> memcg_stress_test.sh: fix memory usage
>> ebd6efaa6 memcg_stress_test.sh: Further cleanup
>> 02c520928 memcg_stress_test.sh: ported to newlib
>> fc544f842 controllers/mem_process.c: Fix comparison warning
>> ...
> 
>> on 4k/64k pages defocnfig....looks fine to me.
> 
>> Thanks a lot for the cleanup.
> Thanks a lot for testing!
> Pushed (with your Tested-by on my commit).
> 
> I did few cleanup changes in my commit (TINFO messages, fix missing local pid, redirect
> stderr for wait to make it quiet, move TPASS message into run_stress()).
> 
> I wonder how to suppress kill message for the first cgroup pid:
> /opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 14750 User defined signal 1   memcg_process_stress $mem_size $interval
> 
> This pid is the only one killed by -USR1, but line 65 is not in fist kill loop.
> Therefore it cannot be killed by -KILL (second kill loop).
> 

? ... I saw no error messages in my testing :D

Regards

Cristian

