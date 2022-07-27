Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D57C19F21
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 05:01:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B95D3C31DA
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 07:01:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9176C3C021B
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 07:01:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26BEC2009E4
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 07:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658898091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gUuspw+iAGS+VK4gsAyYTryHHnKs2nTAB87Zd8OmlE0=;
 b=JET78KIjvHGZE7bUo1gNHcieIv8bj2P5PCmZlyK6LlXQddJyfyAX132CYtKZ0x5s55s+KR
 WqAdMGm4JcjLqdLplg/O61ANwXE1erSzUzKsG6Ih9Fib3ixV5E86tIRDwdDDAlyks4OElk
 2oUhu1yIbRlfX+sflfPaAg6Qkz5FzyY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-ExNwR7ijPkKi3mDa8ElJdw-1; Wed, 27 Jul 2022 01:01:29 -0400
X-MC-Unique: ExNwR7ijPkKi3mDa8ElJdw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-31f5d66fcdeso12359217b3.21
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gUuspw+iAGS+VK4gsAyYTryHHnKs2nTAB87Zd8OmlE0=;
 b=BilQJC9zOLI+jYe8tIDILssN2HvwTl5KWhfMTGuhqcq9L4LWZYH+gBt9NDZqTCYoot
 W2UiGXwo5dQp6Gh6mQ7uommeCfDNE31rWIbavD37K+tclDZ0jKPexZqV6ioaTHyffOLT
 aWuq+x6pgYBndhzNayLIsdze6S63C/HU2pklv5JlMwBUvHsDmh4OyRxTfQ0zOwKodFUy
 h3awd1QHpZn01zH7xJb4ztXrGwn5K0/P2bbXXq8pycdzsxparTSXJnlleO8eoHZYkyy/
 8Vg4hV6nyNXINLEudU8c5JcJQrIADLkPBKIM7pYdgrdH+iVz9n8Xb92+L7VbZohl0aAD
 GkjA==
X-Gm-Message-State: AJIora9IMGuv4eBCXJ5M2Q7aLya/aRLgEIQucACAQU3RJk2hOl4FJUb9
 23BqgUNyhzRGIWJLBR/xhiOgVURShXZtY93frInuEK37HKnTMdxY3cSssqH8KM+YQWsmvEk3F+X
 bqaKVLjecOXnKlndYoEuAMFnUtXA=
X-Received: by 2002:a81:6d04:0:b0:31f:4433:603f with SMTP id
 i4-20020a816d04000000b0031f4433603fmr7142899ywc.53.1658898088991; 
 Tue, 26 Jul 2022 22:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tXo8fpZwvWNcmt07J1BW4oOGzWUkc4IX82Wh9hDJiBNbIpNkf2UdT0o1WIwIBoEhttUslj0GJfmISQ/XRttcM=
X-Received: by 2002:a81:6d04:0:b0:31f:4433:603f with SMTP id
 i4-20020a816d04000000b0031f4433603fmr7142864ywc.53.1658898088551; Tue, 26 Jul
 2022 22:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220726155646.26468-1-pvorel@suse.cz>
 <20220726155646.26468-3-pvorel@suse.cz>
In-Reply-To: <20220726155646.26468-3-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jul 2022 13:01:17 +0800
Message-ID: <CAEemH2cs5nVDMvHjmfXRDDep2wrZKA2FudKixTspeVCL2zTVcQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] tst_cgroup: Add macro
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: multipart/mixed; boundary="===============2092288114=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2092288114==
Content-Type: multipart/alternative; boundary="00000000000049815705e4c24f7a"

--00000000000049815705e4c24f7a
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 26, 2022 at 11:56 PM Petr Vorel <pvorel@suse.cz> wrote:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>

> ---
>  lib/tst_cgroup.c | 69 +++++++++++++++---------------------------------
>  1 file changed, 21 insertions(+), 48 deletions(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 6f24e0450..1cfd79243 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -229,11 +229,11 @@ static const struct cgroup_file freezer_ctrl_files[]
> = {
>         { }
>  };
>
> -static const struct cgroup_file netcls_ctrl_files[] = {
> +static const struct cgroup_file net_cls_ctrl_files[] = {
>         { }
>  };
>
> -static const struct cgroup_file netprio_ctrl_files[] = {
> +static const struct cgroup_file net_prio_ctrl_files[] = {
>         { }
>  };
>
> @@ -254,54 +254,27 @@ static const struct cgroup_file debug_ctrl_files[] =
> {
>  };
>
>  #define CTRL_NAME_MAX 31
> +#define CGROUP_CTRL_MEMBER(x, y)[y] = { .ctrl_name = #x, .files = \
> +       x ## _ctrl_files, .ctrl_indx = y, NULL, 0 }
> +
>  /* Lookup tree for item names. */
>  static struct cgroup_ctrl controllers[] = {
> -       [0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
> -       [CTRL_MEMORY] = {
> -               "memory", memory_ctrl_files, CTRL_MEMORY, NULL, 0
> -       },
> -       [CTRL_CPU] = {
> -               "cpu", cpu_ctrl_files, CTRL_CPU, NULL, 0
> -       },
> -       [CTRL_CPUSET] = {
> -               "cpuset", cpuset_ctrl_files, CTRL_CPUSET, NULL, 0
> -       },
> -       [CTRL_IO] = {
> -               "io", io_ctrl_files, CTRL_IO, NULL, 0
> -       },
> -       [CTRL_PIDS] = {
> -               "pids", pids_ctrl_files, CTRL_PIDS, NULL, 0
> -       },
> -       [CTRL_HUGETLB] = {
> -               "hugetlb", hugetlb_ctrl_files, CTRL_HUGETLB, NULL, 0
> -       },
> -       [CTRL_CPUACCT] = {
> -               "cpuacct", cpuacct_ctrl_files, CTRL_CPUACCT, NULL, 0
> -       },
> -       [CTRL_DEVICES] = {
> -               "devices", devices_ctrl_files, CTRL_DEVICES, NULL, 0
> -       },
> -       [CTRL_FREEZER] = {
> -               "freezer", freezer_ctrl_files, CTRL_FREEZER, NULL, 0
> -       },
> -       [CTRL_NETCLS] = {
> -               "net_cls", netcls_ctrl_files, CTRL_NETCLS, NULL, 0
> -       },
> -       [CTRL_NETPRIO] = {
> -               "net_prio", netprio_ctrl_files, CTRL_NETPRIO, NULL, 0
> -       },
> -       [CTRL_BLKIO] = {
> -               "blkio", blkio_ctrl_files, CTRL_BLKIO, NULL, 0
> -       },
> -       [CTRL_MISC] = {
> -               "misc", misc_ctrl_files, CTRL_MISC, NULL, 0
> -       },
> -       [CTRL_PERFEVENT] = {
> -               "perf_event", perf_event_ctrl_files, CTRL_PERFEVENT, NULL,
> 0
> -       },
> -       [CTRL_DEBUG] = {
> -               "debug", debug_ctrl_files, CTRL_DEBUG, NULL, 0
> -       },
> +       CGROUP_CTRL_MEMBER(cgroup, 0),
> +       CGROUP_CTRL_MEMBER(memory, CTRL_MEMORY),
> +       CGROUP_CTRL_MEMBER(cpu, CTRL_CPU),
> +       CGROUP_CTRL_MEMBER(cpuset, CTRL_CPUSET),
> +       CGROUP_CTRL_MEMBER(io, CTRL_IO),
> +       CGROUP_CTRL_MEMBER(pids, CTRL_PIDS),
> +       CGROUP_CTRL_MEMBER(hugetlb, CTRL_HUGETLB),
> +       CGROUP_CTRL_MEMBER(cpuacct, CTRL_CPUACCT),
> +       CGROUP_CTRL_MEMBER(devices, CTRL_DEVICES),
> +       CGROUP_CTRL_MEMBER(freezer, CTRL_FREEZER),
> +       CGROUP_CTRL_MEMBER(net_cls, CTRL_NETCLS),
> +       CGROUP_CTRL_MEMBER(net_prio, CTRL_NETPRIO),
> +       CGROUP_CTRL_MEMBER(blkio, CTRL_BLKIO),
> +       CGROUP_CTRL_MEMBER(misc, CTRL_MISC),
> +       CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),
> +       CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),
>         { }
>  };
>
> --
> 2.37.1
>
>

-- 
Regards,
Li Wang

--00000000000049815705e4c24f7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 26, 2022 at 11:56 PM P=
etr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@su=
se.cz</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=
=3D"_blank">pvorel@suse.cz</a>&gt;<br></blockquote><div><span class=3D"gmai=
l_default" style=3D"font-size:small"></span></div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:li=
wang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</div><div clas=
s=3D"gmail_default" style=3D"font-size:small"></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
---<br>
=C2=A0lib/tst_cgroup.c | 69 +++++++++++++++--------------------------------=
-<br>
=C2=A01 file changed, 21 insertions(+), 48 deletions(-)<br>
<br>
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c<br>
index 6f24e0450..1cfd79243 100644<br>
--- a/lib/tst_cgroup.c<br>
+++ b/lib/tst_cgroup.c<br>
@@ -229,11 +229,11 @@ static const struct cgroup_file freezer_ctrl_files[] =
=3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { }<br>
=C2=A0};<br>
<br>
-static const struct cgroup_file netcls_ctrl_files[] =3D {<br>
+static const struct cgroup_file net_cls_ctrl_files[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { }<br>
=C2=A0};<br>
<br>
-static const struct cgroup_file netprio_ctrl_files[] =3D {<br>
+static const struct cgroup_file net_prio_ctrl_files[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { }<br>
=C2=A0};<br>
<br>
@@ -254,54 +254,27 @@ static const struct cgroup_file debug_ctrl_files[] =
=3D {<br>
=C2=A0};<br>
<br>
=C2=A0#define CTRL_NAME_MAX 31<br>
+#define CGROUP_CTRL_MEMBER(x, y)[y] =3D { .ctrl_name =3D #x, .files =3D \<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0x ## _ctrl_files, .ctrl_indx =3D y, NULL, 0 }<b=
r>
+<br>
=C2=A0/* Lookup tree for item names. */<br>
=C2=A0static struct cgroup_ctrl controllers[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[0] =3D { &quot;cgroup&quot;, cgroup_ctrl_files=
, 0, NULL, 0 },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_MEMORY] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;memory&quot;,=
 memory_ctrl_files, CTRL_MEMORY, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_CPU] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;cpu&quot;, cp=
u_ctrl_files, CTRL_CPU, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_CPUSET] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;cpuset&quot;,=
 cpuset_ctrl_files, CTRL_CPUSET, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_IO] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;io&quot;, io_=
ctrl_files, CTRL_IO, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_PIDS] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pids&quot;, p=
ids_ctrl_files, CTRL_PIDS, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_HUGETLB] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;hugetlb&quot;=
, hugetlb_ctrl_files, CTRL_HUGETLB, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_CPUACCT] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;cpuacct&quot;=
, cpuacct_ctrl_files, CTRL_CPUACCT, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_DEVICES] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;devices&quot;=
, devices_ctrl_files, CTRL_DEVICES, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_FREEZER] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;freezer&quot;=
, freezer_ctrl_files, CTRL_FREEZER, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_NETCLS] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;net_cls&quot;=
, netcls_ctrl_files, CTRL_NETCLS, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_NETPRIO] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;net_prio&quot=
;, netprio_ctrl_files, CTRL_NETPRIO, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_BLKIO] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;blkio&quot;, =
blkio_ctrl_files, CTRL_BLKIO, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_MISC] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;misc&quot;, m=
isc_ctrl_files, CTRL_MISC, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_PERFEVENT] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;perf_event&qu=
ot;, perf_event_ctrl_files, CTRL_PERFEVENT, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[CTRL_DEBUG] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;debug&quot;, =
debug_ctrl_files, CTRL_DEBUG, NULL, 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(cgroup, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(memory, CTRL_MEMORY),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(cpu, CTRL_CPU),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(cpuset, CTRL_CPUSET),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(io, CTRL_IO),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(pids, CTRL_PIDS),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(hugetlb, CTRL_HUGETLB),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(cpuacct, CTRL_CPUACCT),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(devices, CTRL_DEVICES),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(freezer, CTRL_FREEZER),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(net_cls, CTRL_NETCLS),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(net_prio, CTRL_NETPRIO),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(blkio, CTRL_BLKIO),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(misc, CTRL_MISC),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { }<br>
=C2=A0};<br>
<br>
-- <br>
2.37.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div></div>

--00000000000049815705e4c24f7a--


--===============2092288114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2092288114==--

