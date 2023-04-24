Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6439DC7618E
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 06:36:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D1543CBCB3
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 08:36:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F19EF3CB302
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 08:36:17 +0200 (CEST)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F31F91A0064E
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 08:36:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682318177; x=1713854177;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OqxuT9cYIanT4jiEwwt8+15JRtDJlbXEV0PYuT3+0uM=;
 b=tKYab4MYhPvEsnOOR6fCSRflIrT8aR/54TrJEHBCyrs8qiMAlLLinPzk
 SmizBNVYxZU3NtSCaWv64B2anCk9FaPY1zM1uj22eX6PIdKpxAvwoyyFl
 78LXUBH5GSSmvLLGLklYpvN21bKjG87hYqfWAWOCopmoi49v74rqr84ly
 iEHFWfLtqAqHedvvzcT174ZPkUo5SRwfpC1flLZmpjoQhFpPCp7qEcm3L
 SpqmyaGn4Gs0WUmxrfe+joKP3KWblOHPGSArsc/g3glEehAj+acjzkVts
 99mitu+JXxeYOFeu2hZC7qBnha0G/t9ZcLQQMkW3zTu2j4fsL3lNaih31 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="90998896"
X-IronPort-AV: E=Sophos;i="5.99,222,1677510000"; d="scan'208";a="90998896"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2023 15:36:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOjkctrkRn1vNfk5upVVU5AfEi2vbGlPVlqV2++ulfAcBW1q3+PQaRIqVwdGONPunVyHSwYLrMrUs5Cy2mU07TvvyuXZ9lHqjozScWd1yZvMzt5/8nSvl6rNVzV5iQ/V82RisR2OAR4qVH6Kup3brM16SX/Pma+FgnS3oz1IoKO1BTnDNOQJi90Q3UV2P233rv55Js93Eg1fFRTten3fIpv1mPywYYRoBm2b4wyx+AuHE0cZf2M4l7+RDS1q9LMz9BIbb5OcXWjFQawpL65XFBxKt2f9XXVEHlTXKYslvMCR2Y+sO6S9vjUan2vbQQa7vflzFHdZISgvkiMv5WRBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqxuT9cYIanT4jiEwwt8+15JRtDJlbXEV0PYuT3+0uM=;
 b=bvWY6Pl764zsz/asTX2FAVpwSufoZkOJpequ55vWTfd9N5DdF9Nlbxm2kqiOCrSQRx9FCi5WX+4MMk0VQ6Hk/vG5Y9HeP+56u1DhPNmuxpaHXfI/LDJsyUqFRmlVyq36UQx9nDTXuJfh43qPaSUdBsTBDFSthQUVW/j7hGEpTw6ZNkRcQ1+AebenvwyVOsYsBaQtzHtCw17DAOiFPR0EiNQ7Av1VZDv/1YgeHRw1TvIuKkF/VtuMED/hFP7eMlQNullm3dJSJ1K9s0Fqy6UsRJJhPOY7AcGG04LoorukvuC/POAnZN1mn80wjn5b+2mySz22xnEAXkDIffo9+koVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYCPR01MB9465.jpnprd01.prod.outlook.com (2603:1096:400:199::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 06:36:06 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 06:36:06 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH 5.4 00/92] 5.4.241-rc1 review
Thread-Index: AQHZdCgHJZ/Ld8ZX4EqEULe2+6/cRa86BcaA
Date: Mon, 24 Apr 2023 06:36:06 +0000
Message-ID: <6e1522b2-f3c7-8dad-9a00-534b08498729@fujitsu.com>
References: <20230418120304.658273364@linuxfoundation.org>
 <CA+G9fYuT3N0LFaJGzQW2SYPJxEbEWLONDZO2OfBbeHNrsowy2w@mail.gmail.com>
 <ZD+fDeWVOXklD01f@yuki> <20230421080455.GB2747101@pevik>
In-Reply-To: <20230421080455.GB2747101@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYCPR01MB9465:EE_
x-ms-office365-filtering-correlation-id: fbc786f9-643f-4880-d516-08db448e2f0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNSSrju+XJr+0hBtUYGseNbzzbKvmJ8FJCdEm6bZZKyvUV86brsQ6U9l5SXm77Xa6BihoxIzYoCqmxynodgye8QtlA/wsj+OtG/adLcg6GEonI5DbaC6+4XEc9My4txPhlguePNuWQ9xB5iuEtWI7xr2Z62B1B7ZBk/XfT8kMTzp0Je09MqY0TQOC83oEoOql/kT8c44o7XAxsCJzPZimcqmLDpEazhtqYan4EjhpaWN+gVzGshFOyCGBFBT+tf4ESLpGu2HskQ0Z/MbszEQyIfwbYHaUkM+HtIEwBcBRl0kwmAwYq6L7um4Vo5V8A3g4Hb/dHLm5510Re5lPNmiooThUmM1jvwizRiWVIwmQD6T7iedXPCtlyMrL3ilboJRyqQRSWJOm0lGMxo2LHlMqm6rNl8KBSc6JzuLEUdbzLBPNQtQK4tSadB3p6d7u5JU4XUX0JsSTH2fHr+VXWdd2KvS6JOfUUHVsHHZd7VdjRpsa8Y/vjU3kHxM2WQW7gGYY3/IS7GvDPE4EJkR01SP9LSx8pMs7oJuUE3CMToe1Prp2Ekf4ey2qNzP+VbrALUPtO0aRQ3WGjObO7ATajKVtaVvgTFqujFkTxgA/JtL4vW8reS5Uq4Y5G7d0lqRbIESNjHJAW7FARPZ4JTZYBNykPo2P0yR06iBM4/eWem8Vz1E8uoQ/Mb73KxBhZlak9wCaQ/bxb1P1OB9obrLjse6cQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(1590799018)(451199021)(2906002)(71200400001)(6486002)(966005)(2616005)(6512007)(6506007)(26005)(186003)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(4326008)(478600001)(5660300002)(7416002)(54906003)(110136005)(38070700005)(82960400001)(38100700002)(122000001)(85182001)(36756003)(86362001)(31696002)(83380400001)(31686004)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEhPcmpMaFJpOWtwYytUNFBlQnNzT2dFYnlBY1RiQTRJNkFwWGx6c3lQN2Na?=
 =?utf-8?B?ODg2T1dhYmx0aFliY1BPNXk5OE9DUUFkc0ZtcDdaLy9LS2Q2U3dqV08xTCtG?=
 =?utf-8?B?c3ZTbUFhSFcwWmxsdmtFQmtJaE43R0VKQ01CUU8yL01xSmc3K3B0QjJIMFcz?=
 =?utf-8?B?Mmd3TE1vYWVKczBFcFgrYUoyS1lXT011ckp1NmtveklDYU82cmFESEZIbzNG?=
 =?utf-8?B?RkRJVzVCaDFVSFkwaVFwSzViUk4vRXJBSmNpbEtRRzNQNGFOWFF0WVU3MFNi?=
 =?utf-8?B?Q1FHNFlUcisweXYrb25FaWFUcUxySGpZMEpuRFZDNmpMQW4yLzdXQWtaWURT?=
 =?utf-8?B?eWoyYmVPU3laSCtGeWE4ek15MEdFSVZwRlI4TlZwTk13QVFEaXJ1dy9VUVFy?=
 =?utf-8?B?ZjY0UExJQXRmVDhIcmR3bVZYR0NBODN2YXcyOUZBaEszRzlydTVweG5uS01H?=
 =?utf-8?B?bFhSWUNudFkzWUtpSkxsRVhJSjZ1NEtSV3JnTWc2SkU4RDA2ekthWFR3UU1U?=
 =?utf-8?B?bnd6ZGR4VGFvd3dCa0VyLzV2NlY3d0xMRUI4ajVIRTZpNmJOV0lLWWR0UXZs?=
 =?utf-8?B?Z0g0S1NkSHlPNVRSbTlGL3VJdTBrK1A2TytXODBDNE5VUjRCbnFMTUtGZmpB?=
 =?utf-8?B?TE9LbXJSVDBFNnQ4Mzg2NlVtSlEvWVZUL250TFVhVUZNRzBPZGQvNzhSdi91?=
 =?utf-8?B?MXFaR2dGT21XQ0ZYMkIwTVJrNlROeEZ2TWVMeU0vVk1rV044VVBHQmY1Uld3?=
 =?utf-8?B?OHR2NHhnYi9WeGlTOEIyZkFid1ZMdHZJUFZNaWZZdFRjaytBTHF4cE9tMHl3?=
 =?utf-8?B?T2hrQXNpbUpzT3hVR3dqRjZZWWJEWllSTm5vbzFZdTFlL3Y3aDVwWk1XV2N1?=
 =?utf-8?B?UTlyK1dVdE1uczJ2L0s1WEZjTytnUUNQRWFpemZRcG5JN1JmZXJZOTJBTFlr?=
 =?utf-8?B?cDkvTmczOU5JSEhyS3pqOTBTNi85dElGVXhIb3ZlZE85SzRLUXE2cVkrdGZj?=
 =?utf-8?B?OW1jZXNBT2Q4ZXRYcGtjM3h5T1BqUEUwVk5BNmRGY0FmSDFVWVlNd0N4QVAx?=
 =?utf-8?B?WWwvc3ZOUVNQUXZsSUowYThCQU1jUmtTOTcwd2lYUXlNOXN4elg2UHArWGtS?=
 =?utf-8?B?bldzbjh0MFJGMXk3Nk94RUd1WC95c2UrbmtTOGV5MER1Z25nb3hiNUl3eGpD?=
 =?utf-8?B?V2R0dzlBNnlLYStGdUtCdGxlM1RXbjJxeTVWQVpsU0FrNmp4UUxtTU00ZitD?=
 =?utf-8?B?T0Myd251UWU0Ni9CLzZNSFQvY08vVE02SU5ncStSbURWYUdZR1lzRmlMWFBt?=
 =?utf-8?B?K0pZRkIwTy9FdU1SOGNOVENObC9aUkVTR2t0THRrSkp4aEh1V0FRcXZBdVdP?=
 =?utf-8?B?TzV2V1dVSFdjcFQ1L3FRaFoxZVRvY3hwWEc1ai9iUFROYnhvUStGblBxU1BJ?=
 =?utf-8?B?U2JYWmcrVVovclc4V1RzSWxNR0d0Ymx5WVhvYWQydzhiOEdZQnVvZWdSclMy?=
 =?utf-8?B?c1RhTEJaaldJY3d2RitLQ1RLV3VNVm9BL2NNZlVxK0VrbmlVWGlRVGd5aDVU?=
 =?utf-8?B?dXgwbmdUcWRqd1c1WHJGYzRwTzFWaElLZERwdlY3eFFMZTJrRE43Z2xoOVhL?=
 =?utf-8?B?OU5oVkhnK3hyMWllM21HaGVBRmFFYmdxNkxBRm0vOUVZQWsxK1BFYjh2aytM?=
 =?utf-8?B?MU54eWdueTQxZHM5MnJkbWUrSkIwdENqdWRKbHFQdDdDcFFrVjRRWTgyb2wy?=
 =?utf-8?B?eHVsQUc2ZGlMWU5qbFZxNlQ1WlFLbFVrZUd6blQ2OTlrSkkzandmUDhjdjY3?=
 =?utf-8?B?eXZQa1F5Z1RiYzAxVHVvakNlZ1M4TzltVzd1ZDRpMWw4RWhTM0FLOXhJOVZl?=
 =?utf-8?B?YkppdlFqRDlGbDMvcCt6NzVuWmhJbm1LdklRTXUwY3o0OXBZd2drVmI2VU9a?=
 =?utf-8?B?dEZlQ1kxMzNRVlh4NCtRRVBqTU1RR25tTnk4UUZ2WEFDV1hXalZvY0VERGVv?=
 =?utf-8?B?ZURiaHBORmlhamswNkJDTTdKZDUzUXRNa0Q2aC83MTVBdXZRaEtTeDJHcGdS?=
 =?utf-8?B?VkNhY1VqQ1R3OHp1QVp5YzVvWFBnd0J1eWhjcDUvOHd2YmxvOFdMVXU3dkZx?=
 =?utf-8?B?TmdqakdoNnVyUDVQSS9mKzFScTZmOTVPc1ZyL2VBdXk4VkpvRVVOWHNMSUxs?=
 =?utf-8?B?Q1E9PQ==?=
Content-ID: <413FF48DF9CAC846A065D7752A7381F1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZVhPUGRwZWZZaE5wcUdFTS9XQVhBejBMZ1pDL1puYVhMYTRYR3lVS0JtRHo3?=
 =?utf-8?B?WWNBZitPekdqR1JEZk5kSzRLOG9PVUVValBZdFpkTno5LzZQa3U1RmcxZkly?=
 =?utf-8?B?ekZ6R29vTmVYaVdRT3ZEbzNzYldyNnJFcEVDTVVPa3kybTNvaDRrUFpQelpv?=
 =?utf-8?B?bVdRVHV1VkRNaEtVazhCNjB6bHFURE5FaVZmMXhjRmh6NnoyQVpFZ0tKaFoz?=
 =?utf-8?B?RUZ0Si9KSWtUeTF6UWlFeXhKU1JhL2hNUjVnYmtCd0l5eXkxRVNRanJkUTlI?=
 =?utf-8?B?VjJMOThpUUFxbVkrdE8xOVpPdXRTSW1TNnp0TG9kWm9OdGRuTzJlcTVReHRF?=
 =?utf-8?B?aFVuTXQ0VHphREZGQ1RsMm9Falk4U0NWMXBReUs0ZTVPamZhYkpIVGZHU1RU?=
 =?utf-8?B?eHJQeEhtbWFRSktJeWdnWGVSN25ubTdWblpablJKQWI5YjBCMTRCcHVNcWti?=
 =?utf-8?B?dnRKZGVneThtL1dGSFArQXBic2V4VWRCWVdveURvTFF4UG9RekhPSW9MZmZQ?=
 =?utf-8?B?Q09xRFQ0K0JLdlhXNlNwOTNralFVTUgwSXNJK0lYcCs0aWl6TTVKN1hORzVt?=
 =?utf-8?B?b3dHejBhazRjU1dWNjhSdk1ZeEQ5WjhhdG9KOWRLb28wcktxWGJZL3duMHpn?=
 =?utf-8?B?dDI0RHllVlpJNDhGMnJETEVuZTJRbVUvdHlhSHNUTEhTUEgzT2p3VEIzK09K?=
 =?utf-8?B?d1JZbWVwVkpaeDFtcUVBbEVQOEJxOXNGQ1UyRG1wcGpKYUpsUmZkSHFFTC8r?=
 =?utf-8?B?WVZ3ei9OVTdCZlNLUHFWdUZXaE03NVM4TSszQjI5ZTFUVVVwQjBRUUJhdy9W?=
 =?utf-8?B?dytxbVI1ZjFXMCtoc3laTkR3bG5QQ2RmaUZkU1pVSXZqU1FFVmZ5NjNYVHc1?=
 =?utf-8?B?aldvTGttZm4xeGxXZ2xBYlpqTmdkODZLMnh2d293SUR1YzVPVkN0MUM0ZkZL?=
 =?utf-8?B?eFlXVStOZHY5WGNrZFNrWGVtZmwvcHQ1b3VTK3B4VzBTMXBJaTNWNzBxcDA1?=
 =?utf-8?B?WDdlbXhrZ3IzMU1aMzNEc21aN2NBK2NDbFozKzZrdVk5WHArL21ubzhyN2E4?=
 =?utf-8?B?aVFUMWErNFVJSEhoYm5FYnRRQ0pteHFleEZod0hSMzJCUDRCTHNPeGhXMjd2?=
 =?utf-8?B?dXBEajJ6VnJhRDhBUlErRlJ1RGlES2FQWklvWG4wcm52UWgwVzB4NGRwZVdR?=
 =?utf-8?B?TkIvMWRQV2hHR2ZYWHc3RzJXTXRubGR3N3ZKVlJNY3pld3dwTW13Y1hycW9w?=
 =?utf-8?B?YXYvMEY1c253Q2VVdVdaT0NOOERUbHpFenN0UW45cVQ4YUZXRlN6dDFSUFZx?=
 =?utf-8?B?OGE4VUtSbXdTQVFMUGhVNVBSYXBuYmR6SDl0akdzN0U0Q0N4czhZSEhUSEFu?=
 =?utf-8?B?WVJnR0JoTVZRYVlnRTZ6RWk3bk4zeG5BQ1ByNG44N2pvS09Xa0lJaklSUldR?=
 =?utf-8?B?Qmx4dXBzWVJoRVJsTXNPWWU0U3JzYktBZTJ5ZG8wL1J6OTVuVkhyVTBhZVRM?=
 =?utf-8?B?OElVWXpLTjkwTGdjb1NWWml3LzliRzRCWHptKyt0MHZkTEx0Vkl4UVVVWTcx?=
 =?utf-8?B?TXV1blFmM3dMRW1lTWIxSWYrVmZnL0Y3L0k3MmhTYW5sQk5jbFZFc2Q2aXYy?=
 =?utf-8?B?TFRQTzFQRUhUd1JsWW85bVVNdVJ6MkVoa2VyQitGc0JScXFLMkhCcnZmVDJs?=
 =?utf-8?B?bnB0d3RhMzl3eFRCNHpPRytuU2ZwOUYzbHMvQ1Rtc2lDbnJwNkpHSlNvQkNV?=
 =?utf-8?Q?irHzxU9lYtS8afX1vE/7DhEwnqW75eduTQpdeSs?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc786f9-643f-4880-d516-08db448e2f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 06:36:06.8066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yn2HID+KX8bLV3MEK4sIj4Xx3brcORfTLS6iL/r44SiU5LohXCBGDXNToYpbgkY9eH1heCE8adNKoEQ4OIqrjui8jtaKEbdfBNycPOLvG0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9465
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5.4 00/92] 5.4.241-rc1 review
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
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 "rwarsow@gmx.de" <rwarsow@gmx.de>, "pavel@denx.de" <pavel@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LTP List <ltp@lists.linux.it>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
 "srw@sladewatkins.net" <srw@sladewatkins.net>,
 "patches@kernelci.org" <patches@kernelci.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


on 2023/04/21 16:04, Petr Vorel wrote:
>> Hi!
>>>> This is the start of the stable review cycle for the 5.4.241 release.
>>>> There are 92 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
> 
>>>> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
>>>> Anything received after that time might be too late.
> 
>>>> The whole patch series can be found in one patch at:
>>>>          https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.241-rc1.gz
>>>> or in the git tree and branch at:
>>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
>>>> and the diffstat can be found below.
> 
>>>> thanks,
> 
>>>> greg k-h
> 
> 
>>> Recently we have upgraded the LTP test suite version and started noticing
>>> these test failures on 5.4.
>>> Test getting skipped on 4.19 and 4.14 as not supported features.
> 
>>> Need to investigate test case issues or kernel issues.
> 
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
>>> NOTE:
> 
>>> ---
>>> creat09.c:73: TINFO: User nobody: uid = 65534, gid = 65534
>>> creat09.c:75: TINFO: Found unused GID 11: SUCCESS (0)
>>> creat09.c:120: TINFO: File created with umask(0)
>>> creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
>>> creat09.c:112: TPASS: mntpoint/testdir/creat.tmp: Setgid bit not set
>>> creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
>>> creat09.c:112: TPASS: mntpoint/testdir/open.tmp: Setgid bit not set
>>> creat09.c:120: TINFO: File created with umask(S_IXGRP)
>>> creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
>>> creat09.c:110: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
>>> creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
>>> creat09.c:110: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
> 
>>> Test history links,
>>>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16338751/suite/ltp-syscalls/test/creat09/history/
>>>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16337895/suite/ltp-cve/test/cve-2018-13405/history/
>>>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16338751/suite/ltp-syscalls/test/creat09/log
> 
>> That's likely a missing kernel patch, as this is a regression test there
>> should have been links to the patches and CVE referencies in the test
>> output as the test is tagged with kernel commits and CVE numbers:
> 
>>          .tags = (const struct tst_tag[]) {
>>                  {"linux-git", "0fa3ecd87848"},
>>                  {"CVE", "2018-13405"},
>>                  {"CVE", "2021-4037"},
>>                  {"linux-git", "01ea173e103e"},
> Only this one has been backported (as
> e76bd6da51235ce86f5a8017dd6c056c76da64f9), the other two are missing.
>>                  {"linux-git", "1639a49ccdce"},
>>                  {"linux-git", "426b4ca2d6a5"},
> The last one is merge tag, I wonder if it's correct:
> 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux")
> Maybe just 1639a49ccdce would be ok.
> 
> @Yang Xu
> 1) why 1639a49ccdce has not been merged to stable tree? It does not apply now,
> was that the only reason? Or is it not applicable?

In fact, I don't know the stable kernel tree details.

> 
> @Yang Xu is really 426b4ca2d6a5 needed? Was it easier to list merge commit than
> particular fixes? Merge commit contains:
> 
> 5fadbd992996 ("ceph: rely on vfs for setgid stripping")
> 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers")
> ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile")
> 2b3416ceff5e ("fs: add mode_strip_sgid() helper")

We just need 1639a49ccdce commit is ok and this commit will depend on 
2b3416ceff5e because the previous commit needs to use  mode_strip_sgid api.

For the merged commit, we have a disscussion for 5.19 or 6.0 with cyril 
on last year
see url 
https://lore.kernel.org/ltp/1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com/T/#t

> 
> They have not been backported to 5.4 stable, nor to the older releases.
> Again, they don't apply.
> 

I don't have attention to stable kernel tree, maybe we can ask 5.14 
stable maintainer?

Best Regards
Yang Xu
> 
>>                  {}
>>          },
> 
>>> ---
> 
>>> fanotify14.c:161: TCONF: FAN_REPORT_TARGET_FID not supported in kernel?
>>> fanotify14.c:157: TINFO: Test case 7: fanotify_init(FAN_CLASS_NOTIF |
>>> FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, O_RDONLY)
>>> fanotify14.c:161: TCONF: FAN_REPORT_TARGET_FID not supported in kernel?
>>> [  377.081993] EXT4-fs (loop0): mounting ext3 file system using the
>>> ext4 subsystem
>>> fanotify14.c:157: TINFO: Test case 8: fanotify_init(FAN_CLASS_NOTIF |
>>> FAN_REPORT_DFID_FID, O_RDONLY)
>>> [  377.099137] EXT4-fs (loop0): mounted filesystem with ordered data
>>> mode. Opts: (null)
>>> fanotify14.c:175: TFAIL: fanotify_init(tc->init.flags, O_RDONLY)
>>> failed: EINVAL (22)
> 
>> Possibly like the test may be missing check for a FAN_REPORT_DFID_FID
>> support.
> 
> @Amir could you please look at this fanotify14.c failure on 5.4.241-rc1?
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
