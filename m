Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23A6C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 16:17:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE6503CD74F
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 18:17:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C33433C7AB3
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 18:17:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 03901140026D
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 18:17:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E02A3F1C;
 Thu, 20 Aug 2026 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787242641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yv+uhM4stNuGtOoAUlzsX+GFH8bmzLYX33ttNj1GeBw=;
 b=tFwFaI2XLiUwl1/ZV2JKggc3XSv/2GJdzH1Y/txcXOUV5RE3USIald3V4q6TOIcVACVcqo
 rpeCmuMxNJUTEBpj8OBYnIrI8R86kl4bylIr0E1/OyCBgxXtCUJk6uaYcUxDwlxXL4f3o7
 tQ+k29K7TmRSDZAVlP2yYrDhHeC/48o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787242641;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yv+uhM4stNuGtOoAUlzsX+GFH8bmzLYX33ttNj1GeBw=;
 b=EYnXNC0m4jC+KIT5NkxlFXOqrbJqx6iyhiWWhvWEVipLwxEPoMiC4BB5v2+RcYy9nXwglg
 RSX7lZNDCdRWIpBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787242637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yv+uhM4stNuGtOoAUlzsX+GFH8bmzLYX33ttNj1GeBw=;
 b=e/rcUnL8vJ1UIj8c6TqL6UpHvSHWaVram7d81hZxOmcVu9arWOLanw+cwNC6JZOtFYJ+UZ
 irqEcW4BBpc5/Q+QePjT19UZUrt+UJA2b9636ai3z7XSyd5JA+9AslfvvvbTHMlYeFyXtu
 0EioyY775xw5hj6y0SYAXShkP64NoRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787242637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yv+uhM4stNuGtOoAUlzsX+GFH8bmzLYX33ttNj1GeBw=;
 b=r7MMpmpOIHx0whdU+YXuA8drJZ5WPOeL25QuwuzdWn5L5rrIWj3mSMHvg8JLfvhK9c0UjX
 8AGl0FeKLC7DQqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63052351D;
 Thu, 20 Aug 2026 16:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v6GJFI0oh2o2WQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Aug 2026 16:17:17 +0000
Date: Thu, 20 Aug 2026 18:17:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aocokOprfib9GOC0@yuki.lan>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
 <20260820-fchroot-v2-10-062ed20957a0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260820-fchroot-v2-10-062ed20957a0@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 10/16] fchroot07: test execve blocked
 by failfs root
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
> Verify that after fchroot() moved the root into failfs, loading a
> binary by absolute path fails with EOPNOTSUPP. The exec runs in a
> grandchild so a wrongly successful exec is still detected through
> the exit code.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/staging                               |  1 +
>  testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
>  testcases/kernel/syscalls/fchroot/fchroot07.c | 72 +++++++++++++++++++++++++++
>  3 files changed, 74 insertions(+)
> 
> diff --git a/runtest/staging b/runtest/staging
> index 8b6b1ecd9..b8954bb5a 100644
> --- a/runtest/staging
> +++ b/runtest/staging
> @@ -6,3 +6,4 @@ fchroot03 fchroot03
>  fchroot04 fchroot04
>  fchroot05 fchroot05
>  fchroot06 fchroot06
> +fchroot07 fchroot07
> diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
> index 12151270a..b68069d9a 100644
> --- a/testcases/kernel/syscalls/fchroot/.gitignore
> +++ b/testcases/kernel/syscalls/fchroot/.gitignore
> @@ -4,3 +4,4 @@ fchroot03
>  fchroot04
>  fchroot05
>  fchroot06
> +fchroot07
> diff --git a/testcases/kernel/syscalls/fchroot/fchroot07.c b/testcases/kernel/syscalls/fchroot/fchroot07.c
> new file mode 100644
> index 000000000..d5ebfc576
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchroot/fchroot07.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test that :manpage:`execve(2)` is blocked under the failfs root.
> + *
> + * After :manpage:`fchroot(2)` moved the process root into failfs, loading
> + * a binary by absolute path fails with ``EOPNOTSUPP``.
> + *
> + * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
> + * sentinel requires ``CAP_SYS_CHROOT``.
> + *
> + * The exec runs in a grandchild: a wrongly successful exec would replace
> + * the test image, so the outcome can only be reported when the exec call
> + * returns, and the grandchild exit code tells the parent whether the
> + * image was replaced.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/syscalls.h"
> +
> +/* Marker exit code proving the grandchild image was not replaced. */
> +#define EXEC_NOT_REPLACED 42
> +
> +static void check_exec_blocked(void)
> +{
> +	pid_t pid = SAFE_FORK();
> +	int status;
> +
> +	if (!pid) {
> +		TST_EXP_FAIL(execl("/bin/true", "true", NULL), EOPNOTSUPP,
> +			"absolute exec blocked by the failfs root");
> +		exit(EXEC_NOT_REPLACED);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != EXEC_NOT_REPLACED)
> +		tst_res(TFAIL, "exec replaced the test image");
> +}
> +
> +static void run(void)
> +{
> +	if (SAFE_FORK())
> +		return;
> +
> +	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		"fchroot() with the FD_FAILFS_ROOT sentinel");
> +
> +	check_exec_blocked();
> +
> +	exit(0);
> +}
> +
> +static void setup(void)
> +{
> +	if (access("/bin/true", X_OK))
> +		tst_brk(TCONF | TERRNO, "/bin/true is not available");

I wonder if it would be better to add a fchroot07_child.c, it could do
just tst_reinit() and tst_res(TFAIL, "child executed") and we can then
drop the WAITPID and WIFEXITED() checks from here...

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.forks_child = 1,
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
