Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15468606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=j0OcqKvG;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/WnWztha;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Gv3W34yQ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OlG7xzxX
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A06483E98A4
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 16:29:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12A583E49D1
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 16:29:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 38F201000D3E
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 16:29:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3D2333B1D;
 Fri, 30 Oct 2026 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793374160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FT8WGu2HJisBXXL/s03JE33dSgLVR6vSgfUXdXd1fhs=;
 b=j0OcqKvG+eN0TAPxswzQ85Kz/iN4Ym/EEDVVbHTHaFRtgdIYTSWB7yno6PFUtFNNY0Q5Fv
 FitAow7gBdEAmeLrNw+o8Wb4L6ONWPXCz9wTNJmUW9oGzSAbits0s0coOqou5XTP0dEz+b
 k4ADFiQ63Kn710ORui1UqTJ1lKqF0xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793374160;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FT8WGu2HJisBXXL/s03JE33dSgLVR6vSgfUXdXd1fhs=;
 b=/WnWzthakkABEfsfImDulrjsdGp0y3HMd8r9qSNWub8JwZ5PSedwnGdCY89tSY5a/v1agH
 eBaPLadJJRyvTyDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793374158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FT8WGu2HJisBXXL/s03JE33dSgLVR6vSgfUXdXd1fhs=;
 b=Gv3W34yQdcz4I1EFZTe2Lo2Bkfm9qfKA2zzeGmxFjQ/ktWtjavCS22NPu4mx1L2t7SuxS6
 ULsOsMbnNEhX+E5YYLTJQI1IrzHP7PvWhgi4e9wCdDtfyaMaI3SWZzQORdC6lOIUZxP4Co
 RMn3EZJi2f9L6fgINMjC+4K8aBQd3zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793374158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FT8WGu2HJisBXXL/s03JE33dSgLVR6vSgfUXdXd1fhs=;
 b=OlG7xzxXaW3hl0wy/RfnfON299aoHI33GWD3CdvuIj/h3tcVeTBttMxpHtOtYxIgfP2ilf
 IdqHS7/yDPpyhSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8651713432;
 Fri, 30 Oct 2026 15:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id neTXGs635Gp3WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 30 Oct 2026 15:29:18 +0000
Date: Fri, 30 Oct 2026 16:29:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <auS34aeU5tMadFsg@yuki.lan>
References: <20260830173408.261946-1-pavrampu@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260830173408.261946-1-pavrampu@linux.ibm.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 cgroup_fj_function.sh:url]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] memcg/memcontrol05: add cgroup v2 task
 migration charge accounting test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Verify that in cgroup v2, memory charges remain pinned to the cgroup
> that allocated them when a task migrates, and that new allocations after
> migration are charged to the destination cgroup.
> 
> Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
> ---
> v6 -> v7:
> - Replace named checkpoint enum with single index 0
> - Collapse wake/wait pairs into TST_CHECKPOINT_WAKE_AND_WAIT(0)
> - Drop worker_stage tracking
> - Replace manual pass/fail blocks with TST_EXP_LE_LU()
> - Remove MB(4) factor from migration charge check
> - Kill worker with SAFE_KILL/SAFE_WAITPID instead of checkpoint-based exit handshake
> link to v6: https://lore.kernel.org/ltp/20260817155701.943752-1-pavrampu@linux.ibm.com/
> ---
>  runtest/controllers                           |   1 +
>  testcases/kernel/controllers/memcg/.gitignore |   1 +
>  .../kernel/controllers/memcg/memcontrol05.c   | 160 ++++++++++++++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 testcases/kernel/controllers/memcg/memcontrol05.c
> 
> diff --git a/runtest/controllers b/runtest/controllers
> index 93c52c439..a9050ef0e 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -24,6 +24,7 @@ memcontrol01 memcontrol01
>  memcontrol02 memcontrol02
>  memcontrol03 memcontrol03
>  memcontrol04 memcontrol04
> +memcontrol05 memcontrol05
>  
>  cgroup_fj_function_debug cgroup_fj_function.sh debug
>  cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
> diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
> index 3883cede6..8b9f6005c 100644
> --- a/testcases/kernel/controllers/memcg/.gitignore
> +++ b/testcases/kernel/controllers/memcg/.gitignore
> @@ -9,3 +9,4 @@ memcontrol01
>  memcontrol02
>  memcontrol03
>  memcontrol04
> +memcontrol05
> diff --git a/testcases/kernel/controllers/memcg/memcontrol05.c b/testcases/kernel/controllers/memcg/memcontrol05.c
> new file mode 100644
> index 000000000..d452039e6
> --- /dev/null
> +++ b/testcases/kernel/controllers/memcg/memcontrol05.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 IBM
> + * Author : Pavithra <pavrampu@linux.ibm.com>
> + */
> +
> +/*\
> + * Origin: ``testcases/kernel/controllers/memctl/memctl_testplan.txt``
> + * Verify memory controller charge accounting during task migration.
> + *
> + * Two child cgroups (``group_a``, ``group_b``) are created under the test cgroup.
> + * A worker process is placed in ``group_a`` and allocates a known amount of
> + * anonymous memory, touching every page to ensure physical allocation.
> + * Root is required to create cgroup subdirectories and to write a PID
> + * into ``cgroup.procs`` to migrate the worker between cgroups.
> + *
> + * Test 1 - No charge transfer on migration:
> + *   The worker is migrated to ``group_b`` by writing its PID to
> + *   ``group_b/cgroup.procs``. In cgroup v2 memory charges are never
> + *   transferred on task migration; they remain pinned to the cgroup
> + *   that allocated them. ``group_b/memory.current`` must not increase
> + *   beyond its baseline after the migration.
> + *
> + * Test 2 - New allocations charged to destination cgroup:
> + *   After migration the worker allocates an additional chunk of memory.
> + *   This new allocation must be charged to ``group_b``, so
> + *   ``group_b/memory.current`` must increase from the post-migration
> + *   baseline.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +#include "memcontrol_common.h"
> +
> +#define ALLOC_SIZE	MB(60)
> +#define ALLOC_SIZE2	MB(20)
> +#define MIN_MEM_AVAIL	128
> +
> +static struct tst_cg_group *group_a;
> +static struct tst_cg_group *group_b;
> +static pid_t worker_pid;
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
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	buf2 = SAFE_MMAP(NULL, ALLOC_SIZE2, PROT_READ | PROT_WRITE,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	touch_pages(buf2, ALLOC_SIZE2);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	pause();
> +}
> +
> +static void test_memcg_task_migration(void)
> +{
> +	long baseline_b, after_migrate, after_migrate_a, after_alloc2, current_a;
> +
> +	worker_pid = 0;
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
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	SAFE_CG_SCANF(group_a, "memory.current", "%ld", &current_a);
> +	TST_EXP_LE_LU(ALLOC_SIZE, current_a);
> +
> +	SAFE_CG_PRINTF(group_b, "cgroup.procs", "%d", worker_pid);
> +	tst_res(TINFO, "Migrated worker PID %d to group_b", worker_pid);
> +
> +	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_migrate);
> +	tst_res(TINFO,
> +		"group_b memory.current=%ld after migration (baseline=%ld)",
> +		after_migrate, baseline_b);
> +
> +	TST_EXP_LE_LU(after_migrate, baseline_b);

I do not think that it's actually guaranteed that nothing is charged in
the cgroup_b after the migration. I guess that we can use values_close()
function here.

> +	SAFE_CG_SCANF(group_a, "memory.current", "%ld", &after_migrate_a);
> +	tst_res(TINFO, "group_a memory.current=%ld after migration", after_migrate_a);
> +	TST_EXP_EXPR(after_migrate_a >= (long)ALLOC_SIZE,
> +		     "group_a memory.current (%ld) still holds pre-migration charges (>= ALLOC_SIZE %ld)",
> +		     after_migrate_a, (long)ALLOC_SIZE);
> +
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_alloc2);
> +	tst_res(TINFO, "group_b memory.current=%ld after second alloc (baseline=%ld)",
> +		after_alloc2, after_migrate);
> +
> +	TST_EXP_EXPR(after_alloc2 >= after_migrate + (long)ALLOC_SIZE2,
> +		     "group_b memory.current (%ld) increased by >= ALLOC_SIZE2 (%ld)",
> +		     after_alloc2, (long)ALLOC_SIZE2);

And here as well, I suppose that we can only assert that the
after_alloc2 >= ALLOC_SIZE2.

Also CCing Michal Koutny, our cgroup expert.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
