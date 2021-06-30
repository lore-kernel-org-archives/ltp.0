From: Samuel Zou <zou_wei@huawei.com>
Date: Wed, 30 Jun 2021 10:07:47 +0800
Subject: [LTP] [PATCH] cpuset/cpuset_memory_pressure_test: Check whether
 the swap partition is configured
In-Reply-To: <1617707717-63693-1-git-send-email-zou_wei@huawei.com>
References: <1617707717-63693-1-git-send-email-zou_wei@huawei.com>
Message-ID: <411076e8-3734-a56a-bdcb-841a904aea5d@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ping, and has anybody met the same issue?

On 2021/4/6 19:15, Zou Wei wrote:
> --------------------------
> 
> 1. Fixed a bug where a null value is obtained because swap is not in
>     the fourth line of the free result
> free -m
>          total        used        free      shared  buff/cache   available
> Mem:   128135        3857      120633         158        3644      123219
> Swap:    8191          82        8109
> 
> free -m
>          total       used       free     shared    buffers     cached
> Mem:   419694       9464     410230        234        435       6005
> -/+ buffers/cache:       3022     416671
> Swap:    2053          0       2053
> 
> 2. If no swap partition is configured in the test environment,
>     the testcase will be failed:
> 
> cpuset_memory_pressure 7 TFAIL: sub group's memory_pressure
> didn't have memory pressure rate.
> cpuset_memory_pressure 9 TFAIL: root group's memory_pressure
> didn't have memory pressure rate.
> cpuset_memory_pressure 11 TFAIL: root group's memory_pressure
> didn't have memory pressure rate.
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   .../cpuset_memory_pressure_testset.sh                        | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
> index eddd7f6..2a2d2a1 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
> @@ -35,8 +35,16 @@ exit_status=0
>   # usable physical memory
>   py_mem=$(free -m | awk '{if(NR==2) print $4 + $6 + $7}')
>   
> -# free swap space
> -sw_mem=$(free -m | awk '{if(NR==4) print $4}')
> +# total swap space
> +sw_mem=$(free -m | awk '{if(NR==4) print $2}')
> +if [ -z $sw_mem ]; then
> +	sw_mem=$(free -m | awk '{if(NR==3) print $2}')
> +fi
> +
> +if [ $sw_mem -eq 0 ]; then
> +	tst_resm TCONF "The size of the swap partition is zero."
> +	exit 32
> +fi
>   
>   # the memory which is going to be used
>   usemem=$((py_mem - 20))
> 
