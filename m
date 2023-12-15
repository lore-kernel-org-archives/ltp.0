Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA431C4332F
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 06:05:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFFE63CB36F
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 07:05:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 364A03CB3E0
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 07:04:45 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1FC0E6014F6
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 07:04:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1702620285; x=1734156285;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=7Jm/N1YeyN4EivjrI7IBNnIl5UkIeBpZ2MmbDuEZirE=;
 b=EqdSilLt8gLu5De+FQSuALkPSbeO2XoaMNxTN6hEUe+527DUetn6uDn8
 lf3+Dbn3ruvGawyPqqyaa5uQRnpBEzCHata+uuXht9hHCFwMJQi4xWLQs
 Z4oVLbJU2CdQDI3QMmZYhOVg2DZ4s30+TZAe1RySP7gCVtoa6rXcjWSdr
 jA0PdFqXmBQqsf5oDmTgE75PZAUE6EqmQoAleJ90NKASP2iKxd1SDb2ka
 d3NoGjlCsIfCTFmvSSxHVauMSy0+nu97i5PA9N0AOuGYf00bkX58kDHla
 o8npxIfaoViDItP5+6bN40Mz8RTHl1E2xiSfv2ts56Z89nmtiDO70E22M g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="105835155"
X-IronPort-AV: E=Sophos;i="6.04,277,1695654000"; d="scan'208";a="105835155"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 15:04:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V76EOXmDhg3t8KmK5GqDS0xefDJDGEQCtjAuki7nAxFBhCG5Ve50wjeQzG0kv7qmVcaNPrwm1oAzMz5UuWqI6xulO9Rge+mKHTtOoSfndMd8bqpoMCKyyS8ZPsUDWw+bDZEPSytOiJlZNxQUIf47CvmjC6jCBjrdxn81qSFz093RRkSE5Ry3c/pemZ7KX9kLjhGoyKqQfISaUKVk1YY26Obg0gMu7UvwNYAIkQokQBWiLNQKkLNgR56QfcSFwzAmNKUIO0eQXaFmIc5kcPdQk8BqGf2T7ImmZNrr4MUhMsOmaTUGv7m9CZLgaiiyg4E50hqAxD82nLvw1dcY0ISqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Jm/N1YeyN4EivjrI7IBNnIl5UkIeBpZ2MmbDuEZirE=;
 b=NZnuuhswTUGAsXuja7xWPE9c77XGvCVs1UZLnbK2VaKfDB7KEWl3efekeYGlbeCYI5xTlqMVglKNFMQ4xadrFnGV8maP256qbhIYxKUjzWIaP7piHHGgZYBw9Jc4magkvyslLaIzVCvbN/cvHjykUYcRBIoNUNRLSz0XwJb00xKXio0QOK65Bu2sQQIRbhpDZ93JzJA8xChBUbngcYwJcjQ/79+NoSsB2mKMFF1FKdywJec0ehq327ZvD6AGVF2xV06M6LVK40TRnPUG5+eZ/fQtOcqrHIf45rmOm4RSa/CSwGUjjc4P2ZNcqt1ZzuSGX7WfpQ+WB/pL6ZSfahebCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB9608.jpnprd01.prod.outlook.com (2603:1096:400:19b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.11; Fri, 15 Dec
 2023 06:04:40 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7113.010; Fri, 15 Dec 2023
 06:04:40 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v2 1/2] swapon.2: Adjust decreased value under
 CONFIG_MIGRATION
Thread-Index: AQHaJ0SI9z6kOrCo00G5/4wPUt2mKrCp6qQA
Date: Fri, 15 Dec 2023 06:04:40 +0000
Message-ID: <03fc8738-f3b3-4caa-ab76-49883814ac3c@fujitsu.com>
References: <20231205063017.68690-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231205063017.68690-1-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB9608:EE_
x-ms-office365-filtering-correlation-id: 1e8d8161-c777-4046-4940-08dbfd33b9d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8u3XQlpfTAUcfJoNfn8BqsxCyraWmGrItf2165ZI5ASIfFDTLZUXjzTX9+i1D9Ew2W/G7PPuLOz4W4v5NEfEI2UfSitzz08/hXAlQRhnCbeTX+v7dxzN/ZtQkxbNtQVw7onyT8gE/2cEiBysG2U2HODZVaqAe0AIyipWHyKiItZPhOwSJc+1JrSqRzTbXalo/Fz3uSNqNVxq+zfPxVrVF2WXTjbErGz1ThW0hLMsCGzBU7VRgHDXp51HJa17By1i+ggawTVMfoLsJZJt1D0G3uXJdJEyxVmPUh2MRVqrj46VdwAVzUY6PDGeEZjz+3oZiPZ07ESt5hJsqqtC0DjXZL0Sd5Y41o3TlwcGBU9qMHd1FYgY6PZfFtGi7NSPWdjtCu9ybYrDXwNbSMsY+kZXE3aC05uz2LKBUjggmo8bCgmXRdEpzFRLaTZoF7iu/k8RM5On1iIS7N/owp7Yp5mxKjTG2oN7rdwsdcyaK++9avdXKGmbBLBMxfs018jM99lTBJ1BTVhkojEjfB7KGpZ3aZlP3HZKkAGVzGnJFUQywfCpw634wwWAFD7LefchDRh9eLEUm8Xr5Ov/p6MSn9N9YatT4Ak8e6Jrfj1eZDjGfAu0hP1abzb3soRmubl7dav0gGo7Cb68/WX/G8CboBovaQbGj47pvAJu4XVXAARz0Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(1590799021)(186009)(64100799003)(26005)(2616005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(41300700001)(2906002)(4744005)(478600001)(6486002)(8676002)(8936002)(76116006)(91956017)(66946007)(316002)(6916009)(64756008)(66446008)(66476007)(66556008)(82960400001)(36756003)(85182001)(31696002)(86362001)(122000001)(38100700002)(38070700009)(31686004)(1580799018)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG5wNFZMMmdUbjlnT1RjNDZIQmlIeldUTE5mK0FHRHVYODdMUGdSV05NQWV2?=
 =?utf-8?B?VVBIOTVUeG1JN2RSVlYyQmErZFJIV2NqdmFGOE01WEFnMmtOVzBiUjN2c0k2?=
 =?utf-8?B?WTBZQ1VyOFVTdXBiQWs5OGRLWlVsQm1USnA3OXZpNGIyQVZpSE1nVWwvVHBX?=
 =?utf-8?B?ZWRBdnlONStxUlA1QWxRdm5QL2grQVRoWkNCWFBqbWNpeVhCbjRlckE3cTdm?=
 =?utf-8?B?ZzNEb3lyY2RKSnlVUzdpL2RNRm5DRWNKRXZGS0RNNXVBSVFnNnU2d0M5VkJO?=
 =?utf-8?B?czBHY3BxamxpMVFobWk0UXo2V1g4eVk0SC80c2FDbTBrSVYvWjJYeUdmU0xT?=
 =?utf-8?B?QmhQcGdqQ2VjY3FDem5qaHRDL2FPNVZzM1Z4NzVxNG12VWNQdzRWMFVsVE0v?=
 =?utf-8?B?Q1FobitUd3BlMXZwdU54UjU4dXQ2ek0wWkFaTUIvV2pUaHk0UGhScEN0akpZ?=
 =?utf-8?B?aElVakdVRWFEREUvcWZpQ2QwdkdjdUpjSjRJalo0MWRISTNneWRiRElGNndL?=
 =?utf-8?B?ZnlKdE1mUTBtVWFSSVROWXEvNVo5ZTk4dk5uNEVicGFwQ1dJcVcycnRheStH?=
 =?utf-8?B?TnVWY3pkNnhVQ1VkS2diNCtSWVpZdjYrNldQNnlrMWllQlRYaW10M05XRVE0?=
 =?utf-8?B?YUIrYk1VN08zakcrZGtiN2JuaE9QRjJvQU1UY0wrOFoxMVJaTW9adW5GaWZk?=
 =?utf-8?B?T0w5K2YwMGRCUEpKbkpoc2xnK2xDMnVhZ0JLS05CckdVU3NQMEtvWUhjY3gx?=
 =?utf-8?B?Z0hyVVlObDVxa1QvUTJyQldTZnF0YnNJRUZKNXpNU2hzTnFJak9jTXNtclRa?=
 =?utf-8?B?RDJNRU9kTWFuVHBNRnhvU1hWMTFJMHBmZFBNZkxwZ1pvTFI2NjVrRHNuSG9q?=
 =?utf-8?B?aWIzS1NidEZrWEZBRUpNdldCNGU3S1J6bWkwcmVSdkFsODMwQVZha2d5K1l5?=
 =?utf-8?B?dzZ4OEVpNXo4OStRUHhrZ1Foa2Zzd0VzS2M1ek9XV1RqS0lsS0lMQUtxbGQy?=
 =?utf-8?B?YStneThWZU55dXM4NXAwbWNmeTdwYkxaR0dIMThzUE1IWHUxQkdkZ0gzUFpw?=
 =?utf-8?B?M1JzNDJUTTFxWHJJVGFtdjRWb2l3OWJ5bG1jdnNrVGJiYlhZemUwZGtkMHZR?=
 =?utf-8?B?TkVDVUFBa2gyQUpUVDRFQjZwZGlqbVd2RXFucHFoVnJvUXFBTHIxYiszK1Mw?=
 =?utf-8?B?TmlxR0tCNzdoV28wTHVhQ3QzZ08vQlZqSWk0dEc3cXpvdDZ2M2dpNnh3dmJK?=
 =?utf-8?B?eENjcjRLakdNL2xHVTNaV3lOR25IY1lrSUtKZzRUclEyMHBXbXlsYVVVdU14?=
 =?utf-8?B?MzczK0NPNkZHVmZuSzAyZ1oyOStLK0p4S0ptSkFHMGtLY2dSSUp6SEo1UFBH?=
 =?utf-8?B?Mk1lRTloTmVDTVZtWXFsOER2RGVTYng5aldlcDlZUDNlSW9kSXJvT1pKTXBy?=
 =?utf-8?B?VTlsMVRoU0J3K2toOW02cHFoSG5aMVNsbDgzQkZwV0doTk11ZUFVYkRVb2lk?=
 =?utf-8?B?Wm9Da295Mnk4N0hpbzBvaEl2TU9QZzRSb0NXVDRFczBIWS9RYnlOdUJOcWVN?=
 =?utf-8?B?L254MVlNS0h6T1NZSEs0bnNtbVZ1eElxUHE2aEZuNTdTWnZJWkJ2WENaKytY?=
 =?utf-8?B?VXBpTUFCMDRWemtpNG5kdWJGSEswMkVPVUlpa09EbURrZm5taXc5bVZ4UXd4?=
 =?utf-8?B?UnFyS3dkYXhUV1dXcjBUVHdmeTJIVll3Q1RIRDBya091T0ZrUlNCek9pOFBa?=
 =?utf-8?B?aWQvV3JHZE52MDVVS2hVWkRWV3AwVzBURkxRMXk1VWxFYllzZzZMMHJ3WElw?=
 =?utf-8?B?ekpDYmJweUprdTBjdzBDQWZaS0pEVGJWVHZzYnlBYUJIK2RtODVPWXppRWl5?=
 =?utf-8?B?c0FzVVdCeFM5WWFLdVRIbjdtcXErZnNKa002YysraHpwUUNxZ0xXUlM2Q29R?=
 =?utf-8?B?eHJzSXMydWs2TWtmdUxTL0I1ZHFxc3FLN1oxMVZvcTBHRFQxNUZZdU5MbGFt?=
 =?utf-8?B?Q0JvNm10YXIxb0tZOXFkeDlvUjJ4Rk02K2JwdVl1TDMvUEtJeHZkK1lPZ0lv?=
 =?utf-8?B?dkE1Tjd1TWpCR3kyWEV2eHdHUXN0QkNRSkFnWktQdUlURUNOajZBR0pmNjlM?=
 =?utf-8?B?Zzk5QmZrSzBoQkVTRkZvSDhOMEhQdTZvOU9hN1FCZlhjSk9Ga2NaSzZ2MTZv?=
 =?utf-8?B?Wmc9PQ==?=
Content-ID: <574614166935C84BADA3BB480EBEA59E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gq0dqNZ8hpctnpvy/qW9sMwM2FDeDKeW/ovzEm/fo6e9pjLKpZ4YHRIKJFsY6ZowJeOdyqttejPC5lyY1ToIT4shGQFA3bSXGMRdQ0iMApIpjCuGcIskuqCI2Oe17tL97G/nC9vJW+3eNCZwnJjK64+BgzcSKXnux0TcP4gNqyuKHAawSKu8E1X1Mr0jEC2evbMAJ4PuBKaY37loEWaTZ9mxxu/KfP28yKHoGlCIOXw7Srpj4wiXRZbpBBw9py2UAOji9b1g8dObTEjv1/KOHNXmy7S/a55Aac+LxUgMNhLfzMJdnV8rTxJ2jJ9aQYJy3yndwFmySHgqM4u3zDursLznB8sjIGHzTfgcdH6mkU7Yh+hetiBaMk9dCUgiI+z6nJIET8GAXuubwH5lXzkn7aq8AjvXPxbdLMzyyME9A3RE71RGjHwUxSKy6KVzRl2mp2RFW5OYY6oEZ3tdJvkzKJmFbSvvzRfYejK3iAsRd2Ho/33JWe6531tIeBoydluH8pOGLoQYFzRcDFWIvQtDnTu2LW8jIzQhgm6BkfiMgnJnEO+KeYS6B6fTGG9iPh8ZkKAU3B2/YS/zWmkDrxZKjgH1lRzectZP9+7vEjyMbGpxljmtsx7BDLdon4dD5vk/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8d8161-c777-4046-4940-08dbfd33b9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 06:04:40.4893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sF36yj5obEkTC9JrjOQLI2bvbUpWNYouCW3UbTca0e4dLSHp2B3hr6owhOgN+iBXo9LbbPZHigsD60C8PDrVUhh87BSILLBJBVoUBc7cQOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9608
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] swapon.2: Adjust decreased value under
 CONFIG_MIGRATION
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Ping

Best Regards
Yang Xu

> After kernel 5.19[1], the limit is decreased by 3.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=6c287605f
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   man2/swapon.2 | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/swapon.2 b/man2/swapon.2
> index c0e61cbc6..2bc477d18 100644
> --- a/man2/swapon.2
> +++ b/man2/swapon.2
> @@ -164,7 +164,8 @@ Before Linux 2.4.10,
>   .B MAX_SWAPFILES
>   has the value 8;
>   since Linux 2.4.10, it has the value 32.
> -Since Linux 2.6.18, the limit is decreased by 2 (thus: 30)
> +Since Linux 2.6.18, the limit is decreased by 2 (Since Linux 5.19.0,
> +the limit is decreased by 3)
>   if the kernel is built with the
>   .B CONFIG_MIGRATION
>   option

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
