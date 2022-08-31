Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9197ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 06:41:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 895ED3CA6F9
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 08:41:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED9FD3CA43F
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 08:41:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8A0F1400DD1
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 08:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661928058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=442nH4etWdEqWgH+UFwrtOaNt5n8laxzOGwVkU89ZRU=;
 b=Kj2aUsGeQV2Qt8ScfFlHMvmm9VwNp3EUGBVbIPcFQZ5iFaySAzbafnm9OFq1mv8nGeKsWY
 uh5XYmc3G30l7axTKSjVnYvvwiu9vDEXlwicrFdssqEWVd+AhdD7m4df9HjFE2LT9MbLQu
 oSujdUlAsq/P9zmslbWeYqWrW9Nh29k=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-AyjTJ14sPculnY6hxgKgew-1; Wed, 31 Aug 2022 02:40:56 -0400
X-MC-Unique: AyjTJ14sPculnY6hxgKgew-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-3328a211611so195544537b3.5
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 23:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=xoeHmw1pqPJA9lFjVbNZpbfVu1ZGeisI6cJpDqKDL5o=;
 b=maJD1LHpc2HgI/G/OzR7gY1pYGBSUYnmx7ckNxE5NhI5EVA9ZEinkg3IfW1QpHkY8p
 Q82+ZA63xQi1nXlq6Q3PG95xBZvUuUmvu6pEvkedDeQ1nFNkVk9oKZQqcwwHiYvFqTdH
 74ZOPN85U3erVR/9dFyWEzYnwdQMzwwGDV5rMlp5VI1ToCVmlgskx3b6KemC8H/IhKEH
 PhvpEpDJRIG2meHCnOVlI7LQB9D4c+jCMeLMKrDvH8dW9ct113xOgSLf35j3RoGlDAOj
 kt2uxla9C5VZJZ+d6aq0sTIZXF1CzHDR7QtokPg3862FiUrtBtPh90LFWbZcKZXrYiXv
 id3Q==
X-Gm-Message-State: ACgBeo35DDdrkyzXQNGt6/xvxn4cLZitTjX0eqEBYpZO9FfdLjeKZOjx
 cOVhRhfPU9HVETBql2DPMCieVEfIEJzMAHzq1snWFYTiPDAkzVJbg3A71CBa4vQS4Qd99iZ5hMY
 sb60zUpgoMYlUGWwHJhvZgQU3kts=
X-Received: by 2002:a81:5442:0:b0:32e:ff06:bf10 with SMTP id
 i63-20020a815442000000b0032eff06bf10mr17400630ywb.424.1661928055729; 
 Tue, 30 Aug 2022 23:40:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6qHaasxQQmtDqr9Sa8HSmstex8ZMaYfZg3CqHr+Vd5E6yqwy6zUXgcHI3echHk8yVrPT7uXGK+qmii//YfAEE=
X-Received: by 2002:a81:5442:0:b0:32e:ff06:bf10 with SMTP id
 i63-20020a815442000000b0032eff06bf10mr17400617ywb.424.1661928055463; Tue, 30
 Aug 2022 23:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220830105418.15966-1-akumar@suse.de>
In-Reply-To: <20220830105418.15966-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 31 Aug 2022 14:40:44 +0800
Message-ID: <CAEemH2eLoJwm_+ORaoT7xamtqvLTekN7H7NWmU-ErXPMdK+77w@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getsid02.c: Rewrite using new LTP API
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
Content-Type: multipart/mixed; boundary="===============0286884427=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0286884427==
Content-Type: multipart/alternative; boundary="0000000000006379c305e783c768"

--0000000000006379c305e783c768
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 30, 2022 at 6:54 PM Avinesh Kumar <akumar@suse.de> wrote:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/getsid/getsid02.c | 83 +++++----------------
>  1 file changed, 17 insertions(+), 66 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getsid/getsid02.c
> b/testcases/kernel/syscalls/getsid/getsid02.c
> index b5ab339e2..c235af362 100644
> --- a/testcases/kernel/syscalls/getsid/getsid02.c
> +++ b/testcases/kernel/syscalls/getsid/getsid02.c
> @@ -1,81 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
>   *   Copyright (c) International Business Machines  Corp., 2001
>   *   Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>
> -#define _GNU_SOURCE 1
> -
> -#include "test.h"
> -
> -#include <errno.h>
> +/*\
> + * [Description]
> + *
> + * Verify that getsid(2) fails with ESRCH errno when there is no
> + * process found with process ID pid.
> + */
>
> -char *TCID = "getsid02";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
>
>  static pid_t unused_pid;
>
> -static void cleanup(void);
> -static void setup(void);
> -
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -       int lc;
> -
> -       tst_parse_opts(ac, av, NULL, NULL);
> -
> -       setup();
> -
> -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> -               tst_count = 0;
> -
> -               TEST(getsid(unused_pid));
> -
> -               if (TEST_RETURN == 0) {
> -                       tst_resm(TFAIL, "call succeed when failure
> expected");
> -                       continue;
> -               }
> -
> -               switch (TEST_ERRNO) {
> -               case ESRCH:
> -                       tst_resm(TPASS, "expected failure - errno = %d -
> %s",
> -                                TEST_ERRNO, strerror(TEST_ERRNO));
> -                       break;
> -               default:
> -                       tst_resm(TFAIL, "call failed to produce "
> -                                "expected error - errno = %d - %s",
> -                                TEST_ERRNO, strerror(TEST_ERRNO));
> -                       break;
> -               }
> -       }
> -
> -       cleanup();
> -       tst_exit();
> +       unused_pid = tst_get_unused_pid();
>

We can simply move this to the main function to avoid unused PID
reusing again if people perform test with '-i N'.

How about this below:

#include "tst_test.h"

static void run(void)
{
    pid_t unused_pid;
    unused_pid = tst_get_unused_pid();

    TST_EXP_FAIL(getsid(unused_pid), ESRCH);
}

static struct tst_test test = {
    .test_all = run
};

-- 
Regards,
Li Wang

--0000000000006379c305e783c768
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Aug 30, 2022 at 6:54 PM Avinesh Kumar &lt;<=
a href=3D"mailto:akumar@suse.de">akumar@suse.de</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Avinesh Kumar=
 &lt;<a href=3D"mailto:akumar@suse.de" target=3D"_blank">akumar@suse.de</a>=
&gt;<br>
---<br>
=C2=A0testcases/kernel/syscalls/getsid/getsid02.c | 83 +++++---------------=
-<br>
=C2=A01 file changed, 17 insertions(+), 66 deletions(-)<br>
<br>
diff --git a/testcases/kernel/syscalls/getsid/getsid02.c b/testcases/kernel=
/syscalls/getsid/getsid02.c<br>
index b5ab339e2..c235af362 100644<br>
--- a/testcases/kernel/syscalls/getsid/getsid02.c<br>
+++ b/testcases/kernel/syscalls/getsid/getsid02.c<br>
@@ -1,81 +1,32 @@<br>
+// SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0/*<br>
- *<br>
=C2=A0 *=C2=A0 =C2=A0Copyright (c) International Business Machines=C2=A0 Co=
rp., 2001<br>
=C2=A0 *=C2=A0 =C2=A0Copyright (c) 2012 Cyril Hrubis &lt;<a href=3D"mailto:=
chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt;<br>
- *<br>
- *=C2=A0 =C2=A0This program is free software;=C2=A0 you can redistribute i=
t and/or modify<br>
- *=C2=A0 =C2=A0it under the terms of the GNU General Public License as pub=
lished by<br>
- *=C2=A0 =C2=A0the Free Software Foundation; either version 2 of the Licen=
se, or<br>
- *=C2=A0 =C2=A0(at your option) any later version.<br>
- *<br>
- *=C2=A0 =C2=A0This program is distributed in the hope that it will be use=
ful,<br>
- *=C2=A0 =C2=A0but WITHOUT ANY WARRANTY;=C2=A0 without even the implied wa=
rranty of<br>
- *=C2=A0 =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 =
See<br>
- *=C2=A0 =C2=A0the GNU General Public License for more details.<br>
- *<br>
- *=C2=A0 =C2=A0You should have received a copy of the GNU General Public L=
icense<br>
- *=C2=A0 =C2=A0along with this program;=C2=A0 if not, write to the Free So=
ftware<br>
- *=C2=A0 =C2=A0Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, =
MA 02110-1301 USA<br>
+ *=C2=A0 =C2=A0Copyright (c) 2022 SUSE LLC Avinesh Kumar &lt;<a href=3D"ma=
ilto:avinesh.kumar@suse.com" target=3D"_blank">avinesh.kumar@suse.com</a>&g=
t;<br>
=C2=A0 */<br>
<br>
-#define _GNU_SOURCE 1<br>
-<br>
-#include &quot;test.h&quot;<br>
-<br>
-#include &lt;errno.h&gt;<br>
+/*\<br>
+ * [Description]<br>
+ *<br>
+ * Verify that getsid(2) fails with ESRCH errno when there is no<br>
+ * process found with process ID pid.<br>
+ */<br>
<br>
-char *TCID =3D &quot;getsid02&quot;;<br>
-int TST_TOTAL =3D 1;<br>
+#include &quot;tst_test.h&quot;<br>
<br>
=C2=A0static pid_t unused_pid;<br>
<br>
-static void cleanup(void);<br>
-static void setup(void);<br>
-<br>
-int main(int ac, char **av)<br>
+static void setup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int lc;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_parse_opts(ac, av, NULL, NULL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0setup();<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (lc =3D 0; TEST_LOOPING(lc); lc++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_count =3D 0;<br=
>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEST(getsid(unused_=
pid));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TEST_RETURN =3D=
=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_resm(TFAIL, &quot;call succeed when failure expected&quot;);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (TEST_ERRNO)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ESRCH:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_resm(TPASS, &quot;expected failure - errno =3D %d - %s&quot;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST_ERRNO, strerror(TEST_ERRNO));<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_resm(TFAIL, &quot;call failed to produce &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;expected error - errno =3D %d =
- %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST_ERRNO, strerror(TEST_ERRNO));<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_exit();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unused_pid =3D tst_get_unused_pid();<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">We can simply move this to the main function to avoid unused PID</div=
><div class=3D"gmail_default" style=3D"font-size:small">reusing again if pe=
ople perform test with &#39;-i N&#39;.</div><br></div><div><div class=3D"gm=
ail_default" style=3D"font-size:small">How about this below:</div><br></div=
><div><div class=3D"gmail_default" style=3D"font-size:small">#include &quot=
;tst_test.h&quot;</div><br>static void run(void)<br>{<br>=09<span class=3D"=
gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 </span>pid_t unused_=
pid;<br>=09<span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =
=C2=A0 </span>unused_pid =3D tst_get_unused_pid();<br><br>=09<span class=3D=
"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 </span>TST_EXP_FAIL=
(getsid(unused_pid), ESRCH);<br>}<br><br>static struct tst_test test =3D {<=
br>=09<span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0=
 </span>.test_all =3D run<br>};<br><div class=3D"gmail_default" style=3D"fo=
nt-size:small"></div></div></div><div><br></div>-- <br><div dir=3D"ltr" cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang=
<br></div></div></div></div>

--0000000000006379c305e783c768--


--===============0286884427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0286884427==--

