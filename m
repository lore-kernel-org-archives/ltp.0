Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953BBC433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 09:55:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24ECC3CAAF0
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 11:55:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8143F3CA9B6
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:55:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE7B9140051C
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:55:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652954122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAVnq2MB/SFiU6+hRgeOhx/HU2+bmzAnsJhnKPRQ4zE=;
 b=i4wRCvIaf+T9+wj/M/Ym+h0f6QWqubxu1iCy+bEm/w+6haJTSTAgU7vncKC+70tfZxxiPc
 VSss4HDVy8IalH0anMy/dBAyHsixtLia9I7fjbgHuW6nl4wndI810QWerIdaAygT756kGv
 CN+lXGXvyECej7T/rpw5RE4MHxfwnvo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-sNkfC5FUNKu0Mh-T5O9M_w-1; Thu, 19 May 2022 05:55:21 -0400
X-MC-Unique: sNkfC5FUNKu0Mh-T5O9M_w-1
Received: by mail-lj1-f198.google.com with SMTP id
 y10-20020a2e95ca000000b00253d689f32fso199228ljh.5
 for <ltp@lists.linux.it>; Thu, 19 May 2022 02:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XAVnq2MB/SFiU6+hRgeOhx/HU2+bmzAnsJhnKPRQ4zE=;
 b=nwsLTx6uinFn4F/shEj9Z5II0Z8GVTUUzNsp29KPJ+RZ1ba6+okMCM/jDw7HIZr4KE
 6ldaNWO7Rz6iFbVMbsTAKWqlKlAZEOwvMbNEmmIfdOyNJLpjJ9tpFZtuyOb85NNIEffw
 2DMqbFcruoih/Xpi/Uv72YB9Mt1ShI53KVWeffjzFSi3D+EFjJ/mG8h5aQSoGIp/bgLb
 Jg6O+XXe+AL01+SOWqLVTLujUAR0123ksTpxwOCMJQhQuBwCetTidI1gnzVGAN2WbwXq
 bf4Cf3o1IlwIVOnfZCNC8B/ecyX2CghtkapzHWt+S5xTEs/sosuuGJAoUuFLIHPQR1RI
 BHOw==
X-Gm-Message-State: AOAM530/iHLJ2xi83nbeMPN3dOLc+PA1hivbRwWz+hmLDKtJvHsJeIMO
 SlZjZc01HOBMMaNnJXanbrsbxd2WR2Vy8nyELBQCSwB6L06xwg6sUVrGDqBTFSqfmqzH4MpEf/+
 V/yHB3cPKQROHy6PYEcvOQT5SXAc=
X-Received: by 2002:a05:651c:248:b0:253:d7cb:136 with SMTP id
 x8-20020a05651c024800b00253d7cb0136mr681519ljn.65.1652954119471; 
 Thu, 19 May 2022 02:55:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3h1mcxeoPC8p92tS1oHGcT4x3T9IDbSbSHO6mhxi0mS/ZOK2rCsUlVKD5YmuyVtE/O87OAESqXIG4Nqed3a0=
X-Received: by 2002:a05:651c:248:b0:253:d7cb:136 with SMTP id
 x8-20020a05651c024800b00253d7cb0136mr681506ljn.65.1652954119260; Thu, 19 May
 2022 02:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <47bc8106e2c6f59e297e7cdabea3eef16e65cf44.1652950191.git.jstancek@redhat.com>
 <YoYSyilDnoypaFXF@yuki>
In-Reply-To: <YoYSyilDnoypaFXF@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 19 May 2022 11:55:03 +0200
Message-ID: <CAASaF6xaNt5-hLkm=eY1yfZevASpHbKVWz03pzJ+jPp9Ueywbw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/set_mempolicy04: fix node available
 memory check
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, May 19, 2022 at 11:47 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> > index 4399503c3054..2a1d2e1b9ad0 100644
> > --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> > +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> > @@ -40,9 +40,11 @@ static struct tst_nodemap *nodes;
> >
> >  static void setup(void)
> >  {
> > +     int node_min_pages = FILES * (FILES + 1) / 2 * 10 + FILES * 10;
>                              ^                              ^
>                              10 * sum of 1 .. FILES         |
>                                                         And I guess this is
>                                                         upper bound for
>                                                         FILES * (j%10)

Correct.

>
> Looks good. I guess that I forget to update the estimate when the
> allocation pattern got more complex.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> Also I guess that this should go in before the release.

Thanks, pushed.

>
> >       page_size = getpagesize();
> >
> > -     nodes = tst_get_nodemap(TST_NUMA_MEM, 20 * FILES * page_size / 1024);
> > +     nodes = tst_get_nodemap(TST_NUMA_MEM, node_min_pages * page_size / 1024);
> >       if (nodes->cnt <= 1)
> >               tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
> >  }
> > --
> > 2.27.0
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
