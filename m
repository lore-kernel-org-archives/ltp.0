Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B434C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:23:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BAC33CF963
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:23:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFF7A3C8E42
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:23:30 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2F030200AC6
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:23:29 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C6381F848;
 Tue, 30 Jan 2024 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GnL2+/lnmOpjM+vMGWM1c/C8RyMplr3URa91ckF6MAY=;
 b=uwTzqdLFAlvcSn7x1pcMkHMmr1fCfHex6f1mZIqJ3qLM31EUnOu7//KM47usq86X8NPf3Z
 heCohBn5f+JuCaGeUNTbSUlYFm5Oh9NwWOe6JNU1jwb+XssCopeFFcqieXBGWuoJ3BOTsr
 /xFcNxOBvaMGzli6xQ8JY/YiMrPogkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GnL2+/lnmOpjM+vMGWM1c/C8RyMplr3URa91ckF6MAY=;
 b=+S4aPdR1cDyOiti0/U1qTypWHl00jcRtCcmWhbn1s68PRIDgblBnLzOIxLebNwgXyBqNcs
 /V87bUrpInIavICA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GnL2+/lnmOpjM+vMGWM1c/C8RyMplr3URa91ckF6MAY=;
 b=uwTzqdLFAlvcSn7x1pcMkHMmr1fCfHex6f1mZIqJ3qLM31EUnOu7//KM47usq86X8NPf3Z
 heCohBn5f+JuCaGeUNTbSUlYFm5Oh9NwWOe6JNU1jwb+XssCopeFFcqieXBGWuoJ3BOTsr
 /xFcNxOBvaMGzli6xQ8JY/YiMrPogkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GnL2+/lnmOpjM+vMGWM1c/C8RyMplr3URa91ckF6MAY=;
 b=+S4aPdR1cDyOiti0/U1qTypWHl00jcRtCcmWhbn1s68PRIDgblBnLzOIxLebNwgXyBqNcs
 /V87bUrpInIavICA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D37113212;
 Tue, 30 Jan 2024 12:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 10MFAUHquGWHGwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 12:23:29 +0000
Date: Tue, 30 Jan 2024 13:23:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240130122327.GE766274@pevik>
References: <20231218131142.12464-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218131142.12464-1-wegao@suse.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uwTzqdLF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+S4aPdR1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[21.47%]
X-Rspamd-Queue-Id: 2C6381F848
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fs_fill_btrfs: btrfs fs_fill test set
 mkfs.btrfs -s 4k
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

Hi,

> On PPC64 the page size is 64K and this causes trouble on btrfs
> filesystems of small size(LTP currently use 300M), the threads
> could compete for a very small number of pages/blocks to actually
> write the data. So force the test case with sector size 4k.
> e.g. mkfs.btrfs -s 4k

there were other fixes merged, therefore closing this.

7d39a10b7 ("fs_fill: Increase timeout to 5 min")
848dd6fba ("fs_fill: Increase test loop device size to 1GB")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
