Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9094DF54AA0
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 13:21:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 459203E2AE3
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 14:21:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1FA3DADA3
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:21:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62A221000D2D
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:21:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB7725C072;
 Tue, 24 Mar 2026 13:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774358466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=974z3LumKgC1rd/z2FEHroKgJtF7jqArcVzC8zeiPHA=;
 b=VJqyxiU8+BJ8kqrFnR+hWpLn1ISiV0YjqdyzFfWS941dEnyvjdScmi/668qgGC4nM2t6VI
 AZkxuwh57kVOYB+tD9h9a0Gr3g0iYUgT/Wip+jBaqZY7g5okH4p/4Ff4fPymuTKRN9eMJD
 ZkVdCU44zhuG5/+8YBcUOpV3mEIMgXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774358466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=974z3LumKgC1rd/z2FEHroKgJtF7jqArcVzC8zeiPHA=;
 b=PiDdj/YzuAjCg3TlsvjZL1TIBVlde+r69YM9LQkzXIITzfGdlokdTJk5ySmXO7o8gJQ77T
 88WYq/YS6QPwnMBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774358465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=974z3LumKgC1rd/z2FEHroKgJtF7jqArcVzC8zeiPHA=;
 b=IGZzOgwYLxnWnCdQXLqX6tduzSs+lIB7PWH8ppvJL+nqSGeLLNpvJrYiCfHWVxShaKUhRQ
 Sss5K7GjyxHZPOX7bvS6wJVErh7Vw4M59hcAXkZAUdx3LDDkPc5ceb/GXRpfifAdGAXzAl
 x69uwI57G7qNbtLaTZrM/IIndXtNeNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774358465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=974z3LumKgC1rd/z2FEHroKgJtF7jqArcVzC8zeiPHA=;
 b=XDhbRh95YpQtPPG09zncDWkVzvbBt44L7xEg0M3z9Eof3oauJmMcKau7sS5NbqzL3x1RSQ
 TedRPVqrL7HDoKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B26FE43E66;
 Tue, 24 Mar 2026 13:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kOMRKsGPwmk6IgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 24 Mar 2026 13:21:05 +0000
Date: Tue, 24 Mar 2026 14:21:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <acKPxuwkGSMZILyK@yuki.lan>
References: <20260324-fix_dio_read-v1-1-cf5dfa13e46a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260324-fix_dio_read-v1-1-cf5dfa13e46a@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] dio_read: fix infinite loop when readsize >=
 filesize
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
> The do_direct_reads() function had exit conditions inside the inner
> for loop. When readsize >= filesize, the for loop condition is never
> true, causing the while(1) loop to spin infinitely without checking
> if writers completed or runtime expired.
> 
> Move the exit condition checks outside the for loop to ensure they
> are evaluated on every iteration, regardless of readsize/filesize
> parameters.

I was looking at this when I was rewriting the runtest files and I was
wondering why we do not check that filesize <= readsize && filesize <=
writesize in the test setup() instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
