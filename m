Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C364C433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 14:04:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AF0C3CA968
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 16:03:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 579E33CA508
 for <ltp@lists.linux.it>; Tue, 10 May 2022 16:03:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 30D2410002BC
 for <ltp@lists.linux.it>; Tue, 10 May 2022 16:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652191425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=naid7ShUM5IP3GMRjd0OLT6kGDDc2nURjOejGJ6zxIQ=;
 b=QC7CUzVTHttz6DfaizpOb6Nhycz9MUYO9fQNgmy3zTmG30ZYd9bbQtwrvuxgCsjNrxsThO
 Efe6Nr7yyPLrr7Q4RjUZ5eqr5S+rARv4ujBQahtGD5DzvvklJwJ7oG8ZnSpIzHlXjdV+3T
 tB+/7IJkzJW32JQVPyZCk1O6bLCBlGY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-Ty1GYqIaOOeBmGAd37fODw-1; Tue, 10 May 2022 10:03:43 -0400
X-MC-Unique: Ty1GYqIaOOeBmGAd37fODw-1
Received: by mail-yb1-f199.google.com with SMTP id
 r14-20020a25844e000000b00648bdf7491bso14939366ybm.1
 for <ltp@lists.linux.it>; Tue, 10 May 2022 07:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=naid7ShUM5IP3GMRjd0OLT6kGDDc2nURjOejGJ6zxIQ=;
 b=Pg+EjR5F+b/AdEzz/HaWH+q2ee74Y/j9OKimQ7s1TSU3lgKYd4TamHnFbK0NihYb1I
 +FpBkHHbJq2bVKDkG44bK4lDcPQy8Vkz7eusR8OvsUdzWClRtUenOtbF36EyVBNxPJh6
 QgTFD5Nb+iw1iv4irtEUd2Fvn6l+GntwvDNjD5RwU7N2PJotMtfwGd17B/LHlqhOqEkE
 4ZdCV5J2rPecnK6nNXxkUgCZmjFxknyKmb18Jb93MH6igrFmmmNIH93foz/YIGOc/dZ4
 dk+FTol9xs5ACbGQGqP+qNrKzjge8Cquf5LZUqFHYIK6xvT8QO7bjKW/9P5ruA/Qvlv2
 Z10Q==
X-Gm-Message-State: AOAM532gPq/Zl8LKsI/SUiW9qVv8vgb+XpMY+e7nNrTnjy345nYq7mtX
 6yVT+e7kPdq7P0qCcaWpR60fx9biw+yEbu9MjD33V8UNUlXbYNCEn9nVYwQdLNk6gde/5JIkJM8
 tN/cXFOR8Y15gt3+i/dG7gTNY/80=
X-Received: by 2002:a25:b7d3:0:b0:64a:f307:fd91 with SMTP id
 u19-20020a25b7d3000000b0064af307fd91mr6613033ybj.177.1652191422838; 
 Tue, 10 May 2022 07:03:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvVs5ZZdTsjJI4X+G8tfI2cqc+2WFyI1W+59zP3gjUTut1c4XkAwtRsDjunjrjcN0/TfmU8kwNrC3kebnZK7g=
X-Received: by 2002:a25:b7d3:0:b0:64a:f307:fd91 with SMTP id
 u19-20020a25b7d3000000b0064af307fd91mr6612979ybj.177.1652191422288; Tue, 10
 May 2022 07:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz>
In-Reply-To: <20220503174718.21205-2-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 May 2022 22:03:30 +0800
Message-ID: <CAEemH2eydibco7J0nmgzi2DnMi9Z8iGpj5eqHxDXnhNwhmU1Kw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/30] Introduce a concept of max runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1116728261=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1116728261==
Content-Type: multipart/alternative; boundary="000000000000d3ae6b05dea8caf4"

--000000000000d3ae6b05dea8caf4
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


> --- a/doc/user-guide.txt
> +++ b/doc/user-guide.txt
> @@ -25,6 +25,10 @@ For running LTP network tests see
> `testcases/network/README.md`.
>  | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is
> useful for
>                            slow machines to avoid unexpected timeout).
>                            Variable is also used in shell tests, but
> ceiled to int.
> +| 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime.
> Tests
>

Seems 'LTP_RUNTIME_MUL'  does not take effect, maybe there is a bug
in saving multiply runtime to results->max_iteration_runtime?

--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1634,7 +1634,7 @@ void tst_run_tcases(int argc, char *argv[], struct
tst_test *self)
        SAFE_SIGNAL(SIGUSR1, heartbeat_handler);

        if (tst_test->max_iteration_runtime)
-               results->max_iteration_runtime =
tst_test->max_iteration_runtime;
+               results->max_iteration_runtime = multiply_runtime();

        set_timeout();


$ LTP_RUNTIME_MUL=2 ./test_runtime01
tst_test.c:1522: TINFO: Timeout per run is 0h 00m 35s
test_runtime01.c:16: TINFO: Remaining runtime 5
test_runtime01.c:16: TINFO: Remaining runtime 4
test_runtime01.c:16: TINFO: Remaining runtime 3
test_runtime01.c:16: TINFO: Remaining runtime 2
test_runtime01.c:16: TINFO: Remaining runtime 1
test_runtime01.c:16: TINFO: Remaining runtime 0
test_runtime01.c:20: TPASS: Finished loop!

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0


+++ b/lib/newlib_tests/test_runtime02.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021, Linux Test Project
> + */
> +/*
> + * This test is set up so that the timeout is not long enough to guarantee
> + * enough runtime for two iterations, i.e. the timeout without offset and
> after
> + * scaling is too small and the tests ends up with TBROK.
> + *
> + * You can fix this by exporting LTP_MAX_TEST_RUNTIME=10 before executing
> the
>

I didn't find where to achieve this LTP_MAX_TEST_RUNTIME function in the
patchset.


-- 
Regards,
Li Wang

--000000000000d3ae6b05dea8caf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_=
quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
--- a/doc/user-guide.txt<br>
+++ b/doc/user-guide.txt<br>
@@ -25,6 +25,10 @@ For running LTP network tests see `testcases/network/REA=
DME.md`.<br>
=C2=A0| &#39;LTP_TIMEOUT_MUL&#39;=C2=A0 =C2=A0 =C2=A0| Multiply timeout, mu=
st be number &gt;=3D 1 (&gt; 1 is useful for<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0slow machines to avoid unexpected timeout).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Variable is also used in shell tests, but ceiled to=
 int.<br>
+| <span class=3D"gmail_default" style=3D"font-size:small"></span>&#39;LTP_=
RUNTIME_MUL&#39;=C2=A0 =C2=A0 =C2=A0| Multiplies maximal test iteration run=
time. Tests<br></blockquote><div><br></div><div><div class=3D"gmail_default=
" style=3D"font-size:small">Seems=C2=A0<span class=3D"gmail_default"></span=
>&#39;LTP_RUNTIME_MUL&#39;=C2=A0=C2=A0does not take effect, maybe there is =
a bug</div><div class=3D"gmail_default" style=3D"font-size:small">in saving=
 multiply runtime to results-&gt;max_iteration_runtime?</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">--- a/lib/tst_test.c<br>+++ b/lib/tst_test.c=
<br>@@ -1634,7 +1634,7 @@ void tst_run_tcases(int argc, char *argv[], struc=
t tst_test *self)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(SIGUSR1, heart=
beat_handler);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tst_test-&gt;ma=
x_iteration_runtime)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
results-&gt;max_iteration_runtime =3D tst_test-&gt;max_iteration_runtime;<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 results-&gt;max_iterat=
ion_runtime =3D multiply_runtime();<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 set_timeout();<br></div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><br></div><div><div class=3D"gmail_default" style=3D"font=
-size:small">$ LTP_RUNTIME_MUL=3D2 ./test_runtime01</div>tst_test.c:1522: T=
INFO: Timeout per run is 0h 00m 35s<br>test_runtime01.c:16: TINFO: Remainin=
g runtime 5<br>test_runtime01.c:16: TINFO: Remaining runtime 4<br>test_runt=
ime01.c:16: TINFO: Remaining runtime 3<br>test_runtime01.c:16: TINFO: Remai=
ning runtime 2<br>test_runtime01.c:16: TINFO: Remaining runtime 1<br>test_r=
untime01.c:16: TINFO: Remaining runtime 0<br>test_runtime01.c:20: TPASS: Fi=
nished loop!<br><br>Summary:<br>passed =C2=A0 1<br>failed =C2=A0 0<br>broke=
n =C2=A0 0<br>skipped =C2=A00<br>warnings 0<br><div class=3D"gmail_default"=
 style=3D"font-size:small"></div></div><div><br></div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
+++ b/lib/newlib_tests/test_runtime02.c<br>
@@ -0,0 +1,31 @@<br>
+// SPDX-License-Identifier: GPL-2.0-or-later<br>
+/*<br>
+ * Copyright (c) 2021, Linux Test Project<br>
+ */<br>
+/*<br>
+ * This test is set up so that the timeout is not long enough to guarantee=
<br>
+ * enough runtime for two iterations, i.e. the timeout without offset and =
after<br>
+ * scaling is too small and the tests ends up with TBROK.<br>
+ *<br>
+ * You can fix this by exporting LTP_MAX_TEST_RUNTIME=3D10 before executin=
g the<br></blockquote><div><br></div><div><div class=3D"gmail_default" styl=
e=3D"font-size:small">I didn&#39;t find where to achieve=C2=A0this LTP_MAX_=
TEST_RUNTIME function in the patchset.</div></div><div><br></div></div><div=
><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--000000000000d3ae6b05dea8caf4--


--===============1116728261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1116728261==--

