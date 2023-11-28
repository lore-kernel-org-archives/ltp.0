Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0042AC07CA9
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 05:21:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 619543CDBFD
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 06:21:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBE603CB78F
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 06:21:16 +0100 (CET)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F25926009D1
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 06:21:14 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="119988842"
X-IronPort-AV: E=Sophos;i="6.04,233,1695654000"; d="scan'208";a="119988842"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 14:21:11 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 61D6ADC879
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:21:09 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 96420BF495
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:21:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 31A2E20074726
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:21:08 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C37FB1A0070;
 Tue, 28 Nov 2023 13:21:07 +0800 (CST)
Message-ID: <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
Date: Tue, 28 Nov 2023 13:21:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.004
X-TMASE-Result: 10--25.585500-10.000000
X-TMASE-MatchedRID: zzYpem6aLMmPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizzop8fmelLj8Czy
 bVqWyY2Nhjf50HClX+Dmn3xyPJAJoqeGKe0RZOknf0z7/ZSLdKi87ZHqp4thL2PZr2NA6vZGzEB
 dkYlGYZTuGpDZdzOQn/2YKiTqCsufQ9tg+p38ZokFabEZiR8vKUj9ELTlgqjYy1q7uLUZ7CRSyy
 rOtXH2NKUsCJxjPhMEeHT8hTaGXLvEHXdj/44LpqncG1vVsfbQnSXAAnfQldL+u8KSqyCTQXuLd
 MlaRil5OO3RVhj3WutdKPihnf99FZLaPACgg26Oz9NRtGUXfn/5UnqVnIHSz4IEht5QlwfXiLDZ
 VbQUpeE1Nxae0aBHq0wVzTytimS1a1Tt4wRPVa08o3fwIs8rQb9cAlQW5YprMAGHatVU16P/7Cp
 WnzSe2zRS+vSTNjzXjOoojJQ7a6ETCsslFbOpzB1kSRHxj+Z5BGvINcfHqhcyiHqxwIX2MZtXhf
 4dcLJZCr+rgpj8cSmMkrRACx129mx8N4YhLO2EF+qQpCWTUjmOVGny5q72hvnGwx36cSE1/+Pg4
 4UeBd5vu+EAUOCx07KTdmoQNdOQ240GxxcfXA2628cXbnOhT+8WvEwKGuGp6EyXNAT/1wqjxYyR
 Ba/qJQPTK4qtAgwIWWZjCFLCEBpGONWF/6P/Cg2V/fR8BQ7CKrauXd3MZDUD/dHyT/Xh7Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] pathconf01: Convert to new API
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

On 2023/11/2 16:05, Yang Xu wrote:
> * Simplify code and description
> * Use TST_macros
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/pathconf/pathconf01.c     | 251 +++---------------
>   1 file changed, 33 insertions(+), 218 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
> index 362bae94f..9b8b99d48 100644
> --- a/testcases/kernel/syscalls/pathconf/pathconf01.c
> +++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
> @@ -1,237 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - *
> + * Copyright (c) Linux Test Project, 2000-2023
> + * Authors: William Roske, Dave Fenner
>    */
> -/* $Id: pathconf01.c,v 1.5 2009/11/02 13:57:17 subrata_modak Exp $ */
> -/**********************************************************
> - *
> - *    OS Test - Silicon Graphics, Inc.
> - *
> - *    TEST IDENTIFIER	: pathconf01
> - *
> - *    EXECUTED BY	: anyone
> - *
> - *    TEST TITLE	: Basic test for pathconf(2)
> - *
> - *    PARENT DOCUMENT	: usctpl01
> - *
> - *    TEST CASE TOTAL	: 6
> - *
> - *    WALL CLOCK TIME	: 1
> - *
> - *    CPU TYPES		: ALL
> - *
> - *    AUTHOR		: William Roske
> - *
> - *    CO-PILOT		: Dave Fenner
> - *
> - *    DATE STARTED	: 03/30/92
> - *
> - *    INITIAL RELEASE	: UNICOS 7.0
> - *
> - *    TEST CASES
> - *
> - *	1.) pathconf(2) returns...(See Description)
> - *
> - *    INPUT SPECIFICATIONS
> - *	The standard options for system call tests are accepted.
> - *	(See the parse_opts(3) man page).
> - *
> - *    OUTPUT SPECIFICATIONS
> - *
> - *    DURATION
> - *	Terminates - with frequency and infinite modes.
> - *
> - *    SIGNALS
> - *	Uses SIGUSR1 to pause before test if option set.
> - *	(See the parse_opts(3) man page).
> - *
> - *    RESOURCES
> - *	None
> - *
> - *    ENVIRONMENTAL NEEDS
> - *      No run-time environmental needs.
> - *
> - *    SPECIAL PROCEDURAL REQUIREMENTS
> - *	None
> - *
> - *    INTERCASE DEPENDENCIES
> - *	None
> - *
> - *    DETAILED DESCRIPTION
> - *	This is a Phase I test for the pathconf(2) system call.  It is intended
> - *	to provide a limited exposure of the system call, for now.  It
> - *	should/will be extended when full functional tests are written for
> - *	pathconf(2).
> - *
> - *	Setup:
> - *	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *	 Loop if the proper options are given.
> - *	  Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *		Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *
> - *	Cleanup:
> - *	  Print errno log and/or timing stats if options given
> - *
> +
> +/*\
> + * [Description]
>    *
> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
> + * Check the basic functionality of the pathconf() system call.
> + */
>   
> -#include <unistd.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> +#include <stdlib.h>
> +#include "tst_test.h"
>   
> -void setup();
> -void cleanup();
> -void help();
> +static char *path;
>   
> -struct pathconf_args {
> -	char *define_tag;
> +static struct tcase {
> +	char *name;
>   	int value;
> -} args[] = {
> -	{
> -	"_PC_LINK_MAX", _PC_LINK_MAX}, {
> -	"_PC_NAME_MAX", _PC_NAME_MAX}, {
> -	"_PC_PATH_MAX", _PC_PATH_MAX}, {
> -	"_PC_PIPE_BUF", _PC_PIPE_BUF}, {
> -	"_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED}, {
> -	"_PC_NO_TRUNC", _PC_NO_TRUNC}, {
> -	NULL, 0}
> +} tcases[] = {
> +	{"_PC_LINK_MAX", _PC_LINK_MAX},
> +	{"_PC_NAME_MAX", _PC_NAME_MAX},
> +	{"_PC_PATH_MAX", _PC_PATH_MAX},
> +	{"_PC_PIPE_BUF", _PC_PIPE_BUF},
> +	{"_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED},
> +	{"_PC_NO_TRUNC", _PC_NO_TRUNC},
> +	{NULL, 0},
Hi Yang,

What is the purpose of the last entry? IMO, it is equal to the first 
entry. Other than that, it looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang
>   };
>   
> -char *TCID = "pathconf01";
> -int TST_TOTAL = ARRAY_SIZE(args);
> -
> -int i;
> -
> -
> -int lflag;
> -char *path;
> -
> -option_t options[] = {
> -	{"l:", &lflag, &path},	/* -l <path to test> */
> -	{NULL, NULL, NULL}
> -};
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -
> -	tst_parse_opts(ac, av, options, &help);
> -
> -	if (!lflag) {
> -		tst_tmpdir();
> -		path = tst_get_tmpdir();
> -	}
> -    /***************************************************************
> -     * perform global setup for test
> -     ***************************************************************/
> -	setup();
> -
> -    /***************************************************************
> -     * check looping state if -c option given
> -     ***************************************************************/
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			errno = -4;
> -
> -			/*
> -			 * Call pathconf(2)
> -			 */
> -			TEST(pathconf(path, args[i].value));
> -
> -			/*
> -			 * A test case can only fail if -1 is returned and the errno
> -			 * was set.  If the errno remains unchanged, the
> -			 * system call did not fail.
> -			 */
> -			if (TEST_RETURN == -1 && errno != -4) {
> -				tst_resm(TFAIL,
> -					 "pathconf(%s, %s) Failed, errno=%d : %s",
> -					 path, args[i].define_tag, TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TPASS,
> -					 "pathconf(%s, %s) returned %ld",
> -					 path, args[i].define_tag,
> -					 TEST_RETURN);
> -			}
> -		}
> -	}
> -
> -    /***************************************************************
> -     * cleanup and exit
> -     ***************************************************************/
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> +static void verify_pathconf(unsigned int i)
>   {
> +	struct tcase *tc = &tcases[i];
>   
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	path = tst_get_tmpdir();
>   
> -	TEST_PAUSE;
> +	TST_EXP_POSITIVE(pathconf(path, tc->value),
> +			 "pathconf(%s, %s)", path, tc->name);
>   }
>   
> -/***************************************************************
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - ***************************************************************/
>   void cleanup(void)
>   {
> -	if (!lflag) {
> -		tst_rmdir();
> -		free(path);
> -	}
> +	free(path);
>   }
>   
> -/***************************************************************
> - * help
> - ***************************************************************/
> -void help(void)
> -{
> -	printf("  -l path a path to test with pathconf(2) (def: /tmp)\n");
> -}
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test = verify_pathconf,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.cleanup = cleanup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
