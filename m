Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077BEC636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 12:31:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0AF93CC231
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 13:31:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A08F3CB14D
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 13:31:47 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A284D600954
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 13:31:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkMrTDcnWu6b1odzAfgNV4oZBOLBpAIuqg2f5AncjpgZHNaRv+YrhQiK9CEhlH1JEAlu43/dKsKbS6fIIbM+3nmsKWxKcbgayeXmQ9q//ryQxsD7tRKmzbCVFsYHXc0MA3eB1aBV+HQlsnIotZfKF5qxxlbf07pjoxardKpEXmfTEu/m7fH3VRrRZV/7wY1Q9ezyDpM4p5lAEyOrttRtRYTt+7e0vgLq98rHaD+kT5y6RLCPZwSFfHiV5PkIiIrp3mU/kE3RAE3mshuh+Cp9z9tru5stboDnMJ+AsIdRzf7HykTU0IpEpHXtTyUSall0B/UnlyJboqImZ9u2+VlKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccyVhBRmj4YGyrMxMZyetifuYoJkaoKM7UyMSrN0Ue4=;
 b=k/681XZKdxpcUCxRne2MVI0gjTHESKGJa5f4qJG81cT3HVAoEL4oPZFueCVQacYPLS0B7lwhWO7NbifdZz3lmuZ3lIumZTS5PoMu5Z9cIHavrK/JKUkgj9R1JIWkXCw78AadsvrtEmjdRoSs6VLTMRns9uLIEyYIvk1n1JoHpIcbdCGMM4k66q9n8cGJWKpsEreko6AGv1oQyX52XLiB1NDS0KQMiStOnjXTShTQyuOqUig4jcdKGM+oJz4RTPnTQKjbaNbOx8FYRIRX9gGKwFREYS4joZaiaJ43j6Pa2zTSLhFZVMA/qrZjqPNnk7hbT/A2weT8dGzvENMp8Dne1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccyVhBRmj4YGyrMxMZyetifuYoJkaoKM7UyMSrN0Ue4=;
 b=lTPVQz0XK73c9vQTAu/W7yP/+fGVaruHZRi5eWxVDKTzdU83EhmoSzGG5yAYPi4nMAGQS0R+Jkz/UHDY1RBgkX2RR9G4OfA0A72Ll9EWRAfeHNf/mX3RIDSE462gCex/UNolo63qUAFw1jaqdAw3G+s/G6aaYJiYYWlAxDf0aA1cjTQyAE6+RoKF1myPogY5pUA04FTHkBdHrrTdsjpVhawOoOLhsnAftkue12chuP/wSDwFXLzT7kA5rMR2xdxbBaYab3WpFg1X9B5WZ4v5jp1t7Q405XeJY+eO4fmJ5zcAkeUJRMkt0qcwuHK4U5pdojlvhC1tFHlieJ/JuMFomQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 12:31:44 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 12:31:44 +0000
Message-ID: <908d53fd-fade-9f29-e4d6-975738522c9b@suse.com>
Date: Tue, 7 Feb 2023 13:29:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230207122455.28177-1-andrea.cervesato@suse.com>
In-Reply-To: <20230207122455.28177-1-andrea.cervesato@suse.com>
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ffb79e-8ce2-4bf2-7a5d-08db090745b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diqbGpyKxz5DC20wYsUybwcHo+2xabWCw6OdHP2P4QE3nx+o/nCNmeZq+gZF/yZyLNHl4p7rl3b3hVGjYW/YxUDTk2MuB7CAI9nk0vpK/YxyY3LW/7WX62maVg32tkZofBvz+NwZW14Xk1mz89nfbG8v3QYDASyVal3UK9k7CHpNcZtiyoh6KPFFU44VyRHzTQhmo+JOwgDlsX6x6apda9kM/xnFPTqkEF40BQ3gJO/ZjAM6C4kw/tXp1hdK/izMY8j4pJZ9AVuU2L2B5GtPib+wrMV1zx4ypgawXGwyR33OL1PGHtvlJ5imLNDicLiQc41w+GcdYKEnCnJj94+eKMp9+WFci/3qeRbMzY9KWrIYe+gxftqgp9ILymF2KLaw6UT6xbzRsXLJ7x7t6/q8Q5z3o5bkreVLlhr8ywsnEvhtT7ikarw9Z3kia6e57zDlGsT0IIJ3ECy79RkIOaUdNX7uo2kD+4GoIssvHdbBe+HESdQNmvtqwFrbPRFuSPCHFBfcc4cJeERAxBlmQ8c03lnEuepRGEWl8+WOjPFhGoH1bu8E/f8IJZXNkYSYJc7ZmsoJPbuxdeixw4dD6cUU6PQxsJEqgCCrGO0PYy61oSKaH/Q7/ToMxyNuTzH+HSF6ONuEUqyxT+muuLQIn7rfeAKbJVjJoU8YiDer0YZoJDdwRXjvDUwNccMIy++3mQn5hnfAWTbjAEeuno0EIU/ty0Fz4hRlGvYqKg8yjEUREWcrM8748mM0BAULpkxNrVIm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(26005)(186003)(6512007)(53546011)(6486002)(41300700001)(6506007)(478600001)(83380400001)(2616005)(5660300002)(6916009)(66556008)(66476007)(316002)(66946007)(8676002)(8936002)(2906002)(44832011)(31686004)(38100700002)(31696002)(86362001)(36756003)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlhlY29YVTFiTytZR3lEVzBXT0ViTFFaOXhiMGFvOFRzcjNEMm1sY213MUh4?=
 =?utf-8?B?RW9WTHJibzVTVlpHak1pblpCQzc1MVNLa3JRaXNTMEtjUDJCZ2NUU29QaHJr?=
 =?utf-8?B?MExvYS9OZ3pTc3BPSHg0RS93RHpucnJxOWw3RFNSblNTZ2lEOTFVcnAzbUVF?=
 =?utf-8?B?TWhjK09uQ2VGVDhTV01aeEhWeG5MRjk5eVljTXBaZlgyZU55MVZOSy8wMWxL?=
 =?utf-8?B?eE1wVFo1TmZiRzhNSm1yTmMyQko4b01UKzJ3RHBjOTJSMGQvNmJzbnNSdnJN?=
 =?utf-8?B?RVhpM0QzS0g2RzRsbGJOSis4alkzdnZwUUlDNDNjeDcxWHJLblFucGM2R2xx?=
 =?utf-8?B?UU9HOXA3YjFPMllrRkdPWlNFSVkrYzQvdEdHRURWSEk3NlhPL0ZTdTZmUUV3?=
 =?utf-8?B?OVZLL2ZwZTVSUEVraW5wSnBWZWZCRWRBQlgrQXN0aEpMaE9heFZpRXpWU2pO?=
 =?utf-8?B?N0xudFJhb21SOWJydlQyWEVCZTQva3pBM2hFS2JCRkswMEF5bmQvSTVnbDln?=
 =?utf-8?B?WEM0MWRieVFJcmZSRlN5WmgyMERnNk8xVkhhL2l5bW8rTjlrRTFUdnpvTnZw?=
 =?utf-8?B?QjBPOW43STZUaHZzK1h3YjdNM1R4dldRTm1vbjY4Nlczc2d5eXBHakIycFRL?=
 =?utf-8?B?Z0YzMU5LYWQxVHRzK3hnZ05WTmhPUVVWMnlGQW1oZ2NsTHNQeEwyWlNWWW9R?=
 =?utf-8?B?RW04c0xwbEIwbEEyN2xCVjJPaWtpUDFNZ1F2cXpod1NNVk9obVcwcC9jQVJW?=
 =?utf-8?B?WE9aUnZGMW5vUC9CMDBFYVhDbTU0SjVLd0RuSVZCUmlXQURIK1c3MkRzeDE5?=
 =?utf-8?B?NGhYbVVRWVZkV0dpWGE1cUNneVVQZ0EzNmt5Z1V1a1FqV2kzTTRwOGlzanZV?=
 =?utf-8?B?WVByVVVKT1Z6TUp6ZXpURktlWU9IOENib2VMNmRHUzVpVVA3MUtuMys5amlo?=
 =?utf-8?B?R2p2V1IrTnNzSE5JU0dBWlJiY0JCVlF4eTlMdm1tYnJoekpRN1p5UGNQUHBM?=
 =?utf-8?B?QTBaVzJXRW5WS09aNDcrVzlsQXRsbjMwQUl6Q0pZSC8zSUttNUFHU0FQcVBD?=
 =?utf-8?B?cnUxRCt2ODlnN0RSUzVxT2NrTnQvLzB2N1BaOXlYemliYUt6a0V6TDB4ZkRK?=
 =?utf-8?B?QTRvUzgzVHh5Z2dETGplZzhmYjFxYWFJcmNtT2VUL292TnE5c3ZsU2dFL3ZN?=
 =?utf-8?B?UDYvak96OVFhelgwOWNudTBQY1BOajBBSUZuaVd0N1orUXorZWIyTnVaOVFl?=
 =?utf-8?B?Q0tVb05jbVFSS1pxMC9wTGpmaGpncFZMejQ0blE2cFBRU0lRSHExQnQwMm85?=
 =?utf-8?B?VkxoOFZscVVUTVNlRm5PdGxvUDN6elptS3dOaVZLMHp5ZlRtVFlsOXFKY0lJ?=
 =?utf-8?B?MG9RNWJHZVNGS2RZNjhsZHVZbGF2Mi96NUdVaTdmTFZhQXAzNGErVXFEbFk3?=
 =?utf-8?B?ZGJnbjM2aHIwcDNDYUlGZjVOUVV6OGtxbE5Calp0U2RKWUVpREl5S3NsZTNn?=
 =?utf-8?B?bUZnR20yN3A3SzhMUGs1a3AwbVZQVXlzVStsTDhDRFI1NmNJVm04WURzbzRX?=
 =?utf-8?B?dWlieFVLenlSL01FZXY0VEo3UUFrT3kvakJJRXNkSDNvYkx0VDlySjRwZ2VW?=
 =?utf-8?B?aG9tMWY2eGhkVXZjcHdoNE1IUEpFYUFHcVhqeHhBSkZqTlNXdHZPMnlOZDJU?=
 =?utf-8?B?VzFIV1Q1QWx2dGJqQ2ZKVEszemVNckN5cloyTlRySE1kWENzYzg5OHhjUS9l?=
 =?utf-8?B?YmU3b1hVZ2EyTXUvN3RObEZGQ3p6cVpGOUxKa2krMEo0WkM2N0tRMlo5aENZ?=
 =?utf-8?B?SXYwNytZV2dOOEdCOVBsUWVJb3RycHA1cmJBUlFOejF1aGtWRVpzeFBTY0cy?=
 =?utf-8?B?Qk1oblo2bFNpREtkbHJldC9lUDRqQ0YzRC9YeWdtVzdhcTBLTnl3cGVYOVIw?=
 =?utf-8?B?dEFLdmNFN3cxUUcwcFFKZUFEcU9LTHNUdGxickZIN05QckVEZ3RIdElRVVVI?=
 =?utf-8?B?eTFVZEdhSDgxYWYxNnJpOWUvMFRDcktLdlBHR1Izb1hHVHY4MXNhbDB3NUUy?=
 =?utf-8?B?RTZWNitmMGJDbWJPUXBKaHRmSVUyMEVBaU5XRXJVZVp4ZEdxQjd5RjU2bmwv?=
 =?utf-8?B?S3pESFR2ajNGRHhHRGI1aTREdW9HTFFPbS8zTndla1d1L1J4VmhmUjFkcXhR?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ffb79e-8ce2-4bf2-7a5d-08db090745b1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 12:31:44.3142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A21AJWfr8QejTzBG+80qYe5FJ1fy/eryragwurug4Vr0GYNyMHEDjDa5lb2KNGWIeuI/L2N15Vu+ww6SILKErrxjv5TO0pXt6bPc1V1eopE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Refactor pidns16 test using new LTP API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

counter flag is unused. Please consider v4 instead and ignore this one 
thanks

On 2/7/23 13:24, Andrea Cervesato wrote:
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Using tst_clone API
> More TST_* macro usage
> Better TINFO messages
>
>   testcases/kernel/containers/pidns/pidns16.c | 193 +++++++-------------
>   1 file changed, 62 insertions(+), 131 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
> index 2ee61065a..121da8e63 100644
> --- a/testcases/kernel/containers/pidns/pidns16.c
> +++ b/testcases/kernel/containers/pidns/pidns16.c
> @@ -1,157 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> -* Copyright (c) International Business Machines Corp., 2007
> -* This program is free software; you can redistribute it and/or modify
> -* it under the terms of the GNU General Public License as published by
> -* the Free Software Foundation; either version 2 of the License, or
> -* (at your option) any later version.
> -* This program is distributed in the hope that it will be useful,
> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> -* the GNU General Public License for more details.
> -* You should have received a copy of the GNU General Public License
> -* along with this program; if not, write to the Free Software
> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> -*
> -***************************************************************************
> -
> -* * Test Assertion.
> -* *----------------
> -* * kill -USR1 container_init
> -* *	- from the parent process and also inside a container
> -* *	- Where init has defined a custom handler for USR1
> -* *	- Should call the handler and
> -* *	- Verify whether the signal handler is called from the proper process.
> -* *
> -* * Description:
> -* *  Create PID namespace container.
> -* *  Container init defines the handler for SIGUSR1 and waits indefinetly.
> -* *  Parent sends SIGUSR1 to container init.
> -* *  The signal handler is handled and the cont-init resumes normally.
> -* *  From the container, again the signal SIGUSR1 is sent.
> -* *  In the sig-handler check if it's invoked from correct pid(parent/container)
> -* *  If cont-init wakes up properly -
> -* *  it will return expected value at exit which is verified at the end.
> -* *
> -* * History:
> -* *  DATE	  NAME				   DESCRIPTION
> -* *  04/11/08  Veerendra C  <vechandr@in.ibm.com> Verifying cont init kill -USR1
> -*
> -*******************************************************************************/
> -#include "config.h"
> + * Copyright (c) International Business Machines Corp., 2007
> + *               04/11/08  Veerendra C  <vechandr@in.ibm.com>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Clone a process with CLONE_NEWPID flag and verifies that siginfo->si_pid is
> + * set to 0 if sender (parent process) sent the signal. Then send signal from
> + * container itself and check if siginfo->si_pid is set to 1.
> + */
>   
>   #define _GNU_SOURCE 1
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <sys/wait.h>
> -#include <sys/types.h>
>   #include <signal.h>
> -#include <unistd.h>
> -#include "pidns_helper.h"
> -#include "test.h"
> -
> -#define CHILD_PID	1
> -#define PARENT_PID	0
> +#include "tst_test.h"
> +#include "lapi/sched.h"
>   
> -char *TCID = "pidns16";
> -int TST_TOTAL = 3;
> +static int counter;
> +static int signal_pid;
>   
> -void child_signal_handler(int sig, siginfo_t * si, void *unused)
> +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
>   {
> -	static int c = 1;
> -	pid_t expected_pid;
> -
> -	/* Verifying from which process the signal handler is signalled */
> -
> -	switch (c) {
> -	case 1:
> -		expected_pid = PARENT_PID;
> -		break;
> -	case 2:
> -		expected_pid = CHILD_PID;
> -		break;
> -	default:
> -		tst_resm(TBROK, "child should NOT be signalled 3+ times");
> -		return;
> -	}
> -
> -	if (si->si_pid == expected_pid)
> -		tst_resm(TPASS, "child is signalled from expected pid %d",
> -			 expected_pid);
> -	else
> -		tst_resm(TFAIL, "child is signalled from unexpected pid %d,"
> -			 " expecting pid %d", si->si_pid, expected_pid);
> -
> -	c++;
> +	signal_pid = si->si_pid;
> +	counter++;
>   }
>   
> -/*
> - * child_fn() - Inside container
> - */
> -int child_fn(void *ttype)
> +static int child_func(void)
>   {
>   	struct sigaction sa;
> -	pid_t pid, ppid;
> +	pid_t cpid, ppid;
>   
> -	/* Set process id and parent pid */
> -	pid = getpid();
> +	cpid = getpid();
>   	ppid = getppid();
>   
> -	if ((pid != CHILD_PID) || (ppid != PARENT_PID))
> -		tst_resm(TBROK, "pidns is not created.");
> +	TST_EXP_EQ_LI(cpid, 1);
> +	TST_EXP_EQ_LI(ppid, 0);
> +
> +	tst_res(TINFO, "Catching SIGUSR1 signal");
>   
> -	/* Set signal handler for SIGUSR1, also mask other signals */
>   	sa.sa_flags = SA_SIGINFO;
> -	sigemptyset(&sa.sa_mask);
> +	SAFE_SIGFILLSET(&sa.sa_mask);
>   	sa.sa_sigaction = child_signal_handler;
> -	if (sigaction(SIGUSR1, &sa, NULL) == -1)
> -		tst_resm(TBROK, "%d: sigaction() failed", pid);
> -
> -	pause();
> -	tst_resm(TINFO, "Container: Resumed after receiving SIGUSR1 "
> -		 "from parentNS ");
> -	if (kill(pid, SIGUSR1) != 0) {
> -		tst_resm(TFAIL, "kill(SIGUSR1) fails.");
> -	}
> -	tst_resm(TINFO, "Container: Resumed after sending SIGUSR1 "
> -		 "from container itself");
> -	_exit(10);
> -}
> +	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
>   
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newpid();
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	TST_EXP_EQ_LI(signal_pid, 0);
> +
> +	tst_res(TINFO, "Sending SIGUSR1 from container itself");
> +
> +	SAFE_KILL(cpid, SIGUSR1);
> +
> +	TST_EXP_EQ_LI(signal_pid, 1);
> +
> +	return 0;
>   }
>   
> -/***********************************************************************
> -*   M A I N
> -***********************************************************************/
> -int main()
> +static void run(void)
>   {
> -	int status;
> -	pid_t cpid;
> -
> -	setup();
> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
> +	pid_t pid;
>   
> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> +	signal_pid = -1;
>   
> -	if (cpid < 0) {
> -		tst_resm(TBROK, "clone() failed.");
> +	pid = SAFE_CLONE(&args);
> +	if (!pid) {
> +		child_func();
> +		return;
>   	}
>   
> -	sleep(1);
> -	if (kill(cpid, SIGUSR1) != 0) {
> -		tst_resm(TFAIL, "kill(SIGUSR1) fails.");
> -	}
> -	sleep(1);
> -	if (waitpid(cpid, &status, 0) < 0)
> -		tst_resm(TWARN, "waitpid() failed.");
> -
> -	if ((WIFEXITED(status)) && (WEXITSTATUS(status) == 10))
> -		tst_resm(TPASS, "container init continued successfuly, "
> -			 "after handling signal -USR1");
> -	else
> -		tst_resm(TFAIL, "c-init failed to continue after "
> -			 "passing kill -USR1");
> -	tst_exit();
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	tst_res(TINFO, "Sending SIGUSR1 from parent");
> +
> +	SAFE_KILL(pid, SIGUSR1);
> +
> +	TST_CHECKPOINT_WAKE(0);
>   }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +	.forks_child = 1,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
