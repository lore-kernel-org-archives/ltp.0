Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69035C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:09:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D50383CB341
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:09:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E30C3CB417
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E3C71000F61
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 09:18:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667549921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Am41M9XIXPfPcN3wwIfOtepfAWtuv1q88PbQQXV4SY=;
 b=c2XgUobbf3iEvagM3zvD59xQ9snkpOCFzwtqDCrvVnYDenD77nUDrt7hExSLZKbKwa0IYh
 g8qlE32JW8YjL7IIchZroQEr5slVHm5//iWTpVdHlxxwQ8Ws0M2DWJJA21Y6ASGyw/MH5A
 FzKEP1pcIldjSBUx5a0eKRQMxVhH+Tk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-PStZm0nJMg2zQLO7k78L5w-1; Fri, 04 Nov 2022 04:18:40 -0400
X-MC-Unique: PStZm0nJMg2zQLO7k78L5w-1
Received: by mail-ot1-f71.google.com with SMTP id
 cj4-20020a056830640400b0065c0c211f4dso1746633otb.8
 for <ltp@lists.linux.it>; Fri, 04 Nov 2022 01:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FrQcju7Tq2b3Rqg5icpooIvyvNImiKMUQwusaTiUu+Q=;
 b=VQsUd64s1SubrZkp3oJTqjGZI5mL9dIRS16C8LlvF1zlN/k1qbRsO6u8TW4+7jseaq
 so8WpFzK3NTkJHuI86IohWeY+VQ/assQgHRRHgPlxK+0eMnsgieoizr1Qjzr5MGge6Lk
 7wd16HhP/E5BW/SUk8ZlHreEXT589NdB+7IsxZvmrtl58c2nqGk7LVqqgm+oNV1fnRCI
 IBBD0IT3XwzXP5XXq2ZU7AQBK14KeeRL1ntIut0LZNQkoc5fSAURX/4XZIC8QqkZMkek
 qlzhkipkyy4ama2ia68HsIhcPiEPWqRSrB/uQ8IaSrQb18knZqoXhYLAgU1j9EpUb9gR
 x2lA==
X-Gm-Message-State: ACrzQf2WHxa1IwpYw+bhwuFL62ES1QVQFiLltsi7BL9HRM4JpxJixxtp
 GxDxiXQYV2eIlZnAojMOtH+iWY4e2ipt6o608P96cbKvORLx+fv2lIvO3sSV6prRwbpn8Ia5/xH
 2mNjRSts82HaEWHKXztPRqTgGNVg=
X-Received: by 2002:a05:6808:14cd:b0:357:62f3:d7b7 with SMTP id
 f13-20020a05680814cd00b0035762f3d7b7mr27544819oiw.107.1667549919422; 
 Fri, 04 Nov 2022 01:18:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6/l4H0HUr1SfxWSAUhE4qfCgaIrTfJDgpGZEEw73ww2+TEGcHU77HXzZC5y0CuFPDco2penjyPWrnkvkgRzFw=
X-Received: by 2002:a05:6808:14cd:b0:357:62f3:d7b7 with SMTP id
 f13-20020a05680814cd00b0035762f3d7b7mr27544816oiw.107.1667549919211; Fri, 04
 Nov 2022 01:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221102145935.24738-1-andrea.cervesato@suse.com>
 <CAEemH2ePDmJf-Mq=gk8MX+J7tP-qkGrvqxRL-Ri_k8QjZd842g@mail.gmail.com>
In-Reply-To: <CAEemH2ePDmJf-Mq=gk8MX+J7tP-qkGrvqxRL-Ri_k8QjZd842g@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Nov 2022 16:18:26 +0800
Message-ID: <CAEemH2exsebnEqfaG3hP3Yg5h63SHBm5FgoyzqyiQ_bP=mFmCw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0347881084=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0347881084==
Content-Type: multipart/alternative; boundary="00000000000094907105eca0b83a"

--00000000000094907105eca0b83a
Content-Type: text/plain; charset="UTF-8"

Btw, these are the final changes I propose to fix the problem,
but I haven't figured out why the resolution from CLOCK_*_COARSE worked.

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
@@ -95,11 +95,9 @@ static void setup(void)
 {
        struct timespec res;

-       SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
+       SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &res);

        time_step = res.tv_nsec / 1000;
-       if (time_step < 10000)
-               time_step = 10000;

        tst_res(TINFO, "clock resolution: %luns, time step: %luus",
                res.tv_nsec,


On Fri, Nov 4, 2022 at 2:48 PM Li Wang <liwang@redhat.com> wrote:

> Hi Andrea,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> wrote:
>
> Last test rewrite didn't consider the right expected boundaries when
>> setitimer syscall was tested. We also introduced counter times as
>> multiple of clock resolution, to avoid kernel rounding during setitimer
>> counter increase.
>>
>
> Good catch, but I'm afraid this can not solve the problem thoroughly.
> According failure log on "ITIMER_VIRTUAL/PROF" with running this patch.:
>
> setitimer01.c:64: TINFO: tc->which = ITIMER_VIRTUAL
> setitimer01.c:69: TPASS: sys_setitimer(tc->which, value, NULL) passed
> setitimer01.c:72: TPASS: sys_setitimer(tc->which, value, ovalue) passed
> setitimer01.c:76: TINFO: tv_sec=0, tv_usec=31000
> setitimer01.c:79: TFAIL: Ending counters are out of range
> setitimer01.c:88: TPASS: Child received signal: SIGVTALRM
>
> setitimer01.c:64: TINFO: tc->which = ITIMER_PROF
> setitimer01.c:69: TPASS: sys_setitimer(tc->which, value, NULL) passed
> setitimer01.c:72: TPASS: sys_setitimer(tc->which, value, ovalue) passed
> setitimer01.c:76: TINFO: tv_sec=0, tv_usec=31000
> setitimer01.c:79: TFAIL: Ending counters are out of range
> setitimer01.c:88: TPASS: Child received signal: SIGPROF
>
> It seems the tv_usec always increase 1000us, I highly suspect
> this increase comes from kernel function set_cpu_itimer() that
> explicitly add TICK_NSEC when 'nval' is larger than zero:
>
> $ cat kernel/time/itimer.c -n
>    ...
>    168 static void set_cpu_itimer(struct task_struct *tsk, unsigned int
> clock_id,
>    169                 const struct itimerspec64 *const value,
>    170                 struct itimerspec64 *const ovalue)
>    171 {
>                    ...
>    182          if (oval || nval) {
>    183                  if (nval > 0)
>    184                          nval += TICK_NSEC;
>    185                  set_process_cpu_timer(tsk, clock_id, &nval, &oval);
>    186          }
>    187          ...
>    198 }
>
> To verify my guess, I do a modification based on your patch and
> then easily get the result in pass.
>
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int i)
>                         ovalue->it_value.tv_sec,
>                         ovalue->it_value.tv_usec);
>
> -               if (ovalue->it_value.tv_sec != 0 ||
> ovalue->it_value.tv_usec > usec)
> +               if (ovalue->it_value.tv_sec != 0 ||
> ovalue->it_value.tv_usec - time_step > usec)
>                         tst_res(TFAIL, "Ending counters are out of range");
>
>                 for (;;)
> @@ -98,8 +98,8 @@ static void setup(void)
>         SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
>
>         time_step = res.tv_nsec / 1000;
> -       if (time_step < 10000)
> -               time_step = 10000;
> +       if (time_step < 1000)
> +               time_step = 1000;
>
>         tst_res(TINFO, "clock resolution: %luns, time step: %luus",
>                 res.tv_nsec,
>
>
> But after trying this with my RasberryPi4, it fails again with an increase
> 4000us each time. So it might related to the system use different time
> resolutions. When I shift to use `CLOCK_MONOTONIC_COARSE`
> then test gets passed on all my platforms.
>
> Any comments?
>
>
> ----------CLOCK_MONOTONIC-------------
> setitimer01.c:65: TINFO: tc->which = ITIMER_VIRTUAL
> setitimer01.c:70: TPASS: sys_setitimer(tc->which, value, NULL) passed
> setitimer01.c:73: TPASS: sys_setitimer(tc->which, value, ovalue) passed
> setitimer01.c:77: TINFO: tv_sec=0, tv_usec=7000
> setitimer01.c:80: TFAIL: Ending counters are out of range
>
> -----------CLOCK_MONOTONIC_COARSE-------
> setitimer01.c:65: TINFO: tc->which = ITIMER_VIRTUAL
> setitimer01.c:70: TPASS: sys_setitimer(tc->which, value, NULL) passed
> setitimer01.c:73: TPASS: sys_setitimer(tc->which, value, ovalue) passed
> setitimer01.c:77: TINFO: tv_sec=0, tv_usec=16000
> setitimer01.c:89: TPASS: Child received signal: SIGVTALRM
>
> # lscpu
> Architecture:        aarch64
> Byte Order:          Little Endian
> CPU(s):              4
> On-line CPU(s) list: 0-3
> Thread(s) per core:  1
> Core(s) per cluster: 4
> Socket(s):           -
> Cluster(s):          1
> Vendor ID:           ARM
> Model:               3
> Model name:          Cortex-A72
> Stepping:            r0p3
> CPU max MHz:         1500.0000
> CPU min MHz:         600.0000
> BogoMIPS:            108.00
> Flags:               fp asimd evtstrm crc32 cpuid
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang

--00000000000094907105eca0b83a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Btw, these are the final changes I propose to fix the problem=
,</div><div class=3D"gmail_default" style=3D"font-size:small">but I haven&#=
39;t figured out why the resolution from CLOCK_*_COARSE worked.</div><div c=
lass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">--- a/testcases/kernel/syscalls/seti=
timer/setitimer01.c<br>+++ b/testcases/kernel/syscalls/setitimer/setitimer0=
1.c<br>@@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int i)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ovalue-&gt;it_value.tv_sec,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ovalue-&gt;it_value.tv=
_usec);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(ovalue-&gt;it_value.tv_sec !=3D 0 || ovalue-&gt;it_value.tv_usec &gt; usec=
)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ovalue-&gt;it_v=
alue.tv_sec !=3D 0 || ovalue-&gt;it_value.tv_usec - time_step &gt; usec)<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tst_res(TFAIL, &quot;Ending counters are out of range&quot;);<br=
>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;)=
<br>@@ -95,11 +95,9 @@ static void setup(void)<br>=C2=A0{<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct timespec res;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 SAFE=
_CLOCK_GETRES(CLOCK_MONOTONIC, &amp;res);<br>+ =C2=A0 =C2=A0 =C2=A0 SAFE_CL=
OCK_GETRES(CLOCK_MONOTONIC_COARSE, &amp;res);<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 time_step =3D res.tv_nsec / 1000;<br>- =C2=A0 =C2=A0 =C2=A0 i=
f (time_step &lt; 10000)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 time_step =3D 10000;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(T=
INFO, &quot;clock resolution: %luns, time step: %luus&quot;,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res.tv_nsec,<br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 4, 20=
22 at 2:48 PM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-size:small">Hi=C2=
=A0Andrea,</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Andrea Cervesato via ltp &lt;<a href=3D"mailto:ltp@lists.li=
nux.it" target=3D"_blank">ltp@lists.linux.it</a>&gt; wrote:<br></div><div d=
ir=3D"ltr" class=3D"gmail_attr"><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Last test rewrite didn&#39;t consider the right expected b=
oundaries when<br>
setitimer syscall was tested. We also introduced counter times as<br>
multiple of clock resolution, to avoid kernel rounding during setitimer<br>
counter increase.<br></blockquote><div><br></div><div><div style=3D"font-si=
ze:small">Good catch, but I&#39;m afraid this can not solve the problem tho=
roughly.</div><div style=3D"font-size:small">According failure log on &quot=
;ITIMER_VIRTUAL/PROF&quot; with running this patch.:</div><div style=3D"fon=
t-size:small"><br></div><div style=3D"font-size:small">setitimer01.c:64: TI=
NFO: tc-&gt;which =3D ITIMER_VIRTUAL<br>setitimer01.c:69: TPASS: sys_setiti=
mer(tc-&gt;which, value, NULL) passed<br>setitimer01.c:72: TPASS: sys_setit=
imer(tc-&gt;which, value, ovalue) passed<br>setitimer01.c:76: TINFO: tv_sec=
=3D0, tv_usec=3D31000<br>setitimer01.c:79: TFAIL: Ending counters are out o=
f range</div><div style=3D"font-size:small">setitimer01.c:88: TPASS: Child =
received signal: SIGVTALRM</div><div style=3D"font-size:small"><br>setitime=
r01.c:64: TINFO: tc-&gt;which =3D ITIMER_PROF<br>setitimer01.c:69: TPASS: s=
ys_setitimer(tc-&gt;which, value, NULL) passed<br>setitimer01.c:72: TPASS: =
sys_setitimer(tc-&gt;which, value, ovalue) passed<br>setitimer01.c:76: TINF=
O: tv_sec=3D0, tv_usec=3D31000<br>setitimer01.c:79: TFAIL: Ending counters =
are out of range</div><div style=3D"font-size:small">setitimer01.c:88: TPAS=
S: Child received signal: SIGPROF<br></div><div style=3D"font-size:small"><=
br></div><div style=3D"font-size:small">It seems the tv_usec always increas=
e 1000us, I highly suspect</div><div style=3D"font-size:small">this increas=
e comes from kernel function set_cpu_itimer() that</div><div style=3D"font-=
size:small">explicitly add TICK_NSEC when &#39;nval&#39; is larger than zer=
o:</div><br></div><div><div style=3D"font-size:small">$ cat kernel/time/iti=
mer.c -n</div><div style=3D"font-size:small">=C2=A0 =C2=A0...</div><div sty=
le=3D"font-size:small">=C2=A0 =C2=A0168=09static void set_cpu_itimer(struct=
 task_struct *tsk, unsigned int clock_id,<br>=C2=A0 =C2=A0169=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct itimerspec64 *=
const value,<br>=C2=A0 =C2=A0170=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct itimerspec64 *const ovalue)<br>=C2=A0 =C2=A0171=
=09{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0...<br>=C2=A0 =C2=A0182=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (oval || nv=
al) {<br>=C2=A0 =C2=A0183=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (nval &gt; 0)<br>=C2=A0 =C2=A0184=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0nva=
l +=3D TICK_NSEC;<br>=C2=A0 =C2=A0185=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 set_process_cpu_timer(tsk, clock_id, &amp;nval, &a=
mp;oval);<br>=C2=A0 =C2=A0186=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0=
 =C2=A0187=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>=C2=A0 =C2=A0198=09}<br=
></div><div style=3D"font-size:small"><br></div></div><div style=3D"font-si=
ze:small">To verify my guess, I do a modification based on your patch and</=
div><div style=3D"font-size:small">then easily get the result in pass.</div=
><div style=3D"font-size:small"><br></div><div style=3D"font-size:small">--=
- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>+++ b/testcases/ke=
rnel/syscalls/setitimer/setitimer01.c<br>@@ -76,7 +76,7 @@ static void veri=
fy_setitimer(unsigned int i)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ovalue-&gt;it_value.tv_sec,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ovalue-&gt;it_value.tv_usec);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ovalue-&gt;it_value.tv_sec !=3D 0 || ov=
alue-&gt;it_value.tv_usec &gt; usec)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (ovalue-&gt;it_value.tv_sec !=3D 0 || ovalue-&gt;it_va=
lue.tv_usec - time_step &gt; usec)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TFAIL, &quot;Endin=
g counters are out of range&quot;);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;)<br>@@ -98,8 +98,8 @@ static void s=
etup(void)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_CLOCK_GETRES(CLOCK_MONOTONIC=
, &amp;res);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_step =3D res.tv_=
nsec / 1000;<br>- =C2=A0 =C2=A0 =C2=A0 if (time_step &lt; 10000)<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time_step =3D 10000;<br>+ =C2=
=A0 =C2=A0 =C2=A0 if (time_step &lt; 1000)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 time_step =3D 1000;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tst_res(TINFO, &quot;clock resolution: %luns, time step: %luus&quot=
;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res.tv_nsec,<=
br></div><div>=C2=A0</div></div><div><br></div><div><div style=3D"font-size=
:small">But after trying this with my RasberryPi4, it fails again with an i=
ncrease</div><div style=3D"font-size:small">4000us each time. So it might r=
elated to the system use different=C2=A0time</div><div style=3D"font-size:s=
mall">resolutions. When I shift to use `CLOCK_MONOTONIC_COARSE`</div></div>=
<div style=3D"font-size:small">then test gets passed on all my platforms.</=
div><div style=3D"font-size:small"><br></div><div style=3D"font-size:small"=
>Any comments?</div><div style=3D"font-size:small"><br></div><div><br></div=
><div><div style=3D"font-size:small">----------CLOCK_MONOTONIC-------------=
</div></div><div><div style=3D"font-size:small">setitimer01.c:65: TINFO: tc=
-&gt;which =3D ITIMER_VIRTUAL<br>setitimer01.c:70: TPASS: sys_setitimer(tc-=
&gt;which, value, NULL) passed<br>setitimer01.c:73: TPASS: sys_setitimer(tc=
-&gt;which, value, ovalue) passed<br>setitimer01.c:77: TINFO: tv_sec=3D0, t=
v_usec=3D7000<br>setitimer01.c:80: TFAIL: Ending counters are out of range<=
/div><br><div style=3D"font-size:small">-----------CLOCK_MONOTONIC_COARSE--=
-----</div></div><div><div style=3D"font-size:small">setitimer01.c:65: TINF=
O: tc-&gt;which =3D ITIMER_VIRTUAL<br>setitimer01.c:70: TPASS: sys_setitime=
r(tc-&gt;which, value, NULL) passed<br>setitimer01.c:73: TPASS: sys_setitim=
er(tc-&gt;which, value, ovalue) passed<br>setitimer01.c:77: TINFO: tv_sec=
=3D0, tv_usec=3D16000<br>setitimer01.c:89: TPASS: Child received signal: SI=
GVTALRM<br></div><div style=3D"font-size:small"><br></div><div style=3D"fon=
t-size:small"># lscpu <br>Architecture: =C2=A0 =C2=A0 =C2=A0 =C2=A0aarch64<=
br>Byte Order: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Little Endian<br>CPU(s): =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<br>On-line CPU(s) list: 0=
-3<br>Thread(s) per core: =C2=A01<br>Core(s) per cluster: 4<br>Socket(s): =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -<br>Cluster(s): =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01<br>Vendor ID: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM<br>Mode=
l: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>Model name: =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Cortex-A72<br>Stepping: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0r0p3<br>CPU max MHz: =C2=A0 =C2=A0 =C2=A0 =C2=A0 1500.0=
000<br>CPU min MHz: =C2=A0 =C2=A0 =C2=A0 =C2=A0 600.0000<br>BogoMIPS: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0108.00<br>Flags: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp asimd evtstrm crc32 cpuid<br></div><div sty=
le=3D"font-size:small"></div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"=
ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000094907105eca0b83a--


--===============0347881084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0347881084==--

