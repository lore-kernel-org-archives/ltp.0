Return-Path: <SRS0=z5ZV=N2=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF3C433F5
	for <ltp@archiver.kernel.org>; Sat,  4 Sep 2021 02:40:24 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208E960FE6
	for <ltp@archiver.kernel.org>; Sat,  4 Sep 2021 02:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 208E960FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD8D83C98E1
	for <ltp@archiver.kernel.org>; Sat,  4 Sep 2021 04:40:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B3B93C2831
 for <ltp@lists.linux.it>; Sat,  4 Sep 2021 04:40:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF9D21A01759
 for <ltp@lists.linux.it>; Sat,  4 Sep 2021 04:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630723208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jjv/uwwvuRPr7UdVj08Zmbk1Ihb0gO8p3gz0lzjv6vs=;
 b=aA5cVhyglq22muXdCbuZ+rh6wm1vikYyuz4rtoUkZTPFFyJ0dQwlUJ6csWgp7fmiR0o5CY
 EPDQY9hHUNHo3LQ3d9Cx4Sqm+zLXc3QCt1ZxQuV29iEL+CKD0gmbYg/+Rcv/y/z+Y9gKJb
 OGXufmyah1OX1PhwHPLkRcSDsXs1gng=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-KKHtQHbyNoKuhK8I3Cdaew-1; Fri, 03 Sep 2021 22:40:04 -0400
X-MC-Unique: KKHtQHbyNoKuhK8I3Cdaew-1
Received: by mail-yb1-f197.google.com with SMTP id
 a62-20020a254d410000b0290592f360b0ccso1233139ybb.14
 for <ltp@lists.linux.it>; Fri, 03 Sep 2021 19:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jjv/uwwvuRPr7UdVj08Zmbk1Ihb0gO8p3gz0lzjv6vs=;
 b=SwXbtkGn6ANaEr+2oB9W/Wv+pq8P6wptiH5dcwc3dmffV0uIEM+RYR7hMcsLMV0gFy
 Etnou8xPYmIDRtZ+2bE3ee7+5nhvndqubVVOkVVFkbri0D+IJlLl53mty+f1acn4vnIj
 GFuUKUAt9w9VYtMLsTduSvkhan/Vnx9xmfA8cNgd1yEZK1PpvM3+Tid4std3eW2HYYgo
 OGHOTQQ8jM7vEROURkKyIc5cUWm2Keh6eicH/wtgwjFDmZ8GWXznMOVF6iaRxSfx4/jX
 S7IcpUvpOmiN++f6smBdx0fxsvw2sZ6ABfeESfPkz8T/ti0mv2RxpwXVsNiR/G9uUdGS
 x9Uw==
X-Gm-Message-State: AOAM530nXyLdhxEsfuDf1j3CyemO7YiyC+8WLhPvznYKrwGFnOdMOLda
 4NyD2eDLSd4lINTIQyl08Hf+Uo/1OmlYToCrVJ9XS/8qGs4KgJe5+XI9hFqNcP6xO/Nxj8DH2Vo
 44rJJymtQoU+slVInVNXn5aMdZEc=
X-Received: by 2002:a25:6902:: with SMTP id e2mr2840179ybc.526.1630723203734; 
 Fri, 03 Sep 2021 19:40:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFWlsyzHYtPsHseBB9zaps5vGDgERB7Pz3O7J5e+BEznOHu/7BwCnY7UZnHQTCdCye8fopjLN/d4bs7xiROFE=
X-Received: by 2002:a25:6902:: with SMTP id e2mr2840158ybc.526.1630723203405; 
 Fri, 03 Sep 2021 19:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210903214811.61727-1-petr.vorel@gmail.com>
In-Reply-To: <20210903214811.61727-1-petr.vorel@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 4 Sep 2021 10:39:50 +0800
Message-ID: <CAEemH2cMAMK5pi_mY7PPLaZun71Nv6JYyyQBSJePXaPyPgxKVg@mail.gmail.com>
To: Petr Vorel <petr.vorel@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/2] sched/process.c: Always use pointer to
 stderr
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
Content-Type: multipart/mixed; boundary="===============1244672071=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210904023950.sdOl8V9j5px1aeacOcwX0kDLM5FsgNWlWu7epSR_OKk@z>

--===============1244672071==
Content-Type: multipart/alternative; boundary="000000000000442bd405cb22555a"

--000000000000442bd405cb22555a
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 4, 2021 at 5:48 AM Petr Vorel <petr.vorel@gmail.com> wrote:

> which was previously used for non-linux OS (not relevant to LTP thus not
> used in LTP), for linux stderr directly was used.
>
> This fixes compilation on MUSL which does not like assignment to stderr:
>
> process.c:553:14: error: assignment of read-only variable 'stderr'
>   553 |      debugfp = fopen(foo, "a+");
>       |              ^
>
> NOTE: needed to initialization in main(), because C standard does not
> require stdin, stdout and stderr to be constants (at least not C99),
> otherwise it fails to compile:
>
> process.c:144:15: error: initializer element is not constant
>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Hi,
>
> not really sure why anything needs to be assigned to stderr and whether
> this is a correct approach. Comments are welcome.
>

Hmm, I guess that the original purpose is to redirect stderr to
another destination. But it made a mistake which assigns new
FILE stream to stderr, AFAIK, we should not do like that.
A recomened way is:
    FILE *debugfp = freopen(foo, "w", stderr );

Or, it just wants to make compatible but forget that definition in use then.


Anyway, your fix looks good.
Reviewed-by: Li Wang <liwang@redhat.com>



>
> Kind regards,
> Petr
>
>  testcases/kernel/sched/process_stress/process.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/sched/process_stress/process.c
> b/testcases/kernel/sched/process_stress/process.c
> index a5ff80987..11837c3cb 100644
> --- a/testcases/kernel/sched/process_stress/process.c
> +++ b/testcases/kernel/sched/process_stress/process.c
> @@ -141,13 +141,8 @@ timer_t timer;                     /* timer structure
> */
>
>  Pinfo *shmaddr;                        /* Start address  of shared memory
> */
>
> -#ifndef _LINUX
> -FILE *errfp = stderr;          /* error file pointer, probably not
> necessary */
> -FILE *debugfp = stderr;                /* debug file pointer, used if
> AUSDEBUG set */
> -#else
> -#define errfp stderr
> -#define debugfp stderr
> -#endif
> +FILE *errfp;
> +FILE *debugfp;
>
>  struct envstruct *edat = envdata;      /* pointer to environment data */
>
> @@ -1221,6 +1216,9 @@ void doit(void)
>  /* main */
>  int main(int argc, char *argv[])
>  {
> +       errfp = stderr;
> +       debugfp = stderr;
> +
>         extern Pinfo *shmaddr;  /* start address of shared memory */
>
>         prtln();
> --
> 2.33.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000442bd405cb22555a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sat, Sep 4, 2021 at 5:48 AM Petr Vorel &lt;<a hr=
ef=3D"mailto:petr.vorel@gmail.com" target=3D"_blank">petr.vorel@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">wh=
ich was previously used for non-linux OS (not relevant to LTP thus not<br>
used in LTP), for linux stderr directly was used.<br>
<br>
This fixes compilation on MUSL which does not like assignment to stderr:<br=
>
<br>
process.c:553:14: error: assignment of read-only variable &#39;stderr&#39;<=
br>
=C2=A0 553 |=C2=A0 =C2=A0 =C2=A0 debugfp =3D fopen(foo, &quot;a+&quot;);<br=
>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br=
>
<br>
NOTE: needed to initialization in main(), because C standard does not<br>
require stdin, stdout and stderr to be constants (at least not C99),<br>
otherwise it fails to compile:<br>
<br>
process.c:144:15: error: initializer element is not constant<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:petr.vorel@gmail.com" targe=
t=3D"_blank">petr.vorel@gmail.com</a>&gt;<br>
---<br>
Hi,<br>
<br>
not really sure why anything needs to be assigned to stderr and whether<br>
this is a correct approach. Comments are welcome.<br></blockquote><div><br>=
</div><div><div class=3D"gmail_default" style=3D"font-size:small">Hmm, I gu=
ess that the original purpose is to redirect stderr to</div><div class=3D"g=
mail_default" style=3D"font-size:small">another destination. But it made a =
mistake which=C2=A0assigns new</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">FILE stream to stderr, AFAIK, we should not do like that.</=
div><div class=3D"gmail_default" style=3D"font-size:small">A recomened way =
is:</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=
=A0 FILE *<span class=3D"gmail_default">debugfp</span>=C2=A0=3D freopen(<sp=
an class=3D"gmail_default">foo</span>, &quot;w&quot;, stderr );<br></div></=
div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">Or, it just wants to make =
compatible but forget that definition in use then.</div><div><br></div><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Anyw=
ay,=C2=A0your fix looks good.</div><div class=3D"gmail_default" style=3D"fo=
nt-size:small"></div><div class=3D"gmail_default" style=3D"font-size:small"=
>Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_b=
lank">liwang@redhat.com</a>&gt;</div><br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
Kind regards,<br>
Petr<br>
<br>
=C2=A0testcases/kernel/sched/process_stress/process.c | 12 +++++-------<br>
=C2=A01 file changed, 5 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/ke=
rnel/sched/process_stress/process.c<br>
index a5ff80987..11837c3cb 100644<br>
--- a/testcases/kernel/sched/process_stress/process.c<br>
+++ b/testcases/kernel/sched/process_stress/process.c<br>
@@ -141,13 +141,8 @@ timer_t timer;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* timer structure */<br>
<br>
=C2=A0Pinfo *shmaddr;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Start address=C2=A0 of shared memory */<=
br>
<br>
-#ifndef _LINUX<br>
-FILE *errfp =3D stderr;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* error file po=
inter, probably not necessary */<br>
-FILE *debugfp =3D stderr;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* debug file pointer, used if AUSDEBUG set */<br>
-#else<br>
-#define errfp stderr<br>
-#define debugfp stderr<br>
-#endif<br>
+FILE *errfp;<br>
+FILE *debugfp;<br>
<br>
=C2=A0struct envstruct *edat =3D envdata;=C2=A0 =C2=A0 =C2=A0 /* pointer to=
 environment data */<br>
<br>
@@ -1221,6 +1216,9 @@ void doit(void)<br>
=C2=A0/* main */<br>
=C2=A0int main(int argc, char *argv[])<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0errfp =3D stderr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0debugfp =3D stderr;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 extern Pinfo *shmaddr;=C2=A0 /* start address o=
f shared memory */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 prtln();<br>
-- <br>
2.33.0<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000442bd405cb22555a--


--===============1244672071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1244672071==--

