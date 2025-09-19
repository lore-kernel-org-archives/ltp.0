Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FB5CAC592
	for <ltp@archiver.kernel.org>; Fri, 19 Sep 2025 11:54:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3113D3CDD41
	for <ltp@archiver.kernel.org>; Fri, 19 Sep 2025 13:54:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A63E3CD779
 for <ltp@lists.linux.it>; Fri, 19 Sep 2025 13:53:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 84C566008C5
 for <ltp@lists.linux.it>; Fri, 19 Sep 2025 13:53:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E8DD6336A7;
 Fri, 19 Sep 2025 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758282828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvtWImJsOyYAsoEvTFAEBhecAgEa+XCTTsGEV7aW8dI=;
 b=jrYH6gHhUF2uzDRaCGlZXtlf/X6So7ULJtzyJ8gKa87KXu8inQX0dtpOQegl5lmVuUOEfn
 27xlr2WIPOxFaqzEUWzJCkiv6jRfrcTGsexlO/ydUyWkK5TyyhUpo5IzYdoYCbawnnwvQY
 RsAL5nIjw/+FJpJe9+sr9b0DDEn3IrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758282828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvtWImJsOyYAsoEvTFAEBhecAgEa+XCTTsGEV7aW8dI=;
 b=XOfZTj/TmJzGS5aVMagaDAOlt2kLoVooHQlo3MRyXmridRojOxNTaDvyjHxsNS2vQPSzLq
 feDZc2b2RzAoTGBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758282827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvtWImJsOyYAsoEvTFAEBhecAgEa+XCTTsGEV7aW8dI=;
 b=wjM7Jp7IKbJfq1c8/WX+xsEZ0a+D/jIqzYzYO4Ktf9SQvlVee8XYOE3K1JIbwqn/lL7Q+A
 cdVAi7HhW7fAgx/YAEgnKZQ6MZLsYPsCNQy+Ph78w5nevW+AXKZlzFuGo79SLUGLoxFGiN
 06Q1YPPcohlRSM1OpjGiux5i/DYk+/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758282827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvtWImJsOyYAsoEvTFAEBhecAgEa+XCTTsGEV7aW8dI=;
 b=gdnlNICEk2Tgv2yjASwABTF4/W2DPNrAD3+625Py7wauAsJXuQ+ePJSjJSOD73JQF9MXw0
 KX4BDAQ5i+WP9tCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1C2E13A39;
 Fri, 19 Sep 2025 11:53:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFqYMUtEzWhnbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Sep 2025 11:53:47 +0000
Date: Fri, 19 Sep 2025 13:54:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aM1EdqFm48EyjtWz@yuki.lan>
References: <20250520-fixes-pthread_rwlock_rdlock-v1-1-402ee45114cc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250520-fixes-pthread_rwlock_rdlock-v1-1-402ee45114cc@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix: Update pthread_rwlock_rdlock 2nd
 assertion
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
> The pthread_rwlock_rdlock/2-*.c tests are broken because they rely on an
> old version of the POSIX standard which says:
> 
>   If the Thread Execution Scheduling option is supported, and the threads
>   involved in the lock are executing with the scheduling policies
>   SCHED_FIFO or SCHED_RR, the calling thread shall not acquire the lock if
>   a writer holds the lock or if writers of higher or equal priority are
>   blocked on the lock; otherwise, the calling thread shall acquire the
>   lock.
> 
> Whereas the new version says:
> 
>   If the Thread Execution Scheduling option is supported, and the threads
>   that hold or are blocked on the lock are executing with the scheduling
>   policies SCHED_FIFO or SCHED_RR, the calling thread shall not acquire the
>   lock if a writer holds the lock or if the calling thread does not already
>   hold a read lock and writers of higher or equal priority are blocked on
>   the lock; otherwise, the calling thread shall acquire the lock.

I wouldn't say that these tests are broken because of the change in
POSIX. The change in POSIX only fixed the specs in the case of recursive
locking that is situation where we have a thread that has rdlock and
attempts to do rwlock while there is higher priority thread that
attempts rwlock. In that situation the previous definition would caused
deadlock.

But as far as I can see these tests do not attempt recursive locks, so
that part of POSIX wasn't really problem.

> This behaviour is not supported by default on GNU/Linux, so add a call to
> Glibc pthread_rwlockattr_setkind_np() to set the correct lock kind as a
> prerequisite to the 2-1.c and 2-2.c tests.

This is where the problem is, glibc decided to deviate from the POSIX
since they think that the standard is not well designed. That is a glibc
design choice. I'm not againts working around that with requesting POSIX
confirming variant on glibc, but the patch should clearly say this
instead.

Also we should split this into two patches, one that adjusts the specs
and one that adds glibc workaround.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
