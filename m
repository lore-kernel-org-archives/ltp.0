Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E50C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 09:55:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E472C3C9212
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 10:55:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 790533C54F7
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 10:55:11 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9C2B6008DD
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 10:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647338111; x=1678874111;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Q0Vj3VJwd/XADDXzC/SVH1q1XJlf2O5EnUgwScCskjc=;
 b=I+HWFQjwCJliot34S3azL4trsYv9mTPRHNCWgc2QCDuQ+eib6eCNuioe
 fw8F26xBLKHCLmi0qC0sfztSjMio2IIUDuS3rKFTqEy7GYofqib4mKHCq
 RIY5aM+GWJbcJSQY11/KLjP6TNi5rpmkqNUbJ0pakmvcEG/5fVek8YXkl
 IwDoM29gvZ0hdYk9txZVwxRjy2+DwXKi82p0aTMWknZgh1rQKPBcNJKnq
 qA5Yoh5eXXUMaFcZbk/3LyI7rqNhY5nBuVF2ic+TY9QduXZ17142UBXQm
 +820/yDE0U7tVOei9VWi3ZW7od0SgslDudXbhYc7zJaebj8SJiKiQPDh0 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="51709516"
X-IronPort-AV: E=Sophos;i="5.90,183,1643641200"; d="scan'208";a="51709516"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 18:55:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZt5xluMTgr+vBBLjPfZrDJ/Nk9U2T/mgj1ihpctzZ+F/pmBmJwY/tOt6+06XwZyweOuYdQ0SSN0g10DIcvthjD0I9rT9xSbLoJMPEuivO/gzmMMvDjDLDqk9bswzgJYGwelSkdkCzxuyETejx0o8B5wc6ArYbFh1KbZW6tjCkIZMPhI3UD3G1r0CFCofRcPOhoWGh94FiLQd8hrnljke1CsNzY9PFcxDCUK/PBoxSxvpnQzOyU+LYrTBJL7fJMZByeza4lNDSwvoIIrVaBQ4L4Ttazd7SXsYe3xpMmeGxZwq8feXvbB9Vw2rLUTaxtS/FHIBAxMV6bxqk+wNf+yoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0Vj3VJwd/XADDXzC/SVH1q1XJlf2O5EnUgwScCskjc=;
 b=AMT0D6Qk5NrVCSzJP3z3sODFaJsfniArLeYmHMmWUjR/RlmCKwIiLPFR6R1BLINIGm9Qah+EdJGJY2TsJ7h7ILRqiArI+iLPa37Zt7svCqiEiWpA/hGZ4lpZob3XrihptH3c5bMCHhFelop3hJwxRblBEG8g/i6GX16+/ZC0bm2Gv+WgYLN5Z1+gjoLqIvKcSJGKBVoyO5Nds6ad8TdaXL5NsqXfK5JyibT44SYbwgIcoGiaupi6SA+cuq/UcMJhSgATDPh2EORBlBvZEf1v+tpIMECB6W+Msy3KKQ4tr7n/30vFV1+ftzUruvYTUSQnWGsgLJ6oMQfloX6Wlzk7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0Vj3VJwd/XADDXzC/SVH1q1XJlf2O5EnUgwScCskjc=;
 b=Gnx5soxv5mIr3kR0vhWOqa/1ilxQrEHUgpF39aa58bMgf9LWeZ3USQXhZdhygALs/7O2GuQepfVDTTPw4paD4Pc3k47lndg85ySpxn56vBUvRyGy5En98cCcTtaR6kR4VMgSEaiPKCWD0IbXg+zVmly9FGsw/eItbMfLh0eNRMg=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB9394.jpnprd01.prod.outlook.com (2603:1096:604:1d8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 09:55:05 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 09:55:05 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2 1/1] quotactl: Check for missing quota_v2 module
Thread-Index: AQHYOFHrUAkxbSyg7keW5YKPXWjGgazANQWA
Date: Tue, 15 Mar 2022 09:55:05 +0000
Message-ID: <6230629D.2@fujitsu.com>
References: <20220315094901.5855-1-pvorel@suse.cz>
In-Reply-To: <20220315094901.5855-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f205bc79-609b-4029-9ba7-08da0669e1c2
x-ms-traffictypediagnostic: OSZPR01MB9394:EE_
x-microsoft-antispam-prvs: <OSZPR01MB9394E39AADF4EAD021F23085FD109@OSZPR01MB9394.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0/AdBjLBqLQFmTbeCjGGxVITZd6LcabeavVZ0Ev6iiWWQmW4NyisFaz1Zpy0zEQXSmRwGnw4g9fHCiOdvPxvX/G69wbNiwl6iTtIScUk6EG3KgMUiGAZfBRzWxFD3rwx24x9emYIEQ53lqoEp07a26KgVZ2CWAzvooxdfjBE7PY7bLEhs2+MF9un+m9DPgL/5oJEw0YTmwxcv8FhIJhsymPQo1x3qX7TwYX2yL0D5qQy6EnBHAFIpNq8jU5xs/c22GQ0JMBsNMTkKXZcLPGXYQ8diLYdwIb2BtEn3gMFARWBxi5rHw8OSELHeH7sQqlzFlYLxuuFqPrmrIDIeW8U/1FhLFjnzbw+WEq5UZZNoVzoTIND8pYNPIxxtx26fJCyAug27cTBlCt4xtMtDUxyrl1cexWX7BLOBT2TkNhVoageZ8KzBjkx8WwUvsQlVBT2HZxyFSryeKGNB78hdgYe9RKoAZSfwQd32bVZR3VA6OWhelf1NG8xaOjUlUudbmvI+vTIwell+AU0gqx2rD6u2kRGyDoa2Qg6CNkyCJxY0j1esDsoPXb/IIbRa4q9l8SsM+xfRpmweogOJi6bRtgJAm2GfvIV4c75lVJetocRZLni/EU3xfpcIiQsBYSZ5nvotDI5YU797naYrXmcrOobKrR0cIwu6rPmDV6FlpKDYAStLVLED9SpCklMHbziA9osq3yGic7xIOSHAWAyfhNMg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(2616005)(66446008)(66556008)(66946007)(64756008)(66476007)(38070700005)(38100700002)(122000001)(26005)(186003)(4270600006)(4326008)(91956017)(8676002)(6512007)(82960400001)(33656002)(85182001)(36756003)(558084003)(86362001)(8936002)(2906002)(6486002)(71200400001)(508600001)(5660300002)(316002)(6916009)(6506007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NmtXeWtweFBUbml5cEd6SEdhbURZeElVR2VVbEJrdjdueDVNR1R5SXI2U1JX?=
 =?gb2312?B?WElaNG90ZDBkQlJLdXNFV214L3VtZEhIMWNSWWxBQW51MmhaTWJmSTNFVzBp?=
 =?gb2312?B?ZG04dzlmcTZ1akJpazcwQURjc3k5amh3VVh5SDJqbFk0Mko5OUlJdFNlSVY5?=
 =?gb2312?B?K3d4WFlIZkVSK3JYSU1LSlVpWVY4ZU5YaS90YzN5MExSNGxTVDV2NWFsRFBq?=
 =?gb2312?B?MW43UGhacmNXZEcrQnd1RjF0eXRtM24rSXpkM3NoYjhwQldka3N1Z3J1MzBY?=
 =?gb2312?B?MDJWMUsra2Nydlk4dkpyMmFqRXU4NHZmTmF3OGkyOUdya1lPMGU1cjI5TkNr?=
 =?gb2312?B?RXQydExVdm93TkRiNGMxQ242L0NvV0xqZXcvU1VtRitIWkQ3UE8wQ2RNUVdX?=
 =?gb2312?B?Mks2K2FCbG1DVDNjOXBVV3lLUjhaZ1crMm13ekVES3U4THlXaDljL2pheHhL?=
 =?gb2312?B?TWhSbnFjbVlmQk1xbjBUOS9kU3Y3QXNCTVBMdm9oNlVHeC9PNmxoZjhJaEpT?=
 =?gb2312?B?K2l0eU9lVWEzUTEzc2dtVEtxbW5tRytOUFlDVWJmTnNIZTB4ZU1ESlA1VU9i?=
 =?gb2312?B?NGk4NTZJTG5nQkxxVUJkWmFBOFVBTldNSXZsdVc2UllQd01HZnF0QWNlVzB6?=
 =?gb2312?B?ZXdRaFF3QTRTQVJLKzlHU1ROWGhRYTk2bmhRbUo2YzFmdHVXeFVDTENrM2dt?=
 =?gb2312?B?WFVnYTAzR3V4cGFNM0x5cUpETnhmcmlJNysxNEduV1o0emNuVFQ2WFl0QmZJ?=
 =?gb2312?B?OUhsWmY3WjVQcUZBSi95ZUs4OTJ5VkVBSDdSWm5vV09MLzlndlF3TTAvYzV0?=
 =?gb2312?B?SEhJOXN6Y1R6NTJwOTl5RGNTQWZRbTZvVXRzanZEQ0RhS293NzBSWkprc0dK?=
 =?gb2312?B?TXl4YUIwR1ZLYkkxOVdPRGEvcnExT3g2Mjk4UGVRdlp4bEtvUFlyT1FhRncx?=
 =?gb2312?B?ZDRHRjNHT0Nac25GTCtqS3J1L08valBzUCsxQmI0bTBQVU9la0tKVThjejdj?=
 =?gb2312?B?eTZZbmt3WS9VS0dkUXIvQ1hCTVZ5c3hCOE1ETS9QalUvQUwxRVZFY0p2emx0?=
 =?gb2312?B?UE5KdEZLVUJuN0ZyYjlxZFZCZEtpRkc1NTZpdndYcWhjMGVQTXNhYlpOSk1G?=
 =?gb2312?B?NXVOZzVKS0gzdzFMOHZUb2h2Wk5Pbmo4allPTm5NenBGZG1mbXZtOWpVZm4v?=
 =?gb2312?B?N0czUUU2YlQzR3MwMGhrMERPZlp3YVpzN2RCTkJOdmU1ak9IMjNjbmFvdlRK?=
 =?gb2312?B?djl0S2E3MlhYOUVQeWJKbHpXUkJvcTdUemVjSkJoN085Nm9yaU4rM3dJeFV2?=
 =?gb2312?B?dDJ1ODQxcnk3WXgreHUyUEFqcHF2K0ljVi9rQkxaVkRub0s1a1JmQTI4MFlw?=
 =?gb2312?B?eEtJQ0tlaURrVW93NE9CSEtOVG5WM3lMckFHbWJ4ZTdhOFRJd3RBMjhYUjB0?=
 =?gb2312?B?bzJQWDRkdXNnRXpnVWNPbHhxM2JzUHk3U1dCbEV5ekdSNFJrR2Fta0RTRGtT?=
 =?gb2312?B?TkI0eVFMMi82enVKQ1d3MzdRTVpkUnk0ci8rMlA1NGFFUXk4VnZQQlNnZ3dx?=
 =?gb2312?B?d2dPbW8zOENvS3J2czUrcHVFNkgrejBDeCtPeUZVdGtlNDYxZUVpdzJKc0pp?=
 =?gb2312?B?eGY2YnQzeG9lckF0VGJUWlpMWVkwbXdFKzJvSUYydDNFVTBGMmEydXl6c3dD?=
 =?gb2312?B?b0NmbE10c2dCZnRmeDBiOW5jM1JqdnRVRy8yaDU3TnlDSFdqVTloRTNHOEZN?=
 =?gb2312?B?M2NQQkNNbEQ5djN0RytGd1B6eUFGcXN4c0xsSTBkdzZTbjBveFY0Z3hCbHlD?=
 =?gb2312?B?ODRkQWg4RGFDSHFOT0pSQmhCU29aU0w1TjY5MmEyU0ZsUmdYVGZCSmd2NDhP?=
 =?gb2312?B?LzhqblZuNmRkUGQyQmVBQXRkdWxvbFBsRjY0cjlBTmV0eTlLVWUyVEJQcENz?=
 =?gb2312?B?TlErK1N4UHk2d1pPYWk1cEFnc0RvdmtsZkJMTExaczBGWFZxQnR2KzVUU09B?=
 =?gb2312?Q?tJPS4gdNVBH1ZYjLq+0BFfnaagZR3M=3D?=
Content-ID: <AC2CDDEE8A0C9F49ACAFDC0DE47C952B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f205bc79-609b-4029-9ba7-08da0669e1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 09:55:05.4994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VM+By6CDtEH7d4lrgBloPdOshT74nhh/FSSUcPlVzUBLGDO9B2sYK+n01MhlB3RxN4ZCJMGTuoYUiy/df9OfQfAvkZDUHQHLzKWydBxxtek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9394
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] quotactl: Check for missing quota_v2 module
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
