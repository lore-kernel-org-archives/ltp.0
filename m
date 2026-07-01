Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DF7C43602
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 12:28:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A4FD3E9B5A
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 14:28:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C5AF3E4AB4
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 14:28:28 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 90EAC10000F2
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 14:28:28 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8f0f56c2dc9so1191926d6.0
 for <ltp@lists.linux.it>; Wed, 01 Jul 2026 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782908907; x=1783513707; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MAXGM8offK+WPFH5EtDFpsikycy/cYFOcrhI7bVafo=;
 b=qlK8LkoJYcwAcA5w4vuOU4kKvo1zGVxpHixEfCSt3+4AWI+KkwZbdq1YzFTovgPTzP
 09fedtkqcNUKckEupcoGnAg4PLAbkEx9qi4Cb1t01PZxJ8sgPzK+WLDpMvTSi16GR7Wx
 75Do2M41NsQp2w8ZHflHeMKVLK7KhfulO12RqCNrcjXI3+ELOqn1FdOjWuZtJL9jinSy
 mV7JEOuKOrumY6tdglBj9+czo6gJOEyAPnqPqYPDLIvbZlEEMZ/kPt+PYRHg5mw84bYk
 Jup8x5rQ1e7L+l4TNgb9v7uIOcZdNBw5IlAdpAUskJglynizSI8zbYwbVqtNJKjnSF0n
 8RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782908907; x=1783513707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2MAXGM8offK+WPFH5EtDFpsikycy/cYFOcrhI7bVafo=;
 b=C47SB3KTB3yMeKkSNCtb/LzATVdkv+hyYk6ASQzkKf/dwr9nAdBKI0WF0XGbsmA+SH
 ss6YCUNTsNxLEekjBERP1hCTCpdE8mZR2etsZ+OJtIN24zJpHugX/3Pq1qZxBUwPsG4q
 n3cjH6+q0SMexDCOujCVS4yXJFj8fIlg0TPuh3cwuq8BkGBuTkxMHnWDR5ZSdyAjBW+f
 JPxKMR7d25FjYsSfuH6iMi31HwT/tqu+tl4gqQsJkMeg5hszJgaRQLQJEMoocoj1QdXG
 xJqK1GtAYjnkRncg4i8EX5a3JBwzWCa69m2vuFZO54EdUECIlTBWM6NaCylENly2VZ2T
 MArA==
X-Gm-Message-State: AOJu0Yyvve2jMD0hldQ5W8DF1zCDw9RxOb3WmcajsBfSYXcE2WUvzO1X
 qvqVcm7ouKrgLZsgGRdhnVvCa6lKpDeKfXjKDUJgApu0sGlZmmPqNYpo
X-Gm-Gg: AfdE7cksuReCoDv0DzyWlsOzuqLBB1cBjDB0+J1huyyBnzOEtkNwAwjd9H1BdVH02Mc
 0PqZSH6oQS94rae3Vf2RJRFKuL7bnUIME4q8fhaagDFERfukbjkHvHxjmkEb20IC5n+qaXdKBXq
 zpSjDnJdhxx98mwynoF1owvnoN6o71aWryMUGDI4CA5mY50/as6MVaTVKZaLMUqHkTMDB1tctdR
 lEVVqKpNTYqIAs5gZDRxhJB3Otp0z2d3rtGq8BmOGKFFWhAyAPV6N0MvtelXkfoF5fhDvPpBxvJ
 hrv0+pxPHjHITKrtb+WDoGzRxsSdxDM45Tx4M9lXHXvhpuqzpdKOmVnfxJK318Dkxm4VyBrTrV3
 iS9UaWtaXsyMIVJLfF6nSr2X15a5k2u3p43RgUd+FjZVoYER7X/onptlG2c6ngxIAwyBqR3nOQg
 n1HX3qcqhqOu7vQJDOoHo6TNUXoCG0dTY0y+hWfwPACHfiXH6bJHWESWUwQgS+pRayCuy1dwud+
 0wuVz1pRr5Nk2qAxcqkD57bkJ8=
X-Received: by 2002:a0c:e704:0:b0:8ee:f81e:7927 with SMTP id
 6a1803df08f44-8f3c99ba153mr12470916d6.48.1782908907108; 
 Wed, 01 Jul 2026 05:28:27 -0700 (PDT)
Received: from
 runnervmmklqx.dcmqfzuzjfdufk2kvuezc4hldb.bx.internal.cloudapp.net
 ([51.8.121.165]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f35e887af3sm20536056d6.4.2026.07.01.05.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:28:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Wed,  1 Jul 2026 12:28:26 +0000
Message-ID: <20260701122826.4115-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111242.97520-1-japo@linux.ibm.com>
References: <20260701111242.97520-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Fix PTRACE mode for CONFIG_PROC_MEM_FORCE_PTRACE=y
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

Hi Jan,

On Wed, Jul 1, 2026 at 13:12:38 +0200, Jan Polensky wrote:
> thp04: Fix PTRACE mode for CONFIG_PROC_MEM_FORCE_PTRACE=y

> -#include "lapi/mmap.h"
> +#include "tst_checkpoint.h"
>  #include "tst_fuzzy_sync.h"
> +#include "tst_kconfig.h"
> +#include "tst_test.h"

The patch drops lapi/mmap.h but the test still uses MADV_HUGEPAGE (in
alloc_zero_page) and MADV_DONTNEED (multiple call sites). The fallback
defines for these constants live in lapi/mmap.h. On toolchains where
<sys/mman.h> does not provide them, this will fail to compile.

> +static void run_proc_mem_ptrace_race(void)
> +{
> +	/* After 1000 iterations, let tracee exit cleanly */
> +	SAFE_PTRACE(PTRACE_CONT, tracee_pid, NULL, NULL);
> +	SAFE_WAITPID(tracee_pid, &status, 0);

After run_proc_mem_ptrace_race() returns, the tracee has been reaped.
If the framework re-invokes run() (e.g. via -i 2), the next call to
SAFE_OPEN("/proc/<pid>/mem") will hit ENOENT and abort with TBROK.

The PROC_MEM_ALWAYS path survives re-invocation because
tst_fzsync_run_a() returns false immediately when runtime expires. The
ptrace path could either re-spawn the tracee in run(), or guard with
an early return when tracee_pid is no longer alive.

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
