Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD2AFCD0C4
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:35:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C16C13E58EF
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:35:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 474E93E2383
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:34:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DA1581000DF5
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:34:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 140464D3B9;
 Wed, 18 Mar 2026 13:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773840884;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NqhOqGf3c2mH+lsFJjsbt5bZzdVqMjUBX9Lb1n5TP4=;
 b=bYVchV+Z9KJWqx3a6VBKineUtGUVY0AmwQ0gTbmO9Kze8kYf10hK/fMMAT3a8bitEH/b9k
 rXryXFByj0s/l4eS4TW0dgRCwv6LBfByZrcErvklpx7P6f0xN+m2D172gQQUdggdbaBkap
 r2hi2yTOyX7hPBN8i3w8e0kgliJ6Dt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773840884;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NqhOqGf3c2mH+lsFJjsbt5bZzdVqMjUBX9Lb1n5TP4=;
 b=lB6Pupte0DEUAJE1ycf4oa9gbtrsYO3W7pKGo192/2ea5gjN+46IVXB9ml46Byi3y+DRRg
 WITlVUj5c8p2BABg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bYVchV+Z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lB6Pupte
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773840884;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NqhOqGf3c2mH+lsFJjsbt5bZzdVqMjUBX9Lb1n5TP4=;
 b=bYVchV+Z9KJWqx3a6VBKineUtGUVY0AmwQ0gTbmO9Kze8kYf10hK/fMMAT3a8bitEH/b9k
 rXryXFByj0s/l4eS4TW0dgRCwv6LBfByZrcErvklpx7P6f0xN+m2D172gQQUdggdbaBkap
 r2hi2yTOyX7hPBN8i3w8e0kgliJ6Dt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773840884;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NqhOqGf3c2mH+lsFJjsbt5bZzdVqMjUBX9Lb1n5TP4=;
 b=lB6Pupte0DEUAJE1ycf4oa9gbtrsYO3W7pKGo192/2ea5gjN+46IVXB9ml46Byi3y+DRRg
 WITlVUj5c8p2BABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB76B4273B;
 Wed, 18 Mar 2026 13:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 62njNPOpumkyKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 13:34:43 +0000
Date: Wed, 18 Mar 2026 14:34:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <20260318133442.GA18914@pevik>
References: <20260313125408.480770-2-piotr.kubaj@intel.com>
 <20260316123301.GA313808@pevik>
 <f30646a1e3d1b7bf781385a8d58bc47c52b463fd.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f30646a1e3d1b7bf781385a8d58bc47c52b463fd.camel@intel.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_EQ_ADDR_SOME(0.00)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 140464D3B9
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] high_freq_hwp_cap_cppc.c: new test
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
Cc: "Dubel, Helena Anna" <helena.anna.dubel@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi Piotr,

> > > Verify for all online logical CPUs that their highest performance
> > > value are
> > > the same for HWP Capability MSR 0x771 and CPPC sysfs file.

> > You were supposed to add your RBT:
> > Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>

> > > ---
> > > =A0testcases/kernel/power_management/.gitignore=A0 |=A0 1 +
> > > =A0.../power_management/high_freq_hwp_cap_cppc.c | 57
> > > +++++++++++++++++++

> > You did not add test into runtest/thermal. OTOH test will apply also
> > after we
> > finally merge thermal_interrupt_events.c.

> It's actually not thermal-related, but there are going to be more
> thermal tests anyway.

I'm sorry, I overlooked power_management directory. Anyway, even in new v2
you haven't added a new test into any runtest file.

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
