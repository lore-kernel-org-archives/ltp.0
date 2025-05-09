Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454F8C3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 14:17:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 835E23CC1F2
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 16:17:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACF763CBEAD
 for <ltp@lists.linux.it>; Fri,  9 May 2025 16:17:02 +0200 (CEST)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C4A931A00CD4
 for <ltp@lists.linux.it>; Fri,  9 May 2025 16:16:59 +0200 (CEST)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549CwfF6021232;
 Fri, 9 May 2025 14:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=S1; bh=ZcQL93a
 6h3xMghEjrIQRVTGgtOBEUlSRRydaaV/kuHI=; b=MOycLHsCVo4/D+3LErzsKSY
 MYKr/pxGYBfqI8PJgmNzlCJ4+snWT24gXnBShFB5CvjkrlfHDjdUgrR4w5MVKZEW
 byhmQ2WhjKiJ4k16k5XBx70d/nyQo+N2n6zt9i4+d/HpzcccTkS1qm6MViE8SPQU
 10Vv9hK3Sls+qDtV1cAPIpuaAPY6QkZLDRpxgU5upR/JiUW2Xr20MSFsCwgZDXR4
 wK2jK0G0HkUyK7Ga/9tsW33yDBgBPrNWOYJsIOAkzD9FNtA/ETIteFrKKuMG7GMP
 /m+td0/TxyCSJTxRFTvQNbXr7q1Qg+oylfc8dp9fJDs4nA94s7pZRiVrR645mjg=
 =
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 46gjj6hhc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 May 2025 14:16:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAgOSQMqgQeUOyq9bLN+020IQGJUgGMTuNO+q0lHDiRcdtVH2ANrTV6BNc6yDegbgQhR0f+woFtUzmwgrDBtF6JbIy0NHuvRRbJvZHjdtxszbYkHzrQDeHOvW8aanMTQ8Q3wo+2QVUndQtGGbD+ZNM6FfgaUUCyQlxnEBG8cYPj7/AZX+aSzOZrNz2YFIM9Ofg73/HfD3V0JeQfCiNIYG8MnSsJRVLWEYXH+y+GtSiPvylAHf13G+fnGoq+RGE/z+FJpU+bP9GXr6dT7vfYBm2ho5SkLhxMxFguyNic96RtX/VYSUL3PQZsZsnwRpyuwTVaxo/dhkAMPEZDP5NYfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcQL93a6h3xMghEjrIQRVTGgtOBEUlSRRydaaV/kuHI=;
 b=S/wbNZFhHODepQVfK84HR+oD7plg0BlCh1hOQfdFOk/hGaX6NNmWCPJmuTPwPLSRYztLlZRFCRTetLjxrZAfJRKc+J1NCnHo0CnOT+jREgDxVlxcrUK9XD/ROp71XPx6VXZV8+/5EuDpy16Ey5ZdHBsSY2Jn777oSYiyesLt6XbDmR8cFSo21qjXBXLiju/8CF/mSfnAIQUgk0csKeG4RxrrP+zjUVEZpelY5fFvrM3nDF3e2KbxOocxgPdV22jYqVp8S512AAObwou8UgrlfWb7ed7EH0+8+XCdda0Zch/nigXDE7U7bDbsZkao/1Qw7KbHdZPM+/tg9zk9L1Fp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by DM6PR13MB4003.namprd13.prod.outlook.com (2603:10b6:5:2ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Fri, 9 May
 2025 14:16:43 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%5]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 14:16:43 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Mark Wielaard <mark@klomp.org>, Cyril Hrubis <chrubis@suse.cz>, Martin
 Cermak <mcermak@redhat.com>
Thread-Topic: [LTP] LTP in valgrind :)
Thread-Index: AQHbuMbNDQ4Cl1Kp5EiZ7v+gIXn+wrO/HYaAgAARrACABJaggIABg9gAgAIJfACAAATPAIABnPwAgAFy+SA=
Date: Fri, 9 May 2025 14:16:43 +0000
Message-ID: <MW5PR13MB5632B007B46225B5D7036A2EFD8AA@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <4428939d-dc71-488b-9728-030accaca3e8@suse.cz> <aBh9Z4QA2YcdOFq1@rei.lan>
 <20250506080520.GA64990@pevik>
 <20250507151148.yhrnckco7zkrpfzw@lida.tpb.lab.eng.brq.redhat.com>
 <aBt8PJNmiJNuSEB5@yuki.lan>
 <adfcd1e3f129c97c2132a138e70599642566886a.camel@klomp.org>
In-Reply-To: <adfcd1e3f129c97c2132a138e70599642566886a.camel@klomp.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|DM6PR13MB4003:EE_
x-ms-office365-filtering-correlation-id: f97dbc04-ffe3-425b-00e0-08dd8f041fd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UXJCOVJYR0N1OXZjckJ2VXpSZjlWQ0VXeXhFaGszMkpYWnMrNExTYlRnWGZj?=
 =?utf-8?B?V3dJaHk2TUV1RWtncHNveVJYOHVZODFtb09sMnNsUHQ3bnN6aHVVOUFYNnlL?=
 =?utf-8?B?THZWS01oUTFlM0RmVjBSZ2NTbzNMRjdEdWNwbktST0hSZUFHd1FocGxsb3dx?=
 =?utf-8?B?ZjhpZ3p1MFdWS1RoSGpSUmErM3Q5ZmNnRXNNdjF1VTdQd0NIUGJRNFlhTDlR?=
 =?utf-8?B?bC9Ob0dEd294dmdFVzIyRWdkbHpKSEFzMjFRMzdpSVZ0aWpEZjBEOEV6a0FW?=
 =?utf-8?B?TVB3VHBjRko5bVg4Q0ZRaExGMGhnbjFqMWtrZG15UlluYVpoWDBBMXBRcFNi?=
 =?utf-8?B?Q1pZS1pZa3Vnd28vV3RtYTZodnd4U09CS3R2L1ZraFlVTTVWWXk1R043NUIv?=
 =?utf-8?B?VjFlazJuRzRkRHRkZ0ZoTTIzMW1aNi9vZWpwVEhLMUtrQkh6QlAyNUxuU0ty?=
 =?utf-8?B?UWJYaEsxcmZGb081Y0FtRnArWXpMcWZIT3EyOFVNbGYrQUpkTnhlSjlyYlZU?=
 =?utf-8?B?TTZudHA5cmxsQ1Z6c0htZ0tOVW5IUUU0QkZMZlMxOVJudmlrdUc5Skx3NTk1?=
 =?utf-8?B?dUFsNEExYUZMZXV5U0N0TE5QTk41RkEwK2oyRG9NYlpoNHFoRkxpTU04ZlFJ?=
 =?utf-8?B?U0c4MlRJUkpEalMySGJEWDRmb2dXYWFuQjRLT1YwOWZRcjF2K1BZV3huMGhC?=
 =?utf-8?B?bUV6bnRCaEMrdlE5NlVFL3BwNGVvTmJveTJodGRtVVV1YWlOSXAzeHNGUmx2?=
 =?utf-8?B?UTcrbEFzTEJDTXhkaWtPejg0UDFxTDBHVm1HSHYvSUV5YmNnbnR2QXNhbEZC?=
 =?utf-8?B?M3dVUVNZd1NvZEkwL0Zvb2hBYVppeHZvZFFJMFlvMjQ4NjJyL2JuNXBZZWhr?=
 =?utf-8?B?dzFZblROdmNTZVdndEFubkFvSGIxcUNOeVJJS2k1YzIrRkYxODR5ZURTZFVE?=
 =?utf-8?B?WFdvVTFtcFI0ODNMVzR6eEJEL0Nid1Awdmo2VURkREtrV0N1cHRvdUR1d1l4?=
 =?utf-8?B?eVhGSVNPSlpBL041T1oydkdPNmdIYzhienFBeWlqSkhnclE1Z1hjR0JWNW96?=
 =?utf-8?B?Tm5WQUdqRklpMzJxZDBHUTNVNEVCN1hWYWVmdDlJTFp0azJsaW9PK3ZWNEZ3?=
 =?utf-8?B?RjlLZWRHLzgxa3VwZjF4cHVqVXhqTXNLd2o5YW1NVmJqTjdSQ095cWx6M2ti?=
 =?utf-8?B?aGtzVDczbm5xcWlHTmNHRk5uYVJTTVlLM3pmYVRpWUV0L3dPZXN1bWZTNnFm?=
 =?utf-8?B?R3lGYjNhRlc2dDNRcDRVSVJXVm5SK0IxZnJXYW9UaFpaWVc1WXFRdDF0MHkw?=
 =?utf-8?B?T0R2d2Z1SkE1bkpiYjhLU05YUWd0UC9EWlJkNDd1ZE0yL3BTTU1hMTltdXpv?=
 =?utf-8?B?N2tnc1QrdHJTZGthZGVWNk9DWG9zenJveDFtR2pCZHJSOG9adnVaMDJZN2ow?=
 =?utf-8?B?TVBIVkwwY1RNT1dBbStJMW1FWnBJQkd2bWxtZC9rWmllL0docHpvdi9kWWJQ?=
 =?utf-8?B?cVF1VVNZVGFZTHYrUTJ1a3kzS1VDTDRiTUdGWFA0UXNIYzFBWG5PWXdhR3lE?=
 =?utf-8?B?MnljaDFZSG9TdUFvM2tOOWJZSkdNVG42ZmNkODA3MXNMaUxObVdNM2NDOHRG?=
 =?utf-8?B?ZDZVRlhmajhMRXF2RTU5UjJhL3ZrUXN6NTNIWUhscnFsN3Y4cUxXZDNsN2Ur?=
 =?utf-8?B?YTNub2xXdXo4UjVEQmtsdkd1REEyOFhaU2FGdjlSdjNQb05tMkZ2L0hkckQ5?=
 =?utf-8?B?bjZvTTFBcXJXSlFscmRoL1FHdmpDYmRXU29UTnA4dGZKYWlKM1ZTNHVZZXBD?=
 =?utf-8?B?SENSSmM1S3BGSnp3bW5RRENZVlZjQXZsamt4ZTQza2RrdGdoa3dGd0tzL1lF?=
 =?utf-8?B?ZjgxNjNpaCtwTUlqMy9aUnBYbjBnSGFOb1NrbHZ0b0lNeWFUQXRQdTY0RE14?=
 =?utf-8?Q?0aDUX1Ymz/E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR13MB5632.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnFUK1lqOVVBWWxKWWRFekM0UDRzeC9YaXB5dWNPQkdsQ1pRYmxabHNNZmx2?=
 =?utf-8?B?ZzRMV2kwcGIwVDFTQ2FnSHU5TithdC9raFJkdjZKQ1cySTNNcVBkYmlNbnhv?=
 =?utf-8?B?YTd1UWRQRUwrU3Jmall2Qm1XbmVubUVRVTlxTWNqZGQyTWN1UUlTYUtqNmx1?=
 =?utf-8?B?bVpTUU1iSXlkeXYrM3l0ZlBwUlJ1NmU3SFhTQjUvMGxjM2x1ZWFsVlBlVFJ5?=
 =?utf-8?B?blZjWWxHSmNyMmp2UDV2ak1KQVVKRVBzSVkza1h0MGd1NWg5RG1zWThhSU5o?=
 =?utf-8?B?TXRQRDVMY1BDOFRtQTVVRnpjdkg3VkFWOGVkN2wrVXBVRzFBenE4YUp3am1Z?=
 =?utf-8?B?YVFPNUluU1pxY2VieGNzd2xWcWNmMDF5UEZLT1JkYU81R2JXc3k4c21RbEVp?=
 =?utf-8?B?eFI5cldFU3JaNXQ5K0lDUUdCYXFUNW1IL3AyRVdSblZKNjlyT0VERzg1THpS?=
 =?utf-8?B?dmh1ZHJ3U2czSjFVNFd3cHovb1N4aE5sUHU2Sm0vVXgxWVo5cVJ4WDdDZk5S?=
 =?utf-8?B?TWV4OEFvSE4rU2VaWkkrdEM2Y2FnSWVsQUJteFdLaDRBNE5BTXRRaUJVS3Vi?=
 =?utf-8?B?UWlEQUJnd2dlMXNIMHBrTGo1ditDSUNVM3JrVGxpNGllcEtlTUYvTjlZNUg0?=
 =?utf-8?B?RWFUaFZrb1lad0lXV3NmeFFqTmt2KzlaMnl3dlBuOEJIbWR1TzBDOWJyd3ow?=
 =?utf-8?B?SngxSmt4L0toVW0wZzJEUVZEa3ZxZ1p2Tzk1K1dRMWswWXZYeTQyVUYwTS94?=
 =?utf-8?B?eG1ZT1huMjkxWDZDY0YvQnpJbG9xekFyZ3pNYVdsTGVFalNNbzhyWUxxb1Az?=
 =?utf-8?B?V2w5VkRTekhZYXJqNHloUlZsZmVXeUYxRmlzVEx2QjRRWS9PcVZyV2lEOW9h?=
 =?utf-8?B?T3Y5b1NmcXpXUjBENW41dU5mdVhNQU9pek9KT0FOcUJEMzkrNXovdFBhVlQr?=
 =?utf-8?B?OUo1WVF2Q2hpL3YxUjQyTkJyU2JiV1crTVROVFA3QkJIVEtoQ0hXUnN0bDhP?=
 =?utf-8?B?V21ORXEzN2ZYRDJzNUQzemdoMnVVNGN6MjZ1M0hLMmd3bGt3S1FEbGRHRFRP?=
 =?utf-8?B?TXg2N1hPWkRBN3MxQURmOGk1UTNweWpBdXo3NGZTTldCNUdBVWpESlkvbDRt?=
 =?utf-8?B?NEJhREYySjVRWDlYNHZqam53MUJISitvQkdVaS94aW5GNWhYKzFPT1VPK29H?=
 =?utf-8?B?bGFtNXNaMzhJeUV5aUFSOE43OHpMSS8xdmlGTHdXYTFrbEtiMExvOW5CRktW?=
 =?utf-8?B?L1hleVp6dmNoMTFYczhuK1ZRNms0cEhmMVFjWG5wYzVyT1liU0ZXb0x6Y3VL?=
 =?utf-8?B?VlhGTENqWVFTOU5IUDB6MFBXR3Y2T21oOTRna0x2WFRtcVZPb3ZuVDc1UHZ4?=
 =?utf-8?B?bTc3eFJHNEdHaXd2TDZuU1ZrdkJ1U3Z2TU1jOHdVc0NqVjZoRmFQYUk2U3ZQ?=
 =?utf-8?B?N3ozdXdldjZncnlKZUwvaS9hRlUwNnlVby8xcnpHc05wWENUd1VlY05mR2J4?=
 =?utf-8?B?cGNaVEI2SVVhNVhaMitZZ1Yza1BmaHNZQ1k0NjhkTGZBQU9SSXVRcEY2cDdR?=
 =?utf-8?B?YTZwRHgvWWdyYWFDZmNSQ3RlNFlOMDhtcEptRy91b3JwcUdDNDRSTTJWQ1VB?=
 =?utf-8?B?SEdMTjd6UWVXaVM3YTBQdG5YMDBjWFdNQkp4cWdDcjlsZ0JWdmNjU2FFS3Ba?=
 =?utf-8?B?SzhxeXpCUklkVit2bGFkUGJHOTYrK2lSV3BUZlBWODJaclNpR1lwT3krbDZl?=
 =?utf-8?B?VSswQjJGUkI0c1ZpL1lKWms5MDNGbU1aMys1QnE5cmtaMnRwV0RGcVpQUGo3?=
 =?utf-8?B?SGZFVHA4bjNyU01OM2pFVWNJZWlPTVREcndTSlVYUEFIUnVENTBvZW9EbThw?=
 =?utf-8?B?OFNnTmpSYjRDdGhUU252em9IZ3VZZysvR0VDMld1SXM3Uk1McUhwaWlRaGEw?=
 =?utf-8?B?WTdnWjMvQklsZjNHTDhkSHlsQnh5b2VVcjh2c3g5L25Rc1QzTzlEMkkyU1k0?=
 =?utf-8?B?VkR1RDNtTUlveGJxWC9EdzFuUTVLUDY2TzAwQVRMSmh5QktNRFpHZE9HTnF5?=
 =?utf-8?B?ckREcmlNQUVRTUFIQjBucVZCR2ZjOUo2N2NBTzV6YzN2NytXUXlGNWlNTWdK?=
 =?utf-8?Q?Av3I=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CV0N0j9liDpyhzdkGX/frtmnbV2RFCD30s/P6D5mlanBARsTTY3qjdmQaJX58FYvRqR8iQl2k2K1Ku9qb6U7H2sfxWmPiBR3yFhmBep2ATCeVmPb2e12JpcY477inIkVZpMPYuJVmgPeE48OoEeGp5j0T0x2vWXu/+Nc0ZaENkT60ChQNd/A3rXrl+iV0qHsWAiwa+XHNG3+XzisaKdybLudx+dSf+G2aAnF2vK4WLVW7dH/fFdNxVU1mHZpKDVw5WTUs+Iht0rZqfRK/z+p4JanOjXWSQTjb49m0zjNoQW4yEnuAjk8bFxHH4JUx8ZdPEafLK4aMzSqQmdjuLgv8u5p+oe6bq8r71xV4CAka9js7YMLhdt/MHwk83hRnb2wlLzAx/HXdW+PvtC+znGTfqIWnZfQ2+T4QR45DrpQ6+AAkQ8vu+EpfRR14eP68NyXcftHPYyfIApMpjZcYTQfKdKN7OMjgBsU3oc8ItgCZfZ5LzLYp+LmPIwJgMMN0xdr7CaAI6TwkjgCAsDuHu4nEVo/2QwiwEYxCNYvGvAI+YbULabDe4Y4+yKOarfeuN2sdLPV0whQp5hl+D0eCU7TQRHeHC+8N7id1dpSbyD+H4gzaQDZtN+aCOtNxyd3Z9/x
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97dbc04-ffe3-425b-00e0-08dd8f041fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 14:16:43.3055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPV8CIZGYHtcculYCjqhI1gaTGP1ma5aPahWcU9N+LdzOFyYdUm7JwrzHFHx/0loMP5qMyIMe2Z/eBxjo5O/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4003
X-Proofpoint-ORIG-GUID: kn_wTcdANPEWSgMYTkkKOPOhiW4-gd99
X-Authority-Analysis: v=2.4 cv=e8cGSbp/ c=1 sm=1 tr=0 ts=681e0e53 cx=c_pps
 a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=xR56lInIT_wA:10 a=VwQbUJbxAAAA:8 a=0Ni6rV8TAAAA:8
 a=z6gsHLkEAAAA:8 a=Yk7u0wc1ab2wCCZy03YA:9 a=QEXdDO2ut3YA:10
 a=MEv8DOuCJPEGjlO0Qob3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEzOSBTYWx0ZWRfXxUHsO3AJrWtk
 y3Z0CehTY/0qUhBVjiYGphWx3VDh1J8QIPCUleb7Gr91QLJfHKvPA6acDJtGzVLnD5saHXbOpN4
 p47091uoXfHl55ETEBaBR8mPiRrKudKJo4c3rXkcTVSJwvZVwtW9UY6oMdBYAYt9hNupITDrZ8e
 JkkLuvp+o8JNSjaZUL4pfn1RzGHzo6RymWLFNTVeVdEdjM3CpEHyuaIO+GxUqBVLeWf28ifyrSO
 CA+KDJwvI6qxMOvRbX3hDcYHvNsHu2BQh5S3R3oAJzSqymOKaZQt3n7HLRboE/Psxi8MejYCWXl
 hGUm16oyruTFv1hoUvk8CANSGC7bTe1XJoJyMe/jnszeDEniBpB/kYZSYllEUhVv2lQbgugJUhT
 v6jbEXGfLeyUN7+v4astj4ObdlBJjjaNhBdfuP9i1O3TD87cIzRT6a+D8cxScZxF5STMbuOY
X-Proofpoint-GUID: kn_wTcdANPEWSgMYTkkKOPOhiW4-gd99
X-Sony-Outbound-GUID: kn_wTcdANPEWSgMYTkkKOPOhiW4-gd99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_05,2025-05-08_04,2025-02-21_01
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP in valgrind :)
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



> -----Original Message-----
> From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Mark Wielaard
> Hi Cyril, Hi ltp hackers,
> 
> On Wed, 2025-05-07 at 17:29 +0200, Cyril Hrubis wrote:
> > > > > >
> > > > > Maybe we can even add an option to the test library to supress the
> > > > > messages in output, that would be fairly simple.
> > > >
> > > > @Martin @Mark: feel free to comment what we can do for you :).
> > > > Whole thread:
> > > > https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#t
> > >
> > > Nice to see you noticed!  Primarily we're trying to identify
> > > valgrind gaps and bugs.  For our use-case it's good to have
> > > reproducible test runs in a sense of identical test results for
> > > repeated test runs.  We got pretty close to this by only taking
> > > into account the testcase summaries at the very end of the test
> > > logs.  Any steps to get closer to reproducible test runs on the
> > > LTP side are interesting for us, and we'll try to reflect those!
> >
> > I've proposed a simple solution that would cut the message from tests
> > only to contain the line numbers and results in:
> >
> > https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#m98317262b25ede62704b005fcefc63c62198bb90
> >
> > If that works for you we can get this in LTP before the next release.
> >
> 
> That looks pretty interesting, I just tried it and it turns:
> 
> $ ./testcases/kernel/syscalls/dup/dup01
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_dupbmNNGn as tmpdir (tmpfs filesystem)
> tst_test.c:1907: TINFO: LTP version: VALGRIND_3_25_0-10-g0ce068434ec3
> tst_test.c:1911: TINFO: Tested kernel: 6.13.11-200.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 10 19:02:09 UTC 2025 x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.13.11-200.fc41.x86_64/build/.config'
> tst_test.c:1729: TINFO: Overall timeout per run is 0h 00m 30s
> dup01.c:24: TPASS: dup(fd) returned fd 4
> dup01.c:27: TPASS: buf1.st_ino == buf2.st_ino (6921515)
> 
> Summary:
> passed   2
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> into:
> 
> $ LTP_REPRODUCIBLE_OUTPUT=1 ./testcases/kernel/syscalls/dup/dup01
> tst_tmpdir.c:316:
> tst_test.c:1907:
> tst_test.c:1911:
> tst_kconfig.c:88:
> tst_test.c:1729:
> dup01.c:24:
> dup01.c:27:

Don't you want to keep the status or result (TINFO and TPASS)?

This shouldn't change from run-to-run unless the test is flaky.

 -- Tim


> Summary:
> passed   2
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> So that still shows the "code flow" and the test results Summary (all
> output goes to stderr). I think this would indeed be useful to compare
> if a testcase runs the same "native" and under valgrind.
> 
> Thanks,
> 
> Mark
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
