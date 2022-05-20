Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0BEC433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 11:16:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98C853CAAE9
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 13:16:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DA5D3CA948
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:16:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2EAF414010D9
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653045366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rb0+TF+MaUSTWSTbQezxGS+D69+9D9QXZPqhmWyEPAo=;
 b=UCDydoJ3z2Z7NeSsWaI9tEeSV1ukJfuQmxrV02BQ3FKmTvThAAWj+K2YvL25E9wTY6CiMr
 xMZYcGk5VNYMtdLOwZFf8kiKy76d4vcpO3dOlCjaMdNqHmHN84XKuryRG+iYR9WSTaFH17
 v8DMJeHo5xiUO9W8DScxH5TQj1meF38=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-bDJtJTMDMnOFzG2yUC0Xyg-1; Fri, 20 May 2022 07:16:05 -0400
X-MC-Unique: bDJtJTMDMnOFzG2yUC0Xyg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2ff37db94e8so68478827b3.16
 for <ltp@lists.linux.it>; Fri, 20 May 2022 04:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rb0+TF+MaUSTWSTbQezxGS+D69+9D9QXZPqhmWyEPAo=;
 b=Y3y9cR278FZdrl/dbmJogKqnNVU9HWvZ0W53nqqT/Qd7HceuGohlSG4XkkbJ8cCcPf
 VQA/0NmG558ceQ+uUFHe+JEWVLt7wFAs+hrybME+Wuun7zu3vIV29ZugxH3R4C+umdxT
 ei+ruiyfdW8qiq4B3zh/7DEhIzq+OmzlRPtLjhjPVeScmhkxBQYwj0+4wDkObRMcdpsA
 K6UByC8Tfa0UqzUMy8FcInwZ26p8THAQQiRi+rSSqy5I+Bh6t24fRNfcQtlP1UD7OpEj
 wQmjghJ2A7aFx+8UmCmg0kMWPS2c4dfD0lT3aygQHo5U4+lsnM0s+fTLTn8In7ZLlHyf
 IgWQ==
X-Gm-Message-State: AOAM533VFTsnDzAwmUH0+SZocNKkPdaZXX/I6k7yhY3X0K4YLCN3dgjA
 B8IB9HePQWiVnJRJhKLn9iaWb+d07hQ1Qaxe3aQ1ChdjtBOLssb394OBw/SXqlWm/IxMhgdjZZN
 jRxXRDf1/z77EQF9NWp9Tm1cZc44=
X-Received: by 2002:a25:f312:0:b0:64d:6742:1e80 with SMTP id
 c18-20020a25f312000000b0064d67421e80mr8982985ybs.273.1653045364407; 
 Fri, 20 May 2022 04:16:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTJMovwu8NpXUyQA92sBqISQKxl+qrH4DIRhWkpcGVgdjV+6pNktQM3V/tbKiXlRaKlt60gm6lw/1tdbeIrXw=
X-Received: by 2002:a25:f312:0:b0:64d:6742:1e80 with SMTP id
 c18-20020a25f312000000b0064d67421e80mr8982965ybs.273.1653045364105; Fri, 20
 May 2022 04:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220520083627.2499121-1-liwang@redhat.com>
 <20220520083627.2499121-2-liwang@redhat.com> <Yod1iO3+bURGGNET@yuki>
In-Reply-To: <Yod1iO3+bURGGNET@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 May 2022 19:15:53 +0800
Message-ID: <CAEemH2d3mgQGWLev6jqcrLH7n5H0qZ22BK69jKketm=3Sz827Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] testcases: make use of runtime
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
Content-Type: multipart/mixed; boundary="===============0361301637=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0361301637==
Content-Type: multipart/alternative; boundary="000000000000b9b9ea05df6f9dbe"

--000000000000b9b9ea05df6f9dbe
Content-Type: text/plain; charset="UTF-8"

> This should be ammended to the "fuzzy_sync: Convert to runtime" patch.
>

Yes, that would be better. Feel free to merge into that one.

-- 
Regards,
Li Wang

--000000000000b9b9ea05df6f9dbe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0<br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
This should be ammended to the &quot;fuzzy_sync: Convert to runtime&quot; p=
atch.<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"=
font-size:small">Yes, that would be better. Feel free to merge into that on=
e.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatu=
re"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></d=
iv></div>

--000000000000b9b9ea05df6f9dbe--


--===============0361301637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0361301637==--

