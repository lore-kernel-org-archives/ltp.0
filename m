Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573D8C3ABDD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747763888; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=AwNCz+K2/guZtYLf2j/AB/B776qLGldBEjzdSELhHMw=;
 b=CUI10vdJfsEyVlGq9WpzPX7Kr2CyFxiRy873Eg7InV/5X2MVJHRUiJS8q7NT1Er4ch6My
 eXWt1lAHvLMn+RXQBr+4KkH/A+SLF4dbjvyQBKCgPm1TBez0T/243iPOVy9s5YimofGTAoq
 CiwItd/SQ+bwEsK0BNjW/AIf7BmW99U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59F953CC792
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 19:58:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21EAB3C9AEC
 for <ltp@lists.linux.it>; Tue, 20 May 2025 19:57:46 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E49F4200A00
 for <ltp@lists.linux.it>; Tue, 20 May 2025 19:57:43 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KHu20n007190;
 Tue, 20 May 2025 17:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=22+xKUccXsLzjvtNo65Z97pacYRswqi665Mbbw6/FrU=; b=
 k0gFunAuAXuA3O0T7+lSE9spaRVcCskPV25pBRNCyhNO5Wotb5PoV+toeAstjyXh
 IGFL9zx3W/F7TZL0mXQNzDXm+AGijwAyAqd2TPG627UUjNTya8OYgWq8dG5p6ZaP
 OpvnUzBJZRw4yfKvY2/XAaHbFShWTdApZzo0nJTC4ITDSr2BbQQqZrCTYVbpboCW
 SK6J4rvHyPIyP1mx6LJtl8JPdV6SFyaeI146ZFZUmAHv7UThLzj5J1/os69AwDoJ
 HQYtTmOf6RXvuboMfyJvmZmxaArNdZuRha3lEHjljpLaQEw7K5KA86nP/3pW5uVx
 uer5qu6yzqd+s47pysNLYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rwg588je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 17:57:40 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KGdRuK016418; Tue, 20 May 2025 17:57:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwenug3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 17:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJxVSJFbJx++2eKONhLXwOdXxmMUrc1bQCC54yZA9ou45AOuEswvWW3hBbj3Y2c1J3WEQYhj897pgmRPrQ3E7dkwnp8V3iRI5cvAOB+UV3N2FD3fXOrg+oiSqs8YH1lolp5HSN3dtbT7XrOd6N2E3CR5Veho0QVRT+YMtJH3fh6k7Mqz7HBFs1clv7u22IXyBluJOtoRGxS5Wfgmhqi5BJ2ABnNTDJvNe4lakiriKLcyWEY+aTnakC3v6jKBsdNmK/dY8GfXsmGgBIvIWhIu4IRcMiRtxSh1bnSR+qojhvRwJnN3cKeRe5zn0Q5mEHgZVghuiXyC1w3xday7sXsH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22+xKUccXsLzjvtNo65Z97pacYRswqi665Mbbw6/FrU=;
 b=ytlhmS5bkhX2U6HYAx3xmm5XB2hzDN2KkCN7wVFx/tvscOt2Hi5/OfXvGPD8kfi/6MS4qnc1QVPBkp3FA/I9OzmlYfRpzDgBUQtV04VroWdKT4D3SbTLOQEnrhHT4xh5cNJjm/KXQ1hHhxQCVeAh4Vskx3tofyJCaZSUG/ZjTKNVvAOvY4hXr+gPCADWb7LxsyvhkK3ZoY89aQCEbQXpUAvlFflnSdsyE7ubgD6mooCBGcJP0rJiGn/5IahOLSd+xzqtLWeJtwbjSXb3Q1mls8oD7umo3COBaje0Qgqeo4KsV+raV14MUe0k8Ot4+Bzb0TeBn26NgjfsK2yzKE2oQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22+xKUccXsLzjvtNo65Z97pacYRswqi665Mbbw6/FrU=;
 b=jcPKiRAMLLvbf4WfoyJHWIHGC2GJtFLcgsbn2vAACRTkmT+SGrfVdhoL47E+Mt5PvnqVew5Y9JUQwp92pFKHKbrmV6/19MajNGHyRlsz01ozI7VUUUYBm3+YMWLziGzBMUs0IvhexDFpgjakPRMv5XVJ8+z069iYZBe9cAL4aG0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PPFAFF9EAD68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 17:57:37 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Tue, 20 May 2025
 17:57:37 +0000
Message-ID: <f55ab599-dc34-4981-8859-95e76d13db80@oracle.com>
Date: Tue, 20 May 2025 23:27:31 +0530
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Cyril Hrubis <chrubis@suse.cz>
References: <20250505105310.15072-1-mdoucha@suse.cz>
 <aBts4kDaqLKLJUuw@yuki.lan> <3ff8ee4c-881a-435d-a416-8bd32c35a17e@suse.cz>
 <aB3JFz8PK2okhULz@yuki.lan> <f3cbed38-82b1-45e3-b037-a943f9956ae8@suse.cz>
 <aB3Si02rxzhhZYFv@yuki.lan>
 <qbca5sxzfw53o6nku5ulu2dl2xygxqghgsuerjjjfoea62bacs@a5qm6cl7hhnu>
 <144b6bac-edba-470a-bf87-abf492d85ef5@suse.cz>
Content-Language: en-US
In-Reply-To: <144b6bac-edba-470a-bf87-abf492d85ef5@suse.cz>
X-ClientProxiedBy: TYAPR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:404:15::35) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PPFAFF9EAD68:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ce9c73-284d-41a6-8365-08dd97c7ce3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnpBM1dnRzFxT004UTgzeFpuaHZ5Y09FOHplc3RFS3VLOEdSMzBCVTA2WVNX?=
 =?utf-8?B?TEJvMHZFRnI5cUkzVDd3V3E3d3ROR1hLT21yNEJkWnh1Rkd2R1ZPL0lKdkRO?=
 =?utf-8?B?QWVSekxQVFRta0EwWnNIeW0xM2I5SU1sUVY5aVRXTlB1cGRGVUVBKy80aC9F?=
 =?utf-8?B?NUFGWTRJOWhWVWp1QVdRdDdTQUdGK2xEc3lmVjJCWk14NDlqanRxd01pVWZl?=
 =?utf-8?B?WlJPQ3NWRGR3eEl3cm9xTU01Z1daMTRvS1krbFBQZ0RaTWFXNFNyT1BOZ2RR?=
 =?utf-8?B?UzFFeVBCYUJ4RmtBbnVhK1ROZVZobVYwcDdBUlJoaU1Nd1c4UkVlajZKU25K?=
 =?utf-8?B?ZGNtR25PYVljL3B5R2FOSFVFbGRmZTFvRmZEaEczNkhRZDVyeElaNGpUSXor?=
 =?utf-8?B?dER2NlBncG5ieWQrQzdkRW9ZUzhVUk1yTmRnMmFDYktIYUoyRjZ0eE5XWW9R?=
 =?utf-8?B?WW55ZUJTY3grMlpLVlZXcmx3WDA3TEtrbm9ad0JMdVpMZmNJazlTMTBWc2Z6?=
 =?utf-8?B?cDVMckpiNjZBMEZLTTNYOE9FS1h4ZXIzeG9HRGUza1B4YU1Hdk5VcDZTZ1N1?=
 =?utf-8?B?U0N2amt2WVlkT3IyMS8xNXdPZnIyU016UGMwLzBXdzQxeXdUYTU4bDliK3VD?=
 =?utf-8?B?YkkrYS9lZTk1SVZEUnpaRW5FNWpoQ2FYTVg1cFJFY1owQWRUcEVSc0VQTjBK?=
 =?utf-8?B?dTZwUkhIQXJPWkJTcUhRL3Vqa2NUWXdCQnZCNlBPUFV0Q21lQ2RGUGRLU0pD?=
 =?utf-8?B?NWJPempzOTdCZDQ3TmVuQ1ROOHFkTnlxVHBnN1FNbTJpSGkwRDNoak8yci95?=
 =?utf-8?B?ZHBWMEhNdGV1NTFybjVuTEEzOUc3MUx0bkF6V2VPTjFWNXRtNFVZZWY2Ni9a?=
 =?utf-8?B?RXFWR3l6N04zQjZEaUtRMUJKbjE0QnRBT2dTak4wRXIyN1E0Nzlvd1pLekNw?=
 =?utf-8?B?eS9HeHpVRkVKckk0c0o3VXdZUVlROW5TVXdNbm5OY01sY1ZObkZDSW93Um0y?=
 =?utf-8?B?NWg5dzZIaDFpWXdyREp2TmJyQXE1Z3V2cEVIZ0RZNnJSTGF0MFRadXlXa05l?=
 =?utf-8?B?U1QzR0pJU3h6Nks4VHY3aGxOMElvZW5pOUc0SisydjRvdWVFdU5tMHcvdGw2?=
 =?utf-8?B?Tjg0UkR4UUxZYS9BeWN0NTE2QS9EQzNlQUlCeHBjSU5LWmpaaHA1QzNzOTdW?=
 =?utf-8?B?amVqMFVCZ1FRdmtWOU9oTFl6US9rbkk0RWN0QW5mQTFYamVWc0tGN0ZKRWtJ?=
 =?utf-8?B?S2phWGVaLytkS1NNd1Vkc3p0TTFtVVVPRW94QkZHb0gvbHplVnBzekxsb1Nk?=
 =?utf-8?B?ZS9ZMXM4SHZXMW0reStlaWJwcXh2RGREdzZwa2hPS0ZvelNsUjRtWU5ZdGNv?=
 =?utf-8?B?cjMrSHV2RTc4bmVzc2lQTklzam0xeS9UUHVhamFMY0dDMG15Y1NORmpodCtY?=
 =?utf-8?B?UUQ5MmJOMlpqcndzcGtJZTR2RzhkRmVLcnRTL0VpdUdWUXVLOUdjcHA4YjdD?=
 =?utf-8?B?d3NBQkc0dldiVGdNNFhGUGhiS281OXpZWDlMK2o5TjBkK2VBdStEQm43c2Fk?=
 =?utf-8?B?VHFNVkFtakN5S3RUK3ZXZzk1azFwTndYYzJMOXc5bW9QbndRdVlYL0x4QmNj?=
 =?utf-8?B?T3NlZzA0TVJ6b3RIQVFvQUlreGNSZXJVMmpVbnpjUlhISDVtamNzU0RtZ2V2?=
 =?utf-8?B?ZWpXRTVhenZIMnBEOVVUTnRqVWE2cG9GN3g3dkpTaEVQdk5CUkJmZmp0V3JQ?=
 =?utf-8?B?UVpEOW1KVEZvNnA4b09XQ2hBUXB6eFhydHBTaGhlRjdPS2VyV2pVQW5qVDU4?=
 =?utf-8?B?RUxOc0JKL28zWlY3KytDdWl2TmtYZjZ2amMwYU13dzJUU1ArdjZKWkZvRU9C?=
 =?utf-8?B?QUxTWEc0UkRaNktyaGM0N3oway9OMXJkd1ZIQ0FjcHQ5aEg5MzlybW9NSnlW?=
 =?utf-8?Q?0K6Zdqj9KVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5328.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpKdmhEdENOMm1tVStTOHRudzQyYVhjYVlHSjZiNjlwVHNNclo0NTdKZDVW?=
 =?utf-8?B?bnIzaHhKeUt2LzZMQXVoTll6emFMVVdiSHlIK2l3UVlVN3lmOFJrZ3FxSlpq?=
 =?utf-8?B?Y1VSNmRFVUEvcUM4cnJ0UnFWY3FOVmoyTXRYR2gxWlYzbko3dGRML3FuT3lS?=
 =?utf-8?B?LzVGSU9SRTdjTDJPUy9lVWFtd25uOHdXUmNSNS9KWEsyVEowdFdlcU1DNGRt?=
 =?utf-8?B?QnBXMXFXZ2YyM1FZOHNTT1dCeEk1WVVaM1BOcjZjRnJCQnhURDhXaG1qb2dw?=
 =?utf-8?B?eGRKVjF2UzBtUGIzZHJIS1MxZGVoVHdkeURHQlF3cE9CSWtzQ1NwdS8wNjBm?=
 =?utf-8?B?L29paXhLN3pyc3BmS21zSURnWUJBSEF1LzlqbDkzazkxN2VFU0tpc1VkejNl?=
 =?utf-8?B?MVNDNjFyZzhhUzFTM1Z6bUt2MHU5dkdEQldZUzVBY1A5QUV2TW1WOFoyNVZ2?=
 =?utf-8?B?WHJHZktHVytheHYyNFVqbjhna1RKY1RSblNFYVBXdC83RmhNalJDWkFRckV4?=
 =?utf-8?B?VkhWUDFLclRibmNTWTVYaStPNDh4Y3ljZTJmOVArVE5vamhwNk9Dc0JMNktZ?=
 =?utf-8?B?MjZuTU0wbkl5d05selplbEovWkpXQU5tVDBuaDlLSjJpOGp2ZXFhYS8zSmpC?=
 =?utf-8?B?R2VZV0RkNlBHRE5IQnpKUzVxRWdXcDcvREUyWlIyd3BKZUpBV2dqY3hxTGRD?=
 =?utf-8?B?azlENDFyL2ovK29BLy9YYzZXa1BZZVpNTllwRkZHSjJmcVUzY2VxZGpGQzZT?=
 =?utf-8?B?T0NRYVlUeThXbWhxN2NWVGlrbUFBcVJrZStHL3pqUG9WenBJd1JveFNYUWZS?=
 =?utf-8?B?L1ZqN0JLUGZ5RmpQaU1HVzd4OCtnblpoM1BaOS9QeGhOYkl4NEN4UTEwa1dl?=
 =?utf-8?B?anFvS1BjbWxrdk51SjJkMXdrU2l0eGVaSDhzMURwVmduSFBodTdIMDdqOHJh?=
 =?utf-8?B?L2d3WkY1Mytmbm85RnNPeGtsV2JqTjlRanVtdHBCcGRxYjFSeXpXREV5K2Vw?=
 =?utf-8?B?dEMzcXZZYnpKcVJSTUhTbzJRbkF0ai9CRUJxWUR4VnhaRnZqa3YvS2JpNGpX?=
 =?utf-8?B?TWlHUnZscWE0N0k5T1hrTHRWbjkyVEpRRWxMSExkRXIvbHFvaEQwbzc5Yno5?=
 =?utf-8?B?d2kzaDRjTXlXZndoemhERWxJMi84cTdHZTBrMjJPNE1ucE42K2pKNFZGSjFq?=
 =?utf-8?B?djJTOTBhaFBKL1oydTd2dXRSVDVYV1Vtem5rV2xFVG9kUU5QNmRiTDR1anlZ?=
 =?utf-8?B?aTZqcHhiQXVvRWVmeTBvT2drcHdCNVNQNldXWk0rSkpSWUpFeEw4RmFEWU9i?=
 =?utf-8?B?d2JaOWFJd0p1dm1LUDZyd1NYRUtHaHhwc2grNE8yMm9INXYrTGFPK2RjVUNN?=
 =?utf-8?B?dnBjc0dSa3lwOU1oY01mMGhwb0RqUjkzRk1nVWQ2bVVMbk4yY3N3ZTY1YTJw?=
 =?utf-8?B?b2J2N0FTb0t4aXJxMjNCUFBhU2xnZU8ra0IxakEvMmxlUGFCck5iT3V4Zkt2?=
 =?utf-8?B?Uk5tQytsd1Y4a0w1Y2xqMC9WK28weThoMFlJRnlQSTF5RW02YWNxL3E2Vzdr?=
 =?utf-8?B?aEsrVXBNT2M3bHlHWXVONDBSdHFXcTJlSDdyYjdlaVhuUjc5QURWbjFJU3ll?=
 =?utf-8?B?Zk9WYm8wSVB0elYrUXRXdm1xdjBmY2x0NVNHUERDbkdCaVdmTkw2ZjN2YzM5?=
 =?utf-8?B?NGJTbVFjbmNUVHBTL0NaeTJJcW9FODV2ZWxvY0FPRzdYRmFYMi9KRFFsVzVL?=
 =?utf-8?B?OEJDN3d1UmpwbFMrL0hIbTJWOFVKN1drTEdYUllXdU8vQkR6ekdNbEhaY085?=
 =?utf-8?B?RzVlZCtxZjlWUkZoWmYveGY1WXlENS9zMUVzRXloalQxazVPWWpxUDVWK2hH?=
 =?utf-8?B?WWgzOWkwM0dKdUdBejkvNmNCY3J0ZlAvT3o1WE93ZnNvdER6K2VXZEtNYTVl?=
 =?utf-8?B?bklIVlF0Uk03RTYwbzVlRzkzTnRiZW50WVRHTytuWldxWjFRU1NuUG1ZZzNV?=
 =?utf-8?B?OGN4cVhmNys0NVVnR0Qwb2Z3NWR5bG5DellrVUJ4UVphNDY5Uzh6QU9QQWZ1?=
 =?utf-8?B?all1YkgvNXFGd3BlMEhmM1ZKZVB5WkNVWTZIelZZUXV5VUF0aUJ1UVdmQVhK?=
 =?utf-8?B?MlAweWpEQ3RZemtvb0hSdStGMlQ1ZzV6MjVmcGhPKy9HdzBWVitPeitubGty?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wMaiFY4h8Ysp6+KMk0Mj8HaK8w/J26PSOeSMv1qTQdiSRbnap1vkXGz3o3qwD2QYn3gryQws7iaRgqWztwGS2KtbnjB854uAcKBy+M+pOcaScT+0UlvB89kQZLklGe7IWCfhnFzkVNh/kEoEV0VWbUc0Gl6wVCYHFr56cHt133fTdWXNccRMDB7Hn5p7/F1PAijKkBEsOFjiGPIcbib84Yob7S7SyPR/bt2HBBJcn18VV8eMvX5GvxA9565+TUME0JuiKCE/cNNfI+cR5VSDaLalVjCxQCC3z1FYvKJnlqo+NuMQOqjLlL1t0dwWj/zOtoan20es6nSod1sq+7eEYKy+oChbv2jVGU7LX6VC6g1oQ7Te/3inBeGIkhpUcK+Iv2Awuf7aAsssAaiTG2uNftwlr+RlKhyQIACjh7fB9LBeBpHwU4FiN2bXxIsbb9NJuvQl9K6JxqRtp6yJlcbYxYlPkYo9cOVqQ1FQUF7x5yqjPch2rl/zr953yfQgwgMNyGsc5a0OpILAZHirX3lGgt30cBbrE2xV9jP/iRnXh6k3KXSpxy9ZoVmJBacSBNxqpSL1osPJsDxzYiVYxGeYAC0NWdJn9l4gf+EAeAHwCDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ce9c73-284d-41a6-8365-08dd97c7ce3a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 17:57:37.3331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXMrW9OJBwab5Yq/gEJmEaQpoKWzV3CIq4kr5vAX8uJMUJPKNN1q6ER50lvasrVUjRcWqZ+6OVzVMAtLeTG2DwUUDq9RK+pB8Hb3b0WlaSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAFF9EAD68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_08,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505200149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE1MCBTYWx0ZWRfX5+PoyxbCHjTA
 OStN2qtW2GUhm40UiTJWp2sVPNTfot39E0zDTLJ/e5YjqjBYFOImVhhgKWvC4k5x0k620RVKXB/
 W7lEp/t7ivjmYYnxge/QQ8xJazmPO7lspRWbre35mgVYPRm4ZMmmyQssZ8GwNCYaIIuDqRN50q4
 dNdbE0pEQMm+BqrtzVxfm4DW/nBE9c493wW+/Vg0D0Y8uv3kwNOsIS/KjUSqGgfNPZV0gpFd4Vy
 1C7ku01NEcCceMclnMjaI9NSPVVlxLOrpI1avDyIP08Bf41RmiaVzkWM+94aSbnRIvli6lAYg/J
 Q9o/PU5vtwjtroZ4M6zxXSkfGJ8cpz7jDnt6MzvK0wOp7s/h84me68hnAv9u0jVYmOTny19LO/J
 oDwprrBs5WPzepPo+PIMQWlKBD19rYaJpxT3Qj8LQMZBYPs/rxlzSjzHQQS4IDcDyD4HDT1l
X-Proofpoint-ORIG-GUID: xzkudwDcI_CrFjoJReJ73C7de5gOxvCZ
X-Proofpoint-GUID: xzkudwDcI_CrFjoJReJ73C7de5gOxvCZ
X-Authority-Analysis: v=2.4 cv=Wd4Ma1hX c=1 sm=1 tr=0 ts=682cc295 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=V5LgJR4jVdZOZlNqst4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13188
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcontrol03: Account for process size in cgroup
 allocation
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAwOS0wNS0yMDI1IDIwOjExLCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+IE9uIDA5LiAwNS4g
MjUgMTY6MTEsIE1pY2hhbCBLb3V0bsO9IHdyb3RlOgo+PiBPbiBGcmksIE1heSAwOSwgMjAyNSBh
dCAxMjowMTo0N1BNICswMjAwLCBDeXJpbCBIcnViaXMgCj4+IDxjaHJ1YmlzQHN1c2UuY3o+IHdy
b3RlOgo+Pj4+IFVuZm9ydHVuYXRlbHksIHdlIGNhbid0LiBJJ3ZlIHRlc3RlZCB0aGlzIGFuZCBt
ZW1vcnkuY3VycmVudCBjYW4gY2hhbmdlCj4+Pj4gYSBsb3QgZHVyaW5nIHRoZSBmaXJzdCBwcm9j
ZXNzIG1pZ3JhdGlvbi4KPj4+Cj4+PiBUaGF0IGRvZXMgc291bmQgc3RyYW5nZS4gQE1pY2hhbCBh
bnkgaWRlYSB3aGF0IGhhcHBlbnMgaGVyZT8KPj4KPj4gW1Byb2Nlc3MgbWlncmF0ZXMgaXRzZWxm
IChlY2hvIDAgPiR0YXJnZXRfY2cvY2dyb3VwLnByb2NzKSBvcl0gaXQncwo+PiBvdGhlcndpc2Ug
YWN0aXZlIGR1cmluZyB0aGUgbWlncmF0aW9uPwo+Pgo+PiAoQWxzbywgdGhlIGFwcGFyZW50IGlu
Y3JlYXNlIG9mIG1lbW9yeS5jdXJyZW50IG1heSBiZSBhbXBsaWZpZWQgYmVjYXVzZQo+PiBvZiBN
RU1DR19DSEFSR0VfQkFUQ0ggZXZlbiB3aXRoIGluaXRpYWxseSBzbWFsbCBhbGxvY2F0aW9uLikK
PiAKPiBUaGUgcHJvY2VzcyBtaWdyYXRlcyBpdHNlbGY6Cj4gU0FGRV9DR19QUklOVEYoY2csICJj
Z3JvdXAucHJvY3MiLCAiJWQiLCBnZXRwaWQoKSk7Cj4gCj4gV2UncmUgZGVhbGluZyB3aXRoIGFu
IGlzc3VlIHdoZXJlIHRoZSB0ZXN0IGhhcyAyTUIgc2FmZXR5IG1hcmdpbiBmcm9tIAo+IHRyaWdn
ZXJpbmcgT09NIGJ1dCBpbW1lZGlhdGVseSBhZnRlciB0aGUgcHJvY2VzcyBtaWdyYXRlcyBpdHNl
bGYgaW50byAKPiB0aGUgY2dyb3VwIG9uIFBQQzY0TEUsIG1lbW9yeS5jdXJyZW50IHdpbGwgYmUg
fjRNQiBhbmQgdGhlIHByb2Nlc3Mgd2lsbCAKPiByYW5kb21seSB0cmlnZ2VyIE9PTSBhbnl3YXku
IFNvIHdlJ3JlIGluY3JlYXNpbmcgdGhlIHNhZmV0eSBtYXJnaW4gYnkgCj4gd2hhdGV2ZXIgbWVt
b3J5LmN1cnJlbnQgc2F5cyBpbW1lZGlhdGVseSBhZnRlciB0aGUgbWlncmF0aW9uLgo+IAoKCkVy
cm9yIGxvZyB3aXRob3V0IHRoaXMgY29tbWl0Ogo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KSSB3YXMgc2VlaW5nIGVycm9yIG9u
IDY0SyBpbWFnZSBhYXJjaDY0IChmYWlsdXJlIGNhbiBvY2N1ciByYW5kb21seSk6CnRzdF90ZXN0
LmM6MTg3NTogVElORk86ID09PSBUZXN0aW5nIG9uIGV4dDQgPT09CnRzdF90ZXN0LmM6MTIwOTog
VElORk86IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRoIGV4dDQgb3B0cz0nJyBleHRyYSAKb3B0
cz0nJwpta2UyZnMgMS40Ny4xICgyMC1NYXktMjAyNCkKdHN0X3Rlc3QuYzoxMjIxOiBUSU5GTzog
TW91bnRpbmcgL2Rldi9sb29wMCB0byAKL3RtcGRpci9sdHAtQ3c1a2dqVXA1di9MVFBfbWVtVzly
ejczL21udGRpciBmc3R5cD1leHQ0IGZsYWdzPTAKbWVtY29udHJvbDAzLmM6MTQyOiBUSU5GTzog
Q2hpbGQgMjgxOTIgaW4gbGVhZl9DOiBBbGxvY2F0aW5nIHBhZ2VjYWNoZTogCjUyNDI4ODAwCm1l
bWNvbnRyb2wwMy5jOjE0MjogVElORk86IENoaWxkIDI4MTkzIGluIGxlYWZfRDogQWxsb2NhdGlu
ZyBwYWdlY2FjaGU6IAo1MjQyODgwMAptZW1jb250cm9sMDMuYzoxNDI6IFRJTkZPOiBDaGlsZCAy
ODE5NCBpbiBsZWFmX0Y6IEFsbG9jYXRpbmcgcGFnZWNhY2hlOiAKNTI0Mjg4MDAKbWVtY29udHJv
bDAzLmM6MTA1OiBUSU5GTzogQ2hpbGQgMjgxOTUgaW4gdHJ1bmtfRzogQWxsb2NhdGluZyBhbm9u
OiAKMTU1MTg5MjQ4Cm1lbWNvbnRyb2wwMy5jOjExOTogVFBBU1M6IENoaWxkIDI4MTk1IGV4aXRl
ZAptZW1jb250cm9sMDMuYzoyMDY6IFRQQVNTOiBFeHBlY3Q6IChBL0IgbWVtb3J5LmN1cnJlbnQ9
NDkyMTc1MzYpIH49IDUyNDI4ODAwCm1lbWNvbnRyb2wwMy5jOjIxMjogVEZBSUw6IEV4cGVjdDog
KEEvQi9DIG1lbW9yeS5jdXJyZW50PTIxMTY4MTI4KSB+PSAKMzQ2MDMwMDgKbWVtY29udHJvbDAz
LmM6MjE0OiBUUEFTUzogRXhwZWN0OiAoQS9CL0QgbWVtb3J5LmN1cnJlbnQ9MjU2MjQ1NzYpIH49
IAoxNzgyNTc5MgptZW1jb250cm9sMDMuYzoyMTY6IFRQQVNTOiBFeHBlY3Q6IChBL0IvRSBtZW1v
cnkuY3VycmVudD0wKSB+PSAwCm1lbWNvbnRyb2wwMy5jOjEwNTogVElORk86IENoaWxkIDI4MTk2
IGluIHRydW5rX0c6IEFsbG9jYXRpbmcgYW5vbjogCjE3ODI1NzkyMAptZW1jb250cm9sMDMuYzox
MTQ6IFRQQVNTOiBDaGlsZCAyODE5NiBraWxsZWQgYnkgT09NCm1lbWNvbnRyb2wwMy5jOjIyMjog
VFBBU1M6IEV4cGVjdDogKEEvQiBtZW1vcnkuY3VycmVudD00OTIxNzUzNikgfj0gNTI0Mjg4MDAK
ClN1bW1hcnk6CnBhc3NlZCAgIDM0CmZhaWxlZCAgIDEKYnJva2VuICAgMApza2lwcGVkICAwCndh
cm5pbmdzIDAKPDw8ZXhlY3V0aW9uX3N0YXR1cz4+PgoKTFRQIHRlc3QgUEFTU0VEIHdpdGggY29t
bWl0Ogo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KaGVyZSBteSBvYnNlcnZhdGlvbiBmb3IgYXJyY2g2NCA2NEsgcGFnZSBJbWFn
ZSB3aXRoIHRoaXMgY29tbWl0OgoKdHN0X3Rlc3QuYzoxODc1OiBUSU5GTzogPT09IFRlc3Rpbmcg
b24gZXh0NCA9PT0KdHN0X3Rlc3QuYzoxMjA5OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3Aw
IHdpdGggZXh0NCBvcHRzPScnIGV4dHJhIApvcHRzPScnCm1rZTJmcyAxLjQ3LjEgKDIwLU1heS0y
MDI0KQp0c3RfdGVzdC5jOjEyMjE6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAv
TFRQX21lbTVRbXRnYy9tbnRkaXIgCmZzdHlwPWV4dDQgZmxhZ3M9MAptZW1jb250cm9sMDMuYzox
NTE6IFRJTkZPOiBDaGlsZCAyODM2NyBpbiBsZWFmX0M6IEFsbG9jYXRpbmcgcGFnZWNhY2hlOiAK
NDgyMzQ0OTYKbWVtY29udHJvbDAzLmM6MTUxOiBUSU5GTzogQ2hpbGQgMjgzNjggaW4gbGVhZl9E
OiBBbGxvY2F0aW5nIHBhZ2VjYWNoZTogCjQ4MjM0NDk2Cm1lbWNvbnRyb2wwMy5jOjE1MTogVElO
Rk86IENoaWxkIDI4MzY5IGluIGxlYWZfRjogQWxsb2NhdGluZyBwYWdlY2FjaGU6IAo0ODIzNDQ5
NgptZW1jb250cm9sMDMuYzoxMDg6IFRJTkZPOiBDaGlsZCAyODM3MCBpbiB0cnVua19HOiBBbGxv
Y2F0aW5nIGFub246IAoxNTA5OTQ5NDQKbWVtY29udHJvbDAzLmM6MTI1OiBUUEFTUzogQ2hpbGQg
MjgzNzAgZXhpdGVkCm1lbWNvbnRyb2wwMy5jOjIxODogVFBBU1M6IEV4cGVjdDogKEEvQiBtZW1v
cnkuY3VycmVudD01NDEzMjczNikgfj0gNTI0Mjg4MDAKbWVtY29udHJvbDAzLmM6MjI0OiBUUEFT
UzogRXhwZWN0OiAoQS9CL0MgbWVtb3J5LmN1cnJlbnQ9MjEyOTkyMDApIH49IAozNDYwMzAwOApt
ZW1jb250cm9sMDMuYzoyMjY6IFRQQVNTOiBFeHBlY3Q6IChBL0IvRCBtZW1vcnkuY3VycmVudD0y
NTY5MDExMikgfj0gCjE3ODI1NzkyCm1lbWNvbnRyb2wwMy5jOjIyODogVFBBU1M6IEV4cGVjdDog
KEEvQi9FIG1lbW9yeS5jdXJyZW50PTApIH49IDAKbWVtY29udHJvbDAzLmM6MTA4OiBUSU5GTzog
Q2hpbGQgMjgzNzEgaW4gdHJ1bmtfRzogQWxsb2NhdGluZyBhbm9uOiAKMTczOTk4MDgwCm1lbWNv
bnRyb2wwMy5jOjEyMDogVFBBU1M6IENoaWxkIDI4MzcxIGtpbGxlZCBieSBPT00KbWVtY29udHJv
bDAzLmM6MjM0OiBUUEFTUzogRXhwZWN0OiAoQS9CIG1lbW9yeS5jdXJyZW50PTQ5NDc5NjgwKSB+
PSA1MjQyODgwMAoKU3VtbWFyeToKcGFzc2VkICAgMzUKZmFpbGVkICAgMApicm9rZW4gICAwCnNr
aXBwZWQgIDAKd2FybmluZ3MgMAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKSXMg
dGhlcmUgYW55IGNhc2Ugd2hlcmUgdGhpcyBMVFAgdGVzdCBkZXBlbmRzIG9uIHRoZSB1cHN0cmVh
bSBjb21taXQgCjFiYzU0MmM2YTBkICgnbW0vdm1zY2FuOiB3YWtlIHVwIGZsdXNoZXJzIGNvbmRp
dGlvbmFsbHkgdG8gYXZvaWQgY2dyb3VwIApPT00nKT8KCgpUaGFua3MsCkFsb2sKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
