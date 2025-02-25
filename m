Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D51CC021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 15:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 942043C9C06
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 16:20:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B2543C98E7
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:20:02 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 431741BC09DA
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:20:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 52D1F1F455;
 Tue, 25 Feb 2025 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740496801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N5FEpdHHZKJUpkWsQu1cVLPhXGbBln5KOV09vIhPSxw=;
 b=qzI5xIeb3wmarbhnKQQM7907dO6iWSjc/aHKpUY8AldzD37IzoBoJH8mW4WrXJQQ3dhg63
 vxURr5mKHUSktBv1HtMwZJD+F6mMZcmNBt5JV4NBlI2We/bzmtocZzCcP1D9Rr9s7CqRVu
 Ps7JhF+Mb4ffY8rLyq0tIR56zivOXVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740496801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N5FEpdHHZKJUpkWsQu1cVLPhXGbBln5KOV09vIhPSxw=;
 b=0+7Wa2n0kDEbxMqIRu/9RLK40mgpB9KFQl6oF1doiy6pBLIzm/N+pd20StIYSOThIfN0EL
 xyXQNhcyhbNcUjCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740496801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N5FEpdHHZKJUpkWsQu1cVLPhXGbBln5KOV09vIhPSxw=;
 b=qzI5xIeb3wmarbhnKQQM7907dO6iWSjc/aHKpUY8AldzD37IzoBoJH8mW4WrXJQQ3dhg63
 vxURr5mKHUSktBv1HtMwZJD+F6mMZcmNBt5JV4NBlI2We/bzmtocZzCcP1D9Rr9s7CqRVu
 Ps7JhF+Mb4ffY8rLyq0tIR56zivOXVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740496801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N5FEpdHHZKJUpkWsQu1cVLPhXGbBln5KOV09vIhPSxw=;
 b=0+7Wa2n0kDEbxMqIRu/9RLK40mgpB9KFQl6oF1doiy6pBLIzm/N+pd20StIYSOThIfN0EL
 xyXQNhcyhbNcUjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43EDF13332;
 Tue, 25 Feb 2025 15:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BdACEKHfvWcgKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 25 Feb 2025 15:20:01 +0000
Date: Tue, 25 Feb 2025 16:20:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z73frO04tYIwHgHl@yuki.lan>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
 <20250210-mmap_suite_refactoring-v2-5-6edea3a4363a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210-mmap_suite_refactoring-v2-5-6edea3a4363a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/8] Cleanup mmap18 test
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
Cc: rbm@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * [Description]
> + *
> + * Verify mmap() syscall using MAP_GROWSDOWN flag.
>   *
> - * # Test1:
> + * [Algorithm]
>   *
> - *   We assign the memory region partially allocated with MAP_GROWSDOWN flag to
> - *   a thread as a stack and expect the mapping to grow when we touch the
> - *   guard page by calling a recusive function in the thread that uses the
> - *   growable mapping as a stack.
> + * **Test 1**
>   *
> - *   The kernel only grows the memory region when the stack pointer is within
> - *   guard page when the guard page is touched so simply faulting the guard
> - *   page will not cause the mapping to grow.
> + * We assign the memory region partially allocated with MAP_GROWSDOWN flag to
> + * a thread as a stack and expect the mapping to grow when we touch the
> + * guard page by calling a recusive function in the thread that uses the
> + * growable mapping as a stack.
>   *
> - *   Newer kernels does not allow a MAP_GROWSDOWN mapping to grow closer than
> - *   'stack_guard_gap' pages to an existing mapping. So when we map the stack we
> - *   make sure there is enough of free address space before the lowest stack
> - *   address.
> + * The kernel only grows the memory region when the stack pointer is within
> + * guard page when the guard page is touched so simply faulting the guard
> + * page will not cause the mapping to grow.
>   *
> - *   Kernel default 'stack_guard_gap' size is '256 * getpagesize()'.
> + * Newer kernels does not allow a MAP_GROWSDOWN mapping to grow closer than
> + * 'stack_guard_gap' pages to an existing mapping. So when we map the stack we
> + * make sure there is enough of free address space before the lowest stack
> + * address.
>   *
> - *   The stack memory map would look like:
> + * Kernel default `stack_guard_gap` size is `256 * getpagesize()`.
>   *
> - *   |  -  -  -   reserved  size   -  -  -  |
> + * The stack memory map would look like:
>   *
> - *   +-- - - - --+------------+-------------+
> - *   | 256 pages |  unmapped  |   mapped    |
> - *   +-- - - - --+------------+-------------+
> - *                            | mapped size |
> - *   ^           |  -  -  stack size  -  -  |
> - *   start
> - *               ^                          ^
> - *               stack bottom       stack top
> + * |  -  -  -   reserved  size   -  -  -  |
>   *
> - * # Test2:
> + * +-- - - - --+------------+-------------+
> + * | 256 pages |  unmapped  |   mapped    |
> + * +-- - - - --+------------+-------------+
> + *                          | mapped size |
> + * ^           |  -  -  stack size  -  -  |
> + * start
> + *             ^                          ^
> + *             stack bottom       stack top
>   *
> - *   We allocate stack as we do in the first test but we mmap a page in the
> - *   space the stack is supposed to grow into and we expect the thread to
> - *   segfault when the guard page is faulted.
> + * **Test 2**
> + *
> + * We allocate stack as we do in the first test but we mmap a page in the
> + * space the stack is supposed to grow into and we expect the thread to
> + * segfault when the guard page is faulted.
>   */
>  
> -#include <unistd.h>
>  #include <pthread.h>
> -#include <sys/mman.h>
> -#include <sys/wait.h>
> -#include <sys/types.h>
> -#include <stdlib.h>
> -#include <stdbool.h>
> -
>  #include "tst_test.h"
>  #include "tst_safe_pthread.h"
>  
>  static long page_size;
>  
> -static bool __attribute__((noinline)) check_stackgrow_up(void)
> +static bool __attribute_noinline__ check_stackgrow_up(void)

This does not look correct, __attribute_noinline__ is glibc macro, the
code probably does not compile on other libc implementations after this
change.

>  {
>  	char local_var;
>  	static char *addr;
>  
> -       if (!addr) {
> -               addr = &local_var;
> -               return check_stackgrow_up();
> -       }
> +	if (!addr) {
> +		addr = &local_var;
> +		return check_stackgrow_up();
> +	}
>  
> -       return (addr < &local_var);
> +	return (addr < &local_var);
>  }
>  
>  static void setup(void)
> @@ -90,7 +88,7 @@ static void *allocate_stack(size_t stack_size, size_t mapped_size)
>  	long reserved_size = 256 * page_size + stack_size;
>  
>  	start = SAFE_MMAP(NULL, reserved_size, PROT_READ | PROT_WRITE,
> -	                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  	SAFE_MUNMAP(start, reserved_size);
>  
>  	SAFE_MMAP((start + reserved_size - mapped_size), mapped_size, PROT_READ | PROT_WRITE,
> @@ -103,12 +101,12 @@ static void *allocate_stack(size_t stack_size, size_t mapped_size)
>  	tst_res(TINFO, "start = %p, stack_top = %p, stack bottom = %p",
>  		start, stack_top, stack_bottom);
>  	tst_res(TINFO, "mapped pages %zu, stack pages %zu",
> -	        mapped_size/page_size, stack_size/page_size);
> +		mapped_size/page_size, stack_size/page_size);
>  
>  	return stack_bottom;
>  }
>  
> -static __attribute__((noinline)) void *check_depth_recursive(void *limit)
> +static __attribute_noinline__ void *check_depth_recursive(void *limit)
>  {
>  	if ((off_t) &limit < (off_t) limit) {
>  		tst_res(TINFO, "&limit = %p, limit = %p", &limit, limit);
> @@ -192,10 +190,10 @@ static void grow_stack_fail(size_t stack_size, size_t mapped_size)
>  	}
>  
>  	SAFE_WAIT(&wstatus);
> -        if (WIFSIGNALED(wstatus) && WTERMSIG(wstatus) == SIGSEGV)
> +	if (WIFSIGNALED(wstatus) && WTERMSIG(wstatus) == SIGSEGV)
>  		tst_res(TPASS, "Child killed by %s as expected", tst_strsig(SIGSEGV));
> -        else
> -                tst_res(TFAIL, "Child: %s", tst_strstatus(wstatus));
> +	else
> +		tst_res(TFAIL, "Child: %s", tst_strstatus(wstatus));
>  }
>  
>  static void run_test(void)
> 
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
