Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F6AC53219
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 18:14:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BBA03E5280
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 20:14:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940C43E215D
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 20:14:34 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 42CD36008C8
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 20:14:34 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2cf452def93so1315245ad.1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785348873; x=1785953673; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XVBVgTnE1kU4LGm0yqwvFF0DSgFHRIG5vvjTBqD8zV4=;
 b=fVFHnjzaip/8eJEPOc1ZYVtrZHFW6eu52cAhnJDsnfEHTtq/rditWgSS0TRAgoRrYS
 6Wg20+xUR+yjL4l7QC7+6D160pv3uPLN8V6wGllJEzshycjP26v2yxv/Xmxat9m5mskB
 l6ZHowMc5isLoZKPK+jsnems6Zl07qrrUemPI3JIgnOULUqXhLhKGe7HoEhLJljolO3J
 u8Tz4K16lz039UgMXAmqSj1gLcls8WmimOE6rDuDm9jSkx7whW7Dg6tAiFmu/0DocoLQ
 Duve0I4Vtrdp6uk4Z4M9RhUvzZ6Io3hSOaLfksCEAhAH+QZofr+TmEsyPceLvS9rE/9O
 U2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785348873; x=1785953673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XVBVgTnE1kU4LGm0yqwvFF0DSgFHRIG5vvjTBqD8zV4=;
 b=hQb7Z6l/f4bQ10M0tiPRl7QBMaCTI3TY3VoPtioPQj+umKMJMYLodPtKrsNPzsNSct
 ifaCVlvMnEgxpqKngLmB7dnH6obCvHunR6kW8P/PO6jO9HOQ0v+XEi3ksFfQ3kLR4DT7
 v4GXvdXC0cuEoK99CRPj1VpD0KH0h1Yqm9MWFXptC6CWH+MmXFHL7HOLsJfWY5CawaZE
 6JQTL/tm0tbLeav9l35IKGz5+yIqW7w/RfNDIyHpaYjf6gkzROglFgFMlP3n122ESyaQ
 fZtMBrlqV4LpghYq7PCLMjEfHVfjbL7H87Tg1ZlICVg7j5GyQ7+iTDJZ/vrdY+Wj6L4Y
 RB7g==
X-Gm-Message-State: AOJu0YzgHPp/aCPuDqK3j49XXz/3yUpzYynsUDiILlDtjiKp1Tyh3dr2
 laFNGP99ibZ3VaTxFfsnSrTFaEsLizZ8DDDCCZXImNZ0p1AzG8yS3JKn
X-Gm-Gg: AR+sD11g+aI+x46Dzx2fj5immxKaaWVv8Vscq+dN/CBXl9k8z8fCii9ewdu9sEtUPmi
 awalsTMmc0yjjjJMMUt6nLrVBnvVTMzOQzgDQKu4s8b4jOE+527xvpwOsfIvsKiiqNDjYBMy+7m
 ydb96JjsIwon3ZQ6qlA1ppARufOKHocnNCzBK0Ey9ZF4AcO6EDTuq0NRdw+eiz1ovGUZuMlXfVS
 oVsJmu3i/bJsEVfNgF1BvwgSdykQcHo3OEPO2ROciUJH6TQb+HAe2fKQeJ4gqv12jTCw17mtM0p
 CxAar7E/LkvGW2JO2PH2+D+IXoUntoiltzYnP8bgJ2y73C1jISxkhEWvSJDP4S9MGJ7OqYQDMRB
 3i1SrbAzyZBZxUpVyYDWNotudfUvkb7/+Z/ND1GoVOBw3OzBzS9+PEjiokk1IHs1WxUNBKyImXt
 zM+zMDXTRFTpnIRKXOBe5irI/5Zz3nJ8Ft6TSNuNdcRhD52x6uBhVDoFvoxqR7hOQyguO/S8zqt
 lGjD610gQfgkCPuaIfQT1PI20WP1aTDPYn2PBf3Lln728cGXXERtN6ayTwydQ04mHkFqZOIvyra
 /4w=
X-Received: by 2002:a17:903:2446:b0:2ca:de3:15d7 with SMTP id
 d9443c01a7336-2d026742789mr33818595ad.16.1785348872582; 
 Wed, 29 Jul 2026 11:14:32 -0700 (PDT)
Received: from
 runnervmvrwv9.si5vesnirltutgysy1tpxjbuwf.dx.internal.cloudapp.net
 ([172.184.220.154]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d3c68asm13206602eec.24.2026.07.29.11.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 11:14:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Wed, 29 Jul 2026 18:14:30 +0000
Message-ID: <20260729181430.8673-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729175611.4161450-1-sbertram@redhat.com>
References: <20260729175611.4161450-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

> +	if (hidx >= sem_index)
> +		tst_res(TPASS, "IPC_INFO highest index %d >= our index %d",
> +			hidx, sem_index);
> +	else
> +		tst_res(TFAIL, "IPC_INFO highest index %d < our index %d",
> +			hidx, sem_index);

Can this branch ever take the else path? sem_index is resolved while the
set is alive, and the kernel keeps ipc_get_maxidx() at or above the index
of every live entry - ipc_rmid() only recomputes ids->max_idx when the
removed index was the maximum, and it would then find our entry.

If so the IPC_INFO case no longer asserts anything. Would it make sense
to also validate the returned struct seminfo limits (semmni, semmsl,
semopm) against /proc/sys/kernel/sem, so that IPC_INFO is really
exercised?

> +	arg.__buf = &info;
> +	max_idx = SAFE_SEMCTL(id, 0, SEM_INFO, arg);

The kernel ignores the semid argument for SEM_INFO (semctl_info() never
looks it up), so passing the set id here reads as a per-set query when it
is not.

> +	arg.buf = &dummy_ds;
> +	for (i = 0; i <= max_idx; i++) {
> +		if (semctl(i, 0, SEM_STAT, arg) == id)
> +			return i;
> +	}

The bare semctl() looks deliberate here, since unused or unreadable
indices legitimately fail with EINVAL/EACCES and SAFE_SEMCTL() would
abort. Could a short comment be added to state that, so the missing
SAFE_ wrapper is not raised again on the next read?

The braces are also not needed for the single statement body.

> +		sem_index = get_sem_idx_from_id(sem_id);
> +		if (sem_index < 0)
> +			tst_brk(TBROK, "Failed to get sem_id to idx mapping");

Including sem_id in the message would help diagnose the case where the
lookup does fail.

Verdict - Needs revision

Pre-existing issues, unrelated to this patch:

func_rmid() runs after SAFE_SEMCTL(..., IPC_RMID, ...), and that macro
assigns -1 to its first argument, which is sem_id here. So the
TST_EXP_FAIL(semop(sem_id, ...), EINVAL) check gets EINVAL from the
invalid identifier rather than from the removed set.

msgctl12.c carries the same pattern this patch fixes: index_q is taken
from IPC_INFO in setup() and then used as the MSG_STAT index.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
