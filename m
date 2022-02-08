Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9191DC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 07:20:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 401D13C87C6
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 08:20:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AC9C3C24D6
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 08:20:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1728E200A03
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 08:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644304828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wgjClj5x6nmjWilLnfUZP1Rtkac2lcXrqd945wjUSc0=;
 b=TNODOFws0CJ/wzky7V0uB20T+hIlhoThChHYQ4w2Iw8Adao4qYvwvMM1LtYHr5zE3U4F/O
 DB16ntOCw82gBLLZwox1KwCg1KEuKp7ufQRbsuM8wWpcYywiNNaFmExBFkCKBr96Gc/o/N
 Gcb0vLnXSy16SYqVDzcYBI/xp6dorPc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-KZAKs8HqNsi2cSVaNGXAvA-1; Tue, 08 Feb 2022 02:20:26 -0500
X-MC-Unique: KZAKs8HqNsi2cSVaNGXAvA-1
Received: by mail-yb1-f198.google.com with SMTP id
 f32-20020a25b0a0000000b0061dad37dcd6so11181208ybj.16
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 23:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wgjClj5x6nmjWilLnfUZP1Rtkac2lcXrqd945wjUSc0=;
 b=AIEB/1GlR4n6Pb2FxOR1Q+qQpMmKfEMmJ4gSrlHxczlCfLlLiJoHfu7U3Dt8g0n9Ps
 xTQO6xAnERp4uS6HEIso1DT2zWowV2OnpC3mlJb+26CEXiFlz/2SM+ybtCpcdfi89GxI
 t+BdEPoxtg3eM2rYxa0MsztCZXqPl1P5FO0S4vItpOdmZ5C7JROE546ywc31DP6Grwoh
 kjya1vN83usIjvRCXT/rpo9HmWxDqDVSjaUQ4ZWBKrnh5xf4EjlhG9rqR5GpjXh+bDru
 RpPRPk2emKeeuTZSP/9DH0W5Xipt3lDTA0tGMe9knHfEgNLjZy0aBy7wzBkBCaB5vsKe
 uhYg==
X-Gm-Message-State: AOAM532OCkUXZBNv8yeUI/LcKeyVilDuutwNx8t101rUiZk92UWP9iOm
 +NbPVIzIh6kfTYZdh67WsVG3KtLYemCDRIo4+lAsbSkCWscevvOdvVsf+E+ATzpmd1loIgfIljg
 j1G/C3WV5ebX4wj6q1jNpvDuzsLk=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr3514574ywh.19.1644304826158; 
 Mon, 07 Feb 2022 23:20:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpAqrfq3ybNP1yblK3GFfG4zUXsIZT4+B/Q+0tyWhePKTt/4GqLvt0SqfiUwYiECRrPbZKz12bk+yBVPrf7j8=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr3514561ywh.19.1644304825961; 
 Mon, 07 Feb 2022 23:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20220207141618.2844-1-rpalethorpe@suse.com>
 <20220207141618.2844-4-rpalethorpe@suse.com>
In-Reply-To: <20220207141618.2844-4-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 15:20:10 +0800
Message-ID: <CAEemH2fAYDysjuHoUg3Oa9_m+Et3fCEY16iN6-2a=JmPLfnoPw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] API/cgroup: Add memory.min
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
Content-Type: multipart/mixed; boundary="===============1361011819=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1361011819==
Content-Type: multipart/alternative; boundary="0000000000000de4bb05d77c8dc3"

--0000000000000de4bb05d77c8dc3
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 7, 2022 at 10:16 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>  lib/tst_cgroup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 51b523b80..bb379caf5 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -159,6 +159,7 @@ static const struct cgroup_file cgroup_ctrl_files[] = {
>
>  static const struct cgroup_file memory_ctrl_files[] = {
>         { "memory.current", "memory.usage_in_bytes", CTRL_MEMORY },
> +       { "memory.min", NULL, CTRL_MEMORY },
>         { "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
>         { "memory.stat", "memory.stat", CTRL_MEMORY },
>         { "memory.swappiness", "memory.swappiness", CTRL_MEMORY },
> --
> 2.34.1
>
>

-- 
Regards,
Li Wang

--0000000000000de4bb05d77c8dc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 7, 2022 at 10:16 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.com">rpalethorpe@suse.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-=
by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.com" target=
=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
Reviewed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"=
_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div><span class=3D"gmail_d=
efault" style=3D"font-size:small"></span>Reviewed-by: Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</=
div><div><span class=3D"gmail_default"></span>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/tst_cgroup.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c<br>
index 51b523b80..bb379caf5 100644<br>
--- a/lib/tst_cgroup.c<br>
+++ b/lib/tst_cgroup.c<br>
@@ -159,6 +159,7 @@ static const struct cgroup_file cgroup_ctrl_files[] =3D=
 {<br>
<br>
=C2=A0static const struct cgroup_file memory_ctrl_files[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;memory.current&quot;, &quot;memory.usag=
e_in_bytes&quot;, CTRL_MEMORY },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;memory.min&quot;, NULL, CTRL_MEMORY },<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;memory.max&quot;, &quot;memory.limit_in=
_bytes&quot;, CTRL_MEMORY },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;memory.stat&quot;, &quot;memory.stat&qu=
ot;, CTRL_MEMORY },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;memory.swappiness&quot;, &quot;memory.s=
wappiness&quot;, CTRL_MEMORY },<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000000de4bb05d77c8dc3--


--===============1361011819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1361011819==--

