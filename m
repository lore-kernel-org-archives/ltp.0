Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED85C27C5E
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 12:34:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 431DF3D0B60
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 14:34:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 140413C2FAF
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 14:34:19 +0200 (CEST)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01acsn20806.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::806])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 398911A0146B
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 14:34:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5JE7HLFmTo9uGWy2u2/JtMJ6vXPKN0wKWYHR0wIGLXgV6jzDK1VQ/pEn55Rps6jVvWFZNPe7YCUBJhO8mJtSceoiHL3bLEkPtt277UogPNC590fcA/Wi8hRMp66KdkAyIN38Fxx01au6+smp0LfSzMwH0RREIIkxagNKCn8hXCuvMMH33pGsQ6GH9A9Sjd050v7yjeVubdX8GLFDOGcdqMiSq/b43iho7WdTzJDdQdjPfFgcDHh89Sq5gHiAZUsobChAK4zDsnu34sd8KRzIeEreJ5W4imTaiNwJRqVuivclE3x6DWbmQr1rAILrrPMv8SNzT4Mh0RdWsKQ62IYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p3Rr2MQp9QswCarAP0KgSBiM78EOPjSxDCQ6j1c5PY=;
 b=dDM+QL0ULK3mpRHhMFI8bEj4YBOim83yTzmv4RPgB9nueRy9Aw5UMxsQjTAdMChyXNQEOONEpCCJ1pA1LA26y0P9BHn6cvNPVizapn5tda6GbCtOiyL0F1LQreeHjCBJ6dmY9ABuPyLQbVKMfbVWRAvreN1GKGe/Qjewwb3llGdhJV+nDb7MkI/f7UaKHNff7NxE9NlALejmICFoUxdSMq7eX5+E8B0WvY54xo8RUddxP95Cgf9giemqLVUQrx6EGyesVdOpFdhFT3XPWXUx6mZ04ohi7c7J+A1EK4eZrqqUcAAlZvhhvggeV+rxM5JDyj9MsAJjEPMalnJi/0Zt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p3Rr2MQp9QswCarAP0KgSBiM78EOPjSxDCQ6j1c5PY=;
 b=biUP4kDXAO6lYCP4VKHr6QNDpVRiyIjTaqg5rUA5xno7RDSd6O5IdBR2R/X77nJeop3IyW4BZbgAjDZE/o1y+VykGwK1ppqOaeG19HiEF6idPwwOF9k6MpbVJg551ciQkLqZptVN5RlcNn+W/5pt/+BlxW5k+zPHd5ePCzufuc8xld7NE0UHTrYWi7rqoOeINV/a7u/Wmkiddh+8wmNQ/TBWiBzsL4S9QZDU8OTBMTXVSjb4hrqLOB0CoDLox/l3eRwYI6D/L3+kb/c6QyiXXeRqYYsCU6ymBRjpJCODHEojimvtIqvjoTEq/tGKWSALbUTIJBxItzdKbkZPGKbiaw==
Received: from TYZPR01MB4529.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1fa::5) by SEYPR01MB4973.apcprd01.prod.exchangelabs.com
 (2603:1096:101:ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 12:34:13 +0000
Received: from TYZPR01MB4529.apcprd01.prod.exchangelabs.com
 ([fe80::184d:c04:108e:c82]) by TYZPR01MB4529.apcprd01.prod.exchangelabs.com
 ([fe80::184d:c04:108e:c82%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 12:34:12 +0000
Message-ID: <TYZPR01MB4529CB2B31EEDE260583CAE1A8C72@TYZPR01MB4529.apcprd01.prod.exchangelabs.com>
Date: Tue, 11 Jun 2024 20:34:06 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <SEZPR01MB452774E4131F00D0D2C0CE60A8C72@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
 <Zmg-7snwjqRFWv4K@yuki>
From: Jiwei Sun <sunjw10@outlook.com>
In-Reply-To: <Zmg-7snwjqRFWv4K@yuki>
X-TMN: [Pr8nmHxzqTdEAOV9PgpUBf2XGLwFMvg8]
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To TYZPR01MB4529.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1fa::5)
X-Microsoft-Original-Message-ID: <a4c9186f-17ba-4893-9557-9a7f72016aa7@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB4529:EE_|SEYPR01MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7ed36c-f997-4f62-9373-08dc8a12cc18
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199019|1602099003|440099019|3412199016|3430499023|3420499023; 
X-Microsoft-Antispam-Message-Info: gTW9VG4uRTl5FiQ7CylKS6OQYuO6+6R6POFJtGN9C3b9q6gpoaQ5dGm1JRg2rEMw93/pUAG2NPqWDP9EsJTs85xXoNsbxiwpKmNmfi+a8DQA4mODq3DRKfMTETFrRByguQN8bUqf0BtbLTHcAtDM4UyYvKXKyToJj6RFCKjfpSm1eQzBLjTL9leqfh3WKNDVFXl+LCCejqRtJl91928vIdC2UZYp+vyKeplDPmVJgkOFo+7QrOPaLt+Sc3Kli/PSPzWPXhPhEcWebI80If8a2WmhjYQJHWxd7ApUnVQDQn2cf+I73hFZYA03nzjgXy/tiubfqRFOxeBX7vyXLQ68wVJE53Odi7KeFiju14HL8pNkkWwSZfMM8GQtI3JXivqnWWxnS2zvuNSDY8W9rK+Fay3FpseIlXmH5rZ1uCUkFYx3mn6kD9Cj1GlwWwGLtv7x2bMknr6G1hS4TXEuumH1Xu08eAhs0nnL96cx3X3ESHYT7AK6IJZg15vpWnxfgfMSdWNeJfKJG10W8LBsny2LXPKSARBLe+hkD+KucRqtYPcGusmZ4ivhQXq+VBkhQHoWQ5WzfNmDx5yi4HE+pyYcasBE9GYPMEac/18HR8z3ySg01sxK2ZcM7hq0VUsSiYSb1XaiKLkkjNSSLzcSVQUbqJZcQXlFjkcMCV6XugPlfvY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdubms0UkxUMFArcWxPUExsems2SlE2RGFjZU92bzI2NkxuVjcrcDFNRFk0?=
 =?utf-8?B?MXU4Umtza0MzaUVpUEs5WXovam1FSzdkb1ZyOHoyVzVic0U4bzdZcTFLUTFO?=
 =?utf-8?B?Q3ZBaWpHemxDU2RhRVQ4RlRWYzNSNUtPbVE1WDFxRGJxajB4TVRsSWNpMjRP?=
 =?utf-8?B?YXR4K3EyY3RUVi95WkpYOHJLWjdnS0Q0SS9SZk9wYlJ0VnZ2RncwRWxucnRI?=
 =?utf-8?B?dk9ETis0T2lFQlpObytRaWx5Z3djMEdEQjhqK3Z3VTVHRVZYai8yZVVjMGZM?=
 =?utf-8?B?OEljVzUwVUlCZmlpR3JBQUhtblA5SVlOSGhsem5heDBmdjVoNE5sYzVaLzVo?=
 =?utf-8?B?M3pxdkk1V2I2TWtVbkp4OWQ5aTBrQ1Q0TWZLaDJiUFlTRmhFY2F1UlhLcUdC?=
 =?utf-8?B?dlBKdVR0WHlvZVhmWkt3WStiQW9tcmx4R3Q0UmVqa3lWS2NLVms4VVpiOVBo?=
 =?utf-8?B?a3JWVytDTFY5VXJaYm5UUC9tKzFGNUpjUCt4blN5YVRldi9nMXByb0g1L1dq?=
 =?utf-8?B?dStLbVdDQ2lMZHpFcjdUWjQ4eU5kU0pyZnB1dUFCcEp2dVZYVlhzeHJ0SWZF?=
 =?utf-8?B?RjV1RDJKcU1kL0dpZXkyWVVMdGdoVlQvV2Urb0tXMlFaekNmeWhHdGtjbWR1?=
 =?utf-8?B?NlpYYWVzb2wwVjEwTXdNUldhV09LOExiZ0dDcDNPVU95ZTFuV3lRQ1czdXZW?=
 =?utf-8?B?R015VEplNVFTV2VrY2hxWVgzTUJvOEtGMWF1V0MrVURPODVYYytFSnAxRFZi?=
 =?utf-8?B?VmV4M25IenlKV2YyK1Nad0xZV05uZGVMeXZWdDlEV0h5SjVoZVVVVjRUN2Fm?=
 =?utf-8?B?Q0xtR29scm4yQStEUVNhR2dhV3hTN0lxa09Ua0tocUQyV1VNR1NpNWYwVlJC?=
 =?utf-8?B?Z0V6L0tlaHZOMUFlL1llS09IKzYyNkovNzhzTXl1S1FISHVITHNVcjk5N3NL?=
 =?utf-8?B?OU5TNEtqK2xhVENnMFlFbjdwY1ZwdHc0ajR1bVdRSlJvREYwTGhyWjBESWYx?=
 =?utf-8?B?NHRVdE5pUEQxUG4xVEVDb2UvcHl5TndsbUI3MGF2TUdBNFBhOHBpQ0t5S1pl?=
 =?utf-8?B?by9ycFVEZyt5S05ibzZoTWdKZ2VUZ1lrTklHYVVvZGU3cSt2aXhSdk5sOG5F?=
 =?utf-8?B?MHRnc1Mvd295Q3YvbFpXSlZtYk1oYm45a21ONldTY1RXRWVOdkY0WVVQTmJi?=
 =?utf-8?B?Y3R6aHdQVXJLbmxYMHd0dXNKOXpUcHRjRGFJU3dKdWpqKytkSEZhT1I4RUJU?=
 =?utf-8?B?R1IzSTJ4aUs5WjZHL2c2aW5HQ1ZFMkFheFY4eGU4a3ZkME5lVDhSY2xZL2E0?=
 =?utf-8?B?MHRyWUxCb0hDUXovd2ZzdHVPMXhLeS90Z05tZ1k3cFloMmcxSWZKeUp1UHNS?=
 =?utf-8?B?cGFTOE11NUFuWk5vTWk4V2tHV1U5OEJzU0ZveE9Nb0lxTEFRVEJSVE5aa3Qz?=
 =?utf-8?B?aHhnaGFvbEV4Y0FYVVRZaEFWU3RrUm1udU9UdzBKSG5uTmJpSlpvYjZtSmVX?=
 =?utf-8?B?ejRTQmFpem13Ulp5QXhrbHh5TXY3cWFka3BkZVNvZklia2NwLzhHK1ZvOVcy?=
 =?utf-8?B?dlNGc2hvRitnTkFJWTVHemVIc1owd05OMzB5TVUxVUNTZE95dTBaY2pOTVJh?=
 =?utf-8?Q?ziasVvriL1ciBz4w6IyvflcvyRO3uLuUUmB6A6sNAEdY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7ed36c-f997-4f62-9373-08dc8a12cc18
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4529.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 12:34:12.5109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4973
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] genload: fix memory corruption in hogvm
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
Cc: ahuang12@lenovo.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 6/11/24 20:11, Cyril Hrubis wrote:
> Hi!
>> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
>> ---
>>  tools/genload/genload.c | 2 +-
>>  tools/genload/stress.c  | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/genload/genload.c b/tools/genload/genload.c
>> index 7f56d5272..9712e7828 100644
>> --- a/tools/genload/genload.c
>> +++ b/tools/genload/genload.c
>> @@ -642,7 +642,7 @@ int hogvm(long long forks, long long chunks, long long bytes)
>>  			usleep(backoff);
>>  
>>  			while (1) {
>> -				ptr = (char **)malloc(chunks * 2);
>> +				ptr = (char **)malloc(chunks * 2 * sizeof(char *));
> 
> Good catch, however shouldn't this be just chunks * sizeof(char*) ?

Yes indeed, totally agree with you, "* 2" is redundant, 
thanks for your review and reply. And also, if the chunks is 0, 
the memory will be corrupted too. I will modify it in the v2 patch.

Thanks,
Regards,
Jiwei

> 
>>  				for (j = 0; chunks == 0 || j < chunks; j++) {
>>  					if ((ptr[j] =
>>  					     (char *)malloc(bytes *
>> diff --git a/tools/genload/stress.c b/tools/genload/stress.c
>> index 7f56d5272..9712e7828 100644
>> --- a/tools/genload/stress.c
>> +++ b/tools/genload/stress.c
>> @@ -642,7 +642,7 @@ int hogvm(long long forks, long long chunks, long long bytes)
>>  			usleep(backoff);
>>  
>>  			while (1) {
>> -				ptr = (char **)malloc(chunks * 2);
>> +				ptr = (char **)malloc(chunks * 2 * sizeof(char *));
> 
> Here as well.
> 
>>  				for (j = 0; chunks == 0 || j < chunks; j++) {
>>  					if ((ptr[j] =
>>  					     (char *)malloc(bytes *
>> -- 
>> 2.27.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
