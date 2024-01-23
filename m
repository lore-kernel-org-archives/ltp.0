Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A516C46CD2
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 02:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705976403; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ro0nnPH2c230OdB3nVIDFlRf1jTULMHB8rEdNOMF50I=;
 b=YTft4J4n94IaZsE8J7Q3oDTofHqg9u5xasirk20LsL9WDSxm53fDUe4RMjBSuQtxUMHbJ
 dBXaQBkad/d/jbhZ/j8Ms0BUUjWWc+w+MEWcvpa7IivjNrZEHOF1NLcGlsZ0F6ntfgz+bg7
 N3ZLuZJIz0MkW/r5kaQhwMTouxf33i8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC0273CE57C
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 03:20:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D343E3CC7B2
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 03:19:40 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C7EAE140055B
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 03:19:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt1RNOEHaQcz1llNh8GO4e7GTB5WUGsI2gBY+w2hvAD34RWlOe7atSAEAjC+cxMfUO8MTM2wmqe4mkkyY2bwAKu9fqfBIvjXkpyIE5+kJqgKyIwTc7Ng02MvxtbjZTV0CYBITkp6m4XVNr+sj6rZQ06tD4xL4Lk7cpkiiZc36qE6cvvzTKTsOvBet2EvuPNjS9NxdjdH/LeNvtaNi6JsRJ6rNnCTVKqvoM47o2yzlUPi/zloJ/SaCLCzCTp9DwQTmSXWZ0i3pbuWwvtPuo5LpSh5LYzUJJWOcRCuO3s0lWm/ZzZgm4a1hl1hWNPf1ltc/Gov7Ys0X0qc+tILDOFzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMORyXlXJRDjD2LtluQC6Alnio+WT7+7bMPFQC/PDoA=;
 b=UxBzJDIGfO0H2zvxPrMZ9sqIVJ9kLzjwWnFiFMjpSwTkIeuoQkPtatavbL223gbj4nrIEGe3wfLFsF7/Gwh4eWHIKAQdp3xffKIev36Tw1fvYOPMaGMrACQQJ1viPofy7VMCiQWY1AaREOFgfXJuyeuDPYxZegWBj3QA4z1Ltr6vN6zb7wNwQElN1pZ4EdaEJCmrLv0eMlllcbTYzzpB/NTQqZ6tHh2HP4EvVp48/T+cQSUwqssfPCquG+sljnn8cKyujByH8p/nf9Cic1hj1L008Hkgth7w/wHc2K9RitvzJicMA3XDUmr6RA8KzB+PocRQsIh2vX0NBnP34m+8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMORyXlXJRDjD2LtluQC6Alnio+WT7+7bMPFQC/PDoA=;
 b=cwarEocqTUMGZM5rLG0tJtbbsaFIuMUhO5Fq4H9to7ZIxv74010X0Mbu7NhqyW5JvSTeE1lwtrTJK9xBQulfIWg0w9GDL96Vs26dE2SQRujgABo03QGb2ghpASggx1k8/8oulkiqzXgWkKMIObZP8YnwUDf4xf5lwAsYpM2NLXBHhJ2RsCZOzYkefwgsJjW7R1arQf6KOsxM4mfUk4A9bhVWc/VtjXE1+nFnJVHLDzxO4WbK9HS/omFBIfd0s8Rux5UTXe/5d9mS7oCK1Oza2uV2ujthJJ8ebzoXc/iJSSVUSQ/g5sR90AOGeqFKPLH9zk0UEe4zafhc8T07+6aWfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB8108.eurprd04.prod.outlook.com (2603:10a6:10:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 02:19:37 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 02:19:37 +0000
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 21:19:26 -0500
Message-Id: <20240123021928.9721-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240109065904.18117-1-wegao@suse.com>
References: <20240109065904.18117-1-wegao@suse.com>
X-ClientProxiedBy: TYWPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::14) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: cc108d8a-f71a-402d-7c9e-08dc1bb9bf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uswt72VfN6i6mmuqBSC62iXr4b+ZKJp/dZ9ka4hsAdHSd8Rmi0w/8XJKJr3rtRHp1lFqJ5t6GgCTAZsBPWwRhJTEtJDhPitLIucBsQSEO1IuBp/S79qRHX88K3ljOQCSsYrtkmIprC/GpIjuNnH4DpB2GAe8pIjbCCsOmLpc8jzcI0+F9dCBietIW59KwG6Od7GmfPx5+JVP95ttUhFhoauCiYaPHXW0NW25ISveDhfGSJPMIlRbzfyb+N59hVppypUOJZiTJHH2HZp9pCm6sK64n9FFTmeGz5s0UEm6b0AeqGVG5dcHCcQueIPeIJRanF+pspKo9aDJNWqvbq/tFm7Twsm5BuFfKFsmVMnuCXVdeCBgQJFkV32uTzXxApDHKfETryjkkDtD9Sezb8DT9giVLLvFKFZ/+RXIOovT6AFrCq6qCvsOpwvkXF8h0zI9HvngVcgsUjqag7Wq/DLZvYcA5KYZV6AM9IWmmJOHXpBXvnMbXFdiPHVYVtGZmmS/mWXgDUdD/RiY8xUKCtkUzlQc4891n05bDyajq6LqcRd7eISpq1Uartaan6bt+/4hLxPOvjdu35udG+YUC2C30QgkZ+83du+XhZIVVvs856KiR21mEMK34lfNoLh3Wcap
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(39850400004)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(83380400001)(8936002)(8676002)(558084003)(38100700002)(86362001)(41300700001)(36756003)(2906002)(5660300002)(6512007)(1076003)(2616005)(107886003)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(6506007)(26005)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5ATWB00kKKytGiSci9Xvr5a93XzIVe0hvKYXONCpV3s83Tj7jSEvgIzvAAG?=
 =?us-ascii?Q?GZZ3MRXHlZuD/Bsh0eBMe2Knuvpn7kQQMg7GIi62NHSZ8O7/uaCh5NOv5VsE?=
 =?us-ascii?Q?+Dt1BpBKNOm8XFjiaFXMEHvA/5jcdB+Qy52/yM3qY1i5gHWna0/sNWh2k7pI?=
 =?us-ascii?Q?yxvpnjlITqspNKKgOX3ajOPsQWfAxIq2pE+dK8WG9uPMkk1B5GfLso8+qLzf?=
 =?us-ascii?Q?eK8ypP3ZUKBVOOZwrrc1ezSe4xJTavbikhYjpUWv5/Z82Tab9P9sQEbD3MO/?=
 =?us-ascii?Q?4w0/IGtcpM2hCkecNLcdpFrrd1wM40l4/UQA7rwEzbB9ZIzD/psiuCJZI0Fa?=
 =?us-ascii?Q?stBOlf+USCSWNsV72KsqN3Pkbe0AoRXUAvhqbAydGUIoiKiDbN3B3436jfK4?=
 =?us-ascii?Q?hKKh5zd1mVYjakTXP8Q8jWsG9Q4TI7A1cLxQUypt3H044NN8wcuT9W2rNDFr?=
 =?us-ascii?Q?7qmQE6tD/2q/rndBPoxlauKBJu5YmWQP1ERqNF9iebeA7OJKPmX93HGa9ZzV?=
 =?us-ascii?Q?tAF3zM2S5S06LJYIusVvv35m/MJromTtisKFEA1b254u3nOSbK7a+EvUMDui?=
 =?us-ascii?Q?jCUimYBhrQLP/ZxceJgH9B7KpT1ae29J5733LMslFUSJ/WGUo8/P41ej8VX8?=
 =?us-ascii?Q?d7R+L8hBFZLx1B5/I4zmGjWMnZvPMAdx2HbEzzNpnO2hb7jfV0jGAG7TDxey?=
 =?us-ascii?Q?AamCkJWm/qVRPOW1+pCdl76EGvW0K8SxH1OIv5Ku74CqFmViCnP2kj9ErLsh?=
 =?us-ascii?Q?0O0wjcHOYX9ZEuhuUT8LZdGYLWuVX14C2qaK6UUEhSUm6z5Zd5djGXHHvZ2z?=
 =?us-ascii?Q?Wi1rHsatU5piFksTzrovDp3e5kmhlk0JGskBM8gvYMVObr8YIxvqYn9dQSE9?=
 =?us-ascii?Q?sdKhgGTJ1Wz/N/zBv+r6IpswBgCkv2SLsfveJAGkvGq9xnW/3qSVZVWtulTj?=
 =?us-ascii?Q?zVIwvyhS8aXkIFqMVx1zDN3RPXtD7PYfPIfI/vaDMQGiNnusfXpnL2haq8lS?=
 =?us-ascii?Q?TGuKaD9V2xh/FTjr8lIaA1OcM5v+atjz7poGQv+JoapfGtDisB4gdpPdoz8G?=
 =?us-ascii?Q?+jiuRJpqTQbN17H8RdbkXGvqoJB/n4sMTk95JWtNDxl1iOnh7Ys/EXjabg2t?=
 =?us-ascii?Q?q7mvIiHqUrOXYGEx2qdkpp+J6FcY2b+6xXpaorMeNsjEAUhWrWCwYcdnpSex?=
 =?us-ascii?Q?dwIiW7cGlcOU5wpic8Im1g3kf0XtlmCGbvkTv5izc4QalJ5FYgZgd0Zg2qqL?=
 =?us-ascii?Q?C2vOO2W+xbNKuNRamZGR7tH4hilXsIkCmLf+hGsynGBahw1kal+o377f+mT1?=
 =?us-ascii?Q?CQ2zJ9R0t135nhMFgm8+IN+1v41rnnmFeMWHdyJTTlDwApmRH/uCGflW1LBp?=
 =?us-ascii?Q?Og5DTYH6FPZS2N4edBf/mWE/6YMDvh4cquL/DmdTW1vErdKT9/ErVA4Bh5Gq?=
 =?us-ascii?Q?yvAd2AonBp+EFJWgyJ1A+VmFWwpFMEg4g2eT5Qz6Y9+VwZq4IIWD1z7UNUDj?=
 =?us-ascii?Q?ii0/JLaTUuLL/YzWfEG5t1/yMwlh1xTd6P5zCTJVrlpSymeIwhCKN2vSvJ3u?=
 =?us-ascii?Q?IfwZ4yejDh1GRgWd+Jo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc108d8a-f71a-402d-7c9e-08dc1bb9bf2f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 02:19:37.3109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85XpZRRnJShhPl+MHhB9vBm1mk6eJ7PIy1PKpb085rE3VEYt2mkhLH/zyn32NEIA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8108
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Lib add .ulimit setting
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  lib: Add .ulimit
  execl01.c: set stack to unlimited

 doc/C-Test-API.asciidoc                   | 18 +++++++++++++
 include/tst_test.h                        | 11 ++++++++
 lib/tst_test.c                            | 32 +++++++++++++++++++++++
 testcases/kernel/syscalls/execl/execl01.c |  4 +++
 4 files changed, 65 insertions(+)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
