Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDzxd-0003mo-FV
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 17:20:29 +0000
Date: Thu, 13 Feb 2014 18:20:19 +0100
From: chrubis@suse.cz
Message-ID: <20140213172019.GA19020@rei.suse.cz>
References: <1388049047.1587.21.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1388049047.1587.21.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] lchown/lchown03.c: add EROFS error number test
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> @@ -372,6 +372,7 @@ kill12 kill12
>  
>  lchown01 lchown01
>  lchown02 lchown02
> +lchown03 lchown03 -D DEVICE -T DEVICE_FS_TYPE

Please fix the DEVICE and DEVICE_FS_TYPE to the new format.

> --- /dev/null
> +++ b/testcases/kernel/syscalls/lchown/lchown03.c
> @@ -0,0 +1,162 @@
> +/*
> + * Copyright (c) 2013 Fujitsu Ltd.
> + * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <grp.h>
> +#include <pwd.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/mount.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> +			 S_IXGRP|S_IROTH|S_IXOTH)
> +#define TEST_FILE	"mntpoint"
> +
> +static char *fstype = "ext2";
> +static char *device;
> +static int dflag;
> +static int mount_flag;
> +
> +static option_t options[] = {
> +	{"T:", NULL, &fstype},
> +	{"D:", &dflag, &device},
> +	{NULL, NULL, NULL}
> +};
> +
> +static struct test_case_t {
> +	char *pathname;
> +	char *desc;
> +	int exp_errno;
> +	void (*setup) (int pos);
> +} test_cases[] = {
> +	{TEST_FILE, "EROFS", EROFS, NULL},
> +};

As in the msgclt13.c it does not make sense to create a test_case_t if
you don't intend to add testcases here.

> +char *TCID = "lchown03";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static int exp_enos[] = { EROFS, 0 };
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void help(void);
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +	uid_t user_id;
> +	gid_t group_id;
> +	int i;
> +
> +	msg = parse_opts(argc, argv, options, help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	if (!dflag) {
> +		tst_brkm(TBROK, NULL,
> +			 "you must specify the device used for mounting with "
> +			 "-D option");
> +	}

No need for the dflag.

> +	setup();
> +
> +	TEST_EXP_ENOS(exp_enos);
> +
> +	user_id = geteuid();
> +	group_id = getegid();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +
> +			TEST(lchown(test_cases[i].pathname, user_id, group_id));
> +
> +			if (TEST_RETURN == -1) {
> +				TEST_ERROR_LOG(TEST_ERRNO);
> +				if (TEST_ERRNO == test_cases[i].exp_errno) {
> +					tst_resm(TPASS,
> +						 "lchown(2) fails,%s, errno:%d",
> +						 test_cases[i].desc,
> +						 TEST_ERRNO);
> +				} else {
> +					tst_resm(TFAIL,
> +						 "lchown(2) fails, %s, errno:"
> +						 "%d, expected errno:%d",
> +						 test_cases[i].desc, TEST_ERRNO,
> +						 test_cases[i].exp_errno);
> +				}
> +			} else {
> +				tst_resm(TFAIL,
> +					 "lchown(2) returned %ld, expected -1, "
> +					 "errno:%d", TEST_RETURN,
> +					 test_cases[i].exp_errno);
> +			}
> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	tst_require_root(NULL);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	tst_mkfs(NULL, device, fstype, NULL);
> +	SAFE_MKDIR(cleanup, TEST_FILE, DIR_MODE);
> +	if (mount(device, TEST_FILE, fstype, MS_RDONLY, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	}
> +	mount_flag = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	if (mount_flag && umount(TEST_FILE) < 0) {
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			 "umount device:%s failed", device);

Again I would rather change this to tst_resm(TWARN | TERRNO, ...) to
avoid problems with the tst_brkm().

> +	}
> +
> +	tst_rmdir();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
