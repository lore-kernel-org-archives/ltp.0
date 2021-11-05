Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3086C433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 13:24:29 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B177A6112D
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 13:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B177A6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 355483C739C
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 14:24:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9C623C7350
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 14:24:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CA48140077A
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 14:24:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636118652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99kJgHC2kYPhxF9aECCeS5f8a0yihFvUgAXAgLqE4hs=;
 b=Oe2YY4cC5q59Uvr0Qpqe1tKP3+Zhs5xsUrOf50LK+4+/IzouhaF8nv04aTKf3LTUEV7wKm
 13Qw29HtFnhE5GKvWVx/UrObtQhI9xE4XuQdv7w20Z9zc4qzARMcsKWVJcXfdr34gIT1uf
 nglh2mQGKsay54pHDzotarJhwdEftQs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-JjfPJTDpMx-NBqXAkfQFyA-1; Fri, 05 Nov 2021 09:24:10 -0400
X-MC-Unique: JjfPJTDpMx-NBqXAkfQFyA-1
Received: by mail-yb1-f200.google.com with SMTP id
 d27-20020a25addb000000b005c2355d9052so13426837ybe.3
 for <ltp@lists.linux.it>; Fri, 05 Nov 2021 06:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b/WI+/ZqeXsEW2aY+p47ipaZEeau/UiZaFvDKU+eDo0=;
 b=fsF+JSGfnaMMh223NHuBoCRGtIOoHhUKP6AYnsvME64NXuCENr6gBP93cx5/BhV+sr
 4UklJyMOICuFBvyuWATcNZsgDBuwuYpnt4p5Vmz3Tw+pDcmok9WIKmfXm4Ysm1adwELR
 xyc+nk61Nqk/7pTIAi0AUWaBgBgf3oHwsTEm6Edi3r2OxFNlVeIkTpgZFx9KiBM9gUt3
 w5wp6rSMj6gzLUZ6jwXm3AOiYf9joaxfIm2111+JxU7jjFJXcXN8BMmj9jJr/ZhKPjwY
 4xW76DWV5qwl7ForqOIl7nDFKtauIp5Lom16lQSHIhhQohuduSTGuMKV8gqm4GFoPkV+
 pJNQ==
X-Gm-Message-State: AOAM530upHgDxomE781JL92r+VCot0l1cdHYcn04UCdl/FVUfnBgxqHL
 uIvVODCnqCmXA9h4bhOjOx5ap15NjuDh8FIrLhAzr7TqnJg76ueGHqTbIm/xKS1vc+DNAaiAi2s
 IEjPisvXL8q6lixk6HaOtzWB3D90=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr43332492ybt.302.1636118649414; 
 Fri, 05 Nov 2021 06:24:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEdAcfYqVKPiyaZV5C5gQwZbHXk+BxKwmnifflmgKKbqJPULZ0Ijaxb8HnIPwP0wiXo5dDC+FD0UzoZYH6EoU=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr43332462ybt.302.1636118649168; 
 Fri, 05 Nov 2021 06:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190615042048.29839-1-liwang@redhat.com> <877ddpo35n.fsf@suse.de>
 <CAEemH2fDxJ1xQ9qNejHDxv0p_Cx2cq5LsXTesuhAEBrDe43Hmg@mail.gmail.com>
 <YYKYR4kspdlXuoDB@yuki>
 <CAEemH2e4sp_CYbAF05EA80Y1ggVG6yjRFp=-4EOudGBjTh7Wkg@mail.gmail.com>
 <YYO1WZh7Kz+en5nY@yuki> <87ee7u9b30.fsf@suse.de>
In-Reply-To: <87ee7u9b30.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Fri, 5 Nov 2021 21:23:56 +0800
Message-ID: <CAEemH2cYPVqJBQzLoZwNCkv1m4X2o5LgOmVxr18mEyGrxjj9Ug@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: adding .arch field in tst_test
 structure
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
Content-Type: multipart/mixed; boundary="===============1494469187=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1494469187==
Content-Type: multipart/alternative; boundary="000000000000e503e705d00a8e0d"

--000000000000e503e705d00a8e0d
Content-Type: text/plain; charset="UTF-8"

> > Quite the opposite, it should be an array of strings, so that it's easy
> > to work with such as:
> >
> >       .supported_archs = (const char *const []){"x86_64", "ppc64le",
> NULL},
> >
> > We can put it into a single string delimited by a space, but that would
> > be more complicated to work with.
> >
> >> > However the hard part would be keeping the actual code and metadata in
> >> > sync, we still have to keep the ifdefs in the code.
> >> >
> >>
> >> Yes, some inline assemble require ifdefs.
> >>
> >> Btw, I look back at the reviews and find Jan said:
> >>     "I can see how tst_on_arch() would be useful. Test is valid
> >>      on all arches, but needs different input/constants/code/etc."
> >>
> >> That may be a slight reason for keeping tst_on_arch.
> >
> > I guess that we should reviewe the code we have, I guess that there are
> > a few tests where we can get rid of a few ifdefs by doing the checks
> > dynamically.
> >
> > Also I guess that it would be slightly easier to work with as an enum,
> > so that we can do:
> >
> >       switch (tst_arch) {
> >       case TST_X86_64:
> >               ...
> >       break;
> >       case TST_PPC64_LE:
>
> I prefer enum as well. As an aside, we don't want to include LE in
>

Sure, but I'm now thinking to extend the tst_arch as a structure
so that could also be used in a string:

    enum tst_arch_type {
            TST_I386,
            TST_X86_64,
            ...
            TST_SPARC,
    };

    /*
     * This tst_arch is to save the system architecture for
     * using in the whole test case.
     */
    extern struct arch {
             const char name[16];
             enum tst_arch_type type;
    } tst_arch;

then we just can do simply in case:

    switch (tst_arch.type) {
    case TST_X86_64:
        ...
    break;



> ppc64. If someone finds that the byte order is significant for a test
>

Yes, or we can read info via uname() into 'utsname.machine' for
ppc64le if really needed.


> then we can add ppc64le or ppc64be. Also at some point we may need to
> add a "machine" field for e.g. POWER8, i386 etc.
>

Adding a new field '.machine' maybe not be necessary if just
for POWER8/9/10, or can we find a way to combine them together
with .supported_arch?  Umm, I'm still hesitating.


>
> Which btw, I have some buildroot and QEMU scripts which can be used to
> test ppc64 BE and any other machine you have the hardware or QEMU
> emulator for.
>
> https://gitlab.com/Palethorpe/cross


Thanks for sharing.


-- 
Regards,
Li Wang

--000000000000e503e705d00a8e0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><div>=C2=A0<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Quite the opposite, it should be an array of strings, so that it&#39;s=
 easy<br>
&gt; to work with such as:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.supported_archs =3D (const char *const []){=
&quot;x86_64&quot;, &quot;ppc64le&quot;, NULL},<br>
&gt;<br>
&gt; We can put it into a single string delimited by a space, but that woul=
d<br>
&gt; be more complicated to work with.<br>
&gt;<br>
&gt;&gt; &gt; However the hard part would be keeping the actual code and me=
tadata in<br>
&gt;&gt; &gt; sync, we still have to keep the ifdefs in the code.<br>
&gt;&gt; &gt;<br>
&gt;&gt; <br>
&gt;&gt; Yes, some inline assemble require ifdefs.<br>
&gt;&gt; <br>
&gt;&gt; Btw, I look back at the reviews and find Jan said:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;I can see how tst_on_arch() would be usef=
ul. Test is valid<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 on all arches, but needs different input/const=
ants/code/etc.&quot;<br>
&gt;&gt; <br>
&gt;&gt; That may be a slight reason for keeping tst_on_arch.<br>
&gt;<br>
&gt; I guess that we should reviewe the code we have, I guess that there ar=
e<br>
&gt; a few tests where we can get rid of a few ifdefs by doing the checks<b=
r>
&gt; dynamically.<br>
&gt;<br>
&gt; Also I guess that it would be slightly easier to work with as an enum,=
<br>
&gt; so that we can do:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (tst_arch) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case TST_X86_64:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case TST_PPC64_LE:<br>
<br>
I prefer enum as well. As an aside, we don&#39;t want to include LE in<br><=
/blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">Sure, but I&#39;m now thinking to extend the tst_arch as a stru=
cture</div><div class=3D"gmail_default" style=3D"font-size:small">so that c=
ould also be used in a string:</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><span class=3D"gmail_default" style=3D"font-size:=
small">=C2=A0 =C2=A0 </span>enum tst_arch_type {<br>=09<span class=3D"gmail=
_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>TST_I386<span class=3D"gmail_default" style=3D"font-size:small">=
,</span><br>=09<span class=3D"gmail_default" style=3D"font-size:small">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>TST_X86_64,<br>=09<span class=
=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span><span class=3D"gmail_default" style=3D"font-size:small=
">...</span></div><div><div class=3D"gmail_default" style=3D"font-size:smal=
l">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_SPARC,</div><span class=3D=
"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 </span>};<br><br><s=
pan class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 </span>=
/*<br>=C2=A0<span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =
=C2=A0 </span>* This tst_arch is to save the system architecture for<br>=C2=
=A0<span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 </=
span>* using in the whole test case.<br>=C2=A0<span class=3D"gmail_default"=
 style=3D"font-size:small">=C2=A0 =C2=A0 </span>*/<br><span class=3D"gmail_=
default" style=3D"font-size:small">=C2=A0 =C2=A0 </span>extern struct arch =
{<br>=09<span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span>const char name[16];<br>=09<sp=
an class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0</span>enum tst_arch_type type;<br><span class=
=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 </span>} tst_arc=
h;<br><br></div><div><div class=3D"gmail_default" style=3D"font-size:small"=
>then we just can do simply in case:</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><br></div><span class=3D"gmail_default" style=3D"font=
-size:small">=C2=A0 =C2=A0=C2=A0</span>switch (tst_arch<span class=3D"gmail=
_default" style=3D"font-size:small">.type</span>) {<br><span class=3D"gmail=
_default" style=3D"font-size:small">=C2=A0 =C2=A0=C2=A0</span>case TST_X86_=
64:<br><span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0</span>...<br><div class=3D"gmail_default" style=3D"=
font-size:small">=C2=A0 =C2=A0 break;</div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
ppc64. If someone finds that the byte order is significant for a test<br></=
blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Yes, or we can read info via uname() into &#39;utsname.machine&#=
39; for</div><div class=3D"gmail_default" style=3D"font-size:small">ppc64le=
 if really needed.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
then we can add ppc64le or ppc64be. Also at some point we may need to<br>
add a &quot;machine&quot; field for e.g. POWER8, i386 etc.<br></blockquote>=
<div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">=
Adding a new field &#39;.machine&#39; maybe not be necessary if just</div><=
div class=3D"gmail_default" style=3D"font-size:small">for POWER8/9/10, or c=
an we find a way to combine them together</div><div class=3D"gmail_default"=
 style=3D"font-size:small">with .supported_arch?=C2=A0 Umm, I&#39;m still=
=C2=A0hesitating.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
Which btw, I have some buildroot and QEMU scripts which can be used to<br>
test ppc64 BE and any other machine you have the hardware or QEMU<br>
emulator for.<br>
<br>
<a href=3D"https://gitlab.com/Palethorpe/cross" rel=3D"noreferrer" target=
=3D"_blank">https://gitlab.com/Palethorpe/cross</a></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">Thanks for =
sharing.</div></div><div><br></div></div><div><br></div>-- <br><div dir=3D"=
ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div=
>Li Wang<br></div></div></div></div>

--000000000000e503e705d00a8e0d--


--===============1494469187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1494469187==--

