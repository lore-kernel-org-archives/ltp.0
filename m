Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D432DC433EF
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 03:30:26 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2758260F92
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 03:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2758260F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDD963C9391
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 05:30:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD5FB3C21EB
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 05:30:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6FD52600BDE
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 05:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631071808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVUoGPruCqabLHCREM+ZoAC0k5fh6+pJa0ElHEcc4AM=;
 b=JtCZ5KC0Rz99/ocKKCZkvOxcfl6AMIBgthspr43/imbdmobqKrVmR8LgU+FWo7gHQ27SUj
 FNJ9zLp4fd3aufT/3Vj4WB05UF/ZnyLahoBccLe+ZykTkwfvopJrYWg6tZDGOfiGthYWao
 Pwk6+eacrTWBkdylvx1QtX04G8o20Og=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-isNwtivZPD-9ejku3V8J-A-1; Tue, 07 Sep 2021 23:30:07 -0400
X-MC-Unique: isNwtivZPD-9ejku3V8J-A-1
Received: by mail-yb1-f198.google.com with SMTP id
 w8-20020a259188000000b0059bf0bed21fso815418ybl.18
 for <ltp@lists.linux.it>; Tue, 07 Sep 2021 20:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EVUoGPruCqabLHCREM+ZoAC0k5fh6+pJa0ElHEcc4AM=;
 b=ZiTwM/VaDGAh2I/BdDQl6of/QZUKfK3FEPSh/7421n09Alu+syyQf0q7QWjWcZAzHd
 q7zMEoqV2xpAfliayiz+wgVWGBxONOLI01dA3BZM9hgi8wy2kXTgYKfa43NlMOad/rXY
 7v29hivYCFAZEbOP0i6w01hf/EiXxw/OHhzP0J112HdBpVE+GZcPuPzcBXttMUlr+Gns
 PeLjl3tmuVFuV2CfJl1k+NScg79/bXocEqIizSlDesvy+cWuz6jr5gdQyaDrqIfouNNq
 NwBO9kWR6FL4k8j8Q4bQzdGzf/Q1EniAbbpXrLiMJjyQhPA26KuoUxynLyhpVU0kcLw+
 ZTfQ==
X-Gm-Message-State: AOAM533r2sEQFo8AZPM8CEzkLfBFzanIfkp6KjkUlNj65WWfuELaG0hI
 ccUEBOMsskwLaFxlwUWL0Dra1EC2CXBYXC2lrJZA9JAR3fmc7LzG38i/08DWsC+xwodTrehYoc6
 HTzQODsEaLD8zELZ4sDICbow7dyQ=
X-Received: by 2002:a25:6902:: with SMTP id e2mr2364973ybc.526.1631071806857; 
 Tue, 07 Sep 2021 20:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0fu5GZTmIWVANuBcX+2c2QTqlpo98YRANImzYp++5VRITrMz+YdaQbJadMFd4RUxzhT9XZqS15Ofn8OJb2qs=
X-Received: by 2002:a25:6902:: with SMTP id e2mr2364954ybc.526.1631071806632; 
 Tue, 07 Sep 2021 20:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210905031113.2740-1-zhaogongyi@huawei.com>
In-Reply-To: <20210905031113.2740-1-zhaogongyi@huawei.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Sep 2021 11:29:54 +0800
Message-ID: <CAEemH2ebjS-4UVQGhVuArkzDeS3n1A82wPxVDfGHQ=0Jt+Q4qQ@mail.gmail.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix: Add failure handling of fork()
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
Content-Type: multipart/mixed; boundary="===============0203899299=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210908032954.R4JpbuUEEvDb9I4F699cBWLB2rel9WSP11D17M6IEMk@z>

--===============0203899299==
Content-Type: multipart/alternative; boundary="000000000000a34b8d05cb737fe6"

--000000000000a34b8d05cb737fe6
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 7, 2021 at 8:41 PM Zhao Gongyi <zhaogongyi@huawei.com> wrote:

> When fork() failed and transfer the return value(-1) to kill(),
> kill(-1, SIGSTOP) would freeze the system, so it is very serious
> in this cases and should be avoided.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  .../conformance/interfaces/clock_nanosleep/1-5.c               | 3 +++
>  .../conformance/interfaces/nanosleep/3-2.c                     | 3 +++
>  .../conformance/interfaces/sigaction/10-1.c                    | 3 +++
>  .../conformance/interfaces/sigaction/11-1.c                    | 3 +++
>  .../conformance/interfaces/sigaction/9-1.c                     | 3 +++
>  5 files changed, 15 insertions(+)
>
> diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
> index 46f26163d..a87585884 100644
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
> @@ -48,6 +48,9 @@ int main(void)
>                         return CHILDFAIL;
>                 }
>                 return CHILDFAIL;
> +       } else if (pid < 0) {
> +               printf("fork() did not return success\n");
> +               return PTS_UNRESOLVED;
>

Can we do the error check following the fork() instantly?
Insert pid<0 with a 'else if' looks a bit strange here.

Normally convention like:

pid = fork();
 if (pid < 0)
    do error handle ...

-- 
Regards,
Li Wang

--000000000000a34b8d05cb737fe6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 7, 2021 at 8:41 PM Zhao Gongyi &lt;<a h=
ref=3D"mailto:zhaogongyi@huawei.com">zhaogongyi@huawei.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">When fork() faile=
d and transfer the return value(-1) to kill(),<br>
kill(-1, SIGSTOP) would freeze the system, so it is very serious<br>
in this cases and should be avoided.<br>
<br>
Signed-off-by: Zhao Gongyi &lt;<a href=3D"mailto:zhaogongyi@huawei.com" tar=
get=3D"_blank">zhaogongyi@huawei.com</a>&gt;<br>
---<br>
=C2=A0.../conformance/interfaces/clock_nanosleep/1-5.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 +++<br>
=C2=A0.../conformance/interfaces/nanosleep/3-2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 +++<br>
=C2=A0.../conformance/interfaces/sigaction/10-1.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 +++<br>
=C2=A0.../conformance/interfaces/sigaction/11-1.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 +++<br>
=C2=A0.../conformance/interfaces/sigaction/9-1.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 +++<br>
=C2=A05 files changed, 15 insertions(+)<br>
<br>
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_na=
nosleep/1-5.c b/testcases/open_posix_testsuite/conformance/interfaces/clock=
_nanosleep/1-5.c<br>
index 46f26163d..a87585884 100644<br>
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep=
/1-5.c<br>
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep=
/1-5.c<br>
@@ -48,6 +48,9 @@ int main(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return CHILDFAIL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return CHILDFAIL;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (pid &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;fork()=
 did not return success\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTS_UNRESOLV=
ED;<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">Can we do the error check following the fork() instant=
ly?</div><div class=3D"gmail_default" style=3D"font-size:small">Insert pid&=
lt;0 with a &#39;else if&#39; looks a bit strange here.</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">Normally convention like:</div><div class=3D=
"gmail_default" style=3D"font-size:small">=C2=A0</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">pid =3D fork();</div><div class=3D"gmail_=
default" style=3D"font-size:small">=C2=A0if (pid &lt; 0)</div><div class=3D=
"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 do error handle ...=
</div></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div=
></div></div>

--000000000000a34b8d05cb737fe6--


--===============0203899299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0203899299==--

