Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992ADEB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:31:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A91F3CE0FB
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 14:31:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F257A3CACC1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:31:30 +0200 (CEST)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 58EC51000191
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1687264287; x=1718800287;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=q4EiyqkX542OflVv2lGDakzz5TC2Vf4Bsj0DIGPmJq0=;
 b=FJV6m0fRwyK7P1NombpJj5kUeaPxZS76Wt/HiaQwBN9Q5VLBz4S3VxB0
 Xck5+I3rwuHUFMOLoIe4cpW8LbVrX0wO0GnSRMW75XWFuqX1SApYUQBja
 xoEdWsTzT2KvLEf8LGzC2MdI4QzCQjXNXpVxNM/hoBS4KOvQWhQndSdhl
 kw74G3fzD2csYmWlcleIi9VcLp+/QhPWDyu/MsE5HwdQfJ+kj681pXkyV
 RAFqyaDngbDcYKu19TN2XOmFFFPG2i5N9h8a3Iw5rfVbL11aPwnaGZU+f
 QdTp0JwUdj0RDPbSkQ8+VFXFub7jgY91b2ryruj091HoqNMnil8HC4Kzt Q==;
X-IronPort-AV: E=Sophos;i="6.00,257,1681142400"; d="scan'208";a="347922959"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 20:31:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jon2AzV/t0EY/VlKBDISvj5rTZQ5DhsAgJUbDHKJ+lAnZPj+iFT9xuA9THwsf730MBaarvotN455kxyDh3LPuifp0mmqLRAVJiuNRpSohDtMrba7MObH/lj1WVMhtazjxnNmDYu5k/6kF6Lx4tDIqQ7lXi24h7D5ki3y0y8KU1QQfyYGuhBM9CBxuf8798f6gHlJ5FjbR+MxQBAY5GImYZyed4/RJiTA3vY5w5ePetHAxpnGvYLsv9llai/QIVBIJ4W9u+6o/vFm1ttVyzPs9lC4POmPPtMm5DeD6HuBenOHXmh/K8JBm+FClhNsUd1gX4oUMycASiGKQSQLxQNUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4EiyqkX542OflVv2lGDakzz5TC2Vf4Bsj0DIGPmJq0=;
 b=awfvEtAyMHnK6+DhQl+QZkXHImaEJvVD3j/R1JwqAXpucW4IEkfoIeUj4kpkQ0+BsmX5iljlvPnOwNpMenhJuveAIYkkYTqNVNeBnNaPBPnIOuQ0mrM9nyvqLyFOiaD53WZ61updmOvEAfN/97zH7WmURkwbf8TFPgI5iGXGqzB/ou5JWshdQ5cjC7evCXB4pf92ekx6PLgFWYyYdI5qbY5ClWkHUNQQmCZ00z9hYhEuwvRunkIq9dPSvk+59NpX9j5Zg+GannBfidzAc/2Mk4imSmjWvbF5c5mPRrdOoMDCHmayeH3yOaaGqdmxwd6AGZ5zq687ulFg/rpq+NgRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4EiyqkX542OflVv2lGDakzz5TC2Vf4Bsj0DIGPmJq0=;
 b=uFgm9rMAm5wJyO4wByM+x1SpgwKEAPJCg/dQj0+tK77WFWqwoNNIGGKvFJ2Z1j4gOuS04ZeOe17MaWTsS5zEsxdl33w6f1w9OMrclJh71ufnRKx4fQcgABlqM2G10G4Os5LXTM2lTUTqBk7h1cm00vEap/7dg1UXkX6N1eDgkhs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB6726.namprd04.prod.outlook.com (2603:10b6:610:95::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 12:31:18 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:31:16 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 1/3] ioprio: Move fallback constants and structs to LAPI
 header
Thread-Index: AQHZo28KZ/JVEOGVZEuTQ1y8B+0eNa+Tn1YA
Date: Tue, 20 Jun 2023 12:31:16 +0000
Message-ID: <ZJGcElHQ5x0FydNP@x1-carbon>
References: <20230620120159.320052-1-pvorel@suse.cz>
 <20230620120159.320052-2-pvorel@suse.cz>
In-Reply-To: <20230620120159.320052-2-pvorel@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB6726:EE_
x-ms-office365-filtering-correlation-id: 1701285c-957d-46ba-59e4-08db718a3de8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFtD6qEp7xlECpqTH/ssa6Ajaenyl8+ZU0SUazzmQ/H9XS1Uf0SAK9XThHfDMQvD1zeXbQOuePFjeKGtdZOiLyyFvvRAltlzMrmnEN/JAaIXMyjqK2QNgur6dtZEDjgIwKfHSYcfRADrCNnZazC9b4w5JKKc/yUiN8d0o61oUVU0HRBujA568DA89WklLcnxHpIpAAr95iXAePd5mZQP3BP1GV0eohFsGC0jaIN/2RTLmPzTzUSgT24s1mSL7at+Zz+KXCZtYuGfMPhu/F9vqX1/kQFaapV+J/iw0jdQBqkC/JrY+sjYSh7OAjDADN1yF4R8es8GpWZgi2hO/Lv/+Yn5D5RUUcTshRldqqvjCbEG9XpyAOiZVv4J4CuqtGBTft5uKVtE0l3lP/0ZTXfZdt5HIBBvaRv5GrSe3PNAmceaKKu5vjV67Jg4ER3pDhuAoPZFYgEWAbY0D7lcc3OvZeiFv7afjjINcrO/Hq1hfE2ml7/dh+hiOVZCgiTJ8fTLqvBc1ibXo4B9k6xj8WoeiKQlyWENmfjChBHs0EteDVAuqy92V5idg/Eg3GW2/niLuwDu5by0IIcikzlIdyV0Brfw/pLcbMmclWbFxdKc1GlkgeONzUV3mcFLwBPIelM2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(6486002)(478600001)(71200400001)(54906003)(6512007)(26005)(6506007)(186003)(9686003)(2906002)(4744005)(5660300002)(33716001)(38100700002)(122000001)(91956017)(4326008)(76116006)(66946007)(82960400001)(316002)(8936002)(8676002)(41300700001)(66476007)(6916009)(86362001)(66556008)(64756008)(66446008)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PPD5w69KrnnV10vruxcbCcYjDhDhS3GHrnI4IlPy/ziD+Bu5mMkcPkH3vLtq?=
 =?us-ascii?Q?A/91R2NJW+LaRUHtY5rrseCcB9MBOJ0/twNseZKpiDy2VxS0Z9CsiZ2Nw22q?=
 =?us-ascii?Q?SqVfEng5NuwfiEqDC6x7kTIPvR/TRcBYU0rqoua/ZSw7C+6FS0dQg3XkHhpU?=
 =?us-ascii?Q?yA8JU7X/UEXvL1HkfFh6m8PbpNaRtHBUXIdqZHzI7b4HWa6h/pDJo8dC0nEb?=
 =?us-ascii?Q?fSeVxmoBzdR99jDz+DqkS+ZBCx95DO6MdtOg0TO647xW0dEM4E4AsGRSOG7E?=
 =?us-ascii?Q?yMig3dgEvl9kaf6oUEav2eVPO1C+OtUiQS/pzecf91waasv8eIY0cfobosoy?=
 =?us-ascii?Q?sg+tc/q79l1D1m2Qjj3mxoTMIWsvHmGNUeBQHk2hMqDrxAVJPwzydcjQKqoZ?=
 =?us-ascii?Q?NgJ1KF3u504PM5eIzdsPYEuAusXHuDs6cw1e30ttAwKMjy+oGL1DZdcEm7x5?=
 =?us-ascii?Q?ZgkcfeR2dM2Y++EBmFWto8A6V/QXevD/tFTXxGFG/th5Bfv1/jhifJHevss2?=
 =?us-ascii?Q?ErICGHRt7hYVfAYSIJshW3slFad7nWe/UuyiU7vUiehEMTYxLfKwR2wnRizc?=
 =?us-ascii?Q?kDyIGBzZck1t6Y4EGXUpzkvze5B96oDsDPuv7hqBTpgVs72BrQ1W4q+zUf8v?=
 =?us-ascii?Q?qSY9fLjnACS0ofMffzjQu3fVgC7qh9WElTSRHJH0T3Qx5S9crzoj4kVa+DUq?=
 =?us-ascii?Q?iNJuEv8T5uEdOiOh1uTb4I7QBGg6PudeAVbThOxi3xc1DDNJMmUUu99wBkOl?=
 =?us-ascii?Q?iriRZb5hibpqwQKw0C8lm8v904YaPMntOUle4OCtGQOwVegQEKk4Cn9u5Baq?=
 =?us-ascii?Q?fmrCPH9f9FQY/DwU8kTC8kaqYO9osSOUwTlajKi7OgkT9gZMnc+vOSOPQJUX?=
 =?us-ascii?Q?9TY3D2rWG11f3fhPrgJuC8hBowpL1oXnXefXVy91FuAZkl7UTD9T7Q0tPlQG?=
 =?us-ascii?Q?7dgqrk0dy9q3A7R/I5vcmYQ257xz9cKymPcrAneYuUvgSH04y04jKJBgTp3k?=
 =?us-ascii?Q?/8tTeASxjkh2jDaYruJJMWXIzak8Gp/WI/evjk0XffTPja/wHaw6D4s+ghMy?=
 =?us-ascii?Q?AQwjPaSXfpyEEgQsz3zx1DpuF7VU62ZTgXfafePv3qd/Mf2CzBOCNyDVYSnm?=
 =?us-ascii?Q?uyQDT79jFoiGxOvH5Nmf0Ey0++DwukXlRDHArnaCRlq12a7kJiiwAbhy5Pfd?=
 =?us-ascii?Q?ABDa5lZTG10aSmbkfEHu5jswsre3zcbqb2gUb/dZNtSi4P9XpWmSrzIzOFBg?=
 =?us-ascii?Q?JyFkk3due4O0PJ0tri6uw08qklHMHTFtX51qIYk+KB7NLxc8zoSlSQVbRlIx?=
 =?us-ascii?Q?umoW+iherYQSp3Wb9hSEXl+oo0PADWpUinasTii+h+IlZCi57PAkFxnuubmq?=
 =?us-ascii?Q?E1UxTn5EfeQzr20qGRQcOKhr/9t7LBPy+clwugRaXClE3yMpEYG4Bx51VaUA?=
 =?us-ascii?Q?lhI9dKMKntlw8swqvMPu/4YrqIKnalMaKU3bTxwhA8kgfxAxpRzxrJK4uT1T?=
 =?us-ascii?Q?+yuVWYBexLt3Xj2ECgmAYxzM1pbSssmLQYwQAkSY2+L2GUGeb8csTZPPGs3W?=
 =?us-ascii?Q?Beu31wiWITe2JeLSxG/0Hiy3/k5hiyaKKoJuGGYlVLkNxM5qIDHAodtXIilH?=
 =?us-ascii?Q?9g=3D=3D?=
Content-ID: <F04A089C81064140B8D5D6487919D838@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7ai7X2KTrcMYrbp4n0O3NMWSbNPQOIqo24rqvlw+RBU7HdDaDHtRjvbaxSXO/uJipdhcu/0L+JogCIJ0tyQ0nAM44eeoKKFqCCgc2f3u8iuE/zHHnR34rHmvY/IptKyea3PTc/3gkp7lqcKeH0S+iFzQkR8HilXgAVGLYzn4n61wFM+LSpQVAwaYzQ/MGYog43tFfuDlZlnnRy7/p8FkiY0JnaU1NjXQx7I425+qzcstOIP4F62r8FbX0ANS9TlhId+tGdtftSnnKAs7gaxo9hsPkuQRQrg1neeLS1NanLk4w5Uh3jF6lg8m5CNa98ryjlw0Mfgpm4Gt2ff9XWr6eOcNFYmcAN68ZKdx5ZKfcP1oJTn8LgXeTDrbJLDetFsnaI53FNDJzfzoqu9oZyoLG9iOzHE53wjPcrMv8py8NVAYz9VAA5IG4v7DRS/THsWELA1+za16pNC4Fh68b0YJPypnNPO9fwQ2xpZZD0+5L5MUQk6yvURj9l55gbbP/c2Viof55EYXyG6aYo1Uu+w/VS9tfXczBjBGRLYdlORbBVp1S8ApcCc0Wf4kJizb6Rd325CtEJS0/USYq9t2dIZ0iMH+cQcJ0LxM3Sx9T9sdNcBXBYY88wzzXGt+QMdSUqruqZ2rnBFGxZphl4cJd4y2dZpZVCDDKQRK78xDPknkp+app7URArgmM5oxT3Colq53zCTeVkE75NjNz/SdxIaTy8oVgtu4hGMhxhBY2mYGihN47OKRPgvSXuRn61VoYVDtSga4HVXUBWmH5Vlks25VFcCCYDVTFp5KE5Y/+ZRkSRz1Lw5lMzZqWYUZH9MmMXOR/tBg7PgXbMIbrrc0/fG+LmX/R8EkQrfs3dTeo4RBtpc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1701285c-957d-46ba-59e4-08db718a3de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 12:31:16.0891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSpwY685jqzeQWUfIbxmHF+hZZPDoxVEBz4C8GeN85ytBlgi0TY535UImhNb0bg8qrLmwDI5Zb2nUYSlr2yBjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6726
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioprio: Move fallback constants and structs
 to LAPI header
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
From: Niklas Cassel via ltp <ltp@lists.linux.it>
Reply-To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 20, 2023 at 02:01:57PM +0200, Petr Vorel wrote:
> Originally lapi headers were only for common headers, for fallback
> constants and structs usable only in test for particular subsystem,
> we mix them together with other helper functions in header placed in the
> test directory. But later we started to move to lapi also these
> fallbacks (e.g. fanotify.h in a05dbc4fa).
> 
> + Remove unused headers in the tests.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
