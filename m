Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1B5C2D0D1
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 13:46:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9A063D0F91
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 15:46:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07CD03CFA21
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 15:46:23 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 21BFA60073F
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 15:46:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA2041F7D9;
 Mon, 24 Jun 2024 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719236782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8VuMZFWRoyBiWsDDsI8iTJTYo3FenReZ4FiaiBg1W8=;
 b=vzvI7zb1sWr59JqQN22jSAQEOiVb6OLRkaPgPXzH89SyKAMk6jNs+LbfcsdYlZqvoAjG1J
 LTVOXT+oviUWJdlasH8Loj4Nyaq0/mHcFX+hST9SmFBZ7FJ7C2tOf16AIUKgdUVty2UkEQ
 pTVZyStERICAzItvUQ+krTjZsLvzfk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719236782;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8VuMZFWRoyBiWsDDsI8iTJTYo3FenReZ4FiaiBg1W8=;
 b=U8KnClmIcQrNgG1J7I5oY3Ac3FNpBB58sCN0x+DUyKhqPDObPddmup7wnB8LqDZFb5qGcc
 4amR1d5j+g64WLBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719236781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8VuMZFWRoyBiWsDDsI8iTJTYo3FenReZ4FiaiBg1W8=;
 b=iliPQIuc9gzaGc1YWeaMg7FwkamI+9jYvGqOgrkYw7YP/IXzuatn4AGvXYvgrx+S/10PdP
 l5eALAszjoxJXBLSOaauVqaezE2V5fz3mzasQoExvrBO4lsVFPPGSICRy6wuWH+fsjPwem
 Uo0BoNfizraSw2YIQxoL7TdxddEYu4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719236781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8VuMZFWRoyBiWsDDsI8iTJTYo3FenReZ4FiaiBg1W8=;
 b=dy86MV/MP57doCi6eUZTX2SxnrqehblbIf9+ojDfXST/bfJORpuNzOHjPd47DUJWan4Y7i
 UMowGmUuV5YM42BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8FE613AA4;
 Mon, 24 Jun 2024 13:46:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KMT7L614eWYKewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jun 2024 13:46:21 +0000
Date: Mon, 24 Jun 2024 15:46:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Znl4ozB8fGrAcvtD@yuki>
References: <20240419123137.6731-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240419123137.6731-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add lstat03 test
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
> diff --git a/testcases/kernel/syscalls/lstat/.gitignore b/testcases/kernel/syscalls/lstat/.gitignore
> index a497a445f..72cba871f 100644
> --- a/testcases/kernel/syscalls/lstat/.gitignore
> +++ b/testcases/kernel/syscalls/lstat/.gitignore
> @@ -2,3 +2,5 @@
>  /lstat01_64
>  /lstat02
>  /lstat02_64
> +/lstat03
> +/lstat03_64
> diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
> new file mode 100644
> index 000000000..af852169f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lstat/lstat03.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner, Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that lstat() provides correct information according
> + * with device, access time, block size, ownership, etc.
> + * The implementation provides a set of tests which are specific for each one
> + * of the `struct stat` used to read file and symlink information.
> + */
> +
> +#include "tst_test.h"
> +
> +#define MNTPOINT "mntpoint"
> +
> +static void test_dev(void)
> +{
> +	char *filename = "file_dev";
> +	char *symname = MNTPOINT"/sym_dev";
> +
> +	tst_res(TINFO, "Test symlink device");
> +
> +	SAFE_TOUCH(filename, 0777, NULL);
> +	SAFE_SYMLINK(filename, symname);

I suppose that I missed part of the discussion, but why isn't it
possible to create a single file that has as many things different as
possible in the test setup and simply use it in all tests?

> +	struct stat path;
> +	struct stat link;
> +
> +	TST_EXP_PASS(lstat(filename, &path));
> +	TST_EXP_PASS(lstat(symname, &link));
> +
> +	TST_EXP_EXPR(path.st_dev != link.st_dev, "path.st_dev != link.st_dev");
> +	TST_EXP_EXPR(path.st_ino != link.st_ino, "path.st_ino != link.st_ino");

Hmm, the TST_EXP_EXPR() does not seem to do the stringification as the
rest of the macros and we have to repeat the arguments here. I suppose
that we need:

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 22b39fb14..5e83eeaca 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -340,8 +340,9 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
                        &tst_exp_err__, 1, ##__VA_ARGS__);                     \
        } while (0)
 
-#define TST_EXP_EXPR(EXPR, FMT, ...)                                           \
-       tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: " FMT, ##__VA_ARGS__);
+#define TST_EXP_EXPR(EXPR, ...)                                                    \
+       tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "     \
+                TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, #EXPR), __VA_ARGS__))
 
 #define TST_EXP_EQ_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {\
        TYPE tst_tmp_a__ = VAL_A; \
diff --git a/testcases/kernel/syscalls/fork/fork04.c b/testcases/kernel/syscalls/fork/fork04.c
index b0c6bebe0..413cd5eb4 100644
--- a/testcases/kernel/syscalls/fork/fork04.c
+++ b/testcases/kernel/syscalls/fork/fork04.c
@@ -29,7 +29,7 @@ static void run_child(void)
 
        TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
                "%s environ variable has been inherited by the child",
-               ENV_KEY)
+               ENV_KEY);
 
        tst_res(TINFO, "Unset %s environ variable inside child", ENV_KEY);
 
@@ -72,7 +72,7 @@ static void run(void)
        } else {
                TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
                        "%s environ variable is still present inside parent",
-                       ENV_KEY)
+                       ENV_KEY);
        }
 
        TST_CHECKPOINT_WAKE_AND_WAIT(0);
@@ -85,7 +85,7 @@ static void run(void)
        else {
                TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
                        "%s environ variable didn't change inside parent",
-                       ENV_KEY)
+                       ENV_KEY);
        }
 }


> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_nlink(void)
> +{
> +	char *filename = "file_nlink";
> +	char *symname = "sym_nlink";
> +
> +	tst_res(TINFO, "Test symlink hard link");
> +
> +	SAFE_TOUCH(filename, 0777, NULL);

We should link the filename to a different name here.

> +	SAFE_SYMLINK(filename, symname);
> +
> +	struct stat path;
> +	struct stat link;
> +
> +	TST_EXP_PASS(lstat(filename, &path));
> +	TST_EXP_PASS(lstat(symname, &link));
> +
> +	TST_EXP_EQ_LI(path.st_nlink, link.st_nlink);

And then this would be actually different, which is what we should test
for.

> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_ownership(void)
> +{
> +	char *filename = "file_all";
> +	char *symname = "sym_ownership";
> +
> +	tst_res(TINFO, "Test symlink ownership");
> +
> +	SAFE_TOUCH(filename, 0777, NULL);
> +	SAFE_SYMLINK(filename, symname);
> +
> +	SAFE_CHOWN(symname, 1000, 1000);
> +
> +	struct stat path;
> +	struct stat link;
> +
> +	TST_EXP_PASS(lstat(filename, &path));
> +	TST_EXP_PASS(lstat(symname, &link));
> +
> +	TST_EXP_EXPR(path.st_uid != link.st_uid, "path.st_uid != link.st_uid");
> +	TST_EXP_EXPR(path.st_gid != link.st_gid, "path.st_gid != link.st_gid");
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_filesize(void)
> +{
> +	char *filename = "file_size";
> +	char *symname = "sym_size";
> +	int fd;
> +
> +	tst_res(TINFO, "Test symlink filesize");
> +
> +	SAFE_TOUCH(filename, 0777, NULL);
> +
> +	fd = SAFE_OPEN(filename, O_WRONLY, 0777);
> +	tst_fill_fd(fd, 'a', TST_KB, 500);
> +	SAFE_CLOSE(fd);
> +
> +	SAFE_SYMLINK(filename, symname);
> +
> +	struct stat path;
> +	struct stat link;
> +
> +	TST_EXP_PASS(lstat(filename, &path));
> +	TST_EXP_PASS(lstat(symname, &link));
> +
> +	TST_EXP_EXPR(path.st_size != link.st_size, "path.st_size != link.st_size");
> +	TST_EXP_EXPR(path.st_blocks != link.st_blocks, "path.st_blocks != link.st_blocks");
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_blksize(void)
> +{
> +	char *filename = "file_blksize";
> +	char *symname = MNTPOINT"/sym_blksize";
> +
> +	tst_res(TINFO, "Test symlink blksize");
> +
> +	SAFE_TOUCH(filename, 0777, NULL);
> +	SAFE_SYMLINK(filename, symname);
> +
> +	struct stat path;
> +	struct stat link;
> +
> +	TST_EXP_PASS(lstat(filename, &path));
> +	TST_EXP_PASS(lstat(symname, &link));
> +
> +	TST_EXP_EXPR(path.st_blksize != link.st_blksize, "path.st_blksize != link.st_blksize");
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_timestamp(void)
> +{
> +	char *filename = "file_timestamp";
> +	char *symname = "sym_timestamp";
> +
> +	tst_res(TINFO, "Test symlink timestamp");
> +
> +	SAFE_TOUCH(filename, 0777, NULL);
> +
> +	/* we wait a bit before creating symlink in order to obtain
> +	 * different timestamp values
> +	 */
> +	sleep(1);
> +	SAFE_SYMLINK(filename, symname);

This should really be done in the test setup, since as it is now the
test would sleep for 1 second for each iteration with -i.

> +	struct stat path;
> +	struct stat link;
> +
> +	TST_EXP_PASS(lstat(filename, &path));
> +	TST_EXP_PASS(lstat(symname, &link));
> +
> +	TST_EXP_EXPR(path.st_atime != link.st_atime, "path.st_atime != link.st_atime");
> +	TST_EXP_EXPR(path.st_mtime != link.st_mtime, "path.st_mtime != link.st_mtime");
> +	TST_EXP_EXPR(path.st_ctime != link.st_ctime, "path.st_ctime != link.st_ctime");
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void run(void)
> +{
> +	test_dev();
> +	test_nlink();
> +	test_ownership();
> +	test_filesize();
> +	test_blksize();
> +	test_timestamp();
> +}
> +
> +static void setup(void)
> +{
> +	char opt_bsize[32];
> +	const char *const fs_opts[] = {opt_bsize, NULL};
> +	struct stat sb;
> +	int pagesize;
> +
> +	SAFE_STAT(".", &sb);
> +	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
> +
> +	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tst_is_mounted(MNTPOINT))
> +		SAFE_UMOUNT(MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.needs_device = 1,
> +	.mntpoint = MNTPOINT,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
