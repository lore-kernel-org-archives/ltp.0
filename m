From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Feb 2020 18:04:25 +0100
Subject: [LTP] [PATCH V2 04/10] syscalls/fsopen: New tests
In-Reply-To: <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <20200220170425.GB15699@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

...
> +static struct tcase {
> +	char *name;
> +	unsigned int flags;
> +} tcases[] = {
> +	{"Flag 0", 0},
> +	{"Flag FSOPEN_CLOEXEC", FSOPEN_CLOEXEC},
> +};
Note about removing text from flags apply also for this test.

> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +}
How about removing this and use as setup function directly
fsopen_supported_by_kernel()?
.setup = fsopen_supported_by_kernel,

Other than that it's OK.
However I have problem on fsopen01 and fsmount02.
mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not making
filesystem (use -I to override)
tst_mkfs.c:100: BROK: tst_test.c:830: mkfs.vfat failed with 1

.dev_fs_flags = TST_FS_SKIP_FUSE helps with exfat and ntfs, but this also fails
on vfat.

This is tested on system with CONFIG_VFAT_FS=m and CONFIG_FAT_FS=m, vfat and fat
are loaded by mkfs.vfat. IMHO we need something like TST_FS_SKIP_EXFAT | TST_FS_SKIP_FAT | TST_FS_SKIP_NTFS | TST_FS_SKIP_FUSE
i.e. explicitly say what FS is not wanted no matter whether it's fuse or not.

Or maybe just TST_FS_SKIP_FAT | TST_FS_SKIP_FUSE would be enough.

NOTE: flags TST_FS_SKIP_EXFAT, TST_FS_SKIP_FAT, TST_FS_SKIP_NTFS do not exists yet.

...
> diff --git a/testcases/kernel/syscalls/fsopen/fsopen02.c b/testcases/kernel/syscalls/fsopen/fsopen02.c
> new file mode 100644
> index 000000000000..72cb940c5468
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsopen/fsopen02.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
Nit: I'd avoid "Description:".
> + * Basic fsopen() failure tests.
> + */
...

> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	TEST(fsopen(*tc->fs, tc->flags));
> +
> +	if (TST_RET != -1) {
> +		SAFE_CLOSE(TST_RET);
> +		tst_brk(TFAIL, "%s: fsopen() succeeded unexpectedly (index: %d)",
> +			tc->name, n);
This also need tst_res() and return, or second test get skipped if first fails.
See http://lists.linux.it/pipermail/ltp/2020-February/015505.html

> +	}
> +
> +	if (tc->exp_errno != TST_ERR) {
> +		tst_brk(TFAIL | TTERRNO, "%s: fsopen() should fail with %s",
> +			tc->name, tst_strerrno(tc->exp_errno));
And here too.
> +	}

Kind regards,
Petr
