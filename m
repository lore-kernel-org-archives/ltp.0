Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D67C19F28
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 04:46:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 570783C9208
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 06:46:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41F413C875F
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 06:45:57 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0D12F1400972
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 06:45:56 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 57750A344C;
 Wed,  3 Aug 2022 04:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1659501955; bh=8AB7I1D0/eRhrywnAQ6/my1bi4Oh2WADt1FcrniBbQs=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=FKc32fAmfS8I80gmcSBjeamS7RnEWWq+YsRZz8xxlCbbTnuyBOupLixfjMvlq3on2
 xnvBKU8PbbILWA+g+3MNbvShUDOrRLNv6aOFrVwvhHydVG5pput0A+69J5pd/v1kea
 a6F6QNBr0G+xxaJKWxrlO/pf5zOQdrU2p6ez2iyQ=
Message-ID: <d2dbca31-0ffd-d8d3-1c31-4c3740258f89@jv-coder.de>
Date: Wed, 3 Aug 2022 06:45:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220727053307.3009235-1-lkml@jv-coder.de>
 <20220727053307.3009235-4-lkml@jv-coder.de> <YuQXnCgSjBT1mGFH@pevik>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <YuQXnCgSjBT1mGFH@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] configure: Integrate open posix testsuite
 configure
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Am 7/29/2022 um 7:23 PM schrieb Petr Vorel:
> Hi Joerg,
> 
> [ Cc automated-testing@lists.yoctoproject.org ]
> 
>> From: Joerg Vehlow <joerg.vehlow@aox.de>
> 
>> This changes the default installation location
>> of the open posix testsuite from
>> $prefix
>> to
>> $prefix/testcases/open_posix_testsuite
> I need to have a deeper look on this patchset next week.
> But it looks to me strange, that running LTP top level configure causes
> installation into /opt/ltp/testcases/open_posix_testsuite/, but after running
> ./configure in testcases/open_posix_testsuite make install goes by default to
> /opt/openposix_testsuite.
That is just keeping the old behavior and makes total sense imho. If it
is installed standalone, it makes sense to not install it into ltp's prefix.
If you install the realtime testsuite standalone, it will be installed
under default prefix (/usr or /usr/local), so also different prefix
depending on if it is installed as part of ltp or standalone.

> Also openposix does not use LTP API, when we're touching it, wouldn't it make
> more sense to put it into separate git repository? IMHO that would cause work
> for other people (clone separate git, need to fix CI and tools which are using
> it), but openposix embedded in LTP always looked strange to me.
That is something else to discuss and I don't have a strong opinion
about it.
> 
> Kind regards,
> Petr
> 

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
