Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD88C4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 10:01:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80DEE3D03ED
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 12:01:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EF953C0607
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 12:01:12 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B3AE8201DDB
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 12:01:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6F2620474;
 Mon, 29 Apr 2024 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714384869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wn/htkwAeOExjbzsWUh9agn5+tAEQlrtm0M57Vnq2Js=;
 b=QWAiGK701+rcSOpIXq0eV1xaCbz/YzmM5FztUbbgUpVJwhALre0lXlW25gBzSlrqTN77Pa
 Sp2FlPcc2X5ug8HjQv3CXtJhjVAkCGq49NT91Qp2wkiu3c6bqiCWninntvrcGdN4SEtbxp
 c6eL37DpXPZ2Ih8pzAr7qpEpQbC1+Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714384869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wn/htkwAeOExjbzsWUh9agn5+tAEQlrtm0M57Vnq2Js=;
 b=JxLwdyX4q8MgQ/Yk83TBXAGWrewjdhaFiZu6OqjxAeCHf3VGf5VjNRf2krDvlngVDqP5lu
 p3/PrzJJbEl1TiCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QWAiGK70;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JxLwdyX4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714384869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wn/htkwAeOExjbzsWUh9agn5+tAEQlrtm0M57Vnq2Js=;
 b=QWAiGK701+rcSOpIXq0eV1xaCbz/YzmM5FztUbbgUpVJwhALre0lXlW25gBzSlrqTN77Pa
 Sp2FlPcc2X5ug8HjQv3CXtJhjVAkCGq49NT91Qp2wkiu3c6bqiCWninntvrcGdN4SEtbxp
 c6eL37DpXPZ2Ih8pzAr7qpEpQbC1+Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714384869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wn/htkwAeOExjbzsWUh9agn5+tAEQlrtm0M57Vnq2Js=;
 b=JxLwdyX4q8MgQ/Yk83TBXAGWrewjdhaFiZu6OqjxAeCHf3VGf5VjNRf2krDvlngVDqP5lu
 p3/PrzJJbEl1TiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B60ED139DE;
 Mon, 29 Apr 2024 10:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pdSFK+VvL2bLKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Apr 2024 10:01:09 +0000
Date: Mon, 29 Apr 2024 12:00:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Filippo Storniolo <fstornio@redhat.com>
Message-ID: <Zi9vsoAzBnKi6aLh@yuki>
References: <20240426134802.2607150-1-fstornio@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240426134802.2607150-1-fstornio@redhat.com>
X-Spamd-Result: default: False [-4.00 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C6F2620474
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mlock05: add mlock test for locking and
 pre-faulting of memory
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
> + * Copyright Red Hat
> + * Author: Filippo Storniolo <fstornio@redhat.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify mlock() causes pre-faulting of PTEs and prevent memory to be swapped out.
> + *
> + * Checks the variables VmRSS and VmLck in /proc/$pid/status after the
> + * mlock syscall:
> + * - VmRSS size should be at least as big as the memory allocation
> + * - VmLck size should be equal to the size of the memory allocation
> + */
> +
> +#include "tst_test.h"
> +
> +#define MMAPLEN			(1UL<<20)
> +
> +static void verify_mlock(void)
> +{
> +	unsigned long VmRSS_before;
> +	unsigned long VmRSS_after;
> +	unsigned long VmLck_before;
> +	unsigned long VmLck_after;
> +	unsigned long VmRSS;
> +	unsigned long VmLck;
> +	char *buf;
> +
> +	buf = SAFE_MMAP(NULL, MMAPLEN, PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmRSS: %lu", &VmRSS_before);
> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &VmLck_before);
> +
> +	SAFE_MLOCK(buf, MMAPLEN);
> +
> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmRSS: %lu", &VmRSS_after);
> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &VmLck_after);
> +
> +	VmRSS = VmRSS_after - VmRSS_before;
> +	VmLck = VmLck_after - VmLck_before;
> +
> +	// Convertion from KiB to B
> +	VmRSS *= 1024;
> +	VmLck *= 1024;
> +
> +	if (VmRSS >= MMAPLEN) {
> +		tst_res(TPASS, "Pre-allocation functionality of mlock() successful");
> +	} else {
> +		tst_brk(TBROK, "Expected pre-allocation of %lu bytes, "
> +					"get %lu pre-allocated", MMAPLEN, VmRSS);

This is TFAIL. TBROK is used when a test is broken because a test setup
has failed, not when test a assertion wasn't true.

Also simplify this to TST_EXP_EXPR(VmRSS >= MMAPLEN);

> +	}
> +
> +	if (VmLck == MMAPLEN) {
> +		tst_res(TPASS, "Locking functionality of mlock() successful");
> +	} else {
> +		tst_brk(TBROK, "Expected locking of %lu bytes, "
> +					"get %lu locked", MMAPLEN, VmLck);
> +	}

This could be simplified to a single TST_EXP_EQ_LU(VmLCK, MMAPLEN);

> +	SAFE_MUNLOCK(buf, MMAPLEN);
> +	SAFE_MUNMAP(buf, MMAPLEN);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_mlock,
> +};

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
