Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CA0C27C6E
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 06:39:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 347D23D0C84
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 08:39:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D25A43CE1F9
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 08:39:26 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 069CB140517B
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 08:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718347166; x=1749883166;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=gY4bQvMYT39/ftMLSHutEaEsxcm3IqHAvJoVfK9DWJs=;
 b=fuxQmxt0I2dqbCZHq37FDtOg45W8uq7hcSk1Zpc+PY7BK6fEm8jnabEB
 1QTlIIxCuZLHsV72XQwnjMIGd7AGKIO4TPvkFegTZRUK4fBy2YkF9MLTV
 +bY4+OxwAg9TlD4o7gxav2DA2nSmARc8ta3R0W9AlbKn3hKykfh7u7RMf
 OVprDVTvulkr/Elib2So/O690e7NnaebztryHlQ8L27oFeZ6XzHyRGxmv
 MGiGNz/d2SHrTE96e+YGjPodmq9w1RtiUNXPvOtKw3fw4M/oFxrIcQWpL
 b0WSO62H+aPS/A99evcLro/EeHk/n5LRDZR8XG2nJ4Q8aDEzP5ybY8deh w==;
X-CSE-ConnectionGUID: rnHR+QfgRJC0qLapioew8A==
X-CSE-MsgGUID: RmUt8r+ESbyxI76d9z+/Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15352868"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; d="scan'208";a="15352868"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 23:39:21 -0700
X-CSE-ConnectionGUID: lE5IB9tsTjSRP+2vSr7llg==
X-CSE-MsgGUID: f1CcQ/ALQg2MKLAi3hkJWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; d="scan'208";a="77878454"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 23:39:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 23:39:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 23:39:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 23:39:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 23:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feUxRweKyNe2wQtbNQXoTc2qC8D2UrnBwEMLnPdAADQkqHY51S06KDlInO9rAZOIH/lYPRiNftj/8bucE1Z5RgI26LWm2g2ZXkrbqOMbnX6VCuSGjJjbm1C/3fs7dT90Z1cBkasnjeJF6Bn+JEPRm9FP5pli+ExzR1adkspNBJ/wsM/BREtMAqPUp8XbzEN9SdPD7rOHsV83unYUUKsakC+CusLjJQ8S2ijXrskYIkvYwkN5o6OMzfl/QJXs6m/6osMW562gyIqdVNUsS+a53W4NkO7B45pJcjBgJCPtFr+ZtBuNTaxlYATtN67mk1voH5F6hGghMuN94apLw9q8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n9daMOzdNhzZSpvDJadEzG8STm3edMSGt/0v1jnEVU=;
 b=OyJF0dnm3KqSzSlOZXN9x+VpYZ3fseOmpbMxqrLnaVLrTOqOvWjQXtO2FPPyz29Kr3vtA9IzQ7DwQwgc3d37yZci0ywvsFtYbQrlfrI5rlDB2cKlmNMG/7ukd4zUC14OPSzIM6277twomyt1mIiIzBwlzXlQOiSQfzPTEGEwiQkIfXqtR60vilNhQyXLcGH4EO9NroSXF31Dq4tV33Maqh3sNSJ1gjoIvmfb4kqOEsBSLg0ethCus4/BOFXDpMOvdjbWgvXbWLVIhyTC4/ZqZcCY2XXmpsS/W4aRtSnjftGE8LOpwEkw8RV0UA9EjolE4p0ZkH4z6vOYHKUCOd6xGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8725.namprd11.prod.outlook.com (2603:10b6:408:21e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 06:39:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 06:39:11 +0000
Date: Fri, 14 Jun 2024 14:39:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <202406141431.2b72ca61-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: deef17c3-9fe2-44e0-fa21-08dc8c3cb2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K0bdr35K+jz2930/Z2xmhqaEUgJPu6ttXKW1mF3FjN0Z9IQbKFThAGTWgpnq?=
 =?us-ascii?Q?oLkoD4IM+s+9hl2a7gi7Xoj6UxMTmxFyO674NN0TV+1w+cIAUshRGzfWZ/aU?=
 =?us-ascii?Q?mtY5aIQFgkhALN5Pjc9kIoWyhpoB2vUp3014A05Ym+50NLmrFr3XG1+hV9Hy?=
 =?us-ascii?Q?rFZR1Os02sdLUigelyfbfAKukr/DQFH09CCYuR1yMQRtOnkykMYWppPXSa8L?=
 =?us-ascii?Q?dKtxtGYwtx4nnCAQWMWUVOqbI3GFbfLTbvvKTRT4R3N6rzonFZATBwAdsmkt?=
 =?us-ascii?Q?00M0R3DvmsYFA79kagNSLoHewaPG4a4LlE+HbVWvVXg8wFXHj48IPgqhWIQ1?=
 =?us-ascii?Q?acU660Jozhr9CpXmmiNdVaQhPVGvWu+MRcNzo8UQQ0AzM3GL5qX428A28ydo?=
 =?us-ascii?Q?Tm8PeHJWPvGNs+TVvhMII38xkGbWtdhD6v0jj0zusItHAZDdA4pQjKTtDS2j?=
 =?us-ascii?Q?xfu7luriRaHPzV1kJALGEPJasW3Sb9XVCE/49NXffhnBMxUu90ElxWPzE2MS?=
 =?us-ascii?Q?YFf2jgI8uI4mCl1Dxo/r/WZG6JzyW3Zh0an6Sh9mQgXWaVirQY9Y3cgrg4e7?=
 =?us-ascii?Q?rYh8MNO+SK95P8PN9L0fnKkCQPu5LPR5fJS2GwZXl6XbdLVHvqHiySL5Fi8c?=
 =?us-ascii?Q?xUTHC5CkXJcvzvWx3Jqy8XPKYS+4e/N5Px03AzyCiFs9DSgNVIMWBg4LleKt?=
 =?us-ascii?Q?0C459jC4WcEILJOojrW3AinwE63jBiasd8svJChx7dmunQt3KgZZ79VJ66m1?=
 =?us-ascii?Q?4/GDQETDbBZeh6MUJ4xHd5JUYfUAbhzbEsWeCuJ7dNgOA/rSi/2wX/820Gsi?=
 =?us-ascii?Q?SKWxaX0c40SJ9hwhvXCYwtTnDCKrrBNofsTn24IPVamve2f6k7M79W/LFHTB?=
 =?us-ascii?Q?Nwjare3uE+Y7ein5p5eGjI9rJvyxDVwgfAyEyvzF1HA17nxw56UhmXXlNuNL?=
 =?us-ascii?Q?EgDF8hj1F+EOwBY5Y+E5bG633Qp2hF3UHVlgW+XONsmc5JjQ5mza3UPMeugJ?=
 =?us-ascii?Q?CqGjGFXY0s3hyrXr9KQ1FP9V2k/QBvVAhd1n9ex7QBFfw3bHKGRzTPcA15Hy?=
 =?us-ascii?Q?qAHByf7f8lZ5n4iLs7DD/9+RyeJHt8HUePN2MXIgKTcdOKhu3nrr7N3I09CL?=
 =?us-ascii?Q?903T0zOLJgtVciPoorpgZX87/5iS3uI9R6+MFegq9h0thSW8yvnQq7dpQluB?=
 =?us-ascii?Q?ht6s382nC+xLjYzAblVsXvYuvKcpUq/zIhojjEErMe25vnlyVueqBvmQSeVJ?=
 =?us-ascii?Q?lKPp86PsiGLTyalE1ySa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(376009)(1800799019)(366011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BrohV9DeO8K3McqN5q1/4K+FmPWui9TCTZ6CcQgw33ve/33+LYbneEzIcpQN?=
 =?us-ascii?Q?5VwNgu3ssxceTb/9Eu1aOygVZoCEEH/EVfGjfgFyhq+48Cktq4P0puqhB5ij?=
 =?us-ascii?Q?2zg4oCM/7QZqLIYs27fBvY6EDL8talCOPclBVs8kYZyEpuXgGyN9cS2vNyuh?=
 =?us-ascii?Q?KGsstQ3H1r2cMm1qb8g7BBDKdh2vizc4T4p4bBxubcbUrWc8Lzmjc6VReCRa?=
 =?us-ascii?Q?k5frAhgK5mEFNeFfxn3z5JYXmuzaWn+cWU6ri4vlkLi7/+1Dldh0mmEyflA7?=
 =?us-ascii?Q?nG2XULgTi/iJgDTy0ob3MCH2vM6ST+d2HLmdU5rPcyRPLqUToUem8k1dIHnh?=
 =?us-ascii?Q?4Qx47sv4CXf23PeXGPHJwutLh+MIzLJ52OHlJ94QYMFGrZzxubhlvUSz90a+?=
 =?us-ascii?Q?VKw74pEsRXgKKDvPAggVmPr9XxtzftSWj6A9UzSozjbCQZcdpa0SHaj8s/Tj?=
 =?us-ascii?Q?E+zGTa/UjLo+uwFd8p16dGSY7o/eTSSb3PEgHjDOlTo7vF8BE+UTfvw05kdZ?=
 =?us-ascii?Q?xJ60M+IaK5AyQXQZAPIqEs7308r9aNzQ+XjAFnodqDSoOTzgXES8Ads8d53l?=
 =?us-ascii?Q?5ABnbxqqdtMHrm+uKMejBLcTWzM+JsovKq79fLplBuNBRsd57ckV85D7wiBB?=
 =?us-ascii?Q?adU8TZhmFdc4qONjQsgmQRQ6C8/SffRbUps1XIxFSNV8jEC6CkUA22CfH2so?=
 =?us-ascii?Q?UexVoJPjA7sYKEDHUIjBjt3LsG4VmxuxvejhtdSohcsPKCHWTypCBJRWVL7C?=
 =?us-ascii?Q?FL9dcpOQdMN+eiutNRNsrT63G3loVV7V3hYjxDfTRZPJ+fyDmxv4+mp6o4Ew?=
 =?us-ascii?Q?rzGX94IUKN4CJbzgOjIgy43Cf6bk8m6lf7qoj9heICS5NPg2ouWUIYXJe4PJ?=
 =?us-ascii?Q?g+szZEfjAAk/BvG7hCCnVP2JJgKN54gXeVOaKzEAYA//6NfxvmVRfdEkjzDB?=
 =?us-ascii?Q?VS3MKWtdlyEObiNZxcaKkdiVSOwnTDyOKD+YUxU2ePbv3mWR8t6g0rgJ1A4L?=
 =?us-ascii?Q?/vtdjMuJF+eNxk+AE9FLYFDjXU30iWmffEt3Vjs/sVJ9zKn4kQHy1W1EUO7S?=
 =?us-ascii?Q?9I8tMV6PTpf5jOGzvcHPNV0byYKvS0yEdeD40ddAaLqFBIwq8OynrE15sxBP?=
 =?us-ascii?Q?yocZa1sM8hbgg7nv+RqKsaOW8ZyvIvKcPXrcHu572qV8o+vDe2EmS1/bnWiQ?=
 =?us-ascii?Q?BhUoh5btbOYIQde6uFsN4qKLz71ECymOBkKLi8QT4de3JM6bf+ONWjE2fNLe?=
 =?us-ascii?Q?CDbx4+/8Tr1mONatrka/qL4XnaJUfj8UKGsQxSpQPvHyLP6WMGGPmRffItNM?=
 =?us-ascii?Q?i2ieSoekf950sbhFuYW5gjmpAgokIhu3Yf2/tPppaK+EbORck7KzPRl6llLS?=
 =?us-ascii?Q?dZYsNabd3Rn+AuGXn+Bz5iIRZvgnVhrq11Y4haUdpgAsXT0O5VSC9OnmArzC?=
 =?us-ascii?Q?gVprB88O8RqniQomMXfHm4wLl5MNSlerHLNCdaNOlznvxJMNYw9m7OGkrHiY?=
 =?us-ascii?Q?Kk3ur5EPl/u8FWXYScC0okyfBbbueZLPDH/XatnYVG2dirdmGyZxq8zjlMFU?=
 =?us-ascii?Q?TlTRWbEDhIek9msy4z7sf0fDV23imH6v6B1NSUAyYJO2BTcSIKLw+mtqeYiT?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deef17c3-9fe2-44e0-fa21-08dc8c3cb2ca
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 06:39:10.9920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKvbcCDnphbW02psBp57c848B/mezAtzYYR+wmBiNPmT/3/gIRFBAL+WCARy+3c8MClnkOgoiDt7bNFQFrrndA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8725
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [fs]  2a010c4128: ltp.creat07.fail
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 Linux Memory Management List <linux-mm@kvack.org>, oliver.sang@intel.com,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.creat07.fail" on:

commit: 2a010c41285345da60cece35575b4e0af7e7bf44 ("fs: don't block i_writecount during exec")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 03d44168cbd7fc57d5de56a3730427db758fc7f6]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240608
with following parameters:

	disk: 1HDD
	fs: ext4
	test: syscalls-06/creat07



compiler: gcc-13
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406141431.2b72ca61-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=creat07 stime=1718170008
cmdline="creat07"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1734: TINFO: LTP version: 20240524-32-ge2c52c5bb
tst_test.c:1618: TINFO: Timeout per run is 0h 02m 30s
creat07.c:37: TFAIL: creat() succeeded unexpectedly
Test timeouted, sending SIGKILL!
tst_test.c:1666: TINFO: Killed the leftover descendant processes
tst_test.c:1672: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1674: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   1
broken   1
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=150 termination_type=exited termination_id=3 corefile=no
cutime=0 cstime=4
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-32-ge2c52c5bb

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-32-ge2c52c5bb
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240614/202406141431.2b72ca61-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
