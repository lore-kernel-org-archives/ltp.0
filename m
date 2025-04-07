Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39638C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 13:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8118C3CAEC9
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 15:44:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5E063C103A
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 15:43:53 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.212.45;
 helo=crocodile.elm.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from crocodile.elm.relay.mailchannels.net
 (crocodile.elm.relay.mailchannels.net [23.83.212.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9DBBB600713
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 15:43:50 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 5BF538A5E06;
 Mon,  7 Apr 2025 13:43:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com
 (trex-6.trex.outbound.svc.cluster.local [100.102.53.226])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9C7068A21DB;
 Mon,  7 Apr 2025 13:43:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744033427; a=rsa-sha256;
 cv=none;
 b=SZdvfufvoc3qURRDO0EOrsckBKlar/mSWPw9tTUGnTPxk9jqW/71R3znZlU9cUNsUyjqon
 JcYNiV8s4X8iOI8A+liIFUwtppiSZV3RSo79vcWynWtY0oEJq2FukHRBzvF11vUem5JsSU
 iQUvmHc/5iRLBD3AFJpaUPvRrpRLqIXvfvWiJOctOxPJmZ/KPU3Jd2UbreJ0QLuD1vI0uJ
 GWz31CkIO8yjIc4lFL7SG+sZ/2ssppZuxWrDOY+v4DXWaWoTPCbwrqHlV3dbpWjFDLFQS0
 EqwUzHNhlCMVQGjQXkwSg8TleCxagR13Y0zlbTD4bmmsGfn2cSL/cTJkkv4WZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1744033427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=qGL4C8234oZKeQOexWFgtOa44e6mOu2fW6dqGiLyiMg=;
 b=Etcw5TzXeGuKGoVcFs6wvFADvXGflvRx/FcSs06LlUoti4CJj4UyKdTvm8ZYg9dy+4A3kC
 HdU4rMLtyXa7mr6gB2tsRNwXnJGEnOdngInbr+dYKHDlegp3DIOryBtr+7pGFRiexwYU2D
 KGT8lXBvSdBsE1dp3bnLh4YtUYnGS7+TdEMzSO9QgLAt3jq4i/kmYHTwGs9Ts0zLpcvFqb
 k/D/B9MDm/adMrEMvkXVCnNeWOxdY+9I6C4vwXsQ9O1K/8mp5Pmmj/YWNldUeP+ycfSe1r
 uUTaEvjlzl63qkcJkHpitfawLBYRZl8/atWcFo/qhTFxMAPII3J54MOvCOflUA==
ARC-Authentication-Results: i=1; rspamd-7dd6dcd7db-nn2q6;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Madly: 38626d256dfca987_1744033427924_3384118489
X-MC-Loop-Signature: 1744033427924:2612132160
X-MC-Ingress-Time: 1744033427924
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.53.226 (trex/7.0.3); Mon, 07 Apr 2025 13:43:47 +0000
Received: from [192.168.0.135] (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4ZWVmL74hTzPr; 
 Mon,  7 Apr 2025 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1744033427;
 bh=qGL4C8234oZKeQOexWFgtOa44e6mOu2fW6dqGiLyiMg=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=G3S70aqWrRq6T4wrXCN8TYiiOj87iO59i7BfxuPMmK6r/KLQraTCCUGgkDUzmvAUC
 kIZa7CWKqx4BR0qpGMlZrBoSWN6zB0CpiD6KNXeAdF+2MZGkYKFFMnISk5JcnZ9Y8y
 D2YngjAleN8Sph3KG5QNSqBVDTCIJwgnWu2OjIxrrb3j2prtIlQDzKd7BJDxPuW2La
 Ru4u18HCJpfp4xy8j475PGDAdtnL4YY+mO0d2jX4IHO5nHCvVWoP4oqXc1gS9Si4gt
 nftY61FOC07KTAetLf0qOKsT2zTAthXin1A/Jpw1FsdNc4GRD9pS0P2ZXqW6kPclAR
 A5Ab/ix8/CH/A==
Message-ID: <ea5bf29e-cfe8-411c-bccc-0a586231e4f7@gotplt.org>
Date: Mon, 7 Apr 2025 09:43:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250407102448.2605506-1-siddhesh@gotplt.org>
 <20250407102448.2605506-3-siddhesh@gotplt.org> <20250407111343.GA83774@pevik>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <20250407111343.GA83774@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add centos10 to test matrix
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2025-04-07 07:13, Petr Vorel wrote:
>> gcc on CentOS 10 is configured to build with AVX on by default
>> (specifically, -march=x86-64-v3), unlike other compilers, so it should
>> be a useful addition to the test matrix.
> 
>> cve-2015-3290 for example fails to build on this without `-mno-avx` in
>> the build flags.
> 
> I don't want to add yet another CI job just to test previous commit.
> We already have quite a lot of distros (running is quite long).

So the reason I suggested adding centos10 is that it has a distinctly 
different toolchain from the other containers in the matrix.  The gcc on 
centos10 defaults to generating code for the x86-64-v3 baseline (which 
enables AVX by default) on x86_64 which is different from all of the 
other test environments in the matrix.

> @Li I suppose you want to keep centos 9 than to have centos 10.
> I guess for new distros we have Fedora.

centos9 defaults to x86-64-v2 FWIW, so it's kinda unique in that sense 
too.  Fedora does not change ISA baselines the way centos/RHEL does 
since the Fedora community would like to continue supporting the lowest 
common denominator in terms of architecture support.

Although I understand the need to keep the pre-commit CI run slim, just 
thought I'd add my $0.02 :)

Thanks,
Sid

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
