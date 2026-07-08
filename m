Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD21EC43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783506253; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ZT3dn0lSMMFEVIi5gBMhOSZt951Q1QPkk2wr4brW+/4=;
 b=UBCq61//6XyIhmnkz5qJQSZNNJzuvY1itdwQceSMwpTaJTE95rtMVcja04fF5LiKaBac1
 s6cDG/0RtGsd+R6nxvvs5sbXXeRP8KAFFtq0EeAWvwftnRpBlhwc97AYknxCcQATr+2Dj5h
 r7hpiRszPnzWLIZOZX9psXG3pUlgsYE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CFB63E2A04
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 12:24:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 971A43C0401
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:23:52 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B50AD1400C65
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:23:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AADw/wiCBRNBJ8XRnToJpmRptMw8kDlP/dR9kfz5bMrdZdtZXiuGsKF+W33J0zaiB35c2Bw8JozQJ3Gd/lM/k7LOdYP8ELdLJcnfR6m2L8rMEG7Ysd6rFxa8wY416/MaoIeOFSLmr3vZlxciKfGXC6SHXrN8W6NwxaFwrAm5aDUxAb8PiaQ5M1xW6wLGzvm36igvMFdHwrsejckF+gCQOYW0MsgaY+fFp2KVQ3Mb5onoyEc+Iuxu8wOZt67elrXRKO576n2VfG4efvT1ihh0Rv1MWZgCoQuZmgcZSjw+C0NWU/da9UaCa1tbkKukgCcvafkuRrWxaN5JTAZ0KpfhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKl9tMjdTOO7Zm6Qmku6NKURCRwB7vvFvmwUkqwDBLc=;
 b=yodJo5TOe3M+jL5SjOLPnxiDnej/fKe2rEIyyH9DWOmb/kgkkw3P0k9r7c3zeyGfE25CApOYhN3ALIJ+tO/uSICyQIg4DzMcKNlcR8J05aQVX25dcsDOrgyO3v7qN+CsuSWHy8BBCMtZd+ZeMZd+sVvvwEGfEZvr/5232tCa979Z45hTiQhwNi52a0jW/5pPqxbOi2YbNXoFT0ls8JNiY3/jMgfy3xYjFZLutCg0nVX969KXoFD6fCnYUGYUQleb3KyRCb9ME+te8ix4PAYBD9fuUwb1uowvoIcYjtKiet203mEuSUnFU5XTGoMIPDe1M6N+c5IpOd+P7a6O1ooGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKl9tMjdTOO7Zm6Qmku6NKURCRwB7vvFvmwUkqwDBLc=;
 b=IgMM2/To7uBZRaz+YHPhcXKWQKldOEZUywOjju61QGVP3oEmRM+yU8XJUDETOTs89SFOCsAHymyin6zYmA5RyErzKqzScJNFaYFFOHgURIduFfox58qqQf0/uwRqgilHQQ4MUmfUYGIh/9NZESj8vIdgpMw2Vyl4MUXjedb2DLGHp/kIbgv/gxy7rTtTk+/2XaxlyZ/WLhIbNu6eBexm/0OLKfc+3gd6p8ekeScjtsnqKlifuNywtocl88zjVBL8rcingPTHemcqtNbeBxgxoj8VWTRp/a0nhpDl7v83IGGm/VQnOuxByICpJVVTc93EpQ9QJoyMp6SYz0pv7vxavg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6942.eurprd08.prod.outlook.com (2603:10a6:102:15d::17)
 by DU4PR08MB11077.eurprd08.prod.outlook.com (2603:10a6:10:576::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 10:23:49 +0000
Received: from PAXPR08MB6942.eurprd08.prod.outlook.com
 ([fe80::fe53:d5e4:a1c8:61e6]) by PAXPR08MB6942.eurprd08.prod.outlook.com
 ([fe80::fe53:d5e4:a1c8:61e6%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 10:23:49 +0000
Message-ID: <3717ecd4-8218-4a71-8e37-119300dc8a11@virtuozzo.com>
Date: Wed, 8 Jul 2026 12:23:48 +0200
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
 <akzVEOMWp6p1NSr5@yuki.lan>
Content-Language: en-US
In-Reply-To: <akzVEOMWp6p1NSr5@yuki.lan>
X-ClientProxiedBy: ZR1PEPF000077D6.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::417) To PAXPR08MB6942.eurprd08.prod.outlook.com
 (2603:10a6:102:15d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6942:EE_|DU4PR08MB11077:EE_
X-MS-Office365-Filtering-Correlation-Id: e88f5222-b147-4339-d3db-08dedcdb000f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AJHT14XBu15bjnP3C4WZzZKCQCnRdxL1+FRzrL+2PejDI1nyFRQfhkI727+tWGZmferXhOS2sqxZ+Ol7NtXoqY9Gg/Cb7wZVz4RTAykiOON0ir/wDpisB/9GOsKmLLApPG/BzRLUs/CVKv6Baiqihtu7dV7mSZOCI+8u5e+m7MxclyQuMnxOWrwLa0pV4ds7Bj8Z+CypDaND295TgNreqaiwZD17BN3GpOjfKcDiDAlv+Hl9FYUPoagCkfPPRrTHl2T31Gx+WWmV6sKvgZ9cpZgQh4KG3pzSxIdGst3+976lLeYts9X8eWkAxr9lJidH+pB+Ckyvw2DmcXpcAO/+oZAI+ckwteqQ2vx0VXk4eWelSp1/SuFcmrCmj2ybOtFAuW+b2jdRYXXEpYCq8gtKfyF4hloRr+9PQtD6Dgh+0aaDYF2F/WaLqgZbr+CWO29Cvopxmxs3z9xprkifJbZoRiKKsRahTT1xcPs4m2j/QZ4/XLWajznIdHV4Cq9wKXb0Bdd+ep4kGZYl+SeBmeDSMkJnHnpbJaWQ6/oxIZKy+mG3bAshndI4Ot5Wr5mAzxs5EddzdyatgTsr/34a8UzbTFo7zfP4GAM71l+ossd9H7S4XoHImK+59kW+dmxsZM0RNeBMZKHaBUvNLHGlTWV5vD2kVUvHDLhdpJNJ2Z1wZI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6942.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2xsWkpyd0hZVEhHUHNqWlMveVhFOXFLV0RnNFNROUlXRGdjYUx2UUYwb2VE?=
 =?utf-8?B?WGIzOUVob29nK1NMeUdWRUdsYytaMDIvcE5YZ1BWWXB4ZGRMZm05QTNuU2lX?=
 =?utf-8?B?M2pJZVl2MFpxY3ZlZEFQV1R6aVBuRGNCYVVvTEdiWCtMcWFCT3hJRGpRbTA1?=
 =?utf-8?B?VndMYTVIWEJ2WW5EQUk4Q2s1dWdIN2FLU2pKNWhQUHpiQUwrRy8wZEpEb1BN?=
 =?utf-8?B?aG9JUHU4T2RBZklEdUVMejdlQVY3bnNUSFh2NFNlNFZNMW5RTk0rSmMxZU80?=
 =?utf-8?B?S1BMRjhUZkRQUUF6SysrQ2JrVjFUZEhxNXluTkd0N3paWmxuMEhSR1BoUmQ3?=
 =?utf-8?B?Mm9tb3FXbDVEN0RDTW83NW5WSXVQU3c2cFlVNmpQcXFwSnlTQ1NwbXN2czY1?=
 =?utf-8?B?RHhkZ3YvWkR6T1dHYUI3WS90Q0IzdnpsbDYraVNaNGd1VUhHMDBmUThEZmJO?=
 =?utf-8?B?RFJhQTFjbS8zZWEwbXRSSWNIYmJXeEpSZ29UU3pXNG5mR0xJcWVZQ0JmcU1D?=
 =?utf-8?B?OEppWTQvR2FMMDk5eGFJcitpaWZmTTZtdTh5dVo2aEN3c09pMXpFdm9MbTAv?=
 =?utf-8?B?WDl2MkZ1YzR5b1REYjRwcHZCM1JUQjRickxva09WUkZOTE5VbTd5UDVVdmxJ?=
 =?utf-8?B?TGJOQi9qN2tHYmhHMWNJdU4zV2RxYjJhR3NUdjVCUVVCemJsWjY1dFVBNWYr?=
 =?utf-8?B?OThteDdHYjBVRW9pWjBVL3hpbFZ3b2ZJN0hJRWFad2U2ampsK1V4TkF5bW02?=
 =?utf-8?B?SjJxSElrQmRaU0VJQkxwSWtPdkQ5dVJHRldaYkhwWnp4VU40aE1aVjVXOE5r?=
 =?utf-8?B?WmZvR2ltSHZOR1pjQ3FjdHVNbFhQc2VoYWFuc3F3cVpHSldFb3dhbjA1a2tW?=
 =?utf-8?B?TkdiaFlLSU1DaSt5UHRlQXJSeVdCQ3RHWU9RZmZvT3ZSVnAyNlJsZHc4OU52?=
 =?utf-8?B?aUVEM3pIb0xnL1FRUU9oVmxQdjhTdkhGbkxkQXhxV3htdXJFQVp6Zy9Pa3l0?=
 =?utf-8?B?aVhOcExBZTNyMFdEKzJKQ3p0VnBXK3IxRHdjTnpEOGdFd0p5c21XZklCQlY2?=
 =?utf-8?B?TExESlVtZnZXY242bnNydlhYc3dpT2Q3R1RWaVhsOUpNQlQwQjZBYTNuRjIy?=
 =?utf-8?B?akI0OUV5OHZvOXA2dU9uQlFDMFJJUm5qWmtrOVRDKzdQVzEzWjh6elBWU1B6?=
 =?utf-8?B?MkI1NmpHZ2VXVVowSlVXTUlOdWQwMHh0WVYybCt6bHg2NU8wbStHSlJRUnR5?=
 =?utf-8?B?YXJiWG13c0s1RUZoUGNVR1dlaWdjTjgyemJMdjAxQzdmZUZ1M3ZWYUlIT3FN?=
 =?utf-8?B?SEY3bFdWSElzWlcvUlp4QVMvWEUvZXUydHFxdHVJOXl2QnhZdmM0YXBxa3FJ?=
 =?utf-8?B?T1kyOE5LS2grVU5PMmN0UTRxdVlCTWE2UUlwU2JMQXhlMklRZTRrMUErYkp4?=
 =?utf-8?B?cjA5L01aZ2VGOFV2L3drYm5MMzZOSjIwM3lTdTlyRHVmVHY4SDRpWVpFWk5k?=
 =?utf-8?B?S1UxdFdvbTFiMGxZV1IwU0k2TE94M1duc0tSNlRTbTIrSG95a1dEcmxhMTB4?=
 =?utf-8?B?Q0JWZzRGSXVMU0tDRnFFRVdtcEZpRllVd3RhN3pKaHZoQmRKczdseVVPaUpI?=
 =?utf-8?B?c3BNMlVrZ1Rid1BaV2luVXBpS25rT04vdE9GaHhoNE55R3dzMzNReWxuR0JR?=
 =?utf-8?B?K2hDMnkrVkdFRGxGbUwrNFQwbmxuYWxpUGRjcVRTS0tnWnFjbWkwRkloUHlp?=
 =?utf-8?B?NXZadUx5ODFGdVNsaXpSVTZFQVkyQXUzUWYxRW9lWk5wVThNS3F5QUxyeGRr?=
 =?utf-8?B?QXZncTh4SjUzUGxYVmEzN0U5cVN3Q1ptR0NGTTJianh3Z3dGekpsM2JsN3F1?=
 =?utf-8?B?VU1aZEdaejRiaXFrOFljTUllVnhiYmUvTE1zV2ZKaDI5U0ZLTkdUY25VZnB5?=
 =?utf-8?B?SHA4U3pZRWhPSXVMaFh6ZnJNU1ZOQmFJaG9IVFcyUVNmWDNOQlVCbHpqKytS?=
 =?utf-8?B?WEtvSEIrOUdNZkdlZmlpbjI4OXR1dmhYNmtEenRsQngwV1o4aWRXUnk4SzIx?=
 =?utf-8?B?TFJ6Y1hCc3ZuNG1MZk1QeXlwQUpvSG5kQnJIQTFpWnN1VXZQVEVMcFJvMnd2?=
 =?utf-8?B?M1JZWENBdERDZlM0bHNlWHY3UEFndkR6eXp1Sis4MUgvVnNuT3ZadUtxMzBE?=
 =?utf-8?B?VEkva2x3MGhhTHVvRkhEcWlEWlpDUmVXT3FPeGFPNVlLREFSblViSmdCeElH?=
 =?utf-8?B?eGRwYUg1WUViYWZXcnJrdGJkZnhWNzF2RWx1T2tRRVNDbVEzcGk0eTc2TXFF?=
 =?utf-8?B?V3RRZkNMQVp4ZFcxZ1hMYXVEYm5GZDZZMnp2aHhBQ1BocHVwQlo0UXRoY2Zr?=
 =?utf-8?Q?Q6B0l9W85tGYdEpY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88f5222-b147-4339-d3db-08dedcdb000f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6942.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:23:49.1064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyduhDu0XFh5rc1skm2j9Xym06x5mKWGAO0ZXE60g/CoxLrgu6R74Po5/8X3wt05PXYzqZwf4HLXuCTyD46B7eCyUm9zkm8qSsquuuAPbLSvTyoMIhbhjaydLlb3DGfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11077
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] df01: detect "fuse" fstype in addition to
 "fuseblk"
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 7/7/26 12:29 PM, Cyril Hrubis wrote:
> Hi!
>>   setup()
>>   {
>> -	DF_FS_TYPE="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk)" /proc/mounts | awk 'NR==1{print $3}')"
>> +	DF_FS_TYPE="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk|fuse)" /proc/mounts | awk 'NR==1{print $3}')"
> fuse is a substring of fuseblk so just ($TST_FS_TYPE|fuse) should
> suffice, right?

Hi Chris, looking at it again, yes you are right just fuse would catch 
both cases. I see the patch is already in master
do you want me to send another one or shall we leave it as it is?

>
>>   }
>>   
>>   df_test()
>> -- 
>> 2.47.3
>>
-- 
Best regards, Vasileios Almpanis
Software Developer, Virtuozzo.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
