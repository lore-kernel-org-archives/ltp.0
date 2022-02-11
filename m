Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C41C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 06:48:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 743D83C9EF9
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:48:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C8BC3C5446
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:47:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F0D0A1400512
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644562073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ya8r0mf/TqH1GaRcNSE+Ie7KcZijzi8vXJRebXgxajQ=;
 b=Qx8dnhMYhgXTJQ8tn4otbRPAhgCVwBWuhQFIvyByrBa+Btz6FhRTGe8ijH/p09VoJ1RboX
 nb/NqcnsHqLpv/Q/zNZ8Og2AyAJHncWiOt8hkNoTEZd8CSlLAV8CR0itvSgsuYrI7Pehiy
 rTPCMRQHmqV6WQDHGqHROj2MNAnHkMg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417--8GcTmxLOKqpc73sfxw3xg-1; Fri, 11 Feb 2022 01:47:51 -0500
X-MC-Unique: -8GcTmxLOKqpc73sfxw3xg-1
Received: by mail-yb1-f200.google.com with SMTP id
 a88-20020a25a1e1000000b00615c588ab22so17147769ybi.3
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 22:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ya8r0mf/TqH1GaRcNSE+Ie7KcZijzi8vXJRebXgxajQ=;
 b=YuVKwEGLOGraeOM6V+LdufclIFHouKs1h76wyKpxbcfAaziveiweI0QCkSlYIUXIxD
 PpBWdXQ+JGgHZCelZRZy449oPJfLTMDB5XVKpPTo8CD4Uu/ELuJSZ/ujY3NUbUJBtYve
 8HnviVanVXePOszNUxTeLgIW9JESKNX85XCqZ8kpVDnW+he2EABSKVNmnkZoZOjkBMyB
 xWorqkOkVr0ZMfukiNj/bwDoKbhp9SUGBBzqNdKmFoO50cgbhO244xqsPn9n+rvXmvEu
 osNH9xPg0UdRgsISsg/aeTWZloTRk5/HJgXwENAt4RBz3zZ64h/I+yqyPVfRd+WOD1y7
 TTng==
X-Gm-Message-State: AOAM531upmTyUealhrrXAPyU1yZTAFLrcGkoJSCKHcogcIHjY9zetWOq
 B1qAJJTGyk+P97EQ4aRo4wlWq+eORIzCjm7BN5xAMfOwQz/hsHZ4qAYkHni/yeidCo49ixlGnJg
 clFjfaAZAzWq7BBUruqs6BNnOK9c=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr167495ybj.32.1644562071239;
 Thu, 10 Feb 2022 22:47:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7s1Dym7lCme/okVMFmKPIV0XrYPcCPs/KiQZeNbNB+ANgoIF6V2SlCnzEsKi6Oi8vNDJq/WPRU13usoyW2a0=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr167487ybj.32.1644562071009;
 Thu, 10 Feb 2022 22:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20220210161817.11555-1-mdoucha@suse.cz>
In-Reply-To: <20220210161817.11555-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Feb 2022 14:47:37 +0800
Message-ID: <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Terminate leftover subprocesses when main test
 process crashes
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
Content-Type: multipart/mixed; boundary="===============0363426927=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0363426927==
Content-Type: multipart/alternative; boundary="0000000000000dd0de05d7b87202"

--0000000000000dd0de05d7b87202
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 11, 2022 at 12:18 AM Martin Doucha <mdoucha@suse.cz> wrote:

> When the main test process crashes or gets killed e.g. by OOM killer,
> the watchdog process currently does not clean up any remaining child
> processes. Fix this by sending SIGKILL to the test process group when
> the watchdog process gets notified that the main test process has exited
> for any reason.
>


> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1399,6 +1399,13 @@ static void sigint_handler(int sig
> LTP_ATTRIBUTE_UNUSED)
>         }
>  }
>
> +static void sigchild_handler(int sig LTP_ATTRIBUTE_UNUSED)
> +{
> +       /* If the test process is dead, send SIGKILL to its children */
> +       if (kill(test_pid, 0))
> +               kill(-test_pid, SIGKILL);
> +}
> +
>  unsigned int tst_timeout_remaining(void)
>  {
>         static struct timespec now;
> @@ -1481,6 +1488,7 @@ static int fork_testrun(void)
>                 tst_disable_oom_protection(0);
>                 SAFE_SIGNAL(SIGALRM, SIG_DFL);
>                 SAFE_SIGNAL(SIGUSR1, SIG_DFL);
> +               SAFE_SIGNAL(SIGCHLD, SIG_DFL);
>                 SAFE_SIGNAL(SIGINT, SIG_DFL);
>                 SAFE_SETPGID(0, 0);
>                 testrun();
> @@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc, char *argv[], struct
> tst_test *self)
>
>         SAFE_SIGNAL(SIGALRM, alarm_handler);
>         SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
> +       SAFE_SIGNAL(SIGCHLD, sigchild_handler);
>

Do we really need setup this signal handler for SIGCHILD?

Since we have already called 'SAFE_WAITPID(test_pid, &status, 0)'
in the library process (lib_pid) which rely on SIGCHILD as well.
And even this handler will be called everytime when test exit normally.

Maybe better just add a kill function to cleanup the remain
descendants if main test process exit with abonormal status.

e.g.

--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1503,6 +1503,8 @@ static int fork_testrun(void)
        if (WIFEXITED(status) && WEXITSTATUS(status))
                return WEXITSTATUS(status);

+       kill(-test_pid, SIGKILL);
+
        if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
                tst_res(TINFO, "If you are running on slow machine, "
                               "try exporting LTP_TIMEOUT_MUL > 1");

-- 
Regards,
Li Wang

--0000000000000dd0de05d7b87202
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 11, 2022 at 12:18 AM Martin Doucha &lt;=
<a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">When the main test proces=
s crashes or gets killed e.g. by OOM killer,<br>
the watchdog process currently does not clean up any remaining child<br>
processes. Fix this by sending SIGKILL to the test process group when<br>
the watchdog process gets notified that the main test process has exited<br=
>
for any reason.<br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
--- a/lib/tst_test.c<br>
+++ b/lib/tst_test.c<br>
@@ -1399,6 +1399,13 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNU=
SED)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
+static void sigchild_handler(int sig LTP_ATTRIBUTE_UNUSED)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the test process is dead, send SIGKILL to=
 its children */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (kill(test_pid, 0))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kill(-test_pid, SIG=
KILL);<br>
+}<br>
+<br>
=C2=A0unsigned int tst_timeout_remaining(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 static struct timespec now;<br>
@@ -1481,6 +1488,7 @@ static int fork_testrun(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_disable_oom_pro=
tection(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(SIGALRM=
, SIG_DFL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(SIGUSR1=
, SIG_DFL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SIGNAL(SIGCHLD=
, SIG_DFL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(SIGINT,=
 SIG_DFL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SETPGID(0, 0);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testrun();<br>
@@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc, char *argv[], struct ts=
t_test *self)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(SIGALRM, alarm_handler);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(SIGUSR1, heartbeat_handler);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SIGNAL(SIGCHLD, sigchild_handler);<br></bl=
ockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Do we really need setup this signal handler for SIGCHILD?</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmai=
l_default" style=3D"font-size:small">Since we have already called &#39;SAFE=
_WAITPID(test_pid, &amp;status, 0)&#39;</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">in the library process (lib_pid) which rely on SIG=
CHILD as well.</div><div class=3D"gmail_default" style=3D"font-size:small">=
And even this handler will be called everytime when test exit normally.</di=
v><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">Maybe better just add a kill=
 function=C2=A0to cleanup the remain</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">descendants if main test process exit with abonormal =
status.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">e.g.</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">--- a/lib/tst_test.c<br>+++ b/lib/tst=
_test.c<br>@@ -1503,6 +1503,8 @@ static int fork_testrun(void)<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (WIFEXITED(status) &amp;&amp; WEXITSTATUS(status))<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return WEXITSTAT=
US(status);<br>=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 kill(-test_pid, SIGKILL);<b=
r>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (WIFSIGNALED(status) &amp;&amp; WTERM=
SIG(status) =3D=3D SIGKILL) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tst_res(TINFO, &quot;If you are running on slow machine, &quo=
t;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;try exporting LTP_TIMEOUT_M=
UL &gt; 1&quot;);<br></div></div><div><br></div>-- <br><div dir=3D"ltr" cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang=
<br></div></div></div></div>

--0000000000000dd0de05d7b87202--


--===============0363426927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0363426927==--

