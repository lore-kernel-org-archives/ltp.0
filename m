Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35401C71157
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 08:13:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A565A3CC21B
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 10:13:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D4AE3C9C87
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 10:13:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B463B1A00917
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 10:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750147999; x=1781683999;
 h=date:from:to:cc:subject:message-id:in-reply-to: mime-version;
 bh=sanpY/M0ozFePHPoZHWk3w3yAxDrwxOKdpoYfZWmmgE=;
 b=As9rdsOLzOAf1ndxnRCQGItP89IudKlrgxa/923DlrdynoKVZjuA97+a
 0X0eoEdQKBGDHQWfSkD+6iQYXe8izB12m1cf/hRmOgazXw34eMEPQq4SU
 +p7qQ6aZv5SvdmcBAKOlbpS28ASCLlRFDeaT1ejn5xNSVQYAUmN9oh8YV
 ITxMndVAQdedKrE6ONmJ98MYOI0+1Vop0sOmEFzxKpc+ZvP6jYhqscwnd
 VBGuthNqReAJP9+Y9U7wHxMdGnwBLdbQsbeLjyEz3IgEVvw2OxesFpJQp
 L+I/McEp5P1HRmBfhRFHOZy82q+f9i/jvYC3RNDThXAGOVBWmHq6/IJiL A==;
X-CSE-ConnectionGUID: CRaukzzEQAKYfin1q30ExA==
X-CSE-MsgGUID: nUUj3M1RTBqNcDvJM3/hkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52182551"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52182551"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 01:13:12 -0700
X-CSE-ConnectionGUID: obmaUqjIT0mQd51mXMXY9A==
X-CSE-MsgGUID: fQz/AoBCSfmeNJyd6C5lwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149606035"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 01:13:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 01:13:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 01:13:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 01:13:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBws4GNV1CEzqfXApRqKPV5FewR0hYwKLVqRJXmGBTyopdMb22FkilkqqaoG914Ct4WnAQJfc8KqLEaGUS0IoI3jghbeih/Qm0dGpQyh9KL/MgG07Uq73OpTML5HKYC/YoVZFPCZdAPFlRk0bJIOTX0tZXXsSOi6hf5+Bq9tPXs8w+e3DeClw+8c4h5Hh4R5e0Hy6ngDueYy6hwb0/ft3jTob+IjryVq7rkpNiVUPHhNE5+TkzKt60dZ5wmjXWUHi69DR9DI4iXdLZ9sbIlqcoUfxZsxlYbvadeixWplBglRInNvP7S2NvXwixZ08zbANz9YuhF9QwGnQQfffMHA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfMM1LgaKvALPwCiVvhzOuVc7zuS5Tt5Roz5QHn5CIM=;
 b=Jn36fhsVPEbS0Uda8kTUy4I6rH4NrxfFjY5YGNIMkIrFu8XXcbwlBkut3NfRuU6A6p04ZiKI4Wfn5n/w2P/0qUlCbANrTGmPv/5iPj63d7hVDkbJk9kfD8oHLYjpQgP9nsD7ndaf2fE9i4Je4QAbiaa+Fvlhs3Y9C7QXXGG8LoGFXLLtgSMb3j8pBSpG2QwlbsQTEd9Yakuv9jMt+TdbHf5MmIFfNZmo42JTogMEOFIrwF83zH8I3ZAzofY9a8as5jFAr0Rn9N4ABh6wyfsp/R53Myzp74UgSHY5XBn5bpEF65Q1gWRLmPwh4jpxk6rVmAu+taQldD2rXq+nXn0lAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH2PR11MB8834.namprd11.prod.outlook.com (2603:10b6:610:284::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 08:12:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 17 Jun 2025
 08:12:46 +0000
Date: Tue, 17 Jun 2025 16:12:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jann Horn <jannh@google.com>
Message-ID: <202506171557.b6192de8-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20250528-hugetlb-nerf-v1-1-a404ca33e819@google.com>
X-ClientProxiedBy: KL1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:820:d::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH2PR11MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 41554ceb-50d8-4b42-4213-08ddad76be44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D8v8lR8gxeEwb1oHh/2Mro6tj3K0sKWo8gzM2PAs33dgjUJ+qHk0a/uxXauc?=
 =?us-ascii?Q?NooGWgEvXLT/bj59Ink800q+1OsqJ8MsRvVKZvLkE1qUP2p5ajDrEWa43p0Y?=
 =?us-ascii?Q?SOteZ9Xtp03G8E+87Q5ZjY+GcLwKWJF8hlr4V1Y0rVGIJ+c9gP6nvGzMNIxg?=
 =?us-ascii?Q?EJcvx4k4wtn2kQR+NOzXP0Lgdg50c4cjEF83aWmHHefGoSKCGZrj/fyWt5JT?=
 =?us-ascii?Q?K92FE8yl1PDWC8HZJvcRvnKVtd/n0jbuQnRX4EyYMrkyrzdQHeDhrzM92N14?=
 =?us-ascii?Q?OXS2nlShs2+BapxV4G72KknkevUCf+t9S+FFLhEzI2pVFLS3qRHZTK2PS2oS?=
 =?us-ascii?Q?+d0DGQ57kf3cMteRiYXzauft6zg8SlQ4hvlwBnVJnzDyhcQM/Ag48/myTMq0?=
 =?us-ascii?Q?H8XkoPgQ0H6R9VIDECQPwCPuiLbiOnr50Jb76Sz+b1Wskt/YmbS1rwtJESg0?=
 =?us-ascii?Q?8AXra6D8mrn+M52jOqZPsUzQdVeIGSTJEw3iflileBXBGogbU/q+7Y4p/JGD?=
 =?us-ascii?Q?v+gC/AlTXMiJWLjejVm4RUQYztxsS801uw0WLUlKPy+PP9hbhRC9s5QOOzO/?=
 =?us-ascii?Q?p44AEi/dsHR2KSKrQ/QzFuqFak+EZST49SvR5MKjVeEXTjdKrP/mN8aNFUHL?=
 =?us-ascii?Q?UVR2VnL/sPYhgJdwHVDdw5fWMzrxWVlwd+H2Dqd5lVS7mGV6ApO0Zrniq9yq?=
 =?us-ascii?Q?NXOtoA6N83h0L+oRt+vFp8zh81lusxeuXkpa/mfG8gbWiSLj6lIAI+czYKSb?=
 =?us-ascii?Q?2bQxdsXoMIcISkNe7wIak9qP4ESWnQl8guH6Vfp/tWpCmcNQDMVq9fLeHkj2?=
 =?us-ascii?Q?vPIZpEhJ2yoqRLH3kbXZEBffeFuw3yugeZMJ/QKmCgqNl3O3QXzLGsxxuDmK?=
 =?us-ascii?Q?V5tsNrshER2J+xUGADQQoFYNLoL2VLb3fOpYeAxyDjXFTTXEtBQQhol2AvL9?=
 =?us-ascii?Q?zfkB+/ArqiIYpehZHt9ELL53c56TrO6ZGVjq+wtBcWJN0ifqjn/KF/SXeTxd?=
 =?us-ascii?Q?Ui3CAste/HXscbMJuZ5wbQH8C6zV8ylQ4pBy/fZP/Gj8EgUNP4TJXlRWhF0g?=
 =?us-ascii?Q?T6YdKEW/u0qdJzJy5NrosloPVqSjRovq3FnkXqkd/iDub8yehgaupDXvJQi5?=
 =?us-ascii?Q?M9Gv2I+IaeY4T8uJm9cdiJx1xM7o6a/zKyvXKzRelQcTA8MktqJ6WUnQbXIY?=
 =?us-ascii?Q?GmMB1bP8cNRTlvKKqYMMDp5QC1JgkH3b2Qm1zjvkigwAMq2EZUQwLZHbCPxl?=
 =?us-ascii?Q?bHsmLnaOhNjsY8DhRzSlVRBlMvI88nGuSPlzIZqSdk/YjJfAK101Bc4Q1oKI?=
 =?us-ascii?Q?9eV8waIJAtq6Mm9qg2X4FBPWO2UfJash2b3LRL/N16CsGpT8sQwyQaxDSKHf?=
 =?us-ascii?Q?dMK0FlZ2Ngv0Nh7Sgx5YKXNeZ7oQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ox+r28AfSWCNJDd6WszJqlVK2D1f2cFD2R57lOK4Qke4J4lwLu+0cfxqRJeZ?=
 =?us-ascii?Q?HqH7WUdRPldcVV2YcBZud7M0JAWHnvI64ttlo2AkTbJcxZIoQl9/vXzmV4Tr?=
 =?us-ascii?Q?mgYfxVkI+wxFSw10CPR9ZVI0yIvjBInqstbdGAdNAktR+kwGlwsbGDb/OpSO?=
 =?us-ascii?Q?wPFnwXHZt/1knmFe4PXHGvJDQdSsJXgwWY5efOavGikcUW66E8tWe0fmrWLE?=
 =?us-ascii?Q?+6Zi4BwlPCDnsW3ESZVozOu85D3PPMJJe8ifKihO0o2dtrYErrqDZxQvDghZ?=
 =?us-ascii?Q?dKPSeuckxh3jRlW0EfpJRamkmNTjb+5VE5IaTkaOlZc7ZnXCiCfXcOcos78F?=
 =?us-ascii?Q?Oi+2yxCy098Qk6xrNDR3g2ZUoLjMJoYlQ1j30zgggFIQT+YsWDJTatWCFm40?=
 =?us-ascii?Q?hYiBtRNGBtsoFz6JoQdpooTVUwx0b6K4sWs1nFVOmSNCDUwgFaRumq3SOF0d?=
 =?us-ascii?Q?45B3c8YgCyS9ey6CW21jIYjOdS7zz8ni8YIT9gR7pCCvk1Vlg8b7eOENQS3x?=
 =?us-ascii?Q?bHqBC0QMVTc4RvyBkpXyxxLrd2DTEIXaKER8FpX3RJ0BD2H0MAJ+ryWOBKaZ?=
 =?us-ascii?Q?jZ3h3dGIPNTqLAiqSvaRPH+RLk7XnVouuhEhq8qFDIdfial+K4iWC7l40Pjw?=
 =?us-ascii?Q?wYL1axmZ5jj8ZwddbNPr2KNydAsIV6l/OeKbrjdX7TzSuaPMHHn9Fe0z9Vdb?=
 =?us-ascii?Q?xPqLN61ZBe2QROdT7vt3+EGcjKrMUx7jfYPtIX2AOBnIXDGPn7KlD30qJTxP?=
 =?us-ascii?Q?EnDLs+c0L/L6YzIihVyTOHa7BBWVvabXHP8GTcvpmxAWM5a30G+xlD+V7eNm?=
 =?us-ascii?Q?PmlqUnDS86y0Bx/Lr3/eU6oSTWmPCthWUeoqSmyTiJQnkWBHK4EE6ulb1EYy?=
 =?us-ascii?Q?2YdgNtrT7EzHqlRHdy8fTV+2RyjUtJZYiq/PBCEEL/fY7Df9IzPpBos0Cz4P?=
 =?us-ascii?Q?4CAkM3lCV69woxxcSnIhsSMSnIBbpHk4N/g3p9sh+0TJE2LJAZx3BD7grRwq?=
 =?us-ascii?Q?Sw44ZYJzcyda4zMDBU1RzHdjjJmUF4RrcsdeTeBiJAHQhp6nAl8T1CQVQfmy?=
 =?us-ascii?Q?NfmQ/LyHMMKXCX6U6QpI9cHSpmP/fB7kdh6S5u/LsFlC3nwLNzfstcEkQI8L?=
 =?us-ascii?Q?kv/vWGx8IR9dHG/fJkyEfVHb8cgKLy4YdNZctYkrv6SXqrPWi8Grwygw5QWu?=
 =?us-ascii?Q?vmaHDuE7EdKapjdodUMArygGofg/1H0CWJr5bRoTfn1kGmPptqOJ8P5qHsRz?=
 =?us-ascii?Q?JxvmjwhLq94xKGOEpi5DhrWHGzO+8dyISjdmPsOy9TCRqT/drpBPtPiePekt?=
 =?us-ascii?Q?YobfKUG1j9e14FqOeuWEhp1d5T/eOblL3XBlN7U/NedtKch2lDd4VrBM8VNh?=
 =?us-ascii?Q?8yURNm/QDaEFGGPxaO481JB/JBeOk1hCh5W8hdT6IV2G+iHS02Y9ch3d1RC+?=
 =?us-ascii?Q?NzGnVTCM/xsZIGig5qX1TECODjCpJmX32+V8O6KdsMveXTDNCQ8A4aoI5w5a?=
 =?us-ascii?Q?nyUGTqDD1q9A+QfLj07yDSt7Fi00CWguhUvXFZyURpluWquXvSB+RvEGPxXr?=
 =?us-ascii?Q?WpukFNYIh+uXD7AJdXfz3kNp0/wVl0xfyAu6IB0IiTYepttzg+tdPI6b9fiE?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41554ceb-50d8-4b42-4213-08ddad76be44
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:12:46.7580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRf2rc4vmVy5o3BZHhWcVfM/RTEcS5gCwohfr2/eaoQWHzHJ53nHtsqzJW1y67+iZPfcgSdBfs/C8n7gEhHD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8834
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugetlb: block hugetlb file creation if hugetlb
 is not set up
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
Cc: lkp@intel.com, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, oliver.sang@intel.com,
 oe-lkp@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 ltp@lists.linux.it, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.memfd_create04.fail" on:

commit: d72db81adc14284db5f67ff331d876691b491985 ("[PATCH] hugetlb: block hugetlb file creation if hugetlb is not set up")
url: https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/hugetlb-block-hugetlb-file-creation-if-hugetlb-is-not-set-up/20250529-015217
patch link: https://lore.kernel.org/all/20250528-hugetlb-nerf-v1-1-a404ca33e819@google.com/
patch subject: [PATCH] hugetlb: block hugetlb file creation if hugetlb is not set up

in testcase: ltp
version: ltp-x86_64-99ebf35b3-1_20250607
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-04



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506171557.b6192de8-lkp@intel.com



<<<test_start>>>
tag=memfd_create04 stime=1749692234
cmdline="memfd_create04"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1953: TINFO: LTP version: 20250530-27-g99ebf35b3
tst_test.c:1956: TINFO: Tested kernel: 6.15.0-02199-gd72db81adc14 #1 SMP PREEMPT_DYNAMIC Wed Jun  4 12:19:07 CST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
tst_test.c:1774: TINFO: Overall timeout per run is 0h 10m 00s
memfd_create04.c:64: TINFO: Attempt to create file using 64kB huge page size
memfd_create04.c:71: TPASS: Test failed as expected
memfd_create04.c:64: TINFO: Attempt to create file using 512kB huge page size
memfd_create04.c:71: TPASS: Test failed as expected
memfd_create04.c:64: TINFO: Attempt to create file using 2048kB huge page size
memfd_create04.c:73: TFAIL: memfd_create() failed unexpectedly: ENOMEM (12)

Summary:
passed   2
failed   1
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250617/202506171557.b6192de8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
