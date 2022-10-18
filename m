Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D553BC433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 12:56:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BD293CB085
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 14:56:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A85C3CA7C2
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:56:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 796C92000AF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:56:01 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 67723207D4;
 Tue, 18 Oct 2022 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666097761;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A9a5Dzr5EbCgggRYk+WkAhDYIFLjGXISj2waypehcsI=;
 b=AIMAGdX16nF180l0BRrP3BMw8RqJhPilbNJSCKA6W7zJKXwnBz1SmoBsKgyBfvR0ynmu6/
 777H5VrxrtYY704o4b7PomP2D82Iaz+TZeaFVBpynHEQVAUbTJYMQPo2sZNF7ngpEUGM4g
 idOkc6ZmPOCNHlO/L59JDNedVa3MTuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666097761;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A9a5Dzr5EbCgggRYk+WkAhDYIFLjGXISj2waypehcsI=;
 b=BhXjyTfxpuhAQKdgGw4dqWIXisy4Ca7A+OCELfhAUAINZih6VtC4DTqJSf8dkuqISNZMjX
 CcmIdQYDw73BPNCg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1018C2C142;
 Tue, 18 Oct 2022 12:56:00 +0000 (UTC)
References: <20221006110642.12410-1-andrea.cervesato@suse.com>
 <20221006110642.12410-5-andrea.cervesato@suse.com>
 <875yghjo11.fsf@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 18 Oct 2022 13:49:23 +0100
In-reply-to: <875yghjo11.fsf@suse.de>
Message-ID: <871qr5jnoh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 3/3] Add process_madvise03 test
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


Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> Test for checking MADV_PAGEOUT functionality over memory-mapped file
>> in process_madvise syscall.
>
> So this one doesn't need swap, but it has some other issues.
>
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>  testcases/kernel/syscalls/cma/.gitignore      |   1 +
>>  .../kernel/syscalls/cma/process_madvise03.c   | 139 ++++++++++++++++++
>>  2 files changed, 140 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/cma/process_madvise03.c
>>
>> diff --git a/testcases/kernel/syscalls/cma/.gitignore b/testcases/kernel/syscalls/cma/.gitignore
>> index 47ae3e445..147b03c48 100644
>> --- a/testcases/kernel/syscalls/cma/.gitignore
>> +++ b/testcases/kernel/syscalls/cma/.gitignore
>> @@ -4,3 +4,4 @@
>>  /process_vm_writev02
>>  /process_madvise01
>>  /process_madvise02
>> +/process_madvise03
>> diff --git a/testcases/kernel/syscalls/cma/process_madvise03.c b/testcases/kernel/syscalls/cma/process_madvise03.c
>> new file mode 100644
>> index 000000000..3f12ef530
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/cma/process_madvise03.c
>> @@ -0,0 +1,139 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Spawn child inside cgroup and set max memory. Allocate file-backed memory
>> + * pages inside child and reclaim it with MADV_PAGEOUT. Then check if memory
>> + * pages have been written back to the backing storage.

Actually, one more thing. You don't check if it has been written to the
backing store and it's quite hard to check for this.

At best you could reopen the file in the parent and check the contents
are correct. Otherwise it requires checking the page cache has been
discarded using a side channel (e.g. timing loads).

So I would just not bother for this test.

Also process_madvise returns the number of bytes *advised* not what was
actually reclaimed. Even that is not guaranteed to be the same as the
amount requested.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
