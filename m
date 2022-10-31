Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E6FFA3742
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:16:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B29D23CAB0C
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:15:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8CCA3C08E6
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:15:47 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140049.outbound.protection.outlook.com [40.107.14.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBB4420075A
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:15:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+dwOTfrD6eOXjvNn9xMI9nnrVA/ERw79iWtNjwZW/R+preNx+8kgiq7+2YAqVO/ndeZkhBur38KSS28o2DMWKXdE5+2mpW2eUCELHiisF+fxdWFNe6ebx4WtcFuk5Q+1lHAqA/3KgLJo6z6c0ixnWVthpF98RUbz+kS6qADEqGMeXAeroFAqYwHByTG/ZHWYoW1Lhs0zKcpL3AflxUlj91+5tChviUqKUnviGVuLBftZS4KZ5iGQlB2b5IeDlLyG/0bA5fs/YMcN53ZNgFAdHQ9Zfob5zzl7kuAP3R0yeYnoNdQW01QSlp1t0ltojVFrlZRwoVGb2zU/46gg47umQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYr19jM/o8ZbBRMfVzX96iMq90a3RNHpE9kxq81Hy0o=;
 b=JwfjQf8u1KdHvW8NGuWq87nfAg/1xaEFi4UQ9j/sm+DR6nOk0eH7eUFzbKh6kea18q+AemGoDA01AeREwX1hms9QUknAtZff2MhDxtRqT74aBFYuHtEPyFPhbfb3nm2o1Jrdr1w9zeJuUMzaSGqh7JS8GyzC61QBdhUdNCn7ez7xAwyIM+oO/MgvQlRBrOsIeBdNwdyEAiw7GqD0cZZMt7FuiPUYeksu3MCLp1RkJSPlK8RVySgo2aPrV47JKHw3kT1RqcPutL7C4Zg2fs2iViPcTkg9g5SXx4s0R+xprns6/LbL7vAONJzDd10o5ElJoHBsjAdwvT7UdbHpiGlb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYr19jM/o8ZbBRMfVzX96iMq90a3RNHpE9kxq81Hy0o=;
 b=p5293E1R8HDbbclLPopjXDCxASIjU1OuhHNWaL0XJbg1xa81i+XHKbpi0K+1MWpfAXCwhGgcQMqEd+CC7Zbx0BswW0O+Z1Mh9i/wG1wlhwCPiDq/fTlJ/SRjw+cydBrKPKXYd8wIkCnDCyMBwL7oXq0T2QMHmYA78wtqIM/UGPC4f1DYbeAJk4c89H6gYbU0Ck0Sp5kBb7nLAR6NZx3RqWaaIJcOGLsd5zdVfoB3N/Usv5qGQDfDLgxMEzJtI7zD15OXtOpyykRFYkKBBmIXsNm7VRdeHaYSyWsrs69fZhfXoe4MbV129XYqCEwZInTY/GPYk3KKCAbCPkfM1tITow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 13:15:44 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 13:15:44 +0000
Message-ID: <07e278ff-3122-cf42-d739-2bb6020b921b@suse.com>
Date: Mon, 31 Oct 2022 14:14:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To: Petr Vorel <pvorel@suse.cz>
References: <20221031113046.9218-1-andrea.cervesato@suse.com>
 <20221031113046.9218-3-andrea.cervesato@suse.com> <Y1/GpPKVzWUAV1DK@pevik>
Content-Language: en-US
In-Reply-To: <Y1/GpPKVzWUAV1DK@pevik>
X-ClientProxiedBy: AS8PR04CA0183.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::8) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cd7300-9334-40c0-db5a-08dabb42047d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRje0mAimvghYDQZ7KlZAKxZyl0yCmI5KHFgeltJiDcoKhFkpjot1WpKnvxFhAwxO+NzXIl+llgvRW0e8fdVil3w6ikWYbbVa7XfsJb6PsoRqUtu19tG6UxVtBd0NhNJXImmAMUfuKhVpzTyn9H+7j7QI+YtM7zThD91w0JJzDwKrizUoB5owlCIIcWDaadSbxklGT5MSxgNyGx04lkQx1k9WGL+IYcqNito9iotZvOVz8EYnhG0Dc33miC19BbVokQCeKbBrvfVuQUJQOb67Qq20Q2BfiZVoQR/54XjVKskQ79h9gJ5OkbPtrZQEFg1yecdh2hQ5kr8iEyZcYDpEMuwxtAp11U7915C/1RV1ZAOdartpc7K++Zst/38rnMB1y8yomjbwtHItvvUR8D7U8WK5kvqjvtggzdsNci0dJgLtqs5Y5wTi25OnRdhd6UYwwQ82ajCTqlIFGU29lzhOcHu0NNlSNTWQ4X609o2SZJbkdtuuiwzCyAAjXSDIyFTZv2jH/skxCwWBayzdVg4MGAam+ex2GlwpWf0DOluuIjszw2z+Zh30tQsyXP83L5g4Tj9kO55Q/7DgW5jHxGWZqkCfYCYTpKXpVOXx1PKxSBpKMdqPDteDk8UlnMx0qrQnVQ4T6JoE3NePap1FbWnnZrrlkCcNe/7WNiwwkCoTeWn3vgDFzqfJUc7mAmrH+2Unfqvmbu4YejLpS/n5bwxNmWUhuRb3Q3wqbhNZdJdxkKpM2U77hD+ctH2sR2wACybq7xKwK0/7gA+2FgNh09k97PtFwfeDhJeMBq2NqIut0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(39850400004)(346002)(136003)(396003)(376002)(451199015)(41300700001)(8936002)(66556008)(66476007)(5660300002)(31696002)(4744005)(86362001)(186003)(478600001)(2616005)(6512007)(6486002)(6506007)(2906002)(44832011)(53546011)(26005)(38100700002)(4326008)(6666004)(8676002)(6916009)(316002)(31686004)(66946007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R21FcElJVDVKRzBwdmFXMWxlMHloN1VLYUdqbzlkNTV3dklRWUF4dDJOYXhj?=
 =?utf-8?B?VEhMcXI1aFJEb2RoYUZlUklBUUhraFYxS0Mvd3dTYW0wZmkxSWdtUmM0SU91?=
 =?utf-8?B?QlVSYXdRNUltVXBML0FDakd6OXhjcEZPOWpQRm1DT3pzNnZ0R280RjA4cDBw?=
 =?utf-8?B?d2Y3ZitZK0JmazNqSlAyOFpaY3orcTRRdVkrR0JUM212ZjBnSXg2d0M4Y3A3?=
 =?utf-8?B?M1ZSL3poMDd0bjh5YklBd2dvNHJZOVhuU01hQzZ0d3UrV2RDVUJiOGhGN3NN?=
 =?utf-8?B?TjAvTmJ5M09DaXV2REE1R1dVOWxZMldTZUdMS3lpcWdKRjFvU2ZwbEh3ZkEy?=
 =?utf-8?B?aGJkNG5BMDdxUlhsb1IvVnJYZ2dmYlArN1h4OG13aHY3T2lISldKYzFIZVFk?=
 =?utf-8?B?RitBK0VOaWdkZkNabm1FNHpLUkh3Z1k4L2NmZEMyclFzVzVBdmFpQ0pSWUVr?=
 =?utf-8?B?blNhWjZzQU40WVpZY1RZRjNFQis3MGs3K1VnUVNnUWVYRndTam1TZkI0RDUr?=
 =?utf-8?B?QnZLV3pqMVpWWk5zcWNDVmJJZkJZd3grVmdMQ0E5MDBUOExPQjBOaTFSajgz?=
 =?utf-8?B?OFNFSWlqdmVkc1A5RC9KQkErQUhaNVMzM29SRjFUYThhUlRMSmk4RldiVVJY?=
 =?utf-8?B?MUN0aXAvS1piSlltSlpvNUNRWk0reUV4MEtmSFlBZlRBT2VLVEp0eXk1cjd2?=
 =?utf-8?B?QXVRRXRiSUxaZUtWUkxzbWNoMGt4WE5EZStvZmgvMzAyWjRheTh2Z0VJMmpW?=
 =?utf-8?B?M1NwU2l5clRBZXBReGVXMGpJZUFkLzlTd3A3ckZLYlAxcUdwVDNyeVMvUVVL?=
 =?utf-8?B?cGtoT0NkMUp2bk5sRlhsV2N6bllab1N6WmtkbkNEQURyNFp5bWozRExTTVM4?=
 =?utf-8?B?TzRObEs1NldTU1IxVmlpOEErbTJUN3N5RDlUSzVSRFpDNEZZaWExdXZuM0Zz?=
 =?utf-8?B?SU1ROVIvSi9yc2k0QTdaZFQ1S240V0hlUUJURzRjSkRZNmRJRlVTc3ZpdXBu?=
 =?utf-8?B?OFdsUDRNUUpCWUEyaWdDSG1CaHBUeGl2MlJuZXI3NHlPWFdJdGgvalZsTGJw?=
 =?utf-8?B?dTFrZkVHdUJ0cHozanZwbnpZamp5dnZJQWhwMUNJK3dsYklBWWd2L1dLa3Fn?=
 =?utf-8?B?b0RuRWdja2xaLytaQjhMVUc2UmJZd045aE81Y0Z2bG9Nd2NZWkZCaFdlVjJO?=
 =?utf-8?B?eEw2S055MC9OTUJldTdXcm9iWnlvT004bFpHL3U2SEQwajF1YldML2p6UjM5?=
 =?utf-8?B?NXpac1M2QXBxQTZuZ1BiOG1WUy8yM01IRVFLUmtQRm9QSWtVNnhZVWFIUklU?=
 =?utf-8?B?Ny81cjFFTnhsUW9QeSswVk1QZGJzWWhXdWsrZGZwT3VYVVNQWWZNZjNnelU5?=
 =?utf-8?B?dGFBejltUE4wQTRMV1BDaUh4enBsT3RISnNkNnJ4RWl4ZU9NSnlWVk9kaVJU?=
 =?utf-8?B?Z2NnL3RiY1VydHAxTW4wRjVJTDBpeUlZWkxrOWxlVGUya2xrL0laY1EyaGVQ?=
 =?utf-8?B?L2VhYVVGSGtVUUpvY3owTzZ0UFluVlFJK1FRYVc2NzJOeVFRSGlya3UxaUJ3?=
 =?utf-8?B?cEFvNTk0SUREQUM0YWl4UVZ3L2VFUEhxU3RjU0hjV0JvaitXSFZ2QWs5SjM2?=
 =?utf-8?B?RnAya2FUWW54OGc1OFkxRmFIbktpdUJiK0x6NkptN1Q3QzVNVlh0NHVwTjNI?=
 =?utf-8?B?N2JUbjQrc2NpZXBOZ0hGeU9keFBnVzA3WEN6NXBnRGcwYnZ1NEgzZWlwNW1Z?=
 =?utf-8?B?RXQwQTl6eG1na0dBVS8xM3ZEdGh6WEtyL1VyNVh1a1ZYNlZYSGhqSEoxYVB4?=
 =?utf-8?B?SUhMY2Nqc29oZkk3NllZenJMekREL3lyVWxBMUY2b3JsTWlQdWRnYkQwb1pj?=
 =?utf-8?B?anFlYzYyd29oNkg5cHFkL0pOdmg4QU1SY3c3cmRnNUJvTkVQc21IUTlBQ3BW?=
 =?utf-8?B?U3JPYVp3RUZOU1NkMk9abWVlQ3lSVTFhTG1NQmNNZHpoOG5pTGJ0MnRBeXBN?=
 =?utf-8?B?ckJKekxad1JDbUxXcGZscFNXdzkybkNIQUQ4emR5SkpNQ1JCSWJmVHgrLzN6?=
 =?utf-8?B?RmlRZVllakQxQ2JCOUlsNUovRUw4cVl5MUxWS0s3Vkl1UmVuWGRqT2lpM292?=
 =?utf-8?B?azMzWUJNTE9BUmZ6TDVrSVZxa3lGRW9qZzdYbXpsY1UxOURkVW54UVo0SlNi?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cd7300-9334-40c0-db5a-08dabb42047d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 13:15:44.5813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdXWXSAP2UsubhFqI0+ZvxbDnGFeide2DDcrtawiCFyRQgJ9whq6Qf1UGbRsQxSwsIsNcioWXIx8a1KSoSSZaIQJncEdRniBTGTjKqCQTM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Rewrite utsname testing suite
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

Hi
On 10/31/22 13:59, Petr Vorel wrote:
> Hi Andrea,
>
>> +#define _GNU_SOURCE
>> +
>> +#include "tst_test.h"
>> +#include "utsname.h"
>> +
>> +#define HLEN 100
> Could this definition be in utsname.h?
> Also, although getconf HOST_NAME_MAX returns 64 on my machine, maybe using from
> HOST_NAME_MAX would be safer (that can be up to 255).
> Also maybe HOSTLEN (readability)?

It makes sense to use HOST_NAME_MAX. I will use it in the next patches

>
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
