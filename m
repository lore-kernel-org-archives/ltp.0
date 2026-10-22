Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34B606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Mr+Y5TVM;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aC7fgBvn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Mr+Y5TVM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aC7fgBvn
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6CDA3D26C5
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:07:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DBAF3D2411
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:07:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6089C602086
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:07:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6A622205E;
 Thu, 22 Oct 2026 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792674445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f4QW2Yd4hVEd77+sv28AdlB2M5Hx1QW9Jxus0dDIbeE=;
 b=Mr+Y5TVM7Uf60BOhkVePQT0007iOSxyifaebe8ZGLkPYDFtYB3QWPO8vfEt9CA7YGS89DV
 mOMX3AP6row80aoQW2YsJ6YlNU5uw18HeLrW59uIBn1mvagjlZ4P7ysq4QOS0TOwQibL2H
 FI4zl8b5v7XOZ7TewmgLvUiHj7u4T+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792674445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f4QW2Yd4hVEd77+sv28AdlB2M5Hx1QW9Jxus0dDIbeE=;
 b=aC7fgBvnOi2Y3wQCBzr3ivqO/WXzDA69UQMEEzPGq305xk8qG3UuEUPJWo70JYvp4A2BvJ
 kzjYvSPwv8Oh3ACw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792674445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f4QW2Yd4hVEd77+sv28AdlB2M5Hx1QW9Jxus0dDIbeE=;
 b=Mr+Y5TVM7Uf60BOhkVePQT0007iOSxyifaebe8ZGLkPYDFtYB3QWPO8vfEt9CA7YGS89DV
 mOMX3AP6row80aoQW2YsJ6YlNU5uw18HeLrW59uIBn1mvagjlZ4P7ysq4QOS0TOwQibL2H
 FI4zl8b5v7XOZ7TewmgLvUiHj7u4T+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792674445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f4QW2Yd4hVEd77+sv28AdlB2M5Hx1QW9Jxus0dDIbeE=;
 b=aC7fgBvnOi2Y3wQCBzr3ivqO/WXzDA69UQMEEzPGq305xk8qG3UuEUPJWo70JYvp4A2BvJ
 kzjYvSPwv8Oh3ACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98636134E6;
 Thu, 22 Oct 2026 13:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6lhTHY0K2mo0VgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Oct 2026 13:07:25 +0000
Date: Thu, 22 Oct 2026 15:07:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <atoKordoJ70aqMHk@yuki.lan>
References: <20261022115410.23845-1-sebastian.chlad@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261022115410.23845-1-sebastian.chlad@suse.com>
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_device: Scale loop device detach timeout
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> detach_loop_fd() retries LOOP_CLR_FD 40 times in 50ms steps, a fixed
> 2s timeout that ignores LTP_TIMEOUT_MUL. When another process still
> holds the loop device at cleanup for longer than that, e.g. on a
> loaded machine, the test ends with a spurious
> "ioctl(/dev/loopN, LOOP_CLR_FD, 0) no ENXIO for too long" TWARN.
> 
> Scale the number of retries with tst_multiply_timeout(), which attach
> already uses since d90d20046 ("lib: Use backoff polling to wait for
> loop device nodes"). The default stays 2s, multiplied by 4 on kernels
> with slow kconfig options and by LTP_TIMEOUT_MUL. The 50ms polling
> step is kept, so the detach still finishes shortly after the device
> is released.

It would probably be better if we used the TST_RETRY_FN_EXP_BACKOFF() in
the detach loop instead so that the deatch is fast on fast device but we
do not poll unecessairly fast on slow devices.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
