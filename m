Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFB5C433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 06:00:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E3803CA0E2
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 08:00:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0C1E3C0F3F
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 08:00:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CB33D600A02
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 08:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657087222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V5ZkRwgTpU52SWHCcAJxJwWBvdSM6Bl+fLUc4gpxNFg=;
 b=N3GFxgUbEVTAcI88N5a6iryvH+YS9yUCh7eQqQdQxcOLV/EatgULVFhZtxQHA+Hflagtpk
 WsKbbglemEYKhd+W2vC2F73B+lEYapQgrqeCqtYmBKEzYypM6weQoLlb+sIrIqB+Xny9tr
 7Wy1ZLMwFKbxEYvxKCECHanjc7iXafA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-PgRHXRnoOxCLb-9MQjXZKw-1; Wed, 06 Jul 2022 02:00:18 -0400
X-MC-Unique: PgRHXRnoOxCLb-9MQjXZKw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-31cdce3ed04so17969777b3.13
 for <ltp@lists.linux.it>; Tue, 05 Jul 2022 23:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V5ZkRwgTpU52SWHCcAJxJwWBvdSM6Bl+fLUc4gpxNFg=;
 b=df0UazfHcCwuoG1f30Qg1zQQ0EVEW8GKIemeNqdOekpTdQ4V6WRYL713MaLSn+Tm9N
 Ft0i3ga2ZgBC+j4Xn8cIm7DnoVZDkWgdzJwpx5o7fwffH8KZDdvm4CSsQ9n7s0kPVpSg
 KTIApr+9TYzfkMtpadJ2RYmvaZoqd+kqBpUXbxlBnwAAdWzxQaPOSIrINh7Xd6qIdeWo
 jCDflbuOFFOlfOmh3U6ZaNB2y55NLjkWT6iN77dDyNdv4RzaUhiGJJce6tzcjdrho67j
 yuWstGUf4IHwdgEmV6q9QdnHFaCAjUJp79PlaQG0xk4nVskvcmEpAU9lYMPL1C/YHiKr
 O11g==
X-Gm-Message-State: AJIora/Q0/z8VqfdKCUpYz+nND+u8c4KjVf0N+y3vhFKNN4ua7LVDdpX
 ORiNp4/3CpqS2VZm1o8uk4OEs+Ynt5F7L6CLH2359DVUDGhW/5A2BafQNPOisWPAiOHlMz+Ph8P
 IrNvQd2vhdpgdy4OSjV5fNk5yNBU=
X-Received: by 2002:a81:4eca:0:b0:31c:7a6a:f6d3 with SMTP id
 c193-20020a814eca000000b0031c7a6af6d3mr26491349ywb.82.1657087217849; 
 Tue, 05 Jul 2022 23:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uOYNKvhtFqSeH7a9g2Z58pmZ+tpOp6Nf/ZPTGfVdL0lF3bYgEPF8jE9/dwbBvLUi9akAC5a5pkJgKEj+j9PfI=
X-Received: by 2002:a81:4eca:0:b0:31c:7a6a:f6d3 with SMTP id
 c193-20020a814eca000000b0031c7a6af6d3mr26491328ywb.82.1657087217606; Tue, 05
 Jul 2022 23:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220701213749.3744031-1-edliaw@google.com>
In-Reply-To: <20220701213749.3744031-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 6 Jul 2022 14:00:06 +0800
Message-ID: <CAEemH2cQBinVjFP27NkRQJpEVCvfA08=gxdb5tk1nDRo0eN_nA@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>, 
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] controllers.memcg_regression: add trap to
 clean up directories
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1163921103=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1163921103==
Content-Type: multipart/alternative; boundary="000000000000f7bc5a05e31cae63"

--000000000000f7bc5a05e31cae63
Content-Type: text/plain; charset="UTF-8"

Hi Edward,

Thanks for your patch and I believe it makes sense.
But the whole memcg test has been re-written by Luke's patchset which is
still reviewing.
https://lists.linux.it/pipermail/ltp/2022-April/028777.html

@Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Luke, I guess V3 should be the final version (if you take the time to do
rebase/modification) and we'll happy to help merge those patches next:).



On Sat, Jul 2, 2022 at 5:38 AM Edward Liaw via ltp <ltp@lists.linux.it>
wrote:

> The memcg_regression test creates a memcg/ directory that can be left
> behind if the test exits unexpectedly.  Use a trap to clean up the
> directories on exit.
>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  .../memcg/regression/memcg_regression_test.sh | 20 +++++++++++--------
>  .../memcg/regression/memcg_test_4.sh          | 11 ++++++----
>  2 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git
> a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> index c91a4069e..2467ae0e6 100755
> ---
> a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> +++
> b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> @@ -54,6 +54,15 @@ nr_null=0
>  nr_warning=0
>  nr_lockdep=0
>
> +clean_up()
> +{
> +       # remove the cgroup
> +       rmdir memcg/0 2> /dev/null
> +       # unmount cgroup if still mounted
> +       umount memcg/
> +       rmdir memcg/
> +}
> +
>  # check_kernel_bug - check if some kind of kernel bug happened
>  check_kernel_bug()
>  {
> @@ -102,12 +111,12 @@ check_kernel_bug()
>
>  #---------------------------------------------------------------------------
>  test_1()
>  {
> -       mkdir memcg/0/
> +       mkdir memcg/0
>         echo 0 > memcg/0/memory.limit_in_bytes
>
>         ./memcg_test_1
>
> -       rmdir memcg/0/
> +       rmdir memcg/0
>
>         check_kernel_bug
>         if [ $? -eq 1 ]; then
> @@ -211,14 +220,12 @@ test_4()
>         killall -9 memcg_test_4 2> /dev/null
>         killall -9 memcg_test_4.sh 2> /dev/null
>
> -       # if test_4.sh gets killed, it won't clean cgroup it created
> -       rmdir memcg/0 2> /dev/null
> -
>         swapon -a
>  }
>
>  # main
>  failed=0
> +trap clean_up EXIT
>  mkdir memcg/
>
>  for cur in $(seq 1 $TST_TOTAL); do
> @@ -236,7 +243,4 @@ for cur in $(seq 1 $TST_TOTAL); do
>         umount memcg/
>  done
>
> -rmdir memcg/
> -
>  exit $failed
> -
> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> index 620031366..d002601f1 100755
> --- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> @@ -22,6 +22,13 @@
>  ##
>     ##
>
>  ################################################################################
>
> +clean_up()
> +{
> +       # remove the cgroup when exiting
> +       rmdir memcg/0
> +}
> +
> +trap clean_up EXIT
>  # attach current task to memcg/0/
>  mkdir memcg/0
>  echo $$ > memcg/0/tasks
> @@ -42,7 +49,3 @@ swapoff -a
>  sleep 1
>  echo $pid > memcg/tasks 2> /dev/null
>  echo $$ > memcg/tasks 2> /dev/null
> -
> -# now remove the cgroup
> -rmdir memcg/0
> -
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000f7bc5a05e31cae63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Edward,</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">=
Thanks for your patch and I believe it makes sense.</div><div class=3D"gmai=
l_default" style=3D"font-size:small">But the whole memcg test has been re-w=
ritten by Luke&#39;s patchset which is still reviewing.</div><div class=3D"=
gmail_default" style=3D"font-size:small"><a href=3D"https://lists.linux.it/=
pipermail/ltp/2022-April/028777.html">https://lists.linux.it/pipermail/ltp/=
2022-April/028777.html<br></a></div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=3D"mailto:lu=
ke.nowakowskikrijger@canonical.com" tabindex=3D"-1">@Luke Nowakowski-Krijge=
r</a>=C2=A0=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">Luke, I guess V3 should be the final version (if you take the time to do=
</div><div class=3D"gmail_default" style=3D"font-size:small">rebase/modific=
ation) and we&#39;ll happy to help merge those patches next:).</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jul 2, 2022 at 5:38=
 AM Edward Liaw via ltp &lt;<a href=3D"mailto:ltp@lists.linux.it" target=3D=
"_blank">ltp@lists.linux.it</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">The memcg_regression test creates a memcg/ direc=
tory that can be left<br>
behind if the test exits unexpectedly.=C2=A0 Use a trap to clean up the<br>
directories on exit.<br>
<br>
Signed-off-by: Edward Liaw &lt;<a href=3D"mailto:edliaw@google.com" target=
=3D"_blank">edliaw@google.com</a>&gt;<br>
---<br>
=C2=A0.../memcg/regression/memcg_regression_test.sh | 20 +++++++++++-------=
-<br>
=C2=A0.../memcg/regression/memcg_test_4.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 11 ++++++----<br>
=C2=A02 files changed, 19 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression=
_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_t=
est.sh<br>
index c91a4069e..2467ae0e6 100755<br>
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.s=
h<br>
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.s=
h<br>
@@ -54,6 +54,15 @@ nr_null=3D0<br>
=C2=A0nr_warning=3D0<br>
=C2=A0nr_lockdep=3D0<br>
<br>
+clean_up()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# remove the cgroup<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0 2&gt; /dev/null<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# unmount cgroup if still mounted<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0umount memcg/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/<br>
+}<br>
+<br>
=C2=A0# check_kernel_bug - check if some kind of kernel bug happened<br>
=C2=A0check_kernel_bug()<br>
=C2=A0{<br>
@@ -102,12 +111,12 @@ check_kernel_bug()<br>
=C2=A0#--------------------------------------------------------------------=
-------<br>
=C2=A0test_1()<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir memcg/0/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir memcg/0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo 0 &gt; memcg/0/memory.limit_in_bytes<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./memcg_test_1<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_kernel_bug<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $? -eq 1 ]; then<br>
@@ -211,14 +220,12 @@ test_4()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 killall -9 memcg_test_4 2&gt; /dev/null<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 killall -9 memcg_test_4.sh 2&gt; /dev/null<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# if test_4.sh gets killed, it won&#39;t clean =
cgroup it created<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0 2&gt; /dev/null<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 swapon -a<br>
=C2=A0}<br>
<br>
=C2=A0# main<br>
=C2=A0failed=3D0<br>
+trap clean_up EXIT<br>
=C2=A0mkdir memcg/<br>
<br>
=C2=A0for cur in $(seq 1 $TST_TOTAL); do<br>
@@ -236,7 +243,4 @@ for cur in $(seq 1 $TST_TOTAL); do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 umount memcg/<br>
=C2=A0done<br>
<br>
-rmdir memcg/<br>
-<br>
=C2=A0exit $failed<br>
-<br>
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh =
b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br>
index 620031366..d002601f1 100755<br>
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br>
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br>
@@ -22,6 +22,13 @@<br>
=C2=A0##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
=C2=A0#####################################################################=
###########<br>
<br>
+clean_up()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# remove the cgroup when exiting<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0<br>
+}<br>
+<br>
+trap clean_up EXIT<br>
=C2=A0# attach current task to memcg/0/<br>
=C2=A0mkdir memcg/0<br>
=C2=A0echo $$ &gt; memcg/0/tasks<br>
@@ -42,7 +49,3 @@ swapoff -a<br>
=C2=A0sleep 1<br>
=C2=A0echo $pid &gt; memcg/tasks 2&gt; /dev/null<br>
=C2=A0echo $$ &gt; memcg/tasks 2&gt; /dev/null<br>
-<br>
-# now remove the cgroup<br>
-rmdir memcg/0<br>
-<br>
-- <br>
2.37.0.rc0.161.g10f37bed90-goog<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000f7bc5a05e31cae63--


--===============1163921103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1163921103==--

