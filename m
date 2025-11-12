Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11B4CD37BF
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 20:11:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74EDF3CF5FD
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 21:11:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 205713CF5FD
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 21:11:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1BF711400DC6
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 21:11:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA6F61F798;
 Wed, 12 Nov 2025 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762978291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N63RO4/fDX0buuEA3/dqqbw5NsgAusikv4C0SW5N8X4=;
 b=WL+r9E9xawm+tBZ3bxdhBIn1Oyhw6HbmScbk4pUnb7lyLL3Mj9sSzw0NmtK6cx/b/OH0lr
 PYDTMPigbQTve2voxS8wwHP2U0zu23XNCJdKh3RyDRD2VHH35DD80pxanQ1NnKv5EE/3/d
 sY4g7qdaEPoSBSmDHqLhirMS8rA3pPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762978291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N63RO4/fDX0buuEA3/dqqbw5NsgAusikv4C0SW5N8X4=;
 b=rtRTmbbs+C9s5icE/NBV0GYhGGuNRJo4ICx4jQYaSVH03Da6du1K7NcJ7I6OIvkd79EHWX
 pvbSN37fSH/23GAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="NgnJUR/D";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=asUQfyFz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762978290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N63RO4/fDX0buuEA3/dqqbw5NsgAusikv4C0SW5N8X4=;
 b=NgnJUR/DAGIjxRUWnshJJzYAJjVwxwf+DiS/vkBYV/VrYOl9HLT1peinVASMZPQ9n98FJ3
 8fqzX3loNZNwlxGb1jQTOnlrm90gaV949rpRTOWtMRj/5sxPrg49l6OE9cbs3fwPOF/dv+
 Z806M0sUfO3vQavHOvTO2+/mnlW0x30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762978290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N63RO4/fDX0buuEA3/dqqbw5NsgAusikv4C0SW5N8X4=;
 b=asUQfyFzzqbVWuEJDUxgLHG94naNbV5Ot0LxNTMSWI8yiBy9jtZIrMP5kj1N7gwdG21eqz
 bSDAzFf7irtL0gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32D6C3EA61;
 Wed, 12 Nov 2025 20:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u5llA/LpFGnfAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Nov 2025 20:11:30 +0000
Date: Wed, 12 Nov 2025 21:11:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Stephen Bertram <sbertram@redhat.com>
Message-ID: <20251112201124.GA157071@pevik>
References: <20251112180319.630584-1-sbertram@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251112180319.630584-1-sbertram@redhat.com>
X-Rspamd-Queue-Id: CA6F61F798
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add new tests for clone and clone3
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

Hi Ben,

> Confirming EPERM is returned when CAP_SYS_ADMIN is
> removed from clone and clone3.
> And for clone3 the set_tid_size is greater than 0.

>  runtest/syscalls                            |  2 +
>  testcases/kernel/syscalls/clone/.gitignore  |  1 +
>  testcases/kernel/syscalls/clone/clone11.c   | 72 +++++++++++++++++++++
>  testcases/kernel/syscalls/clone3/.gitignore |  1 +
>  testcases/kernel/syscalls/clone3/clone304.c | 63 ++++++++++++++++++
>  5 files changed, 139 insertions(+)

This looks better then v2. Generally LGTM, few notes below.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I see adding the test for both clone() and clone3() is because Li asked
[1] for it.

[1] https://lore.kernel.org/ltp/CAEemH2cQam9tOeQj_4SdvoYG5ZNmar6Quc5M6mtr==2-HQR9yQ@mail.gmail.com/

nit: I would  phrase the subject as "Add EPERM test for clone and clone3" to
have at least a bit of information in the subject.

...
> +/*\
> + * This test verifies that clone() fals with EPERM when CAP_SYS_ADMIN
s/fals/fails/

If new version is needed, could you please use :man2:`clone` ?
This will link man clone(2) [2] in our test catalog [3].

[2] https://man7.org/linux/man-pages/man2/clone.2.html
[3] https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

> + * has been dropped.
> + */
> +
> +#define _GNU_SOURCE

> +
> +#include "tst_test.h"
> +#include "clone_platform.h"

NOTE: we need to add
#include "lapi/sched.h"

otherwise old systems fail to compile due missing CLONE_NEWCGROUP.
This should really be fixed in a new version or before merge.

FYI we support kernel from 4.4 and glibc 2.22 [4].

[4] https://linux-test-project.readthedocs.io/en/latest/users/supported_systems.html

> +
> +static void *child_stack;
> +static int *child_pid;
> +
> +static struct tcase {
> +	uint64_t flags;
> +	char *sflags;
> +} tcases[] = {
> +	{CLONE_NEWPID, "CLONE_NEWPID"},

nit: If new version needed using macro is more elegant than copy pasting
definition as a string:

#define DESC(x) .flags = x, .sflags = #x
{ DESC(CLONE_NEWPID) },
{ DESC(CLONE_NEWCGROUP) },
...

> +	{CLONE_NEWCGROUP, "CLONE_NEWCGROUP"},
> +	{CLONE_NEWIPC, "CLONE_NEWIPC"},
> +	{CLONE_NEWNET, "CLONE_NEWNET"},
> +	{CLONE_NEWNS, "CLONE_NEWNS"},
> +	{CLONE_NEWUTS, "CLONE_NEWUTS"},
> +};
> +
> +static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +		*child_pid = getpid();
> +		exit(0);
nit: there are 2 tabs.
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	TST_EXP_FAIL(ltp_clone(tc->flags, child_fn, NULL, CHILD_STACK_SIZE,
> +			child_stack), EPERM, "clone(%s) should fail with EPERM"
> +			, tc->sflags);
very nit: ',' is usually on a previous line.
> +}
> +
> +static void setup(void)
> +{
> +	child_pid = SAFE_MMAP(NULL, sizeof(*child_pid), PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (child_pid)
> +		SAFE_MUNMAP(child_pid, sizeof(*child_pid));
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.test = run,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.caps = (struct tst_cap []) {
> +			TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
> +			{},
> +	},
> +	.bufs = (struct tst_buffers []) {
> +			{&child_stack, .size = CHILD_STACK_SIZE},
> +			{},
> +	},
> +};
> diff --git a/testcases/kernel/syscalls/clone3/.gitignore b/testcases/kernel/syscalls/clone3/.gitignore
> index 10369954b..e9b5312f4 100644
> --- a/testcases/kernel/syscalls/clone3/.gitignore
> +++ b/testcases/kernel/syscalls/clone3/.gitignore
> @@ -1,3 +1,4 @@
>  clone301
>  clone302
>  clone303
> +clone304
> diff --git a/testcases/kernel/syscalls/clone3/clone304.c b/testcases/kernel/syscalls/clone3/clone304.c
> new file mode 100644
> index 000000000..e47ab313e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone304.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Stephen Bertram <sbertram@redhat.com>
> + */
> +
> +/*\
> + * This test verifies that clone3() fals with EPERM when CAP_SYS_ADMIN
> + * has been dropped and ``clone_args.set_tid_size`` is greater than zero.
> + */
> +
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +
> +static struct clone_args args = {0};
> +static pid_t tid_array[4] = {0, 0, 0, 0};
> +
> +static struct tcase {
> +	uint64_t flags;
> +	char *sflags;
> +} tcases[] = {
> +	{CLONE_NEWPID, "CLONE_NEWPID"},
> +	{CLONE_NEWCGROUP, "CLONE_NEWCGROUP"},
> +	{CLONE_NEWIPC, "CLONE_NEWIPC"},
> +	{CLONE_NEWNET, "CLONE_NEWNET"},
> +	{CLONE_NEWNS, "CLONE_NEWNS"},
> +	{CLONE_NEWUTS, "CLONE_NEWUTS"},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	args.flags = tc->flags;
> +
> +	TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM, "clone3(%s) should fail with EPERM"
> +			, tc->sflags);
> +}
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +
> +	memset(&args, 0, sizeof(args));
> +	args.set_tid = (uintptr_t)tid_array;
> +	/* set_tid_size greater than zero - requires CAP_SYS_ADMIN */
> +	args.set_tid_size = 4;
> +}
> +
> +static struct tst_test test = {
NOTE: man clone(2) claims set_tid_size is "since Linux 5.5".
But fortunately test TCONF correctly:
../../../../include/lapi/sched.h:88: TCONF: syscall(435) __NR_clone3 not supported on your arch

Therefore we don't need to add .min_kver = "5.5".

> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.test = run,
> +	.needs_root = 1,
> +	.caps = (struct tst_cap []) {
> +			TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
> +			{},
> +	},
> +	.bufs = (struct tst_buffers []) {
> +			{&args, .size = sizeof(struct clone_args)},
> +			{},
> +	},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
