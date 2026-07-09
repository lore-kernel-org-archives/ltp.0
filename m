Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B73C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 16:38:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B935F3D8739
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 18:38:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D32443C6F84
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 18:37:57 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 60C921400114
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 18:37:57 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-92e680c3770so71995385a.1
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783615076; x=1784219876; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HaJ5lU8L2THtiRbwNJIIAxGJaiNGREbxN/RaoyYnEic=;
 b=EQX4LOaIkJBznTFJTYF95n0GkvnLIHopeH58Wt70Ui62CfOar2XiIuaAFFYUrFQtIm
 g+0kYXJraqEtDCQsBkwht6xCPHZAgiVJQ9B0ZStbMypvsbkI1TzbxyX0m/G5eDHgZ0YS
 dsOLv8I85Cbpc7V4+0b7j85QDGoYQ1W1eJ62lgVs9V5HwSIwqtJWDb+HRBDYLmwIN2OT
 k/WO0vk6NW/gvvAYTUJG1rwjt2tcjkQsaglWetS89kqM2BThXxRwNQrkvKYDkohAcyvv
 WvglZthgqhrZp+PVB36c7tWkx7PFr359ruIlno7ybkFHeiCmN8SYmTnrj3Yg+jSxFDBx
 pAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783615076; x=1784219876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HaJ5lU8L2THtiRbwNJIIAxGJaiNGREbxN/RaoyYnEic=;
 b=nsJ/SUnkfo0eEBVJfb+GCtKnFqU5YgMk4qGS/uP1lAlmI8gIdfRQ5VNeSS5RApt8Tj
 qEZTSBsRDW1eYs+PoA1l8AyUOKgeU63quau30+fsebXyGSTuoX2qafofPc58YfDbriVV
 WDzdNdlNuKw4pz5FHtVGN+EuR9NA5adXYBDUih/k4Ym6Qqhdr3WrLq2xKCQEX+/ckQft
 E3QAB0yWhJ0V8L+go+pSEoxdtJsJJYCiJllbp5nWj0zBCYdQN0wmxyJetxVDJ9AZKIfJ
 8XlvGF2GHBLwrvbv7uLDM9ZdxsKPKrbawvT9UY1+msc4IweP+/pcqBAygAUWTEg5YkCp
 sukg==
X-Gm-Message-State: AOJu0YxPPsrz78KSESTSnIVUYZgkV0mY/VXVhTA5wKiWT7+26BBFK5h5
 e36h0IVrsLljyZPbUC3Hm7NKcBgILII+GjjRaWYaOc92AG995OWnVsFfRVa2LtYK
X-Gm-Gg: AfdE7cm7UiSIyqeY9RvwFbB7icpY/8ucMY9t65bCVuzt6g3XnRmXscZmjozcwZ79n+w
 vwNpezpIXZUKtBXCnGmEAA+kMZ6V1EsB1sW1i/icFSiRku7fB/sCRD5MGFCMh98dOKOQ/GmT5KT
 oe/rFBVcrA5pXWcazw7bW1nrnYOxuKcAG8kNn0Nf4schh5sFI1PBsT7xksKBQPGDggtqhGUBRY8
 Aqi6J/cefCYaiYWcQctY/0mGw4o2vG/AX97nP9POPflxvg4NYGQDHPbmVHn/oIfRYkVh/W5y1Ko
 fDGi3LFJI58qVgIuSXvrARei++p6twfFHVsQIo+3/dkClqlG847Vpxdbw44mtds4bkJmXYLSBvc
 6187Iq4bhj9XjagTvzIvrBQPbsQb8T7abcJFVzK+HsYxED4Qk2AO25pO3GMOKGde6M4mTI3VTAs
 HrtRbudeoMoZE5KDanE2/CIYaCzYFjwp/rtBJDaIM8G40YFukPe21GAg9S+/wxJG/8qZ04VCWRX
 cV5n21ExFgw1Q+TJ7HGVd5RWOYe
X-Received: by 2002:a05:620a:4014:b0:92b:6805:917a with SMTP id
 af79cd13be357-92ecf8ea675mr857466585a.66.1783615075890; 
 Thu, 09 Jul 2026 09:37:55 -0700 (PDT)
Received: from
 runnervm5mmn9.1vi0t330zhkepje5rbhct212od.ex.internal.cloudapp.net
 ([135.232.200.8]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90d0011fsm1763449885a.45.2026.07.09.09.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 09:37:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Thu,  9 Jul 2026 16:37:54 +0000
Message-ID: <20260709163754.4041-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709143551.147268-1-japo@linux.ibm.com>
References: <20260709143551.147268-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Add ptrace mode and fix tracee stop synchronization
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

On July 09, 2026, Jan Polensky wrote:
> thp04: Add ptrace mode and fix tracee stop synchronization

> +	effective_mode = user_mode;
> +
> +	/* Probe direct /proc/self/mem writes only if not explicitly set to ptrace */
> +	if (!explicit_mode || user_mode == PROC_MEM_ALWAYS) {
> +		...
> +		effective_mode = PROC_MEM_PTRACE;
> +	}
> +
> +	/* Ptrace mode: tracee will be spawned in run() for each iteration */
> +	if (effective_mode == PROC_MEM_PTRACE)
> +		return;
> +
> +	tst_brk(TCONF, "Writes to /proc/self/mem disabled in kernel policy");

The final tst_brk() appears unreachable. Every code path through setup()
either returns or calls tst_brk() before reaching this line:

- Probe succeeds (PROC_MEM_ALWAYS path): early return inside the block.
- Probe fails with non-EIO: tst_brk(TBROK) inside the block.
- Probe fails with EIO and explicit_mode && user_mode==PROC_MEM_ALWAYS:
  tst_brk(TCONF) inside the block.
- Probe fails with EIO otherwise: effective_mode is set to PROC_MEM_PTRACE
  inside the block, then the "if (PROC_MEM_PTRACE) return" fires.
- Explicit ptrace mode (block skipped): effective_mode==PROC_MEM_PTRACE
  was set before the block, so "if (PROC_MEM_PTRACE) return" fires.
- Explicit never mode: tst_brk(TCONF, "...on kernel cmdline") fires
  inside the params[0].found block; execution does not continue.

Is there a case this was intended to handle that is now missing?

> +	for (i = 0; i < PTRACE_TEST_ITERATIONS; i++) {
> +		...
> +		/* Wait for tracee to stop itself with raise(SIGSTOP) */
> +		SAFE_WAITPID(tracee_pid, &status, 0);
> +
> +		if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGSTOP)
> +			tst_brk(TBROK, "Tracee did not stop with SIGSTOP: %s",
> +				tst_strstatus(status));
> +	}

When the tracee detects page pollution it calls:
  tst_res(TFAIL, "Huge zero page was polluted");
  child_cleanup();
  exit(1);

The SAFE_WAITPID above then returns with WIFEXITED(status)=true, which
triggers tst_brk(TBROK, "Tracee did not stop with SIGSTOP: exited, status=1").

The test output becomes:
  TFAIL: Huge zero page was polluted
  TBROK: Tracee did not stop with SIGSTOP: exited, status=1

The TFAIL is propagated correctly via the LTP result mechanism.
However, the TBROK message "Tracee did not stop with SIGSTOP" describes
an infrastructure anomaly rather than the actual failure (page pollution).
Would it be clearer to check WIFEXITED explicitly and omit the TBROK when
the tracee has already reported a result?

Verdict - Needs revision

Pre-existing issues:

thread_run_always(), line visible in context (unchanged from original):
  /* Wait for dirty page handling before next madvise() */
  usleep(10);
This is sleep-based synchronization. It was present before this patch and
is not introduced here, but worth noting for a follow-up cleanup.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
