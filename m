Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17D2CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 14:14:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D3B03E62CC
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 16:14:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C97263C01A4
 for <ltp@lists.linux.it>; Tue, 26 May 2026 16:14:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DAA4C60095A
 for <ltp@lists.linux.it>; Tue, 26 May 2026 16:14:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A2D065731;
 Tue, 26 May 2026 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779804857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EgJnPtJHohc4ZdHfAiAPuS/mUJn7VAHeML3YyO3VZKo=;
 b=JRQtLbrb9plkfblpCo4Wz3eugdiTcWdf//R6xC94vW0UgQYHquef5HxKnk0kiABGKW/5Pv
 CrBt5UKVS3Bh9Sv/TuYHUauPnJt53Dde/OuHnpATe87oDzE+X0sw6Nd/3soRR2od6iGWHF
 HwiA5P+YxHX3V9WM/IyzvhqFwGYG71Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779804857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EgJnPtJHohc4ZdHfAiAPuS/mUJn7VAHeML3YyO3VZKo=;
 b=LEgvfKGdiVN4w0zckDw5KVY5M4dN/SjgT81QT+Z4Ub1QeO3OcB+JkEg0BPNKOGvmb6Vs3I
 MRGDZ2t2jJi/fBBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JRQtLbrb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LEgvfKGd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779804857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EgJnPtJHohc4ZdHfAiAPuS/mUJn7VAHeML3YyO3VZKo=;
 b=JRQtLbrb9plkfblpCo4Wz3eugdiTcWdf//R6xC94vW0UgQYHquef5HxKnk0kiABGKW/5Pv
 CrBt5UKVS3Bh9Sv/TuYHUauPnJt53Dde/OuHnpATe87oDzE+X0sw6Nd/3soRR2od6iGWHF
 HwiA5P+YxHX3V9WM/IyzvhqFwGYG71Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779804857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EgJnPtJHohc4ZdHfAiAPuS/mUJn7VAHeML3YyO3VZKo=;
 b=LEgvfKGdiVN4w0zckDw5KVY5M4dN/SjgT81QT+Z4Ub1QeO3OcB+JkEg0BPNKOGvmb6Vs3I
 MRGDZ2t2jJi/fBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B7915A248;
 Tue, 26 May 2026 14:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eDSzOLiqFWqbIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 May 2026 14:14:16 +0000
Date: Tue, 26 May 2026 16:14:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260526141411.GB175193@pevik>
References: <20260526083650.14036-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526083650.14036-1-wegao@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4A2D065731
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] min_free_kbytes: Handle transient memory drops
 in check_monitor
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
>  	while (!end) {
>  		memfree = SAFE_READ_MEMINFO("MemFree:");
>  		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);

>  		if (memfree < tune) {
> -			tst_res(TINFO, "MemFree is %lu kB, "
> -				 "min_free_kbytes is %lu kB", memfree, tune);
> -			tst_res(TFAIL, "MemFree < min_free_kbytes");
> +			/*
> +			 * Give it some time to reclaim. The kernel should keep
> +			 * MemFree above min_free_kbytes, but transient drops
> +			 * are possible under high pressure.
> +			 */
> +			for (i = 1; i < 1024; i *= 2) {
> +				usleep(i * 1000);
> +				memfree = SAFE_READ_MEMINFO("MemFree:");
> +				if (memfree >= tune)
> +					break;
> +			}
> +
> +			if (memfree < tune) {
> +				tst_res(TINFO, "MemFree is %lu kB, min_free_kbytes is %lu kB",
> +					memfree, tune);
> +				tst_res(TFAIL, "MemFree < min_free_kbytes");
nit: TINFO message followed by TFAIL message is not optimal. I'd either always
print TINFO:

			tst_res(TINFO, "MemFree is %lu kB, min_free_kbytes is %lu kB",
				memfree, tune);

			if (memfree < tune) {
				tst_res(TFAIL, "MemFree < min_free_kbytes");

or combine info in the error message:
			if (memfree < tune) {
				tst_res(TFAIL, "MemFree %lu kB < min_free_kbytes %lu kB", memfree, tune);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
