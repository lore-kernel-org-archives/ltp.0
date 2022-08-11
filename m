Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D63C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 10:09:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 256A33C965A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 12:09:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F36DA3C0204
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 12:08:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDAED1A0099B
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 12:08:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EE4AC3895C;
 Thu, 11 Aug 2022 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660212536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CyVJN6p3UyOujVFFc0hw5R43B3uztqdMLnDyCbm0NlA=;
 b=hiP51NffHirzW+s+A6WBC6UMAgJlsoAMC1AdL8S9iY+ho1c+wfd8Ga4whRSGoZyz29WmMr
 BDi3O/PEoyK57SvubyE/G3i+WreFcfqth3u1B9t21FzTX2zgD6/orYLIJ1LrGRRcpcXQtO
 RTZq4JkDWsjAmazBqqA6JerV1KzYoQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660212536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CyVJN6p3UyOujVFFc0hw5R43B3uztqdMLnDyCbm0NlA=;
 b=sdUiAiOsGDL13R6iV77WA4uZmyF03L25lmUsXovqpnG5+8pftqAGuhqzsRZBCLYoTy+fXn
 OlzEPl/Sz+x99CCA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BC3152C221;
 Thu, 11 Aug 2022 10:08:56 +0000 (UTC)
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
 <20220722120501.28670-3-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Thu, 11 Aug 2022 10:53:10 +0100
In-reply-to: <20220722120501.28670-3-andrea.cervesato@suse.com>
Message-ID: <87r11nw0qv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/7] Refactor mqns_01 using new LTP API
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

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/containers                         |   3 +-
>  testcases/kernel/containers/mqns/common.h  | 101 +++++++++++
>  testcases/kernel/containers/mqns/mqns_01.c | 193 +++++++--------------
>  3 files changed, 166 insertions(+), 131 deletions(-)
>  create mode 100644 testcases/kernel/containers/mqns/common.h
>
> diff --git a/runtest/containers b/runtest/containers
> index 2637b62fe..863a964ad 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -16,7 +16,8 @@ pidns31 pidns31
>  pidns32 pidns32
>  
>  mqns_01 mqns_01
> -mqns_01_clone mqns_01 -clone
> +mqns_01_clone mqns_01 -m clone
> +mqns_01_unshare mqns_01 -m unshare
>  mqns_02 mqns_02
>  mqns_02_clone mqns_02 -clone
>  mqns_03 mqns_03
> diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/common.h
> new file mode 100644
> index 000000000..92a77b566
> --- /dev/null
> +++ b/testcases/kernel/containers/mqns/common.h
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef MQNS_H
> +#define MQNS_H
> +
> +#include <stdlib.h>
> +#include "lapi/namespaces_constants.h"
> +#include "tst_test.h"
> +#include "tst_safe_posix_ipc.h"
> +
> +enum {
> +	T_CLONE,
> +	T_UNSHARE,
> +	T_NONE,
> +};
> +
> +static int dummy_child1(void *v)
> +{
> +	(void)v;
> +	return 0;
> +}
> +
> +static inline void check_newipc(void)
> +{
> +	int pid, status;
> +
> +	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child1,
>  NULL);

ltp_clone_quick is still part of the old API and only uses clone2. I
think it should be replaced with tst_clone. This may require extending
tst_clone. In fact we probably need a test variant to switch between the
clone2 and clone3 syscalls when using tst_clone.

I'll leave it to you whether you want to try that and rebase this patch
set on it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
