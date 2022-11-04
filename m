Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE375C4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:11:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 780F33CB327
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:11:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 470B33CB3AB
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A755B2009D7
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 07:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667544560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDyReK6ctmK3M1AYhhLFm/cTdmLCAFbu9pmiVFJAUJg=;
 b=c7IEHL2nC1IdUTls0R0dSh2fwQFELIhobJzzvrAIQgeaxKGi6lh9TzRR3CUVyQo68Zty5y
 omoWcnonXnJc3/S4XQhvw2vCub9riwQPHmZ2ukQVhQNPeKJ/5FSpnPofNjpVvUv9Zpr+sh
 etekBKQuq7tCnCUfgfmq68jiCiy/Cwk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-BVJOmN8DOg-j-jYH0PwH7Q-1; Fri, 04 Nov 2022 02:49:08 -0400
X-MC-Unique: BVJOmN8DOg-j-jYH0PwH7Q-1
Received: by mail-ot1-f71.google.com with SMTP id
 t11-20020a9d590b000000b00655fad88dacso1663190oth.1
 for <ltp@lists.linux.it>; Thu, 03 Nov 2022 23:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlkZ09M+xQkO9neSi8mJKFi1mjAlHOVvgCdsKz4g1Y8=;
 b=DPie20nJmBOM85yO2GmCih1ytAO+Es6iK5cdsUePDrSkTZuZaH3iF7kkruoNa+EMzA
 1lisizLt4xTIRe2MosW1moU01LAd+lvm0JI4WDw2/rTuk1fcRULTqYfNgIcM4D5C0Wj3
 O90ljZqoe1VF4SxTc4/fKTtVUF7K2dc1j17AQbv8A6cBzX67ml1nnRjA5UqrunBPzg2S
 Ua3LHb2DiBcMCjiUAjswp27OJUkG6jg0ngtQyRLOAV9Y5hx0iouz9UD1lDXiyd8YprTe
 LXcO2qRcY34l9g9pX5TsMe2eMo/ACL0yGSp44dzw2Kf0sHev1oWE3SEJi8Asn3TBAIbJ
 IAXg==
X-Gm-Message-State: ACrzQf1y+vKkeHmuLMxcqk1tJYW+ISh+d7wnRjcVpFNeux1I4Gsn7pl2
 x5qqPhHJpI0MBhi105fukX7guN0tXTtH3TOEZrbWsObl6kxgir6qod1r+1TwHIah+62Csl4cLkH
 kDAd8R6okarSerA5Q/2/MSywVTLQ=
X-Received: by 2002:a05:6870:40cc:b0:13c:d606:27e8 with SMTP id
 l12-20020a05687040cc00b0013cd60627e8mr18038040oal.107.1667544548087; 
 Thu, 03 Nov 2022 23:49:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43D+SxKW87JuDu2weDnb0YJMUFCEwIzbmsHaStifc7IKMElIDp0FoCU/WRPrQ+zMRjzPeXHLOssXt+ws9deW4=
X-Received: by 2002:a05:6870:40cc:b0:13c:d606:27e8 with SMTP id
 l12-20020a05687040cc00b0013cd60627e8mr18038009oal.107.1667544546758; Thu, 03
 Nov 2022 23:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221102145935.24738-1-andrea.cervesato@suse.com>
In-Reply-To: <20221102145935.24738-1-andrea.cervesato@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Nov 2022 14:48:53 +0800
Message-ID: <CAEemH2ePDmJf-Mq=gk8MX+J7tP-qkGrvqxRL-Ri_k8QjZd842g@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly check setitimer params in setitimer01
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
Content-Type: multipart/mixed; boundary="===============2047437079=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2047437079==
Content-Type: multipart/alternative; boundary="0000000000005b68fa05ec9f7833"

--0000000000005b68fa05ec9f7833
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

Andrea Cervesato via ltp <ltp@lists.linux.it> wrote:

Last test rewrite didn't consider the right expected boundaries when
> setitimer syscall was tested. We also introduced counter times as
> multiple of clock resolution, to avoid kernel rounding during setitimer
> counter increase.
>

Good catch, but I'm afraid this can not solve the problem thoroughly.
According failure log on "ITIMER_VIRTUAL/PROF" with running this patch.:

setitimer01.c:64: TINFO: tc->which = ITIMER_VIRTUAL
setitimer01.c:69: TPASS: sys_setitimer(tc->which, value, NULL) passed
setitimer01.c:72: TPASS: sys_setitimer(tc->which, value, ovalue) passed
setitimer01.c:76: TINFO: tv_sec=0, tv_usec=31000
setitimer01.c:79: TFAIL: Ending counters are out of range
setitimer01.c:88: TPASS: Child received signal: SIGVTALRM

setitimer01.c:64: TINFO: tc->which = ITIMER_PROF
setitimer01.c:69: TPASS: sys_setitimer(tc->which, value, NULL) passed
setitimer01.c:72: TPASS: sys_setitimer(tc->which, value, ovalue) passed
setitimer01.c:76: TINFO: tv_sec=0, tv_usec=31000
setitimer01.c:79: TFAIL: Ending counters are out of range
setitimer01.c:88: TPASS: Child received signal: SIGPROF

It seems the tv_usec always increase 1000us, I highly suspect
this increase comes from kernel function set_cpu_itimer() that
explicitly add TICK_NSEC when 'nval' is larger than zero:

$ cat kernel/time/itimer.c -n
   ...
   168 static void set_cpu_itimer(struct task_struct *tsk, unsigned int
clock_id,
   169                 const struct itimerspec64 *const value,
   170                 struct itimerspec64 *const ovalue)
   171 {
                   ...
   182          if (oval || nval) {
   183                  if (nval > 0)
   184                          nval += TICK_NSEC;
   185                  set_process_cpu_timer(tsk, clock_id, &nval, &oval);
   186          }
   187          ...
   198 }

To verify my guess, I do a modification based on your patch and
then easily get the result in pass.

--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int i)
                        ovalue->it_value.tv_sec,
                        ovalue->it_value.tv_usec);

-               if (ovalue->it_value.tv_sec != 0 ||
ovalue->it_value.tv_usec > usec)
+               if (ovalue->it_value.tv_sec != 0 ||
ovalue->it_value.tv_usec - time_step > usec)
                        tst_res(TFAIL, "Ending counters are out of range");

                for (;;)
@@ -98,8 +98,8 @@ static void setup(void)
        SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);

        time_step = res.tv_nsec / 1000;
-       if (time_step < 10000)
-               time_step = 10000;
+       if (time_step < 1000)
+               time_step = 1000;

        tst_res(TINFO, "clock resolution: %luns, time step: %luus",
                res.tv_nsec,


But after trying this with my RasberryPi4, it fails again with an increase
4000us each time. So it might related to the system use different time
resolutions. When I shift to use `CLOCK_MONOTONIC_COARSE`
then test gets passed on all my platforms.

Any comments?


----------CLOCK_MONOTONIC-------------
setitimer01.c:65: TINFO: tc->which = ITIMER_VIRTUAL
setitimer01.c:70: TPASS: sys_setitimer(tc->which, value, NULL) passed
setitimer01.c:73: TPASS: sys_setitimer(tc->which, value, ovalue) passed
setitimer01.c:77: TINFO: tv_sec=0, tv_usec=7000
setitimer01.c:80: TFAIL: Ending counters are out of range

-----------CLOCK_MONOTONIC_COARSE-------
setitimer01.c:65: TINFO: tc->which = ITIMER_VIRTUAL
setitimer01.c:70: TPASS: sys_setitimer(tc->which, value, NULL) passed
setitimer01.c:73: TPASS: sys_setitimer(tc->which, value, ovalue) passed
setitimer01.c:77: TINFO: tv_sec=0, tv_usec=16000
setitimer01.c:89: TPASS: Child received signal: SIGVTALRM

# lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per cluster: 4
Socket(s):           -
Cluster(s):          1
Vendor ID:           ARM
Model:               3
Model name:          Cortex-A72
Stepping:            r0p3
CPU max MHz:         1500.0000
CPU min MHz:         600.0000
BogoMIPS:            108.00
Flags:               fp asimd evtstrm crc32 cpuid

-- 
Regards,
Li Wang

--0000000000005b68fa05ec9f7833
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Andrea,</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">Andrea Cervesato via ltp &lt;<a href=3D"=
mailto:ltp@lists.linux.it" target=3D"_blank">ltp@lists.linux.it</a>&gt; wro=
te:<br></div><div dir=3D"ltr" class=3D"gmail_attr"><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Last test rewrite didn&#39;t consider t=
he right expected boundaries when<br>
setitimer syscall was tested. We also introduced counter times as<br>
multiple of clock resolution, to avoid kernel rounding during setitimer<br>
counter increase.<br></blockquote><div><br></div><div><div class=3D"gmail_d=
efault" style=3D"font-size:small">Good catch, but I&#39;m afraid this can n=
ot solve the problem thoroughly.</div><div class=3D"gmail_default" style=3D=
"font-size:small">According failure log on &quot;ITIMER_VIRTUAL/PROF&quot; =
with running this patch.:</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>setitimer01.c:64: TINFO: tc-&gt;which =3D ITIMER_VIRTUAL<br>setitimer01.c:=
69: TPASS: sys_setitimer(tc-&gt;which, value, NULL) passed<br>setitimer01.c=
:72: TPASS: sys_setitimer(tc-&gt;which, value, ovalue) passed<br>setitimer0=
1.c:76: TINFO: tv_sec=3D0, tv_usec=3D31000<br>setitimer01.c:79: TFAIL: Endi=
ng counters are out of range</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">setitimer01.c:88: TPASS: Child received signal: SIGVTALRM</di=
v><div class=3D"gmail_default" style=3D"font-size:small"><br>setitimer01.c:=
64: TINFO: tc-&gt;which =3D ITIMER_PROF<br>setitimer01.c:69: TPASS: sys_set=
itimer(tc-&gt;which, value, NULL) passed<br>setitimer01.c:72: TPASS: sys_se=
titimer(tc-&gt;which, value, ovalue) passed<br>setitimer01.c:76: TINFO: tv_=
sec=3D0, tv_usec=3D31000<br>setitimer01.c:79: TFAIL: Ending counters are ou=
t of range</div><div class=3D"gmail_default" style=3D"font-size:small">seti=
timer01.c:88: TPASS: Child received signal: SIGPROF<br></div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">It seems the tv_usec always increase 1000us,=
 I highly suspect</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">this increase comes from kernel function set_cpu_itimer() that</div><div=
 class=3D"gmail_default" style=3D"font-size:small">explicitly add TICK_NSEC=
 when &#39;nval&#39; is larger than zero:</div><br></div><div><div class=3D=
"gmail_default" style=3D"font-size:small">$ cat kernel/time/itimer.c -n</di=
v><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0...</=
div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0168=
=09static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_i=
d,<br>=C2=A0 =C2=A0169=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const struct itimerspec64 *const value,<br>=C2=A0 =C2=A0170=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerspec64=
 *const ovalue)<br>=C2=A0 =C2=A0171=09{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>=C2=A0 =C2=A0182=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (oval || nval) {<br>=C2=A0 =C2=A0183=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nval &gt; 0)<br>=C2=A0=
 =C2=A0184=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0nval +=3D TICK_NSEC;<br>=C2=A0 =C2=A0185=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_process_=
cpu_timer(tsk, clock_id, &amp;nval, &amp;oval);<br>=C2=A0 =C2=A0186=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0187=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ...<br>=C2=A0 =C2=A0198=09}<br></div><div class=3D"gmail_default=
" style=3D"font-size:small"><br></div></div><div class=3D"gmail_default" st=
yle=3D"font-size:small">To verify my guess, I do a modification based on yo=
ur patch and</div><div class=3D"gmail_default" style=3D"font-size:small">th=
en easily get the result in pass.</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">--- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>+++ b=
/testcases/kernel/syscalls/setitimer/setitimer01.c<br>@@ -76,7 +76,7 @@ sta=
tic void verify_setitimer(unsigned int i)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ovalue-&gt;it_value=
.tv_sec,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ovalue-&gt;it_value.tv_usec);<br>=C2=A0<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ovalue-&gt;it_value.tv_sec !=
=3D 0 || ovalue-&gt;it_value.tv_usec &gt; usec)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ovalue-&gt;it_value.tv_sec !=3D 0 || ovalue=
-&gt;it_value.tv_usec - time_step &gt; usec)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TFAIL, &qu=
ot;Ending counters are out of range&quot;);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;)<br>@@ -98,8 +98,8 @@ static=
 void setup(void)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_CLOCK_GETRES(CLOCK_MO=
NOTONIC, &amp;res);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_step =3D =
res.tv_nsec / 1000;<br>- =C2=A0 =C2=A0 =C2=A0 if (time_step &lt; 10000)<br>=
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time_step =3D 10000;<br>=
+ =C2=A0 =C2=A0 =C2=A0 if (time_step &lt; 1000)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_step =3D 1000;<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tst_res(TINFO, &quot;clock resolution: %luns, time step: %luu=
s&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res.tv_=
nsec,<br></div><div>=C2=A0</div></div><div><br></div><div><div class=3D"gma=
il_default" style=3D"font-size:small">But after trying this with my Rasberr=
yPi4, it fails again with an increase</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">4000us each time. So it might related to the system =
use different=C2=A0time</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">resolutions. When I shift to use `CLOCK_MONOTONIC_COARSE`</div></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">then test gets pa=
ssed on all my platforms.</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>Any comments?</div><div class=3D"gmail_default" style=3D"font-size:small">=
<br></div><div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">----------CLOCK_MONOTONIC-------------</div></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">setitimer01.c:65: TINFO: tc-&g=
t;which =3D ITIMER_VIRTUAL<br>setitimer01.c:70: TPASS: sys_setitimer(tc-&gt=
;which, value, NULL) passed<br>setitimer01.c:73: TPASS: sys_setitimer(tc-&g=
t;which, value, ovalue) passed<br>setitimer01.c:77: TINFO: tv_sec=3D0, tv_u=
sec=3D7000<br>setitimer01.c:80: TFAIL: Ending counters are out of range</di=
v><br><div class=3D"gmail_default" style=3D"font-size:small">-----------CLO=
CK_MONOTONIC_COARSE-------</div></div><div><div class=3D"gmail_default" sty=
le=3D"font-size:small">setitimer01.c:65: TINFO: tc-&gt;which =3D ITIMER_VIR=
TUAL<br>setitimer01.c:70: TPASS: sys_setitimer(tc-&gt;which, value, NULL) p=
assed<br>setitimer01.c:73: TPASS: sys_setitimer(tc-&gt;which, value, ovalue=
) passed<br>setitimer01.c:77: TINFO: tv_sec=3D0, tv_usec=3D16000<br>setitim=
er01.c:89: TPASS: Child received signal: SIGVTALRM<br></div><div class=3D"g=
mail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-size:small"># lscpu <br>Architecture: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0aarch64<br>Byte Order: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Little E=
ndian<br>CPU(s): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<br>On-li=
ne CPU(s) list: 0-3<br>Thread(s) per core: =C2=A01<br>Core(s) per cluster: =
4<br>Socket(s): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -<br>Cluster(s): =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>Vendor ID: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ARM<br>Model: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>Mod=
el name: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Cortex-A72<br>Stepping: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r0p3<br>CPU max MHz: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1500.0000<br>CPU min MHz: =C2=A0 =C2=A0 =C2=A0 =C2=A0 600.0000<br>B=
ogoMIPS: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0108.00<br>Flags: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp asimd evtstrm crc32 cpuid<br><=
/div><div class=3D"gmail_default" style=3D"font-size:small"></div><br></div=
>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wa=
ng<br></div></div></div></div>

--0000000000005b68fa05ec9f7833--


--===============2047437079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2047437079==--

