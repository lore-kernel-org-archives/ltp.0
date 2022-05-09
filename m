Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C67C433F5
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 09:38:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F25D3CA927
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 11:38:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5D1A3C0E89
 for <ltp@lists.linux.it>; Mon,  9 May 2022 11:37:54 +0200 (CEST)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A9E321A0064F
 for <ltp@lists.linux.it>; Mon,  9 May 2022 11:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1652089074; x=1683625074;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r79OrsFF830hcWZc3a0Um/8eBO/iHbxqr8d5TLz8B1U=;
 b=qCiFQB9H/6cONjnCDd2M2HX+mb7S7gwRGgOT0A3hQ/DF1vyBCLpxKlvp
 qQfOd2MN1XrOdLawfSTKjnfPeVaKGLhmMcox48syAgwsxb2N2SN4G5+pX
 hH37IjFudJfljXXVrTPU1h+XG9eSoAAObKj7Hx9T0nWoJJfzlk8nLeWHR
 8bCqx4kiNy+Nxpmx1dAcGObmcn0reKJlCbBJucM4J/MEj32rukybpUEpf
 OaLkiCW2PzlMhQAPckHmrSNlHTwQZOpZYdNcE/2ZTYeug3YcMO7NF26AB
 +DVYh9smz04L/jfNKWh1lN2vTxEx1wIXgtMUmqIHOnvGwFIynX0pnd3OM A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="55437374"
X-IronPort-AV: E=Sophos;i="5.91,211,1647270000"; d="scan'208";a="55437374"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 18:37:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM04+DLFMnpyAsOAQd4joWFlsiD4kJF2wx/yUzQXYQeR1xMUSvb66gELPA1afXrOYroeofoBYseH5YlQCouMcdXWzQi9h6rUJBX9vFZQ/oqmxmeO28K0O2f5AJHXhIYZg8n3USU1j/+4402nD8WsXv2+rikI1wJrnueobFSjSL5PEffYGyDUGx+CopD2GcX5jbbtt4xrFRDNaL2KzmbsQCSzhZwX7zO6NALrjdFCntdR9AkMBBlZx7vO0Gslrf7Hzd0sdiPZ1ps0dcS+j5Q7SbQCtAhaDcv1ROfh4fPf5aScm/gXOAeEyOXQ46sxMeipzmW0KI9wrYvKPbRIZ8Pe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r79OrsFF830hcWZc3a0Um/8eBO/iHbxqr8d5TLz8B1U=;
 b=FbIUuYUVzBG/HIXx/EdqIJjepgUIszEwkd9MRH0gUx40CQP0PK70vLKVHCRbfXrK/RaArKkBey41OrJQGupj23mti6if95T0XSo4pKkxL/xJsaPat15IDVv8F6QMbdN36GJKMHzwnhjpxP2xLdTJTDwBnX9g5LlnqNrxUlR4UcLk3VjM085qwtd+s8DdY8kdelCKpjlbwsGWaxadomfFW6CKv0wl02jlR+gV15HwFzWmsSYtVxY7RAvP5RYcuciF/SEhr8xww5bJ4zOwtmIeHGY6ybZRA9YSv71bw0rYgHQ1eJ7O0T4SynDumTB2L4zlxVv6wrTIVmfGjIMKhCsgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r79OrsFF830hcWZc3a0Um/8eBO/iHbxqr8d5TLz8B1U=;
 b=Ok+y5aHVWWWdNDTwvDSW7rfbMWrNBocQnuJt0Ft9DWBdP8Gezlk21z5SrcjqjbOOXgInDYkDuP8TkpUYYvEod5qzLVjK5RAfohs9qZjoymO+GXNPFzNjIC3oV2ts50P/7i79ktEEjzStcAlzLJiBot8Ns4G5cm/Tgd4ViyRCnF4=
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com (2603:1096:604:f5::13)
 by TYCPR01MB10293.jpnprd01.prod.outlook.com (2603:1096:400:1d7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 09:37:49 +0000
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::c9fe:6f62:c297:b2b]) by OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::c9fe:6f62:c297:b2b%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 09:37:49 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "chrubis@suse.cz" <chrubis@suse.cz>
Thread-Topic: [PATCH v5] syscalls/mount_setattr01: Add basic functional test
Thread-Index: AQHYWvrmPg6882ihvUmxC+wmHfeXrK0WWagQ
Date: Mon, 9 May 2022 09:37:48 +0000
Message-ID: <OS3PR01MB6449A771390F50C2471A65A0E6C69@OS3PR01MB6449.jpnprd01.prod.outlook.com>
References: <20220428104642.110-1-chenhx.fnst@fujitsu.com>
 <YmqHdHHNSR+d4SLy@pevik>
In-Reply-To: <YmqHdHHNSR+d4SLy@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e20cacc-e6ef-4a0b-5368-08da319f94a4
x-ms-traffictypediagnostic: TYCPR01MB10293:EE_
x-microsoft-antispam-prvs: <TYCPR01MB102936989D8E341560EC4A3F2E6C69@TYCPR01MB10293.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNDQqC3VOBltho3V9dUAXrO4Fk1ooioK+BK3ycSfT8NhPBiIePxpGi2XLXm3n5kg7EnXIRmbVw72rO3UJ664eMIRGNvDKIwsgcRY7CRCDd1tVhHmoQ2qhXHxfR2pnaQFHFjXkim9W6AWSpgE91ehjiAiiH8q0WQQTRjistMTYlb/cGbAHt/1lQwFphSh3sn6whQcDsac3RE9DYd3UHYrXXh73sJ23lMEG9C5RyjWB307Y/PHgqIGwfLe4Jzfct9yLhLQag6b8SWclUXj1qbZdVkDlCjDBXm5gLBjP94kltnNOgtlPsVTG99UlwdBXmVBayMzH/HctO3xRNLcVutV9i1MNl1YVl8fB56AGS7SNpXCGJPEH4tolmugNsCdROcZJTOvZa158w8pMBLq5GDQ3INBBa0njl3F02LmCq6BaMpNOUa4eDuCaHF9uoWyWzji+PDt9C4HIqb+sX6KSZD7dUbKgbL09Y3Y0RjtKtVa6XLYy7qT6nv7EemVY/FGgxcQQ2T1w7W/QTYZe9tOTaNW/8xKr+xTOfgB1zUgP6W6ta+/ViC9Fx5ALZtEC0NeZBcLX93yUjyzjk/hjmGZZZsrA51CjI0voc6kKAab0gdrlMBMfiiRwDUmJbEnnYvRF4mCvw5rdzw47YzSECWwHbrAUHJqtmbxI8trNT1z8+87PXC0q82D7GgSwm3PbgH6Dmuy0bz4Hf/l07ujmBvpW9jdzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6449.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(224303003)(33656002)(64756008)(66446008)(66476007)(66556008)(54906003)(107886003)(76116006)(66946007)(6506007)(86362001)(186003)(71200400001)(4326008)(4744005)(55016003)(5660300002)(26005)(85182001)(38070700005)(52536014)(38100700002)(110136005)(9686003)(8936002)(508600001)(2906002)(82960400001)(316002)(7696005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eHhTM09hemZVT0xmd3IybHhGOC9Vc3R3SEtFNGhNQXNweldDVktFYTZVN2xO?=
 =?gb2312?B?UFBDWWlTUW9pSGtvNzIzOWFJOWlSSHp6cElTaTM3WmViaWlRYWhGMUsvU2ND?=
 =?gb2312?B?UTQzdmcxRCtReTlQZzVKdlRoMVBZNVBYclJIcEowK0wvZkxlam9vTVJSRUxB?=
 =?gb2312?B?aW9kM1VIMjgyTW14cytZUjg5dVFTT2FZM2Y5d2J3dnZhNkRNWGpoQUMzK3g1?=
 =?gb2312?B?bm5jVFdWZGU2c3gwSjFlWWpibW9BN2FERkRlamw0aHpRZkh4TXZPZU81eEU0?=
 =?gb2312?B?TUFLN1o5UGdlUVpPM09OenlZRFpLSmEyZDFQcThJUWdyQUEzc1lKMnZYcXpI?=
 =?gb2312?B?Yml6RTZKd01VUTVxMk9nRVpiRTRKYVZSY3VCTFliTUhOVXN2VWpPdmU5WFBi?=
 =?gb2312?B?N3F6UjRhOEx4TnhJWDV5S3FiaFNzZ2k3RzVzNDhYNlF0bU5YWkVpM0JFZytn?=
 =?gb2312?B?WncwdHkralhDWEFTeXUzUmo0alYyUTUrek0wUG4zZUI3dGtwdWpVTnJRK2Nx?=
 =?gb2312?B?bnRRcFFGR0h4UUVFSVVTcEVFazBuTGxBTWJwL2xMN3A5SnE0bDRBckJaQm5R?=
 =?gb2312?B?a29NUXdjdGVBdk95RmlHMGxIclAxcXpqN0dOdFRIR0JaOEhncmxGMlhSYmZ5?=
 =?gb2312?B?Wk0vMUdpaTI0aWRXZ1U3YTd3VStHa1hiNFhXWFM3RkN4cnlZMGt0SFZmaWU1?=
 =?gb2312?B?T2NoYTMxOGk0WFhFRHBYYkQ5LzBiWDBvWk5HbEMxZjMyaU5aQnRTdkM4OEpN?=
 =?gb2312?B?RWdZZktLb3VZeTU5UTVidHdGVXlrL0MvekNtWjJrN1dJN1lXbUlQNy8zdDdM?=
 =?gb2312?B?YnlxUGFuZUdFK3ZsKytHWWE5NkpoTkpZekpzMDdJMUovUHNQMTJWMkZQeFlV?=
 =?gb2312?B?Uk42Z0paUE0xOXVVQzB4QUJHdGZFbGVreWgzYUFaenF6Y0JsV05neGFkZVlM?=
 =?gb2312?B?R0I1K1kyb0hJRnZEQWlxQ2g1L1I2STkwQnZMbm9oZkdweUVTeGNXZDdmdmtN?=
 =?gb2312?B?TEVhRC91bTU0ZG1UZWkrVGJXakVUVU1UMnUvL243MnpaY3dEcVpseFdkNktj?=
 =?gb2312?B?ZnJRaVZJRjkyRkdtaVFsak4xUmNObFVYODYvdklYc0VjN0NHU2l0eVZTaXRz?=
 =?gb2312?B?WFprR2taMnppM201SWMrSy9OVmpUWWxXcEZ6eExDNW15eCs2emMwWkt3YmpW?=
 =?gb2312?B?bUUyUHErVHE1SkIxQVBUWjUrKzE5OVdCcEEyRXpsMCtWbUFEb1hwUDBtZk95?=
 =?gb2312?B?STJGcTlDSHdOc2NCeFJTdG1wUU1ubHVwTk1NdXhBMmNJL2JZR0dvelJXNFZw?=
 =?gb2312?B?Mm4yeUdLNzdZRWNwTmxpUEVnSURvM1lZOWdrbThxOW9xNVM4ZWxZMFRpckpo?=
 =?gb2312?B?VVdMV0N2eWI1UUNnakhsU0FON3lYZ1lHZzBqdVZTUHlkRk5rNkNNWEkzTlNC?=
 =?gb2312?B?Q21RajZuTzR4ZkdZNUlSRDlmRkdFRXpQVUsrT3UxRmZ2WkRJVVlneWwySFYr?=
 =?gb2312?B?TzBGRFRPMG1TbDF0NW9kSWR6Ry94M1JkeFNCNVJVRHJ5U1AxVjRsbFlhSUJz?=
 =?gb2312?B?MGlRYldlQk9vT3h4aE1SYy9nZEVmRC91QnR6cUZEZWpTVHoyWDlZNENuSWhJ?=
 =?gb2312?B?MVRHZ2RpbVRnWUhtWnNiNGcrVUdqd09GcEw4ZU5EdkhsbXhrM3d1emFuZzdp?=
 =?gb2312?B?cGVocTgvQ2NOK0tXYU16cnBSRW9Wam1XK3RkTlVza2RQOUo3QkxkRHpPSzBq?=
 =?gb2312?B?aHJ1MVBhZG5VMytlWTFsYUN3U1hiaGJVd1BVbXhnTjBHRDkvOWo0dDJFOEpO?=
 =?gb2312?B?RHBSRW5rVzdnWXJjek1xUnBJZ1Y0RWN4MW1FRDVNK09jaldzL2VNT1cxK2da?=
 =?gb2312?B?cjgzd2F3T2ZsdWNudFRkTUZianlKcTh4K1hocjgrOWZleHVUQ2txK0tZRElR?=
 =?gb2312?B?REZQNHE0aHdJZGxMWlRmd0t0QjFiZFdreU9URlFpNzdtTGhSakc0dXhCTnlt?=
 =?gb2312?B?enZLeEJ2YkpEUTQ4elBoLzhjNEpCaHQwdXB3dm5MTzlWS3NqaWNpUytqcVky?=
 =?gb2312?B?OUlndG9BTHJpNFNqQnZMS3JudEE5T1l1U0hDTE1GZG9sL3JadGtxK2g0M2Ni?=
 =?gb2312?B?TFVuOXFUcklUR1NSVlRZYkdkYWFNR3FoQmdIeHJaSm93Sm9idFJxaUVOcXpN?=
 =?gb2312?B?NE1obVlBQVBQNHN3UzVQa3pOQVh3cUV6VmZTRGJRWlNjTEZGckkraklSNUor?=
 =?gb2312?B?SXo5eW1CNmRwTlcybVh2bWFaeUd1L25OazMzTDdlQWhTdEFWTGFjM0NhNzUv?=
 =?gb2312?B?MGkwY0dXL3RRSkg4RTZJeGpMUHJDSjFHSHJLVmlZdDgvZ1RSa1hEQT09?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6449.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e20cacc-e6ef-4a0b-5368-08da319f94a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 09:37:48.9079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTJxzSsU2OLxYMDXgcQn6gpChPqBnV4g9iVCcbW/mmKzNe5lWi3v6FJzPuBClKRpN9hggPkRm4Ky9gw/KBgkWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10293
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?u9i4tDogW1BBVENIIHY1XSBzeXNjYWxscy9tb3VudF9z?=
 =?gb2312?b?ZXRhdHRyMDE6IEFkZCBiYXNpYyBmdW5jdGlvbmFsIHRlc3Q=?=
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

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+DQo+ILeiy83KsbzkOiAyMDIyxOo01MIyOMjVIDIwOjI0DQo+IDxkYWlzbC5mbnN0QGZ1
aml0c3UuY29tPg0KPiDW98ziOiBSZTogW1BBVENIIHY1XSBzeXNjYWxscy9tb3VudF9zZXRhdHRy
MDE6IEFkZCBiYXNpYyBmdW5jdGlvbmFsIHRlc3QNCj4gDQo+IEhpIERhaSwgQ2hlbiwNCj4gDQo+
IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gTEdUTSwgd2FpdGluZyBm
b3IgQ3lyaWwncyBmaW5hbCBhY2sNCj4gYmVmb3JlIG1lcmdpbmcuDQoNCkhpLCBDeXJpbA0KDQoJ
QW55IGNvbW1lbnRzPw0KDQpSZWdhcmRzLA0KLSBDaGVuDQoNCj4gDQo+ID4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnRfc2V0YXR0ci9tb3VudF9zZXRhdHRyMDEu
Yw0KPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudF9zZXRhdHRyL21vdW50X3Nl
dGF0dHIwMS5jDQo+IC4uLg0KPiA+ICsjZGVmaW5lIE1OVFBPSU5UICAgICAgICAibW50cG9pbnQi
DQo+ID4gKyNkZWZpbmUgT1RfTU5UUE9JTlQgICAgICJvdF9tbnRwb2ludCINCj4gPiArI2RlZmlu
ZSBUQ0FTRV9FTlRSWShhdHRycywgZXhwX2F0dHJzKSAgIFwNCj4gPiArCXsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gPiArCQkubmFtZSA9ICNhdHRycywgICAgICAgICAgICAg
ICAgIFwNCj4gPiArCQkubW91bnRfYXR0cnMgPSBhdHRycywgICAgICAgICAgIFwNCj4gPiArCQku
ZXhwZWN0X2F0dHJzID0gZXhwX2F0dHJzICAgICAgIFwNCj4gPiArCX0NCj4gbml0OiBUaGlzIGlz
IGFic29sdXRlbHkgb2ssIGJ1dCBJJ2QgcGVyc29uYWxseSB1c2UgdGhlIHZlcnNpb24gZnJvbSB2
Miwgd2hpY2ggc2V0DQo+IG9ubHkgLm5hbWUgYW5kIC5tb3VudF9hdHRycyAodGhlIG9ubHkgcG9p
bnQgZm9yIG1hY3JvcyBhcmUgdG8gcmVkdWNlIGR1cGxpY2l0eSwNCj4gd2hpY2ggaXMgbm90IGlu
IHBhc3NpbmcgLmV4cGVjdF9hdHRycykuDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IFBldHINCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
