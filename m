Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B103C77B7A
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 09:06:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31253CB27E
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 11:06:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BA073CB25D
 for <ltp@lists.linux.it>; Fri, 19 May 2023 11:06:28 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4B09110009F7
 for <ltp@lists.linux.it>; Fri, 19 May 2023 11:06:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684487188; x=1716023188;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=FhWKX6s2O5uzQplSYCNZMkRGkWc7wAlBAIiRyY3J+FQ=;
 b=IOjUleu4Y+Du5UoKNRFD3su4ALpSPjT5F6fymQ3RU49/19SzB4Nemfmx
 yv2gG+Dzgm5tfXQLz2du3O2keomvYGIhPuOSJkN+UEcNFtLXPoX96qhdP
 Lp0dkgaLM0FQT5/xJUr+1fFYkLPHKjhvlUKUNZOsMLVgYkFQy6l8fywxS
 1HuzDlUN2ENqsDSnsWLS5Nk3Fkgaoir0AXFrR6IYXAGAf7qVkIH6wEfvO
 Vh6RHl0gvjGYCkvG0GvKZioRRyOZQRuJQb9TKk2BeUXJpsIt2k45T42Pu
 d4LB8OPn2HBhuOn716QfFXpEcIPcAdaDQhlnhVe3oQfNgQO2I0HkySMeZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="84677088"
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; d="scan'208";a="84677088"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 18:06:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT5ozXdwDdrXaWPiQAKAkR76zNUw1Gcq9Dd3fcbee/vbvW0Id0MetsZOfGhdi/m+TQUcvcd67uHb9SQ1vCU754kHaQ6eyJB37fVPbWMN232xRegJIEU6BG2ZzDIciYwIuTxeg+76XdDXJq85y3GN6g1ev5n44iZl8dX4MfMeTEJrEukTwKg1xbu35YyboQ+gUtEtm9nSjrHbIJ5ZCFK/bu9koqU9WvRmln6IjIWDzmB6I4YDHYOUi113V8AjDsqXPqAxV7XiX7Hl2kJm+xUDNr842zTDeW2BgE+PF0Gul9ZPOax+bNBK0BqovjHqKdGvdrRyeVyxnWurClykCqTuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhWKX6s2O5uzQplSYCNZMkRGkWc7wAlBAIiRyY3J+FQ=;
 b=fP6WAw+HxzHVOBjT+qTsZx4jcAZdoQv+2jS2ndT/gvBoNln9qYb/pvGhxRLG2SIMb8t+8Fa2t8rUo98qB4c1DPUUj1GU7vEeJJA+LNwyFDV4CbdJ8S2hZgaZWxk1guYUE41wcihdeuWEbAdZL6ymOs2VE/tNJaxPRdmqIy9wFcgiTnOLtLZ8081QJqCgaQMDnEvtpQh1a0m9lPekvvqNckwI35FyaXM/ZBrYz8n1oo/BD3XWsy47eLP2JKxnGW/3qLqloy+k+ld99Q6dWKZNjSy45qrn3wfGi44hjIdyfZ8kDQkTgKDyg1FlnJkIyLkJKmiuBzKEMsX82R1sFvAJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYCPR01MB5630.jpnprd01.prod.outlook.com (2603:1096:400:46::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20; Fri, 19 May
 2023 09:06:22 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:06:22 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 6/6] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
Thread-Index: AQHZhvyB8eeOeRn+WUy36WgWbA+8ca9hJ0OAgAAtHYA=
Date: Fri, 19 May 2023 09:06:21 +0000
Message-ID: <7f8577a2-9aa5-2a09-9aa2-418d5c5d1d1b@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-6-git-send-email-xuyang2018.jy@fujitsu.com>
 <c90e3176-0b2c-f5d8-5314-984123d40029@fujitsu.com>
In-Reply-To: <c90e3176-0b2c-f5d8-5314-984123d40029@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYCPR01MB5630:EE_
x-ms-office365-filtering-correlation-id: 15d561ce-d6e7-4513-16cd-08db584850c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bk/CzGJ//yMIabCgcwYEdjvyUKcow+3TvlwsOKdXkPoywNvpxp1y1JBIL7tZKN6LxZtTtI/pciImR79j/8BKS9q7RBQVo+T9STlgQheFqWFpR7SPdFDCsugtxb2zVoEMsEp9EMubs12rYTRZ5x9LV1eQ+JKMJxbcBz2Lh+dlY0yP0PzAqf19C6XTqUbjfPl2Yd3D591XJynPGrfedQIz/mLkiN5bjFo9XDysnla+uaWACXdJlp+EJBPIZpdLOWB55DRshC8h7bKma8HOrKOZb8jKUqC/hjYJ3yZEHaMwelBGaCY8KKINYtjaCxfCvrzztIyTnQQrK3+s5qCnnGG7TgIvWbfrQDlyA9SAImsYIrW2Dg6QnV7QuCGDbJ1m7bNU3zw5Pwx7Lwr5V2l+H6IZdOtEPeJB1iOq7d1gsqvNwjlU/YA5fWSDXBpmiY48EKicFNSWmVK0L9td9hZ0FN3CtSONR4QeipcuYUMfFNrD00Z6cHcqBj7buku6CuuzjodlZSEV0j6PDJn8Quq9k6tAE9gdYSQYNqC0S4l875ZWSt8F3gd7K8e99iDmduzlRlsae/IzqH8pEpB6RQH2yRK8x+SutMY2JxRIyhrnW6HyNA3+wuJP4zPr2YvSNNS+ohpDGfuerD3URCVmtRGFknf7sCpUuUBBPV1hSR/pd40LhgokZD9C9NxZDMptHC1TZMFr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(1590799018)(451199021)(71200400001)(6486002)(41300700001)(38100700002)(36756003)(26005)(6506007)(53546011)(6512007)(83380400001)(5660300002)(85182001)(2616005)(186003)(38070700005)(2906002)(31696002)(86362001)(8936002)(122000001)(8676002)(82960400001)(478600001)(66556008)(66946007)(76116006)(64756008)(66476007)(66446008)(91956017)(110136005)(31686004)(1580799015)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEU4MGNwaDFCa3VjNkRpYytqTXk2QUxTMURqcVl4ZjJHbWFHRUh3bkFvdjhh?=
 =?utf-8?B?K0p1S0FHNXArdDVFbnp1OVRGRkpGMmpHYVZxYUhra1RReXRpR21vZTNJeDVK?=
 =?utf-8?B?MGxQMVNDbU5CZ0ZKWkhnZVlDZUpHV096d2k3M1NIVWdweTlVaEJhazhhZ1Ro?=
 =?utf-8?B?Mjl0WWtSR09wM0NUdEhFNWV4aU5mZVhBVkQzYkpZeXFYa2dSblp1ZGU5TlNh?=
 =?utf-8?B?dm1NWEZ4Nk5Oc1h2S1FiZjNUc2UwREkxZ0tBSmpUTTBPekFtSEN5NEpnODFm?=
 =?utf-8?B?WXcyRG1KZ2hNeWpmQlkxVFRLMXBxQktkb0Zqb1I4NnRiMGJvb28yMWlwdDI3?=
 =?utf-8?B?YjlHa1djb1RIM2NVL0kzL3RLL1JDVzVvUS9JT0o1TDhVRHYvZUZyaFlTWHFn?=
 =?utf-8?B?dnd2ZFoyMjFIZWpUd1ZBNWVIOGNheFZYd3U1MHVnckhJZU5Xb3JKM3NQQi9D?=
 =?utf-8?B?YW1ZMmY3SWNQbWNVSGM1U285cmpqRFhrSWpob3hFQWRUZlVHaDVoNSt2MUVs?=
 =?utf-8?B?a0tHZ2NiT3laZ3ZQcXJ1bC9hUWh0ZFFUZElrYXl0UmxETmlJWnpRTFl5d3lm?=
 =?utf-8?B?VC8zUVRMUkNmV0pJQnNWdXUvbkRTWVVBUXNZU0JXTzBlM0dLcS9GbTh4WlZ2?=
 =?utf-8?B?eXBycjJNRmNjdFZMOVJ3OU10UVIyeWpCQnNGZDFXOEdvZ0c1eUFrNncwUWNR?=
 =?utf-8?B?c2J6dmhZTnhJdU0wVTNlVXMwUlZpdncrQ2VkMnhnRlk2SGZWRDU3T0ZVdlZS?=
 =?utf-8?B?Ti9rSDIzN2Vkay9XK29WL2Z4bFVnYjBQOUJHeFdTaVVxQVVVN01Od0xIMHFK?=
 =?utf-8?B?Y2NNTTJTOHhvWnBjaHNzUVBENVZsbFQvZ0cxd1hFUE1ScVpJSkcwMVBrMmZL?=
 =?utf-8?B?S1FZckpwUFkzRldYYzREaU90OGhPYkg4Zms3d2hWbXpLSXlqVVBwcE5acllI?=
 =?utf-8?B?Mm9iYjIxQnBuQkxZSWJyYng1VVdSdnlKR05lWFllT2lNeHZrRUU4Nlg4ckp2?=
 =?utf-8?B?Q2lIL1BMNXhjMjExZ0lpK0N4RTFENnpocS9lNkVsZGcySE1yRTN5Q2piZFNZ?=
 =?utf-8?B?R2ZodVAyNWZ6UDZGcDRUUnhFOVdyOE12TEN3NFVtaHZ0WEZtR2cxZkZSS2dZ?=
 =?utf-8?B?WVAwaFhnZkZaNGU2THhMWGNSTnkySUFQNm1HL3Nvc3llM2IyWnA3VW1sdEpt?=
 =?utf-8?B?ZVE2ZWYvOElyMXc1V211b1VIaHBwV2hIamVJOStwa3kxME5nTisvYlMySW9X?=
 =?utf-8?B?SWZQaXR3bkM1MG9lS1Y4SlFZdXA0MU0yci9KS2FzWkpvMHZwV2FlR04xRXdQ?=
 =?utf-8?B?d2Z3S0JrbDBNMld0MkpseTNhWVVNaFpqWmlMb1lmNm9DK2d5UlYybVZQbldk?=
 =?utf-8?B?UlBUQS9lbTdVSGREelJGUkhvU1pJdXdBZ0ZzeWlnRmp5V1lyb25KV3NzK0dt?=
 =?utf-8?B?dDVxVEZzNklubTdwVUgzMEdZTzVOK1BCaGF1UWlYZTdpbXRJSnNLRitiZjg1?=
 =?utf-8?B?NzJHUVc3MXpSRlc0d0JmYmNNVlB2bWVoZkMrMlkvdDJEdWtJTGlLeU1UTzhN?=
 =?utf-8?B?eW81VzgxOWhUSzVBeXFWU2lvbG82UWNqdnRVU0xNUDNOTllxcTBDMWk5RURp?=
 =?utf-8?B?a3JYYTE5SGhhTGEyM2hmYTBxVUFxVWhhTkx6aGY5L3RXVlI3MXloazZJV21w?=
 =?utf-8?B?Uk04QTdKSEFzSDAveFdjeTArMFVLZkNFeFl4dUcySGJQcHpRa3hWQzlxa2pl?=
 =?utf-8?B?YTFkMXhXY1EzN1l2WHBwbFV6QjdBc001cVJLd0tOeFhGbVR3bUdNTjIxM1hm?=
 =?utf-8?B?SDE5am5WZUE3NGZlZGRFTnE3ZSs3Rks2ZkF5NUlTdHUxWDMyZHpLWTZrNWFI?=
 =?utf-8?B?VHErWVRaWkpHVVRyVlV6eG55cFNJSWJtdUhoWUxlenZPSDBuYXprSUVTT1I3?=
 =?utf-8?B?aHFXMWhPUjNOd1F5MGdnNCtzU0RSRXhnRldmSzZUbVhaSmZJSTd2L2xaRFlr?=
 =?utf-8?B?QzJxUHBHTmxheURJU1dqMGMwRmYvNWhhNy9QZGczMldDS3pWSDdhekxCaUJo?=
 =?utf-8?B?MEZZUWhLRkRGaENrTVZ2a2tzRVV1WHZtdXFqZ1p1bjV1SHRSWk0zRGFHQlhL?=
 =?utf-8?B?VERlSU9FRjhlM0ozcmFGVnlSRnFiMncxcC9HaDZpWjhTRE5VOFVTbXJ3a3RN?=
 =?utf-8?B?K3c9PQ==?=
Content-ID: <0242550EBA9C614FBC9755AD10C124D4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JW27f8AqcIU50A//M40Yc9SaPsHoouIFBQTDParJ8ghGLDEL07PTkjmBAVO9QjXSbisQuUIZlzsbs2DmTVUAthToCZWFgnSmkonCASLDc6w8PPiwkYTt57vntGgInNJvqrSIWD9G5Mbq4RdufE5kDLVAmGWmDgAmwikat5aaKQwSfGpsu1jOhI3yPTjhGlB3jh0mvSaxYI3XdXTpB8QPiNBBXPhXv17YBTfK0VKKCIOpZJn1QVL6glAXFWchWMGGrckd6m9VqWZ67vkDP/bz2D1QmvlXG7whp5nsDP9/k8mNGJcUkdZTtRf5ZAAqnUyeg9XnJXC87toTOLIhc8qhxYpYspA1Vu5GPy9JJ6ouhLqdxmvmNCUfAvdyLAzKw9QbPDkUDBulINaqDf3dvIA20m0aP9uuT1AI10npXCg0OZrl12+yY/L8e6xkuwxmHe37tnE1BHnQhYjLL8mIN+7Z9eod1oElOjLvZ198vwSk/QY1WGbrWyqMYh7aLqOOCnnuNifKbvV2gRns0VsxSkPGNL6CNWjMsmPIxAI+c2x7jMCNrtrOJQ7XUorN/MiuiDL6Yy4BeZrAYY+LawcRnxxKvahOCvm/8ufliwx4U+WIPpbHXKw/ipI53SV2prUMiNYVZZrLuTtHTgA3pHm7XRbxmSzP6hZLqTyr/Xjq8UuGwACL44MmpICV8IH8Cu4C4qoEiZAjb+bKamIK731b+s2IdFglUB8j8NoscuXBR0TltytJipa5FCtU2/UJULONHQ3DJOvPQo9jvzXXIRsHA+PYxA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d561ce-d6e7-4513-16cd-08db584850c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:06:21.9021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWm/bpbvazhwy8fFZ0wKMQj3Iy+0yLskMgWYB/fLmQxGcWuA4+dmA2xx5wWa7uOI9LfRHXtE6pxJjAKAgNa4SwspspzZnlqny51oeP2zCqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5630
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 6/6] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
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

Hi Yang


I have modified this patch set as you suggested and merged.

Thanks for your review.

Best Regards
Yang Xu
> Hi Xu
> 
> LGTM.
> Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
> 
> Best Regards,
> Xiao Yang
> 
> On 2023/5/15 15:11, Yang Xu wrote:
>> Since STATX_DIOLAIGN is only supported on regular file and block device,
>> so this case is used to test the latter.
>>
>> This test is tightly coupled to the kernel's current DIO restrictions on block
>> devices.  These changed in v6.0, and they are subject to further change in the
>> future.
>>
>> It is fine for now because STATX_DIOALIGN is only in v6.1 and later
>> anyway.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>    runtest/syscalls                           |  1 +
>>    testcases/kernel/syscalls/statx/.gitignore |  1 +
>>    testcases/kernel/syscalls/statx/statx11.c  | 89 ++++++++++++++++++++++
>>    3 files changed, 91 insertions(+)
>>    create mode 100644 testcases/kernel/syscalls/statx/statx11.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index e2548dae5..e5ad2c2f9 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1766,6 +1766,7 @@ statx07 statx07
>>    statx08 statx08
>>    statx09 statx09
>>    statx10 statx10
>> +statx11 statx11
>>    
>>    membarrier01 membarrier01
>>    
>> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
>> index 67341ff2d..48ac4078b 100644
>> --- a/testcases/kernel/syscalls/statx/.gitignore
>> +++ b/testcases/kernel/syscalls/statx/.gitignore
>> @@ -8,3 +8,4 @@
>>    /statx08
>>    /statx09
>>    /statx10
>> +/statx11
>> diff --git a/testcases/kernel/syscalls/statx/statx11.c b/testcases/kernel/syscalls/statx/statx11.c
>> new file mode 100644
>> index 000000000..653050855
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/statx/statx11.c
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * It is a basic test for STATX_DIOALIGN mask on block device.
>> + *
>> + * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
>> + *
>> + * These two values are tightly coupled to the kernel's current DIO
>> + * restrictions on block devices.
>> + *
>> + * Minimum Linux version required is v6.1.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <sys/types.h>
>> +#include <sys/mount.h>
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <stdbool.h>
>> +#include <stdio.h>
>> +#include "tst_test.h"
>> +#include "lapi/stat.h"
>> +
>> +static char sys_bdev_dma_path[1024], sys_bdev_logical_path[1024];
>> +
>> +static void verify_statx(void)
>> +{
>> +	struct statx buf;
>> +
>> +	TST_EXP_PASS_SILENT(statx(AT_FDCWD, tst_device->dev, 0, STATX_DIOALIGN, &buf),
>> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
>> +
>> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
>> +		tst_res(TCONF, "Filesystem does not support STATX_DIOALIGN");
>> +		return;
>> +	}
>> +
>> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
>> +	/*
>> +	 * This test is tightly coupled to the kernel's current DIO restrictions
>> +	 * on block devices. The general rule of DIO needing to be aligned to the
>> +	 * block device's logical block size was relaxed to allow user buffers
>> +	 * (but not file offsets) aligned to the DMA alignment instead. See v6.0
>> +	 * commit bf8d08532bc1 ("iomap: add support for dma aligned direct-io") and
>> +	 * they are subject to further change in the future.
>> +	 * Also can see commit 2d985f8c6b9 ("vfs: support STATX_DIOALIGN on block devices).
>> +	 */
>> +	TST_ASSERT_ULONG(sys_bdev_dma_path, buf.stx_dio_mem_align - 1);
>> +	TST_ASSERT_ULONG(sys_bdev_logical_path, buf.stx_dio_offset_align);
>> +#else
>> +	tst_res(TCONF, "glibc statx struct miss stx_dio_mem_align field");
>> +#endif
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	char full_name[256];
>> +	char *dev_name;
>> +
>> +	strcpy(full_name, tst_device->dev);
>> +	dev_name = SAFE_BASENAME(full_name);
>> +	sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
>> +
>> +	/*
>> +	 * Since /sys/block/%s/queue doesn't exist for partition, we need to
>> +	 * use a while to search block device instead of partition.
>> +	 */
>> +	while (access(sys_bdev_logical_path, F_OK) != 0) {
>> +		dev_name[strlen(dev_name)-1] = '\0';
>> +		sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
>> +	}
>> +
>> +	sprintf(sys_bdev_dma_path, "/sys/block/%s/queue/dma_alignment", dev_name);
>> +	if (access(sys_bdev_dma_path, F_OK) != 0)
>> +		tst_brk(TCONF, "dma_alignment sysfs file doesn't exist");
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = verify_statx,
>> +	.setup = setup,
>> +	.needs_device = 1,
>> +	.needs_root = 1,
>> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
