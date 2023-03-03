Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A957C64EC4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 08:48:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D51A03CB9BD
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 09:48:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C12233CB974
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 09:48:03 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 20D4F1400BEF
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 09:48:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ9y7WVeSktq6K1s13xtPHSlev4yXmfqDwhO3MUmg0zE+p3yzxuwLPdkenxpOaU6OcPpLhiaLiqekVkkCyqsMXzcPnPz+moVFaR4B5GwW1lcLToWolLk/NSNiULWlbYesOkQ02DniMeZHwyXRmLqthPfWzdS4Ld8kcHNixb73fHAXMob+kitJjPVlf0W3u6Dzy+PNIIpXANwLrQCixfuMh/Ev78SEce8cZ/HQj7JRMBIkE0ERGL34cmceYjBGvjKOyHXbgDei/s6+FcE+2/670+3UflYxzXZUgSORRodBux2mssv2/EeBxBLev6RBVp43zdTTYauo+PvKjSXIcj4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUhC3ZM4sOtkpjJz/evVCzwzbg6dJIsBEFXtFdfXoZ8=;
 b=jeAZT43/WFb/xZa9onf04fWA2hA1E74+twcQpjLvchbrQlolGqGKP373nZ1YixOV+ahf1IjCdFOa3JK00SLafHI+JABF96gxaVY0Ti5iB0wlmswnThUkfvxthqRtx3RufjFSxnqVDE5e13YGfiXjHWclMExhcJm5cmCQa6aA7gZaXvPUC9Z5DeI6882KG1AXyGx8KzNm441Ql8Ohut0N9bMqeC021FXHxlDC6rzLIoavadrCfsjj7Vl6iq6wbK9Pre2Dt08q+TejjiSPjt/HNHbPp3GPMN37PhnPkP7IkzLUv9JIa15LBtFEZIOwssIKLiASgccdq4/MVNemcCTSgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUhC3ZM4sOtkpjJz/evVCzwzbg6dJIsBEFXtFdfXoZ8=;
 b=vTH5X5DxlIeS7+h9XYFHcDh9Sz3hj+X7XiKLDFMc8LhTGO4/XAPSYy/FVA/saBwdwGxUhWsV8aqjhkPHf/FwB/yOxemaQVMtO1/e21qd/nwXld2SuOaaKIPv5rq1em2Oy7usF4KLdFH6JlArmTzVlA5USBskIB5vN4K6uXQiI6a2QBQ+0SSc3xw4ynTax/Fn1CN3ZXLHAgFXqN7xces+IRSyZdC9onYO69NpDfxZj6N1e+XL9gaOOLAu9dkb/wkuJnEDk711dkjkd9ffmalwz1Jf6LVfrUk3GYHPG/e/jYHMHodmWiQlddjdk8l3x7ni9I2/4DbQqRqPQZ+ZGzH83A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PR3PR04MB7242.eurprd04.prod.outlook.com (2603:10a6:102:91::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Fri, 3 Mar
 2023 08:47:58 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%3]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 08:47:57 +0000
Message-ID: <fdfff412-ba15-adaa-b3c3-1c4359ef1e10@suse.com>
Date: Fri, 3 Mar 2023 09:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230301152818.4427-1-andrea.cervesato@suse.com>
 <20230301152818.4427-5-andrea.cervesato@suse.com>
 <20230303091603.GC4255@pevik>
In-Reply-To: <20230303091603.GC4255@pevik>
X-ClientProxiedBy: FR3P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PR3PR04MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: c46deaa9-14d6-4c27-9d8f-08db1bc3fcb1
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ln0tKvut+9N4ocuvicPVJT1u2cCuQMlYUMbTN2HJKlRkWkP+NBZsG0eDV3PKOdRp9VStBzlAYQxUcYN1zS0Ynrh4qR39KZH2XrpB6kkjat8aFYwzQWBen6FcitD81QXjWWg2v0GbJFiUyr0/wS0TLa/93R3lSORj77gcNRBo/+HstxFPExxZ9sLkALpbZeSiQTUN3b1P0gbvBmS5Gpa+gJtawW1tCRjJUeAENxmjFGNfkVvE+V0tdu5vxqfwGlHtS9MyO0MxlEQtO2hborjM82OGUu2mTtzDijjvddbxQeab9aA+TGAB50zRXinUzW+rci4U2e5A28+3D2BMmBT4dL93I070nC1OISy9JWICAQ9kNoDsA2ikJFhmW8pdEYSvcofmcNF0ATwPk3DPDt2FFTQI0mputk9lRlsViZGLFong/WuSM1N+oOCGW6Uclm32iyNbdaaIzpb333t/BMhbUEHLZ+KoGuuZ2gRRVT+Q9lX5r+ZwQs07+uiyhM7/3Bdu/c66DjxN4mtbpFIKlKKL6WMr3R3kTOesC0k46ztCXnhtIi7yxdRm5lKAeA6pj/l12zWlhqRO9c+r/MCHwvs8jjmwuC1If2oZllcP2lHZYEiKZovpH8dU2e9pojlNNUzIY0e5f32tG8ERtQPv2SsaFKl/NzMXpCwben6Ux720aCSszhT/DNjGJDVmxE32DT7fl2b/JG6IqFyuKjfxPastsap0OztNd9j4flPA/Wq3QI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199018)(26005)(186003)(44832011)(2616005)(6666004)(107886003)(6486002)(316002)(6512007)(6506007)(478600001)(53546011)(31686004)(66556008)(6916009)(8676002)(4326008)(66476007)(8936002)(41300700001)(4744005)(36756003)(5660300002)(2906002)(66946007)(38100700002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1KYnN1eGpDWWNwblFGYVNVc3JYZWtGcjRsMEpPeSsxc2NFbHB5d0hIYzVo?=
 =?utf-8?B?aU9KVHlxUjF0dzBud2QxN2N6NHBJc3kwNHgxQjdnMWZnTmZrSmhqQ2ZtM0VE?=
 =?utf-8?B?a2JWemFPVUdOK1lWTFlXRHJlVitISTNPdFJkQWdPbFNlOXJBejEvb2VybkdI?=
 =?utf-8?B?azIxL2NzRUJ3WHByS3A4OFRMa2xlRVVrWElrU0hYcUFGTkJ2clhLUzNXTnU3?=
 =?utf-8?B?TkFNSkFKeHFKN0R0U2Z4cEhKMWpOZkNXaGI1WkhlTGo1Wmg2N3FaQnhMK2lF?=
 =?utf-8?B?azRuVHFUaTFzTUtFZFg3R1lYVms4NEFsZDdBQ05mVXlzSXRoL0gwZlNMd2ds?=
 =?utf-8?B?SDRXbW8rWldVSjVSWkVSTDl5R1Z3NFRvQ1k1cVY1RFlsMWpvbWhrUVNQb1R3?=
 =?utf-8?B?OUpSWWdPb0ZrWTVleXRGSFgweFJHYStaZkNzVm9BUDVTbmd1L2MvdWF3MThH?=
 =?utf-8?B?aVNRUjNxOUtJaTlvc3ZZWUhkZjhqZmdGZE1iMFpmVXVWRE5UVHc4a2I5dU9w?=
 =?utf-8?B?dXV1NkZnVjNtbmlXMkxuZ3lUTWRZczhBNU1mbDhyZllkYjNwSjMwMEx5T3Nh?=
 =?utf-8?B?K3E0UE1qTWJIVEN4akR0NHFTUHBkSUdweHNwam9rRFpDMm5GY2d4alNNWUVZ?=
 =?utf-8?B?bmVUS1BqYS9ZRFUyMHk4NXBWeUlhWlNENWNCcDdQVHBJdkJydm1JT250cndQ?=
 =?utf-8?B?ZlpZbStuekk5bHFBdWw2SVMyanBhYUdIbVMwclg2UzdOSlpsRGlkWnc5WG9y?=
 =?utf-8?B?bjYzdUlmdk44cWFWMmV5cFdtdDR1WVoydWxUUEhjOVcyRlFPRWtZY0hVL0JZ?=
 =?utf-8?B?MEFUVUpmcVlkS3NCNXJHSG1XWG1PVkZvREtyNU9rK3ZSamVxcEVzSHZGb2dN?=
 =?utf-8?B?SlVMYk1Qa3VYajB1RXBGUjhQaTBmSVBlRWtiUmFoVjFqUGg5eklINnlQVW5P?=
 =?utf-8?B?Z3VEN1FiRVZXSWtOVlRnTUtTei9DcmRCZGU1Z0JQRGh5RGtpUXNVeEZHV1hY?=
 =?utf-8?B?UGl0dnBLMHBzMHk4eitWSVJWUUJPa1NRMTZhYWhBZDZxOXlWUCtCblpoTC9s?=
 =?utf-8?B?YjMyOUF3RmJCS1lSQ1dGV1ZQS0x0NXVYeXNOSU8xQmVzamVGNjZmem5vNXBt?=
 =?utf-8?B?ZFNlWm1yK2hqZEV3M0lqZERFSDBtd0tHNVhWVFFtSjRvYmE2T3N2NkZGT3ND?=
 =?utf-8?B?dk9qWnIxTkxyNVBQYzdENUJIOTVMM3NwaHBhM3F3V1Y3a0JYcG5ERkJNanBm?=
 =?utf-8?B?L25EMXBpbkkzL2N2cVQ4K0pLbW9iVnBoWmFxTkkwcDRaL2Q4UkdGL0xPdWNL?=
 =?utf-8?B?VEtqNXFRRzJFRndjeWhHencrMmYrVDRKMGJrRFJmM3kveWFwL0txVXlPbGdM?=
 =?utf-8?B?TmVXY01aeFl2R2hYaTBTYVNJTXVENEpGVzdtcDhBNDMvK2lBY1lvcnVWYXM3?=
 =?utf-8?B?cVljQ0FqVjB0Vm1McUJKQ1FUNTBIb3JPeWl1NTMvZTYrb2FGOW1COHNrTGNx?=
 =?utf-8?B?VkRRTlI1RlgwbzJFUm44a0hJd3ZZRmw1L1h3aW01bVRzZWM0aWw3T3ZPUVFE?=
 =?utf-8?B?TjgzZjBydnNZbnpOZ04vRVd6VE9qc2NBVHUwZFpGNEsrN2hHeWVFWTdzZSth?=
 =?utf-8?B?dGhDYlJqZC9UaGZ0TC9jUFlBQTZXbUhpVTVlbHViWkU5QTgwMndZRDdZMUNW?=
 =?utf-8?B?YmI1SDFnSlBUb3NkOTNtS2dzbTdZYXV3eTlJVDVOS1BUOHFqSGluUmlsZG42?=
 =?utf-8?B?TzRwcmtjS0RFZS9CeDFZRlpoVkhRditTQXlmN1FHd01mcmxEc3lOOWJDdTBQ?=
 =?utf-8?B?dmlMai9lZEpTOGphWFdDQXpTc1NLbUdsM1pDeGV2YzRraXhIYmhQYmlnaytr?=
 =?utf-8?B?MVc2Nm03SFQyYXRreVF1SnI3WWl1QnlQU0wreXR5dDFwKzN5bHlUZGZJcG1l?=
 =?utf-8?B?T2haSVhxK1dUd1dqTjhMU28rTEV1NUVPYTJXeTFkQzJZaGdyb2F0SyszcUk3?=
 =?utf-8?B?aFBlQS80V25nOHBUbEg3VlJCVG1obXBRcXAxbE1MOXhSNUpSWkkwYTEybU9m?=
 =?utf-8?B?cGZMejVLdHhHbTNpVGorMmlLMjh6dEVteFY0RVZkTUVkZjhBbUFxRHVKd3U4?=
 =?utf-8?B?YllBTjhNSkk3TElMVmtyVWc4b3ExMGRJS3l1QndNSUJta2pjSHBqdlVsWkRj?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46deaa9-14d6-4c27-9d8f-08db1bc3fcb1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 08:47:57.6690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuieoCrZb2esQ5sQ7GJ26KC1vINKcwVJL4ZWDyX9wN/cekq/xNbhXaAdRv5P4qvCDLFZIcOuaX8aBJKiwxfx+V4K3cECgkfW/tP2YJejKUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7242
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/6] Refactor mqns_04 using new LTP API
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 3/3/23 10:16, Petr Vorel wrote:
> Hi Andrea,
>
> +++ b/testcases/kernel/containers/mqns/mqns_04.c
> ...
>> +	tst_res(TINFO, "Try to create %s from parent", mqueue2);
>> -	mkdir(DEV_MQUEUE2, 0755);
>> +	TST_EXP_FAIL(creat(mqueue2, 0755), EACCES);
> OK, you created MQNAME2 (asked by Richie in v4).
>
>> +	if (!TST_PASS)
>> +		tst_atomic_inc(mq_freed2);
>> -	tst_resm(TINFO, "Checking mqueue filesystem lifetime");
>> +	SAFE_UMOUNT(devdir);
>> +}
> I suppose it does not make sense to spawn plain process as it's done in
> mqns_03.c, right?
Indeed, we don't need plain process and we could just use unshare/clone
> Maybe it'd be worth to mention clone and unshare modes in [Description].
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
