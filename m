Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15457C4332F
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 07:02:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8083D3CCF40
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 08:02:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B03E83C7611
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 08:02:42 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3051026B2F3
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 08:02:40 +0100 (CET)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AH70ffL019576; Thu, 17 Nov 2022 07:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=+1f3QXJ32PKHauJQLQJGWzkOEo6apjSpKu0TdYohApo=;
 b=LgDEAcrc1/BPt5kvbeUa1Ah0J/9Mu/YXj0rAgkpFUMnb5QpUADov9Pv5Yu+RyCJW3wSi
 uTc1XFDO15Bq6LFszE3MefgLWqEDRHF+umq96BZBSFO9QNhpoXqpX+UksjTuW2xcKnVe
 tRimBFIVjBdOT7pjsUNA6Us0p9Tq+K571W1is2mEGWxeov/qhL4vS2U1J5vPy1ow8Urm
 5jFz2yf1828hNuAc/4MYEZgzCUzs3879Y6m4V8imSXznXZf5zEOjDkR+9qFJyTa5dbdD
 JfmkQ8/xsxLf+NSSJdaGiot1lyEMm0SwmVP7+PbytVbT0Ch6D/byJVg6sM1s632h34LR Ww== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwf5phy2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Nov 2022 07:02:37 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AH6qBZA005521;
 Thu, 17 Nov 2022 07:02:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06fra.de.ibm.com with ESMTP id 3kt2rj5bne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Nov 2022 07:02:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AH72Wsu3474168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Nov 2022 07:02:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CE1452051;
 Thu, 17 Nov 2022 07:02:32 +0000 (GMT)
Received: from tarunpc (unknown [9.43.22.230])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 491035204E;
 Thu, 17 Nov 2022 07:02:29 +0000 (GMT)
Date: Thu, 17 Nov 2022 12:32:25 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221117070225.rlfwdykdurxgssed@tarunpc>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
 <20221116112516.261535-2-tsahu@linux.ibm.com>
 <Y3T/BmR+XIgWvClD@yuki>
Content-Disposition: inline
In-Reply-To: <Y3T/BmR+XIgWvClD@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hUtFLE9I9OiF7zAI2p9Kovbh8yioDJzA
X-Proofpoint-ORIG-GUID: hUtFLE9I9OiF7zAI2p9Kovbh8yioDJzA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170053
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/7] Hugetlb: Add new argument flags in
 tst_creat_unlinked
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
Thanks for reviewing the patch.
On Nov 16 2022, Cyril Hrubis wrote:
> Hi!
> > Some test requires custom flags for file opened by tst_creat_unlinked
> > along with O_CREAT|O_EXCL|O_RDWR. This patch creates support to pass
> > custom flags in tst_creat_unlinked.
> > 
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> > ---
> >  include/tst_test.h                            |  2 +-
> >  lib/tst_test.c                                | 19 ++++++++++++++-----
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |  2 +-
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  2 +-
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  2 +-
> >  5 files changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index acf2421de..a62515bfe 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -365,7 +365,7 @@ void tst_set_max_runtime(int max_runtime);
> >   * Create and open a random file inside the given dir path.
> >   * It unlinks the file after opening and return file descriptor.
> >   */
> > -int tst_creat_unlinked(const char *path);
> > +int tst_creat_unlinked(const char *path, int flags);
> >  
> >  /*
> >   * Returns path to the test temporary directory in a newly allocated buffer.
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index b225ba082..d17b15ee8 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1027,18 +1027,27 @@ static void prepare_and_mount_hugetlb_fs(void)
> >  	mntpoint_mounted = 1;
> >  }
> >  
> > -int tst_creat_unlinked(const char *path)
> > +int tst_creat_unlinked(const char *path, int flags)
> >  {
> >  	char template[PATH_MAX];
> > +	int len, c, range;
> >  	int fd;
> > +	int start[3] = {'0', 'a', 'A'};
> >  
> >  	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
> >  			path, tid);
> > +	len = strlen(template) - 1;
> > +
> > +	srand(time(NULL));
> > +	while (template[len] == 'X') {
> > +		c = rand() % 3;
> > +		range = start[c] == '0' ? 10 : 26;
> > +		c = start[c] + (rand() % range);
> > +		template[len--] = (char)c;
> > +	}
> >  
> > -	fd = mkstemp(template);
> > -	if (fd < 0)
> > -		tst_brk(TBROK | TERRNO, "mkstemp(%s) failed", template);
> > -
> > +	flags |= O_CREAT|O_EXCL|O_RDWR;
> > +	fd = SAFE_OPEN(template, flags);
> 
> I wonder if it would be easier to add the O_DIRECT flag with F_GETFL and
> F_SETFL fcntl(), but I guess that this is fine as it is.
> 
> The only potential problem I see is that setting the random seed may
> interfere with anything that would print what seed has been used for
> random data in order to be able to reproduce the same random sequence if
> needed. So maybe I wouldn't attempt to set the seed in this function at
> all.
> 
Ok. can remove it.

One more concern, I have, it wont be thread safe. Is it acceptable?
Though, an alternative is to use mkostemp, but it is only defined in
__GNU_SOURCE, defining it for the whole library tst_test.c doesnt seem good.

instead using rand_r will require _thread static seed to make it
thread safe. but doesn't seem to be worth the effort, if we can simply use,
mkostemp or fcntl to set flags manually later.

What do you think?

> >  	SAFE_UNLINK(template);
> >  	return fd;
> >  }
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > index bd0fb440a..3122d5b9d 100644
> > --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > @@ -113,7 +113,7 @@ cleanup:
> >  static void setup(void)
> >  {
> >  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> > -	huge_fd = tst_creat_unlinked(MNTPOINT);
> > +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
> >  }
> >  
> >  static void cleanup(void)
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> > index ce40e7b69..f66b331dc 100644
> > --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> > @@ -118,7 +118,7 @@ static void run_test(unsigned int test_type)
> >  static void setup(void)
> >  {
> >  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> > -	huge_fd = tst_creat_unlinked(MNTPOINT);
> > +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
> >  }
> >  
> >  static void cleanup(void)
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> > index 1008395a4..ceb0f64a1 100644
> > --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> > @@ -60,7 +60,7 @@ static void run_test(void)
> >  static void setup(void)
> >  {
> >  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> > -	huge_fd = tst_creat_unlinked(MNTPOINT);
> > +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
> >  }
> >  
> >  static void cleanup(void)
> > -- 
> > 2.31.1
> > 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
