Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF592C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 07:49:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73B613D197C
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 09:49:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 341153CB579
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:49:28 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CDA776181D0
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720770566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x34aAiJF98F2hxB6fhra+RJ/wP58f0Psv4ODH5EebX4=;
 b=ezXzZ2yxJSZeCNVpIZ5FlQjDG+9yQKnjF/mqTnWLvQCy8EBfZvVQ0D5tNzCS1cIETwRRNf
 ycaWb1eRv0UpoIOMH4uviPHmrw2VTzIHNKBnFPrHufFdAgTdGAKEB4Fb7wAjx3nvsU14jG
 pSttbjXnKkpmPNJc9luR7BNiAAC89vQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-cEqdymHXMIiF4Euhk58Lzg-1; Fri, 12 Jul 2024 03:49:24 -0400
X-MC-Unique: cEqdymHXMIiF4Euhk58Lzg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c95f737113so1707703a91.0
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 00:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720770563; x=1721375363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x34aAiJF98F2hxB6fhra+RJ/wP58f0Psv4ODH5EebX4=;
 b=jozB73ZPvsA3uRmuj8kOzvxIijkCDufJymyhlmBKcp2PEL6+ljRvzvqG9cwqTYynjs
 zhcLKWoZo/p32lH/ARwxCpD/fVQ1ZAdZ/SyD2d+CeKSvauDoN1fSNaCejrTP8gjMOSCe
 4nIgZwAO9ieBwAaz+Gz9wvePTzjZI1qom9nyi+Bb7Ulo+gt69taGCFSO0k9650I9QIDe
 qEczJS0H7wRvfhVwrDPadxDIAZPIE3b4mzhFhyD6vuSsf573D+EXDBomManOKCKX4RSh
 OwabSkL0x+hM8NIJR6jFCCo+OpH6AfyqC8toSmiV8SepPtjaWt2r5p1feFLMMoJCgVny
 T8cg==
X-Gm-Message-State: AOJu0YzeJLW0SFqNy/5W81kveXw0g/qwJb+OGYhOPN8GTbvhqvllIUrA
 DP92V0W7ZKTnhXApp7W2l/rCiM6TehsB4c432+5CtpG8GF0ufI6htJYpD7yfvgfTTJb631fZMH4
 kTVPdbYxHWj39rDbMNyjEiluuE08689jvj+l+vch7MhvRkhXuohwsIYpaGlYRMqBcDYFvyJ1wlV
 yUxl1KKD/3HCuMQv8M6Yjqzp3EKs8FcGLVtg==
X-Received: by 2002:a17:90b:368b:b0:2c9:7e9d:5344 with SMTP id
 98e67ed59e1d1-2ca35d48688mr9096932a91.32.1720770562764; 
 Fri, 12 Jul 2024 00:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoP3q4l3ROf+yntNXLUkIguoEUKb3jeV21VULkNzF8t8q5FU7iaJWyiYLtVN1yPKObQRzT7PSEk2ZKL0HrSps=
X-Received: by 2002:a17:90b:368b:b0:2c9:7e9d:5344 with SMTP id
 98e67ed59e1d1-2ca35d48688mr9096922a91.32.1720770562446; Fri, 12 Jul 2024
 00:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-8-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-8-c7b0e9edf9b0@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jul 2024 15:49:10 +0800
Message-ID: <CAEemH2den+BhfjETwe+EOywhc03fcZ27iBra8jzAMxE+TyOY1w@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 08/11] Add CAP_MKNOD fallback in
 lapi/capability.h
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
