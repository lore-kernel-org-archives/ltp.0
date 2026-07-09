Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D891C44506
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:07:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6E813E2E13
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 12:07:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8888D3C5691
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:07:12 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8896B1A009B1
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:07:10 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6696IE1W1391076
 for <ltp@lists.linux.it>; Thu, 9 Jul 2026 10:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=nqTn6aXXH8AtKFFQhdN/8f+5bt7V0t
 FxTEV1fE7Nk38=; b=X0iJ+/9647gq3Gm2Nbw3Te1Czte9f90LzgYXtT9AWAAY3G
 gdAwiC2J3G+sfXxibJMdT/CqVU1AlLt0mfJBMSfnxNc5Szw6L2ACLXxyLcputReT
 p0bRi6//hzlgXvUzXinsgywyGRhpQxo5kJOYqZ74bd0MmLesrLEj3Jmq4VKnHo+Q
 sYaH04nUYl60Hrj7c/SwEIkBNGwSTXwzck+Qngf615Hss7d2W/h/2FuKpYrPg8FR
 472Haf3rpGMm7d0GKZKKtWhAc8X+5AKHA5EtSUMv+RgLWK4n6I5UupomCvugdarc
 m+bfDVDUPA1bJOa7m0lKQEPSLjiGhBXz61K3CU9Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp416u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 10:07:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669A4bRb020019;
 Thu, 9 Jul 2026 10:07:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yc9vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 10:07:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669A75bw49676678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 10:07:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4DD020079;
 Thu,  9 Jul 2026 10:07:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C111920077;
 Thu,  9 Jul 2026 10:07:05 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.224.74.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  9 Jul 2026 10:07:05 +0000 (GMT)
Date: Thu, 9 Jul 2026 12:07:04 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: linuxtestproject.agent@gmail.com
Message-ID: <ak9yyGk1aVdy9lqt@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260708133726.223095-1-japo@linux.ibm.com>
 <20260708152634.3782-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260708152634.3782-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4f72cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=-gA7TKofNPK2ekn1Q3QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA5NCBTYWx0ZWRfX1rFDjNL3Uhs9
 o7sWl3KNcEtFuPnuJcKoHq9ez4HAM5WR0KhjyFWQCGqdIuWLeqH3DGBYvFFKZLLZ2GdVfZdvTtB
 FytnFthbz5DbTIC6XTh8lxLrOfRNYJI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA5NCBTYWx0ZWRfX5ofx91rOHTRs
 nEVxR5pCJndoXmEH8/4u3k7L6jaR4Z3QoZ1fzmEmo31HemuFqbSuMkI0KMCBkqvegiCSMJtB24q
 AE0QdEx4aaBON7yheLzzN6yLwVFmEWeu4Gh4esBDzxmTe4vaFTdLl5dIIqyuRr9uqftRbSTNv4j
 98gzjoIK5CPwR1hjn+2ycnhvpcgeGQ/Mh0H8M6hGMPWeRn8eU9B8lmg5AJDzVvrvJfKrRLrgLri
 EBDdWCAS8I0PPQ1S+C5T/ycydC+SsBMofIu7jvWm6/P03JrnR4eXtATFXc8TCCxFE22DoIke5VH
 Ey6YocNNAZ9VyubzGibF2JZfjvO613+XKwMmLAR00MKIeBkugzCxIChWMvDDQOPualkLwenDpBS
 Pm0pBC8eq4MTNTNlU/ySbvDBeRNsDPr8VEfaggw/+HuSqju7T0r84jGRteHSyPJyWWNoG5j/zP3
 qdG4uCFi997ZBiQQ3lg==
X-Proofpoint-ORIG-GUID: MHAtUk_cybi_9Xw87S99QVEFzK5McSCr
X-Proofpoint-GUID: CIsihrr_wcRWu4P7SHcSb4enyUPWlf0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090094
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] kill11: Skip with pipe-based core dump handlers
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

On Wed, Jul 08, 2026 at 03:26:34PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Jan,
>
> On Wed, 08 Jul 2026 15:37:26 +0200, Jan Polensky wrote:
> > kill11: Skip with pipe-based core dump handlers
>
> > +	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%255s", core_pattern);
> > +	if (core_pattern[0] == '|') {
> > +		tst_brk(TCONF,
> > +			"Pipe-based core dumps detected (e.g., systemd-coredump). "
> > +			"Test requires direct filesystem core dumps. "
> > +			"Set kernel.core_pattern to a file path (e.g., /tmp/core.%%p) "
> > +			"or disable systemd-coredump for proper testing.");
> > +	}
>
> The check is in setup(), which aborts all iterations when it triggers.
> The hang described in the commit message can only occur when the child
> receives a signal that actually generates a core dump -- i.e. the cases
> with dumps_core == 1 (SIGQUIT, SIGILL, SIGABRT, SIGBUS, etc.).
>
> For the 12+ cases with dumps_core == 0 (SIGHUP, SIGKILL, SIGTERM,
> SIGPIPE, etc.) the child exits immediately without touching the core
> dump path, so SAFE_WAIT() returns right away and the pipe handler is
> never involved.
>
> Placing the skip in setup() discards over half the test coverage on any
> system running systemd-coredump, with no benefit for those cases.
>
> Would it work to keep the core_pattern detection in setup() (store the
> result in a static bool), then check it per-iteration in verify_kill()
> only when tc->dumps_core is set?
>
>   static bool pipe_based_coredump;
>
>   static void setup(void)
>   {
>       char core_pattern[256];
>       ...
>       SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern",
>                       "%255s", core_pattern);
>       pipe_based_coredump = (core_pattern[0] == '|');
>   }
>
>   static void verify_kill(unsigned int n)
>   {
>       struct tcase *tc = &tcases[n];
>
>       if (tc->dumps_core && pipe_based_coredump) {
>           tst_res(TCONF, "%s: pipe-based core dump handler active",
>                   tst_strsig(tc->sig));
>           return;
>       }
>       ...
>   }
>
> That way the non-core-dumping signal cases still run.
>
> Verdict - Needs revision
>
> ---
> Note:
>
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
>
> Regards,
> LTP AI Reviewer
Good point will send v2 soon.
Thank you!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
