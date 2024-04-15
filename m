Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C347C4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713202681; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5D+vj1TZm89nCT5DfZoTgry9V84z5WbxtN2btlUTGkw=;
 b=Sx5w9tsnPO8Mw2ZxA491UWKaA/p8JVOIhzQsRaj8m2+orrWQAXxrjR3K7iVPYUng+2Oc/
 tM02GLhBUPRXlG7UHzJIumL9OkjTekHlb+DKqVNWMd2dlbkzj2LxlUSSuznBCZTuwXE7Bbd
 kNx4fp1gGz7KFiw75cT7D3gYMN0gO2M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1B073CFA3F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 19:38:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBD0D3C0705
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 19:37:39 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 374381A00E08
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 19:37:38 +0200 (CEST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43FDY08S021420; Mon, 15 Apr 2024 17:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hcbC87DNENJ0jtWzaKM4TGBhnuXfEwc0C9VJuYBrQTo=;
 b=XP6WTue7mTNhevJgF2XME7mnJxr9YJ5N446wSqppbn/CWbbmlZrIG4fR0YxBinLew+w+
 oVsEU1i0tS7zt6mAevkqQ/MV51RtVudUCKKm1DQeKDY/scSgLP0spzcmIGeBC5ujHMQs
 Zd1kHFFGKlDolxQXjNNJrBM2t8iUAn3JcSjzgKhnZYb1hG5zopZbERpW46e10R7MA94E
 YUBajf3UPrFDHDLmvC5W83K+gCEKJB+Xinsus7zMyzvJtxcAAdrTrZHmhjs925+uRpUh
 7t9jsH/MyDYn+2Bp+ROLfkPmwnWkpJw9FAHZipfl+qByOONBRCC7Noq8t0R7ozNcte7f uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e3ebe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 17:37:33 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43FHZiqc012602; Mon, 15 Apr 2024 17:37:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xgkwdyuwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 17:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI4yj3OAcWV+/UWmgVXXN8pfzuyEBPx5Ukws3SJJgOJQxaShnYU2LvLju05G+19DsBlFSbhocKuf5AGBTNekmKdn2+gai28T6MNHZ6wCqKoqq85ZdewEVZGY7r57nzCgRpUqbLQ3tCZvCT1bBF/c+8qlGrmLkPmT8rnV1y4pVn5pvbqWydRebea1JtCo0/Iw/TDQOhNE1cnjtMGzEnmFmQqf+5A9eiSrD4pxY2A39Zn/F1+5U4i4vmnta/4O906JYIKy6mYJzpklz8LLDp6kMgpWy7uakc6M/DYWYdzCGSYNUcxFLhC5OK9iqj7ImWyB9biEzvSCkGzNko4eSpJ5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcbC87DNENJ0jtWzaKM4TGBhnuXfEwc0C9VJuYBrQTo=;
 b=lpc/YztdZOEDFVY7HHWyh6iW9IjFBxtAjpc88zdbL7co3wDuyduMnW+AxEeeKgDWBBwfFcCwc7RgxrMVbsg0Obt3wUnMH6ArrBUwL0pgTgWuzVhiPZmwETlYAHysOrphK0X6Oty6uTeuDqRC3/cA+GK4ilksx20brjRUrK96B3ltx6PdpITVdOASU9Aobk8K/Qv7gYYCYu9m9JCGv4yl8Yx/CKN4cQhidMxUC2mrl7j0ARpc1ImH706vgNEdy1yBTPwR7VsUpAYCPbfAucUNqq41DcgX4OsHoztnOH2SDqw6wMbRpWDZ7NT45p2TME0Beq+nIaV4t6N74IvMMJJLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcbC87DNENJ0jtWzaKM4TGBhnuXfEwc0C9VJuYBrQTo=;
 b=Cz84TAYZnTn4ldgliEF7hmqOOon0NYBF73UA2UBxU+hukrZgPkeCEuDMW6W9QyElrYd3N8KF++350OLMesIp5GN3G4z+Es9bm2FNjerWCgDqn8vkVM5iy8Q8imgtynFEki9RM+1T/poiYiFLsfQIbpMqUVj+kybU+NraZn83dlE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5641.namprd10.prod.outlook.com (2603:10b6:510:f8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 17:37:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 17:37:29 +0000
To: Jeff Layton <jlayton@kernel.org>
Thread-Topic: [PATCH 1/1] proc01: Whitelist /proc/fs/nfsd/nfsv4recoverydir
Thread-Index: AQHaj1lsRxICZAWslkS4frAkXqLFYbFplaCAgAACPICAAACPgA==
Date: Mon, 15 Apr 2024 17:37:29 +0000
Message-ID: <6820832A-9F38-4DE7-8EE4-7AAC8CF06FD4@oracle.com>
References: <20240415172133.553441-1-pvorel@suse.cz>
 <7A48C70E-BAAB-4A1C-A41B-ABC30287D8B7@oracle.com>
 <d895ad115632912df228913d4a86e7f597b22599.camel@kernel.org>
In-Reply-To: <d895ad115632912df228913d4a86e7f597b22599.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5641:EE_
x-ms-office365-filtering-correlation-id: 8be93faf-a2cd-4d4e-7219-08dc5d72b908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOZ+c27LEqNxKzkEIpD0didZHkT35/aR6mkx6ZgukDgSPG0S4fB8zLzzaIYDLmk7I7gUOvQppib4MmSSfoJ+8BkjtdMCtki59BhsTknKeoKsX+MduOjOQW6RpLqMBYtLSNyahgeXBGzgMEU9WmYm7JWMxJWAHMArnKIA5CqgywRMI0PKDVI509NLzcIASMhIq37/sjjsbfL9AfyZcWbg1ibbrLlbzkblOkrTHSahyEfJlDYco0kTqqH1KedmrqBvDUnyl8V+C4UonstHYIQH2LQeGkwR4as2eKxF3u1XDTLFG7eqfIQ0SB9Feb/vVzke4anrXHcGqxTNBQ0RwLQbVGUEW4qRMk5BjdRp9R5uSkplCAhe6q7E4FJmOgJ7/CEDS/iqRSwl8xPikPKNelBft7vlVAdVZany2ED4dKviKmTkXlozk20JP47+ZjI2c6nKX5TBxI9XyJ4ulMmeGimn5QqtbpJNV/MGrbnLuYO6UJqp8t9X4eVXXcogTYKM+vKFqOXdUC6bo2UsF5iISyozVuOVbTGIzJq0PBfAqK8N9YdJFZOCLKS+JXaZlmkbbQHrHwpLCIw6zOpaQQH+tVf/qqvTA3q9CRhw5nObhzpUBiG4g43NW2WRENbetLhYVl+IqqOUf1j28ARnWA99buck70/dAqyt9TZD6oUlxS4K6Bfghv3PeSz+jxLYOx+HKliA6k39QgUSUuStTw8Awd3+uky6EvWThvl22iOrXozUv4c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm5SOGpLRlV4U2NyK0t4UzNrbU9TOVkxREtGYjJlNURiNW5qbDlRNWZWeWg4?=
 =?utf-8?B?aWRHbmFQQjRlbU8zQzY4YkhQRE5WQzlxRWY2bDVrMWRBdDRad05CWGFDM3U5?=
 =?utf-8?B?WHl6NHl2WFJILzYybFprcVpab1RKdnIrNkg0Wkh1RzBEVklLYXNaQlpqLzZ4?=
 =?utf-8?B?WmxySTVmVXR1WDV2SmtRMmp2bWJWZS96d0d5NTVUTFM2M2VEYk4rUWwyMmZp?=
 =?utf-8?B?MWNUR1dwTzRaR3RBMGZDQXZqMzZJZ3B1eWFCWUgxRnJLZGxta3o3elJ5V1hF?=
 =?utf-8?B?Y3ZueXRXenRRUk91N2s2RDJybFA1dUlFYjNHajZBV2xRbDRBSk1yVTA0eFdu?=
 =?utf-8?B?M0UvL2VTeDB3WU9tbDFFUUI0KzlwclRFSm9QbXppellkK1NpL25nWEllYUZq?=
 =?utf-8?B?aCs4c3gvU0Q4L1ZXY2NOS0x1cko2aWI4eGFwS1ZnK2tIZE9Ib1ZPY1lXWHVh?=
 =?utf-8?B?MmRhZFE1YVVYdk12NGFicE0ySGZiOGJYa2F2cTlFTkJCNXBac1I4OGVqWE5o?=
 =?utf-8?B?dDRHQjlubUdhMG95Nm9WQXRkNU93bWNyeUJIVnJVWXZzUDhqKzJ6aHJGYm1h?=
 =?utf-8?B?Z2hxazZrSG05UmdMK3hob2htaWtjUVhvZ3B2ZEplUVh1bGhCYTBTbjBTUWFr?=
 =?utf-8?B?WVdzUW40WUVXTG84UFFxSGlwM3BBR2QweER5MVdWUjNtVVk3ZUxLV3d6U0Ft?=
 =?utf-8?B?OTNyWXkrdkozTE53SlpkblQ5VDZ5K1VzM29KTmVDQmgwSFdmWHJwRjN4eVVF?=
 =?utf-8?B?Nm90a21oTkpNb2QvaFhzeXovSTdrd1piY2NlTFozK2xGUENwK0diYjE1V0pW?=
 =?utf-8?B?VHhYcUpFc3ZzR2dWTnVRSGZtRU9OYjVtN2VpTVUvRGEzblc3ZHJLWGl3NmdW?=
 =?utf-8?B?Q0tXbk9LVzF5L3l3ZUpxMk5iOHNjSVJuTUtqNXdqK1JtM1F6ZjRhQUVETU5l?=
 =?utf-8?B?bTFyNFRPUWZqMVNSOUJRVG5FbmFIeHJvT0NsUEh2aDlQWEtOT3RpaGljQVpT?=
 =?utf-8?B?dmpFOUZuZ0lGQnZCL00rWGZzOTJnNkYwMXdHdWZVbGdjRm15M3ovcWpjc0M0?=
 =?utf-8?B?WUlVWjBiRVQvTWVTTHF3b05QUmFwSTFLOTh6eFJpVG5lSVFIRUJIeVpPRkZo?=
 =?utf-8?B?dU1xZUFwcVJ2ZmxGeEthVVA3eVUxZ0FFWEhHSDlVdDVRcXdrNytVMUc0UUEw?=
 =?utf-8?B?Q3RVYU0zWmwwYVFqOStpTjFQWndOUHZ5N3RwcnJwb1NJV0szR0MxUGhPQ1NP?=
 =?utf-8?B?c0VmY3RGbFJDZGRxTC9wU240bU93MHBJUHNVZWtYSmo5RGxTTG04YnFEU1Rp?=
 =?utf-8?B?UWFWMklUL1NQdjgvOHhqbzhObjBEUUdCWlJXZDVFaWtFTU1WTHNTK1BmRkZI?=
 =?utf-8?B?VndPVENaeGRwZlhwRCtnT1pHL2lRWHJDazZHT0pXSkdoYm1CdUZKL2F1MUFH?=
 =?utf-8?B?SlhodTliS0tFdDJMSUJJU0loWGRIRjF6VzBOWXlSOEtkZndlUk5UMHRYUFVu?=
 =?utf-8?B?Y3ZzQXJSMTk1YUJiQ3pHNi91OHVJM0t6SlhvUXhhc1lOaXo4M2JMTHdFNm5v?=
 =?utf-8?B?RXgvYU1TR1cwTWxpSFIvcEwxZUNEeE1TaDQxd2hsMTN1V0FNaFM3d2tGdEt0?=
 =?utf-8?B?RTIxeVd5VEQxVWN1MHFXeWhvVXZWSXkzS0VLcXNsVzdMOTV6cGg0a3JzRGkw?=
 =?utf-8?B?TnoyL29qWDNDZXNvM2xFQXd6VmgvODVQQkhFR3pQeUNKdjVYWSsyQ0J5UGFQ?=
 =?utf-8?B?allXYmppNVlwS1NMUlZZSzREOU1KZ0JoZUZZU0dJU0NDUGtRR2JQV0EyV0gr?=
 =?utf-8?B?UXRCZHdMUXBpa3lId3Z0M202U1NTaHVrekVpSVV2S21RVHJuR09vRmlXTDZl?=
 =?utf-8?B?QkNRNk91VTQvU01WTWhiT3RxenVQdkxIQWY2aG53YzVOSGszOTFUMVA1OEtv?=
 =?utf-8?B?WFNZd1Vod0FJRHFaY0orTThSaWVRNURDdGxuZW9SRUdzdWp2UTRiaTdEd1Jk?=
 =?utf-8?B?N2pWWVlMeDUxZDVCOVhtYVRLRDdDVGl6TUFCcGZEODk4Y1p5VnBkTzlGSDNv?=
 =?utf-8?B?dnUrOXFtSVJtclFOOHdhcnJZRll2eEQxVXc0QmdFUk9lK25LNTk2Z2ZtOHRB?=
 =?utf-8?B?dHpXQUNReXlFYnJnNlNTUittL0l2emZGVkFzbWpPWWpnZ2dBRkZFMGlXMHYv?=
 =?utf-8?B?YWc9PQ==?=
Content-ID: <C7760F16B58A4447BF0ADE1A7F147872@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C7hXKOeBrFTBxuDTVVwisxEo+kf/GvQ+XXuYPWUMZZng4tDTwkqJXcudk1YsWd3ugZbT0olVhOhsbYPCiAMtWZopwjvTAat0kTb0B6XgXIFpzsROEqKyYO398uEbLskYGOCARVkiau3UHabthgS6egC1MLFuNX/Pgu4/D/j/OBgwwSMeodgMPBctJifDFh8QO2Jl5rglB+bptB0+uUQIluTysHPVLQ2QIuI6edk6qohMkj9Z0Cw6LUnnvmOogOcFD1GTVbgziTkQ/JnrS/MLXIIbdkb7d/Or77yvk9xJBGuWPCiW/SbZbxwl4OavWqNyrx3hf3gkxT54ue203mkcYZ4VsAHCIMnlRw5e2DJSKJjB3MBcDFkO5MGLf8prsgie5m+W/ARoQgZ7qyS8dCXkAZeoVmwK/iIEzadhulJEi1WPVM7pxg4cO6Eur+Oq+FMG51RhSSjun2KmF/ZUeMnX+Sz7D813HbLe51ctqjwqFGR9ApqJ+8mVLZBcosJaUt/g5UJlfRec6gm56oFwe/Nn7ARmgStXmCygwwgvPEKgbXDcTsWX2KGxNohPhoJzy5HnGP6kkrviik2fTGbrteQYPBANbgx80Gj3mSIgYuGuTSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be93faf-a2cd-4d4e-7219-08dc5d72b908
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 17:37:29.1733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zp//wbCZlj6kE4ik3tkO8kl/zhAFE45SFLRK4cdxbXmZakuDLkPRKoEPIFs/IvVviO+YivXM0yYzvEb0JSgozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_14,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=797
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150115
X-Proofpoint-GUID: lvuqapQi45mm6r5rBwtF9dIgacjdJV6p
X-Proofpoint-ORIG-GUID: lvuqapQi45mm6r5rBwtF9dIgacjdJV6p
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] proc01: Whitelist
 /proc/fs/nfsd/nfsv4recoverydir
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
From: Chuck Lever III via ltp <ltp@lists.linux.it>
Reply-To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gT24gQXByIDE1LCAyMDI0LCBhdCAxOjM14oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDI0LTA0LTE1IGF0IDE3OjI3ICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+PiBPbiBBcHIgMTUsIDIwMjQsIGF0
IDE6MjHigK9QTSwgUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOg0KPj4+IA0KPj4+
IC9wcm9jL2ZzL25mc2QvbmZzdjRyZWNvdmVyeWRpciBzdGFydGVkIGZyb20ga2VybmVsIDYuOCBy
ZXBvcnQgRUlOVkFMLg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6Pg0KPj4+IC0tLQ0KPj4+IEhpLA0KPj4+IA0KPj4+IEAgSmVmZiwgQ2h1Y2ssIE5l
aWwsIE5GUyBkZXZzOiBUaGUgcGF0Y2ggaXRzZWxmIHdoaXRlbGlzdCByZWFkaW5nDQo+Pj4gL3By
b2MvZnMvbmZzZC9uZnN2NHJlY292ZXJ5ZGlyIGluIExUUCB0ZXN0LiBJIHN1c3BlY3QgcmVhZGlu
ZyBmYWlsZWQNCj4+PiB3aXRoIEVJTlZBTCBpbiA2Ljggd2FzIGEgZGVsaWJlcmF0ZSBjaGFuZ2Ug
YW5kIGV4cGVjdGVkIGJlaGF2aW9yIHdoZW4NCj4+PiBDT05GSUdfTkZTRF9MRUdBQ1lfQ0xJRU5U
X1RSQUNLSU5HIGlzIG5vdCBzZXQ6DQo+PiANCj4+IEknbSBub3Qgc3VyZSBpdCB3YXMgZGVsaWJl
cmF0ZS4gVGhpcyBzZWVtcyBsaWtlIGEgYmVoYXZpb3INCj4+IHJlZ3Jlc3Npb24uIEplZmY/DQo+
PiANCj4gDQo+IEkgZG9uJ3QgdGhpbmsgSSBpbnRlbmRlZCB0byBtYWtlIGl0IHJldHVybiAtRUlO
VkFMLiBJIGd1ZXNzIHRoYXQncyB3aGF0DQo+IGhhcHBlbnMgd2hlbiB0aGVyZSBpcyBubyBlbnRy
eSBmb3IgaXQgaW4gdGhlIHdyaXRlX29wIGFycmF5Lg0KPiANCj4gV2l0aCBDT05GSUdfTkZTRF9M
RUdBQ1lfQ0xJRU5UX1RSQUNLSU5HIGRpc2FibGVkLCB0aGF0IGZpbGUgaGFzIG5vDQo+IG1lYW5p
bmcgb3IgdmFsdWUgYXQgYWxsIGFueW1vcmUuIE1heWJlIHdlIHNob3VsZCBqdXN0IHJlbW92ZSB0
aGUgZGVudHJ5DQo+IGFsdG9nZXRoZXIgd2hlbiBDT05GSUdfTkZTRF9MRUdBQ1lfQ0xJRU5UX1RS
QUNLSU5HIGlzIGRpc2FibGVkPw0KDQpNeSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBydWxlcyBhYm91
dCBtb2RpZnlpbmcgdGhpcyBwYXJ0IG9mDQp0aGUga2VybmVsLXVzZXIgaW50ZXJmYWNlIGlzIHRo
YXQgdGhlIGZpbGUgaGFzIHRvIHN0YXksIGV2ZW4NCnRob3VnaCBpdCdzIG5vdyBhIG5vLW9wLg0K
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
