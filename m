Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADB4C5AD49
	for <ltp@archiver.kernel.org>; Sun,  8 Jun 2025 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749399717; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=HIvvqezOH4UXsKEj3g4t6xHuNpmjNJCtXEt1vrBjF8w=;
 b=eseHsUGUja3iF3ENGZ3QFzPMfvjKQceTYgJJXnpCaGnLcptqRQfJ/TM1ZE0ZuoOA+xCX+
 DdgRNsCIgHLO+Grx6x9hVsJFVxSs5vM69HPM3KiO7LP4i8fOcj7HK55h1kqmki5/kjlNJB7
 QARKLHCPkAH4agzMMptHrzxCUmRXW7c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85FF13CABAB
	for <ltp@archiver.kernel.org>; Sun,  8 Jun 2025 18:21:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4F93C02B9
 for <ltp@lists.linux.it>; Sun,  8 Jun 2025 18:21:36 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B3361A000B3
 for <ltp@lists.linux.it>; Sun,  8 Jun 2025 18:21:34 +0200 (CEST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558CcMk0027864;
 Sun, 8 Jun 2025 16:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=kpjwJD9JXLjc7+2NomGAfBh3bg3RSCUbdMukvCP0xGs=; b=
 X5axHO9mQbB4YDvtF8r2bBXm4D1CZ2Q44xSXlH2tA7VMVLOsqv9eLaA3QdJzq6Ow
 tuIlyRFqndFWdrt/pySderYkEQOk+ARMy/QrzMe2zsxaOc7esVzZrheD1AR9ZTDZ
 wNR3sWbo/Gpry7HShHzHV/qPc9sLt6Ko21CVWQboJCHgUE+NssaAa5VbXpx9soTs
 VrktKdvYBwRheBgFmRBz0cguAnzFujYxqsZLFjboXhl5qAHxwTdzdL0nHiG3JJN3
 nP+7heu5sG3LiT6g/7rH+8g9vOjZ9IbNCvwgzBQMoIBLhDDRooAcL9zU/fJ8nQYO
 lsg3ubjmnhKq0yxttnhO0w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf13sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 08 Jun 2025 16:21:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 558B4ngr007524; Sun, 8 Jun 2025 16:21:31 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv6f5y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 08 Jun 2025 16:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP1O1P4uuWjS6nzW7XaxrjSseX7OGGVZHz4T/AL59v+XOUL7KQwr5Hujp6494ffuTltTX0BMgXEv/BkeJOHX19aVpQQfY58DpmfsThAhIW5LyJz2Wcig7+KkkvzsN+/Die8SUInWgSH9Zh5dzCTu3J1DlXUxxKielP99VoGRC4mA281B0ZFWtSdiCIGCY5IBIqpfpuIM2VVJs4UDom8bpkWTBn1AuGHmcW8LpRRqaDPU5I8s+LsPPGVrnSCg6fE+UsUH74nuDQF63idljKALvw+8C14Fj/NimNnCthAEg53myj9fwIphEfylwKtxkULXB8T2QEZ8C+8uFHf7VUe7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpjwJD9JXLjc7+2NomGAfBh3bg3RSCUbdMukvCP0xGs=;
 b=yN8GntdJtdvk4UPWmhO7DrdWVNOGFQ4gMlDoHZXniLA8nI36JVxOd93CQN6gLrNn6D7YeHcqSLeBZrI4AMZ7UfJbRUxP14Y0jGOVPxD8IN5ee3rkdjJIKUbKriDQ7HvIzsY9LwFRJ1kWayiEUt6S7cAKH0UUqM+Lpq2/Xn1J4RmIrJ3F75dgqs9g6zndncUPs1xn5+HnYToYzE9WscW9xXHtsGwX1bfg6c1Vx7u/bxd1gaivJcmjAbZYDZoBC2efaPCxs2Y9LUHrQlGXv1e5+SaOfsA6+Ixljv/rQdSe46liadAOdXsnoQp15ajlBLMBXMgSJxNeBJS9wWBSDk4qpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpjwJD9JXLjc7+2NomGAfBh3bg3RSCUbdMukvCP0xGs=;
 b=VBuCSq7t5SzkmBT6JIY4lW0Wydj05BuLhkTEHo3f6oHqo2EvF0QPPpGajxSY25F4TAYjYAcJVDLDTlze39OgPB+ENb5oFF41Y1Vtc9Mtg6M/+aW8GH5fY/avoYVfrmT/sjrWqoNBvVNaMpToLkAEwyLnuRoMzdyNmDBRa2fq+7Q=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Sun, 8 Jun
 2025 16:21:28 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 16:21:28 +0000
Message-ID: <575cef1b-58ff-4f40-b68f-66c41fb7b1ac@oracle.com>
Date: Sun, 8 Jun 2025 21:51:24 +0530
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250606132100.20145-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250606132100.20145-1-chrubis@suse.cz>
X-ClientProxiedBy: MA0PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f9f682-a617-463b-57e5-08dda6a8859e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXYzbGJUem1ERGdLNCtoSGNkUEMvcXNoRFZMRTd5SThWMFZIQ3FKSGxMcFFB?=
 =?utf-8?B?bldUeWlIMTlwY3hGNk1EOGlQUkFsUi9DUEd3N2Qvc1R0MytYMERKaGk3NlI1?=
 =?utf-8?B?WmZ1bUZQWlFXYUFHd1BrNTFHRVI0bXVEcStycFllL09NbGUwT21ib1N6Rm1Q?=
 =?utf-8?B?MUxKUy9SRE1FRGROWjl6a3IzYU4vT2sxR21XbC80Q3QyWEsyUWZ5UzhpTTAy?=
 =?utf-8?B?UEJ4elRuLzA4NlNVQzdIdWZHeU9kcVFrRkFnNGlOZzVBR1lRSmdDQkZlTVZw?=
 =?utf-8?B?eWZNUThSRXV2REI2NitSeVRhVm1Fb3F0dzN0QVlvc3RVWE1hQUdYSnpWWkh6?=
 =?utf-8?B?clZIMmFTODFjTElKTWZ4UHN2VnluNHl4ZW1JN3V3WlZITkRWbUNpNEh5SUFk?=
 =?utf-8?B?ajdWRW9sbXBseUd6cFBuT1ZkTjViSERWL0djZlN6M1FmazFNK1RZdDVuY2ZJ?=
 =?utf-8?B?dENTcHdFcHM2d1RubEIrak1TODVCemRPQnhFc1BUVEJQYTZJbEQxZXZHOUcx?=
 =?utf-8?B?QlNYWWNIMXhtVEtPKy9WdnpwZ0ZrcnJVbHFSOWw0QU1wUjBLUUNSaEhoUVZt?=
 =?utf-8?B?aFI2S3VMcUFhMzhDVTEvQVpmbzVNVXJDWmpXVkprUDJwVlVER0pVWmNHQ3Q3?=
 =?utf-8?B?WTFjSlJKR0JNc2dkbFc2Y0t3RU84dzZ2RFRyNW9XSVd3elJuWDZUNmEySlEr?=
 =?utf-8?B?cEN2R1VEMkN1YjI1WDQ5cDZISVd6Tkhsc1pmZFcvUU8rUXJnYTdjdUNzdDl3?=
 =?utf-8?B?aGcyMWFrc0RFcXIycHdzbHltTHhBZWpDbmEyZ2R4MythSDc0cmNyZ2RQdm9y?=
 =?utf-8?B?WkZRaExia3BBUGRSSkVnUEthS3U3ZGlUS3gzREVFYTdnems5U3hxODFpT0NK?=
 =?utf-8?B?QnNxTDRzSDJHbHRrUExQSHdXcm9IaHhIYTFBL0FnaXlPbitVdWcreWJHR3Y5?=
 =?utf-8?B?Um1INFBFazJ6dU84VEJNQmlnbDU3WXRSVlh5VWhoTVNDTndyUU1IYU1oNnhv?=
 =?utf-8?B?WENwdmRLTTZFb2hHcXV6NmlrL2Vhd0N6Q0VRdjR2ZW9TM0kzYlVhRkhLQVlR?=
 =?utf-8?B?SGlaMnNBWTFjK2VLaXFkdGluSXlQdkpsU2dSbitsOW1FNUFId2tVZzBnc0xN?=
 =?utf-8?B?VG9CYy82VEk2RWJVU1VyN2IwdHdTQ0lCNEcyVG00d3FaNDYwbEgweHVvRVVW?=
 =?utf-8?B?WW9rcmZ2MGYwbWJ2NHUrNFlhQkIzWi9aUWk3YnNCSXNLL2NDWkl6YlZNSWhT?=
 =?utf-8?B?L3owVXg3T2w4QmtQMFRZaFF0aURoZ3dna2tkK05vSTRKckJ1cC9aaUg4Yjdw?=
 =?utf-8?B?TEhoa3lBbVdoYUxKbjBFUnlvS1VZa0Z5bjUvQVA4bkNHSWpDT2tJZHplQWpC?=
 =?utf-8?B?aGJ3TzNMTFVyQ1FoRVc1SlBJZ0NoUmh6STNGVndNaTBiZldDUmFkaDJjS1Zm?=
 =?utf-8?B?a0d0SnZlQ3phdGwwYXBnRU80L1g0SFBqdldCdTlUOENpcXBYY3JIeUpRYnVl?=
 =?utf-8?B?VzZMZVROanF0VXpra1lpQWZpVG9oeVlnQ1IwZUZ3L1ZSUFpib1MvRldrU21M?=
 =?utf-8?B?Nk52bkRGL2lUdWxRYkpNMWFJUTlzb2oyTytnLzh2WmovZGhxZ0pMOFl5MVRr?=
 =?utf-8?B?VWlieWhtNjBwMTR2TGlDR0dVMmlsYVV2Z2dxRnlRNmE3SjV4MitvaGl0RW5S?=
 =?utf-8?B?cGhLVGhMbUNyYnduSUIybFVVZHJSYW84M1FRWTJQcmVXSnVtS3FsRjRVT2Vr?=
 =?utf-8?B?Z2ZPemZNL3hENmMxeTdWUml5ZHdzdHhWaVhnOGFrL0xXQ1VFNFVQV3JUbDJi?=
 =?utf-8?B?M1I0SGF1eGlJNjVmeWtkUlVTYkJVM2JDS0xtRWRaYWcwZUZ5VzU2T0V1TCtl?=
 =?utf-8?B?VWdOQVlFemk0ZEcrdFV3Mkc1aUgyM1AyRXVwSGxnaFJuWVpZaUtIeGVOb0Ez?=
 =?utf-8?Q?HKdpY5BWSQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5328.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlRqR21yT1JIRGxQVGdDSmtEODh5NndZbnZVWFNqc1g5K2pXbGhPUGdMTy81?=
 =?utf-8?B?Nm00cFJQV1o0WkVSL1RqRTBTblpZLzRvU01BeWFCRVZSanNJdFRuaXoyS283?=
 =?utf-8?B?UXk5TWJ3Q0pSUU1wRTAxR3Z1N3Y4a0c1U05ob1E3NEs2clNGYkkxeVNyczNH?=
 =?utf-8?B?bHJmcklDS0lxdSsvTm12YkxheHJVajlYTXh5V3JSaDM2dURtak5zeUs1NlJs?=
 =?utf-8?B?ZjdwdGUyZXVqRVpwbEtZSHVjSXVMK0Z5eEpFZm82MjQwOWhiMytYNzlDTENG?=
 =?utf-8?B?dkZaV1haemZiWlkrd3o3eDV4U3JOSk5RY2JzTHpxWWtGdXcxYmVNcXZIaERY?=
 =?utf-8?B?Vy9hTTBVUEp3OVB5TXRQSEVFa2tYRTBXZ3NTUHF6WjlNTzlkS1V0R1JKL2lQ?=
 =?utf-8?B?T2YzTFd2cnJreVNyWWtxdHZ0QTlxYTVmTVBlY0d2OERzVFRYQXZ2M0QwcmZv?=
 =?utf-8?B?bncxRjdoVlBtL0o3U2lhL0tTTGMyMWFFeExmQk00MzR0cmR1bGk1THJ1c1hS?=
 =?utf-8?B?OFU2T3lBZ2ZhZlFyNzFkQmJYNElvZWtrVDZQdUJoN3VpTHZLVmxLTHMrZmJJ?=
 =?utf-8?B?bnNTb3NZV2lGYVV0MzBsVDNKSjRqb2g1MHpsU1ZaNkJOMEVOZVVnTkErV05W?=
 =?utf-8?B?eHppYnNaSmMzY0duT2g5U0tKUnhFTmtYb2tNVlpSRXh6Z3dwV0JpcjBWWkFD?=
 =?utf-8?B?Z3VQV245cEl3NU04THY3S1pDUGdyZU8vQ1hSQmYvd0NISU5ER0d6ei9HdnpO?=
 =?utf-8?B?eEdzdkxFYzRGWHRJcCtGNTFkem5JZEVUeWtRZVl3dkZIdHNiMm1pNjVxZ0Y0?=
 =?utf-8?B?ZDlZNkh4ODBoM0dzQzlZcWVhbEQ0TmFqRUFWaW5iU2xiTE9aVUVWNzh3cmxY?=
 =?utf-8?B?Q0R2SnVhdmQ2WDhjdTlsQXBRV01MYmpVYnRpUVVVblNiUFQrd20zUG9ocnZO?=
 =?utf-8?B?a28yU3Z2NzljYmhJWnlVMk43OEk5QkxLVDArNENhV3c0MGwyY1pkNWRhWTFX?=
 =?utf-8?B?RXFVN0N3NjN4bHVDemJ1Sm5pbjl0c3ExOEdvNGpkY2Q3VkpIVXJ1SWp1aGo5?=
 =?utf-8?B?RVQySEN3OEJYUDkxb0ZBdkd1eThSYTNxS2hiZlVFV0l5M1F2TGgrV2JmOXNr?=
 =?utf-8?B?VUtoYlFxcTc3Tmd6UHM4N2xWUEdjdWVsYVlubmpXZHFZbmVKc0JFVEo1dEJw?=
 =?utf-8?B?TW1NN0w0bW1zQ0tJR1RLTHF2dHVXTTVQZi9MVDBNeTZIUEs5L2MyalBKRUg3?=
 =?utf-8?B?TldGNXJQSWR1MW9MNlBYVDk2aXB2TEd6elhDQkVZWHhKd2N4R2JuUmVpWEdT?=
 =?utf-8?B?dzdndWhEYnZILy9FaGdBVG9GUGdYRzJQUDRxTno3eVZTcmF0TmZUNzZiU0Mz?=
 =?utf-8?B?blBNcmJNTFNOMjhjTysvWmhGQS9pdEVOTmUvZTZJUGQxVGdIMG5NemJ3Um1s?=
 =?utf-8?B?Q2ZoaG9uYVZQU2s2RW55a3JNTXlpeG9BZWorSHYxWkZ2NXk3aXJxdDNvME5p?=
 =?utf-8?B?ZW1RZExvT2VwTlJUQ0ZWdU9RdUVHNzZwK0Naa083d0lEVmd6c2lzZjJ6Qlk0?=
 =?utf-8?B?aUtCZkR0Ty9jWG5mZG9HUTlhUmVWMEZLb1hjT2JqQUNaZXNiKys0SVBPV0hU?=
 =?utf-8?B?akoxRmFjczUwdlJ5VVNBNWxKU09TUDUycHIzbThuVzRxeW4yNUNDQnV5bVRj?=
 =?utf-8?B?Y2tvakh1WjVtMC9uaU43TGtDZ0cxV09tOGIzczEwSnRxaXRUSlNjaTMyYXps?=
 =?utf-8?B?UEVuNE1FMnhGOVp3dFZaamhmQXdPWWU0TTVNc0hDOFdpb0VSemNVdTF6eXNl?=
 =?utf-8?B?QlI1TmdmdURXQldrMWVMMTBCOXVrbnRZZkxtbWg2bE93K2lwN0F6YnBrRm1q?=
 =?utf-8?B?czZaZytQVTNKaEtiSXk3WEtNMEFhSEdrK2U5YURRU1BOTUtTZkRsRjZuSnZ4?=
 =?utf-8?B?a2laUEhKNGdzUW4vY3R0eEJCYngydkdsaHBtRlhoR28yaHhaVGJkQVl3OTYv?=
 =?utf-8?B?M0YyVmRVWW9rN1ZQWllHNlFGU3dkNVR2U09vY1JOR2ZENzhWWGFLZFY1SkxJ?=
 =?utf-8?B?S3VHRmJBSTNQVUljSW9jODc5a2FhdVRja2pBbWpadWtOaWdFQzRqZzI2QjYv?=
 =?utf-8?B?dlo5YjdCZWt5NVFpWnNQWkJuUWJXZkR0TDNMU0xNNmlrcG02NEJxbW8vcVZ2?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KeWuiaH+ajiACGfjM26CqoiGCHBGW8kHohChEzbm+j3SJxUYqmH5zj4hQtR7VpCP3ZIeJCrrd2JF44iPJoe1JhR5vrYwypLK9s4Cr8o5KdiPC54kB1RU+0xjH9TCJqxj5130QcT16Cn9hVG7fbwTVSBfj2Zk9geeUcCroBYs5C+ciiAm+NiXwTan7tlzSm3Et48rOZfthAfARgyrqLEfT0db0sx+QCrTTVMbK6ZEvsc5+JLAQHgbuDlCl4XUyNERFdT/dLoTdTXZVCcTQfZEFvJhnwh6XEHMmDWm1Q9/tYpaLjUetBQGCVMsW5NhHPxOYrwWsRllWeo+KzsPyTMvi6ilc394w8hjUQcnqs20lHttTPwUlIbcFgUGIZBDzwtBb5mVBjFx2EHSnKGl0e84kuZPrVVLyYukH+gX8NDCujRRLkUrH+SiBA1hYJjF44YOXlP6lNxphjZbyiF2CLC5jLyJepw+6Wyf0ahtej8j13iJuTg1F/FCdbyB3g5zbr2h1x7YZJZcXGo/XDWJum2wXu1rcypGq1CeKZlArsj0dopWmHfvtzFBacy1fTMmQ8xH0683XBX2ypNPzn8dxFfGuDrEM56UdCbvpXTzE45KMTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f9f682-a617-463b-57e5-08dda6a8859e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 16:21:28.4163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjNfvqH7IXSUgtSN3cnEj/il6MXL+LYuazJ/q6d4mQFR3kXh5J9g59Y5D4Rxvk0a6DN77M9IHSf1GuhZr/0Nx3VHnbBNihc4m9TesVdJcLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506080131
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6845b88c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=SHTeH4YrTVbUdf5edggA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mgCnOQl9mxL6HCtUsg0q9jDlfmxXe13k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDEzMSBTYWx0ZWRfXwM48QjHv7sL+
 e7oq4ymwi+1/dqOBrZlBMnqkzMTLWAhCVMkxm3QVnYTevq4lhl0dUK3xFU87YSvuuqTXMEqIO05
 l3F/hTFe1FdWm+7+9TLg+JFKbw7OcGa1s8+b1whlvFXk5XIkwJvnxRlP4cjdfB97Nbzaviu3m+8
 lxii0w3jFeowu/4J3VyGJs4kLv+grzZ5RnrxLAQA9K/qWD8meAWHlR+uuNrSjXMhL2xcEEn0C4f
 NB8BQHjKOIY3rdY1dWsMj7TOHzmxKIcxRAMZ9QS2GeljjcuU/r/X+1+1Q/I1O6qJzZEEL8pocM+
 KR604G6K0o5/3ED0IttJ0/nZOgxBMEk5nWSAGGWn7RhMNcRtAND3EPRQDJFhi7S3wpYONNp2Ugo
 g+rRsZ9A4ufTF+cJR/EUdCP4uSvjx/E9r33B6di75PW6i774xzKux7M4Hi7+ZGbwHdQ+qFPz
X-Proofpoint-ORIG-GUID: mgCnOQl9mxL6HCtUsg0q9jDlfmxXe13k
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [External] :  [PATCH] [RFC] doc: Add testers guide
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
From: ALOK TIWARI via ltp <ltp@lists.linux.it>
Reply-To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



There are some minor typos in addition to Ricardo's comments.

On 06-06-2025 18:51, Cyril Hrubis wrote:
> While we have added a documentation on supported kernels, compilers, how
> to compile and run LTP etc. Some kind of a comprehensive guide for
> people new to LTP and kernel testing was missing. This patch adds a
> short guide that tries to explain some of the pitfalls of kernel
> testing. Feel free to point out what is missing and suggest additional
> chapters.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   doc/index.rst               |   1 +
>   doc/users/testers_guide.rst | 129 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+)
>   create mode 100644 doc/users/testers_guide.rst
[snip]
> +
> +Multi dimensionality
> +--------------------
> +
> +First of all kernel testing is a multi dimensional problem, just compiling and
> +running LTP will give you some coverage but very likely not enough. There are
> +several big gaps that may be easily missed.
> +
> +For example 64bit Linux kernel provides compatibility layer for 32bit
> +applications which code quality is usually a bit worse than the 64bit ABI.
> +Hence recompiling LTP with -m32 in compiler flags and runnig both 64bit and

typo runnig -> running

> +32bit test binaries is a good start. If you try to make an argument that your
> +application does not need 32bit support it's better to disable the compat layer
> +completely since it's possible source of security bugs.
> +
> +Another dimension is the number of architectures you need to test, for a
> +general distribution testing you may end up with a couple of them. Different
> +architectures have different platform code as well as differencies in memory

differencies -> differences

> +orderings, etc. that all means that running tests on one architecture out of
> +several will give you incomplete coverage.
> +
> +You also have to decide if you are going to run tests in virtual machine e.g.
> +qemu-kvm, on bare metal or both. Testing in virtual machine will give you about
> +90% of the coverage for bare metal and vice versa.
> +
> +There are other options worth of consideration too, Linux kernel has many
> +debugging options that are usually disabled on runtime since they incur
> +singificant performance penalty. Having a few more LTP testruns with different
> +debug options enabled e.g. KASAN may help catch bugs before they materialize in
> +production.
> +
> +In practice your test matrix may easily explode and you may end up with dozens
> +of differently configured testruns based on different considerations. The hard
> +taks at hand is not to have too many since computing power is not an infinite
> +resource and does not scale that easily. If you managed to read up to this
> +point "Don't Panic" things are almost never as bad as they may seem at first
> +glance.
> +
> +It's a good idea to start small with an evironment that models your production.
> +Once that works well you can try different configurations. Select a few
> +interesting ones and run them for some time in order to get an idea of their
> +usefulness. If you are feeling adventurous you may try to measure and compare
> +actual test coverage with one of the tools such as lcov. If you do so do not
> +fall into a trap of attempting to have 100% line coverage. Having 100% of lines
> +executed during the test does not mean that your test coverage is 100%. Good
> +tests validate much more than just how much code from the tested binary was
> +executed.
> +
> +You may need to sacrifice some coverage in order to match the tests runtime to
> +the available computing power. When doing so Pareto principle is your friend.
> +
> +
> +Test scope
> +----------
> +
> +So far we were talking about a code coverage from a point of maximizing test
> +coverage while keeping our test matrix as small as poissible. While that is a
> +noble goal it's not the universal holy grail of testing. Different use cases
> +have different considerations and scope. For a testing before the final release

testing before a final release

> +such testing is very desirable, however for a continuous integration or smoke
> +testing the main requirement is that feedback loops are as short as possible.
> +
> +When a developer changes the kernel and submits the changes to be merged it's
> +desirable to run some tests. Again the hard question is which tests. If we run
> +all possible tests in all possible combinations it may take a day or two and
> +the developer will move to a diffrent tasks before the tests have a chance to

typo diffrent -> different

> +finish. If you multiply that by a number of developers in the team you may end
> +up in a situation where a developer will retire before tests for his patch may
> +have chance to finish.

have had a chance to finish

> +
> +In this case careful selection of tests is even more important. Having less is
> +more in this context. One of the first ideas for CI is to skip tests that run
> +for more than a second or so, happily this can be easily done with kirk. In the
> +future we may want to explore some heuristics that would map the code changes
> +in kernel into a subset of tests, which would allow for a very quick feedback.
> +
> +
> +Debugging test failures
> +-----------------------
> +
> +You may think that you will enjoy some rest once you have your test matrix
> +ready and your tests are running. Unfortunatelly that's where the actual work
> +starts. Debugging test failures is probably the hardest part of the testing
> +process. In some cases failures are easily reproducible and it's not that hard
> +to locate the bug, either in the test or in the kernel itself. There are
> +however, quite common, cases where the test failure reproduces only in 10% or
> +even 1% of the test runs. That does not mean that there is no bug, that usually
> +means that the bug depends on more prerequisities that have to manifest at the

prerequisities -> prerequisites

> +right time in order to trigger the failure. Sadly for modern systems that are
> +asynchronous in nature such bugs are more and more common.
> +
> +The debugging process itself is not complicated at its nature. You have to

not complicated at its nature -> not complicated by nature

> +attempt to undestand the failure by checking the logs, reading the source code,

typo undestand -> understand

> +debugging with strace, gdb, etc. Then form a hypotesis and either prove or

hypotesis -> hypothesis

> +disprove it. Rinse and repeat until you end up with a clear description of what
> +went wrong. Hopefully you will manage to find the root cause but you should not
> +be discouraged if you do not. Debugging kernel bugs takes a lot of experience
> +and skill one cay say as much as is needed write the kernel code.
> +
> +
> +Happy testing!


Thanks,
Alok


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
