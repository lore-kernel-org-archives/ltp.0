Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3AFC54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 11:50:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A9663CFD26
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 12:50:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 204023CE770
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 12:50:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 46F161A027BE
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 12:50:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7B1F1F7A1;
 Wed, 13 Mar 2024 11:50:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A75441397F;
 Wed, 13 Mar 2024 11:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FFfNJ+qS8WUVJwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Mar 2024 11:50:02 +0000
Date: Wed, 13 Mar 2024 12:49:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZfGSsIEG_k2htig8@yuki>
References: <20240312151324.13236-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240312151324.13236-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: B7B1F1F7A1
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor fork05 using new LTP API
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
> + * On Friday, May 2, 2003 at 09:47:00AM MST, Ulrich Drepper wrote:
> + * >Robert Williamson wrote:
> + * >
> + * >>   I'm getting a SIGSEGV with one of our tests, fork05.c, that apparently
> + * >> you wrote (attached below).  The test passes on my 2.5.68 machine running
> + * >> SuSE 8.0 (glibc 2.2.5 and Linuxthreads), however it segmentation faults on
> + * >> RedHat 9 running 2.5.68.  The test seems to "break" when it attempts to run
> + * >> the assembly code....could you take a look at it?
> + * >
> + * >There is no need to look at it, I know it cannot work anymore on recent
> + * >systems.  Either change all uses of %gs to %fs or skip the entire patch
> + * >if %gs has a nonzero value.
> + * >
> + * >- --
> + * >- --------------.                        ,-.            444 Castro Street
> + * >Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
> + * >Red Hat         `--' drepper at redhat.com `---------------------------
>   *
> + * On Sat, Aug 12, 2000 at 12:47:31PM -0700, Ulrich Drepper wrote:
> + * > Ever since the %gs handling was fixed in the 2.3.99 series the
> + * > appended test program worked.  Now with 2.4.0-test6 it's not working
> + * > again.  Looking briefly over the patch from test5 to test6 I haven't
> + * > seen an immediate candidate for the breakage.  It could be missing
> + * > propagation of the LDT to the new process (and therefore an invalid
> + * > segment descriptor) or simply clearing %gs.
> + * >
> + * > Anyway, this is what you should see and what you get with test5:
> + * >
> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + * > a = 42
> + * > %gs = 0x0007
> + * > %gs = 0x0007
> + * > a = 99
> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + * >
> + * > This is what you get with test6:
> + * >
> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + * > a = 42
> + * > %gs = 0x0007
> + * > %gs = 0x0000
> + * > <SEGFAULT>
> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + * >
> + * > If somebody is actually creating a test suite for the kernel, please
> + * > add this program.  It's mostly self-contained.  The correct handling
> + * > of %gs is really important since glibc 2.2 will make heavy use of it.
> + * >
> + * > - --
> + * > - ---------------.                          ,-.   1325 Chesapeake Terrace
> + * > Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
> + * > Red Hat          `--' drepper at redhat.com   `------------------------
> + * >
> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   */

Uff, this renders very ugly in the documentation. Can we at least drop
the email signatures and rewrite the text a bit?

> -#include <stdio.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <sys/wait.h>
> +#include <asm/ldt.h>
>  #include "lapi/syscalls.h"
> -#include "test.h"
> -
> -char *TCID = "fork05";
> -
> -static char *environ_list[] = { "TERM", "NoTSetzWq", "TESTPROG" };
> -
> -#define NUMBER_OF_ENVIRON (sizeof(environ_list)/sizeof(char *))
> -int TST_TOTAL = NUMBER_OF_ENVIRON;
> +#include "tst_test.h"
>  
>  #if defined(linux) && defined(__i386__)
>  
> -struct modify_ldt_ldt_s {
> -	unsigned int entry_number;
> -	unsigned long int base_addr;
> -	unsigned int limit;
> -	unsigned int seg_32bit:1;
> -	unsigned int contents:2;
> -	unsigned int read_exec_only:1;
> -	unsigned int limit_in_pages:1;
> -	unsigned int seg_not_present:1;
> -	unsigned int useable:1;
> -	unsigned int empty:25;
> -};
> -
> -static int a = 42;
> -
> -static void modify_ldt(int func, struct modify_ldt_ldt_s *ptr, int bytecount)
> +static void run(void)
>  {
> -	tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
> -}
> -
> -int main(void)
> -{
> -	struct modify_ldt_ldt_s ldt0;
> +	struct user_desc ldt0;
> +	int base_addr = 42;
>  	int lo;
> -	pid_t pid;
> -	int res;
>  
>  	ldt0.entry_number = 0;
> -	ldt0.base_addr = (long)&a;
> +	ldt0.base_addr = (long)&base_addr;
>  	ldt0.limit = 4;
>  	ldt0.seg_32bit = 1;
>  	ldt0.contents = 0;
> @@ -154,49 +90,34 @@ int main(void)
>  	ldt0.useable = 1;
>  	ldt0.empty = 0;
>  
> -	modify_ldt(1, &ldt0, sizeof(ldt0));
> +	tst_syscall(__NR_modify_ldt, 1, &ldt0, sizeof(ldt0));
>  
>  	asm volatile ("movw %w0, %%fs"::"q" (7));
> -
>  	asm volatile ("movl %%fs:0, %0":"=r" (lo));
> -	tst_resm(TINFO, "a = %d", lo);
> +	tst_res(TINFO, "a = %d", lo);
>  
>  	asm volatile ("pushl %%fs; popl %0":"=q" (lo));
> -	tst_resm(TINFO, "%%fs = %#06hx", lo);
> +	tst_res(TINFO, "%%fs = %#06hx", lo);
>  
>  	asm volatile ("movl %0, %%fs:0"::"r" (99));
>  
> -	pid = fork();
> -
> -	if (pid == 0) {
> +	if (!SAFE_FORK()) {
>  		asm volatile ("pushl %%fs; popl %0":"=q" (lo));
> -		tst_resm(TINFO, "%%fs = %#06hx", lo);
> +		tst_res(TINFO, "%%fs = %#06hx", lo);
>  
>  		asm volatile ("movl %%fs:0, %0":"=r" (lo));
> -		tst_resm(TINFO, "a = %d", lo);
> +		tst_res(TINFO, "a = %d", lo);
> +
> +		TST_EXP_EQ_LI(lo, 99);
>  
> -		if (lo != 99)
> -			tst_resm(TFAIL, "Test failed");
> -		else
> -			tst_resm(TPASS, "Test passed");

Huh, why have you dropped the only TPASS/TFAIL in the test?

>  		exit(lo != 99);

	This should be just exit(0).

> -	} else {
> -		waitpid(pid, &res, 0);
>  	}
> -
> -	return WIFSIGNALED(res);


I guess that we can do waitpid() for the process and fail the test if we
get SIGSEGV here as well.


>  }
>  
> -#else /* if defined(linux) && defined(__i386__) */
> -
> -int main(void)
> -{
> -	tst_resm(TINFO, "%%fs test only for ix86");
> -
> -	/*
> -	 * should be successful on all non-ix86 platforms.
> -	 */
> -	tst_exit();
> -}
> +static struct tst_test test = {
> +	.run_all = run
> +};
>  
> -#endif /* if defined(linux) && defined(__i386__) */
> +#else /* defined(linux) && defined(__i386__) */
> +	TST_TEST_TCONF("Test only supports linux 32 bits");
> +#endif
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
