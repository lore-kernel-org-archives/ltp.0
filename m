Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC8CD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 07:38:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BCA53E591E
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 09:38:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A73393E1FB6
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 09:38:01 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E6A8260068D
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 09:38:00 +0200 (CEST)
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7e6da33a561so4878137a34.3
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781681879; x=1782286679; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OO0wed4674Ix0KaBsfKgyP2BaSQR35/FVMNmi/KCK/U=;
 b=ico5BLDqwQu2yZUSpfRkVNFZWI5idKU0oMvrDda3QWPF1a4AIRh8FgPOCDWKQBvSu/
 Mo76XdjOrmENqocDB0HUiE/47JkP7oUfsg7v/FpLnxE4YP/J+MUiBviGJQzhttuzV8TE
 NHylMwxxy8jL3sBDHygkuh0XEDfHrq1c2v76nG5c1YoDHVF1yHXvjq8Ha5GuHZzulCmn
 kEpq5Mg/6g0x8eIK8tX7ctsOoVI4XIicYbLsqSIu/f6NjZQ7UHuvfs2d2JYY3HHB3s8H
 pEm/qaZI+msWExrJ1aFz9vfA5cfxuPnWKvU9JoyxNgv3LRgR3wlLUtBurqxm30Tbsh9T
 +mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781681879; x=1782286679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OO0wed4674Ix0KaBsfKgyP2BaSQR35/FVMNmi/KCK/U=;
 b=ss60N5bKNDdBspnGo/vPANSoLor9yiKOkhOYHqiVAwgrhcf4cKk/qyUwGVLc8MkP0R
 fkZ0FKRNFqoWaE4INGpuIVX4CX4tViGfPXEHMAv2w1d8FkoxOhYh5xjXsRso0+TTbYxM
 zDPHoCdzg/tOcnNHzDwK4acVt4hXEeuAG424BB+MTZItrCPZRBc2Y9fTEayP2uvgnnEl
 InKWNURureK8+J6pk5t7uTAmctNFBGRDK9StAzaFyAuhlO5QFLGaJaWXQHW1OjfkIROA
 LTC3zysL5tPkoLoT7Lekf5spfvkDq+8nuLquhPyJA9NssZjbfIswJlP0xZM3On1mfUJF
 kjjw==
X-Gm-Message-State: AOJu0YxhlX4Rz41CVQ8qhTtH5NdwOONwxynQRnA2+IvJm0rizkG7hMqn
 Mzho0qbKoTAkYy2dyQLzPi4fAmyd1nOstJyvztH4m88rCJdVOflvts46
X-Gm-Gg: Acq92OHj6cOp1nnXGFNiT0SrUa5c3XxTEO+SdS2sserxY5spv7RCw+mPHKnwiWyU+lo
 k8uAXLKaKJ2kgmPgldQMFiWGT+YD0nU4n5+htsDeeST02TaiUZy9FLahVTRDAMSZfaEf1ajI0im
 lldO4qRRu5tmDJLhgZZNL8oJmwF7IqTiEA+EioMyvBKn8dKB0yqwrsaYx7AfxyrObrbKVORiChq
 SaS916pRBpr3ELmRNuN9pa4s21m1/gUB4Yrxe/XnyCBEk3q2P8KKqhlAXIfwecC4GW6i6zn6WKx
 d6fG78uKYMyMgcZA69PLhnjwOtpzOurh3xStJVE18MSZW7e9czY+zx5sGTafKklj2F1EfyIHR+d
 SFEBi2ZdOiEr3rySftztwgxUt5qgSD4Zs5BVSCUoCkRdTihlxN06FJ0p9MlpgSmp4PVw72TVK34
 /dQKqjTOF+PSX2SIMqTw6RsDG5PQS1HKovy0xVXnT831N6RMS4axjy/+PIphAJH6yRmoBMbo3kd
 6Vy3yBISuh9dhR8NYLF8DN1cx++Y6fypU91u9uHSA==
X-Received: by 2002:a05:6808:c2f8:b0:484:afc2:eee3 with SMTP id
 5614622812f47-48942850bf4mr2239092b6e.5.1781681879220; 
 Wed, 17 Jun 2026 00:37:59 -0700 (PDT)
Received: from
 runnervm1li68.55yuz4mkmnnebh4brhyc2ym0sh.gx.internal.cloudapp.net
 ([172.212.169.150]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f5a11efsm8697783a34.1.2026.06.17.00.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:37:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: AnonymeMeow <anonymemeow@gmail.com>
Date: Wed, 17 Jun 2026 07:37:57 +0000
Message-ID: <20260617073757.3983-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616210448.12175-2-anonymemeow@gmail.com>
References: <20260616210448.12175-2-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify20: Skip FAN_REPORT_PIDFD | FAN_REPORT_TID test
 on v7.2+
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

Hi AnonymeMeow,

On Wed, Jun 17, 2026, AnonymeMeow wrote:
> fanotify20: Skip FAN_REPORT_PIDFD | FAN_REPORT_TID test on v7.2+

--- [PATCH 1/5] ---

> +	if (tst_kvercmp(7, 2, 0) >= 0)
> +		tst_brk(TCONF, "FAN_REPORT_PIDFD | FAN_REPORT_TID is supported "
> +			       "since v7.2, skipping test");

tst_brk(TCONF) in setup aborts ALL test cases. The second test case
(FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME expected to
succeed) is still valid on v7.2+ but will never run.

Should this be a per-test-case skip instead, so that only the EINVAL
case is skipped on v7.2+?

--- [PATCH 4/5] ---

> fanotify21: Add test variants for FAN_REPORT_TID

> +	if (TST_VARIANT_PIDFD_THREAD) {
> +		fanotify_fd = -1;
> +		thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
> +			FAN_REPORT_PIDFD | FAN_REPORT_TID, ".");
> +		if (thread_pidfd_unsupported)
> +			return;
> +		init_flags |= FAN_REPORT_TID;
> +	}

FAN_REPORT_PIDFD combined with FAN_REPORT_TID is a v7.2 feature and
v7.2 has not been released yet (latest stable is v7.1). Per LTP
convention, tests exercising unreleased kernel features need a
[STAGING] subject prefix and should go into runtest/staging until
the kernel release is finalized.

This applies to patches 4/5 and 5/5 which add FAN_REPORT_TID variant
coverage.

Verdict - Needs revision

Pre-existing issues (not introduced by this series):

- testcases/kernel/syscalls/fanotify/Makefile: per-target CFLAGS is
  placed before testcases.mk instead of between the two includes.
- testcases/kernel/syscalls/fanotify/fanotify21.c: `fanotify_fd` is
  initialized to 0 (implicit) and the cleanup guard uses `>= 0`
  instead of the LTP-conventional `-1` init + `!= -1` guard.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
