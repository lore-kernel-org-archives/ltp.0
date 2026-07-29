Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65225C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 05:52:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E336F3E4ADC
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 07:52:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1139E3E171C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:52:38 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA2CF20077D
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:52:36 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cabfb70501so1903495ad.1
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785304355; x=1785909155; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VmItY4XhkbSLQhS4DHsuYQLaz1wXsi/rhsDa/Jp3WaU=;
 b=AFNd+2dyV2g6POJpB5PiQmOiNFFGmrFMbmrbQgI2yj/vdZlo2+v1AU9QE2CdP7J3qz
 9sTZi6EtRszUYtMqTeP1d50nRqZUXbju1sfIZq/nxbFfnSxOAaeCFGuYHaFKr9iReITU
 qA2c5oJFnlVXfQ8YOkWMWzwT52yi9CxdLz/9LWtjvUZ9O5V6Vu34DUjzJqNTGTQbCSPp
 97yr3x0LYVfc0rpz6VcK8OzA7YV45fnegzcXhROA+qACNvZHfPpiXxmKRXRRWfUUePkc
 jWvMxoIo9hmVHF6NyRFcxFK3Fx5vUYGkHZN9BEYZMp0jam10iFktfIynLo7ZV3TwSiZD
 J+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785304355; x=1785909155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VmItY4XhkbSLQhS4DHsuYQLaz1wXsi/rhsDa/Jp3WaU=;
 b=TeltGZMJM5XZz17aOoCl+gAlGaWHMhZagpyVljByaysKat90/b6map+hxrDdAV03tG
 Q43Z18r5+ISZFX11u0E2A7EOA6T/VTMCULkXSfHpAa8XaxwE0cXbfKlHKUGvaX+x6Uqz
 vnc7vwnHX17W3MdfTqfYMGzGqs6qdrIyarPIyub9qVydMbOY6TMPkJe5Z4DbIfVcF+wB
 iyaJ1tO4eNY2TT2r1fYuJFbH+86GFJG6xS45+/Z8+u8BHAChTk+vtUXWhluDuzH1Q9Qz
 kOs1P0IF9NkNHwQQUHWtmJHcruEDbkpqVZ1r002hMvRnV1x4CeL2k6xSYd7a9XoNYgvQ
 9XQg==
X-Gm-Message-State: AOJu0YziUTBhFjv1U85wnQNPL+uJNY5kfSkqisMam2nO863ZOWo4EkW9
 w7hqm0s/+Amczy/x82Xynb/l9cy45RswrXHsftIr+M6rI7CG/AX0QekZ
X-Gm-Gg: AR+sD13bHTeM1lciBhYQOm4vA6ynZ3giQQEQplyE8Bxg7EiEvL8Hs3EVWXVcfZiAnLz
 NySdHKNA3x+6V2jn/0qyXbszAk5LrARi2bbHJY2EjlalqDZGA7OKLX0sfblbj+9YuFyJgiR7m5C
 a5yNcqLQZlxeqZzX2WNWHccYCW9Mxd2HYNGydzhNVhfU6LNuxa5YFhyRXRXXTpN0dBcHd2sib2O
 9WSyFcfNoLftyld5lCZYezd/56TJUkXevcnuJqfrv+RgK7oOtDR+x2Sm1YgOCgy4oMS9sNixoxY
 mZzcHZRExwcO5mG8inn2p2jcSKq/2b8aoq+Ax5B8eRFJcTUOnpXwoNu1TiRp3pH3UwPtSCRF9/Q
 xwirSKfrarlQcxB3nleXp76HcfHGYAt+GVQYdMbl8G9m7X63K6vIEpjeGYAl3ykyCliR9IzZGa4
 yZXr1eUEIqr9tP1NGQ5N57kvQWZbKtYi3OuM1VEQzDpKhbt6lHsrw3+xP6yKG5qqffTX/5ZXhfV
 CynfqTpT9zGk9YKsxxASLqB1iYJYBOrsAgmJ+I41gDfKHmPNgvjVp/6FGZWzC3JpusZlxDTRLIX
 vg==
X-Received: by 2002:a05:6a20:258f:b0:3c0:ac0f:6558 with SMTP id
 adf61e73a8af0-3c8aafa00e1mr5914851637.2.1785304354787; 
 Tue, 28 Jul 2026 22:52:34 -0700 (PDT)
Received: from
 runnervmvrwv9.ul30hyp0irqepaj0su5chck4eg.yx.internal.cloudapp.net
 ([172.215.217.98]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504e1ff81sm5973388eec.31.2026.07.28.22.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 22:52:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 29 Jul 2026 05:52:33 +0000
Message-ID: <20260729055233.8636-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729053803.9823-1-wegao@suse.com>
References: <20260729053803.9823-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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

Hi Wei,

On Wed, 29 Jul 2026, Wei Gao wrote:
> min_free_kbytes: Handle transient memory drops in check_monitor

> Implement a 2-second grace period with high-accuracy 10ms fixed polling
> in check_monitor() to allow the kernel time to reclaim memory.
>
> Introduce a 10% tolerance (90% threshold) for the MemFree check.

These are two independent changes, and the second one is much more
invasive than the first. Could they be split into separate patches?

The idle poll interval change and the diagnostics are two more logical
changes in the same commit. Splitting them would let the tolerance be
discussed (or reverted) on its own.

> +		threshold = tune * 9 / 10;

> +			if (memfree < threshold) {
> +				tst_res(TFAIL, "MemFree %lu kB < 90%% of min_free_kbytes %lu kB (MinSeen: %lu%%) after 2s",
> +					memfree, tune, (min_memfree * 100 / tune));
> +				violated = 1;
> +			} else if (memfree < tune) {
> +				tst_res(TINFO, "MemFree (%lu kB) stayed within 10%% tolerance (min %lu%%) after ~2s",
> +					memfree, (min_memfree * 100 / tune));

With this, a kernel that steadily keeps MemFree at, say, 0.95 *
min_free_kbytes forever never fails: the loop runs its full 2s, the
value is above threshold, only TINFO is printed and the test ends with
TPASS.

Isn't that the exact regression this test exists to catch? The kernel
contract is MemFree >= min_free_kbytes, and the tolerance turns a
permanent violation into an informational message.

The 2s grace period already covers the transient case described in the
commit message. What does the tolerance add on top of it that the grace
period does not?

If the concern is the slow recovery tail, would extending the grace
period (or retrying with a longer budget) be preferable to lowering the
watermark the test enforces?

> -		sleep(2);
> +		usleep(100000);

The commit message says this improves "responsiveness". What does the
monitor gain from it?

Sampling 10x more often finds more transient dips, which is what the
grace period and the tolerance in this same patch are trying to
suppress. The two changes seem to pull in opposite directions.

It also makes the child read /proc/meminfo and the min_free_kbytes
sysctl 20 times per second while the parent is deliberately driving the
machine into memory pressure, so the monitor adds load to what it is
measuring.

> +			for (i = 10; i <= 2000; i += 10) {
> +				usleep(10000);
> +				memfree = SAFE_READ_MEMINFO("MemFree:");

The loop does not look at "end". min_free_kbytes_test() sends SIGUSR1
right after test_tune() returns, so if the signal lands while this loop
is running the child keeps sampling for up to 2s more and can report
TFAIL for a sample taken after the workload has already finished.

Would adding "end" to the loop condition avoid reporting on the
post-test tail?

Also, c-tests rule 4 asks for exponential-backoff polling rather than a
fixed usleep() interval, and TST_RETRY_FN_EXP_BACKOFF() in
include/tst_common.h implements it. Fixed 10ms is what makes the
"recovered after %d ms" number meaningful, so this may be a deliberate
trade-off worth stating in a comment.

> +					memfree, tune, (min_memfree * 100 / tune));

min_memfree * 100 overflows a 32-bit unsigned long above roughly 41 GB
of free memory. The test still carries a TST_ABI32 branch, so 32-bit is
in scope. 100 * (min_memfree / tune) or a 64-bit intermediate would
avoid it.

>  * Since the tune is not too large or too little, which will
>  * lead to the system hang, the following cases are tested
>  * on all ``overcommit_memory`` policy, at the same time, compare
>  * the current free memory with the tunable value repeatedly.

The high-level description still says the free memory is compared with
the tunable value. After this patch that is no longer what happens.
Could this block be updated to mention the grace period and, if it
stays, the tolerance?

Verdict - Needs revision

Pre-existing issues, not introduced by this patch:

- "volatile int end;" is a non-static global; it could be static.
- eatup_mem() mmaps until failure and never munmaps. The child exits
  immediately after, so this is not a real leak.
- checkpatch reports pre-existing warnings on lines 36, 104 and 126.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
