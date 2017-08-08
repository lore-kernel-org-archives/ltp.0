From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 8 Aug 2017 09:03:48 +0800
Subject: [LTP] [PATCH] syscalls/fcntl35: the pipe-max-size should be
 multiple of PAGE_SIZE
In-Reply-To: <20170807071059.27653-1-liwang@redhat.com>
References: <20170807071059.27653-1-liwang@redhat.com>
Message-ID: <59890DF4.6090703@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

Thanks for fixing this issue! :-)

Thanks,
Xiao Yang.

On 2017/08/07 15:10, Li Wang wrote:
> It's very easy to get failures on a system which the PAGE_SIZE is larger than 4096.
>
>   # uname -r
>   4.13.0-rc3
>   # getconf PAGESIZE
>   65536
>   # echo 4096 >/proc/sys/fs/pipe-max-size
>   bash: echo: write error: Invalid argument
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/fcntl/fcntl35.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
> index b984584..675da71 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl35.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
> @@ -45,19 +45,23 @@
>  #include "tst_test.h"
>  
>  static int pipe_max_unpriv;
> -static int test_max_unpriv = 4096;
> +static int test_max_unpriv;
> +static int test_max_priv;
>  static struct passwd *pw;
>  static struct tcase {
> -	int exp_sz;
> +	int *exp_sz;
>  	int exp_usr;
>  	char *des;
>  } tcases[] = {
> -	{4096, 1, "an unprivileged user"},
> -	{65536, 0, "a privileged user"}
> +	{&test_max_unpriv, 1, "an unprivileged user"},
> +	{&test_max_priv, 0, "a privileged user"}
>  };
>  
>  static void setup(void)
>  {
> +	test_max_unpriv = getpagesize();
> +	test_max_priv = test_max_unpriv * 16;
> +
>  	if (!access("/proc/sys/fs/pipe-max-size", F_OK)) {
>  		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d",
>  				&pipe_max_unpriv);
> @@ -115,7 +119,7 @@ static void do_test(unsigned int n)
>  		if (tc->exp_usr)
>  			SAFE_SETUID(pw->pw_uid);
>  
> -		verify_pipe_size(tc->exp_sz, tc->des);
> +		verify_pipe_size(*tc->exp_sz, tc->des);
>  	}
>  
>  	tst_reap_children();



