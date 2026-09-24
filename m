Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822C1C98310
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 06:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECA203E62C3
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 08:23:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 534483E5CDE
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 08:23:30 +0200 (CEST)
Received: from mta0.migadu.com (out-135.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::87])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 47CF6600D2D
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 08:23:29 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=PXDuQ39yiYU3DdBNEVz440ieP7+MNM93brs8hLIz0HU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790231008; v=1; x=1790835808;
 b=CZ+mq6bvXY9Xh+lQNv95nKo/cs0/o28ppI9JE29c7QlQoiLjnwhhQvaRRLb2lo4b6aBSycOc
 x/hGOIzk22PqSs/Tm+0SpShLJiqu3xmv90JvRranY5PACNgpk4cPoIKh38GRMrmnO9BVQFTXQGw
 Fvyj9t+G3ja9zEVt5UoSPIpM=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 9c1c3f98e785d8ad;
 Thu, 24 Sep 2026 06:23:18 +0000
X-Mizu-Trace-ID: 9c1c3f98e785d8ad
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 14:23:13 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <arTB0aca4BMTuorc@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>,
 Linux Test Project <ltp@lists.linux.it>
References: <ap6fQ11ieRK5FCjk@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ap6fQ11ieRK5FCjk@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

I have manually built and tested the main branch locally,
everything looks good. (kernel-6.6.145, x86_64, vm)

Hopefully this adds confidence in the release.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
