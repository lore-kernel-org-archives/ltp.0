Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8AFC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 02:29:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 745103CDDE8
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 03:29:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 907193CB7FF
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 03:29:09 +0100 (CET)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20577600C7D
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 03:29:07 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="128842930"
X-IronPort-AV: E=Sophos;i="6.04,232,1695654000"; d="scan'208";a="128842930"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 11:29:05 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id CA643DF0E9
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:29:02 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 11B13BF3EE
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:29:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 86F43200649E2
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:29:01 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2521B1A0070;
 Tue, 28 Nov 2023 10:29:01 +0800 (CST)
Message-ID: <590411a7-5e5c-dbcc-77ae-edc4ebc7af19@fujitsu.com>
Date: Tue, 28 Nov 2023 10:29:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <20231110100938.210473-1-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20231110100938.210473-1-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.003
X-TMASE-Result: 10--15.364200-10.000000
X-TMASE-MatchedRID: xnGAJ48IopiPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizxM+b8yxBqvA52S
 8eF0t50JLOEx+hvEk7nMau1T20usruCnSW1s2x7bzYK5U+QI3O7BOVz0Jwcxl6vCrG0TnfVUgK6
 qCGa1Z9dsXqCizdUSQ5XYYVAc0dl5R5cR5NdqsNLz+NEGPHHc6qrFemr66cZVA714v+UID5Qi5u
 P1s5rsy0Ie2eoAxM8kdj6sA9HeF1TfyE70fT6mxihvVjkRcuKhaDoOL4gzIqTuUsaVMCjJLV9Rh
 OpAESv01jXE94ENJm58AX8i9OoygDwdmyX2g5XwBApSYI86Y6hr9+Kgn2XgeCrXJXjG9cgi8rf0
 UFZ3+axV4fWYPm9OiPPH7C/OYQhz1dDZHbsJnLOlJdWkFL6KVln4Ir4HFD2TYUdWP7oX6sgx9S4
 q6ri9O+vnwcnUNOs0wVYwUXEGgs2OrUPm9PNUUrrbxxduc6FPTPe1tPWSpl2bKItl61J/ycnjLT
 A/UDoASlnU38LCY8tWRVlrjsKO8LRBUdG6GQu4F70JBot7Y8+OhzOa6g8KrQ6LqP0NgrtWktJeV
 UoYOLAHy+bflAX36uhLGVCAROQyVCYN9nD8ibA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/link03: Remove this case
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

Hi Yang

It looks good to me. ^_^
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

On 2023/11/10 18:09, Yang Xu wrote:
> I've noticed that the test objectives of link03 and link05
> are very similar. Therefore, i think we can simply remove link03.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   runtest/syscalls                          |   1 -
>   testcases/kernel/syscalls/link/.gitignore |   1 -
>   testcases/kernel/syscalls/link/link03.c   | 167 ----------------------
>   3 files changed, 169 deletions(-)
>   delete mode 100644 testcases/kernel/syscalls/link/link03.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 1851752cf..be55f3f87 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -694,7 +694,6 @@ lgetxattr02 lgetxattr02
>   
>   link01 symlink01 -T link01
>   link02 link02
> -link03 link03
>   link04 link04
>   link05 link05
>   link08 link08
> diff --git a/testcases/kernel/syscalls/link/.gitignore b/testcases/kernel/syscalls/link/.gitignore
> index e5d7f1bbc..b2b9db632 100644
> --- a/testcases/kernel/syscalls/link/.gitignore
> +++ b/testcases/kernel/syscalls/link/.gitignore
> @@ -1,5 +1,4 @@
>   /link02
> -/link03
>   /link04
>   /link05
>   /link08
> diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
> deleted file mode 100644
> index 1f45240ae..000000000
> --- a/testcases/kernel/syscalls/link/link03.c
> +++ /dev/null
> @@ -1,167 +0,0 @@
> -/*
> - * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *  AUTHOR		: Richard Logan
> - *  CO-PILOT		: William Roske
> - * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
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
> - */
> -
> - /*
> -  * Tests that link(2) succeds with creating n links.
> -  */
> -
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static void setup(void);
> -static void help(void);
> -static void cleanup(void);
> -
> -char *TCID = "link03";
> -int TST_TOTAL = 2;
> -
> -#define BASENAME	"lkfile"
> -
> -static char fname[255];
> -static int nlinks = 0;
> -static char *links_arg;
> -
> -option_t options[] = {
> -	{"N:", NULL, &links_arg},
> -	{NULL, NULL, NULL}
> -};
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	struct stat buf;
> -	int i, links;
> -	char lname[255];
> -
> -	tst_parse_opts(ac, av, options, &help);
> -
> -	if (links_arg) {
> -		nlinks = atoi(links_arg);
> -
> -		if (nlinks == 0) {
> -			tst_brkm(TBROK, NULL,
> -			         "nlinks is not a positive number");
> -		}
> -
> -		if (nlinks > 1000) {
> -			tst_resm(TINFO,
> -				 "nlinks > 1000 - may get errno:%d (EMLINK)",
> -				 EMLINK);
> -		}
> -	}
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		if (nlinks)
> -			links = nlinks;
> -		else
> -			links = (lc % 90) + 10;
> -
> -		/* Create links - 1 hardlinks so that the st_nlink == links */
> -		for (i = 1; i < links; i++) {
> -			sprintf(lname, "%s%d", fname, i);
> -			TEST(link(fname, lname));
> -
> -			if (TEST_RETURN == -1) {
> -				tst_brkm(TFAIL | TTERRNO, cleanup,
> -					 "link(%s, %s) Failed", fname, lname);
> -			}
> -		}
> -
> -		SAFE_STAT(cleanup, fname, &buf);
> -
> -		if (buf.st_nlink != (nlink_t)links) {
> -			tst_resm(TFAIL, "Wrong number of links for "
> -			         "'%s' have %i, should be %i",
> -				 fname, (int)buf.st_nlink, links);
> -			goto unlink;
> -		}
> -
> -		for (i = 1; i < links; i++) {
> -			sprintf(lname, "%s%d", fname, i);
> -			SAFE_STAT(cleanup, lname, &buf);
> -			if (buf.st_nlink != (nlink_t)links) {
> -				tst_resm(TFAIL,
> -				         "Wrong number of links for "
> -					 "'%s' have %i, should be %i",
> -					 lname, (int)buf.st_nlink, links);
> -				goto unlink;
> -			}
> -		}
> -
> -		tst_resm(TPASS, "link() passed and linkcounts=%d match", links);
> -
> -unlink:
> -		for (i = 1; i < links; i++) {
> -			sprintf(lname, "%s%d", fname, i);
> -			SAFE_UNLINK(cleanup, lname);
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void help(void)
> -{
> -	printf("  -N #links : create #links hard links every iteration\n");
> -}
> -
> -static void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	sprintf(fname, "%s_%d", BASENAME, getpid());
> -	SAFE_TOUCH(cleanup, fname, 0700, NULL);
> -}
> -
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
