Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918EBC433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 03:27:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A345B61107
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 03:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A345B61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 394BA3C8A1D
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 05:27:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5590B3C6F44
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 05:27:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7AD511000F52
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 05:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632194847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4q1CP07T8GnBfNfqu88W292P2RToSm7ZePefzVV3BNM=;
 b=HcMB1920nsl8fjdxIEO+/iPZKNDmrRgR5hi++igVLV+slwXgFQO4Q5mjx3PbOop45khzsM
 pNLhynEhDslrFqkYGzX47BM5gMHHq1MYMTKSVAzypRA+ROm8KCiQOnwCP4BP8STlY7Q9it
 3RdP0sL1WsMAatXaqVXvIMrzY0CvsxU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-sbFG303iMM2LJLjnkNIRfg-1; Mon, 20 Sep 2021 23:27:23 -0400
X-MC-Unique: sbFG303iMM2LJLjnkNIRfg-1
Received: by mail-qv1-f70.google.com with SMTP id
 h25-20020a0cab19000000b0037a49d15c93so208149487qvb.22
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 20:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4q1CP07T8GnBfNfqu88W292P2RToSm7ZePefzVV3BNM=;
 b=7ih1CQ5xnMG2lECbUwLJPmOPh+xy+kOMm141nqwc0Z02UkWcgt2bBZ5etrrvLMreKG
 /mImoFdlUkPRKovq/ihgtXVZSs6bjRf+AtPhbWfgjSCBvsP7D4+JOsZYMSEyD71IiWJi
 t0zWB7ytH4m0XoPs2WnqtvqIaAr6QO1LQKtOZLsrgCDHHADuausOLNmiWykpY4t+PY1L
 fPuAXkoYlTdfzBNpP4PN22eCfDoO+l+JYtniNMX2mQ+H2ahFjZsisko9CToKajQq9aGV
 4VzJzxQcsmMzAQuG/2TnGGWzP/U8MZmzCwZ01woJxQFaXkaU1gJdHPLB97JWLVOC9s3L
 9cAw==
X-Gm-Message-State: AOAM533Epm6jaMkAE+GCf4oy83wWUnnAFayvdUMQ9V60NOk4NsFXDmdo
 honLqQVVceLIhmo+Y5p3oRvT2uUAOfxb26aFtFx9q87cDM3aGamEFrizmDnCnZoUUr1pmvR3lRY
 tvZG7IBRKh2UMiKShVrRgRcnbiTo=
X-Received: by 2002:a25:7e46:: with SMTP id z67mr33827097ybc.166.1632194843153; 
 Mon, 20 Sep 2021 20:27:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJxQdEz/bDXy1s7g8jn7HOXJwtw83qkyYJDAxEZPUJL045z4ttahJaRQf7n9wmfWou0aDnuBTYW4JgQKM6kkU=
X-Received: by 2002:a25:7e46:: with SMTP id z67mr33827079ybc.166.1632194842844; 
 Mon, 20 Sep 2021 20:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210920122146.31576-1-chrubis@suse.cz>
In-Reply-To: <20210920122146.31576-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Sep 2021 11:27:10 +0800
Message-ID: <CAEemH2eRgUDNLmmzNF5cDaAXp7kMgPOBHeJeWqyStOiAq7QLHw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: shell: Fix timeout process races
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
Content-Type: multipart/mixed; boundary="===============0959462737=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0959462737==
Content-Type: multipart/alternative; boundary="000000000000cff7b805cc78f949"

--000000000000cff7b805cc78f949
Content-Type: text/plain; charset="UTF-8"

Hi Cyril,



> +++ b/testcases/lib/tst_timeout_kill.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#include <stdio.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +
> +static void print_help(const char *name)
> +{
> +       fprintf(stderr, "usage: %s timeout pid\n", name);
> +}
> +
> +#define print_msg(fmt, ...) fprintf(stderr, fmt "\n", ##__VA_ARGS__)
> +
> +int main(int argc, char *argv[])
> +{
> +       int timeout, pid, ret, i;
> +
> +       if (argc != 3) {
> +               print_help(argv[0]);
> +               return 1;
> +       }
> +
> +       timeout = atoi(argv[1]);
> +       pid = atoi(argv[2]);
> +
> +       if (timeout < 0) {
> +               fprintf(stderr, "Invalid timeout '%s'\n", argv[1]);
> +               print_help(argv[0]);
> +               return 1;
> +       }
> +
> +       if (pid <= 1) {
> +               fprintf(stderr, "Invalid pid '%s'\n", argv[2]);
> +               print_help(argv[0]);
> +               return 1;
> +       }
> +
> +       if (timeout)
> +               sleep(timeout);
> +
> +       print_msg("Test timed out, sending SIGTERM!");
> +       print_msg("If you are running on slow machine, try exporting
> LTP_TIMEOUT_MUL > 1");
> +
> +       ret = kill(-pid, SIGTERM);
>

This 'pid' is the parent shell process id, so it obviously that
tst_timeout_kill
process would get signal SIGTERM as well.

I'm thinking maybe we should let tst_timeout_kill itself ignore SIGTERM
otherwise we have no chance to perform the following double-check code?



> +       if (ret) {
> +               print_msg("kill(%i) failed: %s", -pid, strerror(errno));
> +               return 1;
> +       }
> +
> +       usleep(100000);
> +
> +       i = 10;
> +
> +       while (!kill(-pid, 0) && i-- > 0) {
>

And just check 'pid' but not '-pid' as original shell behavior?


> +               print_msg("Test is still running...");
> +               sleep(1);
> +       }
> +
> +       if (!kill(-pid, 0)) {
>

check pid, if so like that.


> +               print_msg("Test is still running, sending SIGKILL");
> +               ret = kill(-pid, SIGKILL);
> +               if (ret) {
> +                       print_msg("kill(%i) failed: %s", -pid,
> strerror(errno));
> +                       return 1;
> +               }
> +       }
> +
> +       return 0;
> +}
> --
> 2.32.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000cff7b805cc78f949
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Hi Cyril,</div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+++ b/testcases/lib/<span class=3D"gmail_default" style=3D"font-size:small"=
></span>tst_timeout_kill.c<br>
@@ -0,0 +1,75 @@<br>
+// SPDX-License-Identifier: GPL-2.0-or-later<br>
+/*<br>
+ * Copyright (c) 2021 Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" =
target=3D"_blank">chrubis@suse.cz</a>&gt;<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;signal.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+#include &lt;errno.h&gt;<br>
+#include &lt;string.h&gt;<br>
+<br>
+static void print_help(const char *name)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;usage: %s timeout pid\n&q=
uot;, name);<br>
+}<br>
+<br>
+#define print_msg(fmt, ...) fprintf(stderr, fmt &quot;\n&quot;, ##__VA_ARG=
S__)<br>
+<br>
+int main(int argc, char *argv[])<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int timeout, pid, ret, i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc !=3D 3) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_help(argv[0])=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D atoi(argv[1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pid =3D atoi(argv[2]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Invalid timeout &#39;%s&#39;\n&quot;, argv[1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_help(argv[0])=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pid &lt;=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Invalid pid &#39;%s&#39;\n&quot;, argv[2]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_help(argv[0])=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep(timeout);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0print_msg(&quot;Test timed out, sending SIGTERM=
!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0print_msg(&quot;If you are running on slow mach=
ine, try exporting LTP_TIMEOUT_MUL &gt; 1&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kill(-pid, SIGTERM);<br></blockquote><d=
iv><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Th=
is &#39;pid&#39; is the parent shell process id, so it obviously that=C2=A0=
<span class=3D"gmail_default"></span>tst_timeout_kill</div><div class=3D"gm=
ail_default" style=3D"font-size:small">process would get signal SIGTERM as =
well.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div=
><div class=3D"gmail_default" style=3D"font-size:small">I&#39;m thinking ma=
ybe we should let=C2=A0<span class=3D"gmail_default"></span>tst_timeout_kil=
l itself ignore=C2=A0SIGTERM</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">otherwise we have no chance to perform the following double-c=
heck code?</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_msg(&quot;kil=
l(%i) failed: %s&quot;, -pid, strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0usleep(100000);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D 10;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (!kill(-pid, 0) &amp;&amp; i-- &gt; 0) {<=
br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"f=
ont-size:small">And just check &#39;pid&#39; but not &#39;-pid&#39; as orig=
inal=C2=A0shell behavior?</div></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_msg(&quot;Tes=
t is still running...&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!kill(-pid, 0)) {<br></blockquote><div><spa=
n class=3D"gmail_default" style=3D"font-size:small"><br></span></div><div><=
span class=3D"gmail_default" style=3D"font-size:small">check pid, if so lik=
e that.</span></div><div><span class=3D"gmail_default" style=3D"font-size:s=
mall"></span>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_msg(&quot;Tes=
t is still running, sending SIGKILL&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kill(-pid, =
SIGKILL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0print_msg(&quot;kill(%i) failed: %s&quot;, -pid, strerror(errno))=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
-- <br>
2.32.0<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000cff7b805cc78f949--


--===============0959462737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0959462737==--

