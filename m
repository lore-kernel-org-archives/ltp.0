Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90191C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 12:00:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D0DF3CAFD9
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 14:00:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38CA93CAFCA
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 14:00:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 918441A00252
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 14:00:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB9ED205EA;
 Mon, 17 Oct 2022 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666008021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOnjf+BdGCVQ3HC3RO0qZu6OPmdZA+JIiPuDUPFfBAM=;
 b=L2/q7HX/I44nhzbGKr2P7bnk5SrhSVih82az9v3n3Oa2SnVGtndH2Iiweau/ovFos++Svc
 nAtoFz2GIlEKOpuQPFfT7CQK0YBCO/ESOSt0X/ztoleZgU1wB9rrHseKz7bHMFBaaxyahU
 B4HoGyCFSdEmdQu3CXa8PLd4v7hUYE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666008021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOnjf+BdGCVQ3HC3RO0qZu6OPmdZA+JIiPuDUPFfBAM=;
 b=KBZGwjHtk0Zw4ix7tk7waes6rEwvjpPDYThknuVXRk5z1t7B2rSz9dEVf6RsX9vIeBNxu/
 1d29v3nL1bDTvPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B63913398;
 Mon, 17 Oct 2022 12:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zgCaDtVDTWN7IwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 12:00:21 +0000
Date: Mon, 17 Oct 2022 14:02:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y01EOw44z65j+quq@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-5-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-5-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/29] Hugetlb: Migrating libhugetlbfs counters
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 475 ++++++++++++++++++
>  3 files changed, 477 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index e2ada7a97..8a56d52a3 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -6,6 +6,7 @@ hugemmap06 hugemmap06
>  hugemmap07 hugemmap07
>  hugemmap08 hugemmap08
>  hugemmap09 hugemmap09
> +hugemmap10 hugemmap10
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 1a242ffe0..e7def68cb 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -7,6 +7,7 @@
>  /hugetlb/hugemmap/hugemmap07
>  /hugetlb/hugemmap/hugemmap08
>  /hugetlb/hugemmap/hugemmap09
> +/hugetlb/hugemmap/hugemmap10
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> new file mode 100644
> index 000000000..107add669
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> @@ -0,0 +1,475 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2007 David Gibson & Adam Litke, IBM Corporation.
> + *
> + * Test Name: Counters
> + *
> + * Test Description: This Test perform mmap and unmap and write operation on
> + * hugetlb file based mapping. Mapping can be shared or private. and it checks
> + * for Hugetlb counter (Total, Free, Reserve, Surplus) in /proc/meminfo and
> + * compare them with expected (calculated) value. if all checks are successful,
> + * the test passes.

Here as well.

> + * HISTORY
> + *  Written by David Gibson & Adam Litke
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +
> +#include "hugetlb.h"
> +
> +
> +/* Global test configuration */

Please no useless comments like this one.

> +#define PROC_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
> +#define PROC_OVERCOMMIT "/proc/sys/vm/nr_overcommit_hugepages"
> +static long saved_nr_hugepages = -1;
> +static long saved_oc_hugepages = -1;

The two proc files should be saved and restored by the .save_restore
array in the tst_test structure.

> +static long hpage_size;
> +static int private_resv;
> +static char *verbose;
> +
> +/* State arrays for our mmaps */
> +#define NR_SLOTS	2
> +#define SL_SETUP	0
> +#define SL_TEST		1
> +static char hfile[NR_SLOTS][MAXPATHLEN];
> +static int map_fd[NR_SLOTS];
> +static char *map_addr[NR_SLOTS];
> +static unsigned long map_size[NR_SLOTS];
> +static unsigned int touched[NR_SLOTS];
> +
> +/* Keep track of expected counter values */
> +static long prev_total;
> +static long prev_free;
> +static long prev_resv;
> +static long prev_surp;
> +
> +#define min(a, b) (((a) < (b)) ? (a) : (b))
> +#define max(a, b) (((a) > (b)) ? (a) : (b))

We already have MIN() and MAX() defined in LTP, use them, do not
reinvent the wheel.

> +static void read_meminfo_huge(long *total, long *free, long *resv, long *surp)
> +{
> +	*total = SAFE_READ_MEMINFO("HugePages_Total:");
> +	*free = SAFE_READ_MEMINFO("HugePages_Free:");
> +	*resv = SAFE_READ_MEMINFO("HugePages_Rsvd:");
> +	*surp = SAFE_READ_MEMINFO("HugePages_Surp:");
> +}
> +
> +static int kernel_has_private_reservations(void)
> +{
> +	int fd;
> +	long t, f, r, s;
> +	long nt, nf, nr, ns;
> +	void *map;
> +
> +	/* Read pool counters */

Here again, useless comment.

> +	read_meminfo_huge(&t, &f, &r, &s);
> +
> +	fd = SAFE_OPEN(hfile[0], O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile[0]);
> +	map = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +
> +	/* Recheck the counters */

And here too.

> +	read_meminfo_huge(&nt, &nf, &nr, &ns);
> +
> +	SAFE_MUNMAP(map, hpage_size);
> +	SAFE_CLOSE(fd);
> +
> +	/*
> +	 * There are only three valid cases:
> +	 * 1) If a surplus page was allocated to create a reservation, all
> +	 *    four pool counters increment
> +	 * 2) All counters remain the same except for Hugepages_Rsvd, then
> +	 *    a reservation was created using an existing pool page.
> +	 * 3) All counters remain the same, indicates that no reservation has
> +	 *    been created
> +	 */
> +	if ((nt == t + 1) && (nf == f + 1) && (ns == s + 1) && (nr == r + 1)) {
> +		return 1;
> +	} else if ((nt == t) && (nf == f) && (ns == s)) {
> +		if (nr == r + 1)
> +			return 1;
> +		else if (nr == r)
> +			return 0;
> +	} else {
> +		tst_brk(TCONF, "%s: bad counter state - "
> +		      "T:%li F:%li R:%li S:%li -> T:%li F:%li R:%li S:%li\n",
> +			__func__, t, f, r, s, nt, nf, nr, ns);

There is absolutely no reason to print __func__ all the tst_* reporting
function print filename and linenumber already.

> +	}
> +	return -1;
> +}
> +
> +static void bad_value(int line, const char *name, long expect, long actual)
> +{
> +	tst_res(TFAIL, "Failure Line %i: Bad %s: expected %li, actual %li",
> +			line, name, expect, actual);
> +	tst_brk(TBROK, "Breaking.. as once one of counter is not expected, "
> +			"it will cause other failure anyway");
> +}

Never ever create wrappers around result reporting functions like this.
This break the best feature these function have, i.e. they print file
and line number where the problem has happenend.

> +static void verify_counters(int line, long et, long ef, long er, long es)
> +{
> +	long t, f, r, s;
> +
> +	/* Read pool counters */
> +	read_meminfo_huge(&t, &f, &r, &s);
> +
> +	if (f < r)
> +		tst_res(TWARN, "HugePages_Free < HugePages_Rsvd");

Why exactly do we warn here?

> +	/* Check actual values against expected values */
> +	if (t != et)
> +		bad_value(line, "HugePages_Total", et, t);
> +
> +	if (f != ef)
> +		bad_value(line, "HugePages_Free", ef, f);
> +
> +	if (r != er)
> +		bad_value(line, "HugePages_Rsvd", er, r);
> +
> +	if (s != es)
> +		bad_value(line, "HugePages_Surp", es, s);

We do have rather nice macros exactly for this TST_EXP_EQ_LI() that
would work nicely as long as you name the variables with something more
reasonable than a single character.


> +	/* Everything's good.  Update counters */
> +	prev_total = t;
> +	prev_free = f;
> +	prev_resv = r;
> +	prev_surp = s;
> +}
> +
> +/* Memory operations:
> + * Each of these has a predefined effect on the counters
> + */
> +#define persistent_huge_pages (et - es)

Just NO. Argument-less macros that use local variables like this are
nightmare.

> +static void _set_nr_hugepages(long count, int line)

Identifiers starting with underscore are reserved in C, don't use them.

> +{
> +	long min_size;
> +	long et, ef, er, es;
> +
> +	SAFE_FILE_PRINTF(PROC_NR_HUGEPAGES, "%lu", count);
> +
> +	/* The code below is based on set_max_huge_pages in mm/hugetlb.c */
> +	es = prev_surp;
> +	et = prev_total;
> +	ef = prev_free;
> +	er = prev_resv;
> +
> +	/*
> +	 * Increase the pool size
> +	 * First take pages out of surplus state.  Then make up the
> +	 * remaining difference by allocating fresh huge pages.
> +	 */
> +	while (es && count > persistent_huge_pages)
> +		es--;
> +	while (count > persistent_huge_pages) {
> +		et++;
> +		ef++;
> +	}
> +	if (count >= persistent_huge_pages)
> +		goto out;
> +
> +	/*
> +	 * Decrease the pool size
> +	 * First return free pages to the buddy allocator (being careful
> +	 * to keep enough around to satisfy reservations).  Then place
> +	 * pages into surplus state as needed so the pool will shrink
> +	 * to the desired size as pages become free.
> +	 */
> +	min_size = MAX(count, er + et - ef);
> +	while (min_size < persistent_huge_pages) {
> +		ef--;
> +		et--;
> +	}
> +	while (count < persistent_huge_pages)
> +		es++;
> +
> +out:
> +	verify_counters(line, et, ef, er, es);
> +}
> +#define set_nr_hugepages(c) _set_nr_hugepages(c, __LINE__)
> +
> +static void _map(int s, int hpages, int flags, int line)

Here ase well.

> +{
> +	long et, ef, er, es;
> +
> +	map_fd[s] = SAFE_OPEN(hfile[s], O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile[s]);
> +	map_size[s] = hpages * hpage_size;
> +	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
> +				map_fd[s], 0);
> +	touched[s] = 0;
> +
> +	et = prev_total;
> +	ef = prev_free;
> +	er = prev_resv;
> +	es = prev_surp;
> +
> +	/*
> +	 * When using MAP_SHARED, a reservation will be created to guarantee
> +	 * pages to the process.  If not enough pages are available to
> +	 * satisfy the reservation, surplus pages are added to the pool.
> +	 * NOTE: This code assumes that the whole mapping needs to be
> +	 * reserved and hence, will not work with partial reservations.
> +	 *
> +	 * If the kernel supports private reservations, then MAP_PRIVATE
> +	 * mappings behave like MAP_SHARED at mmap time.  Otherwise,
> +	 * no counter updates will occur.
> +	 */
> +	if ((flags & MAP_SHARED) || private_resv) {
> +		unsigned long shortfall = 0;
> +
> +		if (hpages + prev_resv > prev_free)
> +			shortfall = hpages - prev_free + prev_resv;
> +		et += shortfall;
> +		ef = prev_free + shortfall;
> +		er = prev_resv + hpages;
> +		es = prev_surp + shortfall;
> +	}
> +
> +	verify_counters(line, et, ef, er, es);
> +}
> +#define map(s, h, f) _map(s, h, f, __LINE__)
> +
> +static void _unmap(int s, int hpages, int flags, int line)

And here.

> +{
> +	long et, ef, er, es;
> +	unsigned long i;
> +
> +	SAFE_MUNMAP(map_addr[s], map_size[s]);
> +	SAFE_CLOSE(map_fd[s]);
> +	map_addr[s] = NULL;
> +	map_size[s] = 0;
> +
> +	et = prev_total;
> +	ef = prev_free;
> +	er = prev_resv;
> +	es = prev_surp;
> +
> +	/*
> +	 * When a VMA is unmapped, the instantiated (touched) pages are
> +	 * freed.  If the pool is in a surplus state, pages are freed to the
> +	 * buddy allocator, otherwise they go back into the hugetlb pool.
> +	 * NOTE: This code assumes touched pages have only one user.
> +	 */
> +	for (i = 0; i < touched[s]; i++) {
> +		if (es) {
> +			et--;
> +			es--;
> +		} else
> +			ef++;
> +	}
> +
> +	/*
> +	 * mmap may have created some surplus pages to accommodate a
> +	 * reservation.  If those pages were not touched, then they will
> +	 * not have been freed by the code above.  Free them here.
> +	 */
> +	if ((flags & MAP_SHARED) || private_resv) {
> +		int unused_surplus = MIN(hpages - touched[s], es);
> +
> +		et -= unused_surplus;
> +		ef -= unused_surplus;
> +		er -= hpages - touched[s];
> +		es -= unused_surplus;
> +	}
> +
> +	verify_counters(line, et, ef, er, es);
> +}
> +#define unmap(s, h, f) _unmap(s, h, f, __LINE__)
> +
> +static void _touch(int s, int hpages, int flags, int line)

And here.

> +{
> +	long et, ef, er, es;
> +	int nr;
> +	char *c;
> +
> +	for (c = map_addr[s], nr = hpages;
> +			hpages && c < map_addr[s] + map_size[s];
> +			c += hpage_size, nr--)
> +		*c = (char) (nr % 2);
> +	/*
> +	 * Keep track of how many pages were touched since we can't easily
> +	 * detect that from user space.
> +	 * NOTE: Calling this function more than once for a mmap may yield
> +	 * results you don't expect.  Be careful :)
> +	 */
> +	touched[s] = MAX(touched[s], hpages);
> +
> +	/*
> +	 * Shared (and private when supported) mappings and consume resv pages
> +	 * that were previously allocated. Also deduct them from the free count.
> +	 *
> +	 * Unreserved private mappings may need to allocate surplus pages to
> +	 * satisfy the fault.  The surplus pages become part of the pool
> +	 * which could elevate total, free, and surplus counts.  resv is
> +	 * unchanged but free must be decreased.
> +	 */
> +	if (flags & MAP_SHARED || private_resv) {
> +		et = prev_total;
> +		ef = prev_free - hpages;
> +		er = prev_resv - hpages;
> +		es = prev_surp;
> +	} else {
> +		if (hpages + prev_resv > prev_free)
> +			et = prev_total + (hpages - prev_free + prev_resv);
> +		else
> +			et = prev_total;
> +		er = prev_resv;
> +		es = prev_surp + et - prev_total;
> +		ef = prev_free - hpages + et - prev_total;
> +	}
> +	verify_counters(line, et, ef, er, es);
> +}
> +#define touch(s, h, f) _touch(s, h, f, __LINE__)
> +
> +static void test_counters(char *desc, int base_nr)
> +{
> +	if (verbose)
> +		tst_res(TINFO, "%s...", desc);
> +	set_nr_hugepages(base_nr);
> +
> +	/* untouched, shared mmap */
> +	map(SL_TEST, 1, MAP_SHARED);
> +	unmap(SL_TEST, 1, MAP_SHARED);
> +
> +	/* untouched, private mmap */
> +	map(SL_TEST, 1, MAP_PRIVATE);
> +	unmap(SL_TEST, 1, MAP_PRIVATE);
> +
> +	/* touched, shared mmap */
> +	map(SL_TEST, 1, MAP_SHARED);
> +	touch(SL_TEST, 1, MAP_SHARED);
> +	unmap(SL_TEST, 1, MAP_SHARED);
> +
> +	/* touched, private mmap */
> +	map(SL_TEST, 1, MAP_PRIVATE);
> +	touch(SL_TEST, 1, MAP_PRIVATE);
> +	unmap(SL_TEST, 1, MAP_PRIVATE);
> +
> +	/* Explicit resizing during outstanding surplus */
> +	/* Consume surplus when growing pool */
> +	map(SL_TEST, 2, MAP_SHARED);
> +	set_nr_hugepages(max(base_nr, 1));
> +
> +	/* Add pages once surplus is consumed */
> +	set_nr_hugepages(max(base_nr, 3));
> +
> +	/* Release free huge pages first */
> +	set_nr_hugepages(max(base_nr, 2));
> +
> +	/* When shrinking beyond committed level, increase surplus */
> +	set_nr_hugepages(base_nr);
> +
> +	/* Upon releasing the reservation, reduce surplus counts */
> +	unmap(SL_TEST, 2, MAP_SHARED);
> +	if (verbose)
> +		tst_res(TINFO, "OK");
> +}
> +
> +static void per_iteration_cleanup(void)
> +{
> +	for (int nr = 0; nr < NR_SLOTS; nr++) {
> +		if (map_fd[nr] >= 0)
> +			SAFE_CLOSE(map_fd[nr]);
> +	}
> +	if (hpage_size <= 0)
> +		return;
> +	if (saved_nr_hugepages >= 0)
> +		SAFE_FILE_PRINTF(PROC_NR_HUGEPAGES, "%ld", saved_nr_hugepages);
> +	if (saved_oc_hugepages >= 0)
> +		SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%ld", saved_oc_hugepages);
> +}
> +
> +static void run_test(void)
> +{
> +	int base_nr = 0;
> +
> +	saved_nr_hugepages = SAFE_READ_MEMINFO("HugePages_Total:");
> +
> +	/* Verify Dynamic Pool support */
> +	SAFE_FILE_LINES_SCANF(PROC_OVERCOMMIT, "%ld", &saved_oc_hugepages);
> +	if (saved_oc_hugepages < 0)
> +		tst_brk(TCONF, "Kernel appears to lack dynamic hugetlb pool support");

Again, this cannot happen at all.

> +	SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 3);
> +
> +	private_resv = kernel_has_private_reservations();
> +	/*
> +	 * This test case should require a maximum of 3 huge pages.
> +	 * Run through the battery of tests multiple times, with an increasing
> +	 * base pool size.  This alters the circumstances under which surplus
> +	 * pages need to be allocated and increases the corner cases tested.
> +	 */

Any verbose description like this should rather be part of the
documentaiton comment.

> +	for (base_nr = 0; base_nr <= 3; base_nr++) {
> +		if (verbose)
> +			tst_res(TINFO, "Base pool size: %i", base_nr);

Again not very keen on the verbose flag.

> +		/* Run the tests with a clean slate */
> +		test_counters("Clean", base_nr);
> +
> +		/* Now with a pre-existing untouched, shared mmap */
> +		map(SL_SETUP, 1, MAP_SHARED);
> +		test_counters("Untouched, shared", base_nr);
> +		unmap(SL_SETUP, 1, MAP_SHARED);
> +
> +		/* Now with a pre-existing untouched, private mmap */
> +		map(SL_SETUP, 1, MAP_PRIVATE);
> +		test_counters("Untouched, private", base_nr);
> +		unmap(SL_SETUP, 1, MAP_PRIVATE);
> +
> +		/* Now with a pre-existing touched, shared mmap */
> +		map(SL_SETUP, 1, MAP_SHARED);
> +		touch(SL_SETUP, 1, MAP_SHARED);
> +		test_counters("Touched, shared", base_nr);
> +		unmap(SL_SETUP, 1, MAP_SHARED);
> +
> +		/* Now with a pre-existing touched, private mmap */
> +		map(SL_SETUP, 1, MAP_PRIVATE);
> +		touch(SL_SETUP, 1, MAP_PRIVATE);
> +		test_counters("Touched, private", base_nr);
> +		unmap(SL_SETUP, 1, MAP_PRIVATE);
> +	}
> +	tst_res(TPASS, "Hugepages Counters works as expected.");
> +	per_iteration_cleanup();
> +}
> +
> +static void setup(void)
> +{
> +	if (!Hopt)
> +		Hopt = tst_get_tmpdir();
> +	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +	for (int nr = 0; nr < NR_SLOTS; nr++) {
> +		snprintf(hfile[nr], sizeof(hfile[nr]), "%s/ltp_hugetlbfile%d_%d",
> +				Hopt, getpid(), nr);
> +	}
> +
> +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +}
> +
> +static void cleanup(void)
> +{
> +	per_iteration_cleanup();
> +	umount2(Hopt, MNT_DETACH);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
> +		{"v", &verbose, "Turns on verbose mode"},
> +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
> +		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
> +		{}
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {0, TST_REQUEST},
> +};
> +
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
