Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C9EC54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 12:54:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A67613CAD20
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 14:54:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEE0F3CABD0
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 14:54:03 +0200 (CEST)
Received: from IND01-MAX-obe.outbound.protection.outlook.com
 (mail-maxind01on2120.outbound.protection.outlook.com [40.107.222.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F4056600833
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 14:54:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT61oVsTroUiC0BPB6xfEwITYJbXXsksNDVkPqo/Nni2PxvRcENbEg9N/rVjBH9te2HGTIYFhu/+yrdiA/Xfgt3TH1j/omWd9R2SZhVuOsLQEOzfcH/sMC1TF4cFapp6/WJgIU8OlPf2OGkdkvre1gZOawE/lISx5zS5EwRXlUPHyXC1/IUAciDplks0N8DKN2lfCMxPJoXmern6sM93qGDHDUwAFlhnTtEqdKZSNlQPIHcO7l5shVqu/bzyj+0AYbZItISB336s5iubjXJlH61JxDKd4dMvYqBgManq8ohY4gioYwphXLKnr2+9qXb8ofNnZl1bYM0YvjcGHELDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZq8skaGAkO7SfFn08cIwm2KqS7KtWNVxwANr+Jj0W0=;
 b=ZfYLbiugIvuwi4b6mzacw7TIbsSWblDHKSKqpgf0xo5Y+D+Fyk5MeZTuelP7+Fnj2b/JEsNk2hTMc1CkID3ojb4U+kmcE6YEPZ67gLP4Q83uN3nHv7K3f06vevTfJEqxy+/W4vylVxvrnOVe9aOXVOMtv4nhOs81u3beUALSWVUDJw6Q0iYbZaMTxtPK3RFsDDCEhXAHYKp4A8eNig3cgWdJ1A2QN50ec8FVt2jbipDTt1Biq61+/AM450EizDIShONtMillaEZ+U+TBkdoL/OGOA3/bL3AL2Z/f0Aj1o71e4e0Yu2Mw4+a2qo/WGT5TM3PikultDQ5+V6fRg1aZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZq8skaGAkO7SfFn08cIwm2KqS7KtWNVxwANr+Jj0W0=;
 b=08cMfQE980FDE6q1WGYdtmcJyOdIPoUulMWIGfD1N9XWfOSTBlYElTVFXyKe2InuCxZqZuTd5PQYY4wFXFnbAKx2wxCXo9lQAGWqXVGlSNAREFePXnVezUiNS4gvg0zy9lFnnWfhyH5asI3fgd+EsbItzHZfaGtkyNBQomBrgM8=
Received: from PNZPR01MB4448.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::8)
 by PN2PR01MB4300.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:14::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Tue, 20 Sep
 2022 12:53:59 +0000
Received: from PNZPR01MB4448.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cd33:1cbb:b205:bf70]) by PNZPR01MB4448.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cd33:1cbb:b205:bf70%2]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 12:53:59 +0000
From: Indumathi Raju <Indumathi.r@exaleapsemi.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Kernel configuration 
Thread-Index: AQHYzO7RM/ZDZuS0qkqTVIuzuvjG8g==
Date: Tue, 20 Sep 2022 12:53:58 +0000
Message-ID: <PNZPR01MB44487CAE043EF38F333E9589F04C9@PNZPR01MB4448.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exaleapsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PNZPR01MB4448:EE_|PN2PR01MB4300:EE_
x-ms-office365-filtering-correlation-id: 453a42de-aca4-4702-6b45-08da9b072f7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54auqFSidlv4TnlH9EeP4VOQsTn5bgdW2jp8Q/+DOtPvdDPX5G256lQe2dmn6bzqP9yN/60cpXIBxeD+KQCMqkG485RcD2YG0udSZ7xDYoHkRLRR6SWEUKWDT3KoO7uJsJ6yzghPu+Zmb71F9L1Ch0YlvBwgHj+umpGxZCcmT4YCab2ywYFfA1G4hILuM33HNgAOs/3mV98jJ8BKiCmyE3q6XokxQkUAB7OAd2vYMV7XR10OLUpYuE/oPBTjsaEtS7Qs/x90oCRgtbHokIblRLOL1E4b5bHi2NZUfv0aKWs3J6Z/lIUhhHnXmEgInBGpdIijO4edcWfPHW6K6GPZtqXBzdit41U1P877QBIWZSwqHdyT72NXX7z4fp+QCOd0RyS9iacujWYCus0h+IWGovvLjQAbC8U8aUzB4UEDuW4k4EftQOmGTcZM9Mt5zarsXsTnSIWRCnTb/PPw6CLaXJvRcvZGE3/+I4poTOmm/pFFHBrY/yz3Sf017Gx0c/IpF/DPEKinEzqwJLk5evZi3CjZpDauVDa8ElHYJIb6d94tJy23YAHV9KD+TcaOr41PmaJen5VKSsN2pPfrNVZmyFHCFYiSq++DQmVbghwNBTDo/VlST6zhw208ACaLvjNBP45ibuNuABB8uTWo8v/dkVKT6bh3BPmVp1AOSFqb4Jx5mVavGA09XiwdPWmg/3kQuUHL+nZFlpBhw7QWWu6nLuxH6971wQC2E+mhNSAr0zciYJScwdX/qdfaXE8qsQ+9id1Nz0Vtbeygo7oqA7sR9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PNZPR01MB4448.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(39830400003)(346002)(366004)(396003)(376002)(136003)(451199015)(19627405001)(55016003)(2906002)(33656002)(3480700007)(122000001)(316002)(8676002)(38100700002)(558084003)(66476007)(7116003)(66446008)(76116006)(5660300002)(66556008)(64756008)(66946007)(6916009)(8936002)(86362001)(186003)(478600001)(38070700005)(9686003)(4743002)(26005)(41300700001)(6506007)(52536014)(71200400001)(55236004)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KVPL9pLj7RVPEqfIqkTKjl4vdeu8SNZ0bDZjmWTv5SZpn55YwO4WsA/ZC9?=
 =?iso-8859-1?Q?VtciZIeBTwVPv3KIIwB0NbV88TkhAEyuecyGFGF8huSjK0ImlNegCcf8vA?=
 =?iso-8859-1?Q?1dF/FIx0GSUtkDw07E0Z2/5nSl60tzR3I50oNG6aEXMTa3D57GBx0EGDtD?=
 =?iso-8859-1?Q?0VD+Ewcu12CfV0ZO31uZCxEA0WNUoX5Ko24YZamIV8o/Yt2grrO5N1eOog?=
 =?iso-8859-1?Q?u6kA9sK3wUgM1csZCt2RvLJDLoBWgrzaVfnjNvZmMBYxKVFFUXIryaV/Us?=
 =?iso-8859-1?Q?ggMlSPmoQ/4FdA9aGjCKR+ITEqO7JVOTF+KCPLxn1z1BWdltGT+9vRJFHW?=
 =?iso-8859-1?Q?4BZMci7ysp4cvFGlNhqOvZ1EjU3UxOj1Qy5snmTczLFjSEaybXm2qz4au3?=
 =?iso-8859-1?Q?+0fA4xUf7uu4OTCOlBRnLddgpHpn/7SNEohnj2FrB0FsUzWF9JPYeho0Fr?=
 =?iso-8859-1?Q?hGClUn2GjndC6hnHstIypAu5g2RXDdz9vCqEbxtOYfzs4pGPCMED6tpLwG?=
 =?iso-8859-1?Q?xQFIXP3Y1ZNE9d65Ub45oi7CtK8YZ+166xFgYqWqsEPpe7rQNUp/TMufWP?=
 =?iso-8859-1?Q?NojlfEhLiVFRfQpVjj6OokzEX9zHReQX+S6s7NCXiTr/uFCENtnxk0K8ob?=
 =?iso-8859-1?Q?+bXjh9pRcw+FmJRMk8Oy1tGRCgDcun+4SUs76GJTwHJzka85ExkuGm6I3x?=
 =?iso-8859-1?Q?nq3O1T1TJMEzmypBVLoWd+JBiH8L0aqaPsjDUejJZb52zdaWJtGPBGU9hn?=
 =?iso-8859-1?Q?MvXKi3p9yiZKmHLCWfkN+Wc+Lmakk+9EQIXz3ketptNLQ9TEvmKMJ0cdal?=
 =?iso-8859-1?Q?pVNVjcqEvNFIjOCy56IRleeEwvKcPHgV8rrVlidbQcvoWDtHsiJu4WRy8j?=
 =?iso-8859-1?Q?t59aSoLQS32NcRwh9+eeP0meJtp72b4LDv4bUv0WGjlWXyaOugpKYQOQaB?=
 =?iso-8859-1?Q?JLVUeey6GEl7fSKle9O93U8AZz2CD0gHgNvmQdtfIZ4xLKaDHm17qUlwE9?=
 =?iso-8859-1?Q?syJSjZIC3UgZQD4bcZ2VS7SBGL9ER/7YJzzCeGvaHu3BTe+hNMjswKbk+e?=
 =?iso-8859-1?Q?wA4X+h9mE0W2g9rT+V2skW9P5mBiRutGSNJEZJVDeQblVI5IdV66a5Ra/q?=
 =?iso-8859-1?Q?CbHJ8EDIv4kmfpvirG8qhcwKzMMe6CiSlV44kaMHYwyAyd+AAFOdIK5t9r?=
 =?iso-8859-1?Q?GWVcOBlNXkeUzPNiV5aKRNxGRGQGtTQm3rbFIwvX83K88lPq6GLvQnxGTh?=
 =?iso-8859-1?Q?u/JrqlpREHdjmYEzM8ZmCLLTkn9ZwNKeVeBYwc5xy7606wzPa2x55P1oNQ?=
 =?iso-8859-1?Q?cYJJxgReNBPNX4fKVLGKduLrfDjSfGRFuQQZAO6uWvYjGuMvMrYYYYt0ZG?=
 =?iso-8859-1?Q?hjU+mvjAtEhquR11KuO6yXWIhWJvashecw/1Sa9fKd/sRv+yK6GPr7z0O5?=
 =?iso-8859-1?Q?/I8qYq5p1PFKXuP5pAyfetdHzplWDChMTeB0aTiiQpeAg950cZ2GaM0pMs?=
 =?iso-8859-1?Q?IPohDjSWELPI8sVJZOeis1F5dKX/1dJE22dRqCvrpRN9KGueThQo9lyvvd?=
 =?iso-8859-1?Q?p0ODKOTTCXmAbQp1DwJi1o164dtiMai2zSrmDddCYZA7VjOi4cbuJZkMy3?=
 =?iso-8859-1?Q?ZXtPQLLzPN/2LdJOE4GQgfrgbDSpLirlnRmYIRQjqDcEroQEGBOIGflg?=
 =?iso-8859-1?Q?=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4448.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 453a42de-aca4-4702-6b45-08da9b072f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 12:53:58.9833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxBt0ZNYUlrx4/iDcK//vylb/uw8cTT+5tWcy3IRDVOdysx6xXRaMB14ZUzS1MOiIhRvbG65b/DryoXvBMqeYBt9rn9YO8qIzuimdjKjTzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4300
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Kernel configuration
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
Content-Type: multipart/mixed; boundary="===============0563289071=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0563289071==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_PNZPR01MB44487CAE043EF38F333E9589F04C9PNZPR01MB4448INDP_"

--_000_PNZPR01MB44487CAE043EF38F333E9589F04C9PNZPR01MB4448INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

We built own Riscv64 distro with selective configuration for soc board, on =
that I want to execute LTP for that I want to know Which are the required k=
ernel configurations to execute LTP tests?
Could you please help with the list of kernel configs?

Regards
Indumathi R

--_000_PNZPR01MB44487CAE043EF38F333E9589F04C9PNZPR01MB4448INDP_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"color: black; font-size: 12pt;" class=3D"elementToProof">Hi,=
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"color: black; font-size: 12pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"color: black; font-size: 12pt;"><span style=3D"color: black;=
 font-size: 12pt;">We built own Riscv64 distro with selective configuration
<span style=3D"color: black; font-size: 12pt;">for soc board</span>, on tha=
t</span> I want to execute LTP for that I want to know Which are the requir=
ed kernel configurations to execute LTP tests?</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"color: black; font-size: 12pt;">Could you please help with t=
he list of kernel configs?</span><br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Indumathi R<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PNZPR01MB44487CAE043EF38F333E9589F04C9PNZPR01MB4448INDP_--

--===============0563289071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0563289071==--
