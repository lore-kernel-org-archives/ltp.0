Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C643C55173
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 12:05:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C98F3EA681
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 14:05:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25AB03E1963
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 14:05:05 +0200 (CEST)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 01E8810001A3
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 14:05:03 +0200 (CEST)
Date: Sat, 1 Aug 2026 20:04:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785585903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hyft3vZtcsQQV5CO8kRZDdjtZQdA56A/BxhhqVo6ZEA=;
 b=Mn/YYH9EOp94KEOl+Is5EZ9eDN4Xu2+v7SqkP2YwEnV30LUYKFo9BI5Zot289NR0Ph71l7
 4CLA90xXKW7IxqHt/gpH3SEdiEE14h+q5hyWAhj/qB9HCn25Wtse8MaqyKnwg6wCoPYHwv
 gbru0yJnsXMWDD0YTLCXPglnImRScqI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <am3g6oTHnfmiYORz@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com>
 <20260730-shell_oom_protection-v2-1-be1de2baa83d@suse.com>
 <am3dJgE_4tMWnsh1@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <am3dJgE_4tMWnsh1@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] shell: add optional OOM protection
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

> > +	if [ "$TST_OOM_PROTECTION" = 1 -a "$_TST_OOM_PROTECTION" != 0 ]; then
> > +		_tst_run_oom_protected "$@"
> > +	fi
> 
> In the C library, OOM protection for the LTP library and harness
> is enabled by default. But in such Shell implementation, we have to
> explicitly enable it via 'TST_OOM_PROTECTION=1'.

Say precisely: only protect LTP library not contains upper harness.
The upper harness can to be handled out from LTP.

See:

  commit 8e5fe1d5f2 ("lib: enable OOM protection for ltp lib process")


> If we keep them consistent and remove the TST_OOM_PROTECTION
> variable, things will become easier I guess :).

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
