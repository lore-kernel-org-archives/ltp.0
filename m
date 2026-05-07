Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C30CD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:44:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCC5F3E614E
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 16:44:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B2623CAD2E
 for <ltp@lists.linux.it>; Thu,  7 May 2026 16:44:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D96F5200B29
 for <ltp@lists.linux.it>; Thu,  7 May 2026 16:44:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FCFA66D91;
 Thu,  7 May 2026 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778165041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UhCET0DQzDFsWVMfVJjBEPLaUNh+V2JzWWvHuVuhG4=;
 b=Ogl9de2zzkPpEcscMBDNscjPM4tu4U+O2QhB7F4H45BLUSyAGLS/i+vif2IHn3FON5EKKQ
 YzFns4Y5MK3J+lrJbpRdu8gfY7OWWR283XW4XapvFzBLoqQHrp2ivKClsQrJF8B1iUuPp2
 E6OtFhoWXLNJhbbMpBjPKgIH2xWhoX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778165041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UhCET0DQzDFsWVMfVJjBEPLaUNh+V2JzWWvHuVuhG4=;
 b=hPooJ0Y8Ml6okm3k7Jd5t9byzTn5VeMa0LvNVqsB/JOFmAczwQDathEIysQXOT5B03aYao
 RM7hLSTTxO0vSlBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778165041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UhCET0DQzDFsWVMfVJjBEPLaUNh+V2JzWWvHuVuhG4=;
 b=Ogl9de2zzkPpEcscMBDNscjPM4tu4U+O2QhB7F4H45BLUSyAGLS/i+vif2IHn3FON5EKKQ
 YzFns4Y5MK3J+lrJbpRdu8gfY7OWWR283XW4XapvFzBLoqQHrp2ivKClsQrJF8B1iUuPp2
 E6OtFhoWXLNJhbbMpBjPKgIH2xWhoX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778165041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UhCET0DQzDFsWVMfVJjBEPLaUNh+V2JzWWvHuVuhG4=;
 b=hPooJ0Y8Ml6okm3k7Jd5t9byzTn5VeMa0LvNVqsB/JOFmAczwQDathEIysQXOT5B03aYao
 RM7hLSTTxO0vSlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E62B593A7;
 Thu,  7 May 2026 14:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4gwnCjGl/GliRAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 May 2026 14:44:01 +0000
Date: Thu, 7 May 2026 16:43:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <afylLJCi9a-FELwp@yuki.lan>
References: <20260507142202.4150-1-linuxtestproject.agent@gmail.com>
 <69fca479.050a0220.143608.4a70@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69fca479.050a0220.143608.4a70@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add helper for checking UFFD feature support
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > --- [PATCH 2/3] ---
> > 
> > On Thu, 7 May 2026 14:28:54 +0200, Ricardo Branco wrote:
> > > [PATCH 2/3] userfaultfd: Use two-step handshake to probe features
> > 
> > > Fixes: 1840ee23d172b5ab04cca7c2acfa48755b041911
> > 
> > This commit is not reachable in the local git history (grafted shallow
> > clone). Please verify the Fixes: tag resolves correctly against the
> > upstream LTP tree.
> 
> Can you please double check this? Maybe we have an another issue
> with the agent.

The commit is there:

commit 1840ee23d172b5ab04cca7c2acfa48755b041911
Author: Li Wang <li.wang@linux.dev>
Date:   Fri Jan 23 19:54:19 2026 +0800

    userfaultfd05: require CONFIG_HAVE_ARCH_USERFAULTFD_WP


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
