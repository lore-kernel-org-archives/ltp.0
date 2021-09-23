Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4894C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 06:39:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3356105A
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 06:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC3356105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B9D93C82E3
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:39:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECC1D3C2178
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 08:39:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27510140124E
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 08:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632379178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbOmsk/ShOuQOUFVhfTz7z0m5NiVX/cGJekkBBoOS1c=;
 b=L4Brxp3ShVaPXqSxFDggjXU5AD1OLPf47W28hdvayxypJ/2DxX5hxtM6uHbeL4WbVf6hcx
 OCdKN9p4ncKjTEIkdkqQIT4Oo4yybxxS3XdAJ7CYZlRSVN7REa+frNzoEdamEom51FvdWl
 HVpNaDSE/meQE791bQtlfv25kstzIyI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-2Gisr5Z6PwWrLgzNxScZEw-1; Thu, 23 Sep 2021 02:39:36 -0400
X-MC-Unique: 2Gisr5Z6PwWrLgzNxScZEw-1
Received: by mail-qt1-f197.google.com with SMTP id
 100-20020aed30ed000000b002a6b3dc6465so9120531qtf.13
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 23:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LbOmsk/ShOuQOUFVhfTz7z0m5NiVX/cGJekkBBoOS1c=;
 b=66ueq++aKI/h+f8M5GJgw6kiLiidu7RUlssiJwkYK9SZKmpC/MEcNM3e5V02e5KTpt
 ZTiEgUs2aTCxzdYMuwLdMt1qMA5O4oW8hTMyofDT2oNh7+4EOb9+7pc2VyYdQ+Bjfkvf
 z8ZcmJbL0tn7+cxGq4rx6gviGsnBvDyGGl5+IveNv+L7NOHgB84HdrrKnR3KNLD6YEli
 kAeTAyQzzToE8rdfpSJgMI/qgn3gGARcQLnhwbSHVv2f/+lzo/X+Hc+a83gpaWgKe+RI
 mWRkfi0he0acZ+PJtCfjPeYvOg2kfB9jpuz/ZVNjI5iF1iSHNE/q1WH+CCUfuSW37NmR
 Ww1g==
X-Gm-Message-State: AOAM5335OFV8Sw+LHtWT0SKMGTSY0fYWZrCoh1zI4BHWfsgXL+tXic6g
 MKP4C0ZUGQbVG7uymCfsejyQtXvZ4aRkINZP3OF0dsiHcmRjFsj/eJMHiI/x+7Z/zR05IgLSFYr
 oawgevqqd83SZaljun36KHsfZFcs=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr3852628yba.316.1632379176537; 
 Wed, 22 Sep 2021 23:39:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFSfHRmETGcGUo2DRYTIfVNB+O+oVJVWhyt+wN6YftaRilrAu/RXEXGTVmt4E1m/0KjiKs6rGadb+dVpamTv4=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr3852613yba.316.1632379176327; 
 Wed, 22 Sep 2021 23:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
In-Reply-To: <YUrnljqYd5Hx/fi+@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Sep 2021 14:39:24 +0800
Message-ID: <CAEemH2e5P-VbEw1xM=tvR=F9Bd+45==hW4rcP2xAbVTuy8rmDg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============1187083891=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1187083891==
Content-Type: multipart/alternative; boundary="000000000000f1bdca05cca3e43c"

--000000000000f1bdca05cca3e43c
Content-Type: text/plain; charset="UTF-8"

> I do not think that it's a good idea to pass ~100MB buffer to a single
> write()
> and expect it to succeed anyways.
>

I suddenly realized that it is 1MB buffer but not 100MB, so that block
number
is not the key point for OOM.

1 Block == 4k on x86_64,
256 * 4k == 1024kB == 1MB

-- 
Regards,
Li Wang

--000000000000f1bdca05cca3e43c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">I do not<span class=3D"gmail_default" s=
tyle=3D"font-size:small"> </span>think that it&#39;s a good idea to pass ~1=
00MB buffer to a single write()<br>
and expect it to succeed anyways.<br></blockquote><div><br></div><div><div =
class=3D"gmail_default" style=3D"font-size:small">I suddenly realized that =
it is 1MB buffer but not 100MB, so that block number</div><div class=3D"gma=
il_default" style=3D"font-size:small">is not the key point for OOM.</div></=
div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">1 Block=C2=A0=3D=3D 4k on =
x86_64,=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small">2=
56 * 4k =3D=3D 1024kB =3D=3D 1MB</div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--000000000000f1bdca05cca3e43c--


--===============1187083891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1187083891==--

