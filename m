Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95039C433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 11:09:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8009A3C9520
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 12:09:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90F2A3C902B
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 12:09:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A602C200914
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 12:09:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C848421129;
 Thu, 13 Jan 2022 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642072162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8+McMR51kgt3GN9ARlTPdrJhogUY3XCcMWnNABrqFQ=;
 b=srUQ/tr4xiJo99empWeQlSMEUIAph/kkt4zMJzQboMLHzCo/GPayzRvtuF9mvj+XMnN/9D
 nC0dVIrhlQQECxV6ohl++N5Z3QkiAkTOhGgzVT6hihkgPg4+3DuIlPIRg0nFtedepDHG21
 pNie2Y2UX9qc6VO8WrqYdQrDVFakwk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642072162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8+McMR51kgt3GN9ARlTPdrJhogUY3XCcMWnNABrqFQ=;
 b=qJ3h9Qs94EuMyuxWFen+oUIlsexe1AemXtqV4F4MbjktKegGPNqQio4QLRN550ID7hf20g
 AQpxHem8m1nDRaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8D581330C;
 Thu, 13 Jan 2022 11:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vi14J2II4GE4JAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Jan 2022 11:09:22 +0000
Date: Thu, 13 Jan 2022 12:09:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YeAIYcZsqi9nBwFp@pevik>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641881435-2351-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/5] lib: Introduce KCONFIG_SKIP_CHECK
 environment variable
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

> This environment variable is designed to add kernel config check functionality
> switch. So we can skip kconfig check completely and it is useful especially
> for the embedded platforms that they don't have kernel config.

very nit: I'd write it a bit simpler. Maybe:
Add environment variable to disable kernel config check functionality.
It is useful for embedded platforms which don't have kernel config installed.

> +++ b/doc/user-guide.txt
> @@ -10,6 +10,7 @@ For running LTP network tests see `testcases/network/README.md`.
>  |==============================================================================
>  | 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
>                            the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
> +| 'KCONFIG_SKIP_CHECK'  | Skip kernel config check, the default is empty (don't skip).
s/empty/not set/ ?
maybe: Skip kernel config check if variable set (not set by default).

...

> +static int kconfig_skip_check(void)
> +{
> +	char *skipped = getenv("KCONFIG_SKIP_CHECK");
> +
> +	if (skipped)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static const char *kconfig_path(char *path_buf, size_t path_buf_len)
>  {
>  	const char *path = getenv("KCONFIG_PATH");
> @@ -485,6 +495,11 @@ int tst_kconfig_check(const char *const kconfigs[])
>  	unsigned int i, var_cnt;
>  	int ret = 0;

> +	if (kconfig_skip_check()) {
> +		tst_res(TINFO, "Skipping kernel config check as requested");
I suppose you expect tests / library use kconfig_skip_check() in the future for
some detection. If not I'd move tst_res(TINFO, ...) into kconfig_skip_check().

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
