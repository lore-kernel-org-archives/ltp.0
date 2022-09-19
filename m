Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C233C54EE9
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 05:17:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580263CACB3
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 07:17:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A63C63C0204
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 07:17:08 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE01D1A00616
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 07:17:07 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 86F399FDDE;
 Mon, 19 Sep 2022 05:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1663564626; bh=8C+xacDmLp0cFotvDjg4Wc6fAps3eU6KMd+41GvgC9k=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=ihI4yZzR3pwhukklcw+qPJd/8if+jBDOcKnWGfm+RogMi96Glgu4DwzVZV7RI2oSm
 49+qk+oYSX9Vvx1Jkk6uLHKHPhGWoWABIDHMSgIMXXku282VTL3R0VdjCbe+JP9MYz
 6imRMbBLIAE5oAikBdAQyhNJY2O6ri3vmLylA6Z4=
Message-ID: <313ec802-8e48-667b-6327-071e25acb8b5@jv-coder.de>
Date: Mon, 19 Sep 2022 07:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 Petr Vorel <pvorel@suse.cz>
References: <1662008249-2227-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YxCR7+dkGxPvCQDn@pevik> <98263d58-cf08-0c70-c642-2a95a727659f@fujitsu.com>
From: Joerg Vehlow <lkml@jv-coder.de>
Organization: AOX Technologies GmbH
In-Reply-To: <98263d58-cf08-0c70-c642-2a95a727659f@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] README: Add missing configure in openposix step
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
Reply-To: Joerg.Vehlow@aox.de
Cc: Joerg Vehlow <joerg.vehlow@aox.de>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

sorry for the late reply, I was on vacation.

Am 9/2/2022 um 9:31 AM schrieb xuyang2018.jy@fujitsu.com:
> Hi Petr
> 
>> Hi Xu,
>>
>> [ Cc Joerg ]
>>
>>> Since 8071ba7("openposix: Setup autoconf and fix installation layout")
>>> , we need to use configure firstly.
>>
>> nit: there should be Fixes: below:
>> Fixes: 8071ba7 ("openposix: Setup autoconf and fix installation layout")
>>
>> Then you can use just 8071ba7 in the text.
>>
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>>   README.md | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>>> diff --git a/README.md b/README.md
>>> index d45d1ee44..d0ca5f4d4 100644
>>> --- a/README.md
>>> +++ b/README.md
>>> @@ -79,11 +79,13 @@ $ cd ../commands/foo
>>>   $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
>>>   ```
>>
>>> -Open Posix Testsuite has it's own build system which needs Makefiles to be
>>> -generated first, then compilation should work in subdirectories as well.
>>> +Open Posix Testsuite has it's own configure and build system which needs
>>> +Makefiles to be generated first, then compilation should work in subdirectories
>>> +as well.
>>
>>>   ```
>>>   $ cd testcases/open_posix_testsuite/
>>
>> You miss:
>> $ make autotools
>> as this creates configure
>>
>>> +$ ./configure
>> But if you run make autotools && ./configure in the top level, none of these two
>> is needed to be run in open posix directory.
> 
> I have called them on top directory, but configure still be needed in 
> open posix directory.
Did you run configure with --with-open-posix-testsuite? Otherwise
configure is not executed in the open posix directory.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
