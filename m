Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDD8C5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 14:57:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52ECF3CE9ED
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 15:57:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 755F03C1D0D
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 15:56:59 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD3321001F26
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 15:56:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE9C96B664;
 Wed,  6 Mar 2024 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709737017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9dFty+54xZ1zmd+oHyPilj39WpdPSBU0zLYA6WibJ8=;
 b=HrWXFwfbtZvhb9I8kIyFl+1/OiuZBgk3Jl13rvr79cpG5RrBsCeDgk7PsnMHXYZTLp9F45
 yiNeCjRNXG8k4N5Cs/jUSnOtQabebrNblsF3oQyU3+IuR6lqNDXQi5GIJTJKkPtxLuovFH
 Nle+EAFTX58TSjtOvg6RJ17+qsOMneY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709737017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9dFty+54xZ1zmd+oHyPilj39WpdPSBU0zLYA6WibJ8=;
 b=TZPh+VdLn9dhrYetNBOkrG7vkDnx74iX0BTr+J0nsHvfa1GXj1IDjC9qMSt1K1qSXnfULT
 nSrN4Jw9PeIiJYDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709737016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9dFty+54xZ1zmd+oHyPilj39WpdPSBU0zLYA6WibJ8=;
 b=0cJTxyIQnUeEz7Wl4LRSX9r8q3A9Djof6aBaG0nz7hnDN6V4L9LnDLVZg0zy3ccgd6luqG
 RgU9iByGTtOIqqbgQvQskhYLsGqzGfc6Rm2kX0V5IBRxx0feUtNcPrd2tb0cxpBo1hpvZ9
 /moevpXfEZ+LV2VgQ7XOG2lw46nXHq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709737016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9dFty+54xZ1zmd+oHyPilj39WpdPSBU0zLYA6WibJ8=;
 b=mgp7mBlraaikAFtIvMX13MyzDcXtCoOKQO32IxrxTEc9/tzGe+nxly7XGq+SoH99vA/FT3
 V9KNLKNBJ/X4MADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D74B313A67;
 Wed,  6 Mar 2024 14:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i2KlMjeE6GVzTQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 06 Mar 2024 14:56:55 +0000
Date: Wed, 6 Mar 2024 15:55:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZeiD-UfEigpEw0Yb@yuki>
References: <20240130122540.13215-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240130122540.13215-1-akumar@suse.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0cJTxyIQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mgp7mBlr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.de:email,linux.it:url,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: EE9C96B664
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/mmap01: Rewrite the test using new
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jan 30, 2024 at 01:23:57PM +0100, Avinesh Kumar wrote:
> - use SAFE_MSYNC() macro
> - fixed the test for iterations > 1
> - enable test for all filesystems
> 
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
> 
> Changes v3->v4:
> * Changed the logic to verify that mapped file has not been changed.
> * Enabled all filesystems.
> 
> 
>  testcases/kernel/syscalls/mmap/mmap01.c | 223 +++++++-----------------
>  1 file changed, 61 insertions(+), 162 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
> index 99266b57f..e0b36915c 100644
> --- a/testcases/kernel/syscalls/mmap/mmap01.c
> +++ b/testcases/kernel/syscalls/mmap/mmap01.c
> @@ -1,194 +1,93 @@
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
>  
> -#include "test.h"
> -
> -#define TEMPFILE	"mmapfile"
> +#include <stdlib.h>
> +#include "tst_test.h"
>  
> -char *TCID = "mmap01";
> -int TST_TOTAL = 1;
> +#define MNT_POINT	"mntpoint"
> +#define TEMPFILE	MNT_POINT"/mmapfile"
>  
> -static char *addr;
> -static char *dummy;
> +static int fd;
>  static size_t page_sz;
>  static size_t file_sz;
> -static int fildes;
> -static char cmd_buffer[BUFSIZ];
> -
> -static void setup(void);
> -static void cleanup(void);
> +static char *addr;
> +static char *dummy;
> +static struct stat stat_buf;
> +static const char write_buf[] = "HelloWorld!";
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
> -
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
> -
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
> -
> -		/* Clean up things in case we are looping */
> -		/* Unmap the mapped memory */
> -		if (munmap(addr, page_sz) != 0) {
> -			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
> -		}
> -	}
> +	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
>  
> -	cleanup();
> -	tst_exit();
> -}
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, write_buf, strlen(write_buf));
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	SAFE_STAT(TEMPFILE, &stat_buf);
>  
> -static void setup(void)
> -{
> -	struct stat stat_buf;
> -	char Path_name[PATH_MAX];
> -	char write_buf[] = "hello world\n";
> +	file_sz = stat_buf.st_size;
> +	page_sz = getpagesize();
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	dummy = SAFE_MALLOC(page_sz);
> +	memset(dummy, 0, page_sz);
> +}
>  
> -	TEST_PAUSE;
> +static void run(void)
> +{
> +	char buf[20];
>  
> -	tst_tmpdir();
> +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
>  
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
> +	SAFE_FILE_SCANF(TEMPFILE, "%s", buf);

Hmm, why do we SAFE_LSEEK() the fd if we are not using it for reading?

This could be just simple SAFE_READ() instead.

> -	page_sz = getpagesize();
> +	if (strcmp(write_buf, buf))
> +		tst_res(TFAIL, "File data has changed");
> +	else
> +		tst_res(TPASS, "mmap() functionality successful");
                                   ^
				   "Data after file end were not written out"

It's kind of pointless to print message that just means "success".


> -	/* Allocate and initialize dummy string of system page size bytes */
> -	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
> -		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
> -	}
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	memset(&addr[file_sz], 0, 3);

I was wondering why this is needed, seems like for tmpfs we will read
back the data after the end of the file on a subsequent runs of the
test, i.e. with -i 2.

I wonder if that is expected or not, it's a bit strange that we can
expand the file size that way.

And it seems to happen for FUSE as well, that actually does sound like a
bug.

> -	/* Create the command which will be executed in the test */
> -	sprintf(cmd_buffer, "grep XYZ %s/%s > /dev/null", Path_name, TEMPFILE);
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
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.mntpoint = MNT_POINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1
> +};
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
