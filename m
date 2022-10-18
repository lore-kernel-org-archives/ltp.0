Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F21C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 07:28:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0551A3CAFAD
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 09:28:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32CFC3CA06D
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:28:34 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E187260067E
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666078112; x=1697614112;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FRoP4VXb4VTcI1kXATBH86rbwYm4g3E8Y/DGWEEz0QQ=;
 b=gi0GU7ZV6746rXFiKnSnPyforh9+QRtQa1rgNTBvMcMu2GCp9hpK09iT
 2Wp//LZiVtlypuk952n8g/C5LjaGf9DWZjssC4p2y/3OyGYXzNTIiRS97
 95lWdMZWv3B4FGGpXDZoAdUgnjK+R+fESP1aY6kq8+yd6no4bynwP3+Nv
 EwnyjORYgVrClMxqINK5rN+MKpby9HONo5GsDnN1C+PsgC4WjUiO2KRuh
 /iEqJ6dWR27LMHVN5IR8TZXRH96XP2wzlHg8qAPPherGat/9BsNlj8JQ/
 rL5g4nPSViaGxRBwR1wihZRo8CXWWB+F7f16Op5wlL5r2jemcWY7Td5ZF g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307687297"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="307687297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 00:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="771080695"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="771080695"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 00:28:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 00:28:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 00:28:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 00:28:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcbFJXheziO5fVs1DqfTrrH3WEtoB1Eq5GMnr3ArCwWGgY3Sqlz3Hpg4DtNpHNLmTcmIkToFbjkQEz9hQiV7WmXnph/Q3MxhX1leds2p29htXbex0Rpf9/esYRbIw6DlfmgHvKuQCuf9o8t27m6euA/eAB4ntpJG7Hv6rOj4VWaWCcutrKnR9V+7GwrGeY8ZNcOjSi1Fl3MaHE40Wq0mh0t4lL3LTk3qp99pQodaMk5aLQHcKijauQPIUEa4eUpOwUx2XOD2V0G+ePLg23jbVQiDHo0JezVYXUnEuG+DFgz9JJz/67huk4Aq4uwv+5Mn+ipGzq/FWDTPZ7x9vwSHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG9JJdKA2tRRl6777jvmFtJlZg02W7TbhngHd5k4t9w=;
 b=bx2WGGYvAE0162Ruj7dmuJRRwfvfcg/E0+2jASqx2B0cpHMaEQ2p8kBb38ZLyPrODWoInpgnaDY4IECieBk/RFiVmONn61EYzY1iuOcs67YvUdyFYsLuVFP8Pqx31IfWf10AvQDkSgSCa84HVRCayWB1+2fw8qeV2zaPx+Ih5IQ/awgd0qoRgPATkVac92Kop3ln/Rog/L/zU515nS7yHKZP02aHBCgi9evUKQe+EeXWIMKYI0zkKZ7mL15ez8kLWp02wONK845APotN5nYVPBrtmVcTXMHzQVc/0pZxk4MNj9ctT9MkYxWAokzhGASOZwE28uHdHaJnc5yJHRhMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH8PR11MB7143.namprd11.prod.outlook.com (2603:10b6:510:22d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 07:28:26 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 07:28:26 +0000
Date: Tue, 18 Oct 2022 15:28:28 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y05VnBdOKEGXFUCk@xpf.sh.intel.com>
References: <cover.1664418361.git.pengfei.xu@intel.com>
 <466821336a63ab9b6c236a0a1c4dbe056b7a5ac3.1664418361.git.pengfei.xu@intel.com>
 <Y0kD/eENxCPGYjOg@xpf.sh.intel.com> <871qr6o7xc.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <871qr6o7xc.fsf@suse.de>
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH8PR11MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 66171870-5017-4da1-3c38-08dab0da5857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WOy4CtUG0F0PxCeCYHGyUkdQDPCbBRcrVo93FnM1eZgfdCDysWo3y9oFrlOpZIWEkfIVi0TNphf2BG0Mv2NkCJ+nby60jpMAdTeDJ6GWBlIECJ8ernSnXQ7RGThB0u6K1i4fLC+IdoJTt7mU21G01VbgUf2xLtG2JRGmYN3tiwivFNq4rLDNCqNbY1or3Tj/ikSIbL9R4Y7XC/HEJkFJt20x1HoSZcu5ro6AU8NCOl32XB845deQRXbI5LfOFWfh/pOcdHWzXKfa+Zl38v/n4u8f8ezq9c9AFAzvlZtd888dqN8Ayrw2AdFxSoiDmFCw/xigoO0xxLsaHLsBcz3H19TbsWrz0KZedq6xWJDxeXtiggmzxKM83GOwkVKTf9kCkMV9zkfffZ3hbxuUzz3GqkRzMD0Mv3ACyznZsM9Nrl4A4uDKbIQg2trN+QGiN6IqiLQHIuaOBHem3+CRM7nsa0CcCboykUAwaRZvIehOhJKuX5A7pL4dBP6Sr1sARFgNaJ76phTVC1PtDb6jcUPCUilwa+UYqOrk/aAYmDD5wpWqq5ULf5VUT8VJ0K5hGK7UIOnHoJGY/mNvoIwW+5dDnZ6CpPlAGhdrSGtKCPM8KXEe0JXX1m4R4U6S/6c2QPfRuinHBhidK4MXYZApxhvpfhEZMZj7U2remn2AMZlihyAjJosRmZswt0OhfkL6igZUNVwRFLVNFkqlhzZnydrzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(6512007)(26005)(53546011)(6506007)(83380400001)(186003)(2906002)(5660300002)(44832011)(4001150100001)(478600001)(6916009)(316002)(6486002)(41300700001)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(86362001)(38100700002)(82960400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KI4LnBFJCBCrmN9TkDZy20t3xaciRmyoaRle2dl46wusBuxaJEhk8/qx5XME?=
 =?us-ascii?Q?H+Yl5SMt1n9rC1UG4J5E/wxU00YoR/mF8/zQqa8qS8tWIAHvq/EbnmESQ+u0?=
 =?us-ascii?Q?tjedAsEpjyFnQW6hwjZ+paMOtwrXbnqejZ5ox7+p0EzwfzVFFXPbvHyxnP0o?=
 =?us-ascii?Q?N0X1QnZUu5xESczpfw7KuOSgdNtxwAcvCKoZupudTb3IE3Oj14k70Pjya0rZ?=
 =?us-ascii?Q?VMA+UJ5VsA4ltvFF/D+L0FSW8sQsYgzGxKEUHXOLVWkvxlqXAY+5gJpdFzii?=
 =?us-ascii?Q?OcEHZwownFwp1GY2l/R/ZlNk5/jAdNc6XoSVELdcgjR0rfJFWqwz5dYGnw1A?=
 =?us-ascii?Q?/ZASo/NPfhpaXJkPA8HC3wFJtR8gwBqlHIGJkn0nQpEO32d2hQyphu5jPN0S?=
 =?us-ascii?Q?2e8iDDs33eV7AZEVOr1Y19H87YtbURKfkJX3Yy3fZwqRVMO3Msq4LaKowyEx?=
 =?us-ascii?Q?rPtdOAubJh1DkJIAzj3as9iR4JLrBvP0TjXAhZBuPJgbeeDaQOf+qjgARRZB?=
 =?us-ascii?Q?ktSNPwPS6xhg02DfbCb0w4mvyi0OvWZlUuBs9bKUii6CnxM95ylbp8lc2N8S?=
 =?us-ascii?Q?8D0gK7XifmZi/0pzdGNU3FrTT/wGIzCkRN1JoSIlw8O08v7KPD8eU17ZdjGs?=
 =?us-ascii?Q?GqC7pn+w+3gncUH8IORJZR3CP0I1f/blvIhP7kN1Y3YDK/vj8Guvxph9+3Lp?=
 =?us-ascii?Q?VzOvWiCJvkZvKF1EI2UPRL2HFtieH/rv9KPpMc1QRLJqAY8iguH39gInozOU?=
 =?us-ascii?Q?zuvgQCIaBrHkL2HpnAypE0QZFLddj30BgPpyRvvcLympWNqgwh/JkjWn4PoB?=
 =?us-ascii?Q?Vok3hca34ExNG8Rksr2onsPFNVfSPlYLEibPF6nbMgSopb5hvv9F5K+hHLm/?=
 =?us-ascii?Q?neZUGmhD5jno/k9+pdQZ+AZ/o8k2ZQZHy0bdX3g1PVETei7SBNyaUJ0g5Mtj?=
 =?us-ascii?Q?qsL3AQxOUS0YAM6op2CztGhfNSykhWlfPtrxeetbhlAWPJfaMJvo7XfQGpHy?=
 =?us-ascii?Q?PX33/hbBQPKdU3TUj/hxohyYS7mW4bE0L3d72BY49dYYRV+xJr6QrHrXpssb?=
 =?us-ascii?Q?C+fysu65laubFDEl+6k+hLSIeuB3FB3iM9DVnXm+CyEw7bqdDNASYhVOuyTD?=
 =?us-ascii?Q?ynzY2ODYLzqPh0AlqDAkPYm33+cadQQnI1Tt2ahGgoTkJpuiidyUxws4BJLZ?=
 =?us-ascii?Q?yF2Tw/88AGZYnM98vwhFFYrfDq7tfgyubRGgIUJOF+DfwPG6KbUbcVJ+W/Ty?=
 =?us-ascii?Q?AgrEvhzWsU9MLjHnyMVPn7FaOUGZy71BRMy8y8botbXQV9Xafz8JDCxHDmPo?=
 =?us-ascii?Q?21NBTLdHWLlVoQpO1M423ZPHbsXeaDyRKUzx2mzPnwWZUjZvuw0jMimeYj0f?=
 =?us-ascii?Q?zs2X1ySx2bvN6F9k6DMYZqgby46VSgJ59xwMb6sGx3P1KomxFNcjxiyv/iBl?=
 =?us-ascii?Q?v5BGvOgwnCCSwTt4RGWSCyEoLRCRXueTr7Dydju9RPElLZcVni5v6pEmVEXa?=
 =?us-ascii?Q?tRK1/46kupmVBv9TUxT9fqAQNROyiMJLvS4nVgUfGX34gMQXZFtOZQ60Mv+F?=
 =?us-ascii?Q?/H81sAW8YL5wGWpGYv/7hbIFTfvKF0onn4dbkWrj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66171870-5017-4da1-3c38-08dab0da5857
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 07:28:25.9236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5h2UqsF2uzZTD3VFoAOFPGDMXZuTnGaec+yNtVRexdjEngQD3dBZqaxpRDqiGYA5goPULm/nnhlwrzGe25sT0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7143
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ptrace07: should not use a hard-coded
 xstate size and use CPUID specified instead
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
Cc: Heng Su <heng.su@intel.com>, eric.devolder@oracle.com,
 chang.seok.bae@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

On 2022-10-17 at 14:55:29 +0100, Richard Palethorpe wrote:
> Hello,
> 
> Pengfei Xu <pengfei.xu@intel.com> writes:
> 
> > Hi,
> >
> > This patch fixes ptrace07 spurious failures when the platform xstate maxium
> > size is bigger than 4096bytes(512*8 bytes).
> >
> > Thanks for comments!
> 
> This patch causes the test to fail on my Xeon workstation. The problem
> seems to be the cpuid function which just fills the args with zeros.
  Sorry, I didn't meet this issue,  I think I should use a new cpuid function.
  Thanks for the report!

> 
> >
> > BR.
> >
> > On 2022-09-29 at 10:30:20 +0800, Pengfei Xu wrote:
> >> Should not use a hard-coded xstate size(512 * 8 = 4096 bytes) which is
> >> wrong, should use maximum XSAVE size specified by CPUID.(EAX=0DH, ECX=0H):EBX.
> >> If the CPU's maximum XSAVE size exceeds the hard-coded xstate size 4096 bytes,
> >> it will cause the ptrace07 case to fail as below:
> >> "
> >> ./ptrace07
> >> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
> >> ptrace07.c:142: TBROK: PTRACE_SETREGSET failed with unexpected error: EFAULT (14)
> >> tst_test.c:1571: TINFO: Killed the leftover descendant processes
> >> 
> >> Summary:
> >> passed   0
> >> failed   0
> >> broken   1
> >> skipped  0
> >> warnings 0
> >> "
> >> 
> >> Reported-by: Eric DeVolder <eric.devolder@oracle.com>
> >> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> >> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> >> ---
> >>  testcases/kernel/syscalls/ptrace/ptrace07.c | 25 +++++++++++++++++----
> >>  1 file changed, 21 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
> >> index da62cadb0..0accaceb5 100644
> >> --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
> >> +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> >> @@ -35,6 +35,7 @@
> >>  #include "config.h"
> >>  #include "ptrace.h"
> >>  #include "tst_test.h"
> >> +#include "ltp_cpuid.h"
> 
> This is from the old API (starts with ltp_) so we shouldn't use it
> anymore. If it is being used at all, then it's being used in a way that
> would allow it to silently fail AFAICT.
> 
  Thanks for the comments, I plan to add below __cpuid_count() macro function
as below in ltp/include/tst_cpu.h first, there seems to be some other place to
use the cpuid function.

/*
 * gcc cpuid.h provides __cpuid_count() since v4.4.
 * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
 *
 * Provide local define for tests needing __cpuid_count() because
 * ltp needs to work in older environments that do not yet
 * have __cpuid_count().
 */
#ifndef __cpuid_count
#define __cpuid_count(level, count, a, b, c, d)				\
	({								\
	__asm__ __volatile__ ("cpuid\n\t"				\
			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
			      : "0" (level), "2" (count));		\
	})
#endif


> >>  
> >>  #ifndef PTRACE_GETREGSET
> >>  # define PTRACE_GETREGSET 0x4204
> >> @@ -48,6 +49,8 @@
> >>  # define NT_X86_XSTATE 0x202
> >>  #endif
> >>  
> >> +#define CPUID_LEAF_XSTATE 0xd
> >> +
> >>  static void check_regs_loop(uint32_t initval)
> >>  {
> >>  	const unsigned long num_iters = 1000000000;
> >> @@ -83,8 +86,15 @@ static void do_test(void)
> >>  	int i;
> >>  	int num_cpus = tst_ncpus();
> >>  	pid_t pid;
> >> -	uint64_t xstate[512];
> >> -	struct iovec iov = { .iov_base = xstate, .iov_len = sizeof(xstate) };
> >> +	uint32_t eax, ebx, ecx = 0, edx;
> >> +	uint64_t *xstate;
> >> +	/*
> >> +	 * CPUID.(EAX=0DH, ECX=0H):EBX: maximum size (bytes, from the beginning
> >> +	 * of the XSAVE/XRSTOR save area) required by enabled features in XCR0.
> >> +	 */
> >> +	cpuid(CPUID_LEAF_XSTATE, &eax, &ebx, &ecx, &edx);
> >> +	xstate = aligned_alloc(64, ebx);
> >> +	struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
> >>  	int status;
> >>  	bool okay;
> 
> Adding:
> 
> tst_res(TINFO, "EAX=%u, ECX=%u, EBX=%u", eax, ecx, ebx);
> 
  Thanks, I will add it.

Thanks!
BR.

> prints:
> 
> ptrace07.c:101: TINFO: EAX=0, ECX=0, EBX=0
> 
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
