Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C795C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:59:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53D303EADA7
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:59:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 004EE3EA7B7
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:59:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62D76600479
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:59:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3433C1F7F1;
 Thu,  3 Sep 2026 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788451157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PS0sNhcpESiLcsS3gSjlxS7FROEbANyMQUaSMuRHQQ8=;
 b=DctbiPGrMFHValF6LU6ehQV9JjtfP3yiiO+eO99n2lkKNaVQbLHiOwt/0O3RRQNbgFiPEX
 lYLszdgk781vebLBcsndj8YTM2tQuQrjMFJhFCwGmuNnIZvHCQDddFCmH/H86fL297DUCv
 CTJcUtr4nitP3iewjlTUM3MLaNTSPfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788451157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PS0sNhcpESiLcsS3gSjlxS7FROEbANyMQUaSMuRHQQ8=;
 b=sDvAzqwgAEiImrFQKH0tcjaViswXXXITaC7h+EhW7gCn6pNoMFfV1PFAGOyabezAoo1E60
 5EqZlV1S4Rd5sCBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bcC0OsIS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QdGrtU67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788451153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PS0sNhcpESiLcsS3gSjlxS7FROEbANyMQUaSMuRHQQ8=;
 b=bcC0OsIS5IGqgPDr6GX9NroVlxiT+8sEm5ba/YqRFkglpkMkjDb/ZRszrScUbuRkeUh5Ej
 ZlEAGkAn1v5f1SvP9yIaEuXXQQNO1jupiBFvOjNc0LHPeaFJhdhfr8yIchQOCWYiQzFrLL
 pZfA58yn20jKx5HtYnRseKmwSuzQGYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788451153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PS0sNhcpESiLcsS3gSjlxS7FROEbANyMQUaSMuRHQQ8=;
 b=QdGrtU6707GIRE6ZBPLRAffdCk2gcsbSkeC2WV5PomK8dMu4HxjT1JT7Fio55rGhNm066C
 1dVixOnDkrpBwgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 598D4136D9;
 Thu,  3 Sep 2026 15:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PmwsE1CZmWojbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 15:59:12 +0000
Date: Thu, 3 Sep 2026 17:59:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903155906.GE1107507@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-13-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-13-chrubis@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3433C1F7F1
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 12/31] testcases: sysfs: Add sys_ata01
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

Hi Cyril,

...
> +++ b/testcases/kernel/sysfs/class/ata_device/sys_ata01.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * Sanity checks for the ATA device attributes exported under
> + * /sys/class/ata_device/<dev>/.
> + *
> + * For every ATA device the test verifies that:
> + *
> + * - class is one of the known libata device classes (ata, atapi, pmp, semb,
> + *   unknown, zac, none). none is a legitimate value here, not just a range
> + *   extension for safety: ata_tdev_add() in drivers/ata/libata-transport.c
> + *   creates a transport device object for every possible device slot on a
> + *   link (e.g. both the master/slave slots on a PATA link), regardless of
> + *   whether a physical device is actually attached to it, so an empty slot
> + *   reports class = none rather than not existing at all.
> + * - dma_mode, pio_mode and xfer_mode, when non-empty, start with the
> + *   ``XFER_`` prefix used by all libata transfer mode names
> + * - spdn_cnt (speed-down count) is non-negative
> + *
> + * dma_mode is legitimately empty for devices that only support PIO, so it is
> + * only checked when present.
> + *
> + * The test skips with TCONF when no ATA device is present.
> + */
> +
> +#include <string.h>
> +#include <dirent.h>
> +#include "tst_test.h"
> +#include "tst_sysfs_assert.h"
> +#include "tst_path_defs.h"
> +
> +static const char *const class_allowed[] = {
> +	"ata", "atapi", "pmp", "semb", "unknown", "zac", "none", NULL
Lol, I'd expect this would be part of Documentation/ABI/testing/sysfs-ata
but it's only in the sources (drivers/ata/libata-transport.c).

You mentioned that by findings of this patchset kernel doc could be improved :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
