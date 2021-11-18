Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E8C433F5
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 05:51:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529A861B39
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 05:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 529A861B39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 480B33C886B
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 06:51:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD4E13C0E87
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 06:51:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 83646140098D
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 06:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637214667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+vyOGN2REi8nRGUo1yzFxEmYugmiagiog+M87xZnK0=;
 b=OZxCsWW5ZvFX8cboYMDmGPyrcebCA65WTDUfmP1lkc5BkeZyeD7NZz8KjBHusfOt8NDRdI
 tTUMQ1cqrBWke+yi5BuNomKz+KtwchOQeL7HQuyvRorC0qTAQxYd2G1jeASJj9cPJ4F6Xn
 YQ4CFlMBZVuYbfKHKSXVQUgLBX6dZf4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-hbnRPolPP8Cii8TCkyyHaw-1; Thu, 18 Nov 2021 00:51:04 -0500
X-MC-Unique: hbnRPolPP8Cii8TCkyyHaw-1
Received: by mail-yb1-f198.google.com with SMTP id
 r18-20020a25ac52000000b005c9047c420bso8125122ybd.4
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 21:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5+vyOGN2REi8nRGUo1yzFxEmYugmiagiog+M87xZnK0=;
 b=w6lC9wQcxsW5Gh/tfx+tQcLFZi9a3tUQgbTIekW99aMiOxkgFcs4n6rRSQ13Xv5Cnw
 AEdeip4LR9UryAKvP38ajW28TJOxignYfoCICOBq9D0Il4RZKY2BwhVW5pdqe3lqGadJ
 cRBHtNUdcXVKP8wguUuaxLslvOV2wrRHmjWSwgDi9doH/bpnUZXVDSUGz5EJm06oTYxe
 JwQil434ZE3utefjudGXFX1Ci7lnu90svf677mUwGfm7xuVFQoa/GaNjNzXA3W/mBj07
 i6mDOFPn8J7NltXLVQqs3pQxUJguJgZwt5VrvX/HqZ/dcgM+CZRsWeofnwXUZbvxaaUU
 Y+mg==
X-Gm-Message-State: AOAM5315tJzXuXQ0WX2MKrFucLl671R0ruhyJZKcZXyrzhIQlxlna64n
 ytKjmfXeLEYHq7BM6KuGA8mx41W69j7RphQ+2fGgqQNP2eTdT3hlC9NlxSCKEN5+yTF0bdFGi0e
 zP3v3II05Kf0xUj/bHaF1Reiaq4E=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr22537558ybt.302.1637214664333; 
 Wed, 17 Nov 2021 21:51:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzknOXggBx/jeodThRLBdTaBM3Gz/IJt/0KGDTpBIjxF2iOGk8RGBhLnjZ73kxpYkM2tbJv1pO1nZq60hJLFBg=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr22537525ybt.302.1637214663968; 
 Wed, 17 Nov 2021 21:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20211117070708.2174932-1-liwang@redhat.com>
 <77e0b8b9-5de6-73ab-0f73-e3d95bad0935@jv-coder.de>
 <87ilwqalvs.fsf@suse.de>
In-Reply-To: <87ilwqalvs.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Nov 2021 13:50:50 +0800
Message-ID: <CAEemH2cCoviXMp8wZQ+3u2txJnT3-jXY8a1=DAvSYAnkc0O+dw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in
 tst_test structure
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
Content-Type: multipart/mixed; boundary="===============0952122347=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0952122347==
Content-Type: multipart/alternative; boundary="00000000000077a03805d109be4d"

--00000000000077a03805d109be4d
Content-Type: text/plain; charset="UTF-8"

Hi Joerg, Richard,

On Wed, Nov 17, 2021 at 10:37 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
> > Hi,
> >
> > On 11/17/2021 8:07 AM, Li Wang wrote:
> >> Testcases for specific arch should be limited on that only being
> supported
> >> platform to run, we now involve a .supported_archs to achieve this
> feature
> >> in LTP library. All you need to run a test on the expected arch is to
> set
> >> the '.supported_archs' array in the 'struct tst_test' to choose the
> required
> >> arch list. e.g.
> >>
> >>      .supported_archs = (const char *const []){"x86_64", "ppc64", NULL}
> >>
> >> This helps move the TCONF info from code to tst_test metadata as well.
> >
> > while I do like this, I wonder if it wouldn't be better to do this
> > using kernel config. IIRC there are config switches
> > for all architectures. Further more this would allow adding more
> > complex conditions in the future.
> >
> > E.g: I am pretty sure, that there are some syscalls, that have existed
> > "forever" in x86_64, but where only added
> > in a specific version for aarch64. By making the arch a separate
> > option, there is no way, to model this.
>

Umm, we shouldn't set .supported_archs to make it a separate option
unless we have an explicit requirement on that. In other words, without
that .supported_archs setting, it will support all arches by default and we
can do anything by the exported tst_arch structure and enum tst_arch_type.



> > If it was done in the kernel config check, it could be possible to add
> > version and arch checks like
> > (CONFIG_AARCH64 && CONFIG_VERSION > 5.3) || CONFIG_X86_64
>

We definitely can achieve this in the current version as well.

    switch (tst_arch.type)
    case TST_AARCH64:
            if ((tst_kvercmp(5, 3, 0)) < 0)
                    break;
    case TST_X86_64:
            ltp_syscall(__NR_special_syscall, ...)
    break;
        ...



> >
> > While this probably does not produce a very good error message, it is
> > more versatile.
> >
> > Sorry for this late questioning the whole approach.
>
> It should never be too late IMO. We should also consider whether there
> are existing tst_test flags which have been made redundant by kconfig.
>

After checking the config file again, yes, I agree that we can achieve the
same thing just with existing kconfig functions to parse it.

E.g. If required x86_64:

    .needs_kconfigs = (const char *[]) {
        "CONFIG_X86_64=y",
        NULL
    },

and s390x will be like:

    .needs_kconfigs = (const char *[]) {
        "CONFIG_64BIT=y",
        "CONFIG_S390=y"
        NULL
    },

...


>
> I suspect the main issue would be meta-data. As an arbitrarily
> complicated kconfig expression may confuse test harnesses.
>

Right, so I would like to keep the .supported_archs and tst_arch structure
no change, even though goes with parsing config file in the library.



>
> It might be better for us to tackle that issue and use kconfig though.
>
> --
> Thank you,
> Richard.
>
>

-- 
Regards,
Li Wang

--00000000000077a03805d109be4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Joerg, Richard,</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 17, 2021 at 10:37 PM Rich=
ard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_blank"=
>rpalethorpe@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hello Joerg,<br>
<br>
Joerg Vehlow &lt;<a href=3D"mailto:lkml@jv-coder.de" target=3D"_blank">lkml=
@jv-coder.de</a>&gt; writes:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; On 11/17/2021 8:07 AM, Li Wang wrote:<br>
&gt;&gt; Testcases for specific arch should be limited on that only being s=
upported<br>
&gt;&gt; platform to run, we now involve a .supported_archs to achieve this=
 feature<br>
&gt;&gt; in LTP library. All you need to run a test on the expected arch is=
 to set<br>
&gt;&gt; the &#39;.supported_archs&#39; array in the &#39;struct tst_test&#=
39; to choose the required<br>
&gt;&gt; arch list. e.g.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 .supported_archs =3D (const char *const []){&q=
uot;x86_64&quot;, &quot;ppc64&quot;, NULL}<br>
&gt;&gt;<br>
&gt;&gt; This helps move the TCONF info from code to tst_test metadata as w=
ell.<br>
&gt;<br>
&gt; while I do like this, I wonder if it wouldn&#39;t be better to do this=
<br>
&gt; using kernel config. IIRC there are config switches<br>
&gt; for all architectures. Further more this would allow adding more<br>
&gt; complex conditions in the future.<br>
&gt;<br>
&gt; E.g: I am pretty sure, that there are some syscalls, that have existed=
<br>
&gt; &quot;forever&quot; in x86_64, but where only added<br>
&gt; in a specific version for aarch64. By making the arch a separate<br>
&gt; option, there is no way, to model this.<br></blockquote><div><br></div=
><div><div class=3D"gmail_default" style=3D"font-size:small">Umm, we should=
n&#39;t set .supported_archs to make it a separate option</div><div class=
=3D"gmail_default" style=3D"font-size:small">unless we have an explicit req=
uirement on that. In other words, without</div><div class=3D"gmail_default"=
 style=3D"font-size:small">that .supported_archs setting, it will support a=
ll arches by default and we</div><div class=3D"gmail_default" style=3D"font=
-size:small">can do anything by the exported tst_arch structure and enum ts=
t_arch_type.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
&gt; If it was done in the kernel config check, it could be possible to add=
<br>
&gt; version and arch checks like<br>
&gt; (CONFIG_AARCH64 &amp;&amp; CONFIG_VERSION &gt; 5.3) || CONFIG_X86_64<b=
r></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">We definitely=C2=A0can achieve=C2=A0this in the current vers=
ion as well.</div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=
=A0 switch (tst_arch.type)</div><div class=3D"gmail_default" style=3D"font-=
size:small">=C2=A0 =C2=A0 case TST_AARCH64:</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
(tst_kvercmp(5, 3, 0)) &lt; 0)</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">=C2=A0 =C2=A0 case TST_X86_64:</div><div class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ltp_syscall(=
__NR_special_syscall, ...)</div><div class=3D"gmail_default" style=3D"font-=
size:small">=C2=A0 =C2=A0 break;</div><div class=3D"gmail_default" style=3D=
"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...</div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; While this probably does not produce a very good error message, it is<=
br>
&gt; more versatile.<br>
&gt;<br>
&gt; Sorry for this late questioning the whole approach.<br>
<br>
It should never be too late IMO. We should also consider whether there<br>
are existing tst_test flags which have been made redundant by kconfig.<br><=
/blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">After checking the config file again, yes, I agree that we can =
achieve the</div><div class=3D"gmail_default" style=3D"font-size:small">sam=
e thing just with existing kconfig functions to parse it. </div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">E.g. If required x86_64:</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">=C2=A0 =C2=A0 .needs_kconfigs =3D (const=
 char *[]) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CONFIG_X86_64=3Dy&quot;,<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>=C2=A0 =C2=A0 },<br></div><br></div>=
<div><div class=3D"gmail_default" style=3D"font-size:small">and s390x will =
be like:</div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 .n=
eeds_kconfigs =3D (const char *[]) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<=
span class=3D"gmail_default"></span>CONFIG_64BIT=3Dy&quot;,</div><div class=
=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 &q=
uot;CONFIG_S390=3Dy&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>=C2=A0 =C2=
=A0 },<br></div><span class=3D"gmail_default" style=3D"font-size:small">=C2=
=A0=C2=A0</span><br></div><div><span class=3D"gmail_default" style=3D"font-=
size:small">...</span></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
I suspect the main issue would be meta-data. As an arbitrarily<br>
complicated kconfig expression may confuse test harnesses.<br></blockquote>=
<div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">=
Right, so I would like to keep the=C2=A0.supported_archs and tst_arch struc=
ture</div><div class=3D"gmail_default" style=3D"font-size:small">no change,=
 even though goes with parsing config file in the library.</div><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
It might be better for us to tackle that issue and use kconfig though.<br>
<br>
-- <br>
Thank you,<br>
Richard.<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--00000000000077a03805d109be4d--


--===============0952122347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0952122347==--

