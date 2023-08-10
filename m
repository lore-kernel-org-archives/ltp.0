Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E350C001E0
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 14:28:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FE223CD089
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 16:28:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BECC3C4BC7
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 16:28:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 54ACA600D32
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 16:28:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7D4A1F45B;
 Thu, 10 Aug 2023 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691677689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qlrkk48OYIDN3xOXiK4AEKBsU6XBZCGyKD03ifBQl0=;
 b=Wd5tk/SatoL7U7MetNnsxshem9EmRBDv5XKETCuCHYSSAcskmwLmf8tWhby2d89Wog0zN6
 rN+Ug2IBWcpS0Tje12frzJ/xqka7YmGTBSwD1GLXeRpkTaMy8QLeCcGni4TwXPLCa0VbK1
 6zLUFHdmMo2zy+wA+xr/KKIIDsAw5Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691677689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qlrkk48OYIDN3xOXiK4AEKBsU6XBZCGyKD03ifBQl0=;
 b=YukgptxG4oSpiaGl69vK5dl5J/D1elcxrpwl76BQhZ6j3FUTuzN7HyQ5ago1Sq6yAXFHxJ
 snFh2MlHT76PnyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 938B5138E0;
 Thu, 10 Aug 2023 14:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 69JsI/nz1GSABQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Aug 2023 14:28:09 +0000
Date: Thu, 10 Aug 2023 16:29:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZNT0NesFgNyVjkv8@yuki>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] include/faccessat.h: Add header file
 faccessat.h
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  include/lapi/faccessat.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 include/lapi/faccessat.h
> 
> diff --git a/include/lapi/faccessat.h b/include/lapi/faccessat.h
> new file mode 100644
> index 000000000..f3318fd7a
> --- /dev/null
> +++ b/include/lapi/faccessat.h
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
> + * Copyright (c) Linux Test Project, 2003-2023
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef FACCESSAT_H
> +#define FACCESSAT_H
> +
> +#include <sys/types.h>
> +#include "lapi/syscalls.h"
> +
> +#ifndef HAVE_FACCESSAT
> +int faccessat(int dirfd, const char *pathname, int mode, int flags)
> +{
> +	return tst_syscall(__NR_faccessat, dirfd, pathname, mode, flags);
> +}
> +#endif

I guess that this will not work without:

diff --git a/configure.ac b/configure.ac
index e4aa2cadf..7beca3d9f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -92,6 +92,7 @@ AC_CHECK_FUNCS_ONCE([ \
     epoll_pwait \
     epoll_pwait2 \
     execveat \
+    faccessat \
     fallocate \
     fchownat \
     fsconfig \


However looking at man faccessat, it was added into glibc 2.10 and since
the oldest glibc we support is 2.17 (see
doc/supported-kernel-libc-versions.txt) we can as well completely drop
this fallback definition.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
