Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC36EEAA50
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 15:13:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBF7F3CE72A
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 17:13:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94EBD3CE70C
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 17:13:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7601E20EB44
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 17:13:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43BB52185F;
 Thu, 14 Sep 2023 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694704409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnmpqAE13FIdWllXn/BcpT+XciRXwYk63Zh9VnWclQE=;
 b=XtQ+bWPzco8+lujx+Z7kK3kIwAdMJo6SCHeEKzuBGOAi9HmzQZqMZMGDL12LrEAAswf2L+
 S0+onDaefUYqMnzSDMto++7QPvx2hZpl+qXWhi5vCCybPUnsCbXOvsb9ntApdl+O96Wl5p
 YwSf/AzAtm11DyKxu8YEU52laQnK9K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694704409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnmpqAE13FIdWllXn/BcpT+XciRXwYk63Zh9VnWclQE=;
 b=eYGVI2a8JIkJcBlgI7E8k+MSKy/6nazF6n56/1k/JnAvlInWH5K2tQN9tpXZePmk6w3KF0
 wIVSu5vlmQAmlwDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 303E113580;
 Thu, 14 Sep 2023 15:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5GwNCxkjA2XLDAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 14 Sep 2023 15:13:29 +0000
Date: Thu, 14 Sep 2023 17:14:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZQMjRzonu8ECGhpe@yuki>
References: <ZPHY1CtYogkqUHzQ@yuki>
 <20230905095411.6704-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230905095411.6704-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap04: Validate mapping perms in
 /proc/self/maps
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2001
> + *  07/2001 Ported by Wayne Boyer
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that, after a successful mmap() call, permission bits of the new
> + * mapping in /proc/pid/maps file matches the prot and flags arguments in
> + * mmap() call.
> + */
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +
> +#define MMAPSIZE 1024
> +static char *addr;
> +
> +static struct tcase {
> +	int prot;
> +	int flags;
> +	char *exp_perms;
> +} tcases[] = {
> +	{PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, "---p"},
> +	{PROT_NONE, MAP_ANONYMOUS | MAP_SHARED, "---s"},
> +	{PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, "r--p"},
> +	{PROT_READ, MAP_ANONYMOUS | MAP_SHARED, "r--s"},
> +	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "-w-p"},
> +	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "-w-s"},
> +	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "rw-p"},
> +	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "rw-s"},
> +	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "r-xp"},
> +	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "r-xs"},
> +	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "-wxp"},
> +	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "-wxs"},
> +	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "rwxp"},
> +	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "rwxs"}
> +};
> +
> +static void get_map_perms(char *addr_str, char *perms)
> +{
> +	FILE *file;
> +	char line[BUFSIZ];
> +
> +	file = SAFE_FOPEN("/proc/self/maps", "r");
> +
> +	while (fgets(line, sizeof(line), file)) {
> +		if (strstr(line, addr_str) != NULL) {
> +			if (sscanf(line, "%*x-%*x %s", perms) != 1)
> +				tst_brk(TBROK, "failed to find permission string in %s", line);
> +			break;
> +		}
> +	}
> +
> +	SAFE_FCLOSE(file);
> +	file = NULL;

No need to set the file to NULL here, it's on stack and will perish once
we leave this function.

Rather than that we should check that the perms was actually set at this
point. It's unlikely that it will be missing, but we are writing kernel
tests so we should really make sure we actually found it.

Also I do wonder if we can use SAFE_FILE_LINES_SCANF() here that would
sove the the problem since it will TBROK if the line wasn't found. For
that we would have to snprintf() the fmt string with the address so that
we pass something as "5560620ce000-%-x %s" to the scanf.

> +}
> +
> +static void run(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +	char addr_str[20];
> +	char perms[8];
> +
> +	addr = SAFE_MMAP(NULL, MMAPSIZE, tc->prot, tc->flags, -1, 0);
> +
> +	sprintf(addr_str, "%p", addr);
> +	if (sscanf(addr_str, "0x%s", addr_str) != 1)
> +		tst_brk(TBROK, "failed to find address string");

I guess that casting the address to (uintptr_t) and printing it with
"%"PRIxPTR is cleaner solution.

> +	get_map_perms(addr_str, perms);
> +
> +	if (!strcmp(perms, tc->exp_perms))
> +		tst_res(TPASS, "mapping permissions in /proc matched: %s", perms);
> +	else
> +		tst_res(TFAIL, "mapping permissions in /proc mismatched,"
> +						" expected: %s, found: %s",
> +						tc->exp_perms, perms);
> +
> +	SAFE_MUNMAP(addr, MMAPSIZE);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
