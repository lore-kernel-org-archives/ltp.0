Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02A0CD8CA4
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C55D3E6F93
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:39:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53EAD3C1ADA
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:39:34 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A9DFA60078F
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:39:33 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-517583cb07aso48884311cf.2
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780929572; x=1781534372; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnhvCPovNraZkZKAJZyDlyyGyJaNDYi4gWKHB+MjJE0=;
 b=TeTvNgKnaQO+MK2raDvV39YNrg+NkJF8Gjl6aFIzTAdA81Uu0bIIbJtW5OY/Vust3O
 nKs0kf3wT9p9zN6VDfrj5o6p5GMQ8yW8SCANDmpwuD/eCslgYtDhJHZgD/T7g3FCAvch
 GJnzsXgmVF570MIZueIRyTTTjqHeLBjRa2/pFOaMAZN6UTD/thn7DXiOZb4tlAmjqieq
 ma5ll9VMlSST4apOnBOIuuhhlxJHC9qu1uPuuMUt2TLhiFcHmW+hHO5bT0qaBV/aueYI
 CLqbFGt60QJY+4EtcRz0vNSJqadOuAOn+qaD+Q5GoKeYZx/ro1Hd0+iIxbRAimuGqOcn
 r0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780929572; x=1781534372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hnhvCPovNraZkZKAJZyDlyyGyJaNDYi4gWKHB+MjJE0=;
 b=DhcOFuRKfdAYGebHffOe80vySfa8GuVpjKLHnVJXBuwrUcssjxD6O8K3lrjK7jKXEI
 VADvEhbSLLjnMW3xf6wXjBRhNdt5bzU/uZSUSKUpfQk6dFQ9uKTq5ThV0IwVK+ahmLza
 Zc2Z2uW1KwQT/Zpj6tfittXRVKag9DbfkXdLZFj2mj3mLbK0PwLuhvBZB1jKj/yIiBB8
 cnJnKS+6asbJgvxxSuBYamdxXPMdQbxPBdO16iuTYvqeR3qN4SlRkZ3ev2CXY6mCh4b7
 svt8i4aNUAbSWo4b7Dwhf6PcVPMWZumcST7eKVIBPkjxtMa00XeLU3OAZ1fr/Na7MOAx
 logg==
X-Gm-Message-State: AOJu0Yzyh4BqFDvpO7g4mIQ8YSNkBfycS7eDEzJk/SsBWq731lFaeJqF
 esTDPMWiCHH1DjhFbwvzqnyu8YfSA+3WHuqc4uTiPqOe7dy2uK615laU
X-Gm-Gg: Acq92OFx3n87Q1MXOvsFcSH/+ZSCBcFB2s1/pa8q4vke8i6BdyBycsFpXcw9JuTJVCh
 ik1cTQnmruZO4EFLMmP3r9BYboQ8KugX/UbH/NGZiZscFW6KutUlmN9Z/lyO28M46gFEaQRK1A4
 +O37LBxthE/o88BDwOF6nDAUWI9SiL37rDgrJyUFWFKO039XX9hl6J4FOPLAV81JA64KtOV4bTn
 C+shFQqbSVXolzhxjaMriAQd99yWj9xPVtLvdtuTYoe49RGlw3s74V3d4lcB24mzjqtX9U4l9z9
 dqmrC1uRmgP/N8wgjMqYXDh4tQyZ2+8SEHWI8KkVEHghzp433f0PhZ9ygVnF1M3xh0m+mRPJVFh
 wtw5tENzdWHHD5StxNWSeRjrNECSp2/Mcw9vgvTAfEzAK2Bu2U5PjILX4TxBhy0oEj4APV2sTZP
 TDKXVA2HxV22N5Nn1Xk3Rt3qvD/qZAygFSEsAoulZo7vqSjKN5fLCcwQk+H6p/EGkR0CVmTjpNC
 gnYg6HeKpeDqqWzT2NXFOFrxwUN5wzutJxxgkAOcJZfyKn4
X-Received: by 2002:a05:622a:17cc:b0:517:5e32:f3bf with SMTP id
 d75a77b69052e-51795b9e179mr231600361cf.20.1780929572285; 
 Mon, 08 Jun 2026 07:39:32 -0700 (PDT)
Received: from
 runnervm3jyl0.t44aakfgbf0ebggs33ekaeudia.bx.internal.cloudapp.net
 ([20.55.86.182]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775dd2e53sm154156281cf.24.2026.06.08.07.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:39:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Praveen K Pandey <praveen@linux.ibm.com>
Date: Mon,  8 Jun 2026 14:39:30 +0000
Message-ID: <20260608143930.4256-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608132526.42325-2-praveen@linux.ibm.com>
References: <20260608132526.42325-2-praveen@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ftrace: Add common library for C implementation
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

Hi Praveen,

On Mon, 8 Jun 2026 18:55:22 +0530, Praveen K Pandey wrote:
> ftrace: Add common library for C implementation

--- [PATCH 1/5] ---

> +// Made with Bob

What is this? This is a C++ style comment (kernel style requires
/* ... */) and seems like a leftover that should be removed.

> +int ftrace_set_tracer(const char *tracer)
> +{
> +	char *path;
> +	int ret;

`ret` is declared but never used in this function since
SAFE_FILE_PRINTF() is used for the write. Should be removed.

> +	if (saved_state.trace_options) {
> +		char *options = strdup(saved_state.trace_options);
> +		char *token = strtok(options, "\n");

If strdup() returns NULL (OOM), passing NULL as the first argument
to strtok() on the first call is undefined behavior. The other
strdup() call in ftrace_initialize() checks for NULL, so this one
should too.

--- [PATCH 2/5] ---

> ftrace: Convert ftrace_regression01.sh to C
>
> Convert ftrace_regression01.sh to C using the new LTP test API.
> This test validates basic ftrace functionality by testing all
> available tracers.

The commit body does not match the test. The code (and the doc
block) test for a kernel panic triggered by userstacktrace with
page fault events, not "basic ftrace functionality by testing all
available tracers."

> - Sets .min_kver = "2.6.29" for kernel version requirement

The code does not set .min_kver at all. The commit body should
match the actual struct tst_test definition.

--- [PATCH 3/5] ---

> ftrace: Convert ftrace_regression02.sh to C
>
> - Sets .min_kver = "2.6.29" for kernel version requirement

The code sets .min_kver = "3.2", not "2.6.29".

--- [PATCH 4/5] ---

> +static volatile int stop_testing = 0;

> +static void stop_stress_tests(void)
> +{
> +	int i;
> +
> +	stop_testing = 1;
> +
> +	for (i = 0; i < thread_count; i++) {
> +		pthread_join(threads[i], NULL);
> +	}

> +static void run_test(void)
> +{
> +	...
> +	stop_stress_tests();

> +static void cleanup(void)
> +{
> +	if (thread_count > 0) {
> +		stop_testing = 1;
> +		stop_stress_tests();
> +	}

On the normal path, run_test() calls stop_stress_tests() which
joins all threads, then cleanup() is called and
stop_stress_tests() runs again. Calling pthread_join() on
already-joined threads is undefined behavior.

One fix: reset thread_count to 0 at the end of
stop_stress_tests().

Also, stop_testing is never reset to 0 between iterations, so
running with -i N would cause iterations 2+ to spawn threads
that exit immediately (all threads check
`while (!stop_testing)`). Both stop_testing and thread_count
should be re-initialized in run_test() or setup().

--- [PATCH 5/5] ---

> diff --git a/testcases/kernel/tracing/ftrace_test/Makefile
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +# C test binaries with shared library dependencies
> +ftrace_regression01:	ftrace_lib.o
> +ftrace_regression02:	ftrace_lib.o
> +ftrace_stress_test:	ftrace_lib.o

The Makefile changes (FILTER_OUT_MAKE_TARGETS, library
dependencies, -lpthread) are deferred to patch 5, but the C
source files are added in patches 1-4. This means the build
breaks at every intermediate commit: patch 1 adds ftrace_lib.c
(which defines TST_NO_DEFAULT_MAIN and has no main()), but the
old Makefile's auto-detection tries to build it as a standalone
binary and the link fails. Patches 2-4 likewise cannot link
without the ftrace_lib.o dependency.

Each patch in the series must compile on its own. The Makefile
changes should be moved earlier, or folded into the respective
patches that add the C files.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
