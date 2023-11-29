Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B089C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 09:21:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E76533CDAFF
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 10:21:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BDF63CC275
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 10:21:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4A74200C0C
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 10:21:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701249661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C5WYDdDSiViazM8haK15SDmOXLIGHxPUevxK4UXR78o=;
 b=HolDRfrWXpOrS81Y5UwSKgvNHPCoSY3AvTCsekj+XkroKSvayf6I44U1vT5tLSajH0afiX
 f3rBtWvZKh0kR//wT5vnincUVfM0bOLxYSzCmSRSN+aMNf7WMlgwMX+nl9kB/RI5Dl6Sex
 vkHHijr2+K9/bnOsx1KtQhFm8j9jgQI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-hF8vF0aoPHOZGvcOGvx27g-1; Wed, 29 Nov 2023 04:20:58 -0500
X-MC-Unique: hF8vF0aoPHOZGvcOGvx27g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50aa9aee5f9so7078309e87.3
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 01:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701249657; x=1701854457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5WYDdDSiViazM8haK15SDmOXLIGHxPUevxK4UXR78o=;
 b=tSNXD5g2okJFkwIeo7L23m49fb4PlRE5jcbwEHwOr2E35IOaR5Bp/Xnx9x8TFZGKAs
 YsoDW/z99MzplM8yvaxhYnQqvoWOMSayjK5LMqzmIqDdAo6/bTGHPlFZV52iGPA7OrV7
 Uri1JylPXHRaRf141UGIwzfDa5DmkkwhoM9/SFQLuGZqAQ9ivwJs1zzwDYNG84FdyfP4
 RE7lFnUCqJovtNQORQQmxAM7W71vSk3v4SPRNmMS/W9jBBOEFIGc7WJNpo5DyQjMouTJ
 twFnxKLV7ANnWTDbXlzhWrILwTb25cAhWDnxBNLHASOriEKDBF9yGu4MnPsDZH/UD3Z1
 TPQg==
X-Gm-Message-State: AOJu0YyCnN/Ud2zBZ6QILMS24X69OTsvaWlQU0hArE6aKaizUqb9wsKo
 lPwKob6qL7nMos7TuoGg3eaXYcP8/eZ/EJf5gjngHmRu3nmhCe0cakB1FiiWVFM5BqURCG33B7W
 F5pkb7RYg2v96i35Q/D7SaCH70vk=
X-Received: by 2002:ac2:546b:0:b0:50b:b939:f241 with SMTP id
 e11-20020ac2546b000000b0050bb939f241mr2791817lfn.30.1701249657448; 
 Wed, 29 Nov 2023 01:20:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGrRsLFXONNsl3OVFhTzunvxYYfzaGrcaF3/2l+E1e70IueR2uFTqTUWCQe6nUeUmuG4KHiJFR40xgOMOyZX0=
X-Received: by 2002:ac2:546b:0:b0:50b:b939:f241 with SMTP id
 e11-20020ac2546b000000b0050bb939f241mr2791802lfn.30.1701249657173; Wed, 29
 Nov 2023 01:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20231129061212.72817-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231129061212.72817-1-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Nov 2023 17:20:45 +0800
Message-ID: <CAEemH2c1c1D=QvHWnti+odXdvR1T-OO-fGyEq5BXpUv0uZ6OTQ@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] swapon02: Simplify code, add copyright,
 modify docparse
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
