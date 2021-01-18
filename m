From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 18 Jan 2021 16:16:09 +0800
Subject: [LTP] [PATCH v3 1/2] cpuset: skip test when cpu or nodes are
 not numbered continuously from 0
In-Reply-To: <1610590728-15813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <X/8ehCeZbWs6TIA4@yuki.lan>
 <1610590728-15813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <600543C9.9080708@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Cyril
ping.

Best Regards
Yang Xu
> These cpuset cases(cpuset_base_ops_test, cpuset_hierarchy_test, cpuset_inherit_test...)
> seem all not consider the situation(cpus/memory are not numbered continuously). It is
> continuously from 0 as default. Skip test if there are not numbered continuously to
> avoid unexpected error.
> 
> This patch also fix cpu_inherit error by using original mem value.
> 
> cpuset_inherit case fails on 4 numa nodes pc, as below:
> cpuset_inherit 1 TPASS: cpus: Inherited information is right!
> cpuset_inherit 3 TPASS: cpus: Inherited information is right!
> cpuset_inherit 5 TPASS: cpus: Inherited information is right!
> cpuset_inherit 7 TPASS: cpus: Inherited information is right!
> cpuset_inherit 9 TPASS: cpus: Inherited information is right!
> cpuset_inherit 11 TPASS: cpus: Inherited information is right!
> cpuset_inherit 13 TPASS: mems: Inherited information is right!
> cpuset_inherit 15 TPASS: mems: Inherited information is right!
> cpuset_inherit 17 TPASS: mems: Inherited information is right!
> cpuset_inherit 19 TPASS: mems: Inherited information is right!
> cpuset_inherit 21 TPASS: mems: Inherited information is right!
> cpuset_inherit 23 TFAIL: mems: Test result - 0-3 Expected string - "4"
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> ---
>   .../kernel/controllers/cpuset/cpuset_funcs.sh | 29 +++++++++++++++++--
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index f4365af2c..84b87d17e 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -26,23 +26,34 @@
> 
>   . test.sh
> 
> +cpu_string="`cat /sys/devices/system/cpu/online`"
>   NR_CPUS=`tst_ncpus`
> +
>   if [ -f "/sys/devices/system/node/has_high_memory" ]; then
> -	N_NODES="`cat /sys/devices/system/node/has_high_memory | tr ',' ' '`"
> +	mem_string="`cat /sys/devices/system/node/has_high_memory`"
>   else
> -	N_NODES="`cat /sys/devices/system/node/has_normal_memory | tr ',' ' '`"
> +	mem_string="`cat /sys/devices/system/node/has_normal_memory`"
>   fi
> +N_NODES="`echo $mem_string | tr ',' ' '`"
>   count=0
> +final_node=0
>   for item in $N_NODES; do
>   	delta=1
>   	if [ "${item#*-*}" != "$item" ]; then
>   		delta=$((${item#*-*} - ${item%*-*} + 1))
>   	fi
> +	final_node=${item#*-*}
>   	count=$((count + $delta))
>   done
> +final_node=$((final_node + 1))
>   N_NODES=$count
> 
> -mem_string="$N_NODES"
> +final_cpu=0
> +N_CPUS="`echo $cpu_string | tr ',' ' '`"
> +for item in $N_CPUS; do
> +	final_cpu=${item#*-*}
> +done
> +final_cpu=$((final_cpu + 1))
> 
>   CPUSET="/dev/cpuset"
>   CPUSET_TMP="/tmp/cpuset_tmp"
> @@ -78,6 +89,12 @@ ncpus_check()
>   	if [ $NR_CPUS -lt $1 ]; then
>   		tst_brkm TCONF "The total of CPUs is less than $1"
>   	fi
> +	# check online cpus whether match 0-num
> +	if [ $final_cpu -eq $NR_CPUS ]; then
> +		tst_resm TINFO "CPUs are numbered continuously starting at 0 ($cpu_string)"
> +	else
> +		tst_brkm TCONF "CPUs are not numbered continuously starting at 0 ($cpu_string)"
> +	fi
>   }
> 
>   nnodes_check()
> @@ -85,6 +102,12 @@ nnodes_check()
>   	if [ $N_NODES -lt $1 ]; then
>   		tst_brkm TCONF "The total of nodes is less than $1"
>   	fi
> +	# check online nodes whether match 0-num
> +	if [ $final_node -eq $N_NODES ]; then
> +		tst_resm TINFO "Nodes are numbered continuously starting at 0 ($mem_string)"
> +	else
> +		tst_brkm TCONF "Nodes are not numbered continuously starting at 0 ($mem_string)"
> +	fi
>   }
> 
>   user_check()



