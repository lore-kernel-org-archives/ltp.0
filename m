Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB82C25B7E
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 06:46:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 388193D04F8
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 08:46:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E94953CFCD7
 for <ltp@lists.linux.it>; Tue, 28 May 2024 08:45:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A2161400066
 for <ltp@lists.linux.it>; Tue, 28 May 2024 08:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716878755; x=1748414755;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=NmZ4Mi4yNejvW2AVI641jrDOSzSGA2X2fOW7A7wsGHA=;
 b=ZFNxBAKyK829lB2rb1IClFwoZVuqseL8n0j3kdR26O49vKkFpjHMVFaL
 zVUwZYaUxflDKIp7Iepwogix6tjc9w5Msl/FTBYTpuZuj3bOygRxkBYD9
 J5bbiK0ASBulAl+CyJG22WhmDuI0TuHd4bNwo73SEW+2D+qFfwAFWUsMd
 sLda+voe/EFaD2hjH+bqbsFCtxvuh1yLr2ydplrA/2lJlb+oJY1rOXnpd
 RoV8iVg/vrxdVQ1vFAW6jqC1+1huKn28N8yCvEIg3hsj5dXMd0yn80bEJ
 KvU8tnTM7CeTdfCACxeDatIOVodjT+V0l5ugq+E5SgqKUuQZ05uU43W/5 Q==;
X-CSE-ConnectionGUID: 6ehNZ8GrROSOyzYtJlzbNA==
X-CSE-MsgGUID: nl6x+Mr0T5GwwFLnkzcZbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13331271"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="13331271"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 23:45:47 -0700
X-CSE-ConnectionGUID: /aWxLNZSTwSL/qTQU3OJaQ==
X-CSE-MsgGUID: EndF+G8sRmKB4ElQKwoE4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="39362495"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 May 2024 23:45:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 23:45:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 23:45:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 23:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1pi7kUw73EXIsBYzw8LA7bbGScqT7WRQTz12Z1F3voBaNzBCx9hz44rCnKTN+9GcSo29YLz8X0HL9RwxtyKrgY7eypFLz7BaButGArGrv2CUUjJmJpIK7lxUkrcdo/IaD6XJ6MT2aSO2ioNQD7iDaoodplKe4hEEXi+4v4AZoyASdW3HOoGn5EYxji/9BTSOYwZhW3UXe/8Shg2ztte8rhjCnucKxh/fAcUMJxBztKOwZzkrKSv1cKHFBma7kBZxCeeeOQTcHHzj+4se3w7dT0MRklViga4p3XC5u3OI75x/5o0TJAADlVvAbXMCPZkWhW+VtmeayY9d+E+2EpbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cePYFJlphZMibNqWdYQRX87h2i8hF7WpHP1A/pVrO0=;
 b=nhSOOfEu0Jcgxr//KkHgL3fBlmhP+s0u1gXDFHKyGS2kJeIgEelLSsu+rdMN9/b5Ssa609cyjlTWXBjAxevxy6467x3X8X5J4L46px1W4PJO9vVDbxp1bymTKaXcWLAwf/d/kGez7wQS9dqGbL8UxsJYaIkXPYFsHXLNYaiQGkl1AEiDVHpzzVPkYT2q2ZUCrApANSAOOa/XFa121qeX/YaPGvuTUNCElm1ZLTDxCbkSllfMYSCdGvbwA7hJqlGSZfKPvFbV2Ztkw8XCmCYCPnxglGZA3SUTbSTTlWFvW++NSdVK1XjN5FXRqEPmPdXgkV0D1YMSu4Rnp7dgfy9hYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 06:45:43 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 06:45:43 +0000
Date: Tue, 28 May 2024 14:45:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Message-ID: <202405281421.127ddddf-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da29f6b-318a-4222-36c5-08dc7ee1cc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+bU8X22z5XJCcDusw4inf3HkFfJMXFW0Aj/p1OGMwFW2wpQpxW2llK0uBpcy?=
 =?us-ascii?Q?ErB+D5AUwzZACj7b6qUg5GZLFxOyCzWw8X4wibZjw0S4Sh7Vk5dVRQrFa3lI?=
 =?us-ascii?Q?qqPebS31T7tPsZ26tH0KiVbDqGddkz4MFdrY66pVKkpKs3WNwygp0Ch70Py2?=
 =?us-ascii?Q?dC4QgPE5OsUvDBzDbK/bxSrtov50si+/5DLLDchm+X8I1GskIHgOWAvxPK1k?=
 =?us-ascii?Q?HVGm38UuJHIMJPiG2e8x5y1c1tx/RTRBq7ncUFU/4LqJHYNF7hHHf01HbJn9?=
 =?us-ascii?Q?9N6l8wzs1AMnHfwSU0dJeor3KtytOt41/5gKvX2lqfLhoQiLDPYm+mAmzbzb?=
 =?us-ascii?Q?FtFskuy7/TiX3SnUcKPKfPim+rIZOJ5X06Np3NWaYIdDD+zLcs1JZ8PylN0X?=
 =?us-ascii?Q?3pu4y8zH0KeXV+dAQJ2xpnjhaZUSYUDcukkUgNGedfMJexe4cYtdBZtUk+4v?=
 =?us-ascii?Q?+UJHaMflbppgiKfHwErsbpSCeYSAoyig94feOhFZ5H+2W9eUhwEMKBC5eRkw?=
 =?us-ascii?Q?unL01tZjPEmB1f3S5ESf+wOc4x/ZiTF26u+OJ7MRvvvUwjnutKE/x23UDtzI?=
 =?us-ascii?Q?ATtCYmvIqT+iBaQbPrebzPv7dnMEWEnBGjTtgmocrAGMMFbWmvCOdM7Maq+Y?=
 =?us-ascii?Q?ZJXUNWw2LLqi3tQ7IHqQizDeOo3uBMuTxOepiXoRzYhRzMJxhJDhDNmZktF0?=
 =?us-ascii?Q?tcXLYtSQWwvvSd9Jm3Jn+2nMTAJup7g4I5HLqyPC6bmLng1So6+wBKOn+lOC?=
 =?us-ascii?Q?y+MMjsny9lekq6KxM1FFo0DrhkjqMLhVdcRxfuCYSf5oXt3AZ5saf3n1GCAE?=
 =?us-ascii?Q?gXM3GxJp9VNKMtXvl0iAbMsn3Jdrg3QdQtu+O6ZdcPoSK3jZrckGeyEb3X9r?=
 =?us-ascii?Q?Gffh07K2v1NOUF+FVF3VxgeBOyCz716NKqSjSIoAUeXvLKG/GIgJFzVT5fq5?=
 =?us-ascii?Q?PmI/mWfq0l6ip/xFVEJS4AEcjffvdytEJLW7x11Tt/LWfFT8b+CzVwq7W8bM?=
 =?us-ascii?Q?3XjRz0H6mycuHWPHDvaLHkWiUwK0NIgXzVti04asWq+kiXW6ZVstX4cyIPLC?=
 =?us-ascii?Q?VEfXqKvuxF8I7WvuR7JYt48fs+1AjFccAWwq+TUTnyktzwFq9IGslA3GzIns?=
 =?us-ascii?Q?lq82X6TJWmW9v4/RwjN6PoSUuMa/FqY0BmflcTFhQJTkXnL6dijxZbg21afT?=
 =?us-ascii?Q?d7UoDCqVi9ShuYYz1Ia10je+6gZN9m59X2mMdzOVVH6/2SZ8bAV7tA3ORa0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ax7iMSXFOAIp71ygp7SWHHoxeR0a9KWC+swnER1sT+Pv3L0r97ZM74kAPo+F?=
 =?us-ascii?Q?7wIpfhd55AAFyLfWhi7ZyD/i13vX2DuSgIDaGqI+9cc8SL1cYSh/Yki18CZP?=
 =?us-ascii?Q?MaJONp97aMBa+D47cbXaEILm+lG9ujx4t3wi8h4MTwDwo605f/dC8l6fFDBf?=
 =?us-ascii?Q?+thOVNRExr9p7VNouim/6e52Ic/9AtbshlgIrIB73RSmiwUyAKFDlSJNBJCb?=
 =?us-ascii?Q?tz2kSFu6Avv8+br9DSL7LBN1OvBejNLgWt/dib5sjBc0k4AK/E3R3t9Ziyc8?=
 =?us-ascii?Q?8RKPvmM5xF84luOiO7rpFBjVPNrAjvUb/b1hUnAyjGxhoflCev8vv5mZkgUR?=
 =?us-ascii?Q?GlFEqt5Ut2GCOF+D5bEWdJviI9sGFD5R2CjZC8tFxl1vG4KnJ2QG2y1OBIJR?=
 =?us-ascii?Q?9PgE3kOZVSI+mHuiYWjLgUDeVK0vc/EUfhVHK8Bxti421lV+w9zTP4KmDF2I?=
 =?us-ascii?Q?rKKPJ+wiaHGwn1MeBm3XYb/H58z9+mD7Xvdumx/jcfaHbpOGobK1JQis+BfQ?=
 =?us-ascii?Q?HGTHcUOERZKS0WRE3JxouHYhn0sTdciXxX/8t4hJdoiQmCGvuyBosPW0Ix6x?=
 =?us-ascii?Q?RckLc6cOCupZ1EX8Ep0qGw+RwRYwAkqs8gH6nMplr47e/k9Ca1BOQgqzXKgp?=
 =?us-ascii?Q?vq5Lx5ynxhfudVsCJZKvtjps2sxs5KsvENC0ihyNA8QT0ZQFQKz3e9zxt1d4?=
 =?us-ascii?Q?d2npIP0Cp4AQP4q2jaXjAnmVuGSpcyr3q8W0quNl25uEggE+ngqNkMELsgCt?=
 =?us-ascii?Q?H0egPyKjWbmfi1/ex3JfMw0xtKuvKy+xQIEbcaRfpsmMKKnYN+sdnGqwKKCx?=
 =?us-ascii?Q?3esJDZTFer4T+zMxpi1F9Vm4Y+WkKM00BKcsMb+41XPmZLzXFWaCFN68Zk0E?=
 =?us-ascii?Q?/TBKp0Y1RsGfvYQwsfWA02yH7myAXWW5nHZ6d+0gzuw+uEOQly1miho+T5TY?=
 =?us-ascii?Q?Al9diigFMSudF3opE61x1UFp96c0uLtiCmoFPM+I2QOAL1F3OGkdM0DyLKiM?=
 =?us-ascii?Q?RyOb/F6+hizX4ZBL/UX4EMSXOaElpZAGzbj8hEwFUOIDjRVzs5yZhB8dD2tm?=
 =?us-ascii?Q?o3YF8sbAdGv7u5KjmnBUNReddm21zBf6jh5gL7BB+xhyWIeFWAtTNraO+pK7?=
 =?us-ascii?Q?0tJht0VBkK7HZW7oFAxmIjpsJu/RHLZw4VYCUuJX+M72+L0/QB6PVcaYXGTL?=
 =?us-ascii?Q?b338Ja1dLFHuxEiur57td/Y/TQzKwxBxXFHia05Sxluhzbse+GavkVsuRVaA?=
 =?us-ascii?Q?DdZzeJHYP/tbP+bwjr2hVIkPeQJspMGVgf2YgSVIOfc2pitkFybRx8UWu5NC?=
 =?us-ascii?Q?LvjMSR2vX/DOpCigvL7JRi9tGiIRTRpSt0EbQKFA2cl7ZMXtaWTZ0sVOERzm?=
 =?us-ascii?Q?mczq9cYlMr44irihTvZMHlLQfaaOKQRUOvEPv6U2Miz8pex+P/4e0KKIqYL7?=
 =?us-ascii?Q?RyxYUBxvHhH2aHlfkkRPcV2BN4Uy+GptGBKo3MHJKhgw/0kjM/7f7139m6XI?=
 =?us-ascii?Q?eXWnGjz5u6T44aDcoeqCcKffKy+kThvpdoXBAO1RoIQzvgm9F71J/mN8amDs?=
 =?us-ascii?Q?Y3pT4gUaJ6zIlwmxS9nkxdpjc0buvInFElReqoSHNzNPnuN2ZIb+Jdaxhghz?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da29f6b-318a-4222-36c5-08dc7ee1cc05
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 06:45:43.6583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVuCsx13ABV7jyNxkSCbEFHwlBZaj/2ORPA3//vblr/UUvG4E4d5rj3HUg5ZiPzaZvdrEpsWmuYfAm1g8k13UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [dennis-percpu:for-6.11] [percpu_counter] 05dbad003f:
 ltp.getrusage03.fail
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
Cc: lkp@intel.com, linux-mm@kvack.org, oliver.sang@intel.com,
 Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
 Dennis Zhou <dennis@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.getrusage03.fail" on:

commit: 05dbad003f2b2ececb1cc7428bfa8f470cc34b95 ("percpu_counter: add a cmpxchg-based _add_batch variant")
https://git.kernel.org/cgit/linux/kernel/git/dennis/percpu.git for-6.11

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240525
with following parameters:

	disk: 1HDD
	fs: xfs
	test: syscalls-03/getrusage03



compiler: gcc-13
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405281421.127ddddf-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=getrusage03 stime=1716734654
cmdline="getrusage03"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1733: TINFO: LTP version: 20240524-4-g22004c7db
tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
getrusage03.c:43: TPASS: initial.self ~= child.self
getrusage03.c:59: TFAIL: initial.children = 0, expected 102400
getrusage03.c:66: TPASS: child.children == 0
getrusage03.c:86: TFAIL: child.children = 0, expected 307200
getrusage03.c:104: TPASS: initial.children ~= pre_wait.children
getrusage03.c:114: TFAIL: post_wait.children = 0, expected 409600
getrusage03.c:133: TPASS: initial.children ~= after_zombie.children
getrusage03_child.c:57: TPASS: initial.self ~= exec.self
getrusage03_child.c:62: TPASS: initial.children ~= exec.children

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f10206cf8e9

Summary:
passed   6
failed   3
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=8 cstime=27
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-4-g22004c7db

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-4-g22004c7db
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240528/202405281421.127ddddf-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
