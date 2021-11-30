Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDFDC433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 14:26:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A10A53C71C2
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 15:26:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50F0F3C5AF0
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 15:26:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9FD21600061
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 15:26:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B2C5212BC;
 Tue, 30 Nov 2021 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638282360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWLyvwZCJNwOiEufUd+QgeSOX2aTgNjaEJKi2IWJDAo=;
 b=ZAkx6t8pISQLNh09DlZ8uQB5T4ZH+aHAouoDPThW19qY8ipF0iUHjEn9xxP/EvVOGUHG86
 USl73EO6Ei+6s5OvBJ2XwrmCNjF7ffMn/FKX6gck6e9qlESHBSGAPyNLZB1UKjJDwa5DXw
 pNgZkmdWusgHlQ/LgVrCzupOCZ+wK2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638282360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWLyvwZCJNwOiEufUd+QgeSOX2aTgNjaEJKi2IWJDAo=;
 b=DGr8cB2pK/ico8y4TNj7OtJL8Qu82N0j6+1Qrsfp4dxMk5bPdVCHMZ/OHYMqkEyH3k0Xvq
 Scm+Dow5to44ROBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65E3D13D4E;
 Tue, 30 Nov 2021 14:26:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EemkF3g0pmGQNgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 30 Nov 2021 14:26:00 +0000
Date: Tue, 30 Nov 2021 15:27:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YaY0wB2ABtq7ypBW@yuki>
References: <20211130114527.5942-1-chrubis@suse.cz>
 <87ilw9lour.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ilw9lour.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sparse: Skip TCID and TST_TOTAL
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
> > Since these are part of the old library API.
> >
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  tools/sparse/sparse-ltp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
> > index b1677d336..1a3b4089a 100644
> > --- a/tools/sparse/sparse-ltp.c
> > +++ b/tools/sparse/sparse-ltp.c
> > @@ -98,6 +98,9 @@ static void check_symbol_visibility(const struct symbol *const sym)
> >  	if (!(mod & MOD_TOPLEVEL))
> >  		return;
> >  
> > +	if (!strcmp(name, "TCID") || !strcmp(name, "TST_TOTAL"))
> > +		return;
> 
> Would it be better to print a warning that old library crap has been
> detected?

I guess so.

> My expectation is that 'make check' will produce a lot of noise if ran
> on tests which haven't even been converted to the new library. Also it's
> possible someone may forget to remove TCID etc.

Well we may as well print the warnings only if new library test is
detected. But I guess that is not an easy task since we would have to
look at the include directives even before we attempt to parse the
file..

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
