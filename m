Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C519C433F5
	for <ltp@archiver.kernel.org>; Sat, 26 Mar 2022 13:18:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 197203C9732
	for <ltp@archiver.kernel.org>; Sat, 26 Mar 2022 14:18:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E196F3C882C
 for <ltp@lists.linux.it>; Sat, 26 Mar 2022 14:17:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4F026140004B
 for <ltp@lists.linux.it>; Sat, 26 Mar 2022 14:17:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648300665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Ld+kOisvBinv5RNR8BcHMk64kqIQUWRMb1T8aNQtfA=;
 b=GOb/5Y98E2XVZe+dLjBYixkqOC1IfcYPcoOysqDd0pxxuZqqzJ9+SGfxxVv9IEuCb80Rjr
 9YBD1zKZf3CaPO1CyHXKQx3I3Ed8aIm8NBP5DGZ02Dfo/HHPdxYF1uj+0Nuv4hyHai77kv
 FxnSfweMjJiAlBKp7Z61YjI6yVu3Nmw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-yo9tWyQ_Pz6b1vhY1BgknQ-1; Sat, 26 Mar 2022 09:17:43 -0400
X-MC-Unique: yo9tWyQ_Pz6b1vhY1BgknQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2e689dfe112so82080357b3.20
 for <ltp@lists.linux.it>; Sat, 26 Mar 2022 06:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Ld+kOisvBinv5RNR8BcHMk64kqIQUWRMb1T8aNQtfA=;
 b=6L3vGQJRtXuojRUgVRzNg8nGFBuEQFdTKwRWA7MDLw+6R65+dVuzQeey2yF7xupqyg
 TIXXErbSGbIcxrK0URkczbMNuEh6zlMzf0jJc6jeVZLeGKoY5fmUGpuFAWHB5ECdIFSQ
 IXA33MZxkYwxb/w7/lcoBtg23LLFW/NFx0sAlPvER0UkTkWRKQZG41X2bRAqnH3UmVGE
 1+LfMsAgn5wXFcnMafu6SRM++yfWJG+aOlwwC7ox5ASZFSqeGij5sHfyw74oENZJP9HU
 MckaOOcHy3BewOg8AXWmruIOMn+l9Bs709feOXvw5Y1MHlB8LHQakiXrPVbqET6GMoLZ
 WGcA==
X-Gm-Message-State: AOAM5304izxA93n03X+OKq3hF7r72xhfaOhWXQTihyJpvSeslBn0E2sm
 z8PYKbJU2rURD4xqv/SJebNmFXoGLHbX/Wf+2woH8cnSPEqWcOGyJUBSNMpqRmC5EXzI39HkpgQ
 VkfaXe1xofCm8Cy+yCDWmyhP2g8s=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr16884525ywb.370.1648300663231; 
 Sat, 26 Mar 2022 06:17:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK5Sg6Hvtn/sjfqcm6YPwvDcCd+cNkg+8GfMr1kg/fdBCXhVgZUHgGmUufhj8LIzUB+olcA7RBCzyzasha134=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr16884498ywb.370.1648300662877; Sat, 26
 Mar 2022 06:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220325040057.544211-1-liwang@redhat.com> <Yj2V2fu/3Zzio3TZ@yuki>
In-Reply-To: <Yj2V2fu/3Zzio3TZ@yuki>
From: Li Wang <liwang@redhat.com>
Date: Sat, 26 Mar 2022 21:17:29 +0800
Message-ID: <CAEemH2fVf8tMbY4R_O-BrSy7vtmyGgNq3NbYF=LfjyHDbDgkBg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_gettime04: set threshold based on the clock
 tick rate
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0964047099=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0964047099==
Content-Type: multipart/alternative; boundary="0000000000007e89bb05db1ee7c9"

--0000000000007e89bb05db1ee7c9
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


> > --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> > +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> > @@ -35,7 +35,7 @@ clockid_t clks[] = {
> >  };
> >
> >  static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;
> > -static long long delta = 5;
> > +static long long delta;
> >
> >  static inline int do_vdso_gettime(gettime_t vdso, clockid_t clk_id,
> void *ts)
> >  {
> > @@ -92,6 +92,7 @@ static struct time64_variants variants[] = {
> >
> >  static void setup(void)
> >  {
> > +     delta = 1000/sysconf(_SC_CLK_TCK) + 5;
>
> This does not look correct to me. The sysconf(_SC_CLK_TCK) returns 100
> on systems where the test was working fine with 5 second delta. I think
> that the difference is that _SC_CLK_TCK returns how fast are the jiffies
> incremented which does not really matter for most of the modern hardware
> that uses high resolution harware for timers.
>

You're right, I checked some documents and confirmed this.
There I used the system tick rate (in the worst situations) that
seemed a bit loose to other clockids.


> I think that we should really use whatever is returned by the
> clock_getres(CLOCK_REALTIME_COARSE, &res), as long as high resolution
> timers are not available this call will return resolution in miliseconds
> and with high resolution timers available the reported resolution will
> be in nanosecond range, so it should probably be something as:
>
>         clock_getres(CLOCK_REALTIME_COARSE, &res);
>
>         delta = 5 + (res.tv_nsec / 1000000) * 5;
>

Sounds reasonable.

But I don't understand why you multiply 5 for the resolution
(in milliseconds) here. Or, a wiser choice is to get the real
resolution for each clockid? i.e.

--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -92,23 +92,27 @@ static struct time64_variants variants[] = {

 static void setup(void)
 {
-       delta = 1000/sysconf(_SC_CLK_TCK) + 5;
-       if (tst_is_virt(VIRT_ANY)) {
-               tst_res(TINFO, "Running in a virtual machine, multiply the
delta by 10.");
-               delta *= 10;
-       }
-
        find_clock_gettime_vdso(&ptr_vdso_gettime, &ptr_vdso_gettime64);
 }

 static void run(unsigned int i)
 {
        struct tst_ts ts;
+       struct timespec res;
        long long start, end = 0, diff, slack;
        struct time64_variants *tv;
        int count = 10000, ret;
        unsigned int j;

+       clock_getres(clks[i], &res);
+       tst_res(TINFO, "%s: resolution is %ldns", tst_clock_name(clks[i]),
res.tv_nsec);
+
+       delta = 5 + res.tv_nsec/1000000;
+       if (tst_is_virt(VIRT_ANY)) {
+               delta *= 10;
+               tst_res(TINFO, "Multiply the delta by 10 in virtual
machine: %lld", delta);
+       }
+
        do {
                for (j = 0; j < ARRAY_SIZE(variants); j++) {
                        /* Refresh time in start */

-- 
Regards,
Li Wang

--0000000000007e89bb05db1ee7c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>=
&gt; wrote:</div></div><div class=3D"gmail_quote"><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
&gt; --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c<br>
&gt; +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c<br>
&gt; @@ -35,7 +35,7 @@ clockid_t clks[] =3D {<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;<br>
&gt; -static long long delta =3D 5;<br>
&gt; +static long long delta;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static inline int do_vdso_gettime(gettime_t vdso, clockid_t clk_=
id, void *ts)<br>
&gt;=C2=A0 {<br>
&gt; @@ -92,6 +92,7 @@ static struct time64_variants variants[] =3D {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void setup(void)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0delta =3D 1000/sysconf(_SC_CLK_TCK) + 5;<br>
<br>
This does not look correct to me. The sysconf(_SC_CLK_TCK) returns 100<br>
on systems where the test was working fine with 5 second delta. I think<br>
that the difference is that _SC_CLK_TCK returns how fast are the jiffies<br=
>
incremented which does not really matter for most of the modern hardware<br=
>
that uses high resolution harware for timers.<br></blockquote><div><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">You&#39;re right, =
I checked some documents and confirmed this.</div>There I used the system t=
ick rate (in the worst situations) that<br><div class=3D"gmail_default" sty=
le=3D"font-size:small">seemed a bit loose to other clockids.</div><div clas=
s=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail=
_default" style=3D"font-size:small"></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
I think that we should really use whatever is returned by the<br>
clock_getres(CLOCK_REALTIME_COARSE, &amp;res), as long as high resolution<b=
r>
timers are not available this call will return resolution in miliseconds<br=
>
and with high resolution timers available the reported resolution will<br>
be in nanosecond range, so it should probably be something as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clock_getres(CLOCK_REALTIME_COARSE, &amp;res);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 delta =3D 5 + (res.tv_nsec / 1000000) * 5;<br><=
/blockquote><div><br></div>Sounds reasonable.<span class=3D"gmail_default" =
style=3D"font-size:small">=C2=A0</span></div><div class=3D"gmail_quote"><sp=
an class=3D"gmail_default" style=3D"font-size:small"><br></span></div><div =
class=3D"gmail_quote"><span class=3D"gmail_default" style=3D"font-size:smal=
l"></span>But I<span class=3D"gmail_default" style=3D"font-size:small"> don=
&#39;t understand</span>=C2=A0why you multiply=C2=A05 for the resolution<sp=
an class=3D"gmail_default" style=3D"font-size:small">=C2=A0</span></div><di=
v class=3D"gmail_quote">(in milliseconds) here.<span class=3D"gmail_default=
" style=3D"font-size:small"> </span><span class=3D"gmail_default">Or,</span=
>=C2=A0a wiser choice is to get the real<span class=3D"gmail_default">=C2=
=A0</span></div><div class=3D"gmail_quote">resolution for each clockid?<spa=
n class=3D"gmail_default" style=3D"font-size:small"> i.e.</span></div><div =
class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><span class=3D"g=
mail_default" style=3D"font-size:small"></span>--- a/testcases/kernel/sysca=
lls/clock_gettime/clock_gettime04.c<br>+++ b/testcases/kernel/syscalls/cloc=
k_gettime/clock_gettime04.c<br>@@ -92,23 +92,27 @@ static struct time64_var=
iants variants[] =3D {<br>=C2=A0<br>=C2=A0static void setup(void)<br>=C2=A0=
{<br>- =C2=A0 =C2=A0 =C2=A0 delta =3D 1000/sysconf(_SC_CLK_TCK) + 5;<br>- =
=C2=A0 =C2=A0 =C2=A0 if (tst_is_virt(VIRT_ANY)) {<br>- =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quot;Running in a virtual mach=
ine, multiply the delta by 10.&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 delta *=3D 10;<br>- =C2=A0 =C2=A0 =C2=A0 }<br>-<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 find_clock_gettime_vdso(&amp;ptr_vdso_gettime, &amp;p=
tr_vdso_gettime64);<br>=C2=A0}<br>=C2=A0<br>=C2=A0static void run(unsigned =
int i)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tst_ts ts;<br>+ =C2=
=A0 =C2=A0 =C2=A0 struct timespec res;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 long =
long start, end =3D 0, diff, slack;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct t=
ime64_variants *tv;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int count =3D 10000, ret=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int j;<br>=C2=A0<br>+ =C2=A0 =C2=
=A0 =C2=A0 clock_getres(clks[i], &amp;res);<br>+ =C2=A0 =C2=A0 =C2=A0 tst_r=
es(TINFO, &quot;%s: resolution is %ldns&quot;, tst_clock_name(clks[i]), res=
.tv_nsec);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 delta =3D 5 + res.tv_nsec/1000000=
;<br>+ =C2=A0 =C2=A0 =C2=A0 if (tst_is_virt(VIRT_ANY)) {<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 delta *=3D 10;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quot;Multiply the delta by =
10 in virtual machine: %lld&quot;, delta);<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; ARRAY_SIZE(variants); j++) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Refresh time in start */<br><div class=3D"gmail_default" styl=
e=3D"font-size:small"></div></div><div><br></div>-- <br><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wan=
g<br></div></div></div></div>

--0000000000007e89bb05db1ee7c9--


--===============0964047099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0964047099==--

