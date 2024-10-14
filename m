Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCF0CF2590
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 06:40:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DAA83C657D
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 08:40:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FBF63C02D9
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 08:40:21 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A64E5644830
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 08:40:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728888018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JIybxiWWDAgX1vXIjC6uA6/HAhr0hz7ArkrOIs8VHvU=;
 b=WTVcq+ySf8JveOifkWc1G2Pn9nMrXWByxTXD482ChjVYEF1uh02vAjwj+SsbLfHdeM7qq3
 MMdhnTkmqWB1qLGkNuv6IJs0kKTr+ogs9JUqm6UB6W20BcP6GoP693wfjT7WyN/Bb4lmcQ
 u+4ygEyaRBw3bABtNm19c5+LQRLVcjs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-7GfDR-2JPAiolcMgfOOJ4w-1; Mon, 14 Oct 2024 02:40:17 -0400
X-MC-Unique: 7GfDR-2JPAiolcMgfOOJ4w-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-20c77c8352dso33019025ad.1
 for <ltp@lists.linux.it>; Sun, 13 Oct 2024 23:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888015; x=1729492815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JIybxiWWDAgX1vXIjC6uA6/HAhr0hz7ArkrOIs8VHvU=;
 b=JZY5j6Oe/tmIfuHSOXWwQGyBsBTrqdCHXfhfehSozNHNVl7jqXkgIfozFg/dsYFs89
 D4Pmp/qgWV9n5gwJ3YoYugtoQPl3HRRYVjfah+0KCyg6t2p8SZ/gWuu/daRZ/OzRldWc
 SNMgqu/dWWv1eEmazu8v255FvhrGe9xlbNU0ELb9nW6wmoUmg0Oex2ocsp88xKU1qe0o
 q/WJMbQ9ze8hX84f3Bbf/l4h04sYw5Oaag8tRfhLnFY+z3t9FQ+4Jryxrr+FiEKWbnj4
 RgBJhguGdi8PEmjj42ftDeoJNqQxqH0tROgl7t4qTMkJiXkHHau6eR+r2ICm9+AiDdUp
 kphA==
X-Gm-Message-State: AOJu0YwFTiSFaXc20IjqZQmhVeOgNfcZhRBZxIrgyLJLs3xEOoc7/qG5
 NxKcc1e09XqeS3F7y3QctrS/LiMIs2sWToyWazcxSVrxgv1abXCZM5VIrbRs5MU0jHpTif0/fqU
 wg3AkpSyEQd18ICgN1bapNlpT/t1XvjHEdjLbatGsme8+/4bLpruEUsjB07lDJ3sC0fsoevGlBS
 UHLSwoKGlkxv6fexmurWqQUcm9usSzdWEOvj3B
X-Received: by 2002:a17:903:2301:b0:20b:fd73:32bb with SMTP id
 d9443c01a7336-20ca1424592mr172766085ad.2.1728888014848; 
 Sun, 13 Oct 2024 23:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhVQNa1T1XNPo0OQR4LrkMX1b96Qs8cfO9RZY6IGO2LIK4ZIwZUXW3ygktbkHA5ztpz1c42Qs2OOIsXhjW4nc=
X-Received: by 2002:a17:903:2301:b0:20b:fd73:32bb with SMTP id
 d9443c01a7336-20ca1424592mr172765865ad.2.1728888014505; Sun, 13 Oct 2024
 23:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241014005339.460608-1-lizhijian@fujitsu.com>
In-Reply-To: <20241014005339.460608-1-lizhijian@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 14 Oct 2024 14:40:02 +0800
Message-ID: <CAEemH2eZ=WNzm39w2qrh8CPRkQhWcr66P+y4u2KmKkG-=tVyxQ@mail.gmail.com>
To: Li Zhijian <lizhijian@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] configure.ac: Fix temperory directory
 ./confXXXXXX not cleanup
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
