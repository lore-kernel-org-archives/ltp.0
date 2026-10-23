Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2696606A322
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r2ER/G99
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 910453E9BFD
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 19:55:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A03183C52F3
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 19:55:10 +0200 (CEST)
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E2FF814001F4
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 19:55:09 +0200 (CEST)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6f436312596so368804eaf.1
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792778108; x=1793382908; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8gamyOpYxX9pegDNap6xGQ88zEmP75L7duEHBj7KzNY=;
 b=r2ER/G99MvFBrhE06l/ug/Jf762xQhDDiuoY2g7MxHv7w8Jwh+FTe+AMYKQ9SwBu0x
 v1QzQ2prNag/VvwaoigVQmJxJU6XhcPi0w6QDqXL7805Szxcd1zoJzVFSFEReFGcCTwP
 E4/rfQ03dpO40qZO/MlMWx5Ttoe4Mi4HRyAYRUdZXiPtVRJe3/IB2gl86LFoq7JF1Zu3
 WJIpzMb18Mc8c6KxX5Ix46Rl7RJPMxoE+GPu662lV7shwPsHs88GgCKXYjZpN3Dds7P6
 Vri5RWr8c16fYE05z1c10KONR3fYY7wu4GuIxu8x1UgU2esDXFK3I7+bDf53HSbZXtH1
 wZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778108; x=1793382908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8gamyOpYxX9pegDNap6xGQ88zEmP75L7duEHBj7KzNY=;
 b=GSsG0+IdBN1t94rOSig27NUcbv+WAwCAnv3UiJhY+N0U8mjHzmEaB7sq7n6J4eaPCD
 9rqPIAD6Jxxs9ys8J/5shBncDIJ2rVX2Vk9PL8SlltDwR3XDXHBmS1odCBDFUEOJomon
 yvEoskdL039Sv+NcZa7OLsqmBc9hxenNztxBjquwRvhTrr6qTlwOs8ec3ragHcHH4hkM
 EpGG/s3TZnXodY5JnyCAgsHjndBmCWJeSzxf4m2qkGP3tO2RnEBtK9ddownTFyexd4rO
 snjksC7i/WAqaKDfNd3a9L2SEglbNY8E7U2fi0ioOUJzAcaq2qcIoC8RAr5JbF4lVV+c
 8VCw==
X-Gm-Message-State: AFq9FYL8I5bff2QVwLbGvidgBbMWeRr6ayVmwwhMyBW7xTLhKh0XXYOX
 /14X9gongTmnIDdJ6JfHaod2VI/7a2ze5/UtQeylIrzCaAmlfinCLPIu
X-Gm-Gg: AYBFou0pwt+YWatAUgdCNyTqjZ3dQO10Lx/AnpofZrSF9uSOTKNLD67m6GCp7+G3Bvg
 rUPF9F5uFIuTTglUSn1MNCQ6m3iQBLol9YJVVr1gODBdBXNxjsaYNDr4LN3rkxQqxtqVxT8PJQ+
 PQq2IwFEAZxnW0ZT0L9CZDqfQJ4IbzUk7ev8d6p/rW0sWvHvBdMnVITmgKo0scMaRu9rLYdzVtC
 kb92yysFCwTCzqAUefPS0sogHsfDybl1lsFAcGqQrMwklQ2TmP/0xTkpSUvnCPZPJ+WQjo3yMNg
 Axqpz+aqNCZnuOuURzVun/uOGlZDQVLpToWlmgYRqk/mp6ie01DSZa+etdZ0F0uPpFcmFXQW3un
 MHA8rLneEl54Lb88Vt3ynYMTz0Zc4jb7d+SiQqQI1keWw37rG5Tp9oVXTisvNiQoIvBhCBR5jJk
 VwScj0kjkSljlOlwSkjyNbByOQ8i2PaGwOy2Osgtv2dfbjIGThtaHTi5XVt+wqvs8nV+WBrmkpP
 8fkhswidXg6MRW3jReWHayntegowaa7ep+ei2RL3ojYA3FnyZdfkx7KAskwWwRoy2WTwd7B1O6M
 lnBEOHedbKGHGY0fo8FaZr7/b0WLro+k83FuU00w4Do3A5+VsGKpJ7fINJk+V3FenMT00Q==
X-Received: by 2002:a05:6820:5047:b0:6d0:8fd1:7500 with SMTP id
 006d021491bc7-70b88af2351mr1804485eaf.77.1792778108228; 
 Fri, 23 Oct 2026 10:55:08 -0700 (PDT)
Received: from
 runnervm8k3b6.oxidzkwq25pelahkqzjg5q43me.jx.internal.cloudapp.net
 ([40.124.100.244]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9ae44045sm586778eaf.6.2026.10.23.10.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:55:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Fri, 23 Oct 2026 17:55:07 +0000
Message-ID: <20261023175507.9587-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024023044.80055-2-samir@linux.ibm.com>
References: <20261024023044.80055-2-samir@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched/psi: Add psi_invalid_trigger01 test
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

Hi Samir,

On Sat, 24 Oct 2026, Samir Mulani wrote:
> sched/psi: Add psi_invalid_trigger01 test

--- [PATCH 1/4] ---

> +	.needs_kconfigs = (const char *const[]) {
> +		"CONFIG_PSI=y",

Medium: PSI statistics exist in Linux 4.20-5.1, but trigger writes were
introduced in 5.2, so CONFIG_PSI and the setup read do not establish
monitor support. Add .min_kver = "5.2" or equivalent runtime detection
to avoid failing on supported kernels without this interface.

> +		TEST(write(fd, tc->input, len));
> +
> +		if (TST_RET == (long)len)
> +			tst_res(TPASS, "%s: trigger accepted", tc->desc);

Low: Use TST_EXP_VAL(write(fd, tc->input, len), (long)len,
"%s", tc->desc) instead of the manual return-value reporting block.

> +	.needs_root = 1,
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_REQ, CAP_SYS_RESOURCE),

Low: Document the root/CAP_SYS_RESOURCE requirement for custom trigger
windows in the high-level test description, not only the commit message.

> diff --git a/testcases/kernel/sched/psi/Makefile b/testcases/kernel/sched/psi/Makefile
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +

Low: Add the required copyright line after the SPDX tag.

--- [PATCH 2/4] ---

> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tests),
> +	.test = run,
> +	.setup = setup,

Medium: This test also needs a monitor-availability gate for PSI-enabled
4.20-5.1 kernels, where setup succeeds but trigger writes are unsupported.
Use .min_kver = "5.2" or equivalent runtime detection.

> +	TST_EXP_FAIL2(WRITE_TRIG(fd, TRIG_B), EBUSY,
> +		      "second write to the same fd");

Medium: This checks the behavior introduced by kernel fix a06247c6804f
("psi: Fix uaf issue when psi trigger is destroyed while being polled").
Add a linux-git regression tag for that fix and explain the relationship
in the commit message; do not skip kernels merely because they lack
the fix.

> +static void (*const tests[])(void) = {
> +	first_write_succeeds,
> +	second_write_ebusy,
> +	dup_fd_shares_trigger,

Low: Use the required struct tcase table and common .test handler,
parameterizing trigger strings, descriptor sharing and expected results
instead of dispatching separate per-case functions.

> +	.needs_root = 1,

Low: Explain the writable PSI interface and custom-window privilege
requirements in the high-level test description.

--- [PATCH 3/4] ---

> +#define PSI_LINE "%7s avg10=%lf avg60=%lf avg300=%lf total=%llu"
> [...]
> +	SAFE_FCLOSE(fp);
> +
> +	if (ret != 10) {

Medium: Supplying total=-1 and an unexpected third line still produces
seven passing results: %llu accepts the sign and the parser ignores
everything after the tenth conversion. Validate unsigned decimal totals,
consume each expected line completely, and reject extra records.

> +	if (n < ARRAY_SIZE(paths))
> +		verify_format(n);
> +	else if (n < 2 * ARRAY_SIZE(paths))
> +		verify_monotonic(n - ARRAY_SIZE(paths));
> +	else
> +		verify_cpu_full_zero();

Low: Replace the index-range dispatch with a struct tcase table describing
each path and check, using the common .test callback.

--- [PATCH 4/4] ---

> +			tst_clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +			if (pwrite(fd, io_buf, IO_SIZE, 0) != IO_SIZE)
> +				tst_brk(TBROK | TERRNO, "pwrite() failed");
> +
> +			tst_clock_gettime(CLOCK_MONOTONIC, &end);
> +			*io_wait_us += tst_timespec_diff_us(end, start);

High: This measures syscall wall time, including CPU work and preemption,
not time blocked on I/O. An O_DIRECT shmem reproduction measured 1995579us
with zero voluntary context switches, yet the test would require 498894us
of I/O pressure; LTP_DEV_FS_TYPE=tmpfs reaches this no-storage path.
Measure actual blocked-I/O time independently or use a controlled
blocking-I/O workload before deriving the expected PSI delta.

> +static char io_buf[IO_SIZE] __attribute__((aligned(4096)));

Medium: A fixed 4KiB alignment is insufficient on supported 64KiB-page
systems with 64KiB-sector Btrfs, which falls back to buffered writes for
this misalignment and invalidates the workload. Allocate a buffer using
the runtime DIO alignment or a suitable runtime page alignment; opening
the file successfully does not validate buffer alignment.

> +	for (i = 0; i < 2; i++) {
> +		if (!SAFE_FORK()) {
> +			join_cgroup();
> +			pin_to_cpu(pin_cpu);
> +
> +			tst_timer_start(CLOCK_MONOTONIC);

Medium: If the parent is delayed between forks for two seconds, the first
worker can finish before the second joins, producing serial workloads
and a false failure on an otherwise idle CPU. Use checkpoints to wait
until both workers have joined and pinned themselves, then release both
before starting their workload timers.

> +			if (pwrite(fd, io_buf, IO_SIZE, 0) != IO_SIZE)
> +				tst_brk(TBROK | TERRNO, "pwrite() failed");

Low: Use SAFE_PWRITE(SAFE_WRITE_ALL, fd, io_buf, IO_SIZE, 0) for this
workload operation; the subject under test is PSI accounting, not pwrite.

> +static void (*const tests[])(void) = {
> +	verify_cpu,
> +	verify_memory,
> +	verify_io,

Low: Use a struct tcase table and common .test handler rather than
dispatching separate per-case functions.

> +	.needs_root = 1,

Low: Document the cgroup/controller and test-filesystem setup as the
reason for requiring root in the high-level description.

> diff --git a/testcases/kernel/sched/psi/.gitignore b/testcases/kernel/sched/psi/.gitignore
>  /psi_proc_format01
> +/psi_accounting01

Low: Keep the entries sorted; /psi_accounting01 belongs first.

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
