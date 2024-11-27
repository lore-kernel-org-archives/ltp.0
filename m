Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C83D690EF
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 09:52:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DA103DBB63
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:51:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09D523DB666
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 13:05:05 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3198563CF19
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 13:05:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKjbbxWDQ0TgMcp/UEOuZY0ogfPuc4+GkiI+pSjNatwWi2E3+y38i+H0GKBl0AMj3UNh4QK7Cz0OYPKo8s3aCblBJTWXcLnFwzwUNYITvgT0oKUjrXCcZIVw8VcLFGwgTsxJborOFdGyhsC/FP+Lh8IgyXKi9DcJOiE8+Xu4C+bDr4pZmhZyj34g0/J+uFPy4EvA7Jif/XN0J+7fDOsQGlzccv0WSyJYuTothyg9x4hZkou5dB2uNdhwM1VFZS++kUMyZqDbDXZga7qf5fvk4TqbjPnHDqIq2FRVn0ROZWK1Fovzgsug9SbHBaeSzbipB670JzL/CozHLcmkkjZY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulYBEeSxQJjc8WkgUM9QYua1OAqpq1YXfvHaPpthCkU=;
 b=KzQX2SvIFi+j1BdjkXolpK9VzjugslVFrxtRQSkIabXUA9ze2hutZcg1Nzw7NE1C/EiizYykHNvilTHbLrUsjcyyuirkDGOXXQ+47D1UH6agQSTXodm5657GqGw4bxyCma/CmUFDOPLgiBVYQ9LH9sHw2v2npXnezBKq4qc9d6HO8ktQwuAQWzF0njbB3AHipZQCfkaUeFtI5YXcRjWVUHC5yRATcmux9tb7HYGLYZpa3B0NJFldlujX5JiG+imFtCwD4KlMUh317uxXqHOaYGN34Pexbe9kdhwiXnnm0ygTG6Xl1B4RrPTiNlr20oPCObHC8/zOGdm3YQmXb4FXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alifsemi.com; dmarc=pass action=none header.from=alifsemi.com;
 dkim=pass header.d=alifsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alifsemi.onmicrosoft.com; s=selector2-alifsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulYBEeSxQJjc8WkgUM9QYua1OAqpq1YXfvHaPpthCkU=;
 b=LqTbMDFDx+iOis/2Z5oXaZXe8rHv3l2RuV38HQ+9MrtIEXaODv7/r+8ueV8kys5HKIRomasBdcgV/F9VX9UminjPQEZW9LbV/YkLqlEmeFEJbzRsTFQ/crm+AHWPz0w3B4niHJ8WXyUaf1/RG17+erIREQmN3XWQAV2sF54ZZ5Y=
Received: from LV1PR22MB6014.namprd22.prod.outlook.com (2603:10b6:408:2b4::11)
 by MW4PR22MB3740.namprd22.prod.outlook.com (2603:10b6:303:1bb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 27 Nov
 2024 12:05:00 +0000
Received: from LV1PR22MB6014.namprd22.prod.outlook.com
 ([fe80::ec4a:ae17:b696:7dc8]) by LV1PR22MB6014.namprd22.prod.outlook.com
 ([fe80::ec4a:ae17:b696:7dc8%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 12:05:00 +0000
From: R Akshay Dharmapuri <raghavendra.akshay@alifsemi.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Regarding the Musl C library for using Linux Test Project on our
 Board linux kernel 5.4.25
Thread-Index: AQHbQMNPi2gyC6xx0U6l8eYU9cdevg==
Date: Wed, 27 Nov 2024 12:04:59 +0000
Message-ID: <LV1PR22MB601444E2D0CA1619E19EAE2BF5282@LV1PR22MB6014.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alifsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR22MB6014:EE_|MW4PR22MB3740:EE_
x-ms-office365-filtering-correlation-id: 6fcd3ea1-5e40-4959-d215-08dd0edbb7b7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DsIEW/NPo1A4oas3HjdXpVf1dc87Q9pjynxYxiZ+rOtMCSM2IpFPPA0s+b?=
 =?iso-8859-1?Q?4GgXTbnIR5WxbVOc2/jzvGozo1o5oF6CktRaNmJfQZHdTXJfAkUQF4BtpX?=
 =?iso-8859-1?Q?asYtzSx6NkAKztRYZ/JtjKUMuD/zcAcxL/A5jnkxPz2A5d920Z6jUw2Pat?=
 =?iso-8859-1?Q?GiTN+x9axhY6NrKqCeAaLxGmXtLUzpWi8CQ8m8/jnT3myTFU9kyjWjkymL?=
 =?iso-8859-1?Q?IXh94AXBVyhPxg8MojyIshT5VKA4AGJ3sxbXbaLf/nUHFcAadPsZqCViv7?=
 =?iso-8859-1?Q?SdfGO5xpl4veohxRCZUcXooLdDOFkJUaJqO2fkuaVQr2pdcv0Htb7OUgGG?=
 =?iso-8859-1?Q?e9nw3MHOJrKGRsm2I5/oDqRnnKih31yREQBwRbqX6fmxPMB5C1MFw+2Wya?=
 =?iso-8859-1?Q?pu8EIJgC3zwtWrtcHgIjYrTVQxSTfUSURyCNtGdXjYmF0oeMa8uQZnU7Ct?=
 =?iso-8859-1?Q?GJ+8nvS2NNbN1HQ4BHE1rUIkZ6nZB5TNQnrdiiEnxg1OsOxXbdDwH3OGRx?=
 =?iso-8859-1?Q?Xu8E4tWqvSk1dUpbROK1sNX2571+5aqe3M77KE14YE4gpKWeMUZkEC5674?=
 =?iso-8859-1?Q?IQWZD3alcDC+tIxPWIm3NcH8A0HRySlaOz33ZkVmyBeFvrgpsjD3/qG8At?=
 =?iso-8859-1?Q?1XHPK5RDx06JJaQq1djpanP6RTAbzvhVGmzdXRn5KSxG3SFA5JvE9qBts6?=
 =?iso-8859-1?Q?ObuVV7YP9JCtkjBxAHSSxXt4uZTF+Orl88U9LJG/ePnIUMgLMpL8JSp8bC?=
 =?iso-8859-1?Q?rhr0jMqR2IuQp6fNjF5CUf8AftRA3lpSG0XksYAlhZ5SHnELXfJpP9Gs57?=
 =?iso-8859-1?Q?+ywZzzvKL+7+pAfHLd212LTyzDp/TKthgDBm5G1J88YPH+qeubwAZ1S0aX?=
 =?iso-8859-1?Q?b3eJGdlmTkx+AYVynx6DiN5Oh9QwoJ/lq83iF2OohO5Wsktd0cm7xPvqRU?=
 =?iso-8859-1?Q?sTMyptMprzQVuFLq9xE56eGY4CkcYQPKmuP2lCOXsKH+CMj4W6xEUIDgw3?=
 =?iso-8859-1?Q?jvdpv16trHCZTSnCF+0MKiqVupRNZ3SOmZMyn7bXX4r5GaVZ0MThCQRHj4?=
 =?iso-8859-1?Q?Pz/kceZwvsP/W8Tq58dLl9ORwvYhzckk+Qe+hgN/czfUcW/8k9bBlNFi1k?=
 =?iso-8859-1?Q?NrodDid7jaHUd0RYem+DWZLHnW83SlTXh3JtYmNRWYrMXLH02t3JrX9n0V?=
 =?iso-8859-1?Q?prrq/R32jqkBtrEi/XjU4dEzQmRt4mbxP01D/EG6n6TdFhsWlDYerD8D5U?=
 =?iso-8859-1?Q?7tEjcNpyiZJ7XmzVyYtlXadlsKfw9fNq1NiLlZKKq12pFznqORzNsZoOHh?=
 =?iso-8859-1?Q?iUJSZZqJrinZIp/hcYVxeiiRzdu0NOkbU8SE2XofzAmIQlxXxaw9/u13BO?=
 =?iso-8859-1?Q?6jZOeCKJ+4ZAFbPPGL/252odelsUlntRyKjG9oRdPKvi3mnqlpJ9ExLYan?=
 =?iso-8859-1?Q?qqqJkRGQUkXiRsTZx7FxKaTY+5MVWozfctekzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR22MB6014.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(8096899003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KFgk26dbQQkG/NE0aQSCHoxyseYYTB9jsBn9h6bID0smEGgqhrPIERpQX9?=
 =?iso-8859-1?Q?xGuhyTXgN4loNjEEMeoZXsC+U7fhZ75OIZEISo1UYa4aafz1gJVf+HxM4D?=
 =?iso-8859-1?Q?T7XAH4D3P2Wu6P6L1FUN3mV2rvt3l/v2Ue568ea2Y/JJVz4uFHK2/cI3HU?=
 =?iso-8859-1?Q?ugafZrbOLWSjQT0n1C2T0EESX7HKha3RwyGLijSZHAhjlWuYHOyBH5+7ZB?=
 =?iso-8859-1?Q?DapIBzxlsJcfiqbuxfGPQ3T+aAztGOjQWe1Y3GuAYfJaMCF8TrheM1ni5Q?=
 =?iso-8859-1?Q?g9iiysROWXZg4D6+Z0v/X+pth7jh+HGIfQjqT+agydy5+fd0xb7VaCjMXI?=
 =?iso-8859-1?Q?kfllOW+XGvadohBgy/aB76Fx6hBdowsacHShqfJ3XGLBP2ItaRZwQUB1Yb?=
 =?iso-8859-1?Q?re9LCX/fg9kEk99GkI1rYP81rri7Bdb4B901+LIrCts4i29Elezgv7/Lwe?=
 =?iso-8859-1?Q?QPbqMopZED0Abk4EFUlycjGO8cwEdXwp1ju7ZHGp0wYV/tPj6kmVpjnRiJ?=
 =?iso-8859-1?Q?Tm+vS8locQAwnFEuT+ka3BXGHNc3xl8DTOXdLo8CevXZeWS2RrpzeWtvg5?=
 =?iso-8859-1?Q?rxyvjCnxalKfdyuFBRAoE/QnjkDndCCFRtZ8uQBCiMx068akeC8En6QF7a?=
 =?iso-8859-1?Q?Y+QoNV60Ee785x6BhzsF+ExHJzS2rLBMXtK/4NlVFSpWMzOEZhSFqtgljF?=
 =?iso-8859-1?Q?1/3Ulv39GzdhYF3QLgon0AvpFRTLaWe0n2RqaeTh237X8TiZT3EvZmUwp/?=
 =?iso-8859-1?Q?A8JmEd0eK8nGrhbAz+Xl1Sh77IVVN8FsEASZPrEEq5MamsFnuXzfPk+esC?=
 =?iso-8859-1?Q?Xjwcy6nTZ8oImWdrggtgyOPgzud1XhhbDticcHb6QjyGyiNczY4kDCR6AA?=
 =?iso-8859-1?Q?P6F59DLIA8BKDRCezvYdY5k1paAtfqlTqphdHg8MA8lJ4pe77lvY1hRPzk?=
 =?iso-8859-1?Q?Jf4bTBnsC7d/WSv1KrT95wcpd/2J2o5xSdTnDKfSVPTReyQjYjZhin/qgD?=
 =?iso-8859-1?Q?LoRHceF5caXMSQaIffellAQIEcjw+n3kSYimRT94M69AjEYeGtKukLB2ek?=
 =?iso-8859-1?Q?BC5YY7fI2nZJkID/7/J4vrvSSK7sUZLc6dEPdsUA19SY+ekr0lLASNQdtR?=
 =?iso-8859-1?Q?I+y86k/DVmai/mYOuLXKUO1Ls4paaYPMtjWl34QBk0cTw509mkHdFK8zzI?=
 =?iso-8859-1?Q?Gj7B9TBpG+A2P+ycVtBF3tH0YPyGUQZYqPLxW5becrlncIEqdqVNLFHvZN?=
 =?iso-8859-1?Q?Q28SSMLVc2EwPNgU2TzSbzLN3z1fORvH2QJMSjqX2ZIgFoB8KpSbmQoPhA?=
 =?iso-8859-1?Q?yesYq9CR/0u5E4SU4twH3Z3Gb9hNPtV6P8q2YxsaJjqgq8D/iss6xw9jNU?=
 =?iso-8859-1?Q?amDwFqEVhpI1llSh763PEruZOAodJMhsnM18K8cnamgb0KnIpX2YvPNaN4?=
 =?iso-8859-1?Q?0wlekU6bHPSZrubcn9fR3Brfu5jn94K5VAxrXIuN8EIzca12Fjs5lCg+n3?=
 =?iso-8859-1?Q?Zhx8Nhp4GqTfFCMNM7owCFDWC/p6udV5zzqdVnhvyUl3pnjugbkWsD3Rx3?=
 =?iso-8859-1?Q?zAK8wq2UzuJN3D9qxUsFkDPxRBtITgFzPP4YZna/XRVFMUb+IqmLInjQT/?=
 =?iso-8859-1?Q?7I/K7+jt8Hr8zqnCaUFXnIwID4yJikM1lo3mY7t7j0oZDZT7BSGWniKQ?=
 =?iso-8859-1?Q?=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: alifsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR22MB6014.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcd3ea1-5e40-4959-d215-08dd0edbb7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 12:04:59.9285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b00baf25-129f-4e99-a1ef-bdc77ebabee5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtepZGTzd0+Ty2KBKxa2C8KdLux5UDc/7R9t5YQJVxzRe+7lo5lVwFEBd3jvUBzlsOgboYSAKx4zNppFHnbRpNcAsS8RfuMsyz32apKYKFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR22MB3740
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 28 Nov 2024 10:49:51 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Regarding the Musl C library for using Linux Test Project on
 our Board linux kernel 5.4.25
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

Myself Akshay from Alif Semiconductor working on LTP(Linux Test Project).I am using environment-setup-cortexa32hf-neon-poky-linux-musleabi (Musl C) for our target board.
I wanted to enquire how to test LTP on Arm 32 architecture(board architecture).We are using linux kernel 5.4.25 to deploy onto the target hardware.
Also wanted to enquire if musl C (above toolchain) is fully supported as I checked onto the documentation link of Linux Test Project(Its not yet fully supported)

Thanks and Regards
Akshay Dharmapuri



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
