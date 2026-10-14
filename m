Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568C1CC6B1F
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 09:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791969955; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=u8RN1/0th2Z4wGef4xgeL2JZJXJpKWesVv539LWMjC8=;
 b=O0G8BBpJlIHAL7XeMZgnWMe8yGNfYPMv7i/X3RxVVOi3fjBm/E63FHvEAqGbiFCZv+OGS
 He3eEYfoAiZqQt54Hzr8ONJjz6M6NCuavA5Yi9rHYwjsRqbuBnrBChH5NhZxuSzBIfr8okq
 1ZdVWAiVBt/kc3AHGz4fEzKCQ7I/OUo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C5453E6AA4
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:25:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6301E3CD74C
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 11:25:35 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C9B986009C9
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 11:25:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocCpKYqiWh1xL8E/CEfEvdz9eUTl2KGgjEdhocNx92EbGkdQNXpMWy+sF1UngiTiI8K4WAFPPGnTxU60102LNDkmFnPm/YBnongCHLaczyPY7X+Zu39ODDSXxRGrfBlbHq94rrudri243fBzACFPsOnjADKkc59mxFr7hLux3SaeQ3LZ1ocnm4zRpGLznmCs9+gnRYNZMCxz8TNR02s4x87OOMNf3/5AegATFxQvL/8OZ2deSLynuXDU4MA+b8V437LgKEWohTeD71a8VUPLEHzRva0sZ25kAg12DxCgea99g7xYdcvoM4sQ6IF15F7oAzs2IkdRciMTBgqhJNSjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ+IQh5G78Onvmp7sSnGJbsEEKK59CUeV9mghbSOWBM=;
 b=AGY+S8Ncaqsxf9J+FAMr/i2wg3Cwkx7wX01d7vAZfZUnjMzu7EO6os0JqmCblviRaJX81JnOhOyFjhUgOo6cu7HyCdrgWH6vbeRaYnyYnmxePBNaJ2vQE4VnFTHg1CEk5nAR+KyGIDYw+KNC5r3lpTdRe/PR5/Fyt/SynxoW7vG49WI3+dp6ulad8383EzADNVv8/H2TDDwjjhzsP/D7NeCXAC4XwXmnadGME3E7ze+xIuYisJ+7IvrbQNRb9Or4bei4Vfu7D4eEhSq2qJZGNC5ZhEg4E6g7N5NEuKEfRcbxLuqvWtPZRWbeBG8TM3d0S3YEs+LAtDX3i3+2QSGsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ+IQh5G78Onvmp7sSnGJbsEEKK59CUeV9mghbSOWBM=;
 b=zMHbsQxwBVeM/sAC4Wku7jtKAV5nm/kqSRLX8dKWzRJdaO83rx4qCLLOnjfCU4/3jArcG/hobgJdK8vuEzmGwhU/nF0jyEIXjFvz4ZKYnUDtHOo6wTqVt9KDcx6tDByPNX4kH1sMUZy3ioz9rWLdQLz+DbdsA2NCUkQcNKWU27wu27EAfIeA3LxjLqnBOHD6K9jtCINJhvLiERb/AyuHn3uNQ+F6nKuw5Wyz7VQECpF5zvm2Z1qO6uni+kcTJyIE8uenOOUNoKiV6mVh+NifsJMfDp0awLLBWajP/94whmQCCkatNDm/Xcd9F+UUDrk513Myt83oEWHWx9rZzY0KMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by VI3P192MB665926.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 09:25:32 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:25:31 +0000
Message-ID: <3a04280e-4f73-451c-be84-857a49c8ce16@codasip.com>
Date: Wed, 14 Oct 2026 11:25:30 +0200
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <zEv6AUi5JUa4zZxBhpChWHtlkQSFX3ZQ9BPa@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <zEv6AUi5JUa4zZxBhpChWHtlkQSFX3ZQ9BPa@localhost.localdomain>
X-ClientProxiedBy: FR4P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::18) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|VI3P192MB665926:EE_
X-MS-Office365-Filtering-Correlation-Id: 82739c3b-bbeb-4a09-41f7-08df29d517e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|10070799003|376014|6133799003|10067099003|22082099003|18002099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: GassMayI93pao+lOgU/9w3pNcGrDn+ZYJHofpKGcJmysmtDeXjP4nTQVc0qoOmWINMaa/TY1Xs7owPZXR75WYmilg5Q4CDO4izISwBatHir7pbWlunBkIlmk2QDeuZVhDe/7/Y0E88VwiQax/BHNiBXPZ+dmEEysG1mL+7Adurnct/Eybn/5goJhw2vxjqPFLpBbyPhDl/IaLi6mU+oxYblSrlrHrFH+kFBRQSM4kXonWezOOYfxvzE0BhF6jCyWUDUJkQtdeOc8Vgts03CEUjVpLoGKaej30uGRQ/vQnZSzABVpHHsLwBD2ue/n4Tn0W1ex5l9QJDLxfSCvrWykFCIWMIWOugDLK/uVudKsru5im9GI2ERWrEtW7fCdE1C5hYgz06mX0KTp3239/PnHVlPxazMfl5dNc1XjBk7a9bCoCdtJEnwEvHm/p5Du33UbUxostbM2FXjkn4i/82hpe1inENY8NQi3alMHpye6dAcNajgCwb5yQVN3Guwr3y2pOJsgVqiWeXeWU2g/JneuJhmkAsWhUNckapuS+f26cYqSXZ+JKYl+/XcguuJ6cQ4yIFvAewv53Zbu4UPte6EFhGMbboR4BEvGRmcRQDSBzBublKucBKRtleumzLa2UXM5vo0L4hfQAl5Qw6eNNkVkFli9F7XOPXDzTlSq3jmTLwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hRQzhMR3grVzJzdCtSN2FKclZnZHRVaTFacXhrSkp2ZTVuRXgxblF0dy9u?=
 =?utf-8?B?V3o0K2lPTEhlM0x4dHZCOVI2UTVldi9DNWpqelI4eFhGek4yNUhDL2ZsRWdx?=
 =?utf-8?B?MUE5QmkyZFhoT1ZOUWtGT1BzdmJVbHp1dFZzK21nK1labHczY0FHYjZKL0wz?=
 =?utf-8?B?NHZ6bVdHUlFYYlJpSGFsWXRpTld4QU4yNDJsMHB5d2s1UzFoTnlvSG52bWNF?=
 =?utf-8?B?Y3JaOVJvZEFPZDNvek9yL1VUbDJicmhSSC9QY0liOE5DM2hNL3hHaE4yaVpy?=
 =?utf-8?B?TEJONjFLUGw2M3pOa1VXZ2x1bTFJN2dOcmtWaURDUXNpZG5sTkVqMnZKbFRq?=
 =?utf-8?B?N05pT2ZsWUxZTUV2UFRxcDBvU2ZjdWh5SjIrWkVMSTR1ZmRSUUpzOXZkY2s3?=
 =?utf-8?B?WEpQMTEyZzhqYkhpTmE0d2lJWkdka0NuVG5yaWw2SWw2c1QzUWdkY3lUTmRM?=
 =?utf-8?B?UUxic3hONUdpV3lmOWI1encvdTNqTHNrT0J2eWE3emFKaHJhZHA0K0JrM0N6?=
 =?utf-8?B?S3FMOVZtRjkxdGw0VW5qTktXb1l6RlRJU0FOZEMweG9CKzg4cm00aCtQa01I?=
 =?utf-8?B?aS9yeU54Q0RXN2pLL3BBbTN2K3hqUXZXZ1VYc2NPdm5BajdXZmxOb251ajEw?=
 =?utf-8?B?enVPWDBkOW1GZXFpUmRHNHkzN2RhV1FvNW5aUGxRZ214azc3UndOdVpzejVC?=
 =?utf-8?B?TFFxc0dyMmJSdkUyWjRyOUlMMVBVQjlEajJDNHBMQkdwQ1ovTTRFc0hjU0R0?=
 =?utf-8?B?TU90aWtLMmJTaXFwY1dZS1A2NG5EREswVGE2bEV1QjhjMTlOVEN3bGZjTUFK?=
 =?utf-8?B?djVmVVltWWNwZmtrV29BOFdTb0t0ZUdJQnNybytJSVpUbjdBVkI4SmdTWHZE?=
 =?utf-8?B?K05HdkVvQU9CbXU1SjBiNjJ1U09maGhnWTlJQnBtT3E0NmxBUnkxSDk3L1ZK?=
 =?utf-8?B?d1dxbnJjcmtFRjhBZ3N5Q0VjbjNWS0RxRkxJeXhzdTBwcDJQVzE5aFdRV0Rm?=
 =?utf-8?B?M2ZaeW05UEJ5R29jZGkySjdseUI3bEFQaUxrMWVOQ0FTWmhxL2UwUGlkeG9o?=
 =?utf-8?B?VUVPQzNNY00wenBTLzlWSnJOSGR2WXFBcGNEaWtvUm9meWpWM3YzbFpiRzJE?=
 =?utf-8?B?dlVPUVZlQ2M4ak1rTGl4dGtwMzllRWoyQno4L1ZXdzhhcXNSMXh4UVR6NFFT?=
 =?utf-8?B?V0xKZm02U2dpaThQSFRaVU9uMG96bGx1aGZscEk5T1ZtUURoRW1hc2RTNTlC?=
 =?utf-8?B?a2lqbnlyYmxNQ1NXTmhQdjlrNUNkMmpWOVM1dlFVWFlJdDJYTE5TeFZzM0R1?=
 =?utf-8?B?dXVmZUtkTWF3M2FpZ0ZHZnErS3QxMkRhK2pLUWNuUXhKajROc0QweTRZaWJP?=
 =?utf-8?B?eUNtMXlQV3Rhb3FFbkVwbHZ1Zmg4N1UzeGQ4c3Q3RnZ3UzRmY29EbkRLL3NF?=
 =?utf-8?B?ZFIzZXRzQ3BhUTZ2VUp1LzBXM0JmT0ZSV2dGaVZRSjByN2ViWjBJUnQvcTQ2?=
 =?utf-8?B?c2VxUlBWamRvZjl0dUxPV0M5T1VaYWhFaE9jaGhJZWlNY0RnZVc2TmdpRUU2?=
 =?utf-8?B?S3B3aUNDeEcvMkwyNHp5clFPRlRBekRsdGE1OWZzUDZuTjk3aURENTBHZmRp?=
 =?utf-8?B?Mjh2NU5URjFtZitSeTVxRVVpQUtQMktNeGk1cXlONnBpRndNRGZ3ckJ1c1hL?=
 =?utf-8?B?M2k0QnBTOEZaZi9DVHRaeld6NlovOUduMG5YSEhsU0Q0ak5JeGlrUDR0Wm1r?=
 =?utf-8?B?VkQ5TEpmUWlhWnVsdE1SdDY5WmVSTzlSSm1QZE45b1FERUNFREZhWWx2VzZm?=
 =?utf-8?B?UzVjRlNLbzJYTDA4dUs3Q3RqTVE3QXRyZ1VRWWpmWG84TXRkL0MvcUo2VVhE?=
 =?utf-8?B?ZHZ3UXd2c3B3aTIrUCtRT2M2RGR0d3V4MFBVVElUeW1oR0dZK1QvSnBrZ2FD?=
 =?utf-8?B?WEpRRndJdUVtVjl6WHErUDNHSzdCdDZUSUt6Q2NsNUhhOC8vQS9VZlAvOUox?=
 =?utf-8?B?N2ZzYTFTS3FyUVAycldwZ2FjcFJRZWlzZ1dCaVJsQkh4WXJ6c1hwYjNueU9K?=
 =?utf-8?B?cTBlSTdhenByR2czME9nZlUwbXJudDM4SWU4MnZyOTY4U0lsT2F4ZVJpTitU?=
 =?utf-8?B?QnkrYVVBUk9TNTY5VXZZTnR3dG9FZ2lQRCtCK0VWSW9semRmTFdlL2taRllw?=
 =?utf-8?B?cUlRRFR3RFBpNEVMamRZcVRDeWE3SCtjcVNYUlNVSXNFM1dvTzJwRzhnK2J1?=
 =?utf-8?B?YklqNWh6OTFDeWFqQzhnU2IvQTh5blY1RVFvdFN6eTZlb1FkOWtRSlorNmQ2?=
 =?utf-8?B?UHhZUUgyUG9oaXNYZGt1RUZMSy9aQzJQS1c0U0ZhR0FtUjdvTFY1ak5hSGE0?=
 =?utf-8?Q?x/2xdtCFnep8bMcdkTmH8RO+eepzY/Wv7fdJVxc9FioJl?=
X-MS-Exchange-AntiSpam-MessageData-1: U/xYAj/yu20PyNVCVEKJU5UWpHqG72uVdKY=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82739c3b-bbeb-4a09-41f7-08df29d517e4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:25:31.7851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inlbFjJmvT8+vjNaFCEaj2ZG9MfrpzN9t9Pjf5ykYYuI42ZKzSyOJPPD4eMfQmRyPEIboOjhKkNVKVgmEKecapn6Wn33ud+8NagBxjJmR9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3P192MB665926
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] keyctl05: Use DNS_LOOKUP_GOOD to avoid
 false-negatives due to EKEYEXPIRED
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
From: Florian Schmaus via ltp <ltp@lists.linux.it>
Reply-To: Florian Schmaus <florian.schmaus@codasip.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 14/10/2026 09.43, Andrea Cervesato wrote:
> Hi Florian,
> 
> 
>> In keyctl05, test_update_nonupdatable() verifies that
>> keyctl(KEYCTL_UPDATE) fails with EOPNOTSUPP on key types without an
>> ->update() method (such as 'dns_resolver').
>>
>> Commit 4e9400050683 ("keyctl05: Improve the dns_res_payload for boundary
>> testing") changed the dns_res_payload to a 6-byte V1 server-list header:
>>      { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 }
>>
>> Byte 4 represents the lookup status (enum dns_lookup_status). Setting it
>> to 0x00 (DNS_LOOKUP_NOT_DONE) causes the kernel's dns_resolver_preparse()
>> (net/dns_resolver/dns_key.c) to treat it as a failed lookup:
>>      if ((v1->status != DNS_LOOKUP_GOOD &&
>>           v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
>>          if (prep->expiry == TIME64_MAX)
>>              prep->expiry = ktime_get_real_seconds() + 1;
>>      }
>>
>> This sets an aggressive 1-second expiration on the key. On slower
>> environments, such as QEMU, more than 1 second may elapse between
>> add_key() and keyctl(KEYCTL_UPDATE), causing the update call in
>> test_update_nonupdatable() to fail with EKEYEXPIRED (127) rather than
>> EOPNOTSUPP:
>>      keyctl05.c:143: TFAIL: updating 'dns_resolver' key unexpectedly failed: EKEYEXPIRED (127)
>>
>> Set status (byte 4) in dns_res_payload to 0x01 (DNS_LOOKUP_GOOD) so
>> that the kernel does not set a 1-second negative expiry, while still
>> retaining the 6-byte boundary payload check for commit acc657692aed.
> 
> Good catch. I'm wondering if it makes sense to use KEYCTL_SET_TIMEOUT in
> this case, but I guess we can rely on the test timeout in this case.
> 
> did you explore this option already?

Sorry, no. This seemed like the less intrusive fix.


> Otherwise LGTM
> 
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thanks!


> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
