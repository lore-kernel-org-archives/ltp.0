Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C7FC197A0
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 11:12:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B50433CE3B6
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 12:12:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B6733C9A14
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 12:12:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E0AF1007CAF
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 12:12:11 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2428C22911
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 11:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700133130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IQT6p7i8kAFQLCMIPUqYc5yUwsfEez3B8nBmRU78qk=;
 b=qI/f65dpmeBg5JQPYlPL7HFGw7Hnt9G+wFCU/kvuZ943EZcvQrlXKS+lPLuMTecV6+QalV
 wy+EqRdApN2woibzkJVyCPUxoL9FpbBgicrpi4Qc9A7J4q7GnB1FaWhnHojyOmRrQbfj07
 LjZBlHCNoK7LXoF/ijREfzdtXDFB4xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700133130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IQT6p7i8kAFQLCMIPUqYc5yUwsfEez3B8nBmRU78qk=;
 b=MFjYTaFlzJTzXTh18gcf/+Cqx1ZRhh3WHKnovTy3K6DUTuWY+k2aZaZa17WT6yp0CHLhpo
 fF5A3z9PUTSMIVAg==
Received: from g78 (rpalethorpe.udp.ovpn2.prg.suse.de [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C84ED2D183;
 Thu, 16 Nov 2023 11:12:09 +0000 (UTC)
References: <20230914114520.5212-1-akumar@suse.de>
 <20230914114520.5212-2-akumar@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Thu, 16 Nov 2023 10:43:01 +0000
Organization: Linux Private Site
In-reply-to: <20230914114520.5212-2-akumar@suse.de>
Message-ID: <87r0kq9cl2.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [14.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 2428C22911
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/mmap01: Rewrite the test using new
 LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Avinesh Kumar <akumar@suse.de> writes:

> - use SAFE_MSYNC() macro
> - fixed the test for iterations > 1
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/mmap/mmap01.c | 223 +++++++-----------------
>  1 file changed, 63 insertions(+), 160 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
> index 99266b57f..a1e6e9d59 100644
> --- a/testcases/kernel/syscalls/mmap/mmap01.c
> +++ b/testcases/kernel/syscalls/mmap/mmap01.c
> @@ -1,194 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *	07/2001 Ported by Wayne Boyer
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * Test Description:
> - *  Verify that, mmap() succeeds when used to map a file where size of the
> - *  file is not a multiple of the page size, the memory area beyond the end
> - *  of the file to the end of the page is accessible. Also, verify that
> - *  this area is all zeroed and the modifications done to this area are
> - *  not written to the file.
> - *
> - * Expected Result:
> - *  mmap() should succeed returning the address of the mapped region.
> - *  The memory area beyond the end of file to the end of page should be
> - *  filled with zero.
> - *  The changes beyond the end of file should not get written to the file.
> +/*\
> + * [Description]
>   *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> + * Verify that, mmap() succeeds when used to map a file where size of the
> + * file is not a multiple of the page size, the memory area beyond the end
> + * of the file to the end of the page is accessible. Also, verify that
> + * this area is all zeroed and the modifications done to this area are
> + * not written to the file.
>   */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <sys/types.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <string.h>
> -#include <signal.h>
> -#include <stdint.h>
> -#include <sys/stat.h>
> -#include <sys/mman.h>
> -#include <sys/shm.h>
> -
> -#include "test.h"
> -
> -#define TEMPFILE	"mmapfile"
>  
> -char *TCID = "mmap01";
> -int TST_TOTAL = 1;
> +#include <stdlib.h>
> +#include "tst_test.h"
>  
> -static char *addr;
> -static char *dummy;
> +#define TEMPFILE "mmapfile"
> +static int fd;
>  static size_t page_sz;
>  static size_t file_sz;
> -static int fildes;
> -static char cmd_buffer[BUFSIZ];
> -
> -static void setup(void);
> -static void cleanup(void);
> +static char *dummy;
> +static char *addr;
>  
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * Call mmap to map the temporary file beyond EOF
> -		 * with write access.
> -		 */
> -		errno = 0;
> -		addr = mmap(NULL, page_sz, PROT_READ | PROT_WRITE,
> -			    MAP_FILE | MAP_SHARED, fildes, 0);
> -
> -		/* Check for the return value of mmap() */
> -		if (addr == MAP_FAILED) {
> -			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
> -			continue;
> -		}
> -
> -		/*
> -		 * Check if mapped memory area beyond EOF are
> -		 * zeros and changes beyond EOF are not written
> -		 * to file.
> -		 */
> -		if (memcmp(&addr[file_sz], dummy, page_sz - file_sz)) {
> -			tst_brkm(TFAIL, cleanup,
> -				 "mapped memory area contains invalid "
> -				 "data");
> -		}
> +	struct stat stat_buf;
> +	char write_buf[] = "hello world\n";
>  
> -		/*
> -		 * Initialize memory beyond file size
> -		 */
> -		addr[file_sz] = 'X';
> -		addr[file_sz + 1] = 'Y';
> -		addr[file_sz + 2] = 'Z';
> -
> -		/*
> -		 * Synchronize the mapped memory region
> -		 * with the file.
> -		 */
> -		if (msync(addr, page_sz, MS_SYNC) != 0) {
> -			tst_brkm(TFAIL | TERRNO, cleanup,
> -				 "failed to synchronize mapped file");
> -		}
> +	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
>  
> -		/*
> -		 * Now, Search for the pattern 'XYZ' in the
> -		 * temporary file.  The pattern should not be
> -		 * found and the return value should be 1.
> -		 */
> -		if (system(cmd_buffer) != 0) {
> -			tst_resm(TPASS,
> -				 "Functionality of mmap() successful");
> -		} else {
> -			tst_resm(TFAIL,
> -				 "Specified pattern found in file");
> -		}
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, write_buf, strlen(write_buf));
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	SAFE_STAT(TEMPFILE, &stat_buf);
>  
> -		/* Clean up things in case we are looping */
> -		/* Unmap the mapped memory */
> -		if (munmap(addr, page_sz) != 0) {
> -			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
> -		}
> -	}
> +	file_sz = stat_buf.st_size;

Adding to what Cyril said; I see no reason to stat the file. We simply
expect to read back the same data we wrote.

If the file system transforms the data and adds to it, then it is not
even guaranteed file_sz < page_sz.

> +	page_sz = getpagesize();
>  
> -	cleanup();
> -	tst_exit();
> +	dummy = SAFE_MALLOC(page_sz);
> +	memset(dummy, 0, page_sz);
>  }
>  
> -static void setup(void)
> +static void run(void)
>  {
> -	struct stat stat_buf;
> -	char Path_name[PATH_MAX];
> -	char write_buf[] = "hello world\n";
> +	char buf[20];
> +	unsigned long read_cnt;
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
>  
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	/* Get the path of temporary file to be created */
> -	if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
> -		tst_brkm(TFAIL | TERRNO, cleanup,
> -			 "getcwd failed to get current working directory");
> +	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz) != 0) {
> +		tst_res(TFAIL, "mapped memory area contains invalid data");
> +		goto unmap;
>  	}
>  
> -	/* Creat a temporary file used for mapping */
> -	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
> -		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
> -	}
> +	addr[file_sz] = 'X';
> +	addr[file_sz + 1] = 'Y';
> +	addr[file_sz + 2] = 'Z';
>  
> -	/* Write some data into temporary file */
> -	if (write(fildes, write_buf, strlen(write_buf)) != (long)strlen(write_buf)) {
> -		tst_brkm(TFAIL, cleanup, "writing to %s", TEMPFILE);
> -	}
> +	SAFE_MSYNC(addr, page_sz, MS_SYNC);
>  
> -	/* Get the size of temporary file */
> -	if (stat(TEMPFILE, &stat_buf) < 0) {
> -		tst_brkm(TFAIL | TERRNO, cleanup, "stat of %s failed",
> -			 TEMPFILE);
> -	}
> -	file_sz = stat_buf.st_size;
> +	memset(buf, 0, sizeof(buf));
> +	read_cnt = SAFE_READ(0, fd, buf, sizeof(buf));
> +	if (read_cnt != file_sz)
> +		tst_res(TFAIL, "unexpected data length in buf");
>  
> -	page_sz = getpagesize();
> +	for (int i = 0; i < 3; i++)
> +		if ((memchr(buf, (int)('X') + i, sizeof(buf))) != NULL) {
> +			tst_res(TFAIL, "mmap() functionality failed");
> +			goto unmap;
> +		}

This seems overly complicated and would miss corruption. If any byte has
changed from the original string, then that is an error.

>  
> -	/* Allocate and initialize dummy string of system page size bytes */
> -	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
> -		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
> -	}
> +	tst_res(TPASS, "mmap() functionality successful");
>  
> -	/* Create the command which will be executed in the test */
> -	sprintf(cmd_buffer, "grep XYZ %s/%s > /dev/null", Path_name, TEMPFILE);
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	memset(&addr[file_sz], 0, 3);
> +
> +unmap:
> +	SAFE_MUNMAP(addr, page_sz);
>  }
>  
>  static void cleanup(void)
>  {
> -	close(fildes);
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +
>  	free(dummy);
> -	tst_rmdir();
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_tmpdir = 1

We should add all filesystems here.

> +};
> -- 
> 2.42.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
