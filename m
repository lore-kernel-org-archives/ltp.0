Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62754C64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 21:41:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF37F3CD8E5
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 22:41:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 170913CB867
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 22:40:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ED9C91A01106
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 22:40:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48D7422499;
 Thu,  9 Mar 2023 21:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678398048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KF1A54IC8L1FEPfUR0Fl4yB9wSfJmeE7O8f7I8FEbc0=;
 b=tC6nKWDvvP8N7Hoet6QJK+JTXnPHGIuFchB8bW3iYTJu1/Hb13QWaxLhjAUZD+9g+emgT6
 B50j7LNdqX56UzbfRDdLgVqrf4z87VWxJJhTdbtJNl9+Wy6kqxyjoEEhmub8ElJ+rroVQV
 ZUtRb1UKiFgAtQZWIUZJkiAt1jdR/4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678398048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KF1A54IC8L1FEPfUR0Fl4yB9wSfJmeE7O8f7I8FEbc0=;
 b=hi7e0Y7qfMDOCuRHXHX273tv4TjHPvEN9mpNbj62pD3RfBO4g+TvmK6MbVCpWG1aDdDnoy
 g0km3MPHXfDgzHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AAB913A10;
 Thu,  9 Mar 2023 21:40:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LC5/AGBSCmQjDwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Mar 2023 21:40:48 +0000
Date: Thu, 9 Mar 2023 22:40:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230309214046.GC451752@pevik>
References: <20230306235715.29868-1-wegao@suse.com>
 <20230307085139.3574-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230307085139.3574-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] kill01: New case cgroup kill
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

Closes: https://github.com/linux-test-project/ltp/issues/846

Test LGTM.

...
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
Is it based on some Christian's reproducer?
I haven't noticed any in https://lwn.net/Articles/855049/ (linked in #846)
nor in the patch
https://lwn.net/ml/cgroups/20210503143922.3093755-1-brauner@kernel.org/.
But maybe I just overlooked it.

> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic cgroup kill test.
> + *
> + */
> +
> +#include <errno.h>
> +#include <linux/limits.h>
> +#include <stdbool.h>
nit: stdbool.h is not needed (can be removed before merge).

...
> +static void run(void)
> +{
> +	pid_t pids[MAX_PID_NUM];
> +	int i;
> +
> +	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
> +
> +	memset(buf, 0, buf_len);
> +
> +	for (i = 0; i < pid_num; i++)
> +		pids[i] = cg_run_nowait(cg_child_test_simple, child_fn);
> +
> +	TST_EXP_PASS(cg_wait_for_proc_count(cg_child_test_simple, pid_num));
> +	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
> +
> +	for (i = 0; i < pid_num; i++) {
> +		/* wait_for_pid(pids[i]); */
I guess this comment should be removed before merge.
> +		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]) == SIGKILL);
> +	}
> +
> +	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
> +}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
