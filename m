Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43C9E80A96
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 06:27:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8B883CDC29
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 08:27:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE0CA3C996C
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 08:27:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E699C601BB6
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 08:27:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C71F821872;
 Wed, 27 Sep 2023 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695796037;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZ5t7tx9/P40/9MBNQJG/50xc/h2dTVy1jXBaPQr5T4=;
 b=RKmsxKO7LGfRCB3I37JbbvfWESImb//VEFysa6CLHfUUEbR34zvjLQxTFEjZ8opystBmkD
 XKAnasZ5Z2fQncyxBN5OIIhoyl8Q7hnVMSXWiKen00jbhrZ4RI+PRI652X5zOGHoNJ7S5r
 s1hijq2g7I90HwicT5TSTJQBfW6Zg3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695796037;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZ5t7tx9/P40/9MBNQJG/50xc/h2dTVy1jXBaPQr5T4=;
 b=HiOFj+NzrrVt/dkeagWlXXFsyA3jpz93KalnHaBl1ndfdBY6G4FNMZYk1uj163JkGxk6I3
 WkBFTz1EsueHURAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACD0113479;
 Wed, 27 Sep 2023 06:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uzbkKEXLE2XLIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 06:27:17 +0000
Date: Wed, 27 Sep 2023 08:27:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20230927062716.GF205174@pevik>
References: <20230926090101.7565-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230926090101.7565-1-rpalethorpe@suse.com>
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

> Can be built with `docker/podman build .`. Then run with `podman -it
> run sh`. It contains Kirk in /opt/kirk. So `cd /opt/kirk && ./kirk -f
> ltp --run-suite syscalls` will run some tests.
> ---

> Hello,

> This builds and installs the LTP and Kirk inside an Alpine
> container. The idea is to use a standard container workflow to build
> and run the LTP from source. This helps with testing LTP itself and
> running tests inside a container.

> I'd like to add some container files to upstream to help with various
> workflows.

> The container has a number of problems:

> 1. If the Git directory has build artifacts in it, these are copied
>    into the container (.dockerignore may help)
> 2. The resulting container is quite large (possibly due to debug symbols)
> 3. Where should we put container files and how should we name them?
> 4. Making the slightest change results in a complete container rebuild

> Note that SUSE publishes a TW container based on our packaging system:
> https://build.opensuse.org/project/show/benchmark:ltp:devel
> https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*

> Also, for developing tests, it may be better to build the LTP outside
> of a container then copy in the files.

> +++ b/Containerfile
> @@ -0,0 +1,35 @@
> +FROM alpine:3.18 AS build

Maybe we could use ARG and ENV to allow user to decide which distro to use.
https://stackoverflow.com/questions/76091578/is-it-possible-to-use-an-environment-variable-in-the-from-instruction-of-a-docke
This way we could use various scripts in ci.

> +ARG LTPROOT=/opt/ltp
> +
> +RUN mkdir /build
> +WORKDIR /build
> +COPY . /build
> +RUN ./ci/alpine.sh
> +RUN ./build.sh -p $LTPROOT -i
> +
> +FROM alpine:3.18
Also here.

> +ARG LTPROOT=/opt/ltp
> +ARG KIRKROOT=/opt/kirk
> +
> +RUN apk add \
> +            acl \
> +            keyutils \
> +            libaio \
> +            libacl \
> +            libcap \
> +            libselinux \
> +            libsepol \
> +            libtirpc \
> +            numactl \
> +            openssl \
> +            py3-msgpack
This somehow emulates ./ci/alpine.sh (i.e. ./ci/alpine.sh has keyutils-dev,
which should install also keyutils as a dependency). We could add a mechanism to
ci scripts to install runtime dependencies (e.g. './ci/alpine.sh runtime' would
install all runtime dependencies, './ci/alpine.sh runtime-syscalls' would
install only runtime dependencies for syscalls).

But better would be to move runtime dependencies to kirk. But unfortunately this
part from original Cyril's perl based runltp-ng was not ported to new Andrea's
python based runltp-ng/kirk.

Kind regards,
Petr

> +
> +COPY --from=build $LTPROOT $LTPROOT
> +ENV LTPROOT=$LTPROOT
> +ENV PATH=$LTPROOT/testcases/bin:$LTPROOT/bin:$PATH
> +
> +RUN mkdir -p $KIRKROOT
> +COPY --from=build /build/tools/kirk $KIRKROOT
> +
> +RUN adduser -D -g "Unprivileged LTP user" ltp
> +RUN su ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
