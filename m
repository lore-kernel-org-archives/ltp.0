Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403F6CF65E1
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 11:43:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E34583C30CD
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 12:43:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD1593C2BF5
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 12:43:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 312146001A2
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 12:43:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E32FD5BD13;
 Mon, 26 Jan 2026 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769427794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SFarWLBahhvyH/O997P7J9nnDMo/QuYajEVQgFo7Rag=;
 b=Ae4I2QWfvWL+LdobhsDjiiItFaNLB7BmNdsGp3D/ZUoGU0UuHpLRDvrFcXjZS7xupbBEEb
 mI+EVR/Mk/f14FCXWXlDN5D7P0gMsdFNuvIEKzoUqyZtDQifIuR8LubPiwazYwDuo+2Jqp
 Av/Mm4+ErQpEnoCi+KFbszBhnSksGXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769427794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SFarWLBahhvyH/O997P7J9nnDMo/QuYajEVQgFo7Rag=;
 b=EPMkviHaPNv1dQdEiUGmG8MYC0SuXCB7n6U8Emb/OZNEBNDHGuX32cjk65sc5u4k2F2aQi
 QEL1VkuEROI9j8Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769427793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SFarWLBahhvyH/O997P7J9nnDMo/QuYajEVQgFo7Rag=;
 b=ScFdf0v7612UnSMivYC9HJs+f3s2kpoFKTvufAi/tfNsZDwKXkvpvKbAFVIg7xiPUbtEjj
 k5RBxJIY2rPM8wz4qde9YqPtvKtXQuiio3m9d+u/OIzID7wG+NRzarypZIUe3tTzkpkzPC
 +M/z3U+kDXON9KYnzBHjM7+uws6O2xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769427793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SFarWLBahhvyH/O997P7J9nnDMo/QuYajEVQgFo7Rag=;
 b=3wYQyN/2JahhYygWjZyVjKdZKzkUXeYNK8VZEUDuIfcYqOcdfRxrkT2Vrytod8qRmr/VoP
 4rYNOoyKOBr3EXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8E66139E9;
 Mon, 26 Jan 2026 11:43:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 800VMFFTd2nzZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Jan 2026 11:43:13 +0000
Date: Mon, 26 Jan 2026 12:44:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aXdToM9WIDy-39Ng@yuki.lan>
References: <20260126-fix_dio_sparse_slow-v2-1-5dbe1622f5c1@suse.com>
 <aXdTEreda0-s6WID@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aXdTEreda0-s6WID@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] io: fix really slow dio_sparse on certain
 systems
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I guess it's not about slow buffering. What I suppose happens is that
> every time the writer thread writes with O_DIRECT it invalidates the
> page cache and we have to re-read everything from disk. Which measn that
> the data are often removed from the cache between the reads and the
> reader processes are often forced to re-read the data from the disk. If
> there was no O_DIRECT reader thread the first child that happens to read
                         ^
			 writer

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
