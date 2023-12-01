Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F87FC4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 03:52:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 137083CD97B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 04:52:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5084D3CC705
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 04:52:42 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 450041400769
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 04:52:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUEJKIMh9o4UC/xTnTCwdjeY1ew5EQFqDLDL1P5fOCB6xzJwQfTcx/xTPMZl0L0VowBzMnwx1gdIIJ4tUcL+TTrHMvZ05ZbZapRtycJ9v3X+Ir80usnh2EbZqR/FmCOO/j3MVG6w9glO9rMBTJ6r7K3y6l5OBPQCdYz01PNG9nAs2apKkJLggidmkFO79qqyKDUPYA5U3ZyOEukjbbDK4F2OFlCsWsP4hY3RxPVBgs1vL03i9z/xxrwshUiGw4ijsvdr50bbZ/3UFMkCEd2NuPeZWZm2avOmkfhuPg4k5MA9ZOAJON5QPomwFvKQWQUpXb3KQ3Mg1qJpltvSb5EHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekMN9HgmGshHpwQm1yf43JeveOZuLjSX1htu1L+BAEo=;
 b=EgA9rfS6TdSgwb9464dk/0JBBliUCZX5jJzemq3+iSpYbY0mvxCy2+ZGf4GsHvfsMIokF6VunmNSeiu2iCAIflmlFIduxRm3pe+8bKMCXv7Sbw8Q9uVcd0c2mc4moZ8mJdlik9mK/9iRxMi7mX95BUOVUo8Zqy/5Le113s9UDOSm6QwEqpZaBKEeHXuVYiPCo3yk4NX9EFL+i153vwIseOLAaIILRN3aifZzOqYMLK046mL0YcBssRWPTVHTyap8OgnHCUx5f5AILxnoSo5v5WgtmwH/tCn0vSBAy7r3N3s/Zim4gJcy8KWZNkHqu8seimSpURZo/m1nw0mO4ThWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekMN9HgmGshHpwQm1yf43JeveOZuLjSX1htu1L+BAEo=;
 b=KtkJWgk4JS1fHelpBTFEd+kEXmQHQHCLhJMkmNXYaH63SgcW9Xr7RVYfjg2FVKJ2Th7d331SJ4s2xwhRHfRntoM7r+6f6Sg6Ij/IsYD6n9iXBJNCsHal4ENqzapbP2wfuiXTw659xds2/CAhpCHQavXv9eB6oZYgsf3cez0vA8xlmkNQDysoSti2jmf6yy9RTZDozS8f4Edpu+uZvS5A06f59vm1TiLPJqKCxpspKffCELbtK+5kU1u944NUNOAwsiN0Ghfmg6bQLLqpIB+HdfNQdrTg4hc9dFc5MSpTlj3xsh5FsidPvDDXU9GHd8ivbHwv/36JqB9FNlvDlY0YDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM9PR04MB7555.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Fri, 1 Dec
 2023 03:52:39 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 03:52:39 +0000
Date: Thu, 30 Nov 2023 22:52:33 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZWlYgRH7/I2aNKI+@wegao>
References: <20230928084408.21125-1-wegao@suse.com>
 <20230929004518.29632-1-wegao@suse.com>
 <20231128105242.GA362098@pevik>
Content-Disposition: inline
In-Reply-To: <20231128105242.GA362098@pevik>
X-ClientProxiedBy: VI1PR07CA0299.eurprd07.prod.outlook.com
 (2603:10a6:800:130::27) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM9PR04MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1cf7f7-a2da-4729-354e-08dbf220f65b
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QPifVlmWVJNvg/HO5Na6sUKdeuW2ll4eVMMQQX9ZvY0yo9+PbMNQwP7E7gTC+vtu7KZW3OS6BjBRCnS9VSqfH4QOH0ll9164oQYZRyM0bmsXkrhouafw3D97Z/+qHjP/UKDI0knhvFGptZ415KY2EO02yoKM5GGsZ3yk75vsRxMn6x+A1JirCz2VbXcqOgI/Hn6Qk4dQ0WgzcFkdyzqVGcVVM2DIqsw+yvP3KBp0hva2Fezb2hTUsuWydlqCRNSHSUnDDvhBAOAXa2OMk4+ZMwjr7NV8JNbk7JDoRhgeaPBrj3F0QGSMVSD0GAAneQYSB1Zm7t5w0HAcWJVeZ/x6oMRz1Q8nszFmD8VWK/GZ1WHw1NDXQ8A6Y9/2+LCXDPnrb/eoCyUvZBTpqLUHiEFqcFHtVuBb1uS1E0PYgbxHg2TSu/lAQADWHPyBjXLY8yavlaG3GGigAuB5VESv4oLApoHVCoIF3L+d93I6j8d1gNmLfaYUpvuQcVEkHVfIxLB3rpU1W6oFSbQluan4mDTfsgMS+GnBT16tOPfho2Ft3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6486002)(66946007)(966005)(66556008)(316002)(8676002)(4326008)(8936002)(6916009)(508600001)(66476007)(2906002)(86362001)(5660300002)(38100700002)(9686003)(107886003)(6512007)(41300700001)(6506007)(6666004)(83380400001)(33716001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MMjtAWB/UKzRCve6sp+tzm17J/ab0PWR95Y/udLJkVEyciAsqhIiiH84CwRn?=
 =?us-ascii?Q?wXDTy6EH/uHvggSy5aONhFl9lB6gOcA/0EqMvYsc7+P6I5Y97Nr0axinDD1/?=
 =?us-ascii?Q?ICWUnoahuyixu8bdwR91sGvvzJ98G+TaW/3DYntArZZx5xAdN8Bi/PvwBcMw?=
 =?us-ascii?Q?Z/0iQWVZ1sYrOCNawXTUTmtcLmh7l1iflgFQ4DmSTu+utyMZAf0Bso851gCd?=
 =?us-ascii?Q?7TlLpfmfJL/1sR5E0KrwcVkXLXTYUdl78VY14wRadvO43Ws8kNoGT/wDgPXP?=
 =?us-ascii?Q?6LH9N1bca6KsuayfJv4lZh8AcRKFKexwSCVSisSPXJfvmCYoycn4oxn2m4gn?=
 =?us-ascii?Q?MuMUD5buWopmr3GZ7TPXhZ+UeTJjYIvHN4hmhl7p8aWn2aY6Pp7QxFPUoCiO?=
 =?us-ascii?Q?rnC6hXjMiyBzxbi3G3O9HziMNeoFvy6nrYeaHaFnZLa0dv/+wAB88G4RTWDE?=
 =?us-ascii?Q?bkgmxoTrxtihiLDq+7LUlSAuKRXsyBtgL+aKzjwKnE5PBaoTOWD8DavCL0Yi?=
 =?us-ascii?Q?mVVeS+TsUNbsZ1hM7FneEmO8c+7kJAGXL70JUhYBPhgCM0xKkacCyZIfWmlI?=
 =?us-ascii?Q?j4WQGPCSu0BXFLwpzV3YqioOUiyMruRl3QfkzNBn3QFpmdnJfG7EYQIn3vIb?=
 =?us-ascii?Q?WGKzwPkIsXsZS7TPE7CZ4QAKgRAkl2CH2slhgQsyp0P6cToEJt3JANHakUyQ?=
 =?us-ascii?Q?fV5OJRPPt64iCkm3UZzIbjiVFKGwtYZlSpRUHBvo3Lh7vLdlP3saCBnCu1mo?=
 =?us-ascii?Q?h0yOPKIebkIgZ035FWs6XzIh9IRBQanBtLLfl89bZqaO+GN0nmerj5z68m+w?=
 =?us-ascii?Q?9F340zAeNnS6eg98COI/qBY3H3iyYUBSra5RxqcxgLLzLvA8vLQu5oyyq684?=
 =?us-ascii?Q?/FLM8e9ySlTx/hVT5sy9yrY8jFtJbLVdY6YCdNemcrdSReQ3JcSKCLsoK9a4?=
 =?us-ascii?Q?s6r04jlinT/7/prsxQHeWLgocMlZDligb84G0XhvL5cN6qTzOqRcbteAuO7n?=
 =?us-ascii?Q?PkvnsolZONg3N9zoEZcrMdTKk7j+eQVD21eNB4rDJwKKD+WDWYfTlzQefiFt?=
 =?us-ascii?Q?URD+5FOVb8ZOSuauokRUBj1sjKCOiNWj92zINsSSSy8ykeb0LlMAZIx4vJ2+?=
 =?us-ascii?Q?g97wTb2sUCZTBkG+LmVehf+cU8JGw680U7EIw3DbX+C/mkAKUuGjyKIGY0xr?=
 =?us-ascii?Q?7c51VQL8AQoBiry8Sc/CTxnTnyr9PNkPasDhqiSQDoLtYtkptmR9lhiTpfOZ?=
 =?us-ascii?Q?Q4nW3UWmKySAyESKSco1bhBdRa7QAWx4hASt4Ql1wRV1JUDOsyleK8ELSxxw?=
 =?us-ascii?Q?OObGUhmfoTeCXTtaSl382OY7R2WIEpLckqrwksLt9wHvvhWlJaaWfeT4HBum?=
 =?us-ascii?Q?ynbvYYvssSOw4ihJi8Sfl0JU7pk+PT9TaULzld+yH4p23AMkxUN604/RmGpb?=
 =?us-ascii?Q?02v9nJywDg86SQ7TAzrLyQjuW7RpcLNxwXaqANPRUnloAy3LB/WtrRmrmLjZ?=
 =?us-ascii?Q?uSVISB+16rzoazy/ysXgWjYVZrRy4gfktSJXhOp1t9Yo1oRcJMw4Der8UNhm?=
 =?us-ascii?Q?gy4PPQ1+N//zNN6aRrk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1cf7f7-a2da-4729-354e-08dbf220f65b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 03:52:39.0730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHmaxTaNCfOM/sf8vp6DvGBXk3DJZMobzeVTZtA8F4URvYersC6/fkehl7aDGeln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7555
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] getcwd01: Use syscall directly check invalid
 argument
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 28, 2023 at 11:52:42AM +0100, Petr Vorel wrote:
> > Fixes: #1084
> 
> You haven't written the reason for switching to raw syscall syscall(__NR_getcwd, ...).
> (Adding https://github.com/linux-test-project/ltp/issues/1084 is not enough, the
> reason for the change is important enough to write to the commit message).
> 
> Also, raw syscall obviously returns a different errnos than glibc wrapper.
> But again, it would be better to document in the commit message the reason for
> the errno change.
I add more comments in patchv4 for improvement.

> > -	if (res) {
> > -		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
> > -		return;
> > -	}
> > -
> > -	if (TST_ERR != tc->exp_err) {
> > -		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
> > -			tst_strerrno(tc->exp_err));
> > -		return;
> > -	}
> 
> > -	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
> > +	TST_EXP_FAIL2(syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
> 
> If the reason is that getcwd() wrapper in musl is not easily fixable (we
> probably don't want #ifdef __GLIBC__), I'm ok for this.
> 
> OTOH if test would be easily fixable for musl, we could consider testing both
> raw syscall and libc wrapper via .test_variants (separate effort).
I think we can add extra variant such as LIB_TYPE into t_case and use it to go different check logic.  
But we can not completely avoid use macro to identify musl or not if i understand correctly.
> 
> Kind regards,
> Petr
> 
> >  }
> 
> >  static struct tst_test test = {

Regards
Gao Wei

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
