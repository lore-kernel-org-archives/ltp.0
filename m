Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144FDC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:14:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 696F73CBE6F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 17:14:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E4E13CBE28
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:14:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6511E10005C0
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:14:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 630B41FDD1
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670861654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1GyxR85QxDa9+KI7CKNpLzlpoqpFSeiY+W+9qPJ1Eg=;
 b=Ay53RbvSkR9plo9ZB9VLUOW3RTZRjUV7ZqPuDuaw5ERZweW4FJPTxLlosNhpkH7UiSN7Gt
 beMEzn+27pzVXHkFeu1eLJhBwEbrBp5dQwRQL1Se1i0px19aPGAFq/8nT0XSoh62G1mGCY
 ++f9EOQrBxr0+yzyCSUoSjumzizlX6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670861654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1GyxR85QxDa9+KI7CKNpLzlpoqpFSeiY+W+9qPJ1Eg=;
 b=Tq0yK4oonQPr4sKEntbXYnN8C90zOU7cENpiZdcHrUUmgj0TNsMqDx8XSE7Mb6xWHRBXKU
 s6uJHVixA3xD8mAw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3BC6C2C141;
 Mon, 12 Dec 2022 16:14:14 +0000 (UTC)
References: <20221206165840.12107-1-rpalethorpe@suse.com>
 <Y5dOdWVLPXfgGKGg@rei>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2022 16:07:48 +0000
Organization: Linux Private Site
In-reply-to: <Y5dOdWVLPXfgGKGg@rei>
Message-ID: <87sfhksip6.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getcpu01: Reinstate node_id test
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Presently the node_id is only checked on i386 and it is broken. The
>> sched_getcpu call was substituted for getcpu when
>> available. sched_getcpu does not have the node_id parameter and does
>> not even call SYS_getcpu if it can be completed by vDSO.
>> 
>> Also we can at least check the node_id on x86_64 as well.
>
> I suppose that the getcpu manual page is a bit confusing, the function
> is implemented on most of the major achitectures and as VDSO on most of
> them too. It was only added first to x86 architectures.

I suppose I overlooked that there is a libc implementation of
getcpu. IDK why sched_getcpu is here at all and my vDSO comment is just
about how sched_getcpu would not result in a call to getcpu. However I
agree we should just call the libc version.

>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>  testcases/kernel/syscalls/getcpu/getcpu01.c | 22 +++++++++------------
>>  1 file changed, 9 insertions(+), 13 deletions(-)
>> 
>> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
>> index fcc273e29..21c67f412 100644
>> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
>> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
>> @@ -15,20 +15,16 @@
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <sys/types.h>
>> +#include "tst_test.h"
>>  #include "lapi/syscalls.h"
>>  #include "lapi/cpuset.h"
>> -#include "tst_test.h"
>>  #include "config.h"
>>  
>>  static inline int get_cpu(unsigned *cpu_id,
>> -			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
>> -			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
>> +			  unsigned *node_id)
>>  {
>> -#ifndef HAVE_SCHED_GETCPU
>> -	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
>> -#else
>> -	*cpu_id = sched_getcpu();
>> -#endif
>> +	return tst_syscall(__NR_getcpu, cpu_id, node_id, NULL);
>
> The call is mostly implemneted as VDSO so it would make much more sense
> to test the libc function instead and test the implementation that is
> actually used in production.
>
>>  	return 0;
>>  }
>>  
>> @@ -78,7 +74,7 @@ realloc:
>>  	return cpu_max;
>>  }
>>  
>> -#ifdef __i386__
>> +#if  defined(__i386__) || defined(__x86_64__)
>>  static unsigned int get_nodeid(unsigned int cpu_id)
>>  {
>>  	DIR *directory_parent, *directory_node;
>> @@ -125,22 +121,22 @@ static void run(void)
>>  {
>>  	unsigned int cpu_id, node_id = 0;
>>  	unsigned int cpu_set;
>
>
> The get_nodeid() just parses sysfs, that should be portable, can't we
> just get rid of the ifdefs completely instead?

That's what I thought too. I Will remove them.

>
>> -#ifdef __i386__
>> +#if defined(__i386__) || defined(__x86_64__)
>>  	unsigned int node_set;
>>  #endif
>>  
>>  	cpu_set = set_cpu_affinity();
>> -#ifdef __i386__
>> +#if defined(__i386__) || defined(__x86_64__)
>>  	node_set = get_nodeid(cpu_set);
>>  #endif
>>  
>> -	TEST(get_cpu(&cpu_id, &node_id, NULL));
>> +	TEST(get_cpu(&cpu_id, &node_id));
>>  	if (TST_RET == 0) {
>>  		if (cpu_id != cpu_set)
>>  			tst_res(TFAIL, "getcpu() returned wrong value"
>>  				" expected cpuid:%d, returned value cpuid: %d",
>>  				cpu_set, cpu_id);
>> -#ifdef __i386__
>> +#if defined(__i386__) || defined(__x86_64__)
>>  		else if (node_id != node_set)
>>  			tst_res(TFAIL, "getcpu() returned wrong value"
>>  				" expected  node id:%d returned  node id:%d",
>> -- 
>> 2.38.1
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Also I guess the kver check for 2.6 can be removed.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
