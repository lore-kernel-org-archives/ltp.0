Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A94C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 07:37:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C19D13C9AE4
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 08:37:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E2353C951F
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 08:37:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DA9E11000F64
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 08:37:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643960247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udqtYU8Ub2Sw89d1Ylddlk14sEmGWIB9BsyT59ZxqQo=;
 b=LGNuAavKygNr5jw9nNNyQDtEOHcA/SfGVYFRD/mZw591CJ9uL7wtJAc/IUFljSIFboJ5Q2
 ZgRv8ZLtMyM4dKruWcrKBTSQ4kb3Z7ZSAb/rGI5ODOpD4oEi58MCCrH4gA14CYMPNNWbyF
 qd6bWOJNDvXxabPOwsRs02TKs2IokBk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-rg7LekIGPNGiJZRUPFcK8g-1; Fri, 04 Feb 2022 02:37:26 -0500
X-MC-Unique: rg7LekIGPNGiJZRUPFcK8g-1
Received: by mail-yb1-f197.google.com with SMTP id
 d65-20020a256844000000b00614359972a6so11188136ybc.16
 for <ltp@lists.linux.it>; Thu, 03 Feb 2022 23:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=udqtYU8Ub2Sw89d1Ylddlk14sEmGWIB9BsyT59ZxqQo=;
 b=EtJxmYDFVY8zqJfFYYz9jIlq1TLfSVXARgd5fG3yrNKISyHZRknrmOA3dAmeCVHJgG
 1hZ2R7CDjNRQYkLted+snH/q3iVSD4CeerdwUH9vvY4blICqDnveKCorOvRBPOYXCYoV
 I3pjYVErbaaKRx7BQIwIo61iRDxtTvobDdsa6mpf343/59pYMe5E5+9jUZ9sl2ZROE/A
 J+LM+pHxfVpemXgp/nI9zbXHQ5805EufS42C3TZW3uRp2Pv5IoC/yJIx7qUk1oQW6J6Q
 95cK+x8Biq9dcHfqEJAxQK4109RQ2qclYNMfDCn2Z5/h1kypNR6YXIlbwSIV3qSDSAL+
 LsLw==
X-Gm-Message-State: AOAM531D2WW9P0jPxPTJ9CHezisyR4qA6DWehS8bLClb2rdJVRV2+OFk
 A/K5l/Kxr2r2C5UyR1sYT0yIu4vUPHkrNukhorCkYZZ4tSlHA8J6dcgKjlC7fOfAnpcrRSKvoXy
 CuvzZ2z1DxtPwByz/GFpk/lSPMls=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr1688846ybp.71.1643960245020;
 Thu, 03 Feb 2022 23:37:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRpN+Zh5YCUBtEEBUj9bO9lP0d8IWJM8AvPOKbmBBVG5uRk5tc7QIVSNO75binMM9FhQ4t3bF+L5iLVUw4WM0=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr1688818ybp.71.1643960244418;
 Thu, 03 Feb 2022 23:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-3-rpalethorpe@suse.com>
In-Reply-To: <20220203081820.29521-3-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Feb 2022 15:37:09 +0800
Message-ID: <CAEemH2cj2yDJDJL3bdL58M-aRAcU+ox3EMHc93gdr87=rXHvsg@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] API/cgroup: Declare required controllers
 and version in test struct
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
Content-Type: multipart/mixed; boundary="===============1656879538=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1656879538==
Content-Type: multipart/alternative; boundary="00000000000064d4e605d72c523e"

--00000000000064d4e605d72c523e
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

This is a good improvement for the CG API. Nice work!!

On Thu, Feb 3, 2022 at 4:20 PM Richard Palethorpe via ltp <
ltp@lists.linux.it> wrote:

> ...

--- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -133,6 +133,14 @@ extern unsigned int tst_variant;
>
>  #define TST_NO_HUGEPAGES ((unsigned long)-1)
>
> +/* CGroups Kernel API version */
> +enum tst_cgroup_ver {
> +       TST_CGROUP_V1 = 1,
> +       TST_CGROUP_V2 = 2,
> +};
>

We can move this into 'tst_cgroup.h' if included that header in tst_test.h.

(As we decide to integrate the CG structure in tst_test, it
seems better to include that tst_cgorup.h file though that
makes some binaries become larger.)

+
> +struct tst_cgroup_group;
>

As Cyril pointed out, this is useless.

+
>  struct tst_test {
>         /* number of tests available in test() function */
>         unsigned int tcnt;
> @@ -280,6 +288,12 @@ struct tst_test {
>
>         /* NULL terminated array of required commands */
>         const char *const *needs_cmds;
> +
> +       /* Requires a particular CGroup API version. */
> +       const enum tst_cgroup_ver needs_cgroup_ver;
> +
> +       /* {} terminated array of required CGroup controllers */
> +       const char *const *needs_cgroup_controllers;
>

Can we use abbreviations for both? just to keep them consistently :).
       const enum tst_cgroup_ver needs_cgroup_ver;
       const char *const *needs_cgroup_ctrls;

or,

       const enum tst_cgroup_ver needs_cgroup_version;
       const char *const *needs_cgroup_controllers;



>  };
>
>  /*
> diff --git a/lib/newlib_tests/tst_cgroup01.c
> b/lib/newlib_tests/tst_cgroup01.c
> index 54a370362..62df9aab2 100644
> --- a/lib/newlib_tests/tst_cgroup01.c
> +++ b/lib/newlib_tests/tst_cgroup01.c
> @@ -22,7 +22,7 @@ static void do_test(void)
>
>  static void setup(void)
>  {
> -       cgopts.only_mount_v1 = !!only_mount_v1,
> +       cgopts.needs_ver = !!only_mount_v1 ? TST_CGROUP_V1 : 0;
>
>         tst_cgroup_scan();
>         tst_cgroup_print_config();
> diff --git a/lib/newlib_tests/tst_cgroup02.c
> b/lib/newlib_tests/tst_cgroup02.c
> index 64b0a1e94..d048c720a 100644
> --- a/lib/newlib_tests/tst_cgroup02.c
> +++ b/lib/newlib_tests/tst_cgroup02.c
> @@ -15,8 +15,6 @@ static struct tst_option opts[] = {
>         {NULL, NULL, NULL},
>  };
>  static struct tst_cgroup_opts cgopts;
> -static const struct tst_cgroup_group *cg;
> -static const struct tst_cgroup_group *cg_drain;
>  static struct tst_cgroup_group *cg_child;
>
>  static void do_test(void)
> @@ -24,12 +22,12 @@ static void do_test(void)
>         char buf[BUFSIZ];
>         size_t mem;
>
> -       if (!TST_CGROUP_VER_IS_V1(cg, "memory"))
> -               SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
> -       if (!TST_CGROUP_VER_IS_V1(cg, "cpuset"))
> -               SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+cpuset");
> +       if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
> +               SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control",
> "+memory");
> +       if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "cpuset"))
> +               SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control",
> "+cpuset");
>
> -       cg_child = tst_cgroup_group_mk(cg, "child");
> +       cg_child = tst_cgroup_group_mk(tst_cgroup, "child");
>         if (!SAFE_FORK()) {
>                 SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d",
> getpid());
>
> @@ -47,19 +45,19 @@ static void do_test(void)
>                 exit(0);
>         }
>
> -       SAFE_CGROUP_PRINTF(cg, "memory.max", "%zu", (1UL << 24) - 1);
> +       SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%zu", (1UL << 24) -
> 1);
>         SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
> -       SAFE_CGROUP_SCANF(cg, "memory.current", "%zu", &mem);
> +       SAFE_CGROUP_SCANF(tst_cgroup, "memory.current", "%zu", &mem);
>         tst_res(TPASS, "memory.current = %zu", mem);
>
>         tst_reap_children();
> -       SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d", getpid());
> +       SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d",
> getpid());
>         cg_child = tst_cgroup_group_rm(cg_child);
>  }
>
>  static void setup(void)
>  {
> -       cgopts.only_mount_v1 = !!only_mount_v1,
> +       cgopts.needs_ver = !!only_mount_v1 ? TST_CGROUP_V1 : 0;
>
>         tst_cgroup_scan();
>         tst_cgroup_print_config();
> @@ -67,14 +65,14 @@ static void setup(void)
>         tst_cgroup_require("memory", &cgopts);
>         tst_cgroup_require("cpuset", &cgopts);
>
> -       cg = tst_cgroup_get_test_group();
> -       cg_drain = tst_cgroup_get_drain_group();
> +       tst_cgroup_init();
>  }
>
>  static void cleanup(void)
>  {
>         if (cg_child) {
> -               SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d",
> getpid());
> +               SAFE_CGROUP_PRINTF(tst_cgroup_drain,
> +                                  "cgroup.procs", "%d", getpid());
>                 cg_child = tst_cgroup_group_rm(cg_child);
>         }
>         if (!no_cleanup)
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 10b65364b..e694d353b 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -138,6 +138,14 @@ struct tst_cgroup_group {
>         struct cgroup_dir *dirs[ROOTS_MAX + 1];
>  };
>
> +/* If controllers are required via the tst_test struct then this is
> + * populated with the test's CGroup.
> + */
> +static struct tst_cgroup_group test_group;
> +static struct tst_cgroup_group drain_group;
> +const struct tst_cgroup_group *const tst_cgroup = &test_group;
> +const struct tst_cgroup_group *const tst_cgroup_drain = &drain_group;
> +
>  /* Always use first item for unified hierarchy */
>  static struct cgroup_root roots[ROOTS_MAX + 1];
>
> @@ -196,7 +204,7 @@ static struct cgroup_ctrl controllers[] = {
>         { }
>  };
>
> -static const struct tst_cgroup_opts default_opts = { 0 };
> +static const struct tst_cgroup_opts default_opts;
>

I'm wondering is there still a need this 'default_opts'?

Since we have defined 'cg_opts' in do_cgroup_requires for the
whole library. So that 'default_opts' is redundant from now on.



-- 
Regards,
Li Wang

--00000000000064d4e605d72c523e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>This is a good improvement for the CG API. Nice work!!</div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 3,=
 2022 at 4:20 PM Richard Palethorpe via ltp &lt;<a href=3D"mailto:ltp@lists=
.linux.it" target=3D"_blank">ltp@lists.linux.it</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail_default=
" style=3D"font-size:small">...</span></blockquote><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
--- a/include/tst_test.h<br>
+++ b/include/tst_test.h<br>
@@ -133,6 +133,14 @@ extern unsigned int tst_variant;<br>
<br>
=C2=A0#define TST_NO_HUGEPAGES ((unsigned long)-1)<br>
<br>
+/* CGroups Kernel API version */<br>
+enum tst_cgroup_ver {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_CGROUP_V1 =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_CGROUP_V2 =3D 2,<br>
+};<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">We can move this into &#39;tst_cgroup.h&#39; if included tha=
t header in tst_test.h.</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">(=
As we decide to integrate the CG structure in tst_test, it<br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">seems better to include tha=
t tst_cgorup.h file though that</div><div class=3D"gmail_default" style=3D"=
font-size:small">makes some binaries become larger.)</div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
+<br>
+struct tst_cgroup_group;<br></blockquote><div><br></div><div class=3D"gmai=
l_default" style=3D"font-size:small">As Cyril pointed out, this is useless.=
</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div=
 class=3D"gmail_default" style=3D"font-size:small"></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+<br>
=C2=A0struct tst_test {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* number of tests available in test() function=
 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int tcnt;<br>
@@ -280,6 +288,12 @@ struct tst_test {<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* NULL terminated array of required commands *=
/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *const *needs_cmds;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Requires a particular CGroup API version. */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const enum tst_cgroup_ver needs_cgroup_ver;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* {} terminated array of required CGroup contr=
ollers */<br>
<span class=3D"gmail_default" style=3D"font-size:small"></span>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *const *needs_cgroup_controllers;<br></blockquo=
te><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:smal=
l">Can we use abbreviations for both? just to keep them consistently :).</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"></div><span class=
=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0const enum tst_cgroup_ver needs_cgroup_ver;<br><div class=3D"gmail_de=
fault" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *con=
st *needs_cgroup_ctrls;</div><br></div><div><div class=3D"gmail_default" st=
yle=3D"font-size:small">or,</div><div class=3D"gmail_default" style=3D"font=
-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l"><span class=3D"gmail_default">=C2=A0</span>=C2=A0 =C2=A0 =C2=A0 const en=
um tst_cgroup_ver needs_cgroup_version;<br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"><span class=3D"gmail_default"></span>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0const char *const *needs_cgroup_controllers;</div><br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0};<br>
<br>
=C2=A0/*<br>
diff --git a/lib/newlib_tests/tst_cgroup01.c b/lib/newlib_tests/tst_cgroup0=
1.c<br>
index 54a370362..62df9aab2 100644<br>
--- a/lib/newlib_tests/tst_cgroup01.c<br>
+++ b/lib/newlib_tests/tst_cgroup01.c<br>
@@ -22,7 +22,7 @@ static void do_test(void)<br>
<br>
=C2=A0static void setup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cgopts.only_mount_v1 =3D !!only_mount_v1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cgopts.needs_ver =3D !!only_mount_v1 ? TST_CGRO=
UP_V1 : 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_cgroup_scan();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_cgroup_print_config();<br>
diff --git a/lib/newlib_tests/tst_cgroup02.c b/lib/newlib_tests/tst_cgroup0=
2.c<br>
index 64b0a1e94..d048c720a 100644<br>
--- a/lib/newlib_tests/tst_cgroup02.c<br>
+++ b/lib/newlib_tests/tst_cgroup02.c<br>
@@ -15,8 +15,6 @@ static struct tst_option opts[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {NULL, NULL, NULL},<br>
=C2=A0};<br>
=C2=A0static struct tst_cgroup_opts cgopts;<br>
-static const struct tst_cgroup_group *cg;<br>
-static const struct tst_cgroup_group *cg_drain;<br>
=C2=A0static struct tst_cgroup_group *cg_child;<br>
<br>
=C2=A0static void do_test(void)<br>
@@ -24,12 +22,12 @@ static void do_test(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char buf[BUFSIZ];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t mem;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!TST_CGROUP_VER_IS_V1(cg, &quot;memory&quot=
;))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINT(c=
g, &quot;cgroup.subtree_control&quot;, &quot;+memory&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!TST_CGROUP_VER_IS_V1(cg, &quot;cpuset&quot=
;))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINT(c=
g, &quot;cgroup.subtree_control&quot;, &quot;+cpuset&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!TST_CGROUP_VER_IS_V1(tst_cgroup, &quot;mem=
ory&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINT(t=
st_cgroup, &quot;cgroup.subtree_control&quot;, &quot;+memory&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!TST_CGROUP_VER_IS_V1(tst_cgroup, &quot;cpu=
set&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINT(t=
st_cgroup, &quot;cgroup.subtree_control&quot;, &quot;+cpuset&quot;);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cg_child =3D tst_cgroup_group_mk(cg, &quot;chil=
d&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cg_child =3D tst_cgroup_group_mk(tst_cgroup, &q=
uot;child&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!SAFE_FORK()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_CGROUP_PRINTF(=
cg_child, &quot;cgroup.procs&quot;, &quot;%d&quot;, getpid());<br>
<br>
@@ -47,19 +45,19 @@ static void do_test(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINTF(cg, &quot;memory.max&quot;, =
&quot;%zu&quot;, (1UL &lt;&lt; 24) - 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINTF(tst_cgroup, &quot;memory.max=
&quot;, &quot;%zu&quot;, (1UL &lt;&lt; 24) - 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_CGROUP_PRINTF(cg_child, &quot;cgroup.procs=
&quot;, &quot;%d&quot;, getpid());<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_SCANF(cg, &quot;memory.current&quot=
;, &quot;%zu&quot;, &amp;mem);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_SCANF(tst_cgroup, &quot;memory.curr=
ent&quot;, &quot;%zu&quot;, &amp;mem);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TPASS, &quot;memory.current =3D %zu&quo=
t;, mem);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_reap_children();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINTF(cg_drain, &quot;cgroup.procs=
&quot;, &quot;%d&quot;, getpid());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINTF(tst_cgroup_drain, &quot;cgro=
up.procs&quot;, &quot;%d&quot;, getpid());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cg_child =3D tst_cgroup_group_rm(cg_child);<br>
=C2=A0}<br>
<br>
=C2=A0static void setup(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cgopts.only_mount_v1 =3D !!only_mount_v1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cgopts.needs_ver =3D !!only_mount_v1 ? TST_CGRO=
UP_V1 : 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_cgroup_scan();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_cgroup_print_config();<br>
@@ -67,14 +65,14 @@ static void setup(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_cgroup_require(&quot;memory&quot;, &amp;cgo=
pts);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_cgroup_require(&quot;cpuset&quot;, &amp;cgo=
pts);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cg =3D tst_cgroup_get_test_group();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cg_drain =3D tst_cgroup_get_drain_group();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_cgroup_init();<br>
=C2=A0}<br>
<br>
=C2=A0static void cleanup(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cg_child) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINTF(=
cg_drain, &quot;cgroup.procs&quot;, &quot;%d&quot;, getpid());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CGROUP_PRINTF(=
tst_cgroup_drain,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cgroup.procs&quot;, &qu=
ot;%d&quot;, getpid());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cg_child =3D tst_cg=
roup_group_rm(cg_child);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!no_cleanup)<br>
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c<br>
index 10b65364b..e694d353b 100644<br>
--- a/lib/tst_cgroup.c<br>
+++ b/lib/tst_cgroup.c<br>
@@ -138,6 +138,14 @@ struct tst_cgroup_group {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cgroup_dir *dirs[ROOTS_MAX + 1];<br>
=C2=A0};<br>
<br>
+/* If controllers are required via the tst_test struct then this is<br>
+ * populated with the test&#39;s CGroup.<br>
+ */<br>
+static struct tst_cgroup_group test_group;<br>
+static struct tst_cgroup_group drain_group;<br>
+const struct tst_cgroup_group *const tst_cgroup =3D &amp;test_group;<br>
+const struct tst_cgroup_group *const tst_cgroup_drain =3D &amp;drain_group=
;<br>
+<br>
=C2=A0/* Always use first item for unified hierarchy */<br>
=C2=A0static struct cgroup_root roots[ROOTS_MAX + 1];<br>
<br>
@@ -196,7 +204,7 @@ static struct cgroup_ctrl controllers[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { }<br>
=C2=A0};<br>
<br>
-static const struct tst_cgroup_opts default_opts =3D { 0 };<br>
+static const struct tst_cgroup_opts default_opts;<br></blockquote><div><br=
></div><div><div class=3D"gmail_default" style=3D"font-size:small">I&#39;m =
wondering is there still a need this=C2=A0&#39;default_opts&#39;?</div><div=
 class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">Since we have defined &#39;cg_opts=
&#39; in do_cgroup_requires for the</div><div class=3D"gmail_default" style=
=3D"font-size:small">whole library. So that &#39;default_opts&#39; is redun=
dant from now on.</div></div><div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div>=C2=A0</div></div><div><br></div>-- <br>=
<div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></=
div></div></div></div>

--00000000000064d4e605d72c523e--


--===============1656879538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1656879538==--

