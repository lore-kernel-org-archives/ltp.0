Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B4FC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 06:59:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADBE53C886A
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 07:59:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 838ED3C04D1
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 07:59:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 76E811400DA2
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 07:59:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647932351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=neBSJB27qTLBB8zAsG4DFrOvsFeFFDtHhb/rrkSOMK8=;
 b=LcuDHNyjindQHnYgaHkQvj8F88hFAFbkaT0izmDhe85PIeY74t5lqlTpDEtJpUJkWFHA2I
 rrgLz1K8KdJ/+Y0evWWuFLXdpv3dv4EMXc599jrgFsB+na5UmKSpoy/IUSMgjU/MCn+sRM
 5cTDvcNnye2VqDks+2TbEgXqWFzODO4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-zCsQDCIHPqOtmYEfmfcn0w-1; Tue, 22 Mar 2022 02:59:09 -0400
X-MC-Unique: zCsQDCIHPqOtmYEfmfcn0w-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2e67b4833d8so6188667b3.0
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 23:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=neBSJB27qTLBB8zAsG4DFrOvsFeFFDtHhb/rrkSOMK8=;
 b=F+k3vXRlZLwlMXNFADveoMnJ0wIF8XGWil4Df2Iu7rZhbleFH8XLpGn++0pLTOTkZh
 MTeBkDsTwsLEXQiMsrbADvaD8RYp1wDEqNoXArfwiuzrrSwjpGxELdC1a86Hoc/MBXnj
 Sz6VyApNCSalPLXM9wwKHQNMUOvEUkT2w9WyhbqGON+L12u8uJjCS9YvJ1foeIDaNSJf
 DAdAYkABMstlEfTE3vYQPV8v3g1klfr3p1iW+mBf8dLLC3801P6MR2DIunks2TqJV0vv
 z8Wqc0BLU0rMG0R8TFGGYJ8hoU4YBEtXNO/2QfbJM6rLLD/2uU5e9fAOHb2qb7j2F8kP
 FW/Q==
X-Gm-Message-State: AOAM533LNdjKrC9cp13RjpCQifDlHc4JvVPV83LDRfHwGn01b3dFkaqS
 hXNpGyarshJecFEs1JBA/iZp6dY5ea1LyhZOCIE5pUI1FC5xkxMYMiiOa51aYf1b3urjiB2PiQR
 Q2TaTchEBnjVMBqD8rSvpQ5en7jw=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr28593773ywm.19.1647932349311; 
 Mon, 21 Mar 2022 23:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBpKjHn3DlSAk+lOBtmuEzP2vXNU2K6yLlgndmxYhLP01vpbQrYyPHskXHFRtWKWb8AAT6ZMg9NbMgChOkX4w=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr28593761ywm.19.1647932349040; Mon, 21
 Mar 2022 23:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220321101429.3703-1-rpalethorpe@suse.com>
In-Reply-To: <20220321101429.3703-1-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Mar 2022 14:58:56 +0800
Message-ID: <CAEemH2fYy_WRLEdHyfomsEwFbbrJPCJZdZQ5HPjo=kQCr7tjNw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] memcontrol04: Copy from kselftest
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0315610492=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0315610492==
Content-Type: multipart/alternative; boundary="000000000000475db105dac9262d"

--000000000000475db105dac9262d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Palethorpe <rpalethorpe@suse.com> wrote:

At first glance this test looks the same as memcontrol03. However
> there are some significant changes which complicate combining the two.
>
> At least up to kernel (5.17) there appears to be a bug causing low
> memory events in F. There is presently no solution, so a known-bug tag
> with a link to Michal's investigation has been included.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> Cc: Li Wang <liwang@redhat.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


--=20
Regards,
Li Wang

--000000000000475db105dac9262d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@su=
se.com">rpalethorpe@suse.com</a>&gt; wrote:<br></div><div dir=3D"ltr" class=
=3D"gmail_attr"><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>At first glance this test looks the same as memcontrol03. However<br>
there are some significant changes which complicate combining the two.<br>
<br>
At least up to kernel (5.17) there appears to be a bug causing low<br>
memory events in F. There is presently no solution, so a known-bug tag<br>
with a link to Michal&#39;s investigation has been included.<br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
Cc: Michal Koutn=C3=BD &lt;<a href=3D"mailto:mkoutny@suse.com" target=3D"_b=
lank">mkoutny@suse.com</a>&gt;<br>
Cc: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwa=
ng@redhat.com</a>&gt;<br></blockquote><div><br></div><div class=3D"gmail_de=
fault" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto=
:liwang@redhat.com">liwang@redhat.com</a>&gt;</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div></div><div><br></div>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></di=
v><div>Li Wang<br></div></div></div></div>

--000000000000475db105dac9262d--


--===============0315610492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0315610492==--

