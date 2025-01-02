Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89739E77188
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 14:53:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34073F042D
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 15:53:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4248D3EB992
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 15:53:19 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 025E6234656
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 15:53:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 868A81F38F;
 Thu,  2 Jan 2025 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735829597;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTCew5p0ITe7WMv9X1YOZozdUO5oTA/yS8zZk6T+FtQ=;
 b=aFxY3YQR9plvL29YN8+A7JD4C3wN6787JrRcw684sgJopbR7nnCtO7uB6lx6EbUtMLFnbS
 fMGAJPKefJRqvBe/kzoqvzqytiJ7mPcepgoe+pjayrrDsPHdaBF7WR5iKC4keP1aRgoRgd
 Mt6sglokDi7TYNN4eI2IJEtlw4A+kPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735829597;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTCew5p0ITe7WMv9X1YOZozdUO5oTA/yS8zZk6T+FtQ=;
 b=0RLuvZkwqg1JH8Jt0QOuV2Vqd5Y+a54w6b5YdG0bvF2N7R9i2djJAy+3pUhmqUT/NGa48U
 lL5Rj6tv5z/4OqCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735829597;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTCew5p0ITe7WMv9X1YOZozdUO5oTA/yS8zZk6T+FtQ=;
 b=aFxY3YQR9plvL29YN8+A7JD4C3wN6787JrRcw684sgJopbR7nnCtO7uB6lx6EbUtMLFnbS
 fMGAJPKefJRqvBe/kzoqvzqytiJ7mPcepgoe+pjayrrDsPHdaBF7WR5iKC4keP1aRgoRgd
 Mt6sglokDi7TYNN4eI2IJEtlw4A+kPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735829597;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTCew5p0ITe7WMv9X1YOZozdUO5oTA/yS8zZk6T+FtQ=;
 b=0RLuvZkwqg1JH8Jt0QOuV2Vqd5Y+a54w6b5YdG0bvF2N7R9i2djJAy+3pUhmqUT/NGa48U
 lL5Rj6tv5z/4OqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B5E313418;
 Thu,  2 Jan 2025 14:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LHk9DF2odmcDGwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Jan 2025 14:53:17 +0000
Date: Thu, 2 Jan 2025 15:53:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250102145307.GD94207@pevik>
References: <20241222075102.14536-1-liwang@redhat.com>
 <20241222075102.14536-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241222075102.14536-3-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] newlib_test: enable all tst_fuzzy_sync tests
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

Hi Li,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Notes:
>     This patch based on Peter's work:
>     Message-ID: <20241210225753.381770-1-pvorel@suse.cz>

>     CI: https://github.com/wangli5665/ltp/actions/runs/12452324779/

>  lib/newlib_tests/runtest.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
> index 66aaa9361..b00965b16 100755
> --- a/lib/newlib_tests/runtest.sh
> +++ b/lib/newlib_tests/runtest.sh
> @@ -2,7 +2,7 @@
>  # Copyright (c) 2021-2024 Petr Vorel <pvorel@suse.cz>

>  # TODO "unknown failure, exit code": test_assert test08 tst_cgroup01 tst_cgroup02 tst_res_flags variant
> -# TODO TFAIL: tst_fuzzy_sync01 tst_fuzzy_sync02 test_macros0[1-6] test23 test26
Ah, I should have mark it as tst_fuzzy_sync0[12]

Anyway, feel free to merge before I merge my patchset, I have no problem to
rebase mine.

Kind regards,
Petr

> +# TODO TFAIL: test_macros0[1-6] test23 test26
>  # TODO TBROK: test_exec_child test_kconfig01 test_kconfig02 tst_needs_cmds04 tst_needs_cmds05 test_runtime02 test01 test02 test03 test04 test06 test11 test13 test22 test25 tst_safe_fileops
>  # TODO TWARN: test_guarded_buf test14 tst_capability01 tst_print_result
>  LTP_C_API_TESTS="${LTP_C_API_TESTS:-
> @@ -20,6 +20,8 @@ tst_bool_expr
>  tst_capability02
>  tst_device
>  tst_expiration_timer
> +tst_fuzzy_sync01
> +tst_fuzzy_sync02
>  tst_fuzzy_sync03
>  tst_needs_cmds0[1-36-8]
>  tst_res_hexd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
