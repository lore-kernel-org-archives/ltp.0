Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18714C433F5
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 09:14:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B19FA3CA9F6
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 11:14:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4E73C1BCA
 for <ltp@lists.linux.it>; Fri, 13 May 2022 11:13:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9249E200B9E
 for <ltp@lists.linux.it>; Fri, 13 May 2022 11:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652433230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brS8/9Np02J1ZoY9fBAEnNOZP6vourf7252pIb74fk0=;
 b=buaVy8SlxLQqj5H3X4Rld/8/PAgGakmCae6uGnA0jrVMS4tSKegc79pfn5Z7wRvQUR17FQ
 yMq79QQ5nv0eTgq42BD7zfwpaSma2SuSqvnb3F5XfP9mzBDdwua3r0s0AUfP4ErChGw8yP
 ntwWDpJkK2ezNoErnssaPh056Sk8SOI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-PMsP9CVINgy_UjYl-KZRCg-1; Fri, 13 May 2022 05:13:43 -0400
X-MC-Unique: PMsP9CVINgy_UjYl-KZRCg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2d7eaa730d9so67401157b3.13
 for <ltp@lists.linux.it>; Fri, 13 May 2022 02:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=brS8/9Np02J1ZoY9fBAEnNOZP6vourf7252pIb74fk0=;
 b=bZyeb2xujOmaNeMvpliyPmZblmwab43Asb7m5B3yhUNQn6B4YXRbN/Vm/EIB4hLcxO
 3aWwoWpxEb4sbeGusl5DsGFQUbIP3GsbBNESmc/KMgQzK6JWvkcSE5zGS5AWhaWml6+U
 SlCiJ1yDh4CiKJ+wmeCvxWxJAQDHg1wVrfMHMI6p8yZ7s7nRPIXbTkUvNW6SpMk1N/DZ
 jnyM3RFp8O/E8FJ50Ppyq5H8RY9icRKvgXhf/LlfUPnXxC8eb+e6Yplp894X93K64E0J
 L/7FFLClsOrGThJ0p4Ay/fylONfTYvAYc8C9gcYvtvILOEmGnuuEoQ4L4lkyQ+5sbP7+
 JAOQ==
X-Gm-Message-State: AOAM533HNieRRzwP5BSNx4OMYjCULAkYtiBSWYjb4YUaWjP7UjOPWjdu
 aZVuTI6oUuFOXJrAIxSKx+3/f7SMug+wpdvqh2hD3DFpbRIz/uUs/wR9H8hbvW05Mu8m4bxg/5P
 ywMH+yHBPSQgNb4AaXSssMOx5z5U=
X-Received: by 2002:a25:107:0:b0:645:d3ed:3cb7 with SMTP id
 7-20020a250107000000b00645d3ed3cb7mr3684293ybb.26.1652433222795; 
 Fri, 13 May 2022 02:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyt3RuTGYLcbn/iHRdzKYG82w55bDslHjhBXV7sdyAZZES9LF3iSUo0nUlJbXUX5KxVmpR13a4t9Y2EYVxvxYE=
X-Received: by 2002:a25:107:0:b0:645:d3ed:3cb7 with SMTP id
 7-20020a250107000000b00645d3ed3cb7mr3684271ybb.26.1652433222515; Fri, 13 May
 2022 02:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
In-Reply-To: <20220512123816.24399-23-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 13 May 2022 17:13:31 +0800
Message-ID: <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1717172029=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1717172029==
Content-Type: multipart/alternative; boundary="0000000000003e58f605dee1178a"

--0000000000003e58f605dee1178a
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index 4f09ed416..bef424002 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -160,15 +160,6 @@ struct tst_fzsync_pair {
>         int b_cntr;
>         /** Internal; Used by tst_fzsync_pair_exit() and
> fzsync_pair_wait() */
>         int exit;
> -       /**
> -        * The maximum desired execution time as a proportion of the
> timeout
> -        *
> -        * A value x so that 0 < x < 1 which decides how long the test
> should
> -        * be run for (assuming the loop limit is not exceeded first).
> -        *
> -        * Defaults to 0.5 (~150 seconds with default timeout).
> -        */
> -       float exec_time_p;
>         /** Internal; The test time remaining on tst_fzsync_pair_reset() */
>         float exec_time_start;
>         /**
> @@ -214,7 +205,6 @@ static inline void tst_fzsync_pair_init(struct
> tst_fzsync_pair *pair)
>         CHK(avg_alpha, 0, 1, 0.25);
>         CHK(min_samples, 20, INT_MAX, 1024);
>         CHK(max_dev_ratio, 0, 1, 0.1);
> -       CHK(exec_time_p, 0, 1, 0.5);
>         CHK(exec_loops, 20, INT_MAX, 3000000);
>
>         if (tst_ncpus_available() <= 1)
> @@ -291,7 +281,7 @@ static inline void tst_fzsync_pair_reset(struct
> tst_fzsync_pair *pair,
>         if (run_b)
>                 SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
>
> -       pair->exec_time_start = (float)tst_timeout_remaining();
> +       pair->exec_time_start = (float)tst_remaining_runtime();
>  }
>
>  /**
> @@ -644,10 +634,9 @@ static inline void tst_fzsync_wait_b(struct
> tst_fzsync_pair *pair)
>   */
>  static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
>  {
> -       float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
> +       float rem_p = 1 - tst_remaining_runtime() / pair->exec_time_start;
>
> -       if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
> -               && (pair->sampling > 0)) {
> +       if ((SAMPLING_SLICE < rem_p) && (pair->sampling > 0)) {
>                 tst_res(TINFO, "Stopped sampling at %d (out of %d)
> samples, "
>                         "sampling time reached 50%% of the total time
> limit",
>                         pair->exec_loop, pair->min_samples);
> @@ -655,7 +644,7 @@ static inline int tst_fzsync_run_a(struct
> tst_fzsync_pair *pair)
>                 tst_fzsync_pair_info(pair);
>         }
>
> -       if (pair->exec_time_p < rem_p) {
> +       if (rem_p >= 1) {
>

I hit a new problem while testing new pty03, that seems here
will fall into an infinite loop and test timed out finally. The printf
shows rem_p will be overflow I haven't figured out why.

But with comparing with 0.9, it always gets passed on to the same system.

--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -644,7 +644,7 @@ static inline int tst_fzsync_run_a(struct
tst_fzsync_pair *pair)
                tst_fzsync_pair_info(pair);
        }

-       if (rem_p >= 1) {
+       if (rem_p >= 0.9) {
                tst_res(TINFO,
                        "Exceeded execution time, requesting exit");
                tst_atomic_store(1, &pair->exit);

----------------------
# ./pty03
...
../../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
-90ns, avg_dev =     8ns, dev_ratio = 0.09 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
 2606ns, avg_dev =   127ns, dev_ratio = 0.05 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
 8785ns, avg_dev =   600ns, dev_ratio = 0.07 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
-6269ns, avg_dev =   566ns, dev_ratio = 0.09 }
../../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
 3269  , avg_dev =   200  , dev_ratio = 0.06 }
Test timeouted, sending SIGKILL!
tst_test.c:1573: TINFO: If you are running on slow machine, try exporting
LTP_TIMEOUT_MUL > 1
tst_test.c:1575: TBROK: Test killed! (timeout?)


-- 
Regards,
Li Wang

--0000000000003e58f605dee1178a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_=
quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h<br>
index 4f09ed416..bef424002 100644<br>
--- a/include/tst_fuzzy_sync.h<br>
+++ b/include/tst_fuzzy_sync.h<br>
@@ -160,15 +160,6 @@ struct tst_fzsync_pair {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int b_cntr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** Internal; Used by tst_fzsync_pair_exit() an=
d fzsync_pair_wait() */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int exit;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The maximum desired execution time as a prop=
ortion of the timeout<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * A value x so that 0 &lt; x &lt; 1 which deci=
des how long the test should<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * be run for (assuming the loop limit is not e=
xceeded first).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Defaults to 0.5 (~150 seconds with default t=
imeout).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0float exec_time_p;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** Internal; The test time remaining on tst_fz=
sync_pair_reset() */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 float exec_time_start;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
@@ -214,7 +205,6 @@ static inline void tst_fzsync_pair_init(struct tst_fzsy=
nc_pair *pair)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHK(avg_alpha, 0, 1, 0.25);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHK(min_samples, 20, INT_MAX, 1024);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHK(max_dev_ratio, 0, 1, 0.1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0CHK(exec_time_p, 0, 1, 0.5);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHK(exec_loops, 20, INT_MAX, 3000000);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tst_ncpus_available() &lt;=3D 1)<br>
@@ -291,7 +281,7 @@ static inline void tst_fzsync_pair_reset(struct tst_fzs=
ync_pair *pair,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (run_b)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_PTHREAD_CREATE=
(&amp;pair-&gt;thread_b, 0, run_b, 0);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pair-&gt;exec_time_start =3D (float)tst_timeout=
_remaining();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pair-&gt;exec_time_start =3D (float)tst_remaini=
ng_runtime();<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
@@ -644,10 +634,9 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync=
_pair *pair)<br>
=C2=A0 */<br>
=C2=A0static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0float rem_p =3D 1 - tst_timeout_remaining() / p=
air-&gt;exec_time_start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0float rem_p =3D 1 - tst_remaining_runtime() / p=
air-&gt;exec_time_start;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((pair-&gt;exec_time_p * SAMPLING_SLICE &lt;=
 rem_p)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; (pair-&g=
t;sampling &gt; 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((SAMPLING_SLICE &lt; rem_p) &amp;&amp; (pai=
r-&gt;sampling &gt; 0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quo=
t;Stopped sampling at %d (out of %d) samples, &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;sampling time reached 50%% of the total time limit&quot;,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pair-&gt;exec_loop, pair-&gt;min_samples);<br>
@@ -655,7 +644,7 @@ static inline int tst_fzsync_run_a(struct tst_fzsync_pa=
ir *pair)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_fzsync_pair_inf=
o(pair);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pair-&gt;exec_time_p &lt; rem_p) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rem_p &gt;=3D 1) {<br></blockquote><div><br=
></div><div class=3D"gmail_default" style=3D"font-size:small">I hit a new p=
roblem while testing new pty03, that seems here</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">will fall into an infinite loop and test t=
imed out finally. The printf</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">shows rem_p will be overflow I haven&#39;t figured out why.</=
div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">But with comparing with 0.=
9, it always gets passed=C2=A0on to the same system.</div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">--- a/include/tst_fuzzy_sync.h<br>+++ b/include=
/tst_fuzzy_sync.h<br>@@ -644,7 +644,7 @@ static inline int tst_fzsync_run_a=
(struct tst_fzsync_pair *pair)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 tst_fzsync_pair_info(pair);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 if (rem_p &gt;=3D 1) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 if (rem_p &gt;=3D 0.9) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 tst_res(TINFO,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Exceeded execution t=
ime, requesting exit&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tst_atomic_store(1, &amp;pair-&gt;exit);<br></div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">----------------------</div><div class=
=3D"gmail_default" style=3D"font-size:small"># ./pty03<br>...<br>../../../i=
nclude/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =3D =C2=A0 -90=
ns, avg_dev =3D =C2=A0 =C2=A0 8ns, dev_ratio =3D 0.09 }<br>../../../include=
/tst_fuzzy_sync.h:295: TINFO: end_a - start_a =C2=A0: { avg =3D =C2=A02606n=
s, avg_dev =3D =C2=A0 127ns, dev_ratio =3D 0.05 }<br>../../../include/tst_f=
uzzy_sync.h:295: TINFO: end_b - start_b =C2=A0: { avg =3D =C2=A08785ns, avg=
_dev =3D =C2=A0 600ns, dev_ratio =3D 0.07 }<br>../../../include/tst_fuzzy_s=
ync.h:295: TINFO: end_a - end_b =C2=A0 =C2=A0: { avg =3D -6269ns, avg_dev =
=3D =C2=A0 566ns, dev_ratio =3D 0.09 }<br>../../../include/tst_fuzzy_sync.h=
:295: TINFO: spins =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: { avg =3D =C2=
=A03269 =C2=A0, avg_dev =3D =C2=A0 200 =C2=A0, dev_ratio =3D 0.06 }<br>Test=
 timeouted, sending SIGKILL!<br>tst_test.c:1573: TINFO: If you are running =
on slow machine, try exporting LTP_TIMEOUT_MUL &gt; 1<br>tst_test.c:1575: T=
BROK: Test killed! (timeout?)<br></div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div></div><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--0000000000003e58f605dee1178a--


--===============1717172029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1717172029==--

