Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A552C001DE
	for <ltp@archiver.kernel.org>; Mon, 31 Jul 2023 11:52:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 515BD3CDD9F
	for <ltp@archiver.kernel.org>; Mon, 31 Jul 2023 13:52:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 100E33C2FB7
 for <ltp@lists.linux.it>; Mon, 31 Jul 2023 13:51:57 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3513B1400B63
 for <ltp@lists.linux.it>; Mon, 31 Jul 2023 13:51:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMggWGDCBDloO5ZpSdgWVk5nwKEGJUTFWd+eVW2IahB0uG1X3cgDUqK9HmK//syBifmTnK4XvHiWlotxMI4AVIsa01GCkQ3Pa8anoxPH35ks5sLE9ZOTrZ2gLeYNu5NJVAMJBK/vIDi7gmPUF8SCaZujCWmez9NkCYu7+fNXvIlhru9HZ0J8qFIeJC55BJnO+a246TAo+NrXikIbvuj0XseadPjZC5mZg7ALqibtWz5uz84/YACk6DS6FsU8i44FNrIirS5Flgelj2QOMr5C07zztn+rIRq/c6Ce71UBmfNcSXxkEGMupeaUDbDS5QeOhxzNKQh/kxhjFPKyZ0gUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoIrDtw7/oYQTl7VmRkWzrqEzFfj5fzLLXWY28Feago=;
 b=G2yE0nZyB+wJ/cMxUPzcKIuD2NZftXHwvXkZlxXrURmNDeYn/Uy4H24pvOBAnQ7U932RZC1OB0qjm1CSmZgU3petnl9wFJIO4ioM+632+4NJjVr5Dy0qTprGDklzp0oog+SfQuobFTe96DrDMUWQSRSBQMzuEtX34obLFMxejk1+7NsxZOzKX/snnuz6YZjDwkV4Wettz2aw8dxAoFVt4vtRjXJFdl/Siim0HdxhO4omAUqXjB6A8sJLJtjjiqSVRdSNWNmo3mBfTmk8JGlqX26ISbkUL8s+LfTz4nYQU3ys++JR+jAo/QSC5fTnvXUV/L9TEfTKoD/ZM4xvrOyXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoIrDtw7/oYQTl7VmRkWzrqEzFfj5fzLLXWY28Feago=;
 b=vF3MYz0k9xjUHq3rx8UuueefSgBSl5DUIGRO/euFMzdHTUg77PLbJgk3fNjfECtAGDmpiJTAU+tGWqRpJGWx4MUs3bMyKYLyONF5bhIG4Gx0367G+sxiG2hEfccu+IRG/FPDIFzLwwtqdDYi7ioiQYCEp2UFX3aBHMzu+hZ9XukrwVWejl7gjx7UL/NL5FFKDLlsWWKpbXS7RsHaeNr5hkgrNBQnsKGnQXo1vlUOJ/Jk7NQdHnBL0XIN+cpWzpDIbxUrWSSthc4N/HZ9kgZgx3GAvBOtY5ek/NeGzqv6AMpyBw3HzxSCYmc7RmfS5sqz+975YZqtIgYZpiP3QLu7hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB8PR04MB6844.eurprd04.prod.outlook.com (2603:10a6:10:112::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 11:51:54 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5e4:f46b:4d4c:f8fb]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5e4:f46b:4d4c:f8fb%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:51:54 +0000
Message-ID: <11efb31e-9f35-403a-bc53-9b0c7f753be4@suse.com>
Date: Mon, 31 Jul 2023 13:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230731114931.13656-1-andrea.cervesato@suse.de>
In-Reply-To: <20230731114931.13656-1-andrea.cervesato@suse.de>
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: f52e8306-893b-4591-e3ca-08db91bc88f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaYG8r0PJDp6N+3/JxzDzAZKyedJ70ItV8DJqoTjGwjemoCMougx+sp27VzS/74sok/uZ7rwhOM/bmYDLK3DrdyCDCi5K0W8KDoWcom44zLv1cdNL5IOXLXCAmYL/jLmgqZvyMx6lIwrPQmpzSeuGQxBbb9AdgbcezlyfuAaL0r1W7kzqMdE5ZtbFd9C0bGxhy5gGoWavja34pWC/aFEjqnsxsFm/M15ZIpiG+kyP1G4exLZGFF95DtDqi5dpH2/8GRLtszkr2rsYqK0Qc/8iu+ykA+gS2Gv2e27LtJNIFhgcwhlVy7xKGOhC+wgvqTdecLeMLqtoBK8AFuVtFL3d2zA8YWIExNXjcos+4AaC+Ijw+uYJ9BZ77nkxSzT4uBEk8yTX5Q+bCmy9XCo1KijaIxsJ5Xz+r/hIeqAXMtf6SX6nWf0zTU/NnYhuLF/wKZS+3/9SoXnK7Ps1QfOhv8C2i7j9C04oCFZ/yxK9HqWGhCjYHESvU0udKpvhjTCk1YpN0I6ziBimm2dbsZgBMchcRaFe/tDlbo7xUewdWkZyWmLCraRMDOxLNULH8sOZpj1HG8YGr7WxWtk6I+hihbenXD6BDQP9Ek5lOkcHaAZhDScbHDpiCVTmYFvkuYcvnLhfPGFt1nPUFy6o8QaDZ4nui7rypJYXiixLpJkW1oTD5MWD9h5LDcE+3fa1WA9NaTq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(5660300002)(2616005)(6506007)(53546011)(8936002)(8676002)(186003)(26005)(44832011)(83380400001)(316002)(478600001)(6916009)(66476007)(66946007)(66556008)(6666004)(6486002)(6512007)(41300700001)(86362001)(31696002)(36756003)(2906002)(30864003)(38100700002)(31686004)(2004002)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R21UTlpCVEFKUEd1RnNVMUxJeHVPd2VOR1hIdEdteE1kNHRkM2hRM0MzeWtL?=
 =?utf-8?B?QzFSVFRSUWpNTWxkL0puVENVdUl6Tk1aYlg5RE1pcWZwaGtFaUFtcS9Yb0FF?=
 =?utf-8?B?dS85SmlCcGZ6a1JaaXRLSXhUZ0lRSTI4SDRrMVFVK3VGLzl4UGU0aFJ0OFRM?=
 =?utf-8?B?UjA2cTlqSmJPT1U5RWYyb3F5TTEwUWJZUi9iL2kzcmtJblJIYzZSUE9pVnlJ?=
 =?utf-8?B?N2lnczBvT085QkZnd3BFSzdjYUVPN3dRNVJmUEdwVFY3Mm9tUGtKNU4wMEtL?=
 =?utf-8?B?eDZHYUlONlA2bkpTdldsTWx5a3UyRnlTVmZZV0x6Ykx6QWRKN2xsZVphalZR?=
 =?utf-8?B?dVBrWEx4blVkQXpzTTBWN3RXZENYcUE2MHR1OS96aDJFVHowWnNYelNweFJJ?=
 =?utf-8?B?LytpNHhici92ZjZtVTlrcTUyaEpwMFZ0UG5nSWVaeGIzVEJ2QzV6SjhBY2xW?=
 =?utf-8?B?aWlFREgvSUFjWnY5RWw4OUNSZlE4cEI5M2VmK01OaFB1dUlEcEtwUGRKRXM5?=
 =?utf-8?B?a0hqZVhZSmlib0tqQ1R0WXhvUGJ6VGM4TXcyUDliVHJsbkdvd1U5MHgzUGVB?=
 =?utf-8?B?aHZyNWdBMEdNOGVBMlBrU0ltbVFrZGRLdHZmR0hORGdGVGhPRUZLTm1VbERN?=
 =?utf-8?B?K29Oc3ZvdmZVNUZzNjlBM051WlZTck9CbzM3WFFTd3dRVWJLL3ZsU21sZEcw?=
 =?utf-8?B?WlVHQ1djb3prQngvR1lEdmNWNUtsai9kMGwvUXpYb1hxdUN1bEExd1hhZ25F?=
 =?utf-8?B?OHZoZDAyOEpXMVJabldHWHZSTzA4U3lJdHUwSHRIVkNxTEV1OXRORmYzc2Ir?=
 =?utf-8?B?Um1DT3FHSnVGYmoyRTVFY3VDYlgwRWhoRHphRGpjQzVFMVd2L3BmVkpRNmFa?=
 =?utf-8?B?SlAyUVhGZTRWR2lmYlpENW5lWUhIdlUwL0RXLzB6dVdXUWkwVXlDYWZyZlVF?=
 =?utf-8?B?Z08wSnNzNlczenhHK1FnOVkyT3pOQUw2SmtDQVoyMVZQbHQxM1FwRVBvRi9z?=
 =?utf-8?B?NWxabi84QmlRWWc5N25WU2xGU0tudkNZbE5DdGVnMGtwOWhaaXJGOW5JekRt?=
 =?utf-8?B?THJaRWo4b0FJQ1ZuQ1gxaytBaDF2bUV0QzhBeHhBc0xWZVYzSkMrZFdHY3JB?=
 =?utf-8?B?bFRwcjRQMmhuUys2aVgrR0pQMUJrREVWaGMrS1NWTVkvNzJiaGdEWVE1Y1J1?=
 =?utf-8?B?TVAxbXYwTEtETjFSaXFQNEhmeldNQzl6RlgwaVVXTzNvVm0yaHhHVEN0bXNN?=
 =?utf-8?B?dUU0M01zQlNHVEJzZVJ6ZmRQc0JxWFhObWU2V2lEL1g4M25rRFZHQzB5NHFG?=
 =?utf-8?B?ZXk1a2tPaDVIVkJHMS9CVHhkREVnTEVmR2x3N0JrSjBjbWZvTUd1a0pXWXpZ?=
 =?utf-8?B?VTlyOWtXY1RCazRXdlBlOTBiNWk3MUtsZXlIblNUVXhyL1p5OXZOL09ZWmRw?=
 =?utf-8?B?U1U0UW5DaW1ZSkQ5MStpZ2J4QVd3a1VzSEhXTXFUVm4rSG9qUzFJTUxKOUF4?=
 =?utf-8?B?WkZnaTJMNVpHcm1LUy9QZEJGYW0zSkd4WFh0K01sMEsrOUxrRnRIWFl0V3pP?=
 =?utf-8?B?TXlsREp1MUJuclZJSUkwM2k0M2tzb1ljd0ppQTNkNkpoTDFGZGRCU1JNVncv?=
 =?utf-8?B?YUs0RUc3ZnhMUjBheHgrVkUvazBqN2Y2MFloUytPUnBObEo2UVlPMTlqQlNT?=
 =?utf-8?B?NisxRXZ2NFcyWEJXcXJLelRKdC9zWXoyYXVqMmhrU2VIWkd0cExWY3A3UkZX?=
 =?utf-8?B?S20rZmFYQWphQkRlaU5ENjhsRHM1KzNnK0lYaXhkY2l3cG03aXpuc3NFejA0?=
 =?utf-8?B?OExEYzVUbFRnRENYUThjanlPOVpla1lEdUdKTmRiSFFjbFhmb3htQTVLd01s?=
 =?utf-8?B?WDh3WUltOHNRTGlYQVkzSVRRYzhueFZVZVMvdGFWdHZFaU5NMXRKRkF1dTVv?=
 =?utf-8?B?c2NZeGg5cTd2TUtObk9IMTFUejQ5U1N0UHo0U1gwL3hSYXZJV0pIbS9abmtF?=
 =?utf-8?B?Yk5hUW1udUlVc0s0QytzS3BUMUhpNGxpdFJDenVQNE1kRlB5ZFZ3NnVBNWl5?=
 =?utf-8?B?S2wzS3U2elVwVXZRTWtuaUgyeisya3JtQUY0eU5NVytRaDA3d0pJS3FMVE9j?=
 =?utf-8?B?SlJ4cWpCcVpLeHdsR25SRjhoQlEyeC9TVTNjaDF0ZXZLdThCeit0c081S3NN?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52e8306-893b-4591-e3ca-08db91bc88f3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:51:54.3503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gy8Ic5LvosPQgJ/1zyIz933blIRbl/qUPkXGoHpJmf92rlvdaO/KS1TtVar0miTPeFidsfRu4jzsR1yxX/NR+QDW544TD/+ttZgMG/EbNrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Remove ltp_clone_quick usage from pidns suite
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

there's an error on the name of the patch. The correct name is "[PATCH 
v3] Remove libclone dependency from pidns05 test". Beside that, patch is 
the right one.


On 7/31/23 13:49, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Usage of checkpoints instead of pipe
> Usage of SAFE_* macros
> Removed libclone dependency and replaced with SAFE_CLONE
> Description formatting
>
>   testcases/kernel/containers/pidns/pidns05.c | 286 ++++++--------------
>   1 file changed, 77 insertions(+), 209 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
> index 79e146e36..f48e9e528 100644
> --- a/testcases/kernel/containers/pidns/pidns05.c
> +++ b/testcases/kernel/containers/pidns/pidns05.c
> @@ -1,256 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> -* Copyright (c) International Business Machines Corp., 2007
> -* This program is free software; you can redistribute it and/or modify
> -* it under the terms of the GNU General Public License as published by
> -* the Free Software Foundation; either version 2 of the License, or
> -* (at your option) any later version.
> -* This program is distributed in the hope that it will be useful
> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> -* the GNU General Public License for more details.
> -* You should have received a copy of the GNU General Public License
> -* along with this program; if not, write to the Free Software
> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> -*
> -***************************************************************************
> -*
> -* Assertion:
> -*   a) Create a  container.
> -*   b) Create many levels of child containers inside this container.
> -*   c) Now do kill -9 init , outside of the container.
> -*   d) This should kill all the child containers.
> -*      (containers created at the level below)
> -*
> -* Description:
> -* 1. Parent process clone a process with flag CLONE_NEWPID
> -* 2. The container will recursively loop and creates 4 more containers.
> -* 3. All the container init's  goes into sleep(), waiting to be terminated.
> -* 4. The parent process will kill child[3] by passing SIGKILL
> -* 5. Now parent process, verifies the child containers 4 & 5 are destroyed.
> -* 6. If they are killed then
> -*	Test passed
> -*  else Test failed.
> -*
> -* Test Name: pidns05
> -*
> -* History:
> -*
> -* FLAG DATE		NAME				DESCRIPTION
> -* 31/10/08  Veerendra C <vechandr@in.ibm.com>	Verifies killing of NestedCont's
> -*
> -*******************************************************************************/
> -#define _GNU_SOURCE 1
> + * Copyright (c) Veerendra C <vechandr@in.ibm.com>, 2008
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Clone a process with CLONE_NEWPID flag and create many levels of child
> + * containers. Then kill container init process from parent and check if all
> + * containers have been killed.
> + */
> +
>   #include <sys/wait.h>
> -#include <assert.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <string.h>
> -#include <errno.h>
> -#include "pidns_helper.h"
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
> +#include "lapi/sched.h"
>   
> -#define INIT_PID	1
> -#define CINIT_PID	1
> -#define PARENT_PID	0
>   #define MAX_DEPTH	5
>   
> -char *TCID = "pidns05";
> -int TST_TOTAL = 1;
> -int fd[2];
> +static struct tst_clone_args clone_args = {
> +	.flags = CLONE_NEWPID,
> +	.exit_signal = SIGCHLD
> +};
> +static pid_t pid_max;
>   
> -int max_pid(void)
> +static void child_func(int *level)
>   {
> -	FILE *fp;
> -	int ret;
> +	pid_t cpid, ppid;
> +
> +	cpid = getpid();
> +	ppid = getppid();
> +
> +	TST_EXP_EQ_LI(cpid, 1);
> +	TST_EXP_EQ_LI(ppid, 0);
>   
> -	fp = fopen("/proc/sys/kernel/pid_max", "r");
> -	if (fp != NULL) {
> -		fscanf(fp, "%d", &ret);
> -		fclose(fp);
> -	} else {
> -		tst_resm(TBROK, "Cannot open /proc/sys/kernel/pid_max");
> -		ret = -1;
> +	if (*level >= MAX_DEPTH) {
> +		TST_CHECKPOINT_WAKE(0);
> +		return;
>   	}
> -	return ret;
> +
> +	(*level)++;
> +
> +	if (!SAFE_CLONE(&clone_args)) {
> +		child_func(level);
> +		return;
> +	}
> +
> +	pause();
>   }
>   
> -/* find_cinit_pids() iteratively finds the pid's having same PGID as its parent.
> - * Input parameter - Accepts pointer to pid_t : To copy the pid's matching.
> - * Returns - the number of pids matched.
> -*/
> -int find_cinit_pids(pid_t * pids)
> +static int find_cinit_pids(pid_t *pids)
>   {
> -	int next = 0, pid_max, i;
> +	int i;
> +	int next = 0;
>   	pid_t parentpid, pgid, pgid2;
>   
> -	pid_max = max_pid();
>   	parentpid = getpid();
> -	pgid = getpgid(parentpid);
> +	pgid = SAFE_GETPGID(parentpid);
>   
> -	/* The loop breaks, when the loop counter reaches the parentpid value */
>   	for (i = parentpid + 1; i != parentpid; i++) {
>   		if (i > pid_max)
>   			i = 2;
>   
>   		pgid2 = getpgid(i);
> +
>   		if (pgid2 == pgid) {
>   			pids[next] = i;
>   			next++;
>   		}
>   	}
> +
>   	return next;
>   }
>   
> -/*
> -* create_nested_container() Recursively create MAX_DEPTH nested containers
> -*/
> -int create_nested_container(void *vtest)
> +static void setup(void)
>   {
> -	int exit_val;
> -	int ret, count, *level;
> -	pid_t cpid, ppid;
> -	cpid = getpid();
> -	ppid = getppid();
> -	char mesg[] = "Nested Containers are created";
> -
> -	level = (int *)vtest;
> -	count = *level;
> -
> -	/* Child process closes up read side of pipe */
> -	close(fd[0]);
> -
> -	/* Comparing the values to make sure pidns is created correctly */
> -	if (cpid != CINIT_PID || ppid != PARENT_PID) {
> -		printf("Got unexpected cpid and/or ppid (cpid=%d ppid=%d)\n",
> -		       cpid, ppid);
> -		exit_val = 1;
> -	}
> -	if (count > 1) {
> -		count--;
> -		ret = do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
> -					    create_nested_container,
> -					    (void *)&count);
> -		if (ret == -1) {
> -			printf("clone failed; errno = %d : %s\n",
> -			       ret, strerror(ret));
> -			exit_val = 1;
> -		} else
> -			exit_val = 0;
> -	} else {
> -		/* Sending mesg, 'Nested containers created' through the pipe */
> -		write(fd[1], mesg, (strlen(mesg) + 1));
> -		exit_val = 0;
> -	}
> -
> -	close(fd[1]);
> -	pause();
> -
> -	return exit_val;
> +	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
>   }
>   
> -void kill_nested_containers()
> +static void run(void)
>   {
> -	int orig_count, new_count, status = 0, i;
> -	pid_t pids[MAX_DEPTH];
> +	int i, status, children;
> +	int level = 0;
>   	pid_t pids_new[MAX_DEPTH];
> +	pid_t pids[MAX_DEPTH];
> +	pid_t pid;
>   
> -	orig_count = find_cinit_pids(pids);
> -	kill(pids[MAX_DEPTH - 3], SIGKILL);
> -	sleep(1);
> -
> -	/* After killing child container, getting the New PID list */
> -	new_count = find_cinit_pids(pids_new);
> -
> -	/* Verifying that the child containers were destroyed when parent is killed */
> -	if (orig_count - 2 != new_count)
> -		status = -1;
> -
> -	for (i = 0; i < new_count; i++) {
> -		if (pids[i] != pids_new[i])
> -			status = -1;
> +	pid = SAFE_CLONE(&clone_args);
> +	if (!pid) {
> +		child_func(&level);
> +		return;
>   	}
>   
> -	if (status == 0)
> -		tst_resm(TPASS, "The number of containers killed are %d",
> -			 orig_count - new_count);
> -	else
> -		tst_resm(TFAIL, "Failed to kill the sub-containers of "
> -			 "the container %d", pids[MAX_DEPTH - 3]);
> +	TST_CHECKPOINT_WAIT(0);
>   
> -	/* Loops through the containers created to exit from sleep() */
> -	for (i = 0; i < MAX_DEPTH; i++) {
> -		kill(pids[i], SIGKILL);
> -		waitpid(pids[i], &status, 0);
> -	}
> -}
> +	TST_EXP_POSITIVE(find_cinit_pids(pids));
>   
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newpid();
> -}
> +	SAFE_KILL(pid, SIGKILL);
> +	SAFE_WAITPID(0, &status, 0);
>   
> -int main(void)
> -{
> -	int ret, nbytes, status;
> -	char readbuffer[80];
> -	pid_t pid, pgid;
> -	int count = MAX_DEPTH;
> +	children = find_cinit_pids(pids_new);
>   
> -	setup();
> +	if (children > 0) {
> +		tst_res(TFAIL, "%d children left after sending SIGKILL", children);
>   
> -	/*
> -	 * XXX (garrcoop): why in the hell is this fork-wait written this way?
> -	 * This doesn't add up with the pattern used for the rest of the tests,
> -	 * so I'm pretty damn sure this test is written incorrectly.
> -	 */
> -	pid = fork();
> -	if (pid == -1) {
> -		tst_brkm(TBROK | TERRNO, NULL, "fork failed");
> -	} else if (pid != 0) {
> -		/*
> -		 * NOTE: use waitpid so that we know we're waiting for the
> -		 * _top-level_ child instead of a spawned subcontainer.
> -		 *
> -		 * XXX (garrcoop): Might want to mask SIGCHLD in the top-level
> -		 * child too, or not *shrugs*.
> -		 */
> -		if (waitpid(pid, &status, 0) == -1) {
> -			perror("wait failed");
> +		for (i = 0; i < MAX_DEPTH; i++) {
> +			kill(pids[i], SIGKILL);
> +			waitpid(pids[i], &status, 0);
>   		}
> -		if (WIFEXITED(status))
> -			exit(WEXITSTATUS(status));
> -		else
> -			exit(status);
> -	}
>   
> -	/* To make all the containers share the same PGID as its parent */
> -	setpgid(0, 0);
> -
> -	pid = getpid();
> -	pgid = getpgid(pid);
> -	SAFE_PIPE(NULL, fd);
> -
> -	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
> -				   create_nested_container, (void *)&count));
> -	if (TEST_RETURN == -1) {
> -		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
> +		return;
>   	}
>   
> -	close(fd[1]);
> -	/* Waiting for the MAX_DEPTH number of containers to be created */
> -	nbytes = read(fd[0], readbuffer, sizeof(readbuffer));
> -	close(fd[0]);
> -	if (nbytes > 0)
> -		tst_resm(TINFO, " %d %s", MAX_DEPTH, readbuffer);
> -	else
> -		tst_brkm(TFAIL, NULL, "unable to create %d containers",
> -			 MAX_DEPTH);
> -
> -	/* Kill the container created */
> -	kill_nested_containers();
> -
> -	tst_exit();
> +	tst_res(TPASS, "No children left after sending SIGKILL to the first child");
>   }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +	.forks_child = 1,
> +};

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
