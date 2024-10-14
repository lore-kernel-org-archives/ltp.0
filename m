Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2250CFC50A
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 09:18:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51EA43C65B5
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 11:18:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFA773C18A9
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 11:18:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 44656648231
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 11:18:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16FC21FDAA;
 Mon, 14 Oct 2024 09:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728897509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e8GQSEK1+/FOHnb1+jM8PI39XZxRpfgPjn7MsXyoCNw=;
 b=C5I1AMj6WfUynZxCdvlHFEN7HaxdBOzhuiIcth5DYc3k2WdB6fRBSdGxJtCJEdU3WKKjA7
 bRn8yx1CKaugua3qn6r+2bQPUztB+WMphI/HuZOr6a5didvz2H4ckHXniV+CxpaRV4YJna
 oTWsivCdt6xIJf5QzKMACycc3ciWhB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728897509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e8GQSEK1+/FOHnb1+jM8PI39XZxRpfgPjn7MsXyoCNw=;
 b=odqPRBF8Y1xMX1VVHs4gw4w1QannyOG4sJVa/dKp2JXgJA3uRpjW04mIJJBWlorsv6Lkqm
 d2jMz2erB7yRNBDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728897509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e8GQSEK1+/FOHnb1+jM8PI39XZxRpfgPjn7MsXyoCNw=;
 b=C5I1AMj6WfUynZxCdvlHFEN7HaxdBOzhuiIcth5DYc3k2WdB6fRBSdGxJtCJEdU3WKKjA7
 bRn8yx1CKaugua3qn6r+2bQPUztB+WMphI/HuZOr6a5didvz2H4ckHXniV+CxpaRV4YJna
 oTWsivCdt6xIJf5QzKMACycc3ciWhB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728897509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e8GQSEK1+/FOHnb1+jM8PI39XZxRpfgPjn7MsXyoCNw=;
 b=odqPRBF8Y1xMX1VVHs4gw4w1QannyOG4sJVa/dKp2JXgJA3uRpjW04mIJJBWlorsv6Lkqm
 d2jMz2erB7yRNBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA4C513A42;
 Mon, 14 Oct 2024 09:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nwD+N+ThDGcVBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 14 Oct 2024 09:18:28 +0000
Date: Mon, 14 Oct 2024 11:18:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20241014091823.GA74659@pevik>
References: <20241014005339.460608-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241014005339.460608-1-lizhijian@fujitsu.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: Fix temperory directory
 ./confXXXXXX not cleanup
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

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

nit: typos in subject: temperory => temporary

> configure
>  ->config.status
>   -> create temperory directory ./confXXXXXX
>   -> cd include/lapi/syscalls
>   -> ./regen.sh
>   -> cleanup ./confXXXXXX, registered in trap

> Where config.status changes the working directory, ./confXXXXXX is not
> removed as a result.

> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/configure.ac b/configure.ac
> index b4ab81e265..d327974efa 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -386,7 +386,7 @@ else
>      AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
>  fi

> -AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
> +AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh; cd - >/dev/null])


I was thinking whether use "cd ${ac_top_builddir}", but because cd happens
outside of regen.sh, "cd -" will always work and it's probably the best.

Also, I suppose this happen quite long time ago:

Fixes: a07008fbec ("configure.ac: Generate linux_syscall_headers.h")

I noticed the problem later on but never invested time to fix it. Li Zhijian,
thanks for taking care.

Kind regards,
Petr

>  # custom functions
>  # NOTE: don't create custom functions for simple checks, put them into this file

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
