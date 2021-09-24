Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D3C433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:28:18 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7906261107
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7906261107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE4B23C8F4C
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 12:28:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEE563C8F1A
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:28:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D21E5602132
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632479284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxMSACbFEVprse/i7kI1yu+QtHbIHJYkf97z9BlWtrw=;
 b=W2xGJT0f8VNDewYDbQK8ms9rmpQRo4f0ZnBV2YoMeU/5G0V1kZTy22sxgRX3Ymc/5xMEvw
 7c0uQhMQrHHMr43hGfe9a70aIKdxlsfIaRXHEuF0iaFNOatmRo03EyjvQ2hjm2wcgnZUEx
 eAjQb1cO0J3qHrDV0HrPmQJnBEooBec=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-C4ff092OONylgG8S2x1guA-1; Fri, 24 Sep 2021 06:28:02 -0400
X-MC-Unique: C4ff092OONylgG8S2x1guA-1
Received: by mail-yb1-f197.google.com with SMTP id
 k15-20020a25240f000000b0059efafc5a58so2849389ybk.11
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 03:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cxMSACbFEVprse/i7kI1yu+QtHbIHJYkf97z9BlWtrw=;
 b=npX5iqVeMezlvkzFyMH0yyWm+uzbcWG3p8NaGnpH2NuQ4rk2Tx61SEKXfcYWvNBIlH
 /m+0YolsmD7n+FHAsNPjMMM6b+HE1sdEd+S1tzwvnXmh6fwIweXIK+WezA2Bf5XBxmas
 eln/CNc+5itzbnnhbdN/WZb3DjY65m6atEXdhtO7wRlObHa+FSDCt25uppmPloa9B310
 mYZJ8SijoYe6o8czhi+eERrM+zKbspmbBF/HkwyojOkmZzmkNFk2b7ouytIofIAFKvEJ
 RMet5st07eI7L7cMlm2ZwU3eeQ9w4RyUkDwNhllOlfkq6fnbJAauS62jOKz/pJHfVvcJ
 E8+g==
X-Gm-Message-State: AOAM5314ArseVLTwz8nryrgncEH3x8NYhAr2+LHWsmxBKDAj2/Ur/qCj
 umPVolhe8RgXvnlKy8a/s0/aczcFqWpy9cTktTXl73dcVhSbfM9Dps/sZXtreiMRiieHwdqGCgU
 ep+nb+3YtC/0ccI4pXclI7BAYrLg=
X-Received: by 2002:a25:2455:: with SMTP id k82mr11174420ybk.186.1632479282211; 
 Fri, 24 Sep 2021 03:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTFu3xRFZTaeJP4Qe0fGQOdpwzGmROrJ/WhrqR3DjHajKwceSGsouKeuSXmGkKbYa8JXTETox614Kp+31/+5A=
X-Received: by 2002:a25:2455:: with SMTP id k82mr11174404ybk.186.1632479281982; 
 Fri, 24 Sep 2021 03:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210924070756.3916953-1-liwang@redhat.com>
 <20210924070756.3916953-3-liwang@redhat.com>
 <YU2foq6v5PUBNUeD@yuki>
In-Reply-To: <YU2foq6v5PUBNUeD@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 24 Sep 2021 18:27:49 +0800
Message-ID: <CAEemH2d7YtS9wGa80uN2w1-p51S0ThPohV972cMHsbjX7a8MQw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] lib: unlimit the tmpfs size when test on
 small systems
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
Content-Type: multipart/mixed; boundary="===============0737397775=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0737397775==
Content-Type: multipart/alternative; boundary="000000000000b4c4b805ccbb3332"

--000000000000b4c4b805ccbb3332
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 24, 2021 at 5:51 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Since commit c305a53c5 (lib: limit the size of tmpfs in LTP, Jul 9)
> > Ltp set tmpfs mount size according to the tdev.size. This cause a
> > new problem on small RAM system, which consume too much memory and
> > finally trigger OOM.
> >
> > To fix this, let's cancel the tmpfs size limitation when MemAvailable
> > is less than twofold of tdev.size.
> >
> > Reported-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  include/tst_test.h | 1 +
> >  lib/tst_test.c     | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index 5e3619698..3dcb45de0 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -42,6 +42,7 @@
> >  #include "tst_lockdown.h"
> >  #include "tst_fips.h"
> >  #include "tst_taint.h"
> > +#include "tst_memutils.h"
> >
> >  /*
> >   * Reports testcase result.
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 4224353da..b50856f20 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -895,6 +895,9 @@ static const char *limit_tmpfs_mount_size(const char
> *mnt_data,
> >       if (strcmp(fs_type, "tmpfs"))
> >               return mnt_data;
> >
> > +     if ((tst_available_mem() / 1024) < (tdev.size * 2))
> > +             return mnt_data;
>
> I'm starting to think that we should do it the other way around, i.e.
>
> - unless the test defines .min_dev_size we should set the size for tmpfs
> to be really small 16MB or 32MB
> - if .min_dev_size is defined and there is not enough free memory -> TCONF
> - if .min_dev_size is not set and there is not even 64MB of free memory
> (for 32MB limit) -> TCONF
>

Agree, this is a cogitative handle way.
At least better than unlimit the tmpfs-size roughly when AvailableMem is
short.



> I think that this is going to work because most of the tests does not
> actually consume more than a megabyte or so of the disk space for the
> actuall test, the only reason why we kept bumping the loop device size
> is that there are limits on minimal size imposed by filesystems.
>

+1 Indeed.

Patch V2 is on the way...

-- 
Regards,
Li Wang

--000000000000b4c4b805ccbb3332
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 24, 2021 at 5:51 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Since commit c305a53c5 (lib: limit the size of tmpfs in LTP, Jul 9)<br=
>
&gt; Ltp set tmpfs mount size according to the tdev.size. This cause a<br>
&gt; new problem on small RAM system, which consume too much memory and<br>
&gt; finally trigger OOM.<br>
&gt; <br>
&gt; To fix this, let&#39;s cancel the tmpfs size limitation when MemAvaila=
ble<br>
&gt; is less than twofold of tdev.size.<br>
&gt; <br>
&gt; Reported-by: Ralph Siemsen &lt;<a href=3D"mailto:ralph.siemsen@linaro.=
org" target=3D"_blank">ralph.siemsen@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/tst_test.h | 1 +<br>
&gt;=C2=A0 lib/tst_test.c=C2=A0 =C2=A0 =C2=A0| 3 +++<br>
&gt;=C2=A0 2 files changed, 4 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/tst_test.h b/include/tst_test.h<br>
&gt; index 5e3619698..3dcb45de0 100644<br>
&gt; --- a/include/tst_test.h<br>
&gt; +++ b/include/tst_test.h<br>
&gt; @@ -42,6 +42,7 @@<br>
&gt;=C2=A0 #include &quot;tst_lockdown.h&quot;<br>
&gt;=C2=A0 #include &quot;tst_fips.h&quot;<br>
&gt;=C2=A0 #include &quot;tst_taint.h&quot;<br>
&gt; +#include &quot;tst_memutils.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Reports testcase result.<br>
&gt; diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
&gt; index 4224353da..b50856f20 100644<br>
&gt; --- a/lib/tst_test.c<br>
&gt; +++ b/lib/tst_test.c<br>
&gt; @@ -895,6 +895,9 @@ static const char *limit_tmpfs_mount_size(const ch=
ar *mnt_data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(fs_type, &quot;tmpfs&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return mnt_data;=
<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((tst_available_mem() / 1024) &lt; (tdev.size =
* 2))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return mnt_data;<br>
<br>
I&#39;m starting to think that we should do it the other way around, i.e.<b=
r>
<br>
<span class=3D"gmail_default" style=3D"font-size:small"></span>- unless the=
 test defines .min_dev_size we should set the size for tmpfs to be really s=
mall 16MB or 32MB<br>
- if .min_dev_size is defined and <span class=3D"gmail_default" style=3D"fo=
nt-size:small"></span>there is not enough free memory -&gt; TCONF<br>
- if .min_dev_size is not set and there is not even 64MB of free memory (fo=
r 32MB limit) -&gt; TCONF<br></blockquote><div><br></div><div><div class=3D=
"gmail_default" style=3D"font-size:small">Agree, this is a=C2=A0cogitative =
handle way.=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">At least better than unlimit the tmpfs-size roughly when AvailableMem is=
 short.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></d=
iv></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I think that this is going to work because most of the tests does not<br>
actually consume more than a megabyte or so of the disk space for the<br>
actuall test, the only reason why we kept bumping the loop device size<br>
is that there are limits on minimal size imposed by filesystems.<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">+1 Indeed.</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Patch V2=
 is on the way...</div></div></div><div><br></div>-- <br><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wa=
ng<br></div></div></div></div>

--000000000000b4c4b805ccbb3332--


--===============0737397775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0737397775==--

