Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A83AC4345F
	for <ltp@archiver.kernel.org>; Fri,  3 May 2024 14:57:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 088463CC67D
	for <ltp@archiver.kernel.org>; Fri,  3 May 2024 16:57:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFEDE3CC589
 for <ltp@lists.linux.it>; Fri,  3 May 2024 16:57:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F5221B601D4
 for <ltp@lists.linux.it>; Fri,  3 May 2024 16:57:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E6DCD2063E;
 Fri,  3 May 2024 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714748243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qLh3+1k0TisVOrbgWlxiuHyDsAO+kvW98wWAgGH91Gk=;
 b=gN79JVXDWyz3bU72aH3DBSdJL9XWrg7Zc13swfaGaVU7/Dg0yUcwS9UGfawbMRiVeUeJ8f
 GzC7vIG2ZIJIPIi7xHg244NtmLrZB83YJhgLCh50sbkvgOSDG1POZdarhfoln1/GtOKc6a
 s9s9MzGTUitB8i25kzkb1r74j31PJRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714748243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qLh3+1k0TisVOrbgWlxiuHyDsAO+kvW98wWAgGH91Gk=;
 b=rBV6pV+FRulTBZnTlnk6kRUBijHmnssb3VN9tdLPZvK9gElkLRNZDdLPkfynJeN+ywvDSM
 VbmsOa8cfUw0RLAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RLSu2FMq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y95Akhs8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714748242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qLh3+1k0TisVOrbgWlxiuHyDsAO+kvW98wWAgGH91Gk=;
 b=RLSu2FMqCAJWNtA1yDEV79kp5/0P0TAL9+TxQq7KHA1IkfoE83FkxQjBXL/K8k+yO1pMbw
 MwCUZmxrYtwBjaXhCbc69vmPGetEYj1OWGqHNEfiS4IsH5yqcy1mO5yagXygshdgX+Du7K
 r4SpLJwG5eTnVNDYYAnpezXQCAHDCF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714748242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qLh3+1k0TisVOrbgWlxiuHyDsAO+kvW98wWAgGH91Gk=;
 b=Y95Akhs8h6lTQBb4scTxae6ZXCRVInYdLE//9yWses2zk2NEEwScMTVfL0I014RXD57SWw
 x9fTYdi/vkXwj9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBB5613991;
 Fri,  3 May 2024 14:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cWLYNFL7NGY/IwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 03 May 2024 14:57:22 +0000
Message-ID: <212a6688-6baa-4201-837e-3bd8ff0d1f27@suse.cz>
Date: Fri, 3 May 2024 16:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240322092832.14955-1-andrea.cervesato@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240322092832.14955-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E6DCD2063E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Refactor fork05 using new LTP API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
two suggestions below.

On 22. 03. 24 10:28, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> simplified documentation
> TST_ABI32 usage
> exit(0)
> check if child crashed
> 
>   testcases/kernel/syscalls/fork/fork05.c | 239 ++++++++----------------
>   1 file changed, 77 insertions(+), 162 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fork/fork05.c b/testcases/kernel/syscalls/fork/fork05.c
> index 9a99cff1d..10ae5258a 100644
> --- a/testcases/kernel/syscalls/fork/fork05.c
> +++ b/testcases/kernel/syscalls/fork/fork05.c
> @@ -1,150 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - * Portions Copyright (c) 2000 Ulrich Drepper
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com$
> - *
> - * For further information regarding this notice, see:$
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - *
> - *
> - *    Linux Test Project - Silicon Graphics, Inc.
> - *    TEST IDENTIFIER	: fork05
> - *    EXECUTED BY	: anyone
> - *    TEST TITLE	: Make sure LDT is propagated correctly
> - *    TEST CASE TOTAL	: 1
> - *    CPU TYPES		: i386
> - *    AUTHORS		: Ulrich Drepper
> - *			  Nate Straz
> - *
> - *On Friday, May 2, 2003 at 09:47:00AM MST, Ulrich Drepper wrote:
> - *>Robert Williamson wrote:
> - *>
> - *>>   I'm getting a SIGSEGV with one of our tests, fork05.c, that apparently
> - *>> you wrote (attached below).  The test passes on my 2.5.68 machine running
> - *>> SuSE 8.0 (glibc 2.2.5 and Linuxthreads), however it segmentation faults on
> - *>> RedHat 9 running 2.5.68.  The test seems to "break" when it attempts to run
> - *>> the assembly code....could you take a look at it?
> - *>
> - *>There is no need to look at it, I know it cannot work anymore on recent
> - *>systems.  Either change all uses of %gs to %fs or skip the entire patch
> - *>if %gs has a nonzero value.
> - *>
> - *>- --
> - *>- --------------.                        ,-.            444 Castro Street
> - *>Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
> - *>Red Hat         `--' drepper at redhat.com `---------------------------
> - *
> + *     Author: Ulrich Drepper / Nate Straz , Red Hat
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>    *
> + * This test verifies that LDT is propagated correctly from parent process to
> + * the child process.
>    *
> - *On Sat, Aug 12, 2000 at 12:47:31PM -0700, Ulrich Drepper wrote:
> - *> Ever since the %gs handling was fixed in the 2.3.99 series the
> - *> appended test program worked.  Now with 2.4.0-test6 it's not working
> - *> again.  Looking briefly over the patch from test5 to test6 I haven't
> - *> seen an immediate candidate for the breakage.  It could be missing
> - *> propagation of the LDT to the new process (and therefore an invalid
> - *> segment descriptor) or simply clearing %gs.
> - *>
> - *> Anyway, this is what you should see and what you get with test5:
> - *>
> - *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - *> a = 42
> - *> %gs = 0x0007
> - *> %gs = 0x0007
> - *> a = 99
> - *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - *>
> - *> This is what you get with test6:
> - *>
> - *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - *> a = 42
> - *> %gs = 0x0007
> - *> %gs = 0x0000
> - *> <SEGFAULT>
> - *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - *>
> - *> If somebody is actually creating a test suite for the kernel, please
> - *> add this program.  It's mostly self-contained.  The correct handling
> - *> of %gs is really important since glibc 2.2 will make heavy use of it.
> - *>
> - *> - --
> - *> - ---------------.                          ,-.   1325 Chesapeake Terrace
> - *> Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
> - *> Red Hat          `--' drepper at redhat.com   `------------------------
> - *>
> - *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>    *
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
> + * > a = 42
> + * > %gs = 0x0007
> + * > %gs = 0x0007
> + * > a = 99
> + * >
> + * > This is what you get with test6:
> + * >
> + * > a = 42
> + * > %gs = 0x0007
> + * > %gs = 0x0000
> + * > <SEGFAULT>
> + * >
> + * > If somebody is actually creating a test suite for the kernel, please
> + * > add this program.  It's mostly self-contained.  The correct handling
> + * > of %gs is really important since glibc 2.2 will make heavy use of it.
> + * >
>    */
>   
> -#include <stdio.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <sys/wait.h>
> +#include "tst_test.h"
>   #include "lapi/syscalls.h"
> -#include "test.h"
> -
> -char *TCID = "fork05";
> -
> -static char *environ_list[] = { "TERM", "NoTSetzWq", "TESTPROG" };
> -
> -#define NUMBER_OF_ENVIRON (sizeof(environ_list)/sizeof(char *))
> -int TST_TOTAL = NUMBER_OF_ENVIRON;
> +#include <asm/ldt.h>

I'm not sure <asm/ldt.h> is available on all archs so it'd be better to 
move this #include under the TST_ABI32 condition.

>   
> -#if defined(linux) && defined(__i386__)
> +#if TST_ABI32
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
> -{
> -	tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
> -}
> -
> -int main(void)
> +static void run(void)
>   {
> -	struct modify_ldt_ldt_s ldt0;
> -	int lo;
> +	struct user_desc ldt0;
> +	int base_addr = 42;
> +	int status;
>   	pid_t pid;
> -	int res;
> +	int lo;
>   
>   	ldt0.entry_number = 0;
> -	ldt0.base_addr = (long)&a;
> +	ldt0.base_addr = (long)&base_addr;
>   	ldt0.limit = 4;
>   	ldt0.seg_32bit = 1;
>   	ldt0.contents = 0;
> @@ -154,49 +78,40 @@ int main(void)
>   	ldt0.useable = 1;
>   	ldt0.empty = 0;
>   
> -	modify_ldt(1, &ldt0, sizeof(ldt0));
> +	tst_syscall(__NR_modify_ldt, 1, &ldt0, sizeof(ldt0));
>   
>   	asm volatile ("movw %w0, %%fs"::"q" (7));
> -
>   	asm volatile ("movl %%fs:0, %0":"=r" (lo));
> -	tst_resm(TINFO, "a = %d", lo);
> +	tst_res(TINFO, "a = %d", lo);
>   
>   	asm volatile ("pushl %%fs; popl %0":"=q" (lo));
> -	tst_resm(TINFO, "%%fs = %#06hx", lo);
> +	tst_res(TINFO, "%%fs = %#06hx", lo);
>   
>   	asm volatile ("movl %0, %%fs:0"::"r" (99));
>   
> -	pid = fork();
> -
> -	if (pid == 0) {
> +	pid = SAFE_FORK();
> +	if (!pid) {
>   		asm volatile ("pushl %%fs; popl %0":"=q" (lo));
> -		tst_resm(TINFO, "%%fs = %#06hx", lo);
> +		tst_res(TINFO, "%%fs = %#06hx", lo);
>   
>   		asm volatile ("movl %%fs:0, %0":"=r" (lo));
> -		tst_resm(TINFO, "a = %d", lo);
> -
> -		if (lo != 99)
> -			tst_resm(TFAIL, "Test failed");
> -		else
> -			tst_resm(TPASS, "Test passed");
> -		exit(lo != 99);
> -	} else {
> -		waitpid(pid, &res, 0);
> -	}
> +		tst_res(TINFO, "a = %d", lo);
>   
> -	return WIFSIGNALED(res);
> -}
> +		TST_EXP_EQ_LI(lo, 99);
>   
> -#else /* if defined(linux) && defined(__i386__) */
> +		exit(0);
> +	}
>   
> -int main(void)
> -{
> -	tst_resm(TINFO, "%%fs test only for ix86");
> +	SAFE_WAITPID(pid, &status, 0);
>   
> -	/*
> -	 * should be successful on all non-ix86 platforms.
> -	 */
> -	tst_exit();
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
> +		tst_res(TFAIL, "Child crashed with SIGSEGV");

The test should fail on any unusual child exit. This particular check 
can be simplified:

if (WIFSIGNALED(status)) {
	tst_res(TFAIL, "Child crashed with %s",
		tst_strsig(WTERMSIG(status));
}

But also check WIFEXITED() and WEXITSTATUS() == 0.

>   }
>   
> -#endif /* if defined(linux) && defined(__i386__) */
> +static struct tst_test test = {
> +	.run_all = run
> +};
> +
> +#else
> +	TST_TEST_TCONF("Test only supports linux 32 bits");
> +#endif

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
