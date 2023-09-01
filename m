Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC877CA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 09:53:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096783CCB2F
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 11:53:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0099E3CBB47
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 11:53:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 23252601BC3
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 11:53:27 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0AF271F45E
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693562007;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESHNbfjM/7LR8Yoi1E9Y+GSui48+5ExZ6jGLsYW8i5o=;
 b=sUXhHDW1zJEMXbfPfBSvr1j2NB5I07iGZr18zQ1ZB431qFhbuR+M8Lcu3aRfsLPYduL3tM
 t2ioMs7OB7IdfzjWkTlAnC9TvFTgardNbAmJjqJMAdyxg69rdZwRZQKfGryvgeSV+tcOoq
 22W5Mzc5L+m9sckhdjJKts7ZZ2Cmm/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693562007;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESHNbfjM/7LR8Yoi1E9Y+GSui48+5ExZ6jGLsYW8i5o=;
 b=aN8tJnYbWtoPpCFtSGuS7ovrhz/LUda+V5RUeTdGxGQT6ly3UnvqvnmQLd59/Kb2zOBueg
 iauP/UbIE/1ejLDQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5B7862C142;
 Fri,  1 Sep 2023 09:53:26 +0000 (UTC)
References: <20230825063932.30875-1-akumar@suse.de>
 <20230825063932.30875-4-akumar@suse.de>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Fri, 01 Sep 2023 10:23:07 +0100
Organization: Linux Private Site
In-reply-to: <20230825063932.30875-4-akumar@suse.de>
Message-ID: <877cpagqy5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] syscalls/mmap14: Rewrite test using new LTP
 API
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

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/mmap/mmap14.c | 135 +++++++-----------------
>  1 file changed, 40 insertions(+), 95 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
> index 31632601b..2bc63ae58 100644
> --- a/testcases/kernel/syscalls/mmap/mmap14.c
> +++ b/testcases/kernel/syscalls/mmap/mmap14.c
> @@ -1,124 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
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
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * Test Description:
> - *  Verify MAP_LOCKED works fine.
> - *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
> +/*\
> + * [Description]
>   *
> - * Expected Result:
> - *  mmap() should succeed returning the address of the mapped region,
> - *  and this region should be locked into memory.
> + * Verify that, mmap() call with MAP_LOCKED flag successfully locks
> + * the mapped pages into memory.
>   */
> -#include <stdio.h>
> -#include <sys/mman.h>
>  
> -#include "test.h"
> +#include <stdio.h>
> +#include "tst_test.h"
>  
> -#define TEMPFILE        "mmapfile"
> -#define MMAPSIZE        (1UL<<20)
> +#define MMAPSIZE        (1UL<<16)
>  #define LINELEN         256
>  
> -char *TCID = "mmap14";
> -int TST_TOTAL = 1;
> -
>  static char *addr;
> -
>  static void getvmlck(unsigned int *lock_sz);
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int argc, char *argv[])
> -{
> -	int lc;
> -	unsigned int sz_before;
> -	unsigned int sz_after;
> -	unsigned int sz_ch;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		getvmlck(&sz_before);
> -
> -		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> -			    MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
> -			    -1, 0);
> -
> -		if (addr == MAP_FAILED) {
> -			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
> -			continue;
> -		}
> -
> -		getvmlck(&sz_after);
> -
> -		sz_ch = sz_after - sz_before;
> -		if (sz_ch == MMAPSIZE / 1024) {
> -			tst_resm(TPASS, "Functionality of mmap() "
> -					"successful");
> -		} else {
> -			tst_resm(TFAIL, "Expected %luK locked, "
> -					"get %uK locked",
> -					MMAPSIZE / 1024, sz_ch);
> -		}
> -
> -		if (munmap(addr, MMAPSIZE) != 0)
> -			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
>  
>  void getvmlck(unsigned int *lock_sz)
>  {
> -	int ret;
>  	char line[LINELEN];
> -	FILE *fstatus = NULL;
> +	FILE *fp = NULL;
>  
> -	fstatus = fopen("/proc/self/status", "r");
> -	if (fstatus == NULL)
> -		tst_brkm(TFAIL | TERRNO, NULL, "Open dev status failed");
> +	fp = fopen("/proc/self/status", "r");
> +	if (fp == NULL)
> +		tst_brk(TFAIL | TERRNO, "could not open status file");
>  
> -	while (fgets(line, LINELEN, fstatus) != NULL)
> +	while (fgets(line, LINELEN, fp) != NULL) {
>  		if (strstr(line, "VmLck") != NULL)
>  			break;
> +	}
>  
> -	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
> -	if (ret != 1)
> -		tst_brkm(TFAIL | TERRNO, NULL, "Get lock size failed");
> +	if (sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz) != 1)
> +		tst_brk(TFAIL | TERRNO, "Get lock size failed");
>  
> -	fclose(fstatus);
> +	fclose(fp);
>  }
>  
> -static void setup(void)
> +static void run(void)
>  {
> -	tst_require_root();
> +	unsigned int sz_before, sz_after, sz_diff;
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	getvmlck(&sz_before);
>  
> -	TEST_PAUSE;
> -}
> +	addr = mmap(0, MMAPSIZE, PROT_READ | PROT_WRITE,
> +				MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);
>  
> -static void cleanup(void)
> -{
> +	if (addr != MAP_FAILED)
> +		tst_res(TPASS, "mmap() with MAP_LOCKED flag passed");
> +	else {
> +		tst_res(TFAIL | TERRNO, "mmap() failed");
> +		return;
> +	}
> +
> +	getvmlck(&sz_after);
> +	sz_diff = sz_after - sz_before;
> +	TST_EXP_EQ_LU(MMAPSIZE / 1024, sz_diff);
> +
> +	SAFE_MUNMAP(addr, MMAPSIZE);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1

I suppose that if RLIMIT_MEMLOCK < MMAPSIZE then the test will fail.

The original test required root, but if we are inside a user namespace
then this is not enough:

nsjail -u 0 --rlimit_memlock 0 --chroot / -- /home/rich/kernel/ltp/testcases/kernel/syscalls/mmap/mmap14
[I][2023-09-01T10:39:53+0100] Mode: STANDALONE_ONCE
[I][2023-09-01T10:39:53+0100] Jail parameters: hostname:'NSJAIL', chroot:'/', process:'/home/rich/kernel/ltp/testcases/kernel/syscalls/mmap/mmap14', bind:[::]:0, max_conns:0, max_conns_per_ip:0, time_limit:0, personality:0, daemonize:false, clone_newnet:true, clone_newuser:true, clone_newns:true, clone_newpid:true, clone_newipc:true, clone_newuts:true, clone_newcgroup:true, clone_newtime:false, keep_caps:false, disable_no_new_privs:false, max_cpus:0
[I][2023-09-01T10:39:53+0100] Mount: '/' -> '/' flags:MS_RDONLY|MS_BIND|MS_REC|MS_PRIVATE type:'' options:'' dir:true
[I][2023-09-01T10:39:53+0100] Mount: '/proc' flags:MS_RDONLY type:'proc' options:'' dir:true
[I][2023-09-01T10:39:53+0100] Uid map: inside_uid:0 outside_uid:1000 count:1 newuidmap:false
[I][2023-09-01T10:39:53+0100] Gid map: inside_gid:100 outside_gid:100 count:1 newgidmap:false
[I][2023-09-01T10:39:53+0100] Executing '/home/rich/kernel/ltp/testcases/kernel/syscalls/mmap/mmap14' for '[STANDALONE MODE]'
mmap14      1  TFAIL  :  mmap14.c:68: mmap of mmapfile failed: errno=EPERM(1): Operation not permitted
[I][2023-09-01T10:39:53+0100] pid=15754 ([STANDALONE MODE]) exited with status: 1, (PIDs left: 0)

That is the original test. It sees we are UID 0 so thinks it can run,
but actually can't.

Probably the best thing to do is check the rlimit and ignore what user
we are. If we are real root (i.e. in the first user namespace) then the
rlimit should not matter, but checking what namespace is not something
we have done before AFAIK. So it's a seperate discussion.

> +};
> -- 
> 2.41.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
