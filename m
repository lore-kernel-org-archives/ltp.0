Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8DDEB8FAD
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 09:47:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D608B3CEA03
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 11:47:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDD233CB740
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 11:47:13 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6A47810011DA
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 11:47:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az+YvLF2gX+k+cnDHg5VsTImcxskRQobFyD/2shkIHqMzcMQB+mJRz+/BB5Y7+l1j0Bicp/m/FiMAmTa3JQPfio+P3xXx8QPHwGryz3KILLTW7qTTCOEu030QWNaKTdE/mxFgjz0+bi9gQbqG/GkQ7PJrexCbwpmi2GA9/2+ixqrX4XIP/ciYsspLly9feQq/g4oqEfCZWQHjp08vQDjCKJAGQBsrZ6NID4C0ASuDrlCYKP68m1EoSth3pBS6+O1m8GWEczp48wH+idhRaKrdVELysU6Dl49Ga1P3A32sntSWcW8krrqddlZhStbMfDRTpP7el+4Sf/h8H1pgVnmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJnz/xpg5IHoU2iAs1LEhSc41NGaB2nEJNYoa6qQgQo=;
 b=BfL0XqnkpeK+prKOwHZGcnBEViX8i28iFJXM9+dz9JqkR8gwSzD7PJMmWu5hmURZ7VS38hVOECG91hMn3xd+PznbPbejlEy0NfD4N76CCSQLhVlcsgxmWCSd3+M+fW4udv2Q4lB8zF61dpgS70rONQxBCDylzoYltByeDkwwiAu/iTI9EGproSldekUzyI1/wiAxOHwK+jMO7OCa4gGcH/H42Dkl73qWqFsplynLp4Kjr0a0Oszc8/yAccJQFNWW+dY9hIz1voz0PcIQ+UALJTgGaXxiEdRgZfighzkYQnc58jnx+88bKqp3l4i9OrSOAgD6dzFxcHticNYryOI2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJnz/xpg5IHoU2iAs1LEhSc41NGaB2nEJNYoa6qQgQo=;
 b=XTa8uK/AvVwyWI9lAZMREKKSZfEAvQfQrQ8/XCbX0jQHweUKuGFylZmjHUdul2Mm3FVMMb0bqFsHioXufURiSWdB0qu5Xnr7rGZeM9mWeVSPm3nsBd2kV23d/lViSvCkm+hNvDMz6AVgsQHaUoKiY11AJT2O1ODQPI3HLVx1g6I5xV6VXHFpRd9sd82wYHyzLgxd/0VlwnDw9Kls0KmioUWgfL3y+Gfop7Gi5zpiI7yxEp1C0qW2d9nec6V9NUzWcMt3ygAos6g47FNBO+yj6lnVGc2jmhpC90qxixmx/WRfxIMQizSVtOTj7p1CKyFEhoQ8qLZywQY61ruqCTYwyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Wed, 6 Sep
 2023 09:47:07 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 09:47:07 +0000
Message-ID: <8ebe4638-fda2-43f0-98d6-8d49b9b5a1b5@suse.com>
Date: Wed, 6 Sep 2023 11:47:05 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: ffac54b1-f6ba-450e-d608-08dbaebe3bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F15b3M7QyleGeV5xf5PVLzYwg4CgkUYMDatzn43/0/Vg/+xlUnvq1DK7qfkcekdz+a6Y9H/CobQ8L4ioGsTTA9qz/OCD22QztpFCqlt+RUe7x6I3GGBbCss0pQbMFSUVMoNxxZZZ4J7j4yc3sGWJ1SFK8jYaBNhwnUIrhon0i8ClbWs6oo/fQT8KxNWAat80eIcnLvDTMuKOyZq7boi7U20l2qdv0FCTC3WX2MoACdIzCdnYXtVWcqaZDHP/GxSMH3ge2qcyf7uECxb0iijheeiBrV3S3NC45CGCOZIkKJqvycyKZxfH2IFLVqchfPvHuw8g0hptZtXZEsbnjT7V1hUBqse/hixOzzWnAPsOK3jBQx1eWZgFibyMBWMNbUOOApB5qWtqqz2qbYNRr8qTmSaEMs7hpbvTQvnvan5xZRUW9UNsCyHuPz0noKIm3ZRcQKJYdvl/WvGtrtR7UCLJkmeB1gTrcDkWyErL9WTvQb3ngvIaoeu/Y2xeMT+PnMoB8sfND8Gu451FGq95OCHrx4OP4zJxd75eg3SOMazGtr4MNwcQE4k09mhVyXB9RjKc8GE4I1p33QRaPjiulc2lFuvThujCwQI7kh31Ow9HYbz+fo6Rb5YHYqi3C4Rfx7ZcBGOQEwSPrEsN9xbldA92wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(26005)(86362001)(31696002)(83380400001)(478600001)(966005)(2616005)(6506007)(6486002)(3480700007)(6512007)(66946007)(66476007)(316002)(6916009)(2906002)(66556008)(36756003)(8676002)(8936002)(5660300002)(31686004)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnI3TXNUM3BockltYnJRODhaU3hOdDlyTU15SWEzWEdkTHRFa1RkQWkrd0dU?=
 =?utf-8?B?UG8rY1ZWbzZKQW1JMXYvekxWUEZveXRsTEJzWCtVMEdwV09lbVAvcFBsL3hm?=
 =?utf-8?B?UEFqRmU0cFZNM1VoZmZSRVNUZ3BYcW5KVTgvTGNMbG8yaWduZmNzYlE0QnQ1?=
 =?utf-8?B?RTNOYU1yeTNNc2N0OTZ1T1VLcXRjeUtQZ3ZOMGN1REJVaThtRm5BQi9ISW1O?=
 =?utf-8?B?MjlrRjE0bnQrcHg1eDNtb25yQU4zN2gwdVJrWlo5b2I2YThrN2loL1ZHMDhG?=
 =?utf-8?B?RDkyUjVNN1JPUW1vUW5TcTBTLzdURlhBckpzRzdwUEJMM1lVV1F0K2RXaXZ1?=
 =?utf-8?B?dmYzQVNVdlVkLzZJU2tVQVZQS1U3N1lZbUFmbEJoaGlDcVlZVEhNMzZBVUZX?=
 =?utf-8?B?ZWQzOGlLMCtKUE5ta0puL1BIeFVqT1lXanVBSWdMeTFJMDNhZ3U0L1RPaGU4?=
 =?utf-8?B?eTBtN1JmL001akRtTmYwOGU5b3Y1RGMzZEVPQm5NOFZUZDB5RXY5VlREQUM3?=
 =?utf-8?B?Z2l2MGFNNzczYXh5NXBzVHVMT0xxZXlDTi8xdFdFSW1yT2RWcWFEd2habEhM?=
 =?utf-8?B?Q3JaZE1sWE5FNE5LU0xGZDNxWDcxb3hub2cvVjN4SWFiYlgrZ2tKN0FTb1Z4?=
 =?utf-8?B?V2E0c2RwMWRJVkwzUzJkbENLRUc5bHp4bDNKZTEzSXlReFF1WWJHcExGZHAx?=
 =?utf-8?B?MFZBZkdVbjdiRWMyK0hxZkxpTDNibnk5YUZyT1JFR0VrV05BM0ZSZGttYWh0?=
 =?utf-8?B?UWRTL0xBRFNwM0NXNStsdUV0L2FpMUxvcEhYMUh3OEhJTWowMEpyQlI0YWw5?=
 =?utf-8?B?bWNScGU4UWxac2NRSEZXQmthT3NTNjl4aHAraVdxL3BTYUsvV1prWG1sWks5?=
 =?utf-8?B?N1pyYWNEaHVJMzUyMGt6MWw4am9RbmhLVUxxamhTMDVtTG1pd1FsVFBNZy8z?=
 =?utf-8?B?NFgvd1ZZRHhEeXJidjlZa09aaFNwczFLTVJucHZSdHVHTFNuaGRXQkhTVjZv?=
 =?utf-8?B?d1NiT1lEUjMxWjAvL093bmljTjNkSFU2OHlEcmVIcSt5MnpNRUxtM0VjY0k2?=
 =?utf-8?B?WkFubVpEU2JOZHdYUUdZNVBxWEl4eWcrcmFWNXFqT1hWS0tOSldCTWc2TW4z?=
 =?utf-8?B?aXFoUTlXYmcvYis1dVBzQ3R4SnR4ZCtlZHltc3Q1ZytOMEpuTTF1Yyt6QmhG?=
 =?utf-8?B?QXN4OFNVK3dWTTI3MElYMUlnVFRXczB4dlAyVTNpdVRGM1VLTWwxN1BNV1hL?=
 =?utf-8?B?ZzI1OFpiMFk3UkRBczZpbi9SaUFpVlV1UUdtbHVCbVhrdFk5alNmb29RMUpT?=
 =?utf-8?B?M1ltMExPM0xyb0l3ZWdqQ2h5TTlkZERyd1BiNU1oNEJGZ0MwU0hXUTFYL0tm?=
 =?utf-8?B?YWVKbnJsQko5NEdWRkpxd2haYklhTnhScjdiMWZWcEVjNEhwNTh2ZVlNZCtH?=
 =?utf-8?B?OXcraW5WS0dFeGZ4WTl1ME5uaGM2N21BK1B1d2pQYURFS1A2NkN4aXlwQnhG?=
 =?utf-8?B?ZWZuUUNCb1lWVHJZc2c5ZS9WVERZd2grQmRaTG5jWjdKaEY4eUJpZXR6RnhL?=
 =?utf-8?B?YzBzdXl0YmdYSHJDNCt0SnJkMjdLbFhYSU9NZy9kRHA5N2NQTFF4bGRhY1Nw?=
 =?utf-8?B?Tm52ZjV0dE50TG5PVHhQbm5DcE5VRGxIRnpIdnZ3VC9acThvSFJmeFNXV240?=
 =?utf-8?B?Ri94bkoyUlVlbWJ3dXcvZ2VFbFc3TlJwSlovZ0FKdWlnNTVaMTlEajJRejli?=
 =?utf-8?B?YzFkL3c1SFI2RlphZER3UkNodzBtcVZVM2p6QmwyaHIrRTg1NStXTVBObE9G?=
 =?utf-8?B?TjdzRUYrMU5uQlR4S0NZMGhjb3Y1SVdJang2OHk5R3BTbk9ENFlTKzE3RnJU?=
 =?utf-8?B?UjdTakIrVWk2clhGcFNXdDNaSm9rNERKalN4cmxNdFF3RndPSnl3alhoUDBx?=
 =?utf-8?B?RWN0VXRnRktrTlNaWUk2MFNIWFV5YlpCSzFVWXN2b29rTU5ZZXZXSUdhSnZS?=
 =?utf-8?B?NUE5KzVReG8xWTBjKzRRSjlUdWMySnNQbjB3SzlDTC9mMitoUXdqdnBSVzdS?=
 =?utf-8?B?RzliMHJIMmcvS3k1RlBtbk1Sbks4S1RrbXgvdmc2QXNvMEdlVHlUV2J3T1or?=
 =?utf-8?B?RTl0UWRPcEZrVkJjTE9abC94V3R5OHZvNWRwb0haQ3Q0eFFnUkxsazJuVmo1?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffac54b1-f6ba-450e-d608-08dbaebe3bdd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:47:07.6730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9clwnD8SOQ89RewWgEPmF/El65nAnkZg9QKRJZbl9BO3BjEo2UBpYEvGEpunf+gp/GznRFTZ2/7Yrv+v7LZPt/NUxST053umobDtzndJe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Replacing runltp-ng with kirk
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

Hello everyone,

in the past months I've been involved into a new version of runltp-ng. 
This new version has been completely rewritten using asyncio, providing 
the possibility to execute tests in parallel, as well as keeping the 
code base more stable and easier to maintain.

After this first stage, I recognized that runltp-ng could have been 
extended not only to LTP, but to all the other Linux testing frameworks 
available nowadays, since the code base was solid enough to be 
abstracted and used to run other binaries/scripts inside Qemu/SSH/LTX 
sessions.

I integrated a new plugins system into runltp-ng, giving the possibility 
to implement a Framework class, which is dynamically loaded at runtime 
and it provides a layer between SUT and new testing frameworks.

As you might guess, project started to diverge from the original runltp. 
For this reason, the new project has now a new name: kirk. Its code can 
be found here: https://github.com/acerv/kirk
First supported frameworks are kselftests, liburing and, of course, LTP 
(that is our default framework).

The idea, now, is to replace runltp-ng, since it's not maintained 
anymore, and replace it with kirk in the LTP official release.

Do you have any question, suggestion, idea? Your feedback is really 
important for the community, so don't hesitate to ask :-)


Best regards,
Andrea Cervesato

Kernel QE Engineer, SUSE software Solutions GmbH


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
