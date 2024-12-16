Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E29E7717F
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 21:22:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 686543EC58A
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 22:22:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE86B3EC553
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 22:22:29 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02966232F24
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 22:22:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73D5B21120;
 Mon, 16 Dec 2024 21:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734384147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjCn82OAHMhIJ5Xq8ZCOnuPBu1Zf128LvcXUxFJMGoc=;
 b=mnI0/LiR74m+Z+CpU30IEndzNjMIxiE0FZzCLQS834uPpsjv2zYtkBQKw/AywzkNxGRyva
 qKFEOzJDgQ6+Ea9fNwI9Yu1xkx5P2Z0mdAAqV4Y53XS4Nf4dkMuonw21LSAuV6C9UWcfV/
 BH3JPsdiEm7ytWpawYarJcxUOzmwD6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734384147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjCn82OAHMhIJ5Xq8ZCOnuPBu1Zf128LvcXUxFJMGoc=;
 b=+jnKc7SGYkPc8tZ/Kdd5OnlZdRVc3o01G1y0VDktB55iRn9KYp2nyIHoxQptfpm6dZrnK/
 /A2Z/0ejOsSe/3Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mnI0/LiR";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+jnKc7SG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734384147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjCn82OAHMhIJ5Xq8ZCOnuPBu1Zf128LvcXUxFJMGoc=;
 b=mnI0/LiR74m+Z+CpU30IEndzNjMIxiE0FZzCLQS834uPpsjv2zYtkBQKw/AywzkNxGRyva
 qKFEOzJDgQ6+Ea9fNwI9Yu1xkx5P2Z0mdAAqV4Y53XS4Nf4dkMuonw21LSAuV6C9UWcfV/
 BH3JPsdiEm7ytWpawYarJcxUOzmwD6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734384147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjCn82OAHMhIJ5Xq8ZCOnuPBu1Zf128LvcXUxFJMGoc=;
 b=+jnKc7SGYkPc8tZ/Kdd5OnlZdRVc3o01G1y0VDktB55iRn9KYp2nyIHoxQptfpm6dZrnK/
 /A2Z/0ejOsSe/3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 523C6139D4;
 Mon, 16 Dec 2024 21:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XHaqEhOaYGcFbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Dec 2024 21:22:27 +0000
Date: Mon, 16 Dec 2024 22:22:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241216212221.GB633653@pevik>
References: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
 <20241211-fix_setsid_tests-v1-2-e103f36c6462@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241211-fix_setsid_tests-v1-2-e103f36c6462@suse.com>
X-Rspamd-Queue-Id: 73D5B21120
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 02/10] Refactor ptem01 test
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

Hi Andrea,

> Fix test failure when running inside a new session via setsid() and
> start spliting its internal tests cases implementations into multiple
> files.

+1

> Fixes: https://github.com/linux-test-project/kirk/issues/28

+1

...
> -	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
> +	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);

>  	slavename = ptsname(masterfd);
> -	if (slavename == NULL) {
> -		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
> -	}
> -
> -	if (grantpt(masterfd) != 0) {
> -		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
> -	}
> -
> -	if (unlockpt(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "unlockpt() call failed");
> -	}
> -
> -	if ((slavefd = open(slavename, O_RDWR)) < 0) {
> -		tst_brkm(TFAIL, NULL, "Could not open %s", slavename);
> -	}
> -
> -	if (ioctl(slavefd, TCGETS, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCGETS");
> -	}
> -
> -	if (ioctl(slavefd, TCSETS, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETS");
> -	}
> -
> -	if (ioctl(slavefd, TCSETSW, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETSW");
> -	}
> -
> -	if (ioctl(slavefd, TCSETSF, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETSF");
> -	}
> -
> -	if (ioctl(slavefd, TCSETS, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETS");
> -	}
> -
> -	if (ioctl(slavefd, TCGETA, &termio) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCGETA");
> -	}
> -
> -	if (ioctl(slavefd, TCSETA, &termio) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETA");
> -	}
> -
> -	if (ioctl(slavefd, TCSETAW, &termio) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETAW");
> -	}
> -
> -	if (ioctl(slavefd, TCSETAF, &termio) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETAF");
> -	}
> -
> -	if (close(slavefd) != 0) {
> -		tst_brkm(TBROK, NULL, "close slave");
> -	}
> -
> -	if (close(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "close master");
> -	}
> -	tst_resm(TPASS, "test1");
...

> +	if (slavename == NULL)
> +		tst_res(TFAIL, "Can't get slave device location");
The old test uses tst_brkm() for all tests, which is IMHO necessary, but I this
one should be tst_brk() because slavename is later used with open/SAFE_OPEN().

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	else
> +		tst_res(TPASS, "pts device location is %s", slavename);
> +
> +	TST_EXP_PASS(grantpt(masterfd));
> +	TST_EXP_PASS(unlockpt(masterfd));
> +
> +	slavefd = SAFE_OPEN(slavename, O_RDWR);
> +
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCGETS, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETS, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETSW, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETSF, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETS, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCGETA, &termio));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETA, &termio));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETAW, &termio));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETAF, &termio));
> +
> +	SAFE_CLOSE(slavefd);
> +	SAFE_CLOSE(masterfd);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
