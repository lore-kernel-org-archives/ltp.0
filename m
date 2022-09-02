Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30094ECAAD2
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 03:26:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 267A23CA8B0
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 05:26:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 872A63CA6D4
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 05:26:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 38823600748
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 05:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662089171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LKMKJuHUQMDXXFG121uQAayODUfIzIcttJvdMD0LADQ=;
 b=VBQDXYL6k1idrL4iuAp5MI7bhI5yag1caZD5teR8NrHU3qakoVz+t/VxgXuHsGACf1gtp4
 TKGzWUq7UdMr7iLbS71qg6+AyuyB+wUWv+XFUXo8FnmiC7jQ0BkhgiUzXH4169Djc/iH1J
 jUjVsDjqRhPGCGFep6TuBNm8786w5Y0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-1ww34bSyPP2d-IP4CWQpYw-1; Thu, 01 Sep 2022 23:26:10 -0400
X-MC-Unique: 1ww34bSyPP2d-IP4CWQpYw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-31f5960500bso6013147b3.14
 for <ltp@lists.linux.it>; Thu, 01 Sep 2022 20:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=LKMKJuHUQMDXXFG121uQAayODUfIzIcttJvdMD0LADQ=;
 b=SjFuGv92B52iU+IW7E8OUI20wRIIOlB80/S01cIBbLBt4YCY9LaRpDoCZ4LDJaFDWP
 aVD5Umkvu8PpxW63CWvqUyyM3h6w9c+2o9SkYnZWxPRW6EULkNSWOJT3h8359MUAtGJ5
 /QF4CWd26I9slCnUi92P2GkjnLEA2kLzdWaMcTIOqiR3oESM9m6y1XREmSa3R9AyzBJR
 eg4m6Q/ia5H2jfXe65Z9RXWCtsqzfCbobxXcQuuWYljvw73R843QRKue6Ld+FV1rVzBm
 M+pUpenFqjgn0E8hKFXe5N6xpp45q6RRHwN7CYgHtvoBFL0MYKsaWh+9mbvNyZlN+XjC
 7cZw==
X-Gm-Message-State: ACgBeo1jy8dIuEodCSMhK9jKBYXisJUvR4jfHq3m0y8HTzqrDEHmlWfI
 1qphYluJ+x/mnnjWyxmccDzvUb1usauIr8mOTG+KEMtgl+dg1cQH6S49OhE+iIht1gUXN7qDRiz
 +gOxkxbxJUQnNCbzucvP/AJ8cHAw=
X-Received: by 2002:a81:5a84:0:b0:341:4c44:1230 with SMTP id
 o126-20020a815a84000000b003414c441230mr17303906ywb.53.1662089168866; 
 Thu, 01 Sep 2022 20:26:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/aXuxBIgXMj6mqH99xJWm0s88nc3PicdwHPtXytXNJ0MCHIm90qfP2Q3bExEcQhCwiGpKVKe4jxgT1ogaGA4=
X-Received: by 2002:a81:5a84:0:b0:341:4c44:1230 with SMTP id
 o126-20020a815a84000000b003414c441230mr17303886ywb.53.1662089168505; Thu, 01
 Sep 2022 20:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220901203306.28623-1-edliaw@google.com>
In-Reply-To: <20220901203306.28623-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Sep 2022 11:25:57 +0800
Message-ID: <CAEemH2fwqvULb8oXoGgb+=s2y=j2C9r697+1r6xnAo_cpk=9SA@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] lapi/name_to_handle.h: fix include
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1679915256=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1679915256==
Content-Type: multipart/alternative; boundary="00000000000079647705e7a94a11"

--00000000000079647705e7a94a11
Content-Type: text/plain; charset="UTF-8"

> Import tst_test.h before lapi/syscalls.h so that the compiler defines
> the correct symbols to use.
>

Thanks for the fix, applied.

-- 
Regards,
Li Wang

--00000000000079647705e7a94a11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Import tst_test.h before lapi/syscalls.h s=
o that the compiler defines<br>
the correct symbols to use.<br></blockquote><div><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">Thanks for the fix, applied.</div></=
div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000079647705e7a94a11--


--===============1679915256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1679915256==--

