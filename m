Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61247C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:01:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DA3D3C0F83
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 09:01:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFEC83C02C2
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:01:17 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6BA3B1A00258
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646899276; x=1678435276;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=14EDBv9PmcpAPN4rhKN72Y3DT0UApndExaz4qSHASCY=;
 b=l53GQj8SkXSsLbeK2lK6C3WNFfhwQ3+pX35qTYWmvD1pYp2rLkruC6Ym
 1g0Bpw+XXGwv/rBF/gDy60L2Nec4aLbMkvndA+duz4sKYA26gsuSblTYs
 oAk9iHe7C/htzdQGSm14a5NGHcoYs9rV+XQGzx/J3gi4fKxsCY0XYEYRY
 gbMjT/jE61dB8QXbA1FfAye1Ln3O07wLp2AtgLl/wf4ZAZkjHNeWnuqAm
 3jPABwJRHbm2KXb2BXxUEZ4Kfvkocu9OBapm1tUTU5R3i2IaLPdVoZ3AD
 16VH26/IGRa4KHv7pody1t1D7SnbKMzCN0ZZW2tiuOWrEL3FGLY6sxPH7 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="52530129"
X-IronPort-AV: E=Sophos;i="5.90,169,1643641200"; d="scan'208";a="52530129"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 17:01:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJSDMfeQ9Cu0YUAfZli6JXF+B30u4acGBnlW00lRebQcANrhcIAMqHVhCH0/qeN9u2MM77k4qNwlHquFNh6PsNoaFjQtWWON33mKqYlpyNCg6mysIjArJjp+4SAHJlnWdp5lmsYJpERHPn+mCwnK3Q5ceHobwYkvq65t3dXVmP4RfVkxvt/Gq6vkckM/C2uS8sOOFBTYgmDVDurycFWVm97f6oTtKlCoRmuvaOQ4MRraOrq2uwbMAYXPESrv7sROi0wjBzPAg+zyGZOxcNHqJ4bSZPje0W/I05rwCdIfCsX8q35PM5c42snPkP/NO60/o7GuU920foDYDUUuRVTfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14EDBv9PmcpAPN4rhKN72Y3DT0UApndExaz4qSHASCY=;
 b=L6f/NA++aqZ0qglkFPZaqJVbwj51jk5DY+uz1bUnvUvYYAJxAW1axg8t4LNbztmwsdYmyDG6B64iYub38H0n4rYcg+SFrYPJLx0yfaSgCMlNmWS1YJzr6VItlou+Kfu5h9FsRwHRPyxwNqj7upw3roiYrUQ7FeNKCuVMfSOKPe74Lnru8lyF+VAHD94zaHBaF81t9XIUk6d10SETIzZ1CsBBZ3qS4FgZ5mM4NhjRxEBfnB+ybsI3ZRrnFvSqv8tIPjxHxmqaLY2Pib/ouuQQZM1TsETRtdg2KIUkXyXn7H2Y2B0CHlAbZBHCN//YxL1zHpQUceOVA8Xz9lbPhdWYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14EDBv9PmcpAPN4rhKN72Y3DT0UApndExaz4qSHASCY=;
 b=l9+QTYZMuVA0VrdJBUjb9zOMeTV6hnDH/DCY5Sc4Jy0IIt9xAB+ecjQClxtx1U0ZiMtCyjzwk6t2s9f4xHnOGX1Dhmx1BHAzNY247hPgw5YeRMzg6D2zWSFQHsgv7np6n9ZNTv6z7R5a7LFcZ2iifM84mMsabKg4fBSH9IF+6Mw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB7827.jpnprd01.prod.outlook.com (2603:1096:604:160::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 08:01:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:01:08 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v2 2/3] lib: enhance .save_restore to support set
 expected value
Thread-Index: AQHYM2KFc7Y3QL3mZ02VzPjVSH6te6y4PmwAgAACpoCAAAJkAA==
Date: Thu, 10 Mar 2022 08:01:08 +0000
Message-ID: <6229B076.5010203@fujitsu.com>
References: <20220308073709.4125677-1-liwang@redhat.com>
 <20220309030440.4166954-1-liwang@redhat.com>
 <20220309030440.4166954-2-liwang@redhat.com> <6229AC3C.2040608@fujitsu.com>
 <CAEemH2cNzETHwR2Zj-rj+inO7TxaSop+wH2r=CM0fb-3TRYQQQ@mail.gmail.com>
In-Reply-To: <CAEemH2cNzETHwR2Zj-rj+inO7TxaSop+wH2r=CM0fb-3TRYQQQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5de9a7a8-1940-4c05-8f51-08da026c229d
x-ms-traffictypediagnostic: OS3PR01MB7827:EE_
x-microsoft-antispam-prvs: <OS3PR01MB78270F166256CB3589327D65FD0B9@OS3PR01MB7827.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESYeMGdJnOK/AJcFKQpev5Mj8yvVvjShwRpJw1tZ+FQLVAuCqkW8oiK2h6sCuOwRh64pT0tyyJf0Sj9TPAVVrksxWKqWWJDXeqgSOtVYxUuGe5V/BRFabjoqW3OiNGf+57relJH/YeZdUleIOpVsTnjlLIDXp1uqmVoF1SA01rlHBTI+VMo/r7Vppgeja6wt+HHt/4OEw1L02qTg/xVrHcVorlpl7uzqfkcpKV2V4OtFpkPKFoBZqnOhIPWKOSSuis45r5dULwWvOn9xMM06Mc0SnSVPvFF49PRU51AfjKaxoJ1ntTlAHsy6RiCHqIt6yog4JTmBG7H4hhYOR26ks2iktfEO/9nW7xEDourNefJg5YmxHsFysMAWMJv9geUmYYSKRSp8JJUUoenqd8LLZ7nUgon8BHlqU5+pjue0ANt2YS5+qnMK7vdfqljQgUu16ozsh9tWuhQTIf5thZOKR2o2EzELU8NluM0ITV/ihQTXtc0ILwjKWkJqAU3dbqie+osgqsz/V4XdCoA7jeUr4VKX2YpW+QzgnmI2kxz9Np6AyOaLuRP7TBCHpRvab5/0u8dRF7LyC0Fq7LYiMk0DA3FAX2lZYTr1RG3buV8c3SMnT6MtRzqnNA6B2GkvM1r2CuU4DJd0ueUW7beJc2fy9lZhCn/SehICWyTp327EWBKCS1ZJwE6fddoAu0fH+DhujeG0e944fMW27ohxK9iK5KPQARpGMDNODqIPZzFEYexvRaQj13ZcpWXCWa7kzS+z5PcdrrEqSuR7DBVQm11ZWkd+/a4NV89Qt7WZeeZ0nKN9/K+tV/Up2wmqG8WRfgcW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(6512007)(2616005)(71200400001)(8936002)(508600001)(87266011)(6506007)(26005)(38070700005)(82960400001)(122000001)(38100700002)(66556008)(83380400001)(4744005)(5660300002)(8676002)(76116006)(66446008)(4326008)(66946007)(66476007)(64756008)(85182001)(33656002)(36756003)(6916009)(54906003)(2906002)(6486002)(966005)(316002)(91956017)(86362001)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmhXOGZ5RHhCVUgvaklNdE5Kc0ZXc0Uzb1dZUEc1YzBLSitjMGY2Tm1mdU1h?=
 =?utf-8?B?VEJtTmpEK2FyMjcyRFM3QmFkT3hQZUlCUXQ3a0F4ako2RjNWM1M1YnlQS3VN?=
 =?utf-8?B?bGJONFNXNEZNOXVGVW9yM0grZEVTc1Nva0FRRjV6UzNVOHZRRThoODJTdm9a?=
 =?utf-8?B?eFRoVmRXdkJQK0VkYk5YNnVNM0dzbW5aNk42MnBHcWUxNDlKVFl1c0VlRTd3?=
 =?utf-8?B?QmZrSFlYRElOUHMzSlRmYjA1UkxjeGNEYWVEd2YwZTVRNlM5YlcvOGgzdFNo?=
 =?utf-8?B?c09OZ2s0UXBjamN2S01FK01OWHhuS1FDcjMraTlVeUhiZHQzV0NvL0NMRStr?=
 =?utf-8?B?eWE2eFBEN0t2N0JDZTdhWGl6Mnk0UU44S1AvZjJZY3Y0OW4xOVREejRuTEFw?=
 =?utf-8?B?QjZUYjFpUUUzUmw3QlA5TU8vaDduQlZ2YmNDbzgrclpBdDhIQzVOQ2cvc0JH?=
 =?utf-8?B?aThhQWNUdzlqaXphdFV2R1FRTndwZ1c1TENrbkg1d1RkTzBQV2JGZE5LWGs5?=
 =?utf-8?B?ei8wamU2VXo1cFVvQXhvd3FkNGZwNk9hZTN0dWdtWldETC9uS3lMR1RlQ3Fa?=
 =?utf-8?B?TnI0WndJZndId1A3TTVOMFJESjFsSW5SUkk4bVUxT2JrZWQvN3hOYkJEMTZq?=
 =?utf-8?B?bGowQXBXbUl3cUp6VitCOUdrcXVidlZHcDI0dWRjTHpEOGZxTU1STjV3L3Iz?=
 =?utf-8?B?N2xIYjNBYitlMG9Tb3QrSjV5dVNNVDJTWFFKNktYZm9nSnJWV29tQlVHT2JV?=
 =?utf-8?B?d1B1ekVBMXZYQTBNcVVpeTVQTHZhblZJUnhaUlZnRjh0T1pKUnlzTFZWdmhS?=
 =?utf-8?B?UCtHZzFrVFN1S2dOVldkdGlyOUEvS3Mvd0Z2TlZqWE1teUVUMndEWGluU2xi?=
 =?utf-8?B?bW5VR1QzTmIxaThWdngvcE9KN3BzcEhKdVdVTitsSUJRSXBFTitSNWpoemVn?=
 =?utf-8?B?TjJBMFVFcUg0ZFFldC9TUWlMVXloTk8rTngrc2swZlhtTzkwUTROZ2ZvYjNh?=
 =?utf-8?B?eDM0ak9JODloeDFHRFVhMVEvYUZ1TjJFSVB4VDZMMnUxcWxoTFVJUnBLdjNw?=
 =?utf-8?B?cHl0SGdzdTVxU1RkRk9Ka1hGUzFMZWVIYWFUV0lYakRBSG12a2JIcUZzZ1J4?=
 =?utf-8?B?dXE1MUM5enU3S0pGZi9lZUlyVjRta25yOHFuNHZWVjQ3OE9GdDRobCtMeE5i?=
 =?utf-8?B?cEhZV1lqT1gzd1pqRzRxY3hzNVo0cHcwSnpKdmZoMVkrM21HVXZkWDRmR0J4?=
 =?utf-8?B?U2w4TlJzbUdSMnk5aFN2MUw5WVdJekIzZUhlSWlEK0ZEa0M3bFhoK1pnNzVj?=
 =?utf-8?B?bVBCTkwwN29xdDZhM2lFMjVUQSs0U1lJVmhHZFhuWFIrVlFQMjZSOU9YVTlo?=
 =?utf-8?B?bnorcGZiZmlTWHYwcXNFSE9GSEl3eEJlRUswQTJwaE1YZTRZMVhrQlBsNnpU?=
 =?utf-8?B?RnNGWjZSa2JjN2NuM3F2WWZWV2wrNGdQRkhoeEtlVmNNUkNaU29YQWcxZlBq?=
 =?utf-8?B?b05wYVZyT2VMQm05R2diQlZYNDQ0b0hCeHJGNUh3Y2lMdi9lT01ETGhLMXlU?=
 =?utf-8?B?eUR0bTdBZm1tYWpZdUJiNm4wc1lYeU1udTYvVW55MkFqYlpzS1BHWTBYaEcw?=
 =?utf-8?B?SFNFMFEvV3dkbkZsUkxGOXJEdHZxWUhEYnBYU0VyTHN0V2NsOHdYSllsZ1pB?=
 =?utf-8?B?WW85a2w4cnpDUEhaSUlGcVJTVXM2OGJDQm1vZUl6RVRmNThCRUFmMStnNFhG?=
 =?utf-8?B?ZUNVdCtTOFoxZTRveGpQQlRkRCt6VTZiWlZiMUhWMXBBWVkvRWdPNHFiZWNl?=
 =?utf-8?B?Vmo4Z0NPUHZuQkFycE8zUkpLWnEzSUFTTm9kQ0c3R1VQWDFJWEp6QWw0ZU1r?=
 =?utf-8?B?dFBDOEFuM0VBdkIwSFdxa1NsSlFmTWNRQkQ5TFI4dlNnbytSaHN3dkNhQnl1?=
 =?utf-8?B?NldadHlDL3kzNW9pRzU5TjVCNzVCb3pxeXZMM1NZMVltSHR2QkpJUVZDdEJD?=
 =?utf-8?B?STdVb1E5ZVhYSkNhOG1jWXFVZE84aHN2YmVsNkJ0N2c2SSsyNUMrQkQ1dzM0?=
 =?utf-8?B?cjhhaTFPVGdRNUx6NEpNSlJyc3JpeFlyVXduSVNIWGQ5MnVmcE16K3FNZW9Y?=
 =?utf-8?B?WEVYTDlUNWRpOGVFN1VFZkV5QWdkV3J5WWg2aVJjMzREckcrQTVHZXVnNDdy?=
 =?utf-8?B?V05sZVN6M2tKckhqY2JoTDA1UHdIdDJkYW5pREJ4c1lTWEVNSUxkOTNRYVp0?=
 =?utf-8?Q?zG0R4BmEZW1VzodCxvM8Weemxbh9CRZhQzNKbeRrvw=3D?=
Content-ID: <4C177A593A647A42BB7BB444F083861F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de9a7a8-1940-4c05-8f51-08da026c229d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:01:08.4946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8v4B8k80qdL4qBjTQgMFz3HAwLsrhYINYGYg0qmeoHctwj27vYA/hsFAU1o9iAhM0tSb7FXUy0rFw3cZOWM7sOkhtEWF8NghYvf3U7654Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7827
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib: enhance .save_restore to support set
 expected value
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
Cc: Bruno Goncalves <bgoncalv@redhat.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li
>      > --- a/include/tst_test.h
>      > +++ b/include/tst_test.h
>      > @@ -259,7 +259,7 @@ struct tst_test {
>      > * NULL terminated array of (/proc, /sys) files to save
>      > * before setup and restore after cleanup
>      > */
>      > - const char * const *save_restore;
>      > + const struct tst_path_val const *save_restore;
>     Ci complains about duplicate const see the following url
>     https://github.com/linux-test-project/ltp/runs/5491806027?check_suite_focus=true#step:10:19
>
>     How about using const struct tst_path_val *save_restore like
>     other struct pointer( struct tst_cap *caps, const struct tst_tag *tags)?
>
>
> Yes, good catch. Can you send a patch to fix the compiling issue or I do
> that?
Of course, you can do it.

Best Regards
Yang Xu
>
> --
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
