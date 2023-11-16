Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAAFC47071
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 04:40:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17CE73CE4A1
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 05:40:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BA273CC025
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 05:39:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F46A2001DB
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 05:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700109591; x=1731645591;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Dhirehg36Kj97nVqO/qF53gdD8rYJbOh/ENCZ8e5/8Q=;
 b=IZ/n0W36/Emq5LzJqhywAedfLoJ5FBd08Fl0kUV8dyMmKIIU2UYtyypm
 zyNjJZ3tJV1YQiDMW3TA/2/sb06EMKIfNWI8B3lFwK8bPPErXgIYiE4Fx
 xwrgguHnB8OYbl76tWj4ukWORBTYmZuZDNMoJV4VcHwyJt5XrGMz5FFaK
 i+i6wlNtEHoW+f2d+hO6Q2FNOoCnaqcMunTnmQExLNPXaPNPObzi1pioa
 Dntfyr7/Q4kpoEXhcGBc6yHlUEYyLpMQb21kwhlIFpe1K4GtjNMyTN5vM
 KvLgjlgxBVHtY+v7fzgagmlJFCiI62jBLUZFme0lHJO7Cqvf1+fK74qwc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4089623"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="4089623"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 20:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768797311"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="768797311"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Nov 2023 20:39:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 20:39:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 20:39:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 20:39:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L10y5J5c5WvllHXpCeL52cYMyCnSfkC6uDr3EB20MS1p/LAwgnn1KCqZcovyAmZDlvqGcRpHx+K9xeIeTzH/eCyj12Q3z27P7bepB4KAO9Cz5VSfB9txBzwvpnuDHX/79SIVPNQQ8lkGFS4AQMeUGmIuaViVdM2ZtH9YJbZF1UQwknPeBJrmHx3RLWhyvgps2ZZykFs25M1WKj4UJUaPJ15kHv7HJXz13K5O7cphdtNshTrCVyXUp9zmbCHk//yudyd1JKy8ZuCvEr6SHvafAWqmzVYQC6EdbvTWX7GTZdn6WMSiqbK1S+MNDxsaVfu/9YxooVzJ9N9dMkqicfNXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdT90THEBEf9pOacFOzg0ACebzlLsjssP4sAHep3wjw=;
 b=ki7XnlwxLhLPcmBcBwv3HSA4QaqmcI88nfcAieO+P9zVxc0oFw5Ogkjr79s38hbG+QiHNSsDekMIJKwtz8QtHWXo9DswQ9oK60uF3u6awfai+6wo7J4RXvSlmV1RczSumpT/tbtg9LV44Z6IQJ8N0suQoP/SimEl29wZb4CQ8byhXZlW/38usriMJ9nfznMnIO8YxkidV0aAy/FZSiJVd9b0pJuyYkwGovatcoVdH3SQSbmK11lDYhvIwICrU81AEPsq98yBmlTcpXNHqei2Xu5FbytAyHlVLt/Pz02AIX623eq634vZaqFYTmq7g025y/NstXwoiASZLOkQ+QP3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 04:39:39 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 04:39:39 +0000
Date: Thu, 16 Nov 2023 12:39:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Stefan Roesch <shr@devkernel.io>
Message-ID: <202311161132.13d8ce5a-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 3594ef03-22e2-4dc3-038d-08dbe65e0ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46bXkmDlbpsWCe59XC3o5h2SaOSRL+IuSM4oRmnVKwgL/Aod6Lvak5+gNbKetECnMWpV7271kqoMw0OsnyfW1kH77sRWemWz1QTbi8EgpjAaS1chLsPAkC/cXGSz9WJeq+AIWvqQtcONyAVfEJt5zDrdtngmPNMBa+/u7kMK1SBM+O13EopY9FHR+Y4geCLWqZTXeayk+HZaw4isaJx9djBY+QjHLdPmqTa80sN99vPnGmLV6mPgm+zywCfMbldk7p+ENDXzaPSt9gkU84wBmwg3sxUGKR3Li3SDR20ran/iPv7GCpmmQDcNQnZiUt5MQZsSrsDRtQtSk5PwtjUVS9qdrB+Yy/c2pB1vgEzB/ktYfNzofTBmhsyCmi34tgibAeGeMabxPS9onVgEp5zKmW3Y98R8GDNNp7HcvnbnbmyPR0/r80vqN+yQgWY0O9Ng195P+WiyT4b2l7B4Hm85OcB+aW4va6R7GpG9sGuN7Qw490rM1x+7Q8Pq8c0knglIlcXcQSnjkwRrV9tr/Ue+F5IkVzeF8Z4E0wqZB4hQ15bF86ghL6qpqoN4IGajMUzyGE81+13dow//iArIKWemJyiQuJxntlBMxC7fsY+g4pQpPS+5cVihh9CC086mTSxb9k5kWxn7Z3JulU6IExQjFaXTgA1CEfH3lLVyI8sgX1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6779.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(1800799009)(451199024)(41300700001)(2906002)(86362001)(5660300002)(8676002)(8936002)(4326008)(36756003)(38100700002)(54906003)(66946007)(66476007)(66556008)(316002)(6916009)(966005)(6486002)(478600001)(83380400001)(107886003)(6666004)(82960400001)(6506007)(26005)(1076003)(6512007)(2616005)(568244002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tagRh8YKVNgnbSunVcgPsBjQEoduMy2pcnYdZqpSHHLATqIm2392OJXYfegJ?=
 =?us-ascii?Q?ItbT8qipR4yIO5RyNCW9R8IQN2DlHVJWHlkgMwQKCUvi0V8Pi5f6Lk2wuZ8u?=
 =?us-ascii?Q?uRyrlx87LJSJ3qPH/5PScL//Hr3v9MTIlf4l1z2w2R15o5aVIE+MAwGAYfn4?=
 =?us-ascii?Q?92iA0Tgoq/zFRxc9HZBncMyXLm11x+tojM4B0zYNd119ER14Ajiy7iYy/IRQ?=
 =?us-ascii?Q?X71wF2K9djJSZNAHE660BFm77vUjniX400ZmUmkJQ529rMZBePQIZ1Bykna0?=
 =?us-ascii?Q?smTR2xD2X8fBqeGx+xFoRNB5BtaHrPRGZUu9DGiqJGksEFWztaWlBa7c6Y3D?=
 =?us-ascii?Q?CQMll2xl4Foa8Y2Yv3Gz3FoCoIvCSbIfdZ0IpqioMS+0vliGqlaD44vRAx4N?=
 =?us-ascii?Q?zdxNg0N4RqWu9jxwk4b1+4sMu8fug8rfFPB+rixROwuFMtxXqySIt52MO+m7?=
 =?us-ascii?Q?16WqhgXwT/e0BJkGouKT9SEa6FSujpQXr0aHgcixpE3f5+BoK6nU0GUIR6wi?=
 =?us-ascii?Q?RGhFipXEdDrew863AEb3zvP5G/i1uECjZxmudcAvhH3Q2KGmehdGvnnp0bk2?=
 =?us-ascii?Q?rdv/QJ0JrnQb46q3X25fxot1Ow6613ZEdyHbybHdg3pzRzdjQWggFpr285yr?=
 =?us-ascii?Q?lgWAjFtkPG2Bx3/MHYOFui1C4adp41dQtpSmbE+N0EehNqdrQclLMgppxXL9?=
 =?us-ascii?Q?DgjHqExKQJiOVuke44iDnmxq4SmmfuRhBAQu9dkJB52EQb3APswHUuosHjSR?=
 =?us-ascii?Q?bFOUPBdCgSwIFwY88cNZxnUEfqRnRSstOAWF8pYiQQFb7814i/95Q+lbp+FS?=
 =?us-ascii?Q?M43ePJ2P+WQx44EE/PuzQD9lSPXL3vYmp2U9dY/i101nq0b89WJsM9S1/xeO?=
 =?us-ascii?Q?5ZGZ4vT4yOUpixlGDA0l5rptPf9IaboWuPN35Hu1FqFta/XRTqBe6F2tKTZm?=
 =?us-ascii?Q?acz0qKR8MB/cfWzAG7YN5aiC9uSqwGTtux+897wDsarfYMS/ERpjtl8tJ1NP?=
 =?us-ascii?Q?6aYQjDDN/9cdtva435ZRzVRpEXuMtoZxJYOUcztuKr63yDH8Tq9EiN5RQ4d4?=
 =?us-ascii?Q?VeXWT2mQeGb4aCqR1dYYYCBNDVKcH0EDJkcGS039NXMnTwrT+Qd+Ff49sRe0?=
 =?us-ascii?Q?aiggqk12+Rr9EEATcI/ftv+tQOy0icszzZoXtzBQI0N3wzIqfzklbrKNbL2e?=
 =?us-ascii?Q?4JwC3xXUlYv27xfu5t9giF/zP1PYqIGx3Hn22wmG4zHziqiQ7GcdndV6Tr4O?=
 =?us-ascii?Q?ik4vME3I6XEf+mrznMGGZqKkqs2eQxkRjUvLzFrY/cdVU7I3LUdDAoH3RprS?=
 =?us-ascii?Q?VHnpQiEwiDt6VM5YUBE0SUI2zzYun5tc/XWa3oVYjvoleDvcC78Wqpvmk41A?=
 =?us-ascii?Q?iaG+UlI448koJtD21CfPkXKMMFqYKmCKNqfTdJWFOrXuP6OkWwMZmoF5q6fe?=
 =?us-ascii?Q?9WY2ogxLPUFVC4qyxzTGPvzkEqNMe3sbUfggJg04xvBdHLu3T/ubRFe+Y48B?=
 =?us-ascii?Q?a0e+GwjhgLe8fw1d8V1XSVFuxKsdHRL7pXKMz9SW4EvmS3mpg6amqVm0b3kc?=
 =?us-ascii?Q?ba3f7zcb8VdSvHT5nRboO+AAFOc+8MUkdiGeyXYJbyGjdfWtVJfAnaUxvHQ6?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3594ef03-22e2-4dc3-038d-08dbe65e0ad0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 04:39:38.9347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TO0QzVMGLyoNYGoaaa07mOX0EJXJZvC12kC1A+yR4jzwMiA3JfmqTDLrsplGyZnrcVz6zzY57kjFc0RXOZEuZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linus:master] [mm/ksm]  5e924ff54d: ltp.ksm01.fail
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
Cc: lkp@intel.com, David Hildenbrand <david@redhat.com>,
 Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


hi, Stefan Roesch,

we reported
"[linux-next:master] [mm/ksm]  5e924ff54d: ltp.ksm01_1.fail"
in
https://lore.kernel.org/all/202311031548.66780ff5-oliver.sang@intel.com/
when this commit is in linux-next/master.

now we noticed this commit is merged in mainline, and we still observed
same issue. just FYI.


Hello,

kernel test robot noticed "ltp.ksm01.fail" on:

commit: 5e924ff54d088828794d9f1a4d5bf17808f7270e ("mm/ksm: add "smart" page scanning mode")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 3ca112b71f35dd5d99fc4571a56b5fc6f0c15814]
[test failed on linux-next/master 8728c14129df7a6e29188a2e737b4774fb200953]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	test: mm-00/ksm01



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311161132.13d8ce5a-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=ksm01 stime=1699563923
cmdline="ksm01"
contacts=""
analysis=exit
<<<test_output>>>
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
mem.c:422: TINFO: wait for all children to stop.
mem.c:388: TINFO: child 0 stops.
mem.c:388: TINFO: child 1 stops.
mem.c:388: TINFO: child 2 stops.
mem.c:495: TINFO: KSM merging...
mem.c:434: TINFO: resume all children.
mem.c:422: TINFO: wait for all children to stop.
mem.c:344: TINFO: child 1 continues...
mem.c:347: TINFO: child 1 allocates 128 MB filled with 'a'
mem.c:344: TINFO: child 2 continues...
mem.c:347: TINFO: child 2 allocates 128 MB filled with 'a'
mem.c:344: TINFO: child 0 continues...
mem.c:347: TINFO: child 0 allocates 128 MB filled with 'c'
mem.c:400: TINFO: child 1 stops.
mem.c:400: TINFO: child 0 stops.
mem.c:400: TINFO: child 2 stops.
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
mem.c:415: TINFO: child 2 finished.
mem.c:415: TINFO: child 0 finished.

Summary:
passed   40
failed   2
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=9 termination_type=exited termination_id=1 corefile=no
cutime=342 cstime=293
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20230516-75-g2e582e743

       ###############################################################

            Done executing testcases.
            LTP Version:  20230516-75-g2e582e743
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231116/202311161132.13d8ce5a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
