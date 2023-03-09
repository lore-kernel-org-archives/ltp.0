Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C8DC6FD1F
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 15:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 629223CD8DE
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 16:02:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 751393CB7F1
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 16:02:10 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 25657600D55
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 16:02:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW8tdmBWAVF2ixKjf63WBUnWK32kcFVIrZOQH0Qaky8thJ0xmEsU7koYS6YB7YQ0uvFrjSoeObJPlfxqS8+VJzDtnLiUIiCJ5Zom7GYkXoYuSl3fl33pWJqzdE7prD9njuF/IWGm3AKYA0C/e6kEjLGsPEZ8yKumR95i1Hu1uDuqJi0EU/5dp40aVq7eVJODtb+YbRme8wHA9AkPwiL3K0zDerf/Ua6MDINHcLxWF09ZziFKcSGgl/2VDPSaPq9tEESY39rxB1wT//yiU9isYJpi2pEGdgnqWzQKG0DpNg6bhhWI+TYyur/pdHllS5F76W5XtebYoBpG7NSiCaSn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf0TfjpiayRJgC3mLVYAA1BkmdAAPOJppdnJqxppapI=;
 b=JuIeYDkQbHnHw7Ye4MBk28WxfkyasfQm5LxLESTIstRoRegVe4WmyqxRZmtKzWirGnp8TtNeE0DoYMqzMzsDJ0mSpXUc/NLQ/khx2S9m7U98h9GIavhSINYwCg6S+VTvjEsxZMuLvt76vAl7ZhnLAiJz5GY60sE1Y80iCK4o+MHXhfo63G4TcMXARTCImqyusLEfb4ajzDeQmbqFwDBOAbRug1liVhgwRONohTHJDGXEXkOarNKWgFGdgQs0ZuEHJPBsohOl2psydN/Ya3Mj2wd8P8QKxQjZq+vu2IMsbOidP1rpAGL544UPRYQ2McZajSEL3V+0tGxl8LRoxVRq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf0TfjpiayRJgC3mLVYAA1BkmdAAPOJppdnJqxppapI=;
 b=XydjdNGIHuawM1l87OsIsS4AFHVy5Dh0+kO4SKc6z8j0Vd+0mZK9nOJbN58/uvbKIWNYdC89px816fr80EiKLiTKh7s8MSXUtczmgWygXc0PpZYFoSjps/jcdXIToGrgXdFLvVeqMHh2Q4wa77sMbJBSxpaEzh1j5XFzd+WJCf5CMovR/xKvaVBvTiKP0QjXlnRm3ogGAsTv26TZw7hIfa1fpWZf3kaSaJRe86QELPMplAMxI8fIE5AwfB0dGCxn/Qqjc9W8ZnzvK+7hZFaNc1R78Q07thhpF5oaFrI1d+vhkx0PEjM/uIUp2GSSkW/TgWKWZCLhmoZIW53NmtvnqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 15:02:08 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%3]) with mapi id 15.20.6178.018; Thu, 9 Mar 2023
 15:02:08 +0000
Message-ID: <a87fbfc2-d54b-2d38-a700-becaf80fb94d@suse.com>
Date: Thu, 9 Mar 2023 15:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230309145917.26846-1-pvorel@suse.cz>
In-Reply-To: <20230309145917.26846-1-pvorel@suse.cz>
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9b1e16-553b-4a4a-a810-08db20af3ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHQeT34w8icU8m6dR2mH+mCPGLDU/bdB2WOY+TvBR1R5swIexpBokNeOFKh050EBHENPjFldxlae5kjK7RtvBFPhmHf6qhZ7yQGOhQbxcHfVZPEcZG/YiUpAAKNXNLazSH6BGam41+dO662knzNByXIvkJourq01LlxPVsWztvohO1gMd5Fowzyi/JoqkDRCp5YkeSrRLccqepyDQOskt27GwEqX29jg5y+6APFnF6WvpxiW62VVs1au054KwBXcGTtUaojB/pzX9bJZdqpe2YcHtp45ZRazdF3C/cridZbUUYPapDthwFLJ9UVY/s6G+/rUsHELomOz3r5WAwrPU6m/PyjtNjHqSjQIsDEdZVm+E9n8ur6DRu0qHCK8SgA5HdBI8R1V0KH+AbiAvvP9r2IThcClBHVsyaUWgvvcNZSYuDeeaGG6iqeNjSTOWp3hE1JXdNK1H+r4ZpANdhEHe7FIoSRUJb1x3JdJLcZRCAipzquoIYIe+4uRBc7BsFwI5zKafJAaZzpesXvX9bwIYZL5DvM5H+ognV4rao7cTX75OpfykHWLdlUhxS+9f2fDfd5tC9tOfrdlbiBZek0D+yv4ZE5aNC5MA1RHZgTxeSaLzqwsjhvt1aI30pjGpHlYDNa9HwX9vcR0cR1l7nQgwGN+bYpQd4zHHZarzrKelTQbFTWmxIr3NJuxfPzphdYjU5bSwH1CdumbSNKBD2FWUxCS2Hxju+CGg/qpSs5GFtQDgb4ySqkevI9Ljx3AAIXN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(31686004)(36756003)(186003)(86362001)(38100700002)(31696002)(6506007)(6512007)(53546011)(26005)(83380400001)(2616005)(6666004)(5660300002)(316002)(6486002)(478600001)(41300700001)(66476007)(8936002)(44832011)(2906002)(66556008)(8676002)(66946007)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdrWmdOVlZDQ2VvQ1JnY0xENzBGNzdiQmNVRGNiTG95eDhuZXlHMDJ6TzRB?=
 =?utf-8?B?N1lJVmQ0dnBCWkxCWEVkUE5NVTVIdHR6Rm5ONE9LR3pyRzRiYzBvT1MrMkE4?=
 =?utf-8?B?UWh2WElERUJOSGNNdDJlMHNuYXVZdmxadFdLcjlFYk5telVVQkRvWmVwK3J6?=
 =?utf-8?B?NldKb09DbDBGdEFyQnpsckt2cXZHNm9aSWxKeU84TWQ4NzFkRFBiOGVna2gy?=
 =?utf-8?B?alkrUURNNkN4ZHhhNE42dWcwSDVNM1hweEJoZ2ptekxmRHBPeGVyYnl6bUUr?=
 =?utf-8?B?bVFvV3dCdDZlRi9taGROejZ6aDc1MEdjVE9aL1ZMU2tvY2FBSFdTNGowbmJu?=
 =?utf-8?B?ekNKYkVCOVl0aTErNWUySU1DNFhnVk1wRURYTlJIRlkxeFJTc3NNVjI2aTNp?=
 =?utf-8?B?SitNM0dUMkpLK2JQeVFaYU41SEhmbmFoenFCWUo5U0xUSkQvRzd5WW9kdW4y?=
 =?utf-8?B?S3ZWNTFnbFlzN1o2dTdOdFBUancwbkU2SFZ5YVpmQzBOQXUrMURJZzBKN1Rq?=
 =?utf-8?B?Vno0Z2pIdE11YnNBWkNPVnlqNnNzSG52aHdVK2p4U2dyeDlCUVd2R09PSW1T?=
 =?utf-8?B?dmRtTE84QVByUDlRVTBpckVNQ3k4YURCQzVuMU5FU0JFMEpnUUpsRnlEYXYw?=
 =?utf-8?B?Y2Y1WnMxYnhNZXlyK2dDVW1KNmZTbDQ2WjFVVW1IWWxpMWRXQzdyWk9NQTJQ?=
 =?utf-8?B?c0hZRnZvOEdDWVFRTEM4NXIvQ1VxeUFMRU0vYWxhYmQ1bjNQaHIxUXFPSnhn?=
 =?utf-8?B?WWlIYlRJWjFBNmRjRE41QjMwelpNUGZrbEx1WWNjM29wd1pkbHlJaXdKS3Zh?=
 =?utf-8?B?cUxWSmd3VzRUNk5LRTB0S09MbCtCbkFwMXErWCt2RDFpL1kyL0dnNnIwSy95?=
 =?utf-8?B?aFpIai9VMGF6RGRpeGp0VmpMRERCbXRQS2tER2VUdnRTMUlxWk5ra3BCaEFS?=
 =?utf-8?B?Mmp5KzlTeFdOSHJYcUlCUmtmTjd3dnlBOGdmaUtVL1p5cEVTMHc4Q0kyU1lS?=
 =?utf-8?B?cmdUOUJMZk05L2YxWnQyNTN0cXJYTitvVzJ4akdTZy95ZEtBR1ZaT21XcEpQ?=
 =?utf-8?B?dmlCa1pXZ0NpTXl2b2ZyOHlsTkx2aVRVZjlyRU9rNGtOc01DU3R5MVJUZm9Z?=
 =?utf-8?B?Vlo2MkJTVjNLdjNDMytzTTExYVRkRXpVNG5POUx5dmZ5NzY3Q0FDWVVLSzNE?=
 =?utf-8?B?d1REalIyZ3RBMGFoWVlOeGhVMXMrWEJENUtBS0xsVjIrM2xaTkZ3UXJ6VlM0?=
 =?utf-8?B?K1BkMENYL25kR3hLVVMzVlg0YVc3MTFQYUY1ZzUwUjJOcitYdmJDSEhzV0Iy?=
 =?utf-8?B?RVhVNEQzQzB5SlNtd1JGSkhwb2g3dmw3V21Cb3d4VTZuL0pVKzR5R1I1QjB5?=
 =?utf-8?B?RXVUQUpySlV5UW5naWYwMFpGNFdERHZoY3VMdXhsdFdJNkdGNC9TMUJWaHF6?=
 =?utf-8?B?cDMyZXBxWWZFWC91czQ2WHBJcG9VM1ZWT004RXhOV1RkMjAzR09vSGdmNGNj?=
 =?utf-8?B?b20xT1VUamgyMjR1cG1wYmYvQmxDVjZHMXdMNC9iYmJYMVlWbjZIL3FlSXRa?=
 =?utf-8?B?VEpNOVpjQ2RCbzhETkZvMkxjOWVUK0hEOGdwT0JwRmRPaFVERFFsZkR1RFoy?=
 =?utf-8?B?RHFFb0J3SHRucjJ6ak5iZERmS29GWnFMM3JUYnZ3OWlkcnRtR3hybk5kYTVy?=
 =?utf-8?B?OFFjOFRJbUppZG52aGlSZzhtZFNWaWVNYlZ5S1FGaGdXc3dDMnFoMUJOMHkr?=
 =?utf-8?B?RWNaRk1tNWtzWHNXOFpFekUvQ1ZnaHBtOTV4ZDI5ZlQ1dS9GTjlyaUk2ZDFi?=
 =?utf-8?B?Z00rcnUwVWtHQVNOZDlxUXl5cGFtTWFJYTF2ayt5cytlTER6cUp2VExDRGRw?=
 =?utf-8?B?Mmh5M1E0WG8vUkZWbjBEcmg0WUFBOU9kYnFuK1hsV0FrcjFKU011Mk8rcE55?=
 =?utf-8?B?VDd0a1lEMDJDbFJCRklxamp0TnNZTlk5Qmo1U2xaU2M3VmFWdS8rd3JoY2F3?=
 =?utf-8?B?bVBsM09xMEl0NlpsZGJ4QmcvU05jWk9tVm45TjhnYW1HS0UxamtnZDc1Mkls?=
 =?utf-8?B?K2U2VE1jTjZKQWxwUklXQi9BT0xGbVM3SUdaaTBFb2Zpa2I3Sm1vN3JJRENs?=
 =?utf-8?B?MnVFalg5aXhJeFFDNWZoRHJkSEJHRk5ZWUd0RCtwbC9LU3loZWFrZGFvZWt3?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9b1e16-553b-4a4a-a810-08db20af3ffb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:02:08.3358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0nawE9Agw3GyhQeFEuEwr11lMruTTnmHgMuMrbZ1w3oTtsbaTJ50CEcj47Nw7yrYBTB//IBycXEiCsotnB/2OCMBSl43IGPwWBQrROuM0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
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

Hi Petr,

looks fine to me.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 3/9/23 15:59, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/containers/share/ns_ifmove.c | 98 ++++++-------------
>   1 file changed, 28 insertions(+), 70 deletions(-)
>
> diff --git a/testcases/kernel/containers/share/ns_ifmove.c b/testcases/kernel/containers/share/ns_ifmove.c
> index 12642c6f4..60dda94d3 100644
> --- a/testcases/kernel/containers/share/ns_ifmove.c
> +++ b/testcases/kernel/containers/share/ns_ifmove.c
> @@ -1,43 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /* Copyright (c) 2015 Red Hat, Inc.
> - *
> - * This program is free software: you can redistribute it and/or modify
> - * it under the terms of version 2 the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> + * Copyright (c) Linux Test Project, 2015-2022
> + * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
>    * Written by Matus Marhefka <mmarhefk@redhat.com>
> + */
> +
> +/*\
> + * [Description]
>    *
> - ***********************************************************************
>    * Moves a network interface to the namespace of a process specified by a PID.
> - *
>    */
>   
> -#define _GNU_SOURCE
> -#include <stdlib.h>
> -#include <string.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <asm/types.h>
> -#include <sys/socket.h>
> -#include <linux/rtnetlink.h>
> -#include <sys/ioctl.h>
> -#include <linux/if.h>
> -#include <net/ethernet.h>
> -#include <arpa/inet.h>
> -#include "test.h"
> -
>   #include "config.h"
>   
> -char *TCID = "ns_ifmove";
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_net.h"
> +
> +#include <linux/if.h>
> +#include <linux/rtnetlink.h>
> +#include <net/ethernet.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
>   
> -#if HAVE_DECL_IFLA_NET_NS_PID
> +#ifdef HAVE_DECL_IFLA_NET_NS_PID
>   
>   struct {
>   	struct nlmsghdr nh;
> @@ -55,50 +43,28 @@ int get_intf_index_from_name(const char *intf_name)
>   	strncpy(ifr.ifr_name, intf_name, sizeof(ifr.ifr_name) - 1);
>   	ifr.ifr_name[sizeof(ifr.ifr_name)-1] = '\0';
>   
> -	sock_fd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> -	if (sock_fd == -1) {
> -		tst_resm(TINFO | TERRNO, "socket");
> -		return -1;
> -	}
> +	sock_fd = SAFE_SOCKET(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
>   
> -	/* gets interface index */
> -	if (ioctl(sock_fd, SIOCGIFINDEX, &ifr) == -1) {
> -		tst_resm(TINFO | TERRNO, "ioctl");
> -		close(sock_fd);
> -		return -1;
> -	}
> +	/* interface index */
> +	SAFE_IOCTL(sock_fd, SIOCGIFINDEX, &ifr);
> +	SAFE_CLOSE(sock_fd);
>   
> -	close(sock_fd);
>   	return ifr.ifr_ifindex;
>   }
>   
> -/*
> - * ./ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>
> - */
>   int main(int argc, char **argv)
>   {
>   	struct rtattr *rta;
>   	int intf_index, pid, rtnetlink_socket;
>   
>   	if (argc != 3) {
> -		tst_resm(TINFO, "%s <INTERFACE_NAME> <NAMESPACE_PID>",
> -			 argv[0]);
> +		printf("ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>\n");
>   		return 1;
>   	}
>   
>   	intf_index = get_intf_index_from_name(argv[1]);
> -	if (intf_index == -1) {
> -		tst_resm(TINFO , "unable to get interface index");
> -		return 1;
> -	}
> -
>   	pid = atoi(argv[2]);
> -
> -	rtnetlink_socket = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> -	if (rtnetlink_socket == -1) {
> -		tst_resm(TINFO | TERRNO, "socket");
> -		return 1;
> -	}
> +	rtnetlink_socket = SAFE_SOCKET(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
>   
>   	memset(&req, 0, sizeof(req));
>   	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
> @@ -115,20 +81,12 @@ int main(int argc, char **argv)
>   		RTA_LENGTH(sizeof(pid));
>   	memcpy(RTA_DATA(rta), &pid, sizeof(pid));
>   
> -	if (send(rtnetlink_socket, &req, req.nh.nlmsg_len, 0) == -1) {
> -		tst_resm(TINFO | TERRNO, "send");
> -		return 1;
> -	}
> +	SAFE_SEND(1, rtnetlink_socket, &req, req.nh.nlmsg_len, 0);
> +	SAFE_CLOSE(rtnetlink_socket);
>   
> -	close(rtnetlink_socket);
>   	return 0;
>   }
>   
>   #else
> -
> -int main(void)
> -{
> -	tst_brkm(TCONF, NULL, "IFLA_NET_NS_PID not defined in linux/if_link.h");
> -}
> -
> +	TST_TEST_TCONF("IFLA_NET_NS_PID not defined in linux/if_link.h");
>   #endif



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
