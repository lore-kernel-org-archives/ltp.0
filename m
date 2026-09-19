Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90859C982D8
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 17:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7AE93E723D
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 19:56:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0D463E71F7
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 19:56:24 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE394600A75
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 19:56:23 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2dd9bce707bso7685545ad.1
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789840582; x=1790445382; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FSQlJsz6mbPyMs59fJmHoQoUSw4caoIFyk5NNfqOm2o=;
 b=C+1fLLc/LQO1Wwb8LYNmR/G2TyE2eiscqGEgSEl/4n/xoVYOV9mZDpzdXhlkQMUSS4
 hYLWt2nhqgwwT55IUTUg3hh949SKeXAUN/rEfsd5tMWT3jNyYB8wK3iz4XqmMOp6cTcq
 Fhewkcq7FpudPpSUrZ3KRFMn0CbDV6HQgiiLfXaeQ3cx/maV0RQZNCa6ZU+s/d3Xu4RL
 Qo7mmpQiVwqGdt31m0tkMNn90QVaYzhHSpq4ipVoVfvoU4UwIIpLmNierFN/19gPBaAf
 +qmEEdniUzVUvosy9xv1Gr1HsTjd2MO9JGL6tHQK/NE+sOY2eUrwlR6XHLvQaCDDDoCN
 m30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789840582; x=1790445382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FSQlJsz6mbPyMs59fJmHoQoUSw4caoIFyk5NNfqOm2o=;
 b=WFnSkr2n1pZYxYWN+x7iaIrjGvaiQcdizZ+lUwnkSG4PVjag3YIdUSJ1Dc0/G1UVN/
 rf0M1JScffJOxAVH5qZDqefz7TSFFElKcpeNZLAWQUX36CxAGYOYkG0jcTGHC+d7TMA8
 +SxuF0OsWTotmBVOodPh7ZcattieKLfjOPd/Bt6tChzWHqL8nMEOk+jYpgu18qy+GiH5
 nsK//H4ZJsheXmD2vBe1EmIwg3vpBp3E/4aD9NxL7orzexL5kjHEGFtJ0WU7rMxlMWuI
 Nzh5RyRwA8IgWERoXLqomSrmSyrocDtbQBR6CSpHAvYLCxqDEIGGByv5wHg+RW42nEOw
 Mrzg==
X-Gm-Message-State: AFuF++kn+1HNz/WfR9jlBSHHjm6DbDPgkGBmtNybh7ed58L479Z0XLKJ
 MMwgsdc2/7EjinQRaA78go/T2ZNn0rz0fxX8CaB/oNH+YN+Jj1yv3aT5
X-Gm-Gg: AYBFou3IizbHa8jw92+issE4aSwPq0zXxoDJH7yRgYWDu7FAFhgqD6mkRnbffG2pV4I
 autL70/IfoN9MswwDYh+mmj9psurV5PRsbeXmes7pKRA2D8yInL7sVFBM5221dv3+DbvhhKoe4d
 iUBFoUahnxND5ycAOtbSwWeRwXjF85q5xsWJJD/2LSdDvo3HcOR2PfTQ4pUugTLyMnRRDI8LGTX
 eydKJxWU+moqSv5QX3+Sk/YtPVELBYFed12PSL0fJO6cDFEp4/danLA8yqvZC0M3XLxBoZrhdM9
 5ltWVPbhHJ/IE4cV5fyDglmJdGlGpdvXELnANhPd33c7VAq+LkyF+gRxRoJKORDFmpQmNZACHmr
 E5OJ29F838pDscUe8oHbD5gvRlyqmk23m7RSU+n/KcSrU/T9Cspwo5Bs71jULpCVF0Iya/8tVu9
 rZHQ5pOAuvR6LsNViVZx/7i9v3nsJvWFX0fY2hnQR4hTNg1O1QNFhSECs3RFnl9ztnSF2/3dG0g
 34vCg7Tc2wQ2L+iBC8+CQQMeQb2vNpWF6B4XHKb23EgipmlY9ZCVXLtXdzbZcGCiAKPGPElXoSj
 5TeX5kuQ797u
X-Received: by 2002:a17:903:4590:b0:2dd:c0ff:e729 with SMTP id
 d9443c01a7336-2ddc0ffe975mr40275875ad.59.1789840581973; 
 Sat, 19 Sep 2026 10:56:21 -0700 (PDT)
Received: from
 runnervmlun5p.tfwys50uckle3nqgfeiqwd11rb.dx.internal.cloudapp.net
 ([172.185.55.128]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3318744dsm6803869eec.20.2026.09.19.10.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 10:56:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat, 19 Sep 2026 17:56:19 +0000
Message-ID: <20260919175620.10016-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919151602.1039825-1-pavrampu@linux.ibm.com>
References: <20260919151602.1039825-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/shmget: Add shmget07 to test SHM_HUGETLB with
 raw device read
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

Hi Pavithra,

On Sat Sep 19 20:46:02 2026 +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> syscalls/shmget: Add shmget07 to test SHM_HUGETLB with raw device read

This test exercises hugetlb shared memory functionality rather than the
shmget syscall itself. Move this test to
testcases/kernel/mem/hugetlb/hugeshmget/ and rename it (e.g. hugeshmget07).
Also, replace "raw device" with /dev/zero as /dev/zero is a character
device, not a raw device.

> diff --git a/runtest/syscalls b/runtest/syscalls
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1596,3 +1596,4 @@ shmget06 shmget06
> +shmget07 shmget07

Move this entry to runtest/hugetlb alongside the other hugeshmget tests
instead of runtest/syscalls.

> + * from :file:`/dev/zero` directly into the shared memory region,

Replace :file:`/dev/zero` with ``/dev/zero``. :file: is not a supported
documentation role in LTP.

> +#include "tst_test.h"
> +#include "tst_hugepage.h"

Remove "tst_hugepage.h" as it is already included by "tst_test.h".

> +	shmid = SAFE_SHMGET(IPC_PRIVATE, size, SHM_HUGETLB|SHM_R|SHM_W);

Add spaces around the '|' operators to follow kernel coding style.

> +	for (i = 0; i < size; i += hpage_size) {
> +		TEST(read(raw_fd, shmaddr + i, hpage_size));
> +		if (TST_RET != hpage_size) {
> +			tst_res(TFAIL | TERRNO, "Can't read full page from raw device!");
> +			break;
> +		}
> +		tst_res(TPASS, "Read full page from raw device");
> +	}

Replace manual TEST() and if/else reporting with:
TST_EXP_VAL(read(raw_fd, shmaddr + i, hpage_size), (ssize_t)hpage_size);
Also, update the message to refer to /dev/zero instead of "raw device".

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
