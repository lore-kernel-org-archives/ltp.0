Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2ACC55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:10:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF39F3E532F
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 16:10:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D9F13CD529
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 16:10:21 +0200 (CEST)
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEA4F20093D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 16:10:20 +0200 (CEST)
Received: by mail-oo2-x09.google.com with SMTP id
 006d021491bc7-6aca92437fbso396319eaf.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785420619; x=1786025419; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o3GEHvXhBMi65+mxUQxHEKQH40Z4Cu4ggFYPe+NVTF4=;
 b=O42NY2Ba92qwwrSgEiAS3MTCKOVuEa2kblhi9cdFaIXMmxC2T79CFqsiLFmlA4pKf0
 53aAjPhEvTEX3CN5PzYc4XbEi9Ve3vsYID41au4nhIs7E/cGLPEdYfPrJ1bqFynS81zP
 JUQ8D7xJci3vyLDRd2rbhc1r2fR2gneyNPhYYS+DO2AcR0YB2aVNsM5fxFhbbum5PTbZ
 3+oV8mrNRkypNGvGY5Sgu1k/cGxbSjy09Kwgc5Ba4NmNAvJrNs3S2FSsBhAUIGOOEePy
 6OIt3plTR5tcx0DxDl1dmZZptNOCNIWOHBXZv7Bb3+uz8sXrbnJlj1CVjPSilnlDWp7r
 kzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785420619; x=1786025419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o3GEHvXhBMi65+mxUQxHEKQH40Z4Cu4ggFYPe+NVTF4=;
 b=I/CBnZY1rMqpu7+rfbON7ermyXoSRBbX6pFYe2LwhCP2AEdbmzZXESA56ZJo7xbvGs
 Zi/q0Si/VLPZqVNMyPCuxvPV4HW/YdRPmSNOH+YIr4LyR4hU0UW3a63gHag4t/w5kmLo
 M3omlyKBGrFRopikTz/QFdmi5TTcYy6P6bG9H5pV7zhvSsz1xAwXNGjFSYgLaZqQXpMN
 eAJu5nrp+2ukXwljrcNO+qQKn+WqR5UIzfNTjAMATLKFAHz/InEDqZjambXa1PccBSqn
 pbmbs//nd7Y1hnZy/OaXdqwZ5apLIu5yRMOn6Ts5h79XAuMAhfrdnlA5a/jc7XutGnG4
 Q7cg==
X-Gm-Message-State: AOJu0YwaAyWjR9RfZkNYhLqxJn0gRDtdCX9mlM7X1iPOV6P9cHyHapvf
 x/uEL6/aNgfeyynEjypbBJXMg+8UX8whYH6BaaeM5lvT/Oy3tiZTc8an
X-Gm-Gg: AR+sD10Tl23xTIkiT6HWTfzLn7xrIO0Q06EXo/0DwHWpzvvfsgsAyO1RC9rfA0GA1IL
 hOF/cBcPJoJaGLtyBxZzpTatJvT0AGvgxfLUjjX/Rt6lrq5SI6L8HaCdy17k3T2ntbZ7eLsnju4
 EQPd8e3XJMKnmo6bpHH6NPxhXMabF7HL4UljjPU/3VawFINAUg0AjRwhhMKG8ljVnlAkOU4fr54
 rAy1P0GXmtN9zE+PWg1+UklLXVwqQmSypUt0oXy793fOIYBAreFKPbqlJJrfdrG8E5PqKFEsXrt
 eARBHq5s0+YWbC27WpryPqvoED4d7yRqsCnJEtFVCiq9ldUBBRqFQx6V3JfwDo82/UJQmvQ8WoU
 Lz25p9sygr7Q99/iEh5x6TEVxVsSiTHGs7wHcLccgkd5dUj8NHhXAHO59QSstcH6iAR8A+zKCbY
 mRSaMSDspqk0kEdfarKs00uqA4yu83ywwn9LDkZJNkycwUIUn9d4gxzrsbc1gaohFWd+2T7Jb4m
 U+0h62WM0RysISG5qPx8Zfvd8QnCLgOLvg4/Vv/zROT7Qru2/y7CZdCadIB+wcA5oIE4qupIQUZ
 NbudV9TM1Ft7Tw==
X-Received: by 2002:a05:6820:1787:b0:6a1:4af2:f8e4 with SMTP id
 006d021491bc7-6acbbd869bbmr1728099eaf.31.1785420619076; 
 Thu, 30 Jul 2026 07:10:19 -0700 (PDT)
Received: from
 runnervmvrwv9.1omdfkmmqcju5ogakpplpa5tcf.gx.internal.cloudapp.net
 ([52.230.250.252]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6acbc55570fsm1545946eaf.9.2026.07.30.07.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:10:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Jul 2026 14:10:17 +0000
Message-ID: <20260730141017.3963-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730-shell_oom_protection-v2-1-be1de2baa83d@suse.com>
References: <20260730-shell_oom_protection-v2-1-be1de2baa83d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shell: add optional OOM protection
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

On Thu, Jul 30, 2026, Andrea Cervesato wrote:
> shell: add optional OOM protection

--- [PATCH 1/2] ---

> --- /dev/null
> +++ b/testcases/lib/tests/shell_oom_protection.sh

The lib self-tests are launched from testcases/lib/run_tests.sh through the
explicit TESTS_PASS / TESTS_FAIL / TESTS_TBROK / TESTS_TCONF lists. This new
test is not added to any of them, so how is it expected to run in the
self-test suite?

As a root run it emits two TPASS (exit 0), which would place it in
TESTS_PASS.

> +# doc
> +# Verify that TST_OOM_PROTECTION shields the shell harness from the OOM
> +# killer and resets the test process oom_score_adj to 0.
> +#
> +# ---
> +# env
> +# {
> +# }
> +# ---
> +
> +TST_TESTFUNC=do_test
> +TST_OOM_PROTECTION=1
[...]
> +. tst_test.sh
> +tst_run

The other tests in this directory use the metadata loader style
(. tst_loader.sh ... . tst_run.sh), where the doc/env blocks are parsed.
Here the test sources tst_test.sh, so these comment blocks are not parsed
and become dead comments. The doc block is also missing its opening
"# ---" delimiter, so it would be malformed under the metadata loader too.

Would it be cleaner to either convert to the tst_loader.sh/tst_run.sh style
with a proper metadata block, or drop the metadata comments?

> +	_tst_enable_oom_protection
> +
> +	(
> +		_tst_disable_oom_protection
> +		_TST_OOM_PROTECTION=0
> +		export _TST_OOM_PROTECTION
> +		tst_run "$@"
> +	) &
> +	_tst_pid=$!
> +
> +	wait "$_tst_pid"
> +	_tst_ret=$?
> +
> +	if [ "$_tst_ret" -eq 137 ]; then

On the SIGKILL path the test runs in the child subshell, so its setup state
(TST_DO_CLEANUP, TST_TMPDIR, TST_MOUNT_FLAG, TST_DEVICE_FLAG) lives in the
killed child. The surviving harness reports TBROK but its
tst_brk -> _tst_do_exit then cleans nothing, so external resources created
by the child (tmpdir, mounts, devices, cgroups) are left behind.

This is largely pre-existing (an OOM-killed driver skipped cleanup before
too), but now the process survives to report while the cleanup is lost. Is
that acceptable, or should the surviving harness own the teardown? See the
concrete impact under patch 2/2.

--- [PATCH 2/2] ---

> +TST_OOM_PROTECTION=1

The mechanism protects the harness (oom_score_adj=-1000) but runs the driver
logic in a child with oom_score_adj=0, the same value as the
memcg_process_stress stressors. In practice the stressors have the larger
RSS and are the natural OOM victims, so the driver child survives.

If the driver child is nonetheless the OOM victim (the case the commit
message describes), the harness reports TBROK "Test killed!" and cleanup()
/ cgroup_cleanup() never run, leaving the memcg mount and cgroup directories
behind. Is that residual leak acceptable given the survival goal?

The Fixes: 02961a7b2bb4 tag is valid and matches local history.

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
