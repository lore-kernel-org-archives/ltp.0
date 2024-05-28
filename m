Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721CBC27C43
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 14:59:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 787143D06C2
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 16:59:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AC643D0481
 for <ltp@lists.linux.it>; Tue, 28 May 2024 11:06:04 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85B2F6008EA
 for <ltp@lists.linux.it>; Tue, 28 May 2024 11:06:03 +0200 (CEST)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e73359b8fbso5886051fa.2
 for <ltp@lists.linux.it>; Tue, 28 May 2024 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716887163; x=1717491963; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h9GBjGS9fFbW/fU1vLeGXiJute0gIkIeWTpDiyJ3yp4=;
 b=YNDHSRme7M9yB126lQN9p4/a+64L1Z2VhRbiOs9nxxdMATgEtZd6fOBzhs8u+3OK/p
 yAEZMTNygMACzn02O1z3T1xCpyIIaRQPtE/59P4hHxc61bvhk3TtRqzy6jIJiiokJD6z
 rzgEJIzwjbbfSQpJk7+GFDdHR4g5gKqPh+Xa6FsbwZhmdkY1q+5VLXeEM/C01r37wXsb
 UzdLJNYJJU5L4jLMRjYj7imT3QX0AglKAPVBPwGfrQdY1rUgMsa5R8KJL7yA5KoVkkle
 ULGzBlDbn85udDmmElyoEyra0kuipUxdpyo8OBN1vN2Xa8zxi4+kh4JQmR+C3HIuke+1
 TO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716887163; x=1717491963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9GBjGS9fFbW/fU1vLeGXiJute0gIkIeWTpDiyJ3yp4=;
 b=JmYXOECYOnke3jXb8hL5NoUl/X2WsAGiB2dtK8V3FyGzX2LAItMvmF95W7TYdJG96S
 5/Gui9jsOG2wbCcQiHCdA3QB2kPdkuzS6OqwYoJoc7z+tGeort5e9DIyxkccZPWVbea3
 PHcC7+RMBYCboeyDpfCuSoHtOSeutHkJy75zLDQ2ccrGXtWs5s+tFnlLIsSPaJbhdeJ8
 +t4cyo4VETmKtaO9F1wsSrNQlzuzYor3c6y2BzNv30/Gu03Od7KgSV/v1lNHGpxZ+kQC
 wJengzple24WuVCk/UaKItwR72KK/eg59A0GdmNJudQ6awkvxwihOTDgXF/QuqvGOSdM
 9FBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6VEU1ly/ASr12OCXuNdYWVeOIwkL3VZuENjV5f7jxfZSCTzoQ4uy7mbm8zUMhhxBto+nXreTNPEM1xHO02JeWSdU=
X-Gm-Message-State: AOJu0YzF0bBZGdyJKWB4ydd4txKz88ex8bIRc++79S5hj926Gg3p0JxC
 hJS9pLkt9Z7a6YdxlXqbqzzAQ7QV5AyNBZmuPOUyvSCYkru/6I/TK/4JwnaP
X-Google-Smtp-Source: AGHT+IG7IJ8KKtLK3X6nQm3e0XhIyT4vFHu2mAvltAVPSuRSDVnJteTvWHRuSuhAbrSXJaGOw8GA5Q==
X-Received: by 2002:a2e:9c94:0:b0:2e2:a85f:f222 with SMTP id
 38308e7fff4ca-2e95b042c1dmr111346181fa.10.1716887162532; 
 Tue, 28 May 2024 02:06:02 -0700 (PDT)
Received: from f (cst-prg-92-138.cust.vodafone.cz. [46.135.92.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf06dcsm11212668f8f.106.2024.05.28.02.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 02:06:01 -0700 (PDT)
Date: Tue, 28 May 2024 11:05:54 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Dennis Zhou <dennis@kernel.org>
Message-ID: <pywb7wcml44gzgidn7mtwwr23mybbilakckchk4777wfibtruj@n4yiwwpvglf7>
References: <202405281421.127ddddf-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202405281421.127ddddf-oliver.sang@intel.com>
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

On Tue, May 28, 2024 at 02:45:35PM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "ltp.getrusage03.fail" on:
> 
> commit: 05dbad003f2b2ececb1cc7428bfa8f470cc34b95 ("percpu_counter: add a cmpxchg-based _add_batch variant")
> https://git.kernel.org/cgit/linux/kernel/git/dennis/percpu.git for-6.11
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240525
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls-03/getrusage03
> 
> 
> 
> Running tests.......
> <<<test_start>>>
> tag=getrusage03 stime=1716734654
> cmdline="getrusage03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1733: TINFO: LTP version: 20240524-4-g22004c7db
> tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
> getrusage03.c:43: TPASS: initial.self ~= child.self
> getrusage03.c:59: TFAIL: initial.children = 0, expected 102400
> getrusage03.c:66: TPASS: child.children == 0
> getrusage03.c:86: TFAIL: child.children = 0, expected 307200
> getrusage03.c:104: TPASS: initial.children ~= pre_wait.children
> getrusage03.c:114: TFAIL: post_wait.children = 0, expected 409600
> getrusage03.c:133: TPASS: initial.children ~= after_zombie.children
> getrusage03_child.c:57: TPASS: initial.self ~= exec.self
> getrusage03_child.c:62: TPASS: initial.children ~= exec.children
> 

I confirm this patch broke things, thanks for the report.

Make sure to sit before you take a look at the fix:

commit 6e8b4caf667fb6fad1c63b061e303faab6d917ef
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue May 28 04:52:10 2024 -0400

    lol

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index c3140276bb36..51bc5246986d 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -97,7 +97,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)

        count = this_cpu_read(*fbc->counters);
        do {
-               if (unlikely(abs(count + amount)) >= batch) {
+               if (unlikely(abs(count + amount) >= batch)) {
                        raw_spin_lock_irqsave(&fbc->lock, flags);
                        /*
                         * Note: by now we might have migrated to another CPU


Dennis, do I need to submit a v4? Given that this is a trivial one line
fixup perhaps it would be handier if you massaged the stuff on your
branch. I'm fine either way.

That said this really should have been reported by something.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
