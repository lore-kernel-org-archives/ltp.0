Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EDAC55182
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 04:10:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A82E3E90C6
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 06:10:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9B653E12E0
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 06:09:57 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CEA921A009B8
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 06:09:56 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92edb00a64eso8948885a.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 21:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785902995; x=1786507795; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KsP76tDKxTtl8pFwz+QZBtezFvr3Fol3Mfil6wXtTtY=;
 b=MHkK2F6EbOX0bSnjJxd1hPpMzhbsf+xOLeZxQG/9FB0nZWCzLSHBbWrahbR0Fi2B4A
 MnZIcRraB8orGWQSgvmQ9n7gSUxrlA/U9t+a6KT8ZpoIg3HwtcbqOidPPaPkKrM3A+3H
 NRqDJw0UwNIFf3QRds6SYcJmw4zhje8uS3ve0ZpnczjZtgAWlj29bBxtrDNdThkTzi0p
 l147miNWN7teHIcaYhNXMjrGHgKQIvyge/V3tsFOZVAik5NU6znaAdn+rWd4Nwu3UT39
 18jxF/SCRnQipMDuIZB9p+TIVZpz/4/vmoJIfDb5CfD8EuWGO3F8Pi4ImqeVpZgtOuwX
 4aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785902995; x=1786507795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KsP76tDKxTtl8pFwz+QZBtezFvr3Fol3Mfil6wXtTtY=;
 b=bz2I2zQa5ix+stutWMhJZVXnPsE6E3rIVBAx5wNPl0nqO6E49wKTMgT6EGA2I04B3A
 +0ZjnLCTKeb7rfbetGVRrxT9Gc0Iux0DrqbgBOpoB3Cu2OvdYYSD1HsiuBwVA4qwghk/
 jO2TDhCzBEWIR2Vs5TXhIHvP7yRaWvzhV3598Uqc341TggAChQKSHcoLDrlDfvyUabce
 iDVVpxlmmnKsU0B/c+yiS/EmYiJHGFTW2RYT4qt1NE8zzzYk52oBJu8MFYAVaeljZxJb
 TKnZgI8O0pEi0NKmgEWwIAdt/8g0vDr8uNuODhgvs7F69bdG4WxiBxYklz2k5BhMR5tq
 jhiw==
X-Gm-Message-State: AOJu0YzaHbNxq2kYGnqmc1Sb8QVMcUFhnQ69K7tGOoLXvOx9Ubt8vgNe
 Pc/P7LjdmusFYXm8RFuKI6euSQspTdtXrX0jcLM6s58Q2XpekTcmyTZB
X-Gm-Gg: AR+sD12RB9d/G9fvwmF7LW2H/10V4pqJMMTKibPZV3WfC8tx0o/hWoHC4OhZ1iFLpaq
 LbQ6tOg3GJl05mrv+N9YFdg7dwk1sZT/9EwwJGX5h4VTognycr0WvLpXddYt45Z/CMZ/KiHI5Kx
 OP0TgY3U3/CMTnerUIZd9S32z/HgHtPABIaqTh1zP2nbnQtD9f+BmiFXvPQ4d2JRr06vccIThJq
 8lsfMB74PCOiVjlcAPKzFRC1Inq8xKs5CUlqO/CRb2x4kJgTggBgBnZmtpbDxb3K7zk03IJOB3X
 jDAepQri1fvfpQzQ7f9KGjq5Scw5OkwSZg37pDNW4RUN3dV9uGsDkHDGKly16btcHJwl0y8OVDs
 SId1wpvEAxxSvvMksydJv8fk0ygIELZqL/YwCumlUu5PjbflCRSL7XKRFSwm1kCWwUXtA3iiAEV
 DC6RRREH+EivG88lcQ5BNSo7kITS8w6JVyTUT0bC6C2EORIlDuiHLzuTtRS5FIz1+jkrjeEEctT
 VFUcoEPi6xwnxBdDJipnt3Tedu9DS9ZSStRSFKRcjQYvHvZfgkgkPiJgx3HyJ7HuZaioObftxhN
 I+1y0nmO9OM=
X-Received: by 2002:a05:620a:270c:b0:92e:7cc9:a888 with SMTP id
 af79cd13be357-93649119b9bmr349263785a.2.1785902995265; 
 Tue, 04 Aug 2026 21:09:55 -0700 (PDT)
Received: from
 runnervmvrwv9.slfmtg5fcnvuxdwlsq1e2o14kh.cx.internal.cloudapp.net
 ([20.161.70.162]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a449d4csm75956585a.20.2026.08.04.21.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 21:09:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Wed,  5 Aug 2026 04:09:54 +0000
Message-ID: <20260805040954.7675-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805025418.1249003-1-wakel@google.com>
References: <20260805025418.1249003-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Use backoff polling to wait for loop device nodes
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

Hi Wake,

On Aug 5, 2026, Wake Liu wrote:
> lib: Use backoff polling to wait for loop device nodes

> +				path_set = TST_RETRY_FN_EXP_BACKOFF(
> +					set_dev_loop_path(rc, path, path_len),
> +					TST_RETVAL_EQ0, 1);

Could the declaration of tst_multiply_timeout() be made available to this
legacy-API library, or could polling avoid this macro? The macro expands to a
call to tst_multiply_timeout(), but test.h does not declare it. GCC reports an
implicit declaration and Clang rejects both new call sites under C99:

> error: call to undeclared function 'tst_multiply_timeout'; ISO C99 and later do not support implicit function declarations

> tst_find_free_loopdev() and tst_attach_device() (starting at 1ms delay,
> doubling each try, capped at 100ms) to wait for the device node to be
> successfully populated.

Could this timing description be corrected or the requested timing be
implemented? TST_RETRY_FN_EXP_BACKOFF(..., 1) starts at one microsecond and
uses one second as its maximum-delay threshold, subject to
tst_multiply_timeout().

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
