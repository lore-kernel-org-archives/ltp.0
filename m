Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DFAEB64DE
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 14:21:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E5C23C1B7B
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 16:21:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57F383C1AEC
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 16:21:26 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 91EC61401250
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 16:21:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AD0E1F816;
 Tue, 10 Sep 2024 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725978084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpi+9wfOhRJJYcUYgoIKk5AM6GmMPCExpumocCWc5Vw=;
 b=qZ/T/tTiOTGH5xf/j0cMHm6Gh8HCq/paRfkvGkBlKDBJFO9yjMgxl/knBcNwKSHWCcrUii
 ctotCnr2vFHikVFG/5qeUlEW0+RyVkLyqHTYfeTLXXO9bACr8yO9f3pKrC/oRrxHPUqtUr
 Ref0HxRTHpEaR9ADmkLkEPcePjoI9I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725978084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpi+9wfOhRJJYcUYgoIKk5AM6GmMPCExpumocCWc5Vw=;
 b=RmUN+HcIGZMSpqXPRlUCdd4PyJtsPw2EEi6AZbr7A55pc1UVuzMNMnkFR1GOQIOQGxLhar
 ylhV8GnWxJIXVYDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725978084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpi+9wfOhRJJYcUYgoIKk5AM6GmMPCExpumocCWc5Vw=;
 b=qZ/T/tTiOTGH5xf/j0cMHm6Gh8HCq/paRfkvGkBlKDBJFO9yjMgxl/knBcNwKSHWCcrUii
 ctotCnr2vFHikVFG/5qeUlEW0+RyVkLyqHTYfeTLXXO9bACr8yO9f3pKrC/oRrxHPUqtUr
 Ref0HxRTHpEaR9ADmkLkEPcePjoI9I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725978084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpi+9wfOhRJJYcUYgoIKk5AM6GmMPCExpumocCWc5Vw=;
 b=RmUN+HcIGZMSpqXPRlUCdd4PyJtsPw2EEi6AZbr7A55pc1UVuzMNMnkFR1GOQIOQGxLhar
 ylhV8GnWxJIXVYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A95EA132CB;
 Tue, 10 Sep 2024 14:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PhmGH+NV4GakLwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Sep 2024 14:21:23 +0000
Date: Tue, 10 Sep 2024 16:20:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZuBVmXDo99opXjdk@yuki.lan>
References: <20240801135023.22125-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240801135023.22125-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add rename15 test
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
> This test has been extracted from symlink01 and it verifies that
> rename() is working correctly on symlink() generated files, renaming
> symbolic link and checking if stat() information are preserved.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> - tst_tmpdir_path/tst_tmpdir_mkpath usage
> - use absolute paths
> - add all_filesystems = 1
> 
>  runtest/syscalls                            |   2 +-
>  testcases/kernel/syscalls/rename/.gitignore |   1 +
>  testcases/kernel/syscalls/rename/rename15.c | 109 ++++++++++++++++++++
>  3 files changed, 111 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/kernel/syscalls/rename/rename15.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 9b3cba667..6028c57c3 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1173,7 +1173,6 @@ removexattr01 removexattr01
>  removexattr02 removexattr02
>  
>  rename01 rename01
> -rename01A symlink01 -T rename01
>  rename03 rename03
>  rename04 rename04
>  rename05 rename05
> @@ -1186,6 +1185,7 @@ rename11 rename11
>  rename12 rename12
>  rename13 rename13
>  rename14 rename14
> +rename15 rename15
>  
>  #renameat test cases
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
> index 000000000..234632879
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rename/rename15.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Authors: David Fenner, Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that rename() is working correctly on symlink()
> + * generated files.
> + */
> +
> +#include "tst_test.h"
> +#include "tst_tmpdir.h"
> +
> +#define MNTPOINT "mnt"
> +#define OLDNAME MNTPOINT"/msymlink0"
> +#define NEWNAME MNTPOINT"/asymlink0"
> +#define OBJNAME MNTPOINT"/object"
> +
> +static char *tmpdir;
> +static char *oldname;
> +static char *newname;
> +static char *objname;
> +
> +static void test_existing(void)
> +{
> +	tst_res(TINFO, "Test rename() on symlink pointing to an existent path");
> +
> +	struct stat oldsym_stat;
> +	struct stat newsym_stat;
> +
> +	SAFE_SYMLINK(tmpdir, oldname);
> +	SAFE_STAT(oldname, &oldsym_stat);
> +
> +	SAFE_RENAME(oldname, newname);
> +	SAFE_STAT(newname, &newsym_stat);
> +
> +	TST_EXP_EQ_LI(oldsym_stat.st_ino, newsym_stat.st_ino);
> +	TST_EXP_EQ_LI(oldsym_stat.st_dev, newsym_stat.st_dev);

Here we should test that the oldname is not there anymore.

> +	SAFE_UNLINK(newname);
> +}
> +
> +static void test_non_existing(void)
> +{
> +	tst_res(TINFO, "Test rename() on symlink pointing to a non-existent path");
> +
> +	struct stat path_stat;
> +
> +	SAFE_SYMLINK("this_path_doesnt_exist", oldname);
> +	TST_EXP_FAIL(stat(oldname, &path_stat), ENOENT);
> +
> +	SAFE_RENAME(oldname, newname);
> +	TST_EXP_FAIL(stat(newname, &path_stat), ENOENT);

I guess that we should use lstat() here to at least make sure that the
symlinks are present when they should be.

> +	SAFE_UNLINK(newname);
> +}
> +
> +static void test_creat(void)
> +{
> +
> +	tst_res(TINFO, "Test rename() on symlink pointing to a path created lately");
> +
> +	struct stat path_stat;
> +
> +	SAFE_SYMLINK(objname, oldname);
> +	TST_EXP_FAIL(stat(oldname, &path_stat), ENOENT);
> +
> +	tst_res(TINFO, "Create object file");
> +
> +	int fd;
> +
> +	fd = SAFE_CREAT(objname, 0700);
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +
> +	SAFE_RENAME(oldname, newname);
> +	TST_EXP_PASS(stat(newname, &path_stat));

Shouldn't we also check here that:

- oldname is not there anymore
- objname is still there

> +	SAFE_UNLINK(objname);
> +	SAFE_UNLINK(newname);
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
> +	tmpdir = tst_tmpdir_path();
> +	oldname = tst_tmpdir_mkpath(OLDNAME);
> +	newname = tst_tmpdir_mkpath(NEWNAME);
> +	objname = tst_tmpdir_mkpath(OBJNAME);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.all_filesystems = 1,
> +	.mntpoint = MNTPOINT,
> +	.format_device = 1,
> +	.needs_root = 1,
> +};
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
