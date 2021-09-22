Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE4C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 04:31:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45613608FE
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 04:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45613608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ED9C3C6AD8
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 06:31:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47DC03C17CE
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 06:31:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6FF4320034B
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 06:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632285073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SAg0iCuv+V19RWndikg8qr440OU5H3k5M340hRabmhw=;
 b=X6jqpP/dYOjrHwEeuNOIFUFAvGV5OWidfGTS4yfLw5xVXPXpzhtHv2nKFdNVz7LfB+Nnl6
 wnxyAVshGGhlMdZpWuriguesCeTudGsVYJjyGpW7D9fV+moophzHZuLYElqsoGmI+kqzFI
 SdZ2qvmz7S/WSQF0HlTYB2JfrthG6aU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-BLUeNSTOPJmcn_MpwjySIQ-1; Wed, 22 Sep 2021 00:31:10 -0400
X-MC-Unique: BLUeNSTOPJmcn_MpwjySIQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 h9-20020a05621413a900b0037a2d3eaf8fso9481831qvz.8
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 21:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SAg0iCuv+V19RWndikg8qr440OU5H3k5M340hRabmhw=;
 b=ikKndL45ETuv/x9I0/qhg0A5ZCORyKsSA18d9bB67zFkzbG1l1nhU5jJToe1/PdGCV
 d8y5DgNGi9R0xbb8lm3g2XR3lYCeIndF4hfsVfwr9W0KSFnqFqHpAq0jai/IlgnEcsVB
 eDdL5Qp3uSyo3i8aeTVkqkED7IbEgZP0So/k7fsARXngp1etVAsSFPdJfurJaICLhOVw
 TOaJENkrKEePNJrAx+TUD258ZbVG/YfdnAYBPd+eeFsCjBg591JWZ+7LmMtOX9gKsuuj
 GBiVQO59OHDU98add3suHkZ+KbYeoIxA7Grh6cg6SuovTvgUb/rBUz+IFsWwvsTsbprt
 z5Tg==
X-Gm-Message-State: AOAM532GnCdBHmv7gJ266h564jO2245rmEuoW2vAxW5TZ6JvO75nh47Z
 tCa3U90Uv7LSzMwYQ/KNoZ22IeKHg3gkEAbEwfXvQHYmvBumnFeeFsrd6CBNWNCONip29E5bPuc
 3cPJz8II2YvgxzPwBxJ/tZNPwZRM=
X-Received: by 2002:a25:938e:: with SMTP id a14mr41492251ybm.144.1632285069934; 
 Tue, 21 Sep 2021 21:31:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRJJCZRgm1Zmo2KvitTxhGZWaR9zeL6Lsz0PVTxn5NawGAhHxM5kbJ/ynJz2z7k0Sn6tt0ZP7dhtWJxZCym0Q=
X-Received: by 2002:a25:938e:: with SMTP id a14mr41492232ybm.144.1632285069628; 
 Tue, 21 Sep 2021 21:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210920122146.31576-1-chrubis@suse.cz>
 <CAEemH2eRgUDNLmmzNF5cDaAXp7kMgPOBHeJeWqyStOiAq7QLHw@mail.gmail.com>
 <YUnCYvtAZkO/LZIP@yuki>
In-Reply-To: <YUnCYvtAZkO/LZIP@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 12:30:57 +0800
Message-ID: <CAEemH2e0kHun++Y2w99N68WAhjFdQkSvkF-1UaDxjbkA1sBrAw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: shell: Fix timeout process races
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0402422725=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0402422725==
Content-Type: multipart/alternative; boundary="000000000000bf701305cc8dfbce"

--000000000000bf701305cc8dfbce
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 21, 2021 at 7:30 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > This 'pid' is the parent shell process id, so it obviously that
> > tst_timeout_kill
> > process would get signal SIGTERM as well.
> >
> > I'm thinking maybe we should let tst_timeout_kill itself ignore SIGTERM
> > otherwise we have no chance to perform the following double-check code?
>
> I guess that signal(SIGTERM, SIG_IGN) a the start of the main() should
> fix it.
>

It works, but better put it behind of sleep(timeout).

Because we still need to guarantee tst_timeout_kill can be
stopped by _tst_cleanup_timer before timeout happening.


--- a/testcases/lib/tst_timeout_kill.c
+++ b/testcases/lib/tst_timeout_kill.c
@@ -44,6 +44,8 @@ int main(int argc, char *argv[])
        if (timeout)
                sleep(timeout);

+       signal(SIGTERM, SIG_IGN);
+
        print_msg("Test timed out, sending SIGTERM!");
        print_msg("If you are running on slow machine, try exporting
LTP_TIMEOUT_MUL > 1");

@@ -57,12 +59,12 @@ int main(int argc, char *argv[])

        i = 10;

-       while (!kill(-pid, 0) && i-- > 0) {
+       while (!kill(pid, 0) && i-- > 0) {
                print_msg("Test is still running...");
                sleep(1);
        }

-       if (!kill(-pid, 0)) {
+       if (!kill(pid, 0)) {
                print_msg("Test is still running, sending SIGKILL");
                ret = kill(-pid, SIGKILL);
                if (ret) {


-- 
Regards,
Li Wang

--000000000000bf701305cc8dfbce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 21, 2021 at 7:30 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; This &#39;pid&#39; is the parent shell process id, so it obviously tha=
t<br>
&gt; tst_timeout_kill<br>
&gt; process would get signal SIGTERM as well.<br>
&gt; <br>
&gt; I&#39;m thinking maybe we should let tst_timeout_kill itself ignore SI=
GTERM<br>
&gt; otherwise we have no chance to perform the following double-check code=
?<br>
<br>
I guess that signal(SIGTERM, SIG_IGN) a the start of the main() should<br>
fix it.<br></blockquote><div><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">It works, but better put it behind of sleep(timeout).=
=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">Because we still n=
eed to=C2=A0guarantee=C2=A0tst_timeout_kill can be=C2=A0</div><div class=3D=
"gmail_default" style=3D"font-size:small">stopped by _tst_cleanup_timer bef=
ore timeout happening.</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">--- a/testca=
ses/lib/tst_timeout_kill.c<br>+++ b/testcases/lib/tst_timeout_kill.c<br>@@ =
-44,6 +44,8 @@ int main(int argc, char *argv[])<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (timeout)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 sleep(timeout);<br>=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 signal(SIGTERM, SIG_IG=
N);<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_msg(&quot;Test timed out, sen=
ding SIGTERM!&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_msg(&quot;If you=
 are running on slow machine, try exporting LTP_TIMEOUT_MUL &gt; 1&quot;);<=
br>=C2=A0<br>@@ -57,12 +59,12 @@ int main(int argc, char *argv[])<br>=C2=A0=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 10;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=
=A0 while (!kill(-pid, 0) &amp;&amp; i-- &gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=
=A0 while (!kill(pid, 0) &amp;&amp; i-- &gt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_msg(&quot;Test is still running...=
&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep(1=
);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 if =
(!kill(-pid, 0)) {<br>+ =C2=A0 =C2=A0 =C2=A0 if (!kill(pid, 0)) {<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_msg(&quot;Test is s=
till running, sending SIGKILL&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ret =3D kill(-pid, SIGKILL);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br></div><div class=3D"gmail_=
default" style=3D"font-size:small"><br></div></div><div><br></div>-- <br><d=
iv dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br>=
</div><div>Li Wang<br></div></div></div></div>

--000000000000bf701305cc8dfbce--


--===============0402422725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0402422725==--

