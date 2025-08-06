Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D06BC87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 13:29:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF1583C847A
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 15:29:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 773563C07BB
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 15:28:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58AC66003CC
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 15:28:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C22C1FF8B;
 Wed,  6 Aug 2025 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754486924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeSagGIhAirJ1SSQC4BXaIIEMfoeQpVTYLlcxYdrefk=;
 b=ejhBvckv6c48lm2AmCYNBo5XLKFdcgkK945mugZP4KTxydoSj/orWYn3nFGQCMlS6P6vIO
 C5wsw/MDRY763xWPD8r79KZQaATLfxBUrsTeviG65GlbqxtejIBsp+62XK+4blOTWSZbfj
 WOlc3HHKn+6m+VbKDLpLggZUcQKPiuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754486924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeSagGIhAirJ1SSQC4BXaIIEMfoeQpVTYLlcxYdrefk=;
 b=VN9J7v5CjvYcwBXle9wRDlh8Vy+GdCUo5sO5eDFqr6EQoQiYD3UCBlV1C6VswGFulrI3dU
 Y0CGoJVb6y/EC1Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ejhBvckv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VN9J7v5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754486924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeSagGIhAirJ1SSQC4BXaIIEMfoeQpVTYLlcxYdrefk=;
 b=ejhBvckv6c48lm2AmCYNBo5XLKFdcgkK945mugZP4KTxydoSj/orWYn3nFGQCMlS6P6vIO
 C5wsw/MDRY763xWPD8r79KZQaATLfxBUrsTeviG65GlbqxtejIBsp+62XK+4blOTWSZbfj
 WOlc3HHKn+6m+VbKDLpLggZUcQKPiuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754486924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeSagGIhAirJ1SSQC4BXaIIEMfoeQpVTYLlcxYdrefk=;
 b=VN9J7v5CjvYcwBXle9wRDlh8Vy+GdCUo5sO5eDFqr6EQoQiYD3UCBlV1C6VswGFulrI3dU
 Y0CGoJVb6y/EC1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B99113ABE;
 Wed,  6 Aug 2025 13:28:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A3E9FYxYk2imawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 06 Aug 2025 13:28:44 +0000
Date: Wed, 6 Aug 2025 15:29:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aJNYvU7O9qKCI1tU@yuki.lan>
References: <20250801100935.974351-1-pvorel@suse.cz>
 <CAEemH2cvLsgVYkLOuVFZ4FrhqoUBFF54xRW0CF-0JN-tOCO8KQ@mail.gmail.com>
 <CAEemH2c9h97nC6sj323oG2kDvkcEqxspA5DPRrgK=zGSpEFr6w@mail.gmail.com>
 <20250806115217.GB431066@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250806115217.GB431066@pevik>
X-Rspamd-Queue-Id: 6C22C1FF8B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] Makefile: Add kernel modules related make
 targets
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
> MODULE_DIRS := $(shell \
> 	dirname $(grep -l 'include.*module\.mk' $(find testcases/ -type f -name 'Makefile')) | sort -u
> )
> 
> Although this works, I wonder if we want to depend on a shell detection like
> this (I'd appreciate others' opinion).

Looks okay to me. It's much better than hardcoding the paths, we will
likely forget to update any hardcoded info.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
