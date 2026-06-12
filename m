Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6A9CD98CC
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781230072; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ue9QkHBp8BMUhYsFA4qs7Jr4VxbB5aQCNeHi2ZS3il0=;
 b=WJOxEsjnjZPbj6dBUEEqNw4u9iU8U2EYR2jY4YRFxcPsrgSko2N7uNq6WZBSHUTWRhg9u
 EmrMfOZ7OfemTLt8voj70nzvfpZDwjeOOU2ksM4td2xGOVesOUmsMZ5VbTCJO19lKFoLgiQ
 id7tFDe7j3jnA3HSC8W8dEzw2zZA5oE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B60943D0613
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 04:07:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BC9C3C5593
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 04:07:31 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CDE131000443
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 04:07:30 +0200 (CEST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E0ECD3F7BD
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 02:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781230049;
 bh=rvdtf3Q6Jloo9Y/Yy6oX842SuxQUlAZqocjOHaINGIA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=nsYmKZ+Sn1HxBH9yn9tM5hee/77USqR7WabOLUoIJonefE2jHF7OVAGoYZrCEqDgY
 gGzmnlMqt1driLIYEgIRg6E30rDESUBod8+8PZmLMAh14TnKKc8XF++xjM2uYg+1zp
 YYm75Opaq8Wmt4j+qFzozM1t8BY15oCBpRrEb2CWlBBHzY2vmSnPdcu7nwbZJbZhfl
 4cCoPCPCeXnREvx2WSoai/bHpwG6mt9AxQkXNASH8oOkil/S462qFCUVUvp6DVQYkl
 amK9IrJtHqXiHSLaZV3ny8lPs6FGYaac0ynRqyrl/tmdC+rzwQTFLkcykFyH+R3JPK
 8WV4N6PSowPRKi99RWHwAQeoKgPFnQBGWRsIX3tCmEU+b1tZ2vSByzbPYF7w/L8llQ
 3cjw5ej0+93Ywf9SMEdmCWqspWC4ehUIhjrRq/sk03xiEvCoPT2htXLuWKC3fJLihf
 dxL6Qj7PU1EaERXz+Gx19bR39i38Cgj8EG/v5orMpwJlMl1GDh+CqBiX5IRNKuYEay
 8l17SaabHANsf+TYl1+sVqj2SaSfus9olLjrFbMrFc8RUqbDQPFyzRBi+lmAryhLJ+
 Y1F6DVotxtr/Fwh7E9hiIaeIg0qBSCmo8aOuYRr/EMRXO9SHQAUP7QKWiYZDX89P7b
 YGIngp/QlDiX/RqYJZCSNo20=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-bf523a51c24so30490366b.2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 19:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781230049; cv=none;
 d=google.com; s=arc-20240605;
 b=QpOrpaBkUOY8BBgf0XUu3oiDH+AtJfxN1CMqfaY1BvPWbeoTte7XFS7UXfg1b65F/l
 L4y0GFCKbqelrC8pvHyvu2F30aiRFvIyONpZaDinMh8S3+iHmzsW6gwUP280RfLZRyJf
 Kn7EjJGlyJg5TbI9jM2wir6CQIyxHzLEjySOK0ny7sRGNV2EyeYfumXNXdwKLmhSsXjz
 wYjhx9eEXfkqi4c+QJN1OUpl46w775pSrB75RLQMzApRQQ2k5Culn5CIIsq2As3P5KGv
 CtaDwHB+R9h55EoXzQR2ze8Q/4K8kGjLcLG1Tc2NReIgOeKp2RlTn4Xw13rqsuVHJcds
 YW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=rvdtf3Q6Jloo9Y/Yy6oX842SuxQUlAZqocjOHaINGIA=;
 fh=m40UBVrR3nZgKdVqXyBfj/+kwMsS69fSxi2566YNWCw=;
 b=EQxjn3YwcmNeSXL9RihHwe9VR3uEBtJMhVh5ZXiYMNiLxMuiyVlbk8rsPq2xnY9/yR
 0xzJUOVM6bZ4Lkw563sXr7Oic33ToW+4NuNCwVcEz3hmlz9FnBoNJH5l1pZ5DQGfhFmY
 A77dRtDDcA+E/AxMg398mMH8LGhi9mDvMq4/7Qy1iBTDiu3FwzuePuB/cYQsoAEnAbr4
 JTpVd6qQBHexeItR+jpO5FCH0mEXi3SaJh0VgM8Q/2vyozdXtxv0QmlIhd03Os6hFxpG
 GdnXy7P28VmGNJ3wGAWyPyOaGh2RQ948w/Z2kKX8zPIRKBiVk9vQI/jaTjj8yvMZR17g
 Q7BQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781230049; x=1781834849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvdtf3Q6Jloo9Y/Yy6oX842SuxQUlAZqocjOHaINGIA=;
 b=myQPD/P6RpO+ZrFg7oyMyDDFffz+LwlQ3GYPDYvpCYxPfo3RYPl67i4/5WQ701lnly
 oENQhiDDF415PjvDa01q8asIZt+c09FfjF7U21gVDbq83fNKpm+otfJmZxv7f7bzRYIu
 TqrfZNuhwz7eR+MgYwm2ZndWRRHLxb9wNeWhf8wAsCtp3Jz3AHooEIQ3icWuFz3QGbK2
 ZNnCrK3AQD0tMHxE21J/dlQU/OyOg9hmwMpePa1CidAtHhIzFzyT3DEmNFvQ38g0/aWa
 HiOebLCLkuSGXhn9ZBOhO1U9Kkvk8STft6qBLTAXQcluB5aPcnjg3Pge2R9nMhZLZXck
 1a2g==
X-Gm-Message-State: AOJu0Yy4vsLkFKcjn3BTdJ2jhv5zDjdCdGL/Up/10xEvVwcOeRTrMkON
 7W3+fqbHIxXmwjDEavL1oHej4GCEBwbjVzc7HYop1quKcJqWqFeMlCDyl90DQtBs6bBmdLa2Kk8
 wiH27JOdKVqDUxo2aEeAHjEkLmlNYt4mWIprvpGq8YwWwB4HqP8FiQaOeeRL0i4/qtYc1Q3gNd0
 skUpyxM3D1vE3fqUntJMX7yEEK1SsZ+QfmiJ9yrwNGdQ==
X-Gm-Gg: Acq92OHVTWWjDdm+sGI1W54wAfXDeaIMkNH5/pzLBcBegQsI13qkKKopksU20fQgDax
 uIhO8NNQxStK2k6EeLFwEY3ShcrQI8P3dkRau4MyzS6zlW+vlfHq487STRgCzNG5urWs87QrB2k
 LLcY0SJCxyBpvyqR6+pY1FMK1lPrdtzhuXVOjtrO7fTVpgrbqAojbH8aUanvNvcuUXFycksxLl+
 PrfWqRGlGmuORv6anSHxgJJwcfeYhMOolkKBmEjT5sTsC/WezEcY26EgIgJ/DVr
X-Received: by 2002:a17:907:2d21:b0:bed:5774:7c17 with SMTP id
 a640c23a62f3a-bfe2793154emr25482966b.5.1781230049516; 
 Thu, 11 Jun 2026 19:07:29 -0700 (PDT)
X-Received: by 2002:a17:907:2d21:b0:bed:5774:7c17 with SMTP id
 a640c23a62f3a-bfe2793154emr25482066b.5.1781230049135; Thu, 11 Jun 2026
 19:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260611162932.756328-1-po-hsu.lin@canonical.com>
 <20260611182244.4738-1-linuxtestproject.agent@gmail.com>
In-Reply-To: <20260611182244.4738-1-linuxtestproject.agent@gmail.com>
Date: Fri, 12 Jun 2026 10:07:17 +0800
X-Gm-Features: AVVi8CfDeBaUJkWRDUpBLnEs5Q1zouZhldoOAff75EXfrY_3jAF6d2NoH3xI3K0
Message-ID: <CAMy_GT_bGKx0Kc1RLnnf5HteowzONPz0S_ssBEoD3N4D6AotpA@mail.gmail.com>
To: linuxtestproject.agent@gmail.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] pipe15: add min kver v4.4.281
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 12 Jun 2026 at 02:22, <linuxtestproject.agent@gmail.com> wrote:

> Hi Po-Hsu,
>
> On Fri, Jun 12, 2026, Po-Hsu Lin wrote:
> > pipe15: add min kver v4.4.281
>
> > This patch 46c4c9d1beb7 has been backported to stable v4.4 with
> > commit 7392701d8615 on linux-4.4.y starting from tag v4.4.281 [1]
>
> "This patch 46c4c9d1beb7" is ambiguous. In the context of a patch
> submission, "this patch" reads as if it refers to the current LTP
> patch. Something like "Upstream commit 46c4c9d1beb7 has been
> backported..." would be clearer.
>
> Also, the body describes the fact that a backport happened but does
> not explain *why* adding min_kver to pipe15 is needed. What problem
> does this solve? Does the test TBROK on older 4.4.x kernels because
> /proc/sys/fs/pipe-user-pages-soft is missing? Or does it hang
> because the fix is absent?
>
> If the sysctl was never present on 4.4.x before 4.4.281, then the
> min_kver is legitimate feature gating and the commit message should
> say so. If the sysctl did exist but the hang fix was missing, then
> skipping the test would mask the bug on those kernels, which
> conflicts with the LTP policy of not working around kernel bugs.
>
> I can confirm that this sysctl, /proc/sys/fs/pipe-user-pages-soft, that
the test is trying to access exists on 4.4.x before 4.4.281.

Please ignore this patch.
Thanks.



> Verdict: Needs revision
>
> Pre-existing: the tags array at line 95 is missing the required
> {} null terminator (see tst_test.h: "@tags: A {} terminated
> array").
>
> ---
> Note:
>
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
>
> Regards,
> LTP AI Reviewer
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
