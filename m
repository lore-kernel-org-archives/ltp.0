Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0474EF4368A
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:41:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B7333E5944
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 13:41:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CF2C3E2730
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 13:41:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D1BBC600749
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 13:41:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49CF06A9AF;
 Fri, 17 Apr 2026 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776426086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v55+xZa9RLJDN9Bw6wQ5WtIzTdshQE9uz69AUkVqAuU=;
 b=1PnmoCKOW8ezzcFSvsveOeEg9vrEJJiC64KKPBMhoL4qYL1RVsdmoOrqdv6Ogi6Ey/XyvI
 Qo/C+7Hi8a2THV8qICPxI5RVIyZDenDSY8TyCPU0xYTQkTNccImK23GpnddBGNHWfRZ1BW
 O4br35N960RKyy2Xbg+6J5iEYJAR8RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776426086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v55+xZa9RLJDN9Bw6wQ5WtIzTdshQE9uz69AUkVqAuU=;
 b=rHhltD2UR+nitbLF2RJItIibolRKYS0kSClpzZbRn+x8MXqcp53VAqKUNAybsPTUA0lE3G
 CzkzKWi0g1OKdBDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1PnmoCKO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rHhltD2U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776426086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v55+xZa9RLJDN9Bw6wQ5WtIzTdshQE9uz69AUkVqAuU=;
 b=1PnmoCKOW8ezzcFSvsveOeEg9vrEJJiC64KKPBMhoL4qYL1RVsdmoOrqdv6Ogi6Ey/XyvI
 Qo/C+7Hi8a2THV8qICPxI5RVIyZDenDSY8TyCPU0xYTQkTNccImK23GpnddBGNHWfRZ1BW
 O4br35N960RKyy2Xbg+6J5iEYJAR8RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776426086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v55+xZa9RLJDN9Bw6wQ5WtIzTdshQE9uz69AUkVqAuU=;
 b=rHhltD2UR+nitbLF2RJItIibolRKYS0kSClpzZbRn+x8MXqcp53VAqKUNAybsPTUA0lE3G
 CzkzKWi0g1OKdBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAE5D593AE;
 Fri, 17 Apr 2026 11:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MPo6N2Uc4mltfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 11:41:25 +0000
Date: Fri, 17 Apr 2026 13:41:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <wangli.ahau@gmail.com>
Message-ID: <20260417114124.GB409289@pevik>
References: <20260410175031.16921-1-always.starving0@gmail.com>
 <20260413212007.GA164377@pevik>
 <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
 <20260416180559.GA303991@pevik>
 <CANgNiRxx3MyMGsEXszhV1TcBc8XP9jSrYL_pnbwsUa4bb0-XiQ@mail.gmail.com>
 <CANgNiRzSi2OgV-vu0amVvqNW_jUK_bBpjntubERaEd-5dqUVXg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANgNiRzSi2OgV-vu0amVvqNW_jUK_bBpjntubERaEd-5dqUVXg@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.cz];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 49CF06A9AF
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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

Hi Li,

> > Yes, that was exactly my point, we'd better remove the INSTALL_* part
> > from the Makefile you posted.

> > -INSTALL_DIR            := $(includedir)/lapi
> > -
> > -INSTALL_MODE           := 00644
> > -
> > -INSTALL_TARGETS                := *.h

> And we even don't need the additional clean targets, for the make-check
> which just simply:

> --- a/include/Makefile
> +++ b/include/Makefile
> @@ -24,4 +24,4 @@ ac-maintainer-clean:: ac-clean

>  vpath %.h $(abs_srcdir)

> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/include/lapi/Makefile b/include/lapi/Makefile
> new file mode 100644
> index 0000000..83ef85c
> --- /dev/null
> +++ b/include/lapi/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> +
> +top_srcdir              ?= ../../
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

+1 (+ deleted that INSTALL_* variables).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
