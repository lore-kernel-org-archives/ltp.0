Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7E1C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:00:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DCDA3CB184
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:00:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A54423CAE89
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:00:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4FB971A01127
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:00:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666260023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K+K8VRapWwUI+Lho7DbGkvemQ2DIlV0HfkbuE3E+uIc=;
 b=JBuTyqJCs/ZcoED3ErOV+j0wVfW3uFGeEcI7SPd4uzBEMlAbVxdpAaO1AydL/0L2GlThKY
 858379tY2jBtPOemjAbk783qWylkxBtcCmcbMCKQ6HXUITuJaV5zwDLRxj+Bo1Uwn28ztQ
 uLEESETC3lqZ/XGc4r21tsWm9+j8MZo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-bBfCjBveOVCrb8LD4xKiOQ-1; Thu, 20 Oct 2022 06:00:22 -0400
X-MC-Unique: bBfCjBveOVCrb8LD4xKiOQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 36-20020a9d0627000000b0063927bfccb5so9688262otn.18
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 03:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K+K8VRapWwUI+Lho7DbGkvemQ2DIlV0HfkbuE3E+uIc=;
 b=V6ek0i06pZqHf/R1FMd5w32ydM224nVl8yAl0Roh2WUD+R+7WbhEsEIMF6D9RR5XVI
 vIo52xgGNZWah+Qgzk1j4UPcTQtEhg1udj56d8CL80E9+NysANCIIxWxLNaq0gg+4Hef
 Iqupq8xJPMIdcWsWHGkoA0JcmETIbR9NEFoD2HXeg3m7L2j1j+AkaAdO0DQHVPzQrJyd
 norODNlQ0x6BF1QH97urDe6pE0HJr8KsHb7vx4Wzc9fLx7vIpKpUIuq6dNOseOl1hmAC
 gcoSpxPPpA2k/qdZzcTCkLbjgrMBAOChhGB7NjDwqYnr7BGSuF5T9gCiDKFG237+lQd+
 7Vlg==
X-Gm-Message-State: ACrzQf2O0zZPgbH9mEIY3+XuePI35Z8roPMcRUGsyc8bsgzNyRkf58EP
 V96rompC07O9a87bFsC/2z3nJ7s/u8SeTfczO1zNBtiKmrxR5TaOX6C0fy/dr+yvSgV9Yrp1OMg
 HoM27kBMaIzMj6ScZfhtJDRkpr6A=
X-Received: by 2002:a05:6808:1704:b0:351:43bc:5e52 with SMTP id
 bc4-20020a056808170400b0035143bc5e52mr21492738oib.107.1666260018474; 
 Thu, 20 Oct 2022 03:00:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5k9VenZXr8VSIsdB2O0OWqRLf4G/Vj6tq4pkDI3DFO+RHCAdo0OOCzlY1pugaJlFJVCPZ6x6zJmITX5YAqx14=
X-Received: by 2002:a05:6808:1704:b0:351:43bc:5e52 with SMTP id
 bc4-20020a056808170400b0035143bc5e52mr21492734oib.107.1666260018269; Thu, 20
 Oct 2022 03:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221009085745.3239893-1-liwang@redhat.com>
 <871qr2x4da.fsf@suse.de>
In-Reply-To: <871qr2x4da.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 18:00:05 +0800
Message-ID: <CAEemH2c-PUqVtEpH5Y7CPU3AVYjyB9nxkiqKXC8cxniRvgbfxQ@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setitimer01: rewrite using new API
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
Content-Type: multipart/mixed; boundary="===============0530012904=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0530012904==
Content-Type: multipart/alternative; boundary="0000000000007e27e305eb746483"

--0000000000007e27e305eb746483
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:



> > +      * call setitimer again with new values.
> > +      * the old values should be stored in ovalue
> > +      */
>
> We should probably set ovalue to some value > SEC1 here. Otherwise it
> could just be zero or some previous value that is still valid.
>

Make sense!

And the rest comments all sound good to me. Will send V2 tomorrow.


-- 
Regards,
Li Wang

--0000000000007e27e305eb746483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de"=
>rpalethorpe@suse.de</a>&gt; wrote:<br></div></div><div class=3D"gmail_quot=
e"><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 * call setitimer again with new values.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * the old values should be stored in ovalue<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
<br>
We should probably set ovalue to some value &gt; SEC1 here. Otherwise it<br=
>
could just be zero or some previous value that is still valid.<br></blockqu=
ote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Make sense!</div><div class=3D"gmail_default" style=3D"font-size:small"=
><br></div><div class=3D"gmail_default" style=3D"font-size:small">And the r=
est comments all sound good to me. Will send V2 tomorrow.</div></div><div><=
br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signat=
ure"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></=
div></div>

--0000000000007e27e305eb746483--


--===============0530012904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0530012904==--

