Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669B4CA5511
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 08:55:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 460E33CB2F1
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 10:54:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65D3C3CB2A9
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 10:54:47 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47D11601091
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 10:54:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpzD0G//HTr4X5wMXartA8RiUUUrLOCxoaH/Bpd5LDjueEnuAOmSDnCU6Xq4AR+ydRVV7h0FCptM+dhpUbtD4lX/E4S1fjEoYQHsrjUkwIcV2cE84uan0KKTfjs//DVu4gdzdpF8xgRgc3UsbiS3dxEtUCAAl85PLOPUSWvnzaOHAUltWbJDSw+9jOKDqv3q5NjGkpzeoWu262Hx9wj5hxHJ7g1mGzSMi2PQ//gbBV+ZQzrTr+YB3KcFL6ECDewh65403x4d+ZwKBC8DqDP23eqZDXD7/1kmaNIdxfj6pKtDcV0bOMcWwXWckwdevXMBb6PQ/ai7dHrrGyquhc9dUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO0GKowRW/X8lnLjbTUYKoX9YM0bZzV/7uUbTQ3alzA=;
 b=XvV1BMbtx9tNSbqo890ZATGaO8VVo2/t5MkP3Eowt4FH9/fi9SybVBhN1RKfLmo5OJbH6urCOczfbkJXeJKNr2kdlRcbMOd5Pfh+zlTYKfBWHdYGZ7YsQ20U3AlK8cMIRvBrG4iqIrmwPagSZQMX77Ci5VtG5lyEIxlQKL6kBdNUfRvCoUKfyDFk1lq5soPjMJGZhTbukB25drsjzjrBlZGU/QkXm3LEAfbsJWjZzFdF06AX8fg//NtHlBZuQjIOTMKVrUOFetS2Bt3rmAC6ZEBo+BA6murpXHVemolquL0f1eWjVxw55Rj43GQqKN8ULEXrCkY7WCyQNYFnSwIVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO0GKowRW/X8lnLjbTUYKoX9YM0bZzV/7uUbTQ3alzA=;
 b=B6eAIw+7SApKH9iyR+fGEtzUGd7IKOl/bp8YbHl6gzfdq4URPwDFBv9d/WhOW60I2FY/jgQj4fy4meT2Lw3s+a1jAK+amastaPJA4hwnJk+dXcEaLL+diZQQUeJ73XyGDf5qgC/JOUj8JCIZIEw1o22GJ3Xoh1KBkHSP3HenV0jh44D8bSHMrEYq/QPjciFNIaDq91ypA8rmknKQSCOtYu2AXfoKmIpvTsBx1vBoLjf31t2xHb6hUGlnGVb8x+3BDxPvi5/7rmzK6DkVTsMQkkIMHedTO3qtCnpIoltLHvlgycNMJZBBaf6VaJd9TijHVVhTGEpZXspwOwXD17UsIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 08:54:44 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 08:54:44 +0000
Message-ID: <1eeeb56d-3a8e-45d8-b275-394b43be0bd5@suse.com>
Date: Wed, 13 Sep 2023 10:54:42 +0200
User-Agent: Mozilla Thunderbird
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20230912144351.13494-1-mkittler@suse.de>
 <20230912144351.13494-3-mkittler@suse.de>
Content-Language: en-US
In-Reply-To: <20230912144351.13494-3-mkittler@suse.de>
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b29f621-cdde-482c-ddd5-08dbb4371304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IMgKtS7IEcH11VCukcEhGYKqe78VduySPa95v2jfeR/ungMLaPmx0wMYzlVg+skOletj5yspltzy7/AE4a5So1bBx656wo5U+LjggNrQQxpl3NoJIroYXuekcV2RdBUvTuGRO85m7TXPpcbkMK1DASyEtBxxdXqmiQgm37lh2yemV+r14MwHrB2MEuTDNwnn5q8jE9d1Hvc224eN4S++CHK/2NiwC/kheBnatTY+9ei8Th91mWHI4MK9kd+hKK6Ye6QGTi+H+QOGBnCawuUvjgXIW7TuIQX6ADz0brwMQ/ZTtvieNN07HDCgzQF4ZvncY2MOpdtiw6hArfHrS2mP77bUAFdwgnECLIuogtEaZtVuOF6boXkiG3t5JMlQqs5sORmy3vrBWvCymO2DolORGQ4w5cQM0BafS3E6DBLihNZACmVSJXC+hrkr4BZpM4sF97O7iGzcEe1ZUdm64CC489dQT2gIaPCbq5ZOBLSjq27Xhe3hs9TMGnQG98h1LxewTMguEKuKJl85Z0GeRza+2q/G13QGse8FWRivoaVQJcy92VZJn/nOt72Q+Lw1oX4tIQsfeDyyhSBwHHdxdNOWtHatYvhEyXDFftjY6NBroZ+S3zkSMiRKcNrLKOlld00dUEQHXxHQALLf4o7ExnyCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(186009)(451199024)(1800799009)(31686004)(44832011)(5660300002)(8936002)(8676002)(6486002)(83380400001)(6512007)(6506007)(26005)(53546011)(2616005)(478600001)(66946007)(316002)(66476007)(66556008)(41300700001)(31696002)(36756003)(2906002)(86362001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzhRT0hkQ2VPN1RHWExTbEtmNFpMT0d2SDNXTFRJY3hkcHVkK05SY0RoQ09h?=
 =?utf-8?B?aG1HYVF2ZStOczB0VnBiNHBVZHlUbkZrUHpPdHltZnArVzNmcTdoNDV2RWtu?=
 =?utf-8?B?dHI2UndBNVFoVHFGR1c3Kzd5U0x6Ny9SaWVSMG54SThPY1NZbEt0Z0VuZnNG?=
 =?utf-8?B?NHUzUkZoN1pNbE8rUFVDWGhSdnNBVTdCSlFoSlZtK0ZwMEtQcENGYTZuSlZU?=
 =?utf-8?B?bXZWc1BNZzdZNzBXK0dwdWJKT3lSVXMxYjNHTWtzQXVaN0tuZ1haT1ZrSWlI?=
 =?utf-8?B?SDRaVUZ5UllPSlBXMU14aDkrODRwUXhOdE9sT1FFaGpSS2w3SnM3TmptZGFJ?=
 =?utf-8?B?SU5vTE9jUm5aN1pCRHorNVRPcHhnUkhFWTF2dGord1dXK2VrS29FbVhnU1VX?=
 =?utf-8?B?cTVVMWxpUUMrc3JYOXNvSUN6VVQ4QnA4VnJiY215dWhtK0JVWEJWL1hudWc5?=
 =?utf-8?B?SjFOanIwTCtOWHg4ZEtkek1FK091VVhudXZTT0dWd3BDdVg0ZnBRTnZia1Fz?=
 =?utf-8?B?THNuSkFYSUFGU3pkaFlzcUNpd3JiVGlYYXF1aDJ5cXZXckZBYThGMW56Z2F4?=
 =?utf-8?B?Mmp0YytSWWhOcDY5U0wxbExBVmIxVUdJbEFvdEhPenNCNmdCbWNhSENuWTdQ?=
 =?utf-8?B?SXpYNC9NWjQwdTZyQ0dXSWV4L1JkUDBOK3F0Nit5Um9VNGJLQk1qUmgzck9E?=
 =?utf-8?B?bDRTREJWcW9Ub3BCaDlzZUxqVWFydHJCQ1g0bVpXTC9sNjk5dlk2NEJVbWp4?=
 =?utf-8?B?NHk0NGs1M3FYOTFXYUdQd1ZiaEpZeW9NS01XT2E0L3piemlPN2dnMlJ1bHJw?=
 =?utf-8?B?cXVSSzRxZUFsaFVDckZLMWRqaG9HcGVSNm1KNGRUckZLa2tCVFBSdXpvQW5m?=
 =?utf-8?B?VDZTcWdOYWU0blJHQTIxUmhpYmZIV2FEc1ZBNGJNSTJmOHRzcm9zL3Vhbjdh?=
 =?utf-8?B?WlNqejdyb05Nc1VrVlVRWDIxZmlsREk0TnV6U1hYTG9SZWlDZ2J0amE3NEhN?=
 =?utf-8?B?NXlZOVRKd3RjaGNaQmFCL2ZWRnFNZmxOdHNwVGM2YjBCL1ljWjVwRlFtS0sx?=
 =?utf-8?B?WUNQdytnbWxEVkx6ZlRZdFFnR0Vzazl1SElSQ3RINDJnU0pNaFV1UG9Pa2J1?=
 =?utf-8?B?WUhycmM5NFlYZFFQMUtUS3RBczJESmxYaEJZdDdmTXQxOU1Td3dmVzNjRkZq?=
 =?utf-8?B?MXVyMXdHRXRkM2Rnazl1dE9LVzdzclZVYnJsdG1oRXRWVjFtbVdvQVRyM1JV?=
 =?utf-8?B?SGZwR3N3QjBkeUJzNkxiZkVtOVMwYjl0KzFDV0k0MEc4VGVqcytRc2xSTThz?=
 =?utf-8?B?d0J2RUNiUFcxNmM1STFYWk5CRWI5Z0ExMThZQ3R3dXZlTkVsVU9uWFpud3FU?=
 =?utf-8?B?Y3RuRVZ4cEVuSFZVZkJHUkx5Wlc5SFVScnhlRktUcXhEMVppbzNxMlAzcEQz?=
 =?utf-8?B?TzFia2w0emRvR1NIeFloWXo2UjQ3UXI2bjVnRnF4U0Z4WkJpTi9BN0ttV1Ri?=
 =?utf-8?B?bW5DREV4eFh6eTVDWkVvQmdSQWo4by8yN0lVcndGR29XNm8vZHFGMEJHYXhO?=
 =?utf-8?B?MGQ4L3RaK0dYY1YveE5CcFVUclo2QVh2amE5aWJQQk1XRnYyZ2JpSm5CbVhN?=
 =?utf-8?B?KzhjaVdqSEYyYmQ1MEVHWnE3VTZUZWJMMHVYN0U4bDk5bitMbWZXNSsweDgx?=
 =?utf-8?B?SFI3b1JiazZNOTF6K0ZSamR1SGtPSlFvZHhzZVo5U3JrYU9UNzRvWkpsUHRs?=
 =?utf-8?B?WW00MGh2TVh5S2F4QnpiSGVvWkZBMVpvLzBWVTdvNzhvZDN1VExjSjU0Vk9K?=
 =?utf-8?B?cXVpZkhHY3lkUjVmaXRLU05BcU9oTUVxRG5tazVKTGZaa0JMSUpvTXJCRWJx?=
 =?utf-8?B?VDFiQk5kLzdvUHF5Y1NzYk9EV0NZQTJtenlVM3h2VlJKbEhIQWdPZ2NHNWZY?=
 =?utf-8?B?V2tmSmdXSnNZbWdTdkROVHRxRXNSQ2pCMG42eG5QNUN5eWg2a1poZ0JielZ0?=
 =?utf-8?B?U1h1N2Z5d1pUNWQ0ekF4QjhRSVhtTHgrVVhaV050UGZvWmd2UWREc2oxSnNq?=
 =?utf-8?B?VUd4Y0FvR2pEMHlwN09FNnhVVVIxNHlaWElaQkFHNjIrWjhxazZ4RTYwOG4r?=
 =?utf-8?B?U2FraUZJNDlkand1dlppWXJhancwN1kvTFloOERGSjIvc3V2MkpUZXNHUVRn?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b29f621-cdde-482c-ddd5-08dbb4371304
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 08:54:44.1984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioGHvfAgSafIh5wVLkpVoh8JC25DpV1AAWiyqqzEKvr9iiVsLUwUepC8Q02qzY/VfircXEjEnwa/SmO0m/bbMUltVYyd+2KnPDBn/sFL9Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] Prevent segmentation fault when negative
 task count specified
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

patch is simple enough to be applied, but this test really needs to be 
refactored, as it's almost untouched for 15 years now and we moved to 
new API long time ago.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 9/12/23 16:43, Marius Kittler wrote:
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>   testcases/realtime/func/rt-migrate/rt-migrate.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/testcases/realtime/func/rt-migrate/rt-migrate.c b/testcases/realtime/func/rt-migrate/rt-migrate.c
> index 2554f63e2..252e77e6a 100644
> --- a/testcases/realtime/func/rt-migrate/rt-migrate.c
> +++ b/testcases/realtime/func/rt-migrate/rt-migrate.c
> @@ -419,6 +419,10 @@ int main(int argc, char **argv)
>   		numcpus = sysconf(_SC_NPROCESSORS_ONLN);
>   		nr_tasks = numcpus + 1;
>   	}
> +	if (nr_tasks < 0) {
> +		printf("The number of tasks must not be negative.\n");
> +		exit(EXIT_FAILURE);
> +	}
>   
>   	intervals = malloc(sizeof(stats_container_t) * nr_tasks);
>   	if (!intervals)

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
