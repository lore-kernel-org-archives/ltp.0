Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43539C77B7C
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 13:57:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F8D3CD72A
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 15:57:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86FBE3C0177
 for <ltp@lists.linux.it>; Tue,  9 May 2023 15:56:53 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85BA4100061F
 for <ltp@lists.linux.it>; Tue,  9 May 2023 15:56:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCx3XtjVasUZvxIBA+068qcfXkALJk7Fg6FNL+nesvfepSCV+t1mn/f3zXxWveTvdxns82XI2CVU1HFtcNwV2JNgRU5nS+OFe6ItHP/21ZfZbt4lQgGieUk5a0ipvFJAqoh2IbvtYSofzTe8vsTfMe4XHNGjCWqSby/thO2OY9IMw3QQgbdcZ5LT6MIoPDxB6rrVKHT7KMu2fjJfvReBGdNbaURlx39oAXrc4cDd6CiTDrllLB/rxIgDJsTnCg8gouG8eaT35uelIL1TzgTB5r/TL/Uq+XYqx7yWGvTvDOnIRrKPy/HSFyr+HyU3TUd2VrRh8vGDafRq++y2E9wmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzjVxEaZIYPgDErfI3lff44p/nfFVOSWF2Fxwx3b7Hw=;
 b=Ulu4tiBoNR+b6eAFfv72DsP8LSBVc6IWJgiiOxnGJ7LMkz5Ry7VdEgqjTudceU6eUWs7lejgOE84RW/lJwCCQQCsvyn+2qEy/cKvufl2fjDoO6L7kt8RXyh9J98oOCFBYxBMc+k2SKZ7TkALDOvLerJsEmnnHM13g7mqqG4H4G26WGDF2wvTLPZmy/nAFVHswmQvr+TBoUmv+JAR0/McoxM4TwieKzePPD+gDKaFrQIyYtmJN9vjA1EHwdh9KoQNcXSZZJCbdMBqrXcs40/i+/nedFrK8TGXSWxMFiLGqAqelnFXMdYdtaaWNVpEAj7ZtEy/C/ZZKCoUuThrEhfflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzjVxEaZIYPgDErfI3lff44p/nfFVOSWF2Fxwx3b7Hw=;
 b=5G8p5m8/PErKEvBx/nfw2zrRwPdXdWyFX5zk29zSu3kQWImIyVOilqkUjEy2SVpdacNFvl7xNbiwX7ZZO6sYGgJfsJsG11Pb47sM2zCnVLY8WrQ3dKR82g1iWjq4pL9yLpU4jN4fvrhHqaiEp3ZooutNYFLuR/X/aMXZiaPB4gcdtqBQz5CdsWWLcFQqlkCMke6udYV3baY7LyavbCBMH3mgc9B06RlQKPReOwllYPuyBfJSWp8/KGJtDh8V5+rn0CIyJSf40ORJGYVvzCuSTNjsZrYj5uyW7rXcHVxbNUphRnUPxGU9zCDe7Gmm5uDW4i1cqTIkAj/EFmQIgsb6cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com (2603:10a6:102:223::9)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 13:56:50 +0000
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80]) by PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80%7]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:56:49 +0000
Date: Tue, 9 May 2023 09:56:43 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZFpRG4amSEOQ3wpo@localhost>
References: <20230321110337.22970-1-wegao@suse.com>
 <20230505173137.GB31348@pevik> <ZFe1VgRXMggwVwV3@localhost>
 <20230509055256.GB128837@pevik>
Content-Disposition: inline
In-Reply-To: <20230509055256.GB128837@pevik>
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To PAXPR04MB9060.eurprd04.prod.outlook.com
 (2603:10a6:102:223::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9060:EE_|PAXPR04MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5a8893-303b-4095-0bcf-08db50953c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dtoq7uBU/HvBfIi0XjaXeuiw5S9bPHM8YCUnp1d3iWLZBrcjcrJ/0tgBAM0T7/YOgogMNlPiPO/Gj/cuzQ84kQL8LxcLWYuOlUQnH4WjpEOK/vS0gpAn7x6KKRgOTHRvoWgxJwZQRDqMIkbisbRwEP1Qx/jOpSA4JB2E2kLBI19iaVZlIns4Dd93qykXDFTof3uiDjXkFvaBiYal3b6G+UsHVxGHSbpq/IG+t7NTxvpOYEvWecdlORQJV8UISl0Zs3i8faXvXSxYrEE7o3F8oIvdjawsb6n52FscLUvuvaEXkQ/ANzB2pA+cf5hJAoKogpdyISsxnwOdIqOPZ02rgVe2ZmBq6gnPFUz07233GxeJYzoXrwxl+MhFaF6iEbQ9MeJRk0e6cxOaq+NM7ptQPLbpWMoThEVExdKtsWBFNF7+PLfg356/sCuxxluJZ9Lykd/qDHvgZf+6fThRF8oY6T76PdEx1TMOtD+CyW+uACNKbO+6hl+bzSdwoKYSXPNxcLyOjoEtcgkj6ZP8A/BI56tBudQPIOLGfCscR0nvOfcgiYMdnlS4d/37VTE+g2MK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9060.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(6666004)(6916009)(4326008)(66556008)(478600001)(66476007)(66946007)(6486002)(316002)(86362001)(83380400001)(26005)(6506007)(9686003)(6512007)(8676002)(2906002)(41300700001)(5660300002)(8936002)(33716001)(38100700002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AV8v+pDfxGjVerAm2yKDWFeuyqckxPMoeJ1Lxa6ci0OwWI4ROyI9DYB8sT2V?=
 =?us-ascii?Q?0GEOM51lEhq//RUEcdS8jLiZQAMoQJcqr8Oz2/j1x8fnXkndVcHKjbqFcpP1?=
 =?us-ascii?Q?6OgNEfO4mZhCowzBkrk8hrufvYG/6cM1ZlwRl7miw4PkN3lyoInyjHOJPxJW?=
 =?us-ascii?Q?tnmgQRN6TqoZ9yRcZoX7++ZLXRmVqTPS3f5c6Wky4j7tSWwNfHPb9fpAWtfd?=
 =?us-ascii?Q?0wcTPP6cAA/Bg87r7oSsZuHsiZsC/J/0kdslBtCDGWAhnxSh7NQHZp+EloEm?=
 =?us-ascii?Q?/qiDjhCWfqG7QXHOMDCR6bZ0ld8fTmJ26ycF8ywEHYzu0q8bSce5qbR+2tvq?=
 =?us-ascii?Q?oohMAjaNhwhzB3HOETBsMrVLRqrle0UYiv8NndMQcBHBgriXPF4TeDP4qt81?=
 =?us-ascii?Q?rVQ0HiXShSv66nm+AdPMlrcnSc5qfrFcTbsxkHCDJAsWo4DqgUJ/SlZzYTsC?=
 =?us-ascii?Q?txOT/rp17+xfm/yzUgLxrP9bftgidpQRUfUXPJkY+fxfchONV41kfF2zby7T?=
 =?us-ascii?Q?dDQrbPT5Z2P7zCXhYmm2MZtktlkAMmm6nuwdN7xxxoLA+MZY6vqhgoGKFAys?=
 =?us-ascii?Q?Rdwvp/WTlqOKO6OQWptmPThKfyR9IR2Msz82SHgADybuFctbtLlk9R+zcqE0?=
 =?us-ascii?Q?4aZtDLtnfPrjO/MUmbUdshlaXC3TOs+Mwqxo8Mr1Z2ojZt7WhDx/X7qKi7Zh?=
 =?us-ascii?Q?c5Gu35vEsPjs+qurSHaDnpSYlxlABbxWX9tqSAASl1F85tT2NSGzJGJ4LZxo?=
 =?us-ascii?Q?gHg+8RFKTu7t0ydinev7pNCoPBnxR7weZdf6AOhQh+CwsYZnkYOOnCPWwIJx?=
 =?us-ascii?Q?uR5IzR3LZSiQLzAepHKIhPdayx8IKvpSlG2MasH/IrMPZiR1hLS6X1rIk7/b?=
 =?us-ascii?Q?2X2NYWmRicyctd1hZCqGIgrfHUGuB0bgw85xPntFnz6piw3JXo/ZZCgzVkXI?=
 =?us-ascii?Q?nxZemqecasgYFD5mjaQt8HwgcqEB1JfBMKtJv462GdUD8TI+pFQplHRFZwWv?=
 =?us-ascii?Q?t5G5KTdrm3pl4EOgXJGC5U84BSxg8TVbVFIk4sux7XMYUgPA4a+kYgLoaOG+?=
 =?us-ascii?Q?kvZ0NF/SSOJmTfxZuKYOQhUX8k38Xe0X4iWlbJ2Z0L3uh1kSD8kN+YSBSubJ?=
 =?us-ascii?Q?Q3bhQO9sdiFZokF/8HO1JCNE8tPdk3xakIAala2u+GUpo8rqn46Xl0Hd3fc2?=
 =?us-ascii?Q?irANmNG2dksMY1HClf70pOa/+fvgHxwEWuibyn828VQcOfhBK4UP5sAkohil?=
 =?us-ascii?Q?IDLTV/pi/gsxrq5HPK/89jPMDykexvSpelVGASrBYCIlC0ukRd+KidoBwBmC?=
 =?us-ascii?Q?xQC56eSzLZfRSlwgWg6IDLJKfK40F8FVHjdgV66dW+R3TES2QPq+dgxBaRTz?=
 =?us-ascii?Q?vrwXz4UoNBf/uuTlY05M7e50dOidE58z9Or7Qj4ZXuONBYUzLjqYTZa75nGA?=
 =?us-ascii?Q?I9SazOwYGRalFjYS43mgfoeQXvKrXauOmIKElqd2lpPHRQNtXzHKFtnFp3YU?=
 =?us-ascii?Q?b5nH5sDrvcxMRanLkIGhrW+RE0SN/STa0rzbvAEPeerfsYuBbAP766+JWHAp?=
 =?us-ascii?Q?2G5mlYftkzyaFdFwQ3w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5a8893-303b-4095-0bcf-08db50953c48
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9060.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:56:49.6279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pARAa0/N5Cqu/SbNHzZqirnMnDvgOhnjcsKF7t9uZcrWpQ5KBsiPwa6hrecmQb7m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405
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

On Tue, May 09, 2023 at 07:52:56AM +0200, Petr Vorel wrote:
> > On Fri, May 05, 2023 at 07:31:37PM +0200, Petr Vorel wrote:
> > > Hi Wei,
> 
> > > > +static struct tst_test test = {
> > > > +	.test_all = do_test,
> > > > +	.setup = setup,
> > > > +	.forks_child = 1,
> > > > +	.needs_checkpoints = 1,
> > > > +	.max_runtime = 120,
> > > Are you sure 2 min is enough? Maybe we need to use tst_remaining_runtime() to
> > > check if we're not running out of time.
> 
> > Seems difficult to check with tst_remaining_runtime since i can use code such as:
> > while(tst_remaining_runtime()) 
> > 	wait_for_pid();
> 
> If you don't know how to use tst_remaining_runtime() how about getting
> inspiration from lib/newlib_tests/test_runtime01.c ?
What i mean is i can not use while or do loop to check tst_remaining_runtime, since 
the last function wait_for_pid() already hold(block) the current process and you do not need 
and can not use tst_remaining_runtime(). Sorry if any misunderstood.

> 
> static void run(void)
> {
> 	int runtime;
> 
> 	tst_res(TINFO, "...");
> 
> 	do {
> 		runtime = tst_remaining_runtime();
> 		tst_res(TINFO, "Remaining runtime %d", runtime);
> 		sleep(1);
> 	} while (runtime);
> 
> 	tst_res(TPASS, "Test passed");
> }
> 
> static struct tst_test test = {
> 	.test_all = run,
> 	.max_runtime = 120,
> };
> 
> => Also, it's a question, how long should the test be running.
> Is it worth to be running for 2 mins? It's kind of stress test, right?
> But even that wouldn't be 30 sec enough?
Normally the default value which i set will spend ~30s i test in virtual machine.
I suppose 2mins max_runtime should be safe enough. 
Yes it can be taken as stress test, you need a big loop number to let test run.

In latest v2 patch the number of loop and max_runtime both configurable, so if your machine 
is too slow maybe you need adjust parameter.
> 
> Kind regards,
> Petr
> 
> > > Also, if we set getopt to choose number of options, we'd need to adjust it by
> > > tst_set_max_runtime().
> 
> > > Kind regards,
> > > Petr
> 
> > > > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
