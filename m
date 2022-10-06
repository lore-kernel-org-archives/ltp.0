Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31164C433FE
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 11:12:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B61C3CAA78
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 13:12:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B0A03C08D9
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 13:11:54 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 03F10140134A
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 13:11:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogIezLuUXKRwWmnhXWgXNV98xpr5AEacgTQc84R+lU2qRym7uEbZNC6MhxfSihCpIFZaBQxUTRRWKgebnpD+4CeEZgBi/ncBIKvMqg/lXPD7fIbw3f+ye8KAQZjgvFq2XGOc8DQTZxVVpLo23S00kIFsdL/QEA+VJ2+QMmKFwdkJMoMwhSgZAmArq63YnkHx694JLX7rGtyskadjRcYdlAutd5DwXzBgKFlG2D2jWz1cA+ULGGvgDdFM2LYsmiN3D33jujiY33EIg8LWbNyTsyzVNluGo+loZOI+d39UV/1b85EeJNIncHWPYQZXclqhH1WSXcCPbWQtxYVXRG8NLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+qrvTVO4/wmZ7y3qEbWEiA8q50rx+s05Rdeodg10Tg=;
 b=n7E36HwKI/rhhZRS3shoq2+r2LT2JR4ri/OmiGL349yxridAglux80JHV5nED3F6M+lgOPb2Zf5t3EU9g/8RVCTgM2b2ZYjR277D/mRE5QOGnq9yguOIABjoqFW+Qeuv3HrUUhP01CfX9D3pOiCNStat8t1r3wAdxdbY2sZAMJSwjAu7EEgQgOCSUKHDGNPjzwFZYwTV8HejeYly9PHQrkOh51rM18VIVeMNnI41Af5SERBTPnzSZVelYkzunMmqUJGymm2b5E1WjzF4YDzXgizxM1+g90Ypb6FQONZTZQ/QK+7jqE0LAcpaTM0BwpDBQm4roTTjhQQ5eBA6kkDLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+qrvTVO4/wmZ7y3qEbWEiA8q50rx+s05Rdeodg10Tg=;
 b=ZiU7A0fyGOgj3iu5NbEkC2BltJ2JbOudp919YwrVkHl1DcVpAn2Uf2iDDbOASiw6R/0cewb3+vuPv6VZNizEWnHUeQ9/4WpF6UxoicazLMJR2yGoRZLOENpiNxz+Ltr2WXaZJMxm+qHJBgmNf9zpR/f+Go3kS8LBWefytlfJPyp3lx5ZDjJRX+CfJhmbAJQRSTUjzqd24ESscwzVdZNGEvW3Z7GfmOulc+lnlNbf5VtD+G3/v4E3NKnYXgSAqkaVorrlrWzpSCNSSW+SR2AqY/QEZZuBttCNcUp0K5DqRy8iEyCF4GNYZ0vrKdvYq3PHvW+1eiHx3Htxj0uDz8uqQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DU2PR04MB8519.eurprd04.prod.outlook.com (2603:10a6:10:2d2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 11:11:49 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399%6]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 11:11:49 +0000
Message-ID: <9208e6f8-0dd3-3cc2-49b5-b9bba305d57d@suse.com>
Date: Thu, 6 Oct 2022 13:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: ltp@lists.linux.it
References: <20221006110642.12410-1-andrea.cervesato@suse.com>
 <20221006110642.12410-3-andrea.cervesato@suse.com>
Content-Language: en-US
In-Reply-To: <20221006110642.12410-3-andrea.cervesato@suse.com>
X-ClientProxiedBy: AS9PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DU2PR04MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2973df-3179-43f9-c3c5-08daa78b9084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeMlxvLc6tafl/f9PskP4cMwMOZLQLuGjFIkhvsj0n9tcOg/pvo+dBMKIrScv9z0/yYVQKFSsw//cmlTYL/XTUVNcgHhx2q2yUdf5qBWulsH4NRtpLryTEah/jHk/2WBXqib82GAwN+SRUx13kWD0YlEe7Qu4d5CyY/KNhgLWNMxVgq9zq4q+yvs3wV4Bd0QZCJpwvwFzYfHWuLfjyZbzUR2IEXksi843qRQ63LvS2rxqbQuqjnITs+esHBISXb9TxhjZyxxLEIYNq7wfmwJ5jod9sJKsMr5SsYNULdQSSf+Em5DBIiRShQmV+TpPqpZxhTgOzW9CwkLenA3OeGS56RXhgbj+L09MvM4MdAfatheS09CTXE3/UxChkY5aIPds5y456UGvKN3gCRksmnJ3wODpZejDNyLbJd+X5pF4M+qsTarXEMNJTIQCoIp/rL7PvKoU0Z5A8IgguTUiPHWCEYz7saxElmHWT3FsTJykgwislfr/KaOB1Ib8hV1/DyUevhNVQkkjMggGPz7FlzF8NXD4Nwj70kEf6oFYChBwWqPG3m4FYo5vjiT6ul9gUibpilX0Bs31Jq7QnxNz3n7fYn3uIWU19QYYZmyOjfUFSA/rZKKiCFP/MYg3u2Xfa1gu07BY5Pg8BuhaN0+1aX1jis4T09wR5xNXDST8RSP4zIAnDSV7Oq4KDCsLSY3xheQZCnfPJ+OaU9hGHZKyuLwKrujIhZ9nyZzkkJ0jz7Ql1OTNg6I/6+H4gbCatCV3LH6o0qV2C4fOMI9+b6uF3d5FzgrFsd5Ia9lYISifwczY7jF1TOaYJ0KQooPnxfWc13a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(53546011)(86362001)(38100700002)(5660300002)(31696002)(8936002)(30864003)(2906002)(44832011)(66946007)(66556008)(66476007)(8676002)(41300700001)(26005)(6512007)(186003)(2616005)(478600001)(6506007)(316002)(6666004)(6486002)(83380400001)(6916009)(31686004)(36756003)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9KZ1hlNE1wTVBqcHFvNXFTMU15RExFYlhPOU1jeDVLNWtIY2x3VU9rUXRp?=
 =?utf-8?B?TmFtRnJ0VFVtTksvQ2JtSENvQTBYYkxsWUpqa1ZrVFhkSzR3V0oyUElNWDNY?=
 =?utf-8?B?VlZVenhDZ0lGTW1HeEtUMjZiWmxqK1BOclJjSzFSZ3lHODh6N0JNRUJSUkw5?=
 =?utf-8?B?MjB0RlN6S1F2ZXZ0T1pUYTRnT0JqRDdKSmNUYXp0cm1ZS2p3QXRPUXNyZ1N5?=
 =?utf-8?B?Uk56eUdUODA3QzFEaGhDM0tpZER3SDF1dEZyT293ZDAxbUhLK2ZWM3Y0Mnhm?=
 =?utf-8?B?R3hidkFXdE1LcWRkMXptQjFyVkR2U3lycE1xa01HQjlIKzBuOW1nMGYwUTJ3?=
 =?utf-8?B?aVhjREtmQmJFUHB3c25kK2svelhjMzZjQjFqdG9UdzVPY3dVWm5mbis0aVJo?=
 =?utf-8?B?UXRxd1V3RnFpUXJjcGlXaVpPaDRkWVlEVjVHa3pvZ1VMYTAwWm5tL2tCTmVa?=
 =?utf-8?B?TVFlai82WFg5bjF6ditnczB0SXprQ0Vvc1MycVU3MWdKYXZPTE5sdUtkUFBI?=
 =?utf-8?B?Y2grMUJIU293bTNLWDhpaUp5M2tUa3JRY0V1UkdLeVNIbndHS251RkprOHEr?=
 =?utf-8?B?R0o4Z0FOV3dmVXBFRTJaYTBjaGNvWXRKdHI0eVBlUENVYjFoZWdPSzRwRGlj?=
 =?utf-8?B?UFRSaXNQaVd3TjI2M0VpL3h2b1pHUlQvQ0tGUTcyUkpzOG5HbDhtcnNFbUFG?=
 =?utf-8?B?alRkM0xwa1RZOUJXd1VKcVYzbG85N0FqNnI4bDd5Tnp3SXphdHpDTVdNdHZq?=
 =?utf-8?B?SG5JUXZoR0xyUEtUVHZhbnRUcjEwUTVqVm5aN0kvaEpkQmtHc05qSk1kVWF1?=
 =?utf-8?B?N21VcWJmaXllb0NDWkhXc3FSclFlMkdKc3l6a2tQMlZyVUJQZmFuZTVVZFRL?=
 =?utf-8?B?QkxOamhnRDlyM3ZtZ0Y1eU1QdmlISnFEQ0FSbEZmS2l2aEo3NG1xVWlreGdF?=
 =?utf-8?B?N3FpZk5jL3VVQXpYb3ZXKzVUNDlZVi9NT3ZEaDhkN0pZM3BpSVh3WVhKS2sr?=
 =?utf-8?B?OG1ZQTFJeUE2dmtFNHE5alFYT2VHbENnb1JsdC9vb2l0Vm4yOFhrcjNsOFlE?=
 =?utf-8?B?UmEyKzlxVjNralczZmRsSi9OSlNGRHpHZEkraXViMVhSRTdKdEQ1a1czYjNm?=
 =?utf-8?B?ZytGT3AyVU5EYm01Z0Vrb2l6Sk1oWUJlQmxFSW5TVDFpUjJiNHJRdktaeDlL?=
 =?utf-8?B?aGd0aERmaDFtN293N2xCMzRGcjc3YnhjM3RqVktnUDdGTWduZkJJMy9kNUQ1?=
 =?utf-8?B?TXFOUmNhNGxIRVdlbjRTamFTdnpCR09Vdm93RjdsZmwzL1VkYVRkMVF2RTFG?=
 =?utf-8?B?NlZYY2xRRUtYRUhnRGR5ZTBkVnVLT0ROaldzTThhcDZsZEVCdXFoTDZ4bkQ1?=
 =?utf-8?B?a005NWRKMTVqTDVERlNNN05lV0hwYnN3Y0JhbEJPZERUOGl0bXN3Z2w0ZGRa?=
 =?utf-8?B?NWNYSy85c0xobjNQNXpZaS9CZ21wS1p3N3MrMFhLdStvNU1Jc0dHNjRKQTZX?=
 =?utf-8?B?djJGNTNzQnJBcm9LSURxV1lXb0d2eTNsMStuVEhmS1UxWGI3TytDN3psaXRG?=
 =?utf-8?B?RHRDdERyZCtkdVNjVVQ1dk9hdmZsajRzMndtWTlya1RIbUE1S2hVTEZSVllT?=
 =?utf-8?B?MGVXbUY5TWFxeTBOZFd1VEZVc0huRS9FOVRjQ1lEb2VVbjF3T1FyQUxYOFJE?=
 =?utf-8?B?Qm8wNVpRY3d2LzVidncvOGlva3ZhT3BmOWdueFQrMTFsQXpTekJoY3M5NzZB?=
 =?utf-8?B?WkFwYnFCZHA1U1dhR3FFdGxlVy8vemhxY0JaYXJaTmdSMnkrTEF6cEVCbkRH?=
 =?utf-8?B?VW45VmdZRkJxLzg0T0VkZzNiRjFWdUpWcFpndFVHaStHMWZRdXVoT2EvR3Nn?=
 =?utf-8?B?dmxYRit0MjBZdUYwaXJ1ekphMDE3TTBDeEVwMDBEK0U3dENmMExOK3FLRUZy?=
 =?utf-8?B?eVIveXk3dDY1NzBJZU1rYTVRRFZjOUUzMXlDYXpTQmhSd1MvU1UxMDlhenk3?=
 =?utf-8?B?bWxGL2hZS3g4UWxodnlvZ0VKNm81TFIwMFl1RDR1SHE2MUVwSjd3MUlDTzEy?=
 =?utf-8?B?UkhxUjFOeE9zNUZ3VW56bkJYeWxhZ210eHdyYVVMMXV6VjhIejNFTEh3WmZZ?=
 =?utf-8?Q?bmQjABgBaSiOHNcbEo21O6phL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2973df-3179-43f9-c3c5-08daa78b9084
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 11:11:49.4352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sas9tDm43c8NmLzFfByO6UO6H3aQ4tZOqpCAjwDefL5DEJiAHDdU5CdQfVGl2k2yAkGyTsLyB8q0aL7gW54iqiPbEkE8g1BWS5tGqSyz9gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8519
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm01 test using new LTP API
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

this patch has been sent already. An accident using "git send-email" 
command.

Andrea

On 10/6/22 13:06, Andrea Cervesato wrote:
> Now test is run on process_vm_writev by default and process_vm_readv can
> be selected by passing -r command line option.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/syscalls                             |   2 +-
>   testcases/kernel/syscalls/cma/process_vm01.c | 464 ++++++++-----------
>   2 files changed, 188 insertions(+), 278 deletions(-)
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3847e8af2..70f22fbd5 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1031,7 +1031,7 @@ profil01 profil01
>   process_vm_readv01 process_vm01 -r
>   process_vm_readv02 process_vm_readv02
>   process_vm_readv03 process_vm_readv03
> -process_vm_writev01 process_vm01 -w
> +process_vm_writev01 process_vm01
>   process_vm_writev02 process_vm_writev02
>   
>   prot_hsymlinks prot_hsymlinks
> diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
> index 16f14d66b..bfd5c5acb 100644
> --- a/testcases/kernel/syscalls/cma/process_vm01.c
> +++ b/testcases/kernel/syscalls/cma/process_vm01.c
> @@ -1,47 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Copyright (C) 2012 Linux Test Project, Inc.
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
> + * Copyright (c) Linux Test Project, 2012
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>    */
>   
> -/*
> - * errno tests shared by process_vm_readv, process_vm_writev tests.
> +/*\
> + * [Description]
> + *
> + * Test errno codes in process_vm_readv and process_vm_writev syscalls.
>    */
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/syscall.h>
> -#include <sys/uio.h>
> -#include <sys/wait.h>
> -#include <sys/mman.h>
> -#include <errno.h>
> -#include <signal.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <limits.h>
> +
>   #include <pwd.h>
> -#include "config.h"
> -#include "test.h"
> -#include "safe_macros.h"
> +#include <stdlib.h>
> +#include "tst_test.h"
>   #include "lapi/syscalls.h"
>   
>   struct process_vm_params {
> @@ -56,137 +27,27 @@ struct process_vm_params {
>   	unsigned long flags;
>   };
>   
> -static int rflag;
> -static int wflag;
> -
> -static option_t options[] = {
> -	{"r", &rflag, NULL},
> -	{"w", &wflag, NULL},
> -	{NULL, NULL, NULL}
> -};
> -
> -static char TCID_readv[] = "process_vm_readv";
> -static char TCID_writev[] = "process_vm_writev";
> -char *TCID = "cma01";
> -int TST_TOTAL = 1;
> -static void (*cma_test_params) (struct process_vm_params * params) = NULL;
> -
> -static void setup(char *argv[]);
> -static void cleanup(void);
> -static void help(void);
> -
> -static void cma_test_params_read(struct process_vm_params *params);
> -static void cma_test_params_write(struct process_vm_params *params);
> -static void cma_test_errnos(void);
> -
> -int main(int argc, char *argv[])
> -{
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, options, &help);
> -
> -	setup(argv);
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		cma_test_errnos();
> -	}
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(char *argv[])
> -{
> -	tst_require_root();
> -
> -	if (rflag && wflag)
> -		tst_brkm(TBROK, NULL, "Parameters -r -w can not be used"
> -			 " at the same time.");
> -	else if (rflag) {
> -		TCID = TCID_readv;
> -		cma_test_params = cma_test_params_read;
> -	} else if (wflag) {
> -		TCID = TCID_writev;
> -		cma_test_params = cma_test_params_write;
> -	} else
> -		tst_brkm(TBROK, NULL, "Parameter missing, required -r or -w.");
> -	TEST_PAUSE;
> -}
> -
> -static void cleanup(void)
> -{
> -}
> -
> -static void help(void)
> -{
> -	printf("  -r      Use process_vm_readv\n");
> -	printf("  -w      Use process_vm_writev\n");
> -}
> -
> -static void cma_test_params_read(struct process_vm_params *params)
> -{
> -	TEST(tst_syscall(__NR_process_vm_readv,
> -			 params->pid,
> -			 params->lvec, params->liovcnt,
> -			 params->rvec, params->riovcnt,
> -			 params->flags));
> -}
> -
> -static void cma_test_params_write(struct process_vm_params *params)
> -{
> -	TEST(tst_syscall(__NR_process_vm_writev,
> -			 params->pid,
> -			 params->lvec, params->liovcnt,
> -			 params->rvec, params->riovcnt,
> -			 params->flags));
> -}
> -
> -static int cma_check_ret(long expected_ret, long act_ret)
> -{
> -	if (expected_ret == act_ret) {
> -		tst_resm(TPASS, "expected ret success - "
> -			 "returned value = %ld", act_ret);
> -	} else {
> -		tst_resm(TFAIL, "unexpected failure - "
> -			 "returned value = %ld, expected: %ld",
> -			 act_ret, expected_ret);
> -		return 1;
> -	}
> -	return 0;
> -}
> -
> -static int cma_check_errno(long expected_errno)
> -{
> -	if (TEST_ERRNO == expected_errno)
> -		tst_resm(TPASS | TTERRNO, "expected failure");
> -	else if (TEST_ERRNO == 0) {
> -		tst_resm(TFAIL, "call succeeded unexpectedly");
> -		return 1;
> -	} else {
> -		tst_resm(TFAIL | TTERRNO, "unexpected failure - "
> -			 "expected = %ld : %s, actual",
> -			 expected_errno, strerror(expected_errno));
> -		return 2;
> -	}
> -	return 0;
> -}
> +static char *str_read;
> +static void (*test_params)(struct process_vm_params *params);
>   
> -static struct process_vm_params *cma_alloc_sane_params(void)
> +static struct process_vm_params *alloc_params(void)
>   {
>   	struct process_vm_params *sane_params;
>   	int len;
>   
>   	len = getpagesize();
> -	sane_params = SAFE_MALLOC(NULL, sizeof(struct process_vm_params));
> +
> +	sane_params = SAFE_MALLOC(sizeof(struct process_vm_params));
>   	sane_params->len = len;
> -	sane_params->ldummy = SAFE_MALLOC(NULL, len);
> -	sane_params->rdummy = SAFE_MALLOC(NULL, len);
> +	sane_params->ldummy = SAFE_MALLOC(len);
> +	sane_params->rdummy = SAFE_MALLOC(len);
>   
> -	sane_params->lvec = SAFE_MALLOC(NULL, sizeof(struct iovec));
> +	sane_params->lvec = SAFE_MALLOC(sizeof(struct process_vm_params));
>   	sane_params->lvec->iov_base = sane_params->ldummy;
>   	sane_params->lvec->iov_len = len;
>   	sane_params->liovcnt = 1;
>   
> -	sane_params->rvec = SAFE_MALLOC(NULL, sizeof(struct iovec));
> +	sane_params->rvec = SAFE_MALLOC(sizeof(struct process_vm_params));
>   	sane_params->rvec->iov_base = sane_params->rdummy;
>   	sane_params->rvec->iov_len = len;
>   	sane_params->riovcnt = 1;
> @@ -197,7 +58,7 @@ static struct process_vm_params *cma_alloc_sane_params(void)
>   	return sane_params;
>   }
>   
> -static void cma_free_params(struct process_vm_params *params)
> +static void free_params(struct process_vm_params *params)
>   {
>   	if (params) {
>   		free(params->ldummy);
> @@ -208,195 +69,244 @@ static void cma_free_params(struct process_vm_params *params)
>   	}
>   }
>   
> -static void cma_test_sane_params(void)
> +static void test_readv(struct process_vm_params *params)
> +{
> +	TEST(tst_syscall(__NR_process_vm_readv,
> +		params->pid,
> +		params->lvec, params->liovcnt,
> +		params->rvec, params->riovcnt,
> +		params->flags));
> +}
> +
> +static void test_writev(struct process_vm_params *params)
> +{
> +	TEST(tst_syscall(__NR_process_vm_writev,
> +		params->pid,
> +		params->lvec, params->liovcnt,
> +		params->rvec, params->riovcnt,
> +		params->flags));
> +}
> +
> +static void check_errno(long expected_errno)
> +{
> +	if (TST_ERR == expected_errno)
> +		tst_res(TPASS | TTERRNO, "expected failure");
> +	else if (TST_ERR == 0)
> +		tst_res(TFAIL, "call succeeded unexpectedly");
> +	else
> +		tst_res(TFAIL | TTERRNO, "unexpected failure - "
> +			"expected = %ld : %s, actual",
> +			expected_errno, strerror(expected_errno));
> +}
> +
> +static void test_sane_params(void)
>   {
>   	struct process_vm_params *sane_params;
>   
> -	sane_params = cma_alloc_sane_params();
> -	tst_resm(TINFO, "test_sane_params");
> -	cma_test_params(sane_params);
> -	cma_check_ret(sane_params->len, TEST_RETURN);
> -	cma_free_params(sane_params);
> +	tst_res(TINFO, "Testing sane parameters");
> +
> +	sane_params = alloc_params();
> +	test_params(sane_params);
> +	TST_EXP_EQ_LI(TST_RET, sane_params->len);
> +	free_params(sane_params);
>   }
>   
> -static void cma_test_flags(void)
> +static void test_flags(void)
>   {
>   	struct process_vm_params *params;
>   	long flags[] = { -INT_MAX, -1, 1, INT_MAX, 0 };
> -	int flags_size = sizeof(flags) / sizeof(flags[0]);
> +	int flags_size = ARRAY_SIZE(flags) / sizeof(flags[0]);
>   	int i;
>   
> -	params = cma_alloc_sane_params();
> +	params = alloc_params();
> +
>   	for (i = 0; i < flags_size; i++) {
>   		params->flags = flags[i];
> -		tst_resm(TINFO, "test_flags, flags=%ld", flags[i]);
> -		cma_test_params(params);
> +
> +		tst_res(TINFO, "Testing flags=%ld", flags[i]);
> +		test_params(params);
> +
>   		/* atm. only flags == 0 is allowed, everything else
> -		 * should fail with EINVAL */
> +		 * should fail with EINVAL
> +		 */
>   		if (flags[i] != 0) {
> -			cma_check_ret(-1, TEST_RETURN);
> -			cma_check_errno(EINVAL);
> +			TST_EXP_EQ_LI(TST_RET, -1);
> +			check_errno(EINVAL);
>   		} else {
> -			cma_check_ret(params->len, TEST_RETURN);
> +			TST_EXP_EQ_LI(TST_RET, params->len);
>   		}
>   	}
> -	cma_free_params(params);
> +
> +	free_params(params);
>   }
>   
> -static void cma_test_iov_len_overflow(void)
> +static void test_iov_len_overflow(void)
>   {
>   	struct process_vm_params *params;
> -	ssize_t maxlen = -1;
> -	params = cma_alloc_sane_params();
> -
> -	params->lvec->iov_len = maxlen;
> -	params->rvec->iov_len = maxlen;
> -	tst_resm(TINFO, "test_iov_len_overflow");
> -	cma_test_params(params);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(EINVAL);
> -	cma_free_params(params);
> +
> +	tst_res(TINFO, "Testing iov_len = -1");
> +
> +	params = alloc_params();
> +	params->lvec->iov_len = -1;
> +	params->rvec->iov_len = -1;
> +	test_params(params);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(EINVAL);
> +	free_params(params);
>   }
>   
> -static void cma_test_iov_invalid(void)
> +static void test_iov_invalid(void)
>   {
>   	struct process_vm_params *sane_params;
>   	struct process_vm_params params_copy;
>   
> -	sane_params = cma_alloc_sane_params();
> -	/* make a shallow copy we can 'damage' */
> +	sane_params = alloc_params();
>   
> +	tst_res(TINFO, "Testing lvec->iov_base = -1");
>   	params_copy = *sane_params;
> -	tst_resm(TINFO, "test_iov_invalid - lvec->iov_base");
>   	params_copy.lvec->iov_base = (void *)-1;
> -	cma_test_params(&params_copy);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(EFAULT);
> +	test_params(&params_copy);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(EFAULT);
>   
> +	tst_res(TINFO, "Testing rvec->iov_base = -1");
>   	params_copy = *sane_params;
> -	tst_resm(TINFO, "test_iov_invalid - rvec->iov_base");
>   	params_copy.rvec->iov_base = (void *)-1;
> -	cma_test_params(&params_copy);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(EFAULT);
> +	test_params(&params_copy);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(EFAULT);
>   
> +	tst_res(TINFO, "Testing lvec = -1");
>   	params_copy = *sane_params;
> -	tst_resm(TINFO, "test_iov_invalid - lvec");
>   	params_copy.lvec = (void *)-1;
> -	cma_test_params(&params_copy);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(EFAULT);
> +	test_params(&params_copy);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(EFAULT);
>   
> +	tst_res(TINFO, "Testing rvec = -1");
>   	params_copy = *sane_params;
> -	tst_resm(TINFO, "test_iov_invalid - rvec");
>   	params_copy.rvec = (void *)-1;
> -	cma_test_params(&params_copy);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(EFAULT);
> +	test_params(&params_copy);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(EFAULT);
>   
> -	cma_free_params(sane_params);
> +	free_params(sane_params);
>   }
>   
> -static void cma_test_invalid_pid(void)
> +static void test_invalid_pid(void)
>   {
>   	pid_t invalid_pid = -1;
>   	struct process_vm_params *params;
> +	struct process_vm_params params_copy;
> +
> +	params = alloc_params();
> +
> +	tst_res(TINFO, "Testing invalid PID");
> +	params_copy = *params;
> +	params_copy.pid = invalid_pid;
> +	test_params(&params_copy);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(ESRCH);
>   
> -	params = cma_alloc_sane_params();
> -	tst_resm(TINFO, "test_invalid_pid");
> -	params->pid = invalid_pid;
> -	cma_test_params(params);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(ESRCH);
> -	cma_free_params(params);
> -
> -	invalid_pid = tst_get_unused_pid(cleanup);
> -
> -	params = cma_alloc_sane_params();
> -	params->pid = invalid_pid;
> -	cma_test_params(params);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(ESRCH);
> -	cma_free_params(params);
> +	tst_res(TINFO, "Testing unused PID");
> +	params_copy = *params;
> +	invalid_pid = tst_get_unused_pid();
> +	params_copy.pid = invalid_pid;
> +	test_params(&params_copy);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(ESRCH);
> +
> +	free_params(params);
>   }
>   
> -static void cma_test_invalid_perm(void)
> +static void test_invalid_perm(void)
>   {
>   	char nobody_uid[] = "nobody";
>   	struct passwd *ltpuser;
> -	int status;
>   	struct process_vm_params *params;
>   	pid_t child_pid;
>   	pid_t parent_pid;
> -	int ret = 0;
> +	int status;
> +
> +	tst_res(TINFO, "Testing invalid permissions on given PID");
>   
> -	tst_resm(TINFO, "test_invalid_perm");
>   	parent_pid = getpid();
> -	child_pid = fork();
> -	switch (child_pid) {
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork");
> -		break;
> -	case 0:
> -		ltpuser = getpwnam(nobody_uid);
> -		if (ltpuser == NULL)
> -			tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
> -		SAFE_SETUID(NULL, ltpuser->pw_uid);
> -
> -		params = cma_alloc_sane_params();
> +	child_pid = SAFE_FORK();
> +	if (!child_pid) {
> +		ltpuser = SAFE_GETPWNAM(nobody_uid);
> +		SAFE_SETUID(ltpuser->pw_uid);
> +
> +		params = alloc_params();
>   		params->pid = parent_pid;
> -		cma_test_params(params);
> -		ret |= cma_check_ret(-1, TEST_RETURN);
> -		ret |= cma_check_errno(EPERM);
> -		cma_free_params(params);
> -		exit(ret);
> -	default:
> -		SAFE_WAITPID(cleanup, child_pid, &status, 0);
> -		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -			tst_resm(TFAIL, "child returns %d", status);
> +		test_params(params);
> +		TST_EXP_EQ_LI(TST_RET, -1);
> +		check_errno(EPERM);
> +		free_params(params);
> +		return;
>   	}
> +
> +	SAFE_WAITPID(child_pid, &status, 0);
>   }
>   
> -static void cma_test_invalid_protection(void)
> +static void test_invalid_protection(void)
>   {
>   	struct process_vm_params *sane_params;
>   	struct process_vm_params params_copy;
> -	void *p;
> -
> -	sane_params = cma_alloc_sane_params();
> -	/* make a shallow copy we can 'damage' */
> +	void *data;
> +	int len;
>   
> -	p = mmap(NULL, getpagesize(), PROT_NONE,
> -		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> -	if (p == MAP_FAILED)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
> +	len = getpagesize();
> +	sane_params = alloc_params();
> +	data = SAFE_MMAP(NULL, len, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>   
> +	tst_res(TINFO, "Testing data with invalid protection (lvec)");
>   	params_copy = *sane_params;
> -	params_copy.lvec->iov_base = p;
> -	tst_resm(TINFO, "test_invalid_protection lvec");
> -	cma_test_params(&params_copy);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(EFAULT);
> +	params_copy.lvec->iov_base = data;
> +	test_params(&params_copy);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(EFAULT);
>   
> +	tst_res(TINFO, "Testing data with invalid protection (rvec)");
>   	params_copy = *sane_params;
> -	params_copy.rvec->iov_base = p;
> -	tst_resm(TINFO, "test_invalid_protection rvec");
> -	cma_test_params(&params_copy);
> -	cma_check_ret(-1, TEST_RETURN);
> -	cma_check_errno(EFAULT);
> +	params_copy.rvec->iov_base = data;
> +	test_params(&params_copy);
> +	TST_EXP_EQ_LI(TST_RET, -1);
> +	check_errno(EFAULT);
>   
> -	SAFE_MUNMAP(cleanup, p, getpagesize());
> +	SAFE_MUNMAP(data, len);
> +	free_params(sane_params);
> +}
>   
> -	cma_free_params(sane_params);
> +static void run(void)
> +{
> +	test_sane_params();
> +	test_flags();
> +	test_iov_len_overflow();
> +	test_iov_invalid();
> +	test_invalid_pid();
> +	test_invalid_perm();
> +	test_invalid_protection();
>   }
>   
> -static void cma_test_errnos(void)
> +static void setup(void)
>   {
> -	cma_test_sane_params();
> -	cma_test_flags();
> -	cma_test_iov_len_overflow();
> -	cma_test_iov_invalid();
> -	cma_test_invalid_pid();
> -	cma_test_invalid_perm();
> -	cma_test_invalid_protection();
> +	if (str_read) {
> +		tst_res(TINFO, "Selected process_vm_readv");
> +		test_params = test_readv;
> +	} else {
> +		tst_res(TINFO, "Selected process_vm_writev");
> +		test_params = test_writev;
> +	}
>   }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.needs_root = 1,
> +	.options = (struct tst_option[]) {
> +		{"r", &str_read, "Use process_vm_read instead of process_vm_write"},
> +		{},
> +	},
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
