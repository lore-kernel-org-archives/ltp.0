Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91568CDB465
	for <ltp@archiver.kernel.org>; Sat, 14 Oct 2023 03:36:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 990CB3CF61D
	for <ltp@archiver.kernel.org>; Sat, 14 Oct 2023 05:36:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30AC93C8712
 for <ltp@lists.linux.it>; Sat, 14 Oct 2023 05:36:31 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 158A51400BF3
 for <ltp@lists.linux.it>; Sat, 14 Oct 2023 05:36:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka5jhw8QNxisORP9r+YT+QVlr8IN4z/TZf2m8ldKE3+9qYKwPxOY3RpdfIj1pENgXH9zKhKIUdwm4hUmxbEL9UaGPFWQnCQDvfnZAkIWpqIEu3iY12ZVTX9mSWGkJKIcvIjivlPHElYM7II/gm/WpFDGU4D/+eJQ/saWk3dSMUqYBkLj/DbgHLgS0ReedEDpi0wnuXFGYLyt+j8VjlgvkHuEHFE8UaVBQ1gKp5Y82oPKehnxGlj5wjisrFkJ48V/fSFdFk5MyChVV7j3BfmIVTlX3e+wEHCjyhX7AOD3fRtNxuawL3mhcHrLAngYg+AfmUK5hNb3oUf8Q1FQtQ0PBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI8gzU0dfdlX87j0kmDyM7kTIr7p/ZQtiEJtXnUDIG4=;
 b=DymNl9hqHMaRb/+m8FziRnKiFzeK3XXRGhLD78k1I0zwFao1C3yEf7czhIh5qFCcuyu/6DLQRl+UobCRrKQQyyu0fS0/4MiBDH2Z3ZYgei6lQm1c/sqWvAwaaCNZ1MKYIW7FAvKBu7RlTJhSLgKFVUCc2VYQZ4GPbt0fEtiurKR278FFcnmXvJFtl6kjggcBPYuCRk7Dkd3ABW/6Mg4LyhpiLqdmLsCpfSG+l2I47AsHcGjAESiW2UiwS8gZJeNcGY78QrINfvLb6hIQLbvCgrpufBoWqLaB1MeAq2XI/gCUv4h+N+DqjV+Q9mQr7RkfCTUG5vijR1tO/+VMKKFybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI8gzU0dfdlX87j0kmDyM7kTIr7p/ZQtiEJtXnUDIG4=;
 b=paoVH1X+8GGx3xiS4VjtXeBuDdFe1HuL1Dga6JSSFHnNKaPpEyxOcWoD/5ucNWY5IXeT9J9Aw9Gr5j1B4GNniK2882ewwZzJdUyR5OTjYQYXYIP4khYHOo2GuYJvMV4pqx8jsxz7V3DfKJLhp+P4b9bddMagTSTuQPM6FmQJqvEDkmmRQge9G10vpijbNY2EZj6Ju3Ryi0sD02j7a3HBO7MF4qtnDzpUtvb0Yce67a/huW0uzA8toq30Skm7D0qct6biCKTZAAyijsDlkhLCna+dhrS1eZztmdsXbEt5ZvKY+cYy/FkXanY9RJ5gawmMHGDwYEpR4dIJIavrNPdgUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8888.eurprd04.prod.outlook.com (2603:10a6:10:2e3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Sat, 14 Oct
 2023 03:36:28 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::fad0:efdb:766:75a]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::fad0:efdb:766:75a%4]) with mapi id 15.20.6863.046; Sat, 14 Oct 2023
 03:36:27 +0000
Date: Fri, 13 Oct 2023 23:36:16 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZSoMsDNyf4Y+w8d3@wegao>
References: <20231012111333.32004-1-wegao@suse.com>
 <20231012112548.6887-1-wegao@suse.com> <ZSf9IdW9ciTDjkFm@yuki>
Content-Disposition: inline
In-Reply-To: <ZSf9IdW9ciTDjkFm@yuki>
X-ClientProxiedBy: CY5PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:930:14::25) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f49391-cf1f-49cc-74ca-08dbcc66bf78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +drrPiCiZ8US8/QfOgHs+k7RvAOAiSS3Q48Sv+mOQPPcoyNZG2MSIYCAnPgrqOxmN4pDCf8EbAGRo0EPmZxMaPOGFWkXj6lhm2hcGmXg+lkatwbtwq4SBpDN7MSUPN5tLs5YLJDgx+m8obK/Iq/tXf1b7uMuDGfItEtYNjWck9aigO3nDBKZcLWvka9fz4guCfBfn+wmIH9TvTpOkyArgPy+JRnU/a2FQK25Jui+6Ohbmdfi061x3ATc0u9gV4dlrkl+V8LpTiiLpPdRO2SZnUL3Kp+zE2N1QoyLE6NyxtWovH+0oFS+8wFAv+1ZOxgoCBfdVfhBMUCS0N9n5smQPWxVEuMG9uzz5K4SeJ5ycopyt7UUsNDIV+dbx4s3WvkGiw8HIXzZmSJuelOtkq/WoBIInuzBkSKfsqUL55TESvHVOIhr5VJBJPhDF/yyBwxQZwzWbPwpWcQ1UfjU1/pxZtGu1N1R2zZK6+LG4L95PMLPOCh0ERD9ZqUxEHgFzVOuznw02amBCaCq4PuhN53kt9/2iJY4QNwSdUSHq/5oZBm8ia4eL8khZ07LxBDWQ3kWpGRl1I48LbXXKYr7TEVweSgZtLKaTDfM/omnyUv5Ob0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(316002)(6916009)(41300700001)(66476007)(66556008)(66946007)(4326008)(5660300002)(8676002)(8936002)(33716001)(26005)(38100700002)(86362001)(478600001)(6486002)(966005)(6512007)(6506007)(6666004)(9686003)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sDtvHpyIcruero3JovubNAuhKB7m6lUSglAA1TCDOpK/8ToICjsSSN3OP5rx?=
 =?us-ascii?Q?1bQ7xKCgJXT9UBmTNQ1BDpJy6puIsN1ghA+EOkm7S1Q50Qz68HPjfwGy2gA3?=
 =?us-ascii?Q?jGhhIhbWIQJF4C87kvuDxpVxZdsdviwvz3Szk+s23+tQOYyxHIRFV8QHdsse?=
 =?us-ascii?Q?3Xk9/907MemPaDwuu5AAk8g12rLCdCa9Qw6sJuclf3uX65dDlDBVISFFDlZk?=
 =?us-ascii?Q?jkVeZGCRgWX0DRxHwXs792pAFjbaEfw5AjD6cQguUZnEpIpA0W8V2bX04HKJ?=
 =?us-ascii?Q?d3ne2Zy2KeCOcsUQXSfhNd/yJijRQNQwkH40LbH92r2uGQgr2qVce4+3RQkJ?=
 =?us-ascii?Q?ZOLeCyV7R3GRYPzz++Hz42HMQ+585yfRI5lsOXnwmpgIJARh3HPQQ/2GVX/x?=
 =?us-ascii?Q?Mua6gGisSH6nqFJx6BhEgnU4iWnARQ8Z/3p4g++6tuLfoxuVNq3dkADoFppR?=
 =?us-ascii?Q?Xti0E9b+0Eq0KThMVkSzhzSfLHqaH3zIiMetcHXZMlaoCVuZmm2eI+0/PA1X?=
 =?us-ascii?Q?CEgREKtv7mRqZ4k/yiy9hm1C/oSKGJ7YZjmb6EhjU0pJoZ6Bf1Mb8Enlkcpx?=
 =?us-ascii?Q?Xc1vZVgzHi8aCShTiOiIrNhyUj91Bpo5F9ynp3EECLvyV6MhhaTL0Aw/hOn2?=
 =?us-ascii?Q?dUaBeEru2IZjpzFlz+gdxgd2NxLscivBzQVR1Of3r4hletlNbGDuKSQ6/oqD?=
 =?us-ascii?Q?m4szDPsv1prYOcVRO3IFVIMokJ1iyv1do6pgOf5a/huhCHMjaK6P/nOkhmQ3?=
 =?us-ascii?Q?IzxemTYvj7yUaFTXyr2CeCMWkN8HeVbE2eKOLsVSTjkS/WaUtjGCts//QYtG?=
 =?us-ascii?Q?zJg3WUu5n3tFSoEW62Q1q0ux0mPO6eyiXVMHsLZmp02yHWpT86z3xPvJ9mzS?=
 =?us-ascii?Q?RMFjauVGW3RElQUyXQcVmDwSR21m5fQwooAvEguS2S0zYjG8Or4exfVRSMpQ?=
 =?us-ascii?Q?FP/HDGqGzPsui7aRQmBD5xnMc2NN4kgTUFZgwemo8P0MlvOW/Z4utayvy8Cw?=
 =?us-ascii?Q?O3QJqLyLczM//BbAQDLVRf+F0+1d9m63rSZr/R+lAGmejnR0l+NGDSCfaYe5?=
 =?us-ascii?Q?WseD1PbGrKIgAJY5OVSlRrN0abm21eAcnh1jPaAwEl+f5BOxYAL9KA18A//v?=
 =?us-ascii?Q?GOyz7cf3SpAJBqlgAvwJPfLSJ+7+2T899tia5F1pgsQUrb4Z7r0YSmbjacHq?=
 =?us-ascii?Q?vPXZaepswen9jl5MeW28A4ocQyiMgelC+A6qw6pszvleMnADqveBJG2vMPId?=
 =?us-ascii?Q?nxT3Ubp4nRfDoS1iGU3ASIKt2CCA/HiD9oYd1TfigbdjPJi6YfJt9Ih4Y0uD?=
 =?us-ascii?Q?rVEtt4ZPhhsr+Ef0+F5i52fx0qZ5TPDKvNjqTBXVrSuT76Se0leoHXVORLk5?=
 =?us-ascii?Q?/BBs9HCTZMtw7VyXD76bZ/5HI2N2LrnqjwJQsPsGWmeBIOTz1JnOWm/5Wa7N?=
 =?us-ascii?Q?5ZpOjYkv/7BocX6XL6DkqVmgyTOqqg3qfXGFAweMl+EXQwZS1wNmX5ds3xsd?=
 =?us-ascii?Q?wH3c9bIXooLD5QHhR/kPOmL8SUJbPTn/C16mKXdXB3VDSfIRvmBK1R6+Zh5L?=
 =?us-ascii?Q?wcC1olMTSVQtD3yenck=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f49391-cf1f-49cc-74ca-08dbcc66bf78
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 03:36:27.6600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UF1PW+YrlVvDhzOITb0YJ8zofHhRsPcdxQAfpstdh26K1CnKu9iJBkwxAG5W7gKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8888
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test for UI_GET_NAME ioctl
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 12, 2023 at 04:05:21PM +0200, Cyril Hrubis wrote:
> Hi!
> > +static int check_ui_get_sysname_ioctl(int fd)
> > +{
> > +	char name[256];
> > +
> > +	SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(name)), name, NULL);
> > +
> > +	DIR *test_dir;
> > +
> > +	struct dirent *ent;
> > +
> > +	test_dir = SAFE_OPENDIR(NULL, "/sys/devices/virtual/input/");
> > +
> > +	while ((ent = SAFE_READDIR(NULL, test_dir))) {
> > +		if (!strcmp(ent->d_name, name))
> > +			return 1;
> > +		else
> > +			continue;
> > +	}
> 
> Why do we loop over the directory here? Can't we just directly check
> that the path /sys/devices/virtual/input/$name/ exists?
> 
> I guess that we can as well read the
> /sys/devices/virtual/input/$name/dev and match that against fstat() on
> the fd.
Seems no dev node can be found under /sys/devices/virtual/input/$name/.

ll /sys/devices/virtual/input/input13/
total 0
drwxr-xr-x 2 root root    0 Oct 13 21:32 capabilities
drwxr-xr-x 3 root root    0 Oct 13 21:32 event8
drwxr-xr-x 2 root root    0 Oct 13 21:32 id
-rw-r--r-- 1 root root 4.0K Oct 13 21:33 inhibited
-r--r--r-- 1 root root 4.0K Oct 13 21:33 modalias
drwxr-xr-x 3 root root    0 Oct 13 21:32 mouse3
-r--r--r-- 1 root root 4.0K Oct 13 21:32 name
-r--r--r-- 1 root root 4.0K Oct 13 21:32 phys
drwxr-xr-x 2 root root    0 Oct 13 21:33 power
-r--r--r-- 1 root root 4.0K Oct 13 21:32 properties
lrwxrwxrwx 1 root root    0 Oct 13 21:32 subsystem -> ../../../../class/input
-rw-r--r-- 1 root root 4.0K Oct 13 21:32 uevent
-r--r--r-- 1 root root 4.0K Oct 13 21:33 uniq

> 
> > +	return 0;
> > +}
> > +
> >  void create_device(int fd)
> >  {
> >  	int nb;
> > @@ -202,7 +225,7 @@ void create_device(int fd)
> >  	SAFE_IOCTL(NULL, fd, UI_DEV_CREATE, NULL);
> >  
> >  	for (nb = 100; nb > 0; nb--) {
> > -		if (check_device())
> > +		if (check_device() && check_ui_get_sysname_ioctl(fd))
> 
> Maybe it would be a bit more readable if we did:
> 
> 		if (check_device() {
> 			check_ui_get_sysname_ioctl(fd);
> 			return;
> 		}
> 
> >  			return;
> >  		usleep(10000);
> >  	}
> > -- 
> > 2.35.3
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
