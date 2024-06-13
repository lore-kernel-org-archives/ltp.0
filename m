Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E222C27C4F
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 11:22:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CF9F3D0C55
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 13:22:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7653E3C70D5
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 13:22:39 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 84C121A00A2F
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 13:22:38 +0200 (CEST)
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-795524bb6d9so61247485a.0
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718277757; x=1718882557; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jbhQeJ/FepV55/M/RsA1+jQpC0AIRZChpwgvf0u+Dok=;
 b=X4J288wmf3y7V48pvpiac9pdHmkJrjyiww8ge9yr2FSAcv+50gIY3K2bnlDJVXbJAf
 rqeSWFeTnFG3jC/HKGUpivJhM2MbqH0ZMYz1hhsrgE/jtFhLq93hCoyLVVXl0MS/yqF6
 LPHtz3a/QWurh4LLysvnfrl6cr2ohehP1+Eq5Aa5mB8dK8s2L0PTka7uLf+m9iBVyTql
 UZpQc+cavgEJ3X7XkPVzoFcMQOuRjXtA8REeS7Yz6tLpIbT1iHRHmsAQSNvnl8yHmQzW
 lNn+FujCXN2rKNUq7hbxSXnugRtf1//JtVtllZjlExJzXqCUdet9gtP4//GSum2cnHUA
 boeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277757; x=1718882557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbhQeJ/FepV55/M/RsA1+jQpC0AIRZChpwgvf0u+Dok=;
 b=lY80fK4ioUOldGedxeu7lnPOVLdQUX5tPaJmusKuYiXViWGJ9I+KK4P6AyC4pwO8/h
 WMAAuY47jX/kEdNW9hfS5iNxpzEqweEpjL8qnIodj3Tvj3VdplJkn0en8CKiko2lCqD4
 sSweA2EJ2luj4ZMHThTw4hG4kPob96WR1ZhQ3tzfppL59VLGMdAOMKPVWOBdkzyzmVbL
 66t+MnKtYxOVFOxcvnhsqamP75u62dCZBtw6QewK4GgbhTgLWeS9JhL75qklYjn55JIL
 +B3BA24LQXvuggBewNkOzvQxVh8G6qrYPB+rKkY7eIrESg6jo024JEl3S+Ni8rcFOZ2G
 BfgA==
X-Gm-Message-State: AOJu0YyBRc3cyD5tO8J0NBRFAXeQqejUlp/2y1Cs9XJ4De0d9WDGcT+t
 66Nr2p8ymBQpN1/4N/FpLgyONC18qEhzOMTN+h5n0+H375eJb2Z8b6YOSH8kWSmm9M4MLdeRj+F
 SUEiMnK/Yr0rtGxBQKtOwMjHAghc43sVIzXwXqyHpk+tuMavtk0vYwA==
X-Google-Smtp-Source: AGHT+IFPcXyyY2iWYfIj2r/7FU9ElJRMDCUTPdF2CZ4Usi/TspXmXrkC/zlMva5CZ8CoEF/GpRqDyGbtfWjv/8Xhnv0=
X-Received: by 2002:a05:6214:3d11:b0:6b0:7a82:8f96 with SMTP id
 6a1803df08f44-6b191e3c1d1mr52539166d6.22.1718277757054; Thu, 13 Jun 2024
 04:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240612112311.10334-1-chrubis@suse.cz>
In-Reply-To: <20240612112311.10334-1-chrubis@suse.cz>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 13 Jun 2024 13:22:26 +0200
Message-ID: <CADYN=9K4K_nbe7hxxmEQ-gki-_mxrPka7z41R-1R_x2bM2N3WA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: starvation: Autocallibrate the timeout
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
Cc: Steve <xufeifei1@oppo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 12 Jun 2024 at 13:23, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Instead of hardcoding the values we attempt to measure the CPU speed and
> set the timeout accordingly. Given that the difference in the duration
> of the test when the kernel is buggy is about 30x we do not have to have
> a precise callibration, just very rough estimate if we are running on a
> server or small ARM board would suffice.
>
> So we attempt to measure how long does a bussy loop take and base the
> default timeout on that. On x86_64 CPUs the resulting timeout is about
> double of the value of the actual test runtime and works fine, but we
> need to make sure that the coeficient we divide the result from
> callibrate works for small boards too. So please run the test on as many
> machines as you can and report if we need to make the dividor smaller or
> not.
>
> CC: Steve <xufeifei1@oppo.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

I've tested this patch on 1 arm HW and 2 arm64 HW's. see the results below.

arm HW:
===== [1;36mstarvation[0m =====
command: starvation
[   43.278533] /usr/local/bin/kirk[356]: starting test starvation (starvation)
tst_test.c:1734: TINFO: LTP version: 20180118-5676-g4696467fb
tst_test.c:1618: TINFO: Timeout per run is 0h 05m 24s
starvation.c:86: TPASS: sched_setaffinity(0, sizeof(mask), &mask) returned 0
starvation.c:54: TINFO: CPU did 100000000 loops in 89172us
tst_test.c:1626: TINFO: Updating max runtime to 0h 01m 29s
tst_test.c:1618: TINFO: Timeout per run is 0h 06m 53s
starvation.c:132: TPASS: wait_for_pid(child_pid) passed
Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
Duration: 1m 2s

arm64 HW1:
===== [1;36mstarvation[0m =====
command: starvation
[   49.213159] /usr/local/bin/kirk[362]: starting test starvation (starvation)
[   49.213159] /usr/local/bin/kirk[362]: starting test starvation (starvation)
tst_test.c:1734: TINFO: LTP version: 20180118-5676-g4696467fb
tst_test.c:1618: TINFO: Timeout per run is 0h 05m 24s
starvation.c:86: TPASS: sched_setaffinity(0, sizeof(mask), &mask) returned 0
starvation.c:54: TINFO: CPU did 100000000 loops in 141688us
tst_test.c:1626: TINFO: Updating max runtime to 0h 02m 21s
tst_test.c:1618: TINFO: Timeout per run is 0h 07m 45s
starvation.c:132: TPASS: wait_for_pid(child_pid) passed
Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
Duration: 1m 32s

arm64 HW2:
===== [1;36mstarvation[0m =====
command: starvation
[   25.384826] /usr/local/bin/kirk[775]: starting test starvation (starvation)
tst_test.c:1734: TINFO: LTP version: 20180118-5676-g4696467fb
tst_test.c:1618: TINFO: Timeout per run is 0h 05m 24s
starvation.c:86: TPASS: sched_setaffinity(0, sizeof(mask), &mask) returned 0
starvation.c:54: TINFO: CPU did 100000000 loops in 113584us
tst_test.c:1626: TINFO: Updating max runtime to 0h 01m 53s
tst_test.c:1618: TINFO: Timeout per run is 0h 07m 17s
starvation.c:132: TPASS: wait_for_pid(child_pid) passed
Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
Duration: 1m 15s

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
