Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51D4C43602
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782982738; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YdIEtaUrFTI6MGXuYe2TenUx5LOejwfoWQPwjpZtgzA=;
 b=BQoJTG1VuqCeoEPm6xVi85oEW+M2WlvIoZscXq/HFtDuBif4bkmf+ppuvuxH1u+om4XlW
 V6zl2H3FSCgELR57dvTWolNfXoHU63xMwJkYT1YeEhhHr9PAkhCUe7PNrNl+yvN+gIpd8hN
 b7D35bK7G55s5LXkpnRg5Ipl2pDQPAM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40E9A3E4A1E
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 10:58:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 768353C5EE8
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 10:58:32 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ABA74600720
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 10:58:26 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso2206685e9.0
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782982706; x=1783587506; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hLZpquGmzj6WeglEPrY3nQQE02foGndok9PBTN3XA2g=;
 b=LRNvFL9SM2XY78aqAfBS4z7V1d9Z4FRhylGn43MNXUweS46TIzOmSL7Uk0dVky+Yrb
 7c324BujYFzlJHQzFiUPO7p5VEBsownNA/4N8btz8Fa7CboZDIRgYe8mwd74FcsqE2Nj
 s1eA5WgZARAdiRrUZYPtkRbfMVeftyvtX51Mt3xuUVTut3OUedUR80M6EZl+3H/+VP/J
 1f/SVJizcNHEmSYYln2w+82B8x8RebyX3LihwuVif4khiRjnjBYukaKRk1Zogb3S477F
 GrqkexQBqqbzLyStDyvw8RxuJ8ztwlch48ottqUDgcjlHgNXFKVTSdaY7/XLM0AkUjHK
 qHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982706; x=1783587506;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLZpquGmzj6WeglEPrY3nQQE02foGndok9PBTN3XA2g=;
 b=LYPHP+QjvixTpX3hTq/KnNALDAjXBhRLwC/PfEZkg8Ax+nm/HpQs4lhuWzmIJo6Yiy
 nz2rak/TSKK+eWCW/JfBvnnzpeEt5Xelg7kmByWahIXIYviNRxxniLY7EY+m6ES3SzfU
 EonEcjbsACdDF1mMKnB1GBPL4akWK8/pVzV6mXYV0UfYOodorb/D+CuHQYhgZV/yzjfa
 RghnAaWNKnAqraOmK8xonZzz+V51LtJ8anxkiAH6fO+p8TU24Nff4pfAXamrsyq2B4Xn
 2v6YhDz93G141h0g6GRMW9fB+YL0MLypP5eCseEyyqoeKF/XpI4EnZM084XLPTDzVlxB
 0EZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gGiSLlRENneoGXRh2jI+VmuLhRTbW32ViHLcDb8aYkSBoHHPt5/dfz/kqA6MOnKiz9T4=@lists.linux.it
X-Gm-Message-State: AOJu0Yw19uFImzBImuIKobbB8IgpXyOnfPG89RbLxKrzMQurrUHuX0VA
 Kz84ohsdnyGZe4jiU3coyqTP2gI6X6m+lloP/oVLt+1J9dLan5q7gBzxEGptzDrZ0YkHTJrSD//
 2zyUnMcd2Kg==
X-Gm-Gg: AfdE7cl+qYesKqYmmplQBbCkaxa5usOIJFHCTSgOUSilGsagXH8YNny77XH3/gGmxNX
 f7DOPAmZLdfHBlhRZjTgV3tWbcjgEizDjh0GyrFek4keZSzIP35E5Lpw2XtGfCRh9l8B4/YbbFo
 sHZ8YoV4nvg7pfWpyPbZHRZqFnzYA/tHJ7De+G9LIR6UtubgQY//tHGo+fjiauusUoKJ95/hvRp
 0UzetxkKXilLMXMdq5WgcMy9CCSnj0Ub2LBJz5ihfrF0BadMSrQfLmiBTsKLpgdSwVsB3RXjcix
 yLPIMu0fRwZdHIJpSPZjTHOMsdkKCZdm57FqGyQoREiQZlnxStMgrE+E+2gFtgHJ11iDY0AXyVZ
 hvVeKoZkwHclMD81Z6+4oMXYNv5YH3f7zN7g3P7bfWTtkKR+27ujANFYWJwbnDgyStbdZXnP7Xu
 II8c9T+aOGBrDCTdKtjOCAEMVHHFZlBQDJOpj99hfzlHDHUwqD3tpOWFh/Yf6wfc5bc9b6y78ud
 0V5uhhqv8GW8xFWyo7jgyw4SopAqO2aL0GvME8ifHGf/mNnhjLxuXXCDS83CZXIKWvoM5OBG7LE
 /A==
X-Received: by 2002:a05:600d:c:b0:493:8391:919a with SMTP id
 5b1f17b1804b1-493c2b433dbmr65735185e9.16.1782982706111; 
 Thu, 02 Jul 2026 01:58:26 -0700 (PDT)
Received: from p200300ef2f13eb00a65561a8bfe9e52d.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6375764sm28612565e9.5.2026.07.02.01.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 01:58:25 -0700 (PDT)
Message-ID: <6a462831.25509765.22e979.4fe7@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260701122826.4115-1-linuxtestproject.agent@gmail.com>
Date: Thu, 02 Jul 2026 08:58:25 +0000
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> The patch drops lapi/mmap.h but the test still uses MADV_HUGEPAGE (in
> alloc_zero_page) and MADV_DONTNEED (multiple call sites). The fallback
> defines for these constants live in lapi/mmap.h. On toolchains where
> <sys/mman.h> does not provide them, this will fail to compile.

This is correct. Please always use lapi/mmap.h instead of the
sys/mman.h. In this way we are sure to fallback to an existing
value and LTP compiles in any machine that doesn't have those
definitions.

> 
> > +static void run_proc_mem_ptrace_race(void)
> > +{
> > +	/* After 1000 iterations, let tracee exit cleanly */
> > +	SAFE_PTRACE(PTRACE_CONT, tracee_pid, NULL, NULL);
> > +	SAFE_WAITPID(tracee_pid, &status, 0);
> 
> After run_proc_mem_ptrace_race() returns, the tracee has been reaped.
> If the framework re-invokes run() (e.g. via -i 2), the next call to
> SAFE_OPEN("/proc/<pid>/mem") will hit ENOENT and abort with TBROK.
> 
> The PROC_MEM_ALWAYS path survives re-invocation because
> tst_fzsync_run_a() returns false immediately when runtime expires. The
> ptrace path could either re-spawn the tracee in run(), or guard with
> an early return when tracee_pid is no longer alive.

This is also correct. Always run the test with `-i` as well.
Also, take a look at tst_reap_children(), because it looks like
we are duplicating the same functionality with SAFE_WAITPID() here.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
