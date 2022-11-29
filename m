Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E33FC4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 04:18:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF22E3CAD42
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 05:18:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40E6E3C6D0A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 05:17:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3973960007C
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 05:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669695475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPELbNC8cvY4vngw7SIppLZcPbq+bnCSDvzArgjsK/w=;
 b=XnajKTBPgXutE2WKvPvfP3BNEU9FrIDtB1FmMxruf8wXTjF/eAuW4qkRg+cic708g0417v
 pP1CEonaDWTk0PN8pfPnAUjEx4Zh9agsAeivXV4fIGx9HYtAslzYewrnaQeV8V+Z20w6Wy
 8koCY/4kpNfl+xWhSAOfkW3EBhRz7tM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-ufe1GiowOyaDuGY_QWB--Q-1; Mon, 28 Nov 2022 23:17:50 -0500
X-MC-Unique: ufe1GiowOyaDuGY_QWB--Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 k1-20020adfb341000000b0024215e0f486so1241558wrd.21
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 20:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KPELbNC8cvY4vngw7SIppLZcPbq+bnCSDvzArgjsK/w=;
 b=qAT96wt5CGYyGXgUTnq5I2ORZ6iMsUw+K7F1jOiJMhIqS0myjnZVM7OzTs7et4BoOl
 ir2nNyU4JiBXw7njsvVlLPW03Pypf9/NZjHfuQl5SgKTV8tLg51Zb946DD7xC9ESjB3G
 4GssX+lNbjwNA6wp153vP86MQ251rdmbV1q5cnG6csFreVtcjs9Ie3zJoKAnlmtKS/2T
 P0BN6lvpyV43Bu08T9E80vcBtDtR56Lk3n1o4Ie+uYrIk7vuSFMWhQpBaUpw4tcciJLc
 Vg1XgdkzRv+AGrpwsTyB2zN+3hsl9t0YE/67YE5F86nYI1RO4RM7dcBMuFitRG48Ityh
 /LSg==
X-Gm-Message-State: ANoB5plxVlE3HP6EvjVDyDiY4rpCQ+ZPuV/cZ2rKGV8JD26Vu6Tw8NuS
 5AWfzd9nnXCHAbGLUw0x7vdFfUJ4PaSWK8Wa9tzTcLtDC99WdZztXzW2HlDJtWkCvdar0mHeufB
 J6KDKkKOqWbk/sbHzITXO4chPHZU=
X-Received: by 2002:adf:f011:0:b0:241:c78c:3671 with SMTP id
 j17-20020adff011000000b00241c78c3671mr27777657wro.129.1669695469215; 
 Mon, 28 Nov 2022 20:17:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6SwZ7m2aKFn+Xnhoy2o+9ne7XChaoI668ly6jtRaKHSIsKqugzaE8fLYBB+lfMd0xjQveSHl8XoUtHXep+VjY=
X-Received: by 2002:adf:f011:0:b0:241:c78c:3671 with SMTP id
 j17-20020adff011000000b00241c78c3671mr27777646wro.129.1669695468962; Mon, 28
 Nov 2022 20:17:48 -0800 (PST)
MIME-Version: 1.0
References: <1669688917-1997-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1669688917-1997-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Nov 2022 12:17:37 +0800
Message-ID: <CAEemH2evVQG7tVnn-TL20ii28YgpPLDXyjwLc-qEdn4FC-veww@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/namespace_constants.h: Add CLONE_NEWCGROUP
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
Content-Type: multipart/mixed; boundary="===============1671386552=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1671386552==
Content-Type: multipart/alternative; boundary="0000000000004f9b6c05ee9445d8"

--0000000000004f9b6c05ee9445d8
Content-Type: text/plain; charset="UTF-8"

Merged, thanks!

On Tue, Nov 29, 2022 at 9:28 AM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:

> This fix undefined CLONE_NEWCGROUP problem on centos7.
>
> Fixes: 5f2a365da ("cgroup_core02: copy from kernel selftest
> test_cgcore_lesser_ns_open")
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> I have verified it on my ltp fork[1]
> [1]
> https://github.com/xuyang0410/ltp/actions/runs/3570059301/jobs/6000664209
>  include/lapi/namespaces_constants.h                 | 3 +++
>  testcases/kernel/controllers/cgroup/cgroup_core02.c | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/lapi/namespaces_constants.h
> b/include/lapi/namespaces_constants.h
> index 447f16c5b..e34b0d6a8 100644
> --- a/include/lapi/namespaces_constants.h
> +++ b/include/lapi/namespaces_constants.h
> @@ -21,6 +21,9 @@
>  #ifndef CLONE_NEWUSER
>  #  define CLONE_NEWUSER        0x10000000
>  #endif
> +#ifndef CLONE_NEWCGROUP
> +#  define CLONE_NEWCGROUP 0x02000000
> +#endif
>  #ifndef CLONE_NEWUTS
>  #  define CLONE_NEWUTS 0x04000000
>  #endif
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c
> b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> index 0dff71eea..e6d599b36 100644
> --- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> @@ -31,6 +31,7 @@
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_file_at.h"
> +#include "lapi/namespaces_constants.h"
>
>  static struct tst_cg_group *cg_child_a, *cg_child_b;
>  static uid_t nobody_uid;
> --
> 2.23.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000004f9b6c05ee9445d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Merged, thanks!</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 29, 2022 at 9:28 AM Yang Xu =
&lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
his fix undefined CLONE_NEWCGROUP problem on centos7.<br>
<br>
Fixes: 5f2a365da (&quot;cgroup_core02: copy from kernel selftest test_cgcor=
e_lesser_ns_open&quot;)<br>
Signed-off-by: Yang Xu &lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com" tar=
get=3D"_blank">xuyang2018.jy@fujitsu.com</a>&gt;<br>
---<br>
I have verified it on my ltp fork[1]<br>
[1]<a href=3D"https://github.com/xuyang0410/ltp/actions/runs/3570059301/job=
s/6000664209" rel=3D"noreferrer" target=3D"_blank">https://github.com/xuyan=
g0410/ltp/actions/runs/3570059301/jobs/6000664209</a><br>
=C2=A0include/lapi/namespaces_constants.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 +++<br>
=C2=A0testcases/kernel/controllers/cgroup/cgroup_core02.c | 1 +<br>
=C2=A02 files changed, 4 insertions(+)<br>
<br>
diff --git a/include/lapi/namespaces_constants.h b/include/lapi/namespaces_=
constants.h<br>
index 447f16c5b..e34b0d6a8 100644<br>
--- a/include/lapi/namespaces_constants.h<br>
+++ b/include/lapi/namespaces_constants.h<br>
@@ -21,6 +21,9 @@<br>
=C2=A0#ifndef CLONE_NEWUSER<br>
=C2=A0#=C2=A0 define CLONE_NEWUSER=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10000000<br=
>
=C2=A0#endif<br>
+#ifndef CLONE_NEWCGROUP<br>
+#=C2=A0 define CLONE_NEWCGROUP 0x02000000<br>
+#endif<br>
=C2=A0#ifndef CLONE_NEWUTS<br>
=C2=A0#=C2=A0 define CLONE_NEWUTS 0x04000000<br>
=C2=A0#endif<br>
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcase=
s/kernel/controllers/cgroup/cgroup_core02.c<br>
index 0dff71eea..e6d599b36 100644<br>
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c<br>
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c<br>
@@ -31,6 +31,7 @@<br>
=C2=A0#include &lt;pwd.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_safe_file_at.h&quot;<br>
+#include &quot;lapi/namespaces_constants.h&quot;<br>
<br>
=C2=A0static struct tst_cg_group *cg_child_a, *cg_child_b;<br>
=C2=A0static uid_t nobody_uid;<br>
-- <br>
2.23.0<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000004f9b6c05ee9445d8--


--===============1671386552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1671386552==--

