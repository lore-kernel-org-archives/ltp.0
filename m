Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F51AC352A1
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 12:54:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E64493CC128
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 13:54:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B0483CC0C5
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 13:54:39 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FC5F1000357
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 13:54:38 +0100 (CET)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B7BH8nv023006; Wed, 7 Dec 2022 12:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=tdtd5ecssftJbDkI2FqTRJh5WqDMnvI3dhQau9jpXg0=;
 b=YeTQ6+/IJYfObtGAy5XIQf91pQXvO1Y/3f3lIfyyXtVJK3MCC2mkSs0LiWxHxaY4D9VT
 Zg7LuxNMusq6O/KTKkLhxkjMrUNtgTltPT4UXz5nx7N/VUvYCC43o5yEhAjvuIpQqr19
 4WVLfMqEn8l9JWGUGQSlYFh5wuaEp72kgHHMm2NOhHGfUEj5Ki0Cu04u52lDaQ12hdRd
 37lqjPBgKmusTKLPycD2BZ/XFJWeAbBrohZ6irFl3Dzrt0ynQurP6GhBHMspCnp6PScc
 0sMHE5WQlyeH7vQ5NB8BsQTJJ3mD0UHx40sWv/miYhO2IJojXPW7YrF6kUwtpLxPRPqE Ew== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mastp27qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Dec 2022 12:54:37 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B795XrT010213;
 Wed, 7 Dec 2022 12:54:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3m9m7ra57u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Dec 2022 12:54:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2B7CsVWl40632654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Dec 2022 12:54:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EDEC2004D;
 Wed,  7 Dec 2022 12:54:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 346EE20040;
 Wed,  7 Dec 2022 12:54:29 +0000 (GMT)
Received: from tarunpc (unknown [9.43.68.243])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Dec 2022 12:54:28 +0000 (GMT)
Date: Wed, 7 Dec 2022 18:24:23 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20221207125423.eiuowfpu42pv3oxc@tarunpc>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-3-tsahu@linux.ibm.com>
 <87mt82t0h4.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <87mt82t0h4.fsf@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2Lcl0_nlQkxa0OA8Ny2Td_khMnMx7id
X-Proofpoint-ORIG-GUID: B2Lcl0_nlQkxa0OA8Ny2Td_khMnMx7id
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_05,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070108
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/8] Hugetlb: Migrating libhugetlbfs
 huge_at_4GB_normal_below
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
Cc: aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 ltp@lists.linux.it, geetika@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,
Thanks for reviewing it.
On Dec 05 2022, Richard Palethorpe wrote:
> Hello,
> 
> Tarun Sahu <tsahu@linux.ibm.com> writes:
> 
> > Migrating the libhugetlbfs/testcases/huge_at_4GB_normal_below.c test
> >
> > Test Description: Designed to pick up a bug on ppc64 where
> > touches_hugepage_high_range() falsely reported true for ranges reaching
> > below 4GB
> >
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> > ---
> >  runtest/hugetlb                               |   1 +
> >  testcases/kernel/mem/.gitignore               |   1 +
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 122 ++++++++++++++++++
> >  3 files changed, 124 insertions(+)
> >  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
> >
> > diff --git a/runtest/hugetlb b/runtest/hugetlb
> > index 4c16e1e7c..2029ee4b3 100644
> > --- a/runtest/hugetlb
> > +++ b/runtest/hugetlb
> > @@ -14,6 +14,7 @@ hugemmap09 hugemmap09
> >  hugemmap10 hugemmap10
> >  hugemmap11 hugemmap11
> >  hugemmap12 hugemmap12
> > +hugemmap13 hugemmap13
> >  hugemmap05_1 hugemmap05 -m
> >  hugemmap05_2 hugemmap05 -s
> >  hugemmap05_3 hugemmap05 -s -m
> > diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> > index adea760c7..5955ed613 100644
> > --- a/testcases/kernel/mem/.gitignore
> > +++ b/testcases/kernel/mem/.gitignore
> > @@ -13,6 +13,7 @@
> >  /hugetlb/hugemmap/hugemmap10
> >  /hugetlb/hugemmap/hugemmap11
> >  /hugetlb/hugemmap/hugemmap12
> > +/hugetlb/hugemmap/hugemmap13
> >  /hugetlb/hugeshmat/hugeshmat01
> >  /hugetlb/hugeshmat/hugeshmat02
> >  /hugetlb/hugeshmat/hugeshmat03
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
> > new file mode 100644
> > index 000000000..84a84e074
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> > + * Author: David Gibson & Adam Litke
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Designed to pick up a bug on ppc64 where touches_hugepage_high_range()
> > + * falsely reported true for ranges reaching below 4GB
> 
> Hhmm seems like the macro no longer exists. This isn't a great test
> description.
> 
> This appers to be the fix for the bug mentioned:
> https://lkml.org/lkml/2005/11/23/540
> 
> Maybe we could add to this that the test creates a hugepage just above
> the 32bit memory space and a normal page below it. That on old kernels
> this would trigger a bug caused by an off-by-one error.
> 
Yeah Agree, Will update it in v2.
> -- 
> Thank you,
> Richard.
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
