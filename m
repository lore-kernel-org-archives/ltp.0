Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98836C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 09:36:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54C7C3C9364
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 10:36:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3B773C91FC
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 10:36:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9CB4600837
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 10:36:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647423360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pdyaNHD3PD9JqPCrcKsweu4kS7zxb9LpW5HKAhnUPZM=;
 b=EiU6mNJ84gLYtB9H6U1Kl8HmQp+UAdnibvUBDhkchUPkJ772qQhPj/6/krcm6q1kI1L5Rp
 xiByM6T1foJtW8CPIzoXSuqA/s6+r7Cm5tCkcvNveYVpijKkUqCYG1HD5q7xDbcmpyaGJi
 SxXhvbbmSeWoe8nYz3GF8Zv2mPlob2s=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-JXQZAL1wMC6yKEFU6U5yyw-1; Wed, 16 Mar 2022 05:35:58 -0400
X-MC-Unique: JXQZAL1wMC6yKEFU6U5yyw-1
Received: by mail-yb1-f198.google.com with SMTP id
 g2-20020a5b0242000000b0062892750241so1539407ybp.23
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 02:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pdyaNHD3PD9JqPCrcKsweu4kS7zxb9LpW5HKAhnUPZM=;
 b=0Ij3p3MOXu+klbDwjImW3rjAADxOpwf+ffRHVVuDjEiD9ciX5eb9fRpr5o7gAJGZVx
 wQb0pj2JDp2uA+rk+sBK26dP8Hgra5HK1hUWiFiQgxhJVjF3KlRbvV4mm+rE/3iW/mUp
 Ksbxg6Ofyt27DvnclvaapG1AG2bSY1p5qYiPFnMBR1Ww+pDbp9MHLErEc2FoO86dgIP9
 FOo/BYojaTogNWJpH+6aadOiqWCMQQjJ2byIj4GJzqW7MKytZa/fx5P3wMmepQywMNs3
 +zadr/9MsuVqtHP7xsorPWlSjgJd4AGx3VxqcgLkdhkMTFqlcBozL0kBhiWDvcepyYAo
 2S5g==
X-Gm-Message-State: AOAM533Qno7hE8M/P7IFsm2oICXwv/MHceRefLipB5Cy6Bfp0AiaKVcs
 hXuhxDrW9K+bzalmP9ozud1Pk7KF0rs9+d9W9xNKcL0Qgi0NOxQiRBcKF7zKCRKWFcHAc+tw2vu
 xNCq0BUfQtrJ3zwXr9xJxLU6bBWo=
X-Received: by 2002:a25:1344:0:b0:633:7592:9c0f with SMTP id
 65-20020a251344000000b0063375929c0fmr7591733ybt.211.1647423358403; 
 Wed, 16 Mar 2022 02:35:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvhEbVKObiPM7stQazr1jprhtQYLR6FZGlMj3PILuqzEwceTWZC4qIZP2Um/vR+Otm8xEls+eDJtSEuiDSqKg=
X-Received: by 2002:a25:1344:0:b0:633:7592:9c0f with SMTP id
 65-20020a251344000000b0063375929c0fmr7591719ybt.211.1647423358152; Wed, 16
 Mar 2022 02:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <4384f778b2664a0ceb561c0b3eac7be42e7cd269.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <87pmmym25m.fsf@suse.de>
In-Reply-To: <87pmmym25m.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Mar 2022 17:35:46 +0800
Message-ID: <CAEemH2dNxKFknG4-Whf8iPC_qBtL9Qvye=m-Fr-_4KH1Sf_YvQ@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 05/16] API/cgroup: Add more controllers to
 tst_cgroup
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
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: multipart/mixed; boundary="===============0390914922=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0390914922==
Content-Type: multipart/alternative; boundary="0000000000000ec52c05da52a445"

--0000000000000ec52c05da52a445
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:



> > --- a/lib/tst_cgroup.c
> > +++ b/lib/tst_cgroup.c
> > @@ -83,8 +83,19 @@ enum cgroup_ctrl_indx {
> >       CTRL_MEMORY = 1,
> >       CTRL_CPU,
> >       CTRL_CPUSET,
> > +     CTRL_IO,
> > +     CTRL_PIDS,
> > +     CTRL_HUGETLB,
> > +     CTRL_CPUACCT,
> > +     CTRL_DEVICES,
> > +     CTRL_FREEZER,
> > +     CTRL_NETCLS,
> > +     CTRL_NETPRIO,
> > +     CTRL_BLKIO,
> > +     CTRL_MISC,
> > +     CTRL_PERFEVENT
>
> I think we need the debug controller as cgroup_fj_function is called
> with that in runtest/controllers.
>

+1

-- 
Regards,
Li Wang

--0000000000000ec52c05da52a445
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de"=
>rpalethorpe@suse.de</a>&gt; wrote:<br></div></div><div class=3D"gmail_quot=
e"><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; --- a/lib/tst_cgroup.c<br>
&gt; +++ b/lib/tst_cgroup.c<br>
&gt; @@ -83,8 +83,19 @@ enum cgroup_ctrl_indx {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CTRL_MEMORY =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CTRL_CPU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CTRL_CPUSET,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_IO,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_PIDS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_HUGETLB,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_CPUACCT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_DEVICES,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_FREEZER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_NETCLS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_NETPRIO,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_BLKIO,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_MISC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CTRL_PERFEVENT<br>
<br>
I think we need the debug controller as cgroup_fj_function is called<br>
with that in runtest/controllers.<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">+1</div></div><div><br></div>-=
- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Rega=
rds,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000000ec52c05da52a445--


--===============0390914922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0390914922==--

