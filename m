Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E080C4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 11:02:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47ECC3CCA78
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 12:02:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03C993C869D
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 12:02:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 404451A0BC29
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 12:02:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1EB421EE8;
 Tue,  5 Dec 2023 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701774125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyYO7o6BbiObRjMvlwvXOl8N5YoIoYx7sY6bMOUePcs=;
 b=ZHRNvYRVaootn/+AnP/Y7e2BAS8evpq0PC4H0VVm7EtBw5n+Zec4/katsdP7Rx0JhpulWe
 80WR8FIjX0064cUJqfvJw8Ekv/Mn+CDhKm9aZzTM0sPAjifiv2m5A1mZOCJMeZpC7cRw1h
 LtA0T8j3/sfquy0vcKzR5QSE1rlZCeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701774125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyYO7o6BbiObRjMvlwvXOl8N5YoIoYx7sY6bMOUePcs=;
 b=YDjKYyUZPm6FBTsT4Y63qmocrzwC42zpZ+jMLYHUVmKW3Qk6Ln1K0s7rY81TYq7JhFMWIf
 yTWgMUg0ZVCEujDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A30D2136CF;
 Tue,  5 Dec 2023 11:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 90rIJi0Db2XTeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Dec 2023 11:02:05 +0000
Date: Tue, 5 Dec 2023 12:02:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Stefan Roesch <shr@devkernel.io>
Message-ID: <ZW8DVo6UfSofc9WP@yuki>
References: <20231204184817.3570465-1-shr@devkernel.io>
 <20231204184817.3570465-3-shr@devkernel.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231204184817.3570465-3-shr@devkernel.io>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.it:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Cc: linux-mm@kvack.org, kernel-team@fb.com, oliver.sang@intel.com,
 ltp@lists.linux.it, david@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 7258489ed..c96fe8bfc 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -53,6 +53,7 @@
>  /ksm/ksm04
>  /ksm/ksm05
>  /ksm/ksm06
> +/ksm/ksm07
>  /mem/mem02
>  /mmapstress/mmap-corruption01
>  /mmapstress/mmapstress01
> diff --git a/testcases/kernel/mem/ksm/ksm07.c b/testcases/kernel/mem/ksm/ksm07.c
> new file mode 100644
> index 000000000..16153fdb2
> --- /dev/null
> +++ b/testcases/kernel/mem/ksm/ksm07.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2010-2017  Red Hat, Inc.
                      ^
		      2023?
> + */
> +/*\
> + * [Description]
> + *
> + * Kernel Samepage Merging (KSM)
> + *
> + * This adds a new ksm (kernel samepage merging) test to evaluate the new
> + * smart scan feature. It allocates a page and fills it with 'a'
> + * characters. It captures the pages_skipped counter, waits for a few
> + * iterations and captures the pages_skipped counter again. The expectation
> + * is that over 50% of the page scans are skipped (There is only one page
> + * that has KSM enabled and it gets scanned during each iteration and it
> + * cannot be de-duplicated).
> + *
> + * Prerequisites:
> + *
> + * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
> + *    distrub the testing as they also change some ksm tunables depends
> + *    on current workloads.

I guess that it would be more user friendly to check if a process with
such name is running and at least print a warning, or even skip the
test.

I suppose that we can add a library function that would loop over
/proc/*/comm and return true if we find a match.

> + */
> +#include <sys/types.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "../include/mem.h"
> +#include "ksm_common.h"
> +
> +/* This test allocates one page, fills the page with a's, captures the
> + * full_scan and pages_skipped counters. Then it makes sure at least 3
> + * full scans have been performed and measures the above counters again.
> + * The expectation is that at least 50% of the pages are skipped.
> + *
> + * To wait for at least 3 scans it uses the wait_ksmd_full_scan() function. In
> + * reality, it will be a lot more scans as the wait_ksmd_full_scan() function
> + * sleeps for one second.
> + */
> +static void create_memory(void)
> +{
> +	int status;
> +	int full_scans_begin;
> +	int full_scans_end;
> +	int pages_skipped_begin;
> +	int pages_skipped_end;
> +	int diff_pages;
> +	int diff_scans;
> +	unsigned long page_size;
> +	char *memory;
> +
> +	/* Apply for the space for memory. */
> +	page_size = sysconf(_SC_PAGE_SIZE);
> +	memory = SAFE_MALLOC(page_size);
> +
> +	for (int i = 0; i < 1; i++) {
> +		memory = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
> +			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +#ifdef HAVE_DECL_MADV_MERGEABLE
> +		if (madvise(memory, page_size, MADV_MERGEABLE) == -1)
> +			tst_brk(TBROK|TERRNO, "madvise");
> +#endif
> +	}
> +	memset(memory, 'a', page_size);
> +
> +	tst_res(TINFO, "KSM merging...");
> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
> +		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
> +	}
> +
> +	/* Set defalut ksm scan values. */
> +	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
> +	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", 100l);
> +	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
> +
> +	/* Measure pages skipped aka "smart scan". */
> +	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_begin);
> +	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_begin);
> +	wait_ksmd_full_scan();
> +
> +	tst_res(TINFO, "stop KSM.");
> +	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
> +
> +	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_end);
> +	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_end);
> +	diff_pages = pages_skipped_end - pages_skipped_begin;
> +	diff_scans = full_scans_end - full_scans_begin;
> +
> +	if (diff_pages < diff_scans * 50 / 100) {
> +		tst_res(TFAIL, "not enough pages have been skipped by smart_scan.");
> +	} else {
> +		tst_res(TPASS, "smart_scan skipped more than 50%% of the pages.");
> +	}
> +
> +	while (waitpid(-1, &status, 0) > 0)
> +		if (WEXITSTATUS(status) != 0)
> +			tst_res(TFAIL, "child exit status is %d",
> +					WEXITSTATUS(status));

Does the test fork a child? I do not see any place in the code that
would do so, did I miss something?

> +}
> +
> +static void verify_ksm(void)
> +{
> +	create_memory();

This is useless indirection.

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.options = (struct tst_option[]) {
> +		{}
> +	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TCONF},
> +		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TCONF},
> +		{"/sys/kernel/mm/ksm/smart_scan", "1",
> +			TST_SR_SKIP_MISSING | TST_SR_TCONF},
> +		{}
> +	},
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_KSM=y",
> +		NULL
> +	},
> +	.test_all = verify_ksm,
> +};
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
