Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA6C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 17:06:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3415F60EE5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 17:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3415F60EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vpitech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4574C3CA20E
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 19:06:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1442E3C2659
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 19:06:26 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD28C1A00CAB
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 19:06:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdmRYtcTvcjRgPqSqYRDiraGopHG7DGZL5eu/xRph85rYOywsqQ3nJyMKgINB38rmwzCNslzZ4IKNwnd0Z/UHJye250TmsqRhhb9zkkIQyQWCLnH3VETy/0nL6rcn3ruR7BaJzDFP4z3FZ1VLMvw36ixdvPBZWlT2w7n6USOg1kUVBBLYXhod+vkPOiOU9JGXh7sYwEM1jmoDzr08Iw1bhdinSPaaoW8HPWkqV9vMY/9HtSuaXyFnZdrAhEo4HMoxD4AcN4yWQ0mx6UjSkD6TkNzdkYwHeNTNxag8nGr86DKSTbLhMah9ttEpbIgt5/MF9rtuyGzyzSHqBxCUhmuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=KSHsGEVQuDpoXHyl4plz+PLiTy/wuSO1p+SsZ2TqthI=;
 b=IPOPXHc56c6G81AVYHgm2uZ/1PV5LwQ6PFGhifZTzNJPgWH1m4ku7pjJub9n1NB913rXufq9x0iNrWKBhYbANPWVWoa/G+b+4LzlWcMuNr8UgQZ3eiXJBvzrNv1FflkAtjzaMoCIkADfP1J29wIl1QeQUW5GyDTWo/XlKzvPxsQSgAMXXh3U3LLlqX/1S4QP5hru1gH2knBIPpH7d6ZC8j0vGpI0icbZxbEncL6oamCPNGSZVuCCuA1vRoWYyxHzF2clTdBBsAqHIk3RlOFdvVE5IbjW0vTLufGn8UzJ5dHGFcrqH8552DUFdH68VcNP/hkewN1b9wybv55eGPb91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSHsGEVQuDpoXHyl4plz+PLiTy/wuSO1p+SsZ2TqthI=;
 b=BlS8FoN2kC4GNhRmOEm0xT52VEJIUrd8A8m8vnGIHBUoUDZPeeYSLZSikIuwUUb/rz8FlSUs3jOdeMAbwxEmxzUTPCEjPBEKvjablMilJec8froFPRd4hzThactnY/WbztYT01s0oeU4cESF8yYPFL2qgPBQBTQ0uaMrIYwAC/w=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MWHPR07MB3184.namprd07.prod.outlook.com (2603:10b6:300:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 17:06:22 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 17:06:21 +0000
Date: Wed, 22 Sep 2021 11:06:20 -0600
From: Alex Henrie <alexh@vpitech.com>
To: Petr Vorel <pvorel@suse.cz>
Message-Id: <20210922110620.cf7530d5120d2f0173ed2f05@vpitech.com>
In-Reply-To: <20210922115310.5927-4-pvorel@suse.cz>
References: <20210922115310.5927-1-pvorel@suse.cz>
 <20210922115310.5927-4-pvorel@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
X-ClientProxiedBy: MWHPR14CA0012.namprd14.prod.outlook.com
 (2603:10b6:300:ae::22) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter (66.60.105.30) by
 MWHPR14CA0012.namprd14.prod.outlook.com (2603:10b6:300:ae::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15 via Frontend Transport; Wed, 22 Sep 2021 17:06:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 558cab13-a91b-4636-4f3d-08d97deb4d43
X-MS-TrafficTypeDiagnostic: MWHPR07MB3184:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3184D42E2CD34E5CB1D474F1B8A29@MWHPR07MB3184.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQ7iS8odZS/1kUkasDnL+BSUsQULDDlXIk47J0/C/fEdXxk9RG3NgOz17VnxWXcYs2pPdzpcsJeVtRQdt+1IO/TDeCQQ18qibQ1OFglYgf76SRgewAR7zsClIU2MI8upwgAdhdPbdaZY9iCYyM35RQRQSETftTNqaiDRXERzd2uMTTjXNX3pSzz0M/oKCc2hL7dHmhHwRJMXFKDqs08T+l7YuWlpVf9/1AP9a6DLrlcjd++M6l8IFS5R5THbXlBbkFm4qwBpf1PUgBrzlCj+fXz4Nbu35KwmmQmJY/J3qUPeRXUcxj/MmhgUlpbbdDNJTAsy22hzJ5qKBsTejQ7/4/OWH4xPZ892y128Nt5503dcZGHDSQ4yvyQXqOCRAPiOZoPcBOQEJFJYCydn7RqFOhfCygjEVvwxhUTEfX5N2xgT1LL/7UJ5pRL0Kx5+krf5nTHqxi1scOPuKa3ASVttkbiz8z8mkH42iDOZ9AVHRCLJf6cG/KzMBRwfOHLGhuewmvI5L1BMwxzYlNAQbWvSv38wEGWRTeuRltwxY9NAVXASh1B6eV0fguCHnXhtV8CAk19+11SEJjrOupN7sVD3JZBuaUAH/WMYr67WV0WFfxODKpPtiuSJG0Nc+Qr431cOueU856SeXQd4jlRyCBdet78O2NJM27c7cppes3vUgkswlupnZQqdKF6HFH5/3mDtwsMOR2v9ACV6pBQpaqsSyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR07MB3980.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39840400004)(376002)(346002)(136003)(396003)(366004)(8676002)(8936002)(508600001)(6486002)(2906002)(6496006)(186003)(5660300002)(86362001)(6916009)(66556008)(66946007)(26005)(316002)(52116002)(4744005)(66476007)(1076003)(83380400001)(2616005)(956004)(36756003)(4326008)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R55dn6WfGp7x9PkTy/o0KzW3/jSuylsUd7Qwrmi1qwUbN2nwumBseRkyeHfy?=
 =?us-ascii?Q?VUmAmCZZ2Ltn39sO4C7UjIb5SIeTkkEXTSCnB/bh8quw6gun1zeu79djQhRb?=
 =?us-ascii?Q?YYgaQ8YW6YaWw23FurRC0AHEgv266NiiDMgsCUCaaUeEBlnTk8SAS620r+N9?=
 =?us-ascii?Q?Y3Roou1/z15rVFh84h52SZNGaqHE27a/xgxFRGVW/nio2UdBYdrh0r2hFEho?=
 =?us-ascii?Q?aAx3zYwPk/HEApAnhH4MGCISuhBhWiWNcbH0qFrWDIk1j5QwjyFuPtH6mB67?=
 =?us-ascii?Q?t7jGWdIAN2B/4P/gVAVdJli+E/j1thIEmAOgz4R0FawQ1jKmqwubpFwQtHki?=
 =?us-ascii?Q?9PPn0t2wlJZB0K38jXgZf8W+O2s02owqmH0GjUadnqQHmRVIqbAIIbSxb+hv?=
 =?us-ascii?Q?OhDbLjlFIOPecf03NGH6Id869q8H60ZfyaXTLO49AgHsdWSxSFJJcTDksUgB?=
 =?us-ascii?Q?WY8mCricn98CPa+0bQ5aD9w7cf06aMvaGfgpew1O/OK2gSDFmlJ8zQJelD4N?=
 =?us-ascii?Q?AeWkbUcOFYEbgFPTYY8d5X1/Em4jG/ScuxbvkwuWuIkA12r4RXqP79mQ7pnq?=
 =?us-ascii?Q?rruFKbX82+ijIHZMpgyOzP9nrzlS7/7XJccYreJf7H7hUYmc7pvHrf1gMlWo?=
 =?us-ascii?Q?IqH7sMf2jH6kEpyTrtTJrcpPzTcC0ajFSm2KyBie2oIq7qIX0ugrMGi9r8wp?=
 =?us-ascii?Q?M6xcwyZEXQxbhEvJMyoHYEmc4fCx7zY7RKqoIXvr9zzvZPYCaAlKjCUksKPp?=
 =?us-ascii?Q?8llsJJuh3W2GHQgQF88By4jRumGJFPj6k3Zyj6YCORpA3puw7ScF3SQP9zMY?=
 =?us-ascii?Q?b+3ZN+x51tygRhuiECIiwuuBspi2kTBcLcqj+ETz9rg4vv7Hr0w8YIf4QCST?=
 =?us-ascii?Q?Nr+Sbisg76U9ndz1dqMgQX8WlfdNLXnuLn0DK4TMoho79/JC2fdvojmLS64G?=
 =?us-ascii?Q?OL5y/0E0y2Mtt950Vf3laZwHn8YmGDydw1+CXCtchubBrf4L5QqPNfRjc5L3?=
 =?us-ascii?Q?FEV8h81Yncr7SaTPXtfiA7ceQucYEi7tyO3AXV6KvOpmW+ozYNOdjuAgswJD?=
 =?us-ascii?Q?K6bGOT0DLzDb98oT7LuyKaQdB5Ajj12hznRNUoS/cU6fmnb4P1NfyIj23IxA?=
 =?us-ascii?Q?WGdKS5hfBekC094glv2zH7FNWOhzE47ciPEsVOpfyfJ/h16G7lHCjqxuj2Oj?=
 =?us-ascii?Q?7Q1zisU7IQYRgKTo2S64SMQsUV9Yyz/xnOFcdgR/djqf4L0iuG3Fa+DdxQIU?=
 =?us-ascii?Q?zSPpSWGEJGSinxzrAwPPDxZI/4Vi/+tKf5T/qHpW3d2BsNxbKP3WLoXFCt5u?=
 =?us-ascii?Q?DHuJ07Z121Fl9IveSyNUjUNX?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558cab13-a91b-4636-4f3d-08d97deb4d43
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 17:06:21.8678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DogjNPcTSUGy8NF6VaZXgQMVDPC2dEwxCAT5jIIqJHD1CzJGG/2kaxVY+wfGvTC0oLCdrwA+An6FJ7rTXVbxIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3184
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/3] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 22 Sep 2021 13:53:10 +0200
Petr Vorel <pvorel@suse.cz> wrote:

> From: Alex Henrie <alexh@vpitech.com>
> 
> Requires "ima: add gid support".
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Alex Henrie <alexh@vpitech.com>
> [ pvorel: add test_file parameter to ima_check(), add
> verify_measurement() (DRY) ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks Petr for taking over and making the changes you want directly,
that makes my life much easier.

-Alex

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
