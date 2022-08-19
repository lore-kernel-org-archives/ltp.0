Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30377C25B0E
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 08:59:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB9183CA278
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:59:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BA833C6552
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 10:59:43 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 182E26007B9
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 10:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660899582; x=1692435582;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=M3wrhmjDWgMuIG9vjAlNlDd8LeMEw3qXkuM94eMdwqk=;
 b=jc8LaFjKjkT7X46sCuY9YRZ7TANVZLC41TCe9hZx0NgecJLKLcp/ueKP
 7FDl3yg9BiG8b2q8xtY+OCoAbwjcgeXdB3aMDDTsaMrHH8ah6GvD50BcK
 j27b7avsCgHdTsFT0safRWRDZdhlCLM33N0nSj8wS5w5EKGDpI1p5Ty57
 e4AzXO8GaK7fllcselZqch4KNesGEuBraFvUw9KWL/N1s3tu7UkwgWY7k
 b8xGe50wC1Go3Bf8eb/evhik05/7d61M6k/nKazqNFLnzQeFXwRjUrH0Y
 nJXiky18kygogqadbuth0+xiowGsd5Cmzjyf7VIdf9jJxZmstcpBKdNym Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="63169242"
X-IronPort-AV: E=Sophos;i="5.93,247,1654527600"; d="scan'208";a="63169242"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2022 17:59:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApPdl7sbT1YYgoGOBxaW4vRaqOAwhDl41lc5PCMWHME9vgF8XtbZAjc63hHNxP4NDV/j/NjswSaoffVy4gbZA0o3IDixWI4M+1rBnPFV6D8JVuoIV8t6ygbnRbWhq0bSE4E50AeaLJUfVZPVTAHVbx+RxIGH9ovWgCB62xlGerkx6wPatwrjKvJUGQn+P3bRgL/466uARGDIH5QHCbco4xBzbu9FzckTq3AxF8mh3FI7IAZ4q+/KAodCpvTGEs5GY5Fy+FDAqYiFj2XmmMYnG/YeBlv9t0LP+Gnjbk5lPoCJN5hcAS6CzG9GQhEQGW6t/YE+nztW8uP1/HyHyyXSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3wrhmjDWgMuIG9vjAlNlDd8LeMEw3qXkuM94eMdwqk=;
 b=IqJ3Yeqn8Fh5UN1VRayHhO1mXciVq0t9RcJ058JHq7Aw03u8T9yAyiIcVNn8zJxQvzomLpbBUQuQO8pbyB8t9viftky3nMONtbFVwGoOg2JmSXUuKMtlBJwmg96hSeTEKPAIBnTj7eZQ88KM4WiZiKf/EGknOe33Z9KyphHW7BTvgQROCy3CIf3N6bTfxqpfOgMqe5YOAYwSVnKwQp6hbLZp/A97EyNBrJBuj7Ihixn1qpdL/XfqMyucumwq5lZG4Fe51yKXTrDAzp2vCmvWrR+3ueKs3LhSiL/hlw2OytsFneNSz/XQsXfy2l9s//elQWx1wqie5K15N0nVAYLNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10061.jpnprd01.prod.outlook.com (2603:1096:400:1de::9)
 by OS0PR01MB6131.jpnprd01.prod.outlook.com (2603:1096:604:cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 08:59:37 +0000
Received: from TY3PR01MB10061.jpnprd01.prod.outlook.com
 ([fe80::7576:ee81:578c:780a]) by TY3PR01MB10061.jpnprd01.prod.outlook.com
 ([fe80::7576:ee81:578c:780a%4]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 08:59:36 +0000
From: "liaohj.jy@fujitsu.com" <liaohj.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/read05: Test read with zero count
Thread-Index: AQHYn/Spks5nzefyfEyzChs9bu3BGq2QauWAgCWpM4A=
Date: Fri, 19 Aug 2022 08:59:36 +0000
Message-ID: <4fcd916d-bb58-0b7a-2e2a-69b84f5ecdf7@fujitsu.com>
References: <1658732564-31728-1-git-send-email-liaohj.jy@fujitsu.com>
 <87czds41ub.fsf@suse.de>
In-Reply-To: <87czds41ub.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a378bb3-3d90-4fae-b2ed-08da81c12498
x-ms-traffictypediagnostic: OS0PR01MB6131:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjq5xImAeeyUDSp/I1f0gtEkwiDjmHeN4TBk9SBsvARwChz3Z0n8JfrGMRmM2rPB/gAs7V2tjm02ja2i59N3JawJb9G982bzGJqpaUi0KdVampdxvtBcZjwyJ1UmBY+2Fi/D78wg62Xe1z7Q6QwvDjjRfTIUyECCD5pKMMbuSKEcxesWnNq37nIQOQynnMmQwDXQ9++oKQ65PQHJm4dpAxcF1xOMfpXNlWAtqu+iMCE9qa2KqkkiN5kb5PZdYnmVxJjk9XKTZW0k+AWxhvkqx0kAejb5eXHxYQKKWl7O5amUjPUfBBl9IiE0yL/7Fjh5lIr37dpFyLj66jW9CaxELFa9I6gj89R9/k6sa2LQ8sTd0MBvjFkjWvNu19oJ0JkZNSwJZ7dCYn9XtRWgo2M8o6gU41pavGreycsnTCE/vhuOvlP+ri9/pj4i2lz7cwyuTJHA0LfihqzIM6e+a7vd4F3PBnUJ6pIQQ6dx26Hd5z66uQcBd+FgzgxZfRnMGQPDy8x3An6cYTmX4TOasmcndYh7AwEGzX0sQmXlBgVYsdqu4y+kLjG9b+89Cz6Jj0zSNrXgQIIDVP+MjWkAqMweIUOk7rwrWcPzUycK4HF3qUzdXeLbCYDJtTXAP25ydkriocLSdz8OJOOThmA+2VmaZfJdTLO+3grF/OaAWDoPNih1PfBGNM2X8UBVK/meuWaf3zcTAjnF77sC6oa04qv5uR23Zo9TtAa8xNqbRX2vcFZBBd0gikv9wzjJueqrMIjBby1llTzLiHAXZjQ07CazrPKS91KtlsJMZZZp51nBwqh8wF7tGQxywKcrZ8Bz0WuxtNM3uso2z2/0OSfeu+P1rA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB10061.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(8676002)(66556008)(64756008)(66446008)(4326008)(66946007)(2906002)(85182001)(316002)(6916009)(66476007)(36756003)(8936002)(5660300002)(6486002)(71200400001)(478600001)(41300700001)(6506007)(26005)(6512007)(122000001)(1580799003)(86362001)(31696002)(82960400001)(38070700005)(2616005)(83380400001)(76116006)(38100700002)(91956017)(31686004)(186003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW1WRWszRVhIYzdzOGZWUmNyWnB0UjJlNUlLUFlHY1F3Y0ZUdkVXTTNBQlBt?=
 =?utf-8?B?WlNjNzFpQ0RDdFNsSncrS1VoTTZLMmMrUjM1RDRjYzEwcUx2WnQwTHdiNFI5?=
 =?utf-8?B?WmFWbnN4NGp5dWtiZnhTL1N6cjRxN05GNlV6OFVRSGIrMldRNDY0ejQ3cVJ5?=
 =?utf-8?B?aXA0RHZQNm9oUWpDZVMySW1QeXdlUmhlV29XckcxYnJkR21MQUhwcStKVHFD?=
 =?utf-8?B?ZzZySWNmRGRmR1VhNjN2b3p3UEFIYmRiUm9jcUZybW1SdTRSZHB1SFk4S2tV?=
 =?utf-8?B?eXh4eDFkM3F1S29CeUt4emlRVHgvRmtnUHhKOTZxbTB5YTFDMlY1cHlqQnJs?=
 =?utf-8?B?YVZ2clN4aER3b0VLVWIzcDdTRkRMbmRxUktHN01zN1poNGg0Y2hMbTdRMXFU?=
 =?utf-8?B?UGN0cStveE1xSzQwNmhhck14bzloSmJlRGF1dnNGaEhlc081Mk1CMGJnV1cy?=
 =?utf-8?B?a0Q5djVFZWJiL1JEc0pHOFo0U1FxUVhneXBEc21qVUZxL1hMTlNwcFFWaXUz?=
 =?utf-8?B?MXdXZUxZdGE3bkt6bWkxUGtpTDNCWTl6WXdwZCtkay9wU1FrWG9Rb3Irdmlm?=
 =?utf-8?B?NnMwTHBXd3JRZ2JuK3BNWWVFVldORmJ4Q0gyNjkva2l4SDNQYWozUEhiaC80?=
 =?utf-8?B?anJzVitGSXd0T2FHYmtUZmIwVUtpWTVKZXltYUp3aStNMVlLZFdSbVBBQ1Q0?=
 =?utf-8?B?QlV0N3k5UjVzZVZ0emxTb3NPNXpUUmQ5NlpJMGlhZjBtSzZNLzRWNGVabjVx?=
 =?utf-8?B?UFBEa2Y1YnRBK0NzclBOS3dsQU9idk1MUVdFbFAyS3JkaXVnWXhwQVpnUjRI?=
 =?utf-8?B?WFI0emV6c25WWXBRUFZrYWxRTnFSSW9lS3V5OFcwaXFOWE1Ec0Y2MWIza0Zn?=
 =?utf-8?B?T253Wm1UNmdjTkQ3dlYzNGhGcWJhTkE2TWI1d0dRSmtNNnYwVVB0UmZoaWE0?=
 =?utf-8?B?SlRSQXpQeCtGd28zdHdZRWpYQjZTdTJxRFV2YkNnK2lMMzVKNHFQcHBuMm1i?=
 =?utf-8?B?L2tFL016WlBCNDJ2cnh3dE8zaXNSS3lGdDVrVzEzYzJoRlVRU2MxclgxZDhK?=
 =?utf-8?B?MXU0SHplalZuNWkxakZkclRyYStTU0w1dnFLSklOc0FMYVhrekdrS3I0UGJQ?=
 =?utf-8?B?S1lWY1RxdGp3cGpWVUsxQWswelBCZXBjMStEODRwaEN3UGsydERyQXlPVG4x?=
 =?utf-8?B?dDFsa1ZXR0dhV3dyTnNFRjk5OGxiLzFVUTNpQTZzQ1Z2b3lGcUdhY3N1VkZV?=
 =?utf-8?B?ekhDb1ZOSXBrK3diay9HemN3S3ltWmhXblpDYTZIMytMR0VsZWlPUkZWYmJl?=
 =?utf-8?B?M0ZHRStXd0R4UVk1WGJacWhiYU1MR1BkQ3NIcWRZK1pySGJvb3IxN2FBTzBq?=
 =?utf-8?B?RkFQT2pQTGE3K0RzYTFyQ1ptczc3eDhhR3J0TkNuNm5tMm9VSU9OM2QxSkhO?=
 =?utf-8?B?cld1Q1pCT2hLSUZjVmdVK005cGorZWdrY0lGRlNFVmNOZmI2ZUFrZkZyZkFv?=
 =?utf-8?B?WXpYOUdLdXMxRmE2YjBFZktOcGhLTG5qcUFZZ1BjOTczQy8xNGRER3dJTDZw?=
 =?utf-8?B?MmpmRnAvUTRxT01CdS8rU2NERUJ3OHZzbVp1akJsamxKdDdyMlFLaEUyTVdJ?=
 =?utf-8?B?RkVkc2cxQ3lFSDFjVTVKMEJYQmN4bU93OU43dXdsNytGMEt2SmlsMEdmMjRm?=
 =?utf-8?B?QUhLRHRvNk40YzVvZEJ3ZndiOFcxTWh4NElQbWxtSmFkcEpoaTJkaVJwS284?=
 =?utf-8?B?eXZlNElsV3ExR3VVUDZmcEZSZWsxSFlza2tmNG5RQmVXWEZWMER1cDVYNTFt?=
 =?utf-8?B?bE9mV3c0a2NjbXMxU2JENUh2VUJFRGpYeGFTUC9LZytyYXBxM2hCaXNVMjhl?=
 =?utf-8?B?QVY1SWNSc2tML2cyWS9JbmZMWkxEcU9lQ3puS3BndlZZaWlmYXQ4VzZsdWJW?=
 =?utf-8?B?cFhWYU5IaVJqdjZWdjhjWlZvZUJEU2pHd2RuUWhtdjRNaGQ1bm9MZzBOSXJL?=
 =?utf-8?B?U3BVM3pXeFJ3bk42UVVmclV3ZkcrbU5XUENSMWNEZFBtMlUzMmcxSVM5bG92?=
 =?utf-8?B?KzFUa3dWMlNXRkM0ZTRoWm90eGFBQlpZNDlKak5CMHRGcEN1SDE1R2NHdkhz?=
 =?utf-8?B?cm9nc1hlUExzb21VeVU2WktCNUlWOXBGUUdjZWZKR3pDWjY4alY3ZHdMZGl2?=
 =?utf-8?B?c3c9PQ==?=
Content-ID: <9E5CA48CF252ED478C303464DD7A3E1B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kQkNBfohCEV51bk6TzlV7eQXZFtJJq9psBvI70IGWt+13mBjeJ+iYilRHrT7ocbWwQYekELsUtSXxRdU6OONO2P8rQqie6fY2t8gITE7puHKb9z8AsXzYnTS+ZfB0DxVBqsDB3tybn4Nsp/3X01x3lkqufl0pvOsXygiA511e3niMPs8Ey0u4DUHYxcuHmXIFo9hiFZxNLD4q0uj+8/4o7nB5yJnltQjWcuhzrmCS9yXW9i50gW46UkIxgubbOU4FwN4BQM/VgxfvqATnUsDzxW5BpfM5PyEvMSLZvW1eZ9KN34rFBJRCz0/riLuFdURaCTBqqJDFQtkdT802wro/lG8z7PrEFtxTahpSrq4nyR/6vAXnNeJ2QzA60vP3cJOsSiV40QAowvOiareUEPJNfnomIlIKkc6I75g0LmZBnsAk+L/VvkcJtSyoUcXMu5K8IV3KW1iT3jm50C3a1Wv9k2Xv0z6PumwKJPPUq9eFp5cfTAqqTzDTBuTkIvvLwQoPr8nkwpL7aleJ9lAVIX8Iqq0ilm/Elc8Bif/oDxta3mbFdt418+C8XImixizptQzHfgmMesYUhY1ZJyBMsk/21TjZwJ4HPtuEGk9e9xL2EMPZB4QGoElVSKLJv+umDXPYJSayXDpE7Ueuvh/6OC6+OUU9l9mt6xJnznaAGkYBiI86rCIatauBtCsUdfC83JpF4n3r0DpSladImPUyVl7T7vkw0XEXa0DziEwYYZwvQJM4V5Jp161n2L8Z9Xv35vvc4KxlUao9i5tx0rpvY/ZPg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10061.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a378bb3-3d90-4fae-b2ed-08da81c12498
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 08:59:36.8379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YU309G1xkbB8OKfwdg+ew4J7/BBMw7TWwVTyRPcsibtzqG/Lqi7hHw7n+cvAZoHF220MK8Au6rZ+iCuD9YB7rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6131
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/read05: Test read with zero count
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

Hi Richard


> Hello,
> 
> Liao Huangjie <liaohj.jy@fujitsu.com> writes:
> 
>> From: Huangjie Liao <liaohj.jy@fujitsu.com>
>>
>> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
>> ---
>>   runtest/syscalls                          |  1 +
>>   testcases/kernel/syscalls/read/.gitignore |  1 +
>>   testcases/kernel/syscalls/read/read05.c   | 44 +++++++++++++++++++++++++++++++
>>   3 files changed, 46 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/read/read05.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 3847e8a..0bd47fc 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1094,6 +1094,7 @@ read01 read01
>>   read02 read02
>>   read03 read03
>>   read04 read04
>> +read05 read05
>>   
>>   readahead01 readahead01
>>   readahead02 readahead02
>> diff --git a/testcases/kernel/syscalls/read/.gitignore b/testcases/kernel/syscalls/read/.gitignore
>> index e89c008..69d97b3 100644
>> --- a/testcases/kernel/syscalls/read/.gitignore
>> +++ b/testcases/kernel/syscalls/read/.gitignore
>> @@ -2,3 +2,4 @@
>>   /read02
>>   /read03
>>   /read04
>> +/read05
>> diff --git a/testcases/kernel/syscalls/read/read05.c b/testcases/kernel/syscalls/read/read05.c
>> new file mode 100644
>> index 0000000..83ac763
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/read/read05.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 FUJITSU LIMITED. All Rights Reserved.
>> + * Author: Huangjie Liao <liaohj.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * In the absence of any errors, a read() with a count of 0 returns
>>   zero.
> 
> This test is quite similar to read04. You could modify that test to read
> multiple times from 0 bytes to the total number of bytes available.
OK
> 
>> + */
>> +
>> +#include <errno.h>
>> +#include "tst_test.h"
>> +
>> +#define SIZE 512
> 
> This could be set to 2*getpagesize() at runtime. Then you can try
> reading every length between 0 and 2*getpagesize().

Then we can increase 2kb length every time, ie  0 2k 4k 6k 8kb.

But I have a question that used which patten to fill the 8KB space.

Maybe write  "A" in the [0-4k] and "B" in the [4-8k]. Or use "A" to
fill the whole 8k space?

> 
> Errors tend to be made on page boundaries and similar.
> 
>> +
>> +static int fd;
>> +static char buf[SIZE];
>> +
>> +static void verify_read(void)
>> +{
>> +	TST_EXP_VAL(read(fd, buf, 0), 0);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	memset(buf, '*', SIZE);
>> +	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
>> +	SAFE_WRITE(1, fd, buf, SIZE);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (fd > 0)
>> +		SAFE_CLOSE(fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = verify_read,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_tmpdir = 1,
> 
> It would increase test coverage greatly to run this on all filesystems
> (i.e. set .all_filesystems = 1). For an example see rename10.

Yes.

Best Regards
> 
>> +};
>> -- 
>> 1.8.3.1
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
