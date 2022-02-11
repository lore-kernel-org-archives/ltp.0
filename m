Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD69C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 06:56:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A02803C9F04
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:56:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C13F3C5A4C
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:56:45 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5EB4600F84
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:56:44 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 8B6CF9FE9A
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 06:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1644562603; bh=wNPSAaVGZXHpttiQix1V/gZdoq+AOQErC9Rxb3J5zyA=;
 h=Message-ID:Date:MIME-Version:To:From:Subject;
 b=r9ESHT4pncPnALS7XEHpa/2rB4ujcH51tQkxJCsdap/l4brgghm+suiZ1MhBxUzp7
 fnWVkB7UYCwH6jDn8Cz6OUee1/XtSE7jKsqSL6AmpHqfB2CLglHpxO9d0uvpu2Ylxp
 q/Kx3BRrALbWLMRhiRrlGVhVejjL844bgBuc7U6A=
Message-ID: <83955ca7-07d4-1fcc-098d-253abf8e3f44@jv-coder.de>
Date: Fri, 11 Feb 2022 07:56:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: LTP List <ltp@lists.linux.it>
From: Joerg Vehlow <lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] hrimer-prio test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I was looking into fails with the test ltp test hrtimer-prio.

For reference here is the test description:
----
Test the latency of hrtimers under rt load.	
The busy_threads should run at a priority higher than the system
softirq_hrtimer, but lower than the timer_thread.  The timer_thread
measure the time it takes to return from a nanosleep call.  If the
lower priority threads can increase the latency of the higher
priority thread, it is considered a failure.
----

The test fails, repeatedly calls clock_nanosleep(10ms) and if the
latency of one of these nanosleeps is longer than 10us, the test fails.
The latency is measured using clock_gettime(CLOCK_MONOTONIC) In my test
on x86_64 hardware, the test sometimes fails, but mostly passes. On an
arm board it almost fails, sometimes with a minimal latency of > 30ms.

I have no knowledge of the timer subsystem, so I can't even tell if the
test is (still) valid. The test is in ltp since 2007, but wasn't enabled
until last year. So maybe the test is invalid and the expected latency
is not even guaranteed anymore or does it require a specific kernel
config or hardware (e.g. a high precision hardware timer)?

There is a kernel selftest for something similar (nsleep-lat). It only
expects the average latency to be less than 40ms, but that has another
difference, because it uses TIMER_ABSTIME instead of a relative sleep time.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
