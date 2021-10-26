Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEFBC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 05:12:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA19860295
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 05:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA19860295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACCC13C6756
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 07:12:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73C643C66AE
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 07:12:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2DF596009D1
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 07:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635225137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkrVoAl0EmNM5UG7QgV1NLV8MLvf0PxOHlIhLAN1hbQ=;
 b=cWPgIXMBw5rOPYjUmOxM5dvxchmmjBxaGRUYn2SMZU87F9W+QlR1HfolsMP4apx/MCoc0X
 deVmCZah9OMqyq9oTISkrBrCgYDdafifdbH90PtNM3QXJu3c4yYRXjACagPhTX3qn5VrbP
 2Kj0CSKJcGihMyu59leat8FgYhz9Kj8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-WpH50Kr7Ocayzd8rvUCZJw-1; Tue, 26 Oct 2021 01:12:15 -0400
X-MC-Unique: WpH50Kr7Ocayzd8rvUCZJw-1
Received: by mail-yb1-f199.google.com with SMTP id
 h40-20020a25b1a8000000b005c16d98634bso5169999ybj.13
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 22:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ASr/zJQWl5J+8vJ8VcBU4huNrN+P9hJ8aSioO99vsSU=;
 b=4w7EX7LZ4kNo7w1P1qOD40QoTop7iS7thlueQdwu5kBsTCU4qiatQeaeS8CRpsudBy
 2MRpiN+uGx1MuF59gTyFNMDicBEmniihwP+/tIeyJiEwh8Sy4IoSxpZ1EygnUkcPtPrW
 bOahV0nuAj3blyULku3ugMiQDxfwWPjLP3mj4wtUJQ8VDne69czfGPKOYBZyK4TmP742
 7a51RZX4a0LNNd3LuBVqRb25iDEk1Rg1yTiCokLwf8XGrJ5c/SJU3vhJ+4iWF1vxEhwS
 8bLRMU0eMFx+ssxxLvGDmBKr014wPReCFInVSbQb5VHMFUbn7gqRyEGIVvuxkUj7myLa
 wpnQ==
X-Gm-Message-State: AOAM532IeQ8rRB8iR+aOEeKmL6qnqi07+YeytEqFZikrYR/KAqFofKYP
 DjWwwmR4her6chAcAYAUojT5heHG7O08h7QHzRT5izY5UyWHQMyPWRSoE4yCKIbnSFaCWO7N2R6
 bXixLLfFpzmjcd2aGjEQz98vAqLU=
X-Received: by 2002:a25:d7d5:: with SMTP id
 o204mr16334561ybg.186.1635225135145; 
 Mon, 25 Oct 2021 22:12:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlioZ5jot8d7rLRty9VmVyzSfoVYWTwq7PpjzyseitiSZk1fSXWG1iGY3RsOwj9wd9RgQyhZcHiKjdVAte/so=
X-Received: by 2002:a25:d7d5:: with SMTP id
 o204mr16334537ybg.186.1635225134861; 
 Mon, 25 Oct 2021 22:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211026034241.1605-1-tangmeng@uniontech.com>
In-Reply-To: <20211026034241.1605-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Oct 2021 13:12:02 +0800
Message-ID: <CAEemH2d6nSt5qVBuotpB3pbGdEmQzT2d84HUaS80DgKw7jF8cQ@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] link/link02: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============2036649635=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2036649635==
Content-Type: multipart/alternative; boundary="0000000000004aa32f05cf3a8555"

--0000000000004aa32f05cf3a8555
Content-Type: text/plain; charset="UTF-8"

Hi Meng,


> --- a/testcases/kernel/syscalls/link/link02.c
> +++ b/testcases/kernel/syscalls/link/link02.c
> @@ -34,23 +34,14 @@
>   */
>

For the Copyright & Licence we should respect the original
author and use SPDX format.  Something like this:

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
 *  AUTHOR : William Roske
 *  CO-PILOT : Dave Fenner
 * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
 */



> -int main(int ac, char **av)
> -{
> -       int lc;
> +       TST_EXP_PASS(link(OLDPATH, NEWPATH));
>
> -       tst_parse_opts(ac, av, NULL, NULL);
> +       if (!TST_PASS)
> +               return;
>
> -       setup();
> +       SAFE_STAT(OLDPATH, &fbuf);
> +       SAFE_STAT(NEWPATH, &lbuf);
>
> -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> -               tst_count = 0;
> -               verify_link();
> +       if (fbuf.st_nlink > 1 && fbuf.st_nlink == lbuf.st_nlink) {
> +               tst_res(TPASS, "link("OLDPATH","NEWPATH") "
> +                                 "returned 0 and stat link counts match");
> +       } else {
> +               tst_res(TFAIL, "link("OLDPATH","NEWPATH") returned 0"
> +                                 " but stat link counts do not match %d
> %d",
> +                                 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
>         }
>

As I mentioned we have to do unlink() here otherwise
test can not run pass with -i option.

        SAFE_UNLINK(NEWPATH);


> +static struct tst_test test = {
> +    .test_all = verify_link,
> +    .setup = setup,
> +    .needs_tmpdir = 1,
>

I'd suggest using tab instead of space to make
code indent.

-- 
Regards,
Li Wang

--0000000000004aa32f05cf3a8555
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Meng,</div></div><div class=3D"gmail_quote"><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
--- a/testcases/kernel/syscalls/link/link02.c<br>
+++ b/testcases/kernel/syscalls/link/link02.c<br>
@@ -34,23 +34,14 @@<br>
=C2=A0 */<br></blockquote><div><br></div><div><div class=3D"gmail_default" =
style=3D"font-size:small">For the Copyright &amp; Licence=C2=A0we should re=
spect the original</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">author and use SPDX format.=C2=A0 Something like this:</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">// SPDX-License-Identifier: GPL-2.0-or-l=
ater<br>/*<br>=C2=A0* Copyright (c) 2000 Silicon Graphics, Inc.=C2=A0 All R=
ights Reserved.<br>=C2=A0* =C2=A0AUTHOR=09=09: William Roske<br>=C2=A0* =C2=
=A0CO-PILOT=09=09: Dave Fenner<br>=C2=A0* Copyright (c) 2014 Cyril Hrubis &=
lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt;<br>=C2=A0*/<b=
r></div></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
-int main(int ac, char **av)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int lc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_PASS(link(OLDPATH, NEWPATH));<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_parse_opts(ac, av, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!TST_PASS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0setup();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_STAT(OLDPATH, &amp;fbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_STAT(NEWPATH, &amp;lbuf);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (lc =3D 0; TEST_LOOPING(lc); lc++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_count =3D 0;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verify_link();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fbuf.st_nlink &gt; 1 &amp;&amp; fbuf.st_nli=
nk =3D=3D lbuf.st_nlink) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TPASS, &quo=
t;link(&quot;OLDPATH&quot;,&quot;NEWPATH&quot;) &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;returned 0 and stat link=
 counts match&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL, &quo=
t;link(&quot;OLDPATH&quot;,&quot;NEWPATH&quot;) returned 0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; but stat link counts do=
 not match %d %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int)fbuf.st_nlink, (int)lbuf.=
st_nlink);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">As I mentioned we have to do unlin=
k() here otherwise</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">test can not run pass with -i option.</div><div class=3D"gmail_default"=
 style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"=
font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_UNLINK(NEWPATH);<br></div=
><div class=3D"gmail_default" style=3D"font-size:small"></div><div class=3D=
"gmail_default" style=3D"font-size:small">=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 .test_all =3D verify_link,<br>
+=C2=A0 =C2=A0 .setup =3D setup,<br>
+=C2=A0 =C2=A0 .needs_tmpdir =3D 1,<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">I&#39;d suggest=C2=A0us=
ing tab instead of space to make</div><div class=3D"gmail_default" style=3D=
"font-size:small">code indent.</div></div></div><div><br></div>-- <br><div =
dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></d=
iv><div>Li Wang<br></div></div></div></div>

--0000000000004aa32f05cf3a8555--


--===============2036649635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2036649635==--

