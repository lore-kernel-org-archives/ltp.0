Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E941EE9A048
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771494908; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=9YICu5G6KkOy4CFIbCJl2DnGDEH9Yg6t25/dhn/hqLU=;
 b=hK9adtdaL5paqItpjT+9WdNPCueinlS7tczxTmn+vTZCGZpLzgi7qHPAmTLN3SLlJniOb
 E+xWGhZ5wkkE7drRd7ZOz7LVLYBUVGql/JoRwBkOlL7jq15WOznD8oSHqHV8rAJiQ6i33QE
 9egPZyD9m2eHhpC8Mmy9PPCyXYjDqBM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 756BE3D0706
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 10:55:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93B793CB3E5
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 10:54:45 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85DD5600216
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 10:54:44 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so5785665e9.0
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 01:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771494884; x=1772099684; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBR09uG93gEInD+98XemLKpTkWW3H3xDzP3OeZr/iD0=;
 b=V8lolyijDX5abBi+gcOd8QIevFGkV1+bbdTBeTg3QL6zMOMSC+fLzIFlREQQoS8S7K
 krZgV579ScwTn59bgTFqtFInLxkmJEmgVkuQvUPO91WkQcSHL+v010ZmEr4OYmbSH8yg
 oQx3EqLBvCXPgqUa20q4yjTL9Kvbt/BuMU2kFCyrrSq4DgVgv/u2TNOmHmVxFKX8oXLP
 oh+sylKVwxSxaEnGz4sCC9bT8o3A/AredNYLXVQYfVFcXPWEQGln0JIYCKfy9ebPNZWN
 +PoXnuACo+enxYvmAC5SJhI2LWAxviEm4ZlNkj6eC2fW3NXUH8zDK7dgXRJK3+kcZvj7
 xxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771494884; x=1772099684;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EBR09uG93gEInD+98XemLKpTkWW3H3xDzP3OeZr/iD0=;
 b=WrczyO6ppQRSRI89MgmXic2e0xgFaVPPY5Ji77y/UhWPYe6HZssUmvo8JYn1HD9qLJ
 wcQ/W8iKACHDunfKnFFEvRKwNxF3ize+3CM5BTA9cHMkWwe7fcUBznNKXB6LjvtB9KnE
 dTcOpZRa02MTchF5Y/0QwishKo6QMDiraQ2+adFSmpixMEJYH3T8LlzGc2dRO7fu28Db
 vB8Sa1K1VykQLILg1ukFt49KjTOti0F0T5YU9trgL2rDs0Zo7RGNftvnlXBlB5aLB3cH
 OpkxgQNRA3GDQUnXb93AbaDmqYszVDjY94jF4ikixw/ATfVpzyR1t4J/Mg4NF4Wy35BS
 s+uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8xylChLp4qpqyoPDXdk8ZLTXwwrJjrCUCHd/X8Z+LYXt1WojNQmf6fiAusWO9wXqjJg8=@lists.linux.it
X-Gm-Message-State: AOJu0YywTWRNaDHOO2wujGOZw22kFhcgUz/Z443KfbVmnisqEv8NiSWm
 fMc9u+8KS4TZZNciP8hvyg82/PnUfBf3776LTunG9Yq9DK5uotRPCyXTDy7b/epg8bCfik9m2ND
 cO6vz
X-Gm-Gg: AZuq6aIbwAV7bPMxzz1pWAIUHZcPocgchUDRhmqSKOwgZBprjBkjCNxvvNZ2D77rrD+
 7pUtIY3fGR6SKqUIRjUJlsWteKtEgYM5i5xhcaJnL97ZSV4eJ4UE2gZDOSk+g2i3AKp/gZ2fU8T
 DV/+QP1vvtyZ5WbI5m2wWWlZ8zziofgBui6jNlTMW8PuTRotxlw4+jujZoYorjUAkJIH+CFVf2c
 m25K3GWQ1FT4oI1zrRXOX9bS7SsrKL2VnasSAmvgwpSJTBDzuJ+t1eWGNC436/6IEx62sGX9Cmr
 +UJ+U/M+/T3y98/aVvP4ZxSDdumKvMtNFReBaVtNNt4rX2nFZEL8NBA83Y+JucSMrt5aVgM2yeR
 nR2LifEn0R+EH1uF6qb54gEGVNJteRKoV/8PdZXCuOAiwJdDUP+dN7PougdZ4dUO/GjffxltpTh
 kkxnQ/qJmklTBp8r7Jy0Ib+LR+xr0jpQjKWvStL9mWZUw4mIRYBbUeDQeP9610nlD3qFUIIWvci
 xfqoHfiG0Qg1e1/niE=
X-Received: by 2002:a05:600c:4e93:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-48379bbcbd0mr284639175e9.12.1771494883774; 
 Thu, 19 Feb 2026 01:54:43 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d994670sm524417965e9.4.2026.02.19.01.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 01:54:43 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 19 Feb 2026 10:54:42 +0100
Message-Id: <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com>
To: "Ricardo Branco" <rbranco@suse.de>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260218135026.159676-1-rbranco@suse.de>
In-Reply-To: <20260218135026.159676-1-rbranco@suse.de>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Add test using UFFDIO_POISON
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Wed Feb 18, 2026 at 2:50 PM CET, Ricardo Branco wrote:
> Signed-off-by: Ricardo Branco <rbranco@suse.de>
> ---
>  configure.ac                                  |   1 +
>  include/lapi/userfaultfd.h                    |  13 ++
>  .../kernel/syscalls/userfaultfd/.gitignore    |   1 +
>  .../kernel/syscalls/userfaultfd/Makefile      |   1 +
>  .../syscalls/userfaultfd/userfaultfd06.c      | 134 ++++++++++++++++++
>  5 files changed, 150 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
>
> diff --git a/configure.ac b/configure.ac
> index 7fa614dcb..94bcbcc98 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -278,6 +278,7 @@ AC_CHECK_TYPES([struct sockaddr_vm],,,[
>  ])
>  
>  AC_CHECK_TYPES([struct uffdio_move],,,[#include <linux/userfaultfd.h>])
> +AC_CHECK_TYPES([struct uffdio_poison],,,[#include <linux/userfaultfd.h>])
>  AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
>  
>  # Tools knobs
> diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
> index 0c9e34c84..aab3890b7 100644
> --- a/include/lapi/userfaultfd.h
> +++ b/include/lapi/userfaultfd.h
> @@ -233,6 +233,19 @@ struct uffdio_writeprotect {
>  };
>  #endif	/* HAVE_STRUCT_UFFDIO_WRITEPROTECT */
>  
> +#ifndef HAVE_STRUCT_UFFDIO_POISON
> +#define UFFD_FEATURE_POISON			(1<<14)
> +#define _UFFDIO_POISON				(0x08)
> +#define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
> +				      struct uffdio_poison)
> +struct uffdio_poison {
> +        struct uffdio_range range;
> +#define UFFDIO_POISON_MODE_DONTWAKE		((__u64)1<<0)
> +        __u64 mode;
> +        __s64 updated;
> +};
> +#endif	/* HAVE_STRUCT_UFFDIO_POISON */
> +
>  #define SAFE_USERFAULTFD(flags, retry) \
>  	safe_userfaultfd(__FILE__, __LINE__, (flags), (retry))
>  
> diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
> index fb2ae243b..bc32fdf3b 100644
> --- a/testcases/kernel/syscalls/userfaultfd/.gitignore
> +++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
> @@ -3,3 +3,4 @@
>  /userfaultfd03
>  /userfaultfd04
>  /userfaultfd05
> +/userfaultfd06
> diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
> index 96650a65a..3252e47df 100644
> --- a/testcases/kernel/syscalls/userfaultfd/Makefile
> +++ b/testcases/kernel/syscalls/userfaultfd/Makefile
> @@ -16,3 +16,4 @@ userfaultfd02: CFLAGS += -pthread
>  userfaultfd03: CFLAGS += -pthread
>  userfaultfd04: CFLAGS += -pthread
>  userfaultfd05: CFLAGS += -pthread
> +userfaultfd06: CFLAGS += -pthread
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> new file mode 100644
> index 000000000..c4546acce
> --- /dev/null
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 SUSE LLC
> + * Author: Ricardo Branco <rbranco@suse.com>
> + */
> +
> +/*\
> + * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
> + * from a different thread testing UFFDIO_POISON.
> + */
> +
> +#include "config.h"
> +#include <poll.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/userfaultfd.h"
> +
> +static int page_size;
> +static char *page;
> +static int uffd;
> +static volatile int poison_fault_seen;
> +static volatile int sigbus_seen;
> +static sigjmp_buf jmpbuf;
> +
> +static void sigbus_handler(int sig)
> +{
> +	if (sig == SIGBUS) {
> +		sigbus_seen = 1;
> +		siglongjmp(jmpbuf, 1);
> +	}
> +}
> +
> +static void set_pages(void)
> +{
> +	page_size = sysconf(_SC_PAGE_SIZE);
> +	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void reset_pages(void)
> +{
> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		page = NULL;
> +	}
> +}
> +
> +static void *handle_thread(void)
> +{
> +	static struct uffd_msg msg;
> +	struct uffdio_poison uffdio_poison = {};
> +	struct pollfd pollfd;
> +	int nready;
> +
> +	pollfd.fd = uffd;
> +	pollfd.events = POLLIN;
> +	nready = poll(&pollfd, 1, -1);
> +	if (nready == -1)
> +		tst_brk(TBROK | TERRNO, "Error on poll");
> +
> +	SAFE_READ(1, uffd, &msg, sizeof(msg));
> +
> +	if (msg.event != UFFD_EVENT_PAGEFAULT)
> +		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
> +
> +	poison_fault_seen = 1;
> +
> +	/* Poison the page that triggered the fault */
> +	uffdio_poison.range.start = msg.arg.pagefault.address & ~(page_size - 1);
> +	uffdio_poison.range.len = page_size;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_POISON, &uffdio_poison);
> +
> +	close(uffd);
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	pthread_t thr;
> +	struct uffdio_api uffdio_api = {};
> +	struct uffdio_register uffdio_register;
> +	struct sigaction sa = {};
> +	volatile char dummy;
> +
> +	sa.sa_handler = sigbus_handler;
> +	sigemptyset(&sa.sa_mask);
> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);
> +
> +	set_pages();
> +
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = UFFD_FEATURE_POISON;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +
> +	uffdio_register.range.start = (unsigned long) page;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +
> +	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
> +
> +	/* Try to read from the page: should trigger fault, get poisoned, then SIGBUS */
> +	if (sigsetjmp(jmpbuf, 1) == 0) {
> +		dummy = page[0];
> +		(void)dummy;
> +	}
> +
> +	SAFE_PTHREAD_JOIN(thr, NULL);
> +	reset_pages();

This should also go into a cleanup(), otherwise if other syscalls will
fail (ioctl for instance), memory will be lost.

> +
> +	if (poison_fault_seen && sigbus_seen) {
> +		tst_res(TPASS, "POISON successfully triggered SIGBUS");
> +	} else if (poison_fault_seen && !sigbus_seen) {
> +		tst_res(TFAIL, "POISON fault seen but no SIGBUS received");
> +	} else if (!poison_fault_seen && sigbus_seen) {
> +		tst_res(TFAIL, "SIGBUS received but no poison fault seen");
> +	} else {
> +		tst_res(TFAIL, "No poison fault or SIGBUS observed");
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.min_kver = "6.6",

This is not needed, we should use UFFDIO_API instead, in order to verify
that UFFD_FEATURE_POISON is present and eventually TCONF.


Also, if I run checkpatch.pl on the code I get:

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#25: FILE: userfaultfd06.c:25:
+static volatile int poison_fault_seen;

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#26: FILE: userfaultfd06.c:26:
+static volatile int sigbus_seen;

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#88: FILE: userfaultfd06.c:88:
+       volatile char dummy;

WARNING: braces {} are not necessary for any arm of this statement
#120: FILE: userfaultfd06.c:120:
+       if (poison_fault_seen && sigbus_seen) {
[...]
+       } else if (poison_fault_seen && !sigbus_seen) {
[...]
+       } else if (!poison_fault_seen && sigbus_seen) {
[...]
+       } else {
[...]

total: 0 errors, 4 warnings, 134 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

userfaultfd06.c has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

If you have `b4`, please run `b4 prep --check` before sending the patch.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
