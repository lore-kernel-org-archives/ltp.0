Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45B5C46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 19:14:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 851B23CCB33
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 20:14:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACF823CB584
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 20:14:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 341BD600856
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 20:14:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4662C2105C;
 Tue, 10 Jan 2023 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673378056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lkgGrXy1lgdgbKSmtkx7BDt89gePG+UjYqKWDON6Q+0=;
 b=ZAj7h4u9VNVm4fO+nRsZR6VGN5UCClZvN0aR36BffOVqXJ14QmAmMPwSAP+6PyPs8to9KR
 as6f5usv3Vw0WwTuL9v4YNvZRd4otEnScJM3s2nGYZR8yHt7Cn33UftTtIHruq1TDx92gt
 /+n+AItGQWyXtMhb4r2iDs0xMEo6Jug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673378056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lkgGrXy1lgdgbKSmtkx7BDt89gePG+UjYqKWDON6Q+0=;
 b=VaeOYLw8J2aU6zR7xuYp89HIT1O3orA53MZbsTg5C4/ysOwlq3zT5xuX4pvUn1L5Lx4qqe
 R2OlBF8dy28fewAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F33A51358A;
 Tue, 10 Jan 2023 19:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D6VpOQe5vWNjcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 Jan 2023 19:14:15 +0000
Date: Tue, 10 Jan 2023 20:14:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Y725Bp/EcVM3U4Cu@pevik>
References: <20230110141616.1449-1-rpalethorpe@suse.com>
 <20230110141616.1449-2-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230110141616.1449-2-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fcntl{34,
 36}: Always use 64-bit flock struct to avoid EINVAL
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
Cc: Khem Raj <raj.khem@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

[ Cc Khem Raj ]

> Recently we switched to using struct fcntl with _FILE_OFFSET_BITS
> instead of the transitional type fcntl64 which has been removed from
> some libcs.

Do you mean b0320456cd ("testcases: Fix largefile support") ?
Because this commit really broke both 32 bit emulation
+ (obviously) LTP on native 32bit.

Please add before merge:

Fixes: b0320456c ("testcases: Fix largefile support")

(although this needs also previous fix)

> This broke testing with 32-bit executables on a 64bit kernel when
> FILE_OFFSET_BITS was not set to 64. Because the fcntl64 syscall does
> not exist on 64 bit kernels.

> The reason we are making the syscall directly is because of old
> glibc's which don't do any conversion.

> So we now do a conversion unconditionally and call fcntl64 if the
> kernel is 32-bit.
+1.

> When we no longer support old glibcs we can drop this compat function
> altogether.
I wonder which glibc these are. And how about musl?

Anyway, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Few unimportant notes below.
...

> +++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
> @@ -1,38 +1,71 @@
>  #ifndef FCNTL_COMMON_H__
>  #define FCNTL_COMMON_H__

> +#include <inttypes.h>
> +
> +#include "tst_test.h"
> +#include "tst_kernel.h"
> +
>  #include "lapi/syscalls.h"
>  #include "lapi/abisize.h"
> +#include "lapi/fcntl.h"
> +
> +struct my_flock64 {
> +	int16_t l_type;
> +	int16_t l_whence;
> +	int64_t l_start;
> +	int64_t l_len;
> +	int32_t l_pid;
> +#if defined(__sparc__)
nit: #ifdef __sparc__

Well, we still support 32bit sparc (you did support for atomic in
include/tst_atomic.h), but IMHO it's dead (I might ask if John Paul Adrian
Glaubitz knows about anybody using LTP for testing on sparc).  But as this is in
kernel struct, there is no harm to keep it for LTP as well.

> +	int16_t padding;
> +#endif
> +};

...

> +static inline int fcntl_compat(const char *file, const int line, const char *cmd_name,
> +			       int fd, int cmd, struct flock *lck)
>  {
> -	int ret = tst_syscall(__NR_fcntl64, fd, cmd, lck);
> -	if (ret == -1)
> -		tst_brk(TBROK|TERRNO, "fcntl64");
> +	struct my_flock64 l64 = {
> +		.l_type = lck->l_type,
> +		.l_whence = lck->l_whence,
> +		.l_start = lck->l_start,
> +		.l_len = lck->l_len,
> +		.l_pid = lck->l_pid,
> +	};
> +	const long sysno = tst_kernel_bits() > 32 ? __NR_fcntl : __NR_fcntl64;
> +	const int ret = tst_syscall(sysno, fd, cmd, &l64);
> +
> +	lck->l_type = l64.l_type;
> +	lck->l_whence = l64.l_whence;
> +	lck->l_start = l64.l_start;
> +	lck->l_len = l64.l_len;
> +	lck->l_pid = l64.l_pid;
> +
> +	if (ret != -1)
> +		return ret;
> +
> +	tst_brk_(file, line, TBROK | TERRNO,
> +		 "%s(%d, %s, { %d, %d, %"PRId64", %"PRId64", %d })",
> +		 tst_kernel_bits() > 32 ? "fcntl" : "fcntl64",
nit: maybe cache tst_kernel_bits() to variable?

Kind regards,
Petr

> +		 fd,
> +		 cmd_name,
> +		 l64.l_type, l64.l_whence, l64.l_start, l64.l_len, l64.l_pid);
> +
>  	return ret;
>  }
> -#endif
> +
> +#define FCNTL_COMPAT(fd, cmd, flock) \
> +	fcntl_compat(__FILE__, __LINE__, #cmd, fd, cmd, flock)

>  #endif /* FCNTL_COMMON_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
