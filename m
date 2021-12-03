Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6934C433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 16:42:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 584E13C908E
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 17:42:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A88F3C88DF
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 17:42:02 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B2C91A01072
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 17:42:02 +0100 (CET)
Received: by mail-pf1-x433.google.com with SMTP id x131so3388536pfc.12
 for <ltp@lists.linux.it>; Fri, 03 Dec 2021 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
 bh=Ts26fyf1U51sthD6yufqMtDk6EewFliawaw6NCN8wuM=;
 b=QNqiYAqfeDgkgHsHLIdjysNQopCoV3QNXu9uNKcxwhQKH/5SxiGmxr0ApEOKx+ucLD
 tfvtBesPo8XSbv4UX+bm6RvF6xYOkYG7CYGIRhXeUTvoLyWK1l88hTiF91ZUibLU8GHI
 iTRgI9VViebaTg94Yz1tEXpS7YpqrJYfnqT3RH+L8nYwMCX/+nNjVGMLw1ucnT7dVNYi
 TS9pNEE3qaY9RPdLUVoOwj2YY0hyDxYNrmZFeDmRgz2W51nrZ+cRF4o92x3ximjfvmQ6
 E5gKiJ6GsVj7y5hbB0/OsqHDl1aJYFty/TzOa3/kvwnnGmp3DabLICpVpiXsTUhAp8Sc
 bsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:cc;
 bh=Ts26fyf1U51sthD6yufqMtDk6EewFliawaw6NCN8wuM=;
 b=exWDX3HfFSf1ZYGgZEOTQDg1EuwKfD3xOMuq4H2I0rutloAJtCrmI66o0uTfeuYz1v
 Vyx6rgS24FWspZxh2EJpMezNY0lSra/UKhxtkf9wZ/Ek3/VN4wP3d3OLo1iiBbfXH9Ii
 vEoFgzmMFDuPR7A74Kr38Nbo1JfzfOegp5TcOVWxGcXhEbTELN/s3OopEibYHShV6tdP
 xX9xVIiX7cHt+D8kGLDe9GqlTbt5GtVqMu0YD+Z45FPDXv6n9Qo6rlYnLd2Zl4fFrnNg
 I/Cdd0vrK9YE2RGdvu6SRcl/47lY0iLCzOj0/pHDu135GFxCw0f1gZ2LGCOizcdkCw2t
 +b0g==
X-Gm-Message-State: AOAM531MnlmGizG95U9R4Zmyh+vdu/7aAnmLh5/GLPSekSGNr7YQ0e/j
 3m8mUTqEFQGs5jfRmt8NLlMd9Dd3xNSw2KFhQkR1cyGk
X-Google-Smtp-Source: ABdhPJz1TDpv+JaXC0LQI4OmMmxNT3/JGktK4T9YcgLxTP0U94UxY2u/UdxfoNHnsgV/d+guIRkb2CXw/VGFqD2SQ1U=
X-Received: by 2002:a05:6a00:1741:b0:4a6:3de7:a816 with SMTP id
 j1-20020a056a00174100b004a63de7a816mr20509592pfc.29.1638549720602; Fri, 03
 Dec 2021 08:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20211127121609.26837-1-saginakash@gmail.com>
In-Reply-To: <20211127121609.26837-1-saginakash@gmail.com>
From: Sagi Nakash <saginakash@gmail.com>
Date: Fri, 3 Dec 2021 18:41:50 +0200
Message-ID: <CAMkC073EZbyb_wux7-Kfv+eT+wL0bB421KpbkypMhkM33LHdvg@mail.gmail.com>
Cc: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] ltp-pan: Report failure if testcases failed
 to run
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
Content-Type: multipart/mixed; boundary="===============0006176817=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0006176817==
Content-Type: multipart/alternative; boundary="0000000000000b1a2305d2409685"

--0000000000000b1a2305d2409685
Content-Type: text/plain; charset="UTF-8"

Ping

On Sat, Nov 27, 2021, 14:16 Sagi Nakash <saginakash@gmail.com> wrote:

> In case a test fails to run in run_child() for some reason (signaled via
> SIGTERM/SIGTOP, execve() failure, etc.), runltp still reports success:
> "INFO: ltp-pan reported all tests PASS".
>
> Failed tests are reported via check_pids(), by checking their exit
> status, yet it doesn't catch tests which weren't able to run at all.
>
> exit_stat holds the exit status code: 0 in case of success in all tests,
> otherwise, the number of failed tests.
>
> Fix this by increasing exit_stat also when a test fails to run.
>
> Signed-off-by: Sagi Nakash <saginakash@gmail.com>
> ---
>  pan/ltp-pan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
> index 0bdb51477..eff9a867d 100644
> --- a/pan/ltp-pan.c
> +++ b/pan/ltp-pan.c
> @@ -551,6 +551,8 @@ int main(int argc, char **argv)
>                                 ++num_active;
>                         if ((cpid != -1 || sequential) && starts > 0)
>                                 --starts;
> +                       if (cpid == -1 && track_exit_stats)
> +                               exit_stat++;
>
>                         if (sequential)
>                                 if (++c >= coll->cnt)
> --
> 2.25.1
>
>

--0000000000000b1a2305d2409685
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ping</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Sat, Nov 27, 2021, 14:16 Sagi Nakash &lt;<a href=
=3D"mailto:saginakash@gmail.com">saginakash@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">In case a test fails to run in run_child(=
) for some reason (signaled via<br>
SIGTERM/SIGTOP, execve() failure, etc.), runltp still reports success:<br>
&quot;INFO: ltp-pan reported all tests PASS&quot;.<br>
<br>
Failed tests are reported via check_pids(), by checking their exit<br>
status, yet it doesn&#39;t catch tests which weren&#39;t able to run at all=
.<br>
<br>
exit_stat holds the exit status code: 0 in case of success in all tests,<br=
>
otherwise, the number of failed tests.<br>
<br>
Fix this by increasing exit_stat also when a test fails to run.<br>
<br>
Signed-off-by: Sagi Nakash &lt;<a href=3D"mailto:saginakash@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">saginakash@gmail.com</a>&gt;<br>
---<br>
=C2=A0pan/ltp-pan.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c<br>
index 0bdb51477..eff9a867d 100644<br>
--- a/pan/ltp-pan.c<br>
+++ b/pan/ltp-pan.c<br>
@@ -551,6 +551,8 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++num_active;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if ((cpid !=3D -1 || sequential) &amp;&amp; starts &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --starts;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (cpid =3D=3D -1 &amp;&amp; track_exit_stats)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_stat++;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (sequential)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (++c &gt;=3D coll-&gt;cnt)<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--0000000000000b1a2305d2409685--

--===============0006176817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0006176817==--
