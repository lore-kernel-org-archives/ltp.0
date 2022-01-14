Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFE4C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 06:27:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82C9F3C8C6D
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 07:27:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DCB03C8B2B
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 07:27:03 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 27ACE600C26
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 07:27:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642141622; x=1673677622;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DAGml4Jd0CPDis7aNnVT5wDDwVP2DsSLOwZBo++XqKQ=;
 b=kAMs3vfaiFLNhjEb4gt2rqOD/rpYCJU7qUAWaISM/6eKdZt88zvNmzbD
 d6CvicR07QQiVisdq643KR6AnFk1GrVHAOKGcssrDikre4umYHcpoHJyi
 5ozv45VoQiqP2qCwY0YWOjeCqtO18pAcq7xLyPSIXhImPY9iBTslbvcfO
 z9VgP3FS63XcGI1m3TPY0qiFg/5s2Rms5h+kVNTTpA5sgSvQnIsx5j/eA
 DwVqhQc83B0u2wWR2XN53d5yidu3ZNFs8dMGU5pK8wVDm8yek7nffew0L
 b7tBZ4rfjT6R3hbjeKTN4UbFBF7IQfGyBPJZc/8pF6dQkI9XSWmE8/Nxs w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="47485670"
X-IronPort-AV: E=Sophos;i="5.88,287,1635174000"; d="scan'208";a="47485670"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 15:26:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6fYiroZuA03duDzLuCYyFGCmCImplI6y2j6cfGoXUGLCOdujjXoeDtaxLw9blf3ZLh4YbC5hbmi/TxI3SUpvMAPC7qu++/MkG49A4lMPQx2ZfIN2R8SQjHsIFXvIBC7cUauIaJJzvdNO+b/hVUuLBxgZIYxdvRCZNQNbOFVFhA9psxe3FrstLrLxSDLjZWM1nWuyPV2y/UrJUx89C79R5HSbGn41HwT+bWbfzuuIwvyOj6qcPQY9iy82sqeNl0KxbnQFWXBc2EDomyKCcCUoyu2gwfuDb+EZX+HzE5+UItfStmBsey6J+Vd9a6WUPqoBcy5fK16tTMW+GjiKyfzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAGml4Jd0CPDis7aNnVT5wDDwVP2DsSLOwZBo++XqKQ=;
 b=HeiLfkZphYXI1pyNkjotARVyT86PdmrYE5IP0UXSz/v+x4MDeh5NlbunVusycvu8DMaSan1OWPqV9FWH2viqB98rU3Yxw9y+jBOTEgdZ0V+8w4cuwgWFevVRVWRE8dIzofZIvRmSXKn1u/NynrjmY7QD+odtN8Trh01YXZDYG0zbJ8BViBJ/nzm7UCZIbMUb+WTTrvuc5lu+OlD3jJkZcPksvsWjIcEYMuSp0BmQr8CGxcmxa0BrE6HshUDCKgyIj2Tg6NqrCOl6x5At4FrpOpCWSR/0sPi1/FKp2ly/AbKa9kyPo6xGN9DQ0JdVlwfRIwM3HSNy02iw2ZXXX+bI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAGml4Jd0CPDis7aNnVT5wDDwVP2DsSLOwZBo++XqKQ=;
 b=ZCEHw2IC4nse81ERG+XWb1e2h7GfT5hss9Z/gddC8jJNhsWc0UPwZbMaCUe2oZkDywbD1t7EzEVzcyTZeBM7goglJMu8YGP6QAJBP8yET1HB0zVD409asacEb3lruwi8WptvGxa+bVpLMNUnmum8aI/V0MFRWQsdYQrAr9UXIiQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB5148.jpnprd01.prod.outlook.com (2603:1096:404:111::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 06:26:57 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 06:26:57 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>, Petr Vorel
 <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
Thread-Index: AQHYBrHpl9iAQbrPq0SVOQssuxdnMqxdcxkAgAAMzYCAA512AIAA9PcA
Date: Fri, 14 Jan 2022 06:26:57 +0000
Message-ID: <61E117E8.5080901@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eZJ7U1+Bdsb5xCB6-KYa1mQQ=GriaDtyFSJ_6zprT7yw@mail.gmail.com>
 <61DD4215.2050104@fujitsu.com> <YeBKakIm5I4HQECr@yuki>
In-Reply-To: <YeBKakIm5I4HQECr@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e8cece0-e7e3-44f9-b757-08d9d726dd5b
x-ms-traffictypediagnostic: TY2PR01MB5148:EE_
x-microsoft-antispam-prvs: <TY2PR01MB5148AF1E0BA81799FF31BB9FFD549@TY2PR01MB5148.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zc6k4NFk2PEzyGYMj5UGDmWnX56UoScMeQts4bsH8p5huQhZx5Zy3P6L8Fqqu3DpV16qbwtWeQQSAxH60p0jDaBYx4nVFFWNKt9FqI7MY5XPaBNRsPrzA1VMfu65PNWPoNUF03u1eS4jajSazEk5wZZCaKzXoH5PdjSSMf/p1rLFu34eDplmnqj0JzgONs+ra2LxMB/feStELokH6jfIENbednpUBsM+JDcFWe6InLtsf4HWMhy7uZsE/pIjh/IM3yKqRT9fOGzck2H1A3qVH7QxXxXtxzkvU++ewSxOw3UNLNRI+K7K38jjlYNvDULR/t/fxl1HqHH8e9Ew5+3wv7sNOAWr/Lvra2E6rjM3jH9tPqaWEUC6Ns9gQqIOo2mzpev9kGs3X2ewfZ+V98wpmjpkfJHswxNl6wrlslqgvqjZ2zBWnnQdCFbjNkQbExsuoxfYTugNAQj7RqJEPa1dn5PtyUGKhIwNBmM6lnBuaHOdkVpFdmUIygMCkuVYoQ8/Z0Hexw5W80Aw0avtdXr7vcXLwLa9qBfHro8eASsPMVIDwKni5ysaGEgiTnCGw3C76bbjkm1b2kbcYi57E59f52swPvxgzOjohmK2hc/e+fSUC5LKibBWaf+QWtlikZbkmUz5Aw/wqnYgigt/7m+ek+4QUmFW2lWZEzPByVMWFJPilkoPiAGdfYH5iNmB14Ehn8TkwMcqoClpIwNA9u2YWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(38100700002)(6506007)(122000001)(71200400001)(6512007)(38070700005)(82960400001)(508600001)(2906002)(33656002)(86362001)(4326008)(85182001)(8936002)(186003)(5660300002)(8676002)(87266011)(66946007)(26005)(76116006)(316002)(110136005)(66556008)(6486002)(66446008)(64756008)(91956017)(66476007)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?czI1ak5KVXhFOThNcTFVY2tHTmpaVXU3WWxUUjRzUk9VK2daVWdQZU9ZVHFJ?=
 =?gb2312?B?ZnFlQUVmTzBpYjBaUERLd1pEaGdEMkMxYnhVeUtLb2tOZEwzem5oT1lmeXBV?=
 =?gb2312?B?SmVmbDl0eXYrSVpVUFRiN2k2UHJLM3dEb1dvVmY1QzdmTUs1UFlHL1VuNGRC?=
 =?gb2312?B?Q0hjSmovT0pZMlcyeXN1R3dKQkZRcW5Zc01uRFhCdGk3RS9oNEZZRFFnTGJN?=
 =?gb2312?B?Q3k5U2RLOVZveFZBZ056NUxiQlh4blQvSDZSSzVPaFZmd2w3M3FsRkdMRy83?=
 =?gb2312?B?cXI0dFVIcHBTSUl3bEE0MU9oOXZYSjhOSURQMDh6emczK0NrSlRWWjlZU1NN?=
 =?gb2312?B?akx5WEhFV1VVb3JuU29kK0ZLTStSQVM5eVVJbS9JNXJPbnZyRXUxTEhmaU1r?=
 =?gb2312?B?Y1ZIYmUzVkcvN0Vuc1RvVG4vaGVPQ0MweHp1dXZqQ1BVMm1JbzV0VFJYUjNk?=
 =?gb2312?B?VXlZcnpRZk9BOXRFdEJSVTZQcXhHdHVEL3VOWlB2dXBFWTcyY2wyeFhJU2M4?=
 =?gb2312?B?NlVSdlNmT0tLTGR3Mk5qVzZKdDNqTzYzd2M0R2NTTnloNHJQZ3RyK0JlT1hp?=
 =?gb2312?B?K3lLQXlJYU83aFNLL2Zrd3dqUFQzM1FnMmFWRXNQS0NwTkRGd05nRS9MV3dh?=
 =?gb2312?B?dUNaZkVLaSticWVJZUtyeVBiV2FrWjc2Q241WU5uVzkyeXo2aVcrTUZRYXh0?=
 =?gb2312?B?SkFqSzgrTGJta1lJalRWRXJEbEJlOU04VENqVEw2YW9UWElWVFdKeW1mOElv?=
 =?gb2312?B?UkkzQXUxbzFTc2p4NW9idGpMQlRZdW9IVzdDN3k1SE00L3prYWpTMVpBMkF2?=
 =?gb2312?B?VnY5Y1czeFRUVGtJU0phZVBNSE83ekZRRDNFa002dS9UQXRkQkhrYTNWd3FX?=
 =?gb2312?B?c0dMQkxVZ010OTByc0JKMzZWRzQ4ektWUy9pRnBud0hnSEFrSjZ2Q0lJUVFw?=
 =?gb2312?B?c1oxdC8rekVLbWRLMUxRbjZ2VVFIZ0h4bldBZzdzVEVmMzViZTRmSjk4YnBN?=
 =?gb2312?B?NXgyMDMyWGV6WlJQWmQ0QmNiSmRRdEV5L0Q1TklMTmVZaW4xRHVsYy82OWFF?=
 =?gb2312?B?a0kxczRrOGpQVFpoVldCVWg3bWhSK2lWb1ZZMkYrWUt6UW9VZGwyN3IyTFJC?=
 =?gb2312?B?UnBJQmN0THp2eG5NOFlMU3dmMlQ1NzMzUVRCWUQrR29mS21WNDJrL3dNLy9i?=
 =?gb2312?B?RmI5QkpSVFY4V1oyc0xTNGZtajA0S0MzZWJnczJtZGl1UTczWHFFdEdBcHdK?=
 =?gb2312?B?aFBLbkRlS0pob2t0dzhFUEtVcFBGTEdjRHIyN25pWHBsWFRpd0JOYm5jYXRY?=
 =?gb2312?B?bTFTS0g3cVV0WkVyNjFWakxENWFDdEdYUEhSWFpCdndJT1p0YlZta000cHE3?=
 =?gb2312?B?YjRobmp6SjgzaktCcEptRm9wSlRKbTExL0huSDB3dWVlUmt2djdXaWk1eGRR?=
 =?gb2312?B?aEg5cTFmT3B5L21oRHlXT0ZwN1lFRS95K1grMGdXTG1jeUorTmREcDlPT2RD?=
 =?gb2312?B?cEE5VmFHdUpFRDNnaFNSYnhudEpMbTRZQlo4VVZIbnhSZGNpV1Evd2lYS0I3?=
 =?gb2312?B?eHZpanZQbUtjbjJHM3JyalZ6cUtQMFdaalZVZGkrMU5XRHVydUltYWxIUWJw?=
 =?gb2312?B?YnA3Vno2YzZDS1NWbWJEQjNrRkJZaFMrWVRaUzcrUWVKUEpuUFVLWURpRTJL?=
 =?gb2312?B?L3JSTk1oV21tSFFRZlZIbjRUU0ZrZlhGc2xqWU12R0Yvb1RBVmxJQU9Ga245?=
 =?gb2312?B?RkRoMkIwK3FxbE9hRHlOcy9FdXppRVdXeFdYV3lHOXdlaTFadlhXMjhiSWt3?=
 =?gb2312?B?bE5HdTB5dWc2SnNLd0tvaFZIZ3pmYXZjMWp6dk1WdWVEZzJ4VGFCeEh6Qm1m?=
 =?gb2312?B?enQ3Yk9zMitVbXF6TmtMZVdjWkgrRXNTek1RUUg1dlRJV2w5QS83L3o0NjZS?=
 =?gb2312?B?c3Bob2VmWmZtMGtZYkpKeFhRUFJxcEw1UTdmS1ljRDJXdmJVRFNMTVhHWVdX?=
 =?gb2312?B?MTRMOFMxU2xjYUdiaCtYenN3c1JLSCtzVEJLYVduSFAxQWw0MXdTRnVWdmdh?=
 =?gb2312?B?M0RwdE13YWdoVzE5QzNGM3RXckFlRS9TZElrOVNUakJGcWV4L0NpVEwyRzdQ?=
 =?gb2312?B?cUxYMStaYjQ1QnZaQXA4RVdVQURuV2JWMjRaZjhxa25OYXAwR3ErQlZJWFFx?=
 =?gb2312?B?VFlnTE1tN29jcEJndW9rWGRpRUVQVzgwQmtuclJmQmU3U3BFaTYrQlk0T0kw?=
 =?gb2312?Q?aO2R00W2NJnAGq394bx08RWSXsIaaUqAgvcWBfUl0Q=3D?=
Content-ID: <310AE22C8AC5E945AE4C6E382B8242D4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8cece0-e7e3-44f9-b757-08d9d726dd5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 06:26:57.1515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgoXdBrFd4iq+7CoWV1pt3tW82f8MZjGyPL+xMP+TV0chy8KBpIV03XU4+UPNhTPkfI5J3vjBrGVsvTjnlRlZppkwV4G5MY0nq0RiNkRwdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5148
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

Hi Cyril, Li, Petr

> Hi!
>> int main(int argc, char *argv[])
>> {
>>           char *str = argv[1];
>>           char *delim = argv[2];
>>           unsigned int i, cnt = 1;
>>           int ret = 0;
>>
>>           if (argc == 2) {
>>                   delim = ",";
>>           } else if (argc == 3) {
>>                   if (strlen(delim)>  1) {
>>                           fprintf(stderr, "The delim must be a single
>> character\n");
>>                           return 1;
>>                   }
>>           } else {
>>                   fprintf(stderr, "Please provide kernel kconfig list and
>> delim "
>>                                   "(optinal, default value is ',')\n");
>>                   return 1;
>>           }
>
> We can make the code a bit easier to read with a switch()
>
> 	switch (argc) {
> 	case 2:
> 		delim = ",";
> 	break;
> 	case 3:
> 		if (strlen(delim)>  1) {
> 			fprintf(stderr, "...");
> 			return 1;
> 		}
> 	break;
> 	default:
> 		fprintf(stderr, "...");
> 		return 1;
> 	}
>
>
>>           for (i = 0; str[i]; i++) {
>>                   if (str[i] == delim[0])
>>                           cnt++;
>>           }
>>
>>           char **kconfigs = malloc(++cnt * sizeof(char *));
>
> It's unlikely that this will fail the allocation, but for the sake of
> correctness we should also do:
>
> 	if (!kconfigs) {
> 		fprintf(stderr, "malloc failed");
> 		return 1;
> 	}
>
>>           for (i = 0; i<  cnt; i++)
>>                   kconfigs[i] = strtok_r(str, delim,&str);
>>
>>           if (tst_kconfig_check((const char * const*)kconfigs))
>>                   ret = 1;
>>
>>           free(kconfigs);
>>           return ret;
>> }
>
> Other than the two minor issues this version looks good to me:

I modify this patch with the above comment and also move tst_res into
kconfig_skip_check in the 2nd patch. Then I pushed this patchset.

Thanks for your patient review.

Best Regards
Yang Xu
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
