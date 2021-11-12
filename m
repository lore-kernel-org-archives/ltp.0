Return-Path: <SRS0=aRd5=P7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A66C433EF
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 06:42:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB866023D
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 06:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DB866023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D95E3C7D7D
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 07:42:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C91CD3C070F
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 07:41:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 817931A016DD
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 07:41:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636699315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7cUiNh0WqprV6POv+n7K6B4s5O/0glKyUbho//GV1s=;
 b=BlLOl0Z7WqgHfxP4JtBrcsPE1M/6O/VPDK3+yLKA9g84bOAsTfKFMhkk+NjnKTtuUfbYvo
 zgz+BBUkQR8MQF1omQIDT/ODbfQqlkGIPOt48TFjmLxaiOhmud22PRs1Yo0k9fXO3FZlGo
 UXj7g/CcqWHe/p7byxr8J8AE8nxnAns=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-D-C7ui4kMbCjva5FTIGqPg-1; Fri, 12 Nov 2021 01:41:54 -0500
X-MC-Unique: D-C7ui4kMbCjva5FTIGqPg-1
Received: by mail-yb1-f198.google.com with SMTP id
 d9-20020a251d09000000b005c208092922so13194248ybd.20
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 22:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o7cUiNh0WqprV6POv+n7K6B4s5O/0glKyUbho//GV1s=;
 b=NjY/bKYivHUxgaKNlrzYT4NGaMiOhp8idmd6gcJ8dAVJofZ43xalrlFTKp/F8WtSWT
 jNmB37UW6JIEE2Y1zfquMzXmY7ltK+QO7LvdPvjdOwmV+fuc02/+XOIttBdTusdJquu0
 SpqGMUz69STcQ+HguJuVqqFOLCeOijOEhpbv8K6SuFknK8s6XoEYpXd9xJSnQuy35Zl7
 TRDxyF4Se3jz+1puJWieR4HCBJqfmWtfm2TNF0YV0dEQJKwNQakS9e5PafCSutrGBij2
 pcv4wYnG4grk1qm8MMFglP9f7QtW9dm5++p9OG1h69No1W7Rd3MsUzb/b053GRsQOAY7
 dPkQ==
X-Gm-Message-State: AOAM531Py4fYEqy/HzRPwsjpawfsWaRIJPgn70t0E6gjHFYxmV8C66iO
 dqWp0MLsZgc0BVVTOfPMh0mT2uyOCqnkrcUti0ZNQ7yadPA+eytVgkxNeI6/vhNU+8gVXn9PwgY
 tQoiCOEpwjZVbm3ktF1KqYaWZYrY=
X-Received: by 2002:a25:e704:: with SMTP id e4mr13956221ybh.490.1636699313656; 
 Thu, 11 Nov 2021 22:41:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtCmH5Pde0VY9vQ5v07NWGHWNa9c4Y9zs/07WcfVDZSQcbpOXbBCuCCCwDnUcJfCosYaf0R6FjLm+TRVWiNn4=
X-Received: by 2002:a25:e704:: with SMTP id e4mr13956195ybh.490.1636699313257; 
 Thu, 11 Nov 2021 22:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109130910.1583233-1-liwang@redhat.com>
 <YYqdxmnJi5je9DvV@yuki>
In-Reply-To: <YYqdxmnJi5je9DvV@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Nov 2021 14:41:40 +0800
Message-ID: <CAEemH2fJHN5i0W9poB6H2JWXUNRBjriXp21VG4x8r5n4oMvhbw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: adding .supported_archs field in
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
Content-Type: multipart/mixed; boundary="===============0941957561=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0941957561==
Content-Type: multipart/alternative; boundary="0000000000002bdcca05d091c149"

--0000000000002bdcca05d091c149
Content-Type: text/plain; charset="UTF-8"

> > +#ifndef TST_ARCH_H__
> > +#define TST_ARCH_H__
> > +
> > +enum tst_arch_type {
> > +     TST_UNKNOWN,
> > +     TST_I386,
>
> I would still probably name this TST_X86, Linux does not support i386
> anymore, the remaining 32bit distributions usually require at least i586
> or i686...
>

Sure, If go with that TST_X86, we just need to do modifications based on
V4 like below, right? What else am I missing here?

--- a/include/tst_arch.h
+++ b/include/tst_arch.h
@@ -7,7 +7,7 @@

 enum tst_arch_type {
        TST_UNKNOWN,
-       TST_I386,
+       TST_X86,
        TST_X86_64,
        TST_IA64,
        TST_PPC,
diff --git a/lib/tst_arch.c b/lib/tst_arch.c
index 67a955789..f19802a03 100644
--- a/lib/tst_arch.c
+++ b/lib/tst_arch.c
@@ -13,9 +13,9 @@ const struct tst_arch tst_arch = {
 #if defined(__x86_64__)
         .name = "x86_64",
         .type = TST_X86_64,
-#elif defined(__i386__)
-        .name = "i386",
-        .type = TST_I386,
+#elif defined(__i386__) || defined(__i586__) || defined(__i686__)
+        .name = "x86",
+        .type = TST_X86,
 #elif defined(__ia64__)
         .name = "ia64",
         .type = TST_IA64,
@@ -48,6 +48,8 @@ const struct tst_arch tst_arch = {

 static const char *const arch_type_list[] = {
        "i386",
+       "i586",
+       "i686",
        "x86_64",
        "ia64",
        "ppc",
diff --git a/testcases/kernel/mem/tunable/max_map_count.c
b/testcases/kernel/mem/tunable/max_map_count.c
index bd5af0ff6..a4c3dbf8e 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -88,7 +88,7 @@ static bool filter_map(const char *line)
                return false;

        switch (tst_arch.type) {
-       case TST_I386:
+       case TST_X86:
        case TST_X86_64:
                /* On x86, there's an old compat vsyscall page */
                if (!strcmp(buf, "[vsyscall]"))

-- 
Regards,
Li Wang

--0000000000002bdcca05d091c149
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +#ifndef TST_ARCH_H__<br>
&gt; +#define TST_ARCH_H__<br>
&gt; +<br>
&gt; +enum tst_arch_type {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TST_UNKNOWN,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TST_I386,<br>
<br>
I would still probably name this TST_X86, Linux does not support i386<br>
anymore, the remaining 32bit distributions usually require at least i586<br=
>
or i686...<br></blockquote><div><br></div><div><div class=3D"gmail_default"=
 style=3D"font-size:small">Sure,=C2=A0If go with that TST_X86, we just need=
 to=C2=A0do modifications based on</div><div class=3D"gmail_default" style=
=3D"font-size:small">V4 like below, right? What else am I missing here?</di=
v></div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">--- a/include/tst_arch=
.h<br>+++ b/include/tst_arch.h<br>@@ -7,7 +7,7 @@<br>=C2=A0<br>=C2=A0enum t=
st_arch_type {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_UNKNOWN,<br>- =C2=A0 =C2=
=A0 =C2=A0 TST_I386,<br>+ =C2=A0 =C2=A0 =C2=A0 TST_X86,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 TST_X86_64,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_IA64,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TST_PPC,<br>diff --git a/lib/tst_arch.c b/lib/tst_=
arch.c<br>index 67a955789..f19802a03 100644<br>--- a/lib/tst_arch.c<br>+++ =
b/lib/tst_arch.c<br>@@ -13,9 +13,9 @@ const struct tst_arch tst_arch =3D {<=
br>=C2=A0#if defined(__x86_64__)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=
 =3D &quot;x86_64&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D TST=
_X86_64,<br>-#elif defined(__i386__)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =
=3D &quot;i386&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D TST_I386,<b=
r>+#elif defined(__i386__) || defined(__i586__) || defined(__i686__)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;x86&quot;,<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.type =3D TST_X86,<br>=C2=A0#elif defined(__ia64__)<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;ia64&quot;,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.type =3D TST_IA64,<br>@@ -48,6 +48,8 @@ const struct tst_=
arch tst_arch =3D {<br>=C2=A0<br>=C2=A0static const char *const arch_type_l=
ist[] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;i386&quot;,<br>+ =C2=A0 =
=C2=A0 =C2=A0 &quot;i586&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 &quot;i686&quot;,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;x86_64&quot;,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;ia64&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ppc&quot;,<b=
r>diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/ker=
nel/mem/tunable/max_map_count.c<br>index bd5af0ff6..a4c3dbf8e 100644<br>---=
 a/testcases/kernel/mem/tunable/max_map_count.c<br>+++ b/testcases/kernel/m=
em/tunable/max_map_count.c<br>@@ -88,7 +88,7 @@ static bool filter_map(cons=
t char *line)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn false;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (tst_arch.type)=
 {<br>- =C2=A0 =C2=A0 =C2=A0 case TST_I386:<br>+ =C2=A0 =C2=A0 =C2=A0 case =
TST_X86:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TST_X86_64:<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* On x86, there&#39;s an old com=
pat vsyscall page */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!strcmp(buf, &quot;[vsyscall]&quot;))<br></div></div><div><br></=
div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li=
 Wang<br></div></div></div></div>

--0000000000002bdcca05d091c149--


--===============0941957561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0941957561==--

