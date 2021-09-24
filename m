Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B5C433F5
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:08:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466BB610CB
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 466BB610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83D2D3C8F37
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 12:08:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90A253C31E7
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:07:52 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B45972011CB
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1632478071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/yIop2uOilx30Gj5fGJZhTAIUIQXTfpi8JKoFcKuJs=;
 b=kW+Q89RoZEXZ07RB4uddxJcHu9SM81x7dxiplcjujlzA2E1lCJw7oAftcc1hT5Hs68AS3M
 ByzIOWPmodZaFDhaT0r19e+7de0OqDMuUt2AfdXj8GnJkNEKqf8aMT2afniHLd6NpF9Tje
 PTDclgzv2SwgBVfr/5EJjvzbWmpKPYE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-5vhW37UJOL2_WVGM4JisMg-1; Fri, 24 Sep 2021 12:07:49 +0200
X-MC-Unique: 5vhW37UJOL2_WVGM4JisMg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmeZaLrDMWmkMY09crUlFfxKPjup+NTSFw5PhKMhwUTyghqLeopOvbpo/ePRQBaiNCPAt2F9xrrdr0MHGpWWXAgl52p7WTMTu3uZ+r0bQ8bBAqG8QiqfZRkRdc/+l8j/u4gNVK39UsRldpUA9oWTrUP3aY6dt0ZDW1H8eMXfQ5Kry9ZOotMy1w4LnEL/v30YnqdHq7zE6yuTgYqxPcPWWqmlcrGq235VpOzyQIxeAkGX5ZE9RJenySUWxJjbvMt1UIxEKC3wPVn/PKV4s2q4UUtVKvoDJQfeQhY4T/FbKFu36uqQnABtp5beBglSeGHaAj74YvAXUCtdnRIOn1DGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=u/yIop2uOilx30Gj5fGJZhTAIUIQXTfpi8JKoFcKuJs=;
 b=mm6PMFXNjcNcKf5tp6S1/O8EVn0+aRU4atXhPenUn6t2JnPHgAGGHWeauJS2DEKfgPbyCKc2KBphvvatAD0ioTtQCRDfv1hEdBZzrOu3SShj9ElYc4z1YW8KUn5DNCqqSMr3fJQ3gJJzRcfkkLYB/udRc9+BgO6gmUpY8XkSvkre1O+C+g4PHBzw5/rAxfqwtWyyWdl9LV0KEZ6gOUVCWaldi6BJKQvKFBIzMKKrLkwWRXiL+gtVB4Fy3m8b6Wb/FYTgyLEelEtAT3C0YzI36u6wPSblYjkkfi60NnJGvwSaagElQ2gn08E0J0p06tC2qW4qfqiX3aRefpVC8L/hsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com (2603:10a6:803:60::23)
 by VI1PR0401MB2382.eurprd04.prod.outlook.com (2603:10a6:800:23::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 10:07:47 +0000
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::39ca:419d:d4bb:ebf9]) by VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::39ca:419d:d4bb:ebf9%5]) with mapi id 15.20.4523.021; Fri, 24 Sep 2021
 10:07:47 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 5/6] rt:pi-tests:testpi-5: return exit code
Thread-Index: AQHXqYs5eISvnd+mG0W8AaGYyusX+6uzANsAgAAEAms=
Date: Fri, 24 Sep 2021 10:07:47 +0000
Message-ID: <VI1PR04MB49588BBF33DF16798A5E5BEE93A49@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
 <20210914170851.22931-5-bogdan.lezhepekov@suse.com> <YU2gAiF7HGujCv+n@pevik>
In-Reply-To: <YU2gAiF7HGujCv+n@pevik>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 7d3bb22b-dd26-e9e6-2945-3aa34acb1b65
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac81daf6-54c7-4afb-d80e-08d97f432915
x-ms-traffictypediagnostic: VI1PR0401MB2382:
x-microsoft-antispam-prvs: <VI1PR0401MB23822A9E55A34A03EFA0465993A49@VI1PR0401MB2382.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XK2RTgThhlINvHxIbrmrBcgAzBUZNhpvPXzJdCzN8DlL74oevWEKwtKmlM5Xt9XKp5ioWagz2+GoIDKp5cOc7z0WOP0xheeZA03Hs4Rjm5Zqxf2RMsEU+n+cTGqX8kxENmgPokmSX7E/GVlZujYYYryqvizqncFxEEnefec40W3axZ7tLPfgH2w9re9+49oycDF8qu6if8D6nmn5JMMAAYHXR6chjyPdAM+lZ8lBcYG8nzoaoFTyFsuMw6cMLcFBKbS8q+rCFiL3k0/5X0aHBg1n4GYEHJ2ynDNC4gKHwFfAoGU+Pkwu6ciaIipBsGS5Ijlrjf6hjwzj8TiGRqW2LSW7pG6Oy5T0WAIF56jOryIX1+uiCVmMY0rhpjXV4qd+/dHz9w7tnynGBXGc5ix2EjgYFMc/HK9wknaOUOlwMvFgA8uUJHNylGgkfAA9GC+qFxsFdBu2PDfspoNSE3Yy1Rtg4HFZEtEW+SCoJiqSHdhefI/diJ7eSPw91HDzFgRS3YUAcYxYtVElSMAZvu47Z/YF//6EAvHyUMxFkSZdUzqJfaFDFNv4pikeSRNe6MbMRU3QG/1ySgoCGX9mKQ7QesMje43y1fzqVHea/qY78rSsRXGnPpTC2va66M77pnSx74fbt1UHu/LgwyBQp+1xfvqmxD56c2e9LLqAR+pJqrlX/sQvf9aB7+gAlpNd8QNk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4958.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2906002)(19627405001)(4744005)(44832011)(52536014)(86362001)(64756008)(5660300002)(316002)(508600001)(54906003)(66556008)(6916009)(66446008)(38070700005)(33656002)(4326008)(38100700002)(9686003)(122000001)(26005)(6506007)(53546011)(8676002)(8936002)(66476007)(76116006)(91956017)(66946007)(55016002)(186003)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B3F/IRdafaWBW2qE4R9PBONTXke9Ab91YZmPDuvXTBvCR+PHEFXft+vLTGhQ?=
 =?us-ascii?Q?KyJLSoN9qMYafZyNi7nKLT3yYvIsog3Wjqe3jZ0dG/50aBQB52pI7OmSAMpP?=
 =?us-ascii?Q?qT5x/X888/3u3lBPHlyYHD/BXtDEXbG88YqWmuVBQj+p+IJU2CGKSWKyAy2P?=
 =?us-ascii?Q?KXvEbiPvG1OuVaBEkAEUFxNaTuYsm3YjymiSySpk3xBoy0QDch0mSZ31BmjY?=
 =?us-ascii?Q?SUpzpTRWeX1kVh9WPhxGip5yCQy0QPkJsc/veiG92O72r+s4jludiNjDq5/B?=
 =?us-ascii?Q?XlOr0Gcfh34fUmEVonQV4SUYEMmTiv+dLxZLW6wscZhglnD1pT7+mTdnLUJX?=
 =?us-ascii?Q?L1yqgsoV6xBxBww3t8AlnAg2RVEDShnKTUP9+EBplBF6kJu41z1SifEILlFk?=
 =?us-ascii?Q?qdfhi+apekzDd2JSk5W7u6EyzNcjjHuO9OUU//NHIp3W7e7KgVcC7zcvbKqM?=
 =?us-ascii?Q?ixdsIIYYYKM3wCiZCRNUN0Zffxxr+NELtHt4XPW59L7WRhc6Cbeh3BLwtVbH?=
 =?us-ascii?Q?ZuHJJucnMH8IcQ7t9mxU6fSujBCprqYVSdHbgHVUsTwAW4VXlEy1A9ZGiwO1?=
 =?us-ascii?Q?9Qc2KYeZgwj3LAikb6pY6m1JrS0D0UTPC2O+rpPZ6ABgF0CXAT/7hLSdAHjU?=
 =?us-ascii?Q?+PMbCHYcIJ1Pc8YYIGIdvV+KGW2nVeX9p+ckSJBd+HJuEiaRanzQJ1pwtG9i?=
 =?us-ascii?Q?1hCv+ilYzz9CsZhybFVkL0Z/LerxdDRpJsPSpLtsQX9SHyZZc/9YfsVF7Xn3?=
 =?us-ascii?Q?5xi8DV5x6XDV558yi3LVcEZCU7ln3XEXS6b3AzotwbWxXvCWPkkTii0L1J16?=
 =?us-ascii?Q?bhGjjZ7E1H4glauzpWPq1S7AlZt7CDKepE0FtXXg/pQqrPLDcau3RPeEpCcc?=
 =?us-ascii?Q?KaSj42pX8p4/F1DWvqdWAh0QATg+13RtFZSKOM4XxsVYdZE6T6zRL439A85R?=
 =?us-ascii?Q?4xbwFXYWyIHX3LIJvQYOJzpoV0en2sKajL4jFdCb1fyhi1Lf0hTlDnIuTmM6?=
 =?us-ascii?Q?zjMPwu2IXC+nXLgfc28Usd2nAyk48mkH2mQPENi8X4NbmNzE1lgZEpCW8NiO?=
 =?us-ascii?Q?I2mBeqd2YYRC/12m4PdjhSoegVlWqA172AuU+fasvum6W15R9i9ljZtCT9ww?=
 =?us-ascii?Q?5nca4H2VrkWWcV3A2H8PRZVfULFOMLsKj+0Es1eckwr1HPg9WaifSCfGuiGm?=
 =?us-ascii?Q?tFqAIxQNi0tVZGnIQYHO+u4SD5+moWx5GLsEMRHFYNMWCdMwTRPE6IG+LSOi?=
 =?us-ascii?Q?ItRu4SOkU4tDD0lx8bGfE+PhU2fqWsx8/nfvuYuNpVEFYTuol2wn8OX8ducX?=
 =?us-ascii?Q?oqU=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac81daf6-54c7-4afb-d80e-08d97f432915
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 10:07:47.7640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQis1DJMK5JUr4t7you/s2TD1b5GTDUde4870LRZA6BvzV3k7I7lEzPVjSuRlEXX+g0mmH7fwBpXLHKU1aPHaqb+E1kca0/r/U+Bn6o1u00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2382
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 5/6] rt:pi-tests:testpi-5: return exit code
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
Content-Type: multipart/mixed; boundary="===============0444754527=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0444754527==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR04MB49588BBF33DF16798A5E5BEE93A49VI1PR04MB4958eurp_"

--_000_VI1PR04MB49588BBF33DF16798A5E5BEE93A49VI1PR04MB4958eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

Thanks for reviewing!

-Bogdan
________________________________
From: Petr Vorel <pvorel@suse.cz>
Sent: Friday, September 24, 2021 12:53
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>; Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH v1 5/6] rt:pi-tests:testpi-5: return exit code

Hi Bogdan,

> +++ b/testcases/realtime/func/pi-tests/testpi-5.c
...

>        create_other_thread(child_thread, NULL);
>        join_threads();

> -     return 0;
> +     return err > 0 ? 1: 0;
nit: "1: 0" =3D> "1 : 0" (for better readability).

Whole patchset LGTM, thanks for improving realtime tests.

To whole patchset:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


--_000_VI1PR04MB49588BBF33DF16798A5E5BEE93A49VI1PR04MB4958eurp_
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
Thanks for reviewing!&nbsp;</div>
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
<b>Sent:</b> Friday, September 24, 2021 12:53<br>
<b>To:</b> Bogdan Lezhepekov &lt;bogdan.lezhepekov@suse.com&gt;<br>
<b>Cc:</b> ltp@lists.linux.it &lt;ltp@lists.linux.it&gt;; Cyril Hrubis &lt;=
chrubis@suse.cz&gt;<br>
<b>Subject:</b> Re: [LTP] [PATCH v1 5/6] rt:pi-tests:testpi-5: return exit =
code</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Bogdan,<br>
<br>
&gt; +++ b/testcases/realtime/func/pi-tests/testpi-5.c<br>
...<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_other_thread(child_th=
read, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; join_threads();<br>
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err &gt; 0 ? 1: 0;<br>
nit: &quot;1: 0&quot; =3D&gt; &quot;1 : 0&quot; (for better readability).<b=
r>
<br>
Whole patchset LGTM, thanks for improving realtime tests.<br>
<br>
To whole patchset:<br>
Reviewed-by: Petr Vorel &lt;pvorel@suse.cz&gt;<br>
<br>
Kind regards,<br>
Petr<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR04MB49588BBF33DF16798A5E5BEE93A49VI1PR04MB4958eurp_--


--===============0444754527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0444754527==--

