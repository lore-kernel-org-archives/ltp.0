Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7F3C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 14:03:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 789F83CA5A9
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 16:03:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92F123C9482
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 16:02:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DDAA61000984
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 16:02:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34E7E210F1;
 Wed, 27 Apr 2022 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651068177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ld74/Z6T4es5GC6WkIulw0uTUjWPu717EjtqtECXhQw=;
 b=P17y4q/R3GPtQx8GhmWQTdPRyqG/KuO8Myd3RRH1thCdTfNoBCA9fQp8MwL4Hf4Mnd6dq9
 q/BJdfkD91NMNv03hlaefLf1NyZ1QjKmfXttlaxALUD5bxAlrVo8+/kmFyu8BoUdX9d7rq
 +HIPFD8UyfydO8GDVZuy+5mPbjFKmqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651068177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ld74/Z6T4es5GC6WkIulw0uTUjWPu717EjtqtECXhQw=;
 b=/EpX1od5w6vNJ0In9Lroz7e1V8qXJ9QVedCVrrHPvZUebz75rm8dD3c4ptqrB8pv3yXsH8
 4pnbd4kwraTFYkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F76D13A39;
 Wed, 27 Apr 2022 14:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YAOtBxFNaWIHawAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 27 Apr 2022 14:02:57 +0000
Date: Wed, 27 Apr 2022 16:05:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Message-ID: <YmlNmOQ2okZgpOlo@yuki>
References: <20220427083814.1100-1-chenhx.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220427083814.1100-1-chenhx.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/mount_setattr01: Add basic functional
 test
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@fujitsu.com>
> + * Author: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic mount_setattr() test.
> + * Test whether the basic mount attributes are set correctly.
> + *
> + * Verify some MOUNT_SETATTR(2) attributes:
> + *
> + * - 1) MOUNT_ATTR_RDONLY - makes the mount read-only
> + * - 2) MOUNT_ATTR_NOSUID - causes the mount not to honor the
> + *     set-user-ID and set-group-ID mode bits and file capabilities
> + *     when executing programs.
> + * - 3) MOUNT_ATTR_NODEV - prevents access to devices on this mount
> + * - 4) MOUNT_ATTR_NOEXEC - prevents executing programs on this mount
> + * - 5) MOUNT_ATTR_NOSYMFOLLOW - prevents following symbolic links
> + *    on this mount
> + * - 6) MOUNT_ATTR_NODIRATIME - prevents updating access time for
> + *    directories on this mount

The numbers here are useless and confusing I bet that it renders
strangely in asciidoc too.

> + * The functionality was added in v5.12.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/statvfs.h>
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "lapi/stat.h"
> +
> +#define MNTPOINT        "mntpoint"
> +#define OT_MNTPOINT     "ot_mntpoint"
> +#define TCASE_ENTRY(attrs, exp_attrs)   \
> +	{                                \
> +		.name = #attrs,                 \
> +		.mount_attrs = attrs,           \
> +		.expect_attrs = exp_attrs       \
> +	}
> +
> +static int mount_flag, otfd = -1;
> +
> +static struct tcase {
> +	char *name;
> +	unsigned int mount_attrs;
> +	unsigned int expect_attrs;
> +} tcases[] = {
> +	TCASE_ENTRY(MOUNT_ATTR_RDONLY, ST_RDONLY),
> +	TCASE_ENTRY(MOUNT_ATTR_NOSUID, ST_NOSUID),
> +	TCASE_ENTRY(MOUNT_ATTR_NODEV, ST_NODEV),
> +	TCASE_ENTRY(MOUNT_ATTR_NOEXEC, ST_NOEXEC),
> +	TCASE_ENTRY(MOUNT_ATTR_NOSYMFOLLOW, ST_NOSYMFOLLOW),
> +	TCASE_ENTRY(MOUNT_ATTR_NODIRATIME, ST_NODIRATIME),
> +};
> +
> +static void cleanup(void)
> +{
> +	if (otfd > -1)
> +		SAFE_CLOSE(otfd);
> +	if (mount_flag)
> +		SAFE_UMOUNT(OT_MNTPOINT);
> +}
> +
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +	struct stat st = {0};
> +
> +	if (stat(OT_MNTPOINT, &st) == -1)
> +		SAFE_MKDIR(OT_MNTPOINT, 0777);
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	struct mount_attr attr = {
> +		.attr_set = tc->mount_attrs,
> +	};
> +	struct statvfs buf;
> +
> +	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
> +		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
> +	if (!TST_PASS)
> +		return;
> +
> +	otfd = (int)TST_RET;
> +
> +	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
> +		"%s set", tc->name);
> +	if (!TST_PASS)
> +		goto out;
> +
> +	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> +	if (!TST_PASS)
> +		goto out;
> +	mount_flag = 1;
> +
> +	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
> +	if (!TST_PASS)
> +		goto out;
> +
> +	if (buf.f_flag & tc->expect_attrs)
> +		tst_res(TPASS, "%s is actually set as expected", tc->name);
> +	else
> +		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
> +
> +out:
> +	if (otfd > -1)
> +		SAFE_CLOSE(otfd);
> +	if (tst_is_mounted_at_tmpdir(OT_MNTPOINT)) {
> +		mount_flag = 0;
> +		SAFE_UMOUNT(OT_MNTPOINT);
> +	}

Can we instead of the ifs just jump to a right label as I asked in the
previous review?

> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []){"fuse", NULL},
> +};
> -- 
> 2.35.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
