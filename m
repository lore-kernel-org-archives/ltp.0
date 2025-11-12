Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0170CCCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 09:59:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B0D73CF721
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 10:59:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 916D93C9ACB
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 10:59:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D56E06002FD
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 10:59:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8ED52219FE;
 Wed, 12 Nov 2025 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762941563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cY1s7MBSauwLUVz+K+nmt0wFY113P+E8YJKC1MIYrV0=;
 b=1325kA2x/OcGtRvHzIZX6CdriqmSmE7jgtoQ6NVn9mSKgmGVppX9luo0XdF9ZsVvBcG3uU
 Inzz2QdKM5RJZ0BFdUIgPQRSmS0L/HEQw3i22GxhiqNJ49LAeRHXFofGWF0hgoljN6CJGC
 5QgcwfU2mo67geS3pL8+hzHeY+HnJ/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762941563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cY1s7MBSauwLUVz+K+nmt0wFY113P+E8YJKC1MIYrV0=;
 b=R5/YNHk1CM9BLgdG4hMfRhdVl/fsackcpqHhrgz6tzEO/V7UHspgiTsxAZHNxZ41hy2lKd
 00EF1KITlibRURCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762941562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cY1s7MBSauwLUVz+K+nmt0wFY113P+E8YJKC1MIYrV0=;
 b=IEHBcgsnGbuvNEHOKKzhk4ezjju147SeS9q5N6DJ1ECIQ3uNNo/1LbxNCq/1+fmIgTNJ6x
 yg3bN5RIwztQdKnINpQhDCr/fN4EmksqFYwGxsf+SkUnlHKtXHzlc4i8Nyd6CAds9bWIjM
 AUX5iZejWWDxRl+vxw7hK/C2j7GE9eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762941562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cY1s7MBSauwLUVz+K+nmt0wFY113P+E8YJKC1MIYrV0=;
 b=0qb42OqxtrgJceY8il4yBLTPhHei1NOdw4QuCo6PB+56GkysKLLN2YMWWfjjiamtY8H4cR
 zIhqnAPH6+eNTNCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75C6B3EA61;
 Wed, 12 Nov 2025 09:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id teycG3paFGmDHwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Nov 2025 09:59:22 +0000
Date: Wed, 12 Nov 2025 11:00:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Stephen Bertram <sbertram@redhat.com>
Message-ID: <aRRaq8hImNwhDAcL@yuki.lan>
References: <20251111153453.547195-1-sbertram@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251111153453.547195-1-sbertram@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Confirming EPERM is returned when
 CAP_SYS_ADMIN is removed from clone3. Signed-off-by: Stephen Bertram
 <sbertram@redhat.com>
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
First of all the patch description shouldn't be on a single line since
the first line ends up in the email subject. There should be newlines
between the subject, patch description and the signed-off-by.

> ---
>  runtest/syscalls                            |  1 +
>  testcases/kernel/syscalls/clone3/.gitignore |  1 +
>  testcases/kernel/syscalls/clone3/clone304.c | 63 +++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/clone3/clone304.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 54d94c0ca..b2c4f338e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -128,6 +128,7 @@ clone10 clone10
>  clone301 clone301
>  clone302 clone302
>  clone303 clone303
> ++clone304 clone304
   ^
   This + shouldn't be there I suppose.

>  close01 close01
>  close02 close02
> diff --git a/testcases/kernel/syscalls/clone3/.gitignore b/testcases/kernel/syscalls/clone3/.gitignore
> index 10369954b..e9b5312f4 100644
> --- a/testcases/kernel/syscalls/clone3/.gitignore
> +++ b/testcases/kernel/syscalls/clone3/.gitignore
> @@ -1,3 +1,4 @@
>  clone301
>  clone302
>  clone303
> +clone304
> diff --git a/testcases/kernel/syscalls/clone3/clone304.c b/testcases/kernel/syscalls/clone3/clone304.c
> new file mode 100644
> index 000000000..8d0d85bd4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone304.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Stephen Bertram <sbertram@redhat.com>
> + */
> +
> +/*\
> + * This test verifies that clone3() fals with EPERM when CAP_SYS_ADMIN
> + * has been dropped and ``clone_args.set_tid_size`` is greater than zero.
> + */
> +
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +
> +struct clone_args args = {0};

Ideally this should be allocated via the guarded buffers:

	struct clone_args *args;

	struct tst_test test = {
		...
		.bufs = (struct tst_buffers []) {
			{&args, size = sizeof(*args)},
			{}
		}
		...
	}

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#guarded-buffers

> +static struct tcase {
> +	uint64_t flags;
> +	char *sflags;
> +} tcases[] = {
> +	{CLONE_NEWPID, "CLONE_NEWPID"},
> +	{CLONE_NEWCGROUP, "CLONE_NEWCGROUP"},
> +	{CLONE_NEWIPC, "CLONE_NEWIPC"},
> +	{CLONE_NEWNET, "CLONE_NEWNET"},
> +	{CLONE_NEWNS, "CLONE_NEWNS"},
> +	{CLONE_NEWUTS, "CLONE_NEWUTS"},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	pid_t tid_array[4] = {0, 0, 0, 0};
> +
> +	args.flags = tc->flags;
> +	args.set_tid = (uint64_t)(uintptr_t)tid_array;
> +
> +	TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM, "clone3(%s) should fail with EPERM",tc->sflags);
                                                                                             ^
											     missing space
> +}
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +
> +	args.pidfd = 0;
> +	args.child_tid = 0;
> +	args.parent_tid = 0;
> +	args.exit_signal = 0;
> +	args.stack = 0;
> +	args.stack_size = 0;
> +	args.tls = 0;

memset(args, 0, sizeof(*args) is probably safer.

> +	args.set_tid_size = 4;  // Greater than zero - requires CAP_SYS_ADMIN
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.test = run,
> +	.needs_root = 1,
> +	.caps = (struct tst_cap []) {
> +				TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
> +				{}
           ^
	   Just single tab here.
> +	},
> +};
> -- 
> 2.49.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
