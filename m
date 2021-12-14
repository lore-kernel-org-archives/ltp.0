Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985AC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 07:46:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB5E53C8C51
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 08:46:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1498B3C0939
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 08:46:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8CBB140138B
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 08:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639467978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TK3jmsQTcKJVHq14/LFPwSwTJTZ81oy+8/jC7Dx/c2A=;
 b=U4esIH32wJr2QhWRoB/4BqgX2xsC0kAqxIhORWxkROWMmuBQRoz3jz/6lfGpOMFaPFTQaH
 omfgk/4k3pqvOg/2Ap3Ds4j9MV4/As/wczthsIdJFG40r5FZZ03EBB3pRIV4V/R/kI8EOA
 7uaJ4ZZDnDaslLlbmnrgCwJYEDYjAXc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-sOxQviolMDe3Dix3S84zPQ-1; Tue, 14 Dec 2021 02:46:15 -0500
X-MC-Unique: sOxQviolMDe3Dix3S84zPQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 t24-20020a252d18000000b005c225ae9e16so35080073ybt.15
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 23:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TK3jmsQTcKJVHq14/LFPwSwTJTZ81oy+8/jC7Dx/c2A=;
 b=h/CVf2nWKBYav82WLoy441h6haX3h2HKTdrct0yoxbzZ0RiOxLw8tRAxxTPBYK0EU9
 +PpzWtGj4VVqMfXnuf7crUdSZYKP2JnxMJo9DxXtKcekv5p7xlpNgy9ThjLv5wJ9iSSD
 Zn1fjSwf8J8UsnnjBm/dOCSdsxksN2d5dleHjkz3kycL44bP/9ExmE6sgmfNxgoETnWU
 JXqgpzhcCYZdwehmcevXaKwctX8UL5NQPMFRS+6lFPNxKd7B7v7o6tvrchd51+4/+Kn0
 ag2xxhiUk4ZPbLalYVO6RCve0Z4u1Nbu5Nm8J/HywTJO67tlNI2nYA+qPpiLD/PBCWfv
 TYbA==
X-Gm-Message-State: AOAM532wl4JmJZt+bCFftDZkD3aT0aODmIlfLrM1ydO0WNu5ZrfOoIb3
 3BN13C31GzMaQ1a5ounFVTNDVKLOmdWZlQH5SV5UYr/jgEqjzqEJ8M7rSV78Fgy1ZEyYU8OqQsg
 E2cXe8ytycfJtiSwY6dfqDZDb4Ng=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr4163069ybs.421.1639467974717; 
 Mon, 13 Dec 2021 23:46:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDAKvxghQ0wxygW5VLw4yWrB6mmYqfVVKWtqCM/ge8LrwKUsDV7dypnNDFVs71eVD7poSAE0uFDbfgKuxthfc=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr4163047ybs.421.1639467974467; 
 Mon, 13 Dec 2021 23:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20211213193419.13414-1-pvorel@suse.cz>
In-Reply-To: <20211213193419.13414-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Dec 2021 15:46:01 +0800
Message-ID: <CAEemH2dp55yFvaXhq_5e77k6QBnY0aFU5fhz4TjW82bkbwwDiA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add support for debugging
 .all_filesystems
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
Content-Type: multipart/mixed; boundary="===============0817239262=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0817239262==
Content-Type: multipart/alternative; boundary="0000000000003d381205d3166209"

--0000000000003d381205d3166209
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 14, 2021 at 3:34 AM Petr Vorel <pvorel@suse.cz> wrote:

> LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE environment variable tests only that
> filesystem instead of all supported filesystems.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/user-guide.txt           | 2 ++
>  lib/tst_supported_fs_types.c | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/doc/user-guide.txt b/doc/user-guide.txt
> index 6a9fb33005..098916d23d 100644
> --- a/doc/user-guide.txt
> +++ b/doc/user-guide.txt
> @@ -15,6 +15,8 @@ For running LTP network tests see
> `testcases/network/README.md`.
>                            'n' or '0': never colorize.
>  | 'LTP_DEV'             | Path to the block device to be used
>                            (C: '.needs_device = 1', shell:
> 'TST_NEEDS_DEVICE=1').
> +| 'LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE' | Testing only specified filesystem
> instead all
> +                          supported (for tests with '.all_filesystems').
>


My only concern is that the variable name is too long and not easy
to remember/understand usage. Can we find a better name?
    LTP_ONE_FS_TYPE
    LTP_ASGD_FD_TYPE
    LTP_FS_TYPE_DEBUG
or some else.

P.s.
And btw I often use .skip_filesystems skip other FS for debugging :).



>  | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
>  | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is
> useful for
>                            slow machines to avoid unexpected timeout).
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index fc072cadfd..f61c3e503d 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -139,8 +139,17 @@ const char **tst_get_supported_fs_types(const char
> *const *skiplist)
>         unsigned int i, j = 0;
>         int skip_fuse;
>         enum tst_fs_impl sup;
> +       const char *only_fs;
>
>         skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
> +       only_fs = getenv("LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE");
> +
> +       if (only_fs) {
> +               tst_res(TINFO, "WARNING: testing only %s", only_fs);
> +               if (tst_fs_is_supported(only_fs))
> +                       fs_types[0] = only_fs;
> +               return fs_types;
> +       }
>
>         for (i = 0; fs_type_whitelist[i]; i++) {
>                 if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist)) {
> --
> 2.34.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000003d381205d3166209
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 14, 2021 at 3:34 AM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">LTP_ALL_FILESYSTEMS_ONLY_FS_TYP=
E environment variable tests only that<br>
filesystem instead of all supported filesystems.<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
=C2=A0doc/user-guide.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0lib/tst_supported_fs_types.c | 9 +++++++++<br>
=C2=A02 files changed, 11 insertions(+)<br>
<br>
diff --git a/doc/user-guide.txt b/doc/user-guide.txt<br>
index 6a9fb33005..098916d23d 100644<br>
--- a/doc/user-guide.txt<br>
+++ b/doc/user-guide.txt<br>
@@ -15,6 +15,8 @@ For running LTP network tests see `testcases/network/READ=
ME.md`.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;n&#39; or &#39;0&#39;: never colorize.<br>
=C2=A0| &#39;LTP_DEV&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
Path to the block device to be used<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(C: &#39;.needs_device =3D 1&#39;, shell: &#39;TST_=
NEEDS_DEVICE=3D1&#39;).<br>
+| &#39;LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE&#39; | Testing only specified file=
system instead all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 supported (for tests with &#39;.all_filesystems&#39;).<br=
></blockquote><div><br></div><div><br></div><div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">My only concern is that the variable name is t=
oo long and not easy</div><div class=3D"gmail_default" style=3D"font-size:s=
mall">to remember/understand usage. Can we find a better name?</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 LTP_ONE_FS_TY=
PE=C2=A0<br></div><div class=3D"gmail_default" style=3D"font-size:small">=
=C2=A0 =C2=A0 LTP_ASGD_FD_TYPE</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">=C2=A0 =C2=A0 LTP_FS_TYPE_DEBUG=C2=A0</div><div class=3D"gm=
ail_default" style=3D"font-size:small">or some else.</div><br></div><div><d=
iv class=3D"gmail_default" style=3D"font-size:small">P.s.</div></div><div><=
div class=3D"gmail_default" style=3D"font-size:small">And btw I often use .=
skip_filesystems skip other FS for debugging :).</div><br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0| &#39;LTP_DEV_FS_TYPE&#39;=C2=A0 =C2=A0 =C2=A0| Filesystem used for =
testing (default: &#39;ext2&#39;).<br>
=C2=A0| &#39;LTP_TIMEOUT_MUL&#39;=C2=A0 =C2=A0 =C2=A0| Multiply timeout, mu=
st be number &gt;=3D 1 (&gt; 1 is useful for<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0slow machines to avoid unexpected timeout).<br>
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c<br=
>
index fc072cadfd..f61c3e503d 100644<br>
--- a/lib/tst_supported_fs_types.c<br>
+++ b/lib/tst_supported_fs_types.c<br>
@@ -139,8 +139,17 @@ const char **tst_get_supported_fs_types(const char *co=
nst *skiplist)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int i, j =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int skip_fuse;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum tst_fs_impl sup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *only_fs;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 skip_fuse =3D tst_fs_in_skiplist(&quot;fuse&quo=
t;, skiplist);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0only_fs =3D getenv(&quot;LTP_ALL_FILESYSTEMS_ON=
LY_FS_TYPE&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (only_fs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quo=
t;WARNING: testing only %s&quot;, only_fs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_fs_is_suppo=
rted(only_fs))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fs_types[0] =3D only_fs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fs_types;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; fs_type_whitelist[i]; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tst_fs_in_skipl=
ist(fs_type_whitelist[i], skiplist)) {<br>
-- <br>
2.34.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000003d381205d3166209--


--===============0817239262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0817239262==--

