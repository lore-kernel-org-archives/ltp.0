Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB88BCD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:25:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE7663E5F8D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:25:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CE2C3E13D7
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:25:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05711140097B
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:25:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C07B06A87A;
 Mon,  8 Jun 2026 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780928731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSU9WGTeN3TOTDjyOIzZyRO+a3Ah7j+tygClq2/mm4g=;
 b=xrFhRHcQjZal6g3W9HRf/YDbwrP+itrqWF+cQVRAA1+29dfXWVUu1VL4kyrHGfiWaatZ+Q
 eY2x2TtSYSItShsdA7YhudG33zdulxhLffAy9s/ZnC9QX7WEmZBGFouL6Mz/e3bimtfTjS
 iyd2Bp1Qsr87r6YhbrWGbfMXS5HGv3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780928731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSU9WGTeN3TOTDjyOIzZyRO+a3Ah7j+tygClq2/mm4g=;
 b=dmhxmTducbWfKTTStgZFdJub1sVptiRAid9it3yM6QtAry/TxWc2mKaOt0t6WQsya2U/Ra
 1yK9pzAFnnggXnCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780928731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSU9WGTeN3TOTDjyOIzZyRO+a3Ah7j+tygClq2/mm4g=;
 b=xrFhRHcQjZal6g3W9HRf/YDbwrP+itrqWF+cQVRAA1+29dfXWVUu1VL4kyrHGfiWaatZ+Q
 eY2x2TtSYSItShsdA7YhudG33zdulxhLffAy9s/ZnC9QX7WEmZBGFouL6Mz/e3bimtfTjS
 iyd2Bp1Qsr87r6YhbrWGbfMXS5HGv3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780928731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSU9WGTeN3TOTDjyOIzZyRO+a3Ah7j+tygClq2/mm4g=;
 b=dmhxmTducbWfKTTStgZFdJub1sVptiRAid9it3yM6QtAry/TxWc2mKaOt0t6WQsya2U/Ra
 1yK9pzAFnnggXnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A83D8779A7;
 Mon,  8 Jun 2026 14:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6ZriJNvQJmpLOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 08 Jun 2026 14:25:31 +0000
Date: Mon, 8 Jun 2026 16:25:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <aibQ2bRNgwTFl4y8@yuki.lan>
References: <20260608092200.92827-1-sachinp@linux.ibm.com>
 <20260608092200.92827-2-sachinp@linux.ibm.com>
 <aiauHurwBjafsd4R@yuki.lan>
 <8a4a075d-0440-4f16-b88c-f09b1961e030@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a4a075d-0440-4f16-b88c-f09b1961e030@linux.ibm.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/8] fs/acl: Add ACL_USER_OBJ permission test
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
> >> +static inline int create_file_as(uid_t uid, gid_t gid, mode_t mode,
> >> +				 int use_umask, mode_t mask)
> >> +{
> >> +	pid_t pid;
> >> +	int status;
> >> +
> >> +	pid = SAFE_FORK();
> >> +	if (!pid) {
> >> +		int fd, err;
> >> +
> >> +		if (setgroups(0, NULL) == -1) {
> >> +			err = errno;
> >> +			_exit(err);
> >> +		}
> >> +
> >> +		if (setgid(gid) == -1) {
> >> +			err = errno;
> >> +			_exit(err);
> >> +		}
> >> +
> >> +		if (setuid(uid) == -1) {
> >> +			err = errno;
> >> +			_exit(err);
> >> +		}
> > These should be SAFE_MACROS().
> Can you elaborate on this?
> This code runs in a forked child process that intentionally tests 
> permission scenarios.
> The function expects these calls to potentially fail as part of testing 
> ACL behavior.
> 
> The current pattern of capturing errno and exiting with it is correct for
> communicating failure back to the parent.
> SAFE_* macros would call tst_brk(TBROK) on failure, which is 
> inappropriate in
> a child process testing permissions.

It does test the permissions for the open() call. It's wrong to check
the errnos from set*() calls.

> The parent process checks the exit status to determine if the operation
> succeeded or failed (line 442: return WEXITSTATUS(status))

And as I described below we do not want to propagate results in LTP. We
should report PASS/FAIL as close to the call that we check as possible.
With that we avoid all possible bugs in result propagation.

> >> +		if (use_umask)
> >> +			umask(mask);
> >> +
> >> +		fd = open(TESTFILE, O_CREAT | O_WRONLY, mode);
> >> +		if (fd >= 0) {
> >> +			close(fd);
> >> +			_exit(0);
> >> +		}
> > Generally in LTP we want to check the test conditions right after they
> > happen. So this function should get expected errno as last parameter and
> > we should check for the result right here with something as:
> >
> > 	if (errno)
> > 		ST_EXP_FAIL()
> > 	else
> > 		TST_EXP_FD()
> >
> > With that we do need to propagate the return value manually, which is
> > prone to errors, and do not need to process the child exit value
> > manually, we can just let the library collect the children with
> > tst_reap_children().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
