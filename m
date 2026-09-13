Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E7CC88E40
	for <ltp@archiver.kernel.org>; Sun, 13 Sep 2026 04:03:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 203053E919F
	for <ltp@archiver.kernel.org>; Sun, 13 Sep 2026 06:03:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 364C33C00AF
 for <ltp@lists.linux.it>; Sun, 13 Sep 2026 06:03:16 +0200 (CEST)
Received: from mta0.migadu.com (out-128.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DE8F31400523
 for <ltp@lists.linux.it>; Sun, 13 Sep 2026 06:03:13 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=A5cwG9Y/qzzlXw331y1MSp+CYUBNGaTHCec1ZksBB0Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789272191; v=1; x=1789876991;
 b=qvm05UBmeD/ThW8eWLJg/FlICMQ/Yk35Q+aqu7m/ICnyNvSSl/ErCv41bIv5F2a4Y1/ivyNl
 sbGaGtekNxUbYFxsjPz8VJ96K6+wp7sqKH1HQvBQDPCwBGcDBh/qeFAx0bFzXQLEykmMHPoPEVw
 dPWUUC7on6XVVWFtOaCEHsNg=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 5f449fad15d635a5;
 Sun, 13 Sep 2026 04:03:01 +0000
X-Mizu-Trace-ID: 5f449fad15d635a5
X-Migadu-Flow: FLOW_OUT
Date: Sun, 13 Sep 2026 12:02:54 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqYgbh9SK5AvUNRE@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
 <20260911-mmap_32bit_coverage-v3-1-b0608349556d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911-mmap_32bit_coverage-v3-1-b0608349556d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lapi/mmap: add MAP_32BIT fallback
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
