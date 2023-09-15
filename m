Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DD5EE645B
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 13:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7F6D3CE6B9
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 15:02:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B8123CB172
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 15:02:22 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 11DE860320C
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 15:02:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrYn3apM5sswjoC9KLO8kLORmLNC1EyRXGs/jP7b6JqiwBinMy+hyOnJgbIvoI484dzBcExBovgMvhfc4Zxv6HLO7fcUq9kx5jPBuPI6cCwTFSZBQTzbFGAmoSUo6WpN/gmtpZAsoGdYeNknXsr/TxuxiAaAsV83pVc5N+MB++/jlSMrdQBCk8v47mfjYYgxbjUkkQoLlzhyhBZ0LenGWzzBeUhTgiYOmn6ZC8llBXzmQn0mMTbuFRkCWmR98yTQqowmVJK8HsZHtc+o4NoBAh/+o57eny39MYXasXvSMFfhluQL7c1EPCVIE25PCHwQB5LQeWtx5eb++yurKRwaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9MIrxx4aQF66H7oE8s5zzF6jeTvt3qtihpF1NN0v6U=;
 b=Ch01WDtgTXJFCQB3I2zGrGWHPzN3DyYpsSbl8QRfv5jvacKlfEbcrqukcjj23IPIH7jMj9AvWc1s30i70RckCv+nlIZ/e68JGwqP7bGIn6skjSsQxySLdXejq1iHQ5CAyA7Y7vBda/BHwMnl/WFKV24w+/T63mzMHhOlUfUbadPM5KtZir/K6gkqouJp6296KWhFJI9ORWm0+f1XI5B5AVlS4ufeEuvVO3ohlGCCJR03oY26V6+tLyzx6cOd3yw+i12DQAFP6UDrGNwdqnwfXZHNuZkgyOwVh6ZyQ9HhUO29LsaV5ocAgGfKley1ephhGD8ElXhzs2bIwV6T14GuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9MIrxx4aQF66H7oE8s5zzF6jeTvt3qtihpF1NN0v6U=;
 b=nC+EaLDGaBfnClQ/0A/jSldC1md8KPvSw52qU32iJRI5RC3xd8HbERq99TRHKZ+bCt48XwaW9m1KoMz5WXF6cfc2f/WvPpxkR3ww89htpD9lPcPS3OPQlG65rvE8L8PUJ+GjuixjDuE9/DO7Ra86gPGTgrFKVCKMOiMmBsaJTihL5Jn146of+bbd4xHG1D3+SZ8l1JE/hmKlrcUSFJHkQPS1EiOUGrswC4fBLHGTNERheOdl5R8+qtEuOeImiLbsAtU6uvpxWMZmBKHEW/HcZwdLlgWm9hvgucSTMDGhQxl52pySWqK7w8jkON0RVom4N118N1V5LyLhHwuHvzgcOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB7076.eurprd04.prod.outlook.com (2603:10a6:208:19a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 13:02:20 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 13:02:20 +0000
Message-ID: <8b1ed832-2c6d-4e1c-8227-234e5864b300@suse.com>
Date: Fri, 15 Sep 2023 15:02:18 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <ZQF5J0UJ25_QLwcQ@yuki>
In-Reply-To: <ZQF5J0UJ25_QLwcQ@yuki>
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM0PR04MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a5c2d1-1704-4e82-8a26-08dbb5ebfefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4EYSYjrPRee8hhKOUVlch7WrTg09/FhyIpMNInpuM5hYX4mIdpWegO+7An8TSA0B5eMCKpX8Io2lx6C06U6A6V7R7AgubCEJ1KtM+nR3iD5EwpbQNO9y8ofIxoVaSeArKHzXJ/M7A1uIfHuh7ZllSyJls/6436WsUZfGsyUQdWOL657ZuSAX/i3QMlJElDoeJa0UEaVQKiHejCHUoisfuvi+tMTejsxSjeZgQr9neF7eU0Xo52swqfmLuJkcM3W9BanSozKewL0uBmhXh07cQoBDiHs56VuppG0+XCbUFzt0NZGpFJXsqvMrYFXPhfbc5BK293mcEObJUmKuq3wDnsit9quOVZP7eOPT3E7TGimREL2naRpyZJxMEChY+9OdyCZgnYk7QC/3qQO68CRsl1ptH9mnmc9uwukj04SnRCdBuhoVtms6KJRO45LvUWP8gc/tYnDSkFyjDYwUTz/UWBLzwtMuAPmkAiaPKmjOTjWUAFcRhIyXR0NggT+hgL/SzalBDhpvkjhFD/UWPTq3pFvJxN93xu4u15PzjjqA6nrchvDADjjhNrk+kgrWRpu2bz/cIxOFK64TolHAJAsXqUBh9hLc519zLtsLrkRQcL1CtnwbZCOd3rV9gRo86SOUgKn3Y4fhBJihRZXw/tt3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(1800799009)(451199024)(186009)(86362001)(41300700001)(66476007)(8676002)(36756003)(6916009)(31696002)(66556008)(66946007)(83380400001)(5660300002)(31686004)(8936002)(316002)(38100700002)(44832011)(2616005)(26005)(966005)(478600001)(2906002)(53546011)(4744005)(6512007)(6486002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHd6YlRWMUYzMFIzZ1MwN05iV0R3Tm9LMmZBYWlNTUhtelpxcnJQT0JUdnAz?=
 =?utf-8?B?ODQ1SkQ4bU1sekMxNTVFOUZDS0Y4azQ1Zm16VFVjTHdqNXhpdFZoSVFnZFJi?=
 =?utf-8?B?Vi9MVlBUbWloejhVeVZWSFhlbWZ3ZHRWN1ZCRHhmYlVBNmhiYjlIMjd0YWkv?=
 =?utf-8?B?Uko4Q1J2S1pCenp2K3dEQkZzVWl5eFRRRDZWQldScDNFcUU2WTM4dytHdG9Z?=
 =?utf-8?B?WVNCRnE2OURWdTVuNjg4TG5MelhNaFE5aHMrb1JoUmhXbENoVG1rUnBWZjBS?=
 =?utf-8?B?dVdEYUhPZTQ1VnBUREhNa3NkOWN5L1ZJRGFaenZyQzJOUFdib0lVejNQVWdG?=
 =?utf-8?B?TkJiM0swaXhud0duSHloN1VzM21HQVppUHk0bXozSFMvSXh4NXFTT3FMUnJk?=
 =?utf-8?B?MERhY1QxZWpvSDRwbm42a08rVTZUaFlzc21RYzlUVnV3VDRnem1RYnY0MWhN?=
 =?utf-8?B?SjVrT1hpaTM2NnVLQW0va3N6aTFweUUyN0IvZVBDYjFHQkFNZ3VCT3pBb2dn?=
 =?utf-8?B?dG5ISWlYMk9Fait2VXpITHY4dmVDRVE4MHRJL2dYN1ZnckdGdlVmRXhCZWRK?=
 =?utf-8?B?RnBCM1E4dzQ2ajRabWZiN2NhazR6N2dkSm4xZDFkVVU4Y3p3WGM1VnI2WWpj?=
 =?utf-8?B?eHhpYXFhQ0JHYzFTWWh5YmhDd1RzelFZTVR4bW5WQko4V0hrNFEzcGw5YVhq?=
 =?utf-8?B?T3MvYzMxMUZxQThjaFRra1g3enBqb2pueWp6M1IzWkszeFU0S3M3WW9PUjBS?=
 =?utf-8?B?citSSnZQdjF0SWFobkZySUtNVUo2V01ZZUx3Nnh3cUI2eDc2QzBxRU14NDBF?=
 =?utf-8?B?NE5KZmJ2WWNacnBCTVM1eEJqWG5QSzg1V0U3SVl2VWk4SC9UcG1oLzBZM2Y2?=
 =?utf-8?B?V0dUSkt2L0c4WCtFVlhjVis5NTh1ZWducUFMdm5hQW82ZHpPZG05NDUzVkgv?=
 =?utf-8?B?b1F4MmUvajBORSt0YkFKV1NYVzZPUHZuM3pvbldtaVFHU2ZRVmtoREx1aWdh?=
 =?utf-8?B?ZFluaC9wNGR0VFVqQzVQV1VlUHFPdmZraEJzUythQmFJOURDR08va1BDQVcy?=
 =?utf-8?B?elVrdVhURHJzNzlSQ2RTRWZ6VVVvYk5RZkJoc1FzZGNuN3BNUWNESVpHbmdn?=
 =?utf-8?B?ZGZTZHNKclIwYkRRcDNtTG9hV2lyeEhkRjR6OWk3eFFHdVlFZWtpbjNodW4r?=
 =?utf-8?B?aEhBTzBsOGhYQURtNGdRVEdTdzd3VHg2QUlON3VQZk85dTdaSnZHQzgwcjg3?=
 =?utf-8?B?VG9HLzdDa3g3SGtWTWkrUDNweklpR3B0MjgwM3BYYXdpSTBjTzg5c0ZPaGZV?=
 =?utf-8?B?REtybExnTjViWUNBVmRmRmpNKzZ6cVR2Q1dsd0kwcGZtTnllbmc1TVRMV1A0?=
 =?utf-8?B?WVduc0Q0c2xZUDdEV3JrM0tQMzRRamN3UkNockV5Q205U2xkMEFNMVE5YUxZ?=
 =?utf-8?B?TUxGK0dhWWFJc3ZHMk5PQTFyYTdjLy84TW14aDRPa2l1RXZXamNBYUtrVmh4?=
 =?utf-8?B?QjViaVNpOVB2TGNVeTdWS0NjWGV1UXJMNjJ5U0h5SFBIVkxoK1B5UWZqRjhj?=
 =?utf-8?B?WXYzMkZXT3owcGx3QU5nWElvT3A5c0E1b3NaUmQzOEsvRm0yb1U2R1N2ZTV5?=
 =?utf-8?B?TmpSZ1NVSmhZb3ZvWXRKeEtCZUhtVTd4eTJYeisvR25kZUN3bGp4TWt5UDJ4?=
 =?utf-8?B?TE1QenpUb280bFZKZHZheXloSWFoUTZtVFQ4RWZxcldsaHB2aTdJd3V3ZWRs?=
 =?utf-8?B?RldUTXhybEFKVmg4aEVPb1Yybzk5MjdLblUrNXVidXI1TVhmWFVOMEFFZWZ4?=
 =?utf-8?B?ZCtZdkJkaTYvY0tQeDErL1Q4c2NjMFVIaTVZclBXVDJlbnNwelloeElha3lK?=
 =?utf-8?B?SmRRajV4ZzJwQndQVUtYd0RxODFWSXFyNlI4N1Uza0VOUnN6dS9hT1RFRzBV?=
 =?utf-8?B?ZXFqc3pCZ3k0Z2g4UEdpaEZjM3dTQnQxcDZ3UFRVVmJGcElEWnFFa25CcWc2?=
 =?utf-8?B?aEVNSUNibVp0SDVQQVlhckNtUHVLaE9uSFJ6SUx1QUtFaW5TbE9QV3A0UXRK?=
 =?utf-8?B?NWR5Q3M4QmVoTkhzWWlsODlteEdQK1pudWI2MzUzNnJDNzloT1g2VGRXSlBS?=
 =?utf-8?B?cmIwZWUyWEs5cmlVNk9Rank2Ryt4QmsyaGhYRlFUalNPVnJqMnNxM2ZPbzVo?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a5c2d1-1704-4e82-8a26-08dbb5ebfefb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:02:20.4820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANo9TxgFgSF28CA52Q8gJo+BCshRI/C3pVyfbFMtQ3BRzm0REER7q1goXc+gVMqDnGGAvBMFR6fkdPF833q4xYNFNxzgH7biOXUOf5kK2ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7076
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

it would be nice to add the ltx tool into the next release.
https://github.com/acerv/ltx

Regards,
Andrea Cervesato

On 9/13/23 10:56, Cyril Hrubis wrote:
> Hi!
> As usuall we are supposed the release LTP at the end of the month. In
> order to get at least two weeks of pre-release testing I would like to
> freeze the git starting next week. I will try to review and merge as
> much as possible till the end of this week. If there is anything that
> you think should go into the release let me know so that I can have a
> look.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
