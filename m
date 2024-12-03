Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F22CD49799
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 09:24:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54C8E3DDC43
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 10:24:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 497EB3DDC31
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 10:24:10 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 67E651434EF6
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 10:24:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DCA31F45F;
 Tue,  3 Dec 2024 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733217848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODsK/8mmTcDdB3hwFYtQGvmNRskwsRdn9jzW54JPVuo=;
 b=2p9/NT09YykfX9/YePV9seGkjgFlPo/WyHQzxDqrFPvJclImALC5Ok/xbFbNeWOF+cGk/x
 sl135vLcbN7OOoWgtiCuIk4LQA6ToZ8ycJXB+cpuo9mtA5QjZwLSKkIsjXzByduATNfVvd
 na8jEXrrIPGrAQK1C2pSG3UGiNsliNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733217848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODsK/8mmTcDdB3hwFYtQGvmNRskwsRdn9jzW54JPVuo=;
 b=GTsTuo6Ul+ByiMToYFtsrYs3PlWwRrHKlfTUcjWodtFbxARM6b63yKchyC57KBYcwRG9TV
 5RqUNvtrTBIhopBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733217848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODsK/8mmTcDdB3hwFYtQGvmNRskwsRdn9jzW54JPVuo=;
 b=2p9/NT09YykfX9/YePV9seGkjgFlPo/WyHQzxDqrFPvJclImALC5Ok/xbFbNeWOF+cGk/x
 sl135vLcbN7OOoWgtiCuIk4LQA6ToZ8ycJXB+cpuo9mtA5QjZwLSKkIsjXzByduATNfVvd
 na8jEXrrIPGrAQK1C2pSG3UGiNsliNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733217848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODsK/8mmTcDdB3hwFYtQGvmNRskwsRdn9jzW54JPVuo=;
 b=GTsTuo6Ul+ByiMToYFtsrYs3PlWwRrHKlfTUcjWodtFbxARM6b63yKchyC57KBYcwRG9TV
 5RqUNvtrTBIhopBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CFCD13A15;
 Tue,  3 Dec 2024 09:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TmC7ETjOTmelTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Dec 2024 09:24:08 +0000
Date: Tue, 3 Dec 2024 10:24:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241203092406.GB414034@pevik>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan> <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik> <Z03RB9JDmBVORPlf@yuki.lan>
 <20241203045310.GA414034@pevik> <Z066Fj9VQVlTOMp_@rei.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z066Fj9VQVlTOMp_@rei.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > It's a nice feature to be able to force testing on filesystem even it's set to
> > > > be skipped without need to manually enable the filesystem and recompile.
> > > > (It helps testing with LTP compiled as a package without need to compile LTP.)
> > > > Therefore I would avoid this.

> > > I guess that this should be another env variable e.g.
> > > LTP_FORCE_SINGLE_FS_TYPE and it should print a big fat warning that it's
> > > only for development purposes.

> > Well, LTP_SINGLE_FS_TYPE already has "Testing only"

> That was maybe how we intended it but we exposed the API and it seems
> that there is a usecase for it so people are possibly using it.

> > and that was the reason it just forced filesystem regardless "skip"
> > setup. Sure, we can turn it into "normal" variable and introduce
> > LTP_FORCE_SINGLE_FS_TYPE if it's needed.  But that would be an use
> > case if anybody uses LTP really to test particular filesystem. And it
> > would affect only .all_filesystem tests (e.g. user's responsibility
> > would be to point TMPDIR to that particular system on non-
> > .all_filesystem tests).

> There is a usecase we haven't figured out, when you want to test a
> single filesystem, you do not want to waste time on the rest of the
> filesystems and LTP_SINGlE_FS_TYPE nearly works for that usecase.

Yes, I understood this use case, this was probably the reason of this PR.
I'd appreciate Zorro's confirmation we understood him properly (e.g. that
somebody really needs this). I suppose you vote for this feature anyway
and it's fairly simple, thus I can prepare it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
