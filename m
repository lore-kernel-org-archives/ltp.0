Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B04C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 05:53:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B7323CB16A
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 07:53:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9382E3CB14D
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 07:52:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DA0BB60064B
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 07:52:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666245164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Hd1t5i6o/sdFcY9CXPVgs1a5E5ivyfGk7N+mrYdflU=;
 b=WmvxNnwG8II90i4exsCCRFnkGy3fN8hTAVoMi4mzeSmZWJ+NieBxfmXOFvxxddAQekjwq0
 YTl9VNrfB+2xhaey3bQVmCYKnTpxLzQGZpm3F7DTDgNN+yUOFsB2GgZhExPvY7JDtKu1hu
 Jhg71iRp/gDJ42H0jvghTTP++/TNPI0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-93mKPJRzMWGyjz0rryCltA-1; Thu, 20 Oct 2022 01:52:43 -0400
X-MC-Unique: 93mKPJRzMWGyjz0rryCltA-1
Received: by mail-oo1-f72.google.com with SMTP id
 a29-20020a4a9b1d000000b00480db71d44bso3599861ook.7
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 22:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Hd1t5i6o/sdFcY9CXPVgs1a5E5ivyfGk7N+mrYdflU=;
 b=0Ij4iKtHOtJyA1SbI0zDjD8SlLGFZ8SuPg5ghJL3EQDC+l+2JVJq5eu4WXIX65scng
 Evv9fS6fKSGWGsTWx8Bct8LWmepq1X3sHZQGxZz5ykfsDlVPkzywysd8je8FGfQEo5yg
 uJaxM+T3nBppSbr9rfSdAAuQBsWD41SIAQHwvBuc7lm6LwHETLxC34e4NckTzGivROeu
 HzrSmQotEVWlEHDMCKueDDGaMhcnDaovGoo1eJRIiKHRlDDsDwQuoWPiLu/o4e8hs4Em
 seDIBInbnt0pC7gslD0Ao8F+LzIjgEyFCtujkssP1iNNuFY7cC74xPLk1dxfO+LR7jw0
 Vg7w==
X-Gm-Message-State: ACrzQf1gLxTn1W5wNVeThoCPgCalQnM4ZYmccb4INOnH6kWn3aXfOrHO
 Cq+BP4s0OEqFSP7/NWShuNHLofGzFbmEUPYGYkoJ2D/lpxhhh9cBFI0MAM/XBoF/IUWSdzlOmhY
 bIt4DBEZNCvfgcBkIoFTSN7i3xnA=
X-Received: by 2002:a9d:12a6:0:b0:661:d26c:708c with SMTP id
 g35-20020a9d12a6000000b00661d26c708cmr6021065otg.160.1666245160179; 
 Wed, 19 Oct 2022 22:52:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6oSmxavA/xW9ij+xuaHbOaj+cBmXM/JVOgj9HRGNG3UcHDm7T3LC8QTzS552ar6FcjC2eXfE6M6Z9rTN4rCt8=
X-Received: by 2002:a9d:12a6:0:b0:661:d26c:708c with SMTP id
 g35-20020a9d12a6000000b00661d26c708cmr6021052otg.160.1666245159896; Wed, 19
 Oct 2022 22:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221020034140.3472638-1-liwang@redhat.com>
 <7f283a53-2710-d721-dc11-5ca1c5d1aa06@fujitsu.com>
In-Reply-To: <7f283a53-2710-d721-dc11-5ca1c5d1aa06@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 13:52:26 +0800
Message-ID: <CAEemH2fru9haqdSa++jcMU7U3XwgBsvjHpcTQ3mksnsn7=igwA@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kconfig: adding new config path
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
Cc: Brian Grech <bgrech@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0896928000=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0896928000==
Content-Type: multipart/alternative; boundary="000000000000dd687105eb70ee93"

--000000000000dd687105eb70ee93
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 20, 2022 at 12:02 PM xuyang2018.jy@fujitsu.com <
xuyang2018.jy@fujitsu.com> wrote:

> Hi Li
>
> > To make kconfig parsing on RHIVOS(Red Hat In-Vehicle Operating System)
> correctly.
> >
> > Before:
> >    # ./sendto03
> >    tst_kconfig.c:65: TINFO: Couldn't locate kernel config!
> >    tst_kconfig.c:201: TBROK: Cannot parse kernel .config
> >
> > After:
> >    # ./sendto03
> >    tst_kconfig.c:88: TINFO: Parsing kernel config
> '/lib/modules/5.14.0-174.137.el9iv.aarch64/config'
> >    tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> >    sendto03.c:91: TPASS: setsockopt(PACKET_RESERVE) value is capped:
> EINVAL (22)
> >    sendto03.c:197: TPASS: Nothing bad happened, probably
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Brian Grech <bgrech@redhat.com>
> > ---
> >   lib/tst_kconfig.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> > index ac13866e8..a97489564 100644
> > --- a/lib/tst_kconfig.c
> > +++ b/lib/tst_kconfig.c
> > @@ -47,6 +47,12 @@ static const char *kconfig_path(char *path_buf,
> size_t path_buf_len)
> >       /* Common install module path */
> >       snprintf(path_buf, path_buf_len, "/lib/modules/%s/build/.config",
> un.release);
> >
> > +     if (!access(path_buf, F_OK))
> > +             return path_buf;
> > +
> > +     /* RHIVOS config path */
> > +     snprintf(path_buf, path_buf_len, "/lib/modules/%s/config",
> un.release);
> This kconfig path is also common, so
> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>

Thanks!


> ps: I guess  RHIVOS doesn't have kconfig file in /boot directory, so it
> can't be parsed. Is it right?
>

That's right. And I would leave this patch one more day for others to
review.

-- 
Regards,
Li Wang

--000000000000dd687105eb70ee93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Oct 20, 2022 at 12:02 PM <a href=3D"mailto:=
xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a> &lt;<a href=3D"mai=
lto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li<br>
<br>
&gt; To make kconfig parsing on RHIVOS(Red Hat In-Vehicle Operating System)=
 correctly.<br>
&gt; <br>
&gt; Before:<br>
&gt;=C2=A0 =C2=A0 # ./sendto03<br>
&gt;=C2=A0 =C2=A0 tst_kconfig.c:65: TINFO: Couldn&#39;t locate kernel confi=
g!<br>
&gt;=C2=A0 =C2=A0 tst_kconfig.c:201: TBROK: Cannot parse kernel .config<br>
&gt; <br>
&gt; After:<br>
&gt;=C2=A0 =C2=A0 # ./sendto03<br>
&gt;=C2=A0 =C2=A0 tst_kconfig.c:88: TINFO: Parsing kernel config &#39;/lib/=
modules/5.14.0-174.137.el9iv.aarch64/config&#39;<br>
&gt;=C2=A0 =C2=A0 tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s<br>
&gt;=C2=A0 =C2=A0 sendto03.c:91: TPASS: setsockopt(PACKET_RESERVE) value is=
 capped: EINVAL (22)<br>
&gt;=C2=A0 =C2=A0 sendto03.c:197: TPASS: Nothing bad happened, probably<br>
&gt; <br>
&gt; Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a>&gt;<br>
&gt; Cc: Brian Grech &lt;<a href=3D"mailto:bgrech@redhat.com" target=3D"_bl=
ank">bgrech@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/tst_kconfig.c | 6 ++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c<br>
&gt; index ac13866e8..a97489564 100644<br>
&gt; --- a/lib/tst_kconfig.c<br>
&gt; +++ b/lib/tst_kconfig.c<br>
&gt; @@ -47,6 +47,12 @@ static const char *kconfig_path(char *path_buf, siz=
e_t path_buf_len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Common install module path */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(path_buf, path_buf_len, &quot;/lib/=
modules/%s/build/.config&quot;, un.release);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!access(path_buf, F_OK))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return path_buf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* RHIVOS config path */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0snprintf(path_buf, path_buf_len, &quot;/lib/modul=
es/%s/config&quot;, un.release);<br>
This kconfig path is also common, so<br>
Reviewed-by: Yang Xu &lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com" targe=
t=3D"_blank">xuyang2018.jy@fujitsu.com</a>&gt;<br></blockquote><div><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">Thanks!</div><div=
 class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"=
gmail_default" style=3D"font-size:small"></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
ps: I guess=C2=A0 RHIVOS doesn&#39;t have kconfig file in /boot directory, =
so it <br>
can&#39;t be parsed. Is it right?<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">That&#39;s right. And I would =
leave this patch one more day for others to review.</div></div><div><br></d=
iv>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000dd687105eb70ee93--


--===============0896928000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0896928000==--

