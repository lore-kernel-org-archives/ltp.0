Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ED6CD98D2
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:00:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A0BD3E6B3B
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 21:00:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79FD63E2A97
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 20:59:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E3A4B600BC7
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 20:59:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E96D571489;
 Fri, 12 Jun 2026 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781287011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9NIY2s7QPMCgeqmVd9U4iodE4kB8nz+UP6wXDawmeE=;
 b=bqTUJzEE12I3tscC8krSsskRgXlxAGih930HsHDg1iu3O/o6QN5Z7rs4SAPip1ubdW/ng/
 xgvibrIFCK3SbSFo/NBI3vq+2c2KmZwXaLrOvfZULtBrN+UDy14M/WF1khMgyokjjQool8
 OahU47ZqGCfWXNWwIrelTGcYW+shD4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781287011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9NIY2s7QPMCgeqmVd9U4iodE4kB8nz+UP6wXDawmeE=;
 b=p/i8AgzBQIgnTnSRQM89AgpGeWE3IqA2qZATKfMxboRHkqIb88TO6I0FDuwNJlLE+wfhGC
 sv36PLXtM2qkupCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DRPwZPWC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j1nH+Hij
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781287010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9NIY2s7QPMCgeqmVd9U4iodE4kB8nz+UP6wXDawmeE=;
 b=DRPwZPWCdwyGQkp5Age01dzXvkQXpEGZQb+363wT19v5T6KcDy0jfG8DPDEmV96pCf1rel
 yPnBo7yHPQuVSm0qOeYS2iePJ6MsM1nxMtCc4kSUOp6IOgB5PsR2lT7LATul5dzPXztWfA
 Ftm6syKxQGV6c7AIYtDXYW54r80K6+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781287010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9NIY2s7QPMCgeqmVd9U4iodE4kB8nz+UP6wXDawmeE=;
 b=j1nH+HijZlOjeLK6jw8C+xscMiZz8tIMIHkLrsdY8at2BfsIgBzpQjNykJyr4XQmfhBIeX
 m6dtIxIWfsh/fPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2EE2779A7;
 Fri, 12 Jun 2026 17:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QT5GMmJILGqCZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Jun 2026 17:56:50 +0000
Date: Fri, 12 Jun 2026 19:56:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <aixIPzk4oTXw6Iaz@rei.lan>
References: <20260527092618.14824-1-mmenashe@redhat.com>
 <20260527092618.14824-4-mmenashe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260527092618.14824-4-mmenashe@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E96D571489
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14 3/4] futex_wake05: Add EFAULT error coverage
 test
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Red Hat, Inc.
> + * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
> + */
> +
> +/*\
> + * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
> + * unmapped or PROT_NONE memory.
> + *
> + * The test uses opflags=0 (no FUTEX_PRIVATE_FLAG), so futex_wake() takes
> + * the shared-futex path in get_futex_key() which must resolve the physical
> + * page. For PROT_NONE memory this page lookup fails with EFAULT, even though
> + * futex_wake() never reads *uaddr.

Maybe this should be more explicit and say that the unmapped address
takes different codepath than the PROT_NONE one. I had to check the
get_futex_key() to realize that this is one of the syscalls where
different types of EFAULT memory actually matters.

Also we have specific EFAULT handling for kernel addresses at the start
of the futex, so figuring out a kernel address and passing it to the
syscall would be a good idea as well.

Also there is a lot of NUMA specific code in there, so adding one more
test that requires NUMA and tries to hit the NUMA specific codepaths
would make sense as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
