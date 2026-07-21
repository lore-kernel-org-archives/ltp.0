Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9928C4452D
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 21:21:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C7FB3E95DB
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 23:21:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85D0A3E1B59
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 23:21:40 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 087196021EF
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 23:21:40 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 d75a77b69052e-51e47c6269bso40558541cf.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784668899; x=1785273699; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BaSHOTeafZqEan9qxVuQPkUVoRsBhaoP25HwN+lhgCM=;
 b=BraYvGao1Im7ktGaQq9gS+7wSlyCW8O/eN0mVO2eIZXm/yTl6HImQ14mEA3rWd9n9J
 Mo4hpeVXVXwB1WCgYngzsfuCW1nnbEQ4bDiWhUxS8EdZEZlQaH/MghhiU+k3+u9SOHqA
 /OGw9Sht5cechJ2DLntqnLYK+6ikwZEZMVUSrt4kjOd0uEFUDjiLVKxb03lCerx9sOB9
 yc7X/ONhni+ZyQVXmZJnuGDbxxbIxMwEXZiGuSYjC+fetN8A2zQowWHZ08Vn+50TsOy6
 Ob9QOUiBDL6ZNWkcR0ANPvmy3vrr9eP2OJs6ueNZotUKSPfbEzPU2MjHv9JMN+K4Y6jF
 LmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784668899; x=1785273699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BaSHOTeafZqEan9qxVuQPkUVoRsBhaoP25HwN+lhgCM=;
 b=az2IN7WmHTw0cDXZQq8BPEceLmBE78dfzUUdJa16NRcZxBxAGXdLkbJbVnhLZCUAaB
 143Xz/m5aEQ0vLBuqtoIAOw7VYbjHi8v7exzL72/JHEMmOHW7cAHPtBXipHdHoiLFT+B
 M6M6G4dKCpD/UW9NrkNItBMJ4JP1XgBf/g2c0HG55JY+rLj5iTDajLxq7MCwKkVHokNK
 oT+h15gZr+4845xoCwT5R+oOte0gukQMkZVv1+HA+GoDB/SXQCLXZddNbzSz7cSB6C/j
 vXLTAp9j4IjRFExQ/H+KS+rRTvJ5nZTdkG5zb9IWc00Xnaj20V93mjvlbVO31rHvkNLI
 05TA==
X-Gm-Message-State: AOJu0YwXAPzm65khOsNylDUZ4WvBg7rAKcLrRlQfZ2rFiC3wdXdkLihY
 ZCwLOCNZBncR/Qigi58M3c1NG7Ugr8LyFAfRn0mdI/i6JpmCTv8Hi9GK
X-Gm-Gg: AfdE7ckCWDxwATYaD1wKdqYHe+MnVomO/tZ1HBdUK6laltepIrsnnBcJT68y9PktNV+
 /iX57iQLD0HC6FYjKmaIQyQcny78UBNKEsFVyG8+GB91uAb6yIkDKpFHJItfsTV/DbOT22hEbuq
 A5kL3UyvqyskQ9APxTkwvJ9i8Vft9LECBaskedUxr93WUC82AtOVsrLB8SWSj+9KGpLCS3/ZchQ
 LmUfr+eee7DaNX/7ZV054VrUjtvfnI8cAi1oyBoSmRO03cPilfyx4xjXebAwOewHYEJox7W8WJV
 h1v+sOxbtRd9DH9rOiR3JHPr5ODzI/K9B0JtQ5ShMowWcZEujRV05NqltuuFlY8ZRvBuqX3zZB4
 0n7O7Li+pCUQpgBTdogYiHAL8nGeeqj5SXJ3/Zvjs77RBkpDBtcKxkFBzFQ7o5Wql8ON80ClTwH
 ml0dqIerKva/jwFq2eqO/ce/FKf1HGCeJpGzZaycY8ygIj5BDX0Rvq/d4FfWW+6FkXAeaWh+ydi
 w6oS1C1JYiceQuhMCI=
X-Received: by 2002:a05:622a:1b20:b0:519:5629:20a2 with SMTP id
 d75a77b69052e-5213d4b0170mr184897931cf.36.1784668898529; 
 Tue, 21 Jul 2026 14:21:38 -0700 (PDT)
Received: from
 runnervm3jd5f.moswaw1qwtoepjndkdztdbvrth.bx.internal.cloudapp.net
 ([20.102.103.200]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-527d402caf9sm2897301cf.30.2026.07.21.14.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 14:21:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Tue, 21 Jul 2026 21:21:37 +0000
Message-ID: <20260721212137.4220-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721202452.315581-2-japo@linux.ibm.com>
References: <20260721202452.315581-2-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Simplify to focus on CVE-2017-1000405 race test
 only
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

On Tue, 21 Jul 2026, Jan Polensky wrote:
> thp04: Simplify to focus on CVE-2017-1000405 race test only

--- [PATCH 1/3] ---

> Remove ptrace mode support from thp04.c to keep the test focused on
> its original purpose: testing the CVE-2017-1000405 race condition.

The pre-patch thp04.c has no ptrace calls or "ptrace mode" branch at
all -- it is already just the plain fuzzy-sync race test using
/proc/self/mem. There does not seem to be anything to remove here.

What the diff actually does is move the static globals (write_thp,
read_thp, write_ptr, read_ptr, thp_size, writefd, readfd, fzsync_pair)
into a heap-allocated `struct thp_state *state`, and add a new probe in
setup() that performs a real write() to /proc/self/mem and reports
TCONF if it fails with EIO (i.e. when CONFIG_PROC_MEM_FORCE_PTRACE or
CONFIG_PROC_MEM_NO_FORCE blocks unforced self-writes). Could the commit
message be updated to describe this actual change and its motivation?

> The ptrace-based /proc/pid/mem write functionality is now covered by
> dedicated tests in testcases/kernel/syscalls/ptrace/:
> - ptrace12: Tests that CONFIG_PROC_MEM_FORCE_PTRACE blocks self-writes
> - ptrace13: Tests that ptrace allows parent-to-child memory writes

Neither ptrace12 nor ptrace13 exists yet at this point in the series --
they are added by patches 2/3 and 3/3. The same names are also baked
into the new TCONF message added to thp04.c's setup(). Someone
bisecting to this commit alone would see references to tests that
don't exist. Would moving this patch after the two ptrace patches (or
dropping the concrete test names) avoid the forward reference?

> +	TEST(lseek(state->writefd, (off_t)state->write_ptr, SEEK_SET));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "lseek on /proc/self/mem failed");

lseek() isn't the subject under test here -- only the write() probe
right after it is meant to observe the FOLL_FORCE policy. Since
SAFE_LSEEK() exists and this duplicates its abort-on-error behavior by
hand, could this use SAFE_LSEEK() instead?

--- [PATCH 3/3] ---

> Add ptrace13 to verify that a tracer can write to tracee memory via
> /proc/pid/mem when CONFIG_PROC_MEM_FORCE_PTRACE=y is active.

Unlike ptrace12's self-write probe (which reports TCONF whenever the
write unexpectedly succeeds), this test has no runtime or
.needs_kconfigs gate on CONFIG_PROC_MEM_FORCE_PTRACE. If the running
kernel enforces CONFIG_PROC_MEM_NO_FORCE (or is booted with
"proc_mem.force_override=never"), proc_mem_foll_force() in
fs/proc/base.c always returns false, so the write to the read-only
page in the run() loop fails with -EIO:

> 		SAFE_LSEEK(memfd, (off_t)shared->test_ptr, SEEK_SET);
> 		SAFE_WRITE(SAFE_WRITE_ALL, memfd, &write_val, sizeof(write_val));

SAFE_WRITE() aborts with TBROK on that -EIO instead of the test
reporting TCONF for a kernel that isn't configured with the "ptrace"
policy. Could this test gate on
`.needs_kconfigs = {"CONFIG_PROC_MEM_FORCE_PTRACE=y", NULL}`, or add a
runtime probe similar to the one used in ptrace12/thp04, so it reports
TCONF instead of TBROK on such kernels?

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
