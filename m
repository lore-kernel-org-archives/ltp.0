Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE24C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 06:21:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FBEB3E2E6E
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 08:21:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F1423E2443
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:21:30 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0DC651A00F7D
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:21:27 +0200 (CEST)
Date: Fri, 7 Aug 2026 14:20:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786083686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gWiVJ+CTRrpb0Hv1ZZZTiZAVI7K8ne6j78C+rOLvxvg=;
 b=V0fMQ9QvYgkfV1AsCdDfJBGQwXEBo8D+RE44LtmOe+ry41o6PZHVzHuJLkZEvJmUjPFECu
 W/u6la4rdvXvFGi9Tj/lMxiat3wBRbC3hBx64pFiaZVltvmp+H5w8abor5uqnrOvZjeMa+
 m5ErbndsN2SiWEzBrhaEXem3bpWN1tA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Xuewen Wang <wangxuewen@kylinos.cn>
Message-ID: <anV5J8HZ-agTZpAB@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Xuewen Wang <wangxuewen@kylinos.cn>,
 linuxtestproject.agent@gmail.com, ltp@lists.linux.it
References: <anVWjUOj6Oi5sBbz@linux.dev>
 <6a756e7a.cc089686.309364.c33e@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a756e7a.cc089686.309364.c33e@mx.google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xuewen, Andrea,

On Fri, Aug 07, 2026 at 05:34:49AM +0000, Andrea Cervesato wrote:
> Hi Li,
> 
> > Fair point that ignoring the return status defeats the purpose. But I'd
> > rather not TBROK on a swapoff failure, that's an environment limitation,
> > not a test failure. Especially swapoff here is an enhancement but not
> > a hard requirement for this test.
> 
> I agree.
> 
> > That is a bit over-engineering.
> > 
> > If an inactive fstab entry gets activated by swapon -a, that arguably
> > points to a misconfigured test host rather than something this test
> > should work around.
> 
> And also here. Unfortunately we don't have enough data for shell tests,
> so AI agent is not really working well in there..
> 
> Honestly I don't know how to fix this but adding more examples which
> we don't have..

No worries, AI agent being too strict in reviewing is not a bad thing.
It inspires me to think about something maybe in a different way.

Like this patch, I am now thinking if we can just limit it only
inside the cgroup:

--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -17,18 +17,17 @@ TST_CLEANUP=do_cleanup
 do_setup()
 {
        memcg_setup
-       swapoff -a
 }

 do_cleanup()
 {
-       swapon -a
        memcg_cleanup
 }

 do_test()
 {
        ROD echo $MEMORY_LIMIT \> memory.limit_in_bytes
+       ROD echo 0 \> memory.swappiness

        start_memcg_process $2 -s ${MEMORY_TO_ALLOCATE}
        ROD echo $MEMCG_PROCESS_PID \> tasks

@Xuewen, can you try this patch and see if it can solve your problem?

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
