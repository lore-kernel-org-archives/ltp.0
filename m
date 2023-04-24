Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270BEC77B61
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 18:39:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 812333CE585
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 20:39:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D4233CBC8E
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 20:39:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79E5460064B
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 20:39:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB1241F854;
 Mon, 24 Apr 2023 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682361567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haN6M/pLzpcU9PLccsdUE2ZfpW2SBQ+iKCQQGBmKBXE=;
 b=En8RNCuuOrQzK9Njt4o1PDcH3EsTExf2Mu7iCxl12FTnF00/R0qS32RGlST2V++u0bNlQy
 nhtj41sk0dwrNaYLGbr4wFJzsmFPH9itgNykhMzcLGrF9wV7bVs8Fpn1ahRP/hKeRGe+qQ
 mQvusM9Ki6nFksuzyaBT0m/dKDZSPx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682361567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haN6M/pLzpcU9PLccsdUE2ZfpW2SBQ+iKCQQGBmKBXE=;
 b=2RYhVofTPY2NOofJwVrckY5RwFz54ckkWn3tflcrGnzKz6HKF7gIkajG/gyvnidlJRgtfL
 Xtqzx4NDmgOizMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8662E13780;
 Mon, 24 Apr 2023 18:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DJ4YHt/MRmRhUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 18:39:27 +0000
Date: Mon, 24 Apr 2023 20:39:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230424183936.GA2855209@pevik>
References: <20230424175934.2847088-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230424175934.2847088-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfslock01: Add GPL-2.0-or-later license
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> C sources and headers in nfslock01 directory don't have a license.
> Add GPL 2+.

Hm, there should probably be copyright added as well.

Kind regards,
Petr

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/nfs/nfslock01/nfs_flock.c      | 1 +
>  testcases/network/nfs/nfslock01/nfs_flock.h      | 2 ++
>  testcases/network/nfs/nfslock01/nfs_flock_dgen.c | 1 +
>  testcases/network/nfs/nfslock01/nfs_flock_func.c | 2 ++
>  4 files changed, 6 insertions(+)

> diff --git a/testcases/network/nfs/nfslock01/nfs_flock.c b/testcases/network/nfs/nfslock01/nfs_flock.c
> index 92acceee9..5aba3340a 100644
> --- a/testcases/network/nfs/nfslock01/nfs_flock.c
> +++ b/testcases/network/nfs/nfslock01/nfs_flock.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Program for testing file locking. The original data file consists of
>   * characters from 'A' to 'Z'. The data file after running this program
> diff --git a/testcases/network/nfs/nfslock01/nfs_flock.h b/testcases/network/nfs/nfslock01/nfs_flock.h
> index 09e3845f4..1cf7f45a3 100644
> --- a/testcases/network/nfs/nfslock01/nfs_flock.h
> +++ b/testcases/network/nfs/nfslock01/nfs_flock.h
> @@ -1,3 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
>  #include <stdio.h>
>  #include <sys/stat.h>
>  #include <errno.h>
> diff --git a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
> index 39abc549f..19acbd743 100644
> --- a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
> +++ b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * This program generates data for testing file locking
>   */
> diff --git a/testcases/network/nfs/nfslock01/nfs_flock_func.c b/testcases/network/nfs/nfslock01/nfs_flock_func.c
> index 811136188..180338c57 100644
> --- a/testcases/network/nfs/nfslock01/nfs_flock_func.c
> +++ b/testcases/network/nfs/nfslock01/nfs_flock_func.c
> @@ -1,3 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
>  #include <stdlib.h>
>  #include <unistd.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
