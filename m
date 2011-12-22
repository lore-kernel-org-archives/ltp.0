Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdhsA-0007D9-06
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 12:35:46 +0000
Date: Thu, 22 Dec 2011 13:45:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222124524.GA29787@saboteur.suse.cz>
References: <1324554978-26997-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324554978-26997-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] syscalls/setxattr01: new testcase to test
 setxattr(2) basic function
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
> new file mode 100644
> index 0000000..cfe5e52
> --- /dev/null
> +++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
> @@ -0,0 +1,207 @@
> +/*
> + * Copyright (C) 2011 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +/*
> + * Basic tests for setxattr(2) and make sure setxattr(2) handles error
> + * conditions correctly.
> + *
> + * There are 7 test cases:
> + * 1. Any other flags being set except XATTR_CREATE and XATTR_REPLACE,
> + *    setxattr(2) should return -1 and set errno to EINVAL
> + * 2. With XATTR_REPLACE flag set but the attribute does not exist,
> + *    setxattr(2) should return -1 and set errno to ENOATTR
> + * 3. Create new attr with name length greater than XATTR_NAME_MAX(255)
> + *    setxattr(2) should return -1 and set errno to ERANGE
> + * 4. Create new attr whose value length is greater than XATTR_SIZE_MAX(65536)
> + *    setxattr(2) should return -1 and set errno to E2BIG
> + * 5. Create new attr whose value length is zero,
> + *    setxattr(2) should succeed
> + * 6. Replace the attr value without XATTR_REPLACE flag being set,
> + *    setxattr(2) should return -1 and set errno to EEXIST
> + * 7. Replace attr value with XATTR_REPLACE flag being set,
> + *    setxattr(2) should succeed
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <attr/xattr.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +
> +#define XATTR_NAME_MAX 255
> +#define XATTR_NAME_LEN (XATTR_NAME_MAX + 2)
> +#define XATTR_SIZE_MAX 65536
> +#define XATTR_TEST_KEY "user.testkey"
> +#define XATTR_TEST_VALUE "this is a test value"
> +#define NR_TEST 7
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +char *TCID = "setxattr01";
> +char filename[BUFSIZ];
> +char long_key[XATTR_NAME_LEN];
> +char *long_value;
> +int TST_TOTAL = NR_TEST;
> +
> +struct test_case {
> +	char *fname;
> +	char *key;
> +	char *value;
> +	size_t size;
> +	int flags;
> +	int exp_err;
> +};
> +struct test_case tc[NR_TEST];
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	int i;
> +	char *msg;
> +	char *tname;
> +	char *tkey;
> +	char *tvalue;
> +	size_t tsize;
> +	int tflags;
> +	int texp_err;
> +
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		for (i = 0; i < NR_TEST; i++)	{
> +			tname = tc[i].fname;
> +			tkey = tc[i].key;
> +			tvalue = tc[i].value;
> +			tsize = tc[i].size;
> +			tflags = tc[i].flags;
> +			texp_err = tc[i].exp_err;
> +
> +			TEST(setxattr(tname, tkey, tvalue, tsize, tflags));
> +
> +			if (TEST_ERRNO == texp_err) {
> +				tst_resm(TPASS, "expected behavior - errno = %d"
> +				    " : %s", TEST_ERRNO, strerror(TEST_ERRNO));

You can use TTERRNO flag together with TPASS to print TEST_ERRNO

> +			} else {
> +				tst_resm(TFAIL, "unexpected behavior - %d : %s "
> +				    "- expected %d", TEST_ERRNO,
> +				    strerror(TEST_ERRNO), texp_err);
> +			}

Here as well.

> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	int fd;
> +	int i;
> +
> +	tst_require_root(NULL);
> +
> +	tst_tmpdir();
> +
> +	/* Test for xattr support */
> +	fd = creat("testfile", 0644);
> +	if (fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create testfile failed");
> +	close(fd);
> +	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
> +		if (errno == ENOTSUP)
> +			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
> +			    "mount without user_xattr option");
> +
> +	/* Create test file */
> +	snprintf(filename, BUFSIZ, "setxattr01testfile");
> +	fd = creat(filename, 0644);
> +	if (fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
> +		    filename);
> +	close(fd);
> +
> +	/* Prepare test cases */
> +	memset(tc, 0, NR_TEST * sizeof(tc[0]));
> +	for (i = 0; i < NR_TEST; i++) {
> +		tc[i].fname = filename;
> +		tc[i].key = XATTR_TEST_KEY;
> +		tc[i].value = XATTR_TEST_VALUE;
> +		tc[i].size = strlen(XATTR_TEST_VALUE);
> +		tc[i].flags = XATTR_CREATE;
> +	}
> +
> +	tc[0].flags = ~0;
> +	tc[0].exp_err = EINVAL;
> +
> +	tc[1].flags = XATTR_REPLACE;
> +	tc[1].exp_err = ENOATTR;
> +
> +	snprintf(long_key, 6, "%s", "user.");
> +	memset(long_key + 5, 'k', XATTR_NAME_LEN - 5);
> +	long_key[XATTR_NAME_LEN - 1] = '\0';
> +	tc[2].key = long_key;
> +	tc[2].exp_err = ERANGE;
> +
> +	long_value = malloc(XATTR_SIZE_MAX + 2);
> +	if (!long_value)
> +		tst_brkm(TBROK | TERRNO, cleanup, "malloc failed");
> +	memset(long_value, 'v', XATTR_SIZE_MAX + 2);
> +	long_value[XATTR_SIZE_MAX + 1] = '\0';
> +	tc[3].value = long_value;
> +	tc[3].size = XATTR_SIZE_MAX + 1;
> +	tc[3].exp_err = E2BIG;
> +
> +	tc[4].size = 0;
> +	tc[4].exp_err = 0;
> +
> +	tc[5].exp_err = EEXIST;
> +
> +	tc[6].flags = XATTR_REPLACE;
> +	tc[6].exp_err = 0;

Hmm is there any reason why most of this couldn't be statically
initalized as it's usually done in the most of the testcases?

The only part that is not static value seems to be the malloc().

> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
