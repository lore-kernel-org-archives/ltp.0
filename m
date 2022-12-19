Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72DEC4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 21:09:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BF8B3CBB17
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 22:09:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9627F3CBABC
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 22:08:48 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 777D21000643
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 22:08:46 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BJKhZJq020073; Mon, 19 Dec 2022 21:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=mXgrjUdNKpz43Gwnm3959Nvdlkj9Me+Rndl2b9QoC5o=;
 b=b5JRGaZVtWrZXRb/HernmkXewidgvvJSV5PUIJ2j43MnX8tv3YmQDBX5kdR0aQHIADXU
 0deLUm9BwfKRcsTl603Obj3bfQhggk9PlYV65Qs2qQZ6TdFsCOTtgBipm+rPuggPH6mm
 etfXpzsJuZs6sn+owDRPkktMKJC8oz4rZsTgj+kGA1FOcTigIFkkH1B+DY3X3b2zlc3v
 wBozuX9PICzw17g39Zkp2zMQJEJL8bEgAStzqDwzb4oCbyzMDDJ1Q6OtjpmVmDvel1N5
 BqS2/ySF7x+AFBCkZb+CLKuihHgdbpsRdioArP2Z8PPflbHd0zVh8VwrJUHuczB1stOy RA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjy85rpja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Dec 2022 21:08:44 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJIfs8k032627;
 Mon, 19 Dec 2022 21:01:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mh6yw27jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Dec 2022 21:01:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BJL1sn023593500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Dec 2022 21:01:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1155520040;
 Mon, 19 Dec 2022 21:01:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3194F20043;
 Mon, 19 Dec 2022 21:01:45 +0000 (GMT)
Received: from tarunpc (unknown [9.43.70.172])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 19 Dec 2022 21:01:43 +0000 (GMT)
Date: Tue, 20 Dec 2022 02:31:30 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20221219205502.x3d4u3pj4ynf6vev@tarunpc>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-5-tsahu@linux.ibm.com>
 <878rjcvh9f.fsf@suse.de>
 <20221213172705.r2kczfotivg4sbck@tarunpc.in.ibm.com>
Content-Disposition: inline
In-Reply-To: <20221213172705.r2kczfotivg4sbck@tarunpc.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lbGO17APhlMnTiDBei6zwh1LqfIRAKGX
X-Proofpoint-ORIG-GUID: lbGO17APhlMnTiDBei6zwh1LqfIRAKGX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190186
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: geetika@linux.ibm.com, aneesh.kumar@linux.ibm.com, ltp@lists.linux.it,
 sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Dec 13 2022, Tarun Sahu wrote:
Hi,

with clang (any version) it even fails on power (with/without VM).
while debugging with lldb, I found clang/llvm used an optmization which
caused goto *p to be ignored and it just jump to jumplabel. Tunrning off
the optimization makes the test work as expected.

I will post the v2 with change in Makefile for this test.

--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -8,4 +8,5 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

+hugemmap15: CFLAGS+=-O0

Thanks
Tarun

> Hi Richard,
> Thanks for looking at it.
> 
> I am also trying to reproduce the same, In the meantime, I have found the
> fix commit for this bug: https://lore.kernel.org/all/20051209032051.GA11744@localhost.localdomain/
> 
> I will update the tag in this and all tests moving forward,
> Pardon me for missing such crucial details.
> 
> Thanks
> Taurn
> On Dec 12 2022, Richard Palethorpe wrote:
> > Hello,
> > 
> > Tarun Sahu <tsahu@linux.ibm.com> writes:
> > 
> > > Migrating the libhugetlbfs/testcases/icache-hygiene.c test
> > >
> > > Test Description: Older ppc64 kernels don't properly flush dcache to
> > > icache before giving a cleared page to userspace.  With some exceedingly
> > > hairy code, this attempts to test for this bug.
> > >
> > > This test will never trigger (obviously) on machines with coherent
> > > icache and dcache (including x86 and POWER5).  On any given run,
> > > even on a buggy kernel there's a chance the bug won't trigger -
> > > either because we don't get the same physical page back when we
> > > remap, or because the icache happens to get flushed in the interim.
> > 
> > Compiling with Clang 15.0.5 on x86_64 and upstream kernel 6.0.9 in a KVM
> > VM the test fails:
> > 
> > sh-5.2# ./hugemmap15
> > [13712.044617] hugemmap15 (2118): drop_caches: 3
> > tst_hugepage.c:83: TINFO: 3 hugepage(s) reserved
> > tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
> > hugemmap15.c:191: TFAIL: icache unclean
> > 
> > > +
> > > +static struct tst_test test = {
> > > +	.needs_root = 1,
> > > +	.mntpoint = MNTPOINT,
> > > +	.needs_hugetlbfs = 1,
> > > +	.needs_tmpdir = 1,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.test_all = run_test,
> > > +	.hugepages = {3, TST_NEEDS},
> > > +};
> > > -- 
> > > 2.31.1
> > 
> > Again, it would be nice to have the git tag(s) of the fix commit(s) if
> > possible.
> > 
> > -- 
> > Thank you,
> > Richard.
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
