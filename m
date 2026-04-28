Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F4BFF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:25:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A16EE3E2D52
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 11:25:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8567F3C61A8
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 11:24:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8E8E100096E
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 11:24:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB4866A7E7;
 Tue, 28 Apr 2026 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777368287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5SINiMg7/vy54Z8CUMMbR3eVSFb7zr9b+1XZI/FSzk=;
 b=Egljjduza/7TCHr0OJ7t6zrfzbbynICwHnQcWC4g1GLiSR+xd6OOM7VIvPJWLlr5yHjOPm
 kW1BqjaxmGpQhdyhGqZ/ou2kODm/H2IvnETr7gX38q0yniLZfFT1rykbtb5tY84qB1VtpN
 wmhsQLIluo11Ebe7vgXWaZE/804AAYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777368287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5SINiMg7/vy54Z8CUMMbR3eVSFb7zr9b+1XZI/FSzk=;
 b=n5jGMJQDOO6H4P+0C9rAvot4avoTxpMsipEPcZJq9i4d8GfBS07NXurLfzx/Ns7RuL2ErS
 Hvi5PXXZhi8+ZzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777368286;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5SINiMg7/vy54Z8CUMMbR3eVSFb7zr9b+1XZI/FSzk=;
 b=BEI1JXC7jwkix4MetI5oNwG4wz1ORhl/FyOMQXqoltMVdPLmtq5pbn+Ihd2o7yVygkpV2i
 M9vzRTDKLu+DAHz9ehVJV6BrFea+LbqHkvz9CVGTu/PaKx5/za2ZJKlf47V2IYaocqIV8/
 11/dcjydlVL3D45+dVfRDnT+8zfwCZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777368286;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5SINiMg7/vy54Z8CUMMbR3eVSFb7zr9b+1XZI/FSzk=;
 b=TQuuxseCnXnGknt4ngglQ1HmIMhLQKmH24dslv1nBDMOa5k9iD8j/VsYg9Dx3QjPgzE/Cr
 9e2fNeSnadyasWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3343593B0;
 Tue, 28 Apr 2026 09:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IYajMt588GktbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 09:24:46 +0000
Date: Tue, 28 Apr 2026 11:24:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260428092441.GA885773@pevik>
References: <20260406023538.14739-1-wegao@suse.com>
 <20260424102238.GC505126@pevik>
 <aetb7HIEgZoZE8NO@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aetb7HIEgZoZE8NO@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl_pidfd06: Accept both ESRCH and EREMOTE
 for PIDFD_GET_INFO
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
> > I have no idea what superseded this patch. But as Wai prefers it [1] I set state
> > new.  Alternative patch [2] [3], with discussion under v1 [4] [5].
> Thanks for change to new state.

I got ack for my approach from Li and Jan and was pinged by Andrea to merge it,
therefore it got fixed in 068617a55d ("ioctl_pidfd06: Update kernel version")
and therefore closing this as rejected.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
