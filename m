Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A2C61DC6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:01:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 452B83E5DED
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:01:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1CBD3CE420
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:01:15 +0200 (CEST)
Received: from mta0.migadu.com (out-60.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::3c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EC170600B01
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:01:14 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=K7rjE1ciMo3XbVocFNVXUEWD/XeWotLks0Fm/DCj65w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787907673; v=1; x=1788512473;
 b=DyWYEg/FLPveydyFNJkicxNLeEqhV+pf1uCH9h6FGVZN+asYub5J1FeLg4xKu97SaL5n+Slr
 Tfw7/CkumpPdCAIpH65tV5irPEtzfMbjDNzcgjouFti0ZZq/gwCk2MWNqeVOE8wc28WK87p1uMU
 jyfTbPDhfoLuzXl349rjJKwI=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id fb75bcfb516b29de;
 Fri, 28 Aug 2026 09:01:13 +0000
X-Mizu-Trace-ID: fb75bcfb516b29de
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 17:01:02 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <apFOTreIdNbi2U72@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <6a91470b.7557dadb.15e29c.77e9@mx.google.com>
 <6a914b26.1f1211b9.7a419.d9d7@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a914b26.1f1211b9.7a419.d9d7@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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

> > this is interesting. Also I notice how it's hard to read the logs, so
> > I need a TINFO before the checks. But technically, this could be a kernel
> > bug: can you please add a sync() before stat() while we are getting the
> > blocks_after? We might need to flush the cache before reading the blocks.
> > 
> > 	fd = SAFE_OPEN(BACKING_FILE, O_RDONLY);
> > 	SAFE_FSYNC(fd);
> > 	SAFE_CLOSE(fd);
> 
> sorry, this should stay after the tst_fill_file()

Great, this works!

I think the fsync after tst_fill_file() ensures all allocated blocks are
flushed to disk, so stat() reflects the real block count.

Feel free to add my RBT with this change applied:

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
