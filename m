Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE89CA0FED
	for <ltp@archiver.kernel.org>; Sat,  6 Sep 2025 00:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757120332; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SAw0PpTeMu+vDLe4Oq53kLPMvoxIlNLAv4Qfv+9aO6s=;
 b=PNk4B2qNfFGql4teZQSlG6P5DpUcaaljH8Eexx8By9ZX80rLFJMTu0Jv6w23croOGJVY7
 4tV/ZyLapT8y/I3aJ/Q1ntGhrwXGxSFzMtTZVsnRLiOq9Ukg7wkG7wbTYG0+Uiv/sUS4Xfb
 JYEElKE9v7ZE8LXpAh0Zo5gfe/CsMKQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 556343CD532
	for <ltp@archiver.kernel.org>; Sat,  6 Sep 2025 02:58:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 996013CB864
 for <ltp@lists.linux.it>; Sat,  6 Sep 2025 02:58:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E686C6008D0
 for <ltp@lists.linux.it>; Sat,  6 Sep 2025 02:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757120309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n8oyqfm14x5fpRNMWrSsrYAEKa/BQioXSOpI3hBgNos=;
 b=b6+b+HuLr/b6+8zDV2k29whxArn7B+4bQAh/IzR3PW9HR/WPsWAmyKZqEJ0bWfTKtjKcdj
 ANdheQ00ALm1oZB0JdJomVGPFnia3p2X4envZdh4HiAWnv4zujnIepmtPknNr0riUuNQTQ
 PPWVRO+Elg4QPmqd/U7zx/V0kzc5Gyk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-3BZ-46mWPxiWm8OGcepl4g-1; Fri, 05 Sep 2025 20:58:25 -0400
X-MC-Unique: 3BZ-46mWPxiWm8OGcepl4g-1
X-Mimecast-MFC-AGG-ID: 3BZ-46mWPxiWm8OGcepl4g_1757120304
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24b2b347073so37342045ad.1
 for <ltp@lists.linux.it>; Fri, 05 Sep 2025 17:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757120304; x=1757725104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8oyqfm14x5fpRNMWrSsrYAEKa/BQioXSOpI3hBgNos=;
 b=WRlcGwp1rMSlPT9i0guZUWpZ2+hnWQowhz2flvwSR6sPLqzuK0Ebp4OH8aLeLx7Xra
 K8t+++reZu6SRlg5tp0UlTBt+ZlFs9mr2oRDbglA+J4FzJpllVQMgnGXY1t7rtO+1pdU
 /rP4xAcY8kmBcQ2oaARYUg12EwrfrXktoaGmOhY9oXz6vDCPb/6NCqKtKMBTPlrmoyv9
 clufgVD/eUUDUjq4czGGrCotKiPFqwikVECxxEMCgLYY8DBJDqZr47epuEOCzHXEVVFP
 UQ9Q/0GJ3ZtfDPxkPo5aVyFoRYVszhCiC+MFzgLSxQPOwYSpTKQkza41UP5z71z8d9Xz
 po7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfv8aoccqOmvugYNdHjNs8hrrDTq6HWowps26n8rqsL4N1rGE8V1JrmbZQDrUhHRi0MpA=@lists.linux.it
X-Gm-Message-State: AOJu0YxJrwudNOprkGDzp3sNfeEyHLvvCkZWJIf9uuLofyKH0Rp9M1WB
 nI1ongeW11rCdlct4kOirMEBA2J0lodXCvuxMMsQ3/IoWdcE8zXh13aNRNnME7khIgs0K8P4p7Z
 cMyDB52L+R/P0SG68oR+ODOL+v5IfYV29Jl2ZVVKPoyWhf57iRHUelY6dg4+AdaTsbBabI+5Hdk
 NXObRRy7SjgMQUyf3naWu8s0b9hNw=
X-Gm-Gg: ASbGncsQSn510NMJP2PML+lybQi+yrUV27lb8j1mrTDeAZSyR4q7E5dP8uxc8uTfWKO
 1WyzfgMpyw6yhyGsCFxlagytVh8zlZldS3VtgySr5+QulmWDEVZzQVJE8wWy4CUbyNsUk+Wpu02
 cSP+MV70Iua06iH0fGxFScgQ==
X-Received: by 2002:a17:903:1b6c:b0:246:2ab3:fd7d with SMTP id
 d9443c01a7336-2516ec6e91amr7199355ad.25.1757120304339; 
 Fri, 05 Sep 2025 17:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIuNXILUoYedufCKiQtyzrzj23nCUPUmaQjxQ02iMs06wX+HaHscA/ND35BmqbgSm0eVPXF+z+a1qhU/h4SMo=
X-Received: by 2002:a17:903:1b6c:b0:246:2ab3:fd7d with SMTP id
 d9443c01a7336-2516ec6e91amr7199135ad.25.1757120303977; Fri, 05 Sep 2025
 17:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
 <aLqq9o9Dkbhr957V@yuki.lan>
 <CAEemH2cRQVq4N-SdRTFEuUzyUbqfCVg_mpQ58t1BeaNSO9NuvQ@mail.gmail.com>
 <aLrYUvN7UMpd64iJ@yuki.lan> <20250905124632.GA12403@pevik>
In-Reply-To: <20250905124632.GA12403@pevik>
Date: Sat, 6 Sep 2025 08:58:04 +0800
X-Gm-Features: Ac12FXyAX10AyTGx-pK7iSL663o7tnDS2W8gTxncO11UyKM-p-lvohdOZUIGOiI
Message-ID: <CAEemH2eKqnUhVRCYV=8SdfCtW5ZN5bWMvPML-H0AkTd5GxXT+g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gz5-Wi3pydQeLybgCRQyTQZxTM1ATuD8eI05Je9cRPA_1757120304
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
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

Petr Vorel <pvorel@suse.cz> wrote:

> Hi!
> > > This has improved something, but still observes sporadic fail on RHEL
> stock
> > > kernel.
> > > However, both the RHEL RT-kernel and the mainline v6.17-rc4 stock
> kernel
> > > pass.
>
> FYI I run tests all SLES and Tumbleweed versions on non-RT kernels, with
> -i50,
> for both master and your v2 (with enabled non-RT kernels).  All are
> passing.
>

Thank you so much Petr, it's valuable to me.

As patch v3 has just been sent out, it would be great to get SUSE tests
against that.
(so far v3 passed on all my RHEL + stock/RT/mainline kernels :)


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
