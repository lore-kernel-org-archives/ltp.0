Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56774FF6E90
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 22:39:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A1623E4B82
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 23:39:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D3503CF076
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 23:39:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8E3260055B
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 23:39:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB2A95BD0E;
 Tue, 17 Mar 2026 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773787169;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z3kyu+BiCSsk5quSQ4nr7IrrN+McMkcnIo+dV73zaWY=;
 b=wb9yfJ5HXn0yPG+5w1YFmPQD8XdJcTjBK7vjtWwEsiJWDkp4jofOL4j82LCmDPu1Cj4TTd
 LM6eh7evgjsITnaCbK+lw1OMvbGBU4v2R3WZ9zRxtj+mkI32wCrmXXS1GD+yw2BXS66z6p
 cRTj0jnLwlq/3/WorG60GRgzge+Y+64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773787169;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z3kyu+BiCSsk5quSQ4nr7IrrN+McMkcnIo+dV73zaWY=;
 b=Jr8v9Rb+ntm4EJUvFxZKiKA8LGmIuRNvZu7qRdagDzOKP7LLbfRFSRZhp729qElB88xbPe
 oR0Z+iJHMDLLFKDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sw1p7RK3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WTD2uWPt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773787168;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z3kyu+BiCSsk5quSQ4nr7IrrN+McMkcnIo+dV73zaWY=;
 b=sw1p7RK3JMNO80Q8x/AsIvbjFrtzghD7xTyiRkNn1YLoWW+Qo2uOEnQvhOjOyQbb6O++lu
 uYAkXKo2Lp8L7lysT5v08mHFNmRUVw5icU7kKcu8mexoNeM2qPoqK2jlrXhTCpN7+qMHjN
 EFwBJaus+lJZ1Pn2O+wiNxWLjkMNZPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773787168;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z3kyu+BiCSsk5quSQ4nr7IrrN+McMkcnIo+dV73zaWY=;
 b=WTD2uWPt2FPS3+k7YnVvXG+YS0gEltVt8WZaoCs1JJLpJjyKstDZ0bmgwt5KV/D7WZuzAD
 i4mYMv1Ejv+q19Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BF504273B;
 Tue, 17 Mar 2026 22:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cZm7CiDYuWlbdQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Mar 2026 22:39:28 +0000
Date: Tue, 17 Mar 2026 23:39:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260317223920.GA370623@pevik>
References: <20260317115828.GA365182@pevik>
 <69b945ab.050a0220.1eaaec.d93b@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69b945ab.050a0220.1eaaec.d93b@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: EB2A95BD0E
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP old API conversion
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> > I'd vote for limiting patchsets to max tests in a single directory.
> > Why? Smaller patchset is easier to review. And if just some of the commits are
> > accepted then fewer commits need to be rebased.

> Do you mean one patch-set for multiple (unrelated) tests (for instance syscalls
> folder) [1], or one patch-set per testing suite [2] ?

I meant [2], i.e. tests from certain folder (usually tests related to single syscall).
But it's just a suggestion, feel free to do it differently if it's significantly
simpler.

Thanks for this effort.

Kind regards,
Petr

> [1] would be 20 random tests from testcases/kerne/syscalls
> [2] i.e. all tests to refactor in `testcases/kernel/mem/mmapstress`

> I would follow the first approach if we want to send a big amount of patches,
> or the second if we want to be more specific.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
