Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE96CC32771
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 18:16:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F2A03CAE18
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 20:16:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D1133C1BC8
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:16:11 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F136D6008BC
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:16:10 +0200 (CEST)
Received: by mail-ua1-x932.google.com with SMTP id p89so2722796uap.12
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=TBDlR/rQyPTINzxn8ptn5g00h/p2wcqdQs12NDZPQTs=;
 b=ePDWeWmlcKDxoD/P2PyZQTPCYfVt4EUagL2oaN8UBo/IRJAbtXfhPKPXJuib9TG8+E
 HUO8kYA7GF5MxTXfzqo7xtgXkxlPkcU29zxC36QEH7bQJdr12Bp1MvwkWijOI0lsInnx
 1tHxo7xlezIQwjVAAMEeBzKznNYAhojPyOrooDYUq1Ejn4AEH8BQ54wBBCGXjsa+oMry
 5my4zTFMiq93uaSj3xIV1Ik1nVrtHMjLK9Y3/WP+2yBVLD/Go8gsIor+BXIlIe4Uy2K9
 EaIumGbHm7CBNiP2yPk4JcHHIF6SVcP2eSdD8hlRW5jqn98stANilwu1K24cWCyvcxT8
 nlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=TBDlR/rQyPTINzxn8ptn5g00h/p2wcqdQs12NDZPQTs=;
 b=YvSxnndf9uial2kyrvytuMxwI4aRpWB5bd38ToAunrEA5ZnbLu8xBIrCkGKDSbY3wk
 DJa5IrVD9ftlVXSKvFLfFK8bdPnxh3eTFYa2xVE8n24cmRs1lXO9IAeOcBE2G6KfaHAp
 yXqnneodQgmwk+1ryDPcADHAykhLolH7RDBU+pyWxGyoQPA9aLTghGIykBH4IQabZQax
 FFKNdh9p6z4oIDHgdl9eSNMyy6sXB4q12Mh/gA5TxJ6nMAcXl7bPeYRRxb+64BzphAry
 Y64ZkZ0cAGGivVZACPjLK1vs5QI8bbZcwIeJbI4nUkPdqkR/hkLF/6ToUilGM/9t1e+B
 CNog==
X-Gm-Message-State: ACrzQf0AgZeBvvNkkceZlzPt3qJ/BBcYZrK83vCKntksor6EHlounsaT
 +OPQUP8DHL7hfwj/zC2CDdPuzkupYuX67ZTfwiv7xw==
X-Google-Smtp-Source: AMsMyM7XM+lM5yxUJHva0a4vMyXjdeTDqTh4pVfMU7eTORNpQrWYVTC+v836Mad/V08zHAXQAHn7O7cZA0q7WFWjXmA=
X-Received: by 2002:ab0:4a54:0:b0:3bf:296c:970d with SMTP id
 r20-20020ab04a54000000b003bf296c970dmr9613152uae.48.1664216169499; Mon, 26
 Sep 2022 11:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220913202839.1807979-1-edliaw@google.com>
 <YyGisrbDIgVa/0QA@yuki>
 <YyHYvCr0PISg6ISY@pevik> <YyHcNcTUNG+gU3rq@pevik>
 <CAG4es9Wi8oGf1OmNUqg41wv51Qmb9gewZrifUQW-wOPL0ZKNhA@mail.gmail.com>
 <YyQ+PiN0JBy6PLJI@yuki>
In-Reply-To: <YyQ+PiN0JBy6PLJI@yuki>
Date: Mon, 26 Sep 2022 11:15:42 -0700
Message-ID: <CAG4es9VB6AydFCRkBvPm=cyozOiqCBN8vxEo68_yvm-as+9FeA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] minmax: fix type warnings
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
Content-Type: multipart/mixed; boundary="===============1545383400=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1545383400==
Content-Type: multipart/alternative; boundary="0000000000009d2d2c05e998851d"

--0000000000009d2d2c05e998851d
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 16, 2022 at 2:11 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> Ideally when you are touching that code it should be cleaned up first
> and ported to the new test API. The code wasn't properly ported to LTP
> to begin with and there are hacks and wrappers around LTP API functions
> that should be removed as well.
>
> --
> Cyril Hrubis
> chrubis@suse.cz


Hi Cyril,
Sure thing, I've made an attempt to port mmapstress01, will send that for
feedback before tackling the others.
Thanks,
Edward

--0000000000009d2d2c05e998851d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Sep 16, 2022 at 2:11 AM Cyril Hru=
bis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<b=
r></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi!<br>
Ideally when you are touching that code it should be cleaned up first<br>
and ported to the new test API. The code wasn&#39;t properly ported to LTP<=
br>
to begin with and there are hacks and wrappers around LTP API functions<br>
that should be removed as well.<br>
<br>
-- <br>
Cyril Hrubis<br>
<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a></b=
lockquote><div><br></div><div>Hi Cyril,</div><div>Sure thing, I&#39;ve made=
 an attempt to port mmapstress01, will send that for feedback before tackli=
ng the others.=C2=A0</div><div>Thanks,</div><div>Edward</div></div></div>

--0000000000009d2d2c05e998851d--

--===============1545383400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1545383400==--
