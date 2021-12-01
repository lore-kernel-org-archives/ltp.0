Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04335C433FE
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 07:11:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BBA03C8F0E
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 08:11:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95CE83C8D11
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:11:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B11081001276
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:11:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638342662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XXyMFOUBqDu/SH01DNJZpqWM/pZ+KwoE9orj0gYD0og=;
 b=Lj+l3I9BTwaCAGHx896XMtNiOzU8DOYxf9efW2RyfRGK/lszNP7wa6C+h1A6lZMNZyzi+m
 xTBtqKvYFSVVSaxjNEY5OJddP1Ty0RI8diwqqBgV13/NVr2wapFjBt5oxFbDlXRRmBe8oF
 noTbyy+rUY7ngoMsJY/zSIfpyeEU5qE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-CXAUrDE3OO-UfFJUSMFgIQ-1; Wed, 01 Dec 2021 02:11:01 -0500
X-MC-Unique: CXAUrDE3OO-UfFJUSMFgIQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 l145-20020a25cc97000000b005c5d04a1d52so34224401ybf.23
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 23:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XXyMFOUBqDu/SH01DNJZpqWM/pZ+KwoE9orj0gYD0og=;
 b=eqAKNHcqHS+jF0gw7ozji+GshG5aNFy36sd/g6zqnuGmfByusOFo+lWkpwj8SmQW5t
 7CluORyvIHIyQ4OkhSQF/6HKglI9JB7vPHXXFAVh8NOst9a2yrBJLCTm236yjzMWfCIx
 9XEQvT/d50ThOsmxzu2AzE04ltMWmzBvc1cdYnxtE1bK/H4nW3CQbk3Xebp8s8eO9xN3
 42LyAjUlcKG1vtSKLnNmbdkR5ybXr5xWc3WSGytCMsgfAIS18TPImRsKQFIE52Y5yes5
 xGWixwFa9EDo+rfBhUu3B2OuApvJdRDoMyyVypB+nXqlEngj26ugvRtjZOmqpE5nfnIO
 VBhQ==
X-Gm-Message-State: AOAM5306GpxxKEkpAH/oZQnTafjLW8v0t9cdVlaRDtmo48KJenghiN4z
 CxNhzNykE8XhOl0NfzvW81am+VBSpvsZEy+J+A4MBcUcmTXgrgkqcnTPvm1zlsnFemqTvKqhBie
 jtYMHN5aNwVzCXxrj0zo2+4CuEKs=
X-Received: by 2002:a25:f621:: with SMTP id t33mr5199152ybd.576.1638342660545; 
 Tue, 30 Nov 2021 23:11:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5cQ7n1JKND1j7Z2IDxFP1AW1zl8XcXC2D/aFSyTtxfHXojwJFkMbPbkub3Nt9nl6K+Vb9iygODbanRReSH6M=
X-Received: by 2002:a25:f621:: with SMTP id t33mr5199134ybd.576.1638342660361; 
 Tue, 30 Nov 2021 23:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20211130104330.32679-1-chrubis@suse.cz>
In-Reply-To: <20211130104330.32679-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 1 Dec 2021 15:10:46 +0800
Message-ID: <CAEemH2cJ-UOFAy0hzZad8uj1PCJA4VVt7SyQRwYPEUtYFGZgJA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] scripts/checkpatch.pl: Replace kstrto with
 tst_parse_
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
Content-Type: multipart/mixed; boundary="===============1996583976=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1996583976==
Content-Type: multipart/alternative; boundary="0000000000004aa89205d210601b"

--0000000000004aa89205d210601b
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 30, 2021 at 6:42 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Since there is no kstrto*() family of functions in LTP we do have
> tst_parse_*() instead.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--0000000000004aa89205d210601b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Nov 30, 2021 at 6:42 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Since there is no kstrto*()=
 family of functions in LTP we do have<br>
tst_parse_*() instead.<br>
<br>
Signed-off-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=
=3D"_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div>=C2=A0</div><div><=
span class=3D"gmail_default" style=3D"font-size:small"></span>Reviewed-by: =
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt;</div><div><span class=3D"gmail_default"></span>=C2=A0</di=
v></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">=
<div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000004aa89205d210601b--


--===============1996583976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1996583976==--

