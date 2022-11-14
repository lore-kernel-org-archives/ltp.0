Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BE3C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 13:46:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 218053CD24B
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 14:46:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B91243CD213
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 14:46:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D0330680E50
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 14:46:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 091F622AAA;
 Mon, 14 Nov 2022 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668433571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yP/7p2iZZVxakWvbW+UobHC8JUmF6oa6JKZG/dI4uc4=;
 b=gm4ELlSchEvl9IzFLHeB5bQSuPbtJYYAJ5pVbUijPTfqBIf8yEfP0SD0mK1Xxy7uoeawjG
 TDUj+ixF+0WgDjGpzxkSEiDt/3vR1DB6E+XugPVH+ASup+SGAJWjqvXFMO8KEn70Uc1SU+
 2uMpPEAWeJKKFyVeK8BDNXyMqAXF3ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668433571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yP/7p2iZZVxakWvbW+UobHC8JUmF6oa6JKZG/dI4uc4=;
 b=t949lDWDqt1qfrvg4H46E7yiI1Be3ABpPLCuD/ZcPObI7umca9BlAQ8vj7agh6acz9gFH6
 eCORj2WrAnUbAIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E272B13A92;
 Mon, 14 Nov 2022 13:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m/LtNaJGcmMRUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 14 Nov 2022 13:46:10 +0000
Date: Mon, 14 Nov 2022 14:46:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y3JGoc2V7VjR0q9Z@pevik>
References: <20221110145429.8158-1-pvorel@suse.cz>
 <8735alu4bp.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8735alu4bp.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] README.md: Document IRC
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

Hi Richie,

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > changes v1->v2
> > * s/on/at/

> > Kind regards,
> > Petr

> >  README.md | 3 +++
> >  1 file changed, 3 insertions(+)

> > diff --git a/README.md b/README.md
> > index d45d1ee44..89b2640c1 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -22,6 +22,9 @@ http://lists.linux.it/listinfo/ltp
> >  LTP mailing list is archived at:
> >  https://lore.kernel.org/ltp/

> > +IRC
> > +#ltp at https://libera.chat/[irc.libera.chat]

Hi Richie,

> Won't the # make it a top level heading?
Well, that would be if there was a separate line between those two lines.

> https://daringfireball.net/projects/markdown/syntax#header

Thus this would work. But I put asciidoc syntax (used in our wiki),
instead of markdown.

Therefore the correct syntax for README.md is:

IRC #ltp at: [https://libera.chat/](irc.libera.chat)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
