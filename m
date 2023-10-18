Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DAECDB474
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 01:49:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D93B13CEDEC
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 03:49:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD1383C8885
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 03:48:59 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3DBD92009CA
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 03:48:56 +0200 (CEST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39I1GwqE022227
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 18:48:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=PPS06212021; bh=xudh/
 Iy5VgdOReeixX3RHYuES5LvYsdSBUpJUQf3XnY=; b=GnH1U7u6S2ZuSbyCZZFoO
 T5p6JQq//8UIjjXr/o1+LRP1rmnrysGx4NBFn4Z/PvKYR3yCVVQPb7EFv/LnTbzR
 ZutDOEAPOtTdo592JacKo5Z74uZ6omO0Hiwk2ZZp4QFNORrexf/LkIiBzY9oT7z3
 7F4DuJIR1UKZYecNRZqahoHIOJn2oG0+9nQVdj/DXwEn7d5s6fyKsFbcIJtI+VjJ
 r2vhsqOBhNqxNhAIV4ZCu86wMNj+nfRiyybSw9vzMKoSr2tckZGmD//wyP3hI0rs
 aaQBvQuYcMuvbxzZcwa11gnOpyIrfGVUz/LCpKobn0fCLEwratJbqmiAYqaEuEJG
 A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tt147g7ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 18:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SodBwKs0w+lYGOuYWpXpD6o3OHWcQb93VliYSIXKCeeZArqh3hC4upbW+Y+yMMFRk8AeUGlKBu5hgpK4U3ZCBXcAI7IjKs3ar6QM4y4WJo5T9j0QlsZn0UNwaIVBwk/E4LpM4TaBoIQVxLHArGcqEHkzw/8FqnaCHSXhNV7xlbOZCOt9ERdH/gjEuDmzw6vT4bc9sBWY+Dl0XsB0tHLqRkcfCb180n2iLqFPzSPDH4OS54Y6qasa/TDGf16r0O6sNC+ZqA12TVAU2JMKXS/GGYXSzW6YEnzPyraejmwcdHAmwGbAhwYWHYHXNrfka2pyhaOe791YWFUbcfXRK9DM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xudh/Iy5VgdOReeixX3RHYuES5LvYsdSBUpJUQf3XnY=;
 b=LKVzoSzGQ0oWf9x4S2uE4q7YqDn7HqIaVKfo7Uj85rgiHHOPauwcboDRLX988g8XsrOFnoRoLTJFoUsYCHX3gk6F0nJir2g8mYIOC9ap+AR8brRVKHCtshXXCy4cKf4h3uqUe6iX+v383bWuNU2MRU1YQA+LjCZxXG6nVd9DOISl9BhvQ0drFfdZiqa608hdp7GaEhTBdwOdBh9MjOgpf+kAQOMNdxX0xieo/P2K0UHp7ulwWwp+pjOWZXNNZEYruTOtL5ngCReKvGBy+DbrtdJeA4mS7+UU80dR0KxRXlWnIIjIZIYUEYZfbYqq6dMSXjIULvYs7CLa6jNqN9bMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 01:48:50 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 01:48:50 +0000
To: ltp@lists.linux.it
Date: Wed, 18 Oct 2023 09:48:32 +0800
Message-Id: <20231018014832.1632063-1-Xin.Wang@windriver.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|MW3PR11MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a258c7-4ed0-4a3b-0e1a-08dbcf7c6072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJsLd7LRA/JnM4uwHtlKFZed/pivYCta42CZuwsfrLjA1ezeZcK+ARx39l3lXKtxHc6Xuh8S8Chg1aou02lRUOrsmrw5MEcR/083ApxrOV5fQDG0yQ25ngkXn02bygoiNDqrBFnf51UAa0HE3P67QJuWGWdzqUWvHxs4/YGA/preTOhkgkCTTK4c4J1lHyFsW4gPa3uSAySxp3Z63h5FK5JvOb2B8aMlNqK0yg/oQ5Y2j8i3ylqB8QCnWpKprOnkT5weUVj3e3SjSalhPeg0WdSERfYau0eFcCh1St/wadLFl6szlUD36XR7rLz7AMWOy7i3HWOdLg8vEuF1UfTC4UPO1ty3zUjUq+mF0XOf5uAOXBDQ1nD2Z2f1ev4+S+JxQHLNqW7SzI4YFWTmK+Lw2mgZGoon8e0vfjmREoWlzWuhp3BAsO9Sb4RJaLgvU+/3nZGrZkq5HYZNKjxfXpJMMMi8BGIE8iNmPg9Uj6jM/tSXCkqRh8CI3l07EBKoSmL5MIEV7hVUD0eU+yXD6JzGfLvsst/0RVs61puqXf8ZWGCvkPA/5nDBW4y7aykJBtaXk/Y1zc/qmH9RYGvlxlV22yARcn7Ry2iki4a06cGyLN+LDGtY+0iQFA+saB40ByZl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(376002)(136003)(346002)(366004)(39850400004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(52116002)(5660300002)(6666004)(2906002)(107886003)(1076003)(83380400001)(26005)(2616005)(4744005)(38100700002)(86362001)(6512007)(6486002)(508600001)(36756003)(66946007)(66556008)(66476007)(316002)(6916009)(41300700001)(4326008)(38350700005)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?endMVUFUUEhnTk1mK080cEFFQ2NaTURjam9ER1V1SUF4d1EzcHdSYUQ2dk9B?=
 =?utf-8?B?Wjc0Tm1xM1phcUFJcFl5RXdCR1VORERybFMzcDFyWTgyc0txTVVaRWJHUzNU?=
 =?utf-8?B?U1RmQVdySVJ3RGxIQStEMktrMFNpUEQ2dlRSSFo4RTA2MDMySXhLcG0vS2FN?=
 =?utf-8?B?OFliSFh1dnc0R3d4bUtCVmh3THhlWk5RQnlNWDZMcE1BeVN5bjFJOGt1OGJT?=
 =?utf-8?B?dDZmL09MWkp1UkRyS3FBRmc1SzNLVW81V2cybTZ3U2E5U3Q3NmJPRVZZS1dK?=
 =?utf-8?B?dThQUFFIYXZ4VWJ1TFVLQTNodGRHRktoMnpuVzNRc0lVWEkyMHA1WXliYW1K?=
 =?utf-8?B?em5NamxDL0RZbXdpWUw3alpYUXJVdEVOYUIybk5iaWJoQytZMERVbVZiL1FR?=
 =?utf-8?B?MmlQVVJzNTFrNThWa3ZGM2J0Lys1TlY5SmVHYjk2UVJyT3JDUGpreVFpcHR3?=
 =?utf-8?B?R3Qrc3JwSndoenZXbzRPTm9FK1hFM0dma2JOOUpxaGpyQVp6RVdrNXBRWWdz?=
 =?utf-8?B?RjMxVnhVbkFFRTVqV0NJOWliN2tKcDZGWkEwcUNSVW1CR2J4Q0FYc1BhZTZQ?=
 =?utf-8?B?TXZSVWppcFVjbUk2WDdwV3lGWTJQWGZDRkw3N0x4K2pNV3hoNytsS0hNU2tY?=
 =?utf-8?B?WFhCajN3ZU9jZldlYWFVRlRnbTlRRDBITDN5ZlJMVnpQY1pUZ2dQVkkwMUlk?=
 =?utf-8?B?UUtHZC9pMGhWendjckRjWFJrZTRVK1hwdVNXYVFuR3RVUWdnMjVWbG1VV3Vi?=
 =?utf-8?B?MWNvQ1U1Q0tBUEhVL2NVZk4zcTkzOXZXQTFsbEtNSzNJS1BkRHVwc3FtcmNi?=
 =?utf-8?B?Q3lZTTdCKzY1blRwYlZ4RDhFcGxWQytRS3BYZDN4RzlMWVF5dkYwMXBuaytm?=
 =?utf-8?B?b2JSNVI4eWM4akVXdzZ5UEl3RHFaaGoxYk0rV1orVDhVLzB3cVMrUXg4a0dC?=
 =?utf-8?B?ZldRZU9JS2hwZjN1N2pTWi9sYWRkTnAwRTYzUnhmaFI2VEVpVmlNbk5DWDND?=
 =?utf-8?B?Slk4YmJoY2wyMmpGTVFhV3prQWZ3RXBxeHlHY2NvOU5ONUpqZjJFcjEwNXIv?=
 =?utf-8?B?STFSSGxHV21NUnFudjZ2b0FoRGpqOUNwMUx3ZHVQUFYwS3Q1ei8vK0xRSy9n?=
 =?utf-8?B?RzdFQW53MHczZlVzanpsMStmWEF0clQwSjJCN0NveEhhdngxUXo2TEMra0hI?=
 =?utf-8?B?MlpVeTRRSEFGVUJsamdzL05GSEtoT0JKNDFxSzV6dVd2RVpjM0MvZmRTVi8x?=
 =?utf-8?B?RmV0ME5Lei84QTY5OHAvMjEwQSs0cGEzV1N3dkRtQ0VIWktBelNzbXpMZUdt?=
 =?utf-8?B?VDlvRGUvNmFObHBLN0NXL3EzZy81MmhUZ0VHaVRENjd1ZGM3aXJmWTIzK0ox?=
 =?utf-8?B?dldIb2FUQnhBYWpzU0lhTXVBZm9hN2FMQkoybWoxUGd0NjVMTjFVazNvakZo?=
 =?utf-8?B?aTNlOGJIMGxNakl5ajNnbW5ybTlndzZYY04yOWQvV2x3UDkrK3czYXV5WkR5?=
 =?utf-8?B?VFkxOWd3bEVFTWpsNXVjSVhFZWhpeWQ3ODlTTVJMdXJXeHN1Rmh4TmQ2MUxh?=
 =?utf-8?B?Q2NqTXZhV0ZHMlFYYVFvcWxxcXI5TG9XZ1VreG12WHkxMmJDWHhKTEdnUXJJ?=
 =?utf-8?B?aUlOWldLM0xXNk9YUC9GMXJDR3lUUHNDMkVhK044QTZucFg3VWZ3RFI2VVVR?=
 =?utf-8?B?Wldlc0ZCMWVHbWU5Z1gwbWFOZ0k3eGU1Mm85YWFqdEtPZTZsMURrU20xZ21G?=
 =?utf-8?B?MklINlNHeHdkZkhMdWlnbTNlNGdQQy9xS29zSVBuUnk1WmVsaUlmbEN1ZDBE?=
 =?utf-8?B?NnlESHlCL29NYWU3WG9tRkJQWkQza05rMlErb3d0YnBSSmtmRkJ0RzJvTXNB?=
 =?utf-8?B?b3VUV2NhcU1PajRseS9lWDRwak5qa1oxTWwrZThWYmRxcFM5SG9iWmxVWjhJ?=
 =?utf-8?B?QXYyZEpOY3lZODFwOUVTWXVxYlVqKy91M1RpdHNPRlNSWGNLR2ZseHVMZTJu?=
 =?utf-8?B?R0FETmNSKy9xUFFTMVEwUTRpUlhkMUxQeGN4VDZQdkdHWVNqaUNrUXB0T29K?=
 =?utf-8?B?SHAvRlZGbFE4LzRKRDRtNURKeEMyL2JIekpBS0U0aWlrNlNyakFKWmE2MnRo?=
 =?utf-8?Q?ntGJSPkpuKXjZo8BA2VFA5KCU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a258c7-4ed0-4a3b-0e1a-08dbcf7c6072
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 01:48:50.7195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuIHkjDP6CTzSSwSVA2016KNGhvHNUkw2VeeSg/cfE9NLvVkOvs6sSiYGgHQ6rv5tj5afB6YbNzcTQ8qTexgpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-Proofpoint-ORIG-GUID: LJFq8odFedRDbYM3OGWsjTjE8o1L13H7
X-Proofpoint-GUID: LJFq8odFedRDbYM3OGWsjTjE8o1L13H7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=534
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310180014
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
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
From: Xin Wang via ltp <ltp@lists.linux.it>
Reply-To: Xin Wang <Xin.Wang@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCkNvdWxkIEkgcHJvdmlkZSB0aGUgcGF0Y2ggYmVmb3JlIGZzeC1saW51eCByZXdyaXR0ZW4g
c2luY2UgdGhlIHJld3JpdGUgc3RpbGwgbmVlZCBhIGZldyBtb250aHM/IFRoZW4gVnhXb3JrcyB1
c2VycyBjb3VsZCBnZXQgYSBzcGVjaWZpYyB2ZXJzaW9uIG9mIGZzeC1saW51eCBmb3IgdGVzdGlu
Zy4KQWZ0ZXIgZnN4LWxpbnV4LmMgaXMgcmV3cml0dGVuLCBJIHdpbGwgc2VuZCBhIG5ldyBzdXBw
b3J0IHBhdGNoIGZvciBWeFdvcmtzLiBJdCBtYXkgYWxzbyB0YWtlIHNvbWUgdGltZSBiZWNhdXNl
IFZ4V29ya3MgZG9lc27igJl0IHN1cHBvcnQgYnVpbGRpbmcgTFRQIEFQSSBsaWJyYXJ5IG5vdy4K
UGxlYXNlIGNvbnNpZGVyIHRoaXMgd2F5IGFuZCByZXZpZXcgbXkgcGF0Y2guIFRoYW5rcy4KClJl
Z2FyZHMsClhpbgoKWGluIFdhbmcgKDEpOgogIGVuYWJsZSBmc3gtbGludXguYyBydW5uaW5nIG9u
IFZ4V29ya3MgdXNlciBzcGFjZSBhbmQgYWRkIG1lYXN1cmVtZW50CiAgICBvZiBleGVjdXRpb24g
dGltZQoKIHRlc3RjYXNlcy9rZXJuZWwvZnMvZnN4LWxpbnV4L01ha2VmaWxlICAgIHwgIDMgKy0K
IHRlc3RjYXNlcy9rZXJuZWwvZnMvZnN4LWxpbnV4L2ZzeC1saW51eC5jIHwgNTMgKysrKysrKysr
KysrKysrKysrKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkKCi0tIAoyLjM0LjEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
