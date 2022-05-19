Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68044C433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 10:30:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD9CF3CAAE1
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 12:30:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D7E13C0CD0
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:29:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2A64B60071F
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652956191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0ld7syqJrkwQRE32SqxlierByucMP9gs8/jj/VaeD4=;
 b=Ld2YamDkZ7pWVRGZWxT1DjLPaNHsZK2LX2pvSkaisCAcMtIQAz0ziEEvftOmslJ9Pupimk
 KJnYCjxa6F1iEX7Y5LaPiwU1sFNrgAcPmPQWzZISVudCcFYCrFlAbYkiA6WDA3BNiu0r4o
 VLf+INaWPXmOpp/lfWfzLiyNuSJm0l0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-pqoAJEGROleS9YPzVju2FA-1; Thu, 19 May 2022 06:29:50 -0400
X-MC-Unique: pqoAJEGROleS9YPzVju2FA-1
Received: by mail-yb1-f199.google.com with SMTP id
 g7-20020a5b0707000000b0064f39e75da4so891586ybq.17
 for <ltp@lists.linux.it>; Thu, 19 May 2022 03:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d0ld7syqJrkwQRE32SqxlierByucMP9gs8/jj/VaeD4=;
 b=KSRrIqZBY/L9sH/y7qjklAr5kmXnSlI31XgncTpRVxGII/pEboPw/decV28WdDhZzg
 xIw5A5LuvWTI9NuWAf0Y3TaL9CsXiFVt5zPcemNDBv/qVx9WpkQ7YOJ7aGeRaoL1NWQb
 91hJNN3xfPD7zRu6StfN965qnpPpAkJKxfsh2BT5oxD0A8S32y0mz9QzL8N+I9owJaiE
 chedIsd46JI3VfIqsrn881Hq7t8iWOjw/D3m7bMno//fEdWSu/fCM7wxcq+O7+wWhVmC
 ldp3k+xeTff6ysLmcpO09holR0pj3qQEKAvuoCJSM4kt7r9j3Ib3ssUvPvvkENhzCas8
 UZ9A==
X-Gm-Message-State: AOAM533VBVirLgNjAqzoGBeJ9fAy+x3hjr7ggVUyy6jKwvVxQ9+kzzRP
 BgcT/1/eFSzv/NJ7yakBFSmyEvZOR3jdWcHM/vKzYGdUqNtPFVcdnJ1FJKENPHEXVrcaqigjW+f
 Q3TP2zajmj3Jy8DvJ00z2/wRlzSk=
X-Received: by 2002:a25:4148:0:b0:64d:7347:7269 with SMTP id
 o69-20020a254148000000b0064d73477269mr3842116yba.161.1652956189966; 
 Thu, 19 May 2022 03:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEJsvL73xw3ui/StE4PXrk7TqNPgHs9Wmi+qEaEwWddk1tekgTD5RAeVquTwRG9eXW23NFHEHHbZOMUvSskgM=
X-Received: by 2002:a25:4148:0:b0:64d:7347:7269 with SMTP id
 o69-20020a254148000000b0064d73477269mr3842099yba.161.1652956189773; Thu, 19
 May 2022 03:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki> <875ym5di8f.fsf@suse.de> <YoN/W4wbow2fyOut@yuki>
 <CAEemH2cazgjqj4C1nuqPcRCC0dZoxwi-yiJymRgJxr0woXXFWw@mail.gmail.com>
 <CAEemH2dYwMczBhFj28yc9xDu0VBg50orjeQBK2s13-8BspK=WQ@mail.gmail.com>
 <YoYIVaJJDzryYNeg@yuki>
 <CAEemH2c50gr-G91_4nbdaDkCeGivCg3OQcYN4O0HTzyP2nf_jw@mail.gmail.com>
 <YoYbm487vwfD8Wne@yuki>
In-Reply-To: <YoYbm487vwfD8Wne@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 May 2022 18:29:38 +0800
Message-ID: <CAEemH2cRhznzW+mVZwSeWk_p9REvwd76t0H2mwJBQS_M7jn4CA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============0119207859=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0119207859==
Content-Type: multipart/alternative; boundary="000000000000856d9f05df5adad3"

--000000000000856d9f05df5adad3
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> Should I send a V4 with this patch included?
>

No need. You can push with this new patch adding,
then I will kick start release testing for the whole LTP
from our side.


-- 
Regards,
Li Wang

--000000000000856d9f05df5adad3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@s=
use.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Should I send a V4 with this patch included?<br></blockquote><div><br></div=
><div class=3D"gmail_default" style=3D"font-size:small">No need. You can pu=
sh with this new patch adding,</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">then I will kick start release testing for the whole LTP</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">from our side.</d=
iv></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></=
div></div></div></div>

--000000000000856d9f05df5adad3--


--===============0119207859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0119207859==--

