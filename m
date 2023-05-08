Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9862C77B75
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 05:27:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 419803CB573
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 07:27:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D0E13C02C8
 for <ltp@lists.linux.it>; Mon,  8 May 2023 07:27:09 +0200 (CEST)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1147A600641
 for <ltp@lists.linux.it>; Mon,  8 May 2023 07:27:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1683523628; x=1715059628;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YTgtj732XFM5FNv5hU/umy7jXUFp1XQl9TnfBzrBqeI=;
 b=ArtnCaXT0JPOcxm4kYXm3p4h6PbqjAKjcr5qY5D7frCDVOSHR4/APbS/
 GNUJJMxNgmMclbiV2TBSQlhUscbJ9AOJ6Va+t8iwTPVwceXhnOQNY9jEr
 LKKarCC3eC863t2Vqyp1w13B0sevdcBsFthyboQP96Ee9LzaJIPyMhJvn
 A09gmP07/Kh9TC0G2cjfDt5DJCKxFAAmhwURU98Hux0Ndo2DPJ1r5u8yh
 daJYh+Ja69MW37CrqfYtEMj9XYR6t5aVIozlQLL0LqbJsMr+VcjECuBTE
 5+EA4eHYO6CkMO2X5E6bcGr3s5nP7sXex23NpThZ9KY+a1Cm9raAX251o Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="84220526"
X-IronPort-AV: E=Sophos;i="5.99,258,1677510000"; d="scan'208";a="84220526"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 14:27:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZa58BDehLP3hy/fgva1JfvIubY+hMErR3SHIxgJa6XXY12vaFmpAzWaTz9Ew4FlByb/xlIV6ctxc/wfEn87z5MEVFhMhbWDlvj5b/VLhDZeuNefF0/usP7gEEpdMioWYxzSNwD7BLV/euLjkHyvdQkkyox4Gdw0QTG1SJtbymPgT+nIqLzy7Dzdmn/sPSfJABStqSKlwD2W5ZKmZKt02bey042izYkSty2T4obaEaZi0OPl5gTR1ZMdKc6sEiiFEsaj7tvc89e3J5/Z0yl32ESRMzWn9WjUBnZirn0urjHTck3PkZLMDqx8x0C7ySiyRyFj4lYi7zmAjDw6tyf40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTgtj732XFM5FNv5hU/umy7jXUFp1XQl9TnfBzrBqeI=;
 b=ijfmz268c+hSYOn10CgL4nz66Xbw9aEOJYGL/XAPyOBWhHqq5Y6twLA2Wfz7ONttlSEKpdZQ2SryECiH2b32Q7xZ077vsueEk6ZFrp/E9MVklydAcPYwHdbQxxwQwv5LqgqbMResSYJvtrYaQrwsQqNHrDQF9/BGrEBLXDi93GecWSihmlkfpHFTeUBbyRczIFGRFL2YyIa9WI0ZQv1vcVcNl2G6jQA8ka6AT8rh6ONdLVqohG/kLHk6QehLC0H23SXzgWWfLbQHEwtwS7eOTYH1fDR8NUv+eauddMBJnhRKboowwuPS44aZtdWfMypvZl+USdcfeXVrlCE0wvRoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYVPR01MB11314.jpnprd01.prod.outlook.com (2603:1096:400:36a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 05:27:04 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 05:27:04 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] LTP release preparations
Thread-Index: AQHZeCAzk9nV0mTq20ajlmyUy370Na9ActgAgAZ9PoCACPsYgA==
Date: Mon, 8 May 2023 05:27:03 +0000
Message-ID: <8fba903c-2a82-d81b-8fa9-1f6cf0398952@fujitsu.com>
References: <ZEjsKC6ESB1+mM0H@rei>
 <903b9fe6-6fa3-ca22-a0f8-ff97ffac9338@fujitsu.com> <ZFD_h77sIv1BDfzE@yuki>
In-Reply-To: <ZFD_h77sIv1BDfzE@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYVPR01MB11314:EE_
x-ms-office365-filtering-correlation-id: 1f64bc7d-659e-407f-06fa-08db4f84db7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WR2e14iERQ+J5+6kEo5+z6aSs6gb66Al/02MHBYmaT1e9G7nMjDfGHdCPJ8Ua0YdTBqu02sCb5jGNCUgN4DVoc5+Sl/e/62gU3ff6WI0HZ6uAXN22a9UDypKcJEqt9LaK5L3jObmXOaMGNlPCHWDxxWxNNn7C5h/den0n8j6Jsc+9p7WSiaAN8bkgvpJ7hibSe2gOBKLESYkMaz08uiOh7tkm7w+fxSevqv4co/FubcGLLwrqWlFAJpyaIU4AwwKrjyY0lW7VOKeDTHwoAgG9spjvWaUMHRcGdw2Iu0c25XUgSBvdPID/OTWISA2vP49f292TBthmgTYHbnyibm1LwkVZKsYN0eLMfhJ2IuVp8fICEu5sVZkxJyBwaCi1uQhO3LggA0QrCQWxfy5qnmgrMMSef/MS68HS7KmdPUzOQ8Bm70OknvEdm11LGziCEFtu0VqSC09BiR5obwyHLdIqw1DPCNuzsN9k6JmA3eyKR/6cQ35Ak1bFqZRVQIjrNoGJnkW2njdwLVT6l+PxQRzJQpUo0N+Whuu6zRbtZ6S/sq7nzkTZXhcROpfejnHEqTmyHA2dyTvK1P1SYQYxAGI87jsNakxvQYmd+QO9346qcKutJLPAXZi/b0BY4+X8EE0oIAEc4tSWAwYc01xxzmn76mp32o2cmJpyH5o6HfEkDY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(1590799018)(451199021)(83380400001)(91956017)(6486002)(478600001)(71200400001)(2616005)(6512007)(6506007)(26005)(186003)(85182001)(4744005)(2906002)(36756003)(38100700002)(66476007)(66556008)(66946007)(76116006)(64756008)(6916009)(82960400001)(4326008)(122000001)(41300700001)(66446008)(8676002)(8936002)(38070700005)(31696002)(86362001)(5660300002)(316002)(31686004)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tjd3L09LWG1KVys1VEdOUXozamluNGJqVWZkQnQxM01iYTQ0V2Q0azVCZm9S?=
 =?utf-8?B?eWZwNkdyODZoOU9SYk9iTS9YNTNyeFpQL2p2RDlraGFiY2hKNFJCVHhkdmRp?=
 =?utf-8?B?S3Mrd1pqT1U3T1lWZzV1Y3d4aEdPdW92VVpJWnVYckFrRy9UdHNpdFZVdlcv?=
 =?utf-8?B?VU52MGdRUEtIVWp3TDBaU1JrWVBoY1dJLzBBZ05lbzQ5ZFlMWVpKRHFFTDRN?=
 =?utf-8?B?ZVhDb0RNNUpyWUVIUndMU2wzNzVEVnFWUUFoY1dKUDNaa1EyZ2taSXArNCtQ?=
 =?utf-8?B?cXpKYldNNjRXK1owQ0RGTi9EOXNhT0dBTUo4aVh4NlZGdjBFVmV0V3p1djN0?=
 =?utf-8?B?dEgrSlQyb1hpUnFPREo2VkFJam1wb29WOFVIT3pubkZqWm1Edi8zVlduQUdI?=
 =?utf-8?B?T1gyZzZlSUVpbC93SWlGZjRMd2hpbmlWWFgvc2JWUzVqYVk4VmJVRXA4YVkr?=
 =?utf-8?B?ZE5WaFFOV3B4OWtoVU1wL3RTSVgzRFdzZndDTTdkSkwxcHpVWmRhTy9Pb3lM?=
 =?utf-8?B?Q2oyYmptM2pvdjVHVFBHcjMyYWU2QnhrN0FnSTFlbWt6dmFPUkpSQ0NyeFRS?=
 =?utf-8?B?RzBZbitKWm1VRFRTV1RKL2V5STAzUmdyWisxZGhxazQxTlJDVkJLbEE2aTNR?=
 =?utf-8?B?OTZZc2pzRGpLM0lHcWsrcERkSDBuTk9nWDdsVFNPVXJHTDRBcjlVVWpXZUdC?=
 =?utf-8?B?UE9WdnJWRDFVVFQrNU5vOFl5Sks2ZHFRL0JkdHprMDJWaTFDS2Y2TjdzdzIr?=
 =?utf-8?B?MmNINEY0SVZqRWJmTFpIaU5KT1BoSXMzcEN6cWowYytTeFltQnl0RDlRMlgx?=
 =?utf-8?B?eFdUNnViSGpRQkRDdzZKS1libTJDamdya1BSYjV0azREbUNHTXc3RVhiaTN0?=
 =?utf-8?B?bVdsSXJBUjhWTE5KNjNkd21IYStQaDFZaFhFempVNFJodFUydU9KWERHNWhr?=
 =?utf-8?B?SDBMaDZqcW9qNGlmeTd5NkpzMndoV3lvMW5vSHhPUkxyZlFsblNXaWpEZjht?=
 =?utf-8?B?VUYvdFY0ajhOb0Z2MjFqMVRHTlY0T0JaS1gzV3dVVTdBM0pUZWU3bE9LSEpu?=
 =?utf-8?B?K1ZUSkJmaTlHRGRmRWhEWFVVNGlvaFg5Nkw0Z2s5Z2Z3c1ppQW9MOGxGNFI1?=
 =?utf-8?B?WmRwS3hFYUQ2K3hsdThuWDdBS1ZRbjY4V2Z0ejBUSjYyM2lvQ3lOTHcrbDFU?=
 =?utf-8?B?SmxSclJKYzdMVGJYMS8rSE1saVV6ZXVycXNwN2pTaCtuQ3VyNWFEeG15dUw2?=
 =?utf-8?B?NzdJUXJCYkhORUQ1YkVBYmpHZzNUVGVWOHFmWTUyUmdoaGtHeDhvaXRXdndm?=
 =?utf-8?B?Q2hxTWhCWnMxcnJCVExlY3RCaklSa3lmdFgvNjJqL3AxdnVyWFJqL1lCQTVP?=
 =?utf-8?B?UlRtbXFMYzBZY3NYQVN6eUpEV3hqMU40M0NYS2tZT25rbjRDOVd3YVE1Nmd2?=
 =?utf-8?B?RWZ1K3lnY0JxNWQ5ckJyaGFHOTNjOTQycGkwNkhwd1VBMGxOUkZpRXFVWHlN?=
 =?utf-8?B?aFU0VFBKRFFaMUwwY2dqRU1uM29JYTByR3lRejZwVXVTTUVrUlJ6K3lRRTAz?=
 =?utf-8?B?Z1ludUQ3RFRwRnRENDR6dDdvd0cwSE1HZjE5MUJVSGZrM1g1UEtZZXFtRFNR?=
 =?utf-8?B?MS9UNlpMdGhSTzdHOTd4aVcrWkRBU0N3SnE3RWlFOGRLNldlSENDczNSVGZk?=
 =?utf-8?B?OXh5cGZwdUhHTUVlelVRZEVyRytMK2syTnhoQ3d3UkoyUERqNVFsNGVHd0Fi?=
 =?utf-8?B?MkVaM1ZpYzJkN3pIOTlvS0JybzUxK3NNZWs2czZpUytBTVA2OW5SSzF6RHRW?=
 =?utf-8?B?RkRmS0FQdXFDdXQzaWxPODQreXZlaVo2Q3R0OUh5STFNVUtaM3hPVnlDZ05p?=
 =?utf-8?B?alNBeUFqUExhbWZWUmRzZ3greVpkRGRid2tjTVFISWd5S3E4NlFuS05QSUsz?=
 =?utf-8?B?STRpUzA5d0NtbnRrc252UGNDVVhCMUVOWmw1YkpGd2FRd0MvOUVGOUNpdTlX?=
 =?utf-8?B?Tk9oYjVCMGJsdDh6Q0krYVJvdG0yZjNZbFhVZlk3bDkwQ3poTlFucjQ3eGQz?=
 =?utf-8?B?b2ZVUXpWbXFFZWxuSnQ3dGNFRWkyaCtBVXBoQUdFZ0w0UjVRY2pPTVJDaFVn?=
 =?utf-8?B?bFJhTWwxbWhwbFhGWlA2UUtaTVVMdzNnMEE3SlM4RzhHbjZ6cTNkd3JaeGRq?=
 =?utf-8?B?WFE9PQ==?=
Content-ID: <71E09DF5AEDA7643A16CEFF9F587A1FB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4ID7AGKaOd6rHkK8BoBHcOiaxl1+QyHVo3PTR58wMBxkKeCyPAjiavVapAP0gFvLotO+OinyIrK7y/EAio0SkR37mXOTgpt9KrA6OI+nNoK+FlBnvX8eZWzdG5QsRQDs8dr4KwitRQ8wrNYz9/YwJ445RSQyVExbTZhEokngkKhHkCFirdy965L6eOfGkTzGl5E2LVoPBGvoT9c+e5BqunBZW2iTe5NWR3o8GtHXxISC26Fix2isGKeckI+2jOS85zUYWvX/18o1T5ix8b7AC8JgasNNYndVAtkd87QaJ5+tQgzzeKsK5Eo5c48JtNYIBu0rbxLbv48XIquI1aHMAL4n5t6DluYtVkGpRFRnQuOmdNpWDl4owNgQPZtKLZI3MhIhaFCiVAaipoDUZtd/cx/hlNaz2W/uant3AyzFBiAOnAO4Pmkbv5DSQZPbtThwWjQQfTJ1LxTIGBh7DwZkpl4zaKA+Wa+Bf5gY8KSLPbD/iJ0lIXCqJ55xPhUsoEzpuliw4lm4hCvSeJiJM0JIArkCjNbI9VDt1IW2IXBgYiQDB6w5HtqSGbXaJMB/ow3b0RDZehjPdK9j2b4IQLCV58uS9voKxuP/yThpt0sJ6yRsKSlz9ToNIZYAIDrPVO8sCOdwrGuSB4v9+xHANKbZnwCp89k5zhFuubnfyXj5OtqNxOGOFoRjE1ktRfOKXjOm02iu0h9uBilPU9GVauoJ//hAUWpMJOHkJGe2+HcD7NYfK93LJ4cOMOX3KYDaDT4e5DC/7YMdZLVKvbiwoxvHcfgBGQcvFTVovqwAMNctUE8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f64bc7d-659e-407f-06fa-08db4f84db7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 05:27:03.9292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRaZ8yPVLlkK/a5QNF/4tg7h+1ZaC+KLJgVKCFklmr9dccPEDUa15cCe9zVtMbwteLfxHLZ6krVLs8uD/8bzPRO1QuQan+Mccz81TifuRcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11314
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
>> I prefer to include my STATX_DIO_ALIGN and mlock cleanup patchset before
>> release.
> 
> I merged mlock04. I'm unsure about the mlock03 removal, it seems to be a
> regression test after all.

Thanks, I just back from a long and happy holidy, I will submit a v3 for 
mlock03.

> 
> As for STAT_DIO_ALIGN I suppose that we need v5, right?

Yes, I will add some meaningful comment and modify to use in-tree 
definition on V5.

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
