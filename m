Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D067C38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 02:14:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 930783CA285
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 04:14:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEFAE3C039E
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 04:14:04 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CB7A1400B84
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 04:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666664043; x=1698200043;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bo/gsNP/IysDl37sUC8+hX0MqOjO9XQy7h2ZIKi34Xo=;
 b=YciXgW9wivq49JgsxsWcMYr4v4BbkXPl5jmeHKMRw8DA8rNy/RQMrvcy
 +Kh315XJIrh8+m9bhXxOWnzzGZw87y3ROVl8TroDikkV0/Vg2mQ3WDliB
 +HrmSBqzkAsPjasL7Wmqr2tSg7mkcNVfH1D2VyYPrgOyhCWR7d98oqfoU
 CkBiUx0doln5GlfKp4/nnfx0rcTXV03cZjacqwMDteNTTNjA+xlEaYrzV
 TsMYUnvL6y0tD1RFIURjZgUH/zHu1maEx1ZZ/7TTfxF7lPJ1Pb6ZdlmIY
 rlxjDDNPDeimJTK4MxStPTvvLds5JOCZ2kEZb9uI2wWeXLjF5fzo8YVYQ g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="68492538"
X-IronPort-AV: E=Sophos;i="5.95,210,1661785200"; d="scan'208";a="68492538"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2022 11:14:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARv+da5O+SByEdTJwHgnqKu41UdXyhk45ykMNUCdHOL86TwBkDs3S/AjJEZtn8AOSkPu+3pJ5CVfFGo7vbYYBLq+NK4ZFwonJr8A+ekxFOV/RqfZsJTW9R04Fo3iGxTK6+YA9Cr7giO/mMDvNlyFDa7tuNL8eCKdmveb7Up+ulzt+lyjZKngYedKUucU7OLj0I9NVZgluNmWlsFacJowP0Fl+1zW09OrLWE3D4ClcLMMcX6t/4wzkUkO0a5EiGwRv/xy+LEwy+4WPFb4/DEfAUqODFUJfEkI2cbTnwwQYWpPzaw1owoyX0ivWzD3TUsWJyQJWNkv0vn25iif27Y+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo/gsNP/IysDl37sUC8+hX0MqOjO9XQy7h2ZIKi34Xo=;
 b=HuhZlOb6pdDWNVhZONZyR0TFVk+8/r4tGpIL68Zu2BPqfZ2Q2YcbuRYcLxCaDZSEZQeL3KYDl5q7XVLLw13AJyPypZOSbmHVI6dPsLtZLAkzm1UH+GdnUC29xpModpaVWPB1dHU+tG/sneYfZ1DV7l+etjoJjbBFwp6PcUNbYFpVLd6eSrxWrnJXJaD/yNYVGMM+UFbyuih8pp44Vau07v5vju/T19N9FjWxL1w6WdOQbwWmp3BTdMK/oape4nNo546JTEz13MKa9y28f+ZoDv4hj4sHHmbTsqKK0kM7uUIv7jRMfE5mRZK+NErYOLWGtDYERCvu1XMkNCZWXzKiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB4419.jpnprd01.prod.outlook.com (2603:1096:604:62::18)
 by TYBPR01MB5358.jpnprd01.prod.outlook.com (2603:1096:404:8025::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 02:13:57 +0000
Received: from OSAPR01MB4419.jpnprd01.prod.outlook.com
 ([fe80::fac7:e474:bccf:92b5]) by OSAPR01MB4419.jpnprd01.prod.outlook.com
 ([fe80::fac7:e474:bccf:92b5%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 02:13:57 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/mount03: Add statfs f_flags member check
Thread-Index: AQHY4tnOJqfO5PH5OUegkRUQ1i3TDK4ZbxiAgANpsoCAANEuAIAA0CsA
Date: Tue, 25 Oct 2022 02:13:57 +0000
Message-ID: <c875bc23-b512-b731-ee16-a2425fb837fe@fujitsu.com>
References: <1666091413-7732-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y1MZnwFidi1eZoct@pevik> <d4483cf3-d1f9-5314-5e87-3b1edf2820e0@fujitsu.com>
 <87fsfdxol5.fsf@suse.de>
In-Reply-To: <87fsfdxol5.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4419:EE_|TYBPR01MB5358:EE_
x-ms-office365-filtering-correlation-id: 7db852f3-6f60-4a5e-f0a7-08dab62e92d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXmA7k0C1D/ImgKre49F2dIaG/ZHEbxL3XsxKbqxHdMPzGEyb2h8u/Hb/W8b3WXn63fBRSdnFr+t6aiI6JxJc/tAvFhLjalkT1MgEqcP3pxjhvYp8YGBI1FXCi53Vi/Ax180slV0xXD1mAu5Qw9ykg62fPB8Bkau0qRg6gXwbWD93NkIzvaldGrdPYbZCwhjhocmYhVJZ5dJ5873ClQpprZT+KYycvXEXqq3gdh7FMi9LX8LxMv77l6xkhZiwcvT+z/yskY9VVk3Uynw6LaG90boZtYB1+TBZYcCnc0aCV6ZdZ6pfrEtel0I4Sg/3gY21gqvA4ZwrdONMtc4iw5PljLRk4pzAd5lYm1iGdn9F0T9rREEDGxARxvnZQyqhHCo+JnPbFkTA54CEtgVUJWyhDYucYM54oTS9fA7v2c0BkxlkghrlwB+eDBd1OhPznNUD4W+Wc3xlqnkvBZ5HquOtoC8Co9WOKlD/MDFvy+MyDJ4+8CxzpbuK34TuGoxccbSMzs4mC9OopWanPZ5AqmpaDcYYCCvqnWvR8n85Z6+v7iaBjZWPRFz6E5roatQ4B0F8a7FLr2s4Ne0mYpdf/9aer6C66L+0X3e0GQc29dIlIWZWDGIo8Zx4KyTAVOzZgA//zZ7Kefy4hIJA4dWZoKqezE+hNuMaoMcdh6NMvwX+g+qeZivz+QMvqVQWFgA+pI0iKGKoC4Lzlc29xxRMap6TclRSUIPKnOM1MFbFP8ShJUhHcOj5c/eoWfq9isvFHG5oFUzY4lZrB/Idz3dh9uJAUVOky1yCwoapga75ue8e2XxPUp/GvCfbwdPlvEMFcVBfXUKy+KTs2D+9ascGl6mjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB4419.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(1590799012)(36756003)(6506007)(4744005)(2906002)(26005)(6512007)(85182001)(66946007)(66556008)(66476007)(66446008)(8676002)(4326008)(64756008)(31696002)(41300700001)(76116006)(86362001)(38070700005)(316002)(6916009)(54906003)(478600001)(5660300002)(8936002)(6486002)(122000001)(91956017)(82960400001)(38100700002)(71200400001)(2616005)(1580799009)(31686004)(186003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVF2VG12U2FyZlR2RktRWnJVT3JGMkZUVDhHSW1HWlBPSS9vZEVSODhhcTdp?=
 =?utf-8?B?Qm1hZVJ0MkQ2VU9tbFBoZ21tYzVET3UrMDBtakwrK2FRaGkxTDdwWW00MW5Y?=
 =?utf-8?B?QThOQmVocUxyaStxUExOYUxzdjU1V3BMRnI4ZlRuZmdkcmFWeWIxbFVtVWNJ?=
 =?utf-8?B?Yzc3bkdrMEc2K3pLdEoyY3RIUW9ZSEhsYXlnMEJlU2s3Qk5ubmdYeG8yTWtG?=
 =?utf-8?B?aE5mYnZPWHphNWZzbFFiYWtmUXYzQlpLZkNyMTBjU2o1NDZDTnNxNVVtVkNj?=
 =?utf-8?B?VFVSQmV4aTJEbmgzUDQrRDhVR21BMzJLZXoxUm1CWnkvdVZ4OTVST2ZsS2VC?=
 =?utf-8?B?cE9lVURuU1dkL2ZJWGFYUXFYS0cvODYreUJHSmFiTG1uZm5QcTNHYUxUSFJo?=
 =?utf-8?B?YjlSZG1ydXIvUkQvYTJ0bUx5R0FzUnhlTEM2aVFQSWU5VFFQaDNCbEZGOUMz?=
 =?utf-8?B?MWdZRWJKMy9qbkVla0tTOWRnN1l1bEJEVW93UGx1ZGNvc3dES2JZUW02MFl6?=
 =?utf-8?B?VmloUEZCZGl2K25lUHdkR2RxbkNMak9TVjBiZzFRcWlFSGRicVpPcTlsTmU0?=
 =?utf-8?B?MjBaSElhQmd2YklhS0RDTU4xSGM0RCtEZ0REalNxS0NUTSsyZHQ5dk5HQUps?=
 =?utf-8?B?dTYxMldJZ1dhZ2JpMWFSc2Y5TGF0WVd2S0p4RS90elVxbVU5YTB4SHdSOS9L?=
 =?utf-8?B?ZmJ5NGNKSzdxSEtBYVRwanVUNkVPSDV3dlRQSzZ4c0NQTGRTUzJaeHlobVgy?=
 =?utf-8?B?WXJIbU96cU9Ld3M5K1hhTlhnTnkzTHN6bUE0ZDBrYUsrQTVKczJnQjJEODZH?=
 =?utf-8?B?SVp3REFVTVp6aGlUYjVhcUwrYk05eGpaZUt4U3V1NS90WVl3V3M1MG4xazY3?=
 =?utf-8?B?RG1Ua2pRaTk5NXJ2SXJuM0lGeVhVbW56YWR6S1llaWNRUythQWRrUGRVKytz?=
 =?utf-8?B?RG82REpvUlIyY0YrdDJSR0owbVZmSE1mcXlZVXR1azFCcjV4RW82dXJsSkE3?=
 =?utf-8?B?OXZwSzhzMXFPR3BteUVzQnU2QjBsa281NXB0R0tqWE5tK0VHem9DYkladkpV?=
 =?utf-8?B?SnBlK0FLUklVVkk1TUtYT3BpakJTQW95Ym1aTGlTN2xjaE5KUlVhMEUvM2Qw?=
 =?utf-8?B?aVhObDI1UCtFa3Zad0NWQjh3WVE4eWN6akthT3ZmSC8yR1Mzajc3cmlCNEFG?=
 =?utf-8?B?UHR1NzBkbHVZN09hU1hQSFRUaTVvdU9zWnRBZytPWGl6b1hjT3FBVDQ1cHdT?=
 =?utf-8?B?U2Q3bVQxSFBhSzlXK004QTNiR1J2d0dxaW8vcnZ3dGtxb3BSZFkzaFNSZnd5?=
 =?utf-8?B?OUxveWlqYU0rQTJJTDZwenk0eXU2K0ZjNmVaYkhCcGI0ZHZ5VG5GTUI2Skwz?=
 =?utf-8?B?eCtyd2ZqdzQ1aDBaZU1iQnJJZnB1cHZ1NjZMVmJNZmVTVWFBSzVvbUVuVDZ4?=
 =?utf-8?B?SFlta3R0ZHROT2I1UWRlNVZWanhKWWVkZmVSdVFPTnRXbUoxNFJGUXpPZk53?=
 =?utf-8?B?YWRKaWo1dTMzbVJ1c1JKdVUvR0ZFeUcyU3htaFc0dmhpaGxmbC9ZMmNuL2NI?=
 =?utf-8?B?VHp0V2FzQTBtaWY2ZnNGaDNFSGw0VXNpL1gyNlVLL2s2QXNkbXJ2Y3RYSm55?=
 =?utf-8?B?eUluK0FHNVZUdFJkejZITVk3SlFnbUQ1OUt6WWhrU2poNVpHeUNSV1FVUDZ6?=
 =?utf-8?B?ZG00Z1RMSGdXMlFmdWRvZSt1ZkxRZCtiOWUvcFoxZVVrSzJnbVFFTWFsQXQ3?=
 =?utf-8?B?OGpvVW1ONUdCZFZRRHp0RlN6OUYrRzlDM3pTb3R0bkN2UTVQQnFrQUsyVU5r?=
 =?utf-8?B?MjBRd2JvRE1sV25ZTldHWHBpaGJCVGZib00rbUt0VTJOZ2U0dDlGTm43c3dy?=
 =?utf-8?B?OG8wdGRNanFPanExaFZIWk5jeTVCbHNxM0NxSXE0ck02eTNFQnRzM1hFK3k4?=
 =?utf-8?B?cjlNNGdzTDZ6eUdsYjduZFVCV28xNk11cVVpK2Y2Z3RseENaRi9Oay9tUWp6?=
 =?utf-8?B?dXozSVB4QWQrcnlOUDdnVmZieVRUZVlhdUU1dGYwd0Y5VEw2K0FrNWdUaS9r?=
 =?utf-8?B?RWx4VE1yOUkwN1REbGNzU0JoUEhXcU0vaUxGRWJsVmdJSi8yME9rZzVncU5U?=
 =?utf-8?B?M3VkNlM3VFdVa2Q3aml4MUlUNVdqbmV0Q24rTEg4dXZCYmIxeFRqR0grczdC?=
 =?utf-8?B?Znc9PQ==?=
Content-ID: <16CFF85FF34742478F925FA73708F6CD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4419.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db852f3-6f60-4a5e-f0a7-08dab62e92d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 02:13:57.4566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wL3OqwwRaaqyDuVwABOc+rOg6W7i3Z2q5bICXCQAyRvixQo0ID3LVV5gcJ+0RPj6Q5MYm1KH584GfaPkCkB+TQS6xoDKYI30QsjRYq/dZ0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5358
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mount03: Add statfs f_flags member check
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

Hi Richard, Petr


> Hello,
> 
> "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:
> 
>> Hi Petr
>>
>>> Hi Xu,
>>>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>>
>>>>    static void run(unsigned int n)
>>>>    {
>>>>    	struct tcase *tc = &tcases[n];
>>>> +	struct statfs stfs;
>>>
>>>>    	tst_res(TINFO, "Testing flag %s", tc->desc);
>>>
>>>> @@ -159,6 +160,11 @@ static void run(unsigned int n)
>>>>    	if (tc->test)
>>>>    		tc->test();
>>>
>>>> +	SAFE_STATFS(MNTPOINT, &stfs);
>>>> +	if (stfs.f_flags & (n == 3 ? MS_REMOUNT : tc->flag))
>>> Wouldn't it be better to add another struct member for this check?
>>
>> Of course, it seems better.
>>
>> Best Regards
>> Yang Xu
> 
> OK... Petr are you going to merge this with your changes?

Thanks for your review, I merged this patch with petr's changes.


Best Regards
Yang Xu
> 
> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
