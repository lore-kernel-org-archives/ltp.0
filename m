Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F84BE77197
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 16:31:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B55F63C1310
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 17:31:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A42F53C0372
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 17:31:00 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C7F31B60234
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 17:30:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23C9F1F450;
 Tue,  7 Jan 2025 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736267459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKjMPMF4lBt9WL7TIGu8NC1LQtOI96t60dfE3VqHYfY=;
 b=ZQifhqkk+ckIwSW6wPQnyyejEr1Jf62EEo4cqYbWdnhky4I2Yscd0oQ9IsBB7ljteS2gxF
 SqebSux8Y7QY8/Q0zWhloyiieJciaVA00Y4kAhaaVzBhE0Og4xaP9lZ7NfblI40mrcVPJ5
 A6CRAYTkO3GjaPl1kVowiSZrqXIc6Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736267459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKjMPMF4lBt9WL7TIGu8NC1LQtOI96t60dfE3VqHYfY=;
 b=tRa6EY3O1gkLZeHG4uHvZhFglRkG0Dugz4M2Bl/WWX7j+fbKdAEBKfC5vLA6LyTPfMw09H
 hYUZfBBt/ckcmMAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736267459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKjMPMF4lBt9WL7TIGu8NC1LQtOI96t60dfE3VqHYfY=;
 b=ZQifhqkk+ckIwSW6wPQnyyejEr1Jf62EEo4cqYbWdnhky4I2Yscd0oQ9IsBB7ljteS2gxF
 SqebSux8Y7QY8/Q0zWhloyiieJciaVA00Y4kAhaaVzBhE0Og4xaP9lZ7NfblI40mrcVPJ5
 A6CRAYTkO3GjaPl1kVowiSZrqXIc6Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736267459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKjMPMF4lBt9WL7TIGu8NC1LQtOI96t60dfE3VqHYfY=;
 b=tRa6EY3O1gkLZeHG4uHvZhFglRkG0Dugz4M2Bl/WWX7j+fbKdAEBKfC5vLA6LyTPfMw09H
 hYUZfBBt/ckcmMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1255413763;
 Tue,  7 Jan 2025 16:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5zG3AcNWfWcIXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Jan 2025 16:30:59 +0000
Date: Tue, 7 Jan 2025 17:30:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z31WtRKdHRTctqPV@yuki.lan>
References: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
 <20250106-fix_setsid_tests-v2-5-c43f57a2bab6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106-fix_setsid_tests-v2-5-c43f57a2bab6@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 05/11] Add ptem03 test
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
> +static void run(void)
> +{
> +	int masterfd, slavefd;
> +	char *slavename;
> +
> +	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
> +	slavename = SAFE_PTSNAME(masterfd);
> +
> +	TST_EXP_PASS(grantpt(masterfd));
> +	TST_EXP_PASS(unlockpt(masterfd));
> +
> +	slavefd = SAFE_OPEN(slavename, O_RDWR);

This is being repeated in each test so it should be really put into the
test setup function and the function should be put into a common header
and included in all the tests.

> +	TST_EXP_PASS(tcsendbreak(masterfd, 10));
> +	TST_EXP_PASS(tcsendbreak(slavefd, 10));

Here you are using the TST_EXP_PASS() correctly.

> +	SAFE_CLOSE(slavefd);
> +	SAFE_CLOSE(masterfd);
> +}
> +
> +static void setup(void)
> +{
> +	if (access(MASTERCLONE, F_OK))
> +		tst_brk(TBROK, "%s device doesn't exist", MASTERCLONE);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
