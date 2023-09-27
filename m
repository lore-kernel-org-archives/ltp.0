Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D652E810AD
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 09:05:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4EDF3CDC30
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 11:05:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A3353C9944
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 11:05:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5EB22601BC0
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 11:05:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F7412190C;
 Wed, 27 Sep 2023 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695805536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjtYTC5oLLOMpC55WA+V7M9n0zWsrts3JiiKFe+5M+g=;
 b=VYQvlgCUwfqhELqHv1jJOM/sGVDakslaUuu1YV/Ze8mzaDotj5/r27EUWPdpEcr9Mq6LAH
 Nq7pT6hh5LhojUuisQcolaxZB7vEtMPkg6noeAvLnBBYWra4xyCqKn3kPXPWYXZmqji596
 0gIP9EcW21fID+qUrVe5KLvEonxoVCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695805536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjtYTC5oLLOMpC55WA+V7M9n0zWsrts3JiiKFe+5M+g=;
 b=kymObks0+5o/Y+fTa5WdPwfBQn16gwWApo8XC91l3jSAgP3WVn2xjc+Y/kO8ouyHPmCp2S
 AyLadVaPUC3suxBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 645981338F;
 Wed, 27 Sep 2023 09:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ISmMF2DwE2UuAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 09:05:36 +0000
Date: Wed, 27 Sep 2023 11:05:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230927090534.GA225232@pevik>
References: <20230926090101.7565-1-rpalethorpe@suse.com>
 <20230927062716.GF205174@pevik> <87pm24dpul.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pm24dpul.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] Add simple Alpine container
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

Hi all,

...
> >> +++ b/Containerfile
> >> @@ -0,0 +1,35 @@
> >> +FROM alpine:3.18 AS build

> > Maybe we could use ARG and ENV to allow user to decide which distro to use.
> > https://stackoverflow.com/questions/76091578/is-it-possible-to-use-an-environment-variable-in-the-from-instruction-of-a-docke
> > This way we could use various scripts in ci.

> Sounds good assuming it does not make the container file too
> complicated. The scripts you made have been really helpful.

+1. We would need at least some comment. If there are more things to say, it
might be useful to have a wiki page about container based testing (if you have
time and energy to write it).

> >> +ARG LTPROOT=/opt/ltp
> >> +
> >> +RUN mkdir /build
> >> +WORKDIR /build
> >> +COPY . /build
> >> +RUN ./ci/alpine.sh
> >> +RUN ./build.sh -p $LTPROOT -i
> >> +
> >> +FROM alpine:3.18
> > Also here.

> >> +ARG LTPROOT=/opt/ltp
> >> +ARG KIRKROOT=/opt/kirk
> >> +
> >> +RUN apk add \
> >> +            acl \
> >> +            keyutils \
> >> +            libaio \
> >> +            libacl \
> >> +            libcap \
> >> +            libselinux \
> >> +            libsepol \
> >> +            libtirpc \
> >> +            numactl \
> >> +            openssl \
> >> +            py3-msgpack
> > This somehow emulates ./ci/alpine.sh (i.e. ./ci/alpine.sh has keyutils-dev,
> > which should install also keyutils as a dependency). We could add a mechanism to
> > ci scripts to install runtime dependencies (e.g. './ci/alpine.sh runtime' would
> > install all runtime dependencies, './ci/alpine.sh runtime-syscalls' would
> > install only runtime dependencies for syscalls).

> How about, for now, just an optional 'runtime' flag that only installs
> runtime deps?

Sure, no problem. The real work is to identify these runtime dependencies.
I mean not libraries without development headers (headers does not take that
much size, thus I would not bother), but various other tools (e.g. ip,
ping, mkfs.*, useradd, quotacheck, e4crypt, exportfs, modprobe, rmmod, ...) Some
of them are installed on normal distro, but not all; for sure most of them
aren't installed in the default container.

> > But better would be to move runtime dependencies to kirk. But unfortunately this
> > part from original Cyril's perl based runltp-ng was not ported to new Andrea's
> > python based runltp-ng/kirk.

> Well we could also make an Alpine, Flatpack, Nix package or any number
> of other ways to build LTP and install the deps. Andrea deliberately
> chose to decouple that from Kirk. However you could pass the CI scripts
I'm not sure if that was a correct decision. Sure, it might be easier to
maintain scripts like this in the projects kirk runs (e.g. LTP, Kselftest),
but OTOH I see a benefit in having unified interface for all project
(or at least run these upstreamed scripts in kirk in unified way).

> to Kirk during test setup. It's just that those scripts don't live
> inside the Kirk repo.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
