Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E890C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 03:56:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF7D13C9478
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 04:56:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DA463C6D9E
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 04:56:14 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DDAC60056A
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 04:56:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647575773; x=1679111773;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=USDAFeNoeIb3eCr2NsTXcjIMN67gzSo1DxhRy/cuvac=;
 b=y1wegwV9MWPqjqe7xx65eD52ddjonqXgp40U6bm4X7pmwkwYhRVtbjht
 325fvTfloSOS6IYjFQqy0aWEZkenV6xLStyqKTkehiFRYybcBnp7NL1to
 1qaL/lZ7YyIu2ZNUajlo8QQLT2TMqcNv0SP59Sz27Ae7vS3kZa6cXyMhH
 jiMe+++Ehp45YwVa8R2D4dtuw2L2lFqk4T8SrowbfESZSYdAik8k8MOKI
 wc6J8Tq7s8fKt1n0IEufb0ZuHVubR2Dg9jHzuEcyuK7gshs+gnH/1ne6v
 4EXCN2vGzEZitRZFNhCdnzZb1ossfdhVSC1zGLtST5OKkbZNsdh5kKLk6 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="51986224"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; d="scan'208";a="51986224"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 12:56:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJbGuwHS30OKH/e7+gGtA1Rh9QetfjFZta5OaOhKOJVTyhLBMkHsakrGT/83xdSNYF85Ftwch2BjGCILG8gGsfbBpTAfDDhsIaQBGKhRmEH0OjIqKgATuDFH9TJssWNcJIxfmaoT4F8WWgXtEgL6L9al+xCjnGbGVR8C9Y5hbK3X/m2l0WdFzaR5oTlfBnUvacDxoIXoEsbKK87GgDWUL+1iM3ESf6qpGexU27mQwoU5BT4e7JJgfKAt2SeQphemSr2Zxjy4tcn2DcCO3pFiCVK3EBkRCVf9HOdowOkzmzXICYNX3PkWK9JG0eH6FSUxivXi6PUXrbZEDHMiK2GzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USDAFeNoeIb3eCr2NsTXcjIMN67gzSo1DxhRy/cuvac=;
 b=fmVm/NAzuWtu3R/H+SiE7p3d1dJbOOyzxnR2qxOZfB7fju8+YiEAhXOW6B30oYAdwb7VhgT9mOskswEsuqITxbZjWm24DvfjA+MOd6dMW4XAvU/O7+biQWx1sMRmB7qP3Mxqj3LzB22YBDjdhEsYlHrb8grHIG80h4F9+ac+/o9x6DXM14MemjBCrdvqyjDDvcFwgn0GkGtm+ijiVcPsIyOqmSwvNyAXHSc0fYjI0SYgoXXSYbw8QWDz7Tc7FYdX5PJk0bAtxOKOhl3zhkA+Tr5k2sHkDnMZ0VHTsmDG9j4ZbIlk2/GNL/5yGmUMnak+ZFtgaRgHcIL6sIkltAId0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USDAFeNoeIb3eCr2NsTXcjIMN67gzSo1DxhRy/cuvac=;
 b=HEtKUdW/UeRGnuiT/70fhUVqAxj9V/+ixu5d6FTHVwzEsjo6g2nsR4ZF0/jmJOB1I5tRsEkl73/5ALtaShFNZko6vBidjiBZDD3QYL8txzkyV0aXhtsrsHhIAErgZQ+WhCZMQfT8vdk7bZVQ7/PzwcHWqUPLZblGDhg2ZlaRd3g=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB3236.jpnprd01.prod.outlook.com (2603:1096:603:38::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 03:56:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 03:56:08 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [PATCH v2 1/3] Add SAFE_ACCESS macro
Thread-Index: AQHYOd2KAaLMrKbCZ0mQpH0QHdb7GqzEhKsA
Date: Fri, 18 Mar 2022 03:56:08 +0000
Message-ID: <62340304.1000500@fujitsu.com>
References: <622EE434.4000400@fujitsu.com>
 <1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcd9428b-934c-4344-928d-08da08933c04
x-ms-traffictypediagnostic: OSAPR01MB3236:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3236CEB78822043F93A8B9ABFD139@OSAPR01MB3236.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhKcj2vlgujzOLIq0E30zzLxNYam+0IUIcoi+tXRO9DVTQkhdvXeZE9pGuK1QG+pYVS2FVe2JvpE55wA8VUSQ3tNsWiWGNfUUBscM+wgBzWAafbcq/scnDqWkbayxDikwExb2GsRZQw69pC5z2ALd9NnGVJDONKCDUdzBC95NR8t/96rlT0rCnLbKVlskhiyp5Gk3kpvC2xN3S9g005EGXecvm0Y7PjFbheAATlJQHaZVvhonyijIgIxr7cgOedIj38T0mIXt6UpwKUYiNZq0uyDsHggcl89+qdf34BKq7ke+jfjF3i3kOp73isH02rkHl+ApW7ZgBSMgeY8jLXCDvysYaZBYdmuXVkzX5W4bd4fIBATx21GOBEU/oL/U30XfLJ2tqsW8iag6aAm66tqM8rVKdy9dLoGe+ihqzCWESTMHnQAFnsFt+qhM7OP67EEb/uXsPgSYBk2J7aTlKK5e+iP7T3DCWyW9pHQg3r9ZxsRwIynbigl2ZJBfO4rOuXqTzYszGESvMlJ0YTNKOwMmtqQ7p7RQ3RLJMwVJpAs+9nTcevQgp7DyIBH9CfsIlYSAEFk9blIW54TIGoQvX2566wl2AL29OQQMLEcOLpwZjnKEWYpUUXqbAa86DNxMb6Y7wlqBriZib0TuFCOE5MD1oEdgYG1W/QDRHSxtMoK32PYJTwfy8yVk4OrCBPHsdr+Zlm3TyuEBIAGS0vdImFJhfa0y5m56obiqf/PYn+zbHY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(91956017)(26005)(2616005)(186003)(66476007)(64756008)(36756003)(558084003)(85182001)(6636002)(37006003)(316002)(66556008)(6486002)(86362001)(122000001)(38100700002)(82960400001)(8936002)(66446008)(87266011)(8676002)(6862004)(76116006)(508600001)(4326008)(66946007)(2906002)(6512007)(71200400001)(6506007)(38070700005)(5660300002)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N21XU1VWdnRjZmJUejMvWDBYU2xDdi9BRW84SkZVZXNtZFBKemVHZzJIdUdh?=
 =?gb2312?B?N3NPRWlNSDQwb0dnNkMyRlNFTHdqT1JWVUNRV01PSkFlamlJcEZQZXF2bGw4?=
 =?gb2312?B?bEJOai9mMWxDM2ptZi9KTXVCSWZHd0djMXBUaDVKMHYwUWVqOE81aTZZcm1K?=
 =?gb2312?B?SGRxZFpHUjhTZklZL1F1cDdlYTNnT3RDb0FncWtxM29mNCt2by9zZmFkQ2RK?=
 =?gb2312?B?VUttNmlOZlFMUWRBbnZ5N013UlVyM1VEMWF1Vk5uUS8xcFN0TzJTbEs2RW43?=
 =?gb2312?B?SjVoTDcrdEF2T3Q4RElFN1drME1FWGRKc21lM1hQeVdnNEk4Q2hCaXNLOUU0?=
 =?gb2312?B?VHBKMTlmblVwL01ockZ4Z0pkdnpWM3JvckdvU212T0c3TkZzQ0t5L2I0QnhG?=
 =?gb2312?B?RXFHcHNSRW5MRU9Ec1puTGh6RG5kZVlSdE9TN1hjRjdyMTViV05RekxLcTBw?=
 =?gb2312?B?MDFCQWYxakZCTlZUY0Fsc1Z3bjRGUVg1emFvZExycXJyUkovaE5LbG92SWJV?=
 =?gb2312?B?cGpyK1Yxd2txNGhFWDJBaTBJaFNnWjZ4dk5ITlJaTzZVb1p5aCtZV1VaU0VE?=
 =?gb2312?B?SnV6alg0QytWVTJhdHI2YUg0WFNlZlRUdGl2SHR5a296b2syOGtmT0R3YjlT?=
 =?gb2312?B?d1c2NWlWRWtvK3hjbXZ0dGtRR3Z1N0doV3ZVVEVUOVoxVUpRMVZuNzVkZmg5?=
 =?gb2312?B?bXdsNEJNeldpZ2ltTUlKL3lWL1VxbFRpUUxOYjZtUVlEMDFxUUk5SExrbU9I?=
 =?gb2312?B?blhXNDc4V3lTN1pLdUVtVjJhWE5KcFVuMjA4ZGJWTU4xL0dKVzJwdCtBK0h1?=
 =?gb2312?B?c1dTN2VjeUlTd2JaeENJdjZmYmw5OVQvQ3VCQ0htZDh1Q0I4ZXFZM0dnRnpP?=
 =?gb2312?B?ZG9NYVhLZVp4SzMwbWRhSW5WbDlwcVpmbWJFcXBUYTl4eGJDTFIyQmpaVDVq?=
 =?gb2312?B?c25WR3hkaEowclBFR3ZSbVVuMHMvaFVOdk9GenMyRWRoeG5qRTZGNFZURWhX?=
 =?gb2312?B?Sm9NdEF5NnFmQUh1eGpNenZPZmNEOGxrcUYzYzRrV0JuTmJSS0dCdDNhTExG?=
 =?gb2312?B?cnV6ZjAvSFJGcHNwU2Y5aUREUU1Dc3doanpPeTVEWGJxMytXcDAxNC96b0Rs?=
 =?gb2312?B?SUh1eU9WU3Y1eHRwb0xEVkV2RFNjcWVuR2l4WHFIWXFoaVdZNzh1ZWVtNkZR?=
 =?gb2312?B?cnY1cXI0bm56U216YWZFVmhjaDMzS1pxOUllamJLTVZnRU15ZU1SbTNmOVFs?=
 =?gb2312?B?cHhJVHg4WUdWaTg0YmNZSTE2d1lwNTlVaWdRK3gxcno3RGhoSUhPR2hPcndG?=
 =?gb2312?B?VjNvbEpKOWs3SnUyYUtTTFArRVJ2SzJIUTdVMDdzVWtRMUpxWENaaWVOK0xr?=
 =?gb2312?B?aDMyRmRTT08zUk1YdUlhS1VYWnk4VTE5VllWQlFiNU9mdGVhMzVlYnJyM0xB?=
 =?gb2312?B?RzJrOGttU2ttb3ZkYUE4dk03YWwzRS9uYllMd1VYUWp4VnRkbFcvc3FSMVl3?=
 =?gb2312?B?UVNjR0xJRGlzR0xJN1ZCZlRhbDVNUDcrdzBySXp0RGNjeU43REVSdW52ekt0?=
 =?gb2312?B?eGZyRXdrL29ITjJJQnNSTHdFL3l4MTFJVU9uWlJud29NQXEvTUY3Sk9Nem50?=
 =?gb2312?B?UE5OYWJNSEZmS3I3Njd4NldjSTVuOVIrSFF4U2gzSGxFQ0VXbkRTT24yYVV1?=
 =?gb2312?B?eXdZR0x6OE1iZzVlSWlubmppL1BTU240TkNBVXgzK1ZSYlFCNDBKNzFaL2FU?=
 =?gb2312?B?MUIrTmxBeTNMdDM1UU9FcklRa1hwRk1XSTZLcW9YeHNKQTlGdnZoVG93MmpP?=
 =?gb2312?B?VkVqaXJ6UjlocW43dlFhM0dVbmRLVUxHU2VJYUFyaGFvTjJqdlM1eGg2c3VQ?=
 =?gb2312?B?cmJrbHhOaHkxYWZRVDBKN0pNNEZNcExGN3NSUmxoejJiZXd1YzRVb1BaZ2Rq?=
 =?gb2312?B?aTU2d2g4LytuNzBSQ3Vld0tHb0lsd210bDc1czIyUWtDZmtuai9hU014NUFT?=
 =?gb2312?Q?elD/gY4JEpHMPY02STwzAr6Y8SPq5A=3D?=
Content-ID: <ECCAE9F6829BEA4AA9457333CD58AACB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd9428b-934c-4344-928d-08da08933c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 03:56:08.6181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQcOWIO20G3XcBB5tw7J+2hk4kQKVRl11zZOQmQRDhPzDmqUW/2RXFXmRWS3HqBt//RILvXp1WNzWb4e0b+oGEf6ZsedwHs1Y6wtV0l29l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3236
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] Add SAFE_ACCESS macro
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

SGkgRGFpDQoNClRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5o7pZYW5n
IFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
