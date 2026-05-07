Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED0ECD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:14:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A7AE3E2CA1
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:13:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52F8E3CE0D0
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:13:39 +0200 (CEST)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1E0A41A001CE
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:13:37 +0200 (CEST)
Date: Thu, 7 May 2026 17:13:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778145216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWrwB4cLBB4223D6AcX60n+gvDpcYATEA+huhZQx8+M=;
 b=mO7o+XlJZey0cLKIV5kg5t8V2BrB/b/ygAFInlQupmbSVvaP7n5wBlAjcIuqCRkINyBbF0
 iPHFwz/SU3o+YWnxl2FHBcYja7ohaMPN5ZXeI6/lw5XoVIce1HlIUuq+09bC2RIbyROCgm
 SGYGyw3uZnZlzF1iioCR36Lrx3sPw8w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <afxXp7ShPMPvOFs9@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, pvorel@suse.cz,
 ltp@lists.linux.it
References: <20260430091956.10915-1-chrubis@suse.cz>
 <afMwMO1yTBGDLQJc@linux.dev> <afNQuLNeBcYC_zAG@yuki.lan>
 <afvkSly0fxGwFiLY@linux.dev> <afw4Kz6SLbzZ1EKj@yuki.lan>
 <afxQIR7bdmlJmCIr@linux.dev> <afxVF3S-m9zDuZnF@linux.dev>
 <afxWcDzTeqwPUvGN@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afxWcDzTeqwPUvGN@yuki.lan>
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

> Hi!
> > I look into Petr's patch, seems we can go another way to replace
> > the checkpoint method.
> 
> I would rather change the binary to use TST_NO_DEFAULT_MAIN. It's not a
> test, just a helper binary, the tst_test structure shouldn't have been
> used to begin with.

That sounds reasonable! To avoid mixing with real LTP tests,
we should keep the auxiliary binary clean.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
