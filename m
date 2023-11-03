Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE28C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 08:15:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8188A3CC81C
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 09:15:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 900143CC7D9
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 09:15:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E7D220118B
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 09:15:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698999314; x=1730535314;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=vIxgmUi+4wmNF+rS5xDfrqjQW94RRh8lO5nxQeQ8RPc=;
 b=Vm2ZWDfD6OC08aZ+U91ziq+gFiahchPjzPIqekH4aDYVNvDDunQwYJnf
 XZqGF5alMylkYkQBaMv7bhAFseCT4d32vpds6OYxnwGaBjah4n9rbOJyR
 yIaLEjL+N4RlFDy5BgeC22itKEi8P/jcxDORHWYNBlfb0pWYeH6+KSJyL
 1lPDB774k4t5A10QLehyyGJnNue2ZUW5RsaYW4driXPGsXFJvnQkKxyK6
 TrzJ14ZZL5P8usVdI8WSG0TTchn0yy0V/6OH3ZDdE000iuzGHPKXGNAcN
 SyHA2JZCC+CS+CfZKK249r7GRE1xJDOxwg8pV1mEBqiYrLJPXJWYi2RYo Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1835957"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="1835957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2023 01:15:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711437569"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; d="scan'208";a="711437569"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2023 01:15:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 01:15:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 01:15:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 01:15:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 01:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqkVZYJP0WQlxpeOUmplfSTCLjpH9l7jeS4qw7xcLX4PD9D/VBUMWFvLrZbkMGa6x28GkK6G7YZJm++Jsmf3YhNiJFiyJTqUX7OTfclOQrOYp7cx9ANdLNl9nZoApgEYx0dL1KsM0k1pRwAVPNKinLL58xVuE98qH2WmwnQTYX3id59v5ZDVTLX7NBicdU9SBDBQ5KYuWX6IYfP5Dfnvio9MqEzmSTvbs7D0qCn/XtvDBBrO7jOQzdBg5Rm8IsqUiAFtfRG/jIIE8YLmpbVngxwazbnyimRub0RHj1KSM/G8QnLlHAbGrFBn50rTRP6eZBnbvub81VsBJ9SA3tqooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTAQF+r+jWPmKVzU/D+NtTeYgXS5ViqgWJakwPKCy4A=;
 b=FDlJLPUVnQemLMebSo1NS1Xsn4R59oHEQr+WDatraduOtMyFpYoUkQvfemZ5bX4g6Ck5aqNPsjnild8bUsa3Yi5H6CR5O5CvFKmnnI3uMvC+OLPvi+TOXd5Gpleaj9MFrq125pTMdSw4ZqbZLD3ym8bM94xyiBct3Lw9MhUZfjP1qUkjjNSHeFvRP/4LWuKxAcJX1m7rRJHBPVOfyFCuBAyU9Tgrf+ULUmYNMLrycE6Dh/A6wqxC8mGDjrxUABycQlM6A8yXwd/P7yVHfxwAV6Pqn+dVt8BhRGq8j/4e/UktJIaUMJc0tLrPdh20+2b5nCNJrQWv/Un85aH6c2rU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 08:15:01 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 08:15:01 +0000
Date: Fri, 3 Nov 2023 16:14:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Stefan Roesch <shr@devkernel.io>
Message-ID: <202311031548.66780ff5-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: cda5c34e-9cc4-4292-6b66-08dbdc44f98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+ifsNs7rgLLXV7VuvRabAOu4C/aaw5MRQgGDlVhNZfbKYc2gXcYPePIjF0PvCRtDwOiuM7iUUEbdCcARHbCF3UpWIzv3cXur208sEGl6DKNUUzQktn3edwmb1arHmpM+PcSeLs5ZlnW3UFrpI9K9RNZ2IFmZxYi7y14zmkgERBl+mbXziK77FNhq9kpR/jbUrN4ALsanB8SdsLrPZSf8FSvIYnx1dV25rOwdUfnhdpa8f5QPHaRekkwaKWVN+pWixSRY9LzGLvlge6EIIdpXHneZtkzBTEN/cumxy4nlhv2vmahbbeSPfCqOZksnDXUwm7zgkTYo/1L6Qj8n3TEg6pAaElghmuUBc0tFuDPLiJ+TMP7Y8Ir9KID+KOPFSHWJqT+IztO+YCFnebnX/LJ6UdHXMZ1cJj4VHG2QcCqVAt8sybw55kiY0AKn/LUIwPonhtTDMPg1rTysvdlmpFJiR0wc0Tq5XQNoZqWKAGYl07fVG8ogYh17BXfNjGCeS3VpVThiBHUSZDodYFr0fGNJO4zOYUqLnwDBIXQ+tRkNKZK001nVbSGews74GoObpJOft36/AJRGVW+OurC+sM/m72NX7YgZ9AbXC3iSS+i6QXnuhe4/mVZIt1MJEZkf5ExMN6mpztVOraKbmfNt8geRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6779.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799009)(64100799003)(186009)(1076003)(2616005)(26005)(4326008)(6512007)(38100700002)(82960400001)(36756003)(86362001)(2906002)(83380400001)(5660300002)(6506007)(478600001)(107886003)(66946007)(6666004)(6916009)(8676002)(8936002)(316002)(6486002)(54906003)(66476007)(41300700001)(66556008)(966005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRwAiiG7mPkC1hH0sIWaVQH9sgkZfja5d/DZIjCWL69cdmeK3SwGeKAj5wBR?=
 =?us-ascii?Q?yfr0ujweFijdmWk4bfkV+3alZnb9hcJhpy0Yx4ylgKIhHb3pr06rsB4mEZFx?=
 =?us-ascii?Q?watmDlp3oPr5A86JyW1yyE5ZAD/JoaKeW6sG+6AeG/tupmgX/VyGK6LlqQu+?=
 =?us-ascii?Q?lh4zETIwsqQXbNlkQP2tpwPKsxIstDBsh5Qts6/rNXSEPKuUruRpfzPBmSuR?=
 =?us-ascii?Q?jm2ldoXvsHfGydCABKqWml31m76uSjUJXJpCbDY9WaauXPewEe2MNPBisx4N?=
 =?us-ascii?Q?r1cEuCMViDDavxA0UAQ2qCc6ap+e1ySNRQ5ivsaQ/T1ceCJWo2BXwK0X8A4E?=
 =?us-ascii?Q?h03Ovo5Sc/fqvLrUZZp9r5APpBLi2DlZDyyrZ3ycQjTWjizoxMALU+pAomXo?=
 =?us-ascii?Q?IG9nbI7ceoLObl290a+QUxUrsSdvkw7oaU5P3ZudT3ecI/TqVa6AORsSwERa?=
 =?us-ascii?Q?oEh2yGRcOutFI87TdEZZjzk2jrr38+0C6CtdaEunv2Ka7e4TVIhOv6zXeE80?=
 =?us-ascii?Q?45M0aaV+OvzVhcfDTtRjbT+qK0F1n9Exqnq11SgrA+8FUVQxM4pOcKsxzcKK?=
 =?us-ascii?Q?TNknuiVGVW3a9+o2PSQLPzG/LEdU4/fKL8pC2nBVVvMqXjYXxcSXT65+WMam?=
 =?us-ascii?Q?LyJ73DGoTaKgPB/H82xs3pP1/JAlswyoHQ66rpXa7lfAuBEz3LFEH3JBmY8N?=
 =?us-ascii?Q?UmYaNSt9SaB3aWq4FzLf3oGYfsZNsMlboY6IhX+MoUe2MH/bTX+sUCn1awO1?=
 =?us-ascii?Q?DNif7t/m1rrxrKaUs87g0I/0lsSDn5C8YSvLbM4ufFbx9XD3GV9toHwYPA+M?=
 =?us-ascii?Q?4hH+BgDbtnHWadVCQFESadS5IvA0PTSnFkf4t7M5qvnx5dYvipjJkg8L2J44?=
 =?us-ascii?Q?3eHPFSb6xIzuO+kSK1aLwBXVGyfBeWh3FM0J74MAjD3ZJtz9sElqoBRMQL/Z?=
 =?us-ascii?Q?loqS3P2GKGZok3bcUJ9wkxTAWDFtpPZ7smJHfSFrCp2HIveULgkjWRhXJdc4?=
 =?us-ascii?Q?fp7UTZ4EZPq9r3Ujj2Og0fkazjLhRziurabvSUWv4+IVMin+5eocgkOKxFwy?=
 =?us-ascii?Q?VccQsqSrzSb8wTKj9hn85bgd7o7qLMaLYlGIn8tDKLYhcZQde4fg8tVMh8sF?=
 =?us-ascii?Q?IpAUtLmkNVbsprA6Kb402CR8h3yG6alY3sT9+0N9Y/7bVwLrmUZVNrikMkV1?=
 =?us-ascii?Q?lDjfCuC9y9w4SsOyVo1wIjk0dfzufhhKE2JZfibQdMWK+TqqGoyOj1g19rRu?=
 =?us-ascii?Q?P5ZMw2n9H4qBDCebDwIrKEtusUFlVkhm/rM5+P8YiQ9xG4aAQV8h6zUBqcAc?=
 =?us-ascii?Q?0zkr4p5F7Z/RmSdOnOJjymnFUlGynBvvn9QVJHoZ7es6UBm2NN3gWXFTspbG?=
 =?us-ascii?Q?C+Ez1Qg4zpjX6EX8hpf3JLa0TeYqPQMAWsk0/nkQaXmucaARiv7tYJhuvseS?=
 =?us-ascii?Q?FTleiFRRHltTfnnQZ43yct4qfrIjA7ys2OrcY/9I1s6p4D03p1vo9W4UuCOq?=
 =?us-ascii?Q?zPbLQR0ti3ex72e94O/Cf5yiMYQFmpAENDH1w46iPcJ6taz3mJKjTqgAJ0uE?=
 =?us-ascii?Q?r94xK4gDm92+EjxY51cz8vpJRUH+AGyHH5zynkzPXCTKdwh8EQh5LekP3cRp?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cda5c34e-9cc4-4292-6b66-08dbdc44f98b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 08:15:01.1996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3K1VUnZRlcCOnL5QoCCBr5bI8wkX3nirFNRwNB7GgYEYCmdex7vTjuFDeyaxhyu3PmTxWfFohOwroLPduqBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [mm/ksm]  5e924ff54d: ltp.ksm01_1.fail
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
Cc: lkp@intel.com, David Hildenbrand <david@redhat.com>, Rik
 van Riel <riel@surriel.com>, Linux Memory Management List <linux-mm@kvack.org>,
 oliver.sang@intel.com, Johannes Weiner <hannes@cmpxchg.org>,
 oe-lkp@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.ksm01_1.fail" on:

commit: 5e924ff54d088828794d9f1a4d5bf17808f7270e ("mm/ksm: add "smart" page scanning mode")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master ab57716449b3438c0136f6f412a2e59e0cf037a9]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	test: mm-00/ksm01_1



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311031548.66780ff5-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=ksm01_1 stime=1698967074
cmdline="ksm01 -u 128"
contacts=""
analysis=exit
<<<test_output>>>
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
mem.c:388: TINFO: child 0 stops.
mem.c:388: TINFO: child 1 stops.
mem.c:422: TINFO: wait for all children to stop.
mem.c:388: TINFO: child 2 stops.
mem.c:495: TINFO: KSM merging...
mem.c:434: TINFO: resume all children.
mem.c:422: TINFO: wait for all children to stop.
mem.c:344: TINFO: child 0 continues...
mem.c:347: TINFO: child 0 allocates 128 MB filled with 'c'
mem.c:344: TINFO: child 1 continues...
mem.c:347: TINFO: child 1 allocates 128 MB filled with 'a'
mem.c:344: TINFO: child 2 continues...
mem.c:347: TINFO: child 2 allocates 128 MB filled with 'a'
mem.c:400: TINFO: child 2 stops.
mem.c:400: TINFO: child 0 stops.
mem.c:400: TINFO: child 1 stops.
ksm_helper.c:36: TINFO: ksm daemon takes 2s to run two full scans
mem.c:264: TINFO: check!
mem.c:255: TPASS: run is 1.
mem.c:255: TPASS: pages_shared is 2.

....

mem.c:255: TPASS: pages_shared is 1.
mem.c:255: TPASS: pages_sharing is 98302.
mem.c:252: TFAIL: pages_volatile is not 0 but 1.     <-----
mem.c:252: TFAIL: pages_unshared is not 1 but 0.     <-----
mem.c:255: TPASS: sleep_millisecs is 0.
mem.c:255: TPASS: pages_to_scan is 98304.

....

mem.c:415: TINFO: child 1 finished.
mem.c:415: TINFO: child 0 finished.
mem.c:415: TINFO: child 2 finished.

Summary:
passed   40
failed   2
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=1 corefile=no
cutime=170 cstime=290
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20230516-75-g2e582e743

       ###############################################################

            Done executing testcases.
            LTP Version:  20230516-75-g2e582e743
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231103/202311031548.66780ff5-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
