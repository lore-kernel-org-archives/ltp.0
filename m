Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355D4C43334
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 07:26:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1AF73CA389
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 09:26:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B51593CA327
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 09:26:30 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5222C2000D4
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 09:26:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657265189; x=1688801189;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xkUqY/kOOoHtmiKrHGqAofHe7zC2rk6gfYwKcL6zQ7Q=;
 b=fMP8Adpu/+fyFz8O4+o/BOtMb8AprXoUCSm9c2GovlvkmqOErQ8Oq/H6
 Ov30MPEDA9uBqknH2whYbFef+X56cgBIGw2vwHJxV4rkzUec+twQ3M+OQ
 0LSkX9MTPsMLWUvrhKNsb80FyelvXTSOndZMEyk7E7L5uDCStWpp9zKKv
 B+YV7kOV5ubtYTK6kXQMsUE83eaOnsA1rA8lvEUZnrCbFzR1Hb0/gKmcr
 pUcsim1oehye0g2kJn/zvCG40GZ5jaFnBu5J2AA0AfbWUbzBw+sjddFIc
 8TOgOvOSftJMjryvK7aM/UOMWSbQr9r53mUFvMjOls8tnzhkfcTQCmg04 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59593388"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; d="scan'208";a="59593388"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 16:26:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRrvvGeDgsX6SlERX/fPdp/QWHzrRsrNQPHG6utAEO5yA9a9pRlWqUmn29w8H61CTN4EmJ/ZNl9pyrA42qyL2aItwcZftqmrFj7InUSI5bSjSTDzZKWJYBNUDSlGiPlwxWunhyIhuJacvKK2NiV+EhBEXjJAuvf56J9+iMqdc5wwVNHEQ4LduRLDaMIb6WF3cI3xvK2PFSSgTi9MxCf4zV3t0FTEHFgGCws5li0oaE3opNJy8+RYIsbKwpF4/HQrDAxZJxqFYGXp8MiGIeFFqmUpNn+Df7Bl7dgqJtuPqlI7eR/xa76tpI1rc2WA4WQnzHXe4qo3bdCoOzF7YsrOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkUqY/kOOoHtmiKrHGqAofHe7zC2rk6gfYwKcL6zQ7Q=;
 b=YwVU3ItbJhKZmg6cKflB+OeSFkXcE2IQYrfbIPYH2KDj7eEQeEcR9w1fX0kYSKorJgQ8c87bGAblhX1NxgYa8vNcK9MYGX1zrzwZuDLEw8hM/bGOQcP+0OwhzCeCyfuqUSnQ+A9QBZ+y7GBA6VhR6WfZzupBWcCfb4GonovQa9WNAwaw3ayZx2DBMAhjpWSX2yq640VTwe9dMr11TOoOHy5yw1Uaik5cEs6JpxKN47qCgWqjC1gTIFVE7oO380CmlJPKqHmfp8zpcAeZK2QWiOQ2ZES3JPh3F+pSVCJXfcHEnintSu8+8id4jtAg9p20L5LBjPvPrtZsRVNtq3fvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkUqY/kOOoHtmiKrHGqAofHe7zC2rk6gfYwKcL6zQ7Q=;
 b=Zrj6n5T8B/UyQZEv7xXrnWyZ9EVotoiccshV4es5CciBJ6lOW/mD84fO4M1/o5mAh7FcWP46RTKanK+9Ny640PKLoyc/Il3YUXi5PgYaRXvFvoYVGtkluSolgVlBwxMJikO3hMrLzMJKhjLkxAk5aBNemNZLKPTt5p2+g1CPcmc=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB5063.jpnprd01.prod.outlook.com (2603:1096:604:7d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 07:26:22 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 07:26:22 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: zhaogongyi <zhaogongyi@huawei.com>
Thread-Topic: [LTP] [PATCH] syscalls/creat09: Add umask(0) to setup
Thread-Index: AdiSfpfPHOhtinRARVqVHuUi3WEtKAAJbiRw
Date: Fri, 8 Jul 2022 07:26:21 +0000
Message-ID: <TY2PR01MB442784936336461F3EEF739CFD829@TY2PR01MB4427.jpnprd01.prod.outlook.com>
References: <4739766d7e9841eba1af74ac93878d40@huawei.com>
In-Reply-To: <4739766d7e9841eba1af74ac93878d40@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YmY0YWQxNjgtMDJmYS00OTQzLTllMGItOGY1YzNiZThj?=
 =?utf-8?B?YjQ3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wNy0wOFQwODoyNTo0Mlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 060eaa2e-a975-46ae-d098-08da60b32876
x-ms-traffictypediagnostic: OSBPR01MB5063:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikt/LFcSv4STKrDq+WEbPo/VviOmpkHKI8I40If+strrsbq3gDa+WinFFd2y5mPnltm/3++eTO4VlNqUUlrE6zglrx0351dLv238OAtTtkP3b2xyj0/VEeUUfuCQ8Jz/Hsf+Ulbo2NE7BbvyDTVyYFaCpSrVqggw+0RJq27r5/o5dkykn9l8NOhAorZigNt/Qqghucj1gkSaoyXkJhM/CrIlLzhyBO3El/kUZ0buBqOYIybLIdrR6rMTgPWuQIAUkSdbGBQjOta9YH5zwYT0tXztlmPBRXcGHJtxa7C3lxJWnA3v6pgxjDMQGXKTbiDykULxmduGoryHaGy8wxu+U0AQQu7l8pSNibsBjUXY7ucShNE44bXDy+AltFNozdMw3ylxPKQiO+M3Ky2V8MMnNXyHyLuqmUl7g+xtqOI+W95WrbO+J+wJMx0h5d4/zqhfRSQpoQ2OyjEMsEgpaBiDJMzcKxARA1D2MaKMZ8YBqneQAUiOSlNez5/QAO6JLBRkVja9EN6SivDo7iy6Yk51+ylndScF5rXPLnYD0dZRk9sZqk31StY+XdVFwsYo3LtinG8tdO++7R2wTcGDbJGbMOkKWDTS8VcLprIWjEQ82HtqXowOTVOBlkNMbayWzGbrexhj3W/49xKVftFyORGGLy6nvgZsUEoQyvnOTGW6/TqV7ljD/zxJ3gDz8prDkznfDDV6ZvDzjF0PbMFNCdqNDj8BmSEQDbYwyEYVN5Pu9fpJbHgpFnYMeEWklQJR+aAL29KChn3p7YTVhhV8kC4gxWwiqzNuvxoPBkX1u/45SkqcPt4ZCVafYpa6uIQiSc9/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(38100700002)(478600001)(6916009)(64756008)(38070700005)(82960400001)(558084003)(71200400001)(41300700001)(85182001)(66476007)(316002)(7696005)(8676002)(9686003)(26005)(76116006)(66946007)(54906003)(66446008)(86362001)(186003)(66556008)(52536014)(2906002)(6506007)(8936002)(5660300002)(55016003)(4326008)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WklUZGttZkZZQXVaR0hQVmZxVGs2dEg3N01pQUdvL3lwdjFYL2Q5NnVNYjA0?=
 =?utf-8?B?MmwvaG9tNHpjdWFSdnVpRkZ6QjBkS3Mvc2tCUTlXWkh1UWh2ZS9BUGZhOFZR?=
 =?utf-8?B?MFRxM01CcDVRYjZaaStLNUlJdGU0ZVBDVVZKMklyZnRBeStWR1BxaS90OUJR?=
 =?utf-8?B?WmhIdEcraXduQjhxZ1J2QXBDeVRWMk1jcUVhYnRPZVhpL2g4c2QyZWNpb2tR?=
 =?utf-8?B?OVNLUmlGRmxCMno3UHFGRXdxZXVKRUhSbGF5Vks1TEplam0xRUJOOHBTUHh3?=
 =?utf-8?B?YjN5dW9jNEFBQ28zb1BiWDdrbHpydTEwQXloaUcxRjFzYzBUZDNqT3NDRmUv?=
 =?utf-8?B?UEFUamhlbDNncE9WdUZ3aFdoM25lb3dTRjlvUVMrUmtpbXlqdndhUHU1ZUg4?=
 =?utf-8?B?eG5WNGlyYS81ekJPekxwTDkyS1A5QjJWM0ozYjJRTTRiQVZqWHFlUk5VYjBR?=
 =?utf-8?B?T0lqcWxKaXVlTzlURmFCRVpQd0cwb1VxRjZCdXVjb3NtTUFMdFZaeFRXdWhk?=
 =?utf-8?B?Qlp0Mm5rSzlOTkZvdDdwOEZVRzYyQlQwTU1yeS9ENzJvMVovZVZjdkwxSDYw?=
 =?utf-8?B?c0NkUG5kVkxlM3d4N2VtaHdIRTFUVG1HMDhMVk9IcVlLSW5LTm9XbDgyc3Jz?=
 =?utf-8?B?amkwL1c5Y05VZW04cFJSL0cvdkV0UERNVVBrYXJHNGhpSml3SnFTdFMxUzhY?=
 =?utf-8?B?elZyZEFmaHBDdFJJdEI4RWRpbzJNbU5GTUg2NkVyYkE5dHRIOSt5S0pMR3Mv?=
 =?utf-8?B?SFh5Vmk2VEk1Z3h5SlpHTTdpQTRZeXprc3F1d21Dem9wSFFSZFJXMk9UOVhQ?=
 =?utf-8?B?MkJRbXY0M3JBOXZxcDg3UGRaNkM3eDdoeGFkdi9ySUNKcUhWQmlYUUhCVnBE?=
 =?utf-8?B?ei8vbGpoWmgvaGVCWUIwQldmcS9xeW90eExQTUlKY0xYTVQ0UTEvNUJMdStZ?=
 =?utf-8?B?K25sbkd3MitXV2F0ZVdzQnJoNERlemlKcFhXcE1OV3B3UENSUFNzZWNnclRu?=
 =?utf-8?B?NXZhSWxGWSs4dG8ydk8rYjI0WC9uU2szSm5SeHFTSER3MHZ5c2FwNUJZUGZZ?=
 =?utf-8?B?RXlwNUpITEgxcThJMy9jNUJlRmpUY3J6a3NrbjJ1T1AwcHkrNHR4a2wwcGpR?=
 =?utf-8?B?cEhyYTcrUURlRjJwc2VQejhjdCtWSHhhcmVNMUtNT0E4UEQ2Q1ZLWmRTbFV6?=
 =?utf-8?B?WURla2NSVlhCZVZGd3Y2TlhPRVRqcUxvQlp3YndUKzU1NmMzcHFoSGU4OW51?=
 =?utf-8?B?QUY4NVZ0Z0R0cDMzczVOaWlZakZlN2lidUNTcm5qbkExcDR3RkZodFFDZHlp?=
 =?utf-8?B?TUlLNE5lMEVDNzYyK3daTVBaYVFXSkFuaS9lbER6VWlOZVFpcU1EeHpWN0Nm?=
 =?utf-8?B?NWQ0RTM5bCtDOHhBaFVmSHY2ZnBEOStnUkpKWmV6REhVYzZuTkZLQ1NMWFYv?=
 =?utf-8?B?WHBzbG9sa0pDQjJVcFBxRmpKMkx4aUt2RVNrRXRST1k0OEpCWTI3OHZDbVE4?=
 =?utf-8?B?VWEwMDJQODcya1FUa2pTeEF3MTN6RXduSlJ3TDBwNnlKVTJZS241SWZBdUxO?=
 =?utf-8?B?enNxemI5eE51MzYyTnFRSkozRmdKNXRRaExJUURkaUNkeGRwNjBJQkJhcmNw?=
 =?utf-8?B?YWoxdVJ6c0JWbWk4TjF5YWt5NmcwME0vRmdOYklhQmFJTDFDcGNSUDc4eXFw?=
 =?utf-8?B?MUg1S1Zpeit5dCtIdEd1ck10c0xDREhpdHU0YUFkanp6U3VxNzNOaW5SZ2t4?=
 =?utf-8?B?MlUvcWRkR2JabDR2RjBXL3N5bW00Ulh2cFhyelBNbjJBSTNPcnZKMFhBL1Uw?=
 =?utf-8?B?V0pDOHhpUXJZbzZUZ2dMbGVoTU5uQUtyTHFXUHM4cWxVekV6aHlCUVBPaHFi?=
 =?utf-8?B?YVJ0d3RiTFBxTVhhaTQ5MWhVeDlqUmV1NWF0WW5ZaG5TWlo1VzBmQ0VaK0R4?=
 =?utf-8?B?NjU3Z3B1U0JpL1E5MldxMVZvTmFiVHJiRTk3elI0NE1qWHNuZ3ZwYmtQb0Vl?=
 =?utf-8?B?Ym5lOXhKYU5vVXcxdlVDUXk0bmxXc29Ndko3dC9JL0RHbkp3S0M1bndPZi9y?=
 =?utf-8?B?NHN0Lyt3NlR5VXVBLy94MDBKSHlod2NHR3JKTGxsa2tnTXdjZVlGcWt2RENQ?=
 =?utf-8?B?UGRBaWNZb1JrRkYzbGtBWHM5eDFjT3NubVgvdzRnTXVVY2hRVkdISUg0YmVn?=
 =?utf-8?B?T3c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060eaa2e-a975-46ae-d098-08da60b32876
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 07:26:22.0321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1j4JreW69Imp3+lI+NfGaLdwvnfuHtXVZnWGDpGnA9WivP3DnXVEPYqWnz8oxEvlYLgovovs4QJGVpZaN5a/a9FzlzhPSrv90FLEsyGswtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5063
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/creat09: Add umask(0) to setup
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
Cc: Zhao Gongyi via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao
> Shall we also need to add umask(0) in setup() though the setgid strip logic is affected by acl operations?

Don't need, it will hide actual kernel bug.

Best Regards
Yang Xu


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
