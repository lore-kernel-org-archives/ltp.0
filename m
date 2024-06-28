Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5140CC30659
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 05:44:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC39C3D435E
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 07:44:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7088D3CD7AD
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 07:43:49 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC6296022B2
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 07:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719553428; x=1751089428;
 h=date:from:to:cc:subject:message-id:in-reply-to: mime-version;
 bh=q3+eW8ZpS51aCoA5ujzraynzqyqjYDEOZJTGfux93R0=;
 b=BzwGkJxTlgx4xhvqiwORhR9mVCItDKsZT7ce6hhk62medDuiuqkIuGEY
 NXpqCgtsPVPp0c8DQKhaTmCtEPIAX6S53DnwerAxMcHr7ZXUeEojHVQ9E
 T4ElUx7rvfJUjhMniEm8vMNQJIhdPs83I0iluR40tzPaLXarxUPw4agpt
 qHcBs06ptG+CQnnxYJtZUPfO2CmdNqO6Q3IHvmLU/4HhB8ZytJ6q+65mD
 dsu20b5OIsHJUJ21gUYNiO0YSwfJe3nS4t/OcgmlXr0W3LIcjUtFGsasA
 0kyxw4RLcMA3MW7IvmfQwq42qRI6Qw8GLjmmZ2ZTDRvg4WHmahkxXX3aZ Q==;
X-CSE-ConnectionGUID: nw8/XmP4TxahsQyY++OEGA==
X-CSE-MsgGUID: 1pZ6eQxFT42+B4JWQ9pgXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20537225"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="20537225"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 22:43:44 -0700
X-CSE-ConnectionGUID: DBV5tHqMSjGyu/361legZg==
X-CSE-MsgGUID: g2rmGb77QIGonqjUj9c9Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="44466194"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Jun 2024 22:43:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 22:43:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 22:43:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 22:43:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 22:43:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjJ0sdRQqTW40aOJVypSrQNbnyUMSeDlbLnlx/RfZPGNuEp3FTniwfxbFl7qRvNdq4qAZgq+zd4ykR2ZcpVfSACVOBvPdjzlAZyTQS21JehLVEgzLLnYx4Nks/FuNRKkhaEfWcoUVVSzr2za66dnUmdCTttncd+unyg7lzD1Z0LN27Ysk9mGdA1lI1q+YwpbI8YVnEz7m5Q0m5pI513OEgttTJ5ouWzyRoX30k+q7SUGabIT4TmH1ncOjjSGydbXRImtHvsE9+rkEruwJQiBJLRJ5VlU9WXgE8TZzD5HbVce2peI1I/msf2VTHv3aaOth9JFRn1JjpwLyumq1lP7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BPON241UZr+SOVTSOZZSU8YcYqVky6iygP8RkzYH6k=;
 b=JEWzNkuxCAwcklxjNTWQ9te5fq3yiQqfoPBNglx3X6XbW8cDzi1qEyJUHWx7DLkNykOVkc1oF6UPgOsJiie8WYcCBaJ5+QyLn1uYWmMRkJ7QC5J/7qCGNBcGodXUJLG6U+Rbg+NqGLAJM+fyeZJgLv1wNbke5Ys0icqE/bFe+TMzOfYOKnvTvBbPr+d904YjF+idNgo1VMxoUf4iOQLDexVAmG5jcTiVz9Re49PNF5AwKecm8lM5Kwo5gOxw9gJ6r7eP9wIrGtEDeoTzlSsAErY2UkyLMRlZMJFsucZuUPhPZxPv74QlZnZa7am9ZgxckQYZa3ySNTl8OIrEYuVoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 05:43:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 05:43:40 +0000
Date: Fri, 28 Jun 2024 13:43:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <202406281321.6026952-oliver.sang@intel.com>
Content-Disposition: inline
In-Reply-To: <87iky5fu6y.fsf_-_@email.froward.int.ebiederm.org>
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b443c8-b51b-4c76-04b9-08dc97354370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nlAc7KCJyurSRY6cinnu5TPbKp4WzKUP/WETQiZ/92VH7F8MxOH6GF7cEge6?=
 =?us-ascii?Q?FaIAFUHk0SnwRhARJX6grVmf6SfAdlowQHtCkH0AyqYAJLYnFCe4/t5PhrnC?=
 =?us-ascii?Q?kv3i+vU5D4N5VH/5ocWv5IIYnl+kWHUf7Yh4tPrzbhr0gLdLAAbyWeQ1WV4N?=
 =?us-ascii?Q?aTHybq6g5d5i+tkB4JYDnDbqqOWIYJcnwaiFZc/dnWH06Thbn+A+Bwq4V6eJ?=
 =?us-ascii?Q?rUFHiLikVnxYFnv4/7RX/EqjknD3r3mt0n7+qxPQHJ0EqPpUj5FesGULjf09?=
 =?us-ascii?Q?l67jWl7u3cNm208+iNqB4BTxsFPDEaWparqaLHwvjWQoqy3+uYIgq3R8bMu0?=
 =?us-ascii?Q?ndV4o+dWQrs4YJvw/hx707OsmsKCLWZ99ycMJ0MPRFVduXm2Qei4JU5kZv+u?=
 =?us-ascii?Q?qgzvDCpnlAEW3+c9syK0rvktkbnm+JRnQxlWR4Albi6GAZjei57PJvE0qrDA?=
 =?us-ascii?Q?9stvJXEq+TfBjsFJ2cDT4mLeAWb+r+40izh/f4S+7BiEL96U6P8wAHvN4Nhz?=
 =?us-ascii?Q?eufb+zejyINzlS9JSxuofHeN2nYV+edkjojKCnepKl6yQHWyQBRPFBd8f3AB?=
 =?us-ascii?Q?ihBFaQhoiqFGsxBnCIGtOSpGVIAzIC2df3ym+/F034It+Fr8/jVxSQW/KW85?=
 =?us-ascii?Q?PhTBHCL8I1IH8JI/fCAjxIDbaAhKuhq1bS0BSCeAzxQTLmFe4mPMZvPqEbcN?=
 =?us-ascii?Q?mKNI8/8Ny0+rjxGfMaWKgdZKVp5zEIWz9Os8+XJJLOcbcLGHDz/6Jfxc5YPZ?=
 =?us-ascii?Q?1yZcPpYr60TrJv1ErcyEXBeHMO6hCTUKKZutdJSlp57cBJkxBnnjOctcT5Az?=
 =?us-ascii?Q?Mrg7AZzY63yX7BZkgOoDsQegP4no8RYsJD6Q5Hs7GCEcPtDNk9MCL5eeLNxQ?=
 =?us-ascii?Q?9/qd4NnJVAxZYVKE8qH0Xtn12ShgkGMeY1r6eq2eeGo4qI0c5GLN0nZluo6Q?=
 =?us-ascii?Q?7iDWYHDCC5licUBKo8Pjome7AXFLN24cXSiIFUdbaXwY/m2xMOvow0hKQNCn?=
 =?us-ascii?Q?fclaHixOjVfCW2K8SiI83aPogPuediSqhj3333j2mtOy+cW5c04GjIDoVmqV?=
 =?us-ascii?Q?MtusHyyUZ7IGoz758HSrLS5tNYeIBOaVQiC6Ex6qsExh2trN670RtWoVF13U?=
 =?us-ascii?Q?AGWMFgs946x1X6JO4aXAJ7a5cPf4d1kvO8KW2MiIyXdh73fVLHNKvUg/HjOA?=
 =?us-ascii?Q?omfUm5HiVBcy/UlG164JRgnYG8wsqudlvI9XwVpekrCmQTAA5S7ejSwW82wA?=
 =?us-ascii?Q?StSNadgycDVx/shaK6zU5vqa/F8zcj627f4GELODQxMFb9Hy3DD6ZOQbvEW7?=
 =?us-ascii?Q?0iE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fHFMYmzQKl4kboqxoyM1maUgDUHgtIBe6FMqp0/sIZwNqSYHIt6L1+aL8SyT?=
 =?us-ascii?Q?i4r/Lycm00r+6ES3Ip6z1D39gxTqRpYzZESACDWBOunDlz3KO3P8ucQ2qju5?=
 =?us-ascii?Q?/Sgw29LUMcfuYSK5MS14E0GgM0jFYe9cm6FurV0Bi7Zwek4tC5jiuE57wU+w?=
 =?us-ascii?Q?xt2S53Fo5kxqiBgzHCQ4CFUlBBhXtiyxSOlM/RZDnAijqO1Dz6HYqFcaL3sx?=
 =?us-ascii?Q?WZvNDijlBWBHs/6SxthW8Ez03c/r4QHItBSmbZyF8NA6slQanACY9OpnLv00?=
 =?us-ascii?Q?Vno5usP1IugrQW0CYHX4W5a6aA2h77KNEN6WFUSCy+yaRVyWf0CR2HvcWKXB?=
 =?us-ascii?Q?WLaebF3wJFhazDE0q5/tyXA5XQTSL/ZCmdOLnScqbcbxG/Kx0j9ckMYDl8xl?=
 =?us-ascii?Q?dBWyPAKXgz81Evf7wQo0TqYoyDx9E3NKeDCK11cnvzb++1kplSt1rwAiw0Fv?=
 =?us-ascii?Q?EyNN7J3bvZocNbHGsgVC0zmwe9v+4A8omWzSjEedrGeQClCKY/kj5lNb5Brz?=
 =?us-ascii?Q?jQRgfWqiTW0UqC5Rp9jEi80AETJMRZm7A0QXn6bDuKWK8DwKlIHp9HTD5Lxb?=
 =?us-ascii?Q?HdoHhB2ezZBhuVxmOr/Dbh9Ht2yFGsYAWcMvDxF9g8R7ZXVQ4JAiLVn0rK6e?=
 =?us-ascii?Q?/4w8HPukOAFZkunMmDkRwcKsihkcoaFUyx6rfc7tETRjfZFX1QDRJjPfMCWt?=
 =?us-ascii?Q?IuHEjQzt7S/v4hftwIGrgePwO6vMgkAlHeYm2Tpf2/Y0AzTTkGokgEm/iSaL?=
 =?us-ascii?Q?9rUgu3/cHINXEz1izQ0BvYe+BgNz69jF11C+/EuWUPHZoccbS6ICY90UUkLM?=
 =?us-ascii?Q?AFd/A5n4UovxkZe0rECc/jpu4GK+KDB5AfDPvnsl2QYOS6VDt9I/xCWBv1UU?=
 =?us-ascii?Q?YKpV4n+agp5leKvSkyu+TK211s5Xvy7iRTNYEspgS/8zySYDuUyhT6tsEAJl?=
 =?us-ascii?Q?7Vjg/M22fzGNKhXkgMbHpMMqrGSr4+IKQIqGGFzbJ56PHQ1u1jpRiYxnm1TN?=
 =?us-ascii?Q?L/fH0E59Mabz7SojtceHzGB3d8ogjkNrqn97JKhn+F0PD5vXuHmLO0f6mvev?=
 =?us-ascii?Q?DuoxOlOQTwJKOo8Ud7ck5eoFA5nQXWM+YJdZqonfgl7dytsZy+ANdvhdnXKx?=
 =?us-ascii?Q?ulyveWspz5hJVGVkNtiBnjxPUw8rg9S4FiJbWYUvrKDgxohbQ/6zDSdXSgAq?=
 =?us-ascii?Q?L/GJ4VH7vvDX7Xnrm8XFck5a9ULk/P+Kz6w7j79OBORdm9/xYms25ZtPTtdb?=
 =?us-ascii?Q?S71Fnyzj/hJzEpXW/vXlNHv4diCu9RWwS/OsHv8c8BioYl+gS6FvFHwbulrx?=
 =?us-ascii?Q?xLV2lMb4ALvNURV3QeBpBZhlmRpj7wy/y2iAPIVeJ/offYTNgcBuxpxmlBCc?=
 =?us-ascii?Q?dR8iFcwN/bIvWEQYf1RjOYty7x7zN2FDtabyJ6BFSxfhRALXd7rLQLDTSw5o?=
 =?us-ascii?Q?DksILf2X52Xyy834sOHl6W9jlVvxktUaHkbr/hgD/KYa/pTt8BvzR7g6OuP0?=
 =?us-ascii?Q?1M6FW1/ynWI58O0FSlrYDao7IlI84sAoL/vUI5LphpMNw4JiXLzpM9UoNGq2?=
 =?us-ascii?Q?0HlD5D4n/l73/qPavp81s3sBtT6ArkmO68IahBe3AX5aZQps/KomWg0obmRA?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b443c8-b51b-4c76-04b9-08dc97354370
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 05:43:40.4855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIGVlJzmvCtNSZxBp6BVPeiN0J6UylXBOZztaKnT5k0XegUWxEoSScnN03bxY5GwIMISyZcHT43hjDavf1/N6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6805
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 13/17] signal: Stop skipping current in
 do_group_exit & get_signal
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
Cc: lkp@intel.com, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, oliver.sang@intel.com,
 oe-lkp@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.acct02.fail" on:

commit: 6d882a729c098fb5c94db8e203a9498b79e846ca ("[PATCH 13/17] signal: Stop skipping current in do_group_exit & get_signal")
url: https://github.com/intel-lab-lkp/linux/commits/Eric-W-Biederman/signal-Make-SIGKILL-during-coredumps-an-explicit-special-case/20240619-121513
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git c793a62823d1ce8f70d9cfc7803e3ea436277cda
patch link: https://lore.kernel.org/all/87iky5fu6y.fsf_-_@email.froward.int.ebiederm.org/
patch subject: [PATCH 13/17] signal: Stop skipping current in do_group_exit & get_signal

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240615
with following parameters:

	disk: 1HDD
	fs: ext4
	test: syscalls-06/acct02



compiler: gcc-13
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406281321.6026952-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=acct02 stime=1719055971
cmdline="acct02"
contacts=""
analysis=exit
<<<test_output>>>
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1734: TINFO: LTP version: 20240524-41-g248223546
tst_test.c:1618: TINFO: Timeout per run is 0h 02m 30s
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
acct02.c:240: TINFO: Verifying using 'struct acct_v3'
acct02.c:193: TINFO: == entry 1 ==
acct02.c:84: TINFO: ac_comm != 'acct02_helper' ('acct02')
acct02.c:133: TINFO: ac_exitcode != 32768 (0)
acct02.c:141: TINFO: ac_ppid != 3859 (3856)
acct02.c:183: TFAIL: end of file reached

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=3
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-41-g248223546

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-41-g248223546
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240628/202406281321.6026952-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
