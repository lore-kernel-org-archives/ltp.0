Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D87FC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 15:32:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 048A73D0B55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 17:32:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E3C53D0AA3
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 17:32:18 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=sony.com (client-ip=185.132.183.11;
 helo=mx07-001d1705.pphosted.com; envelope-from=tim.bird@sony.com;
 receiver=lists.linux.it)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 439DE600621
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 17:32:15 +0200 (CEST)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEZPWE023371;
 Mon, 10 Jun 2024 15:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=S1; bh=SR7iHBO
 fDTg+sZO9L0vv7g9FFWw0z0qehizGfWxbn7U=; b=aeqRCNZq+Hssy7wNcw/L2w8
 Adq8L4b+hT2W8k9SI4pM1dZpEMUEEMUFRkuSKTh6AfsflfvR0uqGfPaPXmUtl+/T
 lqmzJnhO9ZScxeguWq6/a5QHmQInH5pYXhKQlvCghV/y/1Vqmc4DWeKamFQWtqyI
 72p33a1Me1ho1Sz1a9D5q0NUjAuaMN0fq8qrzstxnugja4KRK32Vy73A52zaO6Ff
 n077dyM8+vwQc36+oVsIhrtmfUn93xPMGq8XMYuWfosdCzFpXW5WZ8l7TKsosMCz
 RbOd2OkYn16brXRbB/Z8WO4aIVG7YAdc4nNiynmP1y5dU3nH4DFJOeKkMJyZPug=
 =
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ymhuphu6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jun 2024 15:32:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9iB+RzAZ9vJY8DK+6pBwH8AmH4cf4Kl5Jj04lB6ezaTZBM+HqrpoPZEOSJupoE4PWsKCknBhfIMOjldL5jXr+EsYlENWbtzrf+CS8cVWNcLbVqkFYpWbSLnUpbst84Mf5xP3ZAKLIGHSzgYdZrZ7GcqT5j7k+PNrilM2qdBotzjrA7g93Pgovmuu7H/DZ8HpBD2VL4t4w8VnSkU1sS2qzhVqEc0vkMwTbKbFDOlCVz8gfht53/Ex+Z7uTr91sHd6YkgawYRBWtQZu8Ll6M7rUe0A893kj41+4JUGfqVri4KCOjkPQ5hRQ9hG5JyQ9N7z/SKOoIyqeXxYCYFu9D6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR7iHBOfDTg+sZO9L0vv7g9FFWw0z0qehizGfWxbn7U=;
 b=QgnwmV65mQyq0aSAsZGOyy2Zuu+VH7jclPVt9ZK8nW4leikSP7h32S1oSGpLA1cg9v/mT7DjCUTdtp2OpVTg4jLV31tQyOzNwtDCJEHP9+RdVegMVb1bE05k1juWDcudA6bEBhYYMM4efYz3X80M/mrsEvTSoKYtbOg1qPOekA0odggchITpK1kqTgKFmgJUf3bgnvDNBDgS6THsP5cuhvNEFCo3IhogVlqFK88+6S3qqszQvvMr0OVlynE5LtCH+rgfOCw9hHncetIed2stdW8BnVNSnDSlPCKp4y+MpAo1wsZVYq0YhS/rUY+HOJmKqge5hEU23Xh06C8VwghPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by CO1PR13MB4935.namprd13.prod.outlook.com (2603:10b6:303:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16; Mon, 10 Jun
 2024 15:32:08 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7677.014; Mon, 10 Jun 2024
 15:32:08 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate, add
 info about kirk
Thread-Index: AQHauOZtg6jLCnSkL020MsAFSFbsVLG8YjUAgAAPWQCAAAZtAIAAB7gAgAAG7gCAAAkugIAAOHwwgAPRtoCAAIkP0A==
Date: Mon, 10 Jun 2024 15:32:08 +0000
Message-ID: <SA3PR13MB637200A7A377000193BAF3D2FDC62@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
 <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <4a19e93b-b009-4b0f-9be8-8c348a9ab214@suse.com>
In-Reply-To: <4a19e93b-b009-4b0f-9be8-8c348a9ab214@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|CO1PR13MB4935:EE_
x-ms-office365-filtering-correlation-id: f72175b9-af49-454e-2c4c-08dc89627d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?K0hMS3B1cEQyVjU3UnFuaHRzUlRUeTBiYjVOdUlsZFZsMy9UbHVxT0JCMkIr?=
 =?utf-8?B?cHMyZzhkNjlBZWIyRElCbnRrVXdEWGFMK2ZKVDluaUhxLzNSNVFUMzN5VGov?=
 =?utf-8?B?alp4L0p5SlhFVG4xSTFpbzNpWDl1dkFHNklyYUVDUldhTmZ0TFIxb25VNmhY?=
 =?utf-8?B?OVJvdkJsbkZxTTM0RVpUWW9xRzFyUmltRDFMRGZqY251NWc3VXpCdElFYmov?=
 =?utf-8?B?VzdKL1RtVTRPejNMN1RBK2cxK0p3a09UbVYwU0JrWndoRk5HK3hreVkyUHo3?=
 =?utf-8?B?eWFSckdVMjBDMDBmK0tVUGFYWER6enlrT0J2Ukl5eStHMHd2YjJNcUNWa1U3?=
 =?utf-8?B?UVBibFpMZ0drY3Q1eWJTTS93WnJuWW9LSTA0emhvZnNxdmQwL3hxSW1nTWxR?=
 =?utf-8?B?N09UOGtSWkhlTUhPVkkra3NTK3YrblN2dXVhcWdnYXAxMC84cDRtUXdraDI1?=
 =?utf-8?B?Wk1JV1lkUDcwTld5OGlITmI4K3pIMXk1Q0xCNm5BaGRzMkxWL2JxbFJGMDhL?=
 =?utf-8?B?ekt0U0VlYXp5SnY4Qjl6aHlqZXNuK2ZCczVYQVNVOGV4WXRsWEVOQkxnVTFO?=
 =?utf-8?B?U3I3V1hPSkxlOVNVZTVXQUpoTmcwODlzV2lPM1JJZTdMclhqUndVVVoxaFov?=
 =?utf-8?B?MDRLZUpXK3IycUxrRlJyZWVyN015TUhqRWVaUmJoQnJVclg0YUJGYThoclR6?=
 =?utf-8?B?dU95NnZLa29hMDdzcmdybTVaeUZoTW5BWmdUZXBibnRWaDM3OUFhaHltZ1ll?=
 =?utf-8?B?emxMMnNVYW5YUkcwSThENDdqTHdFa0pBVEtRU0NlanVMWk9WUmVqd1VSaDRx?=
 =?utf-8?B?d0ZySUt0d3JHbC9VSGVFaFRzcE5VMHlhT1lIK2FESWcyMXcwdUR4SmRiK3Vn?=
 =?utf-8?B?VHcwaDJVQmQzM3JoeE94Mk9aTldrQnVzWXRzaGk0M1psVFNxMXZZZzBPd0ph?=
 =?utf-8?B?dytkcWtNZ3FNcjgxaHpKZlpmd3RLNExjclhydEpJV1VuNk15WjlVMWRKY0Q4?=
 =?utf-8?B?ZDM2NnphcERLZFpndWNjTk5jQzM3elgyS0pZVGZUenRRcjNNUHdndWpyZlVo?=
 =?utf-8?B?dzF1ajY1bno1NVkwdzdhd2lybWt4QkE0TGtBcmVLMFhDNm9HT2N1V0loRGFS?=
 =?utf-8?B?YXk2bXdWOE9pSUtrOU9pRG1JS1F2azRBUmtEc3J6V09LZG5OUmJJSmVlOHlu?=
 =?utf-8?B?ZnltdWFGN3A2MGdHR0VVZVZ1SFhqZEY4YVFZSFU4NVFkSEFVT2g0TVhCTmJR?=
 =?utf-8?B?SXBTRHdxRnJVc1Q1OUYzZm1yRHkvbVhWSm5KRFlISWxFMWc4OWxyem9KVWxG?=
 =?utf-8?B?L2NDa2pDeXk3NS92Y0dOUjZSYmdmei92MGhyNjlVM1p1YXRKRFErSWsrTzdQ?=
 =?utf-8?B?cEZlMjcxZGszbEZiM01oUTBFdTRUbGJVSi9XcXdkZnFPWStzeHlqQXU0YSt1?=
 =?utf-8?B?ck1WalQyczlWblV3bkZxY1NoYjFnYk96L0lKNnFXQmVDa2ZWeTIyb3VaQU80?=
 =?utf-8?B?Q0lzVUZySWltMzBkTkxPejNVM1d3d1dGQXh5MUhDdFlFaEtIQXBIeXg4dGZB?=
 =?utf-8?B?bTJwRjlDUis4VzRSRWloT3ZEdGhqUjVPb1Qzb3ErSS9ldFNNVzZNdTlKZUV5?=
 =?utf-8?B?Zkh3dkc0RjdjeGhvQ2txaTNtRHlSQ1NYam00eS81dlM4WjVreHhCajJSTzli?=
 =?utf-8?B?VXZHMFczaVlha1U3ajFXQWd6Z1MrVnVOS3RCbTFSY1ZQb1V1K2w5WnpXaHFF?=
 =?utf-8?B?Yi80ZTZpNHdacGVOU0VmbWJ2cWU4cWtBOWtlWjFlM282VHVMT2VoY2JmbGhv?=
 =?utf-8?Q?+FbVmAjGcHAQJ3tDbyTJGwIXpX1Zifmg/dPDM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR13MB6372.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3ZrSXAxeUQ3aERNYUdkNUpuUUEyK0o2Y1Z3dlo3V1NFVWFFeko5NURaa3ow?=
 =?utf-8?B?MldNVjl0N0NveC8zSHF6RG1PTVQ3Y1FHSHNJbTRxVHFLckRLTXJNSmcxQWJm?=
 =?utf-8?B?U0c4WDQzWU9tcm9yZmVXeG5DS3c1OWp4ZW9XUklxNXhTMG9TWWUwdTdoY1dR?=
 =?utf-8?B?MEtIWkpFL2Npb0Ruck1CTEVndDVVZ1lTcXhkWG91Y3BjWnBwVk1GYkQzRWlz?=
 =?utf-8?B?MjRUb2F3ZzhpMlVGZ1FGRzYwT0psNTNUek1admdnQk9XT0t4NFIxSzAzdGVX?=
 =?utf-8?B?WXRweGJNeFBxell4cXJtdUhabHlTdzYwNG9aRHpNdlpubkV3bGpGWkt1bWg1?=
 =?utf-8?B?SXpRNGFOVDZXN0hkMnUyM1h4Ty9mYlZ5Vi95MlhOWWlxVWtrT2p3d3UrQVZo?=
 =?utf-8?B?V0hpWk1wZ0lkL1U2TDZ1YWwyalNmSFRUdDVEcFp2YnJiem9jZWZYVDNyOUZM?=
 =?utf-8?B?YUlKSFlCczFCdm9jNVRlU2xMeWxnTXRBSlh3c0pweVlXeFdiSmdHQnhjWFZB?=
 =?utf-8?B?SUhYUVExNm9CQmZwMmhQNHl3N21LLzNRSjJ6Z1QyN203dEtWay9SVzAzKzBw?=
 =?utf-8?B?Y2dKRHlYZHcyY2hiKzJ6dzJtankyWFNxc1UxZE4zOG5scjdxeHc0b0syUHQ1?=
 =?utf-8?B?SjhzZzBjVm1XL1NWT3hvbm9scy80dG9SZFA2R0h5NWZUSnVPbDhDN1RmL2to?=
 =?utf-8?B?MUUwbzRRRE1wYWZ5RlQ5aEk3VFJlTjhiSjJQS1FHWEFjdEo3NWZDd0NUTFBl?=
 =?utf-8?B?eGpMNmN6dGdBZFFTMzhlb2VCK2x3RzBRcjlxMnlUdEVKcVpOYnBjaUdxSThI?=
 =?utf-8?B?eXJDbTUzYlRsaXFiZ2JNN05kZlR5Qzc5Q0NtNmI0V254b0VyOE5abkp0eWZC?=
 =?utf-8?B?WDVPSjUrNlhQQzB2WlkyT2xGOFBoT2R5SGhNL0FmQ0srTStsWXpsZGRHWGdv?=
 =?utf-8?B?cHh1dzhnRWxsRUZWdW10UDVSZm0ybGFBamNKQ0kvdk1JWjhQY0J1VHhoN0dR?=
 =?utf-8?B?a25wdlpvMVJKQ0RNRE9QMGVuNVk5T3VwRmRTa1ZaSDBvY0FjTm42SFhQNTM2?=
 =?utf-8?B?NDIxaUFUVFlST2ZWT3pTeW9PVlRhNG5rRW11aFlZS1JQVE1obVhUR2g1c0I5?=
 =?utf-8?B?dWVyemtjQjM3WlRVQlR3U0lLUGN5Qkt1R1RodnV4Z0J4WGtxZ3ZCS1gxQ2h3?=
 =?utf-8?B?SVozSHBXQ2lOWU5mVFRVYlNQVUNyQ3pHNGR4VlVVQkl5Mkh3K2U2aDljU3pL?=
 =?utf-8?B?K1h2RTVKNC9CUWtlVk0rTTdoR3c2M0hYdnpJZ1VndjBMVEE3Yml6M0JsM0xz?=
 =?utf-8?B?aGhJaU5UbUFwMGFYZFRteVNlNUpqbFhXMUxINnFlVXptU3JFMFpNLzFCVUlz?=
 =?utf-8?B?d1JMZGVXL2kxS0tMOFZ3ZUFBV3VwenVCZHRCbmk5TVhTSHJLdW9xZDl6TDVx?=
 =?utf-8?B?UzU0ZXhRQ2hYdXVtcnZnWG9QRWVUb1lUM2FmOVVvcUYzNUFtaGsrN3pyR0h0?=
 =?utf-8?B?ZGFnRWpoRXJxR0ppaWswUEJOL0hoeW15RENDYXlVVXMwS0VuelN1R1UySlo2?=
 =?utf-8?B?OTJNeHhCclFNMm1ud0FRL09rYzZuQk1Ec2piZW4rRTR2UDMxTjhwR0pCYlZy?=
 =?utf-8?B?c3psMFhMSjdRaUI0anFya0gzeTBlZDUxN2pqV0Q2ZDBxYW5vSXNCQnpDQXJC?=
 =?utf-8?B?YVFGODVzVUVvaDFzaG9sZzJqbDFRbHAwUEF2L0NjeDZkWWxFMXFlbnBiNXQv?=
 =?utf-8?B?VVA4ZjlsVC8vY3F5dE5VclBpVHJudzVyQ3VyQVFJTlNRcDFTNkJxVDF3V1BT?=
 =?utf-8?B?TkJzMzhmUVRzbHZEODcwRjRZREhabWRmM1JKd1BnMCtkMDJibCtLQVdFbDl2?=
 =?utf-8?B?aGpFUCtFa2pnbFBBKy9rVGQ3U1ZHdFM2Z1lGZ080SVVzNnZJeTZiUzlZTldJ?=
 =?utf-8?B?NExiTDVOTUYrczZiNmJPa2cvdGN0dUlxaXF0ZDVlQis0WnBlTE82Qk9qMGE1?=
 =?utf-8?B?UTFMNFEvdTN2cUxXZnZqYVJTMzlraUZ2YU5VL2RBbWw2K3RjWlRZYStqZkRj?=
 =?utf-8?B?d2h1T1ExYmtaVEFsWi9mTlozSjlFb01XNUNENG5aZkZhTXpiOSszMGorQ2Rs?=
 =?utf-8?Q?mEdA=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EvO6B80uHvYf05/qHkc6BEHq94TC2N9vkgcF3ga1J6PI9LXbGPqWkkzL890yOSN60v3GTcwLyZwTDaeltN7I3GD1YSO22Hw3NQIBDDJJeQRb22InM2yJaoJ8/144VEN3mDPov9YRrSQHVb33GUuZlmZLzb8Qb97rdiiXhyIvOCFANWf9VbFds93XHRjIMp85KdZXc5NXWO8fAc0KQZfv72WtV+PZFT3VlCwNWgQ2SSszcvgAMSQblTFjueMSD9g7AZGDmpfi3Ax/Cy5MIzull8hDph2sYgA6nfSNvPJ/7fV3kf/hvPWNslbHwTBg2liGoFTG2CnPUaD4GG+PEeNigNZEah1c3Z+1fX6m71ICO7ablwNTUXrr+Fccu6TlDnwYD1/Fxa3UdurM0PRDjxIrAV8YgxZKPkWuBZO8iAwlCTIcWE+7cL38TerJWLjm+iFz0wzDuyly+oshFC2pnRdTrwpzADXCj5lhE84SQXj7ZLOdYgmQVn3o80uXDLtC4tjN9S9DMC+FljP2a84AuemAKh4OxMCNyFuIemTZ6x6xcaVQiMGOBiBdv0iS+fEKZ0CJQduqtlGJna4vhJiGxPCOOnU45v5Rs540Z7LF4hS29UV5wlNoe3LfPEku9bOfRE6c
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72175b9-af49-454e-2c4c-08dc89627d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 15:32:08.1753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5N8U2KDow740T+/9pW3NLa3bDs6urHaZJRPf4IHAryPB27aR1hndKo9gnJXYQ0x1CFsOEEsklObMBfAv2ihdNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4935
X-Proofpoint-ORIG-GUID: ej0iVqgaYFR5__HcFKMwsH2DckeskC14
X-Proofpoint-GUID: ej0iVqgaYFR5__HcFKMwsH2DckeskC14
X-Sony-Outbound-GUID: ej0iVqgaYFR5__HcFKMwsH2DckeskC14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> -----Original Message-----
> From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Andrea Cervesato via ltp
> Hi!
> 
> My 2 cents below.
> 
> On 6/7/24 23:17, Bird, Tim wrote:
> >> -----Original Message-----
> >> From: Cyril Hrubis <chrubis@suse.cz>
> >>>> I'm afraid that's not a good solution either. The end goal for kirk is
> >>>> to have a small binary locked in RAM and with realtime priority to
> >>>> execute tests and send back logs, in case of qemu over virtio, to the
> >>>> kirk. That is to make sure that logs are collected properly even when
> >>>> kernel is out of memory and in a similar situations.
> >>>>
> >>>> If you run kirk on the VM, reporting is not going to be reliable.
> >>> This means you're effectively mandating how ltp be run and the only
> >>> variable would be the kernel binary. Whilst I can understand that, I'm
> >>> not sure how useful us testing with this would be.
> >> Not at all. As I replied to Tim, there is no secret sauce in runltp or
> >> kirk. In the end it's a tool to execute a test binaries. If you have a
> >> system that can execute binaries, reliably transfer logs and handle
> >> kernel crashes you can as well just execute the tests yourself. All you
> >> need from us is a tooling that will produce a list(s) of tests to
> >> execute.
> > I don't think it's that simple.
> >
> > Currently, Fuego users can choose to either:
> > 1. run a suite of tests (specified in the runtest file) using runltp executing on the target
> > 2. run an individual test, not using runltp.
> >
> > In the first case, since some of the suites have a large number of tests,
> > there are options in Fuego to convert the results into spreadsheet files
> > or PDF reports.  But this is based on the multi-test output from runltp.
> >
> > Does kirk provide the same output formats and output options as runltp?
> No, but it provides something better than that: a JSON file that can be
> easily parsed by most of the libraries out there.
> kirk can be literally used as it is runltp, with difference of python
> dependency. If you have python, you can run kirk on
> host as well as on target. All features like Qemu, LTX, SSH (etc.)
> supports are meant to be used by host only.

The python dependency is unfortunate.  In Fuego, we have carefully
avoided any dependencies on the target other than those that can
be provided by busybox (or toybox or toolbox).  This includes limiting all
test programs to either native binaries or shell scripts using  just POSIX
shell features.

It sounds like kirk won't be useful to my project.
  -- Tim

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
