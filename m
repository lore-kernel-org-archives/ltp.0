Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F6BC433FE
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 03:34:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50AFC3CAE52
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 05:34:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6D9B3CA48F
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 05:34:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 659A6100055B
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 05:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665286454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RVkHnxNxw5BbuFK3nghsZtLYme0igJod7O7mn0fZ2Mg=;
 b=KbEaeCQQDfQyUqb3y5/m6JcPj5VYlw/RUl8lHDHgUH/oxrWIgrhzkh2JlayAuDilxIvxhu
 kVq68HsVyrXTMy6v3lXOp7BJ+u6eCBR5TGlYT6JNHkfj9Z8Pdgb48yk6zyvo5+OHJ6bT4l
 eIlUejo0YvKmIgBlaCXRoPGl1p1ZnZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-KcAMvHZlO42bv9eYwi-IjA-1; Sat, 08 Oct 2022 23:34:12 -0400
X-MC-Unique: KcAMvHZlO42bv9eYwi-IjA-1
Received: by mail-wm1-f71.google.com with SMTP id
 v125-20020a1cac83000000b003bd44dc5242so6824520wme.7
 for <ltp@lists.linux.it>; Sat, 08 Oct 2022 20:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RVkHnxNxw5BbuFK3nghsZtLYme0igJod7O7mn0fZ2Mg=;
 b=lejuek4dOJJMF+PNJfSLPzm7H22rw5P/e9mywXJDQp5cLtxhAhLoCye+FCyW6M41Yl
 JqL6ULTuZJQ9pT4GzltfdCNiXedZHtAx4J8qrAHen20me+kbjLmxFXWiCQMa6oW85lrv
 lepx6+sINj0ON8Jg0+PfLMNbLpMnDq5dqNrJeEiObmVySwCT4tNoPy/mJSL8z0/1mymD
 YbFrdUW2GYgOYFvAqlZaObji8n8xjss7W6NFUGPofJecGgaBuhOPcsl8Te9jxBYawKSw
 4yfotxEwzl4dwTRr/Yymva+ApVYAW62WSsThjmXPkb9x6wcSorXVX6YGk9+SAxthQc4G
 3JlA==
X-Gm-Message-State: ACrzQf01ucMaSrfXdz4LDXry/lbm+7PieJGzbIGfY3EKVzBTCDeOEQWG
 aQ3EIzTyriOl8bmkukKXr9gzvRrGczeQrG/q/iGMwzDSztyt7X3tu0FsFDPxVcd9Sc15y8bVWsa
 VO11pc6qpWnmKt5gVc6p+Lo1WRUM=
X-Received: by 2002:a5d:6483:0:b0:22e:4804:8be4 with SMTP id
 o3-20020a5d6483000000b0022e48048be4mr7309048wri.528.1665286451116; 
 Sat, 08 Oct 2022 20:34:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+MB6U7ixICF5vBVGWwBux9HC43MrG06Qgm+nRFXNO2lycb0kCRBcrNUMKe4MvLPWcdCcULBbe+H9F5TOBDvY=
X-Received: by 2002:a5d:6483:0:b0:22e:4804:8be4 with SMTP id
 o3-20020a5d6483000000b0022e48048be4mr7309044wri.528.1665286450941; Sat, 08
 Oct 2022 20:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <YyI/KU10+zSi7Fpj@pevik>
 <20220915074900.2639623-1-liwang@redhat.com>
 <12066736.O9o76ZdvQC@localhost>
 <CAEemH2dbmnka=4wiib-ZiiHn+1qVNUsm4jY9f2iP5Tqan3zSOQ@mail.gmail.com>
In-Reply-To: <CAEemH2dbmnka=4wiib-ZiiHn+1qVNUsm4jY9f2iP5Tqan3zSOQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 9 Oct 2022 11:33:59 +0800
Message-ID: <CAEemH2cUDVZKR1EefJ=CKdsKk48qKWahLXPREvo23-KX_d34kw@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getitimer03.c: convert to new LTP API
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
Content-Type: multipart/mixed; boundary="===============0477815702=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0477815702==
Content-Type: multipart/alternative; boundary="0000000000005bac1705ea91b7f6"

--0000000000005bac1705ea91b7f6
Content-Type: text/plain; charset="UTF-8"

Hi all,

Pushed V2 with minor fixes.

On Fri, Sep 16, 2022 at 10:12 AM Li Wang <liwang@redhat.com> wrote:

> Hi Avinesh, Petr,
>
> On Thu, Sep 15, 2022 at 6:00 PM Avinesh Kumar <akumar@suse.de> wrote:
>
>> Hi Li,
>>
>> Sorry, I missed acting on the review comments you had provided. Thank you
>> for
>> implementing them. Your patch looks good, I have tested as well.
>>
>
> Thanks, btw we also need to take care of the .gitignore and syscalls run
> test file.
> Someone can help add this when merging the patch.
>
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -466,7 +466,6 @@ gethostname01 gethostname01
>
>  getitimer01 getitimer01
>  getitimer02 getitimer02
> -getitimer03 getitimer03
>
>  getpagesize01 getpagesize01
>
> diff --git a/testcases/kernel/syscalls/getitimer/.gitignore
> b/testcases/kernel/syscalls/getitimer/.gitignore
> index 6533d4b50..0a46a1021 100644
> --- a/testcases/kernel/syscalls/getitimer/.gitignore
> +++ b/testcases/kernel/syscalls/getitimer/.gitignore
> @@ -1,3 +1,2 @@
>  /getitimer01
>  /getitimer02
> -/getitimer03
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang

--0000000000005bac1705ea91b7f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hi =
all,</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div>=
<div class=3D"gmail_default" style=3D"font-size:small">Pushed V2 with minor=
=C2=A0fixes.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Fri, Sep 16, 2022 at 10:12 AM Li Wang &lt;<a href=3D"m=
ailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"=
><div class=3D"gmail_default" style=3D"font-size:small">Hi=C2=A0Avinesh, Pe=
tr,</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Thu, Sep 15, 2022 at 6:00 PM Avinesh Kumar &lt;<a href=3D"mailt=
o:akumar@suse.de" target=3D"_blank">akumar@suse.de</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
Sorry, I missed acting on the review comments you had provided. Thank you f=
or<br>
implementing them. Your patch looks good, I have tested as well.<br></block=
quote><div><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>Thanks, btw we also need to take care of the .gitignore and syscalls run t=
est file.</div><div class=3D"gmail_default" style=3D"font-size:small">Someo=
ne can help add this when merging the=C2=A0patch.</div><div class=3D"gmail_=
default" style=3D"font-size:small"><br></div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">--- a/runtest/syscalls<br>+++ b/runtest/syscalls<b=
r>@@ -466,7 +466,6 @@ gethostname01 gethostname01<br>=C2=A0<br>=C2=A0getiti=
mer01 getitimer01<br>=C2=A0getitimer02 getitimer02<br>-getitimer03 getitime=
r03<br>=C2=A0<br>=C2=A0getpagesize01 getpagesize01<br>=C2=A0<br>diff --git =
a/testcases/kernel/syscalls/getitimer/.gitignore b/testcases/kernel/syscall=
s/getitimer/.gitignore<br>index 6533d4b50..0a46a1021 100644<br>--- a/testca=
ses/kernel/syscalls/getitimer/.gitignore<br>+++ b/testcases/kernel/syscalls=
/getitimer/.gitignore<br>@@ -1,3 +1,2 @@<br>=C2=A0/getitimer01<br>=C2=A0/ge=
titimer02<br>-/getitimer03<br></div></div><div><br></div>-- <br><div dir=3D=
"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div><=
/div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div>

--0000000000005bac1705ea91b7f6--


--===============0477815702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0477815702==--

