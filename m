Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535EEC77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:09:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B87FB3CE954
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 16:09:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED0A23C995A
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 16:08:50 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07C211400DAA
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 16:08:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQSKN/XcA8dp2kC0eRo0ttxvwP3N7BrS/uklsl1Z7pZK86xENCOD6RoSvEMwMnT0QswV9v0ZEM7y9OrDQVz8Yn/qjBywNqoZJBsOg5Q/PeOiqjbdl/hFo1Qxf4qxdsJhK3VOVHiz2jBxAS1e78sD3+3cSnkPaw1h9i/JYqjED+zJBFhRR6YrHsxypFEjk0joVuQll6vrmi8RRApqRHSC3uEj7mJvuT9jKgUGt5NOKnXihvBe4PNQrQtSpyklI8Z0prOWQ9rJCVJm80APjbfm+W65STsnLJ6i1vuE6d/woqY1AzaSp9GrW0le/zCvvth0v3/BQ5Jkr0YTEZPuF7QyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqCc+tqyky48Gfmss3eTvw7BZMqayR/O4t02G//rO90=;
 b=moNPTfJ2Ta3p7AHEC/82LMF0GYs5Xp7XQ+fjVyTDLlegh0K+H5f2ewkm7JZgmLM7mAz59x9SOUoP2eTCxTTuDMT5dYka3ea0313KPH7Q7iYslb7dMVGZd3RS9QmHEwHz+w00cjgK8u2EVsPlw81jJdNXBiiiDqPlQDiU54Fro2y1pcG5Kx3s60NOmNUcMDbwjock1BPURKWqzwmrcGGD1KZ2skTjcxxVOZH5duSliu/GNWwh/kuQTlDRQtCvpgqw1rv8QoiQ0z52wYaalhbV5uWtYZLK1DuDvJ5+SqrDISmk6wvYR9uMrllTac81aP/7OWyK66cQWOufXylMWOXR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqCc+tqyky48Gfmss3eTvw7BZMqayR/O4t02G//rO90=;
 b=w2A6j9K6N8TFqroKhzGLdKEAif874+HRLb1K38Q9EnRywpAZ/TFdoJYnU3I3+cFqDVBpc8ouCWmhkLQemSsRimoi3thfK5kVDy158Vqm/FIWi+qRJEmhENSOjo+HloEYVn89PjFD7JzT73dvdH+TGoXF7GT4AfCr7oAiB7n/2uTrPzGjgL5PvlG6/GfNLpqcHIbfSGsNw75jvH6JTCxn0eliP0T+4coVUNU9jtyMDSqPRoXLY6zLzHYAetziKqTKN6JYI5CaPdtXZy8Zht32pgLVCVqGHiau3tw5a3pSa2hZyRhTXoKYipijb6aOhcKJERgMgnznUh5YntKf6AUOCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB9PR04MB8284.eurprd04.prod.outlook.com (2603:10a6:10:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 14:08:47 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::54ce:4ff6:8295:1c06]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::54ce:4ff6:8295:1c06%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 14:08:47 +0000
Message-ID: <760b40df-f580-b6ff-de5b-761734770fb8@suse.com>
Date: Thu, 27 Apr 2023 16:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
References: <ZEjsKC6ESB1+mM0H@rei>
Content-Language: en-US
In-Reply-To: <ZEjsKC6ESB1+mM0H@rei>
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB9PR04MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f3d1ae-f969-45e3-02ba-08db4728eafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOsO+vW5WN/QOkA8FLhrey0R2h2cvMznKB/j/bRUm3T75mv/XGOIA5lBcgb+DQIYYgBf6006DTb/rdMSweI/2LLT/8FccTjwQX30fEkmr3D4Mb2XOUWaCdmZOQfEHIU8WE/qYP5v/QOiThcz66yMj/qFvDqUtghHQf31oBohnzOFsWtcpJ8c7I7WKtQCr6G9nOD+i/9l3yA7EFiyW//ZjvATXtsPFsK5r3oVI00p6bWhW+THxNEUTLtSPLXHk4BcySJ4fBg0G3ovdH8CYmbfcDurHGrCRGDUbR+QyzK5vTU2VM4mPrOUEcnPLEdPqIUv9tNo/8rOoD6tW78ux0HLxWou7jCkpBzTBcTtpTHIlbyKIOm6yNRD99TNLiRA+mlAWPb1I6wZlNRgVyZjwJ8EwBcze9FHQFIoaGdiNWWPiLH7NbKpzpsJ12fHYgQzXptJNqaulqnDE9cyAdN72p2ujCw+mwoaJqkYXgQvv7tOzTsDFynpZqcSB+G/Wws+2JWVtekpH+YldbEXsAaBAbRz1Pv4AexqmC4eCUUNwkPNDCIP8ZnGQouKDzGFKvUPMJNI8SjdR9sx0gcO77UnHiQZJuSQhq+VkaudUyiwcsXHSU9lS6FI1/wjyexSkyvN4nQUobZ6O7p/E/I9N3/M9OuU5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(8676002)(8936002)(44832011)(26005)(316002)(6512007)(6916009)(186003)(6506007)(53546011)(6486002)(86362001)(6666004)(478600001)(36756003)(41300700001)(66476007)(66946007)(5660300002)(2616005)(31696002)(2906002)(31686004)(66556008)(38100700002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0IrNUlyOEZnU2IzNHZncDFpTzJyNnE1Sk11RHpTZEtJVzJkZTh6T2MvaTA2?=
 =?utf-8?B?bmRsNXVlY1JPWVM3ZmVFK1QwZG1XcUFyQnJHVExrMHllRy9FcU82MW1EVEdm?=
 =?utf-8?B?T2FKNDRoMUhSdlNwSm5ZM0FKSUxGS2JyZHY0QVk3OEhtQ1NsMWVnQndNdnFu?=
 =?utf-8?B?TVhvMmVlenhScEJQVWFwUTl3aXo2VkRRQ0NZeS9tMUZmU0VxRThTYUlWVHV5?=
 =?utf-8?B?SGNXaVM4eTNkK056cUxxOS9DSlgrL1c4dE1OeVRLdkZKbER2Znh2clA1OW5m?=
 =?utf-8?B?aVczenpaNU1GdTVmTklVdDFNSGVudXhtS2pzc2xRN2dCWEh2ZWJCdlB6enoz?=
 =?utf-8?B?UFoyZTdYaEJTWHpvSkJLSlhDM0pVcHJ1Z1lSSWcybUZEM3l4a2FGT1BSdVFJ?=
 =?utf-8?B?dW9uOUFzQXJkaHpmK2pIUUlZTUNzQzZMMCt5c2Fzb05UdXJFWWovWjg3UEN4?=
 =?utf-8?B?R05pOGpYNHU4YlE2dWtWTVVmZ0E5ajBnblpNQnM3dXM1dkM4ODhXTGZ1R3Jm?=
 =?utf-8?B?RzdRWVJITjlaWkV2Z3llQ1VtZUkrZVR2TlkyYTdtaW03QWQxT1NiWGRQdkZE?=
 =?utf-8?B?OWtWWklqcFE5bm1sem1kUWt5amViVWNjcXhwTEppRjVUOVU2cVg5b3B6UlZt?=
 =?utf-8?B?cURxVjdmZ29kS1NRSUlCZ1lkc21mSW9IMThlNTJaZ1YzMVd3em1aWnA5Wnpl?=
 =?utf-8?B?VmNBQkFEUkhXKzVjWWw1REw4bXJNSVlBbk1iVnFudVYyQUZaMjZkbjllYmIr?=
 =?utf-8?B?Zy9oNjJFYkhwaFVpSFNQR1NaZ3ZGNjB1T2U1NWdsUG4raVhLTG9NbEtqUEJS?=
 =?utf-8?B?T2JpQnBTMC84SVQza2VKdTNTVUliYkVmWnhBK3pQT3BuUkVXTnNZZVRVTGo2?=
 =?utf-8?B?c1hTTlB5RjNnRExrNS9rOXU1U2YvdjZRbW90WndiZTlrRU1SeUtsbVkzMEZH?=
 =?utf-8?B?c2p2YTNkRnhZVk82aTNad3hQWW0wUHU0NE1sb083aGVaSzVnK2FkeEl5Zm1H?=
 =?utf-8?B?OGVBZUZQY2E1NTM4UndoVDBHVERXelJmRUg0cGFOTGlCVWwzSDlYa2FWMkJL?=
 =?utf-8?B?cEZ4ZkJXTnV6Vlk1V1BCQnlFUzM1ODlYMjA1Ukxla0U5QXd1L0Q4RC9uM2Ns?=
 =?utf-8?B?dGxkTlJ6QmJFT0Evd3FSSFNPNStyUE1ZT1hqbnAyanZ3MThXTDJkTlBQWVBt?=
 =?utf-8?B?QWlua0dRWnZHYkVtM3VRbDF2VDV4SnFFOVJ6dFJnbW1KZnY4dkZxbTAxTm84?=
 =?utf-8?B?Qnh2K2RaaGhMQXBsTGJZUzlySWk1YTlTaFliOVlIb0VQOFkxbnpYVkQvYnBL?=
 =?utf-8?B?bG1wcTd4UzB6UWdxTzJLeWhxTC82WEVtRlFna25WcS9iMnpPNElqZE45aER6?=
 =?utf-8?B?OUdNWVhBcm4wcHVvbWo0ZEY0WWR5MzdnOHFoZTdxejJGb1pFVHlBNmNSVS9h?=
 =?utf-8?B?Z040RVNjZVJ6cDNZbk9XWGhXMjBwVDZMTkRGa3VhSUlMNlQ1c29ZRGZydE5Z?=
 =?utf-8?B?QUFiaXh4bjNwd3kyUHo2RE5CNWxaSGZNbllZTVM2Q0F6OFlZQmhBU1hqYzhU?=
 =?utf-8?B?QmlIaVg2d3N3WkVDdzZaQ1pzN2UvTktCT0l6NXZ2THlFeTRQYlVqZ3ByaUVw?=
 =?utf-8?B?Mi9BMWRtOEloRGJQTEllWWVCZUxYM1BWL0Fsb3ROTCtpbTlyRG15UUdVQ3lx?=
 =?utf-8?B?UVdiRytwK2M1dFZOdTVDL1hmdUFMZUJwalZ3aW5HWXZYNTl1b01Qc1orR05z?=
 =?utf-8?B?cTlRNmV2QnljUHRVRTNHbmRjRktJekMyb3MzTlczUU4vNnhoYi83K0JUQ2tk?=
 =?utf-8?B?KzJYNVdMNktTNzRjSG1DMEU1UXBkRHlBaVM2UkxhdVFGQzh5cW9ndXBLWTlR?=
 =?utf-8?B?MGlOVTlVMm5VUlJHTU5jbkFZTGlQQkxwWTI0Yi9DK3psS1A1aGo1SzRkRXQx?=
 =?utf-8?B?ajdFWTllQ0FuQTg0M3JOQU5Oem9YOUFWcUNGSFV1TEp1V3pzSWhEMFFKbldS?=
 =?utf-8?B?MHBnRE94TmVCdHlPTUJhMWR3ZG5KbVZBaFRTekNCU3pjV2NLSy81YVU5cTlD?=
 =?utf-8?B?SFRBQjZZU1dqZmV6QXlMNjh5dmY4enBWVU5hZzJVVTBycDR6eHFTUm5wSlR1?=
 =?utf-8?B?Z0Y3Ynl4VTRxa2VGVVRpSG1mRGdGempoMjg0L3RzOXZBTlRNWmQ1N0lYam5H?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f3d1ae-f969-45e3-02ba-08db4728eafd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 14:08:47.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLDTY0Eg2hWhiHH5YvRbceAr5w4MajU4VLDdP1d9ZR6EXWoXCeWc524DgEnh+4lA4ZOhNyMallomm8in3t/vuMHQl8djsylo9aPZxm3wOQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8284
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

there's still one more patch to apply if we want to remove 
ltp_clone_quick deprecated function. That's "[v2] Remove ltp_clone_quick 
usage from pidns suite". Then we can safely remove libclone library 
which is not used anymore.
There's also one patch which can be useful in the next release and it's 
"[PATCH v2] Support return value in TST_* macros", which add return code 
to some of the most used TST_* macros.

Regards,
Andrea Cervesato

On 4/26/23 11:17, Cyril Hrubis wrote:
> Hi!
> I would like to start with LTP pre-release preparations a bit sooner
> than usuall, since quite a lot of things have accumulated in May, e.g.
> there is a SUSE Labs conference right in the middle of the month.
>
> I would like to start with reviewe of patches that should go in now,
> freeze the git somewhere at the end of the first week of May and aim for
> a release somewhere in the middle of the month. Does that sound Ok to
> everyone?
>
> Either way if you have patches that should land in the upcomming
> release, please point them out now, so that we have a chance to review
> them.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
