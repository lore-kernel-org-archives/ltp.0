Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB06C6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 14:52:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C71483CDCF1
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 15:52:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F4883CB504
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 15:52:33 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89E17600941
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 15:52:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itVqvppol8lAOGEdrU/1z7xN6/MNAuVe+W5xBHjpVd+/tvRpfBwavCELJcpL6B9A4bHfNKbjJ7UCuOCqDCQjHS7dfFlS/+2FHSxC4ZgauobjdW9apebf6Gu35k48TSQI/IxzNnpV7NoYMNfpxvq8dExjb+MXILCtily4Qv7EdnVgUxDfQbJtfOtYQYn1JpJwQ3QZ/TaaQopK/n/2lLsUv2sWUHJAi+hqm58XWJHyN8tbtZ1F1PHboiXxSqtKtGSFw0/vikRK1jDqH7lk+yGY8uCfRb/OzUFVttRVLwAoCQXhq+95z8NFDwrox0HkL356q/HkLFNRdnDeEufWGDoNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFzIBlZLUZ5RrNDbshBJ4ucVJcp8yHqRQhM6RJA42b4=;
 b=ZlyhKKW+8LFFprnyXCAQnfqmFop1NJPdzZ5Qx7m/KHT+9u4mmsjj0oMcQS0/3/6dfdBDxDsgqJLIzrm893MBaqi5OdAtiB/yfT5XYFXVmlw2KdWybEEJHelXS9HeS311AGexV06oA/HhyOM9xlcwMCM3hKAxJ9VWBQT+29zYLCcbGCMmrGqpNRQMjQtHWF62LLSl8w5zFO0RNWRKvOeKhRs9i5ecPBwviD5CjczYnfOu+GYx16/cMKPPEEb/qiOk6PG4Znkj/DZlHmNTyGdvQTwFLevEm1WPL2/tzkd8/TzFBBC356VRJfG41qnAxdT7q2AH8qH/qpa5hXmeKz6/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFzIBlZLUZ5RrNDbshBJ4ucVJcp8yHqRQhM6RJA42b4=;
 b=V/NsCOaAlBHzyA/N71TFcYFB//UXxmLGzq1J+twWw69WT0uzAUTzwpoCFQ6q//CfE/NHKfk1bWgZdmUcjAyFUP1zh88d5xDiuR6nrmCGn0WzHieQ3zWgM1/M8PI+D/+Ic+sz0XXfdfjqxUuUImSr8iBsRKIkkV35o48e8Hb5jGjFa/hw3W6gL186uiHKI5b3fig+cX6UIEo9oLN7pG1mUpq8jVcEzX+AIAFrhHwqPLY9egJbgwfQg1DxA6izbzrkDXVxVRBhMCPjlPCO6+Dfe8C8CjoYmc993Oe/yChakCjtK2QPfvBs1VitPWn5MO2N0nwD2F0MsrG78AgILkJFFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM7PR04MB6854.eurprd04.prod.outlook.com (2603:10a6:20b:10c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 14:52:30 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%4]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 14:52:30 +0000
Message-ID: <8d111f23-37a0-6f7c-453a-386e8a4ec11e@suse.com>
Date: Thu, 2 Mar 2023 15:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20230302093406.29799-1-andrea.cervesato@suse.com>
 <ZACzPkhrRxsDL3Am@yuki>
 <b641cc8e-2950-fb6d-9c26-28f1e1b0fc1d@I-love.SAKURA.ne.jp>
In-Reply-To: <b641cc8e-2950-fb6d-9c26-28f1e1b0fc1d@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM7PR04MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 5407aff9-d28b-47a7-4d4e-08db1b2dbf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYfAjAhbPGp5VZD9E9MVS/S1ebQBzfc+M+6JWLhEnwVf4obzYP/kml5aY0wj5ue+Nxa7aIbF6HgOFjuU+rnaxWNVWxacVN74vT5wOdiBlzrXhaVfsoN2fyhQjSIvcMBPOqr3qpwMKrlKXH9315Wjo+Ceuq2TE116qjHd2eKCqYYkyN4l/dPRrY7lsttz4C/OXW0lIz6i20ObZdxVeSKiTMvFAYnuzDeSCH+ha9b6KF0inLKG3cIwtWTS4Wezsv2G3pFjiXd4nKno6scVqxpsS+TjN/DtZ4CJBDLcGy+B4XbNmIl6xF9GREuood5hDx6bSE5CrOYMg7AsaGXeCeP29cgNH71UaMhP2b4A3u37uOjI5jw6tpsoOXaJaJjEKJD3h9/nHEmlSaXMS3yrtjDTI5wF50VEAxHXRtU5zPDyo4K463279pA0PfZSHcCeGDLqBz+oEE5rDcnxAbA61cZcjgHrRnMHKuOHcE0pL1MxPjAXKgJNVnd3Zq1a0Bhx4ETruvRvm3eqcNS5nF46JQwtGij3nz7UvrE0ymm2NgXLKAnaRozpkmNdNbUpRwxGPuvuvnrMndrITH+HqN+uxzvzKzAuM5B/FNMSAzV5QnxfxT3cF/RTL6fnbLjPJR0RpMBQBoXpD1pdg4XOgpUq1DiMq77oVaIB1NEhowFok2r5F2rHvEqtcOVZ8YMH4hg1pSU+gDHrc4h/A4onLjP+jWmrZ0fnz/4JHodzp9HhZArkyZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(39850400004)(346002)(376002)(366004)(396003)(451199018)(36756003)(6666004)(53546011)(6506007)(6486002)(966005)(26005)(6512007)(2616005)(186003)(110136005)(316002)(4326008)(41300700001)(44832011)(2906002)(66476007)(8676002)(66556008)(8936002)(478600001)(5660300002)(38100700002)(86362001)(31696002)(66946007)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9tUVJHTmRnRTM3M1dTbWtmaVBIVlVKSHNxd2NBYS9Mam9oZFlhQklwTzZQ?=
 =?utf-8?B?RnZMVWZkbVpvdy9EODlaMktQb1ZKSFFFOWxNSTNzQ2VkOGlZbmMyaEZ6MlVK?=
 =?utf-8?B?amVaRHVIMU1YN0JRbTljSzlmTVhzdnRZK0NhRjJzcGUxYjRPR2U4Umh5dVlM?=
 =?utf-8?B?QzZqaU0wOGRiNzlVRTMrek1aYkpUY2JXZG9lQWt4VEg4a3dYRk9VcFZicTRt?=
 =?utf-8?B?ejZUbC9rL3d4UkRoOUdOZnY5c1poVGkzRWpIQkxsOUFCL0ZpOWZtWFhwUTdn?=
 =?utf-8?B?REZieVJzZnJQSi81YzFMT0QzVnlHUVh2NHB1Y1Jhd1NtSHVxTnYzbjM1NVl1?=
 =?utf-8?B?L2prd3lNVnduM2J2WmFjUW41TmFhY2JXQ2lzSURqaCtsanVpY0R3TnVnOGJj?=
 =?utf-8?B?MUxUMHpNbXB0aGhvbUF2UFZvb0tBNjVSQVBXRGpIZHRwK3I4Qzh0Uks0Tkll?=
 =?utf-8?B?M2Nrc1F6YTBXUzlta2J1NTRjUUVybERoZTAxdFJFdmJ1bkt5N3p0S2hJcWJO?=
 =?utf-8?B?ZDZXT2JnZjhGSUw0S3h2MThSTUZpQ2R3UEhLZFlQQTA2blNuKzNnY09QRkFH?=
 =?utf-8?B?c0JvemxqSHVnQTlvTW0zWnBReklsQVhjWEZiSlhwNnRhV3JieCtwUENNQzBE?=
 =?utf-8?B?dUJpbU1SS1dFYnlFQ1hDejY0U0lucXNWcEExYy9CMEc3SklzZkVMamp2ZTVI?=
 =?utf-8?B?MjRaZStRWmRMR3RHMS9RWFFtck5xMEtnbDFSZWVEelhla1Rsd2VzT1IwTy9S?=
 =?utf-8?B?cjdTYzVnWjIvdVlSZ3NqalJHYmhkd3Vuc2N5SVRRTUlRRWxiY2dvN21pZ1M2?=
 =?utf-8?B?OGMrNWhqRC96ZUtPR2srQW5nL0hYZUI1SjM3c1I4WEZKa2QrTTZvZmk3OWRu?=
 =?utf-8?B?amJpeXhvMGhmdGVHVy9KeXBEWjN6dFRpMy90U29YdDJJVEVWTi8yMkpQRndo?=
 =?utf-8?B?alM1b1dzVDFraWk5UzBCSjA5V2hBb1M3WTZuaTNQdmV4Q01vWEY4eE9IVXQ5?=
 =?utf-8?B?Q0VnQjBNVW8rUmNWUTNPZENuTjd5b3dBSlZOK2hVcXh6VHNsQVBlYUVZbXRk?=
 =?utf-8?B?QURGU0kwRzJlc2hqSGI2eW8yaG1xS2J6TVEvSzZOSUdwU3oxQmsyOTE5TFor?=
 =?utf-8?B?UjdzVE1IWmtDVGE3YkVEbGFhV1o3YWdVVVJoTTV2amxlSk5WNXUycDFVeTBD?=
 =?utf-8?B?VFhQUXRKYTlKdG9Qbm9zZnNNbElBWW1ZNXVCSEQ0ZEVxNGxVOE5rb0QzbTZL?=
 =?utf-8?B?L0RqYzZGcnhORzFMbjZFUjk5OGNqQkNVbCs0UThwc3VWNCs0SE84RzYxdmw3?=
 =?utf-8?B?UVQ4VDB4c1Fyb3R2c1R0R0p0NGxsMENrL2ZHOGNEckhKQzRaWGNqeUZLbndp?=
 =?utf-8?B?VTFVbk9DUUhaem84d1hPaUxCUkM0NnExMURybGpnZTVMdW5sVndxNExYS0dn?=
 =?utf-8?B?Zkw3NWZwY2FrSS9nNDBpVGIvbnBhdG5IdmNWVkVzdGVtUisySDlZNkNDRTdy?=
 =?utf-8?B?cFN5YU5jWTFXU3lLR2NEbE9OZlI2cUhzWUxHa3hlem9XeEd6RTF3S0dUZGVq?=
 =?utf-8?B?aVB6SEdaSG5WQWJlRnJZbmVNYkY5M25yelZ5ajNONjQ4MXU4SE45dVhENlov?=
 =?utf-8?B?UXJYRHhvWnZRbDJpWjgwa3NGYzFQK0UrNVpXWWdEVnNQTlpQQ3p4QjkyNlBz?=
 =?utf-8?B?T3pNYXk5VUQxZCtPNEhta2YxUTNuYlRuQ0JOaTRPSmVLNlhQZE85SnQyOTF3?=
 =?utf-8?B?MllyanJwYjFoY2thSzRTbHVDazJpc1NoZ3Uwa3hWNWRQblBwM2pua0ZJdU9X?=
 =?utf-8?B?OHlpWWVZajRNK2FMS09KQXk1d251bTdob1VmMGJ0c1JaYllFUUd5OFNpVmtv?=
 =?utf-8?B?RmNZa3VPeXhHL2RrYzROSHZDSkgwZ1RNWXBBMUpxQTB1czZhQUxNOE1DazhP?=
 =?utf-8?B?RS9aeDNvMDhPRnNrQnd6RnhxaHpRQkZSR1hLMUEzVHR1c2FyRUFqT3FrWWZu?=
 =?utf-8?B?Z2NMNWVCSVk5dnlhSjBSdVRpdHhCMW5ibG5NNnN5bVAvOTlqbzhHOFVmZllO?=
 =?utf-8?B?R0ZGaDhIOGorZ2ZOWGIyemt1UjZsL2tMRjg0ckdYZU45RkpodE5EWnZrMmI2?=
 =?utf-8?B?ZnRxQi9tVGhRdHFLTVFJV1JSOGIrT1lOMVVCUXhqMVk5MU92eXVmT0wwSnIz?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5407aff9-d28b-47a7-4d4e-08db1b2dbf8a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 14:52:30.5453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bv6Z3k+8z67OoqS5v/VQuEggdzNdd8JzPxrur5GIQadWUIqRE6jebZrZFuckXTeI5tXZdfiYGB3xFI8cuPVFP7cqtzEPcSDyGQbMWBkk9wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6854
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] [RFC] Remove tomoyo testing suite
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
Cc: tomoyo-users-en@lists.osdn.me, ltp@lists.linux.it,
 tomoyo-contact@I-love.SAKURA.ne.jp
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Tomoyo devs,

thank you for your feedback, we will continue on our side then.

Regards,
Andrea

On 3/2/23 15:47, Tetsuo Handa wrote:
> Hello.
>
> Thank you for heads-up.
>
> Removing testing suite for tomoyo from the LTP testcases folder is fine, for
> the latest testing suite for tomoyo is maintained at
> https://osdn.net/projects/tomoyo/scm/svn/tree/head/trunk/2.6.x/tomoyo-tools/kernel_test/
> and tomoyo is tested by syzbot.
>
> But the reasoning "the whole Tomoyo linux functionality seems replaced by
> SELinux or AppArmor" is wrong; the functionality cannot be replaced by
> other LSM modules. ;-)
>
> On 2023/03/02 23:31, Cyril Hrubis wrote:
>> Hi!
>> CCing the contact on https://tomoyo.osdn.jp/support.html.en
>>
>> If anyone wants to pick up the testsuite and maintain it please speak
>> up.
>>
>>> The tomoyo testing suite is built and installed inside the LTP testcases
>>> folder, but it's not used by any runtest file. It seems an old and
>>> unmaintained testing suite that uses old LTP API and ltp_clone_quick
>>> that is going to be deprecated.
>>>
>>> We suppose to update it using new LTP API, cleaning up the code and
>>> removing deprecated functions, but nowadays the whole Tomoyo linux
>>> functionality seems replaced by SELinux or AppArmor and not maintained
>>> anymore in years of development.
>>>
>>> For this reason, this patch is going to remove it from LTP installation.
>>>
>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
