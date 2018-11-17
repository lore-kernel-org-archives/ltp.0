From: Steve Muckle <smuckle@google.com>
Date: Fri, 16 Nov 2018 20:53:05 -0800
Subject: [LTP] [PATCH] syscalls/rt_sigsuspend01: ignore reserved signals
In-Reply-To: <20181117045159.215245-1-smuckle@google.com>
References: <20181117045159.215245-1-smuckle@google.com>
Message-ID: <47afe21b-e783-f64e-5b74-64663665c7fb@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril this applies on top of the recent series you sent:

[LTP] [PATCH 0/3] Add rt signal newlib support + convert rt_sigsuspend01

thanks,
Steve

On 11/16/2018 08:51 PM, Steve Muckle wrote:
> Some signals may be internally used by the C library. Do not attempt to
> verify these.
> 
> Signed-off-by: Steve Muckle <smuckle@google.com>
> ---
>   .../kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> index 14b6bb332..f17a9aae6 100644
> --- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> +++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> @@ -26,6 +26,7 @@ static void sig_handler(int sig)
>   
>   static void verify_rt_sigsuspend(void)
>   {
> +	int i;
>   	sigset_t set, set1, set2;
>   	struct sigaction act = {.sa_handler = sig_handler};
>   
> @@ -51,11 +52,13 @@ static void verify_rt_sigsuspend(void)
>   	tst_res(TPASS, "rt_sigsuspend() returned with -1 and EINTR");
>   
>   	SAFE_RT_SIGPROCMASK(0, NULL, &set2, SIGSETSIZE);
> -
> -	if (memcmp(&set1, &set2, sizeof(unsigned long)))
> -		tst_res(TFAIL, "signal mask not preserved");
> -	else
> -		tst_res(TPASS, "signal mask preserved");
> +	for (i = 1; i < SIGRTMAX; i++) {
> +		if (i >= __SIGRTMIN && i < SIGRTMIN)
> +			continue;
> +		if (sigismember(&set1, i) != sigismember(&set2, i))
> +			tst_brk(TFAIL, "signal mask not preserved");
> +	}
> +	tst_res(TPASS, "signal mask preserved");
>   }
>   
>   static struct tst_test test = {
> 

