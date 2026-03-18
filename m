Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E2A103E183
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:26:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D66DC3E5CAB
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 15:26:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DACD73CC8C5
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 15:26:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 541E6200398
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 15:26:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9959C5BD6B;
 Wed, 18 Mar 2026 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773843965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCOnaNgdq1VUEC+l/1eif75PnYv3PQAK4yRYQw9CZfY=;
 b=e5lKEq1/KOqffTBe/oy+CKWKL/JYbNG/MilqSVZIRhHO5UcUtZwEgZ+Zt1ydFDYc41YOeD
 d3gD1fjKoV9DvG7eEQKgFxXaDrQUyvj/rarZRJc0Iy4tH6qIT/64UKXWZIg5jtbdd3IeKb
 y2t6aannkpagmVAeUYkgxx6AFwVNEM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773843965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCOnaNgdq1VUEC+l/1eif75PnYv3PQAK4yRYQw9CZfY=;
 b=cldQY/I+bAk+PFIvvumlQIR0WpX9BVCkpl1Db+iXGQbV9SfUzYlN2C40NwaiAurzWa46T+
 ljkKEPnvE3NQHvBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="e5lKEq1/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="cldQY/I+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773843965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCOnaNgdq1VUEC+l/1eif75PnYv3PQAK4yRYQw9CZfY=;
 b=e5lKEq1/KOqffTBe/oy+CKWKL/JYbNG/MilqSVZIRhHO5UcUtZwEgZ+Zt1ydFDYc41YOeD
 d3gD1fjKoV9DvG7eEQKgFxXaDrQUyvj/rarZRJc0Iy4tH6qIT/64UKXWZIg5jtbdd3IeKb
 y2t6aannkpagmVAeUYkgxx6AFwVNEM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773843965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCOnaNgdq1VUEC+l/1eif75PnYv3PQAK4yRYQw9CZfY=;
 b=cldQY/I+bAk+PFIvvumlQIR0WpX9BVCkpl1Db+iXGQbV9SfUzYlN2C40NwaiAurzWa46T+
 ljkKEPnvE3NQHvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 868BA4273B;
 Wed, 18 Mar 2026 14:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /A2xH/21umk8YAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Mar 2026 14:26:05 +0000
Date: Wed, 18 Mar 2026 15:26:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abq1-BcXR1nfLGcU@yuki.lan>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260313142600.243939-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9959C5BD6B
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] tst_env.sh: Backport common functions from
 tst_test.sh
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> * ROD()
> * ROD_SILENT()
> * EXPECT_PASS()
> * EXPECT_PASS_BRK()
> * EXPECT_FAIL()
> * EXPECT_FAIL_BRK()
> + their dependencies.
> 
> ROD_SILENT will be used in du01.sh rewrite, others will be used likely
> in other tests later.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_env.sh | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
> index 585790a7d0..13d8a8f954 100644
> --- a/testcases/lib/tst_env.sh
> +++ b/testcases/lib/tst_env.sh
> @@ -1,6 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
> +# Copyright (c) Linux Test Project, 2026
>  #
>  # This is a minimal test environment for a shell scripts executed from C by
>  # tst_run_shell() function. Shell tests must use the tst_loader.sh instead!
> @@ -30,3 +31,73 @@ tst_brk_()
>  
>  alias tst_res="tst_res_ $tst_script_name \$LINENO"
>  alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
> +
> +ROD_SILENT()
> +{
> +	local tst_out
> +
> +	tst_out=$(tst_rod "$@" 2>&1)
> +	if [ $? -ne 0 ]; then
> +		echo "$tst_out"
> +		tst_brk TBROK "$@ failed"
> +	fi
> +}
> +
> +ROD()
> +{
> +	tst_rod "$@"
> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "$@ failed"
> +	fi
> +}

Since we are starting from a scratch I wonder if we should call this
SAFE instead so that the name is closer to the SAFE_XXX macros in C.

> +_tst_expect_pass()
> +{
> +	local fnc="$1"
> +	shift
> +
> +	tst_rod "$@"

If I remmeber correctly the whole reason why we introduced tst_rod.c was
that passing the $@ like this causes the $@ to be evaluated twice and
produces unexpected results.

> +	if [ $? -eq 0 ]; then
> +		tst_res TPASS "$@ passed as expected"
> +		return 0
> +	else
> +		$fnc TFAIL "$@ failed unexpectedly"
> +		return 1
> +	fi
> +}
> +
> +_tst_expect_fail()
> +{
> +	local fnc="$1"
> +	shift
> +
> +	# redirect stderr since we expect the command to fail
> +	tst_rod "$@" 2> /dev/null
> +	if [ $? -ne 0 ]; then
> +		tst_res TPASS "$@ failed as expected"
> +		return 0
> +	else
> +		$fnc TFAIL "$@ passed unexpectedly"
> +		return 1
> +	fi
> +}
> +
> +EXPECT_PASS()
> +{
> +	_tst_expect_pass tst_res "$@"
> +}
> +
> +EXPECT_PASS_BRK()
> +{
> +	_tst_expect_pass tst_brk "$@"
> +}

I'm not sure that adding the PASS_BRK and FAIL_BRK is a good idea. I
would stick to simple EXPECT_PASS and EXPECT_FAIL. And maybe we can
export TST_PASS variable as we do in C to match the API. I think that
the closer the C and shell API are the better.

> +EXPECT_FAIL()
> +{
> +	_tst_expect_fail tst_res "$@"
> +}
> +
> +EXPECT_FAIL_BRK()
> +{
> +	_tst_expect_fail tst_brk "$@"
> +}
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
