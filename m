Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8E7C433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 03:38:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8A1A3CB028
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 05:38:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 955323CAA6E
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 05:38:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 915F160007E
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 05:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666064305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7XAH1XN0CIWuC2YAl4NRcHvJ/iYexekSqAKWObTnHc=;
 b=QxV5hvx8uyqvadmf7t8PwwKtAJeokoV/EIgz5bJw973Jd4apyqgBTg+tNFANfHQUeIi491
 avr+b4cIC8nbKLZrjpCTv22+rCqsWbYKUSZF3v2Yj0TWyXjIKuE73PR4uAjYpiTFbqSn2o
 IsbzxSUKiwSCs7OStFa5ildUaF8KWUU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-57-QyCQ4InoNQOoEihDzQr03Q-1; Mon, 17 Oct 2022 23:38:23 -0400
X-MC-Unique: QyCQ4InoNQOoEihDzQr03Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 p42-20020a05600c1daa00b003c6ee394f0dso5460606wms.5
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 20:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7XAH1XN0CIWuC2YAl4NRcHvJ/iYexekSqAKWObTnHc=;
 b=Ai6OHFDBQ9ftTW8iDPf1SV9kxZ4VcbYJwlSxRFqMqq68MfcVfHUbGyOX3Cno6+bmFK
 HEl9pGkvODD5IdI6zH79nPhp+UoH/zEXfWZJXZ/CvpJrGef9/Kdl1IKwWdHk3JUVzZXf
 qt0Xm9NYZtwrh5xiEXsSJB/VSxz193g+hNoHxUkQdLwfNTGvLfVcx5OiZm9B1lwF1692
 jySNgvfUOrE1nkNDdT+JJGb94ggmpCioOGNirz8kgZGJbSBuRufDh1m/C7nvZaG/4uMP
 EJw7Vpobk/y8Lppr/e5iZ36bMm8H+1v+J4djECbJBhHMGamhJtMEq5AOvJkXhPLFnogU
 OEbg==
X-Gm-Message-State: ACrzQf3JSqn2bKZwTWVZuw6xw4f4j68CjmGlKSbM5+Iod7qRml1Z7jzR
 VEienIArl2QIhXXakCkrIJQfZDo3RsWm9JjTKui3sYl00rCLbZ5zr090hMxmwZJWuqx8AGh9mlx
 RN87JpxO3RBJpZt9dwXG2drU82Xw=
X-Received: by 2002:a5d:64e2:0:b0:22e:7060:b4a7 with SMTP id
 g2-20020a5d64e2000000b0022e7060b4a7mr424862wri.129.1666064301597; 
 Mon, 17 Oct 2022 20:38:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Oxoeo3lgCrY/b6blxzWW7j/lNnBG/VNAddi46w0Bk1//DS6Ya9qaYOe02aA6Q6xxODcWHCZvwLe7jgHWL3yQ=
X-Received: by 2002:a5d:64e2:0:b0:22e:7060:b4a7 with SMTP id
 g2-20020a5d64e2000000b0022e7060b4a7mr424855wri.129.1666064301425; Mon, 17 Oct
 2022 20:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-5-tsahu@linux.ibm.com>
In-Reply-To: <20221016125731.249078-5-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Oct 2022 11:38:10 +0800
Message-ID: <CAEemH2d51W26iJOvTYMZDjqFjN_vAiqc3-hyD2E1w18zcycBXA@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/29] Hugetlb: Migrating libhugetlbfs counters
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: multipart/mixed; boundary="===============0223270338=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0223270338==
Content-Type: multipart/alternative; boundary="000000000000dc1d6d05eb46d2fa"

--000000000000dc1d6d05eb46d2fa
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tsahu@linux.ibm.com> wrote:



> +
> +static void per_iteration_cleanup(void)
> +{
> +       for (int nr = 0; nr < NR_SLOTS; nr++) {
>

Here the for-loop usage is introduced from C99, we have to avoid
definition in the loop to dismiss compiling broken on old compilers.

See:
https://github.com/wangli5665/ltp/actions/runs/3261830153/jobs/5357590260


+
> +static void setup(void)
> +{
> +       if (!Hopt)
> +               Hopt = tst_get_tmpdir();
> +       SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +       for (int nr = 0; nr < NR_SLOTS; nr++) {
>


Here as well ^


-- 
Regards,
Li Wang

--000000000000dc1d6d05eb46d2fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Tarun Sahu &lt;<a href=3D"mailto:tsahu@linux.ibm.com">tsahu@l=
inux.ibm.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+<br>
+static void per_iteration_cleanup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int nr =3D 0; nr &lt; NR_SLOTS; nr++) {<br=
></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"fon=
t-size:small">Here the for-loop usage is introduced from C99, we have to av=
oid</div><div class=3D"gmail_default" style=3D"font-size:small">definition =
in the loop to dismiss compiling broken on old compilers.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">See: <a href=3D"https://github.com/wangl=
i5665/ltp/actions/runs/3261830153/jobs/5357590260">https://github.com/wangl=
i5665/ltp/actions/runs/3261830153/jobs/5357590260</a></div></div><div><br><=
/div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+static void setup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!Hopt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hopt =3D tst_get_tm=
pdir();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MOUNT(&quot;none&quot;, Hopt, &quot;hugetl=
bfs&quot;, 0, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int nr =3D 0; nr &lt; NR_SLOTS; nr++) {<br=
></blockquote><div><br></div><div><br></div><div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Here as well ^</div></div><div><br></div></div=
><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000dc1d6d05eb46d2fa--


--===============0223270338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0223270338==--

