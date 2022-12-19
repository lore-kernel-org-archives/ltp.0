Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00637C4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 09:37:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DA3F3CBAD3
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 10:37:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C5EC3C8765
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 10:37:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE3AC200917
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 10:37:34 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 00C8E5FF5E
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 09:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671442654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IFmzCUEfyM1n7emyldI8FnsIJWIgIWLeD5HLJeOC7ms=;
 b=FGMRJa74mXmSfnKcQafTQRSAYqjg9TBUpf3q+yrnAcQVVD+edzvUqIjA1GEDxe0fUgbVSN
 UA5/g5lMEx1tjsgheGiGYYT84qwDuteJ5d4unGWYwC78n2NHOacHZp+Xzq33kPF9aiEI0F
 2TYhziHxwIoDEi9CnQrQbmAp4Wn/AYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671442654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IFmzCUEfyM1n7emyldI8FnsIJWIgIWLeD5HLJeOC7ms=;
 b=PTnB7JEndsuJTPzIDxVXndMkZm59Y+Byd+Mq10l+VB7fRN1cwCSv9nErFHllvNmvWrTsoI
 n8PqYq+G+X5ASGCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CCABF2D1DB;
 Mon, 19 Dec 2022 09:37:33 +0000 (UTC)
References: <20221216170922.21752-1-mdoucha@suse.cz>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 19 Dec 2022 09:30:00 +0000
Organization: Linux Private Site
In-reply-to: <20221216170922.21752-1-mdoucha@suse.cz>
Message-ID: <87r0wvu42q.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test for CVE 2022-4378
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

Martin Doucha <mdoucha@suse.cz> writes:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  runtest/cve                   |   1 +
>  testcases/cve/.gitignore      |   1 +
>  testcases/cve/cve-2022-4378.c | 108 ++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>  create mode 100644 testcases/cve/cve-2022-4378.c
>
> diff --git a/runtest/cve b/runtest/cve
> index fd0305aa3..1ba63c2a7 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -76,3 +76,4 @@ cve-2022-0847 dirtypipe
>  cve-2022-2590 dirtyc0w_shmem
>  # Tests below may cause kernel memory leak
>  cve-2020-25704 perf_event_open03
> +cve-2022-4378 cve-2022-4378
> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
> index eb0a8b37d..90e8b191c 100644
> --- a/testcases/cve/.gitignore
> +++ b/testcases/cve/.gitignore
> @@ -10,4 +10,5 @@ stack_clash
>  cve-2017-17052
>  cve-2017-16939
>  cve-2017-17053
> +cve-2022-4378
>  icmp_rate_limit01
> diff --git a/testcases/cve/cve-2022-4378.c b/testcases/cve/cve-2022-4378.c
> new file mode 100644
> index 000000000..e1c5df325
> --- /dev/null
> +++ b/testcases/cve/cve-2022-4378.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC <mdoucha@suse.cz>
> + */
> +
> +/*\
> + * CVE 2022-4378
> + *
> + * Check that writing several pages worth of whitespace into /proc/sys files
> + * does not cause kernel stack overflow. Kernel bug fixed in:
> + *
> + * commit bce9332220bd677d83b19d21502776ad555a0e73
> + * Author: Linus Torvalds <torvalds@linux-foundation.org>
> + * Date:   Mon Dec 5 12:09:06 2022 -0800
> + *
> + * proc: proc_skip_spaces() shouldn't think it is working on C strings
> + */

Haha, OK, merged with minor fix to null terminate tags array (detected
by make check).

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
