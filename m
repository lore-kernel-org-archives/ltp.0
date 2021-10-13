Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2236DC433F5
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 06:56:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDD061027
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 06:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EDD061027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFA7A3C0F6A
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 08:56:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 563D63C0E8B
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 08:56:22 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83A23600713
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 08:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1634108181; x=1665644181;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=K90+VM57Dk2w/53RHs/Qf/4U3Ep2XoH+icjUz1QL4us=;
 b=GLnuyWzKdBRYJaBvQO1ivCQ5BFnKhhIs5LzijnUUtKFsLcA96kgmvsVI
 4257F6JoKhNXzuPeZXH5XJfeTzCfELDnNesOHRmk9wOIchsejaxG0Si91
 oZ2qTtdUBa5o6mkS2li6fwhfLn2BRwbPo61uHf5KcwdyFeHmYYy03E0Ha
 tGKXcdbj/urmIqiIc8Oc4G/n3oNj48oyVqHIsESwDqJGOf+/gVjtkMeWl
 RMAxmi37wBkzWgZ1Rd5hdilkoGz9AWrwKbp86BmG33SQ0QQpXyq+Y8aZ0
 FrI7ssmqsAYHNLfNqe9+Mb6bg+HO+wn+ezc4mMU+75hppuMd1M5rWm/jn w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="49405864"
X-IronPort-AV: E=Sophos;i="5.85,369,1624287600"; d="scan'208";a="49405864"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 15:56:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNRqSLN7zFQIyQZQtKfuiFogVWi0sL63yBIioO+Wrr/rbx70WEknIPvPBLef/w0Uy8oyB35x94nfrp6fRsipseXzyM7p0wfJxVmnKKBNA2MFnppCQmROXhS9Ej2Jdajhtu2iPhKAEGNGGQCazUfjaszpkyd3CpDdnlcu8RQlLZ/iciY/KMlukDPehOAbyCvcDX2KnGoaA8KUFJ3nUZlhgSRNgxiy5imCjVtPGc9N8PxKXqso+eyKvMfj+5DE/B2FLxxrvlZO4afBsQche1eRjFutYNKMogFYuy7aQh+SgwKbkZB+7wNG5xwE5/ua4EBGSX9GXPurOZrEoh36qOq6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K90+VM57Dk2w/53RHs/Qf/4U3Ep2XoH+icjUz1QL4us=;
 b=akAtN/ivt0MWxMic9puPqlJrJ/EOchhJ90ojkafSEHW4FxUt0nCzQVCJK1IG9E5dQTMYrDX8JAlnixidFl3jnmtj9CSzN3s8h5083sZnUmvR+/mWXbb30wlHROfDrALIoDiCyG/Jae0VmzSAax+IkyUOjnecAXZOHzjBUZ2IIuf/ays0MCZI3xt/Q12yBpwnuu+W6v/EDpq60+gmX8uimfW4gn0MgvO/E0j4oxQP9wYTLsveYTNdeDF9agWxFURBSCny+jWRJ99ZBEnJQ8baf9gJExgPo1iUnQesLVy5Hp35nr4hE9k2bdgVU7hPhooXaFMHBiHFqN5BaFX9mqB8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K90+VM57Dk2w/53RHs/Qf/4U3Ep2XoH+icjUz1QL4us=;
 b=TTBr+CE7rag8Em7XjT9dQa22r4erC1Y8zinsldnIFLnAzmY7YvjxSaKyGy1bgZYGsenrHJ2LTgAJUGFOzRi1XAANy3drtKbN7vacY9mZJxRIo5/XnzNReP4sQNmGIqY7pSu2+ib25bOteJDAVBOh5uCtWJksAxgnGF8tH3FS6TM=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4831.jpnprd01.prod.outlook.com (2603:1096:404:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 06:56:16 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 06:56:16 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Thread-Topic: [LTP] [PATCH 1/2] msgrcv07: Check negative msg type filters
Thread-Index: AQHXsSWe3XOaOHFkSkK2jE8Wv7+lhKvQnImA
Date: Wed, 13 Oct 2021 06:56:16 +0000
Message-ID: <6166830F.6010508@fujitsu.com>
References: <20210924092111.20012-1-rpalethorpe@suse.com>
In-Reply-To: <20210924092111.20012-1-rpalethorpe@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f169c0c-803f-40e9-b9b2-08d98e168dc2
x-ms-traffictypediagnostic: TYAPR01MB4831:
x-microsoft-antispam-prvs: <TYAPR01MB48312832883A199B0BF06D1BFDB79@TYAPR01MB4831.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRzVw+bR7hP4opC5BMR85yG+46Pq1/hrbknUP+Yk9l+IkOIwBVvUI0v0zYWIDttXrpbxhriqb1m4WHFZdxGC0DetElkKR3F7drSHuCUbgwWCusND9IPT9yVKywkuHD7183zHlRnOzP8hMhV6uP9gcys7PpL3QJ/k3FiPOjWCeMT+xuAuBDE/xu5zjdg1WZyrieqkQ1WJWmCkY+g7Xlwvl1kMHw6ybnpfXTItBNzJ1o3OJuiYiuwaNgoHDa5GkA8vmKggF2fePEHrCF/erwalwUbido2z+/iJbUX5Kb7IuqjWBk0rEfHrafvFv2MG6OS5xCnbisyMm70SeY3stRtToHHseYm+pUboHUmR8HKAoTzMjkKv+TWzrLwOFXbOwArh0T4omPGIZlJXrVgoaDp0kwcGgbxeruJBBSBx8JkTV0xRSRrgsOLPsJLcvd0dZj5E6YcVetSJuSyKUoD3MC/m6femLz6xKUZmlr3qBx9Cx+Mnnat5vhX4Aiu7q5oJbMisKg9r82IlDMALK4tj1a4al15yqPfK6TdtGGyCqUhBBFEB62chZh6ptBex9rPdWye1I4h80G2SopcgX0pcyH+oM6Bc7Ft+5lo0mRCcQ4369yi0raq47jahLDYuMdqGJQ7rg4d4w6VnXruhEsD+3MDFTCwmvTaQgqqoGKrPQbzEsTm9kQhqU5q4gL3tnmh52Ebge88Rs981wPZ95ccg7TYtMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(38100700002)(122000001)(66946007)(76116006)(87266011)(4326008)(86362001)(5660300002)(26005)(6506007)(2906002)(33656002)(8936002)(316002)(71200400001)(66446008)(6916009)(8676002)(66556008)(186003)(83380400001)(82960400001)(38070700005)(6486002)(6512007)(64756008)(91956017)(66476007)(36756003)(85182001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QlBqVTFnNmMwT0NxSzY3dHJSWkMvZVErL2xOUE1QMWlNYkgzZ2x6VWlFM0FF?=
 =?gb2312?B?SVluTTZyUkU2QVI5c3U3ZEd0WkRCMzc1cm1uc2pIaXZKY2didWJCMXBpUy91?=
 =?gb2312?B?Q0Q2OFJZeG8wekx5Rm5LMTFObUlFdk1obFNIZm9XdmY0SFdWT1RINUllOWpJ?=
 =?gb2312?B?Y0U4OWtKa2NCRGlmU0ZSVmZaVWVkZE0zSVpZem4wbzJRMU9ld0oyVFpPQ1kz?=
 =?gb2312?B?NjJHQys0cTZSZE9tNEdTbmJNOElTeVVScXMwbGpWOTlxU0xxVnE2R2RmYzVR?=
 =?gb2312?B?dlFjRk5JNyt5K3JSVEtRWHRSUDVmSy9ldXowTEFzS1FuZFM0TC8yV3NtTXRG?=
 =?gb2312?B?WEY2VWJYZnVmQ3REZmJlTHlLMEtxUUVsTVNJUXFsZlRXUCtBMlBodDBuc002?=
 =?gb2312?B?WlJRUUdScjhCdWoreFByeWNRWlVZUzhNM0FuOEkzK09DY0o5bnpSb3ltQk5N?=
 =?gb2312?B?Q3VBOFpIeCtJallwTmtjNkllZ21LODdtK2hKcXlsYk1XeXV2OGRxU2R3Lzdt?=
 =?gb2312?B?UGtmZkZTM1VaVHJDV1JUL09WOFBxYTR0TWhib0s5aDhGR3F4SkhIUll5cmhK?=
 =?gb2312?B?dlBXTnJha0hLR2JVNjlKdDFYL081blY2YnNQMjZBWTg5bFNPVmYvRnpRQThw?=
 =?gb2312?B?WHk5dHYxSWJxN3kweFhXZGpoMUpGZUMvOWRSUGVlejRnb2gyTE9MWkZsT3g0?=
 =?gb2312?B?eGo3ZENzNlBhRkIyMEh0Q01LV0ZGN1ZRZE1rV1ZOV2phcDY2L3RKOTVwU0xt?=
 =?gb2312?B?TVVqc2FLYk9KN1BkN05jcVdXYndVbTZROTdnbHdlWEYwdEtXWVhRb2lRQ1RO?=
 =?gb2312?B?Um9CMEJ3K1BQajBUY1pGOFFVZ0N1UDVkR1hPaml5citORFlGV3ZJb2Jwbmor?=
 =?gb2312?B?SHFtdTcwS3JtOTYrTCtmVWRPRWQvbHlOOFFTZFhjc0hLWFJwcndNQ3RyTGxk?=
 =?gb2312?B?QUdIV2NoOXRZdDRWTzExSUhmZkJLdEV1ZzREODZTdUlST2lTVVoySE1kazQw?=
 =?gb2312?B?SWhGbTlnWS9oRUJhYm8vWUxRbExINXNHWk8zR0N6WU84VlgxcXhuNVc4RGJu?=
 =?gb2312?B?dnJMNExBUEV2Y2NFanZQQktxMm5lQysxd1RERkU2VGg0TEVJSXNZTTVZZjdq?=
 =?gb2312?B?bm40KzJyRG5qaU5SNVZ6SG5pUzhKS3hmVXhhdGhjNGJEVFoyVEQyWmlnMmZQ?=
 =?gb2312?B?ZExYbXZaTU11ajdVY29CZzVtRFpCaWFQZ21lOUhyeGVVdVQwb1VCQzZZcklY?=
 =?gb2312?B?V0ZtaHBYNzJhZG95VkNHZjJBVWZkUUEyWTM4OFBxRXZKbTQ1RWFHbk1kdGIw?=
 =?gb2312?B?Q0g3VHU3d1MrNldvMWhuNU5JdVF6VEVkK1c1SEdTTUFHNk90aWhXVG9wcFRx?=
 =?gb2312?B?V205QUpaWkhmZE5DL21hU0thSVQ1bi9LOTZ0YnpFczk3c09XMDZFVlJDUlY3?=
 =?gb2312?B?OGZtOTBLTEs2UEN1NHdQaFFwclVESmJER2V1ZGRUYlo0dDk1QnRja1FiR2FK?=
 =?gb2312?B?bHl5NUJBUjkvbVJPZy9BTDMvNlRhSkxFVU9Tdm01WG45bXd3cTRodVpYM0Zu?=
 =?gb2312?B?ME1BWWQ5UWs2cGZSTHEzTmJwNnpvemQxSGVJTTUyc243dVFIV0VJNFdHd0d1?=
 =?gb2312?B?QXM4aTI5Y3Y1MFhvaWpvbkE3Yk9iOG1BcWUrN2JMbkRHbmNFcXJhSVBTYzBy?=
 =?gb2312?B?MzVEL3JzbkxyUFJ6ZkhXaDhEUEttbFpuMzBJM0RDVzBSK05aWTl3Yll1ZWc0?=
 =?gb2312?B?bFkvSlZuQml2dkF2azl4L3RYQUF6NXExMVByTlJKVE4zaFdXMjZIa1hSemJm?=
 =?gb2312?B?TGtqL0hGUGhycmhPVXdoZz09?=
x-ms-exchange-transport-forked: True
Content-ID: <8C427B3B7FF53244AFCE987F6FAA7A6A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f169c0c-803f-40e9-b9b2-08d98e168dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 06:56:16.7682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7SrvfqxiAeaS1eJybur5S3JDbElwsvz5NDDqHX2Sg4a2+9p4vN22zJtulpFanfoLgvz5Dj19FwX+4jZUlG5rERctwuWIoAYDZ2UYqwTXVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4831
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] msgrcv07: Check negative msg type filters
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
> It should leave higher message types on the queue if they are above
> the specified type's magnitude.
>
> Also check what happens when MSG_EXCEPT is passed with a negative msg
> type. This behavior is unspecified, but presently the kernel ignores
> the flag if the type is negative. The motivation to check this is long
> handling in 32bit compat mode. If the msg type is not sign extended
> then it will be treated as a large positive integer. In this case we
> should receive the remaining message.
>
> On the current kernel under x86 the test passes because the system
> call has an explicit compat variant which performs the sign
> extension. Otherwise it would fail.
>
> Signed-off-by: Richard Palethorpe<rpalethorpe@suse.com>
> ---
>   testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> index 2c687c5c8..8635ef7a4 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> @@ -232,6 +232,13 @@ static void test_negative_msgtyp(void)
>   			"-msgtyp didn't get the first message in the queue with the lowest type");
>   	}
>
> +	TST_EXP_FAIL(msgrcv(queue_id,&rcv_buf, MSGSIZE, -MSGTYPE1, IPC_NOWAIT),
> +		     ENOMSG,
> +		     "-msgtype didn't recv next lowest msg");
> +	TST_EXP_FAIL(msgrcv(queue_id,&rcv_buf, MSGSIZE, -MSGTYPE1, MSG_EXCEPT | IPC_NOWAIT),
> +		     ENOMSG,
> +		     "-msgtype (with except) didn't recv next lowest msg");
> +
It should use TST_EXP_FAIL2 macro. Other than this, look good to me
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
>   exit:
>   	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
>   	queue_id = -1;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
