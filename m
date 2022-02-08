Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8DEC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 09:24:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D09A43C9B4B
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:24:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE13B3C06B2
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 10:24:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C21C61000234
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 10:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644312259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=km3pkasDheWD3808P6SFMyxVPrEucKydBsTsXRdev1s=;
 b=ME+Hovggme5xLQaQd8jmMJkTjiWSNJY+lr2PYhg/bqiuL5IQzPgSY0WyUrJim7HYWCIKpN
 dqM5o38cvdOBYjMHm2wVnQdH5dQHjvbHgPUewrtyezE35Kss+LYPVLLpphVS4u9JAjlsiT
 SG61z8PX0dS/5odPr7RzZtXGVA149jY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-6vNdVRbHNSeNRtlVZFRFbQ-1; Tue, 08 Feb 2022 04:24:17 -0500
X-MC-Unique: 6vNdVRbHNSeNRtlVZFRFbQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 b12-20020a056902030c00b0061d720e274aso18648377ybs.20
 for <ltp@lists.linux.it>; Tue, 08 Feb 2022 01:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=km3pkasDheWD3808P6SFMyxVPrEucKydBsTsXRdev1s=;
 b=DbPfLlJYztJ8ZZ2uzgaPtdCCqkNxwnnbFcGQFsqx9D1mPg4KYJ/WVj4BWFW5IEoHk0
 ecFiV/5MzP+yTnxvvHmkZdlh5Qch7lHQJDJz8lXnNq43k/WSKg2hbKdLi5g46NewC6xE
 /gCZ4a/cTrTZWtLp44jsIFjgMOhfzUuCaA7EGmV/76D74snacDIjXMLawVDA8gCg5olF
 yNAr8WY4lVJE2wMA2TDVraVfxsabcKIa6Xw3BWNSvB6Pj9BpHlNXGCguNyHByhtVyhWW
 xjVcotCw/x57edhi/eRzHe9vzPPxfq6WVfxjYMTV1OxADXJyWq5Pd6fXryw3FCQHRHou
 p+mg==
X-Gm-Message-State: AOAM5314+/KfvYTsL/iZpWJMCFFB/0xBxQHc8eLDwAeLI6RZw/ZrJFAn
 Kx2Dxv+vqfepiZ1PNTfcGs+/FzddpBQWGoN56QtS5xXBjCgU1XzDWimQgS76iHwbBNydA1npq5x
 Cf2CFBzDvYZK1xqAAFa/l0MuqVgE=
X-Received: by 2002:a81:3552:: with SMTP id c79mr4023789ywa.300.1644312257067; 
 Tue, 08 Feb 2022 01:24:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlsr8RZmgepuNiNaXHUKh1j+d5hVftmOn1o0kc+rA/QYi8DxBUeOLhEwX6PWnmAa8Cbn9EK7l+leEQJVk92dA=
X-Received: by 2002:a81:3552:: with SMTP id c79mr4023780ywa.300.1644312256874; 
 Tue, 08 Feb 2022 01:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20220207141618.2844-1-rpalethorpe@suse.com>
 <20220207141618.2844-3-rpalethorpe@suse.com>
 <CAEemH2d-K=X0aodrLV=4AiVE-GWDkHv3+Rxf_NUq8btH=jF77A@mail.gmail.com>
 <87czjxwwgc.fsf@suse.de>
In-Reply-To: <87czjxwwgc.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 17:24:03 +0800
Message-ID: <CAEemH2c0MTyitsSjbUqDsyW5rsOOAkXMJconVcBQRZLr0vK=4w@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/5] API/cgroup: Declare required controllers
 and version in test struct
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
Content-Type: multipart/mixed; boundary="===============0812719631=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0812719631==
Content-Type: multipart/alternative; boundary="000000000000f8a11905d77e47b8"

--000000000000f8a11905d77e47b8
Content-Type: text/plain; charset="UTF-8"

> > What about declaring as 'tst_cgroup_test' ? i.e.
> >
> >     const struct tst_cgroup_group *const tst_cgroup_test = &test_group;
> >
> > As it is a reference to test's CGroup and the test_dir is the same
> > layer with drain_dir, so this will be easier to understand the
> relationship
> > with drain_group.
> >
> >  +const struct tst_cgroup_group *const tst_cgroup_drain =
> >  &drain_group;
>
> I agree with your logic, but the variable name is too long even without
> '_test'. Perhaps we could shorten cgroup to cg? However I can submit a
> separate patch for that.
>

Ok, I agree with shortening that. Thanks!


-- 
Regards,
Li Wang

--000000000000f8a11905d77e47b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; What about declaring as &#39;tst_cgroup_test&#39; ? i.e.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0const struct tst_cgroup_group *const tst_cgroup_tes=
t =3D &amp;test_group;<br>
&gt;<br>
&gt; As it is a reference to test&#39;s CGroup and the test_dir is the same=
<br>
&gt; layer with drain_dir, so this will be easier to understand the relatio=
nship<br>
&gt; with drain_group.<br>
&gt;<br>
&gt;=C2=A0 +const struct tst_cgroup_group *const tst_cgroup_drain =3D<br>
&gt;=C2=A0 &amp;drain_group;<br>
<br>
I agree with your logic, but the variable name is too long even without<br>
&#39;_test&#39;. Perhaps we could shorten cgroup to cg? However I can submi=
t a<br>
separate patch for that.<br></blockquote><div><br></div><div><div class=3D"=
gmail_default" style=3D"font-size:small">Ok, I agree=C2=A0with shortening t=
hat. Thanks!</div><br></div></div><div><br></div>-- <br><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wan=
g<br></div></div></div></div>

--000000000000f8a11905d77e47b8--


--===============0812719631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0812719631==--

