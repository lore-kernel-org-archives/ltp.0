Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD8C7618E
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 01:52:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D93E3CDA4D
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 03:52:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED01E3CA1D6
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 03:52:34 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BDC1D1A0093D
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 03:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682560353; x=1714096353;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DKdlXh+O4AjJYbM/hl+qNHnt9OkHu1FGIhhL3/jZIzQ=;
 b=UGoAKG8lSUQIehP9F81Jm+BePDosOpP/bD54lPvSbX6DxVxvLVh64dhi
 jwmHj2U8WDzcofmVpiMmSb52CY6Pq8Ez5OgV7dgzEkLi7G2/HKDm32/SN
 KilYqcNCaSSpioSx0evt1TNDUuRdDNtml/qE75lII1z9ob7/PtjHI/Pn8
 cg9c2Z7xgN2GwByk2ax2E+jcJugVPcknZ4GaYZlFi5XARYnyZEQ/fFC7j
 ZL1o2+YtSYFulQolONzVntVUuyWGkVXeGTJcBa49m8RhnmZU+t7samZYJ
 /MN+986apnApKF9/0EjR07V42H4N9XOqQ39ZPCeXjUmOhFpropJOe89qv A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="83002699"
X-IronPort-AV: E=Sophos;i="5.99,229,1677510000"; d="scan'208";a="83002699"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2023 10:52:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8/CB4Oobk4w5E14/RpkAXBhSbiclRF6o33FPhpmMRBpKPQAR4q61dng9dFrNsNxy/oDgrU4WnihnDR4LCprJMFOGxWWWnIOkuHWbHEIBNMoJFmP/Ne/lSuEL12o9eUnrWYJyKcTlWy1lkba8o3OgsBHhZuIOaEId/MHyoDkqDa5d5xWbIt8wG+qBq72m6bj/571zwZwKJXLW1dwXiPyTmsXWa8WD7bjWejfVNABSfDWKwnR5GAK26vqLkhU9M57pf/aKoapYFAlRMgNQqBaPT3tLOj2eeo5iuYUUVfyz9Ws6CXq2aCcEoEq9Sjj8eZ99t8ZALf8RUwHLda7uaNrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKdlXh+O4AjJYbM/hl+qNHnt9OkHu1FGIhhL3/jZIzQ=;
 b=RoJqTtenrY/4qzQP1aBOTHlorCU6oGu3U5v01hezX3gvUMe9jgiOa2+HG6Og0BRsTeThtQojJZ0gI0giKFXXsViIPoNaknrLuqqZPV17OuuC3oUT95c4oP1TIOdMeef7eRu4mt5GpXtvMopewdThMx8GVpnh8+jm0N7cmnZChS8x1QB656kIlsKPL40zZm+s8jPK+dIOoKqHitOYxSMVEApMku6bTtuaVd3hyXcU4bC+uecrg+tBq5RUaMpCU7EostchD7VjwtqnDltcSOkHqIS9k+N9oJtZpzFRHTvj2nHpgKirR0w3ILb4ppYQ466nYKaDwx+xJGs73zh4jXBjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TY3PR01MB11242.jpnprd01.prod.outlook.com (2603:1096:400:36f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 01:52:27 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 01:52:27 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v4 4/4] lapi/stat.h: Remove deprecated STATX_ALL macro
Thread-Index: AQHZaEpv03ZjnieVs0WT8eeZpzZUZq8+Q3KAgABBzgA=
Date: Thu, 27 Apr 2023 01:52:27 +0000
Message-ID: <81df268c-7255-c251-e174-b54fc65037fb@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426215655.GC58528@sol.localdomain>
In-Reply-To: <20230426215655.GC58528@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TY3PR01MB11242:EE_
x-ms-office365-filtering-correlation-id: bbef7580-4aea-4fab-9cc7-08db46c20dd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvCyLdIneUrfp5s2y9uoIGQXX/MJighzMh5LZLNHkW6Tjp6xyOzpCRpMOi7yz4Bb6edTqsVxHY2EbQNmQ4it4U+yvsxTpfmf7PsfFYeKmkAwBMSWiH8Sifz9u4cCd2yY/uwVS6MjWjoMR+ppCRKPpDpEp/dJM2coK7lBAoFvDDhTpJYURjnprOY9nk79uJv7H+oeOn0CT1oHvOLN6/MbIFOC+TmdN5ZPYEg3r3RcjYkQUA2n20A+jYbXL3TbGADTZfAXgUq+pdfLE18FpMvGfCKm0Sj+a8rScSBY59FtZH63Bsp1dInQgQw0jC7+VI6NU1Cp6XjSj6R4wk2vQ7i4WzMJji3+8Ve5yOeZUOrc78primQquL3ToldPqkmQ2lIhZgNecq/tN0zZkoX8EWza7S+TmWe9eM8yst8M+bAfD2lPSa7sV2NmI2QYd4wTxycmJRXAuSVV5qj5mZd+hJLJSXiqx+oQtKxWNUMK6GGb44DxBvZSwzjASERYRD1vurlq7mptPj5DosCQ5NRNMRHB+ta7O32+ge5qXIAdGPvBEUYbDF2Dimezb/s6EZUPkcgGOGy2UZyS53LFQhY733CHWS7TZDEnLIHi8AbzAWL1c6ohji/pbSFOMT1PkTU6ECbvyeRERcjxRn6V0vEMmHywE0Gl3xQctyBCEb+wOPQ24DumUfqcABdxPuGdE4XKxWCN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(1590799018)(451199021)(1580799015)(86362001)(76116006)(91956017)(186003)(71200400001)(478600001)(85182001)(6506007)(26005)(6512007)(6486002)(36756003)(122000001)(8676002)(8936002)(38100700002)(41300700001)(2616005)(38070700005)(31686004)(2906002)(5660300002)(4326008)(6916009)(31696002)(316002)(66556008)(82960400001)(66446008)(66946007)(64756008)(66476007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?allndEUyMy81UU1Mc3hKWmtscHNqMGJ3YnJCL1lEQ08rY1EvMmtEK0tGZ2tP?=
 =?utf-8?B?MlN3VWhkT25UWFdFcUdlcmtva1ZoenV1ZGRUeGZEZnpxa1JLbk9CK0JrbG93?=
 =?utf-8?B?TVRQOVlrMGlFMmpIYWtNa0k3Y00zT096bFMwUmljMEJ6bjVGc2JGSDVvVWtO?=
 =?utf-8?B?NEZMQ21rK1JESjVKbUdGWjM1UE1ITTBpcWJ4UzRDM0xxa1ZPdUplbnlRRGEz?=
 =?utf-8?B?Smhac3N3N2w2SWRBc1Q0Qks5cGgxQkFzS3ZUUjJJc0pab3JicEJQMVROb3ZY?=
 =?utf-8?B?Yzg2bm5ic2I2NnNQaytwaXRWSTV4bTNFZkE1bjVESVgvMkVYckdBa3lMOHBG?=
 =?utf-8?B?aW44eFpSbnBiM0hzWm1NYlRVL1JVSGRRU2p4L0VIdDFxcEFpVmVuSTVSdG5m?=
 =?utf-8?B?OUQwdkYzVjFkK25jNEE3WEZwVi9mWUMra2hkSDB6aStadno0cnp6TjRmaEdN?=
 =?utf-8?B?OFdTODVRbFpYUmh5WGFLcXBxVnNmOTNNTkxWUTVGVnZpTGNyRzhacllja1l2?=
 =?utf-8?B?bDRIbzhzUUNiQk1FMWdPbU5vL28yT3JUQVJIaTZQbjFNWTNtd3E2M29UQkcw?=
 =?utf-8?B?K2xPczJaWlZQdjJ6ZWR3RDN2VUlJUDEvaW4wdVlFWkM2eXB6ZCtMVkNWK1Z6?=
 =?utf-8?B?WVlWNnRTTW43cGZDSEhxWWpleE5ZS2YzNENPd0hwdEEzNndodFFHRi9Oenlu?=
 =?utf-8?B?Um1nZVBqYnppNWRSeUhGODNidi8wTDR5SHVVK2Z5blErLzhjYnV4blNOYWxV?=
 =?utf-8?B?dzVENFErTFh2b2ErT2Zvekp4ZG43aTVmeWgrbFk4WXVHR3JQSXluOHZsM1Yw?=
 =?utf-8?B?VGY2WlE3c3NON0RGQ3hJT1I1QTN1cm5OejRWRUZyQ1RxS3VYWDFmb0oycmpX?=
 =?utf-8?B?ZXJ4TTk1ZjJWZTQ2V2dlZGVFT0oxK05rQThzL3VQdE5VczhkdmVuVVJDeUo5?=
 =?utf-8?B?SUsxa2trd1c3VzJhUlJBSTZ6bnpOQ0E5OWdEaG9rWHNjNWJmcmZ4cENzUVJO?=
 =?utf-8?B?VlNjV2hGTUVFUDMvNUNXQzV6VkVNL0JrdGcyZEVZWjhIQnNLN0dheWJrUDNl?=
 =?utf-8?B?Y1ZPTHN6SjBsc0luZWwvaHRFaENYRlJ2Qi9XdjI5YVFGbFV5VE5rU2hMQzNM?=
 =?utf-8?B?cC8xZTNTaEo5d0tkQjY5em9xZ0U4K1ZXMGppWjh6SEMwOW9JN1U0QkhBV2JK?=
 =?utf-8?B?bnFKeGx1bnlyRWJMTjRXUlR1Y2xINENBdnZ2L2EycUljenlleGFmNlJiamdx?=
 =?utf-8?B?aGtqNWQ4bm9aZGhaRGxST0VQdDJvU3pKN3BoT0NKbldmSGtwUUVkL1B1ZlRP?=
 =?utf-8?B?UjlEUmpKQWFGR1ZXczVobzNndHhtMVNKOFNSNEJnV2VucUVsa2dTcU1ubkxO?=
 =?utf-8?B?bjgzREhHclYvWis0ckVyRFdzZE5QU1c2UTVNR0t4T1VScVpiUHN4VnZ6bEFZ?=
 =?utf-8?B?Z2h1REZ1dSs2RGpjYU42UG1ISC9PTWdIaWl5K00yRXBiSjlmd3QzSWRIWm43?=
 =?utf-8?B?eWhyTU1jUW1zMzR5eGtORndtU3dnWENad3FqL1M4aWMwSlZxVGppdEJDSngy?=
 =?utf-8?B?RjNGN0hEUFpuSGp4VzFKWG93aE1xUk5YVlJSYWw3V3E5dTduTGFBS1dIa2VI?=
 =?utf-8?B?aW10MXBhNVUwZEtUdmI0dkl5NzdsVlNxVFhpV21PQkhDeHorQXJ1MmgrQVRG?=
 =?utf-8?B?M0JNUEwrRUtaaERBMHhINmxMV3pPSTNWZFQ1NlNobHRva1lEbjNDZEk1aUN4?=
 =?utf-8?B?STZIR0h4WTllNktFOGNCWWlyempkMjNWMy9mUWxPdFpmdmVBTUUzak1Pbmlu?=
 =?utf-8?B?MHJkSEtSLzk0aCtxRm1kUnVDTzJXUkxTZW1MYi9rZldoVzA3cERJRVRyM0o1?=
 =?utf-8?B?bnMrbnNLTUhaQ1JLeFdjU2d4alJ3YjVPZEdpM2FsNnJKNjBZQnd1eEJzdDlo?=
 =?utf-8?B?dnIrQ2tSZVJQa1Q0TWprVVk2UlhXZXJVcGpqWmdiK2NzaUwyQWhnWklrNlFL?=
 =?utf-8?B?TFc1UEowU3dpS29wY1JBdUJSU0FHOUZsU0V5NnA3MFNWQ0t4YTFFYUlxSjlr?=
 =?utf-8?B?NHhva0lHTzRnK2x0SUFFL2dheXdoVloxTDZkN1d1S3VFc0kxeTVUL1BSbG1Y?=
 =?utf-8?B?bksyRzlSS1BxL0x3bmxWVlU5VTRDRXhMOU16dHVGRzJybmI0aXFkSXZ3dWh5?=
 =?utf-8?B?SUE9PQ==?=
Content-ID: <7ECD6282DADD2C44A16E6968815F29A7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z7KeAvMZBEvV48M14U74kqaNtyYcTtsMUci9gzmd5UEN8VmLU2Er5GuF7CP7S4l7IM0TRQ8OcwPwMWv6OZtInVyQf/FDeNojGyqaoFj4DB7smD08I6+LiOxx1YeezgXpgKov7njX3Y5e+AIFAoJiMtPMdrZMe/NT0mj3Zqph9/vPfraRgyV+znZ05e5uJ9+d/x0yZ2q1sQmzpualuolXb6fsKqsftSb8j1b2/FH+qhqiBu0CQMu6EEAyz6ID10J5nnaXEL9xdG3X4BzcwfG+pWJr2wlbTXROuu6tnokXT7J3c4HvM4nzSMCaGvxVxgjSZJQA5D+EpWvvlfN1S6Zb4pIjRkYmdNsf8aEL7e9NsK3blTgIE1STTCcWfZK9+gp8QcIXxMtdwFshfzUgQvBtlauPulcnYH8xxqWm+gdGZF+m5uLu5zCBVPa5T3jHXqtkCAhQSc0c3dKCsyHebjfeNAb8C3U0RFJrUkiInzN/8tLZHZsTYFjyMBvH0AoFfGxaIfWhHBLpd9jB2gq6d5DUVxaYA7RG5hf2mnPiUhNEdkeGI6GqHLMYcJDKxTG6Ymi1oKomxI8yCASbHLAQj9T6rRaIADL8F7KU1pfhGDmSlQ7gGXK/I1bSjS7brdcWAjWCg7W+FmuobDzdy5cEMuEhAJ6I39nbWa5nrf0P1zUHkGv4zIqeF0NoME8UBpDUB/Fuqv6CmynwiTTJquFFklVigPyQd2iko8L16DCr+A5gYeDhzS8+T2FJGhYLaXhnZvn4NGF4kxMEJ1sI3BR6cCfE86fdwOzWxLqxYHtMo/TvKJs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbef7580-4aea-4fab-9cc7-08db46c20dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 01:52:27.1886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+fd2CuWNZ1bskf8n6pTodt7z5hRRt/CK2x3QxUk53klZzr9wnxZp8NQwUHu2+TiGRyovAWJAqXAPDpQY7rrEaEDC2vT5pjqMclx5rgUYao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11242
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] lapi/stat.h: Remove deprecated STATX_ALL
 macro
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



on 2023/04/27 5:56, Eric Biggers wrote:
> On Thu, Apr 06, 2023 at 01:40:22PM +0800, Yang Xu wrote:
>> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
>> index b13c11f72..c798c7a10 100644
>> --- a/testcases/kernel/syscalls/statx/statx07.c
>> +++ b/testcases/kernel/syscalls/statx/statx07.c
>> @@ -62,15 +62,15 @@ static int get_mode(char *file_name, int flag_type, char *flag_name)
>>   {
>>   	struct statx buf;
>>   
>> -	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buf));
>> +	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_BASIC_STATS | STATX_BTIME, &buf));
>>   
>>   	if (TST_RET == -1) {
>>   		tst_brk(TFAIL | TST_ERR,
>> -			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buf)",
>> +			"statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS | STATX_BTIME, &buf)",
>>   			file_name, flag_name);
>>   	}
>>   
>> -	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buf) = %o",
>> +	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS | STATX_BTIME, &buf) = %o",
>>   		file_name, flag_name, buf.stx_mode);
>>   
>>   	return buf.stx_mode;
> 
> Looks like this place just wants STATX_BASIC_STATS.

Yes, I will only use STATX_BASIC_STATS for statx07.c

Best Regards
Yang Xu
> 
> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
