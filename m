Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BBFC00A8F
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 10:37:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B713A3CE5BA
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 12:36:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 034F73CB558
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 12:36:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 40B4420473E
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 12:36:46 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE1C72F4;
 Tue, 24 Oct 2023 03:37:25 -0700 (PDT)
Received: from [10.57.5.81] (unknown [10.57.5.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AE393F64C;
 Tue, 24 Oct 2023 03:36:44 -0700 (PDT)
Message-ID: <dd0509ea-a7e9-0bb1-9511-ecdbeed9225c@arm.com>
Date: Tue, 24 Oct 2023 12:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: Cyril Hrubis <chrubis@suse.cz>
References: <20231023135647.2157030-1-kevin.brodsky@arm.com>
 <20231023135647.2157030-4-kevin.brodsky@arm.com> <ZTaF2kM1R1i3_JpR@yuki>
 <87291cdf-0245-c825-d3a3-235e4a4d1f9d@arm.com> <ZTaL6rLETxHwvFDr@yuki>
 <e6cc15ff-cb44-4805-cba5-9f5340410746@arm.com> <ZTeQJ95GncF5yg8F@yuki>
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZTeQJ95GncF5yg8F@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Provide a PATH_MAX-long buffer when expecting
 ENAMETOOLONG
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

On 24/10/2023 11:36, Cyril Hrubis wrote:
> Hi!
>>> Sigh, I meant 2. I guess that we would have to loop over filesystems
>>> (easily done with .all_filesystems = 1) and pass very long filename. Or
>>> do we have such test already?
>>>
>>> Looking at our tests, the rename10.c is actually one of two tests that
>>> sets .all_fileystems and checks for ENAMETOOLONG. Looking at the
>>> filesystem limits, all seems to have limits that are <= 255 characters,
>>> the only problem is a definition of character. For utf8 character 255
>>> characters are around 1021 (including nul terminator). So I suppose that
>>> if we pass another buffer that is PATH_MAX in length and has PATH_MAX-1
>>> characters we should consistenly hit 2. Or do I miss something?
>> This is a good point, I didn't think about it this way. Your idea seems
>> sensible. With this patch we always hit 1. as we specify a string that
>> is longer than PATH_MAX. We could instead hit 2. without out-of-bound
>> access by specifying a string that is at most PATH_MAX in length
>> (including the null terminator), and at least the filesystem character
>> limit. Maybe something like the diff below (just tested it, that works
>> fine).
> Can we actually have two long paths in the test and test both? That
> should have the best test coverage.

Certainly, that should be easy enough. I can post a follow-up patch to
that effect.

Kevin

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
