Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE877C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:31:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38A4A3C958C
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:31:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E59B3C3129
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:30:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A6CE91000ADD
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655973053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lJtzS1KT3BeRk/0ehu8+YUmA874goCvHvTKpNy6d4wo=;
 b=WRGmouYIOAZ781YlkArbSkMcrwYpC451H75nqWLRCQ/Sa40JgC0rqkJwEXpPTHsUtL3c+E
 N/I68D6watVIVWUEz8jUcZT/BbwIfnGpTSzIQfGjj8hgH1z44XEA5cYuKjTbHR76q0dhsJ
 lSnFLLyjC96KtojahTjwFwF52OwH02Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-K0fYneTqOdazN1SMlcHyhQ-1; Thu, 23 Jun 2022 04:30:51 -0400
X-MC-Unique: K0fYneTqOdazN1SMlcHyhQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 m20-20020a2ea594000000b00258f0218017so2883809ljp.2
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 01:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lJtzS1KT3BeRk/0ehu8+YUmA874goCvHvTKpNy6d4wo=;
 b=470DJGcSNvFsGGDMItZaL6WiHitw2APgRlboxgTqALXzgPSG9iPlmWfzeyPATJQNrX
 JeXdmYAMEC4C8tZzFRR0/2RAPrNp75RNz5vvFK+277/Ft5t2dMI8Az92+q190mcm+4sk
 y0ip31t+93QLo+2Qu1nrRV3gk0mIfMiVCCD1JEEHEdN9wpOx8NHC+uGvjX9yorU7UbLd
 VvsZbqjzZlRMnSdDQtkKFKmjPgyWzU2qC/hbVZfZeIRUkfzCKByB3/k6jz6F0GJKxDsQ
 O9s6q+LAVBZiNvOzKgDaEe7rqcAJ+EkGDf2PmpXllFR4hdHZpLHEb25NjX/oGmrB7PHZ
 e5jg==
X-Gm-Message-State: AJIora/zzdaL8bPe5BV6daFuwyT6akGGuOMC6+seBx4DlXNzPTBIp4Dr
 zliTNyG+ONg1fbv9KvZWT6Ed8OmrMDNrNGXLpln53ijBQN1UIHsq3SPcSwzdEU6FB8VQp+KyTwD
 k220eqojQCP0uYtyr2Mfkva2E/Qc=
X-Received: by 2002:a05:6512:108b:b0:47f:a41b:f2f1 with SMTP id
 j11-20020a056512108b00b0047fa41bf2f1mr1553359lfg.430.1655973050018; 
 Thu, 23 Jun 2022 01:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqb8PdBUqZLXflvH3JDayfcy0CrbfDTtZLCPb4kHy4E2S+pNSg/GuKIqPgznOOXnah17gl4xU7YvGyyDU4Hwo=
X-Received: by 2002:a05:6512:108b:b0:47f:a41b:f2f1 with SMTP id
 j11-20020a056512108b00b0047fa41bf2f1mr1553352lfg.430.1655973049829; Thu, 23
 Jun 2022 01:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220620063456.528113-1-liwang@redhat.com>
In-Reply-To: <20220620063456.528113-1-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Jun 2022 10:30:33 +0200
Message-ID: <CAASaF6xjARnhNAh7cU0pTE5vBfsA7wvvLAdosOmbrAEkHWY2-Q@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] swapping01: make use of remaining runtime in
 test looping
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 20, 2022 at 8:35 AM Li Wang <liwang@redhat.com> wrote:
>
> Here go with default to 10 minutes for max_runtime. At the same time limit
> the loop that waits for the swap usage to settle to run for a reminder
> of max_runtime/2 instead of the hardcoded 30 seconds.
>
> This fix can significantly improve timeouts on slower systems:
>
>   # free -h
>                 total        used        free      shared  buff/cache   available
>   Mem:          2.9Gi       1.1Gi       1.1Gi        20Mi       732Mi       1.5Gi
>   Swap:         2.0Gi          0B       2.0Gi
>
>   # time ./swapping01
>   tst_kconfig.c:82: TINFO: Parsing kernel config '/boot/config-4.18.0-309.el8.x86_64+debug'
>   tst_test.c:1528: TINFO: Timeout per run is 0h 02m 00s
>   swapping01.c:110: TINFO: available physical memory: 1545 MB
>   swapping01.c:113: TINFO: try to allocate: 2008 MB
>   swapping01.c:152: TPASS: no heavy swapping detected, 218 MB swapped.
>   ...
>
>   real    0m34.241s
>   user    0m0.386s
>   sys     0m16.040s
>
> Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
