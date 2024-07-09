Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835DAC2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 08:47:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E21603D393E
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:46:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE0E73D0CD5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 10:46:45 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB75D1A00641
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 10:46:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2381E1F7A6;
 Tue,  9 Jul 2024 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720514803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mZC2qp2ZJjG859dWBAriso/4U/zm/y+J6+ohvyKw5Uw=;
 b=S/KiwRd8KskH1lM39bTGef/XAAqcac7q9nMbjOhUnJLe1PNeNrRldnBDQABM9SSRYZvWjH
 0DwI/ta/upVlpOhyfz/vxrlfDOgcjpsHwSLgou1LsXiKD19JnurLmxo7+DVAucfKHTLWid
 818qDrPitx3JDX1y5VXwY8GIkQqm/ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720514803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mZC2qp2ZJjG859dWBAriso/4U/zm/y+J6+ohvyKw5Uw=;
 b=XVbVGRV4HCpyrKzz+mloQjYI0eSG3L14jANlqrz3iawTQO0GMpwmpaa7ghAZT0obADNK2y
 49CRMzpi6sSlYaAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720514803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mZC2qp2ZJjG859dWBAriso/4U/zm/y+J6+ohvyKw5Uw=;
 b=S/KiwRd8KskH1lM39bTGef/XAAqcac7q9nMbjOhUnJLe1PNeNrRldnBDQABM9SSRYZvWjH
 0DwI/ta/upVlpOhyfz/vxrlfDOgcjpsHwSLgou1LsXiKD19JnurLmxo7+DVAucfKHTLWid
 818qDrPitx3JDX1y5VXwY8GIkQqm/ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720514803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mZC2qp2ZJjG859dWBAriso/4U/zm/y+J6+ohvyKw5Uw=;
 b=XVbVGRV4HCpyrKzz+mloQjYI0eSG3L14jANlqrz3iawTQO0GMpwmpaa7ghAZT0obADNK2y
 49CRMzpi6sSlYaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13D831369A;
 Tue,  9 Jul 2024 08:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id piG7A/P4jGYnLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jul 2024 08:46:43 +0000
Date: Tue, 9 Jul 2024 10:46:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zoz47WNb28I1ID4d@yuki>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
 <20240516-listmount_statmount-v3-4-2ff4ba29bba7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240516-listmount_statmount-v3-4-2ff4ba29bba7@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 04/11] Add listmount01 test
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
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listmount/listmount01.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that listmount() is properly recognizing a mounted
> + * root directory using LSMT_ROOT flag.
> + *
> + * [Algorithm]
> + *
> + * * move into a new unshared namespace
> + * * mount() a root inside temporary folder and get its mount ID
> + * * get list of mounted IDs using listmount(LSMT_ROOT, ..)
> + * * verify that the root mount ID is the only mount ID present inside the list

Can we please use dashes here instead of asterisks? It's kind of hard to
read asterisk based list inside of C comments...

> + */
> +
> +#include "listmount.h"
> +#include "lapi/stat.h"
> +#include "lapi/sched.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define LISTSIZE 32
> +
> +static uint64_t root_id;
> +
> +static void run(void)
> +{
> +	uint64_t list[LISTSIZE];
> +
> +	TST_EXP_POSITIVE(listmount(LSMT_ROOT, 0, list, LISTSIZE, 0));
> +	if (TST_RET == -1)
> +		return;
> +
> +	TST_EXP_EQ_LI(TST_RET, 1);
> +	TST_EXP_EQ_LI(list[0], root_id);
> +}
> +
> +static void setup(void)
> +{
> +	struct statx sx;
> +
> +	SAFE_UNSHARE(CLONE_NEWNS);
> +
> +	SAFE_CHROOT(MNTPOINT);
> +	SAFE_MOUNT("", "/", NULL, MS_REC | MS_PRIVATE, NULL);
> +	SAFE_STATX(AT_FDCWD, "/", 0, STATX_MNT_ID_UNIQUE, &sx);
> +
> +	root_id = sx.stx_mnt_id;
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.forks_child = 1,
> +	.min_kver = "6.8",
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,

I do not think that this makes sense to be run for all filesystems, the
listmount() syscall does not interact with any of the filesytem code at
all. It just loops over a list of mount points in the namespace.

> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		NULL
> +	},
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
