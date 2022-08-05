Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDEEC00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 11:13:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90D0C3C9451
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 13:13:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81E903C8625
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 13:13:23 +0200 (CEST)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 77D621A00352
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 13:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1659698001; x=1691234001;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZDvR6mAfmadqiVXxtWtxe9E0ERZh4pbPq1g0Elxi1AQ=;
 b=bcYnhEIFqC32YcVY+XstPwpfp1Ldl4X8dE80bNuo3yPFAal+ErMXnAcV
 tH6iziXYGNeA2+bRi4zqSwPWDqqKB5tPr7XKfYaahJf2S6lB1Z6jbY6aP
 o9x+XhUvxTHhdSw411bD7hrAZ8hp32+VqJoZj6pOjhvfNFG7B9uQ+Oxt7
 lp7zUHhPNDq+56OuvcACIkMcevdLKIwc56NWA+antBU2bHvpIl8hk8XdZ
 ylwevhoxALA4YmdKcpa20UqNVY4VYI6fcLBr6PtuEWikfvZhscs1YGJrJ
 4gbb15g10aB42s63oLrectiTsDf6F/TGQBpkvwxgcJRtbCd2nh5s+i9RD g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="62348664"
X-IronPort-AV: E=Sophos;i="5.93,216,1654527600"; d="scan'208";a="62348664"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2022 20:13:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3ua/0x50aYPgy+6CdY5oc9czy3HA/HD9hyNvTVVb4tMeFCG/QOhr8tSZkX7UxtLUxNJzxoDmnl2PeEYM+2RC+O2taKPeqwrZeEtDVfE8eAMyesnZ9ksceg9d0CuulGHPRnQsScJgGudDwDmwSEKAmQP/ymK8gTaSzDHcHQ9hvx3T1lek5q8awKodb5xw71K7DdYU/ZpivMcFyJzcaJcTnXtkz1G1wjCKFNF+tCEADwv5C+RcRiXVUvIG6XbwHIcNkEyjr72biwLHdrVKCepy6pKSHuWZfDtxfZP6UGI+th2cNWLEkY9SpV6yRrxSaPQB4Ojz0wP5OwW9NaBF5qO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDvR6mAfmadqiVXxtWtxe9E0ERZh4pbPq1g0Elxi1AQ=;
 b=E7XmkAa5t5jxwxjwWNvQeWDVk3Khru6KRFsBdRyMN7rzHR7Kb82GKybI3W9V6WkeKA1d8kcyuZUZ6GDIalRfr7ZBIX2TbnGWTRFn0B8+HiGnJvIOWphM83FfwsVO3kkZfGmUX57+9yzq9r8x+7GFjJ//VtVvaplhSiH9q8eDUQsN2VTUpdNz4YLqnUw2vPYVtm4G9njLb9kKYXyhNLjTQ/7m7aYm+ozJ7juZG34QIvsML5zBIkdaI2dGY0rF/AJC7p7ZZbCtXW3ieIobpDCFDRRtYxvTDfPRUkwUXLerK5YUS0Dq//r0H9psvm7CVoD5GVjOM0Elhs3IhVfN1CARHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB2541.jpnprd01.prod.outlook.com (2603:1096:404:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 11:13:16 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5482.016; Fri, 5 Aug 2022
 11:13:16 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v2 1/2] syscalls/creat09: Add umask test condition
Thread-Index: AQHYpuAXDvOrRQccxU+lf3eG04Mnpa2e5R+AgAFW1QA=
Date: Fri, 5 Aug 2022 11:13:16 +0000
Message-ID: <607e1f04-ef3d-5b96-ea2d-a076bb1db01a@fujitsu.com>
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <fb04488d-cf67-b419-2249-e9b844e5ab3d@suse.cz>
In-Reply-To: <fb04488d-cf67-b419-2249-e9b844e5ab3d@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ab84952-b845-49fa-0c9c-08da76d37ee0
x-ms-traffictypediagnostic: TYAPR01MB2541:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qqjISZC5xRVm1yQZZ9zG464e992DBDzDYauDmwTP2RbBq8Il4shgvanAgEIM84pneTSWGTxJt+LEIZy01Zonj170Ji8xEJR6EpNObYqXwJEbfz15S9XSgWR46Pn6OVyfMaF2AXVhM/6L0Dgmr+JVol287tmDjEA2Dv2OS+hoMvjKdRNPIn5+Wi2pXNRkd8c1GRoooRYZd6qQubgUw9DUQLGo0YK+VGuONXN8bcKVXGZMxx7f4noNSV4QPkEI3fh9mAI6WZO4Ocjl5RxlbeRsLHFDaYlq+cpTqR1gG518RtMw17EnhBYEQneh9lEaQyG456npLgbesaiX6XdZKsfTkfoWlmkXIETYJDccqivttwJgkI15xLxqcf5A3Od+5IBb6lK7BTr7nDPCRx6imXMjS8FEjizfEGeUkLPMCL5SrdoQM/teC7yXQwVUPddcKTDDVxUk+3HeTLhBJWFeImFO1Tz8RcqDv1wxcz2otrU4D1rcUPg8uw5zSmTOMD9WQf0CPedZ7KrofBnjvBM9t4lt7JjovVJb6C6kUuJ8s0z7gflG7+nb+5hDzUoxcbnCtR5YKCoQCacWh7puUPNySklOkEHiy9F5EB/kZzL5ktHK8DqmuV2JvkBBqC3vxmsJOofVZp5omiJ3GmizhfAEnBx4uUwsuWGbnHz1M0dpPGFEJx3EwpiekTEOL2P2pdem90eQoSPDR3w5Gmd7O9o9Lw0+n/ENmq76p6num0wFdmq0flhbc5x5ypC7jFLyx0AWhNJyH0WJvryghKu2JNk22+lvd4xOWKw2AR6ZCrp8pTsl28Wq/53B9iiTL7f4DBAPsApGM/Kp6WKuO5nbXjrEwPkuQZRaibCD8+Y7obDlCJSj5l/aoXESQuOBvbUNtDzCR0y8TUXrK1CfJEusAswAXxcyag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(31696002)(66556008)(122000001)(6486002)(82960400001)(38070700005)(86362001)(8936002)(38100700002)(71200400001)(76116006)(64756008)(66946007)(8676002)(91956017)(66476007)(4326008)(478600001)(316002)(54906003)(66446008)(110136005)(41300700001)(186003)(2616005)(83380400001)(2906002)(26005)(6506007)(6512007)(5660300002)(31686004)(85182001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWdtYjBGSVpPa2UyWUpOUDlVL2lUd0pQNkk3T3k3M2pxc1VCZExhc2xiVlFO?=
 =?utf-8?B?cGpaekc4ZVdUc1NCRzlBVWR4ZjM4TkNhQkpqRjBKK2hvL2VmMllyUkZYL1Ar?=
 =?utf-8?B?OUdGOXRjMmFuclh2QlpKc3g2UENVa1pGemphL0RZa2VyaEdLWlMzZmVCVmxm?=
 =?utf-8?B?cVBFQWdwcllkSGtoS0pIcmc3M0ZBR0hteWE5Vys4K2xtK2IyL1MvWkdsazFt?=
 =?utf-8?B?ZFBXNEJlbTJ5eTRvdzhZVUgxN3BJYTNRUjEyc2Q5b3RiZ0VrTS9wRFBPVCs1?=
 =?utf-8?B?bUNyOWUzU0FVQ3BZR2ZmaW1Dak5TN0M2L0lMVFY2Qi9qV1hqTjQrbWd4Z3FS?=
 =?utf-8?B?Q080RzNJN1JjZzdDSVRTTVQ3NTNoVWRYOFpkOXExWVQwN1B4UU5JM1I1eWpj?=
 =?utf-8?B?S1pLcDRoemZjalprdE4xNncyaldtTTJ1L1cvc2xYUkhGRGlhNUdaUFQyVDUw?=
 =?utf-8?B?QUx5ZFBJR0NtQ3RpaitvSU4yZEI5US9SV2JHNjI3N3kyaTFzYVlybTJHbWlW?=
 =?utf-8?B?Mmx1VG1ZK1lZOTlGeTJZeEJlRHVsVXBnc0JqTEhyVDN0WG45bzZjaHV6SDRl?=
 =?utf-8?B?TUpyeUdnY1dhNnFsVzBUN1BuaWVURGRkUTBVM0o5RGlGT2F1cHEySUtObS9E?=
 =?utf-8?B?S1hpVDVic09hT3pRSGlaUmRQY1htRlBCOEprWXdHTHFPZjkvQ2Q3RElnZ1li?=
 =?utf-8?B?WkdOZkE3aEVjcENudEdmTDFPMUYrdHJQQ1lRNUhTTkFMRmlxRDBiRi8yU0cx?=
 =?utf-8?B?eW81K1ZxMlBqRG1wS1FVSkF0bEtSRFZ5V283b1JrbFhEeDdMeTBpZmluWVBC?=
 =?utf-8?B?MDEvYjZwUm0xbzZuMzdzSUNtWU11WTY2R0pDVGRLTkd3Z1A0MnVSWUViTjFC?=
 =?utf-8?B?aHd4T05aN1B3ZHhZYlZ0bHNvQVZOQjdTKzdtbFFQTElrL1g1QzllbDhlV1Fp?=
 =?utf-8?B?STlqNWpjeEo2WHpxTS9ZQzVqU0duRG5LWFEvak9iS2dxNjkyZzI1UUhScXVu?=
 =?utf-8?B?eDNLdXFCZW5vblp3QnJWWnBrU1Awa3hLOXltNXpWWGs2cG5UeXVPRnlxLzZQ?=
 =?utf-8?B?eVorUWJPbUZ2NVB0T1pJKzhLSnhnd210WERVeWtCZlp6WTI4K0JsQkFMSlVO?=
 =?utf-8?B?R29Ta0dYMEJEc09zaXZMWTBKL0tpelZGUThWODkvTEpJK201dXZORDV1eTJN?=
 =?utf-8?B?Qi9KYTYxdDYxZGhiS1ZydVVzbW85Y1pNL0VpTXc2eVpYUFEvTlRldVN5NFZK?=
 =?utf-8?B?S0huaGtLYXU5d25YdUdpYzBCNGR2OWhFQlY2ckxFM2Q5RStMU2hsU2dmNFk2?=
 =?utf-8?B?czhIeVo2bnhwMWIzQXhDTlkrUE0ybHZzb01MWGNHYWhWMnFCSjZBbFRwUHRF?=
 =?utf-8?B?MmcyNWsrTVNuS3RnYTZxeVoyak9EbDJ2Umx2TEFBRzk3a1A1M1I4dTFsdnkz?=
 =?utf-8?B?UXU2UlhVN3NNM2ZuamZsQVVsMnZKYWUwdTFlZmR6S3B0U0xRMzY2MW5La1NR?=
 =?utf-8?B?Q2NVMmtpNnlyaDhSOWFqU0orcTRXUGxFN0FmbHg0ZHhuUi9JU0Rsc05saU5Z?=
 =?utf-8?B?SkdQaW9WT21NOGx1cnFnUHNYY1lnWTZ6M1lFbC9FQWhmcE5zWHN5V3Fqb3Fw?=
 =?utf-8?B?UTVoczR6a21nNkJOZmh6RE9kWjJKZXByL3VlVkhsekxHVlV2dTJnR0RiTi9X?=
 =?utf-8?B?VWFYMWpqaklaWkk1QnQxdTdmVG4xZXZwamdVQkpPT2graXNBN0FwWDNKaUZI?=
 =?utf-8?B?Y05LNWw5STQ1MU9hK1Bvd0s1ZUxpbkYyZDVqWDJwT2d2ZXlydHdyV0JWVVlz?=
 =?utf-8?B?c1hacGxkd1pnOExMWnJXbW1hTTVHVGFVa0ZHK1ZQRVlrdEYzRE8xU3hWTkd0?=
 =?utf-8?B?eWNkRVB6REpZVjh2STd0bDlBcXQvdFNPR0VObCtmazZXNXJyOXBWS1JzTEVV?=
 =?utf-8?B?dXRUZnJNcS96UTVnUkJKY1d3NlBPL1BUZEJSZEFiR05xRDhmQkZyeHVEdWk1?=
 =?utf-8?B?Y25PeW45OXZuS2NsTEtJM0NwQnFaRXo4T1ZoY242WTl3eVFPMmhKVW5aVlNI?=
 =?utf-8?B?VWpWWDUwVEJHU0xISG5YV3lHZGVXUHB0Qlk4OXhYT3lZeUFsSW9yWjFHSGJ3?=
 =?utf-8?B?WWJVQ29CSVl5M3RzVmRuemxOTUtsR3VOQUdob2hEeFFKQnlOYmFOcjMwb3hD?=
 =?utf-8?B?VlE9PQ==?=
Content-ID: <5111D0CD6DE032419AB5456E6E3223A4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab84952-b845-49fa-0c9c-08da76d37ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 11:13:16.4511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElHVJP9A9hDJZwzSUx8P54F8v65xtB28/YMmUQU92XhissNyMb/GRUbrVUMzD6Bi4leSiw7xNn0hxqOFzIQl5fsgh9yMJGh+YoRmWowarDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2541
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/creat09: Add umask test condition
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
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "martin.doucha@suse.com" <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin

Thanks for your review.

I have a holiday  next week, so will send v2 when I come back.

Best Regards
Yang Xu

> Hi,
> 
> On 03. 08. 22 5:24, Yang Xu wrote:
>> A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
>> this case has been merged into linux-next branch[1].
>>
>> I will add acl and umask test[2] in xfstests because there is more suitable
>> to do this.
>>
>> Here I just only add umask test condition simply.
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220802&id=1639a49ccdce
>> [2]https://patchwork.kernel.org/project/fstests/list/?series=662984
>>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>> v1-v2:
>> 1.update linux-next and xfstests url
>> 2.use Ternary Operator instead of switch or if
>>   testcases/kernel/syscalls/creat/creat09.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
>> index bed7bddb0..7077cbcff 100644
>> --- a/testcases/kernel/syscalls/creat/creat09.c
>> +++ b/testcases/kernel/syscalls/creat/creat09.c
>> @@ -28,6 +28,16 @@
>>    *  Date:   Fri Jan 22 16:48:18 2021 -0800
>>    *
>>    *  xfs: fix up non-directory creation in SGID directories
>> + *
>> + * When use acl or umask, it still has bug.
>> + *
>> + * Fixed in:
>> + *
>> + *  commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
>> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + *  Date:   Thu July 14 14:11:27 2022 +0800
>> + *
>> + *  fs: move S_ISGID stripping into the vfs_*() helpers
>>    */
>>   
>>   #include <stdlib.h>
>> @@ -94,8 +104,11 @@ static void file_test(const char *name)
>>   		tst_res(TPASS, "%s: Setgid bit not set", name);
>>   }
>>   
>> -static void run(void)
>> +static void run(unsigned int n)
>>   {
>> +	umask(n ? S_IXGRP : 0);
>> +	tst_res(TINFO, "under umask(%s) situation", n ? "S_IXGRP" : "0");
> 
> It'd be much cleaner to use an array of testcase structures and then call:
> tst_res(TINFO, testcase_list[n].name);
> umask(testcase_list[n].mask);
> 
> ...
> 
> .tcnt = ARRAY_SIZE(testcase_list),
> 
> See also creat04 for example.
> 
>> +
>>   	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
>>   	SAFE_CLOSE(fd);
>>   	file_test(CREAT_FILE);
>> @@ -115,13 +128,14 @@ static void cleanup(void)
>>   }
>>   
>>   static struct tst_test test = {
>> -	.test_all = run,
>> +	.test = run,
>>   	.setup = setup,
>>   	.cleanup = cleanup,
>>   	.needs_root = 1,
>>   	.all_filesystems = 1,
>>   	.mount_device = 1,
>>   	.mntpoint = MNTPOINT,
>> +	.tcnt = 2,
>>   	.skip_filesystems = (const char*[]) {
>>   		"exfat",
>>   		"ntfs",
>> @@ -132,6 +146,7 @@ static struct tst_test test = {
>>   		{"linux-git", "0fa3ecd87848"},
>>   		{"CVE", "2018-13405"},
>>   		{"linux-git", "01ea173e103e"},
>> +		{"linux-git", "1639a49ccdce"},
>>   		{}
>>   	},
>>   };
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
