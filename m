Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE751C6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 10:00:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82BA93CDCF1
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 11:00:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63D403CB9CA
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 11:00:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CAFBB1A00E7F
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 11:00:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 082BA21C1A;
 Thu,  2 Mar 2023 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677751210;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fjoM4Ii6DngkTCV3k4fwBkoSL3zFiATMjf6+mvLHTF4=;
 b=2sPZ+1g5BGoFg2vtbKQ6BkPIYOuiDVFoWNm2lnYJLhOz2CuAFxlEw7siMLNk2JzCZZNmvH
 BNXN/q72ra/kGcxWkDM/GJHZgqBp+LoKu25ad9PMSuiw4TQ531C5DN10ezzwkmD5bLCvEX
 6NzGhbbAA2FkcSDvPJaA92+PKNLAZQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677751210;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fjoM4Ii6DngkTCV3k4fwBkoSL3zFiATMjf6+mvLHTF4=;
 b=UoJ8ftXrqQ2qSEcpd3BHc2sXNRFKSJdbqdFiPeMJvrW8q6nIBiuaY6MOpSthNXNR0xa90Y
 5Bj9A5BhZA7PjfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C88B913349;
 Thu,  2 Mar 2023 10:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GkNcL6lzAGTRSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 02 Mar 2023 10:00:09 +0000
Date: Thu, 2 Mar 2023 11:00:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZABzqALt4+Zjqtxq@pevik>
References: <20230228032745.16595-1-wegao@suse.com>
 <20230302014519.31512-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230302014519.31512-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] fsconfig03: SKIP check return value for old
 kernel
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
Cc: kernel-qa@suse.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../kernel/syscalls/fsconfig/fsconfig03.c     | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)

> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> index 7ee37f4ae..9adf06207 100644
> --- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> @@ -41,15 +41,20 @@ static void run(void)
>  	if (pagesize == -1)
>  		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");

> -	for (size_t i = 0; i < 5000; i++) {
> -		/* use same logic in kernel legacy_parse_param function */
> -		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
> +	if ((tst_kvercmp(5, 17, 1)) >= 0) {
I suppose 722d94847de29 (in .tags) change the old behavior (from v5.17-rc1).
Shouldn't be the check against 5.17.0?
if ((tst_kvercmp(5, 17, 0)) >= 0) {


> +		for (size_t i = 0; i < 5000; i++) {
> +			/* use same logic in kernel legacy_parse_param function */
> +			const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;

> -		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize)
> -			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> -		else
> -			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> -					    EINVAL);
> +			if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize)
> +				TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> +			else
> +				TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> +						EINVAL);
> +		}
> +	} else {
> +		for (size_t i = 0; i < 5000; i++)
Repeating the loop again. Wouldn't be more readable moving the if clause to
separate function and doing if/else inside of for loop?

Also "\x00" might be in #define (used 3 times).

Kind regards,
Petr

> +			fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0);
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
