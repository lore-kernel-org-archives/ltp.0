Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A681ACD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 15:40:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C13783C4C48
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 17:40:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E98B3C4AD2
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 17:39:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E46C5601464
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 17:39:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 25A671FBEF;
 Mon,  2 Sep 2024 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725291594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W15I3NXxh6cQ4E/g/lz9PKyNQNU5qzvCcRVrPO1VbBQ=;
 b=FG1IxKehWnRkT5cuMnhDv4FR+a8a6TToRX31Z16zCqFe5arRgy4qeZ+IyVTJKYurPeG712
 AwZ2fdacYdZ4OnSirbY/x3i+g8VTV+51HENQQWMsio89Wmjy1+dbTjlcTZ/+/JA8M+/aLo
 lv1zvgtoGTnGFV9EJcTbaqfTkNHhPvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725291594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W15I3NXxh6cQ4E/g/lz9PKyNQNU5qzvCcRVrPO1VbBQ=;
 b=EvrczkK+yz0cFjI4AcbeI/9oWiIE6mmiaUX7kDTNmUV7Fu/TEb8362DEs0yD95noOUuc0q
 8shefXy3MFNewgAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FG1IxKeh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EvrczkK+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725291594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W15I3NXxh6cQ4E/g/lz9PKyNQNU5qzvCcRVrPO1VbBQ=;
 b=FG1IxKehWnRkT5cuMnhDv4FR+a8a6TToRX31Z16zCqFe5arRgy4qeZ+IyVTJKYurPeG712
 AwZ2fdacYdZ4OnSirbY/x3i+g8VTV+51HENQQWMsio89Wmjy1+dbTjlcTZ/+/JA8M+/aLo
 lv1zvgtoGTnGFV9EJcTbaqfTkNHhPvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725291594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W15I3NXxh6cQ4E/g/lz9PKyNQNU5qzvCcRVrPO1VbBQ=;
 b=EvrczkK+yz0cFjI4AcbeI/9oWiIE6mmiaUX7kDTNmUV7Fu/TEb8362DEs0yD95noOUuc0q
 8shefXy3MFNewgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4172613A7C;
 Mon,  2 Sep 2024 15:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /raSDknc1Wa1TAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Sep 2024 15:39:53 +0000
Date: Mon, 2 Sep 2024 17:38:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Spoorthy <spoorthy@linux.ibm.com>
Message-ID: <ZtXb-70wFQQcweuY@yuki.lan>
References: <20240510141020.189065-1-spoorthy@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240510141020.189065-1-spoorthy@linux.ibm.com>
X-Rspamd-Queue-Id: 25A671FBEF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] [PATCH] Hugetlb: Migrating libhugetlbfs
 shm-perms
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
> Test Description: Tests the behavior of shared memory when
> multiple threads attach to a segment with different permissions. At one
> stage, the reservation accounting of free hugepages allocated to parent and
> child's process may mess up during the memory operations.
> 
> Creates 4 hugepages in parent and a shared memory segment of size segment_size with 0640 permission,
> The segment attaches to process address space and it is partially initialized by filling four parts of the segment with a pattern(0x55).
> The segment is detached from the process's address space.
> Next create child processes in a loop, Each child process reattaches to the shared memory segment as read-only by calling attach_segment() with the SHM_RDONLY flag. After attaching, the child process detaches from the segment using shmdt() and exits. If either attach or detach fails, the test fails
> Also if the reservation accounting calculated by comparing the free hugepage memory in parent's and child's process does not match, the test fails
> The parent process waits for all the child processes to exit. If all child processes exit successfully and the reservation accounting of parent and childprocess matches then the test passes
> 
> Tested and verified the success of test case
> 
> Signed-off-by: Spoorthy <spoorthy@linux.ibm.com>
> -------
> Changes in v2:
> 1)Make check errors are taken care
> 2)segment_size is not static
> 3)Added check to compare the free hugepage memory
> -------
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../mem/hugetlb/hugeshmat/hugeshmat06.c       | 105 ++++++++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..240701b2b 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -44,6 +44,7 @@ hugeshmat02 hugeshmat02 -i 5
>  hugeshmat03 hugeshmat03 -i 5
>  hugeshmat04 hugeshmat04 -i 5
>  hugeshmat05 hugeshmat05 -i 5
> +hugeshmat06 hugeshmat06
>  
>  hugeshmctl01 hugeshmctl01 -i 5
>  hugeshmctl02 hugeshmctl02 -i 5
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index c96fe8bfc..4ad1dc313 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -39,6 +39,7 @@
>  /hugetlb/hugeshmat/hugeshmat03
>  /hugetlb/hugeshmat/hugeshmat04
>  /hugetlb/hugeshmat/hugeshmat05
> +/hugetlb/hugeshmat/hugeshmat06
>  /hugetlb/hugeshmctl/hugeshmctl01
>  /hugetlb/hugeshmctl/hugeshmctl02
>  /hugetlb/hugeshmctl/hugeshmctl03
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
> new file mode 100644
> index 000000000..8b669fb18
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +/*\
> + * [DESCRIPTION]
> + *	Test shared memory behavior when multiple threads are attached
> + *	to a segment with different permissions.  A segment is created
> + *	and children attach read-only to check reservation accounting.

Please no tabs in the documentation comment.

> + */
> +
> +#include "hugetlb.h"
> +#include "tst_safe_sysv_ipc.h"
> +
> +#define SEGMENT_KEY (0x82ba15ff)
> +#define MNTPOINT "hugetlbfs/"
> +
> +static int global_shmid = -1;
> +static void *shmaddr;
> +static long segment_size, hpage_size, stride;
> +
> +static int attach_segment(size_t segsize, int shmflags, int shmperms)
> +{
> +	int shmid;
> +
> +	shmid = SAFE_SHMGET(SEGMENT_KEY, segsize, shmflags);
> +	shmaddr = SAFE_SHMAT(shmid, shmaddr, shmperms);
> +	global_shmid = shmid;
> +	return shmid;
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
> +	segment_size = 4 * hpage_size;
> +	stride = hpage_size;
> +	if (hpage_size > segment_size)
> +		tst_res(TCONF, "Page size is too large for configured segment_size");

the segment_size = 4 * hpage_size so this if is effectively:

	if (hpage_size > 4 * hpage_size)

Which should be always false.

> +}
> +
> +static void compare_free_hugepage_memory(long free_end, long free_start)
> +{
> +	if (free_end != free_start) {
> +		tst_res(TFAIL, "Free hugepages allocated after multiple threads attached is not equal to initial free hugepages allocated");

This message is way too long. Please keep things short and to the point.

> +		exit(EXIT_FAILURE);

The test results are not propagated by the process exit value, the test
must not call exit() with anything but 0. And that is usually not needed
either the test just needs to return from the run_test() function.

> +	}
> +}
> +
> +static void run_test(void)
> +{
> +	char *p;
> +	int i, iterations;
> +	pid_t *wait_list;
> +	long total_hpages, free_start, free_end, val;
> +
> +	total_hpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
> +	iterations = (total_hpages * hpage_size) / segment_size+1;
> +	wait_list = SAFE_MALLOC(sizeof(pid_t) * iterations);
> +	attach_segment(segment_size, IPC_CREAT | SHM_HUGETLB | 0640, 0);
> +	p = (char *)shmaddr;
> +	for (i = 0; i < 4; i++, p += stride)
> +		memset(p, 0x55, stride);
> +	free_start = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	SAFE_SHMDT((const void *)shmaddr);
> +	for (i = 0; i < iterations; i++) {
> +		pid_t pid;
> +
> +		pid = SAFE_FORK();
> +		if (pid) {
> +			wait_list[i] = pid;

There is no need to save the pids if we are not using them for anything.

> +		} else {
> +			attach_segment(0, 0, SHM_RDONLY);
> +			for (i = 0; i < 4; i++)
                                        ^
					This is hardcoded here and in
					the test setup, maybe we need
					#define HPAGES_IN_SEGMENT 4
					at the start of the test
					instead.
> +				val = *((char *)shmaddr + (i * hpage_size));
> +			SAFE_SHMDT(((const void *)shmaddr));
> +			free_end = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +			compare_free_hugepage_memory(free_end, free_start);
> +			exit(EXIT_SUCCESS);
> +		}
> +	}
> +	free_end = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	compare_free_hugepage_memory(free_end, free_start);
> +	for (i = 0; i < iterations; i++)
> +		tst_reap_children();

This function waits all children, not just one, so there is no need to
call it in a loop.

> +	tst_res(TPASS, "Successfully tested shared memory behavior when multiple threads are attached");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (global_shmid >= 0)
> +		SAFE_SHMCTL(global_shmid, IPC_RMID, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {32, TST_NEEDS},
> +};
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
