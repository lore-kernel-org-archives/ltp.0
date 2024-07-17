Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA72C3DA4B
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 08:26:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 876523D1ACE
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 10:26:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 411B53CEF42
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:25:52 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 395EB1A0BC22
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:25:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FFC121B2D;
 Wed, 17 Jul 2024 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721204750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcZPcLx87+9DC/zNyz8I+G2aoOV4g08bCQu2kmHsrHc=;
 b=1x45tXVieCYS4wwBqy3ylM7De/2lG9Fts4I9+BZctva5/3tqDaLFEIFqEWOnzPpO6RLbfV
 FuxrjrJNg1bZnA/NNSWY85Gz0Ajtx264EpSASTeB/2K1LJPrp4CZumkbdj1HHhIH4SesS/
 3u7hKQYnFCmHq7v41oNRYEocs2TMDuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721204750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcZPcLx87+9DC/zNyz8I+G2aoOV4g08bCQu2kmHsrHc=;
 b=g7qhUAFid6S86tOnKq0oiTZs9ulyEX7U6SRbmaWWWF5pVjDtaK43//0C7P0+rIRnRdFWXy
 Nubp17WbUbZv1hDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1x45tXVi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g7qhUAFi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721204750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcZPcLx87+9DC/zNyz8I+G2aoOV4g08bCQu2kmHsrHc=;
 b=1x45tXVieCYS4wwBqy3ylM7De/2lG9Fts4I9+BZctva5/3tqDaLFEIFqEWOnzPpO6RLbfV
 FuxrjrJNg1bZnA/NNSWY85Gz0Ajtx264EpSASTeB/2K1LJPrp4CZumkbdj1HHhIH4SesS/
 3u7hKQYnFCmHq7v41oNRYEocs2TMDuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721204750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcZPcLx87+9DC/zNyz8I+G2aoOV4g08bCQu2kmHsrHc=;
 b=g7qhUAFid6S86tOnKq0oiTZs9ulyEX7U6SRbmaWWWF5pVjDtaK43//0C7P0+rIRnRdFWXy
 Nubp17WbUbZv1hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E391E1368F;
 Wed, 17 Jul 2024 08:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vwc6LA2Al2Y/EgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 08:25:49 +0000
Date: Wed, 17 Jul 2024 10:25:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240717082547.GA584952@pevik>
References: <20240712134412.30853-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240712134412.30853-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7FFC121B2D
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add tst_tmpdir_path() and tst_tmpdir_mkpath()
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

Hi Cyril,

> - tst_tmpdir_path() creates a singleton string copy of the library
>   internal path and returns pointer to it on all subsequent calls.

> - tst_tmpdir_mkpath() constructs a path from the temporary directory
>   path and printf-like format paramters.

> - both functions use guarded buffers to allocate the memory, which
>   especially means that there is no reason to free these strings at
>   the program end.

> - all new library tests are converted to the new API

> + macro is added for new library that fails compilation if old API
>   function is used

> This should solve the absolute temporary directory path handling once
> for all.

Thanks for this! No need for free(), no need to use asprintf() :).

...

> +/**
> + * tst_tmpdir_path - Returns a pointer to a tmpdir path.
> + *
> + * The returned path is allocated and initialized the first time this function is
> + * called, each subsequent call will return the same pointer.
> + *
> + * @return A newly allocated path. The memory is freed automatically at the end
Return must be 'return:', otherwise it's not recognised.

    * return: A newly allocated path. The memory is freed automatically at the end

> + *         of the test. If allocation fails the function calls tst_brk() and
> + *         exits the test.
> + */
> +char *tst_tmpdir_path(void);
> +
> +/**
> + * tst_tmpdir_mkpath - Construct an absolute path pointing to a file inside tmpdir.
> + *
> + * Constructs a path inside tmpdir i.e. adds a prefix pointing to the current
> + * test tmpdir to the string build by the printf-like format.
> + *
> + * @fmt A printf-like format string.
> + * @... A printf-like parameter list.
NOTE: parameters need ':', otherwise it will not be recognised.

 * @fmt: A printf-like format string.
 * @...: A printf-like parameter list.


> + *
> + * @return A newly allocated path. The memory is freed automatically at the end
and here 'return:' as well

It's always safer to generate docs and check it.

With these fixes:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
