Return-Path: <SRS0=NQiP=OS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF4C433EF
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 07:53:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F062761159
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 07:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F062761159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD5733C8B9C
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 09:53:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A41A73C4F65
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 09:53:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E26251A01197
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 09:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632815609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=01dj86eTzM6LS1AQe4AwjgrhPvG/rHGW3G1HB8ioW8k=;
 b=dyK9hbUOI/0HA+mOM3xAZKlEwetMqDbiLOW7jFJrQGXHqf+M1WY3tI9PchRgR1qNpvvxwG
 6yK5VtAg5BK6GbZnSTvmjIjV1egdGHdhJmBhH489bH1KjOOdXHukgzFqk0OT6CndxwFucD
 I8UZukjwga91hwYQgZ1aYeesbY+aQec=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-QouWFvDlP0GZmjDFs-fJfA-1; Tue, 28 Sep 2021 03:53:22 -0400
X-MC-Unique: QouWFvDlP0GZmjDFs-fJfA-1
Received: by mail-yb1-f199.google.com with SMTP id
 x1-20020a056902102100b005b6233ad6b5so20606221ybt.6
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=01dj86eTzM6LS1AQe4AwjgrhPvG/rHGW3G1HB8ioW8k=;
 b=PkXK8bAM051VDjiUD4pZq+dKFOQZU+iSVgH8XmwB5cLQ7ZNNBFkdiqL5zMTZD31CKz
 0hOhyDuSRQm8qiviRk57lX4O3gSW1NDn4vZydUIVkLGqDO8FklfnfCxuOEagGjFv/vSe
 0yHtoWw4UPs8So+RucgEKoo3W54oBJ8DYKx0Ga5xggIl+mpYyAK4g1Ybhyaih+pFijWo
 h2tcOPMeHdfeK0czC1rpKT6JnexD1Uf8LDIFk58s3gboohzPVtkQS7u7NTJ4jNMlQgwI
 /hSBjkIrkrgiLbvdK4wX7iO+r+bxRmX/z8+M28rt3uIfmY9HTO8ThcVPJVoDvgDIN2/k
 HfQg==
X-Gm-Message-State: AOAM530I+JYHHP3T7ucxZ84jdO66aUZYfYDw6Fp5fvYyRWjHHTGn0Iue
 8+00KDw/a3iT/wHOiu5aVbD3t0SNHhS0dAyhAwl05o1Ax7gDcMPTgoiLOw+Hg+quv5UhDyhYBmu
 EOv8hWm99Xqz5MMFhgrysknEqxi4=
X-Received: by 2002:a25:4b02:: with SMTP id y2mr5057647yba.144.1632815602253; 
 Tue, 28 Sep 2021 00:53:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgOl9t5kA/qwFKSkVP/u6IpKhaGFhsZKSJtccrhzPQqVMiJvJfFCTQ9f/BABr6z4GnEGzalQiuZHtlHLCyRwU=
X-Received: by 2002:a25:4b02:: with SMTP id y2mr5057631yba.144.1632815602047; 
 Tue, 28 Sep 2021 00:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210924070756.3916953-3-liwang@redhat.com>
 <20210924105234.3927811-1-liwang@redhat.com>
 <YU3fTlVIIUU7Ff3d@pevik>
 <CAEemH2crBA=-piu3Z+CM7+Z3neWWxkuMY6+y9i6vdHSvZukKgw@mail.gmail.com>
 <20210927151220.GB4173236@maple.netwinder.org>
 <20210927190951.GC4173236@maple.netwinder.org>
 <CAEemH2cntaCBq+BJRZiWpBcrzOvzcBdhS-Hz4O1vZstjT6G=mw@mail.gmail.com>
 <20210928022244.GA2015014@maple.netwinder.org>
In-Reply-To: <20210928022244.GA2015014@maple.netwinder.org>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Sep 2021 15:53:10 +0800
Message-ID: <CAEemH2dX425dA2JtxAECnQiKy-RgwOoxWucqE5rJ75fQcAq0-Q@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: adjust the tmpfs size according to
 .dev_min_size and MemAvailable
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
Content-Type: multipart/mixed; boundary="===============1344690861=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1344690861==
Content-Type: multipart/alternative; boundary="000000000000f1b67605cd098176"

--000000000000f1b67605cd098176
Content-Type: text/plain; charset="UTF-8"

>
> >> Also, when I remove the .dev_min_size=512 from fallocate06, then it
> >> uses the default size of 32MB, and the fallocate06 test runs and
> >> passes.
>
> Should we also change fallocate96 test to not request 512MB?
>

I think yes, there is no place that shows it needs a specific size 512.

-- 
Regards,
Li Wang

--000000000000f1b67605cd098176
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0<br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; Also, when I remove the .dev_min_size=3D512 from fallocate06, then=
 it <br>
&gt;&gt; uses the default size of 32MB, and the fallocate06 test runs and <=
br>
&gt;&gt; passes.<br>
<br>
Should we also change fallocate96 test to not request 512MB?<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">I think yes, there is no=C2=A0place that shows it needs a specific size 5=
12.</div></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_=
signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></=
div></div></div>

--000000000000f1b67605cd098176--


--===============1344690861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1344690861==--

