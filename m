Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B64CD5BD5
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 13:25:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21B6C3CBE28
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 15:25:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 878233C58CC
 for <ltp@lists.linux.it>; Wed, 27 May 2026 15:24:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5B6F600958
 for <ltp@lists.linux.it>; Wed, 27 May 2026 15:24:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D0F46676D7;
 Wed, 27 May 2026 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779888293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5zzZxPnqrLq9R0xtFY4dlfgntex7SQPZDQRGgaKpgw=;
 b=BEF14QNVqbwh+BEQd2n7moq5JdNCjXDhG3ZPyvqSTeV/nyYIA4caEga/r/x8KQlkLN1Q9I
 imo7Gm8KJJ4jkGZ4/NrwFty0zB9KqlJUXASC5jIsUgYAYz5Wde8FOVmBJ8xJ1mOIpYNwxd
 /2112eBHriwni1+Pk6wFNJ42Qhk7A+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779888293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5zzZxPnqrLq9R0xtFY4dlfgntex7SQPZDQRGgaKpgw=;
 b=ugqIuLN5P/wWKD+dvQf0kTHaWF8ctOHItEUVJG/snMeMgArFZTjCFkPNmihJb1CzKVCFmW
 uYjhkK5RVD19SPCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MDry0j9e;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5X74hPfk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779888289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5zzZxPnqrLq9R0xtFY4dlfgntex7SQPZDQRGgaKpgw=;
 b=MDry0j9eMkB+aT3ZHnJYaOgJgUQpmvS2bs7ggE8JGaUBJkhEfFgpHcpIZvckL+M9OKBVt9
 +NJOh3i4F5kNZCs4lieuQVCfDZV5wVqgwMMowqhtY4Yu9ZQzYR3v2j3D8R0TqJjg6DFC7b
 sJbflugGrJoT/MEhlMcB1TkPbb2DUgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779888289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5zzZxPnqrLq9R0xtFY4dlfgntex7SQPZDQRGgaKpgw=;
 b=5X74hPfkAN9y8XlMFPr0Qhr8sxHwB5vvf0t9cvmEbpbYuBpVHyO/qXt/nlWSxPlxpjf7mg
 4obkf7ZYXpSMaiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA7BE5A852;
 Wed, 27 May 2026 13:24:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J4MILKHwFmrzIwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 27 May 2026 13:24:49 +0000
Date: Wed, 27 May 2026 15:24:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <ahbwmz3GOoJlhM1G@yuki.lan>
References: <20260527103756.448843-1-chrubis@suse.cz>
 <20260527130652.4138-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260527130652.4138-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D0F46676D7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TAGGED_RCPT(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/madvise06: Fix sporadic not enough RAM TCONFs
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
> > On systems with <= 2GB RAM the test produced sporadic TCONFs. That is
> > because even if the test setup does sync() and drops caches the system
> > starts fauting in pages immediatelly after caches were dropped. It may
> > easily happen that system may fault in a few hundred of MBs of memory
> > betwen the write to drop_caches and the time sysinfo() syscall returns.
> 
> Three typos in the commit body: "fauting" -> "faulting", "immediatelly"
> -> "immediately", "betwen" -> "between".

Fixed the typos and pushed.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Duplicate Reviewed-by tag.

How did it pick up this? This wasn't in the orignal patch, only in a
mail reply.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
