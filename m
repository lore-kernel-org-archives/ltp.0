Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F7DC5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 15:41:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE4F33CD5FD
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 17:41:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1937A3CD5F1
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 17:40:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F132020092C
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 17:40:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20CFF3E79
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787154039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+IwnhV1e1SVWOJo9wVJXJQwnB5D4SbMvTcYyMr6xdUs=;
 b=YVVHa5hC/hawJWR5JD8Nzhg6zqbQGOBmEYiGnOwqta4HpPpYYFKM04YdOnTukk0bhhSuw0
 W6DPQoNUyB6plydMzKWLZmmDy/+r+AvRtAB434fXG1wLgRlbev1gdvJZ3RwZHELh4N3za7
 GA76dPzhKnDHuXWCtR1SN+LHAwCq3kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787154039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+IwnhV1e1SVWOJo9wVJXJQwnB5D4SbMvTcYyMr6xdUs=;
 b=I5h23DkjoYc8vBg8Omp/zN0oAyJgNUYVoNbjd7Fj7tR4PuPpB1pq+I8+68XP56rcek7VGD
 StQNkYAEh1exzKAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZDlM4cif;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="TSk7/xgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787154035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+IwnhV1e1SVWOJo9wVJXJQwnB5D4SbMvTcYyMr6xdUs=;
 b=ZDlM4cifQqfETbJKDNsFzvaCOhKuHN9cF0wwUYssoo3KU5OLf5OK7bfttlmANUInibPB+0
 6hJu5R5x7glzd+HspaKBt0PpUnuo++70CyRWmZcoI79fPuDOXLUbV4NAGvPj1LhRIYhBDi
 H7hc8Yh5ziduyUgYuf2bCiX/5mczDws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787154035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+IwnhV1e1SVWOJo9wVJXJQwnB5D4SbMvTcYyMr6xdUs=;
 b=TSk7/xguZwye/gfQOaOobCi8pNi33EJ+C/nOnW3BYliy0r6SMD0rnpULkUCDj973HlXw76
 3qY/G+6pjw7YvMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B4DD362E
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 15:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1BmwAXPOhWqGTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 15:40:35 +0000
Date: Wed, 19 Aug 2026 17:40:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <aoXOd5N0mr2UWH95@yuki.lan>
References: <20260818141311.1265557-1-chrubis@suse.cz>
 <20260818141311.1265557-24-chrubis@suse.cz>
 <aoUROJGM1mDGTqjA@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aoUROJGM1mDGTqjA@linux.dev>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 20CFF3E79
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 23/31] testcases: sysfs: Add sys_net04
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Here I got intermittent fails in local test:
> 
>   sys_net_common.h:32: TFAIL: st->operstate (up) != operstate (down)
> 
> The possible reason is kernel asynchronous update race condition.
> The test reads operstate immediately after closing the FD, catching
> the stale "up" state before the kernel's background workqueue has
> time to update it to "down".

Looks like this was pointed out by the ltp-reviewer as well.

> Maybe we can add a polling mechanism with a timeout to wait for
> the operstate to transition.

Will do in v2.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
