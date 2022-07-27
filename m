Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511A3C19F21
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 04:44:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81E593C4D65
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 06:44:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4893C05AE
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 06:44:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 51290100099D
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 06:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658897066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skFwuj2+wuk3O2imAo1ab6oAbwWFVSLT1NnjsU8hW7U=;
 b=IkGpVURSLl/e5kbF0QkFtYAn+5VXvJBzn3VbWhpatHjwN/pp69+BINzi9fHy4EUV1A9q6w
 dTQT9HfooAyVKckFhHFVhRICdFV+kALkB1nCuWCYWjDcD5BMke3R+Ex+K7tpVnQUs1P0Rs
 l8vSeU70+rl3jT7F8g4QpR6TgQN2Jqg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-c4QXNeMBPBqjeikVALR4mg-1; Wed, 27 Jul 2022 00:44:25 -0400
X-MC-Unique: c4QXNeMBPBqjeikVALR4mg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-31f5960500bso17712357b3.14
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 21:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=skFwuj2+wuk3O2imAo1ab6oAbwWFVSLT1NnjsU8hW7U=;
 b=DBEMgrR7miGTW5fM/PWFYZHUF4JIFjN6bOAUU2BS4parqL0j5pslaFOtu/WrVg4aMa
 AEW5cPVhq9a2jUQmrdOkjfPB9RyFk1W27prsKyUKQt/xN9/ClK8Ru+/YT5a+5ORbCq24
 Y13xV9fTAEEHOqIb11q9GnQx56zcMNqSeBUeVJ8yEcjMOG8Jhz/W0atnuTwdVr36uyc2
 J2LfTrsLZXlKAOAK4K5oMyAJ0Ckr8yI6iXt4fH4H3kSQql9gjnFWmhmOYIDJofVUtlp8
 IcL3Ih+UoNKUirJw0S7qiK7RAlzLnZbfKoEpeQCw0aCI2mmaXDZy/PRGMoDv7g6GPFXn
 xkDg==
X-Gm-Message-State: AJIora8iOjE+NPvw4bdpzrmF4VyI9mkGtqGBzULw/y4UJ+CO1uGyeKdx
 acR+Cn1dhL1+ij12ofjB/f6Qc+vSVEI8+uv9Y1wCOhzTQ4YdCwaJHVvo9tDthsxrkmCYpEGxQcm
 vGwNUX7QXDVIhS0pEA4o59O95X9M=
X-Received: by 2002:a25:6f02:0:b0:66f:5acc:7866 with SMTP id
 k2-20020a256f02000000b0066f5acc7866mr16510035ybc.461.1658897064069; 
 Tue, 26 Jul 2022 21:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1saOKwfmMcyC4TUs0u69jSTBToxVlT9jsbCSuDzLMWq0QEFN9SqfsPm+QAVtpH6R7mNwOlSXcVaR8k/rb9aFSg=
X-Received: by 2002:a25:6f02:0:b0:66f:5acc:7866 with SMTP id
 k2-20020a256f02000000b0066f5acc7866mr16510023ybc.461.1658897063748; Tue, 26
 Jul 2022 21:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220726155646.26468-1-pvorel@suse.cz>
 <20220726155646.26468-2-pvorel@suse.cz>
In-Reply-To: <20220726155646.26468-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jul 2022 12:44:12 +0800
Message-ID: <CAEemH2eZJMHYn1oc7M=CB+kJFoxwzr0ibo9Exp7oEBoKd3VkKg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_cgroup: Fix -Wstringop-truncation warning
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: multipart/mixed; boundary="===============1131012892=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1131012892==
Content-Type: multipart/alternative; boundary="000000000000343c0705e4c212cb"

--000000000000343c0705e4c212cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 11:56 PM Petr Vorel <pvorel@suse.cz> wrote:

> Add space for null terminator to fix warning:
>
> tst_cgroup.c:505:17: warning: =E2=80=98__builtin_strncpy=E2=80=99 output =
may be truncated
> copying 255 bytes from a string of length 255 [-Wstringop-truncation]
>   505 |                 strncpy(cgroup_test_dir, test_dir_name, NAME_MAX)=
;
>       |                 ^
>
> Fixes: ebebdd735 ("API/cgroup: Implement tst_cg_load_config")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>



> ---
>  lib/tst_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 998b259a6..6f24e0450 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -502,7 +502,7 @@ static void cgroup_parse_config_line(const char *cons=
t
> config_entry)
>         }
>
>         if (!root->test_dir.dir_name && strcmp(test_dir_name, "NULL")) {
> -               strncpy(cgroup_test_dir, test_dir_name, NAME_MAX);
> +               strncpy(cgroup_test_dir, test_dir_name, NAME_MAX + 1);
>                 cgroup_dir_mk(&root->ltp_dir, cgroup_test_dir,
> &root->test_dir);
>                 root->test_dir.we_created_it =3D 1;
>         }
> --
> 2.37.1
>
>

--=20
Regards,
Li Wang

--000000000000343c0705e4c212cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Jul 26, 2022 at 11:56 PM Petr Vorel &lt;<a =
href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Add space for null terminator =
to fix warning:<br>
<br>
tst_cgroup.c:505:17: warning: =E2=80=98__builtin_strncpy=E2=80=99 output ma=
y be truncated copying 255 bytes from a string of length 255 [-Wstringop-tr=
uncation]<br>
=C2=A0 505 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
trncpy(cgroup_test_dir, test_dir_name, NAME_MAX);<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^<br>
<br>
Fixes: ebebdd735 (&quot;API/cgroup: Implement tst_cg_load_config&quot;)<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br></blockquote><div>=C2=A0</div><div><span c=
lass=3D"gmail_default" style=3D"font-size:small"></span>Reviewed-by: Li Wan=
g &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.=
com</a>&gt;</div><div><span class=3D"gmail_default"><br></span></div><div><=
span class=3D"gmail_default"></span>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
---<br>
=C2=A0lib/tst_cgroup.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c<br>
index 998b259a6..6f24e0450 100644<br>
--- a/lib/tst_cgroup.c<br>
+++ b/lib/tst_cgroup.c<br>
@@ -502,7 +502,7 @@ static void cgroup_parse_config_line(const char *const =
config_entry)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!root-&gt;test_dir.dir_name &amp;&amp; strc=
mp(test_dir_name, &quot;NULL&quot;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncpy(cgroup_test=
_dir, test_dir_name, NAME_MAX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncpy(cgroup_test=
_dir, test_dir_name, NAME_MAX + 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cgroup_dir_mk(&amp;=
root-&gt;ltp_dir, cgroup_test_dir, &amp;root-&gt;test_dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 root-&gt;test_dir.w=
e_created_it =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.37.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000343c0705e4c212cb--


--===============1131012892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1131012892==--

