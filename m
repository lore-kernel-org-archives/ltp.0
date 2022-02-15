Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA69C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 04:31:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D40E3C9FF8
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 05:31:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B3B53C9771
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 05:30:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 92F9F1A01200
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 05:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644899455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmfH9s1pWf5UWGMCD7pf1I+w3+J3c8boEeZ1kKQr23E=;
 b=MsUHKLIMN4YT3rcPyz+mEt2olXsutd8R1MKshSqAWydiWVjgT+atFqjdljF2UUecb7XBPX
 X3sB4+gHjeLQu39xxrqLPNOHkpf2W1gt9ouujbpsgSoY1FTwpmWjEGaCixhUACWT3H0D0F
 H+R5SB2JaICpYjTxmUsSBnTZBmia7wg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-qswnppyGNH6O6GktuwbeIQ-1; Mon, 14 Feb 2022 23:30:50 -0500
X-MC-Unique: qswnppyGNH6O6GktuwbeIQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 s11-20020a255e0b000000b0062277953037so13370344ybb.21
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 20:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hmfH9s1pWf5UWGMCD7pf1I+w3+J3c8boEeZ1kKQr23E=;
 b=P7woSC1T00+atFpyL9cxk8zAkpuJIjMH3Yo8fCBVejMBgGckhhhmZBIputnpiJLWsG
 f3CHqYZMIeDxdzHLCNPXIVkVmBHndLCu1W6pzLbX8+nacZUXMYq50JVureJUwKR5MHJT
 Qo9UAWJYvjmDUd66JRofnYMKvRSQgS8+GqmUHsRe6UQ0SmV4Lk6fzAZYO/59WPqfBMUR
 3cgPRuMXpT4DtIcBGxhZlTl7/nPjnmy6Q0QT16m4sQOFaojsJSlTGolthfElZAgw8H2L
 n9dxFthACJcVlVOgFd1AoYBRgIyPXWOyxzZBCKjrOYFP5jzul9NFkevd/7tZUfq/pcZi
 T+pQ==
X-Gm-Message-State: AOAM533fujIwTpCPub0rUVdAw41AnRVJeCOchQqGB3xr1IdD5iqFhAhH
 A6OrQkeObnjP5PoM2SOykQ0U26fDY+D8lEKidiXrRBrs7IrP4ye8H2CPRnxKh1onnw8Vb7uFwmI
 idP44zSI/8MGEZspthoIMW8w/sUM=
X-Received: by 2002:a81:e543:: with SMTP id c3mr2089001ywm.370.1644899449751; 
 Mon, 14 Feb 2022 20:30:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwS3WKn3j14G6uwqI+CLdwOO1AjSv4LiY+lYV5kjLQwfpvlhQECDT0towKe0vOnHHM6M1WiowPaqrj5RCMj0Dg=
X-Received: by 2002:a81:e543:: with SMTP id c3mr2088982ywm.370.1644899449491; 
 Mon, 14 Feb 2022 20:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20220214165129.32686-1-mdoucha@suse.cz>
In-Reply-To: <20220214165129.32686-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Feb 2022 12:30:35 +0800
Message-ID: <CAEemH2c=+3_HBez0Pn6Yyx+v4PXJpwD3HZtPt87BR6AohtKvUw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup.sh: Fix race condition
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
Content-Type: multipart/mixed; boundary="===============0522290994=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0522290994==
Content-Type: multipart/alternative; boundary="00000000000060e73c05d806ffa2"

--00000000000060e73c05d806ffa2
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 15, 2022 at 12:51 AM Martin Doucha <mdoucha@suse.cz> wrote:

> Processes can stay alive for a short while even after receiving SIGKILL.
> Give the child in subprocess cleanup libtest up to 5 seconds to fully exit
> before reporting that it was left behind.


> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  lib/newlib_tests/test_children_cleanup.sh | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/lib/newlib_tests/test_children_cleanup.sh
> b/lib/newlib_tests/test_children_cleanup.sh
> index 4b4e8b2f0..44505aa51 100755
> --- a/lib/newlib_tests/test_children_cleanup.sh
> +++ b/lib/newlib_tests/test_children_cleanup.sh
> @@ -10,10 +10,19 @@ rm "$TMPFILE"
>  if [ "x$CHILD_PID" = "x" ]; then
>         echo "TFAIL: Child process was not created"
>         exit 1
> -elif ! kill -s 0 $CHILD_PID &>/dev/null; then
> -       echo "TPASS: Child process was cleaned up"
> -       exit 0
> -else
> -       echo "TFAIL: Child process was left behind"
> -       exit 1
>  fi
> +
> +# The child process can stay alive for a short while even after receiving
> +# SIGKILL, especially if the system is under heavy load. Wait up to 5
> seconds
> +# for it to fully exit.
>


It doesn't work for all platforms and we can not guarantee how long it will
cost before PID 1 reaps zombie process.

Also, I just get to know that  Docker does not run processes under a
special init process that properly reaps child processes, so that it is
possible for the container to end up with zombie processes that cause
all sorts of trouble.

I even try adding `kill -SIGCHLD 1` but does not work as expected.

See CI jobs:
  https://github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=true
<https://mail.google.com/mail/u/1/%E2%80%8Bhttps://github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=true>

Therefore, I suggest giving a chance to my refined patch V2 :).

--- a/lib/newlib_tests/test_children_cleanup.sh
+++ b/lib/newlib_tests/test_children_cleanup.sh
@@ -10,10 +10,16 @@ rm "$TMPFILE"
 if [ "x$CHILD_PID" = "x" ]; then
        echo "TFAIL: Child process was not created"
        exit 1
+elif grep -q "Z (zombie)" /proc/$CHILD_PID/status; then
+       echo "TPASS: Child process is in zombie state"
+       exit 0
 elif ! kill -s 0 $CHILD_PID &>/dev/null; then
        echo "TPASS: Child process was cleaned up"
        exit 0
 else
        echo "TFAIL: Child process was left behind"
+       echo "cat /proc/$CHILD_PID/status"
+       echo "---------------------------"
+       cat /proc/$CHILD_PID/status
        exit 1
 fi


-- 
Regards,
Li Wang

--00000000000060e73c05d806ffa2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 15, 2022 at 12:51 AM Martin Doucha &lt;=
<a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Processes can stay alive =
for a short while even after receiving SIGKILL.<br>
Give the child in subprocess cleanup libtest up to 5 seconds to fully exit<=
br>
before reporting that it was left behind.</blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
Signed-off-by: Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=
=3D"_blank">mdoucha@suse.cz</a>&gt;<br>
---<br>
=C2=A0lib/newlib_tests/test_children_cleanup.sh | 21 +++++++++++++++------<=
br>
=C2=A01 file changed, 15 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/lib/newlib_tests/test_children_cleanup.sh b/lib/newlib_tests/t=
est_children_cleanup.sh<br>
index 4b4e8b2f0..44505aa51 100755<br>
--- a/lib/newlib_tests/test_children_cleanup.sh<br>
+++ b/lib/newlib_tests/test_children_cleanup.sh<br>
@@ -10,10 +10,19 @@ rm &quot;$TMPFILE&quot;<br>
=C2=A0if [ &quot;x$CHILD_PID&quot; =3D &quot;x&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;TFAIL: Child process was not created=
&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
-elif ! kill -s 0 $CHILD_PID &amp;&gt;/dev/null; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TPASS: Child process was cleaned up&=
quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TFAIL: Child process was left behind=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
=C2=A0fi<br>
+<br>
+# The child process can stay alive for a short while even after receiving<=
br>
+# SIGKILL, especially if the system is under heavy load. Wait up to 5 seco=
nds<br>
+# for it to fully exit.<br></blockquote><div><br></div><div><br></div><div=
><div class=3D"gmail_default" style=3D"">It doesn&#39;t work for all platfo=
rms and we can not guarantee how long it will<br>cost before PID 1 reaps zo=
mbie process.</div><div class=3D"gmail_default" style=3D""><br>Also, I just=
 get to know that =C2=A0Docker does not run processes under a</div><div cla=
ss=3D"gmail_default" style=3D"">special init process that properly reaps ch=
ild processes, so that it is</div><div class=3D"gmail_default" style=3D"">p=
ossible for the container to end up with zombie processes that cause</div><=
div class=3D"gmail_default" style=3D"">all sorts of trouble.</div><div clas=
s=3D"gmail_default" style=3D""><br></div><div class=3D"gmail_default" style=
=3D"">I even try adding `kill -SIGCHLD 1` but does not work as expected.</d=
iv><div class=3D"gmail_default" style=3D""><br></div><div class=3D"gmail_de=
fault" style=3D"font-size:small">See CI jobs:</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">=C2=A0=C2=A0<a href=3D"https://mail.google.c=
om/mail/u/1/%E2%80%8Bhttps://github.com/wangli5665/ltp/runs/5194270998?chec=
k_suite_focus=3Dtrue">https://github.com/wangli5665/ltp/runs/5194270998?che=
ck_suite_focus=3Dtrue</a></div><div class=3D"gmail_default" style=3D"font-s=
ize:small"></div></div><div class=3D"gmail_default" style=3D"font-size:smal=
l"><br></div></div><div class=3D"gmail_default" style=3D"font-size:small">T=
herefore, I suggest giving a chance to my refined patch V2 :).</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">--- a/lib/newlib_tests/test_children_=
cleanup.sh<br>+++ b/lib/newlib_tests/test_children_cleanup.sh<br>@@ -10,10 =
+10,16 @@ rm &quot;$TMPFILE&quot;<br>=C2=A0if [ &quot;x$CHILD_PID&quot; =3D=
 &quot;x&quot; ]; then<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;TFAIL: Chi=
ld process was not created&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>+=
elif grep -q &quot;Z (zombie)&quot; /proc/$CHILD_PID/status; then<br>+ =C2=
=A0 =C2=A0 =C2=A0 echo &quot;TPASS: Child process is in zombie state&quot;<=
br>+ =C2=A0 =C2=A0 =C2=A0 exit 0<br>=C2=A0elif ! kill -s 0 $CHILD_PID &amp;=
&gt;/dev/null; then<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;TPASS: Child =
process was cleaned up&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 0<br>=C2=
=A0else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;TFAIL: Child process was =
left behind&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 echo &quot;cat /proc/$CHILD_PID=
/status&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 echo &quot;------------------------=
---&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 cat /proc/$CHILD_PID/status<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 exit 1<br>=C2=A0fi<br></div><br clear=3D"all"><div><br=
></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><=
div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000060e73c05d806ffa2--


--===============0522290994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0522290994==--

