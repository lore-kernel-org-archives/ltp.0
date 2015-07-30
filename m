Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKnxL-0003CR-9h
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 13:33:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKnx8-0004SD-8c
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 13:32:58 +0000
Date: Thu, 30 Jul 2015 15:32:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150730133236.GA21727@rei.suse.de>
References: <1438239541-14080-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438239541-14080-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] open/open13.c: add O_PATH flag test
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
> + * You should have received a copy of the GNU General Public License along
> + * with this program.
> + */
> +
> +/*
> + * DESCRIPTION
> + *  Basic test for open(2) with the flag O_PATH.
> + *  "Obtain a file descriptor that can be used to perform operations
> + *   that act purely at the file descriptor level, the file itself is
> + *   not opened, the operations read(2), write(2), fchmod(2), fchown(2)
> + *   and fgetxattr(2) fail with the error EBADF."
> + *
> + *  The operations include but is not limited to the syscalls above.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "config.h"
> +
> +#include <errno.h>
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <sys/types.h>
> +#include <attr/xattr.h>
> +#endif
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +
> +#define TESTFILE	"testfile"
> +#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
> +#define EXP_ERRNO	EBADF

Defining the EXP_ERRNO as EBADF only hides what the expected error is
and it's not like the expected errno for the testcases will ever change.
So it's better to just hardcode the EBADFD there and keep the code nice
and readable.

> +static void setup(void);
> +static void verify_read(void);
> +static void verify_write(void);
> +static void verify_fchmod(void);
> +static void verify_fchown(void);
> +#ifdef HAVE_ATTR_XATTR_H
> +static void verify_fgetxattr(void);
> +#endif
> +static void cleanup(void);
> +
> +static int fd;
> +
> +static void (*test_func[])(void) = {
> +	verify_read,
> +	verify_write,
> +	verify_fchmod,
> +	verify_fchown,
> +#ifdef HAVE_ATTR_XATTR_H
> +	verify_fgetxattr
> +#endif
> +};
> +
> +char *TCID = "open13";
> +int TST_TOTAL = ARRAY_SIZE(test_func);
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
> +		TEST(open(TESTFILE, O_RDWR | O_PATH));
> +		if (TEST_RETURN == -1) {
> +			tst_resm(TFAIL | TTERRNO, "open(2) failed");
> +			continue;
> +		}
> +
> +		fd = TEST_RETURN;

Just do fd = SAFE_OPEN(TESTFILE, O_CREAT | O_RDWR | O_PATH); instead and
drop the SAFE_TOUCH() from the setup as well.

> +		for (tc = 0; tc < TST_TOTAL; tc++)
> +			(*test_func[tc])();

You have to close the fd here, otherwise the loop will leak fds with -i
or -I test parameters.

> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	if ((tst_kvercmp(2, 6, 39)) < 0) {
> +		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> +			"that are 2.6.39 or higher");
> +	}
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();
> +
> +	SAFE_TOUCH(cleanup, TESTFILE, FILE_MODE, NULL);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void verify_read(void)
> +{
> +	char buf[255];
> +
> +	TEST(read(fd, buf, 255));
                             ^
			     sizeof(buf)
> +
> +	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
> +		tst_resm(TPASS, "read(2) failed as expected");
> +	} else {
> +		tst_resm(TFAIL, "open(2) O_PATH flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EXP_ERRNO, strerror(EXP_ERRNO));

                       This does not say what errno we actuall got or if
		       the call has succeded. Given that these all are
		       negative testcases we can define check result
		       functions as:

static void check_result(const char *call_name)
{
	if (TEST_RETURN == 0) {
		tst_resm(TFAIL, "%s succeeded unexpectedly", call_name);
		return;
	}

	if (TEST_ERRNO != EBADF) {
		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly, "
		         "expected EBADF", call_name);
		return;
	}

	tst_resm(TPASS, "%s failed with EBADF", call_name);
}

And call it in all the test functions.

> +	}
> +}
> +
> +static void verify_write(void)
> +{
> +	TEST(write(fd, "w", 1));
> +
> +	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
> +		tst_resm(TPASS, "write(2) failed as expected");
> +	} else {
> +		tst_resm(TFAIL, "open(2) O_PATH flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EXP_ERRNO, strerror(EXP_ERRNO));
> +	}
> +}
> +
> +static void verify_fchmod(void)
> +{
> +	TEST(fchmod(fd, 0666));
> +
> +	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
> +		tst_resm(TPASS, "fchmod(2) failed as expected");
> +	} else {
> +		tst_resm(TFAIL, "open(2) O_PATH flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EXP_ERRNO, strerror(EXP_ERRNO));
> +	}
> +}
> +
> +static void verify_fchown(void)
> +{
> +	uid_t tuid = 1000;
> +	gid_t tgid = 1000;
> +
> +	TEST(fchown(fd, tuid, tgid));
> +
> +	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
> +		tst_resm(TPASS, "fchown(2) failed as expected");
> +	} else {
> +		tst_resm(TFAIL, "open(2) O_PATH flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EXP_ERRNO, strerror(EXP_ERRNO));
> +	}
> +}
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +static void verify_fgetxattr(void)
> +{
> +	TEST(fgetxattr(fd, "tkey", NULL, 1));
> +
> +	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
> +		tst_resm(TPASS, "fgetxattr(2) failed as expected");
> +	} else {
> +		tst_resm(TFAIL, "open(2) O_PATH flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EXP_ERRNO, strerror(EXP_ERRNO));
> +	}
> +}
> +#endif
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0 && close(fd))
> +		tst_resm(TWARN | TERRNO, "failed to close file");
> +
> +	tst_rmdir();
> +}
> -- 
> 1.8.4.2
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
