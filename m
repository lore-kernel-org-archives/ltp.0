Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0776C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:14:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B29513CA9EA
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:14:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705D33C9050
 for <ltp@lists.linux.it>; Wed,  4 May 2022 09:29:21 +0200 (CEST)
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3B0ED1A00939
 for <ltp@lists.linux.it>; Wed,  4 May 2022 09:29:19 +0200 (CEST)
Received: from [192.168.83.80] (unknown [182.2.74.109])
 by gnuweeb.org (Postfix) with ESMTPSA id 067C57E7DF;
 Wed,  4 May 2022 07:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
 s=default; t=1651649357;
 bh=0jCTxyJFrW91G2WoOFPhse6MeV195g1T/fnwYvdmDWI=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=TTUYmlWo7inPfQAC3SmM8ijAmdgEUu0mJXKlOZK3Dq/riHvkmEcDCfjVP7m7hc36o
 HHxYmbTq3EkSlK4oJ00IhKUPSbZTN/8JHDC+0g8rR7/WgCEbfLvc1ciGhwS19Hzzrx
 GWT2kvCSgeVF3bfZ+Wb7FL93sPl47FRNImLoOTIwigRiT72WtA5KlqFz3uhUr2Gytc
 ojP6X0LuiUZxBvxCN/i5k+d3RFG67b+zcgTula8JcYXOOPmZW3Enn+nsD0aCmdnt11
 pIUbNGBvia4M+QVXB3PkLvWNuKh23teGuaLEoFa2QmkRnoKkfoCH/A84470m/+KWG8
 yKgMVWHgwkXzg==
Message-ID: <64cbe8c1-a93f-1aad-2629-9feb6ee7a20e@gnuweeb.org>
Date: Wed, 4 May 2022 14:29:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>, Jens Axboe <axboe@kernel.dk>
References: <20220504060305.GF30775@xsang-OptiPlex-9020>
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220504060305.GF30775@xsang-OptiPlex-9020>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 12 May 2022 16:14:36 +0200
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
Cc: lkp@lists.01.org, lkp@intel.com, ltp@lists.linux.it,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 5/4/22 1:03 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c ("net: add support for fast socket release")
> https://github.com/ammarfaizi2/linux-block axboe/linux-block/sock-nolock.2
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20220430
> with following parameters:
> 
> 	test: cve
> 	ucode: 0x28
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Hello,

Thank you for the testing effort. But it's an abandoned branch, please stop
testing branch: axboe/linux-block/sock-nolock.2.

As Jens has said previously here:
https://lore.kernel.org/lkml/f8de18da-e6ae-e82c-c6eb-6f4de6ce8e98@kernel.dk

=========================================
On Sat, 30 Apr 2022 at 08:58:21 -0600, Jens Axboe wrote:
> 
> Please just stop testing that branch, it's been abandoned.
> 
> -- 
> Jens Axboe
=========================================

-- 
Ammar Faizi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
