Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B9AEE57DF
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 10:50:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E274B3CE855
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 12:50:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A7C23CB3CD
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 12:50:27 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A5101400435
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 12:50:27 +0200 (CEST)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso28694415ad.2
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694429426; x=1695034226; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KafoptB9spjBFM0mErOnUHH+/nBWguGloj63CeeQgmE=;
 b=RqZl/EYbmFvhMMY9YC7/gwpi3BFWwFzEeKEaN+Iv07Rudm7qIvIFmqsjcogyYsJmWi
 sCdnq4luLYpkgUt7ZXp5MUdQfud+Xa8ZeYC2BUvhJVlIHxtPmVh6SLJwvwm0qaoFBaE/
 kJq4SgVOBAMwU2I001ZNfkswrR7bzJcYbwz6RjwBsniWye+VucRjmiFf2ISZAwFLM2lS
 oAaKELliyxWi7u8wXvkLdSfJtfFLNsuea1yQfrCbL9HX6QgDTpL68gb9CKDjVoq72AIT
 IB7zMCjp02rUeGnmZ7vvpmTU+9ql63FjnjAys11mXI5g1IfBPwV7ZKTHiojJCdlNr0TK
 7mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694429426; x=1695034226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KafoptB9spjBFM0mErOnUHH+/nBWguGloj63CeeQgmE=;
 b=R/PYB4CQCs1+j5lUZ2jM1Ao8Lp16FnLpKjmaZ8YHdmgmNwE/r67ivxUpl4G31xivtN
 S5/QCrbH4WJBu2MlJLLDitK7ecSWBm2OqaMhjvGPQrHUoqeej18boMdzXsgk6aJpQCRD
 k6aAHomKkqXQoj/caDH1KnoGMV03XBLcwoYJNThxxJvNAvG8GkiJtIvVId0n6L2UuvQ1
 FvTrhRxJz82F76TwBdaqCdSdva4e9FlWnex5AARHFXmjCINnqr4BAnd+tLb0qpg7ZhJP
 K36dRY6/K1IGatW5nLTJe9bhjCRwuY8JatYwZkKnwsfZdkhEaAoTc3p9/kb4bwmRdlrk
 uE7w==
X-Gm-Message-State: AOJu0Yxjz6XG5l0NCT99UAR4K70+y4bB7LOXoGVzD/MkUlLfzCgCLmB0
 xRlAR14hjXGOgt4G32/eURV433KS6lXwlMEyC1o=
X-Google-Smtp-Source: AGHT+IGpnhnXn6G0laBvVMntjG5hpS16C1VA3aeJJBu+yNY1m0q0zSAkZ2cMg9Bw9pMw4BSPNjaySarStUMbIFsiAyo=
X-Received: by 2002:a17:90a:6081:b0:269:7f88:6b13 with SMTP id
 z1-20020a17090a608100b002697f886b13mr6946726pji.0.1694429425697; Mon, 11 Sep
 2023 03:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230909113004.21766-1-pastalian46@gmail.com>
 <CAEemH2f3-LqJ0M5yLoBPQErfkrWgELgiRZjzxGLJ0QrKMoof9Q@mail.gmail.com>
In-Reply-To: <CAEemH2f3-LqJ0M5yLoBPQErfkrWgELgiRZjzxGLJ0QrKMoof9Q@mail.gmail.com>
From: Takuya Wakazono <pastalian46@gmail.com>
Date: Mon, 11 Sep 2023 19:50:14 +0900
Message-ID: <CAAaAyq_1w2UqVSTkxy+x8CohiK2DEOHEjgVV5t7+gbL0s44VXQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] recvmsg01: Skip unsupported test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,
Thanks for the review.

> >         if ((tst_kvercmp(3, 17, 0) < 0)
> >                         && (tc->flags & MSG_ERRQUEUE)
> >                         && (tc->type & SOCK_STREAM)) {
> >                 tst_res(TCONF, "MSG_ERRQUEUE requires kernel >= 3.17");
> > +               return;
> >
>
> It'd be better to use tst_brk TCONF rather than tst_res + return.

Wouldn't that abort all subsequent test cases? We only want to skip the
MSG_ERRQUEUE test cases.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
