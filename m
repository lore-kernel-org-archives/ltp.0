Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39744CA5534
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 09:49:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 724183CB939
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 11:49:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0970B3CB29F
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:49:21 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22C00200939
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:49:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCeKe2bQEmBnrQjmxRDUwoPt0fETpriN7PTM8FJ5oj4lLWkBdbxecyQYlRJQDKCTjLlHzClxz3/lPJ9nxS7JJeQlZsQ+nB7cmv567y+Lnq9zCeGEwcoYKzIABX4fZAWuX8TMotXarnI+8YdV89JPeMdqdpWmq6aPbVqgFUjwnMOWtvxDzGNDQE4sMXSAffDlwbq58q/ktTugJAunwnLOWg9u7in+isoRgGMwAcISPwId7erjvZepdvGlxnLcJ9ArjlYLCdFHhCDgpgZxcuuFIxWfwq7GFHe9BG4Xpm+Ghny7cZV3aCKU/XSd2XKqSoFUWFh47jCMQZoYY3fSSHNOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKplBOgmCJIFZmMlInV7aZEQC/VcRILlKiqYto4ZbJM=;
 b=CDkLLIdkcdOPWkCHS9X9jTdcTo61vIPS6RRDeF8D1JtYFuc73+Tmlvb/8oWQxYK2lHK1REjYq/Nfg2QT0ipY+5FGxrg3wJiAJ+97kflUBokrMR/FlMOBPxpmEit9hBCa+r9ufGk9YOlrakpAMLdVf5FQKifiv0Y43Y/jOcbnTs5LI3SXPzYCLHZgyTX9CM/xVa5StxDlHSCp0fq8suNRHv230mKpwQkLDJxFGFcyt2vr8oi5D3D5pGKy0WkTi74EJvgIPzrMDtPaI7w8M/ZhbwYO5OiJoRwPLIBFbo0rDREQFeA7phsx5wzz67vMZL3kidYy846OZ6ks0aYi+KxZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKplBOgmCJIFZmMlInV7aZEQC/VcRILlKiqYto4ZbJM=;
 b=srwDaXCIKxF5izDDVAzbiWZueI/YJYrM6+llfIwzMkLrGQWRXyRxoTDezTEFOGXTZlynVQiATY4zOw3LVv99I+dJ/AjzFj1QXbfEfC4rpTHLLlTSbEaXve+Waqz3xvs1WbsOUn8IjYIJ+Htw8h8+8UGzbfxu6gJb3iorj4UnRglfzzIvR4nWByzvYzqQqYVGlQI3DOIjdWV35de6esDzj0pgkvmZmfd3ZdzQP5s8rUEpGaBfLuzVYtqFXEm/gVGPD8iJ7G3EUjjOtz6WrZ65xwTyl9rW/Kz9Gh4Lr34HnPJsxzyx3R+FkZoAQ80BdjDeBOD9BT3lR+pNoTsZH51WkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAWPR04MB9814.eurprd04.prod.outlook.com (2603:10a6:102:37f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 09:49:18 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 09:49:18 +0000
Message-ID: <0516136a-1e76-4e7e-9f0e-679894e4a632@suse.com>
Date: Wed, 13 Sep 2023 11:49:16 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <8ebe4638-fda2-43f0-98d6-8d49b9b5a1b5@suse.com>
 <ZP72f0JFeMhkNo9n@yuki>
In-Reply-To: <ZP72f0JFeMhkNo9n@yuki>
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAWPR04MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: f8acc1f4-8b43-4d92-8492-08dbb43eb297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obMt9dSyb9Qo58xFlon9bqGdVvoAFXb1jaGgKJrB5mEt3vOtrO8OvJaA8b5kKT240jX36OMk8eP4Riy9wYxK6xu7LV/lX6QHxD37SxYyS/9fVJ6v3Svl/ji5O/xgIkMAC8qtMsd8UR5VLAaGJoZyaI8eSYGAHTzQ8SXa/koSp40xJnqKWWmkcFa3KrcKlRZnAYjgeT0UVJCMGs6/SctZwFMt+o0mBcDvmWOmSI+MRjpviyqaFHtVlVS316D8Zk1tX1jvYcqDrqjpN/uvbZwkuiu/+ek3QRicOMHDnTNtSVRAZ0zEA0gimmfNZdWtUpcfzBGvEAmYAPmBM/9DT4FWIjERAB9FKpUjeKvEBwKcqAChPMaaIfI23z+So8gnlrn76EktwGOy5xBR8ak2gM5hKmwb+7sMI+weEZ/vLoBBUoFXvJJPXY5eBJit/AVCuC2tKEkYnLRC4zuKef8mTHvWGAwLMQ8ZKT62ZDA1aK7np7hdOqE4yVOdoTnCPiakOTFCYbpoWZ0nCXIokzK3xH1vklo6p0dNeyyLxJq7dliZuaiimS96abtqR9sC9yvv488FdDI++emfIqw1oNaqnR6oFNJDHOeB93BWBZqcZSuR1IZvcZXtqGzuzcjdum6nqnnN45nkqDVedtqG6K8ErnchPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(2616005)(44832011)(5660300002)(4326008)(26005)(8676002)(8936002)(6512007)(53546011)(6486002)(6506007)(31686004)(66476007)(66556008)(66946007)(38100700002)(478600001)(36756003)(6916009)(316002)(41300700001)(86362001)(31696002)(2906002)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ZpdjNkK2Z6ZEE1ZzFEZWVxQlZFTFJkLzZydnVWKzNwMEk5akdLdnlCQmM4?=
 =?utf-8?B?VXdYdW9rOG1vbTltWmM0RWhERC80STRldVB2STRsQjF1aStQYWVkYUplZ0ZY?=
 =?utf-8?B?enpyUnN6Skw1Rm1YWHVCQkZNNXJkLzI3WEpseVFUdjE2dmp6ZjAvL3J4QUxw?=
 =?utf-8?B?bnF5elYvVVovVkhKWWNJdWFCNEI2ZDNVZkZjdEVhV2tydmlyMXRHMi84SUFO?=
 =?utf-8?B?bFFIREwxSlVKNnppaUtXbW1QeVpTMGIwdmkvcFhkNEZqSGl0Skg2R2o1b1hT?=
 =?utf-8?B?dnByU1dRWWhkM0hrM2E1cG56dlV4M2l3YSt6eVY3NGhBek9yR1hHQmRaRW94?=
 =?utf-8?B?cFVubW4wSzRvL1RwMTc2WnFJRk0zczd3VFk4Q0J1UGZjTWFQUVV4L1pnZi8z?=
 =?utf-8?B?MjdUOHU0eUNPNlZFSStUTmliVnNPMWx1eTVONVZEOFBLMUsyR2dCSlBzRmto?=
 =?utf-8?B?MUZWWUdKRHorSS9nN2taUzBsVlgwRG9XS1lPUTNCeXAxRi93Z25hWTBnZHRW?=
 =?utf-8?B?VzBPZlJCbHNJek1Nb2g4VlB1aHAyenNReGFyYmZGd2VVMHRkZzVHanJ3ckNs?=
 =?utf-8?B?M1pyK3liYklNZzN3ZDBkeHlXQTNibWFDL3BZejNvdkFIL29oTzlkeVEwMDFk?=
 =?utf-8?B?Qm80TW1WS1BuVkJLbGNnRW1qZzJGN0x6dHFIM05zZnFLUjdvdlhqMGxqaGpi?=
 =?utf-8?B?ellXNjZuc1JkQ0NvRlhyYmR4VFNsdmMyY1JrdXBjRFUzWWZkUDdEVmN0bTVl?=
 =?utf-8?B?cWgzRm11bit1TlJ3eDdnek1sY1M1alQ3cTEwcDBjWFBVVisxQTV0VmZ2cVJi?=
 =?utf-8?B?NEI0dFdUL2E5MmZJU2RmbFZwMlZnRjk1b3pmblhoOUtoKzJZOXdsSUVjRTRx?=
 =?utf-8?B?Z3h1NGR0UWJqVXF0MjlHQXI1U0Fhc0UweUtBU0I0NFJod2RwVEJ4NEN6UkMz?=
 =?utf-8?B?ZVNiWEQ0YlpreHMvSUQzMGNSR2x4bUtqZGl6ckFPWTYxUFlESitNV2xuVE1W?=
 =?utf-8?B?QXJnc1pUb3hmekdYOTU4engwZnh1ZURGS1grdU5YRnJoVVlac2NmbmZKVWJH?=
 =?utf-8?B?QW1KMDNZR0MwRGJwL2VDZ3NSWVlDMUZNRWdvRVBsZVpidHpjVVRIQ2oyZzVH?=
 =?utf-8?B?U0RSQkFncDhrUDQ2YzhxR1lQOVpabHZENm1TVkVneGRreTYzeGZEV3lpd3dw?=
 =?utf-8?B?QVdscko1RmJuNVhuRk1QMU93bERkYTkrZ3VrdmhEYk1jQW9CRVdITG9rSUlr?=
 =?utf-8?B?Z1p3dWhmYytlMDR6K3R6My9vR2tWUUFKRStDMXZRNWFzdFpyc1YybENzaUdL?=
 =?utf-8?B?MmdmSE5ub1A1MTJpM0F3aHY4a0paOGR5cm4vWkhUZlpNY2s5eW5od1ZrS0dD?=
 =?utf-8?B?Q3VnTllOVFdMZjFHSWRhSnA3a0p0TXpvUlVMcXM1cndhYjdocUZ2WjNCQjlR?=
 =?utf-8?B?ektmVzVjdlNhSFpBNFRhM25TV2oxRmpubFpEaktyRTEzMHlMc1BIYkord0lT?=
 =?utf-8?B?cUVYMlRsMDFRTlh2cXFQMUQ4WTZFR1d0OTc5QmJESisyNUl5UTJhQTNlZExW?=
 =?utf-8?B?S0RtM1I1Ykd2QU9XbERQKzI3UWZERnYyaE5LeE1kS3U5cXppMW92ZmhGMDVy?=
 =?utf-8?B?akZjbXBqNTU2YStYcE9rRC9XRElMVVZ2cHFiK2FJUEI4ZDBsOTh1cjBFenR4?=
 =?utf-8?B?RVB5QmFMbjVRUlM1SW50R1BwTDBUV1ZYcTFlckRlUWpHaWh6NHM2L1N5U1hq?=
 =?utf-8?B?NC9aOFlLa2s4cTdUcHlRUy9oUG1XaUtYRS9ka3QwOWJVY2pxY1MyUlBwc2ts?=
 =?utf-8?B?M0UvUU5IWDBwS2pHU1pMVi9DK2NOWjRFM1F6SGpRTjhvdE54ZW9sSHVoeUdu?=
 =?utf-8?B?V1cxU0NMTjNHS0FDRkJkN1dDRi9TMDBwL3Y2bjVMeDlibmszMkM0STFkQlNH?=
 =?utf-8?B?YWZ1OUpGKzlJdDR3dkdkL20vRmJ1UHJNOW4yNFd4SGtqbGU3K25qa3J2STYy?=
 =?utf-8?B?VzZWbWVFem9Najhwb2gvcFozUFpyZWpGZThQWmhydzJ0ZkFTQlhCZE1wNFdn?=
 =?utf-8?B?VmpZc2VRNnNWMGd5dVVYOGZiQm4yY3pXR1dlQzdsUVhpMFptVEhhOUhJaXpT?=
 =?utf-8?B?YVZIdzBWODhDSW14aitheXAzVFhuSFBtVGQ5VnEvUGZucVpqZHh2NGw0VGY1?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8acc1f4-8b43-4d92-8492-08dbb43eb297
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:49:18.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIo5igJLQ0037fUGANOw8ep5d7vupabKm59YkEYWykvzqX4smmGOe3VQjPQL44PzHSJr4y3SEGaMykaaw9CYwDMqou/3hoxGsXUOs0eDytw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9814
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Replacing runltp-ng with kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 9/11/23 13:14, Cyril Hrubis wrote:
> Hi!
>> The idea, now, is to replace runltp-ng, since it's not maintained
>> anymore, and replace it with kirk in the LTP official release.
> Given that runltp-ng evolved into kirk I suppose that replacing it with
> kirk in LTP is what we should do, especially since nobody is going to
> invest into runltp-ng anymore.
>
> I suppose that we should:
>
> - put kirk to some more offical place
>    should it live under linux-test-project umbrela?
> - replace the submodule
> - add symlink from runltp-ng to kirk
>
> Does everyone agree or should we do something different?
>
This is a bit tricky, because kirk is not 100% a LTP project, even if 
LTP is the main framework we run by default.

I guess it makes sense to live it under linux-test-project, since we 
started from there. Then the rest comes easy.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
