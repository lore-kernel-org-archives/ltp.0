Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841CBE7109A
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 12:21:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DB223CDE6D
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 14:21:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAB6B3CDE40
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 14:20:49 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 67CCC1A00E11
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 14:20:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWGtdJTz9yslS91G1wqVDunlxr3NI3AlYNE89AdZ44D/BTXgtesKEnMizajWHL2+RflmgYczptWfDcNxIvfdzqNBGDonFJ79PUOou5fYodMu8iyCD61NbuGi2W56n8uS7ekoIUw+j3lkzWZQXmd0i6PlJ7/DpoD7T3FMjfnH1Nca6WQXXAk97xpNsFgOIjx6z5eSCv2CAR4pdAetTKfoQqmssTpCiY0/Jk+5rEaJWYzzgc0ZSSPI4E3n88adz0FhTQqbBYaZFUyrwZFPdhUHTxZ4xAOtt3qw4ZYZkcurtLdy27xu3Ns3hoRSUflIa6hctJB4zumXigYV94zrIFtUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oi/TOeQNlrCqhuMseL+dL32kRuw60phL5xbdys9N0c=;
 b=GDNGkUl+rXB11gWdwRHthV8KogP9Mmh+bsCyVeRsSeCc6ps8xfTH8Gd4uAJcOP7p1XOax89zrmz+Vqa4BPDRZzyuJm5kH836qTlDA3RgR1tjHUjOyo+TtxnTkoV531Njx10FMQlbcr+A8GhThn+bDWTbsXc09EA7+GlI4XrzgN+7w107eVsrVuXfHYWfdX6225WdB0tjY44VbCju42qsbzCRFh7edB61nub0YTSMAbZvjCydu9s0Vg+o86g5NgI3o7WQdjl8k5cFYHETx45ADjFFqXC6xj2SLbJ+qZcUuAH2mI99T3YAZtr3uvGOsLbttO8311Y/OdO3gvbLLSIJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oi/TOeQNlrCqhuMseL+dL32kRuw60phL5xbdys9N0c=;
 b=wWdt3mkJqm7qt7G6fZG45050t57ntbxdfJqcO3Moh49b/Yf5r5Vz9qgszYP3Fz22qwxe8BxXEYBIomjY544RbHukrXAvTdL9wVMfijLzn+zTLuCEXdp+VHrywlUiDLXHNVBTcc+eue/1KckAzYmDXxMw2qTMmT8GqXOK2FZG5H/kLA4xn/VqnrXPPGwCiJ84F74EPB150VGCaIoJniQ058PcI8NkHZw5UaSZzco9HfQdSGQjtPIs2s5F2JSDaXowwQEZtyPnAijgwC6lFmi4j/hUcNkIuVOYU26wlyrN3r8XoaFIzdSHVWk/e0bq27qHQm9nBfiUgaMKFkiI+pspGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB8PR04MB7004.eurprd04.prod.outlook.com (2603:10a6:10:11c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 12:20:46 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:20:46 +0000
Date: Fri, 22 Sep 2023 08:20:38 -0400
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZQ2GltNFaQIrszXl@wegao>
References: <20230921090658.11224-1-mkittler@suse.de> <ZQzZIBNGHkj9/4n0@wegao>
 <5973304.lOV4Wx5bFT@linux-9lzf>
Content-Disposition: inline
In-Reply-To: <5973304.lOV4Wx5bFT@linux-9lzf>
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB8PR04MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 07930ff8-acf3-455d-8af4-08dbbb665904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnoBdOsO3ghAilNqjOrr8Tf1t6l0nQpnTDQ5PtNjt8iRFxqYeyyMMTmNJYpSav9iry6/UwIr/4d++vE3BAdqo3R57PZ3fgfi0ycm56C+wAsV0D1qPMQ32INaV7eQvh4QdYGlu90cbEqBpGqjGYlNGHVYjGcO/RyXISqnjlnUq431qF2YqDrbEyI+dqqYJZ4fLjULKcUWVo66Rs0avANqDY35WFMhGXHbBjP5ipTjPSuNmqO1C3FRKluPXvioTgs8KTT040iWqq3vhfT9Zk02XIa6P8IOu+c566XG4QKf3lHe4rQY5SygxS8ulQSxq1p2OvSglMmbfWWuGQDTm6y5kUeAz/DdKodJE9vkGtBP/fD6H/+/uuCz2rDeW4SLHUIhiUwP4K64YYHEmN4DxK8AsbJc6BGZptQlLXd1NgDj8ojT7GLQgNgZiTMy7n7blSy5NSVyEJQn16V3lq9R4huqrIza2jkqsPtBBUfIq4AWnUoUHwyp1llsMhZm3aOG1nd4xQG1JyjpkrWFXcSYLEOiZZjwUiksvOMox0Pjag0Q1jDu4nxLvuD2rbPe/gK3PypXEDlHgDYyrBP+f8LRp+kZy3TX8Err+QA3ghHsQ3uCpug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(39860400002)(366004)(346002)(396003)(136003)(376002)(186009)(1800799009)(451199024)(38100700002)(41300700001)(316002)(6916009)(4326008)(8936002)(86362001)(8676002)(478600001)(6512007)(966005)(33716001)(6486002)(6506007)(6666004)(9686003)(26005)(66476007)(66946007)(66556008)(2906002)(4744005)(5660300002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8SGkcP2FfZuJoJV1TAckbpuJd22FI+AnGCyKvtsiWbD27P/1YQ1iTfZ5+ZwA?=
 =?us-ascii?Q?zo0+RiNfhkN9+79AxEBUJX/0Lxx0ELSO2hkc4fNlV9g06fRyJ31tH1emGE3D?=
 =?us-ascii?Q?OkpcGG4nktauAEe/iJe8V0Wo4TUSP4E2uTyS2a5Q30/AXjrxm5Vrnpc0qtP6?=
 =?us-ascii?Q?9mf4VfgeapdyehWIGx4ewy0dZMhVEdco2OXOPCGOB5mNJHgarj5pKwhANOKl?=
 =?us-ascii?Q?zDuk4XESsIIBody3RrREKy253y3whrUeae88zqE33yVGzShrO+QX9vCApzes?=
 =?us-ascii?Q?arRkq7T5sZdntr91zjJBlJ8hEqCqCk3i9SicQf3FnsROAaJbzUhFfKFP11tg?=
 =?us-ascii?Q?YmBoYXe8Mty9uDvY0vlcIhYF2XEEKBiV+jqGJfzxBW4P76/3QPlOikgUanSM?=
 =?us-ascii?Q?QO4nnUIsidN/jhqS0RKJxsP0cK7Syw9csPmgWLauX72DACzGM/LFUz54tiqb?=
 =?us-ascii?Q?DBweEGz0A1gxN+1vylzDDV3hgtmWFstMyiYletGGrGvwtnhooptznSKVPlS8?=
 =?us-ascii?Q?Iic3msqvfhtIKgCmSx4fGWdORSFgVk60L+qJ22hIELCQFoCDkhQPUUasJ96n?=
 =?us-ascii?Q?vHv+sHH6hG0pJd1l2YV3vDG/CF+wDG7iiIXbSworBlcCFUJ/yjn4nOlTOD6Y?=
 =?us-ascii?Q?lHUcdL0Yqd7i0JN9I6nviQR30oS/M8fKif/EE8eIM3/T1yA8fmqPCRSoJyIg?=
 =?us-ascii?Q?cEZ9WPXVgLjKYaXN5yV3BqQbsqxjh22f4BdQvUzH+QvxW+gBAqn8BoW24V+I?=
 =?us-ascii?Q?ek4eoIY5F/d4v5ibcnWAGiwbPE6l056emFbPxQxW9M7cBSOkRKKaD7X9EB6m?=
 =?us-ascii?Q?2h6v8LYXOCeBcEQDBeacIh4Rs7lVSrnJHkPPv1CNpC3xv6Lu1+cH75q8Ue49?=
 =?us-ascii?Q?mK28x6oJAEw6rlRdXpwfs/BF1+85WMrC5Kc1EzahQhpxM/wQFK1V10dSbQhj?=
 =?us-ascii?Q?Fk+I/eEWdNQTBOxCd4oaY9bPEcXlG671eaF5PIKuYqph7OZckJEkfAxzOwpX?=
 =?us-ascii?Q?ojV47pKZvDT5ioG0cTNyuQsH8SRFuMkGV0VjlIINgTy+a8lKW85I4OpeEVv+?=
 =?us-ascii?Q?PotXYHq44yblF0nh7pCzoS16ExVOmqXtZ1ohtgAVQ+xlaH5726UP2DynSe92?=
 =?us-ascii?Q?z1uizIFx//3fMAuiwKVQxf0KF5tvTO0AWwDFm7ke/ou5gkEEdRYnunozfH4v?=
 =?us-ascii?Q?4mz90EEysGuC3VE8gSiLbAJ7jss+ocEbl8Mo+1vdwqsNl8AKea1VumLT3a8L?=
 =?us-ascii?Q?5KrEwmL4xqXdxeFi0dAzajc550JW5s+c2AolGVqHPQwJYwAHuRBMSPIc1WjI?=
 =?us-ascii?Q?0cZNtdlkSMiRThSs3BZhhMNdC+TQZUfjz5zaGvhMP6r/s2rZPvp6sSnRpJQ+?=
 =?us-ascii?Q?BlbGKdXNFYyYiOuFoYvl3VXJ2GhBMxeXst03WS3izid7uCEfBvXvtl8nCIB1?=
 =?us-ascii?Q?GjCfSRjPh8ln50fkBhI6WJs6ly7zZ60rLYcLPQv7IJzmpMXWsTpTujqepXhQ?=
 =?us-ascii?Q?eEYFen6Mz2759vWa+dAFi/wEWqxXmBsMHo8Szm8iBpHkHBGhfAVOajLl4B7z?=
 =?us-ascii?Q?f/4QYxqsBHM5P4aMqKk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07930ff8-acf3-455d-8af4-08dbbb665904
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 12:20:45.9850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4uyTWdLZgaopedFonqwszaJ6dhPhvjBAwkHaZgjvkYbcuNb7J9fgmQmTNpccml1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7004
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Port getxattr03.c to new test API
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

On Fri, Sep 22, 2023 at 11:23:47AM +0200, Marius Kittler wrote:
> Am Freitag, 22. September 2023, 02:00:32 CEST schrieb Wei Gao:
> > > #ifdef HAVE_SYS_XATTR_H
> > 
> > Normally i saw this kind of ifdef in include/lapi/xattr.h
> > I suppose we need create include/lapi/xattr.h?
> 
> No, we don't need that header here. This macro is actually defined in `config.h` 
> which also makes sense as it is generated at configuration time. Note that also 
> all builds (including musl) are passing with this change, see
> https://github.com/Martchus/ltp/actions/runs/6259530698.
Maybe some misunderstanding, i mean put ifdef logic into include/lapi/xattr.h instead 
of define HAVE_SYS_XATTR_H, since i saw ifdef logic for judge exist of xxx.h normally 
handled in include/lapi/xxx.h.
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
