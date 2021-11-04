Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A4C433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 15:46:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E2261213
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 15:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0E2261213
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DC263C7339
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 16:46:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A071D3C097D
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 16:46:22 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9FF9B1400510
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 16:46:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1636040780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oU4CxnGjAM5cgSXlNYwvVQk6YEl5PA+/1Z281S+q4qI=;
 b=kPX0IoosiMzcPc+RLn+qw/gHLRrVHyFT2dAFI43zUicTkqWWkrknVu8oKiO6hGIQAnuKYa
 IDFd++KyNJsbAM9qGIti96TW/db3BC0wSPpGJwjp9DtoCl5ksUIDwugE5agMz5msOgiWEv
 5y3Vg8B4CPMEcwfeggBXY1BtD3bPk1Y=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-Fk3B_91HNDynEmo9mFhBsQ-1; Thu, 04 Nov 2021 16:46:20 +0100
X-MC-Unique: Fk3B_91HNDynEmo9mFhBsQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXz/eaMvhlSFxED0xBJqo/vwBFhL2dzGdIXjVn1UXSnV8H7Ikn4vStfLnyrqdbcYWxVBZtcw/n9HYo07FvgTryV8TTjNFlqt6/OtFSBh1X11DHVKGcCvL3UDY49wz5R6SYuNAPrVNKgzBwR/TzcLrt2OGess5y66lV3SX8ug8UlW0toByT2w5PSkbnyIuwG5obf8enJsVsxsffvs1eHas/E9+iGLedNP9MuNlHcn/YdDXrFjyIh6yCkjJSlZQBRBeMdlMHj5sXq0VOfRFNDs9fehKNM8j0NTtljPgonjWICLlxO6NFqaEtIlab3L1UiAxq5HIMH18FOwF3xXkeG9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU4CxnGjAM5cgSXlNYwvVQk6YEl5PA+/1Z281S+q4qI=;
 b=LHmxX9HbvPMGVdHc5wIYgu43XeGimsgV/wK9xgCeBbjooREDoPj+Ez1Agreq80zDEqoF+HFH+7n8fUAr3uBCNbGKAt3IoUzlqNXCVmt/Jnvx4MeEGMgdobr6tAN34XBp30MgJ6U4tWUN4TA0PLOJDTCbPR/0OQvtu5dRMHH53/DMBm3whGIx9MjQcYRDF8i7Z1ihWHtIZP4eyo0cPdCztytrObvIb+CB4anU8n3JbJuW/fK6Qk5d8WXottADBEq/WF3mKfXMsEBwACY9ppUx3ji8+ITVt234RBUT1TUQOC+ri9JPW06iAwXClzhP/9eBzH8KjjJQKbD++7bI33cnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com (2603:10a6:803:60::23)
 by VI1PR0402MB3888.eurprd04.prod.outlook.com (2603:10a6:803:21::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 15:46:19 +0000
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::309f:d595:856e:a1be]) by VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::309f:d595:856e:a1be%2]) with mapi id 15.20.4649.021; Thu, 4 Nov 2021
 15:46:19 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1] netns_netlink: Ensure tuntap is enabled in
 kernel
Thread-Index: AQHX0Jn0tsVvpInFkEuJFomDdzqm26vzajiAgAAarrs=
Date: Thu, 4 Nov 2021 15:46:18 +0000
Message-ID: <VI1PR04MB49584132B93ADCAA3142949A938D9@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20211103100235.22007-1-bogdan.lezhepekov@suse.com>
 <YYPp0c8kFRaKMfty@yuki>
In-Reply-To: <YYPp0c8kFRaKMfty@yuki>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 90ab80bf-5159-9c6f-2716-a6292f02aca8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed6850e2-5d3e-496a-0b10-08d99faa3e77
x-ms-traffictypediagnostic: VI1PR0402MB3888:
x-microsoft-antispam-prvs: <VI1PR0402MB3888B2FFAC56DE281C7DD944938D9@VI1PR0402MB3888.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fqwTdSRwcb6o749D7dThT5YvtrkSTDO5RhgJd22A0ucElq8vxN2GhfuzHQdV6vIMnhUMng0gbF8MkIc7VlzJLu0PseRuj/BWRBL3L5esi2DzIjL+kdwfzniOtaIgvGhQ0K3Fbr474AmcyIKQDMs8HWUroFmSW8MN7GqO64zx7gVNez1oM4EP91SqvVhXpZZmh+qL6Hl6ogcV6V1vGT7UO4HPt2nMf0neZJgQTbVDxZ1HFyZe107LO0Mt8ad6wQq8O0wc9Gagf5rfTyBymNaOaqRGKFGFck16m3uqVwP2XsbhQbiLmz5qfz2geP/ASQM12NmZYQ0cQrmHvYzvJHuk1g/KQwoZ2Zsj5FTBqJpejxJYiSj1Px+WMCyOuYFcQL04XwKzVsZbOhmvQIdhTrlnYhL5ponH7vCNNi8cfJOzAYTY2RyskXujSXYn0SEp2n53qRidGGRcIVvQ5io24l4cJ9W+kxppEwmX4/swK725pK+Ymg0jfCF5784VxURkfqbFb+5kq8sgL8UdfDwaUpvXOSb9C+Xwlf+3FxnDgzetjdrPJ6z3z7s1gYztPZxYhN7cXgMXuJDjr518uiiJ44d8jG13akrlAOyPtkJGjadFGx7yL7TEoo/5YUjsxzgK2Do3KeCrC95jeEZ5ZrIymIfnG8ffy4yxvKhAQ9xyyOJHS2VT/PVg82yaA7cnU/MBOhrn5mw7PIhSfpflEFUxlO1FCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4958.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(316002)(66556008)(66476007)(66446008)(38070700005)(186003)(64756008)(4744005)(5660300002)(122000001)(44832011)(38100700002)(52536014)(86362001)(6916009)(508600001)(55016002)(26005)(2906002)(6506007)(71200400001)(9686003)(4326008)(53546011)(19627405001)(7696005)(76116006)(91956017)(8676002)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xkv06SDDlK9uc3TLiXatwT8sFabGVZihjb7vgMZ843MqeeDBuIt0wgf+H1rY?=
 =?us-ascii?Q?jnaq/phI9JKystU4UmphBY0BopSlJCthIVwpN1i5KxLwGvj+nqKXbv82MdGZ?=
 =?us-ascii?Q?CpBGG5eG1OeUB2N8QwzDbXIF661WPGkFQVbahynmSyuDJvOAd7swKpBW2zTr?=
 =?us-ascii?Q?3fExf3A0FEW+7RzUy0JDUtlSQykcnemBWu8HW6VHZ+oJfoHYRu+Pe7Xj+/25?=
 =?us-ascii?Q?FY0ReoZnVc3tSVItkd2lqlXCBbQJFvXtjH7qZj5GxuJ1dEW7RRCM50KqKguq?=
 =?us-ascii?Q?p2bFdJf4DZ15qZeTWE16MvaTO2+kGX+FAurVV/BvfScGck1Dkp3wa1aL61t6?=
 =?us-ascii?Q?s+OjTnkknqxJ70PYvnRxbRggGH6B6+zxyPCrKVVv0aZ5JY+W2B8m59zm7UKd?=
 =?us-ascii?Q?dEW0/qD6gcG6DOIHIcPn+yRace9eQ0CtyPlJM3npDQm2YKCiOpBTVPxNLLXT?=
 =?us-ascii?Q?/oPLIk8BU6/I0GeJdHTbNkmdr4SEv8NlFxmKyAWVKw9yTqFZoOYrvKWC2YIP?=
 =?us-ascii?Q?b4ThtJGWCOAYPq82Ne0Y684g+hMfIN6WsjHdwnKM41pQgYbW2CJFgg7gxU7Y?=
 =?us-ascii?Q?+tLF8WpRrVKkvcaWqbuT1C8SkyrrqHpDEcbK8dakTjdMjTYYnBxNJnJnMFJR?=
 =?us-ascii?Q?eLjCo7kssLurcBkvjkFcT9AKZKAnOdd+2TwLdMMFHjpsBbxQax1sk4QoSz0H?=
 =?us-ascii?Q?bxQ5UT3YYjZcMadY9O37TMdFqUZV4wURkX4QVyDgqriL/VF8SfkIDtZSGGAF?=
 =?us-ascii?Q?LpzJ3fhiqkJkG3EifIhnLnWBMT3RkIUut7upenARc4G6IGkGILp8uTXBTJZt?=
 =?us-ascii?Q?usYpHBQ78XJU/MpUfN38IcPyMbuRUAlOvOMoPwXsHEWK2yJuRlhAUQh8BGlJ?=
 =?us-ascii?Q?Wk0EHfrQH3NbEIZKsJiURD7XFMmM2wEjkDINnFGs34A7wzsg7LZbHm5i2NHs?=
 =?us-ascii?Q?pQ+xsUSGn0O+N8O4wHOHnPRhoQ9ULtUa5UKOqWGV8Ug01qm3df1zu8VtEH+h?=
 =?us-ascii?Q?FlJsts0eQdbJgMYBPrX6mkKd+EKDwqyGZENqbNQh2VJwF2tZBqHUCYOZma6s?=
 =?us-ascii?Q?3fOuKSKwUx08zlLWX0DA7TbRbek1SlgJRHFFZoD7M9tA9CZzFsdhmTGkaa1J?=
 =?us-ascii?Q?YjKLx5M/kfMiT5WXE7yDkcnW7ETyIcaVEmnirhQwpMGdKgAKWhRyLYfl9GF5?=
 =?us-ascii?Q?aluszqaNXEUL9XhSiJe+QWhUZ2o2kDJxBxitcGvfQvSS8KXc6xnQxd3GR0YY?=
 =?us-ascii?Q?zxq1Rb0cOBo6HEFIhHVI8zhlsgH2/+KA8SvCR+WwIbYQvndlwulEeJU3KARG?=
 =?us-ascii?Q?2Us+w3YsGBv9kC10cEIDOGxFTZvxagZXsDeQYZCaOqS8G3zLfgaAVkClXVFK?=
 =?us-ascii?Q?rj0gMFx0S4vii9OyjNb6sTLN1nKLDv+lZomc21zcr5Fyl4VrHhZI6cN7idbI?=
 =?us-ascii?Q?gHHOJ/MEeBu+8LpoLDkLZvdnbdk5zaoO5USiAEi/jQn0f3WDAzPTjdU9X1zo?=
 =?us-ascii?Q?LM0+vedG7kLsrK6E0uWtJ2DuRGmp4+4et4butcZdADheqEIaeD6yN19wFPaP?=
 =?us-ascii?Q?P5kfsVKRkizyurBQ8APZBQU9AW6uHM63lVgHkwLC+zfri6omWVUZLIvvQ9a5?=
 =?us-ascii?Q?DWdy67zvMTXQltWLkQZ7VcVpqvIr2h9xgdjcttF19fdjye87iJl36+Iu1iuO?=
 =?us-ascii?Q?ftB5OQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6850e2-5d3e-496a-0b10-08d99faa3e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 15:46:18.9762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vz8KS7Jpik0VJMaW5R2PEhOJUSAnv/1H8QlhoRwewv5n0RuD3/oUAKq6cftQfebS+A2GZvZnUITgGG1JVxyeY8nrU+h52tNs83nIDxmNvO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3888
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] netns_netlink: Ensure tuntap is enabled in
 kernel
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
Content-Type: multipart/mixed; boundary="===============1829048190=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1829048190==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR04MB49584132B93ADCAA3142949A938D9VI1PR04MB4958eurp_"

--_000_VI1PR04MB49584132B93ADCAA3142949A938D9VI1PR04MB4958eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks a lot!

-Bogdan
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Thursday, November 4, 2021 16:10
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v1] netns_netlink: Ensure tuntap is enabled in ke=
rnel

Hi!
I've fixed the kconfig line and also added your Signed-off-by and
pushed, thanks.

Please make sure that you commit your patches with -s

--
Cyril Hrubis
chrubis@suse.cz


--_000_VI1PR04MB49584132B93ADCAA3142949A938D9VI1PR04MB4958eurp_
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
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks a lot!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
-Bogdan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Cyril Hrubis &lt;chru=
bis@suse.cz&gt;<br>
<b>Sent:</b> Thursday, November 4, 2021 16:10<br>
<b>To:</b> Bogdan Lezhepekov &lt;bogdan.lezhepekov@suse.com&gt;<br>
<b>Cc:</b> ltp@lists.linux.it &lt;ltp@lists.linux.it&gt;<br>
<b>Subject:</b> Re: [LTP] [PATCH v1] netns_netlink: Ensure tuntap is enable=
d in kernel</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi!<br>
I've fixed the kconfig line and also added your Signed-off-by and<br>
pushed, thanks.<br>
<br>
Please make sure that you commit your patches with -s<br>
<br>
-- <br>
Cyril Hrubis<br>
chrubis@suse.cz<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR04MB49584132B93ADCAA3142949A938D9VI1PR04MB4958eurp_--


--===============1829048190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1829048190==--

