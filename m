Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E4BCCD18E
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 14:43:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54E0A3CED2F
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 16:43:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 068553C7221
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 16:42:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 591151A00115
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 16:42:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B75533883;
 Wed, 15 Oct 2025 14:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760539370;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FvebpG7NjSqRY2CqGweF+ZtoQjExJCQ6PJW0m8msSZ0=;
 b=tA7kWzckgRtKI0Q6WTcK2cxhe7VUPS5e0uoLTHHMuUVPH/kmIm43awIwuzFky/6IXvp+0H
 265ESM+SKJOEo3ZCC/Tx5yU9I/tbI53YTAeQSDE/MPcNKrHshdW9XCjNQu8BdRmJb4hndm
 +vVdfUizVq1rcGkVwfMGpOathaQxzVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760539370;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FvebpG7NjSqRY2CqGweF+ZtoQjExJCQ6PJW0m8msSZ0=;
 b=Neiaw1qHdKCftXidWoAPJFFFFF4kBHQNbWGK7VZKMLhCgLjyD5iWl7zQZn9Wvqfw2JP4Vi
 E0QhLxfwIwuZf3Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NT2UgWHI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="e/t9aR/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760539369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FvebpG7NjSqRY2CqGweF+ZtoQjExJCQ6PJW0m8msSZ0=;
 b=NT2UgWHIigh2MKdJfkt1sx8FV9ds/UuzvEpD9ko9x561Vywhg84lb5zujDYJW9+7WeH2fj
 AXclL1yl8M9vd4C4pHKZCWQjWnC6v1WvPuusBMPQrW0x2uf7TP+QCIagud30BYinPMp+Fa
 PjTpS8fD5OkI+T9MzEwXYW1DbPtUpXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760539369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FvebpG7NjSqRY2CqGweF+ZtoQjExJCQ6PJW0m8msSZ0=;
 b=e/t9aR/YuNBcCQ46teBkR1qFMlHTi3rcCZaQf20wQyQ2YpmIK9we6NQ3MP8S4SIBuIx1JU
 g6xCNHJF9WmrdMCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C72E313A29;
 Wed, 15 Oct 2025 14:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MmqRLuiy72htFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 Oct 2025 14:42:48 +0000
Date: Wed, 15 Oct 2025 16:42:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ben Copeland <ben.copeland@linaro.org>
Message-ID: <20251015144247.GB220875@pevik>
References: <20251015101533.30220-1-ben.copeland@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251015101533.30220-1-ben.copeland@linaro.org>
X-Rspamd-Queue-Id: 2B75533883
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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
Cc: arnd@arndb.de, lkft-triage@lists.linaro.org, ltp@lists.linux.it,
 dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> The overcommit test uses sum_total, the sum (memory and swap) to test
> the overcommit settings.

> This fixes two problems on 32-bit systems. The first is seen with a
> integer overflow can occur when calculating sum_total * 2, if the
> sum_total is larger than 2GB. The second is limited virtual address

You still mention GB ...

> space (2-3GB) means the test can fail from address space exhaustion
> before overcommit has been tested.

> Now the test runs correctly on low-memory 32-bit systems while avoiding
> both the overflow bug and virtual address space issues.

> Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../kernel/mem/tunable/overcommit_memory.c    | 33 +++++++++++++++----
>  1 file changed, 27 insertions(+), 6 deletions(-)

> diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
> index 9b2cb479d..7ff5a98d0 100644
> --- a/testcases/kernel/mem/tunable/overcommit_memory.c
> +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> @@ -131,24 +131,45 @@ static void overcommit_memory_test(void)
>  	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);

>  	update_mem_commit();
> -	alloc_and_check(commit_left * 2, EXPECT_FAIL);
> -	alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
> +	/* Skip tests that would overflow or exceed 32-bit address space */
> +	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {

... but TST_GB / TST_KB is actually MB (you could use TST_MB).

Yes, this fixes the problem on i686 as the tests are skipped as sum_total is
smaller than 1MB.

Kind regards,
Petr

tst_kernel.c:90: TINFO: uname.machine=i686 kernel is 32bit
tst_test.c:2021: TINFO: LTP version: 20250930
tst_test.c:2024: TINFO: Tested kernel: 6.17.1-1-default #1 SMP PREEMPT_DYNAMIC Tue Oct  7 04:26:30 UTC 2025 (1bf5c2e) i686
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1842: TINFO: Overall timeout per run is 0h 02m 00s
overcommit_memory.c:104: TINFO: MemTotal is 2050308 kB
overcommit_memory.c:106: TINFO: SwapTotal is 2098152 kB
overcommit_memory.c:110: TINFO: CommitLimit is 3121256 kB
overcommit_memory.c:123: TINFO: Setting /proc/sys/vm/overcommit_ratio to 30
overcommit_memory.c:126: TINFO: TotalBatchSize is 8008 kB
overcommit_memory.c:132: TINFO: Setting /proc/sys/vm/overcommit_memory to 2
overcommit_memory.c:140: TCONF: Skipping large allocation tests due to address space limits
overcommit_memory.c:146: TCONF: Skipping commit_left/2 allocation test due to address space limits
overcommit_memory.c:150: TINFO: Setting /proc/sys/vm/overcommit_memory to 0
overcommit_memory.c:152: TINFO: ONE_GB: 1073741824
overcommit_memory.c:153: TINFO: TST_GB: 1073741824
overcommit_memory.c:154: TINFO: TST_MB: 1048576
overcommit_memory.c:155: TINFO: TST_GB / TST_KB: 1048576
overcommit_memory.c:156: TINFO: TST_MB * 1024: 1073741824
overcommit_memory.c:157: TINFO: tst_kernel_bits(): 32
overcommit_memory.c:158: TINFO: (unsigned long)sum_total <= ONE_GB: 1
overcommit_memory.c:159: TINFO: (unsigned long)sum_total <= TST_GB: 1
overcommit_memory.c:160: TINFO: condition: 1
overcommit_memory.c:193: TINFO: malloc 1669706 kB successfully
overcommit_memory.c:212: TPASS: alloc passed as expected
overcommit_memory.c:171: TCONF: Skipping large allocation test due to address space limits
overcommit_memory.c:175: TINFO: Setting /proc/sys/vm/overcommit_memory to 1
overcommit_memory.c:193: TINFO: malloc 2074230 kB successfully
overcommit_memory.c:212: TPASS: alloc passed as expected
overcommit_memory.c:182: TCONF: Skipping large allocation tests due to address space limits


> +		alloc_and_check(commit_left * 2, EXPECT_FAIL);
> +		alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
> +	} else {
> +		tst_res(TCONF, "Skipping large allocation tests due to address space limits");
> +	}
>  	update_mem_commit();
> -	alloc_and_check(commit_left / 2, EXPECT_PASS);
> +	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
> +		alloc_and_check(commit_left / 2, EXPECT_PASS);
> +	} else {
> +		tst_res(TCONF, "Skipping commit_left/2 allocation test due to address space limits");
> +	}

>  	/* start to test overcommit_memory=0 */
>  	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 0, 1);

>  	update_mem();
>  	alloc_and_check(free_total / 2, EXPECT_PASS);
> -	alloc_and_check(sum_total * 2, EXPECT_FAIL);
> +	/* Skip if sum_total * 2 would exceed address space.
> +	 * On 32-bit, skip when sum_total > ULONG_MAX/4 (~1GB).
> +	 * Most 32-bit systems with <=1GB RAM can map 2x that in 3GB vaddr space.
> +	 * Systems with 2GB+ RAM likely cannot fit allocations in vaddr space. */
> +	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= TST_GB / TST_KB) {
> +		alloc_and_check(sum_total * 2, EXPECT_FAIL);
> +	} else {
> +		tst_res(TCONF, "Skipping large allocation test due to address space limits");
> +	}

>  	/* start to test overcommit_memory=1 */
>  	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 1, 1);

>  	alloc_and_check(sum_total / 2, EXPECT_PASS);
> -	alloc_and_check(sum_total, EXPECT_PASS);
> -	alloc_and_check(sum_total * 2, EXPECT_PASS);
> +	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= TST_GB / TST_KB) {
> +		alloc_and_check(sum_total, EXPECT_PASS);
> +		alloc_and_check(sum_total * 2, EXPECT_PASS);
> +	} else {
> +		tst_res(TCONF, "Skipping large allocation tests due to address space limits");
> +	}

>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
