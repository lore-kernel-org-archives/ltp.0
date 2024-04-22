Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8E7C4345F
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 07:38:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93F053CFEAA
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 09:38:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18BE63CC7BD
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 09:37:48 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 540AD1400DE0
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 09:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713771466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uEg/5TqY1EidoQP8PTx7eHnzuHb87OGZEHDnxCmqAo=;
 b=AevcTvw35PZvrQcCwJKqEgBbn1GVriD9CdZFO3GC289eShm2iOX2xlpIlMGwuMEvPb6AHR
 95EsRjvw9TPVe4tQgEAWs53cGVthxddG10pZoKcJaUmeO3ZXytQd+VIU+WmBCrL81xvx7i
 7/0XA5kTEE4V5qedjiU5SNUCxwcu9U0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-jVK7xxoTNYetYNALdRTLMw-1; Mon, 22 Apr 2024 03:37:43 -0400
X-MC-Unique: jVK7xxoTNYetYNALdRTLMw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ae0abc0b41so516917a91.2
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 00:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713771463; x=1714376263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3uEg/5TqY1EidoQP8PTx7eHnzuHb87OGZEHDnxCmqAo=;
 b=DTEfzLdO2nPA15TvGhD/YxvIAZO2utWsHclACq7kJlCDRHFp67rryH6dS3Fhx3wi81
 YFU67as9kjD6EDz11pA//MEnT+yqtBBjp/tJac2Lq6zmoJYuQGNdbal5jGhqbafKManI
 SfLYP1hi1d14mV4+7VbE0RcPKyhd8rxcc8L9DR+aOqrOKkcrseawwcZvqjqT9Bp0HpBM
 W6eq+rcpjvUNwIQtI9g/9b+qVoOn/9hp4VtT7YkQah5Zufuhz+I//GTWSwoRS0RZ0prB
 JYQ73ogWYcY4hKl2kvnF6SAHK7xh+WlghoSBXkKcYl4k1wAfi1aiMiOmAU56JD3AG5Ek
 gVzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3IXhYLa8W5p9Ukk225NbI+7Z5dccTgmjUHb9bymX3aYAkfzUwfUdcZLThDrhUN0wapiI0X0XgdSZ+gRm4P6S5obc=
X-Gm-Message-State: AOJu0YxCvoxDJFnrL7LXbaIwSAzugq2Mx1bQ7ELVKkOqYGhXiM8S/yqC
 gSpZ8wmDoavKgQLCebqta+U8W1oeLrlR8afdLQn6iO7kQCmTMXid72OLZ+/EkIqYtKGXc/Gn0op
 DLcI1fm4vlhFPqwezmF9XbjxfdzT/xdOK7OVz2ztjRqdrcC481mX8yask5kexmn4Rtzreqdk63Y
 FCn1p78ArNG0BISqtsKMexTXI=
X-Received: by 2002:a17:90a:5d04:b0:2a0:4c3b:2c39 with SMTP id
 s4-20020a17090a5d0400b002a04c3b2c39mr8607572pji.23.1713771462936; 
 Mon, 22 Apr 2024 00:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvawhLgcsWvu2MLCM7Il5R/+LAM04LYtv6kffL3DhgO2PmTy+spPeycWYeFl/5M3+aan3mFyBRvkumnBdG0sg=
X-Received: by 2002:a17:90a:5d04:b0:2a0:4c3b:2c39 with SMTP id
 s4-20020a17090a5d0400b002a04c3b2c39mr8607559pji.23.1713771462602; Mon, 22 Apr
 2024 00:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240419082549.25476-1-xuyang2018.jy@fujitsu.com>
 <4706602.vXUDI8C0e8@localhost>
In-Reply-To: <4706602.vXUDI8C0e8@localhost>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Apr 2024 15:37:30 +0800
Message-ID: <CAEemH2eG5fZbU_vTneD8fqNf2RKZ5Bg1wwD50wD_rqCQXfuupA@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] gethostname: Add negative test for gethostname
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

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
