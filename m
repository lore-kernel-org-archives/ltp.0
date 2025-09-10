Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A775FCA0FED
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757545652; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2DJqOoZYxT73CMXiQyrP+4Q3PCzbP12mnCUxjHTRNGA=;
 b=rSTWwOe2dVryPfoO5G8Ej4p+jvYZw94ZXLW/tRc1TJCkj3qMuE4EXe1zWC3W9+ChSfy2c
 BMKneI22/nbYy1AU7pFfEYh7vb4zt32gpSQbkiFwxT3YtFZmjq/SUP+Sm04C8cYcU7BPomU
 tKXwlpIDndMiRDEUOrt2ken0xnwKFFA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03FD53CD7F8
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 01:07:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F91C3CBD5E
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 01:07:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35FC8200170
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 01:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757545628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciOy+sEx318rmWVeaN79X+N/GvJ++Y421zGf95hgnJE=;
 b=bxBFm894bZA5qlITsp7KvQD9ezOz8M2B9j2VjQy04H46GPwCPc9SeDqQQ9DRGOBVvIZfhk
 sh2JWZ7ubckY3pcSVFM9JOsR6Qh2aS/+Qy12n+UM7fah78ujS8yIAiMtoEGdc99DOEWd4A
 UNs7jsg5p4ZbcjknxNsjdddwZfR/AVE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-0t5W4jxIMle_jEEjpDU7Dg-1; Wed, 10 Sep 2025 19:07:06 -0400
X-MC-Unique: 0t5W4jxIMle_jEEjpDU7Dg-1
X-Mimecast-MFC-AGG-ID: 0t5W4jxIMle_jEEjpDU7Dg_1757545625
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4f8e079bc1so97983a12.3
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 16:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757545625; x=1758150425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciOy+sEx318rmWVeaN79X+N/GvJ++Y421zGf95hgnJE=;
 b=d6ZVWvBHL94M5zeDtP3m3AeEGTMbeX0eY52mZGUVhYnqYxQ8MySgkKx+t9c1YrOzgs
 5OCp6kCJT8mC3vg1H51i+SpaOpB1FJxTQV3qfac/2RSdX9pD09Yt39gsugN6BicKzH+r
 dFgnulrBnfuN+r4i9KiY7D0tYHg/a7yAUqqp6Rl/Mv8OVRmZO3baCByuyGzdMHAUqYUi
 Y+mPGLR2Lo5nc8bctFBZxlMHre82T1Ojh4DMu2WJsF4SbnYl4dL4xscvIESSxSFGKVRb
 7cKhZ0CLfMlqDuBx+ILFQCIw/vHmsRVGZb5QOnNX4JG9/j74M4cNqNkZTH3Qw9rrbpRY
 ezdw==
X-Gm-Message-State: AOJu0YyIEKiTAUSdIoAfuFJxJkGzmaPMLw0Up1w63R9Rn3k/KtMZG99C
 a7AEdKBD3vrRZVbeC/eiKbYHL5NBDXPDBJ9gzCi7ARQ30grVYTg8OTO88cR/E/e5l3qFOJ7By4o
 tG1Or3MLr2d6MV4DbKxSDZHbPtlCMTlP9oXDhEvfaAWhqhxsrTe9IP1hz05r5ioxJb/D02MvOXk
 EpObG04i54zZhD39ElspLWx43rT0I=
X-Gm-Gg: ASbGncv0+c6/orCfcmWQpdAOk8u3IfeIGFKNdtZUdugIv75FcWsIa6tgOyEbdHjLBwO
 cQ2KTq9H0KBmouKd+Z9p8DtE59Ca2TA6PxkbetvzOgK9xcJPoi3TdSAsMFEf4xE1S0YV71mdSAg
 drPfpyljb167v9YOOaX4U8sg==
X-Received: by 2002:a17:902:eccf:b0:24c:b69f:e4be with SMTP id
 d9443c01a7336-2516e97ed9fmr256818005ad.6.1757545625440; 
 Wed, 10 Sep 2025 16:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0IKqQyA0Nu2oEAkmr2mTS+glvG+NK0iKOYd5cs74TJt4Um6zXQdsFajQzhIf7+zipihUrTFKfeEejZ4bIMnA=
X-Received: by 2002:a17:902:eccf:b0:24c:b69f:e4be with SMTP id
 d9443c01a7336-2516e97ed9fmr256817785ad.6.1757545625076; Wed, 10 Sep 2025
 16:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250906004031.33513-1-liwang@redhat.com>
 <2809360.mvXUDI8C0e@thinkpad>
In-Reply-To: <2809360.mvXUDI8C0e@thinkpad>
Date: Thu, 11 Sep 2025 07:06:53 +0800
X-Gm-Features: AS18NWA7Hss2SWTUIXd0aFeoqGrnUjkoIVIPZk2gpE9bPehSs-H14kf8sO5cRII
Message-ID: <CAEemH2fbh2K_oLgECrjMnLftWNs9HEy_ue3_=-GL8_GczcCzhw@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iEVSZylasABhmqiCWaRO1O4U4-86AcA7xprvjmoxR80_1757545625
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] sched_football: synchronize with kickoff flag
 to reduce skew
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch merged, thanks all.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
