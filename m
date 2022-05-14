Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EB1C433F5
	for <ltp@archiver.kernel.org>; Sat, 14 May 2022 04:21:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ADF43CAA0A
	for <ltp@archiver.kernel.org>; Sat, 14 May 2022 06:21:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01C1B3C0717
 for <ltp@lists.linux.it>; Sat, 14 May 2022 06:21:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D32AC6018BD
 for <ltp@lists.linux.it>; Sat, 14 May 2022 06:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652502084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x34UDFwURA02lyIH2Zu04dNZGPgcmwVhjpis1FuVK4Q=;
 b=RJh1IY05jZ7F0d+rmqX7L6Cm+VAnfFDIEYVl1/tFupySHcMEcIHqk74CNvOJU20RjHXnN2
 C+ULKP0xXW9wp+K/gGgLEHoK/wbjy6AhdH+44TEWfQQvOuFzJoXA/fZddghz6zQaGn0pEr
 QuaT6bExZJ9NzZPKBU0Vh8UxUQdOU1Q=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-iTFl65OGNJmuYYT0u6CW2Q-1; Sat, 14 May 2022 00:21:19 -0400
X-MC-Unique: iTFl65OGNJmuYYT0u6CW2Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 f201-20020a2538d2000000b0064d6dbc76d2so68924yba.6
 for <ltp@lists.linux.it>; Fri, 13 May 2022 21:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x34UDFwURA02lyIH2Zu04dNZGPgcmwVhjpis1FuVK4Q=;
 b=5d6RxTNf27Xvl4XoxAvZXTgcmVRYhDnK6GQUUOBIIyh3/uc6pAHl3XeBv/OTuFwAEh
 1Rw0IZ45Efp6ypxQfSE8oDV9qrt1+S9jkImAhsR8mXJhRidn+kPLTwr3VDj2w0fRj3oA
 WdkwGg2natQKE/l7VvwacT6mD/sya/I+F+AFpxgU/PQWkxOLg1BxX/eDKQFTePqGXC25
 VYt7mSSDPizbuPgtEyimbAoEnDPp7FBdfAcDasCOmHujNXbb6LVlJFE9GMt1MWEO383M
 6N3O72Oihy871odOjoboqOxDgajzeADRqK2EE+3lJTt2+elXJ5JsaDxRzkNctWMsIDm5
 IO/A==
X-Gm-Message-State: AOAM531Te/+6sB+M4lyoBR8SmAFSRH/WoRwpuedIvMULGU+TKyO0m4Zk
 b1VuJo76hwvN6yereOjV9481ejxOe7g3RJ/1iPly80sPlE1rDGG3BFvgLzI29OGlVUZW7ZUVkWu
 mRPkqLYjsuB2rxixv6alHCnrTYLg=
X-Received: by 2002:a25:a081:0:b0:649:12da:9996 with SMTP id
 y1-20020a25a081000000b0064912da9996mr8204593ybh.161.1652502079134; 
 Fri, 13 May 2022 21:21:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcSb1VIoCrffYZ/cjgZ+iRVXiTHIeio5azvpoJfSTJFBIG9w0W/sbjXymmpH9XozoPL2HiJZK9CqX8IZ4GwxU=
X-Received: by 2002:a25:a081:0:b0:649:12da:9996 with SMTP id
 y1-20020a25a081000000b0064912da9996mr8204586ybh.161.1652502078908; Fri, 13
 May 2022 21:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-2-chrubis@suse.cz>
In-Reply-To: <20220512123816.24399-2-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 14 May 2022 12:21:08 +0800
Message-ID: <CAEemH2dnwFBJxqPxjzLo7GiVOp-dng79jMN0V_Z1ZBzAvVx+gg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 01/29] Introduce a concept of max runtime
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
Content-Type: multipart/mixed; boundary="===============0901347065=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0901347065==
Content-Type: multipart/alternative; boundary="000000000000678a9e05def11f84"

--000000000000678a9e05def11f84
Content-Type: text/plain; charset="UTF-8"

On Thu, May 12, 2022 at 8:36 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> This commit introduces a concept of max test runtime. In other words
> test runtime is capped at a certain value in order to make testruns more
> deterministic. Test is free to to finish before the runtime is used up,
> for example when maximal number of iterations was reached, but test must
> stop once the runtime has been used up.
>
> Testcases that run for more than a second or two must check for
> remaining runtime by regular calls to tst_remaining_runtime() and should
> exit when zero is returned.
>
> The test max runtime must be set either by the .max_iteration_runtime in
>

.max_runtime



> the tst_test structure or in the test setup by a call to
> tst_set_runtime().
>

tst_set_max_runtime()



>
> The test timeout is then computed as a sum of DEFAULT_TIMEOUT (currently
> set to 30 seconds) and the test runtime. The DEFAULT_TIMEOUT is nothing
> more than a safety margin for teardown of the test.
>
> This commit also maps the -I parameter to the test max runtime if
> available and introduces LTP_RUNTIME_MUL enviroment variable so that we
> have an easy controll over the runtime cap.
>
> Lastly but not least the function related to the timeout are turned into
> no-op by this commit and removed after all test are converted to the
> runtime API.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/c-test-api.txt                       |  42 +++++--
>  doc/user-guide.txt                       |  30 ++++-
>  include/tst_test.h                       |  27 ++++
>  lib/newlib_tests/.gitignore              |   5 +-
>  lib/newlib_tests/runtest.sh              |   2 +-
>  lib/newlib_tests/test10.c                |  22 ----
>  lib/newlib_tests/test12.c                |  21 ----
>  lib/newlib_tests/test13.c                |   1 -
>  lib/newlib_tests/test18.c                |  22 ----
>  lib/newlib_tests/test_children_cleanup.c |   1 -
>  lib/newlib_tests/test_runtime01.c        |  30 +++++
>  lib/newlib_tests/test_runtime02.c        |  28 +++++
>  lib/tst_test.c                           | 150 +++++++++++++++++------
>  13 files changed, 264 insertions(+), 117 deletions(-)
>  delete mode 100644 lib/newlib_tests/test10.c
>  delete mode 100644 lib/newlib_tests/test12.c
>  delete mode 100644 lib/newlib_tests/test18.c
>  create mode 100644 lib/newlib_tests/test_runtime01.c
>  create mode 100644 lib/newlib_tests/test_runtime02.c
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 9f104ecd7..711b445d9 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -93,14 +93,35 @@ in range of [0, '.tcnt' - 1].
>
>  IMPORTANT: Only one of '.test' and '.test_all' can be set at a time.
>
> -Each test has a default timeout set to 300s. The default timeout can be
> -overridden by setting '.timeout' in the test structure or by calling
> -'tst_set_timeout()' in the test 'setup()'. There are a few testcases
> whose run
> -time may vary arbitrarily, for these timeout can be disabled by setting
> it to
> --1.
> +Each test has a limit on how long it can run and the limit composes of two
> +parts max_runtime and timeout. The max_runtime is a limit for how long
> can the
> +'.test_all' or a set of '.test' functions take and the timeout is static
> part
> +that should cover the duration of test setup and cleanup plus some safety.
>
> -Test can find out how much time (in seconds) is remaining to timeout,
> -by calling 'tst_timeout_remaining()'.
> +Any test that runs for more than a second or two has to make sure to:
> +
> +- set the runtime either by setting the '.max_runtime' in tst_test or by
> +  calling 'tst_set_runtime()' in the test setup
>

     ^ calling 'tst_set_max_runtime()'

Apart from the patch-22 tiny issue, the rest part looks good.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000678a9e05def11f84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, May 12, 2022 at 8:36 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This comm=
it introduces a concept of max test runtime. In other words<br>
test runtime is capped at a certain value in order to make testruns more<br=
>
deterministic. Test is free to to finish before the runtime is used up,<br>
for example when maximal number of iterations was reached, but test must<br=
>
stop once the runtime has been used up.<br>
<br>
Testcases that run for more than a second or two must check for<br>
remaining runtime by regular calls to tst_remaining_runtime() and should<br=
>
exit when zero is returned.<br>
<br>
The test max runtime must be set either by the .max_iteration_runtime in<br=
></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"fon=
t-size:small">.max_runtime</div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
the tst_test structure or in the test setup by a call to<br>
tst_set_runtime().<br></blockquote><div><br></div><div><div class=3D"gmail_=
default" style=3D"font-size:small">tst_set_max_runtime()</div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The test timeout is then computed as a sum of DEFAULT_TIMEOUT (currently<br=
>
set to 30 seconds) and the test runtime. The DEFAULT_TIMEOUT is nothing<br>
more than a safety margin for teardown of the test.<br>
<br>
This commit also maps the -I parameter to the test max runtime if<br>
available and introduces LTP_RUNTIME_MUL enviroment variable so that we<br>
have an easy controll over the runtime cap.<br>
<br>
Lastly but not least the function related to the timeout are turned into<br=
>
no-op by this commit and removed after all test are converted to the<br>
runtime API.<br>
<br>
Signed-off-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=
=3D"_blank">chrubis@suse.cz</a>&gt;<br>
---<br>
=C2=A0doc/c-test-api.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 42 +++++--<br>
=C2=A0doc/user-guide.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 30 ++++-<br>
=C2=A0include/tst_test.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 27 ++++<br>
=C2=A0lib/newlib_tests/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A0lib/newlib_tests/runtest.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0lib/newlib_tests/test10.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 22 ----<br>
=C2=A0lib/newlib_tests/test12.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 21 ----<br>
=C2=A0lib/newlib_tests/test13.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 -<br>
=C2=A0lib/newlib_tests/test18.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 22 ----<br>
=C2=A0lib/newlib_tests/test_children_cleanup.c |=C2=A0 =C2=A01 -<br>
=C2=A0lib/newlib_tests/test_runtime01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
30 +++++<br>
=C2=A0lib/newlib_tests/test_runtime02.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
28 +++++<br>
=C2=A0lib/tst_test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 150 +++++++++++++++++------<br>
=C2=A013 files changed, 264 insertions(+), 117 deletions(-)<br>
=C2=A0delete mode 100644 lib/newlib_tests/test10.c<br>
=C2=A0delete mode 100644 lib/newlib_tests/test12.c<br>
=C2=A0delete mode 100644 lib/newlib_tests/test18.c<br>
=C2=A0create mode 100644 lib/newlib_tests/test_runtime01.c<br>
=C2=A0create mode 100644 lib/newlib_tests/test_runtime02.c<br>
<br>
diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt<br>
index 9f104ecd7..711b445d9 100644<br>
--- a/doc/c-test-api.txt<br>
+++ b/doc/c-test-api.txt<br>
@@ -93,14 +93,35 @@ in range of [0, &#39;.tcnt&#39; - 1].<br>
<br>
=C2=A0IMPORTANT: Only one of &#39;.test&#39; and &#39;.test_all&#39; can be=
 set at a time.<br>
<br>
-Each test has a default timeout set to 300s. The default timeout can be<br=
>
-overridden by setting &#39;.timeout&#39; in the test structure or by calli=
ng<br>
-&#39;tst_set_timeout()&#39; in the test &#39;setup()&#39;. There are a few=
 testcases whose run<br>
-time may vary arbitrarily, for these timeout can be disabled by setting it=
 to<br>
--1.<br>
+Each test has a limit on how long it can run and the limit composes of two=
<br>
+parts max_runtime and timeout. The max_runtime is a limit for how long can=
 the<br>
+&#39;.test_all&#39; or a set of &#39;.test&#39; functions take and the tim=
eout is static part<br>
+that should cover the duration of test setup and cleanup plus some safety.=
<br>
<br>
-Test can find out how much time (in seconds) is remaining to timeout,<br>
-by calling &#39;tst_timeout_remaining()&#39;.<br>
+Any test that runs for more than a second or two has to make sure to:<br>
+<br>
+- set the runtime either by setting the &#39;.max_runtime&#39; in tst_test=
 or by<br>
+=C2=A0 calling &#39;tst_set_runtime()&#39; in the test setup<br></blockquo=
te><div><br></div><div class=3D"gmail_default" style=3D"font-size:small">=
=C2=A0 =C2=A0 =C2=A0^ calling &#39;tst_set_max_runtime()&#39;</div><div cla=
ss=3D"gmail_quote"><div class=3D"gmail_default"><br></div><div class=3D"gma=
il_default">Apart from the patch-22 tiny issue, the rest part looks good.</=
div><div class=3D"gmail_default"><br></div><div class=3D"gmail_default"></d=
iv></div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-by=
: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang=
@redhat.com</a>&gt;</div><div class=3D"gmail_default" style=3D"font-size:sm=
all"><br></div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr=
"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000678a9e05def11f84--


--===============0901347065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0901347065==--

