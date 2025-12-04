Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8B8D1D87F
	for <ltp@archiver.kernel.org>; Thu,  4 Dec 2025 07:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764832974; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=t4Vs95KpjlMVhWp6MaGJNUVg4qWTWO9wvbnyrmCUqu8=;
 b=SnTXyE4ERdmUs/0rcpY0OOPHTk4OMaNr+SIwYnr3xVUPq9mvcQPz1hp49zJta3lFjcYj0
 u0pFG6csID2GJgJ5armMLA8OKmc3oVzKZIw8cz3/qJGMaVwa/qOOc7J8xZ4NnXArIJpBPID
 TbbiSRQzcYyZEvw5lGu8Hhb7/ODKIkA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D8F63CEF7C
	for <ltp@archiver.kernel.org>; Thu,  4 Dec 2025 08:22:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70B823CA7D5
 for <ltp@lists.linux.it>; Thu,  4 Dec 2025 08:22:34 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 57B7D200985
 for <ltp@lists.linux.it>; Thu,  4 Dec 2025 08:22:30 +0100 (CET)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B468kOg132937; Thu, 4 Dec 2025 07:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cAi3NLTrOBfJa1Uddb/HtmkdCoyREem64xQTEoLRrEg=; b=OsxwqgUQrlN5SHVt
 QUHlNuQo2PAaKF9+mINwPII8CJ0HCSgAR1tOoXsqjCFa6QIZTE4rWZDJktx26gUl
 S/JL1Benle4+15nVHcJr3XtO7HGBA11YvOqo8XNa3u+vndogou7BB/sVW9FX7n4e
 XGBSPJNdte12wqAk5jQsCZoelHShBhnOMBe9077FLav8H8hoUdBZOjPlR06EyTEZ
 283gztTWWyH2NOo4bwuWII/KYmoHOh3GH66HKZuvdEUZVZzophTB7+fXX+9rT4tB
 HPLVQssjH8jXGQu07A1zaMgLjQoAYpB+LMFsNiAOB8qppPX8OGK87ok658cX/D28
 pKiHwQ==
Received: from co1pr07cu001.outbound.protection.outlook.com
 (mail-co1pr07cu00105.outbound.protection.outlook.com [40.93.10.93])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm0hu9mp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 04 Dec 2025 07:22:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riPVlALRkFFNtvmDvJ3zwa/zBelAOTxnKyh3cNUGsbPv9OfrmkhudvRwHs3MFL6jMatZlmCEPEWaqhZ6eCB/wp6Zn/9H9Kvq/RQ43p2bcWcwY55MMNaObr8WH3i34VYnw2Z/dD+ZmVKLphaiC/s3uwysey2k9+71wV4z2SBrhH5vyExf1V2QktRanjTbNtjWRm4c3dCnNn3nAER6d1cnRMDHxaNYmU2mv4oyIkkjeguiNj55FV8S3y7Zx8Yc8Nsw824tOgS1dxhTswohZR/ubo1YNe4IYjbv8teWtzaPgeeUucvB2TKzamAPjBExYuUxT8TDOpKNoe/NN5Gm/ExumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAi3NLTrOBfJa1Uddb/HtmkdCoyREem64xQTEoLRrEg=;
 b=OGk2DSYMfDugVIQ/N0QsyGmPRRUMSAPM74NdCihDN5UsM0F0fk5nu+ID8co8lqeNgIayi7D9Zf0Y5oBFIgcSxGaagMo3ia3VuJHQmAfX5lFYvWHfEVOyiAagxkVDqKa5UnfBtuL7qbKWniGJ9b+nyZ61+T8rgID0btGSMoDF2mkqNfL2E9NkwW0cYpJOU60FN31SiIZse5pUz1IYS2Nhd2saxem7b0IW9MOVEaE/XkajWFUzSr/qXYHyngpeyQZR1nlfxTSHmy16atdFfo2hqfQKf6ObFdECdQ4d6t3IU00QaFF+hs7L1EJTu2z5uyL34+PtAwwqfmHF9d2MRUQj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA0PR02MB9145.namprd02.prod.outlook.com (2603:10b6:208:43f::22)
 by DS7PR02MB9508.namprd02.prod.outlook.com (2603:10b6:8:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 07:22:21 +0000
Received: from IA0PR02MB9145.namprd02.prod.outlook.com
 ([fe80::8b4f:d89e:ba0:d01]) by IA0PR02MB9145.namprd02.prod.outlook.com
 ([fe80::8b4f:d89e:ba0:d01%7]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 07:22:21 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>, "chrubis@suse.cz"
 <chrubis@suse.cz>
Thread-Topic: [PATCH v2] dirtyc0w_shmem: Add minimum kernel version 6.0 check
Thread-Index: AQHcYDMHeYlgW4Coi0OZRnq4VKI1hLURG+Lg
Date: Thu, 4 Dec 2025 07:22:21 +0000
Message-ID: <IA0PR02MB91459B3A455BB3EC50D43256F6A6A@IA0PR02MB9145.namprd02.prod.outlook.com>
References: <aRy0-9KIPlRBvnNk@yuki.lan>
 <20251128064808.3865023-1-mananthu@qti.qualcomm.com>
In-Reply-To: <20251128064808.3865023-1-mananthu@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9145:EE_|DS7PR02MB9508:EE_
x-ms-office365-filtering-correlation-id: cb083dd5-6c47-4dba-0882-08de3305dd4e
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yYKLoazQbM2tsYm08yoojLkzFzrSoJnd/bbJ4KjoH1qZlUVGJ6yELTmGgfIr?=
 =?us-ascii?Q?nE5rAgM1POQrGYoT/nXQnDspYcjuqk6Vp6f75zoOYhAZxsLtfYGuVpoDQ6Zm?=
 =?us-ascii?Q?8ku05U/AIv/NXcolsIx8TOsn47iex0hKc9V1/P6j3p6HTMJqVu7Kz+xOiBe1?=
 =?us-ascii?Q?4eFZeKWsdqbGcxLHu5JSYkeRnl7opo7mfiI4tcnny58zNR0lKpThQxRJPl2V?=
 =?us-ascii?Q?pcHP39sGCcf4epmVEsAMKVidv908Rt2veX1avBYl3TDfqije5y/NR9wqdL1H?=
 =?us-ascii?Q?7Kg36+9G1aYJw2k2673awEMY6srRoMiaZatazvUYvEQYQo8z4a8CQ+EVx+bu?=
 =?us-ascii?Q?/iivlGV7g1HXVstGrEkwahPYkGojnrMPw9JR2l4UfTFexc5G5D2uzGwxigIc?=
 =?us-ascii?Q?/I0VFbMdmycSw3vKsfm/ALHJ8Wm/C7n/4yZfb3dT9ptXDvAgDdYvY8w8OHwm?=
 =?us-ascii?Q?NqdkCoKSrPY7pcJi6m9A2oKf5BpJY4HwGpk3QGDBhBktxbra9ejg+elkpy5d?=
 =?us-ascii?Q?E4VuxGEajmRjiCquvII/Hcu+efwF45Ge4Ym4QJLrH5pIxQ96ENIAHuHoagay?=
 =?us-ascii?Q?qbCoJiymmbqyPHN6ZWBWyUNoWSCK9SCtEHBKpMGe/P4WCh+W+fBJSf16+RBa?=
 =?us-ascii?Q?kO+qwVc1gz7anagRJ/hFCyB7SlsLsdvamThcnrqn8jCXbaGFNQcNS/eG/8yN?=
 =?us-ascii?Q?YnXEEzSIoF2bm9dPmAEQWvouY84SCYLUGbNW+KTwHBL9VtPU3ekHQG7SttID?=
 =?us-ascii?Q?BWrG6jURz/4Nuy493A9A5N7KffE0bkBBXc0eb/rh+H4x7hVNXSefsZKVeRh2?=
 =?us-ascii?Q?ZkbXlj2v3GED84uElsKOCLRZohpT8Bm71qtXTahiw7/RWTFrFZiZiM21dFs+?=
 =?us-ascii?Q?MINbSEVVnpFo0WIEwOXDVk9Y4jS2PS8ilGSOe/98a3QSlDEiVX4m/J1jVY0W?=
 =?us-ascii?Q?+wz0zB3aqg9wUPzHoO9woSXmpqFlUyuWVr4pRSZEGp1urqTTmgk0ovcZ47Ki?=
 =?us-ascii?Q?2nO1b30YsWOJNQMLW1QGfG8pRcJRGzuqJE2RG7S9zBdCmZ7ZSPaSO4JXdyaW?=
 =?us-ascii?Q?dJ5CeeBqBZ+th1IErjqLBDgbFmk9I2xFM/oxBtOBsarUkO2yftSlaiRyfYAh?=
 =?us-ascii?Q?1Wh8cl93v4cXq8rYPGhWMijF3BKxXWHZnTpr8I56jASRnMa5CpHinKMHTTr5?=
 =?us-ascii?Q?jvc478KBazj1MuAouG+FSabK7xF31kC4B7u+30678W7B/xdZ+FLWcQ4a1xHd?=
 =?us-ascii?Q?I0E5dIt84sdgXaZXTX/+WofF39MJj2wmIe3hhek5ZEIi3o2LDSh2eyFjct0l?=
 =?us-ascii?Q?H6yqZRBNfsD+DK8+T6cN1NHkNL0980OtsoP7+nEkSBbzg39nVXR6JB6Bevwz?=
 =?us-ascii?Q?yG2xYOjFijh8Dtm7OTxwq7G2zjQpIEgdrSF8vzQLRn2tJRDE68EofNMeBi2o?=
 =?us-ascii?Q?5qKvCis9sGGXUO74e+VHzt4oZl+PHUQiLn+EWfOTBLQU3gLJXj1r19cysFvL?=
 =?us-ascii?Q?Eb5VId2Zf64jPHCxpgXMX4kQb+FXLfzxpAxb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9145.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I0tz4aTdmPmRR+bLttVULpXd3G4p5P9WxN+0kYuWfQN7AJoTvCpVBzl7NIGz?=
 =?us-ascii?Q?WNpeXLcVke5x2R2mDAH1vRcQwPWj6TVW1SLmuKJNVPcfzX1UurH9hngsAhZa?=
 =?us-ascii?Q?6DbheydkKGFDDhlOvuIEJNzjxKO0BQaZ7ZNi1NswaSf/4AEq9Rk5d7Cpz96F?=
 =?us-ascii?Q?Kw16TRB1gqHY/JHUqewGbbDMjSASc8Ipbv2icciAT1Cvfh22EKE5kS3UFYKS?=
 =?us-ascii?Q?kui82ejjHhYq5ojDaBuU5Yn2bM9YHDqL0RMdl/FVaI0qPQT67DWmzBrOKhLX?=
 =?us-ascii?Q?yoFaMYjTeN9mQMXo5iMJEgrcGsCO4B3y4JIMCXcg6qAW0iYhRn8p6bB7jG0b?=
 =?us-ascii?Q?oGTf1Ba47zu4iHT9tdx1R8X0NfsliA0bC/r8MaK3atqaHLALKFKcW7B0eLW6?=
 =?us-ascii?Q?kta1FhIBdlWTDOaJqZSdFYzvKEHDWajOv/SFBMxPCTITo/nIkEltk8YNNf/a?=
 =?us-ascii?Q?7lsrJerhjvAEykqokrUxB9R0365CF5rRg8DgVdsjkfe/f/ryADbcRMtyIFi5?=
 =?us-ascii?Q?NzltWSpMB5+eNlnZhzwQ7FcQIfu22TY4nUIFvGkKrjPZ8m4RYS8AA7EKvYx8?=
 =?us-ascii?Q?tb2iAngmjy+eJtv04L9nkJyJM+oMY0TuXXMsDufkqb+Q5UXc8y31fKim3s+H?=
 =?us-ascii?Q?7vm61lTYbVFMq89wJ+iuKnzHrE6Z01+M+km3Dbyfl4oUUvyowz6YiLwdCicw?=
 =?us-ascii?Q?IzdVrfXTHGLEbWx9/ks2JMuIvpHCeOqqyguxMX3yXfBjEj1kMdK+kcRSmRTA?=
 =?us-ascii?Q?fcwjcuwe4bidtYvTQpCm8S7zS7a88LS/usF1dLqxvWVTovejrrL/9okx2KrS?=
 =?us-ascii?Q?Q+fxt0sPe4wWvhiinYHF6Ejs+XTvwelvbUH5pIakvkD9ORhh6CBHnXSsnobc?=
 =?us-ascii?Q?11tq2UT1xbdCZvU4jtaxj7+MS+YElH4Dr8V0+naSvl0mwIW0chFsJuZLWyWv?=
 =?us-ascii?Q?LJEGXUgOnW9m3sXqEPKnUXbb1o/9n/BBlUaeZYfqOkMhXffigI6yshCRMsXy?=
 =?us-ascii?Q?qXYzZdb3KH01FyJYWzKtCfKURFGkBabUeDCqWdvwY+p697I+br05DNawIzTm?=
 =?us-ascii?Q?D9iCrGWF6nQjcNQ02qN2YC8WJNT0CKWJkfh79ilvZiHVPTuO2wNgNtZUaQuC?=
 =?us-ascii?Q?Pv8c0BZZHrZrrT+Jo/Cs6Dg0QauhKGxdUxzEvoK15t0XAqy8LY7l2ZBlbQkl?=
 =?us-ascii?Q?uhyj27oNzibb6NP6qM8E4Bx3vGzMe/r98Ve7wpulBn+QpmNDNkezoHTaHBOi?=
 =?us-ascii?Q?yBH3nRzcOXoRrCP3BEYQQmzec31sDsVC7cixn7pUoE+bSu2I4rTtbA2SCLY/?=
 =?us-ascii?Q?5t+kHPrVFf9FIzxCcynfsbPAixQO30/hn1rYtTk2yr8Ru05p8Pxqzbqsj5gR?=
 =?us-ascii?Q?TBF38spVwCkqBa+TmQG31vAitVJJfxygzD8pecIhevAv7zrppBPH0MJJa73I?=
 =?us-ascii?Q?qjq5FZxO1yG3WD8GMiv/mLAAviDh8zc831le1HQIYsyDir4Cu6ZfrL28+MOo?=
 =?us-ascii?Q?dj5inuu4FTyVcUHmV84cMgLzzEpn5VSTGjy5+69yipWpKi7oFcHgcOTbIA52?=
 =?us-ascii?Q?Dy/+QswfNl5drPIQu9jlR8+bwdFbh9qkyF9afLrz?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J6dq2Qy7qO7PzNjtSFME/Gy2IaL9zyno80NeEOgBbkDpFWompexND/zhDPOFi45lOCDAPAisZdqxkbZm9XjsomYtq21id9mCXo+bBZbDLsytX9PxXyq0ag5VMpoc/EAk2Ogko4UUi8SIGU/9Nhnk9KZ0JBX5wnH9RkEuDtP1M21VIsUmBy/Sh35VaDVR3Nx2VFTfkF5/2pl7UkwSMVhpoLx0427ViiOcKl+cbf7pErHc1EliqeVP7xKZQC2fbUcW5KtDYkPjiZzx60EPW4SgtoJz88d0ixNwWiIzR0pOaOMS7hqyNB2Pafl0at5AlNJzrNcotAwYFs5hpvW2VP9INx/j621JmGblfMFbnOf+2JhP4jJA2UUDTKqjtc03Jw6NxLpgheh9GhKE2OrZ2HaiaAJwDpGR91lUgjyS+eF3ikbCDruoRWSV3nbKuJVjHEEWNCIilmt98sI94/IV5EnZ92XkZ7R7LINNFFxVDJmjDqpRB7cXPfTtvClHxRetl9VK90YCXQbYSHO/EI5nFNAIV447EmvtP9zjsl9sw2MCWKkA76ypM16XA2nAVtn8ZufTn+p9FJBbMNhxzo+5aGZH4TM0DxAk+dGa/ek088YoqIu4QuXt+krrKXPcToyNe+x/
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb083dd5-6c47-4dba-0882-08de3305dd4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 07:22:21.3514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAZG+ArFdAO5TuOgPZX9+fJ9aTeMp62mNra8Ay6GDOVBNOkcLkTfrWwP/UzA6lti+97a5v1O+Fqon3/EAh7FO4IGcHbwkHpTAy9lrrpRb6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9508
X-Proofpoint-ORIG-GUID: BKVkLAoXMbGYLx24kxq2WYk1rL8PEWKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA1OCBTYWx0ZWRfX+U+H68UpMjcq
 T+CfTeI/xY/f9Lzs35/itv/5rFcZ6uQENomk/7pPyMi3hmg84b+9oW/wspqoTfRW2LdGAXR1ZTL
 7UdBJZ3EM3B23ib4JBpK15TxeLdGZT0uVqSDATlIF+aQfA3WgJPNAFSGgkod0zs/UR1gfc4RsBA
 4XegWs+aNRwDWFkE9od2XgL+RMO7nY1Ik36X50V6bi8Wlf3WfUaOPXCQJdzIxi1jROmfxVGFZ9s
 aXsCw8FBVWEqk85qp6dWtu3Oq4HF7VXFWoFmqVs7J/MxKQvxQKc7NjbM9JwVGj7rAFU6ijRqYIS
 PDYZeZlihmIsOHTRY7P/+qHLM9kW5CCLPKkavEwFRPXizvUcSyjwjo52ndV3h9iyvD0ewlMdfY2
 gEWjuazCaNYZZGbaBNeVGRGV8YmmdA==
X-Proofpoint-GUID: BKVkLAoXMbGYLx24kxq2WYk1rL8PEWKx
X-Authority-Analysis: v=2.4 cv=V5lwEOni c=1 sm=1 tr=0 ts=693136b4 cx=c_pps
 a=q5vO//TkXWYTfB+U33r3ZA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=COk6AnOGAAAA:8 a=lFR0lyDagDS_Z-kbEe0A:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512040058
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] dirtyc0w_shmem: Add minimum kernel version 6.0
 check
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
From: "Madhu Ananthula \(Temp\) via ltp" <ltp@lists.linux.it>
Reply-To: "Madhu Ananthula \(Temp\)" <mananthu@qti.qualcomm.com>
Cc: Wake Liu <wakel@google.com>,
 "Kodanda Rami Reddy V \(Temp\) \(QUIC\)" <quic_kreddyv@quicinc.com>,
 Prasanna Kumar <kprasan@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Team,

Gentle Reminder

Can you help to merge this PR https://github.com/linux-test-project/ltp/pull/1274

Updated the V2 Patch with Review comments.

Thanks,
Madhu

-----Original Message-----
From: Madhu Ananthula (Temp) <mananthu@qti.qualcomm.com> 
Sent: Friday, November 28, 2025 12:18 PM
To: ltp@lists.linux.it
Cc: Wake Liu <wakel@google.com>; Kodanda Rami Reddy V (Temp) (QUIC) <quic_kreddyv@quicinc.com>; Prasanna Kumar <kprasan@qti.qualcomm.com>; Madhu Ananthula (Temp) <mananthu@qti.qualcomm.com>
Subject: [PATCH v2] dirtyc0w_shmem: Add minimum kernel version 6.0 check

The CVE 2022-2590 vulnerability applicable only on kernels 6.0 and above.
Add min_kver = "6.0" to skip the test on older kernels.

Test Module: vts_ltp_test_arm_64
Test Case: cve.cve-2022-2590_64bit#cve.cve-2022-2590_64bit
GBUG: 418679607

Signed-off-by: Madhu Ananthula <mananthu@qti.qualcomm.com>
---
 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index 2c7ad00f2..9cf495704 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -103,6 +103,7 @@ static void cleanup(void)  }
 
 static struct tst_test test = {
+	.min_kver = "6.0",
 	.needs_checkpoints = 1,
 	.child_needs_reinit =1,
 	.forks_child = 1,
--
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
