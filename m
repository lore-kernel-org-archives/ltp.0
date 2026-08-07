Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E4BC2A09B
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 03:53:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EACE73E9036
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 05:53:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65FA93E7064
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 05:53:37 +0200 (CEST)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 071A61000A04
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 05:53:36 +0200 (CEST)
Date: Fri, 7 Aug 2026 11:52:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786074816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjSC3ULDk0bFMpCyOv7dS8Q0ItXmyB0e9eI6GKr1tck=;
 b=NRbSI3LSJ0PHpUhNp5KCO7REJ273NgN8ghe9aX/NhDl6qd4nlVXVzPcJOjiVWzhx38nxa1
 rfsHHhtNF/W5UJT5mOLlL6GMI5cgtaNQWRsykjau5h7gDMHmEZLJHgSpaXB023N+MfZSjF
 g4lzYSqm9sgzKIUQDpZbsX+9BhqK2oQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: linuxtestproject.agent@gmail.com
Message-ID: <anVWjUOj6Oi5sBbz@linux.dev>
Mail-Followup-To: linuxtestproject.agent@gmail.com,
 Xuewen Wang <wangxuewen@kylinos.cn>, ltp@lists.linux.it
References: <20260807014416.1453266-1-wangxuewen@kylinos.cn>
 <20260807025150.4081-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260807025150.4081-1-linuxtestproject.agent@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/functional: fix memcg_failcnt intermittent timeout
 by disabling swap
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
Cc: Xuewen Wang <wangxuewen@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

linuxtestproject.agent@gmail.com wrote:

> Hi Xuewen,
> 
> On Fri, Aug 7, 2026, Xuewen Wang wrote:
> > memcg/functional: fix memcg_failcnt intermittent timeout by disabling swap
> 
> > +do_setup()
> > +{
> > +	memcg_setup
> > +	swapoff -a
> > +}
> 
> Could this use ROD so a failed swapoff aborts the test? swapoff can fail
> when there is not enough memory to page the swap contents back in.
> _tst_run_iterations() ignores the setup function's return status, so the
> test proceeds with swap enabled and the original intermittent timeout
> remains.

Fair point that ignoring the return status defeats the purpose. But I'd
rather not TBROK on a swapoff failure, that's an environment limitation,
not a test failure. Especially swapoff here is an enhancement but not
a hard requirement for this test.

> 
> > +do_cleanup()
> > +{
> > +	swapon -a
> > +	memcg_cleanup
> > +}
> 
> Could cleanup restore only swap areas that were active before setup, and
> only if swapoff was attempted? TST_DO_CLEANUP is set before do_setup(), so
> a TCONF from memcg_setup() reaches this function before swapoff. swapon -a
> can then activate previously inactive fstab entries. Conversely, dynamically
> managed swap areas absent from fstab are disabled by swapoff -a but are not
> restored by swapon -a.

That is a bit over-engineering.

If an inactive fstab entry gets activated by swapon -a, that arguably
points to a misconfigured test host rather than something this test
should work around.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
