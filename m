Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2489C433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 01:37:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38B0D3C97DB
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 02:37:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E1BD3C72A7
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 02:37:33 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B611F1400E56
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 02:37:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1648085851; x=1679621851;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KGMSiv7bLeYJLP5Rcp4H5Qw5Q2kMb2MSf0+yrAIPnv0=;
 b=e8GLTf+0wi+VTlXl1wrP7Vh3PjqQtkXkewKQpStr+rhFBlwRow0jtPr9
 4SmdwsYqHVogupfn3XRYX1AIM5rR3cPqltRriZDj96YPn65z1i2W8E/nL
 hG7wC2YFM2ZQTxySBlN0EqiUdLQcIDyGisRbKD7KiVbPxrEDlbbIDYfaX
 Zq1xm+du2+FmBrHusBBBogpTmz7FPh6DGUTau3u53ayGJFcWTs8LT53t0
 aYYLMdOPVZd6fUgcrquOB7i4cRVw7epwrwG1IegYM6UuBotQB63cAsHBO
 T5y5hQp5BrMeKOQMKIqluzlayibT75crpMchKiyfXJPgtl50nIWiI+ksF Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="60454211"
X-IronPort-AV: E=Sophos;i="5.90,205,1643641200"; d="scan'208";a="60454211"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2022 10:37:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EE2+xFDLi05MEh8rlX4G+yMDS+xjeSwgtayi+2VzoIlfhRJTDyoJTVOTlC9XVtdP0j3G2gOGJ9btlqXNS7QAdzu7+qipZwdEQyU43587P62kaV5/eesFHt79/5Ffim5uiKstRpDWNRDh5HJw9IpDM/WIhc+mreXg2nNNnmcpgHBfYCojxZUdoqOnIkZqxq+h7JiqiVpeBvT2+z4UJnCz5YuDK1viVa70qh8yTUt1B9MqtC5mCFZKqauh1hK7JGPWo+awBa8RxoVAZ8vRu7fy++lid9krfV26LUOlsvaoNrVtSVxIMWux5BM7QJVRD1WnLGiKacz8ZJXKdfSpsy4SPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGMSiv7bLeYJLP5Rcp4H5Qw5Q2kMb2MSf0+yrAIPnv0=;
 b=P3X7IMc0tWqy8GpgzydVJOR3WyeOi0vYkqPgzRkoHXHbI/Y8k+/CGQKmarRAS59pQvWNFUpXTPd5epLPBsoS6hx+sopS1drj8V0KnL7aaYfz0QX+wXvsZne49MsSM0oBTZqk3fjqir7rT0RoXMZ1XLojake3GchAAu1lS8swFu93LYZ1bankGx7XBRd/8nVEBrSvt7Fm+R5xHVjjLthBg2fhmzb+6JfCzrTwqE4O389g4z5GMG2jLXnpzVWCOvDGG/H/FGV5QoPCeu4qTyh8orZ9TMlQgDMihfVs1qjA/0tkg4aVVfuVnWmnNgOrXKc5+LI5/Y5LXhunKUUfF1NGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGMSiv7bLeYJLP5Rcp4H5Qw5Q2kMb2MSf0+yrAIPnv0=;
 b=bZUhb751lZc/WcXgVzxEuTr1Ljak10zZoMIkQ9XCk49CKVU06aIwEfaXQOuqfJYBhQWvNQ8P8+9wjS/sV/b3BtWhqh43gC316jV8PrqGjQ0yofZt765UWoCpodPGOyYVEHtPFM72HbzXxhFmpyRnnYrDvlu+cdoGZKvNEwMB+R0=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS0PR01MB5890.jpnprd01.prod.outlook.com (2603:1096:604:b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 01:37:26 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.017; Thu, 24 Mar 2022
 01:37:25 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [PATCH v3 3/3] syscalls/umount2: Convert to new API and use
 SAFE_ACCESS
Thread-Index: AQHYOpVTKvCDyN9T20qreqbhEtmWYazNyoeA
Date: Thu, 24 Mar 2022 01:37:25 +0000
Message-ID: <623BCB8F.8070105@fujitsu.com>
References: <623414B7.6060004@fujitsu.com>
 <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
 <1647629747-13405-3-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1647629747-13405-3-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7fc42f0-91d7-4b54-e6b0-08da0d36d9cc
x-ms-traffictypediagnostic: OS0PR01MB5890:EE_
x-microsoft-antispam-prvs: <OS0PR01MB5890718617F78060CE1C33B6FD199@OS0PR01MB5890.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYZjINms3uozdRSAVyt2U23sxLnqYPVtqJuNgAYEjMUI6Mx0EnPcD2+3SHVdYUNxTEPct8K6AO/vt/2m5n42MDXuVTTX/5hm4PIubvNzmp0IDjdV/ndu3qPXFh4hxBWyEr18ZPqECHgAAi5rN3wwl9BaM8ZXYaXZZFxiCYQNHTA815ExRCM81mPgD7IlPHfSbOgjD6Zby5fW8bhkE4ziItNr4lvxBtmdwyV76EgD0tH4y4m4LI0HFszZ7B2deiaI22VNPfHvm7wyHEmZFsxMEKUPegNBTfBo1G/D7Bkuyz2I+tzB8GucIwYT1uDzFfKFlQiiSWKYvqHsthaY+/35+Efb0g2Y22+KtQXrGgNvk8zokrrgWnbLIMtFlO7B6XCkzlEBW2y3SPlOP2UKtAiVuGoLGgYoFSOvqvPFj+0iirenEoYhDbwI2JSfOASLYEZyK18Bbhg/iAW+AY/sIECy50WfqcO0IlXuevVAtLh39Y0ou717GJAXNSH1bKitjR6k906kMusAWTpLPttvcrmZgXNvTPU0EkYrLN3e3C4i0eV5tRk/jxp7hDJyhzjhQ6g6R+FagT4dnGY9ylOU48V4uf1Akye9hDXytfbZ1eU68bCOLCSkbkVVfXkNiJHIsX1DLn6fJlSafmWhTBMlR/s7I7fxCqkK1uBYrLFJlO6uGFygqu3EYqJBOjSgoXTVEiZGA+LfRld4ZFuqmd7R1TfWVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(37006003)(38070700005)(122000001)(91956017)(6636002)(82960400001)(8936002)(316002)(83380400001)(66556008)(33656002)(4326008)(8676002)(6862004)(66446008)(66476007)(38100700002)(2616005)(186003)(26005)(6486002)(6506007)(86362001)(6512007)(71200400001)(5660300002)(508600001)(66946007)(76116006)(2906002)(85182001)(36756003)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MVBMVEZEbFJRbVRDOU9zWUduWDJtVHluRXVWU0Q0c2ZVeUhHUE1GYTBPRUU1?=
 =?gb2312?B?YXNsZXBMckd2aHgrRWs2WmlYNjRLNzRtanFzbnRRU0pXbDBucjVlZTA3RVE1?=
 =?gb2312?B?UjdBT28wZ1gxQ29TMCt4dGxDWGVmaW1abVFyQkR0ajlBak5ITWs4VkJyeGNF?=
 =?gb2312?B?WjBXL0VvY2lDaXVLRmV3SGduN3Y3QmhnT3Zvb0RROU9uMFBYYndReDd3aXo1?=
 =?gb2312?B?alhjVEJIcUJnQlJ1dG45ZTFyTkVnSUp5TE1BdUxlcUJvUXpYa21zOTNzb3dK?=
 =?gb2312?B?ZmcyZ3BBdkNGcFlHQWcrSXBLMHlIZm9ocWJDbmxEL3lZaHlBdVZxYTlnOXkr?=
 =?gb2312?B?SE9lR0s0MGphMGlQLzRvb1NXL1BRNkV1NW9sV3B5bEZpUXk5S2FQT21PT3oy?=
 =?gb2312?B?TTBLVXFzYTU2ek1NTDJzNlAxaHJ1SGRrNGlLQVFxR0k1TFM0emViaVBOeDJL?=
 =?gb2312?B?M2lLTHFQL0dHSCttQ1RGUjNGeHlaVjhia3A1UFZuTVRsTmRnVTM5S3I0M004?=
 =?gb2312?B?Q2RFbzJrSjRZMkdMYm05MlEwcnBsTGw0TmYwcFg0RzB5azgvZ0VLRWk3S1hp?=
 =?gb2312?B?ZTdPbWNZeFNNbVlIVmc5YU4rVFdFVjFCdEJpWXlqZG0yZDRiTFlEaG5EeGNY?=
 =?gb2312?B?TUhCd1dGTnRUVnkvSVhyKzVwdk90VHRkYnpuOU1QOG5GRGVPZGxpcklCdDN5?=
 =?gb2312?B?L0s3L2p5Zyt6QTBEazhtUXpUanloV2g5MnpNWWtiak5xVm9CeTE1aURPVUdV?=
 =?gb2312?B?dldhMkw5QzFOMUxxb3lWRTNaVERZaG5SQkYwWlI2cWNORzdieCtoZEF1STQv?=
 =?gb2312?B?cDBtWS9abG1zMys2alBybkpMRnFXUWZMYlA3dkEwYUJJQlRiRlo2SFp4M3VD?=
 =?gb2312?B?MlYrcmg3TEVSYnB1djVNendtWHdtNWVPSFAyL3lJT0g1bTZQUGRhSG5tYVRp?=
 =?gb2312?B?eXdYVUFxais4K1BzdkVKaS9pQkluSEJNZjdiMFFEb2MzZEFSampFZ2JZcWVL?=
 =?gb2312?B?QkZxT2drTjZiMDM2T1VwSDZxYldnQnNXa3VoZU9ZV2s3d3QvUGNnamxFNnVy?=
 =?gb2312?B?QXhIcjlGWDNiM1FTcEIzem9GL2dYVE5rS3ZJblRGOGtLWlBYWDhrdS9FWHor?=
 =?gb2312?B?SDBqZ1VRWGxBdTZFYjBIVDZ0RFRjMnRQbkY2SHVvdUlRVW5IRlhyYXpJaGVX?=
 =?gb2312?B?MGh5TVhlSGR4elZ4WUpwTXR5SUdtRlQzcUlxaXVZMENZRHBhb3hkcGFwajIw?=
 =?gb2312?B?amZpS1lnSjVaRkNCdC81eDJ2SkxVVkxEcG12QVRxU0xaTGErUkRhU1QyaGov?=
 =?gb2312?B?UG13NlJrMnlZWk01S1pXOHR1cU1LODNDTWtzdW5vUWdhQWRuM1pUcU11VWhi?=
 =?gb2312?B?d25XOXVaQTNlVk9TNmNRRTBGQTFDTHNWYWFUSytoa1lDbVd1OHY3S2ZPdnE2?=
 =?gb2312?B?SndoNExYSGVGRjBCVHdVQ0RZeThiY1lyMTQ2WUtJSGNIelFRQ2lIRGUrQkhz?=
 =?gb2312?B?SjJiYXVMUDNaQU9DbGdpT1h0c1Q0YnJsSlpHVldieEdLU0drN2QyUjh5MHRY?=
 =?gb2312?B?TFJaa05yekh4Q1VhYnE1STRra2FpOTNRdTBBcTVPMWRNRC9OQzE4RjdpRTVz?=
 =?gb2312?B?ckpGQlRaUUxzeGx1N1BUWmp0a202ZDFVWkIwZFRHSU9ZWTJ4Vk1yMGk2MVJV?=
 =?gb2312?B?UFJBT2NtbUR3akVZazJkRFFCMDE3bjZieS9KaS95Q1lSdkF0MmdIbVZvQllG?=
 =?gb2312?B?SXdTR0dPZkhOeHhoaXZmR3kxYWtnV0VNbjF4RCs4VDdHTUFMdTdTeFR3Vy9K?=
 =?gb2312?B?Ny9WVlpKQ2g3UzV3bVRBNnJZTHh3NjRpWVFYcDdvdlZ2TEptMHFmeGpIVXVZ?=
 =?gb2312?B?aVhFR2t1dnFRbXg1WWs4cUJwQ29ITHdvOFpWM25GT2NkTUNxMkpOUFM2SHpW?=
 =?gb2312?B?NGNHdmgzOWNJNFFJWkRoYUh4UFNPQ2podWFsZTRuTDBPT1hYWVZxMDZmSDZC?=
 =?gb2312?Q?cac2fwpE2mGD32o9NKmnViNjZDZsNk=3D?=
Content-ID: <843D45B6A36608458AF83DD71EA38D5B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fc42f0-91d7-4b54-e6b0-08da0d36d9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 01:37:25.7794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoILDBYvNkvDbCzwuW5lra/UtpURxCOvSamhf4y0Qg1SFyVoZk406EwzBZ33WPoojps8RFZdIpuxnxoiqAWB6q6EifVkSL7bUOovwz2rdxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5890
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] syscalls/umount2: Convert to new API and
 use SAFE_ACCESS
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Dai

It seems you don't fix some problems thant I comment on your v2 patch.
so again

>   /*

Typo  /* =>/*\

So the description can be used in docparse.

ps:you can cd ltp/docparse directory, then run make command, it will
generate metadata.html, then put this html file into your nginx or
appache directory, then you can see this html whether works well for
docparse from other host.
> - * DESCRIPTION
> + * [Description]
> + *
>    *  Test for feature MNT_EXPIRE of umount2().
> - *  "Mark the mount point as expired.If a mount point is not currently
> - *   in use, then an initial call to umount2() with this flag fails with
> - *   the error EAGAIN, but marks the mount point as expired. The mount
> - *   point remains expired as long as it isn't accessed by any process.
> - *   A second umount2() call specifying MNT_EXPIRE unmounts an expired
> - *   mount point. This flag cannot be specified with either MNT_FORCE or
> - *   MNT_DETACH. (fails with the error EINVAL)"
> + *
> + * - EINVAL when flag is specified with either MNT_FORCE or MNT_DETACH
> + * - EAGAIN when initial call to umount2(2) with MNT_EXPIRE
> + * - EAGAIN when umount2(2) with MNT_EXPIRE after access(2)
> + * - succeed when second call to umount2(2) with MNT_EXPIRE
> + *
> + *  Test for feature UMOUNT_NOFOLLOW of umount2().
> + *
> + * - EINVAL when target is a symbolic link
> + * - succeed when target is a mount point
>    */
> 
> -#include<errno.h>
>   #include<sys/mount.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
>   #include "lapi/mount.h"
> -
> +#include "tst_test.h"
>   #include "umount2.h"
> 
> -#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
> -#define MNTPOINT	"mntpoint"
> -
> -static void setup(void);
> -static void test_umount2(int i);
> -static void verify_failure(int i);
> -static void verify_success(int i);
> -static void cleanup(void);
> -
> -static const char *device;
> -static const char *fs_type;
> +#define MNTPOINT        "mntpoint"
> +#define SYMLINK	"symlink"
> 
>   static int mount_flag;
> 
> -static struct test_case_t {
> +static struct tcase {
> +	const char *mntpoint;
>   	int flag;
>   	int exp_errno;
>   	int do_access;
>   	const char *desc;
> -} test_cases[] = {
> -	{MNT_EXPIRE | MNT_FORCE, EINVAL, 0,
> -		"umount2(2) with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
> -	{MNT_EXPIRE | MNT_DETACH, EINVAL, 0,
> -		"umount2(2) with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
> -	{MNT_EXPIRE, EAGAIN, 0,
> -		"initial call to umount2(2) with MNT_EXPIRE expected EAGAIN"},
> -	{MNT_EXPIRE, EAGAIN, 1,
> -		"umount2(2) with MNT_EXPIRE after access(2) expected EAGAIN"},
> -	{MNT_EXPIRE, 0, 0,
> -		"second call to umount2(2) with MNT_EXPIRE expected success"},
> -};
> +} tcases[] = {
> +	{MNTPOINT, MNT_EXPIRE | MNT_FORCE, EINVAL, 0,
> +		"umount2() with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
> 
> -char *TCID = "umount2_02";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> +	{MNTPOINT, MNT_EXPIRE | MNT_DETACH, EINVAL, 0,
> +		"umount2() with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
> 
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int tc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	{MNTPOINT, MNT_EXPIRE, EAGAIN, 0,
> +		"initial call to umount2() with MNT_EXPIRE expected EAGAIN"},
> 
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	{MNTPOINT, MNT_EXPIRE, EAGAIN, 1,
> +		"umount2() with MNT_EXPIRE after access() expected EAGAIN"},
> 
> -		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
> -		mount_flag = 1;
> -
> -		for (tc = 0; tc<  TST_TOTAL; tc++)
> -			test_umount2(tc);
> +	{MNTPOINT, MNT_EXPIRE, 0, 0,
> +		"second call to umount2() with MNT_EXPIRE expected success"},
> 
> -		if (mount_flag) {
> -			if (tst_umount(MNTPOINT))
> -				tst_brkm(TBROK, cleanup, "umount() failed");
> -			mount_flag = 0;
> -		}
> -	}
> +	{SYMLINK, UMOUNT_NOFOLLOW, EINVAL, 0,
> +		"umount2('symlink', UMOUNT_NOFOLLOW) expected EINVAL"},
> 
> -	cleanup();
> -	tst_exit();
> -}
> +	{MNTPOINT, UMOUNT_NOFOLLOW, 0, 0,
> +		"umount2('mntpoint', UMOUNT_NOFOLLOW) expected success"},
> +};
> 
> -static void setup(void)
> +static void test_umount2(unsigned int n)
>   {
> -	tst_require_root();
> -
> -	if ((tst_kvercmp(2, 6, 8))<  0) {
> -		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> -			 "that are 2.6.8 or higher");
> -	}
> +	struct tcase *tc =&tcases[n];
> 
> -	tst_sig(NOFORK, DEF_HANDLER, NULL);
> -
> -	tst_tmpdir();
> -
> -	fs_type = tst_dev_fs_type();
> -	device = tst_acquire_device(cleanup);
> -
> -	if (!device)
> -		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> -
> -	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
> -
> -	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
> -
> -	TEST_PAUSE;
> -}
> -
> -static void test_umount2(int i)
> -{
> -	/* a new access removes the expired mark of the mount point */
> -	if (test_cases[i].do_access) {
> -		if (access(MNTPOINT, F_OK) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
> +	if (!mount_flag) {
> +		SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> +		mount_flag = 1;
>   	}
> 
> -	TEST(umount2_retry(MNTPOINT, test_cases[i].flag));
> -
> -	if (test_cases[i].exp_errno != 0)
> -		verify_failure(i);
> -	else
> -		verify_success(i);
> -}
> +	tst_res(TINFO, "Testing %s", tc->desc);
> 
> -static void verify_failure(int i)
> -{
> -	if (TEST_RETURN == 0) {
> -		tst_resm(TFAIL, "%s passed unexpectedly", test_cases[i].desc);
> -		mount_flag = 0;
> -		return;
> -	}
> +	if (tc->do_access)
> +		SAFE_ACCESS(MNTPOINT, F_OK);
> 
> -	if (TEST_ERRNO != test_cases[i].exp_errno) {
> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
> -			 test_cases[i].desc);
> -		return;
> +	if (tc->exp_errno) {
> +		TST_EXP_FAIL(umount2_retry(tc->mntpoint, tc->flag), tc->exp_errno,
> +			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
> +		if (!TST_PASS)
> +			mount_flag = 0;
> +	} else {
> +		TST_EXP_PASS(umount2_retry(tc->mntpoint, tc->flag),
> +			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
> +		if (TST_PASS)
> +			mount_flag = 0;
>   	}
> -
> -	tst_resm(TPASS | TTERRNO, "umount2(2) failed as expected");
>   }
> 
> -static void verify_success(int i)
> +static void setup(void)
>   {
> -	if (TEST_RETURN != 0) {
> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
> -			 test_cases[i].desc);
> -		return;
> -	}
> -
> -	tst_resm(TPASS, "umount2(2) succeeded as expected");
> -	mount_flag = 0;
> +	SAFE_SYMLINK(MNTPOINT, SYMLINK);
>   }
> 
>   static void cleanup(void)
>   {
> -	if (mount_flag&&  tst_umount(MNTPOINT))
> -		tst_resm(TWARN | TERRNO, "Failed to unmount");
> -
> -	if (device)
> -		tst_release_device(device);
> -
> -	tst_rmdir();
> +	if (mount_flag)
> +		SAFE_UMOUNT(MNTPOINT);
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.cleanup = cleanup,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.format_device = 1,
If we specify format_device, we don't need .needs_device because
format_device will enable needs_device automatically.

Best Regards
Yang Xu
> +	.mntpoint = MNTPOINT,
> +	.test = test_umount2,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
