Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366D7CD4F4C
	for <ltp@archiver.kernel.org>; Sun,  8 Sep 2024 13:16:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA6313C05D1
	for <ltp@archiver.kernel.org>; Sun,  8 Sep 2024 15:16:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EA183C04BA
 for <ltp@lists.linux.it>; Sun,  8 Sep 2024 15:16:10 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 75A2C1A00895
 for <ltp@lists.linux.it>; Sun,  8 Sep 2024 15:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725801369; x=1757337369;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=9fDFggnOYc5OtF+rreFLr40tR6hjCeIQwQpaR+aHMQU=;
 b=XxaK7codkESmzbHWYgFv+08xavJ1jq+fU/FYG4ivpgoUjdCIg+EVyKE2
 +v1H1hhg/1yAL8Sh8PQnPyN+RiwPRC84IZ1o2+21ZNDlQIz0tD208UYFR
 gJbZvf8T0hYPg0rI0PONHMCpafxaEeCfgODizf0puwpMxf4R/84CwZ5bP
 fdlUXl45VKkJ5bq25FiLuDKNsxZS0bQfhYucmmO8/ieRD6fmK2MVNu+kt
 4ZD52t1iJMMjdTcG/w/BwYgyj4+utlX0bEV1RV0RTWV3OrwsvlcZJvOOq
 eEM4hcezi/tHb15scrTkqI4/08uP1cSUQCVtzrkmbPjuFMsvskV/Fx/ek A==;
X-CSE-ConnectionGUID: GHs6QzSfRw2nj+Z7jTaDEw==
X-CSE-MsgGUID: W6AQnIG5SQGev5aWPcidbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24648445"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; d="scan'208";a="24648445"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2024 06:16:04 -0700
X-CSE-ConnectionGUID: HZOUMy7tS/CtBEMs9NqaOQ==
X-CSE-MsgGUID: C94uFIEyTpSTehjuKCUBhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; d="scan'208";a="66944571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Sep 2024 06:16:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 06:16:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 06:16:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 06:16:02 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Sep 2024 06:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLSLA7lCF5RA3TnOZ9BFGe9fMz9B4/Q+BDvymBJxX4FvW6LkYLx5ugxBJDnMkRW8aE58pnpPgJpnk2gumz/+Ibkboxk3ScOYJuNDxEiIaz/fgftlwWgX4XJet4xrwfOj9JQRAT12DH12ovoaqskMrVErsdph2LqqOIM6eWxCU726rzCihpWgd7NgDBBei6LrC/zGeChYH04a/cuZUJPQ+xi1CDfeg75ga8gXmV8zJio5H6fkX4M0mx/bBhRdez1PPW/6FnWRT1vcdmCGSQhq6MMowKnpR5Ci2dMXQNCpiTo8AkwHLvgZUzMSThQ4xRDz8f4r16CC89LDUa7XxSDZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccIWp9JRHgEVCkumMEstNJw4GmGVZyozzkuwn4e0/fU=;
 b=UJQqjRDf5laNiR1qJE1dNchCZF+jmpV6gvt8WHCAN/056w135efmXA6wVuRU2FK+T/ZCd8wi6CoqIAaOhWfSI8dw5NYb9lt9ZFtoEQX5CTBq4I+CICixv0Fj0X3onwIVYvX/mS7lXlcjuVMEyN8GvJvLwHCHBitgVj5MigZyA7+hxlffQnixxAL5giWfZMkphUrDz3gmix3t2OgnQ4FZouSwbf7nNXY2Q/IjcEnZZPVhm/4EmfeKbqr2s9GObVDgSfswO9quxMAV4wzWD3trrp+LMiwBsJzqC39ue5t2n0y9osuBUpdBm742Wi7x0v2Oe+ZQwsK5Vq8nF2OhOonGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8477.namprd11.prod.outlook.com (2603:10b6:510:30d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sun, 8 Sep
 2024 13:15:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Sun, 8 Sep 2024
 13:15:59 +0000
Date: Sun, 8 Sep 2024 21:15:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Message-ID: <202409081536.d283a0fb-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 56890d63-334d-4cce-8447-08dcd008614a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b+UL228pSvlSriMOv8qo+xpOOKN38jKT+jT+/1gbCslVRVqpleUoAdylFVpl?=
 =?us-ascii?Q?mB/UhcdG1CTi9YluzbdzUi3UksqegIVmkw3pY63+AFmP2LtiInPX2PB0WaI5?=
 =?us-ascii?Q?5/RYAYL3pZgY5gXM9Sy+STbpSMmmklsjdqfxfYA5YsuKT9F8lcHUyJ6Hv5a4?=
 =?us-ascii?Q?WxFW5ADgzoCT2mqlwHCCN66BAetR3X6+ZDvv1LV/5BkB5cVRquAg0KtkgthT?=
 =?us-ascii?Q?29xfa2gLQIm3vM135CJp2hdZ2NN1FgtxE6K5X0PTnQRl+idfs5yqfY7gvnOp?=
 =?us-ascii?Q?FgGz/rc32GCvcZaM4oikbpeVinEfTI6zL8nHtJgviIkKltYKKfvVD8yHDDpH?=
 =?us-ascii?Q?xfuG/zWKVd+v4iNKhI+l51Yh069wL8eKDBDj4JsGjPc2N5RSQFvvGIO2x3Ff?=
 =?us-ascii?Q?oMDyLq3VAnuNWIOI6SUR6XmExuUHmY3iIe4OXs2V16YSDMrnz9ZdfG7mgl/S?=
 =?us-ascii?Q?8sJr/1drXOO1+LVC0T6Qoy1S67D0hk+5qmUHmYgihuckoaR7/zcU/ahGiONS?=
 =?us-ascii?Q?1ccRq5aSPryMlEts/iSXx4Houdkfp3GLhkkI8tvxdUc07mZqJwnQv6Su8d5g?=
 =?us-ascii?Q?W4G4ijGOW1bO87C6cqabAygJ5qtg5LnKEPDUjOXyxLpn76pVBBHUwTARdXcx?=
 =?us-ascii?Q?AKYL0WXUudSq8uj2Dox22NcH4JhTPEzF4HTrxcaJVKT5lyZGhth1ICkws8dg?=
 =?us-ascii?Q?UJFR7EhPvz8ahngXoDSVUsjjXZE9i9x03LFIhmNL4vNsmhdp1H5l6IXIZBit?=
 =?us-ascii?Q?qlaCb+EgGQ7M+y5utTBRc4+TkI4oNdpklrM6IzU91PM95IS+jYqkPrbhGzYZ?=
 =?us-ascii?Q?8ZMs7GXyoPIw8hVMBwho+5Zx3XzRFyy++jVaYFEs5w8IaUu/BavJJmiKm3lR?=
 =?us-ascii?Q?gJCR4//0Ktrcd9w5Q9jyPdk9LLaQ1CrgR4fYv1Ln6wYrpQrS3vkbrr1bXili?=
 =?us-ascii?Q?npJojxz3sxbieieWSEOYe3CV8GgYJwMcgUbq3Rg+KC5V9vJjXhg6eupxY6IE?=
 =?us-ascii?Q?zYk7I9xhsDQeA8/kgwM+V6v3ejbNsnpuLerzhZULeYbvjuzSzSglfi5W/460?=
 =?us-ascii?Q?5xkCncn5pWmNOSoQESBiAHMOyFS3+kH6iqX32duqTaZA/GVKgGg0E/xR0w8w?=
 =?us-ascii?Q?Z1hTiWYBYdRb2PbZO0pR7mJvgNBeHLUduX068MMCPTWA2wT4ZFVi7ZjtIDne?=
 =?us-ascii?Q?40f9pyMnQ0EdXz5BaVz8nH5hn+AHLANnvJPy1H3ecINsZVC2AbSLpn/1rQZg?=
 =?us-ascii?Q?SPShNl++nG702+CRvXem5ESw8wiM9WToD/UziHmGDnM/BfEacCVbONFdXiT6?=
 =?us-ascii?Q?2mFirdYsNVWkyhelzbOq7iu0Q3X+c8eLbL4o4NVOzsJLV53XPpbHivNz8prC?=
 =?us-ascii?Q?K/+Nt4I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8sdzht2YX9aqN4pzaEFRrXv77jxrOpikcK2hUJa9MUfPjPkFL6qo5XynzfA?=
 =?us-ascii?Q?WNuUN0Ix7F20iXoYvWHhiqmtfHxg0KYB5ekBv3WAzsY4SWCbLX121y6lZb+d?=
 =?us-ascii?Q?/6KXAN2njPJPb25QQ1mcY6HU6p2IKZOn+BzckpCs8fwgKMdZI9qU34pAk9KV?=
 =?us-ascii?Q?HylxgUXlpmc/fu8qKpEIcVNm4ABGd718tspqDvBQ0HcnddbB7rNi21AlTBYE?=
 =?us-ascii?Q?9ICOQdwNqBqMcgALd8QI2qAcyB7cyri3ZiHf4E8l89JFiFPMRk0MZpVYnPIO?=
 =?us-ascii?Q?Ieok12lIKjkf6F77fhLRLgJ6pr2qFM6c4fuhaP31tCxbDVqNoMPtoIh5j65/?=
 =?us-ascii?Q?wEpNDv8J6UXxCx/JwE3FenFM9d580xKQWv0T9R10f32drlkyFKsFP41rR8b4?=
 =?us-ascii?Q?oMdJV6A0jIlDb6aKq5VNvY/nZYoiLOU3s6dogIS3uUCL6Lwh9vADtJmx13ZJ?=
 =?us-ascii?Q?4jyxoDwuvbcJq/66Rc9+q9sASQ9Uvpcq1jTeEvpiVy+p/SDlQ6WrV42MqHgW?=
 =?us-ascii?Q?2UB67igjK/dsWL6BbD3FAcSnF2IyCvnqEbdE0sFFPNlAYhas/G2yBcQmNwDu?=
 =?us-ascii?Q?UTvhACQYFdjJydC7miL0Sqiy0ZskF7QU/DrvIyUI38zp6c4iP1VXaLZUUNSK?=
 =?us-ascii?Q?iKBj3INK80s6yUsgAxYNyHQufSLjqgWrK++cntbK6zZY9JUA4YN/pjsxyV+f?=
 =?us-ascii?Q?DIqXj0sbL76uP0GMvxJLlNyBPRoACk0SnkeHPjlRQXODxtJap7ujDK4LYZoo?=
 =?us-ascii?Q?ZQc9iUAmlohyQeLjMwj5QX9/o4FThIjGJhjkrE7FP1JLJis++joIlcewTiPx?=
 =?us-ascii?Q?MucV/QbJx7PNtf7DgwTqOEUcRdAzX70wQUqdP75BI/G2tyTiXUYBhF8V+vHK?=
 =?us-ascii?Q?+6nX8VKl0iC85/+FvSVV3iwxIj8UFgkg9Hf57w+V1UwCj/TFN1O+b/5CF41e?=
 =?us-ascii?Q?zeaAg/9epTZ3Rj37H6KIInO5OolrpOzhv8WGFCsV0N/sT5RQKMK3GDtExyUh?=
 =?us-ascii?Q?sIvDaTgeo9xmz06j6IRYPtUCQxoduiZlJed1jC/C/fvmG2Ua3CnmdGnF4AAM?=
 =?us-ascii?Q?BcFwXtyfOMTltNdMZzF7pAjme16XOUIDx9xC3Kk0TDk8mNkbR3OSjTyp6rmu?=
 =?us-ascii?Q?otWwaeHpLhUXcc4IlAlN2Eruk+9N8b3URt2MuLS+6SR5GxNm1WYQSsLq1HiC?=
 =?us-ascii?Q?wVCAEql3O4uFJZTd7Oh8oSjbBvwvnYpbEKhn2pv7Ii67DqxuvC02iYT4Cp+N?=
 =?us-ascii?Q?5bhNJUM9upQTMNL3qLqYxrumRZbx2jz7ZXT9Lu1IA9NwU+2y9GaIf+3aBsDx?=
 =?us-ascii?Q?MuIFdBZkAMwHqWXxbcJKL6iWLFau74SGMtgwftG3uBLGHuta7aFCVAUOquju?=
 =?us-ascii?Q?peQq9j/fu9MWIvuoDc1eAh//ygVsh/SFjMPOhASQmZUBNdOJEaUlzOAn56hg?=
 =?us-ascii?Q?3JCUGcTtfhxmY4lW/sLU0TxEGxF8NTh/0EkkmtSwrmONn1Xhi6UDlYISDUH6?=
 =?us-ascii?Q?s+UkSnXve4rGPWSok/KBZv2V/MEIQF6+YwvP33kANpMLK6XT5CNbZZHf9jNJ?=
 =?us-ascii?Q?dVoPH2pXep5H8Ltv8MgEAxoVs7X6GVyB48Tbfydfus+Cbu+MhsO/M+b0GIfl?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56890d63-334d-4cce-8447-08dcd008614a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 13:15:59.0981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FDmqa07silwvu94dRjfUm+EHxWqNl4vTMgKXCmYAeFKZfJpn2HeAHwtznGyREO5EW2ZdF0xSOwUpH612+dH1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8477
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [mm/vma] 6898c9039b:
 ltp.memfd_create03.fail
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
Cc: Matthew Wilcox <willy@infradead.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, lkp@intel.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Kees Cook <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 ltp@lists.linux.it, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Mark Brown <broonie@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Bert Karwatzki <spasswolf@web.de>, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, Andrew Morton <akpm@linux-foundation.org>,
 Jiri Olsa <olsajiri@gmail.com>, Sidhartha
 Kumar <sidhartha.kumar@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lstoakes@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.memfd_create03.fail" on:

commit: 6898c9039bc8e3027ae0fcd0f05fc2b82ccc8be0 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 9aaeb87ce1e966169a57f53a02ba05b30880ffb8]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240831
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-03/memfd_create03



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=memfd_create03 stime=1725647495
cmdline="memfd_create03"
contacts=""
analysis=exit
<<<test_output>>>
tst_hugepage.c:84: TINFO: 1 hugepage(s) reserved
tst_test.c:1809: TINFO: LTP version: 20240524-209-g9a6f3896f
tst_test.c:1813: TINFO: Tested kernel: 6.11.0-rc6-00249-g6898c9039bc8 #1 SMP PREEMPT_DYNAMIC Thu Sep  5 20:53:00 CST 2024 x86_64
tst_test.c:1652: TINFO: Timeout per run is 0h 02m 30s
memfd_create03.c:171: TINFO: --TESTING WRITE CALL IN HUGEPAGES--
memfd_create03.c:176: TINFO: memfd_create() succeeded
memfd_create03.c:70: TPASS: write(4, "LTP", 3) failed as expected

memfd_create03.c:171: TINFO: --TESTING PAGE SIZE OF CREATED FILE--
memfd_create03.c:176: TINFO: memfd_create() succeeded
memfd_create03.c:43: TINFO: mmap((nil), 2097152, 2, 2, 4, 0) succeeded
memfd_create03.c:96: TFAIL: munmap(0x7f9b26c00000, 512kB) failed unexpectedly: ENOMEM (12)
memfd_create03.c:171: TINFO: --TESTING HUGEPAGE ALLOCATION LIMIT--
memfd_create03.c:176: TINFO: memfd_create() succeeded
memfd_create03.c:39: TBROK: mmap((nil),0,PROT_WRITE(2),2,4,0) failed: EINVAL (22)

Summary:
passed   1
failed   1
broken   1
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=2 termination_type=exited termination_id=3 corefile=no
cutime=0 cstime=187
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-209-g9a6f3896f

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-209-g9a6f3896f
       ###############################################################

-------------------------------------------
INFO: runltp script is deprecated, try kirk
https://github.com/linux-test-project/kirk
-------------------------------------------



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240908/202409081536.d283a0fb-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
