Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9119C282CD
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 09:23:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FCBA3C9DF2
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 10:23:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 490A93C66A0
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:22:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 31464633970
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:22:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740734562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SsghDyExehaxpvpB/6Dr6FAwKpUCpnvAyFRPAQpi04=;
 b=YihkabnhPrIbKLxUh0jR0aFe8B37iHD/4hT9vZP6ErbWOXo/GrwZV2dOqWQXv7l3K7Jw9R
 mRG0ABlcbWlmxhjseK+qg/hozck0SwxZ2ZSYlKj1rF5gIfmTnvqtv7UfPjhRetKX5UygaK
 eYLkeSR9cpWMy29XviRUN4lT4q8a2Vc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-MmBKmiKaOv6DH4s9LAYbdw-1; Fri, 28 Feb 2025 04:22:40 -0500
X-MC-Unique: MmBKmiKaOv6DH4s9LAYbdw-1
X-Mimecast-MFC-AGG-ID: MmBKmiKaOv6DH4s9LAYbdw_1740734560
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fbff6426f5so4261546a91.3
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 01:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740734559; x=1741339359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4SsghDyExehaxpvpB/6Dr6FAwKpUCpnvAyFRPAQpi04=;
 b=iVXV8bCmrPp4xUsDG1TnnTNTPNsbfc56LjZq+Fa2o105oeUYiuBpo+iX05YpDwOa1D
 QSvXuIvMWiudnjwL1iGcl5eoYEP4FK0OyewLvUDdwbBwY8qYIuUOm5uW7ny+07r1qTn4
 C8VDawgtUkG5rtEknQIYdliJMnol93amCE5snzOMEonTDOn/u0WhYo/fd7iXN7An74Rh
 7Qk5bjSpnWfpLb3M53f0LGnJFcW8M4WIKgONgiRmHrdK43u3swo0gGvXoOrO8a93+WNI
 T0OmtbYys7+leZeZ6a2bdTKsDyFOOVHeeS5I4/N0x82/4agGE0sfZUve3bUrWteIsYaL
 CakA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdn//YevNE/KIXybGRjiXv3F/rdV12hvLr1bID2p4ZFfd8xCHw+wm4lKd9MZN+TyKc+WE=@lists.linux.it
X-Gm-Message-State: AOJu0Ywx69quObR0Vt4bv7zuxRpuuuI+K2dAGb1jIvi0hQYaB5f7LNUi
 Xi3E+F0IU1K9hd39y+Qq0fO5UUrDp0gbohbpUoHwgr1mdAD2OiE2O56y9zuWxE+3lfIIxvV56SH
 MQAxYot/RqorPyZMA5cDUr2Z4XRmSS+VNHJmTchUsMsai6AzGovWX3LHbWRo/w0X55ENHCou2wE
 ZeohFgz+FImG2OFDcFe2L06J2R1lr2MVRLK2zw
X-Gm-Gg: ASbGncs3HHn66otnmpEYXgNzrHPFaFO6H5LEfv2N8IsUd9nnZnGs24OYdzl02yvRJaf
 wpw/L9FgT4d86lNBsBZWn00igfMm8oK5V7FwaDB5euihwAsK0IoVbpA6+DozycgQO0x/TxMA9Ng
 ==
X-Received: by 2002:a17:90b:4c07:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2febab2ec91mr4160097a91.5.1740734559009; 
 Fri, 28 Feb 2025 01:22:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE69qjU7YpqgzHd9YZpXMnVGj8RP+O8ZM7+MrzzEkdYtgrymQvgwoORcaaw5py2v0C9zVXZClzs8R+dKoiktZI=
X-Received: by 2002:a17:90b:4c07:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2febab2ec91mr4160067a91.5.1740734558718; Fri, 28 Feb 2025
 01:22:38 -0800 (PST)
MIME-Version: 1.0
References: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
 <20250224030743.1567840-1-chwen@redhat.com>
 <CAAA2g-1m5Hfq9nygiCnFFwt6Axgxjj3dO=2Ei_-cgSw3dT60Bg@mail.gmail.com>
 <CAEemH2cpdqSViHfDcRfFqsWtz4kkrkhU4DymfXW+5REPEMvYTw@mail.gmail.com>
 <54cd690b-dd2a-4285-8d53-5aef05be3d6c@suse.com>
 <CAEemH2fPRiZOOY4UUfQQVLe6+8N8PtK3FON6pB=jpgbK_HQdfQ@mail.gmail.com>
In-Reply-To: <CAEemH2fPRiZOOY4UUfQQVLe6+8N8PtK3FON6pB=jpgbK_HQdfQ@mail.gmail.com>
From: Li Wang <liwan@redhat.com>
Date: Fri, 28 Feb 2025 17:22:26 +0800
X-Gm-Features: AQ5f1JrUx9nY7eAbIQKKZ7IUNAK6BzOOY2Bhs2VlKlf8uhyiT7AMBBP2lLEf_lE
Message-ID: <CAEemH2e6XYnVwx3t+_Qn_pw5-RSnp1YRxLuEJ+EBFkF8ir3ybQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KeDj6sKJ7ZLm4EC0h_iZ3iphQdHWP-7wmDYJZdHUEDc_1740734560
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Add test case to cover the setting resource
 limit64 for process
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
Cc: Charles Shi <cheshi@redhat.com>, ltp@lists.linux.it,
 Irene Diez <idiez@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Li Wang <liwan@redhat.com> wrote:


> P.s. the patch caused a compiling error on Alpine I haven't figured out
> reason:).
>
> https://github.com/linux-test-project/ltp/actions/runs/13580985467/job/37966850497
>

Well, we have to enable _LARGEFILE64_SOURCE macro to tells glibc
to expose 64-bit structures, see:

$ cat /usr/include/bits/resource.h
...
#ifdef __USE_LARGEFILE64
struct rlimit64
  {
    /* The current (soft) limit.  */
    rlim64_t rlim_cur;
    /* The hard limit.  */
    rlim64_t rlim_max;
 };
#endif
...

Sent a patch to resolve it:
  https://lists.linux.it/pipermail/ltp/2025-February/042497.html

Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
