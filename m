Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E1DC4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 12:13:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8212E3CE59C
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 13:13:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CEEB3C88B0
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 13:13:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B4ECA601463
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 13:13:09 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6D767218FA;
 Mon, 13 Nov 2023 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699877587;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXF3upGN1UyKGal0aZDvIW0jnlvfQ59B6YOBgbR1nRg=;
 b=EJnT4oe+2HjwuQ45aaCAWZM5LwZ6hTHkr0MyuTe2h4eLJsdVTtMVwj+F8Q+VIJL0ekAoF4
 +36jxKmDSn+zMHRX88H03Rd6cnbeP5k6rMXFYNBjkfDG+WZCckdQ5F2bXfAt9liCdjLK1u
 +TXTYGt5Ky6VqRhmHfCvvh3ilO/3ZYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699877587;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXF3upGN1UyKGal0aZDvIW0jnlvfQ59B6YOBgbR1nRg=;
 b=wt+xDFSRapfJqVuKkJRK2IJz3Bv0CBTnEfgIqixuB4i52Tjr94NdeRMAyfpdVLjhrKG04b
 uttJOfc9153WleDw==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0749E2C7E2;
 Mon, 13 Nov 2023 12:13:06 +0000 (UTC)
References: <20230913082214.8453-1-samir@linux.vnet.ibm.com>
 <87cywdc0zv.fsf@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: rpalethorpe@suse.de
Date: Mon, 13 Nov 2023 12:09:49 +0000
Organization: Linux Private Site
In-reply-to: <87cywdc0zv.fsf@suse.de>
Message-ID: <878r71c0mm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
 libhugetlbfs/testcases/stack_grow_into_huge.c test
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Samir Mulani <samir@linux.vnet.ibm.com> writes:
>
>> Test Description:On PowerPC, the address space is divided into segments.
>> These segments can contain either huge pages or normal pages, but not
>> both.
>> All segments are initially set up to map normal pages. When a huge page
>> mapping is created within a set of empty segments, they are "enabled"
>> for huge pages at that time. Once enabled for huge pages, they can
>> not be used again for normal pages for the remaining lifetime of the
>> process.
>>
>> If the segment immediately preceeding the segment containing the stack is
>> converted to huge pages and the stack is made to grow into the this
>> preceeding segment, some kernels may attempt to map normal pages into the
>> huge page-only segment -- resulting in bugs.
>>
>> Signed-off-by: Samir Mulani <samir@linux.vnet.ibm.com>
>> ---
>> v2:
>> Below are the requested changes in version 2:
>> 1. Fixed "make check warnings"
>> 2. Removed explicit calls to exit(1)
>> 3.[To get the information about the child state], adapted the "tst_strstatus" implementation.
>> ---
>>  runtest/hugetlb                               |   1 +
>>  testcases/kernel/mem/.gitignore               |   1 +
>>  .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  | 130 ++++++++++++++++++
>>  3 files changed, 132 insertions(+)
>>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
>>
>> diff --git a/runtest/hugetlb b/runtest/hugetlb
>> index 299c07ac9..0c812c780 100644
>> --- a/runtest/hugetlb
>> +++ b/runtest/hugetlb
>> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>>  hugemmap30 hugemmap30
>>  hugemmap31 hugemmap31
>>  hugemmap32 hugemmap32
>> +hugemmap34 hugemmap34
>>  hugemmap05_1 hugemmap05 -m
>>  hugemmap05_2 hugemmap05 -s
>>  hugemmap05_3 hugemmap05 -s -m
>> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
>> index 7258489ed..41f547edf 100644
>> --- a/testcases/kernel/mem/.gitignore
>> +++ b/testcases/kernel/mem/.gitignore
>> @@ -34,6 +34,7 @@
>>  /hugetlb/hugemmap/hugemmap30
>>  /hugetlb/hugemmap/hugemmap31
>>  /hugetlb/hugemmap/hugemmap32
>> +/hugetlb/hugemmap/hugemmap34
>>  /hugetlb/hugeshmat/hugeshmat01
>>  /hugetlb/hugeshmat/hugeshmat02
>>  /hugetlb/hugeshmat/hugeshmat03
>> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
>> new file mode 100644
>> index 000000000..914a015bc
>> --- /dev/null
>> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2005-2006 IBM Corporation
>> + * Author: David Gibson & Adam Litke
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Test Name: stack_grow_into_huge
>> + *
>> + * On PowerPC, the address space is divided into segments.  These
>> segments can
>
> So does this test work on other architectures?
>
> There don't seem to be any ifdefs to prevent it running on them. We may
> need to limit it to PowerPC and call TST_TEST_TCONF otherwise.
>
>> + * contain either huge pages or normal pages, but not both.  All segments are
>> + * initially set up to map normal pages.  When a huge page mapping is created
>> + * within a set of empty segments, they are "enabled" for huge pages at that
>> + * time.  Once enabled for huge pages, they can not be used again for normal
>> + * pages for the remaining lifetime of the process.
>> + *
>> + * If the segment immediately preceeding the segment containing the stack is
>> + * converted to huge pages and the stack is made to grow into the this
>> + * preceeding segment, some kernels may attempt to map normal pages into the
>> + * huge page-only segment -- resulting in bugs.
>> + */
>> +
>> +#include "hugetlb.h"
>> +
>> +#ifdef __LP64__
>> +#define STACK_ALLOCATION_SIZE	(256*1024*1024)
>> +#else
>> +#define STACK_ALLOCATION_SIZE	(16*1024*1024)
>> +#endif
>> +#define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
>> +#define MNTPOINT "hugetlbfs/"
>> +static int  fd = -1;
>> +static unsigned long long hpage_size;
>> +static int page_size;
>> +
>> +
>> +void do_child(void *stop_address)
>> +{
>> +	struct rlimit r;
>> +	volatile int *x;
>> +
>> +	/* corefile from this process is not interesting and limiting
>> +	 * its size can save a lot of time. '1' is a special value,
>> +	 * that will also abort dumping via pipe, which by default
>> +	 * sets limit to RLIM_INFINITY.
>> +	 */
>> +	r.rlim_cur = 1;
>> +	r.rlim_max = 1;
>> +	SAFE_SETRLIMIT(RLIMIT_CORE, &r);
>> +
>> +	do {
>> +		x = alloca(STACK_ALLOCATION_SIZE);
>> +		*x = 1;
>> +	} while ((void *)x >= stop_address);
>> +}
>> +
>> +static void run_test(void)
>> +{
>> +	int pid, status;
>> +	void *stack_address, *mmap_address, *heap_address;
>> +
>> +	stack_address = alloca(0);
>> +	heap_address = sbrk(0);
>> +
>> +	/*
>> +	 * paranoia: start mapping two hugepages below the start of the stack,
>> +	 * in case the alignment would cause us to map over something if we
>> +	 * only used a gap of one hugepage.
>> +	 */
>> +	mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
>> +	do {
>> +		SAFE_MMAP(mmap_address, hpage_size, PROT_READ|PROT_WRITE,
>> +				MAP_FIXED|MAP_SHARED, fd, 0);
>
> I think this will fail if CGroup limits are in effect as well. It could
> also hit other limits, but probably not on systems where hugepages are
> important.
>
> In any case I think if mmap fails with ENOMEM (at least), then it should
> exit with TCONF.
>
>> +		mmap_address -= hpage_size;
>> +		/*
>> +		 * if we get all the way down to the heap, stop trying
>> +		 */
>> +	} while (mmap_address <= heap_address);
>
> Won't this clobber the heap and any other mappings the LTP libs or
> compiler instrumentations have (if any)?
>
> Could we use MAP_FIXED_NOREPLACE instead?
>
> Looking at the description we only need a single mapping to set the
> segment to a hugepage segment. It's not clear why such a large mapping
> is needed?

I reread the V1 patch and it seems like the original intent is to keep
calling mmap *until it succeeds once* then exit the loop.

So you can't use SAFE_MMAP in this case.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
