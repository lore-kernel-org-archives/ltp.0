Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1175C982FA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 10:01:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 274D03E5D5D
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 12:01:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F410D3C2E03
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 12:00:47 +0200 (CEST)
Received: from mail-yx2-x06.google.com (mail-yx2-x06.google.com
 [IPv6:2607:f8b0:4864:41::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 206411400E7F
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 12:00:47 +0200 (CEST)
Received: by mail-yx2-x06.google.com with SMTP id
 956f58d0204a3-66d1a249389so359584d50.0
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790157646; x=1790762446; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HBsJf09npe4BIoBanVIal2dyJK0istopSkxA9nWBlGE=;
 b=kgTU8Kd9JHRDnqaGgV1qYjSCLc+eRMs8TtuOBO7C1xBKzagIqbkmhkXjFnJ0+21OGJ
 rvkhsg6t3xLnSrn0XpwHa9GAlO/JZk14wxBx5d8VCgACcFaKObcnEjakXK++JXgUrHa6
 Jqrvj03MNm+/KQr4yJzChBTqcN4gSmTCKf93R+yIEboD30B+1H0FT04RuK6OnVKYq9uA
 6I8KOfNvNcl9CeLvNBWcW+Krci529CYhTZJ5ee9xVmLQrCjXDBiVuyfPgACX6wR+EfaL
 PXppIxTi8yrU11nPLcIg9BEzDRXxi3jmco0Z/q+J96KXZg6wBbgxKBaWvpYbZtNdg/5a
 KVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790157646; x=1790762446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HBsJf09npe4BIoBanVIal2dyJK0istopSkxA9nWBlGE=;
 b=0g3JRsIPG6+eNc6ss3Qdhc05tI7LFIQlU58N8g19U+oeL6k1ftLLyMM5/qfdnt2Uv8
 gnDgBKmfp+NTjonB709VTc4DCHlQqhNjyCesTa6vGlNRLJt2x1qYp1A81wbg0Pd/HaI6
 2PmqVXaKbw6oqqZ5YS4MSO3G/tYSxByN1Eqdc6VdE0QQSu9s+2AsSjUIv043JNWkqwN0
 PMR6hb6tpe7awBxlBCFDBLR4oxdJAboCXo0a5yNdVgqyvzck0+m5djeXM3HOroZDbnhE
 LcLBY8xF+x0haq0p8B/7JG/bhpWRxL6g/+wVOeAoxGwQGlsLxfhvOTHAdExm6NJI3VKS
 /VGQ==
X-Gm-Message-State: AFuF++nSmuaPUqiA7vPMvDk5x7AvnKg+8dQ234GynkVcRLwkayCfoIWO
 1qg09SYXJwgKVUIpPc0v4SE5HsobM1Ey1HUUY+seNfrk7UsiA5ecEs3m
X-Gm-Gg: AYBFou0mQ08qUmim7Z51dBgvHXBTce+owa+Dw+AzO6frUoo2x3P2HYYHkv/PtY7Wdgm
 ZE5n+1sVS0pqJmGLbKgHdHrJAV8eWKXLzGNaSuF5O3LcB9Dhr1lvyORIpVZiSq6FDLaCa3gQq6A
 y168Aujz9VeftPOKjzVdXhP3VoEvHwXNBBbtvbpU7nsSQ+2sZBrgIp71UY3ESbvzMNF0BGj49Fw
 SP/UfgVfq0OVb0SeoUvc6bBiCvF2quuX3N0tJa/SbGFf9X5deM9lBuruSncCwLPSg815QPx9fGP
 cqeHb5hGfic+2Iwl8GU2LsfvcbTiohwYGDmAk/Vtlgf5D4pwrJaKaHz3PHZhf149CLjCal3Hgqu
 6yGV9vxHNc6WLD20bFS5qvOuOyMpdPAZUh98ygnHl9/tkFAnGdnaQnAtDIp8HUeBlFLQhJAdnIC
 PvZrVM+DSdm7ljMX3CmSytJ9S6tsTK8HTuUz+7Fd+QI3A9UChuyVB0QFfr3kb8cm7ZfG8nfgC+Y
 SjUsjWv/r+hL5zhQJkjFD5RmCYhasWEmLE1ogQt0wGefNVb+350rvNRCxcRVYjLDMEoxsFItu/R
 sVXTEX27Skgxv0BF1boo
X-Received: by 2002:a53:c20c:0:b0:66d:26b3:2184 with SMTP id
 956f58d0204a3-672d578c2admr662448d50.47.1790157645499; 
 Wed, 23 Sep 2026 03:00:45 -0700 (PDT)
Received: from
 runnervmtr4k5.b3yniapqfpledkdknmdvdxy3fe.bx.internal.cloudapp.net
 ([20.62.255.18]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9140c3e0873sm17001576d6.16.2026.09.23.03.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:00:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Wed, 23 Sep 2026 10:00:43 +0000
Message-ID: <20260923100043.9301-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923080150.44934-1-pavrampu@linux.ibm.com>
References: <20260923080150.44934-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

On Wed Sep 23 13:31:50 2026 +0530, Pavithra wrote:
> hugetlb/hugefallocate: Add hugefallocate03 to stress test fallocate on hugetlbfs

> +static int fd = -1;
> +static unsigned long max_hpages;
> +static long hpage_size;
> +static void *thread_fallocate(void *arg)

Add a blank line between variable declarations and function definitions.

> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);
> +
> +	fault_mmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
> +			PROT_READ | PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +
> +	pthread_cleanup_push(thread_fault_cleanup, NULL);
> +
> +	while (1) {
> +		tpage = ((long long)random()) % (max_hpages);
> +
> +		if (sigsetjmp(fault_jmp, 1) == 0) {
> +			foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
> +			*((volatile char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
> +		}

Save the original SIGBUS handler and restore it upon thread termination or in
cleanup. If SIGBUS is raised after this thread terminates, siglongjmp() jumps
to an invalid stack.

> +	while (1) {
> +		addr = mmap(NULL, max_hpages * hpage_size,
> +				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +		if (addr != MAP_FAILED)
> +			SAFE_MUNMAP(addr, max_hpages * hpage_size);
> +
> +		pthread_testcancel();
> +	}

Use SAFE_MMAP() instead of mmap() and drop the MAP_FAILED check.

> +	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	max_hpages = MIN(nr_hpages_free, MAX_PAGES_TO_USE);
> +	free_before = nr_hpages_free;
> +	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	/* First preallocate file with max_hpages pages */
> +	err = fallocate(fd, 0, 0, hpage_size * max_hpages);

Because .hugepages uses TST_REQUEST, nr_hpages_free and max_hpages can be 0.
When max_hpages is 0, fallocate() fails with EINVAL (causing TBROK instead of
TCONF), and the worker threads divide by zero. Add a check to abort with
tst_brk(TCONF, ...) when max_hpages is 0.

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
