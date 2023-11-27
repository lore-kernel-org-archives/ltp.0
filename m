Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A54C07D59
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 13:46:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51AAB3CDB8F
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 14:46:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5D0C3CDB1E
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 14:46:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 60781200DC3
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 14:46:38 +0100 (CET)
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id F1D9E1F8AC
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701092796;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQHdeYTawcjdTOjcEEzbghB2E6Bz560jA7cL9HX32WQ=;
 b=KTr+12ZJ0OidYw9kDNRvadVmSb6jOMq5Hs4GFDHGDm+Pkp8E/HqogkQl8DOHtQdOAgi8Tf
 aD8f88gEpEMzUxvCm69aAk9heVm1afdYUUqrkOkN3LOHZVftLhalhzNTT6hchsXVivr2jn
 Q8afdHpPjp+nndX5Ngio+KRIqiO+2H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701092796;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQHdeYTawcjdTOjcEEzbghB2E6Bz560jA7cL9HX32WQ=;
 b=aH6CSB6X1ULD9SxjEffWNgfuHezY8WCoa06Ka8xGvZ/vF0zEqMnXog9rYyWTUj2BABVUMj
 OLZNE65cy/bN7cAg==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D2B2D2C145;
 Mon, 27 Nov 2023 13:46:33 +0000 (UTC)
References: <20230925093005.24248-1-mkittler@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Marius Kittler <mkittler@suse.de>
Date: Mon, 27 Nov 2023 13:45:10 +0000
Organization: Linux Private Site
In-reply-to: <20230925093005.24248-1-mkittler@suse.de>
Message-ID: <874jh78g1z.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: F1D9E1F8AC
X-Spamd-Result: default: False [18.99 / 50.00];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; RDNS_NONE(1.00)[];
 SPAMHAUS_XBL(0.00)[149.44.160.134:from]; TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 REPLYTO_ADDR_EQ_FROM(0.00)[];
 HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
 HAS_ORG_HEADER(0.00)[]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; RDNS_DNSFAIL(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add regression test for hangup on pipe
 operations
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Pushed with some significant changes, please see commit for
details. Thanks!

Marius Kittler <mkittler@suse.de> writes:

> This tests the problem fixed by the patch
> https://www.spinics.net/lists/linux-api/msg49731.html.
>
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>  runtest/syscalls                          |  1 +
>  testcases/kernel/syscalls/pipe/.gitignore |  1 +
>  testcases/kernel/syscalls/pipe/pipe15.c   | 96 +++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/pipe/pipe15.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 4f1ee1f34..6c125c2f5 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1004,6 +1004,7 @@ pipe11 pipe11
>  pipe12 pipe12
>  pipe13 pipe13
>  pipe14 pipe14
> +pipe15 pipe15
>  
>  pipe2_01 pipe2_01
>  pipe2_02 pipe2_02
> diff --git a/testcases/kernel/syscalls/pipe/.gitignore b/testcases/kernel/syscalls/pipe/.gitignore
> index 774d73205..581a68b78 100644
> --- a/testcases/kernel/syscalls/pipe/.gitignore
> +++ b/testcases/kernel/syscalls/pipe/.gitignore
> @@ -12,3 +12,4 @@
>  /pipe12
>  /pipe13
>  /pipe14
> +/pipe15
> diff --git a/testcases/kernel/syscalls/pipe/pipe15.c b/testcases/kernel/syscalls/pipe/pipe15.c
> new file mode 100644
> index 000000000..7b55143c1
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pipe/pipe15.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 SUSE LLC Marius Kittler <mkittler@suse.de>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This is a regression test for hangup on pipe operations. See
> + * https://www.spinics.net/lists/linux-api/msg49762.html for
> + * additional context. It tests that pipe operations do not block
> + * indefinitely when going to the soft limit on the total size of
> + * all pipes created by a single user.
> + */
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_safe_macros.h"
> +
> +static int pipe_count;
> +static int *pipes;
> +static char *buffer;
> +static int buffer_size;
> +
> +static void run(void)
> +{
> +	SAFE_WRITE(0, pipes[1], buffer, buffer_size);
> +	SAFE_READ(0, pipes[0], buffer, buffer_size - 1);
> +	SAFE_WRITE(0, pipes[1], buffer, 1);
> +	tst_res(TPASS,
> +		"Pipe operations do not block indefinitely when going to "
> +		"the soft limit on the total size of all pipes created by "
> +		"a single user");
> +}
> +
> +static void setup(void)
> +{
> +	int pipe[2];
> +	int page_size = getpagesize(), soft_limit;
> +	struct rlimit nfd;
> +
> +	/* determine the buffer size of a pipe, usually 65536 */
> +	SAFE_PIPE(pipe);
> +	buffer_size = fcntl(pipe[1], F_GETPIPE_SZ);
> +	SAFE_CLOSE(pipe[0]);
> +	SAFE_CLOSE(pipe[1]);
> +
> +	/* determine the max number of pipes we can create within the
> +	 * soft limit, usually 1024
> +	 */
> +	SAFE_FILE_SCANF("/proc/sys/fs/pipe-user-pages-soft", "%i", &soft_limit);
> +	pipe_count = soft_limit * page_size / buffer_size;
> +
> +	tst_res(TINFO, "Soft limit for pipes: %i pages", soft_limit);
> +	tst_res(TINFO, "Buffer size: %d byte", buffer_size);
> +	tst_res(TINFO, "Creating %i pipes", pipe_count);
> +
> +	/* avoid running into "pipe() failed: EMFILE (24)" */
> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &nfd);
> +	if (nfd.rlim_max < (unsigned long)pipe_count)
> +		tst_brk(TCONF, "NOFILE limit max too low: %lu < %i",
> +			nfd.rlim_max, pipe_count);
> +	if (nfd.rlim_cur < nfd.rlim_max) {
> +		nfd.rlim_cur = nfd.rlim_max;
> +		SAFE_SETRLIMIT(RLIMIT_NOFILE, &nfd);
> +	}
> +
> +	/* allocate memory for pipes and the buffer */
> +	pipes = calloc(pipe_count * 2, sizeof(int));
> +	memset(pipes, 0xFF, pipe_count * 2 * sizeof(int));
> +	for (int i = 0; i < pipe_count; ++i)
> +		SAFE_PIPE(pipes + i * 2);
> +	buffer = calloc(buffer_size, 1);
> +}
> +
> +static void cleanup(void)
> +{
> +	for (int i = 0; i < pipe_count * 2; i++)
> +		if (pipes[i] > 0)
> +			SAFE_CLOSE(pipes[i]);
> +	if (pipes)
> +		free(pipes);
> +	if (buffer)
> +		free(buffer);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.cleanup = cleanup
> +};
> -- 
> 2.42.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
