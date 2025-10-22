Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA76CCD1AB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 13:37:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5416C3CF105
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 15:37:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 338F53C042E
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 15:37:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7728B1A009A9
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 15:37:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F4CE211A6;
 Wed, 22 Oct 2025 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761140243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s65d1g0AK23ZjFGYi/GWl+O1sLOX1PEME3dJNukoTNk=;
 b=Qm9FnHb6iy5Gr+wtXQy40IM7u/AHA4Z7h0S9pKp2M+nlms7FGxVoKJsPyjkX6yXvwv6a8t
 azDy2apuBs7z7PkSXVN9k5VULd5I0DkMp1eQCUPTwrby6aDpzKCvTBt3Bdm0P2zevzc+Q1
 aqwTNikfjCYPxofEIoSbVoq/eyiyOGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761140243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s65d1g0AK23ZjFGYi/GWl+O1sLOX1PEME3dJNukoTNk=;
 b=NiK2IwUI07R0BfaJxT7Je+iyjdiLCJ7QGYPN/g+pK155BZGTFJ7bU3tEVStWAeOr4wUVym
 +ATISmjepjmP28DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=b1Dz5YWY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1SsIuA2N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761140239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s65d1g0AK23ZjFGYi/GWl+O1sLOX1PEME3dJNukoTNk=;
 b=b1Dz5YWYQChRcQ5IkcA01rpzOWRduoE8fv/Ts5dmQI1Z0crz7W706f6O8hbFlsZKH000uo
 KavX9mGIUGFJoZOZzJc1qBD/xzu2i+cDe6gssO9PEzd4h+WRfvZKWpO4PwHBa85OXqdUv5
 rD5JPcA6KMyZ+b8cAOyrilYywKQdq3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761140239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s65d1g0AK23ZjFGYi/GWl+O1sLOX1PEME3dJNukoTNk=;
 b=1SsIuA2Ncg12sdqNjDlg3JlnLoC3TXaQdSROru203aLO/tf8NvFH9AHL49LJdvkofC+JcK
 BpiUyGYyDGH1kVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 601FF1339F;
 Wed, 22 Oct 2025 13:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dMQ+Fg/e+GjZcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Oct 2025 13:37:19 +0000
Date: Wed, 22 Oct 2025 15:37:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
Message-ID: <20251022133713.GC482903@pevik>
References: <20251022095740.8747-1-mdoucha@suse.cz>
 <20251022131321.GA482903@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251022131321.GA482903@pevik>
X-Rspamd-Queue-Id: 7F4CE211A6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ioctl_sg01: Skip USB devices
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

Hi Martin,

> Hi Martin,

> > Some USB devices write hardware info and flags to the ioctl(SG_IO)
> > response buffer which results in test failure. But the info is constant
> > and doesn't represent any security risk. Skip USB devices to prevent
> > false positives.

> > ---

> > I've tested this patch on kernels v4.4 through v6.16. Non-USB generic SCSI
> > block devices get correctly found and used, USB block device get skipped.

> Thanks a lot for an extensive testing!

> I was also verify on my machine with block device connected over USB
> that it's skipped (and indeed test was blocked on master).

FYI running test with this HDD connected over USB no leaked info was printed (no
false positive), but test runs very slow (10 iterations in ~5 min, it will
likely manage below the limit, but 50x slower run is just waste of time given
vast majority of testers runs tests sequentially).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
