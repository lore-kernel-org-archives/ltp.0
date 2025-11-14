Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6B2CDE03C
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 08:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFAF93CF81E
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 09:50:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55B283CF384
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 09:49:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D2E8140111B
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 09:49:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56CB31F391;
 Fri, 14 Nov 2025 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763110189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdTIaFh8WVNUXBaFpF2SfLxNCNAG9cSyYjvYtO3Aie8=;
 b=lyiNx9Lu3W6Mwk5dtXGULQ54T0AF34HKVHDWXWY8Sznt9yTzr46sItP0M+mwjVBSxBBcHB
 lrJdxRRkwgmB/6CZBO1HVuy3uuNWCm6iV6F82nTzUtw/skSTQ4He7R5dNSs5rqtoxzGbd3
 uSG9UYXzMfZe8IeftlpIylqug7YRBv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763110189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdTIaFh8WVNUXBaFpF2SfLxNCNAG9cSyYjvYtO3Aie8=;
 b=BrE2rbFfhxSM1mZh0DN0VhFplAX6mRsLpW7OUKTLUmdPwq5qm1qcLiyYAu8MrhH11H27sh
 5gcbt3gQ6R5aPPAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lyiNx9Lu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BrE2rbFf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763110189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdTIaFh8WVNUXBaFpF2SfLxNCNAG9cSyYjvYtO3Aie8=;
 b=lyiNx9Lu3W6Mwk5dtXGULQ54T0AF34HKVHDWXWY8Sznt9yTzr46sItP0M+mwjVBSxBBcHB
 lrJdxRRkwgmB/6CZBO1HVuy3uuNWCm6iV6F82nTzUtw/skSTQ4He7R5dNSs5rqtoxzGbd3
 uSG9UYXzMfZe8IeftlpIylqug7YRBv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763110189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdTIaFh8WVNUXBaFpF2SfLxNCNAG9cSyYjvYtO3Aie8=;
 b=BrE2rbFfhxSM1mZh0DN0VhFplAX6mRsLpW7OUKTLUmdPwq5qm1qcLiyYAu8MrhH11H27sh
 5gcbt3gQ6R5aPPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AD353EA61;
 Fri, 14 Nov 2025 08:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5gixES3tFmnQLAAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 14 Nov 2025 08:49:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Nov 2025 09:49:43 +0100
Message-ID: <4691033.LvFx2qVVIh@thinkpad>
In-Reply-To: <20251107102939.1111074-2-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
 <20251107102939.1111074-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 56CB31F391
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] tst_test.c: Fix tst_check_cmd() use
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Friday, November 7, 2025 11:29:32 AM CET Petr Vorel wrote:
> 9bb94efa39 changed tst_check_cmd() from int to bool. But it reverted the
> values (0 became true), which logical (false means not supported) than
nit:
I feel it should say:
which is more logical

> the original return codes from 257394e4e3. But then the only use of
> tst_check_cmd() needs to update to expect false instead of true.
> 
> Also document the return code in tst_private.h.
> 
> Fixes: 9bb94efa39 ("tst_cmd: Change tst_check_cmd() return type to int")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Fixing my own error.
> 
>  include/tst_private.h | 5 +++++
>  lib/tst_test.c        | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/tst_private.h b/include/tst_private.h
> index 87ec8829a1..482b68fba2 100644
> --- a/include/tst_private.h
> +++ b/include/tst_private.h
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (c) Linux Test Project, 2020-2025
>   * Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
>   *
>   * Internal helper functions for the shell library. Do not use directly
> @@ -41,9 +42,13 @@ char tst_kconfig_get(const char *confname);
>  /*
>   * If cmd argument is a single command, this function just checks command
>   * whether exists. If not, case breaks if brk_nosupp is defined.
> + *
>   * If cmd argument is a complex string ie 'mkfs.ext4 >= 1.43.0', this
>   * function checks command version whether meets this requirement.
>   * If not, case breaks if brk_nosupp is defined.
> + *
> + * return: true if command presented, optionally with high enough version, false
s/command presented/command is present
> + * otherwise.
>   */
>  bool tst_check_cmd(const char *cmd, const int brk_nosupp);
>  
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index da5314c502..bda66c4672 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1960,7 +1960,7 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>  	tst_res(TINFO, "=== Testing on %s ===", fs_type);
>  	tdev.fs_type = fs_type;
>  
> -	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
> +	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
>  		return TCONF;
>  
>  	if (fs->min_kver && check_kver(fs->min_kver, 0))
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
