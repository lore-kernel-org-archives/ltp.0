Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5476BC79FAD
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 10:30:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60AC53E931E
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 12:30:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 006913E2715
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:30:32 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7A7412010E6
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:30:32 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92edb00a64eso35613985a.1
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788949831; x=1789554631; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X3u2nvURgAuXWh4g/qg0NPVrjeB0kBSs/hmWsEyCFEo=;
 b=au8xovG5xgrDcUOXPQFasYAKiULaYzuINAnSCVTHuHOgrdNq0kEHilDMXA57+zRugn
 PETmOt58/hT50yoGdy7TxKtyNvMG9DknSzvsw8baHLxQgI4c4yvBWnYOnwIhSzvkLyFK
 4rc+dcbPQg/aC+varmSX6kRE7EWrN0F9TvPeH95HTQpcibct9lT6vzbPqvwxGAghtLZN
 VPeSBJbtNjN4WVxnWH2vYk9VA79bdBJ4kQ31NUMnm7J0tRwTyub7yawZ73zz2qyTuzyg
 gc6rBafm8whryFkxYugTQFxrsWpGy2TsrajUQ2avVyLc7ZvdqYfW6GC0SIsddFfEeh8+
 ddaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788949831; x=1789554631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X3u2nvURgAuXWh4g/qg0NPVrjeB0kBSs/hmWsEyCFEo=;
 b=NoPzyuQmrOokH2eszGe797Ln9KxTaNJwASM0biPKx+U9oWepSkrlwRyScixYwiyTVI
 TsytP2JFl3mVSHyja2dfC9ZYV2YPEsjHr2u25h7j8yCetqLHZPYvn5r0jWiIN8aTV66A
 kbrxYN18cNApU0P4S59wUgMgE7aHBF/PuO5CCvsX5U0wywDpldQ7etGS7lhrGD5I598Z
 HxQrMrrzg5RgK/4wuwVihgGDAZY0mnEcznxvdUMh30ybUq0u8DPayhLcz/cJRzpx5yfS
 qWy8USAofARBeQsjdEyunt8/ZjTA5arv659UdSRQjeKdcm4x02/2RwyS593mHEET+586
 IFbQ==
X-Gm-Message-State: AFuF++mILzjT8JuEipKxGegyakyKfitWJedabRnleDJ/fW0fUjCg+yIc
 dqSU/fdQS7YiL1Bh0sdo6Xwa1rJV3pJ9ez7OxQXtMJ96FWSm4R6nrfcnRyR8aYGv
X-Gm-Gg: AYBFou1Qf0HNqWaQwoF0x/qT45Y8rILLA+nq4U3fF9bcKYo4/+bFyJQpy9ab5ZSzk7/
 NC65PPWajFDLegOfJQcW6VWYb+nIgDOHxXQHVS2Pu8zK6x1NOejTaDXdIMtDysapRv8IsWXbRfD
 VgxMLpfxEgLzgLvDsXixUt9wDmmS9A2My5WF+k3yrCrY0MtCOZOi4YomA7KPkH4VCMgd/IbeJlE
 EPtECr51LOQci5sSNvgmJMmQQxrW+UlKyWgG5sEgwJGVa2sQuNDDeLBk/jnkEgDDdnnHnSPMcsk
 faKtIzZJOMtVPHxfuEXZaceMMCgIwT/0HNOKUmWc+FtyVIur6f4NBRfDGPQSNUKIWhAcdN+quhi
 /2kzaMkNajkEyP90DxhdwFfGB7FRv5V9S9H9t8re3EmJ+EGPucp5fceyEd8uqjPtWKXraft/bw5
 TQh+nHYLfWlDzLEbwk7wgdoirCjy+Vt4WpCrRtwygF1vy6nPNvEUxZoGXFLOI3Qubk8airA4u1U
 S6e1L2S0dWujI0qNUl3BTWpNo+fFROV9YbtNSahMj9ZS07B1DdwgdUPBR0ukCV69iEbjfJsyze1
 tg41IWUGXic=
X-Received: by 2002:a05:620a:b8d:b0:939:353c:cddd with SMTP id
 af79cd13be357-939803aeee2mr2895872885a.9.1788949831128; 
 Wed, 09 Sep 2026 03:30:31 -0700 (PDT)
Received: from
 runnervmejwal.igb3cs02yymuxlog0fzrenhqpd.bx.internal.cloudapp.net
 ([20.55.127.229]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939d3b2d010sm29858085a.23.2026.09.09.03.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 03:30:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Wed,  9 Sep 2026 10:30:28 +0000
Message-ID: <20260909103028.9066-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909085555.1601588-1-pavrampu@linux.ibm.com>
References: <20260909085555.1601588-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

On Wed Sep 9 14:25:55 2026 +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> Test hugetlbfs quota accounting with filesystem size limits to check
> for regressions in quota handling for MAP_PRIVATE and MAP_SHARED pages.

The empty lines in the commit message body contain trailing whitespace,
which triggers checkpatch errors.

> +/*\
> + * Test hugetlbfs quota accounting with filesystem size limits.
> + *
> + * The number of global huge pages available to a mounted hugetlbfs filesystem
> + * can be limited using a quota mechanism by setting the size attribute at
> + * mount time. Older kernels did not properly handle quota accounting for
> + * MAP_PRIVATE pages and MAP_SHARED reservations.
> + *
> + * Commit a1e78772d72b introduced MAP_PRIVATE reservations at mmap() time,
> + * so quota is checked upfront and mmap() fails with ENOMEM when over quota.
> + * Before this, quota was only checked at fault time resulting in SIGBUS.
> + *
> + * Root is required to mount the quota-limited hugetlbfs instance.
> + */

Use :manpage:`mmap(2)` when referencing mmap() in the documentation block.

> +static void verify_quota_map_unmap(unsigned long size, int mmap_flags)
> +{
> +	int fd;
> +	char path[PATH_MAX];
> +
> +	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
> +	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
> +	SAFE_UNLINK(path);
> +
> +	TST_EXP_PASS_PTR_VOID(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0),
> +			       "mmap untouched mapping");
> +	SAFE_CLOSE(fd);
> +}

verify_quota_map_unmap() never unmaps the mapping. As a result, this
tests cleanup on process termination rather than unmapping an untouched
mapping. Call SAFE_MUNMAP(TST_RET_PTR, size) if TST_PASS before closing fd.

> +	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
> +	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
> +	SAFE_UNLINK(path);

Use tst_creat_unlinked(MNTPOINT, 0, 0600) instead of manually creating and
unlinking files across the test functions.

> +	if (mount("none", MNTPOINT, "hugetlbfs", 0, mount_opts) == -1) {
> +		if (errno == ENODEV)
> +			tst_brk(TCONF, "hugetlbfs not supported");
> +		tst_brk(TBROK | TERRNO, "mount() failed");
> +	}

Use SAFE_MOUNT("none", MNTPOINT, "hugetlbfs", 0, mount_opts). Hugepage
support is already checked by .hugepages before setup() runs.

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
