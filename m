Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3716C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 09:07:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F2D43C1BB9
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 10:07:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4EBB3C1B77
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 10:07:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E129C600832
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 10:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646644042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jvR0M5MYw2Neh1F640ypOIwtPej4gWg/WGY4VX3eefc=;
 b=FJGL9inIp8ZCp88K1qkwpghbKffgtITcMmxWpgEk38wYH3mOqIcpqIhIrr/lzHtbGAfMOc
 T8nRFl+L5vGHX2ybDE+ZovKoth08/jZ+peHU+VhRLsnInpDV8JipKYfMoXH/1saLTKG2H7
 gvn9vagJJ68FaXL/FoPAxQTEMUtglK0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-sKdSJMfhM-uoFo6dLhfdzQ-1; Mon, 07 Mar 2022 04:07:14 -0500
X-MC-Unique: sKdSJMfhM-uoFo6dLhfdzQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 b12-20020a056902030c00b0061d720e274aso13014085ybs.20
 for <ltp@lists.linux.it>; Mon, 07 Mar 2022 01:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jvR0M5MYw2Neh1F640ypOIwtPej4gWg/WGY4VX3eefc=;
 b=VoKQK+sher+apVee4PAMwNo0YWRusKntqSHrwS7dRUz+4fIPhXEvLFBktK3JPxLFMj
 LkWEcFFCWL3XFuWRnrlHrPM2HNmJqwth+8jLlUUeTXPEXJZIbsE+K730f5+KkUbGDeFC
 Hyq4aThq+bQFu9DuinEreb2BQMenHOILdUgkxuK9yofX5mFpk9Erm/1e/NBUp4hyPQwj
 JIzwo/4Op9MaWz148UZEk8XkC+WQbPhL11lKXuK7IQrLfliSmdXaIywa4vfIIY7Mbz9S
 bVP+gOp1TqWfPjmrx3f7aDA19bpx0JSzATrp7WBvEEO7275yHfoPCDPmuI+jhTZdrItp
 +PHw==
X-Gm-Message-State: AOAM530l6hURw+GRyhBE8+b8nz9FNP9l4UxbMXB3md+igWy1dgpmQTu+
 HP85W6ieCeQc8LMK0/q7MWe291pFt/jvHo/0QDUTDKyRyAC8jGf40zR/9penG4lt11OoLvtNi9h
 3PdzS2AFBQYk8dR7C3t1ZwbFGzHU=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr7652629ywm.19.1646644033952; 
 Mon, 07 Mar 2022 01:07:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdV/J97dtptLzJLAWrKcqYOTxsPS905BRqhbQePIlZMxFa+gWz6PL3Z2gUJuXA3zUCDm0PjlQlZzK+IHo0DHg=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr7652617ywm.19.1646644033685; Mon, 07
 Mar 2022 01:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-6-chrubis@suse.cz>
 <CAEemH2cnCNdUaoWqe=-dyuFq2Zc7gF79yi8XND8ieTvg8iEaRg@mail.gmail.com>
 <YiH/2240VRU1OlAe@yuki>
 <CAEemH2eEJ06UnKJujTjWksutiK2Lmk_HHAwa76nBjAZGpNcVzA@mail.gmail.com>
 <YiXJSYKsDC+SpDcT@yuki>
In-Reply-To: <YiXJSYKsDC+SpDcT@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Mar 2022 17:06:57 +0800
Message-ID: <CAEemH2d_wRGiyLc1VKL4XJQ7A-gWA3sA_MoW9hqmTWBu+3-kLQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/7] mem/ksm06: Move ksm restoration into the
 tst_test struct
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
Content-Type: multipart/mixed; boundary="===============0007224720=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0007224720==
Content-Type: multipart/alternative; boundary="000000000000b3202c05d99d30f2"

--000000000000b3202c05d99d30f2
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 7, 2022 at 4:56 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > > But for the two knobs(run, sleep_millisecs) that should exist unless
> > > > the kernel disables KSM. So here we'd better start with prefix '!'
> and
> > > > add .needs_kconfg for ???CONFIG_KSM=y' check.
> > > > (This also fit for other ksm tests)
> > >
> > > I guess that if we put ! before the merge_across_nodes that would cause
> > > TBROK on systems without CONFIG_NUMA or kernels without that feature.
> > >
> > > So what about just removing the question marks there and adding
> > > .need_kconfigs for KSM and NUMA?
> > >
> >
> > Er, that's exactly what I meant in the last email, maybe you overlooked
> > the last sentence:).
> >
> > i.e.
> >
> > "
> >   prefix ! for 'run' and 'sleep_milisecs'
> >   no prefix for 'merge_across_nodes'
> >   .need_kconfigs for KSM and NUMA
> > "
>
> Ah, right, sorry. What about this:
>
> diff --git a/testcases/kernel/mem/ksm/ksm06.c
> b/testcases/kernel/mem/ksm/ksm06.c
> index 61507b2aa..e734786c1 100644
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -39,9 +39,6 @@
>  #ifdef HAVE_NUMA_V2
>  #include <numaif.h>
>
> -static int run = -1;
> -static int sleep_millisecs = -1;
> -static int merge_across_nodes = -1;
>  static unsigned long nr_pages = 100;
>
>  static char *n_opt;
> @@ -133,35 +130,11 @@ static void test_ksm(void)
>
>  static void setup(void)
>  {
> -       if (access(PATH_KSM "merge_across_nodes", F_OK) == -1)
> -               tst_brk(TCONF, "no merge_across_nodes sysfs knob");
> -
>         if (!is_numa(NULL, NH_MEMS, 2))
>                 tst_brk(TCONF, "The case needs a NUMA system.");
>
>         if (n_opt)
>                 nr_pages = SAFE_STRTOUL(n_opt, 0, ULONG_MAX);
> -
> -       /* save the current value */
> -       SAFE_FILE_SCANF(PATH_KSM "run", "%d", &run);
> -       SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
> -                       "%d", &merge_across_nodes);
> -       SAFE_FILE_SCANF(PATH_KSM "sleep_millisecs",
> -                       "%d", &sleep_millisecs);
> -}
> -
> -static void cleanup(void)
> -{
> -       if (merge_across_nodes != -1) {
> -               FILE_PRINTF(PATH_KSM "merge_across_nodes",
> -                           "%d", merge_across_nodes);
> -       }
> -
> -       if (sleep_millisecs != -1)
> -               FILE_PRINTF(PATH_KSM "sleep_millisecs", "%d",
> sleep_millisecs);
> -
> -       if (run != -1)
> -               FILE_PRINTF(PATH_KSM "run", "%d", run);
>  }
>
>  static struct tst_test test = {
> @@ -171,11 +144,18 @@ static struct tst_test test = {
>                 {}
>         },
>         .setup = setup,
> -       .cleanup = cleanup,
>         .save_restore = (const char * const[]) {
>                 "?/sys/kernel/mm/ksm/max_page_sharing",
> +               "!/sys/kernel/mm/ksm/run",
> +               "!/sys/kernel/mm/ksm/sleep_millisecs",
> +               "/sys/kernel/mm/ksm/merge_across_nodes",
>                 NULL,
>         },
> +       .needs_kconfigs = (const char *const[]){
> +               "CONFIG_KSM=y",
> +               "CONFIG_NUMA=y",
> +               NULL
> +       },
>         .test_all = test_ksm,
>  };
>
>
> If we add merge_across_nodes without any prefix we can as well remove
> the check for the file existence in the test setup.
>

ACK.

-- 
Regards,
Li Wang

--000000000000b3202c05d99d30f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Mar 7, 2022 at 4:56 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; &gt; But for the two knobs(run, sleep_millisecs) that should exis=
t unless<br>
&gt; &gt; &gt; the kernel disables KSM. So here we&#39;d better start with =
prefix &#39;!&#39; and<br>
&gt; &gt; &gt; add .needs_kconfg for ???CONFIG_KSM=3Dy&#39; check.<br>
&gt; &gt; &gt; (This also fit for other ksm tests)<br>
&gt; &gt;<br>
&gt; &gt; I guess that if we put ! before the merge_across_nodes that would=
 cause<br>
&gt; &gt; TBROK on systems without CONFIG_NUMA or kernels without that feat=
ure.<br>
&gt; &gt;<br>
&gt; &gt; So what about just removing the question marks there and adding<b=
r>
&gt; &gt; .need_kconfigs for KSM and NUMA?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Er, that&#39;s exactly what I meant in the last email, maybe you overl=
ooked<br>
&gt; the last sentence:).<br>
&gt; <br>
&gt; i.e.<br>
&gt; <br>
&gt; &quot;<br>
&gt;=C2=A0 =C2=A0prefix ! for &#39;run&#39; and &#39;sleep_milisecs&#39;<br=
>
&gt;=C2=A0 =C2=A0no prefix for &#39;merge_across_nodes&#39;<br>
&gt;=C2=A0 =C2=A0.need_kconfigs for KSM and NUMA<br>
&gt; &quot;<br>
<br>
Ah, right, sorry. What about this:<br>
<br>
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ks=
m06.c<br>
index 61507b2aa..e734786c1 100644<br>
--- a/testcases/kernel/mem/ksm/ksm06.c<br>
+++ b/testcases/kernel/mem/ksm/ksm06.c<br>
@@ -39,9 +39,6 @@<br>
=C2=A0#ifdef HAVE_NUMA_V2<br>
=C2=A0#include &lt;numaif.h&gt;<br>
<br>
-static int run =3D -1;<br>
-static int sleep_millisecs =3D -1;<br>
-static int merge_across_nodes =3D -1;<br>
=C2=A0static unsigned long nr_pages =3D 100;<br>
<br>
=C2=A0static char *n_opt;<br>
@@ -133,35 +130,11 @@ static void test_ksm(void)<br>
<br>
=C2=A0static void setup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(PATH_KSM &quot;merge_across_nodes&qu=
ot;, F_OK) =3D=3D -1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF, &quo=
t;no merge_across_nodes sysfs knob&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_numa(NULL, NH_MEMS, 2))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TCONF, &quo=
t;The case needs a NUMA system.&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n_opt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_pages =3D SAFE_S=
TRTOUL(n_opt, 0, ULONG_MAX);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* save the current value */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FILE_SCANF(PATH_KSM &quot;run&quot;, &quot=
;%d&quot;, &amp;run);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FILE_SCANF(PATH_KSM &quot;merge_across_nod=
es&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%d&quot;, &amp;merge_across_nodes);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FILE_SCANF(PATH_KSM &quot;sleep_millisecs&=
quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%d&quot;, &amp;sleep_millisecs);<br>
-}<br>
-<br>
-static void cleanup(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (merge_across_nodes !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_PRINTF(PATH_KS=
M &quot;merge_across_nodes&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;%d&quot;, merge_across_nodes);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sleep_millisecs !=3D -1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_PRINTF(PATH_KS=
M &quot;sleep_millisecs&quot;, &quot;%d&quot;, sleep_millisecs);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (run !=3D -1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_PRINTF(PATH_KS=
M &quot;run&quot;, &quot;%d&quot;, run);<br>
=C2=A0}<br>
<br>
=C2=A0static struct tst_test test =3D {<br>
@@ -171,11 +144,18 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.cleanup =3D cleanup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const char * const[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;?/sys/kernel/=
mm/ksm/max_page_sharing&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;!/sys/kernel/=
mm/ksm/run&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;!/sys/kernel/=
mm/ksm/sleep_millisecs&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;/sys/kernel/m=
m/ksm/merge_across_nodes&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_kconfigs =3D (const char *const[]){<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;CONFIG_KSM=3D=
y&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;CONFIG_NUMA=
=3Dy&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D test_ksm,<br>
=C2=A0};<br>
<br>
<br>
If we add merge_across_nodes without any prefix we can as well remove<br>
the check for the file existence in the test setup.<br></blockquote><div><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">ACK.</div></=
div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000b3202c05d99d30f2--


--===============0007224720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0007224720==--

