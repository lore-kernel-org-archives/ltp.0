Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FBEC433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 03:17:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D7B53CA32F
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 04:17:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E6353CA1EC
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 04:17:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC67E601B14
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 04:17:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646363851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TGrBHYC84O5rjAkO42ceUAFFidsMVjA8p7GYbEK8zS0=;
 b=C/T7x9iabyWoN5td9P0NyKbC6Oo9QSQcw88xZJrw+sffohpHitqwVcLqzFfFofdR9q/S4u
 57iqc8cA3ATVQ6D1Caev/5B81O4cngQ6I5rVQzUYZKnuwHt342Xa+deIzDaJ1+TD5dmX2X
 N2PfwI66FjnbQ+kKsISvvRcCFnV80oc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-Ilqo8YqTO4y886bQUkPl0w-1; Thu, 03 Mar 2022 22:17:29 -0500
X-MC-Unique: Ilqo8YqTO4y886bQUkPl0w-1
Received: by mail-yb1-f197.google.com with SMTP id
 a3-20020a5b0ac3000000b006288f395b25so6214854ybr.18
 for <ltp@lists.linux.it>; Thu, 03 Mar 2022 19:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TGrBHYC84O5rjAkO42ceUAFFidsMVjA8p7GYbEK8zS0=;
 b=jyIBfCjIYuQvqPa7rKJ62BeKdKeniCbGM5Bi/zoSK7S+ZdLHVaaChggZu7zqmQ4h9S
 LH64FZFWKKHjZSfzF8mdvTdCVBW5mQTGFVJQwfYK293RtYoWjFxwaXeV99ZmurYzPtAo
 uEGvaX3XJRz0aUCk4yhI9AgmUIw8ozxHakXdxZe+Rq9SDsvOh327ClFXArMWFiGIldqd
 Uqf2ARBwL+wPB0eYH0tOtHrVq4g+Lxs2S/FbxXjDX8QGuhM8ddjDO/JMrht01MsGztSn
 p51tSFjGO3OU5IJvEzCXUpItDS1miiSHEXCvxVHjhRPw2sT3RSKq1cEMYV3Izz7tsuL3
 AOrQ==
X-Gm-Message-State: AOAM533EXFgMwDyQ18h9nwsO7KDblvmDEjfOZXbMRgnUvzBFEjR4p+Kw
 47zwRLnEk3X/pdNSlvmNK5mUbtcxiCRJfqNaoDPOOOI4kI87kKebT1FlH0mMrV+Ez9HCOqB2HGq
 YNsXhyyO1FoS3lCl+91Ztz+YYoF0=
X-Received: by 2002:a81:3744:0:b0:2dc:370:8a0e with SMTP id
 e65-20020a813744000000b002dc03708a0emr12996590ywa.208.1646363848696; 
 Thu, 03 Mar 2022 19:17:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw56e/DOEh2ZoxzXUZHAKl3ZS3yVC1i8LM/PsVMzSjNslpZCLe/JpeUpGwdREVXQtPJc2cuUkB72wSKV3dKmRQ=
X-Received: by 2002:a81:3744:0:b0:2dc:370:8a0e with SMTP id
 e65-20020a813744000000b002dc03708a0emr12996581ywa.208.1646363848479; Thu, 03
 Mar 2022 19:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-8-chrubis@suse.cz>
In-Reply-To: <20220303145032.21493-8-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Mar 2022 11:17:15 +0800
Message-ID: <CAEemH2fFU_Cof_H5aT9wXnnuQga+fpUckggyefvpLo3hgzYfiw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/7] mem/ksm06: Make use of the new libltpnuma
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
Content-Type: multipart/mixed; boundary="===============1695365912=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1695365912==
Content-Type: multipart/alternative; boundary="0000000000005c2d4205d95bf4f8"

--0000000000005c2d4205d95bf4f8
Content-Type: text/plain; charset="UTF-8"

Hi Cyril,

Beside the tiny issues pointed out in [5|6]/7. The remaining
part looks good to me.

That would be awesome if you could help cleanup other ksm
tests at the same time. Or, I help do that separately later on.
(e.g. knob validation, add KSM kconfig, and remove 'merge_across_nodes'
from ksm_common.h)

Anyway, nice cleanup work!
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--0000000000005c2d4205d95bf4f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Cyril,</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">B=
eside the tiny issues pointed out in [5|6]/7. The remaining</div><div class=
=3D"gmail_default" style=3D"font-size:small">part looks good to me.</div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">That would be awesome if you c=
ould help cleanup other ksm</div><div class=3D"gmail_default" style=3D"font=
-size:small">tests at the=C2=A0same time. Or, I help do that=C2=A0separatel=
y later on.</div><div class=3D"gmail_default" style=3D"font-size:small">(e.=
g. knob=C2=A0validation, add KSM kconfig, and remove &#39;merge_across_node=
s&#39; from ksm_common.h)</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>Anyway, nice cleanup work!</div><div class=3D"gmail_default" style=3D"font=
-size:small"><div class=3D"gmail_default">Reviewed-by: Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</=
div><font color=3D"#888888"><br></font></div></div><div><br></div>-- <br><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></di=
v></div></div></div>

--0000000000005c2d4205d95bf4f8--


--===============1695365912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1695365912==--

