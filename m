Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89C6C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 14:35:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 287403E5D30
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 16:35:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DD203E28F1
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 16:35:16 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 654F16003C9
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 16:35:15 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669EIRuF1496689
 for <ltp@lists.linux.it>; Thu, 9 Jul 2026 14:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=7aThujR78z3zcriVAgklfo/9zYl9tb
 /0JG6dGKVS0OU=; b=HAWRj3nVkUVhzagHq1bfifNl/vUMyJFC+eG6AJ0M+XGjDy
 pocmKdLDNJwM+H3p8npxdDYC7TUOciNji6OFDapTzgDFcN8VYVZVimI5mshc/oTn
 hIGX5HE7G/TDSmt5OvJ2tPu1SrhmXvPgCQt+Zn17cPhGNGzBA9+Ar1zTUVMwsW8Z
 giKWFvBJRF+vlFXN9bqP4TJcgH3pNm/JH8hdLnOPgUV2s1uuaNDhi3ai0a+J7/QE
 5vxuxEYsfartvHpQTkmGwrYR5BziB4GxIf0HcBbHF5xpb67JrKMjSrKQiG2v0+Xo
 YKzRfYBjT/lMlsresnewBT3qCnmU8WX2yX6vS1LA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt2emb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:35:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EYtK8027236;
 Thu, 9 Jul 2026 14:35:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwdqj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:35:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669EZAWd40239530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 14:35:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69C6D2004B;
 Thu,  9 Jul 2026 14:35:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 563F520043;
 Thu,  9 Jul 2026 14:35:10 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.224.74.129])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  9 Jul 2026 14:35:10 +0000 (GMT)
Date: Thu, 9 Jul 2026 16:35:09 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: linuxtestproject.agent@gmail.com
Message-ID: <ak-xnS4V1vY_fjD6@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260707160024.216347-1-japo@linux.ibm.com>
 <20260707164304.4232-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260707164304.4232-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kAkTJEVLlQOGkopA5I79V4eSfQ2jJZcQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX1d5sNLjhNXab
 fb0DpznKMCUZbSFCZ2sOmggfCly/vTh7es6268vn620w1GPikjs00bSbfqTFMXtotdOLjecCNAi
 nkvxSH1A3DRqiwtQD2WMYRdGbt+fK0A=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4fb1a1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=YYSXbkMydyjiZXrNbMAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: U5T0BWnO3zQV7vEDKurMzOzFyU6hrs6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX7zNo4LVwVj09
 DVl05lFkukEUwEXvdtniyxOGNSKvDpzO+KpT679Ubl5ljLf5E4y2nUq8lEaBiJwBNbRCHZANrJU
 eySrwquazsAkQBNKv3W5kwlP7Zbz2ZtPM4FXthnw3TZtyq803miWwPepedS3EjWKlmND1KZ5+/e
 vn0nSbXI7mk4i11hlsTsrdn297h+V37zO97lRQ25FJDcTDInxe77cShqNo0/8ucGfqC4mI+El1J
 oHmbHoEAnX9HjRPtSBNRnLdVXZSkBaSWltaMb3YIY3UV0cNPxUKFJ14xCZ1vOF6A4bzm0e14icx
 H+jUtyDHIy48MDPCa0bOQ0aquqBNATf4isElWrFGvy3baT8fYW4PHGilqDmbRY8G4WRtIV0dci/
 3WAo5uy+yRFdVdArZpBCIJup3WU4YqqAlSJFmAq6pvt2T7/ljAMrUfz7v4dbAv1X0IrkxvaRMFb
 m2/YFGZtAf3s+Jbx4SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090141
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Add ptrace support for
 CONFIG_PROC_MEM_FORCE_PTRACE=y
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

On Tue, Jul 07, 2026 at 04:43:04PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Jan,
>
> On Tue, 7 Jul 2026 18:00:22 +0200, Jan Polensky wrote:
> > thp04: Add ptrace support for CONFIG_PROC_MEM_FORCE_PTRACE=y
>
> > - Restores lapi/mmap.h for MADV_* fallback definitions
>
> The diff shows lapi/mmap.h was already present in the original file
> and was not removed or re-added by this patch. "Restores" is
> inaccurate here.
>
> > +static void setup_ptrace_tracee(void)
> > +{
> > +	int status;
> > +
> > +	/* Test-loop state is initialized once and read-only afterwards. */
> > +	child = SAFE_MMAP(NULL, sizeof(*child), PROT_READ | PROT_WRITE,
> > +		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > +	memset(child, 0, sizeof(*child));
> > +	child->writefd = -1;
> > +	child->readfd = -1;
> > +
> > +	tracee_pid = SAFE_FORK();
> > +	if (!tracee_pid) {
> > +		tracee_main();
> > +		exit(0);
> > +	}
> > +
> > +	TST_CHECKPOINT_WAIT(0);
> > +
> > +	SAFE_PTRACE(PTRACE_SEIZE, tracee_pid, NULL, NULL);
> > +
> > +	/*
> > +	 * Tracee will run first iteration (madvise + check) and self-stop
> > +	 * with raise(SIGSTOP). Wait for that SIGSTOP - this is iteration 0.
> > +	 */
> > +	SAFE_WAITPID(tracee_pid, &status, 0);
>
> There is a race here. After TST_CHECKPOINT_WAKE(0) the tracee runs the
> for(;;) body immediately and calls raise(SIGSTOP). If that raise()
> fires before PTRACE_SEIZE executes in the parent, the SIGSTOP causes a
> job-control stop (T state), not a ptrace-stop. PTRACE_SEIZE on an
> already-T-stopped process does not generate a new ptrace event.
>
> SAFE_WAITPID(..., 0) without WUNTRACED cannot see a job-control stop,
> so the parent hangs indefinitely.
>
> The comment "Parent will PTRACE_CONT us when ready - no checkpoint
> needed" assumes PTRACE_SEIZE always wins the race, which is not
> guaranteed, especially on a loaded system.
>
> A second checkpoint (wake from parent after PTRACE_SEIZE completes,
> wait in tracee before the first loop iteration) would close the window.
>
> > +/*
> >   * CVE-2017-1000405
> >   *
> > [...]
> > + * Test Modes:
> > + *
> > + * PROC_MEM_ALWAYS: Direct writes to /proc/self/mem ...
>
> The patch modifies this description block. The required opening for an
> LTP high-level description block is /*\ (with a backslash), not /*.
> The block is exported to the test catalog and must use the /*\ form.
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
Send v5 soon.
Thanks

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
