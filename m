Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76A7C32771
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 12:53:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A7693CAD4B
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 14:53:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 179F23CAC3E
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 14:53:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 272382009F4
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 14:53:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BA5A21AA8;
 Wed, 21 Sep 2022 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663764789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwS0MfvkGQUGMLoN7P+vFJeFEHyDmpV1esCnHJr6cB8=;
 b=LW5/Q/OCcR/qZQGJXRG9M6a4hLFP4iBqH0rd67HUbKdqmv+YF6FYFwi10RyG22wYCtjtlg
 ob/hhwY9io6u93QsRzdV+2om/rmb1fjEZj9u4K+iy+5HtDsXB5DSkZsLA03oYydu1vXOpX
 5HkcY9teUeoIjTA/ihVqzKb3N8AZbgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663764789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwS0MfvkGQUGMLoN7P+vFJeFEHyDmpV1esCnHJr6cB8=;
 b=ZH/MxAx1pircRgnnx6Xn8ippJxqgQW7YYmxhrIpYbluF+Hd3gUR+Hd75eAfiSjzcQuRh7V
 uYQfYfmWWuC8XyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C52813A89;
 Wed, 21 Sep 2022 12:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oyX/FDUJK2OPKwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 21 Sep 2022 12:53:09 +0000
Date: Wed, 21 Sep 2022 14:55:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <YysJqtHzakYDOW50@yuki>
References: <20220825143819.311023-1-tudor.cretu@arm.com>
 <20220825143819.311023-2-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220825143819.311023-2-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] syscalls/statfs02,
 fstatfs02: Convert to new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Refactor statfs02 and fstatfs02 to the new LTP API.

Give that we are getting close to release I did fix the remaning
problems and pushed the patches, thanks. See below for details.

> Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
> ---
>  testcases/kernel/syscalls/fstatfs/fstatfs02.c | 102 +++++-------------
>  testcases/kernel/syscalls/statfs/statfs02.c   |  97 ++++-------------
>  2 files changed, 47 insertions(+), 152 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> index db2230f82..4267bd02b 100644
> --- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> +++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> @@ -1,37 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
>  
>  /*
> - * DESCRIPTION
> + * [Description]
>   *	Testcase to check fstatfs() sets errno correctly.
>   */

This is not proper documentation comment. Documentation comment has to
start with /*\ and the content is asciidoc formatted.

> -#include <sys/vfs.h>
> +#include <errno.h>
>  #include <sys/types.h>
>  #include <sys/statfs.h>
> -#include <errno.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -char *TCID = "fstatfs02";
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>  
>  static struct statfs buf;
>  
> @@ -39,76 +21,40 @@ static struct test_case_t {
>  	int fd;
>  	struct statfs *sbuf;
>  	int error;
> -} TC[] = {
> +} tests[] = {
>  	/* EBADF - fd is invalid */
> -	{
> -	-1, &buf, EBADF},
> +	{-1, &buf, EBADF},
>  #ifndef UCLINUX
> -	    /* Skip since uClinux does not implement memory protection */
> -	    /* EFAULT - address for buf is invalid */
> -	{
> -	-1, (void *)-1, EFAULT}
> +	/* Skip since uClinux does not implement memory protection */
> +	/* EFAULT - address for buf is invalid */
> +	{-1, (void *)-1, EFAULT},
>  #endif

UCLINUX does not exists anymore so we are removing all UCLINUX ifdefs
when cleaning up tests.

>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(TC);
> -
> -int main(int ac, char **av)
> +static void fstatfs_verify(unsigned int n)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			TEST(fstatfs(TC[i].fd, TC[i].sbuf));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == TC[i].error) {
> -				tst_resm(TPASS, "expected failure - "
> -					 "errno = %d : %s", TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TFAIL, "unexpected error - %d : %s - "
> -					 "expected %d", TEST_ERRNO,
> -					 strerror(TEST_ERRNO), TC[i].error);
> -			}
> -		}
> -	}
> -	cleanup();
> -
> -	tst_exit();
> +	TST_EXP_FAIL(fstatfs(tests[n].fd, tests[n].sbuf), tests[n].error, "fstatfs()");
>  }
>  
>  static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
>  #ifndef UCLINUX
> -	TC[1].fd = SAFE_OPEN(cleanup, "tempfile", O_RDWR | O_CREAT, 0700);
> +	tests[1].fd = SAFE_OPEN("tempfile", O_RDWR | O_CREAT, 0700);
>  #endif

Indexing the the tests array like this is frowned upon, we usually use
pointers in the test structure instead.

>  }
>  
>  static void cleanup(void)
>  {
>  #ifndef UCLINUX
> -	if (TC[1].fd > 0 && close(TC[1].fd))
> -		tst_resm(TWARN | TERRNO, "Failed to close fd");
> +	if (tests[1].fd > 0 && close(tests[1].fd))
> +		tst_res(TWARN | TERRNO, "Failed to close fd");

This should be just:

	if (fd > 0)
		SAFE_CLOSE();

>  #endif
> -
> -	tst_rmdir();
>  }
> +
> +static struct tst_test test = {
> +	.test = fstatfs_verify,
> +	.tcnt = ARRAY_SIZE(tests),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};
> diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
> index 279665f86..f906c84ff 100644
> --- a/testcases/kernel/syscalls/statfs/statfs02.c
> +++ b/testcases/kernel/syscalls/statfs/statfs02.c
> @@ -1,24 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
>   *	07/2001 Ported by Wayne Boyer
>   *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
>  
>  /*
> - * DESCRIPTION
> + * [Description]
>   *	1.	Use a component of the pathname, which is not a directory
>   *		in the "path" parameter to statfs(). Expect ENOTDIR
>   *	2.	Pass a filename which doesn't exist, and expect ENOENT.
> @@ -32,25 +20,19 @@
>   *		ELOOP.
>   */

Here as well, it has to start with /*\ and asciidoc formatted

> -#include <sys/types.h>
> -#include <sys/statfs.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <sys/vfs.h>
> -#include <sys/mman.h>
>  #include <errno.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "statfs02";
> -
> -static int fd;
> +#include <fcntl.h>
> +#include <sys/statfs.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>  
>  #define TEST_FILE		"statfs_file"
>  #define TEST_FILE1		TEST_FILE"/statfs_file1"
>  #define TEST_NOEXIST		"statfs_noexist"
>  #define TEST_SYMLINK		"statfs_symlink"
>  
> +static int fd;
>  static char test_toolong[PATH_MAX+2];
>  static struct statfs buf;
>  
> @@ -58,7 +40,7 @@ static struct test_case_t {
>  	char *path;
>  	struct statfs *buf;
>  	int exp_error;
> -} TC[] = {
> +} tests[] = {
>  	{TEST_FILE1, &buf, ENOTDIR},
>  	{TEST_NOEXIST, &buf, ENOENT},
>  	{test_toolong, &buf, ENAMETOOLONG},
> @@ -69,72 +51,39 @@ static struct test_case_t {
>  	{TEST_SYMLINK, &buf, ELOOP},
>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(TC);
>  static void setup(void);
>  static void cleanup(void);

These two are useless now.

> -static void statfs_verify(const struct test_case_t *);
>
> -int main(int ac, char **av)
> +static void statfs_verify(unsigned int n)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		for (i = 0; i < TST_TOTAL; i++)
> -			statfs_verify(&TC[i]);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_FAIL(statfs(tests[n].path, tests[n].buf), tests[n].exp_error, "statfs()");
>  }
>  
>  static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	fd = SAFE_CREAT(cleanup, TEST_FILE, 0444);
> +	fd = SAFE_CREAT(TEST_FILE, 0444);
>  
>  	memset(test_toolong, 'a', PATH_MAX+1);
>  
>  #if !defined(UCLINUX)
> -	TC[3].path = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
> +	tests[3].path = SAFE_MMAP(0, 1, PROT_NONE,
>  			       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>  #endif

And here as well.

Full diff:

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index 4267bd02b..7f8fb760f 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -3,9 +3,10 @@
  * Copyright (c) International Business Machines  Corp., 2001
  */
 
-/*
+/*\
  * [Description]
- *	Testcase to check fstatfs() sets errno correctly.
+ *
+ * Testcase to check if fstatfs() sets errno correctly.
  */
 
 #include <errno.h>
@@ -17,38 +18,32 @@
 
 static struct statfs buf;
 
+static int fd;
+static int bad_fd = -1;
+
 static struct test_case_t {
-	int fd;
+	int *fd;
 	struct statfs *sbuf;
 	int error;
 } tests[] = {
-	/* EBADF - fd is invalid */
-	{-1, &buf, EBADF},
-#ifndef UCLINUX
-	/* Skip since uClinux does not implement memory protection */
-	/* EFAULT - address for buf is invalid */
-	{-1, (void *)-1, EFAULT},
-#endif
+	{&bad_fd, &buf, EBADF},
+	{&fd, (void *)-1, EFAULT},
 };
 
 static void fstatfs_verify(unsigned int n)
 {
-	TST_EXP_FAIL(fstatfs(tests[n].fd, tests[n].sbuf), tests[n].error, "fstatfs()");
+	TST_EXP_FAIL(fstatfs(*tests[n].fd, tests[n].sbuf), tests[n].error, "fstatfs()");
 }
 
 static void setup(void)
 {
-#ifndef UCLINUX
-	tests[1].fd = SAFE_OPEN("tempfile", O_RDWR | O_CREAT, 0700);
-#endif
+	fd = SAFE_OPEN("tempfile", O_RDWR | O_CREAT, 0700);
 }
 
 static void cleanup(void)
 {
-#ifndef UCLINUX
-	if (tests[1].fd > 0 && close(tests[1].fd))
-		tst_res(TWARN | TERRNO, "Failed to close fd");
-#endif
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index f906c84ff..143063f19 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -5,19 +5,15 @@
  *
  */
 
-/*
+/*\
  * [Description]
- *	1.	Use a component of the pathname, which is not a directory
- *		in the "path" parameter to statfs(). Expect ENOTDIR
- *	2.	Pass a filename which doesn't exist, and expect ENOENT.
- *	3.	Pass a pathname which is more than MAXNAMLEN, and expect
- *		ENAMETOOLONG.
- *	4.	Pass a pointer to the pathname outside the address space of
- *		the process, and expect EFAULT.
- *	5.	Pass a pointer to the buf paramter outside the address space
- *		of the process, and expect EFAULT.
- *	6.	Pass a filename which has too many symbolic links, and expect
- *		ELOOP.
+ *
+ * - ENOTDIR A component of the pathname, which is not a directory.
+ * - ENOENT A filename which doesn't exist.
+ * - ENAMETOOLONG A pathname which is longer than MAXNAMLEN.
+ * - EFAULT A pathname pointer outside the address space of the process.
+ * - EFAULT A buf pointer outside the address space of the process.
+ * - ELOOP A filename which has too many symbolic links.
  */
 
 #include <errno.h>
@@ -44,16 +40,11 @@ static struct test_case_t {
 	{TEST_FILE1, &buf, ENOTDIR},
 	{TEST_NOEXIST, &buf, ENOENT},
 	{test_toolong, &buf, ENAMETOOLONG},
-#ifndef UCLINUX
 	{(char *)-1, &buf, EFAULT},
 	{TEST_FILE, (struct statfs *)-1, EFAULT},
-#endif
 	{TEST_SYMLINK, &buf, ELOOP},
 };
 
-static void setup(void);
-static void cleanup(void);
-
 static void statfs_verify(unsigned int n)
 {
 	TST_EXP_FAIL(statfs(tests[n].path, tests[n].buf), tests[n].exp_error, "statfs()");
@@ -61,14 +52,16 @@ static void statfs_verify(unsigned int n)
 
 static void setup(void)
 {
+	unsigned int i;
+
 	fd = SAFE_CREAT(TEST_FILE, 0444);
 
 	memset(test_toolong, 'a', PATH_MAX+1);
 
-#if !defined(UCLINUX)
-	tests[3].path = SAFE_MMAP(0, 1, PROT_NONE,
-			       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-#endif
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (tests[i].path == (char *)-1)
+			tests[i].path = tst_get_bad_addr(NULL);
+	}
 
 	SAFE_SYMLINK(TEST_SYMLINK, "statfs_symlink_2");
 	SAFE_SYMLINK("statfs_symlink_2", TEST_SYMLINK);


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
