Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD210CE7AFC
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 18:11:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AED393CFB6C
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 20:11:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2DC3CD44D
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 20:11:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 22DF51BB9FD1
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 20:11:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00B9A1F88F;
 Thu, 28 Sep 2023 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695924686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SsaVjPBAhaj+RV6UC9zWyGftP+/vPSYw0/vPZox+Crc=;
 b=21LW1dUTvsF/UTG22OFYoj9muVilS9TLPhLXnoZCxHgOko5smZ+PAmtUWpriGLrR6SQv4u
 I4anPJsh8BRBVS5cZGiLHg9X6ikcqPxqpCM8dqiFG0RWVG2crnDdgtXTGnKcn2YDKEPf04
 BL8BMBIoGA7ytsUNizbLGWLXm1e9Qcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695924686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SsaVjPBAhaj+RV6UC9zWyGftP+/vPSYw0/vPZox+Crc=;
 b=BYPe4z/NIbjEyTDyIwcCeQeKQP49lulhCGttxXnVOQDp00jqtVMnFtVcMhAqjNO0D0oKBZ
 ejn87iUoOrWp62CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B959F138E9;
 Thu, 28 Sep 2023 18:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bllUK83BFWVteQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 28 Sep 2023 18:11:25 +0000
Date: Thu, 28 Sep 2023 20:11:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20230928181124.GA309263@pevik>
References: <20230928104458.12115-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230928104458.12115-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add simple Containerfile
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

I suppose this is v2 of "[RFC] Add simple Alpine container" [1], thus I set [1]
in patchwork as superseded.

This LGTM, thanks! Minor comments below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> This adds a regular container (or Docker) file which builds LTP from
> source. This is initially intended for testing the LTP itself.

> The resulting container has just the LTP installation and runtime
> dependencies. However it is still quite large, probably due to debug
> symbols.

> The container can be built with a command like:

> podman build -t tumbleweed/ltp \
>        --build-arg PREFIX=registry.opensuse.org/opensuse/ \
>        --build-arg DISTRO_NAME=tumbleweed \
>        --build-arg DISTRO_RELEASE=20230925 .

> Or just

> podman build -t alpine/ltp .

> It contains Kirk in /opt/kirk. So

> cd /opt/kirk && ./kirk -f ltp -r syscalls

> will run some tests.

> Note a much smaller container can be found at:
> https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*
> This is created with SUSE's build system which does not use container files

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Petr Vorel <pvorel@suse.cz>
> Cc: Marius Kittler <mkittler@suse.de>
> ---

> RFC comments:
>     * Add git clean -fdX which should remove any build artifacts
>       this is different from the suggestion of just doing a check. I just
>       found it easier to remove the build files.
FYI what we do in release scripts, is to do a local clone to a different
directory [2]:
git clone ltp ltp-full-YYYYMMDD

Not sure what is faster.

>     * Added seperate alpine and tumbleweed runtime scripts. Again it's
>       different from the suggestion just because it's easier to add
>       seperate scripts than adding a switch
+1

But maybe put it into container directory, because it's not used in GitHub CI?

>     * Obviously a number of distros are missing runtime scripts. They can
>       be added when someone is motivated to do so.

+1

> diff --git a/.dockerignore b/.dockerignore
> new file mode 100644
> index 000000000..bbcd7072f
> --- /dev/null
> +++ b/.dockerignore
> @@ -0,0 +1 @@
> +Containerfile
> diff --git a/Containerfile b/Containerfile
> new file mode 100644
> index 000000000..2f8192c3b
> --- /dev/null
> +++ b/Containerfile
> @@ -0,0 +1,32 @@
> +ARG PREFIX=docker.io/
> +ARG DISTRO_NAME=alpine
> +ARG DISTRO_RELEASE=3.18
> +
> +FROM $PREFIX$DISTRO_NAME:$DISTRO_RELEASE AS build
> +ARG LTPROOT=/opt/ltp
> +ARG DISTRO_NAME=alpine
> +ARG DISTRO_RELEASE=3.18
> +
> +RUN mkdir /build
> +WORKDIR /build
> +COPY . /build
> +RUN ./ci/${DISTRO_NAME}.sh
> +RUN git clean -fdX
> +RUN ./build.sh -p $LTPROOT -i
> +
> +FROM $PREFIX$DISTRO_NAME:$DISTRO_RELEASE
> +ARG LTPROOT=/opt/ltp
> +ARG KIRKROOT=/opt/kirk
> +ARG DISTRO_NAME=alpine
> +
> +COPY --from=build /build/ci/${DISTRO_NAME}-runtime.sh $LTPROOT/runtime-deps.sh
> +RUN $LTPROOT/runtime-deps.sh
> +
> +COPY --from=build $LTPROOT $LTPROOT
> +ENV LTPROOT=$LTPROOT
> +ENV PATH=$LTPROOT/testcases/bin:$LTPROOT/bin:$PATH
> +
> +RUN mkdir -p $KIRKROOT
> +COPY --from=build /build/tools/kirk $KIRKROOT
> +
> +USER ltp
> diff --git a/ci/alpine-runtime.sh b/ci/alpine-runtime.sh
> new file mode 100755
> index 000000000..e4941f329
> --- /dev/null
> +++ b/ci/alpine-runtime.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh -eux

nit: out of curiosity, why -u (fail unset variables and parameters)?
> +
> +apk add \
> +        acl \
> +        keyutils \
> +        libaio \
> +        libacl \
> +        libcap \
> +        libselinux \
> +        libsepol \
> +        libtirpc \
> +        numactl \
> +        openssl \
> +        py3-msgpack

I'd add more runtime packages (at least for syscalls).  If I manage next week to
test this I might ask for more packages, but let's start with this

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20230926090101.7565-1-rpalethorpe@suse.com/
[2] https://patchwork.ozlabs.org/project/ltp/patch/20230927202121.300325-6-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
