Return-Path: <SRS0=8P1C=PD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5ADC433EF
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 08:45:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6B561163
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 08:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C6B561163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CD763C14BD
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 10:45:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 693B83C1324
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 10:45:08 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB5EC1A010F8
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 10:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1634287506; x=1665823506;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=H8WkQH5fiO2MvWBKrx1fUS+iR/1GIjzRsPlNF5nd5U8=;
 b=pYLMMGyD1ClqTFX/f+NllvQeY6zvUs209iaPSC+fM9hkS8awS0v1s1L1
 BD3NviqsoPznFbuZMb+i4UErbueSRWx4IHf6L6rNLPtz1KOA3SGgBszGH
 ysZKz3II/CRVE6KXQVMABf+5RvGQdYp9vIP6166GhtJ1dWWKSfQYlipUt
 p/s6r8HQ5uJpHTxDlBdIhVc0bFVVRaBrqUY38AvNIje9+QwPNHciu7Uss
 S+C7oP+CPBOdZIdZKhJhyaVt7pa5h8JVVKarF6UW9Ze6yZDGJe160R373
 icDUBlFzdusg9fYmOCvk6vSSc9Si+XlB7DX61lxHujR/PoxKvKOIzfv9B g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="49606244"
X-IronPort-AV: E=Sophos;i="5.85,375,1624287600"; d="scan'208";a="49606244"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 17:45:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnr7gx2t+HBgHz2VhpVom56Ewm8lybcTQ4d7a93rjI/LVcgiLyi5zv7UrT1BOTo15beMwAHm6Cvtd4j+u3mzAOIEv8tYMDinn3z4sN65KW49en0c/4NjZnnLG7aoam+vZczkPb4/m71vrSw/4Yn8N2OwFFFZPCGBVMTOHIiIqLUokPQN3TqmovqMmCN5QQ4ZNgarhIbFRa7IRlAHp2xFm6SpFtj1pA0vPtECqEAL6S/HZtipW2/610PKJOoS4DykBIPoiMQ+fjy1Dak66QxoqswlF9USl7DibFUSQg6uY/oErbpgSwurGvYEaqpoiTvYL8WsgI+N/dP8vmDGeMpNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8WkQH5fiO2MvWBKrx1fUS+iR/1GIjzRsPlNF5nd5U8=;
 b=XnpHKlj6Fd6+Xq8HGE9j/sYyrLFR12rj6IOibDYaZvn+wTbfgQmdCHTeFNnAJEdf8bYCqpZS+SyDSejkKj5H290/eRNxZqjvQgXek3iwXlp5Li8A+NqURc5BcG+x78VHd2Rc8uaTf/H+DCSHYspbG19htGh3y+wfo/g6k4IgOdLqb5sPWO6sfLmE//RaMOrOm0i0N/hh/BOr8OEx3Zi1Ck9GC38recfeyvRRNTzGQyfp7boP14ZuFjTKPmS+9p4ZReehtf5BhXj5TAwk3zSiVtQ6MlgrDoj3TLVbzgv0AE3ex/SVuyqKZaYUs3xOpUar/+6tYBcyc8owe1rdZ8HMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8WkQH5fiO2MvWBKrx1fUS+iR/1GIjzRsPlNF5nd5U8=;
 b=Iqmn3S695xb/Nalv4EdFve8bIb+nqm8gLJIsUh5MExJB/maeMZvkiVTCH/BOlu6YQr1b78r/oe17to0HvCT3hWG0RqGvcCWVzuB8oEqJP5LcKNZdjW/xwkBhBB7ZNDoUKK8Ciu4Ok6MfwhS5EGpl7DAEnz82Bcd378+o+zTtfxU=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2861.jpnprd01.prod.outlook.com (2603:1096:404:88::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 08:45:01 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 08:45:01 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v4 1/1] creat09: Run on all_filesystems
Thread-Index: AQHXwaAJaTZlSw6PGUat0/81SOD6YavTvpYA
Date: Fri, 15 Oct 2021 08:45:01 +0000
Message-ID: <61693F84.6050007@fujitsu.com>
References: <20211015083820.11903-1-pvorel@suse.cz>
In-Reply-To: <20211015083820.11903-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95e8425f-009b-4ba5-b51f-08d98fb8139d
x-ms-traffictypediagnostic: TYAPR01MB2861:
x-microsoft-antispam-prvs: <TYAPR01MB2861E405906C47C73D0807A6FDB99@TYAPR01MB2861.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kB2CUwFtJAK+DbYmzMGV+3yuNJnE6v+h+4lIWXcCzYlXCWFQkrVjkCMK/CIKuFLMgcYoceV57YFZztgKs/HqSBeA9VzxuUa3RvpPwECkgMTv1m2KFalVxHgLCljvrxhrq8C8j+o1fp8i+89bj7Qd3pj6VT4acr7T3KPnqgj97UyKJMD8MnhF+alC6LLf5An6jByFj7DjWzAkqlBnFnidE+n+Cm2evSNEJeMzNm0B2SmmODBY3E3oc1+kj6OilQNFfSLswK/Dd68EZttrUdRqPbCnW4Vm1W8Ho3PI6cdPZAaISj0p6nw0oyOuV4YpOUluW+pmgIunFSmxe4jm4oVmw5cEjFPfnTX2G0ITy2raQzzrojpOvBB8zQZHGT9LK32J7xFQIuB6oKmUGeMER9KACVS96uo9oL6ABtph7t/Az+tjyF28ZUQp8terxYXDEbIMlmj+Lqy+W2ACnWvWKBtHQ3uIgHYdF93P4i2WedNxuFPtFv2yB64ifJUoE/w2ZtlYzQT0sNfshZX0Y5mMgBe36UbVPvuQgZifEyYF+moK9WoVNBn7cG8nVHwYoIenzPJqL8jJyWp3o96m9cbrBT6TrOFRSSDO8GjuS/BFLX7eAcMVPcN1/t1owRlKNeZL9qRuW+X1vmd9uAVjiSOHfwUF78WWx0+19Oo9VYqSN10NfayYMGahLV9bZ4/yxMVCMFbshdYLsXBIQ3j6FE0XMAamEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(87266011)(8676002)(26005)(66446008)(91956017)(45080400002)(186003)(76116006)(66476007)(71200400001)(6506007)(6486002)(66946007)(66556008)(64756008)(316002)(2616005)(8936002)(38070700005)(6916009)(82960400001)(33656002)(4326008)(38100700002)(2906002)(83380400001)(36756003)(122000001)(54906003)(86362001)(6512007)(508600001)(5660300002)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cW9KcVU4RDRUdmRKS0dXdjVsTnRoTjBSWGhTNURJeDN2V2FCRDUvL3FQb3J5?=
 =?gb2312?B?N2lKczRodEZLRjhsdG5mMDdYTGV1V3psVEJlb1hMUnNEZ1liZVdOdWVSS0Rr?=
 =?gb2312?B?Qm0remwwUUZnbkhJcHRKVEZHOEw0TzQzOGtpWEVLcUFqMzlaR3R0Nk5zUmRm?=
 =?gb2312?B?ek1vdU1YcGpsV3dLSDhGdURqNHQyZ2Q0YkFNVjI1akhIYStpZHIvakI3Tktk?=
 =?gb2312?B?a1lYM3RPSTZVZk04U1lxblhFME03UGl3M25DcUdUbFNWeUpqWXNSa3BueUJC?=
 =?gb2312?B?OTY4QlphbmFMQWZmSWtxbk82aGNyZG1KaTVYZVpxanc3RzA5Znp2dVovK0ZX?=
 =?gb2312?B?MW0zY0MzUGFKZnlMbFVjLzVJblRYQzRQVFQ1WG1ablZERGpXYXQ5YlNRMzFs?=
 =?gb2312?B?SHpIRnp2NHo0SDVrdmZPZCtPczlGU2lkbmswV05jVG1PbSt6dFlINHRtT2Iy?=
 =?gb2312?B?dFNpcXNHU0ViMVdONEdnb0VMSGRtREc4Qm4rNjFIRittbnhBQnFOMGNzdWZk?=
 =?gb2312?B?Z0hKZnpGUFFKTklFS3lPQkdURUJKSDhCUlliZVFRLzR1ZS8ra2IxZFJDUnov?=
 =?gb2312?B?WHBBSlRUNFFTSkZuUGRDQ01tQXJlZlZzelFjS1NtdTZ3OVNBRlFZcXEvRmNX?=
 =?gb2312?B?VVJ6TDNDc1ZEOEZ0aE9vWkhxOVlub3RLQWlCdnFQTmdoekJhdHdjcTZHR2tx?=
 =?gb2312?B?ZGp3U1Bta0dVcWY4RS8zVHhiQzV0T2pqTUFzOGhtRzVkZ28zWGpIVURzQXhB?=
 =?gb2312?B?MHRKczFVODhxejB5WmJ1SXhSd1VDay8rNTY0ZjZTNk1OblRVaGpXQTQ5YTds?=
 =?gb2312?B?WmppdU5XekZLRW43MHBiVGhqNWdZSUtIZ0tvT1VsUmo5a2wxZVJrWTZ2TmpZ?=
 =?gb2312?B?R24zZU9GV1pyQmp4Z2dNa0YvOWtVeWQycFNFclRrL1Q3Y2NPVUtlWS9wb3Ey?=
 =?gb2312?B?Skw4QlFXVnZZbUtsWGIyUTRWZENPZDJVTWVFakVGRzNsb0E4Rm5HdWQ3RTMx?=
 =?gb2312?B?Ulo5VElaYmUrM1lsUUhDbWtxOUJITGxnN1E4UHpVL2pWWDQ1eGlTOGo5TDFm?=
 =?gb2312?B?V1NFTldxN0ZaMUFNTm02b3lhcjRRNEtQTUdXME9VUG0xdXhJaG1KVmdwcHRa?=
 =?gb2312?B?cytaR3UwbzRRbGtBVXJrckRlNUVhdnNHMU5KSjZ2dmdNdWF3ZlcrVkc1b0Fz?=
 =?gb2312?B?N2cwLzFBeG0vblQ3T1E2eUpWeEoxeEdTSE9rSGR4TEh2VklOWmg5cEhITUNG?=
 =?gb2312?B?b2M4dVJaejRCa2hEQnZxSnlzVmswbVFWUnlNdDBlYmp0T2xqd2orV3ZxTUU4?=
 =?gb2312?B?SkpHS3U5czdrTjdqMm9PQk5qMDAxc0RrYVJSMW0vc09qYk8yTUhBZzRiUFRr?=
 =?gb2312?B?aWlhbFM5Y2dzUWExc0s2RUZTK0ZxV1dxeWlIdW5CNVBjY2JYd1FlY1Rpb1Y4?=
 =?gb2312?B?K3RTcERYR2NYbmhabDdwNml5bkhUdmJSQkZtaVl2NExKaVZEclE4VS9SSVJ0?=
 =?gb2312?B?N3NsakRacS9raGlka1p3di9WM25UTVBNUzZJSEMxT20wQmZjTmVJb3NjSitk?=
 =?gb2312?B?eWlpTzVjeWJMSmhubStYRmU3ekt0ZytvQzdNVlpZUU0wRGpabUZ6Z3ZxRlQ1?=
 =?gb2312?B?SmZsWWJwc0tFcjZML3RNTllmeEZtOUhkdEpUWjVEeGlqUTJoRUVISWZrdjNL?=
 =?gb2312?B?U1d5MlNzcGdXaDE3Ym9BQmhFNHlndElFZ1pkdjF4NzZnam1tQXU3dTdmcnlp?=
 =?gb2312?B?ejhaN2ZOM3BWdUpwZ0NCTGpHTjBDS3FCR2JIV2JwbG84VURhcDk4aXVUZkFw?=
 =?gb2312?B?WERqL1p5OUNiN2V3YkR5QT09?=
x-ms-exchange-transport-forked: True
Content-ID: <33B1C41018F28C4D9952C9ED5AE2E988@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e8425f-009b-4ba5-b51f-08d98fb8139d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 08:45:01.4885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aw4ta1uybr9xIlDGfbLC3cXBZeQIl8j5Mhv0Gux72mwutWQ4HtOTuOTi46y0WwmWkgWIyii1MDy9LbPbUKh+QnSHJCF0VTWGb4oqJ3qF47g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2861
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] creat09: Run on all_filesystems
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

Hi Petr

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> To make sure bug on XFS is detected on systems which use it.
> 
> Due setgid is test problematic on Microsoft filesystems:
> 
> creat09.c:81: TBROK: ntfs: Setgid bit not set
> creat09.c:76: TBROK: chown(exfat,65533,4) failed: EPERM (1)
> creat09.c:76: TBROK: chown(vfat,65533,4) failed: EPERM (1)
> 
> thus they're disabled.
> 
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
> changes v3->v4:
> * remove useless .needs_tmpdir
> 
> changes v2->v3:
> * add missing dir separator /
> * remove unused SAFE_CHDIR() (was needed due missing /)
> * remove unused<stdio.h>
> 
>   testcases/kernel/syscalls/creat/creat09.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index 681b80c7d..bed7bddb0 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -39,7 +39,8 @@
>   #define MODE_RWX        0777
>   #define MODE_SGID       (S_ISGID|0777)
> 
> -#define WORKDIR		"testdir"
> +#define MNTPOINT	"mntpoint"
> +#define WORKDIR		MNTPOINT "/testdir"
>   #define CREAT_FILE	WORKDIR "/creat.tmp"
>   #define OPEN_FILE	WORKDIR "/open.tmp"
> 
> @@ -118,7 +119,15 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.needs_root = 1,
> -	.needs_tmpdir = 1,
> +	.all_filesystems = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.skip_filesystems = (const char*[]) {
> +		"exfat",
> +		"ntfs",
> +		"vfat",
> +		NULL
> +	},
>   	.tags = (const struct tst_tag[]) {
>   		{"linux-git", "0fa3ecd87848"},
>   		{"CVE", "2018-13405"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
