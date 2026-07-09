Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189C3C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 18:00:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98E873E28CF
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 20:00:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 110EA3E1EBA
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 20:00:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EEC051000486
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 20:00:04 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HmkWP1949216
 for <ltp@lists.linux.it>; Thu, 9 Jul 2026 18:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=RzoprOBRoI/fxxDYR1Uo/OQoAC8zGJ
 moLpQgsXE+GQ4=; b=ShTieijJyy+gM/7m2aAFxmDjhlpmxVgMpJof6QKs/xrHDr
 yyvm7OgSHCYWyPdpipil4Y7Nj3Pm8goNl896X5s1b3IiW2fzSX0IVzAOv25P7rzw
 1dD83qqB9Xnq9iVj55kJqVV2H7SAJ/3yGoSTL8HQJRoo8KrM6DLB1UsAJw5MewC4
 FqkDISHxMeWhatPjM092xvZ93yQQ+Azlpdx743gRAVXUhqMHJFmV5T5JRCz68IcZ
 zbM4W5fIc8Xm5Yn3yoGH+LSXCHhQOfUZ7dQZd+TQ+iaxv1hL9zoHyLAFK8MrmERQ
 82RLVoJxFGXlaJjD2bhQ3qBRZPComd0YOK5300FA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt38na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 18:00:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669HncwU027841;
 Thu, 9 Jul 2026 18:00:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ydym8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 18:00:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669I008C48300420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 18:00:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43F302004D;
 Thu,  9 Jul 2026 18:00:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30BBC2004E;
 Thu,  9 Jul 2026 18:00:00 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.224.74.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  9 Jul 2026 18:00:00 +0000 (GMT)
Date: Thu, 9 Jul 2026 19:59:58 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: linuxtestproject.agent@gmail.com
Message-ID: <ak_hnlOxRuNKpapG@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260709143551.147268-1-japo@linux.ibm.com>
 <20260709163754.4041-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709163754.4041-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6YDMktgdWKjzwHi7iXL7YwWNWbiFXHxQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfX/zC0687nncE8
 i2XjVH0ct63+EEgoiC15yPHYqpqB/M8VEgvE8J3ocjCfEWowZEznZR4oRof9zORRI5Y6l0ULpKL
 1T2b1ULwxrroau0PB645XvPf7ida168=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4fe1a3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=oMCQ3PywB9bRQt1jbQkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ykCCUnv0wFV1ZXu90dUaTypkmr0PYH3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfX87Nt1s7JX5Hs
 Hp2Hlg8Wb6jnlcHQPdBbLczN11p+DnFEc/pIVSC/6ly2Rre3p6PKX5TbQiQf7KOWI+zxJHNpSiD
 AkMoxTp9zd3Fy4fZ4WwwslX+I9ANgMVCm+Rq0+6Wha8MOip5Juw+67r3Et9kZ0M5SXy6WwnHNtY
 CSBUaj3nSFSdYUG4T454tjOsT+nwg7rCXFppc5dWvtot8yLfnDDlJv/iXCtf+7na3wrgPVDHUr/
 Cb96YT67PEICxbyH1VeIh4sMAfgiZn5poPOrz7kbG5UWd32BAjfdf5m4pM6hyphDwqOL5RgrJ2d
 a7YtKCz5GNj7Jm7E94baCk8tQYBHqYofUQz2ufy15ar6nbLQxJnbv5eMLrM2a2UQ8pUyYPKdhEr
 aafHUjNqgvTkUK3nmUMI7R02lZx1R5iUMqhWezcgzR8zpC5Gp8pcX1vvuv2oUanx4qnxUEuXyTT
 ywbRMveqMHhIA3+odHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090175
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Add ptrace mode and fix tracee stop synchronization
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

On Thu, Jul 09, 2026 at 04:37:54PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Jan,
>
> On July 09, 2026, Jan Polensky wrote:
> > thp04: Add ptrace mode and fix tracee stop synchronization
>
> > +	effective_mode = user_mode;
> > +
> > +	/* Probe direct /proc/self/mem writes only if not explicitly set to ptrace */
> > +	if (!explicit_mode || user_mode == PROC_MEM_ALWAYS) {
> > +		...
> > +		effective_mode = PROC_MEM_PTRACE;
> > +	}
> > +
> > +	/* Ptrace mode: tracee will be spawned in run() for each iteration */
> > +	if (effective_mode == PROC_MEM_PTRACE)
> > +		return;
> > +
> > +	tst_brk(TCONF, "Writes to /proc/self/mem disabled in kernel policy");
>
> The final tst_brk() appears unreachable. Every code path through setup()
> either returns or calls tst_brk() before reaching this line:
>
> - Probe succeeds (PROC_MEM_ALWAYS path): early return inside the block.
> - Probe fails with non-EIO: tst_brk(TBROK) inside the block.
> - Probe fails with EIO and explicit_mode && user_mode==PROC_MEM_ALWAYS:
>   tst_brk(TCONF) inside the block.
> - Probe fails with EIO otherwise: effective_mode is set to PROC_MEM_PTRACE
>   inside the block, then the "if (PROC_MEM_PTRACE) return" fires.
> - Explicit ptrace mode (block skipped): effective_mode==PROC_MEM_PTRACE
>   was set before the block, so "if (PROC_MEM_PTRACE) return" fires.
> - Explicit never mode: tst_brk(TCONF, "...on kernel cmdline") fires
>   inside the params[0].found block; execution does not continue.
>
> Is there a case this was intended to handle that is now missing?
>
> > +	for (i = 0; i < PTRACE_TEST_ITERATIONS; i++) {
> > +		...
> > +		/* Wait for tracee to stop itself with raise(SIGSTOP) */
> > +		SAFE_WAITPID(tracee_pid, &status, 0);
> > +
> > +		if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGSTOP)
> > +			tst_brk(TBROK, "Tracee did not stop with SIGSTOP: %s",
> > +				tst_strstatus(status));
> > +	}
>
> When the tracee detects page pollution it calls:
>   tst_res(TFAIL, "Huge zero page was polluted");
>   child_cleanup();
>   exit(1);
>
> The SAFE_WAITPID above then returns with WIFEXITED(status)=true, which
> triggers tst_brk(TBROK, "Tracee did not stop with SIGSTOP: exited, status=1").
>
> The test output becomes:
>   TFAIL: Huge zero page was polluted
>   TBROK: Tracee did not stop with SIGSTOP: exited, status=1
>
> The TFAIL is propagated correctly via the LTP result mechanism.
> However, the TBROK message "Tracee did not stop with SIGSTOP" describes
> an infrastructure anomaly rather than the actual failure (page pollution).
> Would it be clearer to check WIFEXITED explicitly and omit the TBROK when
> the tracee has already reported a result?
>
> Verdict - Needs revision
>
> Pre-existing issues:
>
> thread_run_always(), line visible in context (unchanged from original):
>   /* Wait for dirty page handling before next madvise() */
>   usleep(10);
> This is sleep-based synchronization. It was present before this patch and
> is not introduced here, but worth noting for a follow-up cleanup.
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
Prepare v6.
Thanks

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
