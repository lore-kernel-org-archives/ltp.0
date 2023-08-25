Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9783C3DA6F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 09:06:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC5C93CC3AF
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 11:06:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F1A73C6D29
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:06:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CBBFF1A01967
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692954359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+s6yhfeWUrRLyj0DDJLEv2Oouh4SoLsHnXn9ME10SQ=;
 b=H3Ud5gYeFI7Jj5zlEYv8ElLrcay5MWQ9NRymeII4zYXPvZxONPixMAix71re+fI9fchUPQ
 5v9z6pw8xxeen+F8kskPz+IPhJn8/37tv5E2SfSpGSd9ftuLiy4ca6u3bRGtdPSpE4AZll
 Ou/mAr3j1OGHDha60UKw0NvplWEbeRg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-Mi-VLZWRPticEV2MkIk0aQ-1; Fri, 25 Aug 2023 05:05:56 -0400
X-MC-Unique: Mi-VLZWRPticEV2MkIk0aQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9e014111fso8286221fa.0
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 02:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692954355; x=1693559155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z+s6yhfeWUrRLyj0DDJLEv2Oouh4SoLsHnXn9ME10SQ=;
 b=BYZCainOAALYz+taGci20r7nQpHxqCg3V3k8wsRgQubSIKjSSalZUoIM6tX8LVJtsD
 wE12rtfbwyW72aWDKTGUIp8ggjlNRtY04L0W/ypzazmeuhajhq/W4VsrjRzxREA3G4zg
 MMTGAomoVV+KrQF2ox7ANNtoxYh8Agk7Uq8HIIaKqj/Xm8SYGVMoqrzpFymPYgC/Teek
 Tj22WhXo5aspf2a8K8QJDfgE7h08YFv4tWlYj58XgRdFyUc0IDbeEdEARVFzemvfgnfP
 1vwluAEENMyG4ryPmSUsyn8xPw814Ktr9SLlOyRdeboLXxjtrLYR4HNkA8+EXloT/Jrj
 3pVg==
X-Gm-Message-State: AOJu0Yw8aecnIk/pqn+rdEJi4NNFuOOEorF1eMWPHYd9fgvrNyIBxdup
 g4aM/0kuM4HOGCD0LGHj3612LGNHsWHhZ/VHTq5eumXxOVZ4fd6BmUF6UCfNxN11md5uLHz6+LJ
 fbnL35InAIzS+xcWpYA+qIoV6WJI=
X-Received: by 2002:a2e:b0e9:0:b0:2bc:b884:c9be with SMTP id
 h9-20020a2eb0e9000000b002bcb884c9bemr12498171ljl.30.1692954355520; 
 Fri, 25 Aug 2023 02:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG8mxP46c+CJOb2IsoljwUyTvqbOLeRU3puA3UrjiPolDEUg+tXpHyjgyT1N8jfvyJT4JZCgkL9ecGBTzN328=
X-Received: by 2002:a2e:b0e9:0:b0:2bc:b884:c9be with SMTP id
 h9-20020a2eb0e9000000b002bcb884c9bemr12498153ljl.30.1692954355189; Fri, 25
 Aug 2023 02:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <447b0209996f33c5d7f6f5e0f146ca1abfe28346.1692858827.git.souta.kawahara@miraclelinux.com>
 <2424913.C0n9F0bVQ2@localhost>
In-Reply-To: <2424913.C0n9F0bVQ2@localhost>
From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Aug 2023 17:05:42 +0800
Message-ID: <CAEemH2foGr9FrigmczYQBwG3qp0i-=pT4bgD=sddDYvfRECehA@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/1] doc/c-test-api.txt: fix wrong chapter
 number
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thank you, both patches were pushed.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
