Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017BCC54EBC
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 13:32:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B89E43CCB29
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 14:32:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 108573C538F
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 14:32:12 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBD75600803
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 14:32:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n61F8aocD7Ly8elbkCYNiYENuF/mMHhT+vwJKInwFpW4+a5BWPgdUP//1ZmFz/DNWChQo5f5F3TvblkFxn50wwsD05EttQMzGozljBm+0CxcV7sMdexCvBIdExm3fAu5pDNorPIwdyvOJhNRLcgi2y1t+i8oUtbDlW27KgbjJYRG1O8o0mVX7QcEt6elau6ZM10XpWW8jBi8MZxSZaVN7ZeI+tvBQF2xQcsTfjZnMgMnQVKEYQkTKx/Lg1RxVClJxhuLaW7sjJ9q+HfcqL5xN9UlxTbd+u5XmHGba5pm5To+EIKAC6FujJz2DXGNh2M7iUkj+StCN/nBh38QEg76qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3n/TApznFeBTlLVAUdIthKTJNs1TNTZ+GmttS+gayo=;
 b=NKGI2UI0UCXl/nuGRfWxKFdbj2e7WrH82ing/B50kHpeVEm6t6pxruVTHgx4TageBQkbkOK/pFV50kWv9RB1KiWEfhYmENEHi6qjWD54KDcDluPDd6+QVCTSve3/AdZ9zQ7Xt9yuMxcFq5cO3TzGX3+rGTA5+ByK7tIwLLFnR54ONIBMGvplekSflxtz249YPeElqfU0rAG+tAaPV3BZv7bd4YRFE0UelsSf6KwsBYbvcTOpb+Zo5DTaKz6R2t+2x2QGv/obqnn2pf2E2ABQIGtNwvH4ps7OVhxZu34IknuRuiINmway80tidRaIMN7UdCmBPzsRBYRTbOyhPOtjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3n/TApznFeBTlLVAUdIthKTJNs1TNTZ+GmttS+gayo=;
 b=xOupmw+aIrcUQPibubhYn/2PyOlNOiOwX4PU1PEn2JjBvzDL5vrLbtjNBzfkLyf0Z7fF05vyBZ4+PHW4hkn98p8kqOJqhMg4LGXATR6ziBa8sD0Y061oT6f1J0QaYCmy1qgk92A+VQEgimV6qOac0CzybMDOTXDBphd6FEwb7kha6hn8USRhISpnXBXsgEacKU1SSY8Wtz2sWzNleIy4R5YwYuYKzLVuYRyhDGtCQan/cNxHexDrg+S1piwf3/+p2TF0H1NsFUwXcLHRTikkj7NHYIGbBzj5dM8r1dBlFxVi/tZKCTYH1T86vHp2r4KN0VWcS6DNwoYUPL7Ol0NYvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by AM9PR04MB8398.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 13:32:09 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::eabc:a2d7:ab56:d72d]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::eabc:a2d7:ab56:d72d%4]) with mapi id 15.20.5944.019; Tue, 10 Jan 2023
 13:32:09 +0000
Message-ID: <7981cc89-2d15-245b-e9b2-f41f02a7e34e@suse.com>
Date: Tue, 10 Jan 2023 14:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20221220144232.27950-1-andrea.cervesato@suse.com>
 <87cz7miuo3.fsf@suse.de>
In-Reply-To: <87cz7miuo3.fsf@suse.de>
X-ClientProxiedBy: FR0P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::6) To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6788:EE_|AM9PR04MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d820fc-0cf4-4b0d-5e11-08daf30f1304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJRJYsv3PhJw2KTq878qM8DVezq5mmDF04blhtVBG2Wn7qNPKvgR/1+s/GxjsQM6ZmGxUuslyx+OurzsjIou4DfjY7t+NpFCqxVFHT24B/mzWT7dUNN6ErkH0fZE6GOggb1bXTcrQD6Vgfv5Hb46AggcAo0dTczrwn6OL+MG0+KAlF0r39T8SEuMoItz28nnuQkSJ7cOwgNa9UdbEHUwna0zu621C9rcK5kBtHFFVD9E2uxEAlMbujH+k6XMU5J22HbQS9rA+pN0y2rNTCCjLEROFlvx2pgveA0tJ3hMjIwqH9xXm3iYwrVasa14jTiczhMFDNpNtKXgBYPC52/wOnfZ/ZupDWnaJ9GqZetVT5/lP0M49nVPLYYWCkunxbOxwc7acNFVKOUeIPiyVtDUSUIh1lhNjLWcmodglplfVRiNHMp6ZjmPn/85U6sTNr8RAT+SWexXd4r08tzIPkkaUdXNGeNPGRALp9rim/sX7uBG2RCBdZD1Itk9omAsmVPQ7fbNz1KLINypi2QBN2i8M+ts3rzf02knnnx2b5ETTwJSJ3euEvIj4LeSWqnZFyrT9LdEF9IL9UYCW+6xuHfFgEcogUCGU2YQd8H/wYT4Qsf6OCDAX+/+wG/VZd4vpTJCsuW+Iz+xb7avsXy+D5RSJbvzrCHP28tG1eVMbdRkF5Utx5i9UR3NYylZzzbZeP8z3kgUj3TN+wz/jx2cu3ZZiRq8IFXM6zDkLqgxNrJ+JEZBreTt3uT6l+E5kp2/DQJ/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(8936002)(2906002)(5660300002)(41300700001)(4326008)(316002)(6916009)(8676002)(66556008)(66476007)(66946007)(44832011)(26005)(6512007)(2616005)(38100700002)(31686004)(186003)(86362001)(31696002)(966005)(36756003)(478600001)(6486002)(53546011)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE1FZkZHb0dzRUpjN1JSSTdKZHlkOXl0TjExSFVyVWJ4bW9xYlBSYmUxd29w?=
 =?utf-8?B?eGZ3S0pmc0xDM01iZ1gzSk9DMWdVOTFEeGE3V0FPdndTcWdSOGZTUnladExw?=
 =?utf-8?B?SXpmM2lhVlJYcGI1QUZhdEp3OHpwc2M5cXdHbXdkYThoa3NRTWxHeWdnd0x3?=
 =?utf-8?B?bWpvQXlsWVB4eElnY2NyMVpJb3BwN2dFNTRIKzNGbjdoWUUwYWlXM2ZaWFZS?=
 =?utf-8?B?THZtNHhlL3d0QjJMZWJMdGEwTlpOOURaU0YwNEpjaVdUMExCQmpJT0VWV045?=
 =?utf-8?B?bXVnYzY1UUY1WWl4b2MzNEpNUFBlY0hRN0lTaUhhWXNadWdzNDVKeXo0VkN1?=
 =?utf-8?B?eit1Z1NyMWNUQTJFNzN1TzZFTVlJZW5SZVpPbkkxb3RYYTFlSFBzSHR1YTBQ?=
 =?utf-8?B?c0d0RTBpYTRpM2V1aW80RnJSR3hVd2M2bk5Za1JOS25LbHpCa2F4eHZmbzlB?=
 =?utf-8?B?bkE1djEwMWcrVGphZEZacVNEQTdhNGZKa1pUd1lYaVJQNFk1dUZNSDFhQmFJ?=
 =?utf-8?B?UFkxK1F4MHBXSGp0bURSVjFBYkIxSU9KRFo2TTNWRWE2UGVnZDZOZy9RY0dQ?=
 =?utf-8?B?VjQwTGtSTGhBMFFBaVd0RkY1MnFBbklDbmtVY2taNTdqNktpSGJiQXhkc0R4?=
 =?utf-8?B?TnZRNzkweDBHcjJydG5ySVEwb0tjQXN1dkZRTXBNa2FxRzBvelNqdy8rZ1Fr?=
 =?utf-8?B?VkpaQXlqMUFOdkQ5R2ZWNEU1RTJFNXdJUDFXR3dtQ3lDOWliQkZIRDdtY1FB?=
 =?utf-8?B?WkFQTHJqUllkS21keUxsR3VnUjdOUXJVWEFMK0ZOSG93aU9LR0pEMWFHRitk?=
 =?utf-8?B?OFh3RFhTOUprcGI1cHFGTUZKb0hRdzRjcG9qZ2tkMnhkWUZzRkU1Mk9mVllo?=
 =?utf-8?B?Y2E2ZGRWaFJFYnFBa2hFcFRjY3RHbjI5cHBlSDJHSGE1TFlhKzkvUVN1YitY?=
 =?utf-8?B?am9lLzBEeFpWTlBVTmV0cE5aUG5CY1NOWEQ3cWx4SW0xbENLcDVQcGFtenlG?=
 =?utf-8?B?ZGNnUjJHVVIvNFRKQWgvT3NQS3kxNWlVd3RDNDlDdHpMUDBlZ1RrbDA0UDBX?=
 =?utf-8?B?NFZ0bGM2dUtZN1EvN2NJWDR0S3FvRUhWQUVNa25VaElSV3dJOVZBUmM2Y2pN?=
 =?utf-8?B?NEI4T2FNZ1lPTU1BSExDSHo2NFFzRExDYVNMRklzWHVuVmh0M2tRYk5FSVVI?=
 =?utf-8?B?cGdmcXR1SG51NklqUVFKalFOMGJZdzRBeTV1TEl5a1dFalFIOXF1N2g0c004?=
 =?utf-8?B?YkhVb2lWdzdjS21uc091cmZPWlM0TjRIdWhjMER2WVZUamswZk5XR3QwRDNx?=
 =?utf-8?B?VU9haDNQb3owcXN3SXVmbEo0bm1YakFycm9FSDQzc3E5MmcrRE9xZnF3NUh4?=
 =?utf-8?B?TEh5MkYwNFpQdzVEMFAyb05nUEdRTjY3ZmlRL1Z6ajNqZnFVWTJ3alA2YmJj?=
 =?utf-8?B?WnF4ZktZdkdTVElLRGpDS2xVU2F3VUhvOVpjZER5UldGODE3SGhLTUR1emd3?=
 =?utf-8?B?ZnZLeittcDRqZVRWQWtrT3BNNEpSbTd5aEJIZHl4eS82cXp3RkVqU1RJQUhB?=
 =?utf-8?B?UmgwZEd5TkpPU21rb0Z6WGJGczJTSHJvUlordmdFMWo5c1VlWkVXT0ZlVks2?=
 =?utf-8?B?OC9TN2Nwb0ZNa0FmdFdHazljam0wOUNIbmZOUXR1NWJvNStQeHA4b2l2bjNR?=
 =?utf-8?B?S0ptcUhubjFCd294aWdnbmZ3OXh4QzJHVHZvU2F3ZEFBU0ZkZG1pZDZWUWVi?=
 =?utf-8?B?c0IyeDBmWER5ZXdSSE16R3BtbzBvNFdmenFIYkVMZDlzTXhwRndaQ2trTVRK?=
 =?utf-8?B?WE9LSkkrUXE3TFJyeXB4WjJDSHJyM2VQQ3lpK0dPaWhFQnRDZUp3TFNsNHRm?=
 =?utf-8?B?U1ZNT3NZc2ZRc2xoNVhicnN4YTFUNjN0aEZ0N2pkRjdXYVZGYk9kQy9jZUtE?=
 =?utf-8?B?Y1BYdTB6QkRKK2JoTzFvaEd6dXdRS3cycVUyRUFtMEM5RmFoNHl5ZVd1SVRX?=
 =?utf-8?B?NHFtTzhnODdnbGtKQWpyUXZsZEdJM0tIYmtONStWeU0zajNhcjMwV1BoLyt2?=
 =?utf-8?B?N1Y2MVcrS1NXdE0wZ0JHVGtadnFiOTlWVmpqZ2FrQXdHVGNUdk9pdWFQWEZM?=
 =?utf-8?B?ajlLcFQrV0ZpUkRhM3B2d0NBL2VIL0hydTI2eDB1WTJ6dEdlYlcvT3JmbnVj?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d820fc-0cf4-4b0d-5e11-08daf30f1304
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 13:32:09.6552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08EBZOyPmc/81lGDFCHe4KliueOHe9dTweZgq0yLBdrcI6C9ctQ7PqfhNaZdQWs8L7pYCGcDTtja1T5SNReXop8WN3XyvR5VZDZ1cB89sIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8398
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add runltp-ng to upstream
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

Thank you!

Andrea

On 1/10/23 10:51, Richard Palethorpe wrote:
> Hello,
>
> Merged, thanks!
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> runltp-ng is the next generation runner for Linux Testing Project and it
>> will replace the current obsolete runltp script in the next future.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Acked-by: Petr Vorel <pvorel@suse.cz>
>> ---
>> Use https protocol
>>
>>   .gitmodules     | 3 +++
>>   tools/runltp-ng | 1 +
>>   2 files changed, 4 insertions(+)
>>   create mode 160000 tools/runltp-ng
>>
>> diff --git a/.gitmodules b/.gitmodules
>> index a3c34af4b..d1d558b9e 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -4,3 +4,6 @@
>>   [submodule "tools/sparse/sparse-src"]
>>   	path = tools/sparse/sparse-src
>>   	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>> +[submodule "tools/runltp-ng"]
>> +	path = tools/runltp-ng
>> +	url = https://github.com/linux-test-project/runltp-ng.git
>> diff --git a/tools/runltp-ng b/tools/runltp-ng
>> new file mode 160000
>> index 000000000..39792805b
>> --- /dev/null
>> +++ b/tools/runltp-ng
>> @@ -0,0 +1 @@
>> +Subproject commit 39792805b3c2c30bde665b01550994aeecff6071
>> -- 
>> 2.35.3
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
