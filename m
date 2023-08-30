Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86707C6FA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 12:20:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02E233CC00A
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 14:20:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12A5D3C5DFD
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 14:20:14 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 472386008F7
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 14:20:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7SjCf0oEo5UOnanZ2aL5X1GWefEh5qpyKm0y4DOF5TM8ut6xoiZL/GIfb6d/Ho4tUFme2WeUgAEpsa1ewk0ZkWQVrXk9XYpVuUXWlyC/DNRBa8giV9A83M/iE/lVphvZot5R97Bkun1he1r6G0SlPUZJQ7wUCQ/LXNJVXVK3pB24zGyqM2nz0VeMJEEf53DyiPmuFPb3M25CdKsTOcNCbr3GqucOrXVAxlz52jE8xvswT2u21AcsFu//0oIKrbaZEB7md2z9ZRP3kjYt8IJGWimJlS7g1amXP+SPWVI5o8ifdfYkYUh0Sn9wwyVT7bJQk6mX7n50AoVr73E2jJDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYtlzpt4d5ICVPccXryqN0pIMKX49h5gOV0a/3pE950=;
 b=cMKnKozqe5FYzJPnetMdzslX6T2wvdidyb2oU5u91WCEdfX6LBDSr4dHt/UrQAXYTcGDMZRrKhP2bpgnhI6Ms7hBK2H6XNNFXaJzXJrxe6YgSIDbIu2iNYwbD7gcrToAYS6B4ik1dGYPdvPOKWV1pexS/f83nhflmxsuMK5bCswk7M97mfq6QzmP6p8ib50EE8BKGHdtUvW3MQTZHZP2Ar/VBiL6Uu/LJwqenryt12NegsKNP42EmDZ2bjzoRfEX+1D7wtPPPN7GQNE8kMJmcHthjkGiIMb6ofuEgwJijZ5C5tOCn+7rsB2VpPOLpnmBBpBx6lz1cnOcvssn2/hKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYtlzpt4d5ICVPccXryqN0pIMKX49h5gOV0a/3pE950=;
 b=KiGQmfD1tnpnRKWbBbhfT73WL8A6PyxfY62A9GnDdcTo22kHfcoL5cwp5p0b6/C4rVCCWV4fuGd9KB227msoNthE8e5smPV1i0Z4kcLChKan5vOcFg4t8loMg7mnPEy8mnAnMWlPwD38mA7f7SiNJ4p5ijh90SPMDJcQLRVNsjCnGaGROhL5v0ty4qHApUbddENxOzmP9EvQSFG/I9UovLCv9iC70tOH3UkhCJBDwhQeYeqs5Ftd7CH44esXfWYUiVaPkBF2Pe35Bp4wKpw1GkPQztR4VfCXFCZ1KrljXuDnDm2MTAvcH6k6RwUUBr6Rn8iwSGQDCM4HYRkPqRQxEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB9PR04MB8432.eurprd04.prod.outlook.com (2603:10a6:10:243::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 12:20:11 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6678.031; Wed, 30 Aug 2023
 12:20:10 +0000
Message-ID: <65d5a33b-9995-4a5d-9bff-36745e5da1ed@suse.com>
Date: Wed, 30 Aug 2023 14:20:08 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <1692945619-1066-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1692945619-1066-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB9PR04MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a2a507-2811-478a-95e3-08dba9537499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85Vgtb1Sx7fxMujbs+nDemb+7D490z435mRMuPAZYPIYjBa8RpTqDIAoEoA79XUoKXPwVtbaNlOt2AI7EddwNFZIrR+e8ywbuRVUj+4oU8DH9sCgLCfSWkncy7uRbAusjVTsWUnL3ahJkt2SS0tyzcYla5QOL7Pcg4V94aOX+OmtkMZuVho93Z5wnJ49hP/db775TiPhZxkYFwwOrcUnirUx5tmopJhSEgzQHIIb69LvGkQekW18N8J3+wpQhCm3SEQDWYXLxYhjFfA5vkNO/2F8/hjIkl6p8fpnY1X1uDit7a+lKtn1J5r5863pamx+IoxqIKqDiZKBSoMyUZWFDaTOw8AwgWjCC8xJ1A3wq9Z53klaib+C/9IZnht9TyBaK2GY1tk54/XnfOjpgug0Uea0Adas/ssnaJMb9HV6UpF0YjETtDolQgb29YpHkiul4FZhuJGWa2jNeQr4heJi+NqJleyYOD4AY2Joq53W1ZwdkHbxfCubFOcwfUJimeDyVUoOhgC2U7K/1bABRHDmQoIpz/8ZEtJ4gmvRRKLdSIcmWnEBhAmVqBkRO1Opg/XJMhk1weglx1dJqyT729nzwajS9+Hg9P73mhzYOJkK3uvFDkTmODQV488J4XbTAuUMyN1Rir5T5BLUy9OMp+dEddfdeFi4eVvgOS7Qt8iWo58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(396003)(39850400004)(346002)(186009)(451199024)(1800799009)(31686004)(6512007)(2616005)(83380400001)(6486002)(8936002)(8676002)(53546011)(5660300002)(6506007)(478600001)(38100700002)(86362001)(31696002)(44832011)(36756003)(2906002)(66946007)(66476007)(66556008)(316002)(26005)(41300700001)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5WS2t4VGFjWENQMmh3aFlvd2ZUSEdXMWk5UVdpYmVDVDFpdytjT2ladm1U?=
 =?utf-8?B?VmgzL0NwRUgzYXM1TXl6YTBOY3ZBbmtlMjFweElxenNCK2dXdk9zNjdheGRM?=
 =?utf-8?B?TGhPd1VsSU90YjNVcTZKcjBwTXRPSGNuMVNCcDNxd082T2RWeHNHdEg3aWVN?=
 =?utf-8?B?WlA5S0pla2pweXNnTmpZOUx6OEMyQ2JwVE9RbmNwUUpLMTNScSthQjlOeXNG?=
 =?utf-8?B?NUVSOGhERW5jdm52TmxwOThMTlVpMFdxcXZhTmhYNmtWUFhtMDEyei9wd0RJ?=
 =?utf-8?B?WDhpS1RGZ0c1aXl3N1prTGkydmN4Z0VPVVNNbEZCa1ZnWXN6b3RtZ0VtcEp2?=
 =?utf-8?B?QWtHM256Wkgxa0JIUkx5dTNmRzN1T0ljUWMwZnA1Q2h1NXRIUXdvQzFCRUpK?=
 =?utf-8?B?THpVcHFtMUExM2ozM0pvRWtJQU95K2dsdDJGRE5YSy9SbWVzbnNXZm5OWnZs?=
 =?utf-8?B?S29wYWhsVjNxc09FanFBeXl1MFFieVh6MnR2MXhZM1NCVVd0c0w4ZitSSzNj?=
 =?utf-8?B?TjZvMHdGbTJDKzhwbGgwYnR6WVFZTHU2RHF2TDhyY21JdUsva2t0MXArVGhE?=
 =?utf-8?B?WFdxUmlZOGs4d1lKcnpsVElaRzNOT2FoQmtQUDh0VkRkcC9YcUxVRWxnRzFM?=
 =?utf-8?B?MVNLbTdyUEl5b1NqalNXUk4rdGRnQkcvenFBV2xNdlYyZVU5ZzNrc1F4NnJK?=
 =?utf-8?B?bFlnNXpqSTN5L2RGdkplWVh4TjBMaUNpRU9rcUNPYi9DMnJBVzB4VWJ1Z29H?=
 =?utf-8?B?cXByNEJyYUtBaFI3RUxEY25qTHRZYVZnQjJ1RytYRDEzcVM0SW9pTmcyVmlZ?=
 =?utf-8?B?bG9RSFlIWUpSbWNUeEZmM0k5Mi81NU1NaDRiWHFZRFFQRmtsdW15bWljbHRB?=
 =?utf-8?B?VVlMTXUvb1RERldtY0xBekU5eFJJYjdxdUJ3SEpRdUI5S1RzeEV2T1JXKzVS?=
 =?utf-8?B?WklXUWZqcU4rbUVFazZkK3Rxb2RTVk1HMzhFekJmUmZHU1ZxUThwT1VzUytO?=
 =?utf-8?B?Z0ZuT2dTRWZweGdXRjBlcDlvaGtyTjNjYS9OSUJ6YU11ZVM3aFdCUkVSZDhL?=
 =?utf-8?B?bjdMY2xBUWlUanhsKzN0VjJqTTc2cEhnNmdteHZJd3gwWVZac2JrcVlWbCt0?=
 =?utf-8?B?clRMRlFQVW1CdEVWRkF6RFNOR2kxUXB0Q3htTFpNeWNtc0ZSalByRmhpK2Nn?=
 =?utf-8?B?TFlqL0hZS0dNa0g0dVhIcWp4MGpSaTFRbE9PWjN3R2Y5MjB5STh0SDAwbUVL?=
 =?utf-8?B?L1hHcFV6bUFWbzQ4QnBjbDNnK1J2T3MrT2xFQkdLeHpCWlprUTVjaHEzdmpw?=
 =?utf-8?B?L2JVWnRQU1VCUjQzaW1HVDhNbnIyTHVvNGdmMmlJVXE1dEo4OWlsNWNWNVVY?=
 =?utf-8?B?eWdoNkMrTGxIZ1NJZEQ4aEJzRk9BS3Fhc1FiTE1WWktWbzN3RUxLSGdBQnlJ?=
 =?utf-8?B?SDlrYzVUSWRNMVZYSmRWWjVWRll6Vk1Zc1FuMUNJZi9YNjYzbUl2azhqZDk2?=
 =?utf-8?B?bEwyeER4bmlTV2xRbTB2MDVUQlA0U3NidmRoSldaaUh1UU5kbStyaVUxUVlv?=
 =?utf-8?B?RlEzSzgweHhvRjdKanRFN1prRHU4ZkFEQUZjcFVocHhMVnNaV1N2SDJsKy8w?=
 =?utf-8?B?MnZMWjc5YVd3Um1JWjdaUE5tRk9QQXMzbkFKdEJqT251NlVVcmJ1Wkk4TjJO?=
 =?utf-8?B?UEoySzJ0YStoeGNKbVJIQi9oY2FFYWV0d2dvblRnREpSWkxVVkpOblppQmo1?=
 =?utf-8?B?SGwzdnFlVlRXenk4UlFEaTVSV2lGVjVlck1rSHU4TVBVYmxyMWMvZ2RGL1p6?=
 =?utf-8?B?dEI5cUpmREduN0pZYXdPemk2WU53VkRKSVhGT2M5b3c3SktIM3R2K3BSclhq?=
 =?utf-8?B?TUdXWS9yVXNYeDYrbHBCU1I1dTltYWFGbktycERsYWVJVnJWMmRiODA0bHEy?=
 =?utf-8?B?NElmWHBIUDE2VUFmekFHRmM0TFVTZGQ0dk9ON1BlZUVLRzVXcmdGclRWYTlm?=
 =?utf-8?B?aENEK0p3WmJPTHE1Yk8zT2xOL1FhL0luZVJvTzM4WUdtd2J0alYzT25KUmVW?=
 =?utf-8?B?VjdEZ1JsQW5wR1hTRUU1YnZTZnFWd09hbW5NYXRhWTVxajVEWmI0U1NERW1O?=
 =?utf-8?B?THZERGY2Qlg5eEc1NW90RTdIT2preHJ2NUFwTWEvaWxZTjlZRVZLcnlmUE5l?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a2a507-2811-478a-95e3-08dba9537499
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 12:20:10.8896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef9AJJ3CHzuK2Wu/44bZjkalW2rdGaY9eBXUlLDKb0t9UegO9jTVgD4HBJa0Wv9Z42L099XqsPNEmUtUkchb9gbD5NjhAOJqtEjAEKYDOes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8432
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/readlinkat01: Convert to new API
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

Hi!

On 8/25/23 08:40, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/readlinkat/readlinkat01.c | 174 +++++++-----------
>   1 file changed, 62 insertions(+), 112 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
> index 985890ebe..100881615 100644
> --- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
> +++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
> @@ -1,143 +1,93 @@
> -/******************************************************************************
> - *
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
>    * Copyright (c) International Business Machines  Corp., 2006
> - *  Author: Yi Yang <yyangcdl@cn.ibm.com>
>    * Copyright (c) Cyril Hrubis 2014 <chrubis@suse.cz>
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
> - * This test case will verify basic function of readlinkat
> - * added by kernel 2.6.16 or up.
> - *
> - *****************************************************************************/
> + * Copyright (c) Linux Test Project, 2003-2023
> + * Author: Yi Yang <yyangcdl@cn.ibm.com>
> + */
>   
> -#define _GNU_SOURCE
> +/*\
> + * [Description]
> + *
> + * Check the basic functionality of the readlinkat() system call.
It would be nice to extend a the description, explaining what test cases 
we are going to have (symlink, dir, abspath, etc).
> + */
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/time.h>
> -#include <fcntl.h>
>   #include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/readlinkat.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
>   
> -char *TCID = "readlinkat01";
> +#define TEST_FILE       "readlink_file"
> +#define TEST_SYMLINK    "readlink_symlink"
>   
> -static int dir_fd, fd;
> -static int fd_invalid = 100;
> +static int file_fd, dir_fd, dir_fd2;
>   static int fd_atcwd = AT_FDCWD;
> -
> -#define TEST_SYMLINK "readlink_symlink"
> -#define TEST_FILE "readlink_file"
> -
> -static char abspath[1024];
> -
> -static struct test_case {
> -	int *dir_fd;
> -	const char *path;
> -	const char *exp_buf;
> -	int exp_ret;
> -	int exp_errno;
> -} test_cases[] = {
> -	{&dir_fd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> -	{&dir_fd, abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> -	{&fd, TEST_SYMLINK, NULL, -1, ENOTDIR},
> -	{&fd_invalid, TEST_SYMLINK, NULL, -1, EBADF},
> -	{&fd_atcwd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> +static const char *abspath;
> +static const char *testsymlink;
> +static const char *emptypath = "";
> +
> +static struct tcase {
> +	int *fd;
> +	const char **path;
> +} tcases[] = {
> +	{&dir_fd, &testsymlink},
> +	{&dir_fd, &abspath},
> +	{&file_fd, &abspath},
> +	{&fd_atcwd, &testsymlink},
> +	{&fd_atcwd, &abspath},
> +	{&dir_fd2, &emptypath},
>   };
>   
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -static void verify_readlinkat(struct test_case *test)
> +static void verify_readlinkat(unsigned int i)
>   {
>   	char buf[1024];
> +	struct tcase *tc = &tcases[i];
>   
>   	memset(buf, 0, sizeof(buf));
>   
> -	TEST(readlinkat(*test->dir_fd, test->path, buf, sizeof(buf)));
> -
> -	if (TEST_RETURN != test->exp_ret) {
> -		tst_resm(TFAIL | TTERRNO,
> -		         "readlinkat() returned %ld, expected %d",
> -		         TEST_RETURN, test->exp_ret);
> -		return;
> -	}
> -
> -	if (TEST_ERRNO != test->exp_errno) {
> -		tst_resm(TFAIL | TTERRNO,
> -		         "readlinkat() returned %ld, expected %d",
> -		         TEST_RETURN, test->exp_ret);
> -		return;
> -	}
> -
> -	if (test->exp_ret > 0 && strcmp(test->exp_buf, buf)) {
> -		tst_resm(TFAIL, "Unexpected buffer have '%s', expected '%s'",
> -		         buf, test->exp_buf);
> -		return;
> -	}
> -
> -	tst_resm(TPASS | TTERRNO, "readlinkat() returned %ld", TEST_RETURN);
> -}
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	TST_EXP_POSITIVE(readlinkat(*tc->fd, *tc->path, buf, sizeof(buf)),
> +		     "readlinkat(%d, %s, %s, %ld)",
> +		     *tc->fd, *tc->path, buf, sizeof(buf));
>   
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		for (i = 0; i < TST_TOTAL; i++)
> -			verify_readlinkat(&test_cases[i]);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	if (strcmp(buf, TEST_FILE) == 0)
> +		tst_res(TPASS, "The filename in buffer is correct");
> +	else
> +		tst_res(TFAIL, "Wrong filename in buffer '%s'", buf);
>   }
>   
>   static void setup(void)
>   {
> -	tst_tmpdir();
>   	char *tmpdir = tst_get_tmpdir();
>   
> -	snprintf(abspath, sizeof(abspath), "%s/" TEST_SYMLINK, tmpdir);
> +	abspath = tst_aprintf("%s/" TEST_SYMLINK, tmpdir);
>   	free(tmpdir);
>   
> -	fd = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT, 0600);
> -	SAFE_SYMLINK(cleanup, TEST_FILE, TEST_SYMLINK);
> -	dir_fd = SAFE_OPEN(cleanup, ".", O_DIRECTORY);
> -
> -	TEST_PAUSE;
> +	file_fd = SAFE_OPEN(TEST_FILE, O_CREAT, 0600);
> +	SAFE_SYMLINK(TEST_FILE, TEST_SYMLINK);
> +	dir_fd = SAFE_OPEN(".", O_DIRECTORY);
> +	dir_fd2 = SAFE_OPEN(TEST_SYMLINK, O_PATH | O_NOFOLLOW);
>   }
>   
>   static void cleanup(void)
>   {
> -	if (fd > 0 && close(fd))
> -		tst_resm(TWARN | TERRNO, "Failed to close fd");
> +	if (file_fd > -1)
> +		SAFE_CLOSE(file_fd);
>   
> -	if (dir_fd > 0 && close(dir_fd))
> -		tst_resm(TWARN | TERRNO, "Failed to close dir_fd");
> +	if (dir_fd > -1)
> +		SAFE_CLOSE(dir_fd);
>   
> -	tst_rmdir();
> +	if (dir_fd2 > -1)
> +		SAFE_CLOSE(dir_fd2);
>   }
> +
> +static struct tst_test test = {
> +	.test = verify_readlinkat,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&testsymlink, .str = TEST_SYMLINK},
> +		{},
> +	},
> +	.tcnt = ARRAY_SIZE(tcases),
> +};

Overall it looks good to me.

Thank you,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
