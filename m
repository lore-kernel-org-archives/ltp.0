Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CD7C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 13:04:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEB723C1BBF
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 14:04:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2191A3C1B99
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 14:04:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C1482009E0
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 14:04:27 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B1E7A1F37C
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646658266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96PvQKQL7Y0futYyqDR89qDQ+Ix63Shkgrcafresybo=;
 b=eVj0wXFI2fepOKIPUOyuWJXK2ZquLG8nZrFA3qL7h8AKBaCUufLGDaPLL58HeVXUslqw7i
 QPdJtf/+Ub0An/4e/eFgEYnAa9q3MMf/HHWxCYIppBGE/mrO3Di3HJhGBdTsuZpC1fvRNJ
 ooB7WOfWS5Ie0RBu43kR7LGiPIafXUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646658266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96PvQKQL7Y0futYyqDR89qDQ+Ix63Shkgrcafresybo=;
 b=4mcnoh4sqnqKnruHxJDEyVgpwDEuHBpUe1NwljyCIhxclJ2iAtL4jXpVNA+mZXY0GFqG9G
 UDtORCNq5oLm/6DQ==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 820BBA3B89;
 Mon,  7 Mar 2022 13:04:26 +0000 (UTC)
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-5-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 07 Mar 2022 13:04:20 +0000
In-reply-to: <20220303145032.21493-5-chrubis@suse.cz>
Message-ID: <871qzdncbp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] mem/ksm06: SPDX + docparse comment
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

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  testcases/kernel/mem/ksm/ksm06.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
> index 0f5e4b05d..61507b2aa 100644
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -1,24 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (C) 2013-2017  Red Hat, Inc.
> + */
> +/*\
> + * [Description]
>   *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> + * The case is designed to test sysfs boolean knob
> + * /sys/kernel/mm/ksm/merge_across_nodes.
>   *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - */
> -
> -/*
> - * The case is designed to test new sysfs boolean knob
> - * /sys/kernel/mm/ksm/merge_across_nodes, which was introduced by
> - * commit 90bd6fd31c8097ee (ksm: allow trees per NUMA node).
> - * when merge_across_nodes is set to zero only pages from the same
> + * When merge_across_nodes is set to zero only pages from the same
>   * node are merged, otherwise pages from all nodes can be merged
>   * together.
> + *
> + * Introduced in commit:
> + *
> + *  commit 90bd6fd31c8097ee4ddcb74b7e08363134863de5
> + *   Author: Petr Holasek <pholasek@redhat.com>
> + *   Date:   Fri Feb 22 16:35:00 2013 -0800
> + *
> + *   ksm: allow trees per NUMA node
>   */
>  
>  #include "config.h"
> -- 
> 2.34.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
