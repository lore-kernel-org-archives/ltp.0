Return-Path: <SRS0=NQiP=OS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F617C433F5
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 08:00:03 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9EA6101E
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 08:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A9EA6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9A5D3C8B74
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 10:00:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B78D23C7001
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 09:59:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 042661000D39
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 09:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632815989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKvmOTWe5SYDfkwJmVn0bGSe096b8aXlLff31RLBlUo=;
 b=e3TU7Im3jgefgTcjxT3lM1KIKsof8Bd/9PQ4eEqNMrjI35j34lWUY2Khr7j3UB9gBkkcza
 0NuHrTIZoWJljeTwer9rRkGAP86qeqV5Y2cfVOT5EJTh1X/wQcnvat70MzUjDfGfHDAmi1
 9wv3azSNxp/cEKXZ8Gh9kHJTTZPnf3o=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-VOB6ku_7MUe8AL0nhdmSww-1; Tue, 28 Sep 2021 03:59:46 -0400
X-MC-Unique: VOB6ku_7MUe8AL0nhdmSww-1
Received: by mail-yb1-f198.google.com with SMTP id
 t9-20020a056902124900b005b64be937e1so15398044ybu.23
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 00:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UKvmOTWe5SYDfkwJmVn0bGSe096b8aXlLff31RLBlUo=;
 b=UP9R0hvnKPq0m7bHLfdrcqDjD9X4Wb/Pkvx1EDT9eweqiGPGTVtLnhue1NNftFT1pd
 YJt+QG65/Gx4v4gxPGJKnlLRW1EFpB7uj/s89YmGk2rGfzuKbQJpeu4/3WMBB5t+kG+W
 o7KLNM18HsNM+rRVOn+i0CCb5b+5oG2mxik8jDbDJfydP/E5zwrv4NP1XsQVej/NSNzw
 CRYcoc4oED9MCNlLmnmd2FKfAI1c5XtpjoAcTD5xCsipiFN0TM+n4r48UDaHxEP7Zr85
 DUKHjhevs15CWy2f8TCorvabrWTK2Z1RR2J98b2u3ZkMB3ds5dPdmmd4qdeGpFViSc0m
 KD1Q==
X-Gm-Message-State: AOAM533WMykK9LalJ7OcEx0quZXrTKts+tHBlR8ZoiDONOpPDfZonnu1
 mffTA/oBo9XO4Wu9jGUjFAQHVSr2GIXlIMDBKRsBx42RZOQpTadvLeVGhBFYT85HwZ8k8WDjmZ3
 V4BzlElSOy32T91uVZdfenTjwbP8=
X-Received: by 2002:a25:47d7:: with SMTP id u206mr4532350yba.186.1632815986104; 
 Tue, 28 Sep 2021 00:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvjMzEtxkEBrStmguuDyK8FY+1DOw44pO14l/Qhb7P4gccwk/XQV2kUxLguoBH7Si6fVHMQcQeSH4blNEyOg4=
X-Received: by 2002:a25:47d7:: with SMTP id u206mr4532332yba.186.1632815985894; 
 Tue, 28 Sep 2021 00:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210928021850.2015065-1-ralph.siemsen@linaro.org>
In-Reply-To: <20210928021850.2015065-1-ralph.siemsen@linaro.org>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Sep 2021 15:59:33 +0800
Message-ID: <CAEemH2fPxb-Dv8W+Xzg9q3+jfFzL+gckTT=+75X_DwYS8z_=OQ@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: fix MemAvailable parsing
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
Content-Type: multipart/mixed; boundary="===============1153743099=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1153743099==
Content-Type: multipart/alternative; boundary="000000000000d2be6605cd0998d5"

--000000000000d2be6605cd0998d5
Content-Type: text/plain; charset="UTF-8"

> @@ -65,9 +65,9 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
>
>  long long tst_available_mem(void)
>  {
> -       long long mem_available;
> +       long long mem_available = 0;
>

--->  unsigned long long


> -       if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
> +       if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %lld",
>

I modified it to use '%llu' and pushed.

-- 
Regards,
Li Wang

--000000000000d2be6605cd0998d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0<br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
@@ -65,9 +65,9 @@ void tst_pollute_memory(size_t maxsize, int fillchar)<br>
<br>
=C2=A0long long tst_available_mem(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0long long mem_available;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0long long mem_available =3D 0;<br></blockquote>=
<div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">=
---&gt;=C2=A0 unsigned long long </div></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (FILE_LINES_SCANF(&quot;/proc/meminfo&quot;,=
 &quot;MemAvailable: %ld&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (FILE_LINES_SCANF(&quot;/proc/meminfo&quot;,=
 &quot;MemAvailable: %lld&quot;,<br></blockquote><div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-size:small">I modified it to use &#39;=
%llu&#39; and pushed.</div></div></div><div><br></div>-- <br><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>L=
i Wang<br></div></div></div></div>

--000000000000d2be6605cd0998d5--


--===============1153743099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1153743099==--

