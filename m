From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 8 Sep 2016 12:20:54 +0300
Subject: [LTP] [PATCH 6/6] memcg_control_test.sh: Simplify runtest file
In-Reply-To: <1473089055-17782-6-git-send-email-chrubis@suse.cz>
References: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
 <1473089055-17782-6-git-send-email-chrubis@suse.cz>
Message-ID: <57D12D76.10501@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

The entire series looks good, except that issue with the numbering
scheme in memcg_subgroup_charge.sh (patch V2 4/6)

On 09/05/2016 06:24 PM, Cyril Hrubis wrote:
> This commit makes use of $(getconf PAGESIZE) instead of the mem_process
> and also moves the parameters to the test itself as there is no need to
> keep these outside the script.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/controllers                                              | 2 +-
>  testcases/kernel/controllers/memcg/control/mem_process.c         | 3 ---
>  testcases/kernel/controllers/memcg/control/memcg_control_test.sh | 8 +++++---
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/runtest/controllers b/runtest/controllers
> index d14d81e..b904e05 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -13,7 +13,7 @@ memcg_stat	memcg_stat_test.sh
>  memcg_use_hierarchy	memcg_use_hierarchy_test.sh
>  memcg_usage_in_bytes	memcg_usage_in_bytes_test.sh
>  memcg_stress		memcg_stress_test.sh
> -memcg_control		PAGESIZE=$(mem_process -p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
> +memcg_control		memcg_control_test.sh
>  
>  cgroup_fj_function_debug cgroup_fj_function.sh debug
>  cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
> diff --git a/testcases/kernel/controllers/memcg/control/mem_process.c b/testcases/kernel/controllers/memcg/control/mem_process.c
> index 48cdea8..9007c2c 100644
> --- a/testcases/kernel/controllers/memcg/control/mem_process.c
> +++ b/testcases/kernel/controllers/memcg/control/mem_process.c
> @@ -60,9 +60,6 @@ void process_options(int argc, char **argv)
>  			if (*end != '\0')
>  				errx(2, "invalid -m usage");
>  			break;
> -		case 'p':
> -			printf("%d\n", getpagesize());
> -			exit(0);
>  		default:
>  			errx(2, "invalid option specifed");
>  		}
> diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> index 168efe3..1d15872 100644
> --- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> +++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> @@ -41,9 +41,11 @@ export TST_COUNT=0
>  export TMP=${TMP:-/tmp}
>  cd $TMP
>  
> -TOT_MEM_LIMIT=$1
> -ACTIVE_MEM_LIMIT=$2
> -PROC_MEM=$3
> +PAGE_SIZE=$(getconf PAGESIZE)
> +
> +TOT_MEM_LIMIT=$PAGE_SIZE
> +ACTIVE_MEM_LIMIT=$PAGE_SIZE
> +PROC_MEM=$((PAGE_SIZE * 2))
>  
>  TST_PATH=$PWD
>  STATUS_PIPE="$TMP/status_pipe"
> 
