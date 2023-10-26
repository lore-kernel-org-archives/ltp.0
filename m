Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D5EC25B67
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 05:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F8223CCB35
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 07:40:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E32653CCADB
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 07:40:38 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B3E1920004A
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 07:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1698298837; x=1729834837;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=By2WnVdKEjye4tuk5vKXedwT429DUVokl7SNhbdgZkI=;
 b=QR8x65BU15vtjLyS0WwdvcDWDsFiCC8sfGHAJH7FstDcJhevywqE3bvR
 tuQCq1nDzXQi0cvezh9R0w8elp/F23AR2LiK5s0mrZ+AwZ5k2n4BM0Azs
 m99UH4rn2FOQC3SzUZaylPv5Eet/v4fWn/pezoAOjktTtSkbxBsO6srve
 KkzJVv9mBIlbZf8jpb4At8CxH9Ny3O7FBs9ogme7Ba5rJZD8mJuCRYaqT
 1F0Nmla6wF//XIH59q/Ljd8UzOiqA0ui+UMSknhXRVX1cbOn+IBfFBzIT
 /3R5p1gSLuV4cK8e/kM4sBfRhKPz8a78nYEMTn2MU3ZZGNzed6/rG2eKq w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="100721629"
X-IronPort-AV: E=Sophos;i="6.03,253,1694703600"; 
 d="scan'208,217";a="100721629"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 14:40:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C++lnO2B74RzHvgzLRTHv0Cvv2XlB/zVUx5UzJ6C95ovNmi4WBMfMT4b+j7Gv3gJ45RpRNFRXVl9S8xSEZkI73hohXze443/U4saj1aEr8yA0jIECjZ/L46PtShsf8V4MQIUSVZk6oaF3WD01fD5HqAALzYMHaVi1881T2G2QUhPXL1dlZkYoNFcBx3XJXHsMCV3sClc7QfIPVXfk8AkL28nl/ZLfTCw5d4simu0zn03tJG2VC0idvt4pYVadEb83CvKYCYCabsJOjucdkmp27MdGHLx5WB+/WhuKTvGNDHd+UvRNotysYfz+YIRMucmwPO7HgTdKp+U9C0GIPuciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By2WnVdKEjye4tuk5vKXedwT429DUVokl7SNhbdgZkI=;
 b=oXgaxoXN7BET3f0PP3X8Mr9kCaK4hrnuS3uFgS5v/mEhSwwaUG+xoGUbeGtNjhpj1mf7bM6DeFmM7pWmyRgXXMMhXdPZcYRP6MUAka2lKNckpTaEQS3vUZNf4Or5XHIEJugAEPmlW6R4X4HSrY1/fzuxVvutifcgMT8hIOlGbl8bLplWwSABBdGTxXPB3NR+ouMlTfom/6P9KOIGYlSXHTxsewuEEVX8dPhL8dalJrTBTGqJ559gJqy0p7Um6kWKHXcJGtHSc6idXM6/JFJFHp9AYbw9aXjdwTezEx6UO1Q9ZFj3pWcovqzLJcWpCuU4Y2NjoK+iuo5nJDE0Ymx7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OS3PR01MB5992.jpnprd01.prod.outlook.com (2603:1096:604:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 05:40:30 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::251a:519c:5239:ba4f]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::251a:519c:5239:ba4f%4]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 05:40:30 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] umount02: Simplify test using TST_ macros
Thread-Index: AQHZ/Ofa6jc3bRuuU0eoW5vxm8l/E7BbSFiAgABY36o=
Date: Thu, 26 Oct 2023 05:40:30 +0000
Message-ID: <OS7PR01MB11839E411725A81EB0843932CFDDDA@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697100058-2859-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20231026001217.GD540370@pevik>
In-Reply-To: <20231026001217.GD540370@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-10-26T05:40:27.678Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OS3PR01MB5992:EE_
x-ms-office365-filtering-correlation-id: a440bde0-44d1-4e28-df14-08dbd5e610d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BuVVYM23cs/RzJDdW3UG6SPYjhUz/C4qFwYfl5qlIUqsiAr30u8iEJUAAwJ9WrMtKp9owiE0MxTMfHETCOCJaCgQevOgNjKkyPk1+WC2/SCyHKs9H0Qy6SUSBsMVTpfwHtt1+yGQil7sYypIg/dybebGQJEW+XfaTzzjwCKDqMMZHNpSllqHrXGMMQlzv2B5qkFMyPz32NkfC+4KP3w/0V63OytxikjXD4xe3Wn/gsEhOEf3acRBGAhn8WXVMOQb+BOEekcFt1aHMP9HfIhytIv0A7XmoCS+mJIcCxmlcdHDWLp/ro/sqY/3JuBqnvAfJS+LwOO4Or0A075ipd3GTmPM5Xpq/6y/wcUheK9bD2jKBox4MNsXNnbg+ToqAkr7IIfcb/3CrYiR2lp7mjYbi/ZaCOxcRfsMenerLRgRF8GOnxV9N6TmaV4Lhmg8VL3q039B/b+m13MC0bTfz39fW8RVStF96K5bdaFbpHgqFIpv/Ykv2AiMVlGFKGJcyvz23SKUlYUz5AmoVCfk7D/wnxZsvLkBW/LKsxje0r3fHQkGF2p4WLeIdzLMTArByJCAbVZk4YPZYCbo7JXHEh6KFfDTFpXoUYRlY3lq/Mls+OHuPvvYX1UYtlnf8c4hcKxJAFQy45z+AHc0UykdwIY4uA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(1590799021)(451199024)(1800799009)(26005)(55016003)(9686003)(1580799018)(38070700009)(82960400001)(38100700002)(122000001)(86362001)(224303003)(33656002)(85182001)(83380400001)(66556008)(76116006)(66946007)(66476007)(66446008)(316002)(64756008)(4326008)(52536014)(6916009)(8936002)(91956017)(41300700001)(5660300002)(19627405001)(2906002)(6506007)(7696005)(71200400001)(478600001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?K20zTldIekJBeks2MERkd3p6ZVNGZDgrN1RIeCtMRlQ1a1VVUzMvWVRESWZt?=
 =?gb2312?B?WEg0clJscTBsSFI2QXNVYTdiSGw4RWNwNmZkdVc1S2lob29jcm9qc0s0TXRE?=
 =?gb2312?B?NktqUERxSjJDZlR3dGRwZXFHV3pCZ0NPNkdTUDFXcng5YVp5WG9YcjlQWlhB?=
 =?gb2312?B?Sk8yK1lnd3ZZZ08vVHZNbUFDdkowR2c1SXJwcnFRQkJrK1JOaElkdE1QbWc0?=
 =?gb2312?B?WVdyMUZqMzAreFVCc3JGRnUvODJsQ0ZaQnRkcnBkdCtKTDI2dUt5V1QzVk1h?=
 =?gb2312?B?ZlZrLzJTOTNMcGR4VlpNN3RPZWUwQnZPeUcwSmFyY3c1S1pkRm9DcWJkRlJn?=
 =?gb2312?B?SDV3aXpjZjBBYk9pd0hFK2ZKOVZ3SGxkV25qYm1LVGdPSHJPbit6YWdOR1JR?=
 =?gb2312?B?KzdLYXZaZ3doaC9rb1dWMUt2TGxPUXBzUnNnVCtzOFRiZW12MUpHOTAva1hq?=
 =?gb2312?B?ZHZmbGp5czhDVythb25LU3dVdWo0OGlpNnZ2Q01Na2Rxc1YvN2hNMUpjRFVH?=
 =?gb2312?B?aGhWVVFKdEhFLzkvVWJzK0NxTEg2cDhsSjFNcmtScW9ya2RrcjJCQkxGNytH?=
 =?gb2312?B?dlBGZ2Jla0g3aXFPM1VKanV1NW1iemVrWkMycGp4L3RvMlIxT0NYQ3FQZDc5?=
 =?gb2312?B?NlUvNWd1bEUyRlNEVGtIRDFjajFkR1lBaGpJN1RWUWRJNXA4OHRWc05UUHl6?=
 =?gb2312?B?NXRPUnlsR05rK0lvU2FzR0E3WjVZZ3dKVXd1VXNiUDM1bldUdWhtUzdnVEhR?=
 =?gb2312?B?MDY3N0gzQ1AvVXJPRHZIbkFMTUk5R2VkTXNjWkd3MGJoUHY0SWhKdjZhZHRJ?=
 =?gb2312?B?ekJrU2lqZDc0T3FvdTFFOWQ4TnhXWDRHU3JCUCtUU0NlRGFYMFB2SDB4QXNS?=
 =?gb2312?B?bk9BSmE2cktPcVpSeGFSUVFGbCthZHlBdXhPMXdJVGFGd0hia0JMcmZLVldl?=
 =?gb2312?B?WHBVTVcrS3BQWnF3OG5VbWpsTHV5cmsrMXhBZ0RnT3AyeGMwektISFVJb1A3?=
 =?gb2312?B?bmtNRzBhSXowVU00aFRqQ2tudk9MNlc4TGpwWWhPcW9ta0J0UmlDRFEwTlli?=
 =?gb2312?B?cThleGlVS2lXa1NROXY1NWROajNOQzI4RmRUaElETjQ1eTdYcTM3QnkvVDhN?=
 =?gb2312?B?MlZEdmZZQXQvbUZGeEFSbFV0MytveUgvdlcvdHB1VlFuNVUzYkNpR3FjZEF6?=
 =?gb2312?B?QS9xUm4zYmlrY2xNQmxQemx3YjhBRndCbit1bkJzYkw4ZXJWekxQWDNoTHFO?=
 =?gb2312?B?NFpHUnh0VDNoYmFFa0RrTUU5MVBQb0E1a3RyWWNSVURVOXNmejUraUdBSkd5?=
 =?gb2312?B?cWI5a3Ywd0U4eXU2MkFXbXFOakRYUm11Mm1GN3JBc24wMDhsdUI2eVVzTHJR?=
 =?gb2312?B?R2p5dXRPMk1rYVNnZ2RHMER5a0FlTHJpUStqVDN3WC9OVWtDMnJ5QXBIYnFs?=
 =?gb2312?B?MkZ3dTdKc1NJbnRKc0tRd21IbGorSUt6ak1TZlZPWmxxeVBWOWVpSzhyOE5p?=
 =?gb2312?B?WmpUcVNGMndhOVkrZmpFcUFxMmVES1A4cHg1L3pGL3lENlJPWkJtRmFLNFlM?=
 =?gb2312?B?eXhnbGZGWGJhNFN0UFRsaDZPKzZOVVBuNmxVNGJZcEkrZnJNZjBnQnJ3Yit1?=
 =?gb2312?B?WWZHbjRIbHNKMHk5cDJETmdPb2ZacSs5UE1lYnZOc3VCanpvdlhGSWY0RkMv?=
 =?gb2312?B?dVBsei9jalNpeGpMTmNiWmFIM2ZOUjcwaHdkZENvVkhiSTNPNndIYmttdUtq?=
 =?gb2312?B?dXhkQlQ1YU9vT1p0SkF5aHBvN1RJUmZGWnNxQjNuU1pSUzd0K3JmMHZCR0p4?=
 =?gb2312?B?NTZyOWRUZkVJSkV5dmdwY1hhMEczNC9nNG0vWG51a3FHYkw0UjZBZHRvZTBw?=
 =?gb2312?B?TEs3Nld2WVFScXJQTzFYOXgvUVNiY2FjMmxtRW9rZm52QXExcVM1TXhyM0s5?=
 =?gb2312?B?Smg4WElwaXZYMlRZTTJnMmNkRnBNS2Zmd0ZqdWJzeDM3cmNjRGJaYUJYVEkx?=
 =?gb2312?B?Z3BwRmNLbEg3QmoyQW0wUUI2S0ZUdittUktUOUdoSDlTUzJrN2JOUGZVQ0Vu?=
 =?gb2312?B?aWdVVjl6NE9TTDVMaW43NUZHdWFzbTBUWXFBclVQSndEcHJlQWZ1cVRkSm1n?=
 =?gb2312?Q?zWNG11NvWq/sQOszfSrejBdkI?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MUDNW1dlGAWsu55rhXjvE0/04N8ND4oi3SkWu1kYXbclIfIDGsSK/O3tJfZ9UqRl4a7CtucVEvXDmHaBv41U14THGNvoPBBmpZHDMd0OsDqkshr9UX9Nkbltj08sGuTnWNEkVp0CWdZpoUZs4/3Vx+VdTDFzsrMmvmyWPMpXGS46yWEbzK6eIfW7fyoXiUn7fx6iMTgM0r4wI+84hFOCFYrUApQydrbtv3dqMy/qu+UatiUy3OA/P828xMn8NdnvsaXR5F5phPrb9OLFVGz6MHIQYFUInOWAbh8AMj6ChNUqLuRa23nZs8GnjUNKqTfWtzGKZCgY0c44w/cgNqoKILsHklNQqPjMc9/nzIdxrqGPNkUUPgYxGzUz9XAI+ERwix2DKD0tbR8oUfeqlhJ2VKwPASC5e50fmZt7lFDh7kMEKakt1XPiFZ6TJSrFV61TQ96b/mgXhGtZeYyMvpsCft5a3DkJQw3pH3jusBYDrV6DqSbyZt+SyOTEkY6xUjZUyRXCOB5XIz1gc1/idf34PR3dGb8dNGN5j32e5P00ua7Mya0a8AmvZtfqQxvhUlhanN3n+ML8Slm0fmekT9dAhiOcvhU/W3qvx/d608XJfdauk5CCeqm3glQXhp4sZLy7eoi9EnCIIgaYN2Dbxm6A2AgDL9LWCDLqy3gR0tw5YZintd3IxlhWC5wxyYRL9xGFKZYYkgsZ1ooUKeAzKbJCbvvjMsDiW0Ic6PNVWJ4/LJ0swm153tfDhns5w/aPtUwrrorCKeP3xIOGzWHdmwR0ofc9asK7qwZsAd6hH5q6gSo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a440bde0-44d1-4e28-df14-08dbd5e610d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 05:40:30.4641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VU0y8k41yA5RFigtl3UKxiofMmy7wMgwi+31Gp+UoumUs4IyDSE7Fr18gi/K1Cs2+2wV5j1GexfDyA1mPayLWGBS8KmVzh7MZXySmebYwk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5992
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSCAyLzNdIHVtb3VudDAyOiBTaW1w?=
 =?gb2312?b?bGlmeSB0ZXN0IHVzaW5nIFRTVF8gbWFjcm9z?=
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Pj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4+
IC0tLQ0KPj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW1vdW50L3Vtb3VudDAyLmMgfCAx
MiArKystLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA5IGRl
bGV0aW9ucygtKQ0KDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91
bW91bnQvdW1vdW50MDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW1vdW50L3Vtb3Vu
dDAyLmMNCj4+IGluZGV4IDM0YTM4Yzk5OC4uNDBmZWQxZmJkIDEwMDY0NA0KPj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bW91bnQvdW1vdW50MDIuYw0KPj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy91bW91bnQvdW1vdW50MDIuYw0KPj4gQEAgLTIsNiArMiw3IEBA
DQo+PiAgLyoNCj4+ICAgKiBDb3B5cmlnaHQgKGMpIFdpcHJvIFRlY2hub2xvZ2llcyBMdGQsIDIw
MDIuICBBbGwgUmlnaHRzIFJlc2VydmVkLg0KPj4gICAqIENvcHlyaWdodCAoYykgMjAxNCBDeXJp
bCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4NCj4+ICsgKiBDb3B5cmlnaHQgKGMpIExpbnV4IFRl
c3QgUHJvamVjdCwgMjAwMy0yMDIzDQo+PiAgICogQXV0aG9yOiBOaXJtYWxhIERldmkgRGhhbmFz
ZWthciA8bmlybWFsYS5kZXZpQHdpcHJvLmNvbT4NCj4+ICAgKg0KPj4gICAqIENoZWNrIGZvciBi
YXNpYyBlcnJvcnMgcmV0dXJuZWQgYnkgdW1vdW50KDIpIHN5c3RlbSBjYWxsLg0KPj4gQEAgLTQx
LDIxICs0MiwxNCBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfdW1vdW50KHVuc2lnbmVkIGludCBuKQ0K
Pj4gIHsNCj4+ICAgICAgICBzdHJ1Y3QgdGNhc2UgKnRjID0gJnRjYXNlc1tuXTsNCg0KPj4gLSAg
ICAgVEVTVCh1bW91bnQodGMtPm1udHBvaW50KSk7DQo+PiAtDQo+PiAtICAgICBpZiAoVFNUX1JF
VCAhPSAtMSkgew0KPj4gLSAgICAgICAgICAgICB0c3RfcmVzKFRGQUlMLCAidW1vdW50KCkgc3Vj
Y2VlZHMgdW5leHBlY3RlZGx5Iik7DQo+PiAtICAgICAgICAgICAgIHJldHVybjsNCj4+IC0gICAg
IH0NCj4+ICsgICAgIFRTVF9FWFBfRkFJTCh1bW91bnQodGMtPm1udHBvaW50KSwgdGMtPmV4cF9l
cnJubywNCj4+ICsgICAgICAgICAgICAgICAgICAidW1vdW50KCkgZmFpbCB3aXRoICVzIiwgdGMt
PmVycl9kZXNjKTsNCg0KPkknZCBwcmVmZXIganVzdDoNCj5UU1RfRVhQX0ZBSUwodW1vdW50KHRj
LT5tbnRwb2ludCksIHRjLT5leHBfZXJybm8pOw0KDQpPSy4gVGhhbmtzIGZvciB5b3VyIHN1Z2dl
c3Rpb24uDQoNCj4+ICAgICAgICBpZiAodGMtPmV4cF9lcnJubyAhPSBUU1RfRVJSKSB7DQo+PiAg
ICAgICAgICAgICAgICB0c3RfcmVzKFRGQUlMIHwgVFRFUlJOTywgInVtb3VudCgpIHNob3VsZCBm
YWlsIHdpdGggJXMiLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICB0c3Rfc3RyZXJybm8odGMt
PmV4cF9lcnJubykpOw0KPj4gICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gICAgICAgIH0NCj5B
bHNvIHRoaXMgaXMgcmVkdW5kYW50IGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4NCj5XaXRoIGl0IHJl
bW92ZWQgeW91IG1heSBhZGQ6DQo+UmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6Pg0KDQo+bml0OiAjaW5jbHVkZSA8c3RyaW5nLmg+IGNvdWxkIGJlIHJlbW92ZWQuDQo+QWxz
byBkb2MgY291bGQgYmUgY29udmVydGVkIHRvIGRvY3BhcnNlLg0KDQpPSy4NCg0KPktpbmQgcmVn
YXJkcywNCj5QZXRyDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCreivP7IyzogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+DQq3osvN
yrG85DogMjAyM8TqMTDUwjI2yNUgODoxMg0KytW8/sjLOiBYdSwgWWFuZy/Q7CDR7iA8eHV5YW5n
MjAxOC5qeUBmdWppdHN1LmNvbT4NCrOty806IGx0cEBsaXN0cy5saW51eC5pdCA8bHRwQGxpc3Rz
LmxpbnV4Lml0Pg0K1vfM4jogUmU6IFtMVFBdIFtQQVRDSCAyLzNdIHVtb3VudDAyOiBTaW1wbGlm
eSB0ZXN0IHVzaW5nIFRTVF8gbWFjcm9zDQoNCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4gLS0tDQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3Vtb3VudC91bW91bnQwMi5jIHwgMTIgKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQo+IGRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vtb3VudC91bW91bnQwMi5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy91bW91bnQvdW1vdW50MDIuYw0KPiBpbmRleCAzNGEzOGM5OTguLjQwZmVkMWZi
ZCAxMDA2NDQNCj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bW91bnQvdW1vdW50
MDIuYw0KPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vtb3VudC91bW91bnQwMi5j
DQo+IEBAIC0yLDYgKzIsNyBAQA0KPiAgLyoNCj4gICAqIENvcHlyaWdodCAoYykgV2lwcm8gVGVj
aG5vbG9naWVzIEx0ZCwgMjAwMi4gIEFsbCBSaWdodHMgUmVzZXJ2ZWQuDQo+ICAgKiBDb3B5cmln
aHQgKGMpIDIwMTQgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+DQo+ICsgKiBDb3B5cmln
aHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAwMy0yMDIzDQo+ICAgKiBBdXRob3I6IE5pcm1h
bGEgRGV2aSBEaGFuYXNla2FyIDxuaXJtYWxhLmRldmlAd2lwcm8uY29tPg0KPiAgICoNCj4gICAq
IENoZWNrIGZvciBiYXNpYyBlcnJvcnMgcmV0dXJuZWQgYnkgdW1vdW50KDIpIHN5c3RlbSBjYWxs
Lg0KPiBAQCAtNDEsMjEgKzQyLDE0IEBAIHN0YXRpYyB2b2lkIHZlcmlmeV91bW91bnQodW5zaWdu
ZWQgaW50IG4pDQo+ICB7DQo+ICAgICAgICBzdHJ1Y3QgdGNhc2UgKnRjID0gJnRjYXNlc1tuXTsN
Cg0KPiAtICAgICBURVNUKHVtb3VudCh0Yy0+bW50cG9pbnQpKTsNCj4gLQ0KPiAtICAgICBpZiAo
VFNUX1JFVCAhPSAtMSkgew0KPiAtICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwsICJ1bW91bnQo
KSBzdWNjZWVkcyB1bmV4cGVjdGVkbHkiKTsNCj4gLSAgICAgICAgICAgICByZXR1cm47DQo+IC0g
ICAgIH0NCj4gKyAgICAgVFNUX0VYUF9GQUlMKHVtb3VudCh0Yy0+bW50cG9pbnQpLCB0Yy0+ZXhw
X2Vycm5vLA0KPiArICAgICAgICAgICAgICAgICAgInVtb3VudCgpIGZhaWwgd2l0aCAlcyIsIHRj
LT5lcnJfZGVzYyk7DQoNCkknZCBwcmVmZXIganVzdDoNClRTVF9FWFBfRkFJTCh1bW91bnQodGMt
Pm1udHBvaW50KSwgdGMtPmV4cF9lcnJubyk7DQoNCj4gICAgICAgIGlmICh0Yy0+ZXhwX2Vycm5v
ICE9IFRTVF9FUlIpIHsNCj4gICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRURVJSTk8s
ICJ1bW91bnQoKSBzaG91bGQgZmFpbCB3aXRoICVzIiwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICB0c3Rfc3RyZXJybm8odGMtPmV4cF9lcnJubykpOw0KPiAgICAgICAgICAgICAgICByZXR1cm47
DQo+ICAgICAgICB9DQpBbHNvIHRoaXMgaXMgcmVkdW5kYW50IGFuZCBzaG91bGQgYmUgcmVtb3Zl
ZC4NCldpdGggaXQgcmVtb3ZlZCB5b3UgbWF5IGFkZDoNClJldmlld2VkLWJ5OiBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4NCg0Kbml0OiAjaW5jbHVkZSA8c3RyaW5nLmg+IGNvdWxkIGJlIHJl
bW92ZWQuDQpBbHNvIGRvYyBjb3VsZCBiZSBjb252ZXJ0ZWQgdG8gZG9jcGFyc2UuDQoNCktpbmQg
cmVnYXJkcywNClBldHINCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
