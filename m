Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9E8E7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 09:03:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4E623E7AEB
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 10:03:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA8C73E2B81
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:03:15 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22C44246005
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:03:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05D691F399;
 Thu, 12 Dec 2024 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733994194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8G0gK2HdIthI8Y0RYFwLhnO7pYPlTSAVhIEVygmoG5g=;
 b=2/6w1frzWk5885hjodE9J2bTvaB8B6N11ojqt7VqE6+zRbClrSH1R7tcn6EI2r+MOBzJ18
 bNAWRHiBn//d1kVyI4fFx3MWqA9Z+tXNjePuVCS/aN4ejTlL1e7ADnvGrMkY6QP6tf5MGe
 r4AcIB8+BaEGa/eqSKTBUtZZFkAGC8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733994194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8G0gK2HdIthI8Y0RYFwLhnO7pYPlTSAVhIEVygmoG5g=;
 b=L7kuafeS7KacjdVHcaiIZnh9cPu4hdGyPYuAv5Ni4FYZgvqYGeFYZeoHqeYeIuQa2rQRuD
 SIAJp1uIGT9bRYBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2/6w1frz";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L7kuafeS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733994194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8G0gK2HdIthI8Y0RYFwLhnO7pYPlTSAVhIEVygmoG5g=;
 b=2/6w1frzWk5885hjodE9J2bTvaB8B6N11ojqt7VqE6+zRbClrSH1R7tcn6EI2r+MOBzJ18
 bNAWRHiBn//d1kVyI4fFx3MWqA9Z+tXNjePuVCS/aN4ejTlL1e7ADnvGrMkY6QP6tf5MGe
 r4AcIB8+BaEGa/eqSKTBUtZZFkAGC8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733994194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8G0gK2HdIthI8Y0RYFwLhnO7pYPlTSAVhIEVygmoG5g=;
 b=L7kuafeS7KacjdVHcaiIZnh9cPu4hdGyPYuAv5Ni4FYZgvqYGeFYZeoHqeYeIuQa2rQRuD
 SIAJp1uIGT9bRYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E787113508;
 Thu, 12 Dec 2024 09:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IgZfN9GmWmdqBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 12 Dec 2024 09:03:13 +0000
Date: Thu, 12 Dec 2024 10:03:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z1qmxy2HiStDWu1g@rei.lan>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-5-chrubis@suse.cz>
 <20241211001106.GE386508@pevik> <Z1lg6tNdAzzL2UAh@rei.lan>
 <20241211193652.GC443680@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241211193652.GC443680@pevik>
X-Rspamd-Queue-Id: 05D691F399
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] lib/tst_res_.c: Add TBROK handler + more
 verbose errors
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
> > In the end both of these functions increment counters, but in this case
> > we need to return to the shell so we cannot call tst_brk() in the
> > helper. It's a very special situation here.
> 
> Thanks for info. Maybe a little note anywhere (e.g. commit message) would help.

Will do.

> > > Also we have TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN check to not
> > > add TBROK to tst_res_().
> 
> > That only works when the value is constant, if you pass via variable
> > that is not constant at build time you can pass whatever you want. Which
> > is another reason why it makes sense to relax the constraints.
> 
> Good point. So you plan to remove these build time checks?

For tst_brk() these checks are removed in my patchset that changes how
TBROK is propagated, so that tst_brk() works with TFAIL and TPASS as
well.

We also had a discussion about removing TWARN since there is not a big
difference between TBROK and TWARN and replacing TWARN with
tst_res(TBROK, ...) as that would make things simpler. Currently there
is no good rule where to use TBROK and where TWARN so removing TWARN
sounds like a good option.

> Also we have nice docs from you include/tst_res_flags.h.
> ATM include/tst_test.h and doc/old/C-Test-API.asciidoc are outdated,
> but if you relax allowed ttype, than it would not need to be updated.
> 
> Also, any reason to not support TWARN?

See above.

> I suppose we don't need TERRNO, TTERRNO, TRERRNO (not supported by tst_test.sh).

Yes, errno is not defined in shell.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
