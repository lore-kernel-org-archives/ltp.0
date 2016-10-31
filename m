From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 31 Oct 2016 18:20:32 +0800
Subject: [LTP] [PATCH v2] syscalls/quotatcl01.c: Rewrite && Convert to
	new API
In-Reply-To: <20161031101104.GD30590@rei.lan>
References: <20161024104928.GA19167@rei.lan>
 <1477376138-578-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20161031101104.GD30590@rei.lan>
Message-ID: <58171AF0.5000209@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/10/31 18:11, Cyril Hrubis wrote:
> Hi!
> Pushed with follwing diff, thanks.
>
> Apart from cosmetic things like removing useless cast to caddrt_t I've
> changed it to handle missing quotacheck command gracefully. I.e. we have
> to set the mount flag right after we mount the device otherwise the test
> cleanup in library will fail when we call tst_brk() because the
> tst_run_cmd() has failed since the test haven't umounted it. And also
> tst_run_cmd returns 255 on ENOENT which should be mapped to TCONF
> instead of TBROK.
>
> Also can you pretty please resend the second patch? I cannot find it in
> my mailbox anymore (possibly accidentally deleted).
Hi Cyril
Thanks for your review.   I will resend th second patch:-) .

Thanks
Xiao Yang.
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 9e1ff36..89b5dc2 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -63,16 +63,16 @@
>   #  ifndef QFMT_VFS_V0
>   #   define QFMT_VFS_V0     2
>   #  endif
> -#  define USRPATH MNTPOINT "/" "aquota.user"
> -#  define GRPPATH MNTPOINT "/" "aquota.group"
> +#  define USRPATH MNTPOINT "/aquota.user"
> +#  define GRPPATH MNTPOINT "/aquota.group"
>   #  define FMTID	QFMT_VFS_V0
>   # else
>   #  define _LINUX_QUOTA_VERSION  1
>   #  ifndef QFMT_VFS_OLD
>   #   define QFMT_VFS_OLD    1
>   #  endif
> -#  define USRPATH MNTPOINT "/" "quota.user"
> -#  define GRPPATH MNTPOINT "/" "quota.group"
> +#  define USRPATH MNTPOINT "/quota.user"
> +#  define GRPPATH MNTPOINT "/quota.group"
>   #  define FMTID	QFMT_VFS_OLD
>   # endif
>
> @@ -145,14 +145,24 @@ static struct tcase {
>   static void setup(void)
>   {
>   	const char *const cmd[] = {"quotacheck", "-ug", MNTPOINT, NULL};
> +	int ret;
>
>   	SAFE_MKDIR(MNTPOINT, 0755);
>
>   	SAFE_MKFS(tst_device->dev, "ext4", NULL, NULL);
>
>   	SAFE_MOUNT(tst_device->dev, MNTPOINT, "ext4", 0, "usrquota,grpquota");
> +	mount_flag = 1;
>
> -	tst_run_cmd(cmd, NULL, NULL, 0);
> +	ret = tst_run_cmd(cmd, NULL, NULL, 1);
> +	switch (ret) {
> +	case 255:
> +		tst_brk(TCONF, "quotacheck binary not installed");
> +	default:
> +		tst_brk(TBROK, "quotacheck exited with %i", ret);
> +	case 0:
> +	break;
> +	}
>
>   	test_id = geteuid();
>
> @@ -161,8 +171,6 @@ static void setup(void)
>
>   	if (access(GRPPATH, F_OK) == -1)
>   		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
> -
> -	mount_flag = 1;
>   }
>
>   static void cleanup(void)
> @@ -179,7 +187,7 @@ static void verify_quota(unsigned int n)
>   	res_qf.dqi_igrace = 0;
>   	memset(fmt_buf, 0, sizeof(fmt_buf));
>
> -	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, (caddr_t) tc->addr));
> +	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
>   	if (TEST_RETURN == -1) {
>   		tst_res(TFAIL | TERRNO, "quotactl failed to %s", tc->des);
>   		return;
>



