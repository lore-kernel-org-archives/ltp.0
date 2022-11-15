Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA68C4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 04:01:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAF403CD278
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 05:01:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6165C3CD213
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 05:01:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F2846600664
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 05:01:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668484872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Do/z9RIWZgWtK1D5qMhW96ee4oqZQhq85Q5+6tMSPbk=;
 b=H0PWuCZUCB1D+/pac88IflXMfl1F5nSSIGbcDKs+oLbw1FAa6dUxNd4kh8BoAAxUPO7STX
 TkMtie2tUXBhA5ivMq5UgJ43kYkLquQU5l2GvpezEsRO1GE4wxELH/5ec/Slbqa0TtbUIz
 SGMPrSRofkqLjtc6IhtLCNr/dk20W2Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-etMsPCuGM1WgcSC85nn_KQ-1; Mon, 14 Nov 2022 23:01:10 -0500
X-MC-Unique: etMsPCuGM1WgcSC85nn_KQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 bi19-20020a05600c3d9300b003cf9d6c4016so9922954wmb.8
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 20:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Do/z9RIWZgWtK1D5qMhW96ee4oqZQhq85Q5+6tMSPbk=;
 b=fxtO1+3VSlMCd7yIHhdzi3+LLaF6gtRtbOSJ7G/odJWn5AzbSr6Eerpgl4NcdgUxgG
 yCwsdqXsRn15kKeyB0enPEedIggEsxTRI9FdyN2P7Kq4Cfd0NQqAnc712Mc0fzQkUgTj
 ebHI0CRR9HUtR0Fkt+z1DBCAdA3wS1oy31KE26rSULUBYA8hc4VBT7YSdGp8bYtgxftC
 FYbAXYC7hpBhHSNUJwCyULjb5OVk+a3mDiHt/VP6GXGHFjmm35B7kfOIAOeRzduDQFUU
 tYO0fihcp/x4C9Y1ZjSeTSZjX3PUL2ouPfipjWQJ74woBBF3Fp72YljNCvGPKBtha+Bw
 hqgw==
X-Gm-Message-State: ANoB5pnWO/EreIvd0PYVpQR5juq9v19Qvi9eYqH41XR4O89TShL+mMXS
 aePr9+KW6CrWTT9Muk9BuQFx4U0xP8yrG0fxVJ6Ag/Ro8C3m21oiXgLs2Ddx9eMRFWekJ7U3akr
 9sSlPn1mRmmrcDttZyy0rY3l93N4=
X-Received: by 2002:a5d:4042:0:b0:236:8322:4bd5 with SMTP id
 w2-20020a5d4042000000b0023683224bd5mr9020570wrp.129.1668484868708; 
 Mon, 14 Nov 2022 20:01:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4U3E8jDR596IoyInLDoY21wSYPJ54/0oUX7tVOjVOJdYsaEX/lepjJgpembP+44haRyLu3UzIe9he2OPbluVY=
X-Received: by 2002:a5d:4042:0:b0:236:8322:4bd5 with SMTP id
 w2-20020a5d4042000000b0023683224bd5mr9020565wrp.129.1668484868475; Mon, 14
 Nov 2022 20:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20221112040107.3953862-1-liwang@redhat.com>
 <87pmdpsfdv.fsf@suse.de>
In-Reply-To: <87pmdpsfdv.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Nov 2022 12:00:56 +0800
Message-ID: <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
To: rpalethorpe@suse.de, Andrea Cervesato <acervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
Content-Type: multipart/mixed; boundary="===============0846105604=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0846105604==
Content-Type: multipart/alternative; boundary="000000000000e625eb05ed7a6795"

--000000000000e625eb05ed7a6795
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 14, 2022 at 11:52 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Li Wang <liwang@redhat.com> writes:
>
> > Split checking the return ovalue from testing the signal is
> > delivered, so that we could use two time value for verifying.
> >
> > Also, adding interval timer test by handling the signal at
> > least 10 times. After that recover the signal behavior to
> > default and do deliver-signal checking.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  .../kernel/syscalls/setitimer/setitimer01.c   | 63 ++++++++++++-------
> >  1 file changed, 39 insertions(+), 24 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c
> b/testcases/kernel/syscalls/setitimer/setitimer01.c
> > index 1f631d457..260590b0e 100644
> > --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> > +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> > @@ -22,8 +22,10 @@
> >  #include "tst_safe_clocks.h"
> >
> >  static struct itimerval *value, *ovalue;
> > +static volatile unsigned long sigcnt;
> >  static long time_step;
> > -static long time_count;
> > +static long time_sec;
> > +static long time_usec;
> >
> >  static struct tcase {
> >       int which;
> > @@ -40,54 +42,66 @@ static int sys_setitimer(int which, void *new_value,
> void *old_value)
> >       return tst_syscall(__NR_setitimer, which, new_value, old_value);
> >  }
> >
> > -static void set_setitimer_value(int usec, int o_usec)
> > +static void sig_routine(int signo LTP_ATTRIBUTE_UNUSED)
> >  {
> > -     value->it_value.tv_sec = 0;
> > -     value->it_value.tv_usec = usec;
> > -     value->it_interval.tv_sec = 0;
> > -     value->it_interval.tv_usec = 0;
> > +     sigcnt++;
> > +}
> >
> > -     ovalue->it_value.tv_sec = o_usec;
> > -     ovalue->it_value.tv_usec = o_usec;
> > -     ovalue->it_interval.tv_sec = 0;
> > -     ovalue->it_interval.tv_usec = 0;
> > +static void set_setitimer_value(int sec, int usec)
> > +{
> > +     value->it_value.tv_sec = sec;
> > +     value->it_value.tv_usec = usec;
> > +     value->it_interval.tv_sec = sec;
> > +     value->it_interval.tv_usec = usec;
> >  }
> >
> >  static void verify_setitimer(unsigned int i)
> >  {
> >       pid_t pid;
> >       int status;
> > -     long margin;
> >       struct tcase *tc = &tcases[i];
> >
> > +     tst_res(TINFO, "tc->which = %s", tc->des);
> > +
> >       pid = SAFE_FORK();
> >
> >       if (pid == 0) {
> > -             tst_res(TINFO, "tc->which = %s", tc->des);
> > -
> >               tst_no_corefile(0);
> >
> > -             set_setitimer_value(time_count, 0);
> > +             set_setitimer_value(time_sec, time_usec);
> >               TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
> >
> > -             set_setitimer_value(5 * time_step, 7 * time_step);
> > +             set_setitimer_value(2 * time_sec, 2 * time_usec);
>
> IDK if there was some reason for choosing 5 and 7 in the first place?
>

I don't see any necessary reasons for using prime numbers here.

@Andrea, did I miss something?



>
> Andrea seemed to be going through the prime numbers.
>
> >               TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
> >
> > -             tst_res(TINFO, "tv_sec=%ld, tv_usec=%ld",
> > -                     ovalue->it_value.tv_sec,
> > -                     ovalue->it_value.tv_usec);
> > +             TST_EXP_EQ_LI(ovalue->it_interval.tv_sec, time_sec);
> > +             TST_EXP_EQ_LI(ovalue->it_interval.tv_usec, time_usec);
> > +
> > +             tst_res(TINFO, "ovalue->it_value.tv_sec=%ld,
> ovalue->it_value.tv_usec=%ld",
> > +                     ovalue->it_value.tv_sec, ovalue->it_value.tv_usec);
> >
> >               /*
> >                * ITIMER_VIRTUAL and ITIMER_PROF timers always expire a
> >                * time_step afterward the elapsed time to make sure that
> >                * at least counters take effect.
> >                */
> > -             margin = tc->which == ITIMER_REAL ? 0 : time_step;
> > +             long margin = (tc->which == ITIMER_REAL) ? 0 : time_step;
>
> Looks like an unecessary change?
>

Yes, but the 'margin' is only used in children, and I moved
the declaration here is just to highlight and cause attention
in code reading.



>
> >
> > -             if (ovalue->it_value.tv_sec != 0 ||
> ovalue->it_value.tv_usec > time_count + margin)
> > +             if (ovalue->it_value.tv_sec > time_sec ||
> > +                             ovalue->it_value.tv_usec > time_usec +
> margin)
>
> Looking at the man page, technically speaking the valid range for
> ovalue->it_value.tv_sec is 0 to value->it_value.tv_sec when
> ovalue->it_value.tv_usec > 0.
>

Good point!! Seems we have to split the situation into two,

1. no tv_sec elapse happen, just check
    'it_value.tv_usec' within [0, time_usec + margin]

2. tv_sec elapses happen, then check
    'it_value.tv_sec' within [0, time_sec]

Something maybe like:

--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -87,9 +87,17 @@ static void verify_setitimer(unsigned int i)
                 */
                long margin = (tc->which == ITIMER_REAL) ? 0 : time_step;

-               if (ovalue->it_value.tv_sec > time_sec ||
-                               ovalue->it_value.tv_usec > time_usec +
margin)
-                       tst_res(TFAIL, "Ending counters are out of range");
+               if (ovalue->it_value.tv_sec == time_sec) {
+                       if (ovalue->it_value.tv_usec < 0 ||
+                                       ovalue->it_value.tv_usec >
time_usec + margin)
+                               tst_res(TFAIL, "ovalue->it_value.tv_usec is
out of range: %ld",
+                                               ovalue->it_value.tv_usec);
+               } else {
+                       if (ovalue->it_value.tv_sec < 0 ||
+                                       ovalue->it_value.tv_sec > time_sec)
+                               tst_res(TFAIL, "ovalue->it_value.tv_sec is
out of range: %ld",
+                                               ovalue->it_value.tv_usec);
+               }

                SAFE_SIGNAL(tc->signo, sig_routine);



>
> Practically speaking we have to assume a large amount of time has passed
> when using ITIMER_REAL. It has to be *much* larger than a VM is likely
> to be paused for and then successfully resumed. Or the amount of time a
> clock may be corrected by (for e.g. with NTP).
>

Hmm, not sure if I understand correctly above, will that
timer value be out of the range but reasonable?

Or is there any additional situation we should cover?



>
> >                       tst_res(TFAIL, "Ending counters are out of range");
>
> While we are here; we should make our lives easier when the test fails
> by printing any relevant values.
>

We already do that in the above print, but it's fine to have that here as
well.

-- 
Regards,
Li Wang

--000000000000e625eb05ed7a6795
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Nov 14, 2022 at 11:52 PM Richard Palethorpe=
 &lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_blank">rpalethorpe@s=
use.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hello,<br>
<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; Split checking the return ovalue from testing the signal is<br>
&gt; delivered, so that we could use two time value for verifying.<br>
&gt;<br>
&gt; Also, adding interval timer test by handling the signal at<br>
&gt; least 10 times. After that recover the signal behavior to<br>
&gt; default and do deliver-signal checking.<br>
&gt;<br>
&gt; Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../kernel/syscalls/setitimer/setitimer01.c=C2=A0 =C2=A0| 63 +++=
+++++++++-------<br>
&gt;=C2=A0 1 file changed, 39 insertions(+), 24 deletions(-)<br>
&gt;<br>
&gt; diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testc=
ases/kernel/syscalls/setitimer/setitimer01.c<br>
&gt; index 1f631d457..260590b0e 100644<br>
&gt; --- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
&gt; +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
&gt; @@ -22,8 +22,10 @@<br>
&gt;=C2=A0 #include &quot;tst_safe_clocks.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static struct itimerval *value, *ovalue;<br>
&gt; +static volatile unsigned long sigcnt;<br>
&gt;=C2=A0 static long time_step;<br>
&gt; -static long time_count;<br>
&gt; +static long time_sec;<br>
&gt; +static long time_usec;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static struct tcase {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int which;<br>
&gt; @@ -40,54 +42,66 @@ static int sys_setitimer(int which, void *new_valu=
e, void *old_value)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return tst_syscall(__NR_setitimer, which, ne=
w_value, old_value);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static void set_setitimer_value(int usec, int o_usec)<br>
&gt; +static void sig_routine(int signo LTP_ATTRIBUTE_UNUSED)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0value-&gt;it_value.tv_sec =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0value-&gt;it_value.tv_usec =3D usec;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0value-&gt;it_interval.tv_sec =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0value-&gt;it_interval.tv_usec =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sigcnt++;<br>
&gt; +}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0ovalue-&gt;it_value.tv_sec =3D o_usec;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ovalue-&gt;it_value.tv_usec =3D o_usec;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ovalue-&gt;it_interval.tv_sec =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ovalue-&gt;it_interval.tv_usec =3D 0;<br>
&gt; +static void set_setitimer_value(int sec, int usec)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value-&gt;it_value.tv_sec =3D sec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value-&gt;it_value.tv_usec =3D usec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value-&gt;it_interval.tv_sec =3D sec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value-&gt;it_interval.tv_usec =3D usec;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void verify_setitimer(unsigned int i)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pid_t pid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0long margin;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcase *tc =3D &amp;tcases[i];<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;tc-&gt;which =3D %s&quot;, t=
c-&gt;des);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pid =3D SAFE_FORK();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pid =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;=
tc-&gt;which =3D %s&quot;, tc-&gt;des);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_no_corefile(=
0);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_setitimer_value(t=
ime_count, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_setitimer_value(t=
ime_sec, time_usec);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_PASS(sys=
_setitimer(tc-&gt;which, value, NULL));<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_setitimer_value(5=
 * time_step, 7 * time_step);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_setitimer_value(2=
 * time_sec, 2 * time_usec);<br>
<br>
IDK if there was some reason for choosing 5 and 7 in the first place?<br></=
blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-s=
ize:small">I don&#39;t see any necessary reasons for using prime=C2=A0numbe=
rs=C2=A0here.</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">@Andrea, di=
d I miss something?</div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
Andrea seemed to be going through the prime numbers.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_PASS(sys=
_setitimer(tc-&gt;which, value, ovalue));<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;=
tv_sec=3D%ld, tv_usec=3D%ld&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ovalue-&gt;it_value.tv_sec,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ovalue-&gt;it_value.tv_usec);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EQ_LI(ovalue-=
&gt;it_interval.tv_sec, time_sec);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EQ_LI(ovalue-=
&gt;it_interval.tv_usec, time_usec);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;=
ovalue-&gt;it_value.tv_sec=3D%ld, ovalue-&gt;it_value.tv_usec=3D%ld&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ovalue-&gt;it_value.tv_sec, ovalue-&gt;it_value.tv_usec);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ITIMER_VIRTUA=
L and ITIMER_PROF timers always expire a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * time_step aft=
erward the elapsed time to make sure that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * at least coun=
ters take effect.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0margin =3D tc-&gt;whi=
ch =3D=3D ITIMER_REAL ? 0 : time_step;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0long margin =3D (tc-&=
gt;which =3D=3D ITIMER_REAL) ? 0 : time_step;<br>
<br>
Looks like an unecessary change?<br></blockquote><div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-size:small">Yes, but the &#39;margin&#=
39; is only used in children, and I moved</div><div class=3D"gmail_default"=
 style=3D"font-size:small">the declaration here is just to highlight and ca=
use attention</div><div class=3D"gmail_default" style=3D"font-size:small">i=
n code reading.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ovalue-&gt;it_val=
ue.tv_sec !=3D 0 || ovalue-&gt;it_value.tv_usec &gt; time_count + margin)<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ovalue-&gt;it_val=
ue.tv_sec &gt; time_sec ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ovalue-&gt;it_value.tv_usec &gt; time_us=
ec + margin)<br>
<br>
Looking at the man page, technically speaking the valid range for<br>
ovalue-&gt;it_value.tv_sec is 0 to value-&gt;it_value.tv_sec when<br>
ovalue-&gt;it_value.tv_usec &gt; 0.<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">Good point!! Seems we h=
ave to split the situation into two,</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-=
size:small">1. no tv_sec elapse happen, just check</div><div class=3D"gmail=
_default" style=3D"font-size:small">=C2=A0 =C2=A0 &#39;it_value.tv_usec&#39=
; within [0, time_usec + margin]</div><div class=3D"gmail_default" style=3D=
"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size=
:small">2. tv_sec elapses happen, then check=C2=A0</div><div class=3D"gmail=
_default" style=3D"font-size:small">=C2=A0 =C2=A0 &#39;it_value.tv_sec&#39;=
 within [0, time_sec]</div></div><div class=3D"gmail_default" style=3D"font=
-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l">Something maybe like:</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">=
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>+++ b/testcases/=
kernel/syscalls/setitimer/setitimer01.c<br>@@ -87,9 +87,17 @@ static void v=
erify_setitimer(unsigned int i)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 long margin =3D (tc-&gt;which =3D=3D ITIMER_REAL) ? 0 : time_ste=
p;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (oval=
ue-&gt;it_value.tv_sec &gt; time_sec ||<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ovalue-&gt;it_value.tv_usec &gt; time_usec + margin)<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TFA=
IL, &quot;Ending counters are out of range&quot;);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ovalue-&gt;it_value.tv_sec =3D=3D time_=
sec) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (ovalue-&gt;it_value.tv_usec &lt; 0 ||<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ovalue-&gt;it_value.tv_usec &=
gt; time_usec + margin)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TFAIL, =
&quot;ovalue-&gt;it_value.tv_usec is out of range: %ld&quot;,<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ovalue-&gt;it_value.tv_usec);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 } else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ovalue-&gt;it_value.tv_sec &lt; 0 ||=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ovalue-&gt;=
it_value.tv_sec &gt; time_sec)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(=
TFAIL, &quot;ovalue-&gt;it_value.tv_sec is out of range: %ld&quot;,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ovalue-&gt;it_value.tv_usec);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(tc-&gt;signo, sig_routine);<br></div><div =
class=3D"gmail_default" style=3D"font-size:small"><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Practically speaking we have to assume a large amount of time has passed<br=
>
when using ITIMER_REAL. It has to be *much* larger than a VM is likely<br>
to be paused for and then successfully resumed. Or the amount of time a<br>
clock may be corrected by (for e.g. with NTP).<br></blockquote><div><br></d=
iv><div><div class=3D"gmail_default" style=3D"font-size:small">Hmm, not sur=
e if I understand correctly above, will that</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">timer value be out of the range but reasonabl=
e?</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">Or is there any additi=
onal situation we should cover?</div><div class=3D"gmail_default" style=3D"=
font-size:small"><br></div></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tst_res(TFAIL, &quot;Ending counters are out of range&quot;);<=
br>
<br>
While we are here; we should make our lives easier when the test fails<br>
by printing any relevant values.<br></blockquote><div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-size:small">We already do that in the =
above print,=C2=A0but it&#39;s fine to=C2=A0have that here as well.</div></=
div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Rega=
rds,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000e625eb05ed7a6795--


--===============0846105604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0846105604==--

