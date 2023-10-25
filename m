Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00324C25B6B
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 23:45:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 235683CF902
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 01:45:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CD1F3C996B
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:45:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 74E88600712
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:45:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15D401FD5F;
 Wed, 25 Oct 2023 23:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698277540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5dGA9mbTj2Dqf+mkwULRScPN/Dcw2jOGfCwSxvIYiI=;
 b=dsJ9mhew1W8+qapmwsiMimToBhpGEsySjr0mz94lX2IDgd8NsAud2uqU8GEoUMWWbZ9ysW
 GhPUoF5d2LvQXfT5+0fc4BoZGzjJJn9gS25ZbM3SHcJ5EJq6UFw+GvBFn2Ds1CzEipan54
 roOEkHS9gCAg9Zoj7D36NS85DCbWkDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698277540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5dGA9mbTj2Dqf+mkwULRScPN/Dcw2jOGfCwSxvIYiI=;
 b=oRCbhA1E+r8WNtJi/KlHAdb31ZBuOY90tCqIIZs4PWMr0OyrkvLcgXmAJLhP4JsrwVmF87
 tnCDMxYk0ZmMmgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED7F5138E9;
 Wed, 25 Oct 2023 23:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lp0rOKOoOWWLWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 23:45:39 +0000
Date: Thu, 26 Oct 2023 01:45:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231025234538.GA539615@pevik>
References: <1697524491-4749-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697524491-4749-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697524491-4749-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] mkdirat: Remove mkdirat fallback definition
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

Hi Xu,

...
> +++ b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
> @@ -35,7 +35,6 @@
>  #include <string.h>
>  #include <signal.h>
>  #include "test.h"
> -#include "lapi/mkdirat.h"
>  #include "safe_macros.h"

...
> +++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
> @@ -11,7 +11,6 @@

>  #define _GNU_SOURCE
>  #include "tst_test.h"
> -#include "lapi/mkdirat.h"


FYI lapi file was also used in lib/tst_cgroup.c and
testcases/network/nfs/nfs_stress/nfs05_make_tree.c. I fixed it before merge.

Whole patchset merged. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
