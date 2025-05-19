Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903E5C3ABDD
	for <ltp@archiver.kernel.org>; Mon, 19 May 2025 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747680020; h=message-id :
 date : to : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=vHdKlWgElrorMjuuYCAUNAg3cxnXJXyf8JmBClzBg7Q=;
 b=PbL/DV3gnd6AVPIINCIbllxv2dAo8FotpRTUvAfipEJ2Rf0OcVuhVsLRZ4t5/0HU93NO2
 RZyorZYv3Hij3+suRHd6sE6sdL+kxiaN19ml6y0mGV5SVmvrGXbReAoXYzQB+KUc9VoOaXg
 wvJBkY8y2r/IhtQnq3vdT0vnlEb8izk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D4853CC72A
	for <ltp@archiver.kernel.org>; Mon, 19 May 2025 20:40:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B4293C68A4
 for <ltp@lists.linux.it>; Mon, 19 May 2025 20:39:57 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 320CC1A003C6
 for <ltp@lists.linux.it>; Mon, 19 May 2025 20:39:53 +0200 (CEST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGNP2c011411
 for <ltp@lists.linux.it>; Mon, 19 May 2025 18:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=0l9wOgmaOLj8Zbzc
 Kh0TmnWErI5cvVJADfYj+XyglX8=; b=BhHn3ewdcEcbSV0v4c7rSZIAwlszD5it
 pu/MCfPefp0fSFAOjl2yUy9in1ynABWAksyBsNertTpNBaExoJTl4EeUK9FbPGsf
 cuANZGfn8Akm9LuyNh45Hl4uLm82f6RP896+dphgqQKqR9Lthg8z42ESYh9euIOg
 h+M7T9d0RgUCemq9rilLo+X3CThC+JiRojbfpdy1XWry8DsOwD+FrU5Ppc2VP+2a
 idPa/cY4EiWD3CiBbweAYRqwKmSBj2c2AMLT89fZPUYU32r6ca8Fl386kVCqVequ
 BjLRrysEcJwZthcBqrOjm4G/fVCKafM2fC9sIyc4rf8UIpSF8lkXgA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46phcdusg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 19 May 2025 18:39:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JGu2So015606
 for <ltp@lists.linux.it>; Mon, 19 May 2025 18:39:51 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013063.outbound.protection.outlook.com
 [40.93.20.63])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6ta81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 19 May 2025 18:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK7rHN/cm0Vzvyw92dNN1z9VJ8Vte6hXpa9O8uKtTtfpE82DLAtReOeG53sQJGnmoMfT+m8eWcrNpggqMACC+o4o/lnqBTlhzgLuFD3SaGmhJLdZkYEe6iGzfVTDUnzA9PGDBJ1Z30YM356x1NufzC2kgoIdzSsEySLW86s49sBnDsaH+3uc0GxGhDmkbsbOf/89df5adIgmpH2SHbBovkMNJzBlVof9ixDYBFQlOBMlVC2MRT6gpn/uMl4uRX0wRKTJOBpI7irSxFbJ5hjhU0y5kNxDdRR1ng5ISGBhR178085L4KMW4g/toRIKHaM1zLnKgdmmfr9srBad2CkJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l9wOgmaOLj8ZbzcKh0TmnWErI5cvVJADfYj+XyglX8=;
 b=kEHdl2Dho9nZFqxZ8yYb1hpRsxEMbaE2/+wgoERguczqp36x68EIlzDfsjdVwydMfX0P6FuaNZywfAUAAZAwH1VxHKqk17KAohIorj1FLpTg46OgqpwLc6EwM/U4fCAFpLW3CydedtBHQFa5Kr5/uYoIptIXv3+nOvEJI72KHShfperOtiEABMqowAMPjCJBmq4AI559cVPT+kN9Yn8kBGQTWcgRKdsW4bTolibSSLstOCToD+vdflP+8u2dXLNOccLs0Kgjye1TTL21wreQudpjpvVw15w2GRCRl7AlQ2m+7ov+TRbPeWbcQ7Y/h/N8rz+g2fmdRjDXr+9FAsRgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l9wOgmaOLj8ZbzcKh0TmnWErI5cvVJADfYj+XyglX8=;
 b=YZ2cfRDEF6D93uUS72xch5PaONLDweLCAI7csDql6p6XmVCLfyFqOmI3lmPjL2fLXgqGy0A5ajAjInIz/3ZAs5RbawHavjBcA1lpBbaVU6EcmN6AIpdjdMPctCYhA3Wh0HeX0KNF3UvKDjKU21bF7Qcj3yIpaAVhsVqg03zTnII=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8515.namprd10.prod.outlook.com (2603:10b6:208:572::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 18:39:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Mon, 19 May 2025
 18:39:48 +0000
Message-ID: <5964b0f9-e422-46b9-bab1-04e699e2f5f6@oracle.com>
Date: Mon, 19 May 2025 14:39:47 -0400
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
Content-Language: en-US
X-ClientProxiedBy: CH0PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:610:74::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fae3d5-535b-4635-deb6-08dd9704888f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmJ3bkxZV0ZQTGJLRDVNYk13dmJ1QzlVVkNONm5WV0x2cW1ueDVSeEMrdTA5?=
 =?utf-8?B?ZE9VOGluVEV0dkdOUzNIVVZ3L0pSZC9ERFM4Qnl0ZS9zMlBKK0N2aTYwS2t1?=
 =?utf-8?B?b3FGSnRrUXI0TUFRQW8zN1U5RE5zN01yV1l4cHJ6ZjFFa3RMZldkeWN5YThp?=
 =?utf-8?B?b2svTHZ4T3BUaU5FcWFuRnpYdisrVHlOWlJmRk45bEprNnlOdVpxUHg3NmJ2?=
 =?utf-8?B?VHpCbkwzYXpHR0tMUEVqTG1aTzJrS3Z0K1BxQnNQZHBJOGloRStMbWVQRVA1?=
 =?utf-8?B?bDJFRXBvbTBFMUZsd1IwMm93bllPOTUvQU5HbGtpVVI1Ris3TktWdFVyMTRJ?=
 =?utf-8?B?M3IyWDNZdDZtT3ZZamZBTE9LcDY2UU5KYkFaRUg2bklhN1B3NzVoZCs1bmph?=
 =?utf-8?B?K3dPSzlsTlA3YmhGU1hva1F5bVliM0x4MURWazk3OGF2eVBpbkQ2U04vUXl6?=
 =?utf-8?B?Nlkra3crL01pSkJubFh0Tno3MHVieENiRVZSQXZBMlovNUJSajR5ck5Xd0NU?=
 =?utf-8?B?UUNIK0g2UWpLM1Qvc3B4VDRKZFB0aVVNc04vd09KWElIYjhsU0ZXd1F5VnMy?=
 =?utf-8?B?Zkw0UFNtK0VsQjc4OTUzRktHSVdnWVFJbWtQNWZScDdpcSt3YjJXOXVJVVhP?=
 =?utf-8?B?WmxnbS9OOHE5bTY1eFJ4SHUwUm56dlNqNkF0ampkQkdTRktJdnpLdGJYRlNM?=
 =?utf-8?B?UlF6dExxZUNQMnk3T1hQZGJJM0I3dHRUOXFYazdlK1plMVVhTkEzYWJ4d3Fw?=
 =?utf-8?B?bEx6SnlWcFpkdEdnbDRqL0lSVUQ3cDV0RmxHQmFrd2pwSEwzZGRzOVoyOVMw?=
 =?utf-8?B?K1cybkljVm5udEs0KzNoNlp3TnJDc3NnSWdycmZmcFRWWnEzRzBGd0gwZlJr?=
 =?utf-8?B?Zmw5bHdxRmNNWjVMQy81NmNHdmg5dlNGUVV5cnFWSVBkVkoxMkdraGkwNkIr?=
 =?utf-8?B?RnF6bzA1ZWVicklDZ2JrY01lZ01DRzJDeXZ5NjJXNUVZZ3UzeUVGeG1uMENi?=
 =?utf-8?B?SDBlSWpZQmx5VEs4SW9SV0tidVp4K3hNUXcxZGk3UEMxZUFYVDFzSjdNaEhj?=
 =?utf-8?B?b1pPcmZGOVExeUliVDdSVkFTT3ozcjFqM01ocmZ6ZUxMdE5BNW16RnY3bHRh?=
 =?utf-8?B?MHExVk1DeU5PbnRxRUxUdlRrNUIrRlh6d21GRGl1ZmFCSVU5eThvcTlHQlVQ?=
 =?utf-8?B?VTJ4a0UrSThRNFNxa01GVTk4clVtQ0p1NjA5U2dNTHNtQzFxUTV2MG15ZWVV?=
 =?utf-8?B?NWhUZ0Q4bHNvNTFKODNjd1dtWlUzUnQvR21OTjdkeWM4R1c2TXFnRFoweG81?=
 =?utf-8?B?bWhCMUNKQVJabC81cVpjdEd1Zmt4WmxXUldINVEzWnd1SUxWTTN0T2llZktT?=
 =?utf-8?B?NnZXdVlQTkZ1RjRndklFZC9jLzZRa0FpMEM5MWRteW9RZjVNRERncjRBWU5h?=
 =?utf-8?B?YTVBSW5WUllldlNIZ1Ruak04UGtOZUtka29SdlkzWFBtWTJUcWNGanZ6MjFI?=
 =?utf-8?B?ZHVNVC9LSThDVnNYWHZGYzdyaWZrQWIwODRBem5kWVcycTI1cG1SRHN6VmY3?=
 =?utf-8?B?MC95azZpNzN6Z1NyOEozLzgwelBYNUs5NTd6TVpYNnpWL3Z4SVZMRUg3Y24v?=
 =?utf-8?B?U1Z2UGU3aytEU3BQOE04bWZOeHp4T1M2czRuV1cycFlCbXpJcFp3UG4yVjF3?=
 =?utf-8?B?VnRsd2ZWdk04K1ByVU1DM2x1RElRNmhzZHZsbzdQSGVsTW9NbzF1VjZkR2tq?=
 =?utf-8?B?a3BVOE5zMFZMaDBWSGpodURqaHlacTluSmhPMEFJNktWZUVZK2prRjFYR0o1?=
 =?utf-8?B?MGRMdHRDQkgxRWNOUmdSQmRzUEVZd3dsSEZLclJudUNJcVFxZGRyc21zZGFD?=
 =?utf-8?B?Q0M1eEJ5Q0dZNjNIT1JqOVZJWEVhWkdsTWRtNEV3V2IvVFZneURnQkEyeGNW?=
 =?utf-8?Q?vCKo7kcQsn8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVdHTzh5WGMyamc2TFdIdVlmYUh4TGZiQWdaWkhmSmtPazBWMlBIWVN2TmZ4?=
 =?utf-8?B?QTVWcDVkSUZIN1hoNnAxY3RQV1c5c3FpcUhIazhxMU50Qm5XMkZqMlJzMFJm?=
 =?utf-8?B?eGNDRFhJR3BmRS9OcE5LS2R5Ukx6bVN6Z2dYc2ZLMi8rVVJXZ0tXbHpsczQ3?=
 =?utf-8?B?dS9uL3dhM09sOWxGRDVjbkpDTkdoSHBFYm1HRVRmUkZyVUhuSmJrZ3Z0MUJV?=
 =?utf-8?B?Q2dYSXVKZEJ4bWF5T3RKNXk5QnhMR2t6WDJ6bGVJSUs3RzM1YnhoS053bldh?=
 =?utf-8?B?VUdKWFJWM2x6My9oS3FSc29FeWVIOXUxakdiSGNxNG5RM0tuYlhEMEhDNjl2?=
 =?utf-8?B?K25aU3RiVi93SEVjdGQ2UTZ0UVhEenNxWkk5YWxTamFSUTFPY1pMUlBKZGMy?=
 =?utf-8?B?Yi9Oc2tCZ3ZnNkFpOS9YOEQydk5Za0NibGVseU83ODJNdEJKMEZrQ2IrNE0z?=
 =?utf-8?B?SFZORldLZW5hTXZYNEZLaUN5NUNYNzc1MytDY0FaSTVpcFBrUk8xQmQxUWc5?=
 =?utf-8?B?SVdoenhVZ3VORTdDVm5vUG5nNEhNNHozdGxleVdqdzU2N2hxWEF5VWJKSEdq?=
 =?utf-8?B?WDlhbFpnNTlHZUFMbXhTNENRbU8yQXF4SndpOG1QQnZrV2RmQnNkNDkwUFZ6?=
 =?utf-8?B?QlB6dGNvaU56Q2l1S054QXk0d21ubERBTEtSY2YwSE96akFYRXdiVzVSZC9L?=
 =?utf-8?B?MkN1YWZVL3ZYcHoxYzhpbmJKR0Z2b3Y0SHcvTGt3OFdiU2tmQzlGWGo1Nytw?=
 =?utf-8?B?bEMrRkdUNERlSVd1UWIveEdWTnl2bEVPa2FyL3FrY1NEZEtRZUNOZ1FWMWpB?=
 =?utf-8?B?VUlsUzNMSDI4Zk42N0p2ZE9tOThib2liaWozZ1Z3b1BMVld2N21pMlVsNWNn?=
 =?utf-8?B?M0l0RzZYNG1UTDNJTm1kQ1dIRDRITFRZNjNKbWh1eC9OL01rcTdxMTBWU2lF?=
 =?utf-8?B?dnU1MTB5dDh0THhiVzI0dWhEZEN4OFRpMEF0TDF0UjZtZ2dJNTRHZ0sxSmJG?=
 =?utf-8?B?NSt2cmRySGswTU9wQ1M2dnFWV2FmbmFuRmZ4a3JwSlZnQTM1QS95enF4dkdQ?=
 =?utf-8?B?UFFuM3NJUWVOWW5YZm16VkZ6WCtNalBPU280MWc5TWszVnA1cndSbENKdnpV?=
 =?utf-8?B?V0loOWllZzJBUkFoS2Q2d3IzOWUyYzVRN0xEVlVqUU43MFk3amtCOGxXaVQ4?=
 =?utf-8?B?NDA5ZW5oL0FpVVBHeklqUU1MWWxoV1kzNXlmd1pKU3h3YVU5U2tSOTFUWmMz?=
 =?utf-8?B?UFp3dHBjdEQybW53ckJkYjZ0VHp5WFE1dTNEVEViMXpiSlRrdG5mUnJaaTF6?=
 =?utf-8?B?QW5qZ2w1bEZzSXczcE9iV3hTaWU4aUR3VllENU8rRmpaK2xiZ0p2Rk1OQ0Er?=
 =?utf-8?B?YnVJOW5RZ1dCeTluOE5JOUh1QWtPSVJqelJobzhKeit0MmhRN2x2VjNlaGM2?=
 =?utf-8?B?d3ZJNlluQkRDdkNIUDNYQjh2a1FST0JsVDVuU2JMY2h6S0QvRzlpbU5QRFE2?=
 =?utf-8?B?clowSFRyZTNHeTV2cnNXcUZyM1B5MXE3bVZYNmJpWmZ0NVVrRjZnblo2eGF0?=
 =?utf-8?B?ZVNQalFlbWZjVmVWc1hSeXpqTjZzQnFJMjBhUmVKYjJxSEVnaCtWT0Njem4r?=
 =?utf-8?B?TFdIcUQ4L0tKZzNSbkRhWmZDNVFiNjdWRjl6cW9NRXhHUjVxS3NyMDVURC9y?=
 =?utf-8?B?aFhaaEt3ZmZvanFOSHgzTEErYWpOVXRTcndSRnh3KzlGUG80TUJsZ21JZUNM?=
 =?utf-8?B?NGEzOEd6STZ1YjErWUZRUE1aNVlMdVg2alFrUE1RTFpHRjZVTm1PMXBRZXZC?=
 =?utf-8?B?SDBwYUw0N21HcmRSSnJEai9ndzNicXM4NDhsRzRGMmc4TnVsNmUvK29zVlM3?=
 =?utf-8?B?OUd4NXFBR1hZZkQ1VFAyZ0hsSUMvSzdGUWUzSDlDRjJ4WEFkdE5OVktOQURu?=
 =?utf-8?B?dFYzakpKdnRpTTgvcHBVQ3dqdHVZbnNEWEhTRitPalJoRktMMzR2NEx4QkVT?=
 =?utf-8?B?L3R2MDhiZDh6NXpIM0NGR3MvbzVIenJDUTlLdlEzQURwai9CaWo1VGQ2bkph?=
 =?utf-8?B?M0tQMklMM2RtN0t3ZHR2aUNkNmp4U21FNStIeFBJSkxKa2gvbnd2WmkveENa?=
 =?utf-8?B?dzIwTU1Jdlc1V0VhTE9PZ3ltN0lSWGhnVjViekNkNVU2b3hGVXpGdi9tQWFm?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6emSPlWboX/XReM8urHpdXZwmbayDOfrViQSnHLdK/AQN/niiYLyYuzjCT1KI7FcYjWaIhe9Pei9wnW7S9+1hWtFJzCWSjG6U47uibK8A2HSYh3XTpneUcEsc398s7t0U+SnK0pMA6ZmIR8B397/XxTXaTg6E7tg9yCih95UbyqltZ6nDPjOBXOrVFJBLDT3uFD/0L1wReW8yCv1PNngRbF0KSr5y62fu/zKWzdpfSWoBUjIp8z0MO3PBmesaipP1Ts6nsCOH/0BNUrsq/FPxq2yPczGFe+f9YWutAxde4Y4f3f1Uz9zY+2SZhqKNHaTRzaiNwqNp8tLcYx2OTpM2Zm3TZLzzno/o4KA7a0P5H60lNQYFuiqfGC887pgEVMQFvt6Yur/19L+dje39yDIwC2Xn4zOGTmr6cAGAJwYLRyoKdczx5ibrlGX4AnHKSxP8OfkndSHN4fP7qnMXz57o1wd5Pl8gacoEJJBkWDOEDpD72Z6iDnWoCnLitvZXU1aaNvPTOTSg6tOxeRJKeMleQTRKwYQq7Beter8vPJ52awzUfVD1N/13IQ1nDPAvkeaC7nR6vuf62zcaX9uEP5LEKIigl1cW57tKLtR7YYpV5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fae3d5-535b-4635-deb6-08dd9704888f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:39:48.5063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1CbguCJwp1ySnSqddnW6uSYnpRwWkUAh4YrEXh8Jy50MbbtGqjPfEGmDh0llXmVqqUplRE4AjvEX0NEQ4//Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=757 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190174
X-Authority-Analysis: v=2.4 cv=a6gw9VSF c=1 sm=1 tr=0 ts=682b7af7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=OK3hTjM-U8Y2B5h7xa4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZeOL-b6trBBkMN3IqULd1IkqzG_ngzWi
X-Proofpoint-ORIG-GUID: ZeOL-b6trBBkMN3IqULd1IkqzG_ngzWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE3MyBTYWx0ZWRfX7n9o6909pvnl
 JnAbSdrKpmb5ZPoA5Ylbk5VT39nxQbba85lr6+ISQ9GZ7hJMj7xh+13jtJK0cl8Xkpkdva86oiy
 eWUkbVxzkhNKDvPwy6kWOcEzWrNQiF75pDeUymcjQYOZAAnP89xAC66xLNLOx+fnocjEVTFO83w
 cuvk80rtsEy+DrLR5dB/yrxoqY0fU+gTQxsSH6w2ruv7KKniGfX3i8Vijc9adMODXvwF2NzQ/Jl
 XMdbzJzQR2N552FKZ/CP+/HlPO3FqSQq4UVqGKxSZK3gSqG1L+XCq0qydm4RzNx9QMtg4qFBYAo
 yvKaE3yrvKcEPOq8hpGMwvR40d8wU7EsVqXqkiTGeBCKFK86rHlCoBBEN0FEkCcuyfRVo5YUPXa
 kfb45IRS4DVuGYheknLYU7xbpt7TUMFB03Da7XUYqAKWJbG9CqNZwwVSYkdwRgubtmGbUdAC
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] latest ltp not building on RHEL 9.6 ?
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
From: Chuck Lever via ltp <ltp@lists.linux.it>
Reply-To: Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgLQoKTXkgZGFpbHkgQ0kgYnVpbGRzIGx0cCBhbmQgcnVucyBpdCBhZ2FpbnN0IG15IG5mc2Qt
dGVzdGluZyBicmFuY2guCkZvciB0aGUgcGFzdCB3ZWVrIG9yIHNvLCB0aGUgbHRwIGJ1aWxkIGZh
aWxzIHdpdGg6CgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gY3ZlLTIwMTctMTY5MzkuYzoyODoKLi4v
Li4vaW5jbHVkZS9sYXBpL3NjaGVkLmg6MTg6ODogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhz
dHJ1Y3Qgc2NoZWRfYXR0cuKAmQogICAxOCB8IHN0cnVjdCBzY2hlZF9hdHRyIHsKICAgICAgfCAg
ICAgICAgXn5+fn5+fn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2JpdHMv
c2NoZWQuaDo2MCwKICAgICAgICAgICAgICAgICBmcm9tIC91c3IvaW5jbHVkZS9zY2hlZC5oOjQz
LAogICAgICAgICAgICAgICAgIGZyb20gLi4vLi4vaW5jbHVkZS9sYXBpL3NjaGVkLmg6MTAsCiAg
ICAgICAgICAgICAgICAgZnJvbSBjdmUtMjAxNy0xNjkzOS5jOjI4OgovdXNyL2luY2x1ZGUvbGlu
dXgvc2NoZWQvdHlwZXMuaDoxMDI6ODogbm90ZTogb3JpZ2luYWxseSBkZWZpbmVkIGhlcmUKICAx
MDIgfCBzdHJ1Y3Qgc2NoZWRfYXR0ciB7CiAgICAgIHwgICAgICAgIF5+fn5+fn5+fn4KClRoZSB0
ZXN0IHJ1bm5lciBpcyBhIFJIRUwgOS42IGd1ZXN0LiBJIGRvbid0IHNlZSBhbnkgcmVjZW50IGNo
YW5nZXMgdG8KbHRwIGluIHRoaXMgYXJlYSwgc28gcGVyaGFwcyA5LjYgbW9kaWZpZWQgL3Vzci9p
bmNsdWRlL2xpbnV4L3NjaGVkLmggPwoKQW55IGFkdmljZSBhcHByZWNpYXRlZC4KCi0tIApDaHVj
ayBMZXZlcgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
