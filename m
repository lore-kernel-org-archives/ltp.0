Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528B4C25B0E
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 23:00:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4B23C9AC7
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 01:00:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3E8E3C91D2
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 01:00:21 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 722211400537
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 01:00:19 +0200 (CEST)
Received: by mail-vs1-xe29.google.com with SMTP id m67so11607320vsc.12
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=6cqpYws9Kkr5SsRvOdPN2iATfm3cKMuT/gfwcTCKA7A=;
 b=WzSSjhCUnOZk+Eq/419hEzZRqdeBNzCWZBXgvx6KXahuglmr9ebvv96NmZYEtHxyNJ
 cTlH5FWQ371zsdUUaiky2yQNa9BLZeOpAE1z0wu48QhuWzQqinY/LH+Qzu4oXRbEotaN
 +YD809o0WEhEH+a7vhYr7k3HM0W/8NIGgoAd3olk3yTQ4hzQw6JO0yPrqysvHiAdr+zA
 YbSzxldOGbrOyQr4puR95JlsTAHZ48eSnW/aIbPeRfu3Cv+xSVuzb8E3mDvR4LW84I6s
 TSFLWmegTXjjOYaHCOQ0fL2e/+ZQD1QjSMPE6y+RiNhenXfRQ6K920SCpUAOjhmRMBXc
 f3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=6cqpYws9Kkr5SsRvOdPN2iATfm3cKMuT/gfwcTCKA7A=;
 b=cNJQEIGY2apoxD0dRFGQOl9JR6OJSCXqtsd902a+u1bYAW5lGYXCJsyQkmj3PuqfLs
 A+6YhL6FbVm8bssBEivGdaRRaoNND11YFdkOYJiiddVJfxhnUHJKoJ1WplbjDJzJGkGy
 6jWCJi9LRP1WcRXXiGYscPveOx2UnZa9JXFVvptzJy9OEiJK8Yyts/3yC0Czsor4FBLi
 SdCqLvLO07qhLoy3GeNpAn3qoUZxj20Wh7AHpche1sa8c+GiTZdiC6AWGDGskELhC4Zz
 rgOrAOR7W8Q6fPlFRsUFvBiqKDuh49dpye0H0Zj9sGbttwukp2yMhZuro4nQOgrgx0B9
 CAoA==
X-Gm-Message-State: ACgBeo1MaxsBqJA6SauQpk3H8EBx+eb2oqGBbL4N1B+tPJHsxo0dvs0m
 /675TmmRjJGeIcuHKyoUm4CGEUEOjqSaUdvZt7PbmA==
X-Google-Smtp-Source: AA6agR6ed0y7RcyA02HPD9otW/FbtDBAxh9gbj6b+Y5WMoXFf6fiuGPqH+GfgXPRdxpTqNcpNX9wRb2aFLtOZldzD5U=
X-Received: by 2002:a67:b243:0:b0:38c:2d4e:78b4 with SMTP id
 s3-20020a67b243000000b0038c2d4e78b4mr2505159vsh.73.1660690818027; Tue, 16 Aug
 2022 16:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220712173921.2623135-1-edliaw@google.com> <YtaFddMFjVPMTpme@rei>
 <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
 <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
 <YvUhZ/9Yf7eZ4a32@yuki> <YvuRAR1DSi67PDzh@pevik>
In-Reply-To: <YvuRAR1DSi67PDzh@pevik>
Date: Tue, 16 Aug 2022 16:00:07 -0700
Message-ID: <CAG4es9XdXgmPOQK3i+FL3VD-Y8C39sAShwdM6bi7U-CJjk7BQg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1264159511=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1264159511==
Content-Type: multipart/alternative; boundary="0000000000004aff6605e663b616"

--0000000000004aff6605e663b616
Content-Type: text/plain; charset="UTF-8"

We are currently building with clang 14.0.6.  I haven't filed a bug report
with llvm, will work on doing that.

On Tue, Aug 16, 2022 at 5:43 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Edward,
>
> > Hi!
> > > I think I finally understand what you mean by this now; it is rather
> > > strange that the volatility of D does not protect loop from being
> > > optimized away by the compiler.  I don't have a good explanation as to
> > > why it's happening but I'm not sure how to evaluate what's going on
> > > either.  Should I do anything to move this patch forward?
>
> > It all boils down if we want to work around something that looks like a
> > compiler bug in tests or not. I would be inclined not to do so since LTP
> > was littered with quite a lot of workarounds for glibc/compiler bugs and
> > we spend quite some time cleaning that mess up. But in this case I can
> > agree that this is a borderland issue so I'm not strongly against that
> > either.
>
> Edward, which which clang version requires it? It'd be nice to document
> it, so
> that it can be removed in the future.
> Is there any bug report for it?
>
> Kind regards,
> Petr
>

--0000000000004aff6605e663b616
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We are currently building with=C2=A0clang 14.0.6.=C2=A0 I =
haven&#39;t filed a bug report with llvm, will work on doing that.</div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, A=
ug 16, 2022 at 5:43 AM Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" tar=
get=3D"_blank">pvorel@suse.cz</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi Edward,<br>
<br>
&gt; Hi!<br>
&gt; &gt; I think I finally understand what you mean by this now; it is rat=
her<br>
&gt; &gt; strange that the volatility of D does not protect loop from being=
<br>
&gt; &gt; optimized away by the compiler.=C2=A0 I don&#39;t have a good exp=
lanation as to<br>
&gt; &gt; why it&#39;s happening but I&#39;m not sure how to evaluate what&=
#39;s going on<br>
&gt; &gt; either.=C2=A0 Should I do anything to move this patch forward?<br=
>
<br>
&gt; It all boils down if we want to work around something that looks like =
a<br>
&gt; compiler bug in tests or not. I would be inclined not to do so since L=
TP<br>
&gt; was littered with quite a lot of workarounds for glibc/compiler bugs a=
nd<br>
&gt; we spend quite some time cleaning that mess up. But in this case I can=
<br>
&gt; agree that this is a borderland issue so I&#39;m not strongly against =
that<br>
&gt; either.<br>
<br>
Edward, which which clang version requires it? It&#39;d be nice to document=
 it, so<br>
that it can be removed in the future.<br>
Is there any bug report for it?<br>
<br>
Kind regards,<br>
Petr<br>
</blockquote></div>

--0000000000004aff6605e663b616--

--===============1264159511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1264159511==--
