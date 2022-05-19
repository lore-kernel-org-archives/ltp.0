Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD354C433FE
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 10:02:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC2103CAAE4
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 12:02:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C4BD3C0CD0
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:02:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6EFE91000A2E
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652954544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMs0U/6JMcbfup5D3jRLsAw5M6bWHHpqdLXH5BuZk8Y=;
 b=anCBGmfk5nErpiKoy1th2ughS03+OXfwlLQroo4EL+Qffmv8zZgvSsvvuKRDLbHUVsI1Wd
 IPWb9fG5zzUcqXMzd385g0p+EkjiTkL/2zYzJXyFx3xPg5w3/qD0ZOlmgfJD/HCibz9mZ5
 Wdnr7yVlALTTutDkZWFxwUu+0jvwbng=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-W5WL5CkSMNGkcT9aPTRXrA-1; Thu, 19 May 2022 06:02:22 -0400
X-MC-Unique: W5WL5CkSMNGkcT9aPTRXrA-1
Received: by mail-yb1-f198.google.com with SMTP id
 j2-20020a2597c2000000b0064b3e54191aso3943835ybo.20
 for <ltp@lists.linux.it>; Thu, 19 May 2022 03:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yMs0U/6JMcbfup5D3jRLsAw5M6bWHHpqdLXH5BuZk8Y=;
 b=JiYInADxXr1Jd7Bet5MVWE1kI2JrddgRag2wfYmAJRNBWjRuiyZpvUyJ4aASHx2jy7
 tEq5KS+dcdF++uRcIAH3ajUtMa5c0AYQuZ1Xpz3B2CokTU978+cP+CadUf8dPy/4miFO
 r/5lWRmrIDfVgo2U1aAyg8L/dyaLV5Ul2jsOjGEqmHZxpiL1ipCNySVmtiDg1uD+LAFb
 704jXuq0b8yUtTmP1AWz+YQu0BjWD2HybKyadyuYnghZCDoLz2XElSzoDTr9LKPFBmJM
 CjOGmlVQHX0y/5BaSw+8sq/G3vhF4PWd75x10R1yVGlzWFxElNtzxhCD1wlSGy1SG/a+
 mRvA==
X-Gm-Message-State: AOAM531b0P8agdS6tZh/EvfIlh1SZERJ7GPsGnkt1NzFVQ34efGP61mO
 6zkmZ06EfJ/mvqQKomgajJvBK4LQpBbjdu/7/9fOzZ9A5AhY0GKM0I6gTOD8gQqOJezou6i/0dY
 DxDGPjl7W4PotK/H++Qr6zrTow60=
X-Received: by 2002:a25:f312:0:b0:64d:6742:1e80 with SMTP id
 c18-20020a25f312000000b0064d67421e80mr3576174ybs.273.1652954542217; 
 Thu, 19 May 2022 03:02:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD2RWuD0hLfjKS5YzcrqvRXB00NTBjsQA/lviH1coPvSZuH+zngV3HSmXr3QypmI++075U7n5rjnfzbvrTMTU=
X-Received: by 2002:a25:f312:0:b0:64d:6742:1e80 with SMTP id
 c18-20020a25f312000000b0064d67421e80mr3576145ybs.273.1652954541937; Thu, 19
 May 2022 03:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki> <875ym5di8f.fsf@suse.de> <YoN/W4wbow2fyOut@yuki>
 <CAEemH2cazgjqj4C1nuqPcRCC0dZoxwi-yiJymRgJxr0woXXFWw@mail.gmail.com>
 <CAEemH2dYwMczBhFj28yc9xDu0VBg50orjeQBK2s13-8BspK=WQ@mail.gmail.com>
 <YoYIVaJJDzryYNeg@yuki>
In-Reply-To: <YoYIVaJJDzryYNeg@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 May 2022 18:02:10 +0800
Message-ID: <CAEemH2c50gr-G91_4nbdaDkCeGivCg3OQcYN4O0HTzyP2nf_jw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Content-Type: multipart/mixed; boundary="===============1967985918=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1967985918==
Content-Type: multipart/alternative; boundary="0000000000004d699805df5a785d"

--0000000000004d699805df5a785d
Content-Type: text/plain; charset="UTF-8"

On Thu, May 19, 2022 at 5:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Okay, my perspective is shortsighted as well.
> >
> > This solution is correct in the direction but overlooks the significant
> > global value 'tst_start_time'. If that value reflush within tcnt loop we
> > don't need to reset max_runtime again, actually the real work in my
> > previous patch is to invoke heartbeat() which touches tst_start_time.
> >
> > So I would suggest using heartbeat() instead of only sending SIGUSR1
> > to lib_pid. Or, do simply revision like:
>
> Ah, right, I guess that we should just call heartbeat() before each
> iteration of the test then.
>
> So basically:
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index dad8aad92..f3090217b 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1317,6 +1317,24 @@ static void do_cleanup(void)
>         cleanup_ipc();
>  }
>
> +static void heartbeat(void)
> +{
> +       if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
> +               tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> +
> +       if (getppid() == 1) {
> +               tst_res(TFAIL, "Main test process might have exit!");
> +               /*
> +                * We need kill the task group immediately since the
> +                * main process has exit.
> +                */
> +               kill(0, SIGKILL);
> +               exit(TBROK);
> +       }
> +
> +       kill(getppid(), SIGUSR1);
> +}
> +
>  static void run_tests(void)
>  {
>         unsigned int i;
> @@ -1324,6 +1342,7 @@ static void run_tests(void)
>
>         if (!tst_test->test) {
>                 saved_results = *results;
> +               heartbeat();
>                 tst_test->test_all();
>
>                 if (getpid() != main_pid) {
> @@ -1339,6 +1358,7 @@ static void run_tests(void)
>
>         for (i = 0; i < tst_test->tcnt; i++) {
>                 saved_results = *results;
> +               heartbeat();
>                 tst_test->test(i);
>
>                 if (getpid() != main_pid) {
> @@ -1349,6 +1369,8 @@ static void run_tests(void)
>
>                 if (results_equal(&saved_results, results))
>                         tst_brk(TBROK, "Test %i haven't reported
> results!", i);
> +
> +               kill(getppid(), SIGUSR1);
>

As we already invoke heartbeat() at the beginning of each tcnt loop,
why are we still sending SIGUSR1 here?

Otherwise this version looks good to me.



>         }
>  }
>
> @@ -1379,24 +1401,6 @@ static void add_paths(void)
>         free(new_path);
>  }
>
> -static void heartbeat(void)
> -{
> -       if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
> -               tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> -
> -       if (getppid() == 1) {
> -               tst_res(TFAIL, "Main test process might have exit!");
> -               /*
> -                * We need kill the task group immediately since the
> -                * main process has exit.
> -                */
> -               kill(0, SIGKILL);
> -               exit(TBROK);
> -       }
> -
> -       kill(getppid(), SIGUSR1);
> -}
> -
>  static void testrun(void)
>  {
>         unsigned int i = 0;
> @@ -1425,7 +1429,6 @@ static void testrun(void)
>                         break;
>
>                 run_tests();
> -               heartbeat();
>         }
>
>         do_test_cleanup();
>
>
> I guess that this should go in a separate patch on the top of the
> "Introduce concept of max runtime".
>

Agree.


-- 
Regards,
Li Wang

--0000000000004d699805df5a785d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, May 19, 2022 at 5:03 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Okay, my perspective is shortsighted as well.<br>
&gt; <br>
&gt; This solution is correct in the direction but overlooks the significan=
t<br>
&gt; global value &#39;tst_start_time&#39;. If that value reflush within tc=
nt loop we<br>
&gt; don&#39;t need to reset max_runtime again, actually the real work in m=
y<br>
&gt; previous patch is to invoke heartbeat() which touches tst_start_time.<=
br>
&gt; <br>
&gt; So I would suggest using heartbeat() instead of only sending SIGUSR1<b=
r>
&gt; to lib_pid. Or, do simply revision like:<br>
<br>
Ah, right, I guess that we should just call heartbeat() before each<br>
iteration of the test then.<br>
<br>
So basically:<br>
<br>
diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
index dad8aad92..f3090217b 100644<br>
--- a/lib/tst_test.c<br>
+++ b/lib/tst_test.c<br>
@@ -1317,6 +1317,24 @@ static void do_cleanup(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cleanup_ipc();<br>
=C2=A0}<br>
<br>
+static void heartbeat(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_clock_gettime(CLOCK_MONOTONIC, &amp;tst=
_start_time))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TWARN | TER=
RNO, &quot;tst_clock_gettime() failed&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (getppid() =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL, &quo=
t;Main test process might have exit!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We need kill the=
 task group immediately since the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * main process has=
 exit.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kill(0, SIGKILL);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(TBROK);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kill(getppid(), SIGUSR1);<br>
+}<br>
+<br>
=C2=A0static void run_tests(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int i;<br>
@@ -1324,6 +1342,7 @@ static void run_tests(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tst_test-&gt;test) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 saved_results =3D *=
results;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0heartbeat();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_test-&gt;test_a=
ll();<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (getpid() !=3D m=
ain_pid) {<br>
@@ -1339,6 +1358,7 @@ static void run_tests(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; tst_test-&gt;tcnt; i++) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 saved_results =3D *=
results;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0heartbeat();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_test-&gt;test(i=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (getpid() !=3D m=
ain_pid) {<br>
@@ -1349,6 +1369,8 @@ static void run_tests(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (results_equal(&=
amp;saved_results, results))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tst_brk(TBROK, &quot;Test %i haven&#39;t reported results!&quot;=
, i);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kill(getppid(), SIG=
USR1);<br></blockquote><div><br></div><div><div class=3D"gmail_default" sty=
le=3D"font-size:small">As we already invoke heartbeat() at the beginning=C2=
=A0of each tcnt loop,</div><div class=3D"gmail_default" style=3D"font-size:=
small">why are we still=C2=A0sending SIGUSR1 here?</div><div class=3D"gmail=
_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default" =
style=3D"font-size:small">Otherwise this version looks good to me.</div><br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
@@ -1379,24 +1401,6 @@ static void add_paths(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(new_path);<br>
=C2=A0}<br>
<br>
-static void heartbeat(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_clock_gettime(CLOCK_MONOTONIC, &amp;tst=
_start_time))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TWARN | TER=
RNO, &quot;tst_clock_gettime() failed&quot;);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (getppid() =3D=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL, &quo=
t;Main test process might have exit!&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We need kill the=
 task group immediately since the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * main process has=
 exit.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kill(0, SIGKILL);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(TBROK);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0kill(getppid(), SIGUSR1);<br>
-}<br>
-<br>
=C2=A0static void testrun(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int i =3D 0;<br>
@@ -1425,7 +1429,6 @@ static void testrun(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run_tests();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0heartbeat();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_test_cleanup();<br>
<br>
<br>
I guess that this should go in a separate patch on the top of the<br>
&quot;Introduce concept of max runtime&quot;.<br></blockquote><div><br></di=
v><div><div class=3D"gmail_default" style=3D"font-size:small">Agree.</div><=
/div><div class=3D"gmail_default" style=3D"font-size:small"><br></div></div=
><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000004d699805df5a785d--


--===============1967985918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1967985918==--

