Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E344C433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 05:30:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA4103C93CA
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:30:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 748C93C0F6A
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:29:48 +0100 (CET)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC8AE200B13
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641878986; x=1673414986;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=om2BmCo3aqlqcs5cyxnoCXzYc8jLt4NHh94vk4N3gzU=;
 b=TVso+UsWkRj5q/ilKWuc/U5V4Rv2A1y6yXwjnP4ZoLGIKA8ovWd2WSV7
 dv2H3aw0T6ENwnWlTlHtvaNPkk4qyEZC/oiknLMrCp3KNoPSYLaL6TILh
 LkC6wBWFpvzcS66n0nPNsvcGdWGNe4UdbAZKKi58p99R4JyEt1f9NjrOL
 9TWrTRK8+pAF+SXiaZaiAiFD476pRjlXsrqO7JQLgJmeAhg5QoUi0Ir05
 g2yzam8TCSNus9AhATBBcrnJMCodN4dl9m6yH3gX5ipgPFXhqQh7Ue5X+
 VGVeJTxXVHWHaNtZVvuc1GBl4ovSWPQEzeH7DR3NWgkKYxMNekTGO2s3D w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47430678"
X-IronPort-AV: E=Sophos;i="5.88,279,1635174000"; d="scan'208";a="47430678"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2022 14:29:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcmwQgk2SjELutCQNov5xEgFiPHcvqUyzxJFtjOzTAEBlKr9CZD219JboAS9PH5s9ln/W08SlnEPnD25Saif2gJfc8iQNw3BZ4jV2gFaq6s8p99wmrJ/TO5UtjjM62AdH5/ku3qLnaYz6RePG4gw8mtpiPDuCRADvO5ZQCQMf2sY2y9EX739lJcxRmTiI2/cmqD3IbGmTesiBcsIIfrY7XTVIbrxx9yUYjo9iXFAuyTwNhxjXH+xLu0A/Mn1OWi79fCZ5QPs8ZtzJeKEg2zX4tdFCZ18x+vYj20FEh5ii5/I7i1KUgNps5NTXgzkY5wc3RRIIFdguuWhJPifkV3kUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om2BmCo3aqlqcs5cyxnoCXzYc8jLt4NHh94vk4N3gzU=;
 b=NRaqkPwKPLWlhoQ1TdwcmXXW/ChZLGtd4ufqlss4dVoLSfAj+mIiNXG6ZxTH7yR4vdKEO9H6+waXZyRSji+q9ZZiDy5Z6GTsTAutmgXyyBZQsc0ax56hWJFH2iefR8PR6rClkVvXL1mXb1Zw0kq84Nv7Ujkdqag1olIm/bPhzG0YPzPldnG1S7UaQToSBnHymYyHfkea6QX9mn6IRlZi1qLuwvdZMs0qJIZ1JDHLSrQ70swGyHL2uHskuKNdXOPIy688gvFnNhfxqVr90mUDNov6ijrfR8qLs1Qp0jLQ7KmbSmXcd+Rb7SOtXzt9uPcsrtdmBpwQW9I98OKtkbGpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om2BmCo3aqlqcs5cyxnoCXzYc8jLt4NHh94vk4N3gzU=;
 b=VS6EakBW6OaLBwk6vq8wbXfXvh/7mYVxsjjxADuj8/E89JaOeNwN4HhKwqTTbhTcl2a+AWn41I9uGZaRrVtitncvsOKB6fZ/jPmKknSUIT5HeO8P1F77FcTXbkZTInbKADOl1q8ulbMJaEwrjUw2iljoTznYT4GN9Z12sdsjj9E=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4571.jpnprd01.prod.outlook.com (2603:1096:404:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 05:29:39 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 05:29:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 3/4] shell: add kconfig parse api
Thread-Index: AQHYBeiwVvRlvNR0WkO3kkr5h2+8+qxcREyAgAEIkoA=
Date: Tue, 11 Jan 2022 05:29:39 +0000
Message-ID: <61DD15F5.7070803@fujitsu.com>
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641779349-8424-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ydw4BXF2ramqahuh@yuki>
In-Reply-To: <Ydw4BXF2ramqahuh@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db1efb0e-d31c-4094-7f39-08d9d4c35d2b
x-ms-traffictypediagnostic: TY2PR01MB4571:EE_
x-microsoft-antispam-prvs: <TY2PR01MB45716957B9274595E5EFE750FD519@TY2PR01MB4571.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gwQ7YJY0aD3m0FhI+wnEQkuHWtyFORUxb5FRxt6JWFZYEpAxan+LJIdDFw3SLtJhXIXHlA0mKdupPzGWMOUsEhnOicqPTcuR0ZTchLhCEg5olRbhTz23iYsKiWeU84QpnSYUYwxuellfsYDbFWGMpSVMaTnK/Qkt1Bmcn00T/6a8oxb/eDsi38t/7X5OhHFK7rey8Ag22HJTPbw63Lcx99HTGDJBwvVV5HsckPQff+SkI58qrd8lMa2Xj12ZeylNtwdxDOhwsg5ybIE+b3tKYMPVrRpBQJ0LA1sZbX1uoXl0kEYaW6t1Wf8S+NJJ3Zm8A8gI2IT/lLjc3Oo+tvoyO8Ztm/3vD4l0qMQKlyRseULFNwA7+dJRJ3lKGhlIV78Ei92ZYfdv9YtDM5v/ctQcU2T0qv3Bva4sw7vgjawvq6V0pA1s7PObCfFSe1YKIE/xkSA9fPr/nIM+kKDZHURwls5NradYhTOk9HX628Bu28qDYNG0Gzavc/R8pasM5CqTS8La6jPd1kByJmCESpueV0PWv3HcW1JK1NXQh9IwPrYs7/X70fnmcrGQr1nn3AWDspN9Blv5JH1IULm1SZSwespHHwVOAVfrlOgYiMraPm+3+w0sVrNpWAlurgcCWg0kL+vC4MaAKmZmAy1C2F6uFsvnQPJXea5ud0qTL7JnBy0IeJ84/GOnrt7vhGmZp97tQbVw5E9t7SRTZX4to4facYNAHiOXGwm+6qyLIveKgztACm7x7ks7aJ62D9eYEbbio48J3dG9bCykwXMUNt8CdSVHQKZH8hPwz3Kv1w7VEY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(6916009)(122000001)(85182001)(38100700002)(87266011)(8676002)(6506007)(6486002)(38070700005)(8936002)(6512007)(83380400001)(64756008)(33656002)(36756003)(2906002)(30864003)(82960400001)(26005)(71200400001)(5660300002)(86362001)(2616005)(91956017)(76116006)(186003)(66476007)(66946007)(966005)(4326008)(508600001)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bk43UDg1NjY2dU93YVFLbFE5b3U2bzFwbWNJWmczckRQOGVENjZVMmU0eFNZ?=
 =?gb2312?B?K2t6NlUyeGE3MG5zNjF4ZXovcDZjK0ZjdERpbEN3VGV1QkJwaWNYWWFCRElt?=
 =?gb2312?B?TjgrWFhBbnI4enRVVGlHdWRjOUM3Y3FqcFM1NVJvVlJrRUpwOUNRamd3NXVo?=
 =?gb2312?B?WmJzQTZsSXJtT2xUc2o2T2p1K09uajZDZlNZVlN2dUI4bjB2U0UyZ0dpaU5M?=
 =?gb2312?B?UmVLTG03RVRaK29LS3h3bGJiQUVtZjF5N056K1EzcGRKSERYMWU4bzArZHFm?=
 =?gb2312?B?ZEZtRGhpcm5rRUFDZWZHQVJGT1lUcTNsT3k1aTBTSnBGS2xxaUpKeWRDalEw?=
 =?gb2312?B?VkFxVGJFL0Z4S0RJVFZOYnZnK0pkKzU3SlZpTGpXbzV1TjE3eEtkdlBSNVh3?=
 =?gb2312?B?M3ZZUUpPbHNGd2I1ckRuNHQxM1pzNGVsbTNKV3FyQzF4Z3pDN3FaVUxoWDJs?=
 =?gb2312?B?TU4rY01TV2pBZXg3TFkzYlVSNmN5eFJJbE43TTdpTnpQeFhadXRCRXBWOS9X?=
 =?gb2312?B?bHhqQlBHc3BaaGZoV1djditaUDBPdENiQ3dUMmF0RDdNSkpNRHQvYnExWWVq?=
 =?gb2312?B?MVdWOFNoTE9KRVM0MmdhUTdlSU9rbnR3aFdBNFZNeFdVMG4rSWIzU0Z5a05z?=
 =?gb2312?B?SW9UdGkvUlFqc0d4YTllOHNYN2JqSGJkRW5US3RTcFpYT3JVRTRaVUtxVTZQ?=
 =?gb2312?B?T0lpaklETU1IUzNsRklrRHE0S2NlOXB1Y0hEcy83bmZraHpQM09sRXZGQzdw?=
 =?gb2312?B?cXlWRVA4dnVPMkFXZG1IZjBMSzhFeDE2QjN6NS9QYnhVUGhDV0FnRzgwNWx2?=
 =?gb2312?B?UkR5UUZRSGtobzNab2c5d2lsZkVVNlJLRllWTzh1cFZKbE93VzVQdTZvY1ZC?=
 =?gb2312?B?MnpOdjFSdGpGeEdnUkNRQWRoamJMWDViN0lGRkNlTVM2eVlBR2xxb0MrVTh0?=
 =?gb2312?B?TXRNQjAyMldzYzdJdUd1UmVxUXprbDhJa2lUS0tMbkJHV1NydVFTTmgwSUxH?=
 =?gb2312?B?QWpjTDRJeWIrM2hYekdHR1R2SkRRVlV3eTliQlR4VzhRUWxhaW5mRHA5VkRC?=
 =?gb2312?B?R0ZOL1hjSjlUNTNFTVpBY296RllQTGZrR1k1MWlJZUI4SG95aHFWaXFteXZO?=
 =?gb2312?B?ZjZuUk5IRWIzN1VHUXNRZkJvNFRWN0h5elM1QW1MRU16VGR4RkQ2SDJkTThS?=
 =?gb2312?B?eisxOUhzWk9sN1JaY1RQWUUvaHBHZEpPQlJ4WVVyZ1FEa2U3U2pBcGFwTmdR?=
 =?gb2312?B?VjdWZkJWZWRjQnR1RnZseWYzVWxZdW5pUnlrc3hwazZ6Q2NPUWVXL1hMbUh4?=
 =?gb2312?B?TTV4Slp1NlNDdHU3eUM5WnFBUDFQdlpja3hITnJxUG9aWHpSdE9wVCtxU0RW?=
 =?gb2312?B?cXEwcDBlb09Da0xEcnFteFAzMTlsQVFMNGNWMC9zaVhZUWJpOVE4bmNtdWtx?=
 =?gb2312?B?YlY0aUNOdklQemYra29XZ0t6aTFwVUxDVzFaMWkyYi9oSDJRMHo5NTVTSnVB?=
 =?gb2312?B?eTNmSHRoMm9UM2JxSFpadCs3c2srbGtrMFZLbEkzODNqTkVtK0hmRzBGYWlr?=
 =?gb2312?B?dVhMUGl3S3prYWkrMEttWlREMVJQQ2NsVk9HbEhQRFQrK01HMG5WdXlVZjl5?=
 =?gb2312?B?WnQzcFdFR0NPdmM2K29MeTJEdVNsZGpwZkRsN09qQVY1QndKYVRvdUI4azRQ?=
 =?gb2312?B?UzRYVlBHM3ZwSzBoeFZtNkU2SmpzdFJ5bHNQRTNSakZmV2hjMlhSTW9SOEt5?=
 =?gb2312?B?MkN0d0Z1ektuUGVkSmJPMWZYZzNNeVhYUjN4SFlUT25ZSkZWMzh0cVE3SHRE?=
 =?gb2312?B?OUIvTkdMUnkzYlpJbXJxVCtxMjQ3L3Zha2VkTnlpZDBHbWwyaVF5WmxEMisy?=
 =?gb2312?B?MCtyRVNRdnBpNTk5TTZrQzFSVFVtcVpjWEJxaTVwTi9IZVNHUGxyYWZWbmJ3?=
 =?gb2312?B?S2kySHpTbUZXaFhqbFVUaDlMaHNkQkcwaS9ZcURSUE9XZEYrL1BrL0FNeVZY?=
 =?gb2312?B?dDVIOFJvZnA1K0pIOHRpeWNSN05PS1BGdytQenljTERwQ041ZGRxNktlTW5L?=
 =?gb2312?B?Vk4vQmpFa3V0UThSOURINmxUTXpJdFFYWTBoUGhQU0VEUWhhcDc2MHhTYXF5?=
 =?gb2312?B?aUZ6V2xCT2RVSWZ1NUFSODNCRGdwTnpFN1FBbWduVmdyK2hZMnJZR0VhS29N?=
 =?gb2312?B?WWlPUVpZTHE4VlBRVzhpK1M3ZVJWV0FocmphR3BpWW0wSlEvNUhrWmFucGo0?=
 =?gb2312?Q?gZHVxLoc8UxRVPu/qrvW80D4cZqqK6mFA15vVJliCo=3D?=
Content-ID: <C152F53511BDDC409051C674EC931F31@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1efb0e-d31c-4094-7f39-08d9d4c35d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 05:29:39.6009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sghlDFMXCy0Q70ZDIpCcacHOrXQEt/cmcOKh+mcsxs5i1LkKFNJj5ucNdfkVEnxYhLaHS3mcABQVxL6yasO7h6xrID6iPXiXLIg9Y39XZEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4571
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] shell: add kconfig parse api
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

Hi Cyril
> Hi!
>> Use tst_check_kconfigs command to call tst_kconfig_check function in internal.
>> It introduces two variables in tst_test.sh
>> TST_NEEDS_KCONFIGS
>> TST_NEEDS_KCONFIGS_IFS (default value is comma)
>>
>> Also, we can use tst_check_kconfigs in your shell case if you want to skip subtest
>> case instead the whole test.
>>
>> Fixes:#891
>> Suggested-by: Petr Vorel<pvorel@suse.cz>
>> Suggested-by: Cyril Hrubis<chrubis@suse.cz>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   doc/shell-test-api.txt                        | 51 ++++++++++++------
>>   lib/newlib_tests/runtest.sh                   |  3 +-
>>   lib/newlib_tests/shell/tst_check_kconfig01.sh | 16 ++++++
>>   lib/newlib_tests/shell/tst_check_kconfig02.sh | 15 ++++++
>>   lib/newlib_tests/shell/tst_check_kconfig03.sh | 16 ++++++
>>   lib/newlib_tests/shell/tst_check_kconfig04.sh | 25 +++++++++
>>   testcases/lib/.gitignore                      |  1 +
>>   testcases/lib/Makefile                        |  3 +-
>>   testcases/lib/tst_check_kconfigs.c            | 54 +++++++++++++++++++
>>   testcases/lib/tst_test.sh                     | 15 ++++++
>>   10 files changed, 181 insertions(+), 18 deletions(-)
>>   create mode 100755 lib/newlib_tests/shell/tst_check_kconfig01.sh
>>   create mode 100755 lib/newlib_tests/shell/tst_check_kconfig02.sh
>>   create mode 100755 lib/newlib_tests/shell/tst_check_kconfig03.sh
>>   create mode 100644 lib/newlib_tests/shell/tst_check_kconfig04.sh
>>   create mode 100644 testcases/lib/tst_check_kconfigs.c
>>
>> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
>> index b993a9e1e..e082808f7 100644
>> --- a/doc/shell-test-api.txt
>> +++ b/doc/shell-test-api.txt
>> @@ -193,22 +193,25 @@ simply by setting right '$TST_NEEDS_FOO'.
>>
>>   [options="header"]
>>   |=============================================================================
>> -| Variable name      | Action done
>> -| 'TST_NEEDS_ROOT'   | Exit the test with 'TCONF' unless executed under root.
>> -|                    | Alternatively the 'tst_require_root' command can be used.
>> -| 'TST_NEEDS_TMPDIR' | Create test temporary directory and cd into it.
>> -| 'TST_NEEDS_DEVICE' | Prepare test temporary device, the path to testing
>> -                       device is stored in '$TST_DEVICE' variable.
>> -                       The option implies 'TST_NEEDS_TMPDIR'.
>> -| 'TST_NEEDS_CMDS'   | String with command names that has to be present for
>> -                       the test (see below).
>> -| 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
>> -| 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
>> -| 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must be int>= 1,
>> -                       or -1 (special value to disable timeout), default is 300.
>> -                       Variable is meant be set in tests, not by user.
>> -                       It's an equivalent of `tst_test.timeout` in C, can be set
>> -                       via 'tst_set_timeout(timeout)' after test has started.
>> +| Variable name            | Action done
>> +| 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
>> +|                          | Alternatively the 'tst_require_root' command can be used.
>> +| 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.
>> +| 'TST_NEEDS_DEVICE'       | Prepare test temporary device, the path to testing
>> +                             device is stored in '$TST_DEVICE' variable.
>> +                             The option implies 'TST_NEEDS_TMPDIR'.
>> +| 'TST_NEEDS_CMDS'         | String with command names that has to be present for
>> +                             the test (see below).
>> +| 'TST_NEEDS_MODULE'       | Test module name needed for the test (see below).
>> +| 'TST_NEEDS_DRIVERS'      | Checks kernel drivers support for the test.
>> +| 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).
>> +| 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
>> +                             default value is comma, it only supports single character.
>> +| 'TST_TIMEOUT'            | Maximum timeout set for the test in sec. Must be int>= 1,
>> +                             or -1 (special value to disable timeout), default is 300.
>> +                             Variable is meant be set in tests, not by user.
>> +                             It's an equivalent of `tst_test.timeout` in C, can be set
>> +                             via 'tst_set_timeout(timeout)' after test has started.
>>   |=============================================================================
>>
>>   [options="header"]
>> @@ -742,3 +745,19 @@ TST_NEEDS_CHECKPOINTS=1
>>   Since both the implementations are compatible, it's also possible to start
>>   a child binary process from a shell test and synchronize with it. This process
>>   must have checkpoints initialized by calling 'tst_reinit()'.
>> +
>> +1.7 Parsing kernel .config
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The shell library provides an implementation of the kconfig parsing interface
>> +compatible with the C version.
>> +
>> +It's possible to pass kernel kconfig list for tst_require_kconfigs API with
>> +'$TST_NEEDS_KCONFIGS'.
>> +Optional '$TST_NEEDS_KCONFIGS_IFS' is used for splitting, default value is comma.
>> +
>> +-------------------------------------------------------------------------------
>> +#!/bin/sh
>> +TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS, CONFIG_QUOTACTL=y"
>> +
>> +. tst_test.sh
>> +-------------------------------------------------------------------------------
>> diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
>> index 8b2fe347a..b34a582b7 100755
>> --- a/lib/newlib_tests/runtest.sh
>> +++ b/lib/newlib_tests/runtest.sh
>> @@ -6,7 +6,8 @@ tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
>>   tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
>>   tst_fuzzy_sync03 test_zero_hugepage.sh}"
>>
>> -LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
>> +LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
>> +shell/tst_check_kconfig0[1-4].sh shell/net/*.sh}"
>
> It would be slightly safter to actually export the KCONFIG_PATH pointing
> to one of the config files created for the C tests (config02) if we are goind to
> run this in CI.
>
> It's very unlikely that anyone who runs these tests wouldn't have
> CONFIG_EXT4_FS in but it may actually happen.
Good suggestion.
>
>>   cd $(dirname $0)
>>   PATH="$PWD/../../testcases/lib/:$PATH"
>> diff --git a/lib/newlib_tests/shell/tst_check_kconfig01.sh b/lib/newlib_tests/shell/tst_check_kconfig01.sh
>> new file mode 100755
>> index 000000000..065a20fd2
>> --- /dev/null
>> +++ b/lib/newlib_tests/shell/tst_check_kconfig01.sh
>> @@ -0,0 +1,16 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> +
>> +TST_TESTFUNC=do_test
>> +TST_NEEDS_CMDS="tst_check_kconfigs"
>
> I wouldn't bother with checking for this, it's part of the LTP it's not
> an external tool that could be missing.
Agree.
>
>> +TST_NEEDS_KCONFIGS="CONFIG_EXT4"
>> +
>> +. tst_test.sh
>> +
>> +do_test()
>> +{
>> +	tst_res TFAIL "kernel .config doesn't have CONFIG_EXT4"
>> +}
>> +
>> +tst_run
>> diff --git a/lib/newlib_tests/shell/tst_check_kconfig02.sh b/lib/newlib_tests/shell/tst_check_kconfig02.sh
>> new file mode 100755
>> index 000000000..3a0f05847
>> --- /dev/null
>> +++ b/lib/newlib_tests/shell/tst_check_kconfig02.sh
>> @@ -0,0 +1,15 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> +
>> +TST_TESTFUNC=do_test
>> +TST_NEEDS_CMDS="tst_check_kconfigs"
>> +TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS : CONFIG_XFS_FS"
>> +. tst_test.sh
>> +
>> +do_test()
>> +{
>> +	tst_res TFAIL "invalid kconfig delimter"
>> +}
>> +
>> +tst_run
>> diff --git a/lib/newlib_tests/shell/tst_check_kconfig03.sh b/lib/newlib_tests/shell/tst_check_kconfig03.sh
>> new file mode 100755
>> index 000000000..c5f046b79
>> --- /dev/null
>> +++ b/lib/newlib_tests/shell/tst_check_kconfig03.sh
>> @@ -0,0 +1,16 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> +
>> +TST_TESTFUNC=do_test
>> +TST_NEEDS_CMDS="tst_check_kconfigs"
>> +TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS : CONFIG_XFS_FS"
>> +TST_NEEDS_KCONFIGS_IFS=":"
>> +. tst_test.sh
>> +
>> +do_test()
>> +{
>> +	tst_res TPASS "valid kconfig delimter"
>> +}
>> +
>> +tst_run
>> diff --git a/lib/newlib_tests/shell/tst_check_kconfig04.sh b/lib/newlib_tests/shell/tst_check_kconfig04.sh
>> new file mode 100644
>> index 000000000..ad5e8ac21
>> --- /dev/null
>> +++ b/lib/newlib_tests/shell/tst_check_kconfig04.sh
>> @@ -0,0 +1,25 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> +
>> +TST_TESTFUNC=do_test
>> +TST_NEEDS_CMDS="tst_check_kconfigs"
>> +. tst_test.sh
>> +
>> +do_test()
>> +{
>> +	tst_check_kconfigs "CONFIG_EXT4_FS"
>> +	if [ $? -eq 0 ]; then
>> +		tst_res TPASS "kernel .config has CONFIG_EXT4_fs"
>                                                                ^
> 							      FS
Will fix.
>> +	else
>> +		tst_res TFAIL "kernel .config doesn't have CONFIG_EXT4_FS"
>> +	fi
>> +
>> +	tst_check_kconfigs "CONFIG_EXT4"
>> +	if [ $? -eq 0 ]; then
>> +		tst_res TFAIL "kernel .config has CONFIG_EXT4"
>> +	else
>> +		tst_res TPASS "kernel .config doesn't have CONFIG_EXT4"
>> +	fi
>> +}
>> +tst_run
>> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
>> index 9625d9043..c0d4dc851 100644
>> --- a/testcases/lib/.gitignore
>> +++ b/testcases/lib/.gitignore
>> @@ -1,4 +1,5 @@
>>   /tst_check_drivers
>> +/tst_check_kconfigs
>>   /tst_checkpoint
>>   /tst_device
>>   /tst_getconf
>> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
>> index d6b4c7a91..f2de0c832 100644
>> --- a/testcases/lib/Makefile
>> +++ b/testcases/lib/Makefile
>> @@ -11,6 +11,7 @@ INSTALL_TARGETS		:= *.sh
>>   MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>>   			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
>>   			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
>> -			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill
>> +			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
>> +			   tst_check_kconfigs
>>
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/lib/tst_check_kconfigs.c b/testcases/lib/tst_check_kconfigs.c
>> new file mode 100644
>> index 000000000..dd0c72768
>> --- /dev/null
>> +++ b/testcases/lib/tst_check_kconfigs.c
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
>> +
>> +#include<stdio.h>
>> +#include<string.h>
>> +#include<limits.h>
>> +#include<stdlib.h>
>> +#include "tst_kconfig.h"
>> +
>> +int main(int argc, const char *argv[])
>> +{
>> +	char delim[2];
>> +	char str[PATH_MAX];
>> +	char *result = NULL;
>> +	char *next = NULL;
>> +	int i = 0, j = 0, ret = 0;
>> +
>> +	if (argc<  3) {
>> +		fprintf(stderr, "Please provide kernel kconfig list and delims\n");
>> +		return 1;
>> +	}
>> +
>> +	if (strlen(argv[2]) != 1) {
>> +		fprintf(stderr, "The delim must be a single character\n");
>> +		return 1;
>> +	}
>> +
>> +	strcpy(str, argv[1]);
>> +	strcpy(delim, argv[2]);
>> +
>> +	result = strtok_r(str, delim,&next);
>> +	for (i = 0; result != NULL; i++)
>> +		result = strtok_r(NULL, delim,&next);
>
> There is no reason to parse the string like this here we can just do:
>
> 	char *str = argv[1];
> 	char *delim = argv[2];
> 	unsigned int cnt = 1;
>
> 	for (i = 0; str[i]; i++) {
> 		if (str[i] == delim[0])
> 			cnt++;
> 	}
>
>> +	strcpy(str, argv[1]);
>> +	char **kconfigs = (char **)malloc(++i * sizeof(char *));
>                              ^
> 			    useless cast
>
>> +	result = strtok_r(str, delim,&next);
>> +	for (i = 0; result != NULL; i++) {
>> +		kconfigs[i] = (char *)malloc(sizeof(char) * strlen(result));
>> +		strcpy(kconfigs[i], result);
>> +		result = strtok_r(NULL, delim,&next);
>> +	}
>
> Also no reason to allocate anything here, we can in fact modify the
> argv[1] there is no reason not to, so we can do:
>
> 	for (i = 0; i<  cnt; i++)
> 		kconfigs[i] = strtok_r(str, delim,&str);
>
> 	kconfigs[i] = NULL;
>
>
Will do it in v5.


Best Regards
Yang Xu
>> +	kconfigs[i] = NULL;
>> +	if (tst_kconfig_check((const char * const*)kconfigs))
>> +		ret = 1;
>> +
>> +	for (j = 0; j<= i; j++)
>> +		free(kconfigs[i]);
>> +
>> +	free(kconfigs);
>> +	return ret;
>> +}
>> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
>> index 2556b28f5..9c4e4dd3b 100644
>> --- a/testcases/lib/tst_test.sh
>> +++ b/testcases/lib/tst_test.sh
>> @@ -412,6 +412,17 @@ tst_require_drivers()
>>   	return 0
>>   }
>>
>> +tst_require_kconfigs()
>> +{
>> +	[ $# -ne 2  ]&&  return 0
>> +
>> +	tst_check_kconfigs "$1" $2>  /dev/null
>> +	if [ $? -ne 0 ]; then
>> +		tst_brk TCONF "Aborting due to unsuitable kernel config, see above!"
>> +	fi
>> +	return 0
>> +}
>> +
>>   tst_is_int()
>>   {
>>   	[ "$1" -eq "$1" ] 2>/dev/null
>> @@ -587,6 +598,7 @@ tst_run()
>>   			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
>>   			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
>>   			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
>> +			NEEDS_KCONFIGS|NEEDS_KCONFIGS_IFS);;
>>   			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
>>   			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
>>   			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
>> @@ -627,6 +639,7 @@ tst_run()
>>   	[ "$TST_DISABLE_SELINUX" = 1 ]&&  tst_disable_selinux
>>
>>   	tst_require_cmds $TST_NEEDS_CMDS
>> +	tst_require_kconfigs "$TST_NEEDS_KCONFIGS" $TST_NEEDS_KCONFIGS_IFS
>>   	tst_require_drivers $TST_NEEDS_DRIVERS
>>
>>   	if [ -n "$TST_MIN_KVER" ]; then
>> @@ -748,6 +761,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
>>
>>   	TST_TEST_DATA_IFS="${TST_TEST_DATA_IFS:- }"
>>
>> +	TST_NEEDS_KCONFIGS_IFS="${TST_NEEDS_KCONFIGS_IFS:-,}"
>> +
>>   	if [ -n "$TST_CNT" ]; then
>>   		if ! tst_is_int "$TST_CNT"; then
>>   			tst_brk TBROK "TST_CNT must be integer"
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
