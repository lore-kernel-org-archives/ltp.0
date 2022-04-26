Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5125FC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 10:19:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D2983CA184
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 12:19:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5BA83C1BF0
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 12:19:07 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA124600732
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 12:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1650968345; x=1682504345;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=akjS53h2lVeJGqJwD9q9HZgJ9+0DYV17qbk/yr7OWls=;
 b=QuPQXUaIAb88qRFWIG9xe1dr1LkBoaFhwRGOYl5g7Er5TknT9of0X3Mq
 M3rMnXTREhB2cFBlDgh8SSSI1oKEFqgFVluVw+UOH1kExQ9HbcQKrujWj
 PW7Z9lvJ8CaFUbb+0nwBqYUt7LC6L4ZnOV0IDD/fiO2D/QTdfbPTvyc9A
 iXTT4zo9FHkEpPq5r5xoHI4ZBmsL5+Ax4/C7hRexT33nhr4Cnd22frEnd
 pVLPrOt831VhiOK8lbJDiREITNbb65rvH8V0OYtDqsmbqoNCpccIzHUrt
 bgL/Llq33bdKsTodf+rbR362Tmy3x+dsie03hpW93AqZUa9JSnxY50gUS g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="54716030"
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; d="scan'208";a="54716030"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 19:19:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTqx42EmfDqtXh2HQMtsQcCFpkRlqfHZBOfsFtfyj1ZhtBdWOIX68kml/OH/MrtDROZZJi+uZOCfQdA6xEBF9sl/Y9gflYHH8Wks2h+iWi3VxVA7ZXsuhu+znYCF6+hinuas0EZpJ23QcwxhJzly0Ki7zO34oxg/K045XKaxtMhGtXWB6GoMjATrkAKyvLjKFummxvktLlKSld7JhZ6JOFIpXg9ZfXoPb8x5gn71AQZRROWX8nTRE19hNNjCS4QuzEJ9R8QBXvd6qf4hEdDLPiNlD/BcVjA1szYP3QoS0eQ1jBc/gL1Xx+DoGOElmWE0Yy/hnf/l7yxnim0O2uJv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akjS53h2lVeJGqJwD9q9HZgJ9+0DYV17qbk/yr7OWls=;
 b=a6mzdcvFGh0tZM6pFNCRCOKYic8VCiHrqpBHGAJakfd6mJhzFdVatUx1CR5d70Y4df5gNuJ76GYxB2txxc+B6c/2rOQwgCzlJIU0dyehXO1R71Fc3acLi8axzxVFM6AHB6CoiWlPYWst+c2kzCkz/7Ne2+lZG1/5io0Ill7msiyzv4gV6CwvxZ3EddmNgE4Yz+0X2g19glegaFg4zKi6U/vjklZlD/pCiyRE8NoFdZ9GrFsO0CXe/6eUEXV4ys5Ggerp/GAtFATDR0alTFW038axspylfOcfKVaZD0bosA2B36oGBtzThIToKUPmO49rL4R8eV595mdFRzbn5FF1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akjS53h2lVeJGqJwD9q9HZgJ9+0DYV17qbk/yr7OWls=;
 b=LbOTIu3Ra/NKV5TIgRWwajon0BIbN7v6Mq3ubXO0fwK5ugktFc8htW+V7ipXgVUbUJo5XR3NEJgZPWBkbHxsR5buMscBedP8O8na5xqyH6VvcBojggGQX8n1eqXsHwH05M1D8E38ySeTQ0yOPBNV7Cj32oQqFBt0zvdGbNNid/c=
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com (2603:1096:604:f5::13)
 by TYCPR01MB5822.jpnprd01.prod.outlook.com (2603:1096:400:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 10:19:00 +0000
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::dc84:7b2a:da69:3142]) by OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::dc84:7b2a:da69:3142%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 10:19:00 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v3] syscalls/mount_setattr01: Add basic functional test
Thread-Index: AQHYWJH9vyLy/aS12k2SYD14b5Pheq0B+9pw
Date: Tue, 26 Apr 2022 10:18:59 +0000
Message-ID: <OS3PR01MB64499FD6CC589EABED19F910E6FB9@OS3PR01MB6449.jpnprd01.prod.outlook.com>
References: <20220425060806.1038-1-chenhx.fnst@fujitsu.com>
 <YmZ8Y7cZNBd55/oR@pevik>
In-Reply-To: <YmZ8Y7cZNBd55/oR@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a99b76-0c0f-4cc6-467c-08da276e2e24
x-ms-traffictypediagnostic: TYCPR01MB5822:EE_
x-microsoft-antispam-prvs: <TYCPR01MB58220A045A5717586D62CBDEE6FB9@TYCPR01MB5822.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbZVZi0JsUtd2xYuv7w0EgerheavUPUABqN2itdX5EGDIrmivwNyDZags1kkp/WvhIREpDKiCXz04b4oUZaT8AEsCEWG72mZF90+ZQ1T1KKAzXVo+zcnBUWM04to0LkmeEORrTjdB3YQBAEMG2deIO4XtwfhjjhHfTcaIVNqGWYlub/Y77UZgx8fSbYWRtRKsbaPRCkY+g2TOLcKfDeuhHESIk8VEWT4VaaW07JqU8jj98JmrBtiz9n5PBTCShja0rwokatAGff3T6tonNcO3pwkzOQWpcGAMlAB4VmY/kpDmxHrxKIyFEBDK7z8cb64oee5/APSxUDUbYGoA8AZR4fsdDFicDJfnASqBx/eY+iATrzMYXOM7rgvcEQf4XaIPqer8SdIGfhklpou7CgkNazbr2m9hIi85m7IpYvjfoqPytdauuXJ6EwfZuzE2hUOHIXDuGCdx/AgJMvHVgdzytVgDvW6o6oHX9VFZIuSaV4OGrd7baivyLTjL/IsOxv+ixmpWzAnuqE/cEsIJSuCYHNqPzqfCz+0owmo0uqmJcsvYI8079HwU23X6GdIN6/r9PFyA25mhZK6G1vQee8i5wacEtis8eqZGbDvJup8lL1PJ5It0rz2VDgv8UmtjAJaLrj7uE98TELQGtL8MMs6EnXIAxQEnkWTymT7HmHT8tHqBOHvw+qSw6uDqrZudtjRwwEvmRDD6YotLLN+ac/CMfeX2gn6VucLdYhtOJHwBptsB01B4UuJeGyIxwZFHGKhD1x0BhMeeNnk13w9YkVIyjIjB6+bICp7jsUcZikL9fIjrIblAqVrN+HS0l61cBUB47EA56islZubtQqeedWgnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6449.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(55016003)(83380400001)(4326008)(5660300002)(122000001)(82960400001)(26005)(316002)(6916009)(38100700002)(54906003)(38070700005)(186003)(224303003)(52536014)(966005)(76116006)(66476007)(85182001)(2906002)(66556008)(66446008)(64756008)(66946007)(7696005)(6506007)(508600001)(8936002)(71200400001)(33656002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDVKa3gyQVAyYUNXNFM2bkRXRk8xcGNOaWNRZFVESnNIbkVvZXlkOE5WbndQ?=
 =?utf-8?B?bWk3eEw1eFA4dFpiem0wRFVFMCt1R3dleFRCdkR3QTh3b0E0K0xIVTdSUVN3?=
 =?utf-8?B?alFEVkpFTUd3bUhRQzg0cEtFVjJmeEwwUk9XeXpCRWJUTXdxL2xPT1RxcjIz?=
 =?utf-8?B?OFozc2g2dk5aU2sxOGVKaWNEeHNkZFV0TG9WOEtrN0taT09VeFBnRFNxVWdE?=
 =?utf-8?B?ZksvUkZGWFVQVkZUR0kyL1owRFRQWGhHUUdxbTVhN2JrUFh3VW5zUmFIWkt6?=
 =?utf-8?B?QnQzdm0yU05NNTNRcnBLMjVkemZVNlppYVAvWWljS3pXNHg5Z1phUFFOOWUr?=
 =?utf-8?B?elRMOUt2RVMweC9WYzhVUERVNnc4ODZMTmtyNmN3QlU2WEFsR2hOQ1V4a0Qy?=
 =?utf-8?B?OEFTREVpT3N0Wlo5SGwyL2hLRFoxTlB6V3pNWU1aQVZxU1FjVFlzMXRoRU9o?=
 =?utf-8?B?NUNNMGRpYm8vaHRVTm9OSExEWmZMckEvN3hzY1BtdnBxK0xOQ1ZxTXNERFk2?=
 =?utf-8?B?K0cyaUsyekpZSHRCV3A5OU5kUGlJTXBlZHdkVGpXbnhtV216YW5Uc3VIN2lq?=
 =?utf-8?B?bU1OdWF1Q1lpVUJ3TWhWVFFIaDUxMEhWdGhzZnlRa3AvVFNRbmZHNlpoUXJN?=
 =?utf-8?B?WmY3QWEycmErc0V4bmNGbjBOanFQU0QrQTVXdWttL2s5N2RHQlMrdmtJVTZk?=
 =?utf-8?B?Y2tlUXBXbXpVQjFEM2JqNnBCTS9qYlp3UWRDTnBJRzh5b2VTOUw2N1VGN3FU?=
 =?utf-8?B?M0MvdHM0UHN2ZnZKSXJwbTlhQ3U4dGFpb1hBUWhYUEFRem1MZzF6MEFvc01v?=
 =?utf-8?B?dG9LOFZnR2Y3UENqd3BUN1F2OU94T0VjeHdVWU13ejYyZ1JXUEhCV25Ib0dS?=
 =?utf-8?B?RU43YkxacmQydjN3OWRKUTZmY3FoaSs2c0kyeDdBZjd3aVl1eWtTdXpqUXpR?=
 =?utf-8?B?dSt6L3RRUVJnVnBxUGttUllCazFGSGRLanB5cnA5QlVUQld1Ny9rRzR0SldM?=
 =?utf-8?B?WGpyOTJXVWNua0pWMGJMV25QNXdzSk92SEFyUzRBdHNScW93cVRQd040c0N5?=
 =?utf-8?B?V21xalFhNUtwUG5xN2tZZFZSSHY1ZTdvY1BHME9sSTVsUGl0cDhBbFlyNnEw?=
 =?utf-8?B?TFFrYjV2bmxoNmlDVEVqWFJ6NGJhajJ4UDJFUmFibm5rRFpEWFFPemZCUWJU?=
 =?utf-8?B?ZjdZMUNrM0p1UTJxbTU0YUYwOGVGWDdjMCs4Z1cycmdLdEpoVHd1aVRCQ01T?=
 =?utf-8?B?ZGl0THZlUTk5eUlQZ1JJUG5EQzFKSzRDZ3BUQW9WQno2Q2Vta3p2RzgvNjlQ?=
 =?utf-8?B?WWRXby9kVXVidHVFdk9OVy84SThTdkoyWUlKSStIbDJkNnEvYlk5Z2JybjZ2?=
 =?utf-8?B?ZXNIdVhxd2FoWmoxQUxaRkZ6emN0aGMzNlhkZEZpakFQY2tuMDQyVmVjMWNl?=
 =?utf-8?B?aU1Gb09YNGdtdWE4dDRVUlhUbk80cG1MMVMxWU5rL0RvUlhzSTZWMHRmYi9E?=
 =?utf-8?B?aldiRTVXcGtLeXZmMGRFczVwTU9jZzh3NCt0SlJKV3Q2dHV4TEhrT1B3TUpy?=
 =?utf-8?B?UjZYZSsvbjArT3JhVE9iS0V2SjZuMGxFd3JJenRWOTBBLzFQVlZHa0YvQ0pQ?=
 =?utf-8?B?MVpOZm1ZcXRPRUp6VVRiRlhBM3Zrai9KYkROT2x1WW1WdTZDbHhmVTZldU5n?=
 =?utf-8?B?NFNPYmNJdkoxNkJZamNFaklaa2VaTUl0cFJzdWNvZll6UUdBTzNDZE5SczB4?=
 =?utf-8?B?TU5QSTFHM09CbXBzT2o0NHN0MlJUODVLd0ttT0tDQkdqTkR0U3JwOWJ0dE0x?=
 =?utf-8?B?OVBoYW42endMY2RnbS9PMGMrWkkvbFRmTnZTWkNqYU1zTEdoRW15L0ppazNV?=
 =?utf-8?B?cTczQmptNGhkVVZnelJiZEVZaUN3TnFrb2ZydDJvNXlHaHdOZE1nd2NHdlVY?=
 =?utf-8?B?ME0vQjZ2ZnE4bzZYVVZOc3gxd0dMOHh3eFp6N1dmT0FxaXJqUTRXSUt6Tm90?=
 =?utf-8?B?MHJqZG9qcVpIWlJDbDZDNXFOejJoTHZDcG8wSEVJS3hIRm4wN21GRnNqVXM4?=
 =?utf-8?B?TTNVS0tqcklheitOT0U3NnV4MVNrdGIyeTI3UHR5ck1MVm84M1N6N0lNa1BL?=
 =?utf-8?B?aEZ0emNhQmRObkhNaVBTNVBFVVZiMWdOdnlZVFg5NkF6MGNMUldhKzNGaXg2?=
 =?utf-8?B?bzNTeU11WWthZEVZM2dCYldoZDIvY2NiSTFTaitkb2VTWTNVa25yY2tCdEZo?=
 =?utf-8?B?aHYrd3FnUm1xVmJ1MzZtVDFsOENMTzVkeVRBUDB3RkRoVGlWSDN5eXU0MEsv?=
 =?utf-8?B?ZWsxelVCTHpldlRiZ1Y5YnFnMkRCZklYOVlJZHRjZ0J1L01Pd01xZz09?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6449.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a99b76-0c0f-4cc6-467c-08da276e2e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 10:19:00.0049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTGb2tbc4lcPYasvkFEs6LG0RFoXn87Urrjvzvp9wDPGxPSGLRN7IF/oVDdkBqa66uMFO6mhiAs/0odAVWHB9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5822
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?utf-8?b?5Zue5aSNOiBbUEFUQ0ggdjNdIHN5c2NhbGxzL21vdW50X3Nl?=
 =?utf-8?q?tattr01=3A_Add_basic_functional_test?=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjNdIHN5
c2NhbGxzL21vdW50X3NldGF0dHIwMTogQWRkIGJhc2ljIGZ1bmN0aW9uYWwgdGVzdA0KPiANCj4g
SGkgQ2hlbiwgYWxsLA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2ZzbW91bnQu
aCBiL2luY2x1ZGUvbGFwaS9mc21vdW50LmgNCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIG1vdW50
X3NldGF0dHIoKQ0KPiA+ICsgKi8NCj4gPiArc3RydWN0IG1vdW50X2F0dHIgew0KPiBJZiB5b3Ug
YnVpbGQgb24gbmV3IGVub3VnaCBnbGliYyAoYW5kIGFwcGx5IHRvIHJlY2VudCBtYXN0ZXIpLCB5
b3UgZ2V0IGZhaWx1cmVzDQo+IGR1ZSBzdHJ1Y3QgcmVkZWZpbml0aW9uOg0KPiANCj4gSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIG1vdW50X3NldGF0dHIwMS5jOjM0Og0KPiAuLi8uLi8uLi8uLi9pbmNs
dWRlL2xhcGkvZnNtb3VudC5oOjQ4Ojg6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYc3RydWN0
DQo+IG1vdW50X2F0dHLigJkNCj4gICAgNDggfCBzdHJ1Y3QgbW91bnRfYXR0ciB7DQo+ICAgICAg
IHwgICAgICAgIF5+fn5+fn5+fn4NCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uLy4uLy4u
L2luY2x1ZGUvbGFwaS9tb3VudC5oOjExLA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi4vLi4v
Li4vLi4vaW5jbHVkZS9sYXBpL2ZzbW91bnQuaDoxNSwNCj4gICAgICAgICAgICAgICAgICBmcm9t
IG1vdW50X3NldGF0dHIwMS5jOjM0Og0KPiAvdXNyL2luY2x1ZGUvbGludXgvbW91bnQuaDoxMjk6
ODogbm90ZTogb3JpZ2luYWxseSBkZWZpbmVkIGhlcmUNCj4gDQo+IFRoaXMgaXMgZHVlIG15IHJl
Y2VudCBjaGFuZ2VzOg0KPiANCj4gYzBjYjVkMTk2ICgibGFwaS9tb3VudC5oOiBJbmNsdWRlIGtl
cm5lbC9saWJjIGhlYWRlciIpDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2pl
Y3QvbHRwL2NvbW1pdC9jMGNiNWQxOTYyZjcyMDY1ZGYyMmNkZGI3DQo+IDc0ZDUyNDZjOTA1NzYz
OQ0KPiANCj4gOGFlNTk2ZjhiICgibGFwaS9mc21vdW50Lmg6IEluY2x1ZGUgbGFwaS9tb3VudC5o
IGluc3RlYWQgbGliYyBoZWFkZXIiKQ0KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1w
cm9qZWN0L2x0cC9jb21taXQvOGFlNTk2ZjhiNTRkMGU4ODFkNWQ4ZDg0DQo+IGMxNTI4YjQ3Y2Vk
NzJlNjYNCj4gDQo+IFRoaXMgcmVxdWlyZXMgdG8gcHV0IGludG8gY29uZmlndXJlLmFjDQo+IEFD
X0NIRUNLX1RZUEVTKFtzdHJ1Y3QgbW91bnRfYXR0cl0sLCxbDQo+ICNpZmRlZiBIQVZFX0xJTlVY
X01PVU5UX0gNCj4gIyBpbmNsdWRlIDxsaW51eC9tb3VudC5oPg0KPiAjZWxzZQ0KPiAjIGluY2x1
ZGUgPHN5cy9tb3VudC5oPg0KPiAjZW5kaWYNCj4gXSkNCj4gDQo+IGFuZCBoZXJlIGNoZWNrIGZv
ciAjaWZuZGVmIEhBVkVfU1RSVUNUX01PVU5UX0FUVFINCj4gDQo+IE1heWJlIGl0IHdhc24ndCBh
IGdvb2QgaWRlYSB0byBjb21iaW5lIDxsaW51eC9tb3VudC5oPiBhbmQgPHN5cy9tb3VudC5oPg0K
PiAoc3RydWN0IGlzIG9ubHkgaW4gPGxpbnV4L21vdW50Lmg+KS4NCj4gDQo+IElmIHdlIGFncmVl
IG9uIGl0IGFuZCB0aGlzIGlzIHRoZSBvbmx5IGlzc3VlLCBpdCBjYW4gYmUgYXBwbGllZCBiZWZv
cmUgbWVyZ2UuDQoNClllcywgcGxzIGdpdmUgYSBoYW5kIPCfmIoNCg0KUmVnYXJkcywNCi0gQ2hl
bg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IFBldHINCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
