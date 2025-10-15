Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B4ACCD194
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 16:02:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 348553CED79
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 18:02:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52C233CEC04
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 18:02:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E619140098D
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 18:02:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECF89338C7;
 Wed, 15 Oct 2025 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760544146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Nye0KzyI5SNlcC7Vr1OWu9D5ApOemMR+iawfb3PsoQ=;
 b=mkJnl4sgqSZOIDZcJjKUxRwYjB6eKpn9hpPu6lcr4XX94v5JTC09pxy2l9C6Q35KPb+3Of
 6JASebCb0BRBvveBNt7fcZDMUqK2LsjAVfOV2OSIILdHafBCvvSJ3SDmbpu5034aTzdySK
 A83HjPVwpCe49dMLS6VBHE4dU78EIRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760544146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Nye0KzyI5SNlcC7Vr1OWu9D5ApOemMR+iawfb3PsoQ=;
 b=gyea+jrk2bmnRUimAdwdSg8KwCKvP6q0gyAqbGedW35LC8ls2A7MltizJ42fIyS5ovoTom
 pw/IcF88yRrf0bDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="i/q9ukEp";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+cYVjfIg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760544145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Nye0KzyI5SNlcC7Vr1OWu9D5ApOemMR+iawfb3PsoQ=;
 b=i/q9ukEpDkHI/VAZHkUSRneX2uWQd8RMHO7PYGbHMX6VI9dhs/RsR0QFbd8qfheUMMcsQz
 IOwW0LLctP7R+3fvrvW4g+GtL2jrXy8THRhIUDxJM/vABtLZfg3AxRmQUYkgCJ8JELawg2
 X0p+/5x3XQun2UeBvc6dRCB7x8ZN0bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760544145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Nye0KzyI5SNlcC7Vr1OWu9D5ApOemMR+iawfb3PsoQ=;
 b=+cYVjfIg94gCCmgnXeZ5+X464PHhnTofxUrft1bM5zSYRLFgC1QezJ7GrYvVKnuUKan3Zd
 WVYIhnMug7WRRSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FDBF13A42;
 Wed, 15 Oct 2025 16:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uHLdJZHF72jeYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 Oct 2025 16:02:25 +0000
Date: Wed, 15 Oct 2025 18:02:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <20251015160224.GC220875@pevik>
References: <20251015101533.30220-1-ben.copeland@linaro.org>
 <20251015144247.GB220875@pevik> <aO-2-tN418z9wDKm@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aO-2-tN418z9wDKm@stanley.mountain>
X-Rspamd-Queue-Id: ECF89338C7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] overcommit_memory: Fix integer overflow and
 32-bit limits
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
Cc: arnd@arndb.de, lkft-triage@lists.linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, Oct 15, 2025 at 04:42:47PM +0200, Petr Vorel wrote:
> > > The overcommit test uses sum_total, the sum (memory and swap) to test
> > > the overcommit settings.

> > > This fixes two problems on 32-bit systems. The first is seen with a
> > > integer overflow can occur when calculating sum_total * 2, if the
> > > sum_total is larger than 2GB. The second is limited virtual address

> > You still mention GB ...


> Yep.  It is GB.

> > > space (2-3GB) means the test can fail from address space exhaustion
> > > before overcommit has been tested.

> > > Now the test runs correctly on low-memory 32-bit systems while avoiding
> > > both the overflow bug and virtual address space issues.

> > > Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  .../kernel/mem/tunable/overcommit_memory.c    | 33 +++++++++++++++----
> > >  1 file changed, 27 insertions(+), 6 deletions(-)

> > > diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
> > > index 9b2cb479d..7ff5a98d0 100644
> > > --- a/testcases/kernel/mem/tunable/overcommit_memory.c
> > > +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> > > @@ -131,24 +131,45 @@ static void overcommit_memory_test(void)
> > >  	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);

> > >  	update_mem_commit();
> > > -	alloc_and_check(commit_left * 2, EXPECT_FAIL);
> > > -	alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
> > > +	/* Skip tests that would overflow or exceed 32-bit address space */
> > > +	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {

> > ... but TST_GB / TST_KB is actually MB (you could use TST_MB).


> The sizes in this test are measured in KB, so it's 1GB but measured in
> terms of KB not bytes.  Using TST_MB would work mathematically but it's
> misleading.

Ah, I'm sorry to overlook an obvious point.

Implementation details: thinking about the code twice, shouldn't be the check
for overflow in alloc_and_check() instead of outside (to keep the condition on
single place)?

Also, if kept outside the 1st and 2nd if could be joined:

	/* Skip tests that would overflow or exceed 32-bit address space */
	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
		alloc_and_check(commit_left * 2, EXPECT_FAIL);
		alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
		update_mem_commit();
		alloc_and_check(commit_left / 2, EXPECT_PASS);
	} else {
		tst_res(TCONF, "Skipping large allocation tests due to address space limits");
	}

instead of your proposal:

	update_mem_commit();
	/* Skip tests that would overflow or exceed 32-bit address space */
	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
		alloc_and_check(commit_left * 2, EXPECT_FAIL);
		alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
	} else {
		tst_res(TCONF, "Skipping large allocation tests due to address space limits");
	}
	update_mem_commit();
	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
		alloc_and_check(commit_left / 2, EXPECT_PASS);
	} else {
		tst_res(TCONF, "Skipping commit_left/2 allocation test due to address space limits");
	}

because update_mem_commit() IMHO just evaluates /proc/meminfo values, but
when alloc_and_check() is skipped nothing has changed.

Kind regards,
Petr

> regards,
> dan carpenter


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
