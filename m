Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5EFC35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 08:48:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F16AA3C8AC9
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 09:48:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A4503CF32D
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:48:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9F3CA60091F
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702889285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZL3vAd6YkUpC3TA9aF3/JKm7QIc9qlcCXEkTuj9pnA0=;
 b=N44rKslrkcEdYWIuv32znyKqyoz1sRDhr6Hz199Uc386DIoqor6sgMBRgaLhHbyqv7C3Ee
 mCHfNh4t45cqkWydKYEz4i4xtM2ZM1YOscrY/iMTJ9uDjbrHqt1OWjBkRzEWiDUWyXi8Qm
 POUQ04dMa2tHEWgspuIA+3gYkayEt5k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-EuOBK9mIPqOgtfy-VNubYg-1; Mon, 18 Dec 2023 03:48:03 -0500
X-MC-Unique: EuOBK9mIPqOgtfy-VNubYg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2cc5f48a9faso8332881fa.2
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 00:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702889281; x=1703494081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZL3vAd6YkUpC3TA9aF3/JKm7QIc9qlcCXEkTuj9pnA0=;
 b=D+3kRcr9wRCC0nAxMr5VcE3KnXbpa4pv2Kw9RiYfveIhdjZUkeukqlPCCJxw038Jfr
 VTALVe9p6KAKk3tdxEujOgNd11zb0MXknBb3adHPfY9OK+kSMFf/27RJ/M1OrKDw/fW+
 NGH0f+GLx5MVr3YUvBiPKIM3KmaxCYOxuR/Kn54LUYuFcHR2Z/nGNVcSgxulsLy0WEw2
 LWAywSJpGVc5jmVMsTPVNtJeAZkvoMm8Xms6VfuxvkxuzWikPWrNKy+iIP7OsuSglhdq
 J2x+2KJuytM9vJ+oU+1vVHTpd9NAzPiqwKSZMQOgjO+/Nt8qOfZ6YtdOCLNEDLs8QQYv
 pb/w==
X-Gm-Message-State: AOJu0YyUGbWcXx9kGLVPtBItXNJmP9Tzwo99um1TVHKPuv0X20UN8Wmq
 3Pza1Wt9w93AYi3L/xDeIkJ6t2yETZl1dHDrfzOFVjMKAd3gmcpVQkS8++CqCCbEgWLcpn83bdn
 ELLjpP9e3uuLVc52rpACYI5V3sfIwH3/Hwaj0e59HDrA=
X-Received: by 2002:a2e:a7c2:0:b0:2cc:4045:bb48 with SMTP id
 x2-20020a2ea7c2000000b002cc4045bb48mr2897157ljp.101.1702889281060; 
 Mon, 18 Dec 2023 00:48:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEWGJn1Q4HInNhSUCwxvAwdf+E1FpMDYdtZoBDpa5iSV4T0kjfbh7lAP1IbB6qRU0WrEkkNZzvVPin5zlw+tQ=
X-Received: by 2002:a2e:a7c2:0:b0:2cc:4045:bb48 with SMTP id
 x2-20020a2ea7c2000000b002cc4045bb48mr2897152ljp.101.1702889280803; Mon, 18
 Dec 2023 00:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
 <20231218062129.130236-2-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231218062129.130236-2-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Dec 2023 16:47:49 +0800
Message-ID: <CAEemH2eccjMXRoZhcX_=SX8wDtykq2k6JPY60YUB0JWdzbs0Zw@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] gettimeofday02: Convert docs to docparse
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
