Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E23BC83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752252986; h=message-id :
 date : to : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=yuZo3gHhpZ/RF5SAfnLMAgzrC0VkwQKS3j2kdoPAwF4=;
 b=fmdGPqjJv8QtHA+7WkP0RRVPKUInnb13oOcchc/AxfPeXkXnt/ONX9uhBwAOABxrO49pD
 ymn8KQbbcJFFOrA1NyQzlImL7936E/lUzuJI1wZZxkqO2em2mbL6HXr+5F7cuBHFI3acb8i
 3I5Zrtwkkb89qRBaEpQIdHhifKa60Gw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03E903CB356
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 18:56:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76E7D3CA4B5
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 18:56:04 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D7356002A3
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 18:56:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsT04cJgBJt9c2nXX4udT5hIVhsNta5xXOEj3HvLtV3p3XhZzfJLw2UGUiKgEaodOynCos0CaTqdmf+kt3X9tQUO6iQ8bjJWwKQ/sWdr9+4qrLrHq9bbxtCCLe3xNXvuLHZV8QcRFJOcMu1ru5UvqMNtasR5eLleizEqkd+mnV1vNcZpVa8Xy7f53xzWH153/Ov50GkoT+tGUorZKgmGb79+WBLpmRkG6sbf63m/mSYfwg9MCAnBN4tbe1mT4mQTCLHfoGkB+DRg5j7QoMkd39uwpgnhRBjdmSUVwVbsALiXNQsPi5ZSO0oYBqx0VNIBPrOYGovKMd6khblLZ3egzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gui3l/oq/C7dj6hekmuPcVCwOZRQfFzS46SZKbb9HdM=;
 b=LQxMyROf4hyjmaZIpYk6+OLZ4VhLwAeMk+CXIe4MAgmCw3zkml7JN2hgJ42jX+mDuNAJSXuNhQqhO0jvMCDUk3HoM0hea3XXMCmEOzq9Jt3dlzsODgg2wE428x9WIe+A9I5+lG7kdXHlUzrwnscozF3LpRUwbCONP2O7ipcyg1Gx8pJBDr2n/sBpaK9PAq6GU956N4X3/GIb/hnNcJxgppfJUmSn5eeI+VseDRYx6ILHcycEuIvFr/DgcPDf4T0AuHQ8TjdimSVNL/DhTHDBB70ZvFjXZj26AOVbd1cN8aOtBVK6jGXI+oI4oDDtsx7451MXDNkZ3S8uqgIubxwnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gui3l/oq/C7dj6hekmuPcVCwOZRQfFzS46SZKbb9HdM=;
 b=DTpE/f4JiyRxev0n0bj9JniyUwe+i0fk7Iqm/K6F7PJyqLj4Bd8bmf7wcgbKddV4/y64R4OulbzPWI6E6rLmoQn+0TgOp4lSd8hbkc0rwxOlybA6n3KOXMGTtNO8EjwaVd7kC9QxJ/WBylMQHB/6bq9vT2goUh8AsD1D5Rdh1PLbH8iZjHohCksoPaJPv9Lc+uskK3D6WO1c7giweG33C2x1pFYHw1lD1id3Csfc1TnwaJDhSwvaw3luT1bFgKYCACN4CdgS5IaWfBMze3lR1gNle8uub+BmQ7xezFKE7IDy+vlnREVWgwZr8KFZ1bkLE78e30KQoChY5px3VU+m9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by GV2P192MB1968.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Fri, 11 Jul
 2025 16:55:59 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.8922.017; Fri, 11 Jul 2025
 16:55:59 +0000
Message-ID: <dbaa90bc-9f35-48f6-9072-0ab2b23dd6b9@codasip.com>
Date: Fri, 11 Jul 2025 18:55:58 +0200
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
Content-Language: en-US
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|GV2P192MB1968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba11d8e-bab5-4f00-3b91-08ddc09bcfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUdEcDErL1VZRVpQVVkzRjNJd05NRnpaTm9vVjNMN0pQSzVuR3ZteXhYR2hH?=
 =?utf-8?B?cCtvaGlFN1pQNyt0bVhieGlwUjdGK0xXR3YrVVA1bnZET1dtOE1RQ3p0R3pL?=
 =?utf-8?B?VXJuOHBkTUZySWp2YUYzSlpCM2NYdEl4MEZtOUhqU2M0U0JpZktmWTJVTXpy?=
 =?utf-8?B?ZEhDbnJIMFQxNTB0cWJOY1RMUGRSbmM1WUFFYVZsbXRpRGVSam1GN3FVN21Q?=
 =?utf-8?B?SWJ4cGhTYmtrcHFhWUdUQnpJUnZkQjNjaEtzTVFHS0ZnbTFnQWRNM0NvemI0?=
 =?utf-8?B?NGVsK1hHRGlYREd6OW5YRk9vUC84SnJ3RjVXYmVyS1hROHJua0ljaWNQQnlR?=
 =?utf-8?B?R2dkWkluL3BIV1lKS1RFYW83VnMyQVhteFp2UDJQNWIxQjBQSkpXTGxTRkRY?=
 =?utf-8?B?U0dQa24yTkZoYzhCSGVJakZQL2lReHdZUkFleG9uRVBSM3VBdXhyU1dSWjRR?=
 =?utf-8?B?RGFQaEovNDErMHphL2VmWWhzbHNKdGFZaEpxdk4vVEE0cUdvbFozTFcyelVU?=
 =?utf-8?B?ZE5BMjNGZDAvYTB1S0FBUDRNS1VyaFZRdVBVb2t4NmdjU1VZUTZ6NFAwZEVv?=
 =?utf-8?B?K3JPTm4vbm9XMVBtcFFzSWhmVjluNGpQNHJRajlmQ1hMVFFKQnd0a0ZIaHlq?=
 =?utf-8?B?TGVDa2wwTEJXcWlmcWFnUmZFaC9hMnZKVENpdDFldmNCWFBKSElyWllWa0xF?=
 =?utf-8?B?ZjFaalRRUjlrR3NBOXFQM1pCNUtuczVBZHVEdmJBajNQbCtWdWtPcHZtMnZI?=
 =?utf-8?B?cy95dHFNaUdLc2ZpZHBrRjVuclNmUzhJZ3ltUk9YaEFtcmtpSlNvc20zYVZj?=
 =?utf-8?B?Y3NweUp3OWhiRjJCT3lFdlFacnp5ZmZwTjdWdHVFVmFLWU1meXVKbUF2b2NW?=
 =?utf-8?B?WWp3aG9MZHhQK1lvUVltYjVWV29RRG4ybmlSUGZPeEp0clZVdWFrUzNHblFR?=
 =?utf-8?B?WUdLTk1VVURyWnpwbTNaNndpb0JhVWllTDJabnJtSlNaeXpweVQ1Wi9tTm9G?=
 =?utf-8?B?bkZnQ1ROTmlXM0JzR3FLZ3dYVTNpQUVnV0NIbWVzb0hvVVl4YzBjUWZUK09m?=
 =?utf-8?B?ajMxRmhtZGtzYXhtdkY3YjdCYWFPOVRBN2lCTGhBRWN4VUwzQTZVaUg2OC9D?=
 =?utf-8?B?c1N6OWtadHJnc0tmUUJUSW9hdGl3NVBSYXpHWG9SSUUwZmR0TEFIR2pHcmJL?=
 =?utf-8?B?QWdHdHlWcFdtdHZFWFJjaDF4WDlHZ2tLcENiSG5Yc25WYzdoRXBEaVl5bnRG?=
 =?utf-8?B?Tmp0SlpEZE5zdDgyeDI3N0VjbWUrdjhFbFlDNWE3Z0s3bkY5SGJnenE4ZVhw?=
 =?utf-8?B?NWs5RUZEU0dhQkRRak5vYkMwMytGWXZ4cG50OUdYc1FkZXNOWGYzbVdUS3ZE?=
 =?utf-8?B?NURrMFZDM2tsSUp2a2pBNGZjQTg0bTVNakZUai8xdEgwTmYvamd3Y0F2c1o0?=
 =?utf-8?B?TG0xV2RTNTczNm9mZjVpVnlRNUlwS1JOT093cG9ta2NScWQrb1hJb1RjVlhh?=
 =?utf-8?B?TldtblJITWhLdmlSRXJpcWtwcmFGOGNDVTVzL1U4bVVITEIwZkFGbGlsZHhN?=
 =?utf-8?B?WndOQmhVZTNQelNYQUF6TUJ6NjJSRU1STVlJMCtvZ3h3YUViMWF0RVI3YnBU?=
 =?utf-8?B?cEdXTTdvRFZOdTJUSU01TmwwQ3BmdW1Ca3hqZkN6S1JKWmh3bk0vYjFqWHhY?=
 =?utf-8?B?WksyK2MxY1hCT0l3dllDREIrQW9VVDJKSWFrWXU5YmRQTWdNMG43cVNCM2Nl?=
 =?utf-8?B?bWtCSGVydGZRZHhSWU41QlR5NklBc0hCQTl3MWpDSitVS0JEWUVQTXlZWFpp?=
 =?utf-8?B?akhxMUVNbGY4MnpNSVpsWTByYzVyeHgvN3BZNlR4d0dxdnp2cVc4Q0ticFlN?=
 =?utf-8?B?RlVMU1hISXZFR083dGV6ck4rTWg3eVF6VmxwREdhSVlnUHRnQUNWcHdYY2Z6?=
 =?utf-8?Q?zuMT3SwCJ/A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRqSnNKL2IrRUZsMnBQdHRYOXYxbzdMSzh5THduRnZNeTZiQmJ5ODBqRk4w?=
 =?utf-8?B?T2I3c0VsWVh0VjljdmFsQytEemM2RmJyNDVpdXNlVE1hbXRKOEdLdmJkU3d6?=
 =?utf-8?B?NitqSi9vVkFzV0NFSG5JR1A2SHRha2p1NG9uVDVCYmVSOVpXbE5PM290S2lr?=
 =?utf-8?B?U0gybmo5Q0w3VjV0ZHpCRmk5NkVUYWcvYU1Jc0dCYTR3eDJPeDhBbmdkN2RE?=
 =?utf-8?B?Qzc4eGFwRG9PMjYxYkZWVlZlYThwYm02RkFsZmRvUEJtWkt4emgxZ3h2ODhT?=
 =?utf-8?B?ZFhrWVkxVlh3OEFmOXVpSGVmSWExSkhrUmEzd3pQdlNHVWVDOFlkOThxK3Bt?=
 =?utf-8?B?cFZUZVVsUFlOUmJIUXUyeWt1ckxBTFVmNDBhSWg2b0lTMHc0MDlVQVBxUUox?=
 =?utf-8?B?aEcwU2QyeDNRSXNhMFFPL3RhTEx6OWE0SVNlZTZJY01UcFVNNUltelozZUFH?=
 =?utf-8?B?UCtoLzlaMFFRRmxwc1FJVlgrdklmQjhmcmg0c01sMERid1lWZ2J2QU1JWXor?=
 =?utf-8?B?ZCtOMDFrQ2xCVkZFUTRlUVpYZUpPUzNtOEl3QkZOdzB4QVBlWXZLTG1mRjgx?=
 =?utf-8?B?TGRaZnVPa2IzV2dKVSs4anV5dHdiQnVYSnpTVE1GamlpWUZGQmFZTjlldDh3?=
 =?utf-8?B?dGxHT2dPMkFUYlpieGx5VktOdTVwdVQrRi9pcEpXMUQ1WWtOZ2x1Q3BTdUJT?=
 =?utf-8?B?Qmx1cnlPVFVkczdNOGV1dCtzT3NVOWFPZlRISklESS82Sjg4amh6WG9hVEZ4?=
 =?utf-8?B?TTZYM3lyS0lOVW5sNWUrZFdvd1p1SEJYK2xWVm9lYk1iYnVuOEhzK2FROHo0?=
 =?utf-8?B?byt1SEpJbXp2d1VSd1I4Q3FCTHo3cjJiTVo4aEZmZ09xTGFHeklya3gxVnFZ?=
 =?utf-8?B?dlIzY2QxNkJNbnlIZnptWUhaRlZwWm9QWlNoSHJod0dDaGkvbkZtREpSaU1n?=
 =?utf-8?B?TXQzNHAyNG9XVytKQzNrTEtZanRPc2hwSi9WQ3RCL2c0YXdPQzhOU1ppZUFI?=
 =?utf-8?B?aXJnbjlVNDdlQlBiZHdjWGFMRkt3N2VkZU9NM2Y1TkJWbFdKbGtjUjlycldi?=
 =?utf-8?B?dFp3eHFrNUxPLzlmZ2JvdklGak11U2F2ZU96RitSM0h2YzJpQ1pKQVUwRE40?=
 =?utf-8?B?WUhNMThmWmFQam1QaVZCaFN6QVQrV2RjRzhLMUhKWnc1d05EdEtoRERhVG52?=
 =?utf-8?B?VmNoYTdNZkpYS2NiSmx0SlkvU1poalhZaFg5dWg4RjUySkhubEo2YkdzVWZv?=
 =?utf-8?B?YlBLRXhKb0tSeUtEYWFsdGcvNlVsS3dhOXBWTUNDMjRiL1h4RUxkcWZLVUZL?=
 =?utf-8?B?THhnb3RsVDZPbTdzQnNjTWlWbmdndi9QTTY5akNGVnhiM1U2YkM5STNabXNP?=
 =?utf-8?B?U1YvdkNhOW5nTm4zY3E3REthRElsZFE1MWJZbi9tNHo4TjVNMnpQckIyM1hP?=
 =?utf-8?B?UnRXWFBqUDNRZnk4UCtUN3JrTWZyQ1dmUkx1d29kcmNPS2t1V01OdEpMTm5Q?=
 =?utf-8?B?U056TUxNT2NGTTB6cEYzZ1ovVVNrU1hrWjRiQW4vRzFBUlZRSWlTODN6dU9M?=
 =?utf-8?B?UXBzK2tNbTJUay9FcjZ5NWJhaDIyaGNaSGNEaTV4b2pCYjFqK0UxbEtvWURa?=
 =?utf-8?B?RDYrRWpuZ2p0bmRqdEYwWkVPQ3d1d2VFL3FTckM0c3pGVUx0eHY5Y1ZNYmQz?=
 =?utf-8?B?azl4RVgzVEsvWWxxcDRhdlE5bHRRdWxOMUlZbHJQWWwya2laY3ZZemFVTDkr?=
 =?utf-8?B?ZFBxTzdXck5VZXh3TEtraTdEVGswdEk4OWZ6akk2Q0pXV2NSY1h2NWZGM2pO?=
 =?utf-8?B?dzBoU1V2c291b294TU8xUEVHaG9FbjNyb2kyUFVCbjcrT0g1dHJ6TzBOdXBM?=
 =?utf-8?B?Ty9adWM2S0pOSTdmdFQ3QXBBTmtrOXRWaHZYSWdWSmFuUjFTTWE3Y2dieS9T?=
 =?utf-8?B?NTA3bkY2UlhiaUVQWFNWQUhzY1J5Mkd5NUk5NFBTdjhMRVN1bHJkVGtpcWIx?=
 =?utf-8?B?SVZlbmNlcElTb09jMDZFVE5XYmRWK1BQdWltdUU4REQ4QWgrQXl6ZGV1elJH?=
 =?utf-8?B?UG0yQWJGRU9GUGdRWVJFTUdzR0NUdUxpd1VFb3BxL21Jb2FnNG9mY1RwK05S?=
 =?utf-8?B?VmZ1MlRub3gwb0l0V0dwQlZGcm4xdERLQ25kaktXYkFwd25tWUF1d2tSeWVI?=
 =?utf-8?B?UW5lKzdTSTM1T0d6RDhMVThvNHJ2aVFOaFJDL2Q0OTVoOUF4c3ZLNEF1cXVI?=
 =?utf-8?B?MGpHYXZLRm00cmNuWXNmNXlTSDR3PT0=?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba11d8e-bab5-4f00-3b91-08ddc09bcfd6
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 16:55:59.6680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsA9jECFq6UfYQVFFxOnKD6P2GzCukDztuAyzHWc/WiQoRFFg8onOt6cnNc53ZwHWN5Gs3zCDtPIK7iGUG1YDQaCIt+relt8Mlukdl653Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB1968
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify22: Make 'dev' the last debugfs argument for
 musl compat
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
From: Florian Schmaus via ltp <ltp@lists.linux.it>
Reply-To: Florian Schmaus <florian.schmaus@codasip.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The debugfs(8) man page specifies that the device to operate on should
be the last argument. So instead of

debugfs -w /dev/loop2 -R "sif internal_dir/bad_dir mode 0xff"

the correct command line invocation would be

debugfs -w -R "sif internal_dir/bad_dir mode 0xff" /dev/loop2

The former works on glibc-based systems, due to glibc's optind
handling. However, it breaks on musl-based systems, where the
fanotify22 test will hang because debugfs is awaiting user input.

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---
  testcases/kernel/syscalls/fanotify/fanotify22.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c 
b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 20c7a6aca243..357e74dbc702 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -61,7 +61,7 @@ static void trigger_fs_abort(void)
   static void do_debugfs_request(const char *dev, char *request)
  {
-	const char *const cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
+	const char *const cmd[] = {"debugfs", "-w", "-R", request, dev, NULL};
   	SAFE_CMD(cmd, NULL, NULL);
  }
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
