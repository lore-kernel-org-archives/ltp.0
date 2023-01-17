Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F300C677F1
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 15:19:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E0FF3CC8E8
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 16:19:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFE483C53E3
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 16:19:04 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EDC92140035E
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 16:19:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv4tPPrRhbsAA77jJ9YXuJZLuwOqYmx7/qITr1fb9dj9bz4xCe8CvBUMqL9oeORa3o1dhgtxVInlrrqsId85i/EXNxCbWD+JN59V3DIb4SHn0sS2PbUaf8epSVoNKPdk0aouOStj90ljE9CSe8B36czK2RuxDXxbleJMtx0v7uJI6McdpXmvLOMJOUwIq/xbvS0VMRbCdwU91gKGSfR00zZUy8VDFSzaEFsZNd1vUdzTS7xAGyslBYmiAHUKT7CUZPwT0OQUkU53lB831sUlr5rC/YNaMjKovsSZWCovrdD9uEzOAhBUc6vXW4aSgZjh6WMSpTpFoVj3WeQLXpF7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4DmnUv95oa6tH1/etTASdw97O1XeboZyJeZL/MY1w4=;
 b=emR0Xtp71OVeSdyjkqbnOcC2igO2xsXL7bmRZYWzUt5DLzQKAhqqze682US1hvDWBcCMv+SKwqCn1fPjiira8X6R0xu7ZNvjWxG9pJP2wpPUIapJSVynV6ueucBLp1CJLNExAlZDg+5Belu5oLSM06K/pUAcF2sgKvCyM7z/t3HL8SC2tD7F6c26CUXjQQElOmtm0rEIsbAYMrrFLCM3a5mKdmQPudoPBGI/8fNtKBBk/WOGjjdy/UbXUKIGElfzV/vgy1cHkTNRZT9774WjkHQ2u7UDBubnjgdNYVfTsNvs31SNmkKaFmhc1ttyNNLauOCqCKJpyHOYXjU8ZhnDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4DmnUv95oa6tH1/etTASdw97O1XeboZyJeZL/MY1w4=;
 b=j3eb4LalZIejkcCWa70sXkqNEgqiKfon0pCFW4V/F01NtvNL82EBdHB4jZKSR5Lr8rZFjE1pRFQ4UIsJxD+1wE6XfF1xqJQAuhcP3bG9xCEwzRR8QaZCFY81/2+qG/1peK3Czz66dITUq3Oe7fej9k/5FYdOqPgrqSashm+N5NpqaxHhgEWKgygDWF8kSO3CEnT0G1+ztoZYFaZ1ibW8a4n+bhPMt/ngwTRnZgExd8mqHXc81DXX5jYrRoqjylpr+0xFn1qwLbJDb3p8fUkp42KDZjOGr2EG2UfP9y/qtlWAg0Bxt6v9+q3G20tTwEZ9Gtvjs/Fc2wsGOkQV0IjA8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 15:19:02 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%4]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 15:19:02 +0000
Date: Tue, 17 Jan 2023 10:18:52 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y8a8XH5TVsCvzhCF@aa>
References: <20230106113126.5304-1-wegao@suse.com>
 <20230111195231.23596-1-wegao@suse.com> <Y8EnKACJtJJ80uw+@pevik>
 <Y8Zbpfq8xcDZ2uZI@pevik>
Content-Disposition: inline
In-Reply-To: <Y8Zbpfq8xcDZ2uZI@pevik>
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9433:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: b6415460-b010-466b-3a53-08daf89e29d7
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPuRgNM64NjaQrPs4f/WvrYM8Ai6ZkqPIUDY99MzjvPy1xUORf1Sv/d5Y5fDAmm4ZE/WmV7A0+Lu8BZauFaleZkBmrh9dqBGgWny72fcURucD3HL//0wG4IlBCni8nLnwk4ljsTy6m0hgW++VQ0Zskvnry8lkyBFTeJ1+mP/mlD43pDhNfhVtrMVOjahqJNYPswQ2i2nNOBHI0htR8Q+A3xectLs1WRNFaEhFXvuoH1rUhEQlUeIYWLWV3kCms6Vkd/3aEjZK9qZzOH6vif38M2msFDkRBVx5AxBZ66uWmx8MAjyAvMwmJuw6T3Omv7+J98rnn9k42ZzICfMcZkzxJdM4GVL0udoc2fcUNbmbxt8QQ3+Hga7pwOxwWbC+9Gtj/5l+r8ZNSYN+2JSo3hs1j9uHdVbdmL+cStd2Q+R2DwktZ4tSHHxeVVOUd1OpevWNqt6uBkRR9iYjYTiysyUyLSXS3344mVokIcN1w9itxN6OqJQNzqgPb4AvenjbWdnm85o7oJioa3V58wMpAs9DXW7rETcBfmULYbRnqXGTrN5Dv4+oBA+dZPjrnoXFilaFx/a3JcOKDde5OWmMKDe2pFKsdbuSkJCDrCtmCoe8YDE2Ro5InhQ4Lsxv8w6mInZsb7tkjd74WVnIGFbj6r5bDd12E89d1rUt+Mgnha1R3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(86362001)(9686003)(6916009)(66556008)(4326008)(26005)(8676002)(6512007)(186003)(66946007)(66476007)(41300700001)(6666004)(6506007)(316002)(478600001)(966005)(2906002)(6486002)(38100700002)(8936002)(5660300002)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?igxAg8pvYOuRG+eMuOy9vtSBWbCi582aUCdX98EDhwhvjBySsJZf3v6jWhoo?=
 =?us-ascii?Q?N2RYma3KlRox24P7Kjr1gexWxHa9CSyK0SESEzGi8Ewe498M43mKAYzUP9F/?=
 =?us-ascii?Q?bJWGtkGjEx/WBIjL31YYESHFaXQXlXye3tVv/4lIdyNtD6XcaprTCCuF0pGx?=
 =?us-ascii?Q?1NRP9xUnPhPd4mOjv/2y++HRbB8l7zerjwgoi/f/zdbGZjWclW/MxqBifC1k?=
 =?us-ascii?Q?cxS+/k67PdZvSi7eDVUN+KKiHwD3aQMB1pt7lczg2cxoQw2cc9WJPwqHjXA1?=
 =?us-ascii?Q?tElwrtMZhr6VRwb2HYRvwkAAc/nXkyQjjUNKBV4jSp4zktVx+sq8sygWqePe?=
 =?us-ascii?Q?uqh/QRrrlp52uJbR9P17duMkx3SkqNHztGtuG8zjZWHQgSV35ECEKuep5uXd?=
 =?us-ascii?Q?yoavmhG7v5POgQb/Ypm9AhgSGszWzTUt3OJLY2tJKXkg1vvNnXpT9vGMCnSX?=
 =?us-ascii?Q?yBhVkj5pM4xeeHSnoKTiDgZETrongLVrj0uy2bcJvW09Ke4c/tKMHf6hPDdP?=
 =?us-ascii?Q?RVYH23zifPP2aWPFhdy5jMtKkEfh0fsf8evxEOesFTpM2gMupEUeslWJRn2M?=
 =?us-ascii?Q?fXbkdKmukk4fJdGRor4gI7kqH4Ojh2Unat+yXJkkumJs/Z0ULC6qmedtJ2s2?=
 =?us-ascii?Q?HEQ4WGMmQy6Bk/zn5uBgXnE2H3A5nhhCzTJjaUZNkY2MMFX5/gNt9R+2OW9S?=
 =?us-ascii?Q?ex/RLIPFn9JZG4pKUUfydbMabMBp5dVGWwljpieIXzLtadRn37HDy/jMKGYU?=
 =?us-ascii?Q?u8f95o17sMsvh9CVu48nC/wrx02nA5iZekXbCQCNTd4Xd1tp7t6DxoqrXXPl?=
 =?us-ascii?Q?rFePrkW4LZwn43BfwSVXRji7fa8oe0UGkvVF7tvV48Cs4+0lHWsy2fiyjNCF?=
 =?us-ascii?Q?pq4hSSeWKcx+MJBFDLxzRljsA/aMUt/RB3x06ZZmvzhkqxB84JDiGcNXBZDA?=
 =?us-ascii?Q?fU26V2nWn2DZD9o3QwBx3jsWtzaj5+jU8ucJmTMt7TAs5wJY6Kw272zy4GD2?=
 =?us-ascii?Q?L+VdhOIiCPB1mYHQaW8LZmNs/ogqJdQWOqF7zUd4tLYuT+NnAfA9dZ0NleFg?=
 =?us-ascii?Q?OoJxEf14ag7IHPAYzTP3CPH5vF9JLAnnQE+XWsAf9RD423YsdzgG4KYB6GlU?=
 =?us-ascii?Q?xw0cUfmwuFVuuUjZYk4dx7g2JOE6ZOa7+rqOh0wTY2HBw38M9tNWP1D0uMSa?=
 =?us-ascii?Q?OECyYeuclnPKIH4nhCSGk69iIQD+TOvJ62y4vFtnAM1Pcw7zioJvfNryZxyz?=
 =?us-ascii?Q?7fs1mgSM7+b/RiZGnuW2NMlYSS6ZXCXpl6EB/9KGqo3FK3KIE0kOFOtIeyg2?=
 =?us-ascii?Q?52LRQaPjU0X9+RD/QcGXUyTWjHrl84aR7/mA3Idb62Ec+YYRA/2ries+l7Os?=
 =?us-ascii?Q?j6snSswXVZogh1ufX0u+XGolr133BjloISJRFI9g4zdlsNtJlWCjCzmwQm/Y?=
 =?us-ascii?Q?DkYG4SQK98GfD+oI1kH1jNLKWa7h4FQPr6jDL2+Xv9qj7VYqPfW/hO85tTlR?=
 =?us-ascii?Q?uPr9jgL3fR5aIMOloJrmhtkq9W9gH8JHp9nDXjBSLTb8TzSXlO6BrQUQZP8N?=
 =?us-ascii?Q?fxF32IbGA5RdT8n44Ug=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6415460-b010-466b-3a53-08daf89e29d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:19:01.9182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5UXdOEZCbDv3XsiahjAb2gNWFPEiGqEkVL/j+95fA2QwS7i+BINg7EeGK52W21b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add PATH to tst_rhost_run.sh
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jan 17, 2023 at 09:26:13AM +0100, Petr Vorel wrote:
> Hi Wei, all,
> 
> I at least once reproduced the problem:
> # ./tst_rhost_run.sh
> RTNETLINK answers: File exists
> tst_rhost_run 1 TBROK: ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2 failed
> 
> I can't reproduce it now, let's skip it.
> 
> Unfortunately there is another problem, which can't be solved with adjusting
> PATH for the test, because also remote end would need to have PATH adjusted
> With this patch and with your another patch [1]:
> 
> # ./tst_rhost_run.sh
> ...
> tst_rhost_run 1 TINFO: tst_rhost_run: cmd: tst_net_iface_prefix -r 10.0.0.1
> tst_rhost_run 1 TINFO: NETNS: ns_exec 17258 net,mnt sh -c " tst_net_iface_prefix -r 10.0.0.1 || echo RTERR" 2>&1
> ./../../../..//testcases/lib/tst_net.sh: line 1027: sh:: command not found
> tst_rhost_run 1 TINFO: tst_rhost_run: cmd: tst_net_iface_prefix -r fd00:1:1:1::1
> tst_rhost_run 1 TINFO: NETNS: ns_exec 17258 net,mnt sh -c " tst_net_iface_prefix -r fd00:1:1:1::1 || echo RTERR" 2>&1
> ./../../../..//testcases/lib/tst_net.sh: line 1032: sh:: command not found
> ...
> tst_rhost_run 1 TPASS: tst_rhost_run is working
> 
> => test claims TPASS, but it actually does not work properly (false negative).
> 
> Therefore instead of adjusting PATH I want to fix it properly, i.e. moving
> to testcases/kernel/containers/share/ (described previously).
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20230117040132.5245-1-wegao@suse.com/

Your failed case already not related my patch already since failed show "sh:: command not found", could you help check env such as
"which sh" ,  "sh" normally should work in default system PATH, no need add specific PATH.

But yes the test case claim PASS is wrong so we can further make improvement on this kind of error, such as add further check 
for "sh" command then we will exit case and make result failed. I can add more check for "sh" command.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
