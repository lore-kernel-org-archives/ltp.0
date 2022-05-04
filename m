Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A59C433F5
	for <ltp@archiver.kernel.org>; Wed,  4 May 2022 09:07:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27E413CA868
	for <ltp@archiver.kernel.org>; Wed,  4 May 2022 11:07:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA2063C9378
 for <ltp@lists.linux.it>; Wed,  4 May 2022 11:07:11 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3C0401A0048F
 for <ltp@lists.linux.it>; Wed,  4 May 2022 11:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651655229; x=1683191229;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uS5PbqPGgOzM5sgeB21zL4hDAdA1e9yfj8M0x7Uxzbs=;
 b=DtulVinV8u+EttdJztVj4rtFQ8Ja+8Iop5+0UgLME2oqzkl18cI0YHCt
 njXnSN4eIs0asqhjW16seyW0ih4Lw9vJIGN3QEXEb/OvyhPsAhmknunak
 R4t+zpiSZf8YKjqLeucW3NAcTtt7S1ByKjy42/q7bH2auPcagUX/cqAzJ
 SUzN49KBdhQj9EDHmkNPwmLwaVtdxnHub9eWxjtTqq6t9UZQLwOiLm5E0
 OZlGm1e2UbiOrgkVtnA8R4N0bDc+2deZQC+QvrhYTBqpyxkUDDgyfexef
 p9MfXm5YFXmVdpL0r2UNvA7o1dK8UOWKJQUVCw9ZaYk+OrIDu2bXvxXtA g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="265296323"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="265296323"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 02:07:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="584638750"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020)
 ([10.239.159.143])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 02:07:03 -0700
Date: Wed, 4 May 2022 17:07:00 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Message-ID: <20220504090700.GG30775@xsang-OptiPlex-9020>
References: <20220504060305.GF30775@xsang-OptiPlex-9020>
 <64cbe8c1-a93f-1aad-2629-9feb6ee7a20e@gnuweeb.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <64cbe8c1-a93f-1aad-2629-9feb6ee7a20e@gnuweeb.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [net] 5aa32dd9bd: INFO:task_blocked_for_more_than#seconds
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
Cc: Jens Axboe <axboe@kernel.dk>, lkp@lists.01.org, lkp@intel.com,
 ltp@lists.linux.it, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi Ammar,

On Wed, May 04, 2022 at 02:29:10PM +0700, Ammar Faizi wrote:
> On 5/4/22 1:03 PM, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-11):
> > 
> > commit: 5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c ("net: add support for fast socket release")
> > https://github.com/ammarfaizi2/linux-block axboe/linux-block/sock-nolock.2
> > 
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20220430
> > with following parameters:
> > 
> > 	test: cve
> > 	ucode: 0x28
> > 
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> > 
> > 
> > on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 16G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> Hello,
> 
> Thank you for the testing effort. But it's an abandoned branch, please stop
> testing branch: axboe/linux-block/sock-nolock.2.
> 
> As Jens has said previously here:
> https://lore.kernel.org/lkml/f8de18da-e6ae-e82c-c6eb-6f4de6ce8e98@kernel.dk


sorry for this, will ignore this branch.


> 
> =========================================
> On Sat, 30 Apr 2022 at 08:58:21 -0600, Jens Axboe wrote:
> > 
> > Please just stop testing that branch, it's been abandoned.
> > 
> > -- 
> > Jens Axboe
> =========================================
> 
> -- 
> Ammar Faizi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
