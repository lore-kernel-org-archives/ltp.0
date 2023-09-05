Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F32C83F2C
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 06:25:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 719513CB849
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 08:25:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2FCB3CB79D
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 08:25:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 676EB1400C5E
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 08:25:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693895133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYHExUfjti3jZ2huxy5GfJ06CQqHv8oT/CmrX5PXr60=;
 b=LhZGD4LmpP/SMkuopBnOAN0nyPyFKbZyviPjfvyd41bbgazdriLGW0TPjyF8pnzAESKt+B
 JCGnolgt1kHS5g0oN4sFr5k5aChAgfV/9MJOzPURmlAac/9K04dTfew3BUUf8N55tNy8p1
 /vLDynpbe/+2dvMvJb401Lt7yfJlACo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-YqYYEaOVM22UDb16m8uiLQ-1; Tue, 05 Sep 2023 02:25:31 -0400
X-MC-Unique: YqYYEaOVM22UDb16m8uiLQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bcb2990ba0so22591421fa.3
 for <ltp@lists.linux.it>; Mon, 04 Sep 2023 23:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693895129; x=1694499929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYHExUfjti3jZ2huxy5GfJ06CQqHv8oT/CmrX5PXr60=;
 b=UrrquS5QNVG2T3pBxWNnQ3wclf19IX0tZx15oSRIWKWtek11FdMEotduQMLI1VleRm
 dc+iYPfgaqE9DeQ/s/KzOSn5rl8TYK+J1NEukDfQihX8LNxzzdWwUNWQNU47oopRYGIE
 kT19AKiZwOrf/GEcBwIDp+UBQRG78lH/pE7TTDbqhyNxZuxKYw2j1TY93UcnhymotOZM
 KuBTx35AdszvfH4NC/oPQ26faxZNbtl8j8ntGNk6fmP6N/pRBsB0PBzFDpzrfJGccdam
 y/wykbolSmETiZUbo9IGAiLN/aN5igbOqiVTJI5oJxpk5u/eE105FpH/nrnMVOafIVlj
 37EQ==
X-Gm-Message-State: AOJu0YwEv65cZaAZvV3mQ1ZuP4BdAXtmCQteuN6pX5/4zNAb95FkjNQC
 +xh2fEFtdik7ajaJ517qUZrEVPJC+J8UrtkED+oJaAyk68DmPu8d68V1PShtSAWrnVOLshsBf54
 zaECO6LuNZsOAzaGhcU/fLeUEfGpBkoN3N7Ileg==
X-Received: by 2002:a2e:9194:0:b0:2ba:18e5:1063 with SMTP id
 f20-20020a2e9194000000b002ba18e51063mr8024132ljg.50.1693895128854; 
 Mon, 04 Sep 2023 23:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF179eGFEFmD9CCMpCGrGwjLpwxgj35f1JeJYqERa5ZQdGnv1Uv6Jl3+eg/TO+rIIsRS3LU/vu/D6jgM8nuCAI=
X-Received: by 2002:a2e:9194:0:b0:2ba:18e5:1063 with SMTP id
 f20-20020a2e9194000000b002ba18e51063mr8024125ljg.50.1693895128566; Mon, 04
 Sep 2023 23:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230904140424.9971-1-andrea.cervesato@suse.de>
In-Reply-To: <20230904140424.9971-1-andrea.cervesato@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Sep 2023 14:25:16 +0800
Message-ID: <CAEemH2e4Cssq+hFYvgYaLW5j87x9+_6o51YKn_TNMY4YU-3x9Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] Refactor timerfd_create01 using new LTP API
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

Pushed, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
