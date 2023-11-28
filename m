Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769E9C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 06:28:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 135753CD985
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 07:28:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 422CF3CB7FF
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:28:00 +0100 (CET)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 265B5600F92
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:27:58 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="120569179"
X-IronPort-AV: E=Sophos;i="6.04,233,1695654000"; d="scan'208";a="120569179"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 15:27:55 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2051CD9D93
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:27:53 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 59D23BF49D
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:27:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E00C36BEE9
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:27:51 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 622DB1A0070;
 Tue, 28 Nov 2023 14:27:51 +0800 (CST)
Message-ID: <f4ef2685-0ea6-7b35-d6e3-b4d3088600af@fujitsu.com>
Date: Tue, 28 Nov 2023 14:27:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <1697698029-31949-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <1697698029-31949-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.005
X-TMASE-Result: 10--15.074300-10.000000
X-TMASE-MatchedRID: mZljRXDwq+6PvrMjLFD6eJTQgFTHgkhZ9mojSc/N3QdlEv6AItKWFzxT
 JjE+nPo2hjf50HClX+Dmn3xyPJAJoh2P280ZiGmRtw+xHnsmQjNfT3wDt+vdV/+aPQT1cxlGqbs
 +nJ/tFJF05yZ49kHVQZGh6lCCL6zynuCGum6P72L/V0SDC1Do0Jki3iIBA3o/uzdiHYg4JjPIvx
 Q0mBiP0KbF/OIYMbaa/Sj/WnCM/LNNfs8n85Te8oMbH85DUZXyxI7yGrET2VYOsECO9s+GHnQdJ
 7XfU86eOwBXM346/+wElpAkxDY4P61TMGgQseGj1aee+bfcr9nvoHGvF/fYUcjFneuk30ZF
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapon02: Simplify code, add copyright,
 modify docparse
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

On 2023/10/19 14:47, Yang Xu wrote:
> Simplify permission-related test code, making structures look simpler
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/swapon/swapon02.c | 57 +++++++--------------
>   1 file changed, 18 insertions(+), 39 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
> index d34c17a80..2c9e39986 100644
> --- a/testcases/kernel/syscalls/swapon/swapon02.c
> +++ b/testcases/kernel/syscalls/swapon/swapon02.c
> @@ -1,17 +1,17 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
> -
>   /*
>    * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> + * Copyright (c) Linux Test Project, 2003-2023
>    */
>   
>   /*\
>    * [Description]
>    *
>    * This test case checks whether swapon(2) system call returns
> - *  1. ENOENT when the path does not exist
> - *  2. EINVAL when the path exists but is invalid
> - *  3. EPERM when user is not a superuser
> - *  4. EBUSY when the specified path is already being used as a swap area
> + * - ENOENT when the path does not exist.
> + * - EINVAL when the path exists but is invalid.
> + * - EPERM when user is not a superuser.
> + * - EBUSY when the specified path is already being used as a swap area.
>    */
>   
>   #include <errno.h>
> @@ -21,36 +21,20 @@
>   #include "lapi/syscalls.h"
>   #include "libswap.h"
>   
> -static void setup01(void);
> -static void cleanup01(void);
> -
>   static uid_t nobody_uid;
>   static int do_swapoff;
>   
>   static struct tcase {
>   	char *err_desc;
>   	int exp_errno;
> -	char *exp_errval;
>   	char *path;
> -	void (*setup)(void);
> -	void (*cleanup)(void);
>   } tcases[] = {
> -	{"Path does not exist", ENOENT, "ENOENT", "./doesnotexist", NULL, NULL},
> -	{"Invalid path", EINVAL, "EINVAL", "./notswap", NULL, NULL},
> -	{"Permission denied", EPERM, "EPERM", "./swapfile01", setup01, cleanup01},
> -	{"File already used", EBUSY, "EBUSY", "./alreadyused", NULL, NULL},
> +	{"Path does not exist", ENOENT, "./doesnotexist"},
> +	{"Invalid path", EINVAL, "./notswap"},
> +	{"Permission denied", EPERM, "./swapfile01"},
> +	{"File already used", EBUSY, "./alreadyused"},
>   };
>   
> -static void setup01(void)
> -{
> -	SAFE_SETEUID(nobody_uid);
> -}
> -
> -static void cleanup01(void)
> -{
> -	SAFE_SETEUID(0);
> -}
> -
>   static void setup(void)
>   {
>   	struct passwd *nobody;
> @@ -79,24 +63,19 @@ void cleanup(void)

Hi Yang

It looks good to me. one minor hint:
static void cleanup() should be better.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

>   static void verify_swapon(unsigned int i)
>   {
>   	struct tcase *tc = tcases + i;
> -	if (tc->setup)
> -		tc->setup();
> +	if (tc->exp_errno == EPERM)
> +		SAFE_SETEUID(nobody_uid);
>   
> -	TEST(tst_syscall(__NR_swapon, tc->path, 0));
> +	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, 0), tc->exp_errno,
> +		     "swapon(2) fail with %s", tc->err_desc);
>   
> -	if (tc->cleanup)
> -		tc->cleanup();
> +	if (tc->exp_errno == EPERM)
> +		SAFE_SETEUID(0);
>   
> -	if (TST_RET == -1 && TST_ERR == tc->exp_errno) {
> -		tst_res(TPASS, "swapon(2) expected failure;"
> -			 " Got errno - %s : %s",
> -			 tc->exp_errval, tc->err_desc);
> -		return;
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "swapon(2) failed unexpectedly, expected: %s",
> +			tst_strerrno(tc->exp_errno));
>   	}
> -
> -	tst_res(TFAIL, "swapon(2) failed to produce expected error:"
> -	         " %d, errno: %s and got %d.", tc->exp_errno,
> -	         tc->exp_errval, TST_ERR);
>   }
>   
>   static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
