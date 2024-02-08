Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EC3C4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 09:11:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AFAD3CF530
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:11:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 244903C890C
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 10:11:13 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 487881A05C86
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 10:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707383472; x=1738919472;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=yq31qnbAJwXN1fFveEJYhvJlGU0TtEPXF7Cy1B9fPRA=;
 b=STAA3t7L95itYGGLmI3mL5YKEJqk9Rlp5KIeP1QTVOo8o4Wb923M+wUf
 g6rQqcmsCAnsCyLKcL1XbxK9zNYbD1JjAxwPw9GlQOwLWV/xIhKdzjiUU
 T2NNlgsd3IMUcdY4MaIUP/pPBjYexMZ4GHK0egeo1w2XZhn330hsO1NjO
 0PrOY6ASRLq680lmKSx6Cg/V1Nw12qRyWJnpkmsZjUBdiUWN/0iS/ZXDm
 jdLdKh4iFNKC02TJ16rpRdKU7A4+m0J293cS+pt1ZepsycAXRIzh/dQmi
 p+BAxHM33cOku6bhf+/CZle3C8gGRSUnNmQmr6rI65IvmX5a9jbM6N/7Y g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1323993"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1323993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 01:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1598641"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Feb 2024 01:11:05 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 01:11:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 01:11:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 01:11:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6sCvbJvGvMBI9Yk+sVSvN0eEVOHttJxL+ycMSt1SuuKODJ+14kkYJroS3te8CCtmHdLKZu8RZ9ta8C/58acnHee+MQ5Z/gv9hBjhLyFBGcWVaCF4vqzqQx5G12wM+Kw8eXXG47J9EPPu6Ir47O6rYzRiQh5G0A0ofphWpodv6dFtm0HdTnjRdCHsL1l3uWWSp8pJ+E9d5PqE7eLWZhuVnCqZG7C3qM10KXlox3znE/2js3OkKQUl12jWbHVxhbQ7SeVM/H20vjX3j+1syBB00dWkpK1lp6+fYe1KGC5GYGVMInBo4e/fZUH/vxQ5iMY5pKivprgAeTZiP7mIx/mQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s1tFMuueUwPG4f3Dal/iLq4kUWH0KGf3Z13dmfejlI=;
 b=S7TDETDdvTsEL/0orxH5ofSk7UTTS3KzlwxlG46yLeVtUjoL/VHKTWcw6P4oJQtF1BbeeDT5jVQiFe3lusvji6oG4FFh1A8VpA4r7HkJG6j6+p3bpk93Fmj2UbvDujcAWTa4TkGrGYdJr0QAeHk9I07NvanUn4ym6Ri3PFj50K4nte9xxLx062AuPETFpq655Enw+i60o4LFatRHYT6nkwt6nERfCq1RxRq9Tyv/mjRbbXV4cqAYKp1sniaVVkomtvhOACclrR1Xd7f0YxaeI8LJASTloPLvZaSMO4y1AMlnYrzIsonftb+Buo0HguUFaBAFGenQtBza4l9TPV4Klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 09:11:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 09:11:01 +0000
Date: Thu, 8 Feb 2024 17:10:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <202402081653.dfeb3c3f-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 593e25a7-1a26-4bb5-ed8b-08dc2885df03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bazRVWwmuOSNCpcmSEMRhMa9B7NKZ8M8+MS4YcO6wkt6sDI1SKacAad/1e86avZUhWAvtrhvERja9xrlTUXLhBHP3JxjpBiC+tJsfH7bNVOjq7+OzhHTjrDjIQyTee+60a0eC3NlGqBQG8VFUD0DCyBW0Z4lVDr/Nw+zTtnErkn4cx9BA2GV0WIS0rnnKWQKnS6T84CjTNKg6xo8nY0L+cHZ65fXGPRjSfuSlXB1HDadfBy9Oylk/qu9n0T7Np8FYOIMzJ/Vn7fBpgqXr4NmIPBLfQ1Uz0M/gppBnjhQCv40YNw4y/xYHL+2w2bxOOnhbUTrcKAHxKak6lbFe0e/hF50NI6arIZlJFNAn8KS3nI4mEayFM2RQxIxOyxXBH5U3BJ9BUr/SA/75EUGJRvfUWLDu5wkgSBk6OTU6ee8WfhOveY+BURx/cV0Zg0J2bZnE2jZgEthatFPSBz6ch2Q+uIVQd8Ig9qCE/+oBUllSRnUQv8hD3LrY8dxUGzJqKntRbGKywBIQzNrKdFBJM7j+rlJseboWGBXcaJ4/lAhynDKGdeRXlCTXN49h7mpjFltXRHd66WRGIb1WYW7jfqAVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(6486002)(36756003)(966005)(66556008)(66946007)(6666004)(6506007)(6916009)(478600001)(6512007)(8936002)(66476007)(316002)(4326008)(8676002)(82960400001)(26005)(86362001)(2616005)(107886003)(1076003)(38100700002)(83380400001)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rMH358uHEBgPTp7m+33XiGjlJsdwWAK7rz0Psal9c0+HZ2X8nOiTTO35qdep?=
 =?us-ascii?Q?/tV5VB3aUyVA0Vd8kSOUlidaClJ/gJz8bsZr94kRN8XDEA93Tjwm89/cfv49?=
 =?us-ascii?Q?tLdlOgHlNBOP/Sbp1/KYZxoNmcSO8dE0oDaLC1x4KyYfhrAGvDFwAAf6vUWm?=
 =?us-ascii?Q?TJ2ZLISVOBWhVDhUNChG/fGLCsR4VRhgyLhzBSc4rGYnfWHmIB3fr336PxYT?=
 =?us-ascii?Q?BLQeMITapDixW1q4hMHj0GWVu+dGxu4JzYq2SurJ08XKmFcPCfmZF3HPwfoW?=
 =?us-ascii?Q?h0EFgqNxq8FY3JxMsB4FM6kKEP1EvHaTk/CSZovrMGY5hIylTpLTNd0gvVw9?=
 =?us-ascii?Q?APWxoat57rpS89/y/2pmUWHP8drRBebHE14xklH4nw7cYO2qEXwK8oJA8+Sn?=
 =?us-ascii?Q?K8xc46EnIUU0ItFj64sD8drt9rEYszA/FjRCJs2xxThXcDihx9dXsAEx/I0V?=
 =?us-ascii?Q?zJSZmUXel1sd2ZHcmCPgT9HwzeQRSJpX7kw/jVfwFXS0z8BaShldYcr960Dx?=
 =?us-ascii?Q?mUcEyJJhEIr8Ulp4p1wGhofztFZUtiX1UuGpsuawN/zdiOBwplUP6dK1eRcP?=
 =?us-ascii?Q?LQ2W5fvs8MXi2TwnaNmlSkv89iOHSb1Xl4FHh9O8EoPMHw+6Fzr+tchdjAet?=
 =?us-ascii?Q?HWBjGp+GQCyVSrx/pAm77iwXhu+CrH1a921y0g+CBD5FtXGf0qAMBkOpsBjx?=
 =?us-ascii?Q?WraMvjakSqwFJqT9nYOO6lsTWaRktjnhnzfacx4rJB1rxCj3v85/uWXgz0sz?=
 =?us-ascii?Q?hbg8otCNZVQPOWZGNYrLt7YOOzoR157RLS/sUEbtVH28/NTM7xU8qKbq+CB0?=
 =?us-ascii?Q?dtR7Jbe1zgYOOJYg0lshY/MWXnMnbpx6hdpCWo+FMeVmN3KllpENJSufODmu?=
 =?us-ascii?Q?Rg5b13ZtOfrbhKcvSHqC1+God7cxPDSnJdlzVSLXVIxeOd2LOVh2Ls2baUBx?=
 =?us-ascii?Q?nu05rZMWoj+ZMRra7Wp4GUVbPrJi+nqmHzMVWFMaKbZWB7ofVzUYWf/+wxbB?=
 =?us-ascii?Q?5iD6ecFDZ2s2mFCtF0iaVZZiNAlPEKcWT8o8Y5npFD1Th/bjlIqLeMI8dSVQ?=
 =?us-ascii?Q?Hn0i6syCCmMHWHsB/Vh+Gd3D9DGGU69AlXTglMohp4/pJhCcxLuXpXnnqnom?=
 =?us-ascii?Q?dfH0zBIPmoiA11mAEGtgxzw+uFNuPHOHnplWlBraExtD8HTNlFehmeZQS2RA?=
 =?us-ascii?Q?qkUiwN6SPfSP3uAfu+NPXJciTiJUBjvC3NRH3Bn62DvInA8zLPfugUJW+x2h?=
 =?us-ascii?Q?slWqAeJgSz9zW1/AsXvOX1/Mt0IlbLuLwlH9K6i3GDRggpJzFGySwmtd8ASK?=
 =?us-ascii?Q?EiQL1l97Hing+SCijA322TCVYf5c7QzjpbI8mK4KFzHHemXA/DCFv92FtIB+?=
 =?us-ascii?Q?f6DVHHh0uQOgWRhIlscf7k8lPRU1/oi1XNyxpEiJQb+TtzP/B9fH6EuDvYrh?=
 =?us-ascii?Q?H3KCRlf25aLRG4oio7rfJd3HHQ0tc5j7WynJHhrVAFXoi83zLlSqI0/P/ufk?=
 =?us-ascii?Q?b8mdSpOES1Z+hkrv9L7hJOHtRE1rs3Oc1b0zPHg7CpsxVf7PRZ6CVxf5nX+p?=
 =?us-ascii?Q?IdvCACK1ihyPhq4ZR17Dy4eRnsnxhgucf5RT/8Ud/OLwVbCVIMPVlySilIw+?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 593e25a7-1a26-4bb5-ed8b-08dc2885df03
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:11:01.8186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmXTnYmFkRlgdv2133KBnVZ6LYOoOeeNCjqy2uR3mKBuqqh/qJPZZSAdYXZprFYg0DXHckN4UaKdz1hTTDkjEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [jlayton:flsplit] [filelock] 5f664b2068: ltp.fcntl17_64.fail
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
Cc: lkp@intel.com, NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.fcntl17_64.fail" on:

commit: 5f664b2068100bcc076c5a7e4d907a1d10ac238b ("filelock: drop the IS_* macros")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git flsplit

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-03/fcntl17_64



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402081653.dfeb3c3f-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=fcntl17_64 stime=1707278103
cmdline="fcntl17_64"
contacts=""
analysis=exit
<<<test_output>>>
fcntl17     0  TINFO  :  Enter preparation phase
fcntl17     0  TINFO  :  Exit preparation phase
fcntl17     0  TINFO  :  Enter block 1
fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child processes by hand
fcntl17     2  TFAIL  :  fcntl17.c:408: Unexpected death of child process
fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir: rmobj(/fs/sdb2/tmpdir/ltp-ZVHhQhCGuo/LTP_fcnoKSPFS) failed: unlink(/fs/sdb2/tmpdir/ltp-ZVHhQhCGuo/LTP_fcnoKSPFS) failed; errno=2: ENOENT
fcntl17     3  TFAIL  :  fcntl17.c:363: parent_wait() failed
fcntl17     4  TFAIL  :  fcntl17.c:605: child 2 didn't deadlock, returned: 4
fcntl17     5  TFAIL  :  fcntl17.c:295: fcntl on file failed, errno =9
fcntl17     6  TFAIL  :  fcntl17.c:295: fcntl on file failed, errno =9
fcntl17     7  TBROK  :  tst_sig.c:232: unexpected signal SIGPIPE(13) received (pid = 4019).
fcntl17     8  TBROK  :  tst_sig.c:232: Remaining cases broken
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=10 termination_type=exited termination_id=7 corefile=no
cutime=0 cstime=1
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20230516-75-g2e582e743

       ###############################################################

            Done executing testcases.
            LTP Version:  20230516-75-g2e582e743
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240208/202402081653.dfeb3c3f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
