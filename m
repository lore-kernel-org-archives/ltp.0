Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D40ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 02:43:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 047E33CAD71
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 04:43:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F3563CAD3E
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 04:43:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 28EA91400526
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 04:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663901001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O21xkz9JhgO/Nh+zhUhVdSb2TJmF41eTEC3dcspIhUg=;
 b=acKzfiJW7oFCwWAsBwt0Ht5jC0yV+1XOkkWNdGD2DHm80va64ss/vOFgXR7+vp18muqo1B
 osT8pABuittLr8pq2MUMsZ4Og4ri20TSGbS2Bp+XkB/JCwPusVN2mQR3ZeHfVgS73x7sgs
 xWZpyf1V5GxrgW1ONqeVR7LC3BEfJcI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-217-i3BXo0y8O5-2wDxkEQY1lA-1; Thu, 22 Sep 2022 22:43:19 -0400
X-MC-Unique: i3BXo0y8O5-2wDxkEQY1lA-1
Received: by mail-wm1-f71.google.com with SMTP id
 l15-20020a05600c4f0f00b003b4bec80edbso4890007wmq.9
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 19:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=O21xkz9JhgO/Nh+zhUhVdSb2TJmF41eTEC3dcspIhUg=;
 b=0z7AyDL17XaxsH1EBpwKeomlxL/hn937+FkfgRx6rMyMd2YMGC4BhYyM34KIM5JVeg
 TKiGtdtk4fuPdJCpfO7szwoBYnpzZd6+MUIXszxGa5lfC1SLEOOjnjlXMpMUwRo/gc33
 XW7dAZ8/AJkdI2Plc+A/3pjIPqeLPyte9ST/9+3xuRsH/+w/VN+JgvhQKuVYe/2o0kol
 N+O3W1q6qTFdXqTBmsXU2DFzKL9Se8wIKRG2sr3EmI6z1Rp9efQkGKG2W8d1xiLBfRuy
 zIPEtYEmP8kkCD0N1e0qoqeHuy/SisxB9rKTXRnkJ9r5oM0ZbTdBfejt0KsprA59N7Oh
 fVPQ==
X-Gm-Message-State: ACrzQf2Xmu3Yv3+GML1GzcY2xBNHjvhSsZM4gLVY2zIXXNugw+zqaYXz
 rd0jggwHRFZpZoh/e1YLaQuwjyzWY2LW+pkEoWSQEdJoDUflqYPc8sfgzXNHfElKV/UegpmnPFR
 DTs8lhOwmpm+L5eRTLNHRTXycRXk=
X-Received: by 2002:a05:600c:c7:b0:3b4:88ec:f980 with SMTP id
 u7-20020a05600c00c700b003b488ecf980mr4402232wmm.92.1663900998759; 
 Thu, 22 Sep 2022 19:43:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6G+u7m+x/3zH/RmUeyNt7Sv30lROdv3hyhPINsZAWGHtsjJ8QB1TkvwPfFckM7lHozYMBe2R+LpBgvfBfvRgg=
X-Received: by 2002:a05:600c:c7:b0:3b4:88ec:f980 with SMTP id
 u7-20020a05600c00c700b003b488ecf980mr4402228wmm.92.1663900998556; Thu, 22 Sep
 2022 19:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220922210931.23982-1-pvorel@suse.cz>
 <20220922210931.23982-2-pvorel@suse.cz>
In-Reply-To: <20220922210931.23982-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Sep 2022 10:43:07 +0800
Message-ID: <CAEemH2enjnO-=VLb8Lq3Gz3MT4_PoOTZBU76S3Z7ojBUdywaew@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3 v2] tst_supported_fs: Unify messaging
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
Content-Type: multipart/mixed; boundary="===============1334236000=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1334236000==
Content-Type: multipart/alternative; boundary="000000000000f5fe6005e94f23d5"

--000000000000f5fe6005e94f23d5
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 23, 2022 at 5:09 AM Petr Vorel <pvorel@suse.cz> wrote:

> Most of the messages used fprintf() instead of tst_{res,brk}(),
> thus convert all messages to fprintf().
>
> Add macros to shorten code.
>
> Fixes: eb47b4497 ("tst_supported_fs: Support skip list when query single
> fs")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I'm not sure about this myself. Shouldn't we rather use tst_brk() and
> tst_res() instead? It's show tst_supported_fs as command.
>

Not exactly, looking at testcase/lib/* tools, most of them are not written
by LTP standard API, some even do not include tst_test.h.

I personally think if we want more flexibility for those small programs
as auxiliary tool, we should not apply API as dogmatism for everything.

Btw, there is patch confliction when performing git-am, if you can
rebase accordingly for solving that, the whole patchset will be
great for me.

Reviewed-by: Li Wang <liwang@redhat.com>



>
>
>  testcases/lib/tst_supported_fs.c | 61 ++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/testcases/lib/tst_supported_fs.c
> b/testcases/lib/tst_supported_fs.c
> index 26577c726..947aa4dae 100644
> --- a/testcases/lib/tst_supported_fs.c
> +++ b/testcases/lib/tst_supported_fs.c
> @@ -15,6 +15,22 @@
>  #include "tst_test.h"
>  #include "tst_fs.h"
>
> +#define err(...) ({ \
> +       fprintf(stderr, __VA_ARGS__); \
> +       fprintf(stderr, "\n"); \
> +       usage(); \
> +       return 2; })
> +
> +#define fail(...) ({ \
> +       fprintf(stderr, __VA_ARGS__); \
> +       fprintf(stderr, "\n"); \
> +       return 1; })
> +
> +#define info(...) ({ \
> +       fprintf(stderr, __VA_ARGS__); \
> +       fprintf(stderr, "\n"); \
> +       return 0; })
> +
>  static void usage(void)
>  {
>         fprintf(stderr, "Usage:\n");
> @@ -90,67 +106,50 @@ int main(int argc, char *argv[])
>                         break;
>
>                 case 'd':
> -                       if (fsname) {
> -                               fprintf(stderr,
> -                                       "Can't specify multiple paths\n");
> -                               usage();
> -                               return 2;
> -                       }
> +                       if (fsname)
> +                               err("Can't specify multiple paths");
>
>                         fsname = tst_fs_type_name(tst_fs_type(optarg));
>                         break;
>                 }
>         }
>
> -       if (fsname && !skiplist) {
> -               fprintf(stderr, "Parameter -d requires skiplist\n");
> -               usage();
> -               return 2;
> -       }
> +       if (fsname && !skiplist)
> +               err("Parameter -d requires skiplist");
>
> -       if (argc - optind > 1) {
> -               fprintf(stderr, "Can't specify multiple fs_type\n");
> -               usage();
> -               return 2;
> -       }
> +       if (argc - optind > 1)
> +               err("Can't specify multiple fs_type");
>
>         /* fs_type */
>         if (optind < argc) {
> -               if (fsname) {
> -                       fprintf(stderr, "Can't specify fs_type and -d
> together\n");
> -                       usage();
> -                       return 2;
> -               }
> +               if (fsname)
> +                       err("Can't specify fs_type and -d together");
>
>                 fsname = argv[optind];
>         }
>
>         if (fsname) {
>                 if (fsname[0] == '\0')
> -                       tst_brk(TCONF, "fs_type is empty");
> +                       err("fs_type is empty");
>
>                 if (skiplist) {
>                         if (tst_fs_in_skiplist(fsname, (const char *
> const*)skiplist))
> -                               tst_brk(TCONF, "%s is skipped", fsname);
> -                       else
> -                               tst_res(TINFO, "%s is not skipped",
> fsname);
> +                               fail("%s is skipped", fsname);
>
> -                       return 0;
> +                       info("%s is not skipped", fsname);
>                 }
>
>                 if (tst_fs_is_supported(fsname) == TST_FS_UNSUPPORTED)
> -                       tst_brk(TCONF, "%s is not supported", fsname);
> -               else
> -                       tst_res(TINFO, "%s is supported", fsname);
> +                       fail("%s is not supported", fsname);
>
> -               return 0;
> +               info("%s is supported", fsname);
>         }
>
>         /* all filesystems */
>         filesystems = tst_get_supported_fs_types((const char *
> const*)skiplist);
>
>         if (!filesystems[0])
> -               tst_brk(TCONF, "There are no supported filesystems or all
> skipped");
> +               fail("There are no supported filesystems or all skipped");
>
>         for (i = 0; filesystems[i]; i++)
>                 printf("%s\n", filesystems[i]);
> --
> 2.37.3
>
>

-- 
Regards,
Li Wang

--000000000000f5fe6005e94f23d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 23, 2022 at 5:09 AM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Most of the m=
essages used fprintf() instead of tst_{res,brk}(),<br>
thus convert all messages to fprintf().<br>
<br>
Add macros to shorten code.<br>
<br>
Fixes: eb47b4497 (&quot;tst_supported_fs: Support skip list when query sing=
le fs&quot;)<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
I&#39;m not sure about this myself. Shouldn&#39;t we rather use tst_brk() a=
nd<br>
tst_res() instead? It&#39;s show tst_supported_fs as command.<br></blockquo=
te><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:smal=
l">Not exactly, looking at testcase/lib/* tools, most of them are not writt=
en</div><div class=3D"gmail_default" style=3D"font-size:small">by LTP stand=
ard API, some even do not include=C2=A0tst_test.h.</div><div class=3D"gmail=
_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default" =
style=3D"font-size:small">I personally think if we want more flexibility fo=
r those small programs</div><div class=3D"gmail_default" style=3D"font-size=
:small">as=C2=A0auxiliary tool, we should not apply API as dogmatism for ev=
erything.</div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">Btw, there is patch confliction when performing git-am, if you ca=
n</div><div class=3D"gmail_default" style=3D"font-size:small">rebase accord=
ingly for solving that, the whole patchset will be</div><div class=3D"gmail=
_default" style=3D"font-size:small">great for me.</div><br></div><div><div =
class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;=
<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a=
>&gt;</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
<br>
=C2=A0testcases/lib/tst_supported_fs.c | 61 ++++++++++++++++---------------=
-<br>
=C2=A01 file changed, 30 insertions(+), 31 deletions(-)<br>
<br>
diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported=
_fs.c<br>
index 26577c726..947aa4dae 100644<br>
--- a/testcases/lib/tst_supported_fs.c<br>
+++ b/testcases/lib/tst_supported_fs.c<br>
@@ -15,6 +15,22 @@<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_fs.h&quot;<br>
<br>
+#define err(...) ({ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, __VA_ARGS__); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;\n&quot;); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0usage(); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 2; })<br>
+<br>
+#define fail(...) ({ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, __VA_ARGS__); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;\n&quot;); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1; })<br>
+<br>
+#define info(...) ({ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, __VA_ARGS__); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;\n&quot;); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0; })<br>
+<br>
=C2=A0static void usage(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Usage:\n&quot;);<br>
@@ -90,67 +106,50 @@ int main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;d&#39;:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (fsname) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Can=
&#39;t specify multiple paths\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (fsname)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err(&quot;Can&#39;t specify multiple =
paths&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fsname =3D tst_fs_type_name(tst_fs_type(optarg));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fsname &amp;&amp; !skiplist) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Parameter -d requires skiplist\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fsname &amp;&amp; !skiplist)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err(&quot;Parameter=
 -d requires skiplist&quot;);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc - optind &gt; 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Can&#39;t specify multiple fs_type\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc - optind &gt; 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err(&quot;Can&#39;t=
 specify multiple fs_type&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fs_type */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (optind &lt; argc) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fsname) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fprintf(stderr, &quot;Can&#39;t specify fs_type and -d together\n=
&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0usage();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fsname)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err(&quot;Can&#39;t specify fs_type and -d together&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fsname =3D argv[opt=
ind];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fsname) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fsname[0] =3D=
=3D &#39;\0&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_brk(TCONF, &quot;fs_type is empty&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err(&quot;fs_type is empty&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (skiplist) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (tst_fs_in_skiplist(fsname, (const char * const*)skiplist))<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF, &quot;%s is skipped&qu=
ot;, fsname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;%s is not skippe=
d&quot;, fsname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail(&quot;%s is skipped&quot;, fsnam=
e);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0info(&quot;%s is not skipped&quot;, fsname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tst_fs_is_suppo=
rted(fsname) =3D=3D TST_FS_UNSUPPORTED)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_brk(TCONF, &quot;%s is not supported&quot;, fsname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TINFO, &quot;%s is supported&quot;, fsname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fail(&quot;%s is not supported&quot;, fsname);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info(&quot;%s is su=
pported&quot;, fsname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* all filesystems */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 filesystems =3D tst_get_supported_fs_types((con=
st char * const*)skiplist);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!filesystems[0])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF, &quo=
t;There are no supported filesystems or all skipped&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail(&quot;There ar=
e no supported filesystems or all skipped&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; filesystems[i]; i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;%s\n&q=
uot;, filesystems[i]);<br>
-- <br>
2.37.3<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000f5fe6005e94f23d5--


--===============1334236000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1334236000==--

