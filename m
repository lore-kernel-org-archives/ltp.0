Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8B7EB64DC
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 14:40:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34E753CEB73
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 16:40:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 703D13C99AE
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 16:40:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BA2906006ED
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 16:39:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E50231FDA5;
 Mon, 17 Jul 2023 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689604796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rs9uvcUebUMYsasQ832t98i+yhYyEHbW41JV9UaUcj4=;
 b=QBXM1k8OERxN0iaIwVOM7k5vhYNab1sinEWQWfyhUl83K/x9qG83y7igJixZYo0pXzkdRI
 5HkMcCS+exn3+XJT8TeD1ciqGABcwi54XE0gtVhYEEzIfHl3cXGChEHXcjhR0a5c2RS2RZ
 FDmEsmwHRLip1xKgrlls4W7GMu2tHp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689604796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rs9uvcUebUMYsasQ832t98i+yhYyEHbW41JV9UaUcj4=;
 b=KGjA6IXE8LIozekVLTJtjAkJ34AIUvQdps2KI5hNIjXUFlrW2wcysOtF5nQqqbWl6GfK9R
 MJAIbtaXHkBP/pCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5D67138F8;
 Mon, 17 Jul 2023 14:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w2FkLrxStWS4dQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Jul 2023 14:39:56 +0000
Date: Mon, 17 Jul 2023 16:41:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <ZLVS_ANORaZO_ZIE@yuki>
References: <20230628211637.1679348-1-longman@redhat.com>
 <202307171539.3d8d0e8-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202307171539.3d8d0e8-oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Brent Rowsell <browsell@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Phil Auld <pauld@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, yu.c.chen@intel.com,
 Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Peter Hunt <pehunt@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 oe-lkp@lists.linux.dev, Waiman Long <longman@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it, lkp@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Running tests.......
> <<<test_start>>>
> tag=sched_setaffinity01 stime=1689382567
> cmdline="sched_setaffinity01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EFAULT (14)
> sched_setaffinity01.c:73: TFAIL: sched_setaffinity() succeded unexpectedly
> tst_test.c:1612: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1614: TBROK: Test killed! (timeout?)

So what the test does is that it sets empty affinity mask to
sched_setaffinity() and expects EINVAL. Instead it looks like the call
now succeeeds, the test stops getting schedulled and is killed by
timeout.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
