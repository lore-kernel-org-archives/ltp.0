Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4029AC3DA4A
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 11:49:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61FB13CE1E8
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 13:49:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8E313C7A13
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 13:49:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E5F3860193F
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 13:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724154569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHj1Wxgb323qE7ZxdpjtsPLedZ/1pXLk5C7CQ9ZfMmc=;
 b=CiSUefabWXO/p7scALyQIIDKvO0knIM4e2zHzX6YjsZU8bCrJr2KJSxu5+pa81MMSVHy23
 gGbnUj89g0CozTfyPj1fhUTt87vokb6h7RhnHN5PoL30ijObjQOGGjQJsasqfDLjSGHL6W
 gg86unJjD02ugtytdChNkrGkUUUQwIE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-F6m8f-V-N8C0YXk49voaag-1; Tue, 20 Aug 2024 07:49:28 -0400
X-MC-Unique: F6m8f-V-N8C0YXk49voaag-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d3bbfcc5dbso4954128a91.0
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 04:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724154566; x=1724759366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHj1Wxgb323qE7ZxdpjtsPLedZ/1pXLk5C7CQ9ZfMmc=;
 b=XS4hZpY6oCiYTFNrYa5vPDKv3HHxuWCGIRBCgEknGdl2+HhJY5J7f4QoeK0ThWd5nC
 Eep1iseiqxldUICFB0AgpFBcNyKPSs8ewn0Nan+6QYRpd/qRf/jVxfdAGKNy/ZgNqoOb
 SNj/S9UCqxVMNbyCPDu5HB+5/v4NFA09K4IEtye/Bd3Ihvv62aicaVh+F4kIYAG4uxyB
 B4p94hDT5oylhKxgLWkTaR/UnfFPX+C5z5nPMS/xrSNFJxyD2Alpg9uvLQULnANPqls5
 LWHgeJpZKL7jgFQ7FIrR0l9jlYXl1LeJxbBX8C5bCCkC3mYOJ5agB55ohkg7k1RRtB8i
 ccdg==
X-Gm-Message-State: AOJu0Yym9LeQ6Y6RW9Mt8SO+KQOrL5xxdi3pwuooOwpfS3qraWcDe+Hq
 8MDVLReSEW5vtlL4Pzu1d3LbrcueXtDlYR0cHN6fps9TEJUzvIEYBJ1I6llxb5SEyca9F7vUYBb
 PRqeOy/FnPFB0gOzlpEs/gH0XcEhxsD/643cqUARlBzgHsTbIUvmL4zQskm/jxqq9XMIhEnbU8w
 CR8Xu+Sxs0Vq4DzS/gLSAALYVJgMrKcqB4tg==
X-Received: by 2002:a17:90b:3b41:b0:2d3:b643:8381 with SMTP id
 98e67ed59e1d1-2d3e03e89d1mr12781874a91.38.1724154565990; 
 Tue, 20 Aug 2024 04:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvY5G6ieOBDiUDDwMHRwh78keisVvADkumVgeJcuiyR+oshdKELGQMP6vK+4XzrdUwNJmdZevRGZRQrw9+tKA=
X-Received: by 2002:a17:90b:3b41:b0:2d3:b643:8381 with SMTP id
 98e67ed59e1d1-2d3e03e89d1mr12781852a91.38.1724154565531; Tue, 20 Aug 2024
 04:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240820095328.2746374-1-maxj.fnst@fujitsu.com>
In-Reply-To: <20240820095328.2746374-1-maxj.fnst@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Aug 2024 19:49:12 +0800
Message-ID: <CAEemH2dM42+quE5TKvdmQuc6Ok_wm2COv3EHOaorrt_Skg3bPg@mail.gmail.com>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] doc: Test API: Fix typos
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

Hi Xinjian,

Thanks for finding typos, I pushed all of those four fixes.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
