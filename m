Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F36D65521
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 09:38:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25B613D03B0
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 10:38:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E20A3CEB38
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 10:38:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A27996007B9
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 10:38:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1B795BCEC;
 Wed, 17 Dec 2025 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765964304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZtdJcQQlW58KOyZKM3SDGRGkPNtqZseFcgCSy6/23Zs=;
 b=vIuI6Xlz49ukUlkE6Xm9UcFkjhadxcIRD1vrYwKErj1p9sb45ka+vokk/7Y/+eGuh7bWiZ
 c0HvmIXGjH1UqNCoXlR5H0XMZF0uIhNaXSSf2rbeOmuWGCezvaPqTot4/jDv36tPT0ilfQ
 oQ5zXi+aA4j/I9buAMINnQQz8IjTXJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765964304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZtdJcQQlW58KOyZKM3SDGRGkPNtqZseFcgCSy6/23Zs=;
 b=6B8jXBrjZsFb4Snyz4MVU1a71IDJtZZFosCC6gOA8SXyahkapawK54LMV6qtyZncyVWu6G
 9FGlnqTX+skCvkDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B0YYfHYS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1RzC9mKH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765964303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZtdJcQQlW58KOyZKM3SDGRGkPNtqZseFcgCSy6/23Zs=;
 b=B0YYfHYSBuMYH5JcFb/nHARmJd6LZF0T5XV74LXmoyE3riz0u2HV9uFIQEJna2X4SkXGPW
 KX4PQbfSVl/zVZO5HGOrrP9g2uHVyjZO5Klp3ZzDAzPCNcTa0iStpwIwZWnzU32EFUC6Kp
 aWUQ88zmOLNUJLv6RkosqH9DQtbiORU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765964303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZtdJcQQlW58KOyZKM3SDGRGkPNtqZseFcgCSy6/23Zs=;
 b=1RzC9mKHPUpAUJUeGpVDjShAPP3rFMX/HJB9defdIAkvkUv+XqialdgQfrl8kP35XQ4Awx
 cAHPPE9ORqENB1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 906953EA63;
 Wed, 17 Dec 2025 09:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KYM6Ig96QmlKdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Dec 2025 09:38:23 +0000
Date: Wed, 17 Dec 2025 10:39:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aUJ6TnerN5QKSfrm@yuki.lan>
References: <20251216173053.29112-1-mdoucha@suse.cz>
 <20251216173053.29112-2-mdoucha@suse.cz>
 <20251217070831.GA34230@pevik> <DF0B0KNU874U.AETPU4ILX5BI@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DF0B0KNU874U.AETPU4ILX5BI@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A1B795BCEC
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cpuset_memory: Fix race in multinode subtests
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
> > I wonder if this very old test is in a long run worth to rewrite into C, as depending on
> > sleep is not a good idea and C API would hopefully help to avoid it. (Yeah, we
> > discuss sleep as a part of ground rules [1].)
> 
> I tried, and I gave up :-) too many testcases and a really messy code. I
> really wish we could rewrite it, but this is one of those tests which is
> not worth the effort.

We will have to rewrite it eventually, it's not that complex, just big.
I guess that we need to isolate and rewrite one test after another while
putting the common code into a library.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
