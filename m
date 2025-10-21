Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80BCCCD1A5
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 10:59:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C49053CF04E
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 12:59:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11AE93CEEE5
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 12:59:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 88A271400DA9
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 12:59:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24A61211DF;
 Tue, 21 Oct 2025 10:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761044380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPamTdI2ZDwyjqaV4gpk+7oKJkR91+ynGqET4tMshTk=;
 b=y0KIv6HdIwPf69jCA5e6hS2lDZ0DkiefpCxafT1bRYzBPuqRww5tV7IZTJbMNBwlTMZ4ZB
 gItW8raq9DI9ie3qUuhcuRi5g5lxUbBqSvRrZWBeF43oBw5llZ/mMcur80QkkhurZdwIMx
 fA/7PnLllpQSmvHle7Lx7CHRjw2xt2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761044380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPamTdI2ZDwyjqaV4gpk+7oKJkR91+ynGqET4tMshTk=;
 b=S+iTP4Ca9swdmTAITu7UEbB0cgB/3j+73YWa0YlXC2qJHGlasJXncOqfdR5pGmMPv+21Z6
 M3RRZCVcNaOC6nDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761044379;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPamTdI2ZDwyjqaV4gpk+7oKJkR91+ynGqET4tMshTk=;
 b=X/3d7QfdpkC4/fC4paYJZGcp4YyaxWHaYLXmpNgMMms9SEpy9iBfS78QRxWzxTfiFOEagK
 iuRlkNOR0wC44UErs8o6ynnh8ZVrf+y7a85X9CBbRKIYZKHdNyM4j7uzyB4BF9YZYEzhte
 M6i8Va70bnufHTAhk6KPI80FYG7jSZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761044379;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPamTdI2ZDwyjqaV4gpk+7oKJkR91+ynGqET4tMshTk=;
 b=mVeOVD2UctSjGO0CyTl1UYq4aLo8bmXE2lYfjQSKkVh2PCpxTzCLU/YVchIIVNY6cZo7QD
 H1tsgZvUwPqMDbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0B4B139D2;
 Tue, 21 Oct 2025 10:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MciHNZpn92g5IgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 Oct 2025 10:59:38 +0000
Date: Tue, 21 Oct 2025 12:59:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20251021105937.GA429244@pevik>
References: <20251017161639.2088158-1-amir73il@gmail.com>
 <20251020202231.GA416401@pevik>
 <CAOQ4uxiaFBi-tpTNFincUS=cwbZahKfPNekhu1Usq=qv-yrJ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiaFBi-tpTNFincUS=cwbZahKfPNekhu1Usq=qv-yrJ-A@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify24: Verify expected count/offset info in
 pre content events
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
Cc: Kiryl Shutsemau <kas@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, Jan, all,

thanks to both! Merged with minor whitespace style fixes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
