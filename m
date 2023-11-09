Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D32CC4332F
	for <ltp@archiver.kernel.org>; Thu,  9 Nov 2023 02:31:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36A6D3D0708
	for <ltp@archiver.kernel.org>; Thu,  9 Nov 2023 03:31:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 924E43CCAE3
 for <ltp@lists.linux.it>; Thu,  9 Nov 2023 03:31:31 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 929486008AA
 for <ltp@lists.linux.it>; Thu,  9 Nov 2023 03:31:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1699497090; x=1731033090;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=TNIlGyIKxEEgF35k1Aff6K2Uu9OaEEpc+BOb3k7vVn4=;
 b=CHcxc9UsHnyhhUUqSTM5XLgfSyadT/nSEmtA8fEU2CnvJJZVPi90DVwX
 jtPOUGDHf/h4N1e6OfvUB9S7odd9yvR/8CQ0cMR/b07MQTPP3sw8Wdnr5
 3Vyuhi3OlfDT3fOYgu8NDI3eT6G359asOzjVj96Ma21h7BqRZ+NfYVt1w
 6YfPUBZWZ1xLvqpKNPRoaCXLWifQS398ULi1Arhduf9nOLNfH0Q1X6//h
 uai+GhkY7Ka3NqdtZIK1pdLDZD0Coz5gjeOqcs/rzMm7gvriBcizJp/LZ
 5VHhwEV3/YNiHonNiezfv/oV1W4yXgn+twLUAdbPJ/C/I3rIp4R5ezK5s g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="13035399"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; d="scan'208,217";a="13035399"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 11:31:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqcbj7SvHSRog7SpyqIPTIUoS9wTYWov2sSQm9+S18xbofFMQX748bGq1S4FbfkSRTZHjXAEOh0TRwnVTZNP++lgBGaDRVX5z4WPB/yuid27ScTweesOfC+pNGNfPkXJrSnN1aIEGshDzMkwA9o3ZmSOW7EBMrp5GGbHM6Vdu7MeWYGdqyMVZtEv2Pr7KkS4IQedrkDhVM3zeu+2usRhYDOsiPYOdyelCuqWTfDfdfPB7UkU0LJ4ag4WDtCG9jfQKr9bSm2jm4XXLR0HJ9kajejwUZYxd0AiUGO7aoAUgyIxLSEz9VFG2q/fpO66wWVG6EyEVa49h56hwwE6NvGXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNIlGyIKxEEgF35k1Aff6K2Uu9OaEEpc+BOb3k7vVn4=;
 b=GmvzM3BOX0XzizgkJgMq5gU+9ZQ1sq84BiIr0nXV7zAvuKy7P2I9rvD9S/+Lt2HbYwGUTJj87a97SUGDIPbFR+FsPOQtsfCgGuMfdEX5kluMEH/7sjIohMdHzU9L7/ukNMk/D/+KA1tAm6DbZZsM9BRgsLP1pJxhhJhwBK7gBK8qCZp3/JUFRbj0BKN60J+Xwlvizt86XSPmu/FMOPol716CnQ97gjH/bIltU2DfBrh6brG79LBkmN5o2ZLBcDp+PU2y2gyzMtZ+M7Q5dkpm0FzA+sEouPX1MbTIpvhyUGHNpkzqxj5oTVzVnD9YBeNfodcIqC6G0R48S745wFWYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYCPR01MB9829.jpnprd01.prod.outlook.com (2603:1096:400:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 02:31:25 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6cc3:e6ca:7c96:ba7d]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6cc3:e6ca:7c96:ba7d%5]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 02:31:25 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2 2/2] link08: Convert docs to docparse
Thread-Index: AQHaEWlgSLDTDDwczkqX5G9cRdHE/7BwDhmAgAE4BQg=
Date: Thu, 9 Nov 2023 02:31:24 +0000
Message-ID: <OS7PR01MB1183913150102E819564B936EFDAFA@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231107105836.68108-1-xuyang2018.jy@fujitsu.com>
 <20231107105836.68108-2-xuyang2018.jy@fujitsu.com>
 <20231108075203.GB1383908@pevik>
In-Reply-To: <20231108075203.GB1383908@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-09T02:31:23.110Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYCPR01MB9829:EE_
x-ms-office365-filtering-correlation-id: b8cc16c3-7365-4b06-f022-08dbe0cbf831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VfGR9QBzImRcolsevjcqEttQ6hmhJhxt3kOE1YOifsDrgJMC9C0X1gz605guQurGK+81BNX7GIL6aMvX5cx8Q8AuBhhvvlheyCGJM/Hr6S0+QWmN82cOwiUO1NEuzdiOg7OcnN/wP1hORMXP7jyjt+SMOYczJpCc9NasCcLBN8BnTRbRzCqbJZmJD43gEW97TefpjbNLVMZ+SBu6oT9CY6bMDK9OFVRMWw4VJxVFsQkQWxBpXhdv7NKzZ+lUo6sNTRJAxkFSInHWEg9FfnSD1KukUuw8UGHZI/1fRnN8p0qSbJ57avRhMswx3mv3BIGI53SnKJyrVH8CZCVP0ylUe5tU3/v4MxRQ0WzjQBqJIW/rOGOO0V9wy3o/kA+YCUQtMlgAcOyyPSkrcGOlKP1c8+FraH2nGV+cTFCLcWAVpemLQYJjZwM+KOSZU+5b81bPVMbhebmz65ZUgwyc+82jEyYMUWfxaXyGhVUA3YT202U5eHjvoZDtPufUPbAZVxo2Ll1qJcJSM/tg1tc+tjs36ydTWDmcjgDiN3DHoaNNT49F+3wkJYNp8MaTglda6eVSathErJgisVcpZraq0jadkp7J8Pou6nZZxmsuykZSiFwBBVktU3xygs2Toy2MExnfWbFl5UgTfCxFhj3OzsJTwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(1590799021)(1800799009)(186009)(64100799003)(451199024)(6916009)(71200400001)(41300700001)(1580799018)(64756008)(91956017)(85182001)(66946007)(76116006)(66556008)(26005)(33656002)(38070700009)(9686003)(66476007)(83380400001)(86362001)(52536014)(82960400001)(122000001)(38100700002)(66446008)(316002)(7696005)(6506007)(8936002)(5660300002)(19627405001)(4326008)(8676002)(55016003)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Ym10M3Rvd0Y2bkJZMUJVU3VjQkJxbEJxQStqUG5QcDYwTmZjQXlhSWlDVGcz?=
 =?gb2312?B?L2JISUpLRkRxRm5aN1h5bDB0QUJmUHVVTTk5WTV6Zjk3LzFFQ1R1dDN1ZWhU?=
 =?gb2312?B?ZEt5ZnVPOWEzbDQ2ZzBBdnJOY285RzdzZG5Rb1FUcHd1aVJLV29iTW9SNU8v?=
 =?gb2312?B?bGtiOVVMcXh5YVRxTndZWVk1ZG5RVDFJT0VWWlE5cHQwdXJBZ21xMHFlTlRR?=
 =?gb2312?B?SXdmaXBmZmxtb1NYNFoyWDBPMU1JR3NkYis3T2xkVzg5L2xXN3lSV1N6K0hR?=
 =?gb2312?B?aUpSMS9RdnV6bElZNysrNEEzZ3dITjFSZUN1TEZVdFZmeThvdUZ2S3NYZEkz?=
 =?gb2312?B?a0JCcE00WHNwMGhBQkZIMkNSYnFWV2h6WHBFcmJlNEd5b1VQUVFnTEtwaDRS?=
 =?gb2312?B?SnFUVVlOOXBxZjc0NXl0a05lZ2wzbGdXYWhYQkdWSGp3SVBHMVlKTXA5T21R?=
 =?gb2312?B?Z3k5RWVydXNPaDVxNlQzVElDbnRYNVdyaTBOZEV6c29UeHpOK0U3bmN1ZndN?=
 =?gb2312?B?N0lzTnFiVVVrMEhnSnBwWS80Z3JrMEM1Zm81TTdzbXdGSmlEVnNTTlZ2a2M3?=
 =?gb2312?B?SzJoa280NlBLTy9xR1U3ZE5vZWNhSTJycmJ6a05Ka010Z21nNk9JNFZHNGt1?=
 =?gb2312?B?UWh4RHlIV2txM05lOGFhVWdmOHB0QWZVMXZvZEtEK2V2bmVRbi9SUC9XQXpl?=
 =?gb2312?B?Q1hMSjZNOTIyVzNNUGxvSVk2UTNiNjdxZ0RZZHRiMUJJdTY1OWtmczMrLzZ4?=
 =?gb2312?B?MnZLa25PWUVqZzNzRDBxUVJ0cVY3RmZnQktvMmNQYkFvVmJkYWF4VFZBaEdH?=
 =?gb2312?B?S3R2em14Ti96TXlGOHZpWXlsaVFjK1JNY3lhMmVYeTI1cnpXS0xybENtd0R0?=
 =?gb2312?B?WjBMdFhwQXNSYnI2QkFyYUZESkVoNmQ1M3JVeUNuSFdHcjBXRjg5SDdNMlJH?=
 =?gb2312?B?ZXJDazBISHcvc2xUQUlMdENtRjBUK3NKNGRmZmwwUW9GK3pldEw0MTVQOUxh?=
 =?gb2312?B?cm0vY2MxTnlTK3hvN2pML2hpcWFiQmRZb1BtVkgvWUxJMTFwTm14TGxoQnJs?=
 =?gb2312?B?QVZPVUNEcjdHbmNVUUlMd1NOaUs4d2Z3NGNvUVY5TXAvQmxpWGN2WnFoYVlt?=
 =?gb2312?B?aURPR1VNSDROSGhXV21yQ05aYllPclJyQ3AvZkFCL1BlbzNicGdjcEtESXlE?=
 =?gb2312?B?RTJPbUxLcGRSUVFxdXdVZTZKSjQ1NlNUb2p2WVpFVEg1Z3dIam9Ra3RPdFBP?=
 =?gb2312?B?LzROQ3lQc2lpcUZGL1dEb2pHTGR0WUJjdlBEVytESnNxbDBkUk1sVkI0czJM?=
 =?gb2312?B?UEY0enFQN3dHVzBydmpxSlkyYTZMR29BUW93Z256SWlvMDFIT0tqcmpnU0w2?=
 =?gb2312?B?a0xzWEM2WVRSbFZUYUd3cDgwY3hoVzhYWlM5WGhuSU5QcVZaYzBnK3RHMzgv?=
 =?gb2312?B?cG5EQ005SVA5VG9DVmJFZE1zeHVnd2JPbHVNQmkwcitGQjZoWmJ2ZUFyUnNo?=
 =?gb2312?B?QUxYZDNESGZwbFFEc1huVXNwYWhNZXU0T042SGZ0Y3JhbHQ1Zkxja1l6OVVj?=
 =?gb2312?B?WmllcnZ1bkxqYlhXZEJYUFM5WjdYdDdWOTlsSU9FaXBPdi9zcmtiR1VLM3pK?=
 =?gb2312?B?Q2Nrb0ltenRMc2RVQlNsYlZtZkpUNXJVOTdnSnd4NnUwUEVKTXVYeHNmR2tt?=
 =?gb2312?B?bnBrWjVEREpZc0tnZzQyN2tqL3hmS0tjK1IrYXY4QW5UbmdYWDhGWDB2SlRQ?=
 =?gb2312?B?UDZERURNSjNkYlUwNkh4bjdFMTNoY3ZNRFJSQ21mUi9xMUkxd0c1bHZZVW5u?=
 =?gb2312?B?ajdQUGh5aEdTUXBUVmFLREtJTnVSQnZkbkVvL2pZQWVVcEhyUFUycURYeEc5?=
 =?gb2312?B?WnpPazVRR25PbExWWm5FMWNOTnVTcjlzbmx5QXFSdDBBcTA1NVpjWVBxNW4w?=
 =?gb2312?B?a2FZTTZGdHc3N0xwWnh3bWdwaXR0eXJlV3R1RlRqUWRsdUhNMEUxSUt1TDV5?=
 =?gb2312?B?ODIvZnJaVXUwSC9sZjcyYVZzdEV1Zkw1OTh2cEtwWk1ldG5Iclh2SDFkNzFp?=
 =?gb2312?B?OVR1NllFQVlVZmNyV0RVNi9ZY1ZPYjNieDc5T3l4bFZXUEkyM0czYTU4aExO?=
 =?gb2312?Q?lx7qYj5nDEqXJYldFui616p/F?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6Xv7UR3Nvx3Qa0nDJvTTkuxzedhXXv0nL8mr3WtXeAGZxoxlXoC5gZQYQWJsqP/ocASkg8MyvT9DPMw+ZTAdqfAr2EBkihqAib4iudP5UR9FL3U/aNbC8DrES7SE00QLykkPtX2dy9C7Onq3caSkZl2dI3P5bgoo2ZgGoqoVazSZpjYSJDHRP2nQB1wVHafj3NAxPdYvFW7m2xIcHMeKPgSRxAtq0I3Ra8Fg1ZiEKABa9+5YGxgnX1iVscp1MHAwujye0y1O/mIZXCsZCV7VxsMB/XMJtuhw36lPcycbI8GrC7gkD6oi9VgWTvblxzaSGADgf9M0b2kLAzncSKcZGANOqFzKp0D3GPwTaIY+dCK7lCk4hJM270Pqm6+mCOkDrF6J7ITwLYkKflSXSnQDY1fsiUVNuIZkafjZjPLa1chM9K9CPhhD1DVyVWUMNfo18uPJ28dwD8YBFID+yjk9u5tLtDDDfhOr0LC8OMaSp6g9GKYjW2+q7eWMffS606SS9zY2KxFaDc7uX2HjGSdqKWyszTp5DHA6pdjBq+0NM2dzJKFAC5g3z8uvOwJ50Z+SDGeEtrGdaPC7JJz5kv9xaQm2cJCoozeXpNJAATtsBPbb8Z3XiyLr2zr0R5N+EdEOV9/GfcsCaRKg9/jS2fKNC+IoFmEoTssdwnY59/3Fgwg1Ol1JBnBEmc4tmfqfUVroLNNUMFdqiXTwM771SxY3Xb+6z35oafSQb/3ykqZSmBhi/3WciHLrz60o9jeMr2swEEZdUCKwuhGi3uvqpR3aGZ4Ftb8ajSQ7ZPIcWz4RsaI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cc16c3-7365-4b06-f022-08dbe0cbf831
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 02:31:24.9576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJIyoe9cLR8UqagSpm6HWu71DmVsBoFu+YgA5uBCz4L5m79TzEeELPxo5QdYBRNfF287FqZUgiiApIywIPAO8cWruZjoQ0Kkz96wU89vhdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9829
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] link08: Convert docs to docparse
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

>Hi Xu,

>> update copyright, fix grammar
>...
>> +++ b/testcases/kernel/syscalls/link/link08.c
>> @@ -1,23 +1,26 @@
>>  // SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * Copyright (c) 2014 Fujitsu Ltd.
>> + * Copyright (c) Linux Test Project, 2014-2023
>>   * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
>>   */
>> -/*
>> - * Test Description:
>> - *  Verify that,
>> - *   1. link() fails with -1 return value and sets errno to EPERM
>> - *      if oldpath is a directory.
>> - *   2. link() fails with -1 return value and sets errno to EXDEV
>> - *      if oldpath and newpath are not on the same mounted file system( Linux
>> - *      permits a file system to be mounted at multiple points, but link()
>> - *      does not work across different mount points, even if the same
>> - *      file system is mounted on both. ).
>> - *   3. link() fails with -1 return value and sets errno to EROFS
>> - *      if the file is on a read-only file system.
>> - *   4. link() fails with -1 return value and sets errno to ELOOP
>> - *      if too many symbolic links were encountered in resolving path.
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that,
>nit: * Verify that:

>Thanks!

>Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for your suggestion, merged!

Best Regards,
Yang Xu

>Kind regards,
>Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
