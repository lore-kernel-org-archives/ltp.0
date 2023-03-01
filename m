Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44959C6FA9D
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 15:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E4F63CDD9F
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 16:27:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0F893CB124
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 16:27:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9335F601295
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 16:27:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D19EC21AA3;
 Wed,  1 Mar 2023 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677684444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2VsOLck5osIpHVrymZFYCQkTH0zaffaT8R0jfxuXu7k=;
 b=tfBdLDFSYB3pgmLWOhchJReH2d9sOsHHXtNWlfjCjjvcn4Q7tWVUl7DuCSjwaVcVIXEXAt
 Hwcrfr2xLRAzxGaROMqypdP1oLeq1+BXLx3yAk1tr9VEojHkid+Kimw7F/UffYkmRsE9oD
 nS4SSbfkdv2ZKwYeicz6jHYUeFslajY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677684444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2VsOLck5osIpHVrymZFYCQkTH0zaffaT8R0jfxuXu7k=;
 b=41VKKe3QH7BtFyW9EPuR0w9CRddVQnrjbp3f6SkIhlefavVS9V5/9Su4ts8BmkUHoPkPJf
 xaKB5HQs0qLzo8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD80013A3E;
 Wed,  1 Mar 2023 15:27:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ltkPLdxu/2NYXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 01 Mar 2023 15:27:24 +0000
Date: Wed, 1 Mar 2023 16:28:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Message-ID: <Y/9vL6uW2UxcMzrP@yuki>
References: <20230301141634.2881117-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230301141634.2881117-1-Liam.Howlett@oracle.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mprotect: Add mprotect05 testcase
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
> Add a test that uses mprotect to split and combine VMAs.  Created to
> ensure the correctness of the VMA iterator after a bug report.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217061
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  .../kernel/syscalls/mprotect/mprotect05.c     | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mprotect/mprotect05.c
> 
> diff --git a/testcases/kernel/syscalls/mprotect/mprotect05.c b/testcases/kernel/syscalls/mprotect/mprotect05.c
> new file mode 100644
> index 000000000..36f137544
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mprotect/mprotect05.c
> @@ -0,0 +1,118 @@
> +/*
> + * Copyright (c) International Business Machines  Corp., 2001
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */

We switched to SPDX long time ago, please use that instead.

> +/*
> + * DESCRIPTION
> + *	Testcase to check the mprotect(2) system call split/merge
> + *
> + * ALGORITHM
> + *	Create a mapped region using mmap with READ permission.
> + *	Create different VMAs in stripes with mprotect (exec & write)
> + *	mprotect over middle & write area, causing vma_merge of prev & next
> + *	before hitting the limnits.
> + *
> + */

This should be asciidoc formatted comment that starts with a special
header:

/*\
 * [Description]
 *

> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include "test.h"
> +
> +#include "safe_macros.h"
> +
> +static void sighandler(int sig);
> +static void cleanup(void);
> +static void setup(void);
> +
> +char *TCID = "mprotect05";
> +int TST_TOTAL = 1;
> +static int fd;
> +static char file1[BUFSIZ];
> +
> +static char *addr = MAP_FAILED;
> +static unsigned long fullsize;
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int fd;
> +	unsigned long pagesize;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	pagesize = getpagesize();
> +	fullsize = 5 * pagesize;
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		fd = SAFE_OPEN(cleanup, file1, O_RDWR | O_CREAT, 0777);
> +
> +		addr = SAFE_MMAP(cleanup, 0, fullsize, PROT_READ,
> +				MAP_SHARED, fd, 0);
> +
> +		TEST(mprotect(addr + pagesize, pagesize*1, PROT_EXEC));
> +		if (TEST_RETURN)
> +			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
> +
> +		TEST(mprotect(addr + 3*pagesize, pagesize, PROT_WRITE));
> +		if (TEST_RETURN)
> +			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
> +
> +		TEST(mprotect(addr + pagesize, pagesize*4, PROT_READ));
> +		if (TEST_RETURN)
> +			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
> +
> +		SAFE_MUNMAP(cleanup, addr, fullsize);
> +		addr = MAP_FAILED;
> +		SAFE_CLOSE(cleanup, fd);
> +		SAFE_UNLINK(cleanup, file1);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}

Please use the new test library, the old test library is deprecated and
will be removed. See include/tst_test.h.

> +static void sighandler(int sig)
> +{
> +	_exit((sig == SIGSEGV) ? 0 : sig);
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(FORK, sighandler, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	sprintf(file1, "mprotect05.tmp.%d", getpid());
> +}
> +
> +static void cleanup(void)
> +{
> +	if (addr != MAP_FAILED) {
> +		SAFE_MUNMAP(NULL, addr, fullsize);
> +		SAFE_CLOSE(NULL, fd);
> +	}
> +
> +	tst_rmdir();
> +}
> -- 
> 2.39.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
