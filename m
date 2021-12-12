Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09348C433F5
	for <ltp@archiver.kernel.org>; Sun, 12 Dec 2021 03:50:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854A13C8843
	for <ltp@archiver.kernel.org>; Sun, 12 Dec 2021 04:50:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B73253C1D8F
 for <ltp@lists.linux.it>; Sun, 12 Dec 2021 04:50:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 522A910007BB
 for <ltp@lists.linux.it>; Sun, 12 Dec 2021 04:50:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639281025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oSjGym/L4Ic5JVTzxRbJpYKsvn5QO6p4muMGRAK33CY=;
 b=QxZOhERrXXJnkPjgxRTKEfvm2OXjo1cqCL8o4LsgQIiWcVPd2sv0zN2KyGXQUOqjGMiGvC
 Uijggo8d31SBhTx6njTFjMPW3e3HWhuNi/U3KKoUTD6/2vn01L8XLe+SeRVi3OQRJsVPlU
 i0pgkoyfqxiIGJM1YF2bcPTkRA4W1iA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-ABfeLYE5Ouyl9lgc3E3-HA-1; Sat, 11 Dec 2021 22:50:21 -0500
X-MC-Unique: ABfeLYE5Ouyl9lgc3E3-HA-1
Received: by mail-yb1-f198.google.com with SMTP id
 e131-20020a25d389000000b005fb5e6eb757so24094937ybf.22
 for <ltp@lists.linux.it>; Sat, 11 Dec 2021 19:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oSjGym/L4Ic5JVTzxRbJpYKsvn5QO6p4muMGRAK33CY=;
 b=Q8+MdieO122EysKZo/6jMwQnGX5+8OdJufw1lpCr4gWk0Ubl2pJUkLwGj547/YgSCj
 2xJ/rWstnKKOXFyNWGq+anf4qFOqFqn+ClQ9wO1+13J+XvoUpuII4O9n+yJqV4x4IfKY
 5NFMpTrNudehhgEbaLmLIv96Z9hWL0J4t7fOD5G8Q4IEK9N5FdiAmAVuMSbd2HakeqHf
 7F8Rxki8gvwJhAyavO4nXr+dPUnfVCOCFYqrbvps6rdbBq5fVe4GdMqwJL9WS6H/9M6T
 NkMdNfRvPl1bk4PUNAP3lXdr3yftZ3tNq+0NWLa6s0NZWDZgOAtciovHT74rCPDAUAYP
 0n4A==
X-Gm-Message-State: AOAM533EwkuJpN4G4/q5pABuqXbMTN1wG7kh5Ja0wW64jmcwE7XKJqT7
 UzDxoCAu3DIP/XVR5KQvMlKaEwvrtMCsn6QIkqJc1J+4ALPoFP85ZHJH3yekZgSHLA215oT354X
 fQAOi8/nGnM3GUrtwEkQMATdsTKs=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr23797954ybe.32.1639281021351; 
 Sat, 11 Dec 2021 19:50:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbQKJoKqyPgzQJ1wlzQaBJIr3Db9h+5dJPqhNhK4KHnpUmvNx02meYDQhT1G7xk3lj8rqPdL8x7HP5+Do02tY=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr23797934ybe.32.1639281021006; 
 Sat, 11 Dec 2021 19:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20211210134556.26091-1-pvorel@suse.cz>
In-Reply-To: <20211210134556.26091-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sun, 12 Dec 2021 11:49:59 +0800
Message-ID: <CAEemH2ec18R5rxvz-m7yKzRHMHt8aDSA=pggPXGc7jjzHH=-Vw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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
Content-Type: multipart/mixed; boundary="===============0800366507=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0800366507==
Content-Type: multipart/alternative; boundary="000000000000f1d53b05d2eada25"

--000000000000f1d53b05d2eada25
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 10, 2021 at 9:46 PM Petr Vorel <pvorel@suse.cz> wrote:

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>



> ---
>  doc/maintainer-patch-review-checklist.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/maintainer-patch-review-checklist.txt
> b/doc/maintainer-patch-review-checklist.txt
> index c7bb47810..4e2b267ac 100644
> --- a/doc/maintainer-patch-review-checklist.txt
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -34,6 +34,9 @@ New test should
>    GPL-2.0-or-later; the licence for test (e.g. GPL-2.0) should not change
>    unless test is completely rewritten
>  * Old copyrights should be kept unless test is completely rewritten
> +* Tests for new functionality in mainline kernel should be merged after
> final
> +  release of kernel which contains that functionality (it's not enough
> when the
> +  feature gets into rc1, because it can be reverted in later rc if
> problematic).
>
>  ### C tests
>  * Use new
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C
> API]
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

--000000000000f1d53b05d2eada25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Dec 10, 2021 at 9:46 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Suggested-by: Cyril Hrubis &lt;=
<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt=
;<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br></blockquote><div><span class=3D"gmail_def=
ault" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:=
liwang@redhat.com">liwang@redhat.com</a>&gt;</span></div><div><span class=
=3D"gmail_default" style=3D"font-size:small"><br></span></div><div><span cl=
ass=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0doc/maintainer-patch-review-checklist.txt | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-pat=
ch-review-checklist.txt<br>
index c7bb47810..4e2b267ac 100644<br>
--- a/doc/maintainer-patch-review-checklist.txt<br>
+++ b/doc/maintainer-patch-review-checklist.txt<br>
@@ -34,6 +34,9 @@ New test should<br>
=C2=A0 =C2=A0GPL-2.0-or-later; the licence for test (e.g. GPL-2.0) should n=
ot change<br>
=C2=A0 =C2=A0unless test is completely rewritten<br>
=C2=A0* Old copyrights should be kept unless test is completely rewritten<b=
r>
+* Tests for new functionality in mainline kernel should be merged after fi=
nal<br>
+=C2=A0 release of kernel which contains that functionality (it&#39;s not e=
nough when the<br>
+=C2=A0 feature gets into rc1, because it can be reverted in later rc if pr=
oblematic).<br>
<br>
=C2=A0### C tests<br>
=C2=A0* Use new <a href=3D"https://github.com/linux-test-project/ltp/wiki/T=
est-Writing-Guidelines#22-writing-a-test-in-c[C" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/linux-test-project/ltp/wiki/Test-Writing-Gui=
delines#22-writing-a-test-in-c[C</a> API]<br>
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

--000000000000f1d53b05d2eada25--


--===============0800366507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0800366507==--

