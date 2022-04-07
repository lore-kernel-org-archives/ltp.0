Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78E6C433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Apr 2022 07:07:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F1363CA4D7
	for <ltp@archiver.kernel.org>; Thu,  7 Apr 2022 09:07:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EEDF3CA3CC
 for <ltp@lists.linux.it>; Thu,  7 Apr 2022 09:07:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F249680E3E
 for <ltp@lists.linux.it>; Thu,  7 Apr 2022 09:07:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649315245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phILLBYqvIASJ7YDN4XeP9TyNYIo3PMwR6rIu1OSdZU=;
 b=PVCSSh42SCOoxxbCHjxy8r1JYZoMlJ8NXCTtGvcgCEzEs0UlRSmYx6sRB8cg3lWH7yRxRO
 YfVPU0pX7ts5GvBYE9wYVzb7WYOY2rueK1i6Rak7A5ucaKE2JYzFr/2VH4NTz/nCABRKxP
 mWvTtm19/vTmQnAdVRx+O29ic6Ef+RE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-_7qrNDe8MeqfltYMdWfrHQ-1; Thu, 07 Apr 2022 03:07:16 -0400
X-MC-Unique: _7qrNDe8MeqfltYMdWfrHQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2eb8c0ddcf6so41625817b3.10
 for <ltp@lists.linux.it>; Thu, 07 Apr 2022 00:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=phILLBYqvIASJ7YDN4XeP9TyNYIo3PMwR6rIu1OSdZU=;
 b=r1nK0iEedsFR8wBoh696S0o96MqKYj2iiR5x1bouAGvWjGTjoZ2JGUKU3HKEth+0Nx
 nJh4eJnHfzwBCjhmUvqfJYeNoxF1EEXKjgyA5qKuTXMlG4NLnL1tqyf34Yv6l9oUFZvh
 6Ruh+V6yvdKWHZ3P5SU5gKJqElC9p5+28/3w29ITGNwhYs+pMdZbQuGDs8JGbOtSAiuD
 S5mpHW23oXpudmJ/eHBl0KeGLH07lmPBm+/DG0PkpfZkIve87OqZFKy2XDYzMgGedRN2
 EbFcREF24kE38k8iy9PK+ezG8cCO3PV6z1J5qRYZph4BUeozf0dTgt0kkirrgWR/72Cp
 hiYQ==
X-Gm-Message-State: AOAM531wP/sJpI3IgyGnPoGj8Ft22QbsvG/sWv8nGobqdqktQmvG2Tro
 0UyC43MJljTgtbWiKir0jwpHZd5VlZnUwmSz4ISK7aIKCDZ7mlvUUguRSKO1xKdDCp4LhKmgL8L
 XNvalOKGOUZa0m0ih+QegQD5KaaY=
X-Received: by 2002:a5b:28a:0:b0:63d:4556:1c05 with SMTP id
 x10-20020a5b028a000000b0063d45561c05mr9495595ybl.177.1649315236336; 
 Thu, 07 Apr 2022 00:07:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfzJu4h4El5w//iY3gg1r3qQ0r6a7Vql7Ky83aKRluQsXYhOwWCCfYDA7RP+DwWW8mNwTgb99wvP7xL5wdDMc=
X-Received: by 2002:a5b:28a:0:b0:63d:4556:1c05 with SMTP id
 x10-20020a5b028a000000b0063d45561c05mr9495576ybl.177.1649315236027; Thu, 07
 Apr 2022 00:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220405170607.3596657-1-edliaw@google.com>
In-Reply-To: <20220405170607.3596657-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Apr 2022 15:06:58 +0800
Message-ID: <CAEemH2dZiWZjHWMzrRuuiar5YQHF741TMu4p=uMtWgTPG4Oh+w@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fzsync: break inf loop with flag vs
 pthread_cancel
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1053352303=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1053352303==
Content-Type: multipart/alternative; boundary="000000000000c4387f05dc0b20e9"

--000000000000c4387f05dc0b20e9
Content-Type: text/plain; charset="UTF-8"

Hi Edward,

On Wed, Apr 6, 2022 at 1:06 AM Edward Liaw via ltp <ltp@lists.linux.it>
wrote:

> Hi, I'm working to get fzsync working with the Android kernel, which
> does not have pthread_cancel available.
>
> In the absence of pthread_cancel, when thread A exits due to a break,
> thread B will get stuck in an infinite loop while waiting for thread A
> to progress.
>
> Instead of cancelling thread B, we can use the exit flag to break out of
> thread B's loop.  This should also remove the need for the wrapper
> around the thread.
>


This method is more graceful, but involves a new potential issue.

Looking at tst_fzsync_run_a, if anything goes wrong in other places
(thread_b) and break with setting 'pair->exit' to 1 to end the looping.
It doesn't work for thread_a because tst_atomic_store(exit, &pair->exit)
will reset it back to 0 (int exit = 0).

Another suggestion is to distinguish the abnormal invoke for
tst_fzsync_pair_cleanup, because that is rarely a situation we
encounter, no need to reset pair->exit over again.

So better to have this improvement:

--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -232,7 +232,11 @@ static inline void tst_fzsync_pair_init(struct
tst_fzsync_pair *pair)
 static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
        if (pair->thread_b) {
-               tst_atomic_store(1, &pair->exit);
+               /* Terminate thread B if parent hits accidental break */
+               if (!pair->exit) {
+                       tst_atomic_store(1, &pair->exit);
+                       usleep(100000);
+               }
                SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
                pair->thread_b = 0;
        }
@@ -642,7 +646,6 @@ static inline void tst_fzsync_wait_b(struct
tst_fzsync_pair *pair)
  */
 static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 {
-       int exit = 0;
        float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;

        if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
@@ -657,19 +660,18 @@ static inline int tst_fzsync_run_a(struct
tst_fzsync_pair *pair)
        if (pair->exec_time_p < rem_p) {
                tst_res(TINFO,
                        "Exceeded execution time, requesting exit");
-               exit = 1;
+               tst_atomic_store(1, &pair->exit);
        }

        if (++pair->exec_loop > pair->exec_loops) {
                tst_res(TINFO,
                        "Exceeded execution loops, requesting exit");
-               exit = 1;
+               tst_atomic_store(1, &pair->exit);
        }

-       tst_atomic_store(exit, &pair->exit);
        tst_fzsync_wait_a(pair);

-       if (exit) {
+       if (pair->exit) {
                tst_fzsync_pair_cleanup(pair);
                return 0;
        }


-- 
Regards,
Li Wang

--000000000000c4387f05dc0b20e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Edward,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Apr 6, 2022 at 1:06 AM Edward Liaw vi=
a ltp &lt;<a href=3D"mailto:ltp@lists.linux.it" target=3D"_blank">ltp@lists=
.linux.it</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi, I&#39;m working to get fzsync working with the Android kerne=
l, which<br>
does not have pthread_cancel available.<br>
<br>
In the absence of pthread_cancel, when thread A exits due to a break,<br>
thread B will get stuck in an infinite loop while waiting for thread A<br>
to progress.<br>
<br>
Instead of cancelling thread B, we can use the exit flag to break out of<br=
>
thread B&#39;s loop.=C2=A0 This should also remove the need for the wrapper=
<br>
around the thread.<br></blockquote><div><br></div><div><br></div><div><div =
class=3D"gmail_default" style=3D"font-size:small">This method is more grace=
ful, but involves a new potential issue.</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Looking at tst_fzsync_run_a, if anything goes wrong=C2=A0in=
 other=C2=A0places</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">(thread_b) and break with setting &#39;pair-&gt;exit&#39; to 1 to end t=
he looping.=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">It doesn&#39;t work=C2=A0for thread_a because tst_atomic_store(exit, &am=
p;pair-&gt;exit)</div><div class=3D"gmail_default" style=3D"font-size:small=
">will reset it back to 0 (int exit =3D 0).=C2=A0</div><div class=3D"gmail_=
default" style=3D"font-size:small"><br></div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">Another suggestion is to distinguish the abnormal=
=C2=A0invoke for</div><div class=3D"gmail_default" style=3D"font-size:small=
">tst_fzsync_pair_cleanup, because that is rarely a situation we</div><div =
class=3D"gmail_default" style=3D"font-size:small">encounter, no need to res=
et pair-&gt;exit over again.</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">So better to have this improvement:</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">--- a/include/tst_fuzzy_sync.h<br>+++ b/include/tst_fuzzy_sy=
nc.h<br>@@ -232,7 +232,11 @@ static inline void tst_fzsync_pair_init(struct=
 tst_fzsync_pair *pair)<br>=C2=A0static inline void tst_fzsync_pair_cleanup=
(struct tst_fzsync_pair *pair)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (pair-&gt;thread_b) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tst_atomic_store(1, &amp;pair-&gt;exit);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* Terminate thread B if parent hits accidental br=
eak */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pair-&gt;=
exit) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 tst_atomic_store(1, &amp;pair-&gt;exit);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep(10000=
0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_PTHREAD_JOIN(pair-&gt;th=
read_b, NULL);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
air-&gt;thread_b =3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>@@ -642,7 +646,=
6 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)<br>=
=C2=A0 */<br>=C2=A0static inline int tst_fzsync_run_a(struct tst_fzsync_pai=
r *pair)<br>=C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 int exit =3D 0;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 float rem_p =3D 1 - tst_timeout_remaining() / pair-&gt;ex=
ec_time_start;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((pair-&gt;exec_=
time_p * SAMPLING_SLICE &lt; rem_p)<br>@@ -657,19 +660,18 @@ static inline =
int tst_fzsync_run_a(struct tst_fzsync_pair *pair)<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (pair-&gt;exec_time_p &lt; rem_p) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Exceeded =
execution time, requesting exit&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 exit =3D 1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tst_atomic_store(1, &amp;pair-&gt;exit);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (++pair-&gt;exec_l=
oop &gt; pair-&gt;exec_loops) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tst_res(TINFO,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Exceeded execution loop=
s, requesting exit&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 exit =3D 1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts=
t_atomic_store(1, &amp;pair-&gt;exit);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 tst_atomic_store(exit, &amp;pair-&gt;exit)=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_fzsync_wait_a(pair);<br>=C2=A0<br>- =
=C2=A0 =C2=A0 =C2=A0 if (exit) {<br>+ =C2=A0 =C2=A0 =C2=A0 if (pair-&gt;exi=
t) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_fzsync_=
pair_cleanup(pair);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></div></div><div class=3D=
"gmail_default" style=3D"font-size:small"><br></div></div><div><br></div>--=
 <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>

--000000000000c4387f05dc0b20e9--


--===============1053352303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1053352303==--

