Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D805C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:51:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982B6610A5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 982B6610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE6183C68BC
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 04:51:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 045453C6730
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:51:01 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EACBD1401707
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1635303061; x=1666839061;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+SUnFbcNfvShFbSOkTNs6JMLzyN/iIios4IlWf7FbgQ=;
 b=LaQR/ZbnLAg6VEnKWILqyRLUNe9c3Ipjj3D2mbsqIiFkCdbUrgeNVkty
 M7vgD/DzmFZtC2ZoOEhp0zln5qBUapLkWPudHr8MLStKYoSMqDEtWk1bq
 umzI4XZaVuvlbvGrcF/fsGVtnxwAi5s+Nx5zDLMz1e5Qt7M8cR5+VVoO+
 ly+BmDGnmPhBjhX8fbHkvcWz06kuy+Q8qHx14+02ZLs7HbxammCgtyA19
 K0az7FK4q01d/2eFWLkL1W6kAPfEXYCCeURvxNf2nCcVkLD5GJNfuQ5QT
 ndoMikuCZyFOKeVqg/T0wTA5tPraX3YxgVuhlrjTzUiSz7Q7rHlSMWj1w A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="41955540"
X-IronPort-AV: E=Sophos;i="5.87,184,1631545200"; d="scan'208";a="41955540"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 11:50:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVUnXILpbx7/4OujNvL8mXb6z5JD5RTFDANmHeRVeq6dj49yu3mA58u0oFTgnDsmuRzGs1Hua0jJCZpqaisfIRcNzy5OIsLl5GwR2kS9hVDxME/xVRzRloOLVeF/7aqsbx3Kjq+A6DfSHNRWLDBnaOP9gzkBURmR3jhJlUhPExGFGc6qlwQBsV/TB4AMDQlomcnfTzmkkvqJfw0N9dMPI2sfJlH66xfSPJaz+e0VPl6X2kImIs7kPq7lNQYCdZYTFsWANq75rYBQOZ9HgDnDQxYUyoa9agnT67qbOZrcs9Pk+bagBdY0zMqBvJ5w2nR+KMk0OO8iI5TC706Wygti0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SUnFbcNfvShFbSOkTNs6JMLzyN/iIios4IlWf7FbgQ=;
 b=bZGsfPciX+Mpj3vQf3ht/hFV0tMMPryPohr+uFTJqytT3sG4VE9HsADLmzZQlUSM6D8U/5P0HKucCVzIAIo5bii8fP2BXXswm3RPNeGBWkH5s8N3qFlRzOTtpctxHqdchwI1wKH7Wss2UVVGj7G/GEMOYBPElmQgB3nrVgw47+fPuZgawIzc2KhlUNqCyBLfC4uWNPe+s/mecJ4Z37h9Nml5UHLTGiz1kk0gVf87AdBxC81X3fQZEETFSNtnO0ENIn5fo/xo6nX5gTMwf/OBw9pq3sj78EDW+Jkh2KYpe2nPQ85B/9O0ujFN9lmpsUotkD1Y+xdrDBt1qfW3CbwGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SUnFbcNfvShFbSOkTNs6JMLzyN/iIios4IlWf7FbgQ=;
 b=NSi6HG+Cap1RULqB346ENy3AhO+sNir/ZHzj76tfkjb9fJRSJdJNF3av9898CrlDptNrth2kFwutxHNGrwltHiqI5O3kdf5ZwZQiu6UdDFaGleTVM8XXpcP7wFcklG2SzTIPMOb+7AJgF0IU5BFT+yGLX0nM5N7tvPNvVZhiBKs=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB3007.jpnprd01.prod.outlook.com (2603:1096:404:7f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 02:50:56 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 02:50:56 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1 02/11] syscalls/quotactl06???Also test with
 vfsv1 format
Thread-Index: AQHXym+vVRJ/xR6cRkST431OwQQfSKvmJhIA
Date: Wed, 27 Oct 2021 02:50:56 +0000
Message-ID: <6178BE94.8050108@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562591-5830-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YXgGiMSDSwVOhMfW@yuki>
In-Reply-To: <YXgGiMSDSwVOhMfW@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa51a454-a4a9-4fd8-7c1c-08d998f49966
x-ms-traffictypediagnostic: TYAPR01MB3007:
x-microsoft-antispam-prvs: <TYAPR01MB300707497855A6EFAECCF40DFD859@TYAPR01MB3007.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPAs94tyZollC1NgGCxydmq3P5UT5OyRP2e33gss75QVMZ98HKv9fI8R50T6fq+gJy4oXhr1mbObmSSLHwpp3GG32LclJs2aUcawtgZJ/qbkKYA6XXZJXGAe6O0JPgc+OpkOSvWsrIDiCQOW+tXue67tWBZ/MSpAI4AHmqqZPZIeRsY4/1DtEoousMKZx13lSTORiYEe/Mo40kXDCXSAMk6VgQXFm5CCTftx/zbD9x5PTaxjt/J3WJVA4wcbxntsndVqFzyX6E5XwGRPxBp4V/xBswRnkM5Wh1Q/l+mmEpxDQhyZrjli9cOY+xR/1EppCqK/hlvZmSCvOj5r6QawrkNH7WKldepw/AyRuqcB/zxfwlY/2d4+ZgqYZO5b6eEpBsyo776vAniY3+9QTfS1Ta7cauZd38BTMtyfKqL0wXD5kTNBM+4Uw3Iompl7qkp7MsffdhXsQGuGBfVpQRb03rwKdyeryl6bd5wwFZqJsRxGAf+UNMMXHL9e3J6waWfHGcAYTKNtLc3eTTkNNTCaeAF9HLBgjk9JxUA4n2ynusCErust76WePKm0wQz/6AhunFFXoVvhn9ADTgoZUs2cCDXn8gLzBufYBr8o9ofFMLLPx6q+Hk8uX6nEH3DWOPMp+6bIqRVcF6/vGWuj1qWJrw5TLiZZ5+A4o4BkOie6MVV43Qt6yQ7GYlw3glNs5JO++0nBJ1o5QXV5/N70CEFCC3Xsm+CSpyra45Fye1YWItomrutpeGokkEGT/6/6541mSNIeaiRdR6XkRcKPCpjZTURpHNxeX+DJlcNNp4tAVJg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(316002)(82960400001)(8676002)(6512007)(83380400001)(8936002)(6916009)(85182001)(966005)(33656002)(2906002)(36756003)(2616005)(508600001)(6486002)(26005)(66446008)(15650500001)(6506007)(5660300002)(87266011)(66946007)(66556008)(66476007)(122000001)(64756008)(186003)(71200400001)(86362001)(38070700005)(4326008)(91956017)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eEtUSzhrbDIyRGVnYTRSYWNHTE5ucTVwSC9OQnF2c3NYWktwSXZwanNVaURK?=
 =?gb2312?B?bTMyWVVZVGhpNEJ3KzdkZXVvSy9MMmVPWmZ5cTZRbG5LVkk4WjJadEVtUzdj?=
 =?gb2312?B?SUV5YkN2anpTWHhIUzRlVWlqVnVUZ253c1VJZnFxbmhoLzJra3hFU1c4QWJF?=
 =?gb2312?B?blg1KzY1ekZvQTZsTGhxdXpuTE16cVVnYzNQWW8xRDhHQVlkV2p3bkZMVHNm?=
 =?gb2312?B?eUJQV3ErTVQ1S1hhSnBGQzB0SkFPV05NaDkvOTIrdlp5aGRadVZhKzJVdUhP?=
 =?gb2312?B?R2Z5ZmhZMm84OVM4UFBMeEJ3Wmc2RGhVK1NNTUU0UFhiWXpPYmxZY25vaEl0?=
 =?gb2312?B?Q21KVEVvQS9pVmpSd2p2aGdFZU9aNHM4czVUam9RTSszalhZajVKTlJCSWk2?=
 =?gb2312?B?ZThGZm1JbCsyY2VUQi9UZ2ZWa3ZRUjU0Rk1YaVdHWGJ5OFJvMThiREprZlVr?=
 =?gb2312?B?MUJBdDFZRmJpM1ZJdzFJQ2NUdG16VGVDUWlwQlZvN2ZNeCtlakxBZHZ2aDRT?=
 =?gb2312?B?cVJYbGxzdEU1aHQ4RmxpdUVoVXM3Y2RxY2ZZcDVXalhEWWN0eWJJUEs5RjhF?=
 =?gb2312?B?eWpjRmp5RGZzUUhOS1VvRlVMYy91eW1iSlJFbEQ1Y0hLaWpmTVVHRHRnUFQ5?=
 =?gb2312?B?anlpOXJiVXlHQW5iNlVsU1QrMVR0ellLTnlMcFJVdTczWHBWRzEwc0dmWVJZ?=
 =?gb2312?B?TE81N1hXN0ZOR01vTHNPN1RMMGpmM3lyZVoxRlQvcVNWVWlPTVRtbWNPb3Vx?=
 =?gb2312?B?SGZLdnVrK2RWTGcyMnBTb3Z6R2toV1F1dmx4RUxvRGtTMi9CcWF2d3F6YUJO?=
 =?gb2312?B?OWttY0o1RldSRUlzTHVicnJVMjZrOWx2OUczR2ZicWttWmZ1WUYxWUpDTkxE?=
 =?gb2312?B?dnY4KzN1VDZSd0NVekJJVDNReDJKa2VzZ216b1JJOFdEeUtHYkxPQTBudzU4?=
 =?gb2312?B?T3pneDVnMDY3bUs0TVdRRzBjS01QVlE3cC9hM1pGV2ZUcld3U0Jka1JHM2ti?=
 =?gb2312?B?QkxrOW13RDdOdHU2MUtFWHluNzFNN25xYkxYMjZ4SGRTOFJRYVhyT090YmRP?=
 =?gb2312?B?MHlEREJ6V2FBU1J5T3RxNlloVmF2TThUUjM3V2hGVkQ3SGlXbHdramRiNGRi?=
 =?gb2312?B?ZG5rdllQN3p5dTdzRkNTbGwvWWgwbnhTNk5PTFJBWWVGT3V2azFnMFNDUWVO?=
 =?gb2312?B?QkFjNGF3eTkyaWtCQzFUZGdtYml2eXIxMXZvM3JwaU91cFptRTJYT0Q4LzV3?=
 =?gb2312?B?UHlEN2pHK1BCRE5HVE9DSkEyUFo0RVJqRWZRSjE5ejF3eWlnZGthRXh3VS91?=
 =?gb2312?B?NlRvQlhRejQ2Uk5wREhFc285L1gwT1JadThBeitGR0JnMlI1bnhUVythZ3JT?=
 =?gb2312?B?b0NSS2R4UGdDRDZlUDVnb29HTU54ekwzUnJ5cDN0UlpQTkpRcW44cDBsSDJU?=
 =?gb2312?B?Z0ltV3NYQTViUkhTckdqbjRhS2FDdnh4anVXeTR1enNhQVBLSCtVUUtWblN2?=
 =?gb2312?B?aTV3aGZXaUxSOWZ4QkpuNE9QUXpKMEhWb0Iwb1R2cXJFSGh4b3NZY3hjYmx4?=
 =?gb2312?B?UlB5MnR2ODFGZlBPYnRST0tyYVlic1B5a3Z0OGZpQWJ0Qm1BNXllRFY0aHcy?=
 =?gb2312?B?R01LdlZjOWZRM3ZzZ1VkeWxSRmh1b29TWW5CRjhyTmZCbXAzOVdLVitJa2l6?=
 =?gb2312?B?SHU3V1VGOUxLQmRhQTNMKzN1alQ4eVNjeERQMnpKYjlEZVo4UVpTMmt4Qkdt?=
 =?gb2312?B?V2NGZXA5TTMyeXc4TDYyc3N3N2FqUTVCRWxHbWlRdzNWaFBnY3E2ZlE1RHpv?=
 =?gb2312?B?cW0raWpGOS9PWjlqU1g3VmxneVpWSDVNc0FxMnVDTng2b3pzZXBWVmI5dU5W?=
 =?gb2312?B?M1hnU2ljS3kxcjZXcXhkRTFtbGZFc2hBTWMvSWtNc05FSXNmbUM5ckNjYXg5?=
 =?gb2312?B?NGdWTTlTdzFrQ05LSVB2Wk9URXpVUHhUOEZrUktPY3h4YlJndG9mOWVGUXFM?=
 =?gb2312?B?Rm51TmYvSGF2R1pLOVhTL01CTnBKTkt3WVhmckhBRUduK0pzSjExVjdOOXZ6?=
 =?gb2312?B?Q3pLOTN6bjlFcDVTa3B3WWtPOVI0MC9mR21DSnRIYjJTeUsrTThyZDNvejBz?=
 =?gb2312?B?RGFGT3Y3L3pJblVnWlZtOFg4dmQ5M3VaZWVFdmtNYWdzc3JtaGZrTlp1czJE?=
 =?gb2312?B?NWFtb1BxTmgyRDhha2RwWlozNzgwNTFvWEh5WGNnNlVqUkJFMjhwME1rL2lK?=
 =?gb2312?Q?nl6vousRo83XsYoLQiUUb6e6EFS6r2PXFhN69xM6hs=3D?=
Content-ID: <AC530C3F0610BC41B8DDCFE095E5DEF9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa51a454-a4a9-4fd8-7c1c-08d998f49966
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 02:50:56.1732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iqth9eHZuRPoJcfWebckaejM90+vRVz9BGkoRj3b7dLdyn6Ms9sPUhDNoNNq1VUpHOULgCMCyaZ/Zpo5cWKVahkvrSHhCSdIqUthgN+Vqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3007
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 02/11] syscalls/quotactl06???Also test with
 vfsv1 format
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

Hi Cyril
> Hi!
>> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
>> @@ -1,26 +1,42 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> + * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
>>    * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Tests basic error handling of the quotactl syscall with visible quota files
>> + * (cover two formats, vfsv0 and vfsv1):
>>    *
>> - * Tests basic error handling of the quotactl syscall.
>>    * 1) quotactl fails with EACCES when cmd is Q_QUOTAON and addr
>>    * existed but not a regular file.
>> + *
>>    * 2) quotaclt fails with ENOENT when the file specified by special
>>    * or addr does not exist.
>> + *
>>    * 3) quotactl fails with EBUSTY when  cmd is Q_QUOTAON and another
>>    * Q_QUOTAON had already been performed.
>> + *
>>    * 4) quotactl fails with EFAULT when addr or special is invalid.
>> + *
>>    * 5) quotactl fails with EINVAL when cmd or type is invalid.
>> + *
>>    * 6) quotactl fails with ENOTBLK when special is not a block device.
>> + *
>>    * 7) quotactl fails with ESRCH when no disk quota is found for the
>>    * indicated user and quotas have not been turned on for this fs.
>> + *
>>    * 8) quotactl fails with ESRCH when cmd is Q_QUOTAON, but the quota
>>    * format was not found.
>> + *
>>    * 9) quotactl fails with ESRCH when cmd is Q_GETNEXTQUOTA, but there
>>    * is no ID greater than or equal to id that has an active quota.
>> + *
>>    * 10) quotactl fails with ERANGE when cmd is Q_SETQUOTA, but the
>>    * specified limits are out of the range allowed by the quota format.
>> + *
>>    * 11) quotactl fails with EPERM when the caller lacked the required
>>    * privilege (CAP_SYS_ADMIN) for the specified operation.
>>    */
>
> Same comments apply here as well.
Got it.
>> @@ -32,10 +48,7 @@
>>   #include "tst_capability.h"
>>
>>   #define OPTION_INVALID 999
>> -#define QFMT_VFS_V0     2
>>   #define USRPATH MNTPOINT "/aquota.user"
>> -#define FMTID QFMT_VFS_V0
>> -
>>   #define MNTPOINT "mntpoint"
>>   #define TESTDIR1 MNTPOINT "/testdir1"
>>   #define TESTDIR2 MNTPOINT "/testdir2"
>> @@ -43,10 +56,10 @@
>>   static char usrpath[] = USRPATH;
>>   static char testdir1[] = TESTDIR1;
>>   static char testdir2[] = TESTDIR2;
>> -static int32_t fmt_id = FMTID;
>> +static int32_t fmt_id;
>>   static int32_t fmt_invalid = 999;
>>   static int test_invalid;
>> -static int test_id;
>> +static int test_id, mount_flag;
>>   static int getnextquota_nsup;
>>
>>   static struct if_nextdqblk res_ndq;
>> @@ -105,7 +118,7 @@ static void verify_quotactl(unsigned int n)
>>
>>   	if (tc->on_flag) {
>>   		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
>> -			FMTID, usrpath));
>> +			fmt_id, usrpath));
>>   		if (TST_RET == -1)
>>   			tst_brk(TBROK,
>>   				"quotactl with Q_QUOTAON returned %ld", TST_RET);
>> @@ -135,7 +148,7 @@ static void verify_quotactl(unsigned int n)
>>
>>   	if (quota_on) {
>>   		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
>> -			FMTID, usrpath));
>> +			fmt_id, usrpath));
>>   		if (TST_RET == -1)
>>   			tst_brk(TBROK,
>>   				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
>> @@ -150,10 +163,23 @@ static void verify_quotactl(unsigned int n)
>>
>>   static void setup(void)
>>   {
>> -	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
>> +	const char *const vfsv0_cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
>> +	const char *const vfsv1_cmd[] = {"quotacheck", "-uF", "vfsv1", MNTPOINT, NULL};
>
> If we are going to repeat this snippet in each test it may make sense to
> put it into a header as we do with variants:
>
> 	static struct quotactl_variant {
> 		int32_t fmt_id;
> 		const char *fmt_name;
> 	} variants[] = {
> 		{.fmt_id = QFMT_VFS_V0, .fmt_name = "vfsv0"}
> 		{.fmt_id = QFMT_VFS_V1, .fmt_name = "vfsv1"}
> 	};
>
> Then we can construct the rest easily from these as:
>
> 	const char *const cmd[] = {"quotacheck", "-uF", variants[variant].fmt_name, MNTPOINT, NULL};
>
> 	tst_res(TINFO, "quotactl() with %s format", variants[variant].fmt_name);
>
> 	SAFE_CMD(cmd, NULL, NULL);
> 	fmt_id = variants[variant].fmt_id;
Sounds great.

Best Regards
Yang Xu
>
>
>>   	unsigned int i;
>>
>> -	SAFE_CMD(cmd, NULL, NULL);
>> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota");
>> +	mount_flag = 1;
>> +
>> +	if (tst_variant) {
>> +		tst_res(TINFO, "quotactl() with vfsv1 format");
>> +		SAFE_CMD(vfsv1_cmd, NULL, NULL);
>> +		fmt_id = QFMT_VFS_V1;
>> +	} else {
>> +		tst_res(TINFO, "quotactl() with vfsv0 format");
>> +		SAFE_CMD(vfsv0_cmd, NULL, NULL);
>> +		fmt_id = QFMT_VFS_V0;
>> +	}
>>
>>   	if (access(USRPATH, F_OK) == -1)
>>   		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
>> @@ -175,8 +201,15 @@ static void setup(void)
>>   	}
>>   }
>>
>> +static void cleanup(void)
>> +{
>> +	if (mount_flag&&  tst_umount(MNTPOINT))
>> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
>> +}
>> +
>>   static struct tst_test test = {
>>   	.setup = setup,
>> +	.cleanup = cleanup,
>>   	.needs_kconfigs = (const char *[]) {
>>   		"CONFIG_QFMT_V2",
>>   		NULL
>> @@ -185,11 +218,11 @@ static struct tst_test test = {
>>   	.test = verify_quotactl,
>>   	.dev_fs_type = "ext4",
>>   	.mntpoint = MNTPOINT,
>> -	.mount_device = 1,
>> -	.mnt_data = "usrquota",
>> +	.needs_device = 1,
>>   	.needs_cmds = (const char *const []) {
>>   		"quotacheck",
>>   		NULL
>>   	},
>>   	.needs_root = 1,
>> +	.test_variants = 2,
>>   };
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
