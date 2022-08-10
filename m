Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD6CC19F2D
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 02:46:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B2973C95F9
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 04:46:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 522043C9480
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 04:46:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A1316008AC
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 04:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660099595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TP54dNuoJWZCvzTBf5b1d8HF5FyZ9a8ryLOYv+CY3Jw=;
 b=h59EZciKXXhUOJ8RWBzbmjrFpXELRxXVj611j6EQkKmBM3M+w8/N9JevQNcSbIauJ95hAk
 iyyozibLrThheT7xH06HQdhq370fkjQfUb3hPrlqD92eFUiLcQbzKN+Kw2BAA/dleM99TI
 ctpUjfPURUhDTOajkY7tGnU4kVf+IrU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-PCNSI5nzP7-w5WVX-ihovA-1; Tue, 09 Aug 2022 22:46:33 -0400
X-MC-Unique: PCNSI5nzP7-w5WVX-ihovA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-31f56f635a9so115384877b3.4
 for <ltp@lists.linux.it>; Tue, 09 Aug 2022 19:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=TP54dNuoJWZCvzTBf5b1d8HF5FyZ9a8ryLOYv+CY3Jw=;
 b=voGxwJI32aQMEVH66ClbT81t/CNT4a26mnH5sf2YkHNAWecnTCyahhFf1CXn/cCXAA
 nh9nNxFz64m9GOmfup/rWlHIcKLCeIag73Jts4p5Pzm1+NoeboLO18Zh6TEoT+LDQlk0
 7UMzcltfJvqORDagYKdJtIzdqwOeYzMa9u35uN3VQdxza2bLOrANQl0uwM09slAWDIo2
 FrpHd21LTt6pdgY4VKLiRzw05tqE96+usSYZFYjiwWxOHcaeA6C0trswBaXN6typBxlz
 /ziFACundGLs9YnV3mHgagU5nUTWudGjdnRBs7mD6j2Q0uxEQJtAttZdmaaAREaHN4oT
 LAew==
X-Gm-Message-State: ACgBeo1cwAzYbfB8YjGuZXaa0ZWCzm36PkCo4MsBH1hsDEKJQnERLYOy
 csIM6N4A/GAUy891ZflLreDLMUM51W+kILmlANrXrr24jvYMARrj8kZDk4A2APk81HHsdnvF3Mb
 E2fpv4UD1cF0mMQ6rirnftLyw+ts=
X-Received: by 2002:a81:4892:0:b0:31f:9933:9cb with SMTP id
 v140-20020a814892000000b0031f993309cbmr26792334ywa.86.1660099593415; 
 Tue, 09 Aug 2022 19:46:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7l82D69KHdRwbrBKK8NR6OWMf3Eey/psrukwduDGym/qzd5njG0UKS6KpVpCplekhfiWwsAYbbSODidhe7Jy0=
X-Received: by 2002:a81:4892:0:b0:31f:9933:9cb with SMTP id
 v140-20020a814892000000b0031f993309cbmr26792321ywa.86.1660099593109; Tue, 09
 Aug 2022 19:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-3-pvorel@suse.cz>
 <CAEemH2eZmemcmn1H3Gi6zpvr+a-tAZ38GFuGzXbWPM7uKCw-AQ@mail.gmail.com>
 <YvJNW4okkn2OLK8d@pevik>
In-Reply-To: <YvJNW4okkn2OLK8d@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Aug 2022 10:46:22 +0800
Message-ID: <CAEemH2cTL8-gNnXNw7KvySKLBY8QEdC=+rFvu3jt10ydprehLQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0008779737=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0008779737==
Content-Type: multipart/alternative; boundary="0000000000008a242605e5da0e23"

--0000000000008a242605e5da0e23
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 9, 2022 at 8:04 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Petr,
>
> > On Mon, Aug 8, 2022 at 7:38 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit
> > > code, therefore any && must be turned into || (or if ...; then ..; fi).
> > > Fix hardens tst_res TINFO to be able to be used on scripts with
> errexit.
>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > changes v2->v3:
> > > * really fix it.
>
> > >  testcases/lib/tst_ansi_color.sh | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
>
> > > diff --git a/testcases/lib/tst_ansi_color.sh
> > > b/testcases/lib/tst_ansi_color.sh
> > > index 703df1eb8..517b709d0 100644
> > > --- a/testcases/lib/tst_ansi_color.sh
> > > +++ b/testcases/lib/tst_ansi_color.sh
> > > @@ -24,18 +24,19 @@ tst_flag2color()
>
> > >  tst_color_enabled()
> > >  {
> > > -       [ "$LTP_COLORIZE_OUTPUT" = "n" ] || [ "$LTP_COLORIZE_OUTPUT" =
> "0"
> > > ] && return 0
> > > -       [ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" =
> "1"
> > > ] && return 1
> > > +       [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0"
> ]
> > > || return 1
> > > +       [ "$LTP_COLORIZE_OUTPUT" = "y" -o "$LTP_COLORIZE_OUTPUT" = "1"
> ]
> > > || return 0
>
> > This can work but looks a bit strange to read. I personally think
> > use 'if ...; then ; fi' will be better to understand, because this is a
> > simple function, no need to go with weird logic for over simplifying:).
>
> Hi Li,
>
> sure, I can reuse what I posted to as a suggestion to 3rd patch [1],
> therefore I'll use it for these two:
>
> if [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ]; then
>         return 0
> fi
>
> if [ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1" ];
> then
>


Should be "-o" but not "||", otherwise looks good to me.



>         return 1
> fi
>
> For the latter two I can use 'if ...' as well:
>
> if [ "$color" = 1 ]; then
>         tst_flag2color "$1"
> fi
> printf "$2"
> if [ "$color" = 1 ]; then
>         printf '\033[0m'
> fi
>
> although the original != 1 ] || is IMHO quite readable.
>

Yeah, but I do not insist on all, just comments for content in the
tst_color_enabled() function.


-- 
Regards,
Li Wang

--0000000000008a242605e5da0e23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Aug 9, 2022 at 8:04 PM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">&gt; Hi Petr,<br>
<br>
&gt; On Mon, Aug 8, 2022 at 7:38 PM Petr Vorel &lt;<a href=3D"mailto:pvorel=
@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrote:<br>
<br>
&gt; &gt; set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero =
exit<br>
&gt; &gt; code, therefore any &amp;&amp; must be turned into || (or if ...;=
 then ..; fi).<br>
&gt; &gt; Fix hardens tst_res TINFO to be able to be used on scripts with e=
rrexit.<br>
<br>
&gt; &gt; Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" t=
arget=3D"_blank">pvorel@suse.cz</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; changes v2-&gt;v3:<br>
&gt; &gt; * really fix it.<br>
<br>
&gt; &gt;=C2=A0 testcases/lib/tst_ansi_color.sh | 13 +++++++------<br>
&gt; &gt;=C2=A0 1 file changed, 7 insertions(+), 6 deletions(-)<br>
<br>
&gt; &gt; diff --git a/testcases/lib/tst_ansi_color.sh<br>
&gt; &gt; b/testcases/lib/tst_ansi_color.sh<br>
&gt; &gt; index 703df1eb8..517b709d0 100644<br>
&gt; &gt; --- a/testcases/lib/tst_ansi_color.sh<br>
&gt; &gt; +++ b/testcases/lib/tst_ansi_color.sh<br>
&gt; &gt; @@ -24,18 +24,19 @@ tst_flag2color()<br>
<br>
&gt; &gt;=C2=A0 tst_color_enabled()<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$LTP_COLORIZE_OUTPUT&quot; =
=3D &quot;n&quot; ] || [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;0&quot;=
<br>
&gt; &gt; ] &amp;&amp; return 0<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$LTP_COLORIZE_OUTPUT&quot; =
=3D &quot;y&quot; ] || [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;1&quot;=
<br>
&gt; &gt; ] &amp;&amp; return 1<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$LTP_COLORIZE_OUTPUT&quot; =
=3D &quot;n&quot; -o &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;0&quot; ]<b=
r>
&gt; &gt; || return 1<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$LTP_COLORIZE_OUTPUT&quot; =
=3D &quot;y&quot; -o &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;1&quot; ]<b=
r>
&gt; &gt; || return 0<br>
<br>
&gt; This can work but looks a bit strange to read. I personally think<br>
&gt; use &#39;if ...; then ; fi&#39; will be better to understand, because =
this is a<br>
&gt; simple function, no need to go with weird logic for over simplifying:)=
.<br>
<br>
Hi Li,<br>
<br>
sure, I can reuse what I posted to as a suggestion to 3rd patch [1],<br>
therefore I&#39;ll use it for these two:<br>
<br>
if [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;n&quot; -o &quot;$LTP_COLOR=
IZE_OUTPUT&quot; =3D &quot;0&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0<br>
fi<br>
<br>
if [ &quot;$LTP_COLORIZE_OUTPUT&quot; =3D &quot;y&quot; ] || [ &quot;$LTP_C=
OLORIZE_OUTPUT&quot; =3D &quot;1&quot; ]; then<br></blockquote><div><br></d=
iv><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:smal=
l">Should be &quot;-o&quot; but not &quot;||&quot;, otherwise looks good to=
 me.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
fi<br>
<br>
For the latter two I can use &#39;if ...&#39; as well:<br>
<br>
if [ &quot;$color&quot; =3D 1 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_flag2color &quot;$1&quot;<br>
fi<br>
printf &quot;$2&quot;<br>
if [ &quot;$color&quot; =3D 1 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &#39;\033[0m&#39;<br>
fi<br>
<br>
although the original !=3D 1 ] || is IMHO quite readable.<br></blockquote><=
div><br></div><div class=3D"gmail_default" style=3D"font-size:small">Yeah, =
but I do not insist on all, just comments for content=C2=A0in the tst_color=
_enabled() function.</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail=
_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div><=
/div></div></div>

--0000000000008a242605e5da0e23--


--===============0008779737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0008779737==--

