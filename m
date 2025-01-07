Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07251E77197
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 10:43:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E77A93C0769
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 11:43:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF2283C0387
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 11:43:24 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E48B1229DF8
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 11:43:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5648E21114;
 Tue,  7 Jan 2025 10:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736246600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B89+1BlEZ8lKk/m7+hdIhmVgMedoUOsyzYBBM/zSfRw=;
 b=UsR9Y3EV7VpWt8WRqiut0uzWTuQXxCZOTOWs9rOYklYQj7Ljq9ynGJo6fo6RtuTH6RmFxT
 4CBTPpAZ+OyhJTI1LYJdGE9lXzf86UT21Ce+imzitvzpi89beQbI8BbMDvK5IGl78J+LHA
 2w1BxInIY/rHyscE9+w7FgvGqQcvIRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736246600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B89+1BlEZ8lKk/m7+hdIhmVgMedoUOsyzYBBM/zSfRw=;
 b=YvnV1auZRR7dFLxhAvk2nVU4zoHcqhNaLqvmg/pvOE63BD8L+yt2BnOIZXBls1uVU5ujCk
 g+3js4vSYrAX2jCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736246600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B89+1BlEZ8lKk/m7+hdIhmVgMedoUOsyzYBBM/zSfRw=;
 b=UsR9Y3EV7VpWt8WRqiut0uzWTuQXxCZOTOWs9rOYklYQj7Ljq9ynGJo6fo6RtuTH6RmFxT
 4CBTPpAZ+OyhJTI1LYJdGE9lXzf86UT21Ce+imzitvzpi89beQbI8BbMDvK5IGl78J+LHA
 2w1BxInIY/rHyscE9+w7FgvGqQcvIRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736246600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B89+1BlEZ8lKk/m7+hdIhmVgMedoUOsyzYBBM/zSfRw=;
 b=YvnV1auZRR7dFLxhAvk2nVU4zoHcqhNaLqvmg/pvOE63BD8L+yt2BnOIZXBls1uVU5ujCk
 g+3js4vSYrAX2jCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4825113763;
 Tue,  7 Jan 2025 10:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HzBwEEgFfWcEawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Jan 2025 10:43:20 +0000
Date: Tue, 7 Jan 2025 11:43:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z30FOs2ckQTxEYLl@yuki.lan>
References: <20250106140402.52196-1-pvorel@suse.cz>
 <119d081a-f1cc-400f-a278-27e6e33495ac@suse.com>
 <20250106141635.GA323533@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106141635.GA323533@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runtest/ltp-aiodio.part4: Remove duplicate
 entries
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
> @Cyril? If relevant maybe we should just document it. Does it apply to all
> duplicates? I wonder if it makes sense to run whole runset for 45 min when we
> are testing something mainline does not care about it's performance.

Well the ltp-aiodio.part4 is a stress test that iterates between
different I/O stress tests. Stress tests by definition must run for some
time to be useful, the question is for how long these should be run and
for that there is no clear answer I'm afraid.

The dirty and dio_sparse are interleaved because dirty tries to fill in
the page cache with dirty pages before each dio_sparse iteration. The
dio_sparse then creates a sparse file and checks that we correctly read
zeroes all the time while other processes write zeroes to the sparse
file. It may make sense to merge the dirty.c into the dio_sparse.c so
that it's executed at the start of the test and then possibly eliminate
one block of the dio_sparse tests.

We may as well get rid of the multiple lines in the runtest file by
passing -i option since these tests were converted into the new test
library. But over all I wouldn't vote for reducing the runtime for these
tests as drastically as you proposed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
