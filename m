Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C2CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:58:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3055A3E5849
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:58:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD9EC3E56D3
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:58:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 47BEA1A00430
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:58:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B24161F385;
 Tue, 29 Sep 2026 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790693903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWCLLX+4BAPKkjqZ1BeWxDk4413+iQPjl60pbM87Sic=;
 b=QcnIINwSQrQDGkefltHu4D4RqK8he+N+QsAe0L69sA+wCuMU+5AxsW3vb80QRnZG604HV9
 m7nq4hPIhCE627C4JwyRAA1lQlNkGjazvLndCQcPA4ayzYZYrClVDkJEAR2G/bv+8HJ7c2
 gbL0omnbPBraWgjTFk+xQ0UmAE2rggU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790693903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWCLLX+4BAPKkjqZ1BeWxDk4413+iQPjl60pbM87Sic=;
 b=UjsK8/HAO7nSnehbEVaGx6HgiyQhDKgXz1LQEwYmjpKigen2nhhjgmgl3g/9F9j5TxTrO+
 UJu/vSsppqyb/VBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790693899;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWCLLX+4BAPKkjqZ1BeWxDk4413+iQPjl60pbM87Sic=;
 b=Iv0zAFx6BxrdVeZrb6kaZhbccWxHwsVwkw1jgO/oWqDyXKtTTPCBctu22o7mqfpEZTUzFS
 49E4X9BBpMVAEOSZZIlResoUXzgJzaD5lqDswjYL9MSV9I2dCXtJMSxxGM3qoZ8sLBg6YE
 +L72j5co0/q2OjcmGiQX6CYQWVjvfsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790693899;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWCLLX+4BAPKkjqZ1BeWxDk4413+iQPjl60pbM87Sic=;
 b=dOx/0uCkwo0dx/cuEbeZvK9pqMkV6XsjcL5DKhKPNC7wCGmI4vQ8zEc4NMNO8OlQ61Y4Hn
 1rkVrzPuTERdiuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 447C6136E4;
 Tue, 29 Sep 2026 14:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /hATBgvSu2pSfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 14:58:19 +0000
Date: Tue, 29 Sep 2026 16:58:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260929145817.GD2462033@pevik>
References: <arvN7MPnBolwnT3z@yuki.lan>
 <6abbce8c.aec4f0e4.fd74d.fe52@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6abbce8c.aec4f0e4.fd74d.fe52@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_ctl06: Fix BPF map on old kernels
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

[ Cc Red Hat folks ]

> Hi Cyril,

> > Should't this be guarded with kernel version? I.e. only enabled for
> > kernels older than 5.8?

> At the beginning i did that, but then i thought that probably there are
> kernels backporting this feature. i.e. REHL

I'd also skip it for older kernel unless somebody reports it's needed.
(Simplicity wins in the long term.)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
