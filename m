Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805E9E7E637
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 13:55:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E63B83CDC8C
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 15:55:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 892063C9956
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 15:55:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7F2A1A001B1
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 15:54:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 851391F854;
 Tue, 26 Sep 2023 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695736498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UR42ydcyW0iB2LmA0FgkqXCP16ggPOTfx2S1Oxk/0c=;
 b=Cn3NF8MLIKxBxZA5ruPiHYbqbZG6Bi6c/PiGlf0MBXVelSoef2A4V6PZ9wU4soElUkStv3
 00mkF2z2OMjWc+42m1w5kwKQcGzeMuA6mbbU3DAdQ+GwFShCbXKr7tnVDKHvcm3S8O+0gl
 sAN8v6oeweJlvsq8AUoQ5nYUANVXouE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695736498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UR42ydcyW0iB2LmA0FgkqXCP16ggPOTfx2S1Oxk/0c=;
 b=RRrBvnnBjYVfKSxI6Uv46yl3oOWhTrGNQ1a73uu6jq+Wy2NxikJ03srPcqiH92VInUKyWF
 N2uVr5aINrpCurDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 440E51390B;
 Tue, 26 Sep 2023 13:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LaY+D7LiEmXQRgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Sep 2023 13:54:58 +0000
Date: Tue, 26 Sep 2023 15:54:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230926135456.GD159673@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz> <ZRLLL_h8V8rk-H3T@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRLLL_h8V8rk-H3T@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > * Mention release preparation (Li Wang).
> > * Replace skeleton commands with the release scripts.
> > * Update link to the release announcement.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  doc/LTP-Release-Procedure.asciidoc | 111 +++++++++++++++++++++--------
> >  1 file changed, 80 insertions(+), 31 deletions(-)

> > diff --git a/doc/LTP-Release-Procedure.asciidoc b/doc/LTP-Release-Procedure.asciidoc
> > index cd7682fb8..26d85d1fa 100644
> > --- a/doc/LTP-Release-Procedure.asciidoc
> > +++ b/doc/LTP-Release-Procedure.asciidoc
> > @@ -5,54 +5,103 @@ This page contains quick summary of what needs to be done to do a LTP release. I

> >  NOTE: The string YYYYMMDD should be substituted to the current date.

> > -1. Tag the git
> > +1. Release eve work
>                ^
> 	       ?

"Eve" was suggested by Li. While it's a valid word, "preparation" would be
probably better.

> > +-------------------


> > +a. Collecting the (must have) patch list for new release
> > +b. Reviewing and merging the patch list of (a.)
> > +c. Widely testing, explicitly post results
> > +d. Tiny fix according to release testing
> > +e. Writing release note

> To be honest this list looks too sparse to be really useful, what about
> a paragraph with more detailed explanations:

> The release procedure generally takes a few weeks. In the first week or
> two patches that should go into the release are reviewed and possibly
> merged. These patches are either fixes or patches pointed out by the
> community. Patch review, when finished, is followed by a git freeze,
> which is a period where only fixes are pushed to the git. During that
> period community is expected to run a LTP pre-release tests, reports
> problems, and/or send fixes to the mailing list. In this period we are
> especially making sure that there are no regressions in the test results
> on a wide range of distributions and architectures. Once the
> stabilization period has ended the time has finally come to proceed with
> the release.

Yes, that looks much better to me.

> > +2. Tag the git
> > --------------------------
> > -[source,sh]
> > ---------------------------------------------------------------------
> > -git push
> > -git push --tags
> > +LTP 20230516

> Do we want to have the XXXXYYZZ here instead?
Sure, I'll replace it with YYYYMMDD.  I started with a real life example, but
then I removed myself...

> > +-----BEGIN PGP SIGNATURE-----
> > +
> > +iQJDBAABCAAtFiEEIBb+pIWLHDazLoM6wN7C7nLzOl8FAmRjD8sPHHB2b3JlbEBz
> > +...
> > +-----END PGP SIGNATURE-----
> > +
> > +commit 3ebc2dfa85c2445bb68d8c0d66e33c4da1e1b3a7
> > +gpg: Signature made Tue 16 May 2023 07:08:08 AM CEST
> > +gpg:                using RSA key 2016FEA4858B1C36B32E833AC0DEC2EE72F33A5F
> > +...
> > +Primary key fingerprint: 2016 FEA4 858B 1C36 B32E  833A C0DE C2EE 72F3 3A5F
> > +Author: Person-who-released LTP <foo@example.com>
> > +Date:   Tue May 16 07:08:08 2023 +0200
> > +
> > +    LTP 20230516

> And here?

> > +    Signed-off-by: Person-who-released LTP <foo@example.com>
> > +
> > +diff --git a/VERSION b/VERSION
> > +index af4c41fec..ae488c0e7 100644
> > +--- a/VERSION
> > ++++ b/VERSION
> > +@@ -1 +1 @@
> > +-20230127
> > ++20230516

> And here?


...
> >  The announcement is send to:

> >  * lwn at lwn.net
> >  * akpm at linux-foundation.org
> > -* torvalds at linux-foundation.org.
Are these mails complete? I would at least add automated-testing@lists.yoctoproject.org.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
