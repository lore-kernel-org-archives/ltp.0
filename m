Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06ECCAC59A
	for <ltp@archiver.kernel.org>; Fri, 19 Sep 2025 13:22:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 424133CDD4C
	for <ltp@archiver.kernel.org>; Fri, 19 Sep 2025 15:22:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 628413C23A0
 for <ltp@lists.linux.it>; Fri, 19 Sep 2025 15:22:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D51D42002C8
 for <ltp@lists.linux.it>; Fri, 19 Sep 2025 15:22:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B9431F38F;
 Fri, 19 Sep 2025 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758288137;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WXoOSoeaWSLKs2by/wvOW9xl5zBFSL8Ni+nXR+mbDXs=;
 b=pAC6HdbhNEL75aB1xnojjJAEpUOtnWQCCs4r+e5b8bUb6hUhOe47zF/dmdYBCyCU2wbv42
 Ld+v2UnUzYjx4TQoa9plwATOCtUilb119Jr7b49g39t4xWORlGOM/iCA3o7LPiwrjRqzf3
 8KqitZch1oQ+8Hb1LkexKwwtuK4KDcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758288137;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WXoOSoeaWSLKs2by/wvOW9xl5zBFSL8Ni+nXR+mbDXs=;
 b=qr04ktzUEvMbIQkg6YwvQn/DvkrlebyFPu9lmyhY0ylmE1CDicMFa1Abft3LZs2AuiyHOj
 NgL4gDYBNDnX2SCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ti3EVQey;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kJcHM2M9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758288136;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WXoOSoeaWSLKs2by/wvOW9xl5zBFSL8Ni+nXR+mbDXs=;
 b=Ti3EVQeyG+m8jnFdBxnYf+enHZoyDazXuvfllo16Nf3YWMt2q4LracVkRtpNN1EXILujsX
 hfC7DBj5LS2vo8BN4WZdSnCUPOprVcooyIM3EmYheXS+3KiB/4b6D1j6dXpo9uy535zokw
 xYzZiaiKE1WSXI3N0jLBiadh4I6YwQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758288136;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WXoOSoeaWSLKs2by/wvOW9xl5zBFSL8Ni+nXR+mbDXs=;
 b=kJcHM2M9yqX1msqaO9/7Ole76hWcfV7k0VhEvCszQg4PIVvghOg6FUr0d0+kycLBZuFFF5
 pm4kd5MBk0gpYqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F06413A78;
 Fri, 19 Sep 2025 13:22:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y64PDQhZzWjcEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Sep 2025 13:22:16 +0000
Date: Fri, 19 Sep 2025 15:22:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250919132214.GA499767@pevik>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
 <aMDV1aTCZ--ElqfY@localhost> <20250918145335.GA432906@pevik>
 <aMwms-DHHeF5U7PG@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aMwms-DHHeF5U7PG@yuki.lan>
X-Rspamd-Queue-Id: 7B9431F38F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_loop01.c: Use proper device for
 partitioning
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

> Hi!
> > > > The test should have needs_cmds set to parted (we do that properly in
> > > > ioctl09.c) then we do not have to handle the 255 exit code here since
> > > > the test would be skipped if it's missing.

> > > If we use needs_cmds all the check will be skipped in this case.

> > @Cyril: only single test require 'parted' as I reported in v1 [1].
> > Yeah, code gets slightly more complicated just because single test requires
> > parted. Or you would not care? IMHO it does not make sense to split test into
> > two (too much duplicity).

> The problem here is how to handle the metadata. One posible solution is
> to add a notion of optional dependencies so that we would have
> 'needs_foo' and 'wants_foo'. Or turn the needs_foo into a structure with
> an .optional boolean flag.

+1 but that should wait after the release.
Can I merge it with your RBT with the following diff below?

Kind regards,
Petr

> > But TINFO message should be turned in TCONF so that people notice.
> > tst_res(TINFO, "Current environment doesn't have parted disk, skip it");

> Yes please.

+++ testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -59,7 +59,7 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 	TST_ASSERT_INT(autoclear_path, autoclear_field);
 
 	if (!parted_sup) {
-		tst_res(TINFO, "Current environment doesn't have parted disk, skip it");
+		tst_res(TCONF, "Current environment doesn't have parted disk, skip it");
 		return;
 	}
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
