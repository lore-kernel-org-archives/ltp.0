Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88E1C3DA4A
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 16:01:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA60D3D1A50
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 18:00:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 000C13D1A13
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 18:00:43 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 541A3140124E
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 18:00:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DF321F82C;
 Mon, 15 Jul 2024 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721059242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxPO7bvIp4ADtHcMeZzf1hR7bKufqA7Q7Fm+iz9oEO4=;
 b=wFrJabU5Udy+glIGsGV1MYlCgBpWvcN8vWw1uTHkw3OcwyaMKpzVJpNYkQFboA6f1EO4xT
 HGqG9LG0+WbbeBhwlZhcYfvgK1Trmx3wAXcSXQDpwv8/j9KBlfWQDqL0EgeSyT2k23pp5s
 5P4832r/bhpHfcCHVv+WtiXg0SZen4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721059242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxPO7bvIp4ADtHcMeZzf1hR7bKufqA7Q7Fm+iz9oEO4=;
 b=EmV0JznncNFB/WYswoKg6zbmGK8O1klLQTmMcFrvLAeH9HPsJMT4bkJQKeC27VSmkJnT2A
 15mHp2QHrYBfkpAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wFrJabU5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EmV0Jznn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721059242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxPO7bvIp4ADtHcMeZzf1hR7bKufqA7Q7Fm+iz9oEO4=;
 b=wFrJabU5Udy+glIGsGV1MYlCgBpWvcN8vWw1uTHkw3OcwyaMKpzVJpNYkQFboA6f1EO4xT
 HGqG9LG0+WbbeBhwlZhcYfvgK1Trmx3wAXcSXQDpwv8/j9KBlfWQDqL0EgeSyT2k23pp5s
 5P4832r/bhpHfcCHVv+WtiXg0SZen4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721059242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxPO7bvIp4ADtHcMeZzf1hR7bKufqA7Q7Fm+iz9oEO4=;
 b=EmV0JznncNFB/WYswoKg6zbmGK8O1klLQTmMcFrvLAeH9HPsJMT4bkJQKeC27VSmkJnT2A
 15mHp2QHrYBfkpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DEDC137EB;
 Mon, 15 Jul 2024 16:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mehRCqpHlWZaCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jul 2024 16:00:42 +0000
Date: Mon, 15 Jul 2024 18:00:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZpVHnkY5mptj6ETA@yuki>
References: <20240516104227.25381-1-andrea.cervesato@suse.de>
 <Zov59BQ_7j-1080J@yuki>
 <e3f88888-2a5e-4515-9805-bc605e081f52@suse.com>
 <ZpURPV6wv26kpXOb@yuki>
 <f903dd6e-6d5a-48f0-825e-71e4f216b5aa@suse.com>
 <ZpUWaGR0BmgT1j8E@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZpUWaGR0BmgT1j8E@yuki>
X-Rspamd-Queue-Id: 3DF321F82C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] cachestat testing suite
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
> > I had to go through the cachestat code and maybe i found the solution. I 
> > will send the tests soon.
> 
> I had a look as well and it looks that cachestat should work fine for
> all file descriptors that can be mmaped(). So as long as you get success
> for a file descriptor that returns EBADF for mmap() it shouldn't
> probably work with cachestat() either.

And after more staring at the kernel sources I've found that:

- anonymous inodes have the page cache mappings initialized to zeros and
  empty list
- this is not used for anything for most types of file descriptors (e.g.
  sockets)

So if you call cacestat() on a socket fd it will try to loop over empty
list of vmas and the end result would be statistics that are full of
zeroes. Maybe that is worth of a special test just for this case.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
