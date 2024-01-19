Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24686C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 11:59:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9253A3CC8C8
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 12:59:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 536BC3CAC5F
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 12:59:34 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5D29A1A011E8
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 12:59:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 519A62224E;
 Fri, 19 Jan 2024 11:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705665573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTPVbnUxhG1pOzfFkVW3b5A9vWUlo36tuMoaqNhSDlw=;
 b=vtfM3H8Ly4+LCqwXDnZTAST8Ykv9OUT/TymiQ4l9HOGlOvvZ7+gIaFFxqtAWNDlN40t1L9
 7qQx2Cqdwlu1wmic4yCfahje3X/nzjZcLCG09TGljxbCUdOYgETSDnFG4ntox0y4BrIISQ
 /fFu6KqGDrtW5mHwRx4kAw5AdGyYoIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705665573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTPVbnUxhG1pOzfFkVW3b5A9vWUlo36tuMoaqNhSDlw=;
 b=qHSfcpW7JUUpXsKP6Enm5Z9InDURrlnptjkYygkFTn/1Qrh6l0IgPQDxAhBBUia0zSvte3
 nHIDRKiygc8gaZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705665571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTPVbnUxhG1pOzfFkVW3b5A9vWUlo36tuMoaqNhSDlw=;
 b=En5RQaaOCaiQFfhmDFVbetyEf7qDSXGG/nbYAKzFRRxllacLZPJacCyyDG5GWSbn1nD2SN
 KUPL9bEqIQXIBVkugNpS/SvyNQivmxG7XH/U/ohfWMK4d1XzFrthQNW0/yFiXYS3lSzUaF
 FMGkix8LNmqnd/pu+1IoAI0Dk4gqoyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705665571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTPVbnUxhG1pOzfFkVW3b5A9vWUlo36tuMoaqNhSDlw=;
 b=y/juHf8Fl+2WtIzvkFNlOWQz0hazFqCAveOem6hJ+Zlmz0AC4/NzK2Y4lv9ERkovn9mWMO
 wB3rX4rycySNIXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 356691388C;
 Fri, 19 Jan 2024 11:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4GURDCNkqmVuAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jan 2024 11:59:31 +0000
Date: Fri, 19 Jan 2024 12:59:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZapkKSTNkXsnulC3@yuki>
References: <20231011162428.583911-1-pvorel@suse.cz>
 <20231011162428.583911-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011162428.583911-3-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=En5RQaaO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="y/juHf8F"
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[30.72%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 519A62224E
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] swapon01: Simplify code, add copyright
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  /*\
> @@ -21,18 +22,11 @@
>  
>  static void verify_swapon(void)
>  {
> -	TEST(tst_syscall(__NR_swapon, SWAP_FILE, 0));
> +	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));
>  
> -	if (TST_RET == -1) {
> -		tst_res(TFAIL | TTERRNO, "Failed to turn on swapfile");
> -	} else {
> -		tst_res(TPASS, "Succeeded to turn on swapfile");
> -		/*we need to turn this swap file off for -i option */
> -		if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
> -			tst_brk(TBROK | TERRNO, "Failed to turn off swapfile,"
> -				" system reboot after execution of LTP "
> -				"test suite is recommended.");
> -		}
> +	if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {

Maybe if (TST_PASS && tst_syscall(__NR_swapoff, ...) != 0) {


Otherwise it looks good, with that change:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +		tst_brk(TBROK | TERRNO,
> +				"Failed to turn off swapfile, system reboot recommended");
>  	}
>  }
>  
> -- 
> 2.42.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
