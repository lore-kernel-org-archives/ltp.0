Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E87C531D0
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 05:47:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BE753E2D2E
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 07:47:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FA5A3E1FC0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 07:46:56 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B958F60067A
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 07:46:55 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 af79cd13be357-930914e4fc3so46173085a.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 22:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785390414; x=1785995214; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BcLtSwbWsv0bPXgmIT2Kz+apqU6YbojN3otGr4qeZUY=;
 b=DIOrju79/lC3JP8QWF23F7ptnX6Rvfcpmi/j/cg7k82gu/qZPFbbC4/TsKC7p+Y35W
 Xj1gDOSMiUbNvSLnbnLA+BgKTZHvH01bo0WTUKayt6uiT+RGlxvOHeYyRsMuFU2pzLWt
 SUT+DnGwkHqlDaNTLRM1ooxHJj8NaIB9d36bFvp3FWGjgCGtwvBv4L6O/k0OBURIEu//
 UJtEbGXvVU/A+5xL6IB34tiYm6eiVe0RFc9hM7SLhztofe0Dj516G2AzbLzrD7ffi27R
 CrIxNdB85oKSREtTb1uBQaKBr4Ke+aGhuWc/QGCf0wrYohXn9E0BuMKSGrxOmESqyuK4
 C8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785390414; x=1785995214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BcLtSwbWsv0bPXgmIT2Kz+apqU6YbojN3otGr4qeZUY=;
 b=AEHF91hW+wyUXG9BbljVKjpUfqgcla3KbYQMYXHWAkPswrIxDJQdMfAZTI28lBFGEQ
 KlwQG+R3j45EuE8GThnBt1iesTC3Uzc+EKEnkV/JIFr4cE7MbOXJsM3Wj3znGKbuAYAL
 k5yAKC7qs4aV2XlMEZqNDE1NZ08ak273r18R4Qkr2hgSwLMJ+byC+QSEvH83IypnsSrK
 uN7KgVcrULdaOd/BXp/kRsQ0isZiZagmSycIKobIGZLuITcQ0u4NEJO2cUDag93h/s2f
 16fjCx9CReiepKjNbfA4IB+YhyxiZWkcE3G+bCN7Gl1izfpjx9NafB0+gLItKgmUD371
 /r0w==
X-Gm-Message-State: AOJu0Yw2JvpRghxnnuS+3wEM/3leugMv+5MNaRDA5t3ENDmuBChbL7G3
 Wf2df6/G2lyy3SzbIruxuVnemABTz63Ap4oPyGtr7JduqR4xqjc7scr2CysJyG1Z
X-Gm-Gg: AR+sD131kSYnUrgMf7Tk/fLtBU+vs3Oc1Mga86ZJ/aw51bcnwlDh0aN+kvydFuUUc6i
 /dNo7aWiIHwbuyaaItMVcjdvbA07lGDjkX0UifSOnt2CaN7g2C5gtD/O9oxm8yPLiUKhlbLIH0o
 yg9bb2CdYzoKsF/2a6wsqykeuZlOCT5HcKJVZxpGazuuPe3wdwJrinY2RicPyOV5Uh85ATkNm3C
 A8ql4MRaD95L/kKOgIkSbw9S2tiUahwDEQJm+7V+7/3xLtFTXoaL3OkWVKTTWt0rFC2fgCoL2JJ
 hQyCtNFTcghBWrUiuwXj05s9xaAcg68T+WVPmNO9UKzD5CqSXSo/DeMJsf3wJA6sB1yVRQqXiHL
 t8XIPcWHCT9fUZmcqACI40CkjdmmzipuX9O0naGHd1mW/A3oBWlsGC6wqXtSQqMOtBXtmL4mwRE
 Lniqc6kkYJVdbnM9bj449UN5MkhegLoSMWU3RNWl2ETli34gdzaQ6am/LBHSHVy/4k/hdQs3yL5
 9EdUSMqSKSESufJvQZ+FVuVtQ8QrPYHGB5tM1ZEDYDBq7MEOILnok0SyEITxhDfRsahYEXjwyU=
X-Received: by 2002:a05:620a:708b:b0:92e:f1a9:7d39 with SMTP id
 af79cd13be357-93486f052f2mr113710185a.62.1785390414373; 
 Wed, 29 Jul 2026 22:46:54 -0700 (PDT)
Received: from
 runnervm7i58z.crhknial15sujdrxxwan4dnrna.cx.internal.cloudapp.net
 ([48.214.54.35]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e712fae4sm339507285a.24.2026.07.29.22.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 22:46:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Thu, 30 Jul 2026 05:46:53 +0000
Message-ID: <20260730054653.8948-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730044737.107415-1-sbertram@redhat.com>
References: <20260730044737.107415-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: fix SEM_STAT failures under parallel LTP runs
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

Hi Stephen,

On Thu, 30 Jul 2026, Stephen Bertram wrote:
> semctl01: fix SEM_STAT failures under parallel LTP runs

>  static void func_iinfo(int hidx)
>  {
> +	/*
> +	 * Return value is the highest used index. Our set is alive, so the
> +	 * highest used index must be at least our index.
> +	 */
> +	if (hidx >= sem_index)
> +		tst_res(TPASS, "IPC_INFO highest index %d >= our index %d",
> +			hidx, sem_index);
> +	else
> +		tst_res(TFAIL, "IPC_INFO highest index %d < our index %d",
> +			hidx, sem_index);
>  }

The comment states the reason why this condition can never be false:
ipc_get_maxidx() returns the highest index over all live sets, and this
test's set is live for the whole iteration, so hidx >= sem_index always
holds.

That makes the IPC_INFO test case unconditionally pass. The previous
"hidx >= 0" check was equally weak, since semctl_info() returns 0 when
max_idx < 0, so this is not a regression, but since the function is being
touched anyway, would it make sense to check what IPC_INFO actually
returns in the buffer?

IPC_INFO fills struct seminfo with the namespace limits, so semmni,
semmsl and semopm could be compared against /proc/sys/kernel/sem.

> +static int get_sem_idx_from_id(int id)
> +{
> +	struct seminfo info;
> +	struct semid_ds dummy_ds;
> +	union semun arg;
> +	int max_idx, i;
> +
> +	arg.__buf = &info;
> +	/* SEM_INFO ignores semid; but SAFE_SEMCTL requires an lvalue */
> +	max_idx = SAFE_SEMCTL(id, 0, SEM_INFO, arg);
> +
> +	arg.buf = &dummy_ds;
> +	for (i = 0; i <= max_idx; i++) {
> +		/*
> +		 * Bare semctl: unused/unreadable indices fail with
> +		 * EINVAL/EACCES; SAFE_SEMCTL would abort the test.
> +		 */
> +		if (semctl(i, 0, SEM_STAT, arg) == id)
> +			return i;
> +	}
> +
> +	return -1;
>  }

This is a near-copy of get_shm_idx_from_id() in
testcases/kernel/syscalls/shmctl/shmctl01.c, and msgctl will need the
same thing for MSG_STAT.

Would it be worth putting a generic helper into libs/newipc with a
declaration in include/tse_newipc.h instead, so the three IPC families
share one implementation?

> +	if (buf.sem_nsems == PSEMS && buf.sem_perm.mode == (SEM_RA | NEWMODE))
> +		tst_res(TPASS, "id and semaphore STAT info are correct (id=%d)", sem_id);

> +		tst_res(TINFO, "sem_id=%d maps to kernel index=%d", sem_id, sem_index);

Nit: these two lines are 89 and 87 columns with tabs expanded. checkpatch
as vendored allows 100 so make check stays silent, but LTP code is
normally kept at 80.

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
