Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFCFE743F3
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 07:58:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D7BE3CDE37
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 09:58:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BBAC3CBA50
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 09:58:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB4D71A04354
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 09:58:10 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 18EC11F88F
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695974287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rzztdK9w667dSyDYo+agLF3miRTJLBlFHgkY3h45vkk=;
 b=quRCbVkrehWTdL/uJ8fDbsJUHGHNqDDB/AaiC+atCif5eW3ZMApdImccM2SMVJP+38naeF
 HfL3u5vtuhDIqM955yhOghbBFwbDm2OqQ/lQ2rOxndHe/V72DedJDlM2daCnxa5+Xa67Zi
 iiltfuVQPZldWEjxGxSb4qiYmcNMPg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695974287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rzztdK9w667dSyDYo+agLF3miRTJLBlFHgkY3h45vkk=;
 b=kx0Q73cDmdFMejBr6nuF9lV7fQudtWtjuplKM08NmX7yMsQoGuLe22h+5e74yAbEU5Pdt+
 WDacmvw1ITxTFbCw==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B7CF92C142;
 Fri, 29 Sep 2023 07:58:06 +0000 (UTC)
References: <20230928104458.12115-1-rpalethorpe@suse.com>
 <20230928181124.GA309263@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Sep 2023 08:42:59 +0100
Organization: Linux Private Site
In-reply-to: <20230928181124.GA309263@pevik>
Message-ID: <87h6nde7hu.fsf@suse.de>
MIME-Version: 1.0
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> I suppose this is v2 of "[RFC] Add simple Alpine container" [1], thus I set [1]
> in patchwork as superseded.
>
> This LGTM, thanks! Minor comments below.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> This adds a regular container (or Docker) file which builds LTP from
>> source. This is initially intended for testing the LTP itself.
>
>> The resulting container has just the LTP installation and runtime
>> dependencies. However it is still quite large, probably due to debug
>> symbols.
>
>> The container can be built with a command like:
>
>> podman build -t tumbleweed/ltp \
>>        --build-arg PREFIX=registry.opensuse.org/opensuse/ \
>>        --build-arg DISTRO_NAME=tumbleweed \
>>        --build-arg DISTRO_RELEASE=20230925 .
>
>> Or just
>
>> podman build -t alpine/ltp .
>
>> It contains Kirk in /opt/kirk. So
>
>> cd /opt/kirk && ./kirk -f ltp -r syscalls
>
>> will run some tests.
>
>> Note a much smaller container can be found at:
>> https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*
>> This is created with SUSE's build system which does not use container files
>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Cc: Petr Vorel <pvorel@suse.cz>
>> Cc: Marius Kittler <mkittler@suse.de>
>> ---
>
>> RFC comments:
>>     * Add git clean -fdX which should remove any build artifacts
>>       this is different from the suggestion of just doing a check. I just
>>       found it easier to remove the build files.
> FYI what we do in release scripts, is to do a local clone to a different
> directory [2]:
> git clone ltp ltp-full-YYYYMMDD
>
> Not sure what is faster.

I guess that is something a script could also do then 'git clean'
becomes a null op. git clean -X will only remove untracked files so
pending changes should get picked up. Which is probably what people want
during development. Doing a fresh checkout is probably more like a hard
reset and clean.

AFAICT git clean is very quick, far faster than 'make distclean'.

>
>>     * Added seperate alpine and tumbleweed runtime scripts. Again it's
>>       different from the suggestion just because it's easier to add
>>       seperate scripts than adding a switch
> +1
>
> But maybe put it into container directory, because it's not used in
> GitHub CI?

I was thinking it could be used in CI. All we need is a CI that runs VMs
and we can do some testing. (e.g. srchut).

>
>>     * Obviously a number of distros are missing runtime scripts. They can
>>       be added when someone is motivated to do so.
>
> +1
>
>> diff --git a/.dockerignore b/.dockerignore
>> new file mode 100644
>> index 000000000..bbcd7072f
>> --- /dev/null
>> +++ b/.dockerignore
>> @@ -0,0 +1 @@
>> +Containerfile
>> diff --git a/Containerfile b/Containerfile
>> new file mode 100644
>> index 000000000..2f8192c3b
>> --- /dev/null
>> +++ b/Containerfile
>> @@ -0,0 +1,32 @@
>> +ARG PREFIX=docker.io/
>> +ARG DISTRO_NAME=alpine
>> +ARG DISTRO_RELEASE=3.18
>> +
>> +FROM $PREFIX$DISTRO_NAME:$DISTRO_RELEASE AS build
>> +ARG LTPROOT=/opt/ltp
>> +ARG DISTRO_NAME=alpine
>> +ARG DISTRO_RELEASE=3.18
>> +
>> +RUN mkdir /build
>> +WORKDIR /build
>> +COPY . /build
>> +RUN ./ci/${DISTRO_NAME}.sh
>> +RUN git clean -fdX
>> +RUN ./build.sh -p $LTPROOT -i
>> +
>> +FROM $PREFIX$DISTRO_NAME:$DISTRO_RELEASE
>> +ARG LTPROOT=/opt/ltp
>> +ARG KIRKROOT=/opt/kirk
>> +ARG DISTRO_NAME=alpine
>> +
>> +COPY --from=build /build/ci/${DISTRO_NAME}-runtime.sh $LTPROOT/runtime-deps.sh
>> +RUN $LTPROOT/runtime-deps.sh
>> +
>> +COPY --from=build $LTPROOT $LTPROOT
>> +ENV LTPROOT=$LTPROOT
>> +ENV PATH=$LTPROOT/testcases/bin:$LTPROOT/bin:$PATH
>> +
>> +RUN mkdir -p $KIRKROOT
>> +COPY --from=build /build/tools/kirk $KIRKROOT
>> +
>> +USER ltp
>> diff --git a/ci/alpine-runtime.sh b/ci/alpine-runtime.sh
>> new file mode 100755
>> index 000000000..e4941f329
>> --- /dev/null
>> +++ b/ci/alpine-runtime.sh
>> @@ -0,0 +1,16 @@
>> +#!/bin/sh -eux
>
> nit: out of curiosity, why -u (fail unset variables and parameters)?

I find it finds errors in shell scripts or when using them. E.g. typo's
in env variable names. I just include it wherever possible.

>> +
>> +apk add \
>> +        acl \
>> +        keyutils \
>> +        libaio \
>> +        libacl \
>> +        libcap \
>> +        libselinux \
>> +        libsepol \
>> +        libtirpc \
>> +        numactl \
>> +        openssl \
>> +        py3-msgpack
>
> I'd add more runtime packages (at least for syscalls).  If I manage next week to
> test this I might ask for more packages, but let's start with this

+1

>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20230926090101.7565-1-rpalethorpe@suse.com/
> [2] https://patchwork.ozlabs.org/project/ltp/patch/20230927202121.300325-6-pvorel@suse.cz/


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
