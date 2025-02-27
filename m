Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20266C19F32
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 16:03:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DE6C3C9E2E
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 17:03:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1A0B3C9A74
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 17:03:07 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CBCEA1BE1849
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 17:03:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED76621174;
 Thu, 27 Feb 2025 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740672186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/Nznz0E/Vhg9b6qFoLapWM6xFev06D6Am2V1F5gQA0=;
 b=cENUcY1W2tdlYOudUHtP9B/KiltqOX3jV6qN2stmvrmGVj5mwtH1QMtegu1f3KEc1VKc6S
 KxbsTYKDxiSsMSLq97sd2NboqBoQtHHqxXgThkFdYN6AVJ92po3lQaheSjmtyryVDAbGc+
 xZhhb8dB9njVh7Oq3ku/otyN5wyoD20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740672186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/Nznz0E/Vhg9b6qFoLapWM6xFev06D6Am2V1F5gQA0=;
 b=9makUMnMPqZIJs6VqZOjEVvdcHY/nI5kPJfIqqZN5DF6IqakAENZkKh3yksXW0xLxme31O
 Z0Ku8swPJZt/5rAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740672185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/Nznz0E/Vhg9b6qFoLapWM6xFev06D6Am2V1F5gQA0=;
 b=uB5cU+A1tD+5qGLYwjfEbfUcRPn/C9sLdLKYJbzFPyat9c+JQEYVjVqGK6MXugjRR4NpZV
 PCFKjYrR6pKt2OJf0Ret0T+3CqZ6+HgUSaYNSI4+nDYFy9SBRt8ERYMkol+lnYys4IPvEZ
 bPb98YccvwJ6zPYnz/8UryisM3RkR+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740672185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/Nznz0E/Vhg9b6qFoLapWM6xFev06D6Am2V1F5gQA0=;
 b=Th9zgqkzKkMbG7MyfqwCxKv6RwoNfKAzv07yUAZc6Oljvt/nISQtgzPyJkIrk/AFatXmIt
 MY9Wg+IQssvFAlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA2171376A;
 Thu, 27 Feb 2025 16:03:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xdjsJrmMwGfxGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Feb 2025 16:03:05 +0000
Date: Thu, 27 Feb 2025 17:02:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250227160255.GD3130282@pevik>
References: <20240930135809.9300-1-wegao@suse.com>
 <20241209060117.16870-1-wegao@suse.com>
 <20241209060117.16870-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241209060117.16870-2-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

Hi Wei,

...
>  lib/tst_cgroup.c                              |   1 +
>  runtest/mm                                    |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  testcases/kernel/mem/cpuset/Makefile          |   6 +
>  testcases/kernel/mem/cpuset/cpuset02.c        | 142 ++++++++++++++++++
>  .../mq_timedreceive/mq_timedreceive01.c       |  80 +++++++---
This is completely unrelated change. Please remove it in the next version.

...
> +++ b/testcases/kernel/mem/cpuset/Makefile
> @@ -19,6 +19,12 @@

>  top_srcdir		?= ../../../..

> +LTPLIBS = numa
> +
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
> +
> +LDLIBS  += $(NUMA_LIBS)
IMHO we don't need LDLIBS  += $(NUMA_LIBS) ? It compiles without it
because it's added by /testcases/kernel/include/lib.mk due Cyril's change:
6f830ea5c0 ("lib: Replace path_exist() with tst_path_exists()")

> +LTPLDLIBS = -lltpnuma
This change is related to cpuset02, it should be prefixed with cpuset02:

..
> +++ b/testcases/kernel/mem/cpuset/cpuset02.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]

Also please delete [Description] in next version.
> + *
> + * Test checks cpuset.mems works with hugepage file.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include "tst_test.h"
> +
> +#ifdef HAVE_NUMA_V2
> +#include <numa.h>
> +#include <numaif.h>
> +#include <errno.h>
> +#include "tst_numa.h"
> +#include "tst_safe_stdio.h"
> +#include "mem.h"

And, please, rebase. Recent Cyril's cleanup removed "mem.h", see:
decd09c5dab6ad1694857116c011e01f8cc65788~..ac1af455d3384f1bbbda994aee42aeb036c27a23

> +#include "numa_helper.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define HUGE_PAGE_FILE MNTPOINT "hugepagefile"
> +#define PAGES_ALLOCATED 16u

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
