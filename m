Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9805BC433F5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 13:08:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E23A3CA6D5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 15:08:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27A2F3C1777
 for <ltp@lists.linux.it>; Mon, 18 Apr 2022 12:14:08 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96840600576
 for <ltp@lists.linux.it>; Mon, 18 Apr 2022 12:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1650276847; x=1681812847;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0P3zoGroKGVknljF9zZOaUtP5ur6agWLATRSrF7s63Q=;
 b=F2scwNPMdlbBMz6Nb1xYQgAmQpu8XlRKDn4XPiDNoZMEvR+VKpT8fnX6
 jm2cyxzmMjJqGSbVejMDALpzPy/mug+ayJfuNJ0AfmmsvCmOXQsD3nvfS
 LcM9Tl3CRIIxtoSvmlCzSf8wyuT/OQEx4yVH9O/jHoAEz/lrqdiC1ojhL
 v6itBZht+vwj1HscSrid+/jBe+N4hZo6XvUy6a76JqIFU8FykNbaP9mqL
 kJGeV+gfmKvmV7Xr2zjGTIF0V7tqA6DI4N7JwJzfMhc68g3BvZeP7F454
 fvU7A/QeZRdzFTzl5zC7UgzmCT3a5SrsmzIB/0GkOlxkeqfd8oZIb0Vcs g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="61987512"
X-IronPort-AV: E=Sophos;i="5.90,269,1643641200"; d="scan'208";a="61987512"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 19:14:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoYP+05JYB8+IrJ4lItJ+Wi8nhs4qcsoyZQ1FHFNX8XBRHwn56ZMwjXTRKSmz1aaFvfssArdis1rCzToK2s/HArXFCIhrw6nbLk4s/yKCrlr5mU7XualRk+JwNkHjGtcYK9UnMiaW+pdHVbdEvwk7xAu/Avw3Li9c63hKUNRch7NvXxYo7d9CybfoAJcZo9nDXb4glshaxiE2C0qPgr1g6wrNrfZBrwbffOB+DKx4t6DMz+TTDTPjMSOPezRYI/l1+2W2bS/9gWpBY6Gs5iTOgVlxAgerg51dDbJQU1F9uXJUOCBwvBalksxd2p2JzGowT0JlVss2S64MoFU1K3OSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P3zoGroKGVknljF9zZOaUtP5ur6agWLATRSrF7s63Q=;
 b=cJ7wgg5B/8Whd6ens1G88Q+J1HqO4bD4QZs1Y910ToEzutVdh3U6V4dvvsab2K2kr4RhjgaVLKBiacyWFMcgbHiNabnKDMlgKhINnykf0wWXsAWEmbSavlg4ZZbmhF3+w2dpM38LABswEbLrgWTwFHLgUq+Eyo58PTzEvJK+POr2q+fYP/gEkLRIFOTWIZMkcyL7w3nfIir43R/e3RmK46t1D7imvgecnwIbZRmYq4brjwWsCbNiTHL1yARa2cv+KWjaN1mWp8R36iRbvZ2ToJnOO2BMEj4xxq1pdyiRRUNg85ze7hMAb0fJb8kl8dYy71S/2ApQbClWEuq7pdKvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P3zoGroKGVknljF9zZOaUtP5ur6agWLATRSrF7s63Q=;
 b=i0Qh5fP1S4Ug9fnphyTv02vlE+U44bIgEWTuVkWwcTzFmFoV4YFS/wXJ64teLFYSpL2o0bM+69YY3Zb8hv/8FOAtgsAaGfFOUR6MI7QkDhe2nhLFcwMXJU9TbqOzmV50mjRZ6sEw4mWqGp5Klzp3mAtyYE0Bwxy4kzAo3k2v8yY=
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com (2603:1096:604:f5::13)
 by OSAPR01MB2658.jpnprd01.prod.outlook.com (2603:1096:604:3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 10:14:00 +0000
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::99dc:4b79:140e:20db]) by OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::99dc:4b79:140e:20db%2]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 10:14:00 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, "daisl.fnst@fujitsu.com"
 <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH] syscalls/mount_setattr01: Add basic functional test
Thread-Index: AQHYNE9kfiaWT7KWAESuveV7OGAdRay4lo4AgD0K5qA=
Date: Mon, 18 Apr 2022 10:14:00 +0000
Message-ID: <OS3PR01MB6449981D24AF559A67D04D8CE6F39@OS3PR01MB6449.jpnprd01.prod.outlook.com>
References: <1646943582-13826-1-git-send-email-daisl.fnst@fujitsu.com>
 <Yin3uN8lLAioAJ9m@yuki>
In-Reply-To: <Yin3uN8lLAioAJ9m@yuki>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 407b23d4-37a1-4946-0215-08da2124282f
x-ms-traffictypediagnostic: OSAPR01MB2658:EE_
x-microsoft-antispam-prvs: <OSAPR01MB2658236DC14A29F13E4374CDE6F39@OSAPR01MB2658.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1gEPNUz05yllZ6a6zyx+2kbJSa+ZAMuQES0pbmmTrKBJkIkqPqRDAwLqL91m9zGanlMmtAsCwcCfKLew1tduK6gOQ5KTYS0JIUDAPl1+y+7wA+XGP89RGAfMslDkzz4d4vdwvDptiDde3hnX1xR55zyuMmBCF6vQmi95oqTOCco+F2shcXKs3jZTTxegfl6SCtR/c/cSaR7T0sgx8ObE7ML9BcuChUiI5T0lHBA70vJHNxbS8dlppCOFHfBvTgvpkNliKqYct183FWUBXH8Ajoyo0uzVsaYRJunrf/0Mzc/mXdKJDBd7n8e/qWA27cYZDzt67TgS+3TMT1oiLzDk7+/F/Bft8Y6vQJvYgg6h1m1mLcKA8BGSrH1MSRZ3IeLQSK2/Z+KMNk0vQ+4WGXIGPbfjyCogPI2RQaCcsY7NZjZT6Va+Vm9hij2k8aKtFhdx4aEkt7dvs3ZV81zq/sXuwlSfn0kfFN5oGlRje2AvLzl5+KjKAfuvE2ul5VZ7iONnnlH6no/zY5D/1dpDZU5zsFnd6qHmH436yAP/T6sM2A6Nul/GTtUV6tflZlOobOTuC+XHtIxhWGsbwvwGRdatKGRZQwUE2P33yf6pPN97ej7REvfQoqHaKaCRZaQHqXqdrvFldqbFFMZGMUTQtYm+h5GLZ5dihyoCisBj50sX3WZxS+TzSllQTDrbtk7xD6hM0OXl3edaRt/PAjyOZ8LiRmPKyvS/4E5DzKEKHVMRKoSXIwnlJC0dhQuhCyDZN41l2eocC3MB2oehrDewyljGw6SIgUfdLT9bGxn+BrKuAk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6449.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(85182001)(224303003)(122000001)(82960400001)(6636002)(64756008)(66946007)(66476007)(110136005)(76116006)(66556008)(66446008)(4326008)(7696005)(8936002)(33656002)(52536014)(6506007)(9686003)(71200400001)(2906002)(86362001)(55016003)(316002)(38100700002)(38070700005)(83380400001)(26005)(5660300002)(508600001)(966005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UGViRkRBNXF5TUp6ZjNySzB1V3BpdmNuQ3JBdE93dXhSN3BUY1NHS2czQ3dj?=
 =?gb2312?B?M2VsZVg4TWlMeG52NnZBM1VpcGpGTEluUFdyZnVSUzNtQXMxUzhUZms4ZXFn?=
 =?gb2312?B?WlZFMUZobjdqY2Q0MjcvUGI1UWNZRUxneHpZVnBhU0piRXE5WDJZeHZ3S1pZ?=
 =?gb2312?B?NDJUd3dZdGVKaWQ4RkxEaEtMZEZJaFVZcEphVi9QQ0RlNlE2a2h6Rzl3MDJU?=
 =?gb2312?B?VXZCZjJURjRjd2kwb2ZPNGtMUG44WU9MK0Q0RXVkNGplVWZ5bmdzMFNvclp4?=
 =?gb2312?B?Umt0RlZNSFE3dHJhcXVsS3h4cDlsVFZlUEpHVlhYM0UzZTgwYVJDbUNnY050?=
 =?gb2312?B?YnFkNDV3M0FRUTgyWmsvTkZBT2huVDNZOUsxWTB0eDZzdVYwRnJjaE4wM3Ix?=
 =?gb2312?B?ZVRrcnFaN3M2NVZ0TTR2UXJTeTg3YWlQZGlwT0lMMjgvWjRnWFJpam1PR1J4?=
 =?gb2312?B?WHNFQVhPTUI2NThoTFR0YjdIeGVHMEZJRTBOc3pjQWxHRW16cTBWR3J3cElS?=
 =?gb2312?B?QmdNWlMzWm5NcUczbk95Qlgwby9lZVBPNDdBeGZ1UGNZUHRBZld0c1Npekt5?=
 =?gb2312?B?T0VpemJDYWxnM0F3YitXeTYycG9mVmZkS0dyTitQT0xMQ0locVlKS1VnR2Rj?=
 =?gb2312?B?VTh3OHR6Y2tkYnF2d2diT3hKVXVYQllvN283QUtWRlNtWDZZcnRMZWpoNFJl?=
 =?gb2312?B?K2l6cml1a2Z6TnA4aFUwVnd6NnlacXpwamVYRHlRLy9PZkpYNC9FcFNrUFJv?=
 =?gb2312?B?MjJPd2Jia3AwRFYzNVVJam9yZ3MyNWhCanh1ampxWTdiTm9XWEFFUjUxMGRj?=
 =?gb2312?B?UFdRalNpZlRHRE9CYmpqenJvaVUwUDhIeUFmZGpvckRwQTJUTTlXVTlQc1Uz?=
 =?gb2312?B?RlNUZUV3d1dydWRvaHVzdkFpY1hvSXZxNGk1OGd3WVhoNCt6QW5udVRzemw4?=
 =?gb2312?B?SGlyVTlhazFsRkNKclgzZ3d3M0xMS3RGSWJXWkpQRlliM3BtU1FrMmUxTGdo?=
 =?gb2312?B?YWZqV0VFQUZJTHZ2SFc4RDhBbzRqMHJJMlltWmJnMS9UQXMrb3B4WGFrSEY1?=
 =?gb2312?B?NDJCZ3JSdWI2L2ZsZ3BMa0c1dmlqUVA4bUlTZjlaUTU4QnVqWEczYlpXWDFE?=
 =?gb2312?B?SzJNUFVSWGVNUmdYTko1Vnp1bmtHOVVGTVdPY3dxMmdwQjVwRCtBNlJMTER5?=
 =?gb2312?B?SlRjMXBFT1A0R2NueUhFVEJJdkUvS1dTQXN2czIra2N0aDFRZUwyT0dsZzdQ?=
 =?gb2312?B?NlZVcVhXSWNWVmtaVVNwTk16WVkwWHpqdUd2RU9sVm1JNE1yVXBycG9xZFdH?=
 =?gb2312?B?NFBDRVVBOTlKUmFnMFlFUkRKRG8xSHV4TklqZ0tNcDJVZFBpVzNJNVFuTGt4?=
 =?gb2312?B?Q21WMWFHSHAwWTBXb0lJTzFQdDkrY2NuNCt1b2FBYTFJN2FOaDNSeU1WOHlu?=
 =?gb2312?B?N3ZMN1dGOWVzaVdIZ1pQNk13QVpheklHK1VpZ3FZY3paaHhnUVQ3UkdVazBo?=
 =?gb2312?B?QlYxdUs5d3dHYXVaamJ5MlZFUzNlMHEyN0J4YVV3SnhLeUJuOExic0U5RFJ3?=
 =?gb2312?B?cHl4QjlxcmI3SXRrSlRBVzVpY0NZUEIySXI4cFQ1bHhhN3pEU0ZWNFUvTkZ2?=
 =?gb2312?B?NXZ1R2JlTTBCMHRDMDV2VjZwUUhQZnJyUU9IYlBOMXIzZHFINUs2VlY0MENl?=
 =?gb2312?B?Q216dW9rWHIyUTNuV3F5eW9EUFFKYlBnWHU0ZkpwN1FoT3JZd3dHc0lDTk1v?=
 =?gb2312?B?TllMSGMyalpOZVpRSlpCUVoxYUNFS0ZWdnhlcTVKK3pSUzVzME9udkk3WWFz?=
 =?gb2312?B?L2lhNVlZRHE3U3FSbmRPR3A5RUxESCtXNkVFOVh3VS9qaW02cWZzMGFxR2Zo?=
 =?gb2312?B?TTgwWnlLQjdINUxUZ2NMY3g1OHJCWjQ2TUdZYUFSZHlOYTNXclJ6UUVIaU96?=
 =?gb2312?B?TEtrS1ZFeTBURGxmRU5qSEIzTnp2b0tNbFdJemtpTXh0U0ZhcmhCdGowVWll?=
 =?gb2312?B?T3dlVkh2SlZyY24xWmNrQ2xSRG9pSU9vTzdQSlVMdURtbTBySkkyYkJsKy90?=
 =?gb2312?B?VmFqK0FCWDNxK3dSWTlnVTlaVnE3RHpJZ2NsUTZZRG40cVdacmhSbHFLQnIz?=
 =?gb2312?B?TUppMFNXdGs3b0hDZGJnUEpQdFZjdzFPMWxnaUdmUE0rTHdLNFB5TGx4dy9v?=
 =?gb2312?B?WGpwSVhzb1BuZW9pQ1VFcStxSUVkbXh5SmExelA5OUw5YnhVRjVsZE9SMkFP?=
 =?gb2312?B?MzlWNU50WVpjdlR5VXIrVWZweWV0bnRLbnowazEva2NQdFFBVStmQlZWWDJV?=
 =?gb2312?B?Kzk1WHdSeDlXNjFmK3hrQUxnREp6d1JMbzViZmN1bm0xTkN0NkpRdz09?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6449.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407b23d4-37a1-4946-0215-08da2124282f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 10:14:00.1492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIaMTdY9ORN5OjuS5Pdb4ZZQZYpB4anx82Ct9yieV4B+UVf0CD7i9IEhi4lv4DqjWzSv6gwPu15hDN0DRLmnUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2658
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 21 Apr 2022 15:08:19 +0200
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSF0gc3lzY2FsbHMvbW91bnRfc2V0?=
 =?gb2312?b?YXR0cjAxOiBBZGQgYmFzaWMgZnVuY3Rpb25hbCB0ZXN0?=
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

SGkNCg0KPiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBsdHAgPGx0cC1ib3VuY2VzK2No
ZW5oeC5mbnN0PWNuLmZ1aml0c3UuY29tQGxpc3RzLmxpbnV4Lml0PiC0+rHtIEN5cmlsDQo+IEhy
dWJpcw0KPiC3osvNyrG85DogMjAyMsTqM9TCMTDI1SAyMTowNg0KPiDK1bz+yMs6IERhaSwgU2hp
bGkgPGRhaXNsLmZuc3RAZnVqaXRzdS5jb20+DQo+ILOty806IGx0cEBsaXN0cy5saW51eC5pdA0K
PiDW98ziOiBSZTogW0xUUF0gW1BBVENIXSBzeXNjYWxscy9tb3VudF9zZXRhdHRyMDE6IEFkZCBi
YXNpYyBmdW5jdGlvbmFsIHRlc3QNCj4gDQo+IEhpIQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xhcGkvZnNtb3VudC5oIGIvaW5jbHVkZS9sYXBpL2ZzbW91bnQuaCBpbmRleA0KPiA+IGZhMjUz
MDYuLjk5ZDBhMGEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9sYXBpL2ZzbW91bnQuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvbGFwaS9mc21vdW50LmgNCj4gPiBAQCAtMTUsNiArMTUsMjYgQEANCj4g
PiAgI2luY2x1ZGUgImxhcGkvZmNudGwuaCINCj4gPiAgI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMu
aCINCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBNb3VudCBhdHRyaWJ1dGVzLg0KPiA+ICsgKi8NCj4g
PiArI2RlZmluZSBNT1VOVF9BVFRSX1JET05MWSAgICAgICAweDAwMDAwMDAxIC8qIE1vdW50IHJl
YWQtb25seSAqLw0KPiA+ICsjZGVmaW5lIE1PVU5UX0FUVFJfTk9TVUlEICAgICAgIDB4MDAwMDAw
MDIgLyogSWdub3JlIHN1aWQgYW5kIHNnaWQNCj4gYml0cyAqLw0KPiA+ICsjZGVmaW5lIE1PVU5U
X0FUVFJfTk9ERVYgICAgICAgIDB4MDAwMDAwMDQgLyogRGlzYWxsb3cgYWNjZXNzIHRvDQo+IGRl
dmljZSBzcGVjaWFsIGZpbGVzICovDQo+ID4gKyNkZWZpbmUgTU9VTlRfQVRUUl9OT0VYRUMgICAg
ICAgMHgwMDAwMDAwOCAvKiBEaXNhbGxvdyBwcm9ncmFtDQo+IGV4ZWN1dGlvbiAqLw0KPiA+ICsj
ZGVmaW5lIE1PVU5UX0FUVFJfTk9ESVJBVElNRSAgIDB4MDAwMDAwODAgLyogRG8gbm90IHVwZGF0
ZQ0KPiBkaXJlY3RvcnkgYWNjZXNzIHRpbWVzICovDQo+ID4gKyNkZWZpbmUgTU9VTlRfQVRUUl9O
T1NZTUZPTExPVyAgMHgwMDIwMDAwMCAvKiBEbyBub3QgZm9sbG93DQo+IHN5bWxpbmtzDQo+ID4g
KyovDQo+IA0KPiBUaGVzZSBoYXZlIHRvIGJlIGRlZmluZWQgb25seSBpZiB0aGV5IGFyZSBtaXNz
aW5nLCBvdGhlcndpc2Ugd2Ugd2lsbCBlbmQgdXAgd2l0aA0KPiByZWRlZml0aW9uIHdhcm5pbmdz
IG9uY2UgZ2xpYmMgYWRkIHRoZXNlIGNvbnN0YW50cywgaS5lLg0KPiANCj4gI2lmbmRlZiBNT1VO
VF9BVFRSX1JET05MWQ0KPiAjIGRlZmluZSBNT1VOVF9BVFRSX1JET05MWSAweDAwMDAwMDAxDQo+
ICNlbmRpZg0KPiANCg0KR2V0IGl0Lg0KPiAuLi4NCj4gDQo+ID4gKy8qDQo+ID4gKyAqIG1vdW50
X3NldGF0dHIoKQ0KPiA+ICsgKi8NCj4gPiArc3RydWN0IG1vdW50X2F0dHIgew0KPiA+ICsJX191
NjQgYXR0cl9zZXQ7DQo+ID4gKwlfX3U2NCBhdHRyX2NscjsNCj4gPiArCV9fdTY0IHByb3BhZ2F0
aW9uOw0KPiA+ICsJX191NjQgdXNlcm5zX2ZkOw0KPiANCj4gVGhlc2Ugc2hvdWxkIGJlIHVpbnQ2
NF90LCB3ZSBjYW5ub3QgdXNlIHRoZSBrZXJuZWwgdHlwZXMgaW4gdXNlcnNwYWNlLg0KPiANCk9L
Lg0KDQo+ID4gK307DQouLi4NCj4gPiArI2RlZmluZSBNTlRQT0lOVCAgICAgICAgIm1udHBvaW50
Ig0KPiA+ICsjZGVmaW5lIE9UX01OVFBPSU5UICAgICAib3RfbW50cG9pbnQiDQo+ID4gKyNkZWZp
bmUgVENBU0VfRU5UUlkoX21vdW50X2F0dHJzKQl7Lm5hbWUgPQ0KPiAjX21vdW50X2F0dHJzLCAu
bW91bnRfYXR0cnMgPSBfbW91bnRfYXR0cnN9DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xg0KPiBQbGVhc2UgZG8gbm90IHVzZSBpZGVudGlmaWVycyBzdGFydGluZyB3aXRoIHVuZGVyc2Nv
cmUsIHRoZXNlIGFyZSByZXNlcnZlZCBmb3INCj4ga2VybmVsIGFuZCBsaWJjLg0KPiANClN1cmUu
DQoNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZGlyX2NyZWF0ZWQ7DQo+ID4gKw0KPiA+ICtzdGF0
aWMgc3RydWN0IHRjYXNlIHsNCj4gPiArCWNoYXIgKm5hbWU7DQo+ID4gKwl1bnNpZ25lZCBpbnQg
bW91bnRfYXR0cnM7DQo+ID4gK30gdGNhc2VzW10gPSB7DQo+ID4gKwlUQ0FTRV9FTlRSWShNT1VO
VF9BVFRSX1JET05MWSksDQo+ID4gKwlUQ0FTRV9FTlRSWShNT1VOVF9BVFRSX05PU1VJRCksDQo+
ID4gKwlUQ0FTRV9FTlRSWShNT1VOVF9BVFRSX05PREVWKSwNCj4gPiArCVRDQVNFX0VOVFJZKE1P
VU5UX0FUVFJfTk9FWEVDKSwNCj4gPiArCVRDQVNFX0VOVFJZKE1PVU5UX0FUVFJfTk9TWU1GT0xM
T1cpLA0KPiA+ICsJVENBU0VfRU5UUlkoTU9VTlRfQVRUUl9OT0RJUkFUSU1FKSwNCj4gPiArfTsN
Cj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkNCj4gPiArew0KPiA+ICsJaWYg
KGRpcl9jcmVhdGVkKQ0KPiA+ICsJCVNBRkVfUk1ESVIoT1RfTU5UUE9JTlQpOw0KPiANCj4gTm8g
bmVlZCB0byBybWRpciBhbnl0aGluZywgaXQgd2lsbCBiZSByZW1vdmVkIGJ5IHRoZSB0ZXN0IGxp
YnJhcnkgYWxvbmcgd2l0aCB0aGUNCj4gdGVzdCB0ZW1wb3JhcnkgZGlyZWN0b3J5Lg0KPiANCg0K
VGhlcmUgYXJlIHNldmVyYWwgZmlsZSBzeXN0ZW1zIHRvIGJlIHRlc3RlZC4gSWYgd2UgZG8gbm90
IHJtZGlyLCBpdCB3aWxsIGJlIGVycm9yKGRpciBpcyBFRVhJU1QpIHdoZW4gdGVzdGluZyB0aGUg
c2Vjb25kIGZpbGUgc3lzdGVtLg0KDQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHNl
dHVwKHZvaWQpDQo+ID4gK3sNCj4gPiArCWZzb3Blbl9zdXBwb3J0ZWRfYnlfa2VybmVsKCk7DQo+
ID4gKwlTQUZFX01LRElSKE9UX01OVFBPSU5ULCAwNzc3KTsNCj4gPiArCWRpcl9jcmVhdGVkID0g
MTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBuKQ0K
PiA+ICt7DQo+ID4gKwlpbnQgb3RmZDsNCj4gPiArCXN0cnVjdCB0Y2FzZSAqdGMgPSAmdGNhc2Vz
W25dOw0KPiA+ICsJc3RydWN0IG1vdW50X2F0dHIgYXR0ciA9IHsNCj4gPiArCQkuYXR0cl9zZXQg
PSB0Yy0+bW91bnRfYXR0cnMsDQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCVRFU1Qob3RmZCA9IG9w
ZW5fdHJlZShBVF9GRENXRCwgTU5UUE9JTlQsIEFUX0VNUFRZX1BBVEggfA0KPiA+ICsJCUFUX1NZ
TUxJTktfTk9GT0xMT1cgfCBPUEVOX1RSRUVfQ0xPRVhFQyB8DQo+IE9QRU5fVFJFRV9DTE9ORSkp
Ow0KPiA+ICsJaWYgKG90ZmQgPT0gLTEpIHsNCj4gPiArCQl0c3RfcmVzKFRGQUlMIHwgVFRFUlJO
TywgIm9wZW5fdHJlZSgpIGZhaWxlZCIpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gDQo+
IFRoaXMgY2FuIGJlIGp1c3QgVFNUX0VYUF9GRCgpDQpPSy4NCg0KPiANCj4gPiArCVRFU1QobW91
bnRfc2V0YXR0cihvdGZkLCAiIiwgQVRfRU1QVFlfUEFUSCwgJmF0dHIsIHNpemVvZihhdHRyKSkp
Ow0KPiA+ICsJaWYgKFRTVF9SRVQgPT0gLTEpIHsNCj4gPiArCQl0c3RfcmVzKFRGQUlMIHwgVFRF
UlJOTywgIm1vdW50X3NldGF0dHIoKSBzZXQgYXR0ciAlcyBmYWlsZWQuIiwNCj4gdGMtPm5hbWUp
Ow0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gDQo+IGFuZCB0aGlzIGNhbiBiZSBUU1RfRVhQ
X1BBU1MoKQ0KPiANCk9LLg0KDQo+IA0KPiBBbmQgaGVyZSB3ZSBzaG91bGQgY2hlY2sgaWYgdGhl
IGF0dHJpYnV0ZSB3YXMgcmVhbGx5IGNoYW5nZWQuDQo+IA0KPiBJIGd1ZXNzIHRoYXQgd2UgY2Fu
IGFkZCBmdW5jdGlvbnMgdG8gdmVyaWZ5IG1vc3Qgb2YgdGhlIGF0dHJpYnV0ZXMsIGUuZy4NCj4g
Zm9yIFJET05MWSB3ZSBjYW4gYWRkIGEgZnVuY3Rpb24gdGhhdCB0cmllcyB0byBvcGVuIGZpbGUg
Zm9yIHdyaXRpbmcgYW5kIGV4cGVjdHMNCj4gdGhhdCBpdCBmYWlscyB3aXRoIEVST0ZTIGlmIHRo
ZSBhdHRyaWJ1dGUgaGFzIGJlZW4gc2V0Lg0KPiANCg0KR3Vlc3Mgc3RhdHZmcygzKSBtYXkgaGVs
cC4NCg0KPiA+ICsJYXR0ci5hdHRyX2NsciA9IHRjLT5tb3VudF9hdHRyczsNCj4gDQo+IFRoaXMg
ZG9lcyBub3QgaGF2ZSBhbnkgZWZlY3QgYXQgYWxsIHVubGVzcyB3ZSBhbHNvIHJlc2V0IGF0dHJf
c2V0Lg0KPiBBY2NvcmRpbmxneSB0byB0aGUgbWFudWFsIHBhZ2Uga2VybmVsIGZpcnN0IGNsZWFy
cyBhdHRyaWJ1dGVzIHRoZW4gc2V0cyB0aGVtLCBzbw0KPiBhcyBsb25nIGFzIHRoZSBhdHRyX3Nl
dCByZW1haW5zIHNldCB0byB0Yy0+bW91bnRfYXR0cnMgdGhlIGZvbGxvd2luZw0KPiBtb3VudF9z
ZXRhdHRyKCkgaXMgbm8tb3AuDQo+IA0KV2lsbCBiZSBkZWxldGVkIGluIHYyLg0KDQo+ID4gKwlU
RVNUKG1vdW50X3NldGF0dHIob3RmZCwgIiIsIEFUX0VNUFRZX1BBVEgsICZhdHRyLCBzaXplb2Yo
YXR0cikpKTsNCj4gPiArCWlmIChUU1RfUkVUID09IC0xKSB7DQo+ID4gKwkJdHN0X3JlcyhURkFJ
TCB8IFRURVJSTk8sICJtb3VudF9zZXRhdHRyKCkgY2xlYXIgYXR0ciAlcyBmYWlsZWQuIiwNCj4g
dGMtPm5hbWUpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gDQo+IFRoaXMgY2FuIGJlIGp1
c3QgVFNUX0VYUF9QQVNTKCkNCj4gDQo+IEFuZCBoZXJlIHdlIHNob3VsZCBjaGVjayB0aGF0IHRo
ZSBhdHRyaWJ1dGUgaGFzIGJlZW4gcmVzZXQsIGUuZy4gZm9yIFJET05MWQ0KPiBhdHRyaWJ1dGUg
d2Ugc2hvdWxkIGNoZWNrIHRoYXQgZmlsZXMgY2FuIGJlIG9wZW5lZCBmb3Igd3JpdGluZyBhZ2Fp
bi4NCj4gDQoNCj4gDQo+ID4gKwlURVNUKG1vdmVfbW91bnQob3RmZCwgIiIsIEFUX0ZEQ1dELCBP
VF9NTlRQT0lOVCwNCj4gTU9WRV9NT1VOVF9GX0VNUFRZX1BBVEgpKTsNCj4gPiArCWlmIChUU1Rf
UkVUID09IC0xKSB7DQo+ID4gKwkJdHN0X3JlcyhURkFJTCB8IFRURVJSTk8sICJtb3ZlX21vdW50
KCkgZmFpbGVkIik7DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJfQ0KPiANCj4gSSBkbyBub3QgZ2V0
IHdoeSB3ZSBkbyBtb3ZlIHRoZSBtb3VudCBhdCBhbGwsIHRoaXMgaXMgc3VwcG9zZWQgdG8gYmUg
YSBzaW1wbGUNCj4gdGVzdCBmb3IgbW91bnRfc2V0YXR0cigpLg0KDQptb3ZlX21vdW50IHBsYWNl
IHRoZSBmaWxlc3lzdGVtIGludG8gYSBtb3VudCBuYW1lc3BhY2UgYW5kIHRoZW4gaXQgd2lsbCBi
ZSB2aXNpYmxlIHRvIHVzZXJzLg0KDQpJJ2xsIHBvc3QgYSB2MiBwYXRjaCBzb29uLg0KDQpSZWdh
cmRzLA0KLSBDaGVuDQoNCj4gDQo+ID4gKwlTQUZFX0NMT1NFKG90ZmQpOw0KPiA+ICsNCj4gPiAr
CWlmICh0c3RfaXNfbW91bnRlZF9hdF90bXBkaXIoT1RfTU5UUE9JTlQpKSB7DQo+ID4gKwkJU0FG
RV9VTU9VTlQoT1RfTU5UUE9JTlQpOw0KPiA+ICsJCXRzdF9yZXMoVFBBU1MsICJtb3VudF9zZXRh
dHRyKCkgc2V0IGFuZCBjbGVhciBhdHRyICVzIHBhc3NlZC4iLA0KPiB0Yy0+bmFtZSk7DQo+ID4g
Kwl9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsN
Cj4gPiArCS50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLA0KPiA+ICsJLnRlc3QgPSBydW4sDQo+
ID4gKwkuc2V0dXAgPSBzZXR1cCwNCj4gPiArCS5jbGVhbnVwID0gY2xlYW51cCwNCj4gPiArCS5u
ZWVkc19yb290ID0gMSwNCj4gPiArCS5tb3VudF9kZXZpY2UgPSAxLA0KPiA+ICsJLm1udHBvaW50
ID0gTU5UUE9JTlQsDQo+ID4gKwkuYWxsX2ZpbGVzeXN0ZW1zID0gMSwNCj4gPiArCS5za2lwX2Zp
bGVzeXN0ZW1zID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtdKXsiZnVzZSIsIE5VTEx9LCB9Ow0KPiA+
IC0tDQo+ID4gMS44LjMuMQ0KPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IE1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cA0KPiANCj4gLS0NCj4gQ3lyaWwg
SHJ1YmlzDQo+IGNocnViaXNAc3VzZS5jeg0KPiANCj4gLS0NCj4gTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwDQoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
