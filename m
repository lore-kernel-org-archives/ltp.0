Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F53CDB47E
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 03:19:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A0193CEF4D
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 05:19:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD9883CD444
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 05:19:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F114C1007CA6
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 05:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697685560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEBWPMwMweGGSL+JCT7HX+Ebz0bTBJI2w7zHZAPqAZk=;
 b=Og55UXJnm19w4e1agrBg6PghkNTojC30n2jMueQ7o2488aI16v19jEyATAGN+8R/NDQTsm
 psvLTbTKShHmXQ8I3boC7FWAzsWAJOKGCf4yRZitkvuTsjCWIG4c6Tvw90nhcZmrFgjA1r
 a/R9LydKAGcoRh26bNDwNWgvb/sPh1o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-E_evK5_pM--uClBsGNjBnw-1; Wed, 18 Oct 2023 23:19:13 -0400
X-MC-Unique: E_evK5_pM--uClBsGNjBnw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507b92b4346so3126336e87.1
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 20:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697685551; x=1698290351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tEBWPMwMweGGSL+JCT7HX+Ebz0bTBJI2w7zHZAPqAZk=;
 b=O+WGOf9RrTFi+V5tNEtld78qvVPwSxKwDlctbuspf8nGNvO978gitMU/etljqA4Ael
 f8v0884SkZjCxog3SlOYm8z76wHHpxFNGrc7MmGI8c7U8bpx1T1Y9MDRZ57lANPVqzML
 nTb9JiECtX2wsHddgcyLHa4zoNZjDniQFgaIX/pYqbGDAqTld9vPp0YtdpMH9ITSNXwx
 K8wEIo4jZZGfuA0b12BSeI32THyffXUiTLybpYVmVCf93+2K1QPd3wCW/nGjkAKaEpTR
 wMRsh41oO6UJfeP6VuF3gSrJ9HVD0LDHawxoWuqEymJgPZvH4XerBNQPAxCQN0JrujRw
 7WUg==
X-Gm-Message-State: AOJu0YzlctR9fneatrA52D1p74ZgTojQW/XMY4WQswS63lHP/tD8hBJn
 wCSfOiU77Y98JNckK08K6rFI9bfl6Aln+3NOQmfZnTgZLsBYttQ5r68TKraafWiJc98t8uy79g5
 uxzd0UByD642ru6FckdoioqqxoSM=
X-Received: by 2002:ac2:5328:0:b0:500:b74b:e53 with SMTP id
 f8-20020ac25328000000b00500b74b0e53mr495028lfh.46.1697685551610; 
 Wed, 18 Oct 2023 20:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+xS3c/giOPKsrygo1Y+f+ORHgOF07uKqPVialmHWA68PRdAv8xYh1z7Xc1rYe03xG8unkGZceOAL6Sk2wg+g=
X-Received: by 2002:ac2:5328:0:b0:500:b74b:e53 with SMTP id
 f8-20020ac25328000000b00500b74b0e53mr495024lfh.46.1697685551180; Wed, 18 Oct
 2023 20:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <1697684152-29747-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1697684152-29747-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Oct 2023 11:18:59 +0800
Message-ID: <CAEemH2czTb6KvzC7_M8_O-BEsPtbrU7hM-yuW1dZWdpJUJLPng@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/fchmodat01: Convert to new API
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
