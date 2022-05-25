Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E5EC433F5
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 10:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 309C63CAC71
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 12:17:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3EFB3CAC4B
 for <ltp@lists.linux.it>; Wed, 25 May 2022 12:16:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ADFE510007C3
 for <ltp@lists.linux.it>; Wed, 25 May 2022 12:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653473817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JhBmZL+Iefgektq8pB+NtD54JZwKIslxyyrzaZZdd40=;
 b=JMuKr+ysXPnxaJSZGgqubpKr8o5DzmOpgocFJOHqfJAsE0DdkWdMp8QzWHdTyf7nfe7gAi
 /RKjBRXRgkPPOeB/48RP0WjUddqUIaQ8MgG/G0oO/RrXZGRZF8akYYY8fuDQLTdDb89exi
 XSUsKVPWGd+Ly0rMNGPeNo5FvahJItc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-9qmDG8tfNamKQmmJxYE_Yg-1; Wed, 25 May 2022 06:16:55 -0400
X-MC-Unique: 9qmDG8tfNamKQmmJxYE_Yg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2dc7bdd666fso174273777b3.7
 for <ltp@lists.linux.it>; Wed, 25 May 2022 03:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JhBmZL+Iefgektq8pB+NtD54JZwKIslxyyrzaZZdd40=;
 b=ChfRk1LJXzEX0Zv5L0EMsK+vOqjk4gKIlRHfKf+OmOwJxE8rjnmDL+vhSAxJyAIA4i
 ZUzIEPVmDMk+jAg4SKguqIa1IU2EirNLPOn4j9FhxkgDQ1TLf8/4W2f2Cs9lD/vspwDV
 CF3HSjlw3DMJ+MPkyQOxXQodfWplFxUU080lDPgXRpD5PI+nyj9/hYNB06Wu04DCXrNH
 0jGSJpFHIQExpwAIxZhL8nVJM10eUG3GSTe73rp2ISbT1SXBJibtgBud4zqzuWWMPeOK
 SrZ4MDfGLk1Yuu4vnbzWn83enddMfxthSwLTiJYBzzhdp8j+ug2yVPuNaO+pGM8faihN
 5kvg==
X-Gm-Message-State: AOAM532ipvWo2c622wcusjGRBnxOpUbXPYg6PGNVTPi2qozNm2VVWkKE
 cdLC5HmWyg6VyPuoLAMe8P6YyowfSCDT55hIECYcXk7LDU4w6nCS6ssollTxCvrtUCZPVyZka3D
 5NW0PeGePgGLeo1h/EHUwBVtLPCQ=
X-Received: by 2002:a25:d18a:0:b0:652:f8fd:5009 with SMTP id
 i132-20020a25d18a000000b00652f8fd5009mr6132652ybg.412.1653473814898; 
 Wed, 25 May 2022 03:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz12IyIEZivg3B3t/CsM4Lr1SDWJTRg19ImDTbzWOgRiQM0WKebE4z4lz7Ij+uF0co4C/8ogWg7RdfTXbqawzQ=
X-Received: by 2002:a25:d18a:0:b0:652:f8fd:5009 with SMTP id
 i132-20020a25d18a000000b00652f8fd5009mr6132637ybg.412.1653473814643; Wed, 25
 May 2022 03:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <YozXG/f0HHSrhm9E@yuki>
 <20220525065124.2665801-1-liwang@redhat.com>
 <Yo3nAGS+R3IwYYy9@yuki>
In-Reply-To: <Yo3nAGS+R3IwYYy9@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 25 May 2022 18:16:43 +0800
Message-ID: <CAEemH2cfCmR0PqpMRecS2a+789ENkz-YVupuJqN+vBDKeaSwng@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] preadv203: set max_runtime to 270s
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
Content-Type: multipart/mixed; boundary="===============2023754256=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2023754256==
Content-Type: multipart/alternative; boundary="0000000000005e1f8f05dfd35f77"

--0000000000005e1f8f05dfd35f77
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:

Hi!
> > Before the runtime patchset preadv203 use 5min as default timeout
> > per fs, that's really long enough for prepare_device(). But after
> > that, its now only has 30s which might be short for a slower system
> > to do preparation work.
> >
> > Let's set max_runtime to 270s to make the timeout at least equal
> > to previously.
>
> Isn't the main reason why the test fails that the verify_preadv2()
> function spins for at most 60 seconds?
>

Ah, you're right!
I overlooked that spins 60s but wrongly blame the default timeout in the
library.

>
> I guess that the proper solution should be:
>

This patch works for me. I will send V2 as your suggestion.

-- 
Regards,
Li Wang

--0000000000005e1f8f05dfd35f77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@s=
use.cz</a>&gt; wrote:<br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div></div><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi!<br>
&gt; Before the runtime patchset preadv203 use 5min as default timeout<br>
&gt; per fs, that&#39;s really long enough for prepare_device(). But after<=
br>
&gt; that, its now only has 30s which might be short for a slower system<br=
>
&gt; to do preparation work.<br>
&gt; <br>
&gt; Let&#39;s set max_runtime to 270s to make the timeout at least equal<b=
r>
&gt; to previously.<br>
<br>
Isn&#39;t the main reason why the test fails that the verify_preadv2()<br>
function spins for at most 60 seconds?<br></blockquote><div><br></div><div =
class=3D"gmail_default" style=3D"font-size:small">Ah, you&#39;re right!</di=
v><div class=3D"gmail_default" style=3D"font-size:small">I overlooked that =
spins 60s but wrongly blame the default timeout in the library.<br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small"></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
I guess that the proper solution should be:<br></blockquote><div><br></div>=
<div class=3D"gmail_default" style=3D"font-size:small">This patch works for=
 me. I will send V2 as your suggestion.</div></div><div><br></div>-- <br><d=
iv dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br>=
</div><div>Li Wang<br></div></div></div></div>

--0000000000005e1f8f05dfd35f77--


--===============2023754256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2023754256==--

