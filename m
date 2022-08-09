Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59046C19F2D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 09:35:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33D643C949E
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 11:35:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 324483C05AE
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 11:35:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4F7B81400B86
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 11:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660037743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i3FiT5Y8SHbzHe9aVPeq6X730Za4Fl9BiFXsh9/KUg0=;
 b=JVxcyvKl8HW/J+SF+IgcRYqvDi15Usp/vUF1Yviy6p2cnb7kFLYNuPI7PO95yHfB7JL+aL
 Ro4pEmSGdfIH6bG9QXEd16g6UmosTXjwLZ6A/iq9ccomj3ntf6PFplGDofIE8U/vrgIUE4
 9w3dHqim/So0XPxJg/RdEaOEZwXDbyM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-uekaxZlCMcyuIxt08mA9Wg-1; Tue, 09 Aug 2022 05:35:41 -0400
X-MC-Unique: uekaxZlCMcyuIxt08mA9Wg-1
Received: by mail-yb1-f198.google.com with SMTP id
 k16-20020a252410000000b006718984ef63so9282125ybk.3
 for <ltp@lists.linux.it>; Tue, 09 Aug 2022 02:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i3FiT5Y8SHbzHe9aVPeq6X730Za4Fl9BiFXsh9/KUg0=;
 b=6yBJegeqBfoKA7pL3ri91PkXvez3+mLAsspFr3KJt7+0gcMea8cxS6E8En/XKS5pLk
 ksMVYUSf15HJ3YzLFb1sZXQvCncUpdlhxoFNhelxHDLQRRZEJpTsksAxTjX+CwPp0LVE
 bX4p6rldDMdYt/+WOhXbdNd6Wo5lRbZLU6JdfszZgRtg+E0XBwQlSZqzCpbprzmDuBwu
 jcWCNauQ9Fev7SYxe9P4hNDTrHA9/gSFYs+IGHOBQW9w2qI9BBkKYMEDXMhbxkMX9JAY
 MLbJCwC3ulbdt/AfEucs/08NP/tSDz/3dIEF3vHP8y5p9c9Sq2JdUb88vxp4dp98rzKl
 +Yyw==
X-Gm-Message-State: ACgBeo15JrWmmVLaRBexd++BwIXAvWIvvPv0RLFHnH8Gf5g5Lnhs5UoR
 sXqTVMYoqWApsYOC9YqzaA5qb0IRhLrhfTpfQDs9hYEAp1itU3Ed7TDYWQWZ8T9muAPsj0kKGdx
 aq7DuNj/03dusD4Bu52tButbmKCk=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr19999439ybn.597.1660037741159; 
 Tue, 09 Aug 2022 02:35:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5uNPFswlPDH3YQzcpHdZeyRqfM/wIW6PskKmmG4HOe6DKyLgzYDL/yeZi/7AGxwPjvmO3A2B4Qshltln6l/tI=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr19999428ybn.597.1660037740990; Tue, 09
 Aug 2022 02:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-4-pvorel@suse.cz>
In-Reply-To: <20220808113756.11582-4-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Aug 2022 17:35:30 +0800
Message-ID: <CAEemH2c=CniTRfXv8tyLh-866WyZVpnhmCtfK1DAgXJU95q_5w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] tst_test.sh: Fix _tst_cleanup_timer() on
 set -e
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
Content-Type: multipart/mixed; boundary="===============0039075310=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0039075310==
Content-Type: multipart/alternative; boundary="000000000000ddaa1c05e5cba7a2"

--000000000000ddaa1c05e5cba7a2
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 8, 2022 at 7:39 PM Petr Vorel <pvorel@suse.cz> wrote:

> If test exits on time (i.e. no timeout) kill in _tst_cleanup_timer()
> have nothing to kill therefore following wait exits 143.
>
> set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit code,
> fix hardens _tst_cleanup_timer() to be able to be used on scripts with it.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I can use 'if ...; then ; fi' if you prefer:
>
>         if [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0"
> ]; then
>                 return 0
>         fi
>
>         if [ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" =
> "1" ]; then
>                 return 1
>         fi
>
> ...
>         if [ "$color" = 1 ]; then
>                 tst_flag2color "$1"
>         fi
>         printf "$2"
>         if [ "$color" = 1 ]; then
>                 printf '\033[0m'
>         fi
>

These ^ clarifications should be added in patch 2/4, right?

Anyway, this one looks good.
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000ddaa1c05e5cba7a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Aug 8, 2022 at 7:39 PM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">If test exits =
on time (i.e. no timeout) kill in _tst_cleanup_timer()<br>
have nothing to kill therefore following wait exits 143.<br>
<br>
set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit code,=
<br>
fix hardens _tst_cleanup_timer() to be able to be used on scripts with it.<=
br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
I can use &#39;if ...; then ; fi&#39; if you prefer:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot=
;n&quot; -o &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;0&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot=
;y&quot; ] || [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;1&quot; ]; then<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;$color&quot; =3D 1 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_flag2color &quo=
t;$1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &quot;$2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;$color&quot; =3D 1 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &#39;\033[0m=
&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br></blockquote><div><br></div><div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">These ^ clarifications shoul=
d be added in patch 2/4, right?</div><br></div><div><div class=3D"gmail_def=
ault" style=3D"font-size:small">Anyway, this one looks good.</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a h=
ref=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt=
;</div></div></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000ddaa1c05e5cba7a2--


--===============0039075310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0039075310==--

