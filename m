Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE31C4332F
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 15:36:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5947C3C81C9
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 16:36:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECC053C688D
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 16:36:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5FFA60048B
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 16:36:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB73E1F952;
 Wed, 16 Nov 2022 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668612978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0RRGvcxhqvkmM/SfPVC1BiVpkkjbH3kR2Hv7rSLBkg=;
 b=XdgqI9V+5X3mGl0jhGSyh5fdXA/fG9kpeGsxDzzmhVTylwPnPAS4BvXPZXR2xtrG9Opv55
 rRa1FaBMAzrtZsVI/Bfl1RDKqcrdPHC2NgUE4I+Im1GJoCFU3FTMhvazLvZloQ3Ec8yO3u
 7JB69pTvqzObfo8BHHOgHJ8hac5XzLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668612978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0RRGvcxhqvkmM/SfPVC1BiVpkkjbH3kR2Hv7rSLBkg=;
 b=/MqpL4B9Y6EK8sKqW3fMUr/s9qdLJza9BdtLZCfzhnUN6DkO+qZd3d92yiH5JHJjKktMQt
 FA6wTnYyIPqRtNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFF0B13480;
 Wed, 16 Nov 2022 15:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KQViMnIDdWMwcgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 16 Nov 2022 15:36:18 +0000
Date: Wed, 16 Nov 2022 16:37:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y3UDxqM8qvnqRfeT@yuki>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
 <20221116112516.261535-3-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116112516.261535-3-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/7] Hugetlb: Migrating libhugetlbfs counters
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
> +#define CHECK_(fun)	\
> +		{			\
> +		if (fun)	\
> +			break;	\
> +	}

This is working around the tooling we have I would rather have a look
into the checkpatch script to see if we could tweak the rule rather than
to introduce this messy code.

Just submit the patch with sane code and I will check for what I can do
with the script to get rid of the error.

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
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
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
> +	}
> +	tst_brk(TCONF, "bad counter state - "
> +	      "T:%li F:%li R:%li S:%li -> T:%li F:%li R:%li S:%li",
> +		  t, f, r, s, nt, nf, nr, ns);
> +	return -1;
> +}
> +
> +static int verify_counters(int line, char *desc, long et, long ef, long er, long es)
> +{
> +	long t, f, r, s;
> +	long fail = 0;
> +
> +	read_meminfo_huge(&t, &f, &r, &s);
> +
> +	if (t != et) {
> +		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_TOTAL
> +				" expected %li, actual %li", line, desc, et, t);

We do have tst_res_() that can be called as:

	tst_res_(__FILE__, line,
                 "%s bad " MEMINFO_HPAGE_TOTAL " = %li expected %li",
		 desc, et, t);

> +		fail++;
> +	}
> +	if (f != ef) {
> +		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_FREE
> +				" expected %li, actual %li", line, desc, ef, f);
> +		fail++;
> +	}
> +	if (r != er) {
> +		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_RSVD
> +				" expected %li, actual %li", line, desc, er, r);
> +		fail++;
> +	}
> +	if (s != es) {
> +		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_SURP
> +				" expected %li, actual %li", line, desc, es, s);
> +		fail++;
> +	}
> +
> +	if (fail)
> +		return -1;
> +
> +	prev_total = t;
> +	prev_free = f;
> +	prev_resv = r;
> +	prev_surp = s;
> +	return 0;
> +}
> +
> +/* Memory operations:
> + * Each of these has a predefined effect on the counters
> + */
> +static int set_nr_hugepages_(long count, char *desc, int line)
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
> +	return verify_counters(line, desc, et, ef, er, es);
> +}
> +#define set_nr_hugepages(c, d) CHECK_(set_nr_hugepages_(c, d, __LINE__))

The macro name should be uppercase so that it's clear that it's a macro
and not a simple function. With that we can also drop the underscore
from the actual function name too.

> +static int map_(int s, int hpages, int flags, char *desc, int line)
> +{
> +	long et, ef, er, es;
> +
> +	map_fd[s] = tst_creat_unlinked(MNTPOINT, 0);
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
> +	return verify_counters(line, desc, et, ef, er, es);
> +}
> +#define map(s, h, f, d) CHECK_(map_(s, h, f, d, __LINE__))
> +
> +static int unmap_(int s, int hpages, int flags, char *desc, int line)
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
> +	return verify_counters(line, desc, et, ef, er, es);
> +}
> +#define unmap(s, h, f, d) CHECK_(unmap_(s, h, f, d, __LINE__))
> +
> +static int touch_(int s, int hpages, int flags, char *desc, int line)
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
> +	return verify_counters(line, desc, et, ef, er, es);
> +}
> +#define touch(s, h, f, d) CHECK_(touch_(s, h, f, d, __LINE__))
> +
> +static int test_counters_(char *desc, int base_nr)
> +{
> +	int fail = 1;
> +
> +	tst_res(TINFO, "%s...", desc);
> +
> +	do {
> +		set_nr_hugepages(base_nr, "initializing hugepages pool");
> +
> +		/* untouched, shared mmap */
> +		map(SL_TEST, 1, MAP_SHARED, "doing mmap shared with no touch");
> +		unmap(SL_TEST, 1, MAP_SHARED, "doing munmap on shared with no touch");
> +
> +		/* untouched, private mmap */
> +		map(SL_TEST, 1, MAP_PRIVATE, "doing mmap private with no touch");
> +		unmap(SL_TEST, 1, MAP_PRIVATE, "doing munmap private with on touch");
> +
> +		/* touched, shared mmap */
> +		map(SL_TEST, 1, MAP_SHARED, "doing mmap shared followed by touch");
> +		touch(SL_TEST, 1, MAP_SHARED, "touching the addr after mmap shared");
> +		unmap(SL_TEST, 1, MAP_SHARED, "doing munmap shared after touch");
> +
> +		/* touched, private mmap */
> +		map(SL_TEST, 1, MAP_PRIVATE, "doing mmap private followed by touch");
> +		touch(SL_TEST, 1, MAP_PRIVATE, "touching the addr after mmap private");
> +		unmap(SL_TEST, 1, MAP_PRIVATE, "doing munmap private after touch");
> +
> +		/* Explicit resizing during outstanding surplus */
> +		/* Consume surplus when growing pool */
> +		map(SL_TEST, 2, MAP_SHARED, "doing mmap to consume surplus");
> +		set_nr_hugepages(MAX(base_nr, 1), "setting hugepages pool to consume surplus");
> +
> +		/* Add pages once surplus is consumed */
> +		set_nr_hugepages(MAX(base_nr, 3), "Adding more pages after consuming surplus");
> +
> +		/* Release free huge pages first */
> +		set_nr_hugepages(MAX(base_nr, 2), "Releasing free huge pages");
> +
> +		/* When shrinking beyond committed level, increase surplus */
> +		set_nr_hugepages(base_nr, "increasing surplus counts");
> +
> +		/* Upon releasing the reservation, reduce surplus counts */
> +		unmap(SL_TEST, 2, MAP_SHARED, "reducing surplus counts");
> +		fail = 0;
> +	} while (0);
> +
> +	if (fail)
> +		return -1;
> +	tst_res(TINFO, "OK");
> +	return 0;

Maybe it would be a bit nicer to have actually two different macros so
that we don't have to resort to this do {} while (0) trickery e.g.

#define CHECK_BREAK(cond) if (cond) break;
#define CHECK_RETURN(cond) if (cond) return -1;

#define MAP_BREAK(s, h, f, d) CHECK_BREAK(map(s, h, f, d, __LINE__))
#define MAP_RETURN(s, h, f, d) CHECK_RETURN(map(s, h, f, d, __LINE__))

Then the check counters would look much better.

Or we can just stick to the RETURN variants and put the body of the loop
in the runtest() function into do_interation() function.

> +}
> +
> +#define test_counters(a, b) CHECK_(test_counters_(a, b))
> +
> +static void per_iteration_cleanup(void)
> +{
> +	int nr;
> +
> +	prev_total = 0;
> +	prev_free = 0;
> +	prev_resv = 0;
> +	prev_surp = 0;
> +	for (nr = 0; nr < NR_SLOTS; nr++) {
> +		if (map_addr[nr])
> +			SAFE_MUNMAP(map_addr[nr], map_size[nr]);
> +		if (map_fd[nr] > 0)
> +			SAFE_CLOSE(map_fd[nr]);
> +	}
> +}
> +
> +static void run_test(void)
> +{
> +	int base_nr;
> +
> +	for (base_nr = 0; base_nr <= 3; base_nr++) {
> +		tst_res(TINFO, "Base pool size: %i", base_nr);
> +		/* Run the tests with a clean slate */
> +		test_counters("Clean", base_nr);
> +
> +		/* Now with a pre-existing untouched, shared mmap */
> +		map(SL_SETUP, 1, MAP_SHARED,
> +				"doing mmap for running pre-existing untouched shared mapping test");
> +		test_counters("Untouched, shared", base_nr);
> +		unmap(SL_SETUP, 1, MAP_SHARED,
> +				"doing munmap after running pre-existing untouched shared mapping test");
> +
> +		/* Now with a pre-existing untouched, private mmap */
> +		map(SL_SETUP, 1, MAP_PRIVATE,
> +				"doing mmap for running pre-existing untouched private mapping test");
> +		test_counters("Untouched, private", base_nr);
> +		unmap(SL_SETUP, 1, MAP_PRIVATE,
> +				"doing munmap after running pre-existing untouced private mapping test");
> +
> +		/* Now with a pre-existing touched, shared mmap */
> +		map(SL_SETUP, 1, MAP_SHARED,
> +				"doing mmap for running pre-existing touched shared mapping test");
> +		touch(SL_SETUP, 1, MAP_SHARED,
> +				"touching for running pre-existing touched shared mapping test");
> +		test_counters("Touched, shared", base_nr);
> +		unmap(SL_SETUP, 1, MAP_SHARED,
> +				"doing munmap after running pre-existing touched shared mapping test");
> +
> +		/* Now with a pre-existing touched, private mmap */
> +		map(SL_SETUP, 1, MAP_PRIVATE,
> +				"doing mmap for running pre-existing touched private mapping test");
> +		touch(SL_SETUP, 1, MAP_PRIVATE,
> +				"touching for running pre-existing touched private mapping test");
> +		test_counters("Touched, private", base_nr);
> +		unmap(SL_SETUP, 1, MAP_PRIVATE,
> +				"doing munmap after running pre-existing touched private mapping test");
> +	}
> +	if (base_nr > 3)
> +		tst_res(TPASS, "Hugepages Counters works as expected.");
> +	per_iteration_cleanup();
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +	SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%lu", tst_hugepages);
> +	private_resv = kernel_has_private_reservations();
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
