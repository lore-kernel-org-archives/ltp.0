Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17E2C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 05:12:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2330B3C946A
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 06:12:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD1743C1FF1
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 06:11:47 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E8BF600551
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 06:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647580305; x=1679116305;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6PDb4ceJTKtsyDvgtClOj5rmblaSAn2Y39Gp9VPOx1g=;
 b=fBWRO9tsrtzezbBldGNnmsVdeoMYybWnGkWpF+B9gLllqRQjl0wMQolZ
 ySpHvRjS2w9DQx5wVRFequ7BbJkgESN70Kbso8EPBUF/UU8i9o46NB2D9
 83Z4eV/E3iXhUksaDCT2KvcAlwM5OWrM+QHbmRAzhbLTqTB1urnxDw2Eb
 QJ1QKa+Y4TSip0+9vfhlgReRRig5zCtYXOG51geds9ayofZDj5NxiRcO0
 7hn2EwH5SbwOQpEfDHctyw0inFUIc6zEGooE/vlr3k8P7B0BF0iOR3Vn9
 zDDB6ez9cRNqLgbDRsW8T4eIa/z4IxFVA1DNR/cUhHfCANOmT1ve0plH/ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="52013865"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; d="scan'208";a="52013865"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 14:11:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6B42qbuLnU7vUqUhs8+UUXy33QPlmsQDIYbylni66zgYKrGrFu28ESEllJ/D7oWK5eYmP0BjtJG+c4pGI6O2jRM5xzfEuLEoOlZnKdU4/6gcjhAB+rklrOWZjoUGfn5pgJJFI7T2e67af8975IP8lL7aTE0Z16IcjEhM97uYJNZnz18Iwn0pNiq7/EY4Cwnmte5vPmLOKqIgX1bypqiw8Epny6t3cjFrYOjDlH2gpevCvPF534Z2ws8XDTJz8QaS605OS+L/E/Cj/v6PcP6nHwKFOfMmGtggPsG4hdeBeM5F0OtsA9e1AnUF0/8cnPGfj401ISYghAuaZQg3GDcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PDb4ceJTKtsyDvgtClOj5rmblaSAn2Y39Gp9VPOx1g=;
 b=ZP5lmMuIw4BSPTvVFHz5d3eygXLRe8F2BhclC+lZN1xSwMIVIhBKNlecws6886m65lYDFg6myc78650dtzbWkgcWMW/qasBOsfVtjrOwVsDucDtBgyBahRUNEEPbFXd/JW79l2MBRJEg5kV1g24WDFgDT+dxPilU+YboOErmYuTevJ6XV50q7qZnUeJbKtBYLn8Y3ev6ox6/HYjK23oWKmVEDR+xJbd+8sFACrXtT0MmvaNI90iSmTNpYnQEQjNf6fvJlM9HIESdArYUs5fZQsFZv9CsSjG0Z9CG5zdREQktoPmsdiZ6yjC7ZnNPwyE5v8AgcRIm5DeARimGJn5jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PDb4ceJTKtsyDvgtClOj5rmblaSAn2Y39Gp9VPOx1g=;
 b=oZlUh+JnbStarfKQQgh8iK9up3gl4NIM7UWeAAXwaxar9/NLau9/UP//9UYLcI17X5HLTbpj+lVz96AuSDkVepgxJr5dI2RBKmPTNN+Qug4LDgMXLVrFqPT5X6jrJvO76KaKoTlwsKknTKxyICHCxhus9D3/AXurQ+UjiaNpArg=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB2101.jpnprd01.prod.outlook.com (2603:1096:603:26::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 05:11:39 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 05:11:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH v2 3/3] syscalls/umount2: Convert to new API and
 use SAFE_ACCESS
Thread-Index: AQHYOd2QlmtC+uab6Ey66DlhPzspCKzEhrgAgAATDYA=
Date: Fri, 18 Mar 2022 05:11:39 +0000
Message-ID: <623414B7.6060004@fujitsu.com>
References: <622EE434.4000400@fujitsu.com>
 <1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com>
 <1647550813-1958-3-git-send-email-daisl.fnst@fujitsu.com>
 <623404BC.90906@fujitsu.com>
In-Reply-To: <623404BC.90906@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 430e8a95-c3e6-43a5-8740-08da089dc8c1
x-ms-traffictypediagnostic: OSBPR01MB2101:EE_
x-microsoft-antispam-prvs: <OSBPR01MB21015F5E11123FA550B145A3FD139@OSBPR01MB2101.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PeBmBKjrFZarir6KKby1UUbbrODZ3kPq3PfQ48XqTfSIhOsj+4/Ik0nQbcEBn2mJfAORwNYlA6ZngfIDOiBo50yJin6sNLfU5xxOl4s/hBxZwzu3gTtnfmcthyxr/+Dk157pmuGFtb630m7hjFe0fJRIOr8HfK8MRlEmT85g4/ucJJOFImZCtCE8Ytp5DHy26Q+Wknw1yObGRHZ51sGy6TnJJfACZO+vUXUR6GOvZ33k7VxMMV8pjSHZl0nKEs3jKmSjImA7tToIef1yUGBrgU+Ne2aLEGhrTQHTb6KbCpAWA63u7P7gLQIJOaFovjJqRsH0h+JoIXSebJATwDt+Kg6xYSWjm6w8KB4HtXieHKoCdn+eVCEPOjNyNlQKpmTfGcx/lW83IOWlZrsP7/TELLAzpyfOoPxNkU3mkJQSwEmJPMTwqHby5ZxTpJI86dKTdMuMqmiBlrLB9CfCKIprpvelBS9KGrKUsF1eu5RGZqrO7qL26l3qB585M3uY1EjfTRsgXj/Ak7dy4IpCPlHbdFlK+q4gakSMapIdkb4Bz4R5hn97R0pMuwV/kCrA34J1SGSIk17etPzPus253opi7hJTgoOJ/V4YOG5++WQ6KKWSVdMChYZnD+m8/BrfZbnjlylKkAotH2SCIJBk50FWP2U3/UUA2a6G59TtgbEDF+ZjruxZOZfqfaML8YR5EWQqyF5a8+06Cn+w7X8k4VuNk5c/oKwS217XXY86tSnoAc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2616005)(83380400001)(6512007)(6506007)(26005)(8936002)(30864003)(85182001)(87266011)(36756003)(186003)(2906002)(66476007)(8676002)(66446008)(4326008)(6862004)(508600001)(66556008)(66946007)(64756008)(38100700002)(71200400001)(5660300002)(38070700005)(33656002)(37006003)(6636002)(82960400001)(316002)(91956017)(6486002)(76116006)(122000001)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WlptWlVtLzBwSENlaTF1RWFja3RXWGYvb3VBc3h4QmtTWFp1UHFhZjRMQjF2?=
 =?gb2312?B?Tm1nUkZpaEFmN3d0c1B0SlZRcC8yQ0p1M1FTY2p2Y3VSL0pzMWtNYUE3cjhv?=
 =?gb2312?B?QzVyaDZVOExjRUlkb0NjOFJKVkFpQTZ0WFA0cGYxME11RnVVTDB4K1VtYkxx?=
 =?gb2312?B?NkZHTm5PQ1NPbkc2Y0NNR3JNZ25EckpGSjZ3VmwyS29HSWgvRm1wUXE4Ti9P?=
 =?gb2312?B?bWZaMStERFByNDZSSVhOaXFlNTRxTW5rdjVnbzUxTFczUmdFNit1Y1ZHUUFj?=
 =?gb2312?B?ZVoxak10MzEyM3JvaXRZcmpURFQ0MUtKREdwNmNkVE9SR1ZkelIxMXNEbzgy?=
 =?gb2312?B?czNnYW9BQml2V2lkU084RUZTc3hKdGpWL2VFUGFTRmowRlUzTmtoQWd1U3dY?=
 =?gb2312?B?eWRFT0Rsd2tmc01GUzFmbXdHT2lqNHBzQTg1UjNRWDRHR2orVmtSRWdMUzdT?=
 =?gb2312?B?ZExjTTIvbzVWS2tJeTk3K0pYbGl3TWplaG1lSDZyWGJnbzhxZm5mcGJKQVNN?=
 =?gb2312?B?dHBTd1pDM2s1N2xpU0hGLzR4cE9MUk90WVJFN0hDTUxLWE85d0dld1lrYXRy?=
 =?gb2312?B?MHVLQThSV1dkTTJBR21FdFlZaDE5bmdqdUdrMDVKbGJhZDRUMks2ekllNXN1?=
 =?gb2312?B?c1lPV0RuclBOVXkxZmd5NnFZNlFiY0M1S285SVphY0NWK2s1YXVlZkh1d2NX?=
 =?gb2312?B?cWJjQ0Fud1BzSEl4U05DbjhkS3VJaHdIdkxUNFNxc0ZLOWZ4M2J4RThIeUk2?=
 =?gb2312?B?UndBK2RXT1JPUTBIWWlzN09YYmU3NnZVRjlqb0NKcmFSQTdrbkcyT3VpR2x2?=
 =?gb2312?B?ME42UGdjMDQrajYxQkhqdEx5M3JIOUVrTzFyYnhtajhyOU9XbWhxQVdGUGY3?=
 =?gb2312?B?dndBRTNWSmhFWFF4NldGNUxPeHE4RXRielVNQk9CdndPYlF4M1VZUWdCUmZj?=
 =?gb2312?B?WDZrYVZ2YlRHUnU1OWFvYUMwUXNRVDcvZjRPbFZvQ3VyWWh3ZXRUOHB0eHZC?=
 =?gb2312?B?WC9DWmliVjBHK3FmSm0yVDUwMjVNZVIrdlRGU0lKZWp2aGdNaU1IWHdKb1FO?=
 =?gb2312?B?UnRtZVBuUjNpTmY5eFlsbCs2d29xbHFXY2dOeXZVUXUxRlZHWCthbHc0Zzgr?=
 =?gb2312?B?S3QycytPcEthNXdERGNUd0FrWDBDeVc1THozK3NMNDdPVGxlRHM4VVZRTGN3?=
 =?gb2312?B?d3ZWTGErUDJkQXM2Um5QVHpTdGxVeUk1N0hrSXQ0b055UUFNbGt3MmNZK2ZJ?=
 =?gb2312?B?R29YbThrc0hrRUVIQ0FtU292RVpsVnB0S0t0UXM3M3RZRnEwNmZiR2lFNGpS?=
 =?gb2312?B?MVNlTzljTXlCZVFoQ0hwK1ZmQ3Q5eVdROXZxRjlZUHFvSXEweUt4RWNCUm5Y?=
 =?gb2312?B?Ym9CbVBta2t0a1VDTllLeVlENmRoNUJuelVjblNCVWJVZGxoUnZrSjI5Zkp2?=
 =?gb2312?B?WDJBTDZHTlEvellQVUNmaDJ4TjMvUWxuNzd6andPeFAwTFZ3SWFMTDhxaTVM?=
 =?gb2312?B?eE9Vd29vY1d3NWwrV3JkeDdZdGlodkFuQWZqcC9HQ2hYVC91YlBvNU5nTGJt?=
 =?gb2312?B?QXhhYjEzenVOaXVHL1FYWHRIV3dsTldHTnV0M29IckgwOFRlWFRCcWdkelVO?=
 =?gb2312?B?bVhnN0lpWFVnUkdlR1oxeEo2VXBtV1k5emxUM3VpS09KM3ozZDZLVXE0bldH?=
 =?gb2312?B?UUFFd2VscUNleU5qRkRPMndSL0R0TldndGRPK3pqa3d2YXFUbUE2UG05NzVD?=
 =?gb2312?B?LytJdXNpYm5MVDNmNERIMENVbEhONVBxcDA2cjZZQzBpcW9yQ3ZBOHhyeWpQ?=
 =?gb2312?B?ajJxcFMvWTg0ZjQ0VGhLM1BITGRKRDd3aXpqL0o5bGF3OUR3YzVISlZVQldi?=
 =?gb2312?B?WmljREEreko3VXE0VWVDRncwdFVnSWpsdjRPRzllbzNNL1BtS2g0Z1dUT3kr?=
 =?gb2312?B?TE9NdzgrbU91enkvdnJPZWE0My94WE5GRHBqWDBETnE5VDR3NGx3NW9MakRj?=
 =?gb2312?Q?vXbWrNCqQDnHIEaZxkU37QauvlzUgY=3D?=
Content-ID: <2AB13753577E0049B36F0F38826CDE03@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430e8a95-c3e6-43a5-8740-08da089dc8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 05:11:39.6579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tx+kCYrT1PhnKSbuWW/HTy3+vXxYQf5eiKzu+SPJ3AuUoDU4WflCt59PDfWJmG7YA8rDV4xQDQh+mY7Un0qyJ/jtfdz9EI7ajMtHXC6MVw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2101
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] syscalls/umount2: Convert to new API and
 use SAFE_ACCESS
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

Hi Dai

Sorry, it seems keep umount2_02 and umount2_03 is more clean.
> Hi Dai
>
> Since umount2_02 and umount2_03 is similar, can we merge them into a
> single case?
>
> Best Regards
> Yang Xu
>> 1. use TST_EXP_FAIL and TST_EXP_PASS macro
>> 2. use SAFE macro
>> 3. simplify verify operations
>>
>> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
>> ---
>>    testcases/kernel/syscalls/umount2/umount2.h    |   5 +-
>>    testcases/kernel/syscalls/umount2/umount2_02.c | 194 +++++++------------------
>>    testcases/kernel/syscalls/umount2/umount2_03.c | 167 +++++----------------
>>    3 files changed, 94 insertions(+), 272 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/umount2/umount2.h b/testcases/kernel/syscalls/umount2/umount2.h
>> index 65e4c24..d1e486e 100644
>> --- a/testcases/kernel/syscalls/umount2/umount2.h
>> +++ b/testcases/kernel/syscalls/umount2/umount2.h
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>    /*
>>     * Copyright (c) 2016 Cyril Hrubis<chrubis@suse.cz>
>>     *
>> @@ -28,13 +29,13 @@ static inline int umount2_retry(const char *target, int flags)
>>    		if (ret == 0 || errno != EBUSY)
>>    			return ret;
>>
>> -		tst_resm(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
>> +		tst_res(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
>>    			 target, flags, i);
>>
>>    		usleep(100000);
>>    	}
>>
>> -	tst_resm(TWARN, "Failed to umount('%s', %i) after 50 retries",
>> +	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
>>    	         target, flags);
>>
>>    	errno = EBUSY;
>> diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
>> index 7d558fa..39f1608 100644
>> --- a/testcases/kernel/syscalls/umount2/umount2_02.c
>> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
>> @@ -1,182 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>    /*
>> - * Copyright (c) 2015 Fujitsu Ltd.
>> + * Copyright (c) 2015-2022 FUJITSU LIMITED. All rights reserved
>>     * Author: Guangwen Feng<fenggw-fnst@cn.fujitsu.com>
>> - *
>> - * This program is free software; you can redistribute it and/or modify it
>> - * under the terms of version 2 of the GNU General Public License as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it would be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * alone with this program.
>>     */
>>
>>    /*
typo, /* => /*\
>> - * DESCRIPTION
>> + * [Description]
>> + *
>>     *  Test for feature MNT_EXPIRE of umount2().
>> - *  "Mark the mount point as expired.If a mount point is not currently
>> - *   in use, then an initial call to umount2() with this flag fails with
>> - *   the error EAGAIN, but marks the mount point as expired. The mount
>> - *   point remains expired as long as it isn't accessed by any process.
>> - *   A second umount2() call specifying MNT_EXPIRE unmounts an expired
>> - *   mount point. This flag cannot be specified with either MNT_FORCE or
>> - *   MNT_DETACH. (fails with the error EINVAL)"
>> + *
>> + * - EINVAL when flag is specified with either MNT_FORCE or MNT_DETACH
>> + * - EAGAIN when initial call to umount2(2) with MNT_EXPIRE
>> + * - EAGAIN when umount2(2) with MNT_EXPIRE after access(2)
>> + * - succeed when second call to umount2(2) with MNT_EXPIRE
>>     */
>>
>> -#include<errno.h>
>>    #include<sys/mount.h>
>> -
>> -#include "test.h"
>> -#include "safe_macros.h"
>>    #include "lapi/mount.h"
>> -
>> +#include "tst_test.h"
>>    #include "umount2.h"
>>
>> -#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
>> -#define MNTPOINT	"mntpoint"
>> -
>> -static void setup(void);
>> -static void test_umount2(int i);
>> -static void verify_failure(int i);
>> -static void verify_success(int i);
>> -static void cleanup(void);
>> -
>> -static const char *device;
>> -static const char *fs_type;
>> +#define MNTPOINT        "mntpoint"
>>
>>    static int mount_flag;
>>
>> -static struct test_case_t {
>> +static struct tcase {
>>    	int flag;
>>    	int exp_errno;
>>    	int do_access;
>>    	const char *desc;
>> -} test_cases[] = {
>> +} tcases[] = {
>>    	{MNT_EXPIRE | MNT_FORCE, EINVAL, 0,
>> -		"umount2(2) with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
>> +		"umount2() with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
>> +
>>    	{MNT_EXPIRE | MNT_DETACH, EINVAL, 0,
>> -		"umount2(2) with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
>> +		"umount2() with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
>> +
>>    	{MNT_EXPIRE, EAGAIN, 0,
>> -		"initial call to umount2(2) with MNT_EXPIRE expected EAGAIN"},
>> +		"initial call to umount2() with MNT_EXPIRE expected EAGAIN"},
>> +
>>    	{MNT_EXPIRE, EAGAIN, 1,
>> -		"umount2(2) with MNT_EXPIRE after access(2) expected EAGAIN"},
>> +		"umount2() with MNT_EXPIRE after access() expected EAGAIN"},
>> +
>>    	{MNT_EXPIRE, 0, 0,
>> -		"second call to umount2(2) with MNT_EXPIRE expected success"},
>> +		"second call to umount2() with MNT_EXPIRE expected success"},
>>    };
>>
>> -char *TCID = "umount2_02";
>> -int TST_TOTAL = ARRAY_SIZE(test_cases);
>> -
>> -int main(int ac, char **av)
>> +static void test_umount2(unsigned int n)
>>    {
>> -	int lc;
>> -	int tc;
>> +	struct tcase *tc =&tcases[n];
>>
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		tst_count = 0;
>> -
>> -		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
>> +	if (!mount_flag) {
>> +		SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>>    		mount_flag = 1;
>> -
>> -		for (tc = 0; tc<   TST_TOTAL; tc++)
>> -			test_umount2(tc);
>> -
>> -		if (mount_flag) {
>> -			if (tst_umount(MNTPOINT))
>> -				tst_brkm(TBROK, cleanup, "umount() failed");
>> -			mount_flag = 0;
>> -		}
>>    	}
>>
>> -	cleanup();
>> -	tst_exit();
>> -}
>> -
>> -static void setup(void)
>> -{
>> -	tst_require_root();
>> -
>> -	if ((tst_kvercmp(2, 6, 8))<   0) {
>> -		tst_brkm(TCONF, NULL, "This test can only run on kernels "
>> -			 "that are 2.6.8 or higher");
>> -	}
>> -
>> -	tst_sig(NOFORK, DEF_HANDLER, NULL);
>> -
>> -	tst_tmpdir();
>> +	tst_res(TINFO, "Testing %s", tc->desc);
>>
>> -	fs_type = tst_dev_fs_type();
>> -	device = tst_acquire_device(cleanup);
>> +	if (tc->do_access)
>> +		SAFE_ACCESS(MNTPOINT, F_OK);
>>
>> -	if (!device)
>> -		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
>> -
>> -	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
>> -
>> -	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
>> -
>> -	TEST_PAUSE;
>> -}
>> -
>> -static void test_umount2(int i)
>> -{
>> -	/* a new access removes the expired mark of the mount point */
>> -	if (test_cases[i].do_access) {
>> -		if (access(MNTPOINT, F_OK) == -1)
>> -			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
>> -	}
>> -
>> -	TEST(umount2_retry(MNTPOINT, test_cases[i].flag));
>> -
>> -	if (test_cases[i].exp_errno != 0)
>> -		verify_failure(i);
>> -	else
>> -		verify_success(i);
>> -}
>> -
>> -static void verify_failure(int i)
>> -{
>> -	if (TEST_RETURN == 0) {
>> -		tst_resm(TFAIL, "%s passed unexpectedly", test_cases[i].desc);
>> -		mount_flag = 0;
>> -		return;
>> -	}
>> -
>> -	if (TEST_ERRNO != test_cases[i].exp_errno) {
>> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
>> -			 test_cases[i].desc);
>> -		return;
>> -	}
>> -
>> -	tst_resm(TPASS | TTERRNO, "umount2(2) failed as expected");
>> -}
>> -
>> -static void verify_success(int i)
>> -{
>> -	if (TEST_RETURN != 0) {
>> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
>> -			 test_cases[i].desc);
>> -		return;
>> +	if (tc->exp_errno) {
>> +		TST_EXP_FAIL(umount2_retry(MNTPOINT, tc->flag), tc->exp_errno,
>> +			"umount2_retry(%s, %d)", MNTPOINT, tc->flag);
>> +		if (!TST_PASS)
>> +			mount_flag = 0;
>> +	} else {
>> +		TST_EXP_PASS(umount2_retry(MNTPOINT, tc->flag),
>> +			"umount2_retry(%s, %d)", MNTPOINT, tc->flag);
>> +		if (TST_PASS)
>> +			mount_flag = 0;
>>    	}
>> -
>> -	tst_resm(TPASS, "umount2(2) succeeded as expected");
>> -	mount_flag = 0;
>>    }
>>
>>    static void cleanup(void)
>>    {
>> -	if (mount_flag&&   tst_umount(MNTPOINT))
>> -		tst_resm(TWARN | TERRNO, "Failed to unmount");
>> -
>> -	if (device)
>> -		tst_release_device(device);
>> -
>> -	tst_rmdir();
>> +	if (mount_flag)
>> +		SAFE_UMOUNT(MNTPOINT);
>>    }
>> +
>> +static struct tst_test test = {
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.needs_device = 1,
>> +	.format_device = 1,
If we specify format_device, it wil assign value for needs_device a 
utomatically. So we can remove redundant needs_device.
>> +	.mntpoint = MNTPOINT,
>> +	.test = test_umount2,
>> +};
>> diff --git a/testcases/kernel/syscalls/umount2/umount2_03.c b/testcases/kernel/syscalls/umount2/umount2_03.c
>> index a8fddf6..f44ff79 100644
>> --- a/testcases/kernel/syscalls/umount2/umount2_03.c
>> +++ b/testcases/kernel/syscalls/umount2/umount2_03.c
>> @@ -1,167 +1,80 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>    /*
>> - * Copyright (c) 2015 Fujitsu Ltd.
>> + * Copyright (c) 2015-2022 FUJITSU LIMITED. All rights reserved
>>     * Author: Guangwen Feng<fenggw-fnst@cn.fujitsu.com>
>> - *
>> - * This program is free software; you can redistribute it and/or modify it
>> - * under the terms of version 2 of the GNU General Public License as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it would be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * alone with this program.
>>     */
>>
>>    /*
Here as well.

Best Regards
Yang Xu
>> - * DESCRIPTION
>> + * [Description]
>> + *
>>     *  Test for feature UMOUNT_NOFOLLOW of umount2().
>> - *  "Don't dereference target if it is a symbolic link,
>> - *   and fails with the error EINVAL."
>> + *
>> + * - EINVAL when target is a symbolic link
>> + * - succeed when target is a mount point
>>     */
>>
>> -#include<errno.h>
>>    #include<sys/mount.h>
>> -
>> -#include "test.h"
>> -#include "safe_macros.h"
>> +#include "tst_test.h"
>>    #include "lapi/mount.h"
>> -
>>    #include "umount2.h"
>>
>> -#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
>>    #define MNTPOINT	"mntpoint"
>>    #define SYMLINK	"symlink"
>>
>> -static void setup(void);
>> -static void test_umount2(int i);
>> -static void verify_failure(int i);
>> -static void verify_success(int i);
>> -static void cleanup(void);
>> -
>> -static const char *device;
>> -static const char *fs_type;
>> -
>>    static int mount_flag;
>>
>>    static struct test_case_t {
>>    	const char *mntpoint;
>>    	int exp_errno;
>>    	const char *desc;
>> -} test_cases[] = {
>> +} tcase[] = {
>>    	{SYMLINK, EINVAL,
>>    		"umount2('symlink', UMOUNT_NOFOLLOW) expected EINVAL"},
>>    	{MNTPOINT, 0,
>>    		"umount2('mntpoint', UMOUNT_NOFOLLOW) expected success"},
>>    };
>>
>> -char *TCID = "umount2_03";
>> -int TST_TOTAL = ARRAY_SIZE(test_cases);
>> -
>> -int main(int ac, char **av)
>> +static void test_umount2(unsigned int n)
>>    {
>> -	int lc;
>> -	int tc;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> +	struct test_case_t *tc =&tcase[n];
>>
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		tst_count = 0;
>> -
>> -		for (tc = 0; tc<   TST_TOTAL; tc++)
>> -			test_umount2(tc);
>> +	if (!mount_flag) {
>> +		SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>> +		mount_flag = 1;
>>    	}
>>
>> -	cleanup();
>> -	tst_exit();
>> -}
>> -
>> -static void setup(void)
>> -{
>> -	tst_require_root();
>> -
>> -	if ((tst_kvercmp(2, 6, 34))<   0) {
>> -		tst_brkm(TCONF, NULL, "This test can only run on kernels "
>> -			 "that are 2.6.34 or higher");
>> -	}
>> -
>> -	tst_sig(NOFORK, DEF_HANDLER, NULL);
>> -
>> -	tst_tmpdir();
>> -
>> -	fs_type = tst_dev_fs_type();
>> -	device = tst_acquire_device(cleanup);
>> -
>> -	if (!device)
>> -		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
>> -
>> -	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
>> -
>> -	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
>> -
>> -	SAFE_SYMLINK(cleanup, MNTPOINT, SYMLINK);
>> -
>> -	TEST_PAUSE;
>> -}
>> -
>> -static void test_umount2(int i)
>> -{
>> -	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
>> -	mount_flag = 1;
>> -
>> -	TEST(umount2_retry(test_cases[i].mntpoint, UMOUNT_NOFOLLOW));
>> -
>> -	if (test_cases[i].exp_errno != 0)
>> -		verify_failure(i);
>> -	else
>> -		verify_success(i);
>> -
>> -	if (mount_flag) {
>> -		if (tst_umount(MNTPOINT))
>> -			tst_brkm(TBROK, cleanup, "umount() failed");
>> -		mount_flag = 0;
>> +	tst_res(TINFO, "Testing %s", tc->desc);
>> +
>> +	if (tc->exp_errno) {
>> +		TST_EXP_FAIL(umount2_retry(tc->mntpoint, UMOUNT_NOFOLLOW), tc->exp_errno,
>> +			"umount2_retry(%s, %d)", tc->mntpoint, UMOUNT_NOFOLLOW);
>> +		if (!TST_PASS)
>> +			mount_flag = 0;
>> +	} else {
>> +		TST_EXP_PASS(umount2_retry(tc->mntpoint, UMOUNT_NOFOLLOW),
>> +			"umount2_retry(%s, %d)", tc->mntpoint, UMOUNT_NOFOLLOW);
>> +		if (TST_PASS)
>> +			mount_flag = 0;
>>    	}
>>    }
>>
>> -static void verify_failure(int i)
>> -{
>> -	if (TEST_RETURN == 0) {
>> -		tst_resm(TFAIL, "%s passed unexpectedly", test_cases[i].desc);
>> -		mount_flag = 0;
>> -		return;
>> -	}
>> -
>> -	if (TEST_ERRNO != test_cases[i].exp_errno) {
>> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
>> -			 test_cases[i].desc);
>> -		return;
>> -	}
>> -
>> -	tst_resm(TPASS | TTERRNO, "umount2(2) failed as expected");
>> -}
>> -
>> -static void verify_success(int i)
>> +static void setup(void)
>>    {
>> -	if (TEST_RETURN != 0) {
>> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
>> -			 test_cases[i].desc);
>> -		return;
>> -	}
>> -
>> -	tst_resm(TPASS, "umount2(2) succeeded as expected");
>> -	mount_flag = 0;
>> +	SAFE_SYMLINK(MNTPOINT, SYMLINK);
>>    }
>>
>>    static void cleanup(void)
>>    {
>> -	if (mount_flag&&   tst_umount(MNTPOINT))
>> -		tst_resm(TWARN | TERRNO, "Failed to unmount");
>> -
>> -	if (device)
>> -		tst_release_device(device);
>> -
>> -	tst_rmdir();
>> +	if (mount_flag)
>> +		SAFE_UMOUNT(MNTPOINT);
>>    }
>> +
>> +static struct tst_test test = {
>> +	.tcnt = ARRAY_SIZE(tcase),
>> +	.needs_tmpdir = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.format_device = 1,
>> +	.mntpoint = MNTPOINT,
>> +	.test = test_umount2,
>> +};
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
