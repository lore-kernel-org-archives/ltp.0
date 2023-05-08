Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84B4C77B7F
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 08:30:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC6663CB56A
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 10:30:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A10823C0238
 for <ltp@lists.linux.it>; Mon,  8 May 2023 10:30:13 +0200 (CEST)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 86C696005C1
 for <ltp@lists.linux.it>; Mon,  8 May 2023 10:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1683534612; x=1715070612;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s2f7fwnJ+TtsjeXDuGOG7y5Nbry0Hpm4+fCRKI8OQyU=;
 b=Csdg+FUt/NHq1BQw5wKfTkBQFSrtz6juR2HcVB8lDWe5Awlm6FeoRp8D
 CyNWEdGK8hLdOFgv2Ka4/Xot1MttMVsqpA8ElfUO8NHpNUfB+Uk1M/fQZ
 4a7506PQgTnL/4+nHY4q2nd/tA3C61pT86n1Mpcx+W5bY+/Mz4DnMyfAu
 CD9r3bBr9C69W2sbTMKoKPs8ruTzQq7s5ypjamxMcpWjpA3Di+oZV7uc6
 rmwRvwF2wbBDQK/CxbggfK42TPaht6vFJ8A6h7NCmS+h7D03gQiE2Ffaf
 ybAwHDBfdgTQ3w9mAYCUmJKc8uqpSTMszImz1DV1sK1KU9axTdOdI5fMH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="91968701"
X-IronPort-AV: E=Sophos;i="5.99,258,1677510000"; d="scan'208";a="91968701"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 17:30:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNYbWOYyI1xZAjS+8SOBbKXJ4OJ2skroqs/RWaVEzmoNfI/u4bToSH2Jc3Z0rEmwI9cwEiDWigB6k3iNytxNOqjyX2MPseNATGLHD4mhpLexLAfylQLrTFlb1SlTDjeTYrOV+HMXebXax4wxhyx6V4aGMOCXBtP/aGHwvte8l/CnJVtvwCSDmVgpVkTGYh34WmaPqvR9oE4UmlDbs3hYPUBxmaRn5Ec7eO8fBdG6oP3cDrQjwHFcMkUScynooV3Sptc4857QkqSPbBnL1odOM5SafeJuu8wSw5+6t6eHF9fo7jVuYqNROb/xupSICjK3xn+qbQW0kz+ZDLzh80EPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2f7fwnJ+TtsjeXDuGOG7y5Nbry0Hpm4+fCRKI8OQyU=;
 b=eVthkZnr3FFBIth5UCxUXgKFfNgFMzy+v5LSJqRcElMprgYwUiR+uzOa94R6OF469QF4RJJnEGZovJmn+BQuDm83imZzxfz8yRA3sSFAfgwLnMi8ORdWSwVyR5rV1vm5UQGWg+fhuwPQxMsT0fvQLAkOKdpyVQxPUNhOBdNINoI+x/KDclUFzy3DKw1DAIp7crjhEihGz77pjGI88sLv4DxMq4FL5wLxv6w/80bD1NCM/QlSEt/R3t11LdUqgn5QimCB2g2trtF3bqAGs187a4B9qKhK+PeMsmb/upA4SgKpIxzdV9Y+MeSeBs7WbDrxwW0e6P/VmVHLrcc36TZABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TY3PR01MB10906.jpnprd01.prod.outlook.com (2603:1096:400:3af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:30:04 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 08:30:04 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [LTP] [PATCH v4 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
Thread-Index: AQHZaEpelwVUoZfRMk6Q/iAgJbfD1K8+Rj0AgABS04CABz+TAIAKY/oAgAABYIA=
Date: Mon, 8 May 2023 08:30:04 +0000
Message-ID: <74e71028-7c61-17e5-391d-65406d25b532@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426220654.GD58528@sol.localdomain>
 <b1f3f7ee-6f90-172c-520a-fd6ddc23363f@fujitsu.com>
 <20230501174442.GA1224@sol.localdomain>
 <9b44e391-6c5d-2671-1adc-69efd6577160@fujitsu.com>
In-Reply-To: <9b44e391-6c5d-2671-1adc-69efd6577160@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TY3PR01MB10906:EE_
x-ms-office365-filtering-correlation-id: 69032f69-4715-4704-f611-08db4f9e6c3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pXJfs5Yq/rKeRrflZHD3qOaBxXK69El2a6Yi3a505PJ50b76T0h/g0cvhAy5Z0Ap+CEQrBn/tQ4ug2O2s9Qq3jXsGGuqtvVir7MSgg5xVEs7n6aAfjs+FVGlYllrYL3JqTxOKXUoI5f5kxR/aFIarcreP9FDs7yKECee0PcDlnAv0rqRyWy3RSJnqCUcysrV9Ozv+9lHc8D5odQzKLB05qvxoQnGS/+fTfXloXBMkuK6BNW7crRSghOuOAr2dk3nb2wU0liPCw1rDYdi0PJkadIa0Jw3Rd8LZWSnSWbJB5/5WtAkg561eJv7PaRh2b+5z3BzgGr6BF7KS70IYiLzSixQwkErYOV3k3Hta5QK3hIUClSAg84t18/OOV65EwBw91eYkGK+Kzy+l1xg0WsnX2aEd3mDLeVx8WjCPJ6qg/muGPikR4YuWcVxZX+yya+vedJYtrTp4KnFtQiCp1T67LZczyP7L/0zWQkR19fnfL1dR1GoWVqpzSQIE79ENyNgAcKRjSRRrnWiG/hHRELLWnaoEZ2/F5l6VdIbGfWlzVFrRl8MwNpYmVA5Rl5t9AzG5zy2FebpDoiaV/gD1m0MMPtcUJAcRS7k7Go/k1J9IeqjiZobIFZmKE9gLia7I50L99tzm67Gproh0PXAvFbDKq/nPyTTHFwDlwWcN8NHO17lKK8VKWxoudQMx9ave2t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(1590799018)(451199021)(91956017)(31686004)(76116006)(64756008)(5660300002)(6916009)(4326008)(66446008)(478600001)(66556008)(8676002)(8936002)(66476007)(66946007)(2906002)(71200400001)(316002)(41300700001)(1580799015)(6486002)(6506007)(26005)(6512007)(186003)(82960400001)(2616005)(36756003)(85182001)(38070700005)(558084003)(38100700002)(31696002)(86362001)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U21kV2ZXOWJ1RUFMRFVCa01YdUM0MlNhcy9JU2VuNnhrT2M5eXVCdlkwOXRu?=
 =?utf-8?B?Y1dCeGNtdHVJd2Q0Ky82VUVLMzdDL0ErN0VicnFjdTk2T2xEV05FWURUWC9r?=
 =?utf-8?B?ZXJwSjVSQUs1YjZSUmpwNWdkR21mUGN6bCtXQWdOZ3p5R3ZJeEJNbXpheHN4?=
 =?utf-8?B?RXhUTTNYY1hEU3E2dno4UVFlMVN1NDlpZEZDdHRxNkVsblNqSGpEQkcyMUxH?=
 =?utf-8?B?UHlYMzBHSmJIRWh1Y3ErVGlwaDZtYk1rZXBtQ3M0ZWFhaFNZeDZlaDJXN0Fy?=
 =?utf-8?B?STltOS9Rdy92bTRTanRhZmdmNUFXeVd2QmNiZWVlUTRSVlIwUXlmTUhabmFF?=
 =?utf-8?B?M1BxaFpsanltZ0VhTkhjWkhVNG1ZaERhSEp1MGdpYXJrazA4SC8vR01kOER5?=
 =?utf-8?B?c3BaTXJhbE84VDc5VEhwYWdtQ1M1UTZibzUxVXRGMUpNZHR6aElFNjZmWkpX?=
 =?utf-8?B?NlZSclBpYzhJUy9yN0xldWFjQlc0MEdBeUVBaVU4NVlvOStmTXVpSHV2eEJq?=
 =?utf-8?B?V3VPTWI0QzdoQ3gvT0pibitCM0xRUFJwUFpwR0I1aXFrS0RqNWgzT0xJZmN4?=
 =?utf-8?B?VElySzNSa0FyNDRyR3Mxa2ZidHowSnpQM21HMVd4ekRuNG13aVMvMmg1Y0ZG?=
 =?utf-8?B?NzlURVJnM3dMcXdnSDFZMzlIOFU2NitYeWY1bjAvQndjMEQ2eEJYdzFXa1Jx?=
 =?utf-8?B?RVhvVVhBeGx0blNiTjlxQ21iRWJDZzFGdVdQWjNJV2xxTktWUE80aHdqSk1X?=
 =?utf-8?B?RmNGaFFxc1pXZHFFOGUzNGZjME9aZlBDQzV5RUxudnQyRmIzbE40aEE4TTZZ?=
 =?utf-8?B?Z2oyUUtjWGJXZWUrNjdsM1YzTExGeHUxK1dJZGZVS3F3SnU1dk0zT0M0ZGNo?=
 =?utf-8?B?b0g5bkt4K2J1VndiNVhTZklYemZsUGVvTFQvNHlHWVdGS0lDTGhlTjJEMkhx?=
 =?utf-8?B?SW5UeXltVHlVZm9QNG1FTDY2ZDd4aTBYbG1OVGdVeW0zNlozcWNENm1JSThm?=
 =?utf-8?B?M2FadHBzeWZzTGZRU1g0a3pMUHZsZERCTW5uYmhBb2lHRzBPOUVldHhOd0pB?=
 =?utf-8?B?YTZ3VnlJcE1BaVNydjVCRDN0bEhsMmRLcGZzc3J0K2RpSnF1OGp6Y3JST1Jj?=
 =?utf-8?B?dk84Z05TZGs4WUp6UTkzQXVna2ZNM29pNHFVWThpem50ZWlVeTYxWEpIUGFD?=
 =?utf-8?B?NllablpSQnYyZXYzekdkQThKc0hwSFpuNHRlckZjVjNsSGVKcDJtRXg4VGor?=
 =?utf-8?B?ajFqNVBEc0FhVmJTbVU0NWpsZ3RqSEZIZ0ZDOWlmUmt5a1hncGxCV0VDR0tV?=
 =?utf-8?B?ZTQzUWM1T0tVYVZieU9BYlA4RmVnd1l2aFpBVW9tQldkaWFtQ2U4M0ZrZS9B?=
 =?utf-8?B?TDlJL2h3SWhqcjIxdDZ5MnNsMmdDZ2RCV2F4V2dyUkZYNjE5Y2NneUMrMjZl?=
 =?utf-8?B?eitRcE4vVW84KzRKWkp6aXRPYURFQmp5QktzNURMQWdCUWhybk9weTNOcVJG?=
 =?utf-8?B?M3ZYT0Q5d0VkdWg1WURpd1NINk1lWVVBTFBOY0o2cExmZkFkWW90eDhQWkRW?=
 =?utf-8?B?ZWxpNkVQVlQ5b3oxTjFwRmE1NFZKZHpNOGJMTGtJcng4Z2wxUG1NMFlvWkFa?=
 =?utf-8?B?RTYvekFMb2llOWhHYUlDR3NYNWorWUU3Zm9oSUNrUXN1MFVvNUp0RUs2UUM1?=
 =?utf-8?B?c0ZUUVdLSndadDY5WDJGL2F2dmVybHdyWU5yZDlObVRXT3IxUTk1NkMwVDFu?=
 =?utf-8?B?dGNrYVFBREowWDFWYkhDbXZaS2pjRk56cHZCSHh3YmRWaWgycHJMazBMMTYx?=
 =?utf-8?B?KzRjZlBVc29lWC9yTW5jbjBmMzB5ZHR5eGxEN2c0S0YwS0dWYlVPK0kxNzEv?=
 =?utf-8?B?a1M0c0VHTys5QmhVaXlKQndjbEZMT3Mwa3Z2Qk5DbjJhZXZsZjlETUl6SHM5?=
 =?utf-8?B?QTVlT0VuSU1uS1FTSkI0dFZZU0xTMy9kV3ZpcmxDOU9FWm9hMnhZR2Y4TXE5?=
 =?utf-8?B?aDRUa0s5T3BuQ2UwSTlkbTU4SE10T21MZXN1K0JvUGpJbG9XWm41OVJrc0lt?=
 =?utf-8?B?Y0xxQUxXUXNwUzlmRG9NRlRLZHVRL3J0U210Sk1hY1dIb0VNMGJqVWExdERq?=
 =?utf-8?B?WWc1Y2dEa3JzOXF6eDQ2NGo0cWU0cDlTVys3WXRrMGFwOGV2SDc4L0R6WTJa?=
 =?utf-8?B?d1E9PQ==?=
Content-ID: <F3D16A002728364F978A76EA5A5B1215@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R4TiEpGDSELDT3PKxjWshaKFsIbkmO2f+XtTlX08O7JvuKnn+MdV0sF8y0b2SV0H+7l2jcQKErDjv2ZUIr6r/xXKXzvyOuBHUFK2xYpSHn+wUBtjwqcI3qA52r/VR4m42j4681a/YjTf44P3JxyQrhG3ANsnAWrzWLzSU7QK48i7xgivvTcwXf6S3QCOEQd4/6LDjij0MHIGI9Gzq4Y8lhmmc/loV4EPFC1xk55vw975PRuQok48WIa2w539IHQePY/CEFbO8wjhze9BnTUTmLU3Bq08P5wxQv6MPQj3Uykeiyp37n1xJIzsGTY6yvlf0tj7n6GHHAD6NY7zK+zJqpjSIWj5OVZyCX54gT2Qm/yqQqy4BMtiz/qJWFni0NaiB2lv5aY6XSfsFcDl4ieBXXRjuZrDAh9U2JQzi7Rav51U5tpqQdSh0IYx8c3SWDLp6qB0LeWRTrqLSXXgzb778en1wGwMnIV54osj+tp7gUgXo5I+XzW2UzKZPT82ngwcxsHT/x9praNaMb9VMzjx9OsB7khlvEmC1QkaotbDr6NChspUDNS+sOq/HyJOQGBJwcwXd3KjDs+APOuiTgUuzwId8fkE8CW07Q26CymS6cgKHSlZftMdu+AoKZT5LFRLQSpwbNUZz3TIqtZjB6kZ3WrZDgECYgHmTR3VB7Ml5aqrtqxtaaAGVk7vBd34PVmQ9BxvBi9XqNAw1zUHiY3iMeZUL9BzlhhPdvezw14urzWZKxRbI36ZH4uQv6hzKr3898LLd2m2wpY8BErLfYrE/27nsvv9tbX+iIE8OAZKfW4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69032f69-4715-4704-f611-08db4f9e6c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 08:30:04.2259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L74GrXSoN3qwB8RdQjhyu79jIONf0FE3kmYxKw5rA7PScBuWr9IhaoT3PEniZhru+P84IXL4sd0uzgrX3Oq+cqCxcrzM6DPzjtYRpCMffzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10906
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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



on 2023/05/08 16:25, Yang Xu (Fujitsu) wrote:
> IMO, to change ltp owner header to avoid use <sys/mount.h> seems
> difficulty.

<sys/mount.h> => <sys/stat.h>

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
