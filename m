Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FA0C433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 14:57:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F04933CAE75
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 16:57:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4B423CAE66
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 16:57:41 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 127D120093B
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 16:57:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4Q1WcjP3C4R/QVnzyTMazeCE5V39a6QYM10XtZ5iSugP4QAxrs+FO/2a50IbBTjwVI9boBqvFldrPgRsA8MmuBCl6TTVS1jIhS5h3r4c4KNcjvFsKdbUo8KZq+I1s56f0BoPPya9FbaBMwHaxZ3kvU01IkItqBHFNV04m4t8EsHR9Y0XbE5SBFXB/zqxVai4hymVPDGqFZphuDvwnofijOrVQGwMpaWSE5Kvtm7B2UOwmwdc3aCu9iW55h8puQVkLS33Foif9mxe6WNG8TczW7AWY91Qh7H9+9U2dpp1IsNMatSgNhX4DDAN07af1mano+8cf3OeUzOvS/8PI+hMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yhzCOhVE8dO5ipYMv61dfY6hZJYIQgS0kROpbuLalQ=;
 b=CEFUNATF4CLxXCBg6QU6aod9oADP9miUsR2xC51UivR70fVaGGzL1oLuL7gHHILyCQaRCi5QJ8WpbMZ8eItR9+dAg8YqGo0Z7hremsM8sGjOXbNk7ejYuJPPLZ+FHFMwQ6zMwHo1lmaQ5MhEw81uXYJ8QRzL1UW/H12jq1nPdDt42rS7iO6/3RjaA+7YF6JOJB0peSIl1Q7h0WCVE9O2HDeuhz03Fe27/ikNt/ApN1smE8HBJ34uxMTlYL4LsTu9hYhwTUlEg9qgmcbjUU33jztQ+lPJL0O3LatiP90vaCOiW8Qb/406Yf+HKfKzkwf5mjUAPYxpThIbBZOTMLrmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yhzCOhVE8dO5ipYMv61dfY6hZJYIQgS0kROpbuLalQ=;
 b=OPQaIT+a72wqE8q7FKrJRLNUp9bc9lGt62V268tU67VcS1PV2gACFEZny4CPdePtATnVO9nB8gbYx+MMneMYLJ62FLwYa25hVkJ/ZV2vpoj9lJLvnSSLndzTiOS2ctmYOMG7WrVK6Sk1/s3fMyxX4gZiECSaJ3UR8TE4FHN4kMVkMG14EHj0I7nT5eiNKmqScYjHm4Kkx4CMMGlaitRmOwqrML5SatuVSORhcvj4Eqj/bsHg/woFc7EYI4yQsNg7Xagr6krG/dW7KAOcEOmIjuzSKLq4J8fIWYLwRRKWpG9n55h54GQ1SO1slqH0jK2akxUoUR88qj+KA4QNkCD3pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 14:57:33 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399%6]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 14:57:33 +0000
Message-ID: <ffd61505-cdf5-42b1-8fa5-7a3a81bf1ae6@suse.com>
Date: Mon, 10 Oct 2022 16:56:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: ltp@lists.linux.it
References: <20221010141823.26417-1-andrea.cervesato@suse.com>
In-Reply-To: <20221010141823.26417-1-andrea.cervesato@suse.com>
X-ClientProxiedBy: AS9PR07CA0052.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::27) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: c12f5808-8203-4cf9-a1dc-08daaacfc2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDCHxNAdKJKevOyTlzN17S8rDRQbHNXwqSkVIIO88bQwdy4c6S1XJWKspDTEpbdIA874YIsB8m36VZ33tSUjESonFhHCdkm6ketxifymW+6TUh8+yfzqDIHw1HkkRtWR96/Lq96WYwpK3SSgj2zlwoZASJbFVBx3d7GiKwjQ5ZzUJK6fLuOD7b21zlXHErecYbJWab8Ih3l0CrhcqCrX5ism54i0Oh+aEY0ReRTLZgQ18zbMNsm5RBXvCYYvMQAMv7656oOEJN3q2+hnB853ohDfBenW7UzI3ARgtFCciK+krnXJWgrY7bSqBhGHyQSMlbkZuIjFVuNa1iKo7xMgGfoLDIy6Taxv0s6Okb0qaZTiNG0DnbHwaw31Q1bRLRpoeuQaHkYLDd3BdPIDTuTHKwcz9/jqnHt4k7ehEUCtlILQpgxbZUQwxQ2Al1nxveLgHAUrzacAqKwScIb8Luymo3CquhrxFF/n3LWl44RBvWPJcUZpiUe6NelCJV+gKCU2aktECpuPHzXsmBEdGLHRZ+CIIsqVZfoJ3hyLz7hzWyqjGt8ADw70P0lqRcgVwjTvWAzCbjaIAZS+4iK7/iHbl0KsFiW8vxZTgDSH3iAnU7Zv1ZARggJYP3ID1k56RdBTFUjJN+89qzHNaEJ5l98F9NyfVxVZmblh2N6hXVhqead4ebcj64Szc4SJEudOXu99DjfFcf0WjlPpV3zX7/coVaUbDKKCT8IYzoFS1LCwM1TONlN+moaa1MUUM5fpRp8nYLbMovODOHeIF1H1KnscwFSn69kmcwqcdXLpMFe7haY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(136003)(366004)(376002)(39850400004)(346002)(451199015)(6486002)(31686004)(8676002)(83380400001)(2616005)(31696002)(36756003)(38100700002)(6512007)(2906002)(41300700001)(26005)(478600001)(186003)(66946007)(53546011)(6506007)(6916009)(86362001)(66556008)(5660300002)(66476007)(8936002)(316002)(44832011)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHNxeW5SYUJSOWlBVjhXZlBKMXhDNTlKUHhTUlRuVXc2MkxrZmp2YUZHV2Z5?=
 =?utf-8?B?YjY3U3NGbkhib2grYmNTOHI2KzAwdm12b1NoNWp6T1ZaR2pSY3hFdXFiZFA1?=
 =?utf-8?B?djhjV3RhOFBLVDJmQ2N6RlFmcXBGb3Nvc2gzNGhsMlpJQVNKay9YSDFOaXpC?=
 =?utf-8?B?QkdveWJ0VGJzdWJHbityUVJ4QnlZeXBwZTNYYjhzUU9lR0F3YmZmQUljQ0Er?=
 =?utf-8?B?WCtKdFZteDlPZGdtWXE3RkZRVnJpK2MxcERDUzZSUlc4UHdTMVZNb0dHWGRS?=
 =?utf-8?B?VTJ2S3BSUnpDTFZza2FIUnZhRjBrSk9ZemRmcjd5UDFPOU0zV1BCYzdhZ0Nl?=
 =?utf-8?B?YTRMUTQ2N3duclhWTHlSSVh6VjRadzl5enBHU0JTTTVQWUFScXl0bUlkV1VT?=
 =?utf-8?B?VEhUYmtlaWlCeXNwTEJPbURIRTJVUDR5K0hXSExkcVpNajlCQ0V2aEJKMTZu?=
 =?utf-8?B?cWZIVzRjc01vbTYvMHI4VHhidFlDbTQxN0syeWdjQ09sSzJ0S1p0TVptMHJG?=
 =?utf-8?B?NFVhL1dBR2FpQXZTWWZhb1RGQS9FNHpaRU4vcWs4cmdNQUpQdldPbUxCbWZa?=
 =?utf-8?B?dE1mNGJrNGcrZDFJV0NxSmFPQXBYV25sZjFlU2lobXJVYndidXp3bFJ4Mm1k?=
 =?utf-8?B?S1B3SlA1QWowUkRRZzY2c2FuQzdPaGVCejlwWnZKVGZMdGx4aUhPZnVxbHJ6?=
 =?utf-8?B?OGhXM3BOdG9vVUtNVjRMR21TZnFMMnc1c2p3ZXRkcGJNZXRCbjg1VmFuMXZX?=
 =?utf-8?B?RzZXSkw2WHV0Q3B0VXFQTU5xSldvZW9DNEFUVHNXS0oya3Q4TXFLZmQ0eUdr?=
 =?utf-8?B?bnJrcXNtRzR4SWRXUkpXa0N1V05rcEo2TXFPNmJKR2FLWGFEcWhheFZRbmVI?=
 =?utf-8?B?azluaWo3dkZnR0NqQUN5TGF6RDZ2dGVtOWhlK29BUGNjVzdnRitzekRVeW1F?=
 =?utf-8?B?S3BmQ3RkYWhkcE56WHNyZFlQeGJmREExVUZENUg3Z01jUWdqVk5Id2hvMWN6?=
 =?utf-8?B?VmdpMXpJNXJzaEZqdkRGM3l5NmhhRWx5YXBHcGg3ZEJRL2NEQUtRWjBZcHVW?=
 =?utf-8?B?OTVTeDQ5aWJReDdNNmhET2RUZ2pDRkxyL2gzcmdqZG5JYlBza0FFMVlrRjBQ?=
 =?utf-8?B?aWl2UkF6WU9zS3ZCbkM4eldnaVhlbXpEdTU2MldpeHgwQmhSZm9VWFoydXVE?=
 =?utf-8?B?NjhYdjRydkt1Ym9XajhKTjBxdTRMNGJEL2FoRXZoUHFBQjVuNEJiNE1RT2dC?=
 =?utf-8?B?YkorUXlXVXFRNkVXOWVMMWtWT1RQTnRZMXdIYTlla2dKNW02Z0g0K2doWnl6?=
 =?utf-8?B?ejUrNW9BM2RndUdja2tHeXRlWDdoY0FBaWJOell5UGI1ZkpMRmVWcTNueXZR?=
 =?utf-8?B?dG1qL1lMREYzcXhLRnVPSHZoTlZHclRHNlZ6Ly9mbjBSdUFEZDF6aDlSODBo?=
 =?utf-8?B?OFZxZmQ1dWYyUnFBTHNVTlJNZzB0cno5NmRYU2dtbVpKZ2dmUVBNc0hlRDJC?=
 =?utf-8?B?dkJKdjhMUC9UTUhjZlcrNmtCOXRiZFpWdWpyNWdWZktWam54UHhHTnVKWVhZ?=
 =?utf-8?B?dkVPZ3YzNU1RdWRmWlZJQWFEZFdZUnV6VG92QXNLcHVDUFBORkpRUiszK2wx?=
 =?utf-8?B?SFNyWjhxdHlYNlBnbHN6TTkzdXdUMkZWV1hWZlRiekRFaEtyRVV3b01vUnNr?=
 =?utf-8?B?cEYvM3hVc3dHSGU4L0QvQUswMGpITjdPTDJDOUo5VC8rVmV2L05FUWY4L3BC?=
 =?utf-8?B?aDEzajR2ZmxOd1FOdXdVMmVMd0VPZ0ExYUtTSEIvMDY1QmtuYlJRS0xxU2t3?=
 =?utf-8?B?ZDJZR2g2aUlkQlBJUTIwRDhWaU1EWDEvLzRXMXlyeVY2bDJIR2cwdUpFY2tC?=
 =?utf-8?B?alBXdklVOVh3Y0ErenhOM2hFc29CdUN5QzJMMlZKanlnc0RwSVZ5ZWJhZWhF?=
 =?utf-8?B?L3JMQzBUOFUyMHJ0Qmg2NkZ0WDVXL01PZUszdUtIY28zekdsL2NNSzkva3V2?=
 =?utf-8?B?eTdHTXBnNkN1dmFpVFBkOVVTUmxjOXpaV0d5bHdGL2wwNVhnaVF3b2owVm41?=
 =?utf-8?B?S3Ayc0c0Z3BJYVZkWFhzbWVQMlNHakxVNE9xeFpsL1BVQjhrTzdpV0ZMd2xl?=
 =?utf-8?Q?q8Ns/bdcvH3i1iiXP/xt7AHZi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12f5808-8203-4cf9-a1dc-08daaacfc2dd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 14:57:33.1540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3xNjiK9gU7EBM1Vg6InllKvZqtTbhZSvsZG5KiwuCwj/4Vy0QcKjQAXYWWITqHiYunS/KUkrwwp0hUr5mZUn7xLK16nKxujUh7vVXC0Lqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add epoll_wait06 test
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
please ignore v1 and consider v2 that is fixing make check.

On 10/10/22 16:18, Andrea Cervesato wrote:
> This test verifies EPOLLET functionality.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>   .../kernel/syscalls/epoll_wait/epoll_wait06.c | 97 +++++++++++++++++++
>   2 files changed, 98 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
>
> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
> index ab5a9c010..8c5ed7c5c 100644
> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
> @@ -3,3 +3,4 @@ epoll_wait02
>   epoll_wait03
>   epoll_wait04
>   epoll_wait05
> +epoll_wait06
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
> new file mode 100644
> index 000000000..ef3883e83
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that edge triggered behavior is correctly handled by epoll.
> + *
> + * [Algorithm]
> + *
> + * 1. The file descriptor that represents the read side of a pipe (rfd) is
> + *    registered on the epoll instance.
> + * 2. A pipe writer writes 2 kB of data on the write side of the pipe.
> + * 3. A call to epoll_wait(2) is done that will return rfd as a ready file
> + *    descriptor.
> + * 4. The pipe reader reads 1 kB of data from rfd.
> + * 5. A call to epoll_wait(2) should fail because there's data left to read.
> + */
> +
> +#include <poll.h>
> +#include <sys/epoll.h>
> +#include "tst_test.h"
> +
> +#define WRITE_SIZE 2048
> +#define READ_SIZE WRITE_SIZE / 2
> +
> +static int fds[2];
> +static int epfd;
> +
> +static void cleanup(void)
> +{
> +	if (epfd > 0)
> +		SAFE_CLOSE(epfd);
> +
> +	if (fds[0] > 0)
> +		SAFE_CLOSE(fds[0]);
> +
> +	if (fds[1] > 0)
> +		SAFE_CLOSE(fds[1]);
> +}
> +
> +static void run(void)
> +{
> +	int res;
> +	char buff[WRITE_SIZE];
> +	struct epoll_event evt_receive;
> +	struct epoll_event evt_request;
> +
> +	SAFE_PIPE(fds);
> +
> +	evt_request.events = EPOLLIN | EPOLLET;
> +	evt_request.data.fd = fds[0];
> +
> +	epfd = epoll_create(2);
> +	if (epfd == -1)
> +		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
> +
> +	tst_res(TINFO, "Polling channel with EPOLLET");
> +
> +	res = epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &evt_request);
> +	if (res == -1)
> +		tst_brk(TBROK | TERRNO, "epoll_ctl failure");
> +
> +	tst_res(TINFO, "Write bytes on channel");
> +
> +	memset(buff, 'a', WRITE_SIZE);
> +	SAFE_WRITE(0, fds[1], buff, WRITE_SIZE);
> +
> +	res = epoll_wait(epfd, &evt_receive, 1, 2000);
> +	if (res <= 0) {
> +		tst_res(TFAIL | TERRNO, "epoll_wait() returned %i", res);
> +		goto close;
> +	}
> +
> +	if ((evt_receive.events & EPOLLIN) == 0) {
> +		tst_brk(TFAIL, "No data received");
> +		goto close;
> +	}
> +
> +	tst_res(TINFO, "Received EPOLLIN event. Read half bytes from channel");
> +
> +	memset(buff, 0, READ_SIZE);
> +	SAFE_READ(1, evt_receive.data.fd, buff, READ_SIZE);
> +
> +	TST_EXP_EQ_LI(epoll_wait(epfd, &evt_receive, 1, 10), 0);
> +
> +close:
> +	SAFE_CLOSE(fds[0]);
> +	SAFE_CLOSE(fds[1]);
> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.test_all = run,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
