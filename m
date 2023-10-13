Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF387CDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:05:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387E93C8BA9
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:05:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31373C8767
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:05:33 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 28B631A02368
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:05:30 +0200 (CEST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D5dQmM029150; Fri, 13 Oct 2023 00:05:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=NxrbbrZNxaXGbwUa+mZxSjeVIpx6aU50ea+8sT/ZrfM=; b=
 QFxf82KyzOEucQWiaVJU2rKMeaHKHZlOq/McRnJeBout0XawL/Gr+U0swnBdjHfr
 5Fw8idP9cdf4JzylPZrSiFZGrbMmjo+USe+w46DeTAWTUK83q2yMpZLTYv1bfDsd
 nyywZKnviuBHUD/Kzg5UHsw2JLzhyoRfHnuF62tQbQ6U8gOz227qZfUcmXd26zOa
 KFASzhbTDseNCL+1sCv1H4TwO1p86QsTBMPDdxjTrgqwZYeRpwpUlttADU2RAG08
 3r1pcD6v4P2cc8IrzRepZ/GnhqxPrYLZ6/PYb/eku2fzPG9MKJ5TnPfyzr/kTvCY
 foFdITMxT54HNGCeUbshww==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tnhq4a7me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 00:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm8H8GkX4dKSiBN222UYiVqPwIEyEudRJlDWSVpJrWFSnVvdY6s03OdjdZmc0pXK8WT4jO7XpBzGAZmzswBDcJfoOs1gEUY79Hy6yjRz3B24s7VZNNllHulqEVn65DYYjpDiwOfUcFnm044UpH8bI96B1FQGFYqt6nu6132iJ6eQn3qugdQ2D4OeliGEk+MPUTeAQ2MGmnVKYuq8cI2AbKANY88L8hv/8s2eOOPaGFf7KK0QCAgiEgqk+XvXSCNRoMVoPzMmY9G4Ql88vuGTsSlsDRooq2uvyKq2s2OfBiPeG0StC8sKd3gzlp0839hIv2xXbaCUpXI8R+LaGx4Ekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxrbbrZNxaXGbwUa+mZxSjeVIpx6aU50ea+8sT/ZrfM=;
 b=ARWvyqJddncZ8coi1Pz+0DEHkX0NLRHbyeJQlRyufOatkiOWksgV8noB10LvPI3VFB5Q6qjm2mORxKGUgGbCiHV/MS6Qh03zb8zgEN2Z/qv0hVthVzvV76u595b/MN61M+8o3XWCHjV9ApMNmdKgONn1qY9tePpZ507Ds6bDk6dMGJwoBLaCGtPVqmZ53zBvgJORA7laKZ56hxnpUE5T+HZpfA9tK8GeQdLfPLl92G7m6UHfJt0hpFWXMdSOERmYbOlFRM7kvkKN2+xPUzydjPBFp9K84JeKV16jPi66MfPLntkZ1p991b/vsjomc6dolmEHjC0/9Bx1Elo9UroTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by SJ0PR11MB6743.namprd11.prod.outlook.com (2603:10b6:a03:47c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 07:05:22 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 07:05:22 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Thread-Topic: [LTP] [PATCH] enable fsx-linux.c running on VxWorks user space
 and add measurement of execution time
Thread-Index: AQHZ/B+LXSwUZreeR02h7gBqSIOVrbBESL+AgAMDsBA=
Date: Fri, 13 Oct 2023 07:05:22 +0000
Message-ID: <CO1PR11MB4979F807935CE7F35073947695D2A@CO1PR11MB4979.namprd11.prod.outlook.com>
References: <20231011025323.1558560-1-Xin.Wang@windriver.com>
 <ZSZhNWqK-MvqWHHA@yuki> <30ac1949-383f-435e-8cff-fbba05d7d011@suse.com>
In-Reply-To: <30ac1949-383f-435e-8cff-fbba05d7d011@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4979:EE_|SJ0PR11MB6743:EE_
x-ms-office365-filtering-correlation-id: 44087c99-685c-4050-6b17-08dbcbbac490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Lc6vUQ1EcLRrGuVPhvZhQ8C2o2U0nzxqV2fPuUARjDqJsHC87wsXeNgqLCux5t98sQipBSuLwWxn12QOvLoT9kaEOndW6rbW7HILQUNL/GZtSoV9RK5A9YpQPFDQLkaeZUEgcwPbe0rQ4vp7m8q2Qg+2n+WEBQ5iWTkWKTVslIGrpOP/SDusUO1XLU0LMEpAVBRLIj+p4vBQzxt/c+39S8c+q8YknE30pgG+NeROXRECvDFa5UhS/PKwbCz+U0P6hcTlbbr3IBGhQpl6+wyIAXJucS5FZbrE/Hut+kJBKjsF+euMhs6DBVnwTf4cXtzZJtQFRLeMH6Ya5Btbgl94jBwwYbLSLNnUEeny0Sjpv5m4JnpJQAFMr7JMcC0pgvFGDWouLDNYzm5gjX9doOxCQxgWgbA/JB2LcKOCgqCZiwAVTvkQDyvRlOAbX5GdDYUXmY7+3u29zVIf9skjvcy64qghPQK2k8wh2y1NVv4pZWmjBRmhzwMdGwb0UljFLHX3UFoTne6BOeqRjn9I/UiLO5xdRIxlO+yJvv9oooZJbHbnYb7xRFsk/Sjb3aIJhHCQTnlDZffZjOZp0iHBjwJPHDWKUZnYOH/KxpUyehm8A8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(366004)(346002)(396003)(136003)(376002)(39850400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(33656002)(55016003)(26005)(4326008)(41300700001)(66476007)(8936002)(8676002)(66946007)(66556008)(76116006)(66446008)(6916009)(64756008)(316002)(2906002)(83380400001)(5660300002)(52536014)(6506007)(7696005)(966005)(53546011)(478600001)(71200400001)(9686003)(122000001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m+GyXL+B97o9P6ZXhfcELCpqQ2OxrPrgx+GgxbEpq7pAB9mrcXNxjc3LrhnJ?=
 =?us-ascii?Q?GJcN7FCmrkZeNkXWD1dBo6j1PKlHo7f4lOA2v0pWRG1YFmdFA0Mhxa/tAbgk?=
 =?us-ascii?Q?7AIqv3+ZMMNeRHwuZxgxzF/tTQZBgqyegJMFA2hOQ23/gJyGYXg3St4Zgqyb?=
 =?us-ascii?Q?Iu2ASiQLLqoDbjt/hlbHDptSCiAg9AO0n6/L84lXEUUFY32ArSoG2ofSThcv?=
 =?us-ascii?Q?p7OxDgD5kEyNGA4hmMYQZW+k60Ec0BUoH0RYiXBVaySh/nkImin+72cllOWd?=
 =?us-ascii?Q?+xw1+1s9oqwQSiYO3DUPuIulu7uBOIUi5G3Oi/HerAFTdTRCMjW+P4oDGQdW?=
 =?us-ascii?Q?//X4t7SuQzNs7A6i5su2C7QQy5dl0OJtkcJtRuEZjsKub1PNvC3zeH/H6wZC?=
 =?us-ascii?Q?RFl087rG9BKydLdFufLFE5Wu/VGp9WrM3ipLhIDuEY2+BESJHkAamVS2NYhc?=
 =?us-ascii?Q?xUHuA3/L2+pAlJBvLHLnmpSjU0rtq82Zpxm2CT3vUOIY5nKq2oas8W+q7kzD?=
 =?us-ascii?Q?iO+c9VhjNMoqNVK5HnIPTQM+q9xmfRK/UcBccOefYEdNsHxiw5a2zYvqDPS4?=
 =?us-ascii?Q?e10e3oHIP+2MUjCWclrDSq2ssArZAKSmDw6EsnFdjLmr08AQK12JqaR9r7Ym?=
 =?us-ascii?Q?+m+OzGcsZB+Wd+CgEbDd4yy9XuAEPe30oIhzcGZ9yzhIBF4XwgO3lLfUU9wy?=
 =?us-ascii?Q?W8G2BhcMhURku8KYhG7+PUcm41QcbWR0mqRAw7RuPsw9WGtY4snHEgEX6bUP?=
 =?us-ascii?Q?2QuCO67NK15MxJpJ85aDCkQ64y6ooaTeosixhjvsthuBjb9PwJQckuOm9ir4?=
 =?us-ascii?Q?aT21hTrSEjYUChhvHGvM9EdhU8ajYs1prbH1OBBKIf3rBrCCiqxwlGMxH7Pi?=
 =?us-ascii?Q?yu7tEZHDlGJre869EU3DLPm8kXH1lNMAfIvhfFx6EWPf8rqoOqy55fHPn8Lh?=
 =?us-ascii?Q?5EQPCgEjvypuNDK4fQeamgowBzLMAJOvVg28sEh1pjPkgiNypwfkNWgAeStX?=
 =?us-ascii?Q?3+OO7zth+PP82elt34H5gL1y1xSSISsSGiRDV6p+madvKan6pra9H66AgNHH?=
 =?us-ascii?Q?X0vpvSBWdbwSxcRU+/1W8mIKDV/w3bbsEHznPOsQoIdhvu9lA8CzQKSEfxOb?=
 =?us-ascii?Q?PlmGds+OO0O72oOXYQurmSm9lZrjDmNI3p/NeQLpXbmwBTHJ1aeAe0f5Go6y?=
 =?us-ascii?Q?oMzNEyky+lGjiqzgENUhkAVVw2KuGV5/GaEQweL1yCOjQrYUXI5fuw05Twop?=
 =?us-ascii?Q?mYTIQhYju9Yc6Uumq7f6dp0yctgIFnL0cJO+oIMS+Z4G8/sPqK4Vlk9BX2ef?=
 =?us-ascii?Q?AgP1QsxVg8XA9x3KuvivdQcYxdGU4oTUmYufLmdBA75b3RUKqCVWGS2zwmUX?=
 =?us-ascii?Q?k7l6j2OuuwP2E1QG0GfE6HArxzc1pXFFfY3ByaZ0BbQCL+VdYtWEj3tI6/F6?=
 =?us-ascii?Q?DOxtpXE5lQohIEVTSn8EZb5nrF3lqEAmnBYTTPq0QgkRdr6/urCVmQ/rSeee?=
 =?us-ascii?Q?6y4owpMIs+0H2/SBU+wrEZpd8+lb2/9oe3J0x246nWp5TISbxmCaA9BsjMUa?=
 =?us-ascii?Q?o7mCWNZstqYSb1dKwHmZu+LAkPKcYoqDa+HJvTO5?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44087c99-685c-4050-6b17-08dbcbbac490
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 07:05:22.4945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGikxngIv+C2hxkBJLTNogPJlmxgoJD39vc38OgHBVkp7xtPXzAM3JXOiVBP31OGApAIMxMjara1BpU3PMzxWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6743
X-Proofpoint-ORIG-GUID: yd4OzPsgUDuDQiW7N1VryzZz022_amOB
X-Proofpoint-GUID: yd4OzPsgUDuDQiW7N1VryzZz022_amOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310130058
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] enable fsx-linux.c running on VxWorks user space
 and add measurement of execution time
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,
> Hi,
> 
> On 10/11/23 10:47, Cyril Hrubis wrote:
> > Hi!
> >> I come from Wind River. We and our customers used fsx-linux for file
> >> system testing on VxWorks user space and total execution time also
> >> received more attention in the testing.  So I upstream the change of
> >> VxWorks compatibility parts on this patch, wish to enlarge the test
> >> support of fsx-linux.  There is a point need to explain, because
> >> current VxWorks doesn't support CLOCK_MONOTONIC_RAW ,
> CLOCK_MONOTONIC
> >> is still used by VxWorks when calling clock_gettime.  When
> >> CLOCK_MONOTONIC_RAW is support by VxWorks in the future, this part
> >> will be removed.
> > Actually Andrea started to clean up and rewrite the test so that it
> > uses LTP API and he will send a patch soon, can you please send a new
> > patch once that rewrite is finished?
> 
> My 2 cents: I would go the other way around, since I'm busy with different
> things and it won't be available that soon.

Thank you, I could wait for fsx-linux rewrite then send a new patch. Do you have a schedule for fsx-linux rewrite?
> 
> > A few comments below.
> >
> >> Signed-off-by: Xin.Wang@windriver.com
> >> ---
> >>   testcases/kernel/fs/fsx-linux/fsx-linux.c | 44 ++++++++++++++++++++---
> >>   1 file changed, 40 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c
> >> b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> >> index 64c27a0f5..2064fac16 100644
> >> --- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
> >> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> >> @@ -39,8 +39,10 @@
> >>
> >>   #include <sys/types.h>
> >>   #include <sys/stat.h>
> >> -#if defined(_UWIN) || defined(__linux__)
> >> +#if defined(_UWIN) || defined(__linux__) || defined(__VXWORKS__) #if
> >> +!defined(__VXWORKS__)
> >>   #include <sys/param.h>
> >> +#endif
> >>   #include <limits.h>
> >>   #include <time.h>
> >>   #include <string.h>
> >> @@ -849,7 +851,12 @@ void domapwrite(unsigned offset, unsigned size)
> >>              gettimeofday(&t, NULL);
> >>              prt("       %lu.%06lu memcpy done\n", t.tv_sec, t.tv_usec);
> >>      }
> >> -    if (msync(p, map_size, 0) != 0) {
> >> +#ifdef MS_SYNC
> >> +    if (msync(p, map_size, MS_SYNC) != 0) #else
> >> +    if (msync(p, map_size, 0) != 0)
> >> +#endif
> > It would be better to define MS_SYNC to 0 on VXWORKS instead.
> >
> >> +    {
> >>              prterr("domapwrite: msync");
> >>              report_failure(203);
> >>      }
> >> @@ -1115,11 +1122,16 @@ int main(int argc, char **argv)
> >>      int i, style, ch;
> >>      char *endp;
> >>      int dirpath = 0;
> >> -
> >> +    struct timespec time_start, time_end, time_diff;
> >> +
> >>      goodfile[0] = 0;
> >>      logfile[0] = 0;
> >>
> >> +#if defined(__VXWORKS__)
> >> +    page_size = (int)sysconf(_SC_PAGESIZE);
> > We can just use sysconf() everywhere instead.
> >
> >> +#else
> >>      page_size = getpagesize();
> >> +#endif
> >>      page_mask = page_size - 1;
> >>
> >>      setvbuf(stdout, NULL, _IOLBF, 0);       /* line buffered stdout */
> >> @@ -1267,9 +1279,12 @@ int main(int argc, char **argv)
> >>      signal(SIGUSR1, cleanup);
> >>      signal(SIGUSR2, cleanup);
> >>
> >> +#if defined(__VXWORKS__)
> >> +    srand(seed);
> >> +#else
> >>      initstate(seed, state, 256);
> >>      setstate(state);
> >> -
> >> +#endif
> >>      open_test_files(argv, argc);
> >>
> >>      strncat(goodfile, dirpath ? basename(fname) : fname, 256); @@
> >> -1336,12 +1351,33 @@ int main(int argc, char **argv)
> >>      } else
> >>              check_trunc_hack();
> >>
> >> +#if defined(__VXWORKS__)
> >> +    clock_gettime(CLOCK_MONOTONIC, &time_start); #else
> >> +    clock_gettime(CLOCK_MONOTONIC_RAW, &time_start); #endif
> > And here it would be cleaner to define the clock to use instead of
> > ifdefing each clock_gettime call. I.e.:
> >
> > #if defined(__VXWORKS__)
> > # define CLOCK_ID CLOCK_MONOTONIC
> > #else
> > # define CLOCK_ID CLOCK_MONOTONIC_RAW
> > #endif
> >
> >>      while (numops == -1 || numops--)
> >>              test();
> >>
> >>      close_test_files();
> >> +#if defined(__VXWORKS__)
> >> +    clock_gettime(CLOCK_MONOTONIC, &time_end); #else
> >> +    clock_gettime(CLOCK_MONOTONIC_RAW, &time_end); #endif
> >> +
> >>      prt("All operations completed A-OK!\n");
> >>
> >> +    if (time_end.tv_nsec < time_start.tv_nsec) {
> >> +            time_end.tv_nsec += 1000000000;
> >> +            time_end.tv_sec -= 1;
> >> +    }
> >> +    time_diff.tv_sec = time_end.tv_sec - time_start.tv_sec;
> >> +    time_diff.tv_nsec = time_end.tv_nsec - time_start.tv_nsec;
> > LTP has functions for operations with timespec, here you should use
> > tst_timespec_diff()
> >
> >> +    prt("Elapsed Test Time %lu.%09lu\n",
> >> +        (unsigned long)time_diff.tv_sec, time_diff.tv_nsec);
> >> +
> >>      if (tf_buf)
> >>              free(tf_buf);
> >>
> >> --
> >> 2.34.1
> >>
> >>
> >> --
> >> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> The whole CLOCK_MONOTONIC_RAW problem is mostly related with test
> logging messages, which is something we will get rid in the fsx-linux rewrite.
> 
> Regards,
> Andrea Cervesato
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
