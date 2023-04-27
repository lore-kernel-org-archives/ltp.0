Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275D4C77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 09:35:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01CFE3CD9FC
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 11:35:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89E713CBA98
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 11:35:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 951771A003E7
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 11:35:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8FC1821A43;
 Thu, 27 Apr 2023 09:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682588122;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwDAJ7NRD3aAodZA4n3+IfjnM6jtR8/a1ENzcjR2WBo=;
 b=NTJ+ZyVHMGiKXeUzExvcef2bkPG0C/nbRVaJpWjZbTLo/QLTWHVSlI4yIyFgVCOz7WPjuV
 LW9ZuJ/f+RO7GZxoYGfUqJpavZ4JUfhAlH9sreEZ5ySqVnw79OPm9jyw3MAk/+3La9Ihmf
 2lyytJjzkHlA9gaWb7Bvv1BCO/5cbXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682588122;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwDAJ7NRD3aAodZA4n3+IfjnM6jtR8/a1ENzcjR2WBo=;
 b=WQTrhcCVwp7xnb7e0ELTbHckVY0qy1TcG/tOB6f6ilKceEPelb77CkFKKP4pxCsy+C237U
 RrkmkREgIucLb2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14C73138F9;
 Thu, 27 Apr 2023 09:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4Js/AdpBSmTUdQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 27 Apr 2023 09:35:22 +0000
Date: Thu, 27 Apr 2023 11:35:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230427093531.GA3127067@pevik>
References: <20230427002905.1354207-1-edliaw@google.com>
 <20230427002905.1354207-2-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230427002905.1354207-2-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] fcntl{34,
 36}: Only use fcntl64 with 32bit abi
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
Cc: kernel-team@android.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> Fixes: 7643115aaacb ("fcntl{34,36}: Always use 64-bit flock struct to avoid EINVAL")

> On Android arm64, tst_kernel_bits is disregarding the abi, so compiling
What exactly do you mean by "disregarding the abi"? Why is aarch64 different?

> with the 32bit abi is calling the fcntl syscall instead of fcntl64.  The
> fcntl syscall is not compatible with the flock64 struct being passed
> (this doesn't seem to be the case with x86_64, only with arm64).

> This changes it to only use the fcntl64 compat syscall with the 32bit
> abi.

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  testcases/kernel/syscalls/fcntl/fcntl_common.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
> index 5c130a784..485a31367 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl_common.h
> +++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
> @@ -10,6 +10,11 @@
>  #include "lapi/abisize.h"
>  #include "lapi/fcntl.h"

> +#if defined(TST_ABI64)
> +#define FCNTL_COMPAT(fd, cmd, flock) \
> +	SAFE_FCNTL(fd, cmd, flock)
> +
> +#else
>  struct my_flock64 {
>  	int16_t l_type;
>  	int16_t l_whence;
> @@ -43,8 +48,8 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd
>  		.l_len = lck->l_len,
>  		.l_pid = lck->l_pid,
>  	};
> -	const int sysno = tst_kernel_bits() > 32 ? __NR_fcntl : __NR_fcntl64;
> -	const int ret = tst_syscall(sysno, fd, cmd, &l64);
> +
> +	const int ret = tst_syscall(__NR_fcntl64, fd, cmd, &l64);

>  	lck->l_type = l64.l_type;
>  	lck->l_whence = l64.l_whence;
> @@ -57,7 +62,7 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd

>  	tst_brk_(file, line, TBROK | TERRNO,
>  		 "%s(%d, %s, { %d, %d, %"PRId64", %"PRId64", %d })",
> -		 tst_kernel_bits() > 32 ? "fcntl" : "fcntl64",
> +		 "fcntl64",

Once we removed tst_kernel_bits(), there is no need to pass "fcntl64" as %s,
thus it should be:

		 "fcntl64(%d, %s, { %d, %d, %"PRId64", %"PRId64", %d })",
		 fd, cmd_name, l64.l_type, l64.l_whence, l64.l_start, l64.l_len,
		 l64.l_pid);

Otherwise LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  		 fd,
>  		 cmd_name,
>  		 l64.l_type, l64.l_whence, l64.l_start, l64.l_len, l64.l_pid);
> @@ -67,5 +72,6 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd

>  #define FCNTL_COMPAT(fd, cmd, flock) \
>  	fcntl_compat(__FILE__, __LINE__, #cmd, fd, cmd, flock)
> +#endif

>  #endif /* FCNTL_COMMON_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
