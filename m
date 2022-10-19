Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AC0C433FE
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 01:40:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 607CC3CB0E7
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 03:40:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3898C3C010A
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 03:40:22 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D8ED2003B0
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 03:40:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666143619; x=1697679619;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xrE+vAKl/mtyn/8JBWxos9mZRfexLdW1Z8xSxfZX/Qk=;
 b=HmSfaIHssidNSehQ/iiKaOZctB4LtMyd9vDrJAR30C6yaTGSkYZT4q/Y
 MjXgJyuxlDnOhVrrgzb+CPNcx8SPGSAgGFljOqQhHEZ5WJWpBNwqYOlEd
 E1B0qdVzSN9ljmmw8ZVbwR72eNBezfIowYkl1/fFSybumFkrZoB08Gp3q
 B0BoaYfBDazgXMhJsXAAJECLcPesBJxulqaiaPawcCWGFEnQF99YzKzrd
 aFcpHjs/hhZiU89W/przhzGPC7+bnyFgHg2ryIY4FQ75lr37xeaHFNDUk
 Rl+xvF9aPrKD8IFSAyLv1ntOBwBNVLW/BncN9mNnTWwOsdWAPWemhoD8L w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293676043"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; d="scan'208";a="293676043"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 18:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="804047723"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; d="scan'208";a="804047723"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP; 18 Oct 2022 18:40:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 18:40:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 18:40:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 18:40:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 18:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSgAw7e4Soo7vLeydbcF5ThswHfnitX7kHWc8ryNzz4EB788o6W9zlFD80jzT8euFH5JHNFr3khOPJdV2LZjhFIWBzg4HT9xrEqFZqTTIxwOZhFz+Z5f9ZxGnnmDNVyzzdVz2GSj4b3AJVxZENBZFRjrHUl8FYR2sLgweDo9UPZqh/TNpXoOlyyqyEsNDJM9N5tZQvwjCdcQPgZ167hTaFQFUHwO6bzAiiwXzs2zOEduBp7wLkKkljCSjSGtMidPit1n99TcE/8r6xzc122umRRUaiuYNy4cgkNyAXa9fKb9flGnsByC1kLPMuScD/GHlp+vtyB2UuMgLNivd/a+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcAi0Y3qg0WoUoXHEkMe+LPxqsATYGkvw9F/GsECXAw=;
 b=VFtZ3VC9TKNJUi7y5JA3/LLC9QSsA1ctJrvmUremXwMTEOo29v84FyjIIM6yk7I+Iw5Vw1GMd1RiFshntOC+SgYEhQ4n3GsOW9NckdfssY42HH+3PIxl5q8h1+sLZMRuNeUVylX3L02gM1e72TtnUXU/SDbyho0hyz5kzLSgnQtqnxb1x8F4jrHKUAvaoGVCViAc8x+OKHXMfAqclARLxXcb8tYyAfe/jIxY69EGZc4iLAzLVwNiq1nif5t1N94Km3uuy0xfjsB+H8lcSNCA9KXd+ESP9VIFqcrWofoNqeX/dCybq8eQkI1MG6l+lKPh/HvM29Pn9IY3XvQAC2aYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW4PR11MB6839.namprd11.prod.outlook.com (2603:10b6:303:220::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 01:40:12 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 01:40:11 +0000
Date: Wed, 19 Oct 2022 09:40:15 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Y09Vf7XnoXeEcxJH@xpf.sh.intel.com>
References: <20221018152527.4636-1-rpalethorpe@suse.com>
 <20221018152527.4636-2-rpalethorpe@suse.com>
Content-Disposition: inline
In-Reply-To: <20221018152527.4636-2-rpalethorpe@suse.com>
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW4PR11MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: d93a4818-3b5e-494a-1075-08dab172dcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIe+VtKzb//j6UNcZJSyfyxaWAGr8rxZtn5JglMcqPdPhlPtvRZF4COGVu+fn2B1XzgNfY/r6tYAnvrxCpzfwFCBMutoJTazl+8VafYTbh+xlKGHvz1c6dgfhP9WKgojeGPIJ/Bf7k0anP9tzOlhmmV+NJjJJTaUfmABUH/nFophAZoMaoZogpw7GqiAB58/4gDl1Lt7POx6OE1RQX06fDdm/WBnmgb84p8KntuEO30GZk6OKBWaGfCfwxVFy2jhGpbU0ydklidYBsMBjCjEL+Quf4DStQgiNLPFBpBdGBjQXJMJ1ZE5IUICQ2ioywOPcQcZkfbZ5AHChkyzIIv5t6rPa3AblvWVA+fuRm2G7lQ/ltpVVmHiyrrV81eIDP0v34TRsvPkbHKfuIC/5nHwmCTtvDHHCd46bgf/5eTYVyaiLmV1Ixx1r3ZuwNtQ2vSVz+WbUSAJAlzC0HYe4uj4+DVgIC7dj4Uiq//uUfVoFEdi7q8n1FCGPVqFBRjLR6LIXx0Ag8TOP7M2/2OfIvigDOsTH2+foMcnx2fcoV2o3mMOI6V7KNJ7hGaIISm6ofMSylnh12HEeS7P+ATYWTwG8OS5/xEWllFvdg9pU8I/ZneLBXPc7BXVQKZFMhyVvunL4kS/IQEfIENJU0VtD0VBnLMgwChMFUaJPN8dtdQcjjdhXuSbje0CMDRRVV3/+SdiZRcok1U16Du+P0ReJgcqYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(6512007)(6506007)(66946007)(38100700002)(86362001)(66556008)(8676002)(44832011)(6916009)(2906002)(82960400001)(66476007)(26005)(83380400001)(186003)(53546011)(6486002)(4326008)(316002)(4001150100001)(478600001)(8936002)(41300700001)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v2N0/F4Ul40bojlxEbDFNU1fIm1Vz5RWNJyUMMngxmmbVm5Bs3hlkyDRuU2Z?=
 =?us-ascii?Q?zqt7vwdnU3+F9L0iJkJsllM+6nsKGlcSe8jQi/TBGacp5KDG1tn8BdUL0Tog?=
 =?us-ascii?Q?r3XaT2AJ2l/qMthKHLsd0WqMQDUDWmxJbDz/WCtpFIVImN30iRArDWPN4vuk?=
 =?us-ascii?Q?V7E+ZSSz3XLA8fLVP8HEt9UZBfIjgeziTeQeHIYm4L0s9BpCWCmo9cjmEZqQ?=
 =?us-ascii?Q?LwPI6k7EdMgjqoNYcMwwgiEI5+bu+t7xX617mmZebUE7xRqEmvgRMu3IeiGL?=
 =?us-ascii?Q?TYwQ9YX+2Trirg1h4sw2Fh3GVECpUbCcJcpTt7M8emF18NawI+sm0qOg0fPu?=
 =?us-ascii?Q?ea/IyDT2GDKNVVIVWib7gUF0CLuedJucRd34ZXoL1iOqba8jPdtRWdZBgAMU?=
 =?us-ascii?Q?PLXcRR8oZCeN8R+kH3pw+XyDr5ySB/e0vWwEdsfl41MwTszEjFppV3wpQboi?=
 =?us-ascii?Q?szJ629L7F5ygksXQAZXQEsxn1QFAGizc0bdJCtAYBuA+tKf/oQW59nRNiTn9?=
 =?us-ascii?Q?fDzUDTcGnkfsmFUdTzToC75eZyhQzOYpUlc+DVleemz9OrdmOx9axeBJEAI8?=
 =?us-ascii?Q?0h+zzEPUW5Ez3gcd2t0D7gdHYyFZXC718cBHbHSeZ6DVBYh3GFBP5oc7UXVY?=
 =?us-ascii?Q?tFoJSrBFe5qwS6R9h1NyTEb5QLf+eyyJEanpiNHM4HBRF65d2TxAGnINIM3B?=
 =?us-ascii?Q?o3g19nW+m+iFxO8TppbGHyvo4Bbh102IrCQcQY2pQnyvCQBu/DE6eOZaNY20?=
 =?us-ascii?Q?hHTRAFrSyq4iqmtUjeprokwRLR4GXpiY0+Su6GuQABtGNPjeK+nrto/OiyWP?=
 =?us-ascii?Q?csMiIOh42HAiTH6g/eKlUBiOEGo2ng5kmMYmglK/8UvXPb/1mYDrrvmmbxBA?=
 =?us-ascii?Q?1yXdIPf+u3dHml8FmgHgsKTiDXquBe6k5GhcEZT66gQuz+qrshUP1XVFrjhN?=
 =?us-ascii?Q?2TLzxVll4JZ4Pr9CCmXpgUgDTO3WZjgT2lBG0tB/Vx+W0fl8rNdPsGlZX8dI?=
 =?us-ascii?Q?Msd7h0oJRZKLgluBQW6gW2AADxH4tKhJIMk9lrmNIzMPrz+KnjV3duQnppZv?=
 =?us-ascii?Q?jLkoQACmsb/IQ+uqx2Ty3Yw6aKmJyeg6OfsaXvRnKSdTQB/FfoaMfMbUqTYi?=
 =?us-ascii?Q?/lTksfZCUBTyQNbolKEsTClITL21GgKiHhVSa3IxZkNceW+5a5WyTArXBUBq?=
 =?us-ascii?Q?9HDYZfoND95w4vdArN88FVJ2uVLJdMlKBqVaJwLdstKLC9yJU2JJLyelL1w0?=
 =?us-ascii?Q?0ma3Qx8S2GgRh+SYDyRDtOFjBAls56B8oIupJ/Yry5Lq6hdudHXdoO9GF+Ev?=
 =?us-ascii?Q?AoRfnRTwx7l/j4gZOAj8wgwYqdaQp3JNyNRzbxLoqm8NUTzhoPlP9Ta/nrVQ?=
 =?us-ascii?Q?iu9ZWztkHm9P+vOauDidJUybxME/ESHybRYSixfkW33XJri08pCR/5NA6mGE?=
 =?us-ascii?Q?7JcnXrQUeh51IbesMIlakMJy1CnKbafYXaR8JJuxpoQ7/jKnoCol2lqkILU4?=
 =?us-ascii?Q?k0gFeq3UaLO5SmC3L7ZvtQ/x3mboL0/lzI/yzDnoNez2YlSblcyBQRHYZ6yO?=
 =?us-ascii?Q?2UbQ3dFbbpaepgiZ1Kc1X6x76tonDGya+kLV8fyMlzZLkMcCXl1I4vouOEC9?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d93a4818-3b5e-494a-1075-08dab172dcf5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 01:40:11.9176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBsIRKPeg3BKOYdoGhSBxwCNK1hxBnvlrY2RwHZTTe3nUxWMhYv2gNjxnqOIyBEeNw+to+wK3odCPSRx7f7/6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6839
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

On 2022-10-18 at 16:25:27 +0100, Richard Palethorpe wrote:
> Use memalign instead because we live in the past.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace07.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
> index 6bd2b1062..a60c2a49e 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> @@ -35,6 +35,7 @@
>  #include "config.h"
>  #include "ptrace.h"
>  #include "tst_test.h"
> +#include "tst_safe_macros.h"
>  #include "lapi/cpuid.h"
>  
>  #ifndef PTRACE_GETREGSET
> @@ -95,7 +96,7 @@ static void do_test(void)
>  	 * of the XSAVE/XRSTOR save area) required by enabled features in XCR0.
>  	 */
>  	__cpuid_count(CPUID_LEAF_XSTATE, ecx, eax, ebx, ecx, edx);
> -	xstate = aligned_alloc(64, ebx);
> +	xstate = SAFE_MEMALIGN(64, ebx);
>  	struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
>  	int status;
>  	bool okay;

Yes, it's better for LTP compilation. Thanks for the patch!

I checked SAFE_MEMALIGN(), it will verify that the buffer is NULL or not.
"
	rval = memalign(alignment, size);

	if (rval == NULL) {
		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
			"memalign() failed");
	}
"
So could you remove below unnecessary lines in ptrace07.c, thanks.
"
-	if (!xstate)
-		tst_brk(TBROK, "aligned_alloc() failed for xstate buffer");
"

Thanks!
BR.

> -- 
> 2.36.1
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
