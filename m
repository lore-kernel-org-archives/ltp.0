From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Feb 2020 18:34:39 +0100
Subject: [LTP] [PATCH V2 06/10] syscalls/fsmount: Improve fsmount01 test
In-Reply-To: <9706f359006ea409d2f85c111d3e001ca6f6d128.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <9706f359006ea409d2f85c111d3e001ca6f6d128.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <20200220173439.GC15699@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +static struct tcase {
> +	char *name;
> +	unsigned int flags;
> +	unsigned int mount_attrs;
> +} tcases[] = {
> +	{"Flag 0, attr RDONLY", 0, MOUNT_ATTR_RDONLY},
> +	{"Flag 0, attr NOSUID", 0, MOUNT_ATTR_NOSUID},
> +	{"Flag 0, attr NODEV", 0, MOUNT_ATTR_NODEV},
> +	{"Flag 0, attr NOEXEC", 0, MOUNT_ATTR_NOEXEC},
> +	{"Flag 0, attr RELATIME", 0, MOUNT_ATTR_RELATIME},
> +	{"Flag 0, attr NOATIME", 0, MOUNT_ATTR_NOATIME},
> +	{"Flag 0, attr STRICTATIME", 0, MOUNT_ATTR_STRICTATIME},
> +	{"Flag 0, attr NODIRATIME", 0, MOUNT_ATTR_NODIRATIME},
> +	{"Flag CLOEXEC, attr RDONLY", FSMOUNT_CLOEXEC, MOUNT_ATTR_RDONLY},
> +	{"Flag CLOEXEC, attr NOSUID", FSMOUNT_CLOEXEC, MOUNT_ATTR_NOSUID},
> +	{"Flag CLOEXEC, attr NODEV", FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV},
> +	{"Flag CLOEXEC, attr NOEXEC", FSMOUNT_CLOEXEC, MOUNT_ATTR_NOEXEC},
> +	{"Flag CLOEXEC, attr RELATIME", FSMOUNT_CLOEXEC, MOUNT_ATTR_RELATIME},
> +	{"Flag CLOEXEC, attr NOATIME", FSMOUNT_CLOEXEC, MOUNT_ATTR_NOATIME},
> +	{"Flag CLOEXEC, attr STRICTATIME", FSMOUNT_CLOEXEC, MOUNT_ATTR_STRICTATIME},
> +	{"Flag CLOEXEC, attr NODIRATIME", FSMOUNT_CLOEXEC, MOUNT_ATTR_NODIRATIME},
> +};
I'd use desc field

#define DESC(x, y) .flags = x, .mount_attrs = y, .desc = #x ", " #y

+static struct tcase {
+	char *desc;
+	unsigned int flags;
+	unsigned int mount_attrs;
+} tcases[] = {
+	{DESC(0, MOUNT_ATTR_RDONLY)},
+	{DESC(0, MOUNT_ATTR_NOSUID)},

(avoid copy paste).

> +static void setup(void)
>  {
> -	if (is_mounted)
> -		SAFE_UMOUNT(MNTPOINT);
> +	fsopen_supported_by_kernel();
again, just .setup = fsopen_supported_by_kernel;
>  }

> -static void test_fsmount(void)
> +static void run(unsigned int n)
>  {
> +	struct tcase *tc = &tcases[n];
> +	int sfd, mfd;
> +
>  	TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> -	if (TST_RET < 0)
> -		tst_brk(TBROK | TTERRNO, "fsopen() on %s failed", tst_device->fs_type);
> +	if (TST_RET == -1) {
> +		tst_brk(TBROK | TTERRNO, "fsopen() on %s failed",
> +			tst_device->fs_type);
Again, tst_brk(TBROK) shouldn't be on tcnt = ARRAY_SIZE(tcases),
it skips all following tests after failure (sometimes needed but IMHO not here).

> +	}
>  	sfd = TST_RET;
> -	tst_res(TPASS, "fsopen() on %s", tst_device->fs_type);

>  	TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> -	if (TST_RET < 0)
> +	if (TST_RET < 0) {
> +		SAFE_CLOSE(sfd);
>  		tst_brk(TBROK | TTERRNO,
>  			"fsconfig() failed to set source to %s", tst_device->dev);
> -	tst_res(TPASS, "fsconfig() set source to %s", tst_device->dev);
> -
> +	}

>  	TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> -	if (TST_RET < 0)
> +	if (TST_RET < 0) {
> +		SAFE_CLOSE(sfd);
>  		tst_brk(TBROK | TTERRNO, "fsconfig() created superblock");
As you added more runs of the test (changed .test_all to .test && run =
ARRAY_SIZE(tcases)), you need to change all tst_brk() to tst_res() + return.

I also merged tst_brk(TBROK), I guess TFAIL would be better.

Other than that it looks ok.

I also wonder if it'd be worth to implement in fsmount.h some macros to reduce
code duplicity. e.g. one of similar patterns (just flag is different):

TEST(fsopen(tst_device->fs_type, FLAG));
fd = TST_RET;
if (fd == -1)
		tst_brk(TBROK | TERRNO, "fsopen() failed");

But that's not important.

Kind regards,
Petr
