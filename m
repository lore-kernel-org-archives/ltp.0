Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21DAC5DF81
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 04:38:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 923A33D20BA
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 06:38:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A87FC3C62EA
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:38:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9EBE21A00A27
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:38:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FAEB86C64;
 Tue, 25 Aug 2026 04:38:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C84513331;
 Tue, 25 Aug 2026 04:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pqsODTocjWrPMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Aug 2026 04:38:18 +0000
Date: Tue, 25 Aug 2026 06:38:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260825043816.GA22725@pevik>
References: <20260824103832.4058-1-linuxtestproject.agent@gmail.com>
 <20260824135722.200152-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260824135722.200152-1-avinesh.kumar@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5FAEB86C64
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] landlock04: Fix false TFAIL in
 _test_truncate() deny path
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

Thanks for the fix, merged!

I'm sorry for introducing the regression (I tested whole landlock part, but
obviously wrongly when this one slipped in).
...
>  	TST_EXP_PASS_OR_FAIL(truncate(FILE_TRUNCATE, 10), exp_err);
> -	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY, PERM_MODE), exp_err);
> +
> +	if (!exp_err) {
> +		fd = SAFE_OPEN(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
> +	} else {
> +		fd = open(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
> +		if (fd == -1 && errno != EACCES)
> +			 tst_res(TFAIL | TERRNO, "open(%s, O_WRONLY) failed unexpectedly", FILE_TRUNCATE);

nit: there still could have been TST_EXP_FD_OR_FAIL() for else part:

fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY, PERM_MODE), exp_err);

I personally prefer these shortening macros, but maybe they aren't that much
readable when others don't use it. Therefore merged as is.

Kind regards,
Petr

> +	}
>  	if (fd != -1) {
>  		TST_EXP_PASS_OR_FAIL(ftruncate(fd, 10), exp_err);
>  		SAFE_CLOSE(fd);
> @@ -262,7 +269,7 @@ static void _test_truncate(const int exp_err)

>  	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
>  	if (fd != -1)
> -		SAFE_CLOSE(TST_RET);
> +		SAFE_CLOSE(fd);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
