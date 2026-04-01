Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3BED3517C
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 13:05:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AD393E6593
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 15:05:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FA003CA01A
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 15:04:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19F01200097
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 15:04:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E2E84D313;
 Wed,  1 Apr 2026 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775048685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OBBeBEEnbzqTRfZ7xSCKtWBJEbMU4kYxpOiDegjL2cs=;
 b=DWzHbD17b7iCgi6Uv8HY2sdfTciWnz8AcKEHQUIAZEimZoUUlIXd6PsCO96XORVVL0vaLS
 h7aS0PnYvGFlYBTpuOiWz3CMPUqmLni3QkuBBewp0YG45cUcU2+OVm+hNpmTgjG375RyqY
 +U9u+NhPI6W4pzz3xsO+rUOcGdhprqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775048685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OBBeBEEnbzqTRfZ7xSCKtWBJEbMU4kYxpOiDegjL2cs=;
 b=sSBM3t6Ou0blKjfYH6+Z58/jEvHQtdD0M6G1aUXsFnk8FZCwitG+LjMs3x4kytpPYg7+tM
 Q1nvE0R/14i+AeBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DWzHbD17;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sSBM3t6O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775048685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OBBeBEEnbzqTRfZ7xSCKtWBJEbMU4kYxpOiDegjL2cs=;
 b=DWzHbD17b7iCgi6Uv8HY2sdfTciWnz8AcKEHQUIAZEimZoUUlIXd6PsCO96XORVVL0vaLS
 h7aS0PnYvGFlYBTpuOiWz3CMPUqmLni3QkuBBewp0YG45cUcU2+OVm+hNpmTgjG375RyqY
 +U9u+NhPI6W4pzz3xsO+rUOcGdhprqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775048685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OBBeBEEnbzqTRfZ7xSCKtWBJEbMU4kYxpOiDegjL2cs=;
 b=sSBM3t6Ou0blKjfYH6+Z58/jEvHQtdD0M6G1aUXsFnk8FZCwitG+LjMs3x4kytpPYg7+tM
 Q1nvE0R/14i+AeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55AC94A0B0;
 Wed,  1 Apr 2026 13:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NaC2FO0XzWmMLAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 01 Apr 2026 13:04:45 +0000
Message-ID: <a982600e-700c-44e9-a985-4a122477ad42@suse.cz>
Date: Wed, 1 Apr 2026 15:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pavithra <pavrampu@linux.ibm.com>, ltp@lists.linux.it
References: <20260329120425.213306-1-pavrampu@linux.ibm.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260329120425.213306-1-pavrampu@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 5E2E84D313
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix memcontrol03 test failure.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
TL;DR of my review: This patch makes the test basically useless. I can't 
even find any part that could be reworked into something marginally useful.

On 3/29/26 14:04, Pavithra wrote:
>   Fixed "tst_cgroup.c:1044: TBROK: unlinkat(5</sys/fs/cgroup/ltp>,
>    'test-12687', AT_REMOVEDIR): EBUSY (16)" Error due to checkpoint synchronization timeouts, and

Could you point me to the part which fixes this checkpoint 
synchronization timeout? I can't find it.

> adapts the test for PowerPC64 architecture-specific memory behavior.
> 
> Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
> ---
>   .../kernel/controllers/memcg/memcontrol03.c   | 60 ++++++++++++++-----
>   1 file changed, 46 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
> index 493e970ab..4e6dfe0fb 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol03.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol03.c
> @@ -32,6 +32,8 @@
>    * filesystems which allocate extra memory for buffer heads.
>    *
>    * The tolerances have been increased from the self tests.
> + * PowerPC64 adjustments: Higher tolerances and adjusted expectations
> + * due to different memory reclaim behavior.
>    */
>   
>   #define _GNU_SOURCE
> @@ -126,6 +128,12 @@ static void alloc_anon_in_child(const struct tst_cg_group *const cg,
>   		return;
>   	}
>   
> +	/* On some systems, OOM behavior may vary - accept both outcomes */
> +	if (expect_oom && WIFEXITED(status) && WEXITSTATUS(status) == 0) {
> +		tst_res(TINFO, "Child %d exited instead of OOM (acceptable on some systems)", pid);
> +		return;
> +	}
> +

If this is acceptable on SOME systems, then this exception should be 
conditional only for those specific systems. You're disabling a check 
for architectures where missing an expected OOM is not acceptable.

>   	tst_res(TFAIL,
>   		"Expected child %d to %s, but instead %s",
>   		pid,
> @@ -166,6 +174,7 @@ static void test_memcg_min(void)
>   	long c[4];
>   	unsigned int i;
>   	size_t attempts;
> +	long actual_mem, initial_mem;
>   
>   	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
>   	trunk_cg[A] = tst_cg_group_mk(tst_cg, "trunk_A");
> @@ -178,7 +187,7 @@ static void test_memcg_min(void)
>   
>   	SAFE_CG_PRINT(trunk_cg[A], "cgroup.subtree_control", "+memory");
>   
> -	SAFE_CG_PRINT(trunk_cg[A], "memory.max", "200M");
> +	SAFE_CG_PRINT(trunk_cg[A], "memory.max", "250M");
>   	SAFE_CG_PRINT(trunk_cg[A], "memory.swap.max", "0");
>   
>   	trunk_cg[B] = tst_cg_group_mk(trunk_cg[A], "trunk_B");
> @@ -194,7 +203,7 @@ static void test_memcg_min(void)
>   		if (i == E)
>   			continue;
>   
> -		alloc_pagecache_in_child(leaf_cg[i], MB(50));
> +		alloc_pagecache_in_child(leaf_cg[i], MB(46));
>   	}
>   
>   	SAFE_CG_PRINT(trunk_cg[A], "memory.min", "50M");
> @@ -204,35 +213,58 @@ static void test_memcg_min(void)
>   	SAFE_CG_PRINT(leaf_cg[E], "memory.min", "500M");
>   	SAFE_CG_PRINT(leaf_cg[F], "memory.min", "0");
>   
> -	for (attempts = 0; attempts < 5; attempts++) {
> -		SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
> -		if (values_close(c[0], MB(150), 3))
> +	/* Wait for memory to stabilize */
> +	for (attempts = 0; attempts < 15; attempts++) {
> +		SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", &actual_mem);
> +		tst_res(TINFO, "Attempt %zu: A/B memory.current=%ld (target ~%d)",
> +			attempts + 1, actual_mem, MB(138));
> +		if (values_close(actual_mem, MB(138), 15))
>   			break;
>   
>   		sleep(1);
>   	}
>   
> -	alloc_anon_in_child(trunk_cg[G], MB(148), 0);
> +	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", &initial_mem);
> +	tst_res(TINFO, "Initial A/B memory: %ld bytes", initial_mem);
> +
> +	/* First allocation - should succeed and cause some reclaim */
> +	long alloc_size = MB(250) - initial_mem - MB(10);
> +	if (alloc_size < MB(100))
> +		alloc_size = MB(100);

Here you've eliminated all memory pressure from the cgroups, which 
should make the reclaim checks fail, because all leaf cgroups will stay 
above memory.min limit.

>   
> +	tst_res(TINFO, "First allocation: %ld bytes", alloc_size);
> +	alloc_anon_in_child(trunk_cg[G], alloc_size, 0);
> +
> +	/* Check memory after first allocation */
>   	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
> -	TST_EXP_EXPR(values_close(c[0], MB(50), 5),
> -		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
> +
> +	/* On PowerPC64, memory.min protection may not work perfectly,
> +	 * so we use very relaxed tolerances and check that memory was
> +	 * at least partially reclaimed */
> +	if (c[0] < initial_mem) {
> +		tst_res(TPASS, "A/B memory reclaimed: %ld -> %ld", initial_mem, c[0]);
> +	} else {
> +		tst_res(TINFO, "A/B memory.current=%ld (initial=%ld, expected reclaim)",
> +			c[0], initial_mem);
> +	}
>   
>   	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
>   		SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
>   
> -	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
> -		     "(A/B/C memory.current=%ld) ~= %d", c[0], MB(33));
> -	TST_EXP_EXPR(values_close(c[1], MB(17), 20),
> -		     "(A/B/D memory.current=%ld) ~= %d", c[1], MB(17));
> +	/* Very relaxed checks - just verify memory is distributed */
> +	TST_EXP_EXPR(c[0] > 0 && c[0] < MB(100),
> +		     "(A/B/C memory.current=%ld) in reasonable range", c[0]);
> +	TST_EXP_EXPR(c[1] > 0 && c[1] < MB(100),
> +		     "(A/B/D memory.current=%ld) in reasonable range", c[1]);

And here you've made the checks completely useless, because you've 
allocated only 46MB in leaf cgroups and you're checking that the final 
value is between 0 and 100MB.

>   	TST_EXP_EXPR(values_close(c[2], 0, 1),
>   		     "(A/B/E memory.current=%ld) ~= 0", c[2]);
>   
> +	/* Second allocation - may or may not trigger OOM depending on system */
> +	tst_res(TINFO, "Second allocation: attempting OOM scenario");
>   	alloc_anon_in_child(trunk_cg[G], MB(170), 1);
>   
>   	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
> -	TST_EXP_EXPR(values_close(c[0], MB(50), 5),
> -		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
> +	tst_res(TINFO, "Final A/B memory.current=%ld", c[0]);
>   
>   	cleanup_sub_groups();
>   	SAFE_CLOSE(fd);


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
