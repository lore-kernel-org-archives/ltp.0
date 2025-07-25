Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CEAC87FD1
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753444838; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+qHRz7thoaGIw4uwvE8IqjvvqBSXbYCtM0LnnQNIGUw=;
 b=aC7Slcj1n46Qe1HQuSvUio5CRzRBwcg/tB1oNduQaHMAoqOZsvx1wfcpZlNQgfDJ0U1le
 cXgbxP0hlRK/5AnA2GHzkNalaBLTnAXnbgeqjBZG20KKyY/6SX87ZhnbswF+zQKgKTfJdy3
 RT1+onr0FZR2T0GqZ+kb1M6REyFokj0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0658C3CCE90
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 14:00:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 818023C1CEA
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 14:00:17 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0FE820007F
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 14:00:12 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P7fpn8013030;
 Fri, 25 Jul 2025 12:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=rVkY6C3yawLp2owOOXLCuiH+U2mc0eu7BKLMqd+YNs8=; b=
 qlDnnFKP5tJveRuh7dAYqS3Fr0iX/Aa2A6NFsyDNhskPbo2BSJgtMVsXei/C5btl
 lsJ/rX65WqIsP0Br+3dZ76pEsb1F3ebzrb46EWvvXFNz+vbCCen26jCkXKRT6MnS
 LLBeF2R2Ii8favWqJEVocMJBto6k3P0Nv5J8pNJoj2HlsLFMRa5MN72UQGD8Vec7
 V6jybd5XWoGQTeZ6BaHOLrp6Ae2W4SNvf6H0ACJ3KrJENg7r+xhWQvVT2jnV2QGq
 vOho+9CkH3FSNDPsyOhjAexZYhqtsx3WsrgvgGpeCVWZ6ef5jc0cNKxiu0SWEcD1
 YQbxmkS+idKlKZ2cC65seg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wgwt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Jul 2025 12:00:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56PBlAKP031468; Fri, 25 Jul 2025 12:00:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4801tkb4w1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Jul 2025 12:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vid2T5RvA8lg2nOfBqQ6nhyiomFYLjNi9GXqSRaP2QDkQG7/1bhyYEmE3Tx/ewfcrlzRLVGJLjQ/C2bdv7WAP2W3Y2nhPG6LoF22YFtaD7lfvqNeh/HT6WsxZ2dEJAmgTJ8Nixx8ww1McXQjyuK3UPQ8W5MvhmPSuOGuhhFf1We2IjLdnAVstuQ9hlquq/sXSbtGfbORsfC2ipwi1cfbcBMdOsEz7GWxTuFdMgbOFb1kt7FceJW4v/BKTlqkkci+e3P/NmAeq6e4nJUdPfRQ288SMmPyFRndjUP8AgVPl7TKhcpW4FW//HFNUgi/WzS8cPD5hJEOcgj66CDYza77jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVkY6C3yawLp2owOOXLCuiH+U2mc0eu7BKLMqd+YNs8=;
 b=iIKrCY+zFM6Ry12BdKe5rqmDfV0YtNCnokLUTvAVzFU1gedhK3vjN/q1JsmfTpKcdLMHGHO6jBPUK/v1HFY9J91S22QuPqRCQCYpTKfW+AlCaJnznK7OoiQa1I+8o8VhgeVMYjMGFQ1VKX6MB1xVvN1/q8Zqxza4L07Pxk9a2W2O2Bg+NU0xrLjQ5LSC0Wn/wmCXgO6QAnJBBDUwJ7tYwNmNnJbDVcld8of4TIoZD4N/m2zlZu3j0XMkqCqQIVJ/wP2K7pssbnxnkKOSTz/30/4oQ7dwuqm8mJ2Xpz07vSO4rWpl7tQbdPvI6GYi2eJDXHOIMK6s48wIFG1dC1E20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVkY6C3yawLp2owOOXLCuiH+U2mc0eu7BKLMqd+YNs8=;
 b=X8WuweVA3KTZBu+USirot2+C3t16FMAYDck0CfF8FyIS4zUkv4BJHotOpY++WmdDYXix/JoEjIvDB5dhaDZxplkT3+XURUbxYYSEUu7Vyw9YR93jn87tckG6F8m68zhqsYlZRu8Qzi3PFEzwJIj0rt6G1aUa/nGx7geigG2TH08=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SJ2PR10MB7654.namprd10.prod.outlook.com (2603:10b6:a03:53b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 11:59:56 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 11:59:56 +0000
Message-ID: <c5d1eb2b-2697-4413-983c-0650eab389e9@oracle.com>
Date: Fri, 25 Jul 2025 17:29:46 +0530
User-Agent: Mozilla Thunderbird
To: NeilBrown <neil@brown.name>
References: <> <ddaf94dd-30a2-4136-8dff-542b4433308c@oracle.com>
 <175325803891.2234665.5884275341421351947@noble.neil.brown.name>
Content-Language: en-US
In-Reply-To: <175325803891.2234665.5884275341421351947@noble.neil.brown.name>
X-ClientProxiedBy: LO4P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::15) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SJ2PR10MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd24d26-1eaa-4757-47de-08ddcb72c5a5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WC90Q21TMVFFaXBUUnEvNy9OQkd0Rnk3cVhFSU9QMjlxdHBheDd5Tk9jRXAx?=
 =?utf-8?B?TERRNlgwdnlrWVUwS04wOXVoV3hYUmE4Y01zenh5U1FSUysxSDh4aTQvT2dI?=
 =?utf-8?B?M2Nqd2NHQkpsUTV1SUU3UHF5cmQzNEc3d1k4RjJodEF1Y2owcmk0UmpQTkVi?=
 =?utf-8?B?OGV5WXVrQ0k4SmNRd2hZQ3NCZHYvanB1SHM0dUtLc2FaR2liM21GTE15K2Js?=
 =?utf-8?B?cDZxNHFUc01YYmQ1TkJKRndwZGFDVDZxamthMmlUWkJqQkJud2t1dmFVRFlR?=
 =?utf-8?B?T3NHRitHSjNJNFVLTTBnQ0JIVTlETE9PeHpaWmh2Z2VaUTg2MWtFWmo3VFRB?=
 =?utf-8?B?OFNqRTh6eENMMUtocnFlem9xNHpOMEM1M3NhREJocjZDYXUxTjM2SkNVUm9h?=
 =?utf-8?B?NnpRMVJJb29rdFM2eC9zZ1IzYS9tT1lCYlV0eHdwekFIVmUyK0lFZHlEbFNO?=
 =?utf-8?B?dVlIOGxkN3QvbjRsUlRUSkQyQzh5MVFpa2N1TUJXbUdxRUhxdllyQlVQRkNs?=
 =?utf-8?B?aEp2M0EwK0JwVEhzM0R0Tjl6a1YwVXRJNndESXFQQ3c1dDk4dWZXN1hraHFE?=
 =?utf-8?B?WVRNS2dheTREQkFtbWlvLzhpdG44RmV3MjJ1a2hwMW5yMUhyd2xLQ3g0YXdk?=
 =?utf-8?B?SmF6aWxtUFh0UlRab05sRTF6TFgvMnRnRXlZRi84R1BMcTJzK0dnMU1SUFpz?=
 =?utf-8?B?TWttSERjSi92bVo4L0hvRWhZZnllaEUycEFmaXN1Tk1NcjN4UXNCd3RDN1ZW?=
 =?utf-8?B?VVJnNmlUaTA5dEJFVFhHRXBleXY4Q2RHc1djNWEyaCtZVFA1ZnoxcjJ0SG05?=
 =?utf-8?B?YXVnQUVacTdnV0FDUE9Ca3I2QzUxa3QvaUtDWlFVelRCZ0VZYTh1L1VKOWda?=
 =?utf-8?B?cHY1Z2hEQUpqamNlVE9aR1pNVlNLRUFNSHhVd3lSUHRWTzExN05xZnFxelo3?=
 =?utf-8?B?d0NFZDJDd0NOMVFscXBXUHp6ZVIxTEQ4VEM4QUh4Zk1HRjFZNnJDQ1E3ckxR?=
 =?utf-8?B?NmptbGRJV2l0elRXQ1A4bHBkWW4rSHRBLzczNXJGcE5LL0J0UXpiT2o1UHQz?=
 =?utf-8?B?VFhnNU92S3paTDVDSEVvb25mRXFjUmR4eGxRbml0dkx0dmRLbVRGMXJycXVp?=
 =?utf-8?B?dCtYL1E3R3Yxa045YWxseEsydUkxeUR6RDEvcStlSnJKM2ZmWmhjMHVXVzdE?=
 =?utf-8?B?ZFhHUkdaU0UvS29EekYzbGtBZ3Q3eVBpRWM2Tm50YTk1RlMxNmV6NjRDam4x?=
 =?utf-8?B?Z3h3djhHWUpmV3dpVzlyYzgwYkoySXpyak9HT0lKa25vTlR5aENKOXJXVk1u?=
 =?utf-8?B?MWJOcUgzVkZWbnhVVEt3MHE3dlo2SmhYWkNSRis3MXNPejROUTNHVmVyRTI5?=
 =?utf-8?B?MWN3b0ttVVQzRXFPcVpnYmZpNmo1VFUyU2poaDA1RVlwdjZEWnhQaHhLRzc3?=
 =?utf-8?B?M1QrTDI0K0QvT3dBMitQbERMMDRuc2M0WFdLZHFadmpvSlUyZmN6dlo5SFVT?=
 =?utf-8?B?RFExcUt2WlJpSGdhVkFuQjRpUUxhMmZyZ3cram5PazdpTVVaK1BITXRRc2NE?=
 =?utf-8?B?d0VCVmwzbmFGdFJxZjFaemJxZThZRFlTNHByenFmdDZibVZWZ0MwUFp2Wmd6?=
 =?utf-8?B?MG0weTZzMmd3cW1XUjhEbkFabXN2NWR3YU9HdDJtclJxN1hiQkxvdTdhMlVu?=
 =?utf-8?B?djNTOC92K1U2ODYzUjVpamQrTTA5eWYwNjU0VXpqdVBHcTV5RUFKd3dQRDB3?=
 =?utf-8?B?VWFPSVpJTjAyYzJIMEFsNHJ6YmVXbWR1em5yZzhyelZNaDJmOWtwck1Fc3Aw?=
 =?utf-8?B?ZzArK2pnbk9wcG1PczVNTmtMaW9IOHlmbGp0a1hyRVhDMEdQTzZGVFhIMEhz?=
 =?utf-8?B?dGt6ZGx4M2xMa1lidWZWckdWOVg0c2p0VWhEbC84c0dobmQ1bE1OMDI4elBw?=
 =?utf-8?Q?9wxHe5BBEZE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR10MB6165.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWwybnNIS3hRdlkyQUtvcklHdmNYQ25wNmRVanJSTm5xb1Rqb2JZWDlHdXMx?=
 =?utf-8?B?WkkreDV0dlNCQWpYSXFVOVBSa05MY3h6cTFKZnlOR0xGRTRjL2IrdDRPdEsx?=
 =?utf-8?B?THpnSllOZGFSaHdRYldrZHUvNnpqUDgwRnJ2MTZiZnE4WFpDLzM5ZjJCVnQw?=
 =?utf-8?B?R3VuNXBWNGxZN1ZxSHlmZk1YRGYvcUlGZnlwcGlIMW1jMlV5ZTdyWnN0ajRh?=
 =?utf-8?B?V2syaWFzYytjN0QxVUpZellkaWhWRmJWalliZVVjc0FSa3lVUEZRbk9NWlJS?=
 =?utf-8?B?UTltM0dpT3lUM3RGMWlnT0x5em9HUGk5RXFLTTducTJCK2hFdDZUT2J3RDNW?=
 =?utf-8?B?VUdEU1I5dTJaeDZnM2Q1K3ZvVDlrQ1pDRXVUdk11RFZDckx0MFh1eUpVVXRS?=
 =?utf-8?B?eFl4cFNkSWVTUmh0eEVrZFVTMWphb1hHUG5lZ0lBb3BBUmx2MVVxUGR0MkFP?=
 =?utf-8?B?Q2x3WW5wMFJtWlpxKzM2VThRSnAvQWtxQmM1QmtCclZvUWlRQytSUStNWkI4?=
 =?utf-8?B?NDRHR0tmSzEvTXJxNHlLcFc4cEFiY0pPb3Uxc0kzalUrRDdac0ZTS2pQejVG?=
 =?utf-8?B?OHVKQ3BzeExtQ081eXNBRU1EWHp0ZVZqbkhZMjJwRENZQ3hKVHlvalFQcUE4?=
 =?utf-8?B?M0tnczVNaTBYUVhLU09mMk05MXlqektqeVp2R2p3UStqNmpCSVZBSXhQMU9I?=
 =?utf-8?B?ZFlBaUJ2dkliQk5qYTFBMG5MYVlpOXBTQ2svUDg5NU8zWER3a2FYMDJISmpP?=
 =?utf-8?B?dXlwdVB1ZE9VSHkzc2dTR1R4NmNoSXhQcEdGMzZIYnFpbGZlbFlHU2xQRE9I?=
 =?utf-8?B?czZDdkZoaE10TGEzMHFZVnJNMEFUbHZ6bVpJS0p4R3ZkMk5OV0JJQytLZ2Nv?=
 =?utf-8?B?dDd6cFl1dGVudGxrVWZMK1ZERC94SGhxc3c3b2dzY0VLVytRcHdIVm8xYmVD?=
 =?utf-8?B?aE1qTzg5YUhacEwyOFByM0Y5QmJnaFVQTXNzcjc3OEU1MGhLMTRzVnFTdUV0?=
 =?utf-8?B?dXFKemZyYVROdDR4N0N4OURPWWt3a0U5elRvK3MwcDlaMlV1bHcrbUcxVUtt?=
 =?utf-8?B?Tk1wMVZza2pPanBReGR0Z1pUeERtdW56NWdRTUxmemk1dnJOYWlBa01tL3FT?=
 =?utf-8?B?Ny8xbDJSK3RERXlEbGphNWplU0Y4ODhFclkrYVhHSFd1NEJOWmY2aDVRK1Rs?=
 =?utf-8?B?a3RtMXFRcEJ5UytoTDRPTENndjlydEp0TTdPODJZeGh2UGNVMXRzN2JYUytr?=
 =?utf-8?B?aFRrbWdBUVMyTkxtZlpuYmRqaWlyd2g2M09tM2Y4QWpGb21Oa0l6ZGU1bS9T?=
 =?utf-8?B?cmNGWlRpNnJOaUI0a1dPMUg5SWdwZkhUWG5RenhKOTA1bHU4MElNSHZxY2V2?=
 =?utf-8?B?T3UxQnBFZFRJdUZjU3NiR3MxTjRDSHRJQUZVR0x4T0RNNFI4Mm5lM1hwTGJU?=
 =?utf-8?B?NWJVaWRQaEROU05IU1UyRXlrS3Q0MEJWVXpZamxpaHpjTG5CT2VXU0dBUjRQ?=
 =?utf-8?B?MzBEZmlFd2lZMUVkSUltc09FNGRMRmpSYzh3SW1ORHdKWFRTbVNNOElmOWp0?=
 =?utf-8?B?U29IYVhvVDAyUzFVYkdsaVh2YVZtT1RpQ1prYkM3NzJ4akJraFNXVVF0U1lN?=
 =?utf-8?B?dm81VDRGWDNsdFp3VTRvRTBPR1lDVFZ4VDM5QVFVUjRQY0J6dUpTWVBQVWN0?=
 =?utf-8?B?QUV1cXFKR3NUeDMxUTFsTmxhdFRQTVlaNlQxc0djQ1RCZ24xakFTWi9ha3VG?=
 =?utf-8?B?SFRCSEw0Uy8xSjhtTVk0NFQ4Y0ZxdlRiVlkvQ01VL2xEc3A5RlU3ZkR2eGtM?=
 =?utf-8?B?bGE4L2NqSWJoeEMzbVdTUE9xM2VuaS9ranM4YlhyWWFDTk0ybnFTSjZHdFps?=
 =?utf-8?B?ekk4VzNHR2luTnJEMDRnTy8zQjcrNlRiQnIrdmYwaUtkN3h4ZURZOEcxb0pl?=
 =?utf-8?B?aUtmK1VvSEpHQXhuS1hhQlBYU2lUcnROam5ZYUxGbUs3RUNCZ2xRNVlYL1Vp?=
 =?utf-8?B?UGVUVENwWjV6S01zTG8rdnpqTDhKcXBNWVdLdTBXckdXejl1OSs3ZFN5RnFu?=
 =?utf-8?B?bkRmTW9YSk5qTmxRUStNbUZta2lVR0pWeDA5QVFIS3VkSkVOSHpzL3hYMWdk?=
 =?utf-8?B?dGhKNC9zcTNWZm9QcmU2M0t2dzltRXVEMWdYdzJzalF5ZDJTVElpQmx2NTlq?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IpfSEeCQgUp6qFU0VQVuy7BEu5GuiI57hkuTRI+/GCSfVCXx+cXy1bqYvFs5QCwQRQFazLDM/nMG5XnK7ZuFsoaBH/ynFHsDGUc+WuVuKjJBQ/VPnnR21OScU94bX21RrqxQuMO9zGDARIqi/ds81N3MqRbnxpTPJB9ih9K/QUotS+G1pvejuYOZGMii20FLreFR9VsUyezVRyEi/yZoExoS0QVP8UVesC4sdJiVr8ExoB5HEXohJVLgkjx+1ZYTgaPWgAm0yaBOANwP+2sdtrPPTGKdQe6kqDbuFWFh5PnLaa/GAYLvzJ61a/f6WExABU8UrNS5aA3LYQrNXtoRkJ1kfM+rFYdGCoiFsLtCdP0whu7di/D6HRL0NKTPP+toYoBB+r5/5QSyl/IbKUzU985dyizpfD1cYGWkvxReAe6X/nUK2CfEcbw6pTWIrVHnAIgW5ysow3ys+MHLEhnRvXs60f0CH8CVLpHiQJ2QD47DOzV+WVEHj/awfKkyvqIcfVOA1T0LVRYjNUV+Nt/ochsqQZ6AdP/Y9SGnUXq2KiKdIZy829imd1+w2zlv8RTWdMf3EjWP7oouC1RhL8Rb/PgHDqquk2TJ4p/hmDV4fik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd24d26-1eaa-4757-47de-08ddcb72c5a5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:59:56.3180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCGrcjbXWg4cAwrzyt0lOJ1tlOnR6Pr8jHWwhTB7lTeCciMawe8zeBHpFkJMgN7LbVlDwvBtpQImeujAMldbVbbZGepGkiFqXGoRfarnFMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250102
X-Proofpoint-ORIG-GUID: pCwqtwO5gabyJL0cQNu2FOmhC3tTE3qG
X-Proofpoint-GUID: pCwqtwO5gabyJL0cQNu2FOmhC3tTE3qG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEwMSBTYWx0ZWRfX+ZxTUumYkJGE
 x/9AGO9LNifoMwWDomdAUBeXeZzwRUTDhh1QglZSxKbPzO+4/DNy7H1BudO/24jxGKK4YFVHLDu
 DyuGjDxpJWQzx47+gmqRmH4wqEleqRuenIxFw+FT6SVlZHWuQ7xQC5XDLJnqUIALMsk8hoaxFF2
 AKHBn56/t55CFryHnTH454Nj4sVauMSvJtiDQfd722B4QW7VOYj0GtuhQQC3uEdZOuteLqWmRRh
 r+sqvPtlJ/7GbtVEG+rZBcJnPOucgzLX+qBPXBTtsRiowO+mZ3fFrZidbSKIHxR3HO7kOKxrAyr
 2dNCMBdDQfHLry0ldrjy15A+7DmHwkMqRdxZK6U6WltcFUpAgljG5gJejlsAWaLyj+xNqAgi3ZF
 CXhyHsV8HWHQjIiE7Y3pe+moF20lj+aIRjLOE7RxzelcGmnG/92kljODauvVLl6LaVbwo2rI
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=688371c2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8 a=1fT50u9RxeC4elPDTm8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:13600
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
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
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Mark Brown <broonie@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Aishwarya.TCV@arm.com, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
 trondmy@kernel.org, Anna Schumaker <anna@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDIzLzA3LzI1IDE6MzcgUE0sIE5laWxCcm93biB3cm90ZToKPiBPbiBXZWQsIDIzIEp1bCAy
MDI1LCBIYXJzaHZhcmRoYW4gSmhhIHdyb3RlOgo+PiBPbiAwOC8wNC8yNSA0OjAxIFBNLCBNYXJr
IEJyb3duIHdyb3RlOgo+Pj4gT24gRnJpLCBNYXIgMjgsIDIwMjUgYXQgMDE6NDA6NDRQTSAtMDQw
MCwgdHJvbmRteUBrZXJuZWwub3JnIHdyb3RlOgo+Pj4+IEZyb206IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4KPj4+Pgo+Pj4+IE9uY2UgYSB0YXNrIGNh
bGxzIGV4aXRfc2lnbmFscygpIGl0IGNhbiBubyBsb25nZXIgYmUgc2lnbmFsbGVkLiBTbyBkbwo+
Pj4+IG5vdCBhbGxvdyBpdCB0byBkbyBraWxsYWJsZSB3YWl0cy4KPj4+IFdlJ3JlIHNlZWluZyB0
aGUgTFRQIGFjY3QwMiB0ZXN0IGZhaWxpbmcgaW4ga2VybmVscyB3aXRoIHRoaXMgcGF0Y2gKPj4+
IGFwcGxpZWQsIHRlc3Rpbmcgb24gc3lzdGVtcyB3aXRoIE5GUyByb290IGZpbGVzeXN0ZW1zOgo+
Pj4KPj4+IDEwMjcxIDA1OjAzOjA5LjA2NDk5MyAgdHN0X3Rlc3QuYzoxOTAwOiBUSU5GTzogTFRQ
IHZlcnNpb246IDIwMjUwMTMwLTEtZzYwZmU4NGFhZgo+Pj4gMTAyNzIgMDU6MDM6MDkuMDc2NDI1
ICB0c3RfdGVzdC5jOjE5MDQ6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA2LjE1LjAtcmMxICMxIFNN
UCBQUkVFTVBUIFN1biBBcHIgIDYgMjE6MTg6MTQgVVRDIDIwMjUgYWFyY2g2NAo+Pj4gMTAyNzMg
MDU6MDM6MDkuMDc2NzMzICB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwg
Y29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4+PiAxMDI3NCAwNTowMzowOS4wODc4MDMgIHRzdF90
ZXN0LmM6MTcyMjogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBoIDAxbSAzMHMK
Pj4+IDEwMjc1IDA1OjAzOjA5LjA4ODEwNyAgdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNp
bmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+Pj4gMTAyNzYgMDU6MDM6MDkuMDkz
MDk3ICBhY2N0MDIuYzo2MzogVElORk86IENPTkZJR19CU0RfUFJPQ0VTU19BQ0NUX1YzPXkKPj4+
IDEwMjc3IDA1OjAzOjA5LjA5MzQwMCAgYWNjdDAyLmM6MjQwOiBUSU5GTzogVmVyaWZ5aW5nIHVz
aW5nICdzdHJ1Y3QgYWNjdF92MycKPj4+IDEwMjc4IDA1OjAzOjEwLjA1MzUwNCAgPDY+WyAgIDk4
LjA0MzE0M10gUHJvY2VzcyBhY2NvdW50aW5nIHJlc3VtZWQKPj4+IDEwMjc5IDA1OjAzOjEwLjA1
MzkzNSAgPDY+WyAgIDk4LjA0MzE0M10gUHJvY2VzcyBhY2NvdW50aW5nIHJlc3VtZWQKPj4+IDEw
MjgwIDA1OjAzOjEwLjA2NDY1MyAgYWNjdDAyLmM6MTkzOiBUSU5GTzogPT0gZW50cnkgMSA9PQo+
Pj4gMTAyODEgMDU6MDM6MTAuMDY0OTUzICBhY2N0MDIuYzo4NDogVElORk86IGFjX2NvbW0gIT0g
J2FjY3QwMl9oZWxwZXInICgnYWNjdDAyJykKPj4+IDEwMjgyIDA1OjAzOjEwLjA3NjAyOSAgYWNj
dDAyLmM6MTMzOiBUSU5GTzogYWNfZXhpdGNvZGUgIT0gMzI3NjggKDApCj4+PiAxMDI4MyAwNTow
MzoxMC4wNzYzMzEgIGFjY3QwMi5jOjE0MTogVElORk86IGFjX3BwaWQgIT0gMjQ2NiAoMjQ2MSkK
PiBJdCBzZWVtcyB0aGF0IHRoZSBhY2N0MDIgcHJvY2VzcyBnb3QgbG9nZ2VkLi4KPiBNYXliZSB0
aGUgdmZvcmsgYXR0ZW1wdCAodHJ5aW5nIHRvIHJ1biBhY2N0MDJfaGVscGVyKSBnb3QgaGFsZiB3
YXkgYW4KPiBhYm9ydGVkLgo+IEl0IGdvdCBmYXIgZW5vdWdoIHRoYXQgYWNjb3VudGluZyBnb3Qg
aW50ZXJlc3RlZC4KPiBJdCBkaWRuJ3QgZ2V0IGZhciBlbm91Z2ggdG8gdXBkYXRlIHRoZSBwcGlk
Lgo+IEknZCBiZSBzdXJwcmlzZWQgaWYgdGhhdCB3ZXJlIGV2ZW4gcG9zc2libGUuLi4uCj4KPiBJ
ZiB5b3Ugd291bGQgbGlrZSB0byBoZWxwIGRlYnVnIHRoaXMsIGNoYW5naW5nIHRoZQo+Cj4gKyAg
ICAgICBpZiAodW5saWtlbHkoY3VycmVudC0+ZmxhZ3MgJiBQRl9FWElUSU5HKSkKPgo+IHRvCj4K
PiArICAgICAgIGlmICh1bmxpa2VseShXQVJOX09OKGN1cnJlbnQtPmZsYWdzICYgUEZfRVhJVElO
RykpKQo+Cj4gd291bGQgcHJvdmlkZSBzdGFjayB0cmFjZXMgc28gd2UgY2FuIHdlZSB3aGVyZSAt
RUlOVFIgaXMgYWN0dWFsbHkgYmVpbmcKPiByZXR1cm5lZC4gIFRoYXQgc2hvdWxkIHByb3ZpZGUg
c29tZSBoaW50cy4KPgo+IE5laWxCcm93bgoKSGkgTmVpbCwKClVwb24gdGhpcyBhZGRpdGlvbiBJ
IGdvdCB0aGlzIGluIHRoZSBsb2dzCgo8PDx0ZXN0X3N0YXJ0Pj4+CnRhZz1hY2N0MDIgc3RpbWU9
MTc1MzQ0NDE3MgpjbWRsaW5lPSJhY2N0MDIiCmNvbnRhY3RzPSIiCmFuYWx5c2lzPWV4aXQKPDw8
dGVzdF9vdXRwdXQ+Pj4KdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNv
bmZpZwonL2xpYi9tb2R1bGVzLzYuMTUuOC0xLmJ1ZzM4MjI3OTcwLmVsOS5yYzIueDg2XzY0L2Nv
bmZpZycKdHN0X3RtcGRpci5jOjMxNjogVElORk86IFVzaW5nIC90bXBkaXIvbHRwLXcxb3pLS2xK
Nm4vTFRQX2FjYzRSUmZMaCBhcwp0bXBkaXIgKG5mcyBmaWxlc3lzdGVtKQp0c3RfdGVzdC5jOjIw
MDQ6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTA1MzAtMTA1LWdkYTczZTE1MjcKdHN0X3Rlc3Qu
YzoyMDA3OiBUSU5GTzogVGVzdGVkIGtlcm5lbDoKNi4xNS44LTEuYnVnMzgyMjc5NzAuZWw5LnJj
Mi54ODZfNjQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBGcmkgSnVsIDI1CjAyOjAzOjA0IFBEVCAy
MDI1IHg4Nl82NAp0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmln
CicvbGliL21vZHVsZXMvNi4xNS44LTEuYnVnMzgyMjc5NzAuZWw5LnJjMi54ODZfNjQvY29uZmln
Jwp0c3RfdGVzdC5jOjE4MjU6IFRJTkZPOiBPdmVyYWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAw
MG0gMzBzCnRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25maWcKJy9s
aWIvbW9kdWxlcy82LjE1LjgtMS5idWczODIyNzk3MC5lbDkucmMyLng4Nl82NC9jb25maWcnCmFj
Y3QwMi5jOjYxOiBUSU5GTzogQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1RfVjM9eQphY2N0MDIuYzoy
Mzg6IFRJTkZPOiBWZXJpZnlpbmcgdXNpbmcgJ3N0cnVjdCBhY2N0X3YzJwphY2N0MDIuYzoxOTE6
IFRJTkZPOiA9PSBlbnRyeSAxID09CmFjY3QwMi5jOjgyOiBUSU5GTzogYWNfY29tbSAhPSAnYWNj
dDAyX2hlbHBlcicgKCdhY2N0MDInKQphY2N0MDIuYzoxMzE6IFRJTkZPOiBhY19leGl0Y29kZSAh
PSAzMjc2OCAoMCkKYWNjdDAyLmM6MTM5OiBUSU5GTzogYWNfcHBpZCAhPSA4ODkyOSAoODg5Mjgp
CmFjY3QwMi5jOjE4MTogVEZBSUw6IGVuZCBvZiBmaWxlIHJlYWNoZWQKCkhJTlQ6IFlvdSBfTUFZ
XyBiZSBtaXNzaW5nIGtlcm5lbCBmaXhlczoKCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTRkOTU3MDE1
OGI2MjYKClN1bW1hcnk6CnBhc3NlZMKgIMKgMApmYWlsZWTCoCDCoDEKYnJva2VuwqAgwqAwCnNr
aXBwZWTCoCAwCndhcm5pbmdzIDAKaW5jcmVtZW50aW5nIHN0b3AKPDw8ZXhlY3V0aW9uX3N0YXR1
cz4+Pgppbml0aWF0aW9uX3N0YXR1cz0ib2siCmR1cmF0aW9uPTEgdGVybWluYXRpb25fdHlwZT1l
eGl0ZWQgdGVybWluYXRpb25faWQ9MSBjb3JlZmlsZT1ubwpjdXRpbWU9MCBjc3RpbWU9MjAKCjw8
PHRlc3RfZW5kPj4+CgoKVGhhbmtzICYgUmVnYXJkcywKCkhhcnNodmFyZGhhbgoKPgo+Pj4gMTAy
ODQgMDU6MDM6MTAuMDc2NTcyICBhY2N0MDIuYzoxODM6IFRGQUlMOiBlbmQgb2YgZmlsZSByZWFj
aGVkCj4+PiAxMDI4NSAwNTowMzoxMC4wNzY3OTAgIAo+Pj4gMTAyODYgMDU6MDM6MTAuMDg3NDM5
ICBISU5UOiBZb3UgX01BWV8gYmUgbWlzc2luZyBrZXJuZWwgZml4ZXM6Cj4+PiAxMDI4NyAwNTow
MzoxMC4wODc3NDEgIAo+Pj4gMTAyODggMDU6MDM6MTAuMDg3OTc5ICBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0
Lz9pZD00ZDk1NzAxNThiNjI2Cj4+PiAxMDI4OSAwNTowMzoxMC4wODgyMDEgIAo+Pj4gMTAyOTAg
MDU6MDM6MTAuMDg4NDE0ICBTdW1tYXJ5Ogo+Pj4gMTAyOTEgMDU6MDM6MTAuMDg4NjE4ICBwYXNz
ZWQgICAwCj4+PiAxMDI5MiAwNTowMzoxMC4wOTg4NTIgIGZhaWxlZCAgIDEKPj4+IDEwMjkzIDA1
OjAzOjEwLjA5OTIxMiAgYnJva2VuICAgMAo+Pj4gMTAyOTQgMDU6MDM6MTAuMDk5NDU0ICBza2lw
cGVkICAwCj4+PiAxMDI5NSAwNTowMzoxMC4wOTk2NzUgIHdhcm5pbmdzIDAKPj4+Cj4+PiBJIHJh
biBhIGJpc2VjdCB3aGljaCB6ZXJvZWQgaW4gb24gdGhpcyBjb21taXQgKGxvZyBiZWxvdyksIEkg
ZGlkbid0IGxvb2sKPj4+IGludG8gaXQgcHJvcGVybHkgYnV0IHRoZSB0ZXN0IGRvZXMgc3RhcnQg
YW5kIGV4aXQgYSB0ZXN0IHByb2dyYW0gdG8KPj4+IHZlcmlmeSB0aGF0IGFjY291bnRpbmcgcmVj
b3JkcyBnZXQgY3JlYXRlZCBwcm9wZXJseSB3aGljaCBkb2VzIGxvb2sKPj4+IHJlbGV2YW50Lgo+
PiBIaSB0aGVyZSwKPj4gSSBmYWNlZCB0aGUgc2FtZSBpc3N1ZSBhbmQgcmV2ZXJ0aW5nIHRoaXMg
cGF0Y2ggZml4ZWQgdGhlIGlzc3VlLgo+PiBJcyB0aGlzIGFuIGlzc3VlIGludHJvZHVjZWQgYnkg
dGhpcyBwYXRjaCBvciBpdCdzIGR1ZSB0byB0aGUgbHRwCj4+IHRlc3RjYXNlIGJlaW5nIG91dGRh
dGVkPwo+Pgo+PiBUaGFua3MgJiBSZWdhcmRzLAo+PiBIYXJzaHZhcmRoYW4KPj4KPj4+IGdpdCBi
aXNlY3Qgc3RhcnQKPj4+ICMgc3RhdHVzOiB3YWl0aW5nIGZvciBib3RoIGdvb2QgYW5kIGJhZCBj
b21taXRzCj4+PiAjIGJhZDogWzBhZjJmNmJlMWI0MjgxMzg1YjYxOGNiODZhZDk0NmVkZWQwODlh
YzhdIExpbnV4IDYuMTUtcmMxCj4+PiBnaXQgYmlzZWN0IGJhZCAwYWYyZjZiZTFiNDI4MTM4NWI2
MThjYjg2YWQ5NDZlZGVkMDg5YWM4Cj4+PiAjIHN0YXR1czogd2FpdGluZyBmb3IgZ29vZCBjb21t
aXQocyksIGJhZCBjb21taXQga25vd24KPj4+ICMgZ29vZDogWzM4ZmVjMTBlYjYwZDY4N2UzMGM4
YzZiNTQyMGQ4NmU4MTQ5Zjc1NTddIExpbnV4IDYuMTQKPj4+IGdpdCBiaXNlY3QgZ29vZCAzOGZl
YzEwZWI2MGQ2ODdlMzBjOGM2YjU0MjBkODZlODE0OWY3NTU3Cj4+PiAjIGdvb2Q6IFtmZDcxZGVm
NmQ5YWJjNWFlMzYyZmI5OTk1ZDQ2MDQ5YjdiMGVkMzkxXSBNZXJnZSB0YWcgJ2Zvci02LjE1LXRh
Zycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2tkYXZl
L2xpbnV4Cj4+PiBnaXQgYmlzZWN0IGdvb2QgZmQ3MWRlZjZkOWFiYzVhZTM2MmZiOTk5NWQ0NjA0
OWI3YjBlZDM5MQo+Pj4gIyBnb29kOiBbOTNkNTIyODg2NzllMjlhYWE0NGE2ZjEyZDVhMDJlOGE5
MGU3NDJjNV0gTWVyZ2UgdGFnICdiYWNrbGlnaHQtbmV4dC02LjE1JyBvZiBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGVlL2JhY2tsaWdodAo+Pj4gZ2l0IGJp
c2VjdCBnb29kIDkzZDUyMjg4Njc5ZTI5YWFhNDRhNmYxMmQ1YTAyZThhOTBlNzQyYzUKPj4+ICMg
Z29vZDogWzJjZDU3NjlmYjBiNzhiOGVmNTgzYWI0YzAwMTVjMmM0OGQ1MjVkYWNdIE1lcmdlIHRh
ZyAnZHJpdmVyLWNvcmUtNi4xNS1yYzEnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9ncmVna2gvZHJpdmVyLWNvcmUKPj4+IGdpdCBiaXNlY3QgZ29vZCAy
Y2Q1NzY5ZmIwYjc4YjhlZjU4M2FiNGMwMDE1YzJjNDhkNTI1ZGFjCj4+PiAjIGJhZDogWzI1NzU3
OTg0ZDc3ZGE3MzE5MjJiZWQ1MDAxNDMxNjczYjZkYWY1YWNdIE1lcmdlIHRhZyAnc3RhZ2luZy02
LjE1LXJjMScgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L2dyZWdraC9zdGFnaW5nCj4+PiBnaXQgYmlzZWN0IGJhZCAyNTc1Nzk4NGQ3N2RhNzMxOTIyYmVk
NTAwMTQzMTY3M2I2ZGFmNWFjCj4+PiAjIGdvb2Q6IFsyOGExYjA1Njc4ZjRlODhkZTkwYjA5ODdi
MDZlMTNjNDU0YWQ5YmQ2XSBNZXJnZSB0YWcgJ2kyYy1mb3ItNi4xNS1yYzEnIG9mIGdpdDovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC93c2EvbGludXgKPj4+IGdpdCBi
aXNlY3QgZ29vZCAyOGExYjA1Njc4ZjRlODhkZTkwYjA5ODdiMDZlMTNjNDU0YWQ5YmQ2Cj4+PiAj
IGdvb2Q6IFs5MmI3MWJlZmMzNDk1ODdkNThmZGJiZTZjZGQ2OGZiNjdmNDkzM2E4XSBNZXJnZSB0
YWcgJ29ianRvb2wtdXJnZW50LTIwMjUtMDQtMDEnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC90aXAvdGlwCj4+PiBnaXQgYmlzZWN0IGdvb2QgOTJiNzFi
ZWZjMzQ5NTg3ZDU4ZmRiYmU2Y2RkNjhmYjY3ZjQ5MzNhOAo+Pj4gIyBnb29kOiBbNWUxN2I1Yzcx
NzI5ZDhjZTkzNmM4M2E1NzllZDQ1ZjY1ZWZjYjQ1Nl0gTWVyZ2UgdGFnICdmdXNlLXVwZGF0ZS02
LjE1JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXN6
ZXJlZGkvZnVzZQo+Pj4gZ2l0IGJpc2VjdCBnb29kIDVlMTdiNWM3MTcyOWQ4Y2U5MzZjODNhNTc5
ZWQ0NWY2NWVmY2I0NTYKPj4+ICMgZ29vZDogWzM0NGE1MGIwZjRlZWNjMTYwYzYxZDc4MGY1M2Qy
Zjc1NTg2MDE2Y2VdIHN0YWdpbmc6IGdwaWI6IGxwdm9fdXNiX2dwaWI6IHN0cnVjdCBncGliX2Jv
YXJkCj4+PiBnaXQgYmlzZWN0IGdvb2QgMzQ0YTUwYjBmNGVlY2MxNjBjNjFkNzgwZjUzZDJmNzU1
ODYwMTZjZQo+Pj4gIyBiYWQ6IFs5ZThmMzI0YmQ0NGMxZmUwMjZiNTgyYjc1MjEzZGU0ZWNjZmEx
MTYzXSBORlN2NDogQ2hlY2sgZm9yIGRlbGVnYXRpb24gdmFsaWRpdHkgaW4gbmZzX3N0YXJ0X2Rl
bGVnYXRpb25fcmV0dXJuX2xvY2tlZCgpCj4+PiBnaXQgYmlzZWN0IGJhZCA5ZThmMzI0YmQ0NGMx
ZmUwMjZiNTgyYjc1MjEzZGU0ZWNjZmExMTYzCj4+PiAjIGdvb2Q6IFtkZjIxMGQ5YjA5NTFkNzE0
YzE2NjhjNTExY2E1YzhmZjM4Y2Y2OTE2XSBzdW5ycGM6IEFkZCBhIHN5c2ZzIGZpbGUgZm9yIGFk
ZGluZyBhIG5ldyB4cHJ0Cj4+PiBnaXQgYmlzZWN0IGdvb2QgZGYyMTBkOWIwOTUxZDcxNGMxNjY4
YzUxMWNhNWM4ZmYzOGNmNjkxNgo+Pj4gIyBnb29kOiBbYmY5YmUzNzNiODMwYTNlNDgxMTdkYTVk
ODliYjYxNDVhNTc1Zjg4MF0gU1VOUlBDOiBycGNfY2xudF9zZXRfdHJhbnNwb3J0KCkgbXVzdCBu
b3QgY2hhbmdlIHRoZSBhdXRvYmluZCBzZXR0aW5nCj4+PiBnaXQgYmlzZWN0IGdvb2QgYmY5YmUz
NzNiODMwYTNlNDgxMTdkYTVkODliYjYxNDVhNTc1Zjg4MAo+Pj4gIyBnb29kOiBbYzgxZDViY2I3
YjM4YWIwMzIyYWVhOTMxNTJjMDkxNDUxYjgyZDNmM10gTkZTdjQ6IGNscC0+Y2xfY29uc19zdGF0
ZSA8IDAgc2lnbmlmaWVzIGFuIGludmFsaWQgbmZzX2NsaWVudAo+Pj4gZ2l0IGJpc2VjdCBnb29k
IGM4MWQ1YmNiN2IzOGFiMDMyMmFlYTkzMTUyYzA5MTQ1MWI4MmQzZjMKPj4+ICMgYmFkOiBbMTRl
NDFiMTZlOGNiNjc3YmI0NDBkY2EyZWRiYThiMDQxNjQ2Yzc0Ml0gU1VOUlBDOiBEb24ndCBhbGxv
dyB3YWl0aW5nIGZvciBleGl0aW5nIHRhc2tzCj4+PiBnaXQgYmlzZWN0IGJhZCAxNGU0MWIxNmU4
Y2I2NzdiYjQ0MGRjYTJlZGJhOGIwNDE2NDZjNzQyCj4+PiAjIGdvb2Q6IFswYWY1ZmI1ZWQzZDJm
ZDllMTEwYzYxMTIyNzFmMDIyYjc0NGE4NDlhXSBORlN2NDogVHJlYXQgRU5FVFVOUkVBQ0ggZXJy
b3JzIGFzIGZhdGFsIGZvciBzdGF0ZSByZWNvdmVyeQo+Pj4gZ2l0IGJpc2VjdCBnb29kIDBhZjVm
YjVlZDNkMmZkOWUxMTBjNjExMjI3MWYwMjJiNzQ0YTg0OWEKPj4+ICMgZmlyc3QgYmFkIGNvbW1p
dDogWzE0ZTQxYjE2ZThjYjY3N2JiNDQwZGNhMmVkYmE4YjA0MTY0NmM3NDJdIFNVTlJQQzogRG9u
J3QgYWxsb3cgd2FpdGluZyBmb3IgZXhpdGluZyB0YXNrcwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
