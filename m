Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05A1C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 10:50:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABAEA3CA72C
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 12:50:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E1233CA5F6
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 12:50:32 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C22492010F0
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 12:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1651143032; x=1682679032;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CdC3RI7mn7ZqtDR9Rb7pe6HNAugC7KaZOTmchcI8+uE=;
 b=pSsUgzQng7b9giBBBihvJ14kdU1h1XmIYwrtCf/yR/J2+ENxHdHAvoSX
 /+kcqC1RjfexzoaRZe6imuT0tNWyHUcbNRh3ndbQUgvUhrmeWbLalk23b
 kFO/DtqjNQ2k46dYDQwjNvn88P1riF8WxukQI0JQXILybI4rmDujsY3gN
 VIs17dHvlaLosV+ZnVYvSMrSmdwXlWCBzH66ab6u1KgqWL1B4O3/8v6NU
 Vm+5KzrkXdT/bnxvmpmGJLDHzkKqvN2m7tTAX7Ya2k+vj+HPO6xak3eRb
 X0PftwEl+GAUfgRiGtptkHZplGdd7tMLhYeTa+mNkfW+MoXs8+bBGZTVx g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="54850545"
X-IronPort-AV: E=Sophos;i="5.90,295,1643641200"; d="scan'208";a="54850545"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 19:50:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlVvRsJ2m62BCQDkgJEKx322qSZMcv1nHDaqNdQcxOyzOlFGlaCJNkHhoKx3Tz5oAakgIuYJBAJOnesLDm8Xv2lVmd66/JMPQXf1DMLsUoRI3rUILKaU+BiLIMP3qFnwnffeE3kZWkQAxf9fkwTZncgE8zeplEu9p7ne6lz8emi6k3R7WtWJ3amuux+V/61U/AWJniNpIFPqqx+2Mj/TQHro1mZm5L77HXG8GDP08cRdqXX/PswU1pqdyL/wpD2jr+TUeikQZmEPJiNQzXLXjNRqVLQ0XcoHXm9b5hu7PuOo4Hdxt55eeN3bPtpIaiPfAywsQYF8IowvGfWBSq0pNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdC3RI7mn7ZqtDR9Rb7pe6HNAugC7KaZOTmchcI8+uE=;
 b=mLVvOwCOYCuFYaa//enWY0bKzpuhVxVUEJO5Pof5eYcfKTqp8BOOwbcWHf/MpefbPrs/XjOCiFtSQHomc2OIDjF45Nm2C30nKVLB1XDGqrxCypz1714obJQI8abKJUl+YgGwHHXYZG4ff60+1XrjT0sLWmXZZj0QZ2rDTZmpkqzG85poGOVDBeu+wt6FcosXZVRivPR//71X5sK42klKFnqFKXabub2YmiaIzN73rKlpgOqRkXaibB47nqIg1yGSxspbshcEF1SWqH2CtZmooOH5tHyrtmlucqFQYxFC8crwdCJ4imVmHy3eDm5vOm7LuBqnYdz+PjDv9QfC4BRqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdC3RI7mn7ZqtDR9Rb7pe6HNAugC7KaZOTmchcI8+uE=;
 b=f+HwkwC6c6PuCZO3sCBr1E0p1fTOzir7gMGHu+df1W2cEIh5Y/UpneCHYOTjU26rrc2ayVmwX8YYoxRbFkBAxgo/6NZ0R9xJ3ZNEZQfEwZz0IsBvdrRgLLM3omnk9QAA0IrJv5RKB68fLuOMiiNDpIn0tuMW7juVG2rR49ns/tw=
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com (2603:1096:604:f5::13)
 by OSAPR01MB5108.jpnprd01.prod.outlook.com (2603:1096:604:6f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 10:50:26 +0000
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::c9fe:6f62:c297:b2b]) by OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::c9fe:6f62:c297:b2b%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 10:50:26 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v4] syscalls/mount_setattr01: Add basic functional test
Thread-Index: AQHYWj+CuTxLG3l8TEiLVEp/y5xZ2q0FJDRQ
Date: Thu, 28 Apr 2022 10:50:26 +0000
Message-ID: <OS3PR01MB6449FFE59AE8696A751D2D6AE6FD9@OS3PR01MB6449.jpnprd01.prod.outlook.com>
References: <20220427083814.1100-1-chenhx.fnst@fujitsu.com>
 <YmlNmOQ2okZgpOlo@yuki>
In-Reply-To: <YmlNmOQ2okZgpOlo@yuki>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 138f62bd-0ad5-4fc0-83ed-08da2904e784
x-ms-traffictypediagnostic: OSAPR01MB5108:EE_
x-microsoft-antispam-prvs: <OSAPR01MB5108C13772EE200566B74A64E6FD9@OSAPR01MB5108.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTs9aaop0ssKKoqtwCBX6w1Q0o3orbYpDO7DY8dbG8DVHKbUDAoqte7QSW425ckl5qupkVp/VaistTvJJlAZ/GQTY99T6NuHG77Sy3bjbzida/v0E5qkwPlGUbEPFKs/Af5m3+T6FY2sEQTz8EJVFrn+cXMQ85Yx8ZW4JG5KdmHRPNNIzQXezcO6xHFoWUKHDLAeOImNJ3X674QKy8GD0/mR0lP2P/tDIGAFegHo/t0+GwfHROqY9PWlKF2OWzqs0Ws+8sSf7tPLgBDAjkH+x7WVqQ9fxtL/7nbucI/qbUgw1uzXpCPzctQSeMq7wEk3kor9hRp/SuuiU5K5uJDLaYMcZIdQkDdQ280hjtSHa0OVvuriN6CdOVz+am9EM/BupvCWRN9L4+JN0Qj9kZVUJ7GMjhcYbYcGdFlMmU8ICSRZO9cDThFk6tG5rlFwXpw9pIhP/eOBMnnr5Cjbpxn8ac3hUZJ82+Ao/PiUTRxtiLAY79aWNqBJTfWwjdNu8BeSVwQJbedhA+WHvn6HY8pSns+myBmQvpix/+2m4kbo/CZPG3juXy8ZKCwIM5CnT66ZyVwRs6qiV4q68ibqSP9RrvIkLeUb4AkWQ5WnXTuUb0znFj0pKy8jNxFYRtBmPXbTDBHwiKv9/oqi+LE8FGt0px7bFFxwhrNk9Jh/+Mi6wZ3n9qW1TJr+0MwFg5S6+La5r1SLlzT0YAJaPxcpJi3huA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6449.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(186003)(86362001)(83380400001)(38100700002)(71200400001)(508600001)(55016003)(82960400001)(6916009)(54906003)(224303003)(8936002)(122000001)(107886003)(85182001)(26005)(52536014)(7696005)(6506007)(5660300002)(4326008)(33656002)(2906002)(9686003)(38070700005)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RS9MWHJLVTY2ekl3UEFxUEpkdnEzM29IOUN2a2FMS0pwWVpXODBqM2p2QWMy?=
 =?gb2312?B?WU1Ed0hSdWc1SmMrbm1LMHVJVlAyUWpDanpSN2p3UFRka3o5MHdTdDZBa3Y5?=
 =?gb2312?B?RHBTUmJyVGZXeldHMWRHREloQlBoZ09FdlZtTldFS3RjNVVjQjBwQ25oNitE?=
 =?gb2312?B?U08rOFlXMDRmNGVIWmFZSVkra0Q0RmNmb3lCbEl6NytTSjBlek96UzBnakRV?=
 =?gb2312?B?NHZWakN4ZmhsdGxYSVJzVjE1bFVhM2Z6WjBKdW54YjJ5K1BzQ09BV21FN0hV?=
 =?gb2312?B?VTMyM1FtQXI5Mmg4LzZ3dHd6RlR1dmdyMExxa1pZRmFLOEZVeFFVL3cwbCto?=
 =?gb2312?B?ZkNma1g4YjNvQ2VudmJNUzVWc3JRMW9HUkVZc1FuUnNrQ2JIejN0WWVIRkI1?=
 =?gb2312?B?akxoM0FkWXYwalcwU3BZM1dxTERjMXR5SzFJOGQ5S0RIdjRkcGpmaVpQQzZE?=
 =?gb2312?B?RWNSK1NrNXl0VUNKTDJPMTdZSllTL3N4VFlnL2UvNmpXSTZpTDFGWHJzQlZF?=
 =?gb2312?B?VmMyd3R6UjFXUEpXUHhabUtyb2p2MkV3OEs3engwb1VMN1A3b09vc084QTR2?=
 =?gb2312?B?ZWNzM2t1OXVKNTRRaTMxZlhKbjgvb0xlTitFeFBsekdhbXpwd1gwNk5hay9n?=
 =?gb2312?B?Mm1lLzE0aVRvUVdBV2Y2bUswY1N4TU40RmFSSnVPcTVGcFh5YUQ0MG1RZU9H?=
 =?gb2312?B?eDd0QUlweWQvdXhZNXJnZHgrdTZ6WGYzNUdxRHhqTmFnZnQ1SnBlaTA0ZjQ0?=
 =?gb2312?B?RUtMalVLdGYvUGJiTGY4bXB1bENQV29YOXRxTVM3ajlHd0xtbEVuaHhlQjJ0?=
 =?gb2312?B?UDBXUmVZSERKZERPWUo3RVc0aEo0M1NjeW43YUZkZTM4WVpSSkU4czZYdEZT?=
 =?gb2312?B?TDdxQVRDNFM0NVc5SUVrZjZOeHMvNXZqM00wWmRYVXVYMFFlUjN1WTdnV1Ex?=
 =?gb2312?B?UWxpQmJtdzNSZGNoRVdpTUpoY0pQZFZ3QWVxRGxQRngvR3VFWDBQNDVYc2xW?=
 =?gb2312?B?UU5VQlNFOWdJcGM5bDZvZG4zczhQcitoeTNCYUdmTlVubE45ZUkwYTI2dTFN?=
 =?gb2312?B?YUtZQTNBTU5WU2Y4QmtkWjBHaWZYOEo2R2d4TDlXU0tKTW91ZWxVSmNmWmFq?=
 =?gb2312?B?dkM2b09jNXVkeXBTOERGTU0vS1NsRkczeG1WWHVlQ2w3Ynp4a0FXaGNTRXIy?=
 =?gb2312?B?WUF3RnJnT1RxLzVPWkR6WS9LSjZYRmIvbSt5WkRkRVdwYlFiSTdCMnRyS0p0?=
 =?gb2312?B?Z09oQ3BsamllK3BzQ0d6T1BoOFUzL0dMeVUyQjRtUFQ0bHpzcnZsblRkdHhE?=
 =?gb2312?B?QjhsajduNGFPZkhFNlQxaHZhRHQ0OFpYdXZXOVVKeUEzSjFyU0o0N2VsbHBz?=
 =?gb2312?B?cldDb2ZZSVlRS0RWNU9qK24wR0l0QVFWYXBNbXZ4dVpsbWkrNDFzckV0VEpq?=
 =?gb2312?B?ZC9uMk1scHNrRWppa1czNzBPSk4zeUhLZXJVSkpGeHkwZzNTMW1oYVQreTQ0?=
 =?gb2312?B?dHRtNGNsWHNrZXZ6bjI1bXpoYTRPcTRYM0huaVRtZjFUaHRlY29FWFdBeXNP?=
 =?gb2312?B?WkQ1NjQva0hPZ2JGNitHS09PN0xvOUVSSzlEczUvUVFSbUVXSzBJNGh3b0cr?=
 =?gb2312?B?YVdaT2tZL0NNTklUcE5hQjhycDlGYUdoRXRDVjh0UFJ2L0lJbnVLWmlCSExk?=
 =?gb2312?B?NzBJaUhCZVZUQU1lYk50S3JaQkFaSkx0WGFCR1BWSDA4NkRkUVlMSkpFSG1K?=
 =?gb2312?B?ODcveklnYTZUcTA3QUhFeFV5TytBMXFlZ3dpRnpVNjlxSXcvUXl3MDU3bEVk?=
 =?gb2312?B?b0dkSEdTQTdOSWZGSGdMaEgvZTJSZTZoR2JJV3YxM1I1cWRsV0JRejY1OGFj?=
 =?gb2312?B?QUtCNkxmRmdjcmx2ZWJmRWJMeGVLSStzdXREQ2tFWlJrSmJiUnRqN0VzWTlP?=
 =?gb2312?B?RmgzcWdVakgxTTN3RmJMdE5saFQ5SS8wV2VZaXIzbVlRYS91dmVPV3cxN3cr?=
 =?gb2312?B?RHp4dmpxbHFMR0tiUTl4VmpZT0c1ei9ZdFVJNFVNNHdsQUtNZFUyWGxzSEVE?=
 =?gb2312?B?ckZxSGVFS3VyV25tays4TS9xVjdWQnVzcVRSMzJUaHFJdmJLSytpZTlDMEZw?=
 =?gb2312?B?STR3b2dlaExzaVBHRUdseEpQZS8yYzJaaE1KV0JBcW9LeFJzRGZxYkcvUGdo?=
 =?gb2312?B?YzArdS90RDd6VXMwV0h0NHFBRVlJYjRZaEkrZi9MeE5iNE9tZjJaSklxb21N?=
 =?gb2312?B?VnhaYWVHUG1VU0VxNzFZcS9vOTZQQ3BNdk5DRmpZbGZUMW1Jc21Ta2dPRGd6?=
 =?gb2312?B?KzUvSW9Wazhjem96NlNzQm1CZExKdTBTNVRjZ2hsVHVBT25haWxrUT09?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6449.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138f62bd-0ad5-4fc0-83ed-08da2904e784
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 10:50:26.7019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3vt0NCttplc6sS3zFyUEbU1qmXhVGz5rJSqQp+4Z3ryrUVxKL0Id7JzKc1iNT6xZiBCGFtW0FjgrVEimsJf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5108
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?u9i4tDogW1BBVENIIHY0XSBzeXNjYWxscy9tb3VudF9z?=
 =?gb2312?b?ZXRhdHRyMDE6IEFkZCBiYXNpYyBmdW5jdGlvbmFsIHRlc3Q=?=
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGmjrGFsbA0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IEN5cmlsIEhydWJpcyA8
Y2hydWJpc0BzdXNlLmN6Pg0KPiC3osvNyrG85DogMjAyMsTqNNTCMjfI1SAyMjowNQ0KPiDK1bz+
yMs6IENoZW4sIEhhbnhpYW8vs8Ig6s/P9iA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+DQo+ILOt
y806IGx0cEBsaXN0cy5saW51eC5pdDsgcHZvcmVsQHN1c2UuY3o7IERhaSwgU2hpbGkvtPcgysDA
9g0KPiA8ZGFpc2wuZm5zdEBmdWppdHN1LmNvbT4NCj4g1vfM4jogUmU6IFtQQVRDSCB2NF0gc3lz
Y2FsbHMvbW91bnRfc2V0YXR0cjAxOiBBZGQgYmFzaWMgZnVuY3Rpb25hbCB0ZXN0DQo+IA0KPiBI
aSENCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4g
PiArLyoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDIyIEZVSklUU1UgTElNSVRFRC4gQWxsIHJp
Z2h0cyByZXNlcnZlZC4NCj4gPiArICogQXV0aG9yOiBEYWkgU2hpbGkgPGRhaXNsLmZuc3RAZnVq
aXRzdS5jb20+DQo+ID4gKyAqIEF1dGhvcjogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBmdWpp
dHN1LmNvbT4gICovDQo+ID4gKw0KPiA+ICsvKlwNCj4gPiArICogW0Rlc2NyaXB0aW9uXQ0KPiA+
ICsgKg0KPiA+ICsgKiBCYXNpYyBtb3VudF9zZXRhdHRyKCkgdGVzdC4NCj4gPiArICogVGVzdCB3
aGV0aGVyIHRoZSBiYXNpYyBtb3VudCBhdHRyaWJ1dGVzIGFyZSBzZXQgY29ycmVjdGx5Lg0KPiA+
ICsgKg0KPiA+ICsgKiBWZXJpZnkgc29tZSBNT1VOVF9TRVRBVFRSKDIpIGF0dHJpYnV0ZXM6DQo+
ID4gKyAqDQo+ID4gKyAqIC0gMSkgTU9VTlRfQVRUUl9SRE9OTFkgLSBtYWtlcyB0aGUgbW91bnQg
cmVhZC1vbmx5DQo+ID4gKyAqIC0gMikgTU9VTlRfQVRUUl9OT1NVSUQgLSBjYXVzZXMgdGhlIG1v
dW50IG5vdCB0byBob25vciB0aGUNCj4gPiArICogICAgIHNldC11c2VyLUlEIGFuZCBzZXQtZ3Jv
dXAtSUQgbW9kZSBiaXRzIGFuZCBmaWxlIGNhcGFiaWxpdGllcw0KPiA+ICsgKiAgICAgd2hlbiBl
eGVjdXRpbmcgcHJvZ3JhbXMuDQo+ID4gKyAqIC0gMykgTU9VTlRfQVRUUl9OT0RFViAtIHByZXZl
bnRzIGFjY2VzcyB0byBkZXZpY2VzIG9uIHRoaXMgbW91bnQNCj4gPiArICogLSA0KSBNT1VOVF9B
VFRSX05PRVhFQyAtIHByZXZlbnRzIGV4ZWN1dGluZyBwcm9ncmFtcyBvbiB0aGlzIG1vdW50DQo+
ID4gKyAqIC0gNSkgTU9VTlRfQVRUUl9OT1NZTUZPTExPVyAtIHByZXZlbnRzIGZvbGxvd2luZyBz
eW1ib2xpYyBsaW5rcw0KPiA+ICsgKiAgICBvbiB0aGlzIG1vdW50DQo+ID4gKyAqIC0gNikgTU9V
TlRfQVRUUl9OT0RJUkFUSU1FIC0gcHJldmVudHMgdXBkYXRpbmcgYWNjZXNzIHRpbWUgZm9yDQo+
ID4gKyAqICAgIGRpcmVjdG9yaWVzIG9uIHRoaXMgbW91bnQNCj4gDQo+IFRoZSBudW1iZXJzIGhl
cmUgYXJlIHVzZWxlc3MgYW5kIGNvbmZ1c2luZyBJIGJldCB0aGF0IGl0IHJlbmRlcnMgc3RyYW5n
ZWx5IGluDQo+IGFzY2lpZG9jIHRvby4NCj4gDQpPSy4NCg0KPiA+ICsgKiBUaGUgZnVuY3Rpb25h
bGl0eSB3YXMgYWRkZWQgaW4gdjUuMTIuDQouLi4NCj4gPiArCWlmIChvdGZkID4gLTEpDQo+ID4g
KwkJU0FGRV9DTE9TRShvdGZkKTsNCj4gPiArCWlmICh0c3RfaXNfbW91bnRlZF9hdF90bXBkaXIo
T1RfTU5UUE9JTlQpKSB7DQo+ID4gKwkJbW91bnRfZmxhZyA9IDA7DQo+ID4gKwkJU0FGRV9VTU9V
TlQoT1RfTU5UUE9JTlQpOw0KPiA+ICsJfQ0KPiANCj4gQ2FuIHdlIGluc3RlYWQgb2YgdGhlIGlm
cyBqdXN0IGp1bXAgdG8gYSByaWdodCBsYWJlbCBhcyBJIGFza2VkIGluIHRoZSBwcmV2aW91cw0K
PiByZXZpZXc/DQoNClN1cmUuDQoNClJlZ2FyZHMsDQotIENoZW4NCg0KPiANCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gew0KPiA+ICsJLnRjbnQgPSBB
UlJBWV9TSVpFKHRjYXNlcyksDQo+ID4gKwkudGVzdCA9IHJ1biwNCj4gPiArCS5zZXR1cCA9IHNl
dHVwLA0KPiA+ICsJLmNsZWFudXAgPSBjbGVhbnVwLA0KPiA+ICsJLm5lZWRzX3Jvb3QgPSAxLA0K
PiA+ICsJLm1vdW50X2RldmljZSA9IDEsDQo+ID4gKwkubW50cG9pbnQgPSBNTlRQT0lOVCwNCj4g
PiArCS5hbGxfZmlsZXN5c3RlbXMgPSAxLA0KPiA+ICsJLnNraXBfZmlsZXN5c3RlbXMgPSAoY29u
c3QgY2hhciAqY29uc3QgW10peyJmdXNlIiwgTlVMTH0sIH07DQo+ID4gLS0NCj4gPiAyLjM1LjEN
Cj4gPg0KPiA+DQo+ID4NCj4gDQo+IC0tDQo+IEN5cmlsIEhydWJpcw0KPiBjaHJ1YmlzQHN1c2Uu
Y3oNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
