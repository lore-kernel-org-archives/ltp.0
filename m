Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22BCC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 03:56:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A47173CA27E
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 04:56:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78A693C98AB
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 04:55:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 58DDF10009A3
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 04:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646106953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bz7Ekx5ujRSVj+5oxc8wS5ia6YSVyieNwTFjhuF3Wjg=;
 b=Y91tn0vB/03nWYQjdMP8j5ODIe59Yn+fZv5IsgeJPZQPszFkHYqAiuySbF6dooB7LnPX6T
 wrZLZTKhlfUHcy+JIwpl+E83G1FFJEfCbdDlR2dof6PKk0OcYJX2wLRBUkOyVnb/MLogg+
 TeN+QZmlnVdeTI41CW/mLLCfwbrTnoU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-XzJRq7iVMQGcHKhMQzqICQ-1; Mon, 28 Feb 2022 22:55:50 -0500
X-MC-Unique: XzJRq7iVMQGcHKhMQzqICQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2d6b6cf0cafso117174217b3.21
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 19:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bz7Ekx5ujRSVj+5oxc8wS5ia6YSVyieNwTFjhuF3Wjg=;
 b=71nS8nbeMvvOyPSOO8yVlnZX1xiu3rOvH2es9SgxgsnaFfPA+0TL7mHYsydUYq1JyH
 iceDLZfv/v5VmHhsZbBI+eREjtjC15SGouv32g68Ll8nbRepZAaa2brYed1lRx6sCJqL
 3aXjwchniQoUx8uy1BecAvvSNb6mUPvSxkdXWtDK4/2W3uuLs1Oc/1JErIne/DB9izgz
 jQCrMXGfvM5dYSR2+DuVBeQfEJRWCbUgGzUf6s1BqkRLWOfUkokJaWsiNs6nUOsjHz25
 UZEpQPdrva6Pb23w7eSvD2ps3c8j4d2d+Ecjfzpy9KuvB451q0oPUFhM9Q5m6B945uDi
 sj8w==
X-Gm-Message-State: AOAM533LVGGjDaTAxB+AF8GYF/lQKt5D5nIwJKPKiNhV/ihCNy9TYdXE
 PrBBkMe9Jc0ZKu9t5GTWjaFDJH2nng61tVOZ0Fw/GsG5xCLF4uxRVmssXZhTGK1Ago+AyrtNPGY
 Yl1jHBvySO97gafVRBMEQpwBYreU=
X-Received: by 2002:a81:1611:0:b0:2d6:3290:9bd3 with SMTP id
 17-20020a811611000000b002d632909bd3mr23446392yww.19.1646106949693; 
 Mon, 28 Feb 2022 19:55:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhtwST1MJlCiresmCbJwQieCkqu2yb472shgmDmwGXj0J6HxLdqSB0Jc7dkFQxG/6lI53x633bx0sD3lKxNps=
X-Received: by 2002:a81:1611:0:b0:2d6:3290:9bd3 with SMTP id
 17-20020a811611000000b002d632909bd3mr23446386yww.19.1646106949268; Mon, 28
 Feb 2022 19:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20220222124547.14396-1-rpalethorpe@suse.com>
 <20220222124547.14396-3-rpalethorpe@suse.com>
In-Reply-To: <20220222124547.14396-3-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 1 Mar 2022 11:55:35 +0800
Message-ID: <CAEemH2fAPvAL3d07MbvhTPR3yUKUUEG-XhxebQH=75N1CcEjVg@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] memcontrol04: Copy from kselftest
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1092619009=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1092619009==
Content-Type: multipart/alternative; boundary="000000000000f9524b05d920231c"

--000000000000f9524b05d920231c
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.com> wrote:

+// SPDX-License-Identifier: GPL-2.0
> +/*\
> + *
> + * [Description]
> + *
> + * Conversion of the forth kself test in cgroup/test_memcontrol.c.
> + *
> + * Original description:
> + * "First, this test creates the following hierarchy:
> + * A       memory.low = 50M,  memory.max = 200M
> + * A/B     memory.low = 50M,  memory.current = 50M
> + * A/B/C   memory.low = 75M,  memory.current = 50M
> + * A/B/D   memory.low = 25M,  memory.current = 50M
> + * A/B/E   memory.low = 500M, memory.current = 0
> + * A/B/F   memory.low = 0,    memory.current = 50M
> + *
> + * Usages are pagecache
> + * Then it creates A/G and creates a significant
> + * memory pressure in it.
> + *
> + * A/B    memory.current ~= 50M
> + * A/B/C  memory.current ~= 33M
> + * A/B/D  memory.current ~= 17M
> + * A/B/E  memory.current ~= 0
> + *
> + * After that it tries to allocate more than there is unprotected
> + * memory in A available, and checks that memory.low protects
> + * pagecache even in this case."
>


This is not exactly the original description of memory.low test,
it looks like modified from memory.min part.

Maybe we'd better copy from line#398~#418.
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/cgroup/test_memcontrol.c#L398


-- 
Regards,
Li Wang

--000000000000f9524b05d920231c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.com=
">rpalethorpe@suse.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+// SPDX-License-Identifier: GPL-2.0<br>
+/*\<br>
+ *<br>
+ * [Description]<br>
+ *<br>
+ * Conversion of the forth kself test in cgroup/test_memcontrol.c.<br>
+ *<br>
+ * Original description:<br>
+ * &quot;First, this test creates the following hierarchy:<br>
+ * A=C2=A0 =C2=A0 =C2=A0 =C2=A0memory.low =3D 50M,=C2=A0 memory.max =3D 20=
0M<br>
+ * A/B=C2=A0 =C2=A0 =C2=A0memory.low =3D 50M,=C2=A0 memory.current =3D 50M=
<br>
+ * A/B/C=C2=A0 =C2=A0memory.low =3D 75M,=C2=A0 memory.current =3D 50M<br>
+ * A/B/D=C2=A0 =C2=A0memory.low =3D 25M,=C2=A0 memory.current =3D 50M<br>
+ * A/B/E=C2=A0 =C2=A0memory.low =3D 500M, memory.current =3D 0<br>
+ * A/B/F=C2=A0 =C2=A0memory.low =3D 0,=C2=A0 =C2=A0 memory.current =3D 50M=
<br>
+ *<br>
+ * Usages are pagecache<br>
+ * Then it creates A/G and creates a significant<br>
+ * memory pressure in it.<br>
+ *<br>
+ * A/B=C2=A0 =C2=A0 memory.current ~=3D 50M<br>
+ * A/B/C=C2=A0 memory.current ~=3D 33M<br>
+ * A/B/D=C2=A0 memory.current ~=3D 17M<br>
+ * A/B/E=C2=A0 memory.current ~=3D 0<br>
+ *<br>
+ * After that it tries to allocate more than there is unprotected<br>
+ * memory in A available, and checks that memory.low protects<br>
+ * pagecache even in this case.&quot;<br></blockquote><div><br></div><div>=
<div class=3D"gmail_default" style=3D"font-size:small"><br></div><div><div =
class=3D"gmail_default">This is not exactly the original description of mem=
ory.low test,</div><div class=3D"gmail_default">it looks like modified from=
 memory.min part.</div><div class=3D"gmail_default"><br></div><div class=3D=
"gmail_default">Maybe we&#39;d better copy from line#398~#418.</div></div><=
div class=3D"gmail_default" style=3D"font-size:small"><a href=3D"https://gi=
thub.com/torvalds/linux/blob/master/tools/testing/selftests/cgroup/test_mem=
control.c#L398">https://github.com/torvalds/linux/blob/master/tools/testing=
/selftests/cgroup/test_memcontrol.c#L398</a></div></div><div><br></div></di=
v><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000f9524b05d920231c--


--===============1092619009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1092619009==--

