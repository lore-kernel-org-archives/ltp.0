Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30380C02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 18:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738001514; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=LziDZWIbEsMqNG8wT4kutMMlNDgpqRx5uDNR8PGMyC4=;
 b=YUj2+wwHecdWGdye6c7k45y5S2ZWrWMN/5Dfv35tFfF0IWNkz7Xnk1PY0uNeEKSYP+rND
 mzNRQUb02d8t0PrhicwtQQFZGAimKFwJpRTAxcm3jEtVaalH4kLLJEz95q/wNd37G/sfleT
 gPXtAxw5B50EUbKEXynEpKZGPHfS5X0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8761A3C65EF
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 19:11:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B8383C2C38
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 19:11:32 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=hpe.com
 (client-ip=148.163.147.86; helo=mx0a-002e3701.pphosted.com;
 envelope-from=coey.minear@hpe.com; receiver=lists.linux.it)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68666635F00
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 19:11:28 +0100 (CET)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RHhRV1021889
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 18:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 pps0720; bh=hzDv7e4uAt8/69aGWju1simfoXRRO14kGBUWQxDx7HU=; b=ghQz
 /o/fA+OCRq7kB5TIFlHIvBSQfnb9aiUDFyu2FJREBxUF629ViziVxgDrqVvsz33S
 0eUUuKG2qPWSV03VvKhqIR/n02BfgX7lrtswaGUvll9jzZ1j7sAHWAjlYPnsIf3L
 FyS6w4MnaVW/XDbTu+fq0npeJVcWqh1DBEnG7wVComa/T/wOfIVDv7TJcW7iN4FC
 KXdgxd897PP678FdpX2zlVZBcjgfo3JvbOdARoWAIJdP1FidpywRVmjgSRC6DJEm
 T+2ntJ9IQzLrZmquj6mqhxK89cdOuIPbFxCh1F5492lnNRFv3yq5l3ffbEv3ZT+T
 nDZXUqc0Juu976ReTg==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 44eess87sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 18:11:26 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id BD09C801739
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 18:11:25 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 06:11:10 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Mon, 27 Jan 2025 06:11:05 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 06:11:11 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgsuHcJyL/YJDK8mlc4nD5svnwrs5J4iGGaudT7mJGN0GDEye32b1DZX0bvJEXRoSUCqOGtw7LkKd3G4Kz7UqadIRiTaVRbWK8ekxwbPaG+dg3/A3w6Rgxp5NvE7a6gSZRi4pV+fcQDJxH7+M45AvuLhIyUCE1dsOJikKv1jDg+7QFfbtO19MqQSo5atoI75/MQ8IPhwwOSeZ3olNrSP4fgqeDZJx3Fh3i5herYc87c3Tj0aj8zXBiDrTFoYnEL4FW+RAxG75TtyECgVkVKYsOr2EqjtcIKxSJ+NHfyuWKecf+3562b5rSkRBWyt3/Iln25c5vP8gUTy1p16RbAN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzDv7e4uAt8/69aGWju1simfoXRRO14kGBUWQxDx7HU=;
 b=gi6mSY0BixoIiD69RyiREavr+p1Fk5ofE58U1SjMvD3Fyxo8+8kL2srJJz5Z6anPWTDqblqL08OzF7CbQ3r4e7OGIVNOlxfLcSwNLDJXr4q3MYV0GMjrQqTYElCSOz1JODkTBkjoSKLwelH3kU81V1SO9aoX6UytJdER15tpbmH7+6nrVx9L5Lrj28waMvTGsrRWOLTUDI5eXcrJa1X/h55QZwDaJ+CfnyVFBVffGnmGisSkYrRViQkzsv/LK4/H9RWGN3PfVjn5o5Xbs+XUASHygzwK39kr5LVDDRZFNdFZ16zlzq60ABTvyVdWy115ccKrl9xVxgHleL4CEPTJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MN0PR84MB3022.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3ce::15)
 by LV3PR84MB3553.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1ab::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 18:11:09 +0000
Received: from MN0PR84MB3022.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6431:db58:d32e:2b02]) by MN0PR84MB3022.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6431:db58:d32e:2b02%6]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 18:11:09 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Possible fix for LTP Issue #1219
Thread-Index: AQHbcOXhivfgRX1T+EGZAq3G4stlcQ==
Date: Mon, 27 Jan 2025 18:11:09 +0000
Message-ID: <MN0PR84MB3022EFF407AA0C3130EE9728EAEC2@MN0PR84MB3022.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR84MB3022:EE_|LV3PR84MB3553:EE_
x-ms-office365-filtering-correlation-id: 0b8409e9-027e-478e-7d2c-08dd3efdf9c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?gaVZiaNc7JPOmF0FYLJUbQOvYjVnNIL6LMls9s5+xq/Hld0Wja2TSLzo?=
 =?Windows-1252?Q?aYbnKCbnpreY2HF1yP0UsVTYxg94BnwZOq0gVmze2qqDefHktmmw8FpH?=
 =?Windows-1252?Q?hHoGA/3MU+3avMPT9WMabvHo4GL7jWzQUij2XwUqt4mgnfdF3IkykNK9?=
 =?Windows-1252?Q?0LsFIb0LP/mEgLpRxuoLUADyEA9dEo2RwpCaSpLxF2zUFUzwg9gTWKu/?=
 =?Windows-1252?Q?alspOTdggolyNlT1nUqe1HzNj8LWVL4yEvqFly8BmQNVdIAHUZgMiw9r?=
 =?Windows-1252?Q?zv30ppAUEXS62Z2LTAoM6DLap9pfAZ/zwJBHvR4HcIzA5n3AJzCPTUHi?=
 =?Windows-1252?Q?ZK3wDhgwGGwYJ+NkPI8pRX0K5N30hjXL9jNehKZb/Eb6U4L4uyZAuNgZ?=
 =?Windows-1252?Q?1JYfrbfY3G6wcMnYCU5vhT5pA/ZoiSaCmvCwsHe1UNGJ9kr1UDQtwIU+?=
 =?Windows-1252?Q?UAnZmFpCyVBEOgayTp3e4pvoYqoDg+FV0oPYbBKwjzbmql06xvhDqWxs?=
 =?Windows-1252?Q?decixaukch//czNUY/+iCjHuLHvO7ttcFdX6umIhJkNNNg2etIFgrKbp?=
 =?Windows-1252?Q?P5v3ibo/XDbZgi5/4DgTS9lU9HyLsIzUfhdncgEFw8K5XjbpMWcKigOF?=
 =?Windows-1252?Q?5+eaRGpq7+GbdfD4TCY2Dq0Xhfyny37FXrwD1JwCdDRByqcE4vcyg0l3?=
 =?Windows-1252?Q?HHez1bR031T53VWJvdJWnyevP+4elLoCJa2uWN4i5qEd7K/zM4Go+iJZ?=
 =?Windows-1252?Q?Mefo2mGvjfThdyRVYJJl76GpYeAlqnIdY+EtsGfELLO+Kp4ie5f3vqXf?=
 =?Windows-1252?Q?HthpN7pHYoBGG75rfehWOI9X/BownDe3hL4JeL+WEh323xnO3zZr8nD5?=
 =?Windows-1252?Q?mAloWLbocCrKVZaCZ2fSCtB49YKw105bngglyIy66+XbErru9WrueLD3?=
 =?Windows-1252?Q?G/m6Vx2WQjTBRoobacXrXyuuw42pq4xZZ/ey/f5TzNR419TObaa/K1Kt?=
 =?Windows-1252?Q?4TMw/BccHP7/ZIMuemSOALF/wDH0rWLbQPXZQL+ZrJtQYdT6ih7EZJe7?=
 =?Windows-1252?Q?UEQ8FANknc6lv9rJt/slsyVGOBGUvZ9V/ssUlJXWevm/3B4qGWfePoSs?=
 =?Windows-1252?Q?/ye65e8xkc7pEcM46TuOez5oQ8rQxlES31Dtga0VOnyoRUiCKVKgL1B6?=
 =?Windows-1252?Q?2qmIDfL8co+8ytTViJUkCr2cCstECg0AzneCyfA7PzaFXlnM8iApa2eG?=
 =?Windows-1252?Q?asisjLPuwbqxqg4PIxRNwBaBH3nl/QTJEic8sTgQ8Ttwq3xr41HAs/GS?=
 =?Windows-1252?Q?ePv8gKCPiVw7jNW+qMuPjAkJinr/GrBMeVKotTcBQG50ZENyypu6T8J6?=
 =?Windows-1252?Q?XoCkc59VI5Ct+3Llt6UhUDm2Bm1eGeJ3ie51KC/NPQZWPlWgPjlzidXR?=
 =?Windows-1252?Q?ZNat6NUBtV26Hh95L6npZpXsVNLH9s3UqNsk3nHBapbqfoFYUQRAmHPP?=
 =?Windows-1252?Q?tm/hqCowEaz0cqvNEIsv8Cxpj4tcvEQbzcUz7CwauxStwGIPF1SVtCYv?=
 =?Windows-1252?Q?qdSM7l2IVg5rey2f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR84MB3022.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?aUWj3pfFdyPqjs53ZwwhTP4jRYXXtnQi6ez3iBJRaBwFWk71UBEfQrMC?=
 =?Windows-1252?Q?cZ6m9VQ3eqATI6ofveqOH18CskQaW95kNFZQ2pJoZJem+UHSujR0DoJU?=
 =?Windows-1252?Q?wORcTlWWZ12o30BlhzF0Jjn/9pXNBBJJ0ZwR+LfgcD9IcHmAJlGE7sSx?=
 =?Windows-1252?Q?4ZLklmhNsfx5MNjqT0ZJB9IfloiXXC3UjMC51/R172+U6L+6A3IQzPAN?=
 =?Windows-1252?Q?C4AxMeTlPb1m1mVjnVdkgR9SsHyj9ZtKbMRJbp+sxDCvF9bfQwcURY+x?=
 =?Windows-1252?Q?GPkeFpfxqh76SPYu1PllRGoAXvfPeLSgom+fmcTbWztNlx6BVlwXBRXS?=
 =?Windows-1252?Q?3V9TST2VzaxxDbMASZ5z4omGll9m7YQMJsWLS7+3cGWLtATSLaczPbkW?=
 =?Windows-1252?Q?xXO1lkWQ++kNb5fqZSF34NLVQylFbVZmNMwvZntcPH4Ife8cc+5TeGH9?=
 =?Windows-1252?Q?D0N/vIgQ+tJM/CDREPRst1J4Au7gpZXRUbSJfLDwBt7/bKnWpsWxb7H+?=
 =?Windows-1252?Q?WJITElYsffheX2H+ez487cVGN7H/OUh4KT7GlpjXE2+F39O0Zo+QiOfB?=
 =?Windows-1252?Q?cF04WuMWJaDT6re/WFeMLkVsAEyzDONt/WzBU0LPJW1vgj+UTCFInNsn?=
 =?Windows-1252?Q?PbE3BHgsLr7zEL3w07p+Uf4a9BdRx3V8vWRI6y8jdooIZX9DmAiYOXjQ?=
 =?Windows-1252?Q?rJlby8p9S0RXcEqYW7FVSosixnNGSv4GIKL1jBT+/cjXaPkhP4nYV8uo?=
 =?Windows-1252?Q?3eKogdNrS9wzyRLzQ+QdNnFggox5wymL8TsraEFyUwrzaKPq3g6QikFI?=
 =?Windows-1252?Q?PaTp/viC4wQiWjgfv1l7+43lQFtxwOV7T44X+yS8Ysyfk4QyfDioXc3E?=
 =?Windows-1252?Q?kdEFTxk5Y2iyFLlWb602TPmwQoKFz75h2qsuB6OVvBLOdBiw9IoSv4dJ?=
 =?Windows-1252?Q?R5J0BD7qSPan0VeiSJhZiaYwqVexiIH6zQMsD3kaetnq/HlSnXuXDmaZ?=
 =?Windows-1252?Q?aiAd5snuFvoXnJoLywWkc5aiXNFNwfl1aFqYv9LyYswMEfzTw1HRrQ9q?=
 =?Windows-1252?Q?1SVbKSwKHK3eNrhrbt33/Fx840ic6/XFO8c7WRkRckNMR1ReABSY5WQb?=
 =?Windows-1252?Q?XhkpJ6Ccoh44z2tyipjdRuZYF+i57PDJPzcxNYEFiD2ROb0oEVQ7awqy?=
 =?Windows-1252?Q?3LO3nJzvxziKyw24KwdZogJdK08kHMzEILlbxUJ9AXMKD8AtXuSYT58N?=
 =?Windows-1252?Q?55uogd9jbfUqOs/SSlVUBS8gI0TMdxjiC5IGRt/wxYFsUQZotMFr/RZK?=
 =?Windows-1252?Q?5sAXXHZnduvu3xxy2Q9aH309f1UXHG6P2NQZoDHCIngW1g83TC1GJePx?=
 =?Windows-1252?Q?j1z7jP2Q/vDkxVtlr4CHR4qV4wfb3zsXr6/gul9MDXfxTpyjwLxyUd8t?=
 =?Windows-1252?Q?TIsvq7ckAKwNIxPiA33gGiBWBISCxbmkT+fdAdMHeI8+SWsJ9xnyuWMI?=
 =?Windows-1252?Q?mOKQeCP6A9XYq1JYhlGz7EzbrjLNu856EQKW/zN819nHQ3OX/CNXEzVk?=
 =?Windows-1252?Q?0RsuiI8sjzb2KkEfOh+otzIIDmeVTIdXKrS6hp4j1ALdoYbwRyYs9OHM?=
 =?Windows-1252?Q?ieQkzrl+ELGtCsJ0oezV/H6LrLkvlxnly5x1mSYQV8zIHIiQuuh6Py8j?=
 =?Windows-1252?Q?zypRNPtSBs2dtBQvuX1fvfzfhrBoYTY/JoXT4GIAZvyHJy4HevsnoQ?=
 =?Windows-1252?Q?=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR84MB3022.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8409e9-027e-478e-7d2c-08dd3efdf9c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 18:11:09.4386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqj/o5YWX8K08eVDNaXVmv5n4evPdfozIse3mJyp9F0FCoEjo3eDdP4WP5uPc/3gnbDkjF99pGfBam6tAId1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3553
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 67vLrmK8Sis5GeHvLLkPFS5YqAa5YTBH
X-Proofpoint-ORIG-GUID: 67vLrmK8Sis5GeHvLLkPFS5YqAa5YTBH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 phishscore=0 impostorscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270143
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Possible fix for LTP Issue #1219
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
From: "Minear, Coey via ltp" <ltp@lists.linux.it>
Reply-To: "Minear, Coey" <coey.minear@hpe.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I created an issue against LTP: https://github.com/linux-test-project/ltp/i=
ssues/1219. =91pevik=92 suggested that I send a patch here. I=92ll admit th=
at I=92m uncertain what form would be preferred, but here=92s what I=92ll s=
hare:
[[PATCH]]
diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/=
kvm_pagefault01.c
index 16b3137c0..649bf429a 100644
--- a/testcases/kernel/kvm/kvm_pagefault01.c
+++ b/testcases/kernel/kvm/kvm_pagefault01.c
@@ -214,6 +214,10 @@ static struct tst_test test =3D {
        .setup =3D setup,
        .cleanup =3D tst_kvm_cleanup,
        .needs_root =3D 1,
+       .needs_drivers =3D (const char *const []) {
+               "kvm",
+               NULL
+       },
        .supported_archs =3D (const char *const []) {
                "x86_64",
                NULL
diff --git a/testcases/kernel/kvm/kvm_svm01.c b/testcases/kernel/kvm/kvm_sv=
m01.c
index 32d15526b..f81602567 100644
--- a/testcases/kernel/kvm/kvm_svm01.c
+++ b/testcases/kernel/kvm/kvm_svm01.c
@@ -108,6 +108,10 @@ static struct tst_test test =3D {
        .test_all =3D tst_kvm_run,
        .setup =3D tst_kvm_setup,
        .cleanup =3D tst_kvm_cleanup,
+       .needs_drivers =3D (const char *const []) {
+               "kvm",
+               NULL
+       },
        .supported_archs =3D (const char *const []) {
                "x86_64",
                "x86",
diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_sv=
m02.c
index 6914fdcba..701f2731d 100644
--- a/testcases/kernel/kvm/kvm_svm02.c
+++ b/testcases/kernel/kvm/kvm_svm02.c
@@ -129,6 +129,10 @@ static struct tst_test test =3D {
        .test_all =3D tst_kvm_run,
        .setup =3D tst_kvm_setup,
        .cleanup =3D tst_kvm_cleanup,
+       .needs_drivers =3D (const char *const []) {
+               "kvm",
+               NULL
+       },
        .supported_archs =3D (const char *const []) {
                "x86_64",
                "x86",
diff --git a/testcases/kernel/kvm/kvm_svm03.c b/testcases/kernel/kvm/kvm_sv=
m03.c
index 87164d013..87f9887d8 100644
--- a/testcases/kernel/kvm/kvm_svm03.c
+++ b/testcases/kernel/kvm/kvm_svm03.c
@@ -88,6 +88,9 @@ static void *vm_thread(void *arg)

static void setup(void)
{
+       /* Run the common 'tst_kvm_setup()' first. */
+       tst_kvm_setup();
+
        struct sigaction sa =3D { .sa_handler =3D sighandler };
        pthread_mutexattr_t attr;

@@ -155,6 +158,10 @@ static struct tst_test test =3D {
        .setup =3D setup,
        .cleanup =3D cleanup,
        .min_cpus =3D 2,
+       .needs_drivers =3D (const char *const []) {
+               "kvm",
+               NULL
+       },
        .supported_archs =3D (const char *const []) {
                "x86_64",
                "x86",
diff --git a/testcases/kernel/kvm/kvm_svm04.c b/testcases/kernel/kvm/kvm_sv=
m04.c
index e69f0d4be..d8d3bdd96 100644
--- a/testcases/kernel/kvm/kvm_svm04.c
+++ b/testcases/kernel/kvm/kvm_svm04.c
@@ -297,6 +297,10 @@ static struct tst_test test =3D {
        .test_all =3D tst_kvm_run,
        .setup =3D tst_kvm_setup,
        .cleanup =3D tst_kvm_cleanup,
+       .needs_drivers =3D (const char *const []) {
+               "kvm",
+               NULL
+       },
        .supported_archs =3D (const char *const []) {
                "x86_64",
                "x86",
diff --git a/testcases/kernel/kvm/lib_host.c b/testcases/kernel/kvm/lib_hos=
t.c
index 8e3d6094e..17215c23b 100644
--- a/testcases/kernel/kvm/lib_host.c
+++ b/testcases/kernel/kvm/lib_host.c
@@ -323,7 +323,14 @@ void tst_kvm_clear_guest_signal(struct tst_kvm_instanc=
e *inst)

void tst_kvm_setup(void)
{
-
+       /* Do a quick check that the 'kvm' module is actually loaded by
+          checking for '/dev/kvm'. If that device file is not present, then
+          the module is likely not loaded in which case we should just CONF
+          out.
+       */
+       if (access("/dev/kvm", F_OK) !=3D 0) {
+                tst_brk(TCONF, "The test requires 'kvm' device, which is n=
ot loaded.");
+       }
}

void tst_kvm_run(void)
[[/PATCH]]

I=92ll admit that this possibly contains parts that you may not want, but i=
t includes the parts of the issue that I raised.

Coey Minear


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
