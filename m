Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB2CC3DA6F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 11:30:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90A1B3CC3B2
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 13:30:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1422F3CC186
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 13:30:08 +0200 (CEST)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72FC260090B
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 13:30:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692963007; x=1724499007;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=dL+TDVgSuxIdnDflW7vIgfdXBoFJRXOpLxWCNCM1PQs=;
 b=f1M1WKl9p7JL6OilZR+5HG9aPUM1RQggHPRCzAX9dS/1es6AD4khZM0b
 o11Tvmh+z69ZLyyEFG1pxLZGvnGwC8CXHdg32dy9M8urw/L9LR+ue1tY4
 m9FK9GLHCYYn6NthSwYeMg6cZ1vpm9DU7eOrXnO5HYkYoBmpo96+nc8/T
 MBSOmkfNcl1xLdF+H+wyiaJxmZtGy++2xNQzwRKO/Nkiv7ZjxBY9FJTrz
 guKnsmXRW7fCESLFa+F1tOU9GmEw6F8qG9gxco1w7QVU5tOu0Z1t5fIyu
 /6ysSSD6dR98jqEgch7ugyptxD2HuIp/eOo7RJe6w0xwBMKTdXnirhhfF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="93325869"
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; d="scan'208";a="93325869"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 20:30:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3q/d1pFLGlqrzypaVmjzfid6pKNpTpYwhuBSrhtwLcocv0pLmZj7ZB/iuRB/GlAuy6u28nxAw8hGAFMK/CIgliAmfqHVjUPg2AiF20WhLK7UIrMakiX+MWqgiFF43qs+Ydxu18tLRA3SJJiahvV3THvNugq/F8HmJdhWV30T4Kz13/ygv/4MVyTOC+NPWWXzQ7+JAnIgYTggeQQYzJz5651AUyztZpMWwAIwzCxbb6zAEgOmqh/VXBh2TNN2/cn5dwa1djssI01w1QJWKaKbXg2LImENmvbp77sSZuTsPnBF3DDdfveo7yjDIDbfbCdM+n6qR2jyopZkoPt1pkHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL+TDVgSuxIdnDflW7vIgfdXBoFJRXOpLxWCNCM1PQs=;
 b=GmN9paqopQESHj/ckQRAJQ146u09kb9kb68vIaemGtsetL1h9xlRVO586Ga+O7O2+qQ+yKfHbUnZnVdoEZlsvYxe9O2F/hI834a40LLu9r5e6gEWsmWw5zN22cPvp/ic/l2N/52MujXA4As0PJYXTXRSf7xqUgEtB3seAovZDJbJdzhtldtK8kEL2h5a+dzEDSUU+ly1APP+IDK52UAIIBahuKikcA8l2ogfXeCLtnEGSlbCpoQ/4zZvezept6H+LmFEeiXdvqTPYDH4pYl1fg/pvPfR1WP0TEj1cjBt3DnEwdaR/MfMjoLCNX4w1/RZxcE631L4Ki8CcWrMyftM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB10723.jpnprd01.prod.outlook.com
 (2603:1096:400:31c::14) by OSZPR01MB8324.jpnprd01.prod.outlook.com
 (2603:1096:604:180::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 11:30:01 +0000
Received: from TY1PR01MB10723.jpnprd01.prod.outlook.com
 ([fe80::322d:8a4:4aa1:e8a5]) by TY1PR01MB10723.jpnprd01.prod.outlook.com
 ([fe80::322d:8a4:4aa1:e8a5%7]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 11:30:01 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/2] hugeshmctl01: Mark struct tcase as static
Thread-Index: AQHZ1nu6ZlnA2NYZAUWfjY4HdcP7Y6/6uf0AgAAoAgA=
Date: Fri, 25 Aug 2023 11:30:01 +0000
Message-ID: <b0a74844-4ec7-7aa8-4bb7-a55f56bb483f@fujitsu.com>
References: <1692875480-22494-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <68d82f6f-2c42-0c2d-3d8a-618d387675dc@fujitsu.com>
In-Reply-To: <68d82f6f-2c42-0c2d-3d8a-618d387675dc@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB10723:EE_|OSZPR01MB8324:EE_
x-ms-office365-filtering-correlation-id: 98a5c1ef-2f2d-414a-fc15-08dba55e9f02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlbrWXkdLXVijvbq6btzl2GczLyjR/qinsqirpZm/vbvUKk1y7F/lj4CmcKBDxwpyLXf/KeqvdYFTUHWTo/BjGK2SiQGrCFX4m35e/gxoe/lpeomPLJ5TKhNvNg7W+O3pSOuSxiwLthy1unc4iIbmJiOlOFxwy9FlcaR5bYMKRwz6N9sCi+UHUCyWJ5+WVIscNDgCERAn19gzcp9sEjpssvMQmHOP77CO+E3PmHEfJa+Ae32NcXklvsO6nn7mCmPDporypCk/pOPvcRhuFptuqb3jOcU6L0ZG9f4xbr3dpPHm/RwJkz018gsGJQFz30AipMXoFg33x9bFfr1NMdunkjTE3ibAyl7pGyZ3St9bonCL7j5aaZSErFwlIusNm2QXeYKu9xUwUavuO9uCrANu3ITUFS4bgRR2oadjtaJX+Ut+MUtZKL6YcO4X3+/qF2ZfNcrVTE8I0xHirBQ1n2W4uqwCo1N8muTw/WKfoOWe+M6pBwwiZIhN+Q65SsEWtsAPBJlg/F1A5htCSIowxT/a6Ot7LokXUF1a6v54mg4FS3Drgl3W4KK36GXHW/a54kCmj3ywVxltMmG8ZpFpKuvdheEjEpQk0r/cZ/xB6Had/UmoQ2w8t+bhBvbtbU//mpP927rGmbpUyYJzYYh7WSNXh8vnTVraPPhPHgXE2RIKiTzmBq4l3YxiFVcuQAICHju
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB10723.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199024)(1590799021)(1800799009)(186009)(82960400001)(122000001)(38100700002)(38070700005)(1580799018)(8676002)(8936002)(85182001)(64756008)(31696002)(41300700001)(6486002)(6506007)(53546011)(316002)(91956017)(36756003)(66446008)(66476007)(66556008)(110136005)(66946007)(76116006)(86362001)(71200400001)(6512007)(26005)(478600001)(83380400001)(31686004)(2906002)(2616005)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0E4cEFJNmN2S1AvR0xaY0x6anppRlpacmViL2x5TGQvQWpGU2JLeVV3M1Qx?=
 =?utf-8?B?NDlTek16Skt4UlNjK0tHM0hSNGF0ZFV5K2ZxQ1B2S1cwU1pJTUFUMUw2V1F0?=
 =?utf-8?B?MFNoZ0N5K2hOUXNySnk2d0hDNDBSU3dPWFBCWjAwNk1RcU5KMGJ5ek15VmxL?=
 =?utf-8?B?QmgvRk1PZVlHeFMrVm1lbzl5RHZzRUMrYTNuK1VjV0JlS0tCTzN6OFYrdm5I?=
 =?utf-8?B?eDFKcFU3dDBnUi8xTXZ4dFNNMWJoM0tLdGN5MHNBU3dTaTlXSEUvQ3NZalIy?=
 =?utf-8?B?bDFydU5SdzZJVE5ZV2Y4WndoeVcrcE5uUVZwaHEwYW9JaG5FclM4alpId01s?=
 =?utf-8?B?UllaeXZHOU00b1dwUVlKemc1Q2dTbU9ZckVQeGYwU1dhQmp3RVNhQmI0c0J5?=
 =?utf-8?B?SkVmbjJDdmhXY0VJQW9DcmMyWWdBWHNpcDBNNmhGdlZ3cVRDR0lIajNhTWpZ?=
 =?utf-8?B?ZDJlTkdCTzZOMU1NOGpmWWZiRDNyWXhYcmxHaHNKMDczT1o4YmYzTUNvZk5I?=
 =?utf-8?B?Zm5vU0xTTnJ6ZS9DSm91dmdQOXpydGZqQUMza3U3cFExQjA1bjBnSXdDdTIz?=
 =?utf-8?B?MnIzWjFNKzFVdnZaU3RyWFNSb2VxSFk3bHVqL21LTXpWSlV5YllwYVNPQml1?=
 =?utf-8?B?VER6V3ZFL1psdGIrVlN6VUJSOHdHVlJ3Sm90VFVSSW1NMnBNOHZqc1JMamNy?=
 =?utf-8?B?MEE3K0Iyc1gvaVZac1Ewa2hadWZyVFhNRktPd2tsU1BnVFVzUyt3T1RYV1NK?=
 =?utf-8?B?bDRYTm92QmU0SjFuRm1YMnVlQ3RNSDNSd2FnUmdDVldHb1pQWHBrcWF1V0w3?=
 =?utf-8?B?WkpDNmNTNEpyVHI0WnN2alYvS25GYTUrd0x6TzJQZjdmMDJ5dGc0U1dUUnZq?=
 =?utf-8?B?M0IyNW5ENHczTHlWcTUrcHVFd1l1UEZ5Vlh4OGpKcHFjNFhyRFduZnFTT0hW?=
 =?utf-8?B?UnI0eGtGN0FaOFBkYWlWd3AzQ21aK05GYnk2ZlI5Vk5zcGMzM2o3aXRxT29O?=
 =?utf-8?B?Yi9wSFdSQVBiY0pENHdCNG4zeGl0OFdOZXB5Z3hYS0IrUmF4RjVoQW10dlUw?=
 =?utf-8?B?QWQ0S1VUYmViTkNhSHpMbnFDMmE1YlJ4anc3ak0vS0prbFAvNjNKVGhqbFQ1?=
 =?utf-8?B?M05obzY4L2xMWkNxdVRCb2JsTTY0SjVqT1JzUzFOL1FaZmJucGdsVGRpZmU3?=
 =?utf-8?B?aWR0WU5QYWorOFdlekJjT1J0bUFWaEhMN004aFNKY2tTcWppbkl0V2FtK2FI?=
 =?utf-8?B?bUdNeklJU0d5Z25EeVFaMFl0RmJCMVBRTlVCbGhaRmxkMDNHbjVUODB6RWRv?=
 =?utf-8?B?aWZmY041cEZkTVVQS0dNMWZRajRMc2w0MHJPaE42bHlyTG1vV2gwNDY4eWFC?=
 =?utf-8?B?TmVxbDZZYU0wY2d6VTRNS3NWMzJ2SUlTbVJ0QkRHaTh5Qmd4VjBpZC9renFq?=
 =?utf-8?B?YlRwSStuc0I4SVRCam01Ym9pM2NJVUZFbmtzc0tYSXJmWEc0cXlZNzM4K1NI?=
 =?utf-8?B?ZEF0MElTdTZsd0hla1pmNmh1YlBMK0lSQ29vUDNIdVEzaCtxQTYwU1VxajND?=
 =?utf-8?B?ZzFnUnhYSmtNanR5RnJ2SnEza1hxakVyYVFBU29WN092MTZrNHg5VWZzb2dn?=
 =?utf-8?B?VzlVUTVINWNTM05DRCtYRHdhZDF3aUdBc29UVWttK0lTYUdBc2ZSODFCb2dD?=
 =?utf-8?B?WXVEd2FhNEY2cUlYekpaMnB4RUZYck9ldkZIeEltS1J5YzlkMnRPWEtUSEw3?=
 =?utf-8?B?WTAybmgxVjBzZE9UVnF5Ti8rTFVGUDgxVkdMaFRDYnlHcXVNVW9SbWdqRldr?=
 =?utf-8?B?cFI3dVE4NXgvcGQ4UDFjeVRVNlhqK2VzWDVYbHBsb2lVOVlUbWVMa0VmMGNi?=
 =?utf-8?B?MlA2Z0tTeUEzcHNoYXZVbno4SW00RHgzMHZZRGZjaUo1VG56VS9kaTYrNUQ1?=
 =?utf-8?B?MXYwNi9qU0RXZ1EyMVpwSGZPK2FnSHUvdDNxRnBBYTVRSUdmalNrbThSdWI5?=
 =?utf-8?B?ZkVEby9CaStnZjJSSzRxanloVWpyMFB5OXhSYzNERThSRVJLbmNGektEQzI0?=
 =?utf-8?B?UnJFZ21sZGtMWnZMV25LYmF1ZW1Jd21jdFRKY1cwQk5xVHd1QVBWTk9ZamZz?=
 =?utf-8?B?RGVRSnJnclhiMUMwb2pyeTRXTnc4VFpJTWpNVUtCV1RXMlJiVEJLbWMyUDlY?=
 =?utf-8?B?VlE9PQ==?=
Content-ID: <B25B8FBA2CCB04449DA8917572CF2E60@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BzZTlBT4qx0D+9NubJyNDV0BdD81ZNK7GK5LN930H7Tcjy0FKto390sIJFjA36Ze9pkZadTKoCPx+o+06KIJE+pyH/A0oxyNRxacr8JNzCMTF5ELa8vI5b6Wjm6Uv0ZhzT3apEwEOXWKNKIkzMSIGZpWzMAD6tbXKJkyNsmbZfdk90QPBhJEHQGxLcPUFqW6r10Ta8vWzB93SFkediQfqPgjuYGxaPc2WwXHkTXAvz9tVkzvUhkZKJOFY0IbhKY4qnozYarN4OVe0xib0ruLl7L845ZRUVkq/Z7JzZ9E1hMgAi0BxqoxY8PhOpHLaImYkslO06cHGZRfmYWiSG8LqlOiQMhxxRpU4I0OGJs07q8piIZ7F6ytHeldl0QMvPX0AcSe1ufav6MFOfwAaKG6G1SKB4f1K1aUe6JJIbQlwFGAHTBlMb7+Eqy54zhuTfNXV0hnKAxt0UxkL8dGermLV4kHI/5cUXOfxj5BflxqEZ+6jNpU6ZokzAPaxHrUMNZh4eGnIR/KEYSnnagSFdLvsHNm/baIkTLZ7xUYHfFbR7FMjJw7Yfa7cbZGmEdkWIxoQgPh5iR3eq/5W/AvZBWZZImUORkEGnVtuGGpC6nfRrftJdbluzC31Bjr/jUhTW8VgUhUtLVHEpJtOVj6ntz82eG6Wtj3lfMOMFvnDbAM6MxJx+iTydMgtDcJFxYXDHd7+Yh1HWvWBnWhFin2gY6jnNLRRb17GBmyj9VEr5v48C3OAFJ8EnojMoAdhHP2CNgXkmptKxFJX3anzY6641+yaA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB10723.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a5c1ef-2f2d-414a-fc15-08dba55e9f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 11:30:01.5724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsEszv0b6DLPs3WYvLF1CQXel2jgcJY+rpHy4jaJawi1tOCGbnX0ucSmYMwEFwz0zwj+hp4/yvCG3QvnbqdAuWqY8iBFAcn2EjIHaDLi2f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8324
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] hugeshmctl01: Mark struct tcase as static
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQpIaSwgWGlhbyBZYW5nDQo+IEhpIFh1LA0KPg0KPiBUaGUgU3ViamVjdCBzZWVtcyBub3QgZXhh
Y3QuIFlvdSBtYXJrZWQgc3RydWN0IHN0cnVjdCB0Y2FzZSBhbmQgDQo+IHNldmVyYWwgZnVuY3Rp
b25zIGFzIHN0YXRpYy4NCj4NCj4gT3RoZXIgdGhhbiB0aGF0LCBpdCBsb29rcyBnb29kIHRvIG1l
Lg0KPiBSZXZpZXdlZC1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1LmNvbT4NCj4NCj4g
QmVzdCBSZWdhcmRzLA0KPiBYaWFvIFlhbmcNCj4NCg0Kb2suSSdsbCBjb3JyZWN0IHRoZSBzdWJq
ZWN0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpZYW5nIFh1DQoNCj4gT24gMjAyMy84LzI0IDE5OjExLCBZ
YW5nIFh1IHdyb3RlOg0KPj4gVG8gZm9sbG93IExUUCBjb252ZW50aW9ucy4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+
PiDCoCB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1jdGwvaHVnZXNobWN0bDAx
LmMgfCA4ICsrKystLS0tDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9o
dWdldGxiL2h1Z2VzaG1jdGwvaHVnZXNobWN0bDAxLmMgDQo+PiBiL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL2h1Z2V0bGIvaHVnZXNobWN0bC9odWdlc2htY3RsMDEuYw0KPj4gaW5kZXggMTFjZDY5MDUw
Li44Y2FjZGU3Y2QgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxi
L2h1Z2VzaG1jdGwvaHVnZXNobWN0bDAxLmMNCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2h1Z2V0bGIvaHVnZXNobWN0bC9odWdlc2htY3RsMDEuYw0KPj4gQEAgLTUzLDcgKzUzLDcgQEAg
c3RhdGljIHZvaWQgZnVuY19zZXQodm9pZCk7DQo+PiDCoCBzdGF0aWMgdm9pZCBmdW5jX3JtaWQo
dm9pZCk7DQo+PiDCoCBzdGF0aWMgdm9pZCAqc2V0X3NobWF0KHZvaWQpOw0KPj4gwqAgLXN0cnVj
dCB0Y2FzZSB7DQo+PiArc3RhdGljIHN0cnVjdCB0Y2FzZSB7DQo+PiDCoMKgwqDCoMKgIGludCBj
bWQ7DQo+PiDCoMKgwqDCoMKgIHZvaWQgKCpmdW5jX3Rlc3QpICh2b2lkKTsNCj4+IMKgwqDCoMKg
wqAgdm9pZCAoKmZ1bmNfc2V0dXApICh2b2lkKTsNCj4+IEBAIC05MCw3ICs5MCw3IEBAIHN0YXRp
YyB2b2lkIHRlc3RfaHVnZXNobWN0bCh1bnNpZ25lZCBpbnQgaSkNCj4+IMKgIC8qDQo+PiDCoMKg
ICogc2V0X3NobWF0KCkgLSBBdHRhY2ggdGhlIHNoYXJlZCBtZW1vcnkgYW5kIHJldHVybiB0aGUg
cG9pbnRlci4NCj4+IMKgwqAgKi8NCj4+IC12b2lkICpzZXRfc2htYXQodm9pZCkNCj4+ICtzdGF0
aWMgdm9pZCAqc2V0X3NobWF0KHZvaWQpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHZvaWQgKnJ2
YWw7DQo+PiDCoCBAQCAtMjc5LDcgKzI3OSw3IEBAIHN0YXRpYyB2b2lkIGZ1bmNfcm1pZCh2b2lk
KQ0KPj4gwqDCoMKgwqDCoCBzaG1faWRfMSA9IC0xOw0KPj4gwqAgfQ0KPj4gwqAgLXZvaWQgc2V0
dXAodm9pZCkNCj4+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQ0KPj4gwqAgew0KPj4gwqDCoMKg
wqDCoCBsb25nIGhwYWdlX3NpemU7DQo+PiDCoCBAQCAtMjkzLDcgKzI5Myw3IEBAIHZvaWQgc2V0
dXAodm9pZCkNCj4+IMKgwqDCoMKgwqAgc2hta2V5ID0gZ2V0aXBja2V5KCk7DQo+PiDCoCB9DQo+
PiDCoCAtdm9pZCBjbGVhbnVwKHZvaWQpDQo+PiArc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQ0K
Pj4gwqAgew0KPj4gwqDCoMKgwqDCoCBybV9zaG0oc2htX2lkXzEpOw0KPj4gwqAgfQoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
