Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8F6C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 01:21:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 294613C9F08
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 02:21:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 195CD3C9888
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 02:21:26 +0100 (CET)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7B95B1A0049E
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 02:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644542484; x=1676078484;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/2ZEvfsOlYbV4ra7eam1N7yansKxXEDa3MdJxFWxUCE=;
 b=Z65qK4TE01+7Ynu2/6oPuaIjhHYVcMyEU6lzQuws5SZPYKVmd1d1JIOP
 GcKTtVqzebz8mHXUr+rHejy4S1hdTa6AKK1aXtGlJGngp5ziMLGGW129C
 Dwujw0OP4yVKFc9sr5t0DxwgUnCqn52f/ezlngc3WdowJoY2KPpnkSqeM
 4ORl6IREjmT045yZsuDM+x8yiWbYO6qY6tsb4s+srFMyeseJk2rT/CQNo
 aLOs8fLAC0kRSwfnvOd7hm6XZxi8hFl2o+T5lxl70nU7W6rHdi4uklwxW
 F5JhWfVrWsZPtpau+ifjGWmcyThL8qJAea91AuQbGiCIoZ5qt7ESdxAbY Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="49618453"
X-IronPort-AV: E=Sophos;i="5.88,359,1635174000"; d="scan'208";a="49618453"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2022 10:21:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtCuegC8bXmd2aE7TmgIQ8UminofT49ioSXDenmgGvXuLmM0hvcD92EJhbbNEhgq65QQHetQLujIHrs2SxW36E7XHzog1aUVIPUdAEWE1vz9N4p8NjRNHJ2DjT3hPr4omR08UszRc1oQfnaul03V9QtMAbNIdz79bw7LWCgpdsN170sm83DAiLTQCCGzpbuV6f1dTRhkhAwsGGotJwHxl6Y889ffdw359O9t7OXUjphAHR/4JDx4blJiHIxyDl6Msf4HqgCvdpQxjL5xgcYDBFPLoQwR4lCyJCB/M743Lj4IWjJ44UG2bKibCL/X1Vi9+sDiDV1ggazNj4IibpwDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2ZEvfsOlYbV4ra7eam1N7yansKxXEDa3MdJxFWxUCE=;
 b=jBUWp3iaG+u3ft+YmfSDeLV5OefDqxYaf95oglMHUlJgyQNQuuVHSRD5txOR5QCiA3NI3F24/VxKZs6ucH5XGFUeYnVa/wnaT3CixQ5x7lQJJ1U5R8CrmcoJ/uCLf1GdBA0BLdfpI2342kBCgPHD3yi/5NUtMOLxCeZ68hPjAlxL/KFdQnaLOqy+gCvGufFwYT2jsc2v0t3CooaCTCkj5X4NblMKLq6VpmEOIDD2eXKFUP/DHnJlajdkO1XQSum+cLWjvYdBmhlH6iXFgmbc9BaqivIyCc/B1N+K8rA03BtxjOeVWAVb9XL0TUQkFeMglDQlk5ndZMy43S5bz1hkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2ZEvfsOlYbV4ra7eam1N7yansKxXEDa3MdJxFWxUCE=;
 b=FcYxf8/st9OxZZTn86j4wfAHl0pjB8ZmLLfH3pqetk0BDOepaBO2wcw2C5DzPJCDDRYtuyX4zoz/45G1cU/vce+LAIta8JS1uXNpsOspk8DOKB0hGjsEvL0xwskjfjCfDk5J8jsbpN4buoIm/LeTzXyavt8DZnvIADSzzj//lB4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB3558.jpnprd01.prod.outlook.com (2603:1096:604:42::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 01:21:18 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:21:18 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
Thread-Index: AQHYHoN8lwkj+CqUFEe7M3E8hlXtvqyM9MYAgACN64CAAAvQAA==
Date: Fri, 11 Feb 2022 01:21:17 +0000
Message-ID: <6205BA38.7070903@fujitsu.com>
References: <20220210133812.13368-1-bogdan.lezhepekov@suse.com>
 <YgU5QvQnzmcCgKq7@yuki>
 <CAEemH2c71jsd5VDZ05pCEGJMHtdxK2_T2MXaK5P73qttBd-gLQ@mail.gmail.com>
In-Reply-To: <CAEemH2c71jsd5VDZ05pCEGJMHtdxK2_T2MXaK5P73qttBd-gLQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd7f1db2-1ae7-4114-c889-08d9ecfccdef
x-ms-traffictypediagnostic: OSBPR01MB3558:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3558624688E2EEEF231A5234FD309@OSBPR01MB3558.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7z8YgjFIJuu1I0E7XhDFr7hjfAoh2owssz9iLWuP6LIHhNwICX78II4MN43y1ECKoa8EbD+85dvAV2JPjME1abQKlk/gewUcCi+fvBaKa8QsJziTdQwIMBmS4AhJS4RYZiKFcJLnHIuzh3Q9u8B9LO772m+PbJ57Xffl2NJ+Wr1l5OudSbcvY3JGg3Kd1WPqg4oN5PDCwTDDZiJuKujj+c4jAJS+jf1W2KOqgjK+HLV5u2YHy6d557PLmHeaxhhu96CKh3fMgs7ipOu56AocBRd1qRPfvvBf2/hb+iLl/sHQT8RBTE6wwW2CmjhicmpL5FPBi689zUcMv6dTqoAq6chpvJg2SZH9x6zhQMhKiQhZSkF78PdQVfARNpn9JosvN0Cmuy0oDfCWGqj1qZ1WK/wfK6OX7n1wy6btBQGo4F/K6ill/bP1mh0T9cfqzIi9TAjhIzi9h091mbuF4o2iCwLhgmsUsaj/1AvZfEnjx4oMf+v8KnDaYDpEBa6BxHsY0m3U5IX+TgQXqLcTBllePsZvIEhKas6yGDjxltC9TC/F4MVKXd8qh+WSSPYtBLiP620n8fPhi9v6Ba/vF6KuMXESKXUPHD+/qexYEILVQS6XGJDmZhPpy8FRDv2i+GsMJBm93vkHB9ga49643UtLWAR1yUd0Wmnbqpe2v38MWBjWGGGPhLWelmGQTfQNNQ9rLADLbV5cOC1HQekvY1xxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(36756003)(54906003)(38100700002)(66476007)(66556008)(4326008)(8936002)(8676002)(122000001)(316002)(6916009)(66946007)(85182001)(82960400001)(91956017)(26005)(2616005)(186003)(4744005)(5660300002)(33656002)(66446008)(64756008)(508600001)(6486002)(38070700005)(86362001)(2906002)(53546011)(6512007)(6506007)(71200400001)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk1VNGlKbDBNdkRrVXJSejR1QlU2UHBqdnhnL2hrSkhFUkpmSWt5Ykp1S2E3?=
 =?utf-8?B?Vm9MZjQzWDQyNVJaWHZvK2Q0MWYyaXVZS0ZvYXhORTN4dThyalFMZSs2UjVN?=
 =?utf-8?B?QWpBOXdPTXh0QmNtcTVUbHAvODNlYjcrWTJMdFpIN0hyR0RXZXZCYmdiNXFz?=
 =?utf-8?B?V3lCOHh2QlRISFVKcEIvQ2t1MFlzbW1NWStCMkdWUnNtdFJxdmk1SmkwTDcy?=
 =?utf-8?B?bVYvTGZnUTFhU2h4bGRYUFRYZ1JBdy8yNjVEajI4b0dNRjczTng5YzdwUlBK?=
 =?utf-8?B?ejNHWjYxOGEwNzUxM3AydWZUNDNiSXVHOUlGcGtWTFI0d3liV2RzNWhNWCtB?=
 =?utf-8?B?ejdSNWNaQXhSd0QwRDVnRnMyVG9KTXJUUmkveUJWekJtTDFxY09yUy8zVW15?=
 =?utf-8?B?RUxIMzRVS2x4UXh5T1RUSFAvb2VaN1RTWGszR1F4bWptTWVGYUZweUpsdS9W?=
 =?utf-8?B?a0RFeHNLenErNW5JclkvdmxtT3Q5S0hVbWkvMGdFTUx6cE9kd0NUNENZOTMw?=
 =?utf-8?B?blVNeUh3aVp6QzRHUTRLWkM2ZVQxMVEyclo2SENXSFMrd3dnL0V2NUR6SlhE?=
 =?utf-8?B?TVA5cFdvZU9jZlE1RDdicnc3ZUs3MmkzVnRqVzA3OTh1N3BKMlZaSW1QOTgx?=
 =?utf-8?B?UkVmeW1SeFBRTW9JNVlPblJubXlicEhNbjloSEhTdDQ0OFBmTEwxaU9Yd2FH?=
 =?utf-8?B?SjA1V1hoVStPcnEvb2tUWDVsaXk1SjdwS1Faalh3STAwVDBQOXdLMnBEQkFH?=
 =?utf-8?B?NWQvSmNmZ1VVMk82SHZBODBLQ05yQkNSOVpSdXRZVUo2cXF2SVN2R3E0Y2d6?=
 =?utf-8?B?REpEeWNiK1paNHJHRFVpRldNRWozaUNBckc3bVpoQU1FTGZJT0JJbExFbHpY?=
 =?utf-8?B?N1BURmx1a0VzV3NVVVJqNTN5UVk0ODZaVGF6aDgwbEdHdDFHUHpQWWhDblRl?=
 =?utf-8?B?NWttUzllRGNRNzlna0NGc1Rpd002TDRlaDBmWW9oa2RMUHQ2c2FZSjNZdkdW?=
 =?utf-8?B?ZkVLa0I3TjZMSlI1MzZXSGFMa1VkQzZNVWhtZlBhU0tmSVJMeE1LbjNVRkZm?=
 =?utf-8?B?SkpJK2FJcVIybFdZeTR3NkhkZjNXMklXZGFNbmV5cHlNWXB1VnFtdHM1K2xi?=
 =?utf-8?B?R3dDcVBRMHh5VHpSTWZSRFhKN01LRlJXS29pbUFQMzlEK1ZVUnVCLzhWZVZQ?=
 =?utf-8?B?VUc1bUp3TEJPUkVuNGZPcmNvN3lDRnUwdEY5NlNPeXZ0emdvanJUbGRoOXBz?=
 =?utf-8?B?YXd0Zjc3Z1UwdlpyekJkYnJvZGtjd2VFVTZDMWc2Ym5JQXRoK2lRdW9ST3ow?=
 =?utf-8?B?NSsyak9qd05TZW9kMzRLMkpUQlZSb3d4Z0s4MnRXU2Irb1I2RFczOVBZdzBE?=
 =?utf-8?B?TU45ejRNYk1MRmJzS3liL1F6dGtjajJUTjUycG1uaGpQbDZLWjlHT25MSkE4?=
 =?utf-8?B?YTVFNFVLUDk1N21rWW1iRnZTYllTUCt0bXhEZTFvVWtMalZiTGU3VUZVaERa?=
 =?utf-8?B?Rnd1c0hPSUpzZFZTUDloQmpNcFNSci9HY2xVRWtUb04xWHZFSXluTmEvVUJF?=
 =?utf-8?B?WUpKczlvNXNTVGczaVh1VTNhNDZSQVB2ZXJLcHc5WnNvZzdSb0x5M0RieVho?=
 =?utf-8?B?YmhTUmtwWDhxNGYvdGUxSTRxUjFITGFwNDRJejFWZzZiQm5aaEVzakRWNzFl?=
 =?utf-8?B?dXEyRTF2ZVZWZ0U4d2FLM0FzcHdSRVA3V1RweUp6VDh1T0MvVlJ0eWF6dUlR?=
 =?utf-8?B?UlF5MGhEQXVXbnFOc1M5cnlmRTNxQjhlOWlUQVpYWk9kYWM1bnpoOWxGSE1L?=
 =?utf-8?B?MUxWOHliY1hLQVFwTXJ5SXVicStzdUgxK0llbUxUNVU3QXlOWVgreDlaRmpO?=
 =?utf-8?B?aThRRmtCUTYwVW4ybW1jazVmb1NXWEk1TXpDaHFLMmcrRkdLK2hibGFDYkkx?=
 =?utf-8?B?YlJ2dGYvNndjYWc3L2ZzTlB2SFNwMjFIQ1hKZDBMcW9JSkllZE1GSUtSSzVq?=
 =?utf-8?B?NGcySDFkK0s4b0tLSVBUNWVPSnp2a3l1Z005V0FyRnFDMWpxMC9nSWcyaytl?=
 =?utf-8?B?SUVybS9CU1hkelpWaTVhckdkZkJPM3htcC9JbHExbVI2MGh5RTNtaUFiR1NQ?=
 =?utf-8?B?a0Vwamg0dWxkTzY1cEtwUy83SFg3NjR0TVl1RUFLOUpTRTNEaWkyK3VNYWpE?=
 =?utf-8?B?OU9sR1kxZXkvUUdBL2QxRVJwbkljRjgvT1ZPTGlRYUVjOG1WZmtpMHVIYitp?=
 =?utf-8?Q?GXGfpgmOhL4+PL62vN02/mUGBWwOE7A8a1DvdUUiTg=3D?=
Content-ID: <373DE42BA3359F4D8C0AF366BF209A93@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7f1db2-1ae7-4114-c889-08d9ecfccdef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 01:21:18.0124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvDB7MBHEsq85hHV2BdA6D26eEPMpa8WYINhMmPIAGyVfhzBDAS7wRVVZoxBTpSlhW2IHmLtGKuksdXpNHcVjefx94O3bm2AfT1YDXXKlAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3558
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li
>
>
> On Fri, Feb 11, 2022 at 12:09 AM Cyril Hrubis <chrubis@suse.cz
> <mailto:chrubis@suse.cz>> wrote:
>
>     Hi!
>     Applied, thanks.
>
>     I guess that the SAFE_OPEN() caused TBROK on machines without
>     CONFIG_SWAP, right?
>
>
> If so, why not go fix with .needs_config for "CONFIG_SWAP=y" ?
+1, it is also friendly to docparse.

ps: I never listen user complaint for the lack of CONFIG_PORC, so only 
using .needs_config for "CONFIG_SWAP=y" can work well.

Best Regards
Yang Xu
>
> --
> Regards,
> Li Wang
>
>
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
