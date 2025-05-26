Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE6DC5B542
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 06:40:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E17A3C273A
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 08:40:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 175DA3C0463
 for <ltp@lists.linux.it>; Mon, 26 May 2025 08:40:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7AC8C6007B2
 for <ltp@lists.linux.it>; Mon, 26 May 2025 08:40:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26FD221F7E;
 Mon, 26 May 2025 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748241609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fb3J2i8YOzIAIpFrPxozrqjbshXk5F0wMCYI7GsXFeM=;
 b=S/t26qIujPTrI5QhICFiFo7qHkakVePX4/aRfbyMEic2QvNfuXBD1mofNIOYe81YGchzCZ
 z/t9b5q6na8lM2KsdDC7mNTqhio1ZTnpfvfzc4m/AxvnbLJ/n2YZ4Gk6gdxW2fwQ2sdD8F
 Gv6E/DhbLo+6de/gOVkj/ok1k9qjazY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748241609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fb3J2i8YOzIAIpFrPxozrqjbshXk5F0wMCYI7GsXFeM=;
 b=fxTCO6HuFf9KPQymV/N9eJBVgUIJso2jyPlexFzaZub3b2D7x5ARmGvCE8Ki7GTje0HfmR
 LQ8EIiKKJX97pvBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="S/t26qIu";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fxTCO6Hu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748241609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fb3J2i8YOzIAIpFrPxozrqjbshXk5F0wMCYI7GsXFeM=;
 b=S/t26qIujPTrI5QhICFiFo7qHkakVePX4/aRfbyMEic2QvNfuXBD1mofNIOYe81YGchzCZ
 z/t9b5q6na8lM2KsdDC7mNTqhio1ZTnpfvfzc4m/AxvnbLJ/n2YZ4Gk6gdxW2fwQ2sdD8F
 Gv6E/DhbLo+6de/gOVkj/ok1k9qjazY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748241609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fb3J2i8YOzIAIpFrPxozrqjbshXk5F0wMCYI7GsXFeM=;
 b=fxTCO6HuFf9KPQymV/N9eJBVgUIJso2jyPlexFzaZub3b2D7x5ARmGvCE8Ki7GTje0HfmR
 LQ8EIiKKJX97pvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FBC813964;
 Mon, 26 May 2025 06:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IGTOAskMNGg3JgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 26 May 2025 06:40:09 +0000
Date: Mon, 26 May 2025 08:40:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250526064007.GA105770@pevik>
References: <20250516151028.1254207-1-wegao@suse.com>
 <20250522205637.GA32918@pevik> <aDR64TWa0Fo21t6B@MiWiFi-CR6608-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aDR64TWa0Fo21t6B@MiWiFi-CR6608-srv>
X-Spamd-Bar: /
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 26FD221F7E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; REPLYTO_EQ_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig04.c: Check FSCONFIG_SET_PATH
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

Hi Wei,

> On Thu, May 22, 2025 at 10:56:37PM +0200, Petr Vorel wrote:
> > Hi Wei,

> > I'm sorry not a real review, just point out obvious API errors.
> Thanks for pointing that out :)


> > > +#include "lapi/fsmount.h"

> > > +#include "old/old_device.h"
> > Why this?
> tst_acquire_loop_device is needed in this case, and i saw following test
> case using old_device.h, so i just copy it into current case.
> testcases/lib/tst_device.c

Indeed it also uses it, maybe there is really no other alternative for new API.

> > > +
> > > +
> > > +	.all_filesystems = 1,
> > > +	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat",
> > > +		"ext2", "tmpfs", "xfs", "btrfs", NULL},
> > So you skip nearly everything, right?
> Yes, ONLY ext3 and ext4 support journal setup

> > Why not use .mount_device = 1 ? That would mount the default filesystem.
> This case need format default device with ext3 opts='-F -J device=/dev/loop1' firstly,
> so the device can not be mounted before format.

Thanks for info.

Kind regards,
Petr

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
