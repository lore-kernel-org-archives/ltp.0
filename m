Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D1DC5DF87
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 10:33:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 917993CE52A
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 12:33:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2C653CD820
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 12:33:32 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3EEF3200048
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 12:33:32 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-3896ccc93b5so714471a91.1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787222011; x=1787826811; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vPO15XFM4tlwvWzlH2/8kIVmpLrIKV1ww9dlP3FUJ+Q=;
 b=WF/V8HA8MhgzVHEyKrC1iItkgkBTAhu41jZizPTJRFL5hy4VyC2n5ZZsouYNuH8Ajw
 VRfDigkheqeOJO1QuRr2HOzkU7o7TxNE+OA+3eGrGevTfvGbFFdYpmaEkERJ/1VoR4z/
 41DG4lduIaJDMMTvjCxiaDsaa/a+dNFydGU31CYQ2Jqf2p8kNXykWcRpb6dOKtH2GcEt
 9ostXjA9bhcO+yWIRa3b3C0tXSNsr+PyB8h4k41ls3VKyFA/wIgw3mZ803T4xKHAyn+K
 8S5lZ8Kt+8apgyAy1KY7awW+m8m0p4cOTv1SzdxY4xwgXm70LEM4u1vbr8TBd+wMwL/j
 i1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222011; x=1787826811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vPO15XFM4tlwvWzlH2/8kIVmpLrIKV1ww9dlP3FUJ+Q=;
 b=mj48HIdoc3lF/6R05+Mcfy45Axu5T3VmKLBN2yA0rwwxDBa37IGTl+yj6BLyZlVJk6
 kwwiokQY2r0BI1cxFvL8Oz8RbUyqmUsGF5pZobahH96F+0S4MWqxggPNY4wuokLRO1TX
 MipnK1ChuyHFVtATkjvhZaCv31K17la0P2Yx10t5SG1uzo6BL4r2eFcSFjque3m61/Un
 VlkD71tMcmB6XV5KSq7wI5ffDs9Q+WSVBcK2rrlkOLSYHCeJccKHMs099TcPSNBzPpnK
 Nne0cI4d+aOOTU4hY0e1d1pNK1nJZ/A/CaXtl0mQ7qjlEzZmNlsOq0QWEuEhd3cF9hc5
 pm2A==
X-Gm-Message-State: AFuF++lhUwe4vCfjsVgQjGwz1aXFplwjvN50DHvclmMyvwx6O363wHSn
 Zz5yDUJs/Xpymn4yNf3Jb+vYlgyuTJGE/gNYHrRWENivJRbwfwUJAx0s3Fh7wgxwWRc=
X-Gm-Gg: AR+sD13BoAywWslSU29XxpV6Ex99mp7u6tDomaOWEHybp0X2XcFoLsl3mCUMOXXyM8q
 3N1S4sTWvunu3GnNhrkICR4+umduy1iTZFwZJmy8m0yQ8QaR3+aGVNZHluSO7050jW0JALn8Mut
 0P/2ce/pl3fMYwgPcAlDUoDP0fDwTJ6eJDugzLZfG6xqL+UojlKH4Ejy6BKwZSFjKgZL+aAzJKu
 ea17ducXQWPhGdYivHx1atQfMv071xnfYuhXbPrhA8LMdP4dDw2mR2e75RkBs+ccpWvzDpXHoxp
 aDOZITNy8ixwBWWAv7WfF3h6YXMsPFWvG9hsXvGneohHyBUBjbYlBWRScDmb1XWPKKJwGtSI3u0
 aPQxsiwjG+2wQ1M7oN3uCcn7ByamVji7yX3TBRnV98LtoicRF7ZXkMK0GlsYX3+b+7XxperN5I1
 JVVmsscJEAbd/GY8dRZIfUNjmEvtaJ64vfANOV905JyOroL0MImf7iy7lG3hgijIFKGywPBY4gy
 UhWrMoYOZP+QG2p+Laq7DGSbJET7qbiuQ9z+P4VZrc0uGou1u8UqYXwDaPVTYoc4Cfy2YFu1Oc=
X-Received: by 2002:a17:90b:258b:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-395810e9837mr23514533a91.14.1787222010566; 
 Thu, 20 Aug 2026 03:33:30 -0700 (PDT)
Received: from
 runnervm76f27.0ec3n2hyagzerni52n0yzw2ude.dx.internal.cloudapp.net
 ([40.75.131.19]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327cb5a9831sm8960715eec.21.2026.08.20.03.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:33:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Thu, 20 Aug 2026 10:33:28 +0000
Message-ID: <20260820103328.8356-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820042516.46631-1-samir@linux.ibm.com>
References: <20260820042516.46631-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

> 			hugetlb_after = get_proc_hugetlb_kb(getpid());
> 			if (hugetlb_after != 0) {
> 				tst_res(TFAIL,
> 					"Child %d: HugetlbPages after detach is %ld kB (expected 0), reservation accounting leak",

Could this use an oracle tied to reservation state instead? In Linux 7.2,
HugetlbPages reports mm->hugetlb_usage, which is incremented when a huge
page is mapped and decremented when it is unmapped. The original regression
leaked hstate->resv_huge_pages, so HugetlbPages can return to zero after
shmdt() while that reservation remains leaked.

The original test exposed this by making enough read-only attachments to
exhaust the pool. Here, an eventual shmat() failure would also be handled by
SAFE_SHMAT() as TBROK rather than reported as a failure of the operation
under test. Could the original reservation-leak oracle be retained and the
regression reported as TFAIL?

> #define SEGMENT_KEY	(0x82ba15ff)
> 	shmid = SAFE_SHMGET(SEGMENT_KEY, segment_size,
> 			    IPC_CREAT | SHM_HUGETLB | 0640);

Could this segment use IPC_PRIVATE? IPC_CREAT without IPC_EXCL returns an
accessible pre-existing segment for this key when it is large enough.
setup() would then overwrite that segment, and cleanup() would remove
another process's IPC object with IPC_RMID.

> /*\
>  * [Description]

Could the deprecated [Description] header be dropped?

> static struct tst_test test = {
> 	.needs_root	 = 1,

Could the high-level description explain why root is required, namely that
the framework modifies the system huge-page pool to reserve pages?

> +/hugetlb/hugeshmat/hugeshmat06

Could this entry be placed in
testcases/kernel/mem/hugetlb/hugeshmat/.gitignore instead? New test binaries
belong in the .gitignore in their own directory.

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
