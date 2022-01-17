Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E28C433EF
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 09:19:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01FE73C95EE
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 10:19:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86FC03C9550
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 10:19:10 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E37D200168
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 10:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642411150; x=1673947150;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GR2NUqljJ7yn11qOUOygBEs9+LAan8CYdrAPezDSpec=;
 b=vFM7H305seTHYYeUt32GgdCFcmlZEtx8ntnn88lk2exjeloeU9249tpT
 vVew2c7XgxjDdyUZMvWATE7AXM6bfWzXVYjr/hfUuZbyuseUXAJjRgpe8
 HnUnYQ1xBzShZEXcaEQqq4lGcA41ZcQtWebKUBYJRXUxtkfkFawJGxc59
 AsVU4AFwl0pFc0yOiL7mJPOWNegocj5RRlu2izZ4ZJfTiWVjNcdFgofz3
 MQotcM4vXtCj5mcKS9hlz0kWmsREKrjEmsmgIab8W1genbXJ0o3clxQKQ
 CrNFY7L7aRK2ghXT/Ag704SH5fDz1pW6QUbuPUeU6YsSKMNEBXqIFA2P1 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="47570599"
X-IronPort-AV: E=Sophos;i="5.88,295,1635174000"; d="scan'208";a="47570599"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2022 18:19:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn2mDrGtIL7dmlv6OtW2PGUOVgPbkRX6pFBttDd98bJ0hh80svhtoL7y3DVW7B2HVbb54thhnrymG+Ib2DvEpEdR0j+ZvyEugUsyX/ILdfLaoTyBcOVNhv/5atvba/HXBHnrZIhZdY51rl/g+zgcFVCPdvKMY8eR/PFaTT6sPE/KUNZJT+Z8djAhnvrx0qJYSM8ViaN/FOkAr04X7IVI8T/DI8HFEa/CQEcZ1vxBmR0Hv/bcr/I2T9n2w+bftjk7JLbASzMWIZbQSr+wnwzYwlwuiByik/2P585eRiM2M9EkmnxTKuMzZ/Dmn+bUWDleno20XVdu+05CbGn0SqiWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR2NUqljJ7yn11qOUOygBEs9+LAan8CYdrAPezDSpec=;
 b=eXvaFHmqH+VuamHLJ0JtqezI14p6IsHL0rfnWYGhj3MglXxrA6+dQYMgSZvlrmZ9s6OicV0ECRspRfryJeOx3NmO4StLBGORzTtQKVAW+YzXai3ktUPr688o/ZL0r6+3BIMLA74VmRzkum6u7SRhPg8EMU6bVqok+JOhXX9ZBkwwqrmZ0czqahN0hv2bEgk4AcPOlLe8Hlw2qahdbN5TyChf1oI6ysT8WG7Q6nIw64guc4aQk+QKcGVa9Zth22GvEiNVy3AQIUtWhRTuUg9G0thEfTeiSbsL98Ymi66u1yrnXVz9jry3Gu8z4yR64pJReUVC9DI0Q2Nr1CsXflA0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR2NUqljJ7yn11qOUOygBEs9+LAan8CYdrAPezDSpec=;
 b=kQk/85Q93RftKl640TWM1F/AY8VIHuUbq6+WizO9oC7mrLSmUoGBBb1LSOFx1rXhtZ6VN+cD6nmU1xbMaHr6SfU1pHGu0zoe/AXQnn4LgkAU2dwP2Y/rzdomZpbe5Z6Gb6S+GNBexQ7wZImGwZkfYbhI9wQK6Hp14B0NgrmR+j8=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB9434.jpnprd01.prod.outlook.com (2603:1096:400:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 09:19:04 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 09:19:04 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [COMMITTED][PATCH] ci/wiki-mirror: Fix triggering CI
Thread-Index: AQHYC4G1tma/DnqG50282b381PJzT6xm79CA
Date: Mon, 17 Jan 2022 09:19:04 +0000
Message-ID: <61E534C5.6060005@fujitsu.com>
References: <20220117090744.30354-1-pvorel@suse.cz>
In-Reply-To: <20220117090744.30354-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a64e474c-8037-4604-1691-08d9d99a67f7
x-ms-traffictypediagnostic: TYCPR01MB9434:EE_
x-microsoft-antispam-prvs: <TYCPR01MB9434571585DE2049F18D0FADFD579@TYCPR01MB9434.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Kr4DwWMc4z/HOvxiqb8fHHvOnh+9MOoNKNB7rEOljniaLlJAi0DZD+FwINUT6kMX0RFc/nT5JDOZxRXHQuaBfGsaBR4HNH62/IIok9YLODkunjtO/iSR+hRe9ZH1/IKFP3apgWhMHRiDXeBCZbHW/trwX2ez1QOXsAfyKxPA0av9IiorXR5X4+5KLDzPFy6E+rmP8/tddl/6ParkroDXyQhhgyV6w8QI3Dqj+QPFlioMMZiuBuD2nDvalWNFMuFucfcqI1yOfN8FU25sGzO/9Pf5lBvRaFGEC1hMEqlk9wVjzfkcKlkblywR0Hv+x2T1kuRUJqz0p+g+WLCVD+Y9VClKzWVsp2BqzekQKuvdNOS8YgCeno9BuIcx4Go+otBYqQm4vaoTWEqdj+EEQM9IacGy3RxT0w1SKveHEZsmeE8iTWOr+GpwdJquMf8ZnacFn6Gw2qlUWdzDDvaXxQ//9w15X0DclK2Brj0COaC7bguHhRlJ0EAB9X5+dBOy/+UPZrEVBTMoQ8uQVZ6eLdYDHRmpb/IypLqOj0bZ6Q6pF3JDC9agDX8w15e59m9ttkAZq3C7udhSJCU/4eeTDNop1ZAFn95tncN1Lk9s4HFpt8oDfPfn0U1nbJmPW0B9cYjCkU7FzWK9gA3u3TtqwS+2z1zM4uNNM9LaYaosVPuXNEc6pn7a9e99F2xk2JSWHf2mLZOit/iOeAdiaVd3XDpWXuuIv2V2x/2quJVbnJgMjESg71NnrqEMz8hcB75I0Dw3Vfd/88JcjlnIM54/P9iXNTYD5PEVUXcpZdm3ULrb5Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(66476007)(82960400001)(5660300002)(66446008)(186003)(66556008)(2616005)(26005)(966005)(2906002)(8936002)(86362001)(64756008)(122000001)(8676002)(91956017)(76116006)(38100700002)(66946007)(38070700005)(33656002)(6486002)(36756003)(6506007)(71200400001)(83380400001)(6512007)(87266011)(508600001)(316002)(6916009)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q1UwNkY5RVBORUF3MnlmNlZqREZTdjFLWlBCRUQyV3RzV2lHNjM1SEJneWUx?=
 =?gb2312?B?ZDlmSE9aeUh3RjVxU0ovNm5DblQxejg4NVpOMTZKWDhDb1p3MDlLWkFGUTdY?=
 =?gb2312?B?RUljZkRXc01iNlZQMHVGT0V5Z1Nycjc5YXNhYjNmRUczbGZPblhGZGh3Mjd6?=
 =?gb2312?B?YllvSWJaelN1dUpMTEFxVVp2cEF2SHUxUGZ6VFNXUXJkL21GRmxFVG9CVmpk?=
 =?gb2312?B?V0QydkcySlpFT3pvYlVHR2NFbmx0NmRseW9GSVZKOXFzalZ4WDZqQVNyNjBu?=
 =?gb2312?B?aytXQzEvSVh1VWVaZkQ0REk4Rm0xYTFkQklUcHUwQWhjam8xQ3RNUnE5Tm1w?=
 =?gb2312?B?dTd1WUpPcThYdnpkbXovd1U4MFpPanIwdWxQaHBLQm1rTUp6ejRyVzdTZTBR?=
 =?gb2312?B?NzZldjA0Z2ZLTXVBVVV5R3ZTem5DRkpSTkNTMjllS3cwZzFTd0NweU04Zk41?=
 =?gb2312?B?NE5KS21qcG1NTXE0WjVUOVYxenUvcmNaaUxrM2hWaWhrOGU3am9aRnc5Q0Rh?=
 =?gb2312?B?ZDBMcVdJenMvTi9QTkJ6bWlna3VySytEWjZmU3ZDOWNZaTA3eHZJSDdneWs4?=
 =?gb2312?B?bEI2WFZjQmQ3T0FRTjNodGVhSHRSU0NBQ3l4aXdHZXQyaGJHQVY2S1F1dnUy?=
 =?gb2312?B?WVVMdE5IampjTU0wbzJlN1RwY0p6YSs5a0t4SGRGL2lGRlVBcmx3dDRtL0FO?=
 =?gb2312?B?bkJtSmZKV2JjcXFLL0VOK3FnREVET2hHNUJwMitGcjc4aGVFWUJqVzBqK3dv?=
 =?gb2312?B?d2xqUURySEtVa3lJc3NQNUdHZHgyYlFaaVFXcDZzOUFvRGZxU3RsZWI4ZUZP?=
 =?gb2312?B?d0t3L3BMTHM3bHJLK3o5TjNxdXNrZEUwaVdWRW4rS3EzOUdVNjgwSjJRbUEz?=
 =?gb2312?B?c2FTWFBpUUpCcEZPdTdOSmVVU2laMWVkUjBMU21rNk5Qd3hhNnhnbG85YWVG?=
 =?gb2312?B?WHord280RDN2RjhxaURSdUpVaU5WMThhV1FNNlBhYlMwRFRZd2Nmcy9DTUFS?=
 =?gb2312?B?K016THExTTkzeEVzcEZaTUJvQnJYbHRjeGRZczlMaHdRSDlmOXdPb3lNZXZQ?=
 =?gb2312?B?QlpDcU5qWjZiNzJHVS82d2RaS0U5amd0RVBDMlh5R2FNc0t1WkpDVDRqazZZ?=
 =?gb2312?B?N1FUaVJERWVGNzVNZUhtYmF5MmN2a0VGOGpuUTBKTlQ4a1BIS0d5TmRqbjNr?=
 =?gb2312?B?eTZEdlBsZHFyT2xFYWVvUkp4ei9KR1N6Qm9uMld0dkx6RFhCMVRkVUh2ZFVU?=
 =?gb2312?B?d0FwREs4bll1MThNNldPRGQyVWhCMFB4T3VGdWRYcTgzd2E3cUc3VnVROFpx?=
 =?gb2312?B?QndkcGtpcFJHTjhadE9wMW1ValZxdVFLM0ZUT3JNdm1SRnV5QnQ4WU1lemRH?=
 =?gb2312?B?emxGYkswVXlhSG5lZXdUdDlpeHhFSWFXNGpJUlc5ZFp4Uk42aVg0cU9hQ1lR?=
 =?gb2312?B?dmcvdlYrRzlUTmJZT01TY2liN2x4dGdYd3hZTWJndnR2bnAyTDFBa09FU3Nu?=
 =?gb2312?B?SC8vSGpLZ0NUM1EzQmUzTWdUYkdlYk1EeTBCVm95eTVaeDg0bUtBUTlidVZT?=
 =?gb2312?B?bmVSeS9DZzFNVEdMUHNhaTZGaGJLaGlKYythY2l6SmlGbXU4TktnamtlZXo3?=
 =?gb2312?B?QlE5dm9mL0JieVg3NWU1WEFKWUZ1Mld3dUw3NXdKTzZaNHpnTWlQRlFzSExj?=
 =?gb2312?B?R0g1MWZzd2VpdDZ3SlNzdURDdVY5cU91V2dVMjM2QzViNjF4Vi81bGVzV2Vl?=
 =?gb2312?B?WElGWFVha3V2K3JoRFFBai9YRVV2QXZsWWdFeWo2aEp3VWc1MGFrVmxCZ1J2?=
 =?gb2312?B?K1ZFTW5JUlJwMUpEbzBONkx2OGxOWjkwSVh1dXBrbElIVjFHYVhkMTQvNllS?=
 =?gb2312?B?cTBjR2k3Z2J1VCt1Ykw5ZWJIRU5iOUY1UUpJb2Vwa3kyVFFHVUhSTEtOT0NW?=
 =?gb2312?B?cmVhZk45NS9Rck9FVXZZcktBSkREbHkwVGlDK2lKMmd5dGg4MlpsMmhKK0Vk?=
 =?gb2312?B?Z2lCcDdMeFEvcHJnTE54UVgrcnpiYU9OM0t5YWh4bDlScDN1OG52enZkK2lW?=
 =?gb2312?B?bDE5RkN3WmVTOGpRa3V5a2tRTzh2WW00eWZKQk9GNkk1SENxQ0N5SW9obGM2?=
 =?gb2312?B?S1hEdGg2SW1nOU90TlN5R3JaU1BPQ1R0bzlXRVZZa2w4RzRvNGZ1TlM1bUUx?=
 =?gb2312?B?b2JSZUM1Z0hDSlJEZWRGajJ5OXVoa1hCeWVBeGdRR2cwTW9NWU0zdGx4MHZC?=
 =?gb2312?Q?d2uT9TfxACPfesX8xQUgks4f/whvBXYK/o/Dsvw10o=3D?=
Content-ID: <600ED55D0DEB904BAEED98D85AE1273B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64e474c-8037-4604-1691-08d9d99a67f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 09:19:04.1604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQ4nDro6RRTPxbCClTqPendcn6uwskKst0PqxRAYcrD7GzyQrfaS48AFQ7H3nwHI7Xip7oiPETqPyYzWwcm+og8szjUjslT8vJTI5gFrCwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9434
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH] ci/wiki-mirror: Fix triggering CI
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

Hi Petr
> Matching github.repository instead of
> github.event.pull_request.head.repo.full_name is what is required for
> our workflow pushing directly to git (we very rarely use pull requests,
> and not for big changes which includes doc changes).
> 
> This also revert 820cfe539b as it didn't fix the problem.
> 
> Fixes: 760fdf3a8f ("ci: Don't run wiki mirror on LTP forks")
> 
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
> Hi Xu,
> 
> FYI ba99b81708 ("doc: Fix typo missing s in .all_filesystems")
> verified it's working:
> 
> https://github.com/linux-test-project/ltp/actions/runs/1707090366

I found this problem when doc/* patch isn't the last patch of a
patchset.  But here it is a single patch.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
>   .github/workflows/wiki-mirror.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/wiki-mirror.yml b/.github/workflows/wiki-mirror.yml
> index 302667255b..36c7d8311e 100644
> --- a/.github/workflows/wiki-mirror.yml
> +++ b/.github/workflows/wiki-mirror.yml
> @@ -11,7 +11,7 @@ on:
>   jobs:
>     mirror:
>       runs-on: ubuntu-latest
> -    if: ${{ github.event.pull_request.head.repo.full_name == 'linux-test-project/ltp' }}
> +    if: ${{ github.repository == 'linux-test-project/ltp' }}
>       steps:
>         - name: Checkout LTP
>           uses: actions/checkout@v2

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
