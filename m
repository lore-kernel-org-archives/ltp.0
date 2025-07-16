Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6745AC83F27
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 06:55:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABACB3CBCC3
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 08:55:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 402893C9B01
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 08:54:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C40F200C18
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 08:54:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C2F32120A;
 Wed, 16 Jul 2025 06:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752648887;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRQ8Ktn0ZbuJG/l9yHBELZb4/xiYDUtUVm3/K2uUQYA=;
 b=mfOP7lDJ+rQDIX/X7MTgaLPkDTBFiq03fkLhkPgsfiQJidFGh/xrg2IjJ5/uXgOYY/1X73
 vTZ1PSXGTyKPZ7RkkiAqhrbTtu7/fv0XVSzPbr0IBG2mmdWNi+9i6As4OUl15bQ4NMhohx
 VDTpXG0S/lkHoXKevdUTS65TD1pCxb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752648887;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRQ8Ktn0ZbuJG/l9yHBELZb4/xiYDUtUVm3/K2uUQYA=;
 b=BAC5OWsjZftafb+ZREVd5WOlQEPJ7M5tOk+9bdRredAGBM7V9wZuS8rbmTMXVglv1Hwe9W
 HxiykDf/iJ045sDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RI2AzfMh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MnGoAVJ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752648886;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRQ8Ktn0ZbuJG/l9yHBELZb4/xiYDUtUVm3/K2uUQYA=;
 b=RI2AzfMhRnVYC4A6tyRtkmXrccGtTsNe1msXje+aeqzyydFJ/B4b8+QZBWw2VVRHdwjJqL
 ELtgqliUZkj4RpMkyE6b4mcV3OoP+bJeBhFrntobDUHsI4o1QLg55TlqqLyhm1arr7B4OF
 YnGQM4idraLa7GFXSoPOSNPF8SBsEs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752648886;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRQ8Ktn0ZbuJG/l9yHBELZb4/xiYDUtUVm3/K2uUQYA=;
 b=MnGoAVJ5YkkadXJrg4LCn9ktAajtgQYqeAGn2GE22uNV8kZ15gs3EmmEOukmuHgBlnS37H
 wqGEGub/NXQVQGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DEE113306;
 Wed, 16 Jul 2025 06:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iYy5DLZMd2jqcwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Jul 2025 06:54:46 +0000
Date: Wed, 16 Jul 2025 08:54:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250716065444.GA14792@pevik>
References: <20250226143113.3016480-1-pvorel@suse.cz>
 <20250226143113.3016480-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250226143113.3016480-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-2.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; SUBJECT_HAS_CURRENCY(1.00)[];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[tst_ansi_color.sh:url,suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,tst_security.sh:url,ima_setup.sh:url,ozlabs.org:url];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6C2F32120A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 2/3] tst_test: Allow test to suggest reboot
 via $TST_REBOOT
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

> Frameworks/tooling which run LTP can schedule reboot based on
> environment variable.

Cyril, you wanted to add this via struct tst_test (e.g. not using a new variable
in shell). That's indeed better (used by both C API and shell loader + having it
in metadata doc). But for a better integration with external frameworks (e.g.
kirk or openQA) it will still be needed to export some environment variable
(e.g. LTP_REBOOT) to notify the framework for a reboot.

And for IMA tests to be able to use it they will need to be converted to shell
loader (which requires to finish setup/cleanup support for shell loader [1]).
ima_setup.sh use quirk to use a loop device if TMPDIR is on tmpfs (some
IMA measurements are not supported on tmpfs). Because shell loader's struct
tst_test in JSON is not modifiable I will have to use always a loop device
(slower) and force some filesystem (previously tests were run on the filesystem
installed on TMPDIR, e.g. test on the filesystem chosen by distro/user).

Setting this whole patchset in patchwork as rejected.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=460106&state=*

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> If useful, I should probably add it to C API as well
> (at least swapoff01.c and swapon01.c print also "reboot recommended").

>  doc/users/setup_tests.rst | 3 +++
>  testcases/lib/tst_test.sh | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

> diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
> index ddcf00f027..0cdb86715f 100644
> --- a/doc/users/setup_tests.rst
> +++ b/doc/users/setup_tests.rst
> @@ -85,6 +85,9 @@ users.
>     * - LTP_ENABLE_DEBUG
>       - Enable debug info (value ``1`` or ``y``). Equivalent of ``-D`` parameter.

> +   * - TST_REBOOT
> +     - Environment variable set by LTP test to signalize that SUT should be rebooted.
> +
>  Environment variables for network tests
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  See :master:`testcases/network/README.md`.
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 2b797705e3..a450976f36 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -16,6 +16,7 @@ export TST_COUNT=1
>  export TST_ITERATIONS=1
>  export TST_TMPDIR_RHOST=0
>  export TST_LIB_LOADED=1
> +export TST_REBOOT=

>  . tst_ansi_color.sh
>  . tst_security.sh
> @@ -84,6 +85,10 @@ _tst_do_exit()
>  		[ -z "$TST_SKIP_LSM_WARNINGS" ] && _tst_check_security_modules
>  	fi

> +	if [ "$TST_REBOOT" = 1 ]; then
> +		tst_res TINFO "WARNING: reboot recommended due test changes"
> +	fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
