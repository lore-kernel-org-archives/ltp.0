Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B26BC4332F
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 13:11:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB62B3CD745
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 14:11:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A1DC3CD725
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 14:11:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 30B4A600A60
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 14:11:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 489C61F9DF;
 Wed,  9 Nov 2022 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667999488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bbUErfdpYwN/luO5iat86yrSg0QadurE6nEOZ0RETM=;
 b=F9h71+dJOeHkpze8TdXMNX3fp86N2+X1IomdXto7y4stlvQb9iizDEW2ZRNlb2NZP+K9xd
 iAXtkpxlUTYDxIp3qI9OzjP01N0yk3GcXNz3MU2zRFctXR3rpMKt4fv5EnvpSGaHb6LefZ
 5zbUvRANFyig4v04rra4+DBYQ+bLG+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667999488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bbUErfdpYwN/luO5iat86yrSg0QadurE6nEOZ0RETM=;
 b=3FfnSgcw8H1ogJJiKKa3nE6Ave3LzL6qnnfMqrJTyv1FsG8hZWstoSHv4VqbovOluTMXwv
 qNoi8KuvjqtaOoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30ADA1331F;
 Wed,  9 Nov 2022 13:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VJqeCgCna2PeegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Nov 2022 13:11:28 +0000
Date: Wed, 9 Nov 2022 14:12:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2unWTTyFK8DS82w@yuki>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-2-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221108195207.232115-2-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Hugetlb: Migrating libhugetlbfs counters
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 438 ++++++++++++++++++
>  3 files changed, 440 insertions(+)
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
> index 000000000..dacfee8ce
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2007 IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Counters:
      ^
Again this wouldn't render nicely in asciidoc.

> + * This Test perform mmap and unmap and write operation on hugetlb file
> + * based mapping. Mapping can be shared or private. and it checks for
> + * Hugetlb counter (Total, Free, Reserve, Surplus) in /proc/meminfo and
> + * compare them with expected (calculated) value. if all checks are
> + * successful, the test passes.
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
> +#include <setjmp.h>
> +
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +
> +static long hpage_size;
> +static int private_resv;
> +
> +#define NR_SLOTS	2
> +#define SL_SETUP	0
> +#define SL_TEST		1
> +static int map_fd[NR_SLOTS];
> +static char *map_addr[NR_SLOTS];
> +static unsigned long map_size[NR_SLOTS];
> +static unsigned int touched[NR_SLOTS];
> +
> +static long prev_total;
> +static long prev_free;
> +static long prev_resv;
> +static long prev_surp;
> +static jmp_buf buf;
> +
> +static void read_meminfo_huge(long *total, long *free, long *resv, long *surp)
> +{
> +	*total = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
> +	*free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	*resv = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	*surp = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
> +}
> +
> +static int kernel_has_private_reservations(void)
> +{
> +	int fd;
> +	long t, f, r, s;
> +	long nt, nf, nr, ns;
> +	void *map;
> +
> +	read_meminfo_huge(&t, &f, &r, &s);
> +	fd = tst_creat_unlinked(MNTPOINT);
> +
> +	map = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +
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
> +	if ((nt == t + 1) && (nf == f + 1) && (ns == s + 1) && (nr == r + 1))
> +		return 1;
> +	else if ((nt == t) && (nf == f) && (ns == s)) {
> +		if (nr == r + 1)
> +			return 1;
> +		else if (nr == r)
> +			return 0;
> +	} else
> +		tst_brk(TCONF, "bad counter state - "
> +		      "T:%li F:%li R:%li S:%li -> T:%li F:%li R:%li S:%li\n",
                                                                          ^
									  Do
									  not
									  print
									  newline
> +			  t, f, r, s, nt, nf, nr, ns);

This is confusing for no good reason. We are doing return in the if ()
blcoks, so there is no reason to use else at all. This would be much
more readable as:


	if (...)
		reutrn 1;


	if (...) {
		if (...)
			reutrn 1;
		else
			return 0;
	}

	tst_brk(TCONF, "...");


> +	return -1;
> +}
> +
> +static void verify_counters(int line, long et, long ef, long er, long es)
> +{
> +	long t, f, r, s;
> +	long c, ec;
> +	char *huge_info_name;
> +
> +	read_meminfo_huge(&t, &f, &r, &s);
> +
> +	if (t != et) {
> +		c = t;
> +		ec = et;
> +		huge_info_name = MEMINFO_HPAGE_TOTAL;
> +	} else if (f != ef) {
> +		c = f;
> +		ec = ef;
> +		huge_info_name = MEMINFO_HPAGE_FREE;
> +	} else if (r != er) {
> +		c = r;
> +		ec = er;
> +		huge_info_name = MEMINFO_HPAGE_RSVD;
> +	} else if (s != es) {
> +		c = s;
> +		ec = es;
> +		huge_info_name = MEMINFO_HPAGE_SURP;
> +	} else {

I think that it would be better to actually print TFAIL for each of the
values not just the first that is different.

Something as:

	int fail = 0;

	if (t != et) {
		tst_res(TFAIL, ...);
		fail++;
	}

	if (f != ef) {
		...
	}

	...


	if (fail)
		return 1;

	...

> +		prev_total = t;
> +		prev_free = f;
> +		prev_resv = r;
> +		prev_surp = s;
> +		return;
> +	}
> +
> +	tst_res(TFAIL, "Failure Line %i: Bad %s expected %li, actual %li",
                        ^
			Never print "Fail/Pass" with tst_res() it's
			printed based on the flag passed to it.

The output would contain Fail and Failed at the same time.

> +			line, huge_info_name, ec, c);
> +	longjmp(buf, 1);
> +}
> +
> +/* Memory operations:
> + * Each of these has a predefined effect on the counters
> + */
> +static void set_nr_hugepages_(long count, int line)
> +{
> +	long min_size;
> +	long et, ef, er, es;
> +
> +	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", count);
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
> +	while (es && count > et - es)
> +		es--;
> +	while (count > et - es) {
> +		et++;
> +		ef++;
> +	}
> +	if (count >= et - es)
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
> +	while (min_size < et - es) {
> +		ef--;
> +		et--;
> +	}
> +	while (count < et - es)
> +		es++;
> +
> +out:
> +	verify_counters(line, et, ef, er, es);
> +}
> +#define set_nr_hugepages(c) set_nr_hugepages_(c, __LINE__)

I think that instead of the __LINE__ it would make more sense to pass
the test description as a string as we do with test_counters()

> +static void map_(int s, int hpages, int flags, int line)
> +{
> +	long et, ef, er, es;
> +
> +	map_fd[s] = tst_creat_unlinked(MNTPOINT);
> +	map_size[s] = hpages * hpage_size;
> +	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
> +				map_fd[s], 0);
> +	touched[s] = 0;
> +
> +	et = prev_total;
> +	ef = prev_free;
> +	er = prev_resv;
> +	es = prev_surp;
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
> +		ef += shortfall;
> +		er += hpages;
> +		es += shortfall;
> +	}
> +
> +	verify_counters(line, et, ef, er, es);
> +}
> +#define map(s, h, f) map_(s, h, f, __LINE__)
> +
> +static void unmap_(int s, int hpages, int flags, int line)
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
> +#define unmap(s, h, f) unmap_(s, h, f, __LINE__)
> +
> +static void touch_(int s, int hpages, int flags, int line)
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
> +#define touch(s, h, f) touch_(s, h, f, __LINE__)


> +static void test_counters(char *desc, int base_nr)
> +{
> +	tst_res(TINFO, "%s...", desc);
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
> +	set_nr_hugepages(MAX(base_nr, 1));
> +
> +	/* Add pages once surplus is consumed */
> +	set_nr_hugepages(MAX(base_nr, 3));
> +
> +	/* Release free huge pages first */
> +	set_nr_hugepages(MAX(base_nr, 2));
> +
> +	/* When shrinking beyond committed level, increase surplus */
> +	set_nr_hugepages(base_nr);
> +
> +	/* Upon releasing the reservation, reduce surplus counts */
> +	unmap(SL_TEST, 2, MAP_SHARED);
> +	tst_res(TINFO, "OK");
> +}
> +
> +static void per_iteration_cleanup(void)
> +{
> +	int nr = 0;

This is confusing for no good reason, the nr should better be
initialized in the for loop instead as it's usually done.

> +	prev_total = 0;
> +	prev_free = 0;
> +	prev_resv = 0;
> +	prev_surp = 0;
> +	for (; nr < NR_SLOTS; nr++) {
> +		if (map_fd[nr] > 0)
> +			SAFE_CLOSE(map_fd[nr]);
> +	}
> +}
> +
> +static void run_test(void)
> +{
> +	int base_nr = 0;
> +
> +	SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%lu", tst_hugepages);
> +	private_resv = kernel_has_private_reservations();

This should be done once in the test setup().

> +	if (setjmp(buf))
> +		goto cleanup;

This is way beyond ugly. I guess that it would be cleaner to actually
return a pass/fail from the test_counters() function and break the for()
loop based on that value instead of this longjmp trickery.

Also I do not think that the current code is correct anyway, because we
skip the unmap() call. So I suppose the correct way would be:


	res = test_counters("Untouched, shared", base_nr);
	unmap(SL_SETUP, 1, MAP_SHARED);

	if (res)
		break;

Or eventually we can make the desing better by unmaping any leftover
mappings in the per_iteration_cleanup(). Then we can just do:

	map()
	if (test_coutners(...)
		break;
	unmap()

> +	for (base_nr = 0; base_nr <= 3; base_nr++) {
> +		tst_res(TINFO, "Base pool size: %i", base_nr);
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
> +cleanup:
> +	per_iteration_cleanup();
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +}
> +
> +static void cleanup(void)
> +{
> +	per_iteration_cleanup();
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{PATH_OC_HPAGES, NULL},
> +		{PATH_NR_HPAGES, NULL},
> +		{}
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {3, TST_NEEDS},
> +};
> +
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
