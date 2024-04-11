Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FF4CD1292
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 05:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712815139; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=HG54d3ToNrv6Ch5DIT8ejWziUov6quTEaIPJxdFyJqc=;
 b=Caa1oKxbEiOhx9ghFMsaDY7vGQij0uMPM3MiQ8Onuc2foNpXEx8Wvz7AMRs1PwuMJITo3
 FMrdetyZJjoRyAG1RCT5DFEd4JlMXzHYm4lnu9HPfwX8XX4YjfYjm/CSZR4aWueQ5/KKvf+
 C9ZdzippldH32+fpxZ4886LqvEV4QLo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A82553CE85C
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 07:58:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0B353C195B
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 07:58:36 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com;
 envelope-from=samasth.norway.ananda@oracle.com; receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CA8E31A02390
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 07:58:34 +0200 (CEST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43B3nEqI016554; Thu, 11 Apr 2024 05:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q+1Y6tl1l9BHXKVGL2PUux0guC7NX9ATkYeqAUpUAR0=;
 b=TvRrRzFyIWUZDu9QBw9KA/q7Me9sPiJSNo6ItPcNXgTnPsX4XxBlP3bXGlBRuK0a25oK
 UFtnR6tAo/M0q3TZlIxHiRX/3ITYhUflDOgpCR+RO+AwfQpK0BnUf+NOhu76F+uLu2Qe
 cEWFicJoHU8eZcLTAmuyUJd7+8LxvVgL0eoVq8MMDrhBEG2x1lnzFAXPQMdOVzxZT4IB
 cc27cBcBvVGfxxYnzhGfnCurSrFwu8xu/A/KQcrs5V2ZV8nWKJ8PZn4d4Oz30+KimIFJ
 Dvq8e50lAnFqPKb+yVqxoV3KlHJs+2xNK56RnOpgr9QBbRhSeL0ICC7AgDfPQYy76ssV oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf8s48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Apr 2024 05:58:32 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43B57Hi4040673; Thu, 11 Apr 2024 05:58:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xavufdcky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Apr 2024 05:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbQq68hEDhxoYUG/7ycrl95lVSchQk+kxGoIKFea96OBKNjynY9qVYh1TxAOMxQG7lyvF97Nw+57tmmkRa+iBbgkf6CoX6K4DE1T471q/P49HX/cWqghITHs/9sBh9inRRJ3rgEXa0fRiYDY3bawlegy4W6dtQeXs2m9xtSE6UPp2LmStd9RAFGVGjpLpOa392BsS4oFF7t9Jvd6zpM6yP9Vih14KIXh0pFszQm4/nA0boqpC7NcePPco+Wx9eNtsRJEfn/5lodBLkWivTladYYKGagZOrfDzr/fNG5t79KC5zN2kS5RlrUmbY+wfUws9cIA5GnEBZkcq18IWN9Ytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+1Y6tl1l9BHXKVGL2PUux0guC7NX9ATkYeqAUpUAR0=;
 b=X0ERNzBHr1sOa57jOf26H3GWm122Bj8uHEAJnm2eJZeC1TalUWwuaU9poKHsDUgndAx5ewPJsofrR14cXhWi0MCPW0Eb9sRnFMYDcduiTgnktOFKhXz8MF+/gj0QIev/PuR0RhHE2cnqqgkAYP+iZDY1IrM6G6jCxhppq8M+y51lf/QIL1Q8iYgouaWRv7/24/WQUC4P41pPCbonxlUfRE5yCs2iucIydEQE4iZexDmOpQQ5B+uXhweztBpVWd62gA8JUJImbcVGrlFwUGgT+BJn4QXNRrBVyUqJQuVHZd7jTwq4FXbeedBSMTe94/oR0uODEPET45o/an0yVBZ5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+1Y6tl1l9BHXKVGL2PUux0guC7NX9ATkYeqAUpUAR0=;
 b=dyrAj82Wj4xuFyjbnuhdbi6mxFuWh8O7Lqppme/HqUihtb+2x+Kzj2c9BMASexWn3GEmJOOvnKm1bqWRYoo3INrfIYFAdSrt8O9wL+9PAiFIpEUptw/fanFa/tDwk2MhWsPROdAMz7tSB3DENl2sxQzFPJ/6ecMu3Baqpn3Xypk=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by BN0PR10MB5206.namprd10.prod.outlook.com (2603:10b6:408:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 05:58:29 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::d1b7:21b3:9974:8ac8]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::d1b7:21b3:9974:8ac8%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 05:58:29 +0000
Message-ID: <678ab00d-008d-4d64-b58a-bc533af61a28@oracle.com>
Date: Wed, 10 Apr 2024 22:58:27 -0700
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
 <Zg_oLGuLcssY-rYY@yuki> <e2368059-647c-4d98-8c90-2cc5f3bb34a4@oracle.com>
 <20240409101753.GA107959@pevik> <ZhZcL9cH5bVDWL_k@yuki>
 <20240410094621.GA184706@pevik> <ZhZlEz8MjZ2KOiR4@yuki>
 <20240410133337.GA205337@pevik>
Content-Language: en-US
In-Reply-To: <20240410133337.GA205337@pevik>
X-ClientProxiedBy: BYAPR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::25) To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|BN0PR10MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 25366ca5-34d0-4ea5-d73a-08dc59ec693d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGS7aagU6UbWIbMwvYvKP8Fq0FBWKs/OdIPe5cl+tH54YElhxpO+gGYvbYBXOfBZ/+BwFgzAFwcmah2QDTmSDsl3wFQgBDHpCfneaG7Gt3huyHcFRnJ2PdCYygKr9rQHmLreqoEB+zp6co8Qnb9GNZTw/VAOvCPUQZBEAiEMAiayqVzLLv3zsG1FYBVwZoNpjaLbYQb5bIe8dQppG7tJIPNX9NwqvUMoQlem1hRcwqTTOGhwmfBgtxQL1Zm2LdrUZrkqVuY6dTQzGhX9zCWwZGh22JWmh5neX6lYILhEoiCv5JNKC37ijYGVWfD90YHSgvHuPQWefY7Witr9xB004KbbrYw64awNAAYQ56ny22eYMcmCTLo/4bYvRsScN/B+GshVxANaq0DedaUipe3hDVZUjE+pjv3efkdST0RWGqO9QI+v6xP9iYZNPnPGyqb3i8hYzkWlqdLfeny+eRFpNzTZErjcNl3Ln1/Dg/QH9XnpLzs5sjOA2NnJQQR+wNzyTqU9SUbzN+qRHthWak/antjo+tiTIgvbzV3JyiFHTlYFBei7fncHNfHTL7jDoAGRvgaUINeXhgZEfBBBdLTj8D4ON4DrrdIIWhVh7THhZ2/DBbNDpdsQR4JunWpwX4b4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB3817.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdtVVJ3VmxyUDQyRUNZN09SSmQ1Ni85SVNMOFMzN0dtcXhWQWNlUlh5N3M4?=
 =?utf-8?B?dGFNd0lOYVdVVFlmRUhZV1RyaTRlLzJuNFVIOHNwYWU0OHlCWUdPQXZ3Rk9a?=
 =?utf-8?B?ZXM0R3FESlNTNnVkQUk5VXRkWGxsZDlGcmZVUlhzRjNOQmtIaDNrUXBpS2ZL?=
 =?utf-8?B?MVZzaTEvMGcvZUV1ejYrSXVUdVVWSW5sMTYzUDFGQThFWkhiWDJ5THVlUlo5?=
 =?utf-8?B?T21tSEtOaXFWUlF4SDQ5MXNxc0wzN3laZUdNdG5mV0MvZ0JDYThFQW5laFo1?=
 =?utf-8?B?c0tMcFBSQTJwSzBmZW50dUdtKzBjTzVsdVNCOGRZSThGNFo2RVRGelVSN2xi?=
 =?utf-8?B?STg2MzBHeVNXRThQc21vek1JL2FzRE5Rc2oxclNHQnlLRVpId2hiVXZpZng5?=
 =?utf-8?B?VU0xVDdQN3JRMVpRNEEwV1pMTlhEK01pRFJpMEd5bkN1ZGd4MG45RjVPcFFJ?=
 =?utf-8?B?RVd2bW9oeE9VMm8wMWVJZk1CcFdSVnZDSWtVY3BSVm5RSXJZeGxCWjczcklo?=
 =?utf-8?B?L3Y3YlpoZ2FsTjNuVk5rTlhBWVBkQmFUVzJ6alA2eDFtMGlnMlhPOFNNUFNw?=
 =?utf-8?B?eGdxNWNCNTBGanVpWEFLM0lPZ0YxSHRCdlZHcFNpTHM4T0JwVEhFeDVKVTVH?=
 =?utf-8?B?bVN2OGd4QTR4YWRzSCtpR3lGS0tReHNFWkdJQThxOVJmWDZyNXdTaVVDaTV2?=
 =?utf-8?B?RVpiQ3RsMGk1bTdidEtRUEFpSDVjb09tLzZoVzJHU2VOc0VHYVJGSjl2cTVN?=
 =?utf-8?B?YUZRU2M0Z1ptc2R0RGlOWUZKRVBpMjI3OTlCUCtkUEI2VzZwV1Avd2hmazZX?=
 =?utf-8?B?MGRoS2tUVXZqYmUvRFQxUHVYWG93ZmlGd1lXSVJvcVgxdGJ6aHZBRk5LTkV1?=
 =?utf-8?B?eE1GQUF5SFNRaGdxYzdrdmdtKzRxVVp1aTdVcTAzb0kxUEo3eEVzU05xNHpI?=
 =?utf-8?B?dFNYbDBQRGZVdC9BVTlFMyt0SVdLNlh0SzlHNVhFYWF4UFNsWGluV3JoYWV2?=
 =?utf-8?B?YUcvd2NGS2h2YnovV1FmWXhPMkxNRTlnZU90M0VUWkl1cTZhUUViMWFzUU5Y?=
 =?utf-8?B?R1FpY3diSFJzNE83NE9jRGR5ZFMrRE9vaE80RVExbjI1bjJGaG5XSzhXUWJx?=
 =?utf-8?B?RlVHYWh5dGRtanFzR3hMMVRlWkY2V3VnY2YvZWcyV2pNY3hsNjNibU5yelJ4?=
 =?utf-8?B?S2w2SVVDblRMOGFPREQ4azRMbUs1SEV0aHY1Wkg5bFlmTjRvL3QxSmNRSW8v?=
 =?utf-8?B?ZkhyZWd5Y3htZUJ2UkJmdi9NVHNtU3h6YUNMZ2JESHc2dGRVUWZWZ0MwMXdL?=
 =?utf-8?B?TCt4aFhJSG91YnhybHZ0a3l6VFByY2NaOW4xWDBadFVJRmhWSnFvMGJ0RlBy?=
 =?utf-8?B?UVRLK1VST21uNlk5ckRMc1kzay85R1FOQytwNVlZTmErRm1jdWN2MndrSmpW?=
 =?utf-8?B?MXgyL3JpbXRJd0hvK0JXK1pPMEJYSFI3bmNRdFFXMW5ISHdHRjNkM1dKK0Y0?=
 =?utf-8?B?L0cwNm83U3A2QzhkMURXVEptdkRySjl2VW1pdDNSU1JBcmJGL3dlM3JwRm5Q?=
 =?utf-8?B?L2g0WHNjcHBhN3lnRjNjenZmU2ZWcWdORFRodHF2YXFyeUU4UHEwWEpVRjho?=
 =?utf-8?B?dUplT0VraU04RjNpYmZnR0ZESWxXamsyU0ZyODdsL1hBdnZjclhETkFvOC9y?=
 =?utf-8?B?RmJYVGpFNTEzZEt5ZW9GMnlrSy9jYnhneERsWkVhVzFKOCtoOXF3OUJCTXJC?=
 =?utf-8?B?eXRpTmovaWhkQ1VCckRYVjBFb0dwUlE3WkIvU0hKSWp1TEQ2WmJnNnREM3I1?=
 =?utf-8?B?aHlpTkZLejZhdFRrTndPUmRRZklJQUN5WkJNQ2FKZyszcEs1OXVTdEhWU1hz?=
 =?utf-8?B?dUptckRCSHZ0dWRGYlRBYitRckdHOHVROHZhVUtHYXhLTitOdlNSNTIzOVpt?=
 =?utf-8?B?aUZmcDN6MVF4QVphS2VVK3djVTZXbVQ2dHpWa2s3S24wZktwQnY4dUwrS082?=
 =?utf-8?B?by9Bd0o4d09ocFJoNUNPWGFmV2h4Z0xqR0FUMmNZdklYanNiWitkeXVVSFBD?=
 =?utf-8?B?anFGL1FnTHNRMWQ1NklUaEhFdTNKTWVKOHFza3V3bDRSY3pVbmZuelkwUHNN?=
 =?utf-8?B?TDM2QmVveUlkbHFsSGlwWlFMUlkycVYrQ25MenllVDF3cXZIRnFzS0RrWG1G?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uR8T8SKTSu6rVcNUKGeBE63IbY7jmma4RRqVBDViN4uHf1uCo7k2iJcRqv2tjNJho2UX3zIB6ZPWbkDDmW0D2xYWLNQ06OBasB/BiOZgzTkea8dUMybYOoKqxUt52hQXBg2RJPODdqF7r2yUHlW73skjFwprOHrTJnNX4MgIaY/YsMPXFbo5oQMrRbHH6GBknzOG/fsVneaQBwqVzIQpWsUdgmoZDvJRx85PNvc7VYxUz+ho4W+ObctKTRfewh1+FCXB42AEbUtqaJ+OBDSpTA1K7JOXKPkhhy3V9LqdQksUX6sy+MlKQiT9az8s6SbWmOGd2mYPTtDBpIqeD2XfWgiGLHVWeJLAHBlEeVWZM2AoDkOdGkEPi33yvCaouILZDfejn9omwGM3Wzu6LhohUpIMSok6ji/NhECmJ8eVpkjurUcnZeq2ztzdTuPVktRVils1DnrTfWupCnsMczOkvvpp9mbIl2pW2mk+AXCFDfEg7A8gL4agqBUAdLLY4sbhyUhSaJlzWkqXRylsuh82xkYJdZBxIYKNeIitla2vBkvavZVAEf93qVjMQMwXyAY2cr+CfnVRjh5NW2fVVyW+IVmpzvC5y9G/MKC87yuCTq0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25366ca5-34d0-4ea5-d73a-08dc59ec693d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 05:58:29.6432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuD3SMWIh6RthIRLzSaByzRxW0rJad7ln0qgBM8k3K1Exhpw7gLWAEvg3gcE1MXn45tls4v8H9snwh1rwfEoyz44ZxCVXKRveTW2YgIaUz0qcEg/D4tXqKGQVnBxLrFX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404110041
X-Proofpoint-GUID: 3t5LrsdfMWNMEyL1TDG2W9Iyo4fV8UOg
X-Proofpoint-ORIG-GUID: 3t5LrsdfMWNMEyL1TDG2W9Iyo4fV8UOg
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
From: Samasth via ltp <ltp@lists.linux.it>
Reply-To: samasth.norway.ananda@oracle.com
Cc: calum.mackay@oracle.com, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 4/10/24 6:33 AM, Petr Vorel wrote:
>> Hi!
>>> The solution would be to at least check for tst_fs_type(".") == TST_NFS_MAGIC.
> 
>> I would go for this at the moment, that is the easiest fix at the
>> moment.
> 
> So you mean we risk we lost fallocate support in NFSv4.2 for the simplicity. OK
> for me.
> 
>>> Perfect solution would IMHO be to check for NFS version (e.g. in /proc/mounts)
>>> and TCONF only on NFSv3.
> 
>> And is nfsv4 enough, wasn't it added in nfsv4.2? Do we need to parse
>> /proc/net/rpc/nfs to figure out if nfs fallocate() is supported?
> 
> Yes. First, I got confused 95d871f03cae ("nfsd: Add ALLOCATE support") [1] which is
> not mentioning NFS version, because it's for nfsd. But looking other commits,
> e.g. 95d871f03cae ("nfsd: Add ALLOCATE support") [2], 624bd5b7b683 ("nfs: Add
> DEALLOCATE support") [3] and the docs from merge commit in 3.19 [4] and
> kernelnewbies [5], it's clear: it's for NFSv4.2.
> 
> BTW is that whole fallocate() support? [4] mentions "NFSv4.2 client support for
> hole punching and preallocation.", commit [3]: "This patch adds support for
> using the NFS v4.2 operation DEALLOCATE to punch holes in a file.", commit
> b0cb9085239a ("nfsd: Add DEALLOCATE support") [6] uses FALLOC_FL_PUNCH_HOLE
> flag. All that IMHO means it's adding just FALLOC_FL_PUNCH_HOLE support into
> NFSv4.2. Thus other (basic) fallocate() might work in all NFS versions, right?
> 
> That would suggest when addin safe_fallocate() we should check for NFS
> (tst_fs_type(".") == TST_NFS_MAGIC) only when FALLOC_FL_PUNCH_HOLE is used.
> (I got from your answer we ignore missing support for older filesystems,
> we can always add the check once somebody reports invalid error).

Thanks for the detailed explanation of the issue. I will send out a v2 
patch which would check the file system using tst_fs_type(".") before 
printing TCONF.

I will also send a patch to update the man page to include the 
information about nfs.

Thanks,
Samasth.
> 
> Kind regards,
> Petr
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95d871f03cae6b49de040265cf88cbe2a16b9f05
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4ac1674f5da420ef17896f0f222c5215ebcde80
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=624bd5b7b683c978c6d5f4e9f6142cfb3470983d
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e20db597b6264de55ea6636fc79b1e4aaa89d129
> [5] https://kernelnewbies.org/Linux_3.19#NFSv4.2_support_for_hole_punching_and_preallocation
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0cb9085239a20b7482ddd4839dd1d5476801dfa

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
