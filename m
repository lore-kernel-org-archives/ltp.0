Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF755C54FD4
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 20:20:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 298A03E729B
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 22:20:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89AF33E1664
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 22:20:28 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 200491A009AC
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 22:20:28 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2ceb5a39c48so4702155ad.1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785356426; x=1785961226; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ol6+uYHL3Cgo84dS4CUBA0NhLEK4Bo7G0RnEpBZefnQ=;
 b=f1K/S9nRpJr0CM+hxJMOme27XXzwgT44cwnYDXPA/1eSgLc3Ev+wUkfoPh9CbILVp3
 ttypVW0Kr16ZPU6ndtX0mIU43lVDfS7aByqrKGe5u0q0LuO1Mu8Ui6a6q16sIK0CEzSp
 /sflwVotPeJ6yhq+sgzz5iFAeSy5NiLABCwosvZCVMmwU+cdNp0heyzmRQgRncHi54G6
 GtAIeEXfBo1nKFs3T8ZoVcFj1LHbACQN5K4KsqoNvzQqve0Mr1c4fYuncVFquBHEvdKA
 UPkw1BMq4x1rXHsmWqtGFTj7cpbtDGmVyG5GL2q9CtiKc47EE9wK6z+3YnEwOeVn1oxu
 Amhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785356426; x=1785961226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ol6+uYHL3Cgo84dS4CUBA0NhLEK4Bo7G0RnEpBZefnQ=;
 b=jDNVn88L0XeyOiQIlj2Oz95LPaM1Px/e4HloNADAScWITokF4EMyrx1KrDUUVeCCDd
 TxDfRf44KxU5d0/CHD4296p3A8eocMGeA/a6vjWJzoieDXVmlVq5KTo4xkgUJnReW1Jp
 N/JwyFBmfGtgBreqjIWfftwA9GVZ1G3dCHboq8codt3JQ/xkDSqjo3guc46fYHSNvQmh
 VXlHgD4hS6/HncoFOPSm4z/mugT1YzJ/pTcDCobvEbit4V/kRJrFVhxMZMM9OIwr8Yw5
 ao+pYNvEFy7LxB6yJerOzGUAOHBfV3MafAE5bdW+QRwtGj338eC8Kx6H86y/PfjA4Ciw
 fZ+Q==
X-Gm-Message-State: AOJu0YwfQtpNI+dZ0pTK/BFXoEeT3KMwPV1NzEvAOThQ8V9/SQNFPV3b
 7X9x62jyFwFMyAU9tE1N4frPV7Npl0Gmc6uMKSZ9pJKZOzQ3B7fvL0BVWnTuSo40
X-Gm-Gg: AR+sD11QKbcm9pZxKZPWYHw47y87hMFjvAm5wiACVhUm8cCdbOzAin+lhVT2GnETPa1
 zP9ya+qjiMij8+ykJR3jVgaKvyob9lEWq1B0UXIdGGQDw3zQl8C0KwWkkgpRJbgVwkbuJ/J2sjN
 m6jq21QtBehhd51E6knSj2kakWai4Df6bJKnIr2q0Ec6sMphMBv/08vI2B4xfOTyCRyv8O0+pgY
 dox7QywDQkuNjnOaZtwj9fG3aOTh6MIWq/wFaUXfHNnRUI6kVURnX7o4wbRgrElGZosbZp5gwcu
 7Qwycxjg8UmnD0HthSlPBsZoghihbbJzLAW+lg/He/+AZsb6BVmNi9RjE7F47A3KbpfRRwZJnma
 W40zPKJd7G5MZElkOiYO0WDWkoFPOb0uEu6pTtUnrnPU38IPYRk5j7NKPcqfgRGKDCcmofHsKwb
 NXH7OqbU/Cw+vfT0AC0UytXurOdE36AFRhv6kFOmrMdi22K44RmrzgARbAsvqY2B4vOg9DooETg
 QSYYb/CN1NMoA0N3QkfFQ795meJfzPL/OOXkg1eq2fmTGXcsSzXheKUoy1Y/IGJeDwrJYg5VQM=
X-Received: by 2002:a17:902:eb8d:b0:2c0:e2ea:6b0c with SMTP id
 d9443c01a7336-2d0339f1126mr3469105ad.21.1785356426235; 
 Wed, 29 Jul 2026 13:20:26 -0700 (PDT)
Received: from
 runnervmvrwv9.bdfn0epfl0mufmb22kwafb2qeg.xx.internal.cloudapp.net
 ([4.242.44.195]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a16088sm16383965ad.9.2026.07.29.13.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:20:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Wed, 29 Jul 2026 20:20:24 +0000
Message-ID: <20260729202024.11272-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729193307.4187107-1-sbertram@redhat.com>
References: <20260729193307.4187107-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

On Wed, Jul 29, 2026 at 03:33:05PM -0400, Stephen Bertram wrote:
> semctl01: fix SEM_STAT failures under parallel LTP runs

> SEM_STAT was using the global high index from IPC_INFO, which is not
> stable when other IPC tests run in parallel and can abort the test with
> TBROK.

The commit message describes only the SEM_STAT index fix.

The patch also replaces the IPC_INFO check in func_iinfo() with a
completely different one (seminfo limits vs /proc/sys/kernel/sem).
That part is not required by the SEM_STAT fix: dropping the
"sem_index = hidx;" assignment is enough.

Could this be split into two patches, one fixing the SEM_STAT index
lookup and one changing what IPC_INFO verifies? Otherwise the new
IPC_INFO check needs a paragraph in the commit message explaining
why it replaces the old one.

> -	if (hidx >= 0) {
> -		sem_index = hidx;
> -		tst_res(TPASS, "the highest index is correct");
> +	int semmsl, semmns, semopm, semmni;
> +
> +	/*
> +	 * Return value is the highest used index; SAFE_SEMCTL already
> +	 * rejects negatives. Limits are what IPC_INFO actually fills.
> +	 */
> +	tst_res(TINFO, "IPC_INFO highest index %d (our index %d)",
> +		hidx, sem_index);

The comment does not describe the code below it, and the remark about
negatives is moot: semctl_info() in ipc/sem.c returns
"(max_idx < 0) ? 0 : max_idx", so IPC_INFO never returns a negative
value on success.

With this hunk the IPC_INFO return value is no longer verified at all,
only printed. A check that is stable under parallel runs is still
available here: our own set is alive, so the highest used index must be
at least our index, i.e. hidx >= sem_index.

> +static int get_sem_idx_from_id(int sem_id)
> +{

The parameter shadows the file-scope "static int sem_id". Would "id"
be a better name here?

> +	arg.__buf = &info;
> +	/* SEM_INFO ignores semid; but SAFE_SEMCTL requires an lvalue */
> +	max_idx = SAFE_SEMCTL(sem_id, 0, SEM_INFO, arg);

Both statements check out (semctl_info() ignores semid, and SAFE_SEMCTL
assigns to its semid argument), so this only reads oddly because of the
shadowing above.

> +		tst_res(TINFO, "sem_id=%i maps to kernel index=%i", sem_id, sem_index);

%i instead of %d; the rest of the tree uses %d.

Verdict - Needs revision

Pre-existing issues, not introduced by this patch:

func_rmid() runs after SAFE_SEMCTL(*(tc->semid), 0, IPC_RMID, ...), and
SAFE_SEMCTL sets its semid argument to -1 when cmd is IPC_RMID. So
sem_id is already -1 there and

	TST_EXP_FAIL(semop(sem_id, &sops, 1), EINVAL, ...)

really tests semop(-1, ...), which returns EINVAL whether or not the
set was removed. Saving the id before the IPC_RMID test case would make
that check meaningful.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
