Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD331C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 11:26:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3983B3C9274
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 12:26:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ACB83C0667
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 12:25:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B7AD601C5E
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 12:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640172349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4BRXAaexrdyUVdX17ZGKT8/+Ce1f8Bhxl84sA3NRu8M=;
 b=Aa1p0mUchflv/KNw9Abj0f/XkCL0WamegiGPGTqTBytMREV6RPwiKt10l8SsLU9lmjM6J7
 YqeCN0vKZp8d9WCsI59KKL4wlxNclse7uyaR41NdFpMlE2p1i6L+5smTfv1TLE5i6gSg3p
 mpf0u4/J43pSm95LH4ZEKhRKNsgHfIk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-F4j4wdPkNLSfnkgxNizNuQ-1; Wed, 22 Dec 2021 06:25:48 -0500
X-MC-Unique: F4j4wdPkNLSfnkgxNizNuQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 s189-20020a252cc6000000b005c1f206d91eso3430609ybs.14
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 03:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4BRXAaexrdyUVdX17ZGKT8/+Ce1f8Bhxl84sA3NRu8M=;
 b=kHAiMuDCzlnbyUJ5l9JAXqR87inunI8ra52k/O29e91lfKI3Mof+lCoCS0v89gvSk6
 rCo/qdH+EZjWy/wsYk9DcVhM8t7MpfBWauNTklnF1UmSdKfEE6//Awt79Gi9YZ81yXV6
 5L76pP6Onr/CQqpVRGxSw6z22cg+zpWLMMlmr9YGvcJkZoUUsbJVtWS7tg2QnJ2hF2C9
 6qkj0m00MlpHYhOBc6SP8WqbISH0o3Gl9zPojGmgUbAUxX8rT2RI26rhxiqCFMSGowwV
 0V3YB4wZPHsYw2BkLVhCjKeBMnAbA4AAqNqi8m6dsbIPlLwEOAxNenlvuj0qaM+oOOSx
 wi7w==
X-Gm-Message-State: AOAM530VeJrOBeWkAsFFPSQu6gVcRyBZcdqDkd7vyuo3KKuBysHy3gqT
 qc0t7LvBxvfFAAw+81jxqXz7G9046//gq7SwLOYQkjfmOY4mN7tBxeGD79k5dUDACtjcQiH4Oy0
 tx4IL9PnxL3RCaWig4e2shknLDD4=
X-Received: by 2002:a25:ce94:: with SMTP id x142mr3801707ybe.145.1640172347873; 
 Wed, 22 Dec 2021 03:25:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwii4C4dZyNhMoQ/9Ae3AFX5cmDQRkXIb/6o6Dsrp9ha+ENWWI6VhOZB9npqPKjydKXHBBt3qBfauWhmzrlJCU=
X-Received: by 2002:a25:ce94:: with SMTP id x142mr3801681ybe.145.1640172347625; 
 Wed, 22 Dec 2021 03:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20211221193500.31950-1-pvorel@suse.cz>
 <61C28CB8.3050209@fujitsu.com>
 <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
 <61C2C02A.90104@fujitsu.com> <YcLeaPJmSvmUJwJO@pevik>
 <61C2E3DB.9070004@fujitsu.com>
 <CAEemH2dpLJ9N57TpMhW3wMkd-V0cZMPWyH_sXn6KjXoWJWUC4g@mail.gmail.com>
 <YcL5XG6azJuGTys7@yuki> <YcL82UGphHruor3+@pevik> <YcMArVLw7UbLT/wi@yuki>
In-Reply-To: <YcMArVLw7UbLT/wi@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Dec 2021 19:25:34 +0800
Message-ID: <CAEemH2daRNd3ME5UP0mmEEc63xWQT3QwGwM50irNyqXn22++ZA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0404534584=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0404534584==
Content-Type: multipart/alternative; boundary="00000000000026bc3605d3ba623a"

--00000000000026bc3605d3ba623a
Content-Type: text/plain; charset="UTF-8"

Hi Cyril, Petr, Xu,

On Wed, Dec 22, 2021 at 6:39 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > We use just FILE_PRINTF(), but we check the result and TWARN, which
> causes the
> > failure in CI.
>
> Which is why I argued that we should add a version that does not print
> anything and just returns if the operation was successful or not. I
> guess it could be called TRY_FILE_PRINTF() or something.
>

or SILENT_FILE_PRINTF()?



>
> > I've sent v2, which checks CAP_SYS_ADMIN and CAP_SYS_RESOURCE,
> > but feel free just to bring simpler solution.
>
> I still think that the most acurate test would be just writing to the
> file and checking the result.
>

Yes, this method is simpler.

But checking the CAP_SYS_RESOURCE cap can show the
original problem more clearly, people read code easily to know
why here we do that cap check.
(e.g. like me cost much time debugging but not know the root cause)

So I think both of your solutions are great. Can we add the
silent file_printf into lib? I think it is useful to LTP as well.

-- 
Regards,
Li Wang

--00000000000026bc3605d3ba623a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Cyril, Petr, Xu,</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 22, 2021 at 6:39 PM Cyri=
l Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@s=
use.cz</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi!<br>
&gt; We use just FILE_PRINTF(), but we check the result and TWARN, which ca=
uses the<br>
&gt; failure in CI.<br>
<br>
Which is why I argued that we should add a version that does not print<br>
anything and just returns if the operation was successful or not. I<br>
guess it could be called TRY_FILE_PRINTF() or something.<br></blockquote><d=
iv><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">or=
 SILENT_FILE_PRINTF()?</div></div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt; I&#39;ve sent v2, which checks CAP_SYS_ADMIN and CAP_SYS_RESOURCE,<br>
&gt; but feel free just to bring simpler solution.<br>
<br>
I still think that the most acurate test would be just writing to the<br>
file and checking the result.<br></blockquote><div><br></div><span class=3D=
"gmail_default" style=3D"font-size:small">Yes</span>, <span class=3D"gmail_=
default" style=3D"font-size:small">this method is simpler.=C2=A0</span></di=
v><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><span cla=
ss=3D"gmail_default" style=3D"font-size:small">But</span>=C2=A0checking the=
 CAP_SYS_RESOURCE cap<span class=3D"gmail_default" style=3D"font-size:small=
"> can show=C2=A0</span>the=C2=A0</div><div class=3D"gmail_quote"><span cla=
ss=3D"gmail_default" style=3D"font-size:small">original problem</span>=C2=
=A0more clearly, people read code easily to know</div><div class=3D"gmail_q=
uote">why <span class=3D"gmail_default" style=3D"font-size:small">here </sp=
an>we=C2=A0<span class=3D"gmail_default" style=3D"font-size:small">do</span=
>=C2=A0that <span class=3D"gmail_default" style=3D"font-size:small">cap </s=
pan>check.=C2=A0</div><div class=3D"gmail_quote"><div class=3D"gmail_defaul=
t" style=3D"font-size:small">(e.g. like me cost much time debugging but not=
 know the root cause)</div></div><div class=3D"gmail_quote"><div><br></div>=
<div><div class=3D"gmail_default" style=3D"font-size:small">So I think both=
 of your solutions are great. Can we add the</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">silent file_printf into lib? I think it is us=
eful to LTP as well.=C2=A0</div></div><div>=C2=A0</div></div>-- <br><div di=
r=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></d=
iv></div></div>

--00000000000026bc3605d3ba623a--


--===============0404534584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0404534584==--

