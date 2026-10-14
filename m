Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1457CC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 01:59:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D47A3EB131
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 03:59:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD6C23E62B0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 03:59:36 +0200 (CEST)
Received: from mta1.migadu.com (out-210.mta1.migadu.com
 [IPv6:2001:41d0:203:375::d2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E9D114001F7
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 03:59:32 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=fxd+FLr8tKQ0vwvcwKAXmu2fxRX/JgpnFc8Oyb8t+vc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791943171; v=1; x=1792547971;
 b=IcarcL2z/IAEhXPVVBFoyTfSg15utOgT+zuEZ8SgMuCfulULXBp/iK+1k9dhLw6zHTKsJgqZ
 26/henH7klRC6EEmpAAlKmIaHixmCQ/rEWUf644Kvf+LJcOlL/aBMZKBUaPV4Hbdrj24UQse/6E
 JzC00ckPj1twNTT+cVJ3bygI=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 1b04f2ad005b7b5c;
 Wed, 14 Oct 2026 01:59:31 +0000
X-Mizu-Trace-ID: 1b04f2ad005b7b5c
X-Migadu-Flow: FLOW_OUT
Date: Wed, 14 Oct 2026 09:59:26 +0800
From: Li Wang <li.wang@linux.dev>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <as7h1cXdeV_wehHk@linux.dev>
Mail-Followup-To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it
References: <d462c7ccea7e45f489e9f8d5a04ec786de2014b6.1791780763.git.jstancek@redhat.com>
 <b6d98d03422ec30d0bf5284cd094d2ecf688efe3.1791792065.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6d98d03422ec30d0bf5284cd094d2ecf688efe3.1791792065.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] openposix: timers/twoevtimers: Wait for both
 timer signals
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

> The test arms two timers with the same absolute expiration time and
> then does a single sleep() before checking that both signals arrived.
> sleep() returns as soon as the first signal interrupts it, and the
> kernel delivers the two signals one at a time. This sporadically
> leads to failure:
> 
>   Caught abort signal
>   Test FAILED
> 
> even though the second timer fires microseconds later.
> 
> Make the counters volatile sig_atomic_t and move the printf() calls
> out of the signal handlers, so that they only touch the counters and
> cannot clobber errno behind nanosleep()'s back.
> 
> Arm the timers to expire 50ms from now instead of 3 seconds, so the test
> passes in about 50ms, and lower LONGTIME, the upper bound for when a
> signal does not arrive, from 5 to 3 seconds. Also correct the header
> comment: the timers live in the same process, not in different
> processes, and the test only checks that both of them expire, not that
> they expire at the same time.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Li Wang <li.wang@linux.dev>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
