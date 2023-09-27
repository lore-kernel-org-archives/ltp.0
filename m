Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA89E80AA2
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 07:42:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 497833CDC7C
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 09:42:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09BC3C88C8
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 09:42:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C2B441001F4E
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 09:42:29 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9766F1F897
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 07:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695800548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lcaaCzogPSM/j4pW30wFWo3hEChGbmrJaAjFJ1a8KnI=;
 b=FxMHuVgKlmidnD0IPJHkwIjoKC1s3G4qEah2/7e5fH8yGAYDvqUqurMbiGDf1WTkck3NzM
 oMLiekJBRqGd1gPvJRBNVcdZgwGbrWpqiL8UNf6NSNIl1Yi8ioxRpFZbyr0ISOsHTFFKks
 +afvgLr+gilDesJohH4DuLDf3nhAXb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695800548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lcaaCzogPSM/j4pW30wFWo3hEChGbmrJaAjFJ1a8KnI=;
 b=kAsguzJCrX+GiE/Z9DEkZOd/Tal5fliUuHLqVuCL4xVOehX36zulCglEBz4S5Kw8ekVny0
 dCS1nveR8y8d2DCw==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4D2912C142;
 Wed, 27 Sep 2023 07:42:28 +0000 (UTC)
References: <20230926090101.7565-1-rpalethorpe@suse.com>
 <20230927062716.GF205174@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Sep 2023 08:29:22 +0100
Organization: Linux Private Site
In-reply-to: <20230927062716.GF205174@pevik>
Message-ID: <87pm24dpul.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi all,
>
>> Can be built with `docker/podman build .`. Then run with `podman -it
>> run sh`. It contains Kirk in /opt/kirk. So `cd /opt/kirk && ./kirk -f
>> ltp --run-suite syscalls` will run some tests.
>> ---
>
>> Hello,
>
>> This builds and installs the LTP and Kirk inside an Alpine
>> container. The idea is to use a standard container workflow to build
>> and run the LTP from source. This helps with testing LTP itself and
>> running tests inside a container.
>
>> I'd like to add some container files to upstream to help with various
>> workflows.
>
>> The container has a number of problems:
>
>> 1. If the Git directory has build artifacts in it, these are copied
>>    into the container (.dockerignore may help)
>> 2. The resulting container is quite large (possibly due to debug symbols)
>> 3. Where should we put container files and how should we name them?
>> 4. Making the slightest change results in a complete container rebuild
>
>> Note that SUSE publishes a TW container based on our packaging system:
>> https://build.opensuse.org/project/show/benchmark:ltp:devel
>> https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*
>
>> Also, for developing tests, it may be better to build the LTP outside
>> of a container then copy in the files.
>
>> +++ b/Containerfile
>> @@ -0,0 +1,35 @@
>> +FROM alpine:3.18 AS build
>
> Maybe we could use ARG and ENV to allow user to decide which distro to use.
> https://stackoverflow.com/questions/76091578/is-it-possible-to-use-an-environment-variable-in-the-from-instruction-of-a-docke
> This way we could use various scripts in ci.

Sounds good assuming it does not make the container file too
complicated. The scripts you made have been really helpful.

>
>> +ARG LTPROOT=/opt/ltp
>> +
>> +RUN mkdir /build
>> +WORKDIR /build
>> +COPY . /build
>> +RUN ./ci/alpine.sh
>> +RUN ./build.sh -p $LTPROOT -i
>> +
>> +FROM alpine:3.18
> Also here.
>
>> +ARG LTPROOT=/opt/ltp
>> +ARG KIRKROOT=/opt/kirk
>> +
>> +RUN apk add \
>> +            acl \
>> +            keyutils \
>> +            libaio \
>> +            libacl \
>> +            libcap \
>> +            libselinux \
>> +            libsepol \
>> +            libtirpc \
>> +            numactl \
>> +            openssl \
>> +            py3-msgpack
> This somehow emulates ./ci/alpine.sh (i.e. ./ci/alpine.sh has keyutils-dev,
> which should install also keyutils as a dependency). We could add a mechanism to
> ci scripts to install runtime dependencies (e.g. './ci/alpine.sh runtime' would
> install all runtime dependencies, './ci/alpine.sh runtime-syscalls' would
> install only runtime dependencies for syscalls).

How about, for now, just an optional 'runtime' flag that only installs
runtime deps?

>
> But better would be to move runtime dependencies to kirk. But unfortunately this
> part from original Cyril's perl based runltp-ng was not ported to new Andrea's
> python based runltp-ng/kirk.

Well we could also make an Alpine, Flatpack, Nix package or any number
of other ways to build LTP and install the deps. Andrea deliberately
chose to decouple that from Kirk. However you could pass the CI scripts
to Kirk during test setup. It's just that those scripts don't live
inside the Kirk repo.

>
> Kind regards,
> Petr
>
>> +
>> +COPY --from=build $LTPROOT $LTPROOT
>> +ENV LTPROOT=$LTPROOT
>> +ENV PATH=$LTPROOT/testcases/bin:$LTPROOT/bin:$PATH
>> +
>> +RUN mkdir -p $KIRKROOT
>> +COPY --from=build /build/tools/kirk $KIRKROOT
>> +
>> +RUN adduser -D -g "Unprivileged LTP user" ltp
>> +RUN su ltp


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
