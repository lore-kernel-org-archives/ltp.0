Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A2CC87FD1
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 12:22:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25013C2C78
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 14:22:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 119F63C2707
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 14:21:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5D0B660024C
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 14:21:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97BB221990;
 Tue,  5 Aug 2025 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754396514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqTAks9wujP6xv4y98O4BiGpcRqKvvNW632UHwv0MP8=;
 b=hPG84OJ3LEGL8JuDASxIa48l4qrBrZ7GX07MRDoZS8gg1odzA5PSp8e9ptevJKUEZOYo9I
 Y6VsZCbMSF3ZbUe6H2CKQ/iylCCFTKhn3gJIa67WioOYvtD2Be6nJfyvjLhqhlrdXBqMwX
 bIkJz1t751uiAPjmtbb7WX6jr7jkxSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754396514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqTAks9wujP6xv4y98O4BiGpcRqKvvNW632UHwv0MP8=;
 b=nT35SvK+YgaRQWt+WRFCNbwJvlbhDc22Pz2WILuj2Qe9xpk+5ZjfkoEa2Q297kOxqDK9gE
 xhk50xQRry+AOOAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754396513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqTAks9wujP6xv4y98O4BiGpcRqKvvNW632UHwv0MP8=;
 b=VfGS74Ahp3SEsK4+WtuTDUQ11gwkxZRUilzyFxp5dYFqrrvJGUFqQ1Eu3k1YIZF17ac2Yr
 c9wae0ngoxJBK0mDoMp40FPahkdWaPW6wtjT5sc/y8z4X711Pm4NF47aDUm6ry5rOSo7y4
 1jj0XGrYzr6azhFMo0ghknJlpuVGN2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754396513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqTAks9wujP6xv4y98O4BiGpcRqKvvNW632UHwv0MP8=;
 b=KcRRgoL784d0sqGXzOdWfK4KUoio0O0a/OCCcw6oBLTO2B/vsF3RC2rUZirI9TLn2TdWKv
 vghSTf+b/6G4MGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 866A513A50;
 Tue,  5 Aug 2025 12:21:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8bKaH2H3kWgTBgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Aug 2025 12:21:53 +0000
Date: Tue, 5 Aug 2025 14:22:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aJH3kho29ad5UY58@yuki.lan>
References: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
 <20250805-file_setattr_getattr-v3-6-67a7747d226c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250805-file_setattr_getattr-v3-6-67a7747d226c@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 6/6] Add file_attr03 test
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
> +static void run(void)
> +{
> +	dfd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
> +	fd = SAFE_CREAT(MNTPOINT "/" FILENAME, 0777);
> +
> +	TST_EXP_PASS(file_setattr(dfd, FILENAME, attr, FILE_ATTR_SIZE_LATEST, 0));
                                  ^
				  Just for a completion I would use
				  AT_FDCWD in this test so that we test
				  both dirfd (in previous test) and
				  AT_FDCWD (in this test)


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
