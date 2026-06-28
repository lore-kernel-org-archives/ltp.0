Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9090C43458
	for <ltp@archiver.kernel.org>; Sun, 28 Jun 2026 04:46:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB5173C744D
	for <ltp@archiver.kernel.org>; Sun, 28 Jun 2026 06:46:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE9DD3C1D3E
 for <ltp@lists.linux.it>; Sun, 28 Jun 2026 06:46:13 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0ED59600129
 for <ltp@lists.linux.it>; Sun, 28 Jun 2026 06:46:12 +0200 (CEST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782621972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1DXXG/RBB1baNZ34+c/wjzuXkXpDghPcSdZ3lBuNgc=;
 b=mJhmfF1CtnQoMDMnidj2MyImVn5U6Oo/Gbqh6xwtJ1Uz4WiW9cj1d9SaBKDgwX+SrBVQq6
 E8ft0OujQhBNgwcCDC2RHfBlijE2iWYRNOHEkaX9IQGfOF9GAsH/CCqVgESQ+rvL8K+kZo
 bGsOFS+UdHtFtaEX363fZbbA684cVx0=
Date: Sun, 28 Jun 2026 04:46:10 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Li Wang" <li.wang@linux.dev>
Message-ID: <26611dbab9ca4b2503e772b089635a9a79350b55@linux.dev>
TLS-Required: No
To: "Avinesh Kumar" <avinesh.kumar@suse.com>, ltp@lists.linux.it
In-Reply-To: <20260623200336.116104-1-avinesh.kumar@suse.com>
References: <20260623200336.116104-1-avinesh.kumar@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapping01.c: use .needs_abi_bits = 64
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

Merged, thanks!

Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
