Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8991C433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF3D53CB04E
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 10:50:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7192B3C93EF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:50:09 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 490952009BB
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666083006; x=1697619006;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3b5Dh35tq4Ppbz/b1ZpBnTX3u880FhyXlJpTpfIOmiw=;
 b=g9S3Yc/o4ZYFjVAZsHNCZIba2Znd9yywf/e4p4glTM9tINcYcyPv73Qw
 bkBwJ1nILWk7sk/v+eZH6H02T4Odu/QDgN6A+DI3ZHgOhZLuoaay4nuru
 p1eL4SUVLa0ysg3G4wqIb0mIaIvEwFr54Spod1W7YVcg0Kn406/bxVplS
 3BEua44nQy6dnt7JbKumkw5y/5IabdvxWmQ6+lU7k+ciDvSvVDm2rInrT
 Hl73cKFTbdPvCJ5dSXTdHzySb2NA1NKZnFEz9rhWT7V2RGXr0QTOCNhR2
 E4tMzBadTl6i24952+5Ch/32074Z82ort0mOHNXGUXgjxiIBeiPesPUKU w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="289337930"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="289337930"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 01:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="873804215"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="873804215"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2022 01:50:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 01:50:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 01:50:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 01:50:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 01:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bObIs3AqcmbpDdmiGyho53tvgT7sAoFHyNviQrwbpBI1Xb2gjvvj/lvb41M730Pxr9gNCBPOI/Xtk7sx5A6XCtk7JFga5r1Bwd2T0MdkzeNFuFN5Cn9IRhpVM0O5KHcOPs2AI87tKy3rrnWIDJEGgIabZWiO4C2Zb1+Oi0LKulZFU1UERYESGE2zHuZKfFrtY0jUdDc2SL9JvbtYRdDbFox6bnTMYpZxvhsef6kVMMYasWMKVEpNkfrgHFkbdRfdHWriI51F+bRXRUjnZxjtNmytbP42E5H7iS3SHRa4evngtfATb3fKPbGi7QJCDxW2KCuoY03sb73FLLJjR6bXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J33gHFwQ1gpRTXa7SQVCiPKplXfvLxa+ptcnH9j+3Wc=;
 b=dlnQo6NbTECBGziGVGTToANRElPVfAtWJ1Hsm+QshMPuu6ECENyuVISY/+sRp8fGUnjtahP3SOnlVeoPGl01alr1l59JgEfOeZ/QhYGQ5kmpUnEXMtwYMLnY0LOlmiYvWDsJDCYYmdrVWYX+Oc/asHh62p8na0d1w0MpqjmIckm4+YJL7JdlK44r4vAhNFX06VzrM6YZN83M1Ja4AFRNqrHYyLO4iZe2QWmF2EYpywp0lLgtd0MPVjAhd9lveqcn/0yKbXs8zbtfeyqAtFH+LSYRhljFj+dm6cygZkMVZ2axOGKwcko+iw5H2egXBBx6CBYG4aKd7i0vNtPTDJ/2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BL1PR11MB5285.namprd11.prod.outlook.com (2603:10b6:208:309::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 08:49:56 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 08:49:56 +0000
Date: Tue, 18 Oct 2022 16:49:59 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y05n32vZW/WulJqY@xpf.sh.intel.com>
References: <cover.1664418361.git.pengfei.xu@intel.com>
 <466821336a63ab9b6c236a0a1c4dbe056b7a5ac3.1664418361.git.pengfei.xu@intel.com>
 <Y0kD/eENxCPGYjOg@xpf.sh.intel.com> <871qr6o7xc.fsf@suse.de>
 <Y05VnBdOKEGXFUCk@xpf.sh.intel.com> <87o7u9mtog.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <87o7u9mtog.fsf@suse.de>
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BL1PR11MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6ca32c-272f-4bad-a762-08dab0e5bb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VednPsYBmXNTaTKNiUkbQhW+cQOz+N6UOboVzMrcyny2c2K2dHGfFK9jNZzCAnHyDV2IL/CNQDBiCe4NTOxrvuhdcSsVrp+TpRny+HYkrDorNqkjcL4yqlKh4TvO7N+iDOFV/aHIQBuklcw1Pz7uh02ZgvfXDhN7GMltImSlXSVlriDoKaaSn8NC8bMiPpEIn8fLAD6OcT8pVj/3Ya8xo/OUvt5jJ1rQjeekKCyHVoi35lhM/dac3R4jL6Jqae4SXAwxkuj1sSKs8Mr/Y1z4KP04yhMkOTWixRYhD+xb0ddy4J8QEZJYKIHOPvpbf6J+K6V9H00AzNwJ3rUvb9fhD9vZ7k6AqJwmAvgJon9uV0/ESaNwnETDwMydP5Qrq5FqG3KRXw8684DunKAy4m43LmE0GiOP/3HKmMA3wd21t4Of5/CM5ul1F/y1zQE8zGvygQGrsCNZCWrJZgP3gFVUojeJ5+LyYGnurQrOSTRwO4PgqBmwb3ffnbtnrhbP3Y+Dz7+0FSrm5bxDSIg++beATzfQfqnu0EkPCWdAe1XxE/OsKySNSRSFPBIH/cZOAhgH8wGJWv36r+yQXneugt+2zIvm1il0pZkTXtuF5vGWtkN9djEbCz/s7LYZ0H+kcucVp4YL2GQWjvD2NHjjPcE9lmF8bq5IjsgYqN2EMHgQuuiH2iUzsdh0CdNPfSZi7ahatnb5kGxzzciXxHpHz7cBxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(82960400001)(83380400001)(86362001)(38100700002)(66946007)(66556008)(316002)(8676002)(44832011)(6916009)(478600001)(6486002)(5660300002)(186003)(4001150100001)(2906002)(66476007)(8936002)(4326008)(6512007)(41300700001)(53546011)(26005)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgR1zQs42VVmB3oDsLS7r5EmomMdhNw4WtaOy4dweBlZbyzAfrRSLJCwgpeN?=
 =?us-ascii?Q?DtO2IPJtac8csdPS+YX6z6naW4MAgNWf8igsXLpVUWxalhEKamaJJIPtDSoh?=
 =?us-ascii?Q?CK2zGNRShAZZujb7IBBtMQwaL4+l4AFjKA45MFZGecovG62hmBQR3X5FBYBS?=
 =?us-ascii?Q?bdSFWXIPIltKRqXd0zMB3iRTTcrsFTijzixrBWh7ogqmvKyzUH8LYPl6NZaM?=
 =?us-ascii?Q?YmXOMD0N5ifR4dqvR16d51SiPyvXYRz7hX+p0p/It3uqfYZBDLwCMCZ2IjYH?=
 =?us-ascii?Q?lG3xVXZbnc41A06ufzte7w4DNmCIPHEr/LYBbf5xwaBz5cFjTe9NqMQbGCUl?=
 =?us-ascii?Q?xSwP3ahYTG0fmsatk2ylVcotPIaQXOZnkS7xj0oqUK5lanvEaPzzxNB4Iunq?=
 =?us-ascii?Q?pSrLkA7TWAR51zxQ58QsPvdlj80Ir9NM8WyvpoRcnEdNovJZJWB3CnI+5F1z?=
 =?us-ascii?Q?qL6DGFQobSPITh0UNlNntSNrpMnxhTgnq6bqnrXZdBoMb6//GHQiuG1rT/bO?=
 =?us-ascii?Q?TwrdUr3vHmUfl9lTIFr+WAYomTotJq4jeWcV3mKEbQRbnAUkjxKwDH6zzHnN?=
 =?us-ascii?Q?ltkSsqyAuEVwFTkMMXN66x8jX2QVKdWEQ7sJZhJ4bnwrTkSxOynetVFVO0ui?=
 =?us-ascii?Q?/jy/GsXo8VsN536IhKJ9X/RopW9+f+vdzrNsVrJdKIiIjpEfXxOjZcoo4FBJ?=
 =?us-ascii?Q?w9ICgMIwuBgoOsor9f8sddgDim0jqVOULek2ifqe4A4gSDbs6nmJkBRAr7Pg?=
 =?us-ascii?Q?+8NWnKfXj/2Lx/7+zLjWiLeVzcDl+4KozUXiJgu2rJ/XD7oeTpM5PbaP2jJh?=
 =?us-ascii?Q?5gPXML9HfDbNeZ4K8mb0JtDWS6IVlESy86VAlqzetSvKUrp4uv2Z3Z75hCAI?=
 =?us-ascii?Q?300g6WlgyRmHg14j97tYi979BKTJpzYKgk72vNgz8fC3zvWUHilNYC0l3Xjd?=
 =?us-ascii?Q?QBOzmWNknMGoFzanRFKADYev1txuWzsNH31g7DQumE/loa7TQET/EepQ+Frq?=
 =?us-ascii?Q?lrOwNU5A96QwCnafym7IUI5dEHMg8+U6JJPLpVxWGr8rxQinIzkjnsd0RM3o?=
 =?us-ascii?Q?PVGeNLFL8dcQQ5+pjpRdIgXdaWyHXZdZiGGt0AMjD3JrHKRQOPpyakC4fll+?=
 =?us-ascii?Q?o2frqffbnvWfkd7SG1ZzO1hliim+4p0gIfLbgYWNibMBksDl++w7CUZH6gM+?=
 =?us-ascii?Q?8+VwWhRGqD/84k9DSgBKhJPW1aEexBtqb9G4jaOZGFr9BfVtlNzL23kPzx0/?=
 =?us-ascii?Q?nIYIDii0HsMiYIQSVabAz76kzldpgU5Uccg/M+jQoP5d3OtRpn4NK45xtFIx?=
 =?us-ascii?Q?1xpGu5v+C+8a21TRN/ijbBxqQZGCY85I8AgIGunwsW3K5MHUJT9ErA+/JAyK?=
 =?us-ascii?Q?9l4urYwbEt0NvHiDThXvGvQ3TVbMjOB01i+d8vsqZL/Pn6JIY+TF7sHjkAu7?=
 =?us-ascii?Q?gnRSh8KM/RSziAdXWKzSOSi5LYU3h7g7ewiLZX8rC22ZmSQSC/sUg6mPNqag?=
 =?us-ascii?Q?yrmK1kYfYEHBJqtwA/w9CmXbDxwP5XcA6Kp+/9QxossyS2os+kx9EHPaFy4O?=
 =?us-ascii?Q?wnunEDS8hzblhxRZeiEeuubngqUdl3mTrTUcbnCmwUgET5a6WREgfyFZ51kA?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6ca32c-272f-4bad-a762-08dab0e5bb88
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 08:49:56.7578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GycIFxV0PbiRRyc9arB4akH3zyHgWzGLeYdz1RPWkyPWaJQxBJIvjvlBuo3DYcd/Sj7UfCrk3aG/k7yqCA9s8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5285
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
 chang.seok.bae@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

On 2022-10-18 at 09:11:47 +0100, Richard Palethorpe wrote:
> Hello,
> 
> Pengfei Xu <pengfei.xu@intel.com> writes:
> 
> > Hi Richard,
> >
> > On 2022-10-17 at 14:55:29 +0100, Richard Palethorpe wrote:
> >> Hello,
> >> 
> >> Pengfei Xu <pengfei.xu@intel.com> writes:
> >> 
> >> > Hi,
> >> >
> >> > This patch fixes ptrace07 spurious failures when the platform xstate maxium
> >> > size is bigger than 4096bytes(512*8 bytes).
> >> >
> >> > Thanks for comments!
> >> 
> >> This patch causes the test to fail on my Xeon workstation. The problem
> >> seems to be the cpuid function which just fills the args with zeros.
> >   Sorry, I didn't meet this issue,  I think I should use a new cpuid function.
> >   Thanks for the report!
> >
> >> 
> >> >
> >> > BR.
> >> >
> >> > On 2022-09-29 at 10:30:20 +0800, Pengfei Xu wrote:
> >> >> Should not use a hard-coded xstate size(512 * 8 = 4096 bytes) which is
> >> >> wrong, should use maximum XSAVE size specified by CPUID.(EAX=0DH, ECX=0H):EBX.
> >> >> If the CPU's maximum XSAVE size exceeds the hard-coded xstate size 4096 bytes,
> >> >> it will cause the ptrace07 case to fail as below:
> >> >> "
> >> >> ./ptrace07
> >> >> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
> >> >> ptrace07.c:142: TBROK: PTRACE_SETREGSET failed with unexpected error: EFAULT (14)
> >> >> tst_test.c:1571: TINFO: Killed the leftover descendant processes
> >> >> 
> >> >> Summary:
> >> >> passed   0
> >> >> failed   0
> >> >> broken   1
> >> >> skipped  0
> >> >> warnings 0
> >> >> "
> >> >> 
> >> >> Reported-by: Eric DeVolder <eric.devolder@oracle.com>
> >> >> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> >> >> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> >> >> ---
> >> >>  testcases/kernel/syscalls/ptrace/ptrace07.c | 25 +++++++++++++++++----
> >> >>  1 file changed, 21 insertions(+), 4 deletions(-)
> >> >> 
> >> >> diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
> >> >> index da62cadb0..0accaceb5 100644
> >> >> --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
> >> >> +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> >> >> @@ -35,6 +35,7 @@
> >> >>  #include "config.h"
> >> >>  #include "ptrace.h"
> >> >>  #include "tst_test.h"
> >> >> +#include "ltp_cpuid.h"
> >> 
> >> This is from the old API (starts with ltp_) so we shouldn't use it
> >> anymore. If it is being used at all, then it's being used in a way that
> >> would allow it to silently fail AFAICT.
> >> 
> >   Thanks for the comments, I plan to add below __cpuid_count() macro function
> > as below in ltp/include/tst_cpu.h first, there seems to be some other place to
> > use the cpuid function.
> >
> > /*
> >  * gcc cpuid.h provides __cpuid_count() since v4.4.
> >  * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
> >  *
> >  * Provide local define for tests needing __cpuid_count() because
> >  * ltp needs to work in older environments that do not yet
> >  * have __cpuid_count().
> >  */
> > #ifndef __cpuid_count
> > #define __cpuid_count(level, count, a, b, c, d)				\
> > 	({								\
> > 	__asm__ __volatile__ ("cpuid\n\t"				\
> > 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> > 			      : "0" (level), "2" (count));		\
> > 	})
> > #endif
> 
> Looks good. Although this should go in ltp/include/lapi/cpuid.h as this
> is where we put system header fallbacks.
> 
  Thanks for suggestion! Yes, it's better.
  I will write it in ltp/include/lapi/cpuid.h instead.

  Thanks!
  BR.

> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
