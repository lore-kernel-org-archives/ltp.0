Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A10CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:41:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027CC3E2C31
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:41:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3748E3CB935
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:41:29 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 582D71A0014E
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:41:26 +0200 (CEST)
Date: Thu, 7 May 2026 16:41:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778143285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i6eMOo+yBiJUagPMgqrV1Pi8TSsf9llSPQ4xFlxzRCw=;
 b=wgkuYQWDyO24uJz1JBqgzTH7adlCJOnkdeSWqsI/OksCWp9CxCpYzFVGvd7aRgbsaUICAp
 wKyrN0fGbJdCM2aVP2YIkhJ196cPaTJG0tOb7hUM64wKHYbGbkEJ6JsejS4F2k/+IoWa+3
 c5kTiy+sAppZIhESyXKa/ZNF+fwbimY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>, pvorel@suse.cz
Message-ID: <afxQIR7bdmlJmCIr@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, pvorel@suse.cz,
 ltp@lists.linux.it
References: <20260430091956.10915-1-chrubis@suse.cz>
 <afMwMO1yTBGDLQJc@linux.dev> <afNQuLNeBcYC_zAG@yuki.lan>
 <afvkSly0fxGwFiLY@linux.dev> <afw4Kz6SLbzZ1EKj@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afw4Kz6SLbzZ1EKj@yuki.lan>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

Cyril Hrubis wrote:

> I guess that we also need to revert:
> 
> https://lists.linux.it/pipermail/ltp/2026-April/048007.html
> 
> Since the IMA test is broken after this patch:

You're right, tst_reinit() shouldn't be called in an LTP test with
already initialized the IPC.

Or, we should convert ima_mmap.c into raw main() format proceduer.

> $./ima_mmap -f foo
> tst_test.c:2042: TINFO: LTP version: 20260130-210-gcd9899ce4
> tst_test.c:2045: TINFO: Tested kernel: 6.16.0 #1 SMP PREEMPT_DYNAMIC Tue Aug 12 10:49:53 CEST 2025 x86_64
> tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.16.0/build/.config'
> tst_test.c:1870: TINFO: Overall timeout per run is 0h 00m 30s
> tst_test.c:199: TBROK: Test library already initialized!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
