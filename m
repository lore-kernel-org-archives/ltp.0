Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2AFC61DC6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 07:59:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66DE73E2FC7
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:59:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DABE3CC02A
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:59:36 +0200 (CEST)
Received: from mta0.migadu.com (out-29.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::1d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C78B7600959
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:59:35 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=A5cwG9Y/qzzlXw331y1MSp+CYUBNGaTHCec1ZksBB0Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787903975; v=1; x=1788508775;
 b=sUJE+VB/65URwyM/qz00FORrrTyXlQcBKpSyqaMSh+QSeygz+gRceVCK4D2bIplZ+cppd0n2
 UnHT9kxjfzrXCeZ3Yjc9toGw3RImjKJc05G6Nat+CxYs7TC/DNrultMcElMIRToRJIV+v+QjC0o
 7qf9JgbPFh8V0OSVF2oZFwD8=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 3b48b101ba7d6594;
 Fri, 28 Aug 2026 07:59:35 +0000
X-Mizu-Trace-ID: 3b48b101ba7d6594
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 15:59:22 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <apE_2jmXQjKO9QoE@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
 <20260827-swapon_discard_coverage-v1-3-633bcb11c181@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827-swapon_discard_coverage-v1-3-633bcb11c181@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] swapon02: Add test cases for invalid swapflags
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
