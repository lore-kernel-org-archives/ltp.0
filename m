Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZOoT9-0006yB-28
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2015 14:54:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZOoT4-0002f2-RY
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2015 14:54:31 +0000
Date: Mon, 10 Aug 2015 16:54:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150810145401.GA10688@rei.suse.de>
References: <55C1F762.4090001@cn.fujitsu.com>
	<1438846166-8917-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438846166-8917-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/2] umount2/umount2_02.c: add MNT_EXPIRE flag
	test
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
> + *  Test for feature MNT_EXPIRE of umount2().
> + *  "Mark the mount point as expired.If a mount point is not currently
> + *   in use, then an initial call to umount2() with this flag fails with
> + *   the error EAGAIN, but marks the mount point as expired. The mount
> + *   point remains expired as long as it isn't accessed by any process.
> + *   A second umount2() call specifying MNT_EXPIRE unmounts an expired
> + *   mount point. This flag cannot be specified with either MNT_FORCE or
> + *   MNT_DETACH. (fails with the error EINVAL)"
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
> +	int flag;
> +	int exp_errno;
> +	const char *string;

Same as the fcntl testcase. Can you please name this variable more
reasonably?

> +} test_cases[] = {
> +	{MNT_EXPIRE | MNT_FORCE, EINVAL,
> +		"umount2(2) with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
> +	{MNT_EXPIRE | MNT_DETACH, EINVAL,
> +		"umount2(2) with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
> +	{MNT_EXPIRE, EAGAIN,
> +		"initial call to umount2(2) with MNT_EXPIRE expected EAGAIN"},
> +	{MNT_EXPIRE, EAGAIN,
> +		"umount2(2) with MNT_EXPIRE after access(2) expected EAGAIN"},
> +	{MNT_EXPIRE, 0,
> +		"second call to umount2(2) with MNT_EXPIRE expected success"},
> +};
> +
> +char *TCID = "umount2_02";
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
> +		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
> +		mount_flag = 1;
> +
> +		for (tc = 0; tc < TST_TOTAL; tc++)
> +			test_umount2(tc);
> +
> +		if (mount_flag) {
> +			SAFE_UMOUNT(cleanup, MNTPOINT);
> +			mount_flag = 0;
> +		}
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
> +	if ((tst_kvercmp(2, 6, 8)) < 0) {
> +		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> +			"that are 2.6.8 or higher");
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
> +	TEST_PAUSE;
> +}
> +
> +static void test_umount2(int i)
> +{
> +	/* a new access removes the expired mark of the mount point */
> +	if (strstr(test_cases[i].string, "access(2)") != NULL) {
> +		if (access(MNTPOINT, F_OK) == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
> +	}

This is too fragile and may fail horribly if we ever change the testcase
output. If you need to do a special setup before this testcase add a
function pointer to the testcase structure and call it here if it's not
NULL.

I.e. Add void (*setup)(void) to the test case structure, set it to a
function that does the access for this case and here do:

	if (tcases[i].setup)
		tcases[i].setup();


Or even easier we can add an integer flag to the structure and do:

	if (tcases[i].do_access) {
		if (access(MNTPOINT, F_OK) == -1)
			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
	}

> +	TEST(umount2(MNTPOINT, test_cases[i].flag));
> +
> +	if (test_cases[i].exp_errno != 0)
> +		verify_failure(i);
> +	else
> +		verify_success(i);
> +}
> +
> +static void verify_failure(int i)
> +{
> +	if (TEST_RETURN == 0) {
> +		tst_resm(TFAIL, "umount2(2) succeeded unexpectedly, %s",
> +			test_cases[i].string);
> +		mount_flag = 0;
> +		return;
> +	}
> +
> +	if (TEST_ERRNO != test_cases[i].exp_errno) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) failed unexpectedly, %s",
> +			test_cases[i].string);

The same as below. Why don't we just print the message from the
structure?

> +		return;
> +	}
> +
> +	tst_resm(TPASS, "umount2(2) failed as expected");

Can we print which errno have we succesfully failed with?

> +}
> +
> +static void verify_success(int i)
> +{
> +	if (TEST_RETURN != 0) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) failed, %s",
> +			test_cases[i].string);

This would create pretty ugly messages i.e.

"umount2(2) failed, second call to umount2(2) with MNT_EXPIRE expected
success"

What about we just print the message from the structure here?

> +		return;
> +	}
> +
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
