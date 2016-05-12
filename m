From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 May 2016 15:42:18 +0200
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160512134217.GB32457@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Given that, (CommitLimit - Committed_AS) with overcommit_memory == 1,
> looks to be a suitable formula, since the kernel lets allocate this
> amount of memory and there will be some memory for other tasks.

I wonder what the original purpose of the test is, it looks to me like
the whole point is to attach processes to number of memory cgroups and
then stress it by allocating memory while forcing heavy swapping. Hence
the $mem_free + $swap_free/2 which is wrong obviously.

So for the new formula the CommitLimit seems to be calculated as
SWAP + RAM * overcommit_ratio which will default to SWAP + RAM/2 in most
of the cases. Wouldn't that cause too much swap trashing in case that you
have SWAP == 2 * RAM? Shouldn't be something simple as 0.8 * RAM better
for the purpose of the test? Or something as 0.9 * mem_free - 50MB after
caches has been dropped?

Also I wonder if it makes sense to run the test if machine has no swap
configured. Maybe we should TCONF right away in that case.

> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  .../controllers/memcg/stress/memcg_stress_test.sh  |   28 ++++++++++++++++---
>  1 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> index 0d541e5..75baab4 100755
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> @@ -39,6 +39,8 @@ children=""
>  nr_children=0
>  memcg_path=/dev/memcg
>  memcg_created=0
> +overcommit_path=/proc/sys/vm/overcommit_memory
> +overcommit=""
>  
>  cleanup()
>  {
> @@ -54,6 +56,10 @@ cleanup()
>  		umount "$memcg_path"
>  		rmdir "$memcg_path"
>  	fi
> +
> +	if is_int "$overcommit"; then
> +		echo "$overcommit" > "$overcommit_path"
> +	fi
>  }
>  TST_CLEANUP=cleanup
>  
> @@ -139,20 +145,32 @@ testcase_2()
>  ROD echo 3 \> /proc/sys/vm/drop_caches
>  sleep 2
>  
> -mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
> -is_int "$mem_free" || tst_brkm TBROK "Unable to determine mem_free"
> +# We enable the "always overcommit" memory policy and allocate
> +# less than CommitLimit bytes. Given that no other memory-consuming
> +# process should be running, this gives us a more-or-less strong
> +# guarantee that our allocations will result in an OOM situation.
                                        ^
					missing not?

I've just looked into newer patch that has not in the sentence...

> +overcommit=$(cat "$overcommit_path")
> +is_int "$overcommit" || tst_brkm TBROK "Unable to determine overcommit"
>  
> -swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
> -is_int "$swap_free" || tst_brkm TBROK "Unable to determine swap_free"
> +commit_limit=$(cat /proc/meminfo | grep CommitLimit | awk '{ print $2 }')
> +is_int "$commit_limit" || tst_brkm TBROK "Unable to determine commit_limit"
>  
> -mem=$(( $mem_free + $swap_free / 2 ))
> +committed_as=$(cat /proc/meminfo | grep Committed_AS | awk '{ print $2 }')
> +is_int "$committed_as" || tst_brkm TBROK "Unable to determine committed_as"
> +
> +mem=$(( $commit_limit - $committed_as ))
>  mem=$(( $mem / 1024 ))
>  [ "$mem" -gt 0 ] || tst_brkm TBROK "mem is negative: $mem"
>  
> +ROD echo 1 \> "$overcommit_path"
> +
>  date
>  testcase_1
>  date
>  testcase_2
>  date
>  
> +ROD echo "$overcommit" \> "$overcommit_path"

Shouldn't this be done in the cleanup so that it's restored if the test
is aborted somewhere in the middle?

Something as:

cleanup()
{
...
	if [ -n "$overcommit" ]; then
		echo "$overcommit" \> "$overcommit_path"
	fi
...


-- 
Cyril Hrubis
chrubis@suse.cz
