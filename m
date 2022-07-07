Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0931CC433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 10:03:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3EEF3C964E
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 12:03:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 302183C8CB2
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 12:02:49 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3089B60123B
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 12:02:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657188168; x=1688724168;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=P7fQRURTjL7VTwzofD0Mxo3otLGbsSVKU/VLi12dCkY=;
 b=m9oGwHLxOxOwZEhRrOSFrr7uQuanBfOcpTVi9HhnuZQ+ewUP9RpYX7+d
 FpAWv4BR6rdCbIN37F+iMPkAxTEadt/HtfOMlJ+rC81F2juL3oHYC69ok
 Jfe75l7/dPSGZ1egois5TpDok6KDR9ZOJ67sCt9Gz7rmBWZyBmNA+P4no
 CNiT6Mc6fK+HgxkkynvmJP3aGODdXNuVKwyTcBhBQo/OPGZy3S2jtwRjX
 5PVu7n9lJxsfLDm92/2rkoRZa2UorCfz0RQZE3+ojjlPzdVYozUBs/hte
 yopxHrlro3QGyjc98Opr8G4fG4JiOVtqhVboERIu82hyeQIRYLPXRJoIn g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="59980381"
X-IronPort-AV: E=Sophos;i="5.92,252,1650898800"; d="scan'208";a="59980381"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 19:02:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mACJi8/OjsN3wmAJYQ+wpnTUZtBnCMWz39z3yFiPd2VoEoRaQp4FvjF8PYJgZKU1T1FSvTCd5y2jEOtmgWCjXbeJeUpX556Ap45HcalIX8yQFqs/WtFbDyxZDN9uoikPlQD4uXFSpBhjrdkNK7eCKBk40oekqwaC4tfREbINK0PdTzxoQn1QcN99DPhDdwAtMLQOfP7fzznf50No2rHln3udObn6viU5ff5xw67o2r8/X/wW1gilQEF3/A6MPCi0bSqNe2ijiyxFil/Mc+1NbRyZw9dmWBb2pDwgwc7fWjLZtRbdFfInIxuPLgXPnwYVtec38WOoCy6PV1Z6uCbyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7fQRURTjL7VTwzofD0Mxo3otLGbsSVKU/VLi12dCkY=;
 b=LICRJ6B6+YfF+3qAaeyJ5TazIOUXrVQYTvOn0E21FDgQgU1HxfiDoBT5OdTkUagf/7fpAblTkCIm9v1fs3igerVpWvg726pWnhnLg3bt8NRPWUjEgBbjthO7HOtSJsoR0J98s8QlW6hD1WDEW91TPQQWP5tbsrb0jI7dbOHOT60B0sGX2kCw07U2P+gipAa28BzCgA9Tmug98OUMQbAgIx32x9ffvYzwo6m77hd3j/EB4B2j6HftnHQbi9ywPT+3B56SqAlEiIi5XI8FyKOcmanUBX1o9amWjvAcvnJ7ypCO4neg4gJ20ctdZVrAfaGHEbhg6EedeFD8TdRGbOALEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7fQRURTjL7VTwzofD0Mxo3otLGbsSVKU/VLi12dCkY=;
 b=mzYz7eFR/NCgbaGD9CQVEMiO2/twjYstD4rwjN+Mn43MOLhKM/ncExGxu4+wiRxUtVN0uQi/4pTZZfEHWLq7Eam4BOLUuodY0w4LzWJRUNkD4uLDMZZQiNhsmYpD3luhyfOIJVDbBAPXR4Mp7gY7zvsaQ+BfsMzn/sDUor2vSrI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB9509.jpnprd01.prod.outlook.com (2603:1096:400:19a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 10:02:43 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 10:02:43 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH] mountns01: wait for umount completed in thread_b
Thread-Index: AQHYkeVvpj1To9Ct0UKVzebBFftbFq1yvqUA
Date: Thu, 7 Jul 2022 10:02:43 +0000
Message-ID: <62C6BD8E.10802@fujitsu.com>
References: <20220707093845.946230-1-liwang@redhat.com>
In-Reply-To: <20220707093845.946230-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a483397b-e5cd-453d-4e82-08da5fffd5da
x-ms-traffictypediagnostic: TYWPR01MB9509:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SECSKH6UAvJnRuqIoB7t/Ja0V5h+M7hXZ66dryuTOuM8ewmZH3HYgdM5Hz5zAbYIzHTf/lc8o2mZK1IoRPkNEepZ4jQSko+Uz6lGHXO7/ZLqNhKT6RuWl+R7K2iBIfHSGpCpENAkvjbBfBq4T8IiGXq7Np9ulj+Jy+QFabQVdlxXeCtFf0iteuYWAt67lcJXWJZVYVyNr+aQ1rX4rTONzT6/uhcZ78OkSrDWb14Gvh7xDEvvCXggfzkvg1qoyoiBfQZBRAkWL4u9p/VxYyZiB9G3dWY49emtOfyfaJM1jnRDuAFy4uZAfbyKeX66w2uoO8cuKp7P9Uk1xwzTo3/wTOfUOXWjB6jnIb1NaMGi2ip5G6ob4Um8ITND3eBNXDR4OG0ft5nZDqGALa095BnR58aS7EsuvDRNS4nTBrNB/gt+l0MSpsQx2plN4UU8M77GuTcOHjs9X+koIZNafcxzENd7ZDOt3TWGMulB5p0C1T7NCU31cM697iQF6Cip1HL7PlKYYIesBqeyuftH11KMCoNwi6p7qNRHuiPOUIzIPvJoePjpP8TfN6FDofB/n9KUasBt+QyTuCDxcZVgs+NVmVCrxmXwfYvF6xV5+7PlKVMYX5JjgE4z9r3M1qGu5zIeHsRIdtkIK7HwVDEK9NZy88SvItdWttAG3o5kQraHNaOH715Of5nXzf9p58vw70pMmJaps4OAq1S5ER1BpzFt56O+f4mVmwmKasyDIkofKCpRw9wnJEe5EWcW8o/qAAH2T08x43Cr1A/xRIa3PZegku4zM/zaRtgE7N4RD2gnKY7wC4PcfNEhJi070/snKfaK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(478600001)(64756008)(76116006)(316002)(91956017)(8676002)(5660300002)(6506007)(66946007)(66476007)(66556008)(6486002)(6916009)(66446008)(8936002)(71200400001)(4326008)(2906002)(38100700002)(86362001)(38070700005)(85182001)(33656002)(36756003)(26005)(122000001)(6512007)(2616005)(41300700001)(186003)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?a1ZoVzJrb0RXbXBRS1pFc1ozNTBaVWFvL1lxQU5sUFRGQ1hpdjJ5WVNNNVFN?=
 =?gb2312?B?ZURxOWhJa2VQSFo4bmFQdjZrOWlpbEl5bnE2Z09lWmR1eitHL2JoRGpDVXpN?=
 =?gb2312?B?ckIxQ0tCS3Y2eWs0c281a3JKOW5mckg0djNhTXkwVG9NamJxUDhsRHQ4N0FS?=
 =?gb2312?B?YW9JNnp3RnRBdllNaWJOL1Z6aEJacTFuaDZuREY0aStzWlpaM1ZPTlQ4b0Mv?=
 =?gb2312?B?eTF2dmkvZVgrWVJPcG1obHYrMG82emRQbmFvTllYN0ZBWGpjdEVWSDlQT2Jo?=
 =?gb2312?B?WWM3Q3JIV3cxQVRDa1E4RTV1a3pmbHRIVmovKzgwNjIwRUcwZWUzQmthM2Y3?=
 =?gb2312?B?b1lYTmFpdktMN2hzQlZVTUpoOFdKU0NvZElhSmVmQXR1czVXalBCNU00aGlD?=
 =?gb2312?B?SW80Mk00VG9uQ1A1UlZMdDYyNE9tbW5VTU44L0pCSTU0VTFVeVZBSmd3NU5t?=
 =?gb2312?B?T0FrZ285aEJqSVFWL29tc3AzVXhldmdxcE1kb1ZvZGF0azIxWmUyN1hwb2hP?=
 =?gb2312?B?eHpnZ2xJQ1pJSy9uVmRTZFBtWkRqamxycDhvWlNKNVBEdUpWWWx2cmFwbkF3?=
 =?gb2312?B?cmZ6Ymg4YzBxSUhMREt0MFFLV0V1aE53bUFkdHlkK0M0Yis0Z3I2bFNLUWYv?=
 =?gb2312?B?UjVMUWtnZmI2UDZhMFRydWJHZXZUanY5dWVUM2ZGTnFPRFhuRVFXUGpWTC95?=
 =?gb2312?B?eEg5UjIrUXprcE5aMjBLenYyL2NMMW9mNTdOY281bndZUFBXSDNUenczNm1s?=
 =?gb2312?B?YkhKR2ZITEgvME9RQjNSazVDUEdJNWFkUllVTk5RajBEdlo4YkFqVUtWbkIr?=
 =?gb2312?B?VlVhUTAwOXNjT2tkSmZxWlNSemozQnpxMWtCN0t2WitMUXhqSkdDTU01Z09y?=
 =?gb2312?B?YmZKSkZZek9xSkdtSGk0QlNKTUFiUExaeVhyMHI3bFN0UWM2b2NiUDlXVmVS?=
 =?gb2312?B?VUl1VHRtUkpXQW1LZVBpY216OXNSOHJTZmdpZVZUWnVudTViN2Z2dUplRzVj?=
 =?gb2312?B?aEQ4OVhqSDVHYVNieFgwYkhhWUU1S2ZBVHIxaDdza2JnQlNpVFNlYUhWSWF6?=
 =?gb2312?B?R3NPMm40V2c1anNmSnJWUnNXRXYxTncyTUZIODdvRmY2NWM1RzJHWEMyamxJ?=
 =?gb2312?B?eDh5Y2ZCazY0U3JoMmpRVUtQdk9YRzhkNHdJYUFFbnNBUWROT2FXZ2JhQmJw?=
 =?gb2312?B?MHBrZXQwU1BIcVZEWkx1Mmloc1QyTktRbE5ndlRFdksxTEdFbEVFTSt6MjND?=
 =?gb2312?B?TnNtRFRIcC9Dc3c0SDh4a0IzRHdjVEdFMGhNVkw2UUJ0RFp5dTd2cmpqbEhI?=
 =?gb2312?B?ZWljM3N3aUlMR0JKSVlETk5Ea0Erb3F5RzFKem1SOXdlbzVyYy80eWIrMitn?=
 =?gb2312?B?R0NaZlR0b2x3TTFHLytwWGZJY1VoNFV3VmloUmFrS2lSdWFPd1ppUC9sSE5j?=
 =?gb2312?B?NGFKTGhZeHBRbE9QZ0ZGQ2g3ZXJZRWZIVDZreklpYWkxOWlURHRUN3ZJOG5i?=
 =?gb2312?B?UkJPUWJwNysvMWdienVIQTdDb1ZzUld3OG15bUhIcUJZZ2NsdmRTRXRBVTk1?=
 =?gb2312?B?dFY4eS92UlZ6MDVYcmYwTkx6OHJWNGgrM1U1anJvNHNoNnFWOXl6VmdjVVhs?=
 =?gb2312?B?NXJVVzdpUGw2eXh5bGUzU05zRkxsNFI1OGpMWHhJcnd3NXdHQzgxNVd4cVVR?=
 =?gb2312?B?cEtWTjlsek54YisyYXpETzFYQUZkZlhWM1RiSFhLR2wyRzBjcmRIVTM2RVcw?=
 =?gb2312?B?Z1VXaUlPT1dNNUIvVnk0S0xqcXd5MHZHWFMvZk5NaE91SGsyMnJNUERKMTlx?=
 =?gb2312?B?NmUyRmlPMVQxbmdvVXZJVWZIcHZtK24yZHE1dk1lVkM4MlNYdUVSTklkZlVM?=
 =?gb2312?B?RTZyRXZZeVZ4ZTVzZ2ZSenMxY0wzZGVnMUZQSmVROGp2SUZHWlcwejNHdlBr?=
 =?gb2312?B?cnU1K1paMFNuc1JUdWNOdk1aRXhkTk5IVVB4RnJCR3Qzck44aVNFbGI5UWpR?=
 =?gb2312?B?bjBpMWwrVG5qQXBpR0tSUXJHOTVReFZWcHc3ZDY1S2hvaGdwWEFNcDNualhl?=
 =?gb2312?B?MVRsM3dHeUJidy9XRW1La0hXRjlNdWMrZkdDbzRPdDNOK2NUWnJKb0RrMnh6?=
 =?gb2312?B?QW1sTXV2K1hSTEdtbElKTWpkdmh5SHh5NGtGTGhla0hjVE1nbzZNREw5bWVQ?=
 =?gb2312?B?Y3c9PQ==?=
Content-ID: <A20B826B6A78AA48AB761817EEBFC552@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a483397b-e5cd-453d-4e82-08da5fffd5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 10:02:43.5030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4UMWI6dGlwK+nTwogM0WUM3XKnOfFwq3/siokE1eP9kURevNir39uPu6K1Tp3B7W42VRiTvxIp3yy1sCSa9Fzo+AHmo7L7bQu1kP5CHHV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9509
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mountns01: wait for umount completed in thread_b
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

Hi Li

We can also use TST_CHECKPOINT_WAKE_AND_WAIT(0) again,
but use SAFE_WAIT(NULL) is easier.

So
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

ps: mountns04 seems doesn't need to use needs_checkpoints member
because we don't use tst_checkpoint* api in there.

Best Regards
Yang Xu
> To get rid of race condition (occurs with umount_folders):
>
>      mountns01.c:42: TPASS: shared mount in parent passed
>      mountns01.c:83: TPASS: shared mount in child passed
>      tst_device.c:394: TWARN: umount('B') failed with EINVAL
>      mountns.h:39: TWARN: umount(B) failed: EINVAL (22)
>
> Signed-off-by: Li Wang<liwang@redhat.com>
> ---
>   testcases/kernel/containers/mountns/mountns01.c | 2 ++
>   testcases/kernel/containers/mountns/mountns02.c | 2 ++
>   testcases/kernel/containers/mountns/mountns03.c | 2 ++
>   3 files changed, 6 insertions(+)
>
> diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
> index 452fe1d10..3e9c22ce3 100644
> --- a/testcases/kernel/containers/mountns/mountns01.c
> +++ b/testcases/kernel/containers/mountns/mountns01.c
> @@ -86,6 +86,8 @@ static void run(void)
>
>   	TST_CHECKPOINT_WAKE(0);
>
> +	SAFE_WAIT(NULL);
> +
>   	SAFE_UMOUNT(DIRA);
>   }
>
> diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
> index cbd435958..4ef1a61b8 100644
> --- a/testcases/kernel/containers/mountns/mountns02.c
> +++ b/testcases/kernel/containers/mountns/mountns02.c
> @@ -87,6 +87,8 @@ static void run(void)
>
>   	TST_CHECKPOINT_WAKE(0);
>
> +	SAFE_WAIT(NULL);
> +
>   	SAFE_UMOUNT(DIRA);
>   }
>
> diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
> index 5c19a96a9..0d8b86f9d 100644
> --- a/testcases/kernel/containers/mountns/mountns03.c
> +++ b/testcases/kernel/containers/mountns/mountns03.c
> @@ -97,6 +97,8 @@ static void run(void)
>
>   	TST_CHECKPOINT_WAKE(0);
>
> +	SAFE_WAIT(NULL);
> +
>   	SAFE_UMOUNT(DIRA);
>   }
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
