Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3E5CA0EDC
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755185231; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=RiqFJ9apomlRvE0TAHtqZ4ccJxpRIWEySGoNLUJfmfg=;
 b=XUqXMaGpy43k1RhtXimWzl6ZwegSnESo0hVr5Xnb527C5RIgJmmIPRSpkv5funcFG5ne5
 qwmE9J0FWEVn/OeXa0gDKm7hjtXYh2QPjebNt3TFiurEKC5WrASISuvm9godd3mYJBr4geZ
 XvlFmV1FZVFxb9L6N5Pe5kvyrzfTfgM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D2493CBECB
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 17:27:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D4E03C6994
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 17:26:49 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6088914002D7
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 17:26:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVPhz0o5L6tX/a/kwo3Z1Z08Hafr8XiK5fxavFMFBZjuKf0FGBaqniqNZqZKE4orruruJ34w0l5BATK6cxp7uKvrcWnWjBx76XEYt8QV0Gg8e0YP0fwG1eIbL6zT4spBL1v+9K7uIOQloHX3ESx8yxx8hJi01FJwv1WopVdSCeK3c7aiSlHXiFoweDu+6rQYPunWT6BF3v78Z774QGTPmoBGC0sxyX6t0TY9v4UYq5H1il+H6Dr6iROovG4py5noDi5QGQ9YHbXrz8AGhcGLcCR7qOkeRg0UWpyeTsgr1UlFib9hDdSiMfBmjK/ktvu2XQZBnRNG6qgArh5MZlI77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elHNVuIABv/v4wvAGrGXqMeGg0RM//50IlHbDPWaeyw=;
 b=UARZ2lZc/Dv6rW6mTFFyHJyLUzRUXhvcEm8T9xaoI526hatvCru3dFP7+IS/gS5gXBFMSFXj+MM0OxJlWRR8s03A8gFSWpW3fXOHKSys1SWYyRUJJUhV4iU3lDRte3llQpEIfrbTC8HC+5AiZDi7bjVPjbfje60M4VjUIHO3pjv+6TvH/vmglO27SWZ/b08FyLIqskhujd+0fam8TNIb4J8gCaOKuGYEDVfrWayv9JmXXQw1RKVZVRIC+mSk3pG3AjSZQxgtOLdMStgXh5dpNtSnj5AlnKigY2lZLKb7uk84Vr0dJ4SalQKSlXTabSLUGgGbXGe9vIEE4YKJeR7RLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elHNVuIABv/v4wvAGrGXqMeGg0RM//50IlHbDPWaeyw=;
 b=fUj9NCTV3F0uudcFUoKrnVPJN3W4Wtx54WGOcfPPCGc6sV1lS9RvHjirRZqOHddOqxxqojK2ohMLskr4qCXKCVqlLCufB0an+cSz+1+cTPUADCGjm15qXJ/FKmqFfqRkajP5S64PXrRWXs7nOQNkznBtVA73vZzcNYfTH6dwRQztsh5A606P9LBtGkm9a+xkjUTj3XuNZ8wXHvSCa+uwQQw/eUpRcpNX/vDz5I28ePiMwjs3HQkiBBThHwqsS+eDuYNtn1YJt9LckM4ftxz7TqmBur8EJJma6++Uuz02wJYBOlMx7QzgrPiUmnylB3ZXdqFPj9+jVM7igVuOEaWbDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by PAXP192MB1462.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 15:26:45 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 15:26:45 +0000
Message-ID: <0d3b9301-5683-4455-987f-4a47f7d93749@codasip.com>
Date: Thu, 14 Aug 2025 17:26:44 +0200
User-Agent: Mozilla Thunderbird
To: Pedro Falcato <pfalcato@suse.de>
References: <20250808163457.1685958-1-florian.schmaus@codasip.com>
 <24huvlw5wphgka5j6uwrweetmpa2tyi2rnrwp3gqymrpvcx2i6@zmepzxfsiiie>
Content-Language: en-US
In-Reply-To: <24huvlw5wphgka5j6uwrweetmpa2tyi2rnrwp3gqymrpvcx2i6@zmepzxfsiiie>
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|PAXP192MB1462:EE_
X-MS-Office365-Filtering-Correlation-Id: e6701d1b-efb5-409c-59e1-08dddb46fa78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWgyUXpzZmpSaWRDb2U1cWk5alRjSHJJeXkvaW1UZkdCS3dCVEdTYWR3dW9R?=
 =?utf-8?B?aWVadDV4Y2tacVljQWgrd3p4eCtNK2RTSloxWTZKUU0xR3RsU2NzNTFhUkhX?=
 =?utf-8?B?NElIS0pVYjBuUlRpdlVUZDBCek5RdmxocWpwaTU1akd5RUNoZXZsTlRxRFBr?=
 =?utf-8?B?Nmg4MDFpVjFHblN5Z1J6Y2dwS1FYUkNiZGxGOUJlRUkrcVN2TVhMRU1taWJw?=
 =?utf-8?B?NUVPMy9oUlIveTVsWm00Zk9CWkI3Y2piMWtsd25oM3M1bWlHMnVKenJzU2di?=
 =?utf-8?B?S1ZURnZjbzNrSEV6YkdZcWJJQndSQjd2OXZhdEorSFVXb29qWUZySlNYWGJv?=
 =?utf-8?B?RmZPMVlaQ1BIeEMyMkZ1SzBpWG1YdHRXbjBpaFQ5OXZHblRNUFNLZkxNZ21I?=
 =?utf-8?B?QWcwblM2aGtiWVk1T2lVQ09Oc3BLYmFpQkkxSk9JL0VaT2xSTDl0SDdUanMy?=
 =?utf-8?B?ZUcvSG5tcXd5aFFtaEpFUTU2Qnd4LzZhRVE2U3p5U2xMTlJNSHg1MnM5a09D?=
 =?utf-8?B?djRmOTU4bU4vMHJQNTJ5SkJFb2FUWkVVMklqSVZuOVRFeEdBdE14UFg2L3Iy?=
 =?utf-8?B?Q1ozR1MvcjdHaUJTZlZUY01TRUw1QmVDekVLanJjc2s2ejExMTdrZm5aU0w4?=
 =?utf-8?B?TmhjSUZZcVBNV3NmT2kwTEJ6MDI0eFpXM2pldW9YTkd2Z3hwbGMzUFVpV3l4?=
 =?utf-8?B?MnF1aituK0R1SFZOTTBHNERFMVJhbUI4dVBVTHQ3aFdCY3hlbkJPaXdqZlhv?=
 =?utf-8?B?ODMxUVFkWkp3NTY0NFVIV2treGdtQ1A0UzhRZzdKRXJXTWpHYjZvcTBhV2JO?=
 =?utf-8?B?V0RyL1YwOHRlUTZIbTZzU2phK0loTHEvUDRwSzBCb1RvQnZ3enBDdHdSdWtv?=
 =?utf-8?B?S3dWSnFrSjgyWjlISWVreFk1OENvOXVZVGJsU0xUR3UwS0ViRnJESUl4YTAr?=
 =?utf-8?B?MlNxOVpUL01mZjU2YTVCOU1SZnc5KzJ3SUJxbkF4UUh6MnhmVnp4aXJMdHBs?=
 =?utf-8?B?bk1zTWRZRDlMN0JjQzEwOWFhcHY4NTJ4eWxncG9CcHY3clJMUzlSdVlqQUl5?=
 =?utf-8?B?bnVJYjl0WnpZWVAyY3c2QlpYMnJqZU1yT0ZWSVdQVXdqYjd3ZWtiZ1lYRkRo?=
 =?utf-8?B?c0lTU3p1RWVxSFhZU003dnZWbS9OOUFwZlZkMFByU3BKV1FKRVZjM0x1Sksy?=
 =?utf-8?B?WE4rQ0dRN2tIcVJFaUR6QjV3QWh3aW9FdUJrL25QeWFLTkdZMEZzVFJDMWU0?=
 =?utf-8?B?OE5JdGtSMlJ0dCs2eTk3TW93clpDY3BmaHMxMEVZL1pxYUszWXdOYmZCWC90?=
 =?utf-8?B?eUlTNWpxTUxIeDJoWkZVczl3c0h0bzh2QXJpTDRTVkY2eHlGbnVzeDF4Undr?=
 =?utf-8?B?cXpqN1JMZXRhdkU3L3hHZU9kdEFuQy9kNk8zclVJS1N5d1BqMENwcWVWVVd1?=
 =?utf-8?B?L01vdmd0RDFuMmhvMHZLdDdIMENjc1hPNUQ5ZTdlZ0d3K2pxQ0UxSkZyVEdj?=
 =?utf-8?B?KzJQeHVNZkhzMkJtOHlESDZwTkpiS1N6V1FSSDBrTjZUbXJLUVF2blFheDcz?=
 =?utf-8?B?Q3VWUkZUZ0JYYWRWbEVoOElUOWx1SEt3YUhxQ3kxZ2RrcW5iMEIxM2RGdVpZ?=
 =?utf-8?B?N3luSTNLKzY0aTU2TjYvR3Z4QktJdFAyeDNKTng4QnpiMVRNdWNyNElIbCtm?=
 =?utf-8?B?bUpYemZXTllORlZKaHdLQU5nWTRNRXZpcmUvMWU3ZFp2VENNODMwcDhBb1B3?=
 =?utf-8?B?ZkM4ckdydGMyTzF2eUZBQUQ3RU1rUlRmT080SVk0b3pTcEpaL0QzMkpXZDhp?=
 =?utf-8?B?eTVqWENXSktlQlUrdlhZazExZmtWZ2hMMjFsaTd0dVJoRXdiUTBJSnB1R1Zx?=
 =?utf-8?B?MmtidENzTlBpT1d2TkNqVkw1RGFmRkZTcXpLTFhYZGFkcmZhYUIrdVAyZk1l?=
 =?utf-8?Q?K513PeGo6ew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2dkZjBqMCtiME5QenJWR1NoTmd2UDUvMTFtQ3kvdzJtOTQ2RFU2Z0RmTG1P?=
 =?utf-8?B?d2V5MlZoZzMwQ3Bmcy9zM3NIQXcyTEFGd1ZFMlZnM0pVQWZZUGttenJJaXJN?=
 =?utf-8?B?YkpYVmtxL0RqSXVjanhMMGhaVThLQlF0REsyNFJkcmVSTXB3NmIvQ21aS3lm?=
 =?utf-8?B?MlVreS9TY0dhWGRMNmdBMlFqV09vdU1rYkZIQm1UNHJqK0g4NWZOenBpVWVR?=
 =?utf-8?B?YzVYZzhjUEFFY0JqK3p1ZTBlTU5RUDdNYVhXZXp4MDJIL3FoWnlldzdIN3Jz?=
 =?utf-8?B?UDF3bk1yUXdiekFuWm5raU4zTUF3QVQ1ZEMzVXdKUkl3U2hvYXpwbHo0NTFH?=
 =?utf-8?B?aWZxclZLNnVya1pvbTVVcFN1bFYzWGMvQkoxSmp6MTJ2UkJudU5Ba1kxZ2VR?=
 =?utf-8?B?NnJPcVplazdqckxGSE93Y2UzaUxVR3dTQVBueURneUdNWjc1NWFZTUhHYjJW?=
 =?utf-8?B?cTVBTHdrUlYxYkUxd2JRdFRHY1FCUW4xQXl5ZDBEQXREVHpDZThYMHduU0Nn?=
 =?utf-8?B?NGE0V3FVY2FNQ3A1Tzh6RzI4TDk3S2RWOFFjaWx3cVk5d3U3RUVibUZjRXor?=
 =?utf-8?B?enJRV0VNdjBkdmZJY2gyMmtvc3YvT3lmbzN0QWdGeEtLaWhYeW1vSUoxTDQ5?=
 =?utf-8?B?NTNOb1Erdm9ncXpYeWU1NHhBTzNlSkdidjdQZFIxNitQUTdjVVEwNzhLL3VD?=
 =?utf-8?B?aVU1M05QMW95VlNsblpReXJ6Y1N4NXFKZlpnZzluT0xtRHRxZEZNNElQTXlI?=
 =?utf-8?B?blBUU2xPakx0NUpzWWR2ME4zYStSOUdPUjFudTBUbnhCVE05RVZER1NEclho?=
 =?utf-8?B?enMxemszU0l1TVFuZ0NuVXIrQWpLNjJpTW5VMGtJUzJzd1ZMOVdSYVpRc0p1?=
 =?utf-8?B?VjErenhlK2RXSnZ5WTNDQXo2VzBDK2o4VFQxNnNhWVZ3MGZOSUhXVk1FZWtr?=
 =?utf-8?B?VmhiS29iM3JVQXJoWTlBL3BQd214ZksyeWJqaU1YcE5aODlzazd6RXBHUGJr?=
 =?utf-8?B?Z2k2TTBFRFg2REwvbkhHWGZnVERnMjNydExTYmZxbFdlTUF5em4yTWxidHJv?=
 =?utf-8?B?QzlGTks0MmZDN2R3bHZZQVlrc1ZPZHFZcGJyS2RGNWx5OE5jMzZMb3RXRnQr?=
 =?utf-8?B?R0hnOUhnNDFHVFRGb2t4aGlyaUxEbnlOVUtlM1dlK0k4UmtabzN5N2c0TlZa?=
 =?utf-8?B?dnFjODFoNUhONVZHcDRWTGExRzFuNEhQcitxWkNTK2tST2hLcHFhL2RUbURv?=
 =?utf-8?B?aHkyU2JQT094REwwWEtYTnFVQkF3ZUtITjMxQkxtUUU4cFhXdnYwV3dhOG54?=
 =?utf-8?B?Wmx4NC8weURtRmxobVdxZTdxRkFERkpJbTJvb0V4d1BTdkFQVmw5MFNHdE4x?=
 =?utf-8?B?WGVlSDhjUGVDWWsvTERkTS8xbmMvVDNueDF2YmFxYTdQaE9XV2JCcWxKTVJQ?=
 =?utf-8?B?YlFQMGx2VUpMelpnOHFJbTBINFhoMmJPdTlSaStsOW5nUFI4eWU3RHdPTUZs?=
 =?utf-8?B?QWZXVFNsbXU3TTlVN1lDd1FFMHNWOVlQQUtrUlRNMzVvQVo3U05YenhQT055?=
 =?utf-8?B?SllMTlhZaDJ5dzdndkRyTWNrTWNOYTJBVWxOVVo5L0tyZWxDSHRxMzEvNENH?=
 =?utf-8?B?YkRsdlRpMVUwL1ltT0NzYTJ6ZStKZlh5eU9MR2ZOZDhIWXF1OFkyWjZHc29C?=
 =?utf-8?B?S2h2dkVyb1VYUjhqYXpEWXZUeXVWZDRVYnJmWTdxR3hxSDJaZlIzTGxKWkZL?=
 =?utf-8?B?VldleVRKd3NrM28yRUtSZmMzMkhVMlVRK0g2ZjI5cXdLZUNxUjJBQWM5SzM5?=
 =?utf-8?B?RXRXZVFjQ0FVYW8wU29XQkF1RTJyUGdWR2l5SGQrOWxWeUl1UkJKano3Sy90?=
 =?utf-8?B?OTFkQ3dQZFZCZDYweHh6ZzJBQ1dsdHVBVVZ2Z3VhQ1Q4QWt4cVdpKysvdnAx?=
 =?utf-8?B?d010U1JRMDUyRnlGaWhsSmlZMGtIYVdUQXZjNFJabE1wRWpvbW9FbWNpeXVk?=
 =?utf-8?B?MkFQMm9naHJmT1JNVHBldmtSY1RSSitJSmp6ckpuRGxGaFFoQkNQeDdRYitU?=
 =?utf-8?B?Q0l6SVNuVmwvaGVzN1RnSmdjcmExcFlYTzRBM3pXNURoSVZaZnVDL0JIclVJ?=
 =?utf-8?B?SHhIU0lSN2JoR1FzRldqNlpPc1czSDFKblZjUXFMTDl2QVFvQ3ZhQUU5TTlW?=
 =?utf-8?B?ZWoyZVF4RnJzMDdxV1BvYW9DdHc1eTgzTGVoTG9FMy9kV0NrRXFFVHdyV2xH?=
 =?utf-8?B?RW52MG02bWZJQ29kdGpNMUV2OHR3PT0=?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6701d1b-efb5-409c-59e1-08dddb46fa78
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:26:45.4327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2Ow4tYAe6RuH9uUS2NK0g8ifyzM4X9u1oKWO1lQ6/GU3vho6BI2LUkDHjEGBgN0U/rUIPzOBquNqA1x59AWW44lF5nK/grV+6RCuV1jOlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1462
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sigrelse01: Check if signal 34 is available
 for musl compat
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTMvMDgvMjAyNSAxNy4yNiwgUGVkcm8gRmFsY2F0byB3cm90ZToKPiBPbiBGcmksIEF1ZyAw
OCwgMjAyNSBhdCAwNjozNDo1N1BNICswMjAwLCBGbG9yaWFuIFNjaG1hdXMgdmlhIGx0cCB3cm90
ZToKPj4gRG8gbm90IHNlbGVjdCBzaWduYWwgMzQgd2hlbiB0aGUgdGVzdCBpcyBydW4gdXNpbmcg
bXVzbC4gU2lnbmFsIDM0IGlzCj4+IHVzZWQgaW50ZXJuYWxseSBieSBtdXNsIGFzIFNJR1NZTkND
QUxMLiBDb25zZXF1ZW50bHksIG11c2wncyBzaWduYWwoKQo+PiB3aWxsIHJldHVybiB3aXRoIGFu
IGVycm9yIHN0YXR1cyBhbmQgZXJybm8gc2V0IHRvIEVJTlZBTCB3aGVuIHRyeWluZwo+PiB0byBz
ZXR1cCBhIHNpZ25hbCBoYW5kbGVyIGZvciBzaWduYWwgMzQsIGNhdXNpbmcgdGhlIHNpZ3JlbHNl
MDEgdGVzdAo+PiB0byBmYWlsLgo+Pgo+PiBTaW5jZSBtdXNsIHByb3ZpZGVzIG5vIHByZXByb2Nl
c3NvciBtYWNybywgd2UgY2hlY2sgZm9yIHRoZQo+PiBhdmFpbGFiaWxpdHkgb2Ygc2lnbmFsIDM0
IGJ5IGF0dGVtcHRpbmcgdG8gc2V0dXAgYSBzaWduYWwgaGFuZGxlci4gSWYKPj4gc2lnbmFsKCkg
cmV0dXJucyBTSUdfRVJSIHdpdGggZXJybm8gc2V0IHRvIEVJTlZBTCB0aGVuIHdlIGFzc3VtZSB0
aGUKPj4gc2lnbmFsIGlzIHVuYXZhaWxhYmxlLiBLbm93aW5nIHNpZ25hbCAzNCBpcyBhdmFpbGFi
bGUgd2l0aCBnbGliYywgd2UKPj4gcGVyZm9ybSB0aGlzIGNoZWNrIG9ubHkgaWYgX19HTElCQ19f
IGlzIG5vdCBkZWZpbmVkLgo+Pgo+IAogPiBb4oCmXQogPgo+IFNvLCB0aGUgY29ycmVjdCBmaXgg
d291bGQgYmUgdG8gZXhjbHVkZSBhbGwgc2lnbmFscyBvdXRzaWRlIG9mIFtTSUdSVE1JTiwgU0lH
UlRNQVhdCgpUaGFua3MsIHRoaXMgZG9lcyB0aGUgdHJpY2sgYW5kIHJlZHVjZXMgdGhlIHNpemUg
b2YgdGhlIHBhdGNoIApzaWduaWZpY2FudGx5LiBXaWxsIHNlbmQgdjMgc2hvcnRseS4KCi0gRmxv
cmlhbgoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
