Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8C1C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 14:28:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 890DA3D3870
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 16:28:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16FEF3D3818
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 16:27:50 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 30A7810006B2
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 16:27:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11DEF21BD7;
 Wed, 10 Jul 2024 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720621669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQuWwKDFhnQiaLpew+daBhKBrxMyrtkYm3iGY/xDd4g=;
 b=Fw7+QOgU/jTgoibQYjdy4e0UjbGI/XSeWUb4G3LtwgwZnjmNV5YLn0kVQkIrApvxbsw8qB
 3qXVGl7DlR3zyt6AbcvjRk8p5Di7oee5go1qqqXATES5isHqEaVR0bRLJxCFrOznBdYS78
 9i37z6r/bfd/Tp9JF3D+Oic66CAisXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720621669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQuWwKDFhnQiaLpew+daBhKBrxMyrtkYm3iGY/xDd4g=;
 b=9JDAwxhVjaUYEEfa27LgWGm+ecel6OXvQVw8iaMmX8vXR5IhHubTCI8EMGajrpKg1yAyo3
 EI8iXIeVQRxhdfCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720621669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQuWwKDFhnQiaLpew+daBhKBrxMyrtkYm3iGY/xDd4g=;
 b=Fw7+QOgU/jTgoibQYjdy4e0UjbGI/XSeWUb4G3LtwgwZnjmNV5YLn0kVQkIrApvxbsw8qB
 3qXVGl7DlR3zyt6AbcvjRk8p5Di7oee5go1qqqXATES5isHqEaVR0bRLJxCFrOznBdYS78
 9i37z6r/bfd/Tp9JF3D+Oic66CAisXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720621669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQuWwKDFhnQiaLpew+daBhKBrxMyrtkYm3iGY/xDd4g=;
 b=9JDAwxhVjaUYEEfa27LgWGm+ecel6OXvQVw8iaMmX8vXR5IhHubTCI8EMGajrpKg1yAyo3
 EI8iXIeVQRxhdfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 022171369A;
 Wed, 10 Jul 2024 14:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yeESAGWajmbbOwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jul 2024 14:27:49 +0000
Date: Wed, 10 Jul 2024 16:27:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zo6aXATzHGRaPt46@yuki>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
 <20240516-listmount_statmount-v3-9-2ff4ba29bba7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240516-listmount_statmount-v3-9-2ff4ba29bba7@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/11] Add statmount04 test
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
> This test verifies that statmount() is correctly reading propagation
> from what mount in current namespace using STATMOUNT_PROPAGATE_FROM.
> ---
>  runtest/syscalls                                  |   1 +
>  testcases/kernel/syscalls/statmount/.gitignore    |   1 +
>  testcases/kernel/syscalls/statmount/statmount04.c | 131 ++++++++++++++++++++++
>  3 files changed, 133 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6eba317de..81c2f9740 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1541,6 +1541,7 @@ stat04_64 symlink01 -T stat04_64
>  statmount01 statmount01
>  statmount02 statmount02
>  statmount03 statmount03
> +statmount04 statmount04
>  
>  statfs01 statfs01
>  statfs01_64 statfs01_64
> diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
> index 2a02bf721..e720050b5 100644
> --- a/testcases/kernel/syscalls/statmount/.gitignore
> +++ b/testcases/kernel/syscalls/statmount/.gitignore
> @@ -1,3 +1,4 @@
>  statmount01
>  statmount02
>  statmount03
> +statmount04
> diff --git a/testcases/kernel/syscalls/statmount/statmount04.c b/testcases/kernel/syscalls/statmount/statmount04.c
> new file mode 100644
> index 000000000..6ca7ab4d0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statmount/statmount04.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that statmount() is correctly reading propagation from
> + * what mount in current namespace using STATMOUNT_PROPAGATE_FROM.
> + *
> + * [Algorithm]
> + *
> + * * create a mount point
> + * * propagate a mounted folder inside the mount point
> + * * run statmount() on the mount point using STATMOUNT_PROPAGATE_FROM
> + * * read results and check propagated_from parameter contains the propagated
> + *   folder ID

Again dashes please.

> + */
> +
> +#include "statmount.h"
> +#include "lapi/stat.h"
> +#include "lapi/sched.h"
> +#include "tst_safe_stdio.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define DIR_A MNTPOINT "/LTP_DIR_A"
> +#define DIR_C_SUBFOLDER "/LTP_DIR_A/propagated"
> +#define DIR_C (MNTPOINT DIR_C_SUBFOLDER)
> +#define DIR_B MNTPOINT "/LTP_DIR_B"
> +#define DIR_D MNTPOINT "/LTP_DIR_B/propagated"
> +
> +static uint64_t peer_group_id;
> +static uint64_t dird_id;
> +static struct statmount *st_mount;
> +
> +static int read_peer_group(void)
> +{
> +	FILE *file;
> +	char line[PATH_MAX];
> +	char mroot[PATH_MAX];
> +	int group = -1;
> +
> +	file = SAFE_FOPEN("/proc/self/mountinfo", "r");
> +
> +	while (fgets(line, sizeof(line), file)) {
> +		if (sscanf(line, "%*d %*d %*d:%*d %s %*s %*s shared:%d", mroot, &group) != 2)
> +			continue;
> +
> +		if (strcmp(mroot, DIR_C_SUBFOLDER) == 0)
> +			break;
> +	}
> +
> +	if (group == -1)
> +		tst_brk(TBROK, "Can't reed peer group ID for %s", DIR_C_SUBFOLDER);
                                        ^
					read

Also I'm wondering if we simply cannot call statmount() to get basic
info for DIR_C_SUBFOLDER and get the group id from there instead of
parsing proc.

> +	return group;
> +}
> +
> +static void run(void)
> +{
> +	memset(st_mount, 0, sizeof(struct statmount));
> +
> +	TST_EXP_PASS(statmount(
> +		dird_id,
> +		STATMOUNT_PROPAGATE_FROM,
> +		st_mount,
> +		sizeof(struct statmount),
> +		0));

Here as well, strange formatting.

> +	if (TST_RET == -1)
> +		return;
> +
> +	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_PROPAGATE_FROM);
> +	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
> +	TST_EXP_EQ_LI(st_mount->propagate_from, peer_group_id);
> +}
> +
> +static void setup(void)
> +{
> +	struct statx sx;
> +
> +	/* create DIR_A / DIR_C structure with DIR_C mounted */
> +	SAFE_MKDIR(DIR_A, 0700);
> +	SAFE_MOUNT(DIR_A, DIR_A, "none", MS_BIND, NULL);
> +	SAFE_MOUNT("none", DIR_A, "none", MS_SHARED, NULL);
> +
> +	SAFE_MKDIR(DIR_C, 0700);
> +	SAFE_MOUNT(DIR_C, DIR_C, "none", MS_BIND, NULL);
> +	SAFE_MOUNT("none", DIR_C, "none", MS_SHARED, NULL);
> +
> +	/* DIR_A mounts into DIR_B. DIR_D is propagated */
> +	SAFE_MKDIR(DIR_B, 0700);
> +	SAFE_MOUNT(DIR_A, DIR_B, "none", MS_BIND, NULL);
> +	SAFE_MOUNT("none", DIR_B, "none", MS_SLAVE, NULL);
> +
> +	SAFE_STATX(AT_FDCWD, DIR_D, 0, STATX_MNT_ID_UNIQUE, &sx);
> +	dird_id = sx.stx_mnt_id;
> +
> +	peer_group_id = read_peer_group();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tst_is_mounted(DIR_C))
> +		SAFE_UMOUNT(DIR_C);
> +
> +	if (tst_is_mounted(DIR_B))
> +		SAFE_UMOUNT(DIR_B);
> +
> +	if (tst_is_mounted(DIR_A))
> +		SAFE_UMOUNT(DIR_A);

Again I wouldn't bet that umounting once is enough here. If my mental
image is right we have stacked several mounts on each directory.

I wonder how many cycled would this code do?

	while (tst_is_mounted(DIR_A))
		SAFE_UMOUNT(DIR_A);

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
> +		{&st_mount, .size = sizeof(struct statmount)},
> +		{}
> +	}
> +};
> 
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
