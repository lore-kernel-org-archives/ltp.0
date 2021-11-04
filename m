Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA5C433EF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 07:10:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5493861053
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 07:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5493861053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E94F23C72C6
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 08:10:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA1AE3C7205
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 08:10:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1198360111E
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 08:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636009832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAkxHqrERouvfSxezZGM8QWzx8AIQgqs4Ie0sbFe21c=;
 b=G+M2CpXdfXSPw48B4EwQBEiH1/7oIx+V2TOLSf4CkT/uVYzrT36ADNyKKd6yXQos5ghHg+
 x0x2goZ36sDWFvILscP7VMSjFMh2j0ZNrD2STG0Gjl0vCRuYyHNGbLhvT1N80D4qFxwo1S
 rfLPiNqUYgLmZaua0pCBtSX+HeBNZsI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-svJ9P4gvPmGcwYSQT4vBng-1; Thu, 04 Nov 2021 03:10:26 -0400
X-MC-Unique: svJ9P4gvPmGcwYSQT4vBng-1
Received: by mail-yb1-f199.google.com with SMTP id
 z2-20020a254c02000000b005b68ef4fe24so7540392yba.11
 for <ltp@lists.linux.it>; Thu, 04 Nov 2021 00:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HAkxHqrERouvfSxezZGM8QWzx8AIQgqs4Ie0sbFe21c=;
 b=bfu3z8P/se+2L3jcXOyw1NxYUkZ+IeLmhZ+n9cbguoUixnxEJ7CRtSwRF11gADBbWR
 mePG0TQAk5TBdPeyH4xvlmwQB/eDu8wD/ran2ysN8ZkqkVAjxztFDOcG0UFys1oZQv9p
 5SB4t2TfOQsVxgaDjHnm4xIJ0remDEmGu5/xfLAM1zwiKeiufdG02sPpbHkUe9wAKnUH
 vdqRbNGGryQVaxAXoNyRdSriNKehRmBVYYK+CCcpVA1XgbxvqhGggDNEqItMblD1iYVg
 rhyuHXI7TFwvlxG3aETFEQsvHJ/UbDXxEzgy2aQNj09oappxqc9h7pyRdIoxI6SBvKbu
 efTw==
X-Gm-Message-State: AOAM530C8eVqJCoggphSLasvDBwOQponVwqcXfQXUdIW0XVkyjW+0Ufu
 dgzohnZFB4GLkYiEnF/ULh10HJ9eQ/yR2xKSTqHMIU0uPNMujHZrlqJGbe0oapG/+JvMcxBo+Hr
 5bt6VKoDGHCamPPwBP4c3xPwFmuQ=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr40645963ybi.186.1636009826194; 
 Thu, 04 Nov 2021 00:10:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaDAKqw+1xper2UvJxJI0kjd8KBalujqxUeQxeILUrIzHpXy3FV93qog1ppv0BPSUMgXyK+vQvPmYcnUArNkk=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr40645944ybi.186.1636009825869; 
 Thu, 04 Nov 2021 00:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211103232604.7930-1-tangmeng@uniontech.com>
In-Reply-To: <20211103232604.7930-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Nov 2021 15:10:12 +0800
Message-ID: <CAEemH2euhsqdvooX9jxiJr5t2UoqZePpHicV0qK=Yc9eQj7u=w@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] syscalls/link: Convert to new API and
 merge link06 and link07 into link04
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
Content-Type: multipart/mixed; boundary="===============1799203790=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1799203790==
Content-Type: multipart/alternative; boundary="00000000000085368805cff138f1"

--00000000000085368805cff138f1
Content-Type: text/plain; charset="UTF-8"

Hi Meng,

I made some improvements work inline below and pushed.

On Thu, Nov 4, 2021 at 7:26 AM tangmeng <tangmeng@uniontech.com> wrote:

> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  runtest/syscalls                        |   2 -
>  testcases/kernel/syscalls/link/link04.c | 208 +++++++++++-------------
>  testcases/kernel/syscalls/link/link06.c | 113 -------------
>  testcases/kernel/syscalls/link/link07.c | 118 --------------
>  4 files changed, 93 insertions(+), 348 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/link/link06.c
>  delete mode 100644 testcases/kernel/syscalls/link/link07.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b19316805..1e6d46744 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -673,8 +673,6 @@ link02 link02
>  link03 link03
>  link04 link04
>  link05 link05
> -link06 link06
> -link07 link07
>

And we should remove them from the .gitignore file as well.



>  link08 link08
>
>  #linkat test cases
> diff --git a/testcases/kernel/syscalls/link/link04.c
> b/testcases/kernel/syscalls/link/link04.c
> index d9408845e..9a1c32859 100644
> --- a/testcases/kernel/syscalls/link/link04.c
> +++ b/testcases/kernel/syscalls/link/link04.c
> @@ -1,65 +1,40 @@
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
> +#include <pwd.h>
>  #include <sys/param.h>
>  #include <sys/mman.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
> +
> +#define NOBODY_USER     99
> +#define MODE_TO1 S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IXOTH|S_IROTH
> +#define MODE_TO2
> S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IXGRP|S_IXOTH|S_IROTH|S_IWOTH
> +#define MODE_TE S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH
> +#define MODE_RWX        S_IRWXU | S_IRWXG | S_IRWXO
> +#define DIR_TEMP        "dir2/testdir_1"
>
>  static char longpath[PATH_MAX + 2];
>
> -struct test_case_t {
> +static struct tcase {
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
> @@ -79,92 +54,95 @@ struct test_case_t {
>         {"regfile", "regfile", NULL, "invalid address", EFAULT},
>         /* two existing files */
>         {"regfile", "regfile", "regfile2", "regfile2", EEXIST},
> +       {"dir1/oldpath", "Write access diretory", "dir1/newpath",
> "newpath", EACCES},
> +       {"dir2/testdir_1/tfile_2", "Search access diretory",
> "dir2/testdir_1/new_tfile_2",
> +       "dir2/testdir_1/new_tfile_2", EACCES},
>

Reset the layout for more readable.


>  };
>
> -char *TCID = "link04";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int ac, char **av)
> +static void verify_link(unsigned int i)
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
> +       struct tcase *tc = &tcases[i];
> +
> +       TEST(link(tc->file1, tc->file2));
> +
> +       if (TST_RET == -1) {
> +               if (TST_ERR == tc->exp_errno) {
> +                       tst_res(TPASS | TTERRNO,
> +                       "link(<%s>, <%s>)",
> +                       tc->desc1, tc->desc2);
> +       } else {
> +               tst_res(TFAIL | TTERRNO,
> +                       "link(<%s>, <%s>) Failed "
> +                       "expected errno: %d",
> +                       tc->desc1, tc->desc2,
> +                       tc->exp_errno);
>                 }
> -
> +       } else {
> +               tst_res(TFAIL,
> +                        "link(<%s>, <%s>) returned %ld, "
> +                       "expected -1, errno:%d",
> +                       tc->desc1, tc->desc2, TST_RET,
> +                       tc->exp_errno);
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
> -
>         memset(longpath, 'a', PATH_MAX+1);
> -       SAFE_TOUCH(cleanup, "regfile", 0777, NULL);
> -       SAFE_TOUCH(cleanup, "regfile2", 0777, NULL);
> -       SAFE_MKDIR(cleanup, "dir", 0777);
> -
> -       void *bad_addr = tst_get_bad_addr(cleanup);
>
> -       for (n = 0; n < TST_TOTAL; n++) {
> -               if (!test_cases[n].file1)
> -                       test_cases[n].file1 = bad_addr;
> -
> -               if (!test_cases[n].file2)
> -                       test_cases[n].file2 = bad_addr;
> +       SAFE_TOUCH("regfile", 0777, NULL);
> +       SAFE_TOUCH("regfile2", 0777, NULL);
> +       SAFE_MKDIR("dir", 0777);
> +
> +       unsigned int i;
> +       struct passwd *nobody_pwd;
> +
> +       for (i = 0; i < ARRAY_SIZE(tcases); i++) {
> +               struct tcase *tc = &tcases[i];
> +
> +               switch (tc->exp_errno) {
> +               case EACCES:
> +                       if (tc->desc1 == "Write access diretory") {
>

"==" is not a suggested way to compare strings in C programming.
We should use strcmp() for instead.



> +                               SAFE_SETEUID(0);
> +                               SAFE_MKDIR("dir1", MODE_RWX);
> +                               /* Modify mode permissions on test
> directory */
> +                               SAFE_CHMOD("dir1", MODE_TO1);
> +                               SAFE_TOUCH(tc->file1, 0777, NULL);
> +                               nobody_pwd = SAFE_GETPWNAM("nobody");
> +                               SAFE_SETEUID(nobody_pwd->pw_uid);
> +                       } else if (tc->desc1 == "Search access diretory") {
> +                               SAFE_SETEUID(0);
> +                               SAFE_MKDIR("dir2", MODE_RWX);
> +                               /* Modify mode permissions on test
> directory */
> +                               SAFE_CHMOD("dir2", MODE_TO2);
> +                               SAFE_MKDIR(DIR_TEMP, MODE_RWX);
> +                               SAFE_TOUCH(tc->file1, 0666, NULL);
> +
> +                               /* Modify mode permissions on test
> directory - test conditions */
> +                               SAFE_CHMOD(DIR_TEMP, MODE_TE);
> +                               nobody_pwd = SAFE_GETPWNAM("nobody");
> +                               SAFE_SETEUID(nobody_pwd->pw_uid);
>

I help reduce some duplicated code and move this part to the main thread.



> +                       }
> +                       break;
> +               case ENOENT:
> +               case ENOTDIR:
> +               case ENAMETOOLONG:
> +               case EFAULT:
> +               case EEXIST:
> +                       if (!tc->file1)
> +                               tc->file1 = tst_get_bad_addr(NULL);
> +
> +                       if (!tc->file2)
> +                               tc->file2 = tst_get_bad_addr(NULL);
> +                       break;
> +               }
>         }
>  }
>
> -static void cleanup(void)
> -{
> -       tst_rmdir();
> -}
> +static struct tst_test test = {
> +       .tcnt = ARRAY_SIZE(tcases),
> +       .test = verify_link,
> +       .setup = setup,
> +       .needs_tmpdir = 1,
> +       .needs_root = 1,
> +};
>

-- 
Regards,
Li Wang

--00000000000085368805cff138f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Meng,</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">I =
made some improvements work inline below and pushed.</div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 4, 20=
21 at 7:26 AM tangmeng &lt;<a href=3D"mailto:tangmeng@uniontech.com" target=
=3D"_blank">tangmeng@uniontech.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Signed-off-by: tangmeng &lt;<a href=3D"ma=
ilto:tangmeng@uniontech.com" target=3D"_blank">tangmeng@uniontech.com</a>&g=
t;<br>
---<br>
=C2=A0runtest/syscalls=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 -<br>
=C2=A0testcases/kernel/syscalls/link/link04.c | 208 +++++++++++------------=
-<br>
=C2=A0testcases/kernel/syscalls/link/link06.c | 113 -------------<br>
=C2=A0testcases/kernel/syscalls/link/link07.c | 118 --------------<br>
=C2=A04 files changed, 93 insertions(+), 348 deletions(-)<br>
=C2=A0delete mode 100644 testcases/kernel/syscalls/link/link06.c<br>
=C2=A0delete mode 100644 testcases/kernel/syscalls/link/link07.c<br>
<br>
diff --git a/runtest/syscalls b/runtest/syscalls<br>
index b19316805..1e6d46744 100644<br>
--- a/runtest/syscalls<br>
+++ b/runtest/syscalls<br>
@@ -673,8 +673,6 @@ link02 link02<br>
=C2=A0link03 link03<br>
=C2=A0link04 link04<br>
=C2=A0link05 link05<br>
-link06 link06<br>
-link07 link07<br></blockquote><div><br></div><div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">And we should remove them from the .gitignor=
e file as well.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
=C2=A0link08 link08<br>
<br>
=C2=A0#linkat test cases<br>
diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/sys=
calls/link/link04.c<br>
index d9408845e..9a1c32859 100644<br>
--- a/testcases/kernel/syscalls/link/link04.c<br>
+++ b/testcases/kernel/syscalls/link/link04.c<br>
@@ -1,65 +1,40 @@<br>
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
+#include &lt;pwd.h&gt;<br>
=C2=A0#include &lt;sys/param.h&gt;<br>
=C2=A0#include &lt;sys/mman.h&gt;<br>
-#include &quot;test.h&quot;<br>
-#include &quot;safe_macros.h&quot;<br>
+#include &quot;tst_test.h&quot;<br>
+<br>
+#define NOBODY_USER=C2=A0 =C2=A0 =C2=A099<br>
+#define MODE_TO1 S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IXOTH|S_IROTH<b=
r>
+#define MODE_TO2 S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IXGRP|S_IXOTH|S=
_IROTH|S_IWOTH<br>
+#define MODE_TE S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH<br=
>
+#define MODE_RWX=C2=A0 =C2=A0 =C2=A0 =C2=A0 S_IRWXU | S_IRWXG | S_IRWXO<br=
>
+#define DIR_TEMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dir2/testdir_1&quot;<br>
<br>
=C2=A0static char longpath[PATH_MAX + 2];<br>
<br>
-struct test_case_t {<br>
+static struct tcase {<br>
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
@@ -79,92 +54,95 @@ struct test_case_t {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;regfile&quot;, &quot;regfile&quot;, NULL=
, &quot;invalid address&quot;, EFAULT},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* two existing files */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;regfile&quot;, &quot;regfile&quot;, &quo=
t;regfile2&quot;, &quot;regfile2&quot;, EEXIST},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;dir1/oldpath&quot;, &quot;Write access d=
iretory&quot;, &quot;dir1/newpath&quot;, &quot;newpath&quot;, EACCES},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;dir2/testdir_1/tfile_2&quot;, &quot;Sear=
ch access diretory&quot;, &quot;dir2/testdir_1/new_tfile_2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;dir2/testdir_1/new_tfile_2&quot;, EACCES}=
,<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D=
"font-size:small">Reset the layout for more readable.</div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0};<br>
<br>
-char *TCID =3D &quot;link04&quot;;<br>
-int TST_TOTAL =3D ARRAY_SIZE(test_cases);<br>
-<br>
-static void setup(void);<br>
-static void cleanup(void);<br>
-<br>
-int main(int ac, char **av)<br>
+static void verify_link(unsigned int i)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcase *tc =3D &amp;tcases[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST(link(tc-&gt;file1, tc-&gt;file2));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (TST_RET =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TST_ERR =3D=3D =
tc-&gt;exp_errno) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TPASS | TTERRNO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;link(&lt;%s&gt;, &lt;%s&gt;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tc-&gt;desc1, tc-&gt;desc2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL | TTE=
RRNO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;link(&lt;%s&gt;, &lt;%s&gt;) Failed &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;expected errno: %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tc-&gt;desc1, tc-&gt;desc2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tc-&gt;exp_errno);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;link(&lt;%s&gt;, &lt;%s&gt;) returned %ld, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;expected -1, errno:%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tc-&gt;desc1, tc-&gt;desc2, TST_RET,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tc-&gt;exp_errno);<br>
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
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(longpath, &#39;a&#39;, PATH_MAX+1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(cleanup, &quot;regfile&quot;, 0777, =
NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(cleanup, &quot;regfile2&quot;, 0777,=
 NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MKDIR(cleanup, &quot;dir&quot;, 0777);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void *bad_addr =3D tst_get_bad_addr(cleanup);<b=
r>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (n =3D 0; n &lt; TST_TOTAL; n++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_cases[n].=
file1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0test_cases[n].file1 =3D bad_addr;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_cases[n].=
file2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0test_cases[n].file2 =3D bad_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(&quot;regfile&quot;, 0777, NULL);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(&quot;regfile2&quot;, 0777, NULL);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MKDIR(&quot;dir&quot;, 0777);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct passwd *nobody_pwd;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(tcases); i++) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcase *tc =
=3D &amp;tcases[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (tc-&gt;exp_=
errno) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case EACCES:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (tc-&gt;desc1 =3D=3D &quot;Write access diretory&quot;) {<br><=
/blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">&quot;=3D=3D&quot; is not a suggested way to compare strings in=
 C programming.</div></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">We should use strcmp() for instead.<br></div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SETEUID(0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MKDIR(&quot;dir1&quot;, MODE_RWX=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Modify mode permissions on test di=
rectory */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CHMOD(&quot;dir1&quot;, MODE_TO1=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(tc-&gt;file1, 0777, NULL);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nobody_pwd =3D SAFE_GETPWNAM(&quot;no=
body&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SETEUID(nobody_pwd-&gt;pw_uid);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else if (tc-&gt;desc1 =3D=3D &quot;Search access diretory&quot;=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SETEUID(0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MKDIR(&quot;dir2&quot;, MODE_RWX=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Modify mode permissions on test di=
rectory */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CHMOD(&quot;dir2&quot;, MODE_TO2=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MKDIR(DIR_TEMP, MODE_RWX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TOUCH(tc-&gt;file1, 0666, NULL);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Modify mode permissions on test di=
rectory - test conditions */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CHMOD(DIR_TEMP, MODE_TE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nobody_pwd =3D SAFE_GETPWNAM(&quot;no=
body&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SETEUID(nobody_pwd-&gt;pw_uid);<=
br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"f=
ont-size:small">I help reduce some duplicated code and move this part to th=
e main thread.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ENOENT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ENOTDIR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ENAMETOOLONG:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case EFAULT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case EEXIST:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!tc-&gt;file1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tc-&gt;file1 =3D tst_get_bad_addr(NUL=
L);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!tc-&gt;file2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tc-&gt;file2 =3D tst_get_bad_addr(NUL=
L);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-static void cleanup(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_rmdir();<br>
-}<br>
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.tcnt =3D ARRAY_SIZE(tcases),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.test =3D verify_link,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup =3D setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_tmpdir =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_root =3D 1,<br>
+};<br></blockquote></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000085368805cff138f1--


--===============1799203790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1799203790==--

