Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F58DCDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 07:48:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B4613CAD3B
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:48:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CA083C8885
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 09:47:50 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D7C314010D3
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 09:47:46 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39C5q8P9006122; Thu, 12 Oct 2023 07:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=TIBezQAjLURYLV4ZdiGHJhAc/23/VTHZSXv8Jj3wF38=; b=
 qcNez5dX8fhARNInARXHM1K9wdaKNtvqJxJBaBa36yCxUxdC7DCdpyvmHjtG01Gz
 eSb8o6jbqD9AaodFAdigr+j2wh2bVj3sg6IWyhDmghjeSZoEPjBv8Fit5CF47juc
 krlHbU2y9/90Vfjtu5SnTtCbmPAILSwiAA4v/KguzODlrE9JY2zpu2z71iOdfLD2
 eCFjolBNMiWxxz6zdtXFd4jSOHaDmYhyqWizX8Jb8gNlIJNSsCta+gmx0G3dh5xf
 ZZQZIwBCmfk0JdlRPbnkF6Tzhzwcmv5rJtYPrjtozyEhxdizE09S02mlOib0MTTW
 p6lreyuh48gW7nqGqazi9Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tnht897ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 07:47:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz5rBmSjPJLC0Xcyh7tsJ01KdBPJwJuHzH6j74MG2ywiKb+nQdQdgAtsSW95VEvJYBVr8yXK/by6Jo4Vq3D0U/OEVa9jGl7nwGGCg74mT4kxPv/R2yuqPUk8uUCDI01JllxBNE6WQwdbld15HltftnxLCC/wfNe2926BVQh2L5aMVhPJjpPePyu1Rs1Uv5bO0PsfC5Q9uRf1RDS2uLmioEjvzt7I1cgK/6wA7mZXxwe72kcu2RfXcMk528RUCnDXZO64YMGysHjGLb82j3ItHGNcAx9xQO5VxEgdHveG0Gp77PWFWkAVLMKW2Ln+FebduWY6jvkNoFUWtoyy5WRy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIBezQAjLURYLV4ZdiGHJhAc/23/VTHZSXv8Jj3wF38=;
 b=hwnb0SDokWg/fdZIUBd5X9VYzg9/6BfjrgCvE8JnmUCmuR706MWWpI+1BZhdTQIrUyRbRX0bLy0RYzK/jdxukYODF6bUVai6nHwn5nYqS/KiPWp5mWEmcvjBgbewnNy54NLuu4PYwSVipZjmIEqZU5F3uNzCIu5QzNizZ6oCyb2+mySMz1IGbvx5ovjfWNfNBABTXtQ6uiHHUEtNkkQSjWdxptJSxjUvGtmeFMqotHJtXjyupRVSgxf/wO1uwSgL32RgpNdROWJVYoG4jSSwRIqXDqg4BGm5erY+DAG5ZCNt+43FsEnrKO8FGY4PRLE2fiEvPZEkJDa7iFG1NjaDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by DM4PR11MB5533.namprd11.prod.outlook.com (2603:10b6:5:38a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 07:47:42 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 07:47:41 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] enable fsx-linux.c running on VxWorks user space
 and add measurement of execution time
Thread-Index: AQHZ/B+LXSwUZreeR02h7gBqSIOVrbBFxPOA
Date: Thu, 12 Oct 2023 07:47:41 +0000
Message-ID: <CO1PR11MB4979B14E604A3330D6DF930295D3A@CO1PR11MB4979.namprd11.prod.outlook.com>
References: <20231011025323.1558560-1-Xin.Wang@windriver.com>
 <ZSZhNWqK-MvqWHHA@yuki>
In-Reply-To: <ZSZhNWqK-MvqWHHA@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4979:EE_|DM4PR11MB5533:EE_
x-ms-office365-filtering-correlation-id: 760b9aa7-f5c1-48cc-40a9-08dbcaf7838d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOIHd5Lo1FBptEDMFlOmq7YLSu9YDccrzzevJAKILAUlmMdHdKi82iNbMtVkYBj31+pRddOjzzY5x/3+JokNO+O3BO2wdmqAzzV6JSHb+i2dm1BJsPjVrha647YuZO4CccGCTmcgn7N+xoSaTv+0hBQmRrZYlVW8WjieE1d/UwvWN6rpzOygCUWTViiWNMcwyNql19l0sHEzyMDC69jhbOvs9/UR1ziAlNctLVy8caFKcbpVk2NAUhp5V6Xa0IhTZaF++fwkrzbQ+r6aNw62x1ODZZREg056ppGrFPwF+wGlQq45R7lCggh6DDGzL1WvPUllBWx3F0xa+8I27ZCTF3i9aYkRenDGGRZwTBMvzQoVQ1UFA3GhxYr1LQRoLUGNFX2BCdJWBvNdrguQ7YI28SbQJIcV6AjnIXI9Z2xJZ+eUpe8+PSQS8u/G3vxaTP3GoxmR7/ca+2FmM7XN342WR5oHQyQjn4xjWLR4Jf6o0OG0SzRfQKYsTFzQGjtx7KgaNs7Ty0+djUh3IHlbpsdipino9yhDK0qc7BZRCt2iqFHv/kfP4PcjQ02fOC85oVyfNoOfHWszFnU1LwjsyJVEpdRjrEfWHPq3xgrssFu+lfk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(39850400004)(346002)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(966005)(478600001)(55016003)(71200400001)(8676002)(86362001)(66446008)(2906002)(66476007)(66556008)(64756008)(76116006)(6916009)(316002)(66946007)(38070700005)(122000001)(8936002)(5660300002)(38100700002)(41300700001)(4326008)(52536014)(33656002)(9686003)(83380400001)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gqIx8WDvIMO7ad+wjEIsTo39uvqVtvl/cz0ytdH0hk8PAGJaAx7gBLIAY5xg?=
 =?us-ascii?Q?P1K4hq5+LkAIreTTRbbf+6RCbhK6dyrx5WpEAgq0xWFycfiI6okw8Udr0dLQ?=
 =?us-ascii?Q?2c6c+xEvBvU7Zf6776KcYzBRpBxvMqcUQ5v1CBBMheRCn+BspC/LsYL/Zhjp?=
 =?us-ascii?Q?F6ShbkHZndEGX79T1VgRKi0WIANtMn0CI07MMsnAf1KtRBShmwnod1Y23hpX?=
 =?us-ascii?Q?woFVnL/CP5Qh3vxu/skqseSFAaWaea7ilJOguSYvG9GwX40RIBDF/qPRWeNm?=
 =?us-ascii?Q?Yeag7KBegesNmxu7RJmDHXJu38JfNkaLBdqLyTUe2juQmlAI78UOrMKbHleL?=
 =?us-ascii?Q?d50Kgpmg1T+ja+NbEN9PNY/+FcpauttCWyV/uJ33Z1+qxe0/CvsL3NhwdbvH?=
 =?us-ascii?Q?bTBLgjyQEVy8KHlNLRmeS8lFb1t4r3KM5WvlcgtzIZZaOXAsAgTl6gMHcAlQ?=
 =?us-ascii?Q?KuRl9445Jl2IzZsBfoUL4usumZeRHcMU25ug1uNe7PI3bWDZWvIu7ruT6oTH?=
 =?us-ascii?Q?1KSLOJeIy4qgu8MXtHBU1SfU6T1Rj0jNGY0h6auDsCPDFvGIsMSWXdSPM9ha?=
 =?us-ascii?Q?UGx+mPr54rLrxMYJF6Hpf6ZjI2OXMZuaKScpNOf3Nl0X5YzXC9Rz6MwvavOu?=
 =?us-ascii?Q?sr0C03UI6JBiFXthVkOpc9xqqHDRT0r6yjApyPFlKAQBfGXtmeWUQ8b7/RDz?=
 =?us-ascii?Q?y86h7uOcT7TAn0tOp7Pqnjub34mM4lepoKZn924WRCGhpNgVrobRnq9SfGak?=
 =?us-ascii?Q?IlonGwAbBNPHZoYFhYDYmx6Pi2WG2vdZ5scs5lWBSi5gvksFKNdMqv7ZcEm6?=
 =?us-ascii?Q?z57ndzwuo/ni7Jn6V7WAmjErCzkhH8hVI2vGfWX7v2c7PY0ur9w3hmCO1O4g?=
 =?us-ascii?Q?9GT6ytvNHL5KzP40rC1ETKUIQ5zBxUWs8XQANgot0bt7uT77jqK29mh7PJYo?=
 =?us-ascii?Q?PweIVrATMtNtM2eiEl6auVBgFM2tus8JUm4DDt4VkXklsMIWBIDV1Q4ycFhp?=
 =?us-ascii?Q?TA5fVlc7n48kmc+843F7QsYS9i1L5KMjLTEXpQrQI+2d/0b3oq/5TWfqnF3Y?=
 =?us-ascii?Q?q+2Kcp0jXiyGR5IbovH639VG+T6yJ0l7mcr/9S2kSfWIG8+3NtvrcxDi+cnc?=
 =?us-ascii?Q?kCKhunGWTPFXT4v/iDs+noi85iQct6CF8KuZW+ZShSsUXB7yQnM8mNeXcrS3?=
 =?us-ascii?Q?YsWMNeEiVefz4iA+L+ZfUOzjsUKCaLnY/NkUH7Tv/iSCNvMcmbim0RbhiEd/?=
 =?us-ascii?Q?T/2FaXp4gYVnOxmHS5knPGzEAVpl7OCJqPXEgJvluufYqFQ8LoQ2fB+vC0Z1?=
 =?us-ascii?Q?jssHuBveSqfJXpcvxI3yGjDn1impmvKHR0feznt1Y7ttkp89TOVw+V+hVCTk?=
 =?us-ascii?Q?LmtMTy7GmjfYJX9rp+u4pwssXZwIMjODFu3GQMNX9M+rBIZE6NzYUNjuEfaX?=
 =?us-ascii?Q?Wxz4sFyjwMhfHgMfCpGnU4SeU2ixqy6iR0VbT+Z9BpstEn905CsSVqORNRpD?=
 =?us-ascii?Q?ZHZS7LnQ+djyjUeKntAD3AFl5EzEdRgeDW8rVXK0eL17sgP/Rst+3FB4zy7z?=
 =?us-ascii?Q?Te2hjfSdVaXIYyzK9/I=3D?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760b9aa7-f5c1-48cc-40a9-08dbcaf7838d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 07:47:41.5358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPIk7RVoqyjhbAxliGuojiKw04MNqrnHGmPKHtVRdLTTy/fzV2WfbwCObsXyyoJhmHT4uGFla7dfYrgjHEL8LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5533
X-Proofpoint-GUID: RRefuTtPfbJQ7j1mRpaDyhdHJKzrZmiQ
X-Proofpoint-ORIG-GUID: RRefuTtPfbJQ7j1mRpaDyhdHJKzrZmiQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_03,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310120065
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

> Hi!
> > I come from Wind River. We and our customers used fsx-linux for file
> > system testing on VxWorks user space and total execution time also
> > received more attention in the testing.  So I upstream the change of
> > VxWorks compatibility parts on this patch, wish to enlarge the test
> > support of fsx-linux.  There is a point need to explain, because
> > current VxWorks doesn't support CLOCK_MONOTONIC_RAW ,
> CLOCK_MONOTONIC
> > is still used by VxWorks when calling clock_gettime.  When
> > CLOCK_MONOTONIC_RAW is support by VxWorks in the future, this part
> > will be removed.
> 
> Actually Andrea started to clean up and rewrite the test so that it uses LTP API
> and he will send a patch soon, can you please send a new patch once that
> rewrite is finished?
> 
> A few comments below.

Thanks for your review. One question abort msync part in below.
> 
> > Signed-off-by: Xin.Wang@windriver.com
> > ---
> >  testcases/kernel/fs/fsx-linux/fsx-linux.c | 44
> > ++++++++++++++++++++---
> >  1 file changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c
> > b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> > index 64c27a0f5..2064fac16 100644
> > --- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
> > +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> > @@ -39,8 +39,10 @@
> >
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > -#if defined(_UWIN) || defined(__linux__)
> > +#if defined(_UWIN) || defined(__linux__) || defined(__VXWORKS__) #if
> > +!defined(__VXWORKS__)
> >  #include <sys/param.h>
> > +#endif
> >  #include <limits.h>
> >  #include <time.h>
> >  #include <string.h>
> > @@ -849,7 +851,12 @@ void domapwrite(unsigned offset, unsigned size)
> >               gettimeofday(&t, NULL);
> >               prt("       %lu.%06lu memcpy done\n", t.tv_sec, t.tv_usec);
> >       }
> > -     if (msync(p, map_size, 0) != 0) {
> > +#ifdef MS_SYNC
> > +     if (msync(p, map_size, MS_SYNC) != 0) #else
> > +     if (msync(p, map_size, 0) != 0)
> > +#endif
> 
> It would be better to define MS_SYNC to 0 on VXWORKS instead.

Because only MS_ASYNC, MS_SYNC and MS_INVALIDATE are defined for flag argument of msync in POSIX. Is it right to set 0 directly in the case? 
Flag set 0 will be identified EINVAL in VxWorks.

> 
> > +     {
> >               prterr("domapwrite: msync");
> >               report_failure(203);
> >       }
> > @@ -1115,11 +1122,16 @@ int main(int argc, char **argv)
> >       int i, style, ch;
> >       char *endp;
> >       int dirpath = 0;
> > -
> > +     struct timespec time_start, time_end, time_diff;
> > +
> >       goodfile[0] = 0;
> >       logfile[0] = 0;
> >
> > +#if defined(__VXWORKS__)
> > +     page_size = (int)sysconf(_SC_PAGESIZE);
> 
> We can just use sysconf() everywhere instead.
> 
> > +#else
> >       page_size = getpagesize();
> > +#endif
> >       page_mask = page_size - 1;
> >
> >       setvbuf(stdout, NULL, _IOLBF, 0);       /* line buffered stdout */
> > @@ -1267,9 +1279,12 @@ int main(int argc, char **argv)
> >       signal(SIGUSR1, cleanup);
> >       signal(SIGUSR2, cleanup);
> >
> > +#if defined(__VXWORKS__)
> > +     srand(seed);
> > +#else
> >       initstate(seed, state, 256);
> >       setstate(state);
> > -
> > +#endif
> >       open_test_files(argv, argc);
> >
> >       strncat(goodfile, dirpath ? basename(fname) : fname, 256); @@
> > -1336,12 +1351,33 @@ int main(int argc, char **argv)
> >       } else
> >               check_trunc_hack();
> >
> > +#if defined(__VXWORKS__)
> > +     clock_gettime(CLOCK_MONOTONIC, &time_start); #else
> > +     clock_gettime(CLOCK_MONOTONIC_RAW, &time_start); #endif
> 
> And here it would be cleaner to define the clock to use instead of ifdefing each
> clock_gettime call. I.e.:
> 
> #if defined(__VXWORKS__)
> # define CLOCK_ID CLOCK_MONOTONIC
> #else
> # define CLOCK_ID CLOCK_MONOTONIC_RAW
> #endif
> 
> >       while (numops == -1 || numops--)
> >               test();
> >
> >       close_test_files();
> > +#if defined(__VXWORKS__)
> > +     clock_gettime(CLOCK_MONOTONIC, &time_end); #else
> > +     clock_gettime(CLOCK_MONOTONIC_RAW, &time_end); #endif
> > +
> >       prt("All operations completed A-OK!\n");
> >
> > +     if (time_end.tv_nsec < time_start.tv_nsec) {
> > +             time_end.tv_nsec += 1000000000;
> > +             time_end.tv_sec -= 1;
> > +     }
> > +     time_diff.tv_sec = time_end.tv_sec - time_start.tv_sec;
> > +     time_diff.tv_nsec = time_end.tv_nsec - time_start.tv_nsec;
> 
> LTP has functions for operations with timespec, here you should use
> tst_timespec_diff()
> 
> > +     prt("Elapsed Test Time %lu.%09lu\n",
> > +        (unsigned long)time_diff.tv_sec, time_diff.tv_nsec);
> > +
> >       if (tf_buf)
> >               free(tf_buf);
> >
> > --
> > 2.34.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
