Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CEBC54FCD
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 02:20:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D2363E74AC
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 04:20:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72CCA3E2156
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:19:53 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C28F71A0068F
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:19:52 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 af79cd13be357-92e862681ecso35293785a.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 19:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785377991; x=1785982791; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JmTxUOST7DACJZop5UcGDYQ53tfspjVpdrfl/Rtmf+g=;
 b=fXJWhTT5JgfYF1VWGfQW+boBqGwmjJIBFsUvrDxn5KjJQWzTAP2FPRV+DUGaGbJvh2
 dRsVU+sigiR8jgfbuZHcCHEDO9+0Q77k+9PM2IJCV4GxOzS3PH7k4IKLh+JqFb1M0406
 3Obvq1zxHy4rISJHrhsjA4f1IVmEevMnIlyHT2OEcBnJrpmQ05/EpL4frHRWm3w9O5MQ
 pJOLm7jI6W/mlOmVGo35elz/pHBI1eKfbJtJMPWT9euBum8V8mshtDQ3wyfT0hW6dmKk
 PLmnYr+b6nLXrfOJ7GRp/e40fVlSw/acvRenG8gIqJ3rVkF8xPoblJJ4TAtb2kXpIFqD
 gsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785377991; x=1785982791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JmTxUOST7DACJZop5UcGDYQ53tfspjVpdrfl/Rtmf+g=;
 b=NyOEkNxVBkYySly+y1wjHdeabkoQ10uxNdZ3ZSP1E8tpVwcqhDuAcgtolaxc9CXm5b
 PaAn/Mox6wIF++vsDwivqwHK+wUUJDC40YBPJGAj6J7dh87ab8IuJSPe2TzrwESyUyWj
 UQ4Qij/cw2MgYX9+js+8cPifDqIjdwEY8g7XSk4sXhzQabuXfshpFbqzFPHlKE1uSjK5
 Vpno7f4q/EZhXy+6Soz3e28U4uB0AMPGWwYRtddnjMWllWVSvNvtO8xGzrwSg8geZ9UV
 LgclU/wMCtS/HgK1pei7jPlldZgUY1ao+GCbh9PxO2nZgWUEbzlRVuiafxHAB3la4WB4
 0PvA==
X-Gm-Message-State: AOJu0YypovLBo/zbSFdY9zcJXCihoU3b68rR7fCGlLexdL9WX4LMWpZf
 7pJwj9Ra/SxvbZ/dn6PGTeyTceKHw/EW0/gdz7gL0aPr2SMK1JznbEXpIOrNwSbK
X-Gm-Gg: AR+sD11Xq4C9AbSVBg6wCz4WAJOTa3WgCxTUz6az0UyQFDx+lmTbN9tiTdDyjL+cEY0
 cLcR6niIakf2+pYSRW5La6mhEEy/GmCm4sT9u3nFKRM9SZIswlh7rkqKhiGpR9Q8XuHi4OXL+oS
 Nr2kKtgZk8vumJxzwzR6tuk1arIwiNpd88rR1vcjK536r7bXTX00uwsvdVxxxXRfcxpsmsjWRZ9
 Lds3r+Wo3f4mGiRhcy4rWMHsPFTKGk+OcC4ukFx8i2djsppoleGHBhHU7wH8gkjbTGS3jRNHqdP
 kEMUvrD8QhzkSfGsEu2BTZ30x4hRY15NwOfvSvaMtM16KnQcB49rRC0RTWwD8pCu0SGookfjqOp
 ydYGCO6vgqnttwXlxBHNCBRCy6UUVxHV+Ha9S2ycjKOm7bnUqUu7yANYK7NLGJcGyjJ8Pf722I+
 JYfEevCYXyJtalZFedcvbnewzAq0+3XuMSE8Ks51Jpb0H2qw5gEN4bwkXObYVgARwab6ECuNYN8
 2ObnMzoPMrqNz2xU4VpnBRw4GKN4PsGiPcae/+3iWms/xLQAkXu8rcQAAWjIXiJOhsqa578OxM=
X-Received: by 2002:a05:620a:1a1a:b0:92b:6805:91a6 with SMTP id
 af79cd13be357-93486cece1dmr73981685a.62.1785377991383; 
 Wed, 29 Jul 2026 19:19:51 -0700 (PDT)
Received: from
 runnervm7i58z.guklbwq1g02unjtnn4f2llqnib.cx.internal.cloudapp.net
 ([48.214.53.83]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e7351067sm304938585a.41.2026.07.29.19.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 19:19:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Thu, 30 Jul 2026 02:19:50 +0000
Message-ID: <20260730021950.8959-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730020813.68630-1-sbertram@redhat.com>
References: <20260730020813.68630-1-sbertram@redhat.com>
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

On Wed, 29 Jul 2026, Stephen Bertram wrote:
> semctl01: fix SEM_STAT failures under parallel LTP runs

> +/*
> + * get_sem_idx_from_id() relies on this same identity (SEM_STAT(i) == id)
> + * to find sem_index during setup. Re-checking it here still has
> + * meaning: it verifies that SEM_STAT still resolves to our set at
> + * test-execution time, catching the case where a parallel IPC test
> + * reused sem_index in between - the exact race this patch fixes.
> + */
>  static void func_sstat(int semid)

Can a parallel IPC test really reuse sem_index here?

The kernel index is assigned by ipc_idr_alloc() when the set is created
and is only released by ipc_rmid() (ipc/util.c). The set created in
verify_semctl() stays alive until the IPC_RMID entry, which is the last
entry of tests[], so the index is reserved for this set for the whole
run and cannot be handed to another set in between.

The race the patch does fix looks like a different one: IPC_INFO returns
the globally highest used index, which need not belong to this test's
set. Would it be clearer to describe that instead?

Also, comments referring to "this patch" tend to age badly in the source
tree - could that rationale move to the commit message?

Last, the block documents get_sem_idx_from_id() but sits above
func_sstat(), before that helper is declared. Would it read better right
above the helper itself?

> +static int get_sem_idx_from_id(int id)
> +{
> +	struct seminfo info;
> +	struct semid_ds dummy_ds;
> +	union semun arg;
> +	int max_idx, i;

This is the same algorithm as get_shm_idx_from_id() in
testcases/kernel/syscalls/shmctl/shmctl01.c:227.

Would it make sense to put a common helper into libs/newipc so both
tests share it, instead of a second copy? If a shared helper is too
much for this fix, keeping the naming and the TBROK message aligned
with shmctl01 would still help.

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
