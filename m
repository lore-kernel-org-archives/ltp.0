Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AD2CA0FFC
	for <ltp@archiver.kernel.org>; Sat,  2 Sep 2023 05:59:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A7D13CBA97
	for <ltp@archiver.kernel.org>; Sat,  2 Sep 2023 07:59:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DFF53CBA33
 for <ltp@lists.linux.it>; Sat,  2 Sep 2023 07:59:28 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B71D3601CB3
 for <ltp@lists.linux.it>; Sat,  2 Sep 2023 07:59:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp+y2tLrUmsE4DZmIYYbryqbhy3Y98Yff2/eeALZPbBwipXTvYOYYQ1uAO8dtrmoQk1/GsErzkCV/miDFHKbNxWEAaxgzlbO0GGEdvdu/0HfhE/mRdBv/EuU7fjqcHM0AfxV853Z/rZ9T55VdEl6d1Hh1ViOPDlxQRxSe03zazkg0EouwW8usEw4irRv8NcYs6mnhofGXHQSNcoLEI4/qYmsJ4ynuV590wOOz6meMyR/6rxaT1CoH8wMMC+R4gOGGrvN72VBbpKgqLKOHjbULzRq0T0AbJyopoIQmNdIj+/qr3VHrJS8ZcIz/tdvQSbjz6TWN8mavxhlbdwqRtbVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMI3oNcTY4EJoCEhmpeTD1IztfzkcDOlXMN1BHEv56Y=;
 b=TZgsIEJ4N2u+z8yZ6g2kAXCZz4On8H3jNS5TUu8MH/0MewtFIo/GioEytXKMNpTUMyeYVx244O5+OsrcfT2malQgNtnsn2E5bf//coQ+c1I1sZaKBn1G+Upyn/Se993HG4kDdr5VGG29fzzGayDCxbTp90dh+qsnALKsVAsH4BJGobahsUXt+albHHSNVNWp6K2+UO14eQ5J2hBFYrMmX62uL7ct2V6UnDJ5aNuKxHRkp5nzc/fnrN7ag2P63tRTW/EvWyoMIP46PWIAcbMnYg0TwU5xdgGuX5lLNCKQ8mC1K2Dl/5mUVNKwh5VLVkn6Wi6XDkzKDEZeegEz/82AlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMI3oNcTY4EJoCEhmpeTD1IztfzkcDOlXMN1BHEv56Y=;
 b=sf+5GGoamfW/Jmy1wk/XP1LwsadBuoKRovV1VRsgHGVYZMfVJuqI/rlkfhJXAI/YxJYjRBu79YPfXfk3X6HocjkqedyB1W2bzZ3I/sVyFbFQqGmDuNwNtq0YGc+ofPvK+PBTUWs9uVAzSuUiJh9Hh5dORKKwS5xDGXIw2Hm7PQ3+qC++9WUvcjJrbzLVC/wLoZQkvh1uiDx2bSl1pAxu6yGQoiNZnW4TZtkCUVV/t5IgC6/GRvTt+YkLtD+KG7s5nTVzWg2WPSdsSYjcTpckPBRhnStxd3zD+f+Vd6DEtXf5HVCLmsUQzg8JnlD/39gzPkojSQNATD/QSwYx8VduyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Sat, 2 Sep
 2023 05:59:25 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6745.026; Sat, 2 Sep 2023
 05:59:24 +0000
Date: Sat, 2 Sep 2023 01:59:18 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZPLPNvBDyhGk4HBY@wegao>
References: <20230901144407.364630-1-pvorel@suse.cz>
 <ac801295-9ea4-9e6b-1576-3203a7dd548e@suse.cz>
 <20230901170038.GA386230@pevik>
Content-Disposition: inline
In-Reply-To: <20230901170038.GA386230@pevik>
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b91f6f-820d-43fb-a543-08dbab79c29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwG9mi06NV9mrrRo+vW1yFYlgc4Jza+A598AUYpvIbV6ZDH6H0IRogGVesQJmVn0BZDJ6QWpt+XudB9NT1sNd8o6i0F9J3xZurGBAZfbC0GjjRFY1miSoHrKiK9c+Nr5xxPBIbykER3bql00qmwOcs9SEmOFFpnFgNKcdPnsS5VbMu/R7w8PmOhqHVwxHagZtkGl6VF6Ep+6e7F5hbX8zr+IScxtAswKkyRI5vcCAa/LnLcddEt03SBW0wctwgPDJ46xUZ5RaA+oDCwNCWdGFEu4jguFy/uG+HllpjGD32RzolmhBiYzgFpk+0UBX4Io2/FwE0b8bs+O/AHk69wcL6uPHUqghkJFyvJPZqP18t3Ojmtr2rHHlq2i0nv24ZLGqvnPmPhT6VaOSSlvgbsva3ICc3O19Yib3/OU/7Yg1K+ScF58zySBAOn64K492cDXlo41JsWCpJjjaQ/rIUSUN+6L0PLtprKDSHdbslzWqqzOCFNuAi2OZTIBne9ZqtocN+hTuuSr8r3A48X4IbykXVFQk0XSGW93iNgW1pot+8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(136003)(39860400002)(366004)(346002)(396003)(1800799009)(186009)(451199024)(9686003)(6486002)(6506007)(6512007)(6666004)(966005)(478600001)(83380400001)(26005)(2906002)(33716001)(66556008)(66476007)(316002)(66946007)(8936002)(5660300002)(6916009)(4326008)(8676002)(41300700001)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZ0SUG3eSZIog0Iwv0av15iFNi4SfsvcWS+X7aYLLlapLl5JeXsAhtPKzcUi?=
 =?us-ascii?Q?NH9gAwdmq3ftUg4fuLLIE9Qu6L9rpKtK8I0+Mj5WWCEAvNj62keRYxFsqfIl?=
 =?us-ascii?Q?nZ9gdcDbE+cwmAcJsQTr7b+n996MG61Bu6nDwAWQq6Ta3r3is3rXmKWaj+6n?=
 =?us-ascii?Q?0XEpYjgYLCTcd3Rwc+u27LF8oQkdBawRlBfa80PxyWynV/CKcq+QEeIqzeSz?=
 =?us-ascii?Q?bDxaF112aT/q6xSrcEd4wg0YfpY7otgY3F12J0X1StzAt7im/H6O1z+NutiU?=
 =?us-ascii?Q?funMXSmVt9Vsing5hqHXqI13Teh4aQBZoUZ4JTyr8DWNl77qtviijrVoq6SF?=
 =?us-ascii?Q?9jLIifC2mjIVmStOOuB+SheRFPfDtyorBXEO7Vk3uZB4UyTCbXG1FTKyfegZ?=
 =?us-ascii?Q?6XS26e/ZEU7fxnGpOVngPV3gr6u8n2znTV5/dB1xSP4onROheVnt2LEl80Fh?=
 =?us-ascii?Q?e+GrTuTJoEF2FYi5c7EPPISpjM7Z5nRFITe4fS6+ANHmebrKNxVh468P7h5k?=
 =?us-ascii?Q?STNHD322BikWQAK1q/ATy4sNsT0BrD1ltB/Oxwy7MRGpArq30lNphPVvMiU3?=
 =?us-ascii?Q?RB9n2EAypIV/riskEXrjmBEbPAwy9bmmo7uC0GPg0VU5UCJjEGX1PW9SNBG5?=
 =?us-ascii?Q?LHsTZvqLZbnLdLRtPPj6NXq9Dtz6jB5OrJSusSgu5o3e/00GDLDckMgDRKeq?=
 =?us-ascii?Q?qauM4zVtiiKapvYKisM+3kj3FtyLI49H4MT3/5H9J6/9evO1ngVdrIOwgSFL?=
 =?us-ascii?Q?oGRC5yd42igKL9mbixX68dp+UCi5a5LAc8vwBo+8v7C9M0+UzJhKSGJ0Cuv5?=
 =?us-ascii?Q?L1ME/RjhY7YIOo4uYAmC7K8+JzrrzLBtJjmwXn3CiltJm7aKWHiQoO9ltoqc?=
 =?us-ascii?Q?WrTDSa4DacOu1xH737sicpFwPi1GwnQW8abG9136UVxxlYIhYVODHMVHNMUT?=
 =?us-ascii?Q?7Y2R6jCdwCqTY5n5EzEnGiHQGyLfl5KEN1BCrd8J+/Kjrl0dhHIJ9i3dasdm?=
 =?us-ascii?Q?dtn1h7rDuhMiiyrQczoc4iqNJ7/lO925X8Ved1c7w8sT9IvaXKrZKM8IJ02j?=
 =?us-ascii?Q?tuj3fweiDUDGyhJdRHKn4StgvULHK+d7MY0+go0bRASRSKgAfUra+gpy781p?=
 =?us-ascii?Q?0x2JPWMPbi9KTVZfDPN4AHj7VLZ9DYO0xKV+K4QXcPSEZ6WpRJpsEbv9fuNy?=
 =?us-ascii?Q?+hKmzn5JBK8VLAOB/ThsJXJATNyi1OAXmtoi3yYa/IwRr2UFICnvsRbEW43O?=
 =?us-ascii?Q?UHXKGdNnwdFzYBi1JGJhzuM30dsqMQtzsLdoMK7UrJr4pjVYSoAK2q/JkfVZ?=
 =?us-ascii?Q?2qX1dgkNVzLcAve1dpt9aLJFOmlaUsV5s8sQGBwSB+4oK4ks8MeB6d4gfBa5?=
 =?us-ascii?Q?fBDG6OE2vmLAlAIpVSo7dvQZl9ifjp4sAcFAcOW+qLA+gUHbNYoMBtlrvJkF?=
 =?us-ascii?Q?7yxZ5V6XUOcBUBJnKryYVIGD9TLL39qcqFPWn4wuelldpZB5KNAySHkWxUIM?=
 =?us-ascii?Q?KP/9TjowswSVwLGGpBks+A7Pfk6x6e5n/OVLgk8/wlLi512doR179L60XoyN?=
 =?us-ascii?Q?zuSp3/NhsRgYI25LjOY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b91f6f-820d-43fb-a543-08dbab79c29c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2023 05:59:24.8730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYq1z0tNDVKmhrBng2KcAHcyGqGHnENpHell/DGDgmeBXrO4pQP6fcxw1Xj4800S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] clone302: Fix short size test
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

On Fri, Sep 01, 2023 at 07:00:38PM +0200, Petr Vorel wrote:
> Hi Martin,
> 
> > Hi,
> 
> > On 01. 09. 23 16:44, Petr Vorel wrote:
> > > Test uses sizeof(struct clone_args)-1 as invalid size. Original struct
> > > size 64 was suitable (because > 64 results in EINVAL), but unrelated
> 
> > Nit: <64
> 
> Thanks! (I meant that, but fingers wrote the opposite comparator.)
> 
> > > change in 45f6916ba increased the size to 88, thus test failed to due
> > > unexpected clone3() pass.
> 
> > > Depending on struct clone_args size is not good idea, let's use
> > > arbitrary value 1.
> 
> > This will work, but we could also define a "minimal" struct clone_args
> > (without any fields other than the required ones) and use the size of that
> > (-1 of course). That would give better coverage and leave no untested gap
> > between 1 and minimal struct size.
> 
> Very good idea. I'm setting this as changes requested.

I have made another patch for fix this, hope this can work.
https://patchwork.ozlabs.org/project/ltp/patch/20230902055638.14256-1-wegao@suse.com/

> 
> Kind regards,
> Petr
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
