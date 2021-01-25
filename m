From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jan 2021 09:28:46 +0100
Subject: [LTP] [PATCH RFC 2/2] swapping01: check memory swap usage per
 process
In-Reply-To: <20210125064747.26759-2-liwang@redhat.com>
References: <20210125064747.26759-1-liwang@redhat.com>
 <20210125064747.26759-2-liwang@redhat.com>
Message-ID: <YA6BPtiWooSjiiUt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Since previously swapping01 read the system FreeSwap for counting
> usage of swap-size, that's not precise on system especially with
> eating-memory daemon?in the background. Now, we try to check the
> 'VmmSwap' in proc/PID/status?per process, to get rid of?the potential
> influence from?other processes?which easily leads to false positive.

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Petr Vorel <pvorel@suse.cz>
> Cc: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  testcases/kernel/mem/swapping/swapping01.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
> index 8106f6466..0f693f313 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -137,8 +137,7 @@ static void check_swapping(void)
>  		i++;
>  	}

> -	swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
> -	swapped = swap_free_init - swap_free_now;
> +	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
>  	if (swapped > mem_over_max) {
>  		kill(pid, SIGCONT);
>  		tst_brk(TFAIL, "heavy swapping detected: "
