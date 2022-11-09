Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B669C433FE
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 18:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D828A3CD75B
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 19:09:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5BC73CD742
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 19:09:38 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50B751A00163
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 19:09:36 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9GBw3T000877;
 Wed, 9 Nov 2022 18:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=J6N1UtOz+wdj9MN9OQsGxjmYq2QBYKeTlponTC3hTOQ=;
 b=crDAU+Q6IkEnamj/nCrwbr9TGHuFL5DFh11qDtEEmgW8MICAXV6WzeLhviVEYzLBGI9i
 rOtDhVM4y0pZvKvAcLazikN2m0gpNriKQKRDSwwehz9THrWOdY6zOD/AyLP7AgXv4q7k
 w2igLCFqrkWKbvHYFDZXF2EefsxrRyUfxtZJaOE0DRl0JEn+B7viRHRTFkyWEB+Wymsb
 QhhyBYYjb5EarKIS3LeHP3xNKwlCKyDuZy0GPzZ+lN9kh5KR+LIBGIkfNspy2Yw83lP9
 EP8QmmEfzZMh8w2avGjWK8YZqVGo8FrZ3em8j8Yx7uPR9mZ1XgnT28JV5JoSnfk6n3Vx mw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krfguu61s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Nov 2022 18:09:33 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9I6iS4008348;
 Wed, 9 Nov 2022 18:09:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03ams.nl.ibm.com with ESMTP id 3kngqge302-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Nov 2022 18:09:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A9I9SwM25559566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Nov 2022 18:09:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27A254C04A;
 Wed,  9 Nov 2022 18:09:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 417504C040;
 Wed,  9 Nov 2022 18:09:25 +0000 (GMT)
Received: from tarunpc (unknown [9.43.99.20])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  9 Nov 2022 18:09:24 +0000 (GMT)
Date: Wed, 9 Nov 2022 23:39:21 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221109180921.7l27oibmhev6fft7@tarunpc>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-3-tsahu@linux.ibm.com>
 <Y2uqS3gKG8FbS0s5@yuki>
Content-Disposition: inline
In-Reply-To: <Y2uqS3gKG8FbS0s5@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GXL7DySCxIEqinFKuMpOeruClRAP38_R
X-Proofpoint-ORIG-GUID: GXL7DySCxIEqinFKuMpOeruClRAP38_R
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090137
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] Hugetlb: Migrating libhugetlbfs directio
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, 
Thanks for reviewring it.

On Nov 09 2022, Cyril Hrubis wrote:
> > Migrating the libhugetlbfs/testcases/direct.c test
> > 
> > Test Description: This Test perform Direct Write/Read from/To hugetlbfs
> > file which is mapped to process address space. The test is checking if it
> > succeeds and data written or read is not corrupted.
> > 
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> > ---
> >  runtest/hugetlb                               |  1 +
> >  testcases/kernel/mem/.gitignore               |  1 +
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  | 87 +++++++++++++++++++
> >  3 files changed, 89 insertions(+)
> >  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> > 
> > diff --git a/runtest/hugetlb b/runtest/hugetlb
> > index 8a56d52a3..b9ee7227d 100644
> > --- a/runtest/hugetlb
> > +++ b/runtest/hugetlb
> > @@ -7,6 +7,7 @@ hugemmap07 hugemmap07
> >  hugemmap08 hugemmap08
> >  hugemmap09 hugemmap09
> >  hugemmap10 hugemmap10
> > +hugemmap11 hugemmap11
> >  hugemmap05_1 hugemmap05 -m
> >  hugemmap05_2 hugemmap05 -s
> >  hugemmap05_3 hugemmap05 -s -m
> > diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> > index e7def68cb..3e64b67be 100644
> > --- a/testcases/kernel/mem/.gitignore
> > +++ b/testcases/kernel/mem/.gitignore
> > @@ -8,6 +8,7 @@
> >  /hugetlb/hugemmap/hugemmap08
> >  /hugetlb/hugemmap/hugemmap09
> >  /hugetlb/hugemmap/hugemmap10
> > +/hugetlb/hugemmap/hugemmap11
> >  /hugetlb/hugeshmat/hugeshmat01
> >  /hugetlb/hugeshmat/hugeshmat02
> >  /hugetlb/hugeshmat/hugeshmat03
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> > new file mode 100644
> > index 000000000..357c61ab9
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + * Copyright (C) 2005-2006 IBM Corporation.
> > + * Author: David Gibson & Adam Litke
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * This Test perform Direct Write/Read from/To hugetlbfs file
> > + * which is mapped to process address space. The test is checking if it
> > + * succeeds and data written or read is not corrupted.
> > + *
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <sys/mount.h>
> > +#include <limits.h>
> > +#include <sys/param.h>
> > +#include <sys/types.h>
> > +
> > +#include "hugetlb.h"
> > +
> > +#define P0 "ffffffff"
> > +#define IOSZ 4096
> > +#define NORMAL_PATH ""
> > +#define MNTPOINT "hugetlbfs/"
> > +
> > +static long hpage_size;
> > +static int fd = -1, nfd = -1;
> > +
> > +static void run_test(void)
> > +{
> > +	void *p;
> > +	char buf[IOSZ] __attribute__((aligned(IOSZ)));
> > +
> > +	fd = tst_creat_unlinked(MNTPOINT);
> > +	nfd = tst_creat_unlinked(NORMAL_PATH);
> > +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> > +	memcpy(p, P0, 8);
> > +
> > +	SAFE_WRITE(1, nfd, p, IOSZ);
> > +	SAFE_LSEEK(nfd, 0, SEEK_SET);
> > +
> > +	SAFE_READ(1, nfd, buf, IOSZ);
> > +	if (memcmp(P0, buf, 8)) {
> > +		tst_res(TFAIL, "Memory mismatch after Direct-IO write");
> > +		goto cleanup;
> > +	}
> > +	SAFE_LSEEK(nfd, 0, SEEK_SET);
> > +
> > +	memset(p, 0, IOSZ);
> > +	SAFE_READ(1, nfd, p, IOSZ);
> > +
> > +	if (memcmp(p, P0, 8))
> > +		tst_res(TFAIL, "Memory mismatch after Direct-IO read");
> > +	else
> > +		tst_res(TPASS, "Successful");
>                                 ^
> 				We shoudl write something more
> 				meaningful. Something as:
> 
> 				"All data were read and written correctly"
> 
> Other than this the rest looks good.
> 
Ok, Will update it.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
