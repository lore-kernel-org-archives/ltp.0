Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99097E77197
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 16:02:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68FA13C110C
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 17:02:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 686153C0559
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 17:02:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A356D61BEBC
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 17:02:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FC6721158;
 Tue,  7 Jan 2025 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736265722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUxuL7vduxKEQumLhuzcDToHJuxkB7mFk5i7LGVzoJw=;
 b=MKbYdADA50YOJk2SniRR1euw8yyNQGati4Q1LwV9/AccF3h34XjMJdv6l8zVrcGo9ipqxM
 pFcchd6JQKxp1Ozp2aW9cHVsROtihBjNBSa21CIjLzg9PDNXRgMhb1VA05XFhETyIpqJ0B
 z6fiuARQtIF2sW8P796qZ/Dn7Guqn4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736265722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUxuL7vduxKEQumLhuzcDToHJuxkB7mFk5i7LGVzoJw=;
 b=PGLc4Qyu1b4r8bZo1al+HsskAHb6US24e5s/dORDQCHpljgOsbyEB3oMZOhL3R/Y12ci3B
 Y1mLDFmv42ZfrjCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MKbYdADA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PGLc4Qyu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736265722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUxuL7vduxKEQumLhuzcDToHJuxkB7mFk5i7LGVzoJw=;
 b=MKbYdADA50YOJk2SniRR1euw8yyNQGati4Q1LwV9/AccF3h34XjMJdv6l8zVrcGo9ipqxM
 pFcchd6JQKxp1Ozp2aW9cHVsROtihBjNBSa21CIjLzg9PDNXRgMhb1VA05XFhETyIpqJ0B
 z6fiuARQtIF2sW8P796qZ/Dn7Guqn4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736265722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUxuL7vduxKEQumLhuzcDToHJuxkB7mFk5i7LGVzoJw=;
 b=PGLc4Qyu1b4r8bZo1al+HsskAHb6US24e5s/dORDQCHpljgOsbyEB3oMZOhL3R/Y12ci3B
 Y1mLDFmv42ZfrjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0055F13A6A;
 Tue,  7 Jan 2025 16:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dhebOvlPfWeMVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Jan 2025 16:02:01 +0000
Date: Tue, 7 Jan 2025 17:01:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z31P7KEtbAwaCG7l@yuki.lan>
References: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
 <20250106-fix_setsid_tests-v2-3-c43f57a2bab6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106-fix_setsid_tests-v2-3-c43f57a2bab6@suse.com>
X-Rspamd-Queue-Id: 0FC6721158
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 03/11] Refactor ptem01 test
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

Hi!
> +	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
> +	slavename = SAFE_PTSNAME(masterfd);
>  
> -	for (i = 0; i < NUMOPENS; ++i) {
> -		masterfd[i] = open(MASTERCLONE, O_RDWR);
> -		if (masterfd[i] < 0) {
> -			tst_resm(TBROK, "%s", MASTERCLONE);
> -			tst_resm(TBROK, "out of ptys");
> -			for (i = 0; i < NUMOPENS; ++i) {
> -				if (masterfd[i] != 0) {
> -					(void)close(masterfd[i]);
> -				}
> -				if (slavefd[i] != 0) {
> -					(void)close(slavefd[i]);
> -				}
> -			}
> -			tst_exit();
> -		}
> +	TST_EXP_PASS(grantpt(masterfd));
> +	TST_EXP_PASS(unlockpt(masterfd));
>  
> -		slavename = ptsname(masterfd[i]);
> -		if (slavename == NULL) {
> -			tst_brkm(TBROK | TERRNO, NULL,
> -				 "ptsname() call failed");
> -		}
> +	slavefd = SAFE_OPEN(slavename, O_RDWR);

This would be a bit better if done in setup()

> -		if (grantpt(masterfd[i]) != 0) {
> -			tst_brkm(TBROK | TERRNO, NULL,
> -				 "grantpt() call failed");
> -		}
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCGETS, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETS, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETSW, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETSF, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETS, &termios));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCGETA, &termio));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETA, &termio));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETAW, &termio));
> +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETAF, &termio));

Are you sure these shouldn't be TST_EXP_PASS() instead? The original
code was doing != 0 for all of these.

> -		if (unlockpt(masterfd[i]) != 0) {
> -			tst_brkm(TBROK, NULL, "unlockpt() call failed");
> -		}
> -
> -		if ((slavefd[i] = open(slavename, O_RDWR)) < 0) {
> -			tst_brkm(TFAIL, NULL,
> -				 "Iteration %d: Could not open %s", i,
> -				 slavename);
> -		}
> -
> -	}
> -
> -	for (i = 0; i < NUMOPENS; ++i) {
> -		if (close(slavefd[i]) != 0) {
> -			tst_brkm(TBROK, NULL, "Iteration %d: close slave", i);
> -		}
> -		if (close(masterfd[i]) != 0) {
> -			tst_brkm(TBROK, NULL, "close master");
> -		}
> -	}
> -	tst_resm(TPASS, "test5");
> -
> -	/** NOT REACHED **/
> -	return 0;
> +	SAFE_CLOSE(slavefd);
> +	SAFE_CLOSE(masterfd);

And this should be done in cleanup if we do the init in the
setup.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
