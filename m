Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C82C0502A
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 01:46:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FB163CA557
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 03:46:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98EA33C65EB
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 03:46:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C3A3B100064B
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 03:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661737564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7Dfmw0HuOSpmrsOGxjdRdpf32zEeT01Qbi8zQ4bZuo=;
 b=Fn2cDfka+6/0xeuzAKFDWQpqBI4J6GuNhSoY7H6m16swlTOcclLfzkMHggdmHwh/UDeX9Y
 KB0vE/Ex/3oHrAqWR4tYT23LfpDfUgV3yroRCxxuPzcbVIYvM4DVCP5hu3af4HL+AQyV9U
 RIxVxg6R4mQAdQBh5F78C1Eu0ySE204=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-GSPxPkfYNcms4fR22uq7CQ-1; Sun, 28 Aug 2022 21:46:02 -0400
X-MC-Unique: GSPxPkfYNcms4fR22uq7CQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-33dd097f993so110295557b3.10
 for <ltp@lists.linux.it>; Sun, 28 Aug 2022 18:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=i7Dfmw0HuOSpmrsOGxjdRdpf32zEeT01Qbi8zQ4bZuo=;
 b=ok9Kfzit1yfwbqq0B32QSKglPCOAP7JNwUdN+KcIYLAR/RRch/GFNWmxgQF+tYPIg8
 zE2EnecXdLiUa53b6jivwfe2QLJyXF7QRqKRuDds016qGqJ/cgxitrFIRYHsje1xMB6C
 M7UAtkcmzQksQF5plzZTBvDD2Fz2fqjjUWXRKkfZEkO3/5PxqX/YUxb5T+IIau8UVp50
 8G7mMKJOwBs3CZmygHw347XcgdtR3j49sa48zvrcw/n0h3fB/6h2yfli69Au8v/jrexu
 KaCCKYj0xS5gOG7E2B0hsyc9/+wotv/hpH6Q1Qwvs22jGhF58Ks+Xw6c2Lc/bqKiXI6V
 iyTg==
X-Gm-Message-State: ACgBeo1Hk0U+kzXOuzMNzussjc2DFEALSd2LDBNUQCDVtpPwPZoEfAoY
 zFZO6UrISOhKM6iJOGl7XI4YhsuZihxpWJd5HsbLiMQXSN1dUvqDlrXcGsIXLstCykQ6lsOWdj+
 icmdIAec1aQ1w0krkr0yYXuPbtQ8=
X-Received: by 2002:a0d:f783:0:b0:340:cd25:fc5d with SMTP id
 h125-20020a0df783000000b00340cd25fc5dmr5514980ywf.82.1661737561685; 
 Sun, 28 Aug 2022 18:46:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4vjbvJsXWJwoCMSBKzrGVbBEVWAnIkG0F02Y5Mk45njSPf7R9hhegnl6tUlhszFbZ3GzbjpdNFoX2KRECUXeY=
X-Received: by 2002:a0d:f783:0:b0:340:cd25:fc5d with SMTP id
 h125-20020a0df783000000b00340cd25fc5dmr5514964ywf.82.1661737561473; Sun, 28
 Aug 2022 18:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220817204015.31420-1-pvorel@suse.cz> <YwX7r5VWrGRzaXoa@pevik>
In-Reply-To: <YwX7r5VWrGRzaXoa@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Aug 2022 09:45:50 +0800
Message-ID: <CAEemH2e_t5XdGNFPOw0suGgAEbWLYPuX-tnZCoxQ1oZJZ9H2pg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] API: Allow to use xfs filesystems < 300 MB
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============0390570194=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0390570194==
Content-Type: multipart/alternative; boundary="0000000000000fe16705e7576de7"

--0000000000000fe16705e7576de7
Content-Type: text/plain; charset="UTF-8"

Hi Petr, All,


Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> Could we in the end accept this patch?
>
> It'd fix the issue for now and I could set size of the XFS loop device
> smaller
> than 300 MB (better for embedded). i.e. 16 MB (or 32 or 64 MB or anything
> higher
> if XFS developers are convinced it's needed).
>

I personally think YES!
(sorry for replying so late, I was on vacation last week)



>
> As I wrote before I plan to suggest sizes:
> btrfs 110 MB
> the rest (ext[234], xfs, ntfs, vfat, exfat, tmpfs): 16 MB
>

+1 thanks for finding the minimal size.

-- 
Regards,
Li Wang

--0000000000000fe16705e7576de7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Petr, All,</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr"><br></div><div dir=3D"ltr" class=3D"g=
mail_attr">Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i all,<br>
<br>
Could we in the end accept this patch?<br>
<br>
It&#39;d fix the issue for now and I could set size of the XFS loop device =
smaller<br>
than 300 MB (better for embedded). i.e. 16 MB (or 32 or 64 MB or anything h=
igher<br>
if XFS developers are convinced it&#39;s needed).<br></blockquote><div><br>=
</div><div><div class=3D"gmail_default" style=3D"font-size:small">I persona=
lly think YES!</div><div class=3D"gmail_default" style=3D"font-size:small">=
(sorry for replying so late, I was on vacation last week)</div><br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
As I wrote before I plan to suggest sizes:<br>
btrfs 110 MB<br>
the rest (ext[234], xfs, ntfs, vfat, exfat, tmpfs): 16 MB<br></blockquote><=
div><br></div><div class=3D"gmail_default" style=3D"font-size:small">+1 tha=
nks for finding the minimal size.</div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--0000000000000fe16705e7576de7--


--===============0390570194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0390570194==--

