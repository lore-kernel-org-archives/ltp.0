Return-Path: <SRS0=YkbW=OY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE39C433EF
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 10:16:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32B260F38
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 10:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B32B260F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B49913C9FD7
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 12:16:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1322A3C2C30
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 12:16:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E3F1C1000961
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 12:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633342601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awNDeoGTfyo11L97wRfeBMwr+813VQhO6XWOi377IO0=;
 b=it7Rtbm7dm9Siz5EMPWrzhZIsIRA14hvj9HnqJM8ridyjBguW3MAjPF67DTkqNwNQOm90Z
 UBY1qkK9vUPUlxcviAzBU6OWrA5IzO7LcY2IWKIsmiDST4VpERVZOJPKNCbkeFsC3AU4e6
 XLagwVH4I2Xdm0qcZJXU2PcKP2DJuSI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-I5_0faNOM8uRFDdskdr3zg-1; Mon, 04 Oct 2021 06:16:38 -0400
X-MC-Unique: I5_0faNOM8uRFDdskdr3zg-1
Received: by mail-oo1-f72.google.com with SMTP id
 i14-20020a4a928e000000b0029acf18dcffso4451221ooh.11
 for <ltp@lists.linux.it>; Mon, 04 Oct 2021 03:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=awNDeoGTfyo11L97wRfeBMwr+813VQhO6XWOi377IO0=;
 b=hMr/UOfX8RnNPVbsVnAvgt51GnNKWENLAKtX7cOZn6ZkLvOx/RMuNzVZJ5yo/do7WP
 XwNg3lopQoGKX12d8VnkIQY4PznMjGY77VvGIdAIXhLyMhaut26rhwg++LTVi8VyMpzl
 uNMYEHypa8nXi+dKpvlSfKoD0qLHMlViHgoHjSln1+4re/hsAnqQiVBZqNZlZLqZwcOw
 4HgxH2SsiWlUiuIx7G1rxWuNqVVJxisW+R1RUfBr3vKjdNrfKdLmG8UZvFKFaPdenc0Z
 qZ2c5bTOl16JPihzVT8I/S9iZkyyKn5F2dffbWa+lPsjyQHnVl04Dj1bq9xUQ7NUg/NG
 1eiw==
X-Gm-Message-State: AOAM533uR/WDQnOZc5DkDS8WSEJicHSiGDMpZJn9iCWwaFO9O/8v4uVP
 Yk9fYkmqTuOnpwrWhXtz22/TT+CUc/fUV7WrrrQxuTyzritQ4wAvC26p8fKHNwbCGgjJcLbe81D
 RHKuw7uMHgw887l8gQSVOZGNOmr4=
X-Received: by 2002:a05:6808:3a7:: with SMTP id
 n7mr12904199oie.45.1633342597620; 
 Mon, 04 Oct 2021 03:16:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAW1d7VxL7CMaPIpTSEGq5PYemjvyLFYerO3772HtrwRLBlZyW+/XatsC3kZNOa8r+Vt6/zn6pDcnA2WgR6P0=
X-Received: by 2002:a05:6808:3a7:: with SMTP id
 n7mr12904183oie.45.1633342597361; 
 Mon, 04 Oct 2021 03:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210929085910.23073-1-rpalethorpe@suse.com>
 <YVqaH2wxGRegEfiR@pevik>
In-Reply-To: <YVqaH2wxGRegEfiR@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Oct 2021 12:16:21 +0200
Message-ID: <CAASaF6wtsAFJY8pkKdUSycFcaCQySL+xXLeUg8RrTRvxDdShLw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] clock_nanosleep01: Avoid dereferencing bad
 pointers in libc on 32bit
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0573205683=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0573205683==
Content-Type: multipart/alternative; boundary="00000000000050048305cd84350a"

--00000000000050048305cd84350a
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 4, 2021 at 8:07 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Richie,
>
> > In 32-bit (regardless of kernel bits) glibc and musl will usually
> > dereference the timespec pointers and try to read them. In some cases
> > this might be avoidable, but they must do it in others.
>
> > Passing invalid pointers is undefined in POSIX. In any case, AFAICT
> > libc would have to catch the signal in order to guarantee EFAULT is
> > returned.
>
> LGTM.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> > Possibly we shouldn't test things like this at all through libc
> > wrappers.
> Only for 32bit or also for 64 bit? Anyway, there has always been some cases
> where bad addr testing was problematic (e.g. non-intel arch).
>

I'd skip it for both, I recall that some implementations
were crashing.

Acked-by: Jan Stancek <jstancek@redhat.com>


>
> Kind regards,
> Petr
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

--00000000000050048305cd84350a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Oct 4, 2021 at 8:07 AM Petr Vorel &lt=
;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Richie,<br>
<br>
&gt; In 32-bit (regardless of kernel bits) glibc and musl will usually<br>
&gt; dereference the timespec pointers and try to read them. In some cases<=
br>
&gt; this might be avoidable, but they must do it in others.<br>
<br>
&gt; Passing invalid pointers is undefined in POSIX. In any case, AFAICT<br=
>
&gt; libc would have to catch the signal in order to guarantee EFAULT is<br=
>
&gt; returned.<br>
<br>
LGTM.<br>
<br>
Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt;<br>
<br>
&gt; Possibly we shouldn&#39;t test things like this at all through libc<br=
>
&gt; wrappers.<br>
Only for 32bit or also for 64 bit? Anyway, there has always been some cases=
<br>
where bad addr testing was problematic (e.g. non-intel arch).<br></blockquo=
te><div><br></div><div><div style=3D"font-family:monospace" class=3D"gmail_=
default">I&#39;d skip it for both, I recall that some implementations</div>=
<div style=3D"font-family:monospace" class=3D"gmail_default">were crashing.=
<br></div></div><div><br></div><div>Acked-by: Jan Stancek &lt;<a href=3D"ma=
ilto:jstancek@redhat.com">jstancek@redhat.com</a>&gt;</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Kind regards,<br>
Petr<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div></div>

--00000000000050048305cd84350a--


--===============0573205683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0573205683==--

