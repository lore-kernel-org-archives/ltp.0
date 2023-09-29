Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ADEE743FD
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 08:50:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 439493CE0FA
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 10:50:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 953713C993B
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 10:50:17 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 74141601A63
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 10:50:15 +0200 (CEST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T8C1nd031547; Fri, 29 Sep 2023 08:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qG1Zd/qyVTAWVCgQ8/UBp92ZtlOMrBiJK2c8rf2cGBE=;
 b=HXfrYtHRmHlAeUK9M6c3JeO3IcquzqgjNLsadNChq3eJhKCx7Or45EIx5j+9EJrrLZSd
 5bF7CNDnc/dZ9gDmgY3dOM2CT9To+PKbo6sVxs2gglylfaFcKGbVR2JycWTV7aNsWrQj
 1nFgtTt7Pea74je0JXXpKda22FWeOmUyj+2W6TRNLiMnYBVOTNJ/URdbxTwXV75J54nM
 9h2etite69fgG63ePfXg9lLG68vKCNmf8htGGF4dMzVGr0HHxRgFPHfUZvKMIDoPZuVk
 RoitdkucxIf/KuWKpYhehZaY1KWpnmDDANogi6vTZX0nWWjOeVI78KxXB8OogfdSyv8M RQ== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdrc6vsrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 08:50:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T85xmm030719; Fri, 29 Sep 2023 08:50:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjkk0k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 08:50:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38T8oAtQ43843908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Sep 2023 08:50:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46E4120049;
 Fri, 29 Sep 2023 08:50:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBA6B20040;
 Fri, 29 Sep 2023 08:50:07 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com (unknown
 [9.43.62.110]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 29 Sep 2023 08:50:07 +0000 (GMT)
Message-ID: <ea7ce37d732aac43fb43665cfbca8723ab8fcb6a.camel@linux.ibm.com>
From: Shirisha ganta <shirisha@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 29 Sep 2023 14:20:05 +0530
In-Reply-To: <ZPsQbSsR1Y-zJBVd@yuki>
References: <20230908103921.511595-1-shirisha@linux.ibm.com>
 <ZPsQbSsR1Y-zJBVd@yuki>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TyjdMGm7Wfm_Kc1mVjOr4ewm_eGB6UaK
X-Proofpoint-ORIG-GUID: TyjdMGm7Wfm_Kc1mVjOr4ewm_eGB6UaK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290073
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
 libhugetlbfs/testcases/truncate.c test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 2023-09-08 at 14:15 +0200, Cyril Hrubis wrote:
> Hi!
> > +/*\
> > + * [Description]
> > + *
> > + * Test Name: truncate
> > + * Test case is used to verify the correct functionality
> > + * and compatibility of the library with the "truncate" system
> > call when
> > + * operating on files residing in a mounted huge page filesystem.
> > + */
> > +
> > +#include "hugetlb.h"
> > +
> > +#define RANDOM_CONSTANT	0x1234ABCD
>              ^
> 	     THis is not used at all.
Will take care of this in v3.
> 
> > +#define MNTPOINT "hugetlbfs/"
> > +long hpage_size;
> > +int fd;
> 
> These two should be static.
Will take care of this in v3.
> 
> > +
> > +
> > +static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
> > +{
> > +	tst_res(TPASS, "Test Passed");
> > +	exit(0);
> 
> It's not safe to call exit(0) from a signal handler.
> 
> What should be done instead is to:
> 
> - add global static volatile int variable
> - reset it before we attempt to access the truncated memory
> - set it in the signal handler
> - print TPASS/TFAIL based on the value of the variable in the
> run_test()
>   function
> 
Will take care of this in v3.
> > +}
> > +
> > +static void run_test(void)
> > +{
> > +	void *p;
> > +	volatile unsigned int *q;
>          ^
> 	I do not think that this has to be volatile.
> 
> 	All in all this can be just:
> 
> 	unsigned int *p;
> 
> 	...
> 
> 	p = SAFE_MMAP();
> 
> 	...
> 
> 	*p = 0;

This has to be volatile. The test logic is hunting for a bug
that changes the value of q.
> 
> > +	struct sigaction my_sigaction;
> > +	my_sigaction.sa_handler = sigbus_handler;
> > +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE,
> > MAP_SHARED,
> > +			fd, 0);
> > +	if (p == MAP_FAILED)
> > +		tst_res(TFAIL, "mmap failed..!!");
> 
> SAFE_MMAP() cannot fail, it does exit the test with a failure if the
> it
> fails to map the memory.

Will take care of this in v3.
> 
> > +	q = p;
> > +	*q = 0;
> > +	SAFE_SIGACTION(SIGBUS, &my_sigaction, NULL);
> 
> I guess that we can set up the handler in the setup instead.

Will take care of this in v3.
> 
> > +	SAFE_FTRUNCATE(fd, 0);
> > +	*q;
> > +        tst_res(TFAIL, "Didn't SIGBUS");
> 
> And we should SAFE_UNMAP() the memory here.

Sure will take care of this in v3.
> 
> Also does the test work with -i 2 ?
The new Version ie., v3 works
> 
> > +}
> > +
> > +
> > +void setup(void)
> > +{
> > +	hpage_size = tst_get_hugepage_size();
> > +    	fd = tst_creat_unlinked(MNTPOINT, 0);
>    ^
>    Wrong indentation, please make sure to run 'make check' and fix
> all
>    the reported problems.

Done in v3.
> 
> > +}
> > +
> > +void cleanup(void)
> > +{
> > +    	if (fd > 0)
> > +	    SAFE_CLOSE(fd);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.needs_root = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.needs_hugetlbfs = 1,
> > +	.needs_tmpdir = 1,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = run_test,
> > +	.hugepages = {1, TST_NEEDS},
> > +};
> > -- 
> > 2.39.3
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
