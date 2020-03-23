From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 23 Mar 2020 11:13:46 +0800
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200320134937.16616-2-pvorel@suse.cz>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <20200320134937.16616-2-pvorel@suse.cz>
Message-ID: <c0ab47c6-cc59-03e5-d474-e4efd68844a2@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

This patch looks good to me, just a small nit
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/add_key/add_key05.c   | 15 ++-------------
>   testcases/kernel/syscalls/quotactl/quotactl01.c | 14 ++------------
>   testcases/kernel/syscalls/quotactl/quotactl06.c | 12 +-----------
>   3 files changed, 5 insertions(+), 36 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
> index a39bfa0b7..6a4e20564 100644
> --- a/testcases/kernel/syscalls/add_key/add_key05.c
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -36,19 +36,8 @@ static void add_user(void)
>   		return;
>   
>   	const char *const cmd_useradd[] = {"useradd", username, NULL};
> -	int rc;
> -
> -	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
> -	case 0:
> -		user_added = 1;
> -		ltpuser = SAFE_GETPWNAM(username);
> -		break;
> -	case 255:
> -		tst_brk(TCONF, "useradd not found");
> -		break;
> -	default:
> -		tst_brk(TBROK, "useradd failed (%d)", rc);
> -	}
> +
> +	SAFE_RUNCMD(cmd_useradd, NULL, NULL);We should keep ltpuser and user_added assignment.

Best Regards
Yang Xu
>   	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
>   }
>   
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index ede61d7e4..30151814e 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -162,18 +162,8 @@ static struct tcase {
>   static void setup(void)
>   {
>   	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
> -	int ret;
> -
> -	ret = tst_run_cmd(cmd, NULL, NULL, 1);
> -	switch (ret) {
> -	case 0:
> -		break;
> -	case 255:
> -		tst_brk(TCONF, "quotacheck binary not installed");
> -		break;
> -	default:
> -		tst_brk(TBROK, "quotacheck exited with %i", ret);
> -	}
> +
> +	SAFE_RUNCMD(cmd, NULL, NULL);
>   
>   	test_id = geteuid();
>   	if (access(USRPATH, F_OK) == -1)
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index a3b4517e0..0b62e6240 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -146,19 +146,9 @@ static void verify_quotactl(unsigned int n)
>   static void setup(void)
>   {
>   	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
> -	int ret;
>   	unsigned int i;
>   
> -	ret = tst_run_cmd(cmd, NULL, NULL, 1);
> -	switch (ret) {
> -	case 0:
> -		break;
> -	case 255:
> -		tst_brk(TCONF, "quotacheck binary not installed");
> -		break;
> -	default:
> -		tst_brk(TBROK, "quotacheck exited with %i", ret);
> -	}
> +	SAFE_RUNCMD(cmd, NULL, NULL);
>   
>   	if (access(USRPATH, F_OK) == -1)
>   		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
> 


