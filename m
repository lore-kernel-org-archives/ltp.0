Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6F2C3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 02:24:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D3463C921B
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 04:24:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F32C3C0727
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 04:23:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 37DF120023C
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 04:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666578229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=APlEkbR+3+SBHuodjHwI246NbvJ/LL9+Mo1BrArWJXg=;
 b=jOatRRaSLWRC/usoeYarSBIHPRS4lBT9jSNDCo00MtFlFjMARWaNrpQwIzOIlgt9HzlB7r
 RfFEL6OjBhUR816WwH/7loFPxNYB1xVCk2Grw1zUFuSc67cHbiCcAp2POerABTW8k49BR5
 x2mVZPsS/tHeePM61HqzWajYOkERih0=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-361-hx2clcIFMQeosZdv6kgm0w-1; Sun, 23 Oct 2022 22:23:40 -0400
X-MC-Unique: hx2clcIFMQeosZdv6kgm0w-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1331cbf6357so4751646fac.11
 for <ltp@lists.linux.it>; Sun, 23 Oct 2022 19:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APlEkbR+3+SBHuodjHwI246NbvJ/LL9+Mo1BrArWJXg=;
 b=Wq6BagZnJEuAoKb+VhO32yZ43VaAZKilkSTqZEewolw5GLgnYZQgamk4E+eO4nC0jw
 NEQg3TPHY7IxSzm3+hY3Z79yqYCEGwvscu68oTAaPIc7cBk5PkCgNle3pl3ADzOXvWot
 bjUafXwrynGURMpSLwVr4LL+Uv3hyfaY0nYdU35ojdgcOCTPGPR/iH16nXmq7V3L7B3W
 GgEySFVyq4K4YCPZDpxGxftW7vgA3NSgz91HCnGpaPYX4ZC+yqDZdc+WnBcEGDroUqY6
 k4KSzChIG+3r1DUS6H8rBjiYu+WWnvGqk2knqe1tn1ixGx1yFt2+o7s/YjUVB+ubcsGA
 B5GQ==
X-Gm-Message-State: ACrzQf1cQIKwKNj7mOhVwb/3KYvllnTqJphDkmOUdSBsRLGDUVHciXLP
 toJo2yG58j6FmPrWsVKHh8kig0KHVMuoQDPGY5GYBCREBQv7ldbcxglNu8FAQSRx2RyG8b0zpFv
 YgHHoFeXt+8IppVQ4TNW/cF1In8Q=
X-Received: by 2002:a9d:6544:0:b0:665:be47:df05 with SMTP id
 q4-20020a9d6544000000b00665be47df05mr158240otl.7.1666578219562; 
 Sun, 23 Oct 2022 19:23:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6HQ8pwihFihHW5F7jTKZu9hqZGaBHZSrWud46CpTDXRaWv3Mame9bO7YzCZyGFF/esI/UaGE3dpltfmEFyVUY=
X-Received: by 2002:a9d:6544:0:b0:665:be47:df05 with SMTP id
 q4-20020a9d6544000000b00665be47df05mr158234otl.7.1666578219311; Sun, 23 Oct
 2022 19:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221009085745.3239893-1-liwang@redhat.com>
 <871qr2x4da.fsf@suse.de>
In-Reply-To: <871qr2x4da.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Oct 2022 10:23:26 +0800
Message-ID: <CAEemH2c39uij_kEfK-0EtNKNhQJFquC3hPaXX4TE1iG+TDr+UQ@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============2036573303=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2036573303==
Content-Type: multipart/alternative; boundary="000000000000c0bedb05ebbe7a3f"

--000000000000c0bedb05ebbe7a3f
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

After trying that there were new problems with the below two comments.


> +static void verify_setitimer(unsigned int i)
> > +{
> > +     struct tcase *tc = &tcases[i];
> > +
> > +     si_flag = 0;
> > +     value->it_value.tv_sec = SEC1;
> > +     value->it_value.tv_usec = SEC0;
>
> Why not test usecs instead?
>

Yes, But the point we need attention here is to avoid defining
a very tiny value for USEC. Otherwise, test will sometimes get
first-timer expiration too early so that it has not had enough time
for the rest code get an execution.


> +     if (ovalue->it_value.tv_sec <= SEC1)
> > +             tst_res(TPASS, "setitimer functionality is correct");
> > +     else
> > +             tst_brk(TFAIL, "old timer value is not equal to expected
> value");
> > +
> > +     for (;;) {
>
> Could we use sigwait here instead?
>

sigwait() function suspends the calling progress which will
disturb the target process counts down the user-mode CPU time.
This led to the test hanging and never expiring the timer.


> We seem to be burning CPU cycles for no reason and if we get a spurious
> signal the test will still pass if we get the correct one afterwards.
>

And, these three signals all will terminate the process, so maybe
another resolution is to test in children and check if they exit by
the expected signal.

-- 
Regards,
Li Wang

--000000000000c0bedb05ebbe7a3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div></div><br><div class=3D"gmail_quote"><div cl=
ass=3D"gmail_default" style=3D"font-size:small">After trying that there wer=
e new problems with the=C2=A0below two comments.</div><div><br></div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +static void verify_setitimer(unsigned int i)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct tcase *tc =3D &amp;tcases[i];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0si_flag =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value-&gt;it_value.tv_sec =3D SEC1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value-&gt;it_value.tv_usec =3D SEC0;<br>
<br>
Why not test usecs instead?<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">Yes, But the point we need att=
ention here is to avoid defining</div><div class=3D"gmail_default" style=3D=
"font-size:small">a very tiny value for USEC. Otherwise, test will sometime=
s get</div><div class=3D"gmail_default" style=3D"font-size:small">first-tim=
er expiration too early so that it has not had enough time</div><div class=
=3D"gmail_default" style=3D"font-size:small">for the rest code get=C2=A0an =
execution.</div></div><div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div></div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0if (ovalue-&gt;it_value.tv_sec &lt;=3D SEC1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TPASS, &quot;=
setitimer functionality is correct&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TFAIL, &quot;=
old timer value is not equal to expected value&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (;;) {<br>
<br>
Could we use sigwait here instead?<br></blockquote><div><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">sigwait() function suspends t=
he calling progress which will</div><div class=3D"gmail_default">disturb th=
e target process counts down the user-mode CPU time.</div><div class=3D"gma=
il_default" style=3D"font-size:small">This led to the test hanging and neve=
r expiring the timer.</div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
We seem to be burning CPU cycles for no reason and if we get a spurious<br>
signal the test will still pass if we get the correct one afterwards.<br></=
blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">And, these three signals all will terminate the process, so maybe</di=
v><div class=3D"gmail_default" style=3D"font-size:small">another resolution=
 is to test in children and check if they=C2=A0exit by</div><div class=3D"g=
mail_default" style=3D"font-size:small">the expected signal.</div><div clas=
s=3D"gmail_default" style=3D"font-size:small"><br></div></div>-- <br><div d=
ir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></=
div></div></div>

--000000000000c0bedb05ebbe7a3f--


--===============2036573303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2036573303==--

