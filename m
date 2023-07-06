Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232EBEB64DD
	for <ltp@archiver.kernel.org>; Thu,  6 Jul 2023 03:13:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 692783CEF32
	for <ltp@archiver.kernel.org>; Thu,  6 Jul 2023 05:13:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1F2E3C997A
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 05:13:41 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0C46C6002E9
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 05:13:37 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 3663DO4X095026;
 Thu, 6 Jul 2023 11:13:24 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 6 Jul 2023
 11:13:24 +0800
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Thu, 6 Jul 2023 11:13:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.26.104)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Thu, 6 Jul 2023 11:13:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc57PnAdGjZRrLIxBcsGw8CvgulkCtXcEtYN7nmh1Gv1pC8wygaBik3ZXotRkK8YZuSfsVOIUF5YWil+thH35aBumB/hrwWIOq9yCNafzLaAqPmzdPQiewzONxjMtcVlIcV2aGHyIOE7N2IvjFDmDJ/GwUwvqM5Ig8IBeSO7pnx0ibITmOqsYzED35102GfMLrlcnP3vXVC1NJZA/BoP+Hty45ZniXPS8/9ZFl5JqNW1Ghl4ZhDqFgL5Dcyuq2EUijCPstqGENwpPdQ/tUoVVIOzva0jpfQRi46HC+dZlpfWVP0kXuO+N5bQjr/qPTYjq/Z1GMFRT4c5MXb8Vl/JFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caGauOEKR8A6QOhi7NHrIy1DkBL0gIkEU4SdOUizH6M=;
 b=ThV6o03ZdICd9Psd/TXVY44tbaYRS71ASQpQoLfKoGfS/yWoDWsoOwUKl8WMtcbnoIhyqKAHBMz5opY0ClBmrrkGUTZM9CnsUZJ16LlbipW36lby0kp5gfnCGZ6dDDxf8J2bUTX25qjvX0UiPBT6heo7pMYewPNptX4Qrwd48FiYQD+b5uB7pQSnln+25x7YsaIKI0mj1JBjc81F1sF8NxMK+T+9HnFYmuQ5hjj1X+0yy5zoHT6nCx1/7MZabSeeWVPYu4JpQ0mOEDPJltJYHYEQFWuBkoghhgSQLi9VdpJwh7AkpKLM2f6MJ378ZimxBi2fVp9tDO6wLddBSMPVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
Received: from SEZPR03MB6619.apcprd03.prod.outlook.com (2603:1096:101:7a::6)
 by SG2PR03MB6261.apcprd03.prod.outlook.com (2603:1096:4:175::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:13:16 +0000
Received: from SEZPR03MB6619.apcprd03.prod.outlook.com
 ([fe80::c31:ed2d:6d62:4819]) by SEZPR03MB6619.apcprd03.prod.outlook.com
 ([fe80::c31:ed2d:6d62:4819%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 03:13:15 +0000
From: =?big5?B?RHlsYW4gRGFpLVJvbmcgSmhvbmcowempp7/EKQ==?= <dylan@andestech.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc variant
Thread-Index: AQHZn21QOxrsesyk1Ea83vN6QBN5mK+cuAaAgAAo2YCAAQ0cAIAAz7cAgAAVTACAADf2gIANIfDQ
Date: Thu, 6 Jul 2023 03:13:15 +0000
Message-ID: <SEZPR03MB66190287F9B7DAFEC8870340AC2CA@SEZPR03MB6619.apcprd03.prod.outlook.com>
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
 <ZJlZD2fVXaVM3X5i@yuki>
 <CAEemH2d=Mf=WsSXFGwUPeL3dqSOR2kf-eJr+C8HFTMMhAEynKg@mail.gmail.com>
 <20230627135004.GA58180@pevik> <ZJr66taHPoyDthnz@yuki>
 <20230627182635.GA85230@pevik>
In-Reply-To: <20230627182635.GA85230@pevik>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6619:EE_|SG2PR03MB6261:EE_
x-ms-office365-filtering-correlation-id: 4b9ef743-ecbb-4f06-d398-08db7dcef056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCSqFYMLKCWJxBV4y2wMLvmGCFlYaRG41xTpTOFAblGj+wMrPpoKXHIrkMeWyK4e41tktpRdlGMKPd3Z1x1atAZiI/LXj9RYmsXhMwytlSS8QrB1E00Z37ztEfNKjm/7zjBkgYJj2gZI3YK/FZWWpnmIjLZl302jxM4PPitQtHxWxVLswg/Vw/Gx3hDl0KAFH9V4WZJa/UfsOlRNm9qGm9K6S42FguDZLIIBZl7vd1H/5/CykwlCCP4fq5c66/OPUeWnGkVu5MkkpJFQdxZfuM9rGV19YPbVhDTltabpOoaQyUowK/k/EaEeCSi1afOvz+gnDz3bq7DhllKaqtjJw3vBwM5Eu9eosG2wTOnKnLJDAs/oH8QMVxnJT8TH5Wq4eePzzDRQFsYgaM98mnB5MFiICDEAJzgJclF3M3/ofbE3D71MYGFZbCIZAUtbAKC9ndecIUhPCMooUVNxIgQgX0tZI7UitLr8NYklwWvdFI3rjokotsJz9Bt1I2jZF03jXaueItmYEi/nfdax6dYVYcjrAOrMHvf6Ho+Z1pXRsdcFbEoZwUekHD7+9Zl4bnGw73kUfvgRr2d+iGVatXszt/wv0bm5prz50eNpoNdRBh7hBI0LEBLgDhPyo2l87nnA1QiYEjV3xJfbWNcpsGYmPbmvxiRkm59VWPULqfzJ9JM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB6619.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39840400004)(136003)(366004)(451199021)(41300700001)(9686003)(7696005)(71200400001)(38100700002)(122000001)(83380400001)(6506007)(186003)(26005)(55016003)(110136005)(54906003)(38070700005)(86362001)(478600001)(316002)(85182001)(2906002)(66476007)(4326008)(66446008)(66946007)(66556008)(76116006)(33656002)(64756008)(5660300002)(52536014)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?c2xTbFlEMUFLSlJNNUVxUXFaM2R4U2cxdEFDbkVLOUROYlNTMzNPdVgwNWx3L3BP?=
 =?big5?B?UHNaQUxwWTlkczZrUFR5RzFvb3dKbUwvL2s5ZFRoSmVGR1BySzQ5eDBuT2lrN1JO?=
 =?big5?B?aHhlU1V3WWEyRm52bTFTanFZbzJHMENRUGdPdEptYzdybEtzYzVWSjNLS1Z0N1hK?=
 =?big5?B?cktLVGQydG5lQUVRMjhkclpKRG5TSktKMHFhODV0ZDBySEVVZDBURVhxL3VjTVVU?=
 =?big5?B?OGpuYjlCZnpqUTMxL2NkbUx2Tk9yeHNKd0dZQVBvVEgraGIxMTJXbTkvQks0V2g4?=
 =?big5?B?dVJlQmxKZ2NaRFB6eUU2RHdDcytFRmt3cGJKVEFkKzVSaXErK0VWalUwMjcwQkwy?=
 =?big5?B?NTRXa3VVTWpTVmNwcGJkU2FiR0Fhbjc3SXFoVFhzNEhhVUVQaVlSelN4NU15ZU0y?=
 =?big5?B?T0xXOXJlSGs1a2pOQk96aXozU3ZUYUFkbkhWZkV0elNBOXBWQk52RmhOUHo2TmY4?=
 =?big5?B?Wmt1Z2tLSVJGV0h5NmtRbmhGb0laaFNMMEZzVE4yVGZyNm5ONnc2bUdLeHV0dFJC?=
 =?big5?B?Y2c5am1jRjJkelVyYzNrcFJYenk5eE9qZUlncGdVWVhTaEc3a1pMbUt3czRVZ1ZX?=
 =?big5?B?Qm9Hci94MUpGc2l0WEVNaDlEdVNxcGpLNjE2WVBCSGFhbVNrcUFIQU5UQVhydC9I?=
 =?big5?B?alVzckpjeDBHWjFXYy9oYjdkZnpNbzdxT3c2bjM4MHJ3L0VIektCUXdCRkkrWGMx?=
 =?big5?B?Skk3bDBEcmUyTlZ4RmQxYkVvaEovTWduRlhHMzZTUU9iVGw1Vnc4R2VPRVlGbmxX?=
 =?big5?B?cnVSMEJVd2d6N1dCS1BIa1VaKzhiRTI0THZCN0d1RXN1Nk9UL205bG84QkFKUzli?=
 =?big5?B?Y3FsTXNpMFJxL1A2ZGM5U2F2b2Q0dWFaK1lXZFN0VXh5QzZ5d3h4Tm9US28wZjRv?=
 =?big5?B?ZHVUUG1OandEa0dEM2pUY09zRDc1VGxQZnF4VkhGVU5TUkhuZUg1aHhtb0gzL0hv?=
 =?big5?B?NlVIeENKS3RBZ1RGTm45Tm9mcjR6QkpubTBFck9QOEVyMXk0MW9NaEVGQ3orTWFk?=
 =?big5?B?aks4aVZOYkhOY2FLbTJTV2IrTmVZRkpjQWlRN2dNaHpFSGxIZ3R3cXZOWDBrcVBm?=
 =?big5?B?YmlBUXVvemdJWHd4b01NZzRnZDJTVENjZDA1UHc1Wm5qU3J6U1JFTEx5bUdYRnRW?=
 =?big5?B?SFAxdUJ4R2NyUUQya216akFDYVE1NWlsekU2YWRiczYvSmFnSWlUQWNqbGk2MDVz?=
 =?big5?B?ZmJmMVRJUStBTzZrc3FJRm12QU1NUHdDNmhrOE95UWlwYk1PUHNXc1JJMjUwUXgw?=
 =?big5?B?WEZBZHYyN3pmc0tzam9ZcW1rOTIvTHRsSmI1bFRRRjZkQzNOZkI2ZUVCNnR1Y3RD?=
 =?big5?B?Y3kzU1VNSjRCbGpIREkyaEZaY0hEYUJLM3VMaVRQRFltOWZpSVNOUTMxVlFsaVNr?=
 =?big5?B?SzRvakgxcUFEaExEaStvQ3ErTXg5ejl5c1krRFFsQUhMR2FabzFZRzE2YXppRGZi?=
 =?big5?B?V1R3Z2Qrc3pSaDZvamQzTzZUc1UwN0ZYaUFmUEVYUm5hZU82OFlOOFBMZ1RNYTZY?=
 =?big5?B?Q2w2dmxwQlppQlo5TnVrQlI4NXpoVWJPbGVXUkllU1NYSGVRQTJrUWdjQ3VCOHdE?=
 =?big5?B?VHEvanA4K1pZVW5DYlg0a3NhalkvUkV5U2tBZElwdWE0dDZvU3VjNHBBM2JkNWsx?=
 =?big5?B?L2dwdFhVZ1loTU9NeFcvaFFrSTlSd01tdTJ4V3BRNm0yOXVtR1lkREFDR29UaTdP?=
 =?big5?B?eTVlZDF0Y21kc2xVTi8wNitPOWZ0VVVNanFYRWp3T1ZTRzE4bVU3cG5qK3YzY3p3?=
 =?big5?B?QmZrSlZVY1pUeTJCTGVXb1cwT2J6TzlKbjhjM0NKZWxHTUtUVlYwS1Y0UHcycDJU?=
 =?big5?B?WUdkSmJiZTBrTk1hdHdndXY5UENWTHpnaUhSZm5HUHF1SDg3VWI2bURXbGVaSVhB?=
 =?big5?B?eXZPWW0rQkFNRHVnZUs5QTF1WU1taTNUaWI5NTZTUWg0RWZZbUd3QmgvcVNvN01X?=
 =?big5?Q?mpMECioAAxwjvqtrG56vsh86SZinOHyZwfR6/Ty1/+c=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6619.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9ef743-ecbb-4f06-d398-08db7dcef056
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 03:13:15.1470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOdcAwClCVn1X7i4BI2Hjp79ZdB/b4NfDKj+Rtu5Sj3dNpKgscno6d8QBwqxbsEJRy9Hb6iCLidpBudTuNHJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6261
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3663DO4X095026
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: =?big5?B?TWluYSBIdWktTWluIENob3UoqVC8erHTKQ==?= <minachou@andestech.com>,
 =?big5?B?VGltIFNoaWgtVGluZyBPdVlhbmcovNq2p6Rorngp?= <tim609@andestech.com>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

Thanks for reviewing this patch.

> Hi All,

> Reviewed-by: Petr Vorel <pvorel@suse.cz> LGTM.

> > Hi!
> > > > Okay, sounds reasonable. I agree with this.

> > > BTW I also get ENOMEM on my laptop (currently 1G free space):
> > > hugeshmctl02.c:119: TBROK: shmget #1: ENOMEM (12)

> > > Should we handle it somehow?

> > The line 119 looks suspicions, in latest git the hugeshmctl02.c does
> > not even have 119 lines.
> Well, it occurred with this patch (file has with it 147 lines). Previously the version from master worked, but now it also reports ENOMEM even on master:
> hugeshmctl02.c:87: TBROK: shmget #1: ENOMEM (12) (therefore not this patch specific). Should we use .min_mem_avail? (not sure which value).

This patch only adds a set of test variants, and does not modify the content of the test items. I think this error should have nothing to do with this patch, maybe another patch can be sent to solve the "ENOMEM" problem.

> nit: The patch subject is "hugeshmctl02: Skipped EFAULT tests for libc variant".
> "Skipped" => "Skip" (we use imperative mood).
> IMHO more important is the fact, that test variant was added, that's what I'd mention in the subject. Of course, I'd keep in the commit message body that libc variant was skipped.

Thanks for the correction. Do I have to submit a V2 patch to fix the title?

> Kind regards,
> Petr

CONFIDENTIALITY NOTICE:

This e-mail (and its attachments) may contain confidential and legally privileged information or information protected from disclosure. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information contained herein is strictly prohibited. In this case, please immediately notify the sender by return e-mail, delete the message (and any accompanying documents) and destroy all printed hard copies. Thank you for your cooperation.

Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
