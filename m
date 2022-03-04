Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCCFC433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 02:57:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95E943CA374
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 03:57:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A5DA3CA343
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 03:57:16 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1AAA710008FE
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 03:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646362634; x=1677898634;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HhzpoUJFp/+ZK/TeDe5n9TZ5+icXA+Dwkp9POrUm7TA=;
 b=pD2xjOv9wMJyjnfa5NpdWcjNlioNEKXCi24vHZvRnrMs61tuBh0XB5c1
 yvzw1Y+Th/vSEmzr25gel7dlLuGJxNCFObxGAz8QMYQqkOO8cidusObo2
 3CPBjRWvZ8+pokvfNK4R0lOyh75a+aaejTXT9yhIUf46PYCCDHAZbdA7/
 pyEBbfcuYHlEqqff8QnRpH70POLc0sKWtN+tAzR6T5eIjZcn/b+24411o
 AR0wxrja2tPr6+ppJNyftUXBEPY6Uq0tdCPrQ3hCRzXLFGuMbaht02laH
 pMY1WSi2gAcUG0TyIXRNz/IeaGa54mAmr1yCAP/Nrt7nht6cWhPT+0zPe w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="51293592"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; d="scan'208";a="51293592"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 11:57:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SphY8294MD0j3gfdW3lFIdjQZSOh9cKlMYqYVJk54Iwvu/uJM9XLCqQQy4E0d1j2MRWa6ESQB+eW2RsgUMDcYZkMMCiXwIdNoBGu4xLOXDZSCo4/BvyHxYVD+slZtGr7Uv85ThNOqgXq9V51mhEo7ZX7UZRSCkvEQCUsDDez6OGG0TI2Hr+dP2kHWC4IBiXEU8w9+CNHHtk+GlbXI8vjLYgZmzVLBWP3LpCs2Qt1dDAJK/a8aZ3WYUE0X6LLYnJx9+sWhmo0nbEfHIfT/cI2d9aoxvKXKhJBFtVs1i43AUatvRjsVezrPLmdkwYLy/J1YfyXIMpnfuSh1ln1ymblaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhzpoUJFp/+ZK/TeDe5n9TZ5+icXA+Dwkp9POrUm7TA=;
 b=QyFM1EosFBe//EsthmHWSNdFbfLBeLvpHtC2kwSdU1jaQ/l8pZJYVL3ZaMwOqSX1xnped6Yi3Q8VfYsqbh227WS5kQxfeCPg6ONs85EbwEmKxczZqY0HW/h6ON17RjLLzDz1XNz2SYjml+a1yUIjeztafo0gYOC6MT+ewP/7XQXSGqh4GLArpXhAkP1PsZBdgGYeHyj+bY/bCamEluZUWbcOaBeOS8pWBFhkZuBPXUaP1MqxlgL+9ZxpvCvigLGGpVsaIS1Niz5FMBS04drv+IzyGIGCsy7XlrQpL8qKZevhFTM5kBTJTGVnF16pIsU00VMNucEd/rLQsd9fjGV11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhzpoUJFp/+ZK/TeDe5n9TZ5+icXA+Dwkp9POrUm7TA=;
 b=b4qFGrW4BnMq0NHhNsaY+HlO3j6Z6MSw4c+uQKhv992TWmdff9WxfWXREZJWYlpIB22MKRE376G7CrALSknVAGX31WU+VGFY2dDMQnNvwOpipjPAdHqLCA/lfGpZr4aa/gJRWvOk7JRdRBLs+gKteH0zscRw5C2b1A0M5L+SdBU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB5639.jpnprd01.prod.outlook.com (2603:1096:604:c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 02:57:05 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 02:57:05 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
Thread-Index: AQHYKMqkwUNiAx+MtES8Pjk/+VcXKqyh76iAgAulKQCAAQDrgA==
Date: Fri, 4 Mar 2022 02:57:05 +0000
Message-ID: <62218039.2070903@fujitsu.com>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz> <6216E3ED.1050700@fujitsu.com>
 <6d0a36c3-d317-b942-71b1-0c6fecb5c3e5@suse.cz>
In-Reply-To: <6d0a36c3-d317-b942-71b1-0c6fecb5c3e5@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32e5387e-a94a-4af5-f4ff-08d9fd8aaa53
x-ms-traffictypediagnostic: OS3PR01MB5639:EE_
x-microsoft-antispam-prvs: <OS3PR01MB5639B57132AF8A0761678CF1FD059@OS3PR01MB5639.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tkkdJ8o2dc3TeNUdU/bj+AbGF2Tmh664SYWTQSsk+npZumm2RjcB8Ycja+IYNCwVxf//bNHgJTLe/OIA0Bs+zt/ILqUGW6cau39JyAkuOFr4klAF2XwowhOfCFTwrLoN1QXWp+MRGtbJFNs8/NnkVpBbiv/SVRS5k8lQ10uX46z0ih8i+WlW796CwVtIHpfasOStBvXsPgJ4LGHLXt3OqXhTNbYf/p0FhkTcR0dEwPXh2VcJAGn6AQMFY/x1S5sE9vdMyKjWsQCZVLttUwYgUQElL5w/h5qqLsXZNUaB2P1MR7EeM///yIHRqpDvNgQfHnAyllZokdLExPmLosaXhE0anIoNupAF7ECT/CbIgkKRhGLLXwg32RwMN8vh9+xTZIHAe9mR5VRPaN/ZlZ9V9EKSf6nKEVOYsF4QNKpEkITiS4p+0gApV7UubhXfDWrSHWIKi+X9vtFdvHHEzooE83GN9FazOpIQevdO8uw1jip5E52of9qdQp8pyP2OqcR8sGkBn3bLERFH50vf1iAeZHKpQRK4lxr4mCis89kwydRbboC3eR8GWDmQ/JILNDJQVZ5lVkJDd+oimraPCDCPH7Z18ehcsUeiQuXySueP9/ToonD2kQpN4/ynsOEVF4MAhBrxNGTBJOSkHPodJe9EV9stCIhIm7Of2yRaxuCybwtZvOCMkWAygHlYgZqikr38XiiCrC6OSf1fwE87hh5F2d7YE0LZw+ppVtZ9o8l6ajA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66946007)(82960400001)(64756008)(66476007)(66446008)(66556008)(76116006)(4326008)(36756003)(91956017)(38070700005)(5660300002)(8936002)(86362001)(2906002)(122000001)(15650500001)(38100700002)(83380400001)(6506007)(87266011)(186003)(26005)(2616005)(6512007)(71200400001)(54906003)(6916009)(316002)(508600001)(85182001)(6486002)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUJmUDJvSmY4cEhOckpPZFU4a1lYaVYrRE1HYzZpMWlSZW4zT0J6c2RmMnZX?=
 =?utf-8?B?bXNlRW9UOEJEbTNseWNCb0xyRDdZTWxDb3B1azMzQU1GeHhlWlhBQ2Nwd0RM?=
 =?utf-8?B?U1N0VSs4ZituRE9WbWdtdzdzcTBEZlBGcnpXWGRoZkRJUmpZYS9wY050eEtS?=
 =?utf-8?B?aWd0OXBHdmR2TVNMbHl4cE1UckR5cTkwYXN0YnFwZ0JRRC9icEZPd1E2dE5D?=
 =?utf-8?B?dUhybWppWjAxTElDUmxqejl1Z3B0WXVuVnhGTEVNUUtCeFJybFVQMGVrb1k5?=
 =?utf-8?B?S1hVcFg5alg5OTJIbStLa3NnbmFiQm1CeGtxbjRLRXRhaTdveVBKblZQUVFT?=
 =?utf-8?B?T005cHljSWptbTBXQUs3Z3lhZUpDNTU2NXR3cFBjN2UzcGxZNTJUeWl3dmkw?=
 =?utf-8?B?MWEyZDRMTWdRdEloZUltNTJybnVuQ2E0emdYa2wxbEwyMDBrWE53Nittd2M4?=
 =?utf-8?B?aTcvTHRYNSsraWUrZDBucTBtbEFjaGRTZWplYXB3aDI4T1V3ZU5MUitYNEZw?=
 =?utf-8?B?V1Q2eG9JRUZLSTF6RjhVcUJZY1lSWGhWKzdZNC9ZaGFTNmtxckFmZUNPN1N5?=
 =?utf-8?B?MVJKUGR5eE5sT2JGaFJSS29mdFpCcG5EMlJFUW9tTW0wYXVzck45NW50OFM4?=
 =?utf-8?B?TTJiNmQ0eTlwSWF0UzZ0Y2oxcit0UHJ6M1pSczRaMGw4VjZvbG9wMS9EMWZZ?=
 =?utf-8?B?VVZLNm94akZFTjZsY01GYXIvOURZNU1RTnlWRU1vRTd6bi9BSDhrMjRVOGNm?=
 =?utf-8?B?Z1luTFpwZCtQWURnazd5Uy9yWE1QSnh3MHh3T1RKeDdpc2U3YWRYY1Q4aWI1?=
 =?utf-8?B?aDhydGhtNk9URFdtamtzaWZpY3BhT2ZxTHg0ei9WY25EbElvOC80K040ZDVN?=
 =?utf-8?B?VUFxdHpzZXNBeWc4ZTdqdThFaFRaUG1sYVRyL21MTlM4UGlodnVMYjd6TVI4?=
 =?utf-8?B?MDhFRDVVT2huMnZwbDl2NFZaT2xtRCtPZFRTRDNzVkZOM2VHbC82dFFBVktU?=
 =?utf-8?B?c3lSSkUvQjZTSDlROWMwdUR2eHVWckhyZWE5KzFMMFMxaWZsVDIwVlFzTGha?=
 =?utf-8?B?TzFCd25QZ3JHTVh2QlB4NGszcUxHMEJtYjFNSVlEb2VxeTdoZGNvbExYK3A2?=
 =?utf-8?B?eFdQQklYQjNtZHBkR3JkaVppRjRxYW5sbDdrcVlmM2xrVUIxeGdUd0dMZ2JN?=
 =?utf-8?B?VlhGRyt1cWM0dEpEckhwcUlhYnJVc29pVklyZ3VxVllFTnAzaFBsNk9vVGVj?=
 =?utf-8?B?RGswK0syczhLRlpjS2dFZWxERDlDR1Jhb0J0Wm92N3ZFeGJtL3BwVGJjdzRm?=
 =?utf-8?B?MGlYSCticWxmK2JENVVuMkpydzVWZGM2VHdYOVFLL2hPWXZnSll3RkVUUmQ2?=
 =?utf-8?B?clJkb0hYWWZhOXM1VnluRDdMU29KamV3Njk5V21tRHJtaFpsTHZoUkxUU0dB?=
 =?utf-8?B?cmFYeEIzNXJrVzJOdlIzYTRWL25XWVlOaXpSblFoTHdOaUVnVE1jRHlUSkUy?=
 =?utf-8?B?UVEvNGpUdW5iaEVVeW9EYVZRRCtvWS9JZXRtQjl3OHkzcndRRWJTT0NUcHNW?=
 =?utf-8?B?c1pza1ZTL1dpMmRHbDMzTmFSSEJaaHV1VE5mMWJrek5mQkg3WXVVY3ppYU1t?=
 =?utf-8?B?YjR4QkVqNHRxc2d2UitVdC90NTY2d3hNbUZLandPeXRNdzlRNVk0T1dVRFA2?=
 =?utf-8?B?UzFtcDZ2bG5ZUXZkUEVPVmFkc24zMEJ5S1JDME40NlpyTkowM2ZBSSszN3po?=
 =?utf-8?B?S2w2ZlU3SzhPQVVzeForSWlyNUtkNE1YWXdLM1liaXRVY3Y1QlJMSW5BeThO?=
 =?utf-8?B?NlgyUlo3WWxZWnphYk9EMmdrUDNJaFd0NG5JRjdOZ21DZmMyYVNyeXRLajUr?=
 =?utf-8?B?Yzc0bTU3My9HV0xTWmk4cGdBV1hEbEc3czZxZ2F4WFpRRStzL2Q2eUozRWZm?=
 =?utf-8?B?aStuSjBTWEVVbk1KSU5OMnNnek1zbW9Fa2JLK1RzbFZOT25EQ2Y2YTF5a05C?=
 =?utf-8?B?Vmt1SHZ4RWsrejVGc3NtT2VlNk9majh1TFlwUHQzTEw5ZnoxanlIUUVmdzhY?=
 =?utf-8?B?eGVGM094Z2RIVzBMRkpCcVNvaTJzclV3NTYraXZPNVdBTVo1cjhqTnhVVWFJ?=
 =?utf-8?B?aHdQb0dhOGhxcFROZ1BYd0hCNzhuVTFQRGszMmFsalFMelA4SmJ3QStLeE1J?=
 =?utf-8?B?bi9Jd1FEYStpRTJNTngyTVpCNVdmS0t6OWYyZjQ5YmFzRXA3RFZJK2JyVlpO?=
 =?utf-8?Q?sCb+gndUBo0cq5djLNCDtUdD5frJpKogQC3bdExBgY=3D?=
Content-ID: <DA14F6F05AF7314D93CC7E13DCEED357@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e5387e-a94a-4af5-f4ff-08d9fd8aaa53
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 02:57:05.4110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWWDPkdvzTQDglUnD6VeTNO8fxGVG/0akfCFkR0cdwFQPfm2Na/1rCols+61Yk9tSduZdZg2kJwrDf38D6+Yg+W7Oso48wE6qlZ7dP7l8Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5639
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
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

Hi Martin
> On 24. 02. 22 2:47, xuyang2018.jy@fujitsu.com wrote:
>> Hi Petr
>>> to change
>>> quotactl08.c:160: TBROK: mount(/dev/loop0, mntpoint, ext4, 0, (nil)) failed: ESRCH (3)
>> I doubt why fs quota is not supported on this case since we have check
>> kernel config?
>
> In this case, kernel config says that quota is enabled as a module (=M).
> But the module is packaged in a separate RPM and the test is running on
> a minimalistic system where that RPM is not available. Therefore just
> checking the kernel config is not sufficient. We need to query actual
> module presence.
>
> (Sorry for duplicate mail, I forgot to CC the mailing list.)
Oh, I replied the personal mail.

Thanks for your explaination. I don't know this complex situation before.

I think the quota module is belong to kernel-default package but not 
belong to kernel-default-base package. So jeos use kernel-default-base 
will pass kernel config check but indeed it miss this module.

This problem also occurs on centos if we use module from 
kernel-module-extra.

So a better solution is that if the module is belong to 
kernel-default-base ,then we can use kconfig check, but if the module is 
not belong to kernel-default-base, then use need_driver maybe more correct.

Best Regards
Yang Xu


>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
