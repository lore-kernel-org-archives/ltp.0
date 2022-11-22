Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A6CC4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 03:52:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BFEE3CCBEC
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 04:52:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833853C03AE
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 04:52:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B59D91000EDE
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 04:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669089157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVYjtULupvlS6KyxZVoAY2y+aSq6QWgwp743NIZmObM=;
 b=Bt21TVF61II3G7NjhMNL2mCOBJO9JrvUhqNURUZNxNHiw6GeDjMqRmEeKy2nRvue00V9sM
 zvIQjPOtbb8Ug/bE0UMby8NXPaL3FtF11fMhSKOeZqF/8wVvYRIaJ1onw0puIBeAsF1lpU
 07cMWsj6Pjsilm1i6zorp0D9rj8Lzog=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-e-CqFjXwM3uOo3MekJdfug-1; Mon, 21 Nov 2022 22:52:34 -0500
X-MC-Unique: e-CqFjXwM3uOo3MekJdfug-1
Received: by mail-wr1-f71.google.com with SMTP id
 r23-20020adfa157000000b00241bcae980cso3163262wrr.7
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 19:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVYjtULupvlS6KyxZVoAY2y+aSq6QWgwp743NIZmObM=;
 b=WkRyg06gzUSASZi4V0MsfBbNTdK0Y35w2Ykb04FExRCNdQEtPzfOKM+ThT2MY5IGit
 cgU7SV448FQVPlfM+X1H5uIlVluIf0ZJopUIx0+wtFUdED6Dw0p1D3IJlObtAfemU5vu
 VOFpK7/OKUQeWsEOlI0WUr0Lq5rFqDMmLsS2NMfnFiv0F1AqQ3AmWvVh5Iw/GRGAook9
 nTwnybf7e5YmOXrCJzeB9oZK/I1V2MyHMeHSqn6rph+WuMdpuEjSowkVKTlinE3F9icu
 sesr439L8dSP1ohvmEe63JaUAvPzvH1AjimOD1AGh0r1ud1NlV9SwVVoNC/xX42FjZYg
 etNA==
X-Gm-Message-State: ANoB5plAPPszvCkTXGvynrBDOeoAQEIg8iQxWAzu5lQfbsr0OcXLl1ME
 DY247wKnI5UH4QdSO/D9m00VXSMKTNM2CqbKkOk7l5vnpNSgF+ssVPGrLhvyTGir/ZfICnKSDgT
 WmGM9ejZ1bJLFPLtNcb9Bm5Fu7aw=
X-Received: by 2002:a05:600c:3ba1:b0:3d0:47c:9ff5 with SMTP id
 n33-20020a05600c3ba100b003d0047c9ff5mr7980773wms.121.1669089153169; 
 Mon, 21 Nov 2022 19:52:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5pdYmj6TPfhKDlHSng3UbrQFDQsI7HBwFtejZYgYN/FvaRuCWwCP+WcjDQcTwuOzpjDV8s8RVCIPsefI7nUhU=
X-Received: by 2002:a05:600c:3ba1:b0:3d0:47c:9ff5 with SMTP id
 n33-20020a05600c3ba100b003d0047c9ff5mr7980762wms.121.1669089152916; Mon, 21
 Nov 2022 19:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20221121115038.27564-1-akumar@suse.de>
In-Reply-To: <20221121115038.27564-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Nov 2022 11:52:21 +0800
Message-ID: <CAEemH2dYimufC7OvUe09F47_tyrx7Vj9fW4PiWwnzHVpAfurfQ@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrlimit02: add EFAULT case & use TST_EXP_FAIL()
 macro
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0689844764=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0689844764==
Content-Type: multipart/alternative; boundary="0000000000000ef5ea05ee071a5d"

--0000000000000ef5ea05ee071a5d
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 21, 2022 at 7:51 PM Avinesh Kumar <akumar@suse.de> wrote:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
>

Merged, thanks!

> ---
>  .../kernel/syscalls/getrlimit/getrlimit02.c   | 27 ++++++++-----------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit02.c
> b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
> index 586ca5a67..9b68ce20b 100644
> --- a/testcases/kernel/syscalls/getrlimit/getrlimit02.c
> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
> @@ -18,33 +18,28 @@
>  #include <sys/resource.h>
>  #include "tst_test.h"
>
> -#define RLIMIT_TOO_HIGH 1000
> +#define INVALID_RES_TYPE 1000
>
>  static struct rlimit rlim;
>
>  static struct tcase {
> -       int exp_errno;          /* Expected error no            */
> -       char *exp_errval;       /* Expected error value string  */
> -       struct rlimit *rlim;    /* rlimit structure             */
> -       int res_type;           /* resource type                */
> +       int exp_errno;
> +       char *desc;
> +       struct rlimit *rlim;
> +       int res_type;
>  } tcases[] = {
> -       { EINVAL, "EINVAL", &rlim, RLIMIT_TOO_HIGH}
> +       {EFAULT, "invalid address", (void *)-1, RLIMIT_CORE},
> +       {EINVAL, "invalid resource type", &rlim, INVALID_RES_TYPE}
>  };
>
>  static void verify_getrlimit(unsigned int i)
>  {
>         struct tcase *tc = &tcases[i];
>
> -       TEST(getrlimit(tc->res_type, tc->rlim));
> -
> -       if ((TST_RET == -1) && (TST_ERR == tc->exp_errno)) {
> -               tst_res(TPASS, "expected failure; got %s",
> -                        tc->exp_errval);
> -       } else {
> -               tst_res(TFAIL, "call failed to produce "
> -                        "expected error;  errno: %d : %s",
> -                        TST_ERR, strerror(TST_ERR));
> -       }
> +       TST_EXP_FAIL(getrlimit(tc->res_type, tc->rlim),
> +                               tc->exp_errno,
> +                               "getrlimit() with %s",
> +                               tc->desc);
>  }
>
>  static struct tst_test test = {
> --
> 2.38.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000000ef5ea05ee071a5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Nov 21, 2022 at 7:51 PM Avinesh Kumar &lt;<=
a href=3D"mailto:akumar@suse.de">akumar@suse.de</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Avinesh Kumar=
 &lt;<a href=3D"mailto:akumar@suse.de" target=3D"_blank">akumar@suse.de</a>=
&gt;<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Merged, thanks!</div><div class=3D"gmail_default" style=3D"=
font-size:small"></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0.../kernel/syscalls/getrlimit/getrlimit02.c=C2=A0 =C2=A0| 27 ++++++++=
-----------<br>
=C2=A01 file changed, 11 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit02.c b/testcases/=
kernel/syscalls/getrlimit/getrlimit02.c<br>
index 586ca5a67..9b68ce20b 100644<br>
--- a/testcases/kernel/syscalls/getrlimit/getrlimit02.c<br>
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit02.c<br>
@@ -18,33 +18,28 @@<br>
=C2=A0#include &lt;sys/resource.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
<br>
-#define RLIMIT_TOO_HIGH 1000<br>
+#define INVALID_RES_TYPE 1000<br>
<br>
=C2=A0static struct rlimit rlim;<br>
<br>
=C2=A0static struct tcase {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int exp_errno;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Expected error no=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char *exp_errval;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
Expected error value string=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rlimit *rlim;=C2=A0 =C2=A0 /* rlimit str=
ucture=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int res_type;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* resource type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int exp_errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *desc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rlimit *rlim;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int res_type;<br>
=C2=A0} tcases[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{ EINVAL, &quot;EINVAL&quot;, &amp;rlim, RLIMIT=
_TOO_HIGH}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{EFAULT, &quot;invalid address&quot;, (void *)-=
1, RLIMIT_CORE},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{EINVAL, &quot;invalid resource type&quot;, &am=
p;rlim, INVALID_RES_TYPE}<br>
=C2=A0};<br>
<br>
=C2=A0static void verify_getrlimit(unsigned int i)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcase *tc =3D &amp;tcases[i];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST(getrlimit(tc-&gt;res_type, tc-&gt;rlim));<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((TST_RET =3D=3D -1) &amp;&amp; (TST_ERR =3D=
=3D tc-&gt;exp_errno)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TPASS, &quo=
t;expected failure; got %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tc-&gt;exp_errval);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL, &quo=
t;call failed to produce &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;expected error;=C2=A0 errno: %d : %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 TST_ERR, strerror(TST_ERR));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(getrlimit(tc-&gt;res_type, tc-&gt;=
rlim),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tc-&gt;exp_errno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;getrlimit() with %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tc-&gt;desc);<br>
=C2=A0}<br>
<br>
=C2=A0static struct tst_test test =3D {<br>
-- <br>
2.38.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000000ef5ea05ee071a5d--


--===============0689844764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0689844764==--

