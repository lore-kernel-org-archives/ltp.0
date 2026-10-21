Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CE606A31A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tMuyO93C
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F4EC3CFC4D
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 15:39:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B2083CADC6
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 15:39:34 +0200 (CEST)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 847F760098E
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 15:39:34 +0200 (CEST)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-3663e04e9a8so862277eec.0
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792589973; x=1793194773; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f07hnazYd48Fku1nTtYKAnBEh8Qdbp/kH9D9aGj04zM=;
 b=tMuyO93CTdmJ091hL8VJTAbR7KdhOMFxwSz70hhCIEVwcb+C1zZr6CugCsUNKEWsrB
 7SYbPwJTN8RxkjFP6SdFKSj5dNFD8AtCcbhyy6cx1WXi8BGacJnWWg/JKGIriwzIJRrb
 07xtkWWhnLfTHv4JfTANKxiIcM9Nsp3GlQ0sTYQoi1yh0obu+IgIPLyCpdrWebWj8NEb
 kPAnbDnn3F5v5QpxdpY18BTj3l8V+vrGK1/8jLA0VkzlSYm+BMKktGXaK49CuMhuuIt1
 99zlIC0I5A1KAv596gImQNdNWgbANzV25UDhBgb+0eglfysP+hdzBAYAjRumAgJOC0bP
 5bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792589973; x=1793194773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f07hnazYd48Fku1nTtYKAnBEh8Qdbp/kH9D9aGj04zM=;
 b=Y6FBPwfllW46ZSJYy7ZbQdkuenoAQBThWewQOFc3FiNQeLcGxduFqe/27uG+Z8EEbo
 OjWXc97hmXpgobok/exdW4+KGm8Lf+kky9bN+EGuXtjweDYWFLF1mMBrJhH/GlIi0264
 lKCF/Dv1jLGmjvS6DSR3L49I6XnlTLp6RqpST2aZUC/8UTZwQsQTjUQgGosylczZyy94
 2ZbSCOhX9VwfkSfoDZ+3DiqESPYd8pjkkUcche0ofXdEi2Efo8sroM5QzovbEZhxL/ko
 2wamUDMfdQoEGn8fzoVHq9a2AWXIpH+wuNyw3VSDyIrZibNfecSahnEkmxy7jkYso6Pi
 0vMA==
X-Gm-Message-State: AFq9FYLH7fuDiuqpDfy80JlimK1V0bO7vWH0/EVDfUXFUL6Ab4nzMnES
 LwqUc3h7mGzlG+NHQslqjhNlJiF3lVgrX/VutRItjKGcNsT7WhUuqPCT
X-Gm-Gg: AYBFou2rW3LyOHzNwv3CESTSBJrNM99AyolCj5Vo93AKq6oVFojw0+KkQKKjl+bQoiP
 r0fN4Uq71RvI5c1v0MojetvZLKp+YPP7btAzcbbpLLLnZbyVUsA5zObNbkO6WL1hgS6+x4YwQts
 VOaZYRTEQ8tukQc7BVPWF5d53FACK/0AS0kWoNLUVnDhkKXDZvuMhq2C6TXYS6H8tphQ9J3Z+/1
 Dv+wq+FY2kCwwiJoTkbxp1P49BpmkkvAr5pCEwZckkA1gxrpXcc17JQliieKHErN61XG5uj26dC
 JpJyeW1JJUHfKOCL1FIUsr/wUtYePf6INa8tctPvpfn7wjVSWPuSeR6CFY7qlrlCXVAW+kwJUx9
 p5iebD6VD9qzLiF/zWC1b3+VAV2B5pR5h+OpS/gKidIESePQ3ub7jfWVi2Yd3HCvOcy/0lVsVnd
 MrVbXQJlHGsZ+hk6LJNfQtWwlb1jBCbTC6vmfXKzs7WdpVWtDOVHrOgjSkLrROKTOFPciqhuBuc
 U6pFH1/ZvAXW1JXVqcD7Xzce3y5tnxU2YS5Guq+dziUKk7EBIJfq1xZsnEq7NVlJ2GTAilv9I9S
 vjKl5f5j2N6q1uWgBlugE6SL3MRezP3zJ4XEuzdW3Wcx3NB137gtWAMtmQIC1w+K3bnj
X-Received: by 2002:a05:693c:88c9:20b0:361:fd60:3cd2 with SMTP id
 5a478bee46e88-3674e450f3fmr3100324eec.10.1792589972565; 
 Wed, 21 Oct 2026 06:39:32 -0700 (PDT)
Received: from
 runnervmxehtw.cxrikbqfcygehnd5bg50p3ctfh.dx.internal.cloudapp.net
 ([13.83.233.106]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367411bc89fsm9175292eec.16.2026.10.21.06.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:39:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed, 21 Oct 2026 13:39:30 +0000
Message-ID: <20261021133930.9315-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021085932.20557-2-piotr.kubaj@intel.com>
References: <20261021085932.20557-2-piotr.kubaj@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: add tst_test.needs_debugfs flag
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

On 21 October 2026, Piotr Kubaj wrote:
> lib: add tst_test.needs_debugfs flag

--- [PATCH 1/3] ---

> diff --git a/metadata/metaparse.c b/metadata/metaparse.c
> +	{.id = "needs_debugfs", .type = DATA_BOOL},

Medium: Add needs_debugfs -> needs_root to implies[] and cover it with a
metadata fixture. Parsing tst_needs_debugfs.c currently emits
needs_debugfs:true without needs_root:true, although the same executable
rejects non-root execution, so metadata consumers miss its root requirement.

--- [PATCH 2/3] ---

> diff --git a/testcases/kernel/power_management/pkgc_ltr_blocker_show.c b/testcases/kernel/power_management/pkgc_ltr_blocker_show.c
> + * arbitrary u32 read out of the wrong offset averages 2^31, orders of
> + * magnitude past what the bound allows.

Low: This concerns the absolute value, not the difference between reads
from the same wrong offset. Replaying 3735928559 -> 3735928560 passes the
actual delta check, as does an unchanged arbitrary value. Narrow the
description and commit-message coverage claim to format/rate validation,
or provide an independent oracle for the offset regression.

--- [PATCH 3/3] ---

> diff --git a/testcases/kernel/power_management/ltr_counter.c b/testcases/kernel/power_management/ltr_counter.c
> +		if (tst_timespec_diff_ms(now, last_change) >= QUIET_WINDOW * 1000) {
> +			tst_res(TPASS,
> +				"%d counters held still over %ds with every CPU busy",
> +				cnt, QUIET_WINDOW);
> +			return;

Medium: Replaying a counter that updates every 6.5 seconds satisfies the
idle-advance prerequisite, then passes after six seconds of load before
the next update; LOAD_WINDOW never protects this path. Establish a
conservative refresh bound with margin before declaring the counters
quiet. Reconcile the timing assumptions across the series: patch 2 calls
four seconds several refresh periods, while this patch reports roughly
six seconds per refresh.

> +			if (sched_setaffinity(0, sizeof(one), &one)) {
> +				tst_brk(TBROK | TERRNO,
> +					"sched_setaffinity(CPU %d) failed", cpu);
> +			}
> +
> +			spin();

Medium: Affinity does not establish continuous load when a CPU-bandwidth
cgroup quota throttles all spinners together. During those idle gaps,
correct counters can advance and be reported as failures after the load
window. Detect throttling, including inherited limits, and report the
configuration as unsupported rather than blaming the counters.

> +	cpu_set_t mask;
> +	int nr_cpus;
> +	int cpu = 0;
> +
> +	if (sched_getaffinity(0, sizeof(mask), &mask))
> +		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");

Medium: Both glibc and musl cpu_set_t hold only 1024 CPUs, so this call
fails with EINVAL when the kernel's possible-CPU mask is larger, even with
few CPUs online. Use CPU_ALLOC(tst_ncpus_max()), CPU_ALLOC_SIZE(), and the
*_S macros for both masks, with cleanup, following lib/tst_cpu.c.

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
