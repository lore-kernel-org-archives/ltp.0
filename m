Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A9BC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 07:17:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A883C87C6
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 08:16:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F8783C87C6
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 08:16:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 80414600A78
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 08:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644304604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nNwZlIuE/Ou7gtkOM+gzbvUvsPvYEHwtQOaoVxEqWk=;
 b=XKp0PbpXBAd2izQf39nWm8qEgu4qVrX2XRRync1uyCO6+ZQr3F39NjyRur3fqRafYqkRlg
 mWDPUK75hQDV1TXnZtVTufdFrqE3BG4a9dDmRg6VJcO7qTFvrrkMf8Ss2sXf9xiznLu6L8
 36BouLyg3liLxZ8Ur5vc8qYOPQYtiSg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-LBOUannZOY-NGpo-5k3CZQ-1; Tue, 08 Feb 2022 02:16:43 -0500
X-MC-Unique: LBOUannZOY-NGpo-5k3CZQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 f32-20020a25b0a0000000b0061dad37dcd6so11166970ybj.16
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 23:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5nNwZlIuE/Ou7gtkOM+gzbvUvsPvYEHwtQOaoVxEqWk=;
 b=lgF6BJJLuralzOCRlHZDdhKKq/cHfhMwqCwV5kXISZb+Q+X7eiD5kLwnl86ob0ufF7
 CMwa3eG0ZaV3YWFg1PdDf6amn8VlQksLac8tUd+UdVapkWgWUKhEWCqPJk7rPjqrG9Sq
 LI7Xt2EQK7AIqouzDWAjrDWyVZ60YnfiVJLCKFtJJAuXb1mYoD+ikAiqUeLEfKRIDkky
 TKlV1U2O79TaHRFfUy00euz/tTCfjDxZiMtWNtIQn8U7qzwlkDRiqg+CTei44PQnpfIV
 DaucQTyDUj+YnpswUfuhuq2TnSbuEv+bnKjamKBlIAv5XYqnheG9TvKXl6Zk/8QGH57T
 v/6A==
X-Gm-Message-State: AOAM530SVd2IwbeckA8shqlR4G2ND9JZ3yZ6KaBN6sgXIU5CgpD048eF
 Wok/geepB0yHyje01tfOXWaz/slbbduUIrE0AXpVUshvYWpnYbF6vASOSeYHqeg90r3+AUVa0LC
 cTnIn30qfCkxHKylH8RcTWJuUGuw=
X-Received: by 2002:a25:45:: with SMTP id 66mr1861056yba.102.1644304603053;
 Mon, 07 Feb 2022 23:16:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPbvP5Xq3wkYUMaIKuXTgN9ZwjtZ9q4m7dlu0Ztn4aIkAJhMjB5NlIuZvVRCS4VF3oYfuC+qAGhOMMfDdYIpQ=
X-Received: by 2002:a25:45:: with SMTP id 66mr1861031yba.102.1644304602703;
 Mon, 07 Feb 2022 23:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20220207141618.2844-1-rpalethorpe@suse.com>
 <20220207141618.2844-3-rpalethorpe@suse.com>
In-Reply-To: <20220207141618.2844-3-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 15:16:29 +0800
Message-ID: <CAEemH2d-K=X0aodrLV=4AiVE-GWDkHv3+Rxf_NUq8btH=jF77A@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/5] API/cgroup: Declare required controllers
 and version in test struct
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
Content-Type: multipart/mixed; boundary="===============0722507768=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0722507768==
Content-Type: multipart/alternative; boundary="000000000000bf3ef105d77c7f8d"

--000000000000bf3ef105d77c7f8d
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

Richard Palethorpe <rpalethorpe@suse.com> wrote:


--- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> ...
>
>  /* A Control Group in LTP's aggregated hierarchy */
>  struct tst_cgroup_group;
>
> +/* Populated with a reference to this tests's CGroup */
> +extern const struct tst_cgroup_group *const tst_cgroup;
> +extern const struct tst_cgroup_group *const tst_cgroup_drain;
>


--- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -18,7 +18,6 @@
>  #include "lapi/mount.h"
>  #include "lapi/mkdirat.h"
>  #include "tst_safe_file_at.h"
> -#include "tst_cgroup.h"
>
>  struct cgroup_root;
>
> @@ -138,6 +137,14 @@ struct tst_cgroup_group {
>         struct cgroup_dir *dirs[ROOTS_MAX + 1];
>  };
>
> +/* If controllers are required via the tst_test struct then this is
> + * populated with the test's CGroup.
> + */
> +static struct tst_cgroup_group test_group;
> +static struct tst_cgroup_group drain_group;
> +const struct tst_cgroup_group *const tst_cgroup = &test_group;
>

What about declaring as 'tst_cgroup_test' ? i.e.

    const struct tst_cgroup_group *const tst_cgroup_test = &test_group;

As it is a reference to test's CGroup and the test_dir is the same
layer with drain_dir, so this will be easier to understand the relationship
with drain_group.


+const struct tst_cgroup_group *const tst_cgroup_drain = &drain_group;


The rest part looks quite good.
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000bf3ef105d77c7f8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.com">rpalethorpe=
@suse.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=C2=
=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
--- a/include/tst_cgroup.h<br>
+++ b/include/tst_cgroup.h<br>
<span class=3D"gmail_default" style=3D"font-size:small">...</span><br>
<br>
=C2=A0/* A Control Group in LTP&#39;s aggregated hierarchy */<br>
=C2=A0struct tst_cgroup_group;<br>
<br>
+/* Populated with a reference to this tests&#39;s CGroup */<br>
+extern const struct tst_cgroup_group *const tst_cgroup;<br>
+extern const struct tst_cgroup_group *const tst_cgroup_drain;<br></blockqu=
ote><div>=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
--- a/lib/tst_cgroup.c<br>
+++ b/lib/tst_cgroup.c<br>
@@ -18,7 +18,6 @@<br>
=C2=A0#include &quot;lapi/mount.h&quot;<br>
=C2=A0#include &quot;lapi/mkdirat.h&quot;<br>
=C2=A0#include &quot;tst_safe_file_at.h&quot;<br>
-#include &quot;tst_cgroup.h&quot;<br>
<br>
=C2=A0struct cgroup_root;<br>
<br>
@@ -138,6 +137,14 @@ struct tst_cgroup_group {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cgroup_dir *dirs[ROOTS_MAX + 1];<br>
=C2=A0};<br>
<br>
+/* If controllers are required via the tst_test struct then this is<br>
+ * populated with the test&#39;s CGroup.<br>
+ */<br>
+static struct tst_cgroup_group test_group;<br>
+static struct tst_cgroup_group drain_group;<br>
+<span class=3D"gmail_default" style=3D"font-size:small"></span>const struc=
t tst_cgroup_group *const tst_cgroup =3D &amp;test_group;<br></blockquote><=
div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">W=
hat about declaring as=C2=A0&#39;tst_cgroup_test&#39; ? i.e.</div><div clas=
s=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail=
_default" style=3D"font-size:small"><div class=3D"gmail_default"><span clas=
s=3D"gmail_default">=C2=A0 =C2=A0=C2=A0</span>const struct tst_cgroup_group=
 *const tst_cgroup_test =3D &amp;test_group;</div><div class=3D"gmail_defau=
lt"><br></div></div><div class=3D"gmail_default" style=3D"font-size:small">=
As it is a reference to test&#39;s CGroup and the test_dir is the same</div=
><div class=3D"gmail_default" style=3D"font-size:small">layer with drain_di=
r, so this will be easier to understand the=C2=A0relationship</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">with drain_group.</div><br><=
/div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+const struct tst_cgroup_group *const tst_cgroup_drain =3D &amp;drain_group=
;</blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-siz=
e:small">The rest part looks quite good.</div></div><div class=3D"gmail_def=
ault" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:=
liwang@redhat.com">liwang@redhat.com</a>&gt;</div><div><br></div><div><br><=
/div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><di=
v>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000bf3ef105d77c7f8d--


--===============0722507768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0722507768==--

