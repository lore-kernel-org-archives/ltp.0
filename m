Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B692EC433F5
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 02:09:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C298A3CA648
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 04:09:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A18763C12C4
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 04:09:06 +0200 (CEST)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0CFB51A00697
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 04:09:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1650334145; x=1681870145;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tXaC6YxF2i3fB7TpkYjgBByxotn2VrSu6drsC7Y6sZ0=;
 b=fhbn/L26PO8qtjYIIP8E8hJFwkBHQHWJtxc7SZ5HYF6Ywlgvk54fvzRP
 6SWznWAbo5KZxqzRAxeCPnQ4h9RiQRac5zGrcC/RGuBdDtEH59MM1USTT
 tYm50gpzCEfi1Q9lFG/bff+Ljx0b/cd/k/w/aguU0gXufcE8mNIr6ZW9W
 nIO4TmkdAlOGSwDA9ujYwVL4y0mYSepTaMlZ4OvkzTL81yEKXolWItZw1
 LMBM6pYxi60OGTutEAi139GEigVEcl1fKaJzT1I528KizEU4zuPY6Jhfu
 nOuWbRp+3NVTusjzFn5WRu5xAsMDaSRoqhaq4iXPPhQCIoPu2H50ymVfY g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="54101812"
X-IronPort-AV: E=Sophos;i="5.90,271,1643641200"; d="scan'208";a="54101812"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2022 11:09:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLvvGwjvYG9u19RePn+M1iNRxiooLJFZRPQssBuPcFNCQ+dnFpyAtAQcb7evkCqXBr/VxuAQPAyuGgbZAUQfc7N1+T8DiH6PYHVsGpr8477lKrjYgaNLSMKaTeq/jFNcViuyzlxRrwwA92kTSU6gJg/vbLOYgVI3N0XRF4l0YyaapQ0L/L6gvDgXm6iIFGgwDrXQM/zS3Zk/GdTTrm71dHHQwpOK3yHqzUXx/VvM2Snt6ZeaCQ5erqUbjPhTtSFsKfkC0UA/yz0WlrTWbQLYS/vG3ROpuZ+G8W7bYEYVSWGrPQV60xI/d+PgVCJxNGqU0aZ53YPRF/fOMVH7pZaJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXaC6YxF2i3fB7TpkYjgBByxotn2VrSu6drsC7Y6sZ0=;
 b=dPBP03dSsyl+cZ5Orh7qiJOM683Ad/to2ODN9aLSN1NIm/uxI8czF3ihk54qYsphybVWd+zTH2I9HSdtDBuBml4ilAvFw1nKsIEytKG3l/2SJQ8D0dqrF8nhBsWpCqxYzUppCy1MnI7rAZNyf18RxqfURGp79lDhjek4BMlNh2y9L0HI57sK2wJaKxDp8+BYvT9Nz0AkvcTS82gv8jFUWx0JRiJDsBkcItgcLzlFOS5TecVtZgJQrSWV/WMYNhrOM8CB+ctRbDPty9+UGC8RoGIZfW0t5rd1a/bklwZ6+7ch/26lK+pVjqXdyu2hnZIKrqCEdpu2AxGl7kUAacOECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXaC6YxF2i3fB7TpkYjgBByxotn2VrSu6drsC7Y6sZ0=;
 b=WAHBuqwQpBeQNpZXPOj7UAGObZFr0+ChqNlCP78FN2eaOcyWRxUyPbjgALaCzr+Cq8fe4jV91ZONIZ5cD3Hx/ZIRy65MNNZdn69DfzCLPGXAYKDOCs4+KPCI84L2sIAlFjl0qQT8ZAwdoBUtyFgtD8QViJlom8gC37ZH0EmyLEc=
Received: from TYCPR01MB6462.jpnprd01.prod.outlook.com (2603:1096:400:77::6)
 by TYWPR01MB8901.jpnprd01.prod.outlook.com (2603:1096:400:17c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 02:08:59 +0000
Received: from TYCPR01MB6462.jpnprd01.prod.outlook.com
 ([fe80::5d98:2aee:768d:86e0]) by TYCPR01MB6462.jpnprd01.prod.outlook.com
 ([fe80::5d98:2aee:768d:86e0%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 02:08:59 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, "daisl.fnst@fujitsu.com"
 <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH] syscalls/mount_setattr01: Add basic functional test
Thread-Index: AQHYNE9kfiaWT7KWAESuveV7OGAdRay4lo4AgD4lkYA=
Date: Tue, 19 Apr 2022 02:08:58 +0000
Message-ID: <TYCPR01MB64622D276C488C71C507254AE6F29@TYCPR01MB6462.jpnprd01.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: cb45138c-4a32-437a-84e0-08da21a990fd
x-ms-traffictypediagnostic: TYWPR01MB8901:EE_
x-microsoft-antispam-prvs: <TYWPR01MB89014780E4C7070C77096563E6F29@TYWPR01MB8901.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0aU8Qvv6Yflf44mE5XUAzuQ7uUmIUFmvrzaJ+E7c+qSUti76edqz/uef6HuUUhg8cbpwioIbOrg/+V+3j12siFECHsOW4TFHEZEYHCx69+Yg98+eWfIr5qxLE0IGQ0/6r8UPYNYj8D/rm5lxnviuculps7ZGxB3gPBk0iBuXMZPhtkeIAlRwa1wLEHEab5SvMvIbAmGhRE1J9F/KgzYbbjcuJjIJR2nAv5eV7+fAO6qHyaC1RZEk6wJffFX72+a0B2WZNJpr+eOcTJVuTQFJkM+uh7EUv0apKrR8KVEyQAh/ONQGSApiistZSER1Y4ZqBZdZbEf7vsIXauVQCkVYQs95S/i9nzP4SZt1e6OKlakDF3Dy0IQNKwjjaAm7FDpG6RbsI+HkxFlKuBp1RpoUY7W1oxtBZ1k7vzTHrJ8sI2Nykjj7WHtEPkSZpEfZ0LvKOuanbre6iCwewaUoiR2A1v2cNlIZXGyfSqJKA3lfFvG9eJHd0+kIm3gIud2QTykonRass1TY1rHzYwjCf5Sgcn1lxDIaThDodYTP/814x+8kHY8otTX5sYxWpwf09uhvkOyF/6Iqxy6OS0+fmrlYiWUHLnX1ypUeoJQEyMKqkyqzB/12eXDT+rZTnyD51vCD1Y1tkm00FHjZO/TlyX+M1Ytv6bM5D6QuWkS06fV+KkBGltcieHTxLb1/P+YsbkM/GyqlI10IWK2AkWIhvbzQU33wQP7TdrZlBWbZ0WBZeb8Ml8Affmwe0Bs6LcXR3scrf2DvgzT+cxqZ/dmHYnElO8luuUVQihL/0G35czWjr+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6462.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(33656002)(82960400001)(71200400001)(110136005)(38100700002)(7696005)(83380400001)(316002)(122000001)(6636002)(6506007)(55016003)(2906002)(4326008)(86362001)(85182001)(966005)(224303003)(508600001)(76116006)(9686003)(66556008)(66446008)(38070700005)(5660300002)(64756008)(66476007)(66946007)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?clRNa2tvQkRFZExGbGtvNTI0aGNjVEFLQzNqVHRaUlNlYXJTUW5NdWRsck1h?=
 =?gb2312?B?T0RVbHc0ZjE4ejV0ODZESHhKZkE4THhEUjl3ekcvYzYzdnR1aFFRTXJsRHVF?=
 =?gb2312?B?MGM4OUpBV2pKdW5tQnpqZkgzT1pEMFBwS1lXYWhyTGxJeGdOR3JRMVMzbXY3?=
 =?gb2312?B?QmpPcDBNWGtkazZWWldnRWhyZzdMM3VvcTRUNkZOL29NS29pamxGNkF1UkZs?=
 =?gb2312?B?TExRMGRvYnRmT25ybm9zdGRoWjJZS29EdDh3ZzczcEZpdkNDVVVsUWo4UStl?=
 =?gb2312?B?clhZdElwTFNYTTBLRk15R0taNXo2N0ozYWlxYnI4MldjeVp2SStUckw5L3g5?=
 =?gb2312?B?ZEZkZ0doeVNRVGtrc21hL3k2Ym9Ub2oxSHRKbmtoZTlRWld0YTRDWTl3L0Jx?=
 =?gb2312?B?TVNnanIwb1hicWg4bHhQV25UbjhrRnBuNkl0dGhlelU2dE1jYkNQV05NaWJs?=
 =?gb2312?B?VE5tV1FvWHdMK1JqR2tWUDBCMSsxZU45UnpQc2s3dzltb25FK1B5MkxzOU1h?=
 =?gb2312?B?Qldmdld5b2I3SExPMHVIeUZlbVNidzRwdXR5aGdoOXVHTlRzSnlIVDlJbCtX?=
 =?gb2312?B?Y0NiRVJKaGplMXpveENuaW00QTRYN3NjVWJlQzEzN0owbmtYN0g3SUZNMGZu?=
 =?gb2312?B?UTN5RmFlaFVkU0hHMk5ROWEvRHZtelU0ZWVSUGRZYkdlVGxkNFlvMzBOa29G?=
 =?gb2312?B?L2hWQllVRDNFclptTEx0WnRVWk5JTGlsdlUwMXovUmJWalNaRWxSMlJuNmh3?=
 =?gb2312?B?M0N4K016SmZmbGVmYXp6MERQZE53a2pHbVY5Sm9jekkxczJ1RWJ3dzlhSFY2?=
 =?gb2312?B?YitFQUZCVWJtMGhzTlY2akpIazFoRitxd2s0YUZEVGhoQitKZWJrRXR4SWsx?=
 =?gb2312?B?cnhmNGljdVFNbmRiMC8zMWR0bFhkdC9VZENKa2Vuc2pJSi9pZ0w1Rml1Qng0?=
 =?gb2312?B?bTZqSVE3ZmRMZnZwRzhaR1lES3NDMDY4L2JNUnZtdmlOZHdtbVFXbzRLMldV?=
 =?gb2312?B?Y2s4Tm13bTYvb0hMcmNqS2VBdG1qYTcvWlEyd3UxS2FVVWJJL2wxUWpGSlpq?=
 =?gb2312?B?NVdsbnRQR1ZpUE9vNFJLVE9LUWM3WkVEWnVGeVhpVTZPdlUrTzlQRTRZQTBK?=
 =?gb2312?B?VXROc2tvN010dWJ5aFhKNVRUaWZ6Nis1NkZYVTBlS2YwU3J0cnpROGhSU0pS?=
 =?gb2312?B?T1lveHRNdkEyb0NhQVlUSUhTcSt2ZktSV2VTdGRnZ0orVkRnZHVRRlRqa20v?=
 =?gb2312?B?azljQitBbUdSc1huZk5ycGVXT1E2TVRsT0RqWWZZc3VyUkJxRy9saFo3WkFi?=
 =?gb2312?B?eUcyWmpKcTZCbzFWcmc0UlFjY0tmM2dPSEl6Y3N6VTkxdFNGYlNYWDhOMmZq?=
 =?gb2312?B?NDc3Sk8wU2NnZHhUMHBYa05RelB6RFJycDI2OGY5UjBXK3hzbDZDNmQ3aDZQ?=
 =?gb2312?B?cjRSbFEwaGpUYVZiWGs5aUVpdFJ1eXdEcWdTRXNqRnhLYkczeitLeUNRK014?=
 =?gb2312?B?ejFSclIrd0hIR3YzZlgwN1RIdXdSbXkzcUlpZ0VRRTMwWmwyTFdXbjJjTnZ4?=
 =?gb2312?B?bTdXWlIrajY1Wkw4SUZmb09RMm9wR0tQdDNRN3IxZ3RuWFEwcUlkRlVNQU9k?=
 =?gb2312?B?allGY1g5b0JVNVIrYk5ENmxkODZycXIyUVNvdkcwQmliNXZQcTBXczlPTk5T?=
 =?gb2312?B?SEVGcWJJNHltY3d1VDRSRlZxUWhCUzFNb2cwMzUwbko4VVZKeE56V2ZLL1NH?=
 =?gb2312?B?WHB6NjFMd05udHBkRS9xQ09ZUkZYdmsxZGlWZHdWR2l4TnhVMnZuZmdkOVJH?=
 =?gb2312?B?MXh1VWFOMllZelllbFB4bHJ4V29LVHNiR2tiZ1FITk1oVm9NRzMrY3FNNnpw?=
 =?gb2312?B?ak1hemkwa0NlZm9IYjRWSzZ0WXNxcVZQVGI1SXR6UGw1ZXZ1azlZN3NPNzlp?=
 =?gb2312?B?a2NobllMU3ovL0p0cWMrUXlQbUpoeG5WMVQxbDZUcFkwZWUyVjBkNnBjQzEy?=
 =?gb2312?B?UkR0cW9PWW1ITThTRnFsVjhvR2NjY3kyejAvMTlWT08rTldHbnpIdWFTQ29l?=
 =?gb2312?B?NHg2bW00c2o4SFV4NWcxdTJhbDNOdXgxejVwamdjSXV0UXRnTFRJWU5WUGdk?=
 =?gb2312?B?a3V2Z3VWTFM5Z2tHdElwbjR5TzdaMTNlajY3UjZGeHU4bGdVT1BDM2lXS2VD?=
 =?gb2312?B?bzQrdytqeUxITHE5aFRjUUtqcDFHclpNNkdjbHBWTHZJWXBFWndKK0VDWmFp?=
 =?gb2312?B?Z2xHMjN1YlBwZ2tIb2o1QjVhMnZsMUM2VlJmSDhJak9xRUxJcTNwRnJ2K3ZZ?=
 =?gb2312?B?U0kvdTZZN2RnaFVXbHA4bTB6Vy8wekdueGJ0Tk9Jd0dNK3Nqa015UT09?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb45138c-4a32-437a-84e0-08da21a990fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 02:08:58.9414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8b+gBgekCqnIkWCNq+iAG9JvjQ3drdbQJzMPbGPQaHhlRSpo1hS+EmUwz80Xm/u0V01JDLMCFA/qfgtLe5IhJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8901
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
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
ZW5oeC5mbnN0PWNuLmZ1aml0c3UuY29tQGxpc3RzLmxpbnV4Lml0PiC0+rHtIA0KPiBDeXJpbCBI
cnViaXMNCj4gt6LLzcqxvOQ6IDIwMjLE6jPUwjEwyNUgMjE6MDYNCj4gytW8/sjLOiBEYWksIFNo
aWxpIDxkYWlzbC5mbnN0QGZ1aml0c3UuY29tPg0KPiCzrcvNOiBsdHBAbGlzdHMubGludXguaXQN
Cj4g1vfM4jogUmU6IFtMVFBdIFtQQVRDSF0gc3lzY2FsbHMvbW91bnRfc2V0YXR0cjAxOiBBZGQg
YmFzaWMgZnVuY3Rpb25hbCANCj4gdGVzdA0KPiANCj4gSGkhDQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGFwaS9mc21vdW50LmggYi9pbmNsdWRlL2xhcGkvZnNtb3VudC5oIGluZGV4IA0KPiA+
IGZhMjUzMDYuLjk5ZDBhMGEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9sYXBpL2ZzbW91bnQu
aA0KPiA+ICsrKyBiL2luY2x1ZGUvbGFwaS9mc21vdW50LmgNCj4gPiBAQCAtMTUsNiArMTUsMjYg
QEANCj4gPiAgI2luY2x1ZGUgImxhcGkvZmNudGwuaCINCj4gPiAgI2luY2x1ZGUgImxhcGkvc3lz
Y2FsbHMuaCINCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBNb3VudCBhdHRyaWJ1dGVzLg0KPiA+ICsg
Ki8NCj4gPiArI2RlZmluZSBNT1VOVF9BVFRSX1JET05MWSAgICAgICAweDAwMDAwMDAxIC8qIE1v
dW50IHJlYWQtb25seSAqLw0KPiA+ICsjZGVmaW5lIE1PVU5UX0FUVFJfTk9TVUlEICAgICAgIDB4
MDAwMDAwMDIgLyogSWdub3JlIHN1aWQgYW5kIHNnaWQNCj4gYml0cyAqLw0KPiA+ICsjZGVmaW5l
IE1PVU5UX0FUVFJfTk9ERVYgICAgICAgIDB4MDAwMDAwMDQgLyogRGlzYWxsb3cgYWNjZXNzIHRv
DQo+IGRldmljZSBzcGVjaWFsIGZpbGVzICovDQo+ID4gKyNkZWZpbmUgTU9VTlRfQVRUUl9OT0VY
RUMgICAgICAgMHgwMDAwMDAwOCAvKiBEaXNhbGxvdyBwcm9ncmFtDQo+IGV4ZWN1dGlvbiAqLw0K
PiA+ICsjZGVmaW5lIE1PVU5UX0FUVFJfTk9ESVJBVElNRSAgIDB4MDAwMDAwODAgLyogRG8gbm90
IHVwZGF0ZQ0KPiBkaXJlY3RvcnkgYWNjZXNzIHRpbWVzICovDQo+ID4gKyNkZWZpbmUgTU9VTlRf
QVRUUl9OT1NZTUZPTExPVyAgMHgwMDIwMDAwMCAvKiBEbyBub3QgZm9sbG93DQo+IHN5bWxpbmtz
DQo+ID4gKyovDQo+IA0KPiBUaGVzZSBoYXZlIHRvIGJlIGRlZmluZWQgb25seSBpZiB0aGV5IGFy
ZSBtaXNzaW5nLCBvdGhlcndpc2Ugd2Ugd2lsbCANCj4gZW5kIHVwIHdpdGggcmVkZWZpdGlvbiB3
YXJuaW5ncyBvbmNlIGdsaWJjIGFkZCB0aGVzZSBjb25zdGFudHMsIGkuZS4NCj4gDQo+ICNpZm5k
ZWYgTU9VTlRfQVRUUl9SRE9OTFkNCj4gIyBkZWZpbmUgTU9VTlRfQVRUUl9SRE9OTFkgMHgwMDAw
MDAwMQ0KPiAjZW5kaWYNCj4gDQoNCkdldCBpdC4NCj4gLi4uDQo+IA0KPiA+ICsvKg0KPiA+ICsg
KiBtb3VudF9zZXRhdHRyKCkNCj4gPiArICovDQo+ID4gK3N0cnVjdCBtb3VudF9hdHRyIHsNCj4g
PiArCV9fdTY0IGF0dHJfc2V0Ow0KPiA+ICsJX191NjQgYXR0cl9jbHI7DQo+ID4gKwlfX3U2NCBw
cm9wYWdhdGlvbjsNCj4gPiArCV9fdTY0IHVzZXJuc19mZDsNCj4gDQo+IFRoZXNlIHNob3VsZCBi
ZSB1aW50NjRfdCwgd2UgY2Fubm90IHVzZSB0aGUga2VybmVsIHR5cGVzIGluIHVzZXJzcGFjZS4N
Cj4gDQpPSy4NCg0KPiA+ICt9Ow0KLi4uDQo+ID4gKyNkZWZpbmUgTU5UUE9JTlQgICAgICAgICJt
bnRwb2ludCINCj4gPiArI2RlZmluZSBPVF9NTlRQT0lOVCAgICAgIm90X21udHBvaW50Ig0KPiA+
ICsjZGVmaW5lIFRDQVNFX0VOVFJZKF9tb3VudF9hdHRycykJey5uYW1lID0NCj4gI19tb3VudF9h
dHRycywgLm1vdW50X2F0dHJzID0gX21vdW50X2F0dHJzfQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4NCj4gUGxlYXNlIGRvIG5vdCB1c2UgaWRlbnRpZmllcnMgc3RhcnRpbmcgd2l0aCB1
bmRlcnNjb3JlLCB0aGVzZSBhcmUgDQo+IHJlc2VydmVkIGZvciBrZXJuZWwgYW5kIGxpYmMuDQo+
IA0KU3VyZS4NCg0KPiA+ICsNCj4gPiArc3RhdGljIGludCBkaXJfY3JlYXRlZDsNCj4gPiArDQo+
ID4gK3N0YXRpYyBzdHJ1Y3QgdGNhc2Ugew0KPiA+ICsJY2hhciAqbmFtZTsNCj4gPiArCXVuc2ln
bmVkIGludCBtb3VudF9hdHRyczsNCj4gPiArfSB0Y2FzZXNbXSA9IHsNCj4gPiArCVRDQVNFX0VO
VFJZKE1PVU5UX0FUVFJfUkRPTkxZKSwNCj4gPiArCVRDQVNFX0VOVFJZKE1PVU5UX0FUVFJfTk9T
VUlEKSwNCj4gPiArCVRDQVNFX0VOVFJZKE1PVU5UX0FUVFJfTk9ERVYpLA0KPiA+ICsJVENBU0Vf
RU5UUlkoTU9VTlRfQVRUUl9OT0VYRUMpLA0KPiA+ICsJVENBU0VfRU5UUlkoTU9VTlRfQVRUUl9O
T1NZTUZPTExPVyksDQo+ID4gKwlUQ0FTRV9FTlRSWShNT1VOVF9BVFRSX05PRElSQVRJTUUpLA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQ0KPiA+ICt7DQo+
ID4gKwlpZiAoZGlyX2NyZWF0ZWQpDQo+ID4gKwkJU0FGRV9STURJUihPVF9NTlRQT0lOVCk7DQo+
IA0KPiBObyBuZWVkIHRvIHJtZGlyIGFueXRoaW5nLCBpdCB3aWxsIGJlIHJlbW92ZWQgYnkgdGhl
IHRlc3QgbGlicmFyeSANCj4gYWxvbmcgd2l0aCB0aGUgdGVzdCB0ZW1wb3JhcnkgZGlyZWN0b3J5
Lg0KPiANCg0KVGhlcmUgYXJlIHNldmVyYWwgZmlsZSBzeXN0ZW1zIHRvIGJlIHRlc3RlZC4gSWYg
d2UgZG8gbm90IHJtZGlyLCBpdCB3aWxsIGJlIGVycm9yKGRpciBpcyBFRVhJU1QpIHdoZW4gdGVz
dGluZyB0aGUgc2Vjb25kIGZpbGUgc3lzdGVtLg0KDQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyB2b2lkIHNldHVwKHZvaWQpDQo+ID4gK3sNCj4gPiArCWZzb3Blbl9zdXBwb3J0ZWRfYnlfa2Vy
bmVsKCk7DQo+ID4gKwlTQUZFX01LRElSKE9UX01OVFBPSU5ULCAwNzc3KTsNCj4gPiArCWRpcl9j
cmVhdGVkID0gMTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVk
IGludCBuKQ0KPiA+ICt7DQo+ID4gKwlpbnQgb3RmZDsNCj4gPiArCXN0cnVjdCB0Y2FzZSAqdGMg
PSAmdGNhc2VzW25dOw0KPiA+ICsJc3RydWN0IG1vdW50X2F0dHIgYXR0ciA9IHsNCj4gPiArCQku
YXR0cl9zZXQgPSB0Yy0+bW91bnRfYXR0cnMsDQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCVRFU1Qo
b3RmZCA9IG9wZW5fdHJlZShBVF9GRENXRCwgTU5UUE9JTlQsIEFUX0VNUFRZX1BBVEggfA0KPiA+
ICsJCUFUX1NZTUxJTktfTk9GT0xMT1cgfCBPUEVOX1RSRUVfQ0xPRVhFQyB8DQo+IE9QRU5fVFJF
RV9DTE9ORSkpOw0KPiA+ICsJaWYgKG90ZmQgPT0gLTEpIHsNCj4gPiArCQl0c3RfcmVzKFRGQUlM
IHwgVFRFUlJOTywgIm9wZW5fdHJlZSgpIGZhaWxlZCIpOw0KPiA+ICsJCXJldHVybjsNCj4gPiAr
CX0NCj4gDQo+IFRoaXMgY2FuIGJlIGp1c3QgVFNUX0VYUF9GRCgpDQpPSy4NCg0KPiANCj4gPiAr
CVRFU1QobW91bnRfc2V0YXR0cihvdGZkLCAiIiwgQVRfRU1QVFlfUEFUSCwgJmF0dHIsIHNpemVv
ZihhdHRyKSkpOw0KPiA+ICsJaWYgKFRTVF9SRVQgPT0gLTEpIHsNCj4gPiArCQl0c3RfcmVzKFRG
QUlMIHwgVFRFUlJOTywgIm1vdW50X3NldGF0dHIoKSBzZXQgYXR0ciAlcyBmYWlsZWQuIiwNCj4g
dGMtPm5hbWUpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gDQo+IGFuZCB0aGlzIGNhbiBi
ZSBUU1RfRVhQX1BBU1MoKQ0KPiANCk9LLg0KDQo+IA0KPiBBbmQgaGVyZSB3ZSBzaG91bGQgY2hl
Y2sgaWYgdGhlIGF0dHJpYnV0ZSB3YXMgcmVhbGx5IGNoYW5nZWQuDQo+IA0KPiBJIGd1ZXNzIHRo
YXQgd2UgY2FuIGFkZCBmdW5jdGlvbnMgdG8gdmVyaWZ5IG1vc3Qgb2YgdGhlIGF0dHJpYnV0ZXMs
IGUuZy4NCj4gZm9yIFJET05MWSB3ZSBjYW4gYWRkIGEgZnVuY3Rpb24gdGhhdCB0cmllcyB0byBv
cGVuIGZpbGUgZm9yIHdyaXRpbmcgDQo+IGFuZCBleHBlY3RzIHRoYXQgaXQgZmFpbHMgd2l0aCBF
Uk9GUyBpZiB0aGUgYXR0cmlidXRlIGhhcyBiZWVuIHNldC4NCj4gDQoNCkd1ZXNzIHN0YXR2ZnMo
MykgbWF5IGhlbHAuDQoNCj4gPiArCWF0dHIuYXR0cl9jbHIgPSB0Yy0+bW91bnRfYXR0cnM7DQo+
IA0KPiBUaGlzIGRvZXMgbm90IGhhdmUgYW55IGVmZWN0IGF0IGFsbCB1bmxlc3Mgd2UgYWxzbyBy
ZXNldCBhdHRyX3NldC4NCj4gQWNjb3JkaW5sZ3kgdG8gdGhlIG1hbnVhbCBwYWdlIGtlcm5lbCBm
aXJzdCBjbGVhcnMgYXR0cmlidXRlcyB0aGVuIA0KPiBzZXRzIHRoZW0sIHNvIGFzIGxvbmcgYXMg
dGhlIGF0dHJfc2V0IHJlbWFpbnMgc2V0IHRvIHRjLT5tb3VudF9hdHRycyANCj4gdGhlIGZvbGxv
d2luZw0KPiBtb3VudF9zZXRhdHRyKCkgaXMgbm8tb3AuDQo+IA0KV2lsbCBiZSBkZWxldGVkIGlu
IHYyLg0KDQo+ID4gKwlURVNUKG1vdW50X3NldGF0dHIob3RmZCwgIiIsIEFUX0VNUFRZX1BBVEgs
ICZhdHRyLCBzaXplb2YoYXR0cikpKTsNCj4gPiArCWlmIChUU1RfUkVUID09IC0xKSB7DQo+ID4g
KwkJdHN0X3JlcyhURkFJTCB8IFRURVJSTk8sICJtb3VudF9zZXRhdHRyKCkgY2xlYXIgYXR0ciAl
cyBmYWlsZWQuIiwNCj4gdGMtPm5hbWUpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gDQo+
IFRoaXMgY2FuIGJlIGp1c3QgVFNUX0VYUF9QQVNTKCkNCj4gDQo+IEFuZCBoZXJlIHdlIHNob3Vs
ZCBjaGVjayB0aGF0IHRoZSBhdHRyaWJ1dGUgaGFzIGJlZW4gcmVzZXQsIGUuZy4gZm9yIA0KPiBS
RE9OTFkgYXR0cmlidXRlIHdlIHNob3VsZCBjaGVjayB0aGF0IGZpbGVzIGNhbiBiZSBvcGVuZWQg
Zm9yIHdyaXRpbmcgYWdhaW4uDQo+IA0KDQo+IA0KPiA+ICsJVEVTVChtb3ZlX21vdW50KG90ZmQs
ICIiLCBBVF9GRENXRCwgT1RfTU5UUE9JTlQsDQo+IE1PVkVfTU9VTlRfRl9FTVBUWV9QQVRIKSk7
DQo+ID4gKwlpZiAoVFNUX1JFVCA9PSAtMSkgew0KPiA+ICsJCXRzdF9yZXMoVEZBSUwgfCBUVEVS
Uk5PLCAibW92ZV9tb3VudCgpIGZhaWxlZCIpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4g
DQo+IEkgZG8gbm90IGdldCB3aHkgd2UgZG8gbW92ZSB0aGUgbW91bnQgYXQgYWxsLCB0aGlzIGlz
IHN1cHBvc2VkIHRvIGJlIGEgDQo+IHNpbXBsZSB0ZXN0IGZvciBtb3VudF9zZXRhdHRyKCkuDQoN
Cm1vdmVfbW91bnQgcGxhY2UgdGhlIGZpbGVzeXN0ZW0gaW50byBhIG1vdW50IG5hbWVzcGFjZSBh
bmQgdGhlbiBpdCB3aWxsIGJlIHZpc2libGUgdG8gdXNlcnMuDQoNCkknbGwgcG9zdCBhIHYyIHBh
dGNoIHNvb24uDQoNClJlZ2FyZHMsDQotIENoZW4NCg0KPiANCj4gPiArCVNBRkVfQ0xPU0Uob3Rm
ZCk7DQo+ID4gKw0KPiA+ICsJaWYgKHRzdF9pc19tb3VudGVkX2F0X3RtcGRpcihPVF9NTlRQT0lO
VCkpIHsNCj4gPiArCQlTQUZFX1VNT1VOVChPVF9NTlRQT0lOVCk7DQo+ID4gKwkJdHN0X3JlcyhU
UEFTUywgIm1vdW50X3NldGF0dHIoKSBzZXQgYW5kIGNsZWFyIGF0dHIgJXMgcGFzc2VkLiIsDQo+
IHRjLT5uYW1lKTsNCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCB0
c3RfdGVzdCB0ZXN0ID0gew0KPiA+ICsJLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksDQo+ID4g
KwkudGVzdCA9IHJ1biwNCj4gPiArCS5zZXR1cCA9IHNldHVwLA0KPiA+ICsJLmNsZWFudXAgPSBj
bGVhbnVwLA0KPiA+ICsJLm5lZWRzX3Jvb3QgPSAxLA0KPiA+ICsJLm1vdW50X2RldmljZSA9IDEs
DQo+ID4gKwkubW50cG9pbnQgPSBNTlRQT0lOVCwNCj4gPiArCS5hbGxfZmlsZXN5c3RlbXMgPSAx
LA0KPiA+ICsJLnNraXBfZmlsZXN5c3RlbXMgPSAoY29uc3QgY2hhciAqY29uc3QgW10peyJmdXNl
IiwgTlVMTH0sIH07DQo+ID4gLS0NCj4gPiAxLjguMy4xDQo+ID4NCj4gPg0KPiA+IC0tDQo+ID4g
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwDQo+
IA0KPiAtLQ0KPiBDeXJpbCBIcnViaXMNCj4gY2hydWJpc0BzdXNlLmN6DQo+IA0KPiAtLQ0KPiBN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHANCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
