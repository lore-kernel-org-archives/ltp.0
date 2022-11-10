Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5C2C4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 07:01:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C874A3CD64F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 08:01:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E3263CD61D
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 08:01:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A65C1600D38
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 08:01:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668063695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3FZXSMHF58RR1N0cNy/lirenyiPMyOJ20ngmeDmglE=;
 b=IovRiCavUij3boOPphpCpPF0V9TJpcCt04xJQnQulxRZ7A5999siG6SdgkmBPUuezf8trZ
 88YZEmQEKfudv1ApZqw2runPew5Khb8i1XxUNDb9gn5h7ooTkXsrBQX4bge9sduUSawSau
 N82Gw4m+ZHjWrmkG7Np+xQPEzfgrtfk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-Zowld-uCOaSoOxyxNqa3Bg-1; Thu, 10 Nov 2022 02:01:32 -0500
X-MC-Unique: Zowld-uCOaSoOxyxNqa3Bg-1
Received: by mail-ot1-f72.google.com with SMTP id
 p19-20020a056830319300b0066c34a214f2so636738ots.9
 for <ltp@lists.linux.it>; Wed, 09 Nov 2022 23:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f3FZXSMHF58RR1N0cNy/lirenyiPMyOJ20ngmeDmglE=;
 b=U4q77GEXShTx7wmcNK/6OiHl+gn4XVzjS5RQndQnllb2MBY/Q/M6x/LmzAc01zfW9C
 +4/7blL44IH89FDFymyH1R2rhTR67uNS+c0wj/M8cmurLtPIVdlzzSIGHroT3mJFbMNX
 T8Sj//pC0b3XRmIsvO8axAcQl1s1EL9bxCxUT2GUbLb286YdZFURgua7+rNe+IUmX+7b
 B3R6B/1oFtcxkO6gh8PkwmiCGlRcXP8Hha/v2e+rdNWjDwltJP7OX62/Szq2Y9CiH/yd
 IYfTa4F04SY2qJpOiNvTt/cy4OSMjXSOCBro74/RYkciThDl0q2Ps4235nFwWBloDgV9
 i8oQ==
X-Gm-Message-State: ANoB5plxdhWCLS8JBdQsCi0evPmSuNwI0U/XYZpjwZnssIax3/GY3/SF
 aYfesE4hIuk9valcvsEZpCJ/5wNT5rcy306O9ow/dDFO2TEebABnc4O0VIuWWaXouudX7E9AubS
 sxmmuGJcy/OzWdegwPF/Jgfj2yIc=
X-Received: by 2002:a05:6808:15a9:b0:35a:8668:c9ca with SMTP id
 t41-20020a05680815a900b0035a8668c9camr777234oiw.107.1668063692208; 
 Wed, 09 Nov 2022 23:01:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf46az7SmVPqiFJHm2oUQaLZgJLUU7yvMo3/w9C/3XL69gLORmvI+p9rcZ2/M9/JndGS0B6qlHHhg8wrnBLSblY=
X-Received: by 2002:a05:6808:15a9:b0:35a:8668:c9ca with SMTP id
 t41-20020a05680815a900b0035a8668c9camr777227oiw.107.1668063691895; Wed, 09
 Nov 2022 23:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20221107110123.16369-1-andrea.cervesato@suse.com>
In-Reply-To: <20221107110123.16369-1-andrea.cervesato@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Nov 2022 15:01:17 +0800
Message-ID: <CAEemH2fjCBfO3KP1Z7j1fsJde9izthzV2S-zPLiKaT8bAhhTUg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Correctly check setitimer params in setitimer01
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
Content-Type: multipart/mixed; boundary="===============0847424718=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0847424718==
Content-Type: multipart/alternative; boundary="000000000000d1910f05ed18574b"

--000000000000d1910f05ed18574b
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Mon, Nov 7, 2022 at 7:03 PM Andrea Cervesato via ltp <ltp@lists.linux.it>
wrote:

> We use CLOCK_MONOTONIC_COARSE as our time resolution for checking
> setitimer counter boundaries.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Switching to CLOCK_MONOTONIC_COARSE for setitimer time resolution.
>
>  .../kernel/syscalls/setitimer/setitimer01.c   | 33 +++++++++++--------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c
> b/testcases/kernel/syscalls/setitimer/setitimer01.c
> index eb62f02c6..5c880c6ef 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -8,7 +8,7 @@
>  /*\
>   * [Description]
>   *
> - * Spawn a child and verify that setitimer() syscall passes, and it ends
> up
> + * Spawn a child, verify that setitimer() syscall passes and it ends up
>   * counting inside expected boundaries. Then verify from the parent that
> our
>   * syscall sent the correct signal to the child.
>   */
> @@ -22,7 +22,8 @@
>  #include "tst_safe_clocks.h"
>
>  static struct itimerval *value, *ovalue;
> -static unsigned long time_step;
> +static long time_step;
> +static long time_count;
>
>  static struct tcase {
>         int which;
> @@ -56,7 +57,6 @@ static void verify_setitimer(unsigned int i)
>  {
>         pid_t pid;
>         int status;
> -       int usec = 3 * time_step;
>         struct tcase *tc = &tcases[i];
>
>         pid = SAFE_FORK();
> @@ -66,7 +66,7 @@ static void verify_setitimer(unsigned int i)
>
>                 tst_no_corefile(0);
>
> -               set_setitimer_value(usec, 0);
> +               set_setitimer_value(time_count, 0);
>                 TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
>
>                 set_setitimer_value(5 * time_step, 7 * time_step);
>

Maybe we can use 'time_count' instead of 'time_step' as well.



> @@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int i)
>                         ovalue->it_value.tv_sec,
>                         ovalue->it_value.tv_usec);
>
> -               if (ovalue->it_value.tv_sec != 0 ||
> ovalue->it_value.tv_usec > usec)
> +               if (ovalue->it_value.tv_sec != 0 ||
> ovalue->it_value.tv_usec > time_count + time_step)
>

This is not correct for 'ITIMER_REAL', kernel does _not_
add that one jiffy when using high resolution. I'd suggest
taking reference to Martin's code in the last email thread.

And, I also think we'd better insert code comments here to
briefly declare why need to add the time_step for the result
(of ITIMER_VIRTUAL/ITIMER_PROF) comparison, otherwise,
people who are not familiar with this test will be confused.



>                         tst_res(TFAIL, "Ending counters are out of range");
>
>                 for (;;)
> @@ -93,24 +93,29 @@ static void verify_setitimer(unsigned int i)
>
>  static void setup(void)
>  {
> -       struct timespec res;
> +       struct timespec time_res;
>
> -       SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
> +       SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &time_res);
>

And here require code comments on why we choose to
use CLOCK_MONOTONIC_COARSE.



>
> -       time_step = res.tv_nsec / 1000;
> -       if (time_step < 10000)
> -               time_step = 10000;
> +       time_step = time_res.tv_nsec / 1000;
> +       if (time_step <= 0)
> +               time_step = 1000;
>
> -       tst_res(TINFO, "clock resolution: %luns, time step: %luus",
> -               res.tv_nsec,
> -               time_step);
> +       time_count = 3 * time_step;
> +
> +       tst_res(TINFO, "clock resolution: %luns, "
> +               "time step: %luus, "
> +               "time count: %luus",
> +               time_res.tv_nsec,
> +               time_step,
> +               time_count);
>  }
>
>  static struct tst_test test = {
>         .tcnt = ARRAY_SIZE(tcases),
>         .forks_child = 1,
> -       .test = verify_setitimer,
>         .setup = setup,
> +       .test = verify_setitimer,
>         .bufs = (struct tst_buffers[]) {
>                 {&value,  .size = sizeof(struct itimerval)},
>                 {&ovalue, .size = sizeof(struct itimerval)},
> --
> 2.35.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000d1910f05ed18574b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Andrea,</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 7, 2022 at 7:03 PM Andrea Ce=
rvesato via ltp &lt;<a href=3D"mailto:ltp@lists.linux.it" target=3D"_blank"=
>ltp@lists.linux.it</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">We use CLOCK_MONOTONIC_COARSE as our time resolution for=
 checking<br>
setitimer counter boundaries.<br>
<br>
Signed-off-by: Andrea Cervesato &lt;<a href=3D"mailto:andrea.cervesato@suse=
.com" target=3D"_blank">andrea.cervesato@suse.com</a>&gt;<br>
---<br>
Switching to CLOCK_MONOTONIC_COARSE for setitimer time resolution.<br>
<br>
=C2=A0.../kernel/syscalls/setitimer/setitimer01.c=C2=A0 =C2=A0| 33 ++++++++=
+++--------<br>
=C2=A01 file changed, 19 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/=
kernel/syscalls/setitimer/setitimer01.c<br>
index eb62f02c6..5c880c6ef 100644<br>
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
@@ -8,7 +8,7 @@<br>
=C2=A0/*\<br>
=C2=A0 * [Description]<br>
=C2=A0 *<br>
- * Spawn a child and verify that setitimer() syscall passes, and it ends u=
p<br>
+ * Spawn a child, verify that setitimer() syscall passes and it ends up<br=
>
=C2=A0 * counting inside expected boundaries. Then verify from the parent t=
hat our<br>
=C2=A0 * syscall sent the correct signal to the child.<br>
=C2=A0 */<br>
@@ -22,7 +22,8 @@<br>
=C2=A0#include &quot;tst_safe_clocks.h&quot;<br>
<br>
=C2=A0static struct itimerval *value, *ovalue;<br>
-static unsigned long time_step;<br>
+static long time_step;<br>
+static long time_count;<br>
<br>
=C2=A0static struct tcase {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int which;<br>
@@ -56,7 +57,6 @@ static void verify_setitimer(unsigned int i)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid_t pid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int status;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int usec =3D 3 * time_step;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcase *tc =3D &amp;tcases[i];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D SAFE_FORK();<br>
@@ -66,7 +66,7 @@ static void verify_setitimer(unsigned int i)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_no_corefile(0);=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_setitimer_value=
(usec, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_setitimer_value=
(time_count, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_PASS(sys_se=
titimer(tc-&gt;which, value, NULL));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_setitimer_value=
(5 * time_step, 7 * time_step);<br></blockquote><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Maybe we can use &#39;time_=
count&#39; instead of &#39;time_step&#39; as well.</div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
@@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int i)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ovalue-&gt;it_value.tv_sec,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ovalue-&gt;it_value.tv_usec);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ovalue-&gt;it_v=
alue.tv_sec !=3D 0 || ovalue-&gt;it_value.tv_usec &gt; usec)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ovalue-&gt;it_v=
alue.tv_sec !=3D 0 || ovalue-&gt;it_value.tv_usec &gt; time_count + time_st=
ep)<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">This is not correct for &#39;ITIMER_REAL&#39;, kernel =
does _not_</div><div class=3D"gmail_default" style=3D"font-size:small">add =
that one jiffy when using high resolution. I&#39;d suggest</div><div class=
=3D"gmail_default" style=3D"font-size:small">taking reference to Martin&#39=
;s=C2=A0code in the last email thread.</div><br></div><div><div class=3D"gm=
ail_default" style=3D"font-size:small">And, I also think we&#39;d better in=
sert code comments here to</div><div class=3D"gmail_default" style=3D"font-=
size:small">briefly declare why need to add the time_step for the result=C2=
=A0</div><div class=3D"gmail_default" style=3D"font-size:small">(of ITIMER_=
VIRTUAL/ITIMER_PROF) comparison,=C2=A0otherwise,=C2=A0</div><div class=3D"g=
mail_default" style=3D"font-size:small">people who are not familiar with th=
is test will be confused.</div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tst_res(TFAIL, &quot;Ending counters are out of range&quot;);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;)<br>
@@ -93,24 +93,29 @@ static void verify_setitimer(unsigned int i)<br>
<br>
=C2=A0static void setup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct timespec res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct timespec time_res;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &amp;res);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &amp;=
time_res);<br></blockquote><div><br></div><div><div class=3D"gmail_default"=
 style=3D"font-size:small">And here require code comments on why we choose =
to</div><div class=3D"gmail_default" style=3D"font-size:small">use CLOCK_MO=
NOTONIC_COARSE.</div></div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time_step =3D res.tv_nsec / 1000;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (time_step &lt; 10000)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time_step =3D 10000=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0time_step =3D time_res.tv_nsec / 1000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (time_step &lt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time_step =3D 1000;=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;clock resolution: %luns, t=
ime step: %luus&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res.tv_nsec,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time_step);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0time_count =3D 3 * time_step;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;clock resolution: %luns, &=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;time step: %l=
uus, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;time count: %=
luus&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time_res.tv_nsec,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time_step,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time_count);<br>
=C2=A0}<br>
<br>
=C2=A0static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tcnt =3D ARRAY_SIZE(tcases),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .forks_child =3D 1,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.test =3D verify_setitimer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.test =3D verify_setitimer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .bufs =3D (struct tst_buffers[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&amp;value,=C2=A0 =
.size =3D sizeof(struct itimerval)},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&amp;ovalue, .size=
 =3D sizeof(struct itimerval)},<br>
-- <br>
2.35.3<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000d1910f05ed18574b--


--===============0847424718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0847424718==--

