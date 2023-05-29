Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747BFC77B7A
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 17:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4DE63CD02C
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 19:51:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8B483CA768
 for <ltp@lists.linux.it>; Mon, 29 May 2023 19:50:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E71FA100034E
 for <ltp@lists.linux.it>; Mon, 29 May 2023 19:50:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73E3321A60;
 Mon, 29 May 2023 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685382650;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEewmK9bf0m3l0msjIvOYyWhZl81PVhGMIq3d5VXeyY=;
 b=n8Wj8xxE2/9p5ucFiehCaahYuSAhZilgs07fSv31YssnlLaFmj3fIxpb1YkpPE99C8cxjH
 peqT6ohq0y/UGKofMyLz6yx2g7fTkMy2X3yKytD3CoFFuP7wPIQZV8DUpUjWjj6A9AN/R2
 MJsYHpOQEneiIRjL7N64DSAiUKcJpmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685382650;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEewmK9bf0m3l0msjIvOYyWhZl81PVhGMIq3d5VXeyY=;
 b=ZQdYABPuPlRetqDCI5K6VSaj9Dl1JcQnvu69GwQfQ9cHp7MGRpoVnSOhtXQKNaZb/3EZ7g
 GJnyEegXHnCoCzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5067713466;
 Mon, 29 May 2023 17:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ADSWEfrldGTnZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 May 2023 17:50:50 +0000
Date: Mon, 29 May 2023 19:50:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230529175048.GA2021@pevik>
References: <1684748642-6373-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1684748642-6373-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx12: Add basic test for
 STATX_ATTR_MOUNT_ROOT flag
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

I tested it on recent kernel 6.3.1 and very old kernel 3.16.0.
Works as expected.


> This flag was introduced since kernel 5.10 and was used to indicates

80340fe3605c ("statx: add mount_root") was released in v5.8. Unless you refer to
something different, please update it here.

> whether the path or fd refers to the root of a mount or not.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  include/lapi/stat.h                        |   4 +
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/statx/.gitignore |   1 +
>  testcases/kernel/syscalls/statx/statx12.c  | 101 +++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/statx/statx12.c

> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index c7e6fdac0..3606c9eb0 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -221,6 +221,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>  # define STATX_ATTR_AUTOMOUNT	0x00001000
>  #endif

> +#ifndef STATX_ATTR_MOUNT_ROOT
> +# define STATX_ATTR_MOUNT_ROOT	0x00002000
> +#endif
> +
>  #ifndef STATX_ATTR_VERITY
>  # define STATX_ATTR_VERITY	0x00100000
>  #endif
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e5ad2c2f9..0c1993421 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1767,6 +1767,7 @@ statx08 statx08
>  statx09 statx09
>  statx10 statx10
>  statx11 statx11
> +statx12 statx12

>  membarrier01 membarrier01

> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index 48ac4078b..f6a423eed 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -9,3 +9,4 @@
>  /statx09
>  /statx10
>  /statx11
> +/statx12
> diff --git a/testcases/kernel/syscalls/statx/statx12.c b/testcases/kernel/syscalls/statx/statx12.c
> new file mode 100644
> index 000000000..ae6bbb1e2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx12.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * It is a basic test for STATX_ATTR_MOUNT_ROOT flag.
> + *
> + * This flag indicates whether the path or fd refers to the root of a mount
> + * or not.
> + *
> + * Minimum Linux version required is v5.10.
And here as well.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/mount.h>
Do we need these two for anything?

> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "lapi/stat.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define TESTFILE MNTPOINT"/testfile"
> +
> +static int dir_fd = -1, file_fd = -1;
> +
> +static struct tcase {
> +	const char *path;
> +	int mnt_root;
> +	int flag;
Since you're already using <stdbool.h>, mnt_root and flag could be bool.
> +	int *fd;
> +} tcases[] = {
> +	{MNTPOINT, 1, 1, &dir_fd},
> +	{MNTPOINT, 1, 0, &dir_fd},
> +	{TESTFILE, 0, 1, &file_fd},
> +	{TESTFILE, 0, 0, &file_fd}
I'd even consider replacing int flag in struct with counted from n:

static struct tcase {
	const char *path;
	bool mnt_root;
	int *fd;
} tcases[] = {
	{MNTPOINT, 1, &dir_fd},
	{TESTFILE, 0, &file_fd}
};

static void verify_statx(unsigned int n)
{
	struct tcase *tc = &tcases[n/2];
	struct statx buf;
	bool flag = n % 2;

	if (flag) {
		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
				tc->path);
		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
	} else {
		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
				tc->path);

		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
	}
	...

static struct tst_test test = {
	...
	.tcnt = 2* ARRAY_SIZE(tcases)


> +};
> +
> +static void verify_statx(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	struct statx buf;
> +
> +	if (tc->flag) {
> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
> +				tc->path);
> +
> +		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
> +			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
nit: I wonder if we need to duplicate the call in string, just to get tc->path,
which we have printed in TINFO above. Wouldn't be enough just:
		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));

> +	} else {
> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
> +				tc->path);
> +		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
> +			"statx(%d, "", 0, 0, &buf)", *tc->fd);
Well, here you probably meant
		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
			"statx(%d, \"\", 0, 0, &buf)", *tc->fd);
checkpatch.pl (via make check-statx12) warns about it (slightly cryptic):
statx12.c:60: WARNING: Consecutive strings are generally better as a single string
TODO: this is the second thing which should be fixed before merge.

But again, I'd go just for:
		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
> +	}
> +
> +	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
> +		tst_res(TCONF, "Filesystem does not support STATX_ATTR_MOUNT_ROOT");
> +		return;
> +	}
> +
> +	if (buf.stx_attributes & STATX_ATTR_MOUNT_ROOT) {
> +		tst_res(tc->mnt_root ? TPASS : TFAIL,
> +			"STATX_ATTR_MOUNT_ROOT flag is set");
> +	} else {
> +		tst_res(tc->mnt_root ? TFAIL : TPASS,
> +			"STATX_ATTR_MOUNT_ROOT flag is not set");
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_CREAT(TESTFILE, 0755);
> +	dir_fd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
> +	file_fd = SAFE_OPEN(TESTFILE, O_RDWR);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (dir_fd > -1)
> +		SAFE_CLOSE(dir_fd);
nit: Here could be empty line (readability).
> +	if (file_fd > -1)
> +		SAFE_CLOSE(file_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_statx,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.needs_root = 1,
> +	.tcnt = ARRAY_SIZE(tcases)
> +};

All my suggestion (ok to ignore).

Kind regards,
Petr

diff --git testcases/kernel/syscalls/statx/statx12.c testcases/kernel/syscalls/statx/statx12.c
index 40367c8b1..6b76b6e49 100644
--- testcases/kernel/syscalls/statx/statx12.c
+++ testcases/kernel/syscalls/statx/statx12.c
@@ -12,12 +12,10 @@
  * This flag indicates whether the path or fd refers to the root of a mount
  * or not.
  *
- * Minimum Linux version required is v5.10.
+ * Minimum Linux version required is v5.8.
  */
 
 #define _GNU_SOURCE
-#include <sys/types.h>
-#include <sys/mount.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdbool.h>
@@ -32,32 +30,27 @@ static int dir_fd = -1, file_fd = -1;
 
 static struct tcase {
 	const char *path;
-	int mnt_root;
-	int flag;
+	bool mnt_root;
 	int *fd;
 } tcases[] = {
-	{MNTPOINT, 1, 1, &dir_fd},
-	{MNTPOINT, 1, 0, &dir_fd},
-	{TESTFILE, 0, 1, &file_fd},
-	{TESTFILE, 0, 0, &file_fd}
+	{MNTPOINT, 1, &dir_fd},
+	{TESTFILE, 0, &file_fd}
 };
 
 static void verify_statx(unsigned int n)
 {
-	struct tcase *tc = &tcases[n];
+	struct tcase *tc = &tcases[n/2];
 	struct statx buf;
+	bool flag = n % 2;
 
-	if (tc->flag) {
-		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
+	if (flag) {
+		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
 				tc->path);
-
-		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
-			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
+		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
 	} else {
-		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
+		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
 				tc->path);
-		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
-			"statx(%d, "", 0, 0, &buf)", *tc->fd);
+		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
 	}
 
 	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
@@ -85,6 +78,7 @@ static void cleanup(void)
 {
 	if (dir_fd > -1)
 		SAFE_CLOSE(dir_fd);
+
 	if (file_fd > -1)
 		SAFE_CLOSE(file_fd);
 }
@@ -97,5 +91,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.needs_root = 1,
-	.tcnt = ARRAY_SIZE(tcases)
+	.tcnt = 2* ARRAY_SIZE(tcases)
 };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
