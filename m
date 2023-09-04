Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD541C83F33
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 09:21:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 403F83CB8C6
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 11:21:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90A5D3CB5AC
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:21:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 50A56140123A
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:21:06 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4FCD31F38C
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 09:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693819266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7W/wqTqedJ1LkI9pkI9+1sp5mrE2kS2vNEnnB1Ob08=;
 b=zeNtkfKDipAHcJASen9+rtzwlXyqGgUMB2ySAtnqP1j1xflm1WYJkzt/W4iioPUExIFKb8
 3tX6VDbRNweraB9AXuCflf/7Gl0WiSlGuZZRsV381nMgbLe+P8x6SuL5pFOidf2xvcoNlh
 4ialeZ4OFNupcoroengAuNboFUsohT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693819266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7W/wqTqedJ1LkI9pkI9+1sp5mrE2kS2vNEnnB1Ob08=;
 b=o044CII814ISZ+9VZI3XB6Z7np3kY4NE0C59/ZW0g9DOyzFOUUl49lvwtDXt+2zqYIeZ7g
 ZuPsvxJbBzyFF1Bw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A41222C143;
 Mon,  4 Sep 2023 09:21:05 +0000 (UTC)
References: <20230825063932.30875-1-akumar@suse.de>
 <20230825063932.30875-3-akumar@suse.de>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 04 Sep 2023 09:54:29 +0100
Organization: Linux Private Site
In-reply-to: <20230825063932.30875-3-akumar@suse.de>
Message-ID: <87ttsafg5d.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] syscalls/mmap13: Rewrite the test using new
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
>  testcases/kernel/syscalls/mmap/mmap13.c | 174 +++++++++---------------
>  1 file changed, 65 insertions(+), 109 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap13.c b/testcases/kernel/syscalls/mmap/mmap13.c
> index c5a2058e9..5e18f24fe 100644
> --- a/testcases/kernel/syscalls/mmap/mmap13.c
> +++ b/testcases/kernel/syscalls/mmap/mmap13.c
> @@ -1,142 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> + * Verify that, mmap() call succeeds to create a file mapping with length
> + * argument greater than the file size but any attempt to reference the
> + * memory region which does not correspond to the file causes SIGBUS signal.
>   *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -
> -/*
> - * Test Description:
> - *  Verify error signal SIGBUS.
> - *  "Attempted access to a portion of the buffer that does not correspond
> - *   to the file."
> + *                  mmap(0, 8192, prot, MAP_FILE | MAP_SHARED, fd, 0);
>   *
> - * Expected Result:
> - *  mmap() should succeed returning the address of the mapped region,
> - *  and an attempt to access the memory which does not correspond to the file
> - *  should rise the signal SIGBUS.
> + *  byte offset:    0        2047 2048    4095 4096                8191 8192
> + *                  +------------+------------+------------------------+
> + *  Memory          |            |  remainder |                        |
> + *  region          |            | of page(0s)|                        |
> + *                  +------------+------------+------------------------+
> + *                  |<---------->|<---------->|<---------------------->|<--------------->
> + *                  | accessible,| accessible,        references            references
> + *                  |   mapped   | not mapped        yield SIGBUS          yield SIGSEGV
> + *                  |  to file   |  to file
> + *                  |            |
> + *                  +------------+
> + *  Mapped file     |            |
> + * (2048 bytes)     |            |
> + *                  +------------+
> + *  file offset:    0         2047

Nice diagram! The byte offsets are only valid for 4Kb pages though.

>   */
> -#include <stdio.h>
> +
>  #include <stdlib.h>
> -#include <sys/types.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <string.h>
> -#include <signal.h>
> -#include <sys/stat.h>
> -#include <sys/mman.h>
>  #include <setjmp.h>
> -
> -#include "test.h"
> +#include "tst_test.h"
>  
>  #define TEMPFILE	"mmapfile"
> -
> -char *TCID = "mmap13";
> -int TST_TOTAL = 1;
> -
>  static size_t page_sz;
>  static char *addr;
> -static int fildes;
> +static int fd;
>  static volatile sig_atomic_t pass;
>  static sigjmp_buf env;
>  
> -static void setup(void);
> -static void cleanup(void);
> -static void sig_handler(int sig);
> -
> -int main(int argc, char *argv[])
> +static void sig_handler(int sig)
>  {
> -	int lc;
> -	char *ch;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		addr = mmap(NULL, page_sz * 2, PROT_READ | PROT_WRITE,
> -			    MAP_FILE | MAP_SHARED, fildes, 0);
> -
> -		if (addr == MAP_FAILED) {
> -			tst_resm(TFAIL | TERRNO, "mmap() failed on %s",
> -				 TEMPFILE);
> -			continue;
> -		}
> -
> -		if (sigsetjmp(env, 1) == 0) {
> -			ch = addr + page_sz + 1;
> -			*ch = 0;
> -		}
> -
> -		if (pass)
> -			tst_resm(TPASS, "Got SIGBUS "
> -					"as expected");
> -		else
> -			tst_resm(TFAIL, "Invalid access not "
> -						"rise SIGBUS");
> -
> -		if (munmap(addr, page_sz * 2) != 0)
> -			tst_brkm(TFAIL | TERRNO, cleanup,
> -				 "failed to unmap the mmapped pages");
> -
> -		pass = 0;
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	if (sig == SIGBUS) {
> +		pass = 1;
> +		siglongjmp(env, 1);
> +	} else
> +		tst_brk(TBROK, "received an unexpected signal");

To be safe we should exit the signal handler ASAP. It's better to save
the signal details and check them after returning.

The rest looks good, but setting to changes requested.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
