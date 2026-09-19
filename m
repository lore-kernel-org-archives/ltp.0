Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E55C982D8
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 20:14:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EF9F3E749E
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 22:14:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E16CF3E1E96
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 22:14:30 +0200 (CEST)
Received: from mail-oi2-x0a.google.com (mail-oi2-x0a.google.com
 [IPv6:2607:f8b0:4864:32::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0844A1A0090B
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 22:14:30 +0200 (CEST)
Received: by mail-oi2-x0a.google.com with SMTP id
 5614622812f47-4c3bb46aaf0so717439b6e.1
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789848868; x=1790453668; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wOM91xD3KtzBwmxXtfN9rlQqq7ZBGP3CUlmRdIeTj1k=;
 b=XOlhECfTM0EjpgCdxLKE0Ze9IjFHJLFA0ThCLESL8KOhUkLQL8r7TSJH/vMQmLQs/D
 EVsoI8r0ODnygxhHaAVp8ZSKn00mx/ie3fTrSsA9M2DV5DuGaHALx7fCy9uKS8zFeVOL
 6pHKxm6JGb+JIgp8KcGZYio3itcbJX0h60p/hpJIrTyTblXXQc8WyJTtEgRH0sVbA8EA
 +vtHHbOA689bnOtxXjM+z+2TG24/RGi2iKeSpp8ES6PLS0WxC2sVkHiu1UkFpGawUyV+
 m3bb4TJX5qlGt9FmLPYD/7XkDkHE+EdXfWGUP5qzJjinAZfLZmIKc7abrlUJaXDVKaEK
 ZMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789848868; x=1790453668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wOM91xD3KtzBwmxXtfN9rlQqq7ZBGP3CUlmRdIeTj1k=;
 b=oYedyYmOptBAsR4VwNzr3oVwBC3UAr69dcSljaH3BY1O7O6h9ZqM6nurD2eDLP7/Y9
 qWhrojIkbK5lkg3r7/ArSNvMq6iWEO5ACyasr82TaJfoUqX58owKOlFiOlRMY7AGSFZo
 UdGxBKd+DVVXTr/gf7DP1XYITeUJ49d4IFtHmqqfOG46BAp/liL7AF43kAfJIksT9fVN
 uTLFFj27aeH7N8DX3Ncm0yYYPUguJ1YXzLM45jqK8Xj3U3RqAuZ05aKpJsFYy7punwxO
 QtWzuBR9bjhgeXfu8azaparIgwbyQzuhRbnHsQ6wgGMDWtasRajTkfuh1uTpzBpfBBk+
 ZytQ==
X-Gm-Message-State: AFuF++kXlIQYACVHJY5spcIcbDRoOT/hk6yzSiiiN9l6Pzrgw1TEA73s
 tlpiZeHgU2tJs+Eed6q7yz7zhmqY6+9yBmA/k9U9G15Aba41wJSS+5Tg
X-Gm-Gg: AYBFou1P39xYaDL20ZkKqfAM9dx8+j1adE1RG4QcMDUqDaVxHdFVibHpG+JyWs3iz26
 KwSnF5sIaANN9/nhT2P8zWcdgZePmFCabUzr8Ol1iQI3Mt9piBcM7STqGVwshynkMIC5LS4Gx/t
 6dVyhx1bC6peJH5uD4QI9jmaT3nW1N64OMK+J24qdopdS5fJtpu7o/XeswduYOo0LI2coOeQ0G/
 YaAiqCWwzq8u3r7Monx9fEebkuC6WPXKH15BK7wv0Z/VVle8v+cex9fuw4zv7WbZ41qDIdbZqoP
 sJdndwMX1AjklrEeuxl9a9/SLZHrbM3siSgnraPHFEyFrgA5z1MRwnpUqIRrWUDjvb5aUi6qjAP
 Ivckc/g3k7OQZCcGK8km71G0dnaQLdcFFz0a6Vx8SOP1QmLriQy9ECzaDJxQqCOxF1JpqwFq96v
 +pHFOwleGKzuIy8Z1R6WXWiZPsH9l8QTG+P9VQcGVQuHWNQxPG4A7/yW8qSZ1xfCE4UscYk667K
 vMM7HKv+vKOU7Cl6HlGv3F/78A49PxO6x25KGd5EQ2umo7XDND/jbM3o5CpX1Z6tUMxe5FdFwxp
 KC+oGrPEQ/gMMoZGnO9Copk=
X-Received: by 2002:a05:6808:c1b7:b0:4a3:f4b7:cbdf with SMTP id
 5614622812f47-4ccf7192d7dmr6204852b6e.15.1789848868474; 
 Sat, 19 Sep 2026 13:14:28 -0700 (PDT)
Received: from
 runnervmlun5p.ri1lqpitzxauhf3mmjooawwcth.gx.internal.cloudapp.net
 ([20.118.221.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cf3f666498sm2763023b6e.15.2026.09.19.13.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 13:14:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat, 19 Sep 2026 20:14:26 +0000
Message-ID: <20260919201426.9129-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919174920.1078796-1-pavrampu@linux.ibm.com>
References: <20260919174920.1078796-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugefallocate: Add hugefallocate03 to stress test
 fallocate on hugetlbfs
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

On Sat Sep 19 23:19:20 2026 +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> hugetlb/hugefallocate: Add hugefallocate03 to stress test fallocate on hugetlbfs

> +/*\
> + * Stress test fallocate. This test starts three threads.
> + * Thread one will continually punch/fill holes via falloc.
> + * Thread two will continually fault in those same pages.
> + * Thread three will continually mmap/munmap that page range.
> + */

Format syscall names using the `:manpage:` role (e.g.
`:manpage:`fallocate(2)``, `:manpage:`mmap(2)``, `:manpage:`munmap(2)``)
and avoid abbreviations like "falloc". Document why root privileges are
required (.needs_root = 1).

> +	while (1) {
> +		tpage = ((long long)random()) % (max_hpages);
> +		pthread_mutex_lock(&fault_addr_lock);
> +		foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
> +		*((char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
> +		pthread_mutex_unlock(&fault_addr_lock);
> +
> +		nanosleep(&ts, NULL); /* thread cancellation point */
> +	}

fault_addr_lock is not accessed by any other thread and can be removed.
Cast to volatile char * when writing back to prevent the compiler from
optimizing out the write. Replace nanosleep(&ts, NULL) with
pthread_testcancel() for thread cancellation.

> +	while (1) {
> +		pthread_mutex_lock(&mmap_munmap_lock);
> +		mmap_munmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
> +				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +		SAFE_MUNMAP(mmap_munmap_addr, max_hpages * hpage_size);
> +		mmap_munmap_addr = NULL;
> +		pthread_mutex_unlock(&mmap_munmap_lock);
> +
> +		nanosleep(&ts, NULL);   /* thread cancellation point */
> +	}

mmap_munmap_lock is unnecessary since no other thread accesses this
address; mmap_munmap_addr can be a local variable. Replace
nanosleep(&ts, NULL) with pthread_testcancel().

> +	unsigned int seed = (int)getpid() * time(NULL);
> +
> +	srandom(seed);
> +	tst_res(TINFO, "Seed = %d", seed);

seed is unsigned int; use %u instead of %d.

> +	/* First preallocate file with max_hpages pages */
> +	err = fallocate(fd, 0, 0, hpage_size * max_hpages);
> +	if (err) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "fallocate() Operation is not supported");
> +		tst_res(TFAIL | TERRNO, "fallocate():");
> +		goto windup;
> +	}
> +
> +	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	if (free_before - free_after != max_hpages) {
> +		tst_res(TFAIL, "fallocate did not preallocate %ld huge pages",
> +				max_hpages);
> +		goto windup;
> +	}

If fallocate or preallocation fails, branching to windup causes the test
to report TPASS in the subsequent check because SAFE_CLOSE(fd) restores
the free counts and thread_err remains 0. Use tst_brk(TBROK | TERRNO, ...)
to abort on preallocation failure. Also use %lu instead of %ld for
max_hpages.

> +windup:
> +	SAFE_CLOSE(fd);
> +
> +	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	rsvd_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	if (thread_err)
> +		tst_res(TFAIL, "fallocate() failed during stress, see above");
> +	else if (free_after != free_before || rsvd_after != rsvd_before)
> +		tst_res(TFAIL, "free or reserve counts incorrect after fallocate stress test");
> +	else
> +		tst_res(TPASS, "fallocate stress test passed");

Use TST_EXP_EQ_LU(free_after, free_before) and
TST_EXP_EQ_LU(rsvd_after, rsvd_before) to report free and reserve count
comparisons.

> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +}

Use if (fd != -1) instead of if (fd >= 0).

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
