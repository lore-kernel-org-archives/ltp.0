Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A18FFEEF2A
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 12:01:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0DBA3E29B4
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 14:01:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59D9A3C2150
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 14:01:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B8262200778
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 14:01:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D0D44E433;
 Tue,  7 Apr 2026 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775563274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaWPPG2JBOXbo8nQqI0EB5QLUjxDd3UtC/lY9A1A5Ds=;
 b=OTMfQkunypNjqrx9KVJllhs1cn+3RS13/1ftnHU6KMYzNJKA4D1uuaSWrClGQ/DGappbvh
 Q00PuAqEoRL0iwkIwV+zCc7GTFpNB4RWHgWqH6WX9VFx/KqzTxbPXV+cSRdFzgox0xd9uF
 CfzxJvK4LQViImik4WZy8mZyJ8AwHuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775563274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaWPPG2JBOXbo8nQqI0EB5QLUjxDd3UtC/lY9A1A5Ds=;
 b=tuF3kDJ5wNk2nO/u+88EE29m9eNxuQeyuFMyUNYyIQe+hvlRtIA3TwMxAC0wHPVeq5of5C
 eSRz/vujpyAVEIDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WL7oK1U0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RHbYyHOV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775563269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaWPPG2JBOXbo8nQqI0EB5QLUjxDd3UtC/lY9A1A5Ds=;
 b=WL7oK1U0nSXIoopH9qhuKEPDxrVZaf8CNSPpKxnzE6U3/Q3QyeqLlz6Or9ja9hw7ZXAY81
 Brug9gjM5TcyGsfo+7EQmEka+27DTdWmAghXI7mvhUkNuebOMKkqDHvjYfupa36W8Q238U
 cj9ghuAL0hzOLh1aRjzzsZyRaVY3Ck0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775563269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaWPPG2JBOXbo8nQqI0EB5QLUjxDd3UtC/lY9A1A5Ds=;
 b=RHbYyHOVAYZW0VoGnti2CAzjeTlHNo2clAiaFW2kiqkkF6Nx/M0IrrtnryF1gRH7W75/kQ
 2o4be08wYDR13rCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AE454A0B0;
 Tue,  7 Apr 2026 12:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n7ToAQXy1GlBeAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 12:01:09 +0000
Date: Tue, 7 Apr 2026 14:01:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <adTyD98tVRCJFUuY@yuki.lan>
References: <20260304144424.10101-1-chrubis@suse.cz>
 <20260306125417.GA528953@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260306125417.GA528953@pevik>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1D0D44E433
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: ulimit01; Convert to the new library
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
> > +/*\
> > + * Tests the basic functionality of ulimit() with UL_GETFSIZE and UL_SETFSIZE.
> nit: Could you please change before merge ulimit() to
> :manpage:`ulimit(3)`
> so that we get link to https://man7.org/linux/man-pages/man3/ulimit.3.html ?

Fixed and pushed, thanks.

> FYI kernel uses automarkup to recognise various things e.g. git hash [1].
> Maybe we could employ it for git kernel commits.
> But for man page it can have false positives [2].
> 
> [1] https://lore.kernel.org/linux-doc/87a4ydo1hf.fsf@trenco.lwn.net/
> [2] https://lore.kernel.org/linux-doc/aWqg5XwPRXlzq4FI@devuan/

I think that we should have the kernel commits mostly in the tags which
gets translated based on the tag type, so this shouldn't be needed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
