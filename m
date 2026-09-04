Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5240C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:21:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E31A3E9373
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:21:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C7263E5507
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:20:52 +0200 (CEST)
Received: from mail-qk2-x06.google.com (mail-qk2-x06.google.com
 [IPv6:2607:f8b0:4864:34::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B1A481000F39
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:20:51 +0200 (CEST)
Received: by mail-qk2-x06.google.com with SMTP id
 d75a77b69052e-52fa263dd47so4441381cf.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788510050; x=1789114850; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=afwpgcpvNOBcaSfGy73ljA3UJ4edzobwU4lrHxAXi+Y=;
 b=I7CV2hSIbdAvYtQTg28BS/IyoNGUmgiwnLrhF4UfNS8ThU+04kDyfLnnuqiyeoH1vx
 kY6ZzhnqMN8CVIZqO+jyIfFzTXknhLZH7sY3tkETixdBGSp+1YNDEddLrknNMVqVCOrT
 slZMlthjrpx75f46xBYHLe6knJsJBZcF92y4dEW+L861KEaPNRz0tAEzOUmjOzkrDjM8
 Jy2yMyGoXBcJFHspl9/yck1NUsfu0CviClkC9wFa6o46CCCl8VaupEu1X2NY4eL/W/w8
 OA4YBPVWWwVOm8OAuqYzyx4pjD/TQblwebGrU2jxvlbYbXwmvZcvHhs0GrlvRfSgsvs6
 QhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788510050; x=1789114850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=afwpgcpvNOBcaSfGy73ljA3UJ4edzobwU4lrHxAXi+Y=;
 b=IlTTqKsd34LUR4Kfu2aRuC+xyjgoXuJ1yKmLn/U9MJNZHOs1lZroIJhxc5UGuu2Xcv
 EjX/Fq0L3yzIAm15kgwnMlO8YRXj2YQAKmto++wjiaLAVy7P8FxVA8idz7bezQs4IRVk
 ayjSCoa+hh8ZGVxqtqRZ2KeSle9xYrY4eoJ+ZYhRhrXl04fzmq/DVzs3UG71IRvkgs6x
 cZoE9QWU/Y37S2soVVrwu8tmQWinMmUnw2r2F+hiqc5me0eYfA2KhfSffIrZnTm14/zA
 AUPNjgDoPcaGR2NK55fV84wC0rApFbPG5oXheGU/aRTFxjk/W4Jh7mPKLZjPQB6Nr7Vy
 y+EA==
X-Gm-Message-State: AFuF++kg6ROfwdrdpNeioHtCSZTxhMa3gN7DzwtMN9iAb4NNShmInkID
 RXLZ22xCF6KBSpR468KefXH2zUNGlQiFf95caLwyC4W+BoQ0npRIDGLg
X-Gm-Gg: AYBFou1j6flwPfS3UK7RVf/0Qoq42HtDta6ReL5+tMk8W/SgHpAMjp0rcPsPZctAgD9
 P5WHhA+yp8hRDaSiRYgxGI40QuXI7ebYDZWPiio0ma2Q3+MpUFWGJqxLRTCDrNyHaALSZ/XruJk
 LNzAjFg1SQlr4uaadgqiFK9nyUt7IWO/jfpaV4i+BthVGG5RHWgq1z5JTr0eVm6xQaYWKFcGgr7
 FZqyahEBRS0WuoE/TJd8FB2AseITw6l2+oTpewDniyfDuRkIZbU/qq946ONrhvd648lPU9ETzsQ
 lt1N5CuEyStdk9eb7e8R24CIwJJ8SxcscQIzxpZKIOMwBZTxhKSvOyLlFkxdxmHi9oRbSuFpIxY
 cIJsa1f/fVFVCy2eOd2/vpivfgkttKQodgIJhwHEwxztjEDi2VvimRDKWFZUvnbhAGLL5Lb28yC
 Sg6eFgSClo51eBvb27ABIlgZlAVmu4F1UOHjHYyniozmCXfSuiE9b/92sDSpCFNOMt9wGjpUgyq
 1FGiLLmj3XQB7VTOBPsDaZOOqe5fWIvmdH7f854sHi1B4VdDHml54AIOJeBoT2F/LS1i4/0FyEG
X-Received: by 2002:ac8:570f:0:b0:530:3526:9ad4 with SMTP id
 d75a77b69052e-53054944a04mr44707331cf.27.1788510050315; 
 Fri, 04 Sep 2026 01:20:50 -0700 (PDT)
Received: from
 runnervmejwal.nux2vxulkvkenpsq1ny34siynf.bx.internal.cloudapp.net
 ([20.119.103.59]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054180b8fsm15163861cf.17.2026.09.04.01.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:20:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  4 Sep 2026 08:20:49 +0000
Message-ID: <20260904082049.8988-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-cve-ghostlock-v8-1-bd999083c7fb@suse.com>
References: <20260904-cve-ghostlock-v8-1-bd999083c7fb@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_setattr01: Convert to new API
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

Hi Andrea,

On Sep 4, 2026, Andrea Cervesato wrote:
> sched_setattr01: Convert to new API

--- [PATCH 1/5] ---

> Rewrite the test to use the modern LTP API (tst_test.h) with a
> struct tcase array and TST_EXP_* macros.

The body only restates how the test was converted. Please explain why the
conversion is needed.

--- [PATCH 2/5] ---

> Rewrite the test to use the modern LTP API (tst_test.h) with
> TST_EXP_* macros and cleanup callback.

The body only restates how the test was converted. Please explain why the
conversion is needed.

--- [PATCH 3/5] ---

> Add a safe variant of sched_setattr() that breaks the test with TBROK
> on failure and use it in sched_setattr01 and sched_getattr01.

The body describes the wrapper and its callers, but not why the shared
wrapper is needed. Please add the motivation.

> +	if (ret == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"sched_setattr(%i) failed", pid);
> +	}

This body contains one statement. Please remove the braces as required by
LTP C style.

--- [PATCH 5/5] ---

> +	TST_CHECKPOINT_WAKE(CP_SPRAYED);
> +
> +	while (!tst_atomic_load(&stop_spray)) {
> +		prctl(PR_SET_MM, PR_SET_MM_MAP, (unsigned long)&mm_map,
> +		      sizeof(mm_map), 0);
> +	}

> +	TST_CHECKPOINT_WAIT2(CP_SPRAYED, 18000);
> +
> +	SAFE_SCHED_SETATTR(waiter_tid, &attr, 0);

CP_SPRAYED is signaled before the waiter enters PR_SET_MM_MAP, so nothing
ensures that sched_setattr() overlaps the controlled kernel-stack buffer.
Use the PoC's page-boundary and hole-punch mechanism, or an equivalent
mechanism that guarantees a usable overlap; otherwise a vulnerable kernel
can complete all attempts and incorrectly report TPASS.

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
