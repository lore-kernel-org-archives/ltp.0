Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9F3EB64DC
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 04:58:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F10EB3CC1F9
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 06:57:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43FDF3CC059
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 06:57:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 33DB4200040
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 06:57:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A7531F383;
 Mon,  3 Jul 2023 04:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688360261;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1qtos5QWjn5XvyB0jI+9PbC23skK0y4NfDTO9AoxAPs=;
 b=HdzxbdHbT/kCcTYPXokGfny6oXoGMN8Vx9MAuuPrKplnYcuEJ7HOPWOkmfS/mpg05JnRpD
 hYcgkM2rNstVUM3SlSEcI3JETdEkFGajo3vfCPeuhbEY9mLpDOvXtFB7a7iUcsVgWEkZzk
 8QRhcs5uun6FyCpPSJ36Uvre0VLrUtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688360261;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1qtos5QWjn5XvyB0jI+9PbC23skK0y4NfDTO9AoxAPs=;
 b=UCH08oNkyTuIIG7zblZHZjdm4A1Ks1K8ulQ6cQQdAZ+zll0cFXu8Z+ZRtElnZCF2gJAbMg
 riE6BW1OUSk8zeCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3128013276;
 Mon,  3 Jul 2023 04:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zgcZC0VVomThEwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jul 2023 04:57:41 +0000
Date: Mon, 3 Jul 2023 06:57:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230703045739.GB363557@pevik>
References: <1688352041-4945-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1688352041-4945-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1688352041-4945-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/geteuid02: Convert into new api
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

again, wrong formatting:
geteuid02.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
geteuid02.c:20: ERROR: space required after that ',' (ctx:VxV)
geteuid02.c:22: ERROR: space required before the open parenthesis '('
geteuid02.c:25: ERROR: space required after that ',' (ctx:VxV)
geteuid02.c:25: ERROR: space required after that ',' (ctx:VxO)
geteuid02.c:25: ERROR: space required before that '&' (ctx:OxV)
geteuid02.c:25: ERROR: space required after that ',' (ctx:VxO)
geteuid02.c:25: ERROR: space required before that '&' (ctx:OxV)
geteuid02.c:25: ERROR: space required after that ',' (ctx:VxO)
geteuid02.c:25: ERROR: space required before that '&' (ctx:OxV)
geteuid02.c:25: ERROR: space required after that ',' (ctx:VxO)
geteuid02.c:25: ERROR: space required before that '&' (ctx:OxV)
geteuid02.c:27: ERROR: space required before the open brace '{'
geteuid02.c:27: ERROR: space required before the open parenthesis '('
geteuid02.c:30: ERROR: space required after that ',' (ctx:VxV)
geteuid02.c:31: ERROR: space required before the open brace '{'
geteuid02.c:31: ERROR: space required after that close brace '}'
geteuid02.c:33: ERROR: space required after that ',' (ctx:VxV)

...
> --- a/testcases/kernel/syscalls/geteuid/geteuid02.c
...
> +/*
+ Again:

/*\
 * [Description]

> + *[Description]
> + *
> + * Check that geteuid() return value matches value from /proc/self/status.
> + */

> +	TST_EXP_POSITIVE(GETEUID(),"geteuid");

...
> +	if(TST_RET != uid[1]){
> +		tst_res(TFAIL,
> +			"geteuid() ret %ld != /proc/self/status Euid: %ld",
> +			TST_RET,uid[1]);
> +	}else{
> +		tst_res(TPASS,
> +			"geteuid() ret == /proc/self/status Euid: %ld",uid[1]);
Besides missing space around brackets (reported by make check) this could be
simplified by some of our macros:

	TST_EXP_EXPR(TST_RET == uid[1],
				 "geteuid() ret %ld != /proc/self/status EUID: %ld",
				 TST_RET, uid[1]);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
