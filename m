Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE913CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 18:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725300861; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=626X8Gg6TWmBI4VjyReEsGEA/D2lbDGaPeHsh5wMt2U=;
 b=PsFOPjvaJEFiQpVdk4Bpyj39a+kg3frhjPo6GRio6AelxDr151LmCe7H9iF0rom6urkVq
 3gIYF1L+9iTRd97kdA9yo2hAHZXYNOKpyKjyYKnFoDeL8F95tIf9J1VFbYLX+OiZwRnnSPD
 uJDt+O9/g8dqfNZSf4A/7iBDPJ4zfqo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D94553C00D5
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 20:14:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA99C3C299D
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 20:14:00 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 79A98600D6F
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 20:13:58 +0200 (CEST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482GdHCC016780;
 Mon, 2 Sep 2024 18:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=corp-2023-11-20; bh=OxZuxUcdKlxEAR0qhmWIAJ6piT8py+NVoHeilCk9R
 ro=; b=OjLV1eB8Y4zIN/KlGMtJdgzVVPm6Qg1SkwdFu1WxqT6sJYitWDfq8Ac6U
 9XXYyIKfzlljYLuYT63lCJoFO1ilGpOgef7sVbGEKOAZy0rSCCNeI5+3ZfC6HmJ/
 Ip/xbDxp12OUUk5eJ1MN9Ah4QaUgrQUmIFcVWkNgdv31IgyldxNyNxJSu1DBtZ5e
 xaKuvqAsjBKPleKMubmVQAeYYdd80ldzbr0O4BWqAJt2V41WdyODyin6DFHF/3ji
 VDXdTWDYjxTxNDApfQn5cdP6mG50pgJLVp6+RbetMjHuFpdIcEQDgHy/G8Hg9jzX
 8gv6CTGhIUAfD5z7XpS0NHvFdfdSQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dh2c037m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Sep 2024 18:13:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 482H3dlQ023700; Mon, 2 Sep 2024 18:13:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41bsm7crn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Sep 2024 18:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II4isvJuYHxOSC9qIXWIPGmjFLDGHCYUTzkqYLAd7haJv/1cOfZijIR8Gd2BorlS5WI7l1YlhJnLieF3445fwkGtuqL/9S+WH4MSrLeVGrH33GwM6PjoOhRVx4HVvmbQ1IaDmXpO7uqbt8RufDUcBp//v/bsFfcelnJBDf2igFHOrdSCE7oUI2BWk/P1Al+W5Kuqv+ymny7Gt6jjOMthsSxlZp73d5ZOzueWsPOoL4/FuGVf4CgUnvM/eTgsXBfSuj1hJ6Hfi6CsnwvZ/A+ZIszTtVEdK85NKhF6dPlYhG7Ch7kEn5YlcFWJzKNXDeqSWfz2FkF+iFmpT09xE0DCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxZuxUcdKlxEAR0qhmWIAJ6piT8py+NVoHeilCk9Rro=;
 b=xO66P2Rh9YkXjInSFjLExuxeagOani5CemQQWB9lg/0JLvRdeW7j4nUPO1Nfrhy1OD6Ged4sM6rNBZNvHjTw3EZivWXdLx5fFkYmDFGVHGcFsZx5wOT+VbUFAV7DE0VX2muxjiCzYu0im23hpf1jEW3KSXMZcNPZk2BiGVva0oe9wfIZC79ZWurLNfuwOrPLN/GfNVfrfLiyMmnbKHokpcl/tviF773ffXV9c6Tew92LXi5orM1AiCl9/LkBOewy6W7Pbgn1VImgSf1pATyBJCALnTrnbwvkUh1o2UmT7TJv7iFszmmJbB5ZztJXhl+vWYDfaOn0yU64roIfNqRVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxZuxUcdKlxEAR0qhmWIAJ6piT8py+NVoHeilCk9Rro=;
 b=BPgzmaaA6Gt1P7pFKnOBKFUksbU9s3km4/SWQuf44cZUelaM/8tzQM7DH7lMHr8qbfasLEKKUjuZfgq+93uSTOCObdLqA2wiHRaz/YLxX9ogMFkNxs36bGC0hRz7LCLwZIOazvkdXFmuhhDFgwgJ8Hu8X8LBHn8PKA+I39Df6Is=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6737.namprd10.prod.outlook.com (2603:10b6:610:146::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Mon, 2 Sep
 2024 18:13:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Mon, 2 Sep 2024
 18:13:52 +0000
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [PATCH 2/2] nfsstat01: Check that RPC stats don't leak between
 net namespaces
Thread-Index: AQHa+ucFWt9PiB/oIU+RgU8O1F/ws7JAGhoAgARMfwCAAGtHAA==
Date: Mon, 2 Sep 2024 18:13:52 +0000
Message-ID: <306D5C27-B99C-4D97-A35E-1E89152424DD@oracle.com>
References: <20240830141453.28379-1-mdoucha@suse.cz>
 <20240830141453.28379-2-mdoucha@suse.cz>
 <ZtILLtHSahuwDiZq@tissot.1015granger.net>
 <d819ef29-7984-4834-97db-37095a36aba9@suse.cz>
In-Reply-To: <d819ef29-7984-4834-97db-37095a36aba9@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6737:EE_
x-ms-office365-filtering-correlation-id: d616df40-277b-444b-bf98-08dccb7b005f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWdQQW42ejF2VjlmblBCMWNNcjMzNjcxaEJ3UC9mVnlHcXFlc2JWKzV0cEsy?=
 =?utf-8?B?cGJRTG5DYzA5bm5aNEhzM1VYZTlGRFJsWG1haVY5QmRrVzMyTXFjaSt1THAw?=
 =?utf-8?B?WlErd1M0MXIycXcvTDlBM29jS0lNYlduVXE0OGFFUGZoU0w2MjNNbUZPcDhK?=
 =?utf-8?B?eERRdWVSUnI1UTNmb1hkTkF4TmRudlBBcXRhUCtaSFJ4eDNONkRKeUVLS1FO?=
 =?utf-8?B?S3EzcEg0cUdBbk16bEZETUp4RFJJK0dEQ3dZNlVjSzJqT1RJRC9PMURldHdF?=
 =?utf-8?B?Y01LYndMTHlwQkF3dXd1QkF6WDJOOWlFUjRhNHJ3RXRWdVRCL1pyMTZxM1VF?=
 =?utf-8?B?RGJYZmFzTzdXdXhBQVU0cmRDdGkxbW1yK0x1NW1OSXIrc25TeEFPckM0L2xN?=
 =?utf-8?B?TE0ydjNCQldIK1JIQmF2cGFaMVFFSGlDT0JJQTlaWVJYWU9FYVRScUJuK2JP?=
 =?utf-8?B?UTBGTUtMcHgxRGhQU1RqR1NoeW94WFZtbzJjMlg3TVlqbmdXRVE0dWFraXpa?=
 =?utf-8?B?V2EzZUYxRzk5R2ptZkVCeXJPdStxT2xMN004dVI2ZGlzckNHZEVPTHVxc2ds?=
 =?utf-8?B?dUFwNU14ZlRQQzFTUDIwbFZWWE5qbDNUNHFXVytTQmRxMVR6NnlJSWU4cUI0?=
 =?utf-8?B?UWNqNGRSOWlCanQrS0IreFBQbXpGc2hYR2luMldHa3VlV2JKcGp6Z0s0T3hM?=
 =?utf-8?B?dkUwWFpraXdycGtxaEFiMGsrNHJMQ29NL2N1S0I0WWtlaUZhSE9FS2gxUHpE?=
 =?utf-8?B?ZzZhRDU2Zm1zc1pNdWx4Y0xQOVp1ZGFZaXZnRFA5QWdpT0d4T0l3Wmw5MU5v?=
 =?utf-8?B?UGRQRHpzWGNOVXlYTmpxUVBUUFJVWjRDdzVpVzBZaFc3QUxoYU9YSXB3cktr?=
 =?utf-8?B?ZE1mMFZHUnd4N3YvRTFMWnViN1M3ZWdMNXZPRWZhYmU0QTRGRUtWSE1nVTlZ?=
 =?utf-8?B?Ukdad09leEJsdWNoVVdORFVDR0tZdWhoODA5Mk5uYUNvZy9JZW5MUTFPUlNI?=
 =?utf-8?B?ai9PbmM0SkpFblNhUnJKVGRMTWRyK3V3SVJLOXZQc09ZOFEyOWNzeEFITWts?=
 =?utf-8?B?cUQzeng0TzdtSDFqeGIxTjJha1kzRkRPOTlhWndrRlUyL3cvR2Y2R1JIbGwy?=
 =?utf-8?B?a0RLZlVpcys1OU82ZDg4aGpOMXNoNlg2RkNGazZoQnF4V3hTQ0dOcURGbUw4?=
 =?utf-8?B?TEorMFlCVGkzT0xtaVl4bXRvTHhEeUZETWtjT1NISUNHUkZjQ3NyZi90K1Vy?=
 =?utf-8?B?RitwT1hNbEpNcDFJdVhZbWpGMGxNaEJOK20wc1Yyc2hXZ3FseXg5Mk4vTXM3?=
 =?utf-8?B?aHNBbmR5MS9uM1Rla3lxdGsvMWZNekxSY09RVmEyZ0VYV3pRd0NtNGQzV1hX?=
 =?utf-8?B?ekdxdndOelBuek9NOG0zZkpTb1JFbURXWi81dEVBSnI0dnd5TFFjSTcyS2l5?=
 =?utf-8?B?SFlxbytaVmh2cDNpaHh5T1hza29UaG55S09TazlGSHNOTUROMjdGNWY1TzBO?=
 =?utf-8?B?VU9keUFFN2YxMmFZa3h3SGJzV1dFUS9GdUxFemljVDBVb3pvc25tUU4rM2Qx?=
 =?utf-8?B?ZWkvNFFIU3B4Z0F1MElsRmVPTEZRNUlkeEJGQkZiV1graG5jN0ZXdndiRWgz?=
 =?utf-8?B?Q0pZYmhxWTdkNGh1VXZIamtaamlqa1VoOXNsamJDYlZjN0dxUng0Y1M2cEhu?=
 =?utf-8?B?S0crQlJHS2lKNlRiZ01PZ29xbHRzN0I4WlBIN2NPVnNiazRPZjNLZzhTTXhx?=
 =?utf-8?B?RzVicGxqWnlkNFdacitoOTN6MjhyZ1RJbW9iSU0xWm1CTkNoaWZMQnJmWWZC?=
 =?utf-8?B?VERWb05USDRTZ0Zlc0dnbk5WSTVqMHkxRjFTNmQvNmJtUlA0V01FZ1piYzBD?=
 =?utf-8?B?djJ2Rm11RTk1dkJQUVdNNk91SEdpN3F2cHVnMWNTS0xMU3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnQxZ1c5RmVwek5mSzEwYU4vZnlDNzNHZ3ViRkppL25TTVRFQXNmcHJNdVVu?=
 =?utf-8?B?Q29OOXh0V0tEbjlHV2c3LzQ5bWJpeDVxQTV3d2l4Tklkbk9FcVNPejMxakR1?=
 =?utf-8?B?eUV6bWVHYy83d1k0T0Rmd2N3SHNxaTJMdUhGMEE5REJVRkd2clgzb3N5NGJD?=
 =?utf-8?B?VUFnNHhBVUZIOHQzNHovY0tybUd3V0N2ZU9paEFscnpheE9yc2RtdXNjRklx?=
 =?utf-8?B?NFVkQTBjYnJZQVp5dCtOZUFKb3RpMXpuclkwakVwbjYrL2hSem01MFVnSk9U?=
 =?utf-8?B?QVoydFlucTNzRTRXMzNiYkZoTGJiQnRQam9JUlBBdnRrYlU4WVFqMDBJcFhQ?=
 =?utf-8?B?WFlFUlJOY3NrQ3RzSVZKdFhYUEhkRENGcE1mL0tuemYrSUk2WDhmQWRTTzdZ?=
 =?utf-8?B?dHRWMnNaS1ZJbzJpbXZyUkU0UVhDSVZYRWF2bXlUNVJCbHhlYWpyeUpCSERY?=
 =?utf-8?B?a1NxaTlWcGJyVkRHWnRUK1dXTjI4S2FVVWhacUdiS1p6ajdxL0wrUlJrVll5?=
 =?utf-8?B?QnAvWFlscWh0dTh6djRDekloSy9vOXlFMS9lZHdOSHVwNE9Zd2lTS2hFdjBP?=
 =?utf-8?B?cGlTeVJTR1RkUXErWnVUdm1JUERrQ3NOQTFNMEZtdlNGaWdMT2VBbDZvaXpu?=
 =?utf-8?B?SHBnMzRLYm9hRlg0YjdRRWJmQjNsbGYxMmJUMk1maVNVL1YyRWxhY1NQYmtH?=
 =?utf-8?B?UmlnT0xFQXNXS0ViZlFZSFlONmw5M1B3OExpZHFOTlphcEtNOU8rRWVjSWtB?=
 =?utf-8?B?bHpodFdsMGkzSFpnYmNIZDFoUEE4N3dpWWJRQjlqcDdjTEdSdCtpUE9pTlVU?=
 =?utf-8?B?VjBMSWd5ZkVLNWJ2d2d3REx4c0JrS0xWZmVwMVU4SmZQbjJmSElrcDROQlZK?=
 =?utf-8?B?RDFQZDFRVWdUZjRkZm4wenFVck93QWpNcjk1T1NQdVdGeE8vbGs3c2xKbVBk?=
 =?utf-8?B?MmI1em1ieHRUUW5Za1ZhL2EyVFVUZlpnb295RmphMmRZZ2pYS1lpem85N1Q2?=
 =?utf-8?B?bTBpQmYvL0VtbVREV0Mvd0JwV0hEQkpHWWpXL2VJV1BlZWRGaWR1QXRIM3Ez?=
 =?utf-8?B?TFJEeGV2MEpKcmJsYXJidXFxQmZTOUFLYzhZZkhUOHNwZzlQcHJNUVZ2QnlX?=
 =?utf-8?B?UlRIL3FJcC8wRVNvYzZmUlVheXgyV0g5b1U4Mllnb2VVRTdINXBQb0dzd0dr?=
 =?utf-8?B?ZFRNTFBqYWFtN3E1NFdTUHdmTHJGeEpmUktaREIraGVDaHdHc0dSMVBFMkE0?=
 =?utf-8?B?MHJFWXBvWVdBWXd3OU4zeTdEcGIwNzlla2RjajJqV0d6YmZnTVNYTEd5dEdm?=
 =?utf-8?B?NFFQUDcxRGlTcmNCWWUxVzQyNThLZWJERGhxKzJhc3pxbjNBVnZMM3oveUhG?=
 =?utf-8?B?cTRaampuTVIwV1VaLy9RRFVsb3RXaEE4bkhtTnZuUS96RlY4WkZ4a2pPaTRN?=
 =?utf-8?B?WTZDbkh1MS9kdzRWNkd6Z0w5MVRQaElZU1R2dGtYL05PNFRyb0p1YitjS0VK?=
 =?utf-8?B?b1lBQXk1QVBxZnptMVoxaUticm16MktRZk5oQzJJbGlQbVBVMTV4eC9UcmNX?=
 =?utf-8?B?dm5KZFU1VVhFQnJmQjJVWS84YUtjMW5HenJ0MFVraVhuZmlUd1ZoQlZWK1h3?=
 =?utf-8?B?M2txY2h1bU1QcDJDWUQ2NlVLQ2c0NnBwMnpxUEZqS2FLd3haU283VVRrdWhR?=
 =?utf-8?B?TUVuazh2a0dTamc3bTdxOGpzYnNOdnBUV2xkclMzTHNWa0U5MzdpTzBXYUhW?=
 =?utf-8?B?cGNsTjBVbVVRSWtKbDlsQWVPd2paMVJjU1pRajZITTdRSWxuQTVsQ1lWWnFx?=
 =?utf-8?B?OFl6dEFxaENSRnBWOFNZaVV2NlhUd2lwUis5alFMODJVS1UrMFdVeHo2Nitu?=
 =?utf-8?B?M2tuWTFISHZtUEpzeklLVjh2bkdvRGZCWVpHbitLKzZHR1hXdkV6Ny9sd1Qw?=
 =?utf-8?B?RWZkVm1HNEYwOFFWRG5ueTFIMmpCRnBVMk9vclU5eTZXVCtvY2tSVThTT3F3?=
 =?utf-8?B?azNNZUsvYjlhOTdJWURiLzV4c1JCUEYzRmJaSVVJdlVLS2JVMGVKMVllbUVE?=
 =?utf-8?B?OXBhMEZ0N2ZEb09OUXNMelppdGlSaEZVWUMxRnZnSXRiTHQrbFJmMzJpWmM0?=
 =?utf-8?B?TjlqdnV4TTd6UmJEYkR1bWpEVUo0MTZ2aEZ2M04wNmN0UzhDQm5ub3c0T2tH?=
 =?utf-8?B?K1E9PQ==?=
Content-ID: <A09771D6E9A0774AA307E9DBAE958F72@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OTFjbJFL3kib5TdEe0HMuKGq3gh8HyB10Z6LUOzGYgWdEAeJ5ItbiOImtsBopzFgBpxhYKu2hCVYKLXKtSlFZKGIccYWP71I+7YUW6d/LztvDcE10BdMkFIysnM6JNjyqiHbxGsz3reT2oJHb4k7OamunqFGNpVmFN/PQXW1/Wj5r7VqT9ICFi+pOxfrIwycunfs/HSSEJ+FC3poSzQNoKKy/nUUEBKQMFTMR8W44tLO7WCJNaHwEiWD1OKPlbxwr+d9zgSlE65/E3GQMJH6mlabwm6z6yJ/oBXIn9zsIhR1SLPwghitOBsjUjEjqY73+LLAezOr+kjsPzFl01NE5JGx5zg+FFRWNsI4SEh6LGONlYf2iQ16g0p3sgLGRx9OyHuW4wnoR7yXIetXWKSXmHcSklrBk+13cMLn88bKqR/lb7Vx6g+ilPlWIskD9/YLemJlawt4JliyjftVHGqu2u/2H+a/sIR++yHez8j0+fccAJh750bFbMorH9PSFawVSx50IIbLnHI6/x6mlHgTF9nQyiwqoTyg27HzDxfbwd3JX5hZ3X5RAAFGGPvvfAq+Vs9lmHL3xmMVHQMO5FOg4zkb82ceLJqHv1HpdD+56Pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d616df40-277b-444b-bf98-08dccb7b005f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 18:13:52.7441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DQ2uEYm4jMW2Gfe6so6Nv7wsjMb5F+26OYFgU+xIPrlZ7/iIjqOeAYP6xOYEEIuF3IMduHLrqYM2jdUpCDQVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=905
 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409020145
X-Proofpoint-ORIG-GUID: eDx7fBVKKkUCf01rlC-1proxyC73zvIo
X-Proofpoint-GUID: eDx7fBVKKkUCf01rlC-1proxyC73zvIo
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] nfsstat01: Check that RPC stats don't leak
 between net namespaces
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
Cc: Neil Brown <neilb@suse.de>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gT24gU2VwIDIsIDIwMjQsIGF0IDc6NDnigK9BTSwgTWFydGluIERvdWNoYSA8bWRvdWNo
YUBzdXNlLmN6PiB3cm90ZToNCj4gDQo+IE9uIDMwLiAwOC4gMjQgMjA6MTAsIENodWNrIExldmVy
IHdyb3RlOg0KPj4gT24gRnJpLCBBdWcgMzAsIDIwMjQgYXQgMDQ6MTM6NDBQTSArMDIwMCwgTWFy
dGluIERvdWNoYSB3cm90ZToNCj4+PiBXaGVuIHRoZSBORlMgc2VydmVyIGFuZCBjbGllbnQgcnVu
IG9uIHRoZSBzYW1lIGhvc3QgaW4gZGlmZmVyZW50IG5ldA0KPj4+IG5hbWVzcGFjZXMsIGNoZWNr
IHRoYXQgUlBDIGNhbGxzIGZyb20gdGhlIGNsaWVudCBuYW1lc3BhY2UgZG9uJ3QNCj4+PiBjaGFu
Z2UgUlBDIHN0YXRpc3RpY3MgaW4gdGhlIHJvb3QgbmFtZXNwYWNlLg0KPj4+IA0KPj4+IFNpZ25l
ZC1vZmYtYnk6IE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4NCj4+PiAtLS0NCj4+PiAN
Cj4+PiBJJ3ZlIGluaXRpYWxseSB0cmllZCB0byB0ZXN0IGJvdGggTkZTIGFuZCBSUEMgY2xpZW50
IHN0YXRzIGJ1dCBpdCBhcHBlYXJzDQo+Pj4gdGhhdCBORlMgY2xpZW50IHN0YXRzIGFyZSBzdGls
bCBzaGFyZWQgYWNyb3NzIGFsbCBuYW1lc3BhY2VzLiBPbmx5IFJQQw0KPj4+IGNsaWVudCBzdGF0
cyBhcmUgc2VwYXJhdGUgZm9yIGVhY2ggbmV0IG5hbWVzcGFjZS4gVGhlIGtlcm5lbCBwYXRjaHNl
dFsxXQ0KPj4+IHdoaWNoIGludHJvZHVjZWQgcGVyLU5TIHN0YXRzIGNvbmZpcm1zIHRoYXQgb25s
eSBSUEMgc3RhdHMgaGF2ZSBiZWVuIGNoYW5nZWQuDQo+PiBJIGJlbGlldmUgdGhhdCBpcyBjb3Jy
ZWN0LCBKb3NlZiBjaGFuZ2VkIG9ubHkgUlBDIGNvdW50ZXJzLiBXaGljaA0KPj4gY291bnRlcnMg
ZGlkIHlvdSBleHBlY3QgYWxzbyB3b3VsZCBiZSBjb250YWluZXJpemVkLCBleGFjdGx5Pw0KPj4g
UGVyaGFwcyB0aGlzIGlzc3VlIHNob3VsZCBiZSByYWlzZWQgb24gbGludXgtbmZzQHZnZXIsIGl0
IGNvdWxkIGJlDQo+PiBjb25zaWRlcmVkIHRvIGJlIGFub3RoZXIgaW5mb3JtYXRpb24gbGVhay4N
Cj4gDQo+IEkgdHJpZWQgdG8gdGVzdCB0aGUgTkZTIGNsaWVudCBjYWxsIGNvdW50ZXJzLCBmaWVs
ZHMgMTMsIDE1IG9yIDI0IChkZXBlbmRpbmcgb24gTkZTIHZlcnNpb24pIGluIHRoZSAicHJvY1gi
IGxpbmUgb2YgL3Byb2MvbmV0L3JwYy9uZnMuIFRoZXNlIGFyZSB0aGUgY291bnRlcnMgdGhhdCB0
aGUgdGVzdCBhbHJlYWR5IGNoZWNrcyBhZnRlciBSUEMuDQo+IA0KPiBBbHRob3VnaCB3aGVuIEkg
dGhpbmsgYWJvdXQgaXQgc29tZSBtb3JlLCBJJ20gbm90IHN1cmUgd2hldGhlciB0aGUgTkZTL1JQ
QyBjbGllbnQgc3RhdGlzdGljcyBzaG91bGQgYmUgYXR0YWNoZWQgdG8gbmV0d29yayBuYW1lc3Bh
Y2VzIGluIHRoZSBmaXJzdCBwbGFjZS4gQUZBSUNULCBwcm9jZXNzZXMgZnJvbSBhbnkgbmV0d29y
ayBuYW1lc3BhY2UgY2FuIHRyaWdnZXIgY2xpZW50IGNhbGxzIGZvciBib3RoIFJQQyBhbmQgTkZT
IGFzIGxvbmcgYXMgdGhleSBjYW4gYWNjZXNzIHRoZSBORlMgbW91bnRwb2ludC4gUGVyaGFwcyBh
IG1vdW50IG5hbWVzcGFjZSB3b3VsZCBiZSB0aGUgbW9yZSBsb2dpY2FsIGRvbWFpbiBmb3IgY291
bnRpbmcgcGVyLU5TIHN0YXRpc3RpY3MgaW5zdGVhZD8NCg0KRGlzY2xhaW1lcjogSSdtIG5vdCBv
bmUgb2YgdGhlIE5GUyBjbGllbnQgbWFpbnRhaW5lcnMsIGJ1dCBvbmx5DQphIHZlcnkgbG9uZyB0
aW1lIGNvbnRyaWJ1dG9yIHRvIHRoZSBMaW51eCBORlMgaW1wbGVtZW50YXRpb24sDQpzbyBJIGNh
biBvZmZlciBvbmx5IGEgc29tZXdoYXQtZWR1Y2F0ZWQgb3BpbmlvbiBvbiB0aGlzIHRvcGljLg0K
DQpJSVJDIGluIGEgY29udGFpbmVyLCB0aGUgUlBDIGNsaWVudCBpcyBib3VuZCB0byB0aGUgbmV0
d29yaw0KbmFtZXNwYWNlLg0KDQpUaGUgc3RhdGlzdGljcyBpbiAvcHJvYy9zZWxmL21vdW50c3Rh
dHMgYXJlIGFjY3J1ZWQgdG8gYW4NCmluZGl2aWR1YWwgbW91bnQuIEkgdGhpbmsgdGhvc2UgYXJl
IGFzc29jaWF0ZWQgd2l0aCB0aGUgbW91bnQNCm5hbWVzcGFjZS4gSSBjb3VsZCB2ZXJ5IHdlbGwg
YmUgd3JvbmcgYWJvdXQgdGhhdC4NCg0KVGhpcyBpcyBhbm90aGVyIHRvcGljIHRoYXQgd291bGQg
YmUgYXBwcm9wcmlhdGUgdG8gYnJpbmcgdG8NCmxpbnV4LW5mc0AgLg0KDQotLQ0KQ2h1Y2sgTGV2
ZXINCg0KDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
