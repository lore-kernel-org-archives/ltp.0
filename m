Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6789AC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 09:33:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA3F83CE77E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 10:33:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A50463C8BA4
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 10:33:12 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 616D2200B9A
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 10:33:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5V0iOSHc6JxxYfwNEzbirfVZW35IvzFC49jITtf06Z1NAlZJSpDP7kocwzAv4KspBD3NzWkS8NershDSvaMN2ntZTITv2PURy+1Uz2V6Fbnj3eYRJ2rVQ6s6buLCQjIVZQhVjh7Z/K4fgNHj8oKrAMN2MMQ3z3sxfj3GJeyPkKSUmPS+A+KB/q0a+TdNFPdlHtTeWMamsRBJr8btHkdnZSf9MlCq3G6k+R0QmM6VR2WOl9gxjAiTpg44jMasmtd6iUspplK+lPaR7n6DB4wE5GRTJrVkw5etiViXAHo0HYodp9e3w/rEmsabtqnw4gcU+aaC+GPwEiQWY3DLylYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ7uVRe7VGO/T1ESenSSwC6++95mFEbCktd/MhG4KRE=;
 b=VSdceZTEMqvThw8gpsUhJdiCkMnx3nn+6dX9Nm9u2t2FK+WaqQmwYsD/cc4qeZFp69pyLLGr/3r/zs3EB/j2LErycpXrrWrYEo4y4BHuRNCPVSFqf7KQ1KWZAEnvOwCPl7/lf2Gte4/MRblO52O1vEgu9pw70R9mtfIu9zULB6+QnICUdG0nMHRIHPJRFaV1WmgP9+Vt8pWmg70etSs4B1zKJvWoSjKIrSAPpQtOO7UK8GxqgtPqkjR3CiDFmeKtIGXVYwOA57BAzlYMDMIWh53qnKGPOQTwbrHDRY1MbJ9PUMCmIasKbNE0E4knGJRgRPardRAQfQWGeqGmRJiMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ7uVRe7VGO/T1ESenSSwC6++95mFEbCktd/MhG4KRE=;
 b=h9Dx3DLzUzq3elCwmulHPAz0iTX69rU/WPg1gkUc+3e0fGRIhetmj9lSsnMdTe2Wt/WHrvPYNUofWSTcfnJWOuiciRYC80qxBhBERrM+SLr5Q1464e0uHkjeA9haHOkKNaT5nlf0P/1zLG+7M0nALJ56J3rEG9q2KB97EPWuy1kKNh28VUlHxGBDiC9yfXehXF7priwgR3hH1r1l2+adgQ3OWg1HV/YFCPWYYuXZ8tefoYNpTb93CcIcnIoSx52sety5eN1HBrGZyR3sUToK0OzJP10SamdmcxNb8nt5aesZoKMD8y+jtdSFnhFNSFMocXXKZtH62ilo0vDd2uxhfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB9067.eurprd04.prod.outlook.com (2603:10a6:10:2f2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 09:33:09 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 09:33:09 +0000
Date: Wed, 3 Jan 2024 04:32:59 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZUpyz+/h8V+qb7f@wegao>
References: <20231206105318.11832-1-wegao@suse.com>
 <20231222100611.12661-1-wegao@suse.com>
 <20231227132144.GA740736@pevik> <20231227144839.GB757946@pevik>
 <ZZUZBfdTGaQ7huVg@rei> <20240103084425.GB1073466@pevik>
Content-Disposition: inline
In-Reply-To: <20240103084425.GB1073466@pevik>
X-ClientProxiedBy: TYCP286CA0236.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::12) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: bb83cf17-2a6d-491f-0681-08dc0c3efef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqDsea2kglI+kIkIKCkB8A+nPThDb3tp5qYkLA+19ptrjFKMXetyebYK3JO0NpZLpbOMu72O82VrHZxdDqhaM/eJNpmZH3PJNX6Ngx/zCxqgPRSr2cRCylvFogx5cPv56KLkkHTOoPNGTT7/uTAr8ydb33VBEuOOaxfoe7PmZblEtJPT3kdeXiLA3pEqRbYY4yCBUmBLRaD5n3x4LTnoVRwmmBruWXX3A3Jwr+f77pJDzjrVDgXHHN2Pz7m4P3EWfaOBkeKOCoFKFPxRLpYhLeM6/whfO++BYlbCvQ5VYZlWkkRTvNbmKBdAHEA2tKD84i5pDd9H4kUIaGAY8xx2gnEiYGnx0TIcAijlyfxu0Yy4nP4I3xNlPnjArC5nOB+G7B1GBq5kLOjXv5Qwtd8y1J9IHgDVRfzIEPGIWGbeQ4uxnJqfGAnlzWJKf5iMjdS5e9FphiBCQM33cxRLXDj3B0NZ+cLGlKfE64Ga44p2iv7GN1YzqM+ZbD/Qvb5/jWQblipYd685P5GmzC7WziuurUo44KihphmAXgiNxmTgiR1wFkKz7yay9LdDAtUKSbDrl699mYDUV6Wkfd3lPeTnDgBseeT/uuGdNXYv7giAqZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(136003)(39850400004)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8936002)(8676002)(4326008)(5660300002)(4744005)(6486002)(54906003)(66476007)(66556008)(6916009)(66946007)(316002)(2906002)(86362001)(38100700002)(9686003)(26005)(6512007)(6506007)(6666004)(478600001)(33716001)(41300700001)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59HU14wb4b9MBWr+vgAn2QjcTjpR/f1E1D4RC9q76S1zSsurBm/EsU5Dq796?=
 =?us-ascii?Q?dwpbOLeu/3CKMUdlLHLVHF3PNM64yYWrYZik5r0ZLc3iJMNMAo/I87Yi5F1Z?=
 =?us-ascii?Q?Ug9IFLFCkHwLAeXMYTIlml+2u9YiOL1ci9fSt3kEmTHqYqQtIO4dZpeI3T2a?=
 =?us-ascii?Q?PECzfQacvhriqz1ZcjCmD/rltpM2iWp1H0brihFoHDJbl53ywXIbR6TweuF+?=
 =?us-ascii?Q?TZzFyt+v/Xs4mysrvf6btLGGFzV8yCnYAgJwV6aTKx5dVgXwnSy/jsswk/25?=
 =?us-ascii?Q?0kdzf4Ld1iOEn7xZl0p2Gs6fR4VLC7UD/BLWkcdNX9GpjP0dbh1YylK45kDw?=
 =?us-ascii?Q?XKGgMZAG6KsQyHYF08r1LtuigfL/+d8rO/3yl+bw78kgs+6b7FIKiR1oWE5L?=
 =?us-ascii?Q?gB8aItpPEiIyJW7DP0oxIlh3q6EuJoFPNG5Z2Fwa2zprNq3TiWF9a/hPXEo9?=
 =?us-ascii?Q?M8vuEGHvz/E/FIyLmYZ7MAqe1+ULhrPBzrL10UR4mFGidXnhzyTDnGvgGM9g?=
 =?us-ascii?Q?ta/F7ZVT7ZlDhPF6yfcrTpH7/fNgmIrGVwuMpv6zXHmYmW5udiDVX62R6zct?=
 =?us-ascii?Q?efSbCThs+bVzBx+8rqkanHvH4aePbP0ikY6ZoKAhLFi7yQjJ6JdtYn/ZO50g?=
 =?us-ascii?Q?zzn9YA8/6VNj4TAE3cNeWzVbJL++Ex5xe7dASNQNyDpUu9AyEaraR/oBTc78?=
 =?us-ascii?Q?WHnoTS/bQxnVTu02Zbv2NDjIsDjh9Th+7xnR3GEUJw9EV/5qOhMlibk6HNFN?=
 =?us-ascii?Q?1xHotXIWHHqUtmWhgASxkqhrdZhUN2SRyb/EYTf35APvIp8jf3VPHXevyXzB?=
 =?us-ascii?Q?wRtREenUM5KHW04kM81FMoo7hYbOv4VO0TNeV54KNd/r0Ec25YEuL4aMwnhZ?=
 =?us-ascii?Q?gFB9Lc9YOeT3wJfRCgsVK6oL1LbVKnyFQoFIw04WcQ79AtwGmezsXUev8K+Z?=
 =?us-ascii?Q?X9deLNn67ckQ4FwGRImMRdE1oY7xUJ4CvC/M/tgBOTQmfdkUWamyBygpaIRl?=
 =?us-ascii?Q?baE5ruZyOy/GZbjIhzU0M2wepk8BVZEHJbUirSyl8ShtG+dnuGN2GEdccgC6?=
 =?us-ascii?Q?FdVA8BMw4yBQG4jsYQa9SEXdl1lvc4BxK5FYYzDsoKNxr3f1th05LuD8eeJD?=
 =?us-ascii?Q?kfPz0a86YK5pe8ApYPNaQ7aZIc40SJSNlarHTgqjfq4yx6/4MDoNtxPeNHAA?=
 =?us-ascii?Q?rCzZoRc4Z2jc/6MIYMKzM+oNJxHfEppgPm6742zjNJNln+v+QwVcorxZ3qpP?=
 =?us-ascii?Q?RUTeBSJhe74/Q3y4Gt9fBbgbZQ1rZy5HiEKSInwqeSX7Y1XXNTgVwRuI+JP0?=
 =?us-ascii?Q?AJa0YCmt5x1Gyv3Dfd7lLydjbl5oiDAUnam59fEZPJP2+wI+uNihxfKsNzYY?=
 =?us-ascii?Q?x1zoIhbtzSrlU5KZ030cJyy7uML9rye12L4bO+9D2vjh8MvSSDU7XvQ/RXHR?=
 =?us-ascii?Q?DsBpF6AJSqWeL61iWxIyt6wc5k9O5T2kEhHukwWmCJlYFkOZrr/p1vagV9/Q?=
 =?us-ascii?Q?4tzfJBNdycZxe8eLWTze0hC1/bl8T7TdgtVn6X7T+U0VX5LUhXNMysNuS2K0?=
 =?us-ascii?Q?sHrUyMCjYDlm3u4wwmD2zgLU+ivfyUioJEYpvrui?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb83cf17-2a6d-491f-0681-08dc0c3efef6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 09:33:09.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjqHfGV/jB8C6+U5pH5Re4Sv0isxMhc4a5BGARlpyI2NL0YEEpo9dDyq+hrf3J0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9067
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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

On Wed, Jan 03, 2024 at 09:44:25AM +0100, Petr Vorel wrote:
> Hi Cyril, all,
> 
> > Hi!
> > > @Li @Cyril: are you ok to test libc getcwd() wrapper implementations on NULL
> > > buffer in getcwd01.c? Or we just skip NULL buffer test on all libc?
> > > I would be ok to test it, because change in the implementation can influence
> > > lots of user space software, although glibc or any other libc can obviously
> > > change it's behavior.
> 
> > I guess that the easiest solution is to run the test in a child and pass
> > the test both on EFAULT and child being killed by SIGSEGV. Any special
> > cases and ifdefs are assuming something that is not promised and will
> > have to be changed sooner or later.
> 
> Good point. I guess something like testcases/kernel/syscalls/mmap/mmap05.c
> approach right? Wei, could you try that?
Sure! Will check mmap05.c firstly.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
