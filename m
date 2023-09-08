Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7BDEE7FE3
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 12:15:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B93E13CC0FC
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 14:15:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 216663CB536
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 14:15:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB08F1A00A33
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 14:15:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CED9221B78;
 Fri,  8 Sep 2023 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694175299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M//Ncr5l5G1rYQCbH3U5pRoY7VzZ+QGJr02CvO04FOE=;
 b=3cZF0kxynCOiO5asdhbSfUEzjsRwZSeHcPyy8tt5HSy+COw+Bz3udLF3Zc/AnEqqewzwCV
 M9Ybaps/KLJ2PCadG6FCQwJVYSXJ+JFuEoXuWs3rcVUUZIickowliAV/8ttba/Mc4EYRQ6
 /P7gvGJ8JYegOqFLLuOYJvYsvMoyB0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694175299;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M//Ncr5l5G1rYQCbH3U5pRoY7VzZ+QGJr02CvO04FOE=;
 b=hnoStugtYAxMEt0cuNggB6aBCOQ9V/Jzi2jNbqM+NDm7dgupIz8nQxq+0g25uv3N/mr+zN
 xpRUUAsFd9gzKwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5847132F2;
 Fri,  8 Sep 2023 12:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jOFCK0MQ+2QBMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 08 Sep 2023 12:14:59 +0000
Date: Fri, 8 Sep 2023 14:15:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <ZPsQbSsR1Y-zJBVd@yuki>
References: <20230908103921.511595-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230908103921.511595-1-shirisha@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
 libhugetlbfs/testcases/truncate.c test
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
> +/*\
> + * [Description]
> + *
> + * Test Name: truncate
> + * Test case is used to verify the correct functionality
> + * and compatibility of the library with the "truncate" system call when
> + * operating on files residing in a mounted huge page filesystem.
> + */
> +
> +#include "hugetlb.h"
> +
> +#define RANDOM_CONSTANT	0x1234ABCD
             ^
	     THis is not used at all.

> +#define MNTPOINT "hugetlbfs/"
> +long hpage_size;
> +int fd;

These two should be static.

> +
> +
> +static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
> +{
> +	tst_res(TPASS, "Test Passed");
> +	exit(0);

It's not safe to call exit(0) from a signal handler.

What should be done instead is to:

- add global static volatile int variable
- reset it before we attempt to access the truncated memory
- set it in the signal handler
- print TPASS/TFAIL based on the value of the variable in the run_test()
  function

> +}
> +
> +static void run_test(void)
> +{
> +	void *p;
> +	volatile unsigned int *q;
         ^
	I do not think that this has to be volatile.

	All in all this can be just:

	unsigned int *p;

	...

	p = SAFE_MMAP();

	...

	*p = 0;

> +	struct sigaction my_sigaction;
> +	my_sigaction.sa_handler = sigbus_handler;
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +	if (p == MAP_FAILED)
> +		tst_res(TFAIL, "mmap failed..!!");

SAFE_MMAP() cannot fail, it does exit the test with a failure if the it
fails to map the memory.

> +	q = p;
> +	*q = 0;
> +	SAFE_SIGACTION(SIGBUS, &my_sigaction, NULL);

I guess that we can set up the handler in the setup instead.

> +	SAFE_FTRUNCATE(fd, 0);
> +	*q;
> +        tst_res(TFAIL, "Didn't SIGBUS");

And we should SAFE_UNMAP() the memory here.

Also does the test work with -i 2 ?

> +}
> +
> +
> +void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
> +    	fd = tst_creat_unlinked(MNTPOINT, 0);
   ^
   Wrong indentation, please make sure to run 'make check' and fix all
   the reported problems.

> +}
> +
> +void cleanup(void)
> +{
> +    	if (fd > 0)
> +	    SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {1, TST_NEEDS},
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
