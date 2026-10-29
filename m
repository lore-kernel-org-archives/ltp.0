Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68E606A31E
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fgCUiuWu
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 742B33E5F70
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 08:04:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAE973CFD76
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 08:04:01 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1707D1400DA9
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 08:04:01 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c40db84b4b5so24892566b.1
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793257440; x=1793862240; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1ogSedVO7ZUrHOAyfG+DB0FuTjeauluI8F6LglgCR3k=;
 b=fgCUiuWuH9gUlQpmHLhVABE2FxMW9XAtnEFUS53mSULPSaSJ5xPDuTrFVIEGboLMEj
 MtDyvatXJav/Zd2GW+p4oR5Kubj17lh3HJOMGf14p+iMhriekAqv5HvRaBBrUBpLlcsv
 Tq1SolhBUcp9vghiG5ogoeAVhsVxlvEOEfwJ9qwAO2yBET17k8tplOl6S260q6i0tzj4
 X9Mv+JN5EJe7KxSzIjQ/cH87wlIYf2dseg6JGXmI3jpW18jWU7crVxXX1indHqCtz+j5
 NL5zCoBvbNvxErYFKbGox+YS3epgPlfNiPBv7w8AhWHylUei/LiXlby4/uiwFqEghtDA
 dMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793257440; x=1793862240;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1ogSedVO7ZUrHOAyfG+DB0FuTjeauluI8F6LglgCR3k=;
 b=Mjk9NHbz6ez+zBOg7VypyZkB8/02LHoXifbG++KaiUpPEDIsNxUe6j7OKIhF5UIO1u
 dYA8O2HcoJ3SpKOk/YNyXn+sR+pknuS0V6fIvFB2Sto5asxMwlOR3G96kRzy6hTNJi/l
 DveOxzlpMjihY9ShIggaoyPF/ChbNONfASnG14620nCIjT4c55AWjiS51sJfHo5MCYrh
 3wtx1jTqL1rKp1KngcSob0YAT2dEOHsZ3QjOfr6RJgollIeyDRqp4jl78Sxd7vsQXmTr
 8cAgdJ2/Ed+vKRRSCaALsr0gtBIC5Hm1ZmSsRwZumrCSZEkcdmsSFdGJNafjXQnM5T56
 vNHw==
X-Gm-Message-State: AFq9FYKoW1DXG55FHT4EJqzmwsIe0BY/k8vLhDsebTtMwDHAuzro61+9
 k6e+aW2LqKGjzOXV6tOVsrilbxP0xYFyWMH2+q/Q9YYyppS/4K+JJsrPC+YzXLODk7SDmnQku8Y
 vUSvJ
X-Gm-Gg: AYBFou0pVvG8CVtNoVUXyFYQsbRc6V+ClQv992MrFGKqNOpIJBE5i7vDzKnvI0WA2v3
 tQwgG5hCx0VakqlHTP8voA2UVBMZ+Ici7aP1FXmjC2jvWgAuKFNBXXyi2rBfyljJg0no5CdQzQ3
 vsAiOXia0amJ99NR3Ra8snlpGM99rqL7q10D6uJDjCe55rcYdIxpRm18k2Rz4Ot85cZz04uN7Te
 bcvzdTCEgU1BzE3eyyxiFSdQUJX2RaYsuh6NNkWY5dG+ylRonEIL8m5FpMewQpJlek4GRC+WbL/
 TrbwBJdbuxLaR63h6HxVdyOv1yTxipLP9VRyAP6hmryk623OtwEl6TcAHUaAL9NFzU8kfekPrAE
 T0qF+DGut5X5+I6OcYu4NZbQX5UxU5QYoIgq5L3z2aJhnm1e6ouK4Dh8Y5Bz+B3noKPQFA5YCoH
 pm988Q0Gf2Qq0na870N2mVj0Z8oRybnH68Jw3OmnYm6m6fbyaCtqgktxxz65wyVMwT3114QWXHt
 jDG14IKvmMSxFQ/1FPWnNYaeQTF4x6zf5QyIvnFULl1174RobZV+tUc2OjZQ1Ol/kcdGChI8P3W
 kUpYnJi3oqBofkqMjo4v6f51sILaq1ve7EFrb+YSB9F+sWtQPdY8+T0yfjz9ZA==
X-Received: by 2002:a17:906:66d5:b0:c49:9a88:75f6 with SMTP id
 a640c23a62f3a-c49bdedd106mr407032066b.2.1793257440394; 
 Thu, 29 Oct 2026 00:04:00 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4e9995sm690053566b.15.2026.10.29.00.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 00:03:59 -0700 (PDT)
Date: Thu, 29 Oct 2026 08:03:58 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: linuxtestproject.agent@gmail.com
Message-ID: <auLv3opnwC-lAbI2@monster>
References: <20261023123436.1274448-2-anders.roxell@linaro.org>
 <20261023175045.40320-1-linuxtestproject.agent@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261023175045.40320-1-linuxtestproject.agent@gmail.com>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: Install the .args files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2026-10-23 17:50, linuxtestproject.agent@gmail.com wrote:
> Hi Anders,
> 
> On 23 Oct 2026, Anders Roxell wrote:
> > openposix: Install the .args files
> 
> --- [PATCH 2/2] ---
> 
> > +++ b/testcases/open_posix_testsuite/scripts/generate-runtest.sh
> > +find "$suite" -name speculative -prune -o -type f \
> > +	\( -name '*.run-test' -o -name '*.sh' ! -name run.sh \) -print | sort | \
> 
> Medium: On an in-place upgrade, this scan re-enables obsolete binaries such
> as pthread_detach_1-2, which was removed for testing undefined behavior and
> is absent from the current run.sh. Generate entries from the current build's
> install manifests rather than scanning all files left in the destination.

This is about 2/2.

Yes, this looks like a real bug. make install never removes old files,
so the find picks up anything that is left from an earlier install.

I send a v2 where the list comes from INSTALL_TARGETS in the generated
Makefiles.

Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
