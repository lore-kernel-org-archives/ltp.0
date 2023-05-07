Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AF5C77B7C
	for <ltp@archiver.kernel.org>; Sun,  7 May 2023 14:27:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD4293CB5B7
	for <ltp@archiver.kernel.org>; Sun,  7 May 2023 16:27:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E82D3C9922
 for <ltp@lists.linux.it>; Sun,  7 May 2023 16:27:43 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AC32B1000362
 for <ltp@lists.linux.it>; Sun,  7 May 2023 16:27:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnR05qUhIaRdTr9sK7YO1IN26F2yG9hhEH4LJihx8u+uWK1o4qUcgrLJQzi2ElAHbm5R8WQcQKBJ3BA0+5CYgS94vy7KKakiREiv8tbNqaZasudQL5aDwhjFlJmqckcro/kFQKl6yIeYX6CSgIhHRUH4noWm1Ut9ZuAYGGWtLdqgLwxHbXRxRl0i1/9/U4VSkxcrzkW9D2ljnLuoLym6uCp7XxWpJ631gMFUw4KOOkPLKpd9f0mugzBMpnYnr0Wwg+i0UIV/cZFWVy+ZWlJJl2NTThyNtq72S5Q0MybKV+8GNS/v5CksDQHXE7sFn+liL4saXrDwPxONNUVOifrbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GoH4u6PNiYqkS6gKau8mh69IRw3VMJ8+SMSw/uT6y0=;
 b=Q1mF+I0/GYaj6ecl0+/VlUrsLDpljCIKQ2sG/h0Wn+vi7Sc/EpLTwN8j7+0+h0GOBOIXKxM1bwQymX6F+A3o9AqtlpLvcQuMykDtNz+9g5J6/ngHjnUQan6XIxESAm9/U+wUUegJK2wbTl0ZFgxnEA7SKzR6uU/mzNFqi7HPkgBGibc5Nf3VodjJZqr2f+o/wFS8LvJqgGwhgyBAKRVBv3+8N0aegQKCuTnR3Qxjy1GsKvD2oAsu/IGJOwOMfv7MGuocAjLVVMT4Fr930cL2KGoC4QAjOx1fTZSWNYXa1qUwwNg4tB0S654s92I1DE+uRBSDoolv3KgKmaa9Y0RnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GoH4u6PNiYqkS6gKau8mh69IRw3VMJ8+SMSw/uT6y0=;
 b=vnyWzcROv+LKxiwpclmfynQaZxIJEAI2/ifwDz23GTp4G3KzhIbQxij8yCcx5ZqGuCFzP9tbS3UBKeFI7R7EmlCXNVeYP7sBrkjNp1KLeZuNDxV5O4Lu47LpQYkdtCW0mUCkV6DBsSprAseRxCqUFms0cx/Omz0A4Echq9v+SYQ3IPyC9NBXXPphUBJC5zT50nufpBe6R6dkj5pM42US4Z9bY+oxv4GDbcJNMxuMPOXs4xip0fFq/4kuwVVDdsSEcnRVZD17e4Kp/rK6dUu5+KBkwHBIE6Wp/UZwBSIGaCWGOav27Cqfjxwdw95uYGw6Cn4mh8iBs41fCfYXXWjylQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com (2603:10a6:102:223::9)
 by AM7PR04MB6791.eurprd04.prod.outlook.com (2603:10a6:20b:103::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Sun, 7 May
 2023 14:27:41 +0000
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80]) by PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80%7]) with mapi id 15.20.6363.031; Sun, 7 May 2023
 14:27:40 +0000
Date: Sun, 7 May 2023 10:27:34 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZFe1VgRXMggwVwV3@localhost>
References: <20230321110337.22970-1-wegao@suse.com>
 <20230505173137.GB31348@pevik>
Content-Disposition: inline
In-Reply-To: <20230505173137.GB31348@pevik>
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To PAXPR04MB9060.eurprd04.prod.outlook.com
 (2603:10a6:102:223::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9060:EE_|AM7PR04MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 1829cd9a-336e-4507-b788-08db4f07366f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SFSiAo1LUo7RIJao+93ECtJA7qmyZEAprJ7OaVJh3fb+sJXz+oWJc+iB09LmU0M1oV6ny1IGdRVEgw3LO15a46LX9nTAKG7zh8KI0IZipPIjoGTD0i/ieqdoTNu48AW08TKyAwXwslsGXdQdymQ4TPYv9Sm9ZseRhfkfCnuQDPttIBP79v+gdJ9JQogcJCdDgBX1Hd8r55q4w8rtRr/cVenTs7mFw58HzO0u4b2/xNyQkghor3tXGVV1NCRugc/fwIp5w8bDXVUiiBTnsOIRIx86F/8lwuOSZ0q3XUpeSXQ7HcHSxuh8cD2+fPS65gWX2LGab0HUZYnbYYqLXq2f/WPdtK5bxEnTyI414pwfw1QZ2YgSwyr4Nr+lERw7zq6EkrqUIKLXhfeJR58Jaey79iz4tUj2k8QegY1elWSKAtfqdEX6tE/ZTavB7XGta0Pjt4I5ngeHlMWe5gk+82OCDJoJwxvjF/rA64Gz+Ev25OBQ3jctNIX/ET5NcYpyrc83Blv0CDsjrTTFfZIS8od0AHK2fGns1wyCyrfZ3UN7efTSDMSf/c1/eHQPaVA66ko
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9060.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(39850400004)(366004)(396003)(376002)(346002)(136003)(451199021)(86362001)(316002)(66946007)(66556008)(66476007)(6916009)(4326008)(6486002)(478600001)(6666004)(33716001)(8676002)(8936002)(5660300002)(4744005)(2906002)(41300700001)(38100700002)(186003)(9686003)(6512007)(6506007)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9/tUIDvKBfcKLs1crQOWxFjJlOFSmSZIWGOmfKM1tx/sBjo7x1ZBpDhGqusk?=
 =?us-ascii?Q?iAMLjKPmW2gcT1eGlrgX/s+/Z2KwzIvse4Pgy4F/p5B10mH0WJgpGtFG9NvH?=
 =?us-ascii?Q?EgP4kZcs5abbzWmFPKwtOGXQ8k1/Y9sh5sPomMWmnducavHB2BRUhymrXTq5?=
 =?us-ascii?Q?zTbOj1VhMU653JZzT33YyNviHb/bTIrgizLJk4N1exRhVr07LpgTkp+gNtLX?=
 =?us-ascii?Q?18gQUTQTOwe8Ady3omUakdNaHEEqbA5XZDFjYUhAocS7Za/Nb+UoKODYNRkR?=
 =?us-ascii?Q?1kM/EmXHDJGq8OKrkpl291hyHgFmjX5aun5grzQKhlzungodwvD7afXgOR92?=
 =?us-ascii?Q?W3WpgB305kq0ZwC0caRT91tHlryI7f3kTgCWXfEv8PrKg1Vto/zFweT9tRJk?=
 =?us-ascii?Q?gilaI55gVbXrACugN7022mm3byAGBerYXnvfCvGxbJpx++GvPt8TtYKWbSjb?=
 =?us-ascii?Q?yUeeWyyV88z2yva12EAfNcDAGrtRklw5CzO+H9ckhsajD8hYJv8XVJsb8TGV?=
 =?us-ascii?Q?iVBtcNQHjtvFYWAlrYzHD1OkFKlhX0LQ0qnmwicJKKpC1DhFylR33zHAWqFE?=
 =?us-ascii?Q?Rs3zlUDrYncTpqbWHxBXIbGCloBfulBagEP4v6wAW8/1JVXr8oobWzL4fXqy?=
 =?us-ascii?Q?Qa3Hyvl92jTPCVDJ1s/BgU0M4Gch1VbdQkx2290bm8bo2nR5HPn2MquJTfKa?=
 =?us-ascii?Q?Xy4+WzSZTcQXstgv8h0X/Ji3LlwgH2Rcx+UmmdZF3LKKHCpXftAx4wEZ9JZ1?=
 =?us-ascii?Q?ubFt10qQxSWIRHRmcnIEq6Xi1C0bWl9uz5YJODtsqkLuvSwfXdHhVpyFTAii?=
 =?us-ascii?Q?XKS1jFZANoZYldq/4Qwgc0tJoxIeIaOI/iWqr48cHtGWmRVbxtBtaxt9qdO8?=
 =?us-ascii?Q?K/HEIecHXWYvRosMN4fw3oVTUt2guE9iCqkBtdf2PPwqHaZlKSdZ0nvZCrAB?=
 =?us-ascii?Q?sgTnUk4RPBJrqrwRbBL4xJVkUTo3pdwznDYNRdZV7Hk/8Jk/iEQUjt87qdja?=
 =?us-ascii?Q?yqms/Nlh44WtlYB7QC5uOcqbYV4F6esrPV0yLDL+l4tEx6gLa1iwYOevHEsT?=
 =?us-ascii?Q?+i9c6FRHTJnSuInLib7YO4XCv1s+h9SNuRF2pEylbdm/w/0l+0Ic3epsoKTA?=
 =?us-ascii?Q?Ri/Z8LEz2zaa44eG3cA6okBlixEbvzfV+HE3NArZ7JUMv4kp1L/MhMGDlGAU?=
 =?us-ascii?Q?TmDrESP7xmwdv1C1jBPzHcnnbBP0CTw7htAc0QT3F4A3VQBmowVcbuaa6OLW?=
 =?us-ascii?Q?czad13nCwLFwC6VMEyLmDUGCVWj+8vO49jx4G8V7DZnvHyTPR9ddOKKIGgVb?=
 =?us-ascii?Q?QsC03bf4qXZ0V7gv0cQ37lAj0EW1ExrLHvQnMSXHa87qxk2RTMO82lY6/JsV?=
 =?us-ascii?Q?gQE6OlngUL0rmZF6mL95hjZj1kI7t+VUN/UE0wq6i0DhlEYq7Csk4jgKlqb/?=
 =?us-ascii?Q?oiLxPUQfPiFyj5XIX73ortiAVa5Y78HVjODWOIGrl9UvDLmIjDO2hmyeutRE?=
 =?us-ascii?Q?UdmcNn+xdA6lfdkoQmCKMom/delzX6lczZ4GnI24C36KC1hI+R7TFDuR6h53?=
 =?us-ascii?Q?L0fwrpfgCZ3vIuKeTik=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1829cd9a-336e-4507-b788-08db4f07366f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9060.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 14:27:40.1838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmEfDD5OdwM4Vpm72LEZViuYxoUobpfrCDf58kwtT0njmJ7BEU2JYBUihuUFirQR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6791
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] starvation.c: New case for sched starvation
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

On Fri, May 05, 2023 at 07:31:37PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> > +static struct tst_test test = {
> > +	.test_all = do_test,
> > +	.setup = setup,
> > +	.forks_child = 1,
> > +	.needs_checkpoints = 1,
> > +	.max_runtime = 120,
> Are you sure 2 min is enough? Maybe we need to use tst_remaining_runtime() to
> check if we're not running out of time.
Seems difficult to check with tst_remaining_runtime since i can use code such as:
while(tst_remaining_runtime()) 
	wait_for_pid();
> Also, if we set getopt to choose number of options, we'd need to adjust it by
> tst_set_max_runtime().
> 
> Kind regards,
> Petr
> 
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
