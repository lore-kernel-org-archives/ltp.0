Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62546C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 17:28:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED12E3CBDB1
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 18:28:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B6193C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 18:28:13 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 760BE1A00703
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 18:28:12 +0100 (CET)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BDG89ec001299; Tue, 13 Dec 2022 17:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=filkMu+niNB9io43B+FXTpJoi4oW1Y7Su4ZPaPkEpZI=;
 b=hFHvPF0XGhvjjcn0nsOis0OhiS0rqTyqNpd1ruOxPLa24LER8ITjaK9YDQRVk208YU8O
 DleEP/1I5AJi++h59DOEiGH8T1nBZiU19fWJM9ij42Gu1ccx2q4Ty0yOBSevRBccKOfa
 MjKWGwfEW8cXMWyklkO8/K0PXdhcL3BUlI8TDKhQsEd3ELeQnLRYt2gDBizRrrRO6fAm
 74k9GsP7ni7V0PecZt8J/3Fnj0cx0tm/vHFc9p0QIr3ZL8U8zD7RVXBmFbgnPTCiIaH9
 IyzU4xJI9YnfXwmzwjblf4lIOsvSwXy5QCAC2+Wfg2dmu1iglnrxOrrOtagOhk6vlb5u Hg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mevn6jb8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Dec 2022 17:28:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDGwaSb028368;
 Tue, 13 Dec 2022 17:28:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mchr64gwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Dec 2022 17:28:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BDHS3Mn32702954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Dec 2022 17:28:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0582004B;
 Tue, 13 Dec 2022 17:28:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8FB420043;
 Tue, 13 Dec 2022 17:28:00 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.43.67.208])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 13 Dec 2022 17:28:00 +0000 (GMT)
Date: Tue, 13 Dec 2022 22:57:53 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20221213172705.r2kczfotivg4sbck@tarunpc.in.ibm.com>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-5-tsahu@linux.ibm.com>
 <878rjcvh9f.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <878rjcvh9f.fsf@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nkjZt94N27WHoBIIXMYKqC2CU0lzBq1O
X-Proofpoint-ORIG-GUID: nkjZt94N27WHoBIIXMYKqC2CU0lzBq1O
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130151
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/8] Hugetlb: Migrating libhugetlbfs icache-hygiene
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
Thanks for looking at it.

I am also trying to reproduce the same, In the meantime, I have found the
fix commit for this bug: https://lore.kernel.org/all/20051209032051.GA11744@localhost.localdomain/

I will update the tag in this and all tests moving forward,
Pardon me for missing such crucial details.

Thanks
Taurn
On Dec 12 2022, Richard Palethorpe wrote:
> Hello,
> 
> Tarun Sahu <tsahu@linux.ibm.com> writes:
> 
> > Migrating the libhugetlbfs/testcases/icache-hygiene.c test
> >
> > Test Description: Older ppc64 kernels don't properly flush dcache to
> > icache before giving a cleared page to userspace.  With some exceedingly
> > hairy code, this attempts to test for this bug.
> >
> > This test will never trigger (obviously) on machines with coherent
> > icache and dcache (including x86 and POWER5).  On any given run,
> > even on a buggy kernel there's a chance the bug won't trigger -
> > either because we don't get the same physical page back when we
> > remap, or because the icache happens to get flushed in the interim.
> 
> Compiling with Clang 15.0.5 on x86_64 and upstream kernel 6.0.9 in a KVM
> VM the test fails:
> 
> sh-5.2# ./hugemmap15
> [13712.044617] hugemmap15 (2118): drop_caches: 3
> tst_hugepage.c:83: TINFO: 3 hugepage(s) reserved
> tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
> hugemmap15.c:191: TFAIL: icache unclean
> 
> > +
> > +static struct tst_test test = {
> > +	.needs_root = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.needs_hugetlbfs = 1,
> > +	.needs_tmpdir = 1,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = run_test,
> > +	.hugepages = {3, TST_NEEDS},
> > +};
> > -- 
> > 2.31.1
> 
> Again, it would be nice to have the git tag(s) of the fix commit(s) if
> possible.
> 
> -- 
> Thank you,
> Richard.
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
