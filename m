Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42086CED617
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 12:42:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80E883CFDCA
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 13:42:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F99C3CFBBB
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 13:41:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BA5B51A00376
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 13:41:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67D4E211D4;
 Tue, 18 Nov 2025 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763469714;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ReJMJ5ZjFm7H01BTWA544yTab8l3AIy+Ce3cwT/jKg=;
 b=KFUombf1yttfytni8B+8s0zByrXiWibfiSmEbLBMJSg5KHLf2nkCcF8TVrZ5ZGTEf232VY
 hf+TIZNMK70XTtWzofkDRwSWHC6W44lB9NIsgJ5semNJHsk7nCjb3z3F8+Xjh91FgZRxUt
 +fnmPAvWg75LBOJ0oWxRYXbb5iwaR4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763469714;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ReJMJ5ZjFm7H01BTWA544yTab8l3AIy+Ce3cwT/jKg=;
 b=Rw8Ysczywwa4F4HqlobtT2nPcUbixpnMMf50lvIalavMq6I1SEd3sxztplvJB4wGHAOUXN
 OuCOryaOrt+5FHCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763469713;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ReJMJ5ZjFm7H01BTWA544yTab8l3AIy+Ce3cwT/jKg=;
 b=0fvZRHE1OkATAvCMJ3qYfaFhe0yRMGrCSP1eRNlAA4UTVK3t9BF/5weN9SI4TvwnehOo/N
 9HCIZXQOJwz/yXbiziDrGjUKrAaruIopsogJ95TWWwet7AZ7GLJ6fNJ3vPDs2xTbvoholb
 GV1jQzfQVg1F7nqQO6+bw6UbUJaD3Lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763469713;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ReJMJ5ZjFm7H01BTWA544yTab8l3AIy+Ce3cwT/jKg=;
 b=Z69ssz8Mfza3SIzMFfWmbHTYms9cEpwJgrreZL7XWIDsFC1mPzcepI8R6myngCEgJDMv5N
 cLVxIBh8TXRlIcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D61883EA61;
 Tue, 18 Nov 2025 12:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7JrZLpBpHGlgGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Nov 2025 12:41:52 +0000
Date: Tue, 18 Nov 2025 13:41:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251118124151.GA29577@pevik>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-6-pvorel@suse.cz>
 <12777454.O9o76ZdvQC@thinkpad> <20251114102457.GC52218@pevik>
 <aRcEIpgvi9C8NKLd@yuki.lan> <20251114120937.GD43654@pevik>
 <aRc-y_W0StnungVp@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRc-y_W0StnungVp@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] swapon03: Remove grep dependency
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Do you mean to use full swap file path from /proc/mounts, i.e.
> > /tmp/LTP_swaNzeMJr/mntpoint/testswap, /tmp/LTP_swamEVVAc/mntpoint/testswap03,
> > ... (example from run which created /tmp/LTP_swamEVVAc with all swap files,
> > cleanup interrupted by ctrl+C and following one which created /tmp/LTP_swaNzeMJr
> > single swap file only):

> If we make the swapfile names unique enough we can match just that
> instead. I think one of the patches did just that by including the test
> name in the swap filenames. If we want to be extra sure we can take last
> directory component of the test temporary directory as well.

FYI the problem I wanted to address here was during repeatedly running this test
(swapon03.c) during debugging. Therefore $TMPDIR directory component would help
or $PID would help in this case (but sure the test name itself would help in
possible clash of 2 different tests). I'll probably implement it by $TMPDIR
subset unless you see any usefulness of normalizing $TMPDIR.

But I'll postpone it, in v3 I'll just remove fork and "Try to swapon() as many
files until it fails" to get the original problem merged first.

> What I'm
> trying to point out is that the $TMPDIR part of the test temporary
> directory is not adding anything unique to the path since that is prefix
> that is used by all LTP tests.

Understand. FYI I added the full path to the file to avoid the need to create
full path from subset of the path. I'll probably go this way, although I still
think more tests expect normalized path to TMPDIR, but we don't normalize it
nor even check for it (it'd be interesting to see how many tests in
runtest/syscalls will fail with TMPDIR=/run/../tmp or TMPDIR=/tmp///).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
