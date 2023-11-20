Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F59C197A0
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 15:56:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2D9B3CE1C9
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 16:56:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 060193CE1BB
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 16:55:58 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0451D600779
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 16:55:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn8KGSXoJxJtQFus2X7veJzbqw//HBBQPdrf/UipF5FWw+VtdnEW4Jv99VzNecQ/nc1QXvu5tIQy0WfwfQzP8f6AOPXrz85V2FPIYmkvjRNcyIcVOKDPtE6KNVOp8HR5S/OoCswX8aYGsiMDW8vVgYrINpewECdVZNqbOS35ObJmpT34/jkujdyc6r0awVCMzuSD0cVEkg7X/Rh5mcJ19Ldu/5C1YF+D+R8QI+/loD11UO51xjygxj/RNudpe1XUuinhLJhoCgLNKSNBX7E6rzmkWEy8RIM+NSC1vxfijsO53unClgA4yvLPY3riHRtkX/90Xb1qU7lcWo1sMBbBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU61YgUIlu3oN0B8isfYHCmbiKrr8VYOIPHa49DJUbw=;
 b=C6WrLCfjwBF/uTxEfIeZ94Qv9y9az9/feytD8CYXMbv+9dLrtaPwJZCI+vacrUme8n1S4aKyahKXajgNv04+4bzRyB0c6tpKNdGUusu0JEpkBoF/LiWsO++CBr/Qx3IlwOeMpzZD41AdxYczoSYpfZqG0v22kcMgKcdwh951LfAqNCjetw2RBBH9nyOTsHntf1Lz32U6nllesHUbz+H8ZKcZleLjhKOF7r/dsLphg2WO8yRJJNU+Jh/jCN6RZ8h/Ra4DEdVDeJ7WF3G+Gdo79o2TbXqfjqqiwupZWfrPa3GxCWMupXQI3ZSwaw/pdB5wjMtRF039M9kTEFiGSTSauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU61YgUIlu3oN0B8isfYHCmbiKrr8VYOIPHa49DJUbw=;
 b=unVPw2Zlz3CrAAYhr+y8tQJ431ZXLrsNmcTj2YCkctrnBW6hh6xSzOeZB/FvWGwJdwWKe3bZK1t/TF0jUGS3gRsZfSu/RuhMpAzPxzUgZC54tuMJ2gdlnHuOalASGHvRxCtECV2FhJopukdDpiYhKgbQVkTfcShmXQhrHtP1KlQ5D6AzBtxz/LQmvTBqYSumM2Rwzg1x8v4V0dHuTHDfvWj1a+ecwcRfq8z+/QPJOJrIk33VVWf3yxh4hwFJKCuBaXiOtDQtWPdpgKAgwFSMjvrekQN9EOy+Ait2AfS5zo8ggh+09NuCeExuf4sVx6VQ4jpAHb/O1vnY4yKjUQq9Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB7171.eurprd04.prod.outlook.com (2603:10a6:208:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.13; Mon, 20 Nov
 2023 15:55:55 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c%5]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 15:55:53 +0000
Message-ID: <a54b0968-fca8-49aa-91a2-4135e8bd231e@suse.com>
Date: Mon, 20 Nov 2023 16:55:51 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-2-andrea.cervesato@suse.de>
 <20231101103420.GC884786@pevik> <ZUIuNMoMbu2gGApM@yuki>
In-Reply-To: <ZUIuNMoMbu2gGApM@yuki>
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM0PR04MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f6d4d5-ac3c-4b4b-b27b-08dbe9e12cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEWzG1a6wyyIVjuDsK3P6hai7+3r976JOQ9+BaP9STsrJ9HVy0dNPXtEvqbgG1j+ac29gN9kUzqeAumIakCPWrx1EHP6qCZVjquQqxpqsWqkxKFiF8GYhSZjD1ccnZmS+GhwZTGqqKxSMfTh0z4x+QBtCUWSbjYCNyVT5mVfMnUtOQOJ+eke4q8D9Ejj8JoXQl2dl2tkeBBLh7pGVtQPpOO0OHR5xksMn8RomA2muMqT3JSjXIVfCmjFIGpcJQ+TcN/EbHMFyGlC1d9d8rfC6PediXuASa/eUOeGOLRTTobNSCfyhaAJtik5hOyqoPq/ASBOAr/cGuErxjkTRTeg55CPSp9A1YLAgECxwU640YIkGu0buqRIUz7SAG2CqsSggtzkDZ1L3FbNFaVduKbaBrfi7yorUcWIKmWuA6gl8BwkJWRnN5z/qGGNxk7QMjGqYdEH4bZGxm47Qe52VzT9iwlZaMrZaUwMjpedvaSe3aQ96kACZdg9O9rWOcZZGAnZEsdUAe6ibut+TD3wd6onf0cIVzrrujR3xTpVjUnV82h8uL1JNSgxc6R4nQE6iTfyoe+li0hqp2yQWIqFuctzv6Mo2cDbdIU9ir53qH59hakM0R+pzWdZEOoWbw1hoOH330OI5Ighj4igLx/J9uhBjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66556008)(66476007)(66946007)(316002)(8936002)(86362001)(110136005)(41300700001)(5660300002)(31696002)(4326008)(8676002)(44832011)(2906002)(83380400001)(38100700002)(26005)(6486002)(966005)(31686004)(2616005)(53546011)(478600001)(6512007)(36756003)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjBzZ0k2dnBtdSs3Smxxc251Ukx3djdod2N5dWNoTnlGNndQY1l3M2d6bXFR?=
 =?utf-8?B?cTBaNkZ6NTVDUGJXYUpDZjFhK0dtbVpCL3NvS09FdWwzWFJWaENlU1ltU1B2?=
 =?utf-8?B?NzUwVmZXeTJmR3JPZFRyWDNLQnBFU1piNm5kWHBueEhKT012UmEyelF1alNL?=
 =?utf-8?B?U3BjTW1mSU1uNFlBTW80N2Z6blMzTDh1eHJ6Ym9VZ3IxOWJOcmVKSVJuRlF0?=
 =?utf-8?B?RXR1eWEwRXhlVDFHNzhYUFFqWDk3WkVhUTVWMytDejh4ZnJGa3h5dHpsUkVz?=
 =?utf-8?B?MHMzK2VhdEhsY3hUMW1WWTZIUXN2NlU2cDA2WjJKSm5HcTZJUHlhU29xRDdP?=
 =?utf-8?B?d0FaLzFrS3pMbjdNOThQMEMyZ0xoZk1vS2ZwRFM4Vk1xSkZsM0U5NTVIYlVu?=
 =?utf-8?B?N2hoWHVEV1dQd1RURVJKT1l4MDcxYXNPQ0QxNHIxRU44UWFkTWh4MENGSDJu?=
 =?utf-8?B?bGZtakl2ajJuY0tHMHlnTnpRaGZMVTZRL05sVkR2cHhydEg3UEFyQlR6WHkw?=
 =?utf-8?B?cFZrbFFZN1ZjZ3RsMGJOWllUMDBuRHJxNk4wbmF2K3NxRElYOWgvSFJEUXg2?=
 =?utf-8?B?dytyYVAxdGY5bzFza2FxekJQZkV2cit3cUdtUFByV25JUDJBUVhMcFJxOUUz?=
 =?utf-8?B?dTZLSXJOL2pGT0RxaVg3SWM1QjBxWEpETW5xRkd3OVF6Rkl2dUZyblpYOHJW?=
 =?utf-8?B?Q1FZRGFEby8xN0gvRTYwSVVHd2dEWWtLREladW9TcEUyaTNEdDBnWStFeHZQ?=
 =?utf-8?B?R1VQN2ZqZGZ4T3lUUlptM0NEVEFjdUk3aHlEeXpGNy83Z0NkVmo4OCtpRTJF?=
 =?utf-8?B?amFocTlSS3Z5SlRYMmJiY1BRMHNoM01CQzNESW10RjU0NFpZTnRtYi8vd2Fn?=
 =?utf-8?B?QnJ1bU9ZbVBwYWdsVWpRQTNnOEYrbWJSMDIwblRPOHorTDlhSWVTaWtvRXd4?=
 =?utf-8?B?VTlsbER2L1FlNXh4UjVxM1FubTZaVTVpbGVRa2JpdDlVU245SUpCUURWWUV6?=
 =?utf-8?B?RGtaUFVjKzlVcFVNV3dGZjI0M1Yzemo3bSs2OG5hUmFtMEVFbis4TWp0cDVs?=
 =?utf-8?B?L2V1N3prN0ZFU3VOYWdoYmxlY3ROZFJRWXFJRmt1MkFjclUzbElGSUFTWG1B?=
 =?utf-8?B?YUJ1OThhYU9vczdzQ2xobHVRTlRkN2VxSmJEOVo0YVBRQU4zVXBBS1JLSjBN?=
 =?utf-8?B?VTFRaWtPd05YbDNvUFVQYlFybXdKbHdFMFFVTTg4cTZpSDh3cDVmdEpHd0V1?=
 =?utf-8?B?UmUvaC82UStuMG81bmVic25QNkI3MDl4OVpFOThUTTNndnpqQkVGQko4UVZP?=
 =?utf-8?B?Q3cxQmFGK0lUSmltZlBIaFNNZlgxUldyRlVpcDJnRlVyajRtNWwxcVRqa3lZ?=
 =?utf-8?B?R1cyY01DUzlLeHdGYUNIYmRDWXMwT0JsNnRZZUM2RE0raE83cm9WeTl1T2JJ?=
 =?utf-8?B?Z3FUdkFEZ2t6Vm9qcFRMT1J5Ri8zOFNoQzVHaVRpclhteGdlbGsxT2IxaWVk?=
 =?utf-8?B?eDB2SjhnSENkbUtMdWFlL25FanJXbEpieVAxZG44SmZTclg5M0dYUmx1cXI4?=
 =?utf-8?B?SHVOenJBQk9qaExmdFJkeEFyKzlNakhSTDlaKy9KdDlVa29zeTcrK2FQMVZj?=
 =?utf-8?B?aUJCWlA0RTZLTnA4a29GVWZxUWJmdkxaRWFYelNLaWMxTUVjRE1xVE5jN2Ur?=
 =?utf-8?B?QlNpbDdJZ01PMitqYmIyc09MMHdrUmZUbCtoT1ZYRVBTdDR6RGxSMndxTDRL?=
 =?utf-8?B?VWF6b3g0YURScjJsaUN5a1NTMld1bTFWaDdaMHJxT2FScWNQM1N1Z3prODQz?=
 =?utf-8?B?eFR6dlUyTVBlYnhUR3lTYk5iR2c1VE5lOGhaU2JRRytvb3p6eFpkVXQxRWc2?=
 =?utf-8?B?ajZFK3VZU2NTWjJGYWJCU2RQbml6SE81Q2V3bzJpQjFKdWxvcm9VaGE1YmJw?=
 =?utf-8?B?dzhGT0NYTW9scDZ1aUt2bzhNbVJQR2JpTGVxS2NvWngyZmVDRm8rUWp1SUxL?=
 =?utf-8?B?SjV5aFdGYTA3empIYnJhd3c4c2N2TUF5L1V0bTlGS1l1V09FdnFXejlWTEEv?=
 =?utf-8?B?OG1lSE04K2h6VE5uU1pmMC83N3J3SUFobWdrRFhVVCsrZG1HMjhoZW0xcW84?=
 =?utf-8?B?WU0yL2dPS1Q1VnRzd244dzM4TUo1ZlZSSW5FZkFjRkJFWVFSN2dMMUNkWUs1?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f6d4d5-ac3c-4b4b-b27b-08dbe9e12cc2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:55:53.3981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dvfyRAxFlKE9cAUrjc5mopf8gLjz7hy9vJ2MqZFRVxDRQBeIgjiqYKFI4xck3DraJuoq07+KrqlR/8uT+WN+kzkyEWTZtOoKQ9eszesNcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Rewrite fsx-linux test
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

On 11/1/23 11:53, Cyril Hrubis wrote:
> Hi!
>>> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
>>> @@ -1,1353 +1,392 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>   /*
>>>    * Copyright (C) 1991, NeXT Computer, Inc.  All Rights Reserverd.
>>> - * Copyright (c) 1998-2001 Apple Computer, Inc. All rights reserved.
>>> - *
>>> - * @APPLE_LICENSE_HEADER_START@
>>> - *
>>> - * The contents of this file constitute Original Code as defined in and
>>> - * are subject to the Apple Public Source License Version 1.1 (the
>>> - * "License").  You may not use this file except in compliance with the
>>> - * License.  Please obtain a copy of the License at
>>> - * http://www.apple.com/publicsource and read it before using this file.
>> I wonder if we can switch from APSL-1.1 to GPL-2.0-or-later
>> https://spdx.org/licenses/APSL-1.1.html
>>
>> "This is a complete rewrite of the old test." may justify that.
> The test was written from scratch based loosely on what the original
> stress test did, so I would say that the new license is okay.
>
> But I suggested adding "Based on fxs.c test by Next Computer, Inc."
> instead of the copyright lines, since I suppose that once we add these
> copyrights we have to keep the original license.
This is explained in the description.
>>> - * This Original Code and all software distributed under the License are
>>> - * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
>>> - * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
>>> - * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
>>> - * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
>>> - * License for the specific language governing rights and limitations
>>> - * under the License.
>>> - *
>>> - * @APPLE_LICENSE_HEADER_END@
>> ...
>>
>>> -#include <sys/types.h>
>>> -#include <sys/stat.h>
>>> -#if defined(_UWIN) || defined(__linux__)
>> I would also consider moving (and rename) the file to testcases/kernel/fs/fsx/fsx.c.
>> We don't care about _UWIN any more.
> I would keep the linux in the name, at least is clear that we do not
> intend to be portable to BSDs etc. like the orignal code was.
>
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
