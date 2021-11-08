Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D9DC433EF
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 07:32:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CAA60E73
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 07:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06CAA60E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC30A3C7728
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 08:32:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C04C3C702E
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 08:32:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4A50710000D2
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 08:31:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636356718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xmTlqag9xUWHOg0J2rT13NubIFbmg9iutq1xKxi3gig=;
 b=bYOVfe3pZvDHpRKXnxiOoNwQatoWXzfKTeXhm+yf4uzjhIOx5pU1reN6VVGICZ3bUkaEhE
 dJBpqMiAAxpSWOTJ4JhGCm/z6ZhCsnPvr39uYsY35vWa7F8p10cndh4GN+FFkkkpwDJiJB
 Tw7YZS37QDhUO5O4GZ0LqpOTx5/WxcU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-ZaVMA800NF-D3vwXhwBRVQ-1; Mon, 08 Nov 2021 02:31:56 -0500
X-MC-Unique: ZaVMA800NF-D3vwXhwBRVQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 x16-20020a25b910000000b005b6b7f2f91cso24433076ybj.1
 for <ltp@lists.linux.it>; Sun, 07 Nov 2021 23:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xmTlqag9xUWHOg0J2rT13NubIFbmg9iutq1xKxi3gig=;
 b=PoXhF+56JV0dWWe3Fi2K+2R8Jt78HgaEU6m2YXEqQbLRx4d49tzzpFNOQnZiJJecC+
 xuM38IdVcE87Lqcp1fToNDQe2z1CKcLeCgPyt60yW11JcS0OCZvpOL27sPNC2D/vM01X
 sS8jGiBg5Oh6D/+Bqw8yUJ+0LJUFXWCig6LnhP9lKEl7ulfYMdeFXaZgfrbjHmIumRVn
 wr8wps3NtG6jOo1pw5bLbG0dHe9U3B9CfccSJv78M+hymA57ORe1COglBEGQsdg5mX2o
 CmbbRkWkig2t+aM7MFNhc7h1/MFvOVqLLnIKigQgY7RVRDJ0VQk1HZXQLnaVvcPigXlO
 o8Hw==
X-Gm-Message-State: AOAM531qNJKFLbwW2Jmq+C98HMDrue+aYT15Rd3zSvkB8t1HAwOv7uam
 m9HxeQ6t7IeRJ4diCMPLjen/rCl+l4i3j0YNDy3q4ILHc+cGtjTsS2v58HCw2pNazthGXo3ox5a
 ZcYf2BqdT2P/zqHhIxvc5WL4ha2M=
X-Received: by 2002:a25:e704:: with SMTP id e4mr79554874ybh.490.1636356715551; 
 Sun, 07 Nov 2021 23:31:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7kbI3SE4maNgFr0vrgGGVuW9q3LRIJIaywJz6G6qbrXVNgQTu/W38EOOvIwDriR/li9fu5Nxv5d6akmXpRrg=
X-Received: by 2002:a25:e704:: with SMTP id e4mr79554859ybh.490.1636356715379; 
 Sun, 07 Nov 2021 23:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20211104164528.29936-1-pvorel@suse.cz>
In-Reply-To: <20211104164528.29936-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Nov 2021 15:31:43 +0800
Message-ID: <CAEemH2c4rfko1a=V-W04N0QXs9GKhJkc60_WjWFBe+BqbLQ3tA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] test_zero_hugepage.sh: Detect errors write to
 /proc/sys/vm/nr_hugepages
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
Content-Type: multipart/mixed; boundary="===============2137002022=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2137002022==
Content-Type: multipart/alternative; boundary="000000000000bf140d05d041fc3c"

--000000000000bf140d05d041fc3c
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 5, 2021 at 12:45 AM Petr Vorel <pvorel@suse.cz> wrote:

> Fix running make test-c as non-root.
>
> Fixes: 057d6b046 ("lib/tst_hugepage: Fix .request_hugepages = 0 bug")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> maybe echo "128" would not have to be checked.
>

Agreed, If the system memory is too fragmental to keep
enough hpages, there won't be an error returned.

Reviewed-by: Li Wang <liwang@redhat.com>



>
> Kind regards,
> Petr
>
>  lib/newlib_tests/test_zero_hugepage.sh | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/lib/newlib_tests/test_zero_hugepage.sh
> b/lib/newlib_tests/test_zero_hugepage.sh
> index d270e686c..663bd2316 100755
> --- a/lib/newlib_tests/test_zero_hugepage.sh
> +++ b/lib/newlib_tests/test_zero_hugepage.sh
> @@ -3,16 +3,31 @@
>  # Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
>  # Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
>
> +tconf()
> +{
> +       echo "TCONF: $1"
> +       exit 32
> +}
> +
>  echo "Testing .request_hugepages = TST_NO_HUGEPAGES"
>
>  orig_value=`cat /proc/sys/vm/nr_hugepages`
>
>  if grep -q -E '^proc /proc(/sys)? proc ro' /proc/mounts; then
> -       echo "TCONF: /proc or /proc/sys mounted as read-only"
> -       exit 32
> +       tconf "/proc or /proc/sys mounted as read-only"
> +fi
> +
> +if [ ! -f /proc/sys/vm/nr_hugepages ]; then
> +       tconf "/proc/sys/vm/nr_hugepages does not exist"
> +fi
> +
> +if [ ! -w /proc/sys/vm/nr_hugepages ]; then
> +       tconf "no write permission to /proc/sys/vm/nr_hugepages (run as
> root)"
>  fi
>
> -echo "128" > /proc/sys/vm/nr_hugepages
> +if ! echo "128" > /proc/sys/vm/nr_hugepages; then
> +       tconf "Failed to write /proc/sys/vm/nr_hugepages"
> +fi
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

--000000000000bf140d05d041fc3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Nov 5, 2021 at 12:45 AM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Fix running make test-c as non-=
root.<br>
<br>
Fixes: 057d6b046 (&quot;lib/tst_hugepage: Fix .request_hugepages =3D 0 bug&=
quot;)<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
Hi,<br>
<br>
maybe echo &quot;128&quot; would not have to be checked.<br></blockquote><d=
iv><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Ag=
reed, If the system memory is too fragmental to keep</div><div class=3D"gma=
il_default" style=3D"font-size:small">enough hpages, there won&#39;t be an =
error returned.</div><br></div><div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.co=
m">liwang@redhat.com</a>&gt;</div><br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
Kind regards,<br>
Petr<br>
<br>
=C2=A0lib/newlib_tests/test_zero_hugepage.sh | 21 ++++++++++++++++++---<br>
=C2=A01 file changed, 18 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/newlib_tests/test_zero_hugepage.sh b/lib/newlib_tests/test=
_zero_hugepage.sh<br>
index d270e686c..663bd2316 100755<br>
--- a/lib/newlib_tests/test_zero_hugepage.sh<br>
+++ b/lib/newlib_tests/test_zero_hugepage.sh<br>
@@ -3,16 +3,31 @@<br>
=C2=A0# Copyright (c) 2021 Yang Xu &lt;<a href=3D"mailto:xuyang2018.jy@fuji=
tsu.com" target=3D"_blank">xuyang2018.jy@fujitsu.com</a>&gt;<br>
=C2=A0# Copyright (c) 2021 Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz"=
 target=3D"_blank">pvorel@suse.cz</a>&gt;<br>
<br>
+tconf()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TCONF: $1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 32<br>
+}<br>
+<br>
=C2=A0echo &quot;Testing .request_hugepages =3D TST_NO_HUGEPAGES&quot;<br>
<br>
=C2=A0orig_value=3D`cat /proc/sys/vm/nr_hugepages`<br>
<br>
=C2=A0if grep -q -E &#39;^proc /proc(/sys)? proc ro&#39; /proc/mounts; then=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TCONF: /proc or /proc/sys mounted as=
 read-only&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tconf &quot;/proc or /proc/sys mounted as read-=
only&quot;<br>
+fi<br>
+<br>
+if [ ! -f /proc/sys/vm/nr_hugepages ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tconf &quot;/proc/sys/vm/nr_hugepages does not =
exist&quot;<br>
+fi<br>
+<br>
+if [ ! -w /proc/sys/vm/nr_hugepages ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tconf &quot;no write permission to /proc/sys/vm=
/nr_hugepages (run as root)&quot;<br>
=C2=A0fi<br>
<br>
-echo &quot;128&quot; &gt; /proc/sys/vm/nr_hugepages<br>
+if ! echo &quot;128&quot; &gt; /proc/sys/vm/nr_hugepages; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tconf &quot;Failed to write /proc/sys/vm/nr_hug=
epages&quot;<br>
+fi<br>
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

--000000000000bf140d05d041fc3c--


--===============2137002022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2137002022==--

