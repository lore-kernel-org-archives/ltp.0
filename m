Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04733C4332F
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 03:00:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C30E3CB0ED
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 05:00:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC4C53CAC43
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 05:00:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A6F12600A4D
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 05:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666148412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t1QgIp7WuhISQl7cByTduolMEMpyCaUcWYv8v8xkv4Y=;
 b=EHn+zdR+i94GRSWpU78b70eZIrzR6GI5LlEilNlR2iDn5BiGR7XjMhsfSOP09v+ANINDeb
 QxURYdB0qCg336+qAK0U0L2JpJV3fKmG0a4kLno61kEmYFXl8AjXViDAO2iexSe9zGpLLC
 n8Bez5i0wk+Xra4HSLFef14GH5NjlSM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-xxmynI9WMYCtABkar04VmA-1; Tue, 18 Oct 2022 23:00:10 -0400
X-MC-Unique: xxmynI9WMYCtABkar04VmA-1
Received: by mail-wm1-f70.google.com with SMTP id
 r81-20020a1c4454000000b003c41e9ae97dso12222559wma.6
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 20:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t1QgIp7WuhISQl7cByTduolMEMpyCaUcWYv8v8xkv4Y=;
 b=8GdRVJw/oHi/NCy9Ucub61lxo+arL9DMYp+lPOOQIUMXsai0sic9SCYHN6J06TR5oz
 V0QOFfLAJFyxJSKUj7dbZY1sS9fWZW5UdH6fYLCKH6w8283Qla5rZQZ3x2TF/jCbObbs
 hfjDjxxNa+1vrRKjUstIpQN/OR2K72SgWpHQzjszPEpTzS0oA1tFUznmCS6YPhBTEJnd
 LmfbMGLTzn2YQYrITFzF3eLskxl7oWVnrNMIACEoNfUlJsbQOsB9YLHU9eJ61XtxVAqW
 y7VG8OxvIAHx14oRtG00m7wm0rJwQlmeKnJFGWg/Aw9bt4l0IHHzvZmJyAIxgV7zTJmU
 6zxA==
X-Gm-Message-State: ACrzQf3H2DTp8n7CgdDQKrmGB6Jk8UIbEuHBSSmbY6skXMf0XsNeUX2J
 7nH6iOBl5sx6rpUsPbwMRXHBPwlb1iXr/gaHnmZLe5VjKUxt5W2XaxEKcTiMVVOq4k84k1buZNe
 9AHyb1n5aEUMvXEQHGbAolwr+MS8=
X-Received: by 2002:a05:6000:912:b0:230:9113:1a09 with SMTP id
 bz18-20020a056000091200b0023091131a09mr3542902wrb.707.1666148409107; 
 Tue, 18 Oct 2022 20:00:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7cZRrS7CF2cEcN7ymLj+mbcRmo+InagSvq3pGc9keXMmZAavhkDrvPqPhCpupOOnOe840YdRS/jZPgv03S/0w=
X-Received: by 2002:a05:6000:912:b0:230:9113:1a09 with SMTP id
 bz18-20020a056000091200b0023091131a09mr3542888wrb.707.1666148408834; Tue, 18
 Oct 2022 20:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221018152527.4636-1-rpalethorpe@suse.com>
 <20221018152527.4636-2-rpalethorpe@suse.com>
 <Y09Vf7XnoXeEcxJH@xpf.sh.intel.com>
In-Reply-To: <Y09Vf7XnoXeEcxJH@xpf.sh.intel.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Oct 2022 10:59:54 +0800
Message-ID: <CAEemH2f3jrhXj7x5p7XkcTwDf3M=DK0yOyt6kBHfknSzkXJSPQ@mail.gmail.com>
To: Pengfei Xu <pengfei.xu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0607681077=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0607681077==
Content-Type: multipart/alternative; boundary="0000000000000d55b705eb5a68f4"

--0000000000000d55b705eb5a68f4
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 19, 2022 at 9:40 AM Pengfei Xu <pengfei.xu@intel.com> wrote:

> Hi Richard,
>
> On 2022-10-18 at 16:25:27 +0100, Richard Palethorpe wrote:
> > Use memalign instead because we live in the past.
> >
> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > Cc: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> >  testcases/kernel/syscalls/ptrace/ptrace07.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c
> b/testcases/kernel/syscalls/ptrace/ptrace07.c
> > index 6bd2b1062..a60c2a49e 100644
> > --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
> > +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> > @@ -35,6 +35,7 @@
> >  #include "config.h"
> >  #include "ptrace.h"
> >  #include "tst_test.h"
> > +#include "tst_safe_macros.h"
> >  #include "lapi/cpuid.h"
> >
> >  #ifndef PTRACE_GETREGSET
> > @@ -95,7 +96,7 @@ static void do_test(void)
> >        * of the XSAVE/XRSTOR save area) required by enabled features in
> XCR0.
> >        */
> >       __cpuid_count(CPUID_LEAF_XSTATE, ecx, eax, ebx, ecx, edx);
> > -     xstate = aligned_alloc(64, ebx);
> > +     xstate = SAFE_MEMALIGN(64, ebx);
> >       struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
> >       int status;
> >       bool okay;
>
> Yes, it's better for LTP compilation. Thanks for the patch!
>
> I checked SAFE_MEMALIGN(), it will verify that the buffer is NULL or not.
> "
>         rval = memalign(alignment, size);
>
>         if (rval == NULL) {
>                 tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
>                         "memalign() failed");
>         }
> "
> So could you remove below unnecessary lines in ptrace07.c, thanks.
>

I helped modify this and pushed it, thanks!

-- 
Regards,
Li Wang

--0000000000000d55b705eb5a68f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Oct 19, 2022 at 9:40 AM Pengfei Xu &lt;<a h=
ref=3D"mailto:pengfei.xu@intel.com">pengfei.xu@intel.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Richard,<br>
<br>
On 2022-10-18 at 16:25:27 +0100, Richard Palethorpe wrote:<br>
&gt; Use memalign instead because we live in the past.<br>
&gt; <br>
&gt; Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@su=
se.com" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
&gt; Cc: Pengfei Xu &lt;<a href=3D"mailto:pengfei.xu@intel.com" target=3D"_=
blank">pengfei.xu@intel.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 testcases/kernel/syscalls/ptrace/ptrace07.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/k=
ernel/syscalls/ptrace/ptrace07.c<br>
&gt; index 6bd2b1062..a60c2a49e 100644<br>
&gt; --- a/testcases/kernel/syscalls/ptrace/ptrace07.c<br>
&gt; +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c<br>
&gt; @@ -35,6 +35,7 @@<br>
&gt;=C2=A0 #include &quot;config.h&quot;<br>
&gt;=C2=A0 #include &quot;ptrace.h&quot;<br>
&gt;=C2=A0 #include &quot;tst_test.h&quot;<br>
&gt; +#include &quot;tst_safe_macros.h&quot;<br>
&gt;=C2=A0 #include &quot;lapi/cpuid.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #ifndef PTRACE_GETREGSET<br>
&gt; @@ -95,7 +96,7 @@ static void do_test(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * of the XSAVE/XRSTOR save area) required b=
y enabled features in XCR0.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__cpuid_count(CPUID_LEAF_XSTATE, ecx, eax, e=
bx, ecx, edx);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0xstate =3D aligned_alloc(64, ebx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0xstate =3D SAFE_MEMALIGN(64, ebx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovec iov =3D { .iov_base =3D xstate,=
 .iov_len =3D ebx };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool okay;<br>
<br>
Yes, it&#39;s better for LTP compilation. Thanks for the patch!<br>
<br>
I checked SAFE_MEMALIGN(), it will verify that the buffer is NULL or not.<b=
r>
&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rval =3D memalign(alignment, size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rval =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brkm_(file, lin=
eno, TBROK | TERRNO, cleanup_fn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;memalign() failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&quot;<br>
So could you remove below unnecessary lines in ptrace07.c, thanks.<br></blo=
ckquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l">I helped modify this and pushed it, thanks!</div></div><div><br></div>--=
 <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regar=
ds,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000000d55b705eb5a68f4--


--===============0607681077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0607681077==--

