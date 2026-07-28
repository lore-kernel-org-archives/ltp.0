Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A0FC54F51
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 21:12:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E42C63E7484
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 23:12:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586163C0039
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:12:18 +0200 (CEST)
Received: from mail-yx2-x02.google.com (mail-yx2-x02.google.com
 [IPv6:2607:f8b0:4864:41::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ADB8214001E7
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:12:17 +0200 (CEST)
Received: by mail-yx2-x02.google.com with SMTP id
 00721157ae682-81ef69f6b93so2045177b3.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785273136; x=1785877936; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tbWoqIQ/KYzQhsd/kV8wz+4AHd1/Gi7Uip0AZPupqgs=;
 b=h1AdgzczlgtrxX2o4FzqnM+IF+oDM9LcdJFlu2MtWMCgvkUJL7bNlhxwZYx5W8R7HD
 fkCO2k1211B1GaWTgbhEZLOkVFpKDlWDOsZofR429fw2hlZgbuNyLVM1Db0FrKCXTp1P
 PrcIHSlnYohQ+GLaPZZo1FcqyE64pLWiN646mwLeIpjv89Iz6fqqpqkTP7IKLXg6qh4H
 IyL58D9sQWI15/KxqIJVBcgEZyxZSPp13l+oNBctsHY9tRHiT6zDRAXCl1L7U8wiNQdU
 spQ3gzPo5dUa8pjGguBQh0MSs8qvWqmRli72Ut8Z/H14n8CVGNCbhiXT9m952cg/dh2J
 m1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785273136; x=1785877936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tbWoqIQ/KYzQhsd/kV8wz+4AHd1/Gi7Uip0AZPupqgs=;
 b=slMZhPZBDsLl5ZI4LZJ8fsusvXeFVYKo8uCAifLoca9q54+iMliUbr5Cev9LIxIaTk
 K3cAmzxCNKB8ut/P5EHi6i+Efl182dRs/1vgt5xn/v1Xh0AssvwaNZm/hw/P85FDpvP8
 oxIFYxJIGxwKmQWa9BDjcF1isIyNEwe6ZlFUEJOJ6J/pvNnOZe0q6rqGxQ4sGeQkMOQM
 KGS2P1s6GmX23EcKqvcFVwaiFnTjeWyXNXgXnY1+9kMTy05qYXhUx9obxggEY4RFO3DN
 ZoMicB5maBf6RvTeomeGbFwA2EtWiALbBtMZ3/Lnt9TK86zqqj4AQgMj0wQx5fr+Rqwr
 hJMw==
X-Gm-Message-State: AOJu0YxYkjEzuzN6P+E2eZW1heGWIK1U8/YCzLuW9D+AmT5hColxTVbJ
 zF0bcDI7K0ZZm4fnVGz0FF66H6fnCZIWWgyemh3I4RdO8EkK/Mqdpyy4
X-Gm-Gg: AR+sD11+OWmx9PUiulv804Yt274g2HldhTMO1DUeGgtqddPIqVT5mFC/mjARQbex0Ec
 R+CXFHA9Pw/tx6EEGzThczzOUQgw2p57UcZ9ASNNtkTvkPCKjSwRhENcxidKrol/S7wCGlsOGr1
 3KWEVqo0+2uH7Gy+sQV9JnsGYS/lDJT+od569bT4ZLORYVgcUErXuDsJmPizLC6/B7NHqHVHIX/
 wa7A7OylyBCkKNCeXH4xsik1Mw9LFgIt5zcYmiGjjqtPu7PTFmP7FrYJ8ZEVQfg+10bQx8qg4jB
 eSyA0Ql1MnGbVTa+jo5x3uSSDh1a3HqNcuFc1ZNXLYLp+x3suYvxktM4Rwr+8BA+2vGc1SpvHBx
 Q73QX4zb+Zoq+AFZ5PDED/ELKyOQokOnT0ooEwOYj0grZw796vWVQJffIJkc9SNwNbo9/wdP6SC
 KmlxCX2Lj5TJR0xAfiyaNkS974eTSs1sTI7TfeBGAdOZd8FFiDyKUEC3UExAqiPvK3YaSYu+YMq
 +EY5zjmrnewzvfc3g4xWtOFQyEpTNOfY4dFvckoPWK90KbtkiD2E1dLZoB5FokMc8BOFp7By7ud
 aTgtcZCnII0d
X-Received: by 2002:a05:690c:601:b0:80b:9f4e:a73 with SMTP id
 00721157ae682-81f990acf34mr17895277b3.13.1785273135999; 
 Tue, 28 Jul 2026 14:12:15 -0700 (PDT)
Received: from
 runnervmvrwv9.yg1age54wdsejlu0sinfybhffd.ex.internal.cloudapp.net
 ([135.232.201.35]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fa278d1ebsm6328597b3.12.2026.07.28.14.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:12:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Tue, 28 Jul 2026 21:12:14 +0000
Message-ID: <20260728211214.8732-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728203333.3949671-1-sbertram@redhat.com>
References: <20260728203333.3949671-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: look up SEM_STAT index for this test's sem_id
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

On Jul 28, 2026, Stephen Bertram wrote:
> semctl01: look up SEM_STAT index for this test's sem_id

> Walk 0..max_idx with SEM_STAT until the returned id equals this test's
> sem_id.

The body describes what the code does, but not why it is needed. Could it
state the root cause instead, e.g. that IPC_INFO returns the globally
highest used index, which may belong to another process's semaphore set,
so SAFE_SEMCTL(sem_index, 0, SEM_STAT, ...) can fail with EINVAL/EIDRM/
EACCES and abort the test with TBROK when IPC tests run in parallel?

> Test: ./kirk -w 4 -f syscalls_8 -p semctl01 -i 1000
>
> Results summary before:
[...]

This is test-run metadata rather than part of the change log. Would it be
better placed below the "---" line?

> +static int sem_stat_for_id(int id, union semun arg)
> +{
> +	struct seminfo info;
> +	union semun info_arg;
> +	int max_idx, i, ret;
> +
> +	info_arg.__buf = &info;
> +	max_idx = SAFE_SEMCTL(id, 0, IPC_INFO, info_arg);
> +
> +	for (i = 0; i <= max_idx; i++) {
> +		ret = semctl(i, 0, SEM_STAT, arg);
> +		if (ret == id)
> +			return ret;

The helper returns the semid, not the index, and it only returns when
ret == id. Combined with do_sem_stat() aborting otherwise, the value
reaching func_sstat() is always sem_id.

> +static int do_sem_stat(union semun arg)
> +{
> +	int ret;
> +
> +	ret = sem_stat_for_id(sem_id, arg);
> +	if (ret < 0)
> +		tst_brk(TBROK, "Failed to find SEM_STAT for sem_id %d",
> +			sem_id);
> +
> +	return ret;
> +}

>  static void func_sstat(int semidx)
>  {
> -	if (semidx >= 0)
> +	if (semidx == sem_id)
>  		tst_res(TPASS, "id of the semaphore set is correct");
>  	else
> -		tst_res(TFAIL, "id of the semaphore set is incorrect");
> +		tst_res(TFAIL, "expected sem_id %d, got %d", sem_id, semidx);
>  }

Doesn't this make the check tautological? semidx == sem_id holds by
construction, so the TFAIL branch is unreachable and the SEM_STAT test
case no longer asserts anything about the syscall result. A kernel
returning a wrong id would now show up as TBROK ("Failed to find
SEM_STAT for sem_id") rather than TFAIL.

testcases/kernel/syscalls/shmctl/shmctl01.c already solves the same
problem with get_shm_idx_from_id(), which returns the *index*:

	static int get_shm_idx_from_id(int shm_id)
	{
		struct shm_info dummy;
		struct shmid_ds dummy_ds;
		int max_idx, i;

		max_idx = SAFE_SHMCTL(shm_id, SHM_INFO, (void *)&dummy);

		for (i = 0; i <= max_idx; i++) {
			if (shmctl(i, SHM_STAT, &dummy_ds) == shm_id)
				return i;
		}

		return -1;
	}

Following that shape here would keep the assertion intact: resolve
sem_idx, then keep SAFE_SEMCTL(sem_idx, 0, SEM_STAT, tc->arg) in
verify_semctl() so func_sstat() compares an actual syscall return value
against sem_id.

It would also collapse sem_stat_for_id() and do_sem_stat() into a single
helper. As it stands, do_sem_stat() is a one-line wrapper and
sem_stat_for_id() is only ever called with the global sem_id, so the
"id" parameter adds no flexibility.

> +		if (ret == -1 && errno != EIDRM && errno != EINVAL &&
> +			errno != EACCES)
> +			tst_brk(TBROK | TERRNO, "semctl(%d, SEM_STAT)", i);

This aborts on any errno outside the allow-list while probing IPC objects
owned by other processes, which is a new source of TBROK. shmctl01
ignores every failure in the scan loop and simply continues. Is there a
reason to be stricter here?

> +/*
> + * SEM_STAT takes an idr index. Walk 0..max_idx until SEM_STAT
> + * returns this test's sem_id so parallel IPC tests cannot make us exercise
> + * some other process's set (EIDRM/EINVAL/EACCES on a moving max_idx).
> + * Returns that semid.
> + */

The parenthetical looks inaccurate. Per ipc/sem.c semctl_stat(), EINVAL
comes from an unused index, EIDRM from a set removed concurrently, and
EACCES from a set the caller cannot read - none of them from "a moving
max_idx".

Also, semctl(2) describes the argument as an index into the kernel's
internal array; "idr index" is kernel-internal terminology.

>  	if (sem_id == -1)
>  		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
> +
>  	if (tc->func_setup) {

This blank line is unrelated to the change. Could it be dropped to keep
the patch to one logical change?

Verdict - Needs revision

Pre-existing issues, not introduced by this patch:

- func_iinfo(): "hidx >= 0" is always true, since SAFE_SEMCTL() already
  aborts when semctl() returns -1.

- cleanup(): "if (sem_id >= 0)" rather than the "!= -1" convention used
  for the initialiser.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
