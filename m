Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E20C19F2D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 09:32:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B7723C9501
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 11:32:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A78B3C05AE
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 11:31:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D0291400B7C
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 11:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660037508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNz9kETrvfi54vxSKaV2P8VxWRlOOgAZ4kGY2ertRN8=;
 b=WCdWnOmRAedt1z6JvICcMrfyVmHn5jHwugiTHcAiRbGdMP3cWWqiVhyj3idzcxOCB6owrR
 Mbt53UbWc/5ViERgX2d8bfIOtqupqRuobXPaBNHIFMPolxrBAA0EUpLAf1N8/V/ODNlHEQ
 +u/GswVjrwmoJcqLBGdySC7BRSAlENo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-WXOfT2EDMCKrgim5ABkEIw-1; Tue, 09 Aug 2022 05:31:47 -0400
X-MC-Unique: WXOfT2EDMCKrgim5ABkEIw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-3231401769dso98797547b3.10
 for <ltp@lists.linux.it>; Tue, 09 Aug 2022 02:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uNz9kETrvfi54vxSKaV2P8VxWRlOOgAZ4kGY2ertRN8=;
 b=uxhyjO24hDxbuMWwYAUkOCr8PGecDgSiSyglqCtQuvfcDDeVW84oeEijf//NI3Amvz
 DtxlEzAUOcCDfnWwqiwH0aEVisVJsYkkyAhXToC9wRDPy4heUGwiu0QykT8S9N0FC74z
 WdInYxMOxLM5cViwZ2wSq+ddo3/kmNByTBXKOqNRyhl/GmvftA6+vABqSKIsGqMjG093
 SSyRrggJa9deaF6SOOmA3xTWuwGVkO6EfSrXWburMSVVnIcpxdSyxLtLMYzPccYUCYd8
 ZDHipcV2MGRLk0lL8bEJH2Snc50dmCGoUrheCaik9dQJXUaSU7itfRwMfhOFm2YJ8Uxm
 FCLg==
X-Gm-Message-State: ACgBeo3K8KzdiR3DEotnyr8PICbutUSRGEcdhpQAarxOmt/xjQwaNTSn
 7jw63/M8xkJoYLJRO0/U3QoDdmGnZKRpEnMOWdEad3ARSzkQU/ZVeRCEydt4of00/ds7+4iqeCM
 ibYWXj/+G8Ptn4vxkAW8EtbUWZb0=
X-Received: by 2002:a81:1c4f:0:b0:322:dd6b:2552 with SMTP id
 c76-20020a811c4f000000b00322dd6b2552mr21891358ywc.320.1660037506580; 
 Tue, 09 Aug 2022 02:31:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4tHGHqWIhyyf4XBdN2cMQDgCjtSGm8RSbaqi/rr859r/TvxefThJ7CPs9Xzqm2WFbBLlm3i/5biS02SmLQmOE=
X-Received: by 2002:a81:1c4f:0:b0:322:dd6b:2552 with SMTP id
 c76-20020a811c4f000000b00322dd6b2552mr21891338ywc.320.1660037506320; Tue, 09
 Aug 2022 02:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-3-pvorel@suse.cz>
In-Reply-To: <20220808113756.11582-3-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Aug 2022 17:31:35 +0800
Message-ID: <CAEemH2eZmemcmn1H3Gi6zpvr+a-tAZ38GFuGzXbWPM7uKCw-AQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] tst_ansi_color.sh: Allow to run with set -e
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
Content-Type: multipart/mixed; boundary="===============1500809676=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1500809676==
Content-Type: multipart/alternative; boundary="000000000000e0e66b05e5cb992d"

--000000000000e0e66b05e5cb992d
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Mon, Aug 8, 2022 at 7:38 PM Petr Vorel <pvorel@suse.cz> wrote:

> set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit
> code, therefore any && must be turned into || (or if ...; then ..; fi).
> Fix hardens tst_res TINFO to be able to be used on scripts with errexit.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v2->v3:
> * really fix it.
>
>  testcases/lib/tst_ansi_color.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/lib/tst_ansi_color.sh
> b/testcases/lib/tst_ansi_color.sh
> index 703df1eb8..517b709d0 100644
> --- a/testcases/lib/tst_ansi_color.sh
> +++ b/testcases/lib/tst_ansi_color.sh
> @@ -24,18 +24,19 @@ tst_flag2color()
>
>  tst_color_enabled()
>  {
> -       [ "$LTP_COLORIZE_OUTPUT" = "n" ] || [ "$LTP_COLORIZE_OUTPUT" = "0"
> ] && return 0
> -       [ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1"
> ] && return 1
> +       [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ]
> || return 1
> +       [ "$LTP_COLORIZE_OUTPUT" = "y" -o "$LTP_COLORIZE_OUTPUT" = "1" ]
> || return 0
>

This can work but looks a bit strange to read. I personally think
use 'if ...; then ; fi' will be better to understand, because this is a
simple function, no need to go with weird logic for over simplifying:).



>         [ -t 1 ] || return 0
>         return 1
>  }
>
>  tst_print_colored()
>  {
> -       tst_color_enabled
> -       local color=$?
> +       local color=0
>
> -       [ "$color" = "1" ] && tst_flag2color "$1"
> +       tst_color_enabled || color=$?
> +
> +       [ "$color" != 1 ] || tst_flag2color "$1"
>         printf "$2"
> -       [ "$color" = "1" ] && printf '\033[0m'
> +       [ "$color" != 1 ] || printf '\033[0m'
>  }
> --
> 2.37.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000e0e66b05e5cb992d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Petr,</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 8, 2022 at 7:38 PM Petr Vorel =
&lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">set -=
e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit<br>
code, therefore any &amp;&amp; must be turned into || (or if ...; then ..; =
fi).<br>
Fix hardens tst_res TINFO to be able to be used on scripts with errexit.<br=
>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
changes v2-&gt;v3:<br>
* really fix it.<br>
<br>
=C2=A0testcases/lib/tst_ansi_color.sh | 13 +++++++------<br>
=C2=A01 file changed, 7 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color=
.sh<br>
index 703df1eb8..517b709d0 100644<br>
--- a/testcases/lib/tst_ansi_color.sh<br>
+++ b/testcases/lib/tst_ansi_color.sh<br>
@@ -24,18 +24,19 @@ tst_flag2color()<br>
<br>
=C2=A0tst_color_enabled()<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;n&=
quot; ] || [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;0&quot; ] &amp;&amp=
; return 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;y&=
quot; ] || [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;1&quot; ] &amp;&amp=
; return 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;n&=
quot; -o &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;0&quot; ] || return 1<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;y&=
quot; -o &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;1&quot; ] || return 0<b=
r></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">This can work but looks a bit strange to read. I personally =
think</div><div class=3D"gmail_default" style=3D"font-size:small">use &#39;=
if ...; then ; fi&#39;=C2=A0will be better to understand, because this is a=
</div><div class=3D"gmail_default" style=3D"font-size:small">simple functio=
n, no need to go with=C2=A0weird logic for over simplifying:).</div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [ -t 1 ] || return 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
=C2=A0}<br>
<br>
=C2=A0tst_print_colored()<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_color_enabled<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local color=3D$?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local color=3D0<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$color&quot; =3D &quot;1&quot; ] &amp;&=
amp; tst_flag2color &quot;$1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_color_enabled || color=3D$?<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$color&quot; !=3D 1 ] || tst_flag2color=
 &quot;$1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &quot;$2&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$color&quot; =3D &quot;1&quot; ] &amp;&=
amp; printf &#39;\033[0m&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$color&quot; !=3D 1 ] || printf &#39;\0=
33[0m&#39;<br>
=C2=A0}<br>
-- <br>
2.37.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000e0e66b05e5cb992d--


--===============1500809676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1500809676==--

