Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A42ECAAA2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 02:05:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA02E3CA496
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 04:05:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 216D13C0D04
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 04:04:58 +0200 (CEST)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CF9A110005DA
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 04:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1661479498; x=1693015498;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RN1C3Buy3qBCB9oqwCfYgARdNrvHq8pS+22e2a49fDg=;
 b=fhPB5yX+3fGeNEVN/HXNV0226tfmnc3PiHBVLaRxifoRVeQWnp+D4oVm
 M/pmdLfY9HErKRqLToFeCdtlfIRFIw7Y9H/QZFccnFPNB7liny1hq1mzx
 eUyL6OIsfcnj3QoH36wGdhZ755hj6Nzau25uBbsT47aTYuJgK0B0d4XSR
 D8MbQuG1fiKHatJb7iir/hhAlrh5pxwGWHgjsmKrvbLE7S4bAS6T69ogb
 ekY6qgAnZZE95sUwWAtRtQNqftrnjze6gCKu+L+ex6zZEHRL2K6psqPj0
 eMV8RD2hs0DsLokvS2HQL5taee6gILpVIJvpFWG5Jxn1F2hptcu8jz8Kt w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="63555632"
X-IronPort-AV: E=Sophos;i="5.93,264,1654527600"; d="scan'208";a="63555632"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2022 11:04:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdFTVAUlzOjsyFDtqs9/ZlkrQaDQxljfc4dYwZubGSBnB1ha2fjBSu+aRDep4hjz+ivgT/uWiWO923bANtkuzrLnGTFc2dZQWfOoXsCD9r4df6RUkOEDWx2d/q4SHNMa3O4VJWl+HjBCoPjMUCK43zXq8CDof4yFa74qkwMkMp0IZSUq7iljkstV0MCQw8GfA6GjB8svNO3J6/pNzGIQb7lMOU4S5GhAjQ4lEA0tLSgeCFJy5igLKEyM+mwWtrQaiAKDlk+QDcPW/9bZCRBBLl6mlyJNEpvfe5NbKTBL83jl09yMUwWlsU/pQKq9anu+uYjGNoA0mJmlh/e8nmPGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN1C3Buy3qBCB9oqwCfYgARdNrvHq8pS+22e2a49fDg=;
 b=W2Xnlfx+n6/4Og14tm74Oum9HVDAXMm4Gik9VHgAoReDdiJauogXlyQh+Ko60zoCDXJ3/tcwlLSjqV4Zr2zZ+yYf42O+FZK/V3Yf9OKfDXzGNN0nz2xZPh+Hp++Q6CswCs4lxSxJxu9YvJnG7CY8Wb/J05NQjw7U4iGMOCNlovmrC45INP2r03q4C4l3nHDuShfBP7ueqEdud74QTAcUc43y4fBnw+eGMJJiWEkauRVRQ3XIAZ9dcr3MMOfLX1lwmnPUo0yows6p61NWjJHEn5khLnCh3p5bF/K+PbDbNBFykMPdyraxAwL+XHgDFK2gXWjJD1JRnyL5NX0GrmwHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB6008.jpnprd01.prod.outlook.com (2603:1096:604:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 02:04:52 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5546.022; Fri, 26 Aug 2022
 02:04:51 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v3 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
Thread-Index: AQHYttc+107vktIqckqWDG9rHQJBh62/uEQAgAAT/oCAALd8AA==
Date: Fri, 26 Aug 2022 02:04:51 +0000
Message-ID: <5a9b0515-14cc-1243-4dd1-f98eb0f22831@fujitsu.com>
References: <1660813232-2378-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661252479-2363-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661252479-2363-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <875yig2wuo.fsf@suse.de> <871qt42tev.fsf@suse.de>
In-Reply-To: <871qt42tev.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a05dadf-feed-4dc0-c13f-08da87075cdc
x-ms-traffictypediagnostic: OS3PR01MB6008:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fm2ONRYG5jY+bHVpY9tmPDvCdI5JcXlEA1FrMIAHpWjuNdKO1D7ib/ptiCrAg7NsMFkYFZjA3vFmdPmnEdNCPp4gpsaKFghBBv4WFT+4mi4x63jBc5Kzqc6udDihsgUJcEFwXnxtZuum7u7bV2le+diJVaGTRMHvUnODOPBRsKOgXuGREKIJDFd+HbwjA56SoUYBHtrbw3/rbNlsNlT4Zo/drvHRIlB6gwc+gn5QfSGM0Dlk7NYhoe8LbPA0m0Pzq/khGicXleR4dV3jzTd6AJehYWhjAGKZRIsmF5fOnro+KI/ceFqa+3WmW6YF8q6NF7a5yI/mRb+dlESJl2Zm5eqPsl+jyk9XJNun1cJQhzzNTrPDMNGKXWWmxj5J4lzpj3DsLW0vEPDcVODlhMbf8+dvNdoBu+XRLTN12c77CO4orsiYbF1+zG5Td7/EWM+YBW+WgydaVAwdhskuLYXQvkD91CTnUVCXhBhEwOrxUiRVdTfAlDrW5EcW2/EzQ3YoQblbYd3KdOCsM5ufdp4070YUy7a+VXtHZ3qKSaf/ThJvlhNZHWTiuMI1WM4or6ZQ4pKm1uT+q3ivKbt42tQe3QnFQnqOBBYJuT+X9vTmxlntZ464hM9fcr2tzBw+G/qOpEo5SFcA9XFDto+xkk+F2eGyin782ak6yP0hAx8QYzCIkjuONwpqLqPEqgDcGOGYugTLzTRVCVWcZkeQppFZnfRd9NrT9zGVrhG6VnvVY3x19zQr4jr7Bf6b8uKR2lXc0wkJAYOxJ1Q1H3vHjI0GF/mEhsYzhRk2jrkuB6jgOYAXmbsFHIPY2HEsWShhrwJf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(1590799006)(31696002)(1580799003)(6506007)(26005)(6512007)(2616005)(186003)(5660300002)(8936002)(36756003)(85182001)(86362001)(71200400001)(31686004)(478600001)(6486002)(41300700001)(38100700002)(122000001)(82960400001)(83380400001)(38070700005)(4326008)(8676002)(64756008)(66446008)(2906002)(66946007)(316002)(66556008)(66476007)(6916009)(76116006)(91956017)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M21HU0RtQmVXcHZ6WTZaN0FDNlFpam91cmppNmkxdFJRK08vVDZFRHp3UFAw?=
 =?utf-8?B?RUJQeldqcUdGQ1VXb1JxMjZnYWNHKzVxWU1VUzQ2b2Q0V2hJRm9pN0g2VjI0?=
 =?utf-8?B?VjJTcVdzcVRJNkpHd3loNDk4VEpVM1psaDVwSGJvVVNRd1hxeTZkQU9JWUFD?=
 =?utf-8?B?djQzcDFvWGNyTlR4ZWhKSUJnWVAvQ0J4b1pkZ2VQbU9yT3VsSjFYNzk3N2Zu?=
 =?utf-8?B?M1RLYmVuY3dlYXA5RmNkTERIbWtPN0hOWW93SmViaXA1eTE1eFFmeUtlRjQv?=
 =?utf-8?B?cC83TU02ZXo0c2RvQitoaEhqMXErOWpiNFppRExsVkEzMnQwdWJQb0k5TEY5?=
 =?utf-8?B?TEdJNlZmUnBYQUZaMERTRGFrSGs1cjFJQmNJMlBRb2tDdHJodmw1aGVzdURI?=
 =?utf-8?B?NG9KLzcySUF4d09SQkJFeVFCZDJUVEpoVU9DZGJpdko4NFgrdHFlcFFJSkJH?=
 =?utf-8?B?M3JTU0s3SlJRYngzN2lya2ZSSHRnMlpUTjFDTTRpSkM2ZzdGQ0x2K1I1OGZr?=
 =?utf-8?B?MWNzSElOM2szbDgrQ3ptM21VVjZVdGtBSk1oMVMwcUVCVm1CUG5md1JzNHFQ?=
 =?utf-8?B?MnZGUUF3a3JzOUUwaUVBYmdLbCtWUktNdkFBc0tjUExQbUMvSTFsREZtbkRJ?=
 =?utf-8?B?VkNZV1RHRWlORTVnUEpDcVVwYmdydGJpejNGYU9DZEp5ZXcwdk94SGM4LzZh?=
 =?utf-8?B?SWV4QVFpaDlHMXM0WlR1MUNGaDRaMi92QjZ0ZzRObG5URkRqc3lPVlVLQjFZ?=
 =?utf-8?B?MnhIemM0NXF1TTJDbXMyQ2FXYmp5MDMxUmFscEQ0emlIdHRGd21adlVxYVRQ?=
 =?utf-8?B?TkFDQ2hWTjVvVGZ2Wk5zNG5LZERtbmpQV0daL3NWNHVOdnRzVVhsdmJrYkFu?=
 =?utf-8?B?UmIrcTNreGRrU2lUVGc2d0sxaFh3Y1NsUWpGbnFOY0lVbFVBY3l1Y3dMTlRT?=
 =?utf-8?B?aXp1RUdkRy9ORzFnNmpLdHR3V2VjbHIwS0h3NXFubzBnZDhMVFlaaXlWMUg2?=
 =?utf-8?B?aDdtWng4dTZXaXEzRktLR1NSSEg5QlpQb0FGanY5bnZxcTZTWHkyaE1GRkVu?=
 =?utf-8?B?ZExNYnM1NnpENHRqVE5QWXJ1UWd3dFlaaG5ZVlgra3QzS3lObEdMNm4xQmpw?=
 =?utf-8?B?TFV6UjFFUXBBTzB5QnhMM1pSWjVYbnJuZkFXZUJldE1NVVJZZWlXU3U0NC9v?=
 =?utf-8?B?bFZiVCttMnNiZG96NFNOZEFBbE1tZXVGK2pndnRqeUpWL2xoVUxNN2x0OFE4?=
 =?utf-8?B?a0FIS1lyeEhuVCtLZW5xbEJ2dW94bFR6WlV6NkpRMTYwVkF1YmJGMG1DZUJM?=
 =?utf-8?B?djEvMjRUTlZtOVBzN0RJWXN1RUkwd2JDRnYydXlVeFlnQ2RlS0VVTmZSb0Nx?=
 =?utf-8?B?UlAxdVBNMXBjSzk5dUxtNk1HcUJIN2N0OFlrNnhGYUloMXBteVZvUU1QdHZN?=
 =?utf-8?B?Q0dRTkoycXczZzU0M1N6M1RjVEc2c3psUUU5dEpTZzdFTVRja2lub3RKTEI2?=
 =?utf-8?B?Q2tOVzBVYkxsWXRXZ0FaamJQWGd6UzlMNms3UitUbXdzVVdSVUZYZUNnWWw5?=
 =?utf-8?B?UENIMFIvRkVlbjd5M3F5SStxMWdWdkVuUjg1VW1KNnRPalU1TmJMbnRiK2JY?=
 =?utf-8?B?b3MrQUFSWXNQUGI1ZVA4dWVnN3dzVkdUWnFiTk1CQ0w1cmJOYXZ4emVHQ1RF?=
 =?utf-8?B?ZGxvdW1iNmRSYVlMV3pFUmRVQVZwVHlvTG5BVjl6VmRLS2ttS3F5UmpIcnBF?=
 =?utf-8?B?bzhXNVU4bWJWREpyOEFDdFU2R1hBaExSS3lzQlFlb3FmQk12dk9GN1pnSXRE?=
 =?utf-8?B?MWtoMkZ5dlFrNXlDU0FTVU1FaHNxVTFicE5hN2hHWW9nZjg2Ymk1eE9IcFhk?=
 =?utf-8?B?REhmZUJKb1A3TDdVWHIwbU5lUGdCenREV1dRSXp1WXhMeEJIZ0dvejEvMTdK?=
 =?utf-8?B?elljMHJMRkJpTEZxOFl3QXZzQnVqcys1V0lkUG5ocUxHaGxjcGtrMmZzc1hx?=
 =?utf-8?B?NkUvZDRydDM1cDRsc0xmRFBFWm1MRnVwZEtFUmFSWjdRK2pvS1pvdTQ4T09m?=
 =?utf-8?B?Nk90REtCUlhWQ0tjbU82NDNGcFhicVVFK0hNM1dic3Bld2c5VGhOZlpXbHJP?=
 =?utf-8?B?UXNiZE1RcEZPYnZQVVZuS0V2RlB2YVJoeFRsS1RQL0VqTXdmZGVXd2E1dzZn?=
 =?utf-8?B?L1E9PQ==?=
Content-ID: <324B18CF649DC34F8EFEFF6F383512BC@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a05dadf-feed-4dc0-c13f-08da87075cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 02:04:51.8682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rU16ED5rasy0K1VRHdPWwq+RZKu3rs10SasfbNM0Qx1S/o0yEZypEd0byk8xYB8lnRYX0zo00e53YYe0cJf4pwv8aHlPAJRdG9PrVQ0PrcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6008
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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

Hi Richard

> 
> Richard Palethorpe <rpalethorpe@suse.de> writes:
> 
>> Hello,
>>
>> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>>
>>> safe_cg_open is used to open the sub control's file ie cgroup.procs
>>> and returns the opened fd number. The opened fd array is stored in
>>> fds argument.
>>>
>>> safe_cg_fchown is used to use fchownat to change file's uid and gid.
>>>
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>>   include/tst_cgroup.h | 44 +++++++++++++++++++++++++++++
>>>   lib/tst_cgroup.c     | 66 +++++++++++++++++++++++++++-----------------
>>>   2 files changed, 85 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
>>> index d06847cc6..70c5b3fd4 100644
>>> --- a/include/tst_cgroup.h
>>> +++ b/include/tst_cgroup.h
>>> @@ -89,6 +89,32 @@ enum tst_cg_ver {
>>>   	TST_CG_V2 = 2,
>>>   };
>>>   
>>> +/* Controller sub-systems */
>>> +enum cgroup_ctrl_indx {
>>> +	CTRL_MEMORY = 1,
>>> +	CTRL_CPU,
>>> +	CTRL_CPUSET,
>>> +	CTRL_IO,
>>> +	CTRL_PIDS,
>>> +	CTRL_HUGETLB,
>>> +	CTRL_CPUACCT,
>>> +	CTRL_DEVICES,
>>> +	CTRL_FREEZER,
>>> +	CTRL_NETCLS,
>>> +	CTRL_NETPRIO,
>>> +	CTRL_BLKIO,
>>> +	CTRL_MISC,
>>> +	CTRL_PERFEVENT,
>>> +	CTRL_DEBUG
>>> +};
>>> +
>>> +#define CTRLS_MAX CTRL_DEBUG
>>> +
>>> +/* At most we can have one cgroup V1 tree for each controller and one
>>> + * (empty) v2 tree.
>>> + */
>>> +#define ROOTS_MAX (CTRLS_MAX + 1)
>>
>> These need TST_CG_ prepending to them to stop name collisions.
> 
> Actually, I think the easiest thing to do is not export these. Instead
> you could leave these alone and export "#define TST_CG_ROOTS_MAX 32".

Yes, I forgot ltp name rules when export it.

Will use  TST_CG_ROOTS_MAX in v4  and add your reviewed-by.


Best Regards
Yang Xu
> 
> The rest of the patch-set looks great.
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
