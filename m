Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFE1C4332F
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 03:09:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B93AE3CCA44
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 04:09:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5AC53C67D6
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 04:09:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC4FA600714
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 04:09:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669259369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nDlvefnZpW7Da4eGavC16D/tVl2e6NTDx/VxKRgNRpk=;
 b=NOezSTT/TSrR8xP4B1t47Z+LzkPF+awFQxYP7GAxiOcCAFQnDEkrzUASxM5lqxhU7TDPHs
 mA2BQCtDqIo7GhIWORdftGesrvMg1KlLp30eiN4mS/K6s3p81+CX5UdwZuSVSmI1fuR8es
 vQ5aoAfvDBEY6vXUk4fgM2q1HmmAmOM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-520-61lVttFoOLKEDgNAtibCZQ-1; Wed, 23 Nov 2022 22:09:27 -0500
X-MC-Unique: 61lVttFoOLKEDgNAtibCZQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 m34-20020a05600c3b2200b003cf549cb32bso1968766wms.1
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 19:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nDlvefnZpW7Da4eGavC16D/tVl2e6NTDx/VxKRgNRpk=;
 b=V6jSQkWxvEwTUiBU0KYTk8sOc+FxUmx9HzxP4/WI5P16JlOOxLTvYUo+kZUZbKQ3NV
 S4Ap6TiuGDGf8fh4VAFfw2S6n3s6ZYgwjg1KIAGz1jQhokRpo5cKns7etJWEKmwFtkFu
 MzKq0vhqW3PfDZhuPaV57uPqfhGqp7Ihlldzvtn4k5/GkglEx3SvkxtOzrAtgUHPBfWM
 h40jOHGCat6HCuNoPHgIkcSNL7b3oJqpMLX/76WretaRyixaUyd9lpA0+GMsHMKauy6/
 fxqaPoprZLV0eyNuM9tOIZnCVzrt3VknQXVtr5ghJ7Vcp4tGMC0+hMCnNGHwGd0N2r5k
 mzxA==
X-Gm-Message-State: ANoB5pkxqCz7GRbX/R8kEjoua94iFMdxrcI1pQcRj/5krUJYfNUtFNmE
 0zLoaNdWwktODGz7986UmQKTnIkkxcIUn3CGbt3fbQk+3X5b11cUd0xY2ZWa3kdajczJhh02Xdn
 gpLDmHU5uRXXDmw04N9AZZXuKdqI=
X-Received: by 2002:adf:f011:0:b0:241:c78c:3671 with SMTP id
 j17-20020adff011000000b00241c78c3671mr13875759wro.129.1669259365807; 
 Wed, 23 Nov 2022 19:09:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YwL3MOeYKgArfoSPXCMhGXKo8cI+tyQrz4/FzVR8o+wih0TueLKOP+6EPGtZkV6+d/fgJcjC1egS2E/ZT/yU=
X-Received: by 2002:adf:f011:0:b0:241:c78c:3671 with SMTP id
 j17-20020adff011000000b00241c78c3671mr13875748wro.129.1669259365504; Wed, 23
 Nov 2022 19:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20221116160715.10082-1-mdoucha@suse.cz>
 <CAEemH2dGJ3LzO=OS7hrxxgMJ+T4FguiBFgB3KXirJw-R7zVBBQ@mail.gmail.com>
 <Y3eJNAi81ucutljP@yuki>
 <CAASaF6yaPmG1Q5fdecM7xhE3uqHa_PCMZBGj-hUj9xrVU42Z6A@mail.gmail.com>
In-Reply-To: <CAASaF6yaPmG1Q5fdecM7xhE3uqHa_PCMZBGj-hUj9xrVU42Z6A@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Nov 2022 11:09:14 +0800
Message-ID: <CAEemH2etbzDjbNipZGpNM6UqOfjAmrrM5Ht0PDj5VK7i98tOWA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>, Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] save_restore: Introduce new struct field for
 flags
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
Content-Type: multipart/mixed; boundary="===============2125184095=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2125184095==
Content-Type: multipart/alternative; boundary="00000000000084f5a605ee2ebb6e"

--00000000000084f5a605ee2ebb6e
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Tue, Nov 22, 2022 at 4:02 PM Jan Stancek <jstancek@redhat.com> wrote:

> On Fri, Nov 18, 2022 at 2:30 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> >
> > Hi!
> > > > +#define TST_SR_TCONF (TST_SR_TCONF_MISSING | TST_SR_TCONF_RO)
> > > > +#define TST_SR_TBROK (TST_SR_TBROK_MISSING | TST_SR_TBROK_RO)
> > > > +#define TST_SR_SKIP (TST_SR_SKIP_MISSING | TST_SR_SKIP_RO)
> > > >
> > >
> > > I'd suggest using "_TSKIP" to replace "_SKIP' to be consistent.
> > > Then the whole format will look quite perfect and easy to memorize:).
> >
> > I think that it makse sense to keep it as _SKIP because that is the
> > option that does not map directly to the test result flags. If we named
> > it TSKIP people will be confused that there is no TSKIP in the test
> > result flags at all.
>
> +1 for SKIP
>
> Feel free to add my Acked-by back.
>

Sure, no problem.

But before applying patch-v5 as it is, I found additional two tiny issues:

1. the usage in newlib_tests should be corrected as well
2. tst_hugepage need to update the argument in tst_sys_conf_save()

If everyone agrees on the improvements, I will merge with below fixes:

--- a/lib/newlib_tests/test19.c
+++ b/lib/newlib_tests/test19.c
@@ -24,9 +24,9 @@ static struct tst_test test = {
        .test_all = run,
        .setup = setup,
        .save_restore = (const struct tst_path_val[]) {
-               {"?/proc/nonexistent", NULL},
-               {"!/proc/sys/kernel/numa_balancing", NULL},
-               {"/proc/sys/kernel/core_pattern", NULL},
+               {"/proc/nonexistent", NULL, TST_SR_SKIP},
+               {"/proc/sys/kernel/numa_balancing", NULL, TST_SR_TBROK},
+               {"/proc/sys/kernel/core_pattern", NULL, TST_SR_TCONF},
                {}
        },
 };
diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
index 3982ab7..3726cea 100644
--- a/lib/newlib_tests/test20.c
+++ b/lib/newlib_tests/test20.c
@@ -39,7 +39,7 @@ static struct tst_test test = {
        .test_all = do_test,
        .hugepages = {2, TST_NEEDS},
        .save_restore = (const struct tst_path_val[]) {
-               {"!/proc/sys/kernel/numa_balancing", "0"},
+               {"/proc/sys/kernel/numa_balancing", "0", TST_SR_TBROK},
                {}
        },
 };
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index e97cc56..41f65d7 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -7,6 +7,7 @@

 #include "tst_test.h"
 #include "tst_hugepage.h"
+#include "tst_sys_conf.h"

 unsigned long tst_hugepages;
 char *nr_opt;
@@ -24,6 +25,12 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage
*hp)
 {
        unsigned long val, max_hpages;

+       struct tst_path_val pvl = {
+               .path = PATH_NR_HPAGES,
+               .val = NULL,
+               .flags = TST_SR_SKIP,
+       };
+
        if (access(PATH_HUGEPAGES, F_OK)) {
                if (hp->policy == TST_NEEDS)
                        tst_brk(TCONF, "hugetlbfs is not supported");
@@ -59,7 +66,7 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage
*hp)
        }

 set_hugepages:
-       tst_sys_conf_save("?/proc/sys/vm/nr_hugepages");
+       tst_sys_conf_save(&pvl);
        SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
        SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
        if (val != tst_hugepages)


-- 
Regards,
Li Wang

--00000000000084f5a605ee2ebb6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi All,</div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Nov 22, 2022 at 4:02 PM Jan Stancek &lt;=
<a href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Nov 18, 2=
022 at 2:30 PM Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=
=3D"_blank">chrubis@suse.cz</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi!<br>
&gt; &gt; &gt; +#define TST_SR_TCONF (TST_SR_TCONF_MISSING | TST_SR_TCONF_R=
O)<br>
&gt; &gt; &gt; +#define TST_SR_TBROK (TST_SR_TBROK_MISSING | TST_SR_TBROK_R=
O)<br>
&gt; &gt; &gt; +#define TST_SR_SKIP (TST_SR_SKIP_MISSING | TST_SR_SKIP_RO)<=
br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I&#39;d suggest using &quot;_TSKIP&quot; to replace &quot;_SKIP&#=
39; to be consistent.<br>
&gt; &gt; Then the whole format will look quite perfect and easy to memoriz=
e:).<br>
&gt;<br>
&gt; I think that it makse sense to keep it as _SKIP because that is the<br=
>
&gt; option that does not map directly to the test result flags. If we name=
d<br>
&gt; it TSKIP people will be confused that there is no TSKIP in the test<br=
>
&gt; result flags at all.<br>
<br>
+1 for SKIP<br>
<br>
Feel free to add my Acked-by back.<br></blockquote><div><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Sure, no problem.</div><div c=
lass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">But before applying patch-v5 as it i=
s, I found additional two tiny issues:</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">1. the usage in newlib_tests should be corrected as well</div=
><div class=3D"gmail_default" style=3D"font-size:small">2. tst_hugepage nee=
d to update the argument in=C2=A0<span class=3D"gmail_default"></span>tst_s=
ys_conf_save()</div><div class=3D"gmail_default" style=3D"font-size:small">=
<br></div><div class=3D"gmail_default" style=3D"font-size:small">If everyon=
e agrees on the improvements, I will merge with below fixes:</div><div clas=
s=3D"gmail_default" style=3D"font-size:small"><br></div>--- a/lib/newlib_te=
sts/test19.c<br>+++ b/lib/newlib_tests/test19.c<br>@@ -24,9 +24,9 @@ static=
 struct tst_test test =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D ru=
n,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .save_restore =3D (const struct tst_path_val[]) {<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;?/proc/nonexistent&quot;, NUL=
L},<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;!/proc/sys=
/kernel/numa_balancing&quot;, NULL},<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 {&quot;/proc/sys/kernel/core_pattern&quot;, NULL},<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;/proc/nonexistent&q=
uot;, NULL, TST_SR_SKIP},<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 {&quot;/proc/sys/kernel/numa_balancing&quot;, NULL, TST_SR_TBROK},<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;/proc/sys/kerne=
l/core_pattern&quot;, NULL, TST_SR_TCONF},<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>=C2=A0}=
;<br>diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c<br>=
index 3982ab7..3726cea 100644<br>--- a/lib/newlib_tests/test20.c<br>+++ b/l=
ib/newlib_tests/test20.c<br>@@ -39,7 +39,7 @@ static struct tst_test test =
=3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D do_test,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 .hugepages =3D {2, TST_NEEDS},<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .save_restore =3D (const struct tst_path_val[]) {<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;!/proc/sys/kernel/numa_balancing=
&quot;, &quot;0&quot;},<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 {&quot;/proc/sys/kernel/numa_balancing&quot;, &quot;0&quot;, TST_SR_TBR=
OK},<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 },<br>=C2=A0};<br>diff --git a/lib/tst_hugepage.c =
b/lib/tst_hugepage.c<br>index e97cc56..41f65d7 100644<br>--- a/lib/tst_huge=
page.c<br>+++ b/lib/tst_hugepage.c<br>@@ -7,6 +7,7 @@<br>=C2=A0<br>=C2=A0#i=
nclude &quot;tst_test.h&quot;<br>=C2=A0#include &quot;tst_hugepage.h&quot;<=
br>+#include &quot;tst_sys_conf.h&quot;<br>=C2=A0<br>=C2=A0unsigned long ts=
t_hugepages;<br>=C2=A0char *nr_opt;<br>@@ -24,6 +25,12 @@ unsigned long tst=
_reserve_hugepages(struct tst_hugepage *hp)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned long val, max_hpages;<br>=C2=A0<br>+ =C2=A0 =C2=A0 =C2=
=A0 struct tst_path_val pvl =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 .path =3D PATH_NR_HPAGES,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .val =3D NULL,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .flags =3D TST_SR_SKIP,<br>+ =C2=A0 =C2=A0 =C2=A0 };<br>+<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (access(PATH_HUGEPAGES, F_OK)) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hp-&gt;policy =3D=3D T=
ST_NEEDS)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 tst_brk(TCONF, &quot;hugetlbfs is not supported&quot;=
);<br>@@ -59,7 +66,7 @@ unsigned long tst_reserve_hugepages(struct tst_huge=
page *hp)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>=C2=A0set_hugepages=
:<br>- =C2=A0 =C2=A0 =C2=A0 <span class=3D"gmail_default" style=3D"font-siz=
e:small"></span>tst_sys_conf_save(&quot;?/proc/sys/vm/nr_hugepages&quot;);<=
br>+ =C2=A0 =C2=A0 =C2=A0 tst_sys_conf_save(&amp;pvl);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SAFE_FILE_PRINTF(PATH_NR_HPAGES, &quot;%lu&quot;, tst_hugepages)=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_FILE_SCANF(PATH_NR_HPAGES, &quot;%lu&=
quot;, &amp;val);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val !=3D tst_hugepages=
)<br><div class=3D"gmail_default" style=3D"font-size:small"></div></div><br=
 clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signat=
ure"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></=
div></div>

--00000000000084f5a605ee2ebb6e--


--===============2125184095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2125184095==--

