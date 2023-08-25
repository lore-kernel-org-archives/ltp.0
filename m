Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4824C7EE2C
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 09:25:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46F573CC3AC
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 11:25:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 528BF3CB8A2
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:25:21 +0200 (CEST)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1FB451A010B4
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:25:20 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="108796523"
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; d="scan'208";a="108796523"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 18:25:17 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 74A33DB4BF
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 18:25:10 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id AA5CAC4A15
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 18:25:09 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 337596BEF1;
 Fri, 25 Aug 2023 18:25:09 +0900 (JST)
Message-ID: <9fb93c08-9a0b-e3d1-8dbb-fa973b255aab@fujitsu.com>
Date: Fri, 25 Aug 2023 17:25:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <1692875424-22449-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692875424-22449-2-git-send-email-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <1692875424-22449-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27834.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27834.006
X-TMASE-Result: 10--12.515900-10.000000
X-TMASE-MatchedRID: qeYWT+AUEkGPvrMjLFD6eDBgCmbnj9Jmyi3S0YyyoadWjSWvFszxq18l
 h/2sQnVwF8NKa4AxCmDMau1T20usruCnSW1s2x7bzYK5U+QI3O7BOVz0Jwcxl0fyM5VfgjG209D
 6Rw2zIrMq+09NPp8j3SH2yLFsniSlk0XqNqzb6vh85pjA/x1xfvNkoMDX+kiuMAGHatVU16MGAb
 cZ1AtKMK267pjFKBP/fAF/IvTqMoA8HZsl9oOV8L0dPFETpBAHczQnRrpmbEmbKItl61J/ycnjL
 TA/UDoAoTCA5Efyn8C3ApS8cfJcZd0H8LFZNFG7bkV4e2xSge7Xej8GhohJ08uN0cD79mHMUgMW
 etcSVE/jaQZXq6nk6pRMZUCEHkRt
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/renameat2: Remove renameat2 fallback
 definition
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

Hi Xu,

The same comment as I said on renameat01.c.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

On 2023/8/24 19:10, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/renameat2/renameat2.h     | 35 -------------------
>   .../kernel/syscalls/renameat2/renameat201.c   |  2 +-
>   .../kernel/syscalls/renameat2/renameat202.c   |  2 +-
>   3 files changed, 2 insertions(+), 37 deletions(-)
>   delete mode 100644 testcases/kernel/syscalls/renameat2/renameat2.h
> 
> diff --git a/testcases/kernel/syscalls/renameat2/renameat2.h b/testcases/kernel/syscalls/renameat2/renameat2.h
> deleted file mode 100644
> index c4688ed53..000000000
> --- a/testcases/kernel/syscalls/renameat2/renameat2.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/*
> - * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software Foundation,
> - * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - */
> -
> -#ifndef RENAMEAT2_H
> -#define RENAMEAT2_H
> -
> -#include <sys/types.h>
> -#include "config.h"
> -#include "lapi/syscalls.h"
> -
> -#if !defined(HAVE_RENAMEAT2)
> -int renameat2(int olddirfd, const char *oldpath, int newdirfd,
> -				const char *newpath, unsigned int flags)
> -{
> -	return tst_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
> -						newpath, flags);
> -}
> -#endif
> -
> -#endif /* RENAMEAT2_H */
> diff --git a/testcases/kernel/syscalls/renameat2/renameat201.c b/testcases/kernel/syscalls/renameat2/renameat201.c
> index 9832b1cdb..ff1747b8d 100644
> --- a/testcases/kernel/syscalls/renameat2/renameat201.c
> +++ b/testcases/kernel/syscalls/renameat2/renameat201.c
> @@ -37,7 +37,7 @@
>   #include "test.h"
>   #include "safe_macros.h"
>   #include "lapi/fcntl.h"
> -#include "renameat2.h"
> +#include <errno.h>
>   
>   #define TEST_DIR "test_dir/"
>   #define TEST_DIR2 "test_dir2/"
> diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
> index 0c1457022..ef3df3e91 100644
> --- a/testcases/kernel/syscalls/renameat2/renameat202.c
> +++ b/testcases/kernel/syscalls/renameat2/renameat202.c
> @@ -26,7 +26,7 @@
>   #include "test.h"
>   #include "safe_macros.h"
>   #include "lapi/fcntl.h"
> -#include "renameat2.h"
> +#include <errno.h>
>   
>   #define TEST_DIR "test_dir/"
>   #define TEST_DIR2 "test_dir2/"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
