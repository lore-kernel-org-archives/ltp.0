Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E402BC433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 13:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDC883C87C9
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 15:06:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DC773C7C07
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 15:06:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 076F46002BF
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 15:06:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3893021C6D;
 Fri,  3 Jun 2022 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654261572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RgrFDojGM7Lo0EmeHbFdjIAk3rh04oz5vBe2iD7WYro=;
 b=rL2PHWgAlk5AgSYcjzsxzMlS73X61UKgt31UNwoQjvuLaweUTRrxkvj0TnbfoESLQXJuTh
 F7qgEbfpn0K7a9H3824+Kif9LZ9S4z3gPOs/q7wVVMjjDz+SQHOGom8WQOQAV1qBDIa0k6
 rc+sNLO+W5WP9PZBQcw85j7sf3iIhbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654261572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RgrFDojGM7Lo0EmeHbFdjIAk3rh04oz5vBe2iD7WYro=;
 b=r8BR3LzYFb3o2CNrK4dpMiJIT67F/JLJXDYH/tI4Eu0xDmbnDLK6o4gOG06QXdwRiA+Ieq
 H8kZWAod2qoMBbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A00213638;
 Fri,  3 Jun 2022 13:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uuxfBEQHmmLibgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 03 Jun 2022 13:06:12 +0000
Date: Fri, 3 Jun 2022 15:08:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YpoHxLJLlPgfP2Dx@yuki>
References: <20220602081411.33598-1-liwang@redhat.com>
 <20220602081411.33598-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220602081411.33598-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: extend .request_hugepages to
 guarantee enough hpages
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
> This is to satisfy tests which need to reserve hugepage precisely for
> using, with eliminating other process side effects at the same time.
> 
> For example, if there are 'N' (N > 1) hpages reserved but all occupying.
> New '.request_hugepage = 1' in another test will only save the N and do
> echo 1 into hugetlbfs. That obviously may cause problems during test run.
> 
> Here, we introduce two policies to make hugepage reserve work fit for
> more requirements but no need to care about details. And simply rename
> .request_hugepages to .hugepages.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  doc/c-test-api.txt                    | 34 +++++++++++++++++----------
>  include/tst_hugepage.h                | 14 +++++++++--
>  include/tst_test.h                    | 26 +++++++++++++-------
>  lib/newlib_tests/test20.c             | 14 ++++++-----
>  lib/newlib_tests/test_zero_hugepage.c |  9 +++----
>  lib/tst_hugepage.c                    | 22 +++++++++++++----
>  lib/tst_test.c                        |  4 ++--
>  7 files changed, 85 insertions(+), 38 deletions(-)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 711b445d9..16409b97e 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1998,15 +1998,24 @@ For full documentation see the comments in 'include/tst_fuzzy_sync.h'.
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Many of the LTP tests need to use hugepage in their testing, this allows the
> -test can reserve hugepages from system only via '.request_hugepages = xx'.
> +test can reserve hugepages from system via '.hugepages = {xx, TST_REQUEST}'.
>  
> -If set non-zero number of 'request_hugepages', test will try to reserve the
> -expected number of hugepage for testing in setup phase. If system does not
> -have enough hpage for using, it will try the best to reserve 80% available
> -number of hpages. With success test stores the reserved hugepage number in
> -'tst_hugepages'. For the system without hugetlb supporting, variable
> -'tst_hugepages' will be set to 0. If the hugepage number needs to be set to 0
> -on supported hugetlb system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
> +We achieved two policies for hugepage reserving:
                                  ^
				  reserving hugepages:
> +
> +TST_REQUEST:
> +  If set non-zero number in .hugepages, ltp will try to reserve the expected
> +  number of hugepage for testing in setup phase. If system doesn't have enough
> +  memory for that, it will try the best to reserve 80% available huge pages.

Maybe just "it will try the best to reserver available huge pages and
return the number of available hugepages in .hugepages.number, which may
be 0 if hugepages are not supported at all."

> +TST_NEEDS:
> +  This is an enforced requirement for hugepage reserve, LTP should strictly do
> +  hpages applying and guarantee the 'HugePages_Free' no less than pages which
> +  gives that test can use these specified numbers correctly.

We should stress here that test exits with TCONF if the attempt to
reserver hugepages fails or reserves less than requested.

> +With success test stores the reserved hugepage number in 'tst_hugepages'. For
> +system without hugetlb supporting, variable 'tst_hugepages' will be set to 0.
> +If the hugepage number needs to be set to 0 on supported hugetlb system, please
> +use '.hugepages = {TST_NO_HUGEPAGES, TST_REQUEST}'.

I guess that we don't even set the second value here, we can as well
simplify to: .hugepages = {TST_NO_HUGEPAGES}

>  Also, we do cleanup and restore work for the hpages resetting automatically.
>  
> @@ -2018,7 +2027,7 @@ static void run(void)
>  {
>  	...
>  
> -	if (tst_hugepages == test.request_hugepages)
> +	if (tst_hugepages == test.hugepages.number)
>  		TEST(do_hpage_test);
>  	else
>  		...
> @@ -2027,7 +2036,7 @@ static void run(void)
>  
>  struct tst_test test = {
>  	.test_all = run,
> -	.request_hugepages = 2,
> +	.hugepages = {2, TST_REQUEST},
>  	...
>  };
>  -------------------------------------------------------------------------------
> @@ -2045,13 +2054,14 @@ static void run(void)
>  
>  static void setup(void)
>  {
> -?? ?? ?? ?? if (tst_hugepages != test.requested_hugepages)
> +	/* TST_NEEDS achieved this automatically in the library */
> +?? ?? ?? ?? if (tst_hugepages != test.hugepages.number)
>  ?? ?? ?? ?? ?? ?? ?? ?? tst_brk(TCONF, "...");
   ^
   Non ascii whitespaces?

>  }
>  
>  struct tst_test test = {
>  	.test_all = run,
> -	.request_hugepages = 2,
> +	.hugepages = {2, TST_NEEDS},
>  	...
>  };
>  -------------------------------------------------------------------------------
> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> index e08a2daa2..7fba02c40 100644
> --- a/include/tst_hugepage.h
> +++ b/include/tst_hugepage.h
> @@ -12,6 +12,16 @@
>  extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
>  extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
>  
> +enum tst_hp_policy {
> +	TST_REQUEST,
> +	TST_NEEDS,
> +};
> +
> +struct tst_hugepage {
> +	const unsigned long number;
> +	enum  tst_hp_policy policy;
> +};
> +
>  /*
>   * Get the default hugepage size. Returns 0 if hugepages are not supported.
>   */
> @@ -23,11 +33,11 @@ size_t tst_get_hugepage_size(void);
>   *
>   * Note: this depend on the status of system memory fragmentation.
>   */
> -unsigned long tst_request_hugepages(unsigned long hpages);
> +unsigned long tst_reserve_hugepages(struct tst_hugepage *hp);
>  
>  /*
>   * This variable is used for recording the number of hugepages which system can
> - * provides. It will be equal to 'hpages' if tst_request_hugepages on success,
> + * provides. It will be equal to 'hpages' if tst_reserve_hugepages on success,
>   * otherwise set it to a number of hugepages that we were able to reserve.
>   *
>   * If system does not support hugetlb, then it will be set to 0.
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 60316092d..9aef43581 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -191,17 +191,27 @@ struct tst_test {
>  	unsigned long min_mem_avail;
>  
>  	/*
> -	 * If set non-zero number of request_hugepages, test will try to reserve the
> -	 * expected number of hugepage for testing in setup phase. If system does not
> -	 * have enough hpage for using, it will try the best to reserve 80% available
> -	 * number of hpages. With success test stores the reserved hugepage number in
> -	 * 'tst_hugepages. For the system without hugetlb supporting, variable
> -	 * 'tst_hugepages' will be set to 0. If the hugepage number needs to be set to
> -	 * 0 on supported hugetlb system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
> +	 * Two policies for hugepage reserving:
> +	 *
> +	 * TST_REQUEST:
> +	 *   If set non-zero number in .hugepages, ltp will try to reserve the expected
> +	 *   number of hugepage for testing in setup phase. If system does not have enough
> +	 *   memory for that, it will try the best to reserve 80% available huge pages.
> +	 *
> +	 * TST_NEEDS:
> +	 *   This is an enforced requirement for huge page reserve, ltp should strictly do
> +	 *   hpages applying and guarantee the 'HugePages_Free' no less than specified pages
> +	 *   which gives that test can use these specified numbers correctly.
> +	 *
> +	 *
> +	 * With success test stores the reserved hugepage number in 'tst_hugepages. For
> +	 * the system without hugetlb supporting, variable 'tst_hugepages' will be set to 0.
> +	 * If the hugepage number needs to be set to 0 on supported hugetlb system, please
> +	 * use '.hugepages = {TST_NO_HUGEPAGES, TST_REQUEST}'.

Here as well (update the docs).

>  	 * Also, we do cleanup and restore work for the hpages resetting automatically.
>  	 */
> -	unsigned long request_hugepages;
> +	struct tst_hugepage hugepages;
>  
>  	/*
>  	 * If set to non-zero, call tst_taint_init(taint_check) during setup
> diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
> index 5c24770a1..3982ab79f 100644
> --- a/lib/newlib_tests/test20.c
> +++ b/lib/newlib_tests/test20.c
> @@ -4,7 +4,7 @@
>   */
>  
>  /*
> - * Tests .request_hugepages + .save_restore
> + * Tests .hugepages + .save_restore
>   */
>  
>  #include "tst_test.h"
> @@ -18,24 +18,26 @@ static void do_test(void) {
>  	tst_res(TINFO, "tst_hugepages = %lu", tst_hugepages);
>  	SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "1");
>  
> -	hpages = test.request_hugepages;
> +	hpages = test.hugepages.number;
>  	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
>  	if (val != hpages)
>  		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
>  	else
> -		tst_res(TPASS, "test .needs_hugepges");
> +		tst_res(TPASS, "test .hugepges");
> +
> +	struct tst_hugepage hp = { 1000000000000, TST_REQUEST };
> +	hpages = tst_reserve_hugepages(&hp);
>  
> -	hpages = tst_request_hugepages(3);
>  	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
>  	if (val != hpages)
>  		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
>  	else
> -		tst_res(TPASS, "tst_request_hugepages");
> +		tst_res(TPASS, "tst_reserve_hugepages");
>  }
>  
>  static struct tst_test test = {
>  	.test_all = do_test,
> -	.request_hugepages = 2,
> +	.hugepages = {2, TST_NEEDS},
>  	.save_restore = (const struct tst_path_val[]) {
>  		{"!/proc/sys/kernel/numa_balancing", "0"},
>  		{}
> diff --git a/lib/newlib_tests/test_zero_hugepage.c b/lib/newlib_tests/test_zero_hugepage.c
> index 0d85ce866..ca47ed5a7 100644
> --- a/lib/newlib_tests/test_zero_hugepage.c
> +++ b/lib/newlib_tests/test_zero_hugepage.c
> @@ -19,17 +19,18 @@ static void do_test(void)
>  	if (val != 0)
>  		tst_brk(TBROK, "nr_hugepages = %lu, but expect 0", val);
>  	else
> -		tst_res(TPASS, "test .request_hugepages = TST_NO_HUGEPAGES");
> +		tst_res(TPASS, "test .hugepages = {TST_NO_HUGEPAGES, TST_REQUEST}");
>  
> -	hpages = tst_request_hugepages(3);
> +	struct tst_hugepage hp = { 3, TST_REQUEST };
> +	hpages = tst_reserve_hugepages(&hp);
>  	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
>  	if (val != hpages)
>  		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
>  	else
> -		tst_res(TPASS, "tst_request_hugepages");
> +		tst_res(TPASS, "tst_reserve_hugepages");
>  }
>  
>  static struct tst_test test = {
>  	.test_all = do_test,
> -	.request_hugepages = TST_NO_HUGEPAGES,
> +	.hugepages = {TST_NO_HUGEPAGES, TST_REQUEST},
>  };
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> index a7585bc3d..e97cc560e 100644
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -20,11 +20,13 @@ size_t tst_get_hugepage_size(void)
>  	return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>  }
>  
> -unsigned long tst_request_hugepages(unsigned long hpages)
> +unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>  {
>  	unsigned long val, max_hpages;
>  
>  	if (access(PATH_HUGEPAGES, F_OK)) {
> +		if (hp->policy == TST_NEEDS)
> +			tst_brk(TCONF, "hugetlbfs is not supported");
>  		tst_hugepages = 0;
>  		goto out;
>  	}
> @@ -32,16 +34,20 @@ unsigned long tst_request_hugepages(unsigned long hpages)
>  	if (nr_opt)
>  		tst_hugepages = SAFE_STRTOL(nr_opt, 1, LONG_MAX);
>  	else
> -		tst_hugepages = hpages;
> +		tst_hugepages = hp->number;
>  
> -	if (hpages == TST_NO_HUGEPAGES) {
> +	if (hp->number == TST_NO_HUGEPAGES) {
>  		tst_hugepages = 0;
>  		goto set_hugepages;
>  	}
>  
>  	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
> -	max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
> +	if (hp->policy == TST_NEEDS) {
> +		tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
> +		goto set_hugepages;
> +	}
>  
> +	max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
>  	if (tst_hugepages > max_hpages) {
>  		tst_res(TINFO, "Requested number(%lu) of hugepages is too large, "
>  				"limiting to 80%% of the max hugepage count %lu",
> @@ -61,6 +67,14 @@ set_hugepages:
>  				"Not enough hugepages for testing.",
>  				val, tst_hugepages);
>  
> +	if (hp->policy == TST_NEEDS) {
> +		unsigned long free_hpages = SAFE_READ_MEMINFO("HugePages_Free:");
> +		if (hp->number > free_hpages)
> +			tst_brk(TCONF, "free_hpages = %lu, but expect %lu. "
> +				"Not enough hugepages for testing.",
> +				free_hpages, hp->number);
> +	}
> +

Minus the minor comments the code looks good, with the small issues fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
