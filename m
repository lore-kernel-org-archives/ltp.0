Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0435FC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 10:20:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFC913C9845
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 11:20:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E60D73C9564
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 11:20:26 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 128E12009CB
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 11:20:26 +0100 (CET)
Received: by mail-wr1-x436.google.com with SMTP id s1so12319121wrg.10
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 02:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mItomy5BwHd5wz4+WvKFJ894SlALa256ZKkkk0MxlyQ=;
 b=fSRF0ZKaUGj2H2Mf2ldltITQGg8YpD2cO2mlyXhX1os5qbRy6P1rUnzguouxg+DaU4
 ILA5NiAjT4Gug2TPSEES/YzjGErZVeF64pR5r6sviwEmSpsXGgX8DyIiPH47+VGxQezi
 UjpN02k1pSXd7iqWGnCDj3eCmFBIG3xM0SKM3MiIPxbjEeiQdVKmCtSvj/nSzq/YpOGE
 en5ufJ01ka4swZZU/mpVOjhet0UaAhgU6AT5CtwvDZII1sd21sQiJdT8AKFl4L9kp0jR
 zZBBCn2U10irDSh18H1onaZNNWn7Ayq2FnRrnnNrJcWpYK9L8ArFaWl0CFjaC0evrz0j
 eSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mItomy5BwHd5wz4+WvKFJ894SlALa256ZKkkk0MxlyQ=;
 b=GVIVWl3L9EsNqdmqeJ4RKI0/mibeOiwO+pd6Jzdf4biV3wApsszHgLIbCtKDb/qXub
 8V1ZJP3xNy6kdfzhf9JoB9ZGWd525DtLNXBUbvPnxYKOuPyTv8VFvwzJA6Xg3ED9y0IO
 N0wwY3BPTJ0Ia1lqg5vP4Pg/74qCbrDqmPLnK5GtAq8agu7IjzTHYRbK1b+s/XysiVM1
 UBp0HMLshub3oPaKZ7/DsGxwRRmFEDQDtE7BAP9O6fmgvLoZinh3GM9GLJMGHKUHpXAT
 XOr3gVy0Wu4Iv8lIhwmaq8SPspcJvdFUXZI4+G2Qwyyn44Tv4lvbopRSv2csCLShJw8a
 SyoA==
X-Gm-Message-State: AOAM530r58em3ZV/8YU2PhFonEL+nIxqYIqn2iCDvzwhjbKBI5l9l/Pb
 VyINeiIj/iDT+wBpyTJIKHTlphFgkYc6Iq2unWQ=
X-Google-Smtp-Source: ABdhPJyvuieWsXUh531IHnjaiRT1RhZvjOaENkWT+wOhPOyAUYRZFO8MI3KdYa2UTisjjWiwDL7GOISH3ebYGHjcYIM=
X-Received: by 2002:a5d:6b0f:0:b0:1e7:9432:ee8c with SMTP id
 v15-20020a5d6b0f000000b001e79432ee8cmr21507510wrw.216.1645611625454; Wed, 23
 Feb 2022 02:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20220210105101.38337-1-kushalkataria5@gmail.com>
 <YgUw7scGZwUcK22E@yuki>
In-Reply-To: <YgUw7scGZwUcK22E@yuki>
From: Kushal Chand <kushalkataria5@gmail.com>
Date: Wed, 23 Feb 2022 15:50:13 +0530
Message-ID: <CAKaR1hXZL5vfq_SXXwyh8wCr4Rwwugi4ydDzXKhMwGVUsiHoBQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fstat_02: Increase test coverage by creating
 hard link to file and validate using fstat
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1482928964=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1482928964==
Content-Type: multipart/alternative; boundary="0000000000005f9e7905d8acd002"

--0000000000005f9e7905d8acd002
Content-Type: text/plain; charset="UTF-8"

Hi,

Apology for the late reply.

I am not sure about the st_blocks size. If you can guide me how to check
that I might work on that?

Are you planning to merge this patch with the st_blocks check or the
current version is ready to be merged?

On Thu, Feb 10, 2022 at 9:04 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> The subject should be shorter and more to the point, something as:
>
> "fstat02: Validate st_nlink as well"
>
> > Implements: #517
>
> The code looks good now, but it's not complete solution to #517, there
> are still many fields of the structure that are not checked and a few
> more patches would be required to complete it.
>
> For instance the st_blocks should be more or less equal size/512
>
> And we should check the atime/mtime/ctime as well, but maybe it would be
> easier if we do that in a separate test.
>
> > This patch creates a hard link for a file during setup and checks if
> number of hardlinks
> > match with the expected number.
>
> This is missing Signed-off-by: line see:
>
>
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>
> > ---
> >  testcases/kernel/syscalls/fstat/fstat02.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/fstat/fstat02.c
> b/testcases/kernel/syscalls/fstat/fstat02.c
> > index c0229de44..2f9632edf 100644
> > --- a/testcases/kernel/syscalls/fstat/fstat02.c
> > +++ b/testcases/kernel/syscalls/fstat/fstat02.c
> > @@ -17,8 +17,10 @@
> >  #include "tst_safe_macros.h"
> >
> >  #define TESTFILE        "test_file"
> > +#define LINK_TESTFILE   "link_test_file"
> >  #define FILE_SIZE       1024
> >  #define FILE_MODE    0644
> > +#define NLINK                2
> >
> >  static struct stat stat_buf;
> >  static uid_t user_id;
> > @@ -61,6 +63,12 @@ static void run(void)
> >               fail++;
> >       }
> >
> > +     if (stat_buf.st_nlink != NLINK) {
> > +             tst_res(TFAIL, "stat_buf.st_nlink = %li expected %i",
> > +                     (long)stat_buf.st_nlink, NLINK);
> > +             fail++;
> > +     }
> > +
> >       if (fail)
> >               return;
> >
> > @@ -78,6 +86,8 @@ static void setup(void)
> >
> >       if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
> >               tst_brk(TBROK, "Could not fill Testfile!");
> > +
> > +     SAFE_LINK(TESTFILE, LINK_TESTFILE);
> >  }
> >
> >  static void cleanup(void)
> > --
> > 2.25.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz


On Thu, Feb 10, 2022 at 9:04 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> The subject should be shorter and more to the point, something as:
>
> "fstat02: Validate st_nlink as well"
>
> > Implements: #517
>
> The code looks good now, but it's not complete solution to #517, there
> are still many fields of the structure that are not checked and a few
> more patches would be required to complete it.
>
> For instance the st_blocks should be more or less equal size/512
>
> And we should check the atime/mtime/ctime as well, but maybe it would be
> easier if we do that in a separate test.
>
> > This patch creates a hard link for a file during setup and checks if
> number of hardlinks
> > match with the expected number.
>
> This is missing Signed-off-by: line see:
>
>
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>
> > ---
> >  testcases/kernel/syscalls/fstat/fstat02.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/fstat/fstat02.c
> b/testcases/kernel/syscalls/fstat/fstat02.c
> > index c0229de44..2f9632edf 100644
> > --- a/testcases/kernel/syscalls/fstat/fstat02.c
> > +++ b/testcases/kernel/syscalls/fstat/fstat02.c
> > @@ -17,8 +17,10 @@
> >  #include "tst_safe_macros.h"
> >
> >  #define TESTFILE        "test_file"
> > +#define LINK_TESTFILE   "link_test_file"
> >  #define FILE_SIZE       1024
> >  #define FILE_MODE    0644
> > +#define NLINK                2
> >
> >  static struct stat stat_buf;
> >  static uid_t user_id;
> > @@ -61,6 +63,12 @@ static void run(void)
> >               fail++;
> >       }
> >
> > +     if (stat_buf.st_nlink != NLINK) {
> > +             tst_res(TFAIL, "stat_buf.st_nlink = %li expected %i",
> > +                     (long)stat_buf.st_nlink, NLINK);
> > +             fail++;
> > +     }
> > +
> >       if (fail)
> >               return;
> >
> > @@ -78,6 +86,8 @@ static void setup(void)
> >
> >       if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
> >               tst_brk(TBROK, "Could not fill Testfile!");
> > +
> > +     SAFE_LINK(TESTFILE, LINK_TESTFILE);
> >  }
> >
> >  static void cleanup(void)
> > --
> > 2.25.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>

--0000000000005f9e7905d8acd002
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><br>Apology for the late reply.=C2=
=A0<br><br>I am not sure about the st_blocks size. If you can guide me how =
to check that I might work on that?<br><br>Are you planning to merge this p=
atch with the st_blocks check or the current version is ready to be merged?=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Thu, Feb 10, 2022 at 9:04 PM Cyril Hrubis &lt;<a href=3D"mailto:chrubis@=
suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Hi!<br>The subject should be shorter and more to th=
e point, something as:<br><br>&quot;fstat02: Validate st_nlink as well&quot=
;<br><br>&gt; Implements: #517<br><br>The code looks good now, but it&#39;s=
 not complete solution to #517, there<br>are still many fields of the struc=
ture that are not checked and a few<br>more patches would be required to co=
mplete it.<br><br>For instance the st_blocks should be more or less equal s=
ize/512<br><br>And we should check the atime/mtime/ctime as well, but maybe=
 it would be<br>easier if we do that in a separate test.<br><br>&gt; This p=
atch creates a hard link for a file during setup and checks if number of ha=
rdlinks<br>&gt; match with the expected number.<br><br>This is missing Sign=
ed-off-by: line see:<br><br><a href=3D"https://www.kernel.org/doc/html/v4.1=
7/process/submitting-patches.html#sign-your-work-the-developer-s-certificat=
e-of-origin" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/do=
c/html/v4.17/process/submitting-patches.html#sign-your-work-the-developer-s=
-certificate-of-origin</a><br><br>&gt; ---<br>&gt;=C2=A0 testcases/kernel/s=
yscalls/fstat/fstat02.c | 10 ++++++++++<br>&gt;=C2=A0 1 file changed, 10 in=
sertions(+)<br>&gt;<br>&gt; diff --git a/testcases/kernel/syscalls/fstat/fs=
tat02.c b/testcases/kernel/syscalls/fstat/fstat02.c<br>&gt; index c0229de44=
..2f9632edf 100644<br>&gt; --- a/testcases/kernel/syscalls/fstat/fstat02.c<=
br>&gt; +++ b/testcases/kernel/syscalls/fstat/fstat02.c<br>&gt; @@ -17,8 +1=
7,10 @@<br>&gt;=C2=A0 #include &quot;tst_safe_macros.h&quot;<br>&gt;=C2=A0<=
br>&gt;=C2=A0 #define TESTFILE=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;test_file&q=
uot;<br>&gt; +#define LINK_TESTFILE=C2=A0 =C2=A0&quot;link_test_file&quot;<=
br>&gt;=C2=A0 #define FILE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A01024<br>&gt;=C2=
=A0 #define FILE_MODE=C2=A0 =C2=A0 0644<br>&gt; +#define NLINK=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>&gt;=C2=A0<br>&gt;=C2=A0 st=
atic struct stat stat_buf;<br>&gt;=C2=A0 static uid_t user_id;<br>&gt; @@ -=
61,6 +63,12 @@ static void run(void)<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fail++;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt;=
=C2=A0<br>&gt; +=C2=A0 =C2=A0 =C2=A0if (stat_buf.st_nlink !=3D NLINK) {<br>=
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL, &quot;=
stat_buf.st_nlink =3D %li expected %i&quot;,<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(long)stat_buf.st_nl=
ink, NLINK);<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail+=
+;<br>&gt; +=C2=A0 =C2=A0 =C2=A0}<br>&gt; +<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (fail)<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return;<br>&gt;=C2=A0<br>&gt; @@ -78,6 +86,8 @@ static void setup(void)<br>=
&gt;=C2=A0<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_fill_file(TESTFILE, &#=
39;a&#39;, FILE_SIZE, 1))<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tst_brk(TBROK, &quot;Could not fill Testfile!&quot;);<br>&gt; =
+<br>&gt; +=C2=A0 =C2=A0 =C2=A0SAFE_LINK(TESTFILE, LINK_TESTFILE);<br>&gt;=
=C2=A0 }<br>&gt;=C2=A0<br>&gt;=C2=A0 static void cleanup(void)<br>&gt; --<b=
r>&gt; 2.25.1<br>&gt;<br>&gt;<br>&gt; --<br>&gt; Mailing list info:=C2=A0<a=
 href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"noreferrer" target=3D"=
_blank">https://lists.linux.it/listinfo/ltp</a><br><br>--<br>Cyril Hrubis<b=
r><a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a><=
/blockquote></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, Feb 10, 2022 at 9:04 PM Cyril Hrubis &lt;<a href=
=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi!<br>
The subject should be shorter and more to the point, something as:<br>
<br>
&quot;fstat02: Validate st_nlink as well&quot;<br>
<br>
&gt; Implements: #517<br>
<br>
The code looks good now, but it&#39;s not complete solution to #517, there<=
br>
are still many fields of the structure that are not checked and a few<br>
more patches would be required to complete it.<br>
<br>
For instance the st_blocks should be more or less equal size/512<br>
<br>
And we should check the atime/mtime/ctime as well, but maybe it would be<br=
>
easier if we do that in a separate test.<br>
<br>
&gt; This patch creates a hard link for a file during setup and checks if n=
umber of hardlinks<br>
&gt; match with the expected number.<br>
<br>
This is missing Signed-off-by: line see:<br>
<br>
<a href=3D"https://www.kernel.org/doc/html/v4.17/process/submitting-patches=
.html#sign-your-work-the-developer-s-certificate-of-origin" rel=3D"noreferr=
er" target=3D"_blank">https://www.kernel.org/doc/html/v4.17/process/submitt=
ing-patches.html#sign-your-work-the-developer-s-certificate-of-origin</a><b=
r>
<br>
&gt; ---<br>
&gt;=C2=A0 testcases/kernel/syscalls/fstat/fstat02.c | 10 ++++++++++<br>
&gt;=C2=A0 1 file changed, 10 insertions(+)<br>
&gt; <br>
&gt; diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/ker=
nel/syscalls/fstat/fstat02.c<br>
&gt; index c0229de44..2f9632edf 100644<br>
&gt; --- a/testcases/kernel/syscalls/fstat/fstat02.c<br>
&gt; +++ b/testcases/kernel/syscalls/fstat/fstat02.c<br>
&gt; @@ -17,8 +17,10 @@<br>
&gt;=C2=A0 #include &quot;tst_safe_macros.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define TESTFILE=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;test_file&quot=
;<br>
&gt; +#define LINK_TESTFILE=C2=A0 =C2=A0&quot;link_test_file&quot;<br>
&gt;=C2=A0 #define FILE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A01024<br>
&gt;=C2=A0 #define FILE_MODE=C2=A0 =C2=A0 0644<br>
&gt; +#define NLINK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
2<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static struct stat stat_buf;<br>
&gt;=C2=A0 static uid_t user_id;<br>
&gt; @@ -61,6 +63,12 @@ static void run(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail++;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (stat_buf.st_nlink !=3D NLINK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL, &quot;=
stat_buf.st_nlink =3D %li expected %i&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(long)stat_buf.st_nlink, NLINK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fail)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 <br>
&gt; @@ -78,6 +86,8 @@ static void setup(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_fill_file(TESTFILE, &#39;a&#39;, FIL=
E_SIZE, 1))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK, &=
quot;Could not fill Testfile!&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0SAFE_LINK(TESTFILE, LINK_TESTFILE);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void cleanup(void)<br>
&gt; -- <br>
&gt; 2.25.1<br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=
=3D"noreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><b=
r>
<br>
-- <br>
Cyril Hrubis<br>
<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a><br=
>
</blockquote></div>

--0000000000005f9e7905d8acd002--

--===============1482928964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1482928964==--
