Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666ACC5AD4C
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 15:05:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 136763CFE18
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 16:05:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 967D93CC24B
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:05:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 96F0D60062B
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:05:00 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B60AC1FD96;
 Thu, 23 Nov 2023 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700751899;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6uSPC8O5DLpTPHv+jzFg+vxS0uO6Vw80PN19qBWynhM=;
 b=lh9TcWpL2+FPqflb0u/ni34AtCoy3rclgR9ipgPR2ZOibfJIZfZOtLH2h1pllCVB04LNqw
 kgrQeoIZWGDQFIsMi89OY5N4kqbCmwpYfPkudhButIZR+3G5srDChVROl1D2Ep9AxQgJPC
 iAIynSyMb6m33YRZCU29ra2px/VDpf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700751899;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6uSPC8O5DLpTPHv+jzFg+vxS0uO6Vw80PN19qBWynhM=;
 b=qXcHzQFdhTnHxT86cbttJ92ar6/WA/SmjY8nmVhZ15ZnU3Tp7q+6aEY+8DKKrRxR0oSRUw
 IgOiCVkwfRP2NeCA==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 44AA12CC7B;
 Thu, 23 Nov 2023 10:25:43 +0000 (UTC)
References: <20230921021445.2075-1-wegao@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Thu, 23 Nov 2023 09:47:13 +0000
Organization: Linux Private Site
In-reply-to: <20230921021445.2075-1-wegao@suse.com>
Message-ID: <87leao936i.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [14.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: B60AC1FD96
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] seccomp01.c: Add SECCOMP_RET_USER_NOTIF check
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

Wei Gao via ltp <ltp@lists.linux.it> writes:

> This case will report EINVAL error when execute SAFE_IOCTL(notifyFd,
> SECCOMP_IOCTL_NOTIF_RECV, req) such as 5.6.19, so i put current case's
> .min_kver = "5.7.19"
>
> NOTE: If your old kernel compile env is ubuntu 22.04 LTS, better use
> old gcc-8 and also apply patch base following link:
> https://www.spinics.net/lists/kernel/msg3797871.html
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  configure.ac                                  |   1 +
>  include/lapi/seccomp.h                        |   7 +
>  runtest/syscalls                              |   2 +
>  testcases/kernel/syscalls/seccomp/.gitignore  |   1 +
>  testcases/kernel/syscalls/seccomp/Makefile    |   8 +
>  testcases/kernel/syscalls/seccomp/seccomp01.c | 456 ++++++++++++++++++
>  6 files changed, 475 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/seccomp/.gitignore
>  create mode 100644 testcases/kernel/syscalls/seccomp/Makefile
>  create mode 100644 testcases/kernel/syscalls/seccomp/seccomp01.c
>
> diff --git a/configure.ac b/configure.ac
> index 662c4c058..6cea35cb4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -138,6 +138,7 @@ AC_CHECK_FUNCS_ONCE([ \
>      renameat \
>      renameat2 \
>      sched_getcpu \
> +    seccomp \
>      sendmmsg \
>      sethostid \
>      setns \
> diff --git a/include/lapi/seccomp.h b/include/lapi/seccomp.h
> index 29819ba6f..cfb3da55d 100644
> --- a/include/lapi/seccomp.h
> +++ b/include/lapi/seccomp.h
> @@ -37,4 +37,11 @@ struct seccomp_data {
>  };
>  
>  #endif /* HAVE_LINUX_SECCOMP_H*/
> +
> +# ifndef HAVE_SECCOMP
> +int seccomp(unsigned int operation, unsigned int flags, void *args)
> +{
> +	return syscall(__NR_seccomp, operation, flags, args);
> +}
> +# endif /* HAVE_SECCOMP */
>  #endif /* LAPI_SECCOMP_H__ */
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 4f1ee1f34..544610d63 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1242,6 +1242,8 @@ select02 select02
>  select03 select03
>  select04 select04
>  
> +seccomp01 seccomp01
> +
>  semctl01 semctl01
>  semctl02 semctl02
>  semctl03 semctl03
> diff --git a/testcases/kernel/syscalls/seccomp/.gitignore b/testcases/kernel/syscalls/seccomp/.gitignore
> new file mode 100644
> index 000000000..9196906cf
> --- /dev/null
> +++ b/testcases/kernel/syscalls/seccomp/.gitignore
> @@ -0,0 +1 @@
> +seccomp01
> diff --git a/testcases/kernel/syscalls/seccomp/Makefile b/testcases/kernel/syscalls/seccomp/Makefile
> new file mode 100644
> index 000000000..49238eee0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/seccomp/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright (c) 2023 Wei Gao <wegao@suse.com>
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/seccomp/seccomp01.c b/testcases/kernel/syscalls/seccomp/seccomp01.c
> new file mode 100644
> index 000000000..bf23fe8f7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/seccomp/seccomp01.c
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Michael Kerrisk <mtk.manpages@gmail.com>
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify seccomp and seccomp_user_notif
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/prctl.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <signal.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <linux/audit.h>
> +#include <sys/syscall.h>
> +#include <sys/stat.h>
> +#include <linux/filter.h>
> +#include <linux/seccomp.h>
> +#include <sys/ioctl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +#include "tst_test.h"
> +#include "lapi/seccomp.h"
> +
> +#define TMP_PREFIX_DIR "/tmp/ltp_test"
> +#define CWD_DIR "./abc"
> +#define OTHER_DIR "/aa"
> +
> +static struct tcase {
> +	char *dir;
> +	int expect_ret;
> +	char *desc;
> +} tcases[] = {
> +	{TMP_PREFIX_DIR, strlen(TMP_PREFIX_DIR), "pathname begins with the prefix /tmp/"},
> +	{CWD_DIR, 0,  "pathname begins with ./"},
> +	{OTHER_DIR, -1, "pathname begins with /abc"},
> +};
> +
> +static int sendfd(int sockfd, int fd)
> +{
> +	struct msghdr msgh;
> +	struct iovec iov;
> +	int data;
> +	struct cmsghdr *cmsgp;
> +
> +	/* Allocate a char array of suitable size to hold the ancillary data.
> +	 * However, since this buffer is in reality a 'struct cmsghdr', use a
> +	 * union to ensure that it is suitable aligned.
> +	 */

Comments like this are not LTP style. Explanations can go in the
description. Inline comments are reserved for special cases.

> +	union {
> +		char   buf[CMSG_SPACE(sizeof(int))];
> +		/* Space large enough to hold an 'int' */
> +		struct cmsghdr align;
> +	} controlMsg;

Also controlMsg is not LTP style. This continues thoughout the patch.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
