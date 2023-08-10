Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBBFC04FDF
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 10:26:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40FDD3CD41B
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 12:26:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B16B3C4D6E
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 12:26:28 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 287331A00902
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 12:26:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZwoRcwPde2jMSuFGIZJQsN8ToBMZksq6y8S2UUNSdAY=; b=vBoG7IYxv14q8bktC7uZU+G75r
 CXvW0BvAGK9IwO1j1Ita/Ace+JnjF7MEmxe3XSgWmwBtUDsRywoydnhLWU3YG2Bq7yyR8Fl9HwWSA
 loCoe/G9I5zVvECc3GZa0t50NO6G3gDYS7Zu4bRacEX+22xm/DqvPRIsB2/WOovmtX+iwyxe+vFOs
 2C9qqW2WxUOZsLOhWnGKVSqJC6tgde32dY68TRolwts0FOJ0w/p6IIBEkvrpw39wqIM/KRM86qLQQ
 B4+/SQO1UeCq7/AwZI2g7EJ0WSpYJttBWsJXi01fNyN1GBDA2m+Xx/jnEBVC9FcmJ0rPDVSRlrifW
 ocyVpZiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qU2rz-00Bxov-GM; Thu, 10 Aug 2023 10:26:19 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4422730003A;
 Thu, 10 Aug 2023 12:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 09747201D137B; Thu, 10 Aug 2023 12:26:18 +0200 (CEST)
Date: Thu, 10 Aug 2023 12:26:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@suse.de>
Message-ID: <20230810102617.GW212435@hirez.programming.kicks-ass.net>
References: <20230802151906.25258-1-chrubis@suse.cz>
 <20230810083028.l2ov4wpffhv3zw3h@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230810083028.l2ov4wpffhv3zw3h@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2 RESEND] Two fixes for sysctl_sched_rr_timeslice
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
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 10, 2023 at 09:30:28AM +0100, Mel Gorman wrote:
> On Wed, Aug 02, 2023 at 05:19:04PM +0200, Cyril Hrubis wrote:
> > - Fixes rounding error for initial value with CONFIG_HZ_300
> > 
> > - Fixes read from the file after reset to default (by writing val <= 0)
> > 
> 
> Hi Peter,
> 
> Any chance this can be picked up in tip please? It might have helped if
> the leader mentioned the main problem covered in patch 1 -- some HZ
> values can fail LTP tests due to a simple rounding error at compile
> time.

Yah, sorry, too much crazy atm :/ Got it queued.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
