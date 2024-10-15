Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FC7CFC26E
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 06:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 249CC3C6685
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 08:50:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B2623C6685
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 08:49:57 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E9AAC2348D9
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 08:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728974995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9eHJIPv9+UnRFXwnGgd8Eysa4uj9INPh6hesTli6c7Q=;
 b=PNs5i2hHI9I9u0K9hO7GLOFd8POSqXzxKqEBvTgsNscULbmuxgw4V75BANGNT+myqxv2KA
 6/ttWT5agEh3/xRrjq8V+vKRf0RQj0bazMre4Qup5GE4mEjIy3wAIJCVKz+aH4DMvDuOUC
 twATQJkMUVIZMcmJ65kCipNiwzuFqY8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-u71xtCAoOPW8E-kwmXy5hQ-1; Tue, 15 Oct 2024 02:49:53 -0400
X-MC-Unique: u71xtCAoOPW8E-kwmXy5hQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7db9418552fso4496130a12.0
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 23:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728974992; x=1729579792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9eHJIPv9+UnRFXwnGgd8Eysa4uj9INPh6hesTli6c7Q=;
 b=tkn7ya/eeOshmU4wIOUobx93ingopH+5bt/gOtuZqKU9kx3G9lm32HhFiZQnfumf9y
 kxecdQnoREu4KoSDL4bjK+eopvCTin15GfrAJ51YXaHeJ4WBD9C8SlQUCFhyEcjunnyT
 ryChsXdmGo7KuoomIYZvmtMzgsC5Z/Vc/PTl0sZgX3fOQ7UqVYjBeb3YLufvcMxjiRd/
 MVLfS5mDcjfjzQdcITo+vpkFBTn09/ngdwKsneRqxt3a6MO/AHkosuwyVE+nr/a9+pV0
 jz0abhjpXRRCC8BOmeFD3fgSb9uc3YEonYmKWQP1FsP/SDxeoG6n8tVBf46t7VjxaZ30
 AcTg==
X-Gm-Message-State: AOJu0YxLlPSWf/mMoQ2DN3G4uFATGkduAeMSnj+rQtF6XzzZx2B2WDI+
 FEXCHOM81YrthLnDxb+/3ezY2Y/1JZtRNXZZgkASx5SOBLXubKdmnAogYFiVrW+dxtk8zaGck8/
 rG8h9fcuVJz0njobYDuXNj4H2TyGkmQrkkI52QCun4Z5dEKoHdEEfrKnZPUN1mc0iXMJdnIl8Dr
 zupaTjSbssXi6mWVNniZbK5mw=
X-Received: by 2002:a05:6a20:7816:b0:1d8:fdf8:973c with SMTP id
 adf61e73a8af0-1d8fdf898fbmr165143637.29.1728974992291; 
 Mon, 14 Oct 2024 23:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe7vYX7clNzPd2MsfKFXLFOTPvZlOcNktRvhsdPpy3/aNfioeinwW2dH+pTXLDWToxQufiM5pNYWwSAknGduY=
X-Received: by 2002:a05:6a20:7816:b0:1d8:fdf8:973c with SMTP id
 adf61e73a8af0-1d8fdf898fbmr165124637.29.1728974991846; Mon, 14 Oct 2024
 23:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
In-Reply-To: <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Oct 2024 14:49:39 +0800
Message-ID: <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 4/4] Update syscalls files
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

Andrea Cervesato <andrea.cervesato@suse.de> wrote:

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/lapi/syscalls/arc.in         |  41 +-
>  include/lapi/syscalls/arm.in         | 819
> ++++++++++++++++++-----------------
>  include/lapi/syscalls/arm64.in       |  18 +-
>  include/lapi/syscalls/i386.in        |  18 +-
>  include/lapi/syscalls/ia64.in        |  10 +-
>


The mainline kernel has dropped support for Itanium IA-64 from kernel-v6.7.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf8e8658100d4eae80ce9b21f7a81cb024dd5057

I'm wondering if we should remove IA64 support for LTP as well.

But whatever LTP keeps the code for IA64 or not, maybe we don't
need these update for ia64, right?


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
