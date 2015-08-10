Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZOojK-0006mB-1N
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2015 15:11:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZOojH-0003AT-FP
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2015 15:11:14 +0000
Date: Mon, 10 Aug 2015 17:10:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150810151045.GB10688@rei.suse.de>
References: <55C1F86B.1020606@cn.fujitsu.com>
	<1438844752-8361-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438844752-8361-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/2] umount2/umount2_03.c: add UMOUNT_NOFOLLOW
 flag test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/*
> + * Copyright (c) 2015 Fujitsu Ltd.
> + * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License
> + * alone with this program.
> + */
> +
> +/*
> + * DESCRIPTION
> + *  Test for feature UMOUNT_NOFOLLOW of umount2().
> + *  "Don't dereference target if it is a symbolic link,
> + *   and fails with the error EINVAL."
> + */
> +
> +#include <errno.h>
> +#include <sys/mount.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/mount.h"
> +
> +#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
> +#define MNTPOINT	"mntpoint"
> +#define SYMLINK	"symlink"
> +
> +static void setup(void);
> +static void test_umount2(int i);
> +static void verify_failure(int i);
> +static void verify_success(int i);
> +static void cleanup(void);
> +
> +static const char *device;
> +static const char *fs_type;
> +
> +static int mount_flag;
> +
> +static struct test_case_t {
> +	const char *mntpoint;
> +	int exp_errno;
> +	const char *string;

Same here, please name it better.

> +} test_cases[] = {
> +	{SYMLINK, EINVAL,
> +		"umount2('symlink', UMOUNT_NOFOLLOW) expected EINVAL"},
> +	{MNTPOINT, 0,
> +		"umount2('mntpoint', UMOUNT_NOFOLLOW) expected success"},
> +};
> +
> +char *TCID = "umount2_03";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int tc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (tc = 0; tc < TST_TOTAL; tc++)
> +			test_umount2(tc);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	if ((tst_kvercmp(2, 6, 34)) < 0) {
> +		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> +			"that are 2.6.34 or higher");
> +	}
> +
> +	tst_sig(NOFORK, DEF_HANDLER, NULL);
> +
> +	tst_tmpdir();
> +
> +	fs_type = tst_dev_fs_type();
> +	device = tst_acquire_device(cleanup);
> +
> +	if (!device)
> +		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> +
> +	tst_mkfs(cleanup, device, fs_type, NULL);
> +
> +	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
> +
> +	SAFE_SYMLINK(cleanup, MNTPOINT, SYMLINK);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void test_umount2(int i)
> +{
> +	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
> +	mount_flag = 1;
> +
> +	TEST(umount2(test_cases[i].mntpoint, UMOUNT_NOFOLLOW));
> +
> +	if (test_cases[i].exp_errno != 0)
> +		verify_failure(i);
> +	else
> +		verify_success(i);
> +
> +	if (mount_flag) {
> +		SAFE_UMOUNT(cleanup, MNTPOINT);
> +		mount_flag = 0;
> +	}
> +}
> +
> +static void verify_failure(int i)
> +{
> +	if (TEST_RETURN == 0) {
> +		tst_resm(TFAIL, "umount2(2) suceeded unexpectedly, %s",
> +			test_cases[i].string);

And here the message will look ugly. We should at least remove the
umount2(2) so that it's shorter.

> +		mount_flag = 0;
> +		return;
> +	}
> +
> +	if (TEST_ERRNO != test_cases[i].exp_errno) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) failed unexpectedly, %s",
> +			test_cases[i].string);


Here as well.

> +		return;
> +	}
> +
> +	tst_resm(TPASS, "umount2(2) failed as expected");

Again please add which errno we got.

> +}
> +
> +static void verify_success(int i)
> +{
> +	if (TEST_RETURN != 0) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) failed, %s",
> +			test_cases[i].string);
> +		return;
> +	}

And here.

Thinkig of it the best way would have been setting the string in the
structure to:

 "umount2('symlink', UMOUNT_NOFOLLOW) %s expected EINVAL"

 and do tst_resm(..., tcases[i].desc, "failed unexpectedly");

But I guess that the compiler does not like when printf-like function
get's formatting string that is not constant.


So we would have to live with adding the "failed unexpectedly" or
"passed unexpectedly" to end of the message.

> +	tst_resm(TPASS, "umount2(2) succeeded as expected");
> +	mount_flag = 0;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (mount_flag && tst_umount(MNTPOINT))
> +		tst_resm(TWARN | TERRNO, "Failed to unmount");
> +
> +	if (device)
> +		tst_release_device(NULL, device);
> +
> +	tst_rmdir();
> +}
> -- 
> 1.8.4.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
