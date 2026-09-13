Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A134C88E56
	for <ltp@archiver.kernel.org>; Sun, 13 Sep 2026 04:03:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 380493E6E76
	for <ltp@archiver.kernel.org>; Sun, 13 Sep 2026 06:03:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FBEC3E919E
 for <ltp@lists.linux.it>; Sun, 13 Sep 2026 06:03:25 +0200 (CEST)
Received: from mta0.migadu.com (out-130.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::82])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2A6B2100045C
 for <ltp@lists.linux.it>; Sun, 13 Sep 2026 06:03:23 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=A5cwG9Y/qzzlXw331y1MSp+CYUBNGaTHCec1ZksBB0Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789272202; v=1; x=1789877002;
 b=H9i+wauwd+sA7UwKOCq8lpT/i5n/Pltno4GrqvnCF9xlt/b7kfxh8qXSwUHxz8g7VbDqTZrM
 Vqchl6a3oR3szQNRQcRAk95LIAvGo8szTaV8i4pcVldGg8VpPrVF90py4Y27Ov6udaRP8IBdIFw
 lWatMZB+sLPEiyLpIeLHcW6c=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id ee52aa182a9faf6c;
 Sun, 13 Sep 2026 04:03:22 +0000
X-Mizu-Trace-ID: ee52aa182a9faf6c
X-Migadu-Flow: FLOW_OUT
Date: Sun, 13 Sep 2026 12:03:15 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqYgg7T2lEQ0in4P@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
 <20260911-mmap_32bit_coverage-v3-2-b0608349556d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911-mmap_32bit_coverage-v3-2-b0608349556d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] mmap23: add test for MAP_32BIT oversized
 mapping
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

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
