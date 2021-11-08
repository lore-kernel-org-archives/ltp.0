Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB40C433F5
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 07:18:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E34C61157
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 07:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E34C61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 935DE3C763B
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 08:18:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBB783C702E
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 08:18:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A4DEF10006D5
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 08:18:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636355908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RNesqsapmTcb5A7i8bMfyxrcz30za2PLZ6ahCXhb+mY=;
 b=E+1r7aCv2ykETPJYxZ4zV6Y5FDVx9HaFkdWloxfAKMznJWozteFAh+m181eWynbJn81tbl
 5Nfclb3aOuQwqREWPQ6Q/J3tqiVqSC64uhzoF80akCv6+SlP9xadC8fHlSRdrQrI1EGIze
 2BogAEqH+2fOeUA8+3ZGExqwllXEOqs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-uLlCdofxN7Ssmx_UKudj1g-1; Mon, 08 Nov 2021 02:18:26 -0500
X-MC-Unique: uLlCdofxN7Ssmx_UKudj1g-1
Received: by mail-yb1-f199.google.com with SMTP id
 m78-20020a252651000000b005c1f44d3c7bso24054883ybm.22
 for <ltp@lists.linux.it>; Sun, 07 Nov 2021 23:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RNesqsapmTcb5A7i8bMfyxrcz30za2PLZ6ahCXhb+mY=;
 b=c+CVaqWf7wM5Rak4w+f/fm8LQHAQ6WGsY2fXbR+zDi5amnR9Y6KqvOQgUeAS/5M6mC
 fDdc0TY7dTSX5ODsJyNUyxajOVNc9KjDTd65+qUmUeLId/QeWZB41O7zrgqJYnm+KeyT
 RMCm/zZCuc9KqfN3mVUkrIOcP/0xSKpKHJXlog78Z2so5HSO6DVMAPslYg/kVddv+wUo
 KVf6KGLBHzlBTH6tXcGphydV/hcK42zPGbx5BsRSCWxauMIA6CPCOciteRb5C5VbQX6/
 HPQI2UAS4yAppF1eRn3dGV6MmVp9lL1ZH05Pdsz8+ej6vGYmMIJwHlJsaqOzc1oDnC68
 sN8g==
X-Gm-Message-State: AOAM531b/xEpR2SH16/W9d06yhmlrlOz7ccG7+jolJjzb817TzdpzLG6
 ikL4Z5Jq5NQy7Dcn6YKBr99wCZKcA747PJe4vy5Cn0VvZwnf4bnIBHpJ23QZHyfK9ThV0v5uctw
 jlASxaJftVNDYymTdCXiFHEWX57Y=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr67692818ybi.186.1636355906130; 
 Sun, 07 Nov 2021 23:18:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjgPYFN2eWNRqM5YZGfe3FqvRy+K/RcPfrP/Wy+skgemoPB8uBpZcwEAnEoakDMu3vzjcHv2MB5v88g6ridao=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr67692800ybi.186.1636355905909; 
 Sun, 07 Nov 2021 23:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20211108053225.23442-1-tangmeng@uniontech.com>
In-Reply-To: <20211108053225.23442-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Nov 2021 15:18:13 +0800
Message-ID: <CAEemH2ch_nJTopAs3nJsS+TbOGbNC7wYEx6uHkSuoCsGN=qA2A@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] fchdir/fchdir01: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============0641052494=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0641052494==
Content-Type: multipart/alternative; boundary="0000000000007f91d905d041cc4b"

--0000000000007f91d905d041cc4b
Content-Type: text/plain; charset="UTF-8"

> -void check_functionality(void)
> +static void verify_fchdir(void)
>  {
> -       char *buf = NULL;
> -       char *dir;
> +       if ((fd = open(TEST_DIR, O_RDONLY)) == -1)
>

If making use of SAFE_OPEN, then we can save time for the error
checking over and over again.

And better move this into setup() to make "-i x" happy.

Btw, plz remember to close the fd in cleanup().

I made some improvement work as below and pushed:

--- a/testcases/kernel/syscalls/fchdir/fchdir01.c
+++ b/testcases/kernel/syscalls/fchdir/fchdir01.c
@@ -17,19 +17,23 @@ static const char *TEST_DIR = "alpha";

 static void verify_fchdir(void)
 {
-       if ((fd = open(TEST_DIR, O_RDONLY)) == -1)
-               tst_brk(TBROK, "open of directory failed");
-
        TST_EXP_PASS(fchdir(fd));
 }

 static void setup(void)
 {
        SAFE_MKDIR(TEST_DIR, MODES);
+       fd = SAFE_OPEN(TEST_DIR, O_RDONLY);
+}
+
+static void cleanup(void)
+{
+       SAFE_CLOSE(fd);
 }

 static struct tst_test test = {
        .test_all = verify_fchdir,
        .setup = setup,
+       .cleanup = cleanup,
        .needs_tmpdir = 1,
 };

-- 
Regards,
Li Wang

--0000000000007f91d905d041cc4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
-void check_functionality(void)<br>
+static void verify_fchdir(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char *dir;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fd =3D open(TEST_DIR, O_RDONLY)) =3D=3D -1=
)<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font=
-size:small">If making use of SAFE_OPEN, then we can save time for the erro=
r</div><div class=3D"gmail_default">checking over and over again.=C2=A0</di=
v><div class=3D"gmail_default"><br></div><div class=3D"gmail_default">And b=
etter move this into setup() to make &quot;-i x&quot; happy.</div><div clas=
s=3D"gmail_default"><br></div><div class=3D"gmail_default" style=3D"font-si=
ze:small">Btw, plz remember to close the fd in cleanup().</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">I made some improvement work as below an=
d pushed:</div><div class=3D"gmail_default" style=3D"font-size:small"><br><=
/div><div class=3D"gmail_default" style=3D"font-size:small">--- a/testcases=
/kernel/syscalls/fchdir/fchdir01.c<br>+++ b/testcases/kernel/syscalls/fchdi=
r/fchdir01.c<br>@@ -17,19 +17,23 @@ static const char *TEST_DIR =3D &quot;a=
lpha&quot;;<br>=C2=A0<br>=C2=A0static void verify_fchdir(void)<br>=C2=A0{<b=
r>- =C2=A0 =C2=A0 =C2=A0 if ((fd =3D open(TEST_DIR, O_RDONLY)) =3D=3D -1)<b=
r>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK, &quot;o=
pen of directory failed&quot;);<br>-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP=
_PASS(fchdir(fd));<br>=C2=A0}<br>=C2=A0<br>=C2=A0static void setup(void)<br=
>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_MKDIR(TEST_DIR, MODES);<br>+ =
=C2=A0 =C2=A0 =C2=A0 fd =3D SAFE_OPEN(TEST_DIR, O_RDONLY);<br>+}<br>+<br>+s=
tatic void cleanup(void)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 SAFE_CLOSE(fd);<br=
>=C2=A0}<br>=C2=A0<br>=C2=A0static struct tst_test test =3D {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 .test_all =3D verify_fchdir,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .setup =3D setup,<br>+ =C2=A0 =C2=A0 =C2=A0 .cleanup =3D cleanup,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_tmpdir =3D 1,<br>=C2=A0};<br></div></div=
><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000007f91d905d041cc4b--


--===============0641052494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0641052494==--

