Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84024C54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 05:24:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 994DF3CAD10
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 07:24:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D69BC3CACC9
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 07:24:00 +0200 (CEST)
Received: from IND01-BMX-obe.outbound.protection.outlook.com
 (mail-bmxind01on2128.outbound.protection.outlook.com [40.107.239.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D352B200759
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 07:23:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm9X4iVEQllWhCbjV3DSV7N864H538SKfSvkpHX8aqBnYq7g0t7eU+Oza75BvXIwUZMQvi+L61p/9ZxtIpkQHQKB2/gbc0goc10vqvdrs2V4gfHjIPMtTjT/yPsBcL11mk5cNzo41Vav8ZRL6WSeJsRkZD2ogeIdCxWFMhHUCubJIqU4UBjE6qne/Hi+DkiWeALU5C2Nl5TmLOmBaPLXZmrM+xhsKjfLRWFo3KqAE/sLC4cnYS2osFi/WuSwUGw1RzYPTnD/meNbjvmOHo2vinYxcQg7PsatGGcmGSQ72yMySrjPAL++dXmza5K4p/Zu5cQ9myTcuUP26vAsegQg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=819qPzEiv4YpU6/CptMop4VlYAXR9dHbs/MgJ+hQriM=;
 b=oPj0TR3zEwOxhPoPVerlLFGgCdGakjQ9jxKcVYgtdlU8SzDMaBRMgHC9Side0VzM0LvAi7q0fGsg0pPuu/pAfZedSSb0Iuz7KlR2zndDFgE/qFREcqajehabEleJVYNPHjOqbVxT7noxzq+YPSKQrk46w6qpRO3WtyqhmfMv5K+GsgSLSm1fJ00APOLEMJ2TGcu78dc5QklrVcKqLLUJReXWY95gqhcsDszqOQxE+NnsDbHBxdA10da2u9Pm7S/fj2BorOkbEA/MBodiQsF2RVEYpdU0Q2yisTs+PUdY4VRgnCxSEhvhqeIhUnbevy7NfgBMn6hYYnoa0ibC0OSIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=819qPzEiv4YpU6/CptMop4VlYAXR9dHbs/MgJ+hQriM=;
 b=m/E/TseHlmuUKCHbio3fBuB577XOV3wO8hpwrMWuVf/1QUMSqe5QGHVX7HfOf3XWUagWxuwF9BOuv4Jxm6XuWxmaDMAazf7aUk7v9+otFDdpoiuCUSnS4WJiDvdDPljSTBNBJUo2kazTGPq6GU12K8qqvPR0l8+vgDyuUiretGU=
Received: from PNZPR01MB8108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3b::6)
 by MAZPR01MB5441.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Tue, 20 Sep
 2022 05:23:57 +0000
Received: from PNZPR01MB8108.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f064:8fc3:a20d:6f2f]) by PNZPR01MB8108.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f064:8fc3:a20d:6f2f%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 05:23:57 +0000
From: "Ankita Anil  Kulkarni" <Ankita.AN@exaleapsemi.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Kernel Configurations 
Thread-Index: AQHYzLCyAtxY/QG5JEygrGMAwtzyNg==
Date: Tue, 20 Sep 2022 05:23:57 +0000
Message-ID: <PNZPR01MB810830AC76882E62E6D756A2FA4C9@PNZPR01MB8108.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exaleapsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PNZPR01MB8108:EE_|MAZPR01MB5441:EE_
x-ms-office365-filtering-correlation-id: 4a9eca22-bce3-4489-8d94-08da9ac85138
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvZPeq39TOFRZnwtVxr8Ik4qAs3zDojQKLjAPtdM3JuKcCNdezy1nzRdyRSYptOkBAyGGYTtX1LKiA+jpbpGLgo+ti8xV4lZAioWaVOFSP6adEnV68e+6HKkw2WqrAAR7qz98tYXeAbdQhcsXv/Bh1n+4DedmEnVTTsT/pMPuf5q+wVk0hxpcAdHHc0KA6tRbIqnSl6YoLAIGaxbLvkadiXfqm3hqUewvFI+zlZL+gSrDVRZPr1N876WVSM2WkkWlOcfmtc9ypy5/XpWyPylUE6Gsx6sebJN/4NmlMZlZebK2ZRRAwg1HunI+0KpAkokZk2OQFylkpPV3tpWpFSVdHZMseO1P+GaBJ2WJHCFcq9MZPG/NPBFIPIDn6x/+JZ/W0hWgkoCpLZ+Lmykquxb+ZlrQxcO5hH1WxW1AKdte0OTFOrIy3vfud/9Df2Rv21ggjTs9yIBMq+7L9k0qS3wquh6f4b+3498Er63+5NW/YWiE5iMX4Zzjy5JsAXKk13u1mXMBN7stDtcY9tNC9ous1hZnyu3p8sdV+r+GFp9IAElagpRtiD9KfmkkpIUPpoKc1bO6uuqHJliYNB4jRBkhzg858CdlsRz7Z+42ISwtnBTXeB9zX1q7nChfHP5ABTqbsAINsRv3TvL2nqPBiXpPnBmNh1ZZPblcAjfNOjiDClAwSis+LGBewFoYdDYnlfdxBT0fWtaUXXB+5/P+xdm6VD96DRWD17+yxmmUSNJbv7PQ2SwHo4aIRnd/UfzLJXkbrZWyaj5+cyjZPQhibhDEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PNZPR01MB8108.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(366004)(396003)(346002)(376002)(39830400003)(451199015)(5660300002)(7116003)(66946007)(64756008)(66476007)(66556008)(4326008)(66446008)(76116006)(8936002)(86362001)(6916009)(3480700007)(316002)(122000001)(38100700002)(8676002)(558084003)(52536014)(33656002)(107886003)(71200400001)(55236004)(7696005)(41300700001)(6506007)(478600001)(186003)(4743002)(9686003)(26005)(38070700005)(55016003)(19627405001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lysxYj7JuZ7OC4NTfmmCYgXtyTbCMnKo5VCVHLyBvzxCFZ+vpzC1W7T5Es?=
 =?iso-8859-1?Q?sTTf/xO5VWeKGKhH4ngSOxUymjw3v5zsr8Vl4Bo7ICk3YxAcPNM3NFluzA?=
 =?iso-8859-1?Q?yf8WXpWphmXCS0+LhYLl9mGj5GTFNtCj0It0pva8IldydT+ZNOT/9nYt58?=
 =?iso-8859-1?Q?fM6LkYInVM2f28Zc97PBoRx89stJoD+YjlPzpNXQKmjdXY4sneSicNVM/s?=
 =?iso-8859-1?Q?O34x7KwJrj7WtSeqm7ztxRu7dIUd5o6Hl5bxIZbBrX3xTNiFv2zfVjEcCJ?=
 =?iso-8859-1?Q?SDEb3X4npJZEB3ua1hWN5OqJqMquIESWzo2dDfAznlJ2cenvJbMfQ9W96z?=
 =?iso-8859-1?Q?tzj37PD+fYYUKbD9nYY5Cj6OuBH/Z1soB8dCVrNZ9OCgAhLOOLWK59oCoV?=
 =?iso-8859-1?Q?dy2vQibmSSe5z/aGJvgz5xTDoz5bWmhA79gU4pnJzOL8rc67U0ezsc3tX6?=
 =?iso-8859-1?Q?zKS7XQShZW2Mg0D3h4M0+z1QmMBYSSbeNew7fz+vcyQGdiK4ZEyuMOHhCq?=
 =?iso-8859-1?Q?4FjSLjWKX1IIYh/DwxkGYf2wx3GteDCeiM9O2LW19cHL3gij/szO8aKl2K?=
 =?iso-8859-1?Q?KnqShavF/eRHu4ad+l9LeqSwdAF8dOFFhCmjGJeJHcWwg9tsWPEEIYgJbz?=
 =?iso-8859-1?Q?w+Jsjjsus5OTEW2o47gwANDUv2/u5v5MzYzA95vUUAaAs12HXuZgf0mOsb?=
 =?iso-8859-1?Q?CCeLItPGf2nxYKO1EVzaAp9DfcDe1SFgyj2Xd6vymR4sYih0aJFwxZqrfR?=
 =?iso-8859-1?Q?lcrXvZZUb4EYxtNDWtMHc2FfhNeVRicYHka6llrNhc1VCTuvaSUDVJLjmK?=
 =?iso-8859-1?Q?tHTDkc2JUefJWIM83JsHKY0sSySlorSATE83bHnUMqSXj2sdnJum77ecUQ?=
 =?iso-8859-1?Q?maAKtmJCT52vt9TbqtW/ze6eJYmmYrlRcFm2nQq6fRFvUpiyoTs12uiA02?=
 =?iso-8859-1?Q?y3oYXWwRweUN32kV06am9HXJQpeleNnwzmpYu9fbEJaky9MqR3hZt4oAWH?=
 =?iso-8859-1?Q?RaxKXTnKpqaSmR6hTWPBCfU029LJQnAVRnYncavNu2qkrPeSwrvaLjIUHv?=
 =?iso-8859-1?Q?UJvZdBTNY1IWVz3dWwZaG7sJh0ETFac+TeOHqrO45g+u4lNSPVuiFSXIiD?=
 =?iso-8859-1?Q?3pCT1hB60LXAdxBLRMZRkIU3675urELluL/VgUXkVFPBAEoMI9eu+ZznJC?=
 =?iso-8859-1?Q?vy+C8z9L4F9GROYudcDam0AUUUP++AOWj3k67xiGKymLolceUm8JfxbL8+?=
 =?iso-8859-1?Q?fOgPCFgbx6PonrBqGlNRlygD3es8Ce+SzEG71VSqOZAiUBvYK5rwf4pACw?=
 =?iso-8859-1?Q?WpIiLlrI7UW7RSVm1V2gpM/mH97/D/3AHsu7M9mm9SXKygmoXLJnJu3BpF?=
 =?iso-8859-1?Q?QWI2cP7GMUCiKPblkNxHjxzHAE0Oa16GdCYjNFwOMvCMn1gVAh9B4oXMAE?=
 =?iso-8859-1?Q?wMAlujBa5G+zG5EztYdAp/kt8BnVp+ZDpc4zduTyDXVx9fZPN9yo+rCpuY?=
 =?iso-8859-1?Q?3lVWS6bw9OTLhcMdL5x3PxRV4vcmwsw9rZ5R1Nb5ZVNuQimT+RoCIuNcsO?=
 =?iso-8859-1?Q?c3FPnDAZc8gf2G+SdyaD552/KG2+2gBD4maX0ILFzPokO+JtH6Fqy3lEtu?=
 =?iso-8859-1?Q?ytmR43q4aw8qqGhZ+QSGZtnLWuIaMbs8qw?=
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB8108.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9eca22-bce3-4489-8d94-08da9ac85138
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 05:23:57.2987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBejRhaqiNszgPMRFY5v38MWg2MIMBtAiamfQNYbRCtL7ZwxzpcJpAxYDbMkuik5/0j0qfViQiYJ1YnojqlZzkc5kDrUxykqN6fXH43EB0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5441
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Kernel Configurations
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
Cc: Indumathi Raju <Indumathi.r@exaleapsemi.com>
Content-Type: multipart/mixed; boundary="===============1622438656=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1622438656==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_PNZPR01MB810830AC76882E62E6D756A2FA4C9PNZPR01MB8108INDP_"

--_000_PNZPR01MB810830AC76882E62E6D756A2FA4C9PNZPR01MB8108INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
Which are the required kernel configurations to execute LTP tests? Probably=
 we are missing some in our distro.
Could you please help with the list of kernel configs?


Regards,
Ankita

--_000_PNZPR01MB810830AC76882E62E6D756A2FA4C9PNZPR01MB8108INDP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Which are the required kernel configurations to execute LTP tests? Probably=
 we are missing some in our distro.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Could you please help with the list of kernel configs?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Ankita</div>
</body>
</html>

--_000_PNZPR01MB810830AC76882E62E6D756A2FA4C9PNZPR01MB8108INDP_--

--===============1622438656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1622438656==--
