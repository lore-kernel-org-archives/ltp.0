Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25A7C433FE
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFEFA3C8FB7
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 10:13:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE6C63C1014
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 10:13:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6AA8520650C
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 10:13:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7ABAD1F389;
 Fri, 17 Dec 2021 09:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639732425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xCNYN7az7fwzmF0L/axc7PjtkC9JlwPQRy1HzeWqrcw=;
 b=V0lcU9BLSsKdMIHi5Y92N/6YmrEFdjHB2hF4SJ+8+KK+84EsB3ykgFI+EcsGFOGmji/VSE
 StuU4oCXI/ykHi3nt4mSvg8wixdFB3ua63+prg05qMNiJFSXfsJartsZfsMjpXYrkVAbcN
 AGQ3xoGK7xioGkNAIPLhexbfXB61l6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639732425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xCNYN7az7fwzmF0L/axc7PjtkC9JlwPQRy1HzeWqrcw=;
 b=fiJvTb0VpmzVog5Pcw5Mr8w17iuZj+9LCuBbPn157VeXFrQYO5hegAfkTZD8nn+HiC5GM8
 SX9AeHkvJhTMc+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5592213DC1;
 Fri, 17 Dec 2021 09:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PX5tE8lUvGEBCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Dec 2021 09:13:45 +0000
Date: Fri, 17 Dec 2021 10:13:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: sujiaxun <sujiaxun@uniontech.com>
Message-ID: <YbxUx8mz7ejCjp7W@pevik>
References: <20211217062637.29720-1-sujiaxun@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217062637.29720-1-sujiaxun@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [v2,
 1/2] syscalls/sched_get_priority_max01: Convert to new
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi sujiaxun,

> +++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
> @@ -1,142 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
FYI You could add your or LTP copyright. Which one you prefer?

> +/*\
> + * [Description]
>   *
> - *    DESCRIPTION
>   *	This is a Phase I test for the sched_get_priority_max(2) system call.

I suggest to change it to
+ * Basic test for the sched_get_priority_max(2) system call.
+ * Obtain different maximum priority scheduling strategies and compare
+ * them with the expected value.

FYI metadata are:
https://github.com/linux-test-project/ltp/releases/download/20210121/metadata.20210121.html
https://github.com/linux-test-project/ltp/releases/download/20210121/metadata.20210121.pdf
You can run make in metadata/ if you're curious what output you do with
[Description]. The output will be in docparse/metadata.html and/or
docparse/metadata.pdf.

> - *	It is intended to provide a limited exposure of the system call.
> - *
> - * 	Setup:
> - * 	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *	 Loop if the proper options are given.
> - * 	  Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *		Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *
> - * 	Cleanup:
> - * 	  Print errno log and/or timing stats if options given
> - *
> - * USAGE:  <for command-line>
> - *  sched_get_priority_max01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f]
> - * 			     [-p]
> - *			where,  -c n : Run n copies concurrently.
> - *				-e   : Turn on errno logging.
> - *				-h   : Show help screen
> - *				-f   : Turn off functional testing
> - *				-i n : Execute test n times.
> - *				-I x : Execute test for x seconds.
> - *				-p   : Pause for SIGUSR1 before starting
> - *				-P x : Pause for x seconds between iterations.
> - *				-t   : Turn on syscall timing.
> - *
> - ****************************************************************/
> + *	Obtain different maximum priority scheduling strategies and compare
> + *	them with the expected value.
> + */

>  #include <errno.h>
>  #include <sched.h>
> -#include "test.h"
> -
> -static void setup();
> -static void cleanup();
> -
> -char *TCID = "sched_get_priority_max01";
> +#include "lapi/syscalls.h"
> +#include "tst_test.h"

> -static struct test_case_t {
> +static struct test_case {
>  	char *desc;
>  	int policy;
>  	int retval;
> -} test_cases[] = {
> -	{
> -	"Test for SCHED_OTHER", SCHED_OTHER, 0}, {
> -	"Test for SCHED_FIFO", SCHED_FIFO, 99}, {
> -	"Test for SCHED_RR", SCHED_RR, 99}
> +} tcases[] = {
> +	{"SCHED_OTHER", SCHED_OTHER, 0},
> +	{"SCHED_FIFO", SCHED_FIFO, 99},
> +	{"SCHED_RR", SCHED_RR, 99}
>  };
FYI if string is the same as constant, you can use macro:

#define POLICY_DESC(x) .desc = #x, .policy = x

static struct test_case {
	char *desc;
	int policy;
	int retval;
} tcases[] = {
	{POLICY_DESC(SCHED_OTHER), 0},
	{POLICY_DESC(SCHED_FIFO), 99},
	{POLICY_DESC(SCHED_RR), 99}
};

Thus if you agree, I'm going to merge with this diff below.

diff --git testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index 8dcf7e3ea6..5058153e36 100644
--- testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -1,14 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) 2021 sujiaxun <sujiaxun@uniontech.com>
  */
 
 /*\
  * [Description]
  *
- *	This is a Phase I test for the sched_get_priority_max(2) system call.
- *	Obtain different maximum priority scheduling strategies and compare
- *	them with the expected value.
+ * Basic test for the sched_get_priority_max(2) system call.
+ *
+ * Obtain different maximum priority scheduling strategies and compare
+ * them with the expected value.
  */
 
 #include <errno.h>
@@ -16,14 +18,16 @@
 #include "lapi/syscalls.h"
 #include "tst_test.h"
 
+#define POLICY_DESC(x) .desc = #x, .policy = x
+
 static struct test_case {
 	char *desc;
 	int policy;
 	int retval;
 } tcases[] = {
-	{"SCHED_OTHER", SCHED_OTHER, 0},
-	{"SCHED_FIFO", SCHED_FIFO, 99},
-	{"SCHED_RR", SCHED_RR, 99}
+	{POLICY_DESC(SCHED_OTHER), 0},
+	{POLICY_DESC(SCHED_FIFO), 99},
+	{POLICY_DESC(SCHED_RR), 99}
 };
 
 static void run_test(unsigned int nr)
@@ -33,11 +37,9 @@ static void run_test(unsigned int nr)
 
 	TST_EXP_VAL(tst_syscall(__NR_sched_get_priority_max, tc->policy),
 			tc->retval, "test for %s", tc->desc);
-
 }
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run_test,
 };
-

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
