Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753E0C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 02:19:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 991313CC967
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 03:19:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 202423C8492
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 03:18:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A3221A00CC7
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 03:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669342726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6sqnxYMGJ2st87bNA3k02a1YQ7XP5vltjcJtxJXcnk=;
 b=NqdqxZWDrkXz1b4luHLqvYpmGOMC9QYphHuJMyYndDxtw3nXRHdYo+v72+2INZ1i/BaWDo
 fCbXKSyGsh2Hxe5q+PQkTJKoIsZYdQuRMwAwOcUyXlc/4ZCnyXrFgytYVRE6rUnBKrK2bz
 ck6q6HfkRyFmNBDUyrI/1AqzMnwAjAE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-0tML0eilN0KkO_qQJusEnw-1; Thu, 24 Nov 2022 21:18:44 -0500
X-MC-Unique: 0tML0eilN0KkO_qQJusEnw-1
Received: by mail-wm1-f72.google.com with SMTP id
 c1-20020a7bc001000000b003cfe40fca79so1186799wmb.6
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 18:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C6sqnxYMGJ2st87bNA3k02a1YQ7XP5vltjcJtxJXcnk=;
 b=g2wfQNZgEW/kVFBJIdwnFXufjvzYJaE7lH0eVE2H4RAveaSylE1HQhX6V+Z9f77Hvv
 qG88RrKCiYJHO4SySHHaSHNUlyUrRPnGnS07uL/kIuCDDCKSK6R0Kj5qjaxYSthZHtan
 z7ZAduMF/mE09JaPY7bPMRRaX18hmu5/OK9Eb9byjgEWiHa3wyC3dBESiaRXlgs0WvF2
 OaOujULU4lZSMfLa87VnfclDOuQqx8IwoS09okiuyqqx/NVcGtY9cPo8IFiUmFwsH937
 JOrgKgV9W2Gd1eZTNp3D91cbYPGfi3bKQBIxqf7kJCCR9t4wYkKQD5BbJ+8dDzWt3wR4
 y6pw==
X-Gm-Message-State: ANoB5pkzJEgTdbQoFm0m/bLNUZHaqZO2LKEdGBxXWqOVncqNnOHzoMRO
 ytONMdUdmmWV0kInSdJ9evJTczV62uGR0EMvIR1uHeljwXKoDKa0K4ce3v7frXV7WsfQXGze72q
 UEjmkaYXiWQu1IwlNS+oSJEXmWoE=
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id
 k9-20020adfe8c9000000b0022e33dc3bf1mr22256606wrn.316.1669342722861; 
 Thu, 24 Nov 2022 18:18:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7sKXnWxQt2duS174JURewrxIxjaFpBfRk2XA1ReHHxtTFIjg2WlfGyLyFvAJ3SF7FqYcepdTPdq7V/cUlD/iQ=
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id
 k9-20020adfe8c9000000b0022e33dc3bf1mr22256594wrn.316.1669342722604; Thu, 24
 Nov 2022 18:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20221124114204.990-1-akumar@suse.de>
In-Reply-To: <20221124114204.990-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Nov 2022 10:18:31 +0800
Message-ID: <CAEemH2eVctJWX8AehwFDa0aorAyM_c+yabnB8zbwDoTUaVQLyg@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statvfs01: Convert to new LTP API
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
Content-Type: multipart/mixed; boundary="===============2086231449=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2086231449==
Content-Type: multipart/alternative; boundary="000000000000fd65c305ee4223cf"

--000000000000fd65c305ee4223cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2022 at 7:42 PM Avinesh Kumar <akumar@suse.de> wrote:

> Also I've removed the TINFO statements, I'm not sure if only
> printing the data in logs is helpful in anyway.
>

Removing the printing is OK, but I am just wondering that
can we find a way to check if the returned value in 'buf' is
indeed correct?

As you can see the =E2=80=98struct statvfs=E2=80=98 includes many fs key
values that we need to trust when using them.

struct statvfs {
        unsigned long  f_bsize;    /* Filesystem block size */
        unsigned long  f_frsize;   /* Fragment size */
        fsblkcnt_t     f_blocks;   /* Size of fs in f_frsize units */
        fsblkcnt_t     f_bfree;    /* Number of free blocks */
        fsblkcnt_t     f_bavail;   /* Number of free blocks for
                                             unprivileged users */
        fsfilcnt_t     f_files;    /* Number of inodes */
        fsfilcnt_t     f_ffree;    /* Number of free inodes */
        fsfilcnt_t     f_favail;   /* Number of free inodes for
                                             unprivileged users */
        unsigned long  f_fsid;     /* Filesystem ID */
        unsigned long  f_flag;     /* Mount flags */
        unsigned long  f_namemax;  /* Maximum filename length */
 };


>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/statvfs/statvfs01.c | 96 +++++--------------
>  1 file changed, 22 insertions(+), 74 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c
> b/testcases/kernel/syscalls/statvfs/statvfs01.c
> index e3b356c93..89ca4e960 100644
> --- a/testcases/kernel/syscalls/statvfs/statvfs01.c
> +++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
> @@ -1,92 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
>   *    AUTHOR: Prashant P Yendigeri <prashant.yendigeri@wipro.com>
> - *
> - * This program is free software; you can redistribute it and/or modify =
it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License alo=
ng
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
> -/*
> - *    DESCRIPTION
> - *      This is a Phase I test for the statvfs(2) system call.
> - *      It is intended to provide a limited exposure of the system call.
> - *     This call behaves similar to statfs.
> +
> +/*\
> + * [Description]
> + *
> + * Verify that statvfs() executes successfully for all
> + * available filesystems.
>   */
>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <errno.h>
>  #include <sys/statvfs.h>
> -#include <stdint.h>
> -
> -#include "test.h"
> -
> -#define TEST_PATH "/"
> +#include "tst_test.h"
>
> -static void setup(void);
> -static void cleanup(void);
> +#define MNT_POINT "mntpoint"
> +#define TEST_PATH MNT_POINT"/testfile"
>
> -char *TCID =3D "statvfs01";
> -int TST_TOTAL =3D 1;
> -
> -int main(int ac, char **av)
> +static void run(void)
>  {
>         struct statvfs buf;
> -       int lc;
> -
> -       tst_parse_opts(ac, av, NULL, NULL);
>
> -       setup();
> -
> -       for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> -
> -               tst_count =3D 0;
> -
> -               TEST(statvfs(TEST_PATH, &buf));
> -
> -               if (TEST_RETURN =3D=3D -1) {
> -                       tst_resm(TFAIL | TTERRNO, "statvfs(%s, ...)
> failed",
> -                                TEST_PATH);
> -               } else {
> -                       tst_resm(TPASS, "statvfs(%s, ...) passed",
> TEST_PATH);
> -               }
> -
> -       }
> -
> -       tst_resm(TINFO, "This call is similar to statfs");
> -       tst_resm(TINFO, "Extracting info about the '%s' file system",
> -                TEST_PATH);
> -       tst_resm(TINFO, "file system block size =3D %lu bytes", buf.f_bsi=
ze);
> -       tst_resm(TINFO, "file system fragment size =3D %lu bytes",
> buf.f_frsize);
> -       tst_resm(TINFO, "file system free blocks =3D %ju",
> -                (uintmax_t) buf.f_bfree);
> -       tst_resm(TINFO, "file system total inodes =3D %ju",
> -                (uintmax_t) buf.f_files);
> -       tst_resm(TINFO, "file system free inodes =3D %ju",
> -                (uintmax_t) buf.f_ffree);
> -       tst_resm(TINFO, "file system id =3D %lu", buf.f_fsid);
> -       tst_resm(TINFO, "file system max filename length =3D %lu",
> buf.f_namemax);
> -
> -       cleanup();
> -       tst_exit();
> +       TST_EXP_PASS(statvfs(TEST_PATH, &buf));
>  }
>
>  static void setup(void)
>  {
> -       tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -       TEST_PAUSE;
> +       SAFE_TOUCH(TEST_PATH, 0666, NULL);
>  }
>
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test =3D {
> +       .test_all =3D run,
> +       .setup =3D setup,
> +       .needs_root =3D 1,
> +       .mount_device =3D 1,
> +       .mntpoint =3D MNT_POINT,
> +       .all_filesystems =3D 1
> +};
> --
> 2.38.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

--=20
Regards,
Li Wang

--000000000000fd65c305ee4223cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Nov 24, 2022 at 7:42 PM Avinesh Kumar &lt;<=
a href=3D"mailto:akumar@suse.de">akumar@suse.de</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Also I&#39;ve removed the TI=
NFO statements, I&#39;m not sure if only<br>
printing the data in logs is helpful in anyway.<br></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">Removing th=
e printing is OK, but I am just wondering that</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">can we find a way to check if the returned =
value in &#39;buf&#39; is</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">indeed correct?</div><br></div><div><div class=3D"gmail_default"=
 style=3D"font-size:small">As you can see the =E2=80=98struct statvfs=E2=80=
=98 includes=C2=A0many fs key</div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">values that we need to trust when using them.</div></div><di=
v><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">str=
uct statvfs {</div><span class=3D"gmail_default" style=3D"font-size:small">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</span>unsigned long =C2=A0f_bsize; =C2=A0=
 =C2=A0/* Filesystem block size */<br><span class=3D"gmail_default" style=
=3D"font-size:small"></span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long =C2=
=A0f_frsize; =C2=A0 /* Fragment size */<br><span class=3D"gmail_default" st=
yle=3D"font-size:small"></span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fsblkcnt_t =C2=
=A0 =C2=A0 f_blocks; =C2=A0 /* Size of fs in f_frsize units */<br><span cla=
ss=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fsblkcnt_t =C2=A0 =C2=A0 f_bfree; =C2=A0 =C2=A0/* Number of free blo=
cks */<br><span class=3D"gmail_default" style=3D"font-size:small"></span>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fsblkcnt_t =C2=A0 =C2=A0 f_bavail; =C2=A0 /* Nu=
mber of free blocks for<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unprivileged users */<br><span class=
=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fsfilcnt_t =C2=A0 =C2=A0 f_files; =C2=A0 =C2=A0/* Number of inodes *=
/<br><span class=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 fsfilcnt_t =C2=A0 =C2=A0 f_ffree; =C2=A0 =C2=A0/* Numb=
er of free inodes */<br><span class=3D"gmail_default" style=3D"font-size:sm=
all"></span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fsfilcnt_t =C2=A0 =C2=A0 f_favail; =
=C2=A0 /* Number of free inodes for<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unprivileged users */<b=
r><span class=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 unsigned long =C2=A0f_fsid; =C2=A0 =C2=A0 /* Filesystem I=
D */<br><span class=3D"gmail_default" style=3D"font-size:small"></span>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long =C2=A0f_flag; =C2=A0 =C2=A0 /* Mount=
 flags */<br><span class=3D"gmail_default" style=3D"font-size:small"></span=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long =C2=A0f_namemax; =C2=A0/* Maximu=
m filename length */<br>=C2=A0};<br><div class=3D"gmail_default" style=3D"f=
ont-size:small"></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
Signed-off-by: Avinesh Kumar &lt;<a href=3D"mailto:akumar@suse.de" target=
=3D"_blank">akumar@suse.de</a>&gt;<br>
---<br>
=C2=A0testcases/kernel/syscalls/statvfs/statvfs01.c | 96 +++++-------------=
-<br>
=C2=A01 file changed, 22 insertions(+), 74 deletions(-)<br>
<br>
diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kern=
el/syscalls/statvfs/statvfs01.c<br>
index e3b356c93..89ca4e960 100644<br>
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c<br>
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c<br>
@@ -1,92 +1,40 @@<br>
+// SPDX-License-Identifier: GPL-2.0<br>
=C2=A0/*<br>
=C2=A0 * Copyright (c) Wipro Technologies Ltd, 2005.=C2=A0 All Rights Reser=
ved.<br>
=C2=A0 *=C2=A0 =C2=A0 AUTHOR: Prashant P Yendigeri &lt;<a href=3D"mailto:pr=
ashant.yendigeri@wipro.com" target=3D"_blank">prashant.yendigeri@wipro.com<=
/a>&gt;<br>
- *<br>
- * This program is free software; you can redistribute it and/or modify it=
<br>
- * under the terms of version 2 of the GNU General Public License as<br>
- * published by the Free Software Foundation.<br>
- *<br>
- * This program is distributed in the hope that it would be useful, but<br=
>
- * WITHOUT ANY WARRANTY; without even the implied warranty of<br>
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.<br>
- *<br>
- * You should have received a copy of the GNU General Public License along=
<br>
- * with this program; if not, write the Free Software Foundation, Inc.,<br=
>
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
- *<br>
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar &lt;<a href=3D"mailto:avinesh=
.kumar@suse.com" target=3D"_blank">avinesh.kumar@suse.com</a>&gt;<br>
=C2=A0 */<br>
-/*<br>
- *=C2=A0 =C2=A0 DESCRIPTION<br>
- *=C2=A0 =C2=A0 =C2=A0 This is a Phase I test for the statvfs(2) system ca=
ll.<br>
- *=C2=A0 =C2=A0 =C2=A0 It is intended to provide a limited exposure of the=
 system call.<br>
- *=C2=A0 =C2=A0 =C2=A0This call behaves similar to statfs.<br>
+<br>
+/*\<br>
+ * [Description]<br>
+ *<br>
+ * Verify that statvfs() executes successfully for all<br>
+ * available filesystems.<br>
=C2=A0 */<br>
<br>
-#include &lt;stdio.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
-#include &lt;errno.h&gt;<br>
=C2=A0#include &lt;sys/statvfs.h&gt;<br>
-#include &lt;stdint.h&gt;<br>
-<br>
-#include &quot;test.h&quot;<br>
-<br>
-#define TEST_PATH &quot;/&quot;<br>
+#include &quot;tst_test.h&quot;<br>
<br>
-static void setup(void);<br>
-static void cleanup(void);<br>
+#define MNT_POINT &quot;mntpoint&quot;<br>
+#define TEST_PATH MNT_POINT&quot;/testfile&quot;<br>
<br>
-char *TCID =3D &quot;statvfs01&quot;;<br>
-int TST_TOTAL =3D 1;<br>
-<br>
-int main(int ac, char **av)<br>
+static void run(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct statvfs buf;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int lc;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_parse_opts(ac, av, NULL, NULL);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0setup();<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (lc =3D 0; TEST_LOOPING(lc); lc++) {<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_count =3D 0;<br=
>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEST(statvfs(TEST_P=
ATH, &amp;buf));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TEST_RETURN =3D=
=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_resm(TFAIL | TTERRNO, &quot;statvfs(%s, ...) failed&quot;,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST_PATH);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_resm(TPASS, &quot;statvfs(%s, ...) passed&quot;, TEST_PATH);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;This call is similar to s=
tatfs&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;Extracting info about the=
 &#39;%s&#39; file system&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST_PATH);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;file system block size =
=3D %lu bytes&quot;, buf.f_bsize);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;file system fragment size=
 =3D %lu bytes&quot;, buf.f_frsize);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;file system free blocks =
=3D %ju&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uintmax_t) buf.f_=
bfree);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;file system total inodes =
=3D %ju&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uintmax_t) buf.f_=
files);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;file system free inodes =
=3D %ju&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uintmax_t) buf.f_=
ffree);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;file system id =3D %lu&qu=
ot;, buf.f_fsid);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TINFO, &quot;file system max filename =
length =3D %lu&quot;, buf.f_namemax);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_exit();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_PASS(statvfs(TEST_PATH, &amp;buf));<br>
=C2=A0}<br>
<br>
=C2=A0static void setup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_sig(NOFORK, DEF_HANDLER, cleanup);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_PAUSE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(TEST_PATH, 0666, NULL);<br>
=C2=A0}<br>
<br>
-static void cleanup(void)<br>
-{<br>
-}<br>
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.test_all =3D run,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup =3D setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_root =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.mount_device =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.mntpoint =3D MNT_POINT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.all_filesystems =3D 1<br>
+};<br>
-- <br>
2.38.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000fd65c305ee4223cf--


--===============2086231449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2086231449==--

