Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE97D6409F
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 09:31:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53FD83D03B8
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 10:31:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26C2A3CEB38
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 10:31:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BF18520012E
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 10:31:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95E605BCC6;
 Wed, 17 Dec 2025 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765963859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5bU90fsMJv4IqBPUlzAl/IHUwwB9NDYs1LmJvOz5jk=;
 b=JY3fkwSnJD7YRvbraE/eamFlhC9+LtsfyaOzQaTaS+46f+4oS6mo9ECeibgTgJrs3BeLYS
 4OYRvTGnVtPirgXyXqs7hsQpmR1Runr0QGrrvsaJp1bpSPHYUiHdQa0PovXfm0p0Lc4I2u
 dffIDtuqfBh0iGbetahP4CU9pLQ+FOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765963859;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5bU90fsMJv4IqBPUlzAl/IHUwwB9NDYs1LmJvOz5jk=;
 b=nuKtkSfiFQ5pWDwyHrdwulCjOGWPjrJh1cKJ2Ijlr4jk/qPVZhE96Mk4fdSoQG6MOyqcpT
 A6uGW8ZhAZewdqCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JY3fkwSn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nuKtkSfi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765963859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5bU90fsMJv4IqBPUlzAl/IHUwwB9NDYs1LmJvOz5jk=;
 b=JY3fkwSnJD7YRvbraE/eamFlhC9+LtsfyaOzQaTaS+46f+4oS6mo9ECeibgTgJrs3BeLYS
 4OYRvTGnVtPirgXyXqs7hsQpmR1Runr0QGrrvsaJp1bpSPHYUiHdQa0PovXfm0p0Lc4I2u
 dffIDtuqfBh0iGbetahP4CU9pLQ+FOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765963859;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5bU90fsMJv4IqBPUlzAl/IHUwwB9NDYs1LmJvOz5jk=;
 b=nuKtkSfiFQ5pWDwyHrdwulCjOGWPjrJh1cKJ2Ijlr4jk/qPVZhE96Mk4fdSoQG6MOyqcpT
 A6uGW8ZhAZewdqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 764B63EA63;
 Wed, 17 Dec 2025 09:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yrUHHFN4QmlObgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Dec 2025 09:30:59 +0000
Date: Wed, 17 Dec 2025 10:32:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aUJ4kiC86tdo9h3n@yuki.lan>
References: <20251212115244.2027-1-wegao@suse.com>
 <20251214021541.3256-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251214021541.3256-1-wegao@suse.com>
X-Rspamd-Queue-Id: 95E605BCC6
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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
>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
> -	struct mnt_id_req *req = NULL;
> +	mnt_id_req *req = NULL;
> +
> +	if (tc->kver && tc->kver != kver) {
> +		tst_res(TCONF, "Skip the case that is not suitable for the current kernel version");

I would shorten this message a bit "Test not suitable for current kernel version"


Because the information that the test is skipped is already in the TCONF
flag.

Otherwise: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
