Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CB1E77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 12:54:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E7DD3C1BCE
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 13:54:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E17D3C0325
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 13:53:59 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B20A81182560
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 13:53:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 989DE21133;
 Wed,  8 Jan 2025 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736340837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edzowMDAB5qmLu4ip6aKIb7qG+PytuB2Xg6ijfqjEpI=;
 b=A3TwP69E5ZVApQ/IJbyLN9cXcv8BCM2mR0dxg5+qPv70Yu4cyK0Dkla0C+v82FnDzI4PRs
 UjAwJi27raUAvDr7N8S7zNBxATBan0HoaEEua7mIpaWaR56iKbaAwNtzqy3UPb2lfD0aZx
 S//gTLz5rNTtjGV/QecONefMEynf43g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736340837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edzowMDAB5qmLu4ip6aKIb7qG+PytuB2Xg6ijfqjEpI=;
 b=rrHV6GTgEcrIcV5eEWUEE2/vYzWTuZJ9tyyh6b2spoGoTTUhSL6g3a8W2zx/1/HINsju9x
 liQcpe+4A8m8UEAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A3TwP69E;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rrHV6GTg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736340837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edzowMDAB5qmLu4ip6aKIb7qG+PytuB2Xg6ijfqjEpI=;
 b=A3TwP69E5ZVApQ/IJbyLN9cXcv8BCM2mR0dxg5+qPv70Yu4cyK0Dkla0C+v82FnDzI4PRs
 UjAwJi27raUAvDr7N8S7zNBxATBan0HoaEEua7mIpaWaR56iKbaAwNtzqy3UPb2lfD0aZx
 S//gTLz5rNTtjGV/QecONefMEynf43g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736340837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edzowMDAB5qmLu4ip6aKIb7qG+PytuB2Xg6ijfqjEpI=;
 b=rrHV6GTgEcrIcV5eEWUEE2/vYzWTuZJ9tyyh6b2spoGoTTUhSL6g3a8W2zx/1/HINsju9x
 liQcpe+4A8m8UEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 899DD137DA;
 Wed,  8 Jan 2025 12:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UmmHIGV1fmdxKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jan 2025 12:53:57 +0000
Date: Wed, 8 Jan 2025 13:58:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z352WrLF5bP-DgA2@rei>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-3-e293a8d99cf6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112-lsm-v1-3-e293a8d99cf6@suse.com>
X-Rspamd-Queue-Id: 989DE21133
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/7] Add lsm_get_self_attr02 test
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

On Tue, Nov 12, 2024 at 08:15:34AM +0100, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Verify that lsm_get_self_attr syscall is acting correctly when ctx is NULL.
> The syscall can behave in different ways according to the current system
> status:
> 
> - if any LSM is running inside the system, the syscall will pass and it will
>   provide a size as big as the attribute
> - if no LSM(s) are running inside the system, the syscall will fail with -1
>   return code
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                   |  1 +
>  testcases/kernel/syscalls/lsm/.gitignore           |  2 +
>  .../kernel/syscalls/lsm/lsm_get_self_attr02.c      | 55 ++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index d59faf08a3f36b5f64d56952f69641191c70bf33..b3350af4db6d00cf86f621b5efee5d603af920f0 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -757,6 +757,7 @@ lseek07 lseek07
>  lseek11 lseek11
>  
>  lsm_get_self_attr01 lsm_get_self_attr01
> +lsm_get_self_attr02 lsm_get_self_attr02
>  
>  lstat01 lstat01
>  lstat01_64 lstat01_64
> diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
> new file mode 100644
> index 0000000000000000000000000000000000000000..9f7c9b00b026a377f1b36f483ac2c1a0adba6249
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lsm/.gitignore
> @@ -0,0 +1,2 @@
> +lsm_get_self_attr01
> +lsm_get_self_attr02
> diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ce10bc2881fa8ac56a1e1da01631cfed8857eb08
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that lsm_get_self_attr syscall is acting correctly when ctx is NULL.
> + * The syscall can behave in different ways according to the current system
> + * status:
> + *
> + * - if any LSM is running inside the system, the syscall will pass and it will
> + *   provide a size as big as the attribute
> + * - if no LSM(s) are running inside the system, the syscall will fail with -1
> + *   return code
> + */
> +#include "lsm_common.h"
> +
> +static uint32_t page_size;
> +static uint32_t lsm_count;
> +
> +static void run(void)
> +{
> +	uint32_t size = page_size;
> +
> +	if (lsm_count) {
> +		TST_EXP_EXPR(lsm_get_self_attr(
> +			LSM_ATTR_CURRENT, NULL, &size, 0) >= 1);

TST_EXP_POSSITIVE()?

Also I'm a bit confused here, where is the size returned as the return
value from the syscall() or is the size argument modified?

> +		TST_EXP_EXPR(size > 1);
> +	} else {
> +		TST_EXP_EQ_LI(lsm_get_self_attr(
> +			LSM_ATTR_CURRENT, NULL, &size, 0), -1);

TST_EXP_FAIL()?

> +	}
> +}
> +
> +static void setup(void)
> +{
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +
> +	if (verify_enabled_lsm("selinux"))
> +		lsm_count++;
> +
> +	if (verify_enabled_lsm("apparmor"))
> +		lsm_count++;
> +
> +	if (verify_enabled_lsm("smack"))
> +		lsm_count++;

Shouldn't we just look at the /sys/kernel/security/lsm file and if it
exists and it's not empty there is a lsm on the system and the syscall
will not fail in that case?

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.min_kver = "6.8",
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
