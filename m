Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837B1C48297
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 15:43:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CCD03CDE60
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 16:43:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 186E93C12A7
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 16:43:09 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 12F4E61023F
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 16:43:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B46FE21C05;
 Mon, 12 Feb 2024 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707752587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1rXFjRhku3IRtjSxLNZd2X8DjYnq5Lkf51E/+en0SE=;
 b=Jk/cCOKg8y9QmMKEDJkwLuL0fkkoYem5NWqgnOSoe6YCfqK4a0xr36N19SfFWA2/IuvDcG
 uyXi3dXFVqkibeXxRh/J2M/b3XLznDdv+J8A3Qum20nx/vziYx8Oww/NCVKwPy/ihPS0ub
 LJhu0fiYnIcaaZEnKbzR1DgIqctiuBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707752587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1rXFjRhku3IRtjSxLNZd2X8DjYnq5Lkf51E/+en0SE=;
 b=vY3P63DIbWRqAUc9sYpxcVTKuuf83PQYc5ktQsxaN7M7CN1Y8AykxaHFknMUiUJj3ptB1/
 YKGGocCUVm892sBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707752586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1rXFjRhku3IRtjSxLNZd2X8DjYnq5Lkf51E/+en0SE=;
 b=y/xC0E58zLzCzlQ9vCtDRu/34otsELmLigU50yTl7BzTP3jZlFBLJ1ny/mN3P2RFLqdpMt
 Jj9FhspE8swypTkZBkVahTPvnpheN4M+G+/XXhcts/wgS/+YYUurQpoEerKlyPhBOtB/rM
 1/8p7SKkEs0/thQIeRPXcJ4Sx+RGg3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707752586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1rXFjRhku3IRtjSxLNZd2X8DjYnq5Lkf51E/+en0SE=;
 b=Nao+aVFm7CYh9VqSDbpa+sbolKhQukmJxhRBw3c0d5vzXTM6oT4bOMeuancEh5TLCPGH0Q
 hCGFJY/8qcWxFUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A46FB13985;
 Mon, 12 Feb 2024 15:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /UxxJ4o8ymV/ZwAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 12 Feb 2024 15:43:06 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 12 Feb 2024 16:43:06 +0100
Message-ID: <6989698.9J7NaK4W3v@localhost>
Organization: SUSE
In-Reply-To: <20240205051230.6272-2-xuyang2018.jy@fujitsu.com>
References: <20240205051230.6272-1-xuyang2018.jy@fujitsu.com>
 <20240205051230.6272-2-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="y/xC0E58";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nao+aVFm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_TWO(0.00)[2]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,fujitsu.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: B46FE21C05
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap03: Convert to new API
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

Hi,

most of the comments from mremap02 applies here too.
Also please fix the `make check` complains in all three patches.

Thanks,
Avinesh

On Monday, February 5, 2024 6:12:29 AM CET Yang Xu via ltp wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/mremap/mremap03.c | 197 +++++---------------
>  1 file changed, 44 insertions(+), 153 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mremap/mremap03.c
> b/testcases/kernel/syscalls/mremap/mremap03.c index 02b79bc47..b7497bc01
> 100644
> --- a/testcases/kernel/syscalls/mremap/mremap03.c
> +++ b/testcases/kernel/syscalls/mremap/mremap03.c
> @@ -1,165 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA + * Copyright (c) International Business Machines  Corp.,
> 2001
> + * Copyright (c) Linux Test Project, 2001-2024
>   */
> 
> -/*
> - * Test Name: mremap03
> - *
> - * Test Description:
> - *  Verify that,
> - *   mremap() fails when used to expand the existing virtual memory mapped
> - *   region to the requested size, if there already exists mappings that
> - *   cover the whole address space requsted or the old address specified
> was - *   not mapped.
> - *
> - * Expected Result:
> - *  mremap() should return -1 and set errno to EFAULT.
> - *
> - * Algorithm:
> - *  Setup:
> - *   Setup signal handling.
> - *   Pause for SIGUSR1 if option specified.
> - *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed (return=-1)
> - *	if errno set == expected errno
> - *		Issue sys call fails with expected return value and errno.
> - *	Otherwise,
> - *		Issue sys call fails with unexpected errno.
> - *   Otherwise,
> - *	Issue sys call returns unexpected value.
> +/*\
> + * [Description]
>   *
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> + * Test for EFAULT error.
>   *
> - * Usage:  <for command-line>
> - *  mremap03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -p x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - *      11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
> - *      Modified.
> - *      - #include <linux/mman.h> should not be included as per man page
> for - *        mremap, #include <sys/mman.h> alone should do the job. But
> inorder - *        to include definition of MREMAP_MAYMOVE defined in
> bits/mman.h - *        (included by sys/mman.h) __USE_GNU needs to be
> defined. - *        There may be a more elegant way of doing this...
> - *
> - *
> - * RESTRICTIONS:
> - *  None.
> + * - mremap fail with mapping covering the requested entire address space
> already exists + *   or the old address specified was not mapped.
>   */
> +
>  #define _GNU_SOURCE
> -#include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
>  #include <sys/mman.h>
> +#include "tst_test.h"
> 
> -#include "test.h"
> -
> -char *TCID = "mremap03";
> -int TST_TOTAL = 1;
>  static char *bad_addr;
> -static char *addr;		/* addr of memory mapped region */
> -int memsize;			/* memory mapped size */
> -int newsize;			/* new size of virtual memory block */
> +static char *addr;              /* addr of memory mapped region */
> +static int memsize;             /* memory mapped size */
> +static int newsize;             /* new size of virtual memory block */
> 
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -int main(int ac, char **av)
> +static void verify_mremap(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	errno = 0;
> +	addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
> +	TST_ERR = errno;
> 
> -	setup();
> +	/* Check for the return value of mremap() */
> +	if (addr != MAP_FAILED) {
> +		tst_res(TFAIL | TTERRNO,
> +			"mremap returned invalid value, expected: -1");
> 
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * Attempt to expand the existing mapped
> -		 * memory region (memsize) by newsize limits
> -		 * using mremap() should fail as specified old
> -		 * virtual address was not mapped.
> -		 */
> -		errno = 0;
> -		addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
> -		TEST_ERRNO = errno;
> -
> -		/* Check for the return value of mremap() */
> -		if (addr != MAP_FAILED) {
> -			tst_resm(TFAIL,
> -				 "mremap returned invalid value, expected: -1");
> -
> -			/* Unmap the mapped memory region */
> -			if (munmap(addr, newsize) != 0) {
> -				tst_brkm(TFAIL, cleanup, "munmap fails to "
> -					 "unmap the expanded memory region, "
> -					 " error=%d", errno);
> -			}
> -			continue;
> -		}
> -
> -		/* Check for the expected errno */
> -		if (errno == EFAULT) {
> -			tst_resm(TPASS, "mremap() Fails, 'old region not "
> -				 "mapped', errno %d", TEST_ERRNO);
> -		} else {
> -			tst_resm(TFAIL, "mremap() Fails, "
> -				 "'Unexpected errno %d", TEST_ERRNO);
> -		}
> +		/* Unmap the mapped memory region */
> +		SAFE_MUNMAP(addr, newsize);
>  	}
> 
> -	cleanup();
> -	tst_exit();
> -
> +	/* Check for the expected errno */
> +	if (errno == EFAULT) {
> +		tst_res(TPASS | TTERRNO, "mremap() Failed, 'old region not "
> +				"mapped' - errno %d", TST_ERR);
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "mremap() Failed, "
> +				"'Unexpected errno %d", TST_ERR);
> +	}
>  }
> 
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *
> - * Get system page size.
> - * Set the old address point some high address which is not mapped.
> - */
>  void setup(void)
>  {
> -	int page_sz;		/* system page size */
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	int page_sz;            /* system page size */
> 
> -	TEST_PAUSE;
> +	page_sz = getpagesize();
> 
>  	/* Get the system page size */
> -	if ((page_sz = getpagesize()) < 0) {
> -		tst_brkm(TFAIL, NULL,
> -			 "getpagesize() fails to get system page size");
> +	if (page_sz < 0) {
> +		tst_brk(TFAIL | TTERRNO,
> +			"getpagesize() fails to get system page size");
>  	}
> 
>  	/* Get the size of virtual memory area to be mapped */
> @@ -169,19 +66,13 @@ void setup(void)
>  	newsize = (memsize * 2);
> 
>  	/*
> -	 * Set the old virtual address point to some address
> -	 * which is not mapped.
> -	 */
> -	bad_addr = tst_get_bad_addr(cleanup);
> +	* Set the old virtual address point to some address
> +	* which is not mapped.
> +	*/
> +	bad_addr = tst_get_bad_addr(NULL);
>  }
> 
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -	/* Exit the program */
> -
> -}
> +static struct tst_test test = {
> +	.test_all = verify_mremap,
> +	.setup = setup,
> +};





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
