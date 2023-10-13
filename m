Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00F0CDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:25:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2557A3CD433
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 11:25:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECEEA3C8716
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 11:24:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CB1A56008D7
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 11:24:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1BB02219B7;
 Fri, 13 Oct 2023 09:24:56 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BC8852CB52;
 Fri, 13 Oct 2023 09:24:55 +0000 (UTC)
References: <20230907100041.22406-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Oct 2023 10:18:02 +0100
Organization: Linux Private Site
In-reply-to: <20230907100041.22406-1-andrea.cervesato@suse.de>
Message-ID: <87ttquyivu.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-0.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:andrea.cervesato@suse.de,
 s:andrea.cervesato@suse.com]
X-Rspamd-Queue-Id: 1BB02219B7
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork05 using new LTP API
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

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/fork/fork05.c | 133 +++++-------------------
>  1 file changed, 28 insertions(+), 105 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fork/fork05.c b/testcases/kernel/syscalls/fork/fork05.c
> index 9a99cff1d..bf146d32a 100644
> --- a/testcases/kernel/syscalls/fork/fork05.c
> +++ b/testcases/kernel/syscalls/fork/fork05.c
> @@ -1,44 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
> + * Author: Ulrich Drepper / Nate Straz , Red Hat
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - *    Linux Test Project - Silicon Graphics, Inc.
> - *    TEST IDENTIFIER	: fork05
> - *    EXECUTED BY	: anyone
> - *    TEST TITLE	: Make sure LDT is propagated correctly
> - *    TEST CASE TOTAL	: 1
> - *    CPU TYPES		: i386
> - *    AUTHORS		: Ulrich Drepper
> - *			  Nate Straz
> + * This test verifies that LDT is propagated correctly from parent process to
> + * the child process.
>   *
>   *On Friday, May 2, 2003 at 09:47:00AM MST, Ulrich Drepper wrote:
>   *>Robert Williamson wrote:
> @@ -96,55 +67,22 @@
>   *> Red Hat          `--' drepper at redhat.com   `------------------------
>   *>
>   *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - *
>   */
>  
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
> -{
> -	tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
> -}
> -
> -int main(void)
> +static void run(void)
>  {
>  	struct modify_ldt_ldt_s ldt0;

This doesn't compile on Tumbleweed because you removed
modify_ldt_ldt_s. Is this part of a header that I'm missing?

In any case setting to changes requested because we need a header check
or definition.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
