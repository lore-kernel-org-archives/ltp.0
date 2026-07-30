Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1115C54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 07:04:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 004E83E2D2D
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 09:04:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 932483D2634
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 09:04:38 +0200 (CEST)
Received: from mail-yx2-x02.google.com (mail-yx2-x02.google.com
 [IPv6:2607:f8b0:4864:41::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE1C81400242
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 09:04:37 +0200 (CEST)
Received: by mail-yx2-x02.google.com with SMTP id
 00721157ae682-81c6e4ce922so13165817b3.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785395076; x=1785999876; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tFXXae1t/Qh4lLOvDscOrgHaHX/33EM3gN09Y4YFgx4=;
 b=HufMMIe6Apo6zIlorYnxr7BPqPnYfS6ZD6ENCgKL01KT03mTI96ZuGDyAWhGfWafu2
 wutHU1PEo9DNreYSbrzH48fTkLjM8cxmUR0K/WcrioNZ/6SOQTSxSkDcfE1YZ4lUHNnF
 WO+mOeNZxg7KiZqnIrDk7Yo6rP2fwmioe2x/GNZi3ecz+07MCD1EJ7J+8B4D85QNCfVE
 nCOstWmY4nC6AUEtpHPSSRMe+o3GOA1BFa98lc4vSNtuBDPZCqJjjqP/7Vvi5UzzfdM2
 Efhyrk4XCPM8I3Y6U7pBHl20NflD150ukt1CO4NKGIRcrqGhRdM5oe4PrSyxfWDFr1OF
 5hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785395076; x=1785999876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tFXXae1t/Qh4lLOvDscOrgHaHX/33EM3gN09Y4YFgx4=;
 b=qwIFOTJ7N4PPw0nAvFp9T5OWcst/JWdjHu5UmFknHkEDTqwj6Q3jLRT3fEh4hXJh2Y
 rsN2bAL/p9OL0tRqx4O3z3X7g2NzvTRlY5TZvSsiQU49NvkOiHVgbxuawvDjgEuKvLrb
 1iTf4HpXrfomjIiFu0QUq829+dzUZh561+RfgudHMuldBl2sA2YCMCUBlUSp1X9JnmKC
 +mn5gb0LMkZCMd4bmt/FZjS+vXhW8W28MGslmWlgyCWBwbTAXCXL2oJ4hAbrP9HDNhb/
 6R0T+HOdaEcu+61d4YdK5j2rTgbsaUE2limi+X0uttUosA3o9nFlKt7FD/x9LoAIoG6W
 A2ig==
X-Gm-Message-State: AOJu0Yyu/hVmEKRZkuE0UxbFcPGIuyT0hhJLRIT2UwkZCKUiSYEWJZo4
 i9cJZ+q+4aa1hEMvv/+5jeHRwzp2OAjfK3wBd9Z0TwHtgP7NkHn9y7Pu8H1SOIKx
X-Gm-Gg: AR+sD116gnTmz4q/kng2K3WA7g46JmpnF1lXVMwflKN0Vax0+xgbrhHmkReMNpKDktm
 mnAx8T+vkVApHJf2GclZvoaQ5Z5n+AvtBikg5EJe+QzVF+8pturFNRpfwIPJ020zKJ1KQ/oXwX6
 H7/9+2PbHrDnqevDBdRP+O7p2SCQgbPe1RLUEelCR0Nec9rVQ0/oKzKtzo9nyNcWvSBf+TNRq9Q
 FadmGv6CYObbD6pLzLyVm6RRjuZArftvy+Yym+10nQ+mdi8K+z8gX1P4WvpHL+D4ViPeKluBO74
 NGr7DpPGyN9ZoWmVc2zAuPqeCfkUzANdt0LPTGxPtTZlCgbPOMTEos2YttJfV0mMVRnosXa3wWk
 81m7bsPGRtNcbCnrx0crtYnCsKlZXRyJe1lTnhaSKJ4uMQDKEUAi1589uoVs0YTixYJbW99i/Ya
 wNcLXOqJV032guzcBTtRT6kCBavJd2WvlKn4KCmuLWuX+Hjd+ZQKFj4h2ANAobJdl+t8QW7/q63
 NQPoAjLg4zA7me+OQdYduJalBejM0pI9pfjGSrfMYqvuh9L3qMqu7dqbTjuQR27rMKSO0Bp+OPQ
 DS94Gn68Avj8hA==
X-Received: by 2002:a05:690c:698f:b0:7ff:1a93:be35 with SMTP id
 00721157ae682-81fb893f623mr9019877b3.16.1785395076172; 
 Thu, 30 Jul 2026 00:04:36 -0700 (PDT)
Received: from
 runnervmvrwv9.pfe21i0rikauph5zkfwnlcew1b.ex.internal.cloudapp.net
 ([135.232.177.188]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fb8aec6f4sm5548967b3.41.2026.07.30.00.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 00:04:35 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Shaojie Sun <sunshaojie@kylinos.cn>
Date: Thu, 30 Jul 2026 07:04:34 +0000
Message-ID: <20260730070434.11797-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730032850.775128-2-sunshaojie@kylinos.cn>
References: <20260730032850.775128-2-sunshaojie@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_cgroup: add cpu.stat and cpu.weight to cgroup file
 table
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

Hi Shaojie,

On Thu, Jul 30, 2026 at 11:28:48 AM +0800, Shaojie Sun wrote:
> tst_cgroup: add cpu.stat and cpu.weight to cgroup file table

--- [PATCH 1/3] ---

>  	{ "cpu.max", "cpu.cfs_quota_us", CTRL_CPU },
>  	{ "cpu.cfs_period_us", "cpu.cfs_period_us", CTRL_CPU },
> +	{ "cpu.stat", NULL, CTRL_CPU },
> +	{ "cpu.weight", NULL, CTRL_CPU },

A NULL file_name_v1 means "item is V2 only", and cgroup_file_alias()
returns that NULL for TST_CG_V1 roots, so safe_cg_has()/safe_cg_read()
will report the file as absent on a v1 hierarchy.

cpu.stat does exist on v1 though: kernel/sched/core.c has
{ .name = "stat", .seq_show = cpu_cfs_stat_show } in cpu_legacy_files[]
under CONFIG_CFS_BANDWIDTH.

Should this be { "cpu.stat", "cpu.stat", CTRL_CPU }, following the
memory.stat entry?

cpu.weight -> NULL looks right, since the v1 counterpart cpu.shares uses
a different scale and cannot be aliased.

--- [PATCH 2/3] ---

> +	if (!SAFE_FORK()) {
> +		struct cpu_hog_func_param param = {
> +			.nprocs = 1,
> +			.ts = {
> +				.tv_sec = usage_seconds,
> +				.tv_nsec = 0,
> +			},
> +			.clock_type = CPU_HOG_CLOCK_PROCESS,
> +		};
> +
> +		SAFE_CG_PRINTF(cg_test, "cgroup.procs", "%d", getpid());
> +		exit(hog_cpus_timed(&param));
> +	}
> +
> +	SAFE_WAITPID(-1, &status, 0);

The child encodes its outcome in the exit code, but "status" is never
examined here (same pattern in cgroup_cpu03.c, cgroup_cpu04.c
wait_children() and cgroup_cpu05.c).

hog_cpus_timed() returns -1 when clock_gettime() or pthread_create()
fails. With the status ignored, a child that never started a single hog
thread is indistinguishable from a successful run, and the parent then
reads cpu.stat and reports a misleading result. For cgroup_cpu05 this
can even produce a TPASS, since a dead hog and a correctly throttled hog
both yield a near-zero usage_usec.

The LTP way is for the child to report with tst_res()/tst_brk() directly
and exit(0) - the library propagates results from children to the
parent. Could hog_cpus_timed() call tst_brk(TBROK | TERRNO, ...) on
failure instead of returning -1? That also removes the unused "status"
variables and lets the framework reap the children.

> +	SAFE_CG_PRINTF(cg_parent, "cpu.max", "%ld %ld", quota_usec, period_usec);

cpu.max and cpu.max.burst are compiled into cpu_files[] only under
CONFIG_GROUP_SCHED_BANDWIDTH, and CONFIG_CFS_BANDWIDTH which selects it
is "default n". Similarly cpu.weight in cgroup_cpu04.c depends on
CONFIG_GROUP_SCHED_WEIGHT.

On a kernel with the cpu controller but without bandwidth support,
safe_cg_printf() cannot find the file and the test aborts with TBROK,
while a missing feature has to be reported as TCONF.

Would .needs_kconfigs work here, e.g.

	.needs_kconfigs = (const char *[]) {
		"CONFIG_CFS_BANDWIDTH=y",
		NULL
	},

or alternatively a SAFE_CG_HAS() check in setup() followed by
tst_brk(TCONF, ...)?

> +		if (nice(1) == -1 && errno != 0)
> +			exit(1);

nice() may legitimately return -1 as the new nice value, so errno has to
be set to 0 immediately before the call for this check to be meaningful
(see nice(2)). At this point errno can still carry a stale value from
the SAFE_CG_PRINTF() path just above, which would turn a successful
nice(1) returning -1 into a spurious failure.

Adding "errno = 0;" before the call would fix that. The silent exit(1)
is covered by the comment on child result reporting above.

> +/*
> + * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>
> + */

All six new files carry only this line while the patch author is someone
else. cgroup_cpu01.c is clearly derived from memcontrol01.c so keeping
the original attribution makes sense there, but the remaining files are
new work - should they carry the author's own copyright line as well,
with the year matching the commit date?

> + * Includes:
> + * - test_cpucg_weight_overprovisioned
> + * - test_cpucg_weight_underprovisioned
> + * - test_cpucg_nested_weight_overprovisioned
> + * - test_cpucg_nested_weight_underprovisioned

The doc block is rendered as-is in the test catalog, and reST requires a
blank line before a bullet list. A " *" line after "Includes:" is needed
here and in cgroup_cpu05.c.

> + * Conversion of kselftest test_cpucg_subtree_control from
> + * tools/testing/selftests/cgroup/test_cpu.c.

The doc has a role for this, which turns the reference into a link in
the catalog. memcontrol01.c uses it as

	:kselftest:`cgroup/test_memcontrol.c`

Could the five doc blocks use :kselftest:`cgroup/test_cpu.c` instead of
the plain path?

> +	.needs_cgroup_ver = TST_CG_V2,
> +	.needs_cgroup_ctrls = (const char *const []){ "cpu", NULL },
> +	.needs_cgroup_nsdelegate = 0,

needs_cgroup_nsdelegate is a bitfield that already defaults to 0, so the
explicit initialiser can be dropped from all five tests. The same
applies to .timeout = 30 in cgroup_cpu05.c, which is the framework
default.

> +#define USEC_PER_SEC 1000000L
> +#define HOG_SECONDS 10

USEC_PER_SEC is not used anywhere in cgroup_cpu04.c.

> +cleanup:
> +	for (i = 2; i >= 0; i--) {
> +		if (cg_leaf[i]) {
> +			SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs",
> +				       "%d", getpid());
> +			cg_leaf[i] = tst_cg_group_rm(cg_leaf[i]);
> +		}
> +	}

The drain write is inside the loop here, so it runs three times, while
the two nested variants in the same file do it once before the loop.

Beyond the inconsistency, the test process itself is never added to any
cg_leaf group in this file, so is the drain write needed at all here?

> +static void run(unsigned int n)
> +{
> +	switch (n) {
> +	case 0:
> +		test_cpucg_weight_overprovisioned();
> +		break;
...
> +	.test = run,
> +	.tcnt = 4,

LTP dispatches multiple test cases through a table rather than a switch,
either a struct tcase[] or a static array of function pointers, with
.tcnt = ARRAY_SIZE(...). As written, .tcnt = 4 (and .tcnt = 2 in
cgroup_cpu05.c) is a literal that can silently drift out of sync with
the cases.

> +	.forks_child = 1,
> +	.needs_cgroup_ver = TST_CG_V2,

cgroup_cpu02.c does not set .needs_root = 1 while cgroup_cpu03.c,
cgroup_cpu04.c and cgroup_cpu05.c do, even though all four write to
cgroup.procs and cpu.* from the test process. Could this be made
consistent across the series?

> +/*\
> + * Common helpers for cgroup cpu controller tests.
> + *
> + * Converted from kselftest
> + * tools/testing/selftests/cgroup/test_cpu.c
> + */

The "/*\" marker opens a test high-level description that docparse
extracts for the catalog. cgroup_cpu_common.h is a helper header rather
than a test, so a plain "/* */" comment would be more appropriate.

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
