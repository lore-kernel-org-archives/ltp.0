Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF3C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 02:21:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B9660E52
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 02:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9B9660E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F2493C977E
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 04:21:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFA863C2E47
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 04:20:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4900B1A00363
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 04:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630981249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pOGrJaGzxB2tQOLNRGdmPO3yaIO8vd0DAk9dhJrRHc=;
 b=YdGzEcabf0Cw6/Rm6X2T+uuT+55WmBVPM9g2RxzV0S7Rgyr0bTSArNY3zEvXFYAFWQ5L5E
 3kedbYrs0azRPSNRZV3kZve8Fs/vitpxmI54Sj1b2hMMwK6lBLUykIQ7PqclCzbG40IKBT
 tqWkeyvWqKeEiMm2uxhHO0V+HxIYFcw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-4fBr2NqdOTibd7RysK1pCA-1; Mon, 06 Sep 2021 22:20:47 -0400
X-MC-Unique: 4fBr2NqdOTibd7RysK1pCA-1
Received: by mail-yb1-f198.google.com with SMTP id
 b9-20020a5b07890000b0290558245b7eabso9812234ybq.10
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 19:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9pOGrJaGzxB2tQOLNRGdmPO3yaIO8vd0DAk9dhJrRHc=;
 b=cfFIDFYZE1ckzm0L8ECCg40eJLmkhJrSA12MytE0qqGv7iev5gSsPHnS3QUpRb80el
 k6kNGRMURhtv+ijSrTLL2SDbkNFwAucHZUlZamfGSPlMwJdi3TR29BghLtwKf3RCbs+O
 6v1aJ6GcVIKlTqh4LMBnQpzHvV/TeTYEG+ocR0O/j20hNVkbI3M6gzRO7fNzXY0h+uH8
 IjpdzV5tG2MIsTdeCn/ojs15Od5fbIutGCy2/zANMP+t3BE47Mvfe79Ud3MLg+eaPxfP
 XGv2JJutJsmxBJqFEw9fo6z1GmTl/bQJTbaqaQtiRU8qaf4FtBWB2c8IsVxD1gH8D3WS
 qPeg==
X-Gm-Message-State: AOAM530Ud/VT2SAnNub5/Al6jY7qDKNvk7mRoEgaPvICJz3iT1j1zG+N
 B98E1fsM//I+O+vj6QuYtYq3iylwd9g++KOgWzhkuNlgYDlwwOOfEAJNcb1GrHodyve2K6YZGvQ
 PKNE5zSExF4AocIk5akV38a+XO6M=
X-Received: by 2002:a25:ba41:: with SMTP id z1mr19560280ybj.169.1630981247372; 
 Mon, 06 Sep 2021 19:20:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq8McoMI06O5U93UzJnvgnZk6RA60sDf1gtAhUWswBId8FMkF1jsAqAN9sh/NkI6jqANDzeLQNQl2SXj0Wn6s=
X-Received: by 2002:a25:ba41:: with SMTP id z1mr19560260ybj.169.1630981247123; 
 Mon, 06 Sep 2021 19:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
In-Reply-To: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Sep 2021 10:20:35 +0800
Message-ID: <CAEemH2cZNzOawYPHQGgeLGVxob37=0kbJyQz=NSvBM0uGpANSg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ftruncate04: require
 CONFIG_MANDATORY_FILE_LOCKING=y
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
Content-Type: multipart/mixed; boundary="===============1015615216=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907022035.piT7d42ozLmvfBuGBbcG0NKtQZuAU_oOh-Rw7vWvGiY@z>

--===============1015615216==
Content-Type: multipart/alternative; boundary="000000000000ded71c05cb5e690a"

--000000000000ded71c05cb5e690a
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 6, 2021 at 4:36 PM Jan Stancek <jstancek@redhat.com> wrote:

> commit f7e33bdbd6d1 ("fs: remove mandatory file locking support")
> removed mandatory file locking support, but mount option
> is still allowed and produces no error. There's a warning
> in dmesg but it's pr_warn_once() so we can't rely to always
> find it there.
>
> Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=y.
>

I'm wondering, if the SUT without CONFIG_MANDATORY_FILE_LOCKING
enabling, why the mount-check in setup() didn't report EPERM?

And, should we drop the mount-check for EPERM from setup after adding
this .needs_kconfigs?

-- 
Regards,
Li Wang

--000000000000ded71c05cb5e690a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 6, 2021 at 4:36 PM Jan Stancek &lt;<a h=
ref=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">commit f7e33bdbd6d1 (=
&quot;fs: remove mandatory file locking support&quot;)<br>
removed mandatory file locking support, but mount option<br>
is still allowed and produces no error. There&#39;s a warning<br>
in dmesg but it&#39;s pr_warn_once() so we can&#39;t rely to always<br>
find it there.<br>
<br>
Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=3Dy.<br></blockq=
uote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sm=
all">I&#39;m wondering, if the SUT without CONFIG_MANDATORY_FILE_LOCKING</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">enabling, why the=
 mount-check in setup() didn&#39;t report EPERM?</div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" st=
yle=3D"font-size:small">And, should we drop the mount-check for=C2=A0EPERM =
from setup after adding</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">this .needs_kconfigs?</div></div></div><div><br></div>-- <br><div =
dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></d=
iv><div>Li Wang<br></div></div></div></div>

--000000000000ded71c05cb5e690a--


--===============1015615216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1015615216==--

