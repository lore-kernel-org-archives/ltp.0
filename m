Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E159C433FE
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 09:20:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFE0B3C952B
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 10:20:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8667F3C821C
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 10:19:53 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1AFB1A01442
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 10:19:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642151992; x=1673687992;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=k8Ec4wuIFQGZ/KQrUHIZzDKimMjolgnM2BaCoWDh/rY=;
 b=YY4deJncTS91jWKzz0JuZz4JaagVuFr3sApMVqkBk5Y8Onua98FoWhOv
 2fejS49J57Q1P80mlBCc9+r7Z7FBKgQJQWvEmjJoaRnsa/EXUv3ACZXr5
 StQ9gFs2/Evf0gQrpIxsTplwwjPbGjguZw9fmHjFnlkM381s14U/dO5Qt
 AGQP5MCh03aGdOTbnxMq1FHqhRiEwl3tQ3UIhGfeHsHi57mlfre4LfyQq
 l1IyC3BVQvtYNDcT0wxwsfGTa3C0/abZsnC0SBL9BFDg8AgFoqCo78guI
 STAEZ6i/076J+g6++2I8A5YNHFGIw2T8Ixs9SHTqpZXhyZ4/63gRu44Hf g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="55853064"
X-IronPort-AV: E=Sophos;i="5.88,288,1635174000"; d="scan'208";a="55853064"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 18:19:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlknihhwVbhq6RBGBj3WgfkN+5vm35SLdljjRbu+6Y1yOIwfyv23X+I/cjg7iW7wFPVe2Vrc1LoLe7hmWL6tLSqVD7iyF38/FEnGckgUOyvJCcLo7zgHl8fAYoJgbGZmpyiuJPrdyIaekKMbu9soEPrfte2Yo1uR7pEjMNru5OMkN6FpKtbAgJVqHBtUtQK1gO4yhaXyfEyqNtGC5XEPPNPZ5hNHP5kM1kC9mSahnNLk//cmbUgnWiMcgpmjhJCsLJOdVJr2v82/UWLEdAjHdlHEW3B+5WSQrfl2uMFQMVBb//kwYbRMMjy4RTr8RkaEonoxVkL+STUplXzIb1v+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8Ec4wuIFQGZ/KQrUHIZzDKimMjolgnM2BaCoWDh/rY=;
 b=LmPJAtHp1QOxqBQpBBbru7WnxrnV7vVEvo+hVZlRYqM6uW2hd60XDqnEN2MzQWOdw8ze6+ArFZJbumO+4Gvq0GwmBN3Jwsr7GumzHWRzsDAcdX01S0vZtMoA8AVp2DK6oDpnrKVn5FILBgwEImyiUge3Bw3tWqct3HU9floPaAp0FzAeC1LKquPSC95Pipnu0vSMy3L3ylWnLwV55Skpn6w61UPNGPFKQiRuZmkaxaKveDuM2bxE25B1ZIUp857P4+9KsMPIz4jg9u9EsXnZXzegA1Gznk7HuNTM9Jg5y2hZIJAWKBXW5CzzYNIMUlXuLZ50zQp4bRI9cjjzv76UiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8Ec4wuIFQGZ/KQrUHIZzDKimMjolgnM2BaCoWDh/rY=;
 b=QggQ2a2Y9DN92OCQQPUj0fZFvXzw7PPp7BLVEQIlsNGfgjVwZM1hDilSnF/Ap65FzdhVkCkikkgaSlN9Ntf7qDHi9YXuIQqNW5Utsi1IA769KXcznGoqB/ZyFR2GdTx+vlY6k75PyNJsBu7S4MzZf8iADweud+mASzLZyntZpvA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB5578.jpnprd01.prod.outlook.com (2603:1096:404:8057::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 09:19:45 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 09:19:45 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>, Petr Vorel
 <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
Thread-Index: AQHYBrHpl9iAQbrPq0SVOQssuxdnMqxdcxkAgAAMzYCAA512AIAA9PcAgAAwSYA=
Date: Fri, 14 Jan 2022 09:19:45 +0000
Message-ID: <61E14069.8030800@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eZJ7U1+Bdsb5xCB6-KYa1mQQ=GriaDtyFSJ_6zprT7yw@mail.gmail.com>
 <61DD4215.2050104@fujitsu.com> <YeBKakIm5I4HQECr@yuki>
 <61E117E8.5080901@fujitsu.com>
In-Reply-To: <61E117E8.5080901@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be033043-8d93-4777-585c-08d9d73f0198
x-ms-traffictypediagnostic: TYAPR01MB5578:EE_
x-microsoft-antispam-prvs: <TYAPR01MB5578154458513DD8369AD38BFD549@TYAPR01MB5578.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ksy+A9IN1Gai95vw5HF9mdBv4oRPUXNMpoS9HstdLHjNU++zL2jJz8hPDXjKSYZ4C+zwGy26jiVdI50BR25PiBaYSoPLWSzOjesBRU23pfexzpekAOX5uZgogerjjBcLH+4THNAt1eAdyGNz5zgJpYWgIWGRmfHHe+6yd1b/NncgF1fx8/Tub95R/kjtNfM9uOUY36PW2/XBJeD3EiiFix0cbt6tV7tsosnpdFeSopwRFz76lX7wv3RqR/hTdZ3dTytg6pPyP/rVWkZzczlczjOY8uLdcZC272bLueZIjLygHZzofhXeLNhH2ktvddy18nIa8qkpJZ+XFaCPRqkg7XBNc4jEazVkzGKZ3xBYyDJHS+95VQtUzPpi8v8TvQmS2fty7VjMBtCauIokYGS3yVRJopDUkwZ4srhD1ne/GL3KvNAoEM5KJ2cbVbGoZ6+3lqlgxL4xpTYgtTSc32ImvkAvMpqnZchlrooyFaI/ApGCXBNHf2AbsGTDD05ultx8AovZEd0w7Xao0lxhYNZcsMsGhkI/P+QLW3NZPAIGZrDQQF6ss3mMLfcHkO8b37V3/J7Ky0p9w2zYCGRpBUxNytXZI3941/raNn7OimcBo5YfPE72EysJPy0vbygDm0a9niF+q/gnC0yoce45KSDn9o3NYmXK0IGaPmj9RtCMOp7zfHB9/LUtSb5spuoIThJDHuu1kYegXU+NuE+cWJD8VA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(26005)(8936002)(122000001)(8676002)(71200400001)(38100700002)(87266011)(6506007)(4326008)(76116006)(66946007)(33656002)(66446008)(186003)(2906002)(5660300002)(66556008)(66476007)(64756008)(91956017)(86362001)(508600001)(110136005)(85182001)(83380400001)(36756003)(2616005)(316002)(38070700005)(82960400001)(6486002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RjZTd0kzM1VybFpSZEJNRzdFenJyR2pCNEo1RFkvUTV5QmJEM0FpWmoveUo1?=
 =?gb2312?B?VU1HUFZFRjR0Z01ldCtCZ2ZBRE8wWUcxNzMvTkdvMWdTK2h4TWMxcnk4ek90?=
 =?gb2312?B?eExPTkt0L21PeFRMUnU4UlN3a2lvOHY5Q09RQVducjRETWtYODg5NmMySEdY?=
 =?gb2312?B?WkN3WmZNcXU4azVGU1JrTVpLVVdXd001aUpQSHgvbUhaR2tjdXhxeHFkZFRX?=
 =?gb2312?B?UHJmVyt4WXpBWlovS2NCWHNDUVlwQmcvV2Y2Mzh3djc4YngzUng0WFFwdzYv?=
 =?gb2312?B?d3V0b3hGVUIxRXFGMHFyVHpoc0JpUTREczkrRlBzcGlSTERyRldsYTRmb0tJ?=
 =?gb2312?B?b2I3Mzh6UGhpMUxrWmZsQUx0bW5TcHgyYVdYaGNHZDZqMDRtVDJmbW9GNUlj?=
 =?gb2312?B?WXZSa1dXNUROcXAzU2JITDBEcWsrb0VnTlJueVJPaCtRRFpnZ1lFa1MvMiti?=
 =?gb2312?B?WkhZY1JjZng1NGIvb1FOQ09mOFhqTVd2NklZYUxOUUlFNFFJTFdoaDIzMTJr?=
 =?gb2312?B?d1E2QytqSUNDdDdpM0FMTUlZd0k1RU1IZ1U3NTB6djVyNGQrK25ESUhldGhS?=
 =?gb2312?B?RDRQTk01V2tVWlVPeW93M2R5MjRYc2RQUG9FRUR5L0puN1lrS2EyYmxJOTJH?=
 =?gb2312?B?ZzRRUklJSXRjMldpMGlTbDV5Y0Uxcng3S0EvNURZYlhCSEZxb1dLRS84ckk3?=
 =?gb2312?B?Uk8wTE84aC92QVY5NmtSSDhqMmRDZDFaV1MzY1pTaVlFeDZxVzJOdmpHbStP?=
 =?gb2312?B?Nm9YSG1QR01CWUJYOCtCTHdJWWNRcXozdHpMQmVHQXZQaTc0VlJIMVdjanlQ?=
 =?gb2312?B?QXU3bTZMVVBvWUZJUTNxME9EaUJydjU4dkRVTHk5M2xCUFloWnhlUjY4L0J4?=
 =?gb2312?B?OEZ2ckdscmxyeklBenJFWU9PVUlYdUk2allHZFo5QVhmV0MvT05xaW5HYTYv?=
 =?gb2312?B?TGNhOVJacGhwR20xYTFSY2gxUm1XZGNpaURCREtOenNJd2ZhVXR3Y29QY2Jq?=
 =?gb2312?B?ZTJVejNuS1diZ0t2dEVNYXU4TUEveHppemR1N2NIVG9uR3hVbWVYVDZZK24w?=
 =?gb2312?B?L3VRcnZwU2RqNzdnSDdIYUNjdkl4MnJjekNmZmljK01pSGoxTGM4bVlkNVIw?=
 =?gb2312?B?V0h6MVhBVzdwQWRFMWRxamZvckxCVFcvYjFkZGp6YUw2V2RKUzZrckdpN0Nz?=
 =?gb2312?B?NDAyOG55M3BwOGU5clRHVnMvNkhWQW9LNEg0Qi9yVHpaelJjRFU2SlJsZzdr?=
 =?gb2312?B?OElORW16Z28vWkRkTjZ4QWNVdUVjRWx6OGwxNloyQnpIV3pPZSszUGs0RWpX?=
 =?gb2312?B?YldGTW5PanNsMitaV1NGM2xUNUphSjN5eDhEYmZNR0J2N2o5ZmdLbW8zcEVl?=
 =?gb2312?B?b2tQMHNqZTBGZkhqVDMvRm5raEIyRk9jcUlmcFZOSDZPbkJoWXlsM1VOYngy?=
 =?gb2312?B?Zk9rQmlkTEs3NU90a2xtc2VNU01QSnZ3V0lURFRCck51VXlBbEV4MjhXTWxB?=
 =?gb2312?B?YVc0VVFQRjEzNDhLWVgwTHBNZ1crYXBoTE9mNWROU1pVN0FYMUE2ME0rNmJC?=
 =?gb2312?B?QXVnTkIxaWhDSDRkRW1qT1pHZDE2RGhaL2FlTW96U1o1VGFHUGllOGtzNWJi?=
 =?gb2312?B?d1d6d3lzMnE1STFKOVlqQiszLzdBUURwZnVpSXNHM3NMdHJBL1k5UTFVRXN1?=
 =?gb2312?B?b0tKMTdYbWhCbEUxQlQ0a0dVQXQ1WXY4UFZWblZXSkUyS29FS0FOTjZjYkJH?=
 =?gb2312?B?OFI1a2dyYnFDbEE0Q0YwZHN4dHlSL2ltOXdzUkV1eXVTaHNtZlZLVG01YTR1?=
 =?gb2312?B?VGFmcnFJTUMzbTIxZU9nR1hKV00wZ3pnellLK2dJL1VKVlJhUldYeFhOaUZy?=
 =?gb2312?B?THBpWWQwWlRqN3FyWm4xSTNsTkxGL25DeFdCRXAvR3NCMkFnZUhqbjE3NzFl?=
 =?gb2312?B?T3l2dkI0ZDl5WDg4QmNMOHNTQ2JiK3J6UVVGWGFVNkpnS1dmbTlud0J4aW9N?=
 =?gb2312?B?QnlJVFBZQ3FsMGMxS2dJQzIyUFBZcGhPdHlLZ0NsYnBDSHhIZW9qK29CaDFN?=
 =?gb2312?B?citoaHlpb2J4WFVXbnJMWHNKTEJpVUphNUVvWkFYZ0tDRHd5bzdseWNxMGRh?=
 =?gb2312?B?Y2pocmVtc0dsMUU5NFhpcVRaYXBEUkp2Slh6RDJLUmdnWDVtem1KaUtrZGN2?=
 =?gb2312?B?R1FvNVRaK0JCaDdneHk2MXpUSGpYaGRycTlsdmNRN1lYbjdSa2NXOGVVWUdM?=
 =?gb2312?Q?HxuTkFFqx7UuRyCwo0LReGMgbFUwHxOw8Mvzbvcpjc=3D?=
Content-ID: <79FAC0ECEF545F4E8BF448C5C42E5A95@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be033043-8d93-4777-585c-08d9d73f0198
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 09:19:45.8839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tlqLHxq+syimLuhayD8uN6A+N+edxhF0Vpb7JWQhp8D/fJ3AuNPBigp493HT0NvpkRNVWoE/5VPyDgYV/5bG+D1myjewm6Z/RQrSR5oPB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5578
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
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

Hi Petr

I find  ltp doesn't update wiki automatically. Or I miss something?

This occurs the last patch doesn't update doc when we merged a patchset.

Best Regards
Yang Xu
> Hi Cyril, Li, Petr
>
>> Hi!
>>> int main(int argc, char *argv[])
>>> {
>>>            char *str = argv[1];
>>>            char *delim = argv[2];
>>>            unsigned int i, cnt = 1;
>>>            int ret = 0;
>>>
>>>            if (argc == 2) {
>>>                    delim = ",";
>>>            } else if (argc == 3) {
>>>                    if (strlen(delim)>   1) {
>>>                            fprintf(stderr, "The delim must be a single
>>> character\n");
>>>                            return 1;
>>>                    }
>>>            } else {
>>>                    fprintf(stderr, "Please provide kernel kconfig list and
>>> delim "
>>>                                    "(optinal, default value is ',')\n");
>>>                    return 1;
>>>            }
>>
>> We can make the code a bit easier to read with a switch()
>>
>> 	switch (argc) {
>> 	case 2:
>> 		delim = ",";
>> 	break;
>> 	case 3:
>> 		if (strlen(delim)>   1) {
>> 			fprintf(stderr, "...");
>> 			return 1;
>> 		}
>> 	break;
>> 	default:
>> 		fprintf(stderr, "...");
>> 		return 1;
>> 	}
>>
>>
>>>            for (i = 0; str[i]; i++) {
>>>                    if (str[i] == delim[0])
>>>                            cnt++;
>>>            }
>>>
>>>            char **kconfigs = malloc(++cnt * sizeof(char *));
>>
>> It's unlikely that this will fail the allocation, but for the sake of
>> correctness we should also do:
>>
>> 	if (!kconfigs) {
>> 		fprintf(stderr, "malloc failed");
>> 		return 1;
>> 	}
>>
>>>            for (i = 0; i<   cnt; i++)
>>>                    kconfigs[i] = strtok_r(str, delim,&str);
>>>
>>>            if (tst_kconfig_check((const char * const*)kconfigs))
>>>                    ret = 1;
>>>
>>>            free(kconfigs);
>>>            return ret;
>>> }
>>
>> Other than the two minor issues this version looks good to me:
>
> I modify this patch with the above comment and also move tst_res into
> kconfig_skip_check in the 2nd patch. Then I pushed this patchset.
>
> Thanks for your patient review.
>
> Best Regards
> Yang Xu
>>
>> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
