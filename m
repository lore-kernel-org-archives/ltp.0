Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86098C47258
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 10:01:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 403893CCD79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 11:01:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B4523CBAAC
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 11:00:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 581A1600478
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 11:00:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C52A61F898;
 Mon, 15 Jan 2024 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705312845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLCN3ljd4vwBaFzthJJT/NT3C2ptQDKkys4i6Xik5gE=;
 b=wo22ZCensRGIiH8B7bvRDIBEnZl8Q0HnqhnLqVGMwklSNp4HDqOSizqdlfY4cB0R+pFc6n
 6RXIh1iHCridywedbnrTuzbXA4ghILq7YkTUr1+Ka6+RpwdDVxfgtYz7MWxkqK7IlLFlgJ
 dN+yX4RAZpoJ3LAq2whV3xlb0/hD46U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705312845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLCN3ljd4vwBaFzthJJT/NT3C2ptQDKkys4i6Xik5gE=;
 b=ibtyLXf1s4siCk7xFv9cWDEDkEq7dPJtkVcUN+tQx/X0J2gUB0rFTLyrQ1KKFGnlVBceok
 lf/zFIlg80M+XdAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705312845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLCN3ljd4vwBaFzthJJT/NT3C2ptQDKkys4i6Xik5gE=;
 b=wo22ZCensRGIiH8B7bvRDIBEnZl8Q0HnqhnLqVGMwklSNp4HDqOSizqdlfY4cB0R+pFc6n
 6RXIh1iHCridywedbnrTuzbXA4ghILq7YkTUr1+Ka6+RpwdDVxfgtYz7MWxkqK7IlLFlgJ
 dN+yX4RAZpoJ3LAq2whV3xlb0/hD46U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705312845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLCN3ljd4vwBaFzthJJT/NT3C2ptQDKkys4i6Xik5gE=;
 b=ibtyLXf1s4siCk7xFv9cWDEDkEq7dPJtkVcUN+tQx/X0J2gUB0rFTLyrQ1KKFGnlVBceok
 lf/zFIlg80M+XdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5BF913712;
 Mon, 15 Jan 2024 10:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O6lCK00CpWUCIgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 10:00:45 +0000
Date: Mon, 15 Jan 2024 11:01:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: chenguanxi11234@163.com
Message-ID: <ZaUCaXEcdEquP_r7@yuki>
References: <977c827a45313499dd372cfda1c5156c2729595d.1704804430.git.chen.haonan2@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <977c827a45313499dd372cfda1c5156c2729595d.1704804430.git.chen.haonan2@zte.com.cn>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wo22ZCen;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ibtyLXf1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; FREEMAIL_TO(0.00)[163.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[26.53%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[163.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: C52A61F898
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2]
 posix/conformance/interfaces/sem_timedwait/2-1: Fix test
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
Cc: yang.guang5@zte.com.cn, ltp@lists.linux.it,
 Chen Haonan <chen.haonan2@zte.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -	/* Semaphore started out locked */
> -	if (sem_init(&mysemp, 0, 0) == -1) {
> +	/* Map semaphore to shared memory */
> +	int shm_fd = shm_open("/myshm", O_CREAT | O_RDWR, 0666);
> +
> +	ftruncate(shm_fd, sizeof(sem_t));
> +	mysemp = (sem_t *)mmap(NULL, sizeof(sem_t), PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);

Again, this can be just anonymous memory, need need to back it up by the
file descriptor. Should be as easy as:

	mysemp = mmap(NULL, sizeof(*mysemp), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);

As well as the error conditions are still not checked.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
