Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053ECC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:49:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFEA83E9678
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 14:49:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 322AD3E56A8
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 14:49:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84A5D1000368
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 14:49:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AA5B761AF;
 Tue, 14 Jul 2026 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784033345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iyLiq83zHAWAvWpiAl3Ywf/Nu15wr85wFvmNDnVW+jA=;
 b=rBGgGIDGLF/Nq2VLL6zW4E3Ks4axjGKTeSG3NNOa6z6WVE/s7J+ene/qtwi/DWY0t2qQ9O
 vW2NTXnM3hk1sK/dpsDCqtRdSwVIjU1xzJqH6hj5N0Tl0/OQTiGRfhjn9pKMcuuNYKXu5S
 i+V8pm4bDMuIFy3dEIZuBRIwOSu5wwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784033345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iyLiq83zHAWAvWpiAl3Ywf/Nu15wr85wFvmNDnVW+jA=;
 b=bF1lnfcqA183bX6xJgfxRPew4gT/OFfWg5a/CR0h0QpkKTe8baBX/p7cQXO0rzG4oIgmbE
 4Z1kw8Ozk/cZ2yCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784033345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iyLiq83zHAWAvWpiAl3Ywf/Nu15wr85wFvmNDnVW+jA=;
 b=rBGgGIDGLF/Nq2VLL6zW4E3Ks4axjGKTeSG3NNOa6z6WVE/s7J+ene/qtwi/DWY0t2qQ9O
 vW2NTXnM3hk1sK/dpsDCqtRdSwVIjU1xzJqH6hj5N0Tl0/OQTiGRfhjn9pKMcuuNYKXu5S
 i+V8pm4bDMuIFy3dEIZuBRIwOSu5wwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784033345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iyLiq83zHAWAvWpiAl3Ywf/Nu15wr85wFvmNDnVW+jA=;
 b=bF1lnfcqA183bX6xJgfxRPew4gT/OFfWg5a/CR0h0QpkKTe8baBX/p7cQXO0rzG4oIgmbE
 4Z1kw8Ozk/cZ2yCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8750C779AE;
 Tue, 14 Jul 2026 12:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tznkH0EwVmo3NgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 14 Jul 2026 12:49:05 +0000
Date: Tue, 14 Jul 2026 14:48:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <alYwNHy3AP34FJPR@yuki.lan>
References: <20260714-syscall_invalid_nr-v2-1-b94a8f60f112@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260714-syscall_invalid_nr-v2-1-b94a8f60f112@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,yuki.lan:mid];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscall02: test invalid syscall number -1
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
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a021c79da49d4157c33187caed2dd3f0483759e0..8a777e61da1af59ba694e0bc5b5d92bb1d63754a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1678,6 +1678,7 @@ sync_file_range01 sync_file_range01
>  sync_file_range02 sync_file_range02
>  
>  syscall01 syscall01
> +syscall02 syscall02
>  
>  sysconf01 sysconf01
>  
> diff --git a/testcases/kernel/syscalls/syscall/.gitignore b/testcases/kernel/syscalls/syscall/.gitignore
> index 74a081e40cb564e874e0f81478d3d1a0e95b6df4..fed1d81079450a7442023447285cd112924f7a10 100644
> --- a/testcases/kernel/syscalls/syscall/.gitignore
> +++ b/testcases/kernel/syscalls/syscall/.gitignore
> @@ -1 +1,2 @@
>  /syscall01
> +/syscall02
> diff --git a/testcases/kernel/syscalls/syscall/syscall02.c b/testcases/kernel/syscalls/syscall/syscall02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2fefcb17c763813653a6644759c2a035bee2c604
> --- /dev/null
> +++ b/testcases/kernel/syscalls/syscall/syscall02.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that a raw :manpage:`syscall(2)` with the invalid system call
> + * number -1 fails with ENOSYS.
> + *
> + * The behavior of number -1 is architecture specific, so the test only runs on
> + * the architectures where it has been verified against the kernel entry code.
> + */
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	TST_EXP_FAIL2(syscall(-1), ENOSYS, "invalid syscall number -1");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.supported_archs = (const char *const []) {
> +		"x86_64",
> +		"aarch64",
> +		NULL
> +	},
> +};

I do not think that there is an architecture that has a valid syscall
mapped to -1. I do not think that we need to restrict the architecture
here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
