Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE523C10DC1
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 18:44:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4818D3CF5C7
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 19:44:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C781E3CC343
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:44:36 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 91A1A201DAA
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:44:35 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 5743D5C0100;
 Mon,  4 Dec 2023 13:44:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 04 Dec 2023 13:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1701715474; x=1701801874; bh=/8
 +124M5wIy87HPWZG9mXZq93YLN1UZHX1YC4qqLEN4=; b=R5CVCQthhs7inpZTsq
 qDdPsr8n3eGm+zJKw/9XczmGzDIDP6ug6+UqGALd0qSgInXntyrLK3k9ZJ9Sng9e
 f4shpg5EWn0D4yDXnKdYfcDpf4jTz/hHcV0GEMw27FMHsWfhrHPHIhbL8WS/qzWG
 fsTWY5G2PWxcuFxoGPaxdCasGM8Pjd86PykJXYQR5iFEa+GqytiR/ijRSaEn64wS
 s94LQ+ufwZK9EQ/+I0+EGmPRoYkv4gzeTvcwjsEjXouRS8b1ylREsXaU8vKAoEN7
 6rMIlS5lo+JQE7MaWfTjmtTE++MyUkMvTAamtB5p4LdzvcnzI94N9pdTVTnFVgko
 VF0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1701715474; x=1701801874; bh=/8+124M5wIy87
 HPWZG9mXZq93YLN1UZHX1YC4qqLEN4=; b=JmnLIIy67RqJwTQ8XnhFq+ajEK5b/
 E15vYWUjvwtS5YdFfU4oSgIG6gMF5RP6/tpfK8wG/22ZzFJdJGG9Bzj7j8zbOGdt
 HJ8qwyUvVz8DjwsKptl3SiOiK6yC1gKZBhOp6upsPZDrNzxDSDWev4tCWoUvNMG4
 zVvM42YR0LuoOPlEWsQO3N3vRRJqEQK/yv1Qjoxmdhz3dmP3ZL7ufp+jh9yZdM6e
 ZO5VsWAd3SIiAcF03Wf++J6cwsLawTUYtiuBIck+zS+m571EpFGOkKsfJbJGZBhj
 DysSkHgzvYjJrMvHY8FwSKErAi1J/yE+i5R0XvshYoa9P6MoAN1ncKgFg==
X-ME-Sender: <xms:ER5uZRV2jAi9sCNkWM03mNiI4oFnPc0q73pQiM9yM7iYteSL3Hf_kA>
 <xme:ER5uZRlBNy93wGOmTRCSgDVPZ5nPMJjyuguRhss-4exCKjFRjNoqk0RfEQyucU_fX
 2u03znyVaN_y2kB5pQ>
X-ME-Received: <xmr:ER5uZdaFb2daQ4Iky7hG0T4bSKw0UIpb13uAWgfZS7mJYU8yj9b87Bfp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
 fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
 htthgvrhhnpeeijeetleeujeeuffduffekhfdvtedtjefffeehveeijeejhfdtfeffgeej
 vdehfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:ER5uZUWs5XbMUZ34u72I4bJf-upkWMYxqv9fAwLFOdQtjDgN9WPpGA>
 <xmx:ER5uZbkbcNp1OfUsfvzLxG8wFoBdpUyuMuzDnXbPRSKqv-waIXdKJg>
 <xmx:ER5uZRegFjhgky8EReSTeW0znmq0T26Vm7XuVbdMNQroNCs6Y87yqw>
 <xmx:Eh5uZWt6nR5A5SqeBNEWHCkQgs6aU8RMOgF-btWlDjFcxsNioGMICA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 13:44:31 -0500 (EST)
References: <20231201210930.2651725-1-shr@devkernel.io>
 <20231201210930.2651725-3-shr@devkernel.io> <20231204103950.GA22019@pevik>
User-agent: mu4e 1.10.3; emacs 29.1
From: Stefan Roesch <shr@devkernel.io>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 04 Dec 2023 10:42:28 -0800
In-reply-to: <20231204103950.GA22019@pevik>
Message-ID: <87sf4hrenm.fsf@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] add ksm test for smart-scan feature
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
Cc: david@redhat.com, linux-mm@kvack.org, oliver.sang@intel.com,
 kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Petr Vorel <pvorel@suse.cz> writes:

> Hi Stefan,
>
> ...
>> +++ b/testcases/kernel/mem/ksm/ksm07.c
>> @@ -0,0 +1,69 @@
>> +/*
>> + * Copyright (C) 2010-2017  Red Hat, Inc.
>> + *
>
>> + * This program is free software;  you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> + * the GNU General Public License for more details.
> NOTE: we use SPDX instead of verbose GPL (see ksm06.c).
>> + *
>
> NOTE: we have special doc format which starts like this (see ksm06.c):
> /*\
>  * [Description]
>  *
>  * ...
>> + * Kernel Samepage Merging (KSM)
>> + *
>> + * This adds a new ksm (kernel samepage merging) test to evaluate the new
>> + * smart scan feature. It allocates a page and fills it with 'a'
>> + * characters. It captures the pages_skipped counter, waits for a few
>> + * iterations and captures the pages_skipped counter again. The expectation
>> + * is that over 50% of the page scans are skipped (There is only one page
>> + * that has KSM enabled and it gets scanned during each iteration and it
>> + * cannot be de-duplicated).
>> + *
>> + * Prerequisites:
>> + *
>> + * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
>> + *    distrub the testing as they also change some ksm tunables depends
>> + *    on current workloads.
> Hm, we don't have to any helper in LTP API to detect this, so at least we
> document this.
>> + *
>> + */
>
> The result is then uploaded:
> https://github.com/linux-test-project/ltp/releases/download/20230929/metadata.20230929.html
>
> Therefore please use:
>
> // SPDX-License-Identifier: GPL-2.0-or-later
> /*
>  * Copyright (C) 2010-2017  Red Hat, Inc.
>  */
> /*\
>  * [Description]
>  *
>  * Kernel Samepage Merging (KSM)
>  *
>  * This adds a new ksm (kernel samepage merging) test to evaluate the new
>  * smart scan feature. It allocates a page and fills it with 'a'
>  * characters. It captures the pages_skipped counter, waits for a few
>  * iterations and captures the pages_skipped counter again. The expectation
>  * is that over 50% of the page scans are skipped (There is only one page
>  * that has KSM enabled and it gets scanned during each iteration and it
>  * cannot be de-duplicated).
>  *
>  * Prerequisites:
>  *
>  * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
>  *    distrub the testing as they also change some ksm tunables depends
>  *    on current workloads.
>  */
>

The next version will use the above comment as documentation.

>> +
>> +#include <sys/types.h>
>> +#include <sys/mman.h>
>> +#include <sys/stat.h>
>> +#include <sys/wait.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <signal.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include "../include/mem.h"
>> +#include "ksm_common.h"
>> +
>> +static void verify_ksm(void)
>> +{
>> +	create_memory_for_smartscan();
> I wonder, if we reusable create_memory_for_smartscan() later. Maybe it should be
> put into ksm07 for the start.
>

I moved it over to ksm07.c and renamed it to create_memory.

> Also, the test needs to run on older kernel - exit with TCONF (which is not
> considered as a failure) instead of TBROK which does now:
> mem.c:488: TBROK: Failed to open FILE '/sys/kernel/mm/ksm/pages_skipped' for reading: ENOENT (2)
>

Changed it to TCONF.

> If the testing code stays in testcases/kernel/mem/lib/mem.c, you will have to
> stat() it. But if it's really just this test specific and you move it to
> ksm07.c, then you can simply add the handling via .save_restore.
>
>> +}
>> +
>> +static struct tst_test test = {
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.options = (struct tst_option[]) {
>> +		{}
>> +	},
>> +	.save_restore = (const struct tst_path_val[]) {
>> +		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
>> +		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
>> +		{"/sys/kernel/mm/ksm/smart_scan", "1",
>> +			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
>> +		{}
>> +	},
>> +	.needs_kconfigs = (const char *const[]){
>> +		"CONFIG_KSM=y",
>> +		NULL
>> +	},
>> +	.test_all = verify_ksm,
>> +};
>
> Also, there are missing static:
>

These are declared as non-static in ksm_common.h.

> $ cd testcases/kernel/mem/ksm/; make check-ksm07
> CHECK testcases/kernel/mem/ksm/ksm07.c
> ksm07.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> make: [../../../../include/mk/rules.mk:56: check-ksm07] Error 1 (ignored)
> ksm07.c: note: in included file:
> ksm_common.h:14:5: warning: Symbol 'size' has no prototype or library ('tst_') prefix. Should it be static?
> ksm_common.h:14:29: warning: Symbol 'num' has no prototype or library ('tst_') prefix. Should it be static?
> ksm_common.h:14:38: warning: Symbol 'unit' has no prototype or library ('tst_') prefix. Should it be static?
> ksm_common.h:15:6: warning: Symbol 'opt_sizestr' has no prototype or library
> ('tst_') prefix. Should it be static?
> ksm_common.h:15:20: warning: Symbol 'opt_numstr' has no prototype or library
> ('tst_') prefix. Should it be static?
> ksm_common.h:15:33: warning: Symbol 'opt_unitstr' has no prototype or library
> ('tst_') prefix. Should it be static?
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
