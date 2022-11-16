Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB023C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 10:25:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E516A3CD046
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 11:25:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86D533CAFBA
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 11:25:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E4D310000CA
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 11:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668594325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmgqUFtCJcXn3Zf65OINjp5WfOfdETfykEEArEDi/HY=;
 b=VM6GVFIhCLSpQpMeDgXf23E4DWeNY99YsA2bXhb+Br1mRWlB13MwOoiUV2RW0NNgRCoOXf
 OGZAZholY+XA1CQ9VjvOZ6qFZSU8ZGy9xqbWgt4nnwruG191P2g2T77qpOXjAvSVA1ZwZq
 HURXEcQEt7iyiyJe9sN37MAE59nFmdU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-I2Ce4U1wPx6rZvxe2eLorg-1; Wed, 16 Nov 2022 05:25:24 -0500
X-MC-Unique: I2Ce4U1wPx6rZvxe2eLorg-1
Received: by mail-wr1-f69.google.com with SMTP id
 c18-20020adfa312000000b002364fabf2ceso3516040wrb.2
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 02:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BmgqUFtCJcXn3Zf65OINjp5WfOfdETfykEEArEDi/HY=;
 b=LSCcYRvNUrfG/HSHL/SefkYVA+pbD+OFF+TmC1MAekQwNi9M5apt9n5J76eD8wJjp5
 PnLf+lErcb1Sb47Dx55/Z0laqBf6j6z1HagTnVBOGAEsswjvXvdNcm296lpBGeMlf/LV
 Dvq5evUnkXLCASCmAakIo+tIoDIy3iPUp6EnK0Xxq+ZpHFCz9Kl4Xa2Ud0AcNJE8+UsY
 0+FbxdSkjKFLCSGs5jk9T4u7krtF5KIAgDyEMR97xfI6DzpYEO5m+Z4D6U1iQ9rv/wRc
 3qKoUTPSphpHluRr8DIHiskbTCIDNSOwRydwv3kw1TWgCrZLMO6VE2AfD102ietaWLKb
 zi9w==
X-Gm-Message-State: ANoB5pkvxMdtp04ZxDOlKLCbqK0NGLtV6I8DcWee4/wWcCDEMvDRsoEx
 Dagp7+iHwsOirsk7DBx/XtjWsNiHfy/Y52pEowLyzb5SgcPwR5BOTvOTN9sucKhMPyt8Mw8zN1h
 7UUYLy5QWKGgnHHeiGhTKGpNzNPk=
X-Received: by 2002:a05:600c:4a2a:b0:3b4:c00d:2329 with SMTP id
 c42-20020a05600c4a2a00b003b4c00d2329mr1607668wmp.124.1668594322765; 
 Wed, 16 Nov 2022 02:25:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6sz7+VbhhwcPBV58rBqFe1Sjlnxs/UQZniSoo7Eh8KFgMHHube/rx4kGbCpshUuRVYlTC0xurq2vX+av8oWPU=
X-Received: by 2002:a05:600c:4a2a:b0:3b4:c00d:2329 with SMTP id
 c42-20020a05600c4a2a00b003b4c00d2329mr1607653wmp.124.1668594322510; Wed, 16
 Nov 2022 02:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20221112040107.3953862-1-liwang@redhat.com>
 <87pmdpsfdv.fsf@suse.de>
 <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
 <87h6z0sh8o.fsf@suse.de>
 <CAEemH2c-90baLEbom4yF8oVjh9n7O4uKkXS5SBmx2rSBRsZBBQ@mail.gmail.com>
 <CAEemH2d=65BMhY4RFXHS1d5dkbq7v2QDskfE_5b_WnttDXT+Fg@mail.gmail.com>
 <87zgcsqxoc.fsf@suse.de>
In-Reply-To: <87zgcsqxoc.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Nov 2022 18:25:10 +0800
Message-ID: <CAEemH2fqN-haZ64xgANqihHD9pEfM=oe3e+QGT6Uf9HFHDohSw@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0064538402=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0064538402==
Content-Type: multipart/alternative; boundary="000000000000de310105ed93e394"

--000000000000de310105ed93e394
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 15, 2022 at 7:12 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Li Wang <liwang@redhat.com> writes:
>
> > On Tue, Nov 15, 2022 at 6:00 PM Li Wang <liwang@redhat.com> wrote:
> >
> >  Richard Palethorpe <rpalethorpe@suse.de> wrote:
> >
> >  >
> >  >  Practically speaking we have to assume a large amount of time has
> passed
> >  >  when using ITIMER_REAL. It has to be *much* larger than a VM is
> likely
> >  >  to be paused for and then successfully resumed. Or the amount of
> time a
> >  >  clock may be corrected by (for e.g. with NTP).
> >  >
> >  > Hmm, not sure if I understand correctly above, will that
> >  > timer value be out of the range but reasonable?
> >  >
> >  > Or is there any additional situation we should cover?
> >
> >  Sorry that is confusing.
> >
> >  The question is what happens if the clock jumps backwards?
>


I did some research on the work theory of setitimer() for modern
kernels, it seems that situation won't happen, because the kernel
uses a relative mode for the timer countdown. IOW, once the system
wall clock getting changed, the timer for the process will update its
timer relatively.

To verify this I adjust the wall-clock with adding whatever 10 sec or
24 hour, it all works well and get expected signal:

--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -21,6 +21,7 @@
 #include "lapi/syscalls.h"
 #include "tst_safe_clocks.h"

+static struct timespec now;
 static struct itimerval *value, *ovalue;
 static volatile unsigned long sigcnt;
 static long time_step;
@@ -33,8 +34,8 @@ static struct tcase {
        int signo;
 } tcases[] = {
        {ITIMER_REAL,    "ITIMER_REAL",    SIGALRM},
-       {ITIMER_VIRTUAL, "ITIMER_VIRTUAL", SIGVTALRM},
-       {ITIMER_PROF,    "ITIMER_PROF",    SIGPROF},
+//     {ITIMER_VIRTUAL, "ITIMER_VIRTUAL", SIGVTALRM},
+//     {ITIMER_PROF,    "ITIMER_PROF",    SIGPROF},
 };

 static int sys_setitimer(int which, void *new_value, void *old_value)
@@ -72,6 +73,10 @@ static void verify_setitimer(unsigned int i)
                set_setitimer_value(time_sec, time_usec);
                TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));

+               now.tv_sec += 20; // 86400s == 24h
+               SAFE_CLOCK_SETTIME(CLOCK_REALTIME, &now);
+               tst_res(TINFO, "debug only: add 20 secs to now.tv_sec
%ld\n", now.tv_sec);
+
                set_setitimer_value(5 * time_sec, 7 * time_usec);
                TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));

@@ -120,6 +125,9 @@ static void verify_setitimer(unsigned int i)
                tst_res(TPASS, "Child received signal: %s",
tst_strsig(tc->signo));
        else
                tst_res(TFAIL, "Child: %s", tst_strstatus(status));
+
+       SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &now);
+       tst_res(TINFO, "debug only: now.tv_sec is %ld\n", now.tv_sec);
 }

 static void setup(void)
@@ -142,6 +150,9 @@ static void setup(void)

        time_sec  = 9 + time_step / 1000;
        time_usec = 3 * time_step;
+
+       SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &now);
+       tst_res(TINFO, "debug only: now.tv_sec is %ld\n", now.tv_sec);
 }

 static struct tst_test test = {


>  Or do you have another better suggestion?
>
> TBH I don't know if it will happen. An acceptable outcome for me is to
> print the time at the beginning and end of the test. Then if the test
> fails we can see if it was due to a time jump and start investigating
> what the kernel is supposed to do in this case.
>

But I think this print is still necessary, in case that some older kernels
do not use the relative mode for timer. I'll add this and send patch v2.


> The alternative is to find out now what the kernel should do. We could
> also write a test which deliberately changes the system time during an
> interval. Depending how motivated you are.
>

Thanks!


-- 
Regards,
Li Wang

--000000000000de310105ed93e394
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Nov 15, 2022 at 7:12 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Nov 15, 2022 at 6:00 PM Li Wang &lt;<a href=3D"mailto:liwang@r=
edhat.com" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de" ta=
rget=3D"_blank">rpalethorpe@suse.de</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 Practically speaking we have to assume a large amount=
 of time has passed<br>
&gt;=C2=A0 &gt;=C2=A0 when using ITIMER_REAL. It has to be *much* larger th=
an a VM is likely<br>
&gt;=C2=A0 &gt;=C2=A0 to be paused for and then successfully resumed. Or th=
e amount of time a<br>
&gt;=C2=A0 &gt;=C2=A0 clock may be corrected by (for e.g. with NTP).<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Hmm, not sure if I understand correctly above, will that<br=
>
&gt;=C2=A0 &gt; timer value be out of the range but reasonable?<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Or is there any additional situation we should cover?<br>
&gt;<br>
&gt;=C2=A0 Sorry that is confusing.<br>
&gt;<br>
&gt;=C2=A0 The question is what happens if the clock jumps backwards?<br></=
blockquote><div><br></div><div><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">I did some research on the work theory of setitimer() =
for modern</div><div class=3D"gmail_default" style=3D"font-size:small">kern=
els, it seems that situation won&#39;t happen, because the kernel</div><div=
 class=3D"gmail_default" style=3D"font-size:small">uses a relative mode for=
 the timer countdown. IOW, once the system</div><div class=3D"gmail_default=
" style=3D"font-size:small">wall=C2=A0clock getting changed, the timer for =
the process will update its</div><div class=3D"gmail_default" style=3D"font=
-size:small">timer relatively.</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">To verify this I adjust the wall-clock with adding whatever 10 sec or=
</div><div class=3D"gmail_default" style=3D"font-size:small">24 hour, it al=
l works well and get expected signal:</div><div class=3D"gmail_default" sty=
le=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font=
-size:small">--- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>+++=
 b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>@@ -21,6 +21,7 @@<b=
r>=C2=A0#include &quot;lapi/syscalls.h&quot;<br>=C2=A0#include &quot;tst_sa=
fe_clocks.h&quot;<br>=C2=A0<br>+static struct timespec now;<br>=C2=A0static=
 struct itimerval *value, *ovalue;<br>=C2=A0static volatile unsigned long s=
igcnt;<br>=C2=A0static long time_step;<br>@@ -33,8 +34,8 @@ static struct t=
case {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int signo;<br>=C2=A0} tcases[] =3D {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 {ITIMER_REAL, =C2=A0 =C2=A0&quot;ITIMER_REAL=
&quot;, =C2=A0 =C2=A0SIGALRM},<br>- =C2=A0 =C2=A0 =C2=A0 {ITIMER_VIRTUAL, &=
quot;ITIMER_VIRTUAL&quot;, SIGVTALRM},<br>- =C2=A0 =C2=A0 =C2=A0 {ITIMER_PR=
OF, =C2=A0 =C2=A0&quot;ITIMER_PROF&quot;, =C2=A0 =C2=A0SIGPROF},<br>+// =C2=
=A0 =C2=A0 {ITIMER_VIRTUAL, &quot;ITIMER_VIRTUAL&quot;, SIGVTALRM},<br>+// =
=C2=A0 =C2=A0 {ITIMER_PROF, =C2=A0 =C2=A0&quot;ITIMER_PROF&quot;, =C2=A0 =
=C2=A0SIGPROF},<br>=C2=A0};<br>=C2=A0<br>=C2=A0static int sys_setitimer(int=
 which, void *new_value, void *old_value)<br>@@ -72,6 +73,10 @@ static void=
 verify_setitimer(unsigned int i)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 set_setitimer_value(time_sec, time_usec);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_PASS(sys_setitimer(tc=
-&gt;which, value, NULL));<br>=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 now.tv_sec +=3D 20; // 86400s =3D=3D 24h<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_CLOCK_SETTIME(CLOCK_REALTIME, &=
amp;now);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TIN=
FO, &quot;debug only: add 20 secs to now.tv_sec %ld\n&quot;, now.tv_sec);<b=
r>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_setitime=
r_value(5 * time_sec, 7 * time_usec);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TST_EXP_PASS(sys_setitimer(tc-&gt;which, value, ovalu=
e));<br>=C2=A0<br>@@ -120,6 +125,9 @@ static void verify_setitimer(unsigned=
 int i)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(=
TPASS, &quot;Child received signal: %s&quot;, tst_strsig(tc-&gt;signo));<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tst_res(TFAIL, &quot;Child: %s&quot;, tst_strstatus(statu=
s));<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &amp=
;now);<br>+ =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quot;debug only: now.tv_se=
c is %ld\n&quot;, now.tv_sec);<br>=C2=A0}<br>=C2=A0<br>=C2=A0static void se=
tup(void)<br>@@ -142,6 +150,9 @@ static void setup(void)<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 time_sec =C2=A0=3D 9 + time_step / 1000;<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 time_usec =3D 3 * time_step;<br>+<br>+ =C2=A0 =C2=A0 =
=C2=A0 SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &amp;now);<br>+ =C2=A0 =C2=A0 =C2=
=A0 tst_res(TINFO, &quot;debug only: now.tv_sec is %ld\n&quot;, now.tv_sec)=
;<br>=C2=A0}<br>=C2=A0<br>=C2=A0static struct tst_test test =3D {<br></div>=
<div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
&gt;=C2=A0 Or do you have another better suggestion?<br>
<br>
TBH I don&#39;t know if it will happen. An acceptable outcome for me is to<=
br>
print the time at the beginning and end of the test. Then if the test<br>
fails we can see if it was due to a time jump and start investigating<br>
what the kernel is supposed to do in this case.<br></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">But I think=
 this print is still necessary, in case that some older kernels</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">do not use the relative mo=
de for timer. I&#39;ll add this and send patch v2.</div></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
The alternative is to find out now what the kernel should do. We could<br>
also write a test which deliberately changes the system time during an<br>
interval. Depending how motivated you are.<br></blockquote><div><br></div><=
div><div class=3D"gmail_default" style=3D"font-size:small">Thanks!</div><br=
></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></di=
v></div>

--000000000000de310105ed93e394--


--===============0064538402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0064538402==--

