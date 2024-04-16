Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F829C04FF9
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 14:47:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 694433CFAF4
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 16:47:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9A823CFAD7
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 16:47:08 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED2F11405176
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 16:47:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9AD785F8D0;
 Tue, 16 Apr 2024 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713278826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmzQfXX9oV1bM1xP2sW8LbX3AYEOC5T7PpGQDUNJUpw=;
 b=cEYk5306XPtegJTnOX51J4COku1xI4Q/RPobYRiZTqY/Lx9fxmb1SEq5e2UMeKJjUClU/9
 VbQFBteesK8od1sckc35qH8mHYn5oE4CsNjG6PS8RCziY6TVlOv+lDLtek5O+qLTZJ2p2/
 emxzPRqofuS3rB6GlluMJcfBeSy0C7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713278826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmzQfXX9oV1bM1xP2sW8LbX3AYEOC5T7PpGQDUNJUpw=;
 b=/apaqOwfwh/4SjUgNgZXrTOAO37lXK5HxfuP2fpOcThvOZCMrQno84THyb7pZtQ5UdQ+1f
 3nHxSbyJ4wjQ+tAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xVUUqr1a;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HuRoPDRW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713278825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmzQfXX9oV1bM1xP2sW8LbX3AYEOC5T7PpGQDUNJUpw=;
 b=xVUUqr1auDmk9O3iEHTYhhTZbzBo33OHBGEpfFdlVvy1XWEMY22Am2d1AhkZ4JPBNWs9GY
 KADvoE7hcrLVkbFMsULwyiM4eNSTshJexKb5mrOjnGM1vh8TIfnjnpYXVpXqUe1W3Xt7SO
 v4qc2eHahvznpRekS99WIF4WlEpK7fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713278825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmzQfXX9oV1bM1xP2sW8LbX3AYEOC5T7PpGQDUNJUpw=;
 b=HuRoPDRWqcgP4GEqCF8r9lZwp7U7B7nOk4mtHVTvRkwNsrHagwUUBOr4q1uHEsU7t2Iac3
 GPZsd0LdfA4pFGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 888A113432;
 Tue, 16 Apr 2024 14:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rbMQIWmPHmZodwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 16 Apr 2024 14:47:05 +0000
Date: Tue, 16 Apr 2024 16:46:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Zh6PMc8PlTYLj3RN@yuki>
References: <20240415121719.3798-1-andrea.cervesato@suse.de>
 <Zh54TZT7boknYdN8@rei>
 <2c65cdac-d874-4796-b8e2-260c8aa0e7cf@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c65cdac-d874-4796-b8e2-260c8aa0e7cf@suse.com>
X-Spamd-Result: default: False [-3.47 / 50.00]; BAYES_HAM(-2.46)[97.55%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9AD785F8D0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] doc: Add new API conversion stats
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
> I can filter out .h and .c eventually, but the problem is that 
> implementing inside headers is a bad practice by itself and it's not 
> easy to recognize automatically.

The header that includes test.h tends to be also include from more than
one test, hence I suggested to fix the tests instead...

> I tried at first, but it's quite confusing to add this in the same 
> section and creating a new page seems a bit too much.

Fair enough.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
