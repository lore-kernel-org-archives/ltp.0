Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8571CC001E0
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 14:53:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 819E43C8BBF
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 16:53:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38E9E3C4BC7
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 16:53:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2E6E81A02391
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 16:53:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 51F522184B;
 Thu, 10 Aug 2023 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691679198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBmlQVFnrCZS/IXyzb15uVcwypMNr7WVZ2CNWcdagSM=;
 b=JIlR6UDjbfcsoekR25/i/rGKWV0Vt7voxIrDfo3GP6V3G+mzT2c0BbPN8ytgQPXu4rb5s+
 C+WotVHq50n8wxDc+1wlWvhgqNYuqX2Puj4ERBiwPZu7Llbwt01Us7fshCpQxomgXQl2NX
 u2mGoBn7fNRF3PznlQ2Y5q+TONrxVE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691679198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBmlQVFnrCZS/IXyzb15uVcwypMNr7WVZ2CNWcdagSM=;
 b=OzlawWPVCblnFh77dAGAl5cGOZYXfi/1p8Uv28OiVLxI9rWVxTNsn2NvWe7a2eblawsg6P
 p6XNqP0sGNU6sOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3335E138E0;
 Thu, 10 Aug 2023 14:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id y90xC9751GT8EAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Aug 2023 14:53:18 +0000
Date: Thu, 10 Aug 2023 16:54:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZNT6GkZ05CrGk5pV@yuki>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1691208482-5464-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1691208482-5464-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/faccessat201: Add new testcase
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
> diff --git a/include/lapi/faccessat2.h b/include/lapi/faccessat2.h
> new file mode 100644
> index 000000000..e8b27d6b1
> --- /dev/null
> +++ b/include/lapi/faccessat2.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef LAPI_FACCESSAT2_H__
> +#define LAPI_FACCESSAT2_H__
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#ifndef HAVE_FACCESSAT2
> +int faccessat2(int dirfd, const char *pathname, int mode, int flags)
> +{
> +	return tst_syscall(__NR_faccessat2, dirfd, pathname, mode, flags);
> +}
> +#endif
> +
> +#endif /* LAPI_FACCESSAT2_H__ */

This one needs the configure check, and I would call the header just
faccessat.h.

> diff --git a/testcases/kernel/syscalls/faccessat2/faccessat201.c b/testcases/kernel/syscalls/faccessat2/faccessat201.c
> new file mode 100644
> index 000000000..658d1dd81
> --- /dev/null
> +++ b/testcases/kernel/syscalls/faccessat2/faccessat201.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Check the basic functionality of faccessat2().
> + *
> + * Minimum Linux version required is v5.8.
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <pwd.h>
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/faccessat2.h"
> +
> +#define TESTUSER	"nobody"
> +#define TESTDIR		"faccessat2dir"
> +#define TESTFILE	"faccessat2file"
> +#define	RELPATH		"faccessat2dir/faccessat2file"
> +#define TESTSYMLINK	"faccessat2symlink"

There is a mix of tabs and spaces in this part that should be cleaned
up.

> +static int dir_fd = -1, bad_fd = -1;
> +static int atcwd_fd = AT_FDCWD;
> +static char *filepaths[4];
> +static char abs_path[128];
> +static struct passwd *ltpuser;
> +
> +static struct tcase {
> +	int *fd;
> +	char **filename;
> +	int flags;
> +	int exp_errno;
> +} tcases[] = {
> +	{&dir_fd, &filepaths[0], 0, 0},
> +	{&bad_fd, &filepaths[1], 0, 0},
> +	{&atcwd_fd, &filepaths[2], 0, 0},
> +	{&dir_fd, &filepaths[0], AT_EACCESS, 0},
> +	{&bad_fd, &filepaths[1], AT_EACCESS, 0},
> +	{&atcwd_fd, &filepaths[2], AT_EACCESS, 0},
> +	{&dir_fd, &filepaths[0], AT_EACCESS, EACCES},
> +	{&bad_fd, &filepaths[1], AT_EACCESS, EACCES},
> +	{&atcwd_fd, &filepaths[2], AT_EACCESS, EACCES},
> +	{&atcwd_fd, &filepaths[3], AT_SYMLINK_NOFOLLOW, 0},
> +};
> +
> +static void verify_faccessat2(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	if (tc->exp_errno == EACCES) {
> +		if (SAFE_FORK() == 0) {
> +			SAFE_SETUID(ltpuser->pw_uid);
> +			TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename, R_OK, tc->flags),
> +				    tc->exp_errno, "faccessat2(%d, %s, R_OK, %d) as %s",
> +				    *tc->fd, *tc->filename, tc->flags, TESTUSER);
> +		}
> +
> +		tst_reap_children();

I would just put the EACCESS tests to a separate testcase, which would
make the test more straightforward and easier to read.

> +	} else {
> +		TST_EXP_PASS(faccessat2(*tc->fd, *tc->filename, R_OK, tc->flags),
> +			     "faccessat2(%d, %s, R_OK, %d) as root",
> +			     *tc->fd, *tc->filename, tc->flags);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	char *tmpdir_path = tst_get_tmpdir();
> +
> +	sprintf(abs_path, "%s/%s", tmpdir_path, RELPATH);
> +	free(tmpdir_path);
> +
> +	SAFE_MKDIR(TESTDIR, 0666);
> +	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
> +	SAFE_TOUCH(abs_path, 0444, NULL);
> +	SAFE_SYMLINK(abs_path, TESTSYMLINK);
> +
> +	filepaths[0] = TESTFILE;
> +	filepaths[1] = abs_path;
> +	filepaths[2] = RELPATH;
> +	filepaths[3] = TESTSYMLINK;
> +
> +	ltpuser = SAFE_GETPWNAM(TESTUSER);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (dir_fd > 0)
> +		SAFE_CLOSE(dir_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_faccessat2,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&filepaths[0], .size = sizeof(*filepaths[0])},
> +		{&filepaths[1], .size = sizeof(*filepaths[1])},
> +		{&filepaths[2], .size = sizeof(*filepaths[2])},
> +		{&filepaths[3], .size = sizeof(*filepaths[3])},
> +		{&ltpuser, .size = sizeof(ltpuser)},

Why do we allocate anything here when we replace the pointers in the
test setup anyways?

If anything it would make sense to allocate the buffers in the test
setup instead of using static strings there. Also filepath[x] way less
readable than actually giving the variables proper names such as
abs_path.

I guess that we can as well add a helper to the buffer library such as:

diff --git a/include/tst_buffers.h b/include/tst_buffers.h
index d19ac8cf0..a12d70a62 100644
--- a/include/tst_buffers.h
+++ b/include/tst_buffers.h
@@ -46,6 +46,11 @@ char *tst_strdup(const char *str);
  */
 void *tst_alloc(size_t size);
 
+/*
+ * Strdup into a guarded buffer.
+ */
+char *tst_strdup(const char *str);
+
 /*
  * Allocates iovec structure including the buffers.
  *
diff --git a/lib/tst_buffers.c b/lib/tst_buffers.c
index b8b597a12..4488f458e 100644
--- a/lib/tst_buffers.c
+++ b/lib/tst_buffers.c
@@ -76,6 +76,13 @@ void *tst_alloc(size_t size)
        return ret + map->buf_shift;
 }
 
+char *tst_strup(const char *str)
+{
+       char *ret = tst_alloc(strlen(str) + 1);
+
+       return strcpy(ret, str);
+}
+
 static int count_iovec(int *sizes)
 {
        int ret = 0;


And slightly more complicated would be addition of tst_aprintf() that
would printf into buffer allocated by tst_alloc(). I will send a patch
that adds this tomorrow.

Once that is done we can use these in the test setup such as:

static char *abs_path;
static char *testfile;

static struct tcase {
     int *fd;
     char **filename;
     int flags;
     int exp_errno;
} tcases[] = {
     {..., &abs_path, ...},
     {..., &testfile, ...},
}

static void setup(void)
{
	...

	testfile = tst_strdup(TESTFILE);
	abs_path = tst_aprintf(abs_path, "%s/%s", tmpdir_path, TESTFILE);

	...
}

Which allocates the exact sized guarded buffers so that the canaries are
exaclty after end of the data, not at the end of the rather large
buffer.

We can't pre-allocate buffers in the tst_test structure for data whose
size is not known in advance, which is the case for the tmpdir_path.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
