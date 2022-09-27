Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F48C07E9D
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 08:25:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2A93C180D
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 10:25:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98DEF3C180D
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 10:25:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6E271200BD2
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 10:25:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664267140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YaGAmqO5+koQ6/xAPrwWizftorNKMy7sptZP3k2h52Q=;
 b=Ns8CGeusRX8JgarwMvUASBSDyDkgVw8Dounvq9EwEnHiyD1ZMT049iUeoUGX/nknX75j9V
 w5T2ibRAQQrwWyL/zY9Oe2HQeCJUYF2Ium3L6X4ZH+1UqL8X++TenQNht0mCAkdqSrXQVw
 BxpgoLi14knEm/c3CNXg2wQlps79rgM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-362-Xwc1O2dEP5uUoUQ2xqwYPA-1; Tue, 27 Sep 2022 04:25:39 -0400
X-MC-Unique: Xwc1O2dEP5uUoUQ2xqwYPA-1
Received: by mail-wm1-f69.google.com with SMTP id
 fc12-20020a05600c524c00b003b5054c70d3so5211990wmb.5
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 01:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=YaGAmqO5+koQ6/xAPrwWizftorNKMy7sptZP3k2h52Q=;
 b=VhhFLeGDDXGQvR76nBaQNHLowD8tYH3w6FMFZz887ol5TOchdNyiSsh7rH5nwrKpYr
 LG15MAxa9c9CwjXaHTMrAYhzUzJu8/uWCUpG8LgG12E6ynWa8uYuFwGvrB+DzglK588g
 Ee6mwuYubvyZsqW8wQsCbOAB50abSZRfOnPcwxiI3tnlY9jO2tjHYNPpX1A5uyeAAMcA
 /zCv6r43m6n1YRd1RceiIG7PXH52N3PtAsRHPpiZ8nGt7j+UJvSXAYj2VojvXKkmP94k
 DTKLCQrAQFJpQQNgnWknod2J0c5czwY/Bu9NvP5RB2VP4ZLKh8I0RqTcGBltc0qBROtr
 YlNg==
X-Gm-Message-State: ACrzQf2TTXFxDAbpeJDfPlFBgryD2YkD530GNgK6oCfQAeV/jLH+VKKG
 01jfu+hxYMTxswn9FAENeEA4QrDaMBlH31aawKGkIIGsF8wGH4Ql3uXWXURnrrIIomhmkGPBb5s
 p/yp22k1C3/Qs1IJgBp46j30Ca8E=
X-Received: by 2002:a5d:6147:0:b0:22a:6035:a878 with SMTP id
 y7-20020a5d6147000000b0022a6035a878mr15417197wrt.528.1664267138258; 
 Tue, 27 Sep 2022 01:25:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kn+R0ofFH72pzb3zaGKlN9rQvwo5hmOx7STRAAl0L1e8MoutSsKUQbya7HOQKe+SDWcbs1U6hFIrb3jS7QkM=
X-Received: by 2002:a5d:6147:0:b0:22a:6035:a878 with SMTP id
 y7-20020a5d6147000000b0022a6035a878mr15417183wrt.528.1664267138010; Tue, 27
 Sep 2022 01:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki> <YxtPfXA6I64lS2oK@pevik>
 <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
 <YzF3wLk9cMTdU1z7@yuki>
 <CAEemH2feEgX1oiTPD=_ub0Dc-5RTyKqVhSX0QrMAJPTo-0Gdhg@mail.gmail.com>
 <CAEemH2e6Dzm1ydZt1VZvoxZN4xXyrSZua5jmfxeci8SyXNc2tw@mail.gmail.com>
 <YzKv/ClILufSy3up@pevik>
In-Reply-To: <YzKv/ClILufSy3up@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Sep 2022 16:25:25 +0800
Message-ID: <CAEemH2eb3EvUL7c3M1=FgPoYmYTcYDgQAM7NUxY7pSAN0xUjuw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1587551218=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1587551218==
Content-Type: multipart/alternative; boundary="00000000000092a82a05e9a463d4"

--00000000000092a82a05e9a463d4
Content-Type: text/plain; charset="UTF-8"

Petr Vorel <pvorel@suse.cz> wrote:

>    185 df01 42 TFAIL: 'df -T -P' failed, not expected.
>
> This is known:
> https://lore.kernel.org/linux-xfs/YvZTpQFinpkB06p9@pevik/
>
> I've mention that yesterday, that I'll fix it after the release
> https://lore.kernel.org/ltp/YzGDdC76DLmrJyys@pevik/
> I'll try to send a patch soon and we can decide whether we merge it before
> release or not.
>

Ah, yes, I shouldn't skip reading emails so careless :).
Thanks for the upcoming fix, let's see what it looks like and then decide
to merge or not.

And zram01.sh fails due XFS minimal size. I also try to send a patch soon.
>

Thanks! Next, I will only investigate the io_uring failures.


-- 
Regards,
Li Wang

--00000000000092a82a05e9a463d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.=
cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr"><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
&gt;=C2=A0 =C2=A0 185 df01 42 TFAIL: &#39;df -T -P&#39; failed, not expecte=
d.<br><br>
This is known:<br>
<a href=3D"https://lore.kernel.org/linux-xfs/YvZTpQFinpkB06p9@pevik/" rel=
=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/linux-xfs/YvZTpQF=
inpkB06p9@pevik/</a><br>
<br>
I&#39;ve mention that yesterday, that I&#39;ll fix it after the release<br>
<a href=3D"https://lore.kernel.org/ltp/YzGDdC76DLmrJyys@pevik/" rel=3D"nore=
ferrer" target=3D"_blank">https://lore.kernel.org/ltp/YzGDdC76DLmrJyys@pevi=
k/</a><br>
I&#39;ll try to send a patch soon and we can decide whether we merge it bef=
ore<br>
release or not.<br></blockquote><div><br></div><div class=3D"gmail_default"=
 style=3D"font-size:small">Ah, yes, I shouldn&#39;t skip reading emails so =
careless=C2=A0:).=C2=A0</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">Thanks for the upcoming fix, let&#39;s see what it=C2=A0looks like=
 and then decide to merge or not.</div><div class=3D"gmail_default" style=
=3D"font-size:small"></div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
And zram01.sh fails due XFS minimal size. I also try to send a patch soon.<=
br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Thanks! Next, I will only investigate the io_uring failures=
.</div><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmai=
l_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div>=
</div></div></div>

--00000000000092a82a05e9a463d4--


--===============1587551218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1587551218==--

