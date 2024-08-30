Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2EFCA0EC5
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 10:12:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 111BB3D2854
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 12:12:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85F9A3D26BF
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 12:11:57 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B267214088F0
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 12:11:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AE0D1F7BD;
 Fri, 30 Aug 2024 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725012715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKUFOVND9qhEBPpNmFpnWHQi0EQZEo3rIK35jSgP/RY=;
 b=ApAIyPDobnYMlDoh2jZjW+yU1KURzd2bCHFrisQAyKgNCaGIsAitXZC5HwbdfTQKMBq3Ue
 xs9tY8hJpxF86LSMHp3bx7BChhoQyYzazPsriMN/Vufue6YXIy2nbv35WToTMLbKzYwtH7
 pCVd7YTND/K4T9onDjN1t3rZZeY8Rbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725012715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKUFOVND9qhEBPpNmFpnWHQi0EQZEo3rIK35jSgP/RY=;
 b=0PvWAahIcMzC3KZOnjtqJwDfjl30wrwPyU7OvzStHldBFcwDIar79AH6PbizQyAy+qFL4X
 ONZAo15GyJiTmbDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ApAIyPDo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0PvWAahI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725012715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKUFOVND9qhEBPpNmFpnWHQi0EQZEo3rIK35jSgP/RY=;
 b=ApAIyPDobnYMlDoh2jZjW+yU1KURzd2bCHFrisQAyKgNCaGIsAitXZC5HwbdfTQKMBq3Ue
 xs9tY8hJpxF86LSMHp3bx7BChhoQyYzazPsriMN/Vufue6YXIy2nbv35WToTMLbKzYwtH7
 pCVd7YTND/K4T9onDjN1t3rZZeY8Rbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725012715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKUFOVND9qhEBPpNmFpnWHQi0EQZEo3rIK35jSgP/RY=;
 b=0PvWAahIcMzC3KZOnjtqJwDfjl30wrwPyU7OvzStHldBFcwDIar79AH6PbizQyAy+qFL4X
 ONZAo15GyJiTmbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 657F213A3D;
 Fri, 30 Aug 2024 10:11:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AQJ+GOua0WZJGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 30 Aug 2024 10:11:55 +0000
Date: Fri, 30 Aug 2024 12:10:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZtGaqJ0o5yEiYGsq@yuki.lan>
References: <20240515121842.26119-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240515121842.26119-1-andrea.cervesato@suse.de>
X-Rspamd-Queue-Id: 7AE0D1F7BD
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactor fork05 using new LTP API
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
> +/*\
> + * [Description]
>   *
> + * This test verifies that LDT is propagated correctly from parent process to
> + * the child process.
>   *
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
>   */

This renders very ugly in the ascii doc documentation. If you want to
preserve these emails you should replace the > with space which will
turn them into literal paragraphs.

> -#include <stdio.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <sys/wait.h>
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
> -#include "test.h"
> -
> -char *TCID = "fork05";
> -
> -static char *environ_list[] = { "TERM", "NoTSetzWq", "TESTPROG" };
>  
> -#define NUMBER_OF_ENVIRON (sizeof(environ_list)/sizeof(char *))
> -int TST_TOTAL = NUMBER_OF_ENVIRON;
> +#if TST_ABI32

As far as I understand the modify_ldt syscall is only supported on x86
hardware since it changes a descriptor table used by the CPU. So there
is no point in enabling that on other architectures e.g. 32bit Arm.

Grepping the kernel sources it seems that it's indeed implemented only
for 32bit intel CPUs.

> -#if defined(linux) && defined(__i386__)
> +#include <asm/ldt.h>
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
>  {
> -	struct modify_ldt_ldt_s ldt0;
> -	int lo;
> +	struct user_desc ldt0;
> +	int base_addr = 42;
> +	int status;
>  	pid_t pid;
> -	int res;
> +	int lo;
>  
>  	ldt0.entry_number = 0;
> -	ldt0.base_addr = (long)&a;
> +	ldt0.base_addr = (long)&base_addr;
>  	ldt0.limit = 4;
>  	ldt0.seg_32bit = 1;
>  	ldt0.contents = 0;
> @@ -154,49 +79,40 @@ int main(void)
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
> +	pid = SAFE_FORK();
> +	if (!pid) {
>  		asm volatile ("pushl %%fs; popl %0":"=q" (lo));
> -		tst_resm(TINFO, "%%fs = %#06hx", lo);
> +		tst_res(TINFO, "%%fs = %#06hx", lo);
>  
>  		asm volatile ("movl %%fs:0, %0":"=r" (lo));
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
> +	if (WIFSIGNALED(status))
> +		tst_res(TFAIL, "Child crashed with %s", tst_strsig(WTERMSIG(status)));
>  }
>  
> -#endif /* if defined(linux) && defined(__i386__) */
> +static struct tst_test test = {
> +	.run_all = run
> +};
> +
> +#else
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
