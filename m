Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BFEC32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:02:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CF2B3CA295
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:02:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 000803C88EB
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:02:36 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98A4B600235
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660903355; x=1692439355;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=Vx8Ot/qnpqQ8kRYw3LnEZnCv27vwZdRTFmYdEpNbvyQ=;
 b=qVJmBGCfHbGGBX0mTi5Fh3135ETf1j6BI3VIQZe7ucJLuUIH5L4TI3TL
 Fa42ZZkxXuRxhXrFauOj44jxOnbCZ1/0eVN6p1mtocKR3Dbl/2nU+jju6
 KN43Du0bhUSPLVM8UcQ4aeveE4SVHZ5JR3ZRJ6uN5kqbpoyI02NuWTWd4
 Hj3qa2Zy+yD3svl58NNcwcKVW/XwEdDisxuWt/K4qoFE0LyjGheR64VaI
 GuB05GJtfV9Y63ZLVZjmhyRCyfSXSo6EA/X/NvX1OvyE1+X223Dr/Ragc
 Sqjmp88DpxKXMZrfPye/BwvRVUQGtNBZ5vw7UW/2a7X3jcnJ9vIdCRkmU A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="62823822"
X-IronPort-AV: E=Sophos;i="5.93,247,1654527600"; d="scan'208";a="62823822"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2022 19:02:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtiaZX5PRpLT26/6ZAZ2qw62LYGnxQXP6A32yKPUfDEK+zbO6S0+QUcCOI9kW9q8sd+n1fgsveRKTlq/kiktEBE2Y0GXdcGzfmcTzCGTQ/cHuT5KdoS+bqz8rjrzTdUu2OIPiftTQfjy1WOPxDNsAXqCzDC7g4LnD+5b7/tInEfeqsEe/KbPfaAItfqqQ0FtfJnfTwJSXnwdP7Q+ZQzOgwU+vMzoC84ibB06SGdURfTHst3pd7KvBdv2AaNjNdLkssPyqRte11NL61fksOuiiJEj79KvazXOoHzkbKBhOZjV4aYZgG0IugrUhYc+2rPDfyhW74TrDpZg4HeYfKvmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx8Ot/qnpqQ8kRYw3LnEZnCv27vwZdRTFmYdEpNbvyQ=;
 b=N1z7I5aSTUOyBWrEV1EiCxbFrpAXqPKaPjzQq1IozYbGbsWP8ZUuKnRwV5E/yLklKC1N3pJHrq2+vqMN7LHBiszSZ2cHdrosT3d/3Js7v4fq1JN9zEJuYvqJuRJquc/Xe9iUuJNXBsrEefhSynBoyq5OpHZ01eh8eO3TThKpnXV6ViodwmLH9z/kN2iBT2+nQ3jxWqWZZBVetW1kBEeGmvptEIvkSHb6INzlJ9Iu4LnHAH1pieXjp5yPMhKQ+UtlNegV+PlygliD4mBuT7gFHzGQgMQ+0bfq+z+cQ0/jujfujOyxpR2TETUaxoERFg8+5rG3bDh5ea6w7XBMPgbc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 10:02:30 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Fri, 19 Aug 2022
 10:02:30 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
Thread-Index: AQHYs6sbVtcKUuJd90ucFfHvyztCDq22D0YA
Date: Fri, 19 Aug 2022 10:02:30 +0000
Message-ID: <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
References: <20220819090704.17219-1-pvorel@suse.cz>
In-Reply-To: <20220819090704.17219-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 763a60b3-2b16-4410-c0f1-08da81c9ede6
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CRVKRH+lP8QE4s6r8LGLA0QGWU8aHWs24wBdGGp7tWcWQqB9g7Pl+mzDOI2jjLnmoz4bHh17tOpJeUIyMgL9BXD8QhBsGvp/iQJ74GgUQ/X6HJgcEY+hDbp71pzMl9oPTQl6VYUIc+6UjcFHa85I5Hj0H+9Pqb16fd6/ng4ejc73CY/5PYg/2I9wpQn1+MaCHSsbnljhFDPO9yorneyT82UpgX38A7y+sW9B1zfI7LKfWvKVIo5WzNPuSE90ug6bHjyLnR0RK+jlHBYREj2nd2u0AWsZQv60GkSLNSgql9r3drh4Ft8jrSFM+uNqmRpMAwo+H0ZV5FpXeQ7qk4mpxkVHhsxlmuXR8XcZX555z9XdhfBDxrTcjBhX4f0zIOXEs+/Z1r9voEqWYheevee24CXGDCsegS58JaUtnnhri8kttjeiIxpT0G/lGn0cY4KFTO1RaU4aKYKECGqYgJCEBuwGkVWa9W3NDmIURbTwPD4ESsui43G5kCxVlClN9EQ6dHVJCJTBD1YjKgLZbgP1tlJBa+AiGhMdB65hm0TPREpDs2uQNS6etRIE2oPegLjzVjp3jh+CLFPsnCcEs8Ikcutde/Hqx2B6/U6WL3VnENxHykhm/03qekNONcc0PEPDg7xvURJe7FAiwuw36nWQq25Aovgh9n0w1Q3dQimNlhjiI8+o1g1sFjRG2YGFusvncUUtFjTbJHJNsPQj/r2ZOkxUDP1EL5+qf0b0rzfQw7obaojRe21KAWutFXJL4QahB0ZJk8yUMzDHoZ/UiRfJm/qvhhaQQxgVc2huOsVVElcaEvFsdCHfSczJaHsaXQQ0zrZLdwoAkV2uMCmrpMwk43nIkNBaeOayA1e4sVl++rk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(41300700001)(66446008)(66556008)(966005)(6486002)(64756008)(66946007)(66476007)(76116006)(91956017)(8936002)(5660300002)(86362001)(31696002)(2906002)(1580799003)(186003)(71200400001)(478600001)(83380400001)(6512007)(2616005)(82960400001)(26005)(6506007)(38100700002)(38070700005)(8676002)(316002)(31686004)(122000001)(110136005)(36756003)(85182001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xKd2UwNkpoYnErYjNqOExESmJBRk04ZWtHSmxYUjFaVVo2Zmk2SXBnNUVY?=
 =?utf-8?B?aG4vV3pPSEVrY0w0UVpyUzViRkQ2TVh0ZGFIclg0RlA5RW1QMm93bk5UR3Ju?=
 =?utf-8?B?Mm5NT3hpQW1UMlJ4U09BNjBrRlpzQnYvWlhLSjE0RmFucmFLYXVUQ1M1UVhu?=
 =?utf-8?B?MmlJeTBKdUxDVGQxSGU3WC90YnRicGhOK1NpZ3d0aHdRajU1aFBqdHlsaENP?=
 =?utf-8?B?MVYxYnJKcjR0VFoyNTBVVE9BUnNWTkF1bGNmVU1sd1FxbTVtWVN2MGdteXJL?=
 =?utf-8?B?VlAvb1FXSWNHZHcyaDBCR205UjBQaUM4MTgwZUNjUnFxbXhuc25kVmlJQ2hR?=
 =?utf-8?B?NzFEZEVxcGNnUmdMc3Q0SXNIL2hNV01MYmExNkVjNURabzJWbmFnVFphK05w?=
 =?utf-8?B?eVU1QU5ESTltbzdybVRTcTZOMm9WUVg5UUFxRVl2dENJYU9CQWNMcFkybndG?=
 =?utf-8?B?dnlZSi91ODFidFVSWE9vODJFM2J6SE8rd2RGd0JYaUlZa2F1M25zd0xtK3Nt?=
 =?utf-8?B?WkFOMXNvKzJvNktJeFBEUEtEclU4Yk9jVVZ4enN5UTdSVzFaaDFWS2l6endu?=
 =?utf-8?B?eGdJTUJYdXdtWlJxWnBSYnBXcTUvMDI3ZlArMzQ0cHgydFpjWmx6V1VmaXQx?=
 =?utf-8?B?VTNJb0JsbXNJcVFFT2ZpRklqL2lqc3RUcVdMeCtocGtIRHIzRXdkNGRLWnhz?=
 =?utf-8?B?WU1YTjhqK09YS2pNZkdOam9kbkFseDNhYk1HbEtwMzJDL1dNa1F3anhISWd2?=
 =?utf-8?B?a1paYlJsQ3h2blNDamRQRnQwSkJXbWpvWmNOUkY1MUVWWmRQaGxKaUpscHZx?=
 =?utf-8?B?OHBlUCtSOFI1S3YxRjQ5QlRPNHdwS1FjZ3l2ZEh2MUtZMUVXSXFQZzRWZHVW?=
 =?utf-8?B?VEczZU9uQnJPUVBaUGR2a2Qxei9XSExoRlA1WjZYQWt6TjFQaVRTK3lLN1lk?=
 =?utf-8?B?ODlkbC9PbmZTNnZJM2ZHeEVlMTZ4SmdHb1c5Y0s1cWV3RHhTcUl0c3lCRks5?=
 =?utf-8?B?UFBKcEl3bkVZRVV5T3JENGc2R0dLdVJ0eEdiQ1ZCN3BoVVdPU3N6TVllR3Yr?=
 =?utf-8?B?V1FJTWVjS0hSWGd0V2FVTVd6Zm4wNXYrNytTcUlQVkI1alljQWZlM2xVd3RS?=
 =?utf-8?B?THVwVm9LL2hqWXd6dHFkelJRY0hZY3RXVjNMcjg5ZW16VDhWV1JMTTlXNTNE?=
 =?utf-8?B?bUtIbmxiVXBUR2QxakxZR1BBb2RTYm1DZ2RJcDBna3gyZk13V1RoL29YczJ2?=
 =?utf-8?B?aHlpeWJrczBBRDZuYTBSNy94bFd4M2JqdlplS3FMVW5jQ2Q0eGtIZ3FZVHdx?=
 =?utf-8?B?K0wza2tpNDJRR2ZuOTJrZ3JtV2dvRmxLdGpGajhKZ1hzVE9vK3J0T1ZWV2Rr?=
 =?utf-8?B?a2s0bTlFZzlqYXRUZmVuRk5Fb0N1dTljZ3ZTamh1WGNvWXhOY1ROV2R3OVFM?=
 =?utf-8?B?THFWeHFpUGdrc2dQeG9rTHl4YzdZcXNsV1o3T1VjcWlreHZKVjh4WDdFQ1RS?=
 =?utf-8?B?TXYxazZaeXFHMFhlQlUxNzJyYWZEYVRNTVVjK1RLT3QwQ3p1eGFaU21BSXdl?=
 =?utf-8?B?Wm1iYjhDTkplczVabTExVkpsQloyZ0xTNWF4M2thblhPZS9HRGZhdG13SW5r?=
 =?utf-8?B?MzVnRFh4S1NtemxCYlhYeU44dkpJUnM3VDYvSlVySy85dFJjbHc5SW5VR2F2?=
 =?utf-8?B?MGluSzFxRTVtU3NVNm1QYjdnSUgxc3ovOE9ZUGJnRkJUVUx2MU1FZ0I4Z1pO?=
 =?utf-8?B?RktWcWpweWlsQVZtNzBCb1NOQ2R5NUk3UWRiY3BpbzZvOWhxSEp2YWJod2Fa?=
 =?utf-8?B?UWRsUjlMcDY2VVFxOExPZlI5aTg2YzJuVHI1aGtDdTBrSXVrSDM2ZkhYRVdn?=
 =?utf-8?B?dGlXbDdsdyt3MUE2TkdVdmpYdER3WlRVZ2ovREN1K3FBUWtQK01kS0hiMWZa?=
 =?utf-8?B?VUpVcWlWcSt6RDNTbEJYMjVoWVEwZFhCT2VRZmFuNnVyNTduUVYwMEZOQWxq?=
 =?utf-8?B?YUFVZUFhdUVsSVhGRXFXamgvRFhtU2ZRWHdBQVRLaDBBNUdJcXJRNEVTV01D?=
 =?utf-8?B?cW9Hc1BPekx5Q1RLMVB5S1N0NWNNcmZobDY1cnFqcGxVcUFHVXM1N256Ukwx?=
 =?utf-8?B?eG9SQWJ3dUVobnZ1Nll3bEk3bHEwQXpOV1hqNFhINEhsak4rejlNa2ZWOFRo?=
 =?utf-8?B?R1E9PQ==?=
Content-ID: <B45D5FC87EEE9C44B97CEA9BF10DB259@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YtY7ysDf4I06DrAnehvXAAu/74D0sG9nt4w5OeZB9LLYp9VZUbcanFTk3n9L/pvWHspZEHgtp+YEE0cT1SiHT0WBd0LmCuDLx9DYmbSAtl9mzW/zWue8f5xM/7zWGexNGizOjyytzlZGWLTAoP2DPB7W/VYVwKDR3kp+uV20Nqqlct+0JmEa1rpcG/HunteDWFchcjSXG60Ypk9lwsEaWh7aa7WXu6pmYT1IN6RYvfZBe/q+aG/UoXco3eYzEVJvCIcln5Nw6wkeWDY05M2nzJeKRr+xJ2XKm1jzkvcrxzOoiutln+HeD/BJRR7FpAh8c4M5gJdkNRDrvlKtnT9axjt4HjpIA4RZRLPxdkjIjV4EcbB/KtS36PYv5DKTM/KObdq8q16QlI5WCcuqxqi6Y4m4VUKdfc6zI69gAsEi6PfnQvqjbw2Iua8YctK9TTUWbQTFOW3ZtTQ8xDMLvDRCNy0S+6nany8/VBl7a6Pmif3PUIkarn4LHugn4wcxM+4NCifOB3kKdMixoG+20A2lDdY9agoGxezQQb4OgzQUaIeD0WDOXnJAKxsZZp118nqRGu4wiEfqU7Ma+QQZZDT/WjhLaCJUf9XAOxMqH9YCxET6IeVxl4KMQQ1LICeDvqSFmVd6i1oYJg4Kw8H5KDaCc2eQnxqDuPorCsIJnbPZnsIbtSt5gvCrPmaiRr12nP+hvN900Ydxhvy0eQAV1w6r7aPS8/sUcGC/95fQVbqW/gfnvpCbzQBsE3d1wUepSO0v
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763a60b3-2b16-4410-c0f1-08da81c9ede6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 10:02:30.5610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyCpF4Fv/G5GfO/EVaAs6EI9gSLrau0SaKBKjnGeJ4j8V0xYOpRFU5EGgqe/Tz/NfTroUawpnaonDzF6XOiZwaQtEMPCS9E6DqI+jFOrZ/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9983
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
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


Hi Petr

Oh, I see commit title in metadata that I don't see it before.

Tag	   Info
linux-git 93bc420ed41d ("ext2: support statx syscall")

linux-git 99652ea56a41 ("ext4: Add statx support")

linux-git 04a87e347282 ("Btrfs: add statx support")

linux-git 5f955f26f3d4 ("xfs: report crtime and attribute flags to statx")


But user that doesn't use metadata(miss this usage or miss dependent 
package ie rubygem-asciidoctor), then they only see some numbers in tag 
but know nothing.

IMO, it is not clear like min_kever.

Best Regards
Yang Xu
> They are defined in .tags, having in docparse results into poor
> formating in metadata.{html,pdf}.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Li,
> 
> I've done cleanup like this in the past, but sending a patch just to
> make consensus about it. If we prefer to have git commits like this in
> the code (i.e. if being in .tags is not enough), they should be in
> normal comments /* ... */ so that they aren't in docparse.
> 
> IMHO docparse can mention some commit if wanted to add some description,
> but just as 5f955f26f3d4 or 5f955f26f3d4 ("xfs: report crtime and
> attribute flags to statx") if the commit subject is a description
> itself.
> 
> http://linux-test-project.github.io/metadata/metadata.stable.html#statx04
> 
> Kind regards,
> Petr
> 
>   testcases/kernel/syscalls/statx/statx04.c | 35 +----------------------
>   1 file changed, 1 insertion(+), 34 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index 98f9a6315..6c562b3d7 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -14,41 +14,8 @@
>    * - STATX_ATTR_NODUMP: File is not a candidate for backup when a backup
>    *                        program such as dump(8) is run.
>    *
> - * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
> + * XFS filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
>    * three other flags.
> - *
> - * ext2, ext4, btrfs, xfs and tmpfs support statx syscall since the following commit
> - *
> - *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
> - *  Author: yangerkun <yangerkun@huawei.com>
> - *  Date:   Mon Feb 18 09:07:02 2019 +0800
> - *
> - *  ext2: support statx syscall
> - *
> - *  commit 99652ea56a4186bc5bf8a3721c5353f41b35ebcb
> - *  Author: David Howells <dhowells@redhat.com>
> - *  Date:   Fri Mar 31 18:31:56 2017 +0100
> - *
> - *  ext4: Add statx support
> - *
> - *  commit 04a87e3472828f769a93655d7c64a27573bdbc2c
> - *  Author: Yonghong Song <yhs@fb.com>
> - *  Date:   Fri May 12 15:07:43 2017 -0700
> - *
> - *  Btrfs: add statx support
> - *
> - *  commit 5f955f26f3d42d04aba65590a32eb70eedb7f37d
> - *  Author: Darrick J. Wong <darrick.wong@oracle.com>
> - *  Date:   Fri Mar 31 18:32:03 2017 +0100
> - *
> - *  xfs: report crtime and attribute flags to statx
> - *
> - *  commit e408e695f5f1f60d784913afc45ff2c387a5aeb8
> - *  Author: Theodore Ts'o <tytso@mit.edu>
> - *  Date:   Thu Jul 14 21:59:12 2022 -0400
> - *
> - *  mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs
> - *
>    */
>   
>   #define _GNU_SOURCE

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
