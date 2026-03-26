Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4321310A88E5
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 16:42:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF1DC3CF08F
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 17:42:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 546203C2B27
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 17:42:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E6E7860192C
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 17:42:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B07C64D3DE;
 Thu, 26 Mar 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774543351;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SpDAfsWpzpkbmOxpR/N8ArBatb6weKRmVJf+xiBYhQ=;
 b=dV/f6p7NTTO3lLf+Yhz+KuAsdT3RBhYS/ij95Hl9S3eVdEPJAz4dtV+WqM4kX8+hOWCWj+
 PDPHZYED55jx5bxDjHHnlqRDuS9k2IbjqikmXzVQXQGmcddGgx3Xv23j5bheympihIpqDX
 7i4QKuUGYpB63Xpjk7GoFxymS4xRhUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774543351;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SpDAfsWpzpkbmOxpR/N8ArBatb6weKRmVJf+xiBYhQ=;
 b=f+stPMnDLD0ZFpz1RNZ1bRPRxDullSxOcdm3ucBuZEMoy4K957wgQH6uuQtnQXKW7JslTQ
 aOFEfKkA2xlwymDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774543350;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SpDAfsWpzpkbmOxpR/N8ArBatb6weKRmVJf+xiBYhQ=;
 b=q/9E1bE3TQT6Itf1FFaGZSm2zXfZCHzMzeqrDEV+/7EcWeOQc0eMfxk1IRzllLFcZezG9G
 Nm5tt8ZiyNeZPAddOpsgixLHPwFw6vzM164tWZU429CUwr4Nan5qErwSuL7Sn8GjTKvnmw
 GrmT28/dpjXitcfFbBdracL8pAuAEQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774543350;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SpDAfsWpzpkbmOxpR/N8ArBatb6weKRmVJf+xiBYhQ=;
 b=zb2ew4o7Kw15cQT6dM0g+Cds/31y2VwAb8A9SRNqUA0T64dPZwll4OPao1xZat465klPRl
 EEPZ5zV3ZwA2DFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 170594A0A3;
 Thu, 26 Mar 2026 16:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 28x1AvZhxWkiNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 16:42:30 +0000
Date: Thu, 26 Mar 2026 17:42:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <20260326164223.GB11710@pevik>
References: <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
 <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
 <20260325091003.GA86256@pevik>
 <20260325092156.3sxnn26nlejzzygn@lida.tpb.lab.eng.brq.redhat.com>
 <acOs7mrlNceEtchW@yuki.lan>
 <20260325094215.aiv3he5pdgm2v4fn@lida.tpb.lab.eng.brq.redhat.com>
 <acOxlitfqdMfAbZs@yuki.lan> <20260325135723.GA121486@pevik>
 <20260325145243.daqrazagomckexgj@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325145243.daqrazagomckexgj@lida.tpb.lab.eng.brq.redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [RFC PATCH 1/1] LTP tests: Run
 without LTP_REPRODUCIBLE_OUTPUT=1
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On  Wed  2026-03-25  14:57 , Petr Vorel wrote:
> > > Hi!
> > > > > > That sounds reasonable to me.  Which one would you prefer to
> > > > > > keep?  I'm inclined to suggest keeping LTP_REPRODUCIBLE_OUTPUT
> > > > > > and dropping LTP_QUIET but no really strong preference on my
> > > > > > side.  Thoughts?

> > > > > Maybe we can finally implement proper debug levels in LTP. E.g. hide
> > > > > TINFO and TWARN messages with debug level 0 and default to debug level
> > > > > 1. With debug level 2 we would show TDEBUG as well and with debug level
> > > > > 3 we would show TDEBUG messages for library too.

> > > > That would require running valgrind tests with something like
> > > > debug level -1 ;) because what LTP_REPRODUCIBLE_OUTPUT actually
> > > > does is that it hides testrun specific output like e.g. testrun
> > > > specific addresses, temporary file names etc.

> > > The LTP_REPRODUCIBLE_OUTPUT would have to stay, but the LTP_QUITE would
> > > have been replaced by different debug levels.

> > I thought just remove LTP_QUITE and control everything with
> > LTP_REPRODUCIBLE_OUTPUT.

> Sounds fine, Petr.  For Valgrind testing, the functionality of
> both LTP_REPRODUCIBLE_OUTPUT and LTP_QUIET is useful.  But
> there's no need to control the two features independently.
> Merging the functionality under one controlling env var works
> perfectly fine from the Valgrind testsuite perspective.

I prefer to keep LTP_REPRODUCIBLE_OUTPUT as variable name (with merged
functionality of both). 1) We have LTP_ENABLE_DEBUG, so one would expect
LTP_ENABLE_DEBUG and LTP_QUIET are mutually exclusive.
2) IMHO it's more about the reproducibility of the results.

Kind regards,
Petr

> Thanks,
> Martin

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
