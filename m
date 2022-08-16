Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DC2C2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 07:54:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 325613C98BF
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 09:54:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E72BC3C01CF
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 09:53:56 +0200 (CEST)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B6106005D8
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 09:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660636433; x=1692172433;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rC+gDNi/2NgBrZg/FLBySTAXZF+lHD79+7beS02PubQ=;
 b=KcGgiL8Iau/60oZptVO77bVzfSWaEXvsEWVvzByXzL1Hrk3tDx8/fvAT
 KWaMIprATG+98EDZaBniaA0pW8i8W4D+9VtyGhDb1gHbTNKEQ2fMniBYa
 GIYEb0ZQUzUlfp5hw9boZDX29APf8NBgS/19R8PcQ9cWJmd77mGjp/FL5
 OGy0wLoTm81+CRPzyR3ToBBko5IJCBkTHK2clokTx3JylTu0sZD3oFJ0G
 WTHc4IEGFvv9UOJ9FI3umDVYBECUz9G+WLc12JuEgHitI7NU6heKEV+o8
 dg16xOXc6O/XZgWE1fKKMR8Fe0q935bufVOeTDyoQE0eMeDQteRMXwFwn g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="62968290"
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600"; d="scan'208";a="62968290"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 16:53:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5WD9/w1QGYaZcIedmJnjuk3WlEI8EAi0gzb4ewEPb4V/cG825M1EMAbKPY1+gnzTTe8xo5JxXuMQYxJG5N2oYDhu70AlhocAx4O/dPkXXAsiWgECvlXbfqgOA02WINalg21PJHwTwNvoudq3hg4sMS0b5WFVk/niiI4VhA8v0aNfazNAo+vz7zWruwxb9KZa/xUdiy45vQims3MAX6BqyGT9R1xHQorQKwNkx3BhqdUPgdx/kvo+72IbmtVfQ+ioQpnvJLQ6hHNfcJgGdtNVXioYTW3tfWPo5zLnrT2PZFo3Zh+rQdQJhPaVOajqQiV/jo18lJqRqvTi1xgAFQxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC+gDNi/2NgBrZg/FLBySTAXZF+lHD79+7beS02PubQ=;
 b=bA7EG8AFR/wDWenggPd6WHww7caN36QbjpFV/KvUbVsI6yUAryhYuEBqhr+KRleNuJrnnYpdjT4MZMRIIeE0UEjb7OAKgYqFMWbU6UE+87wuQg5CERmrmLz9p5JGk1cbAT3zchl8hLQXyYNmlswhoM8HZkDi8yFovi90dtqyDtd0SbFk+wfb3T8kiPlPftktAxrQ/BFCSCn5LmhgNaFNWYrRbMq5cZz02I0dfeTbqneFBv7tKY5fmcP5iBt7EpvvM4abvzG1FB2ut8jBvYTgw7GIpSoK853J4zhp76ScZ8fqAZEAtJwPmcy8Dyxh0eyfHCbffZHOvR4lbgPyXs8Krg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB3508.jpnprd01.prod.outlook.com (2603:1096:604:53::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 07:53:47 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 07:53:47 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>, Khem Raj <raj.khem@gmail.com>
Thread-Topic: [LTP] [PATCH 1/2] Add configure check for sys/pidfd.h
Thread-Index: AQHYsS9EGiOK7a1Js022rssN+moOdq2xCRoAgAAwJYA=
Date: Tue, 16 Aug 2022 07:53:47 +0000
Message-ID: <90ec1db8-b1f0-8831-d13c-b02b9653fbbc@fujitsu.com>
References: <20220816051539.2948547-1-raj.khem@gmail.com>
 <CAEemH2d24Pgvkz+n8rrF+ATkU3vb9f7-_ageZ3sOge0p37=B0w@mail.gmail.com>
In-Reply-To: <CAEemH2d24Pgvkz+n8rrF+ATkU3vb9f7-_ageZ3sOge0p37=B0w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46727ef5-333c-4c5e-94d2-08da7f5c7318
x-ms-traffictypediagnostic: OSAPR01MB3508:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLRFBxWhKRJEpbOQB7Qgx06BK1t5kzHwt2FcAp9R00EkkxKFzLtdxQyZKnyuV8qPwJPy+UVKPPBLRo3xRnTJ9xKKF72i+YSKfQzWdpnQ9Xvx7mWGS8l6E2GF/xV5y49x3WoMtuIFjsq1tDV+p0x2xZUdNuSSevlgUzLwazvTYQD7doTv5yjx0H2AgxBtbD4SfqBJvJdVK8e5wTNll454qQZVf1O6c+hQwJ2xNRBnkZMXaatX9w7YWzrSrPDYLJKt683jcwxaIRp//qNCLR4YrE1lwIGWV8NkFHRtomvv+xcTqGjoIYifYmsXiQUXP07/9vPD/vKgovabmE9MjV7q6mawT+PP2vZsSFi7Wx2uprFAnHNbC39/Xcp0F76xRbFcRQ+nFPRXGxFYVx/US5Hew2eeYAAvqk6I/j+09htn/ArFsqaFla9EdMeNQPEMdQP56OMJ5mm1fnG+diDVWg7yRSZAtbOL8+BqM059FRoaqag+2FKE7ek+OoOBMLrsx7ycrDiaqw4Aj31ZhlITDLe8pvqBk4P9hQyY3OkRuWukvx4GlSBZa12HSE5ZsW4K5T1W66xbcfzI96N9bSMZCN+7qCh6pr+lgd0Wq67GSMeoLpe9IiHzVhy/J7maUnHGqyFKQ0BCwRo/cJQfGpDKpQcxy9HijPtstj59XlT7oaYmXKXhWU/i+jkavi012mWceAJ2jqjPSbD8RMo+gXd2fBN4JarloWzM7TIPV2zqhbEAwROb3HN7AD7PSPVo/C/vt2xnhKLMtdCoTW/rnCdM8iZvpx0aycfTWuNcszNf2TUbIulFb374mUI9RraZXcCDULrCeU8NAWtTcaxyVKwKet88oOXIP9t3iKqfaSbI6OYx6NDJf3hdLiypj0mh3PbEsJZhfQb/SvUwK6hpOd9ds+yNySD+hLuBdBjbrgLqX1N9HG9KqfYArnJiU7252SNuZ9AD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(38070700005)(83380400001)(186003)(82960400001)(31696002)(86362001)(91956017)(122000001)(38100700002)(2906002)(966005)(8676002)(76116006)(1580799003)(66946007)(66476007)(8936002)(4326008)(66556008)(66446008)(5660300002)(6486002)(41300700001)(478600001)(85182001)(6506007)(6512007)(110136005)(2616005)(26005)(31686004)(316002)(53546011)(71200400001)(36756003)(64756008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHd4ckZmNC82T2N1YlVHZVhOL0kxSjQ5cVFTbGUwUHBqc3J3L2hXUkhsTXFU?=
 =?utf-8?B?QUpKYXlpM1o3YjF3TXJKYS95aXdsd3daN3JpemtRQmxYSFZPWXU3VG5Bck4y?=
 =?utf-8?B?a0wyTWtPcGpLZk1KMVR5Sm5PcmxMVDl0dU9WOHBvdFpJY0dlZzJocEVSZ1RR?=
 =?utf-8?B?ZG9XUzVTUnVDR0ZyTk9tRmozVDVRSldvV2RabmNIbXdYRVc1dVQ2cTFBazdu?=
 =?utf-8?B?VGR3VXdYTktQUm52Q01DRDBDYjdqaWJoS0VoVlJHR1Mra0hRZ2FYd3NHY3N2?=
 =?utf-8?B?WVdaM2drN1VYTFQwUGpYRVhYUjZFR1E4eEJiWC8wYTJ4a2RXR3BpcGhHeUwr?=
 =?utf-8?B?Z3RpdjJFTlk4OHR5NE9aQ0RoMWZ3RE1LWFAweXlrQ2dmNlAxaFJJT1UvWHlk?=
 =?utf-8?B?OW5yZDc1NUZPWDlNVjhMUXNWVjJhdGRkKzBWQlUrRXluZkRqTEs0YTNHWjll?=
 =?utf-8?B?eVdlbUkxOENmNHJOTjRWV2hCVjlseDErVGwxaE4yc3RGVGladUFnem5uV2o4?=
 =?utf-8?B?MkZhQVdWbDRXRHBQTUY4enB2aG4zYmlHdFBFTXJzWHMyRUxtbk1TZ3ljd0Rm?=
 =?utf-8?B?R3RHTTFPaFg2cllqMUlXM3Q4MmUwMEpqRW5zSnpkVzd6aHhYQ1pNNGlxMzFZ?=
 =?utf-8?B?QmV0UW8yNDRXMkQwZmJTQmlFdkoxa21McEZ0VlRGUDJ3c20vMDUxM05ZTURG?=
 =?utf-8?B?Mi9xcDlMaFplVythbW1BMHpRbzNNaFBrYnM0MFA5bVhKZzh0Smt3L2hyOC9W?=
 =?utf-8?B?NkI0R2FVVkRkZnA4L2V6eE9qM1Zsdldpc2hLSEU2ZFREZ2JmMDBmYmlxamFx?=
 =?utf-8?B?a2tUZHFNVS8vZkhvekYrOWlIL1FML3FRMENOQ0Z6dTR1QmIzYzViV2wyOTlp?=
 =?utf-8?B?QTVGekN3cjZOc1ZpZVNPODVGOXE4WVlROG5XR3dRNzBBVGxFeEhPWU5JM2pQ?=
 =?utf-8?B?clRFQ2l3MlFzOGZoUXVVVkJJeERRRWpLb0U5eFJhelYxWXQ0RXZHSm1Pczgv?=
 =?utf-8?B?QnM2YnFsTzBwa2grUTFwVFVBTFowRjRqZ2Zsc01POWhJQkR4UVVDWFg1aEli?=
 =?utf-8?B?d00xdkVGTzY3aDJaUzlsdGpTa3dLOXd5ejdJZFMzL1FmeEVGdGRLK0ZJVXZs?=
 =?utf-8?B?TU5GSmhoenQyZllLZ2QybDdxdDUwTFBLb2pSRWFUY09GcWdvZnZsdks3Lyts?=
 =?utf-8?B?bDFNQlp1bVpnTVFvc0hLNi9DMmwrQy9adGF2N0EyeFdJNG5ib3hMY2o2RWJx?=
 =?utf-8?B?Z1Y0Umswenh0UHNGdmZvL0NxZTBHdDR2WjFXQi9DQSs1WktwUG94Skh6ZDMz?=
 =?utf-8?B?VnV3QkNlS0hpSTVYK3lSNXhYNU9sek84YTFYTzErWFd2bkFpVWkvLzFEU0Y3?=
 =?utf-8?B?TC9zYXg4OHdEMXVMK0V6MS82dnlGaTBNZTFzRXRXYkIvWDQ2MWpua2oweXFx?=
 =?utf-8?B?emcySGJtQm1HNEhoK0RaUXpnN1FzVm9VSmplakt0TDNueWlJeVpuQmpsd2NP?=
 =?utf-8?B?NkxnRGFOQnhMUjZ0dkNBelVYK1BiMlh5N2dJOXplZnp0UG5BbGk4VnJ3MzRM?=
 =?utf-8?B?YWh0Q1dLbXpER0xFZ1BJWVZZZkpmVThFeEo3WFAwclh3VUZSVW1UemwzbXBE?=
 =?utf-8?B?NGpacGdWbzhZMWk3bEZsTi91Y0pPQ2JycityQUViT2VRQ1poQVFMWHIxQVNZ?=
 =?utf-8?B?cWg2Z3N2bVJNVm5kOE9xWmRWOTRXQWtJNWhRdS9nNnk4dDF2VHpTcENhcFBI?=
 =?utf-8?B?VHkzc2h4Ti9KcmFHR0NtbW9VNnd2ZVg1Vm84ak5MSjlPUXdlYVkzNDlPN2pq?=
 =?utf-8?B?WndMNDk1YjRBaDNBWU5WT0hId3g4MWc2N0t4dE5pQ3NLa0tnaXpQZnU0ZEVr?=
 =?utf-8?B?RE9mOXJvaWFhVEhhenRqcGV6NXQrSXFnSVRPdEVha1JvSVh4aGJMd1VGckxF?=
 =?utf-8?B?dXBHS3lJaXBuWGVsRHJRUGpjcXl4MElERk9BbkM3U1lvV016bjRxMW9sWFdk?=
 =?utf-8?B?cEpUUzlFay9BV3hHMnp5amUxenRrbWQ0cGtzMGxJU3haZ2tUTmlmcHI4YTRl?=
 =?utf-8?B?anFQVjhPYWlTR2lMQzY5YnV4QUtwMVZHSVFBTUtVZWhMa0ZFaVlYMWhkNzFQ?=
 =?utf-8?B?Z2w3UWhRK0xKRURVWmh2NU54VEp4dmN1NVdVL2ZmYkRKTzdMVzlKbk4wUFFZ?=
 =?utf-8?B?SEE9PQ==?=
Content-ID: <88C424DE1ACF274B858AD4CDC2823A9D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YEGlgHbN+JPszXAXpAuMpMZZYmDbP22/wEcaxsGycxaIucO0qdZPyIS2reRQR6H/IUSvUuN4MzxeKUxTa4J20OL+pgG550kFwd7Na4f8zqTI4dFZvAxi18Lh0M6wGABPrXijMbz07fPpRLIWMrgtrsL8WJ2EEmK8lr+Z14nnanXBpOx3ARE0V09XDGbDDk2ffpeYNHdgtJbGEEGnu7axGVR/SeNlajrqnnLRIyN6BENjrDOdPnf2i/bia7iItraGhiT9aTJi66XhHcOI8tk+CG7CG86x7eDH+Tk3fSEUZkjYofRyl4fCWpkFpGsSJuKjYA1PGmyZ20lOTzIBOJ8BG4n7j2Kg0eLRGe27eadfk+pUk6XMvpKELRtTgkKe5VbNpKaIfw2Aabsai6LM53twk6HmaCXG3gLhUOKrWTN+1DaF7R4nXxdrCroOmc5DQTbnvI6Ye9fCyWG8o+U6TxbCSfAlut+1nbi+wfU50hzgRXoEsQ9ZJ6peKceUPvymGQ6hxL5ZYM/zWB+AYmdKe5QuHXcmc2e603KFKUcyJCTq0wtWRCcEUbT3RqnlBjGMiIi33AZ9nx8NeV9ybdfeac6dKgBJMWfQdTsPSsLL6EArTTC/0jLB4gjJzagMEfNWgu+exnCxkPt9APU2tbRDClJ9kicEeVhzUbSUbuAJclUXHh/eHmjPuAnq0+YWMCHJn5QeAtmJE6uzVxZgUO8Gyf+bmIW8hJDr3eLqF2UlIf6928QqqyVxHGmWNBofiJdPA1nU9KsMRH26ZkuGOK4sOPSVCSFz5nE9qX2NkkTI27Qu5JKoyPLp/yxCTVoiB+hxNU9X
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46727ef5-333c-4c5e-94d2-08da7f5c7318
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 07:53:47.0431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzidJqp3p108JsjX5cwzTBO5VO/PNI00zvGWcWUvMoSx9PC3yLa49GUH4BLw1QzbaqaRyTgXS2X4wUvF8oCLGgyaU25B6r5N6OOctpzGdjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3508
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Add configure check for sys/pidfd.h
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksIEtoZW0NCg0KPiBIacKgS2hlbSwNCj4gDQo+IERpZCB5b3UgZmV0Y2ggdGhlIGxhdGVz
dCBicmFuY2ggb2YgTFRQPyBpZiBub3QsIGNhbiB5b3UgdHJ5IHdpdGggdGhhdD8NCj4gDQo+IEkg
Z3Vlc3MgdGhpcyB3YXMgZHVwbGljYXRlZCB3aXRoIGFub3RoZXIgZml4KG1lcmdlZCkuDQo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC9kYmM5YzE0Yzky
YTVhY2Y0NTBkMDc4NjhhNzM1YWM4Y2Q2ZWM1YjkwIDxodHRwczovL2dpdGh1Yi5jb20vbGludXgt
dGVzdC1wcm9qZWN0L2x0cC9jb21taXQvZGJjOWMxNGM5MmE1YWNmNDUwZDA3ODY4YTczNWFjOGNk
NmVjNWI5MD4NCj4gDQo+IGFuZCBwYXRjaDIvMiBzaW1pbGFyIHRvOg0KPiBodHRwczovL2dpdGh1
Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9jb21taXQvYjg1N2Y4NzIzZjMwYTRiOTU1NGJm
NmIwZmY4ZmE1MmZkMDdlOGI2MA0KPiA8aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJv
amVjdC9sdHAvY29tbWl0L2I4NTdmODcyM2YzMGE0Yjk1NTRiZjZiMGZmOGZhNTJmZDA3ZThiNjA+
DQo+IA0KSSBndWVzcyBLaGVtIHVzZWQgbHRwIHJlbGVhc2UgdmVyc2lvbiAyMDIyMDUyNyB0aGVu
IGFkZCBoaXMgb3duIHBhdGNoWzFdLg0KU28gdGhpcyBwYXRjaCBzZXQgc2hvdWxkIGJlIGRyb3Bw
ZWQuDQoNClsxXWh0dHBzOi8vZ2l0aHViLmNvbS9vcGVuZW1iZWRkZWQvb3BlbmVtYmVkZGVkLWNv
cmUvYmxvYi9tYXN0ZXIvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL2x0cC9sdHBfMjAyMjA1MjcuYmIN
Cg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQoNCj4gDQo+IE9uIFR1ZSwgQXVnIDE2LCAyMDIyIGF0
IDE6MTYgUE0gS2hlbSBSYWogPHJhai5raGVtQGdtYWlsLmNvbSANCj4gPG1haWx0bzpyYWoua2hl
bUBnbWFpbC5jb20+PiB3cm90ZToNCj4gDQo+ICAgICBVc2UgaXQgdG8gaW5jbHVkZSBuZXdseSBh
ZGRlZCBzeXMvcGlkZmQuaCBpbiBnbGliYyAyLjM2Kw0KPiANCj4gICAgIFNpZ25lZC1vZmYtYnk6
IEtoZW0gUmFqIDxyYWoua2hlbUBnbWFpbC5jb20gPG1haWx0bzpyYWoua2hlbUBnbWFpbC5jb20+
Pg0KPiAgICAgLS0tDQo+ICAgICBjb25maWd1cmUuYWMgPGh0dHA6Ly9jb25maWd1cmUuYWM+wqAg
wqAgwqAgwqAgwqB8IDEgKw0KPiAgICAgIMKgaW5jbHVkZS9sYXBpL3BpZGZkLmggfCA0ICsrKysN
Cj4gICAgICDCoDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiAgICAgZGlm
ZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyA8aHR0cDovL2NvbmZpZ3VyZS5hYz4gYi9jb25maWd1cmUu
YWMNCj4gICAgIDxodHRwOi8vY29uZmlndXJlLmFjPg0KPiAgICAgaW5kZXggODFjYmE5OGMyLi5h
MDEyM2YxNjYgMTAwNjQ0DQo+ICAgICAtLS0gYS9jb25maWd1cmUuYWMgPGh0dHA6Ly9jb25maWd1
cmUuYWM+DQo+ICAgICArKysgYi9jb25maWd1cmUuYWMgPGh0dHA6Ly9jb25maWd1cmUuYWM+DQo+
ICAgICBAQCAtNzEsNiArNzEsNyBAQCBBQ19DSEVDS19IRUFERVJTX09OQ0UoWyBcDQo+ICAgICAg
wqAgwqAgwqBzeXMvZXBvbGwuaCBcDQo+ICAgICAgwqAgwqAgwqBzeXMvZmFub3RpZnkuaCBcDQo+
ICAgICAgwqAgwqAgwqBzeXMvaW5vdGlmeS5oIFwNCj4gICAgICvCoCDCoCBzeXMvcGlkZmQuaCBc
DQo+ICAgICAgwqAgwqAgwqBzeXMvcHJjdGwuaCBcDQo+ICAgICAgwqAgwqAgwqBzeXMvc2htLmgg
XA0KPiAgICAgIMKgIMKgIMKgc3lzL3RpbWVyZmQuaCBcDQo+ICAgICBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9sYXBpL3BpZGZkLmggYi9pbmNsdWRlL2xhcGkvcGlkZmQuaA0KPiAgICAgaW5kZXggMjQ0
ZDNhY2FmLi5kMjlhMmIyNzQgMTAwNjQ0DQo+ICAgICAtLS0gYS9pbmNsdWRlL2xhcGkvcGlkZmQu
aA0KPiAgICAgKysrIGIvaW5jbHVkZS9sYXBpL3BpZGZkLmgNCj4gICAgIEBAIC0xNSw2ICsxNSwx
MCBAQA0KPiAgICAgIMKgI2RlZmluZSBQSURGRF9OT05CTE9DSyBPX05PTkJMT0NLDQo+ICAgICAg
wqAjZW5kaWYNCj4gDQo+ICAgICArI2lmZGVmIEhBVkVfU1lTX1BJREZEX0gNCj4gICAgICsjaW5j
bHVkZSA8c3lzL3BpZGZkLmg+DQo+ICAgICArI2VuZGlmDQo+ICAgICArDQo+ICAgICAgwqBzdGF0
aWMgaW5saW5lIHZvaWQgcGlkZmRfc2VuZF9zaWduYWxfc3VwcG9ydGVkKHZvaWQpDQo+ICAgICAg
wqB7DQo+ICAgICAgwqAgwqAgwqAgwqAgLyogYWxsb3cgdGhlIHRlc3RzIHRvIGZhaWwgZWFybHkg
Ki8NCj4gICAgIC0tIA0KPiAgICAgMi4zNy4yDQo+IA0KPiANCj4gICAgIC0tIA0KPiAgICAgTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwDQo+ICAg
ICA8aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHA+DQo+IA0KPiANCj4gDQo+IC0t
IA0KPiBSZWdhcmRzLA0KPiBMaSBXYW5nDQo+IA0KPiAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
