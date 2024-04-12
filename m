Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD4FC4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 11:29:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BC7E3CF911
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 13:29:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 441D93C0E52
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 13:29:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A66271A0120D
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 13:29:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49904381FB;
 Fri, 12 Apr 2024 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712921359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bHY4VLl9D4t5P7+wprK7153qM6JIIi5lvOAU2fLXoU=;
 b=AbFxFBVBKZXIWb8+X0DoPqYqw6CYB0hUSy68YsZyn+Z9GmsAiGYoZDtlpmltXuO7a/lSVL
 7zia31zobN1weZsG0o4zgIGuQbq6QectNBNAqdvw/GAXAgT3cR5D5WmfM6Opgh3p0i4xLZ
 i8cOXbEc2/zhUFzStTBZ/OKzW7xCFC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712921359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bHY4VLl9D4t5P7+wprK7153qM6JIIi5lvOAU2fLXoU=;
 b=ewVTooJpqCcIgBdakTsb6cQcGOQs7AwAwthkVjv33/pdDLaMpXGDziQ6dA01yHfO7Jy0wh
 7FG9vLmdODa2VQAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AbFxFBVB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ewVTooJp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712921359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bHY4VLl9D4t5P7+wprK7153qM6JIIi5lvOAU2fLXoU=;
 b=AbFxFBVBKZXIWb8+X0DoPqYqw6CYB0hUSy68YsZyn+Z9GmsAiGYoZDtlpmltXuO7a/lSVL
 7zia31zobN1weZsG0o4zgIGuQbq6QectNBNAqdvw/GAXAgT3cR5D5WmfM6Opgh3p0i4xLZ
 i8cOXbEc2/zhUFzStTBZ/OKzW7xCFC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712921359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bHY4VLl9D4t5P7+wprK7153qM6JIIi5lvOAU2fLXoU=;
 b=ewVTooJpqCcIgBdakTsb6cQcGOQs7AwAwthkVjv33/pdDLaMpXGDziQ6dA01yHfO7Jy0wh
 7FG9vLmdODa2VQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AA0E13942;
 Fri, 12 Apr 2024 11:29:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xpwvDQ8bGWazOAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Apr 2024 11:29:19 +0000
Date: Fri, 12 Apr 2024 13:28:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.vnet.ibm.com>
Message-ID: <Zhka2TEpvdMhiBNO@yuki>
References: <20240407102425.65452-1-samir@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240407102425.65452-1-samir@linux.vnet.ibm.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 49904381FB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/stack_grow_into_huge.c test.
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
Cc: rpalethorpe@suse.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +#if defined(__powerpc__) || defined(__powerpc64__)

We have supported_archs array in the tst_test structure now so instead
of ifdefing out the whole test we should add:

	.supported_archs = {"ppc", "ppc64", NULL},

> +#ifdef __LP64__
> +#define STACK_ALLOCATION_SIZE	(256*1024*1024)
> +#else
> +#define STACK_ALLOCATION_SIZE	(16*1024*1024)
> +#endif
> +#define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
> +#define MNTPOINT "hugetlbfs/"
> +static int  fd = -1;
> +static unsigned long long hpage_size;
> +static int page_size;
> +
> +
> +void do_child(void *stop_address)
> +{
> +	struct rlimit r;
> +	volatile int *x;
> +
> +	/* corefile from this process is not interesting and limiting
> +	 * its size can save a lot of time. '1' is a special value,
> +	 * that will also abort dumping via pipe, which by default
> +	 * sets limit to RLIM_INFINITY.
> +	 */
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
> +	int pid, status;
> +	void *stack_address, *mmap_address, *heap_address, *map;
> +
> +	stack_address = alloca(0);
> +	heap_address = sbrk(0);
> +
> +	/*
> +	 * paranoia: start mapping two hugepages below the start of the stack,
> +	 * in case the alignment would cause us to map over something if we
> +	 * only used a gap of one hugepage.
> +	 */
> +	mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
> +	do {
> +		map = mmap(mmap_address, hpage_size, PROT_READ|PROT_WRITE,
> +				MAP_SHARED | MAP_FIXED_NOREPLACE, fd, 0);
> +		if (map == MAP_FAILED) {
> +			if (errno == ENOMEM) {
> +				tst_res(TCONF, "There is no enough memory in the system to do mmap");
> +				exit(-1);

This should be just return;

> +			}
> +		}
> +		mmap_address -= hpage_size;
> +		/*
> +		 * if we get all the way down to the heap, stop trying
> +		 */
> +	} while (mmap_address <= heap_address);
> +	pid = SAFE_FORK();
> +	if (pid == 0)
> +		do_child(mmap_address);
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
> +		tst_res(TPASS, "Child killed by %s as expected", tst_strsig(SIGSEGV));
> +	else
> +		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
> +}
> +
> +void setup(void)
> +{
> +	struct rlimit r;
> +
> +	page_size = getpagesize();
> +	hpage_size = tst_get_hugepage_size();
> +	/*
> +	 * Setting the stack size to unlimited.
> +	 */
> +	r.rlim_cur = RLIM_INFINITY;
> +	r.rlim_max = RLIM_INFINITY;
> +	SAFE_SETRLIMIT(RLIMIT_STACK, &r);
> +	SAFE_GETRLIMIT(RLIMIT_STACK, &r);
> +	if (r.rlim_cur != RLIM_INFINITY)
> +		tst_brk(TCONF, "Stack rlimit must be 'unlimited'");
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +}
> +
> +void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tags = (struct tst_tag[]) {
> +		{"linux-git", "0d59a01bc461"},
> +		{}
> +	},
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {1, TST_NEEDS},
> +	.forks_child = 1,
> +};
> +#else
> +TST_TEST_TCONF("stack_grow_into_huge dosen't support on other architecture");
> +#endif
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
