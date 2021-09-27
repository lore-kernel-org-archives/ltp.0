Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC7C433F5
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 02:39:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D387F60F41
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 02:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D387F60F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2447A3C913E
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 04:39:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B77D53C8F42
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 04:39:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E161B1000774
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 04:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632710378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RAvATHGF6g8Hj4URUhLVTSauBvF21cYotj2KTQmPigc=;
 b=Pynct2h4gTpOnrPM7wJTqtzooe4Jrglg428DgkQtGKtFCxoiTrK2yXkT1bfahpsEigfD/5
 Nir0K8UWLXxljb+SOrZfYWpBMJOe8A4zOYjgRk8CDQTnvQBnZmdJ3MDPXQ4wYx6J9wjeqr
 fp1gwYMr1vosWZCIR/9Bx2wMqBdYMFQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-ET5Tw2TANDibBChvWrc7mw-1; Sun, 26 Sep 2021 22:39:36 -0400
X-MC-Unique: ET5Tw2TANDibBChvWrc7mw-1
Received: by mail-yb1-f199.google.com with SMTP id
 a23-20020a25ae17000000b005ad73346312so13374137ybj.18
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 19:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RAvATHGF6g8Hj4URUhLVTSauBvF21cYotj2KTQmPigc=;
 b=j6ykk8KrbPrLC55NIUGR39b0SUrnOvZSHZTKDzzWkJHrgAbNKcATQFDevE4FFcifLH
 zIpiRAy/+AwKym8QqX8bWC+fNSoVqZ3km7QA/7BEMG706xyxydTldM6qTrhweGRFjtpR
 e5cKPrH7+6aTZEa0dcDOBh4E9b/n5hY6bi/zdb3aApNlLGDssGEStz1JIkooIIFeB3Rd
 zg4RC5VBQnENPTqzPLYuLcqCEDRYqitE7L5dcfTecRHxFtTvENzKqdBP1nz4ZuUBij5x
 hZ5+g/TBPqW2QrWE+g1d6oMk+pI/TzgdiDG2Kkw6CHQJuqKRGimvT+J9HDVmOcFP6X+Q
 /P/A==
X-Gm-Message-State: AOAM532FTcuEexmlqEBjX41R64cRgswBrPn5amZG0GWjwae1NMg+ER/Z
 h+sg0+c33inDaoGlA+374SI9LipGc7rOvU3PnamjJgUMKNYMSIAcvU3X2P9RDw/KY/la9TetTF7
 mpDBmLgbRbmj7D2Qzn0PFgZEtQsk=
X-Received: by 2002:a25:7e46:: with SMTP id z67mr25468624ybc.166.1632710375815; 
 Sun, 26 Sep 2021 19:39:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkiBqVHckWvZLIY+rMLlrKrFMBuvmHzyQwSz87SsuD3LNVCEl5xKEZZKM19humtK3PPwwVYDdS9B2cz4ToYvo=
X-Received: by 2002:a25:7e46:: with SMTP id z67mr25468603ybc.166.1632710375496; 
 Sun, 26 Sep 2021 19:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210924070756.3916953-3-liwang@redhat.com>
 <20210924105234.3927811-1-liwang@redhat.com>
 <YU3fTlVIIUU7Ff3d@pevik>
In-Reply-To: <YU3fTlVIIUU7Ff3d@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 27 Sep 2021 10:39:23 +0800
Message-ID: <CAEemH2crBA=-piu3Z+CM7+Z3neWWxkuMY6+y9i6vdHSvZukKgw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1214472199=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1214472199==
Content-Type: multipart/alternative; boundary="000000000000f3f85a05ccf10151"

--000000000000f3f85a05ccf10151
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 24, 2021 at 10:23 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> nit: I'd add Fixes: c305a53c5 ("lib: limit the size of tmpfs in LTP")
> if anybody searches on Fixes.
>

Thanks for the review, I added this and pushed it.

Btw, according to Ralph's test (153MB MemAva) result:

* test trigger OOM with mount 32MB tmpfs size
* test PASS with unlimited mount tmpfs size
   (actually, it consume 134MB, from the log)

This is more like a kernel-specific problem but not LTP general issue.

-- 
Regards,
Li Wang

--000000000000f3f85a05ccf10151
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 24, 2021 at 10:23 PM Petr Vorel &lt;<a =
href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt;<br>
<br>
nit: I&#39;d add Fixes: c305a53c5 (&quot;lib: limit the size of tmpfs in LT=
P&quot;)<br>
if anybody searches on Fixes.<br></blockquote><div><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">Thanks for the review, I added thi=
s and pushed it.</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Btw, acc=
ording to Ralph&#39;s test (153MB MemAva) result:</div><div class=3D"gmail_=
default" style=3D"font-size:small"><br></div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">* test trigger OOM with mount 32MB tmpfs size</div=
><div class=3D"gmail_default" style=3D"font-size:small">* test PASS with un=
limited mount tmpfs size=C2=A0</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">=C2=A0 =C2=A0(actually, it consume 134MB, from the log)</di=
v><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">This is more like a kernel-s=
pecific problem=C2=A0but not LTP=C2=A0general issue.</div></div><div><br></=
div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li=
 Wang<br></div></div></div></div>

--000000000000f3f85a05ccf10151--


--===============1214472199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1214472199==--

