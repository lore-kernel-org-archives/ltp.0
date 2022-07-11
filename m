Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D1DC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 15:52:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 632FD3CA755
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 17:52:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD5443C986F
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 17:51:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 36F04100064B
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 17:51:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B681203CA;
 Mon, 11 Jul 2022 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657554718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9YUG2yGBPurESP6rHuRGzj8VZgOF8/gD2Km51Q7uHw0=;
 b=EYQMsjd9LhU7SEqMFsYHlSXER476GjHLYKDXDcmXYPp+4zB3EPHHWnFLCnMHmIq9KLO3H+
 RdpTSUvWKdgfRLynv/a8vDAdHio5+3pfrm1q5nh4Mm2VYHaXdHOuu+gs0e5fNsNk08aXdM
 eIVABEKAR5Eq/hFxGiAcR1flVXsDbSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657554718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9YUG2yGBPurESP6rHuRGzj8VZgOF8/gD2Km51Q7uHw0=;
 b=Kz6vs8JMWQe0ZOrMO+0Rsij1MZ75elG2/C3/mTjmsTeejJTLits/baAaFZmNygz/Vsmz6B
 miNTNCmjK+csCQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B03413322;
 Mon, 11 Jul 2022 15:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EgGhBB5HzGJ3bAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 15:51:58 +0000
Date: Mon, 11 Jul 2022 17:51:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YsxHHDw0H1lZTFMN@pevik>
References: <20220708170634.842-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220708170634.842-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fstat02.c: simplify using TST_EXP_*() macros
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

Hi Avinesh,


LGTM, thanks!
Minor comments below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
...
> +++ b/testcases/kernel/syscalls/fstat/fstat02.c
...
> -#include <errno.h>
> -#include <unistd.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
>  #include "tst_test.h"
> -#include "tst_safe_macros.h"

nit: obviously works without all these headers, but <sys/stat.h> is
needed (fstat) but included by tst_test.h

> +
> +/*\ [Description]
> + *

This is wrong, causes docparse not being formatted. It must be:
/*\
 * [Description]

(can be fixed before merge)

>   * Tests if fstat() returns correctly and reports correct file information
>   * using the stat structure.
>   */
...
> -	tst_res(TPASS, "fstat() reported correct values.");
> +	TST_EXP_PASS(fstat(fildes, &stat_buf));
> +	TST_EXP_EQ_LI(stat_buf.st_uid, user_id);
> +	TST_EXP_EQ_LI(stat_buf.st_gid, group_id);
nit: At least st_uid and st_gid are unsigned, thus maybe TST_EXP_EQ_LU?
> +	TST_EXP_EQ_LI(stat_buf.st_size, FILE_SIZE);
> +	TST_EXP_EQ_LI(stat_buf.st_mode & 0777, FILE_MODE);
> +	TST_EXP_EQ_LI(stat_buf.st_nlink, NLINK);
>  }

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
