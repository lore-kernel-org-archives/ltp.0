Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98889C83F1B
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 13:02:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32CFC3CB2FC
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 15:02:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ADF83C0882
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 15:02:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA76C1400BC0
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 15:02:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6311F38C;
 Fri, 11 Jul 2025 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752238937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BGhKSejUI+qPQ6pm3fV0y8OqqgV9ZjK+NUJbX++AtE=;
 b=L4u5ajk3KjL8beWwGkAGWF53cgDnTss30Yf5x9ofvarH8KLoYBNr+gN/Qkq1l+sZ/kfZ7y
 NxtwUDfrfQmyqBlwrR/yCs3767BYrygvaUyIYAEvwMzuDIEBP5HWC3ls9/JQPpVekcIz+k
 RBIuV0M8TwDcb6OxzXBVzGa/uqR8IMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752238937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BGhKSejUI+qPQ6pm3fV0y8OqqgV9ZjK+NUJbX++AtE=;
 b=7CC00AEF6KclroV49Np0XnabFmPfb6pWU67zTCdDrinDQPjGetfFDj6RZEvDlnkX00eti4
 T4O4e1ei/q2wHrCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EXuuJiDE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CNZp4wDk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752238936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BGhKSejUI+qPQ6pm3fV0y8OqqgV9ZjK+NUJbX++AtE=;
 b=EXuuJiDEJC2j2ShO60haa7NEnRMf7+AV4iFiNtXzu8O/thQmepIyWxuBnA2UNkgcaLRPom
 8EzMI8SSnFK6DyhWQwMhqajq0XOLc9cPrAZyCi1ttgiK6P9BV1xaXJ425kH5XowkobXweB
 1ZMe8ezRHCtdkqKrVzQLSp4YNNwOtm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752238936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BGhKSejUI+qPQ6pm3fV0y8OqqgV9ZjK+NUJbX++AtE=;
 b=CNZp4wDkZyMI4AwKxlCr3S2+iW9iA0vQSc/6F9p/1SAEActJUWzssK3IRIQazouqgBbqIq
 oPId17mgkwNY9/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17E9513918;
 Fri, 11 Jul 2025 13:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tRhSBFgLcWhSNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Jul 2025 13:02:16 +0000
Date: Fri, 11 Jul 2025 15:02:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aHELexqAddKs0qU0@yuki.lan>
References: <20250321034248.3501-1-wegao@suse.com>
 <20250321151143.11332-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250321151143.11332-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,yuki.lan:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 2A6311F38C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mount08.c: Restrict overmounting of ephemeral
 entities
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
> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                           |  1 +
>  testcases/kernel/syscalls/mount/.gitignore |  1 +
>  testcases/kernel/syscalls/mount/mount08.c  | 57 ++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mount/mount08.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ded035ee8..d3abc8b85 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -852,6 +852,7 @@ mount04 mount04
>  mount05 mount05
>  mount06 mount06
>  mount07 mount07
> +mount08 mount08
>  
>  mount_setattr01 mount_setattr01
>  
> diff --git a/testcases/kernel/syscalls/mount/.gitignore b/testcases/kernel/syscalls/mount/.gitignore
> index 80885dbf0..3eee5863a 100644
> --- a/testcases/kernel/syscalls/mount/.gitignore
> +++ b/testcases/kernel/syscalls/mount/.gitignore
> @@ -6,3 +6,4 @@
>  /mount05
>  /mount06
>  /mount07
> +/mount08
> diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
> new file mode 100644
> index 000000000..1938c5519
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount/mount08.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Verify that mount will raise ENOENT if we try to mount on magic links
> + * under /proc/<pid>/fd/<nr>.
> + */
> +
> +#include "tst_test.h"
> +#include <sys/mount.h>
> +#include "tst_safe_file_at.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FOO MNTPOINT "/foo"
> +#define BAR MNTPOINT "/bar"
> +
> +static void run(void)
> +{
> +	char path[PATH_MAX];
> +	int foo_fd, newfd, proc_fd;
> +
> +	foo_fd = SAFE_OPEN(FOO, O_RDONLY | O_NONBLOCK, 0640);
> +	newfd = SAFE_DUP(foo_fd);
> +	SAFE_CLOSE(foo_fd);

AFAIK the dup() here is not needed, the original reproducer used the
dup() to create a file descriptor with exact number for the loop. In
this case we can just take the fd from SAFE_OPEN() and use it instead of
the newfd.

> +	sprintf(path, "/proc/%d/fd/%d", getpid(), newfd);
> +
> +	proc_fd = SAFE_OPENAT(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
> +
> +	sprintf(path, "/proc/%d/fd/%d", getpid(), proc_fd);
> +
> +	TST_EXP_FAIL(
> +		mount(BAR, path, "", MS_BIND, 0),
> +		ENOENT,
> +		"mount() on proc failed expectedly"
                ^
		This message is used even if the call passed
		unexpectedly, so it should describe what is being done
		rather than the expected outcome, e.g.:

		"mount(/proc/$PID/fd/$FD)"
> +	);

You are not closing the file descriptors here, so the test fails with:
"-i 1000" command line params.

> +}
> +
> +static void setup(void)
> +{
> +	SAFE_CREAT(FOO, 0777);
> +	SAFE_CREAT(BAR, 0777);

This leaks two file descriptors too, but at least it's these are not
opened on each iteration.

If you just need to create a file do SAFE_TOUCH(FOO, 0777, NULL)
instead.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.min_kver = "6.12",

With this you are masking the problem on older kernels, please do not,
as the problem has possible security implications.

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "d80b065bb172"},
> +		{}
> +	}
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
