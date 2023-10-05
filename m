Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7032E92706
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 14:39:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9FA43CFE81
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 16:39:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C73E53CB4CF
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 16:39:06 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6EFA01001155
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 16:39:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFDYQIbGViS/WcuY//h9p0g95W8o2J4O8u+mVZeggzS3TjRHruIbMRRQk7tVRy1oVXOm9JV4mi1YSqvhYLMyV6CC4mxMsFTPWDFS5HRx06EnKpwY/CqSvyXvZh38MpRMYH7+txh5wChWGz1VOWxrZ6WPMhZD+F0XQ8U5XX0mZbaSRN2K+MDtVoWWX729rMuuEr2g5AxIRpmsB6wlqZLS9MC31s+yvcsWsFG6zXTjSmpW71RxOIm702IDVeBBzdezoomrge9V7uFfANVKITVfr96cb7RG8RMIiXC2T62UMWi+DCpvExF3r8xQSWInsXIyotG/9/Pd9suUbaMfr1BpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mjrYBAg0UXkbfRFOv6HZD5vgY7uIOWcHSFEXTDnR/g=;
 b=QIXJSqzDyEvm1q6vXUfBkZSWl8DtqYcRAfueLjb4rnhCwxHOwcQUGq9lC8uPj/WYtunS51gbFownOfLFtSTKLUwdoD5AiP+OKpVONSH1lBikvrKJfq0/59rgZYe+4S0mOqxnP7qELAdei6U/jUXRXusVjNriazZpE+BtSJlORCz84rteBkTAf5TCkgPnYnYzz9m5kQTsl0YMinnK34QPYWFc0vQlbj14mtgtuxF3us3YYG2EDM9jIX1JZnm3eWdVS2OB01sP7iu+jHz3lMmsa/tKragXXBXSAqMB9ONBwMRikL0F5PH+7guMgZOqg+sbJ/HNG0zAjzTJ5hwyKatPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mjrYBAg0UXkbfRFOv6HZD5vgY7uIOWcHSFEXTDnR/g=;
 b=xsbHRacloVtusRidr6tEgCuug1/UzFGp0fObYp2xI1glLc58Ww+X03UjDi4XixIld43KAl7PlnLLm9quUv9BRp3XesmdZtOsN620ZoYc/BkUcKicw6u5Bm6FkGczqP6KVoelxYq3mRVgMsj+6U5V/2ugTlmeOwWVv+hwS9EK1ajozdek41ieRkEwOjeZkywppj/tFb6GoVzpHO8odcNo2PGnkYhCJfgn39++aykXudt7gaRdLkbKHwsWLd6jE+lj0Gmprlb05VjpsIIVwf0S11zd+ovmDsEZ9Dtz7i+8Bm7MZJCdo662P3wNnK9NH90IvXyW3IV5zT6A16hdSCV7Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 14:39:04 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 14:39:04 +0000
Message-ID: <6302bf6a-46b3-47da-aec6-31abd1b498c0@suse.com>
Date: Thu, 5 Oct 2023 16:39:01 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231005134911.26758-1-andrea.cervesato@suse.de>
 <24951859.XGBpkceEbW@linux-9lzf>
In-Reply-To: <24951859.XGBpkceEbW@linux-9lzf>
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 8806387f-aa92-4fab-dff8-08dbc5b0d262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiEy2oqMXwW4Mv+cD2PqK+BNNsjV3xkCRm1mfw0TniYsTZ3W7tFA51Jt481huIgEozULNddoswtzXS877yVXOFzSFsukp1UrB0vW3SJjmfKP9uLQd+7MdxXvk086B0qB6mvCljbsR31QK+h8kN9cVjIGBqLidRgegnPtzg8D27geL8F5p2IxdtY/UEPV3vRrhqORQv77ANcP/VtXgcy9DTBUBxfGlN284QpX5jXcFhuoQYOCeL1Xs65kDtVroP+iAxCFAGQgOjJUKe77ZnFQaVd010fpbzscPfmfRrzOot2Yt45JZaie6VcPqmpSzm6DhYsE4eq+hCJKD70rtjReGH+Yath0qa4XnXwka++uiJGQU0bOIH7iFOs3S2b+DpR/I77ifAiNVwp428ZWl0vFEvWZAY6f7L8B1iqt6VwdOOO17SIiCJm1bpSkyghklbHaOCVV3DvoVo0OyyVCY7jCd5GjMkyL+UBmA/DrHP/DE3/fFPfOQNjzK+sEWzGIFZ0yUjnoTnoGXresHx3PV1GSB2A9h0YzbEXvsmjv2MPcAq5sQ2kSesO3FpmA48H+yExE7YV2PpnGi26aQ2lHO783O0E3fxtmAe59Z137hjai0uZKwvQmyhHuEhYOlEi4NkjhHqZ8BwUzwtSipq055Cfxtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66946007)(66556008)(31686004)(53546011)(6512007)(6666004)(26005)(2616005)(66476007)(38100700002)(316002)(6916009)(44832011)(5660300002)(41300700001)(6506007)(478600001)(6486002)(8936002)(83380400001)(8676002)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXBBSXN0bWtmT0xLL0JYN2FSU2tTem9JNWdqc3JDOXV4amNaQmpBMEo3elk4?=
 =?utf-8?B?YkZhUkJBT0lhL0dmVDlhWFVxVWwwcWJ4ZU93bzdLNmJvVkdmazRPRlU1S1ZY?=
 =?utf-8?B?MU9Nb0M5eVdJQWRIbWtyMUx3em5lcVA0ZXhaQXBvT2xXa3lzaXBJT2ZYa3Vq?=
 =?utf-8?B?WkNib25OcFBZRXFaa29ha2FvNXhSN0t0bjdQZ1ZYYmhKUmJ5bWdkTXgxTGJz?=
 =?utf-8?B?YTBGSGo0SjJLcVVMVml1b3dSMVFWeVd3VkNwTktkRGtnSHNUS3BnYkwvY2to?=
 =?utf-8?B?MDVyZSt0SXlyN3Q4L0xaQTFTck5lRStxcFZNQTE0QTkyOE5zNlVTUFNUL3FR?=
 =?utf-8?B?NjRESXExeVVFeGkvekRKZTBqWlVMa0h1QktTei9tYXFWNTlzZXNOWTBWMkhv?=
 =?utf-8?B?UkdVelR4UFlFU2lzckV4aFdzVFFkWUpnTm1JZUZxZ1FhOGxFaVJISnovSkVK?=
 =?utf-8?B?c3ZhVFdXYmlhRWlMM0Q3bUdyenJYTDgza2pkaWRWeTc0aGNBeHh6QWk3S1Zr?=
 =?utf-8?B?WW5NZ1ZGeS8vOEdFQ044ZHhmM2VqTE52SGxabWErQjJUV3U4WVMvVmxid0Zh?=
 =?utf-8?B?MzEvcHY4ZmFXMlpMclJOKzYxMEMvVWVRWXgrWUZyZThzTlZaUzJHblMwQW5X?=
 =?utf-8?B?aGVPYWZNYlBUSVdadlpWbVFkRmNkTVlQc3c1VjZnQW4yUVdWQkZTNHVFdXh0?=
 =?utf-8?B?VUY5R3pMYlJCc2VqN2VhdWx0bVdvVXhiTnZSUUhxVHI0V0tYTkpuRUlEUHlH?=
 =?utf-8?B?U0YxR1ZlNFZvZEdxUWVOaHo5cWhBV2pZZi9Ra3dnN2RZMm5BSDZUVWJkNmFP?=
 =?utf-8?B?ay92N3JrL2NtYXF1Z2REOVlKR1hLdGgrSmZSaGNyQWROSHkydEM4MU9WQ3pR?=
 =?utf-8?B?T1NSdzNDYjIzU2x5K1FWQU9pWkttWStwNGxSbjdYakRlYW1meUxyMUlBT25n?=
 =?utf-8?B?TklsNXo3NTZMQTM1TDUxSGJjN1p2RDl3TGhUYU8rVVBGbHBmOTd0WFZ3aUNv?=
 =?utf-8?B?VnhPN1lIcDhDeWxVT2UrNHlWY1V3SE10c0VuYXNZd01idWJFNEVXWkdmWW1L?=
 =?utf-8?B?cmVrR1VVeTJhQVNQaGdqNjRqWjl4YmZ2Sk1ZUkduOGhaR1FxUWYyNDJXdWQz?=
 =?utf-8?B?cVZiRnUzSXJpL1VrQnY3ZFcwVm5nNi8va21WOVF2OFJ0ejVrN1VueG5jcG9t?=
 =?utf-8?B?WnlGb2RjQkRwUzduU0IvMEtwSkVRTkVqS09XZDdjNDJpNXluNzk2Tnl1ZzdD?=
 =?utf-8?B?Sy9xa2pPaUc0SGlKSFFtYU94dmhnNUtmalNuWUV2MWNOYmQ2d0ZBVThWTDdE?=
 =?utf-8?B?VVd0RjFYaHBESGtHTFU0VER0cEFxWFZ6NWp3MlYwK2loNFVET3pPWkdFU0VM?=
 =?utf-8?B?WnhGOURweDZ1bTdyR1pDUC96ZjBtbTZBekNuemp4REJpa2ExZkNjekRXTWZw?=
 =?utf-8?B?R2FWcDdVMWFlVmgxL2Z3YVptb2JCTU9hY2xDenNNTzRDZjgrNU50RTVBYVls?=
 =?utf-8?B?Yzkwb3pSZHNtdW9XTm42eTJTT2IxQm1LNmZMSmpwMlh6bXBRNGdXS2lQNnds?=
 =?utf-8?B?MFNwQ2ZkQ1c3VGNrNFYyanR0d3pGWDVwa2Y2M0Y1a3RPUG1CT1pjQVRiT21z?=
 =?utf-8?B?NUQwOWhrUHpsbkZFOWQxQkV5RE9qZllndEJHSWhBUVBVaVJyeDFobTd4ZGZJ?=
 =?utf-8?B?S0dkYi9zaU95akdqeE0vRkx5SzZFZFg4K21OeW9PYlhEK0NVRm1HeEZncHFy?=
 =?utf-8?B?NTJlTEdJSFBCL3MrRjNpWjZHb3o3bWdsd242WnlUdDNpUndJNjlGd05uN3c5?=
 =?utf-8?B?aHF1MlRUR0M3amhzZGhLUVBZMFdyTHRKeGIzSEtVQlFQei93THAwMkRXY3JV?=
 =?utf-8?B?ZGdNWWxBWmZxRmt5YS9aQUhTeE5tMjlvelRwQlUyKytQQXRKNEdtQW9UWXE2?=
 =?utf-8?B?ZjFDOVd5aWVZMFlWcG5NWlhOYVQ4Q0hzaE0yTlNWNHBsQm5BTXpPU3dXOWFU?=
 =?utf-8?B?cWcrZG5hdk4zYjVoVkQ2TXg4MWtpd3B6MmlpalRBUENKWTA3dzBGTTlkNmNC?=
 =?utf-8?B?anR6anpuTTY2cU9SQURqVGdpMStDMzkxQzRjMGVwNWlKMmovVUtGdTdvdlcy?=
 =?utf-8?B?ekQwMUpMcGRDdFg0UzFxelRLZUdMSjAvK1YzRjYwOGxzdkN0WEkzaDgzbXRR?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8806387f-aa92-4fab-dff8-08dbc5b0d262
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:39:03.9439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x/8XAcLiXGRLFW3Oll8bMrDXVBgMrHfIuv6BgNLXR5lhto+iAjs6ZEqsx5aUaKzL2fs9svUUHIa61rE6pQlJy5Bj0ZaGsP+/3A7nSo1NuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Rewrite the gettid() testing suite
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

On 10/5/23 16:24, Marius Kittler wrote:
> Am Donnerstag, 5. Oktober 2023, 15:49:09 CEST schrieb Andrea Cervesato:
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> Rewrite gettid01 and create a new gettid02 test in order to check all
>> gettid() basic functionalities, according with its manual.
>>
>> Andrea Cervesato (2):
>>    Rewrite gettid01 test
>>    Add gettid02 test
>>
>>   runtest/syscalls                            |   1 +
>>   testcases/kernel/syscalls/gettid/.gitignore |   1 +
>>   testcases/kernel/syscalls/gettid/Makefile   |   4 +-
>>   testcases/kernel/syscalls/gettid/gettid01.c | 105 ++++----------------
>>   testcases/kernel/syscalls/gettid/gettid02.c |  68 +++++++++++++
>>   5 files changed, 93 insertions(+), 86 deletions(-)
>>   create mode 100644 testcases/kernel/syscalls/gettid/gettid02.c
> Looks generally good to merge.
>
> I'm only wondering whether the goto in the 2nd test could be avoided. After
> all it might even be a benefit to get an info for all the wrongly equivalent
> thread IDs (and not just the first).
>
> Then it would also make sense to use `int j = i + 1;` in the inner loop to
> avoid duplicate/redundant commutative comparisons. And then you could actually
> also drop the `i == j` check.
>
>
>
>
It makes sense, I update the code.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
