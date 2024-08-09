Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1DDC3DA4A
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 01:00:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 181093D2098
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 03:00:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F30F3D2031
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 03:00:04 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 170F62009EF
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 03:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723165202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jdOVoLdseDiqqOEbKQphprJ0XqWBUrs9CDx2sHgRmqE=;
 b=gOBMK2tIDX4P1U6ZxNUxFdUl/iLpvL7/hEoqLvg9Vf9vknCsuqNT6FPo7IYff1ZolULeB4
 XfBDcmMOZ4vd7o7pkaQMg+jTCKzFofAPLS4sHs7AuPFJ5/vn7SySMrwX4was5MxiJR5t4j
 AzYvU13hw3Ney3f00taaqok6VQDFq68=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-O0EXbb83OhakaTGNJfmjAg-1; Thu, 08 Aug 2024 20:59:59 -0400
X-MC-Unique: O0EXbb83OhakaTGNJfmjAg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7a28f78c67aso1640210a12.1
 for <ltp@lists.linux.it>; Thu, 08 Aug 2024 17:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723165199; x=1723769999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jdOVoLdseDiqqOEbKQphprJ0XqWBUrs9CDx2sHgRmqE=;
 b=OsBk4u0reusnwdIYujK0K3nhpStTUl9MlhZVTgo7a3i+KqRGayGEFEGw9rXtsO6NNO
 z7/CQ+iuT99biB1Oxym9fDEegPCTMIAThS8G5Bp8J4ilqjTh7dWU7UI5yK+lKc2AiYAZ
 sZwJW8I4yJhJkRAPql+jkYNHXAEMIHnvfYS/U8barZFiYkPiWDtIaBD7NLEQsYiPaTjs
 wThZDRoF5sjufAg5CDguqehmbRayVmjYsRnAJRtgIUh8yhYV+SNRLhp0qK+0Pq7mm3JS
 5e6vSRf66xXemtsQM6ZAGhGN/Lo+YK+BgktBAcYgVTjDntQTu+GpLccq0Cc1Lcz6yt/9
 EYJQ==
X-Gm-Message-State: AOJu0Yy1ZB8BzDNz4Q/YYF5oFJTjLgSYCQ6qojj/ymSueaaYyrP2YsRo
 ZIGksjLYkHFULVAji7q4WNhHoBDy5qzMt0HDyx0oSGYNvpoaVWfxXSst3KeXucEASvANr+rrqEM
 yiJMaolOYKr+IFH/yQ2uyiwnGxp5Zoy5fLAZDtY9WHYYNOq8gsRuwuu9+75ugMtmwlal6wtm5UM
 M81nM07gTQ57UzhQSQdh+AD+E=
X-Received: by 2002:a05:6a21:3403:b0:1c4:87f5:995d with SMTP id
 adf61e73a8af0-1c89ff279admr92777637.54.1723165198752; 
 Thu, 08 Aug 2024 17:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv76NGjArie0TYTyybuC3PYr0QmYHTupjeaqCjhdWjkvhmBO9XTYbtKkfdLFq1IVrSBCdrvCPj70k7NXrvJS0=
X-Received: by 2002:a05:6a21:3403:b0:1c4:87f5:995d with SMTP id
 adf61e73a8af0-1c89ff279admr92768637.54.1723165198403; Thu, 08 Aug 2024
 17:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240808065732.64328-1-liwang@redhat.com>
 <20240808074416.GA306790@pevik>
 <CAEemH2cTymz-XGi+PLLSLLy2tYynKS0Rv6qhi-0LP_JNtp07vQ@mail.gmail.com>
In-Reply-To: <CAEemH2cTymz-XGi+PLLSLLy2tYynKS0Rv6qhi-0LP_JNtp07vQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 9 Aug 2024 08:59:45 +0800
Message-ID: <CAEemH2fzzyzUDktrNgwfO8CDMtn7YQVXgjZ4Wk=ktzYNco+m5Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] pkey01: Adding test for PKEY_DISABLE_EXECUTE
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

Pushed with minor changes as you suggested. Thanks!

P.s. The new test passed on my POWER9+kernel-6.10 and Skylake-SP+
kernel-5.14.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
