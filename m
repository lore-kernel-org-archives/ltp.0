Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26406E7D0B7
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 00:00:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11E1A3CE3C0
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 02:00:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B2843CB576
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 02:00:42 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1E94E602F7C
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 02:00:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRGU5+tbbv2eJZl0QEtv63NtX36QxXUKZ4wRfbELhRbUVbAKN0OqFWPNML2O/rPUdXEpi+mVV/0Am2XWw6Gss0swVfnNLRZouYdZGuYyEB+yBfoQKGm8dhc6S/6j/Lqqzck+oKwhIR5Q/32RIdC9PHJPOfqA4ON8hFL0nGtcYM9RLHis1+Snsqnbp1F5IN+KuvFWVX+jdxYaQn9C9v0ZenY1ZJ0bvRcPllB80XRNocjYtPGQsJ8VyOWzPLB8CCpLBrv/T/Jw64PEW4CI6fyq/0jUXEZlm2Zbh7e2xYHIxuZockWhItbBoNZ0uAPy1ewnuBhmK1nj6rcv3QsTbJpTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2Fh0kCAoi37G8UHNHe+9kyKCUqzr5eXULtEJuiCYpA=;
 b=liCjO5Cpz8hHG91iRoGF3/Iy45xoSOuOormtXeA6s8sPOYzXUzE92b12biM+W6tCzILYfBcbRBKIM2E8xgI3RY0mfLt1hXXZ3sM5G9LWJyquJD/s1kRhXvI8RRO1xWWTkMcVTgkzaFJcD4cXZWTcRmN3tRLkvtkCsbDf2RSauJUi+rVBK6H2iXHsqf1NVxG631zIaV9rlqf0gj/jsWmy+kgdfLh2A9qgWYzD5QSWfg8VszPP7ZfTnC/E5lpWrAHCMByxdmed1kwi1Y2UrUsCpLPZGPqJXFCzAx5cfjOuQkzBo/IlSfxUPvzzURj4RKcM1U//GdyHtsn1ZUr2ZdjPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2Fh0kCAoi37G8UHNHe+9kyKCUqzr5eXULtEJuiCYpA=;
 b=YrVWaYoFN4inqMkPEHyPql34TzDPPL86lnjczMgYyUnPOmDfmFzIb3jmK2WdVn34BGT6Vfo7QcEKhFay8LFJquEIXpZiYOXbluy0Pvx9MfISVamRSUoqHa7pnQDHMTbgbTWQn9MOk1G6qFtwrXuJfnfFBf7XcdbDhiyOAatB1QCRJyGH4CHmz3zDbuYox0pucL0b8EscM05ggfGZlf7U4wrMbvUjZLD80Hvks2w4tb0aMehh/5fl8VQwYAIlPTum7USpHXkMvs6oLo7O9kN7Pgcc0qagcL96y3d70tUh9+jPgjHwPEnUxEBMFCMYCkhBzBn1++xBrzRjIXJrjmlU9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 00:00:39 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 00:00:38 +0000
Date: Thu, 21 Sep 2023 20:00:32 -0400
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZQzZIBNGHkj9/4n0@wegao>
References: <20230921090658.11224-1-mkittler@suse.de>
Content-Disposition: inline
In-Reply-To: <20230921090658.11224-1-mkittler@suse.de>
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 690162be-5521-4b87-920c-08dbbafef3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ostzByGteWd7e/gHSvaE8hsBfvZ3EzveLgzldZgCqcX8lnVQg4GiER8V9GfLGRiTLKp61O3CoTVzfH7khd7Aa6r5MHO+abAZN6oYx0tC3tk2RYt3zz2sZQnMFfFZs1s70Kel/8UmTSM3ImMdzpuqNYJSGice4+XHgPB4X3YefLRTZ1bJAtm9YNuwZ6hV2mNMUpi8k2Uk8Nm6gqFQVM+og3KhboQp4QBJ13Ykn7ByrwbH56yJwtNlA86kvAbP3M30OjftcjPg8HO9/wNuhVtLMVlNu/3AFfPreROZsJyoK2YCzlNy43qleY25xKwlqoeUcN+iDZYBZEByDgw0os8atO9PXcakUa4L+xT4mx97h/Iu9n6uLo8rV1oGoufrn2ZriKCqtQUhu5XntOX8hC/CySeNtD3NaaD9BS6bLbYvnEhjwL76PWE5IZ2tdGjUFvhtldEr1eJAqdbms/zT7qiR7sONetQ/WTflDm/LBRmzPhat8Z0Fzu7N2HPKDL1eIcnyX38h5YHR4ld67IfAjOVrSRvm/HXOQ8Ek3VyJ/144iFWUNsZVKYnCJQjxWl55lhTK4fRmmVtmOQ6i7lT+1B9yuMM4JfhComnOhMZ+G/pjsCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(451199024)(186009)(6486002)(6666004)(6512007)(6506007)(9686003)(38100700002)(33716001)(86362001)(26005)(83380400001)(4326008)(6916009)(966005)(8676002)(2906002)(8936002)(41300700001)(66946007)(66476007)(66556008)(5660300002)(316002)(478600001)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/QirG26L6Xdgk9ojH3U9yomU/os/yspWR8I5Cfc2nPLk19mTX0NwD0LTehd8?=
 =?us-ascii?Q?b2hSlVoy0PQcdfzjJOWbpNmjc+v5LN9tuu1OYjcwvgE1ZRSo8pMBylz3ZjhP?=
 =?us-ascii?Q?fUEcRw9nM0kTk9dpSi6+PSED8wxopX/GnNTx/foBDKGE202L33GYr4EL8UKe?=
 =?us-ascii?Q?naMGlxZ/nX7DnMSnNHmL2G+8pgNKTN3O9Ok8j7v3kntrk4GwkGqng61wQoOy?=
 =?us-ascii?Q?bV7i0mrfsPZ/VUjxKkxkHTw2mwBLc4Z2fR5d1u6dYBghzy4cWq0v+5W+R5Mt?=
 =?us-ascii?Q?h7TJ5sqFOU72P2GnUGMWIzK+i9zJpRgKhnJl4vTqLCxz1/qcjHTEj2gPOR3o?=
 =?us-ascii?Q?pi74qNsAzwDCgKkKqTAJ00wfC4jQW6UEwQzN0F+VEyF0F9d0xMvWeHUSa+1h?=
 =?us-ascii?Q?5Dyyub98IKdoiTwHp6MGiddeDKCIFqJTTQQUUphchoJNOaYadtsCqu07Jdya?=
 =?us-ascii?Q?Rt43z9B0Uck4MnR+asTllD4bHwWWD5To9SbOiApy064puprwEypEnFoqAgcx?=
 =?us-ascii?Q?FTTu9HfyRMFQqZu5TnoIzSUGf3n8cr3r9nrizZv/xXiiy54VdW+C9vzIDrXv?=
 =?us-ascii?Q?ZLdfJW3qYtq4sQceaW4pLPFj6Yd1oys+6WtWCziWXiaYROhOSLEy39W4Clgk?=
 =?us-ascii?Q?404NsTScbjfYwja/JLT2Oc+kZj/iLxwBiTwx4SY7nsGSSOBm4nxnPhVESqJ0?=
 =?us-ascii?Q?PlGZ2ZmpxODIHMY6PEYhE9a6m0CHIQj8QI/3fG9tYO0F+evUvFRuUDEb9uLx?=
 =?us-ascii?Q?cDdwV3+a9ZO4St7JQcRvWCTfABzsnOGBnKHoru6dAESm5LzECbZIjzEvm+pm?=
 =?us-ascii?Q?uDmQxSWRJK+2KA9RdQGfoxdJYKWES3vpa6duyLieBskuhbg9tuX7DLC1Apkx?=
 =?us-ascii?Q?U313V3Q/pkpmnZwit57k5kg5jDWlVl5xinjTHQhevX+PHKxXxUMi/5bArKkT?=
 =?us-ascii?Q?+ylJykePcChZ4Ep52RnISVdgj2SwA0Datlplk5aAghSt4F/+7PznAsXTvyss?=
 =?us-ascii?Q?DFeGlNeiUQicIP5IClI3y7vaB4qOYamOIThzZ7e8iBrH6vM9Irf25D3uEI1p?=
 =?us-ascii?Q?tZSPOWD/OxZqIcMdnl8CFdeuEbhRvqEFiFku0OCx3TBZQZI9jVH/L76/ihA8?=
 =?us-ascii?Q?h3JMEFwjLM5iEdk6L0XKHmVKrfr3e97iDPHTOUKOkDPt8O/hrhO5rssqtGwd?=
 =?us-ascii?Q?B9QJsYFtJFh87eHIpT8LgD28OA5bNdfRYFVBSjXy0wsNJ+zopCGrlS7sLRYh?=
 =?us-ascii?Q?WBfVBIHgbJ2ppLSxkD63GSrn7fK7956chEFA/OnzhyESQyKqasTRhd2U4+uf?=
 =?us-ascii?Q?VEdOcCTDzryy6h7jKfNfwr30/JwMtewqtwzXJ884brF+A11dTiQEBGhlmctu?=
 =?us-ascii?Q?mKQsAy1Guz9iAq/Vlznlti2y3L0fgur+zn6szA3XqPu35SfAN3wkLl0rx5gs?=
 =?us-ascii?Q?kBezutmBK16UXFnbdpo+rx53XvSz7ZeOepcmTs9k4Qf/6NyIPIAcKgJO7gCO?=
 =?us-ascii?Q?IHbgkhZ0LWbZedReYLxGeeoeb2VG63R/B2HVyLPUxTwvDcurK7mje4CAdG6u?=
 =?us-ascii?Q?uk725gu8VNf4jQge3fE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690162be-5521-4b87-920c-08dbbafef3a0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 00:00:38.4594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WveB4gUGjguZfj3STLdFovIiWFBopYtRfk75bAdFzEgFNVfm6vqzQOPGIW584Lzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Port getxattr03.c to new test API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Sep 21, 2023 at 11:06:58AM +0200, Marius Kittler wrote:
> * Utilize `all_filesystems = 1`-mechanism to test on various file
>   systems instead of relying on the temporary directory's file system
>   to support xattr (which it probably does not as it is commonly a
>   tmpfs)
> * Simplify code and description
> 
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>  .../kernel/syscalls/getxattr/getxattr03.c     | 133 +++++-------------
>  1 file changed, 38 insertions(+), 95 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
> index b6ea14287..78ec79e5c 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr03.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
> @@ -1,117 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (C) 2012 Red Hat, Inc.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * Copyright (C) 2012  Red Hat, Inc.
> + * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
>   */
>  
> -/*
> - * An empty buffer of size zero can be passed into getxattr(2) to return
> - * the current size of the named extended attribute.
> +/*\
> + * [Description]
> + *
> + * An empty buffer of size zero can be passed into getxattr(2) to
> + * return the current size of the named extended attribute.
>   */
>  
>  #include "config.h"
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/wait.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <signal.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#ifdef HAVE_SYS_XATTR_H
> -# include <sys/xattr.h>
> -#endif
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "getxattr03";
> +#include "tst_test.h"
>  
>  #ifdef HAVE_SYS_XATTR_H
Normally i saw this kind of ifdef in include/lapi/xattr.h 
I suppose we need create include/lapi/xattr.h? 
> +#include <sys/xattr.h>
> +#include "tst_safe_macros.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FNAME MNTPOINT"/getxattr03testfile"
>  #define XATTR_TEST_KEY "user.testkey"
>  #define XATTR_TEST_VALUE "test value"
>  #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
> -#define TESTFILE "getxattr03testfile"
> -
> -static void setup(void);
> -static void cleanup(void);
>  
> -int TST_TOTAL = 1;
> -
> -int main(int argc, char *argv[])
> +static void run(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		TEST(getxattr(TESTFILE, XATTR_TEST_KEY, NULL, 0));
> -
> -		if (TEST_RETURN == XATTR_TEST_VALUE_SIZE)
> -			tst_resm(TPASS, "getxattr(2) returned correct value");
> -		else
> -			tst_resm(TFAIL | TTERRNO, "getxattr(2) failed");
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_VAL(getxattr(FNAME, XATTR_TEST_KEY, NULL, 0),
> +				XATTR_TEST_VALUE_SIZE);
>  }
>  
>  static void setup(void)
>  {
> -	int fd;
> -
> -	tst_require_root();
> -
> -	tst_tmpdir();
> -
>  	/* Test for xattr support and set attr value */
> -	fd = SAFE_CREAT(cleanup, TESTFILE, 0644);
> -	close(fd);
> -
> -	if (setxattr(TESTFILE, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> -		     XATTR_TEST_VALUE_SIZE, XATTR_CREATE) == -1) {
> -		if (errno == ENOTSUP)
> -			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
> -				 "fs mounted without user_xattr option");
> -		else
> -			tst_brkm(TBROK | TERRNO, cleanup, "setxattr %s failed",
> -				 TESTFILE);
> -	}
> -
> -	TEST_PAUSE;
> +	SAFE_TOUCH(FNAME, 0644, NULL);
> +	SAFE_SETXATTR(FNAME, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> +		     XATTR_TEST_VALUE_SIZE, XATTR_CREATE);
>  }
>  
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.all_filesystems = 1,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.skip_filesystems = (const char *const []) {
> +			"exfat",
> +			"tmpfs",
> +			"ramfs",
> +			"nfs",
> +			"vfat",
> +			NULL
> +	},
> +	.setup = setup,
> +	.test_all = run,
> +};
> +
>  #else /* HAVE_SYS_XATTR_H */
> -int main(int argc, char *argv[])
> -{
> -	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
> -}
> +TST_TEST_TCONF("System doesn't have <sys/xattr.h>");
>  #endif
> -- 
> 2.42.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
