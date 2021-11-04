Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64925C43217
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 01:55:25 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8922161106
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 01:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8922161106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55FB23C72F8
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 02:55:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2352E3C71C6
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 02:55:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E12D200B37
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 02:55:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635990908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PuqLoLcCy7WfPXOU9ZebWMWV1KvvCfo6Hf3FJBZ16S0=;
 b=J9vMKp0X10rFFyWFuVmSxpIt8WI6yN+tIug4rS+aP+6IlZVxm/2AEy1iipw/RqkbfQJ5fA
 cJx8wZBOMGa/J3sZx//DkxR++7rUjbCjnymaQelnVTuWLWs+QoRnrmr063o/lk5ORvVFaM
 qFUhuDfGbfWBFBdecyVbGg/dCrAAV80=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-h2XW4WDzPqWpxBSbtNsGOw-1; Wed, 03 Nov 2021 21:55:07 -0400
X-MC-Unique: h2XW4WDzPqWpxBSbtNsGOw-1
Received: by mail-yb1-f199.google.com with SMTP id
 z2-20020a254c02000000b005b68ef4fe24so6698112yba.11
 for <ltp@lists.linux.it>; Wed, 03 Nov 2021 18:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PuqLoLcCy7WfPXOU9ZebWMWV1KvvCfo6Hf3FJBZ16S0=;
 b=UcTlngLpXahcA8lvFjbftZ6NfTDvGkfre2CyGitEUIjtwsuDb0vWYRYooUlveACI4X
 Wil6xeiR1+J19ljLn4ftnu5qO3PfdWumyAXLfgbiZXo0qMypzNpTruOzkxpYPxkf1v2O
 a55kVKkOfFmopOoMlYjwJi28LBVImYR6VHXNbyDV6qBZIvtaQRFLH1ADcZQnh0dBuFg/
 xMQ5f/tl9zGGOL+y7CkrKMK2XHXjj6vwKIsvECwNU4+2YTiNcaWXIvpT7zNO6AsYX6SC
 jMOcNM4VLbybypbEAwxF51Av4O530CQGcodB3XTyebwOFgALiryWlvpQOhC8Ep6e0FGm
 ILsA==
X-Gm-Message-State: AOAM530PP29w8iZkpaDbBLau9N9+WHhtfvk8UGLaaEdSIsx2O4ejcHPq
 zIpbX+nDepoip38BHGClb9dCOObK1F4FrzbdGDJbPAipZOZk69ctrOY8MFYDNzaOFJAu6pPlmqQ
 2iRHuMZMxg/KbrbWQHa4dy52mqSY=
X-Received: by 2002:a25:86c4:: with SMTP id y4mr41307570ybm.144.1635990906593; 
 Wed, 03 Nov 2021 18:55:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCGx9CYIIu4EQKulPJs2ZL/TMXsnGRTINMnICZKTiaGOxfdhk1sg5J6NH/dEnuGwi4fBIhDnS4BPIey4CUAik=
X-Received: by 2002:a25:86c4:: with SMTP id y4mr41307555ybm.144.1635990906363; 
 Wed, 03 Nov 2021 18:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211104002006.11287-1-tangmeng@uniontech.com>
In-Reply-To: <20211104002006.11287-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Nov 2021 09:54:54 +0800
Message-ID: <CAEemH2da+o7-QgYWT5_WrRJHoaBV0oWeSb9J5So_MROQebDV1g@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getdomainname/getdomainname01: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============0175226471=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0175226471==
Content-Type: multipart/alternative; boundary="000000000000d4788c05cfecd0e5"

--000000000000d4788c05cfecd0e5
Content-Type: text/plain; charset="UTF-8"

Hi Meng,

I made some clean-up and pushed.

Changes like:

--- a/testcases/kernel/syscalls/getdomainname/getdomainname01.c
+++ b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
@@ -13,29 +13,16 @@
  * It is intended to provide a limited exposure of the system call.
  */

-#include <errno.h>
 #include <linux/utsname.h>
 #include "tst_test.h"

 #define MAX_NAME_LEN __NEW_UTS_LEN

-static char domain_name[MAX_NAME_LEN];
-
 static void verify_getdomainname(void)
 {
-       /*
-        * Call getdomainname(2)
-        */
-       TEST(getdomainname(domain_name, sizeof(domain_name)));
+       char domain_name[MAX_NAME_LEN];

-       /* check return code */
-       if (TST_RET == -1) {
-               tst_res(TFAIL, "getdomainname() Failed, errno = %d :"
-                        " %s", TST_ERR, strerror(TST_ERR));
-       } else {
-               tst_res(TPASS, "getdomainname() returned %ld ",
-                        TST_RET);
-       }
+       TST_EXP_PASS(getdomainname(domain_name, sizeof(domain_name)));
 }


-- 
Regards,
Li Wang

--000000000000d4788c05cfecd0e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Meng,</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">I =
made some clean-up=C2=A0and pushed.</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Changes like:</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">=
--- a/testcases/kernel/syscalls/getdomainname/getdomainname01.c<br>+++ b/te=
stcases/kernel/syscalls/getdomainname/getdomainname01.c<br>@@ -13,29 +13,16=
 @@<br>=C2=A0 * It is intended to provide a limited exposure of the system =
call.<br>=C2=A0 */<br>=C2=A0<br>-#include &lt;errno.h&gt;<br>=C2=A0#include=
 &lt;linux/utsname.h&gt;<br>=C2=A0#include &quot;tst_test.h&quot;<br>=C2=A0=
<br>=C2=A0#define MAX_NAME_LEN __NEW_UTS_LEN<br>=C2=A0<br>-static char doma=
in_name[MAX_NAME_LEN];<br>-<br>=C2=A0static void verify_getdomainname(void)=
<br>=C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 /*<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
Call getdomainname(2)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>- =C2=A0 =C2=A0=
 =C2=A0 TEST(getdomainname(domain_name, sizeof(domain_name)));<br>+ =C2=A0 =
=C2=A0 =C2=A0 char domain_name[MAX_NAME_LEN];<br>=C2=A0<br>- =C2=A0 =C2=A0 =
=C2=A0 /* check return code */<br>- =C2=A0 =C2=A0 =C2=A0 if (TST_RET =3D=3D=
 -1) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TFAIL,=
 &quot;getdomainname() Failed, errno =3D %d :&quot;<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; %s=
&quot;, TST_ERR, strerror(TST_ERR));<br>- =C2=A0 =C2=A0 =C2=A0 } else {<br>=
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TPASS, &quot;get=
domainname() returned %ld &quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_RET);<br>- =C2=A0 =C2=
=A0 =C2=A0 }<br>+ =C2=A0 =C2=A0 =C2=A0 TST_EXP_PASS(getdomainname(domain_na=
me, sizeof(domain_name)));<br>=C2=A0}<br>=C2=A0<br></div></div><div><br></d=
iv>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000d4788c05cfecd0e5--


--===============0175226471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0175226471==--

