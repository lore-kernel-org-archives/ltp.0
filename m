Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C7FC43334
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 09:32:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC91A3C9F31
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 11:32:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EF5A3C9BA4
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 11:31:52 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 061F91400F22
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 11:31:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F65PVWsVdMTIM2U2bgRmCQZKoQEZ7hHmorSjHZDBZXiM8Hcrpco10PXLKwCcYbi+eq00VRe+dEda2nYapNZtPFiKV61swjk9vfXUsz8X/r22Zh4AMq34PLL3qC5UISKFyejoE63eCtZhSz4bc3Prl0QeE9Jtt1Co5fi2YiYupDP84ovh4v29hIkgQRj8evDwfHRNdQR2f+CxSc+mmm+grtHPe77FMx5ta8behPSk5C6zd+moc5I9VNCWgK5+QOeO2eiFeC5pB/ssm8FEtMDXbx2VPsv7+owzyyysvYyguaab1klFTAG/1u8+rwUSGSOPu0PZ6BnXonHJqgSPpEN9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ/7A0iwWnxWyweiFMlkmDk+FYVodvkAgPybOxERG6Y=;
 b=iwYY7UfZnv+zA7xNOGKrgkDx+dIlv2OuDwNpkn4Famz0PFhCVw0OwaHX2SKyU32iqAYBhM6+BCtJGtJClwFq0V39I/rFQ4quoEuQThnschLPHjEYID4O0qlfbgwcpR/wpnveZbrGjnkazcnUeHrQBbmRO4a9roXFwIqH0LsUSo3FOr78Jr2FPxKqVnH3AH0WTJKn6cNn3RhsZZue0GVSBDNiEyNq42fhoe3QSYN12seqp7rkuc5IejaceyeMdmeBDq+fwbwpz5A3MNfIjaxPqXQ5gvF21fTFX+71Fknvo2N0/MU+rotKLH9IThUc4Ojsa29gmN4rq7mi206rsJKiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ/7A0iwWnxWyweiFMlkmDk+FYVodvkAgPybOxERG6Y=;
 b=W5DdvNexSFysYs7Nh6wdxQ630uL4DuOBJ5S7l8VtXLSwwPqYK5Y5qEX7q6Evpcq1r7LdIyOSUiip3SlEkE5i5jUvJrxjQCmfCgDkQi40nq3NdV0DbAeCihiN5PnyXBbKET/1YKaponerOeAQKXoVZfz72nIdl8klvQmwzylMJnsrahAXlc80BtSYfzBwGP2k7iJwafYxXBSMH+YBHj1yKM1U6PA8D/bfT4Cp+RIMCTpUOAUnr9eD7nvqPr5BgRe9v2wplmVczGj4T3903P0Tnu57rnSdIUpMr5Xlhm7xDW/DIE/Kh5Ir8ChoTvTocn8U4lkTKTxE/tSgFCcmVbk6YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB7767.eurprd04.prod.outlook.com (2603:10a6:20b:288::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Fri, 22 Jul
 2022 09:31:50 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%5]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 09:31:50 +0000
Message-ID: <aeddb36f-69db-0fae-cec4-df3956e2e6db@suse.com>
Date: Fri, 22 Jul 2022 11:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
 <20220616140717.23708-2-andrea.cervesato@suse.com> <YqumDWnqP35qT0t0@pevik>
 <YqunUfT847rSDkLY@pevik>
In-Reply-To: <YqunUfT847rSDkLY@pevik>
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1646e587-aa3d-4431-7640-08da6bc50143
X-MS-TrafficTypeDiagnostic: AS8PR04MB7767:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1vHm/0Yd0nb5YkZ+Rl8qSMRL2m+TipGQhhS3LCmP3PQS590ZwNWS5x1ZUbMmgvqAC53Ysl5nxzKC3vwDRg2UfjhAdY/CE6EgluTWasL2a0UEruaeYa9u/Rq1SslSqs2qPiNixv9equJCjhjy3qcs8z3ZC7/Ku87pSqILr8JnFKTPJAKQgKoZqfXtPljE/YQelRo4uywpeaar9TGEEJV8meQt8l2haEpOJjV5Qa7l3KMq8PgHD5HDCDJu57f6tRKSuEG+N77UvzsJi5FIi2ySm1FGBQClYcmQv35pGnsLNdVCuY7Bg2gtwgXZ2zg6Zuve0SiYwczzYpKNC0sPGIO4D7cioPBLJkRg0iDmpRBfjBdVoJjbfV5VPKFjhRHJuv4LteX6oKg5+auAS0eD5omehn7zdl45FMGZ1HPKa7vD9I+ti4Qv5Doq29dT+gOqXZC32zo8xCFNafL0S8cREJm+ncHLyHrqmhFJ5cg5n5ZIwif5hXTUZZIgRxorbcP+2pyzB8wrTUX0zwOcLqirmx/VnqbCowSKHZYce+eRwLap1/UaU9p1Q/MtcHMwRkMmyb+nKtnqf1pb9iy5AzAbiADwoAAaNeATEexa0YwFm9R7ajmnHdpeWTkrKE43+maCllB+Oe05AJxodWeanhXYQ8docv3nTIcfj263QP1vggoFYuLaCMyaV+1xdLwhVEtwoN/MLCsLIH6WuOC6Q41tmZ+4nK3ds9j7W4W2Xj3j8OWE6p56d63gfnzLgjLgKEqgCas2PDzCmUsNb/6/dUkwqCc/0iW3vdVmeCLqteaypBs7rSaCVEtH38oOhCKmUEvrnDtBlSMxORBuE4uFoYKRNtUJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(136003)(346002)(376002)(366004)(396003)(6512007)(26005)(6666004)(4744005)(53546011)(41300700001)(44832011)(186003)(6486002)(6506007)(478600001)(2906002)(38100700002)(8936002)(66946007)(66556008)(5660300002)(8676002)(66476007)(83380400001)(31696002)(31686004)(2616005)(316002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlITDUyMjVkU2ZXQnBCVGhvejVBZHNscjVWUzR2ZnRHbzF6OG0wSmZyMHcx?=
 =?utf-8?B?QzR6c0tqZmlLcG1GaDFUTFpBckhxbUZ1YUFQNGhSeHEwbjFmM21SdHYweGxI?=
 =?utf-8?B?YzBnSFJWZ1N2SVE1ZmhndlRKS2t2Nlp1Vnh2TU56OFNUYkFqZ0xmVGdPL2d6?=
 =?utf-8?B?RWNBRStPUFFJSTAxVk91eVNoYW5URUZhMmZWbWVRcE5OS1RvV1dXb3RTNHlx?=
 =?utf-8?B?eFNpdjVkazc4cUJid25vWVgxMmQzTXRHSFNlYXhqYlZlU3ltdURVTVQxWlF0?=
 =?utf-8?B?d21BL1RNSWM1R2Y3RENCQ0JlSG5EWFVPeUphTzFhQzFtWS9sRndsN2ZiOVZs?=
 =?utf-8?B?VXRJOWI2b0RZSlJ2Mm80b3lRYURkWW96YVh5bGsvb012bG41YlJFZ2U4WEJ2?=
 =?utf-8?B?R200MzhRZ0s1a25lcmt4QWdmT0NVWC8xRG51Qjg2Z1EzaWNYaWtzSXU5NjQ1?=
 =?utf-8?B?NUJ1S2dWbWdqejZDMmNWUDF6OWNqNDRrVVpTUkNzVUlUOGErTGdQYzhhQWpS?=
 =?utf-8?B?b29HQTlyRS92OVpxZWtaUWFZZzM4UEMzK0Zhc01NL04zbGdEYlFpS0VJbUky?=
 =?utf-8?B?TDNGN1RRMEdFUE1qVWlUQkVLUWREZmJ0L051MEd4MFc5VWRsZzhsbHZycldW?=
 =?utf-8?B?c0lMRDh6OUJjSFlVL0VnM2dETlB1UXgrVmczd2U4aVliQm82UjFZbk1hSTdR?=
 =?utf-8?B?NnB4aEgreTVHUkVWcitpdkJGYkE4Nkh2dFFxRWgwbmdHbldrSlFKY2RRWWJC?=
 =?utf-8?B?RlhTenN1aGZyblJQeDBNVTRQUmlTVW5pVHRQZ0tScTEyYTA0dUdUQm9oRk5K?=
 =?utf-8?B?SzV1WloyOGxnbmJHcjV1ZmtSVjgzSk42YmZCb0ROUmt3WjV6NU9tcGsvcUlk?=
 =?utf-8?B?cVluV0s5OTM5ZjF0ZUdxeS9LWTBaSXlNUFdQNGcwc0h4Wi9vZjhXVmU5UzRj?=
 =?utf-8?B?Vld4d2xwbDdoZ2tMcG5TMnpiL1RWZlZXRE1Ta29FQ2JWejYvdTNER1V0bGhB?=
 =?utf-8?B?Nkh4S3pHYXVFOVZORjE2VUZxZ1A4TTdXZnJRY0Evb29LLzI1TXp6dEtBWFhu?=
 =?utf-8?B?ZENFV3Eyc0g4NG1UTzlsRmlLUFMrREN4QzhMMWlSeXNFbUYwWFVPb29oUFJU?=
 =?utf-8?B?Tnd1T0ZjN09PdG5RN2lFaEw1WGVJbEltZ3BIam41YTFhZ2dxQjRERHZzcEUy?=
 =?utf-8?B?dkVkUUhFOTlrR2xSSnkreXhSSTAyV21sQzNMSjA1RCtaMjFidVlRN1huSWxR?=
 =?utf-8?B?RGtIc0UzZ1F3bWJmRVVqNCtDdWppUUhoVkwyQ1JjZkUxQzN1azJEcjY1aTJz?=
 =?utf-8?B?R2g2OEU1RU1adUlKNDdjTGRLd1ZtREpGd0lhL29KTjZVckVXVEFkZW1aaENi?=
 =?utf-8?B?RkZVZWNnYVREWWlrVjdFbEQyM0wzeUxkNzB6c0xJV2pPbkNpSitUUDBKS1Z6?=
 =?utf-8?B?OVJBVTVRSUJCbTROTTAySnFacTRlNkQ4eHRoQWMwZEdVZnRpcWhtZEdKWjE2?=
 =?utf-8?B?ek5vYStXN2hOdTZ6VmJkbDV5NXUyS1NHQVJnbUZGRTF4ZEJmVHpOOUhlRmFy?=
 =?utf-8?B?MFZPVjF3NmFNRHg4TGgyT1ZucGdLT0tidzVWamtucnczbmpxdVpsZTZNVzcy?=
 =?utf-8?B?YjIrUVpjSTNPNDlxbFdmRmhUa3NMVm9ISTQ5ckY5OHY4cTdHdlJlM3dBWHlp?=
 =?utf-8?B?SVNyUVliWUFqekJsanJaNXpYb2F2Q3dKeUk2K285V2tQdUpCakVmWXFqMEk2?=
 =?utf-8?B?Qy9GKzFBNXp1eE1iYVhSVm9WL2VFc2VWT0c0SzNFR2lGVlNHQVI5eEpOMnR5?=
 =?utf-8?B?bE5Ba1dubVFkNWEvRjRYMWU3ZzNKUnkvNUo2bGtaclI0VnM5ejA0dFczOE05?=
 =?utf-8?B?S242Y2Nwa25VRmNza1lMNlNscU5TV0tab0JwZTNSZTFuRDFnbmpMWU4wMEpG?=
 =?utf-8?B?NGh4M0xSbEpTWWcwRlAzMERNa0l4MlQrL3hlL1lPWmV0dUp2ZTdNMDZWNkNa?=
 =?utf-8?B?RXV3TEF0ODdRQ0ROQk1rUXZxZWNlSEZjQjYrZjhkRWRpKzJtR05EdDRUSU5s?=
 =?utf-8?B?QkhuZnRzV2V0MWpEc3ZsQ2ZOVHM3UjZCaWkyNFdjanh4YlFsZWl0VHlDaG1l?=
 =?utf-8?B?dDEyeUNnWVhjalRPTExIWkI4a2k1UGltSHk2QmQ0L24wZThlUWVlbStjZWcx?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1646e587-aa3d-4431-7640-08da6bc50143
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 09:31:50.2773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4lxE6olepA4EbtyLaF5DZS4qlGNbDro9rA9kZ/2ShT1OTjpHm3QZ9jSYOuEQn8fUsPmPOhlufMi4F6ld1yC8OLVFHUdk9+Afor8nq7oCxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7767
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Add more safe macros for mqueue API
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

Hi!

On 6/16/22 23:57, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>>> +static inline int safe_mq_close(const char *file, const int lineno,
>>> +				mqd_t __mqdes)
>>> +{
>>> +	int rval;
>>> +
>>> +	rval = mq_close(__mqdes);
>>> +
>>> +	if (rval == -1) {
>>> +		tst_brk_(file, lineno, TBROK | TERRNO,
>>> +			"mq_close(%d) failed", __mqdes);
>>> +	}
>> How about check for invalid return value?
>> 	} else if (rval < 0) {
>> 		tst_brk_(file, lineno, TBROK | TERRNO,
>> 			"Invalid mq_close(%d) return value %d", __mqdes, rval);
>> 	}
> Also safe_mq_open() could have check for invalid return value.
>
It's already like that, Isn't it?
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
