Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FDCEB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:14:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 879F13CE0F2
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:14:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ABA73C9C7B
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 12:14:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7416D10005FE
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 12:14:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 651121F37E;
 Tue, 20 Jun 2023 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687256079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNtShpL8QvRlVlIuqFWBv8Bvd+qxDGh8wdzyodAmx8Y=;
 b=bFU/4tvwKWpe2qEf/+3vSeED8nFEjYAJokKDtKzS5rE6yUZl/qEGvdhK7PeCJipp8C9KAq
 tZ8r6xdKkGC7yXgdAafLTmLPC3V6Y8CQFO/K6grdBSUHwy5I2jQ98c9k6CwfCRMmOoVY1l
 coetCx0zqKW1xLB2TFhR+idwGy82rVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687256079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNtShpL8QvRlVlIuqFWBv8Bvd+qxDGh8wdzyodAmx8Y=;
 b=tFQqbh/qPhyJCUwFzl3yxzVgSGEe8YOp+SZ6UNop5ezd9arIuD0mzzbRGSUvPk43xZEcIq
 qzuRn0MQ6W/Es8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44D461346D;
 Tue, 20 Jun 2023 10:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2xaZDw98kWTUUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 10:14:39 +0000
Date: Tue, 20 Jun 2023 12:14:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Damien Le Moal <dlemoal@kernel.org>
Message-ID: <20230620101429.GC275381@pevik>
References: <20230608005315.3703446-1-dlemoal@kernel.org>
 <20230608005315.3703446-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230608005315.3703446-2-dlemoal@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] ioprio: use ioprio.h kernel header if it
 exists
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Damien,

thanks for this effort!

> For the ioprio system call test cases, avoid blindly defining the
> IOPRIO_XXX macro internally and instead use the kernel user API header
> file if it exists. Given that the definitions in this header file have
> changed over time, make sure to test for the existence of the macro
> IOPRIO_PRIO_LEVEL macro and define it if it does not exist. Similarly,
> use IOPRIO_NR_LEVELS to define IOPRIO_PRIO_NUM if that macro exists.

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If I'm correct, the only change in v2 is added Linus Walleij's RBT.
nit: it'd be better if he sent it himself.

> ---
>  configure.ac                              |  1 +
>  testcases/kernel/syscalls/ioprio/ioprio.h | 29 +++++++++++++++++------
>  2 files changed, 23 insertions(+), 7 deletions(-)

> diff --git a/configure.ac b/configure.ac
> index 548288310..e4aa2cadf 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -56,6 +56,7 @@ AC_CHECK_HEADERS_ONCE([ \
>      linux/if_ether.h \
>      linux/if_packet.h \
>      linux/io_uring.h \
> +    linux/ioprio.h \
>      linux/keyctl.h \
>      linux/mempolicy.h \
>      linux/module.h \
> diff --git a/testcases/kernel/syscalls/ioprio/ioprio.h b/testcases/kernel/syscalls/ioprio/ioprio.h
> index c74380475..6ca134a54 100644
> --- a/testcases/kernel/syscalls/ioprio/ioprio.h
> +++ b/testcases/kernel/syscalls/ioprio/ioprio.h
FYI the header should be moved to include/lapi/,
but that can be done as a separate effort afterwards (by us LTP developers).

> @@ -6,6 +6,12 @@
>  #ifndef LTP_IOPRIO_H
>  #define LTP_IOPRIO_H

There needs to be
#include "config.h"

(Otherwise header will be never included.)

With this change
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +#ifdef HAVE_LINUX_IOPRIO_H
> +
> +# include <linux/ioprio.h>
> +
> +#else

NOTE: yes, we have policy to include kernel (or libc) headers in LTP LAPI
headers [1], but we usually instead of #else part always check for constants like
this:

#ifdef HAVE_LINUX_IOPRIO_H
# include <linux/ioprio.h>
#endif

#ifndef IOPRIO_CLASS_SHIFT
# define IOPRIO_CLASS_SHIFT	(13)
#endif
...
(Exactly the same way you do for e.g. IOPRIO_NR_LEVELS or IOPRIO_PRIO_LEVEL.)

I'm ok with this variant, because it's simpler (the header was added in
v5.15-rc1) and we can check for enum. But once some constant or enum gets
changed we'd need to handle this.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API#lapi-headers

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
