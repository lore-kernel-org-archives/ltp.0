Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC13C25B79
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 13:46:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C1133CF8C1
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 15:46:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 703FA3CF7B3
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:46:14 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA3D920D1BC
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:46:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6AB233BE8;
 Wed, 15 May 2024 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715780772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxiY8CLKp6G+0OqB27RsiF+Y//LU36cFPaH567VOUrA=;
 b=LoHDnALUW2MuvhSt9cepOUc8ngGodgZvc78xGJ8wEGdZ8/vUOU+HkavC49PXE5yNb8Q3Yw
 zXasYCSHAPvQpIql3QQ2kYyWK4bMBvWBfe6MK+THT2LEBuf0aM1dMITiesXolbEZDB6RU+
 uzW9BusgfD/i2PqliBkMvjbXIiEGn2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715780772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxiY8CLKp6G+0OqB27RsiF+Y//LU36cFPaH567VOUrA=;
 b=k/mrZUS+DT3Pq2PtqJumFxoJY0hW+p7x2La3UdSL+Cz7gX3dF+wYh06RkAwvHEF9O5cy8K
 UF2X5x3RaS+gt9Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715780772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxiY8CLKp6G+0OqB27RsiF+Y//LU36cFPaH567VOUrA=;
 b=LoHDnALUW2MuvhSt9cepOUc8ngGodgZvc78xGJ8wEGdZ8/vUOU+HkavC49PXE5yNb8Q3Yw
 zXasYCSHAPvQpIql3QQ2kYyWK4bMBvWBfe6MK+THT2LEBuf0aM1dMITiesXolbEZDB6RU+
 uzW9BusgfD/i2PqliBkMvjbXIiEGn2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715780772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxiY8CLKp6G+0OqB27RsiF+Y//LU36cFPaH567VOUrA=;
 b=k/mrZUS+DT3Pq2PtqJumFxoJY0hW+p7x2La3UdSL+Cz7gX3dF+wYh06RkAwvHEF9O5cy8K
 UF2X5x3RaS+gt9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBE861372E;
 Wed, 15 May 2024 13:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LmZdMaO8RGbpBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 13:46:11 +0000
Date: Wed, 15 May 2024 15:46:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240515134605.GA227140@pevik>
References: <20240515094753.1072-1-mdoucha@suse.cz>
 <20240515101511.GA211618@pevik> <ZkSUG0EtSyu6GvvW@yuki>
 <20240515130355.GA222948@pevik>
 <97937ba2-02b0-4682-baf9-0d97f678cb99@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <97937ba2-02b0-4682-baf9-0d97f678cb99@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: Pass if the tcindex module is
 blacklisted
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

> On 15. 05. 24 15:03, Petr Vorel wrote:
> > > > > +
> > > > > +	if (!ret && TST_ERR == ENOENT) {
> > > > > +		tst_res(TPASS | TTERRNO,
> > > > > +			"tcindex module is blacklisted or unavailable");

> > Why not TCONF? We are testing if removing tcindex does not cause bug,
> > right?

> Blacklisting the module is intended as a partial CVE fix so TPASS is more
> appropriate than TCONF.

Thanks for info. Indeed it makes sense. Maybe it's just me, who didn't see it as
obvious when looking into CVE-2023-1829 description. But OK "We recommend
upgrading past commit 8c710f75256bb3cf05ac7b1672c82b92c43f3d28." + your
description makes it clear that some distros just preferred blacklist
configuration instead of backporting the removal commit.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
