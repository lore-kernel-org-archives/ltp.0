Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A71C3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:47:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2B2F3D1F47
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:47:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C9643CF05B
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:47:28 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B4B21401202
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:47:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 190A921AE1;
 Fri,  2 Aug 2024 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722588447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGQm5aseZQ92LZ+31Fyh+WJEjHbPh+bYz0T8zisIahM=;
 b=punWnkV+4Dqb5E8Z3hmOyuDQYl263QpeNdw1UoNZHSSkGcLEQYI0MmHyqL24GhkWtu0NKM
 e/GufgOzciS7vdF1lIXbusbhSqoq0LSnt4dvaqlsZyUlgnyrZgOGxcbUrqIBrV4K2jfyle
 NMQoZf9SZYSMobqXhXcyt6cTKXAMi5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722588447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGQm5aseZQ92LZ+31Fyh+WJEjHbPh+bYz0T8zisIahM=;
 b=IvWjx9lGJPbx84tLDx+Sc6OrgUcO6VpVCNkWZk9mwKmoKduJpqx/Xxj43rFYRUCX/+y5Iw
 fbOpSuaIT9yNqADQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722588447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGQm5aseZQ92LZ+31Fyh+WJEjHbPh+bYz0T8zisIahM=;
 b=punWnkV+4Dqb5E8Z3hmOyuDQYl263QpeNdw1UoNZHSSkGcLEQYI0MmHyqL24GhkWtu0NKM
 e/GufgOzciS7vdF1lIXbusbhSqoq0LSnt4dvaqlsZyUlgnyrZgOGxcbUrqIBrV4K2jfyle
 NMQoZf9SZYSMobqXhXcyt6cTKXAMi5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722588447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGQm5aseZQ92LZ+31Fyh+WJEjHbPh+bYz0T8zisIahM=;
 b=IvWjx9lGJPbx84tLDx+Sc6OrgUcO6VpVCNkWZk9mwKmoKduJpqx/Xxj43rFYRUCX/+y5Iw
 fbOpSuaIT9yNqADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE37B13999;
 Fri,  2 Aug 2024 08:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rKyrNx6drGYTHQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 02 Aug 2024 08:47:26 +0000
Date: Fri, 2 Aug 2024 10:47:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240802084727.GA1602775@pevik>
References: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
 <20240802-fchmodat2-v5-4-bff2ec1a4f06@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240802-fchmodat2-v5-4-bff2ec1a4f06@suse.com>
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.com:email]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/5] Add fchmodat2_01 test
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This test verifies that fchmodat2() syscall is properly working with
> AT_SYMLINK_NOFOLLOW on regular files. When AT_SYMLINK_NOFOLLOW is used
> on symbolic links instead, we check for EOPNOTSUPP, since the feature is
> not implemented for VFS.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                   |   2 +
>  testcases/kernel/syscalls/fchmodat2/.gitignore     |   1 +
>  testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
>  testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 123 +++++++++++++++++++++
>  4 files changed, 133 insertions(+)

> diff --git a/runtest/syscalls b/runtest/syscalls
> index 9b3cba667..50298d01e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -270,6 +270,8 @@ fchmod06 fchmod06
>  fchmodat01 fchmodat01
>  fchmodat02 fchmodat02

> +fchmodat2_01 fchmodat2_01
> +
>  fchown01 fchown01
>  fchown01_16 fchown01_16
>  fchown02 fchown02
> diff --git a/testcases/kernel/syscalls/fchmodat2/.gitignore b/testcases/kernel/syscalls/fchmodat2/.gitignore
> new file mode 100644
> index 000000000..47d5e2427
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchmodat2/.gitignore
> @@ -0,0 +1 @@
> +fchmodat2_01
> diff --git a/testcases/kernel/syscalls/fchmodat2/Makefile b/testcases/kernel/syscalls/fchmodat2/Makefile
> new file mode 100644
> index 000000000..8cf1b9024
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchmodat2/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> new file mode 100644
> index 000000000..d12c4a8fd
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that fchmodat2() syscall is properly working with
> + * regular files, symbolic links and directories. AT_SYMLINK_NOFOLLOW is a
> + * special feature that is not enabled in VFS for symbolic links, so we only
> + * verify that EOPNOTSUPP is correctly raised when used on those particular
> + * files.

If you don't mind, I'll add here explicit note that change done in 5d1f903f75a8.

> + */
> +
> +#include "tst_test.h"
> +#include "tst_safe_file_at.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/stat.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FNAME "myfile"
> +#define SNAME "symlink"
> +#define DNAME "mydir"
> +#define DNAME_PATH MNTPOINT"/"DNAME
> +
> +static int fd_dir = -1;
> +
> +static void verify_mode(int dirfd, const char *path, mode_t mode)
> +{
> +	struct stat st;
> +
> +	SAFE_FSTATAT(dirfd, path, &st, AT_SYMLINK_NOFOLLOW);
> +	TST_EXP_EQ_LI(st.st_mode, mode);
> +}
> +
> +static void test_regular_file(void)
> +{
> +	tst_res(TINFO, "Using regular files");
> +
> +	SAFE_CHMOD(MNTPOINT"/"FNAME, 0640);
> +
> +	SAFE_FCHMODAT2(fd_dir, FNAME, 0700, 0);
> +	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> +
> +	SAFE_FCHMODAT2(fd_dir, FNAME, 0700, AT_SYMLINK_NOFOLLOW);
> +	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> +}
> +
> +static void test_symbolic_link(void)
> +{
> +	tst_res(TINFO, "Using symbolic link");
> +
> +	SAFE_FCHMODAT2(fd_dir, SNAME, 0700, 0);
> +	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> +	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
> +
> +	if (tst_kvercmp(6, 6, 0)) {
> +		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2,
> +			fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW),
> +			EOPNOTSUPP);
> +	}
I wrote later this is wrong, because the change was backported to all active
stable/LTS trees. We should expect this functionality on all kernels
(tested on 6.6.15, 6.9.9, 6.10.1).

Also, I hesitated, whether we should check AT_SYMLINK_NOFOLLOW also in
safe_fchmodat2(), but we can probably ignore that.

I can change it before merge.

> +}
> +
> +static void test_empty_folder(void)
> +{
> +	tst_res(TINFO, "Using empty folder");
> +
> +	int fd;
> +
> +	SAFE_CHMOD(DNAME_PATH, 0640);
> +	fd = SAFE_OPEN(DNAME_PATH, O_PATH | O_DIRECTORY, 0640);
> +
> +	SAFE_FCHMODAT2(fd, "", 0777, AT_EMPTY_PATH);
> +	verify_mode(fd_dir, DNAME, S_IFDIR | 0777);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void run(void)
> +{
> +	test_regular_file();
> +	test_empty_folder();
> +	test_symbolic_link();
> +}
> +
> +static void setup(void)
> +{
> +	fd_dir = SAFE_OPEN(MNTPOINT, O_PATH | O_DIRECTORY, 0640);
> +
> +	if (access(DNAME_PATH, F_OK) == -1)
> +		SAFE_MKDIR(DNAME_PATH, 0640);
> +
> +	SAFE_TOUCH(MNTPOINT"/"FNAME, 0640, NULL);
> +	SAFE_SYMLINKAT(FNAME, fd_dir, SNAME);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_UNLINKAT(fd_dir, SNAME, 0);
> +	SAFE_RMDIR(DNAME_PATH);
> +
> +	if (fd_dir != -1)
> +		SAFE_CLOSE(fd_dir);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.format_device = 1,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		NULL
> +	},
You were faster than I managed to write. IMHO skipping fuse is not needed.
IMHO it was broken due EOPNOTSUPP.

With these 2 changes:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "5d1f903f75a8"},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
