Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9833CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:24:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D37CC3E9B00
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 13:24:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A19423E6C83
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:24:10 +0200 (CEST)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com
 [IPv6:2607:f8b0:4864:36::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4C07D1000A50
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:24:10 +0200 (CEST)
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-3537dfdcabaso5348211eec.1
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791977049; x=1792581849; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oNnY1l9JtTrmd3d0hnBYpuR74t5rBp7ed9arwSdC8SA=;
 b=njyHVtJOGwYG5f7pthKaPgxCASKnfXfvSqd/VVAzlBRsrD2rk+d2JemV8G95sobxQs
 XjtUO1iVyZOT2aJDFuxhHHFLZo+gBY0a5VJlcmK8E536xUrEM34vWEEk7UFvy71WV1mK
 aEVwhnECLWpSDcLOO9jQa/K4VKgDYEc6S+0Lc5ea9q6Vrlu2KU8+vSTplDOIOzsEel+/
 W015qyRY+eKb5UMOKpn3814Nta3FGByuyorDsZ8oFZ3E5N969fUCFvI/I8ZncHnnrDU5
 vdXe+/7AwPe+W0fTQYeK8gJ6eipAbDlIAy+VWf3kbmMxTme7fadBhHLzJa0e6tp6f8xW
 ROpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977049; x=1792581849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oNnY1l9JtTrmd3d0hnBYpuR74t5rBp7ed9arwSdC8SA=;
 b=PALe/jUXvHpGDQs9MRmbzfL3ILbCbq4iiNKzNiat95uhrH7MXJ7Vi6ow4CLA02+HCy
 NIWFy3Cd72xxQRA/c6BgtrMlt+fXeecf6TpOu+vEByesH3XRfifTDddtcNi710GkzyZj
 eTMLXPNOBtM526CxTG8PY86b/Fh66nDa472UhvRLUP5j/lh6ny8qj9DlxOEsdJ4e9t3L
 lrVmsEWNPZl0zQi7TVib/LI3lId8W1IPqEM1xsA7RmLQCm/rU7tDk9A8ThRTCN1ML8s5
 4g8j5h5xYe/K0EOk/1wseRAP5nxbn7i5HheQYoe+dv1PjpEinG4P3od7xG/YlP+KppYg
 4eTQ==
X-Gm-Message-State: AFq9FYKveo7P3/v3j3wLUB4foTbnTe9obILlTEtQJvc7wKf7eDICzXPW
 UcUrR1e970s24uUtfEEZBh/L7Yh2WCZlDmMndVRneVMdwN68hC3VNIBB
X-Gm-Gg: AYBFou31q3EIqTKUzMNFRbx88nhw/9rfgOv5VO789akQVF3wuRTgxk6PIWQCNVx7Wlg
 8J2Ohi4LvXe2fKYL508V7+4Rr4vRhLDDWrfU5cGsrp4hdQMZXxE7MToBtOpaj5loESbM5EF8S5m
 oekUFdc+9cCgsgjeCEOMWWpGmgcZxHQtSM05L8IXr+vQsb64dKl/2DDLyhMFUKcG3h2dFhylp43
 tapb3UcXBUju9hzkjB41IGWNwrOXi8GD8XUZvEmPUdpZVMYFSMJuOyfUWbRobINXhnmCR7ZYQdY
 V3qy6HSARwDXTwd8JZI5Qzvm9I4Q7h+bwNvwfelnLaP6pb3QSre+zggLTGRcmr65jwTC4++RtcL
 RbLf8MgsOKqnYoyDXePRtZ4JkYq7xtssxJ7WrSG9y3lLb3kqvCEOm2Yk9cVu3/+WNFn0ZK+PVPT
 R1DH7cGXKt5xYAe9CVtqi6BZ+6CgdsZtg7X1qi3f5BJJdnwIhnMMZD4MRFx/oMuTC99fuNgObXM
 3lC3qwX0k5Q5o2TPC0Fl/rbWHh083wTqyMR5HtVz1voyKWk8YHTIer9GHDUz4bDG1DdY9KweXIe
 kFLNAG3pS1uDkQ==
X-Received: by 2002:a05:7301:d195:b0:351:6409:25c9 with SMTP id
 5a478bee46e88-3537e11c9afmr19050074eec.35.1791977048262; 
 Wed, 14 Oct 2026 04:24:08 -0700 (PDT)
Received: from
 runnervmmprz5.2sftis5shwvehknfm3w5ec0hue.phxx.internal.cloudapp.net
 ([172.182.226.69]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm34729690eec.11.2026.10.14.04.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:24:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 14 Oct 2026 11:24:06 +0000
Message-ID: <20261014112407.9439-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014-fix_process_vm_writev_permissions-v1-1-6affee2da859@suse.com>
References: <20261014-fix_process_vm_writev_permissions-v1-1-6affee2da859@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/cma: Require root for process_vm tests
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

On 14 October 2026, Andrea Cervesato wrote:
> syscalls/cma: Require root for process_vm tests

> diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
> @@ -116,6 +120,7 @@ static struct tst_test test = {
>  	.test_all = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> +	.needs_root = 1,
>  	.forks_child = 1,
>  	.needs_checkpoints = 1,

Across all three tests, this skips valid non-root runs when Yama is
disabled or ptrace_scope=0, yet UID 0 without CAP_SYS_PTRACE still passes
the framework's geteuid() check and gets EPERM under modes 1/2.
For mode 1, have the target call prctl(PR_SET_PTRACER, getppid(), ...)
before signalling readiness to authorize the parent and its descendants,
including the sibling.
Preserve unprivileged execution where allowed and use tst_cap_action()
with TST_CAP_REQ when CAP_SYS_PTRACE is actually needed, so missing
capabilities produce TCONF.

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
