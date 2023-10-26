Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD081C25B48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 09:41:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BF213CCB3A
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:41:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 549293C83DA
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:41:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A74E1401103
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:41:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81E5921ACA;
 Thu, 26 Oct 2023 09:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698313281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t3aXOLvK8AWAIv3NtmkHWiJBMktPlqwK7CKv0vYc5Ho=;
 b=VotXL5+yu2CtgU2ZCmWxFz2myu1nYTkxuTbdCkw4wzQgoCUMatyP2g4XBhhXqFL1iXqsnL
 aV77X8BCMUvi/RPBkdYfojkePxE8uyHlNHfU52ZkbqlsnNil34WSngsENGD1fJ99/+tHco
 /v8f6a3jliwXyR7omne+namXJ2VbYk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698313281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t3aXOLvK8AWAIv3NtmkHWiJBMktPlqwK7CKv0vYc5Ho=;
 b=vbzKmcG7INAa0kvpS2uWyeKxpTn/7u920+9VOCGIQGBfMfnpHaTu3Bshh/m1A8zD/wF4Si
 FUnyNeUpu1zKjnCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53591133F5;
 Thu, 26 Oct 2023 09:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FZrrEUE0OmV7NgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 09:41:21 +0000
Date: Thu, 26 Oct 2023 11:41:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Message-ID: <20231026094119.GC580291@pevik>
References: <20230926124647.152972-1-pvorel@suse.cz>
 <20230926124647.152972-3-pvorel@suse.cz> <ZRLn7-PoVhomEB-v@yuki>
 <20230926152155.GE159673@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230926152155.GE159673@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.63 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.33)[96.86%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 2/2] vma05.sh: Add check for core file
 presence
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

Hi all,

> > Hi!
> > > Maybe this sanity check is useless. WDYT?

> > I guess that it does not harm.

> Thanks for your review!

> > >  testcases/kernel/mem/vma/vma05.sh | 2 ++
> > >  1 file changed, 2 insertions(+)

> > > diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
> > > index c9e4becdb..30b1d689a 100755
> > > --- a/testcases/kernel/mem/vma/vma05.sh
> > > +++ b/testcases/kernel/mem/vma/vma05.sh
> > > @@ -54,6 +54,8 @@ vma_report_check()

> > >  	rm -rf core*
> > >  	{ vma05_vdso; } > /dev/null 2>&1
> > > +	[ -f core ] || tst_brk TCONF "missing core file"

> > TCONF or TBROK that is the question.

> I guess TBROK is better in this case. I wonder myself why I type TCONF.
> If nobody complains, I'll merge this with TBROK and your ack.

Merged with TBROK, thanks for your time.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
