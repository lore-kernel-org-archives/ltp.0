Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C51CA5FFF
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 06:58:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B83D3E2E84
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 08:58:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5571E3E2E27
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 08:58:28 +0200 (CEST)
Received: from mta1.migadu.com (out-239.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ef])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA0281000996
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 08:58:27 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=NPVJqpx9sjogz/zTXkXj1YwoGCRJ4HfzGxlp9uXy7uE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791356306; v=1; x=1791961106;
 b=XgnzFZYsJnqupPhUFKEoY3ptzdzBa5ax4f2lvx0fqammXJ8oUSEP+XfNJBp7s5jJnOh9kTBD
 yon10yrJmXrjdMvZyzOemJxzlv8TKy3cKHtCWZRF0/dstxz18yDB8FDc1PyKSls646kCxm/iNji
 g2F8VBHEXc3decCZ6CX5LSlc=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 36108629330532ac;
 Wed, 07 Oct 2026 05:51:02 +0000
X-Mizu-Trace-ID: 36108629330532ac
X-Migadu-Flow: FLOW_OUT
Date: Wed, 7 Oct 2026 13:50:55 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asXdv7lYtcqf4izc@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
 <20261006-fix_simple_bugs_core_lib-v1-1-c94199a46ec5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261006-fix_simple_bugs_core_lib-v1-1-c94199a46ec5@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tst_timer_test: Fix out-of-bounds array access
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 06, 2026 at 03:02:37PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Both outlier and early-wake loops in do_timer_test() evaluate
> samples[i] before verifying that index i is within bounds.
> When all samples are outliers or early, this causes heap buffer
> overreads at samples[nsamples] or samples[-1].
> 
> Check index bounds before indexing the samples array.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
