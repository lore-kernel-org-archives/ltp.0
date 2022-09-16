Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D8DC32771
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 01:37:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80C523CAC67
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 03:36:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E542D3CAAE8
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 03:36:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 28E2D601415
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 03:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663292204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/PqL4bi4ngy0/Tg6Ts+Qz8q+ZSqmpwcK9Sc4U7FGzM=;
 b=ga9mhd2O6ZLX++BerWv3xPoGvR+Cf2v5x+2t7yBC1ja/TDScE7L1vjNrYqva2ifrj64PJY
 O9YMAgTZbEFVVAuCM2EXTSPzkhQ02YTPZSFNrVSeiRODWRBpxfk7k3SDgvE0skcvF1f9f/
 0AED3L/SsarGc2sYzNVyjdwIvZPK50I=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-TmGXFst3NeG-ngX4X1a8CQ-1; Thu, 15 Sep 2022 21:36:42 -0400
X-MC-Unique: TmGXFst3NeG-ngX4X1a8CQ-1
Received: by mail-vs1-f70.google.com with SMTP id
 k12-20020a67ef4c000000b00398774a1c52so1945799vsr.18
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 18:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=w/PqL4bi4ngy0/Tg6Ts+Qz8q+ZSqmpwcK9Sc4U7FGzM=;
 b=L8IYu1UVZisATHEBkAXqz2v6hN3KmL162J5Gy6I2XrmTn1dscy1+ilgOXjNX9mL83g
 vjxyvgNyJMwZi7cDGbDnYWQbD3LhATjwfMIxeALa6lpDIKvEu4UQn2Y25VYmUJNOf5Sq
 15CZwXGtEQu23InutXfrsgabeI5BMdXB3QtAxXeXyG6O+on09K97jds8nFoUwQK3HR09
 0BNSjXyWjHx1rZpaiguqO4QrmBgFCjX4WWPHzqvp0LDMojETXbAJRwmgUEn+1d7En15b
 4iuIdcvNgrHrrs+LzO30DSEPZ7984uVb7Wvov74+mqx9YOl8M41YRLoyvPMSCPCZSFI1
 rNwg==
X-Gm-Message-State: ACrzQf3TT6f94jHmzGbSK12GwXeAtMc3UXEzyzCLc/bM7ay4SevkUzmO
 PRRG4kZL/+S34dngaCkfYwe7yLlbsqDLxtH5qsaYQTPaMVkk1EsD6PTgVJ+lUjp00Zbr4mKv2zT
 zIuzfWq6nHkOBtc+Z1MymSeJ1tn8=
X-Received: by 2002:ab0:5a24:0:b0:3af:fbb1:2dfb with SMTP id
 l33-20020ab05a24000000b003affbb12dfbmr1164579uad.27.1663292202334; 
 Thu, 15 Sep 2022 18:36:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7wpLK/wLpuNfKMJbF3WRSjYT1AD5rt6GZ+G96SGrGUu3wWDG4vsosrwZ3gP5G8CfUIg5tXkb8KdcVzZp416H8=
X-Received: by 2002:ab0:5a24:0:b0:3af:fbb1:2dfb with SMTP id
 l33-20020ab05a24000000b003affbb12dfbmr1164572uad.27.1663292202058; Thu, 15
 Sep 2022 18:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220915031020.2633347-1-liwang@redhat.com>
 <YyMgBQu+phGCulxV@pevik> <YyM05nwf1+0eCd3w@yuki>
In-Reply-To: <YyM05nwf1+0eCd3w@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Sep 2022 09:36:31 +0800
Message-ID: <CAEemH2d_ckW9Zm77wRcoejiY0rCDB1Tpgs7c3LB=WNwYYLF7Hg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open04: add EMFILE check
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
Content-Type: multipart/mixed; boundary="===============1658332568=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1658332568==
Content-Type: multipart/alternative; boundary="000000000000dc9bdf05e8c16410"

--000000000000dc9bdf05e8c16410
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 15, 2022 at 10:19 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > diff --git a/testcases/kernel/syscalls/open/open04.c
> b/testcases/kernel/syscalls/open/open04.c
> > > index d452405d4..01a8b12d6 100644
> > > --- a/testcases/kernel/syscalls/open/open04.c
> > > +++ b/testcases/kernel/syscalls/open/open04.c
> > > @@ -33,7 +33,12 @@ static void setup(void)
> >
> > >     for (i = first + 1; i < fds_limit; i++) {
> > >             sprintf(fname, FNAME ".%d", i);
> > > -           fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0777);
> > > +           fd = open(fname, O_RDWR | O_CREAT, 0777);
> > > +           if (fd == -1) {
> > > +                   if (errno != EMFILE)
> > > +                           tst_brk(TBROK, "Expected EMFILE but got
> %d", errno);
> > > +                   break;
> > > +           }
> > >             fds[i - first] = fd;
> > >     }
> > >  }
> >
> > LGTM.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> I faintly remmeber a similar patch where we decided not to work around
> for a test harness leaking filedescriptors into testcases.
>

This also should be a solution, I searched the mailing list and got a
patch[1].
Do you mean adding that close-on-exec flag when opening fd in harness?

[1] https://lists.linux.it/pipermail/ltp/2020-November/019650.html

-- 
Regards,
Li Wang

--000000000000dc9bdf05e8c16410
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Sep 15, 2022 at 10:19 PM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/=
kernel/syscalls/open/open04.c<br>
&gt; &gt; index d452405d4..01a8b12d6 100644<br>
&gt; &gt; --- a/testcases/kernel/syscalls/open/open04.c<br>
&gt; &gt; +++ b/testcases/kernel/syscalls/open/open04.c<br>
&gt; &gt; @@ -33,7 +33,12 @@ static void setup(void)<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0for (i =3D first + 1; i &lt; fds_limit; i++) {=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(fname, FNA=
ME &quot;.%d&quot;, i);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D SAFE_OPEN(fname,=
 O_RDWR | O_CREAT, 0777);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(fname, O_RD=
WR | O_CREAT, 0777);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd =3D=3D -1) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (errno !=3D EMFILE)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK, &quot;Expected EMFILE but =
got %d&quot;, errno);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fds[i - first] =3D=
 fd;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 }<br>
&gt; <br>
&gt; LGTM.<br>
&gt; Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=
=3D"_blank">pvorel@suse.cz</a>&gt;<br>
<br>
I faintly remmeber a similar patch where we decided not to work around<br>
for a test harness leaking filedescriptors into testcases.<br></blockquote>=
<div><br></div><div class=3D"gmail_default" style=3D"font-size:small">This =
also should be a solution, I searched the mailing list and got a patch[1].<=
/div><div class=3D"gmail_default" style=3D"font-size:small">Do you mean add=
ing that close-on-exec flag when opening fd in harness?</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">[1]=C2=A0<a href=3D"https://lists.linux.it/p=
ipermail/ltp/2020-November/019650.html">https://lists.linux.it/pipermail/lt=
p/2020-November/019650.html<br></a></div></div><div><br></div>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></di=
v><div>Li Wang<br></div></div></div></div>

--000000000000dc9bdf05e8c16410--


--===============1658332568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1658332568==--

