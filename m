Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A975F8A15B
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:48:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34C613E2DEB
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:48:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FCD33E1DD1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:47:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C94221400BC1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:47:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5CAE5BCEF;
 Thu, 16 Apr 2026 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776336462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LBhPlFSdbZp4+o5evfO1W9wCqGqoL4oByvpk7YqAvE=;
 b=PKw8YpeUgrzEcwLpRmyPkwkn+B8mT8XKXuQ4IuJcEUfyONd3ChbZ5m0LAhfsI46VDCGpFA
 b7rEBZ51ADWTcauX22dHaQ/vfdkzJHQYbbbRIG+ezUB5ZCiPmRbISpa0zIMuUsYyb9a1SQ
 2srQ2hpdHQ87/W3Shj/4sWqmL9iA4MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776336462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LBhPlFSdbZp4+o5evfO1W9wCqGqoL4oByvpk7YqAvE=;
 b=eCcqaB2W+aTanXsPcxaOTtH+tz2sr4v1f5EKe/jBBgUiycuQFfETTX622HO9XG2DADg+4s
 8bVxAp0+3uHGW8Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776336462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LBhPlFSdbZp4+o5evfO1W9wCqGqoL4oByvpk7YqAvE=;
 b=PKw8YpeUgrzEcwLpRmyPkwkn+B8mT8XKXuQ4IuJcEUfyONd3ChbZ5m0LAhfsI46VDCGpFA
 b7rEBZ51ADWTcauX22dHaQ/vfdkzJHQYbbbRIG+ezUB5ZCiPmRbISpa0zIMuUsYyb9a1SQ
 2srQ2hpdHQ87/W3Shj/4sWqmL9iA4MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776336462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LBhPlFSdbZp4+o5evfO1W9wCqGqoL4oByvpk7YqAvE=;
 b=eCcqaB2W+aTanXsPcxaOTtH+tz2sr4v1f5EKe/jBBgUiycuQFfETTX622HO9XG2DADg+4s
 8bVxAp0+3uHGW8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 922BF593A3;
 Thu, 16 Apr 2026 10:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vhrUIk6+4GmnOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Apr 2026 10:47:42 +0000
Date: Thu, 16 Apr 2026 12:47:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aeC-WNVQb0yGZ2Se@yuki.lan>
References: <20260414-ci_fix_missing_builds-v1-1-c5aee6b80507@suse.com>
 <69e0b62c.050a0220.2631f9.3cc5@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69e0b62c.050a0220.2631f9.3cc5@mx.google.com>
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.de,lists.linux.it,suse.cz,gmail.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] patchwork: Use last successful run timestamp to
 avoid missing patches
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Ping, this is quite important because the current CI is failing
> quite a lot.

Maybe I'm blind but I do not see this patch neither in my mailbox nor in
patchwork queue.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
