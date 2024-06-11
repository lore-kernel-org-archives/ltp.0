Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CC0C27C55
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 03:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718077337; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Y+D04RoEhCvoAUDp4X0fn9/PveQhb6VIdLUoX8WeuOA=;
 b=HbqdjNvy0AiAFnphBC4Qgx2HbhPL6ZyIMxh+to+KiplwzMPgQbYvf19RNMJnsTvK62XE1
 G1jzrGHvXvR6y0zKmuSSY5iu+Ge162tTPmBWa/foXSeFMF9k2us/rShZJvqrhafRld5rH67
 8an17ApBF1+u6vEn0+He6ujdfT/5HiA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B9553D0B3E
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 05:42:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC98A3CE64F
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 05:41:38 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2011::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CAA9A600720
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 05:41:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFEZvIXvxx92v1f/KcaMnoFc971NJLFmUGNCAK9h3ja3i93vEvQ7sLiOGMMoDPAgp4pQVNg66ayw1+a/b5OpJ670rMaO6WDMP83IbRr5wUIdNemUxkRrdgshWDHKoTVVYqakQFog7Fe6kqqhJLWEkzMbyD8rdy05nt+hUcoIMibfDmMxHm3VW0TMiRXW9T4Ql3ZRX7W8FlsRbDqGIsKMNNq5RF4Cc5SoOOjRrXdUBtqG9fU5pjt3MoBv2j9eNZEwMiD3Hw8IwZnWbPrl2HUhJhGDKiEv6fpPr91IK0kgIxH8s6t9yyVv97sbCQjp3CzhWB9ayGsJ4MsCD1By9cVc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJfv0Cnn49XHlZwmT92eu2JZt6LplXMfvNTPB+VBoLw=;
 b=Mx6SoLz12TIPsmMag7oIW/cZuTfYfFHg82MRW4uZxvP5kn9cJFPPk7lK/6sqCNELs+0nQmGCfRnlJL+gZnZLg0IIVA5D3kAH6KG5Gy33mcYsZ2GXUEYsZygI04GqsT0OVRd7eWFv717uUlqpe1gJfG18M6UtC4Dxeml2Bc4f5h8oXL8Md3iFPl4bg0Al287/j3x1jPyWGcuM/XjIFXpNaoX6wgHDLj2I31mvTq3r1zjTCpxmCl9BrjlqQ8UnHxvesMijPid/Bf0aEDbmBe6p5OJJEYKs2NwyhOHZSxjEW2y500W2tIwUC+Bd1BZv0+WrVBTLIyMHVcmk9ffx85M+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJfv0Cnn49XHlZwmT92eu2JZt6LplXMfvNTPB+VBoLw=;
 b=b4EjgdEsDaV5//rs3XDs28adyf+Aig37CxwpVFK4bjWsaPMNdISvOiinpcnj75o45yIWS+YHNa/lYMnjOZD55d7Tkz5cngwvgqZLoMede7PsBcDzUzz2+BWbW9Kp7Pgi1lbLPCn/ZNFIn9j1/wZ0/LesVwXCr4za/2U4dbB9vmg=
Received: from SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17) by
 KL1PR02MB7880.apcprd02.prod.outlook.com (2603:1096:820:13c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 03:41:31 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::13) by SG2PR06CA0185.outlook.office365.com
 (2603:1096:4:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 03:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 03:41:31 +0000
Received: from WorkStation.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:41:30 +0800
To: <ltp@lists.linux.it>
Date: Tue, 11 Jun 2024 11:40:58 +0800
Message-ID: <20240611034058.12611-2-xufeifei1@oppo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240611034058.12611-1-xufeifei1@oppo.com>
References: <20240611034058.12611-1-xufeifei1@oppo.com>
MIME-Version: 1.0
X-Originating-IP: [172.16.40.118]
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|KL1PR02MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: faad5f7d-b940-412e-04ed-08dc89c8625a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xh0GG5eF5IO3/wYbGR1YT7lc3GtbxnGw+vgdops5EtyMMiNuKlR9dTcKMYDm?=
 =?us-ascii?Q?Jt/f458F4hS0fnXIGvEB6F+yKPWu/5Z0q3u8V7YA/KELdPvFD392xZgTGOeZ?=
 =?us-ascii?Q?Pdfsati9ubtiSemu1E6z8ky9wAxb82u6jlU2Ki1Wt8QS/1s0OtMxzt45SPAA?=
 =?us-ascii?Q?8ehRORfm8hfOFJhFxF0neNahmscZw/GTbeh2KRTd3K865BVUMKomolEijY1c?=
 =?us-ascii?Q?s9b/PA3ON2MflJ9UV7p5J6GfOmDuZu7VqP4U3M8+zSHXt4lz7rPITH93uplF?=
 =?us-ascii?Q?Nilh2TB5EhrsYzpch7JM7fD3s+QhRXsXUZVE+MgXAPDDuDNpiy824tsICuIM?=
 =?us-ascii?Q?BRnuwScc/4gp0H8aSqeyUB/PZNpaQKcA0Tr/1BafZuV35IdifcWm0c9aKVnc?=
 =?us-ascii?Q?5CXtePchTQSqFshbjZCzbpHQy6SzuaZ3Yfc73Aa+Tiins2KF6YGjkhTfo3+E?=
 =?us-ascii?Q?uFqGg1cl6DEohtggpQef2DZvXE1xusmMV0hhRtMK78Td32CL4L6K4ae28flo?=
 =?us-ascii?Q?qndZTGuUeBNy3qgqRScwq4RLmeOy+HRJ/et/QzyDEn25Eaa9ZZGUIR18fP1s?=
 =?us-ascii?Q?ubbxwqVmoaTQuKbkCyV3ItEC4IGtFdGkaTCTUcygItyfe+jiWiayqNJ9hVnb?=
 =?us-ascii?Q?bMpYQlE0a9dquwzkE4nzhsa6iphnMCKlhOcibYgJ1qODpX/IDo2eOaTLx9su?=
 =?us-ascii?Q?r1S65IN/Te/9BkfDdLlmeHJhCAOGWKVl4lVX5L6UJJuwtRTT00xFtGxQLVDY?=
 =?us-ascii?Q?d0UjlzBofvfF93+x4nGLOYHT1OQN6kZIeFb1FkvXFsjSUzmiFdSCfjV2wlS2?=
 =?us-ascii?Q?O5EogfPHveLb1BEWUG7H+zhQ2HNpaDRn5oDH9sQMfEVtYUgiu1KiaP8zyFzD?=
 =?us-ascii?Q?s75R+lqbeSHsjHn0R1JtNkaxrnQZGPcqCFudy5jUXbGPWkQh4Tos9PnCnxOz?=
 =?us-ascii?Q?z+G/HEXIYAddvE4Bjp+Fw5a8RYKHTLcTpyTFoswPwrf4zIP2bHy4yMZFDYL/?=
 =?us-ascii?Q?S88Ji8LG+WViZOxNtZwljQcLYr2prir5lFYCUqIiVVShPsu8JT7UENAJcWEN?=
 =?us-ascii?Q?cW+yhff9pkiU4GRYlJmp6Fe3CzsH1ecsTIH4N2bpbX3JD3V9YYL8AituEzf+?=
 =?us-ascii?Q?i2iCqxTA/ObiWrbjhO7W+Dry5+tnrtp0EQQqD1R+SLvCB6o4cC4ZuvDNhP3l?=
 =?us-ascii?Q?vaqfoFbt7MrHDDstpmGlyoH/meY877N5HmWE9AqRSdhNE1+eT8q+N6Zyw4km?=
 =?us-ascii?Q?k6GF1WZC5pPPWDaTTF7Yv7pWHnfXko/xP2U1l16+zWJSn4gCPO7cuSPhyJKf?=
 =?us-ascii?Q?HVCL4JWBGlhRmSJu0ht8wWmyzpTIJvsHojqjDRHFsMZzPrSHLg0r+FHD/VSN?=
 =?us-ascii?Q?lwPJeFBZF6Fp750I2E88DfdrF59F9vhnb/GRswISOnC76bODUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:58.252.5.68; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.oppo.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 03:41:31.5205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faad5f7d-b940-412e-04ed-08dc89c8625a
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6; Ip=[58.252.5.68];
 Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7880
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Reduce loop count to meet need of low performance
 terminals
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
From: xufeifei via ltp <ltp@lists.linux.it>
Reply-To: xufeifei <xufeifei1@oppo.com>
Cc: xufeifei <xufeifei1@oppo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogeHVmZWlmZWkgPHh1ZmVpZmVpMUBvcHBvLmNvbT4KLS0tCiBydW50ZXN0
L3NjaGVkIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvcnVudGVzdC9zY2hlZCBiL3J1bnRlc3Qvc2NoZWQKaW5kZXggNWRh
YjdhNGMyLi4wMmE3NzA0MGMgMTAwNjQ0Ci0tLSBhL3J1bnRlc3Qvc2NoZWQKKysrIGIvcnVudGVz
dC9zY2hlZApAQCAtOSw3ICs5LDcgQEAgdHJhY2Vfc2NoZWQwMSAgICAgICAgICAgdHJhY2Vfc2No
ZWQgLWMgMQogY2ZzX2JhbmR3aWR0aDAxIGNmc19iYW5kd2lkdGgwMSAtaSA1CiBoYWNrYmVuY2gw
MSBoYWNrYmVuY2ggNTAgcHJvY2VzcyAxMDAwCiBoYWNrYmVuY2gwMiBoYWNrYmVuY2ggMjAgdGhy
ZWFkIDEwMDAKLXN0YXJ2YXRpb24gc3RhcnZhdGlvbgorc3RhcnZhdGlvbiBzdGFydmF0aW9uIC1s
IDEwMDAwMAoKIHByb2Nfc2NoZWRfcnQwMSBwcm9jX3NjaGVkX3J0MDEKCi0tCjIuMTcuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KT1BQTwoKwrHCvsK1w6fDl8OTw5PDisK8w77C
vMKww4bDpMK4wr3CvMO+wrrCrMOTw5BPUFBPwrnCq8OLwr7CtcOEwrHCo8ODw5zDkMOFw4/CosKj
wqzCvcO2w4/DnsOTw5rDk8OKwrzDvsOWwrjDg8O3wrXDhMOKw5XCvMO+w4jDi8KjwqjCsMO8wrrC
rMK4w7bDiMOLwrzCsMOIwrrDl8OpwqPCqcOKwrnDk8ODwqHCo8K9w7vDlsK5w4jDjsK6w47DiMOL
w5TDmsOOwrTCvsKtw4rDmsOIwqjCtcOEw4fDqcK/w7bDj8OCw5LDlMOIw47CusOOw5DDjsOKwr3D
isK5w5PDg8KhwqPDiMOnwrnDu8OEw7rCtMOtw4rDlcOBw4vCscK+w5PDisK8w77Co8Ksw4fDkMOO
w7DCtMKrwrLCpcKhwqLCt8OWwrfCosKhwqLCuMK0w5bDhsKhwqLDk8Khw4vCosK7w7LDisK5w5PD
g8Kxwr7Dk8OKwrzDvsOWwq7DiMOOwrrDjsKywr/Ct8OWwrvDssOGw6TDi8O5w5TDmMOWwq7DiMOO
wrrDjsOEw5rDiMOdwqPCrMKywqLDh8Orw4HCosK8wrTDksOUwrXDp8OXw5PDk8OKwrzDvsONwqjD
lsKqwrfCosK8w77DiMOLwrLCosOJwr7Cs8O9wrHCvsOTw4rCvMO+wrzCsMOGw6TCuMK9wrzDvsKh
wqMKw43DuMOCw6fDjcKow5HCtsK5w4zDk8OQw4jCscOPw53Cv8OJw4TDnMK1wrzDlsOCw5PDisK8
w77CscK7wr3DmMOBw7TCocKiw5DDnsK4w4TCocKiwrbCqsOKwqfCocKiw4bDhsK7wrXCu8OywrDD
vMK6wqzCvMOGw4vDo8K7w7rCssKhwrbCvsK1w4jCssK7wrDCssOIwqvDh8Opwr/DtsKjwqxPUFBP
wrbDlMK0w4vDgMOgwrTDrcOOw7PCu8Oyw5LDhcOCwqnCtsO4w5LDvcOWw4LDlsKuw4jDjsK6w47D
i8Oww4rCp8K4w4XCssK7wrPDkMK1wqPDlMOww4jDjsKywqLCscKjw4HDtMOTw6vCscK+w5PDisK8
w77Dj8OgwrnDmMOWwq7DksK7w4fDkMOIwqjDgMO7wqHCowrCs8O9wrfDh8ODw7fDiMK3w4vCtcOD
w7fCo8KswrHCvsOTw4rCvMO+wrzCsMOGw6TCuMK9wrzDvsOOw57DksOiw5fDt8OOwqrDlMOaw4jD
jsK6w47CucO6wrzDksK7w7LCtcOYw4fDuMOWwq7DksKqw5TCvMKhwqLDlcOQw4DCv8K7w7LCs8OQ
w4XCtcKjwqzDksOgw47DnsOSw6LDl8O3w47CqsOIw47CusOOwr3Cu8OSw5fCu8OywrrDj8ONwqzD
lsKuw5XDvcOKwr3DiMK3w4jDj8KhwqMgwrfCosK8w77DiMOLwqHCosOGw6TDi8O5w4rDtMK7w7rC
ucK5wrvDssOLw7nDisO0wrvDusK5wrnDlsKuwrnDmMOBwqrCu8O6wrnCucK7w7LDiMOOwrrDjsOJ
w4/DisO2wrvDusK5wrnDlsKuwrnDicK2wqvCocKiwrbCrcOKw4LCocKiwrjDn8K8wrbCucOcw4DD
rcOIw4vDlMKxwqHCosOUwrHCucKkwrvDssOGw6TDi8O7w4jDjsK6w47DiMOLwqPCqMOSw5TDj8OC
wrPDhsKhwrDCt8KiwrzDvsOIw4vCocKxwrvDssKhwrBPUFBPwqHCscKjwqnCssK7w5LDssKxwr7D
k8OKwrzDvsOWwq7DjsOzw4vDjcK2w7jCt8OFw4bDusOGw6TDi8O5w4/DrcOWwq7DiMOOwrrDjsOI
wqjDgMO7wqPCrMOSw6DCssK7wrbDlMOSw7LCucOKw5LDosK7w7LCucO9w4rCp8OKwrnDk8ODwrjD
g8K1w4jDkMOFw4/CosK2w7jDksO9wrfCosK7w7LCv8OJw4TDnMOSw73Ct8KiwrXDhMOLw7DDisKn
wrPDkMK1wqPDiMOOwrrDjsOUw7DDiMOOwqHCowrDjsOEwrvCr8Kyw67DksOsw4XDu8OCwrbCo8K6
w5LDssOIwqvDh8Oyw47DhMK7wq/CssOuw5LDrMOTwrDDj8OswqPCrMK1wqXCtMK/w5LDlFlFU1xP
S8K7w7LDhsOkw4vDu8K8w7LCtcKlwrTDisK7w6PCtcOEwrvDmMK4wrTCssKiwrLCu8K5wrnCs8OJ
wrfCosK8w77DiMOLwrbDlMOIw47CusOOwr3Cu8OSw5fCu8OywrrDj8ONwqzDlsKuw5XDvcOKwr3D
iMK3w4jDj8K7w7LCvcOTw4rDnMKjwqzDh8Orw5PDq8K3wqLCvMO+w4jDi8OUw5nCtMOOw4jCt8OI
w4/DksOUwrvDscK1w4PDg8O3w4jCt8OKw6nDg8Omw5LDosK8w7vCocKjwrfCosK8w77DiMOLwrLC
u8K2w5TDiMOOwrrDjsOKw5zDjsOEwrvCr8Kyw67DksOsw5PCsMOPw6zCtsO4wrXCvMOWw4LCucOK
w5LDosK7w7LCtMOtw47Ds8OKwrnDk8ODwrjDg8K1w4jDkMOFw4/CosOLw7nDlMOswrPDicK1w4TD
iMOOwrrDjsOWwrHCvcOTwrvDssK8w6TCvcOTw4vDsMK6wqbCs8OQwrXCo8OUw7DDiMOOwqHCowpU
aGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9y
bWF0aW9uIGZyb20gT1BQTywgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBv
ciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGlu
Zm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90
IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBv
ciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50LCBwbGVhc2UgZG8gbm90IHJlYWQsIGNvcHksIGRpc3RyaWJ1dGUsIG9yIHVzZSB0aGlzIGlu
Zm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIHRyYW5zbWlzc2lvbiBpbiBlcnJv
ciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJlcGx5IGUtbWFpbCBh
bmQgdGhlbiBkZWxldGUgdGhpcyBtZXNzYWdlLgpFbGVjdHJvbmljIGNvbW11bmljYXRpb25zIG1h
eSBjb250YWluIGNvbXB1dGVyIHZpcnVzZXMgb3Igb3RoZXIgZGVmZWN0cyBpbmhlcmVudGx5LCBt
YXkgbm90IGJlIGFjY3VyYXRlbHkgYW5kL29yIHRpbWVseSB0cmFuc21pdHRlZCB0byBvdGhlciBz
eXN0ZW1zLCBvciBtYXkgYmUgaW50ZXJjZXB0ZWQsIG1vZGlmaWVkICxkZWxheWVkLCBkZWxldGVk
IG9yIGludGVyZmVyZWQuIE9QUE8gc2hhbGwgbm90IGJlIGxpYWJsZSBmb3IgYW55IGRhbWFnZXMg
dGhhdCBhcmlzZSBvciBtYXkgYXJpc2UgZnJvbSBzdWNoIG1hdHRlciBhbmQgcmVzZXJ2ZXMgYWxs
IHJpZ2h0cyBpbiBjb25uZWN0aW9uIHdpdGggdGhlIGVtYWlsLgpVbmxlc3MgZXhwcmVzc2x5IHN0
YXRlZCwgdGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBhcmUgcHJvdmlkZWQgd2l0aG91
dCBhbnkgd2FycmFudHksIGFjY2VwdGFuY2Ugb3IgcHJvbWlzZSBvZiBhbnkga2luZCBpbiBhbnkg
Y291bnRyeSBvciByZWdpb24sIG5vciBjb25zdGl0dXRlIGEgZm9ybWFsIGNvbmZpcm1hdGlvbiBv
ciBhY2NlcHRhbmNlIG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250cmFjdC4gVGhlIHNlbmRlciwg
dG9nZXRoZXIgd2l0aCBpdHMgYWZmaWxpYXRlcyBvciBhbnkgc2hhcmVob2xkZXIsIGRpcmVjdG9y
LCBvZmZpY2VyLCBlbXBsb3llZSBvciBhbnkgb3RoZXIgcGVyc29uIG9mIGFueSBzdWNoIGluc3Rp
dHV0aW9uIChoZXJlaW5hZnRlciByZWZlcnJlZCB0byBhcyAic2VuZGVyIiBvciAiT1BQTyIpIGRv
ZXMgbm90IHdhaXZlIGFueSByaWdodHMgYW5kIHNoYWxsIG5vdCBiZSBsaWFibGUgZm9yIGFueSBk
YW1hZ2VzIHRoYXQgYXJpc2Ugb3IgbWF5IGFyaXNlIGZyb20gdGhlIGludGVudGlvbmFsIG9yIG5l
Z2xpZ2VudCB1c2Ugb2Ygc3VjaCBpbmZvcm1hdGlvbi4KQ3VsdHVyYWwgRGlmZmVyZW5jZXMgRGlz
Y2xvc3VyZTogRHVlIHRvIGdsb2JhbCBjdWx0dXJhbCBkaWZmZXJlbmNlcywgYW55IHJlcGx5IHdp
dGggb25seSBZRVNcT0sgb3Igb3RoZXIgc2ltcGxlIHdvcmRzIGRvZXMgbm90IGNvbnN0aXR1dGUg
YW55IGNvbmZpcm1hdGlvbiBvciBhY2NlcHRhbmNlIG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250
cmFjdCwgcGxlYXNlIGNvbmZpcm0gd2l0aCB0aGUgc2VuZGVyIGFnYWluIHRvIGVuc3VyZSBjbGVh
ciBvcGluaW9uIGluIHdyaXR0ZW4gZm9ybS4gVGhlIHNlbmRlciBzaGFsbCBub3QgYmUgcmVzcG9u
c2libGUgZm9yIGFueSBkaXJlY3Qgb3IgaW5kaXJlY3QgZGFtYWdlcyByZXN1bHRpbmcgZnJvbSB0
aGUgaW50ZW50aW9uYWwgb3IgbWlzdXNlIG9mIHN1Y2ggaW5mb3JtYXRpb24uCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCk9QUE8KCuacrOeUteWtkOmCruS7tuWPiuWFtumZhOS7tuWQ
q+aciU9QUE/lhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7pgq7ku7bmjIfmmI7nmoTm
lLbku7bkurrvvIjljIXlkKvkuKrkurrlj4rnvqTnu4TvvInkvb/nlKjjgILnpoHmraLku7vkvZXk
urrlnKjmnKrnu4/mjojmnYPnmoTmg4XlhrXkuIvku6Xku7vkvZXlvaLlvI/kvb/nlKjjgILlpoLm
npzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzliIfli7/kvKDmkq3jgIHliIblj5HjgIHlpI3liLbj
gIHljbDliLfmiJbkvb/nlKjmnKzpgq7ku7bkuYvku7vkvZXpg6jliIbmiJblhbbmiYDovb3kuYvk
u7vkvZXlhoXlrrnvvIzlubbor7fnq4vljbPku6XnlLXlrZDpgq7ku7bpgJrnn6Xlj5Hku7bkurrl
ubbliKDpmaTmnKzpgq7ku7blj4rlhbbpmYTku7bjgIIK572R57uc6YCa6K6v5Zu65pyJ57y66Zm3
5Y+v6IO95a+86Ie06YKu5Lu26KKr5oiq55WZ44CB5L+u5pS544CB5Lii5aSx44CB56C05Z2P5oiW
5YyF5ZCr6K6h566X5py655eF5q+S562J5LiN5a6J5YWo5oOF5Ya177yMT1BQT+WvueatpOexu+mU
meivr+aIlumBl+a8j+iAjOW8leiHtOS5i+S7u+S9leaNn+WkseamguS4jeaJv+aLhei0o+S7u+W5
tuS/neeVmeS4juacrOmCruS7tuebuOWFs+S5i+S4gOWIh+adg+WIqeOAggrpmaTpnZ7mmI7noa7o
r7TmmI7vvIzmnKzpgq7ku7blj4rlhbbpmYTku7bml6DmhI/kvZzkuLrlnKjku7vkvZXlm73lrrbm
iJblnLDljLrkuYvopoHnuqbjgIHmi5vmj73miJbmib/or7rvvIzkuqbml6DmhI/kvZzkuLrku7vk
vZXkuqTmmJPmiJblkIjlkIzkuYvmraPlvI/noa7orqTjgIIg5Y+R5Lu25Lq644CB5YW25omA5bGe
5py65p6E5oiW5omA5bGe5py65p6E5LmL5YWz6IGU5py65p6E5oiW5Lu75L2V5LiK6L+w5py65p6E
5LmL6IKh5Lic44CB6JGj5LqL44CB6auY57qn566h55CG5Lq65ZGY44CB5ZGY5bel5oiW5YW25LuW
5Lu75L2V5Lq677yI5Lul5LiL56ew4oCc5Y+R5Lu25Lq64oCd5oiW4oCcT1BQT+KAne+8ieS4jeWb
oOacrOmCruS7tuS5i+ivr+mAgeiAjOaUvuW8g+WFtuaJgOS6q+S5i+S7u+S9leadg+WIqe+8jOS6
puS4jeWvueWboOaVheaEj+aIlui/h+WkseS9v+eUqOivpeetieS/oeaBr+iAjOW8leWPkeaIluWP
r+iDveW8leWPkeeahOaNn+WkseaJv+aLheS7u+S9lei0o+S7u+OAggrmlofljJblt67lvILmiqvp
nLLvvJrlm6DlhajnkIPmlofljJblt67lvILlvbHlk43vvIzljZXnuq/ku6VZRVNcT0vmiJblhbbk
u5bnroDljZXor43msYfnmoTlm57lpI3lubbkuI3mnoTmiJDlj5Hku7bkurrlr7nku7vkvZXkuqTm
mJPmiJblkIjlkIzkuYvmraPlvI/noa7orqTmiJbmjqXlj5fvvIzor7fkuI7lj5Hku7bkurrlho3m
rKHnoa7orqTku6XojrflvpfmmI7noa7kuabpnaLmhI/op4HjgILlj5Hku7bkurrkuI3lr7nku7vk
vZXlj5fmlofljJblt67lvILlvbHlk43ogIzlr7zoh7TmlYXmhI/miJbplJnor6/kvb/nlKjor6Xn
rYnkv6Hmga/miYDpgKDmiJDnmoTku7vkvZXnm7TmjqXmiJbpl7TmjqXmjZ/lrrPmib/mi4XotKPk
u7vjgIIKVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlh
bCBpbmZvcm1hdGlvbiBmcm9tIE9QUE8sIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBw
ZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9m
IHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywg
YnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVj
dGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVk
IHJlY2lwaWVudCwgcGxlYXNlIGRvIG5vdCByZWFkLCBjb3B5LCBkaXN0cmlidXRlLCBvciB1c2Ug
dGhpcyBpbmZvcm1hdGlvbi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyB0cmFuc21pc3Npb24g
aW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBieSByZXBseSBl
LW1haWwgYW5kIHRoZW4gZGVsZXRlIHRoaXMgbWVzc2FnZS4KRWxlY3Ryb25pYyBjb21tdW5pY2F0
aW9ucyBtYXkgY29udGFpbiBjb21wdXRlciB2aXJ1c2VzIG9yIG90aGVyIGRlZmVjdHMgaW5oZXJl
bnRseSwgbWF5IG5vdCBiZSBhY2N1cmF0ZWx5IGFuZC9vciB0aW1lbHkgdHJhbnNtaXR0ZWQgdG8g
b3RoZXIgc3lzdGVtcywgb3IgbWF5IGJlIGludGVyY2VwdGVkLCBtb2RpZmllZCAsZGVsYXllZCwg
ZGVsZXRlZCBvciBpbnRlcmZlcmVkLiBPUFBPIHNoYWxsIG5vdCBiZSBsaWFibGUgZm9yIGFueSBk
YW1hZ2VzIHRoYXQgYXJpc2Ugb3IgbWF5IGFyaXNlIGZyb20gc3VjaCBtYXR0ZXIgYW5kIHJlc2Vy
dmVzIGFsbCByaWdodHMgaW4gY29ubmVjdGlvbiB3aXRoIHRoZSBlbWFpbC4KVW5sZXNzIGV4cHJl
c3NseSBzdGF0ZWQsIHRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgYXJlIHByb3ZpZGVk
IHdpdGhvdXQgYW55IHdhcnJhbnR5LCBhY2NlcHRhbmNlIG9yIHByb21pc2Ugb2YgYW55IGtpbmQg
aW4gYW55IGNvdW50cnkgb3IgcmVnaW9uLCBub3IgY29uc3RpdHV0ZSBhIGZvcm1hbCBjb25maXJt
YXRpb24gb3IgYWNjZXB0YW5jZSBvZiBhbnkgdHJhbnNhY3Rpb24gb3IgY29udHJhY3QuIFRoZSBz
ZW5kZXIsIHRvZ2V0aGVyIHdpdGggaXRzIGFmZmlsaWF0ZXMgb3IgYW55IHNoYXJlaG9sZGVyLCBk
aXJlY3Rvciwgb2ZmaWNlciwgZW1wbG95ZWUgb3IgYW55IG90aGVyIHBlcnNvbiBvZiBhbnkgc3Vj
aCBpbnN0aXR1dGlvbiAoaGVyZWluYWZ0ZXIgcmVmZXJyZWQgdG8gYXMgInNlbmRlciIgb3IgIk9Q
UE8iKSBkb2VzIG5vdCB3YWl2ZSBhbnkgcmlnaHRzIGFuZCBzaGFsbCBub3QgYmUgbGlhYmxlIGZv
ciBhbnkgZGFtYWdlcyB0aGF0IGFyaXNlIG9yIG1heSBhcmlzZSBmcm9tIHRoZSBpbnRlbnRpb25h
bCBvciBuZWdsaWdlbnQgdXNlIG9mIHN1Y2ggaW5mb3JtYXRpb24uCkN1bHR1cmFsIERpZmZlcmVu
Y2VzIERpc2Nsb3N1cmU6IER1ZSB0byBnbG9iYWwgY3VsdHVyYWwgZGlmZmVyZW5jZXMsIGFueSBy
ZXBseSB3aXRoIG9ubHkgWUVTXE9LIG9yIG90aGVyIHNpbXBsZSB3b3JkcyBkb2VzIG5vdCBjb25z
dGl0dXRlIGFueSBjb25maXJtYXRpb24gb3IgYWNjZXB0YW5jZSBvZiBhbnkgdHJhbnNhY3Rpb24g
b3IgY29udHJhY3QsIHBsZWFzZSBjb25maXJtIHdpdGggdGhlIHNlbmRlciBhZ2FpbiB0byBlbnN1
cmUgY2xlYXIgb3BpbmlvbiBpbiB3cml0dGVuIGZvcm0uIFRoZSBzZW5kZXIgc2hhbGwgbm90IGJl
IHJlc3BvbnNpYmxlIGZvciBhbnkgZGlyZWN0IG9yIGluZGlyZWN0IGRhbWFnZXMgcmVzdWx0aW5n
IGZyb20gdGhlIGludGVudGlvbmFsIG9yIG1pc3VzZSBvZiBzdWNoIGluZm9ybWF0aW9uLgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
