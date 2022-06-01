Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0D6C433EF
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 12:06:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4766E3C69EB
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 14:06:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D63663C61D9
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 14:06:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACC861A01163
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 14:06:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B7C1221B6E;
 Wed,  1 Jun 2022 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654085171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZqZnqD21Y7+hfg7u0v+VyoV0iSSTKUqxdUfRDQYHC84=;
 b=ITrRR6T1f99thEhBOWnMbo82Gv2Z8b9FQxMYOK72qM99G/OxNW0BGtzhEG7fml4loIBWv5
 PFZ8+VJQka44Qi9Re6v8Ud6ZUOwcBlfBVfyN3Bb54R7qhZY3GKCqobJ7YgIjMbB2y0U6U/
 ImZrcO02Bu1GGnpJXc5bpY1mim4P1MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654085171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZqZnqD21Y7+hfg7u0v+VyoV0iSSTKUqxdUfRDQYHC84=;
 b=4ut+wQbD+XQTL4iNsobP4QBmQ/0ngkEBIx4ofHhaJVPT8VTP5ARyCWel6w5H4An8keVLRe
 c/2jm2zazZrYmHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A238613A8F;
 Wed,  1 Jun 2022 12:06:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CDoQJjNWl2IARwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 01 Jun 2022 12:06:11 +0000
Date: Wed, 1 Jun 2022 14:08:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YpdWsp9a4ZcpkCAD@yuki>
References: <20220428132949.11719-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428132949.11719-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/3] lib: extend .request_hugepages to
 guarantee enough pages
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
> This is to satisfy some tests which need to reserved hugepage precisely
> for using, with eliminating other process side effects at the same time.
> 
> For example, if there are 'N' (N > 1) hpages reserved but all occupying.
> New '.request_hugepage = 1' in another test will only save the N and do
> echo 1 into hugetlbfs. That obviously may cause problems during test run.
> 
> Here, we introduce two policies to make hugepage reserve work fit for
> more requirements but no need to care about details.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  doc/c-test-api.txt                    | 33 +++++++++++++++++++--------
>  include/tst_hugepage.h                | 12 +++++++++-
>  include/tst_test.h                    | 27 +++++++++++++++-------
>  lib/newlib_tests/test20.c             | 13 +++++++----
>  lib/newlib_tests/test_zero_hugepage.c |  8 +++++--
>  lib/tst_hugepage.c                    | 22 ++++++++++++++----
>  6 files changed, 86 insertions(+), 29 deletions(-)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 9f104ecd7..1eabdf7ca 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1976,15 +1976,25 @@ For full documentation see the comments in 'include/tst_fuzzy_sync.h'.
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Many of the LTP tests need to use hugepage in their testing, this allows the
> -test can reserve hugepages from system only via '.request_hugepages = xx'.
> +test can reserve hugepages from system only via '.request_hugepages'.
>  
> -If set non-zero number of 'request_hugepages', test will try to reserve the
> -expected number of hugepage for testing in setup phase. If system does not
> -have enough hpage for using, it will try the best to reserve 80% available
> -number of hpages. With success test stores the reserved hugepage number in
> -'tst_hugepages'. For the system without hugetlb supporting, variable
> -'tst_hugepages' will be set to 0. If the hugepage number needs to be set to 0
> -on supported hugetlb system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
> +We simply achieved two policies for hugepage reserving:
> +
> +TST_FLEXIBLE:
> +  If set non-zero number in .request_hugepages, ltp will try to reserve the
> +  expected number of hugepage for testing in setup phase. If system does not
> +  have enough memory for that, it will try the best to reserve 80% available
> +  huge pages.
> +
> +TST_ENFORCED:
> +  This is an enforced requirement for huge page reserve, ltp should strictly do
> +  hpages applying and guarantee the 'HugePages_Free' no less than specified pages
> +  which gives that test can use these specified numbers correctly.

As for the naming I would probably go for TST_NEEDS and TST_REQUEST. We
use the word 'needs' in the tst_test to describe something that is
required for the test. And 'request' sounds better to me than flexible
in a sense that you can request a lot but get less than what was
requested.

> +With success test stores the reserved hugepage number in 'tst_hugepages'. For
> +system without hugetlb supporting, variable 'tst_hugepages' will be set to 0.
> +If the hugepage number needs to be set to 0 on supported hugetlb system, please
> +use '.request_hugepages = TST_NO_HUGEPAGES'.
>  
>  Also, we do cleanup and restore work for the hpages resetting automatically.
>  
> @@ -1996,7 +2006,7 @@ static void run(void)
>  {
>  	...
>  
> -	if (tst_hugepages == test.request_hugepages)
> +	if (tst_hugepages == test.request_hugepages->number)
>  		TEST(do_hpage_test);
>  	else
>  		...
> @@ -2005,7 +2015,10 @@ static void run(void)
>  
>  struct tst_test test = {
>  	.test_all = run,
> -	.request_hugepages = 2,
> +	.request_hugepages = (struct tst_hugepage []){
> +		{2, TST_FLEXIBLE},
> +		{}
> +	},
>  	...
>  };
>  -------------------------------------------------------------------------------
> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> index e08a2daa2..17bd4e9da 100644
> --- a/include/tst_hugepage.h
> +++ b/include/tst_hugepage.h
> @@ -12,6 +12,16 @@
>  extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
>  extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
>  
> +enum tst_hp_policy {
> +	TST_ENFORCED,
> +	TST_FLEXIBLE,
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
> @@ -23,7 +33,7 @@ size_t tst_get_hugepage_size(void);
>   *
>   * Note: this depend on the status of system memory fragmentation.
>   */
> -unsigned long tst_request_hugepages(unsigned long hpages);
> +unsigned long tst_request_hugepages(struct tst_hugepage *hp);
>  
>  /*
>   * This variable is used for recording the number of hugepages which system can
> diff --git a/include/tst_test.h b/include/tst_test.h
> index dbe303bc8..d50d213ef 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -189,17 +189,28 @@ struct tst_test {
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
> +	 * TST_FLEXIBLE:
> +	 *   If set non-zero number in .request_hugepages, ltp will try to reserve the
> +	 *   expected number of hugepage for testing in setup phase. If system does not
> +	 *   have enough memory for that, it will try the best to reserve 80% available
> +	 *   huge pages.
> +	 *
> +	 * TST_ENFORCED:
> +	 *   This is an enforced requirement for huge page reserve, ltp should strictly do
> +	 *   hpages applying and guarantee the 'HugePages_Free' no less than specified pages
> +	 *   which gives that test can use these specified numbers correctly.
> +	 *
> +	 *
> +	 * With success test stores the reserved hugepage number in 'tst_hugepages. For
> +	 * the system without hugetlb supporting, variable 'tst_hugepages' will be set to 0.
> +	 * If the hugepage number needs to be set to 0 on supported hugetlb system, please
> +	 * use '.request_hugepages = TST_NO_HUGEPAGES'.
>  	 *
>  	 * Also, we do cleanup and restore work for the hpages resetting automatically.
>  	 */
> -	unsigned long request_hugepages;
> +	struct tst_hugepage *request_hugepages;

Why is this treated as an array even though we work with only single
struct tst_hugepage instance?

I guess that it should rather be just:

'struct tst_hugepage request_hugepages;'

And that it should be initialized as:

	.request_hugepages = {2, ...},

>  	/*
>  	 * If set to non-zero, call tst_taint_init(taint_check) during setup
> diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
> index 5c24770a1..e8e81f8f4 100644
> --- a/lib/newlib_tests/test20.c
> +++ b/lib/newlib_tests/test20.c
> @@ -18,14 +18,16 @@ static void do_test(void) {
>  	tst_res(TINFO, "tst_hugepages = %lu", tst_hugepages);
>  	SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "1");
>  
> -	hpages = test.request_hugepages;
> +	hpages = test.request_hugepages->number;
>  	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
>  	if (val != hpages)
>  		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
>  	else
> -		tst_res(TPASS, "test .needs_hugepges");
> +		tst_res(TPASS, "test .request_hugepges");
> +
> +	struct tst_hugepage hp = { 1000000000000, TST_FLEXIBLE };
> +	hpages = tst_request_hugepages(&hp);
>  
> -	hpages = tst_request_hugepages(3);
>  	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
>  	if (val != hpages)
>  		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
> @@ -35,7 +37,10 @@ static void do_test(void) {
>  
>  static struct tst_test test = {
>  	.test_all = do_test,
> -	.request_hugepages = 2,
> +	.request_hugepages = (struct tst_hugepage []){
> +		{2, TST_ENFORCED},
> +		{}
> +	},
>  	.save_restore = (const struct tst_path_val[]) {
>  		{"!/proc/sys/kernel/numa_balancing", "0"},
>  		{}
> diff --git a/lib/newlib_tests/test_zero_hugepage.c b/lib/newlib_tests/test_zero_hugepage.c
> index 0d85ce866..27cd196da 100644
> --- a/lib/newlib_tests/test_zero_hugepage.c
> +++ b/lib/newlib_tests/test_zero_hugepage.c
> @@ -21,7 +21,8 @@ static void do_test(void)
>  	else
>  		tst_res(TPASS, "test .request_hugepages = TST_NO_HUGEPAGES");
>  
> -	hpages = tst_request_hugepages(3);
> +	struct tst_hugepage hp = { 3, TST_FLEXIBLE };
> +	hpages = tst_request_hugepages(&hp);
>  	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
>  	if (val != hpages)
>  		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
> @@ -31,5 +32,8 @@ static void do_test(void)
>  
>  static struct tst_test test = {
>  	.test_all = do_test,
> -	.request_hugepages = TST_NO_HUGEPAGES,
> +	.request_hugepages = (struct tst_hugepage []){
> +		{TST_NO_HUGEPAGES, TST_FLEXIBLE},
> +		{}
> +	},
>  };
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> index a7585bc3d..06e9fb7a1 100644
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -20,11 +20,13 @@ size_t tst_get_hugepage_size(void)
>  	return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>  }
>  
> -unsigned long tst_request_hugepages(unsigned long hpages)
> +unsigned long tst_request_hugepages(struct tst_hugepage *hp)
>  {
>  	unsigned long val, max_hpages;
>  
>  	if (access(PATH_HUGEPAGES, F_OK)) {
> +		if (hp->policy == TST_ENFORCED)
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
> +	if (hp->policy == TST_ENFORCED) {
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
> +	if (hp->policy == TST_ENFORCED) {
> +		unsigned long free_hpages = SAFE_READ_MEMINFO("HugePages_Free:");
> +		if (hp->number > free_hpages)
> +			tst_brk(TCONF, "free_hpages = %lu, but expect %lu. "
> +				"Not enough hugepages for testing.",
> +				free_hpages, hp->number);
> +	}
> +
>  	tst_res(TINFO, "%lu hugepage(s) reserved", tst_hugepages);
>  out:
>  	return tst_hugepages;
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
