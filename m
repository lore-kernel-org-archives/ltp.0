Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126CFC02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 17:15:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CA5B3C6586
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 18:15:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 024EF3C275F
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 18:14:50 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A3ED1140F6DC
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 18:14:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D00A11F383;
 Mon, 27 Jan 2025 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737998088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5PKsDZUFwm6Vl++f1pZ4VObNjaXXp84MbOFTfZo4GY=;
 b=TZZ/vUhjQ7UCl7RNSHlB58ZKfI9EvAooxXVu1nWugl35t6cMhFT67Bu8+JDY5ps2aQP2dq
 cS57vE16c6RrcnWYCvWSN+7pKF8dNVlfYG/6lPRsQLsmjvnmtL1pqOktu22XbC8sKLQp9p
 soyQkzHE+0yIZ8mMh1Aw9a6FxU80ico=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737998088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5PKsDZUFwm6Vl++f1pZ4VObNjaXXp84MbOFTfZo4GY=;
 b=P7xx/jyLhmLLuGUYrJEDo5eowmdwOc85K4XG1K0upVWfKNcAdYQGzAbcfk40qMJZQEM1mm
 DxHrs+sx48RLc5CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M61I9LTU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0DqEASDu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737998087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5PKsDZUFwm6Vl++f1pZ4VObNjaXXp84MbOFTfZo4GY=;
 b=M61I9LTU/D8M+sxqWUd3qL0xyZQ9J0AmnJx1VWMngLm3m/sy0JDjJn3XwCaxn3c1kwlWTi
 +9/OHnTB3CG2x4cFlKy8SRLJ+MAVITLy1glGvmgv/SfFuP9jqes0VINMZ88beFlcDhZg9l
 2yBkURdq4QspbRvSpfyF7R4AQrXvneg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737998087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5PKsDZUFwm6Vl++f1pZ4VObNjaXXp84MbOFTfZo4GY=;
 b=0DqEASDu+w1uOskvsIOwhecWEor/B1FSqdnYCqiom3EyEB+jdEgBTpLiIM41EM+fzPEAQ1
 WaH74g0wrQ4jlkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48E2E13715;
 Mon, 27 Jan 2025 17:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1PyODge/l2dLHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 Jan 2025 17:14:47 +0000
Date: Mon, 27 Jan 2025 18:14:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <20250127171441.GA304248@pevik>
References: <20240925084921.16352-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240925084921.16352-1-ice_yangxiao@163.com>
X-Rspamd-Queue-Id: D00A11F383
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[163.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[163.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/{fanotify17,
 getxattr05}: Fix the ENOSPC error
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

Hi Cyril, Li,

> If the value of max_user_namespaces is set to 10 but more than
> 10 user namspaces are currently used on system.  In this case,
> these tests fail with ENOSPC. for example:

> # lsns -t user -n | wc -l
> 17

> # ./fanotify17
> ...
> fanotify17.c:174: TINFO: Test #0: Global groups limit in init user ns
> fanotify17.c:130: TPASS: Created 128 groups - below groups limit (128)
> fanotify17.c:174: TINFO: Test #1: Global groups limit in privileged user ns
> fanotify17.c:154: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> tst_test.c:452: TBROK: Invalid child (6958) exit value 1

> Try to fix the issue by increasing the default value of
> max_user_namespaces by 10.

How about merging this before release? I was able to reproduce:
https://lore.kernel.org/ltp/20241104163845.GA1417282@pevik/

Kind regards,
Petr

> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify17.c | 2 +-
>  testcases/kernel/syscalls/getxattr/getxattr05.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
> index 3ecb31b6e..a6206d953 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify17.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
> @@ -224,7 +224,7 @@ static void setup(void)
>  		user_ns_supported = 0;
>  	} else if (!access(MAX_USERNS, F_OK)) {
>  		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
> +		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns + 10);
>  	}

>  	/*
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
> index d9717a695..f1c8e8391 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr05.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
> @@ -156,7 +156,7 @@ static void setup(void)
>  		user_ns_supported = 0;
>  	} else if (!access(MAX_USERNS, F_OK)) {
>  		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
> +		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns + 10);
>  	}

>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
