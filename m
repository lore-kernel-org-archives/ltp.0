Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79164C433FE
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 16:22:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8EBA3CA817
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 18:22:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FA933C01CC
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 18:22:28 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C40282000E7
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 18:22:26 +0200 (CEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QGKuWW001325;
 Wed, 26 Oct 2022 16:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=ZqmJD70W/61DlYYKIx2Xa8ipSqZuJ/GY/lix8c4+cd8=;
 b=jZf5+PdraNdv7Xi8Skk9h2RmFb+olM4iboepWXNIIYisp4N2lCiesp+ewq9jdm+8XiOH
 lp2/fNFwkb0pRwvse7jruMDYDORwp+fdz54jdhvA4vWJgsYdXFuB8L98sP19xY/gU1wV
 YRS3PxJNnfw94WH2eZvjOeJjH99wk18O231M0QIkX0b7LmrtdFmPwlfUfNllOy+9zWri
 ekCBCPUy1R7DtgUPQuMdI1mTuNB4iv8vGrNU/ojbC7a5gkElI3qsFl/RCdzYFG06oroh
 UI0rffEg1Pgk3qAEpWYqch+N8c0nMFJuutXz6S9BNcvz/jwEw5oIn2b/PKc1v3oAdJRI Aw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kf8b900xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Oct 2022 16:22:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29QGLeUe025719;
 Wed, 26 Oct 2022 16:22:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 3kc859ft5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Oct 2022 16:22:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29QGH3K247382986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Oct 2022 16:17:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60D5011C052;
 Wed, 26 Oct 2022 16:22:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34C4211C050;
 Wed, 26 Oct 2022 16:22:16 +0000 (GMT)
Received: from tarunpc (unknown [9.43.25.184])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Oct 2022 16:22:15 +0000 (GMT)
Message-ID: <0dd4161726a3cc1cea80d30ec87c92d9089efe41.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: rpalethorpe@suse.de
Date: Wed, 26 Oct 2022 21:52:14 +0530
In-Reply-To: <877d0oxj0v.fsf@suse.de>
References: <20221019184846.89318-1-tsahu@linux.ibm.com>
 <20221019184846.89318-2-tsahu@linux.ibm.com> <877d0oxj0v.fsf@suse.de>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cKdydE5uMjUxIcjLiE2Z-1_YbW0k4Xd3
X-Proofpoint-GUID: cKdydE5uMjUxIcjLiE2Z-1_YbW0k4Xd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260090
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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
Reply-To: tsahu@linux.ibm.com
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard, 
Thanks for reviewing the patch.

-- skip
> > +static int arch_has_slice_support(void)
> 
> This only appears to be used on __powerpc64__ in next_chunk. So it
> can
> be defined in the ifdef for next_chunk.
> 
> Otherwise we could get unused function warnings and IMO it is more
> readable.

Yeah, I will update it in next version.

> 
> > +{
> > +#ifdef __powerpc64__
> > +	char mmu_type[16];
> > +	FILE *fp;
> > +	int ret;
> > +
> > +	fp = SAFE_POPEN("cat /proc/cpuinfo | grep MMU | awk '{ print
> > $3}'", "r");
> > +	ret = fscanf(fp, "%s", mmu_type);
> > +	pclose(fp);
> > +
> > +	if (ret < 0)
> > +		tst_brk(TBROK, "Failed to determine MMU type");
> > +
> > +	return strcmp(mmu_type, "Hash") == 0;
> > +#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)
> 
> This elif doesn't appear to be applicable.
I missed adding PPC_NO_SEGMENTS cppflags in Makefile
Will update it in next version.

> 
> > +	return 1;
> > +#else
> > +	return 0;
> > +#endif
> > +}
> > +
> > +#ifdef __powerpc64__
> > +static void *next_chunk(void *addr)
> > +{
> > +	if (!arch_has_slice_support())
> > +		return PALIGN(addr,
> > SAFE_READ_MEMINFO("Hugepagesize:")*1024);
> 
> In setup we set hpage_size, but then keep reading it.
Yeah, I missed it, Will update it.
> 
> > +
> > +	if ((unsigned long)addr < 0x100000000UL)
> > +		/* 256M segments below 4G */
> > +		return PALIGN(addr, 0x10000000UL);
> > +	/* 1TB segments above */
> > +	return PALIGN(addr, 0x10000000000UL);
> > +}
> > +#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)
> > +static void *next_chunk(void *addr)
> > +{
> > +	return PALIGN(addr, 0x10000000UL);
> > +}
> > +#elif defined(__ia64__)
> > +static void *next_chunk(void *addr)
> > +{
> > +	return PALIGN(addr, 0x8000000000000000UL);
> > +}
> > +#else
> > +static void *next_chunk(void *addr)
> > +{
> > +	return PALIGN(addr, SAFE_READ_MEMINFO("Hugepagesize:")*1024);
> > +}
> > +#endif
> 
> If these functions are used in later tests I guess they should go in
> tst_hugepages.h
No, These functions are only used in this test.

> 
> > +	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt,
> > getpid());
> > +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> > +
> > +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> > +	SAFE_UNLINK(hfile);
> 
> I'm guessing opening this file and using it with mmap is a very
> common
> pattern. If so, it should be encapsulated in tst_hugepage.c.
> 
Yeah I agree. But the change in tst_hugepage.c will require change in
prexisting hugetlb tests.

> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (fd >= 0)
> > +		SAFE_CLOSE(fd);
> > +	SAFE_UMOUNT(Hopt);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.needs_root = 1,
> > +	.needs_tmpdir = 1,
> > +	.options = (struct tst_option[]) {
> > +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H
> > /var/hugetlbfs"},
> 
> This is a source of confusion. This description suggests we pass in
> an
> existing hugetlb mount. However it's actually where it will be
> mounted.
> 
> Perhaps instead we could use set/getmntent to find an existing
> hugetlb
> mount?  Then if it is not there, try mounting it. This is what we do
> for
> CGroups.
> 
> I'm not sure what difference it makes where the FS is mounted
> anyway. Why is it even an option?

Not sure, If user is ok for using premounted fs without their
permission. So instead of searching, it will mount where user will
explicitly asked for. Or otherwise if not provided, it will mount at
temp location under /tmp.

I had taken this option from hugemmap01 test. Thinking, it might be
to provide user the flexibility incase user doesnt want test to mount
fs at random location by default.

I will change the description to "Provide the location to mount the
hugetlbfs or default '/tmp/xxxxxxx'"

> 
> > +		{"s:", &nr_opt, "Set the number of the been allocated
> > hugepages"},
> > +		{}
> > +	},
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = run_test,
> > +	.hugepages = {1, TST_NEEDS},
> 
> When we set this tst_hugepages.c could fill Hopt (which should be
> something like tst_hugepages_mount) with the location of the mount
> point. It could also open the hfile fd and store it in a static
> variable like tst_hugepage_fd.
Yeah, It will move the repeated actions to single location.

This will
require change in lib/tst_hugepage.c and which will require
change in already existing test under hugetlb/ . Which will be like a
new separate change patch series.

> 
> Also .taint_check should be added here to check for the type of Ooops
> that are caused by this test. This makes debugging easier if the
> kernel
> doesn't kill the test process or freeze immediately.
Ok, Will update it in next version.

> 
> > +};
> > diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> > b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> > index f75109f3e..1cfeca95a 100644
> > --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> > +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> > @@ -20,6 +20,9 @@
> >  #include "old_tmpdir.h"
> >  #include "mem.h"
> >  
> > +#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> > +#define PALIGN(p, a) ((void *)ALIGN((unsigned long)(p), (a)))
> > +
> >  #define SHM_RD	0400
> >  #define SHM_WR	0200
> >  #define SHM_RW	(SHM_RD|SHM_WR)
> > -- 
> > 2.31.1
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
