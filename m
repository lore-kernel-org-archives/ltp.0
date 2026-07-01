Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA99C43327
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 10:28:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0388D3E9B59
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 12:28:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 841C73E4A66
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 12:27:48 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4D662005F9
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 12:27:47 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661AIGXE609003 for <ltp@lists.linux.it>; Wed, 1 Jul 2026 10:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=RsTo48O8b/OWBAF/2StAc98UsYaauT
 KkES2OX5mi0uk=; b=KvaLmPwJGm13h/ZqSokFxBgFyj//JIFxou4l1wN1bOmvIq
 vouG9S5svAd+2rLHrnlx5vk1nxi8hb/aOaUdeClOpE8hLJHgyDJKlokLYzAG2iP5
 lOuTRwSjsEieYjPsYi2jq/82iQsJlcOvhLx6ZDpyhwsyY2+nb6FYRgFKjSTVOOdw
 cb/JpAg/2dNMOxdGX4GlonpwzkKOPAOXISU4W4kc4vi20KbGvVyCo/TcgZu5HqMp
 TZ2XV9sd+H+Kf93uOzqroDQlexqTIH9+idy2A1gCOpGI73Lf6PcXpwSHVJxEfYyU
 Gac2z8cFWDdpEjaxFfc0F+hjdEDsn4CHHsxyp8kQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe3xs1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 10:27:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661AJtgr006749;
 Wed, 1 Jul 2026 10:27:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gep2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 10:27:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661ARgo610355144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 10:27:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EF422004E;
 Wed,  1 Jul 2026 10:27:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6EF32005A;
 Wed,  1 Jul 2026 10:27:41 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.1.111]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  1 Jul 2026 10:27:41 +0000 (GMT)
Date: Wed, 1 Jul 2026 12:27:40 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: linuxtestproject.agent@gmail.com
Message-ID: <akTrnHXSL-qXlMmF@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260612171712.324175-1-japo@linux.ibm.com>
 <20260612192142.4221-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260612192142.4221-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 2TfQvbwUfe_XDjGziAc7a0zNabPJYLhG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEwNyBTYWx0ZWRfX6S95SkYRWeyi
 M2e9QtwB2ChMUIfmkQFYemf6PT3qnvj6HQCjB5e7YVKnBiy3NA4lCrKbapmAIIx2eJ6pLexTqLm
 P6g8wXBxZvNxgq4moDUfHKvtZdeQi7M=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44eba1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=US0E_hjg1DHf3IiVEvMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEwNyBTYWx0ZWRfX5dXD3ZYF1Q3k
 AGeBrVqBKa5qJxA4gg0jAagpLpKL0l2OnHy2um+AmxBikR6sWr5yFFTNUPMEzkOd7Fm8THwaRbV
 lQbr6KJSDr6IDT6W9BKr0D4bN3igqpDF12LxqUlR+SQynQKdlOFp4y6SwZR5TDPog/HQbI3KfUI
 Z7eTqY8U+QC0d2Z1gdpiS/Nh6BhcWheBEVdGiondeqvIY5rb5eForb92KpfDcfjZfu/3f1s4GWW
 hT7UcfSnC5AHF8ZBbJlfYqt1ExmDZsXUfpjYdkAJMnmeg8UgOXsR53jW0QQ4CkPfWNmllOD5H+j
 UPv1JrK8gVWny2x2ZFCuuxvNq7co+dZAtJqRPAMUlzN+rNBsz3yCtW0nbU9Rez0h+VwwNicViZA
 dmjXQpKCXWY8/bcDg6gAwdoBUhDo4n7I6IAZrTmx8Epdgvbe6ueaA7hIxzCZmFwqnpMEYMJkUSr
 CuYfT2Aof5Ud8+y2T/g==
X-Proofpoint-ORIG-GUID: w7iynfe7UW_tplqu53w-DVRje4Ibt8pR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010107
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

On Fri, Jun 12, 2026 at 07:21:42PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Jan,
>
> On Fri, 12 Jun 2026 19:17:07 +0200, Jan Polensky wrote:
> > thp04: Fix PTRACE mode for CONFIG_PROC_MEM_FORCE_PTRACE=y
>
> > -	fzsync_pair.exec_loops = 100000;
> > -	tst_fzsync_pair_init(&fzsync_pair);
> > +	child->readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
> > +	child->fzsync_pair.exec_loops = 1000;
> > +	tst_fzsync_pair_init(&child->fzsync_pair);
>
> > +	/* In PROC_MEM_ALWAYS mode, child does writes itself */
> > +	if (proc_mem_mode == PROC_MEM_ALWAYS) {
> > +
> > +		/* Simplified test loop without thread */
> > +		for (i = 0; i < 1000; i++) {
> > +			/* Write via /proc/self/mem */
> > +			SAFE_LSEEK(child->writefd, (off_t)child->write_ptr, SEEK_SET);
> > +			SAFE_WRITE(SAFE_WRITE_ALL, child->writefd, &c, sizeof(int));
> > +
> > +			/* Call madvise on write page */
> > +			madvise(child->write_thp, child->thp_size, MADV_DONTNEED);
> > +
> > +			/* Call madvise on read page */
> > +			madvise(child->read_thp, child->thp_size, MADV_DONTNEED);
> > +
> > +			/* Check if read page was polluted */
> > +			if (*child->read_ptr != 0) {
> > +				tst_res(TFAIL, "Huge zero page was polluted");
> > +				return;
> > +			}
> > +
> > +			usleep(100);
> > +		}
>
> The original test used tst_fzsync to race the /proc/self/mem write
> against madvise(MADV_DONTNEED) in a separate thread. That race is
> the mechanism that triggers CVE-2017-1000405: the kernel must
> handle the COW fault concurrently with page reclaim to corrupt
> the huge zero page.
>
> This replacement runs write, madvise, and check sequentially in a
> single thread with no concurrency. The vulnerability cannot be
> triggered without the race, so the test becomes a no-op for
> detecting the bug in PROC_MEM_ALWAYS mode (the default on most
> systems).
>
> The fzsync_pair is still initialized and cleaned up but never
> actually used for racing (no tst_fzsync_run_a/b calls), and
> readfd is opened but never read from. These are dead remnants of
> the removed race mechanism.
>
> Could the fuzzy sync race be preserved for the PROC_MEM_ALWAYS
> path while adding the new write-stop-continue cycle only for the
> PROC_MEM_PTRACE path?
>
> > +	proc_mem_mode = PROC_MEM_ALWAYS;
> > +	child_setup();
> > +
> > +	TEST(lseek(child->writefd, (off_t)child->write_ptr, SEEK_SET));
> > +	if (TST_RET == -1)
> > +		tst_brk(TBROK | TTERRNO, "lseek on /proc/self/mem failed");
> > +
> > +	TEST(write(child->writefd, &test_val, sizeof(test_val)));
> > +
> > +	if (TST_RET == sizeof(test_val)) {
> > +		proc_mem_mode = PROC_MEM_ALWAYS;
> > +		return;
> > +	}
> > +
> > +	if (TST_RET == -1 && TST_ERR != EIO)
> > +		tst_brk(TBROK | TTERRNO, "test write to /proc/self/mem failed");
> > +
> > +	/* /proc/self/mem write failed, cleanup and try ptrace mode */
> > +	child_cleanup();
> > +	SAFE_MUNMAP(child, sizeof(*child));
> > +	child = NULL;
> > +
> > +	if (explicit_mode && proc_mem_mode == PROC_MEM_ALWAYS)
> > +		tst_brk(TCONF,
> > +			"Writes to /proc/self/mem disabled despite always mode");
>
> The unconditional assignment `proc_mem_mode = PROC_MEM_ALWAYS`
> before the probe destroys the value parsed from the kernel command
> line. When the user explicitly sets proc_mem.force_override=ptrace,
> this sequence occurs:
>
>   1. Kernel cmdline parsing sets proc_mem_mode = PROC_MEM_PTRACE
>      and explicit_mode = 1.
>   2. Line 294 overwrites proc_mem_mode = PROC_MEM_ALWAYS.
>   3. The probe write to /proc/self/mem fails (expected in ptrace
>      mode).
>   4. The check `explicit_mode && proc_mem_mode == PROC_MEM_ALWAYS`
>      evaluates to true because the overwrite at step 2 lost the
>      original choice.
>   5. The test exits with TCONF "disabled despite always mode"
>      instead of falling through to the ptrace path.
>
> The user's explicit ptrace choice is silently discarded. One fix
> would be to save the parsed mode in a separate variable (e.g.
> `user_mode`) before the probe and test that at line 316 instead
> of proc_mem_mode.
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
Hi,

thanks for the review.
Both issues have already been addressed in v3. I'll send the updated
version shortly.

Thanks,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
