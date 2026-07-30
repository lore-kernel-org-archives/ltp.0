Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA6AC55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:56:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDDC53E559B
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:56:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 095793E724F
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:56:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8785F600492
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785419762; x=1816955762;
 h=date:from:to:cc:subject:message-id:in-reply-to: mime-version;
 bh=0idbC/PINxKCEWCgK+a9yEGyJowmDeLq70kAaY916hY=;
 b=nvgG4uUhfbdlSOj6fWhAP1UcXnXojVE8fSRSoQpQ+bkIu0dDkEELAUZO
 WlFRLRm/ukdads2t4SCy27qYaQzURKK0nSJsYBfRhErc7PhyqAiBws7ms
 blNnLu3vi3MqArlldgMzcfzl9Q9VOxm1rfDqtyu/UULsYeiaqSQaWkCYv
 oInQfA0a83So/PSvZaKPKSSQUO69L8+3o8XttvQPaNxujDarj5fy4nxBw
 1mn/m83eRUd6zNCMw4BT7mRATFANxUL8RJ14FzEtTwGuN4g/o6qh6Vv+m
 dgTOEJ5jUMkGtUC65cJTT86ZN5CrxJ+q+wrPcqwb7iDMOulf2KccYzg5V g==;
X-CSE-ConnectionGUID: I8DIKD7pTDevlId01Z3X0Q==
X-CSE-MsgGUID: +cV7ILkTQ5GsTVoDpjZk9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85894686"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="85894686"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 06:55:59 -0700
X-CSE-ConnectionGUID: RhLkTRoNQUe+exfq0eefbQ==
X-CSE-MsgGUID: veLSceNVS+KPLhKVHyLVmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="290260252"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 06:55:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 06:55:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 06:55:58 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 06:55:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbfW5xrEWFOJDzatywtT8C8sFR5bXTrrKCKhiiFNwlgskkuTmqhRMi4gpCk5YkM2euI1NRqKDQ5oCidCb/MfAqzdqPV2Zc3TZaRzGR4bAYj+ilhgNyRFA9lryaBd2VPoUmPkU2T2nLPFcDT43Tsb1NRjT/25vQ4DJqhBvnUMtGyggKrX7TYizP3jTc1yfA/HHt1+ga8cfCx6z0sai4AEu1RaY+UUa320lre/ndy3QNULwYIkA5GutzJ/3dKUwfdLlFXmwnYy295PpASvblgTffJJW2YYlJPDlRFKVbHLgurZ/Ua2MCz66RaA62pkfnY92hk3yXA1ChnKdJteML0tWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpctPinir0liy95CfUs77vJzwYsoUeUaiIYrYMLR8QQ=;
 b=OzbA58HzpVtCvcoEFdGmnfQjdahlGo6IxTv1hgr0V/mZw+uovcT3LyLZ1RYlGFpsN3ejkAu2PxIf18bm1K+0ZD/HEbjEBf4o4Va4PuEP1Vt88RfHHbbG7DaH7UPME8unOZtKixubrazXwXL5Mab2cv6HtGfQq1WXf7hR9UPE5hMUgjV1cVqOR/7ArVUJ2/iMF5fD8hOWExGEMT2sk8tqznh5Latjv5RXi0LePv5pejEakpjg8F8wMuWGTlQACxTTH8edsYbSDtNOzo4G0d0ZVDFbhL6TCl2EnzVAtGFscoS5QJTJL4hmwVeEU5lhq86w8xGNnCM1xA82W+aah4tamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 30 Jul
 2026 13:55:55 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 13:55:55 +0000
Date: Thu, 30 Jul 2026 21:55:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: luoqing <l1138897701@163.com>
Message-ID: <202607301544.5b1c926f-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20260720082145.1072547-1-l1138897701@163.com>
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|MN0PR11MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d7ab6b-cd3d-4282-6fa4-08deee424640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|3023799007|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: SMVnQ1FZiDXN1EuJvAOqhw8CndqGbBw9X7PYl6rAmKRdvQy77w85BzcoEVmJ5y6Y3gE0d+ZFg7zBEIablcBmPOPlokwRUOFLDf0sP9sLCvESmsELc+DFYWIYEJIkI6oXxZEl9XpRtxrPCO72nivrcqNPmrN7TsrAy942CA8dpSkDz4qBrzTS12Wv0BZ+ta126yeuM8CbVjyzgVMOwKU4nXqpyi/ovMdy4dhqZeITT+3DxMAni9LvlJch1vx5/gSaSfwETneooTtuBbCOhDJeMWORz/64p4j0WQZhKJ76c9AlbNHgCT/QRDIi8y4hRZCMTidLPXSQD4C8tMa7ZtDGiN+ozu5ko/GpRagHRdOg5ee4EmwklAN9E9462pylrsEs4jvIZBUm/1y42+MhTnwEKMDpz8yVhJyvuQ9BIvtKZEoZmpOteNpMi9ewrhnvXf2PbyF0+znHkyHdtizEj2O30az2nHrXPBUVu/S7UqHIYfhjKYVFzlat9sb2mJfPDBsXhShv2cjpS4EKTdQ+xg8IkHWgIjVqi98tWadZOaSdSsgpKr/otBjU2oyPg+dya5OgDsnrUgOcn/6a63k1tJgCQBHkNokQUrCdA86d1BkIakf0MzlFMk+sZ91XmCsqLeoV2F8gIQ5NGE0OeFAvkw/6y5f7rBYymuuheIy9A9tl07w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(3023799007)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMqFtc7ca3AaJGaenp5TGxmOeQQuiOOAIqsVqQQTPh5idnKOP4tW4M0kQVyb?=
 =?us-ascii?Q?OK2NuCTR2IND37Ac5Zg3TCBWUgtPNfKkCBS2q6fL9fyU98LHVZDVQOUrohml?=
 =?us-ascii?Q?HNKEmybUTsSQ5Ovv6zcTw+8BV1BY3kC2fst3WIQz1GUbK9glC4ZOVnY8n4F2?=
 =?us-ascii?Q?6GcN2n2IcJ6II5+Cb9sFE2buN5wWtxgcUik0UEjS3E9YW1b6+5g7xHWqvuq4?=
 =?us-ascii?Q?oiT6i3ucURs9GREPvtkzruR3hsrrsaKMbMajwHbPAZSiIUBxyuQeN+DxgpUp?=
 =?us-ascii?Q?s/SwMeauXMh6fVPHOS84/LZH4dMh0ijTf5q2wALUYNZnw+tjcDQMs+B4+wNA?=
 =?us-ascii?Q?zCbJhIw0Gn9/a284vFDaO2PLnKBEX0acTqCI8ySTNQupeIuKotgbbcE11XSS?=
 =?us-ascii?Q?zJapWJUd1DKf3Ksw7wnjK79q6KoEgKwiZvgnf1V8LScnot0IJIm8SDAPlIV6?=
 =?us-ascii?Q?a5D0NkvOKc4WvRFyiB5lhVzxA+UzN6AFprSAZ3Xa8848qUg5xmeRfdtGTUr3?=
 =?us-ascii?Q?6E5q7dTGE4Vm0cZJ/JOza7CqCZAOLAcEcsJN8X32zkBOjnX8cAae0f2zdeST?=
 =?us-ascii?Q?OWnG4QTE4Qf4vZ8X0J7kHkiOXc/FvgMf7KUIMCy/AUCmepG8yeqfXxjE9ZAB?=
 =?us-ascii?Q?dstOtPpLp5XWOgNANG4Kox13+ND8LgOffnLVx2S/CUlvKByT4WzbfvGLskC3?=
 =?us-ascii?Q?hXGn5V0dNzumstcRDQwd77dofHpIpRHiu1PqjTf9XB6OY2fbwQv4EsE6ZO2r?=
 =?us-ascii?Q?+BHe34QY9azLRp9II4KR06+7e+VFptBSM7NvXtq0XI/HAo/zmi2squ2VZHFO?=
 =?us-ascii?Q?uwIzxDOXFLf9vyuXBK7B3tHS+wbOmbd8AEUMs5Ee4kyo0XJgHeziSbqEc2lF?=
 =?us-ascii?Q?6w0LYwA+/CDrDHu6yuARXrsBJ5nuB1JYxFEM3wvaLvMNRvSlXIT2X2jeEbsZ?=
 =?us-ascii?Q?ntgD8b5XzqwGwwLi2Ez8AKLhu+UnMCS2y7yYBVK1/rhO+XVVhoejGUqGnLAB?=
 =?us-ascii?Q?507rc31mR0W0Kg4gvJMql1ZhHcKWJj4Qu1f19jjBTNBwfakv6cB1ufPQBY3g?=
 =?us-ascii?Q?fzv4RKNxfr4TMDCXCAJBvI0b9k4+4wayvxpIPnBZFZFMqq9GOvgifHKDm892?=
 =?us-ascii?Q?nHjkTFv3vRh+idjlnTcavdwleCDcPErd2UD+nqKBUpU+veuBZGfCrRNCdPsY?=
 =?us-ascii?Q?KjwBxCncyNVPX+4KYlLCEBMPT4Lr7DvNwehhnlp0FBhYtl8O3dkIUSEi+npg?=
 =?us-ascii?Q?MgJB1NukXOQ7PC24iXhvWTRfF9RVgXbuv5T74+DB2U//tuj6eGN0KZoqVhHn?=
 =?us-ascii?Q?lBeQt3GyWgYxtJR8ZW8tK2ytnnIej9Js/HGm6TOc5iU2+sWCWhPJw61WoBVR?=
 =?us-ascii?Q?2TxueB9FShFkjD4PrTCV7QYBEH9YZC/4T3vBeZWO6a68Sw+4Be6ksZTbgSCY?=
 =?us-ascii?Q?D+50RmxJlLLbqB/6uxxWTQTbr5sm4PXzDqBzcM4wsdmWmdg2V7DyjM39zrTY?=
 =?us-ascii?Q?KOS/H1CryQoDFD3pU78OCEzNigA0Ks0mlZC0NGVLXXrGRaYK68OdzuesBxTe?=
 =?us-ascii?Q?i5iQ0ilNA6sqHKHRBd6d9xAIPvFlzOrFKN4QAnbPu2SuFPYepjXVHKnC2AbO?=
 =?us-ascii?Q?c4fmzzFBZLiZIiwXD1ZR4lXFUwv35yL8afOZ4o1ug1VdtF/Bi5GQO6JGKyd8?=
 =?us-ascii?Q?bP718IY5+/O1YqMAYfJaj53BkxLBntIkZMuPmo6nz0Y8cFu8OodnWRtQeuRE?=
 =?us-ascii?Q?2HbTlBYMLw=3D=3D?=
X-Exchange-RoutingPolicyChecked: jSt6gmizhEp6pbtH4LI/nbQgMhKflSJ68CTcJEgbJ9PvEPpuRehStpc1tXFMQDbhvmlfzSxIj6a9kp8Z148xuU7ro5bXoyHK1D6bVwN1ttgdpb8sYMYdpwCtJFboHb7ZMPXERyQDl0PJwcHW2Q+CdfhoNL4QBXtTWWxZ5gL6LsLGFVcOdYnFoirn9yD4+FMCbtoLqHxSm+C/3eU0ji5rVv8PLShzdcohXaKxAYVAIg15vSmnOI4H1bQboQZ5nBtVRrAt9/EGBMymlnSmSWm7pnaRTmD8t0k76SGim7ujttyxftRja7yFlE28M2cABHNPKCfZVzUsQw/UT5xJKhvIqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d7ab6b-cd3d-4282-6fa4-08deee424640
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:55:55.0184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0SLyl7LUFz4a1i8SekRiYwwXB2hoVtc6qalYHV5YvRDZOCcLDQGJtPwblSLL3LxRcXwpjLImlbd5MYeLqBc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH net v4] sctp: socket: refactor
 sctp_skb_recv_datagram to use ERR_PTR
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
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, lkp@intel.com,
 netdev@vger.kernel.org, edumazet@google.com, linux-kernel@vger.kernel.org,
 linux-sctp@vger.kernel.org, oliver.sang@intel.com, horms@kernel.org,
 oe-lkp@lists.linux.dev, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hello,

kernel test robot noticed "Oops: general protection fault" on:

commit: 2ddbfeaa8f2cc0bbcf3f9b731ad0845142e8688d ("[PATCH net v4] sctp: socket: refactor sctp_skb_recv_datagram to use ERR_PTR")
url: https://github.com/intel-lab-lkp/linux/commits/luoqing/sctp-socket-refactor-sctp_skb_recv_datagram-to-use-ERR_PTR/20260720-162305
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git e13caf1c26587434f0b768193100440939c0fb91
patch link: https://lore.kernel.org/all/20260720082145.1072547-1-l1138897701@163.com/
patch subject: [PATCH net v4] sctp: socket: refactor sctp_skb_recv_datagram to use ERR_PTR

in testcase: ltp
version: 
with following parameters:

	test: net.sctp



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607301544.5b1c926f-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260730/202607301544.5b1c926f-lkp@intel.com


[  336.463290][ T3393] Oops: general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] SMP KASAN PTI
[  336.464727][ T3393] KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
[  336.466093][ T3393] CPU: 0 UID: 0 PID: 3393 Comm: test_1_to_1_rec Not tainted 7.2.0-rc3+ #1 PREEMPT(lazy)
[  336.467502][ T3393] Hardware name: System manufacturer System Product Name/Z170I PRO GAMING, BIOS 3805 05/16/2018
[  336.468800][ T3393] RIP: 0010:sctp_recvmsg+0x12f/0xa70 [sctp]
[  336.470112][ T3393] Code: f6 ff ff 49 89 c5 41 89 c7 48 3d 00 f0 ff ff 0f 87 07 03 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e ce 06 00 00 49 63 45 70 48 8d
[  336.471545][ T3393] RSP: 0018:ffffc9000309f800 EFLAGS: 00010202
[  336.472903][ T3393] RAX: dffffc0000000000 RBX: ffffc9000309fb78 RCX: fffff52000613ee5
[  336.474278][ T3393] RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000070
[  336.475604][ T3393] RBP: 0000000000010000 R08: ffff88826af3d25c R09: fffff52000613eee
[  336.477012][ T3393] R10: ffffc9000309f777 R11: ffffc9000309fb80 R12:


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
