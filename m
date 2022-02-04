Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F37C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 06:42:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 029033C9AE2
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 07:42:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BE673C9736
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 07:42:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5685D1A000B3
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 07:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643956936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8PCz/P+cfAvz7Ywq0bpKlH9iTF5RTCdxrPiq1q03ovY=;
 b=Psstm/ykysYRDptx35vVIHnJWfTGHXHhUw8eCZyM33OmFn6mDRBIQDfoneo2cFmfgH/n9W
 FFLB+n3TJJbQMODfbxy4jK6d92qDmQyK/xbNa6YuKcsS41ZaenXUofcZqVjDiIg3qDFlW+
 KhYa09Vx1D5AIlYpAeWdTZduc9Sxsac=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-R-SYlYXYM7S30Y27j0M-GA-1; Fri, 04 Feb 2022 01:42:13 -0500
X-MC-Unique: R-SYlYXYM7S30Y27j0M-GA-1
Received: by mail-yb1-f197.google.com with SMTP id
 b2-20020a252e42000000b00619593ff8ddso11101938ybn.6
 for <ltp@lists.linux.it>; Thu, 03 Feb 2022 22:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8PCz/P+cfAvz7Ywq0bpKlH9iTF5RTCdxrPiq1q03ovY=;
 b=2asq8JxE/xh9iv+2vFatwCYvLQXJxnWiCFhNjLib0+vW/uLr3Dbu3+CCU0QA5vksPr
 eFZMeWt01ko1LWwQZZHgcydgQIXsQsf8avKlvbKSKct2plQFS58kSroltnaLWt4MkNdr
 EImP1ATruXmAgLN95afnq9uqGBUEpOMU0prXXegleCwD+VevNw+8psc9OECIWi1kKXeQ
 ijxkUyhrUHN9I6byvcrTK4jzDlIWFxuVlTdg0umQabfDr9aqAyl8c8+JvCRWm87J0fa4
 120a0FgUrKyPMY+LXxaiTytQpAMw4Dtzjf5IQz7ngPy9SEbz4nK/FXRaYN3hXsu7FS95
 chAg==
X-Gm-Message-State: AOAM531ppIs498+lekmmQ4fWJmKF3g7wyVd7Cm6nvf9h6n1n+HLtJXOy
 yjn5kZh1xngyxCSNE4r7areRjcrQ6c/BlHWqBj564W94Nd98rXGLLLLiSYhubGCg0wzyTajDJBf
 8TKcEl8zQGm7RE2dIJ/Jh5wUog9M=
X-Received: by 2002:a5b:38f:: with SMTP id k15mr1552859ybp.421.1643956932462; 
 Thu, 03 Feb 2022 22:42:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxN1zgLtClOIADwtjx4Ztb1MEUxRAvbXf9wuD3zTp9j1dLWUpfmNPVw4sbYAGbaAZQHexEcnYT1nl7bgRfPSaw=
X-Received: by 2002:a5b:38f:: with SMTP id k15mr1552847ybp.421.1643956932101; 
 Thu, 03 Feb 2022 22:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-6-rpalethorpe@suse.com>
In-Reply-To: <20220203081820.29521-6-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Feb 2022 14:41:57 +0800
Message-ID: <CAEemH2f6PYXGEDrARM7JKCr08K-GEfRa9xJKPLChSG6bnvVpoA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] API/cgroup: Make tst_cgroup_group_mk
 sprintf like
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
Content-Type: multipart/mixed; boundary="===============0062393357=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0062393357==
Content-Type: multipart/alternative; boundary="000000000000f6e11405d72b8c68"

--000000000000f6e11405d72b8c68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 3, 2022 at 4:20 PM Richard Palethorpe via ltp <
ltp@lists.linux.it> wrote:

> Allows the name to be formatted which is trivial because we already
> copy it into a buffer. Also this removes the init function which is
> now just unnecessary verbiage.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_cgroup.h |  5 +++--
>  lib/tst_cgroup.c     | 29 ++++++++++++-----------------
>  2 files changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> index 17adefd2b..d7a3433fa 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -126,8 +126,9 @@ void tst_cgroup_init(void);
>  /* Create a descendant CGroup */
>  struct tst_cgroup_group *
>  tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
> -                   const char *const group_name)
> -                   __attribute__ ((nonnull, warn_unused_result));
> +                   const char *const group_name_fmt, ...)
> +           __attribute__ ((nonnull, warn_unused_result, format (printf,
> 2, 3)));
>

Seems this is too strict for some compiling.  e.g.

cfs_bandwidth01.c: In function =E2=80=98mk_cpu_cgroup=E2=80=99:
cfs_bandwidth01.c:64:9: error: format not a string literal and no format
arguments [-Werror=3Dformat-security]
   64 |         *cg =3D tst_cgroup_group_mk(cg_parent, cg_child_name);
      |         ^
cc1: some warnings being treated as errors
make: *** [../../../../include/mk/rules.mk:37: cfs_bandwidth01] Error 1

gcc version 11.2.1 20211203 (Red Hat 11.2.1-7) (GCC)



> +
>  const char *
>  tst_cgroup_group_name(const struct tst_cgroup_group *const cg)
>                       __attribute__ ((nonnull, warn_unused_result));
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index d9cd6aa8e..66f17575e 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -840,21 +840,6 @@ clear_data:
>         memset(roots, 0, sizeof(roots));
>  }
>
> -__attribute__((nonnull(1)))
> -static void cgroup_group_init(struct tst_cgroup_group *const cg,
> -                             const char *const group_name)
> -{
> -       memset(cg, 0, sizeof(*cg));
> -
> -       if (!group_name)
> -               return;
> -
> -       if (strlen(group_name) > NAME_MAX)
> -               tst_brk(TBROK, "Group name is too long");
> -
> -       strcpy(cg->group_name, group_name);
> -}
> -
>  __attribute__((nonnull(2, 3)))
>  static void cgroup_group_add_dir(const struct tst_cgroup_group *const
> parent,
>                                  struct tst_cgroup_group *const cg,
> @@ -886,14 +871,24 @@ static void cgroup_group_add_dir(const struct
> tst_cgroup_group *const parent,
>
>  struct tst_cgroup_group *
>  tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
> -                   const char *const group_name)
> +                   const char *const group_name_fmt, ...)
>  {
>         struct tst_cgroup_group *cg;
>         struct cgroup_dir *const *dir;
>         struct cgroup_dir *new_dir;
> +       va_list ap;
> +       size_t name_len;
>
>         cg =3D SAFE_MALLOC(sizeof(*cg));
> -       cgroup_group_init(cg, group_name);
> +       memset(cg, 0, sizeof(*cg));
> +
> +       va_start(ap, group_name_fmt);
> +       name_len =3D vsnprintf(cg->group_name, NAME_MAX,
> +                            group_name_fmt, ap);
> +       va_end(ap);
> +
> +       if (name_len >=3D NAME_MAX)
> +               tst_brk(TBROK, "CGroup name is too long");
>
>         for_each_dir(parent, 0, dir) {
>                 new_dir =3D SAFE_MALLOC(sizeof(*new_dir));
> --
> 2.34.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

--=20
Regards,
Li Wang

--000000000000f6e11405d72b8c68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Feb 3, 2022 at 4:20 PM Richard Palethorpe v=
ia ltp &lt;<a href=3D"mailto:ltp@lists.linux.it" target=3D"_blank">ltp@list=
s.linux.it</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Allows the name to be formatted which is trivial because we alre=
ady<br>
copy it into a buffer. Also this removes the init function which is<br>
now just unnecessary verbiage.<br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
Suggested-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt;<br>
---<br>
=C2=A0include/tst_cgroup.h |=C2=A0 5 +++--<br>
=C2=A0lib/tst_cgroup.c=C2=A0 =C2=A0 =C2=A0| 29 ++++++++++++----------------=
-<br>
=C2=A02 files changed, 15 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h<br>
index 17adefd2b..d7a3433fa 100644<br>
--- a/include/tst_cgroup.h<br>
+++ b/include/tst_cgroup.h<br>
@@ -126,8 +126,9 @@ void tst_cgroup_init(void);<br>
=C2=A0/* Create a descendant CGroup */<br>
=C2=A0struct tst_cgroup_group *<br>
=C2=A0tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 char *const group_name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__att=
ribute__ ((nonnull, warn_unused_result));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 char *const group_name_fmt, ...)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__attribute__ ((nonnull, warn_unu=
sed_result, format (printf, 2, 3)));<br></blockquote><div><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Seems this is too strict fo=
r some compiling.=C2=A0 e.g.</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">cfs_bandwidth01.c: In function =E2=80=98mk_cpu_cgroup=E2=80=99:<br>cfs_=
bandwidth01.c:64:9: error: format not a string literal and no format argume=
nts [-Werror=3Dformat-security]<br>=C2=A0 =C2=A064 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *cg =3D tst_cgroup_group_mk(cg_parent, cg_child_name);<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>cc1: some warnings being trea=
ted as errors<br>make: *** [../../../../include/mk/<a href=3D"http://rules.=
mk:37" target=3D"_blank">rules.mk:37</a>: cfs_bandwidth01] Error 1<br></div=
><div class=3D"gmail_default" style=3D"font-size:small"></div><div class=3D=
"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_def=
ault" style=3D"font-size:small"><div class=3D"gmail_default">gcc version 11=
.2.1 20211203 (Red Hat 11.2.1-7) (GCC)</div><div class=3D"gmail_default"><b=
r></div></div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0const char *<br>
=C2=A0tst_cgroup_group_name(const struct tst_cgroup_group *const cg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __attribute__ ((nonnull, warn_unused_result));<br>
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c<br>
index d9cd6aa8e..66f17575e 100644<br>
--- a/lib/tst_cgroup.c<br>
+++ b/lib/tst_cgroup.c<br>
@@ -840,21 +840,6 @@ clear_data:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(roots, 0, sizeof(roots));<br>
=C2=A0}<br>
<br>
-__attribute__((nonnull(1)))<br>
-static void cgroup_group_init(struct tst_cgroup_group *const cg,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *const group_name)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(cg, 0, sizeof(*cg));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!group_name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strlen(group_name) &gt; NAME_MAX)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK, &quo=
t;Group name is too long&quot;);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(cg-&gt;group_name, group_name);<br>
-}<br>
-<br>
=C2=A0__attribute__((nonnull(2, 3)))<br>
=C2=A0static void cgroup_group_add_dir(const struct tst_cgroup_group *const=
 parent,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tst_cgroup_group *const=
 cg,<br>
@@ -886,14 +871,24 @@ static void cgroup_group_add_dir(const struct tst_cgr=
oup_group *const parent,<br>
<br>
=C2=A0struct tst_cgroup_group *<br>
=C2=A0tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 char *const group_name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 char *const group_name_fmt, ...)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tst_cgroup_group *cg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cgroup_dir *const *dir;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cgroup_dir *new_dir;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0va_list ap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t name_len;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cg =3D SAFE_MALLOC(sizeof(*cg));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cgroup_group_init(cg, group_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(cg, 0, sizeof(*cg));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0va_start(ap, group_name_fmt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0name_len =3D vsnprintf(cg-&gt;group_name, NAME_=
MAX,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 group_name_fmt, ap);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0va_end(ap);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (name_len &gt;=3D NAME_MAX)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK, &quo=
t;CGroup name is too long&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for_each_dir(parent, 0, dir) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_dir =3D SAFE_MA=
LLOC(sizeof(*new_dir));<br>
-- <br>
2.34.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000f6e11405d72b8c68--


--===============0062393357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0062393357==--

