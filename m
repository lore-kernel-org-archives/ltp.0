Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374DACAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 12:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C11803CDE67
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 14:16:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 809913C2566
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 14:16:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D391F1000252
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 14:16:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 211641FB3D;
 Tue, 23 Sep 2025 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758629761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUYKnj0w6Zba0m4HaldUUv0uuRgEcAC6n0UarK3Q9eQ=;
 b=g6P6jnJoG/kXGJSP8x3Mdvb3H8dLvtZGbELmemmvKAr7QGy5p4oo94SdAUofgHCgGdU93A
 zLOvYkFdOdF/Oz6bo+GbZQLQJeHr5CTagSJsQh/4AAk1vrTso61LqVQC+Dr2gQt87ygJjW
 bmvN74KmY9jgbUi6OHqV9oPmz0wh450=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758629761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUYKnj0w6Zba0m4HaldUUv0uuRgEcAC6n0UarK3Q9eQ=;
 b=TqnNWCb212SzJb4hV4lt80AjzY70EcokkFCp6wyCqDdR5nApLZwa+NSb7eIcQ+XBL4tiJ2
 XWVeWiYLJIwR2tDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g6P6jnJo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TqnNWCb2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758629761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUYKnj0w6Zba0m4HaldUUv0uuRgEcAC6n0UarK3Q9eQ=;
 b=g6P6jnJoG/kXGJSP8x3Mdvb3H8dLvtZGbELmemmvKAr7QGy5p4oo94SdAUofgHCgGdU93A
 zLOvYkFdOdF/Oz6bo+GbZQLQJeHr5CTagSJsQh/4AAk1vrTso61LqVQC+Dr2gQt87ygJjW
 bmvN74KmY9jgbUi6OHqV9oPmz0wh450=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758629761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUYKnj0w6Zba0m4HaldUUv0uuRgEcAC6n0UarK3Q9eQ=;
 b=TqnNWCb212SzJb4hV4lt80AjzY70EcokkFCp6wyCqDdR5nApLZwa+NSb7eIcQ+XBL4tiJ2
 XWVeWiYLJIwR2tDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C31B132C9;
 Tue, 23 Sep 2025 12:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yAW2AYGP0miiEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 23 Sep 2025 12:16:01 +0000
Date: Tue, 23 Sep 2025 14:16:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aNKPrUbjC3-oftGI@yuki.lan>
References: <20250923-cve-2025-21756-v2-0-3bb1a6363123@suse.com>
 <20250923-cve-2025-21756-v2-2-3bb1a6363123@suse.com>
 <aNKKtXeaxoAfTsT8@yuki.lan>
 <87878992-ee9a-48a3-93a5-7e38bcd65bc1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87878992-ee9a-48a3-93a5-7e38bcd65bc1@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 211641FB3D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] cve: add test reproducer for cve-2025-21756
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
> > So this generally works all the way back to the oldest LTP supported
> > kernel? I would expect that we would need an EINVAL check here.
> 
> AF_VSOCK were defined in 3.10 (d021c344051a VSOCK: Introduce VM 
> Sockets), so I guess we are pretty safe.

Ack.

> Should I merge it after the Review-by, or we should wait for the release?

As long as it passes the compilation CI I would be inclined to take it
in. The pros is that we get one more CVE reproducer and the cons are
that we add one buggy test, it shouldn't break more than that.

However that should be the last non-fix before the release.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
