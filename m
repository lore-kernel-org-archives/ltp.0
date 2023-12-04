Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8608C4167B
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 00:06:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FB4C3CCBD1
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 01:06:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B18043CBDB0
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 01:06:16 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B6C921400BF3
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 01:06:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNuCiYO9ygX2MQ56r4CXx0xMfBlvc+KAbjFyssTHGEaOo7eS3nqo4vzYVy7aSYO01f8618yeaWLy+3/GsxpJEFxsaCWBBR73MoSxtS/UoSV4t2lMQs/M0+dwIewOCOJbe0wTPGgm6f9+rVhivMLocNj3e1P62XB4kblsDdLDYhITGkHQo98uxg3VVa90ov5fLk2UR5BzH0v+7smMEnARFPRO80jq4LWX1mWRdp7nP0wVDkuKg6rc3+HakacY/d3On5i6QnfAvxc35L14KxexFGiDfaHUcYI9S2krhKwO8VujQGX9zXb9/cLcuBsrIsjpwdP49aGYtmE52xvrfA8O8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXq2E8WhhTXjMwT9aXGiDWXDZZHcOtaBW2ELq32fQDo=;
 b=NvHxJesJdsqXRXtq7L/Ip2bG0RIZnvwAXnTYRF3mqlfRKXowKxAoKKnCRqF4h64N+ovO4WZEKviiTCt1crTdCfAwtFAXwacLZgB6n8aVs0LWBMsORsIMiTgjWQlqoRMwsp6CNI9WhVbWAkpfh6hSGA7FOLhxvRsARMDAsz/gmtx8neqKOmrp4p2phUmBs4BIP8nc/npH0Idfhx0gSG4GDiOsEZsISjKYq1AUptqskgWVfc6pXKD1xdlp/sLWjipTgg4REdMEcMlErzDMxDMheso8FsSqg4Yz91gbyrt5cNgVTt2gSAuYVUHMmAaTHlHIlwXzVIuTrXizmjl6DELnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXq2E8WhhTXjMwT9aXGiDWXDZZHcOtaBW2ELq32fQDo=;
 b=IQJXatpCeNqipY2aYsuZbKv5Vaj8USpwGqIuh+dYqvcCsGNwef/d8qGL2kdEkLN2XS5Tx5sRHxfmbugMIo5hnh5D+cBigIJYFwlLbv9j4+vs69Qg1MdZu21bIH+vyyna1GHSxUKbZxjDHNTOA2Goua8p6uV4fqEtKdwSy7WJD8Apw8Oyfn1YN81m4uDR0xgVXDTCTpNZCxDA26wUAPno9Lt13FBiwUS/WM/AJ2kwxF61s2ocggkUQYDGWHlzdaQlX7Tgun7EGHibzqXpB46NBYT7rQRStB17vMg7tNfuwJwjGiI2bOES4kyh2np//6bwLCZS68pmJzJ0yVpyWz0r3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 00:06:14 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.021; Mon, 4 Dec 2023
 00:06:14 +0000
Date: Sun, 3 Dec 2023 19:06:08 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZW0X8OkWwWKnr1x+@wegao>
References: <20230929004518.29632-1-wegao@suse.com>
 <20231201031512.27513-1-wegao@suse.com>
 <20231201101415.GB1710028@pevik>
Content-Disposition: inline
In-Reply-To: <20231201101415.GB1710028@pevik>
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|GV1PR04MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c8b281-db4d-42f4-587e-08dbf45cd430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFZIL1UiT63dzbB9xAoyoUeP9qtsTdAWq2ewcb5W5h3Ru/4h8eU5ojvxYGjdGAZ/BPxyjekoOOGCkOKm/68ULCqSey49PtmSw+vE7kqdcxYpB9iEjqRKysCARAUEuqVqRWBxlfK+UVtk6m75+I/ZiGTSgXIj8jDKkZy/wrw55f2XkO0+CRwmBaERIYP5Fb5N+NebUZNfSGgmrQt2R3sxWup2gxRdmMspMGx+oQpZ7x0Sd3irxaDJu9r2hP4yX+ZGPuTJvmQOU3RFgnDhQBbjkJ6hxu5uBViC+qmrvIU2nXbKvN4gAUeRPcOv54AChOXnjNW2BG847NEnZmlLwzxYFs8Pr8kdNFNAt3XCALZpmoeITuGi65mP/oXzxqdf/AvHb8VCW8km3drZYdoFZQARWrBy9D0qIUe6Hu2xdX8yEpkOLxY1DNo1LsnuCEzt5B9gm4MHeL66WNQfnnfEuzoEyTN+fXbV15lYfvb8rKeJW47uZFhvELrsjWGTZ3OJZ2rhgUBPXVfat69WFLXIxq+S1EwuVWn9A7E6VvWOgReTjzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(33716001)(2906002)(6506007)(6666004)(478600001)(966005)(6486002)(4326008)(8676002)(8936002)(86362001)(5660300002)(66476007)(66556008)(316002)(6916009)(66946007)(83380400001)(26005)(41300700001)(38100700002)(6512007)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2rfIBtMgmVRAX5rwctFMAoJj8I36r6utmAf6hX3XMiZ0GkU3Mwm7Q46qprI?=
 =?us-ascii?Q?e0pTVjlvUcSDsoH3wokn9rQBYuxawcW5iuxkox0+CzMlNj0fXJzsp4mImIwr?=
 =?us-ascii?Q?ml5BPHRlxLuqYRi+/MCZrgJBpvr4azzxdqT+DLPlfD5bdoPCp4dib0BXEYMP?=
 =?us-ascii?Q?W8on/mtjv64l4t9Xnd5F2xdutUg0zI1Dxo3fjHAK9E0idQ07G82M020AIyHB?=
 =?us-ascii?Q?7AYls0BChkzuk4f4XqX9euk+tMfSzQc2gUTbu5zPah82ZGrPcT3K4cPIyE/5?=
 =?us-ascii?Q?CRxuZq4b8bKEyjxDFF5l7mGqkOs7eJ+qUMjhokybZVw45I2foDLlkCoVEkYH?=
 =?us-ascii?Q?BEJY9et0YLra6+wgL3wZYbYLRS/NRneepiz4JAFoCnql9Uf54oVUaU7pNLPG?=
 =?us-ascii?Q?98dJwyMWi9fbaG+6W2kV2HOFibOsQDFKlNkOp7U5Qiy/01HXjIkqhtSKnqnj?=
 =?us-ascii?Q?/30kDPqHr7x+w7Hg8KTentUk66BQE/M/z9Dbp1Qu9WWtoO2sqd11XdUB+QK5?=
 =?us-ascii?Q?T/ZauVcI24vdBZx8EnocPwGPDMK7AGA3zCKas7VUXa7KZxwUqmxIfr8ELo7m?=
 =?us-ascii?Q?vXaCHYHdzJ8cSH+pFtQ/4ROoo9EnGiDIFx/4yHFi6imn109VdfD+WW80F8ph?=
 =?us-ascii?Q?iek1tbUR1GHNzMgOSml6ZcB6TsAyuSSwsn5BRdc1bUxyd8MQNAZpVqICXdgR?=
 =?us-ascii?Q?VMX/xTmGljny875SkaK0oTIymQQLdXY3wT4OeS5c7DGqHwJ1YPXuzMolYNyV?=
 =?us-ascii?Q?aOKRqzaTTeUMmm/y9sVX7vyDyc9mw6ySNN64e9GO2iWsgz5TGCs/+lhdkBA2?=
 =?us-ascii?Q?P3zmBM808r3af1wzbqYLjlXi4eWduvz6PBbz0YSF8J+A6lXN3U3LbqSPHeCu?=
 =?us-ascii?Q?WHu6uZGxe4Na9muB3EolxXSLWJSsLwF3Zp0fxElXwOLSpHL1vrLYOclJXxfi?=
 =?us-ascii?Q?A0Y7VSIrKN/lmAQ/V4CdV2yjLfsbjBg6lh0OqnTp9NNrhAn/Ger4LxkSdxK0?=
 =?us-ascii?Q?QubWkwuFCEQ4sI25P4XAFIIub418juPz6AqHYQCPOLp2ATvnACkRsmg7mfUG?=
 =?us-ascii?Q?cSPL8aLUO0chYDFL3jhK5EOJ93XnZ3wNF6+1NxUyl0UVRNt4Jo4gGt7JGJEh?=
 =?us-ascii?Q?YrGpJ3cpNXP5gWE9/iiVAK5AjSvrbz2iA1zZ3YmeWJUWyhhqPPfxeEjvPjBS?=
 =?us-ascii?Q?w+y7gSxp1mNmNxOGE8Frxk+a1TzhtZgn5uEIkw2Uognm79hQROb3UfQB+i0s?=
 =?us-ascii?Q?+MrICWmUTV24QwbRqL0Jg5DO0Nub0F/NKgDQTmlPXfauDW5wPEjfOM8I8JKn?=
 =?us-ascii?Q?G8BXOWQDavlczfoumKnGqPKdGSSh6Tq4bH1IxFWjIp2Aa+iDYlgYVFFC+2bF?=
 =?us-ascii?Q?osQimP/jMWA9zkbF9/UOBjV7+xir4h7pYB5k53upYmYkeibHW8rQvNMraca8?=
 =?us-ascii?Q?1Jbiix5FKGSWqVos9hxQKl1VIsvoFVB0YT6/BthaghahZCK6Kxz8tEdLcOZc?=
 =?us-ascii?Q?feUxkDyFc4O6YQRQl4NjuEeQaNAj+vwsvNiMgoXDv9xW7jnodT7XQDY/hUPa?=
 =?us-ascii?Q?gRyEwxM5zZhshB0VxWk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c8b281-db4d-42f4-587e-08dbf45cd430
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 00:06:14.0674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DvwKQ7Jgs0BKdyMHM0hRldgwvFztcKs2KIzuqqJfK45pd+TCjtTGGcDW6VlJ8u9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] getcwd01: Use syscall directly check invalid
 argument
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

On Fri, Dec 01, 2023 at 11:14:15AM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > Fixes: #1084
> 
> > User space wrap getcwd with different implementation, for example
> > glibc will directly input parameter into kernel in normal situation
> > but uclibc-ng and musl will malloc buffer when buffer is NULL, so for
> > uclibc and musl the parameter size will be ignored. Use system call
> > directly check invalid argument can be a solution.
> 
> For the sake of the correctness: there is no malloc() in musl [1] (nor in the
> mirror source you posted to #1084), that's only in uclibc-ng [2] and glibc [3].
> 
> The reason why musl failed was already described by Richie and Cyril in #1084:
> musl ignores the size parameter when buffer is NULL and allocates it with PATH_MAX
> and passes this size to kernel.
> 
> Therefore I reword the commit message.
> 
> [1] https://git.musl-libc.org/cgit/musl/tree/src/unistd/getcwd.c
> [2] https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/tree/libc/sysdeps/linux/common/getcwd.c#n38
> [3] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/getcwd.c;h=5b0b6879ed28f278f07ce494f9be30f504757daa;hb=HEAD#l47
> 
> ...
> > -	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
> > +	TST_EXP_FAIL2(syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
> While syscalls() would work everywhere, it's better is LTP wrapper tst_syscall()
> (it TCONF in case when syscall is not implemented which is I admit nearly
> impossible).
> 
> I used that and merged.
> Thank you!
> 
> NOTE: we should implement .test_variants, where you just skip affected NULL
> buffer test (it's enough to test it with raw syscall). Please send a patch or
> let me know that you don't plan to do it and I'll do it.

I will try to send patch later.
Thanks you very much for fix my issue :) Will more carefull next time.

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
