Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FABC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:36:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FF473C9EEB
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 08:36:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0381B3C5A4C
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:35:59 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C45571A0065B
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1644564958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hplUBnv7HlOVpCP71xZ5Y7RX/GoArBBEVHjZXNHk02k=;
 b=Y0Y8xK/sk33aaEkk6OvL7N0YeaCXY0mhqJGrzFFqyCjiYpLmR5PZNKWCit+9dLu3XQ9dRG
 7DeTOr+WsfpNLUVmYLwe4zYSmgj6Y5lhbpNSh7k03EvySWVMg1Ny1jwDLIjC+gI4lKI0T3
 VOz0lq+2FO0E/3SAy9KYX7Z5vJv/eu0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-SLxY_ExfPiuD3BCKmK9wFQ-1; Fri, 11 Feb 2022 08:35:56 +0100
X-MC-Unique: SLxY_ExfPiuD3BCKmK9wFQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/4nD2O8lQDICMK9tkVUX73y6gMsxMBwpGvjjT0P6acp2ZyX/I3zP1bKXCLzoSTIkNAa07QX3nwg3HxJzxHqUcsF6XGt4PUN2dcpk7CkQYBihmaE4SQ8Ml2wXQBzLWYaAOIpf8B0Graw4HxchN/M9KcZGNvEUzu1Jxn8EVJT0c9GieAxklyMs3685m7SoVO/AvuEy5b4vKmp5llPGI8sCGnWree0+q7XvIWAp1L73hWffB4mK6GkO0dsjfaTD0b/7CLhi2gb/AXi2aQMazqUPa5ChHYyyX5m9z+nki6K5EbZvUNsnzt3DIk6vukm2V8k087KNEhkwudjkRjs8xPgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hplUBnv7HlOVpCP71xZ5Y7RX/GoArBBEVHjZXNHk02k=;
 b=JIslA54zteWy6U99Vx/pzxxgtOyP3dB9so5lnMTipMwQSJ3J+821cIxjLXUIKIosJtxzgmkiY1eCHLyZbggqvCvEKGE3UAzXjLZMJxXGLb/jLLpdpv92Ek9Wls3ZbtSY4bokmHIq8jkP8uSDSH+3fcQSxtBfK0QKhFhqEJa6IjCuXJjMsvohlZ1c1jvv2IIBCYXXZyx3+g+tvSgVnW6ZblJh5L1sdxtM8nPyqSSClXSUUl2nIaZGcNTw7d0spQKcZhLAMdxXx/bG8eD80EqCiWaLfSD3TEgA83lwCC5fzGQcNU+dAho9W9cLtgHWja2Za/C+fxD7q0diujKfKz3vZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com (2603:10a6:803:60::23)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Fri, 11 Feb
 2022 07:35:55 +0000
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::a0d9:78a3:9171:9a2b]) by VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::a0d9:78a3:9171:9a2b%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 07:35:55 +0000
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>, Li Wang
 <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
Thread-Index: AQHYHoN2hkOGrLkIhEeEdGVcZ5V+NKyM9MYAgACN64CAAAudgIAAZtYy
Date: Fri, 11 Feb 2022 07:35:54 +0000
Message-ID: <VI1PR04MB49587421680CE7C6AA8599CD93309@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20220210133812.13368-1-bogdan.lezhepekov@suse.com>
 <YgU5QvQnzmcCgKq7@yuki>
 <CAEemH2c71jsd5VDZ05pCEGJMHtdxK2_T2MXaK5P73qttBd-gLQ@mail.gmail.com>
 <6205BA38.7070903@fujitsu.com>
In-Reply-To: <6205BA38.7070903@fujitsu.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: d4721f55-844a-2c72-da9a-8e0899c85722
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34882267-a485-4006-05df-08d9ed312345
x-ms-traffictypediagnostic: PAXPR04MB8686:EE_
x-microsoft-antispam-prvs: <PAXPR04MB868659F00BB50F3E7F56618793309@PAXPR04MB8686.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3GnijeGndpaAkmT4NGy/JarPWBNseLjWWjQue6cylX+g+CqTEvmktHObrf6Bj+189rODQ4ARtMSoFJLUQDEJwZxVCYguc3U+EO8m2JF+AeyP9QXtYi3Kd0z0mqFFLuqs+weQtfZlxSeVMslHxLEYxoHprXzL+Uh3rNYkcPllIpZ/8Tz4zks4bUaTNlOkdC29NEPJq8Uv80qbRlQ340nWyaT4r8Aqv7pakh6rQGc6SQgmc7D/0QjuYrI+2Av8iUc34gskQnWVdbIyMF/oba8dKmbJDdTdkk+5xjwl8Rj0MZTsUP4fnfV7mOVeqwn89lxi5jjE0zAEHhzYa8UCH3qq+SCkfLjoPpzjEX9Gj0kG/DCgz6uPsAdxiBh5DfNsv6FqmgF+iDxrxnjsEGWkRwTvYzTu92sSGbadADPlvKVN0x3dgsSnxJQbqLHBmE9en1yps+gICP+pRRb3LOvAacHSFs3VtHEv6BkwKHYF6og5M+toTwakRlEGiO3cB1txSH/pJjLz+KRNmGK0eyOSaWlzTE5HQckfYBDUld5jnbwP6Ofz13Dpua0p3FapMMLAMnnlCLFFVfNIzs1nWEne3R012lOlSuhiYkgYbOpCZI/fVSW85Ob6F25OfRqkwXz3ksbAzjnPMv9FcOB1CKz6g4xpkGbClUVvlddyZIglXurw930wOZbQsgHNSuEifxh9Q3oFvjMgJO7Pz9x3Z71HQ0N8hHhjz6/8zPZ9GuV9h6GtCN3A5059naGSzoN7m3rMfujgLWh/oE+wWTOcKBREpAtOFpOcUJG4GsZLeDKQLQI+2I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4958.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(91956017)(6506007)(316002)(44832011)(26005)(966005)(110136005)(5660300002)(19627405001)(4326008)(7696005)(9686003)(86362001)(71200400001)(33656002)(186003)(2906002)(52536014)(508600001)(66446008)(53546011)(38100700002)(64756008)(8676002)(66556008)(66946007)(122000001)(55016003)(8936002)(66476007)(166002)(38070700005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iZTZRSKzAKor0T8jWIuiW/DYfpQjYRkKkiEAuDTpCprXxUVcyRkX68/wFMBD?=
 =?us-ascii?Q?jrB1M6lVTmG10D3nf/01rD49qU2YIuo0jsYM6pz0kCAR/PxjqClc0SbRY4aP?=
 =?us-ascii?Q?5zW5lnlepn1OEhRciinPTZB826g2mqa+xqgb/nNpUyyO8XK2u3VZnJS4mYho?=
 =?us-ascii?Q?nZ1R8CzODw2QLXFfBxwWu7VrOjCiulVAF6TrI/MwywoqoaQOiyzxxtbH71zt?=
 =?us-ascii?Q?wPCg1hdtKzepK7DghrZ54pnimW6M7e0Hheb1U7Gjt7Or3u9/3vFFZvxIhH+3?=
 =?us-ascii?Q?9RZRAb/c+tTEqUTTBexN5h8BpYnPTucVqF9Cw1jPTTIXLbA5DbW6g1/vQE9K?=
 =?us-ascii?Q?LlWukC8zVt1/NPLvIbreApcGUE5KpoP+dGrNBlT4l30ZahqPpBezkElJaKOi?=
 =?us-ascii?Q?Ckdoqi1hzr30QD2PSWyYvrKjdkW+ImpyypC+BiVp8GZDISH29Z4S927szmea?=
 =?us-ascii?Q?CNFYzrAFqQTc7T0KIeV6t0Jg93zp0eiT/sRsI+/rlAPRrKOg5z+CQ76Ud6HQ?=
 =?us-ascii?Q?lqLndm721l/5VpR5PzN+CxczslBAqiR2Kg5rkscKoUb7u5VHWZI7NIqtj6hs?=
 =?us-ascii?Q?4KdTCIAGIrr1iAiubBBHStUne8/xUOVFfvWxUwE+8SbdRxMN1Ojl0Ifhyfdu?=
 =?us-ascii?Q?X1VeQULfyThoYR/43cuM68mcJ7SVuEvP42QE+Ow11uDC5LEYUw7Wtos7mWdY?=
 =?us-ascii?Q?j0QshsAAXRmxWbsCgeBs33nhh8eNYm1rrRVtCk1INBTLGEj2WJVz0JFebhba?=
 =?us-ascii?Q?yNWK3XWhZuSRisCx2PeXqQvsTQCKy09Y3nH3tz7jJrgW2rkmanwqDcH3ZEyE?=
 =?us-ascii?Q?xrhBN0ucAyokRi2xiHb+KkCC3B7O/BPXVYKcZ80uML6K3lWNzL02B+dZDbYk?=
 =?us-ascii?Q?FBjePxJX24ERwFGV0pcL4zTlqeeRCU+GDLVGZmn8RVDgqg/Heli4wMjRBAkd?=
 =?us-ascii?Q?rKdT5Q3qKMlJ/IB1T8L0FCNOmriUssxnGNpIjLEkKSENquEHsU6sDhxC73FO?=
 =?us-ascii?Q?Xo1yPqlyvcqGYDVARchRrdqc+LFTt1jmpLKc0oQMhQfWWd1a2ZEvVhu437BN?=
 =?us-ascii?Q?iurrskAtOdcXrsZ7TRWAWKGHz+czO9HqdXxaOQG8OS69f8pgvXCZr4BrD8wi?=
 =?us-ascii?Q?Ebbv8IQuVe0KNM6sXl2VqS7pGlXCoMBTLPUUSD2zGg97Q/ePqqhiYKI+y8YF?=
 =?us-ascii?Q?WGEd1So7gqlirSVgL5kZ63mnHEwW5DWGOcWN6Ff+/C1pfxh3X8nX+zQm50B2?=
 =?us-ascii?Q?wxCsi3JXLZ0yiGsbc8uObPEYTgH1Jdkpl62m+W+NKF4rD+0wpKEX0spJuwIn?=
 =?us-ascii?Q?xdILOYeuwjeyUw06zf+3eMUlo24WYMdideKCuE80Yc0f8iLQk0UVupEDT1hZ?=
 =?us-ascii?Q?iC17xWOTz5NazZ1bum0buxPlFBImofrZGCde+5WW+mc8XGikBVyJoGRTjyWE?=
 =?us-ascii?Q?T0rKl4DU0oGOPXD5UHmlRMY+BO2wBtGV1CLZbve8Gs2ResdFuNz5pDcv55np?=
 =?us-ascii?Q?ydhjx5h14Vr0ef3JRYDMy4CQU8mTk1THVT92sF6D5ziCjq+88isM+Xn3k9zc?=
 =?us-ascii?Q?SOCsLQVqpr3zS+YB7xV2ToNfbZwf98frViIa7un8ZYkNe2prdxSJAYYSWGdq?=
 =?us-ascii?Q?Fw2n5/yryZ+jVMTMyrHWaYauR5o32EMe87JiyWDqf3juWBf4ShztIy9EkeK8?=
 =?us-ascii?Q?4RNGRA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34882267-a485-4006-05df-08d9ed312345
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 07:35:54.9761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbDYb95a3KGkcSsVZwDCwdJwxOTsgiBcRTIPo/R4bHwn8kih811bAbErWL3DOW/IvbT7w77IpTCqH/Ut/+YDhUy+0wsnVxn7vPMAfaGpyEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0713240321=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0713240321==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR04MB49587421680CE7C6AA8599CD93309VI1PR04MB4958eurp_"

--_000_VI1PR04MB49587421680CE7C6AA8599CD93309VI1PR04MB4958eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I didn't go for CONFIG_SWAP just because wanted to be aligned with syscalls=
/swapon/swapon03.c and to not multiply patterns.

If you see CONFIG_SWAP more beneficial for docparser, I can make another pa=
tch.

Should I?

Cheers,
Bogdan
________________________________
From: ltp <ltp-bounces+bogdan.lezhepekov=3Dsuse.com@lists.linux.it> on beha=
lf of xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Sent: Friday, February 11, 2022 3:21
To: Li Wang <liwang@redhat.com>
Cc: LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported b=
y kernel

Hi Li
>
>
> On Fri, Feb 11, 2022 at 12:09 AM Cyril Hrubis <chrubis@suse.cz
> <mailto:chrubis@suse.cz>> wrote:
>
>     Hi!
>     Applied, thanks.
>
>     I guess that the SAFE_OPEN() caused TBROK on machines without
>     CONFIG_SWAP, right?
>
>
> If so, why not go fix with .needs_config for "CONFIG_SWAP=3Dy" ?
+1, it is also friendly to docparse.

ps: I never listen user complaint for the lack of CONFIG_PORC, so only
using .needs_config for "CONFIG_SWAP=3Dy" can work well.

Best Regards
Yang Xu
>
> --
> Regards,
> Li Wang
>
>
>
>

--
Mailing list info: https://lists.linux.it/listinfo/ltp


--_000_VI1PR04MB49587421680CE7C6AA8599CD93309VI1PR04MB4958eurp_
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
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
Hi all,</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
I didn't go for CONFIG_SWAP just because wanted to be aligned with syscalls=
/swapon/swapon03.c and to not multiply patterns.
<br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
If you see CONFIG_SWAP more beneficial for docparser, I can make another pa=
tch. <br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
Should I?</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
Cheers,</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
Bogdan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> ltp &lt;ltp-bounces+b=
ogdan.lezhepekov=3Dsuse.com@lists.linux.it&gt; on behalf of xuyang2018.jy@f=
ujitsu.com &lt;xuyang2018.jy@fujitsu.com&gt;<br>
<b>Sent:</b> Friday, February 11, 2022 3:21<br>
<b>To:</b> Li Wang &lt;liwang@redhat.com&gt;<br>
<b>Cc:</b> LTP List &lt;ltp@lists.linux.it&gt;<br>
<b>Subject:</b> Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supp=
orted by kernel</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Li<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Feb 11, 2022 at 12:09 AM Cyril Hrubis &lt;chrubis@suse.cz<br>
&gt; &lt;<a href=3D"mailto:chrubis@suse.cz">mailto:chrubis@suse.cz</a>&gt;&=
gt; wrote:<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Hi!<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Applied, thanks.<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; I guess that the SAFE_OPEN() caused TBROK on m=
achines without<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; CONFIG_SWAP, right?<br>
&gt;<br>
&gt;<br>
&gt; If so, why not go fix with .needs_config for &quot;CONFIG_SWAP=3Dy&quo=
t; ?<br>
+1, it is also friendly to docparse.<br>
<br>
ps: I never listen user complaint for the lack of CONFIG_PORC, so only <br>
using .needs_config for &quot;CONFIG_SWAP=3Dy&quot; can work well.<br>
<br>
Best Regards<br>
Yang Xu<br>
&gt;<br>
&gt; --<br>
&gt; Regards,<br>
&gt; Li Wang<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp">https://=
lists.linux.it/listinfo/ltp</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR04MB49587421680CE7C6AA8599CD93309VI1PR04MB4958eurp_--


--===============0713240321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0713240321==--

