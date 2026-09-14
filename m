Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792AEC88E73
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 17:59:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B60A3EB195
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 19:59:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E9543E9112
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 19:58:47 +0200 (CEST)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19EF6200210
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 19:58:47 +0200 (CEST)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso2478757a91.1
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789408725; x=1790013525; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j72SYU+Vzk+66AnRauMswdsQ94nsPerkxbbJCOioTE0=;
 b=qvTyt5p9cX1fyyYW3m3RnhFt7iXl0KsedQqtxy/wvXqmgi2LAI/Sk5SFFP1f1dX5nc
 4qnN2f9UwKckacfCJB8r+B1KRFhW29SBdwJMM1yGv1ipB6NdGxZmZDka5rK+JO/YaeGn
 Qvg/jhHnWhgehdjXaLVmK+4186ABqgYZLqp7tGGyytNP/ZbXL/aZk6hdcoS4dTDxDJqZ
 xKHszZgx0MDHTrYvFrx6ha80cyt4C9quWbzZyqHkjJSWRmmIu/gTYqpjhwRBjESD45P/
 Qj3p9Zi3zLZol77/CrOXE4NN/zzZl3I1oW22R6Ob66f8Fd3OIvIbWSfPu34jo1NR2o1n
 OTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789408725; x=1790013525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j72SYU+Vzk+66AnRauMswdsQ94nsPerkxbbJCOioTE0=;
 b=AAwpCIs3mEbvZlTKeK06PLuq4lG0iHE9hWQXZzVep5HUcaodIsSAzBvG51i73AoLLx
 S5F8S+0kyF5pnh3G0jlxLqT3v9bsmFBtYn3QMFGXAjfOuiIOSvp3LQAr+IZ0juZs9g/S
 BS8jEqYiAtFIE0nEF2SUkzi8HBDfqw5LbY5nBZTWlf1lLWZ0ZXlvKq7j+JV+C1GAKsF1
 58lNC1HPxQn/EWBDsxv1ddhaf7PtUYET3xy3wlzaLtPYsOFGrbT4z3LP8z9307S0P1/b
 uGRsw4pBfs3Y54YtdnjUqH/C1MRsfd9jzd8oXTb4HYsJsgomDUaElVdwJsSpAmyUAhHo
 rhzQ==
X-Gm-Message-State: AFuF++lQc+S+t9dUMTxCK6e1sbN4esniLXyQatlVWe+MBZ+mavysuztV
 DPlhmtsRQAM0xHn1ULlXG5hmYKlgX+SRD1mkVgCUIdfgTg61g+ZEccjc
X-Gm-Gg: AYBFou2DeM3me1w9jl9/nSQeq/nMaHQrwWmzwiqPo5E7vbF8wQC3iKJuuawl59dE8TS
 Bnmob8V6Mlttz9yfcbw/v4bdujCjaJUgR1dlM9TisAvGIT5674/Tad/oQTfiKVXuOGo/esZcmr0
 RPdHUKaaqNKj2TChSbuN0xzzkqqKJyVkt/8a1VtoRJtsMhT4CUE/bOyt/z7P1ri0u6IYSajumfR
 aZgC3GunSP1zL+w8RZr1XN4yqBwOo+uJX2FCxnFao1tNKb53jrc148cPtAL7YyhcJ7HAzQdPXGq
 kFGUVlpEUjb8lJGnoAK3u97G4C+G4hrQ79HxDUXubroT7RPhuDYpdaRlA2pWj/MF/AakGMCy84H
 MqfeBs1IaKMyE5I45jXb3koSxOfnzhbw2meCuEl9xSE9fO7oTSkhqju2r5a0RkHN7TrbQwpJgGg
 fuaaTf5ku17WDDM3x0rwopwm7hpKHYdw91NNa/41abZlE5h1K3rjXgvB1YAMJyZoHfs/ODERMvA
 d5HwhboubfTWjFpDfljw6CRt3jQdV+b5dHTje+DNUtYZdmUeIq+q/jX7586gwLsOJoM8yDyCyTc
 58F8hmkrZQ==
X-Received: by 2002:a17:90b:2ccb:b0:39d:f61d:4b93 with SMTP id
 98e67ed59e1d1-39df61d57bamr4568076a91.13.1789408725110; 
 Mon, 14 Sep 2026 10:58:45 -0700 (PDT)
Received: from
 runnervmlun5p.ihj0oszxugiulclku2pphprrxc.phxx.internal.cloudapp.net
 ([57.154.4.41]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b759d0sm27736245c88.7.2026.09.14.10.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:58:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Mon, 14 Sep 2026 17:58:43 +0000
Message-ID: <20260914175843.9886-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914115838.202410-2-japo@linux.ibm.com>
References: <20260914115838.202410-2-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: group runtime state and skip when /proc/self/mem
 writes are blocked
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

On Mon Sep 14 13:58:33 2026 +0200, Jan Polensky wrote:
> thp04: group runtime state and skip when /proc/self/mem writes are blocked

--- [PATCH 1/3] ---

> Move thp04 runtime state from static globals into a heap-allocated
> struct thp_state. Group write_thp, read_thp, write_ptr, read_ptr,
> thp_size, writefd, readfd and fzsync_pair in one object instead of
> spreading them across file-scope variables.
> 
> Also add a real /proc/self/mem write probe in setup(). If the write
> fails with EIO, report TCONF and skip the test cleanly on kernels where
> CONFIG_PROC_MEM_FORCE_PTRACE or CONFIG_PROC_MEM_NO_FORCE blocks
> unforced /proc/self/mem self-writes.

This commit mixes two unrelated logical changes: refactoring file-scope
globals into struct thp_state, and adding a /proc/self/mem probe to skip with
TCONF. Please split this into two separate patches. Additionally, the commit
message states that struct thp_state is heap-allocated, but the
implementation uses SAFE_MMAP().

> +	state = SAFE_MMAP(NULL, sizeof(*state), PROT_READ | PROT_WRITE,
> +		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

Dynamic memory mapping for test state is unnecessary because thread B shares
the address space with thread A. Keep state in static variables instead.

--- [PATCH 2/3] ---

> +	SAFE_LSEEK(memfd, (off_t)test_ptr, SEEK_SET);
> +	TEST(write(memfd, &test_val, sizeof(test_val)));
> +
> +	if (TST_RET == -1 && TST_ERR == EIO) {
> +		tst_res(TPASS,
> +			"Write to /proc/self/mem correctly rejected with EIO");
> +		return;
> +	}
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TERRNO,
> +			"Write to /proc/self/mem failed with unexpected error");
> +		return;
> +	}
> +
> +	if (TST_RET == (ssize_t)sizeof(test_val)) {
> +		tst_res(TCONF,
> +			"Write to /proc/self/mem succeeded - CONFIG_PROC_MEM_FORCE_PTRACE not enforcing ptrace checks");
> +		return;
> +	}

Use TST_EXP_FAIL2(write(memfd, &test_val, sizeof(test_val)), EIO) instead of
manual TEST() with if/else reporting. When CONFIG_PROC_MEM_FORCE_PTRACE=y is
enforced via .needs_kconfigs, a successful write is a kernel failure that must
be reported as TFAIL, not TCONF.

> +	tst_res(TFAIL,
> +		"Short write to /proc/self/mem: %zd bytes (expected %zu or -1)",
> +		TST_RET, sizeof(test_val));

TST_RET has type long; use %ld instead of %zd.

--- [PATCH 3/3] ---

> +static void run(void)
> +{
> +	char path[PATH_MAX];
> +	int memfd;
...
> +	snprintf(path, sizeof(path), "/proc/%d/mem", tracee_pid);
> +	memfd = SAFE_OPEN(path, O_RDWR);

memfd is declared locally in run() and is not closed in cleanup(). Move memfd
to file scope initialized to -1, and close it in cleanup() with a memfd != -1
guard so it is released if run() aborts early.

> +		if (TST_RET == -1 && TST_ERR == EIO) {
> +			SAFE_CLOSE(memfd);
> +			SAFE_PTRACE(PTRACE_DETACH, tracee_pid, NULL, NULL);
> +			SAFE_KILL(tracee_pid, SIGTERM);
> +			tst_reap_children();
> +			tracee_pid = 0;
> +			tst_brk(TCONF,
> +				"Write to /proc/pid/mem failed with EIO - proc_mem.force_override=never disables FOLL_FORCE");
> +		}

Do not report TCONF on EIO without checking /proc/cmdline for
proc_mem.force_override=never. When CONFIG_PROC_MEM_FORCE_PTRACE=y is active,
an EIO under ptrace is a kernel failure that should be reported as TFAIL.

> +			if (WEXITSTATUS(status) != 0) {
> +				return;
> +			}
> +
> +			if (i == TEST_ITERATIONS - 1) {
> +				tst_res(TPASS,
> +					"Successfully wrote to tracee memory via"
> +					" /proc/pid/mem for %d iterations",
> +					TEST_ITERATIONS);
> +				return;
> +			}

Remove braces from the single-statement if body, and do not split the quoted
string literal across lines.

> + * Test flow:
> + *
> + * 1. Parent forks a child process
> + * 2. Child signals readiness via checkpoint and issues raise(SIGSTOP)

Use the literal [Algorithm] header followed by a hyphen-bulleted list (-)
instead of Test flow:.

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
