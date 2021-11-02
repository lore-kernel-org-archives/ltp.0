Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB8AC433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 09:19:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BE360F36
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 09:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6BE360F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E27153C710E
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 10:19:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 153F53C6BE2
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 10:18:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 326071A017B4
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 10:18:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635844735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nki6omwzdYo9Mxf0QlGBmz0UVZ/eIOsH84UdszasqYg=;
 b=goOPxT0iryNsURd+ymjOEIDUtPQoO4LeyHsSpfHhxg9lW21PAQJwmwJGJ/Axs1flyjlzqR
 s8k5ZnfhVvHrns++xgkI+vFgtwc6pFmnUWW+rG8OBaXS7Mdn6J8+7Ar4oEAJooVQYWWFBP
 0hQi2ky1YE3HNSUTnzAYrG4FADV1++E=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-NItCqXelO7e9KRlDOrmTTQ-1; Tue, 02 Nov 2021 05:18:44 -0400
X-MC-Unique: NItCqXelO7e9KRlDOrmTTQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 y125-20020a25dc83000000b005c2326bf744so11015428ybe.21
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 02:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nki6omwzdYo9Mxf0QlGBmz0UVZ/eIOsH84UdszasqYg=;
 b=IeTdJW75GS3Xim5pbUKWjEE8SttvMOiJb7LaKogUV3Q1Yt8VY2bog5oBFUtiiQSM/X
 GgIJ7zwbnPijSATTQ4RCsOm69GwQMlWy4D8vceubwXeak3xUiTBpp7Kn5t03tfvNe9I9
 N05Cy7TkzvdHnm5446U2bLLXzy+U1YyA+/Od7o7qLvJQ5H7dDCH5P4XTEOkkPLit8PYi
 uMC2SBkRXvPpPkqXG2LPHauTg1jRwhE0Ukk/Yir6Bm68p1y5Kl1Knd+zP7izO9okGqY4
 q+WDkCdHCYOnYuln4Jfrr/IwfzQhAbkhfhv2mX0ydEzSwApTN+p+EyPTv5sW/EUN91w4
 JAeg==
X-Gm-Message-State: AOAM533QMecDM1aUUdo6Sw+jl0U3JNE5xic6w5cTmrM0ZKcH+XjjdbQw
 qGEselP2X5D0l7149SCMAyvWWA03KrnQnWzHYaa9o5W1Gj+w7ZIcpFV14F0GAsPO/P1SS6kkO6w
 McCxCen4K51pEcdCaOw3TGi/YC04=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr19333525ybt.302.1635844723445; 
 Tue, 02 Nov 2021 02:18:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyl1vGyAv4r9EZSobKrKHN8BsH2B2gKx89nHPBedv1MshZRkGHDWcAUyrT3BnuXQ4P+A1Lep2U53n0/uOvDz24=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr19333506ybt.302.1635844723190; 
 Tue, 02 Nov 2021 02:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211029080527.28014-1-tangmeng@uniontech.com>
In-Reply-To: <20211029080527.28014-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Nov 2021 17:18:30 +0800
Message-ID: <CAEemH2cC0S73kBC9qbpYLuog70EGvRtuHAm7y0NAk76ouYaZ3w@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] link/link04: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============0305848199=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0305848199==
Content-Type: multipart/alternative; boundary="000000000000a245d705cfcac74b"

--000000000000a245d705cfcac74b
Content-Type: text/plain; charset="UTF-8"

Hi Meng,

On Fri, Oct 29, 2021 at 4:06 PM tangmeng <tangmeng@uniontech.com> wrote:

> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  testcases/kernel/syscalls/link/link04.c | 140 +++++-------------------
>  1 file changed, 29 insertions(+), 111 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/link/link04.c
> b/testcases/kernel/syscalls/link/link04.c
> index d9408845e..acc8a7134 100644
> --- a/testcases/kernel/syscalls/link/link04.c
> +++ b/testcases/kernel/syscalls/link/link04.c
> @@ -1,65 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>   *  AUTHOR             : Richard Logan
>   *  CO-PILOT           : William Roske
>   * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - *
>   */
>
> -/*
> +/*\
> + * [Description]
> + *
>   * Negative test cases for link(2).
>   *
>   * This test program should contain test cases where link will fail
> regardless
>   * of who executed it (i.e. joe-user or root)
>   */
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
>  #include <sys/param.h>
>  #include <sys/mman.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>
>  static char longpath[PATH_MAX + 2];
>
> -struct test_case_t {
> +struct tcase_t {
>         char *file1;
>         char *desc1;
>         char *file2;
>         char *desc2;
>         int exp_errno;
> -} test_cases[] = {
> +} tcases[] = {
>         /* first path is invalid */
>         {"nonexistfile", "non-existent file", "nefile", "nefile", ENOENT},
>         {"", "path is empty string", "nefile", "nefile", ENOENT},
> @@ -81,90 +48,41 @@ struct test_case_t {
>         {"regfile", "regfile", "regfile2", "regfile2", EEXIST},
>  };
>
> -char *TCID = "link04";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static unsigned int TST_TOTAL = ARRAY_SIZE(tcases);
>

There is no need to define an extra global variable for the test loop.

LTP itself has already supported that to traversing tcase by .tcnt.

For your reference:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise01.c#L117



>
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int ac, char **av)
> +static void verify_link(void)
>  {
> -       int lc;
> -       char *fname1, *fname2;
> -       char *desc1, *desc2;
> -       int i;
> -
> -       tst_parse_opts(ac, av, NULL, NULL);
> -
> -       setup();
> -
> -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -               tst_count = 0;
> -
> -               for (i = 0; i < TST_TOTAL; i++) {
> -
> -                       fname1 = test_cases[i].file1;
> -                       desc1 = test_cases[i].desc1;
> -                       fname2 = test_cases[i].file2;
> -                       desc2 = test_cases[i].desc2;
> -
> -                       TEST(link(fname1, fname2));
> -
> -                       if (TEST_RETURN == -1) {
> -                               if (TEST_ERRNO == test_cases[i].exp_errno)
> {
> -                                       tst_resm(TPASS | TTERRNO,
> -                                                "link(<%s>, <%s>)",
> -                                                desc1, desc2);
> -                               } else {
> -                                       tst_resm(TFAIL | TTERRNO,
> -                                                "link(<%s>, <%s>) Failed "
> -                                                "expected errno: %d",
> -                                                desc1, desc2,
> -                                                test_cases[i].exp_errno);
> -                               }
> -                       } else {
> -                               tst_resm(TFAIL,
> -                                        "link(<%s>, <%s>) returned %ld, "
> -                                        "expected -1, errno:%d",
> -                                        desc1, desc2, TEST_RETURN,
> -                                        test_cases[i].exp_errno);
> -                       }
> -               }
> +       unsigned int i;
>
> +       for (i = 0; i < TST_TOTAL; i++) {
> +               TST_EXP_FAIL(link(tcases[i].file1, tcases[i].file2),
> +                               tcases[i].exp_errno, "link(<%s>, <%s>)",
> +                               tcases[i].desc1, tcases[i].desc2);
>         }
> -
> -       cleanup();
> -       tst_exit();
>  }
>
>  static void setup(void)
>  {
> -       int n;
> -
> -       tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -       TEST_PAUSE;
> -
> -       tst_tmpdir();
> +       unsigned int i;
>
>         memset(longpath, 'a', PATH_MAX+1);
> -       SAFE_TOUCH(cleanup, "regfile", 0777, NULL);
> -       SAFE_TOUCH(cleanup, "regfile2", 0777, NULL);
> -       SAFE_MKDIR(cleanup, "dir", 0777);
> +       SAFE_TOUCH("regfile", 0777, NULL);
> +       SAFE_TOUCH("regfile2", 0777, NULL);
> +       SAFE_MKDIR("dir", 0777);
>
> -       void *bad_addr = tst_get_bad_addr(cleanup);
> +       void *bad_addr = tst_get_bad_addr(NULL);
>
> -       for (n = 0; n < TST_TOTAL; n++) {
> -               if (!test_cases[n].file1)
> -                       test_cases[n].file1 = bad_addr;
> +       for (i = 0; i < TST_TOTAL; i++) {
> +               if (!tcases[i].file1)
> +                       tcases[i].file1 = bad_addr;
>
> -               if (!test_cases[n].file2)
> -                       test_cases[n].file2 = bad_addr;
> +               if (!tcases[i].file2)
> +                       tcases[i].file2 = bad_addr;
>         }
>  }
>
> -static void cleanup(void)
> -{
> -       tst_rmdir();
> -}
> +static struct tst_test test = {
> +       .test_all = verify_link,
> +       .setup = setup,
> +       .needs_tmpdir = 1,
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

--000000000000a245d705cfcac74b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Meng,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Oct 29, 2021 at 4:06 PM tangmeng &lt;=
<a href=3D"mailto:tangmeng@uniontech.com">tangmeng@uniontech.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-=
by: tangmeng &lt;<a href=3D"mailto:tangmeng@uniontech.com" target=3D"_blank=
">tangmeng@uniontech.com</a>&gt;<br>
---<br>
=C2=A0testcases/kernel/syscalls/link/link04.c | 140 +++++------------------=
-<br>
=C2=A01 file changed, 29 insertions(+), 111 deletions(-)<br>
<br>
diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/sys=
calls/link/link04.c<br>
index d9408845e..acc8a7134 100644<br>
--- a/testcases/kernel/syscalls/link/link04.c<br>
+++ b/testcases/kernel/syscalls/link/link04.c<br>
@@ -1,65 +1,32 @@<br>
+// SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0/*<br>
=C2=A0 * Copyright (c) 2000 Silicon Graphics, Inc.=C2=A0 All Rights Reserve=
d.<br>
=C2=A0 *=C2=A0 AUTHOR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: Rich=
ard Logan<br>
=C2=A0 *=C2=A0 CO-PILOT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: William R=
oske<br>
=C2=A0 * Copyright (c) 2014 Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse=
.cz" target=3D"_blank">chrubis@suse.cz</a>&gt;<br>
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
- * Further, this software is distributed without any warranty that it is<b=
r>
- * free of the rightful claim of any third person regarding infringement<b=
r>
- * or the like.=C2=A0 Any license provided herein, whether implied or<br>
- * otherwise, applies only to this software file.=C2=A0 Patent licenses, i=
f<br>
- * any, provided herein do not apply to combinations of this program with<=
br>
- * other software, or any other product whatsoever.<br>
- *<br>
- * You should have received a copy of the GNU General Public License along=
<br>
- * with this program; if not, write the Free Software Foundation, Inc.,<br=
>
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
- *<br>
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,<br=
>
- * Mountain View, CA=C2=A0 94043, or:<br>
- *<br>
- * <a href=3D"http://www.sgi.com" rel=3D"noreferrer" target=3D"_blank">htt=
p://www.sgi.com</a><br>
- *<br>
- * For further information regarding this notice, see:<br>
- *<br>
- * <a href=3D"http://oss.sgi.com/projects/GenInfo/NoticeExplan/" rel=3D"no=
referrer" target=3D"_blank">http://oss.sgi.com/projects/GenInfo/NoticeExpla=
n/</a><br>
- *<br>
=C2=A0 */<br>
<br>
-/*<br>
+/*\<br>
+ * [Description]<br>
+ *<br>
=C2=A0 * Negative test cases for link(2).<br>
=C2=A0 *<br>
=C2=A0 * This test program should contain test cases where link will fail r=
egardless<br>
=C2=A0 * of who executed it (i.e. joe-user or root)<br>
=C2=A0 */<br>
-#include &lt;sys/types.h&gt;<br>
-#include &lt;fcntl.h&gt;<br>
-#include &lt;sys/stat.h&gt;<br>
-#include &lt;errno.h&gt;<br>
-#include &lt;string.h&gt;<br>
-#include &lt;signal.h&gt;<br>
=C2=A0#include &lt;sys/param.h&gt;<br>
=C2=A0#include &lt;sys/mman.h&gt;<br>
-#include &quot;test.h&quot;<br>
-#include &quot;safe_macros.h&quot;<br>
+#include &quot;tst_test.h&quot;<br>
<br>
=C2=A0static char longpath[PATH_MAX + 2];<br>
<br>
-struct test_case_t {<br>
+struct tcase_t {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *file1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *desc1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *file2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *desc2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int exp_errno;<br>
-} test_cases[] =3D {<br>
+} tcases[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* first path is invalid */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;nonexistfile&quot;, &quot;non-existent f=
ile&quot;, &quot;nefile&quot;, &quot;nefile&quot;, ENOENT},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;&quot;, &quot;path is empty string&quot;=
, &quot;nefile&quot;, &quot;nefile&quot;, ENOENT},<br>
@@ -81,90 +48,41 @@ struct test_case_t {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;regfile&quot;, &quot;regfile&quot;, &quo=
t;regfile2&quot;, &quot;regfile2&quot;, EEXIST},<br>
=C2=A0};<br>
<br>
-char *TCID =3D &quot;link04&quot;;<br>
-int TST_TOTAL =3D ARRAY_SIZE(test_cases);<br>
+static unsigned int TST_TOTAL =3D ARRAY_SIZE(tcases);<br></blockquote><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Ther=
e is no need to define an extra global variable for the test loop.</div><di=
v class=3D"gmail_default" style=3D"font-size:small"><br></div>LTP itself <s=
pan class=3D"gmail_default" style=3D"font-size:small">has already=C2=A0</sp=
an>support<span class=3D"gmail_default" style=3D"font-size:small">ed that</=
span> to <span class=3D"gmail_default" style=3D"font-size:small"></span>tra=
versing=C2=A0t<span class=3D"gmail_default" style=3D"font-size:small">case<=
/span><span class=3D"gmail_default" style=3D"font-size:small"></span> by .t=
cnt<span class=3D"gmail_default" style=3D"font-size:small">.</span><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmai=
l_default" style=3D"font-size:small">For your reference:</div><div class=3D=
"gmail_default" style=3D"font-size:small"><a href=3D"https://github.com/lin=
ux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise01=
.c#L117">https://github.com/linux-test-project/ltp/blob/master/testcases/ke=
rnel/syscalls/madvise/madvise01.c#L117</a><br></div><br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-static void setup(void);<br>
-static void cleanup(void);<br>
-<br>
-int main(int ac, char **av)<br>
+static void verify_link(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int lc;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char *fname1, *fname2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char *desc1, *desc2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_parse_opts(ac, av, NULL, NULL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0setup();<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (lc =3D 0; TEST_LOOPING(lc); lc++) {<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_count =3D 0;<br=
>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt=
; TST_TOTAL; i++) {<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fname1 =3D test_cases[i].file1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0desc1 =3D test_cases[i].desc1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fname2 =3D test_cases[i].file2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0desc2 =3D test_cases[i].desc2;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TEST(link(fname1, fname2));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (TEST_RETURN =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TEST_ERRNO =3D=3D test_cases[i].e=
xp_errno) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(=
TPASS | TTERRNO,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;link(&lt;%s&gt;, &lt;%s&gt;)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 desc1, desc2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(=
TFAIL | TTERRNO,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;link(&lt;%s&gt;, &lt;%s&gt;) Failed &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;expected errno: %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 desc1, desc2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 test_cases[i].exp_errno);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm(TFAIL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;li=
nk(&lt;%s&gt;, &lt;%s&gt;) returned %ld, &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ex=
pected -1, errno:%d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc1, d=
esc2, TEST_RETURN,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cas=
es[i].exp_errno);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; TST_TOTAL; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(link(t=
cases[i].file1, tcases[i].file2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcases[i].exp_errno, &quot;link(&lt;%=
s&gt;, &lt;%s&gt;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcases[i].desc1, tcases[i].desc2);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_exit();<br>
=C2=A0}<br>
<br>
=C2=A0static void setup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int n;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_sig(NOFORK, DEF_HANDLER, cleanup);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_PAUSE;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_tmpdir();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(longpath, &#39;a&#39;, PATH_MAX+1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(cleanup, &quot;regfile&quot;, 0777, =
NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(cleanup, &quot;regfile2&quot;, 0777,=
 NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MKDIR(cleanup, &quot;dir&quot;, 0777);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(&quot;regfile&quot;, 0777, NULL);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(&quot;regfile2&quot;, 0777, NULL);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MKDIR(&quot;dir&quot;, 0777);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void *bad_addr =3D tst_get_bad_addr(cleanup);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void *bad_addr =3D tst_get_bad_addr(NULL);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (n =3D 0; n &lt; TST_TOTAL; n++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_cases[n].=
file1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0test_cases[n].file1 =3D bad_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; TST_TOTAL; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tcases[i].file=
1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tcases[i].file1 =3D bad_addr;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_cases[n].=
file2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0test_cases[n].file2 =3D bad_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tcases[i].file=
2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tcases[i].file2 =3D bad_addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-static void cleanup(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_rmdir();<br>
-}<br>
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.test_all =3D verify_link,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup =3D setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_tmpdir =3D 1,<br>
+};<br>
-- <br>
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
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000a245d705cfcac74b--


--===============0305848199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0305848199==--

