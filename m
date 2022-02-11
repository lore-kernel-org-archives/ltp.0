Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC61C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 13:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE1823C9F1C
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 14:16:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 830933C945D
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 14:16:08 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 782BE1401438
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 14:16:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1644585366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DQ2ZhAyYiQArPlGD/OPkO/WtTagpn7E3DAp+ehsmEk=;
 b=SllrvYQ10tmn9HIwxx4nEy3Bylu/ZPBDoX2wbHUiiQ6Wg2OCTiU8hDUtNMrlAu6iDRwRNW
 ZjutOY2lzC5yOY8cqJTSR2/hLptiiQN6f484RNISVhJKDlXtUAyn/VAP1qvyuEx4czBhFk
 0jww8vXGdVmBgQ7vlApxLnzPlXJdDds=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-VBZHpZAJPeOw-m3BWdwWmQ-1; Fri, 11 Feb 2022 14:16:05 +0100
X-MC-Unique: VBZHpZAJPeOw-m3BWdwWmQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr3uBXuiYIFitfoFULlv5xNgTgTbNFGLaF+T6nne2uLbo+UjhLQizDCmBX7lmfWWLltLcBLvDPr7JTacu+Bn9iKM3zfgDU7IqNCc4mr/SjXoyZdh0GKLRqmDeOfLheL8Uk3tzet0uWM2NNrJa8Lr4VroyNViSZ4/vqk8ggsQ2La2/uAfsEyUxzySp3YHKH67cOhZTXpSXbsvXcZDxym+v+21dVgbpL61ezKKttVzPQRV3uqAWXgnKT8ffrIvzptyXIn3zuB3H6kkZ7tlZRTl0WhfygF77bjr1FjzOGZLiJ3reoWaIu5II6+3kwD/h7SwTBgokdI7EbxOvZeeBs9t/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DQ2ZhAyYiQArPlGD/OPkO/WtTagpn7E3DAp+ehsmEk=;
 b=BaTHGCfkAOqUCLeuDkM8z5+3rdtomdLI5we5/xbW+hMVtTuMjhVYfqmO6HWYMIpU8YMzqCSfvYLPeaI25Uks3XZILTBJxgzoxE6+AEQOqZDD7PgAaJw554HyQXyJnrTdbZSxdUpP9pAElGvooktl/d79X5hbFAryXqjnZVTmBeG5d+M5RKK5ojfkLNN/yioJj89DzOrq1VPwjodJeAGafLVs1qXMF2A4G/95JfziY1fyiPrO3ruFcKWQn7K8AqB1yj+A5OogH0VEjGE+hTUxHj3TiVMj9U0h9TzKKyd8AE2B2fNRI9Uq0uyFwrmSospFDXMpgZD4fb5rP8RYi0QhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com (2603:10a6:803:60::23)
 by DB7PR04MB5179.eurprd04.prod.outlook.com (2603:10a6:10:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 13:16:03 +0000
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::a0d9:78a3:9171:9a2b]) by VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::a0d9:78a3:9171:9a2b%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 13:16:03 +0000
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
Thread-Index: AQHYHoN2hkOGrLkIhEeEdGVcZ5V+NKyM9MYAgACN64CAAAudgIAAZtYygAARAoCAAAgbAIAAR7kA////1Us=
Date: Fri, 11 Feb 2022 13:16:03 +0000
Message-ID: <VI1PR04MB4958065F19BD86A04E7A711893309@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20220210133812.13368-1-bogdan.lezhepekov@suse.com>
 <YgU5QvQnzmcCgKq7@yuki>
 <CAEemH2c71jsd5VDZ05pCEGJMHtdxK2_T2MXaK5P73qttBd-gLQ@mail.gmail.com>
 <6205BA38.7070903@fujitsu.com>
 <VI1PR04MB49587421680CE7C6AA8599CD93309@VI1PR04MB4958.eurprd04.prod.outlook.com>
 <62061EC1.2040206@fujitsu.com> <YgYlYoi0AC1flHlT@pevik>
 <YgZhjLc4u+Xb6Y6e@yuki>
In-Reply-To: <YgZhjLc4u+Xb6Y6e@yuki>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 08f60f09-1144-8fb0-966f-4e6e5d4a6660
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 564ab13f-5276-4f56-9804-08d9ed60a7da
x-ms-traffictypediagnostic: DB7PR04MB5179:EE_
x-microsoft-antispam-prvs: <DB7PR04MB51792DCBC02203E4163901AA93309@DB7PR04MB5179.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBZdK1D1qMVUHlEx5dXL5r67PvWoUO395Va1U5hQGQHeloYhSTjoO6w9+d/EOnyrfRpDzzm+vOqcnstJK45SdBT6H9NXEqA+4itvk6b+khCQ0IWHoYZ7Uur8WZ1VWXNkwrMQLGNiFZuJ37U9GWPq4tJ8sP76wAhTcv/UPYSk/0OeTx6Xs5k7J5DD1osazaTy3TJzC2jc0u7drMd8v/fTGPjtettEBAWTN8ByWlCW+noi432o3mpPjUHdru5lopyyrTv7DpJ0KqRlMvav5Ys8lmMUtSltNOW8H2fmJpe8SlBMhrPiIQkNZiqag4SMOKcGT4vW2mOkY4QEp9fmJAl6ZEw1L9bWr8xRPUX/oZ+q28E4S2rO/uVitHo3lVCTU8dOZfEUt5I0957GqTuyJF3ZvlJM+TAMS4ot3eMf/LS7mfgZRssJZjoImSthOTqjMklswHIIdU1SEhqWT2zn6XAxGLfzt+heYGjJ4cZqtkgUUsYbb8OsShSHTzhHQh3r/45AtU3W4kVWLA2pqAM9ctPCiMWISXSmkT4IEfMni4J0asDnkhVC7PHOG4fC/0eeTj/nSrehKcATq/T1Z3HbEzKN4i5HLQFRaeBDBjW11OmtlI3HYq8dy49qqL6eOahb0aPomMT0GnT8+4+a5mD6NirStQL2PTmMvi5TrEC0pzhL5w6BGS0qct8pLzdkwUbbj0cAlO18zwY+tpJ7AlPqZM+hCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4958.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(26005)(8676002)(76116006)(316002)(66946007)(38070700005)(53546011)(71200400001)(38100700002)(66556008)(66476007)(66446008)(64756008)(83380400001)(55016003)(110136005)(54906003)(6506007)(7696005)(19627405001)(86362001)(4326008)(44832011)(91956017)(2906002)(508600001)(9686003)(52536014)(8936002)(122000001)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oe7n34TU4dc9WlV59frxqt5JiM7iL2w/PZaLgE9i10Gfy72diVozBE7Glt3R?=
 =?us-ascii?Q?F1vVJA0SSwETg7pZmzVGR/of6uznGhYy9q3OJkvcAxyIkocezsZRx4QOX0HN?=
 =?us-ascii?Q?08PmtEoM8YeEZf+Nwz8or8zaM08zr6IpTYSPSrlxbUlNzd/T96VORp4EF3qN?=
 =?us-ascii?Q?J+y5OhEIqhDYLJ5rwXN6pyKbCsrys628gRXc1Vu4lZabUqt2vQeFYu6ycDnF?=
 =?us-ascii?Q?wggRhaocOwBdP9fEtF3DUwDByxBvNOohDJorW7FvGUpwMMgY2JdmtZgtsXt/?=
 =?us-ascii?Q?XBfThf0z4mKJgWW/cBrBv46a51s4rCKxmCaPUcTdKzY315j8kysEV4RsF5dv?=
 =?us-ascii?Q?wpg0TEERnHn1tyRs+eOPY5J9rcc98ZHC6rM+LUXgwXv51ZuP5FFJ3sDUDXxS?=
 =?us-ascii?Q?NMdL3dTXlKrZH4yBPn7DHNiKHuaEzx1wQQnEOQohvBVpcuk/H4mpbQ9aCd0o?=
 =?us-ascii?Q?xEUCAtc9koIheGU1kap+NJkuh5+hqq9rGdZmUaqYr/i/XP4kbK/2nGUIiPj6?=
 =?us-ascii?Q?wV5TQ7fA2dpP5x0WYMc1A+voN2Mde2EzsHYss8mDJFjVvxT6xliOTcIf/KCE?=
 =?us-ascii?Q?BrugNzy76KTOn608/rvXc5LqQ5A0V+nI1FQVc7YP8VRzVop9c9qNnjLZ2HAe?=
 =?us-ascii?Q?uVEHK+Ua2hOvYCc0C4Bip3hTEVR01fkoehqIk6N9bGNT/Brg8bGWdD2Uwa8j?=
 =?us-ascii?Q?0VJzFg07MY/WwKmjLSrqCSJS39XeVqFzOTEiBn3KmCqUVyI1j5CJsatK4eGY?=
 =?us-ascii?Q?XNEjXoXPLHLwlOG7O5NTIm+M1wwAMtn2nTRcKYMajTKe/Vo7xQuo6XxSF7ZF?=
 =?us-ascii?Q?SBwIbE9tZ0FzAmlVI2ABHf3Ql+JTtbX9abFnOE8aKJLyPuXy22vfCZBGB61n?=
 =?us-ascii?Q?3xrSxmeorgV18Tgcq4AJa8RZxTeTOuuffLMdJC7gMYr/n1JoDKzZ9IlaOcJi?=
 =?us-ascii?Q?2aMIV6n8QG5PSw7jTPMR4jskl/DgZCTSNPG2REZ1qXuHuzFIm1awtLAAGR5i?=
 =?us-ascii?Q?VEixXN9nKNmsu9MDsPUh2f5ul1xb61Ml3iGonhIIbxQCRWM2LzKoWgDQCLQN?=
 =?us-ascii?Q?XKrYtTNorG90Nvit/R2l+hYKgc9T24T0yR+7kY58Lx5e39GAehc8raHCjaiE?=
 =?us-ascii?Q?dBR3BIuIppUef06xLx4D09/6mXHYpfXRqxiBgbfMjIrRisAoqkvPX0tz7rYI?=
 =?us-ascii?Q?xqhtVFZAF/9FZ74I4OQgNRwprjNTlBLiStkVd7QBNH6+/uWqtmv4GSKgb+lg?=
 =?us-ascii?Q?e48gQw9AZi74AVymTwldRR4Wj4gLgq4vhA1ZtUrAWLOlxJ9e8Bu1piExvVAi?=
 =?us-ascii?Q?JozKs+fOuzX+hM1QE55/TJB7WiAtF50zAAX/HAc1di9uevad8U5dT4RhCUpz?=
 =?us-ascii?Q?EaedmiHfgpJYR2JE8JaBRatGW68xeTitJ0ud6cpSvCexOKHAP16+1jGJPofl?=
 =?us-ascii?Q?lVPA8qu7825iu0008ukNdan2pPZoSruehrDHY0k1f7FoFhIiqjI3lrqmQeG5?=
 =?us-ascii?Q?fC6gtBgp8noIt+vBYEiuaJBWqBcFSg7wii+KMc49l0ScUCzHOuz1l4JTQXMj?=
 =?us-ascii?Q?WQLH1pcRt50mwJSC9YSgOKtd1XNOF9IYpvcmyQYL50K0aI4Bb0gEPC/urao5?=
 =?us-ascii?Q?Io8YX0zDS8LCBtM8JmhnNa3zFh8CDWMLYNLBt94Xi/+ixFqmcXYoA+m2fThq?=
 =?us-ascii?Q?EpPJEA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564ab13f-5276-4f56-9804-08d9ed60a7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 13:16:03.7775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RKrn2Itj9B+bEVzo6NLz1t+mBo66j/WEQWqr8h9EGr/SkDxyjC/1j83swZP4+ljeyOe/d8cW4poH8gjSLQD7Q+YA6HuEsIzwNpGA1H0WDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5179
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1605105388=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1605105388==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR04MB4958065F19BD86A04E7A711893309VI1PR04MB4958eurp_"

--_000_VI1PR04MB4958065F19BD86A04E7A711893309VI1PR04MB4958eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Ok, I will send out a new patch.

Do I need to update syscalls/swapon/swapon03.c accordingly to make it a pat=
tern?

Cheers,
Bogdan
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Friday, February 11, 2022 15:15
To: Petr Vorel <pvorel@suse.cz>
Cc: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>; Bogdan Lezhepeko=
v <bogdan.lezhepekov@suse.com>; Li Wang <liwang@redhat.com>; LTP List <ltp@=
lists.linux.it>
Subject: Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported b=
y kernel

Hi!
> 1) keep check access("/proc/swaps", F_OK)
> 2) use .needs_config for "CONFIG_SWAP=3Dy"
> 3) Add .needs_swap flag to struct tst_test
>
> To be honest, I'm not sure, what's the best, probably .needs_config.
> I worried little bit about .needs_config forcing config to be available i=
n the
> past, but that should be solved KCONFIG_SKIP_CHECK added by Xu.

I guess that the easiest solution would be .needs_kconfig, we ended up
depending on it in quite a few testcases anyway so I would say that
nobody is runing LTP without having kernel config exproted anyways.

--
Cyril Hrubis
chrubis@suse.cz


--_000_VI1PR04MB4958065F19BD86A04E7A711893309VI1PR04MB4958eurp_
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
Hi,</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
Ok, I will send out a new patch.</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
Do I need to update syscalls/swapon/swapon03.c accordingly to make it a pat=
tern? <br>
</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Cyril Hrubis &lt;chru=
bis@suse.cz&gt;<br>
<b>Sent:</b> Friday, February 11, 2022 15:15<br>
<b>To:</b> Petr Vorel &lt;pvorel@suse.cz&gt;<br>
<b>Cc:</b> xuyang2018.jy@fujitsu.com &lt;xuyang2018.jy@fujitsu.com&gt;; Bog=
dan Lezhepekov &lt;bogdan.lezhepekov@suse.com&gt;; Li Wang &lt;liwang@redha=
t.com&gt;; LTP List &lt;ltp@lists.linux.it&gt;<br>
<b>Subject:</b> Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supp=
orted by kernel</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi!<br>
&gt; 1) keep check access(&quot;/proc/swaps&quot;, F_OK)<br>
&gt; 2) use .needs_config for &quot;CONFIG_SWAP=3Dy&quot;<br>
&gt; 3) Add .needs_swap flag to struct tst_test<br>
&gt; <br>
&gt; To be honest, I'm not sure, what's the best, probably .needs_config.<b=
r>
&gt; I worried little bit about .needs_config forcing config to be availabl=
e in the<br>
&gt; past, but that should be solved KCONFIG_SKIP_CHECK added by Xu.<br>
<br>
I guess that the easiest solution would be .needs_kconfig, we ended up<br>
depending on it in quite a few testcases anyway so I would say that<br>
nobody is runing LTP without having kernel config exproted anyways.<br>
<br>
-- <br>
Cyril Hrubis<br>
chrubis@suse.cz<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR04MB4958065F19BD86A04E7A711893309VI1PR04MB4958eurp_--


--===============1605105388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1605105388==--

