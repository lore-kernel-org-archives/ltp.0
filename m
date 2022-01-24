Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA5BC433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 07:55:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55BCE3C84C1
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 08:55:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AEF63C6FEE
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 08:55:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E0D1D600640
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 08:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643010909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5sBodCLQ9zp29Bt92NCfpz271fD4pb+V60JMUee0XQ=;
 b=MHmyfqLer7kWOutYxR7RIj8bfne7S/Ad4HNu63HCZv2oIb3jDA8F/WTyN1YSqoqsIBksX2
 aZDB6ZgARFtQs/wOJQRsT6KoBDpjCC8vLKymJk/efjed4X59MXW4oqobH0YOelWxRTOeXV
 GQfsx9Tu8uG8rKj2c9QjLW7PP7TQf7I=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-47UvJ7QJOSmOIdtuY2H4iQ-1; Mon, 24 Jan 2022 02:55:06 -0500
X-MC-Unique: 47UvJ7QJOSmOIdtuY2H4iQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 v70-20020a25c549000000b006130de5790aso33260375ybe.4
 for <ltp@lists.linux.it>; Sun, 23 Jan 2022 23:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O5sBodCLQ9zp29Bt92NCfpz271fD4pb+V60JMUee0XQ=;
 b=18OGfY24zkx2Ynccq2/3DAobLBw2YwqG8pm7INT22vwXBGwtsqBdYHdEDVMdUWs7YE
 pLx5VhkhCcysK2PnML0TjGXwIKa7aXu9/amDSst49nfr4qZ5FlA+oduEyPYWwF90G762
 fP0W9t/tTTN+iApNibPgVTb5c93Vjm2tPmpCZVvL3qdW/JYfZbYRBr1DEmpPNwTAsmcP
 BWIkcYch2V6u3AusQdXU/OITI3USh3g0kOWhMtC7D52PdSKYfmIJl/35VHGLb6eXEbvw
 qhERBAmfbrmuTtw6UWw0S0J7VZ77o8HbTaBqqiGaiZB/rJWVHcMjFC+nx+baCPMEjyHO
 QFxg==
X-Gm-Message-State: AOAM531eK/7hIsNvQEfpFjTNYmHj+BHb1C3FTBiVd5FI2+ZJ4znum6Y6
 o1HzoRXYjgi7UreyHM1rqTfZqk2MoIQ5YHFT2G258tK+ZT22Yvs5iriHQoi493qO9SYj5l7DbWD
 CasyNdWFlpDqsOop8nTGQpiWbdug=
X-Received: by 2002:a25:15c3:: with SMTP id 186mr22700230ybv.71.1643010905902; 
 Sun, 23 Jan 2022 23:55:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZV46sfR3eZrqO28ZzAiwnLKrEKcb1nrrxYvGIdpsldwJdUV8CRUMqhKaQpqH988jbIUPxIeuE2ga5ByAv6IE=
X-Received: by 2002:a25:15c3:: with SMTP id 186mr22700220ybv.71.1643010905677; 
 Sun, 23 Jan 2022 23:55:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <631e84014f8c9ad23cc634f6de8770998833286a.1642601554.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <631e84014f8c9ad23cc634f6de8770998833286a.1642601554.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jan 2022 15:54:52 +0800
Message-ID: <CAEemH2eUUfGLFqxhihdX_pncuHP0bkvHJJxPbVUSJOXwALcsyg@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 07/16] testcases/lib: Implement tst_cgctl binary
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
Content-Type: multipart/mixed; boundary="===============0645449545=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0645449545==
Content-Type: multipart/alternative; boundary="000000000000653b0105d64f49f9"

--000000000000653b0105d64f49f9
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 19, 2022 at 10:44 PM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:
>
> Implement a binary utility that creates an interface to make calls to
> the cgroup C API.
>
> This will effectively allow shell scripts to make calls to the cgroup C
> api.
>
> Signed-off-by: Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com>
> ---
>  testcases/lib/Makefile    |  2 +-
>  testcases/lib/tst_cgctl.c | 69 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/lib/tst_cgctl.c
>
> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index f2de0c832..f4f8c8524 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -12,6 +12,6 @@ MAKE_TARGETS          := tst_sleep tst_random
tst_checkpoint tst_rod tst_kvcmp\
>                            tst_device tst_net_iface_prefix
tst_net_ip_prefix tst_net_vars\
>                            tst_getconf tst_supported_fs tst_check_drivers
tst_get_unused_port\
>                            tst_get_median tst_hexdump tst_get_free_pids
tst_timeout_kill\
> -                          tst_check_kconfigs
> +                          tst_check_kconfigs tst_cgctl
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/tst_cgctl.c b/testcases/lib/tst_cgctl.c
> new file mode 100644
> index 000000000..a6cf88f41
> --- /dev/null
> +++ b/testcases/lib/tst_cgctl.c
> @@ -0,0 +1,69 @@

We need to add SPDX-License-Identifier and copyright for this file.

And better to use Tabs (8 characters) instead of 4 spaces for the code
indentation:).
See:
https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation

> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include "tst_cgroup.h"
> +
> +static int cgctl_require(const char *ctrl, int test_pid)
> +{
> +    struct tst_cgroup_opts opts;
> +
> +    memset(&opts, 0, sizeof(opts));
> +    opts.test_pid = test_pid;
> +
> +    tst_cgroup_require(ctrl, &opts);
> +    tst_cgroup_print_config();
> +
> +    return 0;
> +}
> +
> +static int cgctl_cleanup(const char *config)
> +{
> +    tst_cgroup_scan();
> +    tst_cgroup_load_config(config);
> +    tst_cgroup_cleanup();
> +
> +    return 0;
> +}
> +
> +static int cgctl_print(void)
> +{
> +    tst_cgroup_scan();
> +    tst_cgroup_print_config();
> +
> +    return 0;
> +}
> +
> +static int cgctl_process_cmd(int argc, char *argv[])
> +{
> +    int test_pid;
> +    const char *cmd_name = argv[1];
> +
> +    if (!strcmp(cmd_name, "require")) {
> +        test_pid = atoi(argv[3]);
> +        if (!test_pid) {
> +            fprintf(stderr, "tst_cgctl: Invalid test_pid '%s' given\n",
> +                    argv[3]);
> +            return 1;
> +        }
> +        return cgctl_require(argv[2], test_pid);
> +    } else if (!strcmp(cmd_name, "cleanup")) {
> +        return cgctl_cleanup(argv[2]);
> +    } else if (!strcmp(cmd_name, "print")) {
> +        return cgctl_print();
> +    }
> +
> +    fprintf(stderr, "tst_cgctl: Unknown command '%s' given\n", cmd_name);
> +    return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    if (argc < 2 || argc > 4) {
> +        fprintf(stderr, "tst_cgctl: Invalid number of arguements given");
> +        return 1;
> +    }

It'd be great to have a help() function to print the usage.
Something maybe looks like:

Usage: ./tst_cgctl  require|print|cleanup  ...

  # cgroup_state=$(./tst_cgctl require "$ctrl" "$pid")
  # echo "$cgroup_state"  # to print detailed controllers
  # tst_cgctl cleanup "$cgroup_state"


> +
> +    return cgctl_process_cmd(argc, argv);
> +}
> --
> 2.32.0
>


--
Regards,
Li Wang

--000000000000653b0105d64f49f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Jan 19, 2022 at 10:44 PM Luke Nowakowski-K=
rijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=
=3D"_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br>&gt;<br>=
&gt; Implement a binary utility that creates an interface to make calls to<=
br>&gt; the cgroup C API.<br>&gt;<br>&gt; This will effectively allow shell=
 scripts to make calls to the cgroup C<br>&gt; api.<br>&gt;<br>&gt; Signed-=
off-by: Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijge=
r@canonical.com" target=3D"_blank">luke.nowakowskikrijger@canonical.com</a>=
&gt;<br>&gt; ---<br>&gt; =C2=A0testcases/lib/Makefile =C2=A0 =C2=A0| =C2=A0=
2 +-<br>&gt; =C2=A0testcases/lib/tst_cgctl.c | 69 +++++++++++++++++++++++++=
++++++++++++++<br>&gt; =C2=A02 files changed, 70 insertions(+), 1 deletion(=
-)<br>&gt; =C2=A0create mode 100644 testcases/lib/tst_cgctl.c<br>&gt;<br>&g=
t; diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile<br>&gt; ind=
ex f2de0c832..f4f8c8524 100644<br>&gt; --- a/testcases/lib/Makefile<br>&gt;=
 +++ b/testcases/lib/Makefile<br>&gt; @@ -12,6 +12,6 @@ MAKE_TARGETS =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0:=3D tst_sleep tst_random tst_checkpoint tst_ro=
d tst_kvcmp\<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_device tst_net_iface_prefi=
x tst_net_ip_prefix tst_net_vars\<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_getco=
nf tst_supported_fs tst_check_drivers tst_get_unused_port\<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0tst_get_median tst_hexdump tst_get_free_pids tst_timeout_k=
ill\<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_check_kconfigs<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tst_check_kconfigs tst_cgctl<br>&gt;<br>&gt; =C2=A0include $(top_srcdir)=
/include/mk/<a href=3D"http://generic_leaf_target.mk" target=3D"_blank">gen=
eric_leaf_target.mk</a><br>&gt; diff --git a/testcases/lib/tst_cgctl.c b/te=
stcases/lib/tst_cgctl.c<br>&gt; new file mode 100644<br>&gt; index 00000000=
0..a6cf88f41<br>&gt; --- /dev/null<br>&gt; +++ b/testcases/lib/tst_cgctl.c<=
br>&gt; @@ -0,0 +1,69 @@<br><br>We need to add SPDX-License-Identifier and =
copyright for this file.<br><br>And better to use Tabs (8 characters) inste=
ad of 4 spaces for the code indentation:).<div><div>See:<a href=3D"https://=
www.kernel.org/doc/html/latest/process/coding-style.html#indentation" targe=
t=3D"_blank"> https://www.kernel.org/doc/html/latest/process/coding-style.h=
tml#indentation</a><br><br>&gt; +#include &lt;stdio.h&gt;<br>&gt; +#include=
 &lt;string.h&gt;<br>&gt; +#include &lt;stdlib.h&gt;<br>&gt; +#include &lt;=
stdint.h&gt;<br>&gt; +#include &lt;unistd.h&gt;<br>&gt; +#include &quot;tst=
_cgroup.h&quot;<br>&gt; +<br>&gt; +static int cgctl_require(const char *ctr=
l, int test_pid)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0struct tst_cgroup_opts o=
pts;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0memset(&amp;opts, 0, sizeof(opts));<b=
r>&gt; + =C2=A0 =C2=A0opts.test_pid =3D test_pid;<br>&gt; +<br>&gt; + =C2=
=A0 =C2=A0tst_cgroup_require(ctrl, &amp;opts);<br>&gt; + =C2=A0 =C2=A0tst_c=
group_print_config();<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return 0;<br>&gt; +}=
<br>&gt; +<br>&gt; +static int cgctl_cleanup(const char *config)<br>&gt; +{=
<br>&gt; + =C2=A0 =C2=A0tst_cgroup_scan();<br>&gt; + =C2=A0 =C2=A0tst_cgrou=
p_load_config(config);<br>&gt; + =C2=A0 =C2=A0tst_cgroup_cleanup();<br>&gt;=
 +<br>&gt; + =C2=A0 =C2=A0return 0;<br>&gt; +}<br>&gt; +<br>&gt; +static in=
t cgctl_print(void)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0tst_cgroup_scan();<br=
>&gt; + =C2=A0 =C2=A0tst_cgroup_print_config();<br>&gt; +<br>&gt; + =C2=A0 =
=C2=A0return 0;<br>&gt; +}<br>&gt; +<br>&gt; +static int cgctl_process_cmd(=
int argc, char *argv[])<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0int test_pid;<br>=
&gt; + =C2=A0 =C2=A0const char *cmd_name =3D argv[1];<br>&gt; +<br>&gt; + =
=C2=A0 =C2=A0if (!strcmp(cmd_name, &quot;require&quot;)) {<br>&gt; + =C2=A0=
 =C2=A0 =C2=A0 =C2=A0test_pid =3D atoi(argv[3]);<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!test_pid) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0fprintf(stderr, &quot;tst_cgctl: Invalid test_pid &#39;%s&#39; given\=
n&quot;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0argv[3]);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn 1;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return cgctl_require(argv[2], test_pid);<br>&gt; + =C2=A0 =C2=A0}=
 else if (!strcmp(cmd_name, &quot;cleanup&quot;)) {<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return cgctl_cleanup(argv[2]);<br>&gt; + =C2=A0 =C2=A0} else =
if (!strcmp(cmd_name, &quot;print&quot;)) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return cgctl_print();<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =
=C2=A0 =C2=A0fprintf(stderr, &quot;tst_cgctl: Unknown command &#39;%s&#39; =
given\n&quot;, cmd_name);<br>&gt; + =C2=A0 =C2=A0return 1;<br>&gt; +}<br>&g=
t; +<br>&gt; +int main(int argc, char *argv[])<br>&gt; +{<br>&gt; + =C2=A0 =
=C2=A0if (argc &lt; 2 || argc &gt; 4) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fprintf(stderr, &quot;tst_cgctl: Invalid number of arguements given&quot=
;);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>&gt; + =C2=A0 =C2=A0}=
</div><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">It&#39;d be great to have a help() function to print the usage.</div>=
<div class=3D"gmail_default" style=3D"font-size:small">Something maybe look=
s like:=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">Usage: ./ts=
t_cgctl=C2=A0 require|print|cleanup=C2=A0 ...</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 # cgroup_state=3D$(./tst_cgctl require &quot;$c=
trl&quot; &quot;$pid&quot;)</div><div class=3D"gmail_default" style=3D"font=
-size:small">=C2=A0 # echo &quot;$cgroup_state&quot;=C2=A0 # to print detai=
led controllers<br></div><div class=3D"gmail_default" style=3D"font-size:sm=
all">=C2=A0 # tst_cgctl cleanup &quot;$cgroup_state&quot;</div><br></div><d=
iv><br>&gt; +<br>&gt; + =C2=A0 =C2=A0return cgctl_process_cmd(argc, argv);<=
br>&gt; +}<br>&gt; --<br>&gt; 2.32.0<br>&gt;<br><br><br>--<br>Regards,<br>L=
i Wang</div></div></div>

--000000000000653b0105d64f49f9--


--===============0645449545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0645449545==--

