Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BEFEB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 08:28:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60F193CC31E
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 10:28:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C19DC3CC30F
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:28:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 592381A00212
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:28:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 418292187F;
 Wed, 28 Jun 2023 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687940908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3q+os3KoT0MNbd6fJ5DA1WFEi3LZwZFSXwRrpsw/Ny8=;
 b=QQHi+UD0nGo1Dee2+p3OMZp4CZswUUgc5PD92Ew/B7Pk0ZyR5IUu+elePQ3JWFOW4xJIRZ
 aZ7FN+gdZ36w394VhCHIhjJ9Yz/+/AmXRWXRFayBguU/zAY9DdoW/OnIYWVzN1FqFFW5K5
 jdGIflrQVQSlz/nwHG0LdE/BJ1pBHhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687940908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3q+os3KoT0MNbd6fJ5DA1WFEi3LZwZFSXwRrpsw/Ny8=;
 b=T7rBS8XmFVBc0i6+d/Tt+Iw6NVHfuRZp68672cIsNjEZJfNMRnP8/UCAVB0/gH1i59Vx61
 CT3XoiBC60Uj9qDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1676D138E8;
 Wed, 28 Jun 2023 08:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BDDzAyzvm2R0WQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 08:28:28 +0000
Date: Wed, 28 Jun 2023 10:28:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230628082826.GA115947@pevik>
References: <20230628081831.123189-1-pvorel@suse.cz>
 <20230628081831.123189-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230628081831.123189-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fsstress/global.h: Include lapi/fcntl.h
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
Cc: NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> To avoid potential problems with different O_DIRECT values across archs.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/fs/fsstress/global.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/fs/fsstress/global.h b/testcases/kernel/fs/fsstress/global.h
> index 4ec382426..863fff263 100644
> --- a/testcases/kernel/fs/fsstress/global.h
> +++ b/testcases/kernel/fs/fsstress/global.h
> @@ -50,7 +50,6 @@
>  #include <sys/ioctl.h>
>  #include <sys/wait.h>
>  #include <sys/types.h>
> -#include <fcntl.h>
>  #include <stdlib.h>
>  #include <dirent.h>
>  #include <errno.h>
> @@ -58,6 +57,7 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
> +#include "lapi/fcntl.h"

>  #ifndef O_DIRECT
>  #define O_DIRECT 040000

I forget to amend. This fallback definition should have been removed.
But maybe we should put _GNU_SOURCE definition into the header.

Kind regards,
Petr

+++ testcases/kernel/fs/fsstress/global.h
@@ -59,8 +59,4 @@
 #include <unistd.h>
 #include "lapi/fcntl.h"
 
-#ifndef O_DIRECT
-#define O_DIRECT 040000
-#endif
-
 #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
