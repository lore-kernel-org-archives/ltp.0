Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3866FC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 07:13:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637E760F26
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 07:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 637E760F26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DFD93C89BC
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 09:13:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7922F3C1D5D
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 09:13:36 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 52BDD1A0116F
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 09:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1631603614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/UaNYVz9Xyhez6UQg4zV8HR5MsnNdlubJt5TnFj+IFI=;
 b=O4OieDPl+pE1DwCui3iB3XdX5UW+kSVFLN9hHWOrekhUW3ALliw1fKpgArOLI4c6gM6mPk
 NKpJLcGxkICpKzjsOdFHBciaqEHwZwppMfzz/wocsJTJ+E9X9NrKoRDJzBuGetnoOJPiHy
 fhtvP4gb3TWnjjX89gTtCXv9ThWA2u4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-38-9CM0Maa0NDmoqZfBrdZwkw-1; Tue, 14 Sep 2021 09:13:33 +0200
X-MC-Unique: 9CM0Maa0NDmoqZfBrdZwkw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMHlNkV4cW8zcWG7W9wHsZf+c/CGJeDs5zxFyzrt0Q4bmvN/pJCeorqs5PXS8Af2JyILXFSKdw9qir6O45DKragLZ2HLVGXUfS0sWKaVRPQ//zznq3Ev5FNtnjTK8Vbx1nhbVbmKEr/2SHyJzDrlxkUiJfsJ09BP87dcoP8Z9Kt3DMQLNeiOAlg68mC5eQSYYm/dsLpmY6TF2UKoxswhVjwaKP5se1XdI5inFHI/0CzFZjqMui40UfcZSiFK68RtddtZ5Y52kwsrrgei/s8SbyrRz58Yg53JVFDaymeRjDqeWiWG35v/BtIH65aNiBv9wxDiM9Ukb1l06vxYNxvnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/UaNYVz9Xyhez6UQg4zV8HR5MsnNdlubJt5TnFj+IFI=;
 b=LidIE0kAwZe3pgdmJPIzjevbjSN0MSRY3OeLFajJJL9KIeHfyY6N8R6COuAeBVQbk5J0zJEe6GUh3NV0yYBVfjk6GDOsD7Y/2gfhDpvaWB2wx8Iv4sS8pvl9eDsDQbAUrpOwpXKl5/0gfYzWG/jb7sDc0wevmE0DaprO2QkFGSTLr3/nmnSKZny4S/DQUAw7l9v05FxROHfITpqewm9xw2MXvI+ASDUka9yLJ3dcPKUM0wHdcrMaHsOqFV6juYHjAS+j3YzpOqF33ur12nv6wgNyekurtTxByn/ogG3OE2Tnlj2VZGc1AGdFgsoyKrYaHK95nBUq2a2OrbZlkgpUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com (2603:10a6:803:60::23)
 by VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 07:13:32 +0000
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::39ca:419d:d4bb:ebf9]) by VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::39ca:419d:d4bb:ebf9%5]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 07:13:32 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 3/3] realtime:profiles: support hrtimer-prio
Thread-Index: AQHXqL2z9d45hcVTU0S+oDV4fcyvZaujBKEAgAAZ0U8=
Date: Tue, 14 Sep 2021 07:13:32 +0000
Message-ID: <VI1PR04MB4958098078E773F7C2B6531D93DA9@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
 <20210913163745.28108-3-bogdan.lezhepekov@suse.com> <YUA12gjIh0JVKh1L@pevik>
In-Reply-To: <YUA12gjIh0JVKh1L@pevik>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6afbc860-e128-c7ea-9788-51c98fe8d128
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 703e8ba2-7b45-49c8-77da-08d9774f28ef
x-ms-traffictypediagnostic: VI1PR04MB4960:
x-microsoft-antispam-prvs: <VI1PR04MB496092851A0879FB6173944693DA9@VI1PR04MB4960.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/qtDYbOaKfPff5X7mDkHgxtv54CuarbBzJzzLgIozxXzkRBloyuNRM5IBA66G2Gk1hsp+DteN9HK/OJ/E2hWJkBN7gor3OIT7Cm3r6RFZAzapVCmBGR/Qkqor5b7WXmIqVbYIdEPUd8dmZLKyhhfeWvIkEqy72jP+TiD4TmWGeLTV6SIj/8ukA/bi3JJwK6p5Z3GSxpNGs0uveEfRieDuDUtnTgznquNIDZmBbfT69uZIllXEuu0DvBAc/rpCLS68spSZqv2xd34zJwDc1TiEEvsVZgfMwld4apk8HMtVagmDF+dCZfsRTcCR0sFxbfexwhnUcL8kS+Azil2laaDdEry79Yf/Rt/loRRU5QtdRK2sQM4rIOZ5KJGpc/EbGV3qstec8XknP5dLxnBwhOz4QucFLdSYOuxzUxqD/coitHE0I4EU2eaTsLwuELTjRuEwC5B8YVld/OXO1z5wa74LhYYA/PuRYA4luO6yIcCFROOMCy74jjAqESUrC7/KtzDF+4NAV4auXvg1VlZmm3WHniCqneyjDWDo28ZK4o2hpUUAtIGIZfim+Boe29UcrTXQEkuAabU55VPiuOxQ6NQ+mSwFG4xMV6NVcQ6U1JYV5bPEIYklJLCPPAHJ8LL2P319lh1yJWSgnb+v1y99W0sILUk4+QXyChOeg2xa9U6bmSDjYuNA7eez8nfjV/bA2HWXNhcbm0xD5i/RX2vYrnng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4958.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(53546011)(52536014)(7696005)(4326008)(86362001)(8676002)(186003)(66446008)(478600001)(9686003)(55016002)(19627405001)(33656002)(44832011)(71200400001)(6916009)(122000001)(91956017)(66946007)(316002)(5660300002)(4744005)(8936002)(64756008)(76116006)(66476007)(6506007)(66556008)(2906002)(26005)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rjom7BpCPDlQ1kM7S6RwgAu1XiRHN5D/XF22h1yL1C0v5+UkGs9+csREu+UK?=
 =?us-ascii?Q?GKOM7HKzxWAEJm98pNP3HL1LmLdOJXsunddi073cJDD09rVDOs4HxadznjKD?=
 =?us-ascii?Q?o7F4LYHVHsGfCLTr9c03xaHEf9BVUU3w78nLzp6Kn7v1Kv0XNEq3MTbSghWO?=
 =?us-ascii?Q?6koU6KOm6zxx5yqDTuWYmu5bZ6aREZzBpvdXvDlvkJQwMkwzLS1ihE8X0Vo9?=
 =?us-ascii?Q?FCZWlRlId5gcYxQalGkvNnmjmJYeZFpNR8fVW1BXP7GLqOcHC39w+Be/tdRa?=
 =?us-ascii?Q?S+nItNhTNpNLF+JeNXqkeUbUOvPQKdhq9lFTnzd+UVuJsXaZugKrnha1pRr0?=
 =?us-ascii?Q?bQZ23YP1DaozJ+9gOjo0PeU+z+ZUtl7mrR9ZoT8aHVHaJhLKkzgUwKsPCsMX?=
 =?us-ascii?Q?XRwa9rVBVS2aZzsn2rMjBFvM2bgBU4ExAEHD86C699IX6IEXUx0pIxpepxKe?=
 =?us-ascii?Q?7qYi1G6oDBBlTY9zPY5dAVhgojkdgK+szVMq74fwRW7CR9yLXQS8vrClkHNY?=
 =?us-ascii?Q?ee+yrY0Cdz3uGbcaAz6hzkKlOVhwm0jA7fEG+STeRBBJn3K3VfJNWICt1+4X?=
 =?us-ascii?Q?oXFsvchkLEjHZx15Uiknz0QZ5hVOmF42swwXblXUqjTVUCqlF/mWGc5W2z6W?=
 =?us-ascii?Q?0wly+kkqL7zplqKfq88lu/xQJiIBUjLdda4vend0GWvoqnR5xkTiU5jZBvzE?=
 =?us-ascii?Q?K7tklkZudaCadmQH6RDlyxvvXh7+JLEBZHRZ81mTIRvRQb6Qz6vXzXjt7lTn?=
 =?us-ascii?Q?9OK6i153JKijzEIVDhRcoXbE+Ww8m1bG9H6TnVRk20mxTRJbwcXVBakffNGC?=
 =?us-ascii?Q?LBz+vg4cIk9aqEjm6MJsEPth5rZ7CC7gebRuoN/CVLO+lFc/AMXuZoEV+Kwu?=
 =?us-ascii?Q?Gy6AVc25t860BRZ4veOkM848Y/GH6OqpGyg5IAoQ49s89DVa+xQ56qrZtR2G?=
 =?us-ascii?Q?nKgEUHk0Xan3cs8x324bFAu0vbnz+bTmTCWX17p0po4kv2nbOkpFr+S/PoBP?=
 =?us-ascii?Q?l/LrFYSkZlFaHHFGrvx7rEbQdWgka077bLn5/72PVttLwdhCoRBswL5FnJmo?=
 =?us-ascii?Q?XPGAaiOxoWL/zrV93xqnIECmJgQYvmyvX+lI7B/6/IB1qVUtvkljfKN8qk0q?=
 =?us-ascii?Q?0YGuhx6z6PT3/3kIzDHeNo2X25kobCqI2rB88kxeg3/wAfWVQ6D82sa/FoVN?=
 =?us-ascii?Q?UQZu0TrszC51W1BCSk3b+Hg4H/spdFL2BJWMWmjATNnoxEEqGlANG8IUjROc?=
 =?us-ascii?Q?b+ukl1ix9UP0NihzFTQGoRdqU+g2LzqbaacyuRJPyXAmIUlVYKTHEyjNv6ti?=
 =?us-ascii?Q?fNw=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703e8ba2-7b45-49c8-77da-08d9774f28ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 07:13:32.1640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECx557rSBSEEXyw21Xi9wwy/0I+HBmdqLmrWl5nPApW0ohC7o1Foz2KI04wKGc1cw8hblQy5HAGPvYG1lKueikRkYsJfZygn+IZjj9yHIcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4960
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 3/3] realtime:profiles: support hrtimer-prio
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
From: Bogdan Lezhepekov via ltp <ltp@lists.linux.it>
Reply-To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============2016453964=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210914071332.DRKR7cc4SMajuVO0_K5r5PuhciTrivNs9ImN50Ht38A@z>

--===============2016453964==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR04MB4958098078E773F7C2B6531D93DA9VI1PR04MB4958eurp_"

--_000_VI1PR04MB4958098078E773F7C2B6531D93DA9VI1PR04MB4958eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

Thank you for reviewing!

-Bogdan
________________________________
From: Petr Vorel <pvorel@suse.cz>
Sent: Tuesday, September 14, 2021 8:40
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v1 3/3] realtime:profiles: support hrtimer-prio

Hi Bogdan,

I moved whitespace change into separated commit and both merged.
Thanks!

Kind regards,
Petr


--_000_VI1PR04MB4958098078E773F7C2B6531D93DA9VI1PR04MB4958eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Petr,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you for reviewing!&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
-Bogdan</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Petr Vorel &lt;pvorel=
@suse.cz&gt;<br>
<b>Sent:</b> Tuesday, September 14, 2021 8:40<br>
<b>To:</b> Bogdan Lezhepekov &lt;bogdan.lezhepekov@suse.com&gt;<br>
<b>Cc:</b> ltp@lists.linux.it &lt;ltp@lists.linux.it&gt;<br>
<b>Subject:</b> Re: [LTP] [PATCH v1 3/3] realtime:profiles: support hrtimer=
-prio</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Bogdan,<br>
<br>
I moved whitespace change into separated commit and both merged.<br>
Thanks!<br>
<br>
Kind regards,<br>
Petr<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR04MB4958098078E773F7C2B6531D93DA9VI1PR04MB4958eurp_--


--===============2016453964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2016453964==--

