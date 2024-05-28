Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A2EC27C43
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 15:00:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A018F3D06C5
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 17:00:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9626A3C00E4
 for <ltp@lists.linux.it>; Tue, 28 May 2024 22:37:08 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99978601104
 for <ltp@lists.linux.it>; Tue, 28 May 2024 22:37:07 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2bdf69d387eso1056104a91.0
 for <ltp@lists.linux.it>; Tue, 28 May 2024 13:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928626; x=1717533426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocGhciDIymjtV72cJYX7TD5dK3LYFKmjLW2hh9YZxCU=;
 b=iSTzypGEUclWml909bgvdQM4OZ6Z08dlVhbJvhmJbVnfO/9q9OPoEngEdYNTudGXIG
 cJs02MoeldkjfuAmtUlTRK2C3o2KWVwJpROMFwHRVTgYSIeY0FqeFzu0yKSRnhOkep/8
 LJ1mZ1p/pqA8ztq3zU/467UHGQNtA0RuFuwqKweXHYqPaJpcnyjlaIoo6Iy7rS2iamVI
 YzsB2ifIYUqobc0pU5W3DN0f9b8QL4JaUipM7lXNyX8mEyrqDc1Vj1BrtxfFSznLdKup
 cT/cmKt+RFFud0cOSlY3w6HwVrEdqmkkyKGj3gt9ejgH6PpQmQ8JO4BLYAY4Y2+LfqhW
 hocg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE4v30uyaXW0RDs8/AI0vw/gq+UFuLiqgDEGQi0Jk0BuT4kkRAWqKszZ0KttVK1yFLew3wimEzVCBxZclGjLS+2rg=
X-Gm-Message-State: AOJu0Yy//x90OFA7hdjkV2mr88CZjeR8OfBudCzFYfF9jPTN+/FHNTT6
 4Z52K/dd42gQ+cwuz8fNylROj3sjVXv13o1WhbH9KmFXOY5fBs8E
X-Google-Smtp-Source: AGHT+IGkLYLgbQKRVPQzy0nbn4TlmHHj/65jHN2jLz0MG1BUJjlY4P+swh2Vt91PtfsBBifZf+g61Q==
X-Received: by 2002:a17:90b:f89:b0:2bd:92e7:c305 with SMTP id
 98e67ed59e1d1-2bf5f10a44bmr13066160a91.21.1716928625840; 
 Tue, 28 May 2024 13:37:05 -0700 (PDT)
Received: from snowbird ([136.25.84.117]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f50c3fdsm8267619a91.18.2024.05.28.13.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:37:05 -0700 (PDT)
Date: Tue, 28 May 2024 13:37:02 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <ZlZAbkjOylfZC5Os@snowbird>
References: <202405281421.127ddddf-oliver.sang@intel.com>
 <pywb7wcml44gzgidn7mtwwr23mybbilakckchk4777wfibtruj@n4yiwwpvglf7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pywb7wcml44gzgidn7mtwwr23mybbilakckchk4777wfibtruj@n4yiwwpvglf7>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 May 2024 16:59:19 +0200
Subject: Re: [LTP] [dennis-percpu:for-6.11] [percpu_counter] 05dbad003f:
 ltp.getrusage03.fail
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
Cc: oe-lkp@lists.linux.dev, linux-mm@kvack.org, ltp@lists.linux.it,
 lkp@intel.com, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, May 28, 2024 at 11:05:54AM +0200, Mateusz Guzik wrote:
> On Tue, May 28, 2024 at 02:45:35PM +0800, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed "ltp.getrusage03.fail" on:
> > 
> > commit: 05dbad003f2b2ececb1cc7428bfa8f470cc34b95 ("percpu_counter: add a cmpxchg-based _add_batch variant")
> > https://git.kernel.org/cgit/linux/kernel/git/dennis/percpu.git for-6.11
> > 
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20240525
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: xfs
> > 	test: syscalls-03/getrusage03
> > 
> > 
> > 
> > Running tests.......
> > <<<test_start>>>
> > tag=getrusage03 stime=1716734654
> > cmdline="getrusage03"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > tst_test.c:1733: TINFO: LTP version: 20240524-4-g22004c7db
> > tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
> > getrusage03.c:43: TPASS: initial.self ~= child.self
> > getrusage03.c:59: TFAIL: initial.children = 0, expected 102400
> > getrusage03.c:66: TPASS: child.children == 0
> > getrusage03.c:86: TFAIL: child.children = 0, expected 307200
> > getrusage03.c:104: TPASS: initial.children ~= pre_wait.children
> > getrusage03.c:114: TFAIL: post_wait.children = 0, expected 409600
> > getrusage03.c:133: TPASS: initial.children ~= after_zombie.children
> > getrusage03_child.c:57: TPASS: initial.self ~= exec.self
> > getrusage03_child.c:62: TPASS: initial.children ~= exec.children
> > 
> 
> I confirm this patch broke things, thanks for the report.
> 
> Make sure to sit before you take a look at the fix:
> 
> commit 6e8b4caf667fb6fad1c63b061e303faab6d917ef
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Tue May 28 04:52:10 2024 -0400
> 
>     lol
> 
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index c3140276bb36..51bc5246986d 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -97,7 +97,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
> 
>         count = this_cpu_read(*fbc->counters);
>         do {
> -               if (unlikely(abs(count + amount)) >= batch) {
> +               if (unlikely(abs(count + amount) >= batch)) {
>                         raw_spin_lock_irqsave(&fbc->lock, flags);
>                         /*
>                          * Note: by now we might have migrated to another CPU
> 
> 
> Dennis, do I need to submit a v4? Given that this is a trivial one line
> fixup perhaps it would be handier if you massaged the stuff on your
> branch. I'm fine either way.
> 

Well that's awkward.. Can you please send a v4?

> That said this really should have been reported by something.

That's fair. I think I starred at parenthesis for too long that day so I
missed it too. The nice thing is these branches get longer running CI so
we can track these things.

Thanks,
Dennis



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
