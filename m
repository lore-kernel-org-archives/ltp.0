Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B83CAC5BB
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 04:39:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BB153CE674
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 06:39:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65D6B3CC9D7
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 06:38:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DC06600937
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 06:38:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 982E91F38F;
 Wed,  8 Oct 2025 04:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759898317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
 b=zSHhXcz+gBlWWqLaLUC6vRw2OGeQGnjLp+aw4/OB8JVSFOmTPDBP9XRTvux8UeUMOE1yNi
 UYRee7+ICsQV57g0QVW+n6YJ997jMhRn67L7z7hqBjaa4unWFuo9whDrbTktn/ZLOmMyRn
 HBejcEtbldcI3PTEpxQM2c075xlhip8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759898317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
 b=GddHVa5AdIU4QiUJkkv53LLVVWOuZrLdD/4qKP4MM1aY5bKXpxgrrXPOx5DanDaz8X7Npq
 wmJObv7/2wbCvmCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zSHhXcz+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GddHVa5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759898317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
 b=zSHhXcz+gBlWWqLaLUC6vRw2OGeQGnjLp+aw4/OB8JVSFOmTPDBP9XRTvux8UeUMOE1yNi
 UYRee7+ICsQV57g0QVW+n6YJ997jMhRn67L7z7hqBjaa4unWFuo9whDrbTktn/ZLOmMyRn
 HBejcEtbldcI3PTEpxQM2c075xlhip8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759898317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
 b=GddHVa5AdIU4QiUJkkv53LLVVWOuZrLdD/4qKP4MM1aY5bKXpxgrrXPOx5DanDaz8X7Npq
 wmJObv7/2wbCvmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B33A13693;
 Wed,  8 Oct 2025 04:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /VItHc3q5WhlKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Oct 2025 04:38:37 +0000
Date: Wed, 8 Oct 2025 06:38:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20251008043836.GA178062@pevik>
References: <20251002083701.315334-1-pvorel@suse.cz>
 <20251002083701.315334-3-pvorel@suse.cz>
 <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com>
 <20251006112136.GA82874@pevik>
 <DDB7LLBEXIQM.2KSWEVEFU0TVS@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DDB7LLBEXIQM.2KSWEVEFU0TVS@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 982E91F38F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > verify_measurement() writes into /sys/kernel/security/ima/policy which on
> > kernels without CONFIG_IMA_WRITE_POLICY requires SUT reboot. Because LTP does
> > not support any reboot, this needs to be handled after test finishes. That's why
> > I separated the tests. This helps to cover more than the first test case out of
> > four.

> Now I see, this is clearly a corner case given by LTP limitations. I
> think we should probably start to think about reboot flag then. Once the
> PR for the new SUT will be implemented in kirk, it's time to work on
> this.

I would not wait for this as this is a long term project (on both LTP side and
IMA tests being converted into shell API at least). Once there is this
functionality implemented the split can be reverted.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
