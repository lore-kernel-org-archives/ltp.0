Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8783CE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 11:31:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 484623CE21C
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:31:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05363C5AC7
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:31:10 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF6F620093F
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:31:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvbOuFz1qdUF7jgVIwHI5CUejIFEE0AEOzwMfQqbVR7dZaUklv1I2YsS/CFQG5pjaeTEE93dvZGSykDvBHw5OGaEFIr62RP+KVmGbJPcKNUdOjhiQ2vXILReYWDscQ4m0nx0ew+YNIrInthSKH3a1xQpla4zES+XrBPLq5Abw5mLxJrUydR1zeXUOeMOD0KUlwu64dMFSxevHVL7Omc3qLf9wvReog6fjJxDzTNTDHhtMMHgaNFUBxRd0tcMovbS/fbvS33qb+hJrZ4hOmkQdidrMs2SKfLONJdsRL0c/dPp6QuUkWFTGyNvc8nDsNmaAaTUwBqNPtry8hHRKCZ6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bXgZIYRe56FFK+bFHqpapjMXpZagAumMCeX53ULa/o=;
 b=dTEp+/PVyAH3SU4cP+5PlEdxUaBIHBD9YXV4XTiYdkWwsX7a8LFfifdrCIYAT0VOf22/NzkY77lpRj5UuAHPg7VEJrGng5ZyZB+AlAN92w8/S5koSz9LMjetMzi4usLjROyyWV1On16qzsGEDmYR2K4Mv1NDipRhQm8kFro/dmqTzM/VsxKI3AFJoaeo4o0xvFo2h3NuJnqRfYz4S9uLeEpvsEXEqtw94zXFizZN3ugkUH8zQhb6kdL+1UljZthZ90tyvVTqwfkkZb7Ll6q/ZJvu9+91IoNpfdm+hHYBDxkE5g4RJLmCE/rSX5Ebi+0LZ9o/m8vKoNRy+K+2O/70HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bXgZIYRe56FFK+bFHqpapjMXpZagAumMCeX53ULa/o=;
 b=bf4ktROWQe3qPlASXlFKaoFfiQAHqZ+sylzqBJYgBdxRSjwXBO2JzFX16tzm+fJcAKwYb3e92sv7Gm2T5SH0dr2yPjoNlYYlBZ244wa4CNmaLsuiC7QWL5PmVUs6U2EjeGBRvg89I0N7zBIYpbdj8Jjxt/lN+1Em2mBsliL8RTPwZcPw4IOO50rKZpE6eicTY9E+GDLZlVuNrLNmyIGnDd3cLB73eUzF/sE31dZRao4kqm4VXw4nNVhdUnLsvdec/qpP7Ct+RvWX1Chj4irzDsONSXBeWUSp7p5DgyuVBwGtUsaCBt/5MV+fWHNYTA6JEMOr/k6SrmzUTcAWFmoFdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by VI1PR04MB7021.eurprd04.prod.outlook.com (2603:10a6:800:127::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 11:31:08 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 11:31:08 +0000
Date: Mon, 25 Sep 2023 07:31:03 -0400
To: ltp@lists.linux.it
Message-ID: <ZRFvd5LYlAiIJCy5@wegao>
References: <20230925110422.19167-1-wegao@suse.com>
Content-Disposition: inline
In-Reply-To: <20230925110422.19167-1-wegao@suse.com>
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|VI1PR04MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 71588ad5-d922-4b09-1fe6-08dbbdbae950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy9tPHSYKg6/ysuVPkSAWx7BBX9QIDzFUVvXhqZkixz0JZzNZ/3mX2SnnPC93cchH6BXqxZsBa0qcE8O8hYgk5VhND7klfQBwphBQYj/jbEp/LrBHD1Xtde8UBfU2tn/2Wyd3GGelpdvyiVRubB8e0awFwU4pXVrNPGSCJVxAuUMgfgAcLjN32I7rcNxEB96IPfPmgS28ElO9Jf/zpYgP/egCJ8P8nBu/Oq3JEAkYX/yz09hPVUWFRdDrmoadia24448LBneiRolqWMVRyhUshPhWGwriOdJQodRc1zDClf/VH2ABhyF0mMcSv5l/yn9AZjUupFz2lpuyA7GR/X0/xzgG9OdZkTCkqqnBE/4bQPTVUNvhtStvvVumnq3cfL8uWLz5gUeD+ia3iIhHhcsUeB54DZYkg4RTBzgeNC9vrz6MslddEkBgUtJVKRlmF9XnXLkdnOaEuWgs/y/af61MNIsBDcIINxwYFGQIxg9s2P6kiOnw12bCpPww1XGCDpLa8z9/SjCRur69eM3A3LaaXGdfp6XjheCNoQGhmgChxQ+RTg0LfSDx1I34ElwkMYw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(39850400004)(396003)(366004)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(6512007)(9686003)(6506007)(86362001)(38100700002)(26005)(4744005)(2906002)(478600001)(6486002)(83380400001)(8936002)(6666004)(8676002)(5660300002)(41300700001)(33716001)(66476007)(66556008)(6916009)(316002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMa5FI1xzPNGLpiMu2e2rlv/0Z+Qwf+P7CpYHPzNOu8Tya8/sOynuh48z207?=
 =?us-ascii?Q?nDmopuQqPsfWNKynjQe1E4q7ZP+zBKD2SDTPXLU+7MT7uSbsFqcPc+TLFAiz?=
 =?us-ascii?Q?NOX4ETDzRbeD2aA0gpsrIoq+0G/UL0CjoT4ybBbVUCNiz8vMwi8vqV+R6ODi?=
 =?us-ascii?Q?NagP+w27vsEk8oJE8KTwDm6na3Ojm95Kt80rTK2QB1KWcARgg1EC9wcwdsCQ?=
 =?us-ascii?Q?0HEj2I9UPc4UM6iUTMRXiWudQPLg8Z3KsDhhyvZ88jwtWkE4VF5fHKxbRyCD?=
 =?us-ascii?Q?V2KvyQWB4sxHKqEGoDOTRVMtl+8hbI9A8czexQHs3oDXf1XORFCCbupXHD1N?=
 =?us-ascii?Q?h8xj57bT9B+4I0O1rm11SzoVH7Mai+vZ3lDErxEPmSDyNjJjtR5glLrGmuF6?=
 =?us-ascii?Q?yTzPVvLlrmbx4lGGLsNznMSt52W5hk9AMp2STAWh7zJMx1roaPMY4WvvNV8E?=
 =?us-ascii?Q?KhkoDBM7IthMowf8Oki4VeeRRcLC/iiZdqE6MnbE5ZZWfUGKv9zRmi2Rf9Cb?=
 =?us-ascii?Q?KfYZFdhw4o6RFXYrBOxA6Wuj3ijeBa0+QWPSYuEoRY1CcJyK4ugeWERIi9f2?=
 =?us-ascii?Q?L0vwZIJzyQgmXqXN92EH5ZnwgoehcB/Qc8kB6tEX9FpvCvPED1SzO3cnnF79?=
 =?us-ascii?Q?icUeOSKT9vIf/uS6S0G7ZMc2ULIbCXCbobIKRjlIYRcM00DWEINn1nscFPD9?=
 =?us-ascii?Q?GKmL2NEL7pFqeJbHJDIKWqnQcv2/fKwwaqcwBQ7ZZ9SY+HZ9s/0M3fp8fAbY?=
 =?us-ascii?Q?T63U2kE1u9oAKp2jzQeaM9aVLFMoQ9Eam2sM+/WN9CWxxKypUF6NCAAmV3if?=
 =?us-ascii?Q?jZWtwevI3BfW41+WmaFDtQULbKfIO4w1I1pFGvFjLiW0IlYQ/IKcbqg7eAIT?=
 =?us-ascii?Q?wNWz3TPQrtSdzcRROFeSytzarpmcdu2cwGjI+RspyEm/J/bO/sQAcSJ8I50M?=
 =?us-ascii?Q?i+3hR2Oec2UiVYNtJyfawINdyqF+cz/al5DC9tEY8zcORumQGrTfmOr1vFfJ?=
 =?us-ascii?Q?LxJMDiqvbYyDU29ZEeqCYYuaj+CV2KSwaahpdxFFQoezgcLCJYyTidn2pNfY?=
 =?us-ascii?Q?qtlKh+d6oeb9qNIdaBKNnNm0wyBMWs13WXgY5egbMrr6Hls9axPLCTAZsubW?=
 =?us-ascii?Q?duFrtPV7WVK9jDjgFM0kACEU4ahOm1G+DtUZKja5ulBupTEndGmZigII0Wr7?=
 =?us-ascii?Q?EsbvHfNVJc/SqdZmncIOkaK3MyE038nRVOOk4iz3L/9+ghhatDxRRmPuWaG5?=
 =?us-ascii?Q?r0rqCkJAyHHaqNDSjcQl8mYNDxy2gQC2HKwW3fbDpNNeF2/5SpqfI9GfwBgd?=
 =?us-ascii?Q?X4dEIeiss8YYJhM4xmZDAwJNyygR8K//KWakazw0HuAoPhvK5dEBWKrNmRNo?=
 =?us-ascii?Q?0/3lDil9ek/YqISlEeTENKZ5Jr3L4J5rYrLfd7SvzxxBnpYJ5EVlLjK73Nq0?=
 =?us-ascii?Q?YqS1rmqPNh+3cNJoSAbFyAZshs9CBlboORXnUKMLY6oWdFFeLTZBGJ1y0TdC?=
 =?us-ascii?Q?89BXrgp+1mDIMfnanGJctiTywZzaBG/wFs5S3CvgHL6QucpdGwyZ7i258Vv9?=
 =?us-ascii?Q?FwMvu9KkIp7KLmToDnQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71588ad5-d922-4b09-1fe6-08dbbdbae950
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 11:31:08.2139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+l0oi6Zen9BcUOFW/jYTROH3XcvIYNJKSemwF3bPmuiW1A5XPzpx1I6HXR2h0eR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7021
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/2] factory
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Sep 25, 2023 at 07:04:20AM -0400, Wei Gao wrote:
> Wei Gao (2):
>   seccomp01.c: Add SECCOMP_RET_USER_NOTIF check
>   d
> 
>  configure.ac                                  |   1 +
>  include/lapi/seccomp.h                        |   7 +
>  runtest/syscalls                              |   2 +
>  testcases/kernel/syscalls/ptrace/ptrace05.c   | 147 ++----
>  testcases/kernel/syscalls/ptrace/ptrace06.c   | 306 +++++++-----
>  testcases/kernel/syscalls/seccomp/.gitignore  |   1 +
>  testcases/kernel/syscalls/seccomp/Makefile    |   8 +
>  testcases/kernel/syscalls/seccomp/seccomp01.c | 456 ++++++++++++++++++
>  8 files changed, 689 insertions(+), 239 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/seccomp/.gitignore
>  create mode 100644 testcases/kernel/syscalls/seccomp/Makefile
>  create mode 100644 testcases/kernel/syscalls/seccomp/seccomp01.c
> 
> -- 
> 2.35.3
> 
Sorry for the garbage email, please skip this serial email

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
