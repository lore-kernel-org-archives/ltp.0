Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4654FC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 10:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D800C3C93DA
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 11:02:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A26E3C1B7F
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 11:01:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5EF621000D3C
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 11:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647424916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bih8UVR7J+YY32sSdaa0rs9NJFFj13jrKzv/KvyVNzY=;
 b=EXdtjxhLW5723b4ee1lbHSlkmV217rE9QwXfIxxm0AWnB0KhxlHUiPl0tWFT8eN02pmL5o
 Asnua3fs2HFaqaMq3WRRNmD6N2QTSQ6xb7AfI3UWZKzoO7lsPIVESrlWJwuSECAoixfsc9
 XSHnPMo/laE08GrSvwP0HEoEAJ5pQ2k=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-FnnfWbEBPhaDX5Z_mc7HKQ-1; Wed, 16 Mar 2022 06:01:54 -0400
X-MC-Unique: FnnfWbEBPhaDX5Z_mc7HKQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 h16-20020a056902009000b00628a70584b2so1616524ybs.6
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 03:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bih8UVR7J+YY32sSdaa0rs9NJFFj13jrKzv/KvyVNzY=;
 b=7D7LxMy3hcDuNwDF7qQkKCc16OSa6UaMubOXxJyqbc7aOxe/cxunFRWKbmIqtGldey
 1C4g3DyIHunX4z0atRzOJ1lzrz3DZfQTH98LBEcUNR6B7Ex5KT6BkUrJ1eBdXs85JiWC
 z39VIGpFbsLqxUMUxePVgNJNUkCZkqqgMriA7HW80v9gjqE+HC4j7gzGBGVhEvOCJwh4
 9TyoUtnReSkCVXJoZO/XsyJl5XL5Sq2ladhl06HzqlJc0aCjj5KsQtazXFDaXjodTldd
 ytYPPiCrazjpg87yBegZ0VZFbRcky5f8lu1EvOYFJpJbVOpbUiQUX9Tm+xcgGBAlpgNB
 PaFQ==
X-Gm-Message-State: AOAM533TTIpDbWPbUCDO14FLgGxVdBiDxERrAIftr86Sn9NEhW7IU9io
 pim7NUOBkXTTMsOhrdit70goLs9c97soS2DQ0cb23Vl4N0EZLqfpVqE1qmKZwXbJSndE6UVnN7l
 wPfJ61ngypN35QhCqChwhVR9EdOc=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr29373326ywm.19.1647424914059; 
 Wed, 16 Mar 2022 03:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz52aBjclI2vILVpC0Dn7ybxHoODEhGPjp8rEZolep8CVXET0D4Me3xSPvYYHiUYNeclGGqhZGs4n/j0E6+Qw=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr29373311ywm.19.1647424913871; Wed, 16
 Mar 2022 03:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <031d9481edff991fc3c38da3699364b0f42ae63f.1646434670.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <031d9481edff991fc3c38da3699364b0f42ae63f.1646434670.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Mar 2022 18:01:42 +0800
Message-ID: <CAEemH2erXyFAihsdhzeFekVw7dqn0jQ8+z=ck3KE9hY-szoV5Q@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/16] API/cgroup: refuse to mount blkio when io
 controller is mounted
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
Content-Type: multipart/mixed; boundary="===============2106937771=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2106937771==
Content-Type: multipart/alternative; boundary="000000000000c92f2105da5300be"

--000000000000c92f2105da5300be
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 5, 2022 at 7:18 AM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:

> Mounting the v1 blkio controller while v2 io controller is mounted
> unmounts the io controller, triggering a tst_brk that the number of
> controller has gone down.
>
> Because these controllers don't seem to be compatible, tst_brk with
> TCONF and report that we refused to mount the blkio controller while the
> io controller is mounted.
>
> Signed-off-by: Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com>
> ---
>  lib/tst_cgroup.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 4e14a2895..52cbf680b 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -691,6 +691,11 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const
> ctrl)
>         char mnt_path[PATH_MAX];
>         int made_dir = 0;
>
> +       if (ctrl->ctrl_indx == CTRL_BLKIO &&
> controllers[CTRL_IO].ctrl_root) {
> +               tst_brk(TCONF,
> +                       "IO controller found on V2 root, skipping blkio
> mount that would unmount IO controller");
> +       }
>

Although we do a TCONF break here, there is still a need to check tst_cgctl
return value in cgroup_require(). Otherwise, test report failure like below:

tst_cgroup.c:702: TCONF: IO controller found on V2 root, skipping blkio
mount that would unmount IO controller
cgroup_fj_function 1 TBROK: cgroup_require: No state was set after call.
Controller 'blkio' maybe does not exist?



> +
>         sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix,
> ctrl->ctrl_name);
>
>         if (!mkdir(mnt_path, 0777)) {
> --
> 2.32.0
>
>

-- 
Regards,
Li Wang

--000000000000c92f2105da5300be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sat, Mar 5, 2022 at 7:18 AM Luke Nowakowski-Krij=
ger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"_=
blank">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Mounting the v1 blkio controller=
 while v2 io controller is mounted<br>
unmounts the io controller, triggering a tst_brk that the number of<br>
controller has gone down.<br>
<br>
Because these controllers don&#39;t seem to be compatible, tst_brk with<br>
TCONF and report that we refused to mount the blkio controller while the<br=
>
io controller is mounted.<br>
<br>
Signed-off-by: Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowsk=
ikrijger@canonical.com" target=3D"_blank">luke.nowakowskikrijger@canonical.=
com</a>&gt;<br>
---<br>
=C2=A0lib/tst_cgroup.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c<br>
index 4e14a2895..52cbf680b 100644<br>
--- a/lib/tst_cgroup.c<br>
+++ b/lib/tst_cgroup.c<br>
@@ -691,6 +691,11 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const =
ctrl)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char mnt_path[PATH_MAX];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int made_dir =3D 0;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctrl-&gt;ctrl_indx =3D=3D CTRL_BLKIO &amp;&=
amp; controllers[CTRL_IO].ctrl_root) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;IO controller found on V2 root, skipping blkio mount that w=
ould unmount IO controller&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Although we do a TCONF break =
here, there is still a need to check tst_cgctl</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">return value in cgroup_require(). Otherwise=
, test report failure like below:</div></div><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">tst_cgroup.c:702: TCONF: IO co=
ntroller found on V2 root, skipping blkio mount that would unmount IO contr=
oller</div>cgroup_fj_function 1 TBROK: cgroup_require: No state was set aft=
er call. Controller &#39;blkio&#39; maybe does not exist?<br><div class=3D"=
gmail_default" style=3D"font-size:small"></div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(mnt_path, &quot;%s%s&quot;, cgroup_moun=
t_ltp_prefix, ctrl-&gt;ctrl_name);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mkdir(mnt_path, 0777)) {<br>
-- <br>
2.32.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000c92f2105da5300be--


--===============2106937771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2106937771==--

