Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2CCC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 04:46:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 225CA3CA926
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 06:46:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0CA93CA4A0
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 06:46:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0E1C41A00CD0
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 06:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657773991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3it1UETEJ035ZwEtXLijYc3DsbvCbZB2wZ+9i8gYnI=;
 b=Ts2pa7rwlA/oik+GAWf9YLFpinLeauIbne5N+6UpBY/7YP2L3F5RkRLoVbpzqiG9tlp1g5
 fp/Ah+J5DPYvP3EXvaoS6lfjeRS+TUH+heWLDgmMTSFVut1h+K0QERqK237ESMwWgTF6S3
 okuP9TaHnocv/LNUJha3zTvmr3iUbig=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-k18vRZLxPB6glu9g9lh7bQ-1; Thu, 14 Jul 2022 00:46:29 -0400
X-MC-Unique: k18vRZLxPB6glu9g9lh7bQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 g12-20020a05690203cc00b0066e232409c9so643205ybs.22
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 21:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a3it1UETEJ035ZwEtXLijYc3DsbvCbZB2wZ+9i8gYnI=;
 b=Tvz5ZmouNNh6OMDJO1I7KAe1QXa9wMW8ogV4KISpFzRnE+YsFldlGHghWM9zAS+ZL0
 WUVTcrYcoXRl+JtxuaEawOin32tAi9T/NLfJeMLZBVwa+zDh29kKrmqD0Vp3YlTQ63pc
 gtrZPEIzXbfP8rfLgTqBOThuGVZPrZ/8/z5hbyI46076TrFsN07P2vptOX/uijcVoymQ
 np+aIDYb/gD6nkxeBveOkw0dW3gvarcYTBbg/TTTDLqhBp7COcAhCkXJ2kBe+aLQlyJs
 XW1eBTRnSNQpiGh+Z3xxNzY9dUzJ/stpB3JUvd0yihSyZzL5Gn4mfCBsZBCTrrXqkNck
 gWiw==
X-Gm-Message-State: AJIora/A43b/y1bKgna/L2z77Wi8HB4HyOW61KYg6Ljujaw5b3Gd7Ofw
 LsGwu/sCDxxE3LDhp/HkAfWCkNR7Wm7hY3DFi0sxv8WbS0zuxfsbAL035GzNIPO14oKndY/oy6D
 HiEiUGxooFF5bkqRco3gdoFqS40k=
X-Received: by 2002:a25:25d7:0:b0:66e:ce4d:da48 with SMTP id
 l206-20020a2525d7000000b0066ece4dda48mr6813528ybl.301.1657773988418; 
 Wed, 13 Jul 2022 21:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJW0xBV9H6JmTGFX29RCEKCZ8vnhg3FPukyfmh0ArPCknxYdh4P39xlmmXf+ZoyQXSGYu/wHIHNLZ7w7Vx/MA=
X-Received: by 2002:a25:25d7:0:b0:66e:ce4d:da48 with SMTP id
 l206-20020a2525d7000000b0066ece4dda48mr6813521ybl.301.1657773988232; Wed, 13
 Jul 2022 21:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220712124617.23139-1-rpalethorpe@suse.com>
 <20220712124617.23139-2-rpalethorpe@suse.com>
In-Reply-To: <20220712124617.23139-2-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Jul 2022 12:46:17 +0800
Message-ID: <CAEemH2e1otstDaZS_ofGPa-fy-f2Bzp0xUpOPeE=9tY8jjEcZw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] read_all: Fix type warnings
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
Content-Type: multipart/mixed; boundary="===============0754869306=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0754869306==
Content-Type: multipart/alternative; boundary="000000000000afd7f005e3bc9544"

--000000000000afd7f005e3bc9544
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 12, 2022 at 8:46 PM Richard Palethorpe via ltp <
ltp@lists.linux.it> wrote:

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>  testcases/kernel/fs/read_all/read_all.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/fs/read_all/read_all.c
> b/testcases/kernel/fs/read_all/read_all.c
> index d8c68bd33..813991f2c 100644
> --- a/testcases/kernel/fs/read_all/read_all.c
> +++ b/testcases/kernel/fs/read_all/read_all.c
> @@ -168,7 +168,7 @@ static void sanitize_str(char *buf, ssize_t count)
>  {
>         int i;
>
> -       for (i = 0; i < MIN(count, MAX_DISPLAY); i++)
> +       for (i = 0; i < MIN(count, (ssize_t)MAX_DISPLAY); i++)
>                 if (!isprint(buf[i]))
>                         buf[i] = ' ';
>
> @@ -439,7 +439,7 @@ static void setup(void)
>                 tst_brk(TBROK, "The directory argument (-d) is required");
>
>         if (!worker_count)
> -               worker_count = MIN(MAX(tst_ncpus() - 1, 1), max_workers);
> +               worker_count = MIN(MAX(tst_ncpus() - 1, 1L), max_workers);
>         workers = SAFE_MALLOC(worker_count * sizeof(*workers));
>
>         if (tst_parse_int(str_worker_timeout, &worker_timeout, 1,
> INT_MAX)) {
> --
> 2.36.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000afd7f005e3bc9544
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Jul 12, 2022 at 8:46 PM Richard Palethorpe =
via ltp &lt;<a href=3D"mailto:ltp@lists.linux.it">ltp@lists.linux.it</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-=
off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.com" targ=
et=3D"_blank">rpalethorpe@suse.com</a>&gt;<br></blockquote><div>=C2=A0</div=
><div><span class=3D"gmail_default" style=3D"font-size:small"></span>Review=
ed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">l=
iwang@redhat.com</a>&gt;</div><div><span class=3D"gmail_default"></span>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0testcases/kernel/fs/read_all/read_all.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/=
read_all/read_all.c<br>
index d8c68bd33..813991f2c 100644<br>
--- a/testcases/kernel/fs/read_all/read_all.c<br>
+++ b/testcases/kernel/fs/read_all/read_all.c<br>
@@ -168,7 +168,7 @@ static void sanitize_str(char *buf, ssize_t count)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; MIN(count, MAX_DISPLAY); i=
++)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; MIN(count, (ssize_t)MAX_DI=
SPLAY); i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!isprint(buf[i]=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 buf[i] =3D &#39; &#39;;<br>
<br>
@@ -439,7 +439,7 @@ static void setup(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK, &quo=
t;The directory argument (-d) is required&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!worker_count)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worker_count =3D MI=
N(MAX(tst_ncpus() - 1, 1), max_workers);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worker_count =3D MI=
N(MAX(tst_ncpus() - 1, 1L), max_workers);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 workers =3D SAFE_MALLOC(worker_count * sizeof(*=
workers));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tst_parse_int(str_worker_timeout, &amp;work=
er_timeout, 1, INT_MAX)) {<br>
-- <br>
2.36.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000afd7f005e3bc9544--


--===============0754869306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0754869306==--

