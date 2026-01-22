Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ED9CA5FB6
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769085558; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DYS115eWyKSVOnDhkE+3g7RPffHmmn1Y0xMQMZtAFgU=;
 b=qCeP8khgVeYK8272A4u/BsnuvY4exvTy1KY3K841n5RMzk7E/Ypl+84pRpHVTa4s9cXX+
 WcetWk/StbhXXZABtig669AiOP5pO+8WOStY+G0QD2S12T5Uiz8qKbe0aZJRVk3TEDN4UVc
 OMAZRvPHCxPcw2J6NBYFvsruZjxK3ko=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9F493CB52C
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:39:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDE243CB452
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:38:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 543A36009FF
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:38:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769085531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=anu0XxLMk3BwirJWWcrjicQiXQhlB7qrfYEHcLIuN0Y=;
 b=QuRsALztaBZ2S/Rk8NUyq27D4B4vUN4ZKbDI1SYKxUo+5VHBE/5Mh+5iiZqN+HRaTMD01+
 2JOyRvhglZU5g3QKRYME7/5L8gA5CfjdmXVm3Dw/s5XovVRSwG79Dnk4h75WeO1CBtZcOh
 hMLUDcX5z8ipeJ9u/3dmvwKoJlnV+bs=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-FeF8yR_kOdCWaDb75-m8SA-1; Thu, 22 Jan 2026 07:38:50 -0500
X-MC-Unique: FeF8yR_kOdCWaDb75-m8SA-1
X-Mimecast-MFC-AGG-ID: FeF8yR_kOdCWaDb75-m8SA_1769085529
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b722bc1be1so4402452eec.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 04:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769085529; x=1769690329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anu0XxLMk3BwirJWWcrjicQiXQhlB7qrfYEHcLIuN0Y=;
 b=uNkD6o9eZfZw3z2R3ODCK+kyW8kp6Tl7dJCH2laVKAgfykUebepXa4qAD3eZeVFBY4
 KdFto239n56oRRJu5Ds/9rlssnWYWPomlPjEQKq9ulGWm7K2zmQfCBnhEH+Ub9tt05Vr
 EOcxGG0Nf8RNAS6Ry8sdc9xc7wNx+ajEeNj82Z3pkH6dlq/SfpNmXh5O1WQdXvP2+4Ss
 mC2ayytP/yECEAGx9qhqKZYK3z2hcSxHgJS+MbcKGrxQ6t2XoQiCGo9hDtwSQ1Hj787e
 IT0LK2wTj4i/xlyUr3ElJnNVLEpzbHS5S6CIME38jfsVwnsTmxkUGu63xNa6HELBZs8p
 +qZQ==
X-Gm-Message-State: AOJu0YwCezfJggTo1CntYp3Kn7hhcSKaOqQKbmEQ/otL0uWILjTFew2r
 7nDCyiG/OfgRO90hkcz5yGgsEN2sNZie+7dBN6MYu041qQYTANmw0C6XRanHObKjdmSa+MTLzen
 uRJLz4vQl0M/H77psA0l9oJMfKRK8y0hC7IXHOpLQIKRKFeryJs3WWI/2VXHm3e4ghr4mvzsbQS
 VJHjKuA1Bsxp8hw6Rs5DnPB3Tb92o=
X-Gm-Gg: AZuq6aLOkZB92WOFslc9TuEmBl1jsE/JZengXgWU+MBTQsitoAy8ocW06WbcfjLxZhf
 4ZkZ+os/xZR0srDy/hPTvjFlCjzECrNgNbAIZzgxNrquv4XgN007SkMYFd3usnN9YeGWzIJNe8m
 A9Hlo1P3ax/TzTJTsb0jOF4+Lx8JvjcAkfiMzs/TBA0r2Jw5Sc/y9tA119cHNvHVk7zDA=
X-Received: by 2002:a05:7300:7495:b0:2b7:2ce1:3e9e with SMTP id
 5a478bee46e88-2b72ce13fa3mr724049eec.39.1769085528986; 
 Thu, 22 Jan 2026 04:38:48 -0800 (PST)
X-Received: by 2002:a05:7300:7495:b0:2b7:2ce1:3e9e with SMTP id
 5a478bee46e88-2b72ce13fa3mr724035eec.39.1769085528527; Thu, 22 Jan 2026
 04:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20260122102210.87453-1-liwang@redhat.com>
 <20260122121756.GB64562@pevik>
In-Reply-To: <20260122121756.GB64562@pevik>
Date: Thu, 22 Jan 2026 20:38:36 +0800
X-Gm-Features: AZwV_Qh_1GBZV9wm8-nXXypC5le8Fl00U9RFqyn8wFfVIKZI9GfQCTYCw1uy0SQ
Message-ID: <CAEemH2d31EzDxcMJK2u7LrEP0aRO5B6hV2HfWt9+xBHmACeVig@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T3m3u1MvhiZBj-3WlOHThTHpltjBjDzjceIn4OfSqFs_1769085529
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd05: allow TCONF when UFFD-WP is
 unsupported
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
Cc: Christian Amann <camann@suse.com>, Ricardo Branco <rbranco@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
> > +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
> > @@ -92,11 +92,11 @@ static void run(void)
>
> >       uffdio_api.api = UFFD_API;
> >       uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> > -     SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> > +     if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
> > +             if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> > +                     tst_brk(TCONF, "UFFD write-protect unsupported");
>
> > -     if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
> > -             tst_brk(TCONF, "UFFD write-protect unsupported");
> > -             return;
> > +             tst_brk(TBROK | TERRNO, "ioctl_userfaultfd failed");

> very nit: I would write "ioctl() on userfaultfd failed"?  I was thinking what
> ioctl_userfaultfd is, but ok, there is man ioctl_userfaultfd(2).

Sure, patch megerd as you suggested, thanks!


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
