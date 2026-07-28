Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5F1C53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 17:32:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 793603E91F0
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 19:31:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27BAC3CD529
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 19:31:41 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 64DF61A008BF
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 19:31:41 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 af79cd13be357-930914e4fc3so3864285a.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785259900; x=1785864700; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mx75Pd6Y7ku1c5RB9Plm9QgpAps6gvNKEDKI9xMgbaY=;
 b=NbqTSjYwmmgci/MyHoL82KYzRJh/QQ9YQyG1VAnpSW9lPHYnU3rPBHxnzt8W3AC16A
 wm2B2lAlAPtXa6HZz4RjAw4oEz8On0AZ5EyKIMHhbwPA74b9O9/IJhgmQ5jIBbxhvqOQ
 6soP76Y6X2s/gcjL/g0aTF3zlkvDawet75Xyd3u8V+RjTJI6G0iKkPHkctKU+ImggyFV
 3mYmQvEXC383kqgqF+TpAUX5rOewTy+CVDlfa2QXYbyYmHdI1ph0BtCq10ydy+dWVdaQ
 TmW3RiAjRNLkkM0gkNAJcUBPIRYBqn061ZbVyCyeD9e4/vU6AujMgbR6Xqu+GuUzeW7K
 awAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785259900; x=1785864700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mx75Pd6Y7ku1c5RB9Plm9QgpAps6gvNKEDKI9xMgbaY=;
 b=HwqTu2s1goxWnd7AQ2SUUcea+FT9CYjTO5mA75FRuVo8gV/Qgmw9nal+KKI6n/4Eg9
 W32XryPGAUFG7Nrv4emg9k8eAmwwvmgvIwjRkXAPFqDTfZb3xJzCII/US/iAzeTKyoKB
 9mTj+Ne4L0s7S6cOV2/Ggx7eLzzF863I2mBL9kimwl3NJkeSTCGQIIuCboemBtEY3Lgq
 VG6OjJYVlPP6vr0+V/lTt5aNoFhlwln+adl+Goi/vBrP+tu68ulBH/NtvQlkcvu3AFQH
 B9BsJwrgz926VS/JCZwp+daBn30fctkE33rNa4Yt9zJA2ZGMKI9bCfPTydL9WhnoUFT/
 1fwQ==
X-Gm-Message-State: AOJu0YxKCDecp0ySSNgL0v7Xiqn4S2JkdOMaBs9v8RxKVaC76leT0JB0
 qSZP77h595fzdsjOXVsfE76sA/OkHuh8Frs06UYggEq+50ogv9mvtRfB
X-Gm-Gg: AR+sD10AnN95C4EmoG5SAxajGNxEwUVi98xiIQkGhY3S+E9Kefte4XDCIlBRsOU7Gw8
 RkFXkCkQX2SuMP3kA86jpUa/3vXmUI1iaj8uE6TFKtoVDc1JE3+9cXJ+jigChks+/dYnCbV1LxS
 51IrgZ677QcLfA8/pP/Kq/vUcPJqPSDGtIQ7hpkyaKN/P5cD6uEJCDz+Zg9Cs+QHtKcuCmNhed1
 l180T2GjYLmtJXZHnu94RzUZDvzqXyvUVZ/ISm+PJ0UhQsXMOAA7iNEHUxWy2Ew6oBs6X5kxc/x
 S7uEHP7QkPOgJ9Me5GL45w33RpgNz4EqOPtmkYXOLd7+3UYgbsK5s/B5b44JcxxnRgGKdU9C4Oy
 5U7Yjs0zkD9Drx45nr7INrjPpNC7RTepUGwU2y58hUQNy3P3ZdTdg0QScebGaE9pQY5PdIfcAtI
 ooYtQJQp+vzNzag2gQq3b0vKEYfjysF09K42OMFK3lslwS+QoLIyt/KaETJh5HYUGgLgVW/GWsX
 FLFEm30tw8KEbsfyX11
X-Received: by 2002:a05:620a:372b:b0:92e:8405:7ad2 with SMTP id
 af79cd13be357-933026f6ca3mr344301085a.41.1785259899705; 
 Tue, 28 Jul 2026 10:31:39 -0700 (PDT)
Received: from
 runnervmvrwv9.0k4pygio4yeebj3bdrl4yme5vh.bx.internal.cloudapp.net
 ([172.174.188.181]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de675571sm882769285a.47.2026.07.28.10.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:31:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Tue, 28 Jul 2026 17:31:38 +0000
Message-ID: <20260728173138.11529-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728162351.3845090-1-sbertram@redhat.com>
References: <20260728162351.3845090-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: tolerate SEM_STAT races under parallel LTP runs
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

On Tue, 28 Jul 2026 12:23:50 -0400, Stephen Bertram wrote:
> semctl01: tolerate SEM_STAT races under parallel LTP runs

> When multiple LTP workers run IPC tests concurrently, SEM_STAT can fail
> with EIDRM/EINVAL because the index from IPC_INFO can disappear before
> SEM_STAT runs. Retry a few times instead of treating that as TBROK.

The TBROK is still there though, see do_sem_stat() below, so the message
promises a bit more than the code delivers.

> The test remains single-threaded; shared globals are intentional.

This reads like an answer to review feedback rather than something a
future reader of the git log needs. Could it be dropped?

> +static int try_sem_stat(union semun *arg)
> +{
> +	int info_id = 0;
> +	int idx;
> +
> +	idx = SAFE_SEMCTL(info_id, 0, IPC_INFO, (union semun)&ipc_buf);
> +	return semctl(idx, 0, SEM_STAT, *arg);
> +}

idx here is ipc_get_maxidx(), i.e. the highest in-use index in the whole
namespace. That is almost never the set this test created - it is whatever
set some other process happens to own at that moment.

So the race is not really being tolerated, it is being retried against a
moving target. Would it be better to look up the index of the test's own
set instead, e.g. walk 0..max_idx with SEM_STAT until the returned id
equals sem_id? That makes the whole sequence deterministic and removes the
need for a retry loop.

There is also EACCES to consider: if the highest index belongs to another
uid, ipcperms() in semctl_stat() rejects it and sem_stat_succeeded() goes
straight to TBROK. On a shared machine that is the same class of spurious
failure the patch is trying to remove.

info_id is always 0 and semctl_info() ignores the semid argument entirely,
so the variable does not carry any information. Passing sem_id would at
least match the rest of the file.

ipc_buf is the global that the IPC_INFO and SEM_INFO test cases point at
through tc->arg. Refilling it from a helper for an unrelated command is a
hidden side effect - a local struct seminfo would keep it contained.

> +static int do_sem_stat(union semun arg)
> +{
> +	int ret;
> +
> +	ret = TST_RETRY_FUNC(try_sem_stat(&arg), sem_stat_succeeded);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO,
> +			"semctl(SEM_STAT) still failing after retries");
> +
> +	return ret;
> +}

TST_RETRY_FUNC() backs off for roughly one second in total and then just
returns the last value, so this path ends in exactly the TBROK the commit
message says is being removed. Under sustained parallel IPC churn the
original failure mode is still reachable, only less likely. 8000 clean runs
show the window got smaller, not that it closed.

>  static void func_sstat(int semidx)
>  {
>  	if (semidx >= 0)

Since do_sem_stat() already brk's on anything negative, this arm can only
ever be TPASS - the test case cannot fail any more. Comparing semidx
against sem_id would give it something real to verify, and it falls out
naturally from the index lookup suggested above.

>  static void func_iinfo(int hidx)
>  {
>  	if (hidx >= 0) {
> -		sem_index = hidx;
>  		tst_res(TPASS, "the highest index is correct");
>  	} else {
> -		sem_index = 0;
>  		tst_res(TFAIL, "the highest index is incorrect");
>  	}
>  }

Both arms are single statements now, so this trips checkpatch:

  semctl01.c:212: WARNING: braces {} are not necessary for any arm of this
  statement

It is not present on master, "make check-semctl01" flags it after the
patch.

> +
>  	if (tc->func_setup) {

> -
>  	if (tc->cmd == GETNCNT || tc->cmd == GETZCNT)

Both hunks are pure whitespace churn unrelated to the fix, and the second
one drops the separation before the cleanup check. Could they be left
alone?

> -	rval = SAFE_SEMCTL(*(tc->semid), tc->semnum, tc->cmd, tc->arg);
> -	switch (tc->cmd) {
> +	if (tc->cmd == SEM_STAT) {
> +		rval = do_sem_stat(tc->arg);
> +		tc->func_test(rval);
> +	} else {
> +		rval = SAFE_SEMCTL(sem_id, tc->semnum, tc->cmd, tc->arg);
> +		switch (tc->cmd) {

The switch gets duplicated for one command. Selecting only the call and
leaving the switch alone keeps the diff to a few lines:

	if (tc->cmd == SEM_STAT)
		rval = do_sem_stat(tc->arg);
	else
		rval = SAFE_SEMCTL(sem_id, tc->semnum, tc->cmd, tc->arg);

	switch (tc->cmd) {
	...
	}

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
