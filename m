Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F898E77197
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 02:52:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A4323C19E8
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 03:52:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0E2D3C180F
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 03:52:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF3F02206F5
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 03:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736304725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMqTR7gyTTmRS+yQphhHJIFp01ritrR/bq+XeLxvXcU=;
 b=hZC+AA8Qo3O2yg3vPqy6/X2A+YovlD5VlF1Gm2yEFSUjsHa0MOm3uAjYix5PkzNRtl/Zwp
 rt2wUj6UEdpMYJRStyOk7xsXwQKa2HNpFPoJnf/XB0IzFVZcm7pmOCqNHHLxW8Jz4FSt8J
 Lxol58qsiEaxMIIRQ14P+3IajI64O2Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-HBQ6A5c9PaObBEvU_vKThA-1; Tue, 07 Jan 2025 21:52:04 -0500
X-MC-Unique: HBQ6A5c9PaObBEvU_vKThA-1
X-Mimecast-MFC-AGG-ID: HBQ6A5c9PaObBEvU_vKThA
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f2a9743093so24266953a91.3
 for <ltp@lists.linux.it>; Tue, 07 Jan 2025 18:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736304722; x=1736909522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sMqTR7gyTTmRS+yQphhHJIFp01ritrR/bq+XeLxvXcU=;
 b=k0E0WGmlREG8gvhXJh+u3Vpg2DjvDVQqIu3DevnUF4NrmbDQZRWN+MPhhZST9gozBS
 iLoJmtfVdeVnz7oVFpg/OtEzAd89CvxGzHWdZUqCReuPkWER0OipdJgti341c/tWiLnm
 MHHjMU/gXCQ60Y/0KhjI3rwUWkT6Ec+2k9EIIF1EFnI8LU62LlH+XQ80jnY3qzN4B+PX
 j9fbWvBoi0+/z6dZWAbHRP9KNHugMjjlC1hPlSJ5atDIb7s3e4H4ygILCWUWWPNPnZYR
 jE3WWKC68iZ/AtvfCWqFsyo5cmPOkq9zq/ppjwm+VzTemI3QdrwPSIJqkkzIGSsz8tkZ
 BT8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMAZiOEqIXfn1hb5JJczVST2381qIZ5Ad14j69MLSldt/kr9XZPqMfSbA2lHDI4iht/F0=@lists.linux.it
X-Gm-Message-State: AOJu0YwN1xlseLw9ahqxezySEzgFw7IifwPOPBfKZyfDgr4JItxwTwg1
 xuHIhQwVj+M9+qbZG5ioA581oYszaHgApjDVVrsiUuCtdx5w37EYQkOSrZHRKBMNx9/xi3pF3l1
 2Y204iEM8G0db7IuE82x9Se840BCZPWAbBBpDnBaKO1J3hG2B8nozAoou1vwldFABCP3bjCRYHS
 pppZexfXxyOqMAk9bBzCWRpUuefDjfooAhXi4q
X-Gm-Gg: ASbGnctwnz4MP4pNjNINKMP7tTfk3zlJVDTu5Q/2FHCnZLMeDl4AB4jPSGeAczkRwE9
 bgcXUseJnrtCa98GISWI3tFAMB9/qW9NjUvM7pmY=
X-Received: by 2002:a17:90b:5484:b0:2ee:b8ac:73b4 with SMTP id
 98e67ed59e1d1-2f548f4265emr1508746a91.36.1736304722099; 
 Tue, 07 Jan 2025 18:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc2hyJyLuZgVvWnVVeUUR5OomcR+7PYtbaE9gpuHUlx53/EfRN+p0BpTsLckqIalCblVIg7nNnwr38XsgSf1o=
X-Received: by 2002:a17:90b:5484:b0:2ee:b8ac:73b4 with SMTP id
 98e67ed59e1d1-2f548f4265emr1508731a91.36.1736304721868; Tue, 07 Jan 2025
 18:52:01 -0800 (PST)
MIME-Version: 1.0
References: <Z3gGuFHey5qgQ__6@yuki.lan>
 <CAEemH2cawEE9=-3=QUScg+K4JYe5hqhYMtUManS_8JsBfG30AQ@mail.gmail.com>
 <Z3vII4tENjV4G6GQ@yuki.lan> <20250106125255.GC302614@pevik>
 <Z3vc-PafjaXVIcRJ@yuki.lan> <20250106153624.GB323533@pevik>
 <Z3wCr3LG_ztyQYHj@yuki.lan>
 <CAEemH2c28ob0=3tq94i7AiwFZW0EyGnb=WAP3P3Qftwb6hLkuw@mail.gmail.com>
 <CAEemH2c_PLCAg4ScxCgbDvFYORfsR3R-xw5-dEWxhzdrNvmp9w@mail.gmail.com>
 <Z30hKu11NUNI_uaJ@yuki.lan> <20250107164943.GA396751@pevik>
 <CAEemH2cNgZxcBBRoqMc28qepA4eRkjea5cH-761NMsMr4y8wTQ@mail.gmail.com>
In-Reply-To: <CAEemH2cNgZxcBBRoqMc28qepA4eRkjea5cH-761NMsMr4y8wTQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jan 2025 10:51:48 +0800
X-Gm-Features: AbW1kvaSSXQ0MjjycPmmqASo9P7e5qGvZ1vF15zSRwwKFFYNkXgSXjD4UfT8EfY
Message-ID: <CAEemH2fFw=f6ZuttwQ=RYvw1icVFpCuhH==qUfwfJ7Jb44mgRA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IEcwbf4mYR2s2h_tYKr9vV0sGzYGxrEYjqDEYzAWW0w_1736304723
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigsD
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

I boldly merge this patch because it could temporarily resolve the
side effects and help extend the time (on slow kernel) for most tests.

And, based on the above discussion I will fully work on the new
timeout+runtime method improvement this week.
Hope we can get that down for the coming release.

Thanks everyone for the suggestions!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
