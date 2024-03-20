Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8209FC54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 03:15:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8823C3CFDCC
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 04:15:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCD453C0313
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 04:15:32 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3184F14010E4
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 04:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710904530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/nXZI7LG92wZkSatdAtcNSHIYGmQ4F3UWD2MzHTkbs4=;
 b=A08+Hb2v1qu/qWYpzj2HuDKk3J38YSXyu2EAb5niId57TLHesRCrb76kqp4lIJMCMROq3X
 PNtpehs/Su+48u7K5Luj8PxpD26sQ7FKlG9LP7Y7ai/TuWJgsJ9v93xwveoWsx5be3CWZ2
 zX5lph7+rqv+Po6pcqzwqZJ6OuVt0yE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-56M-1GFTNL6CqzfToLTw1Q-1; Tue, 19 Mar 2024 23:15:27 -0400
X-MC-Unique: 56M-1GFTNL6CqzfToLTw1Q-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5dc1548ac56so3960056a12.3
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 20:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710904526; x=1711509326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/nXZI7LG92wZkSatdAtcNSHIYGmQ4F3UWD2MzHTkbs4=;
 b=dMrNjy1Cuc46fGhOSw8LzOg4meXbuBx8kCUeUAaOv5U5uLAZUcXYvhMkdiTR1ovgH/
 TmJaGsP4AWS7e0/XG3l25GnQpNulPG+hv+Qa4xGPcBP/SV0Z08BNZWAWGP/nchJ3XLjK
 Xh5ZkqmS6c894M9vAlGkQ8x9DNy4VtaRgJPetOp1K0cINgoZ7Efdo67qVforTw3GN8TZ
 bdhsj+gDuCZN0jHQVU4pKJSXtIC0j/gFObUhrqULFdXn8ydFj4PRsgpg0Je9HMgV1ujU
 jqVVkz5cfwOhKrNQd457gdj6srCWQVU2BIJ93brAYRHIwRCyvxWLKs5VfMb09PYzTcS5
 P+/A==
X-Gm-Message-State: AOJu0Yw/7lQpaicOF707TKC1WsS0suxiB6wlC/tsj1Ed5G5a95i2EPfU
 Pp/aiq/eZBcFFP3rosIoz1zK4nwE5YwzcHqdg3NK8eLcEXB0z8Cd0NKu4Ri74NQaTDddimB+4qT
 qinpJb+Op7Ep9DyEhhpNqcLxRX9Pwagni4Wu0/UY1zOCDsIIILohnhggo4bBqqIA7E4qL61QZv5
 JAowtCL4u/OaOxmUSf4c0gb9Wc8bkrRcYPkg==
X-Received: by 2002:a05:6a20:1595:b0:1a3:701c:cca9 with SMTP id
 h21-20020a056a20159500b001a3701ccca9mr1014904pzj.27.1710904525864; 
 Tue, 19 Mar 2024 20:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAVibWwqhdPLvwxMNV015EoAEyEiPyfn/JRg76aL9sphers/Rx2jbclJIUWfJvYljWP2WquI8nrX53NhoF2oA=
X-Received: by 2002:a05:6a20:1595:b0:1a3:701c:cca9 with SMTP id
 h21-20020a056a20159500b001a3701ccca9mr1014894pzj.27.1710904525540; Tue, 19
 Mar 2024 20:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240319192727.17538-1-sebastianchlad@gmail.com>
In-Reply-To: <20240319192727.17538-1-sebastianchlad@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Mar 2024 11:15:13 +0800
Message-ID: <CAEemH2dLwKFcY8GNj8GNjGkN_B9LUL+RRFHnc=Hp7g+DyaTJiQ@mail.gmail.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] docparse: Correct spelling mistake
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

I added your SBT and pushed it, thanks!


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
