Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89CCC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 08:18:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 174FB3C9B46
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 09:18:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6CEC3C26B4
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 09:18:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 77E42600826
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 09:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644308324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKLX02/Y38A8/Lh8C1ERKw8Qoh/zEWZCD7lKKzn66Es=;
 b=Jz+L8o206PRfGUWaGyqmAC6xbGRPEDP2zD6J/eBsbiTAMh9X0raKB9XJZ0RS37Qt88HaPY
 RayVHlY+7WoLddbaTTmrlrw3IBdcXh9d7C+Qrql+vzC4sry33YxoYgsO9Noc0x9TTEQrpR
 vqjI3d7k8UL94Ou0XerB31ZGGzsMm7g=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-ObQuYmGdMECqgIJtxhFzFA-1; Tue, 08 Feb 2022 03:18:42 -0500
X-MC-Unique: ObQuYmGdMECqgIJtxhFzFA-1
Received: by mail-yb1-f199.google.com with SMTP id
 f32-20020a25b0a0000000b0061dad37dcd6so11419926ybj.16
 for <ltp@lists.linux.it>; Tue, 08 Feb 2022 00:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZKLX02/Y38A8/Lh8C1ERKw8Qoh/zEWZCD7lKKzn66Es=;
 b=05kBrSKma7ttoexh+FZmAE5h/TCvKd2st8JsZQrPYXXOTAAl8xlGoxdFPzNbZmUOoe
 qfkpS8bjfsxB9kNw5U93k9fFSc5tqDmhBp9ZcTd4viUk5J1uOqkE8sBEzDKc7tyJo3WJ
 NvOQ0P1XzcBl5iRmVedy9OG8qwS8bRhzjKfAvNJJduC0qeDK5T/oN9uqTV0WLfMq2hx3
 tUpuT6UEXR1u65FDHK7uFUqYyTAfARO9KR+ReQ/aHYdEymIqLe3pW77d8SgGUVFB8smE
 3d/kl1/SziRviN+KRE9a76Act+vYbqKfs9u375A0lv5Nhqetd9NxPyI+KB4Qu13MpMvS
 D1Fg==
X-Gm-Message-State: AOAM5314HlljeH/7ZXGB1Ict5rxBFuSokziqdw7dRCJFxKDvUfT4Law0
 EiuJZ+e3ubvyj2CMny4kXD0tcSiGdr6lTUHCW3KhAZprcVAf9WZz3MEkCCNX1hshRdGuxSCro80
 WAhwitgvmZQYhR4IrQLyeHezooRE=
X-Received: by 2002:a25:45:: with SMTP id 66mr2021717yba.102.1644308322120;
 Tue, 08 Feb 2022 00:18:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUcT+Pt6tIwNag1N6+jC40pdg9HoRHbNC3yliyStABADR2dz9A6UjudqPRganwxdXZrb2pXr+qVQeU7TR+BxI=
X-Received: by 2002:a25:45:: with SMTP id 66mr2021709yba.102.1644308321939;
 Tue, 08 Feb 2022 00:18:41 -0800 (PST)
MIME-Version: 1.0
References: <YfPiW998P4/j7RWi@pevik>
 <20220203101803.10204-1-rpalethorpe@suse.com>
In-Reply-To: <20220203101803.10204-1-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 16:18:24 +0800
Message-ID: <CAEemH2f6ka-vK+O33cxw1ewMWDYZQwtRZUQ3eKFMkynqB2+R3w@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Create policy for testing unstable kernel features
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
Content-Type: multipart/mixed; boundary="===============0093365007=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0093365007==
Content-Type: multipart/alternative; boundary="0000000000006e47eb05d77d5d6c"

--0000000000006e47eb05d77d5d6c
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 3, 2022 at 6:20 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> It's not clear if anything more than this is required for now.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

> ---
>
>  doc/test-writing-guidelines.txt | 10 ++++++++++
>  runtest/staging                 |  1 +
>  2 files changed, 11 insertions(+)
>  create mode 100644 runtest/staging
>
> diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> index 1fa751ed5..8ca014d45 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -334,3 +334,13 @@ It's easier to maintain a '.gitignore' file per
> directory with tests, rather
>  than having single file in the project root directory. This way, we don't
> have
>  to update all the gitignore files when moving directories, and they get
> deleted
>  automatically when a directory with tests is removed.
> +
> +7 Testing pre-release kernel features
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Tests for features not yet in a mainline kernel release are accepted.
> However
> +they must only be added to the +staging+ runtest file. Once a feature is
> part
> +of the stable kernel ABI the associated test must be moved out of staging.
> +
> +This is primarily to help test kernel RCs by avoiding the need to download
> +separate LTP patchsets.
> diff --git a/runtest/staging b/runtest/staging
> new file mode 100644
> index 000000000..ef1cdea15
> --- /dev/null
> +++ b/runtest/staging
> @@ -0,0 +1 @@
> +# Tests for features that are not yet in the stable kernel ABI
> --
> 2.34.1
>
>

-- 
Regards,
Li Wang

--0000000000006e47eb05d77d5d6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Feb 3, 2022 at 6:20 PM Richard Palethorpe &=
lt;<a href=3D"mailto:rpalethorpe@suse.com">rpalethorpe@suse.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">It&#39;s not=
 clear if anything more than this is required for now.<br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br></blockquote><div><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: L=
i Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@re=
dhat.com</a>&gt;</div><div class=3D"gmail_default" style=3D"font-size:small=
"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
<br>
=C2=A0doc/test-writing-guidelines.txt | 10 ++++++++++<br>
=C2=A0runtest/staging=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A02 files changed, 11 insertions(+)<br>
=C2=A0create mode 100644 runtest/staging<br>
<br>
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.=
txt<br>
index 1fa751ed5..8ca014d45 100644<br>
--- a/doc/test-writing-guidelines.txt<br>
+++ b/doc/test-writing-guidelines.txt<br>
@@ -334,3 +334,13 @@ It&#39;s easier to maintain a &#39;.gitignore&#39; fil=
e per directory with tests, rather<br>
=C2=A0than having single file in the project root directory. This way, we d=
on&#39;t have<br>
=C2=A0to update all the gitignore files when moving directories, and they g=
et deleted<br>
=C2=A0automatically when a directory with tests is removed.<br>
+<br>
+7 Testing pre-release kernel features<br>
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
+<br>
+Tests for features not yet in a mainline kernel release are accepted. Howe=
ver<br>
+they must only be added to the +staging+ runtest file. Once a feature is p=
art<br>
+of the stable kernel ABI the associated test must be moved out of staging.=
<br>
+<br>
+This is primarily to help test kernel RCs by avoiding the need to download=
<br>
+separate LTP patchsets.<br>
diff --git a/runtest/staging b/runtest/staging<br>
new file mode 100644<br>
index 000000000..ef1cdea15<br>
--- /dev/null<br>
+++ b/runtest/staging<br>
@@ -0,0 +1 @@<br>
+# Tests for features that are not yet in the stable kernel ABI<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000006e47eb05d77d5d6c--


--===============0093365007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0093365007==--

