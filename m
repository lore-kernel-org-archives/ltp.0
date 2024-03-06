Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2547DC5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 11:25:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74B663CE9EB
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 12:25:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EFED3C3320
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 12:25:05 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2BCB5617624
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 12:25:04 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BFEC3FF7C;
 Wed,  6 Mar 2024 11:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709724302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61Xbn1bYRtkmKxTOc3emWDRIJbpfxIwBCt+Nld2vRFM=;
 b=Q48VJnx7KJAFOm9BnN8ADkZeiwB8bBv9JsIvLmRd0jWxuALoCbtnw0V4mTyZMZesINtRFH
 GGJkCwjsxYF1fwHzafetb5RQZ8HyHN1KUnSqUzJjBDVL6Rcc/wCLIaBvkm8zm4/8w3Lb8K
 eo+4nIR6V+oaQMH/nfQA3f/O/f6FM3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709724302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61Xbn1bYRtkmKxTOc3emWDRIJbpfxIwBCt+Nld2vRFM=;
 b=2AX1ULV1/2dq7FomlTsk079eB24O7tYXhEC0CIT0tHu6/QPFBIGz2WC1Dvm2edsaviiOY3
 RZZhfkizHUZBKbCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709724302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61Xbn1bYRtkmKxTOc3emWDRIJbpfxIwBCt+Nld2vRFM=;
 b=Q48VJnx7KJAFOm9BnN8ADkZeiwB8bBv9JsIvLmRd0jWxuALoCbtnw0V4mTyZMZesINtRFH
 GGJkCwjsxYF1fwHzafetb5RQZ8HyHN1KUnSqUzJjBDVL6Rcc/wCLIaBvkm8zm4/8w3Lb8K
 eo+4nIR6V+oaQMH/nfQA3f/O/f6FM3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709724302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61Xbn1bYRtkmKxTOc3emWDRIJbpfxIwBCt+Nld2vRFM=;
 b=2AX1ULV1/2dq7FomlTsk079eB24O7tYXhEC0CIT0tHu6/QPFBIGz2WC1Dvm2edsaviiOY3
 RZZhfkizHUZBKbCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BFDAE13A79;
 Wed,  6 Mar 2024 11:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 0HvPLY1S6GVQQAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 06 Mar 2024 11:25:01 +0000
Date: Wed, 6 Mar 2024 12:25:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240306112500.GD558578@pevik>
References: <20240131150136.4082-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240131150136.4082-1-akumar@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/mmap14: Rewrite test using new LTP API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
...
> -/*
> - * Test Description:
> - *  Verify MAP_LOCKED works fine.
> - *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
> +/*\
> + * [Description]
>   *
> - * Expected Result:
> - *  mmap() should succeed returning the address of the mapped region,
> - *  and this region should be locked into memory.
> + * Verify that, mmap() call with MAP_LOCKED flag successfully locks
> + * the mapped pages into memory.
>   */
> -#include <stdio.h>
> -#include <sys/mman.h>

> -#include "test.h"
> +#include <stdio.h>
> +#include "tst_test.h"

> -#define TEMPFILE        "mmapfile"
> -#define MMAPSIZE        (1UL<<20)
> +#define MMAPSIZE        (1UL<<22)
I wonder why it was needed to increase the map size.
Anyway, even with 1UL<<20 it's too high for old SLES 15-SP1.

ulimit -l prints 64 (kB => 65536) ...

> +static void setup(void)
>  {
> +	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &rlim);
...
> +	if (((sz_before * 1024) + MMAPSIZE) > rlim.rlim_cur)
> +		tst_brk(TCONF, "Trying to exceed RLIMIT_MEMLOCK limit");
... therefore it TCONF here in the setup function.

But disabling this check it runs OK. I would expect we would get EAGAIN
(according to man "The file has been locked, or too much memory has been
locked") or MAP_FAILED or ENOMEM (but man says: "This implementation will try to
populate (prefault) the whole range but the mmap() call doesn't fail with ENOMEM
if this fails.")

Just experimenting, to increase to 1UL<<40 I get ENOMEM, doing really too huge
1UL<<200 I get EINVAL.

Therefore I would say the check in this way is wrong.
Or, could we just run SAFE_SETRLIMIT(RLIMIT_MEMLOCK, ...) in case of low limit
and increase it in cleanup?

>  }

>  void getvmlck(unsigned int *lock_sz)
>  {
> -	int ret;
>  	char line[LINELEN];
> -	FILE *fstatus = NULL;
> +	FILE *fp = NULL;

> -	fstatus = fopen("/proc/self/status", "r");
> -	if (fstatus == NULL)
> -		tst_brkm(TFAIL | TERRNO, NULL, "Open dev status failed");
> +	fp = fopen("/proc/self/status", "r");
SAFE_FOPEN() (requires #include "tst_safe_stdio.h") and 2 lines below aren't
needed.

> +	if (fp == NULL)
> +		tst_brk(TFAIL | TERRNO, "could not open status file");

> -	while (fgets(line, LINELEN, fstatus) != NULL)
> +	while (fgets(line, LINELEN, fp) != NULL) {
>  		if (strstr(line, "VmLck") != NULL)
>  			break;
> +	}

> -	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
> -	if (ret != 1)
> -		tst_brkm(TFAIL | TERRNO, NULL, "Get lock size failed");
> +	if (sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz) != 1)
> +		tst_brk(TFAIL | TERRNO, "Getting locked memory size failed");

I would say this should be tst_brk(TFAIL | TERRNO) (it's not directly related to
the testing, more to the preparation). Also I hope Andrea Manzini will add his
first easyhack for SAFE_SSCANF() and he will use it :).

The rest LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
