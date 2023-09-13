Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9717DEDEC49
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 12:02:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89D163CE789
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 14:02:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AAF43CB2BF
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 14:01:58 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 176131A01975
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 14:01:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TibvblXrLZ5lFZ1Nhg/9f3SR55teDel0W+EEX4TW3KWmLS9lWR/gW5hhj8WJU74Gxhursk6inrhbh9t0m9YumK4X15m1sXkrbQhjv7lQETcw58J8Z8Gs8aZadxBfsGjm4F4hm/kmcKtd3bjClOqWAxKFoHxnmu1ZDhAZboyhnVB6w1OYhVBxZCwewmdBpaD2QnGQ+XRz1CfqNsJyF4rAGnlQdcqkSHxv18KxzqjGLd4RRoMoXv3bdaatyEyNeuT8QwkVIswJ21pLAzblny7Lf/JZ0qSIkBPdsnBJuPUZ+hmGNrBCOHria3iVFhrMCcA21C29cdgsmBoCfltto1CeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujKAtXo4Ey/+BIvTm6PoS9DPxGJIKBUuRjdIEc2DDHw=;
 b=D8kOnMcuLOHK+3FQHxofPgVicOQtA7bRPYaubRnTs03TqZv66F7noPFhchFaNxRZIVbmPf/yEW4SA2VTFDYvB3c8JlRws4G12P3Md2VKhI5W4jMuu5HDVX5K2bnWWUhWYZJkJ38qOxdgiHY5TN3k6PJLMI1I/ECBR9uDuvJd9lxKagR/InBNa1mMJJVR+Os9nKztKySp4E/nKudSwkdQbOQFeDltRyzLQI2szXPMZt0RGO08wx0OkC1WsTCILPnb0mlsOK+E0Rw+8E0NjoaXN0wgQ5R6zCybZ+NzyovELloplkihjyaqumvEQcZG1BcNuEIzT4WMnoyHogrPCYhqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujKAtXo4Ey/+BIvTm6PoS9DPxGJIKBUuRjdIEc2DDHw=;
 b=EK4bYcrBCAHoTwOYe1tM/PzqZfDvr8695X5plHKMjGSwUyYL9HrexxzI1floGqL1VLhqDtQfaD9liPHtkpqqfxRewFXCnyVuN71crVhMWdWefBEhDz2C3Y82wa72ZNlKJq/isDw/MoDfncFfFAtmTfMGPl4gs+zLKfMkIIUlPBRXY0s2oj8RpNaixYkhcPuPo7920+D8xzBDYuVZDA9pkypZu9DV0a0TglxaDe5tjrpncAV83d/XnhnoSSFMCEMg3BJewU4YOWuAw1SPetCEcT5b2Fzlt+Gb5tiZSeAivMuWmEzmCTzLbYYpr87qUgxCj8R4YUx+0sUkX18OhtYGtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DUZPR04MB10063.eurprd04.prod.outlook.com (2603:10a6:10:4af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 12:01:55 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 12:01:55 +0000
Message-ID: <2415cdf3-5143-47ac-bb1c-302708227b75@suse.com>
Date: Wed, 13 Sep 2023 14:01:53 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230914182259.29435-1-limin154@huawei.com>
In-Reply-To: <20230914182259.29435-1-limin154@huawei.com>
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DUZPR04MB10063:EE_
X-MS-Office365-Filtering-Correlation-Id: aacebdf8-ba06-4930-be0d-08dbb4513949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ox494hmpk37xHnLWWz7sVGgzTInVs7gfP/78k5DvbBPOQ4rgERYt41PJEepDhfXr/D6boQwJ+vaKv6enn8XxpT7JC5IX0O9OLD4v9FQsMbKKtyMWsbQdINQuVkFi35BoLR6VYzjdOWE1mx/uKZAAZv/oI89Y/aN7MQd7B2BVq9lxA2mKvVYu+RjVEttJGqWqLJn2uhZHP08iM4eZRtJHjmisr0BZyDWHGr8PYnYzmz/aVsp4Xqq+ZyN/IOhVoYm1YgUFAWqLCNTxzW4T1AOrh+3fz/z5TeN/uxNzODyRaB9wZN+hzl13Mw3kSV93vYSDSPP4lQDhnzmaAwiOGdfyn5Nus9sIcjC0yi+vpgNr3QwJLzRRwb8UvH5yJBEgZIB7Exjpds/ASP5zOudq57XbmQOA0YOlluRUC/jpSlciaGoPfTpTAnOc0u3Tm7Xf7MuReOOSsbyHhWMOVIijiHG47fDjRpIb3Rs3ucp3MvHjnFZnepUu65Svd1XYrmYxZRePLigo/xXRh2llWJweGEWN4bMVmJgOeu3X98l8vPUUC8ZooGgV/iuFADNiDl0RBphOCylp0uiNrsta7XWDpB28eYu1fhj+mC9mSdj+IHao5xX83m6JZ/4kaCCwnXHtDMZu1RVZ8vSBOvKGNbioNcRpEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(1800799009)(186009)(451199024)(41300700001)(6486002)(6506007)(53546011)(6512007)(83380400001)(2616005)(2906002)(66556008)(316002)(6916009)(66946007)(66476007)(44832011)(8676002)(5660300002)(478600001)(26005)(8936002)(36756003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Q3R2svdllyVDdUVk9EbXVyRlJUMkx4MmFna3h1R2dVeHBDVkdKd1RKL2Z5?=
 =?utf-8?B?aGYrenpJTkY3Qi9aK2F3UWVqbitGVG13Z2hvbFNpanBaWkk1TzA0SVhzdUFW?=
 =?utf-8?B?MWtuSHNxNTYxM2FaRWhjUklVU3lTZEUzdjhDSnFaeTNJa25VeGpvWTQ3dGU4?=
 =?utf-8?B?eDY3TWNLaFNaMGhjbmQzZG5WRG9jcHlublpPS2ovejJ0TlozeE90eWxaQTd3?=
 =?utf-8?B?bU9RWURZSXdrdFY4WFRqWWhzQVVkblh5cFVsTHRuZ0Y4c2V4bGFvWlFpUzh3?=
 =?utf-8?B?cnY4QVFhTHFCUlI5c1FJQ0ZHMWQ0aUZldFcxbkdCRkxnbGd3WlIwaHU4cWI5?=
 =?utf-8?B?TG5KT3U1dzIvNlRJZ0RWaTZNN2ZGVW5tNUFHVStJd0h2ZnJCNDdoMjlwVktp?=
 =?utf-8?B?ZnJZMUdXeTVCU1l0cFdDUzc1SDFMWFUzaTFRNUoxNkFVQ0tnd3cvK2gyK0J6?=
 =?utf-8?B?a3VQdWFuQlZSMnl4SXZPWDVsalVQeHhRdExtMFI1RnlsUzN4cmNkNVJkZHBm?=
 =?utf-8?B?KytqUDJ6aTZCQWJEOEN5dkdGeGkwK0xHdVA0ZU5WYzBqY3hYcHF5bUx5ZjVw?=
 =?utf-8?B?N3FMTTc4RFgvVUEyVFNNdEdqTmk1czRhYktZa0VESGFUcXlDTE9zM2t0VnBi?=
 =?utf-8?B?NnVhRUR4ZjRGSTZoSTNZalQ1N1U3Q3pTQ2tKaUtibkJlNkg1dm9WUjdLc1lu?=
 =?utf-8?B?b0R1Y2t1QjBqWDhjMTVCbVNrM0RDK25mYXhwVy9FZzVaekVXTTd2L2VRWmx4?=
 =?utf-8?B?eE5JeHpvL0xJbC9qWTlZcThvL1huVk9sNElWdGMxRGFOY3dpYTFGU1czamZy?=
 =?utf-8?B?SW9SbmRpSWNNdklRZ2hRZnpYTlc2Nm5saEd5NnZwQk9remtvODVKaXZjMFU5?=
 =?utf-8?B?Q0N0Rmw5VVNZWlNRbXY3T05XRlRmTllaK2w4YXIzNWVTdU5hS2V1Z1NCS04y?=
 =?utf-8?B?eGpQSFZZYmFreEN5am42aTNVUGozUFlRZGJBVEZXQjI5MDhoSUtsMjZha1Vy?=
 =?utf-8?B?NTBGSlFGbU9kdWRERDN0UVdhSzFJb2hYaUdiemd0TnJPVlFPMjFiakNKMW9G?=
 =?utf-8?B?WS9RN0tVdk1IR0RUSUE1Q212aERkR25KRFFVK29iK0FqVTlVWFZpTy9CZlhX?=
 =?utf-8?B?MnlxN3cxaG45cVhNR3BGVTdMYkxmK1JCUXl5Tk4rWDNVOEI5UkxMWm5KTHpP?=
 =?utf-8?B?ekZCcjd5Yk9OOEtNdStLWmZFWnIxc0hzSU9DZ1RuQ0w3M2YxekZyaWdRSC81?=
 =?utf-8?B?YnlTZDFhUkdlenBTTXRuRkM3TlhaSE9KTkpnVVlzcUhqdEdIMi9zNWNQMXdV?=
 =?utf-8?B?dTVJbGxUSHFDVTJOMVNTNHVpRjZ6QWYxOHBUcGRpUWkzT1BrQzdVT0FCbUZE?=
 =?utf-8?B?ekFINEVJeERKSkNaaWRSSWs0WHZLYXFFMk15aG1CcEpkT1V1OXIraG1JOTZk?=
 =?utf-8?B?NkVDWXpzcUhFaTYyTDJKVHdleXlyUTRUaUpOcFFsaWxwWmJuamFpSGVZZ1lG?=
 =?utf-8?B?aG9WWFhxRDExbVVIU2VrUE9ZVExsTUFMb1lraVdkZFVIem9yZ09EQ0E0NW1J?=
 =?utf-8?B?R3FHRXluaGhTV01ncnRGeml4Tlhsa3VmOGJsaktjR0ZTYW1pWWVuem9hUGNL?=
 =?utf-8?B?eWJqVVFwN2xVNStEUEVpQy8rbDF3VTNNdUQ2dlZiYVBGMlRZbW56QjQwRFFs?=
 =?utf-8?B?aVkyQ3NBdVVMZ3kzSitXN3JGQ2E1WjdKQWJsZFBEZXUxakhMWk5ndldOSElw?=
 =?utf-8?B?V3o0cTF2QlJMWmZXZDZ2RkpsQ2tSS3FucG4zenBPNjB3VXlWOWlWNFN4cC9o?=
 =?utf-8?B?VzV6eSs5UXBnd1NRVkg5Z1h0K1hRSWVIK2ptcDVrdVNRdFRDTzhLMXl1Ums5?=
 =?utf-8?B?S2RnQmNTNmJadHJYWGpScHI2TkRZL2UvOEFXQWYwOGlrV0NGeXNpV2ZQWW45?=
 =?utf-8?B?WW9BNHZ4ZmZPME9NdVAyamlpMzJVbDRpT3RncTFYenY4MjgzeW1LaUJLSWdh?=
 =?utf-8?B?ZWdYZTgvbU5HWWJ5ZjZPaEg4SnY3Ry9wVlJ5V1lPOG5qK0RxbEpxWUlnT0R6?=
 =?utf-8?B?NFlKQk8wbW1FM2xzYWxaMnJsS21ESGdmRm9nWVNRRXR3dzR5QkFxTGdkUWpy?=
 =?utf-8?B?UFdDbEdOL3Jndytib3lBai9aQTl5RUlTRjg0aG5PcVhSYXNNd2hmZ0dZU1NO?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacebdf8-ba06-4930-be0d-08dbb4513949
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 12:01:55.0910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IvjSdqDE5/LJQNMuP+ekIcL/gP1FJIa8Ocoe1s7SaOn7y+m8sp4BFITtOpbAOry5RJ2EZKXcWMuZQIElOxEXP2CgcA9WZT1eAPokNDos0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10063
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] stress/udp/multi-diffip: bugfix for
 multi-diffip/udp4-multi-diffip01
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

Thanks for catching this bug. It will be pushed by maintainers according 
with LTP release code freeze time.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Best regards,
Andrea Cervesato

On 9/14/23 20:22, Li Min via ltp wrote:
> udp4-multi-diffip01: line 233: ret: unbound variable
>
> Signed-off-by: Min Li <limin154@huawei.com>
> ---
>   testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
> index 92af9e438..c0d50efaf 100644
> --- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
> +++ b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
> @@ -230,7 +230,7 @@ while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
>   	# Set IPv6 addresses to the interfaces
>   	ip addr add ${lhost_addr}/${network_mask} dev $lhost_ifname
>
> -	if [ $ret -eq 2 ]; then
> +	if [ $? -eq 2 ]; then
>   	ip addr del ${lhost_addr}/${network_mask} dev $lhost_ifname  2>&1
>   	ip addr add ${lhost_addr}/${network_mask} dev $lhost_ifname
>   	fi
> --
> 2.33.0
>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
