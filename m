Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4531CD11C2
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 11:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B90543CF774
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 13:35:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4EFB3C1A16
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 01:40:43 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B07A20D1A7
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 01:40:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i66vOB5TjBUaNc1qxrxC1nNjQebjr16SIVQvB3e1AknE+K19gA/DrhW7F2g4hwDwMY0VbibPTVIgpuJ7a4F0F6nbVLilFvMgwSpUidzdSsQdPvq7QhMoNji2TRPgnXQKypluAJMx6o5FMeNS9oh6tmaXUHndWzOmYsN0cxGjbjPbBEweEsHOk0r42EPlhQK0QcolM3Dbj6JIjEy2/QeITWG9aI8evdJVQra5nSrcQMWFr8K5ov2LY8Yf81m6/BlMHjFXn2iqIoOGqZA8eo34+njRK8V7QpDOE/IWSeLiCw67Pd377RW9kEhnExi3XxdXPW9Wku/u1K2vucZzk5dEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWMIwn8gMb8/vVFcy1xxKQjULrjBDPfSLjunZLRur4g=;
 b=MFqRxYd5Pqk5h9epKeRQLscFSZ1/02FK5GZEfRdezf1qr3QgHwBT6FEqnZpu38nROHBXa+ox6vL//xsrISXurIIPQuR1bxlMCignvYZBBjR6yweS2B2xOcWN9rJCx91V9og5zO09O4INqbyEbTDrEO8oLcuX46lLyeX+Izb+yf4cImGZh8MsYW9hrupDen+FAyJE+lg0K2lLh2PviyuaQZi65Yqvg2Oblxz+4ofYH+WxSnqeNgXKgWlYV6RiqWIBJXxtQ/qZRR157tZUAGeNy54XIxGucbhT4Qg5fxEnRHhC+m6SxWhMZus1WY6Yn9FD+9tiokMms1Iq3LWbTYd2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWMIwn8gMb8/vVFcy1xxKQjULrjBDPfSLjunZLRur4g=;
 b=gsRn2wlPaT8Z5B1tWj7Fa5Hp+AYTJnqOZAg1vvdE8bOPBCu9cVuhVpx5Nl6HrfAdKfl8I4IbCEW7QtPdc26X5XIscVm6+FJtoGX61X05H53Q3zxw726QRLgl/W9xIyNRbFTSGlVPfpmwAibLeePljGSNZpyMG0OkZ/DViWgx3PM=
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5125.namprd17.prod.outlook.com (2603:10b6:a03:38c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 23:40:37 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.049; Tue, 9 Apr 2024
 23:40:37 +0000
Date: Tue, 9 Apr 2024 19:40:30 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZhXR7gdhKIFVEdvS@memverge.com>
References: <20240329180742.384709-1-gregory.price@memverge.com>
 <CAEemH2eZiJgM83z12eReH+2nrNiH9VkbK0F+iPk3sAZYhPoMRg@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2eZiJgM83z12eReH+2nrNiH9VkbK0F+iPk3sAZYhPoMRg@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buudy0aRAaXot+0c6khYdkjevokS6mux8xK5esVZm71YW6eiuX0pwgWwnwbvAW2J4ltdZwWcHcL+Se7Lbvz8CABvVfflawOZ/AQ0qMmef9Gt25JDK1oQE3BhV0Jaywhcxh6XLA7JzyCjNeC400yfkDVTvPlXBwqNpKXNLkfH1Ac+FPwbQF2IxnuUmUC+cLnifR8MWcCQqh1X5BwhbsCCeze65+uRG651CfkgOmLSRB/Dtdv7C1kgwzsPfA/dnLtQJRnmP873co1vq1obG8i98EItTrAjjUiKiIjQ/n2cZkCYZnxawFBSj4/bw9QO4y7UglKCQq5nYo03GK0ewN5MToYHd/6sWfDEaHRyD2HVNgEKYC64zsHhcoTEHJOOTbqzd/aKhh1jqeJu48fRFYD6x5kV/7fT9gU2bZUzKcX6GYBbDJAvp125LG2mxBoj5swA5UA7oleF6iUcH3ejL8SNukG/d33CYDbkn6VkFEALYbyhs5ENGPxWjZI6x2KKi+syo1Is22FpE4JHpLtwuVGsC2sZdYHOjSgRsyVI1N0FhvDcM8+LgdZU1fj4vQ7/XkMbhIL5cfygKBK9Fap4CionfI4rYUOz6cOHkjVBrV/0Dm4jw/7h7DMC48KKf1Wh2FTvgh3j2BHTGTpydFaUboun6IyCdpcA5rh3QZgdSN4gTkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IhqCHRkIJl92P1bhxwRNzkNm1WmOtqYNQBVHYApn9ZtTA5FiyU9v3WcqS67y?=
 =?us-ascii?Q?cDN8kWU+8OGfHaJ1wk4ibJtez090jhJtFeEY4okezNWcdkglFcXeAleH2zm+?=
 =?us-ascii?Q?OoZcHzEP+97mPNdg/cuNmpUerMY/SfId4bIVj2k6T3D9lhmW7UTqs2XH61aq?=
 =?us-ascii?Q?Smi8sxQjipOtZedJ2zn/1zBTrMAWOWYPN4XeW5P4szzzeSOuBSkyhE8vdmjI?=
 =?us-ascii?Q?HRR3g9qjriQO4ca1+dOBGrPzAVBB3/NMW02VAmqnER8fZtxV50sSTWCoThXw?=
 =?us-ascii?Q?38y6vSUmNvpZ4NxDhNK79HSdaHVxEJyxIvSfcQy4SMoFN/qVJw1uGYsAgeDV?=
 =?us-ascii?Q?l3X/2wBHxzzMLOUw2g0c6RznVOMPdFDmkitHP0zxGfPU4dJG1SHGLa8L8rJS?=
 =?us-ascii?Q?HBFVz77kJFX70SNFdDlS9sxpHZiiqslE4DOSalFBSMA4NidQMAjirYOKzWJQ?=
 =?us-ascii?Q?titkn9/UlcWQgnItwAFNZwtvk2+bYgjJlzBr3Vfl3oRtybTxOEB91Ok0SW2Z?=
 =?us-ascii?Q?6Bc9pSNqR1hK+M+m62vK8E3MPTdOzkJdb7SbJTjG7XXSLMfcjaViF28BWfI0?=
 =?us-ascii?Q?IQL8Gy7EfDa3WEIYIvncFQW8jdMV6u8rY9D9wq6z7iHjncWRfiGoX5agJH0M?=
 =?us-ascii?Q?6jFDGPl8jA0IOtN44n7qigz67Wu4Wbd8N3w6+Udw15gHmFmMCOQWXw4J2mbv?=
 =?us-ascii?Q?pDEdtjxRqdpECVj83LTcllbkQvhNlRTGpzAANDwpzCThR565i/XG9saDrMus?=
 =?us-ascii?Q?H/Zc6uL6OINc/6Hp5zfY/1nXYsD7EgCq7iqC3n0mD51hM54/UoF0w355kO2F?=
 =?us-ascii?Q?gIxXj/8bqodra4VgnfIRFxkCGyQH+kY9WOMhQ9AA8Cx9c6MHZB/CBdtElXkI?=
 =?us-ascii?Q?xMR2p3+AhTXXlemLjb0kbSVaAIoi8aB8+qnqXSBJFKyZEdL+2M/aym8L5vVx?=
 =?us-ascii?Q?s6yGdDVXnYS9SuOsS60Udv3UNJFO8BQx56lWaK6GKnA1KfF11MYF38MT/fkA?=
 =?us-ascii?Q?LBPSOiyoBd+gItevt0kUSBiFMeZxUmpM6COyA5hdNihp/u1LopSAJQGrur5C?=
 =?us-ascii?Q?oFfEz0McvFvRWINu9ujvbNtUhBVkqccpniYlyXV+nnaY7TuWpP3F/5Ngei5n?=
 =?us-ascii?Q?4Vaea1WEAIVrzLDFSpoqjGdogR7YtmdDu5Y516wbWQBEFHDjjlJypNrhImsq?=
 =?us-ascii?Q?jn0re9t84jFw1IfpO7heAWq+Nn9aGfLgbgNsPpmyENAxCRxJDAT5Nz8SI9aH?=
 =?us-ascii?Q?cnN1IY7fU8f8kNwocg/jWNPFsZlEBsT0NMmDLddbd3SjHe3HGDscSVV8V4GI?=
 =?us-ascii?Q?s++SutJyoBWhYl9nvc5KLDEEJqjjUUrzaGGthtIin5TCNDgdMO3y9547W/wE?=
 =?us-ascii?Q?9LRLTGJobgDiiX15aVweiJKn9hNwJU+OOTGvWvip9k8NKrBB7TVyN7LfVoBq?=
 =?us-ascii?Q?kAoOcPEyBjiMmF76biX0bSI3HXugQ1d2Pejx3PbOXLjSl2PNJkI3/RNrHW6+?=
 =?us-ascii?Q?p+Fl4YS/aY1v5KFoQv0rAVZGg5+881uMIxt32OnCep4c651mWL5yY/Cd+F96?=
 =?us-ascii?Q?RkNJAT3jPYTBQokxH7xDfnLTB6c8bGw52y5zVvujmX7PDQM+Dyg2S5IGYfQt?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef215a19-3805-47b0-21f8-08dc58ee7516
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:40:37.0624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I94GzR26FPeksCnQDD5gszRI66qubU+i366ZmAKEaxiMhccxt8S6tJeqyIhdJXGRDkKmlZ7MrIX3WaztWgWZBVUGkQB4N2mOhXlhJj1ewt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5125
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 10 Apr 2024 13:34:57 +0200
Subject: Re: [LTP] [PATCH] mempolicy/mbind: update syscall tests for
 weighted interleave
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
Cc: ltp@lists.linux.it, Gregory Price <gourry.memverge@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Apr 08, 2024 at 03:40:38PM +0800, Li Wang wrote:
> Hi Gregory,
> 
> Thank you for starting this, comments are inline below.
> 
> > +#define MPOL_WEIGHTED_INTERLEAVE 6
> > +#endif
> >
> 
> And can we move this common part into include/lapi/numaif.h,
> to avoid defining this again and again in test cases?
> 

I have a pending patch to do just that, but it is not upstream yet.

This was a comment in the changelog:

> > MPOL_WEIGHTED_INTERLEAVE is ifdef defined because it is not upstream
> > in libnuma yet, so this ensures compilation.

Thought it was useful to shoot out a version of this before it all lands
for the sake of getting ahead of the curve a bit.

> 
> First, we do not suggest adding any new tests by applying one "big"
> patch especially since this contains too many other irrelevant
> modifications.
> We'd better separate them in single to guarantee everything goes
> well for traceability of the commit.
> 

Will do.

> Second, I don't see any new code in set_mempolicy06/07, since you
> only copied them from set_mempolicy02/04, even without any change of the
> comments, this is bad for test maintenance work and involves redundant
> stuff.
> 

the only major differences between the tests, presently, are that the
policy applied is weighted interleave

TEST(set_mempolicy(MPOL_WEIGHTED_INTERLEAVE, bm->maskp, bm->size+1));
                   ^^^^^^^^^^^^^^^^^^^^^^^^

In truth, this test isn't really completely, as it should also:

1) Set the sysfs values located at
/sys/kernel/mm/mempolicy/weighted_interleave/

2) Validate allocations actually match those settings

However, this test is quite complicated to write and make fully
reliable, as you also need to know

1) The environment (available nodes, cpu nodes, memory-only nodes)
2) The node the test will be run on (which can be forced)
3) Where allocations will start from (node X or node Y) as this can
   ultimately affect the final distribution.

In my tests separately, the test itself can also cause allocation
(stack, other regions) which may result in an unexpected distribution of
memory on the target region.  This is because those allocations are
credited as part of the interleaving, but the existing code of the test
cannot adjust for that. This may cause failures for no obvious reason.

This is ultimately why I left the tests mostly unchanged, because I
found it only reasonable to test the default behavior.

> The recommended way is to add MPOL_WEIGHTED_INTERLEAVE in
> the original case if you just want to validate the behavior similarly with
> MPOL_INTERLEAVE.
> 
> But if you want to test something special/new of MPOL_WEIGHTED_INTERLEAVE,
> I think that's necessary to create set_mempolicy06/07, and do something
> validate that interleaving behavior is executed based on weights set in '
> /sys/kernel/mm/mempolicy/weighted_interleave/'.
> 

Was hoping to get input on this.  I think probably trying to write a
test to track page-distribution of real weighted interleave will be
difficult to make reliable, so maybe I should just fold these tests back
into the original and note that this simply tests the default behavior
(which is equivalent to MPOL_INTERLEAVE).

That may require changing the original tests to ensure the sysfs files
are set to 1 to explicitly avoid failures.  But I wasn't sure if that
was ok since it would be making silent system-wide changes, and would
require root.

Thank you for the feedback
~Gregory

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
