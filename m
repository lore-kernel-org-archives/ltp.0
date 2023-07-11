Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41A5EB64DC
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 11:24:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 262643CDECB
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 13:24:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE6533CB8A5
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 13:24:27 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 983FD60076C
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 13:24:24 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 36BBOEFZ042607;
 Tue, 11 Jul 2023 19:24:14 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 Jul 2023
 19:24:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (104.47.26.49) by
 mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Tue, 11 Jul 2023 19:24:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXZPoW2Zn2YIBBiy6tU+2AUYBBVmKuFBDPOsgfFXVzlRiHDGfIshJQfSuVGK5beXFoXnFznNo6mn5iRUJfLttvY0oai9NzD3rXBjWioId9Nwt1BPwwq+v2EM+7zeaUlmXT7ah3FmIrISe7q8HSg5w66YrFceVR895Sq+4BmVtYhiG+fxFpGJzyQWfrBmhJpOwS07DJr1TU4iHYKec7hNuFJ8fb+uMZEZ6A9YrTk9RBkhRl9jSMC86WkTKPStxhYKzunDcL4SvQm3FYNE/gjoAt5GDMJ9CxoQM+/TCoQaJGPvy2i9AZ3Je3jqDGS93DWj5s1F6hdPfsOmWRpgDite7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yslllwkDSO7Nn+OhhFCPmsmouDmC9ZKlACRbggPQm80=;
 b=TUO8PHqd0Adw9+bTWGoFkrm1VgcwJIoR3e5U/jnABEsYuPURhtVlhYJT0z/2xDE+XfHKg9CWjoEHPRIHHbV7I5sQSrJ1K3WAy+OVliECsVnkLl3Am+CWiFa/4L1yjVdVZ909KCdDS/NSG/UhUnhjWeBSzENIk1+xR5R8fJhUkqZ1q4w8/KSeNFm/sN3ks62Zfbb6sizp4lcw9IaCdND043LtrEd4Q/yNrxna4HzU68ZfWHpnLAKmwESW7exY28FAq0d68oOh5A2qj+eashLTYJer/uT1063zuxCmNeYz+zxSUjS9IdUsB2g1JQojVMSNJt5Gd+Zr3jbzbsbdQB7TxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
Received: from SEZPR03MB6619.apcprd03.prod.outlook.com (2603:1096:101:7a::6)
 by TYZPR03MB7484.apcprd03.prod.outlook.com (2603:1096:400:427::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 11:24:03 +0000
Received: from SEZPR03MB6619.apcprd03.prod.outlook.com
 ([fe80::c31:ed2d:6d62:4819]) by SEZPR03MB6619.apcprd03.prod.outlook.com
 ([fe80::c31:ed2d:6d62:4819%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 11:24:03 +0000
From: =?big5?B?RHlsYW4gRGFpLVJvbmcgSmhvbmcowempp7/EKQ==?= <dylan@andestech.com>
To: =?big5?B?RHlsYW4gRGFpLVJvbmcgSmhvbmcowempp7/EKQ==?= <dylan@andestech.com>, 
 Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc variant
Thread-Index: AQHZn21QOxrsesyk1Ea83vN6QBN5mK+cuAaAgAAo2YCAAQ0cAIAAz7cAgAAVTACAADf2gIANIfDQgAhoOQA=
Date: Tue, 11 Jul 2023 11:24:02 +0000
Message-ID: <SEZPR03MB661997C80EA3A2641F99E4FDAC31A@SEZPR03MB6619.apcprd03.prod.outlook.com>
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
 <ZJlZD2fVXaVM3X5i@yuki>
 <CAEemH2d=Mf=WsSXFGwUPeL3dqSOR2kf-eJr+C8HFTMMhAEynKg@mail.gmail.com>
 <20230627135004.GA58180@pevik> <ZJr66taHPoyDthnz@yuki>
 <20230627182635.GA85230@pevik>
 <SEZPR03MB66190287F9B7DAFEC8870340AC2CA@SEZPR03MB6619.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB66190287F9B7DAFEC8870340AC2CA@SEZPR03MB6619.apcprd03.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6619:EE_|TYZPR03MB7484:EE_
x-ms-office365-filtering-correlation-id: f3538179-84e9-497e-6163-08db820154a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHNddLULvfgTeRlM5KbDOE21or2EMz/CtfGr+QGgXsMkrh/DMhM63586228w4EOom3rfLfqT0cUqoTqj6dd3h5olPGATUKT24N+wrSKhIfW2/yQjRSF1ztIjaNfcP0aEFdWot6+0qH5assJLol7z3p8WTpOtA5f0UdEXQL4KhBFtrF1we+ciZje0PTWiRoof4itbfiLlxIJPcERRNlKquL68NohwM9fHX2l/Xd1EUEQcnWnf9yy3xkrr1SlSS+EJxWq/gMoU2yWYmAJbJigLT30IzMiE9UXj+nWcxefrWHeoKE4ksWYwMeBMZ3kxb4LvA5bM5k0DOAfrnbEcIChQDHVj79BvPN6DlaqD2sppZ1KQYMIJd+Ysdn8oH70+PY33VtV2IffnWxdJTsEDowsuOrhe4DN7wfMn1BV2APio8FZ1peXe2zaZW5uw32I13plbR3jI+xbHbWyRyaZjr2j1BMFuRCsPNTVbmy6msE4Q/C/Lcf3FPLB78G7k1fskik6EiypBs+2gYad8FERDK16JfDD/k6UIYMORSuMQGhcpoeyXeEFUBJS9PHOOam7iUW1sl3SiTU2lszadCZIU0NhtRUmzM5H9RNO4cEBrLJv89pgkFAHLeqapbwfR4q2eSTSdcGQGYgn2koG/ANe9vlX2fRn7vNrPkueISaN8Mmkgylg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB6619.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39830400003)(366004)(396003)(136003)(346002)(451199021)(2906002)(66446008)(478600001)(110136005)(54906003)(9686003)(7696005)(41300700001)(4326008)(316002)(5660300002)(8936002)(8676002)(52536014)(76116006)(64756008)(66476007)(66946007)(66556008)(55016003)(83380400001)(33656002)(122000001)(38100700002)(38070700005)(26005)(186003)(86362001)(6506007)(85182001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?VDUwMlBuK2IwQzkrTzNTNzdwdmNsZ1B6Y2JrZnR0a2F4VDgvQjFTVjlib2FvQUYy?=
 =?big5?B?Sk0wVnl4RXR6d2szU0dMeFN4Mis4QUk2a2N5eEdmNzUvSEt2SU02QzV1Mk1od00x?=
 =?big5?B?YnBkWmpBRENjSVhKamFxclBaVkJPL3Rxa0RkanFhdUtIUHZ5ckY1dVFVMzZXb1FQ?=
 =?big5?B?NXFjNHVHcXpZZkFJYjVIQkxSZklKRkRCV2xJU1g2N3hmc1RFcTNkbzN5T1ZWKzBY?=
 =?big5?B?ZVJXMlhhSW1MS2l5MXk3UkJ6RjZTeXFPd1JJV0YrOEtUeklyS0IvNm16cjU1VkNu?=
 =?big5?B?SlMvYk1yUHZYcERUTDhKN0tyVFZFdXlwYy8vK1FOeWZ0UHF0L2E0clo1cnplRiti?=
 =?big5?B?U1pCcFcxTG84RUhRZkRaUW4xKys1WlpFT2NLSUlsYjV4NVJyVG4xYnVIdnFZL2Jh?=
 =?big5?B?OHh6TnkzUGZwbXdNamNxTWR5c1VrbTlDNG5wM0xpVXRac0VxY1JWblZqRUIvZE9H?=
 =?big5?B?OUpYRUN2dFA2Nm9ZRmVncFVtK3RDVFBvTHBDUFl5RTZtelo3SEsvYmdMYTdJN045?=
 =?big5?B?d0dNbXU5dmE3dXNrK3lKMnp4KzhTMnlkN3VkV21jU3ZjaWRTN2xkS3laYTliKzlv?=
 =?big5?B?Q3ZIaEtyeVRxVWlsUHNPU0NmRWRIWHBweHJGRUFmSjQ3d1piNUlQS3J6eFNsT1ha?=
 =?big5?B?Y2pBTmswN1o0YURvTE10a2Vpa3VITHVIWTVKcmFGc1VtajVlbkFieVNGeTRvd25M?=
 =?big5?B?K1FJMnk1bkU1Ull0MW9kTzB4NWIxenVpSUtaaEZjSWg1dnB5R1QvL3lZWHdncFJo?=
 =?big5?B?MDVGQ3BKRzRmaFkvWG9UVTBuek94RzFBemVMaG1WZmRUR1VZVVEvMUZ3US9ITCt1?=
 =?big5?B?Zk5OYVRZU2pBZ1VXeFVPeklhUzRXbFEwSHBEczk2SGlLLzdCYkNUMTQ1MzBxRDFX?=
 =?big5?B?Umd2eG1WTzVxTGJ1ZjhEZlgxT0hnZWlrSFowTHQwaG1hY0FzNllReUJLUUdOQm5n?=
 =?big5?B?b3ZSckgrVFdBM3E0OW5uRWd0V0h0eEYwMmhzMlF2QUxEVEV6YnFqd1Z2T0RMMjJz?=
 =?big5?B?d2Y4QWRPalkwT3oyVG9FVUl1K1FUNm5SajI5LzF2SjM1RVVrb1haK1dMdWRCSkdR?=
 =?big5?B?TUJwUnE1aXpHOXF3Nll6R3dsU3JjVnhDdHN6eXAzbHpENysyaDhITFUzZmZIRFdy?=
 =?big5?B?NUk2N1U0RWlsQTQvemtVUDNabHc4TzVxNjRIQWNOUG9RVUJ0Mk9ncTh0ZEhIK2g0?=
 =?big5?B?V2Y2TFRkNDhIdXVTRFhuSGpOM1RtUEFxVWQ4bitCcWdnbVk4UG93YzNkb2VEL2xi?=
 =?big5?B?Vm5qR3UxVEgvMEVISFZ5R1FYYWM0TElVWkhsSDdvMUI1YkZvcklSMFpDYnNEekMr?=
 =?big5?B?UEoyTG51WHJyRlNzdFBWVUo2eWxNeEhmVVZiK01XRlNURFBSamFWT1BBM0dMek5u?=
 =?big5?B?YW5FL3FQeURwNmc4K3o3SE54V3VuWHV1YzBOdDBMeTBNNU9jSEtvY0RPRktrdjRN?=
 =?big5?B?TWUyUTcrWGxSL3FGUjhWY3IrR2VtK0RxMmtKcVVMazdnZzRiZDVLWnV0ZjFzUUtJ?=
 =?big5?B?ZkVtci82UE5DcnBtL3JOS1R4cnI0a292azVxSUdieHhQZHJ5YytublZMeGpFcUFX?=
 =?big5?B?ZUpGTzJzenlDeGMrKzdqSHRwZnlxTHZrSExiYy9ibEpkQmJWQ0F0QWMyWjlBMlpu?=
 =?big5?B?Rkl4SVRzQ0VpQWM3ZG9KdzlnU0JuNlRpVkFjenFTS0ZSb0R6K2M5emZLeCtvY0sr?=
 =?big5?B?Q1Buc1FteVgzWVhLRjFhT2tUOXlCb3JIOHAwVGRacDJXeXlXcysreEJtMWNPNmI1?=
 =?big5?B?R1pZM1R5a1N6cGdqYlllV3BFWk8yTHNFUnRnVVBwYUxzclVBWUk3MkEwSURWNFdP?=
 =?big5?B?T0NNNm05Y0ZXcllHRFZIdWpNdFA1azk4WmRCWUxtUFVQaHlhWkl2M2ZrSFlvVGEy?=
 =?big5?B?STd0ek9jK0RWeENJVCtpcXJyYmExeHR5VXA5LzRrcjhYSVM3SjlreDlkY2ZLekV5?=
 =?big5?Q?0LszC82s5SSLFEEU7ZaHmAdbRnNdPK/iC3qlBLoOwAI=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6619.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3538179-84e9-497e-6163-08db820154a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 11:24:02.9136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIzJJK0yz3Kc3xps+THM60bELomA6pMQ9kXmmuuk3x/FNXeyh0DFQjJqXOLX6Zae7gZDX5ZoCrY67w5iOpTjaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7484
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 36BBOEFZ042607
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

Any update on this patch?

Best,
Dylan

> Hi All,

> Thanks for reviewing this patch.

> > Hi All,

> > Reviewed-by: Petr Vorel <pvorel@suse.cz> LGTM.

> > > Hi!
> > > > > Okay, sounds reasonable. I agree with this.

> > > > BTW I also get ENOMEM on my laptop (currently 1G free space):
> > > > hugeshmctl02.c:119: TBROK: shmget #1: ENOMEM (12)

> > > > Should we handle it somehow?

> > > The line 119 looks suspicions, in latest git the hugeshmctl02.c does
> > > not even have 119 lines.
> > Well, it occurred with this patch (file has with it 147 lines). Previously the version from master worked, but now it also reports ENOMEM even on master:
> > hugeshmctl02.c:87: TBROK: shmget #1: ENOMEM (12) (therefore not this patch specific). Should we use .min_mem_avail? (not sure which value).

> This patch only adds a set of test variants, and does not modify the content of the test items. I think this error should have nothing to do with this patch, maybe another patch can be sent to solve the "ENOMEM" problem.

> > nit: The patch subject is "hugeshmctl02: Skipped EFAULT tests for libc variant".
> > "Skipped" => "Skip" (we use imperative mood).
> > IMHO more important is the fact, that test variant was added, that's what I'd mention in the subject. Of course, I'd keep in the commit message body that libc variant was skipped.

> Thanks for the correction. Do I have to submit a V2 patch to fix the title?

> > Kind regards,
> > Petr

CONFIDENTIALITY NOTICE:

This e-mail (and its attachments) may contain confidential and legally privileged information or information protected from disclosure. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information contained herein is strictly prohibited. In this case, please immediately notify the sender by return e-mail, delete the message (and any accompanying documents) and destroy all printed hard copies. Thank you for your cooperation.

Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
