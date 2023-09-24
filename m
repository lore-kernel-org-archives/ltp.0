Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CE4CE7A8C
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 21:14:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50E943CDDDC
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 23:14:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BC193CBDC6
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 23:14:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3A4581A007E3
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 23:14:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D287621860;
 Sun, 24 Sep 2023 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695590055;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OZ6H9JkQDp0s7xzkOqBirjunb5L8pQgVMEseOgSKcn4=;
 b=vNDqbjG7vZKqxH4vINnuEDOTkDozE+s8s9GST4ZhRbmQMiiSImEY6eVB0c9nE6h/FuerEN
 l8pIp6S5B/KOF7umDuRmJGAsgqI1NY/6Vx/ANv/7iMgGabyP3Y0cx6n76yvpzIFzaCuYvB
 FXa8kdhfKUZEMo54npThbQr4ioSuH6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695590055;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OZ6H9JkQDp0s7xzkOqBirjunb5L8pQgVMEseOgSKcn4=;
 b=4tdvLtOGwdZUTKJdZZr7Qocp82n7nTPjQswuo6gZWLOj45a1xw0/GxTsTuEeGzHhuT2Prg
 NNBih7SKo4/n7+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AD2413581;
 Sun, 24 Sep 2023 21:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qEhvHKemEGW+SwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 24 Sep 2023 21:14:15 +0000
Date: Sun, 24 Sep 2023 23:14:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230924211413.GA688740@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz>
 <CAEemH2ektE-0Fdu49_4xN5wtq9=jPehHXDVrAPSG3FZ763rTDw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ektE-0Fdu49_4xN5wtq9=jPehHXDVrAPSG3FZ763rTDw@mail.gmail.com>
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

Hi Li,

> Hi Petr,

...
> > -1. Tag the git
> > +1. Release eve work
> > +-------------------
> > +
> > +a. Collecting the (must have) patch list for new release
> > +b. Reviewing and merging the patch list of (a.)
> > +c. Widely testing, explicitly post results
> > +d. Tiny fix according to release testing
> > +e. Writing release note
> > +
> > +2. Tag the git
> >  --------------

> > +Use './tools/tag-release.sh' script, which creates the tag and push it to
> > github.
> >  [source,sh]
> >  --------------------------------------------------------------------
> > -cd ltp
> > -echo YYYYMMDD > VERSION
> > -git commit -s -m 'LTP YYYYMMDD' VERSION
> > -git tag -a YYYYMMDD -m 'LTP YYYYMMDD'
> > ---------------------------------------------------------------------

> What about adding those manual steps into tag-release.sh as code comments?
> That'd be helpful to people who never do release work to try that first
> time.

Good point, makes sense.
I suppose you mean to bput them at the top like this:

#!/bin/sh
# Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
# Create tarballs and metadata for uploading after tagging release.
# https://github.com/linux-test-project/ltp/wiki/LTP-Release-Procedure 
# echo YYYYMMDD > VERSION
# git commit -s -m 'LTP YYYYMMDD' VERSION
# git tag -a YYYYMMDD -m 'LTP YYYYMMDD'
set -e
...
Because there are comments at the top of each "section" (e.g. # git clone
(local))

...
> > -cd ..
> > -git clone ltp ltp-full-YYYYMMDD
> > -cd ltp-full-YYYYMMDD
> > -# Update mce-inject submodule
> > -git submodule init
> > -git submodule update
> > -# Generate configure script
> > -make autotools
> > -# Prepare the archives
> > -cd ..
> > -tar -cjf ltp-full-YYYYMMDD.tar.bz2 ltp-full-YYYYMMDD --exclude .git
> > -tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git

> I suggest adding these into create-tarballs-metadata.sh comments as well.

# git clone ltp ltp-full-YYYYMMDD && cd -
# git submodule update --init
# make autotools
# cd ..
# tar -cjf ltp-full-YYYYMMDD.tar.bz2 ltp-full-YYYYMMDD --exclude .git
# tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git
# sha256sum ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha256

(Adding all checksums would look to me quite verbose (6 lines), but I can add
them.)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
