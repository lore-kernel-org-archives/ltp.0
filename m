Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF45C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 09:39:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29C683E6FA1
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 11:39:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 946FE3E586B
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 11:39:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A738D600D14
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 11:39:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2580780534;
 Fri,  7 Aug 2026 09:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786095569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tw93+rKrCh/uKiHvlxFiRshSswT8lPjoLoLEkjgoy4M=;
 b=FH1L6SeBJGwDGUXyL55dUgUE5ntlXFMTj0Z0m8/trltgzjYGO417OXcQu+4brqZAbTPQDA
 YR2H+8f9YXEIVpCmIiAL9Z91es8FvILq84hl/VKQOD5jEh8qQVjlfOKc0gYTumR3iaOyPA
 93BuclFl/itPuJ3HtkA52Lp6nrCtZtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786095569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tw93+rKrCh/uKiHvlxFiRshSswT8lPjoLoLEkjgoy4M=;
 b=f+Bj3KFnQvxTPIViG15ywB3QV93jDduPnXNDD0r8e+xQdTsaY0YEScBr2TYZzmRYteINt1
 4YcVyBJF+qJ46KDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786095565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tw93+rKrCh/uKiHvlxFiRshSswT8lPjoLoLEkjgoy4M=;
 b=yRfB8hMNm9M7I3GfNIerhD6NwmSxyUcIx6oJtD1nWoF45yq1Ar76U3yVyG7P9/mMGETbVe
 RgC0yl5YfpY/P/BN+WgCA/mP+oVAuExbQU4pOYIEemhnKpLGcnssmZnxi1VPv1LWTZ0wJU
 bj0tr8Bti6G9kKBT/chtMVgGDUJR0bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786095565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tw93+rKrCh/uKiHvlxFiRshSswT8lPjoLoLEkjgoy4M=;
 b=6JT1UtDDmG0vId02WoVzZf0cSxgSUNZhf5gVA5HSOHQQsR7vjWz9iPux3MUROshmOLwECA
 xx8GMgbVDRDqmCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10285779B6;
 Fri,  7 Aug 2026 09:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4HsXA82ndWo0FAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Aug 2026 09:39:25 +0000
Date: Fri, 7 Aug 2026 11:39:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <anWnzne4v83HxM1K@yuki.lan>
References: <20260807-rewrite_mremap_testing_suite-v2-0-1760ae8e3b8b@suse.com>
 <20260807-rewrite_mremap_testing_suite-v2-6-1760ae8e3b8b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v2-6-1760ae8e3b8b@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/6] mremap08: Extract test from mremap05
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/mremap/mremap08.c b/testcases/kernel/syscalls/mremap/mremap08.c
> new file mode 100644
> index 000000000..8d8e82d8b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mremap/mremap08.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Linux Test Project
> + */
> +
> +/*\
> + * Verify the behavior of the ``MREMAP_FIXED`` flag of :manpage:`mremap(2)`:
> + *
> + * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` can move a mapping to a new, free
> + *   address, preserving its content.
> + * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` unmaps a previously existing mapping at
> + *   the target address range and replaces it with the moved mapping.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/mman.h>
> +#include "tst_test.h"
> +
> +static int pagesize;
> +
> +static struct tcase {
> +	size_t old_pages;
> +	size_t new_pages;
> +	int flags;
> +	int free_dst;
> +	const char *msg;
> +} tcases[] = {
> +	{
> +		.old_pages = 1,
> +		.new_pages = 1,
> +		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
> +		.free_dst = 1,
> +		.msg = "move mapping to free address",
> +	},
> +	{
> +		.old_pages = 1,
> +		.new_pages = 1,
> +		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
> +		.free_dst = 0,
> +		.msg = "move mapping onto an occupied address",
> +	},
> +};
> +
> +static void *get_test_area(size_t size, int free_area)
> +{
> +	void *p;
> +
> +	p = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
> +		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +	if (free_area)
> +		SAFE_MUNMAP(p, size);
> +
> +	return p;
> +}
> +
> +static void setup(void)
> +{
> +	pagesize = getpagesize();
> +}
> +
> +static void fill_pattern(char *addr, size_t pages)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < pages; i++)
> +		addr[i * pagesize] = (char)(0x1 + i);
> +}
> +
> +static int check_pattern(const char *msg, char *addr, size_t pages)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < pages; i++) {
> +		char got = addr[i * pagesize];
> +		char exp = (char)(0x1 + i);
> +
> +		if (got != exp) {
> +			tst_res(TFAIL, "%s: page %zu content 0x%x, expected 0x%x",
> +				msg, i, (unsigned char)got, (unsigned char)exp);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	char *old_address;
> +	char *new_address;
> +	char *ret;
> +	size_t old_size = tc->old_pages * pagesize;
> +	size_t new_size = tc->new_pages * pagesize;
> +
> +	old_address = get_test_area(old_size, 0);
> +	new_address = get_test_area(new_size, tc->free_dst);
> +
> +	fill_pattern(old_address, tc->old_pages);
> +
> +	if (!tc->free_dst)
> +		*new_address = 0x7f;

This should be moved into check_patter()

> +	TESTPTR(mremap(old_address, old_size, new_size, tc->flags, new_address));
> +	ret = TST_RET_PTR;
> +
> +	if (ret == MAP_FAILED) {
> +		tst_res(TFAIL | TTERRNO, "%s failed", tc->msg);
> +		SAFE_MUNMAP(old_address, old_size);
> +		if (!tc->free_dst)
> +			SAFE_MUNMAP(new_address, new_size);
> +		return;
> +	}
> +
> +	if (ret != new_address)
> +		tst_res(TFAIL, "%s: ret %p, expected %p", tc->msg, ret, new_address);
> +	else if (check_pattern(tc->msg, ret, tc->new_pages) == 0)
> +		tst_res(TPASS, "%s", tc->msg);

This looks incomplete, we will not produce result if pattern was wrong.
It should be:

	if (ret != new_address)
		tst_res(TFAIL, ...);
	else if (check_pattern(...))
		tst_res(TFAIL, ...);
	else
		tst_res(TPASS, ...);


Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
