Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E85AC25B47
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 01:09:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 899C53CF918
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 03:09:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 990613C996B
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 03:09:14 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4E5AF1006090
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 03:09:11 +0200 (CEST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39Q0qp9B007186
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 18:09:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=frGMugXkLXYySvyGW4J5K/ueS9PKDOc5xXHPV76/VtA=; b=
 hFBtM/f9Sf6JlMKl+jMyPA7aiFlySahLi3u36XMVdTs1NOYi1LZzPvLwsC68XzEh
 XEpfZAs5X/zVVLXhtW+4+4fDUq5RfGVJ3YcDQhD6EuO4JueB24I7Gsd6UgB06KNA
 optYhFhgzL1sH69oZWKyBI217SsFaql0GJQAWpNiZX+GSiMrpeGJfX+BB5QVxPfJ
 wQ7tdbQEUle5cLxOskTaVwRL/UIYIGz+3PvOz6iVS+VUjuF+Mq/J1uHn/N/2Pyhv
 dpf0qoO2X9TeHC+AvvioTxZFUjrN/WRxm/dhWg+RxVKPJInJP5dYgViTq4gbUQnQ
 BD3xl09O1A7ZgAWmJ0lEEg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv9x05132-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 18:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDAnJhCAz60B/6zuaWGOPQ0rmoODPBHqBO5GNk+2qUc4VVgcjIIYeU1ljbnjBxxHVKNYmkL1eM2IdCHOmwexJsY0yU2L9VEijjR7xrQ3u7z1FDZUhlmUPCXCjF7OxjNOvLqFN+CzlnQqttAI2Up4nQ9BGLkYfJ+OUHf0L9sMIMyakGDyQAsswhLTpZiP7oA+aNzrF4OpjtHCZV96Kj16Ak8tNeqz9L7WYVK8B0waw8YO3X+PHqkyIdIoZlwsbxyeuyD3I2zOrZUfIdG5M+6WyzMzIuH+x+t3uEjyChKkHc7KR2DpU5FxucB+jv9l5bLHdadRN+F/ofiK3gIL64VjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frGMugXkLXYySvyGW4J5K/ueS9PKDOc5xXHPV76/VtA=;
 b=JlkS8AHCLD1CKNJ6+XUl5WzxVG7p1pTtPrHdulyZAW161VfC/XHvvFFZbve7TjJywzRgxRtFXklZlKzYnLeDybS70p73QtxlBxP3iByhoKUkPuICTtDsEQkouNwTSMw5vdkFE62r/MlQnmy97+Kd9VZDihgiVUX1Road/gwrpEi6MtDKTjh6G1EzgGsVKmXJ2lb6iokFT7cXuYdWfqC15Pv4ol1IDt7Sx4ZiKAGvjSwNBPUVkpS2M557PAOwZdcE1hbQdGBxOMl3PP0gmBEn7qi7MTsw55P4vU4ncAh7sn5j+9sb4n3L/fBef6U3phHm9jdt0aBifDCmPOoUKKp/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 01:09:04 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9f52:2999:c2f5:729e]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9f52:2999:c2f5:729e%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 01:09:04 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP][PATCH v2 1/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
Thread-Index: AQHaAWVWmfygzwJY20aZ8BS8DfWjFrBbTSdw
Date: Thu, 26 Oct 2023 01:09:04 +0000
Message-ID: <CO1PR11MB4979520F15EBFB02E28BD64C95DDA@CO1PR11MB4979.namprd11.prod.outlook.com>
References: <20231018014915.1632280-1-Xin.Wang@windriver.com>
In-Reply-To: <20231018014915.1632280-1-Xin.Wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4979:EE_|DS0PR11MB7765:EE_
x-ms-office365-filtering-correlation-id: 0f891466-3a8c-46bb-379a-08dbd5c025a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 97SDeGRTEY3IOSaEXaAHkvaGE1IYZ93YULuHSlocgvwAATjBxMMyyR1gSyLIUSyTNZTesDe4jhtKRlY/W8vWG9l8DTm4FN1oOhn9mG5A33uEwCm5aku5CsuFZCvQPwxLIu/9J0z+7hOynl+Vuc9LSNsHA1+KrebzZ4Y9bO+wE1pCUiMTKooVFZbUmpIdc6olSIBN1eg4R5nF0CRunp4Cto0wpVvpoBFKvwiaX4CQjz7VE9cCOIvTJUgZMJoO24jjFngSuTNG5Xq1veznfLb1yI6nKINxjVsp1MmF5PJ5+kKgsFULaCmAwmygphkcxfZRzSSPpTS2X2yA6TgedNVTzjHKHBUFDsV/yo8FEp6WJKHHp5PQ1j6MsmIyd5diCzqpw517yBgkw5nHEJNAnmz7pzwuZ3VQt/R63n7uvTmTNmuS3rVKXCt8Y4k5GoR1uFgsF7NAFJRtSQTaeTZecEtkapvB4YO2b6MrzoIo8dQMMDZFxW6lZT6YWhmascieXb/OsScU/VqY1jaw3BsoRVQ/Lkim/3P46li/9rFyKDUToiXcOky2YODbEXUyGLMGsi5DeN2yTUoGTqJElL84oD3i5QV+vtFbEwkZK1OROt7fTtXo9qnV/TZdj1i4HO0K1tax
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(39850400004)(396003)(136003)(376002)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(38070700009)(38100700002)(2906002)(41300700001)(55016003)(52536014)(5660300002)(86362001)(8676002)(8936002)(478600001)(33656002)(6916009)(7696005)(66446008)(66556008)(71200400001)(64756008)(122000001)(76116006)(66476007)(66946007)(6506007)(316002)(83380400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8wWHnLMama2dH1HpC6wZLf7NUhkzDgU3qfI6nkxgzZCp52Vd6NHfiZxwjE70?=
 =?us-ascii?Q?p3BKKS2oPQG3l27lTQWxHUTasrR0qSGb2y5kaPFsljM4rsp9XXif+U33sqbS?=
 =?us-ascii?Q?2K+5E3lFXS4INoIeBMws9SiwxDgycNsuxybetnpxUZQLaR8zJR2ur+azKOak?=
 =?us-ascii?Q?7dUwXt28d+QnoluFdXA9LBETtcO/IgtNVU2fB0sIYKuWqyWMGGLLXzBMQ6Ax?=
 =?us-ascii?Q?uFyb3VDI2Hqgn+DK5iC48Chm/Y7qEocIELlJRQzOv2XxllVWUOdBVzhuMtCu?=
 =?us-ascii?Q?RLxKPFPeAXT0la456zWJEmGsD4w0MmK1qHPxM2IHKq+nbW12m7gC8u+ApsA5?=
 =?us-ascii?Q?l7TnJ6DEriGRenBQOkUZ5M42Ys8iSkqVCCe3gtDjF6ooNB6d8fG1CwmRhOHg?=
 =?us-ascii?Q?txT6QjbKDlkfs8OkxLC0Xg6KNv2LK4rLJIMdxcUt/zMinKUpVAKl6chod9HL?=
 =?us-ascii?Q?qKWMcRcL4awS6fTZRq7OYYHrY5YLGKWSAp4t5/7T1xffg78Zc2MkiQuMqXhM?=
 =?us-ascii?Q?W9AXRGg8hTjATUQk4O6QfR0ev0kKK4IOFUTfbtFaqg26WzX9J+kRvW7Sbbqi?=
 =?us-ascii?Q?a81DAvLzY2H+qDG4YtLwiuky0JuFEShTTUiuzMhRgQNadniLbF7a/NdFZ+Fw?=
 =?us-ascii?Q?5istagqiQ1MgzcitR+ufKqlpzNKDXSNdPy4PIa/3iC+ZGOAturtyWN+M4Yn3?=
 =?us-ascii?Q?cgD4xOK0D/nlH3H2IG4zwj0ZrZxlBz10fjiSw2YPr8K7rK30Hg4yWImJ9kun?=
 =?us-ascii?Q?ZF4MO/soEiWh1zaAnOlhpO9GDCp/ub4kWJjPgpyQuzrOxQA3QnybLgBCRmvX?=
 =?us-ascii?Q?cutTw4B8xHenCZwaRPtQVMkrNhodAQTd1LMFGK9ghr6XrZ1imxGNaXnjG31S?=
 =?us-ascii?Q?Qb+zrwCHphU45EHBMEwdQp4kbfktA1I0xHuvqnHaAXkDiLXvg9CvCom2VDof?=
 =?us-ascii?Q?9EaYArjIhr5xav4pSeeIj0uikXq5UqvdAd41Z1dnyifHkLHgs+ey2zHnXf4A?=
 =?us-ascii?Q?5tlVs/phTXJOcolgKycLsQya0RixqtDgiC4V+jafZMRyjcx6fna0A5lP3p+f?=
 =?us-ascii?Q?PG77dDkUDi8s1by1dkUEwmm9GnSGLSZ0ucfYrvsv9LG934si9gmHBE0uMu/r?=
 =?us-ascii?Q?qm1AIDMEqmxbhoVF6M1etA5tI0R4PDsJJcXneYcfxN/VVMKsKRGhNRxfb2rh?=
 =?us-ascii?Q?TqjsxIIMVEWakNHompScWRp3FNKW88IVDKxgKR8Tp3FvcghGfkxmR3WGM/Zr?=
 =?us-ascii?Q?An/SXX1DqchKguSFOBnwP7VWth6KSwfTOTsrRyCqR1Sa8mlDFUEVvCE8+fY8?=
 =?us-ascii?Q?8qobiHI8nNMrsm1hrNsa0US3Wx8IED6inWeYj1j1Cflhl/P0BBa2zlQrz4jH?=
 =?us-ascii?Q?auFfAYf3WcgtNpRNFyeh3G5uyQ2QSwngIUsPtyAwJWCKWEE1PrU10ULHPMdw?=
 =?us-ascii?Q?ouCoTBx7xUViNxnSqvXttPTtj/JLGM+cAIKLd3432+/jPeCo4kpJ3Y/3LqVj?=
 =?us-ascii?Q?p0siXRNcm7mFIsbBDf7GEDHwWQBvo55pyLolVruY3UOViJlWvl8fN9vBhRXf?=
 =?us-ascii?Q?rctF2RYEqaWMnK+NHwGCINMi+pP9UxPCpnIgGh4K?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f891466-3a8c-46bb-379a-08dbd5c025a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 01:09:04.5057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs43xtfOWXlI/DvtwqgFS7Ah8abUY2N/It3YnCilBpr+K1WdXReTCnFG7jY0HfuxW90tp4gV+dgHs1WgbgwSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-Proofpoint-ORIG-GUID: hDa8iYQSLngg_lNmL6HG_ps2j8hRNGGn
X-Proofpoint-GUID: hDa8iYQSLngg_lNmL6HG_ps2j8hRNGGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310260007
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] enable fsx-linux.c running on VxWorks user
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
From: "Wang, Xin via ltp" <ltp@lists.linux.it>
Reply-To: "Wang, Xin" <Xin.Wang@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,
> Subject: [LTP][PATCH v2 1/1] enable fsx-linux.c running on VxWorks user space
> and add measurement of execution time
> 
> Signed-off-by: Xin Wang <Xin.Wang@windriver.com>
> ---
>  testcases/kernel/fs/fsx-linux/Makefile    |  3 +-
>  testcases/kernel/fs/fsx-linux/fsx-linux.c | 53 ++++++++++++++++++++---
>  2 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/fs/fsx-linux/Makefile b/testcases/kernel/fs/fsx-
> linux/Makefile
> index 956486b8a..8162da3f9 100644
> --- a/testcases/kernel/fs/fsx-linux/Makefile
> +++ b/testcases/kernel/fs/fsx-linux/Makefile
> @@ -31,4 +31,5 @@ WCFLAGS				+= -w
> 
>  INSTALL_TARGETS			:= fsxtest*
> 
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> \ No newline at end of file
> diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-
> linux/fsx-linux.c
> index 64c27a0f5..c1b0964f1 100644
> --- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> @@ -39,8 +39,10 @@
> 
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -#if defined(_UWIN) || defined(__linux__)
> +#if defined(_UWIN) || defined(__linux__) || defined(__VXWORKS__) #if
> +!defined(__VXWORKS__)
>  #include <sys/param.h>
> +#endif
>  #include <limits.h>
>  #include <time.h>
>  #include <string.h>
> @@ -59,6 +61,10 @@
>  #include <unistd.h>
>  #include <stdarg.h>
>  #include <errno.h>
> +#if !defined(__VXWORKS__)
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_timer.h"
> +#endif
> 
>  /*
>   *	A log entry is an operation and a bunch of arguments.
> @@ -87,6 +93,11 @@ int logcount = 0;		/* total ops */
>  #define OP_MAPREAD	5
>  #define OP_MAPWRITE	6
>  #define OP_SKIPPED	7
> +#if defined(__VXWORKS__)
> +#define CLOCK_ID CLOCK_MONOTONIC
> +#else
> +#define CLOCK_ID CLOCK_MONOTONIC_RAW
> +#endif
> 
>  int page_size;
>  int page_mask;
> @@ -128,6 +139,23 @@ int fsxgoodfd = 0;
>  FILE *fsxlogf = NULL;
>  int badoff = -1;
> 
> +#if defined(__VXWORKS__)
> +static inline struct timespec
> +tst_timespec_diff(struct timespec ts1, struct timespec ts2) {
> +	struct timespec res;
> +
> +	if (ts1.tv_nsec < ts2.tv_nsec) {
> +		ts1.tv_nsec += 1000000000;
> +		ts1.tv_sec -= 1;
> +	}
> +	res.tv_sec = ts1.tv_sec - ts2.tv_sec;
> +	res.tv_nsec = ts1.tv_nsec - ts2.tv_nsec;
> +
> +	return res;
> +}
> +#endif
> +
>  void vwarnc(int code,const char *fmt, va_list ap)  {
>  	fprintf(stderr, "fsx: ");
> @@ -849,7 +877,12 @@ void domapwrite(unsigned offset, unsigned size)
>  		gettimeofday(&t, NULL);
>  		prt("       %lu.%06lu memcpy done\n", t.tv_sec, t.tv_usec);
>  	}
> -	if (msync(p, map_size, 0) != 0) {
> +#if defined(__VXWORKS__)
> +	if (msync(p, map_size, MS_SYNC) != 0)
> +#else
> +	if (msync(p, map_size, 0) != 0)
> +#endif
> +	{
>  		prterr("domapwrite: msync");
>  		report_failure(203);
>  	}
> @@ -1115,11 +1148,12 @@ int main(int argc, char **argv)
>  	int i, style, ch;
>  	char *endp;
>  	int dirpath = 0;
> -
> +	struct timespec time_start, time_end, time_diff;
> +
>  	goodfile[0] = 0;
>  	logfile[0] = 0;
> 
> -	page_size = getpagesize();
> +	page_size = (int)sysconf(_SC_PAGESIZE);
>  	page_mask = page_size - 1;
> 
>  	setvbuf(stdout, NULL, _IOLBF, 0);	/* line buffered stdout */
> @@ -1267,9 +1301,12 @@ int main(int argc, char **argv)
>  	signal(SIGUSR1, cleanup);
>  	signal(SIGUSR2, cleanup);
> 
> +#if defined(__VXWORKS__)
> +	srand(seed);
> +#else
>  	initstate(seed, state, 256);
>  	setstate(state);
> -
> +#endif
>  	open_test_files(argv, argc);
> 
>  	strncat(goodfile, dirpath ? basename(fname) : fname, 256); @@ -
> 1336,12 +1373,18 @@ int main(int argc, char **argv)
>  	} else
>  		check_trunc_hack();
> 
> +	clock_gettime(CLOCK_ID, &time_start);
>  	while (numops == -1 || numops--)
>  		test();
> 
>  	close_test_files();
> +	clock_gettime(CLOCK_ID, &time_end);
>  	prt("All operations completed A-OK!\n");
> 
> +	time_diff = tst_timespec_diff(time_end, time_start);
> +	prt("Elapsed Test Time %lu.%09lu\n",
> +        (unsigned long)time_diff.tv_sec, time_diff.tv_nsec);
> +
>  	if (tf_buf)
>  		free(tf_buf);
> 
> --
Could you please review the patch v2?

Regards,
Xin
> 2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
