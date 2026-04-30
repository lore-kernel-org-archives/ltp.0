Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C781CCFA13
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 10:34:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B83D3E6C88
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:34:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BDCF3E57BC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:34:33 +0200 (CEST)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D893B1000DA7
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:34:32 +0200 (CEST)
Date: Thu, 30 Apr 2026 18:34:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777545271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DU85KNfEtt0JJJlGcDoATA2N34B38MERnqNbtDo112U=;
 b=Z7HSrNLIr2b8CSDHHbQFYAeXyPe7Doh9bSbQsQuim2V7GATEHy78++5vGvyeECN6yGca7i
 gIIk3gbXqPexFYDNmisF9xgrZCKBh3Dsx12M1yjkGoMPnQsskmdfi34coAhxGuA1zN2Jgs
 JNB3OJKAKS93pCv/FFuYNgJa3sHacl4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <afMwMO1yTBGDLQJc@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260430091956.10915-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260430091956.10915-1-chrubis@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_test: tst_reinit() abort when already
 initialized
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

On Thu, Apr 30, 2026 at 11:19:56AM +0200, Cyril Hrubis wrote:
> Calling tst_reinit() when library is already initialized or calling it
> for a second time is always mistake. With that we silenty drop the old
> IPC region, that may have contained test results and there are likely
> other problems possibly caused by initializing the test library twice.
> 
> To fix that this patch adds tst_brk() that abort the test if we call
> tst_reinit() with already initialized test library.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Li Wang <li.wang@linux.dev>

The patch itself looks good, I'm just wondering how you found
this issue, was it called twice somewhere/in a test?

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
