Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5053C433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 06:23:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC5A13CAE5D
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 08:23:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E381F3C1B92
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 08:23:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6BE956008A3
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 08:23:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D3DD1F37E;
 Mon, 10 Oct 2022 06:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665383001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTJz/peupEZDF8BDlBGfsj4xzc8z6xzoblQQIUdZopQ=;
 b=kZmXEzJ465+8EJS/PC+I3c2uwyBBI9K0SOLbkO6d/EYPCXueT6C3UpkO4npZocEZULY0af
 98maGCiLNC8sdfOt3bCWMG3jifkmHtqWZKagphrb2LUoguTdfiotMDofEPpuuIBqoVIJOr
 8RJivqZx7vK03WTHtsYk5gkU7T3JlQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665383001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTJz/peupEZDF8BDlBGfsj4xzc8z6xzoblQQIUdZopQ=;
 b=1b9Lz3EW+nxxUNdExM2Gwpu0G5GikUhuQW1B+hwrsO9QEGqyjz39zPW16XqQNjsYZdUGUu
 esArkngmuxyhGzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD4C213479;
 Mon, 10 Oct 2022 06:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lElYG1i6Q2N9OwAAMHmgww
 (envelope-from <akumar@suse.de>); Mon, 10 Oct 2022 06:23:20 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 10 Oct 2022 11:53:17 +0530
Message-ID: <8145468.T7Z3S40VBb@localhost>
Organization: SUSE
In-Reply-To: <20221007083406.16036-1-andrea.cervesato@suse.com>
References: <20221007083406.16036-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add epoll_create1_03 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Friday, October 7, 2022 2:04:06 PM IST Andrea Cervesato via ltp wrote:
> The test verifies epoll_create1 will raises EMFILE when
> /proc/sys/fs/epoll/max_user_watches is reached.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .../syscalls/epoll_create1/epoll_create1_03.c | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c
> 
> diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c
> new file mode 100644
> index 000000000..7f51edf7a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that epoll_create1 returns -1 and set errno to EMFILE when maximum
> + * number of epoll watchers is reached.
> + */
> +
> +#include <sys/epoll.h>
> +
> +#include "tst_test.h"
> +#include "lapi/epoll.h"
> +#include "lapi/syscalls.h"
> +
> +static void run(void)
> +{
> +	int i, max_inst;
> +
> +	SAFE_FILE_LINES_SCANF("/proc/sys/fs/epoll/max_user_watches", "%d", &max_inst);
> +
> +	for (i = 0; i < max_inst; i++)
> +		TST_EXP_PASS_SILENT(epoll_create1(0) == 0);
I don't think this is correct,
epoll_create1(0) will return a file descriptor (a nonnegative integer).
And IIUC, TST_EXP_PASS* macros take a function call only and not a compare statement.

> +
> +	TST_EXP_FAIL(epoll_create1(0), EMFILE);
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "2.6.27",
> +	.test_all = run,
> +};
> 
Also,
Test reports TBROK if run for more than one iteration -
$ ./epoll_create1_03 -i2
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
epoll_create1_03.c:28: TPASS: epoll_create1(0) : EMFILE (24)
epoll_create1_03.c:23: TBROK: Failed to open FILE '/proc/sys/fs/epoll/max_user_watches' for reading: EMFILE (24)


Kind Regards,
Avinesh





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
