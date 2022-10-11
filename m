Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30863C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 09:28:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59B5E3CAE95
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:28:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CCA93CAE81
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:28:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2D13600158
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:28:18 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B1B401F86C
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 09:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665480497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lAwUEgYrnw+dzGd4crv+RdPGZjDse+I3v3h8J8tAnbQ=;
 b=pxXt2PH/sCz46N7SZspU5c0GO5BZQp5Y/aJSYdIFIBE6xeAaYndN2olo2gc9wH0dFVx73v
 pz96FtLg1dT2LssI83dQg9eMhjC+LHs0d5CgQFjiD+3LkBmFN2o2eX+k3Q/LJrYEI6Qdfo
 j/ttUTz4YBvK8i6Ao0P0KViJ0vkDWdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665480497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lAwUEgYrnw+dzGd4crv+RdPGZjDse+I3v3h8J8tAnbQ=;
 b=eaFTCTfhLhJkojNeCX2SjZdxUaqAhH7YbE0UGJWFQ99R/0kG1hbh9V+2ToVzQZiwv/+Wp4
 h75LwgGuBJGh4YCA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 489A92C142;
 Tue, 11 Oct 2022 09:28:17 +0000 (UTC)
References: <20220727151657.2242-1-pvorel@suse.cz> <874jxq14ay.fsf@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: rpalethorpe@suse.de
Date: Tue, 11 Oct 2022 10:26:57 +0100
In-reply-to: <874jxq14ay.fsf@suse.de>
Message-ID: <878rlm90b3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add ROD shell API test
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Petr Vorel <pvorel@suse.cz> writes:
>
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>  lib/newlib_tests/runtest.sh   |  2 +-
>>  lib/newlib_tests/shell/rod.sh | 30 ++++++++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>  create mode 100755 lib/newlib_tests/shell/rod.sh
>>
>> diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
>> index f136bcb88..5b75fe2c7 100755
>> --- a/lib/newlib_tests/runtest.sh
>> +++ b/lib/newlib_tests/runtest.sh
>> @@ -8,7 +8,7 @@ tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh
>>  test_children_cleanup.sh}"
>>  
>>  LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
>> -shell/tst_check_kconfig0[1-5].sh shell/net/*.sh}"
>> +shell/tst_check_kconfig0[1-5].sh shell/rod.sh shell/net/*.sh}"
>>  
>>  cd $(dirname $0)
>>  PATH="$PWD/../../testcases/lib/:$PATH"
>> diff --git a/lib/newlib_tests/shell/rod.sh b/lib/newlib_tests/shell/rod.sh
>> new file mode 100755
>> index 000000000..e05516d0b
>> --- /dev/null
>> +++ b/lib/newlib_tests/shell/rod.sh
>> @@ -0,0 +1,30 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
>> +
>> +TST_TESTFUNC="test"
>> +TST_NEEDS_TMPDIR=1
>> +TST_CNT=3
>> +
>> +test1()
>> +{
>> +	ROD cd /
>> +	EXPECT_PASS [ "$PWD" != "/" ]
>> +}
>> +
>> +test2()
>> +{
>> +	ROD echo foo > /nonexisting-file
>
> If we are running as root then this will succeed?
>
> I suppose we don't usually run the lib tests as root, but wouldn't it be
> better to create a file and write protect it, then try redirecting to
> it?

Marking as "changes requested", to remove it from the queue.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
