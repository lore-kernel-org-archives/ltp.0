Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39902C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 07:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723186837; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XLJGWA26Cg0Cd29Tq3Ipyrm59h9KJXNVffwLoykfQCk=;
 b=GJ4g5QRtbMznEY6/5DykvoaKyu2tWYGdyZvOCAJk9/cLeft/Yq5Q7O3MgLw/kOV/HQoFC
 Nx0R7OHUqvDfTseEVnRf2scB69YUkzYKxiF8MsBzy8RvYe/+qU7SjiOsO5n39yARVps7Fjf
 FnJ9wwGFUZaEw5QYZHMGdMw55hg5jkk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91BBC3D209F
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 09:00:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 400213D2031
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 09:00:13 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.156.107;
 helo=esa15.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 41B691A05C96
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 09:00:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1723186813; x=1754722813;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mcCPL5+Xj9yzmm3M3vRdGJb+TiUJxJt7YtIbsCR2k9M=;
 b=sUkfn/IzwljS1yuHGZFB3apBImqSudGEH2Ga2tpFwBW3VeLh+DTfsRDZ
 nUsJYNdsRII5xfS8HZa4H8J286s1I7+FXYIqprhW44mVLapQY52IhRV2h
 piakvmNyP6qrxIHUyEt78QrKiURvdaohu5VoaUevrpBkkTIL9UBNRUC3T
 7glr9pw06sHIr1K1RAp5nhxgm4yjwrej7BqXWQhXUJieKcPcHOYeQSPCa
 0Sg79t3L901xN7eGHOd+3FkMMrB9IOhFRh6XrRp4RSJX44SyN+OH8DzQ6
 SWrR9eAhDbXpVcai6EZKfg0T65PPTPVAr/IrM0SJVLn2htf83YMCuLSju Q==;
X-CSE-ConnectionGUID: T8Xl8uy3QKuS/rlz9EJ5cQ==
X-CSE-MsgGUID: GTI1v7NZSemnCe8Pta1kXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="128060338"
X-IronPort-AV: E=Sophos;i="6.09,275,1716217200"; d="scan'208";a="128060338"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 16:00:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaBVfOc3BaSlSXhaGLY9T3qnGRPXlSf0sqPvpBosp1tMH/hr8FGcnMp2ukhgpg6yGgkjXiLVGe2Sg7IXGbWhxQWrGH7HdeoA+s2Pdy6kYS1gUJ7aNkjboE6Hhh+/FcTlc8MIsQbXcFULDNg89JJuN0x7rdNPScnXiNY3mpRnIxFoBeKsxyXIE2PreAmWwMjFBH4o93WuofoTcBwLzXe1+0T8/emVdW5huNMjvcUbkCHDdCIJfPI5YnY2ldmEhNxu0ixrcZ1q5Ffg+1Hwek597vEl1tGdWT9t/KARJj2ivC0/33WVS+SYw4FWfhvNTUXxjHUqgf/bUD3h5/qyPDp0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcCPL5+Xj9yzmm3M3vRdGJb+TiUJxJt7YtIbsCR2k9M=;
 b=XbkYHJxTnD5+P5qCuIhx7arjx9ZZoNI8A35hNUqNZ55DpR6R/aHfDiXGAqn+BTDshMMt6cV+1JwanzeF5rOBSkywDdTQVjKwUDZ48vNb7ouUjYuDaue2oE8HO8HoaQjjvu8v6wVn1e4vx05F2oKyBbDLpX/5+/mjm76MONPoZ8EBUoXj5FEE7kW64ocL9groCZalidCmIaJp6vtqFy7MsyT4NuqG2aHmnw2L37l7eYtZibkCSw0npKrzlkutX5GgV/IQ7CvxIWLtnP8SPj9aqZA4kpwJseICCMbW8GhFUqgAC98owoqHu84qS6iU0PJ7Nmre5dBRMx4wFo3w74F7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYWPR01MB11963.jpnprd01.prod.outlook.com
 (2603:1096:400:402::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 07:00:06 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%5]) with mapi id 15.20.7849.013; Fri, 9 Aug 2024
 07:00:06 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v4] getcpu: Add testcase for EFAULT
Thread-Index: AQHa6L200wealHAAy0GzPRzcjVd3x7IdFfOAgAACcgCAAWfUoA==
Date: Fri, 9 Aug 2024 07:00:06 +0000
Message-ID: <TY3PR01MB120715C57725D50D05B4266B9E8BA2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20240807113601.3882356-1-maxj.fnst@fujitsu.com>
 <20240808091657.GA313341@pevik>
 <1611646b-eac8-4b21-98ed-77f95279dacb@suse.com>
In-Reply-To: <1611646b-eac8-4b21-98ed-77f95279dacb@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9Y2IxMWRkODctM2EyNi00NDY3LThkYjItMjUwMzM0MzEy?=
 =?utf-8?B?MjIxO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA4LTA5VDA2OjUzOjUzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYWPR01MB11963:EE_
x-ms-office365-filtering-correlation-id: b4ec64cf-75fa-4790-e5ee-08dcb840e656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZE14UGlwQW9jSGlZeVNNMUl1Zjc5UTlKREJZdzlWVDRwNGFNcFB2L3kzRFNx?=
 =?utf-8?B?eUJZM0hoSCtWQUZlTkhkRUN2RGpVZjlpZERZdG41OW5mcGhUelNaM3AyUVdU?=
 =?utf-8?B?M2hzaWNpRFcreUo3SUVoUWhhOXBOcG1Gd1V1OWZSaHluTXlKL09TWVFXaFlr?=
 =?utf-8?B?c0JRSHZGWUZEK01ROGtyR1dXbkxobnJheXdWTDlqcUNJTi96RytEeUFUNGNL?=
 =?utf-8?B?WUUzaFNGVFFrWTFNYmp1aDJpS3lVOUJPcitqY0tseVBXRkVETTk3NENZZGhC?=
 =?utf-8?B?eEZnQzV6REdkekNJWWJ6NndsU2JYY1EySUl4K3JhblYvR3h1NE1zTC9VemFL?=
 =?utf-8?B?RWV2dG1CMWlZV2pIdmhpWUhram5FbHF3ZE8rQ1ZRSEI5emsxZXgrUFMyajNP?=
 =?utf-8?B?K2hZZ2FUMEViaTZBRUxZRVpXclRYNGFUSGxIUHNrUzFXb3ZVeUtoSEg5ZFA4?=
 =?utf-8?B?S2plWnNnMUpMUmpjdGQzcURNY2JldTl3Umo1Mnl2UXBmeXlvTldxQisyVlo3?=
 =?utf-8?B?NXR0UFhWRzdGWWtrVzNaRTU2MFFhVTFrYTU2dXVBei9BVVdMYjl3elIrT2Rz?=
 =?utf-8?B?cHBJVC9ETjdaMkhxb0ozdC9zVWYzZUo0TGRPR21SOGovY0dHZmRCaWZoVHoz?=
 =?utf-8?B?MFowNEF5NUJQN1Npb1p0LzZlTFdPdURLTjd3WVJHbVJsUVJiTVluME1VWEF2?=
 =?utf-8?B?VCtPOVhJSzFwZEFmVE92a1FBY3YvT2kwMDFOT1U4MTNVOEhuQzJadGgxWGtY?=
 =?utf-8?B?a1hSOEdYN1k5cGd5WlIxM21QYyt6dnhqQWl1U0FsVnhoWUVJOEJ6S1FaZEhv?=
 =?utf-8?B?bnhHbklVblFNQ3dNM2g0cnpmbyt4SmNTMTBUMDFqajZpeVAyU21MbW1uenRY?=
 =?utf-8?B?anlQd1BoYmtrTml1NlowM0oxd0czeFdBWDlnaXdEa25BZ0tKZzBDenlvNTZ5?=
 =?utf-8?B?eGtwT0djM2QweEdDK0VOMk8yWllsMVUrQVhEQXRGUWRDQVh5OTFibTJNOWJl?=
 =?utf-8?B?V3NEdEg1Q0wxY1lGS1hjZExHeXZGZjNRWmdnTW4rdUNWOGNXZm01ZlFoWDQ5?=
 =?utf-8?B?dUlveUs1b0FZd1Q5U1ZJZFpyNVcwV3NjYWM2WmEwV2dwcklQSWp1azhtZXhJ?=
 =?utf-8?B?d1pxb3JmcW5DUnUvQVdQamU5ZWhxNko1b3lsZE5CNjhFU2toWFRWeDBOQ0ly?=
 =?utf-8?B?Z29hM2lBaE1pSllLSHVXL3BYemNzdmJNUEc2MkhsbXdYVHVIb1FRTG15Z1lw?=
 =?utf-8?B?ZTkyTW5VSlVwaXpBY0grcHltWVVaYmFkeS9JQ1JzWGxCc3duTFdnL2JSeGZW?=
 =?utf-8?B?VE9RSkliRUxOczJGZ2V1eTE3akwxZHZxVEhYMWczYmF5M3l6VTFyaWhEZ0xw?=
 =?utf-8?B?QlhwMFpBTDVaQ0lMd294Mkc2bnB3L0pSUjZldklTS29INm5mbE4reGRtSG5h?=
 =?utf-8?B?UU5HcVVBdkl2V0ZkOG45cExtSzJVS2k2clNWNC9ZbTdzU0tsZGM3bHMzY2Q1?=
 =?utf-8?B?Tm5tclRBZ3R4SEwxV3BvNlB1dEtmeVVCQWxRVnRWZ0o0THVZKzdOSjRZdmZ2?=
 =?utf-8?B?b0Q3YjloTExDc2pqYXhsRnNacU1EN0FOdWpoZys2T2NCYi9vYmgyUmE4cldo?=
 =?utf-8?B?ZUxvY2F5NUFkc1dxVVVmVk81WFV1UjRZeXFlYmpyUGN2akJ6R1R3djRiWG1S?=
 =?utf-8?B?M2hUb3gzbFR3K05wYlRZSzcvS1ViWlhIdjZmVlR1RUFVM0FwbGFKeVl3V0Qz?=
 =?utf-8?B?MDlLNXdVTjBtQ2ZOcGxrcHkrQ2s3S2Mzc0pMamx4YWhFbzU1UWFhTXhsN2w1?=
 =?utf-8?B?UEdyNFhURnZBdUxKdW5Oa2d6TlZGSE9weHRvSVhocW9BY1k3bDZLUCtNY1Fv?=
 =?utf-8?B?ZEE5MFRvTzVhWURBN2s1NVdlbTN2ZHFmY0I5dTZsSzkvZ0dKS2lRTWdFWTVn?=
 =?utf-8?Q?x9cHTyLeX70=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elA1OGlOMWg1Rm03aWlmcVJXcmJmckZTM29Db0kvYmxDSVRmUjN5NTVTTjdk?=
 =?utf-8?B?allaZjJSUmxRMk1OVjVxRURsajl0QTBSbEcvbnFnK0kwZWt1Vk81UkV3QzFH?=
 =?utf-8?B?TFdjeWtkelRhek12UlRiTVVnNUp4aGczWGFNcG9WV05HMkY2Vk5ieE5JYTVt?=
 =?utf-8?B?dHJZK0pQeE1MRjhSTnQxc1hiZjlucnUwK0V2V3VET004elVhM0llaDdyUDRS?=
 =?utf-8?B?Q1RGYXdkak50Q1N4R0MyS0RMdmo5V1hBRjBXOGpQaE4wakw3dVJ5NTV3bFhW?=
 =?utf-8?B?Zm5DZHN4N20wTSswUm1rR05JYzZIVzJVUVYvWGt3dWVEbjdZQVdTcVdrYldr?=
 =?utf-8?B?WEpCWGpCZmtyL2tZUEVFZGlsdk1IandpMkpuRnBiOEJHaW1zRGFZOUtURVdj?=
 =?utf-8?B?MHBpVWlHWTNiR3R6UDZZMDllNFZiTjZ3ajVJTyt6R0l1MU1UeTFta0txajMw?=
 =?utf-8?B?RkM4c2EyMTh6dGczYWFZdjNoc2t4aFlzSXV5YzJmYjdmbDBnTEQ5bDNXTnRV?=
 =?utf-8?B?ci82dHdDUFNXc0FXQmducndJSWRlVklPb3dzZW1Kd3ZTVXROcER4bjdrQWc5?=
 =?utf-8?B?SnlHMXZGZ0VzMWtLVjdZTnBxYlA3R3V4Wk1pT1hnQlRRM2JFa1dBMW5zQjJP?=
 =?utf-8?B?N3JkQXNXRWR2YlFqVXlOM0lBOTFsTndvTGJFVVFTY21ONjBsVEZNWnV3TUVl?=
 =?utf-8?B?dVVjRHAwOXBDSEJLcFhyYkRISlBPYkZkaTlHSjl0RVJuRFV3TlM5cFZnYXdn?=
 =?utf-8?B?K0Qvb1Z4YzZBd0N0MFZPNzdVdlZtMmhNbjM5ekpaSEh2QXhKYVh1U1ZteWtF?=
 =?utf-8?B?RDQxN3dvbXlZRnhobjd5cGlVd3liUW5jRDlpNG1GTmtWRHh1ZTY1d1dxdVg1?=
 =?utf-8?B?Q0tzZEVxTHFoU0s4eTl2L05qaFB0SUpGZk9QYXMzN1lCRnhmUFludVhrUFZZ?=
 =?utf-8?B?azl0NGtiS2MzbDdDTlRmVjNLekpMVjVRYjd0eXRmK24zWEJrNjk1OGVuSHJG?=
 =?utf-8?B?bVVmSzRIRDdRM2RyZjdZOTlYOW9TUnNDVnNBU0ZoWXd0V0tmUXRuRVVydUFj?=
 =?utf-8?B?WWhkOUVuKzJMMWZIdTViQ015bWlzN0dlZ3paWGc3V1VqMWlUWG5QQjVGTndt?=
 =?utf-8?B?MkpzR3ZITzlVMUZRSTQvdld1NU5KbnE0elRtZEJicXNrSm8yNTV3dnJweXpN?=
 =?utf-8?B?S2ZWWU5PWDFza3ZvNzhPOHlNKzM3MCs0RjNkeGRMN3hFaDFJVU9aU1BSMU1D?=
 =?utf-8?B?OG56cWQ0b0cwNDNZR0RJM1B6d1VFZGZYbDBkRkQzQ1FHZGxyZURvV2xqV2M4?=
 =?utf-8?B?cWlIODhvVUYyeVI4WTEwN2h4UmNlOHFhbFlYU3hXZ1o5MU5sY01NbTFLWHgv?=
 =?utf-8?B?QXd2eVB2cW5XRyt5dGdrRFYvVVBJY2pLK0hGWjJaZTJFRzh0REZnNjFxZFYx?=
 =?utf-8?B?VjlTODlhWmh3eFMzTkFOTkxiODNSbGdzUkgyRVMvZ2hRQ0ZYczQ1cndXdWVi?=
 =?utf-8?B?KzNtMFk1N2o3eWljMkRNK3VrcUdyYUs3cUdzRzVQVUFTb1NJUk0vdFg3dFNw?=
 =?utf-8?B?V1Y5bC94L3BrK3A2YUVmQ2g3TEE5L0ZiVFRMckRYUDFBUmZ6MGJJQ3lBZmhW?=
 =?utf-8?B?a2VXOTFrWGlzWnQvamhlaDQwM1lNV280bzhENTl0dGNMdlJPdkRRQW8xUHBJ?=
 =?utf-8?B?WWZOaGVmNzEwMG52NTNXOStmRTBNRTFaNFlseVYyaXdlbWpSM2lBV0llRndC?=
 =?utf-8?B?QUtzd0JRTmNYa2lOOUZrSlYrRERaSlExUzVBbm54OHpKQXJpYmFZUE8xQXp4?=
 =?utf-8?B?MDBLQ1Q4Zk9obldWRVZXSDMzbmZwZXc1V25LMUdmS21ubExuK01PeWFjY2Vk?=
 =?utf-8?B?YlFtZlQ5Wk8xZWZQWWh2UGtyNk1iTzhpTHFvc29mYzZZaVY0TVZGc2hkUjdl?=
 =?utf-8?B?QWt2NmxkSEFVdnZYQ1hBcmQxdS9iVFlRdVRRdHl6YytXU0dLemJtcWV4TFhB?=
 =?utf-8?B?dVE3b3Bla2pQeGI0c1R0djljWjFHakFZdXowY05jcmcwZTFZOVVYNlB5WHVt?=
 =?utf-8?B?M0hsbEZNTDZ0UlNmR3NaY2pXb1JvczY2bGZwMms3ZTVNNlRXeW1vYWV5U09L?=
 =?utf-8?Q?tJ0Zbn+dY9GqMWD0IJE7hcxNA?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bKkWgILYwohFqKa1qaS3+jkjSPNsC/U5Xv4AyIIeXCC2Vel/g27Q+EZUhrbuHFBHtACxDSH2lMNpOFm3kCy6WIuJyZ2ezASivit+G1VlqhpAqHHWwja3IOPPg0GFnAZulSxI2V8xrXFVMsJbLC2Ox/FM5bLpfWTcY/MYkZ8PtvPvKjfFi3lLbmDKNY4cj+fHFS/h5sm6OVKrncvdcoUfeWVkIt4qUfFRQuNCY8DGxe5EX3XiGkFEpaDWfobbPrVwZRD6zgsnpURko0lH38rXICLvDkoAqw/No0IUyd5BjPFDxNYBaWze1qJlJ8xT5XX5rC4KC/8IE0dzQotmsSQuyeJUycUqHIwGi9fh5pYvITVER8iQUM9BVSLW1OgQQ7hQqobe2rKq234zVH0X8NfFMGakhxwlMMf8bxZlTJLUgHC2T7S2xTRKa9svRdKU5rr8hIgwMFCF1wny7GPjmflg8ZQvfx7MB4Cxz5khw3OtonEsKMsqdluEA8RSdRE6VwawkpbHL18JU2Z27girlu2nmmqhowjWeEx+P0Uq8kyaezRWyXWfxDC5uvsn21TtKVPNGC+4JkfSAsZAQQaMJYH/8y0Y1S+JEzyYOYtaPJfRNc1VOFsYGJAhb5OmzsvOc/Qx
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ec64cf-75fa-4790-e5ee-08dcb840e656
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 07:00:06.1132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2A6vedL9vEZpbN2guGkHw2Yt+BIXLQg5b/eaVQLyunMHVI0dp23nmtH1IsM/vFkqqdgE8v6t4lW6L6WKtuOF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11963
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] getcpu: Add testcase for EFAULT
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
From: "Xinjian Ma \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Xinjian Ma \(Fujitsu\)" <maxj.fnst@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Ma,
> 
> 
> On 8/8/24 11:16, Petr Vorel wrote:
> > Hi Ma,
> >
> >> Add a testcase with the arguments point to an invalid address.
> > Generally LGTM, I have few comments, but I'll fix them before merge.
> >
> >> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.de>
> >> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> >> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> > @Andrea, Cyril, feel free to have final look during today (otherwise
> > I'll merge later today).
> >
> > @Ma The test has changed 3 times quite significantly. IMHO it's better
> > not to add Reviewed-by: unless you change just either simple thing or
> > did changes you were explicitly asked to do. Better is to --cc all
> > people who did the review when generating patches with 'git format-patch'.
> Yes, please add Reviewed-by tag only when the reviewer replied with the tag.
> That actually means "patch is ok for me, so it can be submitted"
> instead of "i took a look at the patch and it needs to be modified".
> >
> > (It's good to add Reviewed-by: if your patchset has more commits and
> > some of them were previously reviewed and they are unchanged in the
> > following version.)
> >
> >> ---
> > Also, not needed, but it helps, if you wrote some changes to the
> > previous version after these '---' (it will not be part of the git
> > commit message when other developers apply your patch with 'git am'.
> >
> >>   runtest/syscalls                            |  1 +
> >>   testcases/kernel/syscalls/getcpu/getcpu02.c | 71
> +++++++++++++++++++++
> >>   2 files changed, 72 insertions(+)
> >>   create mode 100644 testcases/kernel/syscalls/getcpu/getcpu02.c
> >> diff --git a/runtest/syscalls b/runtest/syscalls index
> >> b8728c1c5..1537b5022 100644
> >> --- a/runtest/syscalls
> >> +++ b/runtest/syscalls
> >> @@ -448,6 +448,7 @@ futimesat01 futimesat01
> >>   getcontext01 getcontext01
> >>   getcpu01 getcpu01
> >> +getcpu02 getcpu02
> > You miss adding "/getcpu02" into testcases/kernel/syscalls/getcpu/.gitignore.
> > I'll do that before merge.
> >
> >>   getcwd01 getcwd01
> >>   getcwd02 getcwd02
> >
> >> diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c
> >> b/testcases/kernel/syscalls/getcpu/getcpu02.c
> >> new file mode 100644
> >> index 000000000..859cb0d3e
> >> --- /dev/null
> >> +++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
> >> @@ -0,0 +1,71 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> >> + * Copyright (c) Linux Test Project, 2024
> >> + * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
> >> + *
> >> + */
> >> +
> >> +/*\
> >> + * [Description]
> >> + *
> >> + * Verify that getcpu(2) fails with EFAULT:
> >> + *
> >> + * 1) cpu_id points outside the calling process's address space.
> >> + * 2) node_id points outside the calling process's address space.
> >> + */
> >> +
> >> +#define _GNU_SOURCE
> >> +
> >> +#include "tst_test.h"
> >> +#include "lapi/sched.h"
> >> +
> >> +static unsigned int cpu_id, node_id;
> >> +
> >> +static struct tcase {
> >> +	unsigned int *cpu_id;
> >> +	unsigned int *node_id;
> >> +} tcases[] = {
> >> +	{NULL, &node_id},
> >> +	{&cpu_id, NULL}
> > I meant to add char *desc here instead of tst_res(TINFO later in
> > check_getcpu()
> >> +};
> >> +
> >> +static void check_getcpu(unsigned int n) {
> >> +	struct tcase *tc = &tcases[n];
> >> +	int status;
> >> +	pid_t pid;
> >> +
> >> +	if (n == 0) {
> > It might be better to check this as:
> > if (!tc->cpu_id)
> > (set cpu_id only if not set.
> >
> >> +		tst_res(TINFO, "Make cpu_id point outside the calling process's
> address space.");
> >> +		tc->cpu_id = tst_get_bad_addr(NULL);
> >> +	} else if (n == 1) {
> > and here either if (!tc->node_id) or simple else.
> >> +		tst_res(TINFO, "Make node_id point outside the calling process's
> address space.");
> >> +		tc->node_id = tst_get_bad_addr(NULL);
> > Also, we usually try to set values which does not change in the setup
> > function (because one can run test more times, e.g. 1000x with
> > :/getcpu02 -i1000. Thus things which don't have to be repeated go to the
> setup function.
> >
> > But when I tried that, even without setup function, using this pointer
> > always causes SIGSEGV (test passes). And I use direct static values it
> > does *not* cause SIGSEGV (test fails):
> >
> > static unsigned int cpu_id, node_id;
> > static unsigned int *p_cpu_id = &cpu_id, *p_node_id = &node_id;
> >
> > static struct tcase {
> > 	unsigned int **cpu_id;
> > 	unsigned int **node_id;
> > 	char *desc;
> > } tcases[] = {
> > 	{NULL, NULL, "none"},
> > 	{NULL, &p_node_id, "cpu_id"},
> > 	{&p_cpu_id, NULL, "node_id"},
> > };
> >
> > static void check_getcpu(unsigned int n) {
> > 	struct tcase *tc = &tcases[n];
> > 	int status;
> > 	pid_t pid;
> >
> > 	tst_res(TINFO, "Test %s outside process's address space", tc->desc);
> >
> > 	pid = SAFE_FORK();
> > 	if (!pid) {
> > 		TST_EXP_FAIL(getcpu(p_cpu_id, p_node_id), EFAULT); // this would
> always pass
> > 		TST_EXP_FAIL(getcpu(*tc->cpu_id, *tc->node_id), EFAULT); // this
> > always fail, even for none
> >
> > 		exit(0);
> > 	}
> >
> > I guess I miss something obvious. Therefore I suggest to merge (or see
> > the diff below).
> >
> > Kind regards,
> > Petr
> >
> > static struct tcase {
> > 	unsigned int *cpu_id;
> > 	unsigned int *node_id;
> > 	char *desc;
> > } tcases[] = {
> > 	{NULL, &node_id, "cpu_id"},
> > 	{&cpu_id, NULL, "node_id"},
> > };
> >
> > static void check_getcpu(unsigned int n) {
> > 	struct tcase *tc = &tcases[n];
> > 	int status;
> > 	pid_t pid;
> >
> > 	tst_res(TINFO, "Test %s outside process's address space", tc->desc);
> >
> > 	if (!tc->cpu_id)
> > 		tc->cpu_id = tst_get_bad_addr(NULL);
> >
> > 	if (!tc->node_id)
> > 		tc->node_id = tst_get_bad_addr(NULL);
> >
> > 	pid = SAFE_FORK();
> > 	if (!pid) {
> > 		TST_EXP_FAIL(getcpu(tc->cpu_id, tc->node_id), EFAULT);
> >
> > 		exit(0);
> > 	}
> >
> > 	SAFE_WAITPID(pid, &status, 0);
> >
> > 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > 		tst_res(TPASS, "getcpu() caused SIGSEGV");
> > 		return;
> > 	}
> >
> > 	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
> > 		return;
> >
> > 	tst_res(TFAIL, "child %s", tst_strstatus(status)); }
> >
> > diff --git testcases/kernel/syscalls/getcpu/.gitignore
> > testcases/kernel/syscalls/getcpu/.gitignore
> > index 31fec5d35e..cd3022bbb1 100644
> > --- testcases/kernel/syscalls/getcpu/.gitignore
> > +++ testcases/kernel/syscalls/getcpu/.gitignore
> > @@ -1 +1,2 @@
> >   /getcpu01
> > +/getcpu02
> > diff --git testcases/kernel/syscalls/getcpu/getcpu02.c
> > testcases/kernel/syscalls/getcpu/getcpu02.c
> > index 859cb0d3eb..83d236a78c 100644
> > --- testcases/kernel/syscalls/getcpu/getcpu02.c
> > +++ testcases/kernel/syscalls/getcpu/getcpu02.c
> > @@ -9,7 +9,7 @@
> >   /*\
> >    * [Description]
> >    *
> > - * Verify that getcpu(2) fails with EFAULT:
> > + * Verify that getcpu(2) fails with EFAULT if:
> >    *
> >    * 1) cpu_id points outside the calling process's address space.
> >    * 2) node_id points outside the calling process's address space.
> > @@ -25,9 +25,10 @@ static unsigned int cpu_id, node_id;
> >   static struct tcase {
> >   	unsigned int *cpu_id;
> >   	unsigned int *node_id;
> > +	char *desc;
> >   } tcases[] = {
> > -	{NULL, &node_id},
> > -	{&cpu_id, NULL}
> > +	{NULL, &node_id, "cpu_id"},
> > +	{&cpu_id, NULL, "node_id"},
> >   };
> >
> >   static void check_getcpu(unsigned int n) @@ -36,13 +37,13 @@ static
> > void check_getcpu(unsigned int n)
> >   	int status;
> >   	pid_t pid;
> >
> > -	if (n == 0) {
> > -		tst_res(TINFO, "Make cpu_id point outside the calling process's
> address space.");
> > +	tst_res(TINFO, "Test %s outside process's address space", tc->desc);
> > +
> > +	if (!tc->cpu_id)
> >   		tc->cpu_id = tst_get_bad_addr(NULL);
> > -	} else if (n == 1) {
> > -		tst_res(TINFO, "Make node_id point outside the calling process's
> address space.");
> > +
> > +	if (!tc->node_id)
> >   		tc->node_id = tst_get_bad_addr(NULL);
> > -	}
> >
> >   	pid = SAFE_FORK();
> >   	if (!pid) {
> Regards,
> Andrea Cervesato

Hi Petr, Andrea

Thank you for your patient review, I have submitted the [PATCH v5], PTAL.

Best regards
Ma

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
