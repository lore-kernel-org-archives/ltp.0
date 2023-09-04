Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF27DC71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 09:45:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 236F63CB8BC
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 11:45:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D86B3CB911
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:45:15 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A03F1400FAB
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:45:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNWaat4TDhIojGdbEWqlNxANFo7ZFOeDnwE6UmZ259Muuq2Y1Foztcm0iF9CC2trM5CFXsXRIgsXCYYQ3Bsa0FdCbj95oA3VME4dfKNm12kQJiOUvXWj0H9qIi7cRX5BWd5oWxITosjwVh2QQgI3lORlpsC7EMeERno6Kg47trQXwe7kjb4T3o3y/I6Bus27ss2vNGF1+8oXi2mZTVA9WOZbVEjPZX1relf5AwqFnyaFcde+mcBvfmcu7okqr7U6YPtqO+Afkt4UVJSRcLC5Dsvh7ugHSxt6wnhHlmGyhy1Zf+IUaPQBK6OoECLw40F4IMonZDxQTUDniUhIh7JKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHMFjjIp+ligK+5kAO32WA2jVpLE+70P67qtINHfXeE=;
 b=QiasPe4CsbP/zTW3s3VQEOAasCa7GZq9Oq/aEZyWpK9qd4RL2SJDUKzLbmsx8ziHe3IIpmh4Dkajxt9Rc94OR+I7NZokGAhAfI8PfgF7h/kURRvS7op8CHPZ340xk8Xg701pSfGbTzklX01xmLsF9Kw0YQ9jOz8/EngJHKqCG9iKqss6i3eG0PpbYWRyIbGeBLxoYjlwuG0wJndYUhJHZ4Wx9Mz/qghIkGKZAoiCPmfnSeABQRoLqFYSAZuY5Nt2xCzrVFCAcnD4gKPWmS6CfJ4oPPmWgvxojHqVh/BbZvzwsvJKmsSqFlsa1dDHjmv27Z9t/N8rVP+2fWnmylHCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHMFjjIp+ligK+5kAO32WA2jVpLE+70P67qtINHfXeE=;
 b=Xp5ZJukzrFAqCA8pjL/X0cf7QEtROCAdwRc1+gdCPuBZm+Tbp/S4w9I0q+y5IIIhzEit5HT7UjzNwdUY2M5sQ4/NqJC4Gh2MqsrtxQN1P9Z8wcRuU4Fcr0RQlq0SSSK2nINqDUzmpw11b7iquILVUZe5uslGlPlM2igfAKYZ06GZknv6vmirY336T3VzfKjBsD7bRIl4vgz7DNgRRISomacH6T0oiM19mHR5YvbudYOpX/O0eIPUJZ41Nmtg+8pKbN0+YY01bf/qRUgaEStc98Ebi74XxN/xSmSsw38xfIEFkmy6TEkU9R7vZKzKtj1ZkhI869nqLIvtMeV7na5srA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB8182.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:45:13 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:45:12 +0000
Message-ID: <9d77e999-07e1-492d-809c-2369c4bda759@suse.com>
Date: Mon, 4 Sep 2023 11:45:08 +0200
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230904074443.24701-1-andrea.cervesato@suse.de>
 <ZPWZ190rmjWsso_a@yuki>
Content-Language: en-US
In-Reply-To: <ZPWZ190rmjWsso_a@yuki>
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: a206d398-71ad-448c-8a46-08dbad2ba287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BpTxR24P3ZEgrmpPFmNhMPaS1NZSpXDmkKXT1jJlSAXaZTPLpxNkGrjveelxLcjM2Rk+7B11iNfnV9QoBmjCegYXrc1JlUzuh4FRkkodHPmr9iOTMcJcOlUAD+vhHw87H/H8eXhxmeOgVaryDoYBznaw9cG/g8oFkn+kvWpm66z9WjbpBBLJ0hfxF7jyuxBpzChks2HLfLQTNCzExn2Xj+NnvxVa5P25wHuJEYQC8SmlcLTxB6NF5vgVMmECKWgOVjnU63YNw/WVdsUVhx/8YVx6+b52mzJhd0JE34k761DkII6U7OZBCw2hvLoq6aoSgO5qKsp8HBmrIi8KKLazYEcn+jbzUqvK2M9w/2krEvlNHTtOlgqE5Uf9utNoZnWe0bp1+RrvHypwxwo1lHHzkKVixMDq3ovuWQpGUMO9zDL1FRf+DXWshmqicYHT/HLEK7FxSk0JY7BPEpCO+hOvfQPLG7TeP1B+3HTBkoSzOtU9egHhruQoITrjG2ReQscKuNCi2QF4z2KQIj9c0GW+NUS2+T0+Bq+4CLUF1aafXxhNB4hN/7/gsEMT89B/pLw3HTMx4JW9rHKrnTd/EsciH2jN5S+Ko9u7iwgYwkjiwlKcT1l/fQq0KlMkqxtYGWsK+JFK1AzwTHCERy0ZC01YiP9Z7CZlX1cFDHLqBDaOntTf8Sa0HaBeAQ44Y/Dua7s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(26005)(6506007)(2616005)(53546011)(6486002)(6512007)(38100700002)(31696002)(86362001)(36756003)(44832011)(41300700001)(8936002)(316002)(4326008)(66476007)(66556008)(5660300002)(66946007)(110136005)(31686004)(8676002)(2906002)(558084003)(478600001)(6666004)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkpOdVlScTVIblliRjZQS0txdW5ad1NwR0NEV29Eb21RZUl5UndDaERWTGw3?=
 =?utf-8?B?dTk1aERrcW5BRlNtMTVHRUdYTVJkT3NoL3RicVJUQ0pOdTZKOUZSUWtiLytl?=
 =?utf-8?B?aExTNE5PQzF6U1AvOWQrZExtQlJST0xlY2x5RTZHT0RiMzk3Q1VtYlNHTGpy?=
 =?utf-8?B?bFVwRklIQUs5RnBPandtYjVSaWJZUFEzSXNXVkw4M0txalQvTzZEVFlOUG9o?=
 =?utf-8?B?cGFSejZiV2pKK3J4bkU1d2hjZFBpeFZqdS82TmdtMVVaL1ZRVVEwVitiaWl4?=
 =?utf-8?B?UHRHOUhhZUdlMFc4aHRsdW05Q2l5Mzc0NE5ySFU0Y092TVFITjNrSEsxZDJ5?=
 =?utf-8?B?RWU2U1RYODdVWUR1Z1d4c2E3U0ZjK1l0UWh4OHRqbTN4T1FhZ2JFb3EyelZq?=
 =?utf-8?B?WGM0YXh1ZXpLaXRTRlIwTjhyQkJpVDd0Y1Jxbjh0VHgwSGxqbDdFalBnSTNp?=
 =?utf-8?B?bW5jL21ZOWhvQm1UZzgvTXRLTFFTRDBKQkJpV2cza2lwSy9qVHF2MCtIMEhL?=
 =?utf-8?B?dTNQYnpjQW5kN0FudCtaRVloVVluOTJoMVlndmc0Z1BhS0hpbkY1ZSswVmNw?=
 =?utf-8?B?ZjhlNVN5ZmR6aFNkckh0ZnVUREZ3c3VJanAycmxCRElDc2dYMEQ0K0VKRU9M?=
 =?utf-8?B?UVB6SityN0poeWtGUDlqWENkbXpaVG12R1dHdDE4K3o1Wjl3MUVUajk3RGFP?=
 =?utf-8?B?Y29tY0pjRGFzdlIwMmlPQW5vdXFTNVR6NW5qM1Y1TjVmMWh5emxjQVQ5ZUtO?=
 =?utf-8?B?YjI3cTlBSHRaZEpieGNSSEx4TGJyUVRzQ21yenJmWWhVRzdoRENOdStqVVJt?=
 =?utf-8?B?cGVVbi83aHVRNWV4M3ZCcWhsdDg0cXJIQWRCUDJqYktYWnhQMFlYNHB4UTdY?=
 =?utf-8?B?YWRiRU1tZTBoQklraUY2NUZiSncyeVRWRE4rcktQR0Y0VXVNRWwxd0hVMDJk?=
 =?utf-8?B?TjFBTlkwNUJML3ZRTnQ4UDBMVEoyV3BNdHJYRk1YeURmM1I4aFlWclhPUWJ2?=
 =?utf-8?B?MWNGVFMxTlZLMUFQUXlzUWh3ZGdOczg2Z1FCNFV3YlhKVFpUbXlUTGNSSzgw?=
 =?utf-8?B?YVNPYU5ISndxdjFGM2xBY05aVW5GMDhCb1ZqbHd0VlcvYXFuWFlDVWNPQUNs?=
 =?utf-8?B?VU1Zc1BVZGJOdjZHWFpyRWNZTTRvRFhoWlMxQkJjeTlZdUhpbWQwNFh2Y0xX?=
 =?utf-8?B?SkQ1M0FQeHAwRzVRUmNpOFEvTjVPVDJqVGtCMFp0aDZ2NVNzSUVXUnJvamt3?=
 =?utf-8?B?K3FDVDhnbFhBRUdURkhVdHNmU2xGT0pZS3lPM2ZBMTZYNk5rc01yV1lDdEZl?=
 =?utf-8?B?VTlkMU9pQzg5KzFLSGpuT1F5SHVpOVNiWWpVM09FRm41MmRVOTdwWXpkc2Ns?=
 =?utf-8?B?L01Ec0NrVDR6NnZTRmJDcE9HbngrMENPWkJiWm16dnBJekVBT3d1b3R1MUI2?=
 =?utf-8?B?TG1yQTdpd0JsL2hlazNZbjRVTnM1T2d5Qm5wVms0am9YUFgvR1ljUjlNcmVB?=
 =?utf-8?B?bVBCZEVrUnliVW5IOEhwYzZudHg1ZTZjQWUydTkwNy8wSExIdjJ1REZpd0Fr?=
 =?utf-8?B?L1IrRkIxYk5YcXBFNmNBRm9kYzBnTkNMT1FJdkcra0ZNd0VDRzFHbWlLeC9W?=
 =?utf-8?B?bzIrSW5MeXlyeHlTb2p3K01kNWJxcmx4RWJLdzZaTDFYYjUzdUxqY1RoUFA2?=
 =?utf-8?B?b0oyYks5N2ttS2JJM2VlRkhoVDg2c1lSTDQ4T1dWRFY0NnJSamc1VXMxSk1C?=
 =?utf-8?B?dUlHSmdIQTZGUHVSSkgyNnhkeWxvR0dDRjR5SEtpMTNXNXJuRVNSektUcnF0?=
 =?utf-8?B?ZGpXODk5STNNUmFOS2UwM1poMHc5NWhoSXd6SGl5T3pmUXZGZFZaY21TQ2tK?=
 =?utf-8?B?WldISFRvdmgzUWhCbHZBVGtIdUpMdG1jQmk1akwwdGw5a1FmTi82WDA2Nzdo?=
 =?utf-8?B?OXBWWEdFUm9lcDgyeXdSYkJFQThHVmhiQ1EwY1dyTzFLcFJObUkxejlRY1Yx?=
 =?utf-8?B?RVlNa2hXUFpwa2NjNjBycEpoSVJoZmkxUk10cE0va2JiaUxrV3ZLVCtrbjBq?=
 =?utf-8?B?aWZMUjFGM084OEE2VTJ3TzlVNHNtT1krOS96THdMVUlXcHZqT245OXJabGNV?=
 =?utf-8?B?ZmZ5VFNuTnBESFBjS2hCbW9BMnRjeHdGZWRKWDRiQTJWTkRJN25lVzFZL2t3?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a206d398-71ad-448c-8a46-08dbad2ba287
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:45:12.7029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BelSitPR/ziEg0MRgmShSPP0lyCuzdXQkAtdSjTaFodYNnh4Vec5A7INMs3NbdgtMOyh7yXwoth/4Gnv1G30onCyaYr7nO3J4Iic4RduApA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8182
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] lib: add .min_swap_avail in tst_test struct
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

I can send it after this patch.

On 9/4/23 10:48, Cyril Hrubis wrote:
> Hi!
> This looks good, but should be immediatelly followed by a patch that
> fixes the process_madvise test.
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
