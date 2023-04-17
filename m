Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F24EC77B61
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 02:39:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94223CC27C
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 04:39:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77BC83C9959
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 04:39:21 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1DFF71400350
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 04:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1681699161; x=1713235161;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=V81svFVWD8DOU/iR54V3N/01fDHXipgRS9VOevWZ+D4=;
 b=iwQ3Z82xiWM29Pmj9KwnOg8cjQlc1f85if4IMfs3nCoDuV2xBA/CHYgM
 pK3Y/qLeDOpt884ELBIfkNOf1zj4rIP64f43DBHmxEVrMfOn7pK2ZVVnp
 6uanszzAsuoUjHO93JfnPW9jRwOMsfVz88Gy9owbN7rwjtPuBhyKr5zpK
 tlNbZO+aTR6jnKW658ovhCZNeBy3H+GHDfdVySUdm5JvZxBfFhbYW0Dh9
 CDtgrHVB4aF+kRTQqesgBI1oSXH61JyrIx47X++fH1jOXndZAdr0DoQM1
 HVKHdfjUXlXgicHEdiw/A2mzUEQUjp7xDGhE8CYwVHdg96tZBb+UzYZ7e A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="82350703"
X-IronPort-AV: E=Sophos;i="5.99,203,1677510000"; d="scan'208";a="82350703"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2023 11:39:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy9aKSDlUbrnRhJ010NNRkq20Fon2tIHgQvRWRG9UvXOpIViYYmAXgYZKscs9wCm6gt7DL9cJlV0iI1MuyVU8dRWVDFOUj9aTYL0cOQgZ4YRxplN19bPH2hm8UjQpVEJsHrQOPdhyqplLS9yhnbINFuhljR3v55KyABasH0em7PYCkHbz8xo8fSlV9JJ+yx5O3YwIlRlsYLOzF+ZVzP0OOIXQhw6q/4lhULQ5s0W86qYmnkeZxxbQGcwbq/YVuA39CNZf9VJ+zywOOQW6w9S89u2o63ftZAECIXoEjteOHMy6C+Z96eabOBjU2agFY/W9x85d8rBwBx50tGCQfj50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V81svFVWD8DOU/iR54V3N/01fDHXipgRS9VOevWZ+D4=;
 b=Cc4H6aHqXZZ9QvR9QmQeu6BxquU2PYpWSEdyZ69mGi14AjIR51FIt00Kvt00pPqGXFGdFsQ4ifpso94Z93b1IvH6+F64x5Qf4JZlqnwquYW5kVGD0KWCoQjDMishH7gQpcVqXfqlcAbycjxA8kXf75r9lHIREKtSOS54U/G9EbAsY0vVUuMtUQRdKFDK2JIuXV9c3ShdCzlOhdJymb+YLFyqBQEM/FRCUGkQLJDldhEs5QicNoQBnoFtkmQ9ROMO4RQhcc0s59FJzUDNvzvBP7vx54aQkF1DJMpag3XEZMw3Zcz08eGiQOB6MDFHQI5PjjIg2xtYMqm2lBowalq8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYTPR01MB11090.jpnprd01.prod.outlook.com (2603:1096:400:39a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 02:39:15 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 02:39:15 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 4/4] ipc/semget05: Convert into new api
Thread-Index: AQHZWvWcTmNnUGgH/0O8zGM0wwd/Sq8pI8MAgAFJRICABIikgA==
Date: Mon, 17 Apr 2023 02:39:14 +0000
Message-ID: <9ff1f71c-9f21-e7ad-bfb7-c552306892d1@fujitsu.com>
References: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1679293822-19378-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eTxhuQ+5YGMVbQwf9ZY1ttOHZxCySux-s0sDjXvhC4zw@mail.gmail.com>
 <c35fc5da-d420-7cb2-88a9-6327b46ed738@fujitsu.com>
In-Reply-To: <c35fc5da-d420-7cb2-88a9-6327b46ed738@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYTPR01MB11090:EE_
x-ms-office365-filtering-correlation-id: c26ba7cd-a70b-4c89-17fb-08db3eecef3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G/OsUL95nhKRlt0I8hSJUliH0Qrl6q2sl++wNLv6sKSB/hCNbrHIwkxVMxQ4bAjBWZy3kWIBO87Vtf5jQqU/4X3JIA9gYVXu0dCx0OU/cDtePm+7Tek1wy+aT2qpmxrlCPMi4qsR7DD2/4unAvh3KvC1hBTdeeuChXm1UdDnebVllEYIit++jQH2irVTgGHkiR0McNs1LMc8E0q1i5UIojazVNJFJIoqaPA3jydgI0is0xLgvCD4qSBRA9aEiErNawJZqGLcthrO/y4w7T+RqL6cQkNEacPNMsIHX5JQ5bORn6rOOM2urm+Wps211nuK5CJedVm+ZajW9rULtnCtZ+mLdSr87yg7v7QbLLeuTlYQ+9uOuQJICaaDssjeZYxdTxfJuYQWVtnuni4G7ad+nftEhBpukg6CC62BsK3l7etts7c7CO12uTUrEe3lDnmYyXJ4vXm+7W9pSds6ZvWWDJz+SMm+xjAuvNZXmapLoS9wVS38tzvKVUTY5BqxdRP+GApwCAa6OH3/ShkOUE/pYSWpxFv/3uIaNBO23a5WkUQBHyVOiquXLjiByOVnaWKki5jKk3LHowYINHpjUcMSFp9Engrk++oj9H9uqCh5mR6x57xr9ZR03qmzdkagx1hM2HoEvUy+S6kkN52a8i1ebRzHMn7jYDuibPaEZyCuoeg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(84040400005)(1590799018)(451199021)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(4744005)(1580799015)(31686004)(2616005)(5660300002)(86362001)(8936002)(85182001)(316002)(41300700001)(76116006)(36756003)(91956017)(478600001)(71200400001)(6486002)(186003)(82960400001)(122000001)(26005)(6506007)(6512007)(31696002)(966005)(83380400001)(38070700005)(8676002)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDBpay96dkRZcit2TnZHVkMvbzJGeHFWTlE3TmpWMjlQU2NiVmVOTkk3L2ha?=
 =?utf-8?B?M1RhZjY2MVRuNGNTR1RyYlh2VkxMbzcxL2lBWEFJYjdPdUd6cys1Y0VDUUQw?=
 =?utf-8?B?YURRSzN3cHlDWTdEZVpuQjAraU1pMmhYVkVzWFZqLzJ5d0ZIcjFXTGNmdkRS?=
 =?utf-8?B?cS9JdGdaRVBIeWJCMy9vdTNnSk5IUWtqMERzclJMQ3BQdXF5ZU5hK3RrWWhv?=
 =?utf-8?B?NTVXUjlKSHhxM2ExYURIVVkvMnNVZFBqZ0l0Ly84Nkg1SzBPWVZ5VS9FUUNI?=
 =?utf-8?B?Z0JGSmV5NmZuWko3MTVnOENnRFZtYW0xdndOcUM4eHEyd0VNTnlkZVVkWTFu?=
 =?utf-8?B?RDRmbUVFSWI0Q1NKRnZYN3NrWHVoZC9IRHNza1VKTnVyb0NCOWVpVUovUjFa?=
 =?utf-8?B?YUFpMXgzR0R5WlZOZXYwTFRWSTBsVi9XbXU3NStwb1VROWt2MzNZYjA3My9J?=
 =?utf-8?B?RGJRVWZwbDk1VExJZWpUZk5Kb1M0cmJ0WUJWMWpNcVVDOG45cXROSU9ubHVa?=
 =?utf-8?B?SVJ5cWhnd2RmSGRvV3NHZEt4dFdEZUtvcHpIc1BLYVZnYjRGRm9VdXdIQlNU?=
 =?utf-8?B?Zkx2NnlLTFdlcmNOTEhQZGpJU05qMDdIc2JFY2FWSGJUZG5FcndGVjI0ME1q?=
 =?utf-8?B?N2laYW1NS3J4OVpuL0YwVkFhL2QzN01QUm5MclhtNXlOekZHb1dSQmtsZUFa?=
 =?utf-8?B?WExPcUdQNXJtUWVjYjB4Z0krL09rYjgwRC8rYWFvZnkzbnRMNWRFQVRmMTFi?=
 =?utf-8?B?bmkzQWRDZ3NTais5Z2RITFhnN2p5UU95YkJuemMyeUlTeXM5aU80VGVXcGtS?=
 =?utf-8?B?UjJQNU82bEhGOUYvNWllaTduS1BaSysxZWVXNGhZVDM0VCsxdFBWQ2w1SW9r?=
 =?utf-8?B?aGpFT2haM0NVNEJ5WkNmbDBvOGo2VG1GTmJ1V0xGc0FRY0tXSFNmR2JxS3ZF?=
 =?utf-8?B?MXJsY3RUdGZMOVRhcWpSdElBQmV2V2FJdHFqVmdxSU40VUl1bm9oSFR2NVl5?=
 =?utf-8?B?RmR6S0FHYWJRUWpJZFlIWldjbFhHaWE5eEVyZUpCTkhWUUtkSkV1aE45MmlD?=
 =?utf-8?B?TC9QWnVkRTFWejRwMk5CRkRJVFRhVWhhQVlQUzlHQnJzczlBSkZvSUcvbmlr?=
 =?utf-8?B?Nll5Ti9oQ28wa0JJNGZ6NEI5dUFPSkF5TXdkYXZWR2NHdHhBOTdkekgvdkdG?=
 =?utf-8?B?VFRyU09laFFZWVc1OTBobUJkTUJNVHk1UnlrMTQwN2pmMUNmbzM2aW9WSEh6?=
 =?utf-8?B?ZGtRb01EWVNzK3hjMDVMenpKdUNGSU5yYTNzaHVkT0dEZnZZOEdrVVhaeVQy?=
 =?utf-8?B?ZDJhSzdaT3Q2MUhydEVsZTlXL1NZVnZkZVFiVEFTWmtTYytwZWtOTFAwalFr?=
 =?utf-8?B?dkplK1dGOUtGcXU1RmM1dUZnc1pDZlNOc1JsTDBPUm54RWNPY0ZWazVCQnRw?=
 =?utf-8?B?S20rR0NHc2pFdHExcEVLZGxKVkJQODFMVlJLem5TQ1FCdXRMeTR0RG9EQUZU?=
 =?utf-8?B?emp2a3ZVejRndVl0d2FFOVA1L2VVRzFsYll5NHRDa2Zpc082anF0ZGpFTk1n?=
 =?utf-8?B?aFZOaGxZUUdHVjM0VEZMR2dYQ3FvUTVrbHlhTytoaXZxN0Fkd0pmNGxZRm1i?=
 =?utf-8?B?VEZTcnFRdkNZZnI0MnNtZ25RM2gxb3BENlM1Uk80L1pDcU8xSHdUeUVSUHU4?=
 =?utf-8?B?eWNObGRLV3BVRWFCT2VvRnJWVHJRT2JaYUV0d2RPMDV5d2JOelRZdXcyUjZj?=
 =?utf-8?B?SnVGeDAxc2NVSkZXb2RZNGJ3N3JRWjNaMWRneVpxazkzeTkrSGkrODQ3VmR5?=
 =?utf-8?B?RjRGMTRlWnJJSmJrUzhTTkZSK3VlU0VtU2pLWWhUOGpyQVljV1JuajVJZUxL?=
 =?utf-8?B?UEZZaDJwZTdmOW9PWjJ4WjhmUWhyN0pjR09YM3d4c0JDVG9EdGNnM1JMalVp?=
 =?utf-8?B?Y0hFQ1YzU2Y5eW9HbzRFOXhCMllmMlJVS25qMWdaWlhQQ0xjdnZOdlhMNUsr?=
 =?utf-8?B?Q3NFVGx1MWNad3Y4Y1hoVDlkckJPbTA0N2R1RFhOai8ydnlpbzlBTVhvOWtL?=
 =?utf-8?B?UkVBUWVBczZNbVhJbWROL1V0Tkw0RS9ZcjJPQ2ZkYUIxRyttd29XWStoRnVJ?=
 =?utf-8?B?Z00vYkVycENnMEphQ0NLOVh0ckNoaXhYRTNJMFB5K0hVcnB6WTZqT3NzNkYw?=
 =?utf-8?B?c1E9PQ==?=
Content-ID: <A6A8452F9CAC914F9D52B7E15548457A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 689xIIySI45hOMjfMUAALYxMyDW1YM15vD1zV0cN29nnOTomiIEcEvsSTM+X56bc+jaB1tONCf1LJc3kMEwCrz2LKImTH5flyDMvegH5LpWwDqWCk+R8NBCE3U7bX8ymmYXjWsxZRzBeMOe/3OxiZiZ+cZF6CpaKmHcV11IXk4bDKEkYDuaPKhx6ZU/I7PDRGEKK6c4Kc+fHzPQiNoqWvEaH5Lkl5H8rMDIb4+I2FpXqkkY7NLE/SPQIBL8w+Ku2O3puSDeYoRjdUsnkMTWrEHYwyyBtqdY8kiy2AZRis4OZBquUVRTaPtNgLxhcbq2Gu7F30/Qd38OL4DeAxeXkThRTPpWNKbP2e9mGwAW8u7yasgZ8Ufke4zOrXbYf4LEvnpzcjmcBDRlg8OI9WUFWpw8bK0YVB0sL/YoLigI9nJT7D1uxcAPZXfo2GKowP/dJ3FYXtP5RQGIOMl2+wQjY6Xg4GExv76gAF+MdAalaPBA6gOMLoIHsiJ3yD4PZGIaBjp0iQn+etRahyQiqUo+bLXBtlcI8Mr4FHZlgd83PGMYNknM2yPirhVVs2u44wTlwS+CiHWfv07z3Uox3P/PwowCnDBlaxzFJJn1zY3opjQV16nOvChJh6fsFOJ4hkk9zOYD7yfxwlnsyQHef2Lm+/RWfNQWRhpi+Ak4b6czI4a1nGE3ImhM7Dt8s+Za+ycgXJnnSw61dEEOgjqQSn8nk1/aQuTOyt+EpiWO6zfRWT+6V7PVLTUVgr9HK0knGjdog8D0vgReUqo3HZNvCyQmo1hWiVO9AXretPYKn+DUHDQI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26ba7cd-a70b-4c89-17fb-08db3eecef3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 02:39:14.9897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjcFQS15mvanZfU/R8aTfRhPg7/Na4SFiagFP5sOGq6e1loXfbJVu1bTWVdqiv/cB5k8m9Ym7VAJ3lhe2HCRFLgY22BAqZBI4WP1fAA14Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11090
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] ipc/semget05: Convert into new api
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SEkgTGkNCg0KSSBtZXJnZWQgdGhpcyBwYXRjaCBpbnRvIG15IG93biBsdHAgZm9yaywgc28geW91
IGNhbiByZXZpZXcgdGhpcyBwYXRjaCANCm9uIG15IGx0cCBmb3JrLg0KDQpodHRwczovL2dpdGh1
Yi5jb20veHV5YW5nMDQxMC9sdHAvY29tbWl0cy9tYXN0ZXINCg0KQmVzdCBSZWdhcmRzDQpZYW5n
IFh1DQoNCj4gSGkgTGkNCj4gDQo+PiBIaSBYdSwNCj4+DQo+PiBQYXRjaCBnZW5lcmFsbHnCoGxv
b2tzIGdvb2QsIGJ1dCBJIGNhbid0IGFwcGx5IGl0IHRvDQo+PiBtYWluIHRyZWUgYmVjYXVzZSBv
ZiBzb21lIGNvZGUgY29uZmxpY3RpbmcuDQo+Pg0KPiANCj4gSW4gZmFjdCwgSSBkb24ndCBrbm93
IHRoZSByZWFzb24uDQo+IEkgdXNlIG15IGxvY2FsIHBhdGNoLCBpdCBjYW4gYmUgbWVyZ2VkLg0K
PiANCj4+IENhbiB5b3UgaGVscCBjaGVjayB0aGUgcGF0Y2ggYW5kIHJlc2VuZCBhbm90aGVyIHZl
cnNpb24/DQo+IA0KPiBJIHNlZSBnYXJibGVkIGNvZGUgZm9yIE1hdHRoaWV1IEZlcnRyw6kgICLD
qSIgY2hhcmFjdGVyIHdoZW4gSSBkb3dubG9hZA0KPiB0aGlzIHBhdGNoIGZyb20gcGF0Y2h3b3Jr
IGJ5IHVzaW5nIG1ib3ggZm9ybWF0Lg0KPiANCj4gQWxzbyBmb3IgdGhpcyBwYXRjaCwgdGhlIENv
bnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQsIHRoZSBwcmV2aW91cw0KPiBwYXRjaCBpcyBD
b250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA3Yml0Lg0KPiANCj4gQWxzbyB3aGVuIEkgc2VuZCBw
YXRjaCwgSSBjYW4gc2VlIGEgbWVudGlvbiB0aGF0DQo+IFRoZSBmb2xsb3dpbmcgZmlsZXMgYXJl
IDhiaXQsIGJ1dCBkbyBub3QgZGVjbGFyZSBhDQo+IENvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmcu
DQo+ICAgICAgIDAwMDEtaXBjLXNlbWdldDA1LUNvbnZlcnQtaW50by1uZXctYXBpLnBhdGNoDQo+
IFdoaWNoIDhiaXQgZW5jb2Rpbmcgc2hvdWxkIEkgZGVjbGFyZSBbVVRGLThdPw0KPiANCj4gSSBo
YXZlIHJlc2VuZCB0aGlzIHBhdGNoLCBidXQgSSBkb24ndCBzZWUgaXQgb24gcGF0Y2h3b3JrLg0K
PiANCj4gQmVzdCBSZWdhcmRzDQo+IFlhbmcgWHUNCj4gCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
