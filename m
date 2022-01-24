Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0003C433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 20:48:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 111303C9292
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 21:48:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B13123C2911
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 21:48:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 021B21400518
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 21:48:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F381F1F380;
 Mon, 24 Jan 2022 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643057290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8rUs0PpSkxwtOMECw23ldhV6gEpBkLJDvdynQ9Ry7kY=;
 b=l/msyb+UBZ1JdZcsMJ/Z3FLO2vq/leDejqzrp/yjOhE6/Bzy01Nzidzq4emXRT9FWhNUHa
 YBumUlVFUEVbphUysyyXIhG9NdZElr2ofL55WtnR59WCBWVG/EkWX4NdbY0NwygYt8hruM
 DrFtnQLrOGEqnLiMoNCYjqYtEsO42VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643057290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8rUs0PpSkxwtOMECw23ldhV6gEpBkLJDvdynQ9Ry7kY=;
 b=okm7yI0YbjCGY5THbOqkaJETZXJbhLpDIRpqIPmI/FbVOcNFH5CdLJhD6sIGEjflHsLzK1
 +1FjqvZbGkYXmnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A879713ADB;
 Mon, 24 Jan 2022 20:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U+yrIokQ72GdNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 20:48:09 +0000
Date: Mon, 24 Jan 2022 21:48:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Ye8QiIUfmKeUrSmg@pevik>
References: <20220124150533.25935-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220124150533.25935-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Replace ltp_syscall with tst_syscall
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

Hi Andrea,

> diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
> index d7daf8ad0..77391dbdf 100755
> --- a/include/lapi/syscalls/regen.sh
> +++ b/include/lapi/syscalls/regen.sh
> @@ -35,21 +35,17 @@ cat << EOF > "${output_pid}"
>  #include <asm/unistd.h>
>  #include "cleanup.c"

> -#define ltp_syscall(NR, ...) ({ \\
> -	int __ret; \\
> -	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
> -		errno = ENOSYS; \\
> -		__ret = -1; \\
> -	} else { \\
> -		__ret = syscall(NR, ##__VA_ARGS__); \\
> -	} \\
> -	if (__ret == -1 && errno == ENOSYS) { \\
> -		tst_brkm(TCONF, CLEANUP, \\
> -			"syscall(%d) " #NR " not supported on your arch", \\
> -			NR); \\
> -	} \\
> -	__ret; \\
> +#ifdef TST_TEST_H__
> +#define TST_SYSCALL_BRK__(NR) ({ \
> +	tst_brk(TCONF, \
> +		"syscall(%d) " #NR " not supported on your arch", NR); \
> +})
> +#else
> +#define TST_SYSCALL_BRK__(NR) ({ \
> +	tst_brkm(TCONF, CLEANUP, \
> +		"syscall(%d) " #NR " not supported on your arch", NR); \
>  })
> +#endif
I miss this in my review. Cyril meant to put double backslashes also
here in regen.sh (as it was in original version). The result is then:

#ifdef TST_TEST_H__
#define TST_SYSCALL_BRK__(NR) ({ 	tst_brk(TCONF, 		"syscall(%d) " #NR " not supported on your arch", NR); })
#else
#define TST_SYSCALL_BRK__(NR) ({ 	tst_brkm(TCONF, CLEANUP, 		"syscall(%d) " #NR " not supported on your arch", NR); })
#endif

instead of:

#ifdef TST_TEST_H__
#define TST_SYSCALL_BRK__(NR) ({ \
	tst_brk(TCONF, \
		"syscall(%d) " #NR " not supported on your arch", NR); \
})
#else
#define TST_SYSCALL_BRK__(NR) ({ \
	tst_brkm(TCONF, CLEANUP, \
		"syscall(%d) " #NR " not supported on your arch", NR); \
})
#endif

Merging it with this fix.

Thanks a lot!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
