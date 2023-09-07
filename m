Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7D5EE14D3
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 09:25:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDBEB3CC2C7
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:25:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E0233CB65C
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 11:25:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C1797206C4C
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 11:25:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C62A21850;
 Thu,  7 Sep 2023 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694078735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3kWrv5LlCxO1G8/6q2o/5Qt6WjpwZxZKNMgwhPMvzkQ=;
 b=TntA5hFEjYbjaTbhgfIa8YWHNBNPGmFUxDO5SMEWa8zL1LzzyBaDPpzFos6vxhuRNYOYOH
 3CI+Cz6yAA/xGnLTj8eKhKfqK+5WjdVZqMTPwx+EvLgSPsW5TCy8iBD8UkuucbVyEYvqF3
 UGEVU3I43CiPTwzBriE0VxnHm1omTU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694078735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3kWrv5LlCxO1G8/6q2o/5Qt6WjpwZxZKNMgwhPMvzkQ=;
 b=ijqVSPbiiJ4mENAJIoI9NjesVMV7F21dh5ybZZag5dzIP0PiU+yujedSwg3kBgS7TF9frd
 bbQ0tNUWAqmMh5Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D3C3138F9;
 Thu,  7 Sep 2023 09:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qVSMFQ+X+WTSNwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 07 Sep 2023 09:25:35 +0000
Date: Thu, 7 Sep 2023 11:26:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZPmXN9GyrhLC3aw5@yuki>
References: <20230524093930.43971-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230524093930.43971-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] lib: add support for kinds of hpsize
 reservation
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
> Typically when we make use of huge page via LTP library, .hugepages choose
> the default hugepage size, but this can not satisfy all scenarios.
> 
> So this patch introduces applying a specified hpsize huge page for user.
> 
> There is nothing that needs to change for the existing test cases which
> already using .hugepages, it only needs to fill one more field in the
> structure of .hugepages if a different hpsize is required.
> 
> e.g.
> 
>     static struct tst_test test = {
> 	.needs_root = 1,
> 	...
> 	.hugepages = {2, TST_NEEDS, 1048576},
>     };
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  doc/c-test-api.txt     | 37 +++++++++++++++++++++++++++++++++++--
>  include/tst_hugepage.h |  1 +
>  lib/tst_hugepage.c     | 23 +++++++++++++++++------
>  3 files changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index dcb6e1ba8..45610474c 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -2034,9 +2034,15 @@ For full documentation see the comments in 'include/tst_fuzzy_sync.h'.
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Many of the LTP tests need to use hugepage in their testing, this allows the
> -test can reserve hugepages from system via '.hugepages = {xx, TST_REQUEST}'.
> +test can reserve specify size of hugepages from system via:
> +  '.hugepages = {xx, TST_REQUEST, yy}'.
>  
> -We achieved two policies for reserving hugepages:
> +xx: This is used to set how many pages we wanted.
> +
> +yy: This is used to specify the size of the hugepage.
> +    (If not set it will use the default hugepage size)
> +
> +Two policies for reserving hugepages:
>  
>  TST_REQUEST:
>    It will try the best to reserve available huge pages and return the number
> @@ -2103,6 +2109,33 @@ struct tst_test test = {
>  };
>  -------------------------------------------------------------------------------
>  
> +or,
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	...
> +}
> +
> +static void setup(void)
> +{
> +	/*
> +	 * Specify hpsize reserved automatically in the library
> +	 * $ echo 2 > /sys/kernel/mm//hugepages/hugepages-1048576kB/nr_hugepages
> +	 * Do check if 2 hpages are reserved correctly in there
> +	 */
> +}
> +
> +struct tst_test test = {
> +	.test_all = run,
> +	.hugepages = {2, TST_NEEDS, 1048576},
> +	...
> +};
> +-------------------------------------------------------------------------------
> +
>  1.35 Checking for required commands
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> index 46327c79a..e96bfbe53 100644
> --- a/include/tst_hugepage.h
> +++ b/include/tst_hugepage.h
> @@ -27,6 +27,7 @@ enum tst_hp_policy {
>  struct tst_hugepage {
>  	const unsigned long number;
>  	enum  tst_hp_policy policy;
> +	const unsigned long hpsize;
>  };
>  
>  /*
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> index 728a8c3ec..b6706d412 100644
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -5,6 +5,7 @@
>  
>  #define TST_NO_DEFAULT_MAIN
>  
> +#include <stdio.h>
>  #include "tst_test.h"
>  #include "tst_hugepage.h"
>  
> @@ -22,9 +23,10 @@ size_t tst_get_hugepage_size(void)
>  
>  unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>  {
> -	unsigned long val, max_hpages;
> +	unsigned long val, max_hpages, hpsize;
> +	char hugepage_path[PATH_MAX];
>  	struct tst_path_val pvl = {
> -		.path = PATH_NR_HPAGES,
> +		.path = hugepage_path,

This pointer (hugepage_path) is on stack and is passed to a function
that stores the structure into a list and then uses it to restore the
value at the end of the testrun, which will probably crash the test
since there will be random leftovers on the stack.

The array has to be static to have unlimited lifetime.

>  		.val = NULL,
>  		.flags = TST_SR_SKIP_MISSING | TST_SR_TCONF_RO
>  	};
>
> @@ -41,6 +43,13 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>  	else
>  		tst_hugepages = hp->number;
>  
> +	if (hp->hpsize)
> +		hpsize = hp->hpsize;
> +	else
> +		hpsize = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE);
> +
> +	sprintf(hugepage_path, PATH_HUGEPAGES"/hugepages-%lukB/nr_hugepages", hpsize);

Do we check anywhere here if the path actually exists? There is no
guarantee that specific hugepage size will exist on the system, so I
suppose that we have to do:

	if (access(hugepage_path, F_OK)) {
		if (hp->policy == TST_NEEDS)
			tst_brk(TCONF, "Hugepage size %lu not supported", hpsize);
		tst_hugepages = 0;
		goto out;
	}

>  	if (hp->number == TST_NO_HUGEPAGES) {
>  		tst_hugepages = 0;
>  		goto set_hugepages;
> @@ -52,7 +61,7 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>  		goto set_hugepages;
>  	}
>  
> -	max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
> +	max_hpages = SAFE_READ_MEMINFO("MemFree:") / hpsize;
>  	if (tst_hugepages > max_hpages) {
>  		tst_res(TINFO, "Requested number(%lu) of hugepages is too large, "
>  				"limiting to 80%% of the max hugepage count %lu",
> @@ -65,14 +74,16 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>  
>  set_hugepages:
>  	tst_sys_conf_save(&pvl);
> -	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
> -	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
> +
> +	SAFE_FILE_PRINTF(hugepage_path, "%lu", tst_hugepages);
> +	SAFE_FILE_SCANF(hugepage_path, "%lu", &val);
> +
>  	if (val != tst_hugepages)
>  		tst_brk(TCONF, "nr_hugepages = %lu, but expect %lu. "
>  				"Not enough hugepages for testing.",
>  				val, tst_hugepages);
>  
> -	if (hp->policy == TST_NEEDS) {
> +	if ((hp->policy == TST_NEEDS) && (!hp->hpsize)) {

This branch shouldn't be disabled for TST_NEEDS case, shouldn't there be
HugePages_Free-$(size)kB ?

>  		unsigned long free_hpages = SAFE_READ_MEMINFO("HugePages_Free:");
>  		if (hp->number > free_hpages)
>  			tst_brk(TCONF, "free_hpages = %lu, but expect %lu. "
> -- 
> 2.40.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
