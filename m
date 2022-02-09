Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F118C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:48:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CB2E3C9BA4
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 11:48:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B7C43C0E63
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 11:48:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4635E200BAF
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 11:48:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644403681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8dB5fugHuwlQBmK79bZ+99h0o4sbZr9usI3AcTzAAs=;
 b=D4aRp3WgtNZz+l9yez+T6oq9BNdzSzBfJkj48A03B6a5Mk6LcskfMNko9S631TjVaWvtm0
 YHarKvdidUMwkDHeay4bRO5IJpPoedy7YaihuoggpOfjJHyUzVEnrUEQCLbXkaNL8JNK8M
 k9TfnM5nol6TZU4aWUckrVRaceWapX4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-yAINTtCfO8y-L_hmCsZp-Q-1; Wed, 09 Feb 2022 05:48:00 -0500
X-MC-Unique: yAINTtCfO8y-L_hmCsZp-Q-1
Received: by mail-yb1-f200.google.com with SMTP id
 j17-20020a25ec11000000b0061dabf74012so3915736ybh.15
 for <ltp@lists.linux.it>; Wed, 09 Feb 2022 02:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X8dB5fugHuwlQBmK79bZ+99h0o4sbZr9usI3AcTzAAs=;
 b=kM8uqXevBKNyocBLRvjODyuAO5jTdpeLC/O/xg47aWPmSI+JmhppRjb/qwEAfNNuY3
 yJAkYwgfCB3Sg8G2X8MZ/eTatWCcBdUh34wnJUGhi6V2WC0KP7LmrYqmfGER9voUKwqk
 0ZJH/Xx5Pa7cO7EyNLwDokHtbRt8Th0rFJ2DKOjdtn7By3HODYPRcbzKjV2Px5nOGKKL
 BsaW1DGc7yiLunGz0UhoviK8/QaCosDJXw4pEZ47t8mr9jYFuPL8FFRa9c4GmEPAJvld
 FLLfaMoHF6lDF/fGwClk1Or66r5Wxh4FkKhzCC6uuduloyCcDi9v208DiJJg1o7MGOEP
 Yctw==
X-Gm-Message-State: AOAM5302bnldS6utVc7O+MUW8FvW4k5nAaZRJiCCT1V6rLbh4qmMaZss
 hjIfrMgYZSlXp8cUXlJ//0FQaNnRcR1VIa1HZEL+I1ZIW+LjhCdzPBreRUX+fy6lWpEys/Oo46k
 CkLc27AshFGEots/zbG5g8zUe3s0=
X-Received: by 2002:a81:ed01:: with SMTP id k1mr1399250ywm.25.1644403679866;
 Wed, 09 Feb 2022 02:47:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx69aJfIjLCTm0B3NWLyhjmuJQIe6uhdu/K937FjvBc3Tms4h2ucK+RWoy9UUtJgiDs+os0lad1bQx3gvalgJs=
X-Received: by 2002:a81:ed01:: with SMTP id k1mr1399243ywm.25.1644403679660;
 Wed, 09 Feb 2022 02:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-4-rpalethorpe@suse.com>
In-Reply-To: <20220208140322.6842-4-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Feb 2022 18:47:46 +0800
Message-ID: <CAEemH2cb65kihwnkMMKSr8FRXJ_SY3jPnSxPPp-Kk_xBrJAeZw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] memcontrol04: Copy from kselftest
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
Content-Type: multipart/mixed; boundary="===============1646170887=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1646170887==
Content-Type: multipart/alternative; boundary="00000000000031a34205d7939141"

--00000000000031a34205d7939141
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 8, 2022 at 10:04 PM Richard Palethorpe via ltp <
ltp@lists.linux.it> wrote:

> At first glance this test looks the same as memcontrol03. However
> there are some significant changes which complicate combining the two.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  runtest/controllers                           |   1 +
>  testcases/kernel/controllers/memcg/.gitignore |   1 +
>  .../kernel/controllers/memcg/memcontrol04.c   | 228 ++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 testcases/kernel/controllers/memcg/memcontrol04.c
>
> diff --git a/runtest/controllers b/runtest/controllers
> index 4a6f919af..3108a2561 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -20,6 +20,7 @@ memcg_control         memcg_control_test.sh
>  memcontrol01 memcontrol01
>  memcontrol02 memcontrol02
>  memcontrol03 memcontrol03
> +memcontrol04 memcontrol04
>
>  cgroup_fj_function_debug cgroup_fj_function.sh debug
>  cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
> diff --git a/testcases/kernel/controllers/memcg/.gitignore
> b/testcases/kernel/controllers/memcg/.gitignore
> index 49df1582c..3883cede6 100644
> --- a/testcases/kernel/controllers/memcg/.gitignore
> +++ b/testcases/kernel/controllers/memcg/.gitignore
> @@ -8,3 +8,4 @@
>  memcontrol01
>  memcontrol02
>  memcontrol03
> +memcontrol04
> diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c
> b/testcases/kernel/controllers/memcg/memcontrol04.c
> new file mode 100644
> index 000000000..cdfeff4a4
> --- /dev/null
> +++ b/testcases/kernel/controllers/memcg/memcontrol04.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*\
> + *
> + * [Description]
> + *
> + * Conversion of the forth kself test in cgroup/test_memcontrol.c.
> + *
> + * Original description:
> + * "First, this test creates the following hierarchy:
> + * A       memory.low = 50M,  memory.max = 200M
> + * A/B     memory.low = 50M,  memory.current = 50M
> + * A/B/C   memory.low = 75M,  memory.current = 50M
> + * A/B/D   memory.low = 25M,  memory.current = 50M
> + * A/B/E   memory.low = 500M, memory.current = 0
> + * A/B/F   memory.low = 0,    memory.current = 50M
>

This test has a high repetition with memcontrol03, I'm just
wondering if any possibility to merge together by defining a
struct tcase?

static struct tcase {
       char *ctrl_file;
} tcases[] = {
       {"memory.min"},
       {"memory.low"}
};

-- 
Regards,
Li Wang

--00000000000031a34205d7939141
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 8, 2022 at 10:04 PM Richard Palethorpe =
via ltp &lt;<a href=3D"mailto:ltp@lists.linux.it">ltp@lists.linux.it</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">At firs=
t glance this test looks the same as memcontrol03. However<br>
there are some significant changes which complicate combining the two.<br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
---<br>
=C2=A0runtest/controllers=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0testcases/kernel/controllers/memcg/.gitignore |=C2=A0 =C2=A01 +<br>
=C2=A0.../kernel/controllers/memcg/memcontrol04.c=C2=A0 =C2=A0| 228 +++++++=
+++++++++++<br>
=C2=A03 files changed, 230 insertions(+)<br>
=C2=A0create mode 100644 testcases/kernel/controllers/memcg/memcontrol04.c<=
br>
<br>
diff --git a/runtest/controllers b/runtest/controllers<br>
index 4a6f919af..3108a2561 100644<br>
--- a/runtest/controllers<br>
+++ b/runtest/controllers<br>
@@ -20,6 +20,7 @@ memcg_control=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcg_cont=
rol_test.sh<br>
=C2=A0memcontrol01 memcontrol01<br>
=C2=A0memcontrol02 memcontrol02<br>
=C2=A0memcontrol03 memcontrol03<br>
+memcontrol04 memcontrol04<br>
<br>
=C2=A0cgroup_fj_function_debug cgroup_fj_function.sh debug<br>
=C2=A0cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset<br>
diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kern=
el/controllers/memcg/.gitignore<br>
index 49df1582c..3883cede6 100644<br>
--- a/testcases/kernel/controllers/memcg/.gitignore<br>
+++ b/testcases/kernel/controllers/memcg/.gitignore<br>
@@ -8,3 +8,4 @@<br>
=C2=A0memcontrol01<br>
=C2=A0memcontrol02<br>
=C2=A0memcontrol03<br>
+memcontrol04<br>
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/=
kernel/controllers/memcg/memcontrol04.c<br>
new file mode 100644<br>
index 000000000..cdfeff4a4<br>
--- /dev/null<br>
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c<br>
@@ -0,0 +1,228 @@<br>
+// SPDX-License-Identifier: GPL-2.0<br>
+/*\<br>
+ *<br>
+ * [Description]<br>
+ *<br>
+ * Conversion of the forth kself test in cgroup/test_memcontrol.c.<br>
+ *<br>
+ * Original description:<br>
+ * &quot;First, this test creates the following hierarchy:<br>
+ * A=C2=A0 =C2=A0 =C2=A0 =C2=A0memory.low =3D 50M,=C2=A0 memory.max =3D 20=
0M<br>
+ * A/B=C2=A0 =C2=A0 =C2=A0memory.low =3D 50M,=C2=A0 memory.current =3D 50M=
<br>
+ * A/B/C=C2=A0 =C2=A0memory.low =3D 75M,=C2=A0 memory.current =3D 50M<br>
+ * A/B/D=C2=A0 =C2=A0memory.low =3D 25M,=C2=A0 memory.current =3D 50M<br>
+ * A/B/E=C2=A0 =C2=A0memory.low =3D 500M, memory.current =3D 0<br>
+ * A/B/F=C2=A0 =C2=A0memory.low =3D 0,=C2=A0 =C2=A0 memory.current =3D 50M=
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">This test has a high=C2=A0<span style=3D"color:rgb(51,51,5=
1);font-size:14px">repetition</span>=C2=A0with memcontrol03, I&#39;m just</=
div><div class=3D"gmail_default" style=3D"font-size:small">wondering if any=
=C2=A0possibility to merge together by defining=C2=A0a=C2=A0</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">struct tcase?</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div>static struct tcase =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0char *<span class=3D"gmail_default" style=
=3D"font-size:small">ctrl_file</span>;<br>} tcases[] =3D {<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0{&quot;memory.min&quot;},<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quo=
t;memory.low&quot;}<br>};<br><div class=3D"gmail_default" style=3D"font-siz=
e:small"></div></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></=
div></div></div></div>

--00000000000031a34205d7939141--


--===============1646170887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1646170887==--

