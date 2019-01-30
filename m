From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jan 2019 17:15:14 +0100
Subject: [LTP] [PATCH] syscalls/setrlimit03.c: read /proc/sys/fs/nr_open
 for RLIMIT_NOFILE limit
In-Reply-To: <20190130150047.26307-1-tt.rantala@gmail.com>
References: <20190130150047.26307-1-tt.rantala@gmail.com>
Message-ID: <20190130161514.GA27751@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  testcases/kernel/syscalls/setrlimit/setrlimit03.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
> index 29b52aa7f..643432bb4 100644
> --- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
> @@ -36,6 +36,7 @@
>  #endif
>  
>  static struct rlimit rlim1, rlim2;
> +static unsigned int nr_open;

I would have initialized the variable to NR_OPEN here.

>  static struct tcase {
>  	struct rlimit *rlimt;
> @@ -51,7 +52,10 @@ static void verify_setrlimit(unsigned int n)
>  
>  	TEST(setrlimit(RLIMIT_NOFILE, tc->rlimt));
>  	if (TST_RET != -1) {
> -		tst_res(TFAIL, "call succeeded unexpectedly");
> +		tst_res(TFAIL, "call succeeded unexpectedly "
> +			"(nr_open=%u rlim_cur=%lu rlim_max=%lu)", nr_open,
> +			(unsigned long)(tc->rlimt->rlim_cur),
> +			(unsigned long)(tc->rlimt->rlim_max));
>  		return;
>  	}
>  
> @@ -65,10 +69,16 @@ static void verify_setrlimit(unsigned int n)
>  
>  static void setup(void)
>  {
> +	if (tst_kvercmp(2, 6, 25) < 0) {
> +		nr_open = NR_OPEN;
> +	} else {
> +		SAFE_FILE_SCANF("/proc/sys/fs/nr_open", "%u", &nr_open);
> +	}

Can we do here without the explicit kernel version check?

What about:

#define NR_OPEN_PATH "/proc/sys/fs/nr_open"

...

	if (acess(NR_OPEN_PATH, F_OK))
		SAFE_FILE_SCANF(NR_OPEN_APTH, "%u", &nr_open);


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
