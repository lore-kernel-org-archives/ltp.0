Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E74C4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 18:01:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 783713CD933
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 19:01:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EBC23CC0A4
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 19:01:44 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6927F60070B
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 19:01:40 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 07AEB3200A0B;
 Tue,  5 Dec 2023 13:01:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Tue, 05 Dec 2023 13:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1701799296; x=1701885696; bh=85
 e1GmDiyHTfrg3rUKrpj0PaSvamgNAlUYDz2Du3CA8=; b=LAhjXKNllTDDX2R02R
 jhcMHTUkYt/FrbfhlgOy3NIAYxHNkl5HOx8XTXMWdeX8O+NtWMQA5FDrQZY1/BlK
 zBCUaAZ4xZQOWYBuJ9DBYmDHz/C7lXcgzLY5a7EOXbVKGixo24WDpG5l4Ajtdr6o
 0gdt5Z/acXxTbRIM5F6/mMs+OmJesVA8AWIu/cNPukr46JML2iBzjK2/wXuHnqHl
 EcFi1sMKi4tamBSJldJtSzDigxCN7zfEqnGlGHVPrmbbtnROrVx50+IKI+nddrxy
 9w3LZZdZl2omSUoNl2c+AE5k1+Z23piCRkIiJUDY2tsATxLgMRyJZUFi+pIRMm6O
 hyqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1701799296; x=1701885696; bh=85e1GmDiyHTfr
 g3rUKrpj0PaSvamgNAlUYDz2Du3CA8=; b=ajwk9hnT8KvmTSG1Z3d045nwSj5Qm
 D3ZTQWLiCZLenkXcgo8H/hrPWDFBlyThgY8xrNI3FyUYVb7kZCM7EhOhznSpKsMl
 Sie9PD4yOfiNbJAiOFwbNoMp+9rbNFCe4evzw2utpbesRJPEo7vdKclVpU7FWNCX
 GyDlzs5YOwnfLbwIku7z3J36oOo3xT6nPPfR94u6sCyo/zMN2CHrctuSVH2THc1c
 PJ+MB8JE2vyrVty2ou4QtxRpjAEsP4QyQxzvJnVVSHQUKhBj1yCfKoUn2YAb3pIC
 q4efD3YgiFgHKoSXWvTbffWCG9G7bQlMi6oyUdUaEc+R6IZfZNTRUsO+A==
X-ME-Sender: <xms:f2VvZdlC9oLo-Fp7ybjLLHQgNiJLLILHTwNXmMKcmXKXR8JBWSds7w>
 <xme:f2VvZY2I6xhlk1eSJatg-Ifl4MfbhnoricWFIFW6chj1KnZlWLLDxXxlhEK4Blamy
 vvQ7R8Cdb7njrLiZKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedguddtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
 thgvfhgrnhcutfhovghstghhfdcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecugg
 ftrfgrthhtvghrnheplefgteffgfejtdelfeekgfetjefftdejgfdvudffiedtueevvdej
 gfevvdfgleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:f2VvZToqVFg500EfKuwZWNbxTaDz5oAS57dIfp5l_hYhhYrju1qznQ>
 <xmx:f2VvZdmCIbi2-wa6wi_cWulGClEb2gn26zFPBjJkH0Z8L5OaV0_-BQ>
 <xmx:f2VvZb1wI4y0GwGbv-5nfH1sih9EeCo0pUlAccXiHiAnbJwExQLqjA>
 <xmx:gGVvZWSkHQ-3mhkgnCUBr1lF2XUYgp38nGV1F3ZycY-qRWxaKtowYw>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9D598B60089; Tue,  5 Dec 2023 13:01:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <8d8c22e2-1ca4-4400-a5e5-7745c298893a@app.fastmail.com>
In-Reply-To: <20231205131608.GB55404@pevik>
References: <20231204184817.3570465-1-shr@devkernel.io>
 <20231204184817.3570465-3-shr@devkernel.io> <20231205131608.GB55404@pevik>
Date: Tue, 05 Dec 2023 10:01:09 -0800
From: "Stefan Roesch" <shr@devkernel.io>
To: "Petr Vorel" <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] add ksm test for smart-scan feature
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



On Tue, Dec 5, 2023, at 5:16 AM, Petr Vorel wrote:
> Hi Stefan,
>
>> This adds a new ksm (kernel samepage merging) test to evaluate the new
>> smart scan feature. It allocates a page and fills it with 'a'
>> characters. It captures the pages_skipped counter, waits for a few
>> iterations and captures the pages_skipped counter again. The expectation
>> is that over 50% of the page scans are skipped (There is only one page
>> that has KSM enabled and it gets scanned during each iteration and it
>> cannot be de-duplicated).
>
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>  runtest/mm                       |   1 +
>>  testcases/kernel/mem/.gitignore  |   1 +
>>  testcases/kernel/mem/ksm/ksm07.c | 131 +++++++++++++++++++++++++++++++
>>  3 files changed, 133 insertions(+)
>>  create mode 100644 testcases/kernel/mem/ksm/ksm07.c
>
>> diff --git a/runtest/mm b/runtest/mm
>> index f288fed36..d859b331c 100644
>> --- a/runtest/mm
>> +++ b/runtest/mm
>> @@ -70,6 +70,7 @@ ksm05 ksm05 -I 10
>>  ksm06 ksm06
>>  ksm06_1 ksm06 -n 10
>>  ksm06_2 ksm06 -n 8000
>> +ksm07 ksm07
>
>>  cpuset01 cpuset01
>
>> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
>> index 7258489ed..c96fe8bfc 100644
>> --- a/testcases/kernel/mem/.gitignore
>> +++ b/testcases/kernel/mem/.gitignore
>> @@ -53,6 +53,7 @@
>>  /ksm/ksm04
>>  /ksm/ksm05
>>  /ksm/ksm06
>> +/ksm/ksm07
>>  /mem/mem02
>>  /mmapstress/mmap-corruption01
>>  /mmapstress/mmapstress01
>> diff --git a/testcases/kernel/mem/ksm/ksm07.c b/testcases/kernel/mem/ksm/ksm07.c
>> new file mode 100644
>> index 000000000..16153fdb2
>> --- /dev/null
>> +++ b/testcases/kernel/mem/ksm/ksm07.c
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2010-2017  Red Hat, Inc.
>> + */
>> +/*\
>> + * [Description]
>> + *
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
>> + */
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
>> +/* This test allocates one page, fills the page with a's, captures the
>> + * full_scan and pages_skipped counters. Then it makes sure at least 3
>> + * full scans have been performed and measures the above counters again.
>> + * The expectation is that at least 50% of the pages are skipped.
>> + *
>> + * To wait for at least 3 scans it uses the wait_ksmd_full_scan() function. In
>> + * reality, it will be a lot more scans as the wait_ksmd_full_scan() function
>> + * sleeps for one second.
>> + */
>> +static void create_memory(void)
>> +{
>> +	int status;
>> +	int full_scans_begin;
>> +	int full_scans_end;
>> +	int pages_skipped_begin;
>> +	int pages_skipped_end;
>> +	int diff_pages;
>> +	int diff_scans;
>> +	unsigned long page_size;
>> +	char *memory;
>> +
>> +	/* Apply for the space for memory. */
>> +	page_size = sysconf(_SC_PAGE_SIZE);
>> +	memory = SAFE_MALLOC(page_size);
>> +
>> +	for (int i = 0; i < 1; i++) {
>> +		memory = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
>> +			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>> +#ifdef HAVE_DECL_MADV_MERGEABLE
>> +		if (madvise(memory, page_size, MADV_MERGEABLE) == -1)
>> +			tst_brk(TBROK|TERRNO, "madvise");
>> +#endif
>> +	}
>> +	memset(memory, 'a', page_size);
>> +
>> +	tst_res(TINFO, "KSM merging...");
>> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
>> +		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
>> +	}
>> +
>> +	/* Set defalut ksm scan values. */
>> +	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
>> +	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", 100l);
>> +	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
>> +
>> +	/* Measure pages skipped aka "smart scan". */
>> +	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_begin);
>> +	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_begin);
> Unfortunately SAFE_FILE_SCANF quits on missing file and
> /sys/kernel/mm/ksm/pages_skipped is not on kernel < 6.7.
>
> safe_file_vprintf() which SAFE_FILE_SCANF() internally uses does not support any
> flag to quit with TCONF instead TBROK when /sys/kernel/mm/ksm/pages_skipped does
> not exists.
>
> We could use access() in setup function, but another line in .save_restore will
> help:
>
> {PATH_KSM "pages_skipped", NULL, TST_SR_TCONF}
>

I don't think this works correctly. I see a warning:

tst_sys_conf.c:144: TINFO: Failed to open FILE '/sys/kernel/mm/ksm/pages_skipped'

The difference to the other ksm files is, that this is not writeable.

>> +	wait_ksmd_full_scan();
>> +
>> +	tst_res(TINFO, "stop KSM.");
>> +	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
>> +
>> +	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_end);
>> +	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_end);
>> +	diff_pages = pages_skipped_end - pages_skipped_begin;
>> +	diff_scans = full_scans_end - full_scans_begin;
>
> I was going to merge this (with minor cleanup), but the only remaining issue is
> that we allow to test run repeatedly via -iN:
>
> # ./ksm07 -i2
> tst_test.c:1574: TINFO: Timeout per run is 0h 00m 30s
> ksm07.c:73: TINFO: KSM merging...
> ksm_helper.c:36: TINFO: ksm daemon takes 1s to run two full scans
> ksm07.c:88: TINFO: stop KSM.
> ksm07.c:99: TPASS: smart_scan skipped more than 50% of the pages.
> ksm07.c:73: TINFO: KSM merging...
> ksm_helper.c:36: TINFO: ksm daemon takes 1s to run two full scans
> ksm07.c:88: TINFO: stop KSM.
> ksm07.c:97: TFAIL: not enough pages have been skipped by smart_scan.
>
> I'm confused, how to reset KSM to be able to run the test more times?
>
>> +
>> +	if (diff_pages < diff_scans * 50 / 100) {
>> +		tst_res(TFAIL, "not enough pages have been skipped by smart_scan.");
>> +	} else {
>> +		tst_res(TPASS, "smart_scan skipped more than 50%% of the pages.");
>> +	}
>> +
>> +	while (waitpid(-1, &status, 0) > 0)
>> +		if (WEXITSTATUS(status) != 0)
>> +			tst_res(TFAIL, "child exit status is %d",
>> +					WEXITSTATUS(status));
>> +}
> This is not needed, done by check_child_status() in
> lib/tst_test.c.
>
>> +
>> +static void verify_ksm(void)
>> +{
>> +	create_memory();
>> +}
> Why this wrapper? "verify_" as a pattern name is not a must.
>> +
>> +static struct tst_test test = {
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.options = (struct tst_option[]) {
>> +		{}
>> +	},
>> +	.save_restore = (const struct tst_path_val[]) {
>> +		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TCONF},
>> +		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TCONF},
>> +		{"/sys/kernel/mm/ksm/smart_scan", "1",
> We have PATH_KSM definition, lets use it.
>
>> +			TST_SR_SKIP_MISSING | TST_SR_TCONF},
>> +		{}
>> +	},
>> +	.needs_kconfigs = (const char *const[]){
>> +		"CONFIG_KSM=y",
>> +		NULL
>> +	},
>> +	.test_all = verify_ksm,
>> +};
>
> I was going to merge your patch with following changes.
> We just need solve -i2 issue.
>

I have a solution for this: we need another madvise call at the end. I'll send
it with the next version.

> Kind regards,
> Petr
>
> diff --git testcases/kernel/mem/ksm/ksm07.c testcases/kernel/mem/ksm/ksm07.c
> index 16153fdb2..e5c31775b 100644
> --- testcases/kernel/mem/ksm/ksm07.c
> +++ testcases/kernel/mem/ksm/ksm07.c
> @@ -5,35 +5,25 @@
>  /*\
>   * [Description]
>   *
> - * Kernel Samepage Merging (KSM)
> + * Kernel Samepage Merging (KSM) for smart scan feature
>   *
> - * This adds a new ksm (kernel samepage merging) test to evaluate the new
> - * smart scan feature. It allocates a page and fills it with 'a'
> - * characters. It captures the pages_skipped counter, waits for a few
> - * iterations and captures the pages_skipped counter again. The expectation
> - * is that over 50% of the page scans are skipped (There is only one page
> - * that has KSM enabled and it gets scanned during each iteration and it
> - * cannot be de-duplicated).
> + * Test allocates a page and fills it with 'a' characters. It captures the
> + * pages_skipped counter, waits for a few  iterations and captures the
> + * pages_skipped counter again. The expectation  is that over 50% of the page
> + * scans are skipped. (There is only one page that has KSM enabled and it gets
> + * scanned during each iteration and it cannot be de-duplicated.)
>   *
> - * Prerequisites:
> + * Smart scan feature was added in kernel v6.7.
>   *
> - * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
> - *    distrub the testing as they also change some ksm tunables depends
> - *    on current workloads.
> + * [Prerequisites]
> + *
> + * ksm and ksmtuned daemons need to be disabled. Otherwise, it could
> + * distrub the testing as they also change some ksm tunables depends
> + * on current workloads.
>   */
> -#include <sys/types.h>
> -#include <sys/mman.h>
> -#include <sys/stat.h>
> +
>  #include <sys/wait.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <signal.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include "../include/mem.h"
> -#include "ksm_common.h"
> +#include "mem.h"
> 
>  /* This test allocates one page, fills the page with a's, captures the
>   * full_scan and pages_skipped counters. Then it makes sure at least 3
> @@ -46,7 +36,6 @@
>   */
>  static void create_memory(void)
>  {
> -	int status;
>  	int full_scans_begin;
>  	int full_scans_end;
>  	int pages_skipped_begin;
> @@ -70,10 +59,10 @@ static void create_memory(void)
>  	}
>  	memset(memory, 'a', page_size);
> 
> -	tst_res(TINFO, "KSM merging...");
> -	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
> +	tst_res(TINFO, "KSM merging");
> +
> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
>  		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
> -	}
> 
>  	/* Set defalut ksm scan values. */
>  	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
> @@ -85,7 +74,7 @@ static void create_memory(void)
>  	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_begin);
>  	wait_ksmd_full_scan();
> 
> -	tst_res(TINFO, "stop KSM.");
> +	tst_res(TINFO, "stop KSM");
>  	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
> 
>  	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_end);
> @@ -93,21 +82,10 @@ static void create_memory(void)
>  	diff_pages = pages_skipped_end - pages_skipped_begin;
>  	diff_scans = full_scans_end - full_scans_begin;
> 
> -	if (diff_pages < diff_scans * 50 / 100) {
> -		tst_res(TFAIL, "not enough pages have been skipped by smart_scan.");
> -	} else {
> -		tst_res(TPASS, "smart_scan skipped more than 50%% of the pages.");
> -	}
> -
> -	while (waitpid(-1, &status, 0) > 0)
> -		if (WEXITSTATUS(status) != 0)
> -			tst_res(TFAIL, "child exit status is %d",
> -					WEXITSTATUS(status));
> -}
> -
> -static void verify_ksm(void)
> -{
> -	create_memory();
> +	if (diff_pages < diff_scans * 50 / 100)
> +		tst_res(TFAIL, "not enough pages have been skipped by smart_scan");
> +	else
> +		tst_res(TPASS, "smart_scan skipped more than 50%% of the pages");
>  }
> 
>  static struct tst_test test = {
> @@ -117,9 +95,10 @@ static struct tst_test test = {
>  		{}
>  	},
>  	.save_restore = (const struct tst_path_val[]) {
> -		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TCONF},
> -		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TCONF},
> -		{"/sys/kernel/mm/ksm/smart_scan", "1",
> +		{PATH_KSM "pages_skipped", NULL, TST_SR_TCONF},
> +		{PATH_KSM "run", NULL, TST_SR_TCONF},
> +		{PATH_KSM "sleep_millisecs", NULL, TST_SR_TCONF},
> +		{PATH_KSM "smart_scan", "1",
>  			TST_SR_SKIP_MISSING | TST_SR_TCONF},
>  		{}
>  	},
> @@ -127,5 +106,5 @@ static struct tst_test test = {
>  		"CONFIG_KSM=y",
>  		NULL
>  	},
> -	.test_all = verify_ksm,
> +	.test_all = create_memory,
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
