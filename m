Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D96C3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 01:30:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB6CB3D388B
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 03:30:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 627363D3871
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 03:30:43 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57F0A6009F3
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 03:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720661440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HM2/XOorVAJduaz24329ZeYh02YbO1y7eBUglDxlJpw=;
 b=Xz8HIOjqPN2GH/BO/2YaIGdrrSWQqCvjl9eHLlFHBZOitBmJa98WaRJ7Uekh2SwYQZamOi
 d0OX2wdjI4/HeQAeB+ZhsZe8bA+kwE0U1F/wrggNWNrDyD9Ta5KwMpeZgHbg9D1HL3Whjk
 Mr1D0fUL7RZ0CVCGP2sxETs4i6hNrAc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-GhCAm8ESNmifaf-xBIfeIQ-1; Wed, 10 Jul 2024 21:30:38 -0400
X-MC-Unique: GhCAm8ESNmifaf-xBIfeIQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c96f6bed83so345872a91.3
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 18:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720661436; x=1721266236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HM2/XOorVAJduaz24329ZeYh02YbO1y7eBUglDxlJpw=;
 b=P0GcmjU9QFtOZ9SwEcm8aFS0VlY2yofUS2V7ToKVtd047xdIA7XsJiy2GZORdHTRqR
 Ao9fRwZ0Z8PXSb6kNcXMvg+xKB2u5s7Y9nqVdMTP0OjfiPsVPmUXzkPMejZMLyGLYPpw
 JJs/CUdFaUNTq+S/Em7hfiKGuq1xCu/LuKYrQmCdUckzXFTNtzTVDKHrwM8frtgKhSX6
 0OZLRhtd8VxdIVMXKKcMb8wNxcWcJtwms/n4qN9y/NGvRUsvrOofMKyQHuN83TjCYky6
 CXmtn7ccVexfakQXcNOgh0SUmNPt7fFJhG+Hmzn6n0BVC047pYQlqMZTghJ3P8UYQ8Ay
 WUjw==
X-Gm-Message-State: AOJu0Yz9A0PyuHa+H5Vezebbx2Qz2a7QQvo/DUA7kEq6vvxURP4nuAMu
 bYq3sNmDiSELXomaCoL7JPTJBuzUMbkxcfB2Eim9wqvnRphVcXg4ZKCN70T+WvD+fsF7R3/fnH6
 vtxiMoR/ZRhpp1fQenVb2tsAHprbZj7aw+ZGBTQ77NGuQGMDYEIdOivy/FD11fnwXYPkNC1lRZn
 sQ+NKMor58IHY950uhgUgisQt6TsHPSUuh9o1O
X-Received: by 2002:a17:90b:3ccd:b0:2c9:887e:46de with SMTP id
 98e67ed59e1d1-2ca35c310f2mr5153369a91.12.1720661436324; 
 Wed, 10 Jul 2024 18:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzatIKnibx2LHGqulT8qc/dIEn1+HPj6NprCUHe0oRBMv56b4gT0d2hrGdR6GTrt7P/4tAY5UOdrCdTSEuQA0=
X-Received: by 2002:a17:90b:3ccd:b0:2c9:887e:46de with SMTP id
 98e67ed59e1d1-2ca35c310f2mr5153360a91.12.1720661436012; Wed, 10 Jul 2024
 18:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
 <20240710-landlock-v2-2-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-2-ff79db017d57@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Jul 2024 09:30:24 +0800
Message-ID: <CAEemH2fYdPGLYX0F+sWth3N7oeAKBASKVpNC4w=UGo_2mUKtvQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 02/11] Add lapi/landlock.h fallback
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

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
