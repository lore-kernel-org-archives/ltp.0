Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C2DC61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:33:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C2EA3E9A6E
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:33:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C33153D0F40
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:32:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D04D1000530
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:32:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7367221E19;
 Fri, 28 Aug 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787927562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzZQwcDbCvS4v1vd/CUG9nBhv11sB7AbkdJD6FBNE04=;
 b=07PadHe9C7KFN2BTxlvBjpUFY0tl4FWBTiC9YbWN/o4cqqs1TR3GeEHOxw1s1/lJ2yoxze
 8+44WJ0cBTbsqMRjfaL+WTDLJdzMoh+IlLMdLdTvoL3FgdJn3cas1DVE0bZYLYKU7vR09K
 bEGd+ISQEBZGVy5IrIPBpNoSdXfDeTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787927562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzZQwcDbCvS4v1vd/CUG9nBhv11sB7AbkdJD6FBNE04=;
 b=UZFWpRUfDIMJkEWtPwXyKeZo62+TOQzptlmXpnX22cUwtA34+EMfVVKSfPbkZ4BwPB6eRx
 4gLN+qFlkHxUAEDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787927558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzZQwcDbCvS4v1vd/CUG9nBhv11sB7AbkdJD6FBNE04=;
 b=XI1TWHZ/1BkMcXk2WmM74khVygOBXQOc30PwccCwqx1y0QirZfNsC1ffTwUQGIGM30mHk0
 WzQZetNFG9bNoBpQGm38mwTNMwrLsv+xfOAApBwlRIZue//8X+mXkBo24YV0i8fHs8TqFa
 lMKy8NU0uoFdfS/ZwyXp5Dey6pZqb8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787927558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzZQwcDbCvS4v1vd/CUG9nBhv11sB7AbkdJD6FBNE04=;
 b=ZplhZStBDS67Zd54cHTbmdc5petUTj9GbC1pv3/ahMWvSeexblo8gutkcRVl8O5vWeM5em
 mmWKH/e48lN7+PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AF4813515;
 Fri, 28 Aug 2026 14:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 01BHEgackWrZLwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Aug 2026 14:32:38 +0000
Date: Fri, 28 Aug 2026 16:32:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <apGcDIIDG8u2NoQy@yuki.lan>
References: <20260817155701.943752-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260817155701.943752-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] memcg/memcontrol05: add cgroup v2 task
 migration charge accounting test
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
> +enum checkpoints {
> +	WORKER_ALLOC_DONE,
> +	WORKER_RESUME,
> +	WORKER_ALLOC2_DONE,
> +	WORKER_EXIT,
> +};
> +
> +static struct tst_cg_group *group_a;
> +static struct tst_cg_group *group_b;
> +static pid_t worker_pid;
> +
> +enum worker_stage {
> +	STAGE_NOT_STARTED,
> +	STAGE_WAITING_RESUME,   /* worker blocked on WORKER_RESUME */
> +	STAGE_WAITING_EXIT,     /* worker blocked on WORKER_EXIT  */
> +	STAGE_DONE,             /* worker reaped                  */
> +};

First of all since we serialize only two processes, all that is needed
is single checkpoint.

> +static enum worker_stage worker_stage;
> +
> +static void touch_pages(char *buf, size_t size)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < size; i += getpagesize())
> +		buf[i] = 1;
> +}
> +
> +static void worker(void)
> +{
> +	char *buf1, *buf2;
> +
> +	SAFE_CG_PRINTF(group_a, "cgroup.procs", "%d", getpid());
> +
> +	buf1 = SAFE_MMAP(NULL, ALLOC_SIZE, PROT_READ | PROT_WRITE,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	touch_pages(buf1, ALLOC_SIZE);
> +
> +	TST_CHECKPOINT_WAKE(WORKER_ALLOC_DONE);
> +
> +	TST_CHECKPOINT_WAIT(WORKER_RESUME);

Should be just TST_CHECKPOINT_WAKE_AND_WAIT(0);

> +	buf2 = SAFE_MMAP(NULL, ALLOC_SIZE2, PROT_READ | PROT_WRITE,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	touch_pages(buf2, ALLOC_SIZE2);
> +
> +	TST_CHECKPOINT_WAKE(WORKER_ALLOC2_DONE);
> +
> +	TST_CHECKPOINT_WAIT(WORKER_EXIT);

Here as well.

> +	SAFE_MUNMAP(buf1, ALLOC_SIZE);
> +	SAFE_MUNMAP(buf2, ALLOC_SIZE2);
> +}

With the checkpoints unified to a single checkpoint we do not need to
track the worker_stage either.

> +static void test_memcg_task_migration(void)
> +{
> +	long baseline_b, after_migrate, after_migrate_a, after_alloc2, current_a;
> +
> +	worker_pid = 0;
> +	worker_stage = STAGE_NOT_STARTED;
> +
> +	group_a = tst_cg_group_mk(tst_cg, "group_a");
> +	group_b = tst_cg_group_mk(tst_cg, "group_b");
> +
> +	if (SAFE_CG_HAS(tst_cg, "memory.swap.max")) {
> +		SAFE_CG_PRINT(group_a, "memory.swap.max", "0");
> +		SAFE_CG_PRINT(group_b, "memory.swap.max", "0");
> +	}
> +
> +	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &baseline_b);
> +	tst_res(TINFO, "group_b baseline memory.current=%ld", baseline_b);
> +
> +	worker_pid = SAFE_FORK();
> +	if (!worker_pid) {
> +		worker();
> +		exit(0);
> +	}
> +	worker_stage = STAGE_WAITING_RESUME;
> +
> +	TST_CHECKPOINT_WAIT(WORKER_ALLOC_DONE);
> +
> +	SAFE_CG_SCANF(group_a, "memory.current", "%ld", &current_a);


> +	tst_res(TINFO, "group_a memory.current=%ld after alloc", current_a);
> +	if (current_a < (long)ALLOC_SIZE) {
> +		tst_res(TFAIL,
> +			"group_a memory.current (%ld) < ALLOC_SIZE (%ld)",
> +			current_a, (long)ALLOC_SIZE);
> +		goto done;
> +	}
> +	tst_res(TPASS,
> +		"group_a memory.current (%ld) >= ALLOC_SIZE (%ld)",
> +		current_a, (long)ALLOC_SIZE);

This whole block should be TST_EXP_LE_LU()


> +	SAFE_CG_PRINTF(group_b, "cgroup.procs", "%d", worker_pid);
> +	tst_res(TINFO, "Migrated worker PID %d to group_b", worker_pid);
> +
> +	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_migrate);
> +
> +	tst_res(TINFO,
> +		"group_b memory.current=%ld after migration (baseline=%ld)",
> +		after_migrate, baseline_b);
> +
> +	TST_EXP_EXPR(after_migrate <= baseline_b + (long)MB(4),
> +		     "group_b memory.current (%ld) not increased after migration (baseline=%ld)",
> +		     after_migrate, baseline_b);

Where did the MB(4) came from? Magic constants like that surely wouldn't
work universally.

> +	SAFE_CG_SCANF(group_a, "memory.current", "%ld", &after_migrate_a);
> +	tst_res(TINFO, "group_a memory.current=%ld after migration", after_migrate_a);
> +	TST_EXP_EXPR(after_migrate_a >= (long)ALLOC_SIZE,
> +		     "group_a memory.current (%ld) still holds pre-migration charges (>= ALLOC_SIZE %ld)",
> +		     after_migrate_a, (long)ALLOC_SIZE);
> +
> +	TST_CHECKPOINT_WAKE(WORKER_RESUME);
> +	worker_stage = STAGE_WAITING_EXIT;
> +	TST_CHECKPOINT_WAIT(WORKER_ALLOC2_DONE);

Here as well should be just TST_CHECKPOINT_WAKE_AND_WAIT(0);

> +	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_alloc2);
> +	tst_res(TINFO, "group_b memory.current=%ld after second alloc (baseline=%ld)",
> +		after_alloc2, after_migrate);
> +
> +	TST_EXP_EXPR(after_alloc2 >= after_migrate + (long)ALLOC_SIZE2,
> +		     "group_b memory.current (%ld) increased by >= ALLOC_SIZE2 (%ld)",
> +		     after_alloc2, (long)ALLOC_SIZE2);
> +
> +done:
> +	if (worker_stage == STAGE_WAITING_RESUME) {
> +		TST_CHECKPOINT_WAKE(WORKER_RESUME);
> +		worker_stage = STAGE_WAITING_EXIT;
> +		TST_CHECKPOINT_WAIT(WORKER_ALLOC2_DONE);
> +	}
> +	if (worker_stage == STAGE_WAITING_EXIT) {
> +		TST_CHECKPOINT_WAKE(WORKER_EXIT);
> +		tst_reap_children();
> +		worker_pid = 0;
> +		worker_stage = STAGE_DONE;
> +	}

I would be way easier to SAFE_KILL() and SAFE_WAITPID() the worker
process. And the same in the test setup.

> +	group_a = tst_cg_group_rm(group_a);
> +	group_b = tst_cg_group_rm(group_b);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (worker_stage == STAGE_WAITING_RESUME) {
> +		TST_CHECKPOINT_WAKE(WORKER_RESUME);
> +		worker_stage = STAGE_WAITING_EXIT;
> +		TST_CHECKPOINT_WAIT(WORKER_ALLOC2_DONE);
> +	}
> +	if (worker_stage == STAGE_WAITING_EXIT) {
> +		TST_CHECKPOINT_WAKE(WORKER_EXIT);
> +		tst_reap_children();
> +	}
> +
> +	if (group_a)
> +		group_a = tst_cg_group_rm(group_a);
> +	if (group_b)
> +		group_b = tst_cg_group_rm(group_b);
> +}
> +
> +static struct tst_test test = {
> +	.test_all	= test_memcg_task_migration,
> +	.cleanup	= cleanup,
> +	.forks_child	= 1,
> +	.needs_root	= 1,
> +	.needs_checkpoints = 1,
> +	.needs_cgroup_ver  = TST_CG_V2,
> +	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
> +	.min_mem_avail	= MIN_MEM_AVAIL,
> +};
> -- 
> 2.55.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
