Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD80C83F26
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 08:09:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 883CD3C9F39
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 10:09:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BC0B3C9ABA
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:09:39 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9487D200981
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:09:38 +0200 (CEST)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2401b855980so16504635ad.1
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 01:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753776577; x=1754381377; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Ab/B/bY4NoYo6nuvyCQMLVOHlBThrptf69H7NIo6vI=;
 b=fDQrS5ktXNujt+sSI92h1EvaeP+++vG1htD7d9SWCnI4PoWriu8+MyhaDYwM9nz6jg
 VylZUZzmM6R/IyHTPYy0l0EQmyVANMm9v/TaiFKopxgTI5dpjNunkyGvHuEGxY9i58el
 1ZdDRsEAOTKQFpDLvI+228ylXg0KUxr5i/e9lRwc4HuVR3D2+Y/VdiZyGT2pl39z/1hV
 ilmkwbEbg35lwE537TWtPm78uGqC7pBuzefg28Ih+dLh3H181rj0RyPCx6fahLHMDgJ1
 UHjij/PLjYdZjtncFUqBDITYyvySh8gNYTpN3nJ+zLRGd8NeGJ8vgF2vqRhZlr6vk6gO
 gGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753776577; x=1754381377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Ab/B/bY4NoYo6nuvyCQMLVOHlBThrptf69H7NIo6vI=;
 b=ibcQJ53ega5k6tejSoxwpYg1zRk6m4vfc0RrOxG8tI3DszsOrNvM9nIcx5DTG8sJ5x
 xZMpORIzrVnaGU+/oGQ4RAEZP0cSbMHWRZAb8EDNQ5JbtPTnRaLeBNbE7v3NcVNSCcsb
 bdwaHLL7T4RKjEw7m1I3vWAxI+D3KoPzCpcvoZI13aBwdwXLnYIAoaZHZDwAWY3ucTeM
 gwR3K9u13FYKG+IUrk8LtY5Vp+BpfWFqDyQugA1j9O0toEHx/UirzmBSrUhUySGcTb8X
 GjDZWvqX3vaLZn4Ftjj84XWJTjSbxC3EI0o7Z4eJ3rQ2lmoZUXQjhuxwqcwIsmDHvZLO
 Recw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7unCebFYfZy9ifOQrKjgEOWuTaImPiXBgJ/wnx8LS8S6ZhY/M5+H8QhL7sAxw/p3jPkY=@lists.linux.it
X-Gm-Message-State: AOJu0Yy4TMs25r+SElWyuDsYKHgNUZRxgrKroR9uwAkwLiByYlxLipY5
 nCmRNNWgqrX/OXWL2jNnd4jfgZ5JOxbckEJmv+NBi1k1JMcijW0osleExQidOHZV4cOd5Drqa8H
 jgCuxLz6RjKxY8MZfMpaJn4FEgn1sBWzH2/7AbQK+0w==
X-Gm-Gg: ASbGncvEpCZxlM31MwKkb4TEbk7fZ/+Fowry8zINk1LUS0Z/y5R4Dty22NNexI0cnDQ
 jkjTWA7zbJMbMUnvXjCYqxJJIK93d4tPlkw/cRXPYwapz9mVe8riHcsPQO5k7Uhitkks7xnLg/4
 IkEkF+5lk0D3tTrMggz/9V6BKYvU0rPY+iZPQcjsOiUnGkqylhDuBPmayvGWjodV69siv4RDeHE
 98CogyqsTCkPhGGngYH1Hw+JKfDQDISi18aQNPf
X-Google-Smtp-Source: AGHT+IGT2ViHy+e75VyPaoxKYCIeUubMMJSlzBnqnPapx1U8FGl4cpJH5mjItg4QXCRZShPYfKYnW9zlECcYxgZ0igs=
X-Received: by 2002:a17:903:1b10:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-23fb304fef6mr229724345ad.4.1753776576971; Tue, 29 Jul 2025
 01:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAL0q8a7ZKQKN2U-tWDaAui9Yr47oZGZgiF3qdxTaX8+-6Aogzg@mail.gmail.com>
 <CAL0q8a5vePcnKkrPab+aK3U_qCaKvuUYw3NMNN=D-+fwE5TwOA@mail.gmail.com>
In-Reply-To: <CAL0q8a5vePcnKkrPab+aK3U_qCaKvuUYw3NMNN=D-+fwE5TwOA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 29 Jul 2025 13:39:24 +0530
X-Gm-Features: Ac12FXw6KTiuHzyowkUc6W3yND2l-jrA-wLg4n-gryfJOOrGawi_5puCZEu9bro
Message-ID: <CA+G9fYtxbfWsPfBkryN_K_SzZvsrdQH2thZWPDK3huo=FoVpJw@mail.gmail.com>
To: Ben Copeland <ben.copeland@linaro.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] vma05: Fix false positives from stripped system libraries
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
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

+ ltp
+ arnd

On Mon, 28 Jul 2025 at 19:26, Ben Copeland <ben.copeland@linaro.org> wrote:
>
> Sorry I typo'ed Cyril email address.
>
> Regards
>
> Ben
>
> On Mon, 28 Jul 2025 at 14:37, Ben Copeland <ben.copeland@linaro.org> wrote:
> >
> > Hi Cyril / Petr,
> >
> > I hope you are doing well.
> >
> > I have been seeing a test case fail for several years. I recently
> > added a new device in LKFT and noticed vma05 failing. I bumped into
> > issue [1].
> >
> > Upon looking into this failure, I noticed the vma05 test currently
> > produces false positive failures by flagging any `??` symbols in gdb
> > backtraces as vDSO kernel bugs, including those from standard stripped
> > system libraries. This causes the test to fail on most production
> > systems where system libraries like libc.so.6 are stripped of debug
> > symbols.
> >
> > This fails when gdb shows backtraces like:
> > ```
> > #0 0x0000ffff8d427dc0 in ?? () from /lib/aarch64-linux-gnu/libc.so.6
> > #1 0x0000ffff8d3d6980 [PAC] in raise () from /lib/aarch64-linux-gnu/libc.so.6
> > #2 0x0000aaaac6000690 [PAC] in main () at vma05_vdso.c:5 ```
> > ```
> > The `??` symbols from libc.so.6 are normal (stripped system library),
> > but the test incorrectly interprets this as a vDSO kernel bug.
> >
> > I also preserve debug symbols for memory test when building ltp with
> > this change, when we build LTP.
> >
> > ```
> > -find ${INSDIR}/opt/ltp -type f -executable -exec sh -c "file -i '{}'
> > | grep -q 'executable; charset=binary'" \; -print | tee
> > ltp-exec-files.txt
> > +find ${INSDIR}/opt/ltp -type f -executable -not -path "*/mem/*" -exec
> > sh -c "file -i '{}' | grep -q 'executable; charset=binary'" \; -print
> > | tee ltp-exec-files.txt
> > ```
> >
> > From our side I have now stripped out the binaries, but also I believe
> > the vma05 test logic is flawed so I made some adjustments [2]. The
> > test now passes.
> >
> > I'm happy to put a PR up, but Anders and I thought it would make sense
> > to touch base and also see what you think. I guess the other question
> > is, does this problem lend itself to just this test case, or are there
> > others sitting around LTP?
> >
> > Regards,
> >
> > Ben
> >
> > 1: https://github.com/linux-test-project/ltp/issues/477
> > 2: https://github.com/bhcopeland/ltp/commit/67ecbfcfe2313c4b16ce7191ded9949fdf5728d9

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
