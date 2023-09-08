Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D644EE7FE3
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 12:21:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EA6B3CE966
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 14:21:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F27E83CB570
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 14:21:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D6FDD600684
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 14:21:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DBF081FE2E;
 Fri,  8 Sep 2023 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694175695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCL7sg1WQoIReuGX1eF9ssbFvlNfFgefF+1Kf+HPnDk=;
 b=o6ub2b8juv3zE57vd3Z4e5y9Ukh4Kql2erNzLchiS/Bnqh8rvD8dJ/IifnaEousDYiVAn1
 LZlx31PivWtUVVPntzCch+PP+e8BaCruL2WuYxGxn2qA1HbURaqqLyCygEccznZruP/zPG
 MCdpV7uw0APC+RfnaonlB1cISKv/v94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694175695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCL7sg1WQoIReuGX1eF9ssbFvlNfFgefF+1Kf+HPnDk=;
 b=DY2FNl+tsbNRwjtlOygj3pSA0ExJDom5zhBJImFAaBNmZUhtMaY4ziPRK/YmSkGY0MtMns
 1SpkeBIXbMgJ7hDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA08F132F2;
 Fri,  8 Sep 2023 12:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Oh77L88R+2SnNgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 08 Sep 2023 12:21:35 +0000
Date: Fri, 8 Sep 2023 14:22:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.vnet.ibm.com>
Message-ID: <ZPsR-fYtg70dC-Tc@yuki>
References: <20230908110530.14990-1-samir@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230908110530.14990-1-samir@linux.vnet.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Migrating the
 libhugetlbfs/testcases/stack_grow_into_huge.c test
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
Cc: geetika@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
First of all the whitespaces in the test are messed up, please make sure
to run 'make check' and fix all the reported problems.

> +void do_child(void *stop_address)
> +{
> +	struct rlimit r;
> +	volatile int *x;
> +
> +	/* corefile from this process is not interesting and limiting
> +	 * its size can save a lot of time. '1' is a special value,
> +	 * that will also abort dumping via pipe, which by default
> +	 * sets limit to RLIM_INFINITY. */
> +	r.rlim_cur = 1;
> +	r.rlim_max = 1;
> +	SAFE_SETRLIMIT(RLIMIT_CORE, &r);
> +
> +	do {
> +		x = alloca(STACK_ALLOCATION_SIZE);
> +		*x = 1;
> +	} while ((void *)x >= stop_address);
> +}
> +
> +static void run_test(void)
> +{
> +	int pid, status, sig;
> +    	char *b;
> +	void *stack_address, *mmap_address, *heap_address;
> +        stack_address = alloca(0);
> +        heap_address = sbrk(0);
> +        /*
> +         * paranoia: start mapping two hugepages below the start of the stack,
> +         * in case the alignment would cause us to map over something if we
> +         * only used a gap of one hugepage.
> +         */
> +        mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
> +        do {
> +		b = SAFE_MMAP(mmap_address, hpage_size, PROT_READ|PROT_WRITE,
> +						MAP_FIXED|MAP_SHARED, fd, 0);
> +		mmap_address -= hpage_size;
> +		/*
> +		 * if we get all the way down to the heap, stop trying
> +		 */
> +		if (mmap_address <= heap_address)
> +			break;
> + 	   } while (b == MAP_FAILED);

This definitelly wouldn't work as expected, SAFE_MMAP() cannot fail, it
does exit the test if it fails.

> +        if (b == MAP_FAILED)
> +		tst_res(TFAIL, "mmap() at unexpected address %p instead of %p\n", b,
> +	    		 mmap_address);
> +    
> +    	pid = SAFE_FORK();
> +		if (pid == 0) {
> +			do_child(mmap_address);
> +			exit(0);
> +		}
> +   	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFSIGNALED(status)) {
> +		sig = WTERMSIG(status);
> +
> +		if (sig == SIGSEGV) {
> +			 tst_res(TPASS, "Test Passed");
> +			 exit(0);
> +		} else {
> +			tst_res(TFAIL, "Got unexpected signal: %s", strsignal(sig));
> +			exit(1);

No calls to exit(1) in the test, the tst_res() is used to report test
results.

> +		}
> +	}
> +	tst_res(TFAIL, "Child not signalled");

This should use tst_strstatus() to print what has happened to the child.
Have a look at syscalls/mmap/mmap18.c how it's done.

> +}
> +
> +void setup(void)
> +{
> +    	struct rlimit r;
> +	page_size = getpagesize();
> +	hpage_size = tst_get_hugepage_size();
> +	/*
> +	 * Setting the stack size to unlimited.
> +	 */
> +	r.rlim_cur = RLIM_INFINITY;
> +        r.rlim_max = RLIM_INFINITY;
> +        SAFE_SETRLIMIT(RLIMIT_STACK, &r);
> +
> +        SAFE_GETRLIMIT(RLIMIT_STACK, &r);
> +        if (r.rlim_cur != RLIM_INFINITY)
> +		tst_brk(TCONF, "Stack rlimit must be 'unlimited'");
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +}
> +
> +void cleanup(void)
> +{
> +    	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tags = (struct tst_tag[]) {
> +                {"linux-git", "0d59a01bc461"},
> +                {}
> +	},
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},
> +	.forks_child = 1,
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
