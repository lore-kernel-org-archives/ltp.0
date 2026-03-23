Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E19FC72C5
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 12:41:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8E203E5568
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 13:41:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 200773E2B05
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 13:41:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8CE2A10009EB
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 13:41:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BBCF34D28E;
 Mon, 23 Mar 2026 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774269665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Jd6cYS6oS8LG+hYpOZtB78vGFKVt1YZSzHF6XQtKmc=;
 b=HQZsjaMFBL4OmLzS9zYzkwsx+Qy3WkDLiGvaQ80rebN5T0Ab0InsVoQEJnZ9MNLrQqXsFX
 T8PhMGxCAi8wZ29/frgct8K8nkwk76wMxzXt2dfb3pYCLXJAVd4Lr9zjABhTiB0PKxiFXR
 RNJ0keUlArjkP5MnK/N0shDEoOCP8/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774269665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Jd6cYS6oS8LG+hYpOZtB78vGFKVt1YZSzHF6XQtKmc=;
 b=QEqJ921cCENrsN0LglRGuJGmEWJHHlcIm37rAWhg79B9SUV/Xr8g6taSRjfUqu3NT1NYlG
 sFeVZhHP5K51ImDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HQZsjaMF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QEqJ921c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774269665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Jd6cYS6oS8LG+hYpOZtB78vGFKVt1YZSzHF6XQtKmc=;
 b=HQZsjaMFBL4OmLzS9zYzkwsx+Qy3WkDLiGvaQ80rebN5T0Ab0InsVoQEJnZ9MNLrQqXsFX
 T8PhMGxCAi8wZ29/frgct8K8nkwk76wMxzXt2dfb3pYCLXJAVd4Lr9zjABhTiB0PKxiFXR
 RNJ0keUlArjkP5MnK/N0shDEoOCP8/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774269665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Jd6cYS6oS8LG+hYpOZtB78vGFKVt1YZSzHF6XQtKmc=;
 b=QEqJ921cCENrsN0LglRGuJGmEWJHHlcIm37rAWhg79B9SUV/Xr8g6taSRjfUqu3NT1NYlG
 sFeVZhHP5K51ImDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4D1E4389D;
 Mon, 23 Mar 2026 12:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id THlBJ+E0wWmiKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Mar 2026 12:41:05 +0000
Date: Mon, 23 Mar 2026 13:41:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260323124100.GB315436@pevik>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-3-pvorel@suse.cz>
 <abq1-BcXR1nfLGcU@yuki.lan> <20260318150252.GA31214@pevik>
 <ab1zwXCUui24rmmC@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab1zwXCUui24rmmC@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,isofs.sh:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BBCF34D28E
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] isofs.sh rewrite [was Re: [PATCH 2/6] tst_env.sh: Backport
 common functions from tst_test.sh]
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
Let's change the mail subject for this.

> > But OTOH maybe route-change-*.sh tests even don't need to quit.
> > And it's a question if isofs.sh does (and whether we should even keep isofs.sh).

> For the isofs I would probably generate the iso filesystems in advance
> and store them in git so that we don't have to re-generate them during
> the test run. Other than that mounting an iso filesystem over loopback
> and checking that the files are there (which the test does not do) is
> valid kernel test. But that is a different problem.

Ah, right. It's both mkisofs/genisoimage/xorrisofs test + testing isofs as the
kernel part :). And sure, isofs itself will kept used for very long time (USB
install media).

I'll create a ticket once we agree what should be done. "Rewrite test to
mounting an iso filesystem over loopback and checking that the files are there."
is clear. Creating filesystem would be gen_fs_tree() calls (these subdirs) +
call one of mkisofs/genisoimage/xorrisofs. I guess TODO is to find out which
options are worth to test. Because test runs various options, testing ISO-9660
(various ISO levels)/JOLIET/UDF. Kernel's fs/isofs/Kconfig mentions
CONFIG_ISO9660_FS and two other depending on it: CONFIG_JOLIET and CONFIG_ZISOFS
(uses an old tool mkzftree).

Resulted ISO file has 9 MB, which is OK for git (given we are ok only with a
single variant). Obviously we are not going to test max files limits (e.g. files
over 2 GB for DVD require iso level 3), but hopefully size does not matter much.

I'm not sure if it's worth to test some invalid ISOs. But it'd be worth to add
max at least test for max file size, i.e recent fix from v7.0-rc1:
18a777eee289 ("isofs: support full length file names (255 instead of 253)")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
