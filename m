Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074DBC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 09:30:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFD823CB18A
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 11:30:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5353D3C9179
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 11:30:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4BCBD10005C1
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 11:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666258239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eaAk6y39Fr2TR1v2XQm6oxdGZT6tioc9Yw7dfIFmwAo=;
 b=D1+DgAKmuklc0gwZM7RHOmBDOzLS04eHHOdHgvPqygdJHrxd4w28R9Wuf+laP0KxllGHHJ
 gp/qhT6Omz3zW6dZBrZ3blQkKfvv2yFdkuVLKFnVDcrhCwAP3QDClISlV+HoKIkj6UknEm
 NF/geoo7Ag/Xc+RykXGH6NtJU/afJ3k=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-lcxeiX2WNiyFVTJ4Afk_5A-1; Thu, 20 Oct 2022 05:30:35 -0400
X-MC-Unique: lcxeiX2WNiyFVTJ4Afk_5A-1
Received: by mail-oo1-f70.google.com with SMTP id
 q19-20020a056820029300b00476b35bd302so9326319ood.22
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 02:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eaAk6y39Fr2TR1v2XQm6oxdGZT6tioc9Yw7dfIFmwAo=;
 b=7vihYgz1EW/lMnf2bB3aNdX9pfUgH5tsBl4DubAVE24cjN17egzOz1pUqU8QuXl0my
 XpPivzUTMXIm5zom7fjpg0JJBh/rDdh5FhBJIxFW7zf+L2ucDqrr2OMLSNQpUtbASXXe
 t+/6hrD6g15dnbkLnI1w3T87zBbgSBp3LfGTzCGIkpd3joOXsU6OiGYx+hQAhfrg7+vk
 J1FWyPFlvQCvXNa/aR4EdWTJjD6sa1MIRz1Jd9wFe6HWFaa1NqGqou5xGPf+ZVqG74NW
 lp+AGo3rMFndvLAda0r7hGcBWO1R3vq3N2/5MtOhdhiiMSt+/lBLsmVmo7qswWnf66qN
 Srjg==
X-Gm-Message-State: ACrzQf0aTOtJ9ohN9o3ayybYTihUmX9Z82oviz72ePGbgbODwNW/E1hM
 5y04B+TDvLFxyX5HTJQAv1T3+Tj/FK+SEO4qrDnk2EuyWXtE25BSXnvIH2tDtL35DIh6infTqus
 03d6uSAPx7/H/PNMxcovxzpgSL04=
X-Received: by 2002:a05:6808:1486:b0:355:3cb7:b51 with SMTP id
 e6-20020a056808148600b003553cb70b51mr6733125oiw.19.1666258233065; 
 Thu, 20 Oct 2022 02:30:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5yAbTjkQVYgB14IhgLJyIgprV/0d0IUvKM8v6VGpkPLQouUwMRp0BVb7Pef9koEwizj51a2R8BrOz+c0QTLOE=
X-Received: by 2002:a05:6808:1486:b0:355:3cb7:b51 with SMTP id
 e6-20020a056808148600b003553cb70b51mr6733122oiw.19.1666258232903; Thu, 20 Oct
 2022 02:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221009065520.3236525-1-liwang@redhat.com>
 <20221009065520.3236525-2-liwang@redhat.com>
 <875ygex5ob.fsf@suse.de>
In-Reply-To: <875ygex5ob.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 17:30:19 +0800
Message-ID: <CAEemH2fq9qrr3vag3TOHNh_DE9u7s8TfEbr+ZwEPkj6jy1wZ2w@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] setitimer03: convert to new API
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
Content-Type: multipart/mixed; boundary="===============0356910483=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0356910483==
Content-Type: multipart/alternative; boundary="00000000000013a09305eb73fa17"

--00000000000013a09305eb73fa17
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:


> > -static struct itimerval *value;
> > +static struct itimerval *value, *ovalue;
> > +
> > +static struct tcase {
> > +       int which;
> > +       struct itimerval **val;
> > +       struct itimerval **oval;
> > +       int exp_errno;
>
> There is a whitespace error here (see checkpatch/make check)
>

yes, thanks.



>
> > +} tcases[] = {
> > +       {ITIMER_REAL,    &value, &ovalue, EFAULT},
> > +       {ITIMER_VIRTUAL, &value, &ovalue, EFAULT},
> > +       {-ITIMER_PROF,   &value, &ovalue, EINVAL},
> > +};
>
> Why do we need value and ovalue in the struct?
>

Becuase it does not allow parsing an invalid pointer address
from a structure, we have to give a valid address which pointer
to save an invalid address. Otherwise segement fault will
be hit in execution.

And for the last test item, I don't want the invalid pointer to have
a side effect disturbs the first invalid argument.



>
> >
> >  static int sys_setitimer(int which, void *new_value, void *old_value)
> >  {
> >       return tst_syscall(__NR_setitimer, which, new_value, old_value);
> >  }
> >
> > -static void verify_setitimer(void)
> > +static void verify_setitimer(unsigned int i)
> >  {
> > -     TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (struct itimerval
> *)-1),
> > -                  EFAULT);
> > +        struct tcase *tc = &tcases[i];
> > +
> > +     if (tc->exp_errno == EFAULT)
> > +             *(tc->oval) = (struct itimerval *)-1;
>
> Or, why do we use an if statement here instead of defining it in the
> struct?
>

Same above, that's why here explicitly reassign an invalid address.


-- 
Regards,
Li Wang

--00000000000013a09305eb73fa17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de"=
>rpalethorpe@suse.de</a>&gt; wrote:<br></div></div><div class=3D"gmail_quot=
e"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; -static struct itimerval *value;<br>
&gt; +static struct itimerval *value, *ovalue;<br>
&gt; +<br>
&gt; +static struct tcase {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int which;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval **val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval **oval;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int exp_errno;<br>
<br>
There is a whitespace error here (see checkpatch/make check)<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">yes, thanks.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt; +} tcases[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ITIMER_REAL,=C2=A0 =C2=A0 &amp;value, &am=
p;ovalue, EFAULT},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ITIMER_VIRTUAL, &amp;value, &amp;ovalue, =
EFAULT},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{-ITIMER_PROF,=C2=A0 =C2=A0&amp;value, &am=
p;ovalue, EINVAL},<br>
&gt; +};<br>
<br>
Why do we need value and ovalue in the struct?<br></blockquote><div><br></d=
iv><div><div class=3D"gmail_default" style=3D"font-size:small">Becuase=C2=
=A0it does not allow parsing=C2=A0an invalid=C2=A0pointer address</div><div=
 class=3D"gmail_default" style=3D"font-size:small">from a structure, we hav=
e to give a valid address which pointer</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">to save an invalid address. Otherwise segement fau=
lt will</div><div class=3D"gmail_default" style=3D"font-size:small">be hit =
in execution.</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">And for the=
 last test item, I don&#39;t want the invalid pointer to have</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">a side effect disturbs the f=
irst invalid argument.</div><br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int sys_setitimer(int which, void *new_value, void *old_v=
alue)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return tst_syscall(__NR_setitimer, which, ne=
w_value, old_value);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static void verify_setitimer(void)<br>
&gt; +static void verify_setitimer(unsigned int i)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (s=
truct itimerval *)-1),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EFAULT=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcase *tc =3D &amp;tcases[i];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (tc-&gt;exp_errno =3D=3D EFAULT)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(tc-&gt;oval) =3D (s=
truct itimerval *)-1;<br>
<br>
Or, why do we use an if statement here instead of defining it in the struct=
?<br></blockquote><div>=C2=A0</div><div><div class=3D"gmail_default" style=
=3D"font-size:small">Same above, that&#39;s why here explicitly reassign=C2=
=A0an invalid address. </div><br></div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--00000000000013a09305eb73fa17--


--===============0356910483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0356910483==--

