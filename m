Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2EBC3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 14:55:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C233D3D386C
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 16:55:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4950D3D3824
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 16:55:27 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 69806140514C
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 16:55:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08BD3219FA;
 Wed, 10 Jul 2024 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720623326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssOcg5qAQbu4l8Iw2hMMCktk9eq2wD4lcdSeweKMtko=;
 b=IyyBVPje5bBg15OOtVCMNDZ15o8ikkLe1KMhgCAgkrjF9IrYM9HZ56k7Am2TP/XMMsIDzV
 pm1En5jFAZmplPPb226MaRcmOecTc38AkrXqkjoZ7gGKTHPgQS/julagFJO6//7jevX4Cx
 H8/73TvH889D2UV/EaigyCW9VYnxcik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720623326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssOcg5qAQbu4l8Iw2hMMCktk9eq2wD4lcdSeweKMtko=;
 b=+kgbtEFqwlZ4fVWrG5Juq35bh/+csqSXBm3VTYIgqsBcsSTdNY3uRdxZsnxH0DjHpm9l6i
 iTP72084YUpwyKDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="SVID/3rh";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7HIjaEEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720623324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssOcg5qAQbu4l8Iw2hMMCktk9eq2wD4lcdSeweKMtko=;
 b=SVID/3rhz/m5tipdzpUKgIpDhJTv3rmoZaQVWWZ/X1Oz3ldHF+MjBYNT3aAhmPCju91nqt
 wrO8m3VtRi46IRNAUI4zNxDMc5gGVHziDsEHSEzt4mJdSI7Xy66kus7Yx9FCPwps0dp6d6
 i3teT2pRqnapnSLxru2wABen0Hc1fgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720623324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssOcg5qAQbu4l8Iw2hMMCktk9eq2wD4lcdSeweKMtko=;
 b=7HIjaEEE2UYJCzBtvNA+cyz08p8J1DPFmahNIMESuFPvc4pCuAK0zUyp+ksKFmnWlm0BmR
 WstYeHImajvN8kDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EC801369A;
 Wed, 10 Jul 2024 14:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pQMVGtugjma6RAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jul 2024 14:55:23 +0000
Date: Wed, 10 Jul 2024 16:55:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zo6g0o2sPr6S_a0c@yuki>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
 <20240516-listmount_statmount-v3-11-2ff4ba29bba7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240516-listmount_statmount-v3-11-2ff4ba29bba7@suse.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url, suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 08BD3219FA
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 11/11] Add statmount06 test
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
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that statmount() is correctly reading name of the
> + * filesystem type using STATMOUNT_FS_TYPE.
> + *
> + * [Algorithm]
> + *
> + * * create a mount point
> + * * run statmount() on the mount point using STATMOUNT_FS_TYPE
> + * * read results and check if contain the name of the filesystem
> + */
> +
> +#include "statmount.h"
> +#include "lapi/stat.h"
> +#include "lapi/sched.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define SM_SIZE (1 << 10)
> +
> +static uint64_t root_id;
> +static struct statmount *st_mount;
> +
> +static void run(void)
> +{
> +	memset(st_mount, 0, SM_SIZE);
> +
> +	TST_EXP_PASS(statmount(
> +		root_id,
> +		STATMOUNT_FS_TYPE,
> +		st_mount,
> +		SM_SIZE,
> +		0));
> +
> +	if (TST_RET == -1)
> +		return;
> +
> +	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_FS_TYPE);
> +	TST_EXP_EXPR(strcmp(st_mount->str + st_mount->fs_type, tst_device->fs_type) == 0,
> +		"statmount() read '%s', expected '%s'",
> +		st_mount->str + st_mount->fs_type, tst_device->fs_type);

This starts to be a common pattern, I guess that we need TST_EXP_STR_EQ()...

> +}
> +
> +static void setup(void)
> +{
> +	struct statx sx;
> +
> +	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
> +	root_id = sx.stx_mnt_id;
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
> +	.bufs = (struct tst_buffers []) {
> +		{&st_mount, .size = SM_SIZE},
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
