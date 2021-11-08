Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22902C433EF
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 09:09:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A8261265
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 09:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45A8261265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B26C3C77D1
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 10:09:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FBB43C2DBB
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 10:09:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A5D6B200278
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 10:09:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636362539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICGQVidf1bt9V1/2li6XB+ad7nTzwy3Ee29R9xksM+w=;
 b=Dvcz08piYATi3OG2E/XiZTF8oBSrG6LdmrKks0LZ5nYsTkVionuoCmY/jgLQI84kfDRKRe
 +j2mpJ+71ZvA8EIVSLEs6IiNGldAxkqZT+tbdxv+AKVj3WU/mMySuTMapU5aepTTMRj1N4
 Tl06ecn7PdRRhe9okO/h0Lz4u0JwNOQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-HlvMoOKMPESjLkPclP2I_Q-1; Mon, 08 Nov 2021 04:08:56 -0500
X-MC-Unique: HlvMoOKMPESjLkPclP2I_Q-1
Received: by mail-yb1-f200.google.com with SMTP id
 z2-20020a254c02000000b005b68ef4fe24so24431949yba.11
 for <ltp@lists.linux.it>; Mon, 08 Nov 2021 01:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ICGQVidf1bt9V1/2li6XB+ad7nTzwy3Ee29R9xksM+w=;
 b=yFzP77QIkIY5TK5mzRm0OcqpHJ5t21b5L9MYay26xfQR9DLGUMwzrdNDu5GkHGPAWq
 pg32yEhMTPKLTOP/n5XdNHtjyr/DFkv/cWZrr4cp2yBGRBK6VZmuJdYW2pZqxuuEf7bs
 BgkX2+gUul1JtPJSzyLFvX29slnuMH2DU8casn6gDp5UjjL0z9J1WOuaGfUIjH0P7aBP
 vN39qCucogVtouL4+sLuVKhEV7+ffeaGvGy7V2W9sYNz3Ym4hGCDDC7DzCqZFpo0XvKg
 h9uBDvzMpSP+fzQEEzRQmbMWWb3j2VevK3VEqbrRsOpImM40SgXjEo4UM6FmIEU15wdm
 XjQQ==
X-Gm-Message-State: AOAM531S+M5YDdS7RP/iljtaUWmlETjTYfw7mlNTJ+W6jxiRSq7MghHG
 vLeHloIJLC2h/UMm3ZLLSdG51fcN+nBJSNE3fKgpXAfPHaYi1k2UL1Ng9IseOwJyaEMVbZN6sgT
 LuoXiw6xj4f79GmYJNRibHU+P4B8=
X-Received: by 2002:a25:86c4:: with SMTP id y4mr71895554ybm.144.1636362535550; 
 Mon, 08 Nov 2021 01:08:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl840dL7T/hDY89WpagPnUVMS+FZFYL8d59nIoM6SnMnxXQ31Dk2r1N2kTJCLaou/KenKKdfv7n98zYC/1yLA=
X-Received: by 2002:a25:86c4:: with SMTP id y4mr71895529ybm.144.1636362535333; 
 Mon, 08 Nov 2021 01:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20211108073828.33126-1-zhaogongyi@huawei.com>
In-Reply-To: <20211108073828.33126-1-zhaogongyi@huawei.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Nov 2021 17:08:43 +0800
Message-ID: <CAEemH2epiu1ahMYFu=Eb1LovPd2FP=o4vLtkJePtk9r+yj416w@mail.gmail.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: add *cleanup() before exit
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
Content-Type: multipart/mixed; boundary="===============1035147580=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1035147580==
Content-Type: multipart/alternative; boundary="000000000000a484e605d0435740"

--000000000000a484e605d0435740
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 8, 2021 at 3:37 PM Zhao Gongyi <zhaogongyi@huawei.com> wrote:

> If the main process exit without *cleanup() and when the lib process
> has exit, the test environment would not be reset when the testcase
> needs resource of device or tmpfs.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>  lib/tst_test.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 02ae28335..4c7e3a97b 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1226,6 +1226,8 @@ static void heartbeat(void)
>                  * We need kill the task group immediately since the
>                  * main process has exit.
>                  */
> +               do_test_cleanup();
> +               do_cleanup();
>                 kill(0, SIGKILL);
>                 exit(TBROK);
>         }
> --
> 2.17.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000a484e605d0435740
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Nov 8, 2021 at 3:37 PM Zhao Gongyi &lt;<a h=
ref=3D"mailto:zhaogongyi@huawei.com" target=3D"_blank">zhaogongyi@huawei.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>If the main process exit without *cleanup() and when the lib process<br>
has exit, the test environment would not be reset when the testcase<br>
needs resource of device or tmpfs.<br>
<br>
Signed-off-by: Zhao Gongyi &lt;<a href=3D"mailto:zhaogongyi@huawei.com" tar=
get=3D"_blank">zhaogongyi@huawei.com</a>&gt;<br></blockquote><div>=C2=A0</d=
iv><div><span class=3D"gmail_default" style=3D"font-size:small"></span>Revi=
ewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank"=
>liwang@redhat.com</a>&gt;</div><div><span class=3D"gmail_default"></span>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/tst_test.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
index 02ae28335..4c7e3a97b 100644<br>
--- a/lib/tst_test.c<br>
+++ b/lib/tst_test.c<br>
@@ -1226,6 +1226,8 @@ static void heartbeat(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We need kil=
l the task group immediately since the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* main proces=
s has exit.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_test_cleanup();<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_cleanup();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kill(0, SIGKILL);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(TBROK);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
--<br>
2.17.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000a484e605d0435740--


--===============1035147580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1035147580==--

