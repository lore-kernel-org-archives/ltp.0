Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DADCF6D2C
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 14:46:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 947903C59FF
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 16:46:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95E5F3C575E
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 16:46:38 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 080911001261
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 16:46:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1679821C71;
 Wed,  2 Oct 2024 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727880397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMsRA4jPKMhmMWyazuO2qd8sbWkTYsHwxZidujtbOd4=;
 b=K81S/BtLpMw+KeEw4h+NQ6zyKXjvtB+/iJ28c2tkIPTBeGIcA08JMJgDlgLGGSABIYpOyh
 gTApmZ8dlhpVkGc0g9Q9uvApp0uTNmro1enkHgFn0fWyTrz4qN9uZpR/xyzfo3rqT3c206
 PBgHO3AxWHhQ6b/iEssSPrKQREe58+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727880397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMsRA4jPKMhmMWyazuO2qd8sbWkTYsHwxZidujtbOd4=;
 b=jNKCQBKIxjoxtDyJI5wG5JXVtk97yLy/bjGFJx17f4MtQ5AP/8obVAwSXGw24zJDuS8ki+
 rah2cfRGoZs7HVCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="K81S/BtL";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jNKCQBKI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727880397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMsRA4jPKMhmMWyazuO2qd8sbWkTYsHwxZidujtbOd4=;
 b=K81S/BtLpMw+KeEw4h+NQ6zyKXjvtB+/iJ28c2tkIPTBeGIcA08JMJgDlgLGGSABIYpOyh
 gTApmZ8dlhpVkGc0g9Q9uvApp0uTNmro1enkHgFn0fWyTrz4qN9uZpR/xyzfo3rqT3c206
 PBgHO3AxWHhQ6b/iEssSPrKQREe58+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727880397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMsRA4jPKMhmMWyazuO2qd8sbWkTYsHwxZidujtbOd4=;
 b=jNKCQBKIxjoxtDyJI5wG5JXVtk97yLy/bjGFJx17f4MtQ5AP/8obVAwSXGw24zJDuS8ki+
 rah2cfRGoZs7HVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE48813A6E;
 Wed,  2 Oct 2024 14:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fg4yNMxc/WblNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 02 Oct 2024 14:46:36 +0000
Date: Wed, 2 Oct 2024 16:45:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv1cjyU5YSH-i3UM@yuki.lan>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-6-39558204ddf0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909-listmount_statmount-v4-6-39558204ddf0@suse.com>
X-Rspamd-Queue-Id: 1679821C71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 06/13] Add statmount01 test
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
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef STATMOUNT_H

Here as well, missing #define STATMOUNT_H

> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "lapi/mount.h"
> +#include "lapi/syscalls.h"
> +
> +static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
> +		     size_t bufsize, unsigned int flags)
> +{
> +	struct mnt_id_req req = {
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.mnt_id = mnt_id,
> +		.param = mask,
> +	};
> +
> +	return tst_syscall(__NR_statmount, &req, buf, bufsize, flags);
> +}
> +
> +#endif
> diff --git a/testcases/kernel/syscalls/statmount/statmount01.c b/testcases/kernel/syscalls/statmount/statmount01.c
> new file mode 100644
> index 000000000..95dac5c92
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statmount/statmount01.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that statmount() is working with no mask flags.
> + *
> + * [Algorithm]
> + *
> + * - create a mount point
> + * - run statmount() on the mount point without giving any mask
> + * - read results and check that mask and size are correct
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "statmount.h"
> +#include "lapi/stat.h"
> +#include "lapi/sched.h"
> +
> +#define MNTPOINT "mntpoint"
> +
> +static uint64_t root_id;
> +static struct statmount *st_mount;
> +
> +static void run(void)
> +{
> +	memset(st_mount, 0, sizeof(struct statmount));
> +
> +	TST_EXP_PASS(statmount(root_id, 0, st_mount, sizeof(struct statmount), 0));
> +
> +	if (TST_RET == -1)
> +		return;

Here if (!TST_PASS) as well.

> +	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
> +	TST_EXP_EQ_LI(st_mount->mask, 0);
> +	TST_EXP_EQ_LI(st_mount->sb_dev_major, 0);
> +	TST_EXP_EQ_LI(st_mount->sb_dev_minor, 0);
> +	TST_EXP_EQ_LI(st_mount->sb_magic, 0);
> +	TST_EXP_EQ_LI(st_mount->sb_flags, 0);
> +	TST_EXP_EQ_LI(st_mount->fs_type, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_id, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_parent_id, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_id_old, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_parent_id_old, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_attr, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_propagation, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_peer_group, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_master, 0);
> +	TST_EXP_EQ_LI(st_mount->propagate_from, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_root, 0);
> +	TST_EXP_EQ_LI(st_mount->mnt_point, 0);
> +}
> +
> +static void setup(void)
> +{
> +	struct ltp_statx sx;
> +
> +	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
> +
> +	root_id = sx.data.stx_mnt_id;

Maybe this should be called mntpoint_id to make it less confusing.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.min_kver = "6.8",
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		NULL
> +	},

I'm not sure that it makes sense to run this test for all filesystems,
it's just at test that the returned buffer is untouched/cleared if we do
not request any information. I bet that it does not call any filesystem
specific code at all.

> +	.bufs = (struct tst_buffers []) {
> +		{&st_mount, .size = sizeof(struct statmount)},
> +		{}
> +	}
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
