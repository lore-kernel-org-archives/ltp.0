Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D33D10D14B4
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 13:41:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 253AC3D073E
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 15:41:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADCA53CF6F3
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 15:41:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2493E600BD2
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 15:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774878079; x=1806414079;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=ybLTGCNceHvKot2cmMPytNzc237nMDleo7u/6XH7mIA=;
 b=KL+jAHzrFSQ29WN4gMNZOR7UTYyLeZpL0a04jXCCLSKI/KZIOWkhWQWR
 WlqnlWqpjbxRg8Z96iP9B0lvVg2gY/QxvAPvcPTiwC2Eji0715yoc9tH8
 Ll4QnFrK3gGu0leIYU5Bkk4HAw95f6/blsDgDc75v+BM1c7eAtzi50Vfl
 9npw8Hg61PiOAkBDBqMuB9Z30xcV8aM0CM2SxN1WbmX3R2i4EbZw4kZ9p
 udycVSyKri1x3iV31kx77Vd0uPH9dxVcvP2L9aQZPryEhpBe1bmizrobL
 Udg+09FD3rfOVFdVrVFuF+/IapaZ/WC92FLv0h0gqP4zatvY+YVlOFp7P w==;
X-CSE-ConnectionGUID: 9cEuJRSFRAKTAE4buy1lZw==
X-CSE-MsgGUID: LaDkUqBvSseYW798OjPiwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75048292"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75048292"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 06:41:16 -0700
X-CSE-ConnectionGUID: jODvTK5dT9SK1crqOL4BbA==
X-CSE-MsgGUID: f2ujT7QtQD2T5o3wec6CMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="223182849"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 06:41:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:41:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 06:41:16 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:41:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW7+zBGM6i6jYn+EOjyJa8P0V4pTEsSbxlS0OIIzCWPkPjcoQEAgzlUN1hhhn/SmYM2ugaHaJfbv7F+TFLrmayfBy7QWePCBDGmIIzHi8M8raeMHxzEtja1SGO9jvnRRnZ9Lb3DNb1fGkM2SLG+ZVOLkwFOiJrz7anJP28WjaBEEFOCgWyAQ8hm4qHJbboZL+8TYJ0/G02fKdSjb/ZGEDfVUM/isoQLCL0WDD2iPeMUm2DguagZvCNryNUGteu9V+sAPTx74pz8kcwgoXPHHVFLOk13tJLzuWf/Gzj44OzgYKb4nQ6N7GPZvJpxxgh0jKxvTwm4q6BslmxuB4wtlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACVCBGBjlN7qjfF7nmQ9s27nuDwXHmTxlnpBswlT7iE=;
 b=afLbwReBm8byV46sShqjrCDf+8uByhB714JW5zpKRR6r8INnrLnvGUIHsFbl0epApuaasWEtINPMq9IHJ9juDJjvYukqpuoXHc+v4Vn7Sw0bJ9hkmL5l7gjxNCXxsD5l5A7WhhC/ci+sAE9DnomGKsHfNZUITqgl/JR3Mm/1AL/CqlOcT7hc8FvXfiLGf5pwHSfqnOXfQyuOKSL1GFVjCJ3eCgCjpMtTw2s+8+Rf/x+ofx4+8og3bMTD59sauiBSLWBc9fGM5/t2NQhjnX4f193GFksIjltg9g/7Dm2PkzYbV/RZhUvIwXOP5/vnE/IgO+QPswg2M4KphP26BODE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:41:13 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 13:41:13 +0000
Date: Mon, 30 Mar 2026 21:41:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mike Rapoport <rppt@kernel.org>
Message-ID: <202603302154.b50adaf1-lkp@intel.com>
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|MW4PR11MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 12236896-2322-4dc1-0ff8-08de8e620282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6DPVaKXICJpEzfgpuC4Bs9b4o9j8Wezk66mnQeGzqamn7HPnqI5XfL3PZLe9wjwhl9stVWhw1g819wExLYrhg3cncH/mhmf1maiZhbPz32adV+HBJ+a0/voat4+h4rl/WTVjI01wUoXAOlMADYZRdK4pbQYomeEr9a8HIAL9mtLk9p0/KHbLz+KsXc2Ye9ErZvpl5kuu3ugZ1CEd0GqRzwKz/9XsBDq0XDBk2a9ZqUBHCasNUVSR30SChZD7NuPcYVmAnoX0B0WO0p6dIN0orvth/NowjggeI0euBccCZOATe1r3WmP03m9ulutOO6vhNlceypO39jzbj/psts04Idtks5il4I5OfKnwff97JqihZVx8zIUkLuvbG2Gw3pC5zyRIrDSaCttnWyb2SvdiLCIcq9Ujg75aGSu4kKC0/25IAwkQ8kIKTfaDih3dtVrzWrkieq0fowhLc3Pf5QDZsASeuyKBbO1DMRls4EtcQ8T6z+5/lumL3Wh3MoTcrgRsvTssrMnVdfra8+X4GbF9/Lb45dsmEmkukT5z7jx8S1q1FM8RADKO+PXvZTwRIvyl/nDOvs9qwUYr4PXeU5sR8fjp+cwznlUZssyje9P6GAVKfxtwJ4uQbLikXa7UwJLYaW5jgMFqOMuJmFduQ7lgBqxWIxurmCXAhuY27+qy6ZglJN64yS7uovCCmcnD6pPFP8w/zpr73cxY7vf8bydJpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G/8ykTn89oVBVMLhomUFjaMCrLSDX5NIs8w0zS0K8VnyoLckhZvL8X/8ljg5?=
 =?us-ascii?Q?36Wnu5SiCSX49rduPhjla6pQFZlcVFbedoP9asMt85QHFpObenaxEZvq35fG?=
 =?us-ascii?Q?tKYyzj5rM6bU48dcnO/MybOnq2cVtjil89v99sbG5jk377m3UdWW1/HRfv+J?=
 =?us-ascii?Q?m4H/5VGU3L48cBxeU/JgiGI1NhA+yGcOmCege7499pvBR4dj0rh6EXgWAq3I?=
 =?us-ascii?Q?OmXHm0L3hWUmN9eE1Nqy8ZwuryGktkZMXEpiusqkGTgvx0GWzdbEAIsjrc+0?=
 =?us-ascii?Q?sd+tj2z5fgwQXn4JTLUZBLvBnIAOEWJ/0V77J6bvwqOvy3LhtHniaB6Y1I2g?=
 =?us-ascii?Q?KO4WB8+XY60Tl5I7B7uJ89E0H3p6VthanXFqaB05gvEsnvDSebs7Uv+N93So?=
 =?us-ascii?Q?nolv5gWgevbJNG8/uXppMU+OPjdmnE2iITRKhXFmHlMpMymOfw+3+yNnn6Pi?=
 =?us-ascii?Q?8s/ZkMlCfZG8f+Y55GwVfrAfdgkgK8OwYQdjHB68Bvqh36BQx8zptdVEVR6t?=
 =?us-ascii?Q?cgRD57lw1ZVVtuM8LEhu/3hjPhcyYw5keHLrTLX4yYG54vIfKLDHrZIkJ1y6?=
 =?us-ascii?Q?BnvcxV2RKbami/8h1Rrf2O3t1WymZFSlLgVlbjZ7OM9oGhGf7PDhIhaP4aiW?=
 =?us-ascii?Q?/JV02sqdoZE6zXORcBiMnDhNV/cE6DDRIV2ff8lHguViTmTb8D5UeVgTB6Uz?=
 =?us-ascii?Q?GhjcH4r5rtQGnuFxLataz/ccAJCrNcCA0pNFxKvdqlz7RksrmTP7pbDWok0T?=
 =?us-ascii?Q?B4T3egBMBMPDI74VHcGLSr0CxvUtpKNhLri4LnGa+aw3mGlsm4OaB5qeyFot?=
 =?us-ascii?Q?xB6Gne5WTnwEThd3Mn1njEbDy09FgHmPtiYrNigRiu+OhHb23bo0yJ6/ZUck?=
 =?us-ascii?Q?QFyBJq2i5o9eTQ/rED5g6QezrW7MLk8FSQtBxJrhDZhoKPXm4gjOrZyNGeIQ?=
 =?us-ascii?Q?dNSiLZ32WkVxEQ3S7muecbfo4SOwKpz4NI9qv+bWakhu++uYq9FKtUeHxBQb?=
 =?us-ascii?Q?w4K64DIwi4+g/IWOVX65EI1Jek/+2l6av/Olu0lG8o9E/Zr+duT1US+An9qj?=
 =?us-ascii?Q?sgGmq4wcX+TVldg+UvhBLnCV88a8He/LHDhF1pGRLz3LMNh2BejQF1UfDG1j?=
 =?us-ascii?Q?o+xqLPUweToSc8D0izkoezXsmSmGV1dKD7vAcSVR6rwt6Kb2DQbCkkphBj+u?=
 =?us-ascii?Q?G9JDhxdZMD8AyPsjWy5n+gaU+D9qBZPsfuyn3px7N0vXPdp4C09w59aeWJtV?=
 =?us-ascii?Q?QXi8gONSq1coG2suvTi8hd2r9zBg7E3IJHGCCrICnv5yKbc70ngGkc+3tVUi?=
 =?us-ascii?Q?fbhcU5xNfcd51GEz0c+lntR0Wt4fkvU6NdRjaITZSEEjVHdt5Og+8qpP2KpL?=
 =?us-ascii?Q?NG23W4jjC8T7MzAEltZ35KB37nQFjPKCdcO1XHZ+FrZcuuVFsm7xbOOe4eHB?=
 =?us-ascii?Q?8XhTYmVKqMqZtd26WE/ps5ugTXTIU9JhMBw0pMpX83Qwuc+7TUEqkCMrAVpS?=
 =?us-ascii?Q?xWth/iU+3CP0W+TfRYLC9qbjJNPGZX9f60v4fDEcVY5fuStLA1RSRoGK5CEP?=
 =?us-ascii?Q?h26Wb2s40xrWLIuchQ69tlkzxF6TrcyrxtRD6hRLcj5XyMgDiDiEINLKzsCN?=
 =?us-ascii?Q?HwjLo4ADmvXHQuvzZXdvdsW6yF6Jya56gL++HUjo+GLg3O8jKUTDZ7v5lM75?=
 =?us-ascii?Q?jyErAujOp576mg/fYSVXiAQ1ZBFVTt1VHzHlhf0UfMzyBOgEwNCH2YBXL4gL?=
 =?us-ascii?Q?Ga4+YUTUHA=3D=3D?=
X-Exchange-RoutingPolicyChecked: XIEwmTuUxz8PGcZkJ3nXm+NN4z2cC0t4BuBRkRyDWCHigEC9NMuOBgjskTT9HF/nEdO28P9FdkKANpp4smrQFnSFMKUlWOn0omrhw4ENyfbAanb3+boLMfeN23BjQu78Sak87Rtk47DnM0hHtIkeS6kDtRmu9HlnQllHmRW8MxQmmEgxy3Fjlu2CfYtoMOoa/V3EWAR4rPJ+UbbTtiGWIGHfVpMGOpV9TcFEhi5KojiiR6dI64eflqtAZs4j7lj8DvXeVCfRT5tlS8OgQArRh5AKrJpMHVGj0qv/p3HVZBnXzKY9p9GtBdhdCZe3sFAW4sfYKa4CA+btiJOmPL2Dng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12236896-2322-4dc1-0ff8-08de8e620282
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:41:13.5024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jkAdhAp3b8mXJDG+bJdmMcyN/2PQKWtT6VBW91SCg3ZszSxKJgSfdq6n5uqdcH1nOL2UN87V/RZnc/oFnwmFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5911
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [memblock] c7fc9cde41:
 RIP:__free_reserved_area
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
Cc: oe-lkp@lists.linux.dev, linux-mm@kvack.org, oliver.sang@intel.com,
 lkp@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "RIP:__free_reserved_area" on:

commit: c7fc9cde41be029cf6675befbafcbb2dab40b39b ("memblock: warn when freeing reserved memory before memory map is initialized")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 3b058d1aeeeff27a7289529c4944291613b364e9]

in testcase: ltp
version: 
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: dio-01



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603302154.b50adaf1-lkp@intel.com



kern  :warn  : [    0.609106] [      T0] ------------[ cut here ]------------
kern  :warn  : [    0.609305] [      T0] Cannot free reserved memory because of deferred initialization of the memory map
kern  :warn  : [    0.609310] [      T0] WARNING: mm/memblock.c:904 at __free_reserved_area+0x3e2/0x530, CPU#0: swapper/0/0
kern  :warn  : [    0.609778] [      T0] Modules linked in:
kern  :warn  : [    0.609933] [      T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G S                  7.0.0-rc4-00012-gc7fc9cde41be #1 PREEMPT(lazy)
kern  :warn  : [    0.610264] [      T0] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [    0.610428] [      T0] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
kern  :warn  : [    0.610686] [      T0] RIP: 0010:__free_reserved_area (mm/memblock.c:904 (discriminator 1))
kern  :warn  : [    0.610883] [      T0] Code: 48 c1 e0 09 49 81 e0 00 80 ff ff 4d 8d 2c 00 65 ff 0d 52 f1 51 05 74 29 49 39 dd 0f 82 e2 fd ff ff eb 83 48 8d 3d 8e 2b 53 04 <67> 48 0f b9 3a 45 31 e4 e9 6f ff ff ff e8 4c 71 4d ff e9 88 fd ff
All code
========
   0:	48 c1 e0 09          	shl    $0x9,%rax
   4:	49 81 e0 00 80 ff ff 	and    $0xffffffffffff8000,%r8
   b:	4d 8d 2c 00          	lea    (%r8,%rax,1),%r13
   f:	65 ff 0d 52 f1 51 05 	decl   %gs:0x551f152(%rip)        # 0x551f168
  16:	74 29                	je     0x41
  18:	49 39 dd             	cmp    %rbx,%r13
  1b:	0f 82 e2 fd ff ff    	jb     0xfffffffffffffe03
  21:	eb 83                	jmp    0xffffffffffffffa6
  23:	48 8d 3d 8e 2b 53 04 	lea    0x4532b8e(%rip),%rdi        # 0x4532bb8
  2a:*	67 48 0f b9 3a       	ud1    (%edx),%rdi		<-- trapping instruction
  2f:	45 31 e4             	xor    %r12d,%r12d
  32:	e9 6f ff ff ff       	jmp    0xffffffffffffffa6
  37:	e8 4c 71 4d ff       	call   0xffffffffff4d7188
  3c:	e9                   	.byte 0xe9
  3d:	88 fd                	mov    %bh,%ch
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	67 48 0f b9 3a       	ud1    (%edx),%rdi
   5:	45 31 e4             	xor    %r12d,%r12d
   8:	e9 6f ff ff ff       	jmp    0xffffffffffffff7c
   d:	e8 4c 71 4d ff       	call   0xffffffffff4d715e
  12:	e9                   	.byte 0xe9
  13:	88 fd                	mov    %bh,%ch
  15:	ff                   	.byte 0xff
kern  :warn  : [    0.611363] [      T0] RSP: 0000:ffffffff85207e30 EFLAGS: 00010286
kern  :warn  : [    0.611558] [      T0] RAX: 0000000297600001 RBX: 000000021e9ba000 RCX: 0000000080000001
kern  :warn  : [    0.611775] [      T0] RDX: 00000000000000cc RSI: 000000021e9c6000 RDI: ffffffff863afa80
kern  :warn  : [    0.612016] [      T0] RBP: ffffffff842300c0 R08: ffff88821e9c5fff R09: 0000000000000001
kern  :warn  : [    0.612256] [      T0] R10: ffffffff8742a600 R11: 8000000000000063 R12: dffffc0000000000
kern  :warn  : [    0.612494] [      T0] R13: 0000000000000000 R14: 0000000000000000 R15: 000000021fdf1000
kern  :warn  : [    0.612774] [      T0] FS:  0000000000000000(0000) GS:ffff888214e8c000(0000) knlGS:0000000000000000
kern  :warn  : [    0.613034] [      T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [    0.613231] [      T0] CR2: ffff88821f001000 CR3: 000000021c872001 CR4: 00000000001706f0
kern  :warn  : [    0.613471] [      T0] Call Trace:
kern  :warn  : [    0.613609] [      T0]  <TASK>
kern  :warn  : [    0.613811] [      T0]  ? __pfx_set_memory_rw (arch/x86/mm/pat/set_memory.c:2319)
kern  :warn  : [    0.613991] [      T0]  free_reserved_area (mm/memblock.c:958)
kern  :warn  : [    0.614165] [      T0]  alternative_instructions (arch/x86/kernel/alternative.c:2459)
kern  :warn  : [    0.614355] [      T0]  arch_cpu_finalize_init (arch/x86/include/asm/page_64.h:142 arch/x86/kernel/cpu/common.c:2616)
kern  :warn  : [    0.614538] [      T0]  start_kernel (init/main.c:1180)
kern  :warn  : [    0.614687] [      T0]  x86_64_start_reservations (arch/x86/kernel/head64.c:310)
kern  :warn  : [    0.614872] [      T0]  x86_64_start_kernel (??:?)
kern  :warn  : [    0.615048] [      T0]  common_startup_64 (arch/x86/kernel/head_64.S:419)
kern  :warn  : [    0.615225] [      T0]  </TASK>
kern  :warn  : [    0.615355] [      T0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260330/202603302154.b50adaf1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
