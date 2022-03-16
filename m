Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE90CC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 09:09:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FCD43C93E5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 10:09:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 214A23C91FC
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 10:09:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 05D5D60045F
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 10:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647421779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XSKvwq0t0zq6iAFrj5RkCV+fKivt7sSeC+pp3FikOiQ=;
 b=Nr/BZ+kq7P9Q2Rybr2wPOs9855hDwAgcUaiU+j8pWRQYdfgREEKihslAJNGOATz5lp8Gqh
 IgIZJGzpgdpTuf0ujU91jB8joxk5J5GH6PxhN1POZO9SWV9P1kuGSq4Rj/3UvBYcIsjuV/
 q8hK34EiXwjBWm2ez1lpyYKxewrLDSI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-0Vcgj1WrMiu4ogxtOqQE7w-1; Wed, 16 Mar 2022 05:09:37 -0400
X-MC-Unique: 0Vcgj1WrMiu4ogxtOqQE7w-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2dbf52cc4b9so13815477b3.18
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 02:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XSKvwq0t0zq6iAFrj5RkCV+fKivt7sSeC+pp3FikOiQ=;
 b=OTE/lPiC4C7nEJaP2bACyh5cjFmhFTnrBfQeZmqD/DeJj0D9nJ9FGNMeXhnXmMH1FB
 Jt4Bsa7uRP2dx80a0k+PWNR0zhZBwUSxaejQfTT9Rm1QG6Y7HQfZpxTFgca+BVv6AwD6
 0vLqfQPG/xgvAQRdptO+zF5s8SxsgtSQThhMc/1gsTrqDmkb1WUKkdekj7Bf4NpEPYI0
 f7Hg4oOGv7bREnPEaK4ZTSPOTefUpaXiG67kr4QkzmNxptHE4UA+xcA/9P6RGXMAFo0m
 aPOb2vbTE957pkDZIY2/TGkfaCwR3EeO/Zfmdjv97vptVXntUEiuqTyGO4sQjE95YuDv
 lQWw==
X-Gm-Message-State: AOAM532/hnX++J45ewwLARkIp95xaGe3GEIA1YRm9xAgtlPfrt94MoOl
 aCLny/fHb+JbB0MlH/7uN3j/g7FEjubNgtnkOr4cgt6CXQUAR8EsE84i4XYn3WSrlxfOVOj7Ikh
 MiUdw+pKj9sGlcDLPu4wqewv1gr4=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr3821623ywb.370.1647421776439; 
 Wed, 16 Mar 2022 02:09:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhSaSm66Oofe4d/9EjAn99Tm7pZxzJJx99cpxiwH3VYm6YXUHBlGpnqGeYLNEoW67vHdSlDEowESmpxQdo5r4=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr3821547ywb.370.1647421775113; Wed, 16
 Mar 2022 02:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <6cefd04ee35cf06c9771a34d28dcd35015e49ded.1646434670.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <6cefd04ee35cf06c9771a34d28dcd35015e49ded.1646434670.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Mar 2022 17:09:23 +0800
Message-ID: <CAEemH2cbaH+CM=j=zJ+XWVvpjYLOeHBX=ySmc-TomGdH1Qeceg@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 16/16] controllers: update cgroup_regression_test
 to use newer cgroup lib
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
Content-Type: multipart/mixed; boundary="===============0151479275=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0151479275==
Content-Type: multipart/alternative; boundary="000000000000b3868605da524500"

--000000000000b3868605da524500
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 5, 2022 at 7:19 AM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:

> The older function in the cgroup lib 'get_cgroup_mountpoint' has been
> removed, so instead replace it with its old functionaility to get
> mountpoint.
>
> Also use the newer cgroup lib require operation to mount and cleanup a
> cpu controller.
>
> Signed-off-by: Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com>
> ---
>  .../cgroup/cgroup_regression_test.sh            | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index 592a1d3b1..2df216f43 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -170,17 +170,8 @@ test3()
>                 return
>         fi
>
> -       cpu_subsys_path=$(get_cgroup_mountpoint "cpu")
> -
> -       # Run the test for 30 secs
> -       if [ -z "$cpu_subsys_path" ]; then
> -               mount -t cgroup -o cpu xxx cgroup/
> -               if [ $? -ne 0 ]; then
> -                       tst_res TFAIL "Failed to mount cpu subsys"
> -                       return
> -               fi
> -               cpu_subsys_path=cgroup
> -       fi
> +       cgroup_require "cpu"
> +       cpu_subsys_path=$(cgroup_get_mountpoint "cpu")
>
>         cgroup_regression_3_1.sh $cpu_subsys_path &
>         pid1=$!
> @@ -193,7 +184,7 @@ test3()
>         wait $pid2 2>/dev/null
>
>         rmdir $cpu_subsys_path/0 2> /dev/null
> -       tst_umount $PWD/cgroup
> +       cgroup_cleanup
>         check_kernel_bug
>  }
>
> @@ -310,7 +301,7 @@ test_7_1()
>         # could be passed here as params and this will lead to ambiguity
> and
>         # errors when grepping simply for 'debug' in /proc/mounts since
> we'll
>         # find also /sys/kernel/debug. Helper takes care of this.
> -       local subsys_path=$(get_cgroup_mountpoint $subsys)
> +       local subsys_path=$(grep cgroup /proc/mounts | grep -w $subsys |
> awk '{ print $2 }')
>

Why not use 'cgroup_get_mountpoint' like test3 but
switch back to grep for getting the subsys path?
The grep way won't work on Cgroup V2, isn't it?


-- 
Regards,
Li Wang

--000000000000b3868605da524500
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sat, Mar 5, 2022 at 7:19 AM Luke Nowakowski-Krij=
ger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com">luke.nowako=
wskikrijger@canonical.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">The older function in the cgroup lib &#39;get_cgro=
up_mountpoint&#39; has been<br>
removed, so instead replace it with its old functionaility to get<br>
mountpoint.<br>
<br>
Also use the newer cgroup lib require operation to mount and cleanup a<br>
cpu controller.<br>
<br>
Signed-off-by: Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowsk=
ikrijger@canonical.com" target=3D"_blank">luke.nowakowskikrijger@canonical.=
com</a>&gt;<br>
---<br>
=C2=A0.../cgroup/cgroup_regression_test.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 17 ++++-------------<br>
=C2=A01 file changed, 4 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh =
b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh<br>
index 592a1d3b1..2df216f43 100755<br>
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh<br>
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh<br>
@@ -170,17 +170,8 @@ test3()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_subsys_path=3D$(get_cgroup_mountpoint &quot=
;cpu&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run the test for 30 secs<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -z &quot;$cpu_subsys_path&quot; ]; then<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount -t cgroup -o =
cpu xxx cgroup/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; th=
en<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res TFAIL &quot;Failed to mount cpu subsys&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_subsys_path=3Dc=
group<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cgroup_require &quot;cpu&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_subsys_path=3D$(cgroup_get_mountpoint &quot=
;cpu&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cgroup_regression_3_1.sh $cpu_subsys_path &amp;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid1=3D$!<br>
@@ -193,7 +184,7 @@ test3()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait $pid2 2&gt;/dev/null<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rmdir $cpu_subsys_path/0 2&gt; /dev/null<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_umount $PWD/cgroup<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cgroup_cleanup<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_kernel_bug<br>
=C2=A0}<br>
<br>
@@ -310,7 +301,7 @@ test_7_1()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # could be passed here as params and this will =
lead to ambiguity and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # errors when grepping simply for &#39;debug&#3=
9; in /proc/mounts since we&#39;ll<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # find also /sys/kernel/debug. Helper takes car=
e of this.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local subsys_path=3D$(get_cgroup_mountpoint $su=
bsys)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local subsys_path=3D$(grep cgroup /proc/mounts =
| grep -w $subsys | awk &#39;{ print $2 }&#39;)<br></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">Why not use=
 &#39;cgroup_get_mountpoint&#39;=C2=A0like test3 but</div><div class=3D"gma=
il_default" style=3D"font-size:small">switch back to grep for getting the s=
ubsys path?=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">The grep way won&#39;t work on Cgroup V2, isn&#39;t it?</div></div><div =
class=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br>=
</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><d=
iv>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000b3868605da524500--


--===============0151479275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0151479275==--

