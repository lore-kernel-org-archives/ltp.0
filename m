Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98935D690ED
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1732787412; h=message-id :
 date : to : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=I8w6Wm46/tyfP2/mUSMVVkzb5jGQ3V1ktryuIBUtawI=;
 b=gk5si5A/rY7AYTj6o+9EGKJHJCawWCsWksf/xpCTO9Y9vlzyDZ4cmmUvlhySxuZwbpeg4
 4r4MwvCy9nE/kXealt/s0nThWPGOJX9I2sJC36ryTOJtJRlA1lL5KvS4MR8HaxFEqv0dObd
 xl2JuR987M+baNMz331QT2IyUILrRzw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E42B23DBB68
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:50:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2033A3D86D8
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 09:25:43 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=harshvardhan.j.jha@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AAE752082A6
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 09:25:40 +0100 (CET)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7fwa1021360
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 08:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=Wu9h1SKVobiDZP4n
 xr9rO4eVbpiWqC/O6BBsuTo7UzQ=; b=Xz6NoV3KUc8lkpvdEcd6LMzx82hj7cEe
 trqu8Ijt2H1FdYA912smdmJhFZGj6qYnxz8tg/kUlP68mf2/8k4/+vJjA5K7FkcT
 qRsLKxlhJWhM4WVsLaettNNhISz5QH16t6zxNSlplnuvH4fV+upndtsEa3ty/WUZ
 NVB5lc3Z3W+gRwy/3qc+Mm3CzPb+QYrV0u4rBWvKxa2FX8KTRn7ZIDTK7nZwQ//e
 jTVllQ2QtIBe+/uOPr1iCGuaEspqZ/+yjH00YXAHlqcG8yPmbU3+lFcq76DrPwUb
 x+JNspNENtCQlzanyW3/mzMBS2R6SjrJHvhj/xjDNVDEgYFAJXGzCg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebveay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 08:25:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AJ7iwrd023230
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 08:25:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42xhu8kvny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 08:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/JwaT4+GRSd0cCHXbL9cLmVfY6EByDoygGFsXduK9csJQ9hSpY3Ux9WyW5SHcl5bzBsPPe1QZLYbS2zb9UlulkLnQeyUGSO7bsafRFmVfkZ8O2ndyC4Nz548DoitM3vrl79y0HjpNJd2ySfpKL08NlGBYgD+ivi1iIBeCbo+upxPzxiROyjGTN1aHZbfaVde8tU+asSI/zvoWW4cKzGn/PkJRCzI32cMQxaBfPEe6jpiik237ShnG7x82QQRcXiS2nFtmNaMis1gyouJJfSjABd4kYSyQP518GrS/N3ulCOAWG8DLdV27am8HdSG3lrY7eIAKl/XezoNHE39ycZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu9h1SKVobiDZP4nxr9rO4eVbpiWqC/O6BBsuTo7UzQ=;
 b=BOvhl0H01SsjNqDRzxdqZ6qjS/w7PlCT52csT5qYvNNfzhdev/VsspKqqeWZAY4NMiTo1KRjFgWaFk9K35lg2Z6CumC1IFUuxqWVAnGsRGJ1X9BeLAv8DkzxFSaB2TAp3930i/IrncGt7nmAO3lDiu2AsZGuWHlptx6BeTUVSLcZ3/nz4LG8Gn2Wb2fMbr+R0WDF9mNkuhC8ahMEnAfZXFqVFDLL9rITcfgLz3RtRif5G11G7uN/zQs4YIFi4URQJYGSl153rFEDKYexri0dAhPTpJuVqUotNTLQyhmcgaITyxb5fJDEquDeNvQ7FYRSzzGrBCsa8Wu23ftPhTMlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu9h1SKVobiDZP4nxr9rO4eVbpiWqC/O6BBsuTo7UzQ=;
 b=VXVWjU8lb/0629EIRqsGNpRtPfWFlkN/SUcpLRo59nN5+c4kOxxl5c8C41wvNg1GVvFnqa73cgqgb93JRfvDeammD+ce5nz4FDSU9INkDo8NPsMV5zlFPM7TuvCMGlgWmB1QpnxzWV+GgY6KpeLFFmdkbMevhPwi8ToopY0e+so=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by MW4PR10MB6322.namprd10.prod.outlook.com (2603:10b6:303:1e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 08:25:35 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8158.017; Tue, 19 Nov 2024
 08:25:35 +0000
Message-ID: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
Date: Tue, 19 Nov 2024 13:55:30 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|MW4PR10MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddc5deb-ca0f-422f-e3aa-08dd0873bdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDduNkV0eUxnV3ViMUZYb25aQnZhWXdYNXBNMlVRbjE1YjEyZDlJWlczZEtS?=
 =?utf-8?B?TGEzYzhMdWVTeThvcXh5VTdFcnd0Q01Kc0dVa3oxcC9kODRqd25YVDB5bDhW?=
 =?utf-8?B?Q3BsREgzTWRnZEJyWEo5NmxxWjBPTjd6eUg0UkxiQkJWa21qV0FGRTRjaHdU?=
 =?utf-8?B?elY3eENQZzhaV3lwYVIyVFVmSVlOa2VkM0tKVWdWZkxnMnB3bXp0SUs5WG9y?=
 =?utf-8?B?T3BJRzd5UlNCOFVhVWNFVjQ0c0M4a2ZUL0xQRU91RndtUDNCV29uLzg2NXBk?=
 =?utf-8?B?NVZGRGE5ejVwcVZ4SDZ1cis1djhDVmlCckMrL0haYno2QXUwNWd5ckRCOHFm?=
 =?utf-8?B?V3FNa3NhbDZaOVpjcDk0UXBSRVRmbEwrTzY0T3N3SnZRQ0d4SGtXRFI4RUdl?=
 =?utf-8?B?UldnNXBvc2dwYlYwR29nVlVNVjVqL25TYkNCWjFkNjlEanBHMUoybUFFTS9q?=
 =?utf-8?B?bEsrNW1RYVFzQ2NDa2orZnZTWkQ2R2Vkenk3SmhoSGI4dXUrYmpiTGRiWFk5?=
 =?utf-8?B?VFhVVEZUdFJpaU8rR0JoWnlxazZhZ0RMbEtKVlNPR1c1VlN6RThwQyt5SHlu?=
 =?utf-8?B?WFNxVTNEUERpZ0ExNUlVRUxSb0hOOUFvSzYvNmNRaWYwZUxYQTA0RXNmbEVB?=
 =?utf-8?B?VzNCemJOUmh5ZEZJUkxsZEJwcGt0Qk5hWXdGUG94NE5uZjBVQ215WmtKQllQ?=
 =?utf-8?B?UzNQY1ZIZDJQay9wTzJVQm9LVWdja2ZuQ3piU1prR29ES2Ywc2pCUWJjdkFx?=
 =?utf-8?B?SlJPTlg2b2xwRjFPNXphZjRJTXhCbzhxZU9Mc0p3U1VUeHFucmtDL1ZYT2Y0?=
 =?utf-8?B?aUNQQ3Fpd0EvR1RJeG92ZG5yZldseGl4TnRoK05zYXRQUUs4dSt4eHhJbEQv?=
 =?utf-8?B?RFp1MDF6Rm5aQS9uZVlSZHRjOW9zYlpnUWlodUxRTzFwaWpEK0JUSk1VTWQw?=
 =?utf-8?B?aVVVN1ZaTkExSGZ2Lzh4WnBMT1FGVTQ5M0JXaVViRHFmTWw3NXVXK1MyTEx4?=
 =?utf-8?B?VWE0TEZrVmZzekdkUWd1TkQrczNYRG0wM0xoZkZ0WUlBWlAzK1YvRmZzTGdC?=
 =?utf-8?B?VU04ZnRQWXRJMEJrR3FwZUZpMjI5ZURmbk1PVXJYaDE2TW8xMyt3K2FiS3NB?=
 =?utf-8?B?Q1hNMko2VXRDazJGMkpnNEQweEdJUUc2Q2tjVnhYc1RSbHBqODhodUYvcXZz?=
 =?utf-8?B?bUdiczk1R3pxaW91a0VVOWMyaDdISnBOeU1DdXBOSkJkOURPVjFKdTdsVUl5?=
 =?utf-8?B?MjlCWGRERXQ0YldSVXZjdTIyT0RIa1dmcUpGKzNxWHVhYS9ITWwxSVBZRHZO?=
 =?utf-8?B?RWhzQ3g0eGI5SEU3NE5OY0pTR2JFUTVFc0tJLzFFZkJIRzk4RGRQSnFTS2NQ?=
 =?utf-8?B?RjkwR1RGZU4xRlVJNGV5VllwQU8yOXd2RXF0WitqRG9Pa3NYUy9nZXhZTHMw?=
 =?utf-8?B?TDZ0SzlrMDNrRXdhWWU1cGVGeXFMTm9jOGpGdjZOOWpObERVYUVLMUxZQUdZ?=
 =?utf-8?B?T1dqdXpnVXhiU05rZkFvUTc1M1ZYdHQ1WWx5d3hqRlhJaytyS25pZHJkYVRI?=
 =?utf-8?B?ZWZHaW9hUW1hbDZ2d2JkM3g0NGE5blBCNWhVYW81WmlFRi9CMjVpaldJMmF5?=
 =?utf-8?B?cUwxKzRUM3VzT2xsb0p0eG5WWDF1SDRNSmxvd0NXR2p0eW05Nkx2NVdkcmx0?=
 =?utf-8?B?STVxcDc2NnExaGdNTm9DbFpvcEFKOG5Hdm0rQnh0Z1NmZ1A0eXVrWVgzcStr?=
 =?utf-8?Q?f2WJn2G0/zLgOP2ilar06UI6TZDxWOBJuaUOSFf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR10MB6505.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R29mYkwxK00zY3RBdW43cVh0NGVnRndIUUVnQ2kxN3N2UzZyY1FtV0RlSXVL?=
 =?utf-8?B?UHM3Z1plUzRha0tzMmZHdVpnY1UwL1EzSk1NTkluVHR0TDArcVhROUlscjFu?=
 =?utf-8?B?UXdlVno0ZDlDWTU4RTNma3ZYeFNSMHBSdkZITko3M0ZvbDZNUm8wRlB4Sm9s?=
 =?utf-8?B?MWtnUmJwOXRPY0RaT2pyVTFyd1NzbDNkWmUySEx5cFlsTk5LYlQyQXNsYVFk?=
 =?utf-8?B?NkRsM3ZKck5MT25CdFVMMHA1Y0F1K1dzYmNieU1PU0FRSm9vck85ODYrZGdk?=
 =?utf-8?B?SlhGa3FyZFROYnlXbk5CVGg5eitLcFJ4NWF5dDRGcVhORXR2MEJtR2VEd1pw?=
 =?utf-8?B?NEprcnBkWW1CSWxPZ2szUE84bFk1TlRuMDZCZUt2S2hJSS9NUG04VDlUc29s?=
 =?utf-8?B?cnZQZi8xWFhGTUxGblQ4Zm9YN1I4WWRuVlRQQ3pZUHlWZEZEY01QUkRsaVZr?=
 =?utf-8?B?VGdlYXUxZTVFWUtic3doTDRjZ1pqTVpJVm5yNFZyVHpZamtBZk94amlKMFZL?=
 =?utf-8?B?d1Q1SjArN3RBVVB1bFRYMU1MN3c5LytKTUtCZXVrSUlydUE1UUtUMTVGcEpZ?=
 =?utf-8?B?TFFGcU5HVnlXMG9PTWFiRUpGUlFMeXF4Y3VpYkhENDdGY2pQMlIzUFJ6Sk9Z?=
 =?utf-8?B?dlNPME9TRC8xOVRyU0NWbDlPNWRDQTJBMVBVNnB5Z21WVWd6RUFlaEVWVXIr?=
 =?utf-8?B?T0RvS1JXUVBhUGxTdUk4L21KTEsySXNEbmp4SkQ3OVJ2K1lFcUYxbVQwQzR5?=
 =?utf-8?B?Y3k3RmlwUjVwU0c0Q0QrNWN5SkZuUlkvUmIveVZlek1WR3pBSzBHOTFGeU54?=
 =?utf-8?B?dGhud0pCYmZTRVZTZXFVdC84aUh5ZDJuc09RL01MVkt0NzJkeHczVEJDNEVB?=
 =?utf-8?B?WmpMMEFHaVBKR0kvdVFqdWdNb3pXOUY3WXNoVjZhTzd3algyOXRvVHN6TzBz?=
 =?utf-8?B?Qlp1ZVpXcTdjN1psNUZodjVnby95SWhhdGRGanFvTHk1UG50dG1KU2FKVFVq?=
 =?utf-8?B?STBCa1ZQZm5VbFc1Y25tZUkyays4WkFaK2pybzZKTzgvSndyUTBBOFVlcmpy?=
 =?utf-8?B?aUg2VmhVbGloWUswRHBaaGFiNnRmOVBWMlA2NFpibmlGTVlmbzkxeFlxNnVL?=
 =?utf-8?B?eU14azlNMmlES1lpU1pLd3NLVVRydzZBNEsxTk9UUGFOUUJTWVpNcjI4ZjNM?=
 =?utf-8?B?YkpmSWc2VDZUZ21kSWVUTm1INzNOYUVkbGVVNHM1SGpmeXcyaWNBUjltWnRu?=
 =?utf-8?B?RGN0S09menJoYnBUYVBMbWlGTm8zc2hRTkI4OVZLdTY2K3lMRUVrVVhWQVh3?=
 =?utf-8?B?aUNzWWx6a3lEMkt6M3QrZTV1TmUzTGhZM1RZdU9CaXhyMmt3TlZmTmozQlBo?=
 =?utf-8?B?WlI3VHN6aVFIZkF6cWVKNWY4ZERoYzNLbFpVUU9iREFLQTBLR3dEcHg1bDZ2?=
 =?utf-8?B?bytodUx0TnJ2eVBYTFZ2cWhPRDc2VkViaFhoSGZmTVdsdnp5Y1dCcDcrSlhF?=
 =?utf-8?B?bnAyZUtkUnF4bDQvTDJuOG9LRTJPRnpmTFA4ZzlqcnZIanM1Tkxad0tzU09L?=
 =?utf-8?B?UlNaYngvZldMM3VjbG0waXhKUjk0Z0pvajlsajFRSlVVU3AwTXpHVmp6NHNn?=
 =?utf-8?B?UFUwTVdXWndaczJZdEJCT2l2ejVFMVZGM05meWJIVGNOSjRiallPY0xyNE82?=
 =?utf-8?B?QVdob1ZpV1JhRTFZYTdzT08vbG5NbktkdHpkNmRTM0pnSTgzR29WUHlRNUZ6?=
 =?utf-8?B?RHY1RjA1YlB5UGd6cVlpRFpGRzh5dXBFZjNZb2t5WGdIMWZUU1NuWmc4SWs3?=
 =?utf-8?B?SzZYVktUTWRiazBXOWFyOU5CVWxNejN1Z1JlSmNyNFYwZmFNd1ByUWhrYitT?=
 =?utf-8?B?R0VhMVVCMncvaUExUEVEQlUvVi9rWDEvUTRWcVdTdkY3bklhZ25Ua1lhakRl?=
 =?utf-8?B?VEhJSGdaQ010ZTRXOTI2MjN5U2pQTGhDS2hWTWFncTVjUVFKcE5JbmZtN1pF?=
 =?utf-8?B?SGZvL0M0bXJ2N2pXL09Wa0UvNm51TUZGaGwybCtqRHoyOVlRdDBNd2U2TU1X?=
 =?utf-8?B?eHJLUUF3YjdJMHNreFdpeE9wbUJrU0hkR1I2OTZCRDdibnMzYWV2TnVtT0tV?=
 =?utf-8?B?SFJsOUhzZWhodjNPMjFHRVZnYkRlOUN3Z1F1RXE2U1JCMGloWVF0NVhBaEdS?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hCS3Zc0FecG/B5Gdgk61twBdSPaNN0d0HNzzt0DteNZ/HUew/hWXXWgbd9YsZ9r0VZ1bIlG6KCJ5ckrThAKywCt2BYihIEJR8o9vOzX1sjqSxZoeBLG0+Vgc//o7Hiz491sex1WICNs+CGGvsFMDyJmuaJMJHUlS7VPqzZ3Vtv0vYNbcjeyql6RYpqcNWgq/F1RyHxWelz2HbMKFQN7enYhh+IPKg4n5BLEi1By9vjzIPsyo2z73SFEa/0HW1I1LPOGk0FnRFcu0zLsZBKtbstwR64fhygavvpoe9Cl9XBzqCAaqpfCIeNBlyeCbQvjXHU0aCmd+25ksllp5b/yTpWVVMZS1cl213So34x29Lp5k4ZkW4vJwCJNy0p0M3/Y0zQ1ZF7RRkG18v7wibR1bwhUvN4wdclHMjkMqqh5xIPzkKIs2bxPGrb+dFy5/ZeK6ZIGnLtV2I7sQJysgjLtRVxnVzLDe9FCkfUvTOx3w9STm18d8bx+VrctVdcO09KQ22WgLdup0OPq4aBOCBebVxVQ9BrabJld6qdjY1KQuLNVsOdPmB23h/GNnvWQPO/1oz/KMx0M2J3a++KN9047Sz2vW8C23wxOLy77wAzOzLZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc5deb-ca0f-422f-e3aa-08dd0873bdac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:25:35.6060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fpgRx+uLbFkuQSMGCD1CcoBrx/nohTAwGzQ3YHwrET9aDXXnSWcs3qtvmuOwdQgVxT7Kp2ZDjckam4pcPxuhUB+q8y8SO9V923kOVE90lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190059
X-Proofpoint-GUID: WwqjUX9m_GgUNtNVpRXDTSv7SMRZcg6t
X-Proofpoint-ORIG-GUID: WwqjUX9m_GgUNtNVpRXDTSv7SMRZcg6t
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 28 Nov 2024 10:49:51 +0100
Subject: [LTP] Issue faced in memcg_stat_rss while running mainline kernels
 between 6.7 and 6.8
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
From: Harshvardhan Jha via ltp <ltp@lists.linux.it>
Reply-To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgdGhlcmUsCgpJJ3ZlIGJlZW4gZ2V0dGluZyB0ZXN0IGZhaWx1cmVzIG9uIHRoZSBtZW1jZ19z
dGF0X3JzcyB0ZXN0Y2FzZSBmb3IKbWFpbmxpbmUgNi4xMiBrZXJuZWxzIHdpdGggMyB0ZXN0cyBm
YWlsaW5nIGFuZCBvbmUgYmVpbmcgYnJva2VuLgoKUnVubmluZyB0ZXN0cy4uLi4uLi4KPDw8dGVz
dF9zdGFydD4+Pgp0YWc9bWVtY2dfc3RhdF9yc3Mgc3RpbWU9MTczMjAwMzUwMApjbWRsaW5lPSJt
ZW1jZ19zdGF0X3Jzcy5zaCIKY29udGFjdHM9IiIKYW5hbHlzaXM9ZXhpdAo8PDx0ZXN0X291dHB1
dD4+PgppbmNyZW1lbnRpbmcgc3RvcAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5uaW5nOiBt
ZW1jZ19zdGF0X3Jzcy5zaAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBUZXN0ZWQga2VybmVsOiBM
aW51eCBoYXJqaGEtb2w5a2Rldmx0cAo2LjEyLjAtbWFzdGVyLjIwMjQxMDIxLmVsOS52MS54ODZf
NjQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBNb24gT2N0IDIxCjA2OjI0OjIyIFBEVCAyMDI0IHg4
Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBVc2lu
ZwovdGVtcGRpci9sdHAtWTRBRVVtS1ZJRS9MVFBfbWVtY2dfc3RhdF9yc3Mua0VoRDBRdnZNdyBh
cyB0bXBkaXIgKHhmcwpmaWxlc3lzdGVtKQptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiB0aW1lb3V0
IHBlciBydW4gaXMgMGggNW0gMHMKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogc2V0IC9zeXMvZnMv
Y2dyb3VwL21lbW9yeS9tZW1vcnkudXNlX2hpZXJhcmNoeQp0byAwIGZhaWxlZAptZW1jZ19zdGF0
X3JzcyAxIFRJTkZPOiBTZXR0aW5nIHNobW1heAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5u
aW5nIG1lbWNnX3Byb2Nlc3MgLS1tbWFwLWFub24gLXMgMjY2MjQwCm1lbWNnX3N0YXRfcnNzIDEg
VElORk86IFdhcm1pbmcgdXAgcGlkOiA5MzY3Cm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFByb2Nl
c3MgaXMgc3RpbGwgaGVyZSBhZnRlciB3YXJtIHVwOiA5MzY3Cm1lbWNnX3N0YXRfcnNzIDEgVEZB
SUw6IHJzcyBpcyAwLCAyNjYyNDAgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgMiBUSU5GTzogUnVu
bmluZyBtZW1jZ19wcm9jZXNzIC0tbW1hcC1maWxlIC1zIDQwOTYKbWVtY2dfc3RhdF9yc3MgMiBU
SU5GTzogV2FybWluZyB1cCBwaWQ6IDkzODMKbWVtY2dfc3RhdF9yc3MgMiBUSU5GTzogUHJvY2Vz
cyBpcyBzdGlsbCBoZXJlIGFmdGVyIHdhcm0gdXA6IDkzODMKbWVtY2dfc3RhdF9yc3MgMiBUUEFT
UzogcnNzIGlzIDAgYXMgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgMyBUSU5GTzogUnVubmluZyBt
ZW1jZ19wcm9jZXNzIC0tc2htIC1rIDMgLXMgNDA5NgptZW1jZ19zdGF0X3JzcyAzIFRJTkZPOiBX
YXJtaW5nIHVwIHBpZDogOTQ0NgptZW1jZ19zdGF0X3JzcyAzIFRJTkZPOiBQcm9jZXNzIGlzIHN0
aWxsIGhlcmUgYWZ0ZXIgd2FybSB1cDogOTQ0NgptZW1jZ19zdGF0X3JzcyAzIFRQQVNTOiByc3Mg
aXMgMCBhcyBleHBlY3RlZAptZW1jZ19zdGF0X3JzcyA0IFRJTkZPOiBSdW5uaW5nIG1lbWNnX3By
b2Nlc3MgLS1tbWFwLWFub24gLS1tbWFwLWZpbGUKLS1zaG0gLXMgMjY2MjQwCm1lbWNnX3N0YXRf
cnNzIDQgVElORk86IFdhcm1pbmcgdXAgcGlkOiA5NDYyCm1lbWNnX3N0YXRfcnNzIDQgVElORk86
IFByb2Nlc3MgaXMgc3RpbGwgaGVyZSBhZnRlciB3YXJtIHVwOiA5NDYyCm1lbWNnX3N0YXRfcnNz
IDQgVFBBU1M6IHJzcyBpcyAyNjYyNDAgYXMgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgNSBUSU5G
TzogUnVubmluZyBtZW1jZ19wcm9jZXNzIC0tbW1hcC1sb2NrMSAtcyAyNjYyNDAKbWVtY2dfc3Rh
dF9yc3MgNSBUSU5GTzogV2FybWluZyB1cCBwaWQ6IDk0NzkKbWVtY2dfc3RhdF9yc3MgNSBUSU5G
TzogUHJvY2VzcyBpcyBzdGlsbCBoZXJlIGFmdGVyIHdhcm0gdXA6IDk0NzkKbWVtY2dfc3RhdF9y
c3MgNSBURkFJTDogcnNzIGlzIDAsIDI2NjI0MCBleHBlY3RlZAptZW1jZ19zdGF0X3JzcyA2IFRJ
TkZPOiBSdW5uaW5nIG1lbWNnX3Byb2Nlc3MgLS1tbWFwLWFub24gLXMgMjY2MjQwCm1lbWNnX3N0
YXRfcnNzIDYgVElORk86IFdhcm1pbmcgdXAgcGlkOiA5NDk1Cm1lbWNnX3N0YXRfcnNzIDYgVElO
Rk86IFByb2Nlc3MgaXMgc3RpbGwgaGVyZSBhZnRlciB3YXJtIHVwOiA5NDk1Cm1lbWNnX3N0YXRf
cnNzIDYgVEZBSUw6IHJzcyBpcyAwLCAyNjYyNDAgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgNiBU
QlJPSzogdGltZWQgb3V0IG9uIG1lbW9yeS51c2FnZV9pbl9ieXRlcyA0MDk2IDI2NjI0MAoyNjYy
NDAKL29wdC9sdHAtMjAyNDA5MzAvdGVzdGNhc2VzL2Jpbi90c3RfdGVzdC5zaDogbGluZSAxNTg6
wqAgOTQ5NQpLaWxsZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNnX3By
b2Nlc3MgIiRAIsKgICh3ZDoKL3N5cy9mcy9jZ3JvdXAvbWVtb3J5L2x0cC90ZXN0LTkzMDgvbHRw
XzkzMDgpCgpTdW1tYXJ5OgpwYXNzZWTCoMKgIDMKZmFpbGVkwqDCoCAzCmJyb2tlbsKgwqAgMQpz
a2lwcGVkwqAgMAp3YXJuaW5ncyAwCjw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4KaW5pdGlhdGlvbl9z
dGF0dXM9Im9rIgpkdXJhdGlvbj0xNyB0ZXJtaW5hdGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlv
bl9pZD0zIGNvcmVmaWxlPW5vCmN1dGltZT0xMyBjc3RpbWU9NTgKPDw8dGVzdF9lbmQ+Pj4KSU5G
TzogbHRwLXBhbiByZXBvcnRlZCBzb21lIHRlc3RzIEZBSUwKTFRQIFZlcnNpb246IDIwMjQwOTMw
CgpJJ20gbm90IHN1cmUgd2hldGhlciB0aGlzIGVycm9yIGlzIGR1ZSB0byB0aGUga2VybmVsIG9y
IHRoZSB0ZXN0Y2FzZQpiZWluZyBvdXRkYXRlZC4gSSBrbm93IHRoYXQgc2luY2UgY2dyb3VwIHYy
IGlzIHRoZSBkZWZhdWx0IHVwc3RyZWFtIGFuZApjZ3JvdXAgdjEgaXMgbm93IGEgbGVnYWN5IG9w
dGlvbiwgdGhpcyBzcGVjaWZpYyB0ZXN0Y2FzZSBpcyBub3QKcGFydGljdWxhcmx5IGhpZ2hlciBp
biB0aGUgcHJpb3JpdHkgbGlzdCwgYnV0IGp1c3QgdG8gYmUgc3VyZSwgSSB3YW50ZWQKdG8gdmVy
aWZ5IHRoaXMgZnJvbSB5b3VyIHNpZGUuIFBsZWFzZSBsZXQgbWUga25vdyB3aGV0aGVyIHRoaXMg
ZXJyb3IgaXMKY29taW5nIGR1ZSB0byB0aGUgdGVzdGNhc2UgYmVpbmcgb3V0ZGF0ZWQgb3IgdGhp
cyBpbiBmYWN0IGlzIGEgdmFsaWQKa2VybmVsIGVycm9yLgoKSSByYW4gYSBiaXNlY3Qgb24gbWVt
Y2dfc3RhdF9yc3MgdGVzdCB1cG9uIG1haW5saW5lIGtlcm5lbHMgYW5kIHNhdyB0aGUKYmlzZWN0
IHJhbmdlIG5hcnJvdyBkb3duIGJldHdlZW4gNi43IGFuZCA2Ljggd2hpY2ggZnVydGhlciBpc29s
YXRlZCB0bzoKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
c3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2lkPTdkN2VmMGE0Njg2YWJlNDNjZDc2YTE0MWIzNDBh
MzQ4ZjQ1ZWNkZjIKVGhpcyBjb21taXQgd2FzIHBhcnQgb2YgYSA1IHBhdGNoIHNlcmllcyBhbmQg
SSB3YXNuJ3QgYWJsZSB0byByZXZlcnQgaXQKb24gNi4xMiB3aXRob3V0IGdldHRpbmcgYSBzZXJp
ZXMgb2YgY29uZmxpY3RzLgpTbywgd2hhdCBJIGRpZCB3YXMgY2hlY2tvdXQgdGhlIFNIQSBiZWZv
cmUgdGhpcyBwYXRjaCBzZXJpZXMKNGEzYmZiZDE2OTllMjMwNjczMTgwOWQ1MGQ0ODA2MzQwMTJl
ZDRkZSBhbmQgYWZ0ZXIgdGhlIHBhdGNoIHNlcmllcwo3ZDdlZjBhNDY4NmFiZTQzY2Q3NmExNDFi
MzQwYTM0OGY0NWVjZGYyIGFuZCByYW4gdGhpcyB0ZXN0LgoKVGhlIG1hY2hpbmUgaGFkIDMyR0Ig
UmFtIGFuZCA0Q1BVcy4KClRoZSBzdGVwcyB0byByZXByb2R1Y2UgdGhpcyBhcmU6CgojIS9iaW4v
YmFzaAoKIyBBZnRlciBzZXR0aW5nIGRlZmF1bHQga2VybmVsIHRvIHRoZSBkZXNpcmVkIG9uZQpp
ZiAhIGdyZXAgLXEgInVuaWZpZWRfY2dyb3VwX2hpZXJhcmNoeT0wIiAvcHJvYy9jbWRsaW5lOyB0
aGVuCsKgwqDCoMKgwqDCoMKgIHN1ZG8gZ3J1YmJ5IC0tdXBkYXRlLWtlcm5lbCBERUZBVUxUCi0t
YXJncz0ic3lzdGVtZC51bmlmaWVkX2Nncm91cF9oaWVyYXJjaHk9MCIKwqDCoMKgwqDCoMKgwqAg
c3VkbyBncnViYnkgLS11cGRhdGUta2VybmVsIERFRkFVTFQKLS1hcmdzPSJzeXN0ZW1kLmxlZ2Fj
eV9zeXN0ZW1kX2Nncm91cF9jb250cm9sbGVyIgrCoMKgwqDCoMKgwqDCoCBzdWRvIGdydWJieSAt
LXVwZGF0ZS1rZXJuZWwgREVGQVVMVCAtLWFyZ3Mgc2VsaW51eD0wCsKgwqDCoMKgwqDCoMKgIHN1
ZG8gc2VkIC1pICIvXlNFTElOVVg9L3MvPS4qLz1kaXNhYmxlZC8iIC9ldGMvc2VsaW51eC9jb25m
aWcKwqDCoMKgwqDCoMKgwqAgc3VkbyByZWJvb3QKZmkKCmNkIC9vcHQvbHRwCnJtIC1yZiAvdG1w
ZGlyCm1rZGlyIC90ZW1wZGlyCi4vcnVubHRwIC1kIC90ZW1wZGlywqAgLXMgbWVtY2dfc3RhdF9y
c3MKCgpUaGUgcmVzdWx0cyBvYnRhaW5lZCB3ZXJlOgoKUHJlIGJpc2VjdCBjdWxwcml0ICg0YTNi
ZmJkMTY5OWUyMzA2NzMxODA5ZDUwZDQ4MDYzNDAxMmVkNGRlKToKCjw8PHRlc3Rfc3RhcnQ+Pj4K
dGFnPW1lbWNnX3N0YXRfcnNzIHN0aW1lPTE3MzE3NTQwNzgKY21kbGluZT0ibWVtY2dfc3RhdF9y
c3Muc2giCmNvbnRhY3RzPSIiCmFuYWx5c2lzPWV4aXQKPDw8dGVzdF9vdXRwdXQ+Pj4KaW5jcmVt
ZW50aW5nIHN0b3AKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogUnVubmluZzogbWVtY2dfc3RhdF9y
c3Muc2gKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogVGVzdGVkIGtlcm5lbDogTGludXggaGFyamhh
LW9sOWtkZXZsdHAKNi43LjAtbWFzdGVycHJlLjIwMjQxMTEuZWw5LnJjMS54ODZfNjQgIzEgU01Q
IFBSRUVNUFRfRFlOQU1JQyBGcmkgTm92IDE1CjExOjU2OjEwIFBTVCAyMDI0IHg4Nl82NCB4ODZf
NjQgeDg2XzY0IEdOVS9MaW51eAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBVc2luZwovdGVtcGRp
ci9sdHAtU3pFOUFESzZNTS9MVFBfbWVtY2dfc3RhdF9yc3MuNm9wMjhzTVhPMiBhcyB0bXBkaXIg
KHhmcwpmaWxlc3lzdGVtKQptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiB0aW1lb3V0IHBlciBydW4g
aXMgMGggNW0gMHMKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogc2V0IC9zeXMvZnMvY2dyb3VwL21l
bW9yeS9tZW1vcnkudXNlX2hpZXJhcmNoeQp0byAwIGZhaWxlZAptZW1jZ19zdGF0X3JzcyAxIFRJ
TkZPOiBTZXR0aW5nIHNobW1heAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5uaW5nIG1lbWNn
X3Byb2Nlc3MgLS1tbWFwLWFub24gLXMgMjY2MjQwCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFdh
cm1pbmcgdXAgcGlkOiAzNDIzNwptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBQcm9jZXNzIGlzIHN0
aWxsIGhlcmUgYWZ0ZXIgd2FybSB1cDogMzQyMzcKbWVtY2dfc3RhdF9yc3MgMSBUUEFTUzogcnNz
IGlzIDI2NjI0MCBhcyBleHBlY3RlZAptZW1jZ19zdGF0X3JzcyAxIFRCUk9LOiB0aW1lZCBvdXQg
b24gbWVtb3J5LnVzYWdlX2luX2J5dGVzIDQwOTYgMjY2MjQwCjI2NjI0MAovb3B0L2x0cC0yMDI0
MDkzMC90ZXN0Y2FzZXMvYmluL3RzdF90ZXN0LnNoOiBsaW5lIDE1ODogMzQyMzcKS2lsbGVkwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1jZ19wcm9jZXNzICIkQCLCoCAod2Q6
Ci9zeXMvZnMvY2dyb3VwL21lbW9yeS9sdHAvdGVzdC0zNDE4MC9sdHBfMzQxODApCgpTdW1tYXJ5
OgpwYXNzZWTCoMKgIDEKZmFpbGVkwqDCoCAwCmJyb2tlbsKgwqAgMQpza2lwcGVkwqAgMAp3YXJu
aW5ncyAwCjw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4KCgpQb3N0IGJpc2VjdCBjdWxwcml0KDdkN2Vm
MGE0Njg2YWJlNDNjZDc2YTE0MWIzNDBhMzQ4ZjQ1ZWNkZjIpOgoKPDw8dGVzdF9zdGFydD4+Pgp0
YWc9bWVtY2dfc3RhdF9yc3Mgc3RpbWU9MTczMTc1NTMzOQpjbWRsaW5lPSJtZW1jZ19zdGF0X3Jz
cy5zaCIKY29udGFjdHM9IiIKYW5hbHlzaXM9ZXhpdAo8PDx0ZXN0X291dHB1dD4+PgppbmNyZW1l
bnRpbmcgc3RvcAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5uaW5nOiBtZW1jZ19zdGF0X3Jz
cy5zaAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBUZXN0ZWQga2VybmVsOiBMaW51eCBoYXJqaGEt
b2w5a2Rldmx0cAo2LjcuMC1tYXN0ZXJwb3N0LjIwMjQxMTEuZWw5LnJjMS54ODZfNjQgIzEgU01Q
IFBSRUVNUFRfRFlOQU1JQyBGcmkgTm92CjE1IDExOjU1OjQxIFBTVCAyMDI0IHg4Nl82NCB4ODZf
NjQgeDg2XzY0IEdOVS9MaW51eAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBVc2luZwovdGVtcGRp
ci9sdHAtRzZjZ2U0Q2tyUi9MVFBfbWVtY2dfc3RhdF9yc3MuMXpybTZYMDJDTyBhcyB0bXBkaXIg
KHhmcwpmaWxlc3lzdGVtKQptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiB0aW1lb3V0IHBlciBydW4g
aXMgMGggNW0gMHMKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogc2V0IC9zeXMvZnMvY2dyb3VwL21l
bW9yeS9tZW1vcnkudXNlX2hpZXJhcmNoeQp0byAwIGZhaWxlZAptZW1jZ19zdGF0X3JzcyAxIFRJ
TkZPOiBTZXR0aW5nIHNobW1heAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5uaW5nIG1lbWNn
X3Byb2Nlc3MgLS1tbWFwLWFub24gLXMgMjY2MjQwCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFdh
cm1pbmcgdXAgcGlkOiA5MDgzCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFByb2Nlc3MgaXMgc3Rp
bGwgaGVyZSBhZnRlciB3YXJtIHVwOiA5MDgzCm1lbWNnX3N0YXRfcnNzIDEgVEZBSUw6IHJzcyBp
cyAwLCAyNjYyNDAgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgMSBUQlJPSzogdGltZWQgb3V0IG9u
IG1lbW9yeS51c2FnZV9pbl9ieXRlcyA0MDk2IDI2NjI0MAoyNjYyNDAKL29wdC9sdHAtMjAyNDA5
MzAvdGVzdGNhc2VzL2Jpbi90c3RfdGVzdC5zaDogbGluZSAxNTg6wqAgOTA4MwpLaWxsZWTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNnX3Byb2Nlc3MgIiRAIsKgICh3ZDoK
L3N5cy9mcy9jZ3JvdXAvbWVtb3J5L2x0cC90ZXN0LTkwMjQvbHRwXzkwMjQpCgpTdW1tYXJ5Ogpw
YXNzZWTCoMKgIDAKZmFpbGVkwqDCoCAxCmJyb2tlbsKgwqAgMQpza2lwcGVkwqAgMAp3YXJuaW5n
cyAwCjw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4KClRoYW5rcyAmIFJlZ2FyZHMsCkhhcnNodmFyZGhh
bgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
