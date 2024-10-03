Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598FFCF34AD
	for <ltp@archiver.kernel.org>; Thu,  3 Oct 2024 13:53:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF48F3C5F34
	for <ltp@archiver.kernel.org>; Thu,  3 Oct 2024 15:53:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137EC3C5A45
 for <ltp@lists.linux.it>; Thu,  3 Oct 2024 15:53:05 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 600341416742
 for <ltp@lists.linux.it>; Thu,  3 Oct 2024 15:53:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F93C21D61;
 Thu,  3 Oct 2024 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727963583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JHrMoiXLbAnQY/JoEat0N2ZvcXcXo9rB4vIIdSkOHWw=;
 b=oA76fgGMtpfTB0zhaV2Q21bW2Z8x4LEMlOrwOTEDYCmJaCs4J8Tysdb3A3Hza3qDYH2+/c
 7aO+6ugIQL+AKAv4zTK5pPMlThlNfmWIt/o0CwupP88JqWvictQGmHYA9WhyY7PDRMLFBd
 GKlWIc3Ftq20HFT5Z//LsjESqhxD0pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727963583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JHrMoiXLbAnQY/JoEat0N2ZvcXcXo9rB4vIIdSkOHWw=;
 b=ODFJZkRIXuANNk8JFmyXCSrxyLET3pwBKbgNtf3GXWfjigt1akJ2OSfNSCzOnllXkCR7jl
 u5IjMI1Jy/xS+6DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727963583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JHrMoiXLbAnQY/JoEat0N2ZvcXcXo9rB4vIIdSkOHWw=;
 b=oA76fgGMtpfTB0zhaV2Q21bW2Z8x4LEMlOrwOTEDYCmJaCs4J8Tysdb3A3Hza3qDYH2+/c
 7aO+6ugIQL+AKAv4zTK5pPMlThlNfmWIt/o0CwupP88JqWvictQGmHYA9WhyY7PDRMLFBd
 GKlWIc3Ftq20HFT5Z//LsjESqhxD0pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727963583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JHrMoiXLbAnQY/JoEat0N2ZvcXcXo9rB4vIIdSkOHWw=;
 b=ODFJZkRIXuANNk8JFmyXCSrxyLET3pwBKbgNtf3GXWfjigt1akJ2OSfNSCzOnllXkCR7jl
 u5IjMI1Jy/xS+6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B804139CE;
 Thu,  3 Oct 2024 13:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8QgFEr+h/maFQgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Oct 2024 13:53:03 +0000
Date: Thu, 3 Oct 2024 15:51:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv6hfN1iiGiKIgQR@yuki.lan>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-9-39558204ddf0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909-listmount_statmount-v4-9-39558204ddf0@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 09/13] Add statmount04 test
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
> +/*\
> + * [Description]
> + *
> + * This test verifies that statmount() is correctly reading propagation from
> + * what mount in current namespace using STATMOUNT_PROPAGATE_FROM.
> + *
> + * [Algorithm]
> + *
> + * - create a mount point
> + * - propagate a mounted folder inside the mount point
> + * - run statmount() on the mount point using STATMOUNT_PROPAGATE_FROM
> + * - read results and check propagated_from parameter contains the propagated
> + *   folder ID
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "statmount.h"
> +#include "lapi/stat.h"
> +#include "lapi/sched.h"
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
> +static void run(void)
> +{
> +	memset(st_mount, 0, sizeof(struct statmount));
> +
> +	TST_EXP_PASS(statmount(dird_id, STATMOUNT_PROPAGATE_FROM, st_mount,
> +		sizeof(struct statmount), 0));
> +
> +	if (TST_RET == -1)
> +		return;

Again if (!TST_PASS)

> +	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_PROPAGATE_FROM);
> +	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
> +	TST_EXP_EQ_LI(st_mount->propagate_from, peer_group_id);
> +}
> +
> +static void setup(void)
> +{
> +	struct ltp_statx sx;
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
> +	dird_id = sx.data.stx_mnt_id;
> +
> +	peer_group_id = read_peer_group(DIR_A);
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


Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
