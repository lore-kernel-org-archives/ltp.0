Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B61ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 06:47:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA76C3CA93A
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 08:47:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D33443C9733
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 08:47:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 73BC71400535
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 08:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662360444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0qA2nspYsN04V2Tnv2DUivXO2l8lrVa+PZZYo8+GiM=;
 b=Sb/HvCMJ8pmX1KxU7f4H6/ZebOQDqI0SFdbAQ0CX59enj58Buq5Mxix8zn2SxOM2b/ytoV
 lV4ZsyFflNIJVbqQhX1bwbdu9x1VlpucGOx0eUAVq8uQzBsBTFNleud37fHkxDlesSNRIu
 jQU9fG/FG2kRWE5CJPmVF9bcvtcBfto=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-5SsTfeDaNIOLscu5NSSbbA-1; Mon, 05 Sep 2022 02:47:23 -0400
X-MC-Unique: 5SsTfeDaNIOLscu5NSSbbA-1
Received: by mail-ua1-f71.google.com with SMTP id
 d15-20020ab0318f000000b0039f8df41964so1527597uan.11
 for <ltp@lists.linux.it>; Sun, 04 Sep 2022 23:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=d0qA2nspYsN04V2Tnv2DUivXO2l8lrVa+PZZYo8+GiM=;
 b=qqKNFnoCuF9O2CcHD5QoDARQdPTWe1HYDo/CIUg51OuCYZdGVBlWQbApY9BFiKFYgz
 5/oUTNCcmqvRyvOZAUdflMa3tjyce6K0KJ7+651YmtXqEC09PQ8pDvyIsVIZUYlA2s/y
 yfWru8PLcoi10JGtZh3yXkJxhdDPF2YO/whJJkF+dWhv1sQmvZVkFK1jHEXaujCKD5Di
 lqPvrWA7KEsA34s8+Rijyqw1uVYX5h+BBCB96ftM0SKyW2vcTMAQ5L6T+d/kJCYgsH21
 kskYT6o6srsi/M0Ylki/feqXyv81FHV8YF7d5RsiPnpPfmgZo2BXu4PsNUhGjcZNesyJ
 UW4A==
X-Gm-Message-State: ACgBeo0awugMl3yiRfsflrAhZlQav9VAy0tN26JHXyPaeIlmbZj8CfN/
 LluOXVXZc+WaDNLwTVwziX4Y79n3YQF+oM1awF7jRZMHzwcjdJrWmwpXf6lcjeplmP7geyR7Fph
 5zXyCMvi8Z4TUPcg92OdEWkA56Cw=
X-Received: by 2002:a67:c089:0:b0:392:a432:b292 with SMTP id
 x9-20020a67c089000000b00392a432b292mr7508987vsi.69.1662360442678; 
 Sun, 04 Sep 2022 23:47:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4b2DIJM+6l5RK1Bpxgmfz/H5eNCSzFX51C+IO86n8mv1Gl0ZGeltXIIlAS4iV4pLDqZpV71U50WBVJoemprRU=
X-Received: by 2002:a67:c089:0:b0:392:a432:b292 with SMTP id
 x9-20020a67c089000000b00392a432b292mr7508975vsi.69.1662360442434; Sun, 04 Sep
 2022 23:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220902133710.1785-1-pvorel@suse.cz>
In-Reply-To: <20220902133710.1785-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Sep 2022 14:47:11 +0800
Message-ID: <CAEemH2fetx7L+B+=YTsNH=8QR+292s9w+LuRnJBM4nu8UkrR9w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] shell: df01.sh: $TST_ALL_FILESYSTEMS
 (.all_filesystems)
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: multipart/mixed; boundary="===============0910470711=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0910470711==
Content-Type: multipart/alternative; boundary="000000000000a916e405e7e8730c"

--000000000000a916e405e7e8730c
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

The whole patch set looks nice!

Btw, it might be great to wait for the series patch set of
"Track minimal size per filesystem" and merge together
in case this can't complete test on XFS.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000a916e405e7e8730c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Petr,</div><div class=3D"gmail_default" style=3D"font=
-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l">The whole patch set looks nice!=C2=A0</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Btw, it might be great to wait for=C2=A0the series patch se=
t of</div><div class=3D"gmail_default" style=3D"font-size:small">&quot;Trac=
k minimal size per filesystem&quot; and merge together</div><div class=3D"g=
mail_default" style=3D"font-size:small">in case this can&#39;t complete tes=
t=C2=A0on XFS.</div><div class=3D"gmail_default" style=3D"font-size:small">=
<br></div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-b=
y: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwan=
g@redhat.com</a>&gt;<br></div></div><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr"><br></div></div><div><br></div>-- <br><div dir=3D=
"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div><=
/div>
</div>

--000000000000a916e405e7e8730c--


--===============0910470711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0910470711==--

