Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859A7C27C6E
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 12:51:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4E2F3D0148
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 14:51:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4B783CE9A0
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 14:51:20 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D58C601B36
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 14:51:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F626204DA;
 Fri, 14 Jun 2024 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718369478;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpKP0DrWkZ7/QBSExLgPJP+G4UlwO8HTKe0gy+8KzU8=;
 b=vLhM9fbURF9Jk1d6gd3PnBZHIgzWgtoNBIZuqH23lTPm1Fvm+KTyIdgj2Hx+WCdHsYg+nu
 hM25Ju/4tsXoWHZ4xRL9UprAPurdBKbmlMq9I3CS45BYii/dSaXNGsAP7A5pV5d3zfy7ws
 /ktAQqJmPwkP1+iezU4O5Ym07V/ei80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718369478;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpKP0DrWkZ7/QBSExLgPJP+G4UlwO8HTKe0gy+8KzU8=;
 b=cGLqBmGWZ8lLopKMNo0mmUpMoxStq2xizKOFKBE2Jt4u2TsKULmUEWChRRxCwtITIcRuwZ
 MQ88slCNtk3SLoAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vLhM9fbU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cGLqBmGW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718369478;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpKP0DrWkZ7/QBSExLgPJP+G4UlwO8HTKe0gy+8KzU8=;
 b=vLhM9fbURF9Jk1d6gd3PnBZHIgzWgtoNBIZuqH23lTPm1Fvm+KTyIdgj2Hx+WCdHsYg+nu
 hM25Ju/4tsXoWHZ4xRL9UprAPurdBKbmlMq9I3CS45BYii/dSaXNGsAP7A5pV5d3zfy7ws
 /ktAQqJmPwkP1+iezU4O5Ym07V/ei80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718369478;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpKP0DrWkZ7/QBSExLgPJP+G4UlwO8HTKe0gy+8KzU8=;
 b=cGLqBmGWZ8lLopKMNo0mmUpMoxStq2xizKOFKBE2Jt4u2TsKULmUEWChRRxCwtITIcRuwZ
 MQ88slCNtk3SLoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E78A13AB1;
 Fri, 14 Jun 2024 12:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Aw+jAsY8bGZuMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jun 2024 12:51:18 +0000
Date: Fri, 14 Jun 2024 14:51:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240614125116.GA197913@pevik>
References: <20240530044029.15474-1-wegao@suse.com>
 <20240613232044.7418-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240613232044.7418-1-wegao@suse.com>
X-Rspamd-Queue-Id: 1F626204DA
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] msync04.c: Use direct IO to verify the data is
 stored on disk
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

Hi Wei,

...
> +static void verify_mmaped(void)
> +{
> +	char *buffer = SAFE_MEMALIGN(getpagesize(), getpagesize());
> +
> +	tst_res(TINFO, "Haven't seen dirty bit so we check content of file instead");
> +	test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY | O_DIRECT);
If this fails we have memory leak, because free() is not run.

> +	SAFE_READ(0, test_fd, buffer, getpagesize());
Also here. Maybe create buf as static and have conditional free() also at the
cleanup?

Kind regards,
Petr

> +
> +	if (buffer[8] == 'B')
> +		tst_res(TCONF, "Write was too fast, couldn't test msync()");
> +	else
> +		tst_res(TFAIL, "write file failed");
> +
> +	free(buffer);
> +}
> +

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
