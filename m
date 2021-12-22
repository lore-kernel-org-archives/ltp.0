Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947A1C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 06:05:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5A143C9274
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 07:05:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418453C0B99
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 07:05:24 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 77127601D66
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 07:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640153123; x=1671689123;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7CTomEGEUwL8xhsKgiO59rFapSFcFYxOdFOQTdvSnqk=;
 b=kxzjL4DINMvwvjRli8MWmANy3oE66AtYJA0VRbqIfPjSZRhPVL32eafV
 s/AOpyf/ClYd8KWqQIaEgHiC76vBPYkAAu+G89+yKIDPgvVN+FwewEN8U
 5BgmJ6EtR0PYl/dHNReSMKE8v5U7Ye9oWHOPEyF688D+xAgIowporc/mK
 quF2EfSj0WFwp9gn8bqykqjYzZ+Z6jCcVKDahSfISjHSxQvey8u4wQhQG
 l7HqodrWZYf1LToyKPiHgR/NXF5Jomixw6KX7SWQ/VDrpGxDW3PkOpgOz
 fK3zWFqoaikm19GOKFuf9+o6kfjVtHTHn+bjUfd8J+01wiQlQCG/zHK2U g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="46200236"
X-IronPort-AV: E=Sophos;i="5.88,225,1635174000"; d="scan'208";a="46200236"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 15:05:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCF6F85Bu/dq4iMg9FCg5Cs55y+dstQ61gDz4GwVOIosq9mMx0+dvxNftIRzTcqHh6s2kpCENUjJBU8W7AtlGm4ZUp/x5LOSUUnCUxFNNXkNhwg5VuGQU0uT11OJU6Yt4Ji7FzYgwW6d9YKJJwbiG31cAXRDJwcjfip6u2C39OLI27+iNAD8Ol3RoYgWwicjPZZLJxL7CNKn/J7gzhf5aanOUEDhy7JbjSri4iVo0qKuWoclctIo4zyTVYyEzi52VdIF9yeBdagc7eZ5Isnc3u6WZz6nlg2OpZCMWe2HXaUSbs7EPgq/Mi4n6uDtzQbXMvzOcLavT8FeHFO/PFft5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CTomEGEUwL8xhsKgiO59rFapSFcFYxOdFOQTdvSnqk=;
 b=arek1nb+1YZRBMEEb5flViO0TTfcHWgGX/K2C+pprYy1i6Mr40tRR9hlJDHU3YEJaZYtPTlEhOYgQfwR3S1HZIdNY5Ta2f06yg43e0TpgvmGFIapP+KjRNrWNX3R5ryYPjWbRSx/clx4OPbgrUE/J9TwFO4hxGeFVqPN6FuAFrumWcdJ23sKAwIAL2FB4zNuuNbjFBb+odnrxSwz6sfD8viTbCfRCLlYb3sckJtEwZ4bNazTGsyahRgU04dOps2FxaFq/ezZlWwZGbOnXkNAgYsPYl4xzoKLoeoi/yahFZ0QfMtAorcza5ht7+ofuaZmSByWB4ucdoPqqPLNLy8fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CTomEGEUwL8xhsKgiO59rFapSFcFYxOdFOQTdvSnqk=;
 b=DfkfLIUMafpcgRaVYwNzQ1Q/mHQHV4hYJRbSwp87jgh2InCsjyzga8Qz2DMKJjVW0cPddaA+gRrofrhJl1B8YtavZMMcP8r5fU7qp13xlIehOmhe5a0BmZMT+W8pHKtMRGvXzpNKBA/MjPYCxnr0G34u7WtnbWnS4taVliySjpE=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4624.jpnprd01.prod.outlook.com (2603:1096:404:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 06:05:15 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%8]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 06:05:15 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
Thread-Index: AQHX9qHoonjI6Y3fe064dMYL0OKUWqw9yUAAgAASfICAACrYAA==
Date: Wed, 22 Dec 2021 06:05:15 +0000
Message-ID: <61C2C02A.90104@fujitsu.com>
References: <20211221193500.31950-1-pvorel@suse.cz>
 <61C28CB8.3050209@fujitsu.com>
 <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
In-Reply-To: <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7964d6f5-bd01-412e-a289-08d9c5110633
x-ms-traffictypediagnostic: TYAPR01MB4624:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4624C533344A9810F6B204BEFD7D9@TYAPR01MB4624.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxkaWwkk769B+yVRJJ2RD+ijFjc1d3QJKOWgf0yp7ZgB1NTsUSPQucesuMXMwjQylKE7bq4YZUw1QYZs5B4jVU4W6V6/1Au2uvIEo2dMtmsb2NHshbeCypX8o6oIA7qWNsvuwyQA9lsLWopHUbK20B37exAO0IgC6R8CWRouPzEYc9A0J84HVF50vivFp/OYrDCqmgW+eLWil7WxuWshGbYkGKvMBis+dxed8H0AVLdh0DJIkOc4z7NgBKM/7TC/qg/m3z6Gal2WYZMGz7RGuHzAGLqvsZ13ddtl+Q+bXe56CvCJQDAVNfEhHySteKxDpbE3Y3+ADzXCLSS3MrRj4szRVjamv3+SZxP2aHZQVMBVnDHgkYepPAGGhtUq8gyHE0EABG6OOR36j1AhAjvO8y8VOrLmyJo4tlrpF4/zjkoTN7rbP7OtTrGLZJgGNajbB8ahLPqcAiFg6NLXc1u3wTKPZ35zyaVGJzpubxdjZ78OvFlnbpEHmAj8MW6vOniYWbsW/cVAtC0JPPyNsPvejQ16Dni47/Ja0tZCb5J8ti+PSZW4VSrqdChvvPk8TBp2Qh2b6KAb0XMcfoJCKxnmcx1RmRz3KAfqTLRetDaH2lnEtf1AFl48/IhAuaC7SD97XUaEKYecEKaSojtgdgQ+rXsisrP75MkPXisQs7/VzFKcDwFbZnZyaubiUgKN1qqEczf00KQ4/rcopTe/OQjcQ+Hr5WQS5sogyH99ME9M90ZnjnBLJMmvJt5cuHVMYB7exlUqP2R9lCgAWtv1rC9aG0S6S9Ifyp1RAANh+N4PHoM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(2906002)(966005)(316002)(85182001)(36756003)(66446008)(66556008)(8936002)(33656002)(76116006)(66946007)(91956017)(54906003)(82960400001)(5660300002)(64756008)(508600001)(66476007)(38100700002)(6512007)(26005)(186003)(4326008)(122000001)(8676002)(53546011)(86362001)(6506007)(83380400001)(6916009)(38070700005)(71200400001)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFE3UjdOMjU4WDF3MXd2dk1PQU9iang5aHl5QThYVmFURWFCeDdoTUg4YllK?=
 =?utf-8?B?dlRETmlKRXlObGJyTVk4SktBVmE5M0F5clZNbDYvWm5pcUNzYkd0MWpISVFy?=
 =?utf-8?B?Y2NrL0psbU5nNFl6THp0YUl6N29XS1ZHMzVZV1JmeE53V0dKRXd5Q2JZODdx?=
 =?utf-8?B?NiswV2tYNU1vT3FWSHd5QWRCWlN6aVlsc0loY2VZdnk5NHJYb1JySmlHZ1JJ?=
 =?utf-8?B?ei9TbFkzR2tBZkpIYThBSlE0akZiamVDQU5LYy93QXFRUXNqKzEzMDVaWVRr?=
 =?utf-8?B?WnZ5VzVjUmdaOTZzMFE5RXArREwxQ2hzNjFWSFNBS1NnNjlYalNETHZ5UlB4?=
 =?utf-8?B?NCt2ZjZiWDRIMjlKOEFHemZiRlZVaVhMcCt0NzZNN3krY3NIWTZSTXlvdFJm?=
 =?utf-8?B?dTI4b0xnTUdDc01QU2RZMFR0OFg1cEJzRWtlVkFHZkJ4UldZYlRjZmIvUk4v?=
 =?utf-8?B?VlRPVUJxU2w4OFF1L29XNkh3dmEwVUpuTHdBdEhXQzlqUzY0TVFWMXpqdGpP?=
 =?utf-8?B?VlI4eXhYOGdnSHRYVjlYbXR4elRhcEhVSUo2LzBuMzZGR0FHMVppeVRUZEZu?=
 =?utf-8?B?dzFuZWJLNkRpaU1oRWdkaUFadVR0TGNMYU5MWWd3SVdFNk1YSzNWWEJSZzl4?=
 =?utf-8?B?N2xYaWRSbmdoNW5nRGRiVDNJOHdRVlNJRHlxbWZHa3dVQmlkOEVXZXUvaXR5?=
 =?utf-8?B?OGpnc0wxa0hmanY4Qy9HdEtJN1luWlp0N0FUY05rbW1LbHdqZ0U2UFNYVE5q?=
 =?utf-8?B?amdRMmR3UFNaM2ExTkNSY0pQTnRzeC9aUnk0Q3B5THdUT3JQcWZRc1ozOFlo?=
 =?utf-8?B?RTNLRkdxUXlrbnZLeVRGa0czaUhZSWJVYTh6SW5OeE9NTFlwam91eVNRKzNG?=
 =?utf-8?B?TUJMeC8xdjFMQXhSQzNVelNQVHg1QisydUlpdTVGU1o0cDNyMHdWNytqTXRT?=
 =?utf-8?B?ZmljVFJqYzR2R0hJOStmQnVaaDhveUI2SWdiQnFFNjIrWkozRHhyL09DdFRn?=
 =?utf-8?B?clhnMVcwcDBmSSs3MWF0azl3bWxiSWUrakN4TzFzT1JXbXhWbklxcXIxMHpk?=
 =?utf-8?B?Y29QZmVycFdEeVZGRmoyem1XTUFHYXNGcndoTXFIYW53SWtUcUtHRU9yeWhT?=
 =?utf-8?B?V3RSRUlJQlZNdkRIWExMYnJrb3VvTk1qbFB6VnBsN0xxT25yMUsyWGRVaTJZ?=
 =?utf-8?B?WSsrWUt2aVl3Mk1JbXVRRWdFc1c2THVEeW5nQkpjOTZIVTVwazZ0MUtZeFBS?=
 =?utf-8?B?Y1FuY3hXTEswNVdXT25Vc2lFK0Yxa0hPYkFhZm9RZHAxTzA3TUdCek9LQng3?=
 =?utf-8?B?VElrVXZTRjFrNmFmYTF6d1NhcVh1aDcvM1JkTWZuL1RDbTVTSEZTNkczVUhG?=
 =?utf-8?B?amJxbDJZb0RCUlRJSmE5U2FGTTFNVTBZM041VkNUWXgyTmpLNm1RVXhYNnpY?=
 =?utf-8?B?WndYc2diTGZCbUlnYmpHNHI0N1Q2bDdPb0tTTHQ4MDFURmdYK09PUDBkZU1z?=
 =?utf-8?B?ZGUrN00zSCtCM1NpVlR6L1hSd3Fxc0RCWGgrZnM4MFVlUUkzV3E1VklMaHdT?=
 =?utf-8?B?TDlJRDFyQUFKZnYrckxGUnoxR04xTy9qZzRqOW1SdDFmN3RVSmtlelhTM29j?=
 =?utf-8?B?NWZLblNCc2xuazIxdWk0VGo0MW10cWVMR0RUQ0FNL0RYUUdQRmpxVkFZZHJo?=
 =?utf-8?B?VTBlUTFzT2R3MUdpdG9mR1E2dGxEQjJnZ2RJeDZza3pLcUtJMHRRS2FnbVpR?=
 =?utf-8?B?V0Q2RnZKbHFSOVlsSGFNTlEwMUR5MTRLWTFyNy9rTms1cFB5YVZudWpacDVh?=
 =?utf-8?B?em9lMWNhaW1Qemh1bjMxSXFhTnQvQkhwNHhWTVlwWVZkOFFCV2xycUVJQndq?=
 =?utf-8?B?bG9mektBSXNHYUkrekNMYnhJOENiaTNlODd5VEIzWVJaYXB6YmJFdXVKSE5u?=
 =?utf-8?B?bUc3R0doYkNGUENLKzl0ZDV5VUJWdGU3RS9mL2lJTHc4QlJJTUo2NkFqcHFI?=
 =?utf-8?B?RC9BVVEvMm1Xa3VVM0krVHdPUG1Tb3FMWXZwSlp3S0NTWnEzVkZ3Uy9uamov?=
 =?utf-8?B?eGpjczVPL2w2eXRib1pWNyszdG9hYWFTcWdtUWZoMDJkSzd4RGJxNlIvejU4?=
 =?utf-8?B?blUrRGVvaGxNYzA3WHFMZVRmeHc5S09FWllCcWhrQWRmbEJKZ0tCTGpFdmVT?=
 =?utf-8?B?NFFLYldQbFcwOTZpTGd1Y2tHWndObFAvd3Z3b3lQS2NUeGdxYkUvN1IvbEhE?=
 =?utf-8?Q?wc/P05ZiMdMDbqQ6GjN2k2G4U0/Xm7vbZ/AaQgw0Ro=3D?=
Content-ID: <C802CB8ACD12B74A87CA9F67672A863B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7964d6f5-bd01-412e-a289-08d9c5110633
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 06:05:15.7454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq21kir/GR0zDVdAXyJCf5ZDSMIxjqNNd+Uccy83u2jx2Ai0l/4NX3YS/5naQwM/5+3c48pnowJwKOkUD+qcihp8NeOyuQbjuxNEGVAPoTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4624
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li
> Hi Xu, Petr,
>
> On Wed, Dec 22, 2021 at 10:26 AM xuyang2018.jy@fujitsu.com
> <mailto:xuyang2018.jy@fujitsu.com> <xuyang2018.jy@fujitsu.com
> <mailto:xuyang2018.jy@fujitsu.com>> wrote:
>
>     Hi Petr
>      > If needed to set value also for non-root, use set_oom_score_adj().
>     If so, why not rename set_oom_score_adj to tst_set_oom_score_adj and
>     add
>     declartion to tst_memutils.h?
>
>
> Yes, it makes sense to expose this function to users to cover
> more oom test scenarios. For instance, set a high (>0) or low (<0)
> score in child_alloc() to verify if OOM-Killer still works well.
> But so far, we don't have such tests.
>
>
>     ps: also have a word typo in set_oom_score_adj, adjustement =>
>     adjustment.
>
>     Best Regards
>     Yang Xu
>      >
>      > Fixes: 8a0827766d ("lib: add functions to adjust oom score")
>      >
>      > Signed-off-by: Petr Vorel<pvorel@suse.cz <mailto:pvorel@suse.cz>>
>      > ---
>      > include/tst_memutils.h | 11 ++++++++++-
>      > lib/tst_memutils.c | 6 ++++++
>      > 2 files changed, 16 insertions(+), 1 deletion(-)
>      >
>      > diff --git a/include/tst_memutils.h b/include/tst_memutils.h
>      > index 68a6e37714..e6f946ac0c 100644
>      > --- a/include/tst_memutils.h
>      > +++ b/include/tst_memutils.h
>      > @@ -30,11 +30,15 @@ long long tst_available_mem(void);
>      > * echo -1000>/proc/$PID/oom_score_adj
>      > * If the pid is 0 which means it will set on current(self) process.
>      > *
>      > + * WARNING:
>      > + * Do nothing for non-root, because setting value< 0 requires root.
>      > + If you want to set value also for non-root, use
>     set_oom_score_adj().
>      > + *
>      > * Note:
>      > * This exported tst_enable_oom_protection function can be used at
>     anywhere
>      > * you want to protect, but please remember that if you do enable
>     protection
>      > * on a process($PID) that all the children will inherit its score
>     and be
>      > - * ignored by OOM Killer as well. So that's why
>     tst_disable_oom_protection
>      > + * ignored by OOM Killer as well. So that's why
>     tst_disable_oom_protection()
>      > * to be used in combination.
>      > */
>      > void tst_enable_oom_protection(pid_t pid);
>      > @@ -42,6 +46,11 @@ void tst_enable_oom_protection(pid_t pid);
>      > /*
>      > * Disable the OOM protection for the process($PID).
>      > * echo 0>/proc/$PID/oom_score_adj
>      > + *
>      > + * WARNING:
>      > + * Do nothing for non-root, because it's expected to be cleanup
>     after
>      > + * tst_enable_oom_protection(). Use set_oom_score_adj(), if you
>     want to set
>      > + * value also for non-root.
>      > */
>      > void tst_disable_oom_protection(pid_t pid);
>      >
>      > diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
>      > index 4346508d9a..f0695e026a 100644
>      > --- a/lib/tst_memutils.c
>      > +++ b/lib/tst_memutils.c
>      > @@ -126,10 +126,16 @@ static void set_oom_score_adj(pid_t pid,
>     int value)
>      >
>      > void tst_enable_oom_protection(pid_t pid)
>      > {
>      > + if (geteuid() != 0)
>
>
> This is not working as expected in Github CI. I'm still looking at the
> problem.
> https://github.com/wangli5665/ltp/runs/4602025797?check_suite_focus=true
I tested local but it works well. I guess ci fails because of linux user 
namespace. Maybe we should require CAP_SYS_RESOURCE cap instead of using 
geteuid.

Best Regards
Yang Xu
>
> And the worth mentioning, maybe better to do this check
> in set_oom_score_adj() if we do not decide to expose
> that function to user.
>
> --
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
