Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CEEC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 07:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1FD13C9B3F
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 08:27:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E84DD3C87C6
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 08:27:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D0579200393
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 08:27:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644305265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQV2ErNb+/WkEXLgGimLlbY8evAQ0kGW9Za3aPoYYe0=;
 b=dKhFJ6dDcaUpAIiKHsPSSBo1SFhc83rnACOx/XI+Iteo83erJFrmXBRPdtPZFvE99jyfmp
 q1eoicNEeIEMW641mu2ak/Cw6e4zNIBHjrmhA6cqxYJLqAcvUJiVZJehZBg4jC2pztW+55
 etfIAnW8z2QJcNCUpC0tagrxU3Yvews=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-xUq-ssGCOc-TyCwTpC3BqQ-1; Tue, 08 Feb 2022 02:27:43 -0500
X-MC-Unique: xUq-ssGCOc-TyCwTpC3BqQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 s73-20020a25aa4f000000b0061d764d3c13so17751871ybi.1
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 23:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fQV2ErNb+/WkEXLgGimLlbY8evAQ0kGW9Za3aPoYYe0=;
 b=Cj81wzFI4QPyW5A9iRFj4sjgyM4VLOiqHR8jT97lNTRxOx6bN9+/9hrLlo8YSK8VTd
 cn9Rl3KpEkD8u1YpxfNB9kIl2v9xPpJw4DWZGNnZ6Ij2qiIOH+OjlV8IONfSyk6rR/kf
 mU1sKFXG2NRBWp1K6iJ3JSaLoFOSdHMAk6Ljp8qOh/no/frmXeg5h+mhpWQPz3xppWQP
 NX5LvOzg63sUeRFXIb0sK2+Fh8ge4dolLPCABhIjrxQHZMRefUECZeL/pg2t9QauYgK2
 XUIC0rWUxel+b4763TtPSEKi9XMUFVYYm/rrzgPxk315INjYSAIDXNkmk9WMAG4DVmwB
 Tu3g==
X-Gm-Message-State: AOAM5330DlkS3pe7znF/7MrOPHalK5VDFCYDZA6n2XIru7omD388vBdt
 d9kPzOfGGRJFYX+jHrj1WWM5R6W94F3rG8k2kRrmaQQCqGkITKKUFKE5TSaBtDjInH725qNto3O
 D98vLEpTY4j2DJfJ+fdBR6DM4QTE=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr3531062ywh.19.1644305263142; 
 Mon, 07 Feb 2022 23:27:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwodW2i7IkVwN7rm/sBGzqyVgONFtk60j/T5+aBqXAWkzrLHoGHSXx7eZPYEtRABnIIM5vqgWcmZxdc++qrWak=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr3531052ywh.19.1644305262922; 
 Mon, 07 Feb 2022 23:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20220207141618.2844-1-rpalethorpe@suse.com>
 <20220207141618.2844-5-rpalethorpe@suse.com>
In-Reply-To: <20220207141618.2844-5-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 15:27:26 +0800
Message-ID: <CAEemH2f3YFnGV96pNFen3+2cTz_KCFP90_UkJYm6kWMCdKuR0Q@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] API/cgroup: Make tst_cgroup_group_mk
 sprintf like
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
Content-Type: multipart/mixed; boundary="===============0271813457=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0271813457==
Content-Type: multipart/alternative; boundary="0000000000001964ac05d77ca70f"

--0000000000001964ac05d77ca70f
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 7, 2022 at 10:16 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Allows the name to be formatted which is trivial because we already
> copy it into a buffer. Also this removes the init function which is
> now just unnecessary verbiage.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--0000000000001964ac05d77ca70f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 7, 2022 at 10:16 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.com">rpalethorpe@suse.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Allows the =
name to be formatted which is trivial because we already<br>
copy it into a buffer. Also this removes the init function which is<br>
now just unnecessary verbiage.<br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
Suggested-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div>=C2=A0</div><div><spa=
n class=3D"gmail_default" style=3D"font-size:small"></span>Reviewed-by: Li =
Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redh=
at.com</a>&gt;</div><div><br></div></div><div><br></div>-- <br><div dir=3D"=
ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div=
>Li Wang<br></div></div></div></div>

--0000000000001964ac05d77ca70f--


--===============0271813457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0271813457==--

