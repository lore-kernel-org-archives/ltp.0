Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E57CD98D2
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:22:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFA3F3E6B37
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 21:22:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E117F3E2A97
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:21:51 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9DAE56006D4
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:21:45 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-9157b949fc7so136894585a.3
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781292104; x=1781896904; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VpHNuS+9sUyuxNVwRfY5YkFJpNpJg5W14zvMFG1ieA=;
 b=lNZveHrG/bHs99DbZ8b745DesTK65E3r8Og8MGhtoie4X8b+aUt8KTogyvzzY64lH6
 8nBHMWIX/ljF/mXGetfJ6ZFjqGvLTJG0qSVHLHDjYUZ5eyC788PT/4w3Aw5bGWQ7rdXz
 qGWsm1nT/aBq8rlELo3bEDMe6n9yJ/3Abamk18FXA4t8x2Zb7I53e8vAQXCCPCROtLHl
 R1TWVZNmC0HjQTCPaa7PY0DRCfDL47iUp0Eq3GkApkPerB60UJfi6k46+vrOlbghn3+n
 AGsBF1xD/ZNtz932pzez1aijx1gJE1qUGGSPnP5fZ8qPBMK3niEvXtE2/kn2vYnD9fAU
 Jk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781292104; x=1781896904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8VpHNuS+9sUyuxNVwRfY5YkFJpNpJg5W14zvMFG1ieA=;
 b=gQkEVZKXzaO8JTV6mX00GlbNQnQqzh/9+qL1fzshbQbwDjOjFSAxCuEtocSXbEnmp0
 j1lZdpw1ofWjTYF4x8WFecjgE9mZk9VjwZsGX12Zc9nmnNVh8HR5SWNKR+HsFK9pRxbI
 BASrGQiPbgKZVh4w+BuwCgBIrn3qd+eKXRM2rzUEX8Iw2arZPRoF86ApyfGX2g0DVxMt
 3rasLFTIFPXaruuPZP9GqvxR0ZnJUQZdaAl9gYLnctC7pgl82ew/78oPxdzEQiUQJr1p
 e7vt9Nijs71FKLniTGQg4yBSNQbEApuX/Q06p9KdIM4zB9VMaBz6b9c5htbIUM2SzZkt
 C4Yw==
X-Gm-Message-State: AOJu0YzLac9GS7vweUOhnBWRuTPfkbqy6n1mwwSsDr1O+XXEkixn56cg
 IJgyOrhlcPW88BEJ9oJ5I7xeUZSprOUvgsmIWAhoy4UZ3JfPH5FkrqXYFUvDwsye
X-Gm-Gg: Acq92OFrPEJFqwQl170cJYDAQCKNgHRO1OC/NRLAWdADZeTvyXoqjERb0VnKReIQIJS
 DbZ/mV6Jb7IKkOKjG96mlyA5Q2m5raxVMSErWLMf9DV3spvDhDbCff/zMlDNSp4IrwGjtl0Chqb
 1L2RNw7DTLEZePQPCai/va/0iKdvnJ3agKMgJOQ6MB/oLJ4GN0fl6FSTjYpENbf3HXno0gRxvFI
 +6WqgwmjdjaJlqnQa+ckI8O2uT0BfXWDD3q1aQ3YtCmQxGYJXOES6hYMIKXlKmY35N3jFtOH1qN
 PT/E6kOmv5Y6nFrSlvTCWFaIbFVKcuOcssp+nev71HBuqYz5K/PSXzFQ97x7rW5XlgY4v/eFeyO
 IzIp6IDBcV+b1qR46fwaIldcHMdkPUyOBphCFCHWMgIpTJp8gBiYr8ZOAj9lrBJPkGPzIZR9t2H
 0NIfjmyiMVYpPv9qszLIBi41Hmeqzb/cAFor5BAw9QJYJA1XpmOtgapOfruvOdrhvLtSoMM8ter
 OVbYAAClT1/VP70LJAD8YQ15PCVt32wBHXkTr+k
X-Received: by 2002:a05:620a:2904:b0:915:9fba:878f with SMTP id
 af79cd13be357-9161bab4562mr608227985a.5.1781292104349; 
 Fri, 12 Jun 2026 12:21:44 -0700 (PDT)
Received: from
 runnervm1li68.ul30arpzjjae5mt5wo1entlhwg.ex.internal.cloudapp.net
 ([64.236.153.152]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a006e35sm299784585a.28.2026.06.12.12.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:21:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Fri, 12 Jun 2026 19:21:42 +0000
Message-ID: <20260612192142.4221-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612171712.324175-1-japo@linux.ibm.com>
References: <20260612171712.324175-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Fix PTRACE mode for CONFIG_PROC_MEM_FORCE_PTRACE=y
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

Hi Jan,

On Fri, 12 Jun 2026 19:17:07 +0200, Jan Polensky wrote:
> thp04: Fix PTRACE mode for CONFIG_PROC_MEM_FORCE_PTRACE=y

> -	fzsync_pair.exec_loops = 100000;
> -	tst_fzsync_pair_init(&fzsync_pair);
> +	child->readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
> +	child->fzsync_pair.exec_loops = 1000;
> +	tst_fzsync_pair_init(&child->fzsync_pair);

> +	/* In PROC_MEM_ALWAYS mode, child does writes itself */
> +	if (proc_mem_mode == PROC_MEM_ALWAYS) {
> +
> +		/* Simplified test loop without thread */
> +		for (i = 0; i < 1000; i++) {
> +			/* Write via /proc/self/mem */
> +			SAFE_LSEEK(child->writefd, (off_t)child->write_ptr, SEEK_SET);
> +			SAFE_WRITE(SAFE_WRITE_ALL, child->writefd, &c, sizeof(int));
> +
> +			/* Call madvise on write page */
> +			madvise(child->write_thp, child->thp_size, MADV_DONTNEED);
> +
> +			/* Call madvise on read page */
> +			madvise(child->read_thp, child->thp_size, MADV_DONTNEED);
> +
> +			/* Check if read page was polluted */
> +			if (*child->read_ptr != 0) {
> +				tst_res(TFAIL, "Huge zero page was polluted");
> +				return;
> +			}
> +
> +			usleep(100);
> +		}

The original test used tst_fzsync to race the /proc/self/mem write
against madvise(MADV_DONTNEED) in a separate thread. That race is
the mechanism that triggers CVE-2017-1000405: the kernel must
handle the COW fault concurrently with page reclaim to corrupt
the huge zero page.

This replacement runs write, madvise, and check sequentially in a
single thread with no concurrency. The vulnerability cannot be
triggered without the race, so the test becomes a no-op for
detecting the bug in PROC_MEM_ALWAYS mode (the default on most
systems).

The fzsync_pair is still initialized and cleaned up but never
actually used for racing (no tst_fzsync_run_a/b calls), and
readfd is opened but never read from. These are dead remnants of
the removed race mechanism.

Could the fuzzy sync race be preserved for the PROC_MEM_ALWAYS
path while adding the new write-stop-continue cycle only for the
PROC_MEM_PTRACE path?

> +	proc_mem_mode = PROC_MEM_ALWAYS;
> +	child_setup();
> +
> +	TEST(lseek(child->writefd, (off_t)child->write_ptr, SEEK_SET));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "lseek on /proc/self/mem failed");
> +
> +	TEST(write(child->writefd, &test_val, sizeof(test_val)));
> +
> +	if (TST_RET == sizeof(test_val)) {
> +		proc_mem_mode = PROC_MEM_ALWAYS;
> +		return;
> +	}
> +
> +	if (TST_RET == -1 && TST_ERR != EIO)
> +		tst_brk(TBROK | TTERRNO, "test write to /proc/self/mem failed");
> +
> +	/* /proc/self/mem write failed, cleanup and try ptrace mode */
> +	child_cleanup();
> +	SAFE_MUNMAP(child, sizeof(*child));
> +	child = NULL;
> +
> +	if (explicit_mode && proc_mem_mode == PROC_MEM_ALWAYS)
> +		tst_brk(TCONF,
> +			"Writes to /proc/self/mem disabled despite always mode");

The unconditional assignment `proc_mem_mode = PROC_MEM_ALWAYS`
before the probe destroys the value parsed from the kernel command
line. When the user explicitly sets proc_mem.force_override=ptrace,
this sequence occurs:

  1. Kernel cmdline parsing sets proc_mem_mode = PROC_MEM_PTRACE
     and explicit_mode = 1.
  2. Line 294 overwrites proc_mem_mode = PROC_MEM_ALWAYS.
  3. The probe write to /proc/self/mem fails (expected in ptrace
     mode).
  4. The check `explicit_mode && proc_mem_mode == PROC_MEM_ALWAYS`
     evaluates to true because the overwrite at step 2 lost the
     original choice.
  5. The test exits with TCONF "disabled despite always mode"
     instead of falling through to the ptrace path.

The user's explicit ptrace choice is silently discarded. One fix
would be to save the parsed mode in a separate variable (e.g.
`user_mode`) before the probe and test that at line 316 instead
of proc_mem_mode.

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
