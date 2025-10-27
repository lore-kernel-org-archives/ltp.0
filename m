Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5B4CCF9E5
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 14:33:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 151393C4D80
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 15:33:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BED63C315D
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 15:32:59 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BDA4C2002D1
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 15:32:58 +0100 (CET)
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8910e8be161so52750885a.3
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761575577; x=1762180377; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OA09SGLyw52kWfQoMzg42v6FKVsyuCVBzjrUD11dSr8=;
 b=vq8ttF7sztpaB8+N+xz/isqCBuR6Ew38ApF3X7zl/lX6tNDLHlGZ7AjaYmc52vEBHt
 Fv37R20efoVgq+RT6ucnht8YiIwY4XgWaFGlCPe1tt3KBEJWVo3YMHQ7XwEjnX/LGSIR
 RPofK8EY73wXf0kBqW08rmZFkkwaxaqj96GopdunzMUK4cHaQGex7gUvzUt+f/NAdyUw
 /RW0HGQ41AJ9cJLZkgSuU70mMQ7ZkkrrLl9Y2qFJmZ1QzMXCFBMHd/jXXefHIgHbaaTj
 +dwTci7ynGEXx8gDACF9duN/il5uHcIzGbrvqaFtcCQwLDsrw72gFqfQ1BjwfYnLmRmZ
 AwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761575577; x=1762180377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OA09SGLyw52kWfQoMzg42v6FKVsyuCVBzjrUD11dSr8=;
 b=LaUjmbdsZiXn1SNmExD1+XjNxoqdklMoGT1H4PzpxwqGU50n6GM/DpNoifb75zoxgp
 jZTy/podZxUsva9oQpfkH3BgLwpSpos7oi04nraxuDYXyf3GtmsZdz06ZU9jlUQ8COay
 zWbpNefC4ig5wiDxr1Jy4/CJ0x5vwEE4IuPLvdJP7Wa9Mjs2gQ14TDlpbWmjjoGLg/pk
 OT/QgyCyWB75Qg+TexXpH7AABeTJz5SEWPpRHF9pSZY9BKedg9mdUKQAV5bf8rE2+4FL
 7Rjjh26P5hs1WmPYArxQXudOV2FMoEg4ioqOl81LsiOzgHsZaLeJzjOtaJStINttiKO+
 D/Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdsSngk6PRzZ/0B2cR1gkQJZdTM94necRascaLnXd3HIr7i+GNrKeMQ82GeMRLDORC19M=@lists.linux.it
X-Gm-Message-State: AOJu0YzhSYSBxoabGiVBFsibbCKU4XonEbP5iFtau1CRk5rd/hw/5krq
 weICiBkyUKQgJdnl9SIKGGawykw9eiXVPVoAxiiLX0dDqQEQqVcrDuzj+kftcc/Sdv6G2wnIkNu
 ofEiYanPWGaiY/s9N6n5H1TyKK9ijcSYiEtaIHCqCkw==
X-Gm-Gg: ASbGncsTBoDdVKmIIBN2cVlwxcQwntuP6TCF0CVdXkeX6glsuqIfKtq36btWUSP5aRo
 hDJaFgQ9RcN67y+isu+5y0Ey/nq/1e1DGcQoXTdcYh4RPwMB1Z9xcCJtXxU2WMq2nJXb9oSsgIX
 nmuRUIKK1/rSvGmJ4yl3DkOOl8I50zQPa/aKnHBk+adKc70EQ97b+tnImWCfaZohaR2zLwkrMEJ
 JZ8GhBVtX9nd0Oe1TWpyHAZzT5eujZL5q8/VzevswXjX9aEAbYGll4w9dC4fJLLO+oJC9Lwjt8m
 gBRdLUJaJR/qyDY=
X-Google-Smtp-Source: AGHT+IEo5xsSANTAsw2zusS1NLqyAyewcUFJu/786AM1KaccBtlnscPFWMPsIKbH4FZNgaWdqv9hiyfLBNwiUd+Hcgc=
X-Received: by 2002:ac8:7f45:0:b0:4d7:e0ed:421f with SMTP id
 d75a77b69052e-4ed0747f763mr2381701cf.3.1761575577508; Mon, 27 Oct 2025
 07:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251024125613.2340799-1-anders.roxell@linaro.org>
 <20251024133035.GA590258@pevik> <aPu2lqXN8G7h4e7D@stanley.mountain>
 <aP85jhbSvlYxeOiQ@rei>
In-Reply-To: <aP85jhbSvlYxeOiQ@rei>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 27 Oct 2025 15:32:46 +0100
X-Gm-Features: AWmQ_bn0kTWY6m5aZxYSXV35Y8RsyLf0pcRYmawWIbtRKhHeSppEe4Rs0uTx2qc
Message-ID: <CADYN=9JgKUWnqgJMe2KRWmtd=wctWwKKYr=abHO9e2S5u4c1qQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] file_attr02: Add XFS kernel config requirement
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
Cc: ltp@lists.linux.it, Dan Carpenter <dan.carpenter@linaro.org>,
 benjamin.copeland@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 27 Oct 2025 at 10:22, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > I wonder why tst_get_supported_fs_types() from lib/tst_supported_fs_types.c did
> > > not detect it. Could you please post whole output?
> > >
> > > Because if code in struct tst_test.filesystems does not work, many tests would
> > > be affected with this setup. I'm probably missing something, but I'd prefer to
> > > fix the detection in the library than force config (we don't have any CONFIG_.*_FS
> > > in testcases/).
>
> I think that we have a but in the test library, it looks like we do not
> check for the kernel support if we have only one filesystem defined in
> the tst_test.filesystems.
>
> The problem is that we are trying to avoid formatting and mounting the
> filesystem for each test iteration (if -i 10 is passed) but that means
> that we skip the filesystem kernel support. We only check for mkfs in
> the setup and prepare the device.
>
> This should fix it:

Indeed, this fixed the issue I tried it, for both file_attr02 and file_attr03.

Will you create a patch or do you want me to create one?

Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
