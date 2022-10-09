Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47FFC433FE
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 03:24:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D77893CAE2A
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 05:24:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296DB3CA48F
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 05:24:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5995F6006ED
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 05:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665285844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWQQ5zURRYlpbT9jVVftrScLTAx9wkaMjGSi6UkvzqY=;
 b=iVCQ7s2hoos667gYnB1FrpdEuLw/4JNkN5pjnOO8mjm2RDFF2tHeo91IYAtl0UYTPqo1OE
 iH4FbgjfSL2cwtW/7lQENvK3V53rMKH+5ClP8QRjLK4dQmqkyWcp7hlN7EdV5SWYNrBZz+
 rzLGII/9TKTHD2MuXgZfJi6YD4hrV/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-C7E4bsKJM86GM2X01yd6qg-1; Sat, 08 Oct 2022 23:24:03 -0400
X-MC-Unique: C7E4bsKJM86GM2X01yd6qg-1
Received: by mail-wm1-f72.google.com with SMTP id
 az35-20020a05600c602300b003c5273b79fdso1197680wmb.3
 for <ltp@lists.linux.it>; Sat, 08 Oct 2022 20:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NWQQ5zURRYlpbT9jVVftrScLTAx9wkaMjGSi6UkvzqY=;
 b=iX8r5E0WnDgEGUVwb4nwNsQUkyGGq2GG6PNdqMSDuPyAnVoFhHpQCKKEyJYoJXl6qW
 1USrPel2mbYXUHY5s2f4kHvwtDx7bZwp3GtCood+pBrCzjtTyN21IGiNxHj3773HhU/h
 w/zToOp4Bgya9gZ6+sz/czFYE9JReFXsGVN3FwjM0zGB1dgUq1z6M4WRAN+fADJn+TCl
 kielHUDcybYXQIfSb46v9ZmvZC4DZY5jTN7fCV6J+5DXlLSW4aZi7Fg5hmE3vyt8u9Gq
 jDCaEVAyNj8N5XzjDK/pFhsvxqpUOtNQ+5XuKv5/bCVOrZiKxaNyx+w7PAK4j35Ens7E
 aI+g==
X-Gm-Message-State: ACrzQf2xaiw/cHJXF29nQbKwTXu91XpCchLMNlR9WTivH/SFkaExKJ0j
 q5jDclMiE27SWZsOdLL3+dfeJbNMDJSq72h8F3mTGoYZ10jX7tjmJvC90HN3FYOqn6erLUEJKFt
 rjNoctvqOqxmhNxCES2wwKAwcbow=
X-Received: by 2002:a5d:6483:0:b0:22e:4804:8be4 with SMTP id
 o3-20020a5d6483000000b0022e48048be4mr7296509wri.528.1665285841756; 
 Sat, 08 Oct 2022 20:24:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5j/FP6T7pDIGjiYOJYtMOiC5XTWFHHYK7DPqVrqPY/tKxkGjepsAR+xDXMpOEPjWKnHnswL2XxATgkR+7Z9s8=
X-Received: by 2002:a5d:6483:0:b0:22e:4804:8be4 with SMTP id
 o3-20020a5d6483000000b0022e48048be4mr7296504wri.528.1665285841510; Sat, 08
 Oct 2022 20:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220930091208.5688-1-pvorel@suse.cz> <Yza1B8t2LOueCVUC@yuki>
 <Yza2jwpow0uhaLHu@pevik> <Yza4a2Icm+M9cTiK@yuki> <Yzbvg36XX5pVCFkB@pevik>
In-Reply-To: <Yzbvg36XX5pVCFkB@pevik>
From: Li Wang <liwang@redhat.com>
Date: Sun, 9 Oct 2022 11:23:50 +0800
Message-ID: <CAEemH2d7B5wXbvj71zN-=VHpRxjO-67_oH_5-87HZrTEfPwypg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] zram01.sh: Fix minimal size for XFS on
 kernel 5.19
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1372125912=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1372125912==
Content-Type: multipart/alternative; boundary="000000000000087cde05ea919397"

--000000000000087cde05ea919397
Content-Type: text/plain; charset="UTF-8"

Hi Petr, Cyril,

Thanks for moving on this, and good to see the new released.
I had to suspend work and deal with some family matters last week,
so sorry for the later reply.



On Fri, Sep 30, 2022 at 9:30 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> Tested on affected 5.19 kernel and various older SLES kernels.
> Therefore merged.
>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang

--000000000000087cde05ea919397
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Petr, Cyril,</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Thanks for moving on this,=C2=A0and good to see the new=C2=A0rel=
eased.</div><div class=3D"gmail_default" style=3D"font-size:small">I had to=
 suspend work and deal with some family matters last week,<br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">so sorry for the=C2=A0later=
 reply.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div></div><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 30, 2022=
 at 9:30 PM Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Hi all,<br>
<br>
Tested on affected 5.19 kernel and various older SLES kernels.<br>
Therefore merged.<br>
<br>
Kind regards,<br>
Petr<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000087cde05ea919397--


--===============1372125912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1372125912==--

