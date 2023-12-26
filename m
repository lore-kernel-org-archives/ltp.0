Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E03C46CD3
	for <ltp@archiver.kernel.org>; Tue, 26 Dec 2023 15:11:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8BB23CD427
	for <ltp@archiver.kernel.org>; Tue, 26 Dec 2023 16:11:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 021143C9727
 for <ltp@lists.linux.it>; Tue, 26 Dec 2023 16:11:38 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A1EA61A004A4
 for <ltp@lists.linux.it>; Tue, 26 Dec 2023 16:11:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUY/yhy2tWMlP85Ql5m+QICwRwC+wNsLSDeZ0xn6mUEg1KkD3lx8rvFBKPZ0a2n8Xy+7ghIU7K/+va8Op+bP0WH9q0cFJD8MQdNQWukzSsWVK4w/PeQPA2yCaC6UtJ7AvOWdEnma+49VAV1267P2NkJ+v6IIgQ/WnEiKHo/SgH/jFttwB+1l66MsE/li5/oc8M6dyGofk+jbi/nVcFaqH5w3fjlpJBKgqKDMsfY3uM88sPXUZbw4drnnjBO84pUg0Rj8ethgWuBwpFGzNtvvzxZtDKPX1kGzNL2KumpPvPeiEkPI3DuuEc/gOwUdhx2ue7tvS0bwnBQra02oEyRlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4h4vI9CJYA1H8PJO23uZCf20VsBMwQ9cSD/yg/9dIE=;
 b=S274xVTSxMEpMcvz+7bJo/10ygrlIkOBRHPmyOq6CUmHusKc9+1H5k5lNqSolMjz797Drs1mqSGJVww5IQhGmBuxCrMwHrbJRlxZwpCMhWe+0fj04wJfcrRo+TUA/XCzZbY82fvW4m/Bupqk8i9Td1+YM5gwpff+PJ7VYaWG5q6d1IMVSzzKN+AxMEBFgIU1WnAGZCQeTlEYi8DNLj9w2qobIN5oXUGLh1rsr696DvdZGJ3vpPeH0ldL/pKTQEM8Sum74h0bczEPXopGcgtM0gT2EGuF3coKo3h3JTmwTLYXTfTj0bzs04EBAmmTy5AGmNXWjgqZOH9uXYHtbkDMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4h4vI9CJYA1H8PJO23uZCf20VsBMwQ9cSD/yg/9dIE=;
 b=LSA9todNwEIOlCMe4kTMrlEzoM/Vg6dg3Thoq1w8CtN2YeZH7yaYDwbCxS9U2+MCJActAsrkTMfpL4LbclQqe4lJhS1PgvgGx1oitRWIYJjKowPhKjtniW8vo6MEzfK8mzSJ2Ku6bpC7reuHUgb2KqLBGg8/zSFricG3ztQSNGREVMovikk6rCP9sCVx7lg7XBeXChn2RoHxmaDSkkkXf56lYEqGZcRnwjugGQVAElGV6s8mcrW7qEXf/7vmUpgr743wRyTuG6T89cPXvT2aj4Xd06sPwLOxP3kNfKH5YbepQMr6LKe1egf/qvcx5jeHIzWqI3/Iv5ZX8jXhGVHuQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM8PR04MB7859.eurprd04.prod.outlook.com (2603:10a6:20b:24c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 15:11:35 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 15:11:35 +0000
Date: Tue, 26 Dec 2023 10:11:26 -0500
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZYrtHnaYJLmyplj5@wegao>
References: <20230913101542.18550-1-wegao@suse.com>
 <87zfzga7xj.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <87zfzga7xj.fsf@suse.de>
X-ClientProxiedBy: TYCP286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::14) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM8PR04MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0a16ad-0fce-409f-123d-08dc0624f34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKYYv2Pe9Mbl/i+GsFKgolYUWrx71rJ0dxZ0mW7zr5LhvNFNN+lijO65xLSWshT87lUvKERT/odjx9UI3FgViDn0BFtQ5skiuZjL6qHq/hlEjapKhqCTLyrYIur3fZqq2X77pEQbvBt+rGboOW1z9qWV5WVmusOU2Qhh6b961VNx3ir/RMYECrtBocueFp/D7nvm+hCSrD8/oVM32YeJTidusyYp/Z03FRg0RwEZdVsVboneuh+KMGmrrNZHQ6DB0P5eq/G2+rOkTszzUAdKXXxfVgTFlWvR7zDBaLJHk4aY3hubUwVYJrckQaOV+MuL+oQ+v/RlHlR7MCTxf3I3SBhaL7pPSl0SPBE11/9scACzEOSrRNNZ/u7vlhHWYZN49M7BnBmv9IsOJm8R+efe4Vzmrgu4D8Vz/AhEoOYlYZe/NmriWsY54icXHzLVu3LcZCbZwen2Gtn4A+O/4bvckJLwxp1tBnP6Aqy6aIsdkMB+bc6YjyBVSNfY1zjKFcNv2n1mQ3UXhRZ4zo8NSRMPGqekqoMSaXmdJGZnLQPDMgLXu2AMecj5EBmuV229xBVB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(396003)(366004)(39850400004)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(4744005)(2906002)(478600001)(26005)(38100700002)(6486002)(41300700001)(86362001)(33716001)(316002)(66476007)(66556008)(66946007)(6916009)(9686003)(6512007)(6666004)(6506007)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jC8hF/AOIgzsVtwaZa7u7IwnGhRrQSfHBIgTpSZ/oSbZVrK5RJy1t0Sx2kh?=
 =?us-ascii?Q?F/ogk9AiaCBF59ZJ22RH7c3fCy7FoWhF56wOFyA0OpPvKqqbcBIREe/GnMaP?=
 =?us-ascii?Q?5ZbVixxZxydCAtnFrV4U4wDA+Ctt9IRY83h0RVgpgdGCCpE8hhhtwDvIZ2yR?=
 =?us-ascii?Q?/zNoj5OnYgNHMsSTP4VpRV3jRcTOqRWnpNDDXv9CX5hPZ3qY0PpK5i5Q856Y?=
 =?us-ascii?Q?Rf8P7g5KvH9c/BZxBD+N10ITuvLp2pOKE3Bwwp6h11VZr0CIcYp14KQxgYMk?=
 =?us-ascii?Q?Yk2IIOAC0INgQD81fwnv/hceCC5mr2rTmEcpD+IzzkG6fpnk+HeqZ5702WMw?=
 =?us-ascii?Q?2gp7S20gP1HkFzWjsV4rVoJvp4vNaXfAP/mTaAEXf2rS8U3HZlAc1lK5ribS?=
 =?us-ascii?Q?loONF2w/1i0AWxZ+vSXte77Dv2gshWjDElmVHBcGQtK6yJ8X2d4Nz0gBMOmW?=
 =?us-ascii?Q?xC9N6P1UYeaODwZiGD6SS/pZgj2TLDTJGiAzYOM3cswY45px/P5rS6gYV3wM?=
 =?us-ascii?Q?dQhlbML+n23wp7L9VK10EqiXVzwiyuwllDZrDoKuNvAv4OTc3z/Fej4zLD8U?=
 =?us-ascii?Q?xIygQVQcA+/blfvtnqI4axeGnA9h/naCou7HnlgKBwJChpvNJyFBln5LcdyH?=
 =?us-ascii?Q?x/xh9OJvDOqMba6lTknFHA81fUmRl7y2P4UrF0xR+Y3/TxjuGJenEQuFIPUZ?=
 =?us-ascii?Q?/nfBPuZ8lk3Lla2Hj9AmhlFo/ULydz5n3VWwUXy6RPoB2cRijSKe+WLE/cs+?=
 =?us-ascii?Q?E+dsALOZPp47tSbVtV/4Og6hFOgnCM5gGzQXztTsZYz3uCO/nA4v8lNGbpHI?=
 =?us-ascii?Q?6yXoAZHnppfjZ32HjduKxOROx3qhQlimX2Nb9RPKwZUOHu+DJQfTi5TJPXyq?=
 =?us-ascii?Q?JJXbopDhVbhYz0TwMbXQQ+MfZpxU8y0+oakliV0hCG/4eVmUN3PJRv9aB1P5?=
 =?us-ascii?Q?6smWlaseUzZpePvS02ZZtaaQC0nt4ESTc4HD6C41fnyGP5Ia8uAUuGEA9IT4?=
 =?us-ascii?Q?4IEPIzRWe/Eds8BMA5qGkZQ3hD0NSIO5goWPFdsoh99GyLUVCw0OCUklXEt1?=
 =?us-ascii?Q?tNsaAEK8T7+2JwCwhoQ/Zfj8ufTrg6nA/KBsos3AKy0Vd+YPAfKm6dt6sevo?=
 =?us-ascii?Q?HotslsDdhEl8JUcjXsYIWEo9wfLTOBqN1WMsoXnuY6L/fU+QZ52CFfBRShEV?=
 =?us-ascii?Q?CJaFYO4SCQ2SziFYyYnpvN/7c2pQIbo9hP8o76jmkoHzIFNtwZHp5I/20tbT?=
 =?us-ascii?Q?pIuALmJH+UVFWxOPZCvZrxv52C5LbkEaYOM32wm1GYodntcswJddaRunuhV5?=
 =?us-ascii?Q?6qgizgDawMDOyraw4tfSZ9aaYR6h8GtFODMJZhO05VGh1/kyy/yNuSMFCJM6?=
 =?us-ascii?Q?C/Mt38c9/tVc0W0X5P153X8Y5QTV4n58jrFT7EGYfjyfi1HlJLBQrPwKxiY6?=
 =?us-ascii?Q?TTTRvHnRNhSDaLxa0mJHfw5QLrFbiGBLkPVFfiN1xskr/yUtyibVQCiINwk6?=
 =?us-ascii?Q?b9fBnYuvYMCw5HFu+eBrllFYJ2L0oh80f12l0dKiYCaKG+u6njBNblLq95FI?=
 =?us-ascii?Q?2bXT7v1PAuFTzfE2/6U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0a16ad-0fce-409f-123d-08dc0624f34f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 15:11:35.2634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIoaO+kdXgOxxpqZL/RfFanCdm3FGN3DNcbs1a3Uq9zMBViaM+T+yfv5nAVVgm9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7859
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] move_mount03: check allow to mount beneath top
 mount
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 14, 2023 at 09:17:15AM +0000, Richard Palethorpe wrote:
> Hello,
> 
> Wei Gao via ltp <ltp@lists.linux.it> writes:
> 
> This should at least reference the following commit:
> 
> commit 6ac392815628f317fcfdca1a39df00b9cc4ebc8b
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Wed May 3 13:18:42 2023 +0200
> 
>     fs: allow to mount beneath top mount
> 
> To be honest I am struggling to understand what all of this
> does. However I think that I found some issues with the test which I
> have noted below.
> 
Thanks for your pateint review, i also spend a lot of time to recall
my memory for this test case, so i decide to reconstruct this test case
with heavy comments to introduce how this feature work and give every
explaination for each step of test case.
> 
> 
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
