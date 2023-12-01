Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C8C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 01:07:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D6EC3CDC38
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 02:07:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B8693C88C8
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 02:07:01 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9A3A600F1B
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 02:07:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBt112TOK5cMNlE13YBT89MU53l7HhDspPTfqNl7+qikvcq6lOZGtEZtUgurD0d5rnEpjEshtA+fmf83kiS09ZY29WZllC3utWgX0vgdfHGx9eAxd5uHPfmmF3UKv/rLq54WVGoeqo3ELrvEcZ9RJMUOdaiXf91dUw4xjgcKORBf9D/ez+8FiWARiy2jBodfXx4r78dkltvi8odGdVP0M96qfRjwHzWiLcjOFlW7o/A+t3pG/I/ud3ZQiUTs8xXAJa3RMjfL3EwbMBYh3f5/deca3Td2OA7RNW73QhcOnr9Xxzl6KS6rknOtD9mS7C5dFuTl1yDnrCgFYdPmRQH/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKCpaeilWwhD0JfyCRjlUG6Rbsho/GfcohOjAH0SSuI=;
 b=L4af3F5lNksLNTTmv3UnbLBcP4XyCvQzOsWQWcGID4EHXvrnRZkTzzJr2vdmyEhWPfJZVlXFSG0tFZwksPECs172kvjhO8+yS7BbOn607x1+eFq5J812BbvR+30WpwDrKzqPkL8HlEN5sX4EJf/ZGVDdu/5QA2ZldhYyg3aeQskfCeVeB7NtPeC8kEQl5r5/XPlJhCHLlTUsFnPzvhUZ4Si5enpWgyy0TuUT88o3vClspeVFfR8eHwkPRT4C1jF7Ef1dScrk3v0um8Az1k1DIZ4sV3M/3L48WNanNXaWkrx/LRiI+OesRrgI5aYIQ3FuMwrZODvWnJJIO4Yo+TZS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKCpaeilWwhD0JfyCRjlUG6Rbsho/GfcohOjAH0SSuI=;
 b=JQ+O+ypQjwwzkrl8sNsvwCqQljZa6wqjsvmw+YjS/TA0glJlz0mYTIfLd1rLehpyhQQnc9b2nuS4/1BATqUXfosroHOrBGt5zTl+uECXhVcUOf+tSK/3J1XR6s47nzmQOkk0Mw3Gjki6PAFT9YF9f/ze5xXYJfe3VEg04Izlv9dlpOdrI+urdsLAu4zZWtqzxdAixWq3cx+l9A5zWDeDyOPk6y1b/0h6AoBUcgY4384f+Q1HSFy4/tNggxpXKG245DfeviRN46iQEaxy2LWXOBBsKES5TP8v7z7w6s0Q1kw+CidDUqVrB1jS2Wz/dpwa4jXdTO57TR4OKWjmFXLoiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM9PR04MB7650.eurprd04.prod.outlook.com (2603:10a6:20b:281::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.11; Fri, 1 Dec
 2023 01:06:58 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 01:06:58 +0000
Date: Thu, 30 Nov 2023 20:06:52 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZWkxrP/BhuMgCbmL@wegao>
References: <20230925112245.30701-1-wegao@suse.com>
 <20230925112245.30701-3-wegao@suse.com>
 <20231128095149.GA356525@pevik>
Content-Disposition: inline
In-Reply-To: <20231128095149.GA356525@pevik>
X-ClientProxiedBy: VE1PR03CA0042.eurprd03.prod.outlook.com
 (2603:10a6:803:118::31) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM9PR04MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: db79c575-f4b7-403b-fa1e-08dbf209d171
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1Jw2NCvboZBnM8qAJ2KwgP2hXXpZYLGtKuDgUxsJRFWBUYJ3LDTFMjlv30ow6uJjq0pxWiMv/+WAdbVsKTsfGMpScgUizlrrqaa4aH7+AggtFOz+scKShVvdpJL7lOZPXxsnj/p5J+XbVeOO0UIMj6n2ga3ZCA091/mg2yj4rXf7VN49gRBHZSkGqXY64mG5U5d9St0x9Um3TgnZddjRACa8u1Np0h1l+qB9iYuTS/22gjKvLvQ4BtywuKNkAO70cOoqJWkqHqOTUf6lyjnbhbmd9uYcvaVsETAv3OEmqX4Vc16qXv4xuawo1WBV9i7Ev6++ho8s6eLU4YEyZ1IbxoyH3/P7e94q/L9aB6D+VomQ9OjH8JNVJ2dJXhjIK3iizJzLFjV5IMdiOEBBBDylO4Yj6rXfsXMBEsNhaO+vAOwRHwIMtgdvtqiTMEtki2juvvQEqx/VXHaM+KwNW31veWNXwwJqZ6T+iR7WHalrDs8Jl6CpAS2l9GSrfC/ecxTNsNckLobs3YFM3xjHEBrxYyYL0b/QEwkzEPOIdUKkfIWzsrQPOSWlWeYGhpzPNL0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(107886003)(26005)(6666004)(6512007)(6506007)(83380400001)(9686003)(8676002)(8936002)(4326008)(66556008)(86362001)(316002)(6486002)(508600001)(66476007)(6916009)(38100700002)(66946007)(41300700001)(4744005)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?15Ni0yfyiPJBCyvXEVyqapP5CEZLXH0Jl4Fx/ooA5yqeUnMjN9E4bgGhXz+d?=
 =?us-ascii?Q?vRpXmwPpWspcHscIzNuTHR8KAU/HkgweqKSDFOxS56FjBol5TC2GhJ66q4jv?=
 =?us-ascii?Q?GI3VrI5L8592owNwuA0oR7OQERZORuS1A3BW7It8+U4Fs2EJdjTOeWQbTVyO?=
 =?us-ascii?Q?KohqxBs3PcS4C5h7eVPZiubyUQJ9kUpkG0riCV11nG5ze4+KSShUUa54iKsU?=
 =?us-ascii?Q?IGMXn889VYi+gpB7CLNduZxmpl08s4W42CdEGu3wbqkUCOTNpVu76tLJVZP6?=
 =?us-ascii?Q?k/NAFQRRtnDR1VFhcFGc6GnXnEw7ADUP8QBWDX02DbQSCxDZFDHHgRjcFKTE?=
 =?us-ascii?Q?K/+slfxoQyI27nlFBwpAp0hYMuMDB/7F1e1T0lTvwShxQuI0gQFG/PeLFyO7?=
 =?us-ascii?Q?dnR71DhBlGF0rupDsrpaspro5Rfzi0i/UtgJIOiRZW67tb1l3sGtVyPQPciF?=
 =?us-ascii?Q?jP/+NU1oP9Z6IukaWF03xOwgWAakhZ1q77LMllfIXmjoKD+GIMBmrY2GYRPA?=
 =?us-ascii?Q?4xWWq7WkPN/+BCQSoxfbK8XqHKD+suspG0KJqEvGTIl0QtQhyZsejQhuBWLk?=
 =?us-ascii?Q?d/TlDpiLBN2NWHUN3if6891pQqwe9aryBOVhpdhiLf4ps+W+FGSXQu6uIlTw?=
 =?us-ascii?Q?1VvJi+48Sy5AMjly6+Yc6OvklchGFFewXJgCNZaZMBEYx3gIvdXycZVTu2ba?=
 =?us-ascii?Q?sWGk8dtUCgiPCsBkHIjjSKAe9AxEvK5jc1GO39jBGnHkf4NtAcFizgjpgRl5?=
 =?us-ascii?Q?/7gF+leB118yUARTPKl3R87psuC9cGcY68HbxABuVu18hHEtwaPGArsvikIF?=
 =?us-ascii?Q?mGno0jPvHi6PsqKCG0DxxHcfkCB2+sKRPMleVXXZwvJlfF+3Iuo5/Fe9TMIz?=
 =?us-ascii?Q?RPeHF4MDLOoZVfXKo8+cVLFT/+KosivO1zMfssBXv451hFE0LzBKP4Xmuw55?=
 =?us-ascii?Q?ggQTsoiHQvO/UMoHuuQvdcIKf5lp1GTUEcZEc8Uf2xb7QSv/Mwavz8R6Kr0Q?=
 =?us-ascii?Q?Ce9+id64wPU8mlbKUi91My1QWLt1mUbng94pjZPbHw9knkGky06PDY1TCBHl?=
 =?us-ascii?Q?n4b/XS+fN9kS0IjAt6/kgVoPQqjOPwxOfwsOWCqw4qBzHCAWOCunkYb2Zunk?=
 =?us-ascii?Q?wgbIEKxJl0/fT8HICZJXMR+dwuM8JpWBClGE/wN7cQ9CJVVu9mlv3xkqdGfD?=
 =?us-ascii?Q?mIBV9+zZ9+0d8egngaWSHi7/gsvrslbzE4oafIU1PZC5WcjZx8SicPAUVrdE?=
 =?us-ascii?Q?K6lSlwybJcSWgvDRYqWUgV2iQfCWjT3ylTbkAebz+HX3NXhd1+tXWQfswo90?=
 =?us-ascii?Q?U5NJor40l2lupc6JMRkv0Uo8pbl+5e7xESy3bNkI4eoaRg67mNd9uU/oZnmt?=
 =?us-ascii?Q?n3lhISjXursEEoDWBMabHH4iFKWJNhxc4S9RqB6ZoGi/GNJTuvfHmhDn+Bft?=
 =?us-ascii?Q?aV99uz146G+kvy6eGwhLTotprWLPw4Zryu5Ak5/HFlvAB9J5x+dp3nE9e+1M?=
 =?us-ascii?Q?6a3o+6IwbnrvW21SSnHkMQ+gpImXaV4yxKeJcmRNN0vGDqlLTFP3qr9DWeeA?=
 =?us-ascii?Q?VogpnYtZeVi2oSz0cNQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db79c575-f4b7-403b-fa1e-08dbf209d171
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 01:06:58.7391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3M69zKXvFtJrhzepBKKtCLD4EYtJpnFpNDOPx1TrZeSONS/22E1oDPTgEOPENXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7650
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] ptrace06: Refactor the test using new LTP
 API
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

On Tue, Nov 28, 2023 at 10:51:49AM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> >  #if defined(__i386__)
> >  #define SIZEOF_USER 284
> >  #elif defined(__x86_64__)
> > @@ -35,168 +34,213 @@
> >  #define SIZEOF_USER 0x1000	/* just pick a big number */
> >  #endif
> 
> I wonder if this SIZEOF_USER is valid. I haven't found what value they mean
> (they talk about arch/*/include/asm/user*.h in kernel).
> 
Yes, i also not found SIZEOF_USER, but i suppose the risk is low since the kernel
code for struct user is quite stable and the latest update is 2008.3.

Thanks.
Regards
Gao Wei

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
