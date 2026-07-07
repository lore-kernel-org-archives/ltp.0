Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46E9C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 15:58:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A1B63D7C3B
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 17:58:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E58283CD5C6
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 17:58:07 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 11AE26008CB
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 17:58:05 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Fmcxf669948; Tue, 7 Jul 2026 15:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=i7qCPcINysHFX4lx0i1EexkGcPMrLj
 JSFzNyvlNSvFk=; b=TJ4BKErAvhi/GESXegWMttY8csXZFn/d0OHiifKGNxJIZe
 ZMzlvTgRiztuG0WRtkxHXkt2ctPRKUiqt6vpVQgyljYhu9AsGyr4c+sj4UNQD1r5
 70VjLs5rEvGlfr4h6ZRh4ETQL9TV4o2aOAiy/Es09QMICiNaL8NwPvCFjW2U1F09
 HYnz0TuSLQGJvB+4Op8OZZIiUjpg0GninSlVdylyA2QiFYkiCeWlOgki/EKtH1ND
 qre12UZ4Qa3MqcdH/TEBSu9Gag0kg1yEKPqgCnx6gsse2yFDW0iBcFqR9e8plYdy
 KDepM0P5BTYBawGV4z2EijhKnNL5sc3E4L2M2i7A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknfuwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 15:58:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667FncZe009005;
 Tue, 7 Jul 2026 15:58:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y36tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 15:58:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667Fw0tD51511578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 15:58:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 563892004B;
 Tue,  7 Jul 2026 15:58:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E21520043;
 Tue,  7 Jul 2026 15:58:00 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.59.117])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  7 Jul 2026 15:58:00 +0000 (GMT)
Date: Tue, 7 Jul 2026 17:57:58 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 linuxtestproject.agent@gmail.com
Message-ID: <ak0iBiwKSAgfA0bE@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260701122826.4115-1-linuxtestproject.agent@gmail.com>
 <6a462831.25509765.22e979.4fe7@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a462831.25509765.22e979.4fe7@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4d220b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=iox4zFpeAAAA:8
 a=W9JIN6utTe397279cxYA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: KtCJgaTRbVg2-on9HNpUmVJLvv31Mwh2
X-Proofpoint-ORIG-GUID: GMyPcLjvsFhh6eFHzkIciDArApPGyHMj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE1NSBTYWx0ZWRfX0rwaOjIOsGP+
 +t3qkxrkRkFMje84WJ5Cigsgo1VVWWgKU3Y31j4K2E6Xqo6m1SV5MXeedfWQ55oYc0DiG0ulXwR
 aAG09a+AWPfgloWtrLw0W3SgZlyFj2k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE1NSBTYWx0ZWRfX/acJZagugtOW
 lxuLRzU3TkYcH/dKuI82dFUcasOgKO/PjgRsVfNlU1zJA1QF8vA/JRSo/5tmvQaWhXMU94801sQ
 rq6MCgMggXTzxORCxJ3gRTnXBtZKg2mfle4yQ16uelNqEhs+eRI7VUlG04rHiwSpNLOOLBA+4Zu
 RsdI+zLBrnbz6cKBtB+xBYY/l9Qp9Z/IAYcOhjVktfFL1R85C8ynyabrCXkYYYSJN51cGio6cby
 4aOJ+H9qmLa+45ZF3JOl9bdUxji2JjXlSof1zUXNQxy1fVOwvwlDMU3f47K44WojotkKZWnEHO1
 zt1KDPvIJZ+uLAPBf0OFlrvSRpA7CFpFdTgPudesCrJ8vEWVKDNuY+BHelwJjIuUG7/MYQOde5p
 na4KsJzqZqFPv3WQGuVzYAtPVU9AboK10dOXCHvUkBHNN5kp9lhCp9zjLlExaPNeKPAHbKgtzKu
 NDdBTAr1WK1xhY/d2lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070155
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Fix PTRACE mode for CONFIG_PROC_MEM_FORCE_PTRACE=y
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

On Thu, Jul 02, 2026 at 08:58:25AM +0000, Andrea Cervesato wrote:
> Hi Jan,
>
> > The patch drops lapi/mmap.h but the test still uses MADV_HUGEPAGE (in
> > alloc_zero_page) and MADV_DONTNEED (multiple call sites). The fallback
> > defines for these constants live in lapi/mmap.h. On toolchains where
> > <sys/mman.h> does not provide them, this will fail to compile.
>
> This is correct. Please always use lapi/mmap.h instead of the
> sys/mman.h. In this way we are sure to fallback to an existing
> value and LTP compiles in any machine that doesn't have those
> definitions.
>
> >
> > > +static void run_proc_mem_ptrace_race(void)
> > > +{
> > > +	/* After 1000 iterations, let tracee exit cleanly */
> > > +	SAFE_PTRACE(PTRACE_CONT, tracee_pid, NULL, NULL);
> > > +	SAFE_WAITPID(tracee_pid, &status, 0);
> >
> > After run_proc_mem_ptrace_race() returns, the tracee has been reaped.
> > If the framework re-invokes run() (e.g. via -i 2), the next call to
> > SAFE_OPEN("/proc/<pid>/mem") will hit ENOENT and abort with TBROK.
> >
> > The PROC_MEM_ALWAYS path survives re-invocation because
> > tst_fzsync_run_a() returns false immediately when runtime expires. The
> > ptrace path could either re-spawn the tracee in run(), or guard with
> > an early return when tracee_pid is no longer alive.
>
> This is also correct. Always run the test with `-i` as well.
> Also, take a look at tst_reap_children(), because it looks like
> we are duplicating the same functionality with SAFE_WAITPID() here.
>
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

Hi Andrea,

thanks, both issues are addressed in the next revision.

Regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
