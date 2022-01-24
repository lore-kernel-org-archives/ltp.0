Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CC0C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 15:22:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CBB53C8FE3
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 16:22:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1D323C8DD5
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 16:21:57 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 65117600640
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 16:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1643037713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xEcXzDJWu6ppCF8tQRN9Q+41SrEIsuY/0Wsk2Mi30U=;
 b=IB1uSLPQam03bR98797pDEtoeHEtQOkeIEUDAQAuo/f1XaHT8SmNQv9V1khsfrT4GP3AFl
 oeF8W2HsJbkfHEAriwa2Goh8/tWWD0lL7ZEXRm9BaiIMiG06QAO5IimySLMZqZPvDGw0Gr
 hBsz0tkQ7gekmZd5F05Mkmt0/CqmwF0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-HlwDAShmO6yKaqg-jiT_xw-1; Mon, 24 Jan 2022 16:21:52 +0100
X-MC-Unique: HlwDAShmO6yKaqg-jiT_xw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9ch5mp7e/jtXIKwklfZ0epdjPbKM+r7yj15qQKIz4JoRgMR+83GRTq4V7nfp9PGf5f8KcvK5cLjjsvS2Fiv/WbvcRtTolyY8DwDdArhdkXhHNtS1Uy2pTTENevWGMIKKv7xUQmRu27r4o+iQJ1YSyrQwhNVEbFbgDiQXO3aoNTnvTeeg7Qa3rg5Um7o61bcEfNqRyIWNERvL0RPmyF7bGlZmo5bLldckCaLSh8USYXRtBVcIoNH/sevUUbjuqZN7o7ddKrsLb/uYE/w2CHgYwg7YdmaD4RC0v6m2+uGaaNFSEx/gSEGZ1jDeik6UZyQC3EJGBvTPD80FI3oJpmXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xEcXzDJWu6ppCF8tQRN9Q+41SrEIsuY/0Wsk2Mi30U=;
 b=jVlNlnuCyTOIKvNbIcxd34YabDmcS59uvtq0gpBvOFEzLBDtjV6K+ER1qMikN+U/5XPzY6ZuJ0t2TVdjEi+pkCVleThkaUCsyIDhoLfw5NrozaayLJuGspNfVrR6LheaMHUuPa81IAPLdPVbIef/m0UKp0HVaPWLjMsXUatMShxp/8UiEwbk0wNXCsrvp3mEAtFYKq5Lps6ud88vsWsrP2WY7oeP6Y4DvrvGyq/F8Me6cITJBNIFRq177tChhyRAkM4CzxJT9BIym+TNxQDpYWujvdv9wo+EQX9bUM1xYaZoCQU6qGmSXjkk5oqmoZ9ETsLlfVST6sIdxBdW+gWzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by HE1PR0401MB2315.eurprd04.prod.outlook.com (2603:10a6:3:1e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 15:21:46 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::15fe:49d3:b4a4:7d82]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::15fe:49d3:b4a4:7d82%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 15:21:46 +0000
Message-ID: <2a1d49ba-aa62-0c77-9c55-9d3a53098a30@suse.com>
Date: Mon, 24 Jan 2022 16:21:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20220124150317.24616-1-andrea.cervesato@suse.de>
In-Reply-To: <20220124150317.24616-1-andrea.cervesato@suse.de>
X-ClientProxiedBy: MR1P264CA0125.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::23) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a75367d4-f6b0-4133-e284-08d9df4d3bf4
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2315:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0401MB23159989258AF7B749C8B408F85E9@HE1PR0401MB2315.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZ601VDHB6aNEuf4HckqYWDwRH3trNE99tzv2Ny/dAmk6pXEAEAti1QNzKL5XW1n9UncSmedG85VcMH/39o/0qmOxTJMKYRjloFTq7By+jKuTM79PURymMcJzJhgQcSBCdNVnyJxcqaCkNkF1WEwuim9Cz9zYMRTnGYZJrtCMj6E2a+odPDGCwohgTUmWrbvPTRLdCYwtAC8YnEeA9rsaqG6qzKu6O4AeNaeWu1p+UHMgi2KL7gaMH9eVkMGxgGmXEndXv/i2uyezPL7+LHCLrHmnAnLX0jsUfcEzi+54ubNKzA9g7R7BVKptIvpvGOqbFqzVND1IOBHktmqmngGQzPfZnsW4UaBQzfftBNlNswV6Svd7HcyTpNl45mYbVFrlxU/PJo6vLT5F3eEd/bL906SdCAGEPZDtSYqfcO8I2MCtd8NuDjQddeJn1Yaga2/a7dkkh+ES236B41Q9qG2eFWbhSm016+6Y3u/BDi29vPlt+Fzk8iSyW6WNO4cyw1HptrvgFDZGeB/xBnsiIEqt9s0rL252M8sANeWGY+r3oqo9CNE0DfG0gM8xjFLhVTguXoxp2sJ6xkgzN8xFBeVkoPbTK6gA7tgJjPmLerPtDOzv4JhrCyjM8xNfDhpPVER/OjjE7eZpiJImBtbKrOkWBZPUBPWYG54xoz0eY2Z8JdyZUxED1ss5ye9tqOCAsiutk0HmkU05+Orcr5W+wpQTcW8YLyo0Alx/B4sCGk9NPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2616005)(8676002)(508600001)(44832011)(6486002)(186003)(36756003)(26005)(5660300002)(38100700002)(31686004)(86362001)(31696002)(316002)(33964004)(2906002)(6506007)(66556008)(66946007)(83380400001)(30864003)(66476007)(8936002)(53546011)(6512007)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUpqdlNDVVN3UHprYVVGRFc5ZzhYTUwrQWh1Y1c1RlhZb2swWWVKWU9qbVI3?=
 =?utf-8?B?QUFkOTMzWlI4ZnFiZktDWUlHN1E4aDlXcUJ0Zkk1OGhrUE9nejNKRjJvbzIv?=
 =?utf-8?B?TnlYYWxCUWhlakRpOEJYS1UxTHJmNDViY3BJRHh3TVMzak5VNyt5b0QvRG8w?=
 =?utf-8?B?b3RIekZqL3pybEdibTVMb24xd1ZkaVJ6UFVoUXpLUUFFOVlwVnFwR1h6UzMx?=
 =?utf-8?B?N2tkaXJXVkhMLzVONGU2aVJYb3Y3TmhuT0hEd2hDTjdvTHNWYm5udm13VHBz?=
 =?utf-8?B?b2tnMlovdnZxN0Z1WktHNlhyUlJDUFhTRDM1ekRaZUhoQlB1Um4xL1JYN1NB?=
 =?utf-8?B?OWlZc0VuSnE1ZlRRbkMrckxCWjRjSzNpQ292dllROHVXM0l4emxaZTI5RCtw?=
 =?utf-8?B?c1BOZjNjeURYUElzUkQvNkVRZVJGVWJlbEtyV294UW5WK3ZFbnVvcXV3NUxx?=
 =?utf-8?B?NGpaQ0lKTndNa2wzcWJBdWxvQ1pSc3BZemZaTlZFckZiNldMWTNCQms5a25s?=
 =?utf-8?B?VExyUEhqRzZSNmJycVdRVEV1bmtvWlNLRkF6ZnJyVnpQWDJyOE10Y1o3T1dl?=
 =?utf-8?B?N3hGSnk2Q1JCcXRjYXMwUCtmYy9zN3QwMkJiMnk0MXh6bzd3UTh3THZXQUlS?=
 =?utf-8?B?RW1xRnhYNjB4V09iZzVBeDgzbng5Zm5jOGR0Z0t5YVQ4NWtaK3pvc3FxYWhJ?=
 =?utf-8?B?dTRiMlhhWXdtcTRlRXIrOHhBVkJzbHpFdjNrdUZTckFHK2JQUGhRbVAyeE5x?=
 =?utf-8?B?N0NzbzRaL1FFN1VVdFVYRlFKaDVjVnJWN0gyZStoSlpXSVE3YTVEVnJzQkhW?=
 =?utf-8?B?OHVrWi83N0JFOTBZNnJIUTV0UmtYZHdLTWJzREkwV0Z3OVJBS05jZTV4enRR?=
 =?utf-8?B?R0h5UE5hZGphWlBOZUFzUEJsU1Z0MlFQQlZDT29pQ2p0UkhKT1Jwd0N0djF3?=
 =?utf-8?B?WkthMXNSVE1ZaFFMNzFvMUlyajNGdTYrdnVUVjBRRE5QMlY3S1NIaFB4QTYz?=
 =?utf-8?B?eFF4VXNsTmJydFRwT29GYi9oYW5xN1JocWQ4K3lUR1BRb0ZYS3diaUY4Q2pl?=
 =?utf-8?B?ZEU1Z3F5RmxrRDkwN0d1cDN4VlU4ZGFhVklhK3lCWTNmL3VVdmp1ZnE1OUFN?=
 =?utf-8?B?N1F4MTFpMFdZRDhkWjdST0UzNzdhb2cxdHZpcXFtbnZueXp2RW5FM1pKenlV?=
 =?utf-8?B?bjlMeWhGdnZRZmpCZWY1VHlWTlB1bHZIdFhNMStqdG4wZzMzSnJod3Z6M1Fi?=
 =?utf-8?B?RFlFa1dCamRaRnR4UXdrUEdvM1VaS2pSb2VQNHViYnlSMmhicjlvMGRaYnY3?=
 =?utf-8?B?ZVFtTlErWXFDZHBxZHpNTG1zWElNZkVPZlBSZ3VFQ1VzWjdaaWFQUGkrTit1?=
 =?utf-8?B?cEZnNy9rSWtrZXhLc2hBR3RwOWs1b2syYktpdmxvWDRIK2w3OC9FaFI0dWFj?=
 =?utf-8?B?ZzlRakZDWGQwTG5MYzduL0FWOER0eFMwRGRkaEVLZzlYVTZORGtqaW5BRTZ6?=
 =?utf-8?B?djR0cU9GOHA0dG8xK2thTms4eURySDNlbHVPV3cwTWk0dGFHT293MnJzaVIw?=
 =?utf-8?B?alZSVFhvL1NVSWp4UmZpTkw2aCtQSjBUTVZkNnFuRUNJV3BoQmhqRWl1OWRQ?=
 =?utf-8?B?M2dZUkJkSURFTGR0ZUZPQmNUeG5hUEhFdVg3bC9hZkE2eFg2RzNHdDR2Qkx5?=
 =?utf-8?B?emtLY2FNNXlhdUpFbWc3STJyenpDc0VIY3dIYS9WVFFEeEZ3VjdIUjY3VTFl?=
 =?utf-8?B?Zy85bEduZnFsR0NTMTNCeUNscE85a2xIMHdRRm1VdEVYZlJQa3BaTVBVLzdP?=
 =?utf-8?B?aS9ldm1qSml6TlJDdE9PODBCK0kyV2NFamhYRzRtaklUT0dTSmlxVlZpbWxw?=
 =?utf-8?B?WDJTMndza0dzQkwwem8xUldsb0MrL1JMZHBRQnYrRTRMMmNmTzNlMk9qZEpU?=
 =?utf-8?B?T2txbi83S204c2V4TTZlVHJDTWxVOVd2SFVpdENBSGlVR0VvcEk4M1NWeUpZ?=
 =?utf-8?B?T0JROGRzaUJGQkErNk1LQWNDT3daWlZzOURVVHhBaFdEVVlyaG9ueGd4Q1JB?=
 =?utf-8?B?cWtva0x1azVVaTdsTDlaWkJGVHRXUmNDVmljZm9WVUZXSllEazIwTXYvNWVJ?=
 =?utf-8?B?RWd4RStRMys0cUtTUXZFTDVHU25Vd01TaVVpb0g4K3Y5aERyYmNKWDdZOE1u?=
 =?utf-8?B?SVJkaTNCU0R2R0hGK1Z0Nk5UejJ5V2tieU9mTm1mTXFsbUk0S1hkWnpKK1Fo?=
 =?utf-8?B?cm83SVo0WncrS1dHaDBYM0NuK21RPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75367d4-f6b0-4133-e284-08d9df4d3bf4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 15:21:46.6171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIyUGCdiH4jMegaTQkBbL2yMnQhubLVNhhixAqOI8V6YjkEs1F+RHGWhtiPKXpmVchdS5FHKTwjNmiZkVyCyEclN3R1dvuZHqGnZvNqr1u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2315
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Replace ltp_syscall with tst_syscall
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: multipart/mixed; boundary="===============1941546552=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1941546552==
Content-Type: multipart/alternative;
 boundary="------------FNVRmDBs5vKvDJfPxXawND8b"
Content-Language: en-US

--------------FNVRmDBs5vKvDJfPxXawND8b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this is the wrong patch. Please consider v3

On 1/24/22 16:03, Andrea Cervesato wrote:
> This modification is a first step into the old LTP API replacement and
> it has
> been completed with the following procedure:
> - removed ltp_syscall
> - replaced ltp_syscall with tst_syscall inside all tests
> - reshuffled headers inside tests to import tst_test.h before
>    lapi/syscalls.h
>
> Signed-off-by: Andrea Cervesato<andrea.cervesato@suse.de>
> ---
>   include/lapi/fallocate.h                      | 10 +---
>   include/lapi/init_module.h                    |  2 +-
>   include/lapi/mkdirat.h                        |  2 +-
>   include/lapi/readlinkat.h                     |  2 +-
>   include/lapi/renameat.h                       |  2 +-
>   include/lapi/rt_sigaction.h                   | 10 +---
>   include/lapi/sync_file_range.h                | 20 +++-----
>   include/lapi/syscalls/regen.sh                | 50 +++++++++----------
>   include/lapi/timerfd.h                        |  6 +--
>   libs/libltpsigwait/sigwait.c                  |  2 +-
>   libs/libltpswap/libswap.c                     |  2 +-
>   testcases/cve/cve-2016-10044.c                |  2 +-
>   .../kernel/containers/libclone/libclone.c     |  2 +-
>   testcases/kernel/containers/mqns/mqns_01.c    |  8 +--
>   testcases/kernel/containers/mqns/mqns_02.c    |  6 +--
>   testcases/kernel/containers/mqns/mqns_03.c    |  2 +-
>   testcases/kernel/containers/mqns/mqns_04.c    |  2 +-
>   testcases/kernel/containers/pidns/pidns30.c   | 12 ++---
>   testcases/kernel/containers/pidns/pidns31.c   | 12 ++---
>   testcases/kernel/containers/userns/userns04.c |  6 +--
>   .../controllers/cpuset/cpuset_lib/libcpuset.c |  6 +--
>   testcases/kernel/syscalls/cma/process_vm01.c  |  4 +-
>   .../kernel/syscalls/cma/process_vm_readv02.c  |  4 +-
>   .../kernel/syscalls/cma/process_vm_readv03.c  |  6 +--
>   .../kernel/syscalls/cma/process_vm_writev02.c |  4 +-
>   testcases/kernel/syscalls/connect/connect01.c |  2 +-
>   .../syscalls/delete_module/delete_module01.c  |  2 +-
>   testcases/kernel/syscalls/eventfd/eventfd01.c |  2 +-
>   .../kernel/syscalls/eventfd2/eventfd2_01.c    |  4 +-
>   .../kernel/syscalls/eventfd2/eventfd2_02.c    |  4 +-
>   .../kernel/syscalls/eventfd2/eventfd2_03.c    |  2 +-
>   .../kernel/syscalls/exit_group/exit_group01.c |  2 +-
>   .../kernel/syscalls/faccessat/faccessat01.c   |  2 +-
>   .../kernel/syscalls/fchmodat/fchmodat01.c     |  2 +-
>   testcases/kernel/syscalls/fchownat/fchownat.h |  2 +-
>   testcases/kernel/syscalls/fcntl/fcntl31.c     |  2 +-
>   testcases/kernel/syscalls/fork/fork05.c       |  2 +-
>   testcases/kernel/syscalls/fstatat/fstatat01.c |  6 +--
>   .../kernel/syscalls/futimesat/futimesat01.c   |  2 +-
>   .../get_robust_list/get_robust_list01.c       | 10 ++--
>   .../kernel/syscalls/getrandom/getrandom01.c   |  2 +-
>   .../kernel/syscalls/getrandom/getrandom02.c   |  2 +-
>   .../kernel/syscalls/getrandom/getrandom03.c   |  2 +-
>   .../kernel/syscalls/getrandom/getrandom04.c   |  2 +-
>   .../syscalls/gettimeofday/gettimeofday01.c    |  2 +-
>   .../syscalls/inotify_init/inotify_init1_01.c  |  4 +-
>   .../syscalls/inotify_init/inotify_init1_02.c  |  4 +-
>   .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  2 +-
>   testcases/kernel/syscalls/linkat/linkat01.c   |  2 +-
>   testcases/kernel/syscalls/linkat/linkat02.c   |  2 +-
>   .../syscalls/migrate_pages/migrate_pages01.c  | 20 ++++----
>   testcases/kernel/syscalls/mknodat/mknodat.h   |  2 +-
>   testcases/kernel/syscalls/mknodat/mknodat02.c |  2 +-
>   .../kernel/syscalls/newuname/newuname01.c     |  2 +-
>   testcases/kernel/syscalls/openat/openat.h     |  2 +-
>   .../perf_event_open/perf_event_open01.c       |  2 +-
>   testcases/kernel/syscalls/ppoll/ppoll01.c     |  2 +-
>   testcases/kernel/syscalls/prctl/prctl05.c     |  2 +-
>   .../kernel/syscalls/renameat2/renameat2.h     |  2 +-
>   .../rt_sigprocmask/rt_sigprocmask01.c         |  6 +--
>   .../rt_sigprocmask/rt_sigprocmask02.c         |  2 +-
>   .../sched_get_priority_max01.c                |  2 +-
>   testcases/kernel/syscalls/select/select_var.h |  2 +-
>   .../set_thread_area/set_thread_area01.c       |  2 +-
>   .../set_tid_address/set_tid_address01.c       |  2 +-
>   .../syscalls/setdomainname/setdomainname.h    |  2 +-
>   .../kernel/syscalls/sgetmask/sgetmask01.c     |  4 +-
>   .../kernel/syscalls/signalfd/signalfd01.c     |  2 +-
>   .../kernel/syscalls/signalfd4/signalfd4_01.c  |  4 +-
>   .../kernel/syscalls/signalfd4/signalfd4_02.c  |  4 +-
>   .../kernel/syscalls/ssetmask/ssetmask01.c     |  6 +--
>   .../kernel/syscalls/symlinkat/symlinkat01.c   |  2 +-
>   .../timer_getoverrun/timer_getoverrun01.c     |  6 +--
>   testcases/kernel/syscalls/timerfd/timerfd02.c |  4 +-
>   testcases/kernel/syscalls/timerfd/timerfd03.c |  4 +-
>   testcases/kernel/syscalls/tkill/tkill01.c     |  2 +-
>   testcases/kernel/syscalls/tkill/tkill02.c     |  3 +-
>   testcases/kernel/syscalls/utils/compat_16.h   |  2 +-
>   78 files changed, 164 insertions(+), 187 deletions(-)
>
> diff --git a/include/lapi/fallocate.h b/include/lapi/fallocate.h
> index 92b6994a4..fc246bcfc 100644
> --- a/include/lapi/fallocate.h
> +++ b/include/lapi/fallocate.h
> @@ -36,19 +36,13 @@
>   
>   #if !defined(HAVE_FALLOCATE)
>   
> -# ifdef __TEST_H__
> -#  define TST_SYSCALL_WRAPPER ltp_syscall
> -# else
> -#  define TST_SYSCALL_WRAPPER tst_syscall
> -# endif /* __TEST_H__ */
> -
>   static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
>   {
>   	/* Deal with 32bit ABIs that have 64bit syscalls. */
>   # if LTP_USE_64_ABI
> -	return TST_SYSCALL_WRAPPER(__NR_fallocate, fd, mode, offset, len);
> +	return tst_syscall(__NR_fallocate, fd, mode, offset, len);
>   # else
> -	return (long)TST_SYSCALL_WRAPPER(__NR_fallocate, fd, mode,
> +	return (long)tst_syscall(__NR_fallocate, fd, mode,
>   				 __LONG_LONG_PAIR((off_t) (offset >> 32),
>   						  (off_t) offset),
>   				 __LONG_LONG_PAIR((off_t) (len >> 32),
> diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
> index 8c820059a..fe35ec3ae 100644
> --- a/include/lapi/init_module.h
> +++ b/include/lapi/init_module.h
> @@ -8,8 +8,8 @@
>   #define LAPI_INIT_MODULE_H__
>   
>   #include "config.h"
> -#include "lapi/syscalls.h"
>   #include "tst_test.h"
> +#include "lapi/syscalls.h"
>   
>   static inline int init_module(void *module_image, unsigned long len,
>   			      const char *param_values)
> diff --git a/include/lapi/mkdirat.h b/include/lapi/mkdirat.h
> index 4d452d684..72eb7f647 100644
> --- a/include/lapi/mkdirat.h
> +++ b/include/lapi/mkdirat.h
> @@ -13,7 +13,7 @@
>   #ifndef HAVE_MKDIRAT
>   static inline int mkdirat(int dirfd, const char *dirname, int mode)
>   {
> -	return ltp_syscall(__NR_mkdirat, dirfd, dirname, mode);
> +	return tst_syscall(__NR_mkdirat, dirfd, dirname, mode);
>   }
>   #endif
>   
> diff --git a/include/lapi/readlinkat.h b/include/lapi/readlinkat.h
> index bf1564823..a680deeec 100644
> --- a/include/lapi/readlinkat.h
> +++ b/include/lapi/readlinkat.h
> @@ -14,7 +14,7 @@
>   static inline int readlinkat(int dirfd, const char *pathname,
>                                char *buf, size_t bufsiz)
>   {
> -	return ltp_syscall(__NR_readlinkat, dirfd, pathname, buf, bufsiz);
> +	return tst_syscall(__NR_readlinkat, dirfd, pathname, buf, bufsiz);
>   }
>   #endif
>   
> diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
> index 0a9e8e595..abf4c1d6e 100644
> --- a/include/lapi/renameat.h
> +++ b/include/lapi/renameat.h
> @@ -15,7 +15,7 @@
>   static inline int renameat(int olddirfd, const char *oldpath, int newdirfd,
>                              const char *newpath)
>   {
> -	return ltp_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
> +	return tst_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
>   					newpath);
>   }
>   #endif
> diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
> index f368c07d8..a42b690d0 100644
> --- a/include/lapi/rt_sigaction.h
> +++ b/include/lapi/rt_sigaction.h
> @@ -157,12 +157,6 @@ __attribute__ ((optimize("Os"))) __attribute__((used)) restore_rt(void)
>   }
>   #endif
>   
> -#ifdef TST_TEST_H__
> -# define TST_SYSCALL tst_syscall
> -#else
> -# define TST_SYSCALL ltp_syscall
> -#endif
> -
>   /* This is a wrapper for __NR_rt_sigaction syscall.
>    * act/oact values of INVAL_SA_PTR is used to pass
>    * an invalid pointer to syscall(__NR_rt_sigaction)
> @@ -218,11 +212,11 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
>   
>   
>   #ifdef __sparc__
> -	ret = TST_SYSCALL(__NR_rt_sigaction, signum,
> +	ret = tst_syscall(__NR_rt_sigaction, signum,
>   			kact_p, koact_p,
>   			stub, sigsetsize);
>   #else
> -	ret = TST_SYSCALL(__NR_rt_sigaction, signum,
> +	ret = tst_syscall(__NR_rt_sigaction, signum,
>   			kact_p, koact_p,
>   			sigsetsize);
>   #endif
> diff --git a/include/lapi/sync_file_range.h b/include/lapi/sync_file_range.h
> index 2f81e446c..b1d2b2827 100644
> --- a/include/lapi/sync_file_range.h
> +++ b/include/lapi/sync_file_range.h
> @@ -13,12 +13,6 @@
>   
>   #if !defined(HAVE_SYNC_FILE_RANGE)
>   
> -#ifdef TST_TEST_H__
> -# define TST_SYSCALL tst_syscall
> -#else
> -# define TST_SYSCALL ltp_syscall
> -#endif
> -
>   /*****************************************************************************
>    * Wraper function to call sync_file_range system call
>    ******************************************************************************/
> @@ -28,29 +22,29 @@ static inline long sync_file_range(int fd, off64_t offset, off64_t nbytes,
>   #if (defined(__arm__) || defined(__powerpc__) || defined(__powerpc64__))
>   # ifdef TST_ABI32
>   #  if __BYTE_ORDER == __BIG_ENDIAN
> -	return TST_SYSCALL(__NR_sync_file_range2, fd, flags,
> +	return tst_syscall(__NR_sync_file_range2, fd, flags,
>   		(int)(offset >> 32), (int)offset, (int)(nbytes >> 32),
>   		(int)nbytes);
>   #  elif __BYTE_ORDER == __LITTLE_ENDIAN
> -	return TST_SYSCALL(__NR_sync_file_range2, fd, flags, (int)offset,
> +	return tst_syscall(__NR_sync_file_range2, fd, flags, (int)offset,
>   		       (int)(offset >> 32), nbytes, (int)(nbytes >> 32));
>   #  endif
>   # else
> -	return TST_SYSCALL(__NR_sync_file_range2, fd, flags, offset, nbytes);
> +	return tst_syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
>   # endif
>   #elif (defined(__s390__) || defined(__s390x__)) && defined(TST_ABI32)
> -	return TST_SYSCALL(__NR_sync_file_range, fd, (int)(offset >> 32),
> +	return tst_syscall(__NR_sync_file_range, fd, (int)(offset >> 32),
>   		(int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
>   #elif defined(__mips__) && defined(TST_ABI32)
>   # if __BYTE_ORDER == __BIG_ENDIAN
> -	return TST_SYSCALL(__NR_sync_file_range, fd, 0, (int)(offset >> 32),
> +	return tst_syscall(__NR_sync_file_range, fd, 0, (int)(offset >> 32),
>   		(int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
>   # elif __BYTE_ORDER == __LITTLE_ENDIAN
> -	return TST_SYSCALL(__NR_sync_file_range, fd, 0, (int)offset,
> +	return tst_syscall(__NR_sync_file_range, fd, 0, (int)offset,
>   		(int)(offset >> 32), (int)nbytes, (int)(nbytes >> 32), flags);
>   # endif
>   #else
> -	return TST_SYSCALL(__NR_sync_file_range, fd, offset, nbytes, flags);
> +	return tst_syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
>   #endif
>   }
>   #endif
> diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
> index d7daf8ad0..8fa381c97 100755
> --- a/include/lapi/syscalls/regen.sh
> +++ b/include/lapi/syscalls/regen.sh
> @@ -35,34 +35,30 @@ cat << EOF > "${output_pid}"
>   #include <asm/unistd.h>
>   #include "cleanup.c"
>   
> -#define ltp_syscall(NR, ...) ({ \\
> -	int __ret; \\
> -	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
> -		errno = ENOSYS; \\
> -		__ret = -1; \\
> -	} else { \\
> -		__ret = syscall(NR, ##__VA_ARGS__); \\
> -	} \\
> -	if (__ret == -1 && errno == ENOSYS) { \\
> -		tst_brkm(TCONF, CLEANUP, \\
> -			"syscall(%d) " #NR " not supported on your arch", \\
> -			NR); \\
> -	} \\
> -	__ret; \\
> +#ifdef TST_TEST_H__
> +#define TST_SYSCALL_BRK__(NR) ({ \
> +	tst_brk(TCONF, \
> +		"syscall(%d) " #NR " not supported on your arch", NR); \
>   })
> -
> -#define tst_syscall(NR, ...) ({ \\
> -	int tst_ret; \\
> -	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
> -		errno = ENOSYS; \\
> -		tst_ret = -1; \\
> -	} else { \\
> -		tst_ret = syscall(NR, ##__VA_ARGS__); \\
> -	} \\
> -	if (tst_ret == -1 && errno == ENOSYS) { \\
> -		tst_brk(TCONF, "syscall(%d) " #NR " not supported", NR); \\
> -	} \\
> -	tst_ret; \\
> +#else
> +#define TST_SYSCALL_BRK__(NR) ({ \
> +	tst_brkm(TCONF, CLEANUP, \
> +		"syscall(%d) " #NR " not supported on your arch", NR); \
> +})
> +#endif
> +
> +#define tst_syscall(NR, ...) ({ \
> +	int tst_ret; \
> +	if (NR == __LTP__NR_INVALID_SYSCALL) { \
> +		errno = ENOSYS; \
> +		tst_ret = -1; \
> +	} else { \
> +		tst_ret = syscall(NR, ##__VA_ARGS__); \
> +	} \
> +	if (tst_ret == -1 && errno == ENOSYS) { \
> +		TST_SYSCALL_BRK__(NR); \
> +	} \
> +	tst_ret; \
>   })
>   
>   EOF
> diff --git a/include/lapi/timerfd.h b/include/lapi/timerfd.h
> index 14f8405ab..2613746ca 100644
> --- a/include/lapi/timerfd.h
> +++ b/include/lapi/timerfd.h
> @@ -18,7 +18,7 @@
>   #if !defined(HAVE_TIMERFD_CREATE)
>   static inline int timerfd_create(int clockid, int flags)
>   {
> -	return ltp_syscall(__NR_timerfd_create, clockid, flags);
> +	return tst_syscall(__NR_timerfd_create, clockid, flags);
>   }
>   #endif
>   
> @@ -27,7 +27,7 @@ static inline int timerfd_settime(int fd, int flags,
>                                     const struct itimerspec *new_value,
>                                     struct itimerspec *old_value)
>   {
> -	return ltp_syscall(__NR_timerfd_settime, fd, flags, new_value,
> +	return tst_syscall(__NR_timerfd_settime, fd, flags, new_value,
>   			   old_value);
>   }
>   #endif
> @@ -35,7 +35,7 @@ static inline int timerfd_settime(int fd, int flags,
>   #if !defined(HAVE_TIMERFD_SETTIME)
>   static inline int timerfd_gettime(int fd, struct itimerspec *curr_value)
>   {
> -	return ltp_syscall(__NR_timerfd_gettime, fd, curr_value);
> +	return tst_syscall(__NR_timerfd_gettime, fd, curr_value);
>   }
>   #endif
>   
> diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
> index 2be949929..86899954d 100644
> --- a/libs/libltpsigwait/sigwait.c
> +++ b/libs/libltpsigwait/sigwait.c
> @@ -5,9 +5,9 @@
>   #include <errno.h>
>   #include <stdlib.h>
>   #include <limits.h>
> -#include "lapi/syscalls.h"
>   #include "libsigwait.h"
>   #include "tst_sig_proc.h"
> +#include "lapi/syscalls.h"
>   
>   void test_empty_set(swi_func sigwaitinfo, int signo,
>   		    enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index 796ac0334..a4427736f 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -8,9 +8,9 @@
>   
>   #define TST_NO_DEFAULT_MAIN
>   
> -#include "lapi/syscalls.h"
>   #include "tst_test.h"
>   #include "libswap.h"
> +#include "lapi/syscalls.h"
>   
>   /*
>    * Make a swap file
> diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
> index 7519676a1..b0a329d83 100644
> --- a/testcases/cve/cve-2016-10044.c
> +++ b/testcases/cve/cve-2016-10044.c
> @@ -14,10 +14,10 @@
>   #include <stdio.h>
>   #include <stdint.h>
>   #include <string.h>
> -#include "lapi/syscalls.h"
>   #include "lapi/personality.h"
>   #include "tst_test.h"
>   #include "tst_safe_stdio.h"
> +#include "lapi/syscalls.h"
>   
>   static FILE *f;
>   
> diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
> index 239674ff8..db0d9b2a5 100644
> --- a/testcases/kernel/containers/libclone/libclone.c
> +++ b/testcases/kernel/containers/libclone/libclone.c
> @@ -56,7 +56,7 @@ int do_unshare_tests(unsigned long clone_flags,
>   	}
>   	if (pid == 0) {
>   		close(retpipe[0]);
> -		ret = ltp_syscall(SYS_unshare, clone_flags);
> +		ret = tst_syscall(SYS_unshare, clone_flags);
>   		if (ret == -1) {
>   			if (write(retpipe[1], "0", 2) < 0) {
>   				perror("unshare:write(retpipe[1], ..)");
> diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
> index b4364ce95..1d109e020 100644
> --- a/testcases/kernel/containers/mqns/mqns_01.c
> +++ b/testcases/kernel/containers/mqns/mqns_01.c
> @@ -59,7 +59,7 @@ int check_mqueue(void *vtest)
>   		printf("read(p1[0], ...) failed: %s\n", strerror(errno));
>   		exit(1);
>   	}
> -	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
> +	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
>   	if (mqd == -1) {
>   		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0) {
>   			perror("write(p2[1], ...) failed");
> @@ -105,7 +105,7 @@ int main(int argc, char *argv[])
>   		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
>   	}
>   
> -	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
> +	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
>   		0777, NULL);
>   	if (mqd == -1) {
>   		perror("mq_open");
> @@ -118,7 +118,7 @@ int main(int argc, char *argv[])
>   	if (r < 0) {
>   		tst_resm(TFAIL, "failed clone/unshare");
>   		mq_close(mqd);
> -		ltp_syscall(__NR_mq_unlink, NOSLASH_MQ1);
> +		tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
>   		tst_exit();
>   	}
>   
> @@ -142,7 +142,7 @@ int main(int argc, char *argv[])
>   	if (mq_close(mqd) == -1) {
>   		tst_brkm(TBROK | TERRNO, NULL, "mq_close failed");
>   	}
> -	ltp_syscall(__NR_mq_unlink, NOSLASH_MQ1);
> +	tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
>   
>   	tst_exit();
>   }
> diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
> index 85edf91fe..d4e785b59 100644
> --- a/testcases/kernel/containers/mqns/mqns_02.c
> +++ b/testcases/kernel/containers/mqns/mqns_02.c
> @@ -64,7 +64,7 @@ int check_mqueue(void *vtest)
>   	} else {
>   
>   		mqd =
> -		    ltp_syscall(__NR_mq_open, NOSLASH_MQ1,
> +		    tst_syscall(__NR_mq_open, NOSLASH_MQ1,
>   			    O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
>   		if (mqd == -1) {
>   			if (write(p2[1], "mqfail", strlen("mqfail") + 1) < 0) {
> @@ -87,7 +87,7 @@ int check_mqueue(void *vtest)
>   					if (mq_close(mqd) < 0) {
>   						perror("mq_close(mqd) failed");
>   						exit(1);
> -					} else if (ltp_syscall(__NR_mq_unlink,
> +					} else if (tst_syscall(__NR_mq_unlink,
>   							   NOSLASH_MQ1) < 0) {
>   						perror("mq_unlink(" NOSLASH_MQ1
>   						       ") failed");
> @@ -161,7 +161,7 @@ int main(int argc, char *argv[])
>   		tst_resm(TFAIL, "child process could not create mqueue");
>   		umount(DEV_MQUEUE);
>   	} else {
> -		mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
> +		mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
>   		if (mqd == -1) {
>   			tst_resm(TPASS,
>   				 "Parent process can't see the mqueue");
> diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
> index e68ace866..a7452b970 100644
> --- a/testcases/kernel/containers/mqns/mqns_03.c
> +++ b/testcases/kernel/containers/mqns/mqns_03.c
> @@ -71,7 +71,7 @@ int check_mqueue(void *vtest)
>   		exit(1);
>   	}
>   
> -	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
> +	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
>   		0755, NULL);
>   	if (mqd == -1) {
>   		write(p2[1], "mqfail", 7);
> diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
> index a32e8b9aa..d07a85c04 100644
> --- a/testcases/kernel/containers/mqns/mqns_04.c
> +++ b/testcases/kernel/containers/mqns/mqns_04.c
> @@ -64,7 +64,7 @@ int check_mqueue(void *vtest)
>   
>   	read(p1[0], buf, 3);	/* go */
>   
> -	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
> +	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
>   		0755, NULL);
>   	if (mqd == -1) {
>   		write(p2[1], "mqfail", 7);
> diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
> index 3f82834b2..c8b0806c0 100644
> --- a/testcases/kernel/containers/pidns/pidns30.c
> +++ b/testcases/kernel/containers/pidns/pidns30.c
> @@ -91,7 +91,7 @@ static void remove_pipe(int *fd)
>   static void remove_mqueue(mqd_t mqd)
>   {
>   	mq_close(mqd);
> -	ltp_syscall(__NR_mq_unlink, mqname);
> +	tst_syscall(__NR_mq_unlink, mqname);
>   }
>   
>   static void cleanup(void)
> @@ -109,7 +109,7 @@ static void cleanup(void)
>   static void cleanup_child(void)
>   {
>   	if (mqd != -1) {
> -		ltp_syscall(__NR_mq_notify, mqd, NULL);
> +		tst_syscall(__NR_mq_notify, mqd, NULL);
>   	}
>   	cleanup();
>   }
> @@ -182,7 +182,7 @@ int child_fn(void *arg)
>   	while (read(father_to_child[0], buf, 1) != 1)
>   		sleep(1);
>   
> -	mqd = ltp_syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
> +	mqd = tst_syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
>   	if (mqd == -1) {
>   		perror("mq_open failed");
>   		return 1;
> @@ -193,7 +193,7 @@ int child_fn(void *arg)
>   	notif.sigev_notify = SIGEV_SIGNAL;
>   	notif.sigev_signo = SIGUSR1;
>   	notif.sigev_value.sival_int = mqd;
> -	if (ltp_syscall(__NR_mq_notify, mqd, &notif) == -1) {
> +	if (tst_syscall(__NR_mq_notify, mqd, &notif) == -1) {
>   		perror("mq_notify failed");
>   		return 1;
>   	} else
> @@ -248,7 +248,7 @@ int main(void)
>   		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
>   	}
>   
> -	ltp_syscall(__NR_mq_unlink, mqname);
> +	tst_syscall(__NR_mq_unlink, mqname);
>   
>   	/* container creation on PID namespace */
>   	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> @@ -256,7 +256,7 @@ int main(void)
>   		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
>   
>   	mqd =
> -	    ltp_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
> +	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
>   		    NULL);
>   	if (mqd == -1)
>   		tst_brkm(TBROK | TERRNO, cleanup, "mq_open failed");
> diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
> index fb8035d90..8821ec83c 100644
> --- a/testcases/kernel/containers/pidns/pidns31.c
> +++ b/testcases/kernel/containers/pidns/pidns31.c
> @@ -93,7 +93,7 @@ static void remove_pipe(int *fd)
>   static void remove_mqueue(mqd_t mqd)
>   {
>   	mq_close(mqd);
> -	ltp_syscall(__NR_mq_unlink, mqname);
> +	tst_syscall(__NR_mq_unlink, mqname);
>   }
>   
>   /*
> @@ -116,7 +116,7 @@ static void cleanup_resources(int step, mqd_t mqd)
>   		break;
>   
>   	case F_STEP_2:
> -		ltp_syscall(__NR_mq_notify, mqd, NULL);
> +		tst_syscall(__NR_mq_notify, mqd, NULL);
>   		/* fall through */
>   	case F_STEP_1:
>   		remove_mqueue(mqd);
> @@ -172,7 +172,7 @@ int child_fn(void *arg)
>   	}
>   	tst_resm(TINFO, "cinit: my father is ready to receive a message");
>   
> -	mqd = ltp_syscall(__NR_mq_open, mqname, O_WRONLY, 0, NULL);
> +	mqd = tst_syscall(__NR_mq_open, mqname, O_WRONLY, 0, NULL);
>   	if (mqd == (mqd_t) - 1) {
>   		tst_resm(TBROK, "cinit: mq_open() failed (%s)",
>   			 strerror(errno));
> @@ -264,9 +264,9 @@ int main(void)
>   		cleanup_mqueue(TBROK, NO_STEP, 0);
>   	}
>   
> -	ltp_syscall(__NR_mq_unlink, mqname);
> +	tst_syscall(__NR_mq_unlink, mqname);
>   	mqd =
> -	    ltp_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
> +	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
>   		    NULL);
>   	if (mqd == (mqd_t) - 1) {
>   		tst_resm(TBROK, "parent: mq_open() failed (%s)", @@ -289,7 +289,7 @@ int main(void) info.mqd = mqd; info.pid = cpid; 
> notif.sigev_value.sival_ptr = &info; - if (ltp_syscall(__NR_mq_notify, 
> mqd, &notif) == (mqd_t) -1) { + if (tst_syscall(__NR_mq_notify, mqd, 
> &notif) == (mqd_t) -1) { tst_resm(TBROK, "parent: mq_notify() failed (%s)",
>   			 strerror(errno));
>   		cleanup_mqueue(TBROK, F_STEP_1, mqd);
> diff --git a/testcases/kernel/containers/userns/userns04.c b/testcases/kernel/containers/userns/userns04.c
> index f7d6e8005..66d3388a9 100644
> --- a/testcases/kernel/containers/userns/userns04.c
> +++ b/testcases/kernel/containers/userns/userns04.c
> @@ -35,7 +35,7 @@ int TST_TOTAL = 1;
>   static void setup(void)
>   {
>   	check_newuser();
> -	ltp_syscall(__NR_setns, -1, 0);
> +	tst_syscall(__NR_setns, -1, 0);
>   	tst_tmpdir();
>   	TST_CHECKPOINT_INIT(NULL);
>   }
> @@ -56,7 +56,7 @@ static int child_fn2(void *arg)
>   	int exit_val = 0;
>   	int ret;
>   
> -	ret = ltp_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER);
> +	ret = tst_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER);
>   	if (ret != -1) {
>   		printf("child2 setns() unexpected success\n");
>   		exit_val = 1;
> @@ -95,7 +95,7 @@ static void test_cap_sys_admin(void)
>   	case -1:
>   		tst_brkm(TBROK | TERRNO, cleanup, "fork");
>   	case 0:
> -		if (ltp_syscall(__NR_setns, fd, CLONE_NEWUSER) == -1) {
> +		if (tst_syscall(__NR_setns, fd, CLONE_NEWUSER) == -1) {
>   			printf("parent pid setns failure: (%d) %s",
>   				errno, strerror(errno));
>   			exit(1);
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> index a687ad2ee..9a81c23eb 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> +++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> @@ -3083,19 +3083,19 @@ done:
>   
>   static int sched_setaffinity(pid_t pid, unsigned len, unsigned long *mask)
>   {
> -	return ltp_syscall(__NR_sched_setaffinity, pid, len, mask);
> +	return tst_syscall(__NR_sched_setaffinity, pid, len, mask);
>   }
>   
>   static int get_mempolicy(int *policy, unsigned long *nmask,
>   			 unsigned long maxnode, void *addr, int flags)
>   {
> -	return ltp_syscall(__NR_get_mempolicy, policy, nmask, maxnode,
> +	return tst_syscall(__NR_get_mempolicy, policy, nmask, maxnode,
>   		addr, flags);
>   }
>   
>   static int set_mempolicy(int mode, unsigned long *nmask, unsigned long maxnode)
>   {
> -	return ltp_syscall(__NR_set_mempolicy, mode, nmask, maxnode);
> +	return tst_syscall(__NR_set_mempolicy, mode, nmask, maxnode);
>   }
>   
>   struct cpuset_placement {
> diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
> index f9bd865e5..16f14d66b 100644
> --- a/testcases/kernel/syscalls/cma/process_vm01.c
> +++ b/testcases/kernel/syscalls/cma/process_vm01.c
> @@ -124,7 +124,7 @@ static void help(void)
>   
>   static void cma_test_params_read(struct process_vm_params *params)
>   {
> -	TEST(ltp_syscall(__NR_process_vm_readv,
> +	TEST(tst_syscall(__NR_process_vm_readv,
>   			 params->pid,
>   			 params->lvec, params->liovcnt,
>   			 params->rvec, params->riovcnt,
> @@ -133,7 +133,7 @@ static void cma_test_params_read(struct process_vm_params *params)
>   
>   static void cma_test_params_write(struct process_vm_params *params)
>   {
> -	TEST(ltp_syscall(__NR_process_vm_writev,
> +	TEST(tst_syscall(__NR_process_vm_writev,
>   			 params->pid,
>   			 params->lvec, params->liovcnt,
>   			 params->rvec, params->riovcnt,
> diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
> index ac53ed226..b705b946b 100644
> --- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
> +++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
> @@ -134,7 +134,7 @@ static void child_invoke(void)
>   	remote.iov_len = len;
>   
>   	tst_resm(TINFO, "child 1: reading string from same memory location.");
> -	TEST(ltp_syscall(__NR_process_vm_readv, pids[0],
> +	TEST(tst_syscall(__NR_process_vm_readv, pids[0],
>   			 &local, 1UL, &remote, 1UL, 0UL));
>   	if (TEST_RETURN != len)
>   		tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv"); @@ -150,7 +150,7 @@ static void setup(void) tst_require_root(); /* 
> Just a sanity check of the existence of syscall */ - 
> ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 
> 0UL); + tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 
> 0UL, 0UL); tst_tmpdir(); TST_CHECKPOINT_INIT(cleanup); diff --git 
> a/testcases/kernel/syscalls/cma/process_vm_readv03.c 
> b/testcases/kernel/syscalls/cma/process_vm_readv03.c index 
> 561146e5e..2333f7fd6 100644 --- 
> a/testcases/kernel/syscalls/cma/process_vm_readv03.c +++ 
> b/testcases/kernel/syscalls/cma/process_vm_readv03.c @@ -180,7 +180,7 
> @@ static long *fetch_remote_addrs(void) remote.iov_base = foo; 
> remote.iov_len = len; - TEST(ltp_syscall(__NR_process_vm_readv, 
> pids[0], &local, + TEST(tst_syscall(__NR_process_vm_readv, pids[0], 
> &local, 1UL, &remote, 1UL, 0UL)); if (TEST_RETURN != len) 
> tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv");
> @@ -213,7 +213,7 @@ static void child_invoke(int *bufsz_arr)
>   	tst_resm(TINFO, "child 1: %d local iovecs initialized.",
>   		 NUM_LOCAL_VECS);
>   
> -	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local,
> +	TEST(tst_syscall(__NR_process_vm_readv, pids[0], local,
>   			    (unsigned long)NUM_LOCAL_VECS, remote,
>   			    (unsigned long)nr_iovecs, 0UL));
>   	if (TEST_RETURN != bufsz)
> @@ -249,7 +249,7 @@ static void setup(void)
>   	tst_require_root();
>   
>   	/* Just a sanity check of the existence of syscall */
> -	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
> +	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
>   
>   	nr_iovecs = nflag ? SAFE_STRTOL(NULL, nr_opt, 1, IOV_MAX) : 10;
>   	bufsz = sflag ? SAFE_STRTOL(NULL, sz_opt, NUM_LOCAL_VECS, LONG_MAX)
> diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
> index ea2ca63d1..e70ead4ed 100644
> --- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
> +++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
> @@ -171,7 +171,7 @@ static void child_write(void)
>   	remote.iov_len = bufsz;
>   
>   	tst_resm(TINFO, "child 2: write to the same memory location.");
> -	TEST(ltp_syscall(__NR_process_vm_writev, pids[0], &local,
> +	TEST(tst_syscall(__NR_process_vm_writev, pids[0], &local,
>   			 1UL, &remote, 1UL, 0UL));
>   	if (TEST_RETURN != bufsz)
>   		tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv");
> @@ -182,7 +182,7 @@ static void setup(void)
>   	tst_require_root();
>   
>   	/* Just a sanity check of the existence of syscall */
> -	ltp_syscall(__NR_process_vm_writev, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
> +	tst_syscall(__NR_process_vm_writev, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
>   
>   	bufsz =
>   	    sflag ? SAFE_STRTOL(NULL, sz_opt, 1, LONG_MAX - PADDING_SIZE * 2)
> diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
> index 0d7d15a83..1c1630fa7 100644
> --- a/testcases/kernel/syscalls/connect/connect01.c
> +++ b/testcases/kernel/syscalls/connect/connect01.c
> @@ -129,7 +129,7 @@ static char *argv0;
>   static int sys_connect(int sockfd, const struct sockaddr *addr,
>   		socklen_t addrlen)
>   {
> -	return ltp_syscall(__NR_connect, sockfd, addr, addrlen);
> +	return tst_syscall(__NR_connect, sockfd, addr, addrlen);
>   }
>   
>   #define connect(sockfd, addr, addrlen) sys_connect(sockfd, addr, addrlen)
> diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
> index c4f6978c1..476551233 100644
> --- a/testcases/kernel/syscalls/delete_module/delete_module01.c
> +++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
> @@ -14,9 +14,9 @@
>    */
>   
>   #include <errno.h>
> -#include "lapi/syscalls.h"
>   #include "tst_test.h"
>   #include "tst_module.h"
> +#include "lapi/syscalls.h"
>   
>   #define MODULE_NAME	"dummy_del_mod"
>   #define MODULE_NAME_KO	"dummy_del_mod.ko" diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c 
> b/testcases/kernel/syscalls/eventfd/eventfd01.c index 
> 4d888910b..242e170e2 100644 --- 
> a/testcases/kernel/syscalls/eventfd/eventfd01.c +++ 
> b/testcases/kernel/syscalls/eventfd/eventfd01.c @@ -72,7 +72,7 @@ 
> static void setup(void); static int myeventfd(unsigned int initval, 
> int flags) { /* eventfd2 uses FLAGS but eventfd doesn't take FLAGS. */ 
> - return ltp_syscall(__NR_eventfd, initval); + return 
> tst_syscall(__NR_eventfd, initval); } /* diff --git 
> a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c 
> b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c index 
> c0c6a263c..c9ecdc58e 100644 --- 
> a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c +++ 
> b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c @@ -91,7 +91,7 @@ 
> int main(int argc, char *argv[]) } setup(); - fd = 
> ltp_syscall(__NR_eventfd2, 1, 0); + fd = tst_syscall(__NR_eventfd2, 1, 
> 0); if (fd == -1) { tst_brkm(TFAIL, cleanup, "eventfd2(0) failed");
>   	}
> @@ -104,7 +104,7 @@ int main(int argc, char *argv[])
>   	}
>   	close(fd);
>   
> -	fd = ltp_syscall(__NR_eventfd2, 1, EFD_CLOEXEC);
> +	fd = tst_syscall(__NR_eventfd2, 1, EFD_CLOEXEC);
>   	if (fd == -1) {
>   		tst_brkm(TFAIL, cleanup, "eventfd2(EFD_CLOEXEC) failed");
>   	}
> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> index 418c07c45..2125b528e 100644
> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> @@ -89,7 +89,7 @@ int main(int argc, char *argv[])
>   	setup();
>   
>   	tst_count = 0;
> -	fd = ltp_syscall(__NR_eventfd2, 1, 0);
> +	fd = tst_syscall(__NR_eventfd2, 1, 0);
>   	if (fd == -1) {
>   		tst_brkm(TFAIL, cleanup, "eventfd2(0) failed");
>   	}
> @@ -102,7 +102,7 @@ int main(int argc, char *argv[])
>   	}
>   	close(fd);
>   
> -	fd = ltp_syscall(__NR_eventfd2, 1, EFD_NONBLOCK);
> +	fd = tst_syscall(__NR_eventfd2, 1, EFD_NONBLOCK);
>   	if (fd == -1) {
>   		tst_brkm(TFAIL, cleanup, "eventfd2(EFD_NONBLOCK) failed");
>   	}
> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
> index 4c26b654e..e26714ddc 100644
> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
> @@ -52,7 +52,7 @@ void cleanup(void)
>   
>   static int eventfd2(int count, int flags)
>   {
> -	return ltp_syscall(__NR_eventfd2, count, flags);
> +	return tst_syscall(__NR_eventfd2, count, flags);
>   }
>   
>   static void xsem_wait(int fd)
> diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
> index d7bcbe9d6..5bf5b0218 100644
> --- a/testcases/kernel/syscalls/exit_group/exit_group01.c
> +++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
> @@ -42,7 +42,7 @@ static void verify_exit_group(void)
>   		tst_brkm(TFAIL | TERRNO, NULL, "fork failed");
>   
>   	if (cpid == 0) {
> -		TEST(ltp_syscall(__NR_exit_group, 4));
> +		TEST(tst_syscall(__NR_exit_group, 4));
>   	} else {
>   		w = SAFE_WAIT(NULL, &status);
>   
> diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
> index 807ab917b..1ab494e7a 100644
> --- a/testcases/kernel/syscalls/faccessat/faccessat01.c
> +++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
> @@ -64,7 +64,7 @@ static int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
>   
>   int myfaccessat(int dirfd, const char *filename, int mode)
>   {
> -	return ltp_syscall(__NR_faccessat, dirfd, filename, mode);
> +	return tst_syscall(__NR_faccessat, dirfd, filename, mode);
>   }
>   
>   int main(int ac, char **av)
> diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
> index 369f80eb2..9676ae0fd 100644
> --- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
> +++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
> @@ -64,7 +64,7 @@ int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
>   
>   int myfchmodat(int dirfd, const char *filename, mode_t mode)
>   {
> -	return ltp_syscall(__NR_fchmodat, dirfd, filename, mode);
> +	return tst_syscall(__NR_fchmodat, dirfd, filename, mode);
>   }
>   
>   int main(int ac, char **av)
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat.h b/testcases/kernel/syscalls/fchownat/fchownat.h
> index a95c26f93..927cf929a 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat.h
> +++ b/testcases/kernel/syscalls/fchownat/fchownat.h
> @@ -29,7 +29,7 @@
>   static inline int fchownat(int dirfd, const char *filename, uid_t owner,
>   		gid_t group, int flags)
>   {
> -	return ltp_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
> +	return tst_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
>   }
>   #endif
>   
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
> index 900308980..f6e2b01ff 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl31.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
> @@ -210,7 +210,7 @@ static void setownex_tid_test(void)
>   	}
>   
>   	tst_own_ex.type = F_OWNER_TID;
> -	tst_own_ex.pid = ltp_syscall(__NR_gettid);
> +	tst_own_ex.pid = tst_syscall(__NR_gettid);
>   
>   	TEST(fcntl(test_fd, F_SETOWN_EX, &tst_own_ex));
>   	if (TEST_RETURN< 0) { diff --git a/testcases/kernel/syscalls/fork/fork05.c 
> b/testcases/kernel/syscalls/fork/fork05.c index ce03dcd22..9a99cff1d 
> 100644 --- a/testcases/kernel/syscalls/fork/fork05.c +++ 
> b/testcases/kernel/syscalls/fork/fork05.c @@ -133,7 +133,7 @@ static 
> int a = 42; static void modify_ldt(int func, struct modify_ldt_ldt_s 
> *ptr, int bytecount) { - ltp_syscall(__NR_modify_ldt, func, ptr, 
> bytecount); + tst_syscall(__NR_modify_ldt, func, ptr, bytecount); } 
> int main(void) diff --git 
> a/testcases/kernel/syscalls/fstatat/fstatat01.c 
> b/testcases/kernel/syscalls/fstatat/fstatat01.c index 
> b5fa83735..28e3d472f 100644 --- 
> a/testcases/kernel/syscalls/fstatat/fstatat01.c +++ 
> b/testcases/kernel/syscalls/fstatat/fstatat01.c @@ -62,17 +62,17 @@ 
> static const int flags[] = { 0, 0, 0, 0, 9999, 0 }; #if (__NR_fstatat64 >  0)
>   int fstatat(int dirfd, const char *filename, struct stat64 *statbuf, int flags)
>   {
> -	return ltp_syscall(__NR_fstatat64, dirfd, filename, statbuf, flags);
> +	return tst_syscall(__NR_fstatat64, dirfd, filename, statbuf, flags);
>   }
>   #elif (__NR_newfstatat > 0)
>   int fstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
>   {
> -	return ltp_syscall(__NR_newfstatat, dirfd, filename, statbuf, flags);
> +	return tst_syscall(__NR_newfstatat, dirfd, filename, statbuf, flags);
>   }
>   #else
>   int fstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
>   {
> -	return ltp_syscall(__NR_fstatat, dirfd, filename, statbuf, flags);
> +	return tst_syscall(__NR_fstatat, dirfd, filename, statbuf, flags);
>   }
>   #endif
>   #endif
> diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
> index e3b1011e8..9b1e75b7f 100644
> --- a/testcases/kernel/syscalls/futimesat/futimesat01.c
> +++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
> @@ -58,7 +58,7 @@ static const int expected_errno[] = { 0, 0, ENOTDIR, EBADF, 0 };
>   
>   int myfutimesat(int dirfd, const char *filename, struct timeval *times)
>   {
> -	return ltp_syscall(__NR_futimesat, dirfd, filename, times);
> +	return tst_syscall(__NR_futimesat, dirfd, filename, times);
>   }
>   
>   int main(int ac, char **av)
> diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> index 222dc6f2e..1ff37bc9b 100644
> --- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> +++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> @@ -94,7 +94,7 @@ int main(int argc, char **argv)
>   		 * argument.
>   		 */
>   
> -		TEST(ltp_syscall(__NR_get_robust_list, 0,
> +		TEST(tst_syscall(__NR_get_robust_list, 0,
>   				      (struct robust_list_head *)&head,
>   				      NULL));
>   
> @@ -110,7 +110,7 @@ int main(int argc, char **argv)
>   			tst_resm(TFAIL,
>   				 "get_robust_list succeeded unexpectedly");
>   
> -		TEST(ltp_syscall(__NR_get_robust_list, 0,
> +		TEST(tst_syscall(__NR_get_robust_list, 0,
>   				      NULL,
>   				      &len_ptr));
>   
> @@ -131,7 +131,7 @@ int main(int argc, char **argv)
>   		 * find the task specified by the pid argument.
>   		 */
>   
> -		TEST(ltp_syscall(__NR_get_robust_list, unused_pid,
> +		TEST(tst_syscall(__NR_get_robust_list, unused_pid,
>   				      (struct robust_list_head *)&head,
>   				      &len_ptr));
>   
> @@ -147,7 +147,7 @@ int main(int argc, char **argv)
>   			tst_resm(TFAIL,
>   				 "get_robust_list succeeded unexpectedly");
>   
> -		TEST(ltp_syscall(__NR_get_robust_list, 0,
> +		TEST(tst_syscall(__NR_get_robust_list, 0,
>   				      (struct robust_list_head **)&head,
>   				      &len_ptr));
>   
> @@ -159,7 +159,7 @@ int main(int argc, char **argv)
>   
>   		SAFE_SETUID(cleanup, 1);
>   
> -		TEST(ltp_syscall(__NR_get_robust_list, 1,
> +		TEST(tst_syscall(__NR_get_robust_list, 1,
>   				      (struct robust_list_head *)&head,
>   				      &len_ptr));
>   
> diff --git a/testcases/kernel/syscalls/getrandom/getrandom01.c b/testcases/kernel/syscalls/getrandom/getrandom01.c
> index ccbd2864f..695f904a0 100644
> --- a/testcases/kernel/syscalls/getrandom/getrandom01.c
> +++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
> @@ -5,9 +5,9 @@
>    * Calls getrandom(2) with a NULL buffer and expects failure.
>    */
>   
> +#include "tst_test.h"
>   #include "lapi/getrandom.h"
>   #include "lapi/syscalls.h"
> -#include "tst_test.h"
>   
>   static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
>   		      GRND_RANDOM | GRND_NONBLOCK};
> diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
> index 1384fc5f3..b79e4ed6a 100644
> --- a/testcases/kernel/syscalls/getrandom/getrandom02.c
> +++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
> @@ -6,9 +6,9 @@
>    * and expects success.
>    */
>   
> +#include "tst_test.h"
>   #include "lapi/getrandom.h"
>   #include "lapi/syscalls.h"
> -#include "tst_test.h"
>   
>   #define PROC_ENTROPY_AVAIL "/proc/sys/kernel/random/entropy_avail"
>   
> diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
> index 705f9b288..afeb65d59 100644
> --- a/testcases/kernel/syscalls/getrandom/getrandom03.c
> +++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
> @@ -6,9 +6,9 @@
>    * number of bytes required and expects success.
>    */
>   
> +#include "tst_test.h"
>   #include "lapi/getrandom.h"
>   #include "lapi/syscalls.h"
> -#include "tst_test.h"
>   
>   #define MAX_SIZE 256
>   
> diff --git a/testcases/kernel/syscalls/getrandom/getrandom04.c b/testcases/kernel/syscalls/getrandom/getrandom04.c
> index 465e353e4..57b14881e 100644
> --- a/testcases/kernel/syscalls/getrandom/getrandom04.c
> +++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
> @@ -7,9 +7,9 @@
>    */
>   
>   #include <sys/resource.h>
> +#include "tst_test.h"
>   #include "lapi/getrandom.h"
>   #include "lapi/syscalls.h"
> -#include "tst_test.h"
>   
>   static void verify_getrandom(void)
>   {
> diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
> index 08ea1673a..f9acb9665 100644
> --- a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
> +++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
> @@ -61,7 +61,7 @@ int main(int ac, char **av)
>   	for (lc = 0; TEST_LOOPING(lc); lc++) {
>   		tst_count = 0;
>   
> -		TEST(ltp_syscall(__NR_gettimeofday, (void *)-1, (void *)-1));
> +		TEST(tst_syscall(__NR_gettimeofday, (void *)-1, (void *)-1));
>   
>   		/* gettimeofday returns an int, so we need to turn the long
>   		 * TEST_RETURN into an int to test with */
> diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> index f1b50fd4e..714077a34 100644
> --- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> +++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> @@ -135,7 +135,7 @@ int main(int argc, char *argv[])
>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>   		tst_count = 0;
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			fd = ltp_syscall(__NR_inotify_init1, 0);
> +			fd = tst_syscall(__NR_inotify_init1, 0);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL | TERRNO, cleanup,
>   					 "inotify_init1(0) failed");
> @@ -151,7 +151,7 @@ int main(int argc, char *argv[])
>   			}
>   			close(fd);
>   
> -			fd = ltp_syscall(__NR_inotify_init1, IN_CLOEXEC);
> +			fd = tst_syscall(__NR_inotify_init1, IN_CLOEXEC);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL | TERRNO, cleanup,
>   					 "inotify_init1(IN_CLOEXEC) failed");
> diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> index 3b0c7678e..5edcbfa3d 100644
> --- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> +++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> @@ -132,7 +132,7 @@ int main(int argc, char *argv[])
>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>   		tst_count = 0;
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			fd = ltp_syscall(__NR_inotify_init1, 0);
> +			fd = tst_syscall(__NR_inotify_init1, 0);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL | TERRNO, cleanup,
>   					 "inotify_init1(0) failed");
> @@ -149,7 +149,7 @@ int main(int argc, char *argv[])
>   			}
>   			close(fd);
>   
> -			fd = ltp_syscall(__NR_inotify_init1, IN_NONBLOCK);
> +			fd = tst_syscall(__NR_inotify_init1, IN_NONBLOCK);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL | TERRNO, cleanup,
>   					 "inotify_init1(IN_NONBLOCK) failed");
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
> index 8569322dc..228174c9b 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
> @@ -17,12 +17,12 @@
>    * message.
>    */
>   
> -#include "lapi/syscalls.h"
>   #include "tst_test.h"
>   #include "tst_fuzzy_sync.h"
>   #include "tst_safe_pthread.h"
>   #include "tst_safe_sysv_ipc.h"
>   #include "tst_timer.h"
> +#include "lapi/syscalls.h"
>   
>   static struct tst_fzsync_pair fzsync_pair;
>   
> diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
> index cde0910e1..70feb6b03 100644
> --- a/testcases/kernel/syscalls/linkat/linkat01.c
> +++ b/testcases/kernel/syscalls/linkat/linkat01.c
> @@ -192,7 +192,7 @@ int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
>   static int mylinkat(int olddirfd, const char *oldfilename, int newdirfd,
>   		    const char *newfilename, int flags)
>   {
> -	return ltp_syscall(__NR_linkat, olddirfd, oldfilename, newdirfd,
> +	return tst_syscall(__NR_linkat, olddirfd, oldfilename, newdirfd,
>   		       newfilename, flags);
>   }
>   
> diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
> index 566c76b1f..796190fef 100644
> --- a/testcases/kernel/syscalls/linkat/linkat02.c
> +++ b/testcases/kernel/syscalls/linkat/linkat02.c
> @@ -112,7 +112,7 @@ static void linkat_verify(const struct test_struct *desc)
>   		desc->setupfunc();
>   	}
>   
> -	TEST(ltp_syscall(__NR_linkat, AT_FDCWD, desc->oldfname,
> +	TEST(tst_syscall(__NR_linkat, AT_FDCWD, desc->oldfname,
>   			 AT_FDCWD, desc->newfname, desc->flags));
>   
>   	if (desc->cleanfunc != NULL)
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> index fa9315412..198ba3813 100644
> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> @@ -62,7 +62,7 @@ static void cleanup(void);
>   static void test_sane_nodes(void)
>   {
>   	tst_resm(TINFO, "test_empty_mask");
> -	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node,
> +	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node,
>   		     sane_old_nodes, sane_new_nodes));
>   	check_ret(0);
>   }
> @@ -72,14 +72,14 @@ static void test_invalid_pid(void)
>   	pid_t invalid_pid = -1;
>   
>   	tst_resm(TINFO, "test_invalid_pid -1");
> -	TEST(ltp_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
> +	TEST(tst_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
>   		     sane_old_nodes, sane_new_nodes));
>   	check_ret(-1);
>   	check_errno(ESRCH);
>   
>   	tst_resm(TINFO, "test_invalid_pid unused pid");
>   	invalid_pid = tst_get_unused_pid(cleanup);
> -	TEST(ltp_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
> +	TEST(tst_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
>   		     sane_old_nodes, sane_new_nodes));
>   	check_ret(-1);
>   	check_errno(ESRCH);
> @@ -88,7 +88,7 @@ static void test_invalid_pid(void)
>   static void test_invalid_masksize(void)
>   {
>   	tst_resm(TINFO, "test_invalid_masksize");
> -	TEST(ltp_syscall(__NR_migrate_pages, 0, -1, sane_old_nodes,
> +	TEST(tst_syscall(__NR_migrate_pages, 0, -1, sane_old_nodes,
>   		     sane_new_nodes));
>   	check_ret(-1);
>   	check_errno(EINVAL);
> @@ -99,7 +99,7 @@ static void test_invalid_mem(void)
>   	unsigned long *p;
>   
>   	tst_resm(TINFO, "test_invalid_mem -1");
> -	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, -1, -1));
> +	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, -1, -1));
>   	check_ret(-1);
>   	check_errno(EFAULT);
>   
> @@ -108,13 +108,13 @@ static void test_invalid_mem(void)
>   		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>   	if (p == MAP_FAILED)
>   		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
> -	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
> +	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
>   	check_ret(-1);
>   	check_errno(EFAULT);
>   
>   	SAFE_MUNMAP(cleanup, p, getpagesize());
>   	tst_resm(TINFO, "test_invalid_mem unmmaped");
> -	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
> +	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
>   	check_ret(-1);
>   	check_errno(EFAULT);
>   }
> @@ -143,7 +143,7 @@ static void test_invalid_nodes(void)
>   		memset(new_nodes, 0, sane_nodemask_size);
>   		set_bit(new_nodes, invalid_node, 1);
>   
> -		TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node,
> +		TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node,
>   			     old_nodes, new_nodes));
>   		check_ret(-1);
>   		check_errno(EINVAL);
> @@ -178,7 +178,7 @@ static void test_invalid_perm(void)
>   		if (ltpuser == NULL)
>   			tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
>   		SAFE_SETUID(NULL, ltpuser->pw_uid);
> -		TEST(ltp_syscall(__NR_migrate_pages, parent_pid,
> +		TEST(tst_syscall(__NR_migrate_pages, parent_pid,
>   			     sane_max_node, sane_old_nodes, sane_new_nodes));
>   		ret |= check_ret(-1);
>   		ret |= check_errno(EPERM);
> @@ -215,7 +215,7 @@ static void setup(void)
>   	int node, ret;
>   
>   	tst_require_root();
> -	TEST(ltp_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
> +	TEST(tst_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
>   
>   	if (!is_numa(NULL, NH_MEMS, 1))
>   		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
> diff --git a/testcases/kernel/syscalls/mknodat/mknodat.h b/testcases/kernel/syscalls/mknodat/mknodat.h
> index b4e828c5d..8f3a1f007 100644
> --- a/testcases/kernel/syscalls/mknodat/mknodat.h
> +++ b/testcases/kernel/syscalls/mknodat/mknodat.h
> @@ -28,7 +28,7 @@
>   #if !defined(HAVE_MKNODAT)
>   int mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
>   {
> -	return ltp_syscall(__NR_mknodat, dirfd, filename, mode, dev);
> +	return tst_syscall(__NR_mknodat, dirfd, filename, mode, dev);
>   }
>   #endif
>   
> diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
> index 7e6afda92..28c5c8a4b 100644
> --- a/testcases/kernel/syscalls/mknodat/mknodat02.c
> +++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
> @@ -163,7 +163,7 @@ static void mknodat_verify(struct test_case_t *tc)
>   	}
>   
>   	if (TEST_ERRNO == 0 &&
> -	    ltp_syscall(__NR_unlinkat, fd, pathname, 0) < 0) {
> +	    tst_syscall(__NR_unlinkat, fd, pathname, 0) < 0) {
>   		tst_brkm(TBROK | TERRNO, cleanup, "unlinkat(%d, %s) "
>   			 "failed.", fd, pathname);
>   	}
> diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
> index ebf2fcc10..2b9349e35 100644
> --- a/testcases/kernel/syscalls/newuname/newuname01.c
> +++ b/testcases/kernel/syscalls/newuname/newuname01.c
> @@ -115,7 +115,7 @@ int main(int ac, char **av)
>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>   		tst_count = 0;
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			TEST(ltp_syscall(__NR_uname, &name));
> +			TEST(tst_syscall(__NR_uname, &name));
>   			if (TEST_RETURN == -1) {
>   				tst_brkm(TFAIL, cleanup, "%s failed - errno = %d : %s",
>   					 TCID, TEST_ERRNO,
> diff --git a/testcases/kernel/syscalls/openat/openat.h b/testcases/kernel/syscalls/openat/openat.h
> index 9b5568bda..45d001833 100644
> --- a/testcases/kernel/syscalls/openat/openat.h
> +++ b/testcases/kernel/syscalls/openat/openat.h
> @@ -28,7 +28,7 @@
>   #if !defined(HAVE_OPENAT)
>   int openat(int dirfd, const char *pathname, int flags, mode_t mode)
>   {
> -	return ltp_syscall(__NR_openat, dirfd, pathname, flags, mode);
> +	return tst_syscall(__NR_openat, dirfd, pathname, flags, mode);
>   }
>   #endif
>   
> diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
> index 6286d415d..3807b2df1 100644
> --- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
> +++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
> @@ -123,7 +123,7 @@ static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
>   {
>   	int ret;
>   
> -	ret = ltp_syscall(__NR_perf_event_open, hw_event, pid, cpu,
> +	ret = tst_syscall(__NR_perf_event_open, hw_event, pid, cpu,
>   			  group_fd, flags);
>   	return ret;
>   }
> diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
> index 3d2f92f2a..606018af4 100644
> --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
> +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
> @@ -17,12 +17,12 @@
>   #include <stdlib.h>
>   #include <sys/types.h>
>   #include <sys/wait.h>
> -#include "lapi/syscalls.h"
>   #include "ltp_signal.h"
>   #include "time64_variants.h"
>   #include "tst_sig_proc.h"
>   #include "tst_test.h"
>   #include "tst_timer.h"
> +#include "lapi/syscalls.h"
>   
>   /* Older versions of glibc don't publish this constant's value. */
>   #ifndef POLLRDHUP
> diff --git a/testcases/kernel/syscalls/prctl/prctl05.c b/testcases/kernel/syscalls/prctl/prctl05.c
> index ae390fdfc..838e717f7 100644
> --- a/testcases/kernel/syscalls/prctl/prctl05.c
> +++ b/testcases/kernel/syscalls/prctl/prctl05.c
> @@ -16,9 +16,9 @@
>   #include <sys/prctl.h>
>   #include <string.h>
>   #include <stdio.h>
> +#include "tst_test.h"
>   #include "lapi/syscalls.h"
>   #include "lapi/prctl.h"
> -#include "tst_test.h"
>   
>   static struct tcase {
>   	char setname[20];
> diff --git a/testcases/kernel/syscalls/renameat2/renameat2.h b/testcases/kernel/syscalls/renameat2/renameat2.h
> index b04558d14..c4688ed53 100644
> --- a/testcases/kernel/syscalls/renameat2/renameat2.h
> +++ b/testcases/kernel/syscalls/renameat2/renameat2.h
> @@ -27,7 +27,7 @@
>   int renameat2(int olddirfd, const char *oldpath, int newdirfd,
>   				const char *newpath, unsigned int flags)
>   {
> -	return ltp_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
> +	return tst_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
>   						newpath, flags);
>   }
>   #endif
> diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> index 202e85386..e564a9430 100644
> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> @@ -105,7 +105,7 @@ int main(int ac, char **av)
>   					 "rt_sigaction call failed");
>   
>   			/* call rt_sigprocmask() to block signal#TEST_SIG */
> -			TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set,
> +			TEST(tst_syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set,
>   				     &oset, SIGSETSIZE));
>   			if (TEST_RETURN == -1)
>   				tst_brkm(TFAIL | TTERRNO, cleanup,
> @@ -123,7 +123,7 @@ int main(int ac, char **av)
>   					 "the process's signal mask");
>   			} else {
>   				/* call rt_sigpending() */
> -				TEST(ltp_syscall(__NR_rt_sigpending, &oset,
> +				TEST(tst_syscall(__NR_rt_sigpending, &oset,
>   					     SIGSETSIZE));
>   				if (TEST_RETURN == -1)
>   					tst_brkm(TFAIL | TTERRNO, cleanup,
> @@ -137,7 +137,7 @@ int main(int ac, char **av)
>   
>   				/* call rt_sigprocmask() to unblock
>   				 * signal#TEST_SIG */
> -				TEST(ltp_syscall(__NR_rt_sigprocmask,
> +				TEST(tst_syscall(__NR_rt_sigprocmask,
>   					     SIG_UNBLOCK, &set, &oset,
>   					     SIGSETSIZE));
>   				if (TEST_RETURN == -1)
> diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
> index 5c8c36b74..8c4724eb4 100644
> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
> @@ -104,7 +104,7 @@ int main(int ac, char **av)
>   			"Call to sigfillset() failed.");
>   
>   	for (i = 0; i < test_count; i++) {
> -		TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_BLOCK,
> +		TEST(tst_syscall(__NR_rt_sigprocmask, SIG_BLOCK,
>   			     &s, test_cases[i].ss, test_cases[i].sssize));
>   		if (TEST_RETURN == 0) {
>   			tst_resm(TFAIL | TTERRNO,
> diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
> index a1c54efd0..f6fe1add9 100644
> --- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
> +++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
> @@ -14,8 +14,8 @@
>    */
>   
>   #include <sched.h>
> -#include "lapi/syscalls.h"
>   #include "tst_test.h"
> +#include "lapi/syscalls.h"
>   
>   #define POLICY_DESC(x) .desc = #x, .policy = x
>   
> diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
> index a17b2fdd6..a945fa6b0 100644
> --- a/testcases/kernel/syscalls/select/select_var.h
> +++ b/testcases/kernel/syscalls/select/select_var.h
> @@ -5,8 +5,8 @@
>   #ifndef SELECT_VAR__
>   #define SELECT_VAR__
>   
> -#include "lapi/syscalls.h"
>   #include "tst_timer.h"
> +#include "lapi/syscalls.h"
>   
>   struct compat_sel_arg_struct {
>   	long _n;
> diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> index b8639a3d3..30626d5e9 100644
> --- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> @@ -74,7 +74,7 @@ int main(int argc, char *argv[])
>   
>   	for (lc = 0; TEST_LOOPING(lc); lc++) {
>   		for (i = 0; i < sizeof(tests) / sizeof(struct test); i++) {
> -			TEST(ltp_syscall(tests[i].syscall, tests[i].u_info));
> +			TEST(tst_syscall(tests[i].syscall, tests[i].u_info));
>   
>   			if (TEST_RETURN != tests[i].exp_ret) {
>   				tst_resm(TFAIL, "%s returned %li expected %i",
> diff --git a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
> index 20974a9e7..11fa27540 100644
> --- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
> +++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
> @@ -112,7 +112,7 @@ int main(int ac, char **av)
>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>   		tst_count = 0;
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			TEST(ltp_syscall(__NR_set_tid_address, &newtid));
> +			TEST(tst_syscall(__NR_set_tid_address, &newtid));
>   			if (TEST_RETURN == getpid()) {
>   				tst_resm(TPASS,
>   					 "set_tid_address call succeeded:  as expected %ld",
> diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname.h b/testcases/kernel/syscalls/setdomainname/setdomainname.h
> index 12c8a088f..dcacb0acf 100644
> --- a/testcases/kernel/syscalls/setdomainname/setdomainname.h
> +++ b/testcases/kernel/syscalls/setdomainname/setdomainname.h
> @@ -7,9 +7,9 @@
>   #define SETDOMAINNAME_H__
>   
>   #include <string.h>
> +#include "tst_test.h"
>   #include "lapi/utsname.h"
>   #include "lapi/syscalls.h"
> -#include "tst_test.h"
>   
>   #define TST_VALID_DOMAIN_NAME "test_dom"
>   
> diff --git a/testcases/kernel/syscalls/sgetmask/sgetmask01.c b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
> index 2b482f385..afd409128 100644
> --- a/testcases/kernel/syscalls/sgetmask/sgetmask01.c
> +++ b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
> @@ -125,11 +125,11 @@ int main(int ac, char **av)
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
>   
>   			for (sig = -3; sig <= SIGRTMAX + 1; sig++) {
> -				TEST(ltp_syscall(__NR_ssetmask, sig));
> +				TEST(tst_syscall(__NR_ssetmask, sig));
>   				tst_resm(TINFO, "Setting signal : %d -- "
>   					"return of setmask : %ld",
>   					sig, TEST_RETURN);
> -				TEST(ltp_syscall(__NR_sgetmask));
> +				TEST(tst_syscall(__NR_sgetmask));
>   				if (TEST_RETURN != sig) {
>   					tst_resm(TINFO,
>   						 "Oops,setting sig %d, got %ld",
> diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
> index 1a62156ff..3df941785 100644
> --- a/testcases/kernel/syscalls/signalfd/signalfd01.c
> +++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
> @@ -78,7 +78,7 @@ int main(void)
>   int signalfd(int fd, const sigset_t * mask, int flags)
>   {
>   	/* Taken from GLIBC. */
> -	return ltp_syscall(__NR_signalfd, fd, mask, SIGSETSIZE);
> +	return tst_syscall(__NR_signalfd, fd, mask, SIGSETSIZE);
>   }
>   #endif
>   
> diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> index 960c7ce98..7909f587a 100644
> --- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> +++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> @@ -141,7 +141,7 @@ int main(int argc, char *argv[])
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
>   			sigemptyset(&ss);
>   			sigaddset(&ss, SIGUSR1);
> -			fd = ltp_syscall(__NR_signalfd4, -1, &ss,
> +			fd = tst_syscall(__NR_signalfd4, -1, &ss,
>   				SIGSETSIZE, 0);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL, cleanup,
> @@ -158,7 +158,7 @@ int main(int argc, char *argv[])
>   			}
>   			close(fd);
>   
> -			fd = ltp_syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE,
> +			fd = tst_syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE,
>   				     SFD_CLOEXEC);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL,
> diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
> index ddf8b8c3d..4c9c2022a 100644
> --- a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
> +++ b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
> @@ -137,7 +137,7 @@ int main(int argc, char *argv[])
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
>   			sigemptyset(&ss);
>   			sigaddset(&ss, SIGUSR1);
> -			fd = ltp_syscall(__NR_signalfd4, -1, &ss,
> +			fd = tst_syscall(__NR_signalfd4, -1, &ss,
>   				SIGSETSIZE, 0);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL, cleanup,
> @@ -154,7 +154,7 @@ int main(int argc, char *argv[])
>   			}
>   			close(fd);
>   
> -			fd = ltp_syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE,
> +			fd = tst_syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE,
>   				     SFD_NONBLOCK);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL,
> diff --git a/testcases/kernel/syscalls/ssetmask/ssetmask01.c b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
> index 336a9be3f..ca3a1dedb 100644
> --- a/testcases/kernel/syscalls/ssetmask/ssetmask01.c
> +++ b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
> @@ -112,13 +112,13 @@ int main(int ac, char **av)
>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>   		tst_count = 0;
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			ltp_syscall(__NR_ssetmask, SIGALRM);
> -			TEST(ltp_syscall(__NR_sgetmask));
> +			tst_syscall(__NR_ssetmask, SIGALRM);
> +			TEST(tst_syscall(__NR_sgetmask));
>   			if (TEST_RETURN != SIGALRM) {
>   				tst_brkm(TFAIL | TTERRNO, cleanup,
>   					 "sgetmask() failed");
>   			}
> -			TEST(ltp_syscall(__NR_ssetmask, SIGUSR1));
> +			TEST(tst_syscall(__NR_ssetmask, SIGUSR1));
>   			if (TEST_RETURN != SIGALRM) {
>   				tst_brkm(TFAIL | TTERRNO, cleanup,
>   					 "ssetmask() failed");
> diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
> index 8c9e148e9..1687ea157 100644
> --- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
> +++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
> @@ -126,7 +126,7 @@ int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
>   static int mysymlinkat(const char *oldfilename,
>   		       int newdirfd, const char *newfilename)
>   {
> -	return ltp_syscall(__NR_symlinkat, oldfilename, newdirfd, newfilename);
> +	return tst_syscall(__NR_symlinkat, oldfilename, newdirfd, newfilename);
>   }
>   
>   int main(int ac, char **av)
> diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
> index ec5588410..aa9881f27 100644
> --- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
> +++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
> @@ -57,7 +57,7 @@ int main(int ac, char **av)
>   	ev.sigev_value = (union sigval) 0;
>   	ev.sigev_signo = SIGALRM;
>   	ev.sigev_notify = SIGEV_SIGNAL;
> -	TEST(ltp_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));
> +	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));
>   
>   	if (TEST_RETURN != 0)
>   		tst_brkm(TBROK | TTERRNO, cleanup, "Failed to create timer");
> @@ -65,7 +65,7 @@ int main(int ac, char **av)
>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>   		tst_count = 0;
>   
> -		TEST(ltp_syscall(__NR_timer_getoverrun, timer));
> +		TEST(tst_syscall(__NR_timer_getoverrun, timer));
>   		if (TEST_RETURN == 0) {
>   			tst_resm(TPASS,
>   			         "timer_getoverrun(CLOCK_REALTIME) Passed");
> @@ -74,7 +74,7 @@ int main(int ac, char **av)
>   			         "timer_getoverrun(CLOCK_REALTIME) Failed");
>   		}
>   
> -		TEST(ltp_syscall(__NR_timer_getoverrun, -1));
> +		TEST(tst_syscall(__NR_timer_getoverrun, -1));
>   		if (TEST_RETURN == -1 && TEST_ERRNO == EINVAL) {
>   			tst_resm(TPASS,	"timer_gettime(-1) Failed: EINVAL");
>   		} else {
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
> index 88742b806..9d2e3ff3c 100644
> --- a/testcases/kernel/syscalls/timerfd/timerfd02.c
> +++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
> @@ -137,7 +137,7 @@ int main(int argc, char *argv[])
>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>   		tst_count = 0;
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			fd = ltp_syscall(__NR_timerfd_create,
> +			fd = tst_syscall(__NR_timerfd_create,
>   				CLOCK_REALTIME, 0);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL, cleanup,
> @@ -154,7 +154,7 @@ int main(int argc, char *argv[])
>   			}
>   			close(fd);
>   
> -			fd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME,
> +			fd = tst_syscall(__NR_timerfd_create, CLOCK_REALTIME,
>   				     TFD_CLOEXEC);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL,
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
> index 41aa94636..ca70d1759 100644
> --- a/testcases/kernel/syscalls/timerfd/timerfd03.c
> +++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
> @@ -133,7 +133,7 @@ int main(int argc, char *argv[])
>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>   		tst_count = 0;
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			fd = ltp_syscall(__NR_timerfd_create,
> +			fd = tst_syscall(__NR_timerfd_create,
>   				CLOCK_REALTIME, 0);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL, cleanup,
> @@ -150,7 +150,7 @@ int main(int argc, char *argv[])
>   			}
>   			close(fd);
>   
> -			fd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME,
> +			fd = tst_syscall(__NR_timerfd_create, CLOCK_REALTIME,
>   				     TFD_NONBLOCK);
>   			if (fd == -1) {
>   				tst_brkm(TFAIL,
> diff --git a/testcases/kernel/syscalls/tkill/tkill01.c b/testcases/kernel/syscalls/tkill/tkill01.c
> index edce2b0b6..15f2dfb3e 100644
> --- a/testcases/kernel/syscalls/tkill/tkill01.c
> +++ b/testcases/kernel/syscalls/tkill/tkill01.c
> @@ -17,8 +17,8 @@
>   
>   #include <signal.h>
>   
> -#include "lapi/syscalls.h"
>   #include "tst_test.h"
> +#include "lapi/syscalls.h"
>   
>   static volatile sig_atomic_t sig_flag;
>   
> diff --git a/testcases/kernel/syscalls/tkill/tkill02.c b/testcases/kernel/syscalls/tkill/tkill02.c
> index 63fa664e4..6cd60923b 100644
> --- a/testcases/kernel/syscalls/tkill/tkill02.c
> +++ b/testcases/kernel/syscalls/tkill/tkill02.c
> @@ -20,10 +20,9 @@
>   #include <errno.h>
>   #include <unistd.h>
>   #include <signal.h>
> -#include <sys/syscall.h>
>   
> -#include "lapi/syscalls.h"
>   #include "tst_test.h"
> +#include "lapi/syscalls.h"
>   
>   static pid_t unused_tid;
>   static pid_t inval_tid = -1;
> diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
> index 75d5d2d28..d1f3dfd15 100644
> --- a/testcases/kernel/syscalls/utils/compat_16.h
> +++ b/testcases/kernel/syscalls/utils/compat_16.h
> @@ -45,7 +45,7 @@ int getresgid(gid_t *rgid, gid_t *egid, gid_t *sgid);
>   #ifdef TST_USE_COMPAT16_SYSCALL
>   # define LTP_CREATE_SYSCALL(sys_name, cleanup, ...) \
>   	if (__NR_##sys_name##32 != __LTP__NR_INVALID_SYSCALL) { \
> -		return ltp_syscall(__NR_##sys_name, ##__VA_ARGS__); \
> +		return tst_syscall(__NR_##sys_name, ##__VA_ARGS__); \
>   	} else { \
>   		tst_brkm(TCONF, cleanup, \
>   			"16-bit version of %s() is not supported on your " \
--------------FNVRmDBs5vKvDJfPxXawND8b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi, this is the wrong patch. Please consider v3</font><br>
    </p>
    <div class="moz-cite-prefix">On 1/24/22 16:03, Andrea Cervesato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220124150317.24616-1-andrea.cervesato@suse.de">
      <pre class="moz-quote-pre" wrap="">This modification is a first step into the old LTP API replacement and
it has
been completed with the following procedure:
- removed ltp_syscall
- replaced ltp_syscall with tst_syscall inside all tests
- reshuffled headers inside tests to import tst_test.h before
  lapi/syscalls.h

Signed-off-by: Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.de">&lt;andrea.cervesato@suse.de&gt;</a>
---
 include/lapi/fallocate.h                      | 10 +---
 include/lapi/init_module.h                    |  2 +-
 include/lapi/mkdirat.h                        |  2 +-
 include/lapi/readlinkat.h                     |  2 +-
 include/lapi/renameat.h                       |  2 +-
 include/lapi/rt_sigaction.h                   | 10 +---
 include/lapi/sync_file_range.h                | 20 +++-----
 include/lapi/syscalls/regen.sh                | 50 +++++++++----------
 include/lapi/timerfd.h                        |  6 +--
 libs/libltpsigwait/sigwait.c                  |  2 +-
 libs/libltpswap/libswap.c                     |  2 +-
 testcases/cve/cve-2016-10044.c                |  2 +-
 .../kernel/containers/libclone/libclone.c     |  2 +-
 testcases/kernel/containers/mqns/mqns_01.c    |  8 +--
 testcases/kernel/containers/mqns/mqns_02.c    |  6 +--
 testcases/kernel/containers/mqns/mqns_03.c    |  2 +-
 testcases/kernel/containers/mqns/mqns_04.c    |  2 +-
 testcases/kernel/containers/pidns/pidns30.c   | 12 ++---
 testcases/kernel/containers/pidns/pidns31.c   | 12 ++---
 testcases/kernel/containers/userns/userns04.c |  6 +--
 .../controllers/cpuset/cpuset_lib/libcpuset.c |  6 +--
 testcases/kernel/syscalls/cma/process_vm01.c  |  4 +-
 .../kernel/syscalls/cma/process_vm_readv02.c  |  4 +-
 .../kernel/syscalls/cma/process_vm_readv03.c  |  6 +--
 .../kernel/syscalls/cma/process_vm_writev02.c |  4 +-
 testcases/kernel/syscalls/connect/connect01.c |  2 +-
 .../syscalls/delete_module/delete_module01.c  |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd01.c |  2 +-
 .../kernel/syscalls/eventfd2/eventfd2_01.c    |  4 +-
 .../kernel/syscalls/eventfd2/eventfd2_02.c    |  4 +-
 .../kernel/syscalls/eventfd2/eventfd2_03.c    |  2 +-
 .../kernel/syscalls/exit_group/exit_group01.c |  2 +-
 .../kernel/syscalls/faccessat/faccessat01.c   |  2 +-
 .../kernel/syscalls/fchmodat/fchmodat01.c     |  2 +-
 testcases/kernel/syscalls/fchownat/fchownat.h |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl31.c     |  2 +-
 testcases/kernel/syscalls/fork/fork05.c       |  2 +-
 testcases/kernel/syscalls/fstatat/fstatat01.c |  6 +--
 .../kernel/syscalls/futimesat/futimesat01.c   |  2 +-
 .../get_robust_list/get_robust_list01.c       | 10 ++--
 .../kernel/syscalls/getrandom/getrandom01.c   |  2 +-
 .../kernel/syscalls/getrandom/getrandom02.c   |  2 +-
 .../kernel/syscalls/getrandom/getrandom03.c   |  2 +-
 .../kernel/syscalls/getrandom/getrandom04.c   |  2 +-
 .../syscalls/gettimeofday/gettimeofday01.c    |  2 +-
 .../syscalls/inotify_init/inotify_init1_01.c  |  4 +-
 .../syscalls/inotify_init/inotify_init1_02.c  |  4 +-
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  2 +-
 testcases/kernel/syscalls/linkat/linkat01.c   |  2 +-
 testcases/kernel/syscalls/linkat/linkat02.c   |  2 +-
 .../syscalls/migrate_pages/migrate_pages01.c  | 20 ++++----
 testcases/kernel/syscalls/mknodat/mknodat.h   |  2 +-
 testcases/kernel/syscalls/mknodat/mknodat02.c |  2 +-
 .../kernel/syscalls/newuname/newuname01.c     |  2 +-
 testcases/kernel/syscalls/openat/openat.h     |  2 +-
 .../perf_event_open/perf_event_open01.c       |  2 +-
 testcases/kernel/syscalls/ppoll/ppoll01.c     |  2 +-
 testcases/kernel/syscalls/prctl/prctl05.c     |  2 +-
 .../kernel/syscalls/renameat2/renameat2.h     |  2 +-
 .../rt_sigprocmask/rt_sigprocmask01.c         |  6 +--
 .../rt_sigprocmask/rt_sigprocmask02.c         |  2 +-
 .../sched_get_priority_max01.c                |  2 +-
 testcases/kernel/syscalls/select/select_var.h |  2 +-
 .../set_thread_area/set_thread_area01.c       |  2 +-
 .../set_tid_address/set_tid_address01.c       |  2 +-
 .../syscalls/setdomainname/setdomainname.h    |  2 +-
 .../kernel/syscalls/sgetmask/sgetmask01.c     |  4 +-
 .../kernel/syscalls/signalfd/signalfd01.c     |  2 +-
 .../kernel/syscalls/signalfd4/signalfd4_01.c  |  4 +-
 .../kernel/syscalls/signalfd4/signalfd4_02.c  |  4 +-
 .../kernel/syscalls/ssetmask/ssetmask01.c     |  6 +--
 .../kernel/syscalls/symlinkat/symlinkat01.c   |  2 +-
 .../timer_getoverrun/timer_getoverrun01.c     |  6 +--
 testcases/kernel/syscalls/timerfd/timerfd02.c |  4 +-
 testcases/kernel/syscalls/timerfd/timerfd03.c |  4 +-
 testcases/kernel/syscalls/tkill/tkill01.c     |  2 +-
 testcases/kernel/syscalls/tkill/tkill02.c     |  3 +-
 testcases/kernel/syscalls/utils/compat_16.h   |  2 +-
 78 files changed, 164 insertions(+), 187 deletions(-)

diff --git a/include/lapi/fallocate.h b/include/lapi/fallocate.h
index 92b6994a4..fc246bcfc 100644
--- a/include/lapi/fallocate.h
+++ b/include/lapi/fallocate.h
@@ -36,19 +36,13 @@
 
 #if !defined(HAVE_FALLOCATE)
 
-# ifdef __TEST_H__
-#  define TST_SYSCALL_WRAPPER ltp_syscall
-# else
-#  define TST_SYSCALL_WRAPPER tst_syscall
-# endif /* __TEST_H__ */
-
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 	/* Deal with 32bit ABIs that have 64bit syscalls. */
 # if LTP_USE_64_ABI
-	return TST_SYSCALL_WRAPPER(__NR_fallocate, fd, mode, offset, len);
+	return tst_syscall(__NR_fallocate, fd, mode, offset, len);
 # else
-	return (long)TST_SYSCALL_WRAPPER(__NR_fallocate, fd, mode,
+	return (long)tst_syscall(__NR_fallocate, fd, mode,
 				 __LONG_LONG_PAIR((off_t) (offset &gt;&gt; 32),
 						  (off_t) offset),
 				 __LONG_LONG_PAIR((off_t) (len &gt;&gt; 32),
diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
index 8c820059a..fe35ec3ae 100644
--- a/include/lapi/init_module.h
+++ b/include/lapi/init_module.h
@@ -8,8 +8,8 @@
 #define LAPI_INIT_MODULE_H__
 
 #include &quot;config.h&quot;
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;tst_test.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 static inline int init_module(void *module_image, unsigned long len,
 			      const char *param_values)
diff --git a/include/lapi/mkdirat.h b/include/lapi/mkdirat.h
index 4d452d684..72eb7f647 100644
--- a/include/lapi/mkdirat.h
+++ b/include/lapi/mkdirat.h
@@ -13,7 +13,7 @@
 #ifndef HAVE_MKDIRAT
 static inline int mkdirat(int dirfd, const char *dirname, int mode)
 {
-	return ltp_syscall(__NR_mkdirat, dirfd, dirname, mode);
+	return tst_syscall(__NR_mkdirat, dirfd, dirname, mode);
 }
 #endif
 
diff --git a/include/lapi/readlinkat.h b/include/lapi/readlinkat.h
index bf1564823..a680deeec 100644
--- a/include/lapi/readlinkat.h
+++ b/include/lapi/readlinkat.h
@@ -14,7 +14,7 @@
 static inline int readlinkat(int dirfd, const char *pathname,
                              char *buf, size_t bufsiz)
 {
-	return ltp_syscall(__NR_readlinkat, dirfd, pathname, buf, bufsiz);
+	return tst_syscall(__NR_readlinkat, dirfd, pathname, buf, bufsiz);
 }
 #endif
 
diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
index 0a9e8e595..abf4c1d6e 100644
--- a/include/lapi/renameat.h
+++ b/include/lapi/renameat.h
@@ -15,7 +15,7 @@
 static inline int renameat(int olddirfd, const char *oldpath, int newdirfd,
                            const char *newpath)
 {
-	return ltp_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
+	return tst_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
 					newpath);
 }
 #endif
diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index f368c07d8..a42b690d0 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -157,12 +157,6 @@ __attribute__ ((optimize(&quot;Os&quot;))) __attribute__((used)) restore_rt(void)
 }
 #endif
 
-#ifdef TST_TEST_H__
-# define TST_SYSCALL tst_syscall
-#else
-# define TST_SYSCALL ltp_syscall
-#endif
-
 /* This is a wrapper for __NR_rt_sigaction syscall.
  * act/oact values of INVAL_SA_PTR is used to pass
  * an invalid pointer to syscall(__NR_rt_sigaction)
@@ -218,11 +212,11 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
 
 
 #ifdef __sparc__
-	ret = TST_SYSCALL(__NR_rt_sigaction, signum,
+	ret = tst_syscall(__NR_rt_sigaction, signum,
 			kact_p, koact_p,
 			stub, sigsetsize);
 #else
-	ret = TST_SYSCALL(__NR_rt_sigaction, signum,
+	ret = tst_syscall(__NR_rt_sigaction, signum,
 			kact_p, koact_p,
 			sigsetsize);
 #endif
diff --git a/include/lapi/sync_file_range.h b/include/lapi/sync_file_range.h
index 2f81e446c..b1d2b2827 100644
--- a/include/lapi/sync_file_range.h
+++ b/include/lapi/sync_file_range.h
@@ -13,12 +13,6 @@
 
 #if !defined(HAVE_SYNC_FILE_RANGE)
 
-#ifdef TST_TEST_H__
-# define TST_SYSCALL tst_syscall
-#else
-# define TST_SYSCALL ltp_syscall
-#endif
-
 /*****************************************************************************
  * Wraper function to call sync_file_range system call
  ******************************************************************************/
@@ -28,29 +22,29 @@ static inline long sync_file_range(int fd, off64_t offset, off64_t nbytes,
 #if (defined(__arm__) || defined(__powerpc__) || defined(__powerpc64__))
 # ifdef TST_ABI32
 #  if __BYTE_ORDER == __BIG_ENDIAN
-	return TST_SYSCALL(__NR_sync_file_range2, fd, flags,
+	return tst_syscall(__NR_sync_file_range2, fd, flags,
 		(int)(offset &gt;&gt; 32), (int)offset, (int)(nbytes &gt;&gt; 32),
 		(int)nbytes);
 #  elif __BYTE_ORDER == __LITTLE_ENDIAN
-	return TST_SYSCALL(__NR_sync_file_range2, fd, flags, (int)offset,
+	return tst_syscall(__NR_sync_file_range2, fd, flags, (int)offset,
 		       (int)(offset &gt;&gt; 32), nbytes, (int)(nbytes &gt;&gt; 32));
 #  endif
 # else
-	return TST_SYSCALL(__NR_sync_file_range2, fd, flags, offset, nbytes);
+	return tst_syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
 # endif
 #elif (defined(__s390__) || defined(__s390x__)) &amp;&amp; defined(TST_ABI32)
-	return TST_SYSCALL(__NR_sync_file_range, fd, (int)(offset &gt;&gt; 32),
+	return tst_syscall(__NR_sync_file_range, fd, (int)(offset &gt;&gt; 32),
 		(int)offset, (int)(nbytes &gt;&gt; 32), (int)nbytes, flags);
 #elif defined(__mips__) &amp;&amp; defined(TST_ABI32)
 # if __BYTE_ORDER == __BIG_ENDIAN
-	return TST_SYSCALL(__NR_sync_file_range, fd, 0, (int)(offset &gt;&gt; 32),
+	return tst_syscall(__NR_sync_file_range, fd, 0, (int)(offset &gt;&gt; 32),
 		(int)offset, (int)(nbytes &gt;&gt; 32), (int)nbytes, flags);
 # elif __BYTE_ORDER == __LITTLE_ENDIAN
-	return TST_SYSCALL(__NR_sync_file_range, fd, 0, (int)offset,
+	return tst_syscall(__NR_sync_file_range, fd, 0, (int)offset,
 		(int)(offset &gt;&gt; 32), (int)nbytes, (int)(nbytes &gt;&gt; 32), flags);
 # endif
 #else
-	return TST_SYSCALL(__NR_sync_file_range, fd, offset, nbytes, flags);
+	return tst_syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
 #endif
 }
 #endif
diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index d7daf8ad0..8fa381c97 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -35,34 +35,30 @@ cat &lt;&lt; EOF &gt; &quot;${output_pid}&quot;
 #include &lt;asm/unistd.h&gt;
 #include &quot;cleanup.c&quot;
 
-#define ltp_syscall(NR, ...) ({ \\
-	int __ret; \\
-	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
-		errno = ENOSYS; \\
-		__ret = -1; \\
-	} else { \\
-		__ret = syscall(NR, ##__VA_ARGS__); \\
-	} \\
-	if (__ret == -1 &amp;&amp; errno == ENOSYS) { \\
-		tst_brkm(TCONF, CLEANUP, \\
-			&quot;syscall(%d) &quot; #NR &quot; not supported on your arch&quot;, \\
-			NR); \\
-	} \\
-	__ret; \\
+#ifdef TST_TEST_H__
+#define TST_SYSCALL_BRK__(NR) ({ \
+	tst_brk(TCONF, \
+		&quot;syscall(%d) &quot; #NR &quot; not supported on your arch&quot;, NR); \
 })
-
-#define tst_syscall(NR, ...) ({ \\
-	int tst_ret; \\
-	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
-		errno = ENOSYS; \\
-		tst_ret = -1; \\
-	} else { \\
-		tst_ret = syscall(NR, ##__VA_ARGS__); \\
-	} \\
-	if (tst_ret == -1 &amp;&amp; errno == ENOSYS) { \\
-		tst_brk(TCONF, &quot;syscall(%d) &quot; #NR &quot; not supported&quot;, NR); \\
-	} \\
-	tst_ret; \\
+#else
+#define TST_SYSCALL_BRK__(NR) ({ \
+	tst_brkm(TCONF, CLEANUP, \
+		&quot;syscall(%d) &quot; #NR &quot; not supported on your arch&quot;, NR); \
+})
+#endif
+
+#define tst_syscall(NR, ...) ({ \
+	int tst_ret; \
+	if (NR == __LTP__NR_INVALID_SYSCALL) { \
+		errno = ENOSYS; \
+		tst_ret = -1; \
+	} else { \
+		tst_ret = syscall(NR, ##__VA_ARGS__); \
+	} \
+	if (tst_ret == -1 &amp;&amp; errno == ENOSYS) { \
+		TST_SYSCALL_BRK__(NR); \
+	} \
+	tst_ret; \
 })
 
 EOF
diff --git a/include/lapi/timerfd.h b/include/lapi/timerfd.h
index 14f8405ab..2613746ca 100644
--- a/include/lapi/timerfd.h
+++ b/include/lapi/timerfd.h
@@ -18,7 +18,7 @@
 #if !defined(HAVE_TIMERFD_CREATE)
 static inline int timerfd_create(int clockid, int flags)
 {
-	return ltp_syscall(__NR_timerfd_create, clockid, flags);
+	return tst_syscall(__NR_timerfd_create, clockid, flags);
 }
 #endif
 
@@ -27,7 +27,7 @@ static inline int timerfd_settime(int fd, int flags,
                                   const struct itimerspec *new_value,
                                   struct itimerspec *old_value)
 {
-	return ltp_syscall(__NR_timerfd_settime, fd, flags, new_value,
+	return tst_syscall(__NR_timerfd_settime, fd, flags, new_value,
 			   old_value);
 }
 #endif
@@ -35,7 +35,7 @@ static inline int timerfd_settime(int fd, int flags,
 #if !defined(HAVE_TIMERFD_SETTIME)
 static inline int timerfd_gettime(int fd, struct itimerspec *curr_value)
 {
-	return ltp_syscall(__NR_timerfd_gettime, fd, curr_value);
+	return tst_syscall(__NR_timerfd_gettime, fd, curr_value);
 }
 #endif
 
diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
index 2be949929..86899954d 100644
--- a/libs/libltpsigwait/sigwait.c
+++ b/libs/libltpsigwait/sigwait.c
@@ -5,9 +5,9 @@
 #include &lt;errno.h&gt;
 #include &lt;stdlib.h&gt;
 #include &lt;limits.h&gt;
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;libsigwait.h&quot;
 #include &quot;tst_sig_proc.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 void test_empty_set(swi_func sigwaitinfo, int signo,
 		    enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 796ac0334..a4427736f 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -8,9 +8,9 @@
 
 #define TST_NO_DEFAULT_MAIN
 
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;tst_test.h&quot;
 #include &quot;libswap.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 /*
  * Make a swap file
diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index 7519676a1..b0a329d83 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -14,10 +14,10 @@
 #include &lt;stdio.h&gt;
 #include &lt;stdint.h&gt;
 #include &lt;string.h&gt;
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;lapi/personality.h&quot;
 #include &quot;tst_test.h&quot;
 #include &quot;tst_safe_stdio.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 static FILE *f;
 
diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
index 239674ff8..db0d9b2a5 100644
--- a/testcases/kernel/containers/libclone/libclone.c
+++ b/testcases/kernel/containers/libclone/libclone.c
@@ -56,7 +56,7 @@ int do_unshare_tests(unsigned long clone_flags,
 	}
 	if (pid == 0) {
 		close(retpipe[0]);
-		ret = ltp_syscall(SYS_unshare, clone_flags);
+		ret = tst_syscall(SYS_unshare, clone_flags);
 		if (ret == -1) {
 			if (write(retpipe[1], &quot;0&quot;, 2) &lt; 0) {
 				perror(&quot;unshare:write(retpipe[1], ..)&quot;);
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index b4364ce95..1d109e020 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -59,7 +59,7 @@ int check_mqueue(void *vtest)
 		printf(&quot;read(p1[0], ...) failed: %s\n&quot;, strerror(errno));
 		exit(1);
 	}
-	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
+	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
 	if (mqd == -1) {
 		if (write(p2[1], &quot;notfnd&quot;, strlen(&quot;notfnd&quot;) + 1) &lt; 0) {
 			perror(&quot;write(p2[1], ...) failed&quot;);
@@ -105,7 +105,7 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK | TERRNO, NULL, &quot;pipe failed&quot;);
 	}
 
-	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
+	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
 		0777, NULL);
 	if (mqd == -1) {
 		perror(&quot;mq_open&quot;);
@@ -118,7 +118,7 @@ int main(int argc, char *argv[])
 	if (r &lt; 0) {
 		tst_resm(TFAIL, &quot;failed clone/unshare&quot;);
 		mq_close(mqd);
-		ltp_syscall(__NR_mq_unlink, NOSLASH_MQ1);
+		tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
 		tst_exit();
 	}
 
@@ -142,7 +142,7 @@ int main(int argc, char *argv[])
 	if (mq_close(mqd) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL, &quot;mq_close failed&quot;);
 	}
-	ltp_syscall(__NR_mq_unlink, NOSLASH_MQ1);
+	tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
 
 	tst_exit();
 }
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index 85edf91fe..d4e785b59 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -64,7 +64,7 @@ int check_mqueue(void *vtest)
 	} else {
 
 		mqd =
-		    ltp_syscall(__NR_mq_open, NOSLASH_MQ1,
+		    tst_syscall(__NR_mq_open, NOSLASH_MQ1,
 			    O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
 		if (mqd == -1) {
 			if (write(p2[1], &quot;mqfail&quot;, strlen(&quot;mqfail&quot;) + 1) &lt; 0) {
@@ -87,7 +87,7 @@ int check_mqueue(void *vtest)
 					if (mq_close(mqd) &lt; 0) {
 						perror(&quot;mq_close(mqd) failed&quot;);
 						exit(1);
-					} else if (ltp_syscall(__NR_mq_unlink,
+					} else if (tst_syscall(__NR_mq_unlink,
 							   NOSLASH_MQ1) &lt; 0) {
 						perror(&quot;mq_unlink(&quot; NOSLASH_MQ1
 						       &quot;) failed&quot;);
@@ -161,7 +161,7 @@ int main(int argc, char *argv[])
 		tst_resm(TFAIL, &quot;child process could not create mqueue&quot;);
 		umount(DEV_MQUEUE);
 	} else {
-		mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
+		mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
 		if (mqd == -1) {
 			tst_resm(TPASS,
 				 &quot;Parent process can't see the mqueue&quot;);
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index e68ace866..a7452b970 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -71,7 +71,7 @@ int check_mqueue(void *vtest)
 		exit(1);
 	}
 
-	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
+	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
 		0755, NULL);
 	if (mqd == -1) {
 		write(p2[1], &quot;mqfail&quot;, 7);
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index a32e8b9aa..d07a85c04 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -64,7 +64,7 @@ int check_mqueue(void *vtest)
 
 	read(p1[0], buf, 3);	/* go */
 
-	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
+	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
 		0755, NULL);
 	if (mqd == -1) {
 		write(p2[1], &quot;mqfail&quot;, 7);
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index 3f82834b2..c8b0806c0 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -91,7 +91,7 @@ static void remove_pipe(int *fd)
 static void remove_mqueue(mqd_t mqd)
 {
 	mq_close(mqd);
-	ltp_syscall(__NR_mq_unlink, mqname);
+	tst_syscall(__NR_mq_unlink, mqname);
 }
 
 static void cleanup(void)
@@ -109,7 +109,7 @@ static void cleanup(void)
 static void cleanup_child(void)
 {
 	if (mqd != -1) {
-		ltp_syscall(__NR_mq_notify, mqd, NULL);
+		tst_syscall(__NR_mq_notify, mqd, NULL);
 	}
 	cleanup();
 }
@@ -182,7 +182,7 @@ int child_fn(void *arg)
 	while (read(father_to_child[0], buf, 1) != 1)
 		sleep(1);
 
-	mqd = ltp_syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
+	mqd = tst_syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
 	if (mqd == -1) {
 		perror(&quot;mq_open failed&quot;);
 		return 1;
@@ -193,7 +193,7 @@ int child_fn(void *arg)
 	notif.sigev_notify = SIGEV_SIGNAL;
 	notif.sigev_signo = SIGUSR1;
 	notif.sigev_value.sival_int = mqd;
-	if (ltp_syscall(__NR_mq_notify, mqd, &amp;notif) == -1) {
+	if (tst_syscall(__NR_mq_notify, mqd, &amp;notif) == -1) {
 		perror(&quot;mq_notify failed&quot;);
 		return 1;
 	} else
@@ -248,7 +248,7 @@ int main(void)
 		tst_brkm(TBROK | TERRNO, cleanup, &quot;pipe failed&quot;);
 	}
 
-	ltp_syscall(__NR_mq_unlink, mqname);
+	tst_syscall(__NR_mq_unlink, mqname);
 
 	/* container creation on PID namespace */
 	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
@@ -256,7 +256,7 @@ int main(void)
 		tst_brkm(TBROK | TERRNO, cleanup, &quot;clone failed&quot;);
 
 	mqd =
-	    ltp_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
+	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
 		    NULL);
 	if (mqd == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, &quot;mq_open failed&quot;);
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index fb8035d90..8821ec83c 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -93,7 +93,7 @@ static void remove_pipe(int *fd)
 static void remove_mqueue(mqd_t mqd)
 {
 	mq_close(mqd);
-	ltp_syscall(__NR_mq_unlink, mqname);
+	tst_syscall(__NR_mq_unlink, mqname);
 }
 
 /*
@@ -116,7 +116,7 @@ static void cleanup_resources(int step, mqd_t mqd)
 		break;
 
 	case F_STEP_2:
-		ltp_syscall(__NR_mq_notify, mqd, NULL);
+		tst_syscall(__NR_mq_notify, mqd, NULL);
 		/* fall through */
 	case F_STEP_1:
 		remove_mqueue(mqd);
@@ -172,7 +172,7 @@ int child_fn(void *arg)
 	}
 	tst_resm(TINFO, &quot;cinit: my father is ready to receive a message&quot;);
 
-	mqd = ltp_syscall(__NR_mq_open, mqname, O_WRONLY, 0, NULL);
+	mqd = tst_syscall(__NR_mq_open, mqname, O_WRONLY, 0, NULL);
 	if (mqd == (mqd_t) - 1) {
 		tst_resm(TBROK, &quot;cinit: mq_open() failed (%s)&quot;,
 			 strerror(errno));
@@ -264,9 +264,9 @@ int main(void)
 		cleanup_mqueue(TBROK, NO_STEP, 0);
 	}
 
-	ltp_syscall(__NR_mq_unlink, mqname);
+	tst_syscall(__NR_mq_unlink, mqname);
 	mqd =
-	    ltp_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
+	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
 		    NULL);
 	if (mqd == (mqd_t) - 1) {
 		tst_resm(TBROK, &quot;parent: mq_open() failed (%s)<a class="moz-txt-link-rfc2396E" href="mailto:,@@-289,7+289,7@@intmain(void)info.mqd=mqd;info.pid=cpid;notif.sigev_value.sival_ptr=&amp;info;-if(ltp_syscall(__NR_mq_notify,mqd,&amp;notif)==(mqd_t)-1){+if(tst_syscall(__NR_mq_notify,mqd,&amp;notif)==(mqd_t)-1){tst_resm(TBROK,">&quot;,
@@ -289,7 +289,7 @@ int main(void)
 	info.mqd = mqd;
 	info.pid = cpid;
 	notif.sigev_value.sival_ptr = &amp;info;
-	if (ltp_syscall(__NR_mq_notify, mqd, &amp;notif) == (mqd_t) -1) {
+	if (tst_syscall(__NR_mq_notify, mqd, &amp;notif) == (mqd_t) -1) {
 		tst_resm(TBROK, &quot;</a>parent: mq_notify() failed (%s)&quot;,
 			 strerror(errno));
 		cleanup_mqueue(TBROK, F_STEP_1, mqd);
diff --git a/testcases/kernel/containers/userns/userns04.c b/testcases/kernel/containers/userns/userns04.c
index f7d6e8005..66d3388a9 100644
--- a/testcases/kernel/containers/userns/userns04.c
+++ b/testcases/kernel/containers/userns/userns04.c
@@ -35,7 +35,7 @@ int TST_TOTAL = 1;
 static void setup(void)
 {
 	check_newuser();
-	ltp_syscall(__NR_setns, -1, 0);
+	tst_syscall(__NR_setns, -1, 0);
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(NULL);
 }
@@ -56,7 +56,7 @@ static int child_fn2(void *arg)
 	int exit_val = 0;
 	int ret;
 
-	ret = ltp_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER);
+	ret = tst_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER);
 	if (ret != -1) {
 		printf(&quot;child2 setns() unexpected success\n&quot;);
 		exit_val = 1;
@@ -95,7 +95,7 @@ static void test_cap_sys_admin(void)
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, &quot;fork&quot;);
 	case 0:
-		if (ltp_syscall(__NR_setns, fd, CLONE_NEWUSER) == -1) {
+		if (tst_syscall(__NR_setns, fd, CLONE_NEWUSER) == -1) {
 			printf(&quot;parent pid setns failure: (%d) %s&quot;,
 				errno, strerror(errno));
 			exit(1);
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
index a687ad2ee..9a81c23eb 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
@@ -3083,19 +3083,19 @@ done:
 
 static int sched_setaffinity(pid_t pid, unsigned len, unsigned long *mask)
 {
-	return ltp_syscall(__NR_sched_setaffinity, pid, len, mask);
+	return tst_syscall(__NR_sched_setaffinity, pid, len, mask);
 }
 
 static int get_mempolicy(int *policy, unsigned long *nmask,
 			 unsigned long maxnode, void *addr, int flags)
 {
-	return ltp_syscall(__NR_get_mempolicy, policy, nmask, maxnode,
+	return tst_syscall(__NR_get_mempolicy, policy, nmask, maxnode,
 		addr, flags);
 }
 
 static int set_mempolicy(int mode, unsigned long *nmask, unsigned long maxnode)
 {
-	return ltp_syscall(__NR_set_mempolicy, mode, nmask, maxnode);
+	return tst_syscall(__NR_set_mempolicy, mode, nmask, maxnode);
 }
 
 struct cpuset_placement {
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index f9bd865e5..16f14d66b 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -124,7 +124,7 @@ static void help(void)
 
 static void cma_test_params_read(struct process_vm_params *params)
 {
-	TEST(ltp_syscall(__NR_process_vm_readv,
+	TEST(tst_syscall(__NR_process_vm_readv,
 			 params-&gt;pid,
 			 params-&gt;lvec, params-&gt;liovcnt,
 			 params-&gt;rvec, params-&gt;riovcnt,
@@ -133,7 +133,7 @@ static void cma_test_params_read(struct process_vm_params *params)
 
 static void cma_test_params_write(struct process_vm_params *params)
 {
-	TEST(ltp_syscall(__NR_process_vm_writev,
+	TEST(tst_syscall(__NR_process_vm_writev,
 			 params-&gt;pid,
 			 params-&gt;lvec, params-&gt;liovcnt,
 			 params-&gt;rvec, params-&gt;riovcnt,
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index ac53ed226..b705b946b 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -134,7 +134,7 @@ static void child_invoke(void)
 	remote.iov_len = len;
 
 	tst_resm(TINFO, &quot;child 1: reading string from same memory location.&quot;);
-	TEST(ltp_syscall(__NR_process_vm_readv, pids[0],
+	TEST(tst_syscall(__NR_process_vm_readv, pids[0],
 			 &amp;local, 1UL, &amp;remote, 1UL, 0UL));
 	if (TEST_RETURN != len)
 		tst_brkm(TFAIL | TTERRNO, tst_exit, &quot;process_vm_readv<a class="moz-txt-link-rfc2396E" href="mailto:);@@-150,7+150,7@@staticvoidsetup(void)tst_require_root();/*Justasanitycheckoftheexistenceofsyscall*/-ltp_syscall(__NR_process_vm_readv,getpid(),NULL,0UL,NULL,0UL,0UL);+tst_syscall(__NR_process_vm_readv,getpid(),NULL,0UL,NULL,0UL,0UL);tst_tmpdir();TST_CHECKPOINT_INIT(cleanup);diff--gita/testcases/kernel/syscalls/cma/process_vm_readv03.cb/testcases/kernel/syscalls/cma/process_vm_readv03.cindex561146e5e..2333f7fd6100644---a/testcases/kernel/syscalls/cma/process_vm_readv03.c+++b/testcases/kernel/syscalls/cma/process_vm_readv03.c@@-180,7+180,7@@staticlong*fetch_remote_addrs(void)remote.iov_base=foo;remote.iov_len=len;-TEST(ltp_syscall(__NR_process_vm_readv,pids[0],&amp;local,+TEST(tst_syscall(__NR_process_vm_readv,pids[0],&amp;local,1UL,&amp;remote,1UL,0UL));if(TEST_RETURN!=len)tst_brkm(TFAIL|TTERRNO,tst_exit,">&quot;);
@@ -150,7 +150,7 @@ static void setup(void)
 	tst_require_root();
 
 	/* Just a sanity check of the existence of syscall */
-	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
+	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(cleanup);
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 561146e5e..2333f7fd6 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -180,7 +180,7 @@ static long *fetch_remote_addrs(void)
 	remote.iov_base = foo;
 	remote.iov_len = len;
 
-	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], &amp;local,
+	TEST(tst_syscall(__NR_process_vm_readv, pids[0], &amp;local,
 			 1UL, &amp;remote, 1UL, 0UL));
 	if (TEST_RETURN != len)
 		tst_brkm(TFAIL | TTERRNO, tst_exit, &quot;</a>process_vm_readv&quot;);
@@ -213,7 +213,7 @@ static void child_invoke(int *bufsz_arr)
 	tst_resm(TINFO, &quot;child 1: %d local iovecs initialized.&quot;,
 		 NUM_LOCAL_VECS);
 
-	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local,
+	TEST(tst_syscall(__NR_process_vm_readv, pids[0], local,
 			    (unsigned long)NUM_LOCAL_VECS, remote,
 			    (unsigned long)nr_iovecs, 0UL));
 	if (TEST_RETURN != bufsz)
@@ -249,7 +249,7 @@ static void setup(void)
 	tst_require_root();
 
 	/* Just a sanity check of the existence of syscall */
-	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
+	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
 	nr_iovecs = nflag ? SAFE_STRTOL(NULL, nr_opt, 1, IOV_MAX) : 10;
 	bufsz = sflag ? SAFE_STRTOL(NULL, sz_opt, NUM_LOCAL_VECS, LONG_MAX)
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index ea2ca63d1..e70ead4ed 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -171,7 +171,7 @@ static void child_write(void)
 	remote.iov_len = bufsz;
 
 	tst_resm(TINFO, &quot;child 2: write to the same memory location.&quot;);
-	TEST(ltp_syscall(__NR_process_vm_writev, pids[0], &amp;local,
+	TEST(tst_syscall(__NR_process_vm_writev, pids[0], &amp;local,
 			 1UL, &amp;remote, 1UL, 0UL));
 	if (TEST_RETURN != bufsz)
 		tst_brkm(TFAIL | TTERRNO, tst_exit, &quot;process_vm_readv&quot;);
@@ -182,7 +182,7 @@ static void setup(void)
 	tst_require_root();
 
 	/* Just a sanity check of the existence of syscall */
-	ltp_syscall(__NR_process_vm_writev, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
+	tst_syscall(__NR_process_vm_writev, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
 	bufsz =
 	    sflag ? SAFE_STRTOL(NULL, sz_opt, 1, LONG_MAX - PADDING_SIZE * 2)
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 0d7d15a83..1c1630fa7 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -129,7 +129,7 @@ static char *argv0;
 static int sys_connect(int sockfd, const struct sockaddr *addr,
 		socklen_t addrlen)
 {
-	return ltp_syscall(__NR_connect, sockfd, addr, addrlen);
+	return tst_syscall(__NR_connect, sockfd, addr, addrlen);
 }
 
 #define connect(sockfd, addr, addrlen) sys_connect(sockfd, addr, addrlen)
diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index c4f6978c1..476551233 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -14,9 +14,9 @@
  */
 
 #include &lt;errno.h&gt;
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;tst_test.h&quot;
 #include &quot;tst_module.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 #define MODULE_NAME	&quot;dummy_del_mod&quot;
 #define MODULE_NAME_KO	&quot;dummy_del_mod.ko<a class="moz-txt-link-rfc2396E" href="mailto:diff--gita/testcases/kernel/syscalls/eventfd/eventfd01.cb/testcases/kernel/syscalls/eventfd/eventfd01.cindex4d888910b..242e170e2100644---a/testcases/kernel/syscalls/eventfd/eventfd01.c+++b/testcases/kernel/syscalls/eventfd/eventfd01.c@@-72,7+72,7@@staticvoidsetup(void);staticintmyeventfd(unsignedintinitval,intflags){/*eventfd2usesFLAGSbuteventfddoesn'ttakeFLAGS.*/-returnltp_syscall(__NR_eventfd,initval);+returntst_syscall(__NR_eventfd,initval);}/*diff--gita/testcases/kernel/syscalls/eventfd2/eventfd2_01.cb/testcases/kernel/syscalls/eventfd2/eventfd2_01.cindexc0c6a263c..c9ecdc58e100644---a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c+++b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c@@-91,7+91,7@@intmain(intargc,char*argv[])}setup();-fd=ltp_syscall(__NR_eventfd2,1,0);+fd=tst_syscall(__NR_eventfd2,1,0);if(fd==-1){tst_brkm(TFAIL,cleanup,">&quot;
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index 4d888910b..242e170e2 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -72,7 +72,7 @@ static void setup(void);
 static int myeventfd(unsigned int initval, int flags)
 {
 	/* eventfd2 uses FLAGS but eventfd doesn't take FLAGS. */
-	return ltp_syscall(__NR_eventfd, initval);
+	return tst_syscall(__NR_eventfd, initval);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
index c0c6a263c..c9ecdc58e 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
@@ -91,7 +91,7 @@ int main(int argc, char *argv[])
 	}
 	setup();
 
-	fd = ltp_syscall(__NR_eventfd2, 1, 0);
+	fd = tst_syscall(__NR_eventfd2, 1, 0);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, &quot;</a>eventfd2(0) failed&quot;);
 	}
@@ -104,7 +104,7 @@ int main(int argc, char *argv[])
 	}
 	close(fd);
 
-	fd = ltp_syscall(__NR_eventfd2, 1, EFD_CLOEXEC);
+	fd = tst_syscall(__NR_eventfd2, 1, EFD_CLOEXEC);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, &quot;eventfd2(EFD_CLOEXEC) failed&quot;);
 	}
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
index 418c07c45..2125b528e 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
@@ -89,7 +89,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	tst_count = 0;
-	fd = ltp_syscall(__NR_eventfd2, 1, 0);
+	fd = tst_syscall(__NR_eventfd2, 1, 0);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, &quot;eventfd2(0) failed&quot;);
 	}
@@ -102,7 +102,7 @@ int main(int argc, char *argv[])
 	}
 	close(fd);
 
-	fd = ltp_syscall(__NR_eventfd2, 1, EFD_NONBLOCK);
+	fd = tst_syscall(__NR_eventfd2, 1, EFD_NONBLOCK);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, &quot;eventfd2(EFD_NONBLOCK) failed&quot;);
 	}
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
index 4c26b654e..e26714ddc 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
@@ -52,7 +52,7 @@ void cleanup(void)
 
 static int eventfd2(int count, int flags)
 {
-	return ltp_syscall(__NR_eventfd2, count, flags);
+	return tst_syscall(__NR_eventfd2, count, flags);
 }
 
 static void xsem_wait(int fd)
diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index d7bcbe9d6..5bf5b0218 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -42,7 +42,7 @@ static void verify_exit_group(void)
 		tst_brkm(TFAIL | TERRNO, NULL, &quot;fork failed&quot;);
 
 	if (cpid == 0) {
-		TEST(ltp_syscall(__NR_exit_group, 4));
+		TEST(tst_syscall(__NR_exit_group, 4));
 	} else {
 		w = SAFE_WAIT(NULL, &amp;status);
 
diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index 807ab917b..1ab494e7a 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -64,7 +64,7 @@ static int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
 
 int myfaccessat(int dirfd, const char *filename, int mode)
 {
-	return ltp_syscall(__NR_faccessat, dirfd, filename, mode);
+	return tst_syscall(__NR_faccessat, dirfd, filename, mode);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 369f80eb2..9676ae0fd 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -64,7 +64,7 @@ int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
 
 int myfchmodat(int dirfd, const char *filename, mode_t mode)
 {
-	return ltp_syscall(__NR_fchmodat, dirfd, filename, mode);
+	return tst_syscall(__NR_fchmodat, dirfd, filename, mode);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/fchownat/fchownat.h b/testcases/kernel/syscalls/fchownat/fchownat.h
index a95c26f93..927cf929a 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat.h
+++ b/testcases/kernel/syscalls/fchownat/fchownat.h
@@ -29,7 +29,7 @@
 static inline int fchownat(int dirfd, const char *filename, uid_t owner,
 		gid_t group, int flags)
 {
-	return ltp_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
+	return tst_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
 }
 #endif
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
index 900308980..f6e2b01ff 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl31.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -210,7 +210,7 @@ static void setownex_tid_test(void)
 	}
 
 	tst_own_ex.type = F_OWNER_TID;
-	tst_own_ex.pid = ltp_syscall(__NR_gettid);
+	tst_own_ex.pid = tst_syscall(__NR_gettid);
 
 	TEST(fcntl(test_fd, F_SETOWN_EX, &amp;tst_own_ex));
 	if (TEST_RETURN <a class="moz-txt-link-rfc2396E" href="mailto:0){diff--gita/testcases/kernel/syscalls/fork/fork05.cb/testcases/kernel/syscalls/fork/fork05.cindexce03dcd22..9a99cff1d100644---a/testcases/kernel/syscalls/fork/fork05.c+++b/testcases/kernel/syscalls/fork/fork05.c@@-133,7+133,7@@staticinta=42;staticvoidmodify_ldt(intfunc,structmodify_ldt_ldt_s*ptr,intbytecount){-ltp_syscall(__NR_modify_ldt,func,ptr,bytecount);+tst_syscall(__NR_modify_ldt,func,ptr,bytecount);}intmain(void)diff--gita/testcases/kernel/syscalls/fstatat/fstatat01.cb/testcases/kernel/syscalls/fstatat/fstatat01.cindexb5fa83735..28e3d472f100644---a/testcases/kernel/syscalls/fstatat/fstatat01.c+++b/testcases/kernel/syscalls/fstatat/fstatat01.c@@-62,17+62,17@@staticconstintflags[]={0,0,0,0,9999,0};#if(__NR_fstatat64">&lt; 0) {
diff --git a/testcases/kernel/syscalls/fork/fork05.c b/testcases/kernel/syscalls/fork/fork05.c
index ce03dcd22..9a99cff1d 100644
--- a/testcases/kernel/syscalls/fork/fork05.c
+++ b/testcases/kernel/syscalls/fork/fork05.c
@@ -133,7 +133,7 @@ static int a = 42;
 
 static void modify_ldt(int func, struct modify_ldt_ldt_s *ptr, int bytecount)
 {
-	ltp_syscall(__NR_modify_ldt, func, ptr, bytecount);
+	tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
 }
 
 int main(void)
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index b5fa83735..28e3d472f 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -62,17 +62,17 @@ static const int flags[] = { 0, 0, 0, 0, 9999, 0 };
 #if (__NR_fstatat64 &gt;</a> 0)
 int fstatat(int dirfd, const char *filename, struct stat64 *statbuf, int flags)
 {
-	return ltp_syscall(__NR_fstatat64, dirfd, filename, statbuf, flags);
+	return tst_syscall(__NR_fstatat64, dirfd, filename, statbuf, flags);
 }
 #elif (__NR_newfstatat &gt; 0)
 int fstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
 {
-	return ltp_syscall(__NR_newfstatat, dirfd, filename, statbuf, flags);
+	return tst_syscall(__NR_newfstatat, dirfd, filename, statbuf, flags);
 }
 #else
 int fstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
 {
-	return ltp_syscall(__NR_fstatat, dirfd, filename, statbuf, flags);
+	return tst_syscall(__NR_fstatat, dirfd, filename, statbuf, flags);
 }
 #endif
 #endif
diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
index e3b1011e8..9b1e75b7f 100644
--- a/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -58,7 +58,7 @@ static const int expected_errno[] = { 0, 0, ENOTDIR, EBADF, 0 };
 
 int myfutimesat(int dirfd, const char *filename, struct timeval *times)
 {
-	return ltp_syscall(__NR_futimesat, dirfd, filename, times);
+	return tst_syscall(__NR_futimesat, dirfd, filename, times);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index 222dc6f2e..1ff37bc9b 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -94,7 +94,7 @@ int main(int argc, char **argv)
 		 * argument.
 		 */
 
-		TEST(ltp_syscall(__NR_get_robust_list, 0,
+		TEST(tst_syscall(__NR_get_robust_list, 0,
 				      (struct robust_list_head *)&amp;head,
 				      NULL));
 
@@ -110,7 +110,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL,
 				 &quot;get_robust_list succeeded unexpectedly&quot;);
 
-		TEST(ltp_syscall(__NR_get_robust_list, 0,
+		TEST(tst_syscall(__NR_get_robust_list, 0,
 				      NULL,
 				      &amp;len_ptr));
 
@@ -131,7 +131,7 @@ int main(int argc, char **argv)
 		 * find the task specified by the pid argument.
 		 */
 
-		TEST(ltp_syscall(__NR_get_robust_list, unused_pid,
+		TEST(tst_syscall(__NR_get_robust_list, unused_pid,
 				      (struct robust_list_head *)&amp;head,
 				      &amp;len_ptr));
 
@@ -147,7 +147,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL,
 				 &quot;get_robust_list succeeded unexpectedly&quot;);
 
-		TEST(ltp_syscall(__NR_get_robust_list, 0,
+		TEST(tst_syscall(__NR_get_robust_list, 0,
 				      (struct robust_list_head **)&amp;head,
 				      &amp;len_ptr));
 
@@ -159,7 +159,7 @@ int main(int argc, char **argv)
 
 		SAFE_SETUID(cleanup, 1);
 
-		TEST(ltp_syscall(__NR_get_robust_list, 1,
+		TEST(tst_syscall(__NR_get_robust_list, 1,
 				      (struct robust_list_head *)&amp;head,
 				      &amp;len_ptr));
 
diff --git a/testcases/kernel/syscalls/getrandom/getrandom01.c b/testcases/kernel/syscalls/getrandom/getrandom01.c
index ccbd2864f..695f904a0 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom01.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
@@ -5,9 +5,9 @@
  * Calls getrandom(2) with a NULL buffer and expects failure.
  */
 
+#include &quot;tst_test.h&quot;
 #include &quot;lapi/getrandom.h&quot;
 #include &quot;lapi/syscalls.h&quot;
-#include &quot;tst_test.h&quot;
 
 static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
 		      GRND_RANDOM | GRND_NONBLOCK};
diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index 1384fc5f3..b79e4ed6a 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -6,9 +6,9 @@
  * and expects success.
  */
 
+#include &quot;tst_test.h&quot;
 #include &quot;lapi/getrandom.h&quot;
 #include &quot;lapi/syscalls.h&quot;
-#include &quot;tst_test.h&quot;
 
 #define PROC_ENTROPY_AVAIL &quot;/proc/sys/kernel/random/entropy_avail&quot;
 
diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
index 705f9b288..afeb65d59 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom03.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
@@ -6,9 +6,9 @@
  * number of bytes required and expects success.
  */
 
+#include &quot;tst_test.h&quot;
 #include &quot;lapi/getrandom.h&quot;
 #include &quot;lapi/syscalls.h&quot;
-#include &quot;tst_test.h&quot;
 
 #define MAX_SIZE 256
 
diff --git a/testcases/kernel/syscalls/getrandom/getrandom04.c b/testcases/kernel/syscalls/getrandom/getrandom04.c
index 465e353e4..57b14881e 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom04.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
@@ -7,9 +7,9 @@
  */
 
 #include &lt;sys/resource.h&gt;
+#include &quot;tst_test.h&quot;
 #include &quot;lapi/getrandom.h&quot;
 #include &quot;lapi/syscalls.h&quot;
-#include &quot;tst_test.h&quot;
 
 static void verify_getrandom(void)
 {
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
index 08ea1673a..f9acb9665 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
@@ -61,7 +61,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		TEST(ltp_syscall(__NR_gettimeofday, (void *)-1, (void *)-1));
+		TEST(tst_syscall(__NR_gettimeofday, (void *)-1, (void *)-1));
 
 		/* gettimeofday returns an int, so we need to turn the long
 		 * TEST_RETURN into an int to test with */
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
index f1b50fd4e..714077a34 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
@@ -135,7 +135,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
-			fd = ltp_syscall(__NR_inotify_init1, 0);
+			fd = tst_syscall(__NR_inotify_init1, 0);
 			if (fd == -1) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 &quot;inotify_init1(0) failed&quot;);
@@ -151,7 +151,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = ltp_syscall(__NR_inotify_init1, IN_CLOEXEC);
+			fd = tst_syscall(__NR_inotify_init1, IN_CLOEXEC);
 			if (fd == -1) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 &quot;inotify_init1(IN_CLOEXEC) failed&quot;);
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
index 3b0c7678e..5edcbfa3d 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
@@ -132,7 +132,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
-			fd = ltp_syscall(__NR_inotify_init1, 0);
+			fd = tst_syscall(__NR_inotify_init1, 0);
 			if (fd == -1) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 &quot;inotify_init1(0) failed&quot;);
@@ -149,7 +149,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = ltp_syscall(__NR_inotify_init1, IN_NONBLOCK);
+			fd = tst_syscall(__NR_inotify_init1, IN_NONBLOCK);
 			if (fd == -1) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 &quot;inotify_init1(IN_NONBLOCK) failed&quot;);
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index 8569322dc..228174c9b 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -17,12 +17,12 @@
  * message.
  */
 
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;tst_test.h&quot;
 #include &quot;tst_fuzzy_sync.h&quot;
 #include &quot;tst_safe_pthread.h&quot;
 #include &quot;tst_safe_sysv_ipc.h&quot;
 #include &quot;tst_timer.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 static struct tst_fzsync_pair fzsync_pair;
 
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index cde0910e1..70feb6b03 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -192,7 +192,7 @@ int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
 static int mylinkat(int olddirfd, const char *oldfilename, int newdirfd,
 		    const char *newfilename, int flags)
 {
-	return ltp_syscall(__NR_linkat, olddirfd, oldfilename, newdirfd,
+	return tst_syscall(__NR_linkat, olddirfd, oldfilename, newdirfd,
 		       newfilename, flags);
 }
 
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 566c76b1f..796190fef 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -112,7 +112,7 @@ static void linkat_verify(const struct test_struct *desc)
 		desc-&gt;setupfunc();
 	}
 
-	TEST(ltp_syscall(__NR_linkat, AT_FDCWD, desc-&gt;oldfname,
+	TEST(tst_syscall(__NR_linkat, AT_FDCWD, desc-&gt;oldfname,
 			 AT_FDCWD, desc-&gt;newfname, desc-&gt;flags));
 
 	if (desc-&gt;cleanfunc != NULL)
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index fa9315412..198ba3813 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -62,7 +62,7 @@ static void cleanup(void);
 static void test_sane_nodes(void)
 {
 	tst_resm(TINFO, &quot;test_empty_mask&quot;);
-	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node,
+	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node,
 		     sane_old_nodes, sane_new_nodes));
 	check_ret(0);
 }
@@ -72,14 +72,14 @@ static void test_invalid_pid(void)
 	pid_t invalid_pid = -1;
 
 	tst_resm(TINFO, &quot;test_invalid_pid -1&quot;);
-	TEST(ltp_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
+	TEST(tst_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
 		     sane_old_nodes, sane_new_nodes));
 	check_ret(-1);
 	check_errno(ESRCH);
 
 	tst_resm(TINFO, &quot;test_invalid_pid unused pid&quot;);
 	invalid_pid = tst_get_unused_pid(cleanup);
-	TEST(ltp_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
+	TEST(tst_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
 		     sane_old_nodes, sane_new_nodes));
 	check_ret(-1);
 	check_errno(ESRCH);
@@ -88,7 +88,7 @@ static void test_invalid_pid(void)
 static void test_invalid_masksize(void)
 {
 	tst_resm(TINFO, &quot;test_invalid_masksize&quot;);
-	TEST(ltp_syscall(__NR_migrate_pages, 0, -1, sane_old_nodes,
+	TEST(tst_syscall(__NR_migrate_pages, 0, -1, sane_old_nodes,
 		     sane_new_nodes));
 	check_ret(-1);
 	check_errno(EINVAL);
@@ -99,7 +99,7 @@ static void test_invalid_mem(void)
 	unsigned long *p;
 
 	tst_resm(TINFO, &quot;test_invalid_mem -1&quot;);
-	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, -1, -1));
+	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, -1, -1));
 	check_ret(-1);
 	check_errno(EFAULT);
 
@@ -108,13 +108,13 @@ static void test_invalid_mem(void)
 		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (p == MAP_FAILED)
 		tst_brkm(TBROK | TERRNO, cleanup, &quot;mmap&quot;);
-	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
+	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
 	check_ret(-1);
 	check_errno(EFAULT);
 
 	SAFE_MUNMAP(cleanup, p, getpagesize());
 	tst_resm(TINFO, &quot;test_invalid_mem unmmaped&quot;);
-	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
+	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
 	check_ret(-1);
 	check_errno(EFAULT);
 }
@@ -143,7 +143,7 @@ static void test_invalid_nodes(void)
 		memset(new_nodes, 0, sane_nodemask_size);
 		set_bit(new_nodes, invalid_node, 1);
 
-		TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node,
+		TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node,
 			     old_nodes, new_nodes));
 		check_ret(-1);
 		check_errno(EINVAL);
@@ -178,7 +178,7 @@ static void test_invalid_perm(void)
 		if (ltpuser == NULL)
 			tst_brkm(TBROK | TERRNO, NULL, &quot;getpwnam failed&quot;);
 		SAFE_SETUID(NULL, ltpuser-&gt;pw_uid);
-		TEST(ltp_syscall(__NR_migrate_pages, parent_pid,
+		TEST(tst_syscall(__NR_migrate_pages, parent_pid,
 			     sane_max_node, sane_old_nodes, sane_new_nodes));
 		ret |= check_ret(-1);
 		ret |= check_errno(EPERM);
@@ -215,7 +215,7 @@ static void setup(void)
 	int node, ret;
 
 	tst_require_root();
-	TEST(ltp_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
+	TEST(tst_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
 
 	if (!is_numa(NULL, NH_MEMS, 1))
 		tst_brkm(TCONF, NULL, &quot;requires NUMA with at least 1 node&quot;);
diff --git a/testcases/kernel/syscalls/mknodat/mknodat.h b/testcases/kernel/syscalls/mknodat/mknodat.h
index b4e828c5d..8f3a1f007 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat.h
+++ b/testcases/kernel/syscalls/mknodat/mknodat.h
@@ -28,7 +28,7 @@
 #if !defined(HAVE_MKNODAT)
 int mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
 {
-	return ltp_syscall(__NR_mknodat, dirfd, filename, mode, dev);
+	return tst_syscall(__NR_mknodat, dirfd, filename, mode, dev);
 }
 #endif
 
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index 7e6afda92..28c5c8a4b 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -163,7 +163,7 @@ static void mknodat_verify(struct test_case_t *tc)
 	}
 
 	if (TEST_ERRNO == 0 &amp;&amp;
-	    ltp_syscall(__NR_unlinkat, fd, pathname, 0) &lt; 0) {
+	    tst_syscall(__NR_unlinkat, fd, pathname, 0) &lt; 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, &quot;unlinkat(%d, %s) &quot;
 			 &quot;failed.&quot;, fd, pathname);
 	}
diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index ebf2fcc10..2b9349e35 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
-			TEST(ltp_syscall(__NR_uname, &amp;name));
+			TEST(tst_syscall(__NR_uname, &amp;name));
 			if (TEST_RETURN == -1) {
 				tst_brkm(TFAIL, cleanup, &quot;%s failed - errno = %d : %s&quot;,
 					 TCID, TEST_ERRNO,
diff --git a/testcases/kernel/syscalls/openat/openat.h b/testcases/kernel/syscalls/openat/openat.h
index 9b5568bda..45d001833 100644
--- a/testcases/kernel/syscalls/openat/openat.h
+++ b/testcases/kernel/syscalls/openat/openat.h
@@ -28,7 +28,7 @@
 #if !defined(HAVE_OPENAT)
 int openat(int dirfd, const char *pathname, int flags, mode_t mode)
 {
-	return ltp_syscall(__NR_openat, dirfd, pathname, flags, mode);
+	return tst_syscall(__NR_openat, dirfd, pathname, flags, mode);
 }
 #endif
 
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 6286d415d..3807b2df1 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -123,7 +123,7 @@ static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
 {
 	int ret;
 
-	ret = ltp_syscall(__NR_perf_event_open, hw_event, pid, cpu,
+	ret = tst_syscall(__NR_perf_event_open, hw_event, pid, cpu,
 			  group_fd, flags);
 	return ret;
 }
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 3d2f92f2a..606018af4 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -17,12 +17,12 @@
 #include &lt;stdlib.h&gt;
 #include &lt;sys/types.h&gt;
 #include &lt;sys/wait.h&gt;
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;ltp_signal.h&quot;
 #include &quot;time64_variants.h&quot;
 #include &quot;tst_sig_proc.h&quot;
 #include &quot;tst_test.h&quot;
 #include &quot;tst_timer.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 /* Older versions of glibc don't publish this constant's value. */
 #ifndef POLLRDHUP
diff --git a/testcases/kernel/syscalls/prctl/prctl05.c b/testcases/kernel/syscalls/prctl/prctl05.c
index ae390fdfc..838e717f7 100644
--- a/testcases/kernel/syscalls/prctl/prctl05.c
+++ b/testcases/kernel/syscalls/prctl/prctl05.c
@@ -16,9 +16,9 @@
 #include &lt;sys/prctl.h&gt;
 #include &lt;string.h&gt;
 #include &lt;stdio.h&gt;
+#include &quot;tst_test.h&quot;
 #include &quot;lapi/syscalls.h&quot;
 #include &quot;lapi/prctl.h&quot;
-#include &quot;tst_test.h&quot;
 
 static struct tcase {
 	char setname[20];
diff --git a/testcases/kernel/syscalls/renameat2/renameat2.h b/testcases/kernel/syscalls/renameat2/renameat2.h
index b04558d14..c4688ed53 100644
--- a/testcases/kernel/syscalls/renameat2/renameat2.h
+++ b/testcases/kernel/syscalls/renameat2/renameat2.h
@@ -27,7 +27,7 @@
 int renameat2(int olddirfd, const char *oldpath, int newdirfd,
 				const char *newpath, unsigned int flags)
 {
-	return ltp_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
+	return tst_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
 						newpath, flags);
 }
 #endif
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index 202e85386..e564a9430 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 					 &quot;rt_sigaction call failed&quot;);
 
 			/* call rt_sigprocmask() to block signal#TEST_SIG */
-			TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_BLOCK, &amp;set,
+			TEST(tst_syscall(__NR_rt_sigprocmask, SIG_BLOCK, &amp;set,
 				     &amp;oset, SIGSETSIZE));
 			if (TEST_RETURN == -1)
 				tst_brkm(TFAIL | TTERRNO, cleanup,
@@ -123,7 +123,7 @@ int main(int ac, char **av)
 					 &quot;the process's signal mask&quot;);
 			} else {
 				/* call rt_sigpending() */
-				TEST(ltp_syscall(__NR_rt_sigpending, &amp;oset,
+				TEST(tst_syscall(__NR_rt_sigpending, &amp;oset,
 					     SIGSETSIZE));
 				if (TEST_RETURN == -1)
 					tst_brkm(TFAIL | TTERRNO, cleanup,
@@ -137,7 +137,7 @@ int main(int ac, char **av)
 
 				/* call rt_sigprocmask() to unblock
 				 * signal#TEST_SIG */
-				TEST(ltp_syscall(__NR_rt_sigprocmask,
+				TEST(tst_syscall(__NR_rt_sigprocmask,
 					     SIG_UNBLOCK, &amp;set, &amp;oset,
 					     SIGSETSIZE));
 				if (TEST_RETURN == -1)
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
index 5c8c36b74..8c4724eb4 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
@@ -104,7 +104,7 @@ int main(int ac, char **av)
 			&quot;Call to sigfillset() failed.&quot;);
 
 	for (i = 0; i &lt; test_count; i++) {
-		TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_BLOCK,
+		TEST(tst_syscall(__NR_rt_sigprocmask, SIG_BLOCK,
 			     &amp;s, test_cases[i].ss, test_cases[i].sssize));
 		if (TEST_RETURN == 0) {
 			tst_resm(TFAIL | TTERRNO,
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index a1c54efd0..f6fe1add9 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -14,8 +14,8 @@
  */
 
 #include &lt;sched.h&gt;
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;tst_test.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 #define POLICY_DESC(x) .desc = #x, .policy = x
 
diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
index a17b2fdd6..a945fa6b0 100644
--- a/testcases/kernel/syscalls/select/select_var.h
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -5,8 +5,8 @@
 #ifndef SELECT_VAR__
 #define SELECT_VAR__
 
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;tst_timer.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 struct compat_sel_arg_struct {
 	long _n;
diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
index b8639a3d3..30626d5e9 100644
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
@@ -74,7 +74,7 @@ int main(int argc, char *argv[])
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		for (i = 0; i &lt; sizeof(tests) / sizeof(struct test); i++) {
-			TEST(ltp_syscall(tests[i].syscall, tests[i].u_info));
+			TEST(tst_syscall(tests[i].syscall, tests[i].u_info));
 
 			if (TEST_RETURN != tests[i].exp_ret) {
 				tst_resm(TFAIL, &quot;%s returned %li expected %i&quot;,
diff --git a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
index 20974a9e7..11fa27540 100644
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
-			TEST(ltp_syscall(__NR_set_tid_address, &amp;newtid));
+			TEST(tst_syscall(__NR_set_tid_address, &amp;newtid));
 			if (TEST_RETURN == getpid()) {
 				tst_resm(TPASS,
 					 &quot;set_tid_address call succeeded:  as expected %ld&quot;,
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname.h b/testcases/kernel/syscalls/setdomainname/setdomainname.h
index 12c8a088f..dcacb0acf 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname.h
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname.h
@@ -7,9 +7,9 @@
 #define SETDOMAINNAME_H__
 
 #include &lt;string.h&gt;
+#include &quot;tst_test.h&quot;
 #include &quot;lapi/utsname.h&quot;
 #include &quot;lapi/syscalls.h&quot;
-#include &quot;tst_test.h&quot;
 
 #define TST_VALID_DOMAIN_NAME &quot;test_dom&quot;
 
diff --git a/testcases/kernel/syscalls/sgetmask/sgetmask01.c b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
index 2b482f385..afd409128 100644
--- a/testcases/kernel/syscalls/sgetmask/sgetmask01.c
+++ b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
@@ -125,11 +125,11 @@ int main(int ac, char **av)
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
 
 			for (sig = -3; sig &lt;= SIGRTMAX + 1; sig++) {
-				TEST(ltp_syscall(__NR_ssetmask, sig));
+				TEST(tst_syscall(__NR_ssetmask, sig));
 				tst_resm(TINFO, &quot;Setting signal : %d -- &quot;
 					&quot;return of setmask : %ld&quot;,
 					sig, TEST_RETURN);
-				TEST(ltp_syscall(__NR_sgetmask));
+				TEST(tst_syscall(__NR_sgetmask));
 				if (TEST_RETURN != sig) {
 					tst_resm(TINFO,
 						 &quot;Oops,setting sig %d, got %ld&quot;,
diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index 1a62156ff..3df941785 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -78,7 +78,7 @@ int main(void)
 int signalfd(int fd, const sigset_t * mask, int flags)
 {
 	/* Taken from GLIBC. */
-	return ltp_syscall(__NR_signalfd, fd, mask, SIGSETSIZE);
+	return tst_syscall(__NR_signalfd, fd, mask, SIGSETSIZE);
 }
 #endif
 
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
index 960c7ce98..7909f587a 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
@@ -141,7 +141,7 @@ int main(int argc, char *argv[])
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
 			sigemptyset(&amp;ss);
 			sigaddset(&amp;ss, SIGUSR1);
-			fd = ltp_syscall(__NR_signalfd4, -1, &amp;ss,
+			fd = tst_syscall(__NR_signalfd4, -1, &amp;ss,
 				SIGSETSIZE, 0);
 			if (fd == -1) {
 				tst_brkm(TFAIL, cleanup,
@@ -158,7 +158,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = ltp_syscall(__NR_signalfd4, -1, &amp;ss, SIGSETSIZE,
+			fd = tst_syscall(__NR_signalfd4, -1, &amp;ss, SIGSETSIZE,
 				     SFD_CLOEXEC);
 			if (fd == -1) {
 				tst_brkm(TFAIL,
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
index ddf8b8c3d..4c9c2022a 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
@@ -137,7 +137,7 @@ int main(int argc, char *argv[])
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
 			sigemptyset(&amp;ss);
 			sigaddset(&amp;ss, SIGUSR1);
-			fd = ltp_syscall(__NR_signalfd4, -1, &amp;ss,
+			fd = tst_syscall(__NR_signalfd4, -1, &amp;ss,
 				SIGSETSIZE, 0);
 			if (fd == -1) {
 				tst_brkm(TFAIL, cleanup,
@@ -154,7 +154,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = ltp_syscall(__NR_signalfd4, -1, &amp;ss, SIGSETSIZE,
+			fd = tst_syscall(__NR_signalfd4, -1, &amp;ss, SIGSETSIZE,
 				     SFD_NONBLOCK);
 			if (fd == -1) {
 				tst_brkm(TFAIL,
diff --git a/testcases/kernel/syscalls/ssetmask/ssetmask01.c b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
index 336a9be3f..ca3a1dedb 100644
--- a/testcases/kernel/syscalls/ssetmask/ssetmask01.c
+++ b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
@@ -112,13 +112,13 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
-			ltp_syscall(__NR_ssetmask, SIGALRM);
-			TEST(ltp_syscall(__NR_sgetmask));
+			tst_syscall(__NR_ssetmask, SIGALRM);
+			TEST(tst_syscall(__NR_sgetmask));
 			if (TEST_RETURN != SIGALRM) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 &quot;sgetmask() failed&quot;);
 			}
-			TEST(ltp_syscall(__NR_ssetmask, SIGUSR1));
+			TEST(tst_syscall(__NR_ssetmask, SIGUSR1));
 			if (TEST_RETURN != SIGALRM) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 &quot;ssetmask() failed&quot;);
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index 8c9e148e9..1687ea157 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -126,7 +126,7 @@ int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
 static int mysymlinkat(const char *oldfilename,
 		       int newdirfd, const char *newfilename)
 {
-	return ltp_syscall(__NR_symlinkat, oldfilename, newdirfd, newfilename);
+	return tst_syscall(__NR_symlinkat, oldfilename, newdirfd, newfilename);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index ec5588410..aa9881f27 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -57,7 +57,7 @@ int main(int ac, char **av)
 	ev.sigev_value = (union sigval) 0;
 	ev.sigev_signo = SIGALRM;
 	ev.sigev_notify = SIGEV_SIGNAL;
-	TEST(ltp_syscall(__NR_timer_create, CLOCK_REALTIME, &amp;ev, &amp;timer));
+	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME, &amp;ev, &amp;timer));
 
 	if (TEST_RETURN != 0)
 		tst_brkm(TBROK | TTERRNO, cleanup, &quot;Failed to create timer&quot;);
@@ -65,7 +65,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 
-		TEST(ltp_syscall(__NR_timer_getoverrun, timer));
+		TEST(tst_syscall(__NR_timer_getoverrun, timer));
 		if (TEST_RETURN == 0) {
 			tst_resm(TPASS,
 			         &quot;timer_getoverrun(CLOCK_REALTIME) Passed&quot;);
@@ -74,7 +74,7 @@ int main(int ac, char **av)
 			         &quot;timer_getoverrun(CLOCK_REALTIME) Failed&quot;);
 		}
 
-		TEST(ltp_syscall(__NR_timer_getoverrun, -1));
+		TEST(tst_syscall(__NR_timer_getoverrun, -1));
 		if (TEST_RETURN == -1 &amp;&amp; TEST_ERRNO == EINVAL) {
 			tst_resm(TPASS,	&quot;timer_gettime(-1) Failed: EINVAL&quot;);
 		} else {
diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
index 88742b806..9d2e3ff3c 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
@@ -137,7 +137,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
-			fd = ltp_syscall(__NR_timerfd_create,
+			fd = tst_syscall(__NR_timerfd_create,
 				CLOCK_REALTIME, 0);
 			if (fd == -1) {
 				tst_brkm(TFAIL, cleanup,
@@ -154,7 +154,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME,
+			fd = tst_syscall(__NR_timerfd_create, CLOCK_REALTIME,
 				     TFD_CLOEXEC);
 			if (fd == -1) {
 				tst_brkm(TFAIL,
diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
index 41aa94636..ca70d1759 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd03.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
@@ -133,7 +133,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno &lt; TST_TOTAL; ++testno) {
-			fd = ltp_syscall(__NR_timerfd_create,
+			fd = tst_syscall(__NR_timerfd_create,
 				CLOCK_REALTIME, 0);
 			if (fd == -1) {
 				tst_brkm(TFAIL, cleanup,
@@ -150,7 +150,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME,
+			fd = tst_syscall(__NR_timerfd_create, CLOCK_REALTIME,
 				     TFD_NONBLOCK);
 			if (fd == -1) {
 				tst_brkm(TFAIL,
diff --git a/testcases/kernel/syscalls/tkill/tkill01.c b/testcases/kernel/syscalls/tkill/tkill01.c
index edce2b0b6..15f2dfb3e 100644
--- a/testcases/kernel/syscalls/tkill/tkill01.c
+++ b/testcases/kernel/syscalls/tkill/tkill01.c
@@ -17,8 +17,8 @@
 
 #include &lt;signal.h&gt;
 
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;tst_test.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 static volatile sig_atomic_t sig_flag;
 
diff --git a/testcases/kernel/syscalls/tkill/tkill02.c b/testcases/kernel/syscalls/tkill/tkill02.c
index 63fa664e4..6cd60923b 100644
--- a/testcases/kernel/syscalls/tkill/tkill02.c
+++ b/testcases/kernel/syscalls/tkill/tkill02.c
@@ -20,10 +20,9 @@
 #include &lt;errno.h&gt;
 #include &lt;unistd.h&gt;
 #include &lt;signal.h&gt;
-#include &lt;sys/syscall.h&gt;
 
-#include &quot;lapi/syscalls.h&quot;
 #include &quot;tst_test.h&quot;
+#include &quot;lapi/syscalls.h&quot;
 
 static pid_t unused_tid;
 static pid_t inval_tid = -1;
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index 75d5d2d28..d1f3dfd15 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -45,7 +45,7 @@ int getresgid(gid_t *rgid, gid_t *egid, gid_t *sgid);
 #ifdef TST_USE_COMPAT16_SYSCALL
 # define LTP_CREATE_SYSCALL(sys_name, cleanup, ...) \
 	if (__NR_##sys_name##32 != __LTP__NR_INVALID_SYSCALL) { \
-		return ltp_syscall(__NR_##sys_name, ##__VA_ARGS__); \
+		return tst_syscall(__NR_##sys_name, ##__VA_ARGS__); \
 	} else { \
 		tst_brkm(TCONF, cleanup, \
 			&quot;16-bit version of %s() is not supported on your &quot; \
</pre>
    </blockquote>
  </body>
</html>

--------------FNVRmDBs5vKvDJfPxXawND8b--


--===============1941546552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1941546552==--

