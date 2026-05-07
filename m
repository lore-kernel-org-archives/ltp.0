Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B071CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:23:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D80D43E5F70
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:23:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A4AA3CE0D0
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:22:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F0F14600818
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:22:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB92C6C3D1;
 Thu,  7 May 2026 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778145774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPYaIklPHsrziBitfeqDAz/T8xnfDQ4OtrIpdk+R4U8=;
 b=XUjVtFUMfD3t+hLs9BwdfeJjOmEwPUlSX4P4+uaD3G/gWWRqz9kbZ5SWysVCXXHI1kfGxv
 bLdkRJ638+6zifL2wP7wUGx2u/3K0xBEyh+v2RlFdQy/Y6wb9IKDWm56YvMvoZqUzfBxWa
 bCm78kqqSXkwfbUCU9+qdge0pMeJr7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778145774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPYaIklPHsrziBitfeqDAz/T8xnfDQ4OtrIpdk+R4U8=;
 b=ecqJOO7d1WLBOy11atygsHw0vReSxTAV4jUHVDZf90xmOY+R6gzC6tgYMUUhLviv9SI2OE
 qwiIpoJiO6ho4WBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XUjVtFUM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ecqJOO7d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778145774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPYaIklPHsrziBitfeqDAz/T8xnfDQ4OtrIpdk+R4U8=;
 b=XUjVtFUMfD3t+hLs9BwdfeJjOmEwPUlSX4P4+uaD3G/gWWRqz9kbZ5SWysVCXXHI1kfGxv
 bLdkRJ638+6zifL2wP7wUGx2u/3K0xBEyh+v2RlFdQy/Y6wb9IKDWm56YvMvoZqUzfBxWa
 bCm78kqqSXkwfbUCU9+qdge0pMeJr7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778145774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPYaIklPHsrziBitfeqDAz/T8xnfDQ4OtrIpdk+R4U8=;
 b=ecqJOO7d1WLBOy11atygsHw0vReSxTAV4jUHVDZf90xmOY+R6gzC6tgYMUUhLviv9SI2OE
 qwiIpoJiO6ho4WBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B652593A7;
 Thu,  7 May 2026 09:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UKqlJO5Z/GkUfAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 May 2026 09:22:54 +0000
Date: Thu, 7 May 2026 11:22:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <afxZ7QDu7Kju1rp3@yuki.lan>
References: <20260316124022.316230-1-pvorel@suse.cz>
 <69b94b3d.050a0220.29aff4.793b@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69b94b3d.050a0220.29aff4.793b@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AB92C6C3D1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kconfig: Don't consider
 CONFIG_FAULT_INJECTION slow
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
> I didn't use fault injection extensively, but I read that when verbose mode is
> enabled we might have a big slowdown, so I wouldn't skip this check.
> 
> Eventually, we can implement a check that verifies if fault injection is enabled
> with a high verbosity. That would probably make more sense.

In this case the fault injection looks like something that you have to
configure before use so I would assume that anyone who configure this
can also adjust the LTP multipliers.

Maybe we can just print TINFO message that the config is on and may
slown donw the execution instead?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
