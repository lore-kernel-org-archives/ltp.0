Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B456DE80A93
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 06:44:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3443CBAE3
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 08:44:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE8223CA0AB
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 08:44:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 50361206C49
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 08:44:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EBD41F37C;
 Wed, 27 Sep 2023 06:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695797058;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+loMH2rKe4Xu8G0iL6f55x5xUsqVxraPB2bAU3TZoI=;
 b=1UzUzwG8KE6dd/ZpyzFpwBCSjCvWp8ixZRnQ1yIpjYMAq87V8bZ3nMAYnu43XWTDJywALP
 Abp4ndZPky9uDO3bOX6WFnspttdHM9P2R0iaT77t394Hg2vK1G7Ga0Rm8p9nDMUtbOgUPl
 baXZnA++RYQE0zZOwLIQ9xyu6Roe0Yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695797058;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+loMH2rKe4Xu8G0iL6f55x5xUsqVxraPB2bAU3TZoI=;
 b=2Yfu/j+SV3Xt1QlhgtjMNxO+dK/0YF3T+Q7hRJ4TSPJingHpt1pp2cmhzIUaIgs7kE0xts
 2N3Jy4/ioslLeJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE77113479;
 Wed, 27 Sep 2023 06:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1ioyOUHPE2XHLAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 06:44:17 +0000
Date: Wed, 27 Sep 2023 08:44:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230927064416.GA223090@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz>
 <CAEemH2ektE-0Fdu49_4xN5wtq9=jPehHXDVrAPSG3FZ763rTDw@mail.gmail.com>
 <20230924211413.GA688740@pevik>
 <CAEemH2du9Or2y84qF8uHWAO8_+jLfvV+1b6iwBkBdd4abUiZ3A@mail.gmail.com>
 <20230925125037.GA60471@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230925125037.GA60471@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] doc: Update release procedure
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Cyril,

...
> > > > > +Use './tools/tag-release.sh' script, which creates the tag and push
> > > it to
> > > > > github.
> > > > >  [source,sh]
> > > > >  --------------------------------------------------------------------
> > > > > -cd ltp
> > > > > -echo YYYYMMDD > VERSION
> > > > > -git commit -s -m 'LTP YYYYMMDD' VERSION
> > > > > -git tag -a YYYYMMDD -m 'LTP YYYYMMDD'
> > > > > ---------------------------------------------------------------------

> > > > What about adding those manual steps into tag-release.sh as code
> > > comments?
> > > > That'd be helpful to people who never do release work to try that first
> > > > time.

> > > Good point, makes sense.
> > > I suppose you mean to bput them at the top like this:



> > Yes, even looks verbose, but will be helpful to people who never do release
> > work.


> Sure, no problem. I put all commands.

Or how about instead of putting these commands in the script keep them in wiki
page (+ update them) and mention the script in the end? Script would also
contain link to the wiki page.
If somebody does not want to use script, he will probably find more convenient.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
