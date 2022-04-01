Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6462FC433F5
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 09:48:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63CE93CA2E9
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 11:48:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85D993CA182
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 11:48:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B8D77140113C
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 11:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648806513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SoWwvDbY8f2FuHDv13y/s31sWTM+HpuzC3hSmv6uHvc=;
 b=VrSwI55J/QhHs4cHjIkCF4yNjF+WrSwUzQv7PUxGWR3VZWYtYYLh9tccHSJnhCBPZGjFnQ
 QkdEYHmmSacN3us7gwwYe7lGQakgqjiJDTrhJ26pMDFpfz4e9aWZz+2YxzrhMCdq+ICmrP
 JN42VhB9GevuW6bVBq9mG0bOnsWPSmc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-ClJR6D53PNqQvCaok0myDw-1; Fri, 01 Apr 2022 05:48:32 -0400
X-MC-Unique: ClJR6D53PNqQvCaok0myDw-1
Received: by mail-yb1-f200.google.com with SMTP id
 t9-20020a5b03c9000000b0063363e52dd1so1834816ybp.2
 for <ltp@lists.linux.it>; Fri, 01 Apr 2022 02:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SoWwvDbY8f2FuHDv13y/s31sWTM+HpuzC3hSmv6uHvc=;
 b=FfG2GmojhCC9QwH/tROBYdBeFatjGMdfYm5K28TNhOTDQTGGo3UDMbHEtrA+3loMMH
 UT7g8lsKLAJny1hdC1s7P30BqF7XzAdEWDUl0M29A3fEWPwc3Fb2Z9hRiJx/fLdi6vk2
 edWgRPegWACJQbDIsm1v9OSVi9rQ7xfENEzNuZO7ycvfUS14L/nDg3OnHUBcflJhyLOd
 cynb3oxcghgyW8g7nste7AECCBqeARz6ReCWa5Lzl5knWU+VNvUPFr2it5EQI/fXHaYF
 UXM+VwZoQ9JywyBSwQsYFTB/uBFqmG7TOc3W0YgldMOKFvboL93xW6WMEahrGmVJ5mSr
 lOLg==
X-Gm-Message-State: AOAM532JeH5UjIgubdPfVfy7V9cummySXBq2g2pDOqzVeq7nysi2V6n3
 O7xRgJppd2WN/gJEO3CW197f7fToRsaZTd2+k3E3MNb9GRiwUbRZkPZY7Nu9OM52i6zpqRUobw4
 uFcRDnQhJ+0o0jjsX/2GWYMTHjqM=
X-Received: by 2002:a25:d788:0:b0:634:dd8:49c8 with SMTP id
 o130-20020a25d788000000b006340dd849c8mr8054098ybg.161.1648806511430; 
 Fri, 01 Apr 2022 02:48:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpgjU6aLaceo4NYCoM2IPOxUUz2PLWQ++fzWXMrMe+EUbD1HEjgh7aDJZUi3rrL3d4Leb3OiHD0CWcrijndhY=
X-Received: by 2002:a25:d788:0:b0:634:dd8:49c8 with SMTP id
 o130-20020a25d788000000b006340dd849c8mr8054090ybg.161.1648806511213; Fri, 01
 Apr 2022 02:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220401084124.801586-1-liwang@redhat.com>
 <YkbDasKqlCyln8wP@pevik>
In-Reply-To: <YkbDasKqlCyln8wP@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Apr 2022 17:48:15 +0800
Message-ID: <CAEemH2e+tJect7Nh_A+Ec_ZUjwxPRmx1W3zMn4_WZz3cbL=gAQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: resolve some no match arguments problem
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
Content-Type: multipart/mixed; boundary="===============1502517977=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1502517977==
Content-Type: multipart/alternative; boundary="00000000000067937f05db94ae15"

--00000000000067937f05db94ae15
Content-Type: text/plain; charset="UTF-8"

> BTW Other alternative would be to move these packages to the end, i.e.:
> $yum foo || true
>
> Because with this, we might put rubygem-asciidoctor also to main $yum
> command
> (it should now work with --skip-broken


Yes, good point.

-- 
Regards,
Li Wang

--00000000000067937f05db94ae15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
BTW Other alternative would be to move these packages to the end, i.e.:<br>
$yum foo || true<br>
<br>
Because with this, we might put rubygem-asciidoctor also to main $yum comma=
nd<br>
(it should now work with --skip-broken<span class=3D"gmail_default" style=
=3D"font-size:small"></span></blockquote><div><br></div><div class=3D"gmail=
_default" style=3D"font-size:small">Yes, good point.</div></div><div><br></=
div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div=
>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000067937f05db94ae15--


--===============1502517977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1502517977==--

