Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ED1C2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720534272; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=o1pvefDylJGWLQODKDr9zFo332UH3BM9vnkJhNx2Mjk=;
 b=j1TMqYP4nBFR+i4H+CkjUxGCK0zRCNErYeM1jKHtHx8K+UiX8zD1r/QFDNYKEVRgMR5hT
 REuEoHHvDqqZXN870t+8k1i0R8sDrmyzzPuV9tZ36oLLG66MLOKx33mYoMgp0SBmiR9M4mv
 xUjnTvOhge+BCSuyNT1uScFT3elgo0o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DF333D3945
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 16:11:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CBB33D3905
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 16:10:49 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=gulam.mohamed@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B876A1400DC7
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 16:10:46 +0200 (CEST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT5i5024978;
 Tue, 9 Jul 2024 14:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=corp-2023-11-20; bh=lfK41e8V7uqhR0
 /WdW0G8ldzINWGsajPbWDFdIpW4l8=; b=lCBLlM5SsAB4Hi447M8NhYBkCuYexQ
 EQIx0zAseL6OM3VUORpy8puJW2Mrhbw8tjTzJy2cSBuwxUDR+UABQe/Wjn7gCBkt
 3y3Hia/bmC//Eg+OqlnKclkR/hEoMEsuD5D5DdCN8/+y+uclu6vFFxuwdBDNmnhO
 cIeAi8wR1pvBq4usZcq7cYKMZWyqk1UR35Cb1gcLgm+1uE3fNtf/kAZhsaZQBXqM
 6kPi7MoKWpBuamwtEU6aBclLh7QIpmMM7tV+3mOrXz/BVYFNA+/rQ0jalY0m37ft
 fj36h8SY5nBxC/fWdldjSbp8c6o3XbbYJ+HQjj8FysePsLxZjDBGMmag==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky52jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 14:10:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469DTwxq014580; Tue, 9 Jul 2024 14:10:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407txh11mh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 14:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF2QMYaiX9LMe3o9zeck/gpcbVtmcMedkEDNirwDPBTvKZdB9wL50pfZUwXza7qRPJ2tiOWCxYa/U8WG9mvLx31kuARJPHVNugJHOs3uiy/h0sWCENXQ5JUvI/PeTT4FH+Wuet2uhtQtygx82wnaDilGrHOMlfO6fPjiL+DhiLUjWhKBQKd5GcOAqW9RBYi00wNxwuC4RgiFMVlgbmUsTosLq1Hlp0le2eQMSFlqcnfC2gASOf/IxiL8GubfZqB6qb/Sxd7FUMloL4YEquHPG5s7usLcIfWSAocsHryTvM4Q7Z6fX5IfjY76AFObjO0VWopQbiZ0o0nF7BUZtgAZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfK41e8V7uqhR0/WdW0G8ldzINWGsajPbWDFdIpW4l8=;
 b=R4uaJx4pjPJtTKdQ9jYZAHkUsdmVOkX0a6vR9Y5hcjb0R5g+v8fwgNwQnaqgnlcYWUmVWuTdt8a+5RYUAF6jtbYo8PK9okZ8dMUsDVLy94DOOj9uIaA1D5BGHzaDMGYQpqtPD71UKxOL+CEfZyOlnJhmu7tMfFOh8XEYHOhOfmJhQ+RKEOTymxtEy7jY2XqU+qFjavMP2N/zDfjmN376sbBitbnM7vPft/y1q67PIsiepf+MpIRCXucXYHVUN3xFZXrSkZkL0W02tN1K66Z+odUykqMFcdv8wwzHzvcqxjoImXWUAgMrCBVwZBHv/7lDjtxRfxq7D9QjyR0x3+vmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfK41e8V7uqhR0/WdW0G8ldzINWGsajPbWDFdIpW4l8=;
 b=MkSoPaqA6l8cNaa7uaJSiPzMz5xj5cT+XiaiqGPU6i10W+J6VDVY+H7tPsk/9VyEo7gPamOEu1RspNIVx9jLIjV6oNJqdoQM5gBJxRG6Ab4HqN+cHrEQUXQytvmkyocV1G1D0/h3nBUDYr5STW3MXa7sTrL5OSgi1KzaI5ZLBrk=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 14:10:40 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:10:40 +0000
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] Request for Modification of test cases
Thread-Index: AdrPE+E5zP1T61RgRZ2SWJGBqXDPgQAQsVeAAKyqAiA=
Date: Tue, 9 Jul 2024 14:10:40 +0000
Message-ID: <IA1PR10MB7240E961E4C697B7379EB66E98DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <CAEemH2fLGJY6D+GAgmFcoCk5jSw7-K5VkoDb1CEqTbwqfKw+Wg@mail.gmail.com>
In-Reply-To: <CAEemH2fLGJY6D+GAgmFcoCk5jSw7-K5VkoDb1CEqTbwqfKw+Wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|SJ0PR10MB4494:EE_
x-ms-office365-filtering-correlation-id: c8a81609-e304-45f1-5f96-08dca020ea30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SWw3Wld4Tmp2dWdtR3l2YzRXVGhmTWFMenorZGNRNCtGUlBTdkVaWDAvanBn?=
 =?utf-8?B?YndFeE0vMnZpc1FzYjBMME5JdkxzbUJ3dWRhMHJIdE9DWGdIaHAwWi9rOUFU?=
 =?utf-8?B?Y1lxdnhCRmhQRkpja0pQbWNHcGRSRTZVbTY5V2pUczdpUlFQT1JudkxvQ095?=
 =?utf-8?B?eUh0bnF4bW5zNzRrK0lVZm9ETkpBbXZJL1k0WmRwWnZOL05EV0dxT25TMzZn?=
 =?utf-8?B?VW9ORC8rYW1VOWY2dzVac1ptZm1yRjF3UUd5RUpsU0s5SzJqYUlBTmp0QVpW?=
 =?utf-8?B?SkVUQUg2THBqZ05YOER6MVAwWlZsd2Z0SytSY2ZOSjJWSnNienhzR2oxekU3?=
 =?utf-8?B?U21OZE5Xd0xkcXhKNnZLbnI2ZWw4aVBWd1RVcEh0eDIzdEZGb1M2MmhGR2Rh?=
 =?utf-8?B?cHRVL054d0ZydTQ1bmZLNmtuam1Gbks2Ykhhc0I4b3JnUTRDTG90V292VkNj?=
 =?utf-8?B?QTY3dGNiRFhOMGwzeUd6QVNzNXZmTU01ZWhYK0RxS3JHOHlqYy91K2ZKYU94?=
 =?utf-8?B?M0F5Vk1zQU9MVnZqSDJranJwanR5ZU55eXJNQWdBUkVJOENjWGdDMWprMnIz?=
 =?utf-8?B?NVJDNzdkdjBmd1JxS2lUTG1vMDRuVGgrdEVaT1NmWVZjSE0veWxkTU1HSlJZ?=
 =?utf-8?B?Qnk2NnJheFhXYzdvL05pN0ZYMUlhV2I3UW5Eb1Juek1jMy9PYXRkaXBMbXdU?=
 =?utf-8?B?VGRNQ2JzL0xLb1hzZFdrOTUybUZUKzVxYVh1SFhzRW1Eamh0c20rN3Z3aTI5?=
 =?utf-8?B?SWNheDVidWtaMm1ZMGtJejBreHFLTnk2d01qdnFNWmtsR1BlaVQ2SlJXcGpp?=
 =?utf-8?B?Y0l0QWVYSHFNcXlyRVdtd0ZjY215dGd3ZU5ZSnFQUXhQOHAxWVV1Ujd3bG5F?=
 =?utf-8?B?TmdmTUNyOWtSV3VXd2ZxU3YwS01JYzdmakRLWkxjTmNkc3l5SWxlWmtrVFUv?=
 =?utf-8?B?WWIyTEFXMmVzaFBNd3FrSHU0ZTQ3UGZYLzQzeUpjQmdmMXp5NTVNTkNiUWQ1?=
 =?utf-8?B?WUQva0gwbkRsYjVKVFNwWlZYUGJ2Q0VDVHVFbXQzK1EzT2oxYXBVbnVhcC9H?=
 =?utf-8?B?Z29NdTAyd0tib1VPdWdGdW8vZkE0NHBNZmdFcWI0QU1ZR3BBRjdwRmgwd28v?=
 =?utf-8?B?ODhCYmp6eFZVSml4dzZzYWlEUlMvSU5zSFE0aWYvaTh0eEtEZXBZeTZPeDA1?=
 =?utf-8?B?QzllNkdMNkd1K2k2eVo3K25hRUxjK0ZhYi9JR2lOTE5QZDQyMGZUaThKYmRM?=
 =?utf-8?B?eXNJOGovejBRa3FTd0FJaStwZ1lzMTV2WnEzT2hqbG1oczhGNDJCTitWWmJI?=
 =?utf-8?B?ZE9PaTgyalVGVXcyT0tBcVMzMDJJOHVEMEU0NDBIN0FBZGpFNU95YW14cGZK?=
 =?utf-8?B?U0E4ZnVzYitJOUk2YnVJOGhzTm5rUVFOVXhsYWtVZFo5b24zYjdGQWNwakI1?=
 =?utf-8?B?ZXZlYSs5MHpjT1dEQVhtN29mK1dOY1pDaGFEczY3OHIyb1JTUXFHS3lSOWlC?=
 =?utf-8?B?eVdZNm1RTDlIRjgveFNOdEpmS1BmT0Y2d2FhT1MvaGhpTHhkNWU3V1JVd0Fw?=
 =?utf-8?B?bzFDK25oUzE4U3Ntai9RWXEySmZzaUdtY2U1STdSTWQ0Nmd2MGI2WUtnbGsz?=
 =?utf-8?B?Vy9KVHhETXowdlVjSkZGYzRDZHJWODQ5M3BpTjQrK0l4c0FSbEpLbTN2SXY1?=
 =?utf-8?B?VThpTTJPMHdtcVp2aElVdFdhdDdRQUlmTGk4RUJEbTh0eHIzL2dXN21YK2VZ?=
 =?utf-8?B?WHhsdm9xWnlCQkFYVkdFNy85c2JCcHRvUUpKS3VldGdzZjdHcjVjR0FKazNM?=
 =?utf-8?B?TmtqQWxBZGt4dTZ1cU5JU3NMZ09NRXRlNXVOMkFhZXk4MU1wN25iODhNY1Bj?=
 =?utf-8?B?L2ZKZlMwdURFdWpscURNQTR2K25SeFF2UjU1SWNTMXRiZWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7240.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDBUVVphVzJRQUNtRm03UWY4OUZwMHNpTUoxT3gwUGdaRXNHQ2xnSXluU1Rq?=
 =?utf-8?B?UG05dlMrTUNTMmk1aVdIWFF2a3F5WWUwWWJtejhNTXQ2d0R4Wnl0dWlNMERO?=
 =?utf-8?B?RVgySmdZcVdtTzllWUVBTndBa1NvR05GTy94cFVrR1FadGJNL3Q2eDhJZTNH?=
 =?utf-8?B?OG5OQjJnMm1vVVdGeU1QaW9TWnVLWG43RjV3eEJEajM0d29jejBRWS9FbEdn?=
 =?utf-8?B?ZjlESE9hQjFyWG0rME96ZDJ0L004STVjVllZNklHVE5HQXB5TFZNQUJJR0Jh?=
 =?utf-8?B?d1E5R0dVRTFkNytVU0l5dTgwOUoxU09YZEl6T21CdVhYUjExNE16ZURFQzUr?=
 =?utf-8?B?eHRuclY4cEtUT3BkMmd1Uk5YbnNWd29LLzFqRVM5L3Vicm1QNkF4R1BiRWFj?=
 =?utf-8?B?eUxJTklYYzlzelNxT1VkSVF1MGVOODVVbWd3Q2MrNVNEcWU3Sy9WZThOY0Q0?=
 =?utf-8?B?eUE2NmlsSEswUFVuUk1MZjBEUFBYT3hsSUg3T09HcFhjbjYwZmE5ZEZ3UFhS?=
 =?utf-8?B?dVNReWhUY09KbkU1eXYrc2R4Z0VhMW11aTNiRCtWR1JWazFNNDJwcHRyV2ZE?=
 =?utf-8?B?T2hFT0FqWnprcHo0VHIweWNyYjQrZnduM3gwNnI5ZWFjelU3Znc5M24xSXVD?=
 =?utf-8?B?Q2hUdVdVZXRWU0VDTnNoLytpa0hyUThFZDRtSGVTK0ZrOXlWSU9nWkVoOVgr?=
 =?utf-8?B?dmpQMlNnMXFKUFEvRU02T29SWkY4QUdyNGdOTGZEVGFTZHA4aXhFVVQzMG5i?=
 =?utf-8?B?ZzNmSXlnMkpVd1lFdG94TFk0b01zbXM0bHVZekdmYnVVZFZja0NlNXJ2VUtD?=
 =?utf-8?B?dnJIZHYrZk92NDk3QXRJRG5TR05INVFLYzQ0N3piS1hHK00yaStVRWpKQVIx?=
 =?utf-8?B?ZEg4dEpIWERLSHhFejcyUkpFMXJ0aVljZXN5dHlBOU1tTWNnTUFEd2xmT21r?=
 =?utf-8?B?YjBQTk5CMVhxaTA0dUQ3cHE0Q2UvV2Q1dXVEN2x4YnA0cnFHZEFXWXlpNmJ5?=
 =?utf-8?B?dWxKa2Z5MElhendWZXIxS2RJZnlVcUFNckYrTnN4YmFvd0JyYno1cEpxVGNI?=
 =?utf-8?B?UW9MMURnRGxFVVJ4SXo0bjVlZkFDUDhnZlV4UWhPZm1wRDZMZjNYd2VLK1da?=
 =?utf-8?B?RzV1djJoQkIzQ1Z1T0NwbFdTbitXb2dRV3dFUm5nWG8wQXQ5eXFsN3JSRXB5?=
 =?utf-8?B?OTcrUFIzdGMzK0t3V0V3eUNrenh2WWdwemU0TzkwajFFWHlFdTFHdnFXcFdC?=
 =?utf-8?B?bHRSOXo2S09WdHRUa3l3ZnozdmY0T1IwbDJWOTRXMlF6ZG41UWdxUDZxYThv?=
 =?utf-8?B?ZlVheXVxeVY5ZFBnVWpyQ25MVExwK0kwOTFNaHA1c0t6TkQxdktjK3ByS2Nr?=
 =?utf-8?B?WmlxZTZiK1F1MjM4NmNjU0JNWWVoQ3FRYU4xMW5PV0l3aXBWRXk1bGZYNVg3?=
 =?utf-8?B?Q0pZVWdZUzhOUzNUTGEzaGMvV1hJUEhhMFB5U2FWU3o2cHdXVFNraGw3U1lP?=
 =?utf-8?B?M29ReEtNS3JiaXZJbnpoNmwvMjdIbytaN2lONEFKS2psVlZXamNhRitsdzll?=
 =?utf-8?B?c1FYN1QvdnozVVliaytiUGx5VVFrZndNa3kxbUxOc2xnZThUVityV0R3YjlU?=
 =?utf-8?B?RXMzek1WeUpCMDAxRitCK3pkT1ppMGtZZ3o5THY1S2tZN28vWGdTQ2pwS09M?=
 =?utf-8?B?aE9GbUJYbmFqT3NCU1VvVTZuYU1QTnJhSFhEV0NFVVBGOE16c1M5N0JDaDFq?=
 =?utf-8?B?UmxGQWowK3JpZzdlOVYzOWJDZWovZVhXWkZDU3FyRkI0UmZkZkdubVhoV0Vx?=
 =?utf-8?B?aUszQXdGRmgvQXU3WjBBZDR5WGloSzJKRUV5Wlh0Sy85NExRMUxpVEhYKzdt?=
 =?utf-8?B?N3U2NGEwZnpUMHRXdFlsb3ltUzZCQ0tFRmcydjBnTm1jU0RiU2xUT3Y5N282?=
 =?utf-8?B?TVhab3pVUm80clZwdmJMaDZNcHdzNlJhSWJvenVZaytjYmRzVVJhdWdDSXh6?=
 =?utf-8?B?cTRlV0Vla0VTK0NIRnVTdnNBUGI2UVZuYlJOTHBXaDRoWCsvaXZYNGpNbUU5?=
 =?utf-8?B?eWtRMVVOUXBOWENJczZ3djhTYjhuSkpQM2N1bW91YXJ3QTdyOTIxZHJteXRs?=
 =?utf-8?Q?EXzW1DSLn6U3zDWutAyLBaF05?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B5YciLiiArYsePLk8feL7Qu7jeKV9qJgwpNuXVbUXAVfF2JicCOJ+NJ6U1ouJQfXjWtyidvMctxfdDxGLP6QxvnA867CWtdj44Cm/ieb4jm5/vOMpVNcHChTqnsk7m8ci7JJiRXkwZwobgqlEaJ7l1N37VV8U61JdSmC1xfsxA6BHBYJpdHE45KWJS5yUzPUyaEPMsUWbT0OcnKyigHL8BvgHgaA7AgYPmtLkgc02X5c5+2QX2yD0mRUtInDU9ctJr2D/kJUC3lfXWQ4c32vMuvmQ1rsee6SDrnDPjzMqKfEXPHqR/ceBmtI0QYHbx/27BC6fcS2lbocqpfLTgeajVktHWXngxfL5nH9UJGlEJO/fQFHvK6B7DndUK59/GeKSKscGrQCd3HvljVCwQ3gU3CE6KJbN3tKV9RmhlleR48js4xQdtYfde7MGyJ4Za5ZL+VqkXIE/yKmMqR5sWfTSGolwKRIPdvFCStDCsrjHKy28YM1SyCsQ+cLWxrOprALZQlWRJVxshO/bHVBCo/exnd2CBfUQZhBNdb5qTv+1ck9VQmm3fXFBRJk0yiHAAvzacOwSPkDUWxK2k1rpZSHmpa2pf76NJEBp+CeGPCLyA4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a81609-e304-45f1-5f96-08dca020ea30
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:10:40.7819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeskbK+tG96OpVAZDBQ0O5pD5mae9qKZOabeDdwRdB/KettD6JfztF7FDLpyJfajxkz0GHG42N0prasH/T/xGTT4f7xhepWAgpwtn088plk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090091
X-Proofpoint-ORIG-GUID: w4WpDIq5h6xZMQrrDGOpfBMIvMgMRXHs
X-Proofpoint-GUID: w4WpDIq5h6xZMQrrDGOpfBMIvMgMRXHs
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Request for Modification of test cases
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
From: Gulam Mohamed via ltp <ltp@lists.linux.it>
Reply-To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkgV2FuZywNCg0KRnJvbTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+DQpTZW50OiBT
YXR1cmRheSwgSnVseSA2LCAyMDI0IDk6MTMgQU0NClRvOiBHdWxhbSBNb2hhbWVkIDxndWxhbS5t
b2hhbWVkQG9yYWNsZS5jb20+DQpDYzogbHRwQGxpc3RzLmxpbnV4Lml0DQpTdWJqZWN0OiBSZTog
W0xUUF0gUmVxdWVzdCBmb3IgTW9kaWZpY2F0aW9uIG9mIHRlc3QgY2FzZXMNCg0KSGkgR3VsYW0s
DQoNCk9uIFNhdCwgSnVsIDYsIDIwMjQgYXQgMzo0OOKAr0FNIEd1bGFtIE1vaGFtZWQgdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0PG1haWx0bzpsdHBAbGlzdHMubGludXguaXQ+PiB3cm90ZToN
CkhpIFRlYW0sDQoNCiAgICBUaGlzIGlzIHJlZ2FyZGluZyB0aGUgY2hhbmdlIGluIGtlcm5lbCBi
ZWhhdmlvciBhYm91dCB0aGUgd2F5IHRoZSBsb29wIGRldmljZSBpcyBkZXRhY2hlZC4NCg0KICAg
ICAgICAgICAgICBDdXJyZW50IGJlaGF2aW9yDQogICAgICAgICAgICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQogICAgICAgICAgICAgIFdoZW4gdGhlIExPT1BfQ0xSX0ZEIGlvY3RsIGNvbW1h
bmQgaXMgc2VudCB0byBkZXRhY2ggdGhlIGxvb3AgZGV2aWNlLCB0aGUgZWFybGllciBiZWhhdmlv
ciB3YXMgdGhhdCB0aGUgbG9vcCAgICAgZGV2aWNlIHVzZWQgdG8gYmUgZGV0YWNoZWQgYXQgdGhh
dCBpbnN0YW5jZSBpdHNlbGYgaWYgdGhlcmUgd2FzIGEgc2luZ2xlIG9wZW5lciBvbmx5LiBJZg0K
ICAgICAgICAgICAgICAgdGhlcmUgd2VyZSBtdWx0aXBsZSBvcGVuZXJzIG9mIHRoZSBsb29wIGRl
dmljZSwgdGhlIGJlaGF2aW9yIHdhcyB0byBkZWZlciB0aGUgZGV0YWNoIG9wZXJhdGlvbiBhdCB0
aGUgbGFzdCBjbG9zZSBvZiB0aGUgZGV2aWNlLg0KDQogICAgICAgICAgICAgIE5ldyBiZWhhdmlv
cg0KICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0NCiAgICAgICAgICAgICAgQXMgcGVy
IHRoZSBuZXcgYmVoYXZpb3IsIGlycmVzcGVjdGl2ZSBvZiB3aGV0aGVyIHRoZXJlIGFyZSBhbnkg
b3BlbmVycyBvZiB0aGUgbG9vcCBkZXZpY2Ugb3Igbm90LCB0aGUgZGV0YWNoIG9wZXJhdGlvbiBp
cyBkZWZlcnJlZCB0byB0aGUgbGFzdCBjbG9zZSBvZiB0aGUgZGV2aWNlLiBUaGlzIHdhcyBkb25l
IHRvIGFkZHJlc3MgYW4gaXNzdWUsIGR1ZQ0KICAgICAgICAgICAgICB0byByYWNlIGNvZGl0aW9u
cywgcmVjZW50bHkgd2UgaGFkIGluIGtlcm5lbC4NCg0KICAgICAgICAgICAgICBXaXRoIHRoZSBu
ZXcga2VybmVsIGJlaGF2aW9yIGluIHBsYWNlLCBzb21lIG9mIHRoZSBMVFAgdGVzdCBjYXNlcyBp
biAidGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC8iIGFyZSBmYWlsaW5nIGFzIHRoZSBk
ZXZpY2UgaXMgY2xvc2VkIGF0IHRoZSBlbmQgb2YgdGhlIHRlc3QgYW5kIHRoZSB0ZXN0IGNhc2Vz
IGFyZSBleHBlY3RpbmcgZm9yIHRoZQ0KICAgICAgICAgICAgICAgcmVzdWx0cyB3aGljaCBjYW4g
b2NjdXIgYWZ0ZXIgdGhlIGRldmljZSBpcyBkZXRhY2hlZC4gU29tZSBvZiB0aGUgdGVzdCBjYXNl
cyB3aGljaCBhcmUgZmFpbGluZyBhcmU6DQoNCiAgICAgICAgICAgICAgMS4gaW9jdGwwNCwgaW9j
dGwwNSwgaW9jdGwwNiwgaW9jdGwwNywgaW9jdGwwOQ0KICAgICAgICAgICAgICAyLiBpb2N0bF9s
b29wMDEsIGlvY3RsX2xvb3AwMiwgaW9jdGxfbG9vcDAzLCBpb2N0bF9sb29wMDQsIGlvY3RsX2xv
b3AwNSwgaW9jdGxfbG9vcDA2LCBpb2N0bF9sb29wMDcNCg0KICAgICAgICAgICAgICBUaGUgbWFp
biByb290IGNhdXNlIG9mIHRoZSBtb3N0IG9mIHRoZSB0ZXN0IGZhaWx1cmVzLCBpcyB0aGUgZnVu
Y3Rpb24gInRzdF9kZXRhY2hfZGV2aWNlX2J5X2ZkKCkiIHdoZXJlIHRoZSBmdW5jdGlvbiBpcyBl
eHBlY3RpbmcgZXJyb3IgRU5YSU8gd2hpY2ggaXMgcmV0dXJuZWQgb25seSBhZnRlciB0aGUgZGV2
aWNlIGlzIGRldGFjaGVkLiBCdXQNCiAgICAgICAgICAgICAgZGV0YWNoLCBhcyBwZXIgbmV3IGJl
aGF2aW9yLCBoYXBwZW5zIG9ubHkgYWZ0ZXIgdGhlIGxhc3QgY2xvc2UgKGkuZSBhZnRlciB0aGlz
IGZ1bmN0aW9uIGlzIHJldHVybmVkKSwgdGhlIHRlc3Qgd2lsbCBmYWlsIHdpdGggZm9sbG93aW5n
IGVycm9yOg0KDQogICAgICAgICAgICAgICJpb2N0bCgvZGV2L2xvb3AwLCBMT09QX0NMUl9GRCwg
MCkgbm8gRU5YSU8gZm9yIHRvbyBsb25nIg0KDQogICAgICAgICAgICAgIFNpbWlsYXJseSwgc29t
ZSBvdGhlciB0ZXN0IGNhc2VzIGFyZSBleHBlY3RpbmcgcmVzdWx0cyB3aGljaCBhcmUgcmV0dXJu
ZWQgYWZ0ZXIgdGhlIGRldGFjaCBvcGVyYXRpb24sIGJ1dCBhcyB0aGUgZGV0YWNoIGRpZCBub3Qg
aGFwcGVuLCB1bmV4cGVjdGVkIHZhbHVlcyBhcmUgcmV0dXJuZWQgcmVzdWx0aW5nIGluIHRoZSB0
ZXN0IGZhaWx1cmUuDQoNCiAgICAgICAgICAgICAgU28sIGNhbiBMVFAgbWFpbnRhaW5lcnMgdGVh
bSBjaGFuZ2UgdGhlIGltcGFjdGVkIHRlc3QgY2FzZXMgdG8gYWNjb21tb2RhdGUgdGhlIG5ldyBi
ZWhhdmlvciBvZiBrZXJuZWwgZm9yIHRoZSBkZXRhY2ggb3BlcmF0aW9uIG9mIHRoZSBsb29wIGRl
dmljZT8NCg0KDQpUaGFua3MgZm9yIGhpZ2hsaWdodGluZyB0aGUgaXNzdWUsIGNhbiB5b3UgdGVs
bCB3aGljaCBrZXJuZWwgdmVyc2lvbiAoY29tbWl0ID8pDQppbnRyb2R1Y2VkIHRoYXQgY2hhbmdl
LCB0aGVuIHdlIGNvdWxkIGFkanVzdCB0aGUgdGVzdCBhZ2FpbnN0IHRoZSBkaWZmZXJlbnQga2Vy
bmVscy4NCg0KVGhhbmtzIGZvciB0aGUgaGVscC4gVGhlIHBhdGNoIGlzIGFscmVhZHkgaW4gcXVl
dWUgYnkgdGhlIGJsb2NrIG1haW50YWluZXJzIGZvciA2LjExLiBTZWVtcyBsaWtlIGl0IHdpbGwg
YmUgbWVyZ2VkIHNvb24uDQoNClJlZ2FyZHMsDQpHdWxhbSBNb2hhbWVkLg0KDQotLQ0KUmVnYXJk
cywNCkxpIFdhbmcNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
