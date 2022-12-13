Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A985FC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 01:51:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F6023CBE6E
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 02:51:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0B513CBE03
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 02:51:25 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B063C1A0060C
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 02:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670896284; x=1702432284;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WmjkIuDWnePXvU/SfCXNrOBJftfD3AS1ld0qC40D2K0=;
 b=p2FHW02z2KZcP8F/t/XfLmGMi+5m7QRhm9z5cy15sdQ8XNTm1rF7MYKr
 hlWXkflXP3fjxuLNciXeM2BrB36IyBO/sXG+6fIsM/h+g3zuB6p9FUvBt
 1TdAh8pbkxU5sYEy/FDqH8+iM45wQqceFBmFLI5OaXY2rETzQaEmdO4LF
 xdVcHcLcGvIFiKZqoKCOcA3tPU3PNXbri4dlhw3mF/Rp72T5apA0E08mP
 MzY0uLc+XeGAH6TiV+sy9r8RfizBvuwdbJceWfQrLL1hfVYQHj8xjEWCN
 6UEdPlJMdx9ZuyvBeAvLLisHpwV5fzEvxfYBFuHhJM6uqE/AoGqknoxl9 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="72693213"
X-IronPort-AV: E=Sophos;i="5.96,240,1665414000"; d="scan'208";a="72693213"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 10:51:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e17+PlPzod0IOBUX5brWxkRK+tTqjVps5PcRojHREb7EIzQxfRGCz4IFnAfCV4LJImnESMs0GKdMA71/r2Z8gEz0TtWxlFH2PbeRJsM1QIgo/Z1s6C94BB7S49DpuMChqDJwuGPpHKl6Arihdc/9k8cHa2YlGeF7p9tXkCaiKU0jTDhC9ctOuL0pQunKG4quC5tlUYXqSSj+2L8d3zU1PfPsHMOlh+7fitXAm17fVR/foBFHqvyJxfh/ME6FrggiYDtEYhNP2O49peSeK7q/FwMqu26THJqh1KBgm0ITPDD+RVCN9P/Vs4Qj90rxEI5SwVdAnA79SbYyUw7x9+ubwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmjkIuDWnePXvU/SfCXNrOBJftfD3AS1ld0qC40D2K0=;
 b=gwYci1WTXnh7eOMLHnMSeEHSgKUz3Ewtp4ClzTZKsKVnXJhlMgRE3EK0H/Z7q8a6caEEUHpphJB3MDyS8RyL0V/TmLA8ag/xB0/ZclUuwk56dU57hje7IWUQtTaJFoTWV+8015PVCHxocbsniNhGlGVz920JSxhHoqT2mWtUbIcIT4zqmFpjYEVUK8rWc7jgZQKcQwyndplws0popBIHRD7k3y99oYfq4oXZ3i1X9I6cNDRSzyB6rQnvWHxl8XWR6kKRPwlNsEY9sg142gEqVTUNfHYbirvJNd+6vncXx+Y1UnQcq4aEARNZa9wnbw3u/mZ4hOh3UlgtHtl9ocbL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB10536.jpnprd01.prod.outlook.com (2603:1096:400:29f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 01:51:18 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 01:51:18 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/statx01: Add exit condition when parsing
 /proc/self/mountinfo
Thread-Index: AQHZCh9MmXPX2gXka0myMisJNVZbrK5qZmuAgADBOAA=
Date: Tue, 13 Dec 2022 01:51:18 +0000
Message-ID: <7fe5b9a0-7b90-360a-1aee-c64efd140b56@fujitsu.com>
References: <1670409376-1951-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87wn6wskrb.fsf@suse.de>
In-Reply-To: <87wn6wskrb.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB10536:EE_
x-ms-office365-filtering-correlation-id: 8dc61da2-10b5-40dc-74d6-08dadcac8720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AzE/aBT8xAuenn5wflkKklo6M2QnebTaMCOaxWr/xE7gJgsBv0k5f0B5L9ewTVlzRg9XkmvKmErsz1UIRHNVuX4cp7gD9pLm7V/eIe/CPMC/9wXVE5ujraCDW+Rpwavop25G0NNs6mBWQk51r1DVkRl1izRhQ1CvAMAED/O1B0DZ0ptbkatlcjR1D1HEGIsOHA+ID5wVSkxZPQCTQSwosaBmA4DRdcfc6KPCpF0cSKyAV9LsAgRhrQmMtPsyfsiEdkrKAVSHMYRj2bBaH+xScgmpPQ/7L9kgxaRBADWA6BKZs1HTn6iqatNaRkND9+mnHg3IfxM+Fhp2fo6i5Vimukn3aZJMqQ+NOR6FWsb6E2P+Ia/9XRlhYs/bdDvpck94nVnJRA9Zh1zEPrOp5ayzTBe30VXlOWQNUVYRKehA5q0UEaVGVC8UDUT3eH/EZVmZnDaUB3tsrxDerFIbetxBBzzIeG0VZ3BKb0WL29DAcyxSBeSe9MbSWhfmphLpnsCbcEJAA56sJdUuLStXIRkTxN6rhckrZVrn+cF8AXLXsCPciT77OCQVS8OjhGGylnvf1JGWY5OspOaSsmf96pDmQE34TU4Dw29U917JXMLfQ9nExIFQ5nLEMXERxr3oo1kdjRMsrN/3RvM/skfsSZJC6vN7kmI4EhTyg/heGsCTulmnB6bjuhAT+thOycqREGNeKdkYEZmSG8JAm16yIKmc/RVxeAzpFkV4zqDs4IzxmC7ShUQrlV8BuhEUXgI22wtfq2S95bAIDZrZrp9O3juXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(1590799012)(83380400001)(82960400001)(5660300002)(38100700002)(6486002)(36756003)(76116006)(31696002)(71200400001)(66946007)(91956017)(86362001)(85182001)(2616005)(186003)(6512007)(8936002)(478600001)(66476007)(41300700001)(6506007)(38070700005)(31686004)(66556008)(66446008)(4326008)(8676002)(64756008)(6916009)(26005)(316002)(2906002)(122000001)(1580799009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M283VC9aRW53QTRIQ3o5ODk2UkVzbWszWkpnU3RTRzc0UUNvQS92aldZWThB?=
 =?utf-8?B?SllqL2pxVUlwdkZJREh4N2dEWFM1L2FDUjVJaitSUVJvMThJVlFWSHo1ZnRp?=
 =?utf-8?B?NUh3K2dKTnRCRldZc1gxS0xUbk9rSUpJTDVmajUramhxRlNWVWlwQnBJeEpU?=
 =?utf-8?B?U2dpTkZLZUlHRTlrSEZCeXRmYXVaRTNkaDdZMHp0TTEvMElqL21BSzNSMXJX?=
 =?utf-8?B?Ly96cVZzQVZEMHFjSU9DS3JLSDZEZHZzZzNaaFNzL3ZXbC84THczRUN4LzJ6?=
 =?utf-8?B?VDQvY0oxSmZkck0rejNWRnQxbkxuWndhRkRCbndDTDFnb0NkWTR6SDNzWTlP?=
 =?utf-8?B?cVVGazJqZGNLK0FMc1d6VE94MG1IcjdsOXFkOEFMWUZQVFhaeGx1ejI0UDl2?=
 =?utf-8?B?cEZ1OE1iaGRqSFFDRWFDNERHTTlHQmp4V1Naa3JkM2dWVk5sUEpkRGJVaTNU?=
 =?utf-8?B?aUxPSTRxUVF6dXplRHZrZDJ4eStndWwyaThCY3RQMUhSOXZtOWtMNXVLNnpL?=
 =?utf-8?B?cHB1UW9BdW5mTTNLTzhmLzBwL00vM04rbmdZbTlNRjd2Ulo0WU5OSzBrUEtt?=
 =?utf-8?B?Mzc4MXBuQkZxa1ZwZlBLMUcxbGNld2lLQngycW1ScFR5bVpwOGVCK3J2alFj?=
 =?utf-8?B?cmtWU0hqTGtxZ0krNU5QaFA5aXFJZWkyVE5qbnVuTVpMaFpWUCtxd1BRNEtq?=
 =?utf-8?B?UTBvdzlVYzlTVC9kZVFaS24zdk9FKzhyUjJxSHlwaER3SUVYcm9RL1NYWE9o?=
 =?utf-8?B?R2IrMDVaRkphR0dFVzBMZ0tRVjFxT0hObUVZVEp5VjNDZWxpUWRNZU5nOGly?=
 =?utf-8?B?REpiUHlsQnlweU9WRklQNzJqZXRjYnhPNVEyTWlJTWtIMVVOaDVrcW5Qay9N?=
 =?utf-8?B?MG1jMjFKZFUzKzdjdDM3Wnh3VFNhN0JCNEU2b0NGcnU0VGFnbEI4T0Z0aHFq?=
 =?utf-8?B?UzdYekJJZUt1RmFoUGxjVlJXOUNLYzhHQ0Y0MDQwSW9TT2pZZVdPSmZObzcz?=
 =?utf-8?B?bGQ0ZlF3T0toWWZsWEdOc1RiRmFTd0toTk9aRDJGZW1Mb1ZqQ09WZGlrbW56?=
 =?utf-8?B?SUtjeW1mVjFFWGpaK0hXSUp3c21uSUF6cnZqVDdVb2gyMi9UM1MvMm1EVDFa?=
 =?utf-8?B?SE1yK0EyMHlxWitLbTRPeTd4RDYwOEQ1eDZJVjF5VjNKMXRkQzRPaUM5RTY3?=
 =?utf-8?B?NGxwZzhOOG16NmhBSDR5LzVwdGxwWkhPaVpsNEQvVWdLZ2gyQ09mNXVxZkVS?=
 =?utf-8?B?RS9ZTTl5RWgyNzhxQlVCblNPOW1XSndYb3B3eDNINFNwS2JuZmp5d3RhQ0ho?=
 =?utf-8?B?cDhBRy9BUGFGOVhvVUVWQlJwbFlxbWloSzZxUUo4cFVzMExwWEd3UEVvUDc4?=
 =?utf-8?B?bUdQZFZvRkk4bG9YRCtRemJiZTFWbFdMZ0lMeks5MVV4ejZ1aEJTUVkxSUlM?=
 =?utf-8?B?R2k3cFYySUJjL3lSaHV0d3BHaTlmVXJvUGdaVTdDdUZ4dzhVckpwYUxTS1I1?=
 =?utf-8?B?Zml3UU1ENlJhSDBsdmY5czhzdngrWXByRW8wT0EzeEF0UitDMVMzcUo5cEgz?=
 =?utf-8?B?U09tTnpqdnpTQUpROGlyTjdPZ3hGaHQ1bDlBZXFiM2tYUjR0cWVraDN5YWgy?=
 =?utf-8?B?VUVXMTE2ZDdlbzZLcXJxZUdJMTllcTJKMEtlUE9sSWUzczl6Q3JjaDNwWFBQ?=
 =?utf-8?B?RGlXQXQyZmQ4dThkNHFtUU4vRFZoak1jL1ZjRDRnYVhzMHlTZXU0eGVRVm5D?=
 =?utf-8?B?NTFNUnVlWGtvQi9zc0pyNktLRmFjbDdJVW9LOHVQQUNyYmJDaWhYN0tQdlBY?=
 =?utf-8?B?bGwwZ3o4bWhpS3hHOStPVVRVNFNCTVdkcm9wT2tXbmFJeUQxVGJ4a2ZsUEdK?=
 =?utf-8?B?VnUzdG90YkFxU1VlT0c1YkQ0SytXZm1wUjQvZWc4UnhYV05FMmxrNVpPeFRS?=
 =?utf-8?B?YlJIa3EwSDRsa1BPbGljbWNnejlOSi8xR0tNY2dKVzVqK3Q5VmFLMGxxc0g5?=
 =?utf-8?B?R3gxZHlqaFFsTkk4WG5WbSt5TEpMYjk1aHBubENtZmxneFFrckxNa1J0MHQr?=
 =?utf-8?B?NjNaTUVvL04rNituMUppdk1hT0ZFZ3hucU8zRWs5VnFNeDU3S2JERENHc2Y0?=
 =?utf-8?B?cDE3U3FtbTlvYlZEZ1NXdlVnS2ZpQ3VLYVgrZDhpZHZtcjMvVkthQ0JRcHl1?=
 =?utf-8?B?WEE9PQ==?=
Content-ID: <0E1810D3A524194E92DAC6DB8AADCF5F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc61da2-10b5-40dc-74d6-08dadcac8720
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 01:51:18.5570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux5gbDjM4iFw/56q0cnl1CyZzbYJcuRh/2AN3ybro0BdIhhm1C1DxWVs7TgwEmvFHCUPJNMViIRhC+KO8PaG1QPj5BMKyFCzQtHWe/DZcJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10536
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx01: Add exit condition when parsing
 /proc/self/mountinfo
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard

> Hello,
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> When using user filesystem such as overlayfs, the current parsing way can't
>> work well.
>>
>> 63 66 8:3 / /sysroot rw,relatime - ext4 /dev/sda3 rw,seclabel
>> 43 66 8:3 /ostree/deploy/rhivos/var /var rw,relatime shared:3 - ext4 /dev/sda3 rw,seclabel
>>
>> So add the exit condition for statx.mnt_id check so it can skip the
>> underflying filesystem and parse the correct user fileystem's mnt_id.
>>
>> Fixes: #1001
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/statx/statx01.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
>> index 60b50958b..931aa60c1 100644
>> --- a/testcases/kernel/syscalls/statx/statx01.c
>> +++ b/testcases/kernel/syscalls/statx/statx01.c
>> @@ -68,7 +68,8 @@ static void test_mnt_id(struct statx *buf)
>>   		if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
>>   			continue;
>>   
>> -		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor)
>> +		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor &&
>> +				mnt_id == buf->stx_mnt_id)
> 
> The fail message after this point doesn't make sense with this change.
> 
> 	if (buf->stx_mnt_id == mnt_id)
> 		tst_res(TPASS,
> 			"statx.stx_mnt_id equals to mount_id(%"PRIu64") in /proc/self/mountinfo",
> 			mnt_id);
> 	else
> 		tst_res(TFAIL,
> 			"statx.stx_mnt_id(%"PRIu64") is different from mount_id(%"PRIu64") in /proc/self/mountinfo",
> 			(uint64_t)buf->stx_mnt_id, mnt_id);
> 
> It'll print whatever the last mnt_id is which is probably unrelated.

Good catch, will send v2.

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
