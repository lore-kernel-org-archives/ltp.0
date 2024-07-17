Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34985C3DA42
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 08:31:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EC653D1AB8
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 10:31:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6A6E3D0C85
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:31:25 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2EC4D600292
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:31:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD6AF1FB63;
 Wed, 17 Jul 2024 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721205079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dx1rRmL8k0gNEsRtWqE3pTBg0frrYwfV8SwqUwcCdnA=;
 b=yxf5ARwHfNHiApN0cXenIBj+Lk+d4+f2XiJ5LX+wjGsIfImjqSnPIilzgSutbZ9cMiN310
 frBwCEfI02cOdsAsfOO3LwzJAeZKalSsrDM2mQ1Zk1EdIZifIm9gYNVBiuSHBSJH9anHWh
 3mWaDU0HQkBtGFEiGltmupwaKX5xJLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721205079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dx1rRmL8k0gNEsRtWqE3pTBg0frrYwfV8SwqUwcCdnA=;
 b=iFodB0zuBDGnfRaU36KuUCSyCki5fT5SgpUfVXea9g4l0XDyTPuglgvlSbgwrZyFShK/0a
 FWDSYIHoTX29W+Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721205079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dx1rRmL8k0gNEsRtWqE3pTBg0frrYwfV8SwqUwcCdnA=;
 b=yxf5ARwHfNHiApN0cXenIBj+Lk+d4+f2XiJ5LX+wjGsIfImjqSnPIilzgSutbZ9cMiN310
 frBwCEfI02cOdsAsfOO3LwzJAeZKalSsrDM2mQ1Zk1EdIZifIm9gYNVBiuSHBSJH9anHWh
 3mWaDU0HQkBtGFEiGltmupwaKX5xJLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721205079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dx1rRmL8k0gNEsRtWqE3pTBg0frrYwfV8SwqUwcCdnA=;
 b=iFodB0zuBDGnfRaU36KuUCSyCki5fT5SgpUfVXea9g4l0XDyTPuglgvlSbgwrZyFShK/0a
 FWDSYIHoTX29W+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E71E1368F;
 Wed, 17 Jul 2024 08:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JlkLFFeBl2YhFAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 08:31:19 +0000
Date: Wed, 17 Jul 2024 10:31:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20240717083116.GA587967@pevik>
References: <20240712134412.30853-1-chrubis@suse.cz>
 <20240717082547.GA584952@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240717082547.GA584952@pevik>
X-Spamd-Result: default: False [0.50 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > +/**
> > + * tst_tmpdir_path - Returns a pointer to a tmpdir path.
> > + *
> > + * The returned path is allocated and initialized the first time this function is
> > + * called, each subsequent call will return the same pointer.
> > + *
> > + * @return A newly allocated path. The memory is freed automatically at the end
> Return must be 'return:', otherwise it's not recognised.

>     * return: A newly allocated path. The memory is freed automatically at the end

> > + *         of the test. If allocation fails the function calls tst_brk() and
> > + *         exits the test.
> > + */

Also, formatting other lines with indent makes " A newly allocated path. The
memory is freed automatically at the end" to be bold. The correct formatting is
therefore without indent:

/**
 * tst_tmpdir_path - Returns a pointer to a tmpdir path.
 *
 * The returned path is allocated and initialized the first time this function is
 * called, each subsequent call will return the same pointer.
 *
 * return: A newly allocated path. The memory is freed automatically at the end
 * of the test. If allocation fails the function calls tst_brk() and
 * exits the test.
 */
char *tst_tmpdir_path(void);

/**
 * tst_tmpdir_mkpath - Construct an absolute path pointing to a file inside tmpdir.
 *
 * Constructs a path inside tmpdir i.e. adds a prefix pointing to the current
 * test tmpdir to the string build by the printf-like format.
 *
 * @fmt: A printf-like format string.
 * @...: A printf-like parameter list.
 *
 * return: A newly allocated path. The memory is freed automatically at the end
 * of the test. If allocation fails the function calls tst_brk() and exits the
 * test.
 */
char *tst_tmpdir_mkpath(const char *fmt, ...)
	__attribute__((format(printf, 1, 2)));


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
