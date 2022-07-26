Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3551C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 12:49:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFE093C98BA
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 14:49:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1801A3C01CF
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 14:48:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C90491400972
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 14:48:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F12D37A67;
 Tue, 26 Jul 2022 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658839738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5vrE/urvMqPPRoISmW6EfJVcRqSSILcx9y2pfX+V8U=;
 b=ByFQw6TTKHMwTOrOr/johfyi5Z6SJ9MfS/2XiZHFSBhH2sPOn9tZUV0JCeVLDwT1hPJNAK
 sI2IWHMMZIdm+22HW+3/ohiPSuymHBY7rECiCKu5PK7t0LpzBaY23aWt3u2MkikLfnSRrf
 CAMX6+TDvHJN/rwBPQ4DWW1PINznlFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658839738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5vrE/urvMqPPRoISmW6EfJVcRqSSILcx9y2pfX+V8U=;
 b=JewHGZcnYa/Y83V7v96KCViw78HqAc8CSWdJurA6d8Vbv7DaJBm2ofGfILxXlsK2dVnKot
 ZwQF5IDSxIFdfgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C29EC13322;
 Tue, 26 Jul 2022 12:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aADaLbni32L8CgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 12:48:57 +0000
Date: Tue, 26 Jul 2022 14:48:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <Yt/iuJCC9kLv7LV0@pevik>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <d9b6784f8e3fa3e4d9486bc54a2e230a313edd84.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9b6784f8e3fa3e4d9486bc54a2e230a313edd84.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 09/18] testcases/lib: Implement tst_cgctl binary
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

> Implement a binary utility that creates an interface to make calls to
> the cgroup C API.

> This will effectively allow shell scripts to make calls to the cgroup C
> api.

> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
> v2: Add license identifier and copyright.
> Reformat with tabs instead of spaces.
> Add help format message and help function.
> Add error gotos to streamline error messaging.

>  testcases/lib/Makefile    |  2 +-
>  testcases/lib/tst_cgctl.c | 87 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/lib/tst_cgctl.c

> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index f2de0c832..f4f8c8524 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -12,6 +12,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>  			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
>  			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
>  			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
> -			   tst_check_kconfigs
> +			   tst_check_kconfigs tst_cgctl

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/tst_cgctl.c b/testcases/lib/tst_cgctl.c
> new file mode 100644
> index 000000000..4f4fe8542
> --- /dev/null
> +++ b/testcases/lib/tst_cgctl.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Canonical Ltd.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include "tst_cgroup.h"
> +
> +#define USAGE "Usage: tst_cgctl require [controller] [test_pid]\n\
> +	\t cleanup [config (output of tst_cg_print_config)]\n\
> +	\t print\n\
> +	\t help\n"
nit: instead of define I'd create function usage().
I'd print always to stderr, just exit code would be different.
(we print tst_res/tst_brk output to stderr, thus it's better to use it).

Also checkpatch does not like it:
$ cd testcases/lib/ && make check-tst_cgctl
CHECK testcases/lib/tst_cgctl.c
tst_cgctl.c:13: WARNING: Avoid line continuations in quoted strings

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
