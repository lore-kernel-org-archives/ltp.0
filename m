Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1687BC4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 11:25:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272603CDC2D
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 12:25:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E5223CD520
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 12:25:34 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5BC48200CEC
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 12:25:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBHM3jaq2O0HAB4uYjGCDHHY56ym0U8Ofj4shj83BmmCMbQcZ5T7nPt+a+ePUCChfE9sTiWNeUodwgv9EYeLie5gui/nwwUCaj8CNRLmApU2TMRqC7GxnzvfSpT2mj6BM978daxjzqbGG/BQlONq2by2N3TGH1vwEVxRHgGiOcMJY1V8AKSJtmUp3M4cYNmrZrnQ1l5kXc9d54ndnifsYGKaLi3gh6vAqO/58eXVwXnRD0nU8JLUoVKWpnV/JZYaWR8LpovlWnC6pzN+0shMtbX4mPtvQ4SshSg69ucf/n1uXoikDSqJYZ7aCFcKxqF9A+RRjagRBTcWlUbGlw2UAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nB4HkdQTTFyS1Mq8h5olYQFKkpZNmCUV4Lk3zvLwbOE=;
 b=h11zk/LFWT+sDEeltvHvnCsMPyjCR9teZA8yhHG+EfRu4xStyyZy58OWlhOXsmyvaSHv6AxyyXoNFZtXAetZ53/MLJjkAS1F10CWNgczGAlaTco2LsqKZ3f9OS/J1VFEDI08jwF95e8CX4Mfh/au7uRNvShh1sU9bAxMbiW1fIwdxuyCM1GVt8n9k+BqRgPce/+O9EbOypqfF6jc0sI72fonDQk0nLkFb7aL6auwuYl8AYYQ6uV3ciJosKelbKIw7Efjoex7xSEAabRVJ9241bRWuzJB7qaMJNp3po2oTZmCcHfDqm6st2xpEqozrrA9x6Z9F3hJbsKzoZtu5yDF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB4HkdQTTFyS1Mq8h5olYQFKkpZNmCUV4Lk3zvLwbOE=;
 b=b1RM5TspQeabOxwkGxGIQNGCcgpXLkucTpDMSjgC+17MDZTIZitQazFYFVw9Fy3svOLAz68Lv6Beg+3S1dBQH2MEdjCXDwquezvcScqXFU/44ykFWUrDiOR24m0QmYm/3SI91NLWONlsF6ND45KkMPGT8RWGfp5cHFIjvRR6Ib7nPs7+ijnOEvQQnu1vhz5LD4bZLQDxCD5W2TI0BxxmngKKSjyknajnMwXaZNFhzdjKYbuRVemHAjfxrZ+WuCgmBSDypDtx59JqcjpCSBmf6A9qJGB59ot4F0R/CdkimbdCvNKQwnf+kCmZjoxAC9FGq1qVq83ZCz9tu9vRQUJlMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.16; Fri, 1 Dec
 2023 11:25:31 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c%5]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 11:25:31 +0000
Message-ID: <29d08b1d-13c7-4236-a2d5-0d7d1a0ea942@suse.com>
Date: Fri, 1 Dec 2023 12:25:29 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-ClientProxiedBy: VE1PR08CA0021.eurprd08.prod.outlook.com
 (2603:10a6:803:104::34) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f23e2dc-f539-4ac4-23aa-08dbf2603a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdYAmBoih3yUaBgEtv918oL3kzUHwY3EIAM0CvrBzIYNsb7vA/npZzCumr+UX2vPMTPOGpOYTLMGkE3arnIYmjYf9nIx/lp2jN97FSQ+KqgqOSUB4m65hV0FG4is0nBYFTNn/KWMc96Z8Qzw6+ZzcZUV3/xbVCZG9uyUZVpcXDdof62Z7WqKgP6AdEB0huwW21BvfVZLvrvC435PsJahut1/6cYwf/sc4j1qNuU3Har4dfwH4rWN1eWiQ1neMc+7GR9xvlFZk1Y2jYJ7WY4zRhmM3AmteM11tq8RTzmuI0Gc/MTl2lWjqaTqKxcbBGnIlq7NIgcc8RIxo6n4TTFeHf0erJ2jzKraZ9QATIaFE9vG84eDyL7jq5iSVDbBsk7+ABy1PfXXTjjTQgk8aBISXHmUgLbH6LNFKgC3R6DskA/JuOiuw36H7p0CzvYQcXyByJbiffoPQh+3IEW/8ndNWilCvbqMVlSvqkk+sURZjaXP9Y/oPpnYxMV4q587+N44wmS+hFCzeAyEVzf5W/78ob1u38TF2+WB9G7iYGT6O2HJjJFAYSgzfGUP14mmYwDzv9nLG1KzV8b9CaunMb4b+GUIRMn7VcYhxmoQVTPsR9NzuQaB2s8B0ChFaD49Sc7rkcAuBZdgGPPMAlGtQS9Fhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66476007)(66556008)(316002)(558084003)(86362001)(6512007)(66946007)(41300700001)(2906002)(5660300002)(31686004)(38100700002)(6916009)(83380400001)(44832011)(31696002)(26005)(966005)(6486002)(2616005)(508600001)(36756003)(6506007)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHFHMUlURUVSNU1yeXB1ZkNmaHQzZi9UZ1FwZlZpS29YcjZqRUhiUnp3aUFw?=
 =?utf-8?B?cHRuTk9HTjNINXJ3dEp0Z0tWQWgyL2kwNWVNSDFvZzQwUmJXaXBhaFRSWUZ3?=
 =?utf-8?B?cVU3ZEFKNGFwMEgzaG5PTUZyZ0tsWE14UUJ1TnBXalBzK2w3alpzeWFsdDFQ?=
 =?utf-8?B?UG0vTnovbFIyeTkyVWZWRzhISURILzQ4NWZRMzg1L1JWY3QrNWV3STgyRmNv?=
 =?utf-8?B?UGJXRjVqdG5CZnh1UXlydHJjOW5rS3FwWHlGWmw2RXluRzE3anZYTVprL2VD?=
 =?utf-8?B?RW9GaTZldVI4OXBKaU1CV3h6MlFwclg4eGEyeGxkSGdlVzI4V2g0ajU2YStl?=
 =?utf-8?B?eTRCWWk2cUlET2k3WEZ4TUdxMjhWa3c0VVdCVC8vY3pyK1RKMThtaGxzK25G?=
 =?utf-8?B?b1YxVlZCcGdjQ0UzUTZTVE9BQXhoNDVIeDdlT2w1SE9DdDZPRzhIVnNQMTVu?=
 =?utf-8?B?SURvVllTT2lWQXNicktsdnEvUDdSbTV2cUE5VUR3YjNWNGd6d25VVG5jV1hp?=
 =?utf-8?B?TitWWmM4cGJ6VzUrTmM5a0hLRDR0MC9EMVd6ckV0MjU3N05kTFlydWdVV1JG?=
 =?utf-8?B?MnpSWTVyekhvc05LQ0lnUENoMmZTZWZsT2VpT1oySE5Ud2tOTXpjQU1OU3lE?=
 =?utf-8?B?Nzd3bE5uZGl5ZCsrSmpaNGlmekZmNTlOc2h2ZjgrV0daemd0eHRGQktMMzBW?=
 =?utf-8?B?TVo5ZkliMkY4L1FHbGdlN0pjVVIrZmF5NmtyYm9NTFF4S1R2OGlUVjI2emlG?=
 =?utf-8?B?ZHRSZkdrZ0p6Z0dBc0dMTUJoankydE5lR1hpUXgwNFRSUnV4VUhHZWFoOEk1?=
 =?utf-8?B?UTNTUEZWNW5EMkFxWXIrUk1sR3A0UHoxT1FWVk43dUVyZnNNOUhlSi8yMU84?=
 =?utf-8?B?cUVDNjJLYlJhaWdLcW14bDA1ZnM0NzBxRFBXekVVMjFHZ3ZBMnZZUmxUdnlG?=
 =?utf-8?B?NUtnZVByZFVTWTVRU3A3dXdGYXlqd1pUY0g0TXpuV285Rlh6ak5CRjNaZm52?=
 =?utf-8?B?cnN4REZKNXJwblZrWkpXcHpvZXlPNnpkOGxNcmo4ZHBRckVMdzc5cytZN21F?=
 =?utf-8?B?Y05mS2dqdHpBMGt0Znc2VmRYd3ZBTUo5bzVuRURlSTRKNW5pUEtSc3pTVnJH?=
 =?utf-8?B?SWlWR1ZxRVM0dnd4Y3V5NnMrZnkrMzBCbW5lZG0wUjFSSVZjQVh1blAxZUdS?=
 =?utf-8?B?N1RCR042ZXYrbFp2cUZ5ZVc3NUpIYzFNWVdEUitRM1NPWUh2K0ZrUlVma0hr?=
 =?utf-8?B?STFoVVhoUEFPQW56Q0NhUjVLL25oRG96WnZ4cms3Rkl5RnNMb0pJRlgxTEVW?=
 =?utf-8?B?bmhIcnpKUGkvbHNnR2hOay9wZzd5WUxndnJVcXEyUnFTTG5waEVxaFVHUHEy?=
 =?utf-8?B?SGtIV1h3WVkxOC84NFpOcktFSzI3TlAvMEtWUDg5RStydzVoOXBVUm5GWHlD?=
 =?utf-8?B?VUJyTy9BL0lRRit2cXQwOGRIQTcvZUViaVlyV215M0tCc3dSQzQ3ckhhMGtP?=
 =?utf-8?B?cFlreG0yd1J6Y0tIeWE4NExQaU5VL01qU3NMVjhEU09pamRPcWl5ZUVIK3lD?=
 =?utf-8?B?eDViMlBvdVpvUkFhYzBDT1pUeGVFZVNzdjVSc1JwVm1DR3ZOODU3UEkvRWFz?=
 =?utf-8?B?OWxkZGV6MFdqU29RcmQ4Z2NOVjhMcWdkaFE5U0dlaHBLK0hGMzVkSW9ab0pT?=
 =?utf-8?B?NUV2M3NkVTYwYUh3S25nMVNLQ2RYdDlkUVliU05lckdLZk8yOTlYNU15SGdk?=
 =?utf-8?B?NEhaZ0NMWnovelJQR01RMnVoUzE2UWVtRGdSMmxIK2JiV2owcU9JOGN6SkNW?=
 =?utf-8?B?N1h2ZjlsL05UV2FoRng4MEZEUFFSampEVTlJVzhHWE5TdFdvN1VrcDJBNy9O?=
 =?utf-8?B?VkhVV3BXVjV6TVBqMTNhemtFREFCZ041aGZkSFJIR3YzdGNuNStzb2tnc2Rh?=
 =?utf-8?B?Y0pERVJ2UE1lNGlmV0tiV0Z1RzhFeDdhWUFtS3pPSStMVk9Ddkw1Qy9XcUYr?=
 =?utf-8?B?YWdsWFFLV3BMUnNHMnBqOGptcVM3S1Q4SmlQclJWczIrSVdYVkdGdWt3RnFD?=
 =?utf-8?B?Q1pkQSsrVWFZSnFxZjFYSGlZUHZCWnRGRDBKL2luNUZNWlFLWnFCK1pKT3k3?=
 =?utf-8?B?SUxQSEZ0NXZFQm5yUWlINVQzaGhqS1ZZOUdHMnJYTnBYbkxYK2Nxb0Zjazg2?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f23e2dc-f539-4ac4-23aa-08dbf2603a89
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 11:25:31.7401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufOMfScVANvSg+xOM8YgOouNj3OEIa/zCYB58+/KB7SQn4hzmiBTrBelu8G3Ft7HXhvVu1NSvVlZGBWyLJSnawrJZoLZYmafHOykCiPnFTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open monthly meeting 6th of November 09:00 UTC
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

Hello,

this is a friendly reminder for the LTP mailing list about monthly meeting.
As previously discussed.

Time and date: First Wednesday each month at 09:00 UTC.
Platform: https://meet.jit.si/linux-test-project

Next meeting will be on the 6th of November 09:00 UTC.

Thank you,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
