Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F740CF34A9
	for <ltp@archiver.kernel.org>; Thu,  3 Oct 2024 14:10:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 870EB3C5E10
	for <ltp@archiver.kernel.org>; Thu,  3 Oct 2024 16:10:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E8A63C5A79
 for <ltp@lists.linux.it>; Thu,  3 Oct 2024 16:10:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F5677A9220
 for <ltp@lists.linux.it>; Thu,  3 Oct 2024 16:10:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71FC921D78;
 Thu,  3 Oct 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727964631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goyfEKfGHr25hPU5YP5P/gp9v7rKhOSHY0mG2Qx/JH4=;
 b=SdGICUt/MlWcVTgGMtdZRdsBl+Z+wf0LbP9kQzezcaRBl5sxMlmKixiq7UIevNbOUs9qSV
 FpNM86N84NnvYVB3H/wgfK72rQ36R1vbdh03GA1Eu4VA34NnYybRglslWu5uDHykZ4DhhG
 nQYIjVPoGtOCpluAp4PP3Nz4FDxjrms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727964631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goyfEKfGHr25hPU5YP5P/gp9v7rKhOSHY0mG2Qx/JH4=;
 b=ADZmHDvRAvgIBa3BWG2anmHOhfBo3NTmWRjHemSHPMZDZBfruCvQ8Rtth7lqHVoLrzHJbt
 YS5VNcjiX+h+UPAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727964631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goyfEKfGHr25hPU5YP5P/gp9v7rKhOSHY0mG2Qx/JH4=;
 b=SdGICUt/MlWcVTgGMtdZRdsBl+Z+wf0LbP9kQzezcaRBl5sxMlmKixiq7UIevNbOUs9qSV
 FpNM86N84NnvYVB3H/wgfK72rQ36R1vbdh03GA1Eu4VA34NnYybRglslWu5uDHykZ4DhhG
 nQYIjVPoGtOCpluAp4PP3Nz4FDxjrms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727964631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goyfEKfGHr25hPU5YP5P/gp9v7rKhOSHY0mG2Qx/JH4=;
 b=ADZmHDvRAvgIBa3BWG2anmHOhfBo3NTmWRjHemSHPMZDZBfruCvQ8Rtth7lqHVoLrzHJbt
 YS5VNcjiX+h+UPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C65113882;
 Thu,  3 Oct 2024 14:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JtRHEtel/mZHSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Oct 2024 14:10:31 +0000
Date: Thu, 3 Oct 2024 16:09:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv6llMhdNMQ5Chb6@yuki.lan>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-10-39558204ddf0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909-listmount_statmount-v4-10-39558204ddf0@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 10/13] Add statmount05 test
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
> This test verifies STATMOUNT_MNT_ROOT and STATMOUNT_MNT_POINT
> functionalities of statmount().
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                  |   1 +
>  testcases/kernel/syscalls/statmount/.gitignore    |   1 +
>  testcases/kernel/syscalls/statmount/statmount05.c | 128 ++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e43e53002..9f5a473f3 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1572,6 +1572,7 @@ statmount01 statmount01
>  statmount02 statmount02
>  statmount03 statmount03
>  statmount04 statmount04
> +statmount05 statmount05
>  
>  statfs01 statfs01
>  statfs01_64 statfs01_64
> diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
> index e720050b5..f64763242 100644
> --- a/testcases/kernel/syscalls/statmount/.gitignore
> +++ b/testcases/kernel/syscalls/statmount/.gitignore
> @@ -2,3 +2,4 @@ statmount01
>  statmount02
>  statmount03
>  statmount04
> +statmount05
> diff --git a/testcases/kernel/syscalls/statmount/statmount05.c b/testcases/kernel/syscalls/statmount/statmount05.c
> new file mode 100644
> index 000000000..dd4bb17f0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statmount/statmount05.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies STATMOUNT_MNT_ROOT and STATMOUNT_MNT_POINT functionalities
> + * of statmount(). In particular, STATMOUNT_MNT_ROOT will give the mount root
> + * (i.e. mount --bind /mnt /bla -> /mnt) and STATMOUNT_MNT_POINT will
> + * give the mount point (i.e. mount --bind /mnt /bla -> /bla).
> + *
> + * [Algorithm]
> + *
> + * - create a mount point
> + * - mount a folder inside the mount point
> + * - run statmount() on the mounted folder using STATMOUNT_MNT_ROOT
> + * - read results and check if contain the mount root path
> + * - run statmount() on the mounted folder using STATMOUNT_MNT_POINT
> + * - read results and check if contain the mount point path
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "statmount.h"
> +#include "lapi/stat.h"
> +#include "lapi/sched.h"
> +#include "tst_tmpdir.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define DIRA MNTPOINT "/LTP_DIR_A"
> +#define DIRB MNTPOINT "/LTP_DIR_B"
> +#define SM_SIZE (1 << 10)
> +
> +static uint64_t root_id;
> +static struct statmount *st_mount;
> +static char *mnt_root;
> +static char *mnt_point;
> +
> +static void test_mount_root(void)
> +{
> +	tst_res(TINFO, "Testing STATMOUNT_MNT_ROOT");
> +
> +	char *last_root;
> +
> +	memset(st_mount, 0, SM_SIZE);
> +
> +	TST_EXP_PASS(statmount(root_id, STATMOUNT_MNT_ROOT, st_mount,
> +		SM_SIZE, 0));
> +
> +	if (TST_RET == -1)
> +		return;

if (!TST_PASSED)

> +	last_root = strrchr(mnt_root, '/');
> +
> +	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_ROOT);
> +	TST_EXP_EXPR(strcmp(st_mount->str + st_mount->mnt_root, last_root) == 0,
> +		"statmount() read '%s', expected '%s'",
> +		st_mount->str + st_mount->mnt_root,
> +		last_root);

You have added TST_EXP_EQ_STR() in an subsequent patch, you should use
it here as well.

> +}
> +
> +static void test_mount_point(void)
> +{
> +	tst_res(TINFO, "Testing STATMOUNT_MNT_POINT");
> +
> +	memset(st_mount, 0, SM_SIZE);
> +
> +	TST_EXP_POSITIVE(statmount(root_id, STATMOUNT_MNT_POINT, st_mount,
> +		SM_SIZE, 0));
> +
> +	if (TST_RET == -1)
> +		return;

Here as well.

> +	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_POINT);
> +	TST_EXP_EXPR(strcmp(st_mount->str + st_mount->mnt_point, mnt_point) == 0,
> +		"mount point is '%s'",
> +		st_mount->str + st_mount->mnt_point);

And here as well.

> +}
> +
> +static void run(void)
> +{
> +	test_mount_root();
> +	test_mount_point();
> +}
> +
> +static void setup(void)
> +{
> +	struct ltp_statx sx;
> +
> +	mnt_root = tst_tmpdir_mkpath(DIRA);
> +	mnt_point = tst_tmpdir_mkpath(DIRB);

This was renamed to tst_tmpdir_genpath()

> +	SAFE_MKDIR(mnt_root, 0700);
> +	SAFE_MKDIR(mnt_point, 0700);
> +	SAFE_MOUNT(mnt_root, mnt_point, "none", MS_BIND, NULL);
> +
> +	SAFE_STATX(AT_FDCWD, mnt_point, 0, STATX_MNT_ID_UNIQUE, &sx);
> +	root_id = sx.data.stx_mnt_id;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tst_is_mounted(DIRB))
> +		SAFE_UMOUNT(DIRB);
> +
> +	if (tst_is_mounted(DIRA))
> +		SAFE_UMOUNT(DIRA);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "6.8",
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		NULL
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&st_mount, .size = SM_SIZE},
> +		{}
> +	}
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
