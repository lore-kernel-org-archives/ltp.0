From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Aug 2020 14:42:02 +0200
Subject: [LTP] [PATCH 2/2] syscalls/utimensat01: add exception for
 Ubuntu 4.4 kernel
In-Reply-To: <20200817120644.9401-3-po-hsu.lin@canonical.com>
References: <20200817120644.9401-1-po-hsu.lin@canonical.com>
 <20200817120644.9401-3-po-hsu.lin@canonical.com>
Message-ID: <20200817124202.GB8445@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  testcases/kernel/syscalls/utimensat/utimensat01.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
> index 7dabfed6d..469cb61c5 100644
> --- a/testcases/kernel/syscalls/utimensat/utimensat01.c
> +++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
> @@ -158,6 +158,10 @@ static void tst_multi_set_time(enum tst_ts_type type, struct mytime *mytime)
>  
>  static void update_error(struct test_case *tc)
>  {
> +	static struct tst_kern_exv kvers[] = {
> +		{ "UBUNTU", "4.4.0-48.69" },
> +	};
> +
>  	if (tc->exp_err != -1)
>  		return;
>  
> @@ -167,9 +171,12 @@ static void update_error(struct test_case *tc)
>  	 * This patch has also been merged to stable 4.4 with
>  	 * b3b4283 ("vfs: move permission checking into notify_change() for utimes(NULL)")
>  	 */
> -	if (tst_kvercmp(4, 4, 27) < 0)
> +	if (tst_kvercmp(4, 4, 27) < 0) {
>  		tc->exp_err = EACCES;
> -	else
> +		// Special case for Ubuntu kernel, which got this patch since 4.4.0-48.69
> +		if (tst_kvercmp2(4, 4, 0, kvers))
> +			tc->exp_err = EPERM;
> +	} else
>  		tc->exp_err = EPERM;

This whole thing looks broken, this is not how the tst_kvercmp2() is
supposed to work. The generic kernel version is supposed to be passed in
the first parameters and the kvers overrides that option.

So this should be something like:

	if (tst_kvercmp2(4, 4, 27, kvers) < 0)
		tc->exp_err = EACCESS;
	else
		tc->exp_err = EPERM;


And in a case that the distro matches to UBUNTU the kernel version is
compared against the "4.4.0-48.69" instead of the generic one.

>  }
>  
> -- 
> 2.17.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
