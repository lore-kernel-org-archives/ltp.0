Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E71C433EF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 07:12:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3911261053
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 07:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3911261053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 335713C71EC
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 08:12:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D80503C71EC
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 08:12:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DFC98600C21
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 08:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636009957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cjl5zOFrgqweUTvmL1nSp70/PUFdZrtNIEXzKHYOt1Y=;
 b=UbpJkZKW3NLR8dS4O50ntUgwZWfw5bWIbWqYeXFsBrDA7BY6NAN1Woi3KIwCoAeedNQEqa
 UDqXabkGXZjuDkFAaYzy9CGoMDPiP/GaQoShkNeu+G1xpvSMtavsKyADqlK98hmioJxV3+
 LMaQ9x7cpFM/XY//o/sKhCfMyKU4lAU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-fgJSSEChNCmKKwPg3c_kfw-1; Thu, 04 Nov 2021 03:12:36 -0400
X-MC-Unique: fgJSSEChNCmKKwPg3c_kfw-1
Received: by mail-yb1-f198.google.com with SMTP id
 l28-20020a25b31c000000b005c27dd4987bso7454399ybj.18
 for <ltp@lists.linux.it>; Thu, 04 Nov 2021 00:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cjl5zOFrgqweUTvmL1nSp70/PUFdZrtNIEXzKHYOt1Y=;
 b=FtKlFS8cu/3DlIcRUwd7iWMl/il8cHBOASc+umeZ+mNb8NIkSGfNs4NowftqJv33QW
 0ATrWSSGUqbtdXubFfEBVU52+RhN6+8NUT4WQeWW9PvqHXXZ0T/8hIm6K5H2x/iDYkF5
 GMxvYOMMjtYEEXgf79EmQFJyM+B/IFREpzsCTj4s4EMVsU7LU1oE+UicMq951KjYpw2G
 +EC1wFRXdawfHWfEayDFf3d93R0AVFjS2nUN7kCUgrb3zrOHDnAO7r49rA9aHDFcsZ5z
 fuEF7SVGD/u+SY4D5CMu7ihfsiu+2LsgRTjTWIXketcwv0JnD6f9xF7WjLMcxaPDCQXZ
 g94Q==
X-Gm-Message-State: AOAM532WJS/mclSTjbx6WWv8KVYcz4d0eun+ebTI5qCbL1ufwAUV0H6z
 BDPj7pIu4IlloePtMXASMoDuHoURb0KIbW3OsXedO505hfD8uWRD7MFeXUyHBwmPqs3/Rpg6Kgc
 Ds6UIdjCzqp0H+notzIG15ouIds0=
X-Received: by 2002:a25:e704:: with SMTP id e4mr50505875ybh.490.1636009955727; 
 Thu, 04 Nov 2021 00:12:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGaEGHOIp+8S52oWKSDjhXpkkY8XdRW6gxspTCswN5IqlcHQuGcCojB1bEVJ+Uvs7/6X+lmB4xSfkGqkmj4Zo=
X-Received: by 2002:a25:e704:: with SMTP id e4mr50505855ybh.490.1636009955526; 
 Thu, 04 Nov 2021 00:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211103232604.7930-1-tangmeng@uniontech.com>
 <20211103232604.7930-2-tangmeng@uniontech.com>
In-Reply-To: <20211103232604.7930-2-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Nov 2021 15:12:22 +0800
Message-ID: <CAEemH2cKA7dYS451r8mVEix99QzzWV4kJs+BASwdruYfEk33Fg@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] link/link05: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1964983983=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1964983983==
Content-Type: multipart/alternative; boundary="0000000000003fa0f705cff140ba"

--0000000000003fa0f705cff140ba
Content-Type: text/plain; charset="UTF-8"

Patch pushed with the following improvements. Thanks~

--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -22,19 +22,19 @@ static int nlinks = 1000;

 static void verify_link(void)
 {
-       struct stat fbuf, lbuf;
        int cnt;
-       char lname[255];
+       char lname[1024];
+       struct stat fbuf, lbuf;

        for (cnt = 1; cnt < nlinks; cnt++) {
-               sprintf(lname, "%s%d", fname, cnt);
-               TST_EXP_PASS(link(fname, lname), "link(%s, %s)", fname,
lname);
+               sprintf(lname, "%s_%d", fname, cnt);
+               TST_EXP_PASS_SILENT(link(fname, lname), "link(%s, %s)",
fname, lname);
        }

        SAFE_STAT(fname, &fbuf);

        for (cnt = 1; cnt < nlinks; cnt++) {
-               sprintf(lname, "%s%d", fname, cnt);
+               sprintf(lname, "%s_%d", fname, cnt);

                SAFE_STAT(lname, &lbuf);
                if (fbuf.st_nlink <= 1 || lbuf.st_nlink <= 1 ||
@@ -49,6 +49,7 @@ static void verify_link(void)
                        break;
                }
        }
+
        if (cnt >= nlinks) {
                tst_res(TPASS,
                         "link(%s, %s[1-%d]) ret %ld for %d files, "
@@ -58,7 +59,7 @@ static void verify_link(void)
        }

        for (cnt = 1; cnt < nlinks; cnt++) {
-               sprintf(lname, "%s%d", fname, cnt);
+               sprintf(lname, "%s_%d", fname, cnt);
                SAFE_UNLINK(lname);
        }
 }

-- 
Regards,
Li Wang

--0000000000003fa0f705cff140ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Patch pushed with the following improvements. Thanks~</div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">--- a/testcases/kernel/syscall=
s/link/link05.c<br>+++ b/testcases/kernel/syscalls/link/link05.c<br>@@ -22,=
19 +22,19 @@ static int nlinks =3D 1000;<br>=C2=A0<br>=C2=A0static void ver=
ify_link(void)<br>=C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 struct stat fbuf, lbuf;=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int cnt;<br>- =C2=A0 =C2=A0 =C2=A0 char lna=
me[255];<br>+ =C2=A0 =C2=A0 =C2=A0 char lname[1024];<br>+ =C2=A0 =C2=A0 =C2=
=A0 struct stat fbuf, lbuf;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (c=
nt =3D 1; cnt &lt; nlinks; cnt++) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sprintf(lname, &quot;%s%d&quot;, fname, cnt);<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_PASS(link(fname, lname), =
&quot;link(%s, %s)&quot;, fname, lname);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sprintf(lname, &quot;%s_%d&quot;, fname, cnt);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_PASS_SILENT(link(f=
name, lname), &quot;link(%s, %s)&quot;, fname, lname);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_STAT(fname, &amp=
;fbuf);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (cnt =3D 1; cnt &lt; n=
links; cnt++) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprin=
tf(lname, &quot;%s%d&quot;, fname, cnt);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sprintf(lname, &quot;%s_%d&quot;, fname, cnt);<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_STAT(ln=
ame, &amp;lbuf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if (fbuf.st_nlink &lt;=3D 1 || lbuf.st_nlink &lt;=3D 1 ||<br>@@ -49,6 +49,=
7 @@ static void verify_link(void)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
}<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cnt &gt;=3D nlinks) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TPASS,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;link(%s, %s[1-%d]) ret %ld for %d files, &quot;<br>@@ -58,7=
 +59,7 @@ static void verify_link(void)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (cnt =3D 1; cnt &lt; nlinks; cnt=
++) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(lname, =
&quot;%s%d&quot;, fname, cnt);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sprintf(lname, &quot;%s_%d&quot;, fname, cnt);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_UNLINK(lname);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>=C2=A0}<br></div></div><div><br></div>-- <br><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div=
><div>Li Wang<br></div></div></div></div>

--0000000000003fa0f705cff140ba--


--===============1964983983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1964983983==--

