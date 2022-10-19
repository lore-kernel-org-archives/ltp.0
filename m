Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6375FC4332F
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 03:16:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A6103CB0FE
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 05:16:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB4F93CAC43
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 05:16:11 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 049A3200ACF
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 05:16:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666149369; x=1697685369;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2s7VYseSaSfiNpHI5iy3vAL1vGxyAOI/WtHWMERiNjs=;
 b=cEvOG3jnHSqAFQxJqD6VW3HQduMopMtkGjshqQKL74kqY/IGXGcI3GAV
 xpGmI/c3+toVm/UkvpALtsxmiBafxNgGQPOovYKl8QRvMH0ovhQn6IbWw
 y0QcKZoP+CBAbFdoYisId9HVigmeEIlhtxABYzpS2K4r6t3IMEA3lffJf
 vdiFRKy50L1TVRe30sWa1lXck9dYHzSt2MiA0OZn6Z59nnegJE4EGPgFE
 FxrGqaeKezPhcZnNUJ91g4IkVHOrz9jQSVFt8VjGwC5fnYvNrXNxLld8C
 /Ju3TUBlDjNiiL4ppHCmWeqbeHVS89gw1/j6+hpx6/ZMm1Q32BLAzX9NF g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="305029016"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; d="scan'208";a="305029016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 20:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660124035"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; d="scan'208";a="660124035"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 20:16:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 20:16:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 20:16:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 20:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkT15OMS8soiQWVcxuht9y3XGs90OQ8sa5jOEuksVIRi4PfUyTq5yddhNiiQjDZhkgKo/9iFpIudgEmLp2YjB7Wpy9JhltYnzAbuI5ujk/kwNOoi8QxV1wpyGvWFq/nVPUjABq/e1tZTsBkW+fvRgqaUTJibJ4HioMq3lf1QJ0sM7LN7TPpXQwdMum9iyvij3MbXaG9Us0ZD+/FmInBIx7UglrtMauvK/YDc1wVPv31e0JJ5M8+nay+ZazyRE7ZqkmbJnGB0/Xc7TPIAK6JKPwVpIyZr7QZHDEhGxHL6cqByl4be8gfQNT8YqU8ma4EKCaFFtRzYZWN+G1DJoM/VQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENoSfoDUeusE6Uexdqlb36h8qFzoNCI/wDPHCYFOkXA=;
 b=i5enhjPdrPfzDqlAQB7HXr2t+2wbGorLE2eDcDcuWrUJ6mc44/HVZ0yGvSt7nkpkRrB/R69di8NvDJ1KFjOhwXZ2R+0OnRAfoM3NZyX5767eBOtsEw+O27lYen7/8BX7mCBBtletbrJee5sprGYlhJrfOsVSJhxtXErdD6z8ntEbttgGzy93yH83oyj5yc3xpz+7JDSeZgO4rPO/HxpqEYfUFI7P4ccKhXeHOTKxEmwFQyRyaSG2JwWFfpdLWNGe4K+s6k4uTjdo/5b180mXoBm+hSWAebfjUxO6BQRjfB6Rpk33joy8jcFmcmU76zXQMARirCQIlYl7zdZDhaE1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA0PR11MB4624.namprd11.prod.outlook.com (2603:10b6:806:98::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 03:16:00 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 03:16:00 +0000
Date: Wed, 19 Oct 2022 11:16:07 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y09r93VsOg5j2UcT@xpf.sh.intel.com>
References: <20221018152527.4636-1-rpalethorpe@suse.com>
 <20221018152527.4636-2-rpalethorpe@suse.com>
 <Y09Vf7XnoXeEcxJH@xpf.sh.intel.com>
 <CAEemH2f3jrhXj7x5p7XkcTwDf3M=DK0yOyt6kBHfknSzkXJSPQ@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2f3jrhXj7x5p7XkcTwDf3M=DK0yOyt6kBHfknSzkXJSPQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA0PR11MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cf255d-6c63-4d1e-2d05-08dab1803f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Y8I/OOUBz3Ss5L5isWfy47TbRDAN+aEoy3OM+X/6lKyxKuMt/I+9daHGrNDNkdsO9aAvpv2xeJRVMuep1QxJjMHgu/gso0yIYidBwvq2E6LDTgSz3IB00+6nY2Bek4dGnlYx9lSjqXP4HvKHcsFfVkQue9/908Aewji7x/p3z4f0mh+tiNIPIY0iS4blQtyIAcqHGwyKsFrJehXh8nT/aduLjbkVdlADfhdxkYeBN3sRDfh0JYiBURDJlMGAF9wtmeFbBGQev5IUqvL0f1wzkgstqLfM09Gvg4Iv/lIPPusQ14cqwHlkS6Z4Hzi5v+VH04qm28Ps+DzgzY+a5wO2rGP1enn4+5XMtzdn7w3haIxwzdjU4ckSYz7k5EVVxLEXm76TycdOjX3se6nvHj3oFwc7RVgNbptviC36daUECVIHirViWHXP50h+SO7nMR3HJNYAsJLkul1EMgWJY2wXHdyiPDqAboiyxXls1l5RyLU6iXhCsrCaALGRMzNEnHcda9WdVXFuH2qgMLyj6S5m9rRl8lmluJetyNSVkBfyUMG92AbzKWm6/sB5EPf88ZlQ+XN34pBVls4/KCV3dkBcnp/NPuGoecrkFwAqFvm9dUaYg8RJKZ3Caxo4YHbupl9U+F9/dXpjFH1IpRyqv098zgBfSfQdlYx5NJG15l12z/WeQGcPxBZsRupYgyksI7k/mzrt1/v5B6gnBEWCQDUFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(44832011)(5660300002)(2906002)(8936002)(4001150100001)(82960400001)(38100700002)(41300700001)(4326008)(66476007)(66556008)(66946007)(8676002)(83380400001)(316002)(6916009)(86362001)(186003)(6512007)(26005)(6506007)(53546011)(478600001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSvT/A8L0Wo3nsQyYyoZu3kLlYnHrXux571a3ma29hmEO6FGCM1ire9tioIV?=
 =?us-ascii?Q?pn9y4jJ6E+kICIVnyMIGC8GrUL5iwEvB5d2EftjYFnKSOqTejfteYnYTYYbF?=
 =?us-ascii?Q?xYb/Q//sln8Ayk7+goYqo/6SrOYxAiiBkW2dQV24P2XK64wtQJlgf5cX/aY4?=
 =?us-ascii?Q?FnIgtRJa9Db5feZgVBKMrj5YkhUneySMyEsgvDdUZQvsjJxiCQZU2kZjOkjp?=
 =?us-ascii?Q?9xhOqInCKXN4sZIDNIRxbKatn/bl4grYAfHig4XK1NaH0y7VPxGCTcWj+wPw?=
 =?us-ascii?Q?A0S1XeUJpmt6LhB3u6avS8LbSi2wuqKMVWrr5ETaxonKS5hVKPu0ivTg/oqF?=
 =?us-ascii?Q?dr818gOCyURhqmykoe3rMosQDy4ELFML5OyGzeYEnX8WPw7vN0c06BMZGa/s?=
 =?us-ascii?Q?0To/2nawMiMVugRcgYnxupDyefZaMObGIysyJzrMzrRcLbnDs9EvaWvQV0fW?=
 =?us-ascii?Q?r+KtDSmlRiL78/F4C9rB7ZzsXsypOJLi4akxfTZc7nSMlrBEAQOfCe/yN86w?=
 =?us-ascii?Q?Kmuu43WL1hYbbTex9sWAkrv+UKnXMRRjTBJMTNjBFbRzWr3bXjs6HJGUysOA?=
 =?us-ascii?Q?YbBUbKoy1/7HwFQZisX6wlACjdEu9UZazJ3T7GpRWEUNZ7tn0fhejBKAmREn?=
 =?us-ascii?Q?MaZTWWvD92NUH6i05keDButLtjVXgLpiCohr5oMWGY0JN0Wpw4EmWJIMX36f?=
 =?us-ascii?Q?VeUy1csC608taYMtFju7Fn7WA8qSGLtpjt08K7WZrnyo274C3x1Lad1NUTSQ?=
 =?us-ascii?Q?Za0qOy9M451DCIMBdYSxIH0Ui7SioZDLM+MiG2+UmsSI8X0xVNLYHibs8ev0?=
 =?us-ascii?Q?iukvNlSJlysA6Lg8DNR1fRK7+Q6kMJYp4DOKypDi626EtdyJI51ePdLrC+xW?=
 =?us-ascii?Q?2NAr/Hsdv+RPLtCRmutVB+skuC16Mx7sOz2eEathsF9G109x0RJTPvg5uFCQ?=
 =?us-ascii?Q?qb+U7gW+/OUjhOYuVYNusGpLMdo71nztEX1ggnf6rmClYpBGoRDs7O83RyQ3?=
 =?us-ascii?Q?+mnYe44HfMb2ijfv8k9ZX3s9n3wpHBhjfs3sI0szNd181wo29AIW8ci74WFr?=
 =?us-ascii?Q?ruzW3a0vzUJ8nZ3TxlokHIKkq9EZWsPXHfiordU0P665ZBeL3O2eBrktQ6P+?=
 =?us-ascii?Q?0jGPlxt7vHIxI7MRFlHlQOZl7z/aalxuppMoSbeChu1Jjj8+AJ0wps9Uty1E?=
 =?us-ascii?Q?1iNtrPucOSUSDDfiQPhz6LEwazVJn8pfMY6icJymwHT/K7R64p8XYnan/r/F?=
 =?us-ascii?Q?olaqKBCBrAOcj8d4lDq+oeaaBNBxOlJJvPT/OPGDdgqX5b5LwEd7pfQp9GXd?=
 =?us-ascii?Q?gUJhlFhLleE7tRkT4494JW2PVN5d34SzHw8kbA+fMqNjlnuB1CmdVTXXGB6m?=
 =?us-ascii?Q?1/xLyLiVh63YzzKF+AcTt6506vY8l3S6v/+QTzNfecTY9QDpbvV9gC3Mno7l?=
 =?us-ascii?Q?WIpiiflY0nelMtSA9Od9BVrrZUstTcdmRXdOb1uiKBAVERO7O0YxtW7ekFJ4?=
 =?us-ascii?Q?AwwLieI+WNswpWK0IqGy+kUrYUZ+0UJKnGIfoBY4wTQZyWtW9uGOOMPgnWmh?=
 =?us-ascii?Q?znBEt6SWzekOHDDZypE6Xs85PT0lqetjjazLLA+PtEBhic41xa7obwhcqI+d?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cf255d-6c63-4d1e-2d05-08dab1803f25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 03:16:00.0771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ee2LMxXrMHHzwtaKir9UV9JhFG4lSjAP5Ou7MY8F4BqovjUMK25vQVH+6DmWpTZHFeIs+Z3MtgZOkEmEcBEhOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ptrace07: Fix compilation by avoiding
 aligned_alloc
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li Wang,
On 2022-10-19 at 10:59:54 +0800, Li Wang wrote:
> On Wed, Oct 19, 2022 at 9:40 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
> 
> > Hi Richard,
> >
> > On 2022-10-18 at 16:25:27 +0100, Richard Palethorpe wrote:
> > > Use memalign instead because we live in the past.
> > >
> > > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > > Cc: Pengfei Xu <pengfei.xu@intel.com>
> > > ---
> > >  testcases/kernel/syscalls/ptrace/ptrace07.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c
> > b/testcases/kernel/syscalls/ptrace/ptrace07.c
> > > index 6bd2b1062..a60c2a49e 100644
> > > --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
> > > +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> > > @@ -35,6 +35,7 @@
> > >  #include "config.h"
> > >  #include "ptrace.h"
> > >  #include "tst_test.h"
> > > +#include "tst_safe_macros.h"
> > >  #include "lapi/cpuid.h"
> > >
> > >  #ifndef PTRACE_GETREGSET
> > > @@ -95,7 +96,7 @@ static void do_test(void)
> > >        * of the XSAVE/XRSTOR save area) required by enabled features in
> > XCR0.
> > >        */
> > >       __cpuid_count(CPUID_LEAF_XSTATE, ecx, eax, ebx, ecx, edx);
> > > -     xstate = aligned_alloc(64, ebx);
> > > +     xstate = SAFE_MEMALIGN(64, ebx);
> > >       struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
> > >       int status;
> > >       bool okay;
> >
> > Yes, it's better for LTP compilation. Thanks for the patch!
> >
> > I checked SAFE_MEMALIGN(), it will verify that the buffer is NULL or not.
> > "
> >         rval = memalign(alignment, size);
> >
> >         if (rval == NULL) {
> >                 tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> >                         "memalign() failed");
> >         }
> > "
> > So could you remove below unnecessary lines in ptrace07.c, thanks.
> >
> 
> I helped modify this and pushed it, thanks!
  Great, thanks!
  I tried that "SAFE_MEMALIGN(64, ebx);" modification in ptrace07.
  Ptrace07 works well and passed in previous reproduced server.

  Thanks!
  BR.
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
