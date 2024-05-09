Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E45C25B4F
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 14:21:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 088BF3CE2D9
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 16:21:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82DD53CE0E2
 for <ltp@lists.linux.it>; Thu,  9 May 2024 16:20:59 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB11F200B3D
 for <ltp@lists.linux.it>; Thu,  9 May 2024 16:20:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06A363871D;
 Thu,  9 May 2024 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715264457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7iXTYd5CQWnMKG0I9osvbcGEcOMnED/3kT7fU2o9e0Q=;
 b=u2dC4rATXPtNKj/+RUBT0r85F9BEnw2DS3sTqrk4BkRkt59IuVOTFqCL3jD8h39U6DYpTb
 phW0L621KUS88sE2tBXuku5+Xo+xr5xEWElN/vsmmIMlgB3NU7m5UWvdYpNhM09cNRLqdD
 B3lq3xUyStuYPQpOWykIta/eGBWRmbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715264457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7iXTYd5CQWnMKG0I9osvbcGEcOMnED/3kT7fU2o9e0Q=;
 b=2tb5UHT61pNyVPKmUJLf0NHCkgF5ocxem45l3dvzLgdTUHcDGmaQhDcQv3FVvnvoG0dFf1
 laL8O+LF10kqw0AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715264457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7iXTYd5CQWnMKG0I9osvbcGEcOMnED/3kT7fU2o9e0Q=;
 b=u2dC4rATXPtNKj/+RUBT0r85F9BEnw2DS3sTqrk4BkRkt59IuVOTFqCL3jD8h39U6DYpTb
 phW0L621KUS88sE2tBXuku5+Xo+xr5xEWElN/vsmmIMlgB3NU7m5UWvdYpNhM09cNRLqdD
 B3lq3xUyStuYPQpOWykIta/eGBWRmbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715264457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7iXTYd5CQWnMKG0I9osvbcGEcOMnED/3kT7fU2o9e0Q=;
 b=2tb5UHT61pNyVPKmUJLf0NHCkgF5ocxem45l3dvzLgdTUHcDGmaQhDcQv3FVvnvoG0dFf1
 laL8O+LF10kqw0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAF1C13941;
 Thu,  9 May 2024 14:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hoMjNMjbPGbNAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 14:20:56 +0000
Date: Thu, 9 May 2024 16:20:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20240509142055.GB305046@pevik>
References: <20240201151357.110769-1-pvorel@suse.cz> <ZjzY1pR1WbYB3ec9@yuki>
 <20240509141710.GA305046@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240509141710.GA305046@pevik>
X-Spamd-Result: default: False [-3.48 / 50.00]; BAYES_HAM(-2.98)[99.92%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tree: Use TST_EXP_FAIL2() for wait{,id}
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Cyril,

> > Hi!
> > > Both wait() and waitid() returns PID, therefore (similarly as for file
> > > descriptor) pass condition is >= 0, which is in TST_EXP_FAIL2().

> > Actually waitid() returns whatever was waited for in the siginfo_t
> > structure and returns just 0 on success.

> Ah, thanks!  I guess I misread "waitpid()" in man wait(3p) as "waitid()".

> I'll send v2 with just pidfd_open04.c and wait01.c changes.
Actually only wait01.c (pidfd_open04.c has also waitid) + searching for
waitpid() usage.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
