Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE12C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 18:40:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D904C3CEDDE
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 20:40:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CADF3C2953
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:40:05 +0200 (CEST)
Received: from mail-qv2-x02.google.com (mail-qv2-x02.google.com
 [IPv6:2607:f8b0:4864:33::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DF141100036B
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:40:04 +0200 (CEST)
Received: by mail-qv2-x02.google.com with SMTP id
 6a1803df08f44-90c4d223e0bso923976d6.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787251203; x=1787856003; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJwCuvlvPDU7inOhd8wLdAxnjXtd0AAmfbu/9+FnEW4=;
 b=RLtlQQf2627BMLzPf8vpl4G6WQ/pZzajvICBl9/nFAfBEa1CK+X2g1r+fi7F+eceZM
 TsJ9GLvjC5VRz572EKKPVGDZBcpGHB/ofZ8MSKm/mxHWkjfy3sNNP6L/fmmJIt9dMD3N
 gORMmotWLDHjvS6IPpp6jWatvOD/WketXN1eg6H+XZofyErSFPKLulnOZ1X4ueg6vJtT
 3UlvVfihhcV528XKcn4T5Ht8bD03qOhDr5roRx4FV4YPVmHDQKggEfjLSu8KD+0OV8q0
 ssHRjDvG4/hoLlM1OYZHtJRCLxd8b1n49eWq7xk1PcKUvdEOhy8blyrANWnaEk31Jc/E
 Lrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251203; x=1787856003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJwCuvlvPDU7inOhd8wLdAxnjXtd0AAmfbu/9+FnEW4=;
 b=czaJmAxRzMim22/Mr4D24pyQmCr8P4PGqnUBld2ZmWSAB2GUBYHONvmEpAkVDE7XuA
 ATBsoMsRmJN3zmKM/cVD5u8OTctBB5hpGnTnLjw8H2wNXlxtvDX/c+Pu4eXcQ1ew79uD
 4WheqhXf7mdmGirxNIbDvUY42LrOWNeJol5FuKWrqpMrLrH8DnTYdofyuySn+KQzXgKp
 TiSFAnmGMWSJKRWGIsT7jgaPjYygTEq7Xi7LoifZJkvUk6dT6rrLPlLiFYPWdbleOXIT
 ZddO5uekdwAF2OApALj18mTBdftvM3YcifKwo3ry3aOX3kcrbIgUB90WbUBmcGVtjtm6
 S5uw==
X-Gm-Message-State: AFuF++npWGS8lw11FpKB5PuYJSvQfPTZ+PHV2uKHAzu+Jc/iJLaAl+CK
 rcISEBhkbxeqPsSq2VJ5rznmDhl0qaC2W/g+5tG3rY5JVtbbWZiRFd40
X-Gm-Gg: AR+sD13mBqWfn/HqpzJgtsbBCuoIjFJZrnW3N3uCHcI/dGgA+7czsHPh+bI5xdsSoE5
 H60Hv1j1vfXhcMf0eKbrXOP/oVB+zlbagLfGuROGcgtKvHnuCDK0KKXqe1RvPZ5EpPjparOVyEm
 rqq2D9nWTFPXsRTB9hEbtC0OmM57eSXYgcsjQ5dEKkDLrDzx6LUvKOF7AcKFdtqJs/D9JspVycr
 RVfp4/e1zLKBQpd5QSoJwO135IechHUHYwo12Vd80jhm4vVcsFuQAwWdxFQbPR6vxgkA2LViFXC
 Dge8niGTqtOp/ZLqlza99d+V3wP4CU9T19yxZwMdrHssSMhJiRx/grAUcH+3M+lwARUfKRHxpXf
 p8pvEVOvS4G8QZ47iQUleomzXQdc6QBKyugHuOBCKIWO7Qj/BXlx4uThPxXAF0zA4XhtfzPDAdp
 KfCEY+IoN70IzSuj8Q19zI7scq017MEOsTQsNYjnXp8z0EiqGIwK10t0AndG+cQgYAF4R7ZQTkG
 HAOQvzOyH+Q/WEXPF0x/ecl6K07mFr54Y6AJ+PHO4VU19qh0ozVNwoQp4SJskNbiRmeJvTBNXHA
 YogZHuSHIQ==
X-Received: by 2002:ad4:5ce6:0:b0:8f3:e97:59be with SMTP id
 6a1803df08f44-90c80c66774mr2076326d6.17.1787251203459; 
 Thu, 20 Aug 2026 11:40:03 -0700 (PDT)
Received: from
 runnervm76f27.t44aakfgbf0ebggs33ekaeudia.bx.internal.cloudapp.net
 ([20.55.86.177]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5eec934bsm44784686d6.15.2026.08.20.11.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:40:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Thu, 20 Aug 2026 18:40:02 +0000
Message-ID: <20260820184002.4137-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820125552.47435-1-samir@linux.ibm.com>
References: <20260820125552.47435-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugeshmat: Add hugeshmat06 migrated from
 libhugetlbfs shm-perms
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

Hi Samir,

On Aug 20, 2026, Samir Mulani wrote:
> hugetlb/hugeshmat: Add hugeshmat06 migrated from libhugetlbfs shm-perms

> #define HPAGES_IN_SEG	4
> #define MAX_CHILDREN	128
>
> 	iterations = MIN((long)tst_hugepages, (long)MAX_CHILDREN);

Could the iteration count retain the original test's exhaustion guarantee?
Each leaked attach reserves HPAGES_IN_SEG pages, so a pool containing N
hugepages requires more than N / HPAGES_IN_SEG attaches to expose the leak.
The original test calculated that value plus one.

With this cap, one execution can pass without detecting the bug when the pool
contains 512 or more hugepages. Even the "-i 5" runtest entry is insufficient
at 2560 or more. Could the count instead be derived from the pool and segment
sizes, including the final attach that exceeds the pool?

> 			if (shmaddr == (void *)-1) {
> 				tst_res(TFAIL | TERRNO,
> 					"Child %d: shmat() failed, hugepage reservation pool may be exhausted",
> 					getpid());
> 				exit(EXIT_FAILURE);
> 			}

Could the child exit successfully after reporting TFAIL?
tst_reap_children() converts this nonzero status into an additional TBROK
("Invalid child exit value") and aborts the parent. LTP already propagates the
child's tst_res() result, so the regression should remain a TFAIL rather than
also becoming a broken-test result.

> static struct tst_test test = {
> 	.needs_root	 = 1,

This is described as a regression test, but the test has no .tags entry.
Could the corresponding linux-git regression fix tag be added?

> +/hugetlb/hugeshmat/hugeshmat06

Could this binary instead be ignored by
testcases/kernel/mem/hugetlb/hugeshmat/.gitignore as /hugeshmat06? New test
binaries should use a leaf-directory .gitignore rather than the shared
testcases/kernel/mem/.gitignore.

> /*\
>  * Tests shared memory behavior when multiple processes attach to a
>  * hugepage-backed segment with different permissions.

Could the exported description explain why root is required? The test sets
.needs_root because the framework adjusts the hugepage pool and mounts
hugetlbfs.

>  * pool.  This is detected by using raw shmat() in each child so that a

Could shmat() use the ":manpage:`shmat(2)`" role here? Syscalls in exported
test descriptions should use their man-page role.

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
