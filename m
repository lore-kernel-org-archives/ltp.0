Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A985CDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 11:39:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEAB93CF558
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 13:39:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B48483CD075
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 13:39:20 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E7F241A011DB
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 13:39:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeKtsAJK+lGeQ/WIVMFVgpfWuMrlAKLZLhN5IXxopFG2tHzaQ0wZ9KCt0o6kc/bCLJF/F7sCGnDXUhNkY+mOwqX+Vtm1a+yRFVdDhC0VDi1YRSEFAaF/XsYnkFs+ujSAO0a1UCmMQlD2Xmga0BAphzxj7HaJ++GwcHn609CP6FFSLGAD08WsA7z38Kv5aVaq1v9atpkRK+ngTg0todsx6UdnQAVmulVvaIoDqy1XRvUM/TGNFt4qPVURPBnrCOqANlbkmbyoorPx8SupA3OiGmPQfLp/KTbPAAGj3GBN7y06hNPcz+cQsnstOdWLC+plCuHgL9gUxd84aOuORuLqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdWMxsVWfjImW+n+ig4WVGEAtrMmsP2qUbxOrU89LZU=;
 b=mptblfL67JMdSl0EwlulSldNxSZswvrxT8SGFR3PY/n3/tO39TyCRonVCBsAm8EjA2WLvX2nm8CqEvny9EGduzGv3Vs2OA74g1ZylZJc8dlbAEeELc4WuWhnZYHG8oqW9fQPa+VNK8wl7XJYEHtImeMup8jL2Xal+c1oeK+8zJD/+CgaDpcOKlgKG/SGAiTevxhc7fRTozz60+n8GaEiLqUNR0xjD37Pt6rjwTLfQRjVUNAPQgQbSiFCLj/3O36pfipDV/kdQ20ga/xkixdlFX9CiPywDVbfgAh8GYutPa4AwzKBW6r/uAsHDAShZ4irmWW6EsHT3orDLGAzYluIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdWMxsVWfjImW+n+ig4WVGEAtrMmsP2qUbxOrU89LZU=;
 b=aRI7hHhr9vvqVfnpNc71JracIU9NLC1YZtYQidpq7gjoo0WlZjhzrzv+GF8JO/XwguoFHzOJ6ZxWks5unv29AQlKe6tBPds8F7+H21ow+6Rbu43FIBGmUSQq+QLmWeN3BzU6Fy1FahQX9PUBQOqxyXNYO+uUtFCsK3hkcnZmHENgVALp4DmfhjV1NKr6KLVj7aGqivN7bepRknZSj5h2HaifaNXmzoKU3ub02afzvCUBEc8ujhz/OcF3yL6fZsal+zFJ8QFbk3DZ2XRLIWpipikXNOGzOkC03VhX23ih5z9g8mXnWcUuzcK7IEjOrNi/ThntPqmWVNMU4M8QRUrZhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM8PR04MB7378.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 11:39:18 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::fad0:efdb:766:75a]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::fad0:efdb:766:75a%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 11:39:18 +0000
Date: Thu, 19 Oct 2023 07:39:09 -0400
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZTEVXfQInRoM/A6/@wegao>
References: <875y33vsks.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <875y33vsks.fsf@suse.de>
X-ClientProxiedBy: CYZPR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:930:8a::16) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM8PR04MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: e301d59c-c51c-49f3-96c8-08dbd0980731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLMTgNpgbaj+TkVfUDXvrJE1aMbdb3CHpZHMbomJkJf2Zieh3br9i4LELOiprT4Nx6mRxwhs0btVocYqQsXPhrb5++FCBf5xQZwWLwr5XHvwppWRBkfsWhRAjp9rAamon7dzPkje0XCLlEqcyW27u2kmzkk5NNcXf/dXy5yoWMDaIeuD8XRQv5OKIk1RIwzrKDknukHCRBYt3xFwBqqaW5gnvwJ07R5lVdL6PZTEE3JQ5RZiUbe6Zomk37DnVaxl8h/og1yAvoSU/PbYGy09aqgm97hWq7+C+Bb8CTXlsQhrtIezezvo/H/2hB31yYl3kFdSfw7zZgSeibJ/4OEqN0E31fwTaxIidbDf02apauJUj3GT05daabKi/fQ/OZCh0MbB9rEzEgAmCoPS6f9/7n3RVo5QOAkGoCl/+3pf4SqJvIr79vilt98U5ZFHjoZWlp5RsWB5fT8hBKlh9ah9/ZRJMi57BumbvEIrrvlsHqY759Y3lSgOb0xLuiqk8zdHY42jngKNNz+v4O0RGANu3RElZo+ZvGUxyNgexlIlcxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66899024)(66556008)(38100700002)(41300700001)(66946007)(66476007)(6916009)(6666004)(9686003)(26005)(33716001)(6512007)(966005)(6506007)(6486002)(8936002)(8676002)(316002)(2906002)(5660300002)(4326008)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRzsPqSTLy2R3OB5crzdqK55aMFGTaFBlf6kdt0teL/m7KNMN6oX966J8IjV?=
 =?us-ascii?Q?XX7YhAAUhAN6pW4uhX9mUcLRLDhq1TirkMmnhjyOJT7kNF9nlwAzoF2oBZVI?=
 =?us-ascii?Q?EGDAkpUG4JdE1j61AaoShhS1oscJfR0cigc/QXYO4PtVTULvnRo2vy83EEu+?=
 =?us-ascii?Q?T7aVu9MiqV9dyM77ebDWxqo8g7MzGki+E9h2dlQ/Sm58I8Td/y3x+JQ20pXn?=
 =?us-ascii?Q?WT6LXtRvPRfp93Sz2NJzieTnP7+eQbK6pRUAc1qR/3jOGSoSgBYMmKsDe3WG?=
 =?us-ascii?Q?KJveVqw5xSiLPboiFWSF2mm+jPpJEtT6RZST236d3XVv2CXPpBOHO1a+Evxe?=
 =?us-ascii?Q?SCw3c766OXJ/JHWKhSznm4QUMvBZcR+mAWiEsvn+ZOn5zbfj89XJiB775fni?=
 =?us-ascii?Q?XzNTz9SVJvobhNcCyIo5iBR5qMRsBtDgaUJ08oxD6Shtq/ggkOAQy7ZHL+JI?=
 =?us-ascii?Q?KkmuasCFQ52UA602qdHKN4qLTSJ09LtYp5MtEpikFTsuqJmW5XlTcai9ARkA?=
 =?us-ascii?Q?k1l12LjoH3AD2WrXZLT7SlJfDDrgcAMFbim2yov+TWPJLEH1s2/R6dAqv+pT?=
 =?us-ascii?Q?Mv7Oozi7NNpJRAHlBIux+pYZIwJUaq/z2QNhbYBCcROQwlZhnSnkd9qfgN2t?=
 =?us-ascii?Q?RWTYUyHHrRHqddtE5fRryFmG6LJljNqCE8p2h6p1xTG3dqs0cImDp7yXEe5M?=
 =?us-ascii?Q?iRTxWJEvtfeJuB1ngG59F05uoiaHA1FFoewmH4MUGtfsAODxucwVCCznvftJ?=
 =?us-ascii?Q?n2pXWcyJnDDywQPNfWibghYRKnKeAJ/Y89MsUO2T0dc8Qb5/pyWqfP2djW7H?=
 =?us-ascii?Q?0BaQWIiOYwLV4pC6zWIZ/1X5XxZwlGFtgUJpf6YZw7VxhCKxT6PL87v2yyUa?=
 =?us-ascii?Q?d0V5ULSZ2PEHU+Sv3Vv1FSk8RzKcCj4a2dxYiQvL19CfBGsxKRDvrknuCBFZ?=
 =?us-ascii?Q?lmJXNx0Fbzdhz2l9UDIO/CllngufWxH3YvtkazKnJ9+hMRHkSjfvlMGuLDyp?=
 =?us-ascii?Q?k0cjED4+qmAuRTAcIfXc680hxPs3Pbw2vQcZyCdMu7sOM0vjo8AGz3zCn3Km?=
 =?us-ascii?Q?pne+KN0GQndlqH1KBzLe6KkbR7XPYLqzLASoHNV66KnZDpdp2U7OGCq+4IvR?=
 =?us-ascii?Q?OPcUHlAAKhnYP2+G//McZQUFfvXsMNZVFUUtW2A5iqKuwdJPylrpE7hoSHkC?=
 =?us-ascii?Q?bcTNwsu2V/BGY5qTwonxG7dL+cXbw2eMQPANBmHAl3shs32kM1V8N8n7WuUU?=
 =?us-ascii?Q?x0f9mjElmSx4njhOI581zeUtGEJDzmVR34nsdvtkUoQzsYAkkGymbR1qDuTb?=
 =?us-ascii?Q?PusVpDACqCs3r+BmCD7qKEpCaWqZaa8uvqbS3TvnrdeCw/GFKaoEULpMUKeI?=
 =?us-ascii?Q?62hiIg0X0B5ofUqDE2hlsl6hrUVjeKZQnHC4FjaKr53mL+tkXpA/Vl6rRLGF?=
 =?us-ascii?Q?7UmT0vO5HMXqushiv3xVg/LF42qardRyU7zmhK7Dp0rAsuYy8+hogWNBJkta?=
 =?us-ascii?Q?KN6LEfQbPN2t2qr9KxgKfupfxIdZlyeR2FYs8Vd+Qvpfc1bYWrQe7YqmTHsr?=
 =?us-ascii?Q?UeyrSEbaXsatYeEeAj4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e301d59c-c51c-49f3-96c8-08dbd0980731
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:39:18.0442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7hCXHO2aCZWeE9UgDgYUd7hQSc4wGqTHYq/QUfNbs8oNqZS73f8qJzaclCZ5vDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7378
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] LTP open monthly meeting
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 19, 2023 at 10:31:10AM +0100, Richard Palethorpe wrote:
> Hello,
> 
> I propose a meeting once a month to discuss non-technical things such as
> patch review policy, overall direction and bike shed discussions. Anyone
> is welcome who is interested in that.
> 
> Originally I thought just to include myself and some SUSE colleagues in
> an ad-hoc meeting to deal with Reviewed-by tag delegation. However I
> think the real problem is we have no LTP meeting in which to discuss
> these things and chat. The ML is not adequate for this IMO.
> 
> For me any time and day would be fine excluding 22:00 to 09:00
> UTC/GMT. Probably Monday to Friday would be best for most.
> 
> The agenda for the first meeting would be to discuss how to deal with
> the situation where someone reviews the V1 of a patch, but does not add
> their Reviewed-by tag in subsequent versions.
> 
> After that just introductions, questions and anything someone would like
> to bring up.
> 
Thanks for such good proposal!
09:00-12:00 is OK for me normally, also i can try best to join if time is more later.
> -- 
> Thank you,
> Richard.
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
