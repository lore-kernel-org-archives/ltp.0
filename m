Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515F6C44501
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:27:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B76E83E2DEB
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 10:27:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CBD93E2793
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:27:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 546C82005E9
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783672050; x=1815208050;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=I/y0b4/R98obTs8p+ibMhX94xpZa5cUUuE7pNj0QWQU=;
 b=lqfGdIGGCd+Yp2is+beWqMuAKqCEVVvsuNfzvNKmi9mgDfFpADaT3kzA
 /qOUM73Y9lfiRGO8pEUDptcCi69zXg6d4uHxNagy3pbrYJHvPbUFqHseM
 JSNerZwWa7pj3ZgIreIB4LQUqnz++UEGNgTyhAutUYFM/xVkAfjUYvlQN
 LyfRo9W8YGiq5lBNYVwL/vgvEqfLDFOuXkwphMTPztNzskOczkOKZbXrZ
 ftzk4xOowJDwtdn8Z59xqUyVUS030l03xrpsYxMW5an0+CQtHnF61Mkr3
 1T5FRMwNA6+/Aa8pYlwNWtD8mm5G+bCGF5jNcgCwKnIZnshhy4G9rl4bx A==;
X-CSE-ConnectionGUID: O/EDgVVASNia05YOebFszg==
X-CSE-MsgGUID: EtJpgzU1R06xlC5r73t/wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88053090"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="88053090"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 01:27:28 -0700
X-CSE-ConnectionGUID: Jdx7OeL9S3CHBbKalCpn1A==
X-CSE-MsgGUID: qvdcOS4KQCSRRv8tYYmvmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252178203"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 01:27:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 01:27:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 01:27:26 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 01:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krEGquzJEi38pW8nz+DHFYtIWFoGqZZpWM8M7w7llefY6vMbwd8qtKcNnno5IDEWHEbVpkJMJn1gTMeMs3yWBfHY75DmxVzMdgL25uWyafqNSYhCnRlNwPSMc9xiqPTpIieoyzEY9y8RKNo98bKlfyQO3kZ6fSEtYwygO//o1v69DXrcmjZGrLFlQdl+OqnG3GUY3ZfOd+DChvseUkJyWAz0gOnaYrke0efcLsaUL56Nqkw3GZP7zBbfjqa5UzewtwsrKfP2R+c/jtJQrNRZ+2HsVW9Y1NY13zi9KBbcmE6t94Zo3K3q9hh9Dxshwi4xDujnfJUjYSTNVSjRbskicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAnDXRVaSHzaGFndDRwhKpDf00gnI8lYq0ee368SQRw=;
 b=XiQSXLZiZzdyzcH4rjwvtyWxGsEehs7DBlcJ3HsAh1nckn2wUAQRRVP5mmltBTZoG/27ZngYMcPCp6L4tkelAwotuL+ohnC0wpWveAKnCixQfY1la7/3GzuCPSPkXTEQM1SidHpzxR8z3AZ47pFytJSDmLCPp26geGtKOKSVw/5hY80IgwilK30fvhVmKizriI2edl4oP19eH+Qx+pvk/g+dKWb0tSnrQE58kVLKStXIsQESIy5zmBOSqXUJr8XfjHAprOqAdHu1ddMgghLaYkXqMVOT+y3komMW5CbjC0/gcMyeq/XuZFhImRHxeq4sXXEiCvQ+SSdMD7uyO5/njQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 08:27:24 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:27:24 +0000
Date: Fri, 10 Jul 2026 16:27:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Message-ID: <202607101054.8da4ec23-lkp@intel.com>
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CYYPR11MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cf338d-9e8d-450d-b483-08dede5d11a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|18002099003|56012099006|6133799003|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info: iGiBYXsE/o2li787HIqRnNsNCDRddQq1ThCy9Zwa+YqalsaZJUGeAHLBgwTAgHzD/TOOZJeIhE+JGCP/lfSapAGnEnuL2R+1r4dtGacgSp/oUjbrk7lYwsvSHqcSe1VZ5Y8qhggUYy1PtXXA0weyXvCqdwCBhj2oFAkG6H8slBkIWLkja3zACjJsjOcXUDc5d4iex5XXe+UUUJRCwJ9+TD515l0Xr8T9ivAeYCWzaQpZ7TNnBMcU3ho9RCH6D7ggoqvz7Imi1yrQnX1rO3Whx/6VwWz4eQSlLBUJr6cJsf7zhuf/07gGHWAB1KrntaJeZwS6V5TJ+dEz+W+kBKvtWrKKPK9bUuhYRzNAwseKpCOjRPfTFmTmWMhLxGgGsE23l7iOhun++wY0m1mgwZ06lvxK3Ld4Ds1I9oLg2b+KFAF2Ibr0a+eCpo5sLhyzHTowedfmKhoZi0c5cvU/2d32pgfKTCRoYMBi+ztgZp4WtuMsovm1U8sOqMJz1gXTKhp7pSoFTwOmcLX/DqfQHPihu4o4qLToVFPf5ywLsSKlcEokfZba3jRD2aaLExaxUgkaIhlRui3jRV/DphT2m8xk5fS0zLtF1OeRSRgqaduohtrmlDbwyX8hicJ7TGSIavt2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(18002099003)(56012099006)(6133799003)(3023799007)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzYxVs1gfDqfJxIKkF7XLyBlhINFsMLDkA2gsh0F93TykD2vtkW3Cv6YzpCk?=
 =?us-ascii?Q?uxPEvba2M/UWWQLkAbgE875JSW+cOSs8Ibhhh4ke4x2CZpjm/IRxiqD1X9vH?=
 =?us-ascii?Q?cqOSWpykNBn7uU+CGWhMwPKDvrvZOZJYs+nBM8P84Ibi5GhR5t4oqcr2Dvtb?=
 =?us-ascii?Q?GIGwzExWwFMiaERqo5LYIA3AozuSPmi4ZqNiGeLdTXYQf1o2jDUnxYon0K/5?=
 =?us-ascii?Q?8tq5RkKW1QrbLtmU8oMk64oxXxAbtIVatvClGXRrfXC8xEcWkgQSEPvDxbyJ?=
 =?us-ascii?Q?zEjC0L6ibjSx3maPn0MNSx9lUeZkge7hWIJtx9AsNhYx1/xNPhLay1xAexIA?=
 =?us-ascii?Q?6l6PKUhD2v/CK+ATpwbL+cZEgkpUHPdjMrTENM/mDWl3HIe1gnwhRByJLSPG?=
 =?us-ascii?Q?sSu/PvOnuuSGO3MPMxRVyQfaW1EMtbYpaYeIt7fstIQfdpiEfgynmWx5I0yR?=
 =?us-ascii?Q?HUtOph4kLZqOQodNaJYF9w8VdWgR+3ltA0JgtcXj+9bOHcNu4+pxnGcgpXyO?=
 =?us-ascii?Q?xFDLK6v1McYMFNOY7gLXSqDoJbN/2DzTwPCS67NmfAXtoBZWu3R/drJ5c0AT?=
 =?us-ascii?Q?GID6n+OP8IMgE/SqeZ5sn1fNbKctdUcuOS2PCpn7vipWGr60/AXTod63rfKq?=
 =?us-ascii?Q?tSCTnmW46T0ZdE7fyQIg7trRCOAKWpCqB+kebs2AlYc19ScMvydImAX0FpP+?=
 =?us-ascii?Q?j5+J9AjM/6uHnlvus68+Ch/5ZnIOrGqqIvtwfB50nDIrH3vZznMP9XI2q3LN?=
 =?us-ascii?Q?oLhwKUpzR9EIteUrfYNNOrLpHqzcijJnxmlc2bqcj31CuVbyQoQlOkvJuUNw?=
 =?us-ascii?Q?d5ziqT/RDHv5nYqGQE/OFIEfEAgtrsvy7SXvV0FXb43JtjMMFbqbGEoHvxi2?=
 =?us-ascii?Q?Cm/c26lGbXd7c/dnWtmCAf/4/ONqXJdPLtpHOgQmSFipFDZJjyUkkASqdFz7?=
 =?us-ascii?Q?wkN9jOt8yJMelB2tXStTc5Pov97J2WVTO3zMSv6EteFwvbGbaEPDOqkcVmIw?=
 =?us-ascii?Q?uAAaR1Cik4BTtX8RE6jCyzUjH+3qIo1qZO3T+BcriK24N00/zETJoJoTjO4s?=
 =?us-ascii?Q?PY4OPZWdkKeBkzadWKW5B/j0IckDTRzl2xGeONLhSNsuD4/UJNCn1FQixy/T?=
 =?us-ascii?Q?FIdcA4yPTY7paYAjwln+zDgv0Rw+EYq05iINb4POf7IseG/uewwfS5X9nwT8?=
 =?us-ascii?Q?aoU/XbQASz1wA0FwrBFGZ9N66Dt0Q/Q5PUgB6dJmsNA4Iev+5dRqQbK+7ibE?=
 =?us-ascii?Q?/4LBNAwypXzE90M/yTjQYmjH4U1mZ4xQC9fkNZGh2od97wntU11rafyjrEsr?=
 =?us-ascii?Q?ghZ4F7PMuUlQ3/B++9lnC2XFd/HsA6y3y6pxle3prDeYE9Zun1nZLGptHQh3?=
 =?us-ascii?Q?IDrjuvnecSBofu772wvWOFGyCB93eRmle+2GGjD4ngtCDpW9buyDLCBuT8BL?=
 =?us-ascii?Q?MOR2L8pb0nluEF4n6NcMh8MwFsvvx0YCg9yoJXdyKx3irekKgoUF6skKhZWn?=
 =?us-ascii?Q?8GohwX1f6ANuJtuhSi++l/ixb7tYXfClfRxLatGGsf1yVKJ6imx+FPXw4pI7?=
 =?us-ascii?Q?t9b+42uFyU/ZPD3Y8avcZ9lGk7BuqlrDmnMIYBa9qXBvZOe6gkDNvFR+tO03?=
 =?us-ascii?Q?LEHjjNJs9gEoceyiv+5rDOBk8wYL9eR0I9kPLe7pKqLvd8Rt/aaY5jZ2yfsh?=
 =?us-ascii?Q?iA0SraIsO2xgnLiT8gD/sMTsZppyC9kiMv91IlkCvwYhCmTT+HuhoHZoNiyF?=
 =?us-ascii?Q?NxPdu6jzlg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Pw9eCQCQVK5Fvh5l+EiS13w9tphINP9rxVquo3tQoRGXoo1eC9GObKssf+XKiCbVF5PWJY1paHl/HWJbs2UjZq+tyy4oIMRlsW0VItmD3YTAhvwXORL5gu2YPh3MgYYdbGhZt4XCETSiGy2gKNFVKTqYSdq+aOs/pwAbX+O/CE2uqme1WKgU/1jrOlfVQtm2AXBwrf0r270JOenGJFbaWUcabAO7+8dF2C+orQ9F6VEM+HipqNCMe7C60jc019QkdugB7DdCfwxbhYqwvj0tetP34ULehrRC04XZ0BypJtLR2Ncwx7qtJFuye5kgRu/6cIdpEZqhrcIkadAFKmZP2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cf338d-9e8d-450d-b483-08dede5d11a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:27:24.5093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgVZBpRg0rIhuhNZ4qtF3jPFEDuvDsFaDoOn7y7RZ9qW+LRpSj6GgVxDEcjPM382uuV3o4wwGGPO3U+6s4VhUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linus:master] [exfat] 82a81a7352:
 invoked_oom-killer:gfp_mask=0x
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
Cc: lkp@intel.com, "Darrick J. Wong" <djwong@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

this report is just FYI.

seems 82a81a7352 causes more memory footprint in our ltp tests on a 16G memory
Skylake desktop machine.

parent can always pass without the issues.



kernel test robot noticed "invoked_oom-killer:gfp_mask=0x" on:

commit: 82a81a7352bcf5f2756ac33d47ee0582737e9a85 ("exfat: add iomap buffered I/O support")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      2c7c88a412aa6d09cd04b414211b4ef8553b5309]
[test failed on linux-next/master 34cf6dafc47441dfb6b356a095b89c3585a93714]
[test failed on fix commit        5362e7aedd113bb8b042e47e385103fe98274764]

in testcase: ltp
version: 
with following parameters:

	disk: 1SSD
	fs: f2fs
	test: syscalls-06



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607101054.8da4ec23-lkp@intel.com



[  430.386383][T10010] BTRFS info (device loop0): last unmount of filesystem 5e76d402-936a-4bbd-a5ab-c986cca03967
[  430.422556][T10105] Adding 1020k swap on mntpoint/swapfile01.  Priority:-1 extents:1 across:1020k SS
[  431.662145][T10105] Adding 131068k swap on mntpoint/swapfile01.  Priority:-1 extents:1 across:131068k SS
[  432.662740][T10115] swapon: swapfile has holes
[  432.678788][T10115] swapon: swapfile has holes
[  432.769811][T10115] swapon01 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
[  432.770508][T10115] CPU: 3 UID: 0 PID: 10115 Comm: swapon01 Tainted: G           OE       7.1.0+ #1 PREEMPT(lazy)
[  432.770513][T10115] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  432.770515][T10115] Hardware name: System manufacturer System Product Name/Z170I PRO GAMING, BIOS 3805 05/16/2018
[  432.770529][T10115] Call Trace:
[  432.770531][T10115]  <TASK>
[  432.770533][T10115]  dump_stack_lvl (kbuild/src/lib/dump_stack.c:94 kbuild/src/lib/dump_stack.c:120)
[  432.770539][T10115]  dump_header (kbuild/src/mm/oom_kill.c:464)
[  432.770542][T10115]  oom_kill_process.cold (kbuild/src/mm/oom_kill.c:1031)
[  432.770545][T10115]  out_of_memory (kbuild/src/mm/oom_kill.c:1169 (discriminator 4))


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260710/202607101054.8da4ec23-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
