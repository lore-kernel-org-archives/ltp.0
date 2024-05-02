Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B341C4345F
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 10:30:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90F493CC23A
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 12:30:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E09B3CBF9D
 for <ltp@lists.linux.it>; Thu,  2 May 2024 12:30:14 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2C3EB1A02365
 for <ltp@lists.linux.it>; Thu,  2 May 2024 12:30:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 678861FBF0;
 Thu,  2 May 2024 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714645812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azsVRAiQd31YkXr4wr/tErBmZjoN/uBGIYY3+mB+oZY=;
 b=uawLzeSoC10NKEyd9fza9JKxe9aR5QgOXjBce3ika5mKFDIvweSyCeMDtyjz/trR3MvWhV
 V9YvdFhOyLukvdWTvUcMOYc3tZLWnoDz6njT3voJnB8nS8QyT0QqXoZzc3hOvLJ9yBwyBV
 0TF0kUW0HNRA0adFIlJ0RD+j8N0dmAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714645812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azsVRAiQd31YkXr4wr/tErBmZjoN/uBGIYY3+mB+oZY=;
 b=njve7GofRE3GjJSKoqEBQG+JHH+2yHmEDZDJJIcZBbKASIVG24cEbcwqYZc8ZL4Ihpd2JP
 6Kue1hSSmqM4x0CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uawLzeSo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=njve7Gof
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714645812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azsVRAiQd31YkXr4wr/tErBmZjoN/uBGIYY3+mB+oZY=;
 b=uawLzeSoC10NKEyd9fza9JKxe9aR5QgOXjBce3ika5mKFDIvweSyCeMDtyjz/trR3MvWhV
 V9YvdFhOyLukvdWTvUcMOYc3tZLWnoDz6njT3voJnB8nS8QyT0QqXoZzc3hOvLJ9yBwyBV
 0TF0kUW0HNRA0adFIlJ0RD+j8N0dmAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714645812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azsVRAiQd31YkXr4wr/tErBmZjoN/uBGIYY3+mB+oZY=;
 b=njve7GofRE3GjJSKoqEBQG+JHH+2yHmEDZDJJIcZBbKASIVG24cEbcwqYZc8ZL4Ihpd2JP
 6Kue1hSSmqM4x0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57FDA1386E;
 Thu,  2 May 2024 10:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SrmPFDRrM2ZWEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 02 May 2024 10:30:12 +0000
Date: Thu, 2 May 2024 12:29:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZjNrApqMiZ9bj0au@yuki>
References: <20240430052845.31039-1-liwang@redhat.com>
 <20240430052845.31039-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240430052845.31039-2-liwang@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 678861FBF0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] kallsyms01: Utilize ksymbol table for
 unauthorized address access
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
Cc: Rafael Aquini <aquini@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Any reason this is GPL-2.0-only and not 2.0-or-later?

> +/*
> + * Copyright (C) 2024 Red Hat, Inc.
> + */
> +
> +/*\
> + * [Description]
> + *
> + *  Utilize kernel's symbol table for unauthorized address access.
> + *
> + *  Access the system symbols with root permission to test whether it's
> + *  possible to read and write the memory addresses of kernel-space
> + *  from user-space. This helps in identifying potential vulnerabilities
> + *  where user-space processes can inappropriately access kernel memory.
> + *
> + * Steps:
> + *  1. Start a process that reads all symbols and their addresses from
> + *     '/proc/kallsyms' and stores them in a linked list.
> + *
> + *  2. Attempt to write to each kernel address found in the linked list.
> + *     The expectation is that each attempt will fail with a SIGSEGV
> + *     (segmentation fault), indicating that the user-space process
> + *     cannot write to kernel memory.
> + *
> + *  3. Handle each SIGSEGV using a signal handler that sets a flag and
> + *     long jumps out of the faulting context.
> + *
> + *  4. If any write operation does not result in a SIGSEGV, log this as
> + *     a potential security vulnerability.
> + *
> + *  5. Observe and log the behavior and any system responses to these
> + *     unauthorized access attempts.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <assert.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +
> +struct kallsym {
> +	unsigned long addr;
> +	char type;
> +	char name[128];
> +};
> +
> +static struct kallsym *sym_table;
> +static unsigned int nr_symbols;
> +static sigjmp_buf jmpbuf;
> +volatile sig_atomic_t segv_caught = 0;
> +
> +static void segv_handler(int sig)
> +{
> +	if (sig == SIGSEGV)
> +		segv_caught++;
> +	else
> +		tst_res(TFAIL, "Unexpected signal %s", strsignal(sig));
> +
> +	siglongjmp(jmpbuf, 1);
> +}
> +
> +static unsigned int read_kallsyms(struct kallsym *table, unsigned int table_size)
> +{
> +	char *line = NULL;
> +	size_t len = 0;
> +	unsigned int nr_syms = 0;
> +	FILE *stream = SAFE_FOPEN("/proc/kallsyms", "r");
> +
> +	while (getline(&line, &len, stream) != -1) {
> +
> +		if (table && nr_syms < table_size) {
> +			sscanf(line, "%lx %c %s",
> +					&table[nr_syms].addr,
> +					&table[nr_syms].type,
> +					table[nr_syms].name);
> +		}
> +
> +		nr_syms++;
> +	}
> +
> +	SAFE_FCLOSE(stream);
> +
> +	return nr_syms;
> +}
> +
> +static void setup(void)
> +{
> +	nr_symbols = read_kallsyms(NULL, 0);
> +	sym_table = SAFE_CALLOC(nr_symbols, sizeof(*sym_table));
> +	unsigned int read_symbols = read_kallsyms(sym_table, nr_symbols);
> +
> +	if (nr_symbols != read_symbols)
> +		tst_res(TWARN, "/proc/kallsyms changed size!?");
> +}
> +
> +static void access_ksymbols_address(struct kallsym *table)
> +{
> +	tst_res(TDEBUG, "Access kernel addr: 0x%lx (%c) (%s)",
> +				table->addr, table->type, table->name);
> +
> +	if (sigsetjmp(jmpbuf, 1) == 0) {
> +		*(volatile unsigned long *)table->addr = 0;
> +
> +		tst_res(TFAIL, "Successfully accessed kernel addr 0x%lx (%c) (%s)",
> +				table->addr, table->type, table->name);
> +	}
> +}
> +
> +static void test_access_kernel_address(void)
> +{
> +	struct sigaction sa;
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler = segv_handler;
> +	sigaction(SIGSEGV, &sa, NULL);

We can move the sigaction to the test setup.

> +	for (unsigned int i = 0; i < nr_symbols; i++)
> +		access_ksymbols_address(&sym_table[i]);

And we have to set the segv_caught to 0 before this loop, otherwise the
test does not work with -i 2

> +	if (segv_caught == (sig_atomic_t)nr_symbols)
> +		tst_res(TPASS, "Caught %d times SIGSEGV in access ksymbols addr", segv_caught);

And also in a case that we got wrong number on segfaults this does not
produce any results. I guess that we need to do:

	if (...)
		tst_res(TPASS, "...");
	else
		tst_res(TFAIL, "Caught %d SIGSEGV expected %d", ...);


> +}
> +
> +static void cleanup(void)
> +{
> +	if (sym_table)
> +		free(sym_table);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.max_runtime = 60,
> +	.test_all = test_access_kernel_address,
> +};
> -- 
> 2.40.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
