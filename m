Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CE5C3DA49
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 06:57:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 257F23D1D7C
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 08:57:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0BE63CEB69
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 08:57:24 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99F0C600B1A
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 08:57:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 566441F7CF;
 Tue, 30 Jul 2024 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722322639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NLfu7jOxV8N1zxJCBWXjC+Ku/Ae1uVHFdtNMrMx+vI=;
 b=Jss5FCi4EplNX7RxNZ6h6TPV8weXZ/ySSxb8f1LT8Apd5btVpuJGG4F8rLrvyYpwXX6DM6
 iV39mXs95IXavHm+0XF9Zy+B0ZprTa8pbdAhRA7B4NT0H0pOTBfdi3pcYxR8xUMem207JM
 izDF9xYXJRMibQ+ikT5j4KWGP3rgqCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722322639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NLfu7jOxV8N1zxJCBWXjC+Ku/Ae1uVHFdtNMrMx+vI=;
 b=J6jf8IMuFQH9CTc7FYgXAs87m1kEDQRi0N4jgOUc4npB6jU3ZEyczy6QGwCkNG/5fYfrib
 RN66cTgxpMnFz9CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722322639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NLfu7jOxV8N1zxJCBWXjC+Ku/Ae1uVHFdtNMrMx+vI=;
 b=Jss5FCi4EplNX7RxNZ6h6TPV8weXZ/ySSxb8f1LT8Apd5btVpuJGG4F8rLrvyYpwXX6DM6
 iV39mXs95IXavHm+0XF9Zy+B0ZprTa8pbdAhRA7B4NT0H0pOTBfdi3pcYxR8xUMem207JM
 izDF9xYXJRMibQ+ikT5j4KWGP3rgqCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722322639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NLfu7jOxV8N1zxJCBWXjC+Ku/Ae1uVHFdtNMrMx+vI=;
 b=J6jf8IMuFQH9CTc7FYgXAs87m1kEDQRi0N4jgOUc4npB6jU3ZEyczy6QGwCkNG/5fYfrib
 RN66cTgxpMnFz9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3830A13983;
 Tue, 30 Jul 2024 06:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7ANqDM+OqGaDZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jul 2024 06:57:19 +0000
Date: Tue, 30 Jul 2024 08:57:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240730065715.GA1314377@pevik>
References: <20240424092357.11207-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240424092357.11207-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add rename15 test
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

Hi Andrea,

...
> +++ b/runtest/smoketest
> @@ -10,7 +10,7 @@ write01 write01
>  symlink01 symlink01
>  stat04 symlink01 -T stat04
>  utime01A symlink01 -T utime01
> -rename01A symlink01 -T rename01
> +rename15 rename15
FYI this needs to be rebased now.

>  splice02 splice02 -s 20
>  df01_sh df01.sh
>  shell_test01 echo "SUCCESS" | shell_pipe01.sh
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b9dd9fec6..f515d46aa 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1156,7 +1156,6 @@ removexattr01 removexattr01
>  removexattr02 removexattr02

>  rename01 rename01
> -rename01A symlink01 -T rename01
>  rename03 rename03
>  rename04 rename04
>  rename05 rename05
> @@ -1169,6 +1168,7 @@ rename11 rename11
>  rename12 rename12
>  rename13 rename13
>  rename14 rename14
> +rename15 rename15

>  #renameat test cases
nit: maybe while at it remove this useless comment above?

>  renameat01 renameat01
> diff --git a/testcases/kernel/syscalls/rename/.gitignore b/testcases/kernel/syscalls/rename/.gitignore
> index f95cf7d21..d17b80f09 100644
> --- a/testcases/kernel/syscalls/rename/.gitignore
> +++ b/testcases/kernel/syscalls/rename/.gitignore
> @@ -11,3 +11,4 @@
>  /rename12
>  /rename13
>  /rename14
> +/rename15
> diff --git a/testcases/kernel/syscalls/rename/rename15.c b/testcases/kernel/syscalls/rename/rename15.c
> new file mode 100644
> index 000000000..d410758a2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rename/rename15.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
very nit:
*  Authors: David Fenner, Jon Hendrickson
 * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that rename() is working correctly on symlink()
> + * generated files.
> + */
> +
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +#define OLDNAME "msymlink0"
> +#define NEWNAME "asymlink0"
> +
> +static char *tmpdir;
> +
> +static void test_existing(void)
> +{
> +	tst_res(TINFO, "Test rename() on symlink pointing to an existent path");
> +
> +	struct stat oldsym_stat;
> +	struct stat newsym_stat;
> +
> +	SAFE_SYMLINK(tmpdir, OLDNAME);
> +	SAFE_STAT(OLDNAME, &oldsym_stat);
> +
> +	SAFE_RENAME(OLDNAME, NEWNAME);
> +	SAFE_STAT(NEWNAME, &newsym_stat);
> +
> +	TST_EXP_EQ_LI(oldsym_stat.st_ino, newsym_stat.st_ino);
> +	TST_EXP_EQ_LI(oldsym_stat.st_dev, newsym_stat.st_dev);
> +
> +	SAFE_UNLINK(NEWNAME);
> +}
> +
> +static void test_non_existing(void)
> +{
> +	tst_res(TINFO, "Test rename() on symlink pointing to a non-existent path");
> +
> +	struct stat path_stat;
> +
> +	SAFE_SYMLINK("this_path_doesnt_exist", OLDNAME);
> +	TST_EXP_FAIL(stat(OLDNAME, &path_stat), ENOENT);
> +
> +	SAFE_RENAME(OLDNAME, NEWNAME);
> +	TST_EXP_FAIL(stat(NEWNAME, &path_stat), ENOENT);
> +
> +	SAFE_UNLINK(NEWNAME);
> +}
> +
> +static void test_creat(void)
> +{
> +	tst_res(TINFO, "Test rename() on symlink pointing to a path created lately");
> +
> +	char *objpath = "object";
nit: why not above:
#define OBJPATH "object"
and use this definition.
Not really important, but definitions are more common and you would be
consistent.

> +	struct stat path_stat;
	int fd;
(see below)

> +
> +	SAFE_SYMLINK(objpath, OLDNAME);
> +	TST_EXP_FAIL(stat(OLDNAME, &path_stat), ENOENT);
> +
> +	tst_res(TINFO, "Create object file");
> +
> +	SAFE_CREAT(objpath, 0700);
> +	SAFE_RENAME(OLDNAME, NEWNAME);
> +	TST_EXP_PASS(stat(NEWNAME, &path_stat));
> +
> +	SAFE_UNLINK(objpath);
> +	SAFE_UNLINK(NEWNAME);

You need to close(), because with too high -i it fails:

./rename15 -i1200
rename15.c:25: TINFO: Test rename() on symlink pointing to an existent path
rename15.c:36: TPASS: oldsym_stat.st_ino == newsym_stat.st_ino (92519)
rename15.c:37: TPASS: oldsym_stat.st_dev == newsym_stat.st_dev (40)
rename15.c:59: TINFO: Test rename() on symlink pointing to a path created lately
rename15.c:65: TPASS: stat(OLDNAME, &path_stat) : ENOENT (2)
rename15.c:67: TINFO: Create object file
rename15.c:69: TBROK: creat(object,0700) failed: EMFILE (24)

	fd = SAFE_CREAT(OBJPATH, 0700);
	if (fd >= 0)
		SAFE_CLOSE(fd);

> +}
> +
> +static void run(void)
> +{
> +	test_existing();
> +	test_creat();
> +	test_non_existing();
> +}
> +
> +static void setup(void)
> +{
> +	tmpdir = tst_get_tmpdir();
This will need to be replaced to tst_tmpdir_path();

> +}
> +
> +static void cleanup(void)
> +{
> +	free(tmpdir);
> +}
And you now don't need a cleanup function now (done by library).

With fixed this and -i and ideally with the other diff below (but it is up to
you) you may add:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_tmpdir = 1,
I also wonder why we don't run this on all filesystems as we do on most of other
rename tests.
> +};

Kind regards,
Petr

diff --git testcases/kernel/syscalls/rename/rename15.c testcases/kernel/syscalls/rename/rename15.c
index d410758a20..8bda162e56 100644
--- testcases/kernel/syscalls/rename/rename15.c
+++ testcases/kernel/syscalls/rename/rename15.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *    Author: David Fenner
- *    Copilot: Jon Hendrickson
- * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ * Authors: David Fenner, Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*\
@@ -16,6 +15,7 @@
 #include <stdlib.h>
 #include "tst_test.h"
 
+#define OBJPATH "object"
 #define OLDNAME "msymlink0"
 #define NEWNAME "asymlink0"
 
@@ -59,19 +59,22 @@ static void test_creat(void)
 {
 	tst_res(TINFO, "Test rename() on symlink pointing to a path created lately");
 
-	char *objpath = "object";
 	struct stat path_stat;
+	int fd;
 
-	SAFE_SYMLINK(objpath, OLDNAME);
+	SAFE_SYMLINK(OBJPATH, OLDNAME);
 	TST_EXP_FAIL(stat(OLDNAME, &path_stat), ENOENT);
 
 	tst_res(TINFO, "Create object file");
 
-	SAFE_CREAT(objpath, 0700);
+	fd = SAFE_CREAT(OBJPATH, 0700);
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+
 	SAFE_RENAME(OLDNAME, NEWNAME);
 	TST_EXP_PASS(stat(NEWNAME, &path_stat));
 
-	SAFE_UNLINK(objpath);
+	SAFE_UNLINK(OBJPATH);
 	SAFE_UNLINK(NEWNAME);
 }
 
@@ -84,17 +87,11 @@ static void run(void)
 
 static void setup(void)
 {
-	tmpdir = tst_get_tmpdir();
-}
-
-static void cleanup(void)
-{
-	free(tmpdir);
+	tmpdir = tst_tmpdir_path();
 }
 
 static struct tst_test test = {
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = run,
 	.needs_tmpdir = 1,
 };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
