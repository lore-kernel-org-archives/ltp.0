Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE3CC433FE
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 03:20:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DD793CB0FC
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 05:20:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7A303CAC43
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 05:20:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B60D760091C
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 05:20:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666149637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F+ol5u9ZdvNyk24gArLqA2HHIckgYhrvcJAxapSl5O4=;
 b=eQhZYafrFAJsmJrKRs9e6joYW2dCwKAWKGWjPR7KA/bPVwZMI9jSpkBU2MBKb6wr/foSms
 6KjiLRYO4r+BbhySrjPXRyb+PoiPADhA3oSf4iGbXz1n684zUO4hx9NEFov5QLMcv238As
 4wSJjF3rX6k/Xew864Lw0ehye560FfY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-s9hRxK_TMpqnZZQteXpX8A-1; Tue, 18 Oct 2022 23:20:36 -0400
X-MC-Unique: s9hRxK_TMpqnZZQteXpX8A-1
Received: by mail-wm1-f71.google.com with SMTP id
 f7-20020a7bcd07000000b003c6e73579d3so8477845wmj.8
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 20:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F+ol5u9ZdvNyk24gArLqA2HHIckgYhrvcJAxapSl5O4=;
 b=zt2RbJ2jOc1qT1PeDIiVTQhb417hn0q9XWJsQq3GJKP1lZJwp0XzxxSKyXE0CAUe2i
 lkOqVyEBEJE2GFsck6Dj5kUk+Dn1SH9TsXC+DkCfhBovK76cqfoFMKP6Wu45mb3/DCKY
 BiChJddOlP7xxgNidnT/5x0vFhVl2ix2PxhJ5nKz0Wwe3BORf5G8YOlBUJ9UZsatjekW
 blmX8Ohq7NBNkvfI9wLZ9nFKQQt46PRIzqXTYkAitZQIxoN7e0TPFqmdD7ALvY5P3O/V
 BhdTot7vtb4+gj5Tooi7ETN73stBuVXB7SzBK5CIKUv5faZ+UOMwlSPpGgMcscgCogxN
 zyDA==
X-Gm-Message-State: ACrzQf0AxtbWNU6E/AMoiBy4CvVlLWCA6yZ1Q6nZ5FPqm1h0f2yylCSL
 FWPai0s+tpmhobcSFzMeau0YYoXyCHZq4VfvdXKljKL8xo/MXC9E2ygjztCFbn+n6AqraTA0ARg
 rh7Q/ARlLjRjn8c/P7omcZPeIkYE=
X-Received: by 2002:a05:600c:255:b0:3c6:e58d:354e with SMTP id
 21-20020a05600c025500b003c6e58d354emr3911118wmj.168.1666149632995; 
 Tue, 18 Oct 2022 20:20:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4IUJISguPgAe4m6/Clc0rxdQj3PP8PtvBe3As2Vo695DHTkLVc0QlCUSVb85mrxTJFV/MZlMJjtAQ0zjrDDTY=
X-Received: by 2002:a05:600c:255:b0:3c6:e58d:354e with SMTP id
 21-20020a05600c025500b003c6e58d354emr3911111wmj.168.1666149632779; Tue, 18
 Oct 2022 20:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221018152527.4636-1-rpalethorpe@suse.com>
 <20221018152527.4636-2-rpalethorpe@suse.com>
 <Y09Vf7XnoXeEcxJH@xpf.sh.intel.com>
 <CAEemH2f3jrhXj7x5p7XkcTwDf3M=DK0yOyt6kBHfknSzkXJSPQ@mail.gmail.com>
 <Y09r93VsOg5j2UcT@xpf.sh.intel.com>
In-Reply-To: <Y09r93VsOg5j2UcT@xpf.sh.intel.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Oct 2022 11:20:18 +0800
Message-ID: <CAEemH2cisVLayRJ6QW1kPYFwXmaQh8OoJb9h2pg_LU2vjFwP+w@mail.gmail.com>
To: Pengfei Xu <pengfei.xu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ptrace07: Fix compilation by avoiding
 aligned_alloc
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0274270480=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0274270480==
Content-Type: multipart/alternative; boundary="0000000000000140f805eb5ab13e"

--0000000000000140f805eb5ab13e
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 19, 2022 at 11:17 AM Pengfei Xu <pengfei.xu@intel.com> wrote:

> Hi Li Wang,
> On 2022-10-19 at 10:59:54 +0800, Li Wang wrote:
> > On Wed, Oct 19, 2022 at 9:40 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > > Hi Richard,
> > >
> > > On 2022-10-18 at 16:25:27 +0100, Richard Palethorpe wrote:
> > > > Use memalign instead because we live in the past.
> > > >
> > > > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > > > Cc: Pengfei Xu <pengfei.xu@intel.com>
> > > > ---
> > > >  testcases/kernel/syscalls/ptrace/ptrace07.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c
> > > b/testcases/kernel/syscalls/ptrace/ptrace07.c
> > > > index 6bd2b1062..a60c2a49e 100644
> > > > --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
> > > > +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> > > > @@ -35,6 +35,7 @@
> > > >  #include "config.h"
> > > >  #include "ptrace.h"
> > > >  #include "tst_test.h"
> > > > +#include "tst_safe_macros.h"
> > > >  #include "lapi/cpuid.h"
> > > >
> > > >  #ifndef PTRACE_GETREGSET
> > > > @@ -95,7 +96,7 @@ static void do_test(void)
> > > >        * of the XSAVE/XRSTOR save area) required by enabled features
> in
> > > XCR0.
> > > >        */
> > > >       __cpuid_count(CPUID_LEAF_XSTATE, ecx, eax, ebx, ecx, edx);
> > > > -     xstate = aligned_alloc(64, ebx);
> > > > +     xstate = SAFE_MEMALIGN(64, ebx);
> > > >       struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
> > > >       int status;
> > > >       bool okay;
> > >
> > > Yes, it's better for LTP compilation. Thanks for the patch!
> > >
> > > I checked SAFE_MEMALIGN(), it will verify that the buffer is NULL or
> not.
> > > "
> > >         rval = memalign(alignment, size);
> > >
> > >         if (rval == NULL) {
> > >                 tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> > >                         "memalign() failed");
> > >         }
> > > "
> > > So could you remove below unnecessary lines in ptrace07.c, thanks.
> > >
> >
> > I helped modify this and pushed it, thanks!
>   Great, thanks!
>   I tried that "SAFE_MEMALIGN(64, ebx);" modification in ptrace07.
>   Ptrace07 works well and passed in previous reproduced server.
>

Cool~ thanks for your feedback.

-- 
Regards,
Li Wang

--0000000000000140f805eb5ab13e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Oct 19, 2022 at 11:17 AM Pengfei Xu &lt;<a =
href=3D"mailto:pengfei.xu@intel.com">pengfei.xu@intel.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li Wang,<br>
On 2022-10-19 at 10:59:54 +0800, Li Wang wrote:<br>
&gt; On Wed, Oct 19, 2022 at 9:40 AM Pengfei Xu &lt;<a href=3D"mailto:pengf=
ei.xu@intel.com" target=3D"_blank">pengfei.xu@intel.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi Richard,<br>
&gt; &gt;<br>
&gt; &gt; On 2022-10-18 at 16:25:27 +0100, Richard Palethorpe wrote:<br>
&gt; &gt; &gt; Use memalign instead because we live in the past.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpal=
ethorpe@suse.com" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
&gt; &gt; &gt; Cc: Pengfei Xu &lt;<a href=3D"mailto:pengfei.xu@intel.com" t=
arget=3D"_blank">pengfei.xu@intel.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 testcases/kernel/syscalls/ptrace/ptrace07.c | 3 ++-<br=
>
&gt; &gt; &gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c<br>
&gt; &gt; b/testcases/kernel/syscalls/ptrace/ptrace07.c<br>
&gt; &gt; &gt; index 6bd2b1062..a60c2a49e 100644<br>
&gt; &gt; &gt; --- a/testcases/kernel/syscalls/ptrace/ptrace07.c<br>
&gt; &gt; &gt; +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c<br>
&gt; &gt; &gt; @@ -35,6 +35,7 @@<br>
&gt; &gt; &gt;=C2=A0 #include &quot;config.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;ptrace.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;tst_test.h&quot;<br>
&gt; &gt; &gt; +#include &quot;tst_safe_macros.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;lapi/cpuid.h&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #ifndef PTRACE_GETREGSET<br>
&gt; &gt; &gt; @@ -95,7 +96,7 @@ static void do_test(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * of the XSAVE/XRSTOR save area) =
required by enabled features in<br>
&gt; &gt; XCR0.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__cpuid_count(CPUID_LEAF_XSTATE, e=
cx, eax, ebx, ecx, edx);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0xstate =3D aligned_alloc(64, ebx);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0xstate =3D SAFE_MEMALIGN(64, ebx);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovec iov =3D { .iov_base =
=3D xstate, .iov_len =3D ebx };<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool okay;<br>
&gt; &gt;<br>
&gt; &gt; Yes, it&#39;s better for LTP compilation. Thanks for the patch!<b=
r>
&gt; &gt;<br>
&gt; &gt; I checked SAFE_MEMALIGN(), it will verify that the buffer is NULL=
 or not.<br>
&gt; &gt; &quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rval =3D memalign(alignment, siz=
e);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rval =3D=3D NULL) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_=
brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;memalign() failed&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &quot;<br>
&gt; &gt; So could you remove below unnecessary lines in ptrace07.c, thanks=
.<br>
&gt; &gt;<br>
&gt; <br>
&gt; I helped modify this and pushed it, thanks!<br>
=C2=A0 Great, thanks!<br>
=C2=A0 I tried that &quot;SAFE_MEMALIGN(64, ebx);&quot; modification in ptr=
ace07.<br>
=C2=A0 Ptrace07 works well and passed in previous reproduced server.<br></b=
lockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:sm=
all">Cool~ thanks for your feedback.</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"></div></div><div><br></div>-- <br><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wan=
g<br></div></div></div></div>

--0000000000000140f805eb5ab13e--


--===============0274270480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0274270480==--

