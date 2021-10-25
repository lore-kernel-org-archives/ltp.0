Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15694C433F5
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:30:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD784604AC
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD784604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C34E23C65D2
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 10:30:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C9E73C63A2
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:30:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AE9D7200DE7
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635150623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TiX1XnQwYpeTCxg1qseukryyCK4WESQug3HF/M/y9CQ=;
 b=gHLAWM6OGk64r9nHBaOtKN2kDViser8oTq1noNDW25dLgUyPOfylh5da5r0Sjkk95SNrb/
 UJC858mfwepf+R/gzbOEAQgD6dvpWYs65GLgf8CwhqYfwHS11WzJ+yGHaj+oSOJtkOF5ln
 haPwHqy/RA5ZRiqTzEz/GHgNx06w1y0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-wUCXY-7ZNrW2ZMMD1L4P-Q-1; Mon, 25 Oct 2021 04:30:21 -0400
X-MC-Unique: wUCXY-7ZNrW2ZMMD1L4P-Q-1
Received: by mail-yb1-f198.google.com with SMTP id
 r67-20020a252b46000000b005bea12c4befso16139483ybr.19
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 01:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TiX1XnQwYpeTCxg1qseukryyCK4WESQug3HF/M/y9CQ=;
 b=K/eOhPkk7OtJC2DMo2SW6JC5apg7rMpCOHFlU6C1upDmDXDLJqL2A3FyGX+P3NPqHJ
 AFlu58/GSf2MItF641GoD3vJaV1WFtFBiCVZl7nbjscrlc4rWjWbLCPnNpO7PWuRT+Su
 OdS/V5DqZGfGy/2486QyE+fkqVuBhsGcOWyIxfwVWUbSh6Z5WEv+oJKmCTY7jdgZ4bBA
 GL8vaMfICo0H/SLpuV2TD/CersF6NLaWZeA2mFlhFqXVnH0m1ZuLrNJhk3paJWaI6kgL
 3/wIUcRrGWWRkfbFPv7D4NwpNOs7MfT5cw+ewLyyUFsxI9Ia8WQor09N+6CPGv4gV6+x
 afew==
X-Gm-Message-State: AOAM532+h3ScbPKtULL3QmCytDGwmCohpul5aiiAkmZR3ay+bz/fFcIn
 CLDBdLm7btwwKgTtsq1L+6GXkAJXlxZ9EeGYmG/AMQ4WJje/P1uCYiVrrvlKx+d4/hG9ZiDvUc8
 d9zTV/DrS5/2gtGamlw4cRlfgZvc=
X-Received: by 2002:a25:cc02:: with SMTP id l2mr6345996ybf.425.1635150620985; 
 Mon, 25 Oct 2021 01:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJHWVeDU0Lw4T0jFdcN2hPYd3TEQh0i4M1q8Q45o8ExVcOah3vkWzM97Dykhyyx7eux7MXtv1j1HAScdRq7Xc=
X-Received: by 2002:a25:cc02:: with SMTP id l2mr6345965ybf.425.1635150620710; 
 Mon, 25 Oct 2021 01:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211022043806.19171-1-tangmeng@uniontech.com>
In-Reply-To: <20211022043806.19171-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Oct 2021 16:30:08 +0800
Message-ID: <CAEemH2dsSesL+P3YiK-i-3FGoxsZfr4GGy30QLbesjHCR+dn=A@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] link/link02: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1755197967=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1755197967==
Content-Type: multipart/alternative; boundary="000000000000e6f1c405cf292bd0"

--000000000000e6f1c405cf292bd0
Content-Type: text/plain; charset="UTF-8"

Hi Meng,


> -static void verify_link(void)
> +static void verify_link02(void)
>  {
>         struct stat fbuf, lbuf;
>
>         TEST(link(OLDPATH, NEWPATH));
>
> -       if (TEST_RETURN == 0) {
> -               SAFE_STAT(cleanup, OLDPATH, &fbuf);
> -               SAFE_STAT(cleanup, NEWPATH, &lbuf);
> +       if (TST_RET == 0) {
> +               SAFE_STAT(OLDPATH, &fbuf);
> +               SAFE_STAT(NEWPATH, &lbuf);
>                 if (fbuf.st_nlink > 1 && lbuf.st_nlink > 1 &&
>                     fbuf.st_nlink == lbuf.st_nlink) {
> -                       tst_resm(TPASS, "link("OLDPATH","NEWPATH") "
> +                       tst_res(TPASS, "link("OLDPATH","NEWPATH") "
>                                  "returned 0 and link counts match");
>                 } else {
> -                       tst_resm(TFAIL, "link("OLDPATH","NEWPATH")
> returned 0"
> +                       tst_res(TFAIL, "link("OLDPATH","NEWPATH") returned
> 0"
>                                  " but stat lin count do not match %d %d",
>                                  (int)fbuf.st_nlink, (int)lbuf.st_nlink);
>                 }
> -               SAFE_UNLINK(cleanup, NEWPATH);
>         } else {
> -               tst_resm(TFAIL | TTERRNO,
> +               tst_res(TFAIL | TTERRNO,
>                          "link("OLDPATH","NEWPATH") returned %ld",
> -                        TEST_RETURN);
> -       }
>

Generally looks good, but I personally hope to decrease the
layers of brace nesting by reordering the if-conditions.

Something logic like this maybe better:

        TEST(link(OLDPATH, NEWPATH));
        if (TST_RET == -1) {
                ...
        }

        SAFE_STAT(OLDPATH, &fbuf);
        SAFE_STAT(NEWPATH, &lbuf);

        if (fbuf.st_nlink > 1 && fbuf.st_nlink == lbuf.st_nlink) {
                ...
        } else {
               ...
        }



> -}
> -
> -int main(int ac, char **av)
> -{
> -       int lc;
> -
> -       tst_parse_opts(ac, av, NULL, NULL);
> -
> -       setup();
> -
> -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> -               tst_count = 0;
> -               verify_link();
> +                        TST_RET);
>         }
> -
> -       cleanup();
> -       tst_exit();
>  }
>
>  static void setup(void)
>  {
> -       tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -       TEST_PAUSE;
> -
> -       tst_tmpdir();
> -
> -       SAFE_TOUCH(cleanup, OLDPATH, 0700, NULL);
> +       SAFE_TOUCH(OLDPATH, 0700, NULL);
>  }
>
>  static void cleanup(void)
>  {
> -       tst_rmdir();
> +    SAFE_UNLINK(NEWPATH);
>

I'd suggest moving this unlink() to verify_link02 to make test
options '-i N' happy.

Otherwise:

# ./link02 -i 2
tst_test.c:1365: TINFO: Timeout per run is 0h 05m 00s
link02.c:31: TPASS: link(oldpath,newpath) returned 0 and link counts match
link02.c:40: TFAIL: link(oldpath,newpath) returned -1: EEXIST (17)

 }
> +
> +static struct tst_test test = {
> +    .test_all = verify_link02,
> +    .setup = setup,
> +    .cleanup = cleanup,
> +    .needs_tmpdir = 1,
> +};
> --
> 2.20.1
>
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000e6f1c405cf292bd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Hi Meng,</div></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
-static void verify_link(void)<br>
+static void verify_link02(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stat fbuf, lbuf;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST(link(OLDPATH, NEWPATH));<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (TEST_RETURN =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_STAT(cleanup, =
OLDPATH, &amp;fbuf);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_STAT(cleanup, =
NEWPATH, &amp;lbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (TST_RET =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_STAT(OLDPATH, =
&amp;fbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_STAT(NEWPATH, =
&amp;lbuf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fbuf.st_nlink &=
gt; 1 &amp;&amp; lbuf.st_nlink &gt; 1 &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fbuf.=
st_nlink =3D=3D lbuf.st_nlink) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_resm(TPASS, &quot;link(&quot;OLDPATH&quot;,&quot;NEWPATH&quot=
;) &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TPASS, &quot;link(&quot;OLDPATH&quot;,&quot;NEWPATH&quot;=
) &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;returned 0 and link coun=
ts match&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_resm(TFAIL, &quot;link(&quot;OLDPATH&quot;,&quot;NEWPATH&quot=
;) returned 0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TFAIL, &quot;link(&quot;OLDPATH&quot;,&quot;NEWPATH&quot;=
) returned 0&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; but stat lin count do n=
ot match %d %d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int)fbuf.st_nlink, (int)lbuf.=
st_nlink);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_UNLINK(cleanup=
, NEWPATH);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TFAIL | TT=
ERRNO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL | TTE=
RRNO,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;link(&quot;OLDPATH&quot;,&quot;NEWPATH&quot;) return=
ed %ld&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 TEST_RETURN);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Generally looks good, but I p=
ersonally hope to decrease the</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">layers of brace nesting by reordering the if-conditions.</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Something logic like this m=
aybe better:</div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TEST(link(OLDPATH, NEWPATH));<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (TST_RET =3D=3D -1) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ...<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SAFE_STAT(OLDPATH, &amp;fbuf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SA=
FE_STAT(NEWPATH, &amp;lbuf);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fbuf.st=
_nlink &gt; 1 &amp;&amp; fbuf.st_nlink =3D=3D lbuf.st_nlink) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0...<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"><br></div></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
-}<br>
-<br>
-int main(int ac, char **av)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int lc;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_parse_opts(ac, av, NULL, NULL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0setup();<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (lc =3D 0; TEST_LOOPING(lc); lc++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_count =3D 0;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verify_link();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 TST_RET);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_exit();<br>
=C2=A0}<br>
<br>
=C2=A0static void setup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_sig(NOFORK, DEF_HANDLER, cleanup);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_PAUSE;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_tmpdir();<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(cleanup, OLDPATH, 0700, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(OLDPATH, 0700, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0static void cleanup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_rmdir();<br>
+=C2=A0 =C2=A0 SAFE_UNLINK(NEWPATH);<br></blockquote><div><br></div><div><d=
iv class=3D"gmail_default" style=3D"font-size:small">I&#39;d suggest moving=
 this unlink() to verify_link02 to make test</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">options &#39;-i N&#39; happy.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">Otherwise:</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div># ./link02 -i 2<br>tst_test.c:1365=
: TINFO: Timeout per run is 0h 05m 00s<br>link02.c:31: TPASS: link(oldpath,=
newpath) returned 0 and link counts match<br>link02.c:40: TFAIL: link(oldpa=
th,newpath) returned -1: EEXIST (17)<br><div class=3D"gmail_default" style=
=3D"font-size:small"></div></div><div><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
=C2=A0}<br>
+<br>
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 .test_all =3D verify_link02,<br>
+=C2=A0 =C2=A0 .setup =3D setup,<br>
+=C2=A0 =C2=A0 .cleanup =3D cleanup,<br>
+=C2=A0 =C2=A0 .needs_tmpdir =3D 1,<br>
+};<br>
--<br>
2.20.1<br>
<br>
<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000e6f1c405cf292bd0--


--===============1755197967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1755197967==--

