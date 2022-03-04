Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA498C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 02:28:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D1CC3C954D
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 03:28:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 028663C954D
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 03:27:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6CB961A00A20
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 03:27:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646360870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBpZrdg61oAsCzh6fYo2cluSmOdB0rnu1UvCacLrF6c=;
 b=KOvT9lgEv3lQVv/4JAq7KRa9nz56wtj236JzzP37ug3QZ6Zt1Y1W+RHxAngmlyCidVKUaT
 25mLM5ReO0eMZCN9KDx00fGl/mZA9+5oL0xJ4s1ndiwsvDH2Pg3Po0cIDaDorf08lY4N90
 E+MQdTB5XIZgkC+nb7b7Kr/7YYb3Pu0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-L1pLXI7LP9GHU4Qhpyzikw-1; Thu, 03 Mar 2022 21:27:49 -0500
X-MC-Unique: L1pLXI7LP9GHU4Qhpyzikw-1
Received: by mail-yb1-f197.google.com with SMTP id
 b11-20020a5b008b000000b00624ea481d55so6126991ybp.19
 for <ltp@lists.linux.it>; Thu, 03 Mar 2022 18:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EBpZrdg61oAsCzh6fYo2cluSmOdB0rnu1UvCacLrF6c=;
 b=e/SQqxMF26xyDF8FEMdvHtNdKiLw8XQQMEs9BM2ajMpQmO5PmgmkZAIiNDx9jlw99o
 tkbcogts8fbgT9E3eRLI9ohNFP/JZwtsLHM+UYK/G+6pdYfBNVHR+OSbCP3wWYMJLmPK
 20WSHvQdbfJx+YmlinYq2hA/tQjtazUNBOmsmlp77L4F/Ora85hF/bQtDWnlXrK83T6w
 O1sWrFW/k3HfdRx4UJYBXonzxPun8R7BD3UK0zh/x5BN6ZrNXQIH9ah811ttO5bpCqyg
 Y6F0VB5+yQQyXaYYq9mKDWL5irlWLTLEbBi/v2C6mVQWtT0iQQbBGt9I3pufKViQXqoY
 Pnkw==
X-Gm-Message-State: AOAM531n+YoKF2DOyOo/ifGTCvswzjamzIZVpe1DVFgm8feJrgTjrYPW
 +GHvzzc406u+cuskc3N/Tj4SRwNH+qvrAPbQodLVv5HCPKhCVXadNUzXt9dFe4fc60kg3VB04rH
 u98xVdegPsamCiJNxx/tUU0o5+5U=
X-Received: by 2002:a25:ac8b:0:b0:628:b4da:4c2f with SMTP id
 x11-20020a25ac8b000000b00628b4da4c2fmr8665042ybi.177.1646360868959; 
 Thu, 03 Mar 2022 18:27:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuZZnNlSRZ6JTfrLImHmMFsJrrT5hOpTqlcQQebQg01MGSZjX0o+/noMSiaJM1ZDDGpmhwbFNxFSdpPr75CPI=
X-Received: by 2002:a25:ac8b:0:b0:628:b4da:4c2f with SMTP id
 x11-20020a25ac8b000000b00628b4da4c2fmr8665029ybi.177.1646360868721; Thu, 03
 Mar 2022 18:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-6-chrubis@suse.cz>
In-Reply-To: <20220303145032.21493-6-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Mar 2022 10:27:35 +0800
Message-ID: <CAEemH2cnCNdUaoWqe=-dyuFq2Zc7gF79yi8XND8ieTvg8iEaRg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============2014615339=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2014615339==
Content-Type: multipart/alternative; boundary="000000000000c0adca05d95b42f5"

--000000000000c0adca05d95b42f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 3, 2022 at 10:49 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/mem/ksm/ksm06.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)
>
> diff --git a/testcases/kernel/mem/ksm/ksm06.c
> b/testcases/kernel/mem/ksm/ksm06.c
> index 61507b2aa..f5f7319d7 100644
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -39,9 +39,6 @@
>  #ifdef HAVE_NUMA_V2
>  #include <numaif.h>
>
> -static int run =3D -1;
> -static int sleep_millisecs =3D -1;
> -static int merge_across_nodes =3D -1;
>  static unsigned long nr_pages =3D 100;
>
>  static char *n_opt;
> @@ -141,27 +138,6 @@ static void setup(void)
>
>         if (n_opt)
>                 nr_pages =3D SAFE_STRTOUL(n_opt, 0, ULONG_MAX);
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
> -       if (merge_across_nodes !=3D -1) {
> -               FILE_PRINTF(PATH_KSM "merge_across_nodes",
> -                           "%d", merge_across_nodes);
> -       }
> -
> -       if (sleep_millisecs !=3D -1)
> -               FILE_PRINTF(PATH_KSM "sleep_millisecs", "%d",
> sleep_millisecs);
> -
> -       if (run !=3D -1)
> -               FILE_PRINTF(PATH_KSM "run", "%d", run);
>  }
>
>  static struct tst_test test =3D {
> @@ -171,9 +147,11 @@ static struct tst_test test =3D {
>                 {}
>         },
>         .setup =3D setup,
> -       .cleanup =3D cleanup,
>         .save_restore =3D (const char * const[]) {
>                 "?/sys/kernel/mm/ksm/max_page_sharing",
>

The mem library verifies the max_page_sharing validity before
setting because some old kernels do not have it. Thus it is fine
to use the prefix '?'.

+               "?/sys/kernel/mm/ksm/run",
> +               "?/sys/kernel/mm/ksm/merge_across_nodes",
> +               "?/sys/kernel/mm/ksm/sleep_millisecs",
>


But for the two knobs(run, sleep_millisecs) that should exist unless
the kernel disables KSM. So here we'd better start with prefix '!' and
add .needs_kconfg for =E2=80=98CONFIG_KSM=3Dy' check.
(This also fit for other ksm tests)

For 'merge_across_nodes', we don't need any prefix because
ksm06 is actually relying on it, otherwise TCONF is expected.
Thus it's fine to remove the file check from setup() as well.

--=20
Regards,
Li Wang

--000000000000c0adca05d95b42f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Mar 3, 2022 at 10:49 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-of=
f-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank"=
>chrubis@suse.cz</a>&gt;<br>
---<br>
=C2=A0testcases/kernel/mem/ksm/ksm06.c | 28 +++-------------------------<br=
>
=C2=A01 file changed, 3 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ks=
m06.c<br>
index 61507b2aa..f5f7319d7 100644<br>
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
@@ -141,27 +138,6 @@ static void setup(void)<br>
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
@@ -171,9 +147,11 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.cleanup =3D cleanup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const char * const[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;?/sys/kernel/=
mm/ksm/max_page_sharing&quot;,<br></blockquote><div><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">The mem library verifies the max_=
page_sharing=C2=A0validity before</div><div class=3D"gmail_default" style=
=3D"font-size:small">setting because some old kernels do not have it. Thus =
it is fine</div><div class=3D"gmail_default" style=3D"font-size:small">to u=
se the prefix=C2=A0&#39;?&#39;.</div><div class=3D"gmail_default" style=3D"=
font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:=
small"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;?/sys/kernel/=
mm/ksm/run&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;?/sys/kernel/=
mm/ksm/merge_across_nodes&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;?/sys/kernel/=
mm/ksm/sleep_millisecs&quot;,<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail=
_default" style=3D"font-size:small">But for the two knobs(run, sleep_millis=
ecs) that should exist unless</div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">the kernel disables KSM. So here we&#39;d better start with =
prefix &#39;!&#39; and</div><div class=3D"gmail_default" style=3D"font-size=
:small">add .needs_kconfg for =E2=80=98CONFIG_KSM=3Dy&#39; check.</div></di=
v><div class=3D"gmail_default" style=3D"font-size:small">(This also fit for=
 other ksm tests)</div><div class=3D"gmail_default" style=3D"font-size:smal=
l"><br></div><div class=3D"gmail_default" style=3D"font-size:small">For &#3=
9;merge_across_nodes&#39;, we don&#39;t need any prefix because</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">ksm06 is actually relying =
on it, otherwise TCONF is expected.=C2=A0</div><div class=3D"gmail_default"=
 style=3D"font-size:small">Thus it&#39;s fine to remove the file check from=
=C2=A0setup() as well.</div><div><div class=3D"gmail_default" style=3D"font=
-size:small"></div><br></div></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"=
><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000c0adca05d95b42f5--


--===============2014615339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2014615339==--

