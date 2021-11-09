Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA0C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:22:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BA3610CB
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0BA3610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A09E3C088F
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:22:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A5C93C03B1
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:22:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4FBBC100116B
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:22:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636453348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DSJ782T/r4BDfMZeGpVJHpalkbVeKwhHqqItplh3kJo=;
 b=drJJ+4eF2n35607uxPZi+r21qQYuU0ixbmfOxYLAp1XO6UWK+owMBfpmT8kdrhFkNAr0+r
 0i0ZewRpfv++06HnlRrihnETBKIRUTMslLvmtrHfxkiDazmoADOf36DZ2ZXMLzTswiGTjI
 UXdGF63ovSCoGp30A4ufPOpgmUXYz/Y=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-snAie0hhNZ-pHYAop1iHyQ-1; Tue, 09 Nov 2021 05:22:25 -0500
X-MC-Unique: snAie0hhNZ-pHYAop1iHyQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 t24-20020a252d18000000b005c225ae9e16so29977812ybt.15
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 02:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DSJ782T/r4BDfMZeGpVJHpalkbVeKwhHqqItplh3kJo=;
 b=7+Fj7ANE39Rug03ZPG1Abi3XqyZ66WyjaJoYTjcC2WpZj0GsCF1OH5TDKRNU3e5+S8
 3N2aEWBkiIxIcQw7kf/CfNy3FhLLWjrW0BNvf+H5hLbCngqu/2VliNLrAPt145yfZOKn
 8wyzCp/SpQbeXhUYqZkUtMpDXvgyLtwGS1rzXzbBp2mFxNxTfqIcJcGFo9vx91QPX8Y5
 sl2ABovJ8AlqSFWwGQvjVYk/Q879IDIncVZhD4rQXdNuzqgffAAE1LvWyQkFdavEsHW/
 Fonx0N3BpDUaATSiWI7LwCHUNxfClJ0gaSvtZ2KSm7TVKIvb+iZu4ZlkGGO/6lzbkCIT
 H54A==
X-Gm-Message-State: AOAM532fjut8X5OqHZcAMOVtPvcfmqDp/4g4rZdRE7BSdJNqGJPpN102
 e94JmKA1uofCuX7wTDnyegMM9Mgvg570nJOP3FqliKm5c1jS+a3bH4G4EdG9elHwWTbiEyQ1AGV
 x96Do6JyQe/ulHPVJFfvVCq9Ndys=
X-Received: by 2002:a05:6902:1543:: with SMTP id
 r3mr7874213ybu.166.1636453344774; 
 Tue, 09 Nov 2021 02:22:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwifzG2ICQFALcJdRQcRT/U1UyU1r0BHIb2x9gJOQIYj8KZUtIeh9agAQpksSIXl48SkHHejNhobI+If+Iha0Q=
X-Received: by 2002:a05:6902:1543:: with SMTP id
 r3mr7874183ybu.166.1636453344563; 
 Tue, 09 Nov 2021 02:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20211109101145.20092-1-pvorel@suse.cz>
In-Reply-To: <20211109101145.20092-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Nov 2021 18:22:10 +0800
Message-ID: <CAEemH2eZX6TX_WJ2mRpV0O3QFwWGmj7J1tYvOfthaz--W8VFeg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] test_zero_hugepage.sh: Lower hpages to 4
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
Content-Type: multipart/mixed; boundary="===============1119018322=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1119018322==
Content-Type: multipart/alternative; boundary="0000000000004b6c3e05d0587c3d"

--0000000000004b6c3e05d0587c3d
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 9, 2021 at 6:12 PM Petr Vorel <pvorel@suse.cz> wrote:

> which is enough
>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Tested on various distros, working.
>
> Kind regards,
> Petr
>
>  lib/newlib_tests/test_zero_hugepage.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/newlib_tests/test_zero_hugepage.sh
> b/lib/newlib_tests/test_zero_hugepage.sh
> index eed0a96f9..92bd7e331 100755
> --- a/lib/newlib_tests/test_zero_hugepage.sh
> +++ b/lib/newlib_tests/test_zero_hugepage.sh
> @@ -25,7 +25,7 @@ if [ ! -w /proc/sys/vm/nr_hugepages ]; then
>         tconf "no write permission to /proc/sys/vm/nr_hugepages (run as
> root)"
>  fi
>
> -echo "128" > /proc/sys/vm/nr_hugepages
> +echo 4 > /proc/sys/vm/nr_hugepages
>
Reviewed-by: Li Wang <liwang@redhat.com>


>
>  ./test_zero_hugepage
>
> --
> 2.33.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000004b6c3e05d0587c3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Nov 9, 2021 at 6:12 PM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">which is enough<br>
<br>
Suggested-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt;<br>
Acked-by: Yang Xu &lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com" target=
=3D"_blank">xuyang2018.jy@fujitsu.com</a>&gt;<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
Tested on various distros, working.<br>
<br>
Kind regards,<br>
Petr<br>
<br>
=C2=A0lib/newlib_tests/test_zero_hugepage.sh | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/newlib_tests/test_zero_hugepage.sh b/lib/newlib_tests/test=
_zero_hugepage.sh<br>
index eed0a96f9..92bd7e331 100755<br>
--- a/lib/newlib_tests/test_zero_hugepage.sh<br>
+++ b/lib/newlib_tests/test_zero_hugepage.sh<br>
@@ -25,7 +25,7 @@ if [ ! -w /proc/sys/vm/nr_hugepages ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tconf &quot;no write permission to /proc/sys/vm=
/nr_hugepages (run as root)&quot;<br>
=C2=A0fi<br>
<br>
-echo &quot;128&quot; &gt; /proc/sys/vm/nr_hugepages<br>
+echo 4 &gt; /proc/sys/vm/nr_hugepages<br></blockquote><div><span class=3D"=
gmail_default" style=3D"font-size:small"></span>Reviewed-by: Li Wang &lt;<a=
 href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&=
gt;</div><div><span class=3D"gmail_default"></span>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0./test_zero_hugepage<br>
<br>
-- <br>
2.33.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000004b6c3e05d0587c3d--


--===============1119018322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1119018322==--

