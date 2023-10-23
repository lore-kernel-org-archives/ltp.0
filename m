Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C4C001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:50:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1050B3CF4FF
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:50:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B88833CF4F7
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 16:50:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 930862001C6
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 16:50:37 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 863BE2F4;
 Mon, 23 Oct 2023 07:51:16 -0700 (PDT)
Received: from [10.44.160.71] (e126510-lin.lund.arm.com [10.44.160.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8D713F64C;
 Mon, 23 Oct 2023 07:50:34 -0700 (PDT)
Message-ID: <87291cdf-0245-c825-d3a3-235e4a4d1f9d@arm.com>
Date: Mon, 23 Oct 2023 16:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: Cyril Hrubis <chrubis@suse.cz>
References: <20231023135647.2157030-1-kevin.brodsky@arm.com>
 <20231023135647.2157030-4-kevin.brodsky@arm.com> <ZTaF2kM1R1i3_JpR@yuki>
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZTaF2kM1R1i3_JpR@yuki>
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

On 23/10/2023 16:40, Cyril Hrubis wrote:
> Hi!
>> A number of tests check that syscalls manipulating paths return
>> -ENAMETOOLONG when the specified path is longer than allowed. There
>> are actually two ways this error can be triggered:
>>
>> 1. If the given string is longer than PATH_MAX, i.e. 4096 as far as
>>    the kernel is concerned, then the getname() helper will fail and
>>    the kernel will return -ENAMETOOLONG right away.
>>
>> 2. If the string fits in PATH_MAX, but the filesystem rejects the
>>    path name, for instance because one of its components is longer
>>    than the support file name length (e.g. 255 for ext4).
> Ideally we should have at least one test that would hit the 1. as well...

This is what patch 3 is meant to achieve: instead of hitting 2. we now
systematically hit 1.

Thanks for merging this series (so quickly)!

Kevin

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
