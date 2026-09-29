Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A60C9832A
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 04:35:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 903953C9FD7
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 06:35:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9707D3C26A1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 06:35:17 +0200 (CEST)
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 76C701400E09
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 06:35:16 +0200 (CEST)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-33bf2604829so970966eec.0
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790656515; x=1791261315; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZpNozUQiL9HU+UIz079asp3u1PTQVC31p0ozXQxY6kU=;
 b=luzAsWrh1xfQ6vp3W7e9owsrQ3WzklQNpFLEykxjydAmn3cIr/ML6Zn5nMF8iFomO4
 zk0ITksUbSjJXvXlP2+dQ5vDVu3HSgUOR4ITfICiopglUIzcxZPJ7hkdoPF7eggEDJII
 GyAJGTXH0FUJVoDVPGpWhKzCMPiYhFwb+reuaZNhPt2fAUOvjhvHKIFTduRbU8O6H3L5
 3W+m4HKFXXdC7oYCRTdJzjF/wBFGc3u9q9jq8rWVVJpA60htcZi+aec9jxcCt+vVBvwv
 LaY3lk2qLAPqJAmliVVldfgvUc2b0cpS+/gRIFtEKeh+H8b2kMsrvqlBNt9P5QuqbmEC
 SS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656515; x=1791261315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZpNozUQiL9HU+UIz079asp3u1PTQVC31p0ozXQxY6kU=;
 b=N5fWewhXDktbBrNkLOiiOIUG7rqzW/VWnButILHRsIIheKQ7zKvQdIaR3IPzx4WEi0
 UalXJucLw479tyh8kul9ZsChazyRuA+KFz3ZXfo4guBLZ6zkdj+PZ6oNLVXqTtzjGq6h
 LYuRWPFhJAMaiEA5F69TFqqoaiILe/3X8r2vB+vxuZJQL/ZTG+cOp5Jvxkhk28lUwntM
 Y2X6a1LvrtUPzQFj4c2ZER+TQdQvbykON0q9TLKc2C14zGBu7JXsmQ92+6rMve9jdUM5
 nmCuiaA4KT0bwzA3B/BoXxMbhdTtzEV80b+s6BQftMZTXHx2O90Th47k8g7tTDJKoNRB
 RfSQ==
X-Gm-Message-State: AFq9FYInD7NibDthf3MN7VrZXY0ZcgTBfFr30176puPq57VK8GbC7SS8
 FPKloWNbBsp9KiFcDyX5O1mdyB9qwZ8YISNbeWRe1Pmt/PJAC12qXNP9
X-Gm-Gg: AYBFou2QBamaATLi1kOTzs2zxMkkIO/RUqtRxeUtHeDAMH7UoEsUvDo+gDopwqAo/Tm
 XA6VWViQEdCtm+jkQb+ah/TZh61umjZykIf+FKGBTMhIwewFpiaNV8makqZWTCg711j+JNcedUX
 Na/+GamXgHAiE594Ef9lerY/7K0A3Kh2ZRE02QoR0zCfFOrUxyN/Pyti5flnRvVXjlvqSK6+phG
 uUbRmAFcHD90Igs5q+EQ+4BurvTpR4rghYvXK1YJKwRjHldGD6kuSlEXDKhYSKHehZdb+lLfQnU
 fw0zJOiRhiXX9DSkGZBNXNB46JWOBear26po0SJPSMe+pDADW0k8nTeM2NiS7xlA/H+5qMXEbkI
 lYlyj6rriHTmu7YJk5B9J3+dJVsAi+DYxxjbSyZGcNBLiE/nFIbmMAw+eTSszMbIofIZh+5pltH
 M1kt9oarwQHmURdgLaEykQdfV5jiFYoJr3XrZipXJxol+1zTFdP0m9GmMtmExzKuaZS155iubFt
 lvkOm9/XCAn6a+xmhqFkink35DtEvjPqloQixzO4B9RU+Mf2FotZ9nBlyH29/R99d137B4owS+e
 5Ol5ibDuYJ8=
X-Received: by 2002:a05:7300:3e93:b0:342:59f6:d142 with SMTP id
 5a478bee46e88-34271d8cda1mr12525557eec.19.1790656514536; 
 Mon, 28 Sep 2026 21:35:14 -0700 (PDT)
Received: from
 runnervmtr4k5.zs354342tb2e3kgisxlw23eeif.dx.internal.cloudapp.net
 ([13.87.216.116]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-341460f5166sm34093171eec.29.2026.09.28.21.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:35:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 29 Sep 2026 04:35:12 +0000
Message-ID: <20260929043512.8963-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929022340.524-1-wegao@suse.com>
References: <20260929022340.524-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcontrol03: Bind to single CPU on systems with 64KB
 pagesize
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

Hi Wei,

On Tue Sep 29 02:23:32 2026 +0000, Wei Gao wrote:
> memcontrol03: Bind to single CPU on systems with 64KB pagesize

> diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
> index 96224c4ee..6007d5588 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol03.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol03.c
> @@ -235,6 +235,23 @@ static void test_memcg_min(void)
>  	SAFE_UNLINK(TMPDIR"/tmpfile");
>  }
>  
> +static void setup(void)
> +{

Add #include <sched.h> to memcontrol03.c. The test relies on transitive
inclusion for sched_getcpu(), sched_setaffinity(), and cpu_set_t.

> +	if (getpagesize() >= 64 * 1024) {

Use SAFE_SYSCONF(_SC_PAGESIZE) instead of getpagesize(). The latter is a
legacy API removed in POSIX.1-2001, and memcontrol_common.h already uses
SAFE_SYSCONF(_SC_PAGESIZE).

> +		cpu_set_t mask;
> +		int cpu = sched_getcpu();
> +
> +		if (cpu < 0)
> +			tst_brk(TBROK | TERRNO, "sched_getcpu() failed");
> +
> +		tst_res(TINFO, "Page size >= 64KB, binding to CPU %d", cpu);
> +		CPU_ZERO(&mask);
> +		CPU_SET(cpu, &mask);
> +		if (sched_setaffinity(0, sizeof(mask), &mask))
> +			tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");

On systems with CPU IDs >= 1024 (e.g. large ppc64le systems where
CONFIG_NR_CPUS can be up to 8192), cpu_set_t cannot represent cpu.
CPU_SET() will silently drop the bit, leaving mask empty and causing
sched_setaffinity() to fail with EINVAL. Allocate the mask dynamically
using CPU_ALLOC() or verify cpu < CPU_SETSIZE. Also, check the return
value of sched_setaffinity() with < 0.

Verdict - Needs revision

Pre-existing issues:
- Line 194: sleep(1) is used in a retry loop; use exponential backoff
  polling instead of fixed sleep (Ground Rule 2).
- Lines 166 and 235: string concatenation without spaces (TMPDIR"/tmpfile").

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
