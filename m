Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF4FC4332F
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 06:39:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 146EA3CAEF9
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 08:39:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FFB03CAB0D
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 08:39:03 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49E92200DB5
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 08:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665729540; x=1697265540;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yIc1YhXED8i01yCwKr/1UsmXtDidrHefx9D1vxYvYjA=;
 b=ABVHTEHvypMe5PBQKI1KC7wYFmbGyLqsKY2DQs0OyiyKbQHhwiDj8l7k
 4u+bTZG+W1TjEKGAr4XSEZACn6Yc2frbZWR1mFuOK1P+73Axtly++/sQH
 VEjE4AqmHWBYZRRLl43vxybsxa/sOlgK7Zkg1fUAa6BXqlubfuCpY1tSs
 fDolJcn57VlBHVwnwBIov3nP6hVdDR7uNy2NVpAMyTO6uYAN0J+b+bBMS
 r01gnCvCifU+s8afcrKoNvSl3P8YW4XhCOvWH1X6UgFQ7OKBCrlNi01kG
 RkqDDeuVutUgRYGNvqW+Hcj4NwKVS+lD9geI4JTBGrB2gUq03uDRgT4Ob w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="292653906"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; d="scan'208";a="292653906"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2022 23:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="660627040"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; d="scan'208";a="660627040"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga001.jf.intel.com with ESMTP; 13 Oct 2022 23:38:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 23:38:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 23:38:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 23:38:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFywRiDuZibafcQheumndpdBXWUDDQ1f5koZzMKbhwYQw1aCBVwBRyRwFjlAAblLlfk6BfdOx5kNiqThBq7JFSaCtm6dQ1B7B5wsazL+QjP3AFO2P5py+YAdSnDnBnueMBjK8pUYpxKetL7ezMoT2M3zpvoGu8zuz3zZcW2Ca0pLgUfaIQKpqDpzk271rqR0lYWLBHXpxRtmExyNvGnWn1x4dz1EhyqDHcpvyLCNg8MvY7RXvulWjirVE1NJMZAeqWZbvBsSdn+ns/9jVdEMBW0ZVHXkYzuJy6VFri3emBLZly7flTy73VqpSFd/Io82uurc5TBynEC64CQENXpYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRIEcU3Sf8BoNQ1IIfHsEimcTF8msabTstvucfVXSxY=;
 b=PrWhWoCUUYNkaU1/86P5FmtuzudciXFL8v2VRpDU0MBsy3t53mcz+9CpV0uQL8BnKRL3KgKetti8MNwEmOn7STPNGBCElBVbugFgxMzF1rpsUJPxars+VKSkSsCJpvnxw0AMPY1cpXMokH6QvUsF6IDEEgwY3+IKKl0LnESbr3W1FVyg3AYg4h6VtFKCvJcfyBRAEJhzwfTEMCzXPpDDnoqaRtnlyvJ5R1QBfLX4W3ATNR1PRH60KBamkdBjdLS1h5M/zBvspTb64Qm89R2mny+J03iFr668Oakg0LGWkLyIzYrY9jg+Rnio+ottzbm3nM+IrBbVut5LV8XxrqeCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 06:38:49 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ff77:34f5:692c:680c]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ff77:34f5:692c:680c%4]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:38:48 +0000
Date: Fri, 14 Oct 2022 14:38:53 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <ltp@lists.linux.it>
Message-ID: <Y0kD/eENxCPGYjOg@xpf.sh.intel.com>
References: <cover.1664418361.git.pengfei.xu@intel.com>
 <466821336a63ab9b6c236a0a1c4dbe056b7a5ac3.1664418361.git.pengfei.xu@intel.com>
Content-Disposition: inline
In-Reply-To: <466821336a63ab9b6c236a0a1c4dbe056b7a5ac3.1664418361.git.pengfei.xu@intel.com>
X-ClientProxiedBy: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3af1f1-5ee7-4448-8555-08daadaec031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk6TM7SKXRPTRPI8vPzz7tHM3qo0aSg/2F5d4ZtBx30xMDpyzJKCaM5DHWFxdV0yq1h9+GCnoi86rgTBQoZ9O5Y0qwgEycySYdAzf2XbyWRiOSAvuuN7089jpLlWErhx8ww/qfSlNOART/ui4UTJyI9cwpmGN6MO/VelWya8/KnI7G/Fei5Ezpk0QaRAwKKpMzcFmuI2Z7OeAl3Q+3nP5pfguCzZJNKBwPRf3W2BDxWjVBzl6iEz5IyPHCQpvWx4+g40ZTBMh6PSjEaXIGOdywoE1jcP7qEWPW+lMrGijxfjALHcbAbaxIY+d018OPf6iYrK89r5Ky7/M7sVnyzwnQy1Gq/1Z0TkSCBIk2STYx+qIz0wHlpiAIL45h+5yVwmhAE85bwRWjI2GDdGU2mtVvZGgQguKU15vf3BISMenuJ/MH6qjBtyEYpWhzBF92sOVRq2tPSxOilOVyrv2xQsaiNySQL6+qXd77boFxj+Ovho4PYiFzGnPZ+FOQgz1UI8KlspV3i3jgTer3oZufN4zSP01CuRjBUMjdioqEcnKXb+xdcLr9naoFCguQzRCSPtRJAo5doS5euQEF+13wkXXDfWPJYEEfs0BO99ibQfgKskLgesjepJjZC8hW86/pITu7I6KEliUm7PajXlbMBkGGXj2Af+gzeGsRFjGZ0ZsC8iZ5Usm3qTm73Rem7rfnIOfcjdoK5ItBUOTxb/IU06qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(2906002)(44832011)(8936002)(41300700001)(5660300002)(6916009)(478600001)(6486002)(38100700002)(82960400001)(6506007)(26005)(6512007)(6666004)(53546011)(8676002)(66476007)(66556008)(66946007)(4326008)(316002)(86362001)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BS2l3VGPHSHkb5F0U/V46NR2AOG99hQHn1P0dn77CESzvE0kIsxe8cWdyIoH?=
 =?us-ascii?Q?vgj8dXhla/7nl6ld9F0+fJETr6clAFmPyqJEKgfVFNDONnBWuVX4aTyi6kAu?=
 =?us-ascii?Q?07kTIAFMdVllYzF8kDCnu4VQZRgA6MhRfQ/qR5M4qbZylzPqBcYLWFsKuPbe?=
 =?us-ascii?Q?O7vocYUoGKWLVQIRpTIIiKMP7kEkGBPwp4nyGt/zeNKRvfp5jbbqcc2lEURq?=
 =?us-ascii?Q?mCq6kN4iKb0K3frJkHwn+/+jktf/+qO2LdinEVSOM1um3IzihxoQ7k0iE54y?=
 =?us-ascii?Q?eCR2Hhlyu5WyNUU+5K47/T2dVgx8v+LLEVCTCidCZ/A6eSUU1bPzkjt+KBD+?=
 =?us-ascii?Q?5nOTC6BybRhnb7XASE70WV8YXSRQzTkQpg7+6Bf1MGhEWGWFAJWgsScILQCO?=
 =?us-ascii?Q?9OTxJlh2IpIc1XGpJ1sehcWiX08LGwlsDOdmOntIQ8RpD39g906A8K4kKBo3?=
 =?us-ascii?Q?+F9HUO8VvjzADxRzU/SNXebM3Xw4WiUGyQQdHEWiACMQuNPoGYAknDLsLFm1?=
 =?us-ascii?Q?xiIxXyru+/w6/e16CHmOSZ2la6iIimZmLI1YRkDcKZUTwqfNhxTv8QlpSCER?=
 =?us-ascii?Q?uKTlhnPxEZxEZBZSD4IsHvcfzXeEAAvkbYn57XX+QWxk3rmaf9NPxr0pSFaz?=
 =?us-ascii?Q?KPaCA7vllznA37itLIFBmrkF/MTSyJ5/MnqEEUFUH/Yez2TaWVGNM62i+XgE?=
 =?us-ascii?Q?Y8mS12aG5tglQTqLTz2sj3wbVgjm86xp5HJ9oZUJRkdldXbjiEYNJRLSUIph?=
 =?us-ascii?Q?QFlETQ1LtWpcU+53ZxZZc+tmLAdy4/HB4TKba1nCkZXgvY8qMTZ9ClQibBGU?=
 =?us-ascii?Q?XqWyDL5gEs3XG4DAUD1K50Z2KokVGmbBVn/S6VpsltrsA3hXZoe2oHIwTqqo?=
 =?us-ascii?Q?jRwuNKp4Tmyltyp64FMg5ceJvhlBe1mOeix1BQ8lgQbkrMei0Ak+6O1M8AMW?=
 =?us-ascii?Q?I1M+wDhBWRKuKqhtUu5qgCbZ7GoxQokQgYwjhz77Ek7DQUQ3Jg8nPzgHyvxi?=
 =?us-ascii?Q?u05eSPJqp/8xdvkHP4BecqAl2AmIBAhVo/FcS+/7TvexE8hIH4PWqEe/nxPr?=
 =?us-ascii?Q?OU5RE9dBzR/AAjqvSiQw0IIHcQXZnbywRnn5hvVKDyFXXVl4MntDUAA70kTm?=
 =?us-ascii?Q?ROgoWvL5Um/yQIrsrdSIc6VVPQQWvrhHHTQ+hCYzb4IpXZ6nnnnimkuOo6zw?=
 =?us-ascii?Q?74LDvK2KY7KZoe6shLBHOn/fRQEDbCEFCqlE+krOnSBK6rHFEISmqVV30VGI?=
 =?us-ascii?Q?3MriARjV18tL2HIUYWCEsMOvVAf1/gSuFAxG1h+W9Df6K6/7DbqA+EEudbIi?=
 =?us-ascii?Q?oittNH1ygNSmB175AcMFrux5nPI3MnNeuSRvOu/ee7uJjveBUU9FQDeTUdJe?=
 =?us-ascii?Q?LaM8a/OU6h/RVOJvpQxMlcBBw+Is8z8xrv2ItB+w/9gT2jfOwWok9v7sA0iH?=
 =?us-ascii?Q?/wwO+JhrjkcgApRRQzumhV0bUqFTIwYKRd85ojzyGVb+3gtzsFdwujxxzJJS?=
 =?us-ascii?Q?lURAfDKvlw+VM+/F1AEF66m+Duice1uWsBNLmEyiqBHDW+k4mx8n+jBh/w4X?=
 =?us-ascii?Q?eiW5DnPbieXtNxm3QGdFG7yZKQGB4nyTBxtCXjaWhegVWYbY4fWRf1eu72DR?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3af1f1-5ee7-4448-8555-08daadaec031
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 06:38:48.8294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czpzc1czTh++tN1MSb8dNdC3Ncw6clojMfewm57gCLASR5AcssSpzFnlqwYLtzoPLx4ksPLpjTREsKXy/tP/lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
 chang.seok.bae@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

This patch fixes ptrace07 spurious failures when the platform xstate maxium
size is bigger than 4096bytes(512*8 bytes).

Thanks for comments!

BR.

On 2022-09-29 at 10:30:20 +0800, Pengfei Xu wrote:
> Should not use a hard-coded xstate size(512 * 8 = 4096 bytes) which is
> wrong, should use maximum XSAVE size specified by CPUID.(EAX=0DH, ECX=0H):EBX.
> If the CPU's maximum XSAVE size exceeds the hard-coded xstate size 4096 bytes,
> it will cause the ptrace07 case to fail as below:
> "
> ./ptrace07
> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
> ptrace07.c:142: TBROK: PTRACE_SETREGSET failed with unexpected error: EFAULT (14)
> tst_test.c:1571: TINFO: Killed the leftover descendant processes
> 
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> "
> 
> Reported-by: Eric DeVolder <eric.devolder@oracle.com>
> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace07.c | 25 +++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
> index da62cadb0..0accaceb5 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> @@ -35,6 +35,7 @@
>  #include "config.h"
>  #include "ptrace.h"
>  #include "tst_test.h"
> +#include "ltp_cpuid.h"
>  
>  #ifndef PTRACE_GETREGSET
>  # define PTRACE_GETREGSET 0x4204
> @@ -48,6 +49,8 @@
>  # define NT_X86_XSTATE 0x202
>  #endif
>  
> +#define CPUID_LEAF_XSTATE 0xd
> +
>  static void check_regs_loop(uint32_t initval)
>  {
>  	const unsigned long num_iters = 1000000000;
> @@ -83,8 +86,15 @@ static void do_test(void)
>  	int i;
>  	int num_cpus = tst_ncpus();
>  	pid_t pid;
> -	uint64_t xstate[512];
> -	struct iovec iov = { .iov_base = xstate, .iov_len = sizeof(xstate) };
> +	uint32_t eax, ebx, ecx = 0, edx;
> +	uint64_t *xstate;
> +	/*
> +	 * CPUID.(EAX=0DH, ECX=0H):EBX: maximum size (bytes, from the beginning
> +	 * of the XSAVE/XRSTOR save area) required by enabled features in XCR0.
> +	 */
> +	cpuid(CPUID_LEAF_XSTATE, &eax, &ebx, &ecx, &edx);
> +	xstate = aligned_alloc(64, ebx);
> +	struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
>  	int status;
>  	bool okay;
>  
> @@ -102,12 +112,15 @@ static void do_test(void)
>  	sched_yield();
>  
>  	TEST(ptrace(PTRACE_ATTACH, pid, 0, 0));
> -	if (TST_RET != 0)
> +	if (TST_RET != 0) {
> +		free(xstate);
>  		tst_brk(TBROK | TTERRNO, "PTRACE_ATTACH failed");
> +	}
>  
>  	SAFE_WAITPID(pid, NULL, 0);
>  	TEST(ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov));
>  	if (TST_RET != 0) {
> +		free(xstate);
>  		if (TST_ERR == EIO)
>  			tst_brk(TCONF, "GETREGSET/SETREGSET is unsupported");
>  
> @@ -138,6 +151,7 @@ static void do_test(void)
>  		tst_res(TINFO,
>  			"PTRACE_SETREGSET with reserved bits failed with EINVAL");
>  	} else {
> +		free(xstate);
>  		tst_brk(TBROK | TTERRNO,
>  			"PTRACE_SETREGSET failed with unexpected error");
>  	}
> @@ -152,8 +166,10 @@ static void do_test(void)
>  	 * worry about potential stops after this point.
>  	 */
>  	TEST(ptrace(PTRACE_DETACH, pid, 0, 0));
> -	if (TST_RET != 0)
> +	if (TST_RET != 0) {
> +		free(xstate);
>  		tst_brk(TBROK | TTERRNO, "PTRACE_DETACH failed");
> +	}
>  
>  	/* If child 'pid' crashes, only report it as info. */
>  	SAFE_WAITPID(pid, &status, 0);
> @@ -173,6 +189,7 @@ static void do_test(void)
>  	}
>  	if (okay)
>  		tst_res(TPASS, "wasn't able to set invalid FPU state");
> +	free(xstate);
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.31.1
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
