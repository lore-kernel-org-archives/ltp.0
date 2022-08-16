Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB828C2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 09:54:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2253E3C98CE
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 11:54:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D4A83C97B2
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 11:53:59 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78E0410007F5
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 11:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660643638; x=1692179638;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zYwWZD91rMNVIdq+mA8zuEfrFPzmkExqQiY0WYHSrOY=;
 b=nfvmKO0sAxkmBEV5iqcLNLyeYsV81wC4nsJNJYIN04QMVEklqsONzSzs
 wdGzAT9cGa9FTo3BO470C2l1CcXVRNss+ztt8T1cyEHSSAvUEqnBsHH69
 2U70RQ+PrNb7EZX8a80nwR/71GfrmbFWHNHUf9V6dQqKAAuVcIJIXrGmP
 suCmaKb82PHE6LfYVWglbsgD/fKNLw8cmp0v/PNOgApMy74bpyYBiWzE0
 VkfZx+g+VFToZENvJq1eg0ZvzUderw4huwVBZVQVoUxgrEB1PF3c1zPNV
 28XkNQa3SElTmCCMXM/AMWYMiLetLzMwJO5W9CxEzcUtIPg0BSUAmYMoY w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="62911824"
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600"; d="scan'208";a="62911824"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 18:53:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbhAtS2R6RUnsxsR7iRkEBqQbAAeBRKESXyjxDQdjdgX2ArerE+g4KBEb6cfqlOQ/M/bLMTtpcgBaSQ+ATYFFvIoiCiyptYJzoB3TFTomwS/2DLtHR0g5F5JsRJJePnYx6LwUjXW/jXKDzRA4gR3aKEGruiteopeuv9o4cWRxgs3Q6RBJJfxCPIvQTPqYf/isw66QrkynnDrmeZ4qBRgniTpGJ3UW6rOt1k8XFfTGixzs8MEqCiCYqkRNI0wqOhsei1hDYxqCZuaPum6yL+rIk80Uh64JDG6T8Uc8PsJ4YcqZClKilqYrgWywuhXlc368fTvos1JmOEnoXHqav10ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYwWZD91rMNVIdq+mA8zuEfrFPzmkExqQiY0WYHSrOY=;
 b=l4nD0CBf2Z2MqbdIGT7dSSCfHKmOMvtFoFOQgox0UP0Lk3LATMdbBp8gN5S1HAgEI1cpHRSH1F4f2iszDVx8VgCoOJS5iXS967WEpVFH40xllQTSU6dJqpZjWkMw3CcUo2JgSxRKvM4OUPuiEHKO/UJEOZkIFKEQ/KWFz902YG9g3wJI8wo4U2PxDeY4/XcQbuR6VC0DCr28tqZvhvYHWfpH0HAbBaNuo4FlCP9rpB77eCDmR6Kp0ZIXFB0iE3EQWzhfWwCA1hjWKqV0HjX/MK1QCX0sTeV90gXhSnqIA4ySc6554fuBcawp2oP+qv1F7/Xbb0Znkfb32X/ih+kxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB4579.jpnprd01.prod.outlook.com (2603:1096:604:37::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 09:53:47 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 09:53:47 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] mount03: Convert to new API
Thread-Index: AQHYmBOoqm5IaIDdEEayRx+hWUOXY61/pByAgAQiagCACxEWAIAitWIA
Date: Tue, 16 Aug 2022 09:53:47 +0000
Message-ID: <e043db5b-91cd-3e26-d6cd-32189c91518c@fujitsu.com>
References: <20220715062519.2480-1-chenhx.fnst@fujitsu.com>
 <YtGZZeUm2iB/uySr@pevik> <YtURQlBJhpnWoSCv@yuki> <Yt5Z0s6ymBfgUL4j@pevik>
In-Reply-To: <Yt5Z0s6ymBfgUL4j@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43c2c1fb-68ea-4850-9186-08da7f6d36a0
x-ms-traffictypediagnostic: OSAPR01MB4579:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2u0WhwhH6fEfvOEmc+vm3kyldfURXzsa2psC34cpdJsxwEBbE9tSvrblwcRrEG/GdkfI+m/vlv7+FntZ0rjZj9TKrImcNfgUeE6Aeles5FquPicgcxkKEB+/+k9BupYqLVpIwybus/nROgfMxqpaJcrdhVdrO5yBniclEvIFRYkj1qyIcPa5ZiGl3IvIvPX/zYwWZQxZoDSf2TQOCUbISo/Guv9EHUL97N26DsO+btYp6inb7MR5vv9i89VMruxM24R18qfCKZEBwbM/u72nu527p3lHBtLUI8hqoGGyNb3iYcV7NCwPaTPyrQTEoeB/sG/4dDZr9cSxS2N96k2ZcG3kGJcjLikTPnCOujFnSiLc6PXGwcje2jm1ItP089/7qx28UfIBr4Xwnl/lVYyQK/kJS4tsyaK6mgqojKAtPS3eTEXtlS0/p/CcPLDJ42ZmuW14On4jk/FkTNuLLQOGqsXOjNyNPustRZRo+AVSauk78TxBCq4Mjyx/2gb6EsR0Jva9Y3y+Lq++nul2syEy0bU3341VbPP1hhtEaop7MLCdSwQXpK6CNFzmnOwQJ03Qt0ou3R4zMBAF36QZjOEEBfftjdcqhX0e3EWWdpQ4PO8uTLrkoIeSNtnR3jH6S0zK+Y2D44NRGZarzCeuS6DaP9duZxn4/OhhMQnCvmI8KqKx5VdwbJF0kjVnjMpevD/KIitLQ/VgnRAV2emBx3qXzVQp5T7hZB8Y/QfkE2DC1OGG4tb+PP/ok25tIOSYNVEjlQjUgrwjvnsuDj8H5HnTPOyY56GYgNAVWpjwQnj/I0T05c1r2rdB/dGcN1R15VM5fwzF6wcBiln3XJhQd8cuT67dtzrRq6wUH93gQvVmkwa+C6vePXst+8+D56lq63eWLvv3U3OKEBYKKzJ52VWaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(26005)(316002)(8676002)(6506007)(36756003)(110136005)(38070700005)(82960400001)(85182001)(54906003)(83380400001)(478600001)(6512007)(31686004)(186003)(41300700001)(2616005)(86362001)(122000001)(966005)(64756008)(2906002)(38100700002)(31696002)(4326008)(76116006)(6486002)(5660300002)(91956017)(66556008)(66476007)(1580799003)(71200400001)(66446008)(8936002)(66946007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXdMUGkwUWRDazQ0S0YxWis4SUxTWE9zL0lXTnFTNjN5L0pUTkdhbXMxa1VG?=
 =?utf-8?B?MjlKNVNQNmJrTCtxZldiU0loSE5aMTFaZFFWbEZ2QmtpWUlPd2RiY091MlFD?=
 =?utf-8?B?L1lpM2FHU1RNR3NZdFpBazJzSDRHZGE0dzZJd3ZKcjV6NGkrckxlRzdxck5Y?=
 =?utf-8?B?TTkyNkFxU0l4VUh3OXVVNzB0YUdCczhCRVAwL2Z1ZDY0T2VmZFlwa3RjSE1X?=
 =?utf-8?B?OGsrVlNvb1JmZE43aGhUL2FxaWI4V0hJVEFkMnFwcFIzM1lOZmh5VWt1VTlH?=
 =?utf-8?B?cXQrdjN6Qnhtb0E0RzFPU2ZMMEtRTzF1SnFKcC8vUzRlVTdyTG0zelltUjN5?=
 =?utf-8?B?SCtrV2dMV0JVVTdXZHVlOWlNTHdTbDNuVVdRUE5WTmp4bzhnTzQ1QTYwdkRV?=
 =?utf-8?B?aGdGNVNZQWhCY1UzTm9Qc3RoMkN1TUNYbnIrdWNPbW9Ua21ybFp5UWVTQ2RU?=
 =?utf-8?B?ZmlNRkduZ2Fidmx1WWVsNk5LOStzWHVaWmRKSi9MTGFhQTVtNWhjZUVUQnc3?=
 =?utf-8?B?TXNnL2I3Mk1nWEU0NS9qN3VwaURRYmJxVzJnUU5PQ2QyazFwZnhkRWJoYmNy?=
 =?utf-8?B?Sm1VZ25BVUVsOXhwU05rWitSOEZDUkIzT205ZDFtbGpJVzRiK3IxaW1JQVNx?=
 =?utf-8?B?dUtsWkZCNU83QTJ4Vi8xaGZKTHNlRnlYUVpDM3grRmE1ZVRHaFdid0R4MDJ2?=
 =?utf-8?B?VXVrS2tBOEZ4bXFZa0wrZnRWL3E0a3k5L210aFJaN0xSN3FFcjV4T3J3bWp2?=
 =?utf-8?B?cGpWQW43T2VPc1N0VnAwREpremY2LzBRS0poOGR0VEJQR2lZU3FubFk4NU9W?=
 =?utf-8?B?OWY4STN4U0RUWDYzRTBDNTVxa3BMQ045Um9YWDNYdlRyQnlVS0xmVUxvQS9x?=
 =?utf-8?B?aHNyVlVBTmZLMjI1QmM3UE0wTFU2YWZZUzZlelRNLytoVlk2SkRJaFhpZjl4?=
 =?utf-8?B?NHluVW0wMVBkNjFQcmV3SG4wSmRBU3pPOUl0V0J4a3BidEpVUEo2bDlvdThP?=
 =?utf-8?B?WU45R0pyVkQwSDNNWmFkOVFVYngySWt4eStVM0V4cURSNUQ5SytRRVRodS9s?=
 =?utf-8?B?WWdHTWdnT0pFeW9HWEw0STZ4TTY5d1g4TzBONjUwdCtTRGN5aE9kWDZHWmJo?=
 =?utf-8?B?SjlpbzlNaGVVRGtxbXFyYlk2QUR5dnpqckFHYjAwbmVqMjlUK2hVbTdSSUxs?=
 =?utf-8?B?QzMwQWhONHVYRlBHOStTb21ESTlnTEg0ZFNHdVYyalJLdXY1NzNKbFdTcTg2?=
 =?utf-8?B?UXJ6dUhGSitUUnFlMExOLzlsYnNWMjdnMUpOZ2E0RVNRRGxiZzJOOW13L3Zh?=
 =?utf-8?B?ellLZ3R2NHRDNDU0TjNiNFBqUUpMNSs4MjYwUHlaM3NtRzZrMjVuOW02d1B2?=
 =?utf-8?B?czF4Z0VXQVRKSnIwUHkzcjQvRG9Td1pXempOc2Q0VjIrNFNTK1N0bUxDREFn?=
 =?utf-8?B?eUpuMllWeGJOV1lqejBCR3htallBc0RFQTM0elArUldUNldHSEtMWk9VcjVz?=
 =?utf-8?B?cDRIakpkVmg0MXlMRXBDWnQ5SXRCbEpjTWhneFFJTDBmNFV2S2hkUkhQd1hB?=
 =?utf-8?B?UGJ6all4c0ovQXRqQ1pPblNjTjhxbGNVT3RMNDdxdFFGbzBBVFJiZ3NiRkJv?=
 =?utf-8?B?TERiMkFJSjJTRHhWYmN0RHpEVkxQUHY0eHQxQ3Ezdk80RmFyOSs0U0dNdE04?=
 =?utf-8?B?Ykw0YklMYXZhNHdza05SL1NIRklhWXVhejkvbWpES0FoVHZaTUR6TW1vVC9R?=
 =?utf-8?B?NGxmVEc2bThBeENWblFrTEY1NUliZWZmQWErSFhyQUpQSm5RVVpNdUpHOE5J?=
 =?utf-8?B?aFVydDBicktZQnU4ZHFQeTNtaVpiRVpqZzVwbksxb3htSW4xYWVIbTd4blpM?=
 =?utf-8?B?V2JXaENDOTR4T2p2a0tlTmdTaTBJeGk0cDRxVXlqWmdXNjdrNldpTGhxWi9O?=
 =?utf-8?B?RTJsSzUzR0xIQkR2WWxUNXFxbkN2K3l3MHBUblN6Z3dyUTBiaXR6SThDUTh3?=
 =?utf-8?B?RnZjK3lNQWZsRGJWRUtjWmJNbDNEalR3NFgrbGk1ZkJlSlIyWkhmZjZidEY0?=
 =?utf-8?B?Wm9oeE5OMlFIZDA1azZqM21HRzlMVWNyNnl3YnJza2RYOHZMWm5sUmF5NUN1?=
 =?utf-8?B?TFFuMDIzTnRzVnBwbk9HYTRueWIxSGszOTdwTFUrdmc4YkR1M3AyTFFoajl0?=
 =?utf-8?B?QkE9PQ==?=
Content-ID: <08C704567AE77843BFE1263A15F36D28@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uVck7r58Ohv/GFbW5qShKZvCAAQD5TqAKxxjN4joK2cn/oNDrgxhFfee9fOBZzAUbQsVI5k9wg2wvpR8NsK/a5SPMC7Io+/IOpdNjqJit2+W/sQk6GvR5HdHnMZD7BdkziXcyOrB/qi/2jGUyYxF19Qt86QALOUDnLjgXODE4V0bS6WTl7RLh2vV/iSsVIfh4vOLqcTWf/ueAX6RWqzEfXsgKAaS6emvIGFwHlVORf3HQrN9pqBYB4HU636bX4FnaqJfDDUKjclm6ZUQm1nsfNvgFnCshn8K0OcGWYMH5reuzuTbLJs3c5kBL42e7DKE3GSoA/77XFbWBqPaMN2BAQaMLFmkCs8lW19FvzKqcu4VWuqUy8k3oHVufNeNdfriylxsjqqYDMGp/qZuBy8sqvxJ6u6X07vweHP7q1qkjQHbl9VdplIJZO3V9H1t5KmPj45ZftVOHOopKIqaFzuNZ2SyEJdwzzRfhTT2wQJ9B7R1uu8/IUtog3iq59M5/QowQplFAhqAJJW6YE4gk+yUkEIiP+/LVr83JAuLRGp+grPnoZTbvO457aQ66rqv8FkxYfokb5wKKTwKLOfSaWL2IYwxC+J3SJRelyDDjgGyznaeSCMyt+8rOKid2kwKR0xGZX09R2E9DlUp/O08p7+mjk2rEgBTfeN/Qk0eQ91CwGhhD1Bj32aISy6Lk8Ls8vzrlxVcpuL63s0DoG/q6dADXm/afd4rfOmvFY6rHU/1qtBsNpR9cQ5lwHFxZgWFXe7Qq+TuFfdC0fyVwDAHQvgDQA1Urp8Y3ph7HYZGpDAcseQUAXXR+NlWfNgHh/l6Vyg2UmYeOdUx2C4Dhs3oLO/kmGOgJKl/iZ6ZrVtzkJNnRNk=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c2c1fb-68ea-4850-9186-08da7f6d36a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 09:53:47.0689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEjU3Vi6+KYxf32LgT4LcbTLVqJjysQ8TO9Euyh6OaJpPbXTKFxahmJro2tf7L+4s2BirGs0vbw00jrCqA5lxnoQWv3sDGCBobVoOV+Z4FI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4579
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mount03: Convert to new API
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All

>> Hi!
>>> @Richie @Li @Metan: There are checkpatch.pl warnings. Yes, kernel folks does not
>>> like permission warnings. Do we want to follow? Or should we remove these from
>>> our checkpatch.pl fork (we use constants in many places)?
> 
>>> $ make check-mount03
>>> mount03.c:29: WARNING: Symbolic permissions 'S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH' are not preferred. Consider using octal permissions '0644'.
>>> mount03.c:30: WARNING: Symbolic permissions 'S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH' are not preferred. Consider using octal permissions '0511'.
>>> mount03.c:50: WARNING: static char array declaration should probably be static const char
>>> mount03.c:103: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
>>> mount03.c:114: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
>>> mount03.c:125: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
>>> mount03.c:181: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
>>> mount03.c:204: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
> 
>> To be honest I think Linus is right at this one, the single octal number
>> is way more readable than the bitwise or of four constants, so I would
>> be inclined to start following the kernel practice here.
> 
> Agree with the rule, numbers are indeed much readable and I'm for using it in
> LTP source.

Linux checkpatch.pl only think perms should use octal number, but not 
inlcude sticky bits, set-uid  bit setgid bit and file types[1].

Should we modify checkpatch.pl to print only three bit instead of four 
bits because setgid bit setuid bit sticky bit are stil keep symbolic names .

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc1&id=f90774e1fd2700de4a6e0d62866d34a26c544bd0

Best Regards
Yang Xu

> 
> My concern was different: aren't these constants part of POSIX? See man from
> <sys/stat.h> from 1997 [1]. There might be a test for these constants but
> it has much lower priority than tests for new kernel functionality and CVE.
> 
> Kind regards,
> Petr
> 
> [1] https://pubs.opengroup.org/onlinepubs/007908799/xsh/sysstat.h.html
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
