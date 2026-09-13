Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85A1C88E56
	for <ltp@archiver.kernel.org>; Sun, 13 Sep 2026 04:18:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D276A3E71F3
	for <ltp@archiver.kernel.org>; Sun, 13 Sep 2026 06:18:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99DB23C9A1C
 for <ltp@lists.linux.it>; Sun, 13 Sep 2026 06:18:16 +0200 (CEST)
Received: from mta0.migadu.com (out-75.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::4b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 25003600101
 for <ltp@lists.linux.it>; Sun, 13 Sep 2026 06:18:15 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=IgjTQP5pYgPLEkQDZM+nbBqxZgVzDtY/I9eNzJCx8Q0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789273095; v=1; x=1789877895;
 b=uPXPlhui3P4vKcEGPtSyNYt1tsZkxeepP6OwxfrMfU5cy73VmIPt718EHxlo2/pJkSJyStJ/
 nkaC/YqGua+1UxfYEJ+QBpj4hfx8kPEB4bRrTWutGo5gL1twPmKCuN4pv1KXoWM9938XSiM4c1o
 QY49mbDKKEiTzNcHcI1b8jow=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id e2ff4ac453f5707e;
 Sun, 13 Sep 2026 04:18:05 +0000
X-Mizu-Trace-ID: e2ff4ac453f5707e
X-Migadu-Flow: FLOW_OUT
Date: Sun, 13 Sep 2026 12:18:01 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqYj-Qytv7dq1bl8@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
 <20260911-mmap_32bit_coverage-v3-3-b0608349556d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911-mmap_32bit_coverage-v3-3-b0608349556d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] mmap24: add test for MAP_32BIT address
 limit
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

> +/*\
> + * Verify that :manpage:`mmap(2)` with the MAP_32BIT flag restricts all mappings
> + * to the first 2GB of the process address space (< 0x80000000).
> + *
> + * MAP_32BIT is supported only on x86-64 for 64-bit programs.
> + *
> + * Use PROT_NONE to test address placement without allocating data pages
> + * or charging private writable memory against the commit limit.

Reviewed-by: Li Wang <li.wang@linux.dev>

This test itself looks good, but unlike the address placement way, maybe we
can create a new test (mmap25.c) that allocates real read-write anonymous memory,
writes a pattern, reads it back, and checks the result.

This verifies that read-write memory mapped with MAP_32BIT functions correctly.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
