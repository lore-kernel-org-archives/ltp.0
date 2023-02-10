Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04C1C05027
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 14:20:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D36673CC095
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 15:20:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D97063CAF38
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 15:20:35 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C08BD600E2C
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 15:20:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlyCE3JfR+c10cWgz2jmgobKN9mLCz558Dy0uI8AMGL67JGhS9R09nFENVkc8PQdSXxHP4nb6127ruJT4BPUyGkcaPdu5WTS2EDeYfXOmLqlqMaTowhha808AVhDmAp0U4wePyUvGoKA5brD7Cv8RGRTgRhVOpCy7NQAU0qL10Gvbt/KrP9UdiG0M4/otpF7IcIPOxZZ48o1bsVmJ+g+Jx8ck/f0EDS0SDlHK65+Wsy28UquBSoiuVsshojm+56HqAVjP/tNexP6fZgxVk7FYbdT7JP9+w5XSe/WmYeleh8CbBPzBJU/GX7jOuBYnYmrCC5a+/myFIY92Ljgc5KAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGkbQ3wonhV78h7pogXDeKNaHLZDqmklbY+kLFbL0vw=;
 b=I6NCCZluog3nVceChjEFNq4BCzzUBWnJgJ+be6OZiweRhhO1qkPUkUNZLqyE1L1IJ+rlObLKVx6M7uruPKPf9XbA+aAIJAZTOZAyZZHt8K/+8DHpVdAldL9dI7rda4ycoPjCToCWkYX6+y1OGRkOJwBER018eB3M0/TtgZV9ggv55aD3uSOZ3/o1idgoTH9z9aJ7nHu6Yhx+DtB3OScFc8P9hHuG1ywgBkc8TsIEAnZUSuPXClVjUSLo8A4pYDUnBvMtNQSPOgG94w2ys+obWhyPa5hMzz3inVd3ScjIADFW9PCN+jfVRy1qXiQlHKGiJjjPQ6bxEhuahCAz44Fb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGkbQ3wonhV78h7pogXDeKNaHLZDqmklbY+kLFbL0vw=;
 b=Rc2PeLe2BLkE2LppRwbkkmHdakfxs5qIlbFL3zo+jNYYlvJBtmaMWdmka5gssfZvhTo05yOtD0dNMtFhQOs/ibDh7rCTADm/ZAt8hTAC3owRG1ATlE1Nw4ZOdAe97mojH7KOIRKYRWyWqoV4KjnUO1o2qRZGiZdJ9ZkMYm7emBf4HPi4XwLHAzJjOORwVdH8om2E1geokNGXBCR0ZPmjh+Yiea0ID+URGtDQb/FuSk/1Xdyr+0ncpxm6X5l6u20mm2hBDFCm23/ietcQCUi4vV3mtWzRKqNVJN/Yw8+JGDkwVbG8US7SF7WZnBabXpVUHDQvQMHFGkR/ltG+UkvQhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 14:20:33 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 14:20:32 +0000
Message-ID: <5be1311a-6057-5362-93f6-ee623279e79e@suse.com>
Date: Fri, 10 Feb 2023 15:18:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230208091120.9994-1-andrea.cervesato@suse.com>
 <Y+ZDlj7gSCgdWFC1@yuki>
In-Reply-To: <Y+ZDlj7gSCgdWFC1@yuki>
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5285f5-fee4-4cd1-7ad5-08db0b71f80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwAuSLiaoTElg5e6PIjGQxqAdFSpnspWMBjAzWDK/lEPXbJ4VTf/VEIrpnME8AxdOQsuPt0xuuzqclq+kDfcS9BPdjYDJI6T7xiGUBPz5mHBBQubmJUiMj3T0DgaDtS1oiW6tHOKKkWSYUC7zixoU6F0xbW0jr0e30NF1CUiKcvumkqYiyiCbhacVPyhQgDKb5BiOP3zHK4UtVSM+vmMVw0mxle1vNGd8pT8TIPc0hFFB7YW9sOSgchO7B6CUK+u1zn68Eq4vAFtsf3rh+kUprwglw5m4Y2t8VIGnvA0/Oi17o2GyJUMIfv8McGUMXFWjoKqsUo6hMRmSjditYpxuGnX4Hd2zscUl26hgStNSggnoqUqf6TX0pBlihzb2SIMVn5GKb90LGoztfpemUnDIDXL+pmGtZKV0WVo+zD1/suId/7pzZG9r+q6jxqGFkdmzXxrG/En+NQrSBD3pxXMoj6AGGcvr8Fnbr7J6vH2zkgpTo3MlM/Sqyhy3qbaOFCrGxpcZ8E2gS9f0osmof7GMu0fj4uWe8xlkykyaiFih1BNkWlj08tY3dUWqk3IyHlQVXhxCa2cG+NTp0nQdRgOFFMMEnouKohCJtUDv2SChmr/Uk3o95Tq5Vn/EyS063M+dR/v/s0lRAkwbWlsq1tg/73D35oDTK08Ca/l8lZN9FTlnaYQByu5E+afThRlaT+JaOVBlQ8Z1Zx+RsGOZ/Hvm7+T2Ma4W7cu+NXTBCNTCkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199018)(478600001)(6486002)(2616005)(6512007)(186003)(26005)(6506007)(31686004)(53546011)(316002)(66556008)(66946007)(8676002)(6916009)(38100700002)(66476007)(4326008)(8936002)(2906002)(5660300002)(4744005)(44832011)(36756003)(41300700001)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEs5VnRIQy9ibmNWQldQTzdFQjhIbnZtMFVrR2oyWStNU25jRUdXQ0FtT0hO?=
 =?utf-8?B?V2cyazFBKzJWeEc4MXNOZTlsMDZSWjVyUi90ZnNtbjhtK3ladXRuVHJVei9P?=
 =?utf-8?B?eHNscUkzTktCelNGU1A1SjUwSlZEWHVyVUtMVkMrTHJjMXlVYktQVlYwU2tQ?=
 =?utf-8?B?Y0FCejkvYmxhQXFiNUEvTEN5ZE1LZmpNckFEajV5MU12LzYxaGFhOFNrS0t3?=
 =?utf-8?B?WUxlekR1YjJlOXZjMXovY1ZXTzJRbkxaVHV2eWFhV245NEY5ZXBRQzVQWEFt?=
 =?utf-8?B?cE5pTTdDeStCbHlrVG1HVy9OWjRSZVJuRFZPTHlLdmN6dENNcXhkOElLK0VU?=
 =?utf-8?B?clo0MjM4VmlWM20vNGVRQno5SmZDeGt3alJaK0kzTG1CbjBJamdSSllWQXJp?=
 =?utf-8?B?bkplbjRGamJsTTdzNXZXQVppdVdBUkxuaDBBT3hVT3hpaVp4QmkrRnR4a0ZP?=
 =?utf-8?B?amRNYmlUTEY5bTlaREI2ZGZlb0FQZ05zZmJmbVV4T3BuRHMxT0VsWlFkZE5s?=
 =?utf-8?B?dkFJVmhMc3NHSVhDZ2dPeUsxRFhLQnFkSTByYk1qb0FNS2VqWTUraWRrdkxD?=
 =?utf-8?B?NEZtY2xYdXRZTEVUNDdkalNzaEh6Y09abVZkL0FUVUtiQ1lWRUo5T1dYZGMy?=
 =?utf-8?B?dk1tdWhSb0Z5WUpvM0xySlBqYi9ZNGp0MlRya3dVRWs3Z21lVUN6NEZ5OEgv?=
 =?utf-8?B?WXBaYU1vMllHMENKRHFuWGY3bzNzNmpxb3lrMGpkaUlBd0p6L2FDQm8wMlM2?=
 =?utf-8?B?TS9PeHdQSWt0d1MwTUhrWXdPYUVWdXNmaTNTV21ITjJ3OCs1NXJQYW1sTFVy?=
 =?utf-8?B?U1NlbEFiWjVHbkt1OW41UmdtRXVMTVpHRXBZeTloNVk0L0Q0MkM4bWNKNnFE?=
 =?utf-8?B?UGo3N1VJMU1HQVJLNEE5TkxUZTNlcE5wWmdmRkZZd1N0Z29aazREU3Vkb3BB?=
 =?utf-8?B?clZ0dWxOUW5aZS80OWZ6MGZkcjMvREEydmZ2cmora09sTnk4YUpKc1hQZm0v?=
 =?utf-8?B?c3JubDloU1BEMmVOSlhsbkdSSnFOcUl3azJHUnlvbWxENEFaMnFjaG56Z2NB?=
 =?utf-8?B?cFd4ZjY3c3Urb3U5V1Uyczc0VzUzY1M2YzFUSWNUZTlBSkxaeTk0U04vRExi?=
 =?utf-8?B?STVrUDlTMlNPdXRZZmpHSjlBRlBORjBqUGNxNnc4bG5iZndzQ2l5NmYxd2FE?=
 =?utf-8?B?ZWV3RUJYaHNkTEd5LzVUc2NwTFdHQlFsZmo2MUZ3cVg1WUxhdFN1U3QwMy9Y?=
 =?utf-8?B?THJOM0NoWUN2UjVpU2dEY3k4WG5QeXRlcm8wUDJLU1RieHFuZFhwZ2t2b0tE?=
 =?utf-8?B?N2FOamdsWmx4ajFaQS8rR25XVDJrN3lpbk5TT3ViUXZPcDlxc2NGR3h0bTRV?=
 =?utf-8?B?VnlQMEJpbURpNVZxbUdEVEw5Q3FOMzdqNllRVkxnQmUxQ0QveHF6N3hRTU9F?=
 =?utf-8?B?UWRRNTU3K1VTTzdYOWpDQm9pcWlkM1V0S0JSanA5RkV2Um1IZVNOSEtlSTAr?=
 =?utf-8?B?TTVpRUs3dDZRZUxFbWxUVjE5QVA4cy9VbjM1WVFWZDZsOFU4bXJTeHhIZVlS?=
 =?utf-8?B?YS9PSjNsU25RZTQvSXZHQ21PRVgwUDMyVEw4STJ2cU1IMjdkeGsrM0ptWWpD?=
 =?utf-8?B?Q2RnTzdwU0pxNVlWOWhDc2dlNmZwKy82Q1BqOVZxSXd3Z1ZyTFFLUHhjaW1p?=
 =?utf-8?B?c3k5NkEvRCs2ZWdwSDJiUHlCNjhldGllU0NmSWFnSnRNTDV6Mm5jT2tEbEFZ?=
 =?utf-8?B?RnQ0dGdxemRRK1lmcWduSG10R0xjSU1BSStJMjd6NmFMd1AzR2hIZlBvTElS?=
 =?utf-8?B?aXQ4RmppazFoUVdMTE9KZnpDa2dHOXNhc3JjbnQwMFhXaVNid1p5MmYycEFl?=
 =?utf-8?B?N25peC8xY21jRUtRUjVLVGlvcGEwMzNVZ1I2anF5TTk2Z0o0MUEwR3NGdC9k?=
 =?utf-8?B?aUFVSlFxNHpSZmw3dC9ud2RIUTZuNzlwbmRjUHJtbDFMVjcrQStXTTB4WXdT?=
 =?utf-8?B?OHVjUURRNXM1WmtneDNXZWY1QURhQjdFVmJlWHZrME1jODdndlh0MFJXbHVS?=
 =?utf-8?B?dUhXaVFiSHRBdnBsci9XdU4yRzY0Y2t3WUQyWlNxeHJlVmdoMjQrOC94VUp6?=
 =?utf-8?B?b083cW0wcis1WTc5bjRKTXhlZEVCOG50K1BTVzNKcHhrc2ozWnRsUGtNandv?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5285f5-fee4-4cd1-7ad5-08db0b71f80a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 14:20:32.6058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs3B8Oq9yLs5Yxlu4w7J41Cd31z0sBtwXTKNutfNQj4zQxKYlMw0dLtMe0VXCebGax+D66tdQSlBFp5o1Cx3ufWR1fdk6bepFN1p1IRV3rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactor pidns30 test using new LTP API
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

On 2/10/23 14:16, Cyril Hrubis wrote:
> Hi!
>> +static void run(void)
>>   {
>> -	int status;
>> -	char buf[5];
>> -	pid_t cpid;
>> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
>>   
>> -	setup();
>> +	remove_mqueue(mqd);
>> +	received = 0;
> I wonder if we really need to clear the flag here, as far as I can see
> we only modify that variable in the child process and that shouldn't
> propagate to parent, unless we pass CLONE_VM of course.
Flag reset has been added to be 100% sure we are receiving the signal on 
-i > 1.
>
> Other than this it looks really good:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
