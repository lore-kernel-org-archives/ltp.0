Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE631C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 12:35:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0E953E5DBF
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:35:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5BAC3DFABE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:35:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 21737600864
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:35:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7221221D4;
 Fri, 28 Aug 2026 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787920507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnvNg4U2DTVhbi7rLfGMB9Y+H3Hg9HsmBQUx3huWZa8=;
 b=r4rcikAbKldv0OGVGpt/5wdbDZUMWbBEE3ZtS3nrHMaVgtU34lu1Fcigqp56xTk2Sg74SJ
 NPCbVANO89q9wCDmKgXG94zo14W6npoXUSZMgqcqkxEiUefLd8Ohcpr8Wn50+o3FtRmjez
 5Jtcu0l+QRZYKJxtQiWouijMJYdtDnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787920507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnvNg4U2DTVhbi7rLfGMB9Y+H3Hg9HsmBQUx3huWZa8=;
 b=r4m6SypblvtOFo+51RkbGCZjHqF9Nt4bTBr6zJQXFBC0JGES3/yxULpcv3Oc7yHqvmUa5f
 R0oBJjlyP4Mr5LBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tHDHRc7X;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7Fo310kc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787920503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnvNg4U2DTVhbi7rLfGMB9Y+H3Hg9HsmBQUx3huWZa8=;
 b=tHDHRc7Xhiyh33Jp2kYNbn8kOM+Un8NTtA9iYxr78F2wQHrY7fBUSQdVny4dFjumWhiFFR
 leXPh5cgSCiQ95fD6sS6FxCEz2huToATog+7Vo0qO5AYhtLDaatjWTNKEhBQc4kE5HaDo9
 jvPfRZwKpdjNp4xmGP62mgy/BKkg3KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787920503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnvNg4U2DTVhbi7rLfGMB9Y+H3Hg9HsmBQUx3huWZa8=;
 b=7Fo310kcVYjlFRxwz58dx0oY9oUn4Wy5iBRsmmfE81IxUuJsiHXZfeQzej19/xCGOm5O3/
 sRY9VH8zOWaSxUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1A8C1352D;
 Fri, 28 Aug 2026 12:35:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GutyJ3eAkWoMOAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Aug 2026 12:35:03 +0000
Date: Fri, 28 Aug 2026 14:35:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <apGAei1EG3ioALnL@yuki.lan>
References: <20260817064052.304786-2-piotr.kubaj@intel.com>
 <2ae1b4ad5c5212d346387aa6b61b2e97c9d69b1c.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ae1b4ad5c5212d346387aa6b61b2e97c9d69b1c.camel@intel.com>
X-Rspamd-Queue-Id: C7221221D4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] pmc_core: add test for
 pkgc_blocker_residency_show
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
Cc: "Niestepski, Daniel" <daniel.niestepski@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> One question: there doesn't seem to be a way to check whether debugfs
> is mounted, apart from implementing it myself. I have another test in
> the queue for LTR counters that also uses debugfs. Does it make sense
> to put that debugfs check somewhere in the framework, or do you prefer
> it to be put directly in the tests? It's about 25 LOC.

If more than one test would use it makes sense to add a library support
for mounting debugfs.

Also generally distributions are moving into not mounting debugfs by
default, since there have been security implications of exporting
internal kernel state by default. So it would make sense to add
.needs_debugfs flag to the tst_test struct that would cause the library
mount (and later umount) debugfs at .mntpoint unconditionally.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
