Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE6CD8C85
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 21:11:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B51E3D0372
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 23:11:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 542B13D0372
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 23:11:25 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E7162200B2A
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 23:11:24 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-51784eb2ba0so23278031cf.2
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780780284; x=1781385084; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVajfUshsT43YggNQQFxiODx5iITHneAKOh+OkK5drA=;
 b=ocDD1Jhq3NSc398AiPwJXBIeriOITe5TfJprcUgCDUFHEUpa9sPBx4Tyk/imGb28p8
 SluGSKZO0d6EZOqMhgpx/PoJEZHQfCyuq1ImlZCOimp9XiVBZXE/DFbQS7Ekpie8yhLM
 PUKb4utaC/U+4aoSPJvlWtIBQ7B5GiK+chrw6vB+u5L3Dly+Wlr3TIjdNmzJVkiFma7v
 AR6wyfO0ZIetjdv8Az9a0+f9D135q4+RRhbDLqDiIjP3gChfJhxBI1owFkXbOHxCxl/0
 f+KfspHPS7gLoYGso3+V3eT82WuWNKt5WXlvR+7OB2xIn7pil1EV+DQ3XZN3XVcb+s3E
 Vkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780780284; x=1781385084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KVajfUshsT43YggNQQFxiODx5iITHneAKOh+OkK5drA=;
 b=gyRDEsZ7pvbxMfwRn31YcaibO6mjL8MWtZNn5TNtJMUgsKhWQnMYA/XurM2YyC7d85
 vAu6kXPaV1eVnBHC3ECw21Kh1kdLaLX8YF7Q51Auzo9/FaIjI9VhWpZNErCXCwj1nJvX
 iSiw8D9piOs0AaPorawyM43IRd96w8FryYvXnSArDJeFRe79EqiQUxlS7HD7wWL5Bld+
 1sqdIRebyO84ay2ImakrzvhjngsUhwGEQieBrJcwUyi0L4VEaYHOdCkF9I/lfbx/TWGx
 tx19mpxeTtduG/GTL7weEDjBZVCOvUCIU8p/Qo0Fxr0gPKvPCtgwg2wXUpH0DL8BL2Lg
 z0Ng==
X-Gm-Message-State: AOJu0Ywa0qK679Vu2Ev0g9VLUn2Xn5diq6Gl6pKCQF4oP200WH3MK+9Q
 tLkLeX4ktPrJbwAXPtuKZfwUqRjUYMBbg2kIxbiDMpR5WiuliUSCu8zz
X-Gm-Gg: Acq92OH7UwggVdR6gUGPccz/dN9Dq6Dk5XfMVhVWqU866uNANaNZxmzcs6ClTZH5CSl
 dJR42rGWd+51s9P8j520gUsx+xK2WiLdujuAIMlVUCbJ7zffrTkpmSY8NmI5zi1gd4RV6Jwx0c3
 m40balki5MEzdOmCq4/CjFclL7Az0mJ+uiG/4yj9ISSOusPw0Jlrqjx3Zf0jWW+uwU7Mf1LLAG5
 PcRpRJ2Yw3piM5gCKSlKnZWBbDKJ7VgbwtNv8o2yzBpx7pcdejiM6UDaqG2dIYHd86MslORIPe0
 Dj5f7OQdjKHwdlSUYmr6g6f0MKFi5nv989mbZsQVjg+8jJc8o+uw69f6CmoFcOLTIR0sx7NKQ0a
 9TqdcWu/R0gzdW+UqlUBptBmUyz5WU6ArP23XHC27Zf7gjIpW94yykIs5zs4AO7GNb0Z6SOahdL
 0YY2g9soC9RBzXFsZGNtjNAmnVbpJx/i+fSs2xDxA4p0hGHaLaF6FgRNqw2Tu0prtHaxn/rzhJ1
 M2s38D/uj9rx0iy9ZoyY2+5xZJWOe7yXBXKMj0Ex4cgVep+xqc=
X-Received: by 2002:a05:622a:14d2:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-51795a486d9mr127869201cf.7.1780780283498; 
 Sat, 06 Jun 2026 14:11:23 -0700 (PDT)
Received: from
 runnervm3jyl0.zm1gstafu1aubcwruotojqkf4h.bx.internal.cloudapp.net
 ([74.235.134.165]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da6f41sm108042901cf.22.2026.06.06.14.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 14:11:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Praveen K Pandey <praveen@linux.ibm.com>
Date: Sat,  6 Jun 2026 21:11:21 +0000
Message-ID: <20260606211121.4161-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606195818.95400-2-praveen@linux.ibm.com>
References: <20260606195818.95400-2-praveen@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

On Sun, 07 Jun 2026 01:28:14 +0530, Praveen K Pandey wrote:
> ftrace: Add common library for C implementation

--- [PATCH 1/5] ---

> +	/* Mount debugfs if not already mounted */
> +	if (!found) {
> +		char *tmpdir = tst_tmpdir_path();

tst_tmpdir_path() calls tst_brkm(TBROK) with the message
".needs_tmpdir must be set!" when the tmpdir has not been created by
the framework. None of the tests in this series set .needs_tmpdir = 1,
so if debugfs is not already mounted the test aborts with a confusing
TBROK instead of a clear error. Either set .needs_tmpdir = 1 in each
test, or use a separate hard-coded path (e.g. via mkdtemp()) for the
debugfs mount point.

--- [PATCH 2/5] ---

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "1dbd195"},
> +		{"CVE", "2015-8550"},
> +		{}
> +	}

CVE-2015-8550 is a Xen cross-VM information-leak vulnerability. It is
unrelated to the kernel ftrace preempt-count leak fixed by commit
1dbd195. Is this the right CVE?

> +	/* Wait for trace events to be written */
> +	TST_RETRY_FUNC(ftrace_read_file("trace"), TST_RETVAL_NOTNULL);

The return value of TST_RETRY_FUNC is the last return value of
ftrace_read_file(), which is an allocated buffer. Discarding it leaks
that memory. The result should be assigned to a pointer and freed, even
if the content is not needed here.

> + * [Algorithm]
> + *
> + * 1. Enable stack tracer
> + * 2. Enable userstacktrace option
> + * 3. Enable page fault events (either exceptions:page_fault_kernel or
> + *    kmem:mm_kernel_pagefault depending on kernel version)
> + * 4. Repeat multiple times to trigger the issue
> + * 5. System should not panic

The [Algorithm] section must use a bulleted list with '-' markers, not
a numbered list. See documentation.md rule 4.

> +static struct tst_test test = {
> +	.test_all = run_test,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,

Ground Rule 4 requires that the reason root is needed be documented in
the test's doc comment. The /*\ ... */ block does not mention it. A
line such as "Requires root to access and configure the ftrace
subsystem via debugfs." is sufficient.

--- [PATCH 3/5] ---

> + * [Algorithm]
> + *
> + * 1. Enable signal:signal_generate event
> + * 2. Enable tracing
> + * 3. Generate some signals by running commands
> + * 4. Check trace output for 'grp=' and 'res=' fields
> + * 5. Test passes if both fields are present

Same as above: [Algorithm] must use '-' bullets, not a numbered list.

> +	.needs_root = 1,

Same as above: the doc comment must state why root is required.

--- [PATCH 4/5] ---

> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +# C test binaries with shared library dependencies
> +ftrace_regression01:	ftrace_lib.o
> +ftrace_regression02:	ftrace_lib.o
> +ftrace_stress_test:	ftrace_lib.o
> +
> +# Only ftrace_stress_test needs pthread
> +ftrace_stress_test: LDLIBS += -lpthread

Per-target LDLIBS assignments must appear between the two framework
includes, not after generic_leaf_target.mk. Object-dependency rules
(the ftrace_lib.o lines) must be after, but the LDLIBS line must move
up, before the generic_leaf_target.mk include. See build-system.md
section "Per-target flags".

> +ftrace_stress_test:	ftrace_lib.o

There is no .gitignore in this directory. The three new binaries
(ftrace_regression01, ftrace_regression02, ftrace_stress_test) must be
listed there so they are not reported as untracked files. See
c-tests.md rule 6.

> + * [Description]
> + *
> + * Stress test for ftrace subsystem.

The [Description] header is deprecated. Remove it and keep only the
description text. See c-tests.md rule 18.

> +	.needs_root = 1,

Same as above: doc comment must state why root is required.

The series updates runtest/tracing to reference the new C binaries but
does not remove the old shell files that are now orphaned:

  testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
  testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
  testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
  testcases/kernel/tracing/ftrace_test/ftrace_lib.sh

These files are no longer installed (the INSTALL_TARGETS line was
removed) and are no longer referenced from runtest, but they remain in
the tree. They should be deleted, either in this patch or in a
follow-up.

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
