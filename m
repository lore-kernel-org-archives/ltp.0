Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C3CCA6017
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791625378; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=KGCkzj7a0RBPTICDdHf2XdvC53dn1beJdDKgFQRk4V4=;
 b=m0xW6uCm8QQyZLdvprY0ggFiAf2xtRIMgsNC0MkV2OJgGwuYI+tVbk4UgT42Hs1YThWKg
 R4O7cbBbAAMJNyTKnEtKuIatn1nV31SroQvoUAy8if5MB1Ifgn6ig1oR54ffoInWRQ8ovWR
 MfoPyAeTJlNonXiw9nOl3zjRJAN9E2s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF94A3E2D20
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:42:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 156973E5381
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:42:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B66414000E8
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791625350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=714aWoimB+a4dguA0ZS0bJJ1S2xHu/IHk1NgU3D7+ko=;
 b=AS5ZFPl3pkTrMCktnXQTlkbXPBKgtni2yF7uYOgDuLHJvD3zYjhpRqCWgdZvk5QW19Vqds
 L1CxyeenE0kBgz/UsLvLpV9GilqLPf91/Swvjln0A4XVv55yr71VNGciar1Usnr642EUvb
 +VzeRZxKT7fODRHeuB5bgIy0HDQUGI0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-M1LfTv62PKWBBIptA5NC0Q-1; Sat, 10 Oct 2026 09:42:23 +0000
X-MC-Unique: M1LfTv62PKWBBIptA5NC0Q-1
X-Mimecast-MFC-AGG-ID: M1LfTv62PKWBBIptA5NC0Q_1791625342
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a020cf06c3so2527785e9.3
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 02:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791625342; x=1792230142;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=714aWoimB+a4dguA0ZS0bJJ1S2xHu/IHk1NgU3D7+ko=;
 b=1jzr9eL/pfh1KtNIHp9dFYc/P1Lm7ERsZOcdG9KkvlMd+2f356OzJtbgyWvMA2xZ7c
 drrwfWTU98bY9wHJMcl4vHRaBRi1Cw+XWnluFN2ylBdBCOxo6/x6GJH10ofJE2Xy1xM2
 xSQZIxitvCpyKYK9rgv17+Lh9zw5zmVjqaYGFy5HLGocP8LJgSKcH6a3eMZ3MTkfMG2m
 dfWfXbqpsvfrBSMNPcnkd9dAUcXczESbCKH8zgFPyZEUITUSLYc0bxb1vZMXPUQKc9Jg
 HoySq9Pn/GGsHFLth6u0dhemRcbYSK8kArwe4Jh31iauX1JruQH3WDv47rVU6NWhWyGl
 Rsww==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXUfGBL6WACWHuxwpGBkk4WyHAgLdUzrLoT9pk/ueXoG1fOBABQumuRVQi72DeyuE1VoE=@lists.linux.it
X-Gm-Message-State: AFq9FYJCSqIhYdcV2ebx/scukmncz2JpTuDm+EzXruW9H+v+n850GNGa
 ADv+oBQDjA6krQPnHvLk9nTBvcTOOCTp9Lyx/Z5l7qdb9AezK1j1KXSrCqF5FPy6PVdae2C1G38
 D2BqwBZ1K8+sOHwsC30HmbZFEeN+z/KybpS3dAlZx2y2D7IOmSiCB1+hVwmZJgvksov/Unp/h14
 5GlbJdo0HqAp7KHHshmurTQW+mSCk=
X-Gm-Gg: AYBFou0ZWbYj5Sa8pO+e+zjBBvCtRfWtCFGILKv0ED9JMggb6rxLDN6hIP2Jy1gu8FA
 3RBi77k2f37r4Xm1fsVdB9zNYyLPbWPtvU/FKvyt9N5ztDlRr0KF4rkuVIYxw4tLkpLR8W3C9O/
 RMjan2COf6XKIlOpO87gHKWZwDPsx6SPpvCpzzCWLO4gLKHG2QqEWt0uebIA==
X-Received: by 2002:a05:600c:154c:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a18e4a9159mr92875905e9.19.1791625341732; 
 Sat, 10 Oct 2026 02:42:21 -0700 (PDT)
X-Received: by 2002:a05:600c:154c:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a18e4a9159mr92875665e9.19.1791625341343; Sat, 10 Oct 2026
 02:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <24014310ac600340c4ef9720980eac1c047f4b6f.1791543115.git.jstancek@redhat.com>
 <20261009172601.34695-1-linuxtestproject.agent@gmail.com>
 <asoAKV-Wd-TK5XUe@linux.dev>
In-Reply-To: <asoAKV-Wd-TK5XUe@linux.dev>
Date: Sat, 10 Oct 2026 11:42:08 +0200
X-Gm-Features: AclHuK8QH5WnZzx1mIatcKTVJYrqfWj1hzh38krzD0wXBeNSvd4aOlwgMjHoKAU
Message-ID: <CAASaF6wO7=9vHVJ3BxE307tFc1n_xbJEihw1EMECsRNhxvvDHw@mail.gmail.com>
To: linuxtestproject.agent@gmail.com, Jan Stancek <jstancek@redhat.com>, 
 LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Anwzi401g9EPGAAiH2JUp639dG6lp5V-zfgoQHk6RGk_1791625342
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] openposix: timers/twoevtimers: Wait for both timer signals
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Oct 10, 2026, 11:07 Li Wang <li.wang@linux.dev> wrote:

> Hi Jan,
>
> linuxtestproject.agent@gmail.com wrote:
>
> > Hi Jan,
> >
> > On Fri, 9 Oct 2026, Jan Stancek via ltp wrote:
> > > openposix: timers/twoevtimers: Wait for both timer signals
> >
> > > +   PTS_WRITE_MSG("Caught abort signal\n");
> > > +   PTS_WRITE_MSG("Caught alarm signal\n");
> > > +           if (errno != EINTR) {
> > > +                   perror("nanosleep() did not return success\n");
> > > +                   return PTS_UNRESOLVED;
> > > +           }
> >
> > Medium: PTS_WRITE_MSG() calls write() without preserving errno. If the
> > second signal arrives after nanosleep() sets EINTR but before the new
> > errno check, a failed handler write (e.g. EAGAIN on a full nonblocking
> > stdout pipe) causes a spurious unresolved result even when both timers
> > fired. Save errno on entry and restore it before returning in both
> > handlers.
>
> The race condition pointed out by the AI seems plausible. Would it make
> sense to save and restore errno in the signal handlers, like this:
>

It seems very unlikely. I was thinking to move the print outside of signal
handler if we want to address it.


> static void handler_abrt(int signo PTS_ATTRIBUTE_UNUSED)
>  {
> +       int saved_errno = errno;
> +
>         PTS_WRITE_MSG("Caught abort signal\n");
>         caughtabort++;
> +
> +       errno = saved_errno;
> +
>  }
>
>  static void handler_alrm(int signo PTS_ATTRIBUTE_UNUSED)
>  {
> +       int saved_errno = errno;
> +
>         PTS_WRITE_MSG("Caught alarm signal\n");
>         caughtalarm++;
> +
> +       errno = saved_errno;
>  }
>
> The rest part looks good to me.
>
> --
> Regards,
> Li Wang
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
