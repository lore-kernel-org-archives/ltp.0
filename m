Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F8C433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 13:51:31 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B9C611EF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 13:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6B9C611EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D08433C72F1
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 14:51:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74FC63C72C5
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 14:51:18 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B39AC1A009AA
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 14:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1636033877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HL8Ugq+QYPIUf2W3u6YLhRssBEU6NUYMiuZ/6GbPHC4=;
 b=TULtnlnog2UUGp0hcBWrb9ttVYM6Y/HlJBEl5bt5U5313babzN5WLGIBDqNhsMwV5I7eTG
 PrAEvTw8BsiBrNC7PwUhzcmXfNjv5HPNBiYDVZZZj4nisfX18wHCzflyMivMjjM8bRa2Md
 ANHVGlWIQbhdsNL3kgHiQ8YpQ+xiwVM=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-j1vvG_cONZGnhKkwA1q1dQ-1; Thu, 04 Nov 2021 14:51:16 +0100
X-MC-Unique: j1vvG_cONZGnhKkwA1q1dQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mee+GgkDgDsNXCrvEQc144Sfbmoa2PWJdGmmo54QvSVihbuh35GQ444YqOaKKQxiRNnlQbAvSsdq8hLGmy5MOgoqXpk4ikAI3rxCaoB0J3+txkTg04JWNBz15QR61V43xXNMZXzFEN3nyFu6fD2+fj/Vuvc4tSvf5F5kozFPpeZU9CP4GcaPXar//5HEfqhdhJJ3FwiTKR2m7Bl681NCqo1J2sGldyT2U2OgEhx99ZIIsKah6dyB/f9XS2jbO6c+yFoljbL5f/uaf814LtgFQRIfQEt8+1nMMJzULgKxrBBoDP7JdURFNR5xr5b9LYPb8JNbGPFQhVrp44/vFIjPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL8Ugq+QYPIUf2W3u6YLhRssBEU6NUYMiuZ/6GbPHC4=;
 b=FvQjmNOyfmHOBCRBsPO15D4vbHy9VDZ/C5MjCEkWZkCowPkFgBkGexYZqk04534X52IqwhVbUDA2HnnFjrON6H6ZElElZv+WIr0QYcI7nas1c2ElG4kHgg32vRNy/ePVloQuIHcGNev71pdOFMWp9pFeIbBkb04qrfpQpCquo9gr5bRmJ+7XHel8jJCrK40K2guDW5A0A0LToxTSWzX6wO+N6SuSS1hg7HZ02uLIhGIcR7PdEV0PsIUICU6XZtcMxpo4GzXXmlqdsamMLtD2Gq/t3GD9WXv++BLrRjFoBR3cF8nNi2jLxnDqKXFuPdxdhDOXc1czQEl5bjRDUv8i3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com (2603:10a6:803:60::23)
 by VI1PR0402MB3520.eurprd04.prod.outlook.com (2603:10a6:803:6::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Thu, 4 Nov
 2021 13:51:14 +0000
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::309f:d595:856e:a1be]) by VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::309f:d595:856e:a1be%2]) with mapi id 15.20.4649.021; Thu, 4 Nov 2021
 13:51:14 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1] netns_netlink: Ensure tuntap is enabled in
 kernel
Thread-Index: AQHX0Jn0tsVvpInFkEuJFomDdzqm26vzXeuAgAAGcGg=
Date: Thu, 4 Nov 2021 13:51:14 +0000
Message-ID: <VI1PR04MB495821F6033AD4F7AF967CAE938D9@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20211103100235.22007-1-bogdan.lezhepekov@suse.com>
 <YYPff0zN0ydo5Z9h@yuki>
In-Reply-To: <YYPff0zN0ydo5Z9h@yuki>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 5abb9719-fe17-af84-48d7-bb118865e983
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41516c5c-729b-4207-a4bc-08d99f9a2ae5
x-ms-traffictypediagnostic: VI1PR0402MB3520:
x-microsoft-antispam-prvs: <VI1PR0402MB352050A5F609F73011860CE6938D9@VI1PR0402MB3520.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Huzdnj7UTcLdD8D1WlU/EDXBH2Z2RmEW1yAZHUDTpz0yDG6eptqmoAlqKy0dft54UNxslisiUyFh9xgP6968cxBXN8qDTOBxwS9qg7FpSv1MGZ0eo8AoZ3L5wlmJPzu4Z4JM5SaRZFMfIkv+wVdAISc6I7XxSkRSwODzdDTQqDks66uUInyhrAB6pKiWmrBtsIi3p5lqyOLfea9vVrcgvu21e2vReOTEz8Eo+3XpaqvL4CxkQnwfrgM7rcU7Qv03cgw76nP+Do4U54MtE6X5Zco4qMj2prX8CMXtDqik22+sqpskl1TA2ZQ6KCWZkcWgj6o0pQosjT9sUFLaQlbBjONKYUPgr+GB5UF8JR+ZgB91XpERtevUODxOB5FaTsHNJR1UUYS9K8W/2dTkXjR4IVAMhiDbHCScuX1Y3UGsJ62+m8nDKGNwzl3aayDsyKRpo7k6EcJlQChURU7G3pihLloNvrs3RQHHdUYSZ6QXIYehQlpCV4UlpdY0Vq2fyFhKlP7zhppY54iEtB11hsZ+wa1qtnR53b/48K19AL9xVGu/UYqdkpKeJ06+BI8ZZUsq0qrnDdBHQdxlJJ/dXMuNw+zKKrhcPvQ3ORKmca5bn0GCXbdKBLLCPEud2De0jAzfaulnBubUTE44xOSPd9zylM97U6yCGfPDVaeD6XJ/rwJAVuqvrJX6nV7McDBfQoTGEK256nLR8M5IE/r15N+h3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4958.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(122000001)(508600001)(86362001)(9686003)(55016002)(64756008)(6916009)(6506007)(5660300002)(66946007)(2906002)(8676002)(26005)(71200400001)(33656002)(53546011)(186003)(66476007)(66556008)(52536014)(66446008)(8936002)(4326008)(76116006)(91956017)(316002)(38070700005)(19627405001)(44832011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKo0ac6kMVyOSpzPvA4IjQ2w1I5KcF5tcbzv8TjVHD7AZgQhQcON1DTjLmVU?=
 =?us-ascii?Q?aLTVsuZMv9pGmDMHpOoDEV5NNY+y9WVSW+QjHIQ+ABZmICkUhyQU/z1hMXAD?=
 =?us-ascii?Q?D73/gooJa8/OrOdq86W2RMUsBSDqA1aX7/n25lifqWlTxzm/qrxT3MlTvOfY?=
 =?us-ascii?Q?Uk4EtNy57dXaP3dqfrU8J0RsuTCj/39gEiv59LZVpHVyU5sw8RoejkKGTv6B?=
 =?us-ascii?Q?U2B+v+dv1ui/xycuqwutBSR7dOlaJmsnMOXlKUniaTz2BVEAUxoyngfzOFmb?=
 =?us-ascii?Q?LEL9ue9IQsg3DfpNEG/gknZ71mDFsmlIXOMqm+ZS6yb0XAe/H7qbB1UzsQrs?=
 =?us-ascii?Q?gY4awetoYsOcllOiRJ5lcqhw8mNod0/2OG2yvMroIejSCS5XExqq169mIq8I?=
 =?us-ascii?Q?gMTFZ9KzYRvdMrW1TqJnO+P8KEigjJAyOJKaLC7+GEVkysJCAPudePSsXLMd?=
 =?us-ascii?Q?KpSw+IO40v+KA2P0+Z2tEFvjFLNcLWunQCGQOJd3eC4VifgWGNBPaD1VW5+1?=
 =?us-ascii?Q?yMFZaMgiuA9OUDkKuNdH0rt9P2s/UTYhZPdphHRPOOkkM6mjyaLrkupo32hm?=
 =?us-ascii?Q?haqFW98L2tlylI+/kzfFGQFwfOEs+Ak+ZcXxWT2MMATQrPwQ1ngR/cIcS2RP?=
 =?us-ascii?Q?PrTNzqIps5M3lYh4zewDA7pAQ7ak2C2BhfXXAozDE69d7VzOsz8VSXRJELx3?=
 =?us-ascii?Q?fzY910544qystOfj5YmSFPznwCQN2gxuGx5yOHmAE2H6I4XXD6y3rAIzx/WV?=
 =?us-ascii?Q?MVSjO5IuaXz6qEb6lOAJsnk9O45+y6dNYGOEZUpMB3Mb9gb3LrRvs6bG9FWf?=
 =?us-ascii?Q?SsvBgxzV2dAeDsCidvj1G80UsQqhYNbagL9e2CXLfhPSBpVw5Pcuap3uPrjo?=
 =?us-ascii?Q?PYSWsVyHQNDdolMnB6p9npWlJBsat3FcVWoL3X8XOZGJcvNo3JCcWjexwWB/?=
 =?us-ascii?Q?ZVPRF4Vz5sbYK527AMvXOX1imWCWM78pYcnO5DWNVKceNWm93XLpy0+ckTWy?=
 =?us-ascii?Q?rSK601JgNDrSpO+TLqk3nctKhiXLZSql3CPs/b901EzrX40DybvoF5tDF729?=
 =?us-ascii?Q?yhMQsUSRsa/JHvLSCBeb/36WJJmkMv38WKEVVHu+HNznSSDEN1tpLBKqB+QS?=
 =?us-ascii?Q?iNApiSvtN2Ee7VPf6tYSZZfFAZhIH9GQDLJsF2MySzn68LAXKvWgvSzmXzyL?=
 =?us-ascii?Q?r4/Wva1stXIXqG8nFRHB183zADJ+h18hjxIM8BQoDvK5JUCNTBV4ia19aBTV?=
 =?us-ascii?Q?0jW/Qeg86HgjCwyAHb6YZEVd4YJtCJCJjc8s/zuCu6lknu0Sy9MsDh4tS+Oc?=
 =?us-ascii?Q?3wtCY+SqP3DiQndWjLT1R9RJ12R3RQyqEsAzBflJIfUa1P2+b9gELd2v3Npt?=
 =?us-ascii?Q?1jsrkLNG4TrSL/Z8rKGRjs9Vhn3oth4i6X4Fkbo+Bf1NfGguDxUeD8+ECOz4?=
 =?us-ascii?Q?aHys30h8GtDgDVd2xuAIY5P7rjTIk6Pq1GxNobilCNCECqoWA3uRUZEP/kWH?=
 =?us-ascii?Q?AYqzhDhJJg/ri1XMpm7AhsP4s8VEW7RAmtiW93mX5xWNGeLCXTIPJpTQKMqy?=
 =?us-ascii?Q?qtZIGU0JzyXzl/Cl14aFagFSbk9WR/K8tr2YiLUnq+WMV0wXiMfWke9enfNy?=
 =?us-ascii?Q?UONQ17IxUYimtM6AOW2kVEv6+RzjMyMpZT6Xubx1T9O2?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41516c5c-729b-4207-a4bc-08d99f9a2ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 13:51:14.1669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5v4I+AiXD2jcpUFyJtCPSB3tKsfx6nXbBvW/1emjBbnS8Xk3SvWCHEBrjPR9LlR6Y9YXLW8atlBHrcksQTNQifp0YRsg7gEaIWwoHGeCVsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3520
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1284977806=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1284977806==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR04MB495821F6033AD4F7AF967CAE938D9VI1PR04MB4958eurp_"

--_000_VI1PR04MB495821F6033AD4F7AF967CAE938D9VI1PR04MB4958eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Cyril,

I was missing that it's possible with the test API. Then of course it would=
 be better.

Should I submit V2?

Thanks,
Bogdan

________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Thursday, November 4, 2021 15:26
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v1] netns_netlink: Ensure tuntap is enabled in ke=
rnel

Hi!
>  testcases/kernel/containers/netns/netns_netlink.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcase=
s/kernel/containers/netns/netns_netlink.c
> index ddd8ce910..f9ae255f5 100644
> --- a/testcases/kernel/containers/netns/netns_netlink.c
> +++ b/testcases/kernel/containers/netns/netns_netlink.c
> @@ -120,6 +120,7 @@ static struct tst_test test =3D {
>        .forks_child =3D 1,
>        .needs_kconfigs =3D (const char *[]) {
>                "CONFIG_NET_NS=3Dy",
> +             "CONFIG_TUN=3Dy",

Shouldn't that be just "CONFIG_TUN" as that would match both
"CONFIG_TUN=3Dy" and "CONFIG_TUN=3Dm"?

--
Cyril Hrubis
chrubis@suse.cz


--_000_VI1PR04MB495821F6033AD4F7AF967CAE938D9VI1PR04MB4958eurp_
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
Hi&nbsp;Cyril,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I was missing that it's possible with the test API. Then of course it would=
 be better.
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Should I submit V2? <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,
<div>Bogdan</div>
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Cyril Hrubis &lt;chru=
bis@suse.cz&gt;<br>
<b>Sent:</b> Thursday, November 4, 2021 15:26<br>
<b>To:</b> Bogdan Lezhepekov &lt;bogdan.lezhepekov@suse.com&gt;<br>
<b>Cc:</b> ltp@lists.linux.it &lt;ltp@lists.linux.it&gt;<br>
<b>Subject:</b> Re: [LTP] [PATCH v1] netns_netlink: Ensure tuntap is enable=
d in kernel</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi!<br>
&gt;&nbsp; testcases/kernel/containers/netns/netns_netlink.c | 1 +<br>
&gt;&nbsp; 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testc=
ases/kernel/containers/netns/netns_netlink.c<br>
&gt; index ddd8ce910..f9ae255f5 100644<br>
&gt; --- a/testcases/kernel/containers/netns/netns_netlink.c<br>
&gt; +++ b/testcases/kernel/containers/netns/netns_netlink.c<br>
&gt; @@ -120,6 +120,7 @@ static struct tst_test test =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .forks_child =3D 1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .needs_kconfigs =3D (const c=
har *[]) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &quot;CONFIG_NET_NS=3Dy&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;CONFIG_TUN=3Dy&quot;,<br>
<br>
Shouldn't that be just &quot;CONFIG_TUN&quot; as that would match both<br>
&quot;CONFIG_TUN=3Dy&quot; and &quot;CONFIG_TUN=3Dm&quot;?<br>
<br>
-- <br>
Cyril Hrubis<br>
chrubis@suse.cz<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR04MB495821F6033AD4F7AF967CAE938D9VI1PR04MB4958eurp_--


--===============1284977806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1284977806==--

