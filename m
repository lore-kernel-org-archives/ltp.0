Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C6ACD6E5D
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780235512; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wcunlBX7mPx0OqW33JdD1pNDLxqHUdJfEMf6Gjhyggg=;
 b=b1NzrcOQY/FdiU0etqRuf1ku6GnT8eFr2vHbEKMae2bXS3ERITkEsV4YvL8E60cugO38x
 jsV0uXST2SpK9UZ5ne7DbX2beAzLMugBiVhF/F+sGQTlVCTFimYiTxcoOmIu2/JbmxOFQsH
 5k61RBomAD88WoJUZ7cTuM33X9LrUAE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3830E3C560C
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 15:51:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 019743C560C
 for <ltp@lists.linux.it>; Sun, 31 May 2026 15:51:28 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BE0452000B2
 for <ltp@lists.linux.it>; Sun, 31 May 2026 15:51:26 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490a7629893so5580975e9.0
 for <ltp@lists.linux.it>; Sun, 31 May 2026 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780235486; x=1780840286; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7tDkemwlFo3tsNAu2nSScwETph25ciceve3vQM7fpv4=;
 b=BRkgBx4+2Ixnqrt7vd7gCg+S5D7q6xwc6DLXug4Z4DE19raR82mzq7yFWn8LN9NpVO
 nfIHasBb6ovh4yUnCwxE8sDfsMk6CkNFse/hZVOi30yQA4BG2D0dYrtfRMwQAFXl3oh2
 yajrB7ZNGFoTaa3tc3dBUpTgBuukNYeNG8uXQ+VQMOh8KrOUK3booCTB95dkNjw9Fl6+
 qXSUYW4NW3HJCD7rRqSmLJfB13ovLCxa1JxQU6a3paqigwyMkwkOBoVQGVjK18mhKlkM
 83jS4fvF7NNLagdPA/99glIVbiAqaoLrkx3H4PvqTEiH601CdMLjRMpcjc0NIagLo1bQ
 RDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780235486; x=1780840286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tDkemwlFo3tsNAu2nSScwETph25ciceve3vQM7fpv4=;
 b=kO27Tm2K60jPzhaDYrGnC8FgRJe9kmr8tqWGM0FtcvJv6qr5RoWSFav+Z6GxYU8kjf
 av7ZqSm7/i7I4Bm2O5flt/g8f/aky9XSB2Xf1FdnIyM8RyORj7Y8ufceZUOESnQq/axH
 WjLy3jN46mvePUUnTQ6ESMdenv/fL6YLwTrIVN3uCEu9V7lmG2lPfpHO3kAWFEqLmr1J
 eg5g4A1EOWTqpnep/d7/ds+RK8PpPSNx4DWbjHPVib4bCxQsmYyyTQ5LwWZ5wA9lmjvh
 T3pyOfKV/yiDfnZSsfW8dPu358OVIh6SHS0ozdwL4wkXrKcKeLyGJp8P4mEioNY7/CeZ
 SvoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i+6VI0P9/bSNvMhkF8r5GbY1cJhyCeC4WIiOyZJVHeJwmYA91f0FOnpDW12xkX4mpTbs=@lists.linux.it
X-Gm-Message-State: AOJu0YyAoVA+XJENJ6vyRX5dOoqyllj3yLhrpyLWuGVEzQ/CvdJg/w/s
 +nKbehqKV55fDkM9SzLPqiN1EdKG9gOVwg0Wph3np6Tronl1e4YsLSnxKbPPgntZVjQdHODxbGE
 HiLU=
X-Gm-Gg: Acq92OEZ1m+Fkg66SlNhxMKZL1YtJ7gKeYh4MuzTbrjG5Ep3WUTkGiNAaYsFGs7O0/w
 mpbYk1UecCn9JDDhVsmu3Rd4u7GAmGSPywKTGya/joBAt+isKLp7qZ8w7TWQ0Gx3GJRe1LMFThK
 o7fANkP84lr2NvxLBqlM+a+M1I3yhvYPDSl+JXE+WwBrwV3MRPrpWq+SbAMMOW2EXBe2i4dEfS5
 CDxITY51sWD3AalO3ZaqOYGfeOiQq9LG6jbo+2qNKdfGNOqdmxix9RSyNr1eFpr8o3ff7C6Lr+M
 3eEVmq3VoUQ1kna00wjrg1mRItvAN0CRC082kcgBom5vbWVXRZ6bVnnsKo7P7GxV2rTCmGUR/pO
 BfXVGsbGWwzgxdeD9SqrgZeXwFHLULwP5B8rkgpNMu04E+mYGGtTRv6cpMUa3xFdoUcz8s3xOGc
 S51wqzNhkMsAz4h1MizNYAowiY9LyEBkMMqNil9Hcuw8ZXSmpQhRo=
X-Received: by 2002:a05:600c:2a8a:b0:490:44eb:c1ec with SMTP id
 5b1f17b1804b1-490a293cf3bmr89670265e9.27.1780235486133; 
 Sun, 31 May 2026 06:51:26 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cab7b00sm188867695e9.14.2026.05.31.06.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 06:51:25 -0700 (PDT)
Date: Sun, 31 May 2026 13:51:24 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ahw83IPF8_y8yvHj@autotest-wegao.qe.prg2.suse.org>
References: <20260527050843.14963-1-wegao@suse.com> <ahcQd-5ffiCDU8IE@yuki.lan>
 <20260529160708.GA287653@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260529160708.GA287653@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem/min_free_kbytes: Add grace period for
 memory reclaim
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, May 29, 2026 at 06:07:08PM +0200, Petr Vorel wrote:
> Hi all,
> 
> 
> > I think that we also want to change the test so that the monitor is
> > started and stopped for each testcase with a specific value we set the
> > min_free_kbytes to. Running it asynchronously like this may mean that we
> > will be looking for a wrong value for the second if we are unlucky. But
> > that can be done later on.
> 
> @Wei Unfortunately this does not help on the current stable kernels (at least
> not on 7.0.10 on Tumbleweed. We discussed it with Vlastimil Babka and Cyril
> Hrubis and the conclusion  is to start with running the monitor synchronously
> with each subtestcase and making sure MemFree is big enough before we start the
> monitor and the process that creates memory stress.
> Also, please rebase when doing changes.

Base my latest v3 patch test result, it can pass Tumbleweed test now.
And if you check the log of patchv3, there is always big enough mem
before we start monitor, so i do not think monitor synchronously can
help, only increase pool time and threadhold can help.


tst_test.c:2042: TINFO: LTP version: 20260529
tst_test.c:2045: TINFO: Tested kernel: 7.0.10-2-default #1 SMP PREEMPT_DYNAMIC Sat May 23 12:09:09 UTC 2026 (bb95589) aarch64
tst_test.c:1864: TINFO: Test timeout is not limited
min_free_kbytes.c:89: TINFO: Setting /proc/sys/vm/overcommit_memory to 2
min_free_kbytes.c:93: TINFO: Setting /proc/sys/vm/min_free_kbytes to 45056
memfree is 1200068 kB before eatup mem   <<<<<<<
memfree is 74972 kB after eatup mem
min_free_kbytes.c:95: TINFO: Setting /proc/sys/vm/min_free_kbytes to 90112
memfree is 1680500 kB before eatup mem   <<<<<<<
min_free_kbytes.c:224: TINFO: MemFree recovered to 93868 (min 98%, avail 0) after 1 retries (~10 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 96684 (min 98%, avail 0) after 1 retries (~10 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 94712 (min 93%, avail 0) after 1 retries (~10 ms)
memfree is 94760 kB after eatup mem
min_free_kbytes.c:103: TINFO: Setting /proc/sys/vm/min_free_kbytes to 40165
memfree is 1655360 kB before eatup mem
min_free_kbytes.c:224: TINFO: MemFree recovered to 40748 (min 99%, avail 0) after 2 retries (~20 ms)
memfree is 75220 kB after eatup mem
min_free_kbytes.c:89: TINFO: Setting /proc/sys/vm/overcommit_memory to 0
min_free_kbytes.c:93: TINFO: Setting /proc/sys/vm/min_free_kbytes to 45056
memfree is 1727596 kB before eatup mem
min_free_kbytes.c:95: TINFO: Setting /proc/sys/vm/min_free_kbytes to 90112
memfree is 1716960 kB before eatup mem
min_free_kbytes.c:224: TINFO: MemFree recovered to 92648 (min 96%, avail 0) after 4 retries (~40 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 91488 (min 85%, avail 0) after 9 retries (~90 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 90348 (min 69%, avail 0) after 28 retries (~280 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 98264 (min 79%, avail 0) after 27 retries (~270 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 92440 (min 80%, avail 0) after 14 retries (~140 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 91864 (min 72%, avail 0) after 27 retries (~270 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 94816 (min 86%, avail 0) after 4 retries (~40 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 92680 (min 86%, avail 0) after 3 retries (~30 ms)
min_free_kbytes.c:103: TINFO: Setting /proc/sys/vm/min_free_kbytes to 40165
memfree is 1651044 kB before eatup mem
min_free_kbytes.c:224: TINFO: MemFree recovered to 45152 (min 94%, avail 1252) after 4 retries (~40 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 55620 (min 91%, avail 7644) after 1 retries (~10 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 46452 (min 72%, avail 0) after 2 retries (~20 ms)
min_free_kbytes.c:89: TINFO: Setting /proc/sys/vm/overcommit_memory to 1
min_free_kbytes.c:93: TINFO: Setting /proc/sys/vm/min_free_kbytes to 45056
memfree is 1703808 kB before eatup mem
min_free_kbytes.c:224: TINFO: MemFree recovered to 53224 (min 87%, avail 11664) after 1 retries (~10 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 53500 (min 98%, avail 10556) after 1 retries (~10 ms)
min_free_kbytes.c:95: TINFO: Setting /proc/sys/vm/min_free_kbytes to 90112
memfree is 1664820 kB before eatup mem <<<<<<<<<<<<
min_free_kbytes.c:224: TINFO: MemFree recovered to 91172 (min 68%, avail 0) after 73 retries (~730 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 92996 (min 78%, avail 0) after 14 retries (~140 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 91500 (min 72%, avail 0) after 94 retries (~940 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 92760 (min 91%, avail 0) after 9 retries (~90 ms)
min_free_kbytes.c:103: TINFO: Setting /proc/sys/vm/min_free_kbytes to 40165
memfree is 1654728 kB before eatup mem
min_free_kbytes.c:224: TINFO: MemFree recovered to 41508 (min 96%, avail 0) after 1 retries (~10 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 41984 (min 96%, avail 0) after 1 retries (~10 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 52068 (min 93%, avail 3480) after 1 retries (~10 ms)
min_free_kbytes.c:224: TINFO: MemFree recovered to 47720 (min 98%, avail 0) after 1 retries (~10 ms)
min_free_kbytes.c:79: TPASS: min_free_kbytes test pass
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
