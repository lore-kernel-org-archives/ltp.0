Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B938EEDEC4D
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 12:57:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A4C93CE77D
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 14:57:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 196493CB2C4
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 14:57:13 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B425B1400978
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 14:57:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtLG84JRdvQ6/l+UxFaNQutarhy3k9Wfd+CJxcR/cfNxQHKcTJ54Oy1Yt4ySGZ7Nj0bXqod8s14gR4kuhVa1D40YZdvidxS+oxKQQeln3f91b/BJZO1HJ5NmnA4vDmQa8KbENyKV1vaLn7odbw3nBlQ5SPgCi2L1F/dptXxfZiGBZQOyTV5xxMUoJc+OVujKvccEnoz0Sy2aF1icukv3qThM0NLBSmLGW0/0tgzCmQ6Mu55C9nkyfSyn5lCuw2Ap9k9SAaODR5JS9Ma5gbEjJ6BuaoSY6FTLjVeqyIo+atc6ew4gLsBFRObGPZeOsy3PFoT1a38bcWk1mtSzA/GxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAgWNe2LgCpNjhUWO9TYDt1wx9RE4AbkH+P7ak1qMKc=;
 b=cVdRGwYwtcKBmf6POf+L2PV6vhTOYj3VR3hhIoXq4eY/ArDL2jZ/ZogiFM0Holi/81vOWqapwpacoBoRJEyRa6XOESuF2cpr2Ara0HtE5gFsONVKkYn33lCrFkGEeu48CIerWjwAqQk3ZztOIqTFjjpw7Ea6ae6b5iC+B2HcI4crKovTiVeErbJC3iN0DDhLCS2OQ18XIz+NDIsGIgyt9qUBojto0lNmsW0jGKxXfNqmU3x2LMnzyfYuBPVcXhlvSUYdEblPj8RvQFi/UagEeWyGmlrXVDWb5Yqw9CEwkOCp/Oo4uk52jVw+oxGCJ2abgmMqzgjcg+J5qWV7pNcWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAgWNe2LgCpNjhUWO9TYDt1wx9RE4AbkH+P7ak1qMKc=;
 b=tmZsVTnjIC4+aaRIJxFN09USgpLu7gELUTesSNSYT8jDh42YOQscTEA8AC0wyWWjYWpj7hrMD8KLYLUPjgLikAe29CTYulX2muPsoF8blWBKmqpz9psUTmnMl3BnJSdUBGndZKuofZ1+nYLKpomP1OLLNtvWplfqIDTFzVOiSwnMGMY2n/qQwGigGo9vcMvpLNoPOsq9rH5SZQtHsKMW3rmp+VxJytQ0EsiYHEPJGuA/OX71BpJI9M4NIbM7/DRNBQB305RwdOFd+SSf0I8p5/Bu33Eo2NL+1pVEb0aWR/T0HJd3ysDpR5g6A9eofGLNoo2TsNuZY6g5SYXyODyV7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB8159.eurprd04.prod.outlook.com (2603:10a6:102:1c1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 12:57:10 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 12:57:10 +0000
Message-ID: <f36ca896-a7b5-4131-b48d-09f19b9d534d@suse.com>
Date: Wed, 13 Sep 2023 14:57:08 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230705141223.31468-1-andrea.cervesato@suse.de>
 <20230705141223.31468-2-andrea.cervesato@suse.de> <ZQGoXAAPcWjLjear@yuki>
In-Reply-To: <ZQGoXAAPcWjLjear@yuki>
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 81230f6b-72dc-4b85-6b54-08dbb458f12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8YnUMOIMEyVullQTzRPv7Uv+Z9+HNFs5fP98eZorTcYqHjY5nDgAdI5+PM3ohK0AUuH0BiZKawL5fN6UgOdxhOe7pIxOgW6t+OaOrAig8nlHPpJUz2dokPbzhkwThdWzsg96MxJ9IGlYz3sai+sw/9KKl4U3W66cTIdqb3Ts0QarTxk7sgDI6vDiyKpldIhdD0ebyaXThqRnd47CWjB6uxVyRY4i0VewsHhMWG7ZmPGa7+Zy7pLUH+L63W1+dgrrIot2vxOlUZBfLZfGa8/XsanRa8ASHv970zl+QlYEC1hTZXuwV1yGGN5qAIKR4evlcJiWjh0dwJDCMkMaxSlRiFhdZ58+8qeJwjs7Rgq4ZsFvO8XkdxsA6GC3I+tPIVtBf3l53LF7U/Zmcwdgx42/XyRC5iJh2kuvKzf9zuZqn2tjIrak7spJ08WomGsRYO9T15TC9eM+AgQng5MmU/ZxFi1M0Sn0+amh+jyBLHna3QQ59X9/qVRK/TvBpv6f6jNEuTauBK0Ff9TEEeOQP0hpjAgStP9RhDw2+NJG4FWK6Do3J9fzesjTJpNaSBTy9HAE4nvO7HwP+uGHdUoiczPsPff2HArfLW4zfyve6X+wMBVrRrT67wEETYlNNDYaqE5jkm2BfW6K0urvSIFZJDT9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(186009)(1800799009)(451199024)(6486002)(6506007)(53546011)(6512007)(478600001)(2616005)(26005)(4744005)(2906002)(44832011)(66476007)(66946007)(66556008)(316002)(110136005)(4326008)(5660300002)(8676002)(41300700001)(8936002)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndLNDZnRWM4dlF4aTZQY2ljaVRWdXhvb2d5Zzl5dzEyWHVOTURJOEJNVW9T?=
 =?utf-8?B?bUNqVWZ6U056REtFMkp4RTZrQXpOTW5TbUJlY3oyaFk2SjJ3SUVZaXVtYU1D?=
 =?utf-8?B?dElQRmZTSTB4TnBWWmVENDBBZlN4K0dlZmxWQ1dGSGFiV241SHZkR2txdEZn?=
 =?utf-8?B?bGREbGtDQ0w4ai9IUFFXQk5IdkQzeHZ5ZHZvRVNrbloxdDl5Wkx6UVUxQity?=
 =?utf-8?B?U21mTm5rQ3RJbXVDYjE4a0xxN0lmdXI0ZmRWRVJIeHJqRDNrRFJna0ROdHc2?=
 =?utf-8?B?ejlrWHl1cy9TOGhvc0srcnZOMWlRZ21KVCtNdmpXRGkyQ0xHQi96WXNwZ3VB?=
 =?utf-8?B?QnZqSUREb1ZmSmZ6b2tNUHhqYzdURG43YUpOTDBWbUFFTTFmdmNhQVFrSGNz?=
 =?utf-8?B?QkhTdHBvSWQ1KzZlK3oyY2VSZDU1YUwydHZQU0hWVGN2T2lSQ2YxL2tFSllT?=
 =?utf-8?B?aWtRb2ErejlxR2lTQmJKazE0UmZnNTRPajFQT2JHNmNYMkJPQWFLZE5sNGRZ?=
 =?utf-8?B?RWRYcm5wRFRYYTZWVUFDemIraHowR3VNdTVlYWNiRlBLKzR0MjNFVjlkWmJh?=
 =?utf-8?B?bExBSUVtUTcxbVlvMDZYSXBMZXVaNHoycmRvSnJnQzBGTjhFRG8xSlgrd013?=
 =?utf-8?B?c3d5VEI1M01Jc2g4cjB0ZEcxVFlkNzdubFpPL25LUDlRUzU5ODh3WlhWY1Vx?=
 =?utf-8?B?QmN4cEtYR2gxdFU5YytmV1Eyc2JwTzU3YmZaRG9pSk5zaTlJV28xY29oUXBW?=
 =?utf-8?B?VjJPWEpMbmpOYUkvOGxkRHhXOTRPRTZRTWRsUmRkTENUREZwZ3BUbU16Wlgx?=
 =?utf-8?B?YkJTY1ArM2ZjZlIwYndxdndYTlRhdDBvbkR2YTRkaFFUNzIrYzFJWEI0TlNy?=
 =?utf-8?B?MnZBOHlZenZrK0JHNEFFQW1VR29YYXlYN2t4ZWF1K2VKTCs2YzZtbHNycmtS?=
 =?utf-8?B?NmhyQ0tUcXlCUzRBUFRrWE5ieWZyb1BiSnNCL1FYTGJzN1VSckxDNE1FcWlh?=
 =?utf-8?B?TmxEWlhLUzcxcTNwOWdEZVVlTGlKVTdmOGxRWUp5cGJlanZkQnJrNDNaZ3A4?=
 =?utf-8?B?NzJUamV6Q3A5R3EzOVVCckVWSXg1cWtSaWxXZlNyN1lyd0ZYWC94QkFaOEt0?=
 =?utf-8?B?ZmpNajluTjVkUy9PSCtqbEpWNTVDOE5VakdKc1czVnNtZ21LQnJXa1Q2RUsz?=
 =?utf-8?B?aUtqM1R1THc1TVRYWDhFU1dPSzA2QzdEVDh6TFFJZGU3ODFZMkxLWU51dXVq?=
 =?utf-8?B?WUwwRW8yWlpyRW4wMFkxd096TFpjeDBhR1cyb3VrTGtBUDZySGN2bEoyU0Vn?=
 =?utf-8?B?UDFodVBMNTdlOGMxWDh4ZkpWSGt6RGRrMUMxZmY1OXN4L0VyOEx1QVBSUjU1?=
 =?utf-8?B?YXdXS2s4c3BLK3h5dTFWQWVxSjB0NTkwWC9YYWNFLzhPQXdzVUVNZUs4eDZr?=
 =?utf-8?B?Q1h0ekZFY21kYi9SMFhCbG45ZkZnbkdzRU1rdmFlNXlmOWM4eTZ5V0FScWtR?=
 =?utf-8?B?MGZvY0ZzV0xOT08yTjBCeElqajJ0NWQyKzJTRWVwTUVEM2FLeXR0eXJOSlhG?=
 =?utf-8?B?UUZPQWpRZlBVd3pDOWVFVGM4alJuSzJGS1FCdm05SzZjMWFzbHJhWk0yQUYw?=
 =?utf-8?B?am9sNzJvRi9uRnZLTTdvR1ZqVElxTDkwMzFiQWU0d1NXNUNuLzRGL1ljbWpz?=
 =?utf-8?B?V2pMcTVJdmQxQnd3SElIQ2VrM3NtMGl5NUJVSVpXViswSlMrSEF5T0c3YVhx?=
 =?utf-8?B?VWk2WnNBcjJqTENBWEcxWWlHSGZINDVscStSVmEzbjZsdDFjYzVYdVdVTHFP?=
 =?utf-8?B?K0pLNmFleW1VYWJ5aVJ5SDZEZHU5OWdDWmd6M3lCNHlmM0N3RkZTUkJ5K2R1?=
 =?utf-8?B?S3NHMDJ0b0s4RVE0czU2Zk9qeHdkaGRPVDhHdWhPbGdjcnRxcnlHRlF4SlRP?=
 =?utf-8?B?cUZiT21ESXBOeUdPNmpTMWlIRWdmMnd5L2NXblRxQ1pvTHFyT3dUdlNwczZW?=
 =?utf-8?B?WEY5NkErd3pGS1NjSEJKK2ZsUi80dGExZkUwRGFzcUl5bkVCaW8xZjNQYzZQ?=
 =?utf-8?B?akZhT01MREJ0SkNwMzV6WFg0U2N6NmgyOFNTZDladm1ZSDVhZnVaNFdoa1lO?=
 =?utf-8?B?aGJkblhwWUJBT1pGcU1OTDhUQ1BDaTBGMjNKckx0dWI0bVRTK0V6aU5PWmhS?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81230f6b-72dc-4b85-6b54-08dbb458f12c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 12:57:10.1577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxniK4a4kbid0lvotZjOPLRWcSqyiW32LeVq+iunEiGoIORQaYKN/0dMF7gL4I5aisKx2WnX44+C8TyhVN0j2QmGccrgNGMid85FrpalgWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8159
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/4] Refactor mqns_03 using new LTP API
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

Hi,

On 9/13/23 14:17, Cyril Hrubis wrote:
> Hi!
>>   static void setup(void)
>>   {
>> -	tst_require_root();
>> -	check_mqns();
>> +	char *tmpdir;
>> +
>> +	if (!str_op || (strcmp(str_op, "clone") && strcmp(str_op, "unshare")))
>> +		tst_brk(TCONF, "Please specify clone|unshare child isolation");
>> +
>> +	tmpdir = tst_get_tmpdir();
>> +
>> +	SAFE_ASPRINTF(&devdir, "%s/mqueue", tmpdir);
>> +	SAFE_MKDIR(devdir, 0755);
>> +
>> +	SAFE_ASPRINTF(&mqueue1, "%s" MQNAME1, devdir);
>> +	SAFE_ASPRINTF(&mqueue2, "%s" MQNAME2, devdir);
> Do we really need the devdir and mqueue paths to be absolute?
>
I tried absolute and relative path for devdir and they both work well 
with SAFE_UMOUNT() function, but any other combination of SAFE_MOUNT() 
parameters doesn't really work.

I think we can left it absolute, unless we really want to get rid of it.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
