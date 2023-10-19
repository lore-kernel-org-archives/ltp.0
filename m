Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB4CCDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 08:58:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 803623CD09A
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 10:58:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9914A3C84B2
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 10:58:24 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C5128209A1D
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 10:58:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbDeA2TkHdzxBTsFiLPlF1lwVE3+vULQJCGSjgBpURBpfWmrV/qKsJbg1K39w7sO0sCeyy66BRED+3HsBDUjabz0FoCcQAavqb8TDz6KemglZ0cnpcV4mHsDkaawtLYmQISTwQsdTYWQUjTbJsXyXpR5t6HAh+AjfijAmsJWHxAS0inujA0IWPxQpqJR1AicucjOfA/HRke6Q0hmng2c5XsE1Y4BglHe8G5D/Y6IvHBI+6YCQK5UdMteSnvVYrTLcadMbKESe76fW/Hfjg7ax9kMW1gJ3odg4SJA/I+aZ4yvM4jaoJI00qBJ9qVBbCtZffUCPQXv0oDjmM0q1457DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+61beECNdMZ/9Ax3eFapwz7jBVTOBZTfWY6bt0AvU8=;
 b=HCTiN195C7oKcDWUBxXbIEu25CdUSA3LTKFvg2iQwNHkdaTnpIkOQTZL4Uhct1eXC4qv50WJlgKjgelix2y78CDsAKK9r+0RlXln62lq/FVQP86IRVHGyVtV5Tl5NfYRv3NcNCP2n5VH168GQIwn7xZohtgAEc7WelIun2Gx20N0thVabv8ggxFqvyRK2CVc7OhxIXv21Ei5UwQrhxbGxgwJ9EK+BeoTNgrJb2zyVjTotYHgwICRJzwmix6F42v5kZtaq6T3XKYwXyee97utNcF064l82P/ZcbPWmmscj7fzARf8yMEO2ySruBKuo3ur2LeD/3pIMfNv+qQV1wbgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+61beECNdMZ/9Ax3eFapwz7jBVTOBZTfWY6bt0AvU8=;
 b=2wirqwGOUa58vrUiD17+sdL7GFuKg6vCnMBkAfOFh6n+2ekdEHyU7JjMn6zyq6OQiy/i2A7jVMx+mEFDby6YiARIzqwm2TzYo0vGxChRtOSY7lDnbbY/J1P6trXPdvo62yKAx0e6Oezv6Jp4+lmNVsB0WCn8K6xMDcSR/2+lkizf8JsIM1OqBe1NCcw40ZHrzh+xZpwyFs6q48ZOWJdvAKZhm1/gZCdjHujCmNWWBgQzLO0sL9YnxcS6HhU2Du35NfUDYGzgKN2i3xcnvulXDxuHUQK27DZSyq9Ju26bedHdp7HgK2ZE3S5KNsUfHYnPupgZuJSEMdQJauD8V4nRTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB8PR04MB6793.eurprd04.prod.outlook.com (2603:10a6:10:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 08:58:21 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 08:58:21 +0000
Message-ID: <1f088ac0-fac1-40c4-91eb-accf629daaee@suse.com>
Date: Thu, 19 Oct 2023 10:58:19 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <272dd7b41f4e1049c7428d2de2ac97814ed900ba.1697705468.git.jstancek@redhat.com>
In-Reply-To: <272dd7b41f4e1049c7428d2de2ac97814ed900ba.1697705468.git.jstancek@redhat.com>
X-ClientProxiedBy: FR4P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::7) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB8PR04MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6febf4b0-bfaa-473c-e28f-08dbd0818b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzUtnucq4Gl0jx7if24i/NGeHDCd2pNkMqiJmTefc9Ufa4vo8lJXkZJxe1lyMp+CXjf6x1MQIDwJB2zhOkOZcIB2ToJays/I8uCtqsvdg/+LMa0C+ldtsCiHK7xpnpRphTJF03D7j3rHe9bEWW5EVFwCk4v0DAOPAUGvwgb7wkyIK4G6SbnkYjQMSL3EKOQ/CUEZWQ3qIM79Y5EPIVd/72CMxgl+KXoV5sds2i+2eSZWvunUhkAsqCzsv6uRKS7AvalpoIXi55wfiorH3uOp+SUYyLp4k9TwATY8LCKiMOgGvOyLaL/9KqF/z1BqfwV/ZssvRJksBSpwGLjrPFj8VtyjeSPeHrEwDK0cP8g3lKAi01P6K5/+V12QNm8FNGUVvR01FhUYYTP0x6YU/Ozy7nE2WllkvdxEbtmD/lHie1u59ieTr7R+Fywwe2avIA8QZUGiAqonQJFMsfS4838L0tShZ8+sB1mbIWticOaYMmXjQHmZa9mW9U8kDyWTPJqTI+ml9ViyUwQjcpuCfLU8tF+aQEGZK3H8TgIOL1i73GRaL3EhmPVy029Te901LDmJQq/L9XlUiUJmmEyOCijs2Pi7FEU+X8Syt8XxchABOnXZFBdhqGffSf4nGUEPaoBLWI3qnd+Og7biV5aWnKk3bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(66556008)(66946007)(66476007)(6916009)(316002)(8936002)(478600001)(8676002)(6486002)(86362001)(5660300002)(44832011)(31696002)(36756003)(2906002)(6506007)(38100700002)(2616005)(53546011)(6512007)(83380400001)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVHYzM0TnRzcm1sbUxrc1lrRE9sVy9LNjJ4K0R4SjVWRlkwN1dkdzgrcU5Y?=
 =?utf-8?B?Mk5oUnMxRnJpUlpJT3kzcjBqQWRCTllsZnNWc1E2aEw2MDdNWVgzdFFyazU4?=
 =?utf-8?B?TWVwZnR2bnlLQ1FCOGxIZmtWU1FveWdHcFAyZEtYSU5mMU5qb3RlV0RjWDZ4?=
 =?utf-8?B?QzJIVU1uMm5IZE1RSHlZR3ZnNjRMbmkyOWFKM0p4RG0vUkplcWI3OWYzdXFT?=
 =?utf-8?B?NzY1TEdDc3V1dXVNdjVmbVZVRmRaMjFqZFpEQ0oyaFlSN2dzSU9CVjdsZE9P?=
 =?utf-8?B?bFA4aytGbkw4OVlZa05vdWh5bndwNnkyWk5CKzBjRmN4b0ZkaEtMaEg1c0VB?=
 =?utf-8?B?Mk1RUlZ5YW5YNmREMlNHNjZpa3pHT043RHYyUGl5UzQ3dGNFSDZ6cyszRkdD?=
 =?utf-8?B?TUhYc3lCVC9nN2NzVUY1Z200TXQ2b1RRUlh0K3ExdGdUWVZ6MFVnQTNmV2RR?=
 =?utf-8?B?ckxEWG9QU0ZkL2UxajVHWWc0RWI5TW14c3FpOVZMQjUzckc3UmxkTHliSUVF?=
 =?utf-8?B?ak9iVVlSQmhWTE82SFRhdXgwL0JYb0d0UFMwekp0UW1Uc2ZrWDhUQUJ5TkxC?=
 =?utf-8?B?Q0ppRlpJWDQxa2orbDRyeUpRbXlOZW9FTjJ2aWNzSjdGSU53UzF1SVhob05L?=
 =?utf-8?B?YjZNODRXd1VmRjFwQlJ6WFpMQk1tTWQzNG9FS2NBRVdsdmJFRWFOSzFOYmEw?=
 =?utf-8?B?UmFOZ0pUU0poQ21BMURSZStYQWw2MkNkM2tRL3QzSiswWWlCbVlIeXpsRjNM?=
 =?utf-8?B?UW1tSGZOVTlPUGJFWWFPY21CRUZhbU14aDlhNjhLMFZ5ajFXSnRWajhXQ2V6?=
 =?utf-8?B?bStSY3l3L3BVK2hWN3c3VTdsU1gvTzhlbjBZQkJuNThIS3FPMTR1REFRTUxC?=
 =?utf-8?B?NHcwZzFrcHB5YWhEb3F3Zm5wajU0aEZtT1NvdmY3QU9za1RDeDExUU13VWtm?=
 =?utf-8?B?V0liUDlVbDNWbjdaRjZ4c3ZmeXdHT3Q3R0JtaCtTU2dzYVV5cElNQ3hzYWFt?=
 =?utf-8?B?UHF0L1VEb2dDc0lpWU9adElxQ1p3bC9ZclpFL0VsS3p0OHByTjlxR3BPRGdV?=
 =?utf-8?B?N1U1cUpWSk41UU00ZGl3c3d2Q2dTMWRON0QrTk5mVFloQ3NDMHNRRVAzYXNy?=
 =?utf-8?B?eEpaSVN2ekFyMHp4aUl4dXJyV1hFOHp5VTl2c0dhMEd3ZDg0Q3lMZjdyVXZF?=
 =?utf-8?B?WkxURFhIYTlZYU02MktBZFhkVWM3Zi91cW9ScUdReXM2TjlJM1o0ZGV6OXpT?=
 =?utf-8?B?SkhIWEJnblg5aFozQzVHTUtTODBZTGZkR2p0WW94b0lEb0FoVEVTZjBIM2FB?=
 =?utf-8?B?dXlPSVgxUDBjSTRyK3J4ZDBFbnMvSXh5UTRVU2lSUTQ5b0JWZlJlR1AxRE1G?=
 =?utf-8?B?TXhHL2srck9vZkZkd2xMMHFRVlpQb3FwRXh3R0JvSDFUVjR6NVh3Z3A2S0RM?=
 =?utf-8?B?Mmw5dUEwMk1CT05SbUhBUW40TzNxTnYzQ1hYRkFYMVpCQTJhcFNudWh1a1Ft?=
 =?utf-8?B?dStneFFOaHU3ZnZOWHI2MHRCRzBpeW1ZdEZzZDJteEJDMkxYZVJ3TnN4a1Ey?=
 =?utf-8?B?dGQrekI2aVVGUjljcE4xeVdJYWpWVHBsRnAyTGZlSWFXdE5wSm1VTHJKMWVl?=
 =?utf-8?B?dmVZOTJiUWNlMmhlRHhlV05LODRoMW5xaGNFRTliWjBsYlE0Z3R6dUdaTkpv?=
 =?utf-8?B?NEJOeFo3QW1zSlJMKzU5VzB5MGFURVNRMUlPQjBKNG9FVUJERmhIeHQ2SlNZ?=
 =?utf-8?B?bXU4N21hUkl4M1lHOWFWSHc2dmdPenFHMzd0QU5IY0JBUzBDd1ZrcjRDTCtR?=
 =?utf-8?B?ZUlabWxxMFdaSkVvcWdydTVkNzFHYzRvNm80UjUzWHg1czV0SDd0b3FvS21n?=
 =?utf-8?B?cmljL00wU0U2MnNyVzNwUXBpM1hhQXdmWUpRRGxBRlBXdDhmbHc5L2NpY0d4?=
 =?utf-8?B?dzQrMHlCUzMveG9qd0luRWdXYTNmMTBIa2NoNFJET3VjK094QmdKN1Z3QUQ0?=
 =?utf-8?B?Um4wMUZVWlIvaEwrbUQrSUd0eWc2SEhpMy9nbFpkckRpWVFxTktEL0lTT2di?=
 =?utf-8?B?MjBHTnVFaVpEaWdja2Z2aWlWa1E0VVZJQ2dCK1pWbmpsUzJxOWFEUVhJb1E1?=
 =?utf-8?B?WXcvRXJEUlkyMEZDMHE1NTJnZTlYSStzNVZDS1VQaUxhSWx4WXBsbFhGY0ZO?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6febf4b0-bfaa-473c-e28f-08dbd0818b49
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:58:21.0953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvQ1Jh9jvqAY/NwkptxIJFMx4qoyurB/c2qQA+IPID5bCSSMyMSoAdNuHs1/4vAfGoA/N/52lHYXRw6f8m8KEddvNSeaWOJZF9B0nXbrXyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6793
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/process_madvise01: fix smaps scan and
 min_swap_avail
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

On 10/19/23 10:51, Jan Stancek wrote:
> smaps matching can prematurely end, because the comparison to "VmFlags"
> string is not exact. So depending on address on line, it can break
> before it finds Swap line. This makes the test fail on recent aarch64
> kernels.
>
> min_swap_avail per documentation is in MB not KB.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   testcases/kernel/syscalls/process_madvise/process_madvise.h   | 2 +-
>   testcases/kernel/syscalls/process_madvise/process_madvise01.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/process_madvise/process_madvise.h b/testcases/kernel/syscalls/process_madvise/process_madvise.h
> index c4570e5309de..5b227ada099e 100644
> --- a/testcases/kernel/syscalls/process_madvise/process_madvise.h
> +++ b/testcases/kernel/syscalls/process_madvise/process_madvise.h
> @@ -54,7 +54,7 @@ static inline void read_address_mapping(unsigned long address, struct addr_mappi
>   		if (!found)
>   			continue;
>   
> -		if (found && strcmp(line, "VmFlags") >= 0)
> +		if (found && strncmp(line, "VmFlags", 7) == 0)
>   			break;
>   
>   		if (sscanf(line, "%31[^:]: %d", label, &value) > 0) {
> diff --git a/testcases/kernel/syscalls/process_madvise/process_madvise01.c b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
> index 322b4cf60353..0fd3c1ef4f80 100644
> --- a/testcases/kernel/syscalls/process_madvise/process_madvise01.c
> +++ b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
> @@ -123,7 +123,7 @@ static struct tst_test test = {
>   	.min_kver = "5.10",
>   	.needs_checkpoints = 1,
>   	.needs_root = 1,
> -	.min_swap_avail = MEM_CHILD / TST_KB,
> +	.min_swap_avail = MEM_CHILD / TST_MB,
>   	.needs_kconfigs = (const char *[]) {
>   		"CONFIG_SWAP=y",
>   		NULL

Thanks for fixing this.

Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
