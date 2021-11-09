Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D61C433FE
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:42:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4817361184
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4817361184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F18C3C0844
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 12:42:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B66CB3C07B4
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 12:42:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7BFE2200E00
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 12:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636458128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s2cs89amrsM/0y8bdD1wrswpmGuyOOTKU4YbKzoLIug=;
 b=hYaNVV/UVPpRvoDlmUVxgRuh/amlYhKkMd8Y68BCfHmqDOnqrBF9h2u4YxZ57cM4dpJCv7
 KHKfWCUmw/FDx5LKZcgsaJxp95UDlFWABWxyZNTqyGBpchsjqso2V18sIvwuuunvZOFHHZ
 1f+ZwQ31gfl5+IAm/D4geyIr1Hn+Znw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-ShqQhwmQPPG7p96-Rld6ZQ-1; Tue, 09 Nov 2021 06:42:06 -0500
X-MC-Unique: ShqQhwmQPPG7p96-Rld6ZQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 m78-20020a252651000000b005c1f44d3c7bso29992384ybm.22
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 03:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s2cs89amrsM/0y8bdD1wrswpmGuyOOTKU4YbKzoLIug=;
 b=wqldXppkf9s/UsdKvophrPssAVRhTHGf6uOkouLGn+7R+e5O6eZiU45bou6wFr2PrP
 C66Vlc7KlL2q2TJU1svUc3pCAvEO9mzytPjgb4/BED/XdEhwvjbeJ+W0GZBW2vlzlqJe
 rwtoGRSX/ArsMUlW+gcJsUaEJrkMOnMyICAArogS5PaFWupCOQ58M0LjNKfJq+xe6grK
 dIWyXVvVbuNQFD29qHy0SwjncmuRSbGt++aESxgPIg1IfQ/fG0Y7gzzNSv0WVUVoE9p/
 T8agRhDfEsxQJ5B//SXrcOXD1l+8eLxFy7SdULoWXYxbqTPhk1vOXyEcxiUcHV92ssIO
 tjww==
X-Gm-Message-State: AOAM530p4k+kVcTc2RE4P6qoQ43WYKXoumNmNgviKR+W0A98Uv3QLXNo
 vqSMJRqwoR22tLxmwTL2NXwkjev4pRAgBsNb6vPyT+JjN+pr9BvRDLBZtZFlfWV9f4n1y2qpnlh
 0khVzp2M5oqQDbMK819C3uNQ1rFE=
X-Received: by 2002:a25:e704:: with SMTP id e4mr7520009ybh.490.1636458126021; 
 Tue, 09 Nov 2021 03:42:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQS5MKp47eAeeBjemreEf32f1/J0akq9WwPCM2r47Fa4IPnR/wJ5XIciLlspc9YuRcTXXsKcckG4f8ASfimNs=
X-Received: by 2002:a25:e704:: with SMTP id e4mr7519987ybh.490.1636458125825; 
 Tue, 09 Nov 2021 03:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20211108021450.1460819-1-liwang@redhat.com>
 <20211108021450.1460819-3-liwang@redhat.com>
 <YYkbujntxMkANsG6@yuki>
 <CAEemH2cw=cSgoX=5-A_Q0_N4rhSBUYmqvWdtPEZoEngc1wZxsA@mail.gmail.com>
 <YYpR201x6Ew7D9Zf@yuki>
In-Reply-To: <YYpR201x6Ew7D9Zf@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Nov 2021 19:41:53 +0800
Message-ID: <CAEemH2c-Vaa=y3y1db9AN9EJZcRPA-xoRN_qU4t1TJRRGEdJPg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] max_map_count: replace ifdefs by tst_arch
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
Content-Type: multipart/mixed; boundary="===============1825328780=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1825328780==
Content-Type: multipart/alternative; boundary="00000000000047b53105d05999a9"

--00000000000047b53105d05999a9
Content-Type: text/plain; charset="UTF-8"

> > >                 I wonder if this would be better as:
> > >
> > >                 if (tst_kernel_bits() == 64)
> > >                         return false;
> > >
> >
> > Actually, we have TST_AARCH64 already, I'd go with switch to that.
>
> That wouldn't work right? Since we are checking here if 32bit ARM binary
> runs on 64bit AARCH64 kernel. The tst_arch defines for which
> architecture the binary was build while the tst_kernel_bits() checks if
> the kernel is 32bit or 64bit.
>

Right, I didn't realize that situation. Thanks for the reminder~


-- 
Regards,
Li Wang

--00000000000047b53105d05999a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I wo=
nder if this would be better as:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
tst_kernel_bits() =3D=3D 64)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; &gt;<br>
&gt; <br>
&gt; Actually, we have TST_AARCH64 already, I&#39;d go with switch to that.=
<br>
<br>
That wouldn&#39;t work right? Since we are checking here if 32bit ARM binar=
y<br>
runs on 64bit AARCH64 kernel. The tst_arch defines for which<br>
architecture the binary was build while the tst_kernel_bits() checks if<br>
the kernel is 32bit or 64bit.<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Right, I didn&#39;t realize t=
hat situation. Thanks for the reminder~</div></div><div><br></div></div><di=
v><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000047b53105d05999a9--


--===============1825328780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1825328780==--

