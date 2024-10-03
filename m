Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3E6CF34A9
	for <ltp@archiver.kernel.org>; Thu,  3 Oct 2024 13:29:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EAE03C5E82
	for <ltp@archiver.kernel.org>; Thu,  3 Oct 2024 15:29:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0DF53C58B9
 for <ltp@lists.linux.it>; Thu,  3 Oct 2024 15:28:45 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2CAE60FB33
 for <ltp@lists.linux.it>; Thu,  3 Oct 2024 15:28:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D8F881FDFE;
 Thu,  3 Oct 2024 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727962120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fXqzqt+VN5PXPKHtWv4IHjo9RdOiH+NRVfko1E8N4yU=;
 b=NJawysDeY2j8+VGgkbeH/v9M0KHbt8bd+dPRb0UbhukxHTA5h4VjqTTGhTr78/LQANMhTS
 JhlVk6QBTVhYHeEbUL0PbP4p2Sqy2scqLkut4AjsduFheC3pVDHhn8U7Y/5YPGLQHjlWFT
 cacGZ6+Hct0IcOHsIB8Lk3PQgL9Ngfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727962120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fXqzqt+VN5PXPKHtWv4IHjo9RdOiH+NRVfko1E8N4yU=;
 b=P2r74WvtgSSuM2YKeu3m8MnCe+eNvPKSMb/QWlxm//Kv6+zA+ZHW2TjGZh9scRrS0r7wAf
 CpWhMSAtgC4uL9Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727962119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fXqzqt+VN5PXPKHtWv4IHjo9RdOiH+NRVfko1E8N4yU=;
 b=RqLdfEnwHtbjbOk7JU6qc6pFjnM6YcAAAbZYtJEyvT/gd5p6H+6ympKD8PhnIlNEdrG8pE
 8+Ct9/XG0HStIR2pyl1HOor+esnJ/nNYdgWn6kU5AGxLY2GHX+UOjDaer/UjgTTxc9l1eL
 zORHYJSFXZJwz4pOxZSQpjUTE7XG0G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727962119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fXqzqt+VN5PXPKHtWv4IHjo9RdOiH+NRVfko1E8N4yU=;
 b=vZyKThCbjNd7rrzvqIGc9TyMuLD3aSFnMnSLg8Bj3ig3G9PMKNV4olQ2R4EWo9IEzha7bF
 m2w6UMubRu3XKMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6550139CE;
 Thu,  3 Oct 2024 13:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I217Lwec/mbuOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Oct 2024 13:28:39 +0000
Date: Thu, 3 Oct 2024 15:27:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv6bxSyf-NMxc_3C@yuki.lan>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-8-39558204ddf0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909-listmount_statmount-v4-8-39558204ddf0@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 08/13] Add statmount03 test
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
> This test verifies that statmount() is correctly reading mount
> information (mount id, parent mount id, mount attributes etc.)
> using STATMOUNT_MNT_BASIC.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                  |   1 +
>  testcases/kernel/syscalls/statmount/.gitignore    |   1 +
>  testcases/kernel/syscalls/statmount/statmount.h   |  24 ++++
>  testcases/kernel/syscalls/statmount/statmount03.c | 137 ++++++++++++++++++++++
>  4 files changed, 163 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e028baf19..ec11a3a21 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1570,6 +1570,7 @@ stat04_64 stat04_64
>  
>  statmount01 statmount01
>  statmount02 statmount02
> +statmount03 statmount03
>  
>  statfs01 statfs01
>  statfs01_64 statfs01_64
> diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
> index a30b9565f..2a02bf721 100644
> --- a/testcases/kernel/syscalls/statmount/.gitignore
> +++ b/testcases/kernel/syscalls/statmount/.gitignore
> @@ -1,2 +1,3 @@
>  statmount01
>  statmount02
> +statmount03
> diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
> index e807c8288..5cd54242c 100644
> --- a/testcases/kernel/syscalls/statmount/statmount.h
> +++ b/testcases/kernel/syscalls/statmount/statmount.h
> @@ -10,6 +10,7 @@
>  #include "tst_test.h"
>  #include "lapi/mount.h"
>  #include "lapi/syscalls.h"
> +#include "tst_safe_stdio.h"
>  
>  static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
>  		     size_t bufsize, unsigned int flags)
> @@ -23,4 +24,27 @@ static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *bu
>  	return tst_syscall(__NR_statmount, &req, buf, bufsize, flags);
>  }
>  
> +static inline int read_peer_group(const char *path)
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
> +		if (strcmp(mroot, path) == 0)
> +			break;
> +	}
> +
> +	if (group == -1)
> +		tst_brk(TBROK, "Can't reed peer group ID for %s", path);
> +
> +	return group;
> +}
> +
>  #endif
> diff --git a/testcases/kernel/syscalls/statmount/statmount03.c b/testcases/kernel/syscalls/statmount/statmount03.c
> new file mode 100644
> index 000000000..634c4b447
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statmount/statmount03.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that statmount() is correctly reading mount information
> + * (mount id, parent mount id, mount attributes etc.) using STATMOUNT_MNT_BASIC.
> + *
> + * [Algorithm]
> + *
> + * - create a mount point
> + * - create a new parent folder inside the mount point and obtain its mount info
> + * - create the new "/" mount folder and obtain its mount info
> + * - run statmount() on the mount point using STATMOUNT_MNT_BASIC
> + * - read results and check if mount info are correct
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "statmount.h"
> +#include "lapi/stat.h"
> +#include "lapi/sched.h"
> +
> +#define DIR_A "LTP_DIR_A"
> +#define DIR_B "LTP_DIR_B"
> +
> +static uint64_t mnt_id;
> +static uint64_t mnt_id_old;
> +static uint64_t parent_id;
> +static uint64_t parent_id_old;
> +static uint64_t mnt_peer_group;
> +static uint64_t mnt_master;
> +static struct statmount *st_mount;
> +
> +static void read_mnt_id(
> +	const char *path,
> +	uint64_t *mnt_id,
> +	uint64_t *mnt_id_unique)
> +{
> +	struct ltp_statx sx;
> +
> +	if (mnt_id) {
> +		SAFE_STATX(AT_FDCWD, path, 0, STATX_MNT_ID, &sx);
> +		*mnt_id = sx.data.stx_mnt_id;
> +	}
> +
> +	if (mnt_id_unique) {
> +		SAFE_STATX(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
> +		*mnt_id_unique = sx.data.stx_mnt_id;
> +	}

Technically the stx_mnt_id is only valid if the sx.data.stx_mask has the
STATX_MNT_ID or STATX_MNT_ID_UNIQUE set when statx() returns.

We have min_kver set to 6.8 so this should always work, but it wouldn't
hurt to double check.

> +}
> +
> +static struct tcase {
> +	uint64_t prop_type;
> +	char *msg;
> +} tcases[] = {
> +	{ MS_PRIVATE, TST_TO_STR_(MS_PRIVATE) },
> +	{ MS_SHARED, TST_TO_STR_(MS_SHARED) },
> +	{ MS_SLAVE, TST_TO_STR_(MS_SLAVE) },
> +	{ MS_UNBINDABLE, TST_TO_STR_(MS_UNBINDABLE) },
> +};
> +
> +static void run(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	tst_res(TINFO,  "Testing statmount() on %s", tc->msg);
> +
> +	SAFE_MOUNT(DIR_B, DIR_A, "none", MS_BIND, NULL);
> +	SAFE_MOUNT("none", DIR_A, "none", tc->prop_type, NULL);
> +	read_mnt_id(DIR_A, &mnt_id_old, &mnt_id);
> +
> +	memset(st_mount, 0, sizeof(struct statmount));
> +
> +	TST_EXP_PASS(statmount(mnt_id, STATMOUNT_MNT_BASIC, st_mount,
> +		sizeof(struct statmount), 0));
> +
> +	SAFE_UMOUNT(DIR_A);
> +
> +	if (TST_RET == -1)
> +		return;

Here as well if (!TST_PASS)

> +	/* s->sm.mnt_peer_group = IS_MNT_SHARED(m) ? m->mnt_group_id : 0;
> +	 * s->sm.mnt_master = IS_MNT_SLAVE(m) ? m->mnt_master->mnt_group_id : 0;
> +	 */

This comment looks like a leftover.

> +	mnt_peer_group = tc->prop_type == MS_SHARED ? read_peer_group(DIR_A) : 0;
> +	mnt_master = tc->prop_type == MS_SLAVE ? read_peer_group(DIR_A) : 0;
> +
> +	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_BASIC);
> +	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
> +	TST_EXP_EQ_LI(st_mount->mnt_id, mnt_id);
> +	TST_EXP_EQ_LI(st_mount->mnt_id_old, mnt_id_old);
> +	TST_EXP_EQ_LI(st_mount->mnt_parent_id, parent_id);
> +	TST_EXP_EQ_LI(st_mount->mnt_parent_id_old, parent_id_old);
> +	TST_EXP_EQ_LU(st_mount->mnt_propagation & tc->prop_type, tc->prop_type);
> +	TST_EXP_EQ_LI(st_mount->mnt_master, mnt_master);
> +	TST_EXP_EQ_LI(st_mount->mnt_peer_group, mnt_peer_group);
> +}

Otherwise it looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
