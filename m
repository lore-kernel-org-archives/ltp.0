Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47482C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB3DD3E920F
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 10:21:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 203983E53C2
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:20:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 459D3200776
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:20:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5940F21B5F;
 Fri, 11 Sep 2026 08:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789114843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYfZ7bq1K04UPDWNBo8keYq9W2Rg2vvD0vRFZwBz04k=;
 b=lQ6ba2uPHNzBEYRP++lWJQKd3AdOAF0oEDUpBUyuJ1oONnUFH0sHtb7ekirl4notkg6A7y
 nNwtzZXn24pQcvYb2o/hkLQpHcRPVl+F68esiVAXzbh/1uxWM9vXoli8LRRzzFYxaQrshA
 nfBnAFPrx/dZoAEmAn29abg44OTBZMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789114843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYfZ7bq1K04UPDWNBo8keYq9W2Rg2vvD0vRFZwBz04k=;
 b=S/pH9ds5p/QnDiQOpzDvUFxYVHsRDLMggL18xLrKvXCmypqYC5CCZReyNUt86so2cQXwvO
 ZEq1XaclMj9btPBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Lb98IvdS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iFMvZrev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789114839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYfZ7bq1K04UPDWNBo8keYq9W2Rg2vvD0vRFZwBz04k=;
 b=Lb98IvdScX0r7GrzvapmZUVTL0akmXOBfK+ii2pk1DsAxCLjKt9h5fSySQkx4YsDWvgpd9
 3QFpkCCnIeYfRiSqEsyk3IZjo0gBWrxygasB1qSgzStiXAd8s8VvMjuKG4Zb1GdibOfJN2
 SgLpthHqD23hmIN8H4NXx7P8k6cse/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789114839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYfZ7bq1K04UPDWNBo8keYq9W2Rg2vvD0vRFZwBz04k=;
 b=iFMvZrevIp/F6sK13Ni7fg4FTMCSSvx85pHvC2LVYiCQZhJVfqdaHXm+KELZFNQO3la/oG
 Sw3y86qNP7HOunCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20CEF136ED;
 Fri, 11 Sep 2026 08:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DNT9B9e5o2r0fAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 08:20:39 +0000
Date: Fri, 11 Sep 2026 10:20:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqO53U7noZHaIDj1@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-7-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-7-43b78b15ef9f@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5940F21B5F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email,yuki.lan:mid,linux.it:url];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 07/33] keyctl15: Test KEYCTL_GET_SECURITY label
 retrieval
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
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl15.c b/testcases/kernel/syscalls/keyctl/keyctl15.c
> new file mode 100644
> index 000000000..c281e9c69
> --- /dev/null
> +++ b/testcases/kernel/syscalls/keyctl/keyctl15.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test ``KEYCTL_GET_SECURITY`` label retrieval of :manpage:`keyctl(2)`.
> + *
> + * ``KEYCTL_GET_SECURITY`` reads the LSM security label of a key.
> + * When no label is set (no LSM enabled or the LSM does not label keys)
> + * the operation returns 1 and an empty string.
> + *
> + * [Algorithm]
> + *
> + * - read the label of a valid key into a large buffer, verify the return
> + *   value is at least 1 and an empty string is returned when no label is set
> + */
> +
> +#include "keyctl_common.h"
> +
> +#define KEY_DESC	"ltpkeyctl15"
> +#define PAYLOAD		"payload"
> +#define BUF_SIZE	128
> +
> +static key_serial_t key;
> +static char buf[BUF_SIZE];
> +
> +static void setup(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
> +
> +	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD),
> +			   KEY_SPEC_PROCESS_KEYRING);
> +	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
> +}
> +
> +static void run(void)
> +{
> +	memset(buf, 0, sizeof(buf));
> +
> +	TEST(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "KEYCTL_GET_SECURITY failed");
> +
TST_EXP_POSITIVE()?

> +	if (TST_RET < 1) {
> +		tst_res(TFAIL, "returned %ld, expected at least 1", TST_RET);
> +		return;
> +	}
> +	if (TST_RET == 1) {
> +		if (buf[0] != '\0') {
> +			tst_res(TFAIL, "empty label is not NUL terminated");
> +			return;
> +		}
> +
> +		tst_res(TPASS, "no label set, empty string returned");
> +		return;
> +	}

Is the string supposed to be null terminated? Shouldn't we just check
that the is null at the end regardless the length (we fail the test if <
1 either way)?

> +	tst_res(TPASS, "security label returned, full length %ld", TST_RET);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
