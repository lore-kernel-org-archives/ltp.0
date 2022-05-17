Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEFEC433EF
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 12:28:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25E623CAA5D
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 14:28:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3799A3C0282
 for <ltp@lists.linux.it>; Tue, 17 May 2022 14:28:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 77EDA1400C59
 for <ltp@lists.linux.it>; Tue, 17 May 2022 14:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652790521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ioPG6F+y96eS0oW7OWRsCgQmcCC9vvtF2Ahiu/jS3KU=;
 b=PlnHfMDjtHTXWH+XO3MKsGcZRGf31hd+JWgQtbJnC1vWAHR+SViuHrW2cSdGIwYiLz+3EE
 weQ0dYsQ45XVCcMyfxTIcSS3D+TK0fL4v85RR5WO5nlSdvcyRWmOD/LD1BgRYHCuGk7Pog
 ZEhip6jvghCkqt36LkzdJBe+ibTypHg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-pgBh5hwfNKymOLitx5B4wg-1; Tue, 17 May 2022 08:28:37 -0400
X-MC-Unique: pgBh5hwfNKymOLitx5B4wg-1
Received: by mail-yb1-f197.google.com with SMTP id
 a144-20020a25ca96000000b0064d6e10dd6aso6751031ybg.1
 for <ltp@lists.linux.it>; Tue, 17 May 2022 05:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ioPG6F+y96eS0oW7OWRsCgQmcCC9vvtF2Ahiu/jS3KU=;
 b=dklFIpUP+iseHdyvcD4DYiL7Y+gkw+9wDPtz11O7pCuPYBGvfoMn6lndeVblYrT6Aj
 4bgKzczFFhMeCNhf/9pOSrG7zGA3UG7irLAIL9pgISNS+F+lMuJHFwoTks3Dv0s0RbPj
 4DkNFM2mrCu8u6qoYfF6L5eErvt8kbrzrpENWWqUY/iN0irzCg0FgibqINGAbnKM2qFa
 KLyM+H4Ksjr2Z/E5ZcNB7gs9kbzrwANJleaLZZa+Rp8tENZHhdsZBjU8FRuRxtpdGFl5
 2sDs6aa42Uibhk90np++z7RvWwcEmgjE/aZEqqh0eP0OSeXq5PWmM6FsixyWbDRFSeMc
 ePJw==
X-Gm-Message-State: AOAM533fSt8r/3JiioRtGdByG8B7EnRdqSmmohB8MPjhUJTUvm0M/4hA
 R2dI4v3j3yT8zSCnHa5rStIZAHx2Edkqk/wOlXxiQzdNl7vtYbZp5Xd3wRjLmVlykLshiujBng3
 jj22Y+bGP8UyZTAlEPyItaY7ye3k=
X-Received: by 2002:a25:f312:0:b0:64d:6742:1e80 with SMTP id
 c18-20020a25f312000000b0064d67421e80mr15432689ybs.273.1652790517380; 
 Tue, 17 May 2022 05:28:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWYUUU8oPX/vV7sn2q85GqzZTGOUPo/QgyFUTbBdhWeOxCpd9Xi9QCm8GE0kJW4/j8Ll7Pgsvd2peUPsUBROA=
X-Received: by 2002:a25:f312:0:b0:64d:6742:1e80 with SMTP id
 c18-20020a25f312000000b0064d67421e80mr15432663ybs.273.1652790517047; Tue, 17
 May 2022 05:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki> <875ym5di8f.fsf@suse.de> <YoN/W4wbow2fyOut@yuki>
In-Reply-To: <YoN/W4wbow2fyOut@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 17 May 2022 20:28:26 +0800
Message-ID: <CAEemH2cazgjqj4C1nuqPcRCC0dZoxwi-yiJymRgJxr0woXXFWw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1272279273=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1272279273==
Content-Type: multipart/alternative; boundary="000000000000a8365205df344731"

--000000000000a8365205df344731
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> > Or each test case (defined by tcnt) could be given an equal share of the
> > runtime?
>
> That would be solution as well. If everyone agrees on this I will go
> with this version, it should be as easy as:
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index dad8aad92..69d7799c3 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1349,6 +1349,8 @@ static void run_tests(void)
>
>                 if (results_equal(&saved_results, results))
>                         tst_brk(TBROK, "Test %i haven't reported
> results!", i);
> +
> +               kill(getppid(), SIGUSR1);
>

I have to say NO here.

This is only reset timeout for each test, the problem we're encountered
is the max_runtime exhausting, we have to reset 'results->max_runtime'
but not .timeout.

-- 
Regards,
Li Wang

--000000000000a8365205df344731
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chr=
ubis@suse.cz</a>&gt; wrote:<br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"> <br>
&gt; Or each test case (defined by tcnt) could be given an equal share of t=
he<br>
&gt; runtime?<br>
<br>
That would be solution as well. If everyone agrees on this I will go<br>
with this version, it should be as easy as:<br>
<br>
diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
index dad8aad92..69d7799c3 100644<br>
--- a/lib/tst_test.c<br>
+++ b/lib/tst_test.c<br>
@@ -1349,6 +1349,8 @@ static void run_tests(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (results_equal(&=
amp;saved_results, results))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tst_brk(TBROK, &quot;Test %i haven&#39;t reported results!&quot;=
, i);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kill(getppid(), SIG=
USR1);<br></blockquote><div><br></div><div><div class=3D"gmail_default" sty=
le=3D"font-size:small">I have to say NO here.</div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">This is only reset timeout fo=
r each test, the problem we&#39;re encountered<br></div><div class=3D"gmail=
_default" style=3D"font-size:small">is the max_runtime exhausting, we have =
to reset &#39;results-&gt;max_runtime&#39;</div><div class=3D"gmail_default=
" style=3D"font-size:small">but not .timeout.</div></div><div><br></div></d=
iv>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000a8365205df344731--


--===============1272279273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1272279273==--

