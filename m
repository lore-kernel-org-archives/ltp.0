Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05C2FF885D
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 02:41:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 459043CE1C6
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 04:41:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D1353CB935
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 04:41:15 +0200 (CEST)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E5E831000459
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 04:41:14 +0200 (CEST)
Date: Mon, 27 Apr 2026 10:41:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777257673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYEBxujDknH+G3XBFNxwehVnHk+U/DQCBkMs9a+Ysd8=;
 b=bmelC8vaUjTB23FbiR0ZfR8qFtbOcMJ4vHukp2K6aGLmr6i8v9I3X55b1dl+R1+gB/rbMR
 QUUILiXEx2pfOKTwgeGR2cFZAjIdgJrbFIxXSKUFnr4YKBejwojuHLbGzOR3qEm0A2Nk22
 sDGklLVFW28ly7b6Q+v8SbLQNhYb/s8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Darren Chang <chihsheng@google.com>
Message-ID: <ae7Mw837_lcAI5Ja@linux.dev>
Mail-Followup-To: Darren Chang <chihsheng@google.com>, ltp@lists.linux.it
References: <20260426035823.3634607-1-chihsheng@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260426035823.3634607-1-chihsheng@google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap09: Drop hardcoded /tmp path
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

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
