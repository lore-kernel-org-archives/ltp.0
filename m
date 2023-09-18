Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91481CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 09:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE4203CE4C4
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:35:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA27F3CADE0
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:35:28 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BFD9360111B
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:35:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRuPvhryNe8HT0gITfA99mR8a7hOe0BcO2o1ae9vhJa7c5dAIEJYNgNdcor4CvojsuxOIZi2EVxO3K9Aw3m3iGgAI6rGy94J8Fn1qvgU1lRcuzAEzu3KD+b99fv55QL8FxO6HkueXXuhtnfFGMvNZfPzP6pusrPK8iufImHLBgA0XMWxiDNaVahfY1mPVurkage4Jk1xndSJnChy84kr2hCTO5XrodMGXDZ8RBl0QJO7VUbLgnsH7yTNfy6KFhAt62GYWD7NhvRkS7h3rdhSPvJmA0z7SJxXlr5/Dzvq+iHtZs5bhUanJ3mzl9F2B8PdDxhygbzDJAMMkiPTQ0DERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqQRRWIJ7Hr3r2aUorzjCnojNxMNx0brATcKiaOsBoI=;
 b=ITmZjgyXvhKlYLpfmsGJJaIRuDtVx9u66QK4euOkRCBt0rwjCVIURp860NoeIZDetmK/EIoLFkpBtNlQPXZ8t+aGRQ03auTfQp6R5PFNoEYrjOrQdKl0uwnUYdWCWkJzQkr+gz3sE45BeVQzx+0vchkryEPqkFVUDl8ZAUo07sSIHdODSnz4G27h4ndEoqdOKNy7bPh+tw6eyoXyOrdZQfCPT/XzyL9iQwnBKFdO4CduMRdKMS7liara8ijIhGJzzX6QG8j+Y0Z570pQncwQzMQ7aw6AR6L3bEULFwjydbrcaT8AQDq5FVlV7lSgnp4zzS60xAOgvuiSVkJIZfsLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqQRRWIJ7Hr3r2aUorzjCnojNxMNx0brATcKiaOsBoI=;
 b=PdSg1zwG9Jcu29rCP/m6t06KH6+hC8FKm4q4MKkw/VQsP4+8t3sJwqX7L6oBoWroRFbiraDX1bnIPTpufk2W4oN7iU8Xp/6qVANqavewnuKKv9bzeAZBTe22tVYdy3AqR3qKqweIbZsgV6MCOw5ww/LnMRWl7Rp1FKwQykeVFyZ5cZfWDQaHhZDb5bZfkP2QGA/XG5S4ld2QeFZgUycTdHHXDnYpfTSPiVH04Mk4XcXAQNAgI1QOnDQxtQMNiwQZV5z0leqfVB2zQ5k31I7O9HL2Y23+cNgdvpERmoypX1zlIT3nFGVeFp4oKGZGNZzPDE5Qf+tqxmwRKAUhRrBA+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PR3PR04MB7323.eurprd04.prod.outlook.com (2603:10a6:102:88::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 09:35:26 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:35:26 +0000
Message-ID: <7d0373b8-ae5d-49b8-b955-2759305fa336@suse.com>
Date: Mon, 18 Sep 2023 11:35:24 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230918082506.17464-1-andrea.cervesato@suse.de>
 <20230918082506.17464-3-andrea.cervesato@suse.de>
 <20230918091756.GB30304@pevik>
In-Reply-To: <20230918091756.GB30304@pevik>
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: ccaf8770-8209-4123-ed81-08dbb82a96c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj9cLsClmpIH8DyL3dqX5KYeMTIBzE3mNj+esZETHZhM/DJ/l+T9HB6OKwxLvaoMc+QAhi+ZTvyDdh6/gffdCvqF0tYDcB4ywEvLRC2amYmpwzcRT18msMorOLwBjyHKcTGdRq4xWTWD/SymNqGFXQzMAbI1PvaqN+yhkBriTwFhNCKwa7tRTPG30diSZImPkZpeiKWDMGmkdMkfDVxx7rzDK2hKwoQlbsGABIIL0QcIzMBJUwctROJYxHhKckpFNiCt2C0de5faQKmrgnEH0uV6AGCehZb/V6Kvg6YWR9ILV+TqNkdlwdPO0L6FndgfUrqbn7qOGa3cWgZtWvZad3YGIaWR5REmQGLcdLADDGPgvCashE/Zlq764ZLXTwPoge83HX5q5pxi0FnMJyLmzacoP25AmpDYu4Dyze/91Flbc3b9SSYNfdRFVE4+Je9JHRXqVFxE/1tuta2eIC3BIi32ElqbKAVmBbjjD0huav+GGnKLVUIAQ/sekHhaoAmVaVtmBx+6sKM/XdK6mWYBT5GWpou9BE3QSUHltTB3YoCI5oLmfhIFeMc9BZaboDJ82yIcxxFce8wJNaYsVHoY24AzDBRVoPhsVgNj2QtEQ6OHtN+5ra6ymrGUk94TvABZB5Gz5PJtPo2aKfPi9ZM0Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199024)(186009)(1800799009)(66556008)(36756003)(31686004)(26005)(2616005)(2906002)(5660300002)(44832011)(38100700002)(31696002)(86362001)(4326008)(8676002)(8936002)(166002)(316002)(41300700001)(66946007)(66476007)(478600001)(966005)(83380400001)(110136005)(6486002)(6506007)(53546011)(6512007)(33964004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTBsdzZYY0RuT1Nsakw0Tmh5ZDg0K3FsNExzMHpqK2puTXNCcWE0aVpNVmlK?=
 =?utf-8?B?eDJhcjVqNmlmY1dHVitrcWZsM0tNWkNHd25WTmZuNUhBMnpLQ0JjMFVuaDdF?=
 =?utf-8?B?S295QzdUQmhRNkFleEFIcFlVandLYVVIN1ROV0tWWWJjUGtWa1NBcU1qa203?=
 =?utf-8?B?NEVuTHNoN0N0L0doSTQ4T0RzMjVpajdzdElwa0JrSFFrR1hKSkt0MUE1bUdK?=
 =?utf-8?B?SE5RUmtCNEtUaE9LUEFyaCthVDdXKzFpeWFnSG9Nd1puWEcxMG1kWjBZU2Vw?=
 =?utf-8?B?VExoOFJJNDhDMThtOWNSb0wzSmsyZFlTWTlEbnpIVHV5cFpFWjkzcHgvaldE?=
 =?utf-8?B?aGJwZlU5UXRnSnRCQ1BnZlR0UkJUVWhEQ1F4a004QXlyM3d0UTVQYmFnZTBj?=
 =?utf-8?B?T0RXakR0ODJ5SDBodlAraUhxUlRvaW54cG10WVp5WndKa3d3SkZwWVlWRGh3?=
 =?utf-8?B?aHJRYUNiTG9JaFlvQzNTbDlLYlZuNlZNWGxNTlpWcEZtZDRnUldHczBsOTRD?=
 =?utf-8?B?OW9RVlV1Q2hUR0JSQzl3aDBJdUpXYUp5TjhnNFRKaVl4amRkRDJ3UGFFZG5z?=
 =?utf-8?B?dng3L0JFVjZNU3A1MjZZV3k2bkYyRXhqc0xWOExrMXNIYm42YytjWEwraEtw?=
 =?utf-8?B?K2hoNHF2SkV3R3owbDVQQU5ibDd4ZmZmNjJIVkVhSFVNbVBuVXE4UUo4Z0lV?=
 =?utf-8?B?SkNhdUFHeDNQVFF5aUdNVG9YajNRbXRncXBZTXZaMGxHYXBJdTJHekN5SUJU?=
 =?utf-8?B?NXlvODVmQ2xBSGtLb1UzQ0orWG1sZ2o0NTFQYktEYkdxVUJWMmVobms1OFpi?=
 =?utf-8?B?UTlZUTZJd2V1TURGWU1lL2NZc3FrcU0wYlFGT3hiZmdjUWZINVdDbVZUZE1v?=
 =?utf-8?B?MzVxamEvckV4eEp2QVJsS2tQekJsMnZ2SmdHRENtdGFWL2lqenhicWU2Wmlw?=
 =?utf-8?B?WnZPdnpqanFwdnBUS2pVQkc2VXQ3VldGNjFIbUlGSGRGMy92TXJjbkxPTEhU?=
 =?utf-8?B?RHExWUY4amFGWVlHaFp0bGZIUFg0OGZ3NU53RmsvdHhDVGdRTXVGcERpLy83?=
 =?utf-8?B?endJSjYxVjNSVnBwK1RKTnpBeGtFN05ibXJZSTZXNUQ5bDA3VzNNMk9CSVdJ?=
 =?utf-8?B?akZhbHIvN0FwcnZUZ0NoSHh4cjZZODZkZXBkb09QM3czVk44Rk5Dd1RhWGhL?=
 =?utf-8?B?cWdSNUJxYXBIMmJKTkoybHJVaVJ6NXVjRnIybW00c0tYb1dXNWhuT215R29q?=
 =?utf-8?B?V2kxb05RclN1d09pNWFtY0VlZno2MEV5YzlGaEtwQnI2V3N5N1RnYTB4YzZL?=
 =?utf-8?B?a3l2am9CRjJuaFF0Q1dOM0FKQ1RCWk80cTJ4WlV6YXZ6ajBrS3VTbWNzODBu?=
 =?utf-8?B?MFlUVEpaSFF3NlhnLzFNMG1QZW83VlhKMm1FL1BVZzJndnlHU0lGSG0rN0xx?=
 =?utf-8?B?NU51S0JjTVJsMjhkL1BENUllajdzTGF3RzhQUmV2S2h5UmZEbWZnY0t0T1Jl?=
 =?utf-8?B?OUZiTms2YlJmSWRzMlg0NFZXOHlPc2U2bkFjdzFmT21Ed2c3Nnl3ZlVieEZk?=
 =?utf-8?B?bFIxb3lzQjdDd1E4STdlb2VGKzNJVjIyZ0pMS0kyK3Bnc3BwV3A3bnI0RlY3?=
 =?utf-8?B?QUFwVHIxVmVxeWV1Z0Nkc2RLaWhuTlpqb24wRDQvSUlsOGFtb3NSZTZPKzMz?=
 =?utf-8?B?TFRPOWxZd09hcjJnZHhFVHdxM2kwdG5jcmFSQ2x1Smk4ckdvYmhvM3pUNVpJ?=
 =?utf-8?B?YTZBa0ZzZmE4RXdxdGpZcUZnSHlkbGpYbjZRRDFKMDF6NStNS0YwVXM3YzFK?=
 =?utf-8?B?MHQ2aG14N0NJOW93eDBVaFJEMHN6R3ppb2hQTjZyNmNXNnJ0VXNxdkxvcWlj?=
 =?utf-8?B?aG1zNEY5Ny9pZjQxS05Cc09sWFp5dWJlVEx3UGhINVhuUnAxVkxQdVNWVytJ?=
 =?utf-8?B?dnRXU1habWlJbzA3d0dURVNxblRYb2d5ZGRGSlh1VU5hS2N4aThtYmZyQ045?=
 =?utf-8?B?cDU3ZEZ0eUtXU0dIUzRsRE43WGlyaTZ1MWRZS2htbEtEcjF4NjNDMmduVDA5?=
 =?utf-8?B?SDhPb0VYYUk3eGw5Q1JJTDZLendObUpGdWx1eWdxQktmclZOUUR4MkE0dUVU?=
 =?utf-8?B?RHg2eWQySWkvQmNqYXNPeEl4T3ozRlpXRThqTGNKbkc3ejZRdzhjSmU3ckJI?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccaf8770-8209-4123-ed81-08dbb82a96c4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 09:35:26.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAldgByhFvJco9yxqQG2mZq8DWShTHBVjv706nP3MtkeFhfE0n8wPfkbAecVpDuQ+ldweIhzjha5mkZwLUDh+6Sm2chZ/jSfeCGUaNUJg5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/2] Add Linux Test eXecutor inside tools
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

Sorry but I seen this review when I already sent the patch 1 or 2 
minutes later.

On 9/18/23 11:17, Petr Vorel wrote:
>> From: Andrea Cervesato<andrea.cervesato@suse.com>
>> The ltx program runs on the system under test (SUT). It's primary
>> purpose is to run test executables in parallel and serialise the
>> results.
>> Signed-off-by: Andrea Cervesato<andrea.cervesato@suse.com>
>> ---
>>   .gitmodules        |  3 +++
>>   tools/ltx/Makefile | 31 +++++++++++++++++++++++++++++++
>>   tools/ltx/ltx-src  |  1 +
>>   3 files changed, 35 insertions(+)
>>   create mode 100644 tools/ltx/Makefile
>>   create mode 160000 tools/ltx/ltx-src
>> diff --git a/.gitmodules b/.gitmodules
>> index c389186c9..2a8b7a399 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -10,3 +10,6 @@
>>   [submodule "tools/kirk"]
>>   	path = tools/kirk
>>   	url =https://github.com/linux-test-project/kirk.git
>> +[submodule "tools/ltx/ltx-src"]
>> +	path = tools/ltx/ltx-src
>> +	url =https://github.com/linux-test-project/ltx.git
>> diff --git a/tools/ltx/Makefile b/tools/ltx/Makefile
>> new file mode 100644
>> index 000000000..4810ec8df
>> --- /dev/null
>> +++ b/tools/ltx/Makefile
>> @@ -0,0 +1,31 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2023 Cyril Hrubis<chrubis@suse.cz>
>> +# Copyright (c) 2023 Andrea Cervesato<andrea.cervesato@suse.com>
>> +#
>> +# Install script for Linux Test eXecutor
>> +
>> +top_srcdir		?= ../..
>> +
>> +include $(top_srcdir)/include/mk/env_pre.mk
>> +
>> +ifneq ($(wildcard $(abs_srcdir)/ltx-src/*),)
>> +
>> +BINARY=ltx
>> +
>> +MAKE_TARGETS := $(BINARY)
>> +
>> +CFLAGS+=-I$(abs_srcdir)/ltx-src/ -I$(abs_srcdir)/ltx-src/msgpack/
>> +
>> +$(BINARY): $(wildcard $(abs_srcdir)/ltx-src/*.c $(abs_srcdir)/ltx-src/msgpack/*.c)
>> +ifdef VERBOSE
>> +	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
>> +else
>> +	@echo CC $@
>> +	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
>> +endif
> This works, but why we don't use approach used for sparc, i.e.
>
> $(MAKE) -C ltx-src
>
> That way we would not have to redefine the default rules.
>
> Also it detects missing git clone and runs
> git submodule update --init if needed.
>
> I'm asking for a same approach, not only because later we can unify and reuse
> the code in some make helper, but also because it'd be more user friendly if our
> new git submodules work the same way.
>
> But if there is not enough time before release I would not be against this.
>
> Kind regards,
> Petr
>
I don't see reasons to change Makefile if it's using the right LTP 
variables and approach to tools installation within the LTP folder.

Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
