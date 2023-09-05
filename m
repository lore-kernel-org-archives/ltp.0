Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30022C83F33
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 09:02:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33E663CDEFC
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 11:02:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4822C3CB78F
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:02:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0279B1A027AB
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:02:39 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E9B20211CE;
 Tue,  5 Sep 2023 09:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693904558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5A+Wqo2MY7bbKbOa9pxjzkH8uBcStWQ7sDtKiNsjJk=;
 b=ZtUWeeCpB1sa6u1R41rldmft9NotCcj4LzHuseag1Q4vjJqmWiIwRLBQl3Itp94bImAGxJ
 V/zePb1LAxoA8c5OvfY3L6jj1Irhe/tSPsqw9Or70Q0vziNyw11tol52+q/q9P6DtVl5b9
 omhlkEu7xtO2O4NjbMS6mO3bMxzU/TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693904558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5A+Wqo2MY7bbKbOa9pxjzkH8uBcStWQ7sDtKiNsjJk=;
 b=g9WufoGBx0p66NbpyRCbnl+r526DPHIWPIyU7OxGDB5GLUOCrM4bB3EO6OTx4dnqXGU56B
 lXePWrVERMmFQPBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 22F912C145;
 Tue,  5 Sep 2023 09:02:37 +0000 (UTC)
References: <1692875424-22449-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <040088ba-20f1-711f-3fe5-6d1d4782a015@fujitsu.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Xiao Yang <yangx.jy@fujitsu.com>
Date: Tue, 05 Sep 2023 09:58:51 +0100
Organization: Linux Private Site
In-reply-to: <040088ba-20f1-711f-3fe5-6d1d4782a015@fujitsu.com>
Message-ID: <87cyyxf0wl.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/renameat: Remove renameat fallback
 definition
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

Xiao Yang <yangx.jy@fujitsu.com> writes:

> Hi Xu,
>
> 1) Please explain why you drop the fallback definition by adding a
> commit message.

Yes, I don't want to remove this code unless there is a good argument
why it is safe.

Especially as the code is small and not causing any issues that I am
aware of.

Setting this to changes requested

> 2) I think the related code in the following file can also be removed:
> configure.ac
> include/lapi/syscalls/aarch64.in
> include/lapi/syscalls/arc.in
> include/lapi/syscalls/arm.in
> include/lapi/syscalls/hppa.in
> include/lapi/syscalls/i386.in
> include/lapi/syscalls/ia64.in
> include/lapi/syscalls/loongarch.in
> include/lapi/syscalls/mips_n32.in
> include/lapi/syscalls/mips_n64.in
> include/lapi/syscalls/mips_o32.in
> include/lapi/syscalls/powerpc.in
> include/lapi/syscalls/powerpc64.in
> include/lapi/syscalls/s390.in
> include/lapi/syscalls/s390x.in
> include/lapi/syscalls/sh.in
> include/lapi/syscalls/sparc.in
> include/lapi/syscalls/sparc64.in
> include/lapi/syscalls/x86_64.in
>
> Other than those, it looks good to me.
> Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
>
> Best Regards,
> Xiao Yang
>
> On 2023/8/24 19:10, Yang Xu wrote:
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/renameat.h                       | 23 -------------------
>>   .../kernel/syscalls/renameat/renameat01.c     |  1 -
>>   2 files changed, 24 deletions(-)
>>   delete mode 100644 include/lapi/renameat.h
>> diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
>> deleted file mode 100644
>> index abf4c1d6e..000000000
>> --- a/include/lapi/renameat.h
>> +++ /dev/null
>> @@ -1,23 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-or-later
>> -/*
>> - * Copyright (c) International Business Machines  Corp., 2007
>> - * Copyright (c) 2014 Fujitsu Ltd.
>> - */
>> -
>> -#ifndef LAPI_RENAMEAT_H__
>> -#define LAPI_RENAMEAT_H__
>> -
>> -#include <sys/types.h>
>> -#include "config.h"
>> -#include "lapi/syscalls.h"
>> -
>> -#if !defined(HAVE_RENAMEAT)
>> -static inline int renameat(int olddirfd, const char *oldpath, int newdirfd,
>> -                           const char *newpath)
>> -{
>> -	return tst_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
>> -					newpath);
>> -}
>> -#endif
>> -
>> -#endif /* LAPI_RENAMEAT_H__ */
>> diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
>> index 3de103563..c318a7971 100644
>> --- a/testcases/kernel/syscalls/renameat/renameat01.c
>> +++ b/testcases/kernel/syscalls/renameat/renameat01.c
>> @@ -50,7 +50,6 @@
>>   #include "test.h"
>>   #include "safe_macros.h"
>>   #include "lapi/fcntl.h"
>> -#include "lapi/renameat.h"
>>     #define MNTPOINT "mntpoint"
>>   #define TESTDIR "testdir"


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
