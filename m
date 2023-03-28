Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EA4C76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 07:44:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65F8F3CCB0A
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 09:44:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AE853C010E
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 09:44:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 16BF9601EFC
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 09:44:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679989465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xuMKcRCvB5tHnerPYgIEyxAxD7qu7P1WlIxutjYnAM=;
 b=J9R7GDUda0Ow9ilf3LLPqeuJKouaSNZgqfJ+P7PLeyaQ6IvNQIqQtbph+3AHxFX1dbcGM9
 gWpHiSjwEcqmhOshLAmHYQKz/BomFrhiQG00TOrDM5uINP3Ap5exGD+I7giGc7ET3d5YWn
 dJ01QP+ilRbEUx54+zH5t7iRSywh+2E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-gEFEwDHEPQGVqytbNfhbrw-1; Tue, 28 Mar 2023 03:44:22 -0400
X-MC-Unique: gEFEwDHEPQGVqytbNfhbrw-1
Received: by mail-wm1-f71.google.com with SMTP id
 e5-20020a05600c4e4500b003edc5824521so6897374wmq.0
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 00:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679989461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7xuMKcRCvB5tHnerPYgIEyxAxD7qu7P1WlIxutjYnAM=;
 b=OgwhgWFRNQg82HSP2DSIRd611KEH9n4SkdWCgi3tyh+ymvqj32q8kzIMQfD8l+5+AR
 qDpyP3l3E6FyNTRN7lbg+zFq8e4U/MzHIC2ynYFwCwH0YR0Ua9chSieO8Sh7kxupY3Nd
 9/APNbtDccQ+8GEnWZdh3O/KzYxS24zN9pS74FApaM0QtFXfysD/l/PG/EIIcrdXEuXX
 YRn49ezFB64dtPp/Wxb04EzrNBFr/SXJQanUXRqrytGI0Dj47LGLZyCB2YbytqrmT2ey
 KgObRnjUaou5qVqYVu1vFyNw99eOC0TwTHE0C+HFbMd9eBM0qKyxuWYBu7Cc9KTetsxc
 KWbA==
X-Gm-Message-State: AAQBX9fkvUGODzryxKZ8TYj3U/H5b1zgCihMhka+0PIFod8l26x2rXm6
 CeH3IwWpy2jDuZouMyFID37WHTI88ZspNe8M/1ltU5FjF1TRjCjSAm4htRF2p0nXRsp/UNet8QQ
 2uTx9tED58EDbFa0Gd6MC51PxwVY=
X-Received: by 2002:adf:e941:0:b0:2d6:e7b3:74cb with SMTP id
 m1-20020adfe941000000b002d6e7b374cbmr2943452wrn.7.1679989461717; 
 Tue, 28 Mar 2023 00:44:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bH8psVdJL2CQODXh/xOTJNq31nM9TUNuiWJ4A/9P/lJ67Vv1WhastXNBW7dNSG3wItoHU8L8jnx2KkXgDuz2Q=
X-Received: by 2002:adf:e941:0:b0:2d6:e7b3:74cb with SMTP id
 m1-20020adfe941000000b002d6e7b374cbmr2943447wrn.7.1679989461481; Tue, 28 Mar
 2023 00:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230323160442.671164-1-teo.coupriediaz@arm.com>
In-Reply-To: <20230323160442.671164-1-teo.coupriediaz@arm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2023 15:44:10 +0800
Message-ID: <CAEemH2dHG-j53Q1W+aGtORNjX+v2WWnXdCvzD0TEX65Cr1ifAQ@mail.gmail.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ipc/msgstress03: Assume all forks will run
 concurently
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
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
