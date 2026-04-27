Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD8CFF8860
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 12:26:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DFE93DB86B
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 14:26:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 808D03CCF96
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 14:26:10 +0200 (CEST)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9CA760070B
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 14:26:09 +0200 (CEST)
Date: Mon, 27 Apr 2026 20:26:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777292768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lwIBuiYjVjcICV7K/Kpln/buqmHNbh941p6cTKuPOuo=;
 b=JM5NRirmCbmT5cHu3tgpMG1WKzKcOVf4Qr+ittYS2vJAihLUotwC9sVwUraegzQhh/vNNR
 9/qfBoFjBP37YzRCO7dUBF16WDOfrI20/737C5HIbUXPK6H10rybcqwGje6LDGOfaM7AIK
 abHQqUFVwmSypbtShptVw2w8kl9Jkto=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Wei Gao <wegao@suse.com>
Message-ID: <ae9V2BKpMIFi3nnK@linux.dev>
Mail-Followup-To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20260427115941.31945-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260427115941.31945-1-wegao@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap
 space
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

Hi Wei,

Wei Gao via ltp wrote:

> mmapstress06 is designed to stress the mfile_swap kernel primitive, which
> manages shared anonymous memory. On architectures with large pages (like
> 64KB on ppc64le), the test's hardcoded request for 32769 pages results
> in a ~2GB mapping. So in suse test system configured with 2GB of RAM and
> no swap space, the test will fails with following information:
> 
> mmapstress06: errno = 12; large mmap failed
> for this test to run, it needs a mmap space of
> 32769 pages
> 
> The failure occurs because the 2GB request cannot be fulfilled within
> the 2GB RAM limit without swap backing. Since the test specifically
> intends to exercise swap-related logic (mfile_swap), it should be skipped
> with TCONF when the system lacks swap space.

Since we do have MAKE_SWAPFILE_SIZE macros, I guess we could create
a dedicated swap-file for the testing on those system?

And, it'd be appreciated if you can convert it into new LTP API.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
