From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 28 Jul 2016 07:28:26 -0400 (EDT)
Subject: [LTP] [PATCH] swapping: replace mem_free by mem_available
In-Reply-To: <1469000896-6122-1-git-send-email-liwang@redhat.com>
References: <1469000896-6122-1-git-send-email-liwang@redhat.com>
Message-ID: <1594266875.9316113.1469705306083.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: ltp@lists.linux.it
> Sent: Wednesday, 20 July, 2016 9:48:16 AM
> Subject: [LTP] [PATCH] swapping: replace mem_free by mem_available
> 
> On some ppc64 systems, there free memory are larger than available memory,
> and
> swap size is very small. Then this swapping01 easily get failures like:
> 
> swapping01    0  TINFO  :  free physical memory: 14651 MB
> swapping01    0  TINFO  :  try to allocate: 19046 MB
> swapping01    1  TBROK  :  swapping01.c:134: malloc: errno=ENOMEM(12): Cannot
> allocate memory
> swapping01    2  TBROK  :  swapping01.c:134: Remaining cases broken
> swapping01    1  TBROK  :  swapping01.c:151: child was not stopped.
> swapping01    2  TBROK  :  swapping01.c:151: Remaining cases broken
> 
>  # free -m
>                total        used        free      shared  buff/cache
>                available
>  Mem:          15316         238       14651           0         427
>  14478
>  Swap:          4607         202        4405
> 
> That's because 14478(available_mem) + 4405(swap_free) < 19046(expected:
> 14651(free_mem) * 1.3),
> so we get malloc ENOMEM errors.
> 
> This patch replaces the free memory by available, and clean up some code.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/mem/swapping/swapping01.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/mem/swapping/swapping01.c
> b/testcases/kernel/mem/swapping/swapping01.c
> index b530ee2..caadb19 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -68,7 +68,7 @@ static void init_meminfo(void);
>  static void do_alloc(void);
>  static void check_swapping(void);
>  
> -static long mem_free_init;
> +static long mem_available_init;
>  static long swap_free_init;
>  static long mem_over;
>  static long mem_over_max;
> @@ -108,17 +108,17 @@ int main(int argc, char *argv[])
>  static void init_meminfo(void)
>  {
>  	swap_free_init = read_meminfo("SwapFree:");
> -	mem_free_init = read_meminfo("MemFree:");
> -	mem_over = mem_free_init * COE_SLIGHT_OVER;
> -	mem_over_max = mem_free_init * COE_DELTA;
> -
> -	/* at least 10MB free physical memory needed */
> -	if (mem_free_init < 10240) {
> -		sleep(5);
> -		if (mem_free_init < 10240)
> +	if (!FILE_LINES_SCANF(cleanup, "/proc/meminfo", "MemAvailable: %ld",
> +				&mem_available_init))
> +		mem_available_init = read_meminfo("MemFree:") + read_meminfo("Cached:");
> +	mem_over = mem_available_init * COE_SLIGHT_OVER;
> +	mem_over_max = mem_available_init * COE_DELTA;
> +
> +	/* at least 10MB available physical memory needed */
> +	if (mem_available_init < 10240)
>  			tst_brkm(TCONF, cleanup,
> -				 "Not enough free memory to test.");
> -	}
> +				 "Not enough avalable memory to test.");
> +
>  	if (swap_free_init < mem_over)
>  		tst_brkm(TCONF, cleanup, "Not enough swap space to test.");

Hi,

check_swapping() compares swap increase to mem_over_max. Is bad kernel
really using that much swap? If so, then condition above looks
wrong, since it doesn't check that we can fit so much into swap.

>  }
> @@ -128,8 +128,8 @@ static void do_alloc(void)
>  	long mem_count;
>  	void *s;
>  
> -	tst_resm(TINFO, "free physical memory: %ld MB", mem_free_init / 1024);
> -	mem_count = mem_free_init + mem_over;
> +	tst_resm(TINFO, "available physical memory: %ld MB", mem_available_init /
> 1024);
> +	mem_count = mem_available_init + mem_over;
>  	tst_resm(TINFO, "try to allocate: %ld MB", mem_count / 1024);
>  	s = malloc(mem_count * 1024);
>  	if (s == NULL)
> @@ -160,7 +160,7 @@ static void check_swapping(void)
>  			tst_brkm(TFAIL, cleanup, "heavy swapping detected: "
>  				 "%ld MB swapped.", swapped / 1024);
>  		}
> -		sleep(1);
> +		usleep(100000);

The original code appears to check multiple times to be sure that
writes to swap have settled. Did you test if shortened delay can still
detect bug on bad kernel?

I was thinking we break the loop if we see no change in swap usage
for certain period:

i = 0;
while (i < X) {
  i++;
  swapped = read_meminfo("SwapFree:");
  sleep(1);
  if (abs(swapped - read_meminfo("SwapFree:")) < 512)
    break;
}

if (swapped > mem_over_max) {
  FAIL
}

Regards,
Jan

>  	}
>  	tst_resm(TPASS, "no heavy swapping detected, %ld MB swapped.",
>  		 swapped / 1024);
> --
> 1.8.3.1
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
