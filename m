Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8C9C369AB
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 01:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744768584; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=K1IBDaksDq1WFkCrDptQwd224EpONG+5ihtseMq40RM=;
 b=W+QNg7UtYezyyJRu0M6NEm521eAW91N0bHycFxnKXffYSm1yYn5xs7Hco+09RTh1bnPRm
 mwzlTtQBpQpe3SXtIk+hYa+af0Llh+7lSC2XsbTHH/+dnK+pDvOGltPj7igqhw0p4g2B6eO
 Y5yc1Z7kpe0C1TMqz/o2/48J/7wbYDw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FD823C02B9
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 03:56:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B87903C02B9
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 03:56:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7CD9200078
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 03:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744768558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P9r7bBD4SdSTG6bLPx3amrepKR1PrV3KUGWr6J/c+O0=;
 b=ftHuYz/1sXIHZK7KnnFwUhkE71OgXa0W20eT1s3rNHclRjQOqfKbs21Ng+WeMAKistuH8R
 eM3Pf1QKScqLs6MkmBZdUC5BFSDZBOjqwPhwXFSKDJE7OY6JElX5oDZL0p1t/y2uL8JzHo
 T9UTOzi7PM1QHcl9KQENkuCcn/rSX3I=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-zznY1EYgOymThBD1GoNkkQ-1; Tue, 15 Apr 2025 21:55:56 -0400
X-MC-Unique: zznY1EYgOymThBD1GoNkkQ-1
X-Mimecast-MFC-AGG-ID: zznY1EYgOymThBD1GoNkkQ_1744768556
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-736cd27d51fso5097369b3a.2
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744768556; x=1745373356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9r7bBD4SdSTG6bLPx3amrepKR1PrV3KUGWr6J/c+O0=;
 b=ayDcCtyxQUrJZQhQJQt8AkOS2WAjRHkgKkxowRHLGQesNzrpLaAoDSZ2JMHaF980tU
 2JEapUOU+rQXbWkgyuKYuh7+Q0o/idKGx2Qa9vxI6lenN8wXcEot7oawiaBOqdaq8XSL
 shfhhyi5g2fLnMx90k9OYm86/FU/JemGyJ/zOUWYA9AI+1HFJuhOPghIWhm1t7MRcwr2
 TIocJB4PUV+HRN7m5RWWVT9MjrDvVguV4oM9982OEQAgYcKqBCRu9YT2VkS/e03PJ75C
 LD3+VtBlaWzxPptqgYosCsiOr6CDDI6RufYB6YAtqDwbN+RR+Yb+mmTk/PRlxuzO9ITp
 R4+A==
X-Gm-Message-State: AOJu0Yw8Vx7TlM1zGFiKhDnhv8TqHIxm2SEdAIP//lx01JMffHi/XiG6
 DQj5XmiIXrBfKdOc9I8FrTiQzWDoPbEk0iuprslHVjtseo9nowvKwrI2e/hSslriPsTbd9ZYh7B
 F+y9helsrkMQg4wuzaDIDeQ9yKa7l8JbMjTlxGQd5Ha93snpaLf4CeKQwbK7U5IiCEYFfP77nTB
 xA7ozWMSFc3kBIX/gKy6NQdj0=
X-Gm-Gg: ASbGncswhaQW953Q/GNsMyMsteX0tS/XXWOA8KKTkjrYd85Fua1TnDfGKX4PMIeAphv
 4MvHW34Fpo2aJhZBmsSXVGYcWJ0qT88cU5KU84VZpp4UrKd2g5cCeU5jxTK1PMWvO0c1J
X-Received: by 2002:a17:90b:3bc3:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-3085edc038bmr2367784a91.0.1744768555938; 
 Tue, 15 Apr 2025 18:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUE86E/Xe04v4xh/9TC9J5fiWJpNNpzPC18SU2wUiBJVU2Qh2ypIPMIWNuD6k7g/CKtqpUWbEnb1NA2gnN390=
X-Received: by 2002:a17:90b:3bc3:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-3085edc038bmr2367756a91.0.1744768555588; Tue, 15 Apr 2025
 18:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250409074906.128290-1-lufei@uniontech.com>
 <20250411093049.131850-1-lufei@uniontech.com>
In-Reply-To: <20250411093049.131850-1-lufei@uniontech.com>
Date: Wed, 16 Apr 2025 09:55:43 +0800
X-Gm-Features: ATxdqUEF_3cm5o5MtH7QFWLgka5fQ4P9mLiApV52UPErBPyiQsBTIEqa1hl-J3w
Message-ID: <CAEemH2czaEs1Lq6ri2tSBk-W2ErGs4s+bOQ=OmYyr3kug-7v8Q@mail.gmail.com>
To: lufei <lufei@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vdYQbh68iyefL0vSgRDhGFcWgwLbjQisrG0xZud3HgY_1744768556
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] unshare03: set nr_open with sizeof(long)*8
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: viro@zeniv.linux.org.uk, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Lufei,

I helped refine the patch description and merged.

See:
https://github.com/linux-test-project/ltp/commit/fc8be6ed405d3a949161c19b917e79ade969a505


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
