Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108CECD11C2
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712739831; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=c9vtdgBihLcnBNA09tg2+DCTcEzVLz3OLKBrKmAvu7w=;
 b=PObZxI0tf36uU/t+OWtKdEvfhds2hN3vkF1wIMAOwsxLIBI5BHYYCTy6+PNmmAauRTZqe
 lBkj2GwNl6US4fPO/REgepKZO6JugqWlkOfcB1C/M+kJHiHOjCyNF5f1I2aEeGgXWrmWc5f
 ZOjGNsVoFkBZWDrsBHV6uAtdbbOJkc4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39C853CF749
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 11:03:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72F23CB461
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 11:03:28 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.156.96;
 helo=esa13.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 30CC414011A8
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 11:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1712739808; x=1744275808;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iJ/ZWzbHVwvooKzNyLG1dtLcqFPO8473GvThUGFhFRY=;
 b=tgF2KXY3a8rzobJnOCi/JhBZSdQCn8CwsfbiYshwKg8/mp29LFLw8y4B
 lrmjNmS8lDyWsspWwRtjrt2fMZ63SME9bueSLgFk6pXE4RqexIKqq4Ko+
 kRsk0K7EgmlzBsjR5ctj2PlJc8KtAMKnrVkrDHkDfLdA5cU+Hy6bixg0/
 B6CSGyr+mMcAPyadrdRCzotnG36uEfAiHr2j3hKq+1ylU6VxdaZ7mhuqG
 rQT7pAh7teM5Z2GjKjOEpdypHBLBlcP0YaWV+fMEeobugz6D/dCE6UzXM
 VktemlLNIUqKYdYS19nd12TJfRp6OyJYLBvDeWbq5zEssM/CiSGye+OdL g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="116029741"
X-IronPort-AV: E=Sophos;i="6.07,190,1708354800"; d="scan'208";a="116029741"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2024 18:03:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS6qJnalFks02rsvS+o5M9Sj3FX0mtq775kWrPI8dp5bZlofZb7Vb8cs+t9shpK88+KwSr0jNoDCYCpXLVsv5lgnTcWVVwBrbNIKNsWq0/E2T2pMTnrqzqdXyYxSweiyOC0ZF3FK4FI0++2xygvU6Et9ay9p4ANLmcH469rswwTrFmf4ExxHzXT8FEvO+uWkjZKtPPyDAH7YjexfUYdlINsmMTihJLMg2aQP2UzhxiQhQYdr3UO0WYy9xDHp2ol9sWuvjJ9Etu2nUvf1eveMWreZncwLgBEfBDYNP7NjuHf5QvmPUCb4YXe3pA5o0HFU2OpnDCz5+eAXLDE4Sc3wmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ/ZWzbHVwvooKzNyLG1dtLcqFPO8473GvThUGFhFRY=;
 b=CwhO1A7ZQto2DUnSmTstZYQ8rxfvZrkAH3X/E3xG2QMzdV+5IbB5vefofQPG0dbMqWl5eZidmGHqV/CqqlJMp2UmdXgWljZ/WzTfhrqJvwQZS/RwE9SKbn8v5Rtga5N7Joy1mMIISdFjEczdE2NUz0Dj+BFwDFRcpblj/Q9MZDx7fPM3xmEs8lU4y7QtfjbXT8Gwpk8jc2tfD1A7qlErpV0fZiOH8hRbydtKPW/LBu08DJUyhitTTtP7kpcdYyyfnZC0q3mj6RjFYscDOJa/pyPKzp8VScQ95OiLQq5b13k80J5vxxf0blfyduvnMzV3Re1NZrWv6DBly4k1747EfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6504.jpnprd01.prod.outlook.com (2603:1096:604:e6::10)
 by TYWPR01MB11935.jpnprd01.prod.outlook.com (2603:1096:400:403::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:03:20 +0000
Received: from OS3PR01MB6504.jpnprd01.prod.outlook.com
 ([fe80::73c:43d2:e9ea:dbd3]) by OS3PR01MB6504.jpnprd01.prod.outlook.com
 ([fe80::73c:43d2:e9ea:dbd3%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 09:03:20 +0000
To: Avinesh Kumar <akumar@suse.de>
Thread-Topic: [LTP] [PATCH] unlink: Add error tests for EPERM and EROFS
Thread-Index: AQHag+QK3SHcbptqfkKP2Q/edyZlzLFehv+AgAK9E4A=
Date: Wed, 10 Apr 2024 09:03:19 +0000
Message-ID: <cf27795a-9656-4bf6-8bd0-a2322fcfc953@fujitsu.com>
References: <20240401024948.8703-1-xuyang2018.jy@fujitsu.com>
 <2511807.XAFRqVoOGU@localhost>
In-Reply-To: <2511807.XAFRqVoOGU@localhost>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6504:EE_|TYWPR01MB11935:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQWweNKNF2TOaTz/uO7ypbvOewgtw1JvcdSeV9Z3s0+6SMng9JEueOG0dBH9ilC/Jm3GadJFZlsPuTidfCOKLr7+KuX5q8m0rkPhZp91KqOXZrO0+V4ILmgGwmozZJDmYtbJS90nqGAu2DBW/06ehKnnSzg354IZeueSnuUC63yl2CHb+ZjqsSz/Fa7UM7UuSTktpFuMrvmY+CNC2WyiQT8aIRm0uany4YwEr2otL69/KZqo6xEwllti9KAWzUlLGlK0PMt2JJeg/K+n5bQmCxeQz4+NFi2NZQOkYBrUwNTLWlPCqfRaZ1Upzjff0gimge+7qZxKH1JNMl50UMLShObtbaTUqPbhpBROVAyyrNe5X9eSxf3MXwoSqgx2HGJ7MoqxhwW2+jdPllFuKrerI6x5iCt/ghiFIzBS0qdQzFEcp1l4z2kV7VNHaxDvI49CXWVZts6hqKHq+oUquLxYxZx7H8QB8g7ZZ3lxLHRKozuOq6nmN5m44tDV0dlSfSPGC7QtwWtO9hQ5NAkWdT7djEDkMoW1i/p8LfOm/LLO9lsfLbxAyMilrCkC8QvHlsqtXoyWpxBo7XXeWash46tTSEknXq5AU3Abbx7C9J48i/mYDuef2DoYRvUJR1gsrBNGXlNHt+FT0uIkM2Ugz2+AWJmQ5l+hviCpCJEUBH5QiEoPjAcjuv/o7xyP4zlUSQfZUl4zc8FIaUngx49oAtEOqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6504.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(1580799018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V01VaG0zUXVPTUpYK0YwZTNlaHp2YzBlM3pDZG0zb0dkVEJ6LzJQVVJSblVW?=
 =?utf-8?B?eW10WXhuR2pzWk9pK3ZFNDdXZitHSVozU05rOXlWSTBMc29NV0N4bXp2cW5t?=
 =?utf-8?B?MVJYSVM1Q2R6cm5uZXArTnRlMXd4VHQ4cE81dHhnK0V0a1RzVlIyRDRiRWFq?=
 =?utf-8?B?OSs1czJCQjNvTks0dU4ybUZjc2ozcWlxT3J3UFB5cDdMNWNRdFJlajFwM0JF?=
 =?utf-8?B?dlN0dmlwSTZCQ1loSzFoSDUzUXdXaElYdzlGK1FLVXVUT1ZrUlV0V21aajFa?=
 =?utf-8?B?YUF0MmJzWnF6TE1wQ2RJaXZYalBTYm1NMzc5Slc1YWo1cDVqWnY4Zk9JaHhE?=
 =?utf-8?B?eUlBYlhpU0RndFIxeEpvbHZwZDNiM0k0N3ZvSzN5RFZXemR4dXNZVHc1Uzdv?=
 =?utf-8?B?WEdIUS8rQ2o4YXVTVW51V2lsanUrak5rQ1NjRUw5ZXNoK1F3U1JqaThMNjgv?=
 =?utf-8?B?TVVlTHRVZFZpSm50K3dwVmg0ZGV4eEpCYjBqeTBTRk43YlgzS1k5a2pZUE5n?=
 =?utf-8?B?SDhnOXY2KzllNXhzN0d2NHFJdFFLek4vb3NhV3NEVDRuKy9HM3NNM0pKTks1?=
 =?utf-8?B?b0IweTF2TDdyOEdISTZSNS9peEZjRThzUUpJdFBQS2FHN3JIbStuV2VnTXls?=
 =?utf-8?B?TldXR21scnJ6alZYRnJHQWdDVWc3cXVKbWRtN1h2dXV1Q2ovUTZjd2JPZmlB?=
 =?utf-8?B?ci9PVWpxbDRqNlg5dzdnMWM2Um9aVDU5WlNyUUd3YjNRZFZEaHZxdHN2ZSsx?=
 =?utf-8?B?SU41T1JmaW1xQ0RXV2piK25SNzk5OXh0MU9XeGprQ1Q0Z244Y3BQY2ptakkr?=
 =?utf-8?B?aDB2cm9Tam1JZ0JyMk1jS09CMTRoa0VVOGQyc0ZPTTQwa2RKamFIeWZkb2JH?=
 =?utf-8?B?N1NodU1FemFaeklSV09FclpNTENRVHc0WlBUSHBSK1RySXFaOUNJalZtdFdO?=
 =?utf-8?B?VkJ5dkVhYkNoeE53RjN3cWpoaEZZRGozUDlYMUdNQzl0bGdhNWxGSGVaeVlY?=
 =?utf-8?B?d2VUcmhyVXJiMHVtd1ZMTFUrcHhobUlMQmNtNzBHakhwVWtvMFB5R2hvQUdG?=
 =?utf-8?B?WG5HWkNDTlZCRVV0SzN0Zzc2N2VUY21GeHFvR1dhMmJXVm45MWhPVDRzdTBv?=
 =?utf-8?B?ODUzbkZGZDg0UThUUHlDOGlGM0pVaHlROVE3NWRtRnowVnl3aWIyT2tBWHN0?=
 =?utf-8?B?TlFRanMvRXA3K3N2eEFTQmE4d3BuZnJEcXlLbUFJWlhlNHZmNnp0cyttbkhY?=
 =?utf-8?B?RFJzdnVqUktRVTFMR29jOEI2SVJsaGtOV1hpUXZHdm9QVkNGL28ySWRZQ1VU?=
 =?utf-8?B?eXZKbnc0U0hITG1LK05aOEtTL1llRzhhendUWlNkbmRscXo2U3ZDYUlZQVNK?=
 =?utf-8?B?K2drYlNhUTUzSlRJUExBUGpmdHZYZ0RxamErZUg1bjhmT2tqaDM2Sklkb3Z3?=
 =?utf-8?B?UStzbE1yQlRYMXpSZzhYSld4NEl6cnJNaEk0RDZudThQWldTWEpxS3k0Z2VB?=
 =?utf-8?B?S2JYeGpCQzBOMDVwUERXRTlObzUzdTc4TTBNM0J4RWwxZE9nRVNiS2U2TGdp?=
 =?utf-8?B?Y09wSmVaRldIZXpvZjZSV2s4SVAzV3hoajJtSmZzemFyeXdUV3RsVnpJSC93?=
 =?utf-8?B?UVQybUF4dEIrUE1KbVg4RWRacFBxMnFzR2dXNUJLMW01eG5naXdhbjl1SGpl?=
 =?utf-8?B?TGRtK3Fya3hqaUJDcmtJVW9nZ2VCYmNySVVld3dObVdMeTdzeE5GZTFSaW0x?=
 =?utf-8?B?cm1SeW9FdUQ5eHRhMUFEbWV4cGJXUnZDRHZuZHdMOUZUdXF5MEdUZ1lFMjBq?=
 =?utf-8?B?K1R5YVpCVVdNNXN0aHowUkhyMXVmOE5jeUdXMFZYQlFqY05aa09hRGUwU3Rn?=
 =?utf-8?B?MWROSXV4aTZGWkJXVkp0Rm9kMGg3M0x1UmFYcVVrR0NabnRNd3N3UzdJclFE?=
 =?utf-8?B?NlRsQmtJOVRwV0lYNC9BNzBuYmJ4RlJsOHFuSHUzclN6SG5Lc2FTUm1hZEVz?=
 =?utf-8?B?U0FaREtzY0ZvN3llSGNsYmdncmlER2NyZ21iL2lYMmRVVkFJVzNkK0xnSWJD?=
 =?utf-8?B?dWxObEZYYzhrZ3JxVWgzRm0rck05YnA5ZElkRWpRTlBlQlYxUTl0eFFodEpr?=
 =?utf-8?B?bVlqZ3VkQjJPYTkyRnZPN29IRlMyWlVMN3hXYThvdEhzYVVrbk41ZkMxckJ5?=
 =?utf-8?B?aEE9PQ==?=
Content-ID: <C0C0363B0A247644A65099FBF8D18AE3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FwHRR3mdYlz2kKwH+rqJoXz/k38Y9nELrd067nL4rXXkX9uwL8Lx5jEL/qa4qoZcZgriqbA3lbSM+dVYeqy2mZjue21laB89t1MsKQb9IpTc1Uu9gsIRXyGfO0MlI9rcLcXqUVUdGQuYOuc2ch3icHX19lPriHyQgr0Aa4WzgjrQoKAZPgGBQJ4si79RJLGYb0MHsw3P2SrTT1DCoHgFXe6hoE1yqb38pi6xFrap7I0BG//2KZLspxF8NIEqjl31kY5aPfxsHqpwQsLYQYDAsn6DmkokzAiu5V8Xp/aCrZoLUyh0EUiuLkWCjKF8c1r/mAANoUqZfkqAt/o+t6S762R+iUfADl+dWPJ3SOw0G2KovIUWpzpgUGXz/A3T4TaY0e2VCyLr1jLCmZ7HQApiNtQQMGYMPy6kI2Pq1dkoic7u6Nqvl+IKBtOefAc27YYhHto8ST89XCQGshnmDa4UOyTn+cp4sXXTsHOP/fJyc25YH60scZi+vE8mMvS0KCfGgxbyCAI9CBTmO0uu+6BmamOJo6H4bAhvmiiBX0QS5bleD12mH1WZRtZOGOXUvMPx1RKEE5EvtERXL4Ap1FyVG5rAqyCeAU8y5tAaz9IEdXiNEuVQG7zcwNCIrNQBCS2O
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6504.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff956a2-2cf8-41da-8938-08dc593d1161
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 09:03:19.8739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMQCShL4/RfVX/hEV2e/4udw4nIh3V8MIQm/3qs9B/3id4bjtLZ0McYuZ5cwSqKinsy32RUbXVuiTVkm/f0EIKcCElgdb+2CyoD8xkw4HcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11935
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unlink: Add error tests for EPERM and EROFS
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQXZpbmVzaC4NCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IEhpIFlhbmcgWHUs
DQo+IHNvbWUgY29tbWVudHMgYmVsb3cNCj4gDQo+IE9uIE1vbmRheSwgQXByaWwgMSwgMjAyNCA0
OjQ5OjQ44oCvQU0gQ0VTVCBZYW5nIFh1IHZpYSBsdHAgd3JvdGU6DQo+PiBBZGQgbmVnYXRpdmUg
Y2FzZXMgZm9yIHVubGluaygpLCB3aGVuIGVycm5vIGlzIEVQRVJNIG9yIEVST0ZTLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAt
LS0NCj4+ICAgcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
ICsNCj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsvLmdpdGlnbm9yZSB8ICAx
ICsNCj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsvdW5saW5rMDkuYyB8IDg2
ICsrKysrKysrKysrKysrKysrKysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlv
bnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
dW5saW5rL3VubGluazA5LmMNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBi
L3J1bnRlc3Qvc3lzY2FsbHMNCj4+IGluZGV4IDRlZDJiNTYwMi4uYjk5Y2U3MTcwIDEwMDY0NA0K
Pj4gLS0tIGEvcnVudGVzdC9zeXNjYWxscw0KPj4gKysrIGIvcnVudGVzdC9zeXNjYWxscw0KPj4g
QEAgLTE2NTEsNiArMTY1MSw3IEBAIHVubGluazAxIHN5bWxpbmswMSAtVCB1bmxpbmswMQ0KPj4g
ICB1bmxpbmswNSB1bmxpbmswNQ0KPj4gICB1bmxpbmswNyB1bmxpbmswNw0KPj4gICB1bmxpbmsw
OCB1bmxpbmswOA0KPj4gK3VubGluazA5IHVubGluazA5DQo+Pg0KPj4gICAjdW5saW5rYXQgdGVz
dCBjYXNlcw0KPj4gICB1bmxpbmthdDAxIHVubGlua2F0MDENCj4+IGRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VubGluay8uZ2l0aWdub3JlDQo+PiBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvdW5saW5rLy5naXRpZ25vcmUgaW5kZXggMmU3ODM1ODBkLi42MDM4Y2My
OWQNCj4+IDEwMDY0NA0KPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsv
LmdpdGlnbm9yZQ0KPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsvLmdp
dGlnbm9yZQ0KPj4gQEAgLTEsMyArMSw0IEBADQo+PiAgIC91bmxpbmswNQ0KPj4gICAvdW5saW5r
MDcNCj4+ICAgL3VubGluazA4DQo+PiArL3VubGluazA5DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsvdW5saW5rMDkuYw0KPj4gYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3VubGluay91bmxpbmswOS5jIG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBp
bmRleCAwMDAwMDAwMDAuLmI3ZmY5NGVlNg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsvdW5saW5rMDkuYw0KPj4gQEAgLTAsMCArMSw4
NiBAQA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+
PiArLyoNCj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQgRlVKSVRTVSBMSU1JVEVELiBBbGwgUmln
aHRzIFJlc2VydmVkLg0KPj4gKyAqIEF1dGhvcjogWWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWpp
dHN1LmNvbT4NCj4+ICsgKi8NCj4+ICsNCj4+ICsvKlwNCj4+ICsgKiBbRGVzY3JpcHRpb25dDQo+
PiArICoNCj4+ICsgKiBWZXJpZnkgdGhhdCB1bmxpbmsoMikgZmFpbHMgd2l0aA0KPj4gKyAqDQo+
PiArICogLSBFUEVSTSB3aGVuIHRhcmdldCBmaWxlIGlzIG1hcmtlZCBhcyBpbW11dGFibGUgb3Ig
YXBwZW5kLW9ubHkNCj4+ICsgKiAtIEVST0ZTIHdoZW4gdGFyZ2V0IGZpbGUgaXMgb24gYSByZWFk
LW9ubHkgZmlsZXN5c3RlbS4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSA8ZXJybm8uaD4N
Cj4+ICsjaW5jbHVkZSA8dW5pc3RkLmg+DQo+PiArI2luY2x1ZGUgPHN5cy9pb2N0bC5oPg0KPj4g
KyNpbmNsdWRlICJ0c3RfdGVzdC5oIg0KPj4gKyNpbmNsdWRlICJ0c3Rfc2FmZV9tYWNyb3MuaCIN
Cj4+ICsjaW5jbHVkZSAibGFwaS9mcy5oIg0KPiBlcnJuby5oLCB1bmlzdGQuaCwgaW9jdGwuaCBh
bmQgdHN0X3NhZmVfbWFjcm9zLmggaGVhZGVycyBhcmUgYWxyZWFkeSBpbmNsdWRlZA0KPiB2aWEg
dHN0X3Rlc3QuaA0KPiAgIA0KPj4gKw0KPj4gKyNkZWZpbmUgVEVTVF9FUEVSTV9JTU1VVEFCTEUg
InRlc3RfZXBlcm1faW1tdXRhYmxlIg0KPj4gKyNkZWZpbmUgVEVTVF9FUEVSTV9BUFBFTkRfT05M
WSAidGVzdF9lcGVybV9hcHBlbmRfb25seSINCj4+ICsjZGVmaW5lIERJUl9FUk9GUyAiZXJvZnMi
DQo+PiArI2RlZmluZSBURVNUX0VST0ZTICJlcm9mcy90ZXN0X2Vyb2ZzIg0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgZmRfaW1tdXRhYmxlOw0KPj4gK3N0YXRpYyBpbnQgZmRfYXBwZW5kX29ubHk7DQo+
PiArDQo+PiArc3RhdGljIHN0cnVjdCB0ZXN0X2Nhc2VfdCB7DQo+PiArCWNoYXIgKmZpbGVuYW1l
Ow0KPj4gKwlpbnQgZXhwZWN0ZWRfZXJybm87DQo+PiArCWNoYXIgKmRlc2M7DQo+PiArfSB0Y2Fz
ZXNbXSA9IHsNCj4+ICsJe1RFU1RfRVBFUk1fSU1NVVRBQkxFLCBFUEVSTSwgInRhcmdldCBmaWxl
IGlzIGltbXV0YWJsZSJ9LA0KPj4gKwl7VEVTVF9FUEVSTV9BUFBFTkRfT05MWSwgRVBFUk0sICJ0
YXJnZXQgZmlsZSBpcyBhcHBlbmQtb25seSJ9LA0KPj4gKwl7VEVTVF9FUk9GUywgRVJPRlMsICJ0
YXJnZXQgZmlsZSBpbiByZWFkLW9ubHkgZmlsZXN5c3RlbSJ9LA0KPj4gK307DQo+PiArDQo+PiAr
c3RhdGljIHZvaWQgc2V0dXAodm9pZCkNCj4+ICt7DQo+PiArCWludCBhdHRyOw0KPj4gKw0KPj4g
KwlmZF9pbW11dGFibGUgPSBTQUZFX09QRU4oVEVTVF9FUEVSTV9JTU1VVEFCTEUsIE9fQ1JFQVQs
IDA2MDApOw0KPj4gKwlpb2N0bChmZF9pbW11dGFibGUsIEZTX0lPQ19HRVRGTEFHUywgJmF0dHIp
Ow0KPj4gKwlhdHRyIHw9IEZTX0lNTVVUQUJMRV9GTDsNCj4+ICsJaW9jdGwoZmRfaW1tdXRhYmxl
LCBGU19JT0NfU0VURkxBR1MsICZhdHRyKTsNCj4+ICsNCj4+ICsJZmRfYXBwZW5kX29ubHkgPSBT
QUZFX09QRU4oVEVTVF9FUEVSTV9BUFBFTkRfT05MWSwgT19DUkVBVCwgMDYwMCk7DQo+PiArCWlv
Y3RsKGZkX2FwcGVuZF9vbmx5LCBGU19JT0NfR0VURkxBR1MsICZhdHRyKTsNCj4+ICsJYXR0ciB8
PSBGU19BUFBFTkRfRkw7DQo+PiArCWlvY3RsKGZkX2FwcGVuZF9vbmx5LCBGU19JT0NfU0VURkxB
R1MsICZhdHRyKTsNCj4gV2UgY2FuIHVzZSBTQUZFX0lPQ1RMKCkgaW4gYWxsIHBsYWNlcy4NCj4+
ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQ0KPj4gK3sNCj4+ICsJaW50
IGF0dHI7DQo+PiArDQo+PiArCWlvY3RsKGZkX2ltbXV0YWJsZSwgRlNfSU9DX0dFVEZMQUdTLCAm
YXR0cik7DQo+PiArCWF0dHIgJj0gfkZTX0lNTVVUQUJMRV9GTDsNCj4+ICsJaW9jdGwoZmRfaW1t
dXRhYmxlLCBGU19JT0NfU0VURkxBR1MsICZhdHRyKTsNCj4+ICsJU0FGRV9DTE9TRShmZF9pbW11
dGFibGUpOw0KPj4gKw0KPj4gKwlpb2N0bChmZF9hcHBlbmRfb25seSwgRlNfSU9DX0dFVEZMQUdT
LCAmYXR0cik7DQo+PiArCWF0dHIgJj0gfkZTX0FQUEVORF9GTDsNCj4+ICsJaW9jdGwoZmRfYXBw
ZW5kX29ubHksIEZTX0lPQ19TRVRGTEFHUywgJmF0dHIpOw0KPj4gKwlTQUZFX0NMT1NFKGZkX2Fw
cGVuZF9vbmx5KTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgdmVyaWZ5X3VubGluayh1
bnNpZ25lZCBpbnQgaSkNCj4+ICt7DQo+PiArCXN0cnVjdCB0ZXN0X2Nhc2VfdCAqdGMgPSAmdGNh
c2VzW2ldOw0KPj4gKw0KPj4gKwlUU1RfRVhQX0ZBSUwodW5saW5rKHRjLT5maWxlbmFtZSksIHRj
LT5leHBlY3RlZF9lcnJubywgIiVzIiwgdGMtPmRlc2MpOw0KPiBJZiBmb3Igd2hhdGV2ZXIgcmVh
c29uLCB1bmxpbmsoKSBjYWxsIHBhc3NlcyBoZXJlLCBmdXJ0aGVyIHRlc3QgaXRlcmF0aW9ucw0K
PiB3aWxsIG5vdCB3b3JrIGNvcnJlY3RseSBhcyB0ZXN0IGZpbGUgbm8gbG9uZ2VyIGV4aXN0LiBJ
IGd1ZXNzIHdlIG5lZWQgdG8gaGFuZGxlDQo+IHRoZSByZXN0b3JpbmcgaW4gdGhpcyBtYWluIHRl
c3QgZnVuY3Rpb24uIEFuZCBjbGVhbnVwKCkgZG9lcyBub3QgbmVlZCB0byByZXNldA0KPiBhbnkg
ZmxhZ3MgYXMgaXQgaXMgY2FsbGVkIG9ubHkgb25jZSBhZnRlciBhbGwgdGhlIGl0ZXJhdGlvbnMu
DQo+IA0KSW4gdGhpcyBjYXNlLCBldmVyeSBpdGVyYXRpb24gdXNlcyBhIHNlcGFyYXRlIGZpbGUu
IEV2ZW4gaWYgdW5saW5rKCkgDQpwYXNzZXMgdW5leHBlY3RlZGx5LCBvdGhlciBpdGVyYXRpb24g
d2lsbCBub3QgYmUgYWZmZWN0ZWQuDQpTbyBJIHRoaW5rIHRoZXJlIGlzIG5vIG5lZWQgdG8gcmVz
dG9yZSB0aGUgZmlsZS4NCg0KVGhlIHJlc2V0IG9mIGZsYWcgaXMgZm9yIHRoZSB0ZXN0IGZpbGUg
Y2xlYW51cC4NCg0KSWYgZmxhZyBpcyBub3QgcmVzZXQsIHRoZSB0ZXN0IGZyYW1ld29yayB3aWxs
IHRocm93IGEgd2FybmluZyBhcyBmb2xsb3dpbmc6DQp0c3RfdG1wZGlyLmM6MzQzOiBUV0FSTjog
dHN0X3JtZGlyOiBybW9iaigvdG1wL0xUUF91bmxZbjBSdHUpIGZhaWxlZDogDQp1bmxpbmsoL3Rt
cC9MVFBfdW5sWW4wUnR1L3Rlc3RfZXBlcm1fYXBwZW5kX29ubHkpIGZhaWxlZDsgZXJybm89MTog
RVBFUk0NCg0KSW4gdHN0X3RtcGRpci5jLCB1bmxpbmsgaXMgY2FsbGVkIHRvIHJlbW92ZSB0aGUg
dGVtcCBmaWxlIGFuZCBkaXIuIFNvIGlmIA0KZmxhZyBpcyBub3QgcmVzZXQsIHRoZSB0ZW1wIGZp
bGUgYW5kIGRpciB3aWxsIG5vdCBiZSByZW1vdmVkLg0KDQpTb29uIEkgd2lsbCBzZW5kIG91dCBW
MiBwYXRjaC4NCg0KQmVzdCByZWdhcmRzDQpZYW5nIFh1DQoNCj4+ICt9DQo+PiArDQo+PiArc3Rh
dGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gew0KPj4gKwkuc2V0dXAgPSBzZXR1cCwNCj4+ICsJ
LnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksDQo+PiArCS5jbGVhbnVwID0gY2xlYW51cCwNCj4+
ICsJLnRlc3QgPSB2ZXJpZnlfdW5saW5rLA0KPj4gKwkubmVlZHNfcm9mcyA9IDEsDQo+PiArCS5t
bnRwb2ludCA9IERJUl9FUk9GUywNCj4+ICsJLm5lZWRzX3Jvb3QgPSAxLA0KPj4gK307DQo+IA0K
PiANCj4gUmVnYXJkcywNCj4gQXZpbmVzaA0KPiANCj4gDQo+IAoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
