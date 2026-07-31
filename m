Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F6EC54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 11:52:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B827A3E71D1
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 13:52:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8356F3E25FB
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:52:18 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 105DF1A00CA9
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:52:18 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8fda6ac0586so4066316d6.1
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785498736; x=1786103536; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YyAmqFwuMUXfZDDwkftfQzo9zrGyrFBbR1/vZmYvwx4=;
 b=LoWAK1caGJEo7zzqAUGUL2SB2GOqcUt2tuvg7SlgHkeTYV0CwnhuWEH7TMAFuL0IUF
 5LHq9oyCHytU9EdsHdtnLWa0ygMFRwCdmIue08uHHLXVIOQHFcPJQkszmttKWmvHR8qg
 N+sq0iEKmR1MS4FKpgPRTlAm7eLnt6bubIKTQjNspz2nEHbFxxXv04iepYTIyhpBF70G
 vlcIjq9fDdyUoAcfNpoTUGCLjsTwFncgsctfGoYzBWfQJud1ezwtF0dWRKHITTXijjEL
 YekSy9XPavEgoG5trfPg26ymlH2AUX55X7/Q+moRw0p4xlgF1LvknhhUKiMv/5oJ/C9J
 ansQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785498736; x=1786103536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YyAmqFwuMUXfZDDwkftfQzo9zrGyrFBbR1/vZmYvwx4=;
 b=Sy9Z1wodacOB1nvYqclD9iu0Pz04jSna3b08oQkI6N05bjZjpONTD4BUz7r2ur8tIq
 8gdBQnUMAEgvmtF5eMfHuyozombIudiuybxWNdhN+GJnnzBtqjmppDaDVv5Xs4nbBvtP
 h0vSKMNAHDfsnE8AVKZFJDvk7xAx3msxxvkT2T4m992qbC9kVaR3o++snq7ls79KWVsh
 zN8MnJeWxrFLDKFiA/Y4uC6Um+W/h+/7ib/MeZqpo3+W5khpKmjFx/Kq6ErjNowA7ipI
 nQu83DTv6gW8VDOb4/QJd4v0DEdEdSzSnm5Uc4vTuWVhcy9/pDtnprG5ytVW2l8NnKQT
 HVtQ==
X-Gm-Message-State: AOJu0Yz52xFJLTNqRX5s9sd0ptbdUBjLL1hwM+CzopDEh8/qk2w/q7+l
 TuS8uv2Q133uKhCMlhLcbs5pzbmNsWAFo1PBG+mevVCkxKRiPojupbhL
X-Gm-Gg: AR+sD12BIJAFJ0DOnBmm91V1zGWCELsXmWGL8CGOg7PJFSnUzF7S++fIDzK+Dj8UB0o
 6JX1gkNXbQprRwNZHY31a/RQ7Ix2dWDKi1s9dKmSI0V6rDe8dHTjaxmMDY6ftrIv/PI+aM8wmUg
 kiUwN54tENScGfhy33yXWhsNEzBi+/LZY+ESd+7r13I0iFdhO76phdDmm84nwRaM8lltZJHiKy9
 CZY7NXKw30530NQBv2ODdHg++CLvcOM+v7gGUZX2CQgGL7Qe7nNFJbEUkjFiSX1IJnjud63EFn9
 EcPwmhWyXsCxJBoOtpO8NmCgo/ZWgHIBW5NbqmjfZSC/WGazikE6MhG5s2HK0WxocCiQHSYcBkg
 HfmXG+HrG1pcc6qMHCq91dhnZwg2NgvzqrFBI8FN9JjX/rLOXT8L0Y49axnwzOg3L9vBPvWoHeG
 d94eiGWCx0d7lzBe37+kqpg31roTPH+S2iMeDo+aRjdnaNtPvX8lJq+nQVHjFg+CpdWKLXQ2gK1
 lxK6mCXcNCZ1vMasc4pPOtHun2i2PINfbu8YBmybuYo3pViv7L64hjiWQPGigYbral3VX0GyTLZ
X-Received: by 2002:a05:6214:4908:b0:8ef:31b6:74e8 with SMTP id
 6a1803df08f44-9084219de9cmr30790496d6.10.1785498736541; 
 Fri, 31 Jul 2026 04:52:16 -0700 (PDT)
Received: from
 runnervmvrwv9.4spcgtrrpnuuxis0joratmmoqc.bx.internal.cloudapp.net
 ([20.102.102.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908435ed43esm8610056d6.40.2026.07.31.04.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:52:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Jul 2026 11:52:15 +0000
Message-ID: <20260731115215.8956-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731105132.187177-2-pvorel@suse.cz>
References: <20260731105132.187177-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Rename function check_kver() => check_min_kver()
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

Hi Petr,

On Fri, 31 Jul 2026, Petr Vorel wrote:
> lib: Rename function check_kver() => check_min_kver()

--- [PATCH 1/5] ---

> Preparation for a next commit.

Could the message explain that the rename distinguishes the minimum-version
helper from the new maximum-version helper, without referring to a later
patch? The current body does not explain the change independently.

--- [PATCH 2/5] ---

> + * on any stable release (test with ``min_kver = "7.1"`` runs also on kernel
> + * 7.1.5). Stable releases are compared as expected.

Could this example use ``max_kver``? As written, the new field documents the
opposite API.

> +	for (i=0, dots=0; max_kver[i]; i++)

Could spaces be added around both assignment operators to follow kernel
coding style?

--- [PATCH 3/5] ---

> +	.max_kver = "6.10",

Could this test be allowed to run again on Linux 7.2? In that tree,
do_open_execat() calls exe_file_deny_write_access() and returns ETXTBSY when
the executable is open for writing (fs/exec.c:800-802).

A permanent maximum version therefore reports TCONF for behavior that is
valid again. It cannot represent the temporary 6.11 through 7.1 behavior
window.

--- [PATCH 4/5] ---

> +	.max_kver = "6.10",

Could creat07 also be allowed to run again on Linux 7.2? The exec path makes
i_writecount negative through exe_file_deny_write_access(), and creat() then
reaches get_write_access(), which returns ETXTBSY for a negative count
(include/linux/fs.h:2813-2816).

This maximum bound suppresses valid 7.2 coverage and cannot describe the
temporary 6.11 through 7.1 behavior window.

--- [PATCH 5/5] ---

> Because the above flag combinations are already "tested" by the tests
> that use them and we don't have any tests that >= 5.10 has support for
> FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.

Could this claim be corrected? Other tests exercise FAN_REPORT_TID and
FAN_REPORT_PIDFD separately, but fanotify20 is the only LTP test combining
them.

> +	.max_kver = "7.1",

Could the first case instead expect success when thread pidfds are supported,
while retaining the second valid-combination check? Linux 7.2 now uses
task_pid(current) for FAN_REPORT_TID and creates a thread pidfd
(fs/notify/fanotify/fanotify.c:843-849 and
fs/notify/fanotify/fanotify_user.c:906-913). Skipping the whole test removes
the only coverage of the newly valid combination.

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
