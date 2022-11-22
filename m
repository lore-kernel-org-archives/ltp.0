Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0B1C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 03:53:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8C9A3CCBF2
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 04:53:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11D5D3C03AE
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 04:53:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3BB531457B42
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 04:53:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669089214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+mIZoak2dAgLsHM+14q32PR4u09NL54fIbyY1qJ5i8=;
 b=dqtQv1YqmujaBJ95BgM8rNr3ik4Jc6HbEtGBCZfF7JEdMPPlA712B9mp2BHY7prWKeidfG
 SXdGmhQsaa9nLsKFjC47+6bgiw4LMpWG2Q3wVnV5AbI1zdidOlv0EEyY2tmMaLaV2/Y7+7
 aY7eFQ1O+h19wbJ3xr1MHwR/AWqndxE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-KE8w9LwTNGSNZVoAil7t_w-1; Mon, 21 Nov 2022 22:53:32 -0500
X-MC-Unique: KE8w9LwTNGSNZVoAil7t_w-1
Received: by mail-wr1-f71.google.com with SMTP id
 i24-20020adfa518000000b00241e2f40d8bso132125wrb.14
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 19:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+mIZoak2dAgLsHM+14q32PR4u09NL54fIbyY1qJ5i8=;
 b=tG8cirE85EqNfeKWEPRio5M3Dqw6zDIa3djpA0pjKZQXCkCovzKIYyOHk560a+Z925
 jfoUHqbT2FLK6m4e3SDAAKdN/uXFUeLEA3Hw/UX4l7gtvFft/rQA95UmkwnCCktXuuuq
 XkigzmTTGhLjsO+PfaAJ4YkXNTLmSWwtNQEFBNiyIA/KwkUZnknSXk2gRB5fr2+0T+8O
 oPWqJZ88I5pC4BwwgGk+zlullaFWPhfU7Y4qPeCTkfcGE9U5+6SZ2VqRdTHEhm557BwX
 MyTeNbf5JFqrY2xxpSJLZkQI+7EtrU6PeffEHeWf+Xf/cXZsdweXrWuPPFb1QlzheFSf
 pTYQ==
X-Gm-Message-State: ANoB5pnRsU/Nc0HqFvvNyQ8XnZfI4SgUv/Rb4gVcJREPfBoB7Nxwxtis
 l5WwYGBWGjbBCbKu6aqvRajgvOY4bLlz4R4x4XeMp2j2eJo0v79KD5wegrpSWbJhoJ4LNNGN3hF
 /KTz+jV9a1Xm2WcXGyIBoRAguekg=
X-Received: by 2002:adf:f8c5:0:b0:241:b408:f170 with SMTP id
 f5-20020adff8c5000000b00241b408f170mr13075506wrq.42.1669089210993; 
 Mon, 21 Nov 2022 19:53:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf65LI+cJICGJed3LM9PKDGDixd6d3AJtqhJrYgLE/yDMsBsTRx3aKAwh3a7vcCo4o09r6KUKkkhvPaMcqAcMH8=
X-Received: by 2002:adf:f8c5:0:b0:241:b408:f170 with SMTP id
 f5-20020adff8c5000000b00241b408f170mr13075501wrq.42.1669089210821; Mon, 21
 Nov 2022 19:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20221121115128.27847-1-akumar@suse.de>
In-Reply-To: <20221121115128.27847-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Nov 2022 11:53:19 +0800
Message-ID: <CAEemH2eNByAiwMfvWTGch61WPAiOd-tgKKfWSAdhy7Adi+7HBg@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrlimit01: use TST_EXP_PASS() macro
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
Content-Type: multipart/mixed; boundary="===============1171314025=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1171314025==
Content-Type: multipart/alternative; boundary="00000000000082856805ee071d11"

--00000000000082856805ee071d11
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 21, 2022 at 7:51 PM Avinesh Kumar <akumar@suse.de> wrote:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/getrlimit/getrlimit01.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> index 2a480dfa7..bea37ab1c 100644
> --- a/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> @@ -47,17 +47,9 @@ static void verify_getrlimit(unsigned int i)
>         struct rlimit rlim;
>         struct tcase *tc = &tcases[i];
>
> -       TEST(getrlimit(tc->res, &rlim));
> -
> -       if (TST_RET == -1) {
> -               tst_res(TFAIL | TTERRNO,
> -                       "getrlimit() test %s failed",
> -                       tc->res_str);
> -       } else {
> -               tst_res(TPASS,
> -                       "getrlimit() test %s success",
> -                       tc->res_str);
> -       }
> +       TST_EXP_PASS(getrlimit(tc->res, &rlim),
> +                               "getrlimit() test for resource type %s:",
> +                               tc->res_str);
>

Merged (with print message refined), thanks!



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

--00000000000082856805ee071d11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Nov 21, 2022 at 7:51 PM Avinesh Kumar &lt;<=
a href=3D"mailto:akumar@suse.de">akumar@suse.de</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Avinesh Kumar=
 &lt;<a href=3D"mailto:akumar@suse.de" target=3D"_blank">akumar@suse.de</a>=
&gt;<br>
---<br>
=C2=A0testcases/kernel/syscalls/getrlimit/getrlimit01.c | 14 +++-----------=
<br>
=C2=A01 file changed, 3 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit01.c b/testcases/=
kernel/syscalls/getrlimit/getrlimit01.c<br>
index 2a480dfa7..bea37ab1c 100644<br>
--- a/testcases/kernel/syscalls/getrlimit/getrlimit01.c<br>
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit01.c<br>
@@ -47,17 +47,9 @@ static void verify_getrlimit(unsigned int i)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rlimit rlim;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcase *tc =3D &amp;tcases[i];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST(getrlimit(tc-&gt;res, &amp;rlim));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (TST_RET =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL | TTE=
RRNO,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;getrlimit() test %s failed&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tc-&gt;res_str);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TPASS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;getrlimit() test %s success&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tc-&gt;res_str);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_PASS(getrlimit(tc-&gt;res, &amp;rlim),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;getrlimit() test for resource t=
ype %s:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tc-&gt;res_str);<br></blockquote><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Merg=
ed (with print message refined), thanks!</div><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
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

--00000000000082856805ee071d11--


--===============1171314025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1171314025==--

