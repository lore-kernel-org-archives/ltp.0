Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA00C433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 08:24:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81756109F
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 08:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E81756109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA76F3C12AD
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 10:24:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6B803C0E8A
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 10:24:36 +0200 (CEST)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 314D3201032
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 10:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1634113476; x=1665649476;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OSUr6OxEietdJqE3fQdu6/hWs9NNv1u1Kk+u1AgvSKE=;
 b=uNlKJcSYObt+cpda5gIoPU6X42ctSS54NdvcGDv6UO/+234f/LEgka3o
 d7ZQQXLFHJH4baXMdmvDq+mFKrwzbwWYGVOvjVdMvjFKXd4IBjQVEpDbV
 pRx6cU4OYWuZEhM3lbBNfT+Fj8FGPs1Yud17+7vewOtXcEv+uDHxC39+4
 bDI0GgspDR0cGyzVVjU3JynmeEPpylH2n+uRXodGrHhjMzlL1ngZzpYSN
 HzQw5+I+BGUKkHPapeuP+Je7TKAQ0S6z3yU3CxI3JfpkSs+U/g+GZADbw
 NyjbFbTgbkBRRZItctoQDaASYaRJIrP+5EEQGCP9AB/hADf92vGO2J2od A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="41336706"
X-IronPort-AV: E=Sophos;i="5.85,370,1624287600"; d="scan'208";a="41336706"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 17:24:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdQlyrm9WDso307Fqsvf4ScM8D0h/LZECzIL+1srEjrrZEER1igpUM79LkYsCW/g1Fuf7pPaU6KH6u+xAbRREIgk9/z7yD/4/y8GIpCcBrpvQm8CHjM1NwaUeIvGz28n6CGCti8roa5aW3cq7LKvzNcIZNEHxwrvafvZfjeOkQg5XA04HgZ8DKkuMA1//WHSFubK4Ev6+c4Q1YZsZzCJ9Cb/kHUOr5idbvIuc3JcQfAcJtPfZ29997c8Py6AyDH4f0ECvlHsI8HiE0cF/mYnL6xkVlFRhFEtYT/pitAAHP7vc/YCY5FzJAiUAv3URTL2xMK7Vo2BD+J3QFWv4Lrv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSUr6OxEietdJqE3fQdu6/hWs9NNv1u1Kk+u1AgvSKE=;
 b=nY7enpxZPWwpUixDu3TyRBeiucWMdbFf5NRFC0HOc5FDeKG0jrUxZxPfG3zm1F/Sv6/X9JlNqP8z4JtoPE9mGMe6S2NFq6GsldL83Dtrb8VRk1JPz6xVVmc2asK6IE4wgoMB8U3GaonGBl9tBfXbH3SpU/mTq64a0EIAGZicdJZxhc5xEpIFu8ZAnB0RFvs1EqNMookDWsI681EMIuIg25BVs+Y7wKrRSEITicsIYuy6OQMykcE5hXSUrMoID7eZ1r1MyXBo8rncbpNsD8p7pq00CN8iQR+5hfTxmhx0ZZgHBGspYVOD5chmiJL6xEe4qtgpTp/sPHm/67QY5sUlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSUr6OxEietdJqE3fQdu6/hWs9NNv1u1Kk+u1AgvSKE=;
 b=rHW3hOH2sKvH73cehz4u1rk7+h8txND6/pBah1sw1bcyhs0RNHBqGDy1nRjCkE2hZUOUkauQy/861scWR0hIjfeX24Hzty52bBQB4sLY5a1cUSc5BycKn4OZK9rPXdGjjCLloItBc5PiDpB6ReyQ2bLkdaTaoXh9TaTducp2UDo=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2683.jpnprd01.prod.outlook.com (2603:1096:404:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 08:24:31 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 08:24:31 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Thread-Topic: [LTP] [PATCH] msgrcv02: Add negative msgtyp tests
Thread-Index: AQHXv0u5xhIKSrD+r0GXr1CPXqR7javQmOaA
Date: Wed, 13 Oct 2021 08:24:30 +0000
Message-ID: <616697BF.4060607@fujitsu.com>
References: <20211012092858.29992-1-rpalethorpe@suse.com>
In-Reply-To: <20211012092858.29992-1-rpalethorpe@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff557b3e-ab67-4119-c4ec-08d98e22e157
x-ms-traffictypediagnostic: TY2PR01MB2683:
x-microsoft-antispam-prvs: <TY2PR01MB268334C27A39F20EA5385432FDB79@TY2PR01MB2683.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJqicIqKHAoNb1Xkp4BVb0uN1f/GU2q9RC1nO0iRJAIQ6nJcC0tEiujqdhNCRpEDix2nrQ9kB+tDmyyg1PwYtEH5SLMTSk7civhxpJAP4lS+ygNqvsFjBw+su3iFSEqdMN59DOM0Fss1ON4ka9PBhgRVzhVvLGFBp7bbTGdap+djRGSeD7ryVz6qVhkJymhesTiV7pD0bHIVqy7682LR3BFXYRgiQhlC67DigsCtpuPz3VzdAN4PyS8hTJGpUGGEfetFlX23AjP+1sLOB2t8WBBv+2ZVuHGkuBETWVcGAwArOS932XsZFVUS/d9eElKhECD/18X0ZxbEbkjonuZSZhsL7z3vA8S6kTBmWeVMM13LNFBs9eVUySSbBolOfwKVDr76rpvc7TdXToAR1zCbNbJFr69VI1I8OH+F4+nepVTsLbpr1fiPj54afBjXhttVlCDbfVouy8bXBYYraaE4lOMwFDt05KvqWtNN4NJgj1uI6oKZ/sS6bI3QeWNEYRHBjLdmXISBZhqkAzDDKKsmObHnkPimIU8+ws/jr78blaKVW0RwdMjih1q3kmVhKekr8uKV8nbAMKXAIROGFDKHi6SYSO2RmSvcAayplIQUqKtGQMhVdt2gbelkfYuNarM7nWBySvdmbhTLbXGjRF1fPCc6Yh6q90ef2/1lJUT+jew20+2oc0cQdhDH4KaI2YxAMENP7RXpOBTWA6Vf3b6XYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(87266011)(64756008)(33656002)(38070700005)(2616005)(6486002)(6916009)(91956017)(38100700002)(2906002)(8676002)(26005)(85182001)(83380400001)(4326008)(66476007)(66946007)(66556008)(8936002)(186003)(36756003)(122000001)(5660300002)(66446008)(82960400001)(6506007)(71200400001)(6512007)(316002)(76116006)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QUFDcmdCR0ZqbWpZbG1DL1ZPSHo3ZXEvNVZFTVhpdHd4S0R6bjF6U3I2UW4x?=
 =?gb2312?B?c0JpLzJNaUhCc1krMmNjQ2tkbU4zQmZWcUNpRm1wbytNRVkvTTZ6SU1DSUVi?=
 =?gb2312?B?TFpxY05qaWJWVnYvV0N6Tk5sSW1WOGhXaUx5ejh1WFRvQmZzZDg1ZWl6cTRO?=
 =?gb2312?B?eXFkN2lGQml0QjlpK2cwYXpSTURkY09MQWNnZWVxbUJOWDBVejFQc0NSbnc5?=
 =?gb2312?B?WGw5WDhaS3pyYVlwc2JjUWtZVGgwcEhUT2E5cit4aXZGTkJoRE1xZmZQTEJU?=
 =?gb2312?B?bHJ4L1lHSTlvQkRMR2pVbXdHa1hNQ2pCSDRBT0t1bVZuM0pONm8vcC9pOTVM?=
 =?gb2312?B?bjFJcUVvUjE2Y0tBYXBlT09SZEtqZGowWFhaRkE3SVVyb3pwOXZPQ3VYdzBQ?=
 =?gb2312?B?MGhYREEwN1FET2N4L2RhQTJxQ0N2MW1STWVRLy9ZMndJMGExOThRZyszNFhx?=
 =?gb2312?B?djBQMSsrSG56Y0ljdStoc3VyMVN1NnNGUlBhcHpVbDRhT3RRV2pydWI4YjBv?=
 =?gb2312?B?VDFSZHh1Z3gxckxPNXZldVRsU2FTSWpFUGFobjRKdkVULzNQamNwZEZPWUpC?=
 =?gb2312?B?cERldUFaTWdyaDhwWTY3NlZTcnAxRHVpRS92N3ZmeTdEZ2NDZlhsd0xlank5?=
 =?gb2312?B?S2JoLzRrSnhKbE1QUlZSdkpPcng5aDBDTkh3cVdBd3BROUl3Nk04NU9RbjA5?=
 =?gb2312?B?THJuSGEvTjVLN29wUTBpWThQcnptbzl1eUZOMTQ0R1FXd01WZU55YXFRbkxC?=
 =?gb2312?B?S1BMbEdnY3YxYjF3MmViWlFNZXp1MHEzZmp0MWpXUkVTelQxS0pDVUljaUdk?=
 =?gb2312?B?UjhKQVUwMmp3c2Y3T1Qrc2s4OEU4NGU2cFhEemRiVUdRYUtYNHNZSzZpMnAr?=
 =?gb2312?B?QnhqR292TGlrMWx3RnQvYVp5SEFUcDdUek1GeGUyc0dDN0k4Z1B5L0UycUIx?=
 =?gb2312?B?TWFoTUUxci80UDcrVm9uRWdlcHFETkhWcUJjRTRYMlVYbENGb2FGc1RDOWFs?=
 =?gb2312?B?Sjc5N1RxdTBrcVU0K1ptTDJlTmEyckNvSUZQNHZhUlltUlpCVmRndlk0ajMy?=
 =?gb2312?B?TjhtR2trRkNHbkFyb3h1SjZJSGhaM2Y1Sk84L0hWS204d1lYTTBKYStWb2p0?=
 =?gb2312?B?dHZ3MGl5em4zZStvUFM3NmZiUTMvSFlnNG5pdXpETjNZZm5tbTBCNlgvNkRW?=
 =?gb2312?B?eGZYY29HMmY4Ui9pV2hLOGZVb1BsaEhvZ0VCVkFWbkFTTGIxMDVBQ0ZFZUx0?=
 =?gb2312?B?L01oQ3ZKZE41cHNHVTVvZWJsY0ZvaVhhMGhtTDNJVG1PZU9PVTFqaytTYVhs?=
 =?gb2312?B?RkoxcW5ZcitQZWpTSzR3MXpHb2JZZjZmbDBHeUg3d3hIbHJicDhua1ZFOVJ0?=
 =?gb2312?B?THEvRlFxMEJlei9KYXMwSHVHOGV6Znd2anpSdUVJb3E2Uk1HbWFKK0JtYWc0?=
 =?gb2312?B?TWRSTElyczhielhqdWlsZmp2NmpMcUJVTXU3dDdJQWloUElFUzczQnVmakQw?=
 =?gb2312?B?R0ZWY3dRUDhWWUx2WUFPdUV5ZFAyVi9uLyt0S1JHRDJEbE91NHRKdkJvN0p2?=
 =?gb2312?B?MTQ1aE85N0JoUHpMODl6RHUyTUtscEwrcUdiVmFLWTVLS28zODdzVFgyRzVE?=
 =?gb2312?B?ekd6c094YW1BS211YjExZldNQnQxaUpZd1FZNTZudGdiRW1ua2lTU0hZaXJz?=
 =?gb2312?B?cGJrNUdQelE5bVp2SFZxQk5Ob3lrYXJ2aFd0TmhGZXAwdVB3T1ZqNXVyQkln?=
 =?gb2312?B?NW4xZmxsTjZnWTQ1NGRuUk4vUnFoUExBaWNkaXpvczU1SUV0OEoxSit3eHBr?=
 =?gb2312?B?ell4MmRwdDdFK0VPRXZVUT09?=
x-ms-exchange-transport-forked: True
Content-ID: <AB55141F3F7B2D48892318916E615393@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff557b3e-ab67-4119-c4ec-08d98e22e157
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 08:24:30.9357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nbs8dBoqP01MiUPKq3f6dC7lpewK4kSLHO1PV8EoXL6OdBdotrhzuz9k5SvGTHyrk5Q2C4SE7TBziufC35ols+GpMHUgN6mUbpgs/LzYumA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2683
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] msgrcv02: Add negative msgtyp tests
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
Cc: Richard Palethorpe via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard
> Test that we do not get higher message types. Also that -1 msgtyp is not
> misinterpreted as INT_MAX by using MSG_EXCEPT.

Other than some unnecessary spaces or empty lines, this patch looks good 
to me.

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
>
> Signed-off-by: Richard Palethorpe<rpalethorpe@suse.com>
> Suggested-by: Cyril Hrubis<chrubis@suse.cz>
> ---
>   .../kernel/syscalls/ipc/msgrcv/msgrcv02.c     | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> index cfb7d7446..fba6a5289 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> @@ -21,6 +21,8 @@
>    *   msgflg and no message of the requested type existed on the message queue.
>    */
>
> +#define _GNU_SOURCE
> +
>   #include<string.h>
>   #include<sys/wait.h>
>   #include<sys/msg.h>
> @@ -38,7 +40,7 @@ struct passwd *pw;
>   static struct buf {
>   	long type;
>   	char mtext[MSGSIZE];
> -} rcv_buf, snd_buf = {MSGTYPE, "hello"};
> +} rcv_buf, snd_buf = {2, "hello"};
>
>   static struct tcase {
>   	int *id;
> @@ -49,12 +51,15 @@ static struct tcase {
>   	int exp_user;
>   	int exp_err;
>   } tcases[] = {
> -	{&queue_id,&rcv_buf, 4, 1, 0, 0, E2BIG},
> -	{&queue_id,&rcv_buf, MSGSIZE, 1, 0, 1, EACCES},
> -	{&queue_id, NULL, MSGSIZE, 1, 0, 0, EFAULT},
> -	{&bad_id,&rcv_buf, MSGSIZE, 1, 0, 0, EINVAL},
> -	{&queue_id,&rcv_buf, -1, 1, 0, 0, EINVAL},
> -	{&queue_id,&rcv_buf, MSGSIZE, 2, IPC_NOWAIT, 0, ENOMSG},
> +	{&queue_id,&rcv_buf, MSGSIZE - 1, 2, 0, 0, E2BIG},
> +	{&queue_id,&rcv_buf, MSGSIZE,     2, 0, 1, EACCES},
> +	{&queue_id, NULL,     MSGSIZE,     2, 0, 0, EFAULT},
> +	{&bad_id,&rcv_buf, MSGSIZE,     2, 0, 0, EINVAL},
> +	{&queue_id,&rcv_buf, -1,          2, 0, 0, EINVAL},
> +
> +	{&queue_id,&rcv_buf, MSGSIZE,  3, IPC_NOWAIT,              0, ENOMSG},
> +	{&queue_id,&rcv_buf, MSGSIZE, -1, IPC_NOWAIT,              0, ENOMSG},
> +	{&queue_id,&rcv_buf, MSGSIZE, -1, IPC_NOWAIT | MSG_EXCEPT, 0, ENOMSG},
>   };
>
>   static void verify_msgrcv(struct tcase *tc)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
